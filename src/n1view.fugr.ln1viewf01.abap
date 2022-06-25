*----------------------------------------------------------------------*
***INCLUDE LN1VIEWF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  MODIFY_SCREEN
*&---------------------------------------------------------------------*
FORM modify_screen.

  LOOP AT SCREEN.
    CASE screen-name.
      WHEN 'RN1_SCR_VIEW100-VIEWID'.
        screen-input = false.
        screen-active = false.
      WHEN 'RN1_SCR_VIEW100-VIEWTYPE' OR
           'RN1_SCR_VIEW100-SAP_STD'  OR
           'RN1_SCR_VIEW100-CST_STD'.
        IF g_vcode = g_vcode_display OR
           g_vcode = g_vcode_update.
          screen-input = false.
        ENDIF.
        IF screen-name = 'RN1_SCR_VIEW100-SAP_STD' AND g_system_sap = off.
          screen-input = false.
        ENDIF.
      WHEN 'RN1_SCR_VIEW100-VIEWIDTXT'.
        IF g_vcode = g_vcode_display.
          screen-input = false.
        ENDIF.
      WHEN 'RN1_SCR_VIEW100-SVARID' OR
           'RN1_SCR_VIEW100-AVARID' OR
           'RN1_SCR_VIEW100-FVARID'.
        IF g_vcode = g_vcode_display.
          screen-input = false.
        ENDIF.
        screen-active = false.
      WHEN 'SVAR_BUT_INS' OR 'AVAR_BUT_INS' OR 'FVAR_BUT_INS' OR
           'SVAR_BUT_UPD' OR 'AVAR_BUT_UPD' OR 'FVAR_BUT_UPD' OR
           'SVAR_BUT_DEL' OR 'AVAR_BUT_DEL' OR 'FVAR_BUT_DEL' OR
           'SVAR_BUT_COP' OR 'AVAR_BUT_COP' OR 'FVAR_BUT_COP'.
        IF g_vcode = g_vcode_display.
          screen-active = false.
          screen-input  = false.
        ENDIF.
      WHEN 'RN1_SCR_VIEW100-ZUO_TXT'  OR 'BEZ_TXT'      OR
           'RN1_SCR_VIEW100-VDEFAULT' OR 'VDEFAULT_TXT' OR
           'RN1_SCR_VIEW100-SORTID'   OR 'SORTID_TXT'.
        IF g_vcode = g_vcode_display.
          screen-input = false.
        ENDIF.
        IF g_place_zuo = off OR g_place-wplaceid IS INITIAL.
          screen-active = false.
          screen-input  = false.
        ENDIF.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.

ENDFORM.                               " MODIFY_SCREEN

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
  IF g_vcode = g_vcode_update OR g_vcode = g_vcode_insert.
    PERFORM append_excltab USING 'ENTR'.       " Enter
  ENDIF.
  IF g_vcode = g_vcode_insert.
    PERFORM append_excltab USING 'VWREF'.       "Where-Used-List
  ENDIF.
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
*&      Form  OK_CODE_100
*&---------------------------------------------------------------------*
FORM ok_code_100.

  DATA: l_rc            TYPE sy-subrc,
        l_rc_spec       TYPE sy-subrc,
        l_no_std        TYPE ish_on_off,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_einri         TYPE einri,
        l_leave         TYPE ish_on_off,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.

  DATA: l_var_old       TYPE rnviewvar,
        l_var_new       TYPE rnviewvar.

  g_save_ok_code = ok-code.
  CLEAR ok-code.

  CLEAR l_rc.

  l_leave = off.

  CHECK g_error = off.

  PERFORM get_einri CHANGING l_einri.

* ID 18129: handle ok-codes for view specific fields (BEFORE standard-ok-code handling)
  PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    g_save_ok_code
                       '1'                          " BEFORE standard-ok-code handling
                       g_view
                       g_vcode
                       l_einri
                       l_var_old
                       l_var_new
                       gs_refresh_old
                       gs_refresh
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

  CASE g_save_ok_code.
    WHEN 'ENTR'.                       " Enter
      IF g_vcode = g_vcode_display.
        l_leave = on.
      ENDIF.
*   Sichtfunktionen
    WHEN 'SAVE'.                       " Sichern
      PERFORM save_view CHANGING l_rc.
      IF l_rc = 0.
        l_leave = on.
      ENDIF.
    WHEN 'DELE'.                       " Sicht löschen
      PERFORM delete_view CHANGING l_rc.
      IF l_rc = 0.
        l_leave = on.
      ENDIF.
    WHEN 'DELU'.                       " Benutzereinstellungen löschen
      PERFORM delete_view_pers CHANGING l_rc.
*   show the Where-Used-List to the view
    WHEN 'VWREF'.
      CALL FUNCTION 'ISH_WP_WHERE_USED_LIST_VIEW'
        EXPORTING
        i_viewtype          = g_view-viewtype
        i_viewid            = g_view-viewid
        i_callback          = 'SAPLN_WP'
        i_pf_status         = 'SET_PF_STATUS_VM4'
*       i_user_cmd          =
*       I_MARK              = ' '
      EXCEPTIONS
        not_used            = 1
        OTHERS              = 2.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
*   Selektionsvariantenfunktionen
    WHEN 'SVIN'.                       " Sel.var. anlegen
      PERFORM svar_call USING    g_vcode_insert
                        CHANGING l_rc.
    WHEN 'SVUP'.                       " Sel.var. ändern
      PERFORM svar_call USING    g_vcode_update
                        CHANGING l_rc.
    WHEN 'SVDE'.                       " Sel.var. löschen
      PERFORM svar_delete CHANGING l_rc.
    WHEN 'SVCO'.                       " Sel.var. kopieren
      PERFORM svar_copy CHANGING l_rc.
    WHEN 'SVRE'.
      PERFORM svar_ref CHANGING l_rc.
*   Anzeigevariantenfunktionen
    WHEN 'AVIN'.                       " Anz.var. anlegen
      PERFORM avar_call USING    g_vcode_insert
                        CHANGING l_rc.
    WHEN 'AVUP'.                       " Anz.var. ändern
      PERFORM avar_call USING    g_vcode_update
                        CHANGING l_rc.
    WHEN 'AVDE'.                       " Anz.var. löschen
      PERFORM avar_delete CHANGING l_rc.
    WHEN 'AVCO'.                       " Anz.var. kopieren
      PERFORM avar_copy CHANGING l_rc.
    WHEN 'AVRE'.
      PERFORM avar_ref CHANGING l_rc.
*   Funktionsvariantenfunktionen
    WHEN 'FVIN'.                       " Fkt.var. anlegen
      PERFORM fvar_call USING    g_vcode_insert
                        CHANGING l_rc.
    WHEN 'FVUP'.                       " Fkt.var. ändern
      PERFORM fvar_call USING    g_vcode_update
                        CHANGING l_rc.
    WHEN 'FVDE'.                       " Fkt.var. löschen
      PERFORM fvar_delete CHANGING l_rc.
    WHEN 'FVCO'.                       " Fkt.var. kopieren
      PERFORM fvar_copy CHANGING l_rc.
    WHEN 'FVRE'.
      PERFORM fvar_ref CHANGING l_rc.
  ENDCASE.

* ID 18129: handle ok-codes for view specific fields (AFTER standard-ok-code handling)
  PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    g_save_ok_code
                       '2'                          " AFTER standard-ok-code handling
                       g_view
                       g_vcode
                       l_einri
                       l_var_old
                       l_var_new
                       gs_refresh_old
                       gs_refresh
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

  IF l_leave = on.
    SET SCREEN 0. LEAVE SCREEN.
  ENDIF.

ENDFORM.                               " OK_CODE_100

*&---------------------------------------------------------------------*
*&      Form  SAVE_VIEW
*&---------------------------------------------------------------------*
*       Sichern der Sicht
*----------------------------------------------------------------------*
FORM save_view CHANGING p_rc   LIKE sy-subrc.

  DATA: lt_n_nwview       LIKE TABLE OF vnwview,
        lt_n_nwviewt      LIKE TABLE OF vnwviewt,
        lt_o_nwview       LIKE TABLE OF vnwview,
        lt_o_nwviewt      LIKE TABLE OF vnwviewt,
        l_wa_nwview       LIKE vnwview,
        l_wa_nwviewt      LIKE vnwviewt,
        l_nwview          LIKE nwview,                      "#EC NEEDED
        l_kz              LIKE vnwview-kz,
        l_kz_txt          LIKE vnwviewt-kz,
        l_kz_spec         LIKE vnwviewt-kz,
        l_rc              LIKE sy-subrc,
        l_key             LIKE rnwp_gen_key-nwkey,
        l_wa_msg          LIKE bapiret2.

  DATA: lt_messages       LIKE TABLE OF bapiret2.

  DATA: ls_wa_n           TYPE REF TO data,
        ls_wa_o           TYPE REF TO data,
        lt_ref_n          TYPE REF TO data,
        lt_ref_o          TYPE REF TO data,
        l_comp_kz(2)      TYPE c,
        l_comp_mandt      TYPE lvc_fname,
        l_comp_type_pg    TYPE lvc_fname,
        l_comp_id_pg      TYPE lvc_fname,
        l_dbname_dummy    TYPE lvc_tname,
        l_dbname          TYPE lvc_tname,
        l_func_name       TYPE ish_fbname.

  FIELD-SYMBOLS: <l_wa_n>      TYPE ANY,
                 <l_wa_o>      TYPE ANY,
                 <l_kz>        TYPE vnwviewt-kz,
                 <l_mandt>     TYPE vnwviewt-mandt,
                 <l_type_pg>   TYPE vnwview_014-nwplacetype_pg,
                 <l_id_pg>     TYPE vnwview_014-nwplaceid_pg,
                 <lt_n>        TYPE STANDARD TABLE,
                 <lt_o>        TYPE STANDARD TABLE.

  CLEAR:   p_rc.

  CLEAR:   lt_n_nwview, lt_n_nwviewt, lt_o_nwview, lt_o_nwviewt.
  REFRESH: lt_n_nwview, lt_n_nwviewt, lt_o_nwview, lt_o_nwviewt.
  CLEAR:   l_wa_nwview, l_wa_nwviewt.

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
  IF g_vcode_spec = g_vcode_insert.    " Insert
    l_kz_spec = 'I'.
  ELSE.                                " Update
    l_kz_spec = 'U'.
  ENDIF.

* Sicht kann sich nicht ändern, daher nur anlegen
  IF g_vcode = g_vcode_insert.
*   Schlüssel für Sichten automatisch generieren
    IF g_view_sap_std = on.
*     SAP-Sicht-Namen beginnen mit 'S'
      CALL FUNCTION 'ISHMED_VM_VIEW_SAP_STD_GET'
        EXPORTING
          i_viewtype = g_view-viewtype
        IMPORTING
          e_viewid   = g_view-viewid.
*     Prüfen, ob es bereits eine SAP-Standard-Sicht gibt
      SELECT SINGLE * FROM nwview INTO l_nwview
             WHERE  viewtype  = g_view-viewtype
             AND    viewid    = g_view-viewid.
      IF sy-subrc = 0.
        REFRESH lt_messages.
*       Für diesen Sichttypen existiert bereits eine
*       SAP-Standard-Sicht
        p_rc = 1.
        PERFORM build_bapiret2(sapmn1pa)
                USING 'I' 'NF1' '473' space
                      space space space
                      space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO lt_messages.
        PERFORM messages_send TABLES lt_messages.
        EXIT.
      ENDIF.
    ELSE.
*     Kundensicht-Namen beginnen mit 'CST'
      CALL FUNCTION 'ISHMED_VM_GENERATE_KEY'
           EXPORTING
             i_key_type       = 'V'    " View
*            i_user_specific  =
             i_placetype      = g_place-wplacetype
             i_viewtype       = g_view-viewtype
           IMPORTING
             e_key            = l_key
             e_rc             = l_rc
           TABLES
             t_messages       = lt_messages.
      IF l_rc <> 0.
*       Fehler beim Generieren des Schlüssels
        p_rc = 1.
        DESCRIBE TABLE lt_messages.
        IF sy-tfill > 0.
          LOOP AT lt_messages INTO l_wa_msg.
            l_wa_msg-type = 'I'.
            MODIFY lt_messages FROM l_wa_msg.
          ENDLOOP.
          PERFORM messages_send TABLES lt_messages.
        ENDIF.
        EXIT.
      ELSE.
        g_view-viewid = l_key.
      ENDIF.
    ENDIF.
    g_viewvar-viewid = g_view-viewid.
    MOVE-CORRESPONDING g_view TO l_wa_nwview.               "#EC ENHOK
    l_wa_nwview-kz    = l_kz.
    APPEND l_wa_nwview  TO lt_n_nwview.
  ENDIF.

* Text zur Sicht
  g_view_txt = rn1_scr_view100-viewidtxt.
  IF g_vcode_txt = g_vcode_insert OR
     rn1_scr_view100-viewidtxt <> g_view_txt_old.
*   Neue Daten
    MOVE-CORRESPONDING g_view TO l_wa_nwviewt.              "#EC ENHOK
    l_wa_nwviewt-txt   = rn1_scr_view100-viewidtxt.
    l_wa_nwviewt-spras = sy-langu.
    l_wa_nwviewt-kz    = l_kz_txt.
    APPEND l_wa_nwviewt TO lt_n_nwviewt.
*   Alte Daten
    IF g_vcode = g_vcode_update.
      CLEAR l_wa_nwviewt.
      MOVE-CORRESPONDING g_viewvar_old TO l_wa_nwviewt.     "#EC ENHOK
      l_wa_nwviewt-txt  = g_view_txt_old.
      APPEND l_wa_nwviewt TO lt_o_nwviewt.
    ENDIF.
  ENDIF.

* Aufruf der Verbucher
  DESCRIBE TABLE lt_n_nwview.
  IF sy-tfill > 0.
    CALL FUNCTION 'ISH_VERBUCHER_NWVIEW'
      EXPORTING
        i_tcode    = sy-tcode
      TABLES
        t_n_nwview = lt_n_nwview
        t_o_nwview = lt_o_nwview.
  ENDIF.

  DESCRIBE TABLE lt_n_nwviewt.
  IF sy-tfill > 0.
    CALL FUNCTION 'ISH_VERBUCHER_NWVIEWT'
      EXPORTING
        i_tcode     = sy-tcode
      TABLES
        t_n_nwviewt = lt_n_nwviewt
        t_o_nwviewt = lt_o_nwviewt.
  ENDIF.

* Varianten zur Sicht anlegen oder ändern
  IF g_vcode = g_vcode_insert OR
     g_viewvar-svariantid     <> g_viewvar_old-svariantid OR
     g_viewvar-avariantid     <> g_viewvar_old-avariantid OR
     g_viewvar-fvariantid     <> g_viewvar_old-fvariantid OR
     gs_refresh-rfsh          <> gs_refresh_old-rfsh      OR
     gs_refresh-rfsh_interval <> gs_refresh_old-rfsh_interval OR
     g_placetype_pg           <> g_placetype_pg_old       OR " ID 13398
     g_placeid_pg             <> g_placeid_pg_old.          " ID 13398
*   Varianten leer?
    IF g_viewvar-svariantid IS INITIAL.
      CLEAR: g_viewvar-reports, g_viewvar-flag1, g_viewvar-flag2.
    ENDIF.
    IF g_viewvar-avariantid IS INITIAL.
      CLEAR: g_viewvar-reporta, g_viewvar-handle, g_viewvar-log_group,
             g_viewvar-username, g_viewvar-type.
    ENDIF.
*   Je Sichttyp die spezielle Tabelle befüllen (ID 18192 chg)
    CLEAR: l_dbname, l_func_name, ls_wa_n, ls_wa_o, lt_ref_n, lt_ref_o.
    PERFORM get_view_specific IN PROGRAM sapln1workplace
                              USING      g_view-viewtype
                              CHANGING   l_dbname_dummy
                                         l_dbname
                                         l_func_name.
    IF l_dbname IS INITIAL OR l_func_name IS INITIAL.
      COMMIT WORK AND WAIT.
      EXIT.
    ENDIF.
    CREATE DATA lt_ref_n TYPE STANDARD TABLE OF (l_dbname).
    ASSIGN lt_ref_n->* TO <lt_n>.
    CREATE DATA lt_ref_o TYPE STANDARD TABLE OF (l_dbname).
    ASSIGN lt_ref_o->* TO <lt_o>.
    CREATE DATA ls_wa_n LIKE LINE OF <lt_n>.
    ASSIGN ls_wa_n->* TO <l_wa_n>.
    CREATE DATA ls_wa_o LIKE LINE OF <lt_o>.
    ASSIGN ls_wa_o->* TO <l_wa_o>.
*   Neue Daten
    CLEAR <l_wa_n>.
    MOVE-CORRESPONDING g_viewvar  TO <l_wa_n>.              "#EC ENHOK
    MOVE-CORRESPONDING gs_refresh TO <l_wa_n>.              "#EC ENHOK
