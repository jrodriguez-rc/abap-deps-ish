FUNCTION ishmed_vm_view_change.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"     VALUE(I_VIEW) TYPE  NWVIEW OPTIONAL
*"     VALUE(I_VCODE) TYPE  ISH_VCODE DEFAULT 'INS'
*"     VALUE(I_PLACE_ZUO) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_CALLER) TYPE  SY-REPID
*"     VALUE(I_CHK_BUFFER) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_SAP_STANDARD) TYPE  ISH_ON_OFF DEFAULT ' '
*"  EXPORTING
*"     VALUE(E_RC) LIKE  SY-SUBRC
*"     VALUE(E_VIEWVAR) LIKE  RNVIEWVAR STRUCTURE  RNVIEWVAR
*"     VALUE(E_VIEWTXT) LIKE  NWVIEWT-TXT
*"  TABLES
*"      T_NWPVZ_CHK STRUCTURE  V_NWPVZ OPTIONAL
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: l_view             TYPE nwview,                     "#EC NEEDED
        l_nwpvz_chk        LIKE v_nwpvz,
        l_idx              LIKE sy-tabix,
        lt_messages        LIKE TABLE OF bapiret2,
        l_already          LIKE off,                        "#EC NEEDED
        l_viewspec_tab     TYPE lvc_tname,
        l_viewspec_dummy   TYPE lvc_tname,
        l_func_dummy       TYPE ish_fbname,
        l_tmp_viewid       TYPE nwview-viewid.              "#EC NEEDED
  DATA l_tab_checked_v   TYPE string.  " TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) FIX

  CLEAR:   t_messages, lt_messages.
  REFRESH: t_messages, lt_messages.

  CLEAR: e_rc, e_viewvar, e_viewtxt.
  CLEAR: g_place, g_view, g_vcode, g_vcode_txt, g_vcode_spec,
         g_save_ok_code, g_viewvar_old, g_v_nwview, g_viewvar,
         g_view_txt, gs_refresh_old, gs_refresh.

* Globale Daten
  g_place      = i_place.
  g_view       = i_view.
  g_vcode      = i_vcode.
  g_place_zuo  = i_place_zuo.
  g_chk_buffer = i_chk_buffer.

  gt_nwpvz_chk[] = t_nwpvz_chk[].

* Diese Funktion ist nur für den bestimmte Arbeitsumfeldtypen gedacht,
* da zu den Sichten die speziellen Sichttabellen (NWVIEW_00x) einen
* bestimmten Aufbau haben müssen
  IF g_place-wplacetype <> '001'.
    e_rc = 1.                                    " Workplace only !
    EXIT.
  ENDIF.
* ID 5683: Arbeitsumfeld-ID kann bei neuem Arbeitsumfeld hier leer sein!
*  if g_place-wplaceid is initial.
*    e_rc = 1.
*    exit.
*  endif.

  CALL FUNCTION 'MESSAGES_INITIALIZE'.

* Prüfen des Verarbeitungscodes
  IF g_vcode <> g_vcode_insert  AND
     g_vcode <> g_vcode_update  AND
     g_vcode <> g_vcode_display.
    g_vcode = g_vcode_display.
  ENDIF.

* Prüfen, ob Sicht für INSERT geeignet ist
  IF g_vcode = g_vcode_insert AND NOT g_view-viewid IS INITIAL.
    SELECT SINGLE * FROM nwview INTO l_view
           WHERE  viewtype  = g_view-viewtype
           AND    viewid    = g_view-viewid.
    IF sy-subrc = 0.
      g_vcode = g_vcode_update.
    ENDIF.
  ENDIF.

  g_vcode_txt  = g_vcode.
  g_vcode_spec = g_vcode.

