FUNCTION ishmed_vm_view_delete.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"     VALUE(I_VIEW) TYPE  NWVIEW
*"     VALUE(I_POPUP) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_BUFFER) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_CALLER) TYPE  SY-REPID
*"  EXPORTING
*"     VALUE(E_RC) LIKE  SY-SUBRC
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: l_wa_msg           LIKE bapiret2,
        l_popup            LIKE off,
        l_del_zuo_only     LIKE off,
*        l_del_ok           LIKE off,
        l_rc               LIKE sy-subrc,
        l_v_nwview         LIKE v_nwview,
        l_view             LIKE nwview,
        l_viewvar          LIKE rnviewvar,
        lt_nwview          LIKE TABLE OF vnwview,
        lt_o_nwview        LIKE TABLE OF vnwview,
        l_nwview           LIKE vnwview,
        lt_nwviewt         LIKE TABLE OF vnwviewt,
        lt_o_nwviewt       LIKE TABLE OF vnwviewt,
        l_nwviewt          LIKE vnwviewt,
        lt_nwpvz           LIKE TABLE OF vnwpvz,
        lt_o_nwpvz         LIKE TABLE OF vnwpvz,
        l_nwpvz            LIKE vnwpvz,
        lt_nwpvzt          LIKE TABLE OF vnwpvzt,
        lt_o_nwpvzt        LIKE TABLE OF vnwpvzt,
        l_nwpvzt           LIKE vnwpvzt,
        l_allowed(1)       TYPE c,
        l_tablekey         LIKE e071k-tabkey,
        l_tablename        LIKE tresc-tabname,
        l_fieldname        LIKE tresc-fieldname,
        nwpvz_count        TYPE i,
        l_txt1(50)         TYPE c,
        l_txt2(50)         TYPE c,
        l_text1(70)        TYPE c,
        l_text2(70)        TYPE c,
        l_text3(70)        TYPE c,
        l_text4(70)        TYPE c,
        l_text(280)        TYPE c,
        l_icon_1           TYPE icon-name,
        l_icon_2           TYPE icon-name,
        l_viewtype_txt(30) TYPE c,
        l_cancel           LIKE off,
        l_answer(1)        TYPE c.

  DATA: ls_wa_n            TYPE REF TO data,
        ls_wa_o            TYPE REF TO data,
        lt_ref_n           TYPE REF TO data,
        lt_ref_o           TYPE REF TO data,
        l_comp_kz(2)       TYPE c,
        l_comp_mandt       TYPE lvc_fname,
        l_dbname           TYPE lvc_tname,
        l_dbname_v         TYPE lvc_tname,
        l_func_name        TYPE ish_fbname,
        l_tabname_checked  TYPE string.  " TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) FIX

  FIELD-SYMBOLS: <l_wa_n>       TYPE ANY,
                 <l_wa_o>       TYPE ANY,
                 <l_kz>         TYPE vnwviewt-kz,
                 <l_mandt>      TYPE vnwviewt-mandt,
                 <lt_n>         TYPE STANDARD TABLE,
                 <lt_o>         TYPE STANDARD TABLE.

  CLEAR:   e_rc, l_view, l_viewvar.

  CLEAR:   t_messages.
  REFRESH: t_messages,
           lt_nwview,   lt_nwviewt,   lt_nwpvz,   lt_nwpvzt,
           lt_o_nwview, lt_o_nwviewt, lt_o_nwpvz, lt_o_nwpvzt.

  l_popup = i_popup.

* Sicht lesen
  SELECT SINGLE * FROM nwview INTO l_view
         WHERE  viewtype  = i_view-viewtype
         AND    viewid    = i_view-viewid.
  IF sy-subrc <> 0.
*   Die Sicht & (Sichttyp &) wurde nicht gefunden
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF1' '228' i_view-viewid i_view-viewtype
                  space space space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    e_rc = 1.
    EXIT.
  ELSE.
    APPEND l_view TO lt_nwview.
*   Text zur Sicht lesen (alle Sprachen!)
    SELECT * FROM nwviewt INTO TABLE lt_nwviewt "#EC CI_NOFIRST
           WHERE  viewtype  = l_view-viewtype
           AND    viewid    = l_view-viewid.
  ENDIF.

* System bestimmen - SAP oder Kunde (und in globale Variable stellen)
  PERFORM read_system.

