FUNCTION ishmed_changedocument_display.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_APPLICATIONID) TYPE  REPID
*"     REFERENCE(IS_VARIANT) LIKE  DISVARIANT STRUCTURE  DISVARIANT
*"       OPTIONAL
*"     REFERENCE(IS_LAYOUT) OPTIONAL
*"     REFERENCE(I_FLG_AUTOCONDENSE) TYPE  C OPTIONAL
*"     REFERENCE(I_CB_PROGRAM) LIKE  SY-REPID OPTIONAL
*"     REFERENCE(I_OBJECTCLAS) LIKE  CDHDR-OBJECTCLAS
*"     REFERENCE(IS_SEL_HIDE) TYPE  SLIS_SEL_HIDE_ALV OPTIONAL
*"     REFERENCE(I_SCREEN_START_LINE) DEFAULT 0
*"     REFERENCE(I_SCREEN_START_COLUMN) DEFAULT 0
*"     REFERENCE(I_SCREEN_END_LINE) DEFAULT 0
*"     REFERENCE(I_SCREEN_END_COLUMN) DEFAULT 0
*"     REFERENCE(I_CALLBACK_PF_STATUS_SET) TYPE  SLIS_FORMNAME DEFAULT
*"       SPACE
*"     REFERENCE(IT_EVENTS) TYPE  SLIS_T_EVENT OPTIONAL
*"     VALUE(I_ACTIVEX) TYPE  ISH_ON_OFF DEFAULT ON
*"     VALUE(I_NO_VARIANTS) TYPE  ISH_ON_OFF DEFAULT OFF
*"     VALUE(I_TAB_INFO_INIT) TYPE  ISH_ON_OFF DEFAULT OFF
*"  TABLES
*"      I_CDRED STRUCTURE  CDRED
*"----------------------------------------------------------------------

************************************************************************
* local data declaration
************************************************************************

  DATA:    l_str_variant                 LIKE disvariant,
           l_var_layout                  TYPE slis_layout_alv,
           l_var_sel_hide                TYPE slis_sel_hide_alv,
           l_var_callback_pf_status_set  TYPE slis_formname,
           l_var_print                   TYPE slis_print_alv,
           l_dsc_cdred                   TYPE i,
           l_tmp_percentage              TYPE i,
           l_sav_percentage              TYPE i,
           l_tab_cdreddisp               LIKE cdreddisp OCCURS 100,
           l_wrk_cdreddisp               LIKE cdreddisp,
           l_wrk_cdred                   LIKE cdred,
           l_tab_events                  TYPE slis_t_event,
           l_var_cbprogram               LIKE sy-repid,
           l_tab_fieldcat                TYPE slis_t_fieldcat_alv,
           ls_layout                     TYPE lvc_s_layo,
           lt_fieldcat                   TYPE lvc_t_fcat,
           lt_excl_tab                   TYPE ui_functions,
           lt_excluding                  TYPE slis_t_extab,
           l_excluding                   LIKE LINE OF lt_excluding,
           l_height                      TYPE i,
           l_width                       TYPE i.

************************************************************************
* check parameters
************************************************************************
  DESCRIBE TABLE i_cdred LINES l_dsc_cdred.
  CHECK l_dsc_cdred NE 0.

************************************************************************
* initializiting data
************************************************************************
  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
       EXPORTING
*           percentage = 0
            text       = 'Daten werden initialisiert ...'(001).

  IF is_layout IS INITIAL.
    l_var_layout-colwidth_optimize = 'X'.
    l_var_layout-no_min_linesize   = 'X'.
    l_var_layout-get_selinfos      = 'X'.
  ELSE.
    l_var_layout = is_layout.
  ENDIF.

  IF is_sel_hide IS INITIAL.
  ELSE.
    l_var_sel_hide = is_sel_hide.
  ENDIF.

  IF is_variant IS INITIAL.
    l_str_variant-report = i_applicationid.
  ELSE.
    l_str_variant = is_variant.
  ENDIF.
  IF NOT ( i_cb_program IS INITIAL ).
    l_var_cbprogram = i_cb_program.
    APPEND LINES OF it_events TO l_tab_events.
    l_var_callback_pf_status_set = i_callback_pf_status_set.
  ENDIF.

  PERFORM init_fieldcat USING     i_tab_info_init
                        CHANGING  l_tab_fieldcat[].

  REFRESH: lt_excluding, lt_excl_tab.
  IF i_no_variants = on.
*   ALV-Liste ...
*   Varianten-Funktionen ausblenden
    l_excluding-fcode = '&FG_VARIANT'.
    APPEND l_excluding TO lt_excluding.