*   ID 13398: viewtype 014 has 2 additional fields
    IF g_view-viewtype = '014'
      OR g_view-viewtype = '018'.                           "MED-33470
      l_comp_type_pg   = 'NWPLACETYPE_PG'.
      ASSIGN COMPONENT l_comp_type_pg OF STRUCTURE <l_wa_n>
                       TO <l_type_pg>.
      <l_type_pg>      = g_placetype_pg.
      l_comp_id_pg     = 'NWPLACEID_PG'.
      ASSIGN COMPONENT l_comp_id_pg   OF STRUCTURE <l_wa_n>
                       TO <l_id_pg>.
      <l_id_pg>        = g_placeid_pg.
    ENDIF.
*   mandant
    l_comp_mandt = 'MANDT'.
    ASSIGN COMPONENT l_comp_mandt OF STRUCTURE <l_wa_n> TO <l_mandt>.
    IF <l_mandt> IS INITIAL.
      <l_mandt> = sy-mandt.
    ENDIF.
*   update/insert flag
    l_comp_kz = 'KZ'.
    ASSIGN COMPONENT l_comp_kz OF STRUCTURE <l_wa_n> TO <l_kz>.
    <l_kz> = l_kz_spec.
    APPEND <l_wa_n> TO <lt_n>.
*   Alte Daten
    CLEAR <l_wa_o>.
    MOVE-CORRESPONDING g_viewvar_old  TO <l_wa_o>.          "#EC ENHOK
    MOVE-CORRESPONDING gs_refresh_old TO <l_wa_o>.          "#EC ENHOK
    APPEND <l_wa_o> TO <lt_o>.
*   Verbucher aufrufen
    DESCRIBE TABLE <lt_n>.
    IF sy-tfill > 0.
      CALL FUNCTION l_func_name
        EXPORTING
          i_tcode    = sy-tcode
        TABLES
          t_n_nwview = <lt_n>
          t_o_nwview = <lt_o>.
    ENDIF.
  ENDIF.

  COMMIT WORK AND WAIT.

ENDFORM.                               " SAVE_VIEW

*&---------------------------------------------------------------------*
*&      Form  DELETE_VIEW
*&---------------------------------------------------------------------*
*       Löschen einer Sicht
*----------------------------------------------------------------------*
FORM delete_view CHANGING p_rc   LIKE sy-subrc.

  DATA: lt_messages  LIKE TABLE OF bapiret2,
        l_wa_msg     LIKE bapiret2.

  CLEAR p_rc.

  CALL FUNCTION 'ISHMED_VM_VIEW_DELETE'
    EXPORTING
      i_place         = g_place
      i_view          = g_view
      i_popup         = on
      i_update_buffer = off
      i_caller        = 'LN1VIEWF01'
    IMPORTING
      e_rc            = p_rc
    TABLES
      t_messages      = lt_messages.

  DESCRIBE TABLE lt_messages.
  IF sy-tfill > 0.
    LOOP AT lt_messages INTO l_wa_msg.
      l_wa_msg-type = 'I'.
      MODIFY lt_messages FROM l_wa_msg.
    ENDLOOP.
    PERFORM messages_send TABLES lt_messages.
  ENDIF.

ENDFORM.                               " DELETE_VIEW

*&---------------------------------------------------------------------*
*&      Form  DELETE_VIEW_PERS
*&---------------------------------------------------------------------*
*       Löschen der benutzerspezifischen Einstellungen zu einer Sicht
*----------------------------------------------------------------------*
FORM delete_view_pers CHANGING p_rc   LIKE sy-subrc.

  DATA: lt_messages  LIKE TABLE OF bapiret2,
        l_wa_msg     LIKE bapiret2,
        l_answer(1)  TYPE c.

  CLEAR: p_rc, l_answer.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar      = 'Benutzerspezifische Einstellungen löschen'(034)
      text_question = 'Alle Benutzereinstellungen der Sicht löschen?'(035)
    IMPORTING
      answer        = l_answer.
  CHECK l_answer = '1'.

  CALL FUNCTION 'ISHMED_VM_VIEW_PERSONAL_CHANGE'
    EXPORTING
      i_view     = g_view
      i_place    = g_place
      i_vcode    = 'DEL'  " Löschen
      i_mode     = 'XXX'  " für alle Benutzer
      i_commit   = on
      i_caller   = 'LN1VIEWF01'
    IMPORTING
      e_rc       = p_rc
    TABLES
      t_messages = lt_messages.

  DESCRIBE TABLE lt_messages.
  IF sy-tfill > 0.
    LOOP AT lt_messages INTO l_wa_msg.
      l_wa_msg-type = 'I'.
      MODIFY lt_messages FROM l_wa_msg.
    ENDLOOP.
    PERFORM messages_send TABLES lt_messages.
  ENDIF.

ENDFORM.                               " DELETE_VIEW_PERS

*&---------------------------------------------------------------------*
*&      Form  FILL_LB_VIEWTYPE
*&---------------------------------------------------------------------*
*       Listbox mit den gültigen Sichttypen befüllen
*       (auch externe Aufrufe !!!)
*----------------------------------------------------------------------*
*      --> P_FNAME      Feldname (Sichttyp)
*      --> P_PLACETYPE  Arbeitsumfeldtyp
*----------------------------------------------------------------------*
FORM fill_lb_viewtype USING value(p_fname)     TYPE vrm_id
                            value(p_placetype) LIKE nwplace-wplacetype.

  DATA: lt_list       TYPE vrm_values.

* get texts for viewtypes from data dictionary
  PERFORM get_viewtype_texts(sapln1workplace) USING    p_placetype
                                                       on
                                              CHANGING lt_list.

* set values for listbox
  CALL FUNCTION 'VRM_SET_VALUES'
       EXPORTING
            id              = p_fname
            values          = lt_list
       EXCEPTIONS
*           id_illegal_name = 1
            OTHERS          = 0.

ENDFORM.                               " FILL_LB_VIEWTYPE

*&---------------------------------------------------------------------*
*&      Form  HELP_SVAR
*&---------------------------------------------------------------------*
*       F4-Auswahl für Selektionsvariante
*----------------------------------------------------------------------*
FORM help_svar.

  DATA: l_fname         LIKE dynpread-fieldname,
        lt_dynpr        LIKE TABLE OF dynpread WITH HEADER LINE,
        l_title(60)     TYPE c,
        l_typetext(60)  TYPE c,
        l_variantid     LIKE rnviewvar-svariantid,
        l_selvar_txt    LIKE rsvar-vtext,
        l_dummy_atxt    LIKE rn1_scr_view100-avar_txt,
        l_dummy_ftxt    LIKE rn1_scr_view100-fvar_txt,
        l_no_std        TYPE ish_on_off.

  CLEAR lt_dynpr. REFRESH lt_dynpr.

  CLEAR l_variantid.

* Beim Anlegen einer neuen Sicht ist der Sichttyp änderbar, daher muß
* hier der Dynpro-Wert geholt werden, um den korrekten Reportnamen zu
* übergeben
  IF g_vcode = g_vcode_insert.
    l_fname = 'RN1_SCR_VIEW100-VIEWTYPE'.
    lt_dynpr-fieldname = l_fname.
    APPEND lt_dynpr.
    PERFORM read_from_dynpro TABLES lt_dynpr USING '*'.
    READ TABLE lt_dynpr WITH KEY fieldname = l_fname.
    rn1_scr_view100-viewtype = lt_dynpr-fieldvalue.
    PERFORM check_viewtype.
  ENDIF.

* ID 18129: F4 for view specific variants
  PERFORM help_svar_spec USING '1' CHANGING l_no_std.
  CHECK l_no_std = off.

  PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE'
                                                g_view-viewtype
                                                l_typetext.

  CONCATENATE 'Selektionsvarianten'(004) l_typetext INTO l_title
                                                    SEPARATED BY space.

  CALL FUNCTION 'RS_VARIANT_CATALOG'
       EXPORTING
            report               = g_viewvar-reports
            new_title            = l_title
*           DYNNR                =
*           INTERNAL_CALL        = ' '
*           MASKED               = 'X'
*           VARIANT              = ' '
*           POP_UP               = ' '
       IMPORTING
            sel_variant          = l_variantid  " g_viewvar-svariantid
            sel_variant_text     = l_selvar_txt
*      TABLES
*           BELONGING_DYNNR      =
       EXCEPTIONS
            no_report            = 1
            report_not_existent  = 2
            report_not_supplied  = 3
            no_variants          = 4
            no_variant_selected  = 5
            variant_not_existent = 6
            OTHERS               = 7.
  IF sy-subrc <> 0.
    MESSAGE s229 WITH ' ' ' '.
*   Selektionsvariante & für Report & konnte nicht gef. werden
  ELSE.
    IF g_vcode = g_vcode_display OR l_variantid IS INITIAL.
      EXIT.                            " keine Änderung im Anzeigemodus
    ENDIF.
    PERFORM clear_viewbuffer_svar.
    g_viewvar-svariantid = l_variantid.
    rn1_scr_view100-svarid = g_viewvar-svariantid.
    IF l_selvar_txt IS INITIAL.
      PERFORM get_var_texts USING    on off off
                                     rn1_scr_view100-svarid
                                     rn1_scr_view100-avarid
                                     rn1_scr_view100-fvarid
                                     g_viewvar-reports g_viewvar-reporta
                                     g_viewvar-viewtype
                                     g_viewvar-viewid
                            CHANGING rn1_scr_view100-svar_txt
                                     l_dummy_atxt
                                     l_dummy_ftxt.
    ELSE.
      rn1_scr_view100-svar_txt = l_selvar_txt.
    ENDIF.
  ENDIF.

* Text der Selektionsvariante an Dynpro übergeben
  CLEAR lt_dynpr. REFRESH lt_dynpr.
  l_fname = 'RN1_SCR_VIEW100-SVAR_TXT'.
  lt_dynpr-fieldname  = l_fname.
  lt_dynpr-fieldvalue = rn1_scr_view100-svar_txt.
  APPEND lt_dynpr.
  l_fname = 'RN1_SCR_VIEW100-SVARID'.
  lt_dynpr-fieldname  = l_fname.
  lt_dynpr-fieldvalue = rn1_scr_view100-svarid.
  APPEND lt_dynpr.
  PERFORM read_from_dynpro TABLES lt_dynpr USING 'W'.

* ID 18129: F4 for view specific variants
  PERFORM help_svar_spec USING '2' CHANGING l_no_std.

ENDFORM.                               " HELP_SVAR

*&---------------------------------------------------------------------*
*&      Form  HELP_AVAR
*&---------------------------------------------------------------------*
*       F4-Auswahl für Anzeigevariante
*----------------------------------------------------------------------*
FORM help_avar.

  DATA: l_fname         LIKE dynpread-fieldname,
        lt_dynpr        LIKE TABLE OF dynpread WITH HEADER LINE,
        li_disvariant   LIKE disvariant,
        le_disvariant   LIKE disvariant,
        l_no_std        TYPE ish_on_off.

  CLEAR lt_dynpr. REFRESH lt_dynpr.

* Beim Anlegen einer neuen Sicht ist der Sichttyp änderbar, daher muß
* hier der Dynpro-Wert geholt werden, um den korrekten Reportnamen zu
* übergeben
  IF g_vcode = g_vcode_insert.
    l_fname = 'RN1_SCR_VIEW100-VIEWTYPE'.
    lt_dynpr-fieldname = l_fname.
    APPEND lt_dynpr.
    PERFORM read_from_dynpro TABLES lt_dynpr USING '*'.
    READ TABLE lt_dynpr WITH KEY fieldname = l_fname.
    rn1_scr_view100-viewtype = lt_dynpr-fieldvalue.
    PERFORM check_viewtype.
  ENDIF.

* ID 13398: viewtype 014 has a special layout (presentation variants)
  IF g_view-viewtype = '014'
    OR g_view-viewtype = '018'.                             "MED-33470
    PERFORM help_avar_pg.
    EXIT.
  ENDIF.

* ID 18129: F4 for view specific variants
  PERFORM help_avar_spec USING '1' CHANGING l_no_std.
  CHECK l_no_std = off.

  CLEAR: li_disvariant, le_disvariant.

  li_disvariant-report = g_viewvar-reporta.

  CALL FUNCTION 'LVC_VARIANT_F4'
       EXPORTING
            is_variant          = li_disvariant
*           IT_DEFAULT_FIELDCAT =
            i_save              = ' '  " no user-sp. variants!
       IMPORTING
*           E_EXIT              =
            es_variant          = le_disvariant
       EXCEPTIONS
            not_found           = 1
            program_error       = 2
            OTHERS              = 3.

  IF sy-subrc <> 0.
    MESSAGE s230 WITH ' ' ' ' sy-subrc.
*   Anzeigevariante & für Report & konnte nicht gef. werden (Fehler &)
  ELSE.
    IF g_vcode = g_vcode_display OR le_disvariant-variant IS INITIAL.
      EXIT.                            " keine Änderung im Anzeigemodus
    ENDIF.
    PERFORM clear_viewbuffer_avar.
    g_viewvar-avariantid     = le_disvariant-variant.
    g_viewvar-log_group      = le_disvariant-log_group.
    g_viewvar-username       = le_disvariant-username.
    g_viewvar-handle         = le_disvariant-handle.
    rn1_scr_view100-avarid   = le_disvariant-variant.
    rn1_scr_view100-avar_txt = le_disvariant-text.
  ENDIF.

* Text der Anzeigevariante an Dynpro übergeben
  CLEAR lt_dynpr. REFRESH lt_dynpr.
  l_fname = 'RN1_SCR_VIEW100-AVAR_TXT'.
  lt_dynpr-fieldname  = l_fname.
  lt_dynpr-fieldvalue = rn1_scr_view100-avar_txt.
  APPEND lt_dynpr.
  l_fname = 'RN1_SCR_VIEW100-AVARID'.
  lt_dynpr-fieldname  = l_fname.
  lt_dynpr-fieldvalue = rn1_scr_view100-avarid.
  APPEND lt_dynpr.
  PERFORM read_from_dynpro TABLES lt_dynpr USING 'W'.

* ID 18129: F4 for view specific variants
  PERFORM help_avar_spec USING '2' CHANGING l_no_std.

ENDFORM.                               " HELP_AVAR

*&---------------------------------------------------------------------*
*&      Form  HELP_FVAR
*&---------------------------------------------------------------------*
*       F4-Auswahl für Funktionsvariante
*----------------------------------------------------------------------*
FORM help_fvar.

  DATA: l_fname         LIKE dynpread-fieldname,
        lt_dynpr        LIKE TABLE OF dynpread WITH HEADER LINE,
        l_wa_v_nwfvar   LIKE v_nwfvar,
        l_rc            LIKE sy-subrc,
        l_no_std        TYPE ish_on_off.

* Beim Anlegen einer neuen Sicht ist der Sichttyp änderbar, daher muß
* hier der Dynpro-Wert geholt werden, um den korrekten Sichttyp zu
* übergeben
  IF g_vcode = g_vcode_insert.
    l_fname = 'RN1_SCR_VIEW100-VIEWTYPE'.
    lt_dynpr-fieldname = l_fname.
    APPEND lt_dynpr.
    PERFORM read_from_dynpro TABLES lt_dynpr USING '*'.
    READ TABLE lt_dynpr WITH KEY fieldname = l_fname.
    rn1_scr_view100-viewtype = lt_dynpr-fieldvalue.
    PERFORM check_viewtype.
  ENDIF.

* ID 18129: F4 for view specific variants
  PERFORM help_fvar_spec USING '1' CHANGING l_no_std.
  CHECK l_no_std = off.

  CALL FUNCTION 'ISHMED_VM_FVAR_F4'
    EXPORTING
      i_viewtype = g_viewvar-viewtype
    IMPORTING
      e_rc       = l_rc
      e_fvar     = l_wa_v_nwfvar.

  CASE l_rc.
    WHEN 0.                                                 " OK
      IF g_vcode = g_vcode_display.
        EXIT.                          " keine Änderung im Anzeigemodus
      ENDIF.
      IF NOT l_wa_v_nwfvar IS INITIAL.
        PERFORM clear_viewbuffer_fvar.
        g_viewvar-fvariantid     = l_wa_v_nwfvar-fvar.
        rn1_scr_view100-fvarid   = l_wa_v_nwfvar-fvar.
        rn1_scr_view100-fvar_txt = l_wa_v_nwfvar-txt.
      ELSE.
        EXIT.
      ENDIF.
    WHEN 2.                            " Cancel
      EXIT.
    WHEN OTHERS.                       " Error
      MESSAGE s359 WITH g_viewvar-viewtype.
*     Zu Sichttyp & sind keine Funktionsvarianten vorhanden
  ENDCASE.

* Text der Anzeigevariante an Dynpro übergeben
  CLEAR lt_dynpr. REFRESH lt_dynpr.
  l_fname = 'RN1_SCR_VIEW100-FVAR_TXT'.
  lt_dynpr-fieldname  = l_fname.
  lt_dynpr-fieldvalue = rn1_scr_view100-fvar_txt.
  APPEND lt_dynpr.
  l_fname = 'RN1_SCR_VIEW100-FVARID'.
  lt_dynpr-fieldname  = l_fname.
  lt_dynpr-fieldvalue = rn1_scr_view100-fvarid.
  APPEND lt_dynpr.
  PERFORM read_from_dynpro TABLES lt_dynpr USING 'W'.

