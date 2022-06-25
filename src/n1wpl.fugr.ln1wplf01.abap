*----------------------------------------------------------------------*
***INCLUDE LN1WPLF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  FILL_EXCLTAB
*&---------------------------------------------------------------------*
FORM fill_excltab.

  CLEAR gt_ex_fct.   REFRESH gt_ex_fct.
  IF g_vcode = g_vcode_display.
    PERFORM append_excltab USING 'SAVE'.       " Sichern
  ENDIF.
  IF g_vcode = g_vcode_display OR g_vcode = g_vcode_insert.
    PERFORM append_excltab USING 'DELE'.       " Löschen
    PERFORM append_excltab USING 'DELU'.       " Löschen Benutzereinst.
  ENDIF.
  IF g_vcode = g_vcode_insert.
    PERFORM append_excltab USING 'WPRF'.       "Where-Used-List
  ENDIF.
*  IF g_vcode = g_vcode_update OR g_vcode = g_vcode_insert.
*    PERFORM append_excltab USING 'ENTR'.       " Enter
*  ENDIF.

* ID 6505: Wenn Web-GUI aktiv, einige Buttons ausblenden
  CALL FUNCTION 'ITS_PING'
    EXCEPTIONS
      its_not_available = 1
      OTHERS            = 2.
  IF sy-subrc <> 0.
*    PERFORM append_excltab USING 'VINS'.       " Sicht anlegen
    PERFORM append_excltab USING 'VAPP'.       " Sicht aufnehmen
    PERFORM append_excltab USING 'VREM'.       " Sicht rausnehmen
  ENDIF.

* ID 8515: Transportieren generell hier rausnehmen
  PERFORM append_excltab USING 'TRAN'.         " Transportieren

ENDFORM.                               " FILL_EXCLTAB
*---------------------------------------------------------------------*
* FORM APPEND_EXCLTAB
* Satz in EXCL_TAB einfügen, wenn noch nicht vorhanden
*---------------------------------------------------------------------*
FORM append_excltab USING l_function TYPE any.

  READ TABLE gt_ex_fct WITH KEY function = l_function.
  IF sy-subrc <> 0.
    gt_ex_fct-function = l_function.
    APPEND gt_ex_fct.
  ENDIF.

ENDFORM.                               " APPEND_EXCLTAB

*&---------------------------------------------------------------------*
*&      Form  INIT_300
*&---------------------------------------------------------------------*
*       Initialisierungen für Dynpro 300 (Zuordnungsdetails ändern)
*----------------------------------------------------------------------*
FORM init_300.

  IF g_first_time_300 = on.

*   Die Listbox für den Sichttyp befüllen
    PERFORM fill_lb_viewtype(sapln1view) USING 'RN1_SCR_WPL300-VIEWTYPE'
                                               rn1_scr_wpl300-wplacetype.

    g_first_time_300 = off.
  ENDIF.

ENDFORM.                                                    " INIT_300

*&---------------------------------------------------------------------*
*&      Form  INIT_200
*&---------------------------------------------------------------------*
*       Initialisierungen für Dynpro 200 (Arb.umf. anlegen)
*----------------------------------------------------------------------*
FORM init_200.

  IF g_first_time_200 = on.
*   Die Listbox für den Arbeitsumfeldtyp befüllen
*   da er vorläufig nicht angezeigt wird - derzeit nicht befüllen
*    perform fill_lb_wplacetype using 'RN1_SCR_WPL101-WPLACETYPE'.
    PERFORM modify_screen.
    g_first_time_200 = off.
  ENDIF.

ENDFORM.                                                    " INIT_200

*&---------------------------------------------------------------------*
*&      Form  INIT_100
*&---------------------------------------------------------------------*
*       Initialisierungen für Dynpro 100 (Arb.umf. pflegen)
*----------------------------------------------------------------------*
FORM init_100.

  IF g_first_time_100 = on.
    PERFORM clear_personal_buffer.
    PERFORM read_all_views USING rn1_scr_wpl101-wplacetype.
    PERFORM set_get_personal_buffer USING 'L'.           " Load
    g_error          = off.
    g_menu_req       = off.
    g_dragdrop_req   = off.
    g_first_time_100 = off.
  ENDIF.

ENDFORM.                                                    " INIT_200

*&---------------------------------------------------------------------*
*&      Form  FILL_LB_WPLACETYPE
*&---------------------------------------------------------------------*
*       Listbox mit den gültigen Arbeitsumfeldtypen befüllen
*----------------------------------------------------------------------*
*      --> P_FNAME   Feldname (Arbeitsumfeldtyp)
*----------------------------------------------------------------------*
*FORM fill_lb_wplacetype USING value(p_fname) TYPE vrm_id.
*
*  DATA: lt_list    TYPE vrm_values,
*        l_wa_list  LIKE LINE OF lt_list,
*        lt_values  LIKE TABLE OF dd07v,
*        l_value    LIKE dd07v.
*
*  REFRESH: lt_list, lt_values.
*
** Festwerte und Bezeichnungen der Domäne lesen
*  PERFORM get_domain_values(sapmn1pa) TABLES lt_values
*                                      USING  'NWPLACETYPE'.
*
*  LOOP AT lt_values INTO l_value.
*    CLEAR l_wa_list.
*    l_wa_list-key  = l_value-domvalue_l.
*    l_wa_list-text = l_value-ddtext.
*    APPEND l_wa_list TO lt_list.
*  ENDLOOP.
*
*  CALL FUNCTION 'VRM_SET_VALUES'
*       EXPORTING
*            id              = p_fname
*            values          = lt_list
*       EXCEPTIONS
**           id_illegal_name = 1
*            OTHERS          = 0.
*
*ENDFORM.                               " FILL_LB_WPLACETYPE

*&---------------------------------------------------------------------*
*&      Form  OK_CODE_100
*&---------------------------------------------------------------------*
FORM ok_code_100.

  DATA: l_rc                LIKE sy-subrc,
        yn(2)               TYPE c,
        l_v_nwpvz           TYPE v_nwpvz,
        l_v_nwview          TYPE v_nwview,
        l_sortid            TYPE nwpvz-sortid,
        l_tab_index         TYPE sy-tabix,
        lt_nwpvz_dd         TYPE TABLE OF v_nwpvz,
        lt_nodes            TYPE lvc_t_nkey,
        l_node              TYPE lvc_nkey.

  g_save_ok_code = ok-code.

  IF ok-code(1) = '%'.                 " Control Events
    CALL METHOD cl_gui_cfw=>dispatch.
    CLEAR ok-code.
  ELSE.
    CLEAR ok-code.
    CASE g_save_ok_code.
      WHEN 'ENTR'.                     " Enter
        IF g_vcode = g_vcode_display.
          SET SCREEN 0. LEAVE SCREEN.
        ENDIF.
      WHEN 'SAVE'.                     " Sichern
        PERFORM save_wplace.
        SET SCREEN 0. LEAVE SCREEN.
      WHEN 'DELE'.                     " Löschen
        PERFORM delete_wplace CHANGING l_rc.
        IF l_rc = 0.
          SET SCREEN 0. LEAVE SCREEN.
        ENDIF.
      WHEN 'DELU'.                     " Löschen Benutzereinstellungen
        PERFORM delete_wplace_pers CHANGING l_rc.
      WHEN 'TRAN'.                     " Transportieren (ID 6682)
        IF g_error = off.
          IF g_vcode                   = g_vcode_insert  OR
             rn1_scr_wpl101           <> g_place_old     OR
             rn1_scr_wpl100-place_txt <> g_place_txt_old OR
             gt_nwpvz[]               <> gt_nwpvz_old[]  OR
             g_subscreen_changed       = on.
            PERFORM popup_to_confirm(sapmnpa0)
                    USING ' ' 'Arbeitsumfeld noch nicht gesichert.'(025)
                              'Daten sichern?'(026)
                              'Arbeitsumfeld transportieren'(024)  yn.
            CASE yn.
              WHEN 'J'.               " Yes
                PERFORM save_wplace.
                PERFORM transport_wplace.
                g_save_ok_code = 'SAVE'.
                SET SCREEN 0. LEAVE SCREEN.
              WHEN 'A'.               " Cancel
                EXIT.                            " am Dynpro bleiben
              WHEN OTHERS.            " No
                MESSAGE s572.
*               Ohne Sichern kann Arbeitsumfeld nicht transp. werden
            ENDCASE.
          ELSE.
            PERFORM transport_wplace.
          ENDIF.
        ENDIF.
*     show the Where-Used-List to the Work Environment
      WHEN 'WPRF'.
        CALL FUNCTION 'ISH_WP_WHERE_USED_LIST_WPLACE'
          EXPORTING
            i_wplacetype = rn1_scr_wpl101-wplacetype
            i_wplaceid   = rn1_scr_wpl101-wplaceid
            i_callback   = 'SAPLN_WP'
            i_pf_status  = 'SET_PF_STATUS_VM4'
*           I_USER_CMD   =
*           I_MARK       = ' '
          EXCEPTIONS
            not_used     = 1
            OTHERS       = 2.
        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
                  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
        ENDIF.

      WHEN 'VINS'.                     " Sicht anlegen
*       get all selected nodes
        PERFORM get_sel_nodes_view_tree CHANGING lt_nodes.
        LOOP AT lt_nodes INTO l_node.
          CHECK l_node(2) <> gc_viewtype.
          DELETE TABLE lt_nodes FROM l_node.
        ENDLOOP.
        DESCRIBE TABLE lt_nodes.
        IF sy-tfill > 0.
          READ TABLE lt_nodes INTO l_node INDEX 1.
          PERFORM call_view_insert USING l_node on.
        ELSE.
          CLEAR l_node.
          PERFORM call_view_insert USING l_node off.
        ENDIF.
*       refreshing viewlist and launchpad
        PERFORM build_launchpad_nodes USING on.
        PERFORM build_view_list_nodes USING on.
      WHEN 'VAPP'.                     " Sicht hinzufügen
*       button only active in web-gui-modus
*       add view to launchpad (at last position)
        CLEAR: l_sortid, l_v_nwpvz.
        REFRESH: lt_nwpvz_dd, lt_nodes.
*       get all selected nodes
        PERFORM get_sel_nodes_view_tree CHANGING lt_nodes.
        LOOP AT lt_nodes INTO l_node.
          CHECK l_node(2) <> gc_viewid.
          DELETE TABLE lt_nodes FROM l_node.
        ENDLOOP.
        DESCRIBE TABLE lt_nodes.
        IF sy-tfill > 0.
*         get last sortid
          LOOP AT gt_nwpvz_lp INTO l_v_nwpvz.
            IF l_v_nwpvz-sortid > l_sortid.
              l_sortid = l_v_nwpvz-sortid.
            ENDIF.
          ENDLOOP.
          l_sortid = l_sortid + 1.
*         get data of the view(s) to be added
          LOOP AT lt_nodes INTO l_node.
            l_tab_index = l_node+2(10).
            READ TABLE gt_views INTO l_v_nwview INDEX l_tab_index.
            CLEAR l_v_nwpvz.
            MOVE-CORRESPONDING rn1_scr_wpl101 TO l_v_nwpvz. "#EC ENHOK
            MOVE-CORRESPONDING l_v_nwview     TO l_v_nwpvz. "#EC ENHOK
            l_v_nwpvz-sortid = l_sortid.
            APPEND l_v_nwpvz TO lt_nwpvz_dd.
            l_sortid = l_sortid + 1.
          ENDLOOP.
          PERFORM insert_view_to_launchpad TABLES lt_nwpvz_dd.
*         refreshing viewlist and launchpad
          PERFORM build_launchpad_nodes USING on.
          PERFORM build_view_list_nodes USING on.
        ENDIF.
      WHEN 'VREM'.                     " Sicht rausnehmen
*       button only active in web-gui-modus
*       remove view from launchpad
        CLEAR: l_sortid, l_v_nwpvz.
        REFRESH: lt_nwpvz_dd.
*       get all selected nodes
        PERFORM get_sel_nodes_launchpad CHANGING lt_nodes.
        LOOP AT lt_nodes INTO l_node.
          CHECK l_node(2) <> gc_view.
          DELETE TABLE lt_nodes FROM l_node.
        ENDLOOP.
        DESCRIBE TABLE lt_nodes.
        IF sy-tfill > 0.
*         get data of the view(s) to be removed
          LOOP AT lt_nodes INTO l_node.
            l_tab_index = l_node+2(10).
            READ TABLE gt_nwpvz_lp INTO l_v_nwpvz
                                   INDEX l_tab_index.
            APPEND l_v_nwpvz TO lt_nwpvz_dd.
          ENDLOOP.
          PERFORM insert_view_to_view_tree TABLES lt_nwpvz_dd.
*         refreshing viewlist and launchpad
          PERFORM build_launchpad_nodes USING on.
          PERFORM build_view_list_nodes USING on.
        ENDIF.
    ENDCASE.
  ENDIF.

ENDFORM.                               " OK_CODE_100

*&---------------------------------------------------------------------*
*&      Form  OK_CODE_200
*&---------------------------------------------------------------------*
FORM ok_code_200.

  g_save_ok_code = ok-code.
  CLEAR ok-code.

  CASE g_save_ok_code.
    WHEN 'ENTR'.                       " Enter (Anlegen)
      SET SCREEN 0. LEAVE SCREEN.
  ENDCASE.

ENDFORM.                               " OK_CODE_200

*&---------------------------------------------------------------------*
*&      Form  OK_CODE_300
*&---------------------------------------------------------------------*
FORM ok_code_300.

  g_save_ok_code_300 = ok-code.
  CLEAR ok-code.

  CASE g_save_ok_code_300.
    WHEN 'ENTR'.                       " Enter
      SET SCREEN 0. LEAVE SCREEN.
  ENDCASE.

ENDFORM.                               " OK_CODE_300

*&---------------------------------------------------------------------*
*&      Form  CHECK_WPLACEID
*&---------------------------------------------------------------------*
*       Prüfung des Arbeitsumfeld-ID
*----------------------------------------------------------------------*
FORM check_wplaceid.

  DATA: l_nwplace    LIKE nwplace.                          "#EC NEEDED
  DATA: l_allowed(1) TYPE c,
        tablekey     LIKE e071k-tabkey,
        tablename    LIKE tresc-tabname,
        fieldname    LIKE tresc-fieldname.

* Die Arbeitsumfeld-ID muß beim Anlegen und Ändern eines neuen
* Arbeitsumfelds geprüft werden
* Beim Ändern deshalb, weil keine SAP-Arb.umf. geändert werden dürfen

  g_error = off.

  CHECK g_vcode = g_vcode_insert OR g_vcode = g_vcode_update.
  CHECK NOT rn1_scr_wpl101-wplaceid IS INITIAL.

* Prüfen, ob dieses Arbeitsumfeld nicht bereits existiert
* Nur am Dynpro 200 prüfen, da am Dynpro 100 nicht mehr änderbar
  IF g_vcode = g_vcode_insert AND sy-dynnr = '0200'.
    SELECT SINGLE * FROM nwplace INTO l_nwplace
           WHERE  wplacetype  = rn1_scr_wpl101-wplacetype
           AND    wplaceid    = rn1_scr_wpl101-wplaceid.
    IF sy-subrc = 0.
      g_error = on.
      SET CURSOR FIELD 'RN1_SCR_WPL101-WPLACEID'.
      MESSAGE e367 WITH rn1_scr_wpl101-wplaceid.
*     Das Arbeitsumfeld & existiert bereits
    ENDIF.
  ENDIF.

* Namensgebung prüfen
*  if g_first_time_warning = on.
  IF g_system_sap = off.     " Prüfung nur auf Kundensystemen ID 7947
