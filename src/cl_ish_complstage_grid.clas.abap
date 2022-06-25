class CL_ISH_COMPLSTAGE_GRID definition
  public
  create protected .

*"* public components of class CL_ISH_COMPLSTAGE_GRID
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_COMPLSTAGE_GRID type ISH_OBJECT_TYPE value 12187. "#EC NOTEXT

  methods CHECK
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  type-pools ABAP .
  methods CHECK_FOR_CHANGE
    returning
      value(R_CHANGED) type ABAP_BOOL .
  methods CONSTRUCTOR .
  class-methods CREATE
    importing
      !IR_MONCON type ref to CL_ISH_MONCON
    returning
      value(RR_COMPLSTAGE_GRID) type ref to CL_ISH_COMPLSTAGE_GRID
    raising
      CX_ISH_STATIC_HANDLER .
  methods DESTROY .
  methods FIRST_DISPLAY
    importing
      value(I_VCODE) type ISH_VCODE default 'DIS'
      !IR_CONTAINER type ref to CL_GUI_CONTAINER
    preferred parameter I_VCODE
    raising
      CX_ISH_STATIC_HANDLER .
  methods REFRESH
    importing
      value(I_VCODE) type ISH_VCODE optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods SAVE
    importing
      value(I_UPDATE_TASK) type ABAP_BOOL default ABAP_ON
      value(I_COMMIT) type ABAP_BOOL default ABAP_ON
    exporting
      value(E_SAVED) type ABAP_BOOL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_COMPLSTAGE_GRID
*"* do not include other source files here!!!

  data GR_GRID type ref to CL_GUI_ALV_GRID .
  data GR_CONTAINER type ref to CL_GUI_CONTAINER .
  data GR_MONCON type ref to CL_ISH_MONCON .
  data GS_LAYOUT type LVC_S_LAYO .
  data GT_EXCL_FUNCTIONS type UI_FUNCTIONS .
  data GT_FIELDCAT type LVC_T_FCAT .
  data GT_OUTTAB type ISH_T_COMPLSTAGE_DATAOBJ .
  data G_VCODE type ISH_VCODE .

  methods BUILD_EXCL_FUNC_TAB .
  methods BUILD_FIELDCAT
    raising
      CX_ISH_STATIC_HANDLER .
  methods BUILD_LAYOUT .
  methods BUILD_OUTTAB .
  methods HANDLE_DATA_CHANGED
    for event DATA_CHANGED of CL_GUI_ALV_GRID
    importing
      !ER_DATA_CHANGED
      !E_ONF4
      !E_ONF4_BEFORE
      !E_ONF4_AFTER
      !E_UCOMM .
  methods HANDLE_DATA_CHANGED_FINISHED
    for event DATA_CHANGED_FINISHED of CL_GUI_ALV_GRID
    importing
      !E_MODIFIED .
  methods HANDLE_ON_F4
    for event ONF4 of CL_GUI_ALV_GRID
    importing
      !E_FIELDNAME
      !E_FIELDVALUE
      !ES_ROW_NO
      !ER_EVENT_DATA
      !ET_BAD_CELLS
      !E_DISPLAY .
  methods REGISTER_EVENTS .
private section.
*"* private components of class CL_ISH_COMPLSTAGE_GRID
*"* do not include other source files here!!!

  methods CHECK_ICONS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
ENDCLASS.



CLASS CL_ISH_COMPLSTAGE_GRID IMPLEMENTATION.


METHOD build_excl_func_tab.

* Workarea
  DATA: ls_function LIKE LINE OF gt_excl_functions.

  REFRESH: gt_excl_functions.

* --- --- --- --- --- --- ---
* Einsetzen
  ls_function = cl_gui_alv_grid=>mc_mb_paste.
  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---
* Kopieren
  ls_function = cl_gui_alv_grid=>mc_fc_loc_copy.
  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---