* ID 18129: F4 for view specific variants
  PERFORM help_fvar_spec USING '2' CHANGING l_no_std.

ENDFORM.                               " HELP_FVAR

*&---------------------------------------------------------------------*
*&      Form  SVAR_CALL
*&---------------------------------------------------------------------*
*       Selektionsvariante anlegen oder ändern
*----------------------------------------------------------------------*
*      --> P_VCODE  Verarbeitungscode (INS oder UPD)
*----------------------------------------------------------------------*
FORM svar_call USING     value(p_vcode)  LIKE g_vcode
               CHANGING  p_rc            TYPE sy-subrc.

  DATA: l_rc            LIKE sy-subrc,
        l_read_buffer   LIKE off,
        l_update_buffer LIKE off,
        l_read_viewvar  LIKE off,
        l_svariantid    LIKE rnsvar-svariantid,
        l_viewvar       LIKE rnviewvar,
        l_cvers         TYPE ish_country,                 "note 2753930
        lt_messages     LIKE TABLE OF bapiret2 WITH HEADER LINE.

  CLEAR l_svariantid.
  CLEAR p_rc.

  call function 'ISH_COUNTRY_VERSION_GET'                 "note 2753930
    importing
      ss_cvers = l_cvers.

* Beim Anlegen einer neuen Sicht soll keine Selektionsvariante gelesen
* und der Puffer nicht befüllt werden, da dort die Sicht-ID geprüft
* wird und die ja noch nicht existiert
  IF g_vcode = g_vcode_insert.
    l_read_buffer   = off.
    l_update_buffer = off.
    l_read_viewvar  = off.
  ELSE.
    l_read_buffer   = on.
    l_update_buffer = on.
    l_read_viewvar  = on.
  ENDIF.

* Es soll jene Selektionsvariante geändert werden, die am Dynpro
* eingegeben wurde (das muß nicht jene sein, die bereits zur Sicht
* gespeichert ist), daher muß sie hier eigens übergeben werden
  IF p_vcode = g_vcode_update.
    IF g_viewvar-svariantid IS INITIAL.
      MESSAGE i354 WITH rn1_scr_view100-svarid.
*     Selektionsvariante & nicht vorhanden
      EXIT.
    ELSE.
      l_svariantid = g_viewvar-svariantid.
    ENDIF.
  ENDIF.

  CALL FUNCTION 'ISHMED_VM_SVAR_CHANGE'
       EXPORTING
            i_view          = g_view
            i_place         = g_place
            i_mode          = 'S'
            i_vcode         = p_vcode
            i_save          = ' '   " hier noch nicht zur Sicht sichern
*           I_COMMIT        = 'X'
            i_caller        = 'LN1VIEWF01'
            i_read_buffer   = l_read_buffer
            i_update_buffer = l_update_buffer
            i_read_viewvar  = l_read_viewvar
            i_svariantid    = l_svariantid
       IMPORTING
            e_rc            = l_rc
            e_viewvar       = l_viewvar
       TABLES
            t_messages      = lt_messages.

  IF l_rc = 0.
    IF NOT l_viewvar-svariantid IS INITIAL.
      rn1_scr_view100-svarid = l_viewvar-svariantid.
    ENDIF.
    if l_cvers = cv_austria.                          "note 2753930 beg
      if not l_viewvar-reports is initial.
        g_viewvar-reports = l_viewvar-reports.
      endif.
    endif.                                            "note 2753930 end
  ELSE.
    PERFORM messages_send TABLES lt_messages.
  ENDIF.
  p_rc = l_rc.

ENDFORM.                               " SVAR_CALL

*&---------------------------------------------------------------------*
*&      Form  AVAR_CALL
*&---------------------------------------------------------------------*
*       Anzeigevariante anlegen oder ändern
*----------------------------------------------------------------------*
*      --> P_VCODE  Verarbeitungscode (INS oder UPD)
*----------------------------------------------------------------------*
FORM avar_call USING     value(p_vcode)  LIKE g_vcode
               CHANGING  p_rc            TYPE sy-subrc.

  DATA: l_rc            LIKE sy-subrc,
        l_read_buffer   LIKE off,
        l_update_buffer LIKE off,
        l_read_viewvar  LIKE off,
        l_avariantid    LIKE rnavar-avariantid,
        l_viewvar       LIKE rnviewvar,
        lt_messages     LIKE TABLE OF bapiret2 WITH HEADER LINE.

  CLEAR p_rc.

* ID 13398: viewtype 014 has a special layout (presentation variants)
  IF g_view-viewtype = '014'
    OR g_view-viewtype = '018'.                             "MED-33470
    PERFORM avar_call_pg USING p_vcode CHANGING p_rc.
    EXIT.
  ENDIF.

  CLEAR l_avariantid.

* Beim Anlegen einer neuen Sicht soll keine Anzeigevariante gelesen
* und der Puffer nicht befüllt werden, da dort die Sicht-ID geprüft
* wird und die ja noch nicht existiert
  IF g_vcode = g_vcode_insert.
    l_read_buffer   = off.
    l_update_buffer = off.
    l_read_viewvar  = off.
  ELSE.
    l_read_buffer   = on.
    l_update_buffer = on.
*   ID 7145: Falls die Layout-ID nicht verändert wurde, dann sollen
*            die gepufferten Werte verwendet werden ...
    IF g_viewvar-avariantid = g_viewvar_old-avariantid.     " ID 7145
*     ID 7605: ... aber nur, wenn im Puffer nicht ein persönl. Layout
*              steht, denn das darf hier nicht bearbeitet werden
      CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
        EXPORTING
          i_viewid    = g_view-viewid
          i_viewtype  = g_view-viewtype
          i_mode      = 'L'
          i_caller    = 'LN1VIEWF01'
          i_placeid   = g_place-wplaceid
          i_placetype = g_place-wplacetype
        IMPORTING
          e_rc        = l_rc
          e_viewvar   = l_viewvar.
      IF l_rc = 0 AND l_viewvar-username IS INITIAL.        " ID 7605
        l_read_viewvar  = on.                               " ID 7145
      ELSE.                                                 " ID 7605
        l_read_viewvar  = off.                              " ID 7605
*       nicht das persönl., sondern das Layout zur Sicht ändern
        l_avariantid    = g_viewvar-avariantid.             " ID 7605
*       Puffer NICHT updaten, damit das persönl. Layout auch
*       weiter angezeigt wird.
        l_update_buffer = off.                              " ID 7605
      ENDIF.                                                " ID 7605
      CLEAR l_viewvar.                                      " ID 7605
    ELSE.                                                   " ID 7145
      l_read_viewvar = off.
    ENDIF.                                                  " ID 7145
  ENDIF.

  IF p_vcode = g_vcode_update.
*   Es soll jene Anzeigevariante geändert werden, die am Dynpro
*   eingegeben wurde (das muß nicht jene sein, die bereits zur Sicht
*   gespeichert ist), daher muß sie hier eigens übergeben werden
    IF g_viewvar-avariantid IS INITIAL.
      MESSAGE i355 WITH rn1_scr_view100-avarid.
*     Anzeigevariante & nicht vorhanden
      p_rc = 1.
      EXIT.
*    else.                                               " rem ID 7145
    ELSEIF g_viewvar-avariantid <> g_viewvar_old-avariantid. " ID 7145
      l_avariantid = g_viewvar-avariantid.
    ENDIF.
  ELSEIF p_vcode = g_vcode_insert.
*   Je nach Art der Sicht, soll die Anzeigevariante mit einem
*   bestimmten Namen gesichert oder es soll der Name automatisch
*   generiert werden
    IF g_view_sap_std = on.
      IF g_ishmed_used = true.
        l_avariantid = '1SAP_MED'.
      ELSE.
        l_avariantid = '1SAP_ISH'.
      ENDIF.
    ELSEIF g_view_cst_std = on.
      l_avariantid = '/STANDARD'.
    ELSE.
      CLEAR l_avariantid.            " automatisch generieren
    ENDIF.
  ENDIF.

  CALL FUNCTION 'ISHMED_VM_AVAR_CHANGE'
       EXPORTING
            i_view          = g_view
            i_place         = g_place
            i_mode          = 'S'
            i_vcode         = p_vcode
            i_save          = ' '   " hier noch nicht zur Sicht sichern
*           I_COMMIT        = 'X'
            i_caller        = 'LN1VIEWF01'
            i_read_buffer   = l_read_buffer
            i_update_buffer = l_update_buffer
            i_read_viewvar  = l_read_viewvar
            i_avariantid    = l_avariantid
       IMPORTING
            e_rc            = l_rc
            e_viewvar       = l_viewvar
       TABLES
            t_messages      = lt_messages.

  IF l_rc = 0.
    IF NOT l_viewvar-avariantid IS INITIAL AND
           l_viewvar-username   IS INITIAL.                 " ID 7605
      rn1_scr_view100-avarid = l_viewvar-avariantid.
    ENDIF.
  ELSE.
    PERFORM messages_send TABLES lt_messages.
  ENDIF.
  p_rc = l_rc.

ENDFORM.                               " AVAR_CALL

*&---------------------------------------------------------------------*
*&      Form  FVAR_CALL
*&---------------------------------------------------------------------*
*       Funktionsvariante anlegen oder ändern
*----------------------------------------------------------------------*
*      --> P_VCODE  Verarbeitungscode (INS oder UPD)
*----------------------------------------------------------------------*
FORM fvar_call USING     value(p_vcode)  LIKE g_vcode
               CHANGING  p_rc            TYPE sy-subrc.

  DATA: l_rc            LIKE sy-subrc,
        l_read_buffer   LIKE off,
        l_update_buffer LIKE off,
        l_read_viewvar  LIKE off,
        l_fvariantid    LIKE rnfvar-fvariantid,
        l_viewvar       LIKE rnviewvar,
        lt_messages     LIKE TABLE OF bapiret2 WITH HEADER LINE.

  CLEAR l_fvariantid.
  CLEAR p_rc.

* Beim Anlegen einer neuen Sicht soll keine Funktionsvariante gelesen
* und der Puffer nicht befüllt werden, da dort die Sicht-ID geprüft
* wird und die ja noch nicht existiert
  IF g_vcode = g_vcode_insert.
    l_read_buffer   = off.
    l_update_buffer = off.
    l_read_viewvar  = off.
  ELSE.
    l_read_buffer   = on.
    l_update_buffer = on.
    l_read_viewvar  = off.
  ENDIF.

  IF p_vcode = g_vcode_update.
*   Es soll jene Funktionsvariante geändert werden, die am Dynpro
*   eingegeben wurde (das muß nicht jene sein, die bereits zur Sicht
*   gespeichert ist), daher muß sie hier eigens übergeben werden
    IF g_viewvar-fvariantid IS INITIAL.
      MESSAGE i356 WITH rn1_scr_view100-fvarid.
*     Funktionsvariante & nicht vorhanden
      EXIT.
    ELSE.
      l_fvariantid = g_viewvar-fvariantid.
    ENDIF.
  ELSEIF p_vcode = g_vcode_insert.
*   Je nach Art der Sicht, soll die Funktionsvariante mit einem
*   bestimmten Namen gesichert oder es soll der Name automatisch
*   generiert werden
    IF g_view_sap_std = on.
      IF g_ishmed_used = true.
        l_fvariantid = 'SAP&STANDARDMED'.
      ELSE.
        l_fvariantid = 'SAP&STANDARD'.
      ENDIF.
    ELSE.
      CLEAR l_fvariantid.            " automatisch generieren
    ENDIF.
  ENDIF.

  CALL FUNCTION 'ISHMED_VM_FVAR_CHANGE'
       EXPORTING
            i_view          = g_view
            i_place         = g_place
            i_mode          = 'S'
            i_vcode         = p_vcode
            i_save          = ' '   " hier noch nicht zur Sicht sichern
*           I_COMMIT        = 'X'
            i_caller        = 'LN1VIEWF01'
            i_read_buffer   = l_read_buffer
            i_update_buffer = l_update_buffer
            i_read_viewvar  = l_read_viewvar
            i_fvariantid    = l_fvariantid
       IMPORTING
            e_rc            = l_rc
            e_viewvar       = l_viewvar
       TABLES
            t_messages      = lt_messages.

  IF l_rc = 0.
    IF NOT l_viewvar-fvariantid IS INITIAL.
      rn1_scr_view100-fvarid = l_viewvar-fvariantid.
    ENDIF.
  ELSE.
    PERFORM messages_send TABLES lt_messages.
  ENDIF.
  p_rc = l_rc.

ENDFORM.                               " FVAR_CALL

*&---------------------------------------------------------------------*
*&      Form  SVAR_DELETE
*&---------------------------------------------------------------------*
*       Selektionsvariante löschen
*       D.h. hier erst mal nur den Namen der Selektionsvariante vom
*       Dynprofeld rauslöschen
*       Beim Sichern wird dann die Selektionsvariante tatsächlich aus
*       der Sicht herausgelöscht
*       Die Selektionsvariante selbst wird hier nur gelöscht, wenn
*       sie in keiner anderen Sicht mehr verwendet wird und eine
*       entsprechende Abfrage mit Ja beantwortet wird
*----------------------------------------------------------------------*
FORM svar_delete CHANGING p_rc TYPE sy-subrc.

  DATA: l_viewvar  LIKE rnviewvar,
        l_cancel   LIKE off.

  p_rc = 0.

  IF NOT rn1_scr_view100-svarid IS INITIAL.
    CLEAR l_viewvar.
    l_viewvar-viewtype   = g_viewvar-viewtype.
    l_viewvar-viewid     = g_viewvar-viewid.
    l_viewvar-svariantid = rn1_scr_view100-svarid.
    l_viewvar-reports    = g_viewvar-reports.
    PERFORM clear_viewbuffer_svar.
    PERFORM delete_svar USING    l_viewvar on
                        CHANGING l_cancel.
    IF l_cancel = on.
      p_rc = 2.
      EXIT.
    ENDIF.
  ENDIF.

  CLEAR rn1_scr_view100-svarid.
  CLEAR g_viewvar-svariantid.

ENDFORM.                               " SVAR_DELETE

*&---------------------------------------------------------------------*
*&      Form  AVAR_DELETE
*&---------------------------------------------------------------------*
*       Anzeigevariante löschen
*       D.h. hier erst mal nur den Namen der Anzeigevariante vom
*       Dynprofeld rauslöschen
*       Beim Sichern wird dann die Anzeigevariante tatsächlich aus
*       der Sicht herausgelöscht
*       Die Anzeigevariante selbst wird hier nur gelöscht, wenn
*       sie in keiner anderen Sicht mehr verwendet wird und eine
*       entsprechende Abfrage mit Ja beantwortet wird
*----------------------------------------------------------------------*
FORM avar_delete CHANGING p_rc TYPE sy-subrc.

  DATA: l_viewvar  LIKE rnviewvar,
        l_cancel   LIKE off.

  p_rc = 0.

* ID 13398: viewtype 014 has a special layout (presentation variants)
  IF g_view-viewtype = '014'
    OR g_view-viewtype = '018'.                             "MED-33470
    PERFORM avar_delete_pg CHANGING l_cancel.
    IF l_cancel = on.
      p_rc = 2.
    ENDIF.
    EXIT.
  ENDIF.

  IF NOT rn1_scr_view100-avarid IS INITIAL.
    CLEAR l_viewvar.
    l_viewvar-viewtype   = g_viewvar-viewtype.
    l_viewvar-viewid     = g_viewvar-viewid.
    l_viewvar-avariantid = rn1_scr_view100-avarid.
    l_viewvar-reporta    = g_viewvar-reporta.
    PERFORM clear_viewbuffer_avar.
    PERFORM delete_avar USING    l_viewvar on
                        CHANGING l_cancel.
    IF l_cancel = on.
      p_rc = 2.
      EXIT.
    ENDIF.
  ENDIF.

  CLEAR rn1_scr_view100-avarid.
  CLEAR g_viewvar-avariantid.

ENDFORM.                               " AVAR_DELETE

*&---------------------------------------------------------------------*
*&      Form  FVAR_DELETE
*&---------------------------------------------------------------------*
*       Funktionsvariante löschen
*       D.h. hier erst mal nur den Namen der Funktionsvariante vom
*       Dynprofeld rauslöschen
*       Beim Sichern wird dann die Funktionsvariante tatsächlich aus
*       der Sicht herausgelöscht
*       Die Funktionsvariante selbst wird hier nur gelöscht, wenn
*       sie in keiner anderen Sicht mehr verwendet wird und eine
*       entsprechende Abfrage mit Ja beantwortet wird
*----------------------------------------------------------------------*
FORM fvar_delete CHANGING p_rc TYPE sy-subrc.

  DATA: l_viewvar  LIKE rnviewvar,
        l_cancel   LIKE off.

  p_rc = 0.

  IF NOT rn1_scr_view100-fvarid IS INITIAL.
    CLEAR l_viewvar.
    l_viewvar-viewtype   = g_viewvar-viewtype.
    l_viewvar-viewid     = g_viewvar-viewid.
    l_viewvar-fvariantid = rn1_scr_view100-fvarid.
    PERFORM clear_viewbuffer_fvar.
    PERFORM delete_fvar USING    l_viewvar on
                        CHANGING l_cancel.
    IF l_cancel = on.
      p_rc = 2.
      EXIT.
    ENDIF.
  ENDIF.

  CLEAR rn1_scr_view100-fvarid.
  CLEAR g_viewvar-fvariantid.

