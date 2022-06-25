FUNCTION ishmed_vm_wplace_change.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"     VALUE(I_VCODE) TYPE  ISH_VCODE DEFAULT 'INS'
*"     VALUE(I_USER_ZUO) TYPE  ISH_ON_OFF DEFAULT ' '
*"     VALUE(I_CALLER) TYPE  SY-REPID
*"     VALUE(I_SAP_STANDARD) TYPE  ISH_ON_OFF DEFAULT ' '
*"  EXPORTING
*"     VALUE(E_RC) LIKE  SY-SUBRC
*"     VALUE(E_PLACE) TYPE  NWPLACE
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: l_place            LIKE nwplace,
        l_usr_param_value  LIKE usr05-parva,
        l_prio             LIKE nwpusz-prio,
        l_wa_msg           LIKE bapiret2,
        l_agr_name         LIKE nwpusz-agr_name,
        l_text1(50)        TYPE c,
        l_text2(50)        TYPE c,
        l_text(100)        TYPE c,
        l_answer(1)        TYPE c.

  CLEAR:   t_messages.
  REFRESH: t_messages.

  CLEAR: e_rc, e_place.
  CLEAR: g_place_old, g_vcode, g_vcode_txt, g_save_ok_code,
         g_place_txt_old, l_place, g_subscreen_changed,
         g_launchpad_container, g_launchpad_tree, l_agr_name,
         g_view_container, g_view_tree,
         g_place_001, g_caller,
         rn1_scr_wpl100, rn1_scr_wpl101.

  REFRESH: gt_nwplace, gt_nwview, gt_nwpvz, gt_nwpusz, gt_nwpvz_old,
           gt_nwplace_001.

* Globale Daten
  rn1_scr_wpl101 = i_place.

  g_vcode  = i_vcode.
  g_caller = i_caller.

  IF rn1_scr_wpl101-mandt IS INITIAL.
    rn1_scr_wpl101-mandt = sy-mandt.
  ENDIF.

* Arbeitsumfeldtyp sollte übergeben werden, wenn nicht, dann aufgrund
* des Aufrufers bestimmen
  IF rn1_scr_wpl101-wplacetype IS INITIAL.
    CASE i_caller.
      WHEN 'SAPLN_WP_FRAMEWORK'.
        rn1_scr_wpl101-wplacetype = '001'.
      WHEN OTHERS.
        rn1_scr_wpl101-wplacetype = '001'.
    ENDCASE.
  ENDIF.

* System bestimmen - SAP oder Kunde (und in globale Variable stellen)
  PERFORM read_system.

* Prüfen des Verarbeitungscodes
  IF g_vcode <> g_vcode_insert  AND
     g_vcode <> g_vcode_update  AND
     g_vcode <> g_vcode_display.
    g_vcode = g_vcode_display.
  ENDIF.

* Prüfen, ob Arbeitsumfeld für INSERT geeignet ist
  IF g_vcode = g_vcode_insert AND NOT rn1_scr_wpl101-wplacetype IS INITIAL
                              AND NOT rn1_scr_wpl101-wplaceid   IS INITIAL.
    SELECT SINGLE * FROM nwplace INTO l_place
           WHERE  wplacetype  = rn1_scr_wpl101-wplacetype
           AND    wplaceid    = rn1_scr_wpl101-wplaceid.
    IF sy-subrc = 0.
      rn1_scr_wpl101 = l_place.
      g_place_old    = rn1_scr_wpl101.
      g_vcode        = g_vcode_update.
    ENDIF.
  ENDIF.

*  g_first_time_warning = on.

* Falls des Arbeitsumfeld-ID mit 'S' beginnt, dann ist es ein von
* SAP ausgeliefertes SAP-Standard-Arbeitsumfeld
  IF rn1_scr_wpl101-wplaceid(1) = 'S'.
    rn1_scr_wpl100-sapstandard = on.
  ELSE.
    rn1_scr_wpl100-sapstandard = off.
  ENDIF.

* ID 7947: SAP-Standard-Arbeitsumfeld oder Kunden-Arbeitsumfeld anlegen
  IF g_vcode = g_vcode_insert.
    IF i_sap_standard = on.
      rn1_scr_wpl100-sapstandard = on.
    ELSEIF i_sap_standard = 'P'.
      IF g_system_sap = on.
        l_text1 = 'Wollen Sie ein SAP-Standard-Arbeitsumfeld'(029).
        l_text2 = 'oder ein Kunden-Arbeitsumfeld anlegen?'(030).
        CONCATENATE l_text1 l_text2 INTO l_text SEPARATED BY space.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            titlebar                    = 'Arbeitsumfeld anlegen'(001)
*           DIAGNOSE_OBJECT             = ' '
            text_question               = l_text
            text_button_1               = 'Standard'(031)
*           ICON_BUTTON_1               = ' '
            text_button_2               = 'Kunden'(032)
*           ICON_BUTTON_2               = ' '
            default_button              = '2'