*    g_first_time_warning = off.
    tablekey  = rn1_scr_wpl101-wplaceid.
    tablename = 'NWPLACE'.
    fieldname = 'WPLACEID'.
    CALL FUNCTION 'CHECK_CUSTOMER_NAME_FIELD'
      EXPORTING
*       OBJECTTYPE            = 'TABU'
        tablekey              = tablekey
        tablename             = tablename
        fieldname             = fieldname
      IMPORTING
        keyfield_allowed      = l_allowed
*       SYSTEM_SAP            =
*       TABLE_NOT_FOUND       =
*       RESERVED_IN_TRESC     =
      EXCEPTIONS
        objecttype_not_filled = 1
        tablename_not_filled  = 2
        fieldname_not_filled  = 3
        OTHERS                = 4.                          "#EC *
    IF sy-subrc <> 0.
      l_allowed = off.
    ENDIF.
    IF l_allowed <> on.
      SET CURSOR FIELD 'RN1_SCR_WPL101-WPLACEID'.
      g_error = on.
      CLEAR ok-code.
      IF g_vcode = g_vcode_insert.
        MESSAGE e368.
*       Bitte den Namen des Arb.umf. aus dem zuläss. Namensraum wählen
      ELSE.
        MESSAGE e369.
*       Von SAP ausgelieferte Arb.umf. dürfen nicht geändert werden
      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.                               " CHECK_WPLACEID

*&---------------------------------------------------------------------*
*&      Form  INIT_SUBSCREEN
*&---------------------------------------------------------------------*
*       Subscreen 'Spezielle Daten des Arbeitsumfelds' initialisieren
*----------------------------------------------------------------------*
FORM init_subscreen.

  IF g_first_time_subscreen = on.
*   Subscreen initialisieren
    CALL FUNCTION 'ISHMED_VM_WPL_SUBSCREEN_SET'
      EXPORTING
        i_place     = rn1_scr_wpl101                        "#EC ENHOK
        i_vcode     = g_vcode
        i_setvars   = on  " hier initialisieren
        i_okcode    = space
      IMPORTING
        e_sub_pgm   = g_sub_pgm
        e_sub_dynnr = g_sub_dynnr.
  ENDIF.
  g_first_time_subscreen = off.

ENDFORM.                               " INIT_SUBSCREEN

*&---------------------------------------------------------------------*
*&      Form  SET_SUBSCREEN
*&---------------------------------------------------------------------*
*       Daten (OK-Code) an den Subscreen übergeben
*----------------------------------------------------------------------*
FORM set_subscreen.

  CALL FUNCTION 'ISHMED_VM_WPL_SUBSCREEN_SET'
    EXPORTING
      i_place   = rn1_scr_wpl101                            "#EC ENHOK
      i_vcode   = g_vcode
      i_setvars = off  " hier NICHT initialisieren
      i_okcode  = ok-code.

ENDFORM.                               " SET_SUBSCREEN

*&---------------------------------------------------------------------*
*&      Form  GET_SUBSCREEN
*&---------------------------------------------------------------------*
*       Daten vom Subscreen holen
*----------------------------------------------------------------------*
FORM get_subscreen.

  CALL FUNCTION 'ISHMED_VM_WPL_SUBSCREEN_GET'
    EXPORTING
      i_place        = rn1_scr_wpl101                       "#EC ENHOK
    IMPORTING
      e_okcode       = ok-code
      e_data_changed = g_subscreen_changed
      e_nwplace_001  = g_place_001.

  REFRESH gt_nwplace_001.
  APPEND g_place_001 TO gt_nwplace_001.

ENDFORM.                               " GET_SUBSCREEN

*&---------------------------------------------------------------------*
*&      Form  MODIFY_SCREEN
*&---------------------------------------------------------------------*
FORM modify_screen.

  CASE sy-dynnr.
    WHEN '0100'.
      IF g_vcode = g_vcode_display.
        LOOP AT SCREEN.
          screen-input  = false.
          MODIFY SCREEN.
        ENDLOOP.
      ENDIF.
      LOOP AT SCREEN.
*       Vorläufig soll der Arb.umf.typ überhaupt nicht angezeigt werden
        IF screen-name = 'RN1_SCR_WPL101-WPLACETYPE' OR
           screen-name = 'WPLACETYPE_TXT'     OR
           screen-name = 'RN1_SCR_WPL101-WPLACEID'   OR
           screen-name = 'WPLACEID_TXT'.
          screen-input  = false.
          screen-active = false.
          MODIFY SCREEN.
        ENDIF.
*       Feld 'SAP-Standard' nur auf SAP-Systemen anzeigen und nur beim
*       Anlegen eingabebereit
        IF screen-name = 'RN1_SCR_WPL100-SAPSTANDARD' OR
           screen-name = 'SAPSTANDARD_TEXT'.
          IF g_vcode <> g_vcode_insert.
            screen-input  = false.
          ENDIF.
*          if g_system_sap = off.   " ID 7947 ab 4.63A gar nicht anz.
          screen-active = false.
*          endif.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.
    WHEN '0200'.
      LOOP AT SCREEN.
*       Vorläufig soll der Arb.umf.typ überhaupt nicht angezeigt werden
        IF screen-name = 'RN1_SCR_WPL101-WPLACETYPE' OR
           screen-name = 'WPLACETYPE_TXT'.
          screen-input  = false.
          screen-active = false.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.
  ENDCASE.

ENDFORM.                               " MODIFY_SCREEN

*&---------------------------------------------------------------------*
*&      Form  SAVE_WPLACE
*&---------------------------------------------------------------------*
*       Arbeitsumfeld sichern
*----------------------------------------------------------------------*
FORM save_wplace.

  DATA: lt_n_nwplace      LIKE TABLE OF vnwplace,
        lt_n_nwplacet     LIKE TABLE OF vnwplacet,
        lt_n_nwpvz        LIKE TABLE OF vnwpvz,
        lt_n_nwpvzt       LIKE TABLE OF vnwpvzt,
        lt_o_nwplace      LIKE TABLE OF vnwplace,
        lt_o_nwplacet     LIKE TABLE OF vnwplacet,
        lt_o_nwpvz        LIKE TABLE OF vnwpvz,
        lt_o_nwpvzt       LIKE TABLE OF vnwpvzt,
        l_wa_nwplace      LIKE vnwplace,
        l_wa_nwplacet     LIKE vnwplacet,
        l_wa_nwpvz        LIKE vnwpvz,
        l_wa_nwpvzt       LIKE vnwpvzt,
        l_wa_v_nwpvz      LIKE v_nwpvz,
        l_kz              LIKE vnwplace-kz,
        l_kz_txt          LIKE vnwplacet-kz,
        l_rc              LIKE sy-subrc,
        l_key             LIKE rnwp_gen_key-nwkey.

  DATA: lt_messages       LIKE TABLE OF bapiret2.

  REFRESH: lt_n_nwplace, lt_n_nwplacet, lt_n_nwpvz, lt_n_nwpvzt,
           lt_o_nwplace, lt_o_nwplacet, lt_o_nwpvz, lt_o_nwpvzt.
  CLEAR:   l_wa_nwplace, l_wa_nwplacet, l_wa_nwpvz, l_wa_nwpvzt.

  CHECK g_vcode <> g_vcode_display.

* Verarbeitungs-KZ
  IF g_vcode = g_vcode_insert.         " Insert
    l_kz = 'I'.
  ELSE.                                " Update
    l_kz = 'U'.
  ENDIF.
  IF g_vcode_txt = g_vcode_insert.     " Insert
    l_kz_txt = 'I'.
  ELSE.                                " Update
    l_kz_txt = 'U'.
  ENDIF.

* Arbeitsumfeld
  IF g_vcode = g_vcode_insert OR rn1_scr_wpl101 <> g_place_old.
*   ID des Arbeitsumfelds generieren, je nachdem, ob die
*   Checkbox SAP-Standard markiert wurde oder nicht,
*   beginnen Kunden-Arbeitsumfeld-Namen mit 'CST',
*   SAP-Standard-Arbeitsumfeld-Namen mit 'S'
    IF rn1_scr_wpl101-wplaceid IS INITIAL.
      CALL FUNCTION 'ISHMED_VM_GENERATE_KEY'
        EXPORTING
          i_key_type      = 'W'    " Workplace
*         i_user_specific =
          i_sap_standard  = rn1_scr_wpl100-sapstandard
          i_placetype     = rn1_scr_wpl101-wplacetype
*         i_viewtype      =
        IMPORTING
          e_key           = l_key
          e_rc            = l_rc
        TABLES
          t_messages      = lt_messages.
      IF l_rc <> 0.
*       Fehler beim Generieren des Schlüssels
        DESCRIBE TABLE lt_messages.
        IF sy-tfill > 0.
          CALL FUNCTION 'ISH_WP_RETURN_MESSAGES_SEND'
            EXPORTING
              i_message_type = 'S'
            TABLES
              t_messages     = lt_messages.
        ENDIF.
        EXIT.
      ELSE.
        rn1_scr_wpl101-wplaceid = l_key.
        g_place_001-wplaceid = l_key.
        rn1_scr_wpl101-owner = sy-uname.
      ENDIF.
    ENDIF.
*   Neue Daten
    MOVE-CORRESPONDING rn1_scr_wpl101 TO l_wa_nwplace.      "#EC ENHOK
    l_wa_nwplace-kz    = l_kz.
    APPEND l_wa_nwplace  TO lt_n_nwplace.
*   Alte Daten
    IF g_vcode = g_vcode_update.
      CLEAR l_wa_nwplace.
      MOVE-CORRESPONDING g_place_old TO l_wa_nwplace.
      APPEND l_wa_nwplace  TO lt_o_nwplace.
    ENDIF.
  ENDIF.

* Text zum Arbeitsumfeld
  IF g_vcode_txt = g_vcode_insert OR rn1_scr_wpl100-place_txt <> g_place_txt_old.
*   Neue Daten
    MOVE-CORRESPONDING rn1_scr_wpl101 TO l_wa_nwplacet.     "#EC ENHOK
    l_wa_nwplacet-txt   = rn1_scr_wpl100-place_txt.
    l_wa_nwplacet-spras = sy-langu.
    l_wa_nwplacet-kz    = l_kz_txt.
    APPEND l_wa_nwplacet TO lt_n_nwplacet.
*   Alte Daten
    IF g_vcode_txt = g_vcode_update.
      CLEAR l_wa_nwplacet.
      MOVE-CORRESPONDING g_place_old TO l_wa_nwplacet.      "#EC ENHOK
      l_wa_nwplacet-txt  = g_place_txt_old.
      APPEND l_wa_nwplacet TO lt_o_nwplacet.
    ENDIF.
  ENDIF.

* Zuordnung der Sichten zum Arbeitsumfeld (+ Texte)
  IF g_vcode = g_vcode_insert OR gt_nwpvz[] <> gt_nwpvz_old[].
*   Alle bestehenden Zuordnungen löschen ...
    IF g_vcode = g_vcode_update.
      LOOP AT gt_nwpvz_old INTO l_wa_v_nwpvz.
*       Neue und Alte Daten
        CLEAR l_wa_nwpvz.
        MOVE-CORRESPONDING l_wa_v_nwpvz TO l_wa_nwpvz.      "#EC ENHOK
        APPEND l_wa_nwpvz TO lt_o_nwpvz.
        l_wa_nwpvz-kz = 'D'.
        APPEND l_wa_nwpvz TO lt_n_nwpvz.
        SELECT SINGLE * FROM nwpvzt INTO l_wa_nwpvzt
               WHERE  wplacetype  = l_wa_v_nwpvz-wplacetype
               AND    wplaceid    = l_wa_v_nwpvz-wplaceid
               AND    viewtype    = l_wa_v_nwpvz-viewtype
               AND    viewid      = l_wa_v_nwpvz-viewid
               AND    spras       = sy-langu.
        IF sy-subrc = 0.
          CLEAR l_wa_nwpvzt.
          MOVE-CORRESPONDING l_wa_v_nwpvz TO l_wa_nwpvzt.   "#EC ENHOK
          APPEND l_wa_nwpvzt TO lt_o_nwpvzt.
          l_wa_nwpvzt-kz = 'D'.
          APPEND l_wa_nwpvzt TO lt_n_nwpvzt.
        ENDIF.
      ENDLOOP.
    ENDIF.
*   ... und dann die aktuellen Zuordnungen neu anlegen
    LOOP AT gt_nwpvz INTO l_wa_v_nwpvz.
*     Nur Neue Daten
      CLEAR l_wa_nwpvz.
      l_wa_v_nwpvz-wplaceid = rn1_scr_wpl101-wplaceid.
      MOVE-CORRESPONDING l_wa_v_nwpvz TO l_wa_nwpvz.        "#EC ENHOK
      l_wa_nwpvz-kz = 'I'.
      APPEND l_wa_nwpvz TO lt_n_nwpvz.
      CLEAR l_wa_nwpvzt.
      MOVE-CORRESPONDING l_wa_v_nwpvz TO l_wa_nwpvzt.       "#EC ENHOK
      l_wa_nwpvzt-spras = sy-langu.                         " ID 8958
      l_wa_nwpvzt-kz = 'I'.
      APPEND l_wa_nwpvzt TO lt_n_nwpvzt.
    ENDLOOP.
  ENDIF.

* Aufruf der Verbucher
  DESCRIBE TABLE lt_n_nwplace.
  IF sy-tfill > 0.
    CALL FUNCTION 'ISH_VERBUCHER_NWPLACE'
      EXPORTING
        i_tcode     = sy-tcode
      TABLES
        t_n_nwplace = lt_n_nwplace
        t_o_nwplace = lt_o_nwplace.
  ENDIF.
  DESCRIBE TABLE lt_n_nwplacet.
  IF sy-tfill > 0.
    CALL FUNCTION 'ISH_VERBUCHER_NWPLACET'
      EXPORTING
        i_tcode      = sy-tcode
      TABLES
        t_n_nwplacet = lt_n_nwplacet
        t_o_nwplacet = lt_o_nwplacet.
  ENDIF.
  DESCRIBE TABLE lt_n_nwpvz.
  IF sy-tfill > 0.
    CALL FUNCTION 'ISH_VERBUCHER_NWPVZ'
      EXPORTING
        i_tcode   = sy-tcode
      TABLES
        t_n_nwpvz = lt_n_nwpvz
        t_o_nwpvz = lt_o_nwpvz.
  ENDIF.
  DESCRIBE TABLE lt_n_nwpvzt.
  IF sy-tfill > 0.
    CALL FUNCTION 'ISH_VERBUCHER_NWPVZT'
      EXPORTING
        i_tcode    = sy-tcode
      TABLES
        t_n_nwpvzt = lt_n_nwpvzt
        t_o_nwpvzt = lt_o_nwpvzt.
  ENDIF.

* Spezialdaten verbuchen
  IF g_subscreen_changed = on.
    CALL FUNCTION 'ISHMED_VM_WPL_SUBSCREEN_SAVE'
      EXPORTING
        i_place = rn1_scr_wpl101.                           "#EC ENHOK
  ENDIF.

  COMMIT WORK AND WAIT.

ENDFORM.                               " SAVE_WPLACE

*&---------------------------------------------------------------------*
*&      Form  DELETE_WPLACE
*&---------------------------------------------------------------------*
*       Arbeitsumfeld löschen
*----------------------------------------------------------------------*
FORM delete_wplace  CHANGING p_rc   LIKE sy-subrc.

  DATA: lt_messages  LIKE TABLE OF bapiret2,
        l_caller     TYPE sy-repid.

  CLEAR: p_rc, l_caller.