ENDFORM.                               " FVAR_DELETE

*&---------------------------------------------------------------------*
*&      Form  MESSAGES_SEND
*&---------------------------------------------------------------------*
*       Nachrichten ausgeben
*----------------------------------------------------------------------*
*      --> PT_MESSAGES  Nachrichten
*----------------------------------------------------------------------*
FORM messages_send TABLES pt_messages STRUCTURE bapiret2.

  DESCRIBE TABLE pt_messages.
  CHECK sy-tfill > 0.

  PERFORM init_messages(sapmn1pa).
  LOOP AT pt_messages.
    IF pt_messages-type   IS INITIAL OR
       pt_messages-id     IS INITIAL OR
       pt_messages-number IS INITIAL.
      CALL FUNCTION 'MESSAGE_STORE'
        EXPORTING
          arbgb = 'NF'
          msgty = 'I'
          txtnr = '666'
          msgv1 = pt_messages-message.
    ELSE.
      PERFORM store_message(sapmn1pa)
              USING pt_messages-type       pt_messages-id
                    pt_messages-number
                    pt_messages-message_v1 pt_messages-message_v2
                    pt_messages-message_v3 pt_messages-message_v4.
    ENDIF.
  ENDLOOP.
  PERFORM show_messages(sapmn1pa) USING ' ' on off.

  CALL FUNCTION 'MESSAGES_STOP'
    EXCEPTIONS
      OTHERS = 0.                                           "#EC *

ENDFORM.                               " MESSAGES_SEND

*&---------------------------------------------------------------------*
*&      Form  CHECK_SVAR
*&---------------------------------------------------------------------*
*       Prüfung der Selektionsvariante
*----------------------------------------------------------------------*
FORM check_svar.

  DATA: l_rc        LIKE sy-subrc,
        l_report    LIKE rsvar-report,
        l_variant   LIKE rsvar-variant,
        l_no_std    TYPE ish_on_off.

* ID 18129: check special view fields
  PERFORM check_svar_spec CHANGING l_no_std.
  CHECK l_no_std = off.

  IF NOT rn1_scr_view100-svarid IS INITIAL.

    l_report  = g_viewvar-reports.
    l_variant = rn1_scr_view100-svarid.

    CALL FUNCTION 'RS_VARIANT_EXISTS'
      EXPORTING
        report              = l_report
        variant             = l_variant
      IMPORTING
        r_c                 = l_rc
      EXCEPTIONS
        not_authorized      = 1
        no_report           = 2
        report_not_existent = 3
        report_not_supplied = 4
        OTHERS              = 5.

    IF sy-subrc <> 0 OR l_rc <> 0.
      g_error = on.
      SET CURSOR FIELD 'RN1_SCR_VIEW100-SVARID'.
      MESSAGE i354 WITH rn1_scr_view100-svarid.
*     Selektionsvariante & nicht vorhanden
      EXIT.
    ENDIF.

  ENDIF.

* Wenn die Selektionsvariante geändert wurde,
* dann den Puffer clearen
  IF g_viewvar-svariantid <> rn1_scr_view100-svarid.
    PERFORM clear_viewbuffer_svar.
  ENDIF.

  g_viewvar-svariantid = rn1_scr_view100-svarid.

ENDFORM.                               " CHECK_SVAR

*&---------------------------------------------------------------------*
*&      Form  CHECK_AVAR
*&---------------------------------------------------------------------*
*       Prüfung der Anzeigevariante
*----------------------------------------------------------------------*
FORM check_avar.

  DATA: l_variant      LIKE disvariant,
        l_no_std       TYPE ish_on_off.

* ID 13398: viewtype 014 has special layouts (presentation variants)
  IF g_view-viewtype = '014'
    OR g_view-viewtype = '018'.                             "MED-33470
    PERFORM check_avar_pg.
    EXIT.
  ELSE.
    CLEAR: g_placetype_pg, g_placeid_pg.
  ENDIF.

* ID 18129: check special view fields
  PERFORM check_avar_spec CHANGING l_no_std.
  CHECK l_no_std = off.

  CLEAR l_variant.

  IF NOT rn1_scr_view100-avarid IS INITIAL.
    l_variant-report  = g_viewvar-reporta.
    l_variant-variant = rn1_scr_view100-avarid.
    CALL FUNCTION 'LVC_VARIANT_EXISTENCE_CHECK'
      EXPORTING
        i_save        = ' '  " no user-sp. variants!
      CHANGING
        cs_variant    = l_variant
      EXCEPTIONS
        wrong_input   = 1
        not_found     = 2
        program_error = 3
        OTHERS        = 4.

    IF sy-subrc <> 0.
      g_error = on.
      SET CURSOR FIELD 'RN1_SCR_VIEW100-AVARID'.
      MESSAGE i355 WITH rn1_scr_view100-avarid.
*     Anzeigevariante & nicht vorhanden
      EXIT.
    ENDIF.
  ENDIF.

* Wenn die Anzeigevariante geändert wurde,
* dann den Puffer clearen
  IF g_viewvar-avariantid <> rn1_scr_view100-avarid.
    PERFORM clear_viewbuffer_avar.
  ENDIF.

  g_viewvar-avariantid = rn1_scr_view100-avarid.
  g_viewvar-log_group  = l_variant-log_group.
  g_viewvar-username   = l_variant-username.
  g_viewvar-handle     = l_variant-handle.

ENDFORM.                               " CHECK_AVAR

*&---------------------------------------------------------------------*
*&      Form  CHECK_FVAR
*&---------------------------------------------------------------------*
*       Prüfung der Funktionsvariante
*----------------------------------------------------------------------*
FORM check_fvar.

  DATA: l_rc           LIKE sy-subrc,
        l_no_std       TYPE ish_on_off.
  DATA: lt_fvar        LIKE TABLE OF v_nwfvar.

* ID 18129: check special view fields
  PERFORM check_fvar_spec CHANGING l_no_std.
  CHECK l_no_std = off.

  IF NOT rn1_scr_view100-fvarid IS INITIAL.

    CALL FUNCTION 'ISHMED_VM_FVAR_GET'
      EXPORTING
        i_viewtype   = g_viewvar-viewtype
        i_fvariantid = rn1_scr_view100-fvarid
      IMPORTING
        e_rc         = l_rc
      TABLES
        t_fvar       = lt_fvar.

    IF l_rc <> 0.
      g_error = on.
      SET CURSOR FIELD 'RN1_SCR_VIEW100-FVARID'.
      MESSAGE i356 WITH rn1_scr_view100-fvarid.
*     Funktionsvariante & nicht vorhanden
      EXIT.
    ENDIF.

  ENDIF.

* Wenn die Funktionsvariante geändert wurde,
* dann den Puffer clearen
  IF g_viewvar-fvariantid <> rn1_scr_view100-fvarid.
    PERFORM clear_viewbuffer_fvar.
  ENDIF.

  g_viewvar-fvariantid = rn1_scr_view100-fvarid.

ENDFORM.                               " CHECK_FVAR

*&---------------------------------------------------------------------*
*&      Form  CHECK_VIEWTYPE
*&---------------------------------------------------------------------*
*       Prüfung des Sichttyps
*----------------------------------------------------------------------*
FORM check_viewtype.

* Der Sichttyp muß nicht mehr extra geprüft werden, da zur Eingabe
* eine Listbox mit den gültigen Werten verwendet wird ...

* ... aber hier müssen, wenn nötig, die entsprechenden
* Reportnamen für die Varianten gesetzt werden

  CHECK g_vcode = g_vcode_insert OR g_vcode = g_vcode_update.

* Report für Selektionsvariante wird benötigt
  IF g_viewvar-reports IS INITIAL OR g_view-viewtype <> rn1_scr_view100-viewtype.
    PERFORM get_report_selvar(sapln1workplace) USING rn1_scr_view100-viewtype
                                                     rn1_scr_view100-viewid
                                            CHANGING g_viewvar-reports.
  ENDIF.

* Report für Anzeigevariante wird benötigt
  IF g_viewvar-reporta IS INITIAL OR g_view-viewtype <> rn1_scr_view100-viewtype.
    PERFORM get_report_anzvar(sapln1workplace) USING rn1_scr_view100-viewtype
                                            CHANGING g_viewvar-reporta.
  ENDIF.

* Sichttyp auch in globales Feld stellen
  g_view-viewtype    = rn1_scr_view100-viewtype.
  g_viewvar-viewtype = rn1_scr_view100-viewtype.

ENDFORM.                               " CHECK_VIEWTYPE

*&---------------------------------------------------------------------*
*&      Form  CHECK_VIEWART
*&---------------------------------------------------------------------*
*       Prüfung der Art der Sicht
*----------------------------------------------------------------------*
FORM check_viewart.

* Es muß geprüft werden, daß nicht beide Checkboxen markiert sind

  IF rn1_scr_view100-sap_std = on AND rn1_scr_view100-cst_std = on.
    g_error = on.
    SET CURSOR FIELD 'RN1_SCR_VIEW100-SAP_STD'.
    MESSAGE i504.
*   Bitte entweder nur SAP-Standard oder Kunden-Standard markieren
    EXIT.
  ENDIF.

  g_view_sap_std = rn1_scr_view100-sap_std.
  g_view_cst_std = rn1_scr_view100-cst_std.

ENDFORM.                               " CHECK_VIEWART

*&---------------------------------------------------------------------*
*&      Form  CHECK_VIEWID
*&---------------------------------------------------------------------*
*       Prüfung der Sicht-ID
*----------------------------------------------------------------------*
FORM check_viewid.

  DATA: l_nwview     LIKE nwview.                           "#EC NEEDED
  DATA: l_allowed(1) TYPE c,
        tablekey     LIKE  e071k-tabkey,
        tablename    LIKE  tresc-tabname,
        fieldname    LIKE  tresc-fieldname.

* Die Sicht-ID muß beim Anlegen und Ändern einer neuen Sicht geprüft
* werden (beim Ändern deshalb, weil keine SAP-Sichten geändert werden
* dürfen)

  g_error = off.

  CHECK g_vcode = g_vcode_insert OR g_vcode = g_vcode_update.

  CHECK NOT rn1_scr_view100-viewid IS INITIAL.

* Prüfen, ob diese Sicht nicht bereits existiert
  IF g_vcode = g_vcode_insert.
    SELECT SINGLE * FROM nwview INTO l_nwview
           WHERE  viewtype  = g_view-viewtype
           AND    viewid    = rn1_scr_view100-viewid.
    IF sy-subrc = 0.
      g_error = on.
      SET CURSOR FIELD 'RN1_SCR_VIEW100-VIEWID'.
      MESSAGE i361 WITH rn1_scr_view100-viewid.
*     Die Sicht & existiert bereits
      EXIT.
    ENDIF.
  ENDIF.

* Namensgebung prüfen
*  if g_first_time_warning =  off         and
*     g_view-viewid        <> RN1_SCR_VIEW100-viewid.
*    g_first_time_warning = on.
*  endif.
*  if g_first_time_warning = on.
*    g_first_time_warning = off.
* ID 7947: E-Meldung nur in Kundensystemen ausgeben
  IF g_system_sap = off.
    tablekey  = rn1_scr_view100-viewid.
    tablename = 'NWVIEW'.
    fieldname = 'VIEWID'.
    CALL FUNCTION 'CHECK_CUSTOMER_NAME_FIELD'
         EXPORTING
*           OBJECTTYPE            = 'TABU'
            tablekey              = tablekey
            tablename             = tablename
            fieldname             = fieldname
        IMPORTING
           keyfield_allowed      = l_allowed
*           SYSTEM_SAP            =
*           TABLE_NOT_FOUND       =
*           RESERVED_IN_TRESC     =
        EXCEPTIONS
           objecttype_not_filled = 1
           tablename_not_filled  = 2
           fieldname_not_filled  = 3
           OTHERS                = 4.                       "#EC *
    IF sy-subrc <> 0.
      l_allowed = off.
    ENDIF.
    IF l_allowed <> on.
      SET CURSOR FIELD 'RN1_SCR_VIEW100-VIEWID'.
      g_error = on.
      CLEAR ok-code.  " wie Warning-Msg behandeln, 1x am Popup bleiben
      IF g_vcode = g_vcode_insert.
        MESSAGE e362.
*       Der Name der Sicht darf nicht mit 'S' beginnen (SAP-Namensraum)
      ELSE.
        MESSAGE e363.
*       Von SAP ausgelieferte Sichten dürfen nicht geändert werden
      ENDIF.
    ENDIF.
  ENDIF.

* Sichttyp auch in globales Feld stellen
  g_view-viewid    = rn1_scr_view100-viewid.
  g_viewvar-viewid = rn1_scr_view100-viewid.

ENDFORM.                               " CHECK_VIEWID

*&---------------------------------------------------------------------*
*&      Form  CHECK_VDEFAULT
*&---------------------------------------------------------------------*
*       Default-Kz prüfen: es darf nur für 1 Sicht gesetzt werden
*----------------------------------------------------------------------*
FORM check_vdefault.

  DATA: l_wa_nwpvz  LIKE nwpvz,
        l_nwpvz     LIKE v_nwpvz,
        lt_nwpvz    LIKE TABLE OF v_nwpvz,
        l_txt       LIKE nwpvzt-txt.

  CHECK g_place_zuo = on AND NOT g_place-wplaceid IS INITIAL.

  CHECK g_vcode = g_vcode_insert OR g_vcode = g_vcode_update.

  IF rn1_scr_view100-vdefault = on.
*   Gepufferte Zuordnungen oder jene von der DB vergleichen
    REFRESH lt_nwpvz.
    IF g_chk_buffer = on.
      lt_nwpvz[] = gt_nwpvz_chk[].
    ELSE.
      LOOP AT gt_nwpvz INTO l_wa_nwpvz.
        CLEAR l_nwpvz.
        MOVE-CORRESPONDING l_wa_nwpvz TO l_nwpvz.           "#EC ENHOK
        APPEND l_nwpvz TO lt_nwpvz.
      ENDLOOP.
    ENDIF.
    LOOP AT lt_nwpvz INTO l_nwpvz WHERE vdefault = on.
      IF l_nwpvz-viewtype   = rn1_scr_view100-viewtype AND
         l_nwpvz-viewid     = rn1_scr_view100-viewid   AND
         l_nwpvz-wplacetype = g_place-wplacetype       AND
         l_nwpvz-wplaceid   = g_place-wplaceid.
        CONTINUE.
      ENDIF.
      SET CURSOR FIELD 'RN1_SCR_VIEW100-VDEFAULT'.
      g_error = on.
      IF l_nwpvz-txt IS INITIAL.
        SELECT SINGLE txt FROM nwpvzt INTO l_txt
               WHERE  wplacetype  = g_place-wplacetype
               AND    wplaceid    = g_place-wplaceid
               AND    viewtype    = l_nwpvz-viewtype
               AND    viewid      = l_nwpvz-viewid
               AND    spras       = sy-langu.
      ELSE.
        l_txt = l_nwpvz-txt.
      ENDIF.
      MESSAGE i382 WITH l_txt.
*     Das Default-Kennzeichen darf nur bei einer Sicht gesetzt werden
      EXIT.
    ENDLOOP.
  ENDIF.

  g_vdefault = rn1_scr_view100-vdefault.

ENDFORM.                               " CHECK_VDEFAULT

*&---------------------------------------------------------------------*
*&      Form  CHECK_SORTID
*&---------------------------------------------------------------------*
*       SORTID prüfen: es sollen nicht doppelte SORTIDs vorkommen
*----------------------------------------------------------------------*
FORM check_sortid.

  DATA: l_wa_nwpvz  LIKE nwpvz,
        l_nwpvz     LIKE v_nwpvz,
        lt_nwpvz    LIKE TABLE OF v_nwpvz,
        l_txt       LIKE nwpvzt-txt.

  CHECK g_place_zuo = on AND NOT g_place-wplaceid IS INITIAL.

  CHECK g_vcode = g_vcode_insert OR g_vcode = g_vcode_update.

  IF rn1_scr_view100-sortid IS INITIAL.