*           DISPLAY_CANCEL_BUTTON       = 'X'
*           POPUP_TYPE                  =
          IMPORTING
            answer                      = l_answer
          EXCEPTIONS
            text_not_found              = 1
            OTHERS                      = 2.
        IF sy-subrc <> 0.
          e_rc = 1.
          EXIT.
        ENDIF.
        CASE l_answer.
          WHEN '1'.
            rn1_scr_wpl100-sapstandard = on.
          WHEN '2'.
            rn1_scr_wpl100-sapstandard = off.
          WHEN OTHERS.
            e_rc = 2.                                        " Cancel
            EXIT.
        ENDCASE.
      ELSE.
        rn1_scr_wpl100-sapstandard = off.
      ENDIF.
    ENDIF.
  ENDIF.

* Beim Anlegen soll ein Popup für Eingabe Type und ID kommen
* ID 5683: Popup braucht nicht mehr zu kommen, da der
* Type übergeben und die ID automatisch generiert wird
*  IF g_vcode = g_vcode_insert.
*    g_first_time_200 = on.
*    CALL SCREEN 200 STARTING AT 3 3 ENDING AT 55 5.
*    IF g_save_ok_code = 'ECAN'.
*      e_rc = 2.                                          " Cancel
*      EXIT.
*    ENDIF.
*  ENDIF.

* Prüfen, ob Arbeitsumfeld für UPDATE oder DISPLAY geeignet ist
  IF g_vcode = g_vcode_update OR g_vcode = g_vcode_display.
    SELECT SINGLE * FROM nwplace INTO l_place
           WHERE  wplacetype  = rn1_scr_wpl101-wplacetype
           AND    wplaceid    = rn1_scr_wpl101-wplaceid.
    IF sy-subrc = 0.
      rn1_scr_wpl101 = l_place.
      g_place_old    = l_place.
    ELSE.
*     Arbeitsumfeld & nicht gefunden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '366' rn1_scr_wpl101-wplaceid
                    space space space
                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO t_messages.
      e_rc = 1.
      EXIT.
    ENDIF.
  ENDIF.

* Text zum Arbeitsumfeld lesen
  g_vcode_txt = g_vcode.
  IF g_vcode = g_vcode_update OR g_vcode = g_vcode_display.
    SELECT SINGLE txt FROM nwplacet INTO rn1_scr_wpl100-place_txt
           WHERE  wplacetype  = rn1_scr_wpl101-wplacetype
           AND    wplaceid    = rn1_scr_wpl101-wplaceid
           AND    spras       = sy-langu.
    IF sy-subrc <> 0.
      CLEAR rn1_scr_wpl100-place_txt.
      g_vcode_txt = g_vcode_insert.       " Insert Text
    ENDIF.
    g_place_txt_old = rn1_scr_wpl100-place_txt.
  ENDIF.

* Anzeige-Art der Knoten bestimmen
  CALL FUNCTION 'ISH_USR05_GET'
    EXPORTING
      ss_bname         = sy-uname
      ss_parid         = 'WP_LAUNCHPAD_BUTTON'
    IMPORTING
      ss_value         = l_usr_param_value
    EXCEPTIONS
      parid_not_found  = 1
      bname_is_initial = 2
      parid_is_initial = 3
      OTHERS           = 4.
  IF sy-subrc = 0.
    g_buttons_in_launchpad = l_usr_param_value.
  ELSE.
    g_buttons_in_launchpad = on.
  ENDIF.

  g_first_time_100       = on.
  g_first_time_subscreen = on.

* Dynpro 'Arbeitsumfeld pflegen' aufrufen
  CALL SCREEN 100 STARTING AT 2 2 ENDING AT 101 25.

* Falls gewünscht, soll das Arbeitsumfeld dem Benutzer zugeordnet werden
  IF i_user_zuo = on AND g_save_ok_code = 'SAVE'.
    CLEAR: l_prio, l_agr_name.
    PERFORM place_user_zuo USING sy-uname l_agr_name
                                 rn1_scr_wpl101 rn1_scr_wpl100-place_txt l_prio
                                 on off off.               "#EC ENHOK
  ENDIF.

* Immer den Puffer der Arb.umf./Sicht-Daten des Benutzers initialisieren
  PERFORM clear_personal_buffer.
* Den Puffer der Sicht-Daten ebenfalls initialisieren
  PERFORM refresh_view_buffer.

* Angelegte/geänderte Sicht mit Varianten zurückliefern
  IF g_save_ok_code = 'SAVE'.
    e_place = rn1_scr_wpl101.
  ELSEIF g_save_ok_code = 'ECAN'.
    e_rc = 2.                                    " Cancel
  ELSEIF g_save_ok_code = 'DELE'.
    e_rc = 3.                                    " Delete
  ENDIF.

* Control Objekte freigeben
  CALL METHOD g_view_tree->free.
  CALL METHOD g_view_container->free.
  CALL METHOD g_launchpad_tree->free.
  CALL METHOD g_launchpad_container->free.

ENDFUNCTION.
