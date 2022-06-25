class CL_ISH_CHECK_LIST definition
  public
  create public .

public section.
*"* public components of class CL_ISH_CHECK_LIST
*"* do not include other source files here!!!
  type-pools ICON .

  constants CO_CHECKBOX type RNT40-MARK value 1. "#EC NOTEXT
  constants CO_STANDARD type RNT40-MARK value 2. "#EC NOTEXT
  constants CO_BUTTON type RNT40-MARK value 3. "#EC NOTEXT
  constants CO_DISPLAY type TNDYM-VCODE value 'DIS'. "#EC NOTEXT
  constants CO_UPDATE type TNDYM-VCODE value 'UPD'. "#EC NOTEXT
  data G_CHECK_LIST type ref to CL_GUI_ALV_GRID .
  data G_TITLE type RNT40-GPNAM .

  events BUTTON_CLICK
    exporting
      value(ES_COL_ID) type LVC_S_COL
      value(ES_ROW_NO) type LVC_S_ROID .
  events DATA_CHANGED .

  methods CONSTRUCTOR
    importing
      value(I_PARENT) type ref to CL_GUI_CONTAINER optional
      value(I_GRID_LAYOUT) type LVC_S_LAYO optional
      value(GT_FIELDCAT) type LVC_T_FCAT optional
      value(I_MARK) type RNT40-MARK optional .
  methods GET_SEL_ENTRIES
    exporting
      value(E_OUTTAB_MARK) type ISH_T_RN1CHECKLIST .
  methods HANDLE_BUTTON_CLICK
    for event BUTTON_CLICK of CL_GUI_ALV_GRID
    importing
      !ES_COL_ID
      !ES_ROW_NO .
  methods HANDLE_DATA_CHANGED
    for event DATA_CHANGED of CL_GUI_ALV_GRID
    importing
      !ER_DATA_CHANGED
      !E_ONF4
      !E_ONF4_BEFORE
      !E_ONF4_AFTER .
  methods SET_SEL_ENTRIES
    importing
      value(I_OUTTAB_MARK) type ISH_T_RN1CHECKLIST
      value(I_MARK) type RNT40-MARK .
  methods REFRESH_TABLE_DISPLAY .
  methods CREATE_DISPLAY
    importing
      value(I_MARK) type RNT40-MARK
      value(I_GRID_LAYOUT) type LVC_S_LAYO optional
      value(I_OUTTAB_MARK) type ISH_T_RN1CHECKLIST optional
      value(I_FIELDCAT) type LVC_T_FCAT optional
      value(I_TOOLBAR_EXCLUDING) type UI_FUNCTIONS optional
      value(I_EXCEPT_QINFO) type LVC_T_QINF optional
      value(I_VCODE) type TNDYM-VCODE default 'UPD' .
  methods FREE .
protected section.
*"* protected components of class CL_ISH_CHECK_LIST
*"* do not include other source files here!!!

  types:
    begin of ty_checklist.
         include type rn1checklist.
  types: field6(4) type c.
  types: end of ty_checklist .
  types:
    tyt_checklist type standard table of ty_checklist .
  types:
    begin of ty_es_col_id.
         include type lvc_s_col.
  types: end of ty_es_col_id .
  types:
    tyt_es_col_id type standard table of ty_es_col_id .
  types:
    begin of ty_es_row_no.
         include type lvc_s_roid.
  types: end of ty_es_row_no .
  types:
    tyt_es_row_no type standard table of ty_es_row_no .
* ANDERLN181203 extended Check - package dependencies
*  types:
*    begin of ty_n1fst.
*         include type n1fst.
*  types: end of ty_n1fst .
*  types:
*    tyt_n1fst type standard table of ty_n1fst .

  data GT_FIELDCAT type LVC_T_FCAT .
  data GT_RN1CHECKLIST type ISH_T_RN1CHECKLIST .
  data GT_OUTTAB type TYT_CHECKLIST .
  data GT_ES_COL_ID type TYT_ES_COL_ID .
  data GT_ES_ROW_NO type TYT_ES_ROW_NO .
  data G_MARK type RNT40-MARK .
  data G_VCODE type ISH_VCODE value 'UPD' .

  methods SWITCH_BUTTON
    importing
      value(ES_COL_ID) type TYT_ES_COL_ID
      value(ES_ROW_NO) type TYT_ES_ROW_NO .
  methods FILL_FIELDCAT
    importing
      value(I_MARK) type RNT40-MARK optional
    returning
      value(T_FIELDCAT) type LVC_T_FCAT .
  methods EXPAND_FIELDCAT
    importing
      value(I_MARK) type RNT40-MARK
      value(I_VCODE) type TNDYM-VCODE default 'UPD'
    changing
      value(GT_FIELDCAT) type LVC_T_FCAT optional .
  methods CHANGE_DATA
    importing
      value(ER_DATA_CHANGED) type ref to CL_ALV_CHANGED_DATA_PROTOCOL .