*    Priorität muß nicht unbedingt eingegeben werden
*    Wenn keine Priorität eingegeben wird, dann wird die Sicht dem
*    Arbeitsumfeld an letzter Stelle hinzugefügt
*    SET CURSOR FIELD 'RN1_SCR_VIEW100-SORTID'.
*    MESSAGE i384.
**   Bitte vergeben Sie eine Priorität für die Zuordnung dieser Sicht
*    g_error = on.
  ELSE.
    REFRESH lt_nwpvz.
    IF g_chk_buffer = on.
      lt_nwpvz[] = gt_nwpvz_chk[].
    ELSE.
      LOOP AT gt_nwpvz INTO l_wa_nwpvz.
        CLEAR l_nwpvz.
        MOVE-CORRESPONDING l_wa_nwpvz TO l_nwpvz.           "#EC ENHOK
        APPEND l_nwpvz TO lt_nwpvz.
      ENDLOOP.
    ENDIF.
    LOOP AT lt_nwpvz INTO l_nwpvz WHERE sortid = rn1_scr_view100-sortid.
      IF l_nwpvz-viewtype   = rn1_scr_view100-viewtype      AND
         l_nwpvz-viewid     = rn1_scr_view100-viewid        AND
         l_nwpvz-wplacetype = g_place-wplacetype AND
         l_nwpvz-wplaceid   = g_place-wplaceid.
        CONTINUE.
      ENDIF.
      SET CURSOR FIELD 'RN1_SCR_VIEW100-VDEFAULT'.
      g_error = on.
      IF l_nwpvz-txt IS INITIAL.
        SELECT SINGLE txt FROM nwpvzt INTO l_txt
               WHERE  wplacetype  = g_place-wplacetype
               AND    wplaceid    = g_place-wplaceid
               AND    viewtype    = l_nwpvz-viewtype
               AND    viewid      = l_nwpvz-viewid
               AND    spras       = sy-langu.
      ELSE.
        l_txt = l_nwpvz-txt.
      ENDIF.
      MESSAGE i383 WITH rn1_scr_view100-sortid l_txt.
*     Die Priorität & wurde bereits bei der Sicht & vergeben
      EXIT.
    ENDLOOP.
  ENDIF.

  g_sortid = rn1_scr_view100-sortid.

ENDFORM.                               " CHECK_SORTID

*&---------------------------------------------------------------------*
*&      Form  READ_FROM_DYNPRO
*&---------------------------------------------------------------------*
FORM read_from_dynpro TABLES pt_dynpr STRUCTURE dynpread
                      USING  p_mode   TYPE c.

  DATA: l_repid LIKE sy-repid.
  DATA: l_dynnr LIKE sy-dynnr.

  l_repid = sy-repid.
  l_dynnr = sy-dynnr.

* Werte der Dynprofelder einlesen
  IF p_mode = 'R' OR p_mode = '*'.
    CALL FUNCTION 'ISH_DYNP_VALUES_READ'
      EXPORTING
        dyname     = l_repid
        dynumb     = l_dynnr
      TABLES
        dynpfields = pt_dynpr.
  ENDIF.

  READ TABLE pt_dynpr INDEX 1.
  CHECK sy-subrc = 0.

*  LOOP AT pt_dynpr.
*    TRANSLATE pt_dynpr-fieldvalue TO UPPER CASE.
*    MODIFY pt_dynpr INDEX sy-tabix.
*  ENDLOOP.

  IF p_mode = 'W' OR p_mode = '*'.
    CALL FUNCTION 'DYNP_VALUES_UPDATE'
      EXPORTING
        dyname     = l_repid
        dynumb     = l_dynnr
      TABLES
        dynpfields = pt_dynpr.
  ENDIF.

ENDFORM.                               " READ_FROM_DYNPRO

*&---------------------------------------------------------------------*
*&      Form  GET_VAR_TEXTS
*&---------------------------------------------------------------------*
*       Texte der Varianten holen
*----------------------------------------------------------------------*
FORM get_var_texts USING value(p_sel)      LIKE on
                         value(p_anz)      LIKE on
                         value(p_func)     LIKE on
                         value(p_svarid)   LIKE rn1_scr_view100-svarid
                         value(p_avarid)   LIKE rn1_scr_view100-avarid
                         value(p_fvarid)   LIKE rn1_scr_view100-fvarid
                         value(p_reports)  LIKE rnviewvar-reports
                         value(p_reporta)  LIKE rnviewvar-reporta
                         value(p_viewtype) LIKE nwview-viewtype
                         value(p_viewid)   LIKE nwview-viewid
                   CHANGING p_svar_txt     LIKE rn1_scr_view100-svar_txt
                            p_avar_txt     LIKE rn1_scr_view100-avar_txt
                            p_fvar_txt     LIKE rn1_scr_view100-fvar_txt.

  DATA: l_selvar_txt    LIKE rsvar-vtext.
  DATA: l_disvariant    LIKE disvariant,
        dummy_dispvar   TYPE lvc_t_fcat.
  DATA: lt_fvar         LIKE TABLE OF v_nwfvar,
        l_fvar          LIKE v_nwfvar,
        ls_view         TYPE nwview,
        l_no_std        TYPE ish_on_off,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_einri         TYPE einri,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling,
        l_rc            LIKE sy-subrc,
        l_rc_dummy      TYPE ish_method_rc.
  DATA: l_var_old       TYPE rnviewvar,
        l_var_new       TYPE rnviewvar.

  ls_view-mandt    = sy-mandt.
  ls_view-viewtype = p_viewtype.
  ls_view-viewid   = p_viewid.
  PERFORM get_einri CHANGING l_einri.

* Text der Selektionsvariante
  IF p_sel = on.
    IF p_svarid IS INITIAL.
      CLEAR p_svar_txt.
      PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
      PERFORM vp_view_spec_func(sapln1workplace)
                  USING    'GET_TXT_S'
                           '0'
                           ls_view
                           g_vcode
                           l_einri
                           l_var_old
                           l_var_new
                           gs_refresh_old
                           gs_refresh
                           l_rc_dummy
                  CHANGING l_no_std
                           l_svar_txt
                           l_avar_txt
                           l_fvar_txt
                           l_rc
                           lr_errorhandler.
      IF l_rc = 0 AND l_svar_txt IS NOT INITIAL.
        p_svar_txt = l_svar_txt.
      ENDIF.
    ELSE.
      CALL FUNCTION 'RS_VARIANT_TEXT'
           EXPORTING
              curr_report  = p_reports
              langu        = sy-langu
              variant      = p_svarid
*             ALL_VARIANTS = ' '
           IMPORTING
              v_text       = l_selvar_txt
           EXCEPTIONS
              OTHERS       = 1.
      IF sy-subrc <> 0.
        CLEAR p_svar_txt.
      ELSE.
        p_svar_txt = l_selvar_txt.
      ENDIF.
      IF p_svar_txt IS INITIAL.
        p_svar_txt = 'Text nicht gepflegt'(036).
      ENDIF.
    ENDIF.
  ENDIF.

* Text der Anzeigevariante
  IF p_anz = on.
    IF p_avarid IS INITIAL.
      CLEAR p_avar_txt.
*     ID 13398: viewtype 014 has special layouts (presentation variants)
      IF p_viewtype = '014'
        OR p_viewtype = '018'.                              "MED-33470
        IF NOT g_placetype_pg IS INITIAL AND
           NOT g_placeid_pg   IS INITIAL.
          SELECT SINGLE txt FROM nwplacet INTO p_avar_txt
                 WHERE  wplacetype  = g_placetype_pg
                 AND    wplaceid    = g_placeid_pg
                 AND    spras       = sy-langu.
          IF sy-subrc <> 0 OR p_avar_txt IS INITIAL.
            p_avar_txt = 'Text nicht gepflegt'(036).
          ENDIF.
        ENDIF.
      ENDIF.
      PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
      PERFORM vp_view_spec_func(sapln1workplace)
                  USING    'GET_TXT_A'
                           '0'
                           ls_view
                           g_vcode
                           l_einri
                           l_var_old
                           l_var_new
                           gs_refresh_old
                           gs_refresh
                           l_rc_dummy
                  CHANGING l_no_std
                           l_svar_txt
                           l_avar_txt
                           l_fvar_txt
                           l_rc
                           lr_errorhandler.
      IF l_rc = 0 AND l_avar_txt IS NOT INITIAL.
        p_avar_txt = l_avar_txt.
      ENDIF.
    ELSE.
      CLEAR dummy_dispvar. REFRESH dummy_dispvar.
      CLEAR l_disvariant.
      l_disvariant-report     = p_reporta.
      l_disvariant-variant    = p_avarid.

      CALL FUNCTION 'LVC_VARIANT_SELECT'
        EXPORTING
          i_dialog            = ' '
          i_user_specific     = ' '  " no user-sp. variants!
          it_default_fieldcat = dummy_dispvar
        CHANGING
          cs_variant          = l_disvariant
        EXCEPTIONS
          wrong_input         = 1
          fc_not_complete     = 2
          not_found           = 3
          program_error       = 4
          OTHERS              = 5.
      IF sy-subrc <> 0.
        CLEAR p_avar_txt.
      ELSE.
        p_avar_txt = l_disvariant-text.
      ENDIF.
      IF p_avar_txt IS INITIAL.
        p_avar_txt = 'Text nicht gepflegt'(036).
      ENDIF.
    ENDIF.
  ENDIF.

* Text der Funktionsvariante
  IF p_func = on.
    IF p_fvarid IS INITIAL.
      CLEAR p_fvar_txt.
      PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
      PERFORM vp_view_spec_func(sapln1workplace)
                  USING    'GET_TXT_F'
                           '0'
                           ls_view
                           g_vcode
                           l_einri
                           l_var_old
                           l_var_new
                           gs_refresh_old
                           gs_refresh
                           l_rc_dummy
                  CHANGING l_no_std
                           l_svar_txt
                           l_avar_txt
                           l_fvar_txt
                           l_rc
                           lr_errorhandler.
      IF l_rc = 0 AND l_fvar_txt IS NOT INITIAL.
        p_fvar_txt = l_fvar_txt.
      ENDIF.
    ELSE.
      CALL FUNCTION 'ISHMED_VM_FVAR_GET'
        EXPORTING
          i_viewtype   = p_viewtype
          i_fvariantid = p_fvarid
        IMPORTING
          e_rc         = l_rc
        TABLES
          t_fvar       = lt_fvar.
      IF l_rc <> 0.
        CLEAR p_fvar_txt.
      ELSE.
        READ TABLE lt_fvar INTO l_fvar INDEX 1.
        p_fvar_txt = l_fvar-txt.
        IF p_fvar_txt IS INITIAL.
          p_fvar_txt = 'Text nicht gepflegt'(036).
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.                               " GET_VAR_TEXTS

*&---------------------------------------------------------------------*
*&      Form  INIT_100
*&---------------------------------------------------------------------*
*       Dynpro 100 (Sicht pflegen) initialisieren
*----------------------------------------------------------------------*
FORM init_100.

  DATA: l_nwpvz         LIKE nwpvz,
        l_v_nwpvz       LIKE v_nwpvz,
        l_rc            TYPE sy-subrc,
        l_rc_dummy      TYPE ish_method_rc,
        ls_view         TYPE nwview,
        l_no_std        TYPE ish_on_off,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_einri         TYPE einri,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_var_old       TYPE rnviewvar,
        l_var_new       TYPE rnviewvar.

  IF g_first_time_100 = on.
    CLEAR rn1_scr_view100.
    rn1_scr_view100-viewtype  = g_view-viewtype.
    rn1_scr_view100-viewid    = g_view-viewid.
    rn1_scr_view100-viewidtxt = g_view_txt.
    rn1_scr_view100-svarid    = g_viewvar-svariantid.
    rn1_scr_view100-avarid    = g_viewvar-avariantid.
    rn1_scr_view100-fvarid    = g_viewvar-fvariantid.
    rn1_scr_view100-rfsh      = gs_refresh-rfsh.
    rn1_scr_view100-rfsh_int  = gs_refresh-rfsh_interval.

*   Aufgrund des Sicht-IDs und der eingetragenen Anzeigevariante kann
*   die Art der Sicht ermittelt werden
    IF NOT g_view-viewid IS INITIAL.
      CASE g_view-viewid(1).
        WHEN 'C'.                            " Kunde
          IF g_viewvar-avariantid = '/STANDARD'.
            g_view_cst_std = on.             " Kundenstandard
          ENDIF.
        WHEN 'S'.                            " SAP
          g_view_sap_std = on.               " SAP-Standard
      ENDCASE.
    ENDIF.
    rn1_scr_view100-sap_std = g_view_sap_std.
    rn1_scr_view100-cst_std = g_view_cst_std.

*   Die Listbox für den Sichttyp befüllen
    PERFORM fill_lb_viewtype USING 'RN1_SCR_VIEW100-VIEWTYPE'
                                   g_place-wplacetype.
*   Falls Sichttyp bekannt ist, Reportnamen für Varianten befüllen
    IF NOT g_view-viewtype IS INITIAL.
*     Report für Selektionsvariante wird benötigt
      IF g_viewvar-reports IS INITIAL.
        PERFORM get_report_selvar(sapln1workplace) USING g_view-viewtype
                                                         g_view-viewid
                                              CHANGING g_viewvar-reports
                                              .
      ENDIF.
*     Report für Anzeigevariante wird benötigt
      IF g_viewvar-reporta IS INITIAL.
        PERFORM get_report_anzvar(sapln1workplace) USING g_view-viewtype
                                              CHANGING g_viewvar-reporta
                                              .
      ENDIF.
    ENDIF.

*   Alle Zuordnungen des Arbeitsumfelds lesen
    CLEAR:   g_vdefault, g_sortid, g_zuo_txt.
    REFRESH: gt_nwpvz.
    IF g_place_zuo = on AND NOT g_place-wplaceid IS INITIAL.
      IF g_chk_buffer = off.
*       Zuordnungsattribute von der DB lesen
        SELECT * FROM nwpvz INTO TABLE gt_nwpvz
               WHERE  wplacetype  = g_place-wplacetype
               AND    wplaceid    = g_place-wplaceid.       "#EC *
        IF g_vcode = g_vcode_update.
          READ TABLE gt_nwpvz INTO l_nwpvz
                     WITH KEY viewtype = g_view-viewtype
                              viewid   = g_view-viewid.
          IF sy-subrc = 0.
            g_vdefault               = l_nwpvz-vdefault.
            g_sortid                 = l_nwpvz-sortid.
            rn1_scr_view100-vdefault = l_nwpvz-vdefault.
            rn1_scr_view100-sortid   = l_nwpvz-sortid.
            SELECT SINGLE txt FROM nwpvzt INTO g_zuo_txt
                   WHERE  wplacetype = g_place-wplacetype
                   AND    wplaceid   = g_place-wplaceid
                   AND    viewtype   = g_view-viewtype
                   AND    viewid     = g_view-viewid
                   AND    spras      = sy-langu.
            rn1_scr_view100-zuo_txt  = g_zuo_txt.
          ENDIF.
        ENDIF.
      ELSE.
*       Übergebene, gepufferte Zuordnungsattribute verwenden
        READ TABLE gt_nwpvz_chk INTO l_v_nwpvz WITH KEY
                   wplacetype = g_place-wplacetype
                   wplaceid   = g_place-wplaceid
                   viewtype   = g_view-viewtype
                   viewid     = g_view-viewid.
        IF sy-subrc = 0.
          g_vdefault               = l_v_nwpvz-vdefault.
          g_sortid                 = l_v_nwpvz-sortid.
          g_zuo_txt                = l_v_nwpvz-txt.
          rn1_scr_view100-vdefault = l_v_nwpvz-vdefault.
          rn1_scr_view100-sortid   = l_v_nwpvz-sortid.
          rn1_scr_view100-zuo_txt  = l_v_nwpvz-txt.
        ENDIF.
      ENDIF.
    ENDIF.
    IF g_zuo_txt IS INITIAL.
      g_zuo_txt = g_view_txt.
    ENDIF.

*   ID 18129: initialization for view specific fields
    ls_view-mandt    = sy-mandt.
    ls_view-viewtype = g_viewvar-viewtype.
    ls_view-viewid   = g_viewvar-viewid.
    PERFORM get_einri CHANGING l_einri.
    PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
    PERFORM vp_view_spec_func(sapln1workplace)
              USING    'INIT'
                       '0'
                       ls_view
                       g_vcode
                       l_einri
                       l_var_old
                       l_var_new
                       gs_refresh_old
                       gs_refresh
                       l_rc_dummy
              CHANGING l_no_std
                       l_svar_txt
                       l_avar_txt
                       l_fvar_txt
                       l_rc
                       lr_errorhandler.
    IF l_rc <> 0 AND lr_errorhandler IS BOUND.
      CALL METHOD lr_errorhandler->display_messages
        EXPORTING
          i_control = on.
    ENDIF.

    g_first_time_100 = off.
    g_error = off.
  ENDIF.

ENDFORM.                                                    " INIT_100