* Zeile kopieren
  ls_function = cl_gui_alv_grid=>mc_fc_loc_copy_row.
  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---
* Ausschneiden
  ls_function = cl_gui_alv_grid=>mc_fc_loc_cut.
  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---
** Zeile löschen
*  ls_function = cl_gui_alv_grid=>mc_fc_loc_delete_row.
*  INSERT ls_function INTO TABLE gt_excl_functions.
** --- --- --- --- --- --- ---
** Neue Zeile
*  ls_function = cl_gui_alv_grid=>mc_fc_loc_insert_row.
*  INSERT ls_function INTO TABLE gt_excl_functions.
** --- --- --- --- --- --- ---
** Zeile anhängen
*  ls_function = cl_gui_alv_grid=>mc_fc_loc_append_row.
*  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---
* Verschieben
  ls_function = cl_gui_alv_grid=>mc_fc_loc_move_row.
  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---
* Einfügen
  ls_function = cl_gui_alv_grid=>mc_fc_loc_paste.
  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---
* Einfügen neu
  ls_function = cl_gui_alv_grid=>mc_fc_loc_paste_new_row.
  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---
* Rückgängig machen
  ls_function = cl_gui_alv_grid=>mc_fc_loc_undo.
  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---
* Aktualisieren
  ls_function = cl_gui_alv_grid=>mc_fc_refresh.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Aufsteigend Sortieren
  ls_function = cl_gui_alv_grid=>mc_fc_sort_asc.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Absteigend Sortieren
  ls_function = cl_gui_alv_grid=>mc_fc_sort_dsc.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Filter setzen ...
  ls_function = cl_gui_alv_grid=>mc_fc_filter.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Summe
  ls_function = cl_gui_alv_grid=>mc_mb_sum.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Drucken
  ls_function = cl_gui_alv_grid=>mc_fc_print.
  INSERT ls_function INTO TABLE gt_excl_functions.
  ls_function = cl_gui_alv_grid=>mc_fc_print_back.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Info (Doku)
  ls_function = cl_gui_alv_grid=>mc_fc_info.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Ansichten
  ls_function = cl_gui_alv_grid=>mc_mb_view.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Exportieren
  ls_function = cl_gui_alv_grid=>mc_mb_export.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Layout ändern
  ls_function = cl_gui_alv_grid=>mc_mb_view.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Layout ändern
  ls_function = cl_gui_alv_grid=>mc_mb_variant.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Einblenden
  ls_function = cl_gui_alv_grid=>mc_fc_current_variant.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Ausblenden
  ls_function = cl_gui_alv_grid=>mc_fc_col_invisible.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Grafik anzeigen
  ls_function = cl_gui_alv_grid=>mc_fc_graph.
  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---
* Prüfen
  ls_function = cl_gui_alv_grid=>mc_fc_check.
  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---
* Detail
  ls_function = cl_gui_alv_grid=>mc_fc_detail.
  INSERT ls_function INTO TABLE gt_excl_functions.
* ----------
* Suchen
*  ls_function = cl_gui_alv_grid=>mc_fc_find.
*  INSERT ls_function INTO TABLE gt_excl_functions.
* --- --- --- --- --- --- ---

ENDMETHOD.