private section.
*"* private components of class CL_ISH_CHECK_LIST
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_CHECK_LIST IMPLEMENTATION.


METHOD change_data.

  DATA: ls_mod_cells  TYPE lvc_s_modi.
  DATA: l_help(10)    TYPE c.

  LOOP AT er_data_changed->mt_good_cells INTO ls_mod_cells.
    CASE ls_mod_cells-fieldname.
      WHEN 'FIELD6' OR 'FIELD5'.
        CALL METHOD er_data_changed->get_cell_value
          EXPORTING
            i_row_id    = ls_mod_cells-row_id
            i_fieldname = ls_mod_cells-fieldname
          IMPORTING
            e_value     = l_help.
    ENDCASE.
  ENDLOOP.

ENDMETHOD.


METHOD constructor.

* Instanzierung der Super-Klasse cl_ish_check_list
  CREATE OBJECT g_check_list
    EXPORTING
*     I_SHELLSTYLE      = 0
*     I_LIFETIME        =
      i_parent          = i_parent
*     I_APPL_EVENTS     = space
*     I_PARENTDBG       =
*     I_APPLOGPARENT    =
*     I_GRAPHICSPARENT  =
*     I_USE_VARIANT_CLASS = SPACE
*     I_NAME            =
*  EXCEPTIONS
*     ERROR_CNTL_CREATE = 1
*     ERROR_CNTL_INIT   = 2
*     ERROR_CNTL_LINK   = 3
*     ERROR_DP_CREATE   = 4
*     others            = 5
      .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDMETHOD.


METHOD create_display.

  DATA: lt_outtab_mark TYPE STANDARD TABLE OF rn1checklist.

  IF i_mark = co_standard.
    i_grid_layout-sel_mode = 'A'.
  ENDIF.

* i_fieldcat  = Feldkatalog wird im Programm zusammengestellt
* gt_fieldcat = Feldkatalog wird in einer Subklasse zusammengestellt
  IF NOT i_fieldcat[] IS INITIAL.
    gt_fieldcat[] = i_fieldcat[].
  ENDIF.

  IF NOT gt_fieldcat[] IS INITIAL.
    CALL METHOD me->expand_fieldcat
      EXPORTING
        i_mark      = i_mark
        i_vcode     = i_vcode
      CHANGING
        gt_fieldcat = gt_fieldcat[].
  ELSE.
*   Default-Feldkatalog
    CALL METHOD me->fill_fieldcat
      EXPORTING
        i_mark     = i_mark
      RECEIVING
        t_fieldcat = gt_fieldcat[].
    CALL METHOD me->expand_fieldcat
      EXPORTING
        i_mark      = i_mark
      CHANGING
        gt_fieldcat = gt_fieldcat[].
  ENDIF.


  CALL METHOD g_check_list->set_table_for_first_display
      EXPORTING
        i_buffer_active               = ' '
*        I_STRUCTURE_NAME              =
*        IS_VARIANT                    =
*        I_SAVE                        =
*        I_DEFAULT                     = 'X'
        is_layout                     = i_grid_layout
*        IS_PRINT                      =
*        IT_SPECIAL_GROUPS             =
        it_toolbar_excluding          = i_toolbar_excluding
        it_except_qinfo               = i_except_qinfo
*        IT_HYPERLINK                  =
*        IT_ALV_GRAPHICS               =
      CHANGING
        it_outtab                     = gt_outtab[]
        it_fieldcatalog               = gt_fieldcat[]
*        IT_SORT                       =
*        IT_FILTER                     =
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.

  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  SET HANDLER me->handle_button_click FOR g_check_list.
  SET HANDLER me->handle_data_changed FOR g_check_list.

  CALL METHOD g_check_list->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_modified.

  lt_outtab_mark[] = i_outtab_mark[].