*&---------------------------------------------------------------------*
*&      Form  NWPVZ_LIST
*&---------------------------------------------------------------------*
*       Liste der Arbeitsumfelder, denen die zu löschende Sicht
*       zugeordnet ist
*----------------------------------------------------------------------*
*      --> PT_NWPVZ   Zuordnungen Arbeitsumfeld-Sicht
*      <-- P_DEL_OK   Sicht löschen (und alle Zuordnungen zu Arb.umf.)
*----------------------------------------------------------------------*
*FORM nwpvz_list TABLES    pt_nwpvz    STRUCTURE vnwpvz
*                CHANGING  p_del_ok    LIKE off.
*
*  DATA: l_wa_nwpvz   LIKE vnwpvz,
*        l_place_txt  LIKE nwplacet-txt,
*        l_header(70) TYPE c,
*        l_title(60)  TYPE c.
*  DATA: a_texttab    LIKE TABLE OF rn1list132 WITH HEADER LINE,
*        a_buttab     LIKE TABLE OF rn1push    WITH HEADER LINE.
*  DATA: a_fcode      LIKE fcode.
*
*  p_del_ok = off.
*
** Zeilen mit Arbeitsumfeldern füllen
*  CLEAR a_texttab.   REFRESH a_texttab.
*  LOOP AT pt_nwpvz INTO l_wa_nwpvz.
*    a_texttab-text = l_wa_nwpvz-wplaceid.
*    SELECT SINGLE txt FROM nwplacet INTO l_place_txt
*           WHERE  wplacetype  = l_wa_nwpvz-wplacetype
*           AND    wplaceid    = l_wa_nwpvz-wplaceid
*           AND    spras       = sy-langu.
*    IF sy-subrc = 0.
*      a_texttab-text+16(50) = l_place_txt.
*    ENDIF.
*    APPEND a_texttab. CLEAR a_texttab.
*  ENDLOOP.
*
** Pushbuttons für Popup festlegen
*  CLEAR a_buttab.   REFRESH a_buttab.
*  a_buttab-fcode = 'DELE'.
** a_buttab-icon  = icon_delete.
*  a_buttab-text  = 'Sicht löschen'(008).
*  APPEND a_buttab.
*
** Titel
*  CLEAR l_title.
*  CONCATENATE 'Sicht:'(011) l_wa_nwpvz-viewid '-'
*              'Zuordnung zu Arbeitsumfeldern'(010)
*              INTO l_title SEPARATED BY space.
*
** Header
*  CLEAR l_header.
*  l_header(15)    = 'Arbeitsumfeld'(012).
*  l_header+16(50) = 'Bezeichnung'(013).
*
** List-Popup ausgeben
*  CALL FUNCTION 'ISHMED_LIST_POPUP'
*       EXPORTING
*            i_title     = l_title
*            i_header1   = l_header
**           I_HEADER2   = ' '
*            i_enter_key = ' '
*            i_print_key = ' '
*            i_modal     = 'X'
*       IMPORTING
*            f_code      = a_fcode
*       TABLES
*            t_outtab    = a_texttab
*            t_button    = a_buttab.
*
*  CASE a_fcode.
*    WHEN 'DELE'.                       " Sicht löschen
*      p_del_ok = on.
*    WHEN 'CANC'.                       " Abbrechen
*      p_del_ok = off.
*  ENDCASE.
*
*ENDFORM.                               " NWPVZ_LIST

*&---------------------------------------------------------------------*
*&      Form  CHECK_SVAR_USED
*&---------------------------------------------------------------------*
*       Prüfen, ob Selektionsvariante auch in anderen Sichten
*       verwendet wird
*----------------------------------------------------------------------*
*      --> P_VIEWVAR     Sicht (und Varianten)
*      <-- P_SVAR_USED   Andere Verwender gefunden (ON/OFF)
*----------------------------------------------------------------------*
FORM check_svar_used USING    value(p_viewvar) LIKE rnviewvar
                     CHANGING p_svar_used      LIKE off.

  DATA: lt_view               LIKE TABLE OF nwview,
        l_tabname             TYPE lvc_tname,
        l_viewname_dummy      TYPE lvc_tname,
        l_func_name_dummy     TYPE ish_fbname,
        l_tabn_checked        TYPE string.  " TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) FIX

  p_svar_used = off.

  REFRESH lt_view.

  CLEAR l_tabname.

* get name of view specific table (ID 18129)
  PERFORM get_view_specific IN PROGRAM sapln1workplace
                            USING      p_viewvar-viewtype
                            CHANGING   l_tabname
                                       l_viewname_dummy
                                       l_func_name_dummy.
  CHECK l_tabname IS NOT INITIAL.

" TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) FIX Start
      TRY.
          cl_abap_dyn_prg=>check_table_name_str(
                  EXPORTING
                    val               = l_tabname    " Input that shall be checked
                    packages          = 'IS-HMED,IS-H'    " Package to which the table shall belong
                    incl_sub_packages = abap_true
                  RECEIVING
                    val_str           = l_tabn_checked    " Same as the input
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
                  val                      = l_tabname
                  whitelist                = lt_whitelist
                RECEIVING
                  val_str           = l_tabn_checked    " Same as the input
              ).
            CATCH cx_abap_not_in_whitelist.    "
              MESSAGE a001(n1sec).
*   SQL-Befehlsinjektion - interner Fehler
          ENDTRY.
      ENDTRY.

  SELECT mandt viewtype viewid FROM (l_tabn_checked) INTO TABLE lt_view
         WHERE  viewtype    = p_viewvar-viewtype
         AND    reports     = p_viewvar-reports
         AND    svariantid  = p_viewvar-svariantid
         AND    flag1       = p_viewvar-flag1
         AND    flag2       = p_viewvar-flag2.
" TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) End

* Zu löschende Sicht nicht beachten
  DELETE lt_view WHERE viewtype = p_viewvar-viewtype
                   AND viewid   = p_viewvar-viewid.
  DESCRIBE TABLE lt_view.
  IF sy-tfill > 0.
    p_svar_used = on.
  ENDIF.

ENDFORM.                               " CHECK_SVAR_USED

*&---------------------------------------------------------------------*
*&      Form  CHECK_AVAR_USED
*&---------------------------------------------------------------------*
*       Prüfen, ob Anzeigevariante auch in anderen Sichten
*       verwendet wird
*----------------------------------------------------------------------*
*      --> P_VIEWVAR     Sicht (und Varianten)
*      <-- P_AVAR_USED   Andere Verwender gefunden (ON/OFF)
*----------------------------------------------------------------------*
FORM check_avar_used USING    value(p_viewvar) LIKE rnviewvar
                     CHANGING p_avar_used      LIKE off.

  DATA: lt_view               LIKE TABLE OF nwview,
        l_tabname             TYPE lvc_tname,
        l_viewname_dummy      TYPE lvc_tname,
        l_func_name_dummy     TYPE ish_fbname,
        l_tabname_checked     TYPE string.  " TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) FIX

  p_avar_used = off.

  REFRESH lt_view.

  CLEAR l_tabname.
* get name of view specific table (ID 18129)
  PERFORM get_view_specific IN PROGRAM sapln1workplace
                            USING      p_viewvar-viewtype
                            CHANGING   l_tabname
                                       l_viewname_dummy
                                       l_func_name_dummy.
  CHECK l_tabname IS NOT INITIAL.

" TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) FIX Start
      TRY.
          cl_abap_dyn_prg=>check_table_name_str(
                  EXPORTING
                    val               = l_tabname    " Input that shall be checked
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
                  val                      = l_tabname
                  whitelist                = lt_whitelist
                RECEIVING
                  val_str           = l_tabname_checked    " Same as the input
              ).
            CATCH cx_abap_not_in_whitelist.    "
              MESSAGE a001(n1sec).
*   SQL-Befehlsinjektion - interner Fehler
          ENDTRY.
      ENDTRY.

  SELECT mandt viewtype viewid FROM (l_tabname_checked)
         APPENDING TABLE lt_view
         WHERE  reporta     = p_viewvar-reporta
         AND    handle      = p_viewvar-handle
         AND    log_group   = p_viewvar-log_group
         AND    username    = p_viewvar-username
         AND    avariantid  = p_viewvar-avariantid
         AND    type        = p_viewvar-type.
" TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) End
* Zu löschende Sicht nicht beachten
  DELETE lt_view WHERE viewtype = p_viewvar-viewtype
                   AND viewid   = p_viewvar-viewid.
  DESCRIBE TABLE lt_view.
  IF sy-tfill > 0.
    p_avar_used = on.
  ENDIF.

ENDFORM.                               " CHECK_AVAR_USED

*&---------------------------------------------------------------------*
*&      Form  REFRESH_PERSONAL_BUFFER
*&---------------------------------------------------------------------*
*       Puffer der Arbeitsumfeld/Sicht-Daten des Users aktualisieren
*----------------------------------------------------------------------*
*      --> P_USER   Benutzer
*      --> P_PLACE  Arbeitsumfeld
*----------------------------------------------------------------------*
FORM refresh_personal_buffer USING value(p_user)  LIKE sy-uname
                                   value(p_place) LIKE nwplace.

  DATA: lt_workplaces     LIKE  TABLE OF v_nwplace,
        lt_views          LIKE  TABLE OF v_nwview,
        lt_user_menus     LIKE  TABLE OF bxmnodes1,
        lt_user_favorites LIKE  TABLE OF bxmnodes,
        lt_nwpvz          LIKE  TABLE OF v_nwpvz,
        lt_nwpusz         LIKE  TABLE OF v_nwpusz.

  CHECK NOT p_place-wplacetype IS INITIAL.

  CALL FUNCTION 'ISHMED_VM_PERSONAL_DATA_READ'
    EXPORTING
      i_uname              = p_user
      i_placetype          = p_place-wplacetype
      i_mode               = 'R'
      i_caller             = 'LN1VIEWF01'
      i_replace_substitute = on
    TABLES
      t_workplaces         = lt_workplaces
      t_views              = lt_views
      t_user_menus         = lt_user_menus
      t_user_favorites     = lt_user_favorites
      t_nwpvz              = lt_nwpvz
      t_nwpusz             = lt_nwpusz.

ENDFORM.                               " REFRESH_PERSONAL_BUFFER

*&---------------------------------------------------------------------*
*&      Form  REFRESH_VIEW_BUFFER
*&---------------------------------------------------------------------*
*       Puffer der Sicht/Varianten-Daten aktualisieren
*----------------------------------------------------------------------*
*      --> P_PLACE Arbeitsumfeld
*      --> P_VIEW  Sicht
*----------------------------------------------------------------------*
FORM refresh_view_buffer USING    value(p_place) LIKE nwplace
                                  value(p_view)  LIKE nwview.

  DATA: lt_selvar      LIKE TABLE OF rsparams,
        lt_fvar        LIKE TABLE OF v_nwfvar,
        lt_fvar_button LIKE TABLE OF v_nwbutton,
        lt_fvar_futxt  LIKE TABLE OF v_nwfvarp,
        lt_dispvar     TYPE lvc_t_fcat,
        lt_dispsort    TYPE lvc_t_sort,
        lt_dispfilt    TYPE lvc_t_filt.

  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_viewid      = p_view-viewid
      i_viewtype    = p_view-viewtype
      i_mode        = 'R'
      i_caller      = 'LN1VIEWF01'
      i_placeid     = p_place-wplaceid
      i_placetype   = p_place-wplacetype
    TABLES
      t_selvar      = lt_selvar
      t_fvar        = lt_fvar
      t_fvar_button = lt_fvar_button
      t_fvar_futxt  = lt_fvar_futxt
    CHANGING
      c_dispvar     = lt_dispvar
      c_dispsort    = lt_dispsort
      c_dispfilter  = lt_dispfilt.

ENDFORM.                               " REFRESH_VIEW_BUFFER
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

*--------------------------------------------------------------------
* Form Check_ISHMED
* Prüft ob ISHMED verwendet wird
*--------------------------------------------------------------------
FORM check_ishmed CHANGING l_ishmed_used TYPE i.

  DATA: l_wa_tn00 LIKE tn00.

  l_ishmed_used = false.

  SELECT SINGLE * FROM tn00 INTO l_wa_tn00
         WHERE keyfil = '1'.
  IF sy-subrc = 0.
    IF l_wa_tn00-ishmed = 'X'.
      l_ishmed_used = true.
    ENDIF.
  ENDIF.

ENDFORM.                               " CHECK_ISHMED
*&---------------------------------------------------------------------*
*&      Form  clear_viewbuffer_fvar
*&---------------------------------------------------------------------*
*       Puffer der Funktionsvariante der Sicht clearen
*----------------------------------------------------------------------*
FORM clear_viewbuffer_fvar.

  DATA: lt_fvar        LIKE TABLE OF v_nwfvar,
        lt_fvar_button LIKE TABLE OF v_nwbutton,
        lt_fvar_futxt  LIKE TABLE OF v_nwfvarp.

  REFRESH: lt_fvar, lt_fvar_button, lt_fvar_futxt.

  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_viewid      = g_viewvar-viewid
      i_viewtype    = g_viewvar-viewtype
      i_mode        = 'C'
      i_caller      = 'LN1VIEWF01'
      i_placeid     = g_place-wplaceid
      i_placetype   = g_place-wplacetype
    TABLES
      t_fvar        = lt_fvar
      t_fvar_button = lt_fvar_button
      t_fvar_futxt  = lt_fvar_futxt.

ENDFORM.                               " clear_viewbuffer_fvar
*&---------------------------------------------------------------------*
*&      Form  clear_viewbuffer_avar
*&---------------------------------------------------------------------*
*       Puffer der Anzeigevariante der Sicht clearen
*----------------------------------------------------------------------*
FORM clear_viewbuffer_avar.

  DATA: lt_dispvar     TYPE lvc_t_fcat,
        lt_dispsort    TYPE lvc_t_sort,
        lt_dispfilt    TYPE lvc_t_filt.

  REFRESH: lt_dispvar, lt_dispsort, lt_dispfilt.

  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_viewid     = g_viewvar-viewid
      i_viewtype   = g_viewvar-viewtype
      i_mode       = 'C'
      i_caller     = 'LN1VIEWF01'
      i_placeid    = g_place-wplaceid
      i_placetype  = g_place-wplacetype
    CHANGING
      c_dispvar    = lt_dispvar
      c_dispsort   = lt_dispsort
      c_dispfilter = lt_dispfilt.

ENDFORM.                               " clear_viewbuffer_avar
*&---------------------------------------------------------------------*
*&      Form  clear_viewbuffer_svar
*&---------------------------------------------------------------------*
*       Puffer der Selektionsvariante der Sicht clearen
*----------------------------------------------------------------------*
FORM clear_viewbuffer_svar.

  DATA: lt_selvar   LIKE TABLE OF rsparams.

  REFRESH: lt_selvar.

  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_viewid    = g_viewvar-viewid
      i_viewtype  = g_viewvar-viewtype
      i_mode      = 'C'
      i_caller    = 'LN1VIEWF01'
      i_placeid   = g_place-wplaceid
      i_placetype = g_place-wplacetype
    TABLES
      t_selvar    = lt_selvar.

ENDFORM.                               " clear_viewbuffer_svar
*&---------------------------------------------------------------------*
*&      Form  delete_svar
*&---------------------------------------------------------------------*
*       Selektionsvariante löschen, falls nicht mehr verwendet
*----------------------------------------------------------------------*
FORM delete_svar USING    value(p_viewvar) LIKE rnviewvar
                          value(p_popup)   LIKE off
                 CHANGING p_cancel         LIKE off.

  p_cancel = off.

  DATA: l_svar_used     LIKE off,
        l_txt1(70)      TYPE c,
        l_txt2(70)      TYPE c,
        l_text(140)     TYPE c,
        l_icon_1        TYPE icon-name,
        l_icon_2        TYPE icon-name,
        l_answer(1)     TYPE c,
        l_selvar_txt    LIKE rn1_scr_view100-svar_txt,
        l_dummy_atxt    LIKE rn1_scr_view100-avar_txt,
        l_dummy_ftxt    LIKE rn1_scr_view100-fvar_txt,
        l_dummy_avarid  LIKE rn1_scr_view100-avarid,
        l_dummy_fvarid  LIKE rn1_scr_view100-fvarid.

  IF NOT p_viewvar-svariantid IS INITIAL AND
     NOT p_viewvar-svariantid(4) CS 'SAP&'.
    PERFORM check_svar_used USING    p_viewvar
                            CHANGING l_svar_used.
    IF l_svar_used = off.
*     Abfrage-Popup bringen
      IF p_popup = on.
        PERFORM get_var_texts
                USING    on off off
                         p_viewvar-svariantid
                         l_dummy_avarid    l_dummy_fvarid
                         p_viewvar-reports p_viewvar-reporta
                         p_viewvar-viewtype
                         p_viewvar-viewid
                CHANGING l_selvar_txt l_dummy_atxt l_dummy_ftxt.
        CONCATENATE 'Wollen Sie die Selektionsvariante'(021)
                    l_selvar_txt INTO l_txt1 SEPARATED BY space.
        l_txt2 = 'oder nur die Zuordnung zur Sicht löschen?'(023).
        CONCATENATE l_txt1 l_txt2 INTO l_text SEPARATED BY space.
        l_icon_1 = icon_delete.
        l_icon_2 = icon_disconnect.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            titlebar              = 'Selektionsvariante löschen'(020)
*            diagnose_object       = ' '
            text_question         = l_text
            text_button_1         = 'Variante'(029)
            icon_button_1         = l_icon_1
            text_button_2         = 'Zuordnung'(015)
            icon_button_2         = l_icon_2
            default_button        = '1'
            display_cancel_button = 'X'
*            popup_type            = ' '
          IMPORTING
            answer                = l_answer
          EXCEPTIONS
            text_not_found        = 1
            OTHERS                = 2.
        IF sy-subrc <> 0.
          p_cancel = on.
          EXIT.
        ENDIF.
      ELSE.
        l_answer = '1'.                " Selektionsvariante löschen
      ENDIF.