*   ALV-Grid ...
*   Varianten-Funktionen ausblenden
    APPEND cl_gui_alv_grid=>mc_fc_maintain_variant TO lt_excl_tab.
    APPEND cl_gui_alv_grid=>mc_fc_current_variant  TO lt_excl_tab.
    APPEND cl_gui_alv_grid=>mc_fc_load_variant     TO lt_excl_tab.
    APPEND cl_gui_alv_grid=>mc_fc_save_variant     TO lt_excl_tab.
  ENDIF.
* F1-Hilfe-Button ausblenden
  l_excluding-fcode = '&ELP'.
  APPEND l_excluding TO lt_excluding.
  APPEND cl_gui_alv_grid=>mc_fc_info               TO lt_excl_tab.
* Div. Funktionen ausblenden
  APPEND cl_gui_alv_grid=>mc_fc_graph              TO lt_excl_tab.
  APPEND cl_gui_alv_grid=>mc_mb_export             TO lt_excl_tab.
  APPEND cl_gui_alv_grid=>mc_mb_view               TO lt_excl_tab.

************************************************************************
* preparing data for display
************************************************************************
  LOOP AT i_cdred INTO l_wrk_cdred.
    l_tmp_percentage = ( sy-tabix * 100 ) / l_dsc_cdred .
    IF l_tmp_percentage NE l_sav_percentage.
      CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
        EXPORTING
          percentage = l_tmp_percentage
          text       = 'Daten werden aufbereitet ...'(002).
    ENDIF.
    l_sav_percentage = l_tmp_percentage.

    MOVE-CORRESPONDING l_wrk_cdred TO l_wrk_cdreddisp.
    PERFORM add_user_details CHANGING l_wrk_cdreddisp.

    IF i_flg_autocondense = 'X'.
      CONDENSE l_wrk_cdreddisp-f_new.
      CONDENSE l_wrk_cdreddisp-f_old.
    ENDIF.

    PERFORM add_ddic_details CHANGING l_wrk_cdreddisp.

    APPEND l_wrk_cdreddisp TO l_tab_cdreddisp.
  ENDLOOP.

************************************************************************
* calling ALVIS
************************************************************************
  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
       EXPORTING
*        percentage = 0
         text       = 'ALV wird gestartet ...'(003).

  IF i_activex = off.
    CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
       EXPORTING
*           I_INTERFACE_CHECK        = ' '
            i_callback_program       = l_var_cbprogram
            i_callback_pf_status_set = l_var_callback_pf_status_set
*           I_CALLBACK_USER_COMMAND  = ' '
*           I_STRUCTURE_NAME         =
            is_layout                = l_var_layout
            it_fieldcat              = l_tab_fieldcat[]
            it_excluding             = lt_excluding
*           IT_SPECIAL_GROUPS        =
*           IT_SORT                  =
*           IT_FILTER                =
            is_sel_hide              = l_var_sel_hide
*           I_DEFAULT                = 'X'
            i_save                   = 'X'
            is_variant               = l_str_variant
            it_events                = l_tab_events
*           IT_EVENT_EXIT            =
            is_print                 = l_var_print
*           IS_REPREP_ID             =
            i_screen_start_column    = i_screen_start_column
            i_screen_start_line      = i_screen_start_line
            i_screen_end_column      = i_screen_end_column
            i_screen_end_line        = i_screen_end_line
*      IMPORTING
*           E_EXIT_CAUSED_BY_CALLER  =
*           ES_EXIT_CAUSED_BY_USER   =
       TABLES
            t_outtab                 = l_tab_cdreddisp
       EXCEPTIONS
            program_error            = 1
            OTHERS                   = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ELSE.
    l_height = i_screen_end_line   - i_screen_start_line.
    l_width  = i_screen_end_column - i_screen_start_column.
    CALL FUNCTION 'LVC_TRANSFER_FROM_SLIS'
      EXPORTING
        it_fieldcat_alv = l_tab_fieldcat
        is_layout_alv   = l_var_layout
      IMPORTING
        et_fieldcat_lvc = lt_fieldcat
        es_layout_lvc   = ls_layout
      TABLES
        it_data         = l_tab_cdreddisp
      EXCEPTIONS
        it_data_missing = 1
        OTHERS          = 2.
    IF sy-subrc <> 0.
    ENDIF.
    CALL FUNCTION 'ISHMED_F4_ALLG_ACTIVEX'
      EXPORTING
        it_f4tab         = l_tab_cdreddisp
        it_fieldcat      = lt_fieldcat
        i_vcode          = 'DIS'
        i_title          = l_var_layout-window_titlebar
        i_xk             = i_screen_start_column
        i_yk             = i_screen_start_line
        i_width          = l_width
        i_height         = l_height
        it_function_excl = lt_excl_tab
        is_variant       = l_str_variant
        is_layout        = ls_layout.
  ENDIF.

ENDFUNCTION.