* Wenn der Aufrufer der Baustein 'ISH_WP_MAINTAIN' ist, dann dürfen
* aufgrund der Administratorberechtigung dieser Funktion, auch alle
* Zuordnungen des Arbeitsumfelds zu allen Benutzern gelöscht werden
* Bei anderen Aufrufern dürfen zwar auch Arbeitsumfelder gelöscht
* werden, aber primär wird nur die Zuordnung zum eigenen Benutzer
* gelöscht
  IF g_caller = 'LN_WPF10'.
    l_caller = g_caller.
  ELSE.
    l_caller = 'LN1WPLF01'.
  ENDIF.

  CALL FUNCTION 'ISHMED_VM_WPLACE_DELETE'
    EXPORTING
      i_place         = rn1_scr_wpl101                      "#EC ENHOK
      i_popup         = on
      i_update_buffer = off
      i_caller        = l_caller
    IMPORTING
      e_rc            = p_rc
    TABLES
      t_messages      = lt_messages.

  DESCRIBE TABLE lt_messages.
  IF p_rc = 0.
    IF sy-tfill = 0.
*     ist die Message-Tabelle leer, dann wurden nur
*     Zuordnungen - nicht aber das Arbeitsumfeld - gelöscht
*     daher muß der letzte OK-CODE auf 'SAVE' gesetzt werden,
*     damit der Baustein nicht E_RC = 3 (Arbeitsumfeld wurde
*     gelöscht) zurückliefert!
      g_save_ok_code = 'SAVE'.
*    ELSE.
*     ist die Message-Tabelle befüllt (Success-Meldung),
*     dann wurde auch das Arbeitsumfeld gelöscht
    ENDIF.
  ENDIF.
  IF sy-tfill > 0.
    CALL FUNCTION 'ISH_WP_RETURN_MESSAGES_SEND'
      EXPORTING
        i_message_type = 'S'
      TABLES
        t_messages     = lt_messages.
  ENDIF.

ENDFORM.                               " DELETE_WPLACE

*&---------------------------------------------------------------------*
*&      Form  DELETE_WPLACE_PERS
*&---------------------------------------------------------------------*
*       Benutzerspezifische (persönliche) Einstellungen (z.B. Layouts)
*       zu allen Sichten des Arbeitsumfelds löschen (ID 12452)
*----------------------------------------------------------------------*
FORM delete_wplace_pers  CHANGING p_rc   LIKE sy-subrc.

  DATA: lt_messages      LIKE TABLE OF bapiret2,
        lt_messages_all  LIKE TABLE OF bapiret2,
        l_nwpvz          LIKE LINE OF gt_nwpvz,
        l_nwview         LIKE LINE OF gt_nwview,
        l_view           TYPE nwview,
        l_answer(1)      TYPE c,
        l_rc             TYPE sy-subrc.

  CLEAR: p_rc, l_rc, l_answer.
  REFRESH: lt_messages, lt_messages_all.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar      = text-033
      text_question = text-034
    IMPORTING
      answer        = l_answer.
  CHECK l_answer = '1'.

  LOOP AT gt_nwpvz INTO l_nwpvz.
    REFRESH lt_messages.
    READ TABLE gt_nwview INTO l_nwview
               WITH KEY viewtype = l_nwpvz-viewtype
                        viewid   = l_nwpvz-viewid.
    CHECK sy-subrc = 0.
    CLEAR l_view.
    MOVE-CORRESPONDING l_nwview TO l_view.                  "#EC ENHOK
    CALL FUNCTION 'ISHMED_VM_VIEW_PERSONAL_CHANGE'
      EXPORTING
        i_view     = l_view
        i_place    = rn1_scr_wpl101                         "#EC ENHOK
        i_vcode    = 'DEL'  " Löschen
        i_mode     = 'XXX'  " für alle Benutzer
        i_commit   = on
        i_caller   = 'LN1WPLF01'
      IMPORTING
        e_rc       = l_rc
      TABLES
        t_messages = lt_messages.
    IF l_rc <> 0.
      p_rc = l_rc.
    ENDIF.
    DESCRIBE TABLE lt_messages.
    IF sy-tfill > 0.
      APPEND LINES OF lt_messages TO lt_messages_all.
    ENDIF.
  ENDLOOP.

  DESCRIBE TABLE lt_messages_all.
  IF sy-tfill > 0.
    CALL FUNCTION 'ISH_WP_RETURN_MESSAGES_SEND'
      EXPORTING
        i_message_type = 'S'
      TABLES
        t_messages     = lt_messages_all.
  ENDIF.

ENDFORM.                               " DELETE_WPLACE_PERS

*&---------------------------------------------------------------------*
*&      Form  TRANSPORT_WPLACE
*&---------------------------------------------------------------------*
*       Arbeitsumfeld transportieren                        ID 6682
*----------------------------------------------------------------------*
FORM transport_wplace.

  DATA: l_program   LIKE sy-repid,
        lt_nwplace  LIKE TABLE OF nwplace WITH HEADER LINE.

  CLEAR l_program.
  CLEAR lt_nwplace. REFRESH lt_nwplace.

  lt_nwplace = rn1_scr_wpl101.
  APPEND lt_nwplace.

  CALL FUNCTION 'ISH_WP_TRANSPORT_DIALOG'
    EXPORTING
      ss_program       = l_program
    TABLES
      ss_nwplace       = lt_nwplace
*     SS_NWVIEW        =
    EXCEPTIONS
      error            = 1
      canceled         = 2
      nothing_selected = 3
      OTHERS           = 4.
  CASE sy-subrc.
    WHEN 0.
      MESSAGE s574.
*     Arbeitsumfeld wurde erfolgreich an einen Transportauftrag gehängt
    WHEN 1.
      MESSAGE s573.
*     Es ist ein Fehler beim Transport des Arbeitsumfelds aufgetreten
    WHEN OTHERS.
*     Canceled
  ENDCASE.

ENDFORM.                               " TRANSPORT_WPLACE

*&---------------------------------------------------------------------*
*&      Form  PLACE_USER_ZUO
*&---------------------------------------------------------------------*
*       Arbeitsumfeld einem Benutzer zuordnen
*----------------------------------------------------------------------*
*      -->P_USER         Benutzer
*      -->P_AGR_NAME     Rolle (Gruppe)
*      -->P_PLACE        Arbeitsumfeld
*      -->P_PLACE_TXT    Arbeitsumfeldbezeichnung
*      -->P_PLACE_PRIO   Priorität der Zuordnung
*      -->P_COMMIT       Commit Work (ON/OFF)
*      -->P_UPDATE_TASK  Verbuchung 'in update task' (ON/OFF)
*      -->P_CHANGE       Bestehende Zuordnung ändern (ON/OFF)  ID 9747
*----------------------------------------------------------------------*
FORM place_user_zuo USING   value(p_user)        LIKE sy-uname
                            value(p_agr_name)    LIKE nwpusz-agr_name
                            value(p_place)       LIKE nwplace
                            value(p_place_txt)   LIKE nwplacet-txt
                            value(p_place_prio)  LIKE nwpusz-prio
                            value(p_commit)      TYPE ish_on_off
                            value(p_update_task) TYPE ish_on_off
                            value(p_change)      TYPE ish_on_off.

  DATA: l_wa_nwpusz    LIKE nwpusz,                         "#EC NEEDED
        l_wa_nwpuszt   LIKE nwpuszt,                        "#EC NEEDED
        l_nwpusz       LIKE vnwpusz,
        l_nwpuszt      LIKE vnwpuszt,
        lt_n_nwpusz    LIKE TABLE OF vnwpusz,
        lt_o_nwpusz    LIKE TABLE OF vnwpusz,
        lt_n_nwpuszt   LIKE TABLE OF vnwpuszt,
        lt_o_nwpuszt   LIKE TABLE OF vnwpuszt.

  CLEAR:   lt_n_nwpusz, lt_o_nwpusz, lt_n_nwpuszt, lt_o_nwpuszt.
  REFRESH: lt_n_nwpusz, lt_o_nwpusz, lt_n_nwpuszt, lt_o_nwpuszt.

  SELECT * FROM nwpusz INTO l_wa_nwpusz UP TO 1 ROWS
         WHERE  wplacetype  = p_place-wplacetype
         AND    wplaceid    = p_place-wplaceid
         AND    agr_name    = p_agr_name
         AND    benutzer    = p_user.
    EXIT.
  ENDSELECT.

* Wenn noch keine Zuordnung besteht, dann zuordnen
  IF sy-subrc <> 0.
    CLEAR: l_nwpusz, l_nwpuszt.
    MOVE-CORRESPONDING p_place  TO l_nwpusz.                "#EC ENHOK
    l_nwpusz-agr_name = p_agr_name.
    l_nwpusz-benutzer = p_user.
    l_nwpusz-prio     = p_place_prio.
    MOVE-CORRESPONDING l_nwpusz TO l_nwpuszt.               "#EC ENHOK
    l_nwpuszt-spras = sy-langu.
    l_nwpuszt-txt   = p_place_txt.
    l_nwpusz-kz     = 'I'.
    SELECT * FROM nwpuszt INTO l_wa_nwpuszt UP TO 1 ROWS
           WHERE  wplacetype  = p_place-wplacetype
           AND    wplaceid    = p_place-wplaceid
           AND    agr_name    = p_agr_name
           AND    benutzer    = p_user
           AND    spras       = sy-langu.
      EXIT.
    ENDSELECT.
    IF sy-subrc <> 0.
      l_nwpuszt-kz  = 'I'.
    ELSE.
      l_nwpuszt-kz  = 'U'.
    ENDIF.
    APPEND l_nwpusz  TO lt_n_nwpusz.
    APPEND l_nwpuszt TO lt_n_nwpuszt.
  ELSE.
*   ID 9747: Bestehende Zuordnung ändern
    IF p_change = on.
      CLEAR: l_nwpusz, l_nwpuszt.
      MOVE-CORRESPONDING p_place  TO l_nwpusz.              "#EC ENHOK
      l_nwpusz-agr_name = p_agr_name.
      l_nwpusz-benutzer = p_user.
      l_nwpusz-prio     = p_place_prio.
      MOVE-CORRESPONDING l_nwpusz TO l_nwpuszt.             "#EC ENHOK
      l_nwpuszt-spras = sy-langu.
      l_nwpuszt-txt   = p_place_txt.
      l_nwpusz-kz     = 'U'.
      SELECT * FROM nwpuszt INTO l_wa_nwpuszt UP TO 1 ROWS
             WHERE  wplacetype  = p_place-wplacetype
             AND    wplaceid    = p_place-wplaceid
             AND    agr_name    = p_agr_name
             AND    benutzer    = p_user
             AND    spras       = sy-langu.
        EXIT.
      ENDSELECT.
      IF sy-subrc <> 0.
        l_nwpuszt-kz  = 'I'.
      ELSE.
        l_nwpuszt-kz  = 'U'.
      ENDIF.
      APPEND l_nwpusz  TO lt_n_nwpusz.
      APPEND l_nwpuszt TO lt_n_nwpuszt.
    ELSE.
      EXIT.
    ENDIF.
  ENDIF.

  IF p_update_task = on.
    CALL FUNCTION 'ISH_VERBUCHER_NWPUSZ' IN UPDATE TASK
      EXPORTING
        i_tcode    = sy-tcode
      TABLES
        t_n_nwpusz = lt_n_nwpusz
        t_o_nwpusz = lt_o_nwpusz.
    CALL FUNCTION 'ISH_VERBUCHER_NWPUSZT' IN UPDATE TASK
      EXPORTING
        i_tcode     = sy-tcode
      TABLES
        t_n_nwpuszt = lt_n_nwpuszt
        t_o_nwpuszt = lt_o_nwpuszt.
  ELSE.
    CALL FUNCTION 'ISH_VERBUCHER_NWPUSZ'
      EXPORTING
        i_tcode    = sy-tcode
      TABLES
        t_n_nwpusz = lt_n_nwpusz
        t_o_nwpusz = lt_o_nwpusz.
    CALL FUNCTION 'ISH_VERBUCHER_NWPUSZT'
      EXPORTING
        i_tcode     = sy-tcode
      TABLES
        t_n_nwpuszt = lt_n_nwpuszt
        t_o_nwpuszt = lt_o_nwpuszt.
  ENDIF.
  IF p_commit = on.
    COMMIT WORK AND WAIT.
  ENDIF.

ENDFORM.                               " PLACE_USER_ZUO

*&---------------------------------------------------------------------*
*&      Form  SET_LAUNCH_PAD
*&---------------------------------------------------------------------*
*       Vorschau Arbeitsumfeld (Column Tree in Container) befüllen
*       LINKE Seite des Dynpro 100
*----------------------------------------------------------------------*
FORM set_launch_pad.

  DATA: hierarchy_header   TYPE treev_hhdr.

  IF g_launchpad_container IS INITIAL.

*   create a container for the tree control
    CREATE OBJECT g_launchpad_container
      EXPORTING
        container_name              = g_container_name_lp
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
*     Fehler & beim Anlegen des Controls & (Programm &)
      MESSAGE x247(nf1) WITH sy-subrc 'G_LAUNCHPAD_CONTAINER'
                             'LN1WPLF01'.
    ENDIF.

*   setup the hierarchy header
    CLEAR hierarchy_header.
    hierarchy_header-heading = 'Vorschau Arbeitsumfeld'(012).
    hierarchy_header-width   = 80.

*   create a tree control

*   After construction, the control contains one column in the
*   hierarchy area. The name of this column
*   is defined via the constructor parameter HIERACHY_COLUMN_NAME.
    CREATE OBJECT g_launchpad_tree
      EXPORTING
        parent                      = g_launchpad_container
        node_selection_mode         = cl_gui_column_tree=>node_sel_mode_multiple
        item_selection              = on
        hierarchy_column_name       = 'View'                "#EC NOTEXT
        hierarchy_header            = hierarchy_header
      EXCEPTIONS
        cntl_system_error           = 1
        create_error                = 2
        failed                      = 3
        illegal_node_selection_mode = 4
        illegal_column_name         = 5
        lifetime_error              = 6
        OTHERS                      = 7.
    IF sy-subrc <> 0.
*     Fehler & beim Anlegen des Controls & (Programm &)
      MESSAGE x247(nf1) WITH sy-subrc 'G_LAUNCHPAD_TREE' 'LN1WPLF01'.
    ENDIF.

*   Initialize drag & drop descriptions
    CREATE OBJECT g_lpad_dd_tree.
    CALL METHOD g_lpad_dd_tree->add
      EXPORTING
        flavor     = 'view_lpad'                            "#EC NOTEXT
        dragsrc    = ' '
        droptarget = 'X'
        effect     = cl_dragdrop=>copy.
    CALL METHOD g_lpad_dd_tree->add
      EXPORTING
        flavor     = 'lpad_lpad'                            "#EC NOTEXT
        dragsrc    = 'X'
        droptarget = 'X'
        effect     = cl_dragdrop=>copy.
    CALL METHOD g_lpad_dd_tree->add
      EXPORTING
        flavor     = 'lpad_view'                            "#EC NOTEXT
        dragsrc    = 'X'
        droptarget = ' '
        effect     = cl_dragdrop=>copy.
    CALL METHOD g_lpad_dd_tree->get_handle
      IMPORTING
        handle = g_handle_lpad.

*   define events and set event handler
    PERFORM set_event_handler_launchpad.

*   set views as nodes
    PERFORM build_launchpad_nodes USING off.

  ELSE.

*   Aktualisieren
    IF g_menu_req = off AND g_dragdrop_req = off.
      PERFORM build_launchpad_nodes USING on.
    ENDIF.

  ENDIF.                  " IF g_launchpad_container IS INITIAL

ENDFORM.                               " SET_LAUNCH_PAD