*     Selektionsvariante löschen
      IF l_answer = '1'.
        CALL FUNCTION 'RS_VARIANT_DELETE'
             EXPORTING
                  report               = p_viewvar-reports
                  variant              = p_viewvar-svariantid
                  flag_confirmscreen   = on
                  flag_delallclient    = on
*            IMPORTING
*                 VARIANT              =
             EXCEPTIONS
                  not_authorized       = 1
                  not_executed         = 2
                  no_report            = 3
                  report_not_existent  = 4
                  report_not_supplied  = 5
                  variant_locked       = 6
                  variant_not_existent = 7
                  no_corr_insert       = 8
                  variant_protected    = 9
                  OTHERS               = 10.                "#EC *
        IF sy-subrc <> 0.
          EXIT.
        ENDIF.
      ELSEIF l_answer = 'A'.           " Cancel
        p_cancel = on.
*      ELSE.
*       Bei 2 soll nur die Zuordnung gelöscht werden -> OK
      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.                               " delete_svar
*&---------------------------------------------------------------------*
*&      Form  delete_avar
*&---------------------------------------------------------------------*
*       Anzeigevariante löschen, falls nicht mehr verwendet
*----------------------------------------------------------------------*
FORM delete_avar USING    value(p_viewvar) LIKE rnviewvar
                          value(p_popup)   LIKE off
                 CHANGING p_cancel         LIKE off.

  DATA: l_avar_used     LIKE off,
        lt_dvar         TYPE STANDARD TABLE OF ltdxkey,
        l_dvar          TYPE ltdxkey,
        l_txt1(70)      TYPE c,
        l_txt2(70)      TYPE c,
        l_text(140)     TYPE c,
        l_icon_1        TYPE icon-name,
        l_icon_2        TYPE icon-name,
        l_answer(1)     TYPE c,
        l_anzvar_txt    LIKE rn1_scr_view100-avar_txt,
        l_dummy_stxt    LIKE rn1_scr_view100-svar_txt,
        l_dummy_ftxt    LIKE rn1_scr_view100-fvar_txt,
        l_dummy_svarid  LIKE rn1_scr_view100-svarid,
        l_dummy_fvarid  LIKE rn1_scr_view100-fvarid.

  p_cancel = off.

  IF NOT p_viewvar-avariantid IS INITIAL AND
     NOT p_viewvar-avariantid(1) CA '0123456789'.
    PERFORM check_avar_used USING    p_viewvar
                            CHANGING l_avar_used.
    IF l_avar_used = off.
*     Abfrage-Popup bringen
      IF p_popup = on.
        PERFORM get_var_texts
                USING    off on off
                         l_dummy_svarid
                         p_viewvar-avariantid
                         l_dummy_fvarid
                         p_viewvar-reports p_viewvar-reporta
                         p_viewvar-viewtype
                         p_viewvar-viewid
                CHANGING l_dummy_stxt l_anzvar_txt l_dummy_ftxt.
        CONCATENATE 'Wollen Sie das Layout'(022)
                    l_anzvar_txt INTO l_txt1 SEPARATED BY space.
        l_txt2 = 'oder nur die Zuordnung zur Sicht löschen?'(023).
        CONCATENATE l_txt1 l_txt2 INTO l_text SEPARATED BY space.
        l_icon_1 = icon_delete.
        l_icon_2 = icon_disconnect.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            titlebar              = 'Layout löschen'(037)
*            diagnose_object       = ' '
            text_question         = l_text
            text_button_1         = 'Layout'(030)
            icon_button_1         = l_icon_1
            text_button_2         = 'Zuordnung'(015)
            icon_button_2         = l_icon_2
            default_button        = '1'
            display_cancel_button = 'X'
*            popup_type            = ' '
          IMPORTING
            answer                = l_answer
          EXCEPTIONS
            text_not_found        = 1
            OTHERS                = 2.
        IF sy-subrc <> 0.
          p_cancel = on.
          EXIT.
        ENDIF.
      ELSE.
        l_answer = '1'.                " Layout löschen
      ENDIF.
*     Anzeigevariante löschen
      IF l_answer = '1'.
        CLEAR l_dvar. REFRESH lt_dvar.
        l_dvar-report    = p_viewvar-reporta.
        l_dvar-handle    = p_viewvar-handle.
        l_dvar-log_group = p_viewvar-log_group.
        l_dvar-username  = p_viewvar-username.
        l_dvar-variant   = p_viewvar-avariantid.
        l_dvar-type      = p_viewvar-type.
        APPEND l_dvar TO lt_dvar.
        CALL FUNCTION 'LT_VARIANTS_DELETE'
*              EXPORTING
*                   I_TOOL        = 'LT'
*                   I_TEXT_DELETE = 'X'
               TABLES
                    t_varkey      = lt_dvar
               EXCEPTIONS
                    not_found     = 1
                    OTHERS        = 2.                      "#EC *
        IF sy-subrc <> 0.
          EXIT.
        ENDIF.
      ELSEIF l_answer = 'A'.           " Cancel
        p_cancel = on.
*      ELSE.
*       Bei 2 soll nur die Zuordnung gelöscht werden -> OK
      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.                               " delete_avar
*&---------------------------------------------------------------------*
*&      Form  delete_fvar
*&---------------------------------------------------------------------*
*       Funktionsvariante löschen, falls nicht mehr verwendet
*----------------------------------------------------------------------*
FORM delete_fvar USING    value(p_viewvar) LIKE rnviewvar
                          value(p_popup)   LIKE off
                 CHANGING p_cancel         LIKE off.

  DATA: l_rc         LIKE sy-subrc,
        l_wa_msg     LIKE bapiret2,
        lt_messages  LIKE TABLE OF bapiret2.

  p_cancel = off.

  IF NOT p_viewvar-fvariantid IS INITIAL.
*   Funktionsvariante löschen
    CALL FUNCTION 'ISHMED_VM_FVAR_DELETE'
      EXPORTING
        i_viewtype   = p_viewvar-viewtype
        i_fvariantid = p_viewvar-fvariantid
        i_check_used = on
        i_viewid     = p_viewvar-viewid
        i_commit     = off
        i_popup      = p_popup
      IMPORTING
        e_rc         = l_rc
      TABLES
        t_messages   = lt_messages.
    CASE l_rc.
      WHEN 0.
*       Funktionsvariante wurde gelöscht -> Feld wird im Popup gecleart
      WHEN 1.                       " Error
*       Meldungen ausgeben
        DESCRIBE TABLE lt_messages.
        IF sy-tfill > 0.
          LOOP AT lt_messages INTO l_wa_msg.
            l_wa_msg-type = 'I'.
            MODIFY lt_messages FROM l_wa_msg.
          ENDLOOP.
          PERFORM messages_send TABLES lt_messages.
        ENDIF.
        p_cancel = on. " damit Feld im Popup nicht gecleart wird!
      WHEN 2.                       " Cancel
        p_cancel = on.
      WHEN 3.                                               " ID 7958
*       Funktionsvariante wurde zwar nicht gelöscht, da sie noch von
*       anderen Sichten verwendet wird, doch soll die Zuordnung zu
*       der aktuellen Sicht gelöscht werden
*       -> Feld wird im Popup gecleart
    ENDCASE.
  ENDIF.

ENDFORM.                               " delete_fvar
*&---------------------------------------------------------------------*
*&      Form  check_zuo_txt
*&---------------------------------------------------------------------*
*       Prüfen der Zuordnungsbezeichnung
*----------------------------------------------------------------------*
FORM check_zuo_txt.

  CHECK g_vcode = g_vcode_insert OR g_vcode = g_vcode_update.

  g_zuo_txt = rn1_scr_view100-zuo_txt.

ENDFORM.                    " check_zuo_txt
*&---------------------------------------------------------------------*
*&      Form  svar_copy
*&---------------------------------------------------------------------*
*       Selektionsvariante kopieren
*----------------------------------------------------------------------*
FORM svar_copy CHANGING p_rc TYPE sy-subrc.

  DATA: l_rc            LIKE sy-subrc,
        l_rnsvar        LIKE rnsvar,
        l_rnsvar_new    LIKE rnsvar,
        l_cancel        TYPE ish_on_off,
        lt_messages     LIKE TABLE OF bapiret2 WITH HEADER LINE.

  CLEAR: p_rc, l_rnsvar, l_rnsvar_new, l_rc, l_cancel.

* Es soll jene Selektionsvariante kopiert werden, die am Dynpro
* eingegeben wurde (das muß nicht jene sein, die bereits zur Sicht
* gespeichert ist), daher muß sie hier übergeben werden
  IF g_viewvar-svariantid IS INITIAL.
    MESSAGE i354 WITH rn1_scr_view100-svarid.
*   Selektionsvariante & nicht vorhanden
    p_rc = 1.
    EXIT.
  ELSE.
    MOVE-CORRESPONDING g_viewvar TO l_rnsvar.               "#EC ENHOK
  ENDIF.

  CHECK NOT l_rnsvar IS INITIAL.

  CALL FUNCTION 'ISHMED_VM_SVAR_COPY'
    EXPORTING
      i_svar     = l_rnsvar
      i_popup    = 'X'
      i_viewtype = g_viewvar-viewtype
      i_viewid   = g_viewvar-viewid
    IMPORTING
      e_svar     = l_rnsvar_new
      e_rc       = l_rc
      e_cancel   = l_cancel
    TABLES
      t_messages = lt_messages.

  IF l_rc = 0 AND l_cancel = off.
    IF NOT l_rnsvar_new-svariantid IS INITIAL.
      rn1_scr_view100-svarid = l_rnsvar_new-svariantid.
    ENDIF.
  ENDIF.

  IF l_cancel = on.
    p_rc = 2.
  ELSEIF l_rc <> 0.
    p_rc = 1.
  ENDIF.

* Meldungen (auch Success!) ausgeben
  PERFORM messages_send TABLES lt_messages.

ENDFORM.                    " svar_copy
*&---------------------------------------------------------------------*
*&      Form  svar_ref
*&---------------------------------------------------------------------*
*       show all references to the selection variant
*----------------------------------------------------------------------*
FORM svar_ref CHANGING p_rc TYPE sy-subrc.

  p_rc = 0.

  IF g_viewvar-svariantid IS INITIAL.
    MESSAGE i354 WITH ' '.
*   Selektionsvariante & nicht vorhanden
    p_rc = 1.
    EXIT.
  ENDIF.

  CALL FUNCTION 'ISH_WP_WHERE_USED_LIST_SVAR'
    EXPORTING
      i_viewtype      = g_viewvar-viewtype
      i_svariant      = g_viewvar-svariantid
      i_svariant_txt  = rn1_scr_view100-svar_txt
      i_callback      = 'SAPLN_WP'
      i_pf_status     = 'SET_PF_STATUS_VM2'
      i_user_cmd      = 'USER_COMMAND'
*      _MARK           = ' '
    EXCEPTIONS
      not_used        = 1
      OTHERS          = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                    " svar_ref
*&---------------------------------------------------------------------*
*&      Form  avar_ref
*&---------------------------------------------------------------------*
*       show all references to the ALV Layout
*----------------------------------------------------------------------*
FORM avar_ref CHANGING p_rc TYPE sy-subrc.

  p_rc = 0.

  IF g_viewvar-avariantid IS INITIAL.
    MESSAGE i355 WITH ' '.
*   Anzeigevariante & nicht vorhanden
    p_rc = 1.
    EXIT.
  ENDIF.

  CALL FUNCTION 'ISH_WP_WHERE_USED_LIST_AVAR'
    EXPORTING
      i_viewtype      = g_viewvar-viewtype
      i_avariant      = g_viewvar-avariantid
      i_avariant_txt  = rn1_scr_view100-avar_txt
      i_callback      = 'SAPLN_WP'
      i_pf_status     = 'SET_PF_STATUS_VM2'
      i_user_cmd      = 'USER_COMMAND'
*      _MARK           = ' '
    EXCEPTIONS
      not_used        = 1
      OTHERS          = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                    " avar_ref
*&---------------------------------------------------------------------*
*&      Form  fvar_ref
*&---------------------------------------------------------------------*
*       show all references to the function variant
*----------------------------------------------------------------------*
FORM fvar_ref CHANGING p_rc TYPE sy-subrc.

  p_rc = 0.

  IF g_viewvar-fvariantid IS INITIAL.
    MESSAGE i356 WITH ' '.
*   Funktionsvariante & nicht vorhanden
    p_rc = 1.
    EXIT.
  ENDIF.

  CALL FUNCTION 'ISH_WP_WHERE_USED_LIST_FVAR'
    EXPORTING
      i_viewtype      = g_viewvar-viewtype
      i_fvariant      = g_viewvar-fvariantid
      i_fvariant_txt  = rn1_scr_view100-fvar_txt
      i_callback      = 'SAPLN_WP'
      i_pf_status     = 'SET_PF_STATUS_VM2'
      i_user_cmd      = 'USER_COMMAND'
*      _MARK           = ' '
    EXCEPTIONS
      not_used        = 1
      OTHERS          = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                    " fvar_ref

*&---------------------------------------------------------------------*
*&      Form  avar_copy
*&---------------------------------------------------------------------*
*       Layout kopieren
*----------------------------------------------------------------------*
FORM avar_copy CHANGING p_rc TYPE sy-subrc.

  DATA: l_rc            LIKE sy-subrc,
        l_rnavar        LIKE rnavar,
        l_rnavar_new    LIKE rnavar,
        l_cancel        TYPE ish_on_off,
        lt_messages     LIKE TABLE OF bapiret2 WITH HEADER LINE.

  CLEAR: p_rc, l_rnavar, l_rnavar_new, l_rc, l_cancel.

* ID 13398: viewtype 014 has a special layout (presentation variants)
*           and therefor a copy function is not available so far
  IF g_view-viewtype = '014'
    OR g_view-viewtype = '018'.                             "MED-33470
    MESSAGE i042(n1base).
*   Kopieren von Layouts für diesen Sichttyp nicht möglich
    p_rc = 1.
    EXIT.
  ENDIF.

* Es soll jenes Layout kopiert werden, das am Dynpro
* eingegeben wurde (das muß nicht jenes sein, das bereits zur Sicht
* gespeichert ist), daher muß es hier übergeben werden
  IF g_viewvar-avariantid IS INITIAL.
    MESSAGE i355 WITH rn1_scr_view100-avarid.
*   Anzeigevariante & nicht vorhanden
    p_rc = 1.
    EXIT.
  ELSE.
    MOVE-CORRESPONDING g_viewvar TO l_rnavar.               "#EC ENHOK
  ENDIF.

  CHECK NOT l_rnavar IS INITIAL.

  CALL FUNCTION 'ISHMED_VM_AVAR_COPY'
    EXPORTING
      i_avar     = l_rnavar
      i_popup    = 'X'
      i_viewtype = g_viewvar-viewtype
      i_viewid   = g_viewvar-viewid
      i_nwplace  = g_place                                  " ID 12249
    IMPORTING
      e_avar     = l_rnavar_new
      e_rc       = l_rc
      e_cancel   = l_cancel
    TABLES
      t_messages = lt_messages.

  IF l_rc = 0 AND l_cancel = off.
    IF NOT l_rnavar_new-avariantid IS INITIAL.
      rn1_scr_view100-avarid = l_rnavar_new-avariantid.
    ENDIF.
  ENDIF.

  IF l_cancel = on.
    p_rc = 2.
  ELSEIF l_rc <> 0.
    p_rc = 1.
  ENDIF.

* Meldungen (auch Success!) ausgeben
  PERFORM messages_send TABLES lt_messages.

ENDFORM.                    " avar_copy

*&---------------------------------------------------------------------*
*&      Form  fvar_copy
*&---------------------------------------------------------------------*
*       Funktionsvariante kopieren
*----------------------------------------------------------------------*
FORM fvar_copy CHANGING p_rc TYPE sy-subrc.

  DATA: l_rc            LIKE sy-subrc,
        l_rnfvar        LIKE rnfvar,
        l_rnfvar_new    LIKE rnfvar,
        l_cancel        TYPE ish_on_off,
        lt_messages     LIKE TABLE OF bapiret2 WITH HEADER LINE.

  CLEAR: p_rc, l_rnfvar, l_rnfvar_new, l_rc, l_cancel.

* Es soll jene Funktionsvariante kopiert werden, die am Dynpro
* eingegeben wurde (das muß nicht jene sein, die bereits zur Sicht
* gespeichert ist), daher muß sie hier übergeben werden
  IF g_viewvar-fvariantid IS INITIAL.
    MESSAGE i356 WITH rn1_scr_view100-fvarid.
*   Funktionsvariante & nicht vorhanden
    p_rc = 1.
    EXIT.
  ELSE.
    MOVE-CORRESPONDING g_viewvar TO l_rnfvar.               "#EC ENHOK
  ENDIF.

  CHECK NOT l_rnfvar IS INITIAL.

  CALL FUNCTION 'ISHMED_VM_FVAR_COPY'
    EXPORTING
      i_fvar     = l_rnfvar
      i_popup    = 'X'
      i_viewtype = g_viewvar-viewtype
      i_viewid   = g_viewvar-viewid
    IMPORTING
      e_fvar     = l_rnfvar_new
      e_rc       = l_rc
      e_cancel   = l_cancel
    TABLES
      t_messages = lt_messages.

  IF l_rc = 0 AND l_cancel = off.
    IF NOT l_rnfvar_new-fvariantid IS INITIAL.
      rn1_scr_view100-fvarid = l_rnfvar_new-fvariantid.
    ENDIF.
  ENDIF.

  IF l_cancel = on.
    p_rc = 2.
  ELSEIF l_rc <> 0.
    p_rc = 1.
  ENDIF.