METHOD build_fieldcat.

  DATA: lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling,
        ls_fieldcat       LIKE LINE OF gt_fieldcat.

  REFRESH: gt_fieldcat.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'RN1COMPLSTAGE_DATAOBJ'
      i_bypassing_buffer     = 'X'
    CHANGING
      ct_fieldcat            = gt_fieldcat[]
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    CREATE OBJECT lr_errorhandler.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_COMPLSTAGE_GRID'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  LOOP AT gt_fieldcat INTO ls_fieldcat.
    IF g_vcode <> co_vcode_display.
      ls_fieldcat-edit      = on.
    ENDIF.
    CASE ls_fieldcat-fieldname.
      WHEN 'COMPLETION_LOW'.
        ls_fieldcat-col_pos     = 1.
        ls_fieldcat-outputlen   = 5.
      WHEN 'COMPLETION_HIGH'.
        ls_fieldcat-col_pos     = 2.
        ls_fieldcat-outputlen   = 5.
      WHEN 'ICON_NAME'.
        ls_fieldcat-col_pos     = 3.
        ls_fieldcat-outputlen   = 20.
        ls_fieldcat-f4availabl  = on.
      WHEN 'COMPLETION_ICON'.
        ls_fieldcat-col_pos     = 4.
        ls_fieldcat-outputlen   = 5.
        ls_fieldcat-icon        = on.
        ls_fieldcat-edit        = off.
      WHEN 'COMPLETION_NAME'.
        ls_fieldcat-col_pos     = 5.
        ls_fieldcat-outputlen   = 30.
    ENDCASE.
    MODIFY gt_fieldcat FROM ls_fieldcat.
  ENDLOOP.

ENDMETHOD.


METHOD build_layout.

  CLEAR gs_layout.

*  gs_layout-cwidth_opt  =  'X'.      " Spaltenbreite optimieren
*  gs_layout-smalltitle =  'X'.
*  gs_layout-sel_mode   =  'B'.
*  gs_layout-no_rowmark =  'X'.
*  gs_layout-stylefname =  g_style_fname.
*  gs_layout-sgl_clk_hd =  ' '.

ENDMETHOD.


METHOD build_outtab.

  DATA: lt_complstage    TYPE ish_t_complstage_obj,
        ls_complstage    LIKE LINE OF lt_complstage,
        ls_outtab        LIKE LINE OF gt_outtab.

  REFRESH gt_outtab.

  TRY.
      CALL METHOD gr_moncon->get_complstages
        RECEIVING
          rt_complstage = lt_complstage.
    CATCH cx_ish_static_handler .
      EXIT.
  ENDTRY.

  LOOP AT lt_complstage INTO ls_complstage.
    CLEAR ls_outtab.
    ls_outtab-r_complstage = ls_complstage-r_complstage.
    CALL METHOD ls_complstage-r_complstage->get_completion_low
      RECEIVING
        r_completion_low = ls_outtab-completion_low.
    CALL METHOD ls_complstage-r_complstage->get_completion_high
      RECEIVING
        r_completion_high = ls_outtab-completion_high.
    CALL METHOD ls_complstage-r_complstage->get_completion_icon
      RECEIVING
        r_completion_icon = ls_outtab-completion_icon.
    IF ls_outtab-completion_icon IS NOT INITIAL.
      SELECT SINGLE name FROM icon INTO ls_outtab-icon_name
             WHERE  id  = ls_outtab-completion_icon.
    ENDIF.
    CALL METHOD ls_complstage-r_complstage->get_completion_name
      RECEIVING
        r_completion_name = ls_outtab-completion_name.
    APPEND ls_outtab TO gt_outtab.
  ENDLOOP.

  SORT gt_outtab BY completion_low.

ENDMETHOD.


METHOD check.

  DATA: lr_cx_static_handler  TYPE REF TO cx_ish_static_handler,
        l_rc                  TYPE ish_method_rc.

  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CALL METHOD me->check_for_change.

  TRY.
      CALL METHOD gr_moncon->check
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
    CATCH cx_ish_static_handler INTO lr_cx_static_handler.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
        EXPORTING
          i_exceptions    = lr_cx_static_handler
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = 1.
  ENDTRY.

  CALL METHOD me->check_icons
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


METHOD check_for_change.

  DATA: l_valid(1)      TYPE c.

* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---  *
  r_changed = abap_off.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---  *