* Prüfung: Es sollten keine SAP-Standard-Sichten gelöscht werden
  IF g_system_sap = off.     " Prüfung nur auf Kundensystemen ID 7947
    l_tablekey  = l_view-viewid.
    l_tablename = 'NWVIEW'.
    l_fieldname = 'VIEWID'.
    CALL FUNCTION 'CHECK_CUSTOMER_NAME_FIELD'
         EXPORTING
*             OBJECTTYPE           = 'TABU'
              tablekey             = l_tablekey
              tablename            = l_tablename
              fieldname            = l_fieldname
        IMPORTING
              keyfield_allowed     = l_allowed
*             SYSTEM_SAP           =
*             TABLE_NOT_FOUND      =
*             RESERVED_IN_TRESC    =
        EXCEPTIONS
             objecttype_not_filled = 1
             tablename_not_filled  = 2
             fieldname_not_filled  = 3
             OTHERS                = 4.                     "#EC *
    IF sy-subrc <> 0.
      l_allowed = off.
    ENDIF.
    IF l_allowed <> on.
      e_rc = 1.
*     Von SAP ausgelieferte Sichten dürfen nicht geändert werden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '363' space space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO t_messages.
      EXIT.
*      MESSAGE i363.  " keine Warning sonst Control-Absturz !
    ENDIF.
  ENDIF.

* Zuordnungs- oder Sichtbezeichnung für Popup + S-Message lesen
  CLEAR: l_txt1, l_txt2, l_rc, l_v_nwview.
  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_viewid    = i_view-viewid
      i_viewtype  = i_view-viewtype
      i_caller    = 'LN1VIEWU02'
      i_placeid   = i_place-wplaceid
      i_placetype = i_place-wplacetype
    IMPORTING
      e_rc        = l_rc
      e_view      = l_v_nwview.
  IF l_rc <> 0 OR l_v_nwview-txt IS INITIAL.
    READ TABLE lt_nwviewt INTO l_nwviewt with key spras = sy-langu.
    l_txt1 = l_nwviewt-txt.
  ELSE.
    l_txt1 = l_v_nwview-txt.
  ENDIF.

* Prüfen, ob die Sicht noch anderen Arbeitsumfeldern zugeordnet ist
  l_del_zuo_only = off.
  SELECT * FROM nwpvz INTO TABLE lt_nwpvz
         WHERE  viewtype    = l_view-viewtype
         AND    viewid      = l_view-viewid.                "#EC *
  IF sy-subrc = 0.
    SELECT * FROM nwpvzt INTO TABLE lt_nwpvzt
           FOR ALL ENTRIES IN lt_nwpvz
           WHERE  wplacetype  = lt_nwpvz-wplacetype
           AND    wplaceid    = lt_nwpvz-wplaceid
           AND    viewtype    = lt_nwpvz-viewtype
           AND    viewid      = lt_nwpvz-viewid.            "#EC *
    DESCRIBE TABLE lt_nwpvz.
    IF sy-tfill = 1.
      READ TABLE lt_nwpvz INTO l_nwpvz INDEX 1.
      IF l_nwpvz-wplacetype = i_place-wplacetype AND
         l_nwpvz-wplaceid   = i_place-wplaceid.
*       nur zum übergebenen Arbeitsumfeld zugeordnet
        nwpvz_count = 0.
      ELSE.
*       auch anderen Arbeitsumfeldern zugeordnet
        nwpvz_count = 1.
      ENDIF.
    ELSE.
      nwpvz_count = sy-tfill.
    ENDIF.
    IF nwpvz_count > 0.
*     Liste aller Arbeitsumfelder --> doch nicht anzeigen (ID 6205)
*      PERFORM nwpvz_list TABLES    lt_nwpvz
*                         CHANGING  l_del_ok.
*      IF l_del_ok = off.
*        e_rc = 2.                      " Cancel
*        EXIT.
*      ENDIF.
*     Falls die Sicht auch in einem anderen Arbeitsumfeld verwendet wird
*     dann soll kein Popup kommen, sondern nur die Zuordnung gelöscht
*     werden (betrifft nur Funktion 'Sicht ändern'; bei der Funktion
*     'Arbeitsumfeld pflegen' kommt ein anderes Popup)
      l_popup = off.
      l_del_zuo_only = on.
    ENDIF.
  ENDIF.