* Meldungen (auch Success!) ausgeben
  PERFORM messages_send TABLES lt_messages.

ENDFORM.                    " fvar_copy
*&---------------------------------------------------------------------*
*&      Form  exit
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM exit .

  DATA: yn(2)           TYPE c,
        l_rc            TYPE sy-subrc,
        l_rc_dummy      TYPE ish_method_rc,
        ls_view         TYPE nwview,
        l_no_std        TYPE ish_on_off,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_einri         TYPE einri,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_var_old       TYPE rnviewvar,
        l_var_new       TYPE rnviewvar.

  g_save_ok_code = ok-code.
  CLEAR ok-code.
  l_rc = 0.

  CASE g_save_ok_code.
    WHEN 'ECAN'.
      IF g_error = off.
*       IF g_vcode                   = g_vcode_insert               OR
*          g_vcode_txt               = g_vcode_insert               OR
        IF g_viewvar-viewtype        <> g_viewvar_old-viewtype       OR
           g_viewvar-viewid          <> g_viewvar_old-viewid         OR
           g_viewvar-svariantid      <> g_viewvar_old-svariantid     OR
           g_viewvar-avariantid      <> g_viewvar_old-avariantid     OR
           g_viewvar-fvariantid      <> g_viewvar_old-fvariantid     OR
           rn1_scr_view100-rfsh      <> gs_refresh_old-rfsh          OR
           rn1_scr_view100-rfsh_int  <> gs_refresh_old-rfsh_interval OR
           rn1_scr_view100-viewidtxt <> g_view_txt_old.
          PERFORM popup_to_confirm(sapmnpa0)
                  USING ' ' 'Nicht gespeicherte Änderungen'(005)
                            'gehen verloren. Daten sichern?'(006)
                            'Sichtenpflege beenden'(007)    yn.
          CASE yn.
            WHEN 'J'.               " Yes
              g_save_ok_code = 'SAVE'.
              PERFORM save_view CHANGING l_rc.
              IF l_rc = 0.
                ls_view-mandt    = sy-mandt.
                ls_view-viewtype = g_viewvar-viewtype.
                ls_view-viewid   = g_viewvar-viewid.
                PERFORM get_einri CHANGING l_einri.
*               ID 18129: save view specific fields
                PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
                PERFORM vp_view_spec_func(sapln1workplace)
                            USING    'SAVE'
                                     '2'
                                     ls_view
                                     g_vcode
                                     l_einri
                                     l_var_old
                                     l_var_new
                                     gs_refresh_old
                                     gs_refresh
                                     l_rc_dummy
                            CHANGING l_no_std
                                     l_svar_txt
                                     l_avar_txt
                                     l_fvar_txt
                                     l_rc
                                     lr_errorhandler.
                IF l_rc <> 0 AND lr_errorhandler IS BOUND.
                  CALL METHOD lr_errorhandler->display_messages
                    EXPORTING
                      i_control = on.
                ENDIF.
              ENDIF.
            WHEN 'A'.               " Cancel
              EXIT.                            " am Dynpro bleiben
            WHEN OTHERS.            " No
          ENDCASE.
        ENDIF.
      ENDIF.
      IF l_rc = 0.
        SET SCREEN 0. LEAVE SCREEN.
      ENDIF.
  ENDCASE.

ENDFORM.                    " exit
*&---------------------------------------------------------------------*
*&      Form  check_svar_spec
*&---------------------------------------------------------------------*
*       check view special selection variants                ID 18129
*----------------------------------------------------------------------*
*      <--P_NO_STD  do no further standard checking
*----------------------------------------------------------------------*
FORM check_svar_spec  CHANGING p_no_std   TYPE ish_on_off.

  DATA: ls_view         TYPE nwview,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_rc            TYPE ish_method_rc,
        l_rc_dummy      TYPE ish_method_rc,
        l_einri         TYPE einri,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_var_old       TYPE rnviewvar,
        l_var_new       TYPE rnviewvar.

  p_no_std = off.

  ls_view-mandt    = sy-mandt.
  ls_view-viewtype = g_viewvar-viewtype.
  ls_view-viewid   = g_viewvar-viewid.
  PERFORM get_einri CHANGING l_einri.

  PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    'CHECK_S'
                       '0'
                       ls_view
                       g_vcode
                       l_einri
                       l_var_old
                       l_var_new
                       gs_refresh_old
                       gs_refresh
                       l_rc_dummy
              CHANGING p_no_std
                       l_svar_txt
                       l_avar_txt
                       l_fvar_txt
                       l_rc
                       lr_errorhandler.

  IF l_rc <> 0.
    g_error = on.
    SET CURSOR FIELD 'RN1_SCR_VIEW100-SVAR_TXT'.
    IF lr_errorhandler IS BOUND.
      CALL METHOD lr_errorhandler->display_messages
        EXPORTING
          i_control = on.
    ELSE.
      MESSAGE i354 WITH space.
*     Selektionsvariante & nicht vorhanden
    ENDIF.
  ENDIF.

ENDFORM.                    " check_svar_spec
*&---------------------------------------------------------------------*
*&      Form  check_avar_spec
*&---------------------------------------------------------------------*
*       check view special layouts                           ID 18129
*----------------------------------------------------------------------*
*      <--P_NO_STD  do no further standard checking
*----------------------------------------------------------------------*
FORM check_avar_spec  CHANGING p_no_std   TYPE ish_on_off.

  DATA: ls_view         TYPE nwview,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_rc            TYPE ish_method_rc,
        l_rc_dummy      TYPE ish_method_rc,
        l_einri         TYPE einri,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_var_old       TYPE rnviewvar,
        l_var_new       TYPE rnviewvar.

  p_no_std = off.

  ls_view-mandt    = sy-mandt.
  ls_view-viewtype = g_viewvar-viewtype.
  ls_view-viewid   = g_viewvar-viewid.
  PERFORM get_einri CHANGING l_einri.

  PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    'CHECK_A'
                       '0'
                       ls_view
                       g_vcode
                       l_einri
                       l_var_old
                       l_var_new
                       gs_refresh_old
                       gs_refresh
                       l_rc_dummy
              CHANGING p_no_std
                       l_svar_txt
                       l_avar_txt
                       l_fvar_txt
                       l_rc
                       lr_errorhandler.

  IF l_rc <> 0.
    g_error = on.
    SET CURSOR FIELD 'RN1_SCR_VIEW100-AVAR_TXT'.
    IF lr_errorhandler IS BOUND.
      CALL METHOD lr_errorhandler->display_messages
        EXPORTING
          i_control = on.
    ELSE.
      MESSAGE i355 WITH space.
*     Anzeigevariante & nicht vorhanden
    ENDIF.
  ENDIF.

ENDFORM.                    " check_avar_spec
*&---------------------------------------------------------------------*
*&      Form  check_fvar_spec
*&---------------------------------------------------------------------*
*       check view special function variants                 ID 18129
*----------------------------------------------------------------------*
*      <--P_NO_STD  do no further standard checking
*----------------------------------------------------------------------*
FORM check_fvar_spec  CHANGING p_no_std   TYPE ish_on_off.

  DATA: ls_view         TYPE nwview,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_rc            TYPE ish_method_rc,
        l_rc_dummy      TYPE ish_method_rc,
        l_einri         TYPE einri,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_var_old       TYPE rnviewvar,
        l_var_new       TYPE rnviewvar.

  p_no_std = off.

  ls_view-mandt    = sy-mandt.
  ls_view-viewtype = g_viewvar-viewtype.
  ls_view-viewid   = g_viewvar-viewid.
  PERFORM get_einri CHANGING l_einri.

  PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    'CHECK_F'
                       '0'
                       ls_view
                       g_vcode
                       l_einri
                       l_var_old
                       l_var_new
                       gs_refresh_old
                       gs_refresh
                       l_rc_dummy
              CHANGING p_no_std
                       l_svar_txt
                       l_avar_txt
                       l_fvar_txt
                       l_rc
                       lr_errorhandler.

  IF l_rc <> 0.
    g_error = on.
    SET CURSOR FIELD 'RN1_SCR_VIEW100-SVAR_TXT'.
    IF lr_errorhandler IS BOUND.
      CALL METHOD lr_errorhandler->display_messages
        EXPORTING
          i_control = on.
    ELSE.
      MESSAGE i356 WITH space.
*     Funktionsvariante & nicht vorhanden
    ENDIF.
  ENDIF.

ENDFORM.                    " check_fvar_spec

*&---------------------------------------------------------------------*
*&      Form  help_svar_spec
*&---------------------------------------------------------------------*
*       F4-value-request for view specific selection variants ID 18129
*----------------------------------------------------------------------*
FORM help_svar_spec USING    p_when     TYPE num1
                    CHANGING p_no_std   TYPE ish_on_off.

  DATA: l_fname         TYPE dynpread-fieldname,
        lt_dynpr        TYPE TABLE OF dynpread WITH HEADER LINE,
        ls_view         TYPE nwview,
        l_einri         TYPE einri,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_rc            TYPE ish_method_rc,
        l_rc_dummy      TYPE ish_method_rc,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_var_old       TYPE rnviewvar,
        l_var_new       TYPE rnviewvar.

  p_no_std = off.

  CHECK g_vcode <> g_vcode_display.

  ls_view-mandt    = sy-mandt.
  ls_view-viewtype = g_viewvar-viewtype.
  ls_view-viewid   = g_viewvar-viewid.
  PERFORM get_einri CHANGING l_einri.

  PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    'F4_S'
                       p_when
                       ls_view
                       g_vcode
                       l_einri
                       l_var_old
                       l_var_new
                       gs_refresh_old
                       gs_refresh
                       l_rc_dummy
              CHANGING p_no_std
                       l_svar_txt
                       l_avar_txt
                       l_fvar_txt
                       l_rc
                       lr_errorhandler.
  IF l_rc <> 0.
    IF lr_errorhandler IS BOUND.
      CALL METHOD lr_errorhandler->display_messages
        EXPORTING
          i_control = on.
    ELSE.
      MESSAGE s229 WITH ' ' ' '.
*     Selektionsvariante & für Report & konnte nicht gef. werden
    ENDIF.
    EXIT.
  ENDIF.

  CHECK l_svar_txt IS NOT INITIAL.

  rn1_scr_view100-svar_txt = l_svar_txt.

* set text to dynpro field
  CLEAR lt_dynpr. REFRESH lt_dynpr.
  l_fname = 'RN1_SCR_VIEW100-SVAR_TXT'.
  lt_dynpr-fieldname  = l_fname.
  lt_dynpr-fieldvalue = rn1_scr_view100-svar_txt.
  APPEND lt_dynpr.
  PERFORM read_from_dynpro TABLES lt_dynpr USING 'W'.

ENDFORM.                    " help_svar_spec

*&---------------------------------------------------------------------*
*&      Form  help_avar_spec
*&---------------------------------------------------------------------*
*       F4-value-request for view specific layouts           ID 18129
*----------------------------------------------------------------------*
FORM help_avar_spec USING    p_when     TYPE num1
                    CHANGING p_no_std   TYPE ish_on_off.

  DATA: l_fname         TYPE dynpread-fieldname,
        lt_dynpr        TYPE TABLE OF dynpread WITH HEADER LINE,
        ls_view         TYPE nwview,
        l_einri         TYPE einri,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_rc            TYPE ish_method_rc,
        l_rc_dummy      TYPE ish_method_rc,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_var_old       TYPE rnviewvar,
        l_var_new       TYPE rnviewvar.

  p_no_std = off.

  CHECK g_vcode <> g_vcode_display.

  ls_view-mandt    = sy-mandt.
  ls_view-viewtype = g_viewvar-viewtype.
  ls_view-viewid   = g_viewvar-viewid.
  PERFORM get_einri CHANGING l_einri.

  PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    'F4_A'
                       p_when
                       ls_view
                       g_vcode
                       l_einri
                       l_var_old
                       l_var_new
                       gs_refresh_old
                       gs_refresh
                       l_rc_dummy
              CHANGING p_no_std
                       l_svar_txt
                       l_avar_txt
                       l_fvar_txt
                       l_rc
                       lr_errorhandler.
  IF l_rc <> 0.
    IF lr_errorhandler IS BOUND.
      CALL METHOD lr_errorhandler->display_messages
        EXPORTING
          i_control = on.
    ELSE.
      MESSAGE s230 WITH ' ' ' ' sy-subrc.
*     Anzeigevariante & für Report & konnte nicht gef. werden (Fehler &)
    ENDIF.
    EXIT.
  ENDIF.

  CHECK l_avar_txt IS NOT INITIAL.

  rn1_scr_view100-avar_txt = l_avar_txt.

* set text to dynpro field
  CLEAR lt_dynpr. REFRESH lt_dynpr.
  l_fname = 'RN1_SCR_VIEW100-AVAR_TXT'.
  lt_dynpr-fieldname  = l_fname.
  lt_dynpr-fieldvalue = rn1_scr_view100-avar_txt.
  APPEND lt_dynpr.
  PERFORM read_from_dynpro TABLES lt_dynpr USING 'W'.

ENDFORM.                    " help_avar_spec

*&---------------------------------------------------------------------*
*&      Form  help_fvar_spec
*&---------------------------------------------------------------------*
*       F4-value-request for view specific function variants ID 18129
*----------------------------------------------------------------------*
FORM help_fvar_spec USING    p_when     TYPE num1
                    CHANGING p_no_std   TYPE ish_on_off.

  DATA: l_fname         TYPE dynpread-fieldname,
        lt_dynpr        TYPE TABLE OF dynpread WITH HEADER LINE,
        ls_view         TYPE nwview,
        l_einri         TYPE einri,
        l_svar_txt      TYPE nwsvar_txt,
        l_avar_txt      TYPE nwavar_txt,
        l_fvar_txt      TYPE nwfvar_txt,
        l_rc            TYPE ish_method_rc,
        l_rc_dummy      TYPE ish_method_rc,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_var_old       TYPE rnviewvar,
        l_var_new       TYPE rnviewvar.

  p_no_std = off.

  CHECK g_vcode <> g_vcode_display.

  ls_view-mandt    = sy-mandt.
  ls_view-viewtype = g_viewvar-viewtype.
  ls_view-viewid   = g_viewvar-viewid.
  PERFORM get_einri CHANGING l_einri.

  PERFORM set_variant_data_for_spec CHANGING l_var_old l_var_new.
  PERFORM vp_view_spec_func(sapln1workplace)
              USING    'F4_F'
                       p_when
                       ls_view
                       g_vcode
                       l_einri
                       l_var_old
                       l_var_new
                       gs_refresh_old
                       gs_refresh
                       l_rc_dummy
              CHANGING p_no_std
                       l_svar_txt
                       l_avar_txt
                       l_fvar_txt
                       l_rc
                       lr_errorhandler.
  IF l_rc <> 0.
    IF lr_errorhandler IS BOUND.
      CALL METHOD lr_errorhandler->display_messages
        EXPORTING
          i_control = on.
    ELSE.
      MESSAGE s359 WITH g_viewvar-viewtype.
*     Zu Sichttyp & sind keine Funktionsvarianten vorhanden
    ENDIF.
    EXIT.
  ENDIF.

  CHECK l_fvar_txt IS NOT INITIAL.

  rn1_scr_view100-fvar_txt = l_fvar_txt.

* set text to dynpro field
  CLEAR lt_dynpr. REFRESH lt_dynpr.
  l_fname = 'RN1_SCR_VIEW100-FVAR_TXT'.
  lt_dynpr-fieldname  = l_fname.
  lt_dynpr-fieldvalue = rn1_scr_view100-fvar_txt.
  APPEND lt_dynpr.
  PERFORM read_from_dynpro TABLES lt_dynpr USING 'W'.

ENDFORM.                    " help_fvar_spec
*&---------------------------------------------------------------------*
*&      Form  set_variant_data_for_spec
*&---------------------------------------------------------------------*
*       set variant data for view specific function         ID 18129
*----------------------------------------------------------------------*
*      <--P_VAR_OLD  old variant data
*      <--P_VAR_NEW  new variant data
*----------------------------------------------------------------------*
FORM set_variant_data_for_spec  CHANGING p_var_old  TYPE rnviewvar
                                         p_var_new  TYPE rnviewvar.

  CLEAR: p_var_old, p_var_new.

  p_var_old = g_viewvar.

  p_var_new = g_viewvar.

  p_var_new-svariantid = rn1_scr_view100-svarid.
  p_var_new-avariantid = rn1_scr_view100-avarid.
  p_var_new-fvariantid = rn1_scr_view100-fvarid.

  IF p_var_old = p_var_new.
    p_var_old = g_viewvar_old.
  ENDIF.

ENDFORM.                    " set_variant_data_for_spec