* Durch den Aufruf dieser Methode wird das Ereignis "data changed"
* angestoßen. Somit erfolgt zuerst einmal eine Prüfung der Daten.
  CALL METHOD gr_grid->check_changed_data
    IMPORTING
      e_valid = l_valid.

  IF l_valid = abap_off.
    r_changed = abap_on.
  ELSE.
    IF gr_moncon->is_changed( ) = abap_on.
      r_changed = abap_on.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD check_icons.

  DATA: ls_outtab             LIKE LINE OF gt_outtab,
        l_id                  TYPE icon-id.              "#EC NEEDED

  CLEAR e_rc.

  LOOP AT gt_outtab INTO ls_outtab WHERE icon_name       IS NOT INITIAL
                                     AND completion_icon IS INITIAL.
    SELECT id FROM icon INTO l_id
           WHERE  name  = ls_outtab-icon_name.
      EXIT.
    ENDSELECT.
    IF sy-subrc <> 0.
      IF cr_errorhandler IS INITIAL.
        CREATE OBJECT cr_errorhandler.
      ENDIF.
      e_rc = 1.
*     Ikone &1 existiert nicht.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ = 'E'
          i_kla = 'SEEF_BADI'
          i_num = '040'
          i_mv1 = ls_outtab-icon_name.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD constructor.                                         "#EC NEEDED

ENDMETHOD.


METHOD create.

  DATA: lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.

  IF ir_moncon IS INITIAL.
    CREATE OBJECT lr_errorhandler.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_COMPLSTAGE_GRID'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ELSE.
    CREATE OBJECT rr_complstage_grid.
    CHECK rr_complstage_grid IS BOUND.
    rr_complstage_grid->gr_moncon = ir_moncon.
  ENDIF.

ENDMETHOD.


METHOD destroy.

  DATA: l_valid     TYPE i.

* DO NOT destroy GR_CONTAINER + GR_MONCON (given by CALLER!)

  IF gr_grid IS BOUND.
    CALL METHOD gr_grid->is_valid
      IMPORTING
        RESULT = l_valid.
    IF l_valid = 1.
      CALL METHOD gr_grid->free
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2.
      IF sy-subrc <> 0.
        CLEAR gr_grid.
      ENDIF.
    ENDIF.
  ENDIF.

  CLEAR: gr_grid,
         gs_layout,
         gt_excl_functions[],
         gt_fieldcat[],
         gt_outtab[],
         g_vcode.

ENDMETHOD.


METHOD first_display.

  DATA: lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.

  REFRESH: gt_outtab.

  IF ir_container IS INITIAL.
    IF lr_errorhandler IS INITIAL.
      CREATE OBJECT lr_errorhandler.
    ENDIF.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_COMPLSTAGE_GRID'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  g_vcode = i_vcode.

  gr_container = ir_container.

  CLEAR gr_grid.
  CREATE OBJECT gr_grid
    EXPORTING
      i_parent          = gr_container
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.
  IF sy-subrc <> 0.
    IF lr_errorhandler IS INITIAL.
      CREATE OBJECT lr_errorhandler.
    ENDIF.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_COMPLSTAGE_GRID'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  CALL METHOD me->build_fieldcat.

  CALL METHOD me->build_layout.

  CALL METHOD me->build_excl_func_tab.

  CALL METHOD me->build_outtab.

  CALL METHOD gr_grid->set_table_for_first_display
    EXPORTING
      is_layout                     = gs_layout
      it_toolbar_excluding          = gt_excl_functions
    CHANGING
      it_outtab                     = gt_outtab
      it_fieldcatalog               = gt_fieldcat
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
  IF sy-subrc <> 0.
    IF lr_errorhandler IS INITIAL.
      CREATE OBJECT lr_errorhandler.
    ENDIF.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_COMPLSTAGE_GRID'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  CALL METHOD me->register_events.

ENDMETHOD.