* Methode zum setzen der selektierten Einträge
  CALL METHOD me->set_sel_entries
    EXPORTING
      i_outtab_mark = lt_outtab_mark
      i_mark        = i_mark.

ENDMETHOD.


METHOD expand_fieldcat.

  DATA: l_wa_fieldcat TYPE lvc_s_fcat.

  IF i_mark = co_button OR i_mark = co_checkbox.

    l_wa_fieldcat-col_pos   = 6.
    l_wa_fieldcat-fieldname = 'FIELD6'.
    l_wa_fieldcat-tabname   = '1'.
    l_wa_fieldcat-seltext   = 'Auswahl'(001).
    IF i_mark = co_checkbox.
      l_wa_fieldcat-reptext   = icon_checkbox.
      l_wa_fieldcat-checkbox  = 'X'.
      l_wa_fieldcat-style     = cl_gui_alv_grid=>mc_style_disabled.
    ELSE.
      l_wa_fieldcat-reptext   = icon_space.
      l_wa_fieldcat-icon      = 'X'.
*     Attribut einer Klasse ansprechen
      IF i_vcode <> co_display.
        l_wa_fieldcat-style     = cl_gui_alv_grid=>mc_style_button.
      ENDIF.
    ENDIF.
    IF i_mark = co_button.
      l_wa_fieldcat-datatype  = 'CHAR'.
      l_wa_fieldcat-intlen    = 4.
      l_wa_fieldcat-domname   = 'TEXT04'.
      l_wa_fieldcat-ref_table = 'RN1CHECKLIST'.
      l_wa_fieldcat-dd_outlen = 1.
      l_wa_fieldcat-outputlen = 3.
    ELSE.
      l_wa_fieldcat-datatype  = 'CHAR'.
      l_wa_fieldcat-intlen    = 1.
      l_wa_fieldcat-domname   = 'ISH_ON_OFF'.
*      l_wa_fieldcat-ref_table = 'RN1CHECKLIST'.
      l_wa_fieldcat-dd_outlen = 1.
      l_wa_fieldcat-outputlen = 3.
    ENDIF.
    APPEND l_wa_fieldcat TO gt_fieldcat.

    LOOP AT gt_fieldcat INTO l_wa_fieldcat.
      CASE l_wa_fieldcat-fieldname.
        WHEN 'FIELD1' OR 'FIELD2' OR 'FIELD3' OR 'FIELD4' OR 'FIELD5'.
          l_wa_fieldcat-col_pos = l_wa_fieldcat-col_pos + 1.
        WHEN 'FIELD6'.
          l_wa_fieldcat-col_pos = 1.
          IF i_vcode = co_display.
            l_wa_fieldcat-emphasize = 'C001'.
          ENDIF.
        WHEN 'STYLE'.
          l_wa_fieldcat-tech = 'X'.
      ENDCASE.
      MODIFY gt_fieldcat FROM l_wa_fieldcat.
    ENDLOOP.

    SORT gt_fieldcat BY col_pos.

  ELSE.

    LOOP AT gt_fieldcat INTO l_wa_fieldcat.
      CASE l_wa_fieldcat-fieldname.
        WHEN 'FIELD6' or 'STYLE'.
          l_wa_fieldcat-tech = 'X'.
        WHEN OTHERS.
      ENDCASE.
      MODIFY gt_fieldcat FROM l_wa_fieldcat.
    ENDLOOP.

  ENDIF.

ENDMETHOD.


METHOD fill_fieldcat.

  DATA: lt_fieldcat TYPE lvc_t_fcat.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*      I_BUFFER_ACTIVE              =
      i_structure_name             = 'RN1CHECKLIST'
*      I_CLIENT_NEVER_DISPLAY       = 'X'
*      I_BYPASSING_BUFFER           =
    CHANGING
      ct_fieldcat                  = lt_fieldcat[]
    EXCEPTIONS
      inconsistent_interface       = 1
      program_error                = 2
      OTHERS                       = 3.

  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*          WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  t_fieldcat[] = lt_fieldcat[].

ENDMETHOD.


METHOD FREE .

  CALL METHOD g_check_list->free
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

  free g_check_list.
ENDMETHOD.