*&---------------------------------------------------------------------*
*&      Form  SET_GET_PERSONAL_BUFFER
*&---------------------------------------------------------------------*
*       Den Puffer setzen ('U') oder lesen ('L','R')
*----------------------------------------------------------------------*
*      -->P_MODE   Modus ('U'pdate / 'L'oad / 'R'efresh)
*----------------------------------------------------------------------*
FORM set_get_personal_buffer USING  value(p_mode) TYPE any.

  DATA: l_wa_nwplace    LIKE v_nwplace,
        l_wa_nwpusz     LIKE v_nwpusz,
        lt_nwplace_001  LIKE TABLE OF nwplace_001.

* Aktuelle Spezialdaten für Arb.umf.typ 001 in den Puffer stellen
  REFRESH lt_nwplace_001.
  IF p_mode = 'U'.
    lt_nwplace_001[] = gt_nwplace_001[].
  ENDIF.

  IF g_vcode = g_vcode_insert AND p_mode = 'L'.
*   Bei neuem Arbeitsumfeld nichts zu lesen
  ELSE.
    CALL FUNCTION 'ISHMED_VM_PERSONAL_DATA_READ'
      EXPORTING
        i_uname              = sy-uname
        i_placetype          = rn1_scr_wpl101-wplacetype
        i_mode               = p_mode
        i_caller             = 'LN1WPLF01'
*       I_WORKFLOW           = 'X'
*       I_FAVORITES          = 'X'
        i_placeid            = rn1_scr_wpl101-wplaceid
        i_replace_substitute = off
*     IMPORTING
*       e_rc                 = l_rc
*       E_DEFAULT_VIEW       =
*       E_DEFAULT_WPLACE     =
      TABLES
        t_workplaces         = gt_nwplace
        t_views              = gt_nwview
*       T_USER_MENUS         =
*       T_USER_FAVORITES     =
*       T_MESSAGES           =
        t_nwpvz              = gt_nwpvz
        t_nwpusz             = gt_nwpusz
        t_workplaces_001     = lt_nwplace_001.
  ENDIF.

* Beim Lesen der Daten
  IF p_mode = 'L'.
*   Beim 1. Lesen die Daten in die OLD-Tabelle stellen
    IF g_first_time_100 = on.
      gt_nwpvz_old[] = gt_nwpvz[].
      SORT gt_nwpvz_old BY wplaceid sortid.
    ENDIF.
*   Beim Anlegen eines Arb.umfelds die Tabellen erstmalig befüllen
    DESCRIBE TABLE gt_nwplace.
    IF sy-tfill = 0.                   " Neues Arbeitsumfeld
      CLEAR l_wa_nwplace.
      MOVE-CORRESPONDING rn1_scr_wpl101 TO l_wa_nwplace.    "#EC ENHOK
      l_wa_nwplace-spras = sy-langu.
      l_wa_nwplace-txt   = rn1_scr_wpl100-place_txt.
      APPEND l_wa_nwplace TO gt_nwplace.
      CLEAR l_wa_nwpusz.
      MOVE-CORRESPONDING rn1_scr_wpl101 TO l_wa_nwpusz.     "#EC ENHOK
      l_wa_nwpusz-benutzer = sy-uname.
      l_wa_nwpusz-spras    = sy-langu.
      l_wa_nwpusz-txt      = rn1_scr_wpl100-place_txt.
      APPEND l_wa_nwpusz TO gt_nwpusz.
    ENDIF.
  ENDIF.

ENDFORM.                               " SET_GET_PERSONAL_BUFFER

*&---------------------------------------------------------------------*
*&      Form  UPDATE_GT_NWPLACE
*&---------------------------------------------------------------------*
*       Globale Arbeitsumfeldtabelle mit geänderten Daten aktualisieren
*----------------------------------------------------------------------*
FORM update_gt_nwplace.

  DATA: l_wa_nwplace   LIKE v_nwplace.

  LOOP AT gt_nwplace INTO l_wa_nwplace.
    l_wa_nwplace-txt           = rn1_scr_wpl100-place_txt.
    l_wa_nwplace-titel_inactiv = rn1_scr_wpl101-titel_inactiv.
    MODIFY gt_nwplace FROM l_wa_nwplace.
  ENDLOOP.

ENDFORM.                               " UPDATE_GT_NWPLACE

*&---------------------------------------------------------------------*
*&      Form  CHECK_VDEFAULT
*&---------------------------------------------------------------------*
*       Default-Kz prüfen: es darf nur für 1 Sicht gesetzt werden
*----------------------------------------------------------------------*
FORM check_vdefault.

  DATA: l_wa_v_nwpvz   LIKE v_nwpvz.

  CHECK rn1_scr_wpl300-vdefault = on.

  LOOP AT gt_nwpvz INTO l_wa_v_nwpvz WHERE vdefault = on.
    IF l_wa_v_nwpvz-viewtype   = rn1_scr_wpl300-viewtype   AND
       l_wa_v_nwpvz-viewid     = rn1_scr_wpl300-viewid     AND
       l_wa_v_nwpvz-wplacetype = rn1_scr_wpl300-wplacetype AND
       l_wa_v_nwpvz-wplaceid   = rn1_scr_wpl300-wplaceid.
      CONTINUE.
    ENDIF.
    SET CURSOR FIELD 'RN1_SCR_WPL300-VDEFAULT'.
    MESSAGE e382 WITH l_wa_v_nwpvz-txt.
*   Das Default-Kennzeichen darf nur bei einer Sicht gesetzt werden
  ENDLOOP.

ENDFORM.                               " CHECK_VDEFAULT

*&---------------------------------------------------------------------*
*&      Form  CHECK_SORTID
*&---------------------------------------------------------------------*
*       SORTID prüfen: es sollen nicht doppelte SORTIDs vorkommen
*----------------------------------------------------------------------*
FORM check_sortid.

  DATA: l_wa_v_nwpvz   LIKE v_nwpvz.

  IF rn1_scr_wpl300-sortid IS INITIAL.
    SET CURSOR FIELD 'RN1_SCR_WPL300-SORTID'.
    MESSAGE e384.
*   Bitte vergeben Sie eine Priorität für die Zuordnung dieser Sicht
  ELSE.
    LOOP AT gt_nwpvz INTO l_wa_v_nwpvz WHERE sortid = rn1_scr_wpl300-sortid.
      IF l_wa_v_nwpvz-viewtype   = rn1_scr_wpl300-viewtype   AND
         l_wa_v_nwpvz-viewid     = rn1_scr_wpl300-viewid     AND
         l_wa_v_nwpvz-wplacetype = rn1_scr_wpl300-wplacetype AND
         l_wa_v_nwpvz-wplaceid   = rn1_scr_wpl300-wplaceid.
        CONTINUE.
      ENDIF.
      SET CURSOR FIELD 'RN1_SCR_WPL300-SORTID'.
      MESSAGE e383 WITH rn1_scr_wpl300-sortid l_wa_v_nwpvz-txt.
*     Die Priorität & wurde bereits bei der Sicht & vergeben
    ENDLOOP.
  ENDIF.

ENDFORM.                               " CHECK_SORTID

*&---------------------------------------------------------------------*
*&      Form  CLEAR_PERSONAL_BUFFER
*&---------------------------------------------------------------------*
*       Puffer mit Arb.umf./Sicht-Daten des Benutzers initialisieren
*----------------------------------------------------------------------*
FORM clear_personal_buffer.

  CALL FUNCTION 'ISHMED_VM_PERSONAL_DATA_READ'
    EXPORTING
      i_uname     = sy-uname
      i_placetype = rn1_scr_wpl101-wplacetype
      i_mode      = 'C'  " clear/löschen !
      i_caller    = 'LN1WPLF01'.

ENDFORM.                               " CLEAR_PERSONAL_BUFFER

*&---------------------------------------------------------------------*
*&      Form  REFRESH_VIEW_BUFFER
*&---------------------------------------------------------------------*
*       Puffer mit Sicht-Daten aktualisieren
*----------------------------------------------------------------------*
FORM refresh_view_buffer.

  DATA: l_v_nwpvz      LIKE v_nwpvz.
  DATA: lt_selvar      LIKE TABLE OF rsparams,
        lt_fvar        LIKE TABLE OF v_nwfvar,
        lt_fvar_button LIKE TABLE OF v_nwbutton,
        lt_fvar_futxt  LIKE TABLE OF v_nwfvarp,
        lt_dispvar     TYPE lvc_t_fcat,
        lt_dispsort    TYPE lvc_t_sort,
        lt_dispfilt    TYPE lvc_t_filt.