* Popup als Sicherheitsabfrage bringen, wenn gewünscht
  DESCRIBE TABLE lt_nwpvz.
  IF l_popup = on AND l_del_zuo_only = off AND sy-tfill > 0.
    PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE'
                                                  l_view-viewtype
                                                  l_viewtype_txt.
    CONCATENATE 'Wollen Sie die Sicht'(024) l_txt1 INTO l_text1
                SEPARATED BY space.
    CONCATENATE '(' 'Sichttyp'(017) INTO l_txt2.
    CONCATENATE l_txt2 l_viewtype_txt INTO l_txt2 SEPARATED BY space.
    CONCATENATE l_txt2 ')' INTO l_txt2.
    CONCATENATE l_txt2 'oder nur die Zuordnung'(025) INTO l_text2
                SEPARATED BY space.
    l_text3 = 'zum Arbeitsumfeld löschen?'(026).
    CONCATENATE l_text1 l_text2 l_text3 INTO l_text SEPARATED BY space.
    l_icon_1 = icon_delete.
    l_icon_2 = icon_disconnect.
    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        titlebar              = 'Sicht löschen'(016)
*        diagnose_object       = ' '
        text_question         = l_text
        text_button_1         = 'Sicht'(027)
        icon_button_1         = l_icon_1
        text_button_2         = 'Zuordnung'(015)
        icon_button_2         = l_icon_2
        default_button        = '1'
        display_cancel_button = 'X'
*        popup_type            = ' '
      IMPORTING
        answer                = l_answer
      EXCEPTIONS
        text_not_found        = 1
        OTHERS                = 2.
    IF sy-subrc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
    CASE l_answer.
      WHEN '1'.                                             " Sicht
*       OK -> Weiter
      WHEN '2'.                                             " Zuordnung
*       Sicht selbst nicht löschen -> nur die Zuordnung zum Arb.umf.
        l_del_zuo_only = on.
      WHEN OTHERS.                                          " Cancel
        e_rc = 2.                                           " Abbrechen
        EXIT.
    ENDCASE.
  ELSE.
*   Direkt im Sicht-ändern-Popup soll obiges Abfrage-Popup erscheinen,
*   aber aus dem Arbeitsumfeld-ändern-Popup soll folgendes kommen
    READ TABLE lt_nwpvz INTO l_nwpvz
               with key wplacetype = i_place-wplacetype
                        wplaceid   = i_place-wplaceid.
    IF ( i_caller    <> 'LN1VIEWF01' AND
         i_popup      = on           AND
         nwpvz_count  > 0 )          OR
       ( sy-subrc    <> 0            AND
         i_popup      = on           AND
         nwpvz_count  > 0 ).
      PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE'
                                                    l_view-viewtype
                                                    l_viewtype_txt.
      CONCATENATE 'Die Sicht'(031) l_txt1 INTO l_text1
                  SEPARATED BY space.
      CONCATENATE '(' 'Sichttyp'(017) INTO l_txt2.
      CONCATENATE l_txt2 l_viewtype_txt INTO l_txt2 SEPARATED BY space.
      CONCATENATE l_txt2 ')' INTO l_text2.
      l_text3 =
        'wird noch von anderen Arbeitsumfeldern verwendet.'(032).
      l_text4 = 'Wollen Sie die Sicht trotzdem löschen?'(033).
      CONCATENATE l_text1 l_text2 l_text3 l_text4 INTO l_text
                  SEPARATED BY space.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar              = 'Sicht löschen'(016)
*          diagnose_object       = ' '
          text_question         = l_text
          text_button_1         = 'Ja'(009)
          text_button_2         = 'Nein'(014)
          default_button        = '1'
          display_cancel_button = 'X'
*          popup_type            = ' '
        IMPORTING
          answer                = l_answer
        EXCEPTIONS
          text_not_found        = 1
          OTHERS                = 2.
      IF sy-subrc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
      CASE l_answer.
        WHEN '1'.                                         " Ja
*         OK -> Weiter (Sicht & Zuordnungen löschen)
          l_del_zuo_only = off.
        WHEN OTHERS.                                      " Cancel/Nein
          e_rc = 2.                                       " Abbrechen
          EXIT.
      ENDCASE.
    ENDIF.
  ENDIF.

* Zuerst die Zuordnung der Sicht zum Arbeitsumfeld löschen