METHOD get_sel_entries.

  DATA: lt_selected_rows      TYPE lvc_t_row.
  DATA: lt_selected_rows_id   TYPE lvc_t_roid.
  DATA: l_wa_selected_rows_id TYPE lvc_s_roid.
  DATA: l_idx                 LIKE sy-tabix.
  DATA: l_idx2                LIKE sy-tabix.
  DATA: l_wa_outtab1          TYPE ty_checklist.
  DATA: lt_outtab             TYPE STANDARD TABLE OF ty_checklist.
  DATA: l_wa_outtab2          TYPE ty_checklist.
  DATA: l_outtab_mark         LIKE LINE OF e_outtab_mark.
*----------------------------------------------------------------------*

  CLEAR:   lt_selected_rows, lt_selected_rows_id.
  REFRESH: lt_selected_rows, lt_selected_rows_id.

  IF g_mark = co_standard.
*   Ermittlung aller ausgewählten Zeilen
    CALL METHOD g_check_list->get_selected_rows
      IMPORTING
        et_index_rows = lt_selected_rows
        et_row_no     = lt_selected_rows_id.

    SORT lt_selected_rows_id BY row_id.
    DELETE ADJACENT DUPLICATES FROM lt_selected_rows_id
                               COMPARING row_id.

    IF NOT lt_selected_rows_id[] IS INITIAL.
      LOOP AT lt_selected_rows_id INTO l_wa_selected_rows_id.
        l_idx = sy-tabix.
        READ TABLE gt_outtab INTO l_wa_outtab1
                             INDEX l_wa_selected_rows_id-row_id.
        l_idx2 = sy-tabix.
        IF sy-subrc = 0.
          l_wa_outtab2 = l_wa_outtab1.
          APPEND l_wa_outtab2 TO lt_outtab.
          MODIFY gt_outtab FROM l_wa_outtab1 INDEX l_idx2.
        ENDIF.
      MODIFY lt_selected_rows_id FROM l_wa_selected_rows_id INDEX l_idx.
      ENDLOOP.
    ENDIF.
  ELSEIF g_mark = co_button.
    LOOP AT gt_outtab INTO l_wa_outtab1 WHERE field6 = icon_led_green.
      l_idx = sy-tabix.
      IF sy-subrc = 0.
        l_wa_outtab2 = l_wa_outtab1.
        APPEND l_wa_outtab2 TO lt_outtab.
        MODIFY gt_outtab FROM l_wa_outtab1 INDEX l_idx.
      ENDIF.
    ENDLOOP.
  ELSEIF g_mark = co_checkbox.
    LOOP AT gt_outtab INTO l_wa_outtab1 WHERE field6 = 'X'.
      l_idx = sy-tabix.
      IF sy-subrc = 0.
        l_wa_outtab2 = l_wa_outtab1.
        APPEND l_wa_outtab2 TO lt_outtab.
        MODIFY gt_outtab FROM l_wa_outtab1 INDEX l_idx.
      ENDIF.
    ENDLOOP.
  ENDIF.

*  e_outtab_mark[] = lt_outtab[].
  REFRESH e_outtab_mark.
  LOOP AT lt_outtab INTO l_wa_outtab1.
    CLEAR l_outtab_mark.
    MOVE-CORRESPONDING l_wa_outtab1 TO l_outtab_mark.
    APPEND l_outtab_mark TO e_outtab_mark.
  ENDLOOP.

ENDMETHOD.


METHOD handle_button_click.

* button_click:
* wir bekommen mit: ES_COL_ID: SpaltenId
*                   ES_ROW_NO: Numerische Zeilen ID

  CLEAR: gt_es_col_id, gt_es_row_no.
  REFRESH: gt_es_col_id, gt_es_row_no.

  APPEND es_col_id TO gt_es_col_id.
  APPEND es_row_no TO gt_es_row_no.

  CHECK g_vcode = co_update.

  CALL METHOD me->switch_button
    EXPORTING
      es_col_id = gt_es_col_id
      es_row_no = gt_es_row_no.

ENDMETHOD.


METHOD handle_data_changed.

*data: data_changed type REF TO CL_ALV_CHANGED_DATA_PROTOCOL.
*
*data_changed = er_data_changed.
*
*CALL METHOD me->change_data
*  EXPORTING
*    er_data_changed = data_changed.

ENDMETHOD.


METHOD refresh_table_display.

  CALL METHOD g_check_list->refresh_table_display