* Nur wenn sich Subscreen-Daten (OE's) geändert haben
  CHECK g_subscreen_changed = on.

  LOOP AT gt_nwpvz INTO l_v_nwpvz.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid      = l_v_nwpvz-viewid
        i_viewtype    = l_v_nwpvz-viewtype
        i_mode        = 'R'
        i_caller      = 'LN1WPLF01'
        i_placeid     = rn1_scr_wpl101-wplaceid
        i_placetype   = rn1_scr_wpl101-wplacetype
      TABLES
        t_selvar      = lt_selvar
        t_fvar        = lt_fvar
        t_fvar_button = lt_fvar_button
        t_fvar_futxt  = lt_fvar_futxt
      CHANGING
        c_dispvar     = lt_dispvar
        c_dispsort    = lt_dispsort
        c_dispfilter  = lt_dispfilt.
  ENDLOOP.

ENDFORM.                               " REFRESH_VIEW_BUFFER

*&---------------------------------------------------------------------*
*&      Form  SET_VIEW_TREE
*&---------------------------------------------------------------------*
*       Vorrat an Sichten (Column Tree in Container) befüllen
*       RECHTE Seite des Dynpro 100
*----------------------------------------------------------------------*
FORM set_view_tree.

  DATA: hierarchy_header   TYPE treev_hhdr.

  IF g_view_container IS INITIAL.

*   create a container for the tree control
    CREATE OBJECT g_view_container
      EXPORTING
        container_name              = g_container_name
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
*     Fehler & beim Anlegen des Controls & (Programm &)
      MESSAGE x247(nf1) WITH sy-subrc 'G_VIEW_CONTAINER'
                             'LN1WPLF01'.
    ENDIF.

*   setup the hierarchy header
    CLEAR hierarchy_header.
    hierarchy_header-heading = 'Vorrat an Sichten'(011).
    hierarchy_header-width   = 80.

*   create a tree control

*   After construction, the control contains one column in the
*   hierarchy area. The name of this column
*   is defined via the constructor parameter HIERACHY_COLUMN_NAME.
    CREATE OBJECT g_view_tree
      EXPORTING
        parent                      = g_view_container
        node_selection_mode         = cl_gui_column_tree=>node_sel_mode_multiple
        item_selection              = on
        hierarchy_column_name       = 'View'                "#EC NOTEXT
        hierarchy_header            = hierarchy_header
      EXCEPTIONS
        cntl_system_error           = 1
        create_error                = 2
        failed                      = 3
        illegal_node_selection_mode = 4
        illegal_column_name         = 5
        lifetime_error              = 6
        OTHERS                      = 7.
    IF sy-subrc <> 0.
*     Fehler & beim Anlegen des Controls & (Programm &)
      MESSAGE x247(nf1) WITH sy-subrc 'G_VIEW_TREE' 'LN1WPLF01'.
    ENDIF.

*   Initialize drag & drop descriptions
    CREATE OBJECT g_view_dd_tree.
    CALL METHOD g_view_dd_tree->add
      EXPORTING
        flavor     = 'view_lpad'                            "#EC NOTEXT
        dragsrc    = 'X'
        droptarget = ' '
        effect     = cl_dragdrop=>copy.
    CALL METHOD g_view_dd_tree->add
      EXPORTING
        flavor     = 'lpad_view'                            "#EC NOTEXT
        dragsrc    = ' '
        droptarget = 'X'
        effect     = cl_dragdrop=>copy.
    CALL METHOD g_view_dd_tree->get_handle
      IMPORTING
        handle = g_handle_view.

*   define events and set event handler
    PERFORM set_event_handler_viewlist.

*   set views as nodes
    PERFORM build_view_list_nodes USING off.

  ELSE.

*   Aktualisieren (bei ENTER nicht notwending)
    IF g_menu_req = off AND g_dragdrop_req = off AND
       g_save_ok_code <> 'ENTR'.
      PERFORM build_view_list_nodes USING on.
    ENDIF.

  ENDIF.                               " IF g_view_container IS INITIAL

ENDFORM.                               " SET_VIEW_TREE

*&---------------------------------------------------------------------*
*&      Form  SET_EVENT_HANDLER_VIEWLIST
*&---------------------------------------------------------------------*
*       define and set events for view list
*----------------------------------------------------------------------*
FORM set_event_handler_viewlist.

  DATA: l_event  TYPE cntl_simple_event,
        l_events TYPE cntl_simple_events.

* define the events which will be passed to the backend
* event 'node_context_menu_sel' is registered automatically
* by the control wrapper
  l_event-eventid = cl_gui_column_tree=>eventid_button_click.
  l_event-appl_event = on.
  APPEND l_event TO l_events.
  l_event-eventid = cl_gui_column_tree=>eventid_link_click.
  l_event-appl_event = on.
  APPEND l_event TO l_events.
  l_event-eventid = cl_gui_column_tree=>eventid_item_double_click.
  l_event-appl_event = on.
  APPEND l_event TO l_events.
  l_event-eventid = cl_gui_column_tree=>eventid_node_context_menu_req.
  l_event-appl_event = on.
  APPEND l_event TO l_events.

  CALL METHOD g_view_tree->set_registered_events
    EXPORTING
      events                    = l_events
    EXCEPTIONS
      cntl_error                = 1
      cntl_system_error         = 2
      illegal_event_combination = 3.
  IF sy-subrc <> 0.
    MESSAGE s700(n4) WITH 'set_registered_events' sy-subrc. "#EC NOTEXT
  ENDIF.

* assign event handlers in the application class to each desired event
  SET HANDLER lcl_view_event=>handle_item_button_click
                              FOR g_view_tree.
  SET HANDLER lcl_view_event=>handle_item_link_click
                              FOR g_view_tree.
  SET HANDLER lcl_view_event=>handle_item_double_click
                              FOR g_view_tree.
  SET HANDLER lcl_view_event=>handle_node_context_menu_req
                              FOR g_view_tree.
  SET HANDLER lcl_view_event=>handle_node_context_menu_sel
                              FOR g_view_tree.

  SET HANDLER lcl_dragdrop_receiver=>view_tree_drag
                                     FOR g_view_tree.

  SET HANDLER lcl_dragdrop_receiver=>view_tree_drop
                                     FOR g_view_tree.

ENDFORM.                               " SET_EVENT_HANDLER_VIEW_LIST

*&---------------------------------------------------------------------*
*&      Form  SET_EVENT_HANDLER_LAUNCHPAD
*&---------------------------------------------------------------------*
*       define and set events for launch pad
*----------------------------------------------------------------------*
FORM set_event_handler_launchpad.

  DATA: l_event  TYPE cntl_simple_event,
        l_events TYPE cntl_simple_events.

* define the events which will be passed to the backend
* event 'node_context_menu_sel' is registered automatically
* by the control wrapper
  l_event-eventid = cl_gui_column_tree=>eventid_button_click.
  l_event-appl_event = on.
  APPEND l_event TO l_events.
  l_event-eventid = cl_gui_column_tree=>eventid_link_click.
  l_event-appl_event = on.
  APPEND l_event TO l_events.
  l_event-eventid = cl_gui_column_tree=>eventid_item_double_click.
  l_event-appl_event = on.
  APPEND l_event TO l_events.
  l_event-eventid = cl_gui_column_tree=>eventid_node_context_menu_req.
  l_event-appl_event = on.
  APPEND l_event TO l_events.

  CALL METHOD g_launchpad_tree->set_registered_events
    EXPORTING
      events                    = l_events
    EXCEPTIONS
      cntl_error                = 1
      cntl_system_error         = 2
      illegal_event_combination = 3.
  IF sy-subrc <> 0.
    MESSAGE s700(n4) WITH 'set_registered_events' sy-subrc. "#EC NOTEXT
  ENDIF.

* assign event handlers in the application class to each desired event
  SET HANDLER lcl_view_event=>handle_item_button_click
                              FOR g_launchpad_tree.
  SET HANDLER lcl_view_event=>handle_item_link_click
                              FOR g_launchpad_tree.
  SET HANDLER lcl_view_event=>handle_item_double_click
                              FOR g_launchpad_tree.
  SET HANDLER lcl_view_event=>handle_node_context_menu_req
                              FOR g_launchpad_tree.
  SET HANDLER lcl_view_event=>handle_node_context_menu_sel
                              FOR g_launchpad_tree.

  SET HANDLER lcl_dragdrop_receiver=>launchpad_drag
                                     FOR g_launchpad_tree.

  SET HANDLER lcl_dragdrop_receiver=>launchpad_drop
                                     FOR g_launchpad_tree.

ENDFORM.                               " SET_EVENT_HANDLER_LAUNCHPAD

*&---------------------------------------------------------------------*
*&      Form  BUILD_VIEW_LIST_NODES
*&---------------------------------------------------------------------*
*       building view list as nodes in a tree control
*----------------------------------------------------------------------*
*       -->  p_refresh    update nodes and items ON/OFF
*----------------------------------------------------------------------*
FORM build_view_list_nodes USING value(p_refresh)    TYPE ish_on_off.

  DATA: node_table         TYPE treev_ntab,
        item_table         TYPE item_table_type,
        lt_range_viewvar   TYPE TABLE OF rnrangeviewtype,
        ls_range_viewvar   LIKE LINE OF lt_range_viewvar,
        lt_exp_nodes       TYPE treev_nks,
        l_exp_node_key     LIKE treev_node-node_key,
        lt_viewtypes_exp   LIKE TABLE OF nwview,
        l_viewtype_exp     LIKE nwview,
        l_view             TYPE v_nwview,
        l_wa_view          TYPE v_nwview,                   "#EC NEEDED
        l_viewtype         TYPE nwview-viewtype,
        l_viewtype_txt(60) TYPE c,
        l_ishmed_used      TYPE ish_on_off,
        l_acm_active       TYPE ish_on_off,                 " MED-31201
        last_view_type     LIKE nwview-viewtype,
        l_top_node_id      LIKE nwview-viewid,
        l_top_node_type    LIKE nwview-viewtype,
        l_top_node         LIKE treev_node-node_key,
        l_top_node_last    LIKE treev_node-node_key,
        node_key           LIKE treev_node-node_key,
        node_relatkey      LIKE treev_node-relatkey,
        node_relatship     LIKE treev_node-relatship,
        node_icon          LIKE treev_node-n_image,
        node_isfolder      LIKE treev_node-isfolder,
        node_dragdropid    LIKE treev_node-dragdropid,
        tab_index(5)       TYPE n,
        lt_dom_val         TYPE TABLE OF dd07v,
        ls_dom_val         TYPE dd07v,
        l_flag             TYPE c.

  REFRESH: lt_exp_nodes, lt_viewtypes_exp.
  CLEAR: l_top_node_id, l_top_node_type, l_top_node, l_top_node_last.

  IF p_refresh = on.

*   Geöffnete Knoten beim Aktualisieren merken
    CALL METHOD g_view_tree->get_expanded_nodes
      CHANGING
        node_key_table    = lt_exp_nodes
      EXCEPTIONS
        cntl_system_error = 1
        dp_error          = 2
        failed            = 3
        OTHERS            = 4.
    IF sy-subrc <> 0.
      MESSAGE s700(n4) WITH 'GET_EXPANDED_NODES' sy-subrc.
    ENDIF.
*   get data of the selected viewtype
*   table gt_views is sorted by the views who are displayed in
*   the view list and p_node_key is the index of this sorted table
    LOOP AT lt_exp_nodes INTO l_exp_node_key.
      CHECK l_exp_node_key(2) = gc_viewtype.
      tab_index = l_exp_node_key+2(10).
      READ TABLE gt_views INTO l_view INDEX tab_index.
      CLEAR l_viewtype_exp.
      l_viewtype_exp-viewtype = l_view-viewtype.
      APPEND l_viewtype_exp TO lt_viewtypes_exp.
    ENDLOOP.
*   Beim Aktualisieren die Listenposition beibehalten
    CALL METHOD g_view_tree->get_top_node
      IMPORTING
        node_key          = l_top_node
      EXCEPTIONS
        cntl_system_error = 1
        failed            = 2
        OTHERS            = 3.
    IF sy-subrc = 0.
      CALL METHOD cl_gui_cfw=>flush.   " sonst Dump im Web-GUI
      l_top_node_last = l_top_node.
      IF l_top_node_last(2) = gc_viewid.
        tab_index = l_top_node_last+2(10).
        READ TABLE gt_views INTO l_view INDEX tab_index.
        IF sy-subrc = 0.
          l_top_node_id = l_view-viewid.
          l_top_node_type = l_view-viewtype.                " ID 12686
        ENDIF.
      ELSEIF l_top_node_last(2) = gc_viewtype.
        tab_index = l_top_node_last+2(10).
        READ TABLE gt_views INTO l_view INDEX tab_index.
        IF sy-subrc = 0.
          l_top_node_type = l_view-viewtype.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.
  REFRESH: lt_exp_nodes.

* get the actual view list
* Alle Sichten, die nicht bereits im Launch-Pad sind, sollen
* hier angezeigt werden
  CLEAR gt_views. REFRESH gt_views.
  LOOP AT gt_views_all INTO l_view.
    READ TABLE gt_nwview INTO l_wa_view
                         WITH KEY viewtype = l_view-viewtype
                                  viewid   = l_view-viewid.
    IF sy-subrc <> 0.
      APPEND l_view TO gt_views.
    ENDIF.
  ENDLOOP.

* Falls zu einem Sichttyp keine Sicht vorhanden ist,
* muß ein Dummy-Title-Node für den Sichttyp angelegt werden
  CASE rn1_scr_wpl101-wplacetype.
*   Clinical Workplace
    WHEN '001'.
*     get all viewtypes (ID 18129)
      PERFORM get_domain_values IN PROGRAM sapmn1pa
                                    TABLES lt_dom_val
                                     USING 'NVIEWTYPE'.
      PERFORM get_range_viewvar IN PROGRAM sapln1workplace
                                  CHANGING lt_range_viewvar.
      CLEAR ls_range_viewvar.                           " ID 18129 (3)
      ls_range_viewvar-sign   = 'I'.                    " ID 18129 (3)
      ls_range_viewvar-option = 'BT'.                   " ID 18129 (3)
      ls_range_viewvar-low    = '001'.                  " ID 18129 (3)
      ls_range_viewvar-high   = '099'.                  " ID 18129 (3)
      APPEND ls_range_viewvar TO lt_range_viewvar.      " ID 18129 (3)
      LOOP AT lt_dom_val INTO ls_dom_val
              WHERE domvalue_l IN lt_range_viewvar.     " ID 18129 (3)
*              WHERE domvalue_l BETWEEN '001' AND '099' " ID 18129 (3) REM
*                 OR domvalue_l IN lt_range_viewvar.    " ID 18129 (3) REM
        l_viewtype = ls_dom_val-domvalue_l.
        READ TABLE gt_views TRANSPORTING NO FIELDS
          WITH KEY viewtype = l_viewtype.
        IF sy-subrc <> 0.
          CLEAR l_view.
          l_view-viewtype = ls_dom_val-domvalue_l.
          APPEND l_view TO gt_views.
        ENDIF.
      ENDLOOP.
    WHEN OTHERS.
  ENDCASE.

* falls IS-H*MED inaktiv ist, dann bestimmte Sichttypen NICHT
* berücksichtigen
  PERFORM check_ishmed(sapln1workplace) CHANGING l_ishmed_used.

* SAP ACM - active? (MED-31201)
  CALL FUNCTION 'ISH_OUTPATIENT_ACTIVE'
    IMPORTING
      e_active = l_acm_active.
  IF l_ishmed_used = false AND l_acm_active  = off.
    DELETE gt_views WHERE viewtype = '006'.
  ENDIF.

* remove IS-H*MED-views if IS-H*MED is not active
  IF l_ishmed_used = false.
    DELETE gt_views WHERE viewtype = '004'
                       OR viewtype = '005'
*                       OR viewtype = '006'     " REM MED-31201
                       OR viewtype = '011'
                       OR viewtype = '012'
                       OR viewtype = '013'
                       OR viewtype = '014'
                       OR viewtype = '016'.
  ENDIF.

* ID 18133: Check each viewtype if it should be active or not
  CLEAR: l_wa_view.
  LOOP AT gt_views INTO l_view.
    IF l_view-viewtype <> l_wa_view-viewtype.
      PERFORM check_viewtype_active IN PROGRAM sapln1workplace
        USING    l_view-viewtype
        CHANGING l_flag.
      IF l_flag = off.
        DELETE gt_views WHERE viewtype = l_view-viewtype.
      ENDIF.
    ENDIF.
    l_wa_view = l_view.
  ENDLOOP.

* building up tree with all defined view list
  SORT gt_views BY viewtype txt viewid.
  CLEAR last_view_type.
  LOOP AT gt_views INTO l_view.
    tab_index = sy-tabix.
    IF l_view-viewtype NE last_view_type.
      last_view_type = l_view-viewtype.
*     displaying a title node (viewtype)
*     -> node_key = 'ty00001'
      CLEAR: node_relatkey.
      CONCATENATE gc_viewtype tab_index INTO node_key.
      CLEAR node_icon.
      node_isfolder   = on.
      node_dragdropid = g_handle_view.
      PERFORM get_domain_value_desc(sapmn1pa)
                                   USING 'NVIEWTYPE' l_view-viewtype
                                                     l_viewtype_txt.
      PERFORM title_node_create TABLES node_table    item_table
                                USING  node_key      node_icon
                                       node_isfolder node_dragdropid
                                       l_viewtype_txt.
      node_relatkey = node_key.
*     append title node for expanding if required
      IF p_refresh = on.
        READ TABLE lt_viewtypes_exp INTO l_viewtype_exp WITH KEY
                                         viewtype = l_view-viewtype.
        IF sy-subrc = 0.
          l_exp_node_key = node_key.
          APPEND l_exp_node_key TO lt_exp_nodes.
        ENDIF.
*       save top node for positioning
        IF NOT l_top_node_type IS INITIAL AND
               l_top_node_type = l_view-viewtype.
          l_top_node = node_key.
        ENDIF.
      ENDIF.
    ENDIF.                   " l_view-viewtype NE last_view_type.
*   displaying an executable node (viewid)
    CHECK NOT l_view-viewid IS INITIAL.
*   -> node_key = 'id00001'
    CONCATENATE gc_viewid tab_index INTO node_key.
    node_relatship  = cl_gui_column_tree=>relat_last_child.
    node_icon       = icon_list.
    IF l_view-viewid(1) = 'S'.                " SAP standard view
      node_icon = icon_system_sap_menu.
    ENDIF.
    node_dragdropid = g_handle_view.
    PERFORM executable_node_create TABLES node_table item_table
                                   USING  node_key   node_relatkey
                                          node_relatship
                                          node_dragdropid
                                          node_icon  l_view-txt.
*   save top node for positioning
    IF NOT l_top_node_id IS INITIAL AND p_refresh = on AND
           l_top_node_id = l_view-viewid AND
           l_top_node_type = l_view-viewtype.               " ID 12686
      l_top_node = node_key.
    ENDIF.
  ENDLOOP.                             " gt_views

* add nodes and items
  CHECK sy-subrc EQ 0.
  IF p_refresh EQ on.
    CALL METHOD g_view_tree->delete_all_nodes
      EXCEPTIONS
        failed            = 1
        cntl_system_error = 2.
    IF sy-subrc <> 0.
      MESSAGE s700(n4) WITH 'DELETE_ALL_NODES' sy-subrc.
    ENDIF.
  ENDIF.
  CALL METHOD g_view_tree->add_nodes_and_items
    EXPORTING
      node_table                     = node_table
      item_table                     = item_table
      item_table_structure_name      = 'MTREEITM'
    EXCEPTIONS
      failed                         = 1
      cntl_system_error              = 3
      error_in_tables                = 4
      dp_error                       = 5
      table_structure_name_not_found = 6.
  IF sy-subrc <> 0.
    MESSAGE s700(n4) WITH 'ADD_NODES_AND_ITEMS' sy-subrc.
  ENDIF.

  IF p_refresh = on.
*   expand nodes like before
    DESCRIBE TABLE lt_exp_nodes.
    IF sy-tfill > 0.
      CALL METHOD g_view_tree->expand_nodes
        EXPORTING
          node_key_table          = lt_exp_nodes
        EXCEPTIONS
          failed                  = 1
          cntl_system_error       = 2
          error_in_node_key_table = 3
          dp_error                = 4
          OTHERS                  = 5.
      IF sy-subrc <> 0.
        MESSAGE s700(n4) WITH 'EXPAND_NODES' sy-subrc.
      ENDIF.
    ENDIF.
*  ELSE.
*   no expanded nodes on start (ID 6102)
*   expand all root nodes
*    call method g_view_tree->expand_root_nodes
*         exporting
*             level_count         = 1
*             expand_subtree      = on
*         exceptions
*             failed              = 1
*             illegal_level_count = 2
*             cntl_system_error   = 3
*             others              = 4.
*    if sy-subrc <> 0.
*      message s700(n4) with 'EXPAND_ROOT_NODES' sy-subrc.
*    endif.
  ENDIF.

* position
  IF l_top_node IS INITIAL OR p_refresh = off.
    CALL METHOD g_view_tree->scroll
      EXPORTING
        scroll_command         = cl_tree_control_base=>scroll_home
      EXCEPTIONS
        failed                 = 1
        illegal_scroll_command = 2
        cntl_system_error      = 3
        OTHERS                 = 4.
  ELSE.
    CALL METHOD g_view_tree->set_top_node
      EXPORTING
        node_key          = l_top_node
      EXCEPTIONS
        cntl_system_error = 1
        node_not_found    = 2
        failed            = 3
        OTHERS            = 4.
    CALL METHOD cl_gui_cfw=>flush.       " sonst Dump im Web-GUI
  ENDIF.

*  CALL METHOD cl_gui_column_tree=>set_focus
*       EXPORTING
*          control           = g_view_tree
*       EXCEPTIONS
*          CNTL_ERROR        = 1
*          CNTL_SYSTEM_ERROR = 2
*          others            = 3.
*  if sy-subrc <> 0.
*    message s700(n4) with 'SET_FOCUS' sy-subrc.
*  endif.

  g_menu_req     = off.
  g_dragdrop_req = off.

ENDFORM.                               " BUILD_VIEW_LIST_NODES

*&---------------------------------------------------------------------*
*&      Form  BUILD_LAUNCHPAD_NODES
*&---------------------------------------------------------------------*
*       building launchpad as nodes in a tree control
*----------------------------------------------------------------------*
*       -->  p_refresh    update nodes and items ON/OFF
*----------------------------------------------------------------------*
FORM build_launchpad_nodes USING value(p_refresh)    TYPE ish_on_off.

  DATA: node_table       TYPE treev_ntab,
        item_table       TYPE item_table_type.
  DATA: l_place          TYPE v_nwplace,
        l_nwpusz         TYPE v_nwpusz,
        l_nwpvz          TYPE v_nwpvz,
        l_view           TYPE v_nwview,
        l_viewvar        TYPE rnviewvar,
        l_refresh_dummy  TYPE rnrefresh.
  DATA: lt_selvar        TYPE TABLE OF rsparams.
  DATA: last_wp_id       LIKE nwplace-wplaceid,
        node_key         LIKE treev_node-node_key,
        node_key_default LIKE treev_node-node_key,          "#EC NEEDED
        node_relatkey    LIKE treev_node-relatkey,
        node_relatship   LIKE treev_node-relatship,
        node_icon        LIKE treev_node-n_image,
        node_isfolder    LIKE treev_node-isfolder,
        node_dragdropid  LIKE treev_node-dragdropid,
        l_top_node_id    LIKE nwview-viewid,
        l_top_node_type  LIKE nwview-viewtype,
        l_top_node       LIKE treev_node-node_key,
        l_top_node_last  LIKE treev_node-node_key,
        tab_index(5)     TYPE n,
        l_rc             LIKE sy-subrc.

  SORT gt_nwpvz BY wplaceid sortid.

  CLEAR: l_top_node_id, l_top_node_type, l_top_node, l_top_node_last.

  REFRESH: gt_nwplace_lp, gt_nwpusz_lp, gt_nwpvz_lp, gt_nwview_lp.
  gt_nwplace_lp[] = gt_nwplace[].
  gt_nwpusz_lp[]  = gt_nwpusz[].
  gt_nwpvz_lp[]   = gt_nwpvz[].
  gt_nwview_lp[]  = gt_nwview[].

  IF p_refresh = on.
*   Beim Aktualisieren die Listenposition beibehalten
    CALL METHOD g_launchpad_tree->get_top_node
      IMPORTING
        node_key          = l_top_node_last
      EXCEPTIONS
        cntl_system_error = 1
        failed            = 2
        OTHERS            = 3.
    IF sy-subrc = 0.
      CALL METHOD cl_gui_cfw=>flush.      " sonst Dump im Web-GUI
*     get data of the selected view
*     table gt_nwpvz_lp is sorted by the views who are displayed in
*     the launch pad and the node_key is the index of this sorted table
      IF l_top_node_last(2) = gc_view.
        tab_index = l_top_node_last+2(10).
        READ TABLE gt_nwpvz_lp INTO l_nwpvz INDEX tab_index.
        IF sy-subrc = 0.
          l_top_node_id = l_nwpvz-viewid.
        ENDIF.
      ELSEIF l_top_node_last(2) = gc_wplace.
        tab_index = l_top_node_last+2(10).
        READ TABLE gt_nwpvz_lp INTO l_nwpvz INDEX tab_index.
        IF sy-subrc = 0.
          l_top_node_type = l_nwpvz-wplaceid.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

* Platzhalter für OEs im Text füllen
  LOOP AT gt_nwpvz_lp INTO l_nwpvz WHERE txt CA '&'.
*   Aus Selektionsvariante holen, falls vorhanden
    CLEAR: l_viewvar, lt_selvar[].
    PERFORM get_viewvar(sapln1workplace) USING    l_nwpvz-viewtype
                                                  l_nwpvz-viewid
                                         CHANGING l_viewvar
                                                  l_refresh_dummy
                                                  l_rc.
    IF l_rc = 0 AND NOT l_viewvar-svariantid IS INITIAL.
      CALL FUNCTION 'RS_VARIANT_CONTENTS'
        EXPORTING
          report               = l_viewvar-reports
          variant              = l_viewvar-svariantid
*         MOVE_OR_WRITE        = 'W'
*         NO_IMPORT            = ' '
*       IMPORTING
*         SP                   =
        TABLES
          valutab              = lt_selvar
        EXCEPTIONS
          variant_non_existent = 1
          variant_obsolete     = 2
          OTHERS               = 3.
      IF sy-subrc = 0.
*       Ist die OE des Arbeitsumfeldes befüllt, aber die der Selektions-
*       variante leer, soll sie aus dem A.Umfeld befüllt werden
        PERFORM fill_oe_from_wplace(sapln1workplace)
                                    USING    l_nwpvz-viewtype
                                             l_nwpvz-wplacetype
                                             l_nwpvz-wplaceid
                                             g_place_001
                                    CHANGING lt_selvar.
*       Und nun die OEs ersetzen
        PERFORM refresh_oe_in_text(sapln1workplace)
                                   TABLES   lt_selvar
                                   USING    l_nwpvz-wplacetype
                                            l_nwpvz-wplaceid
                                            l_nwpvz-viewtype
                                            l_nwpvz-viewid
                                            g_place_001
                                   CHANGING l_nwpvz-txt.
      ENDIF.
    ELSE.
*     Aus Arbeitsumfeld-Spezialisierungstabelle (d.h. Puffer) ersetzen
      PERFORM fill_oe_in_text(sapln1workplace)
                              USING    l_nwpvz-wplacetype
                                       l_nwpvz-wplaceid
                                       g_place_001
                              CHANGING l_nwpvz-txt.
    ENDIF.
    MODIFY gt_nwpvz_lp FROM l_nwpvz.
  ENDLOOP.

* building up launchpad tree with all defined views
* Alle Sichten, die bereits dem Arbeitsumfeld zugeordnet sind, sollen
* hier angezeigt werden
  SORT gt_nwpusz_lp BY prio.
  CLEAR last_wp_id.
  last_wp_id = 'DUMMY_XXX1'.                                "#EC NOTEXT
  LOOP AT gt_nwpusz_lp INTO l_nwpusz.
    LOOP AT gt_nwpvz_lp INTO l_nwpvz
                     WHERE wplacetype = l_nwpusz-wplacetype
                     AND   wplaceid   = l_nwpusz-wplaceid.
      tab_index = sy-tabix.
      IF l_nwpvz-wplaceid NE last_wp_id.
        last_wp_id = l_nwpvz-wplaceid.
        READ TABLE gt_nwplace_lp INTO l_place
                   WITH KEY wplacetype = l_nwpvz-wplacetype
                            wplaceid   = l_nwpvz-wplaceid.
        CHECK sy-subrc EQ 0.
*       displaying a title node for the launch pad
*       -> node_key = 'vp00001'
        CLEAR: node_relatkey.
        IF l_place-titel_inactiv EQ off.
          CONCATENATE gc_wplace tab_index INTO node_key.
          CLEAR node_icon.
          node_isfolder   = on.
          node_dragdropid = g_handle_lpad.
          PERFORM title_node_create TABLES node_table    item_table
                                    USING  node_key      node_icon
                                           node_isfolder node_dragdropid
                                           l_place-txt.
          node_relatkey = node_key.
*         save top node for positioning
          IF NOT l_top_node_type IS INITIAL AND p_refresh = on AND
                 l_top_node_type = l_nwpvz-wplaceid.
            l_top_node = node_key.
          ENDIF.
        ENDIF.
      ENDIF.
*     read data of a single view
      READ TABLE gt_nwview_lp INTO l_view
                 WITH KEY viewid   = l_nwpvz-viewid
                          viewtype = l_nwpvz-viewtype.
      CHECK sy-subrc EQ 0.
*     displaying an executable node for the launch pad
*     -> node_key = 'vw00001'
      CONCATENATE gc_view tab_index INTO node_key.
      IF l_nwpvz-vdefault EQ on.
        node_key_default = node_key.
      ENDIF.
      IF l_place-titel_inactiv EQ on.
        CLEAR node_relatkey.           "A root node has no parent
        CLEAR node_relatship.
      ELSE.
        node_relatship = cl_gui_column_tree=>relat_last_child.
      ENDIF.
      node_icon = icon_list.
      IF l_view-viewid(1) = 'S'.                " SAP standard view
        node_icon = icon_system_sap_menu.
      ENDIF.
      node_dragdropid = g_handle_lpad.
      PERFORM executable_node_create TABLES node_table  item_table
                                     USING  node_key    node_relatkey
                                            node_relatship
                                            node_dragdropid
                                            node_icon   l_nwpvz-txt.
*     save top node for positioning
      IF NOT l_top_node_id IS INITIAL AND p_refresh = on AND
             l_top_node_id = l_nwpvz-viewid.
        l_top_node = node_key.
      ENDIF.
    ENDLOOP.
*   there is no view assigned to the work environment
    IF sy-subrc EQ 4.
      READ TABLE gt_nwplace_lp INTO l_place
                 WITH KEY wplacetype = l_nwpusz-wplacetype
                          wplaceid   = l_nwpusz-wplaceid.
      CHECK sy-subrc EQ 0.
*     displaying a title node for the launch pad
*     -> node_key = 'vp00001'
      CLEAR: node_relatkey.
      IF l_place-titel_inactiv EQ off.
        CONCATENATE gc_wplace tab_index INTO node_key.
        CLEAR: node_icon.
        node_isfolder   = on.
        node_dragdropid = g_handle_lpad.
        PERFORM title_node_create TABLES node_table    item_table
                                  USING  node_key      node_icon
                                         node_isfolder node_dragdropid
                                         l_place-txt.
      ELSE.
*       display dummy title
        CONCATENATE gc_wplace tab_index INTO node_key.
        CLEAR node_icon.
        node_icon = icon_space.
        node_isfolder   = on.
        node_dragdropid = g_handle_lpad.
        PERFORM title_node_create TABLES node_table    item_table
                                  USING  node_key      node_icon
                                         node_isfolder node_dragdropid
                                         space.
*        node_relatkey = node_key.
      ENDIF.
    ENDIF.
  ENDLOOP.

* add nodes and items
  CHECK sy-subrc EQ 0.
  IF p_refresh EQ on.
    CALL METHOD g_launchpad_tree->delete_all_nodes
      EXCEPTIONS
        failed            = 1
        cntl_system_error = 2.
    IF sy-subrc <> 0.
      MESSAGE s700(n4) WITH 'DELETE_ALL_NODES' sy-subrc.
    ENDIF.
  ENDIF.
  CALL METHOD g_launchpad_tree->add_nodes_and_items
    EXPORTING
      node_table                     = node_table
      item_table                     = item_table
      item_table_structure_name      = 'MTREEITM'
    EXCEPTIONS
      failed                         = 1
      cntl_system_error              = 3
      error_in_tables                = 4
      dp_error                       = 5
      table_structure_name_not_found = 6.
  IF sy-subrc <> 0.
    MESSAGE s700(n4) WITH 'ADD_NODES_AND_ITEMS' sy-subrc.
  ENDIF.

* expand all root nodes
  CALL METHOD g_launchpad_tree->expand_root_nodes
    EXPORTING
      level_count         = 1
      expand_subtree      = on
    EXCEPTIONS
      failed              = 1
      illegal_level_count = 2
      cntl_system_error   = 3
      OTHERS              = 4.
  IF sy-subrc <> 0.
    MESSAGE s700(n4) WITH 'EXPAND_NODE' sy-subrc.
  ENDIF.

* position
  IF l_top_node IS INITIAL OR p_refresh = off.
    CALL METHOD g_launchpad_tree->scroll
      EXPORTING
        scroll_command         = cl_tree_control_base=>scroll_home
      EXCEPTIONS
        failed                 = 1
        illegal_scroll_command = 2
        cntl_system_error      = 3
        OTHERS                 = 4.
  ELSE.
    CALL METHOD g_launchpad_tree->set_top_node
      EXPORTING
        node_key          = l_top_node
      EXCEPTIONS
        cntl_system_error = 1
        node_not_found    = 2
        failed            = 3
        OTHERS            = 4.
    CALL METHOD cl_gui_cfw=>flush.   " sonst Dump im Web-GUI
  ENDIF.

  g_menu_req     = off.
  g_dragdrop_req = off.

ENDFORM.                               " BUILD_LAUNCHPAD_NODES

*&---------------------------------------------------------------------*
*&      Form  READ_ALL_VIEWS
*&---------------------------------------------------------------------*
*       Alle Sichten für einen bestimmten Arbeitsumfeldtypen lesen
*----------------------------------------------------------------------*
*      --> P_PLACETYPE   Arbeitsumfeldtyp
*----------------------------------------------------------------------*
FORM read_all_views USING value(p_placetype) LIKE nwplace-wplacetype.

  DATA: lt_nwview         TYPE TABLE OF nwview,
        ls_nwview         LIKE LINE OF lt_nwview,
        lt_nwviewt        TYPE HASHED TABLE OF nwviewt
                               WITH UNIQUE KEY viewtype viewid spras,
        ls_nwviewt        LIKE LINE OF lt_nwviewt,
        ls_views_all      LIKE LINE OF gt_views_all,
        lt_range_viewvar  TYPE TABLE OF rnrangeviewtype.

  CLEAR:   gt_views_all.
  REFRESH: gt_views_all, lt_nwview, lt_nwviewt.

  CASE p_placetype.
    WHEN '001'.
*     Klinischer Arbeitsplatz (clinical workplace)
      PERFORM get_range_viewvar IN PROGRAM sapln1workplace
                                  CHANGING lt_range_viewvar." ID 18129
      IF lt_range_viewvar[] IS INITIAL.                      " ID 18129 (3)
        SELECT * FROM nwview INTO TABLE lt_nwview            " ID 18129 (3)  "#EC CI_GENBUFF
               WHERE  viewtype BETWEEN '001' AND '099'.      " ID 18129 (3)
      ELSE.                                                  " ID 18129 (3)
        SELECT * FROM nwview INTO TABLE lt_nwview           "#EC CI_GENBUFF
               WHERE  viewtype BETWEEN '001' AND '099'
                  OR  viewtype IN lt_range_viewvar.
      ENDIF.                                                 " ID 18129 (3)
      CHECK sy-subrc = 0.
    WHEN OTHERS.
      EXIT.
  ENDCASE.

  SELECT * FROM nwviewt INTO TABLE lt_nwviewt
         FOR ALL ENTRIES IN lt_nwview
         WHERE  viewtype  = lt_nwview-viewtype
         AND    viewid    = lt_nwview-viewid
         AND    spras     = sy-langu.
  LOOP AT lt_nwview INTO ls_nwview.
    CLEAR ls_views_all.
    MOVE-CORRESPONDING ls_nwview TO ls_views_all.           "#EC ENHOK
    READ TABLE lt_nwviewt INTO ls_nwviewt
         WITH TABLE KEY viewtype = ls_nwview-viewtype
                        viewid   = ls_nwview-viewid
                        spras    = sy-langu.
    IF sy-subrc = 0.
      ls_views_all-txt = ls_nwviewt-txt.
    ENDIF.
    ls_views_all-spras = sy-langu.
    APPEND ls_views_all TO gt_views_all.
  ENDLOOP.

ENDFORM.                               " READ_ALL_VIEWS

*&---------------------------------------------------------------------*
*&      Form  TITLE_NODE_CREATE
*&---------------------------------------------------------------------*
*       create a title node in the view list
*----------------------------------------------------------------------*
*      <-> P_NODE_TABLE
*      <-> P_ITEM_TABLE
*      --> P_NODE_KEY
*      --> P_NODE_ICON
*      --> P_NODE_ISFOLDER
*      --> P_NODE_DRAGDROPID
*      --> P_NODE_TXT
*----------------------------------------------------------------------*
FORM title_node_create TABLES p_node_table STRUCTURE treev_node"#EC *
                              p_item_table STRUCTURE mtreeitm"#EC *
                       USING  value(p_node_key)        TYPE any
                              value(p_node_icon)       TYPE any
                              value(p_node_isfolder)   TYPE any
                              value(p_node_dragdropid) TYPE any
                              value(p_node_txt)        TYPE any.

  DATA: node       TYPE treev_node,
        item       TYPE mtreeitm.

  CLEAR node.
  node-node_key   = p_node_key.
  CLEAR node-relatkey.                 " Special case: A root node has
  CLEAR node-relatship.                " no parent node.
  node-hidden     = off.
  node-disabled   = off.
  node-isfolder   = p_node_isfolder.
  node-n_image    = p_node_icon.
  node-exp_image  = p_node_icon.
  node-expander   = off.
  node-dragdropid = p_node_dragdropid.
  APPEND node TO p_node_table.

  CLEAR item.
  item-node_key   = p_node_key.
  item-item_name  = 'View'.      "#EC NOTEXT    " Item of Column 'View'
  item-class      = cl_gui_column_tree=>item_class_text.
  item-text       = p_node_txt.
  APPEND item TO p_item_table.

ENDFORM.                               " TITLE_NODE_CREATE

*&---------------------------------------------------------------------*
*&      Form  EXECUTABLE_NODE_CREATE
*&---------------------------------------------------------------------*
*       create a executable node in the view list
*----------------------------------------------------------------------*
*      <-> P_NODE_TABLE
*      <-> P_ITEM_TABLE
*      --> P_NODE_KEY
*      --> P_NODE_RELATKEY
*      --> P_NODE_RELATSHIP
*      --> P_NODE_DRAGDROPID
*      --> P_NODE_ICON
*      --> P_NODE_TXT
*----------------------------------------------------------------------*
FORM executable_node_create
                TABLES p_node_table STRUCTURE treev_node    "#EC *
                       p_item_table STRUCTURE mtreeitm      "#EC *
                USING  value(p_node_key)
                       value(p_node_relatkey)
                       value(p_node_relatship)
                       value(p_node_dragdropid)
                       value(p_node_icon)
                       value(p_node_txt).

  DATA: node       TYPE treev_node,
        item       TYPE mtreeitm.

  CLEAR node.
  node-node_key   = p_node_key.
  node-relatkey   = p_node_relatkey.
  node-relatship  = p_node_relatship.
  node-hidden     = off.
  node-disabled   = off.
  node-isfolder   = off.
  node-n_image    = p_node_icon.
  node-exp_image  = p_node_icon.
  node-expander   = off.
  node-dragdropid = p_node_dragdropid.
  APPEND node TO p_node_table.

  CLEAR item.
  item-node_key   = p_node_key.
  item-item_name  = 'View'.        "#EC NOTEXT  " Item of Column 'View'
  item-class      = cl_gui_column_tree=>item_class_button.
  IF g_buttons_in_launchpad EQ off.
    item-class = cl_gui_column_tree=>item_class_link.
  ENDIF.
  item-text       = p_node_txt.
  APPEND item TO p_item_table.

ENDFORM.                               " EXECUTABLE_NODE_CREATE

*&---------------------------------------------------------------------*
*&      Form  CALL_ZUO_POPUP
*&---------------------------------------------------------------------*
*       Popup aufrufen, um Arb.umf./Sicht-Zuordnungsdaten zu ändern
*       (nur für Sicht-Einträge im Launchpad)
*----------------------------------------------------------------------*
*      -->P_NODE_KEY  selected node of the launch pad
*----------------------------------------------------------------------*
FORM call_zuo_popup USING p_node_key TYPE any.

  DATA: l_v_nwpvz   TYPE v_nwpvz,
        l_tab_index LIKE sy-tabix.

  CHECK p_node_key(2) = gc_view.

* get data of the selected view
* table gt_nwpvz_lp is sorted by the views who are displayed in
* the launch pad and p_node_key is the index of this sorted table
  l_tab_index = p_node_key+2(10).
  READ TABLE gt_nwpvz_lp INTO l_v_nwpvz INDEX l_tab_index.

* call popup
  CALL FUNCTION 'ISHMED_VM_WPLACE_VIEW_POPUP'
    EXPORTING
      i_v_nwpvz = l_v_nwpvz.

* OK-Code auf ENTER, damit der rechte Tree (Sichtvorrat) nicht
* aktualisiert wird (Performance)
  g_save_ok_code = 'ENTR'.

ENDFORM.                               " CALL_ZUO_POPUP
*&---------------------------------------------------------------------*
*&      Form  CALL_WHERE_USED_LIST
*&---------------------------------------------------------------------*
*       call the where-use-list to a view
*----------------------------------------------------------------------*
*      -->P_NODE_KEY  selected node of the launch pad
*----------------------------------------------------------------------*
FORM call_where_used_list USING p_node_key TYPE any.

  DATA: l_v_nwpvz   TYPE v_nwpvz,
        l_v_nwview  TYPE v_nwview,
        l_view      TYPE nwview,
        l_tab_index LIKE sy-tabix.

* get data of the selected view
  l_tab_index = p_node_key+2(10).
  CASE p_node_key(2).
    WHEN gc_viewid.                    " view list
*     table gt_views is sorted by the views who are displayed in
*     the view list and p_node_key is the index of this sorted table
      READ TABLE gt_views INTO l_v_nwview INDEX l_tab_index.
      MOVE-CORRESPONDING l_v_nwview TO l_view.              "#EC ENHOK
    WHEN gc_view.                      " launchpad
*     table gt_nwpvz_lp is sorted by the views who are displayed in
*     the launch pad and p_node_key is the index of this sorted table
      READ TABLE gt_nwpvz_lp INTO l_v_nwpvz INDEX l_tab_index.
      MOVE-CORRESPONDING l_v_nwpvz TO l_view.               "#EC ENHOK
    WHEN OTHERS.
      EXIT.
  ENDCASE.

  CALL FUNCTION 'ISH_WP_WHERE_USED_LIST_VIEW'
    EXPORTING
      i_viewtype  = l_view-viewtype
      i_viewid    = l_view-viewid
      i_callback  = 'SAPLN_WP'
      i_pf_status = 'SET_PF_STATUS_VM4'
    EXCEPTIONS
      not_used    = 1
      OTHERS      = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

* OK-Code auf ENTER, damit der rechte Tree (Sichtvorrat) nicht
* aktualisiert wird (Performance)
  g_save_ok_code = 'ENTR'.

ENDFORM.                               " CALL_ZUO_POPUP

*&---------------------------------------------------------------------*
*&      Form  CALL_VIEW_DELETE
*&---------------------------------------------------------------------*
*       Sicht löschen (nur für Sicht-Einträge im Sicht-Vorrat, aber
*       falls die Sicht auch im Launchpad angezeigt wurde, muß sie
*       auch dort herausgenommen werden)
*----------------------------------------------------------------------*
*      -->P_NODE_KEY  selected node of the view list
*----------------------------------------------------------------------*
FORM call_view_delete USING  p_node_key TYPE any.

  DATA: l_v_nwview   TYPE v_nwview,
        l_view       TYPE nwview,
        l_wa_view    TYPE nwview,                           "#EC NEEDED
        l_tab_index  LIKE sy-tabix,
        l_rc         LIKE sy-subrc,
        lt_messages  LIKE TABLE OF bapiret2.

  DATA: lr_errorhandler TYPE REF TO cl_ishmed_errorhandling,
        l_rc_spec       TYPE sy-subrc,
        l_no_std        TYPE ish_on_off,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_refresh       TYPE rnrefresh,
        l_viewvar       TYPE rnviewvar.

  CHECK p_node_key(2) = gc_viewid.

* get data of the selected view
* table gt_views is sorted by the views who are displayed in
* the view list and p_node_key is the index of this sorted table
  l_tab_index = p_node_key+2(10).
  READ TABLE gt_views INTO l_v_nwview INDEX l_tab_index.
  MOVE-CORRESPONDING l_v_nwview TO l_view.                  "#EC ENHOK

* ID 18129 + MED-29864: handle ok-codes for view specific fields
  PERFORM get_viewvar(sapln1workplace) USING    l_view-viewtype
                                                l_view-viewid
                                       CHANGING l_viewvar
                                                l_refresh
                                                l_rc.
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    'VDEL'
                       '1'                          " BEFORE standard-ok-code handling
                       l_view
                       g_vcode
                       g_place_001-einri
                       l_viewvar
                       l_viewvar
                       l_refresh
                       l_refresh
                       l_rc
              CHANGING l_no_std
                       l_svar_txt
                       l_avar_txt
                       l_fvar_txt
                       l_rc_spec
                       lr_errorhandler.
  IF l_rc_spec <> 0 AND lr_errorhandler IS BOUND.
    CALL METHOD lr_errorhandler->display_messages
      EXPORTING
        i_control = on.
  ENDIF.
  CHECK l_no_std = off.

* call function to delete view
  CALL FUNCTION 'ISHMED_VM_VIEW_DELETE'
    EXPORTING
      i_place         = rn1_scr_wpl101                      "#EC ENHOK
      i_view          = l_view
      i_popup         = on
      i_update_buffer = off  " hier nicht nötig!
      i_caller        = 'LN1WPLF01'
    IMPORTING
      e_rc            = l_rc
    TABLES
      t_messages      = lt_messages.

  CALL FUNCTION 'ISH_WP_RETURN_MESSAGES_SEND'
    EXPORTING
      i_message_type = 'S'
    TABLES
      t_messages     = lt_messages.
  IF l_rc EQ 0.
*   Sicht wurde erfolgreich gelöscht
    SELECT SINGLE * FROM nwview INTO l_wa_view
           WHERE  viewtype  = l_view-viewtype
           AND    viewid    = l_view-viewid.
    IF sy-subrc <> 0.
      DELETE gt_views_all WHERE viewtype = l_view-viewtype
                            AND viewid   = l_view-viewid.
*     Sicht aus Sichtvorrat-Tree löschen
      CALL METHOD g_view_tree->delete_node
        EXPORTING
          node_key          = p_node_key
        EXCEPTIONS
          failed            = 1
          node_not_found    = 2
          cntl_system_error = 3
          OTHERS            = 4.
      IF sy-subrc <> 0.
        MESSAGE s700(n4) WITH 'DELETE_NODE' sy-subrc.
      ENDIF.
    ENDIF.
    DELETE gt_nwview    WHERE viewtype = l_view-viewtype
                          AND viewid   = l_view-viewid.
    DELETE gt_nwpvz     WHERE viewtype = l_view-viewtype
                          AND viewid   = l_view-viewid.
    DELETE gt_nwpvz_old WHERE viewtype = l_view-viewtype
                          AND viewid   = l_view-viewid.
*   Falls die Sicht dem Arb.umf. zugeordnet war -> Aktualisieren
    IF sy-subrc = 0.
*     refreshing the launchpad
      PERFORM build_launchpad_nodes USING on.
    ENDIF.
  ENDIF.

* ID 18129 + MED-29864: handle ok-codes for view specific fields
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    'VDEL'
                       '2'                          " AFTER standard-ok-code handling
                       l_view
                       g_vcode
                       g_place_001-einri
                       l_viewvar
                       l_viewvar
                       l_refresh
                       l_refresh
                       l_rc
              CHANGING l_no_std
                       l_svar_txt
                       l_avar_txt
                       l_fvar_txt
                       l_rc_spec
                       lr_errorhandler.
  IF l_rc_spec <> 0 AND lr_errorhandler IS BOUND.
    CALL METHOD lr_errorhandler->display_messages
      EXPORTING
        i_control = on.
  ENDIF.

ENDFORM.                               " CALL_VIEW_DELETE

*&---------------------------------------------------------------------*
*&      Form  CALL_VIEW_COPY
*&---------------------------------------------------------------------*
*       Sicht kopieren (nur für Sicht-Einträge im Sicht-Vorrat)
*----------------------------------------------------------------------*
*      -->P_NODE_KEY  selected node of the view list
*----------------------------------------------------------------------*
FORM call_view_copy USING  p_node_key TYPE any.

  DATA: l_v_nwview   TYPE v_nwview,
        l_view       TYPE nwview,
        lt_view      TYPE ishmed_t_nwview,
        lt_view_copy TYPE ishmed_t_nwview,
        l_viewtxt    TYPE nwviewt-txt,
        l_var_copy   TYPE char1,
        l_tab_index  LIKE sy-tabix,
        l_rc         LIKE sy-subrc,
        lt_messages  LIKE TABLE OF bapiret2.

  DATA: lr_errorhandler TYPE REF TO cl_ishmed_errorhandling,
        l_rc_spec       TYPE sy-subrc,
        l_no_std        TYPE ish_on_off,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_refresh       TYPE rnrefresh,
        l_viewvar       TYPE rnviewvar,
        l_refresh_old   TYPE rnrefresh,
        l_viewvar_old   TYPE rnviewvar.

  CHECK p_node_key(2) = gc_viewid.

* get data of the selected view
* table gt_views is sorted by the views who are displayed in
* the view list and p_node_key is the index of this sorted table
  l_tab_index = p_node_key+2(10).
  READ TABLE gt_views INTO l_v_nwview INDEX l_tab_index.
  CLEAR: l_view, l_var_copy.
  MOVE-CORRESPONDING l_v_nwview TO l_view.                  "#EC ENHOK
  REFRESH: lt_view, lt_view_copy.
  APPEND l_view TO lt_view.

  CALL FUNCTION 'ISHMED_VM_VIEW_COPY_POPUP'
    EXPORTING
      i_text          = l_v_nwview-txt
*     I_TITEL         = ' '
    IMPORTING
      e_text          = l_viewtxt
      e_variants_copy = l_var_copy
    EXCEPTIONS
      cancel          = 1
      OTHERS          = 2.
  CHECK sy-subrc = 0.

* ID 18129 + MED-29864: handle ok-codes for view specific fields
  PERFORM get_viewvar(sapln1workplace) USING    l_view-viewtype
                                                l_view-viewid
                                       CHANGING l_viewvar
                                                l_refresh
                                                l_rc.
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    'VCOP'
                       '1'                          " BEFORE standard-ok-code handling
                       l_view
                       g_vcode
                       g_place_001-einri
                       l_viewvar
                       l_viewvar
                       l_refresh
                       l_refresh
                       l_rc
              CHANGING l_no_std
                       l_svar_txt
                       l_avar_txt
                       l_fvar_txt
                       l_rc_spec
                       lr_errorhandler.
  IF l_rc_spec <> 0 AND lr_errorhandler IS BOUND.
    CALL METHOD lr_errorhandler->display_messages
      EXPORTING
        i_control = on.
  ENDIF.
  CHECK l_no_std = off.
  l_viewvar_old = l_viewvar.
  l_refresh_old = l_refresh.

* call function to copy view
  CALL FUNCTION 'ISHMED_VM_VIEW_COPY'
    EXPORTING
      it_nwviews      = lt_view
      i_variants_copy = l_var_copy
      i_view_text     = l_viewtxt
      i_placetype     = rn1_scr_wpl101-wplacetype
      i_placeid       = rn1_scr_wpl101-wplaceid
*     I_COMMIT        = 'X'
*     I_UPDATE_TASK   = ' '
      i_caller        = 'LN1WPLF01'
    IMPORTING
      e_rc            = l_rc
      et_nwviews      = lt_view_copy
    TABLES
      t_messages      = lt_messages.

  CALL FUNCTION 'ISH_WP_RETURN_MESSAGES_SEND'
    EXPORTING
      i_message_type = 'S'
    TABLES
      t_messages     = lt_messages.
  IF l_rc EQ 0.
*   Sicht wurde erfolgreich kopiert
    LOOP AT lt_view_copy INTO l_view.
      MOVE-CORRESPONDING l_view TO l_v_nwview.              "#EC ENHOK
      SELECT SINGLE txt FROM nwviewt INTO l_viewtxt
             WHERE  viewtype  = l_view-viewtype
             AND    viewid    = l_view-viewid
             AND    spras     = sy-langu.
      CHECK sy-subrc = 0.
      l_v_nwview-spras = sy-langu.
      l_v_nwview-txt   = l_viewtxt.
      APPEND l_v_nwview TO gt_views_all.
    ENDLOOP.
  ENDIF.

* ID 18129 + MED-29864: handle ok-codes for view specific fields
  PERFORM get_viewvar(sapln1workplace) USING    l_view-viewtype
                                                l_view-viewid
                                       CHANGING l_viewvar
                                                l_refresh
                                                l_rc.
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    'VCOP'
                       '2'                          " AFTER standard-ok-code handling
                       l_view
                       g_vcode
                       g_place_001-einri
                       l_viewvar_old
                       l_viewvar
                       l_refresh_old
                       l_refresh
                       l_rc
              CHANGING l_no_std
                       l_svar_txt
                       l_avar_txt
                       l_fvar_txt
                       l_rc_spec
                       lr_errorhandler.
  IF l_rc_spec <> 0 AND lr_errorhandler IS BOUND.
    CALL METHOD lr_errorhandler->display_messages
      EXPORTING
        i_control = on.
  ENDIF.

ENDFORM.                               " CALL_VIEW_COPY

*&---------------------------------------------------------------------*
*&      Form  CALL_VIEW_INSERT
*&---------------------------------------------------------------------*
*       Sicht anlegen (nur für Sichttyp-Einträge im Sicht-Vorrat)
*----------------------------------------------------------------------*
*      -->P_NODE_KEY  selected node of the view list
*      -->P_VORB      Vorbelegung des Sichttypen
*----------------------------------------------------------------------*
FORM call_view_insert USING    p_node_key       TYPE any
                               p_vorb           LIKE off.

  DATA: l_v_nwview   TYPE v_nwview,
        l_view       TYPE nwview,
        l_viewvar    TYPE rnviewvar,
        l_viewtxt    TYPE nwviewt-txt,
        l_tab_index  LIKE sy-tabix,
        l_rc         LIKE sy-subrc,
        lt_messages  LIKE TABLE OF bapiret2.

  IF p_vorb = on.
    CHECK p_node_key(2) = gc_viewtype.
*   get data of the selected viewtype
*   table gt_views is sorted by the views who are displayed in
*   the view list and p_node_key is the index of this sorted table
    l_tab_index = p_node_key+2(10).
    READ TABLE gt_views INTO l_v_nwview INDEX l_tab_index.
    MOVE-CORRESPONDING l_v_nwview TO l_view.                "#EC ENHOK
    CLEAR l_view-viewid.
  ELSE.
    CLEAR l_view.
  ENDIF.

  CASE rn1_scr_wpl101-wplacetype.
    WHEN '001'.                                  " Clinical Workplace
      CALL FUNCTION 'ISHMED_VM_VIEW_CHANGE'
        EXPORTING
          i_place        = rn1_scr_wpl101                   "#EC ENHOK
          i_view         = l_view
          i_vcode        = 'INS'
          i_place_zuo    = off  " hier nicht zuordnen!
          i_caller       = 'LN1WPLF01'
          i_sap_standard = rn1_scr_wpl100-sapstandard
        IMPORTING
          e_rc           = l_rc
          e_viewvar      = l_viewvar
          e_viewtxt      = l_viewtxt
        TABLES
          t_messages     = lt_messages.
      IF l_rc NE 0.
        CALL FUNCTION 'ISH_WP_RETURN_MESSAGES_SEND'
          EXPORTING
            i_message_type = 'S'
          TABLES
            t_messages     = lt_messages.
      ELSE.
*       Neue Sicht wurde erfolgreich angelegt
        MOVE-CORRESPONDING l_viewvar TO l_v_nwview.         "#EC ENHOK
        l_v_nwview-spras = sy-langu.
        l_v_nwview-txt   = l_viewtxt.
        APPEND l_v_nwview TO gt_views_all.
      ENDIF.
    WHEN OTHERS.                       " andere Arbeitsumfelder
      EXIT.
  ENDCASE.

ENDFORM.                               " CALL_VIEW_INSERT

*&---------------------------------------------------------------------*
*&      Form  CALL_VIEW_UPDATE
*&---------------------------------------------------------------------*
*       Sicht ändern (für Sicht-Einträge im Sicht-Vorrat u. Launchpad)
*----------------------------------------------------------------------*
*      -->P_NODE_KEY  selected node of the view list or launchpad
*----------------------------------------------------------------------*
FORM call_view_update USING    p_node_key TYPE any.

  DATA: l_v_nwview   TYPE v_nwview,
        l_view       TYPE nwview,
        l_wa_view    TYPE nwview,                           "#EC NEEDED
        l_viewvar    TYPE rnviewvar,
        l_viewtxt    LIKE nwviewt-txt,
        l_v_nwpvz    LIKE v_nwpvz,
        l_wa_v_nwpvz LIKE v_nwpvz,
        l_tab_index  LIKE sy-tabix,
        l_rc         LIKE sy-subrc,
        l_idx        LIKE sy-tabix,
        l_place_zuo  LIKE off,
        lt_nwpvz     LIKE TABLE OF v_nwpvz,
        lt_messages  LIKE TABLE OF bapiret2.

* get data of the selected view
  l_tab_index = p_node_key+2(10).
  CASE p_node_key(2).
    WHEN gc_viewid.                    " view list
*     table gt_views is sorted by the views who are displayed in
*     the view list and p_node_key is the index of this sorted table
      READ TABLE gt_views INTO l_v_nwview INDEX l_tab_index.
      MOVE-CORRESPONDING l_v_nwview TO l_view.              "#EC ENHOK
      l_place_zuo = off.
    WHEN gc_view.                      " launchpad
*     table gt_nwpvz_lp is sorted by the views who are displayed in
*     the launch pad and p_node_key is the index of this sorted table
      READ TABLE gt_nwpvz_lp INTO l_v_nwpvz INDEX l_tab_index.
      MOVE-CORRESPONDING l_v_nwpvz TO l_view.               "#EC ENHOK
      l_place_zuo = on.
    WHEN OTHERS.
      EXIT.
  ENDCASE.

  CASE rn1_scr_wpl101-wplacetype.
    WHEN '001'.                                    " Clinical Workplace
      REFRESH lt_nwpvz.
      lt_nwpvz[] = gt_nwpvz[].
      CALL FUNCTION 'ISHMED_VM_VIEW_CHANGE'
        EXPORTING
          i_place      = rn1_scr_wpl101                     "#EC ENHOK
          i_view       = l_view
          i_vcode      = 'UPD'
          i_place_zuo  = l_place_zuo
          i_caller     = 'LN1WPLF01'
          i_chk_buffer = on
        IMPORTING
          e_rc         = l_rc
          e_viewvar    = l_viewvar
          e_viewtxt    = l_viewtxt
        TABLES
          t_nwpvz_chk  = lt_nwpvz
          t_messages   = lt_messages.
      IF l_rc NE 0.
        CALL FUNCTION 'ISH_WP_RETURN_MESSAGES_SEND'
          EXPORTING
            i_message_type = 'S'
          TABLES
            t_messages     = lt_messages.
        IF l_rc = 3.
*         Sicht wurde gelöscht
*         ... trotzdem auf Existenz prüfen, den möglicherweise
*         wurde nur die Zuordnung zum Arb.umfeld gelöscht
          SELECT SINGLE * FROM nwview INTO l_wa_view
                 WHERE  viewtype  = l_view-viewtype
                 AND    viewid    = l_view-viewid.
          IF sy-subrc <> 0.
            DELETE gt_views_all WHERE viewtype = l_view-viewtype
                                  AND viewid   = l_view-viewid.
          ENDIF.
          DELETE gt_nwview    WHERE viewtype = l_view-viewtype
                                AND viewid   = l_view-viewid.
          DELETE gt_nwpvz     WHERE viewtype = l_view-viewtype
                                AND viewid   = l_view-viewid.
          DELETE gt_nwpvz_old WHERE viewtype = l_view-viewtype
                                AND viewid   = l_view-viewid.
        ENDIF.
      ELSE.
*       Sicht wurde erfolgreich geändert
        MOVE-CORRESPONDING l_viewvar TO l_view.             "#EC ENHOK
        LOOP AT gt_views_all INTO l_v_nwview
                             WHERE viewtype = l_view-viewtype
                               AND viewid   = l_view-viewid.
          MOVE-CORRESPONDING l_view TO l_v_nwview.          "#EC ENHOK
          l_v_nwview-spras = sy-langu.
          l_v_nwview-txt   = l_viewtxt.
          MODIFY gt_views_all FROM l_v_nwview.
        ENDLOOP.
        IF p_node_key(2) = gc_view.    " launchpad
          LOOP AT gt_nwview INTO l_v_nwview
                            WHERE viewtype = l_view-viewtype
                              AND viewid   = l_view-viewid.
            MOVE-CORRESPONDING l_view TO l_v_nwview.        "#EC ENHOK
            l_v_nwview-spras = sy-langu.
            l_v_nwview-txt   = l_viewtxt.
            MODIFY gt_nwview FROM l_v_nwview.
          ENDLOOP.
*         Die Zuordnung Arbeitsumfeld/Sicht im Puffer ändern
          READ TABLE gt_nwpvz INTO l_v_nwpvz WITH KEY
                     wplacetype = rn1_scr_wpl101-wplacetype
                     wplaceid   = rn1_scr_wpl101-wplaceid
                     viewtype   = l_view-viewtype
                     viewid     = l_view-viewid.
          IF sy-subrc = 0.
            l_idx = sy-tabix.
            READ TABLE lt_nwpvz INTO l_wa_v_nwpvz WITH KEY
                       wplacetype  = rn1_scr_wpl101-wplacetype
                       wplaceid    = rn1_scr_wpl101-wplaceid
                       viewtype    = l_view-viewtype
                       viewid      = l_view-viewid.
            IF sy-subrc = 0 AND NOT l_wa_v_nwpvz-sortid   IS INITIAL
                            AND NOT l_wa_v_nwpvz-txt      IS INITIAL.
              l_v_nwpvz-vdefault = l_wa_v_nwpvz-vdefault.
              l_v_nwpvz-sortid   = l_wa_v_nwpvz-sortid.
              l_v_nwpvz-txt      = l_wa_v_nwpvz-txt.
              MODIFY gt_nwpvz FROM l_v_nwpvz INDEX l_idx
                              TRANSPORTING sortid vdefault txt.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
    WHEN OTHERS.                       " andere Arbeitsumfelder
      EXIT.
  ENDCASE.

ENDFORM.                               " CALL_VIEW_UPDATE

*&---------------------------------------------------------------------*
*&      Form  INSERT_VIEW_TO_LAUNCHPAD
*&---------------------------------------------------------------------*
*       Sichten ins Launchpad insertieren
*----------------------------------------------------------------------*
FORM insert_view_to_launchpad TABLES pt_nwpvz  STRUCTURE v_nwpvz.

  DATA: start_sortid  LIKE nwpvz-sortid,
        end_sortid    LIKE nwpvz-sortid,
        next_sortid   LIKE nwpvz-sortid,
        l_wa_nwpvz    LIKE v_nwpvz,
        l_v_nwpvz     LIKE v_nwpvz,
        l_v_nwview    LIKE v_nwview.

* Bestimmen der zu insertierenden SORTIDs
  CLEAR: start_sortid, end_sortid, next_sortid.
  LOOP AT pt_nwpvz INTO l_wa_nwpvz.
    IF start_sortid IS INITIAL.
      start_sortid = l_wa_nwpvz-sortid.
    ENDIF.
    end_sortid = l_wa_nwpvz-sortid.
  ENDLOOP.
  next_sortid = end_sortid + 1.

* SORTIDs bestehender Sichten erhöhen
  LOOP AT gt_nwpvz INTO l_v_nwpvz.
*   Wird innerhalb des Launchpads verschoben, dann müssen hier
*   die 'alten' Sätze rausgelöscht werden, damit die Sichten
*   dann nicht doppelt aufscheinen
    READ TABLE pt_nwpvz INTO l_wa_nwpvz
                        WITH KEY viewtype = l_v_nwpvz-viewtype
                                 viewid   = l_v_nwpvz-viewid.
    IF sy-subrc = 0.
      DELETE gt_nwpvz.
      CONTINUE.
    ENDIF.
    CHECK l_v_nwpvz-sortid >= start_sortid.
    IF l_v_nwpvz-sortid <= next_sortid.
      l_v_nwpvz-sortid = next_sortid.
      MODIFY gt_nwpvz FROM l_v_nwpvz TRANSPORTING sortid.
      next_sortid = next_sortid + 1.
    ELSE.
      CONTINUE.
    ENDIF.
  ENDLOOP.

* Sichten mit entsprechenden SORTIDs insertieren
  LOOP AT pt_nwpvz INTO l_v_nwpvz.
    APPEND l_v_nwpvz TO gt_nwpvz.
    CLEAR l_v_nwview.
    MOVE-CORRESPONDING l_v_nwpvz TO l_v_nwview.
    APPEND l_v_nwview TO gt_nwview.
  ENDLOOP.

ENDFORM.                               " INSERT_VIEW_TO_LAUNCHPAD

*&---------------------------------------------------------------------*
*&      Form  INSERT_VIEW_TO_VIEW_TREE
*&---------------------------------------------------------------------*
*       Sichten in den Sichtvorrat insertieren
*----------------------------------------------------------------------*
FORM insert_view_to_view_tree TABLES pt_nwpvz  STRUCTURE v_nwpvz.

  DATA: l_v_nwpvz     LIKE v_nwpvz.

* Um die Sichten im Sichtvorrat zu insertieren, müssen diese nur aus
* den Launchpad-Tabellen entfernt werden
  LOOP AT pt_nwpvz INTO l_v_nwpvz.
    DELETE gt_nwview  WHERE viewtype = l_v_nwpvz-viewtype
                        AND viewid   = l_v_nwpvz-viewid.
    DELETE gt_nwpvz   WHERE viewtype = l_v_nwpvz-viewtype
                        AND viewid   = l_v_nwpvz-viewid.
  ENDLOOP.

ENDFORM.                               " INSERT_VIEW_TO_VIEW_TREE

*&---------------------------------------------------------------------*
*&      Form  read_system
*&---------------------------------------------------------------------*
* Ermitteln, in welchem System man sich befindet
*---------------------------------------------------------------------
FORM read_system.

  DATA:  sap_cus(10)   TYPE  c.

  CALL 'C_SAPGPARAM' ID 'NAME'  FIELD 'transport/systemtype'
                     ID 'VALUE' FIELD sap_cus.
  CASE sap_cus.
    WHEN  'SAP'.
      g_system_sap = on.
    WHEN OTHERS.
      g_system_sap = off.
  ENDCASE.

ENDFORM.                               " read_system
*&---------------------------------------------------------------------*
*&      Form  GET_SEL_NODES_VIEW_TREE
*&---------------------------------------------------------------------*
*      -->PT_NODES  Get selected nodes of view tree
*----------------------------------------------------------------------*
FORM get_sel_nodes_view_tree CHANGING pt_nodes TYPE lvc_t_nkey.

  REFRESH pt_nodes.

  CALL METHOD g_view_tree->get_selected_nodes
    CHANGING
      node_key_table               = pt_nodes
    EXCEPTIONS
      cntl_system_error            = 1
      dp_error                     = 2
      failed                       = 3
      multiple_node_selection_only = 4
      OTHERS                       = 5.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                               " GET_SEL_NODES_VIEW_TREE
*&---------------------------------------------------------------------*
*&      Form  GET_SEL_NODES_LAUNCHPAD
*&---------------------------------------------------------------------*
*      -->PT_NODES  Get selected nodes of launchpad
*----------------------------------------------------------------------*
FORM get_sel_nodes_launchpad CHANGING pt_nodes TYPE lvc_t_nkey.

  REFRESH pt_nodes.

  CALL METHOD g_launchpad_tree->get_selected_nodes
    CHANGING
      node_key_table               = pt_nodes
    EXCEPTIONS
      cntl_system_error            = 1
      dp_error                     = 2
      failed                       = 3
      multiple_node_selection_only = 4
      OTHERS                       = 5.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                               " GET_SEL_NODES_LAUNCHPAD