* Prüfen, ob Sicht für UPDATE oder DISPLAY geeignet ist
  IF g_vcode = g_vcode_update OR g_vcode = g_vcode_display.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid    = g_view-viewid
        i_viewtype  = g_view-viewtype
        i_mode      = 'L'
        i_caller    = 'LN1VIEWU01'
        i_placeid   = g_place-wplaceid
        i_placetype = g_place-wplacetype
      IMPORTING
        e_rc        = e_rc
        e_view      = g_v_nwview
        e_viewvar   = g_viewvar
        e_refresh   = gs_refresh
      TABLES
        t_messages  = lt_messages.
    IF e_rc <> 0.
      t_messages[] = lt_messages[].
      EXIT.
    ELSE.
      SELECT SINGLE txt FROM nwviewt INTO g_view_txt
             WHERE  viewtype  = g_view-viewtype
             AND    viewid    = g_view-viewid
             AND    spras     = sy-langu.
      IF sy-subrc <> 0.
        g_vcode_txt = g_vcode_insert.
      ENDIF.
      CLEAR l_viewspec_tab.
*     Varianten aus speziellen Tabellen lesen (ID 18129)
      PERFORM get_view_specific IN PROGRAM sapln1workplace
                                USING      g_view-viewtype
                                CHANGING   l_viewspec_tab
                                           l_viewspec_dummy
                                           l_func_dummy.
      IF l_viewspec_tab IS INITIAL.
        e_rc = 1.
        EXIT.
      ENDIF.

      " TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) FIX Start
      TRY.
          cl_abap_dyn_prg=>check_table_name_str(
                  EXPORTING
                    val               = l_viewspec_tab    " Input that shall be checked
                    packages          = 'IS-HMED,IS-H'    " Package to which the table shall belong
                    incl_sub_packages = abap_true
                  RECEIVING
                    val_str           = l_tab_checked_v    " Same as the input
                ).
        CATCH cx_abap_not_a_table.
          MESSAGE a001(n1sec).
*   SQL-Befehlsinjektion - interner Fehler
        CATCH cx_abap_not_in_package.
          TRY.
              DATA lt_whitelist TYPE string_hashed_table.

              cl_ishmed_sec_utl=>get_db_whitelist_4_nwview(
                IMPORTING
                  et_whitelist = lt_whitelist    " Positiv-Liste aller DB-Tabellen kund. Sichttypen
              ).

              cl_abap_dyn_prg=>check_whitelist_tab(
                EXPORTING
                  val                      = l_viewspec_tab
                  whitelist                = lt_whitelist
                RECEIVING
                  val_str                  = l_tab_checked_v    " Same as the input
              ).
            CATCH cx_abap_not_in_whitelist.    "
              MESSAGE a001(n1sec).
*   SQL-Befehlsinjektion - interner Fehler
          ENDTRY.
      ENDTRY.

      SELECT SINGLE viewid FROM (l_tab_checked_v) INTO l_tmp_viewid
             WHERE  viewtype  = g_view-viewtype
             AND    viewid    = g_view-viewid.
" TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) End
      IF sy-subrc <> 0.
        g_vcode_spec = g_vcode_insert.
      ENDIF.
    ENDIF.
  ELSE.
    MOVE-CORRESPONDING g_view TO g_v_nwview.                "#EC ENHOK
    MOVE-CORRESPONDING g_view TO g_viewvar.                 "#EC ENHOK
  ENDIF.

  g_viewvar_old  = g_viewvar.
  gs_refresh_old = gs_refresh.
  g_view_txt_old = g_view_txt.

* ID 13398: viewtype 014 has special layouts (presentation variants)
  CLEAR: g_placetype_pg, g_placeid_pg.
  IF g_view-viewtype = '014' AND
     ( g_vcode = g_vcode_update OR g_vcode = g_vcode_display ).
    SELECT SINGLE nwplacetype_pg nwplaceid_pg FROM nwview_014
           INTO (g_placetype_pg, g_placeid_pg)
           WHERE  viewtype  = g_view-viewtype
           AND    viewid    = g_view-viewid.
    g_placetype_pg_old = g_placetype_pg.
    g_placeid_pg_old   = g_placeid_pg.
  ENDIF.

* START MED-33470 HP 2008/11/13
  IF g_view-viewtype = '018' AND
  ( g_vcode = g_vcode_update OR g_vcode = g_vcode_display ).
    SELECT SINGLE nwplacetype_pg nwplaceid_pg FROM nwview_018
            INTO (g_placetype_pg, g_placeid_pg)
            WHERE viewtype  = g_view-viewtype
              AND viewid    = g_view-viewid.
    g_placetype_pg_old = g_placetype_pg.
    g_placeid_pg_old   = g_placeid_pg.
  ENDIF.