* Alte Tabellen füllen
  APPEND LINES OF lt_nwpvz   TO lt_o_nwpvz.
  APPEND LINES OF lt_nwpvzt  TO lt_o_nwpvzt.

* Delete-KZ setzen
  IF l_del_zuo_only = off.
*   da auch die Sicht gelöscht wird, alle Zuordnungen löschen
    LOOP AT lt_nwpvz INTO l_nwpvz.
      l_nwpvz-kz = 'D'.
      MODIFY lt_nwpvz FROM l_nwpvz.
    ENDLOOP.
    LOOP AT lt_nwpvzt INTO l_nwpvzt.
      l_nwpvzt-kz = 'D'.
      MODIFY lt_nwpvzt FROM l_nwpvzt.
    ENDLOOP.
  ELSE.
*   nur die Zuordnung zum übergebenen Arbeitsumfeld löschen
    LOOP AT lt_nwpvz INTO l_nwpvz WHERE wplacetype = i_place-wplacetype
                                    AND wplaceid   = i_place-wplaceid.
      l_nwpvz-kz = 'D'.
      MODIFY lt_nwpvz FROM l_nwpvz.
    ENDLOOP.
    LOOP AT lt_nwpvzt INTO l_nwpvzt
                      WHERE wplacetype = i_place-wplacetype
                        AND wplaceid   = i_place-wplaceid.
      l_nwpvzt-kz = 'D'.
      MODIFY lt_nwpvzt FROM l_nwpvzt.
    ENDLOOP.
  ENDIF.

* Verbuchung Zuordung Arbeitsumfeld-Sicht
  CALL FUNCTION 'ISH_VERBUCHER_NWPVZ'
    EXPORTING
      i_tcode   = sy-tcode
    TABLES
      t_n_nwpvz = lt_nwpvz
      t_o_nwpvz = lt_o_nwpvz.
* Verbuchung Text zur Zuordung Arbeitsumfeld-Sicht
  CALL FUNCTION 'ISH_VERBUCHER_NWPVZT'
    EXPORTING
      i_tcode    = sy-tcode
    TABLES
      t_n_nwpvzt = lt_nwpvzt
      t_o_nwpvzt = lt_o_nwpvzt.

* Nun auch Sicht selbst löschen, wenn sie in keinem
* Arbeitsumfeld mehr verwendet wird und das Popup bestätigt wurde
  IF l_del_zuo_only = off.

*   Alte Tabellen füllen
    APPEND LINES OF lt_nwview  TO lt_o_nwview.
    APPEND LINES OF lt_nwviewt TO lt_o_nwviewt.

*   Delete-KZ setzen
    LOOP AT lt_nwview INTO l_nwview.
      l_nwview-kz = 'D'.
      MODIFY lt_nwview FROM l_nwview.
    ENDLOOP.
    LOOP AT lt_nwviewt INTO l_nwviewt.
      l_nwviewt-kz = 'D'.
      MODIFY lt_nwviewt FROM l_nwviewt.
    ENDLOOP.

*   Verbuchung Sicht
    CALL FUNCTION 'ISH_VERBUCHER_NWVIEW'
      EXPORTING
        i_tcode    = sy-tcode
      TABLES
        t_n_nwview = lt_nwview
        t_o_nwview = lt_o_nwview.
*   Verbuchung Text zur Sicht
    CALL FUNCTION 'ISH_VERBUCHER_NWVIEWT'
      EXPORTING
        i_tcode     = sy-tcode
      TABLES
        t_n_nwviewt = lt_nwviewt
        t_o_nwviewt = lt_o_nwviewt.

*   Nur für Workplace und Components -> Varianten löschen
    IF i_place-wplacetype = '001'.
*     Varianten aus speziellen Tabellen lesen (ID 18129 chg)
      CLEAR: l_dbname, l_dbname_v, l_func_name, ls_wa_n, ls_wa_o,
             lt_ref_n, lt_ref_o.
      PERFORM get_view_specific IN PROGRAM sapln1workplace
                                USING      l_view-viewtype
                                CHANGING   l_dbname
                                           l_dbname_v
                                           l_func_name.
      IF l_dbname    IS INITIAL OR
         l_dbname_v  IS INITIAL OR
         l_func_name IS INITIAL.
        e_rc = 1.
        EXIT.
      ENDIF.
      CREATE DATA lt_ref_n TYPE STANDARD TABLE OF (l_dbname_v).
      ASSIGN lt_ref_n->* TO <lt_n>.
      CREATE DATA lt_ref_o TYPE STANDARD TABLE OF (l_dbname_v).
      ASSIGN lt_ref_o->* TO <lt_o>.
      CREATE DATA ls_wa_n LIKE LINE OF <lt_n>.
      ASSIGN ls_wa_n->* TO <l_wa_n>.
      CREATE DATA ls_wa_o LIKE LINE OF <lt_o>.
      ASSIGN ls_wa_o->* TO <l_wa_o>.
      CLEAR: <l_wa_n>, <l_wa_o>.

" TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) FIX Start
      TRY.
          cl_abap_dyn_prg=>check_table_name_str(
                  EXPORTING
                    val               = l_dbname    " Input that shall be checked
                    packages          = 'IS-HMED,IS-H'    " Package to which the table shall belong
                    incl_sub_packages = abap_true
                  RECEIVING
                    val_str           = l_tabname_checked    " Same as the input
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
                  val                      = l_dbname
                  whitelist                = lt_whitelist
                RECEIVING
                  val_str                  = l_tabname_checked    " Same as the input
              ).
            CATCH cx_abap_not_in_whitelist.    "
              MESSAGE a001(n1sec).
*   SQL-Befehlsinjektion - interner Fehler
          ENDTRY.
      ENDTRY.

      SELECT SINGLE * FROM (l_tabname_checked) INTO <l_wa_o>
             WHERE  viewtype  = l_view-viewtype
             AND    viewid    = l_view-viewid.              "#EC ENHOK
" TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) FIX Start
*     Alte Daten
      APPEND <l_wa_o> TO <lt_o>.
*     Neue Daten
      <l_wa_n> = <l_wa_o>.
*     mandant
      l_comp_mandt = 'MANDT'.
      ASSIGN COMPONENT l_comp_mandt OF STRUCTURE <l_wa_n> TO <l_mandt>.
      IF <l_mandt> IS INITIAL.
        <l_mandt> = sy-mandt.
      ENDIF.
*     delete flag
      l_comp_kz = 'KZ'.
      ASSIGN COMPONENT l_comp_kz OF STRUCTURE <l_wa_n> TO <l_kz>.
      <l_kz> = 'D'.
      APPEND <l_wa_n> TO <lt_n>.
*     Verbucher aufrufen
      DESCRIBE TABLE <lt_n>.
      IF sy-tfill > 0.
        CALL FUNCTION l_func_name
          EXPORTING
            i_tcode    = sy-tcode
          TABLES
            t_n_nwview = <lt_n>
            t_o_nwview = <lt_o>.
      ENDIF.
*     Prüfen, ob die Varianten noch in anderen Sichten verwendet werden,
*     wenn nicht, dann sollen sie gelöscht werden
      IF NOT l_viewvar IS INITIAL.
*       Selektionsvariante
        PERFORM delete_svar USING    l_viewvar off
                            CHANGING l_cancel.
*       Anzeigevariante
        PERFORM delete_avar USING    l_viewvar off
                            CHANGING l_cancel.
*       Funktionsvariante
        PERFORM delete_fvar USING    l_viewvar off
                            CHANGING l_cancel.
      ENDIF.                           " if not L_VIEWVAR is initial
    ENDIF.                             " Workplace OR Components?

*   Personalisierungsinformation der Sicht (für alle Benutzer) löschen
    CALL FUNCTION 'ISHMED_VM_VIEW_PERSONAL_CHANGE'
      EXPORTING
        i_view   = l_view
        i_place  = i_place
        i_vcode  = 'DEL'  " Löschen
        i_mode   = 'XXX'  " für alle Benutzer
        i_commit = off
        i_caller = 'LN1VIEWU02'.

*   Success-Message zurückliefern -> Sicht & wurde gelöscht
    PERFORM build_bapiret2(sapmn1pa)
            USING 'S' 'NF1' '385' l_txt1  space
                  space space space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.

  ENDIF.                               "  if l_del_zuo_only = off

  COMMIT WORK AND WAIT.

  IF i_update_buffer = on.
*   Puffer mit den Arbeitsumfeld/Sicht-Daten des Benutzers aktual.
    PERFORM refresh_personal_buffer USING sy-uname i_place.
  ENDIF.

ENDFUNCTION.