METHOD handle_data_changed.

  DATA: ls_mod_cell  LIKE LINE OF er_data_changed->mt_mod_cells,
        l_icon_name  TYPE icon-name,
        l_icon       TYPE icon-id.

  LOOP AT er_data_changed->mt_mod_cells INTO ls_mod_cell
       WHERE fieldname  = 'ICON_NAME'.
    CLEAR: l_icon_name, l_icon.
    IF ls_mod_cell-value IS NOT INITIAL.
      l_icon_name = ls_mod_cell-value.
      TRANSLATE l_icon_name TO UPPER CASE.   "#EC TRANSLANG
      SELECT id FROM icon INTO l_icon
             WHERE  name  = l_icon_name.
        EXIT.
      ENDSELECT.
      IF sy-subrc <> 0.
        MESSAGE s040(seef_badi) WITH l_icon_name.
*       Ikone &1 existiert nicht.
      ENDIF.
    ENDIF.
    CALL METHOD er_data_changed->modify_cell
      EXPORTING
        i_row_id    = ls_mod_cell-row_id
        i_fieldname = 'COMPLETION_ICON'
        i_value     = l_icon.
  ENDLOOP.

ENDMETHOD.


METHOD handle_data_changed_finished.

  DATA: ls_outtab      LIKE LINE OF gt_outtab,
        lt_complstage  TYPE ish_t_complstage_obj,
        ls_complstage  LIKE LINE OF lt_complstage.

  CHECK e_modified = on.

  LOOP AT gt_outtab INTO ls_outtab.
    IF ls_outtab-r_complstage IS INITIAL.
      IF ls_outtab-completion_low  IS INITIAL AND
         ls_outtab-completion_high IS INITIAL AND
         ls_outtab-completion_icon IS INITIAL AND
         ls_outtab-completion_name IS INITIAL.
        CONTINUE.
      ENDIF.
      TRY.
          CALL METHOD gr_moncon->create_complstage
            RECEIVING
              rr_complstage = ls_outtab-r_complstage.
        CATCH cx_ish_static_handler .
          CONTINUE.
      ENDTRY.
    ENDIF.
    CALL METHOD ls_outtab-r_complstage->set_completion_low
      EXPORTING
        i_completion_low = ls_outtab-completion_low.
    CALL METHOD ls_outtab-r_complstage->set_completion_high
      EXPORTING
        i_completion_high = ls_outtab-completion_high.
    IF ls_outtab-icon_name IS INITIAL.
      CLEAR ls_outtab-completion_icon.
    ENDIF.
    CALL METHOD ls_outtab-r_complstage->set_completion_icon
      EXPORTING
        i_completion_icon = ls_outtab-completion_icon.
    CALL METHOD ls_outtab-r_complstage->set_completion_name
      EXPORTING
        i_completion_name = ls_outtab-completion_name.
    MODIFY gt_outtab FROM ls_outtab.
  ENDLOOP.

* check if lines have been deleted
  TRY.
      CALL METHOD gr_moncon->get_complstages
        RECEIVING
          rt_complstage = lt_complstage.
    CATCH cx_ish_static_handler .
      EXIT.
  ENDTRY.
  LOOP AT lt_complstage INTO ls_complstage.
    READ TABLE gt_outtab TRANSPORTING NO FIELDS
         WITH KEY r_complstage = ls_complstage-r_complstage.
    CHECK sy-subrc <> 0.
    CALL METHOD ls_complstage-r_complstage->mark_for_deletion.
  ENDLOOP.

ENDMETHOD.


METHOD handle_on_f4.

  DATA: l_icon            TYPE icon-id,
        l_icon_name       TYPE icon-name,
        l_f4              TYPE lvc_s_modi.

  FIELD-SYMBOLS: <lt_f4>  TYPE lvc_t_modi.

* get correct OUTTAB-line
  READ TABLE gt_outtab TRANSPORTING NO FIELDS INDEX es_row_no-row_id.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

* call F4-value-help
  CASE e_fieldname.