*END MED-33470

  g_first_time_100     = on.
*  g_first_time_warning = on.

  CLEAR: g_view_sap_std, g_view_cst_std.
* ID 7947: SAP-Standard-Arbeitsumfeld anlegen
  IF g_vcode = g_vcode_insert AND i_sap_standard = on.
    g_view_sap_std = on.
  ENDIF.

* System bestimmen - SAP oder Kunde (und in globale Variable stellen)
  PERFORM read_system.

* Lesen IS-H*MED-Kennzeichen
  PERFORM check_ishmed CHANGING g_ishmed_used.

* Popup 'Sicht pflegen' aufrufen
  IF g_place_zuo = on AND NOT g_place-wplaceid IS INITIAL.
    CALL SCREEN 100 STARTING AT 28 5 ENDING AT 97 18.
  ELSE.
    CALL SCREEN 100 STARTING AT 28 7 ENDING AT 97 19.
  ENDIF.

* Falls gewünscht, soll die Sicht dem Arbeitsumfeld zugeordnet werden
  IF g_place_zuo = on AND NOT g_place-wplaceid IS INITIAL AND
     i_chk_buffer = off.
    l_already = off.
    IF g_save_ok_code = 'SAVE'.
      CALL FUNCTION 'ISHMED_VM_VIEW_WPLACE_ZUO'
        EXPORTING
          i_place    = g_place
          i_view     = g_view
          i_view_txt = g_zuo_txt
          i_vdefault = g_vdefault
          i_sortid   = g_sortid
          i_replace  = on
          i_caller   = 'LN1VIEWU01'
        IMPORTING
          e_already  = l_already.
    ELSEIF g_save_ok_code = 'DELE'.
*     Puffer mit den Arbeitsumfeld/Sicht-Daten des Benutzers aktual.
      PERFORM refresh_personal_buffer USING sy-uname g_place.
    ENDIF.
  ENDIF.

* Puffer mit den Sicht/Varianten-Daten aktualisieren
* aber nur beim Insert, da beim Update die jeweiligen Bausteine für
* das Ändern von Selektions-, Anzeige- und Funktionsvariante den
* Puffer bereits angepaßt haben
* und außerdem gäbe es sonst bei der Selektion ein Problem:
* es ginge nämlich sonst eine ev. temporär eingestellte Selektion
* verloren (wenn z.B. keine Selektionsvariante zur Sicht gespeichert ist
* kommt sonst nochmals das Popup 'Sicht einstellen' hoch)
  IF g_save_ok_code = 'SAVE' AND g_vcode = g_vcode_insert.
    PERFORM refresh_view_buffer USING g_place g_view.
  ENDIF.

* Geänderte Zuordnungsattribute zurückliefern
  IF g_chk_buffer = on AND g_save_ok_code = 'SAVE'.
    READ TABLE t_nwpvz_chk INTO l_nwpvz_chk WITH KEY
               wplacetype = g_place-wplacetype
               wplaceid   = g_place-wplaceid
               viewtype   = g_view-viewtype
               viewid     = g_view-viewid.
    IF sy-subrc = 0.
      l_idx = sy-tabix.
      l_nwpvz_chk-vdefault = g_vdefault.
      l_nwpvz_chk-sortid   = g_sortid.
      l_nwpvz_chk-txt      = g_zuo_txt.
      MODIFY t_nwpvz_chk FROM l_nwpvz_chk INDEX l_idx
                         TRANSPORTING sortid vdefault txt.
    ENDIF.
  ENDIF.

* Angelegte/geänderte Sicht mit Varianten zurückliefern
  IF g_save_ok_code = 'SAVE'.
    e_viewvar = g_viewvar.
    e_viewtxt = g_view_txt.
  ELSEIF g_save_ok_code = 'ECAN'.
    e_rc = 2.                                    " Cancel
  ELSEIF g_save_ok_code = 'DELE'.
    e_rc = 3.                                    " Delete
  ENDIF.

ENDFUNCTION.