*    EXPORTING
*     IS_STABLE      =
*     I_SOFT_REFRESH =
    EXCEPTIONS
      finished       = 1
      OTHERS         = 2.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD set_sel_entries.

  DATA: l_wa_outtab_inp       LIKE LINE OF i_outtab_mark.
  DATA: l_wa_outtab_mark      TYPE ty_checklist.
  DATA: l_wa_outtab           TYPE ty_checklist.
  DATA: l_idx                 TYPE sy-tabix.
  DATA: lt_row_no             TYPE STANDARD TABLE OF lvc_s_roid.
  DATA: l_wa_row_no           TYPE lvc_s_roid.
  DATA: l_idx2                LIKE sy-tabix.
  DATA: lt_index_rows         TYPE STANDARD TABLE OF lvc_s_row.
  DATA: l_wa_index_rows       TYPE lvc_s_row.

  CLEAR lt_index_rows.
  REFRESH lt_index_rows.

  IF i_mark = co_button OR i_mark = co_checkbox.

    LOOP AT i_outtab_mark INTO l_wa_outtab_inp.
      MOVE-CORRESPONDING l_wa_outtab_inp TO l_wa_outtab_mark.
      READ TABLE gt_outtab INTO l_wa_outtab WITH KEY
                           field1 = l_wa_outtab_mark-field1
                           field2 = l_wa_outtab_mark-field2
                           field3 = l_wa_outtab_mark-field3
                           field4 = l_wa_outtab_mark-field4.
      IF sy-subrc = 0.
        l_idx = sy-tabix.
        IF i_mark = co_button.
          l_wa_outtab-field6 = icon_led_green.
        ELSE.
          l_wa_outtab-field6 = 'X'.
        ENDIF.
        MODIFY gt_outtab FROM l_wa_outtab INDEX l_idx.
      ENDIF.
    ENDLOOP.

    CALL METHOD me->refresh_table_display.

  ELSE.

    CLEAR: l_idx, l_idx2.

    LOOP AT i_outtab_mark INTO l_wa_outtab_inp.
      MOVE-CORRESPONDING l_wa_outtab_inp TO l_wa_outtab_mark.
      l_idx = sy-tabix.
      READ TABLE gt_outtab INTO l_wa_outtab WITH KEY
                           field1 = l_wa_outtab_mark-field1
                           field2 = l_wa_outtab_mark-field2
                           field3 = l_wa_outtab_mark-field3
                           field4 = l_wa_outtab_mark-field4.
      IF sy-subrc = 0.
        l_idx2 = sy-tabix.
        l_wa_outtab-field6 = 'X'.
        l_wa_row_no-row_id = sy-tabix.
        l_wa_index_rows-index = sy-tabix.
        APPEND l_wa_row_no TO lt_row_no.
        APPEND l_wa_index_rows TO lt_index_rows.
        MODIFY gt_outtab FROM l_wa_outtab INDEX l_idx2.
      ENDIF.
*      MODIFY i_outtab_mark FROM l_wa_outtab_mark INDEX l_idx.
    ENDLOOP.


    CALL METHOD g_check_list->set_selected_rows
      EXPORTING
        it_index_rows = lt_index_rows.

  ENDIF.

ENDMETHOD.


METHOD switch_button.

  DATA: l_wa_es_row_no  TYPE lvc_s_roid.
  DATA: l_wa_outtab     TYPE ty_checklist.
  DATA: l_idx           LIKE sy-tabix.

  LOOP AT gt_es_row_no INTO l_wa_es_row_no.
    l_idx = sy-tabix.
    READ TABLE gt_outtab INTO l_wa_outtab INDEX l_wa_es_row_no-row_id.
    IF sy-subrc = 0.
      IF l_wa_outtab-field6 = icon_led_inactive.
        l_wa_outtab-field6 = icon_led_green.
      ELSE.
        l_wa_outtab-field6 = icon_led_inactive.
      ENDIF.
      MODIFY gt_outtab FROM l_wa_outtab INDEX sy-tabix.
    ENDIF.
    MODIFY gt_es_row_no FROM l_wa_es_row_no INDEX l_idx.
  ENDLOOP.

  CALL METHOD g_check_list->refresh_table_display
*    EXPORTING
*      IS_STABLE      =
*      I_SOFT_REFRESH =
*    EXCEPTIONS
*      FINISHED       = 1
*      others         = 2
          .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDMETHOD.
ENDCLASS.