*   F4 on name of icon
    WHEN 'ICON_NAME'.
      CALL FUNCTION 'ISHMED_ICON_SHOW'
        EXPORTING
          i_vcode     = g_vcode
          i_modal     = on
        IMPORTING
          e_icon_id   = l_icon
          e_icon_name = l_icon_name
        EXCEPTIONS
          read_error  = 1
          cancel      = 2
          OTHERS      = 3.
      IF sy-subrc = 0.
        ASSIGN er_event_data->m_data->* TO <lt_f4>.
        CLEAR l_f4.
        l_f4-fieldname = e_fieldname.
        l_f4-row_id    = es_row_no-row_id.
        l_f4-value     = l_icon_name.
        APPEND l_f4 TO <lt_f4>.
        CLEAR l_f4.
        l_f4-fieldname = 'COMPLETION_ICON'.
        l_f4-row_id    = es_row_no-row_id.
        l_f4-value     = l_icon.
        APPEND l_f4 TO <lt_f4>.
      ENDIF.
    WHEN OTHERS.
      EXIT.
  ENDCASE.

* set info that F4 has been called (Eigene F4-Hilfe bereits aufgerufen)
  er_event_data->m_event_handled = on.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_complstage_grid.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_type  TYPE ish_object_type.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_type.

  IF i_object_type = l_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_complstage_grid.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD refresh.

  DATA: ls_stbl        TYPE lvc_s_stbl.

  IF i_vcode IS NOT INITIAL.
    g_vcode = i_vcode.
  ENDIF.

*  CALL METHOD me->build_fieldcat.

*  CALL METHOD me->build_layout.

*  CALL METHOD me->build_excl_func_tab.

  CALL METHOD me->build_outtab.

  CALL METHOD gr_grid->refresh_table_display
    EXPORTING
      is_stable      = ls_stbl
      i_soft_refresh = on.

ENDMETHOD.


METHOD register_events.

  DATA: lt_f4        TYPE lvc_t_f4,
        l_f4         TYPE lvc_s_f4.

* F4-Wertehilfe
  CLEAR l_f4.
  l_f4-fieldname  = 'ICON_NAME'.
  l_f4-register   = 'X'.
  l_f4-getbefore  = 'X'.
  l_f4-chngeafter = ' '.
  INSERT l_f4 INTO TABLE lt_f4.
  CALL METHOD gr_grid->register_f4_for_fields
    EXPORTING
      it_f4 = lt_f4.
  SET HANDLER me->handle_on_f4 FOR gr_grid.

* Nach erfolgter Änderung der Daten.
  SET HANDLER me->handle_data_changed_finished FOR gr_grid.

* Reaktion auf Änderung der Daten.
  SET HANDLER me->handle_data_changed FOR gr_grid.

* ÄNDERUNG der Daten
* Um auf Änderungen reagieren zu können muß folgende Methode aufge-
* rufen werden. Es wird bekannt gegeben durch welche Aktion das
* Ereignis ausgelöst werden soll.
* Prinzipiell stehen zwei Möglichkeiten zur Verfügung:
*    Ereignis wird bei ENTER aufgerufen (dies ist hier der Fall)
*    Ereignis wird immer dann angestossen, wenn eine Änderung der
*    Daten erfolgte
  CALL METHOD gr_grid->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_enter
    EXCEPTIONS
      error      = 1
      OTHERS     = 2.

ENDMETHOD.


METHOD save.

  DATA: lr_cx_static_handler  TYPE REF TO cx_ish_static_handler,
        l_rc                  TYPE ish_method_rc.

  CHECK me->check_for_change( ) = abap_on.

  CALL METHOD me->check_icons
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

  TRY.
      CALL METHOD gr_moncon->save
        EXPORTING
          i_update_task = i_update_task
          i_commit      = i_commit.
    CATCH cx_ish_static_handler INTO lr_cx_static_handler.
      IF cr_errorhandler IS INITIAL.
        CREATE OBJECT cr_errorhandler.
      ENDIF.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
        EXPORTING
          i_exceptions    = lr_cx_static_handler
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = 1.
      EXIT.
  ENDTRY.

  e_saved = abap_on.

ENDMETHOD.
ENDCLASS.
