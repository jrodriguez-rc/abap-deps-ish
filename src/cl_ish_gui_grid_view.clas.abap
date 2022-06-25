class CL_ISH_GUI_GRID_VIEW definition
  public
  inheriting from CL_ISH_GUI_CONTROL_VIEW
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_GRID_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_GRID_VIEW .

  aliases GET_ALV_GRID
    for IF_ISH_GUI_GRID_VIEW~GET_ALV_GRID .
  aliases GET_GRID_LAYOUT
    for IF_ISH_GUI_GRID_VIEW~GET_GRID_LAYOUT .
  aliases GET_MODEL_BY_IDX
    for IF_ISH_GUI_GRID_VIEW~GET_MODEL_BY_IDX .
  aliases GET_OUTTAB_ROW_MODELS
    for IF_ISH_GUI_GRID_VIEW~GET_OUTTAB_ROW_MODELS .
  aliases GET_ROW_BY_IDX
    for IF_ISH_GUI_GRID_VIEW~GET_ROW_BY_IDX .
  aliases GET_SELECTED_IDX
    for IF_ISH_GUI_GRID_VIEW~GET_SELECTED_IDX .
  aliases GET_SELECTED_IDXS
    for IF_ISH_GUI_GRID_VIEW~GET_SELECTED_IDXS .
  aliases GET_SELECTED_MODEL
    for IF_ISH_GUI_GRID_VIEW~GET_SELECTED_MODEL .
  aliases GET_SELECTED_MODELS
    for IF_ISH_GUI_GRID_VIEW~GET_SELECTED_MODELS .
  aliases SET_SELECTED_CELL
    for IF_ISH_GUI_GRID_VIEW~SET_SELECTED_CELL .
  aliases SET_SELECTED_ROWS_BY_IDXS
    for IF_ISH_GUI_GRID_VIEW~SET_SELECTED_ROWS_BY_IDXS .
  aliases SET_SELECTED_ROWS_BY_MODELS
    for IF_ISH_GUI_GRID_VIEW~SET_SELECTED_ROWS_BY_MODELS .
  aliases SET_SELECTED_ROW_BY_IDX
    for IF_ISH_GUI_GRID_VIEW~SET_SELECTED_ROW_BY_IDX .
  aliases SET_SELECTED_ROW_BY_MODEL
    for IF_ISH_GUI_GRID_VIEW~SET_SELECTED_ROW_BY_MODEL .

  constants CO_CMDRESULT_EXIT type I value '3'. "#EC NOTEXT
  constants CO_CMDRESULT_NOPROC type I value '0'. "#EC NOTEXT
  constants CO_CMDRESULT_OKCODE type I value '2'. "#EC NOTEXT
  constants CO_CMDRESULT_PROCESSED type I value '1'. "#EC NOTEXT
  constants CO_DEF_FIELDNAME_CELLSTYLE type ISH_FIELDNAME value 'CELLSTYLE'. "#EC NOTEXT
  constants CO_DEF_FIELDNAME_R_MODEL type ISH_FIELDNAME value 'R_MODEL'. "#EC NOTEXT

  class-methods CLASS_CONSTRUCTOR .
  class-methods SBUILD_DEFAULT_EXCLFUNCS
    returning
      value(RT_EXCLFUNC) type UI_FUNCTIONS .
  class-methods SBUILD_DEFAULT_FCAT
    importing
      !I_OUTTAB_STRUCTNAME type TABNAME
    returning
      value(RT_FCAT) type LVC_T_FCAT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    preferred parameter I_ELEMENT_NAME .
protected section.
*"* protected components of class CL_ISH_GUI_GRID_VIEW
*"* do not include other source files here!!!

  data GR_OUTTAB type ref to DATA .
  data GR_TMP_MODEL_DCF type ref to IF_ISH_GUI_MODEL .
  data GT_DRAL_HASH type ISH_T_GUI_DRAL_HASH .
  data GT_GOOD_CELLS type LVC_T_MODI .
  data GT_TMP_MODEL_DCF type ISH_T_GUI_MODEL_OBJHASH .
  data G_FIELDNAME_CELLSTYLE type ISH_FIELDNAME .
  data G_FIELDNAME_R_MODEL type ISH_FIELDNAME .
  data G_TMP_FIELDNAME_DCF type ISH_FIELDNAME .

  type-pools ABAP .
  class-methods _ADD_GRID_TO_FLUSH_BUFFER
    importing
      !IR_ALV_GRID type ref to CL_GUI_ALV_GRID
      !I_STABLE_ROW type ABAP_BOOL default ABAP_TRUE
      !I_STABLE_COL type ABAP_BOOL default ABAP_TRUE
      !I_SOFT_REFRESH type ABAP_BOOL default ABAP_TRUE .
  class-methods _CHECK_R_OUTTAB
    importing
      !IR_OUTTAB type ref to DATA
    raising
      CX_ISH_STATIC_HANDLER .
  methods ON_AFTER_USER_COMMAND
    for event AFTER_USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM
      !E_SAVED
      !E_NOT_PROCESSED
      !SENDER .
  methods ON_BEFORE_USER_COMMAND
    for event BEFORE_USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM
      !SENDER .
  methods ON_BUTTON_CLICK
    for event BUTTON_CLICK of CL_GUI_ALV_GRID
    importing
      !ES_COL_ID
      !ES_ROW_NO
      !SENDER .
  methods ON_DATA_CHANGED
    for event DATA_CHANGED of CL_GUI_ALV_GRID
    importing
      !ER_DATA_CHANGED
      !E_ONF4
      !E_ONF4_AFTER
      !E_ONF4_BEFORE
      !E_UCOMM
      !SENDER .
  methods ON_DATA_CHANGED_FINISHED
    for event DATA_CHANGED_FINISHED of CL_GUI_ALV_GRID
    importing
      !E_MODIFIED
      !ET_GOOD_CELLS
      !SENDER .
  methods ON_DOUBLE_CLICK
    for event DOUBLE_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO
      !SENDER .
  methods ON_DRAG
    for event ONDRAG of CL_GUI_ALV_GRID
    importing
      !ES_ROW_NO
      !E_COLUMN
      !E_DRAGDROPOBJ
      !E_ROW .
  methods ON_DROP
    for event ONDROP of CL_GUI_ALV_GRID
    importing
      !ES_ROW_NO
      !E_COLUMN
      !E_DRAGDROPOBJ
      !E_ROW .
  methods ON_DROP_COMPLETE
    for event ONDROPCOMPLETE of CL_GUI_ALV_GRID
    importing
      !ES_ROW_NO
      !E_COLUMN
      !E_DRAGDROPOBJ
      !E_ROW .
  methods ON_HOTSPOT_CLICK
    for event HOTSPOT_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW_ID
      !E_COLUMN_ID
      !ES_ROW_NO
      !SENDER .
  methods ON_MENU_BUTTON
    for event MENU_BUTTON of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_UCOMM
      !SENDER .
  methods ON_MODEL_ADDED
    for event EV_ENTRY_ADDED of IF_ISH_GUI_TABLE_MODEL
    importing
      !ER_ENTRY
      !SENDER .
  methods ON_MODEL_CHANGED
    for event EV_CHANGED of IF_ISH_GUI_STRUCTURE_MODEL
    importing
      !ET_CHANGED_FIELD
      !SENDER .
  methods ON_MODEL_REMOVED
    for event EV_ENTRY_REMOVED of IF_ISH_GUI_TABLE_MODEL
    importing
      !ER_ENTRY
      !SENDER .
  methods ON_TOOLBAR
    for event TOOLBAR of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_INTERACTIVE
      !SENDER .
  methods ON_USER_COMMAND
    for event USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM
      !SENDER .
  methods _ADD_FVAR_BUTTON_TO_TOOLBAR
    importing
      !IR_BUTTON type ref to CL_ISH_FVAR_BUTTON
      !IR_TOOLBAR_SET type ref to CL_ALV_EVENT_TOOLBAR_SET
    returning
      value(R_ADDED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _ADD_FVAR_FUNCTION_TO_CTMENU
    importing
      !IR_CTMENU type ref to CL_CTMENU
      !IR_FUNCTION type ref to CL_ISH_FVAR_FUNCTION
    returning
      value(R_ADDED) type ABAP_BOOL .
  methods _ADD_ROW
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !IR_ROW type ref to DATA
      !I_IDX type I optional
    returning
      value(R_IDX) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _ADD_ROW_BY_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_IDX type I optional
    returning
      value(R_IDX) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_CTMENU_FVAR
    importing
      !IR_CTMENU type ref to CL_CTMENU
      !IR_FVAR type ref to CL_ISH_FVAR
      !I_FCODE type UI_FUNC .
  methods _BUILD_CTMENU_OWN
    importing
      !IR_CTMENU type ref to CL_CTMENU
      !I_FCODE type UI_FUNC .
  methods _BUILD_EXCLUDING_FUNCTIONS
    returning
      value(RT_EXCLFUNC) type UI_FUNCTIONS
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_FCAT
    returning
      value(RT_FCAT) type LVC_T_FCAT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_FILTER
    returning
      value(RT_FILTER) type LVC_T_FILT .
  methods _BUILD_LAYOUT
    returning
      value(RS_LAYO) type LVC_S_LAYO .
  methods _BUILD_OUTTAB
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_SORT
    returning
      value(RT_SORT) type LVC_T_SORT .
  methods _BUILD_TBMENU_FVAR
    importing
      !IR_TOOLBAR_SET type ref to CL_ALV_EVENT_TOOLBAR_SET
      !IR_FVAR type ref to CL_ISH_FVAR
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_TBMENU_OWN
    importing
      !IR_TOOLBAR_SET type ref to CL_ALV_EVENT_TOOLBAR_SET
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_TOOLBAR_MENU
    importing
      !IR_TOOLBAR_SET type ref to CL_ALV_EVENT_TOOLBAR_SET
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_VARIANT
    exporting
      !ES_VARIANT type DISVARIANT
      !E_SAVE type CHAR01 .
  methods _CHANGE_ROW_BY_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME optional
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CLEAR_DRAL_VALUES
    importing
      !I_HANDLE type INT4 .
  methods _CMD_ON_DRAG
    importing
      !IR_GRID_EVENT type ref to CL_ISH_GUI_GRID_EVENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CMD_ON_DROP
    importing
      !IR_GRID_EVENT type ref to CL_ISH_GUI_GRID_EVENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CMD_ON_DROP_COMPLETE
    importing
      !IR_GRID_EVENT type ref to CL_ISH_GUI_GRID_EVENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DEREGISTER_EVENTHANDLERS .
  methods _DESTROY_DND .
  methods _DISABLE_CELL
    importing
      !IR_ROW type ref to DATA
      !I_FIELDNAME type ISH_FIELDNAME
      value(I_DISABLE_F4) type ISH_ON_OFF default SPACE .
  methods _DISABLE_CELL_F4
    importing
      !IR_ROW type ref to DATA
      !I_FIELDNAME type ISH_FIELDNAME .
  methods _DISABLE_ROW
    importing
      !IR_ROW type ref to DATA .
  methods _ENABLE_CELL
    importing
      !IR_ROW type ref to DATA
      !I_FIELDNAME type ISH_FIELDNAME .
  methods _ENABLE_CELL_F4
    importing
      !IR_ROW type ref to DATA
      !I_FIELDNAME type ISH_FIELDNAME .
  methods _ENABLE_ROW
    importing
      !IR_ROW type ref to DATA .
  methods _FILL_ROW
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME optional
      !IR_ROW type ref to DATA
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_DRAL_KEY
    importing
      !I_HANDLE type INT4
      !I_VALUE type CHAR128
    returning
      value(R_KEY) type CHAR128 .
  methods _GET_DRAL_VALUE
    importing
      !I_HANDLE type INT4
      !I_KEY type CHAR128
    returning
      value(R_VALUE) type CHAR128 .
  methods _GET_DRAL_VALUES
    importing
      !I_HANDLE type INT4
    returning
      value(RT_VALUES) type ISH_T_GUI_DRAL_VALUES .
  methods _GET_FCODE_BUTTONTYPE
    importing
      !I_FCODE type UI_FUNC
    returning
      value(R_BUTTONTYPE) type TB_BTYPE .
  methods _GET_IDX_4_NEW_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(R_IDX) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_IDX_BY_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(R_IDX) type LVC_INDEX .
  methods _GET_IDX_BY_ROW
    importing
      !IR_ROW type ref to DATA
    returning
      value(R_IDX) type LVC_INDEX .
  methods _GET_MAIN_MODEL
    returning
      value(RR_MAIN_MODEL) type ref to IF_ISH_GUI_MODEL .
  methods _GET_MODEL_BY_ROW
    importing
      !IR_ROW type ref to DATA
    returning
      value(RR_MODEL) type ref to IF_ISH_GUI_MODEL .
  methods _GET_ROWCOL_BY_MESSAGE
    importing
      !IS_MESSAGE type RN1MESSAGE
    exporting
      !E_ROW_IDX type LVC_INDEX
      !E_COL_FIELDNAME type ISH_FIELDNAME .
  methods _GET_ROW_BY_IDX
    importing
      !I_IDX type LVC_INDEX
    returning
      value(RR_ROW) type ref to DATA .
  methods _GET_ROW_BY_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(RR_ROW) type ref to DATA .
  methods _GET_ROW_MODELS
    returning
      value(RT_ROW_MODEL) type ISH_T_GUI_MODEL_OBJHASH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _INIT_GRID_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_GRID_LAYOUT optional
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
      !IR_OUTTAB type ref to DATA
      !I_FIELDNAME_R_MODEL type ISH_FIELDNAME default CO_DEF_FIELDNAME_R_MODEL
      !I_FIELDNAME_CELLSTYLE type ISH_FIELDNAME default CO_DEF_FIELDNAME_CELLSTYLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods _IS_FCODE_DISABLED
    importing
      !I_FCODE type UI_FUNC
    returning
      value(R_DISABLED) type ABAP_BOOL .
  methods _IS_MODEL_VALID
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(R_VALID) type ABAP_BOOL .
  methods _LOAD_OR_CREATE_LAYOUT
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_USERNAME type USERNAME default SY-UNAME
    returning
      value(RR_LAYOUT) type ref to CL_ISH_GUI_GRID_LAYOUT .
  methods _OWN_CMD
    importing
      !IR_GRID_EVENT type ref to CL_ISH_GUI_GRID_EVENT
      !IR_ORIG_REQUEST type ref to CL_ISH_GUI_REQUEST
    returning
      value(R_CMDRESULT) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _PREPARE_DND
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REFRESH_TABLE_DISPLAY
    importing
      !I_STABLE_ROW type ABAP_BOOL default ABAP_TRUE
      !I_STABLE_COL type ABAP_BOOL default ABAP_TRUE
      !I_SOFT_REFRESH type ABAP_BOOL default ABAP_FALSE
      !I_FORCE type ABAP_BOOL default ABAP_FALSE .
  methods _REGISTER_ALV_GRID_EVENTS
    importing
      !IR_ALV_GRID type ref to CL_GUI_ALV_GRID
      !I_ACTIVATION type ABAP_BOOL default ABAP_TRUE
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REGISTER_MODEL_EVENTHANDLERS
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_ACTIVATION type ABAP_BOOL default ABAP_TRUE .
  methods _REMOVE_ROW_BY_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(R_IDX_REMOVED) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REPLACE_MODEL
    importing
      !IR_OLD_MODEL type ref to IF_ISH_GUI_MODEL
      !IR_NEW_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SET_CURSOR_AT_REFRESH_DISPLAY
    returning
      value(R_CURSOR_SET) type ABAP_BOOL .
  methods _SET_DRAL_VALUES
    importing
      !I_HANDLE type INT4
      !IT_VALUES type ISH_T_GUI_DRAL_VALUES .

  methods ON_DISPATCH
    redefinition .
  methods _CREATE_CONTROL
    redefinition .
  methods _DESTROY
    redefinition .
  methods _FIRST_DISPLAY
    redefinition .
  methods _PROCESS_COMMAND_REQUEST
    redefinition .
  methods _PROCESS_EVENT_REQUEST
    redefinition .
  methods _REFRESH_DISPLAY
    redefinition .
  methods _SET_VCODE
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_GRID_VIEW
*"* do not include other source files here!!!

  types:
    BEGIN OF gty_flush_buffer,
      r_alv_grid    TYPE REF TO cl_gui_alv_grid,
      s_stable      TYPE lvc_s_stbl,
      soft_refresh  TYPE abap_bool,
    END OF gty_flush_buffer .
  types:
    gtyt_flush_buffer  TYPE HASHED TABLE OF gty_flush_buffer WITH UNIQUE KEY r_alv_grid .

  class-data GT_FLUSH_BUFFER type GTYT_FLUSH_BUFFER .

  class-methods ON_FLUSH
    for event EV_FLUSH of CL_ISH_GUI_CONTROL_VIEW .
ENDCLASS.



CLASS CL_ISH_GUI_GRID_VIEW IMPLEMENTATION.


METHOD class_constructor.

* Register the flush event.
  SET HANDLER on_flush ACTIVATION abap_true.

ENDMETHOD.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

ENDMETHOD.


METHOD if_ish_gui_grid_view~get_alv_grid.

  TRY.
      rr_alv_grid ?= get_control( ).
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_grid_view~get_grid_layout.

  TRY.
      rr_grid_layout ?= get_layout( ).
    CATCH cx_sy_move_cast_error.
      CLEAR rr_grid_layout.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_grid_view~get_model_by_idx.

  DATA lr_row  TYPE REF TO data.

  lr_row = _get_row_by_idx( i_idx = i_idx ).

  rr_model = _get_model_by_row( ir_row = lr_row ).

ENDMETHOD.


METHOD if_ish_gui_grid_view~get_outtab_row_models.

  FIELD-SYMBOLS <lt_outtab>           TYPE table.
  FIELD-SYMBOLS <ls_outtab>           TYPE data.
  FIELD-SYMBOLS <lr_model>            TYPE REF TO if_ish_gui_model.

  CHECK gr_outtab IS BOUND.
  CHECK g_fieldname_r_model IS NOT INITIAL.

  ASSIGN gr_outtab->* TO <lt_outtab>.
  CHECK sy-subrc = 0.

  LOOP AT <lt_outtab> ASSIGNING <ls_outtab>.
    ASSIGN COMPONENT g_fieldname_r_model
      OF STRUCTURE <ls_outtab>
      TO <lr_model> CASTING.
    CHECK <lr_model> IS BOUND.
    INSERT <lr_model> INTO TABLE rt_model.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_grid_view~get_row_by_idx.

  DATA:
    lr_row        TYPE REF TO data,
    lr_datadescr  TYPE REF TO cl_abap_datadescr.

  FIELD-SYMBOLS:
    <ls_row>      TYPE data,
    <ls_row_copy> TYPE data.

  lr_row = _get_row_by_idx( i_idx = i_idx ).
  CHECK lr_row IS BOUND.

  ASSIGN lr_row->* TO <ls_row>.

  lr_datadescr ?= cl_abap_typedescr=>describe_by_data( p_data = <ls_row> ).
  CREATE DATA rr_row TYPE HANDLE lr_datadescr.
  ASSIGN rr_row->* TO <ls_row_copy>.

  <ls_row_copy> = <ls_row>.

ENDMETHOD.


METHOD if_ish_gui_grid_view~get_selected_idx.

  DATA:
    lt_idx                  TYPE lvc_t_indx.

  lt_idx = get_selected_idxs( ).
  CHECK lt_idx IS NOT INITIAL.

  IF lines( lt_idx ) > 1.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '152' ).
  ENDIF.

  READ TABLE lt_idx INDEX 1 INTO r_idx.

ENDMETHOD.


METHOD if_ish_gui_grid_view~get_selected_idxs.

  DATA:
    lr_alv_grid                 TYPE REF TO cl_gui_alv_grid,
    lt_rowidx                   TYPE lvc_t_row,
    l_row                       TYPE i,
    l_idx                       TYPE lvc_index,
    ls_row_id                   TYPE lvc_s_row.

  FIELD-SYMBOLS:
    <ls_rowidx>                TYPE lvc_s_row.

* Get the alv grid.
  lr_alv_grid = get_alv_grid( ).
  CHECK lr_alv_grid IS BOUND.

* Get the indices of the selected rows.
  CALL METHOD lr_alv_grid->get_selected_rows
    IMPORTING
      et_index_rows = lt_rowidx.
  IF lt_rowidx IS INITIAL.
    CALL METHOD lr_alv_grid->get_current_cell
      IMPORTING
        es_row_id = ls_row_id.
    IF ls_row_id-index IS NOT INITIAL.
      l_idx = ls_row_id-index.
      INSERT l_idx INTO TABLE rt_idx.
    ENDIF.
  ELSE.
    LOOP AT lt_rowidx ASSIGNING <ls_rowidx>.
      INSERT <ls_rowidx>-index INTO TABLE rt_idx.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_grid_view~get_selected_model.

  DATA l_idx            TYPE lvc_index.

  l_idx = get_selected_idx( ).
  CHECK l_idx > 0.

  rr_model = get_model_by_idx( l_idx ).

ENDMETHOD.


METHOD if_ish_gui_grid_view~get_selected_models.

  DATA lt_idx                 TYPE lvc_t_indx.
  DATA lr_model               TYPE REF TO if_ish_gui_model.

  FIELD-SYMBOLS <l_idx>       TYPE lvc_index.

  lt_idx = get_selected_idxs( ).

  LOOP AT lt_idx ASSIGNING <l_idx>.
    lr_model = get_model_by_idx( <l_idx> ).
    CHECK lr_model IS BOUND.
    INSERT lr_model INTO TABLE rt_model.
  ENDLOOP.

ENDMETHOD.


method IF_ISH_GUI_GRID_VIEW~SET_SELECTED_CELL.

  DATA:
    lr_alv_grid                TYPE REF TO cl_gui_alv_grid,
    ls_row_id                  TYPE lvc_s_row,
    ls_column_id               TYPE lvc_s_col.

  CHECK i_row_idx IS NOT INITIAL.

* Get the alv grid.
  lr_alv_grid = get_alv_grid( ).
  CHECK lr_alv_grid IS BOUND.

  ls_column_id-fieldname = i_col_fieldname.
  ls_row_id-index        = i_row_idx.

  lr_alv_grid->set_current_cell_via_id(
      is_row_id     = ls_row_id
      is_column_id  = ls_column_id ).

endmethod.


METHOD if_ish_gui_grid_view~set_selected_rows_by_idxs.

  DATA:
  lr_alv_grid                TYPE REF TO cl_gui_alv_grid,
  lt_rowidx                  TYPE lvc_t_row,
  ls_rowidx                  TYPE lvc_s_row.

  FIELD-SYMBOLS <l_idx>     TYPE lvc_index.

* Get the alv grid.
  lr_alv_grid = get_alv_grid( ).
  CHECK lr_alv_grid IS BOUND.

* Generate the index table.
  LOOP AT it_idx ASSIGNING <l_idx>.
    ls_rowidx-index = <l_idx>.
    APPEND ls_rowidx TO lt_rowidx.
  ENDLOOP.

* Set the indices of the selected rows.
  CALL METHOD lr_alv_grid->set_selected_rows
    EXPORTING
      it_index_rows = lt_rowidx.

ENDMETHOD.


METHOD if_ish_gui_grid_view~set_selected_rows_by_models.

  DATA lr_model               TYPE REF TO if_ish_gui_model.
  DATA l_idx                  TYPE lvc_index.
  DATA lt_idx                 TYPE lvc_t_indx.

* Get the indexes for the models.
  LOOP AT it_model INTO lr_model.
    l_idx = _get_idx_by_model( ir_model = lr_model ).
    CHECK l_idx IS NOT INITIAL.
    APPEND l_idx TO lt_idx.
  ENDLOOP.

  set_selected_rows_by_idxs( lt_idx ).

ENDMETHOD.


METHOD if_ish_gui_grid_view~set_selected_row_by_idx.

  DATA:
    lt_idx                      TYPE lvc_t_indx.

* Set the indices of the selected rows.
  APPEND i_idx TO lt_idx.
  set_selected_rows_by_idxs( lt_idx ).

ENDMETHOD.


METHOD if_ish_gui_grid_view~set_selected_row_by_model.

  DATA: l_idx                      TYPE lvc_index.

* Get the index of the model.
  l_idx = _get_idx_by_model( ir_model = ir_model ).
  CHECK l_idx IS NOT INITIAL.

  set_selected_row_by_idx( l_idx ).

ENDMETHOD.


METHOD on_after_user_command.

*  DATA lt_filter                TYPE lvc_t_filt.
*  DATA ls_filter                TYPE lvc_s_filt.
*
*  FIELD-SYMBOLS <ls_filter>     TYPE lvc_s_filt.
*
*  CHECK sy-uname = 'C5044748'.
*
*  CHECK sender IS BOUND.
*  CHECK sender = get_control( ).
*
*  CHECK e_ucomm = '&MB_FILTER'.
*  CHECK e_not_processed = abap_false.
*
*  CALL METHOD sender->get_filter_criteria
*    IMPORTING
*      et_filter = lt_filter.
*
*  CHECK lt_filter IS NOT INITIAL.
*
*  READ TABLE lt_filter INDEX 1 INTO ls_filter.
*  ls_filter-fieldname = 'EXTID'.
*  ls_filter-order = 1.
*  ls_filter-low = 'R'.
*  ls_filter-option = 'GE'.
*
*  LOOP AT lt_filter ASSIGNING <ls_filter>.
*    <ls_filter>-order = <ls_filter>-order + 1.
*  ENDLOOP.
*
*  INSERT ls_filter INTO lt_filter INDEX 1.
*
*  CALL METHOD sender->set_filter_criteria
*    EXPORTING
*      it_filter                 = lt_filter
*    EXCEPTIONS
*      no_fieldcatalog_available = 1
*      OTHERS                    = 2.
*
*  _refresh_table_display( ).

ENDMETHOD.


METHOD on_before_user_command.

*  DATA lt_filter                TYPE lvc_t_filt.
*
*  FIELD-SYMBOLS <ls_filter>     TYPE lvc_s_filt.
*
*  CHECK sy-uname = 'C5044748'.
*
*  CHECK sender IS BOUND.
*  CHECK sender = get_control( ).
*
*  CHECK e_ucomm = '&MB_FILTER'.
*
*  CALL METHOD sender->get_filter_criteria
*    IMPORTING
*      et_filter = lt_filter.
*
*  CHECK lt_filter IS NOT INITIAL.
*
*  LOOP AT lt_filter ASSIGNING <ls_filter>.
*    CHECK <ls_filter>-fieldname = 'EXTID'.
*    DELETE lt_filter.
*    CALL METHOD sender->set_filter_criteria
*      EXPORTING
*        it_filter                 = lt_filter
*      EXCEPTIONS
*        no_fieldcatalog_available = 1
*        OTHERS                    = 2.
*    _refresh_table_display( ).
*    RETURN.
*  ENDLOOP.

ENDMETHOD.


METHOD on_button_click.

  DATA lr_request                 TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_model                   TYPE REF TO if_ish_gui_model.
  DATA l_row_idx                  TYPE lvc_index.
  DATA l_col_fieldname            TYPE ish_fieldname.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

* Create the grid event request.
  l_row_idx       = es_row_no-row_id.
  l_col_fieldname = es_col_id-fieldname.
  lr_model = get_model_by_idx( i_idx = l_row_idx ).
  lr_request = cl_ish_gui_grid_event=>create( ir_sender       = me
                                              i_fcode         = cl_ish_gui_grid_event=>co_fcode_button_click
                                              i_row_idx       = l_row_idx
                                              i_col_fieldname = l_col_fieldname
                                              ir_row_model    = lr_model ).

* Propagate the request.
  lr_response = _propagate_request( ir_request = lr_request ).

* After request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_data_changed.

  FIELD-SYMBOLS <ls_good_cell>            TYPE lvc_s_modi.

  IF er_data_changed IS BOUND AND
     LINES( er_data_changed->mt_mod_cells ) <> LINES( er_data_changed->mt_good_cells ).
    LOOP AT er_data_changed->mt_good_cells ASSIGNING <ls_good_cell>.
      READ TABLE gt_good_cells FROM <ls_good_cell> TRANSPORTING NO FIELDS.
      CHECK sy-subrc <> 0.
      INSERT <ls_good_cell> INTO TABLE gt_good_cells.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD on_data_changed_finished.

  DATA lt_good_cells              TYPE lvc_t_modi.
  DATA l_row_id                   TYPE int4.
  DATA l_idx                      TYPE lvc_index.
  DATA lr_row_model               TYPE REF TO if_ish_gui_model.
  DATA l_fieldname                TYPE ish_fieldname.
  DATA lx_static                  TYPE REF TO cx_ish_static_handler.

  FIELD-SYMBOLS <ls_good_cell>    TYPE lvc_s_modi.
  FIELD-SYMBOLS <ls_modi>         TYPE lvc_s_modi.
  FIELD-SYMBOLS <lt_outtab>       TYPE table.
  FIELD-SYMBOLS <ls_outtab>       TYPE data.
  FIELD-SYMBOLS <l_field>         TYPE any.

* Initial checking.
  CHECK sender IS BOUND.
  CHECK sender = get_alv_grid( ).

* Build lt_good_cells.
  lt_good_cells = et_good_cells.
  LOOP AT gt_good_cells ASSIGNING <ls_good_cell>.
    READ TABLE lt_good_cells FROM <ls_good_cell> TRANSPORTING NO FIELDS.
    CHECK sy-subrc <> 0.
    INSERT <ls_good_cell> INTO TABLE lt_good_cells.
  ENDLOOP.

* Clear gt_good_cells.
  CLEAR gt_good_cells.

* Process only if modified.
  CHECK e_modified = abap_true.

* Assign the outtab.
  CHECK gr_outtab IS BOUND.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  CHECK sy-subrc = 0.

* Transport modified cell content into the corresponding model.
  SORT lt_good_cells BY row_id.
  LOOP AT lt_good_cells ASSIGNING <ls_modi>.
*   No transport for error cells.
    CHECK <ls_modi>-error = abap_false.
*   Get the row_model
*   Assign the outtab line.
    IF l_row_id <> <ls_modi>-row_id.
      l_row_id = <ls_modi>-row_id.
      l_idx = l_row_id.
      lr_row_model = get_model_by_idx( i_idx = l_idx ).
      CHECK lr_row_model IS BOUND.
      READ TABLE <lt_outtab> INDEX l_idx ASSIGNING <ls_outtab>.
      CHECK sy-subrc = 0.
    ENDIF.
    CHECK lr_row_model IS BOUND.
    CHECK <ls_outtab> IS ASSIGNED.
*   Assign the outtab field.
    l_fieldname = <ls_modi>-fieldname.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_outtab>
      TO <l_field>.
    CHECK sy-subrc = 0.
*   Transport the field to the model.
*   Errors are propagated and collected in gt_errorfield.
    gr_tmp_model_dcf = lr_row_model.
    g_tmp_fieldname_dcf = l_fieldname.
    TRY.
        __set_field_content(
            ir_model    = lr_row_model
            i_fieldname = l_fieldname
            i_content   = <l_field> ).
      CATCH cx_ish_static_handler INTO lx_static.
        _set_errorfield(
            ir_model    = lr_row_model
            i_fieldname = l_fieldname
            ir_messages = lx_static->gr_errorhandler ).
        _propagate_exception( ir_exception = lx_static ).
      CLEANUP.
        CLEAR gr_tmp_model_dcf.
        CLEAR g_tmp_fieldname_dcf.
    ENDTRY.
    CLEAR gr_tmp_model_dcf.
    CLEAR g_tmp_fieldname_dcf.
  ENDLOOP.

* Synchronize changed models.
  LOOP AT gt_tmp_model_dcf INTO lr_row_model.
    TRY.
        _change_row_by_model( ir_model = lr_row_model ).
      CATCH cx_ish_static_handler INTO lx_static.
        _propagate_exception( ir_exception = lx_static ).
      CLEANUP.
        CLEAR gt_tmp_model_dcf.
    ENDTRY.
  ENDLOOP.
  CLEAR gt_tmp_model_dcf.

* Refresh table display.
  _refresh_table_display( ).

ENDMETHOD.


METHOD on_dispatch.

  DATA lr_alv_grid            TYPE REF TO cl_gui_alv_grid.

  super->on_dispatch( ).

  lr_alv_grid = get_alv_grid( ).
  CHECK lr_alv_grid IS BOUND.

  lr_alv_grid->check_changed_data( ).

ENDMETHOD.


METHOD on_double_click.

  DATA lr_request                 TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_model                   TYPE REF TO if_ish_gui_model.
  DATA l_row_idx                  TYPE lvc_index.
  DATA l_col_fieldname            TYPE ish_fieldname.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

* Create the grid event request.
  l_row_idx       = es_row_no-row_id.
  l_col_fieldname = e_column-fieldname.
  lr_model = get_model_by_idx( i_idx = l_row_idx ).
  lr_request = cl_ish_gui_grid_event=>create( ir_sender       = me
                                              i_fcode         = cl_ish_gui_grid_event=>co_fcode_double_click
                                              i_row_idx       = l_row_idx
                                              i_col_fieldname = l_col_fieldname
                                              ir_row_model    = lr_model ).

* Propagate the request.
  lr_response = _propagate_request( ir_request = lr_request ).

* After request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_drag.

  DATA lr_alv_grid                TYPE REF TO cl_gui_alv_grid.
  DATA lr_request                 TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_model                   TYPE REF TO if_ish_gui_model.
  DATA l_row_idx                  TYPE lvc_index.
  DATA l_col_fieldname            TYPE ish_fieldname.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

* Check changed data.
  lr_alv_grid = get_alv_grid( ).
  IF lr_alv_grid IS BOUND.
    lr_alv_grid->check_changed_data( ).
  ENDIF.

* Create the grid event request.
  l_row_idx       = es_row_no-row_id.
  l_col_fieldname = e_column-fieldname.
  lr_model = get_model_by_idx( i_idx = l_row_idx ).
  lr_request = cl_ish_gui_grid_event=>create( ir_sender         = me
                                              i_fcode           = cl_ish_gui_grid_event=>co_fcode_on_drag
                                              i_row_idx         = l_row_idx
                                              i_col_fieldname   = l_col_fieldname
                                              ir_row_model      = lr_model
                                              ir_dragdropobject = e_dragdropobj ).

* Propagate the request.
  lr_response = _propagate_request( ir_request = lr_request ).

* After request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_drop.

  DATA lr_alv_grid                TYPE REF TO cl_gui_alv_grid.
  DATA lr_request                 TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_model                   TYPE REF TO if_ish_gui_model.
  DATA l_row_idx                  TYPE lvc_index.
  DATA l_col_fieldname            TYPE ish_fieldname.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

* Check changed data.
  lr_alv_grid = get_alv_grid( ).
  IF lr_alv_grid IS BOUND.
    lr_alv_grid->check_changed_data( ).
  ENDIF.

* Create the grid event request.
  l_row_idx       = es_row_no-row_id.
  l_col_fieldname = e_column-fieldname.
  lr_model = get_model_by_idx( i_idx = l_row_idx ).
  lr_request = cl_ish_gui_grid_event=>create( ir_sender         = me
                                              i_fcode           = cl_ish_gui_grid_event=>co_fcode_on_drop
                                              i_row_idx         = l_row_idx
                                              i_col_fieldname   = l_col_fieldname
                                              ir_row_model      = lr_model
                                              ir_dragdropobject = e_dragdropobj ).

* Propagate the request.
  lr_response = _propagate_request( ir_request = lr_request ).

* After request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_drop_complete.

  DATA lr_alv_grid                TYPE REF TO cl_gui_alv_grid.
  DATA lr_request                 TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_model                   TYPE REF TO if_ish_gui_model.
  DATA l_row_idx                  TYPE lvc_index.
  DATA l_col_fieldname            TYPE ish_fieldname.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

* Check changed data.
  lr_alv_grid = get_alv_grid( ).
  IF lr_alv_grid IS BOUND.
    lr_alv_grid->check_changed_data( ).
  ENDIF.

* Create the grid event request.
  l_row_idx       = es_row_no-row_id.
  l_col_fieldname = e_column-fieldname.
  lr_model = get_model_by_idx( i_idx = l_row_idx ).
  lr_request = cl_ish_gui_grid_event=>create( ir_sender         = me
                                              i_fcode           = cl_ish_gui_grid_event=>co_fcode_on_drop_complete
                                              i_row_idx         = l_row_idx
                                              i_col_fieldname   = l_col_fieldname
                                              ir_row_model      = lr_model
                                              ir_dragdropobject = e_dragdropobj ).

* Propagate the request.
  lr_response = _propagate_request( ir_request = lr_request ).

* After request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_flush.

  DATA:
    l_result                   TYPE i.

  FIELD-SYMBOLS:
    <ls_flush_buffer>          LIKE LINE OF gt_flush_buffer.

  LOOP AT gt_flush_buffer ASSIGNING <ls_flush_buffer>.
    CALL METHOD <ls_flush_buffer>-r_alv_grid->is_valid
      IMPORTING
        result = l_result.
    CHECK l_result = 1.
    CHECK <ls_flush_buffer>-r_alv_grid->is_alive( ) <> cl_gui_control=>state_dead.
    CALL METHOD <ls_flush_buffer>-r_alv_grid->refresh_table_display
      EXPORTING
        is_stable      = <ls_flush_buffer>-s_stable
        i_soft_refresh = <ls_flush_buffer>-soft_refresh
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2.
  ENDLOOP.

  CLEAR: gt_flush_buffer.

ENDMETHOD.


METHOD on_hotspot_click.

  DATA lr_request                 TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_model                   TYPE REF TO if_ish_gui_model.
  DATA l_row_idx                  TYPE lvc_index.
  DATA l_col_fieldname            TYPE ish_fieldname.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

* Create the grid event request.
  l_row_idx       = es_row_no-row_id.
  l_col_fieldname = e_column_id-fieldname.
  lr_model = get_model_by_idx( i_idx = l_row_idx ).

  lr_request = cl_ish_gui_grid_event=>create( ir_sender       = me
                                              i_fcode         = cl_ish_gui_grid_event=>co_fcode_hotspot_click
                                              i_row_idx       = l_row_idx
                                              i_col_fieldname = l_col_fieldname
                                              ir_row_model    = lr_model ).

* Propagate the request.
  lr_response = _propagate_request( ir_request = lr_request ).

* After request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_menu_button.

  DATA lr_layout                TYPE REF TO cl_ish_gui_grid_layout.
  DATA lr_fvar                  TYPE REF TO cl_ish_fvar.
  DATA l_fcode                  TYPE ui_func.

  CHECK sender IS BOUND.
  CHECK sender = get_alv_grid( ).

  CHECK e_object IS BOUND.

* Get the fvar.
  lr_layout = get_grid_layout( ).
  CHECK lr_layout IS BOUND.
  TRY.
      lr_fvar = lr_layout->get_fvar( ).
    CATCH cx_ish_static_handler.
      CLEAR lr_fvar.
  ENDTRY.

* If we have a fvar we build the ctmenu by the fvar.
* If not we build an own ctmenu.
  l_fcode = e_ucomm.
  IF lr_fvar IS BOUND.
    _build_ctmenu_fvar(
        ir_ctmenu = e_object
        ir_fvar   = lr_fvar
        i_fcode   = l_fcode ).
  ELSE.
    _build_ctmenu_own(
        ir_ctmenu = e_object
        i_fcode   = l_fcode ).
  ENDIF.

ENDMETHOD.


METHOD on_model_added.

  DATA:
    lx_root             TYPE REF TO cx_root.

* The model has to be specified.
  CHECK er_entry IS BOUND.

* Add the row.
  TRY.
      CHECK _add_row_by_model(
                ir_model  = er_entry
                i_idx     = _get_idx_4_new_model( ir_model = er_entry ) ) IS NOT INITIAL.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( ir_exception = lx_root ).
  ENDTRY.

* Refresh table display.
  _refresh_table_display( ).

ENDMETHOD.


METHOD on_model_changed.

  DATA lx_root                    TYPE REF TO cx_root.

  FIELD-SYMBOLS <l_fieldname>     TYPE ish_fieldname.

* The model has to be specified.
  CHECK sender IS BOUND.

* Special processing at data_changed_finished.
  IF sender = gr_tmp_model_dcf.
    IF et_changed_field IS INITIAL OR
       lines( et_changed_field ) > 1.
      INSERT sender INTO TABLE gt_tmp_model_dcf.
    ELSE.
      READ TABLE et_changed_field FROM g_tmp_fieldname_dcf TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        INSERT sender INTO TABLE gt_tmp_model_dcf.
      ENDIF.
    ENDIF.
    RETURN.
  ENDIF.

* On changes we have to remove the corresponding errorfield.
  LOOP AT et_changed_field ASSIGNING <l_fieldname>.
    _remove_errorfield(
        ir_model    = sender
        i_fieldname = <l_fieldname> ).
  ENDLOOP.

* Change the rows.
  TRY.
      CHECK _change_row_by_model( ir_model         = sender
                                  it_changed_field = et_changed_field ) = abap_true.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( ir_exception = lx_root ).
  ENDTRY.

* Refresh table display.
  _refresh_table_display( ).

ENDMETHOD.


METHOD on_model_removed.

  DATA:
    lx_root        TYPE REF TO cx_root.

* The model has to be specified.
  CHECK er_entry IS BOUND.

* Remove the row.
  TRY.
      CHECK _remove_row_by_model( ir_model = er_entry ) IS NOT INITIAL.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( ir_exception = lx_root ).
  ENDTRY.

* Refresh table display.
  _refresh_table_display( ).

ENDMETHOD.


METHOD on_toolbar.

  DATA lx_root            TYPE REF TO cx_root.

  CHECK sender IS BOUND.
  CHECK sender = get_alv_grid( ).

  CHECK e_object IS BOUND.

  TRY.
      _build_toolbar_menu( ir_toolbar_set = e_object ).
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( lx_root ).
  ENDTRY.

ENDMETHOD.


METHOD on_user_command.

  DATA lr_request             TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_response            TYPE REF TO cl_ish_gui_response.

  lr_request = cl_ish_gui_grid_event=>create( ir_sender = me
                                              i_fcode   = e_ucomm ).

* Propagate the request.
  lr_response = _propagate_request( ir_request = lr_request ).

* After request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD sbuild_default_exclfuncs.

  APPEND cl_gui_alv_grid=>mc_fc_check              TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_refresh            TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_loc_copy_row       TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_loc_delete_row     TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_loc_append_row     TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_loc_insert_row     TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_loc_move_row       TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_loc_copy           TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_loc_cut            TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_loc_paste          TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_loc_paste_new_row  TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_loc_undo           TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_detail             TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_graph              TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_print_back         TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_print_prev         TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_mb_view               TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_mb_export             TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_info               TO rt_exclfunc.
  APPEND cl_gui_alv_grid=>mc_fc_subtot             TO rt_exclfunc.

  APPEND cl_gui_alv_grid=>mc_mb_sum                TO rt_exclfunc.

ENDMETHOD.


METHOD sbuild_default_fcat.

* The outtab_structname has to be specified.
  IF i_outtab_structname IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'SBUILD_DEFAULT_FCAT'
        i_mv3 = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

* Build the default fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = i_outtab_structname
    CHANGING
      ct_fieldcat      = rt_fcat
    EXCEPTIONS
      OTHERS           = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '2'
        i_mv2 = 'SBUILD_DEFAULT_FCAT'
        i_mv3 = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _add_fvar_button_to_toolbar.

  CHECK ir_toolbar_set IS BOUND.
  CHECK ir_button IS BOUND.

  r_added = ir_button->add_to_toolbar_set(
               ir_toolbar_set = ir_toolbar_set
               i_disabled     = _is_fcode_disabled( ir_button->get_fcode( ) )
               i_buttontype   = _get_fcode_buttontype( ir_button->get_fcode( ) ) ).

ENDMETHOD.


METHOD _add_fvar_function_to_ctmenu.

  CHECK ir_ctmenu IS BOUND.
  CHECK ir_function IS BOUND.

  ir_function->add_to_ctmenu(
      ir_ctmenu   = ir_ctmenu
      i_disabled  = _is_fcode_disabled( ir_function->get_fcode( ) ) ).

  r_added = abap_true.

ENDMETHOD.


METHOD _add_grid_to_flush_buffer.

  DATA:
    ls_flush_buffer        LIKE LINE OF gt_flush_buffer.

  FIELD-SYMBOLS:
    <ls_flush_buffer>      LIKE LINE OF gt_flush_buffer.

  CHECK ir_alv_grid IS BOUND.

  READ TABLE gt_flush_buffer
    WITH TABLE KEY r_alv_grid = ir_alv_grid
    ASSIGNING <ls_flush_buffer>.
  IF sy-subrc = 0.
    IF i_stable_row = abap_true.
      <ls_flush_buffer>-s_stable-row = abap_true.
    ENDIF.
    IF i_stable_col = abap_true.
      <ls_flush_buffer>-s_stable-col = abap_true.
    ENDIF.
    IF i_soft_refresh = abap_false.
      <ls_flush_buffer>-soft_refresh = abap_false.
    ENDIF.
  ELSE.
    ls_flush_buffer-r_alv_grid   = ir_alv_grid.
    ls_flush_buffer-s_stable-row = i_stable_row.
    ls_flush_buffer-s_stable-col = i_stable_col.
    ls_flush_buffer-soft_refresh = i_soft_refresh.
    INSERT ls_flush_buffer INTO TABLE gt_flush_buffer.
    CHECK sy-subrc = 0.
  ENDIF.

ENDMETHOD.


METHOD _add_row.

  DATA l_idx                            TYPE i.
  DATA lr_xtabmdl                       TYPE REF TO if_ish_gui_xtable_model.
  DATA lr_next_entry                    TYPE REF TO if_ish_gui_model.

  FIELD-SYMBOLS <ls_row>                TYPE data.
  FIELD-SYMBOLS <lt_outtab>             TYPE table.

* The row has to be specified.
  CHECK ir_row IS BOUND.
  ASSIGN ir_row->* TO <ls_row>.

* The outtab reference has to be bound.
  CHECK gr_outtab IS BOUND.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_ADD_ROW'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

* Calculate the idx.
  l_idx = i_idx.
  DO 1 TIMES.
    CHECK i_idx = -1.
    TRY.
        lr_xtabmdl ?= _get_main_model( ).
      CATCH cx_sy_move_cast_error.
        EXIT.
    ENDTRY.
    CHECK lr_xtabmdl IS BOUND.
    lr_next_entry = lr_xtabmdl->get_next_entry( ir_previous_entry = ir_model ).
    CHECK lr_next_entry IS BOUND.
    l_idx = _get_idx_by_model( ir_model = lr_next_entry ).
    WHILE lr_next_entry IS BOUND AND l_idx IS INITIAL.
      lr_next_entry = lr_xtabmdl->get_next_entry( ir_previous_entry = lr_next_entry ).
      IF lr_next_entry IS BOUND.
        l_idx = _get_idx_by_model( ir_model = lr_next_entry ).
      ENDIF.
    ENDWHILE.
  ENDDO.
  IF l_idx < 0.
    l_idx = 0.
  ENDIF.

* Add the row.
  IF l_idx IS INITIAL.
    APPEND <ls_row> TO <lt_outtab>.
    IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = '_ADD_ROW'
          i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
    ENDIF.
    r_idx = lines( <lt_outtab> ).
  ELSE.
    INSERT <ls_row> INTO <lt_outtab> INDEX l_idx.
    IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '3'
          i_mv2        = '_ADD_ROW'
          i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
    ENDIF.
    r_idx = l_idx.
  ENDIF.

* Further processing only if the model is bound.
  CHECK ir_model IS BOUND.

* Register the row model events.
  _register_model_eventhandlers( ir_model = ir_model ).

ENDMETHOD.


METHOD _add_row_by_model.

  DATA:
    lr_row             TYPE REF TO data.

  FIELD-SYMBOLS:
    <lt_outtab>        TYPE table.

* The model has to be specified.
  CHECK ir_model IS BOUND.

* Check if the model is valid.
  CHECK _is_model_valid( ir_model ) = abap_true.

* The outtab reference has to be bound.
  CHECK gr_outtab IS BOUND.

* Create an empty row.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  CREATE DATA lr_row LIKE LINE OF <lt_outtab>.

* Fill the new row.
  _fill_row( ir_model = ir_model
             ir_row   = lr_row ).

* Add the row.
  r_idx = _add_row( ir_model = ir_model
                    ir_row   = lr_row
                    i_idx    = i_idx ).

ENDMETHOD.


METHOD _build_ctmenu_fvar.

  DATA lr_button                TYPE REF TO cl_ish_fvar_button.
  DATA lt_function              TYPE ish_t_fvar_function_obj.
  DATA lr_function              TYPE REF TO cl_ish_fvar_function.

  CHECK ir_ctmenu IS BOUND.
  CHECK ir_fvar IS BOUND.
  CHECK i_fcode IS NOT INITIAL.

  lr_button = ir_fvar->get_button_by_fcode( i_fcode = i_fcode ).
  CHECK lr_button IS BOUND.

  lt_function = lr_button->get_all_functions( ).
  CHECK lt_function IS NOT INITIAL.

  LOOP AT lt_function INTO lr_function.
    _add_fvar_function_to_ctmenu(
        ir_ctmenu   = ir_ctmenu
        ir_function = lr_function ).
  ENDLOOP.

ENDMETHOD.


METHOD _build_ctmenu_own.

* No default processing.

ENDMETHOD.


METHOD _build_excluding_functions.

  rt_exclfunc = sbuild_default_exclfuncs( ).

ENDMETHOD.


METHOD _build_fcat.

  DATA lr_tabledescr            TYPE REF TO cl_abap_tabledescr.
  DATA lr_structdescr           TYPE REF TO cl_abap_structdescr.
  DATA l_outtab_structname      TYPE dd02l-tabname.

  FIELD-SYMBOLS <lt_outtab>     TYPE table.

* The outtab structure has to be bound.
  IF gr_outtab IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = '_BUILD_FCAT'
        i_mv3 = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.
  ASSIGN gr_outtab->* TO <lt_outtab>.

* Get the outtab structure name.
  TRY.
      lr_tabledescr ?= cl_abap_typedescr=>describe_by_data( p_data = <lt_outtab> ).
      lr_structdescr ?= lr_tabledescr->get_table_line_type( ).
      l_outtab_structname = lr_structdescr->get_relative_name( ).
    CATCH cx_root.                                       "#EC CATCH_ALL
      cl_ish_utl_exception=>raise_static(
          i_typ = 'E'
          i_kla = 'N1BASE'
          i_num = '030'
          i_mv1 = '1'
          i_mv2 = '_BUILD_FCAT'
          i_mv3 = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDTRY.

* Build the default fcat.
  rt_fcat = sbuild_default_fcat( i_outtab_structname = l_outtab_structname ).

ENDMETHOD.


METHOD _BUILD_FILTER.


ENDMETHOD.


METHOD _build_layout.

  rs_layo-edit        = abap_false.
  rs_layo-sel_mode    = 'A'.
  rs_layo-no_rowmark  = abap_false.
  rs_layo-no_totline  = abap_true.
  rs_layo-no_merging  = abap_true.
  rs_layo-no_rowins   = abap_true.
  rs_layo-no_rowmove  = abap_true.
  rs_layo-stylefname  = g_fieldname_cellstyle.

ENDMETHOD.


METHOD _build_outtab.

  DATA:
    lt_row_model           TYPE ish_t_gui_model_objhash,
    lr_row_model           TYPE REF TO if_ish_gui_model.

  FIELD-SYMBOLS:
    <lt_outtab>            TYPE table.

* Get the row models.
  lt_row_model = _get_row_models( ).

* Build the outtab.
  LOOP AT lt_row_model INTO lr_row_model.
    _add_row_by_model( ir_model = lr_row_model ).
  ENDLOOP.

ENDMETHOD.


METHOD _BUILD_SORT.

ENDMETHOD.


METHOD _build_tbmenu_fvar.

  DATA lt_button                  TYPE ish_t_fvar_button_obj.
  DATA lr_button                  TYPE REF TO cl_ish_fvar_button.

  CHECK ir_toolbar_set IS BOUND.
  CHECK ir_fvar IS BOUND.

* Add the buttons.
  lt_button = ir_fvar->get_all_buttons( ).
  LOOP AT lt_button INTO lr_button.
    _add_fvar_button_to_toolbar(
        ir_toolbar_set  = ir_toolbar_set
        ir_button       = lr_button ).
  ENDLOOP.

ENDMETHOD.


METHOD _build_tbmenu_own.

* No default processing.

ENDMETHOD.


METHOD _build_toolbar_menu.

  DATA lr_layout            TYPE REF TO cl_ish_gui_grid_layout.
  DATA lr_fvar              TYPE REF TO cl_ish_fvar.

  CHECK ir_toolbar_set IS BOUND.

* Get the fvar.
  lr_layout = get_grid_layout( ).
  CHECK lr_layout IS BOUND.
  lr_fvar = lr_layout->get_fvar( ).

* If we have a fvar we build the toolbar by the fvar.
* If not we build an own toolbar.
  IF lr_fvar IS BOUND.
    _build_tbmenu_fvar(
        ir_toolbar_set  = ir_toolbar_set
        ir_fvar         = lr_fvar ).
  ELSE.
    _build_tbmenu_own(
        ir_toolbar_set  = ir_toolbar_set ).
  ENDIF.

ENDMETHOD.


METHOD _build_variant.

  DATA lr_application       TYPE REF TO if_ish_gui_application.
  DATA lr_layout            TYPE REF TO cl_ish_gui_grid_layout.
*  DATA l_layout_variant     TYPE slis_vari.
*  DATA ls_user_variant      TYPE disvariant.

  CLEAR es_variant.
  CLEAR e_save.

  lr_application = get_application( ).
  CHECK lr_application IS BOUND.

* Default settings.
  es_variant-report   = lr_application->build_alv_variant_report( ir_view = me ).
  es_variant-handle   = 'GRID'.
  es_variant-username = sy-uname.
  IF cl_ish_utl_base=>get_auth_vm_def( ) = abap_true.
    e_save = 'A'.
  ELSE.
    e_save = 'U'.
  ENDIF.

* If the layout has a variant we use it.
  lr_layout = get_grid_layout( ).
  IF lr_layout IS BOUND.
    es_variant-variant = lr_layout->get_disvar_variant( ).
  ENDIF.
** If the layout has a variant we use it.
** But only if we do not have a default user-specific disvariant.
*  DO 1 TIMES.
*    lr_layout = get_grid_layout( ).
*    CHECK lr_layout IS BOUND.
*    l_layout_variant = lr_layout->get_disvar_variant( ).
*    CHECK l_layout_variant IS NOT INITIAL.
*    ls_user_variant-report = es_variant-report.
*    CALL FUNCTION 'LVC_VARIANT_DEFAULT_GET'
*      EXPORTING
*        i_save     = 'U'
*      CHANGING
*        cs_variant = ls_user_variant
*      EXCEPTIONS
*        OTHERS     = 1.
*    CHECK sy-subrc = 0.
*    CHECK ls_user_variant-username IS INITIAL.
*    es_variant-variant = l_layout_variant.
*  ENDDO.

ENDMETHOD.


METHOD _CHANGE_ROW_BY_MODEL.

  DATA:
    lr_row                TYPE REF TO data.

* The model has to be specified.
  CHECK ir_model IS BOUND.

* Get the row for the model.
  lr_row = _get_row_by_model( ir_model = ir_model ).
  CHECK lr_row IS BOUND.

* Fill the row.
  r_changed = _fill_row( ir_model         = ir_model
                         it_changed_field = it_changed_field
                         ir_row           = lr_row ).

ENDMETHOD.


METHOD _CHECK_R_OUTTAB.

  DATA lr_typedescr         TYPE REF TO cl_abap_typedescr.
  DATA lr_tabledescr        TYPE REF TO cl_abap_tabledescr.

  IF ir_outtab IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_R_OUTTAB'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

  CALL METHOD cl_abap_typedescr=>describe_by_data_ref
    EXPORTING
      p_data_ref  = ir_outtab
    RECEIVING
      p_descr_ref = lr_typedescr
    EXCEPTIONS
      OTHERS      = 1.
  IF sy-subrc <> 0 OR
     lr_typedescr IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_CHECK_R_OUTTAB'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

  TRY.
      lr_tabledescr ?= lr_typedescr.
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '3'
          i_mv2        = '_CHECK_R_OUTTAB'
          i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDTRY.

  IF lr_tabledescr->table_kind <> lr_tabledescr->tablekind_std.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '4'
        i_mv2        = '_CHECK_R_OUTTAB'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _clear_dral_values.

  DATA ls_dral                    TYPE lvc_s_dral.
  DATA lt_dral                    TYPE lvc_t_dral.
  DATA lr_alv_grid                TYPE REF TO cl_gui_alv_grid.

  FIELD-SYMBOLS <ls_dral_hash>    LIKE LINE OF gt_dral_hash.

  READ TABLE gt_dral_hash
    WITH TABLE KEY dral_handle = i_handle
    ASSIGNING <ls_dral_hash>.
  CHECK sy-subrc = 0.

  CLEAR <ls_dral_hash>-t_dral_values.

  ls_dral-handle = i_handle.
  INSERT ls_dral INTO TABLE lt_dral.

  lr_alv_grid = get_alv_grid( ).
  CHECK lr_alv_grid IS BOUND.

  lr_alv_grid->set_drop_down_table( it_drop_down_alias = lt_dral ).

ENDMETHOD.


METHOD _cmd_on_drag.

  DATA lr_dragdropobject            TYPE REF TO cl_dragdropobject.
  DATA lt_idx                       TYPE lvc_t_indx.
  DATA l_lines                      TYPE i.
  DATA lt_model                     TYPE ish_t_gui_model_objhash.
  DATA lr_model                     TYPE REF TO if_ish_gui_model.
  DATA lr_info_object               TYPE REF TO object.
  DATA lr_drop_processor            TYPE REF TO if_ish_gui_drop_processor.

  FIELD-SYMBOLS <l_idx>             TYPE lvc_index.

* The grid_event has to be specified.
  CHECK ir_grid_event IS BOUND.

* Get the dragdropobject.
  lr_dragdropobject = ir_grid_event->get_dragdropobject( ).
  CHECK lr_dragdropobject IS BOUND.

* Get the selected idxs
  lt_idx = get_selected_idxs( ).
  CHECK lt_idx IS NOT INITIAL.
  DESCRIBE TABLE lt_idx LINES l_lines.

* Build the info_object.
  IF l_lines = 1.
*   If just one idx is selected we set as object the row model
    lr_info_object = ir_grid_event->get_row_model( ).
  ELSE.
*   If there are more idxs selected we get all models to the selected
*   idxs and build a table model with all selected models - we set as object the table model.
    LOOP AT lt_idx ASSIGNING <l_idx>.
      CHECK <l_idx> IS ASSIGNED.
      lr_model = get_model_by_idx( <l_idx> ).
      CHECK lr_model IS BOUND.
      INSERT lr_model INTO TABLE lt_model.
    ENDLOOP.
    CHECK lt_model IS NOT INITIAL.
    lr_info_object = cl_ish_gm_table=>create( it_entry = lt_model ).
  ENDIF.

* Set the dragdropobject->object.
  TRY.
      lr_drop_processor ?= me.
      CREATE OBJECT lr_dragdropobject->object
        TYPE
          cl_ish_gui_drag_object
        EXPORTING
          ir_drag_view           = me
          ir_drag_request        = ir_grid_event
          ir_drop_processor      = lr_drop_processor
          ir_info_object         = lr_info_object.
    CATCH cx_sy_move_cast_error.
      lr_dragdropobject->object = lr_info_object.
  ENDTRY.

ENDMETHOD.


METHOD _cmd_on_drop.

  DATA lr_dragdropobject        TYPE REF TO cl_dragdropobject.
  DATA lr_drag_object           TYPE REF TO cl_ish_gui_drag_object.
  DATA lr_drop_processor        TYPE REF TO if_ish_gui_drop_processor.

* Check the tree_event.
  CHECK ir_grid_event IS BOUND.
  CHECK ir_grid_event->get_sender( ) = me.

* Get the dragdrop object.
  lr_dragdropobject = ir_grid_event->get_dragdropobject( ).
  CHECK lr_dragdropobject IS BOUND.
  CHECK lr_dragdropobject->object IS BOUND.

* Get the drag_object.
  TRY.
      lr_drag_object ?= lr_dragdropobject->object.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Get the drop_processor.
  lr_drop_processor = lr_drag_object->get_drop_processor( ).
  CHECK lr_drop_processor IS BOUND.

* Let the drop_processor process the on_drop request.
  lr_drop_processor->process(
      ir_drag_object  = lr_drag_object
      ir_drop_view    = me
      ir_drop_request = ir_grid_event ).

ENDMETHOD.


METHOD _cmd_on_drop_complete.



ENDMETHOD.


METHOD _create_control.

  DATA:
    lr_parent_container_view  TYPE REF TO if_ish_gui_container_view,
    lr_parent_container       TYPE REF TO cl_gui_container,
    lx_root                   TYPE REF TO cx_root.

* Get the parent container.
  TRY.
      lr_parent_container_view ?= get_parent_view( ).
      lr_parent_container = lr_parent_container_view->get_container_for_child_view( me ).
    CATCH cx_root.                                       "#EC CATCH_ALL
      CALL METHOD cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = '_CREATE_CONTROL'
        i_mv3 = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDTRY.

* Create the alv grid.
  CREATE OBJECT rr_control TYPE cl_ish_gui_alv_grid
    EXPORTING
      i_parent      = lr_parent_container
      i_appl_events = abap_false
    EXCEPTIONS
      others        = 1.
  IF sy-subrc <> 0.
    CALL METHOD cl_ish_utl_exception=>raise_static(
      i_typ = 'E'
      i_kla = 'N1BASE'
      i_num = '030'
      i_mv1 = '2'
      i_mv2 = '_CREATE_CONTROL'
      i_mv3 = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _deregister_eventhandlers.

  DATA lr_alv_grid              TYPE REF TO cl_gui_alv_grid.
  DATA lr_model                 TYPE REF TO if_ish_gui_model.

  FIELD-SYMBOLS <lt_outtab>     TYPE table.
  FIELD-SYMBOLS <ls_outtab>     TYPE data.
  FIELD-SYMBOLS <l_field>       TYPE any.

* Deregister the alv_grid eventhandlers.
  TRY.
      lr_alv_grid = get_alv_grid( ).
      IF lr_alv_grid IS BOUND.
        _register_alv_grid_events(
            ir_alv_grid   = lr_alv_grid
            i_activation  = abap_false ).
      ENDIF.
    CATCH cx_ish_static_handler.                        "#EC NO_HANDLER
  ENDTRY.

* Deregister the main model eventhandlers.
  _register_model_eventhandlers(
      ir_model  = _get_main_model( )
      i_activation  = abap_false ).

* Deregister the outtab model eventhandlers.
  DO 1 TIMES.
    CHECK g_fieldname_r_model IS NOT INITIAL.
    CHECK gr_outtab IS BOUND.
    ASSIGN gr_outtab->* TO <lt_outtab>.
    CHECK sy-subrc = 0.
    LOOP AT <lt_outtab> ASSIGNING <ls_outtab>.
      ASSIGN COMPONENT g_fieldname_r_model
        OF STRUCTURE <ls_outtab>
        TO <l_field>.
      CHECK sy-subrc = 0.
      TRY.
          lr_model ?= <l_field>.
        CATCH cx_sy_move_cast_error.
          CONTINUE.
      ENDTRY.
      CHECK lr_model IS BOUND.
      TRY.
          _register_model_eventhandlers(
              ir_model      = lr_model
              i_activation  = abap_false ).
        CATCH cx_ish_static_handler.                    "#EC NO_HANDLER
      ENDTRY.
    ENDLOOP.
  ENDDO.

ENDMETHOD.


METHOD _destroy.

* Deregister the eventhandlers.
  _deregister_eventhandlers( ).

* Destroy drag&drop.
  _destroy_dnd( ).

* Clear attributes.
  CLEAR gr_outtab.
  CLEAR gr_tmp_model_dcf.
  CLEAR gt_dral_hash.
  CLEAR gt_good_cells.
  CLEAR gt_tmp_model_dcf.
  CLEAR gt_tmp_model_dcf.
  CLEAR g_fieldname_cellstyle.
  CLEAR g_fieldname_r_model.
  CLEAR g_tmp_fieldname_dcf.

* Further processing by the super method.
  super->_destroy( ).

ENDMETHOD.


method _DESTROY_DND.
endmethod.


METHOD _disable_cell.

  DATA lr_structdescr                 TYPE REF TO cl_abap_structdescr.
  DATA ls_cellstyle                   TYPE lvc_s_styl.

  FIELD-SYMBOLS <ls_row>              TYPE data.
  FIELD-SYMBOLS <lt_cellstyle>        TYPE lvc_t_styl.
  FIELD-SYMBOLS <ls_cellstyle>        TYPE lvc_s_styl.

* For processing we need the cellstyle.
  CHECK g_fieldname_cellstyle IS NOT INITIAL.

* The row has to be specified.
  CHECK ir_row IS BOUND.
  ASSIGN ir_row->* TO <ls_row>.

* Get the structure descriptor for the row.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = <ls_row> ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_structdescr IS BOUND.

* Assign the cellstyle.
  TRY.
      ASSIGN COMPONENT g_fieldname_cellstyle
        OF STRUCTURE <ls_row>
        TO <lt_cellstyle>
        CASTING.
    CATCH cx_root.                                       "#EC CATCH_ALL
      RETURN.
  ENDTRY.

* Set the cellstyle.
  READ TABLE <lt_cellstyle>
    WITH TABLE KEY fieldname = i_fieldname
    ASSIGNING <ls_cellstyle>.
  IF sy-subrc = 0.
    <ls_cellstyle>-style = cl_gui_alv_grid=>mc_style_disabled.
  ELSE.
    CLEAR ls_cellstyle.
    ls_cellstyle-fieldname = i_fieldname.
    ls_cellstyle-style     = cl_gui_alv_grid=>mc_style_disabled.
    INSERT ls_cellstyle INTO TABLE <lt_cellstyle>.
  ENDIF.

  IF i_disable_f4 = abap_true.
* Set the cellstyle.
    READ TABLE <lt_cellstyle>
      WITH TABLE KEY fieldname = i_fieldname
      ASSIGNING <ls_cellstyle>.
    IF sy-subrc = 0.
      <ls_cellstyle>-style2 = cl_gui_alv_grid=>mc_style_f4_no.
    ELSE.
      CLEAR ls_cellstyle.
      ls_cellstyle-fieldname = i_fieldname.
      ls_cellstyle-style2    = cl_gui_alv_grid=>mc_style_f4_no.
      INSERT ls_cellstyle INTO TABLE <lt_cellstyle>.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD _disable_cell_f4.

  DATA lr_structdescr                 TYPE REF TO cl_abap_structdescr.
  DATA ls_cellstyle                   TYPE lvc_s_styl.

  FIELD-SYMBOLS <ls_row>              TYPE data.
  FIELD-SYMBOLS <ls_cellstyle>        TYPE lvc_s_styl.
  FIELD-SYMBOLS <lt_cellstyle>        TYPE lvc_t_styl.

* For processing we need the cellstyle.
  CHECK g_fieldname_cellstyle IS NOT INITIAL.

* The row has to be specified.
  CHECK ir_row IS BOUND.
  ASSIGN ir_row->* TO <ls_row>.

* Get the structure descriptor for the row.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = <ls_row> ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_structdescr IS BOUND.

* Assign the cellstyle.
  TRY.
      ASSIGN COMPONENT g_fieldname_cellstyle
        OF STRUCTURE <ls_row>
        TO <lt_cellstyle>
        CASTING.
    CATCH cx_root.                                       "#EC CATCH_ALL
      RETURN.
  ENDTRY.

* Set the cellstyle.
  READ TABLE <lt_cellstyle>
    WITH TABLE KEY fieldname = i_fieldname
    ASSIGNING <ls_cellstyle>.
  IF sy-subrc = 0.
    <ls_cellstyle>-style2 = cl_gui_alv_grid=>mc_style_f4_no.
  ELSE.
    CLEAR ls_cellstyle.
    ls_cellstyle-fieldname = i_fieldname.
    ls_cellstyle-style2    = cl_gui_alv_grid=>mc_style_f4_no.
    INSERT ls_cellstyle INTO TABLE <lt_cellstyle>.
  ENDIF.

ENDMETHOD.


METHOD _disable_row.

  DATA lr_structdescr                 TYPE REF TO cl_abap_structdescr.
  DATA ls_cellstyle                   TYPE lvc_s_styl.

  FIELD-SYMBOLS <ls_row>              TYPE data.
  FIELD-SYMBOLS <lt_cellstyle>        TYPE lvc_t_styl.
  FIELD-SYMBOLS <ls_cellstyle>        TYPE lvc_s_styl.
  FIELD-SYMBOLS <ls_component>        TYPE abap_compdescr.

* For processing we need the cellstyle.
  CHECK g_fieldname_cellstyle IS NOT INITIAL.

* The row has to be specified.
  CHECK ir_row IS BOUND.
  ASSIGN ir_row->* TO <ls_row>.

* Get the structure descriptor for the row.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = <ls_row> ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_structdescr IS BOUND.

* Assign the cellstyle.
  TRY.
      ASSIGN COMPONENT g_fieldname_cellstyle
        OF STRUCTURE <ls_row>
        TO <lt_cellstyle>
        CASTING.
    CATCH cx_root.                                       "#EC CATCH_ALL
      RETURN.
  ENDTRY.

* Fill the row.
  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.
    READ TABLE <lt_cellstyle>
      WITH TABLE KEY fieldname = <ls_component>-name
      ASSIGNING <ls_cellstyle>.
    IF sy-subrc = 0.
      <ls_cellstyle>-style  = cl_gui_alv_grid=>mc_style_disabled.
    ELSE.
      CLEAR ls_cellstyle.
      ls_cellstyle-fieldname = <ls_component>-name.
      ls_cellstyle-style     = cl_gui_alv_grid=>mc_style_disabled.
      INSERT ls_cellstyle INTO TABLE <lt_cellstyle>.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD _enable_cell.

  DATA lr_structdescr                 TYPE REF TO cl_abap_structdescr.
  DATA ls_cellstyle                   TYPE lvc_s_styl.

  FIELD-SYMBOLS <ls_row>              TYPE data.
  FIELD-SYMBOLS <lt_cellstyle>        TYPE lvc_t_styl.
  FIELD-SYMBOLS <ls_cellstyle>        TYPE lvc_s_styl.

* For processing we need the cellstyle.
  CHECK g_fieldname_cellstyle IS NOT INITIAL.

* The row has to be specified.
  CHECK ir_row IS BOUND.
  ASSIGN ir_row->* TO <ls_row>.

* Get the structure descriptor for the row.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = <ls_row> ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_structdescr IS BOUND.

* Assign the cellstyle.
  TRY.
      ASSIGN COMPONENT g_fieldname_cellstyle
        OF STRUCTURE <ls_row>
        TO <lt_cellstyle>
        CASTING.
    CATCH cx_root.                                       "#EC CATCH_ALL
      RETURN.
  ENDTRY.

* Set the cellstyle.
  READ TABLE <lt_cellstyle>
    WITH TABLE KEY fieldname = i_fieldname
    ASSIGNING <ls_cellstyle>.
  IF sy-subrc = 0.
    CLEAR <ls_cellstyle>-style.
  ENDIF.

ENDMETHOD.


METHOD _enable_cell_f4.

  DATA lr_structdescr                 TYPE REF TO cl_abap_structdescr.
  DATA ls_cellstyle                   TYPE lvc_s_styl.

  FIELD-SYMBOLS <ls_row>              TYPE data.
  FIELD-SYMBOLS <lt_cellstyle>        TYPE lvc_t_styl.
  FIELD-SYMBOLS <ls_cellstyle>        TYPE lvc_s_styl.

* For processing we need the cellstyle.
  CHECK g_fieldname_cellstyle IS NOT INITIAL.

* The row has to be specified.
  CHECK ir_row IS BOUND.
  ASSIGN ir_row->* TO <ls_row>.

* Get the structure descriptor for the row.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = <ls_row> ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_structdescr IS BOUND.

* Assign the cellstyle.
  TRY.
      ASSIGN COMPONENT g_fieldname_cellstyle
        OF STRUCTURE <ls_row>
        TO <lt_cellstyle>
        CASTING.
    CATCH cx_root.                                       "#EC CATCH_ALL
      RETURN.
  ENDTRY.

* Set the cellstyle.
  READ TABLE <lt_cellstyle>
    WITH TABLE KEY fieldname = i_fieldname
    ASSIGNING <ls_cellstyle>.
  IF sy-subrc = 0.
    CLEAR <ls_cellstyle>-style2.
  ENDIF.

ENDMETHOD.


METHOD _enable_row.

  DATA lr_structdescr                 TYPE REF TO cl_abap_structdescr.
  DATA ls_cellstyle                   TYPE lvc_s_styl.

  FIELD-SYMBOLS <ls_row>              TYPE data.
  FIELD-SYMBOLS <lt_cellstyle>        TYPE lvc_t_styl.
  FIELD-SYMBOLS <ls_cellstyle>        TYPE lvc_s_styl.
  FIELD-SYMBOLS <ls_component>        TYPE abap_compdescr.

* For processing we need the cellstyle.
  CHECK g_fieldname_cellstyle IS NOT INITIAL.

* The row has to be specified.
  CHECK ir_row IS BOUND.
  ASSIGN ir_row->* TO <ls_row>.

* Get the structure descriptor for the row.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = <ls_row> ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_structdescr IS BOUND.

* Assign the cellstyle.
  TRY.
      ASSIGN COMPONENT g_fieldname_cellstyle
        OF STRUCTURE <ls_row>
        TO <lt_cellstyle>
        CASTING.
    CATCH cx_root.                                       "#EC CATCH_ALL
      RETURN.
  ENDTRY.

* Fill the row.
  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.
    READ TABLE <lt_cellstyle>
      WITH TABLE KEY fieldname = <ls_component>-name
      ASSIGNING <ls_cellstyle>.
    IF sy-subrc = 0.
      CLEAR <ls_cellstyle>-style.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD _fill_row.

  DATA lr_structmdl               TYPE REF TO if_ish_gui_structure_model.
  DATA lr_xstructmdl              TYPE REF TO if_ish_gui_xstructure_model.
  DATA lr_structdescr             TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname                TYPE ish_fieldname.
  DATA lr_row_copy                TYPE REF TO data.
  DATA lx_root                    TYPE REF TO cx_root.

  FIELD-SYMBOLS <ls_row>          TYPE data.
  FIELD-SYMBOLS <ls_row_copy>     TYPE data.
  FIELD-SYMBOLS <ls_component>    TYPE abap_compdescr.
  FIELD-SYMBOLS <l_field>         TYPE any.

* The row has to be specified.
  CHECK ir_row IS BOUND.
  ASSIGN ir_row->* TO <ls_row>.

* The given model has to be a structure model.
  TRY.
      lr_structmdl ?= ir_model.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_structmdl IS BOUND.

* Get the structure descriptor for the row.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = <ls_row> ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_structdescr IS BOUND.

* Remember the actual row data (needed to determine changes).
  CREATE DATA lr_row_copy LIKE <ls_row>.
  ASSIGN lr_row_copy->* TO <ls_row_copy>.
  <ls_row_copy> = <ls_row>.

* Get the xstructure model to en-/disable cells.
  IF g_vcode <> co_vcode_display.
    TRY.
        lr_xstructmdl ?= lr_structmdl.
      CATCH cx_sy_move_cast_error.
        CLEAR lr_xstructmdl.
    ENDTRY.
  ENDIF.

* Fill the row.
  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
    CHECK l_fieldname IS NOT INITIAL.
    CHECK l_fieldname <> g_fieldname_r_model.
    CHECK l_fieldname <> g_fieldname_cellstyle.
*   Errorfields are not transported.
    CHECK _get_errorfield_messages(
              ir_model    = lr_structmdl
              i_fieldname = l_fieldname ) IS NOT BOUND.
*   Transport only changed fields.
    IF it_changed_field IS NOT INITIAL.
      READ TABLE it_changed_field FROM l_fieldname TRANSPORTING NO FIELDS.
      CHECK sy-subrc = 0.
    ENDIF.
*   Transport the field from the model to the row.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_row>
      TO <l_field>.
    CHECK sy-subrc = 0.
    TRY.
        CALL METHOD __get_field_content
          EXPORTING
            ir_model    = lr_structmdl
            i_fieldname = l_fieldname
          CHANGING
            c_content   = <l_field>.
      CATCH cx_ish_static_handler INTO lx_root.
        _propagate_exception( ir_exception = lx_root ).
        CONTINUE.
    ENDTRY.
*   En-/Disable the cell.
    DO 1 TIMES.
      CHECK g_vcode <> co_vcode_display.
      CHECK lr_xstructmdl IS BOUND.
      IF lr_xstructmdl->is_field_changeable( i_fieldname = l_fieldname ) = abap_true.
        _enable_cell(
            ir_row      = ir_row
            i_fieldname = l_fieldname ).
      ELSE.
        _disable_cell(
            ir_row      = ir_row
            i_fieldname = l_fieldname ).
      ENDIF.
    ENDDO.
  ENDLOOP.

* Set the model reference.
  IF g_fieldname_r_model IS NOT INITIAL.
    ASSIGN COMPONENT g_fieldname_r_model
      OF STRUCTURE <ls_row>
      TO <l_field>.
    IF sy-subrc = 0.
      TRY.
          <l_field> ?= ir_model.
        CATCH cx_sy_move_cast_error.                    "#EC NO_HANDLER
      ENDTRY.
    ENDIF.
  ENDIF.

* Export.
  IF <ls_row> <> <ls_row_copy>.
    r_changed = abap_true.
  ENDIF.

ENDMETHOD.


METHOD _first_display.

  DATA lr_alv_grid                  TYPE REF TO cl_gui_alv_grid.
  DATA lr_model                     TYPE REF TO if_ish_gui_model.
  DATA lt_fcat                      TYPE lvc_t_fcat.
  DATA ls_layo                      TYPE lvc_s_layo.
  DATA lt_sort                      TYPE lvc_t_sort.
  DATA lt_filter                    TYPE lvc_t_filt.
  DATA lt_exclfunc                  TYPE ui_functions.
  DATA ls_variant                   TYPE disvariant.
  DATA l_variant_save               TYPE char01.
  DATA lr_main_model                TYPE REF TO if_ish_gui_model.
  DATA lr_tabmdl                    TYPE REF TO if_ish_gui_table_model.
  DATA ls_dral                      TYPE lvc_s_dral.
  DATA lt_dral                      TYPE lvc_t_dral.

  FIELD-SYMBOLS <lt_outtab>         TYPE table.
  FIELD-SYMBOLS <ls_dral_hash>      LIKE LINE OF gt_dral_hash.
  FIELD-SYMBOLS <ls_dral_values>    TYPE rn1_gui_dral_values.

* The outtab reference has to be bound.
  IF gr_outtab IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_FIRST_DISPLAY'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.
  TRY.
      ASSIGN gr_outtab->* TO <lt_outtab>.
    CATCH cx_root.                                       "#EC CATCH_ALL
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = '_FIRST_DISPLAY'
          i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDTRY.

* Create the alv tree.
  _create_control_on_demand( ).
  lr_alv_grid = get_alv_grid( ).
  IF lr_alv_grid IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = '_FIRST_DISPLAY'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

* Set dropdown aliases.
  LOOP AT gt_dral_hash ASSIGNING <ls_dral_hash>.
    CLEAR lt_dral.
    LOOP AT <ls_dral_hash>-t_dral_values ASSIGNING <ls_dral_values>.
      ls_dral-handle  = <ls_dral_hash>-dral_handle.
      ls_dral-value   = <ls_dral_values>-dral_value.
      ls_dral-int_value = <ls_dral_values>-dral_key.
      APPEND ls_dral TO lt_dral.
    ENDLOOP.
  ENDLOOP.
  lr_alv_grid->set_drop_down_table( it_drop_down_alias = lt_dral ).

* Build the fieldcat.
  lt_fcat = _build_fcat( ).

* Build the outtab.
  _build_outtab( ).

* Build the layout.
  ls_layo = _build_layout( ).

* Build the sort.
  lt_sort = _build_sort( ).

* Build the filter.
  lt_filter = _build_filter( ).

* Build the excluding functions.
  lt_exclfunc = _build_excluding_functions( ).

* Build the variant.
  CALL METHOD _build_variant
    IMPORTING
      es_variant = ls_variant
      e_save     = l_variant_save.

* Register the alv_grid eventhandlers.
  _register_alv_grid_events( ir_alv_grid = lr_alv_grid ).

* Set table for first display.
  CALL METHOD lr_alv_grid->set_table_for_first_display
    EXPORTING
      is_layout            = ls_layo
      it_toolbar_excluding = lt_exclfunc
      is_variant           = ls_variant
      i_save               = l_variant_save
    CHANGING
      it_outtab            = <lt_outtab>
      it_fieldcatalog      = lt_fcat
      it_sort              = lt_sort
      it_filter            = lt_filter
    EXCEPTIONS
      OTHERS               = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '4'
        i_mv2        = '_FIRST_DISPLAY'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

* Set toolbar interactive.
  lr_alv_grid->set_toolbar_interactive( ).

* Set ready for input.
  IF g_vcode = co_vcode_display.
    lr_alv_grid->set_ready_for_input( i_ready_for_input = 0 ).
  ELSE.
    lr_alv_grid->set_ready_for_input( i_ready_for_input = 1 ).
  ENDIF.

* Register the main model eventhandlers.
  lr_model = _get_main_model( ).
  _register_model_eventhandlers( ir_model = lr_model ).

  _set_cursor_at_refresh_display( ).

ENDMETHOD.


METHOD _get_dral_key.

  FIELD-SYMBOLS <ls_dral_hash>            LIKE LINE OF gt_dral_hash.
  FIELD-SYMBOLS <ls_dral_values>          TYPE rn1_gui_dral_values.

  READ TABLE gt_dral_hash
    WITH TABLE KEY dral_handle = i_handle
    ASSIGNING <ls_dral_hash>.
  CHECK sy-subrc = 0.

  READ TABLE <ls_dral_hash>-t_dral_values
    WITH KEY dral_value = i_value
    ASSIGNING <ls_dral_values>.
  CHECK sy-subrc = 0.

  r_key = <ls_dral_values>-dral_key.

ENDMETHOD.


METHOD _get_dral_value.

  FIELD-SYMBOLS <ls_dral_hash>            LIKE LINE OF gt_dral_hash.
  FIELD-SYMBOLS <ls_dral_values>          TYPE rn1_gui_dral_values.

  READ TABLE gt_dral_hash
    WITH TABLE KEY dral_handle = i_handle
    ASSIGNING <ls_dral_hash>.
  CHECK sy-subrc = 0.

  READ TABLE <ls_dral_hash>-t_dral_values
    WITH KEY dral_key = i_key
    ASSIGNING <ls_dral_values>.
  CHECK sy-subrc = 0.

  r_value = <ls_dral_values>-dral_value.

ENDMETHOD.


METHOD _get_dral_values.

  FIELD-SYMBOLS <ls_dral_hash>            LIKE LINE OF gt_dral_hash.

  READ TABLE gt_dral_hash
    WITH TABLE KEY dral_handle = i_handle
    ASSIGNING <ls_dral_hash>.
  CHECK sy-subrc = 0.

  rt_values = <ls_dral_hash>-t_dral_values.

ENDMETHOD.


METHOD _get_fcode_buttontype.

  r_buttontype = -1.

ENDMETHOD.


METHOD _get_idx_4_new_model.

* By default new models are appended (idx=0).
* Use -1 to allow calculation of the index in _add_row (only useful if the main model is a xtable model).
* Use any other value > 0 to fix the index.

  r_idx = 0.

ENDMETHOD.


METHOD _get_idx_by_model.

  DATA l_idx                            TYPE lvc_index.

  FIELD-SYMBOLS <lt_outtab>             TYPE table.
  FIELD-SYMBOLS <ls_outtab>             TYPE data.
  FIELD-SYMBOLS <l_field>               TYPE any.

  CHECK ir_model IS BOUND.

  CHECK g_fieldname_r_model IS NOT INITIAL.

  CHECK gr_outtab IS BOUND.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  CHECK sy-subrc = 0.

  l_idx = 0.
  LOOP AT <lt_outtab> ASSIGNING <ls_outtab>.
    l_idx = l_idx + 1.
    ASSIGN COMPONENT g_fieldname_r_model
      OF STRUCTURE <ls_outtab>
      TO <l_field>.
    CHECK <l_field> = ir_model.
    r_idx = l_idx.
    RETURN.
  ENDLOOP.

ENDMETHOD.


METHOD _GET_IDX_BY_ROW.

  DATA:
    lr_row                TYPE REF TO data.

  FIELD-SYMBOLS:
    <lt_outtab>           TYPE table.

* The row has to be specified.
  CHECK ir_row IS BOUND.

* Assign the outtab.
  CHECK gr_outtab IS BOUND.
  ASSIGN gr_outtab->* TO <lt_outtab>.

* Get the row index.
  LOOP AT <lt_outtab> REFERENCE INTO lr_row.
    CHECK lr_row = ir_row.
    r_idx = sy-tabix.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD _GET_MAIN_MODEL.

  DATA:
    lr_controller  TYPE REF TO if_ish_gui_controller.

  lr_controller = get_controller( ).
  CHECK lr_controller IS BOUND.

  rr_main_model = lr_controller->get_model( ).

ENDMETHOD.


METHOD _get_model_by_row.

  FIELD-SYMBOLS <ls_outtab>           TYPE data.
  FIELD-SYMBOLS <l_field>             TYPE ANY.

  CHECK ir_row IS BOUND.

  CHECK g_fieldname_r_model IS NOT INITIAL.

  ASSIGN ir_row->* TO <ls_outtab>.

  ASSIGN COMPONENT g_fieldname_r_model
    OF STRUCTURE <ls_outtab>
    TO <l_field>.
  CHECK sy-subrc = 0.

  TRY.
      rr_model ?= <l_field>.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


method _GET_ROWCOL_BY_MESSAGE.

  DATA lr_model       TYPE REF TO if_ish_gui_model.

  TRY.
    lr_model ?= is_message-object.
    CATCH cx_sy_move_cast_error.     "#EC NO_HANDLER
  ENDTRY.

  IF lr_model IS BOUND.
    e_row_idx = _get_idx_by_model( lr_model ).
  ENDIF.

  e_col_fieldname = is_message-field.

endmethod.


METHOD _get_row_by_idx.

  FIELD-SYMBOLS:
    <lt_outtab>            TYPE table.

  CHECK i_idx IS NOT INITIAL.

  CHECK gr_outtab IS BOUND.
  ASSIGN gr_outtab->* TO <lt_outtab>.

  READ TABLE <lt_outtab> INDEX i_idx REFERENCE INTO rr_row.

ENDMETHOD.


METHOD _get_row_by_model.

  FIELD-SYMBOLS <lt_outtab>             TYPE table.
  FIELD-SYMBOLS <ls_outtab>             TYPE data.
  FIELD-SYMBOLS <l_field>               TYPE ANY.

  CHECK ir_model IS BOUND.

  CHECK g_fieldname_r_model IS NOT INITIAL.

  CHECK gr_outtab IS BOUND.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  CHECK sy-subrc = 0.

  LOOP AT <lt_outtab> ASSIGNING <ls_outtab>.
    ASSIGN COMPONENT g_fieldname_r_model
      OF STRUCTURE <ls_outtab>
      TO <l_field>.
    CHECK <l_field> = ir_model.
    GET REFERENCE OF <ls_outtab> INTO rr_row.
    RETURN.
  ENDLOOP.

ENDMETHOD.


METHOD _get_row_models.

  DATA:
    lr_tabmdl          TYPE REF TO if_ish_gui_table_model.

* Get the main model.
* It has to be a table model.
  TRY.
      lr_tabmdl ?= _get_main_model( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_tabmdl IS BOUND.

* Get the entries of the table model.
  rt_row_model = lr_tabmdl->get_entries( ).

ENDMETHOD.


METHOD _init_grid_view.

  DATA lr_tabledescr                  TYPE REF TO cl_abap_tabledescr.
  DATA lr_structdescr                 TYPE REF TO cl_abap_structdescr.
  DATA lr_datadescr                   TYPE REF TO cl_abap_datadescr.
  DATA l_tmp_fieldname_cellstyle      TYPE ish_fieldname.
  DATA lr_layout                      TYPE REF TO cl_ish_gui_grid_layout.

  FIELD-SYMBOLS <lt_outtab>           TYPE data.

* Check outtab
  _check_r_outtab( ir_outtab = ir_outtab ).

* The outtab has to be a table.
  ASSIGN ir_outtab->* TO <lt_outtab>.
  TRY.
      lr_tabledescr ?= cl_abap_typedescr=>describe_by_data( p_data = <lt_outtab> ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_tabledescr.
  ENDTRY.
  IF lr_tabledescr IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_INIT_GRID_VIEW'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

* The fieldname for the model has to be specified.
  IF i_fieldname_r_model IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = '_INIT_GRID_VIEW'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

* Check the model fieldname.
  TRY.
      lr_structdescr ?= lr_tabledescr->get_table_line_type( ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_structdescr.
  ENDTRY.
  IF lr_structdescr IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '4'
        i_mv2        = '_INIT_GRID_VIEW'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.
  CALL METHOD lr_structdescr->get_component_type
    EXPORTING
      p_name      = i_fieldname_r_model
    RECEIVING
      p_descr_ref = lr_datadescr
    EXCEPTIONS
      OTHERS      = 1.
  IF sy-subrc <> 0 OR
     lr_datadescr IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '5'
        i_mv2        = '_INIT_GRID_VIEW'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.
  IF lr_datadescr->type_kind <> cl_abap_typedescr=>typekind_oref.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '6'
        i_mv2        = '_INIT_GRID_VIEW'
        i_mv3        = 'CL_ISH_GUI_GRID_VIEW' ).
  ENDIF.

* Handle the layout.
  IF ir_layout IS BOUND.
    lr_layout = ir_layout.
  ELSE.
    lr_layout = _load_or_create_layout(
        ir_controller  = ir_controller
        ir_parent_view = ir_parent_view ).
  ENDIF.

* Further processing by _init_control_view.
  _init_control_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = lr_layout
      i_vcode           = i_vcode ).

* Prepare drag&drop.
  _prepare_dnd( ).

* Initialize attributes.
  gr_outtab = ir_outtab.
  g_fieldname_r_model   = i_fieldname_r_model.

* Handle the cellstyle.
  DO 1 TIMES.
    CHECK i_fieldname_cellstyle IS NOT INITIAL.
    CALL METHOD lr_structdescr->get_component_type
      EXPORTING
        p_name      = i_fieldname_cellstyle
      RECEIVING
        p_descr_ref = lr_datadescr
      EXCEPTIONS
        OTHERS      = 1.
    CHECK sy-subrc = 0.
    CHECK lr_datadescr IS BOUND.
    CHECK lr_datadescr->type_kind = cl_abap_typedescr=>typekind_table.
    CHECK lr_datadescr->get_relative_name( ) = 'LVC_T_STYL'.
    g_fieldname_cellstyle = i_fieldname_cellstyle.
  ENDDO.

ENDMETHOD.


METHOD _is_fcode_disabled.

* By default all fcodes are enabled.

  r_disabled = abap_false.

ENDMETHOD.


METHOD _is_model_valid.

* By default each model is valid.
  r_valid = abap_true.

ENDMETHOD.


METHOD _load_or_create_layout.

  DATA l_element_name           TYPE n1gui_element_name.

  TRY.
      rr_layout ?= _load_layout(
          ir_controller   = ir_controller
          ir_parent_view  = ir_parent_view
          i_layout_name   = i_layout_name
          i_username      = i_username ).
    CATCH cx_sy_move_cast_error.
      CLEAR rr_layout.
  ENDTRY.

  IF rr_layout IS NOT BOUND.
    l_element_name = get_element_name( ).
    CREATE OBJECT rr_layout
      EXPORTING
        i_element_name = l_element_name
        i_layout_name  = i_layout_name.
  ENDIF.

ENDMETHOD.


METHOD _own_cmd.

  CHECK ir_grid_event IS BOUND.

  CASE ir_grid_event->get_fcode( ).

*   On Drag
    WHEN cl_ish_gui_grid_event=>co_fcode_on_drag.
      r_cmdresult = co_cmdresult_processed.
      _cmd_on_drag( ir_grid_event = ir_grid_event ).

*   On Drop
    WHEN cl_ish_gui_grid_event=>co_fcode_on_drop.
      r_cmdresult = co_cmdresult_processed.
      _cmd_on_drop( ir_grid_event = ir_grid_event ).

*   On Drop
    WHEN cl_ish_gui_grid_event=>co_fcode_on_drop_complete.
      r_cmdresult = co_cmdresult_processed.
      _cmd_on_drop_complete( ir_grid_event = ir_grid_event ).

    WHEN OTHERS.

*     We haven't processed the event
      r_cmdresult = co_cmdresult_noproc.
      RETURN.

  ENDCASE.

ENDMETHOD.


method _PREPARE_DND.
endmethod.


METHOD _process_command_request.

  DATA lr_okcode_request        TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_grid_event            TYPE REF TO cl_ish_gui_grid_event.
  DATA lx_root                  TYPE REF TO cx_root.
  DATA l_exit                   TYPE abap_bool.

* The command request has to be specified.
  CHECK ir_command_request IS BOUND.

* The command request has to be created by an okcode request.
  lr_okcode_request = ir_command_request->get_okcode_request( ).
  CHECK lr_okcode_request IS BOUND.

* The okcode request has to be created by a grid event.
  TRY.
      lr_grid_event ?= lr_okcode_request->get_control_event( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_grid_event IS BOUND.

* The grid event has to belong to self.
  CHECK lr_grid_event->get_sender( ) = me.

* Process the grid event.
  TRY.

      CASE _own_cmd(
               ir_grid_event   = lr_grid_event
               ir_orig_request = ir_command_request ).
        WHEN co_cmdresult_processed.
          l_exit = abap_false.
        WHEN co_cmdresult_exit.
          l_exit = abap_true.
        WHEN OTHERS.
          RETURN.
      ENDCASE.

      rr_response = cl_ish_gui_response=>create(
          ir_request    = ir_command_request
          ir_processor  = me
          i_exit        = l_exit ).

*   On errors we have to propagate the exception.
    CATCH cx_ish_static_handler INTO lx_root.

      _propagate_exception( lx_root ).
      rr_response = cl_ish_gui_response=>create( ir_request   = ir_command_request
                                                 ir_processor = me ).
      RETURN.

  ENDTRY.

ENDMETHOD.


METHOD _process_event_request.

  DATA lr_grid_event            TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_okcode_request        TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_dragdropobject        TYPE REF TO cl_dragdropobject.
  DATA lr_tmp_messages          TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_root                  TYPE REF TO cx_root.

* The event request has to be specified.
  CHECK ir_event_request IS BOUND.

* The event request has to belong to self.
  CHECK ir_event_request->get_sender( ) = me.

* The event request has to be a grid event.
  TRY.
      lr_grid_event ?= ir_event_request.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Process the grid_event.
  TRY.

      CASE _own_cmd( ir_grid_event   = lr_grid_event
                     ir_orig_request = ir_event_request ).
        WHEN co_cmdresult_noproc.
*         We havn't processed the event
          RETURN.
        WHEN co_cmdresult_processed.
*         We have processed the event
          rr_response = cl_ish_gui_response=>create( ir_request   = ir_event_request
                                                     ir_processor = me ).
        WHEN co_cmdresult_exit.
*         We have processed the event and want to exit.
          rr_response = cl_ish_gui_response=>create( ir_request   = ir_event_request
                                                     ir_processor = me
                                                     i_exit       = abap_true ).
        WHEN co_cmdresult_okcode.
*         Create an okcode request for our event and propagate it
          lr_okcode_request = cl_ish_gui_okcode_request=>create_by_control_event(
                                              ir_sender         = me
                                              ir_processor      = me
                                              ir_control_event  = lr_grid_event ).

          _propagate_request( lr_okcode_request ).

          rr_response = cl_ish_gui_response=>create( ir_request   = ir_event_request
                                                     ir_processor = me ).
      ENDCASE.

*   On errors we have to display the messages.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( lx_root ).
      rr_response = cl_ish_gui_response=>create( ir_request   = ir_event_request
                                                 ir_processor = me ).
      IF lr_grid_event->get_fcode( ) = cl_ish_gui_grid_event=>co_fcode_on_drag.
        lr_dragdropobject = lr_grid_event->get_dragdropobject( ).
        IF lr_dragdropobject IS BOUND.
          lr_dragdropobject->abort( ).
        ENDIF.
      ENDIF.

  ENDTRY.

ENDMETHOD.


method _REFRESH_DISPLAY.

  _set_cursor_at_refresh_display( ).

endmethod.


METHOD _refresh_table_display.

  DATA lr_alv_grid                TYPE REF TO cl_gui_alv_grid.
  DATA ls_stable                  TYPE lvc_s_stbl.
  DATA lt_rowidx                  TYPE lvc_t_row.
  DATA lr_model                   TYPE REF TO if_ish_gui_model.
  DATA lt_marked_model            TYPE ish_t_gui_model_objhash.
  DATA ls_current_row             TYPE lvc_s_row.
  DATA ls_current_col             TYPE lvc_s_col.
  DATA lr_current_model           TYPE REF TO if_ish_gui_model.

  FIELD-SYMBOLS <ls_rowidx>       TYPE lvc_s_row.

* Get the alv_grid.
  lr_alv_grid = get_alv_grid( ).
  CHECK lr_alv_grid IS BOUND.

* Process only if first display is already done.
  CHECK is_first_display_done( ) = abap_true.

* If the flush_buffer is active we only have to add the grid to the flush_buffer.
  IF i_force = abap_false AND is_flush_buffer_active( ) = abap_true.
    _add_grid_to_flush_buffer( ir_alv_grid    = lr_alv_grid
                               i_stable_row   = i_stable_row
                               i_stable_col   = i_stable_col
                               i_soft_refresh = i_soft_refresh ).
    RETURN.
  ENDIF.

* On hard refresh:
*   - Remind the marked row models.
*   - Remind the row model and column for the current cell.
  IF i_soft_refresh = abap_false.
    CALL METHOD lr_alv_grid->get_selected_rows
      IMPORTING
        et_index_rows = lt_rowidx.
    IF lt_rowidx IS INITIAL.
      CALL METHOD lr_alv_grid->get_current_cell
        IMPORTING
          es_row_id = ls_current_row
          es_col_id = ls_current_col.
      IF ls_current_row-index IS NOT INITIAL.
        lr_current_model = get_model_by_idx( ls_current_row-index ).
      ENDIF.
    ELSE.
      LOOP AT lt_rowidx ASSIGNING <ls_rowidx>.
        lr_model = get_model_by_idx( <ls_rowidx>-index ).
        CHECK lr_model IS BOUND.
        INSERT lr_model INTO TABLE lt_marked_model.
      ENDLOOP.
    ENDIF.
  ENDIF.

* Refresh table display.
  ls_stable-row = i_stable_row.
  ls_stable-col = i_stable_col.
  CALL METHOD lr_alv_grid->refresh_table_display
    EXPORTING
      is_stable      = ls_stable
      i_soft_refresh = i_soft_refresh
    EXCEPTIONS
      OTHERS         = 1.
  CHECK sy-subrc = 0.

* On hard refresh:
*   - Reset the marked rows.
*   - Reset the actual cell.
* Set the selected rows.
  IF i_soft_refresh = abap_false.
    IF lr_current_model IS BOUND.
      ls_current_row-index  = _get_idx_by_model( lr_current_model ).
      lr_alv_grid->set_current_cell_via_id(
          is_row_id     = ls_current_row
          is_column_id  = ls_current_col ).
    ELSE.
      IF lt_marked_model IS NOT INITIAL.
        set_selected_rows_by_models( it_model = lt_marked_model ).
      ENDIF.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD _register_alv_grid_events.

  DATA:
    l_clsname            TYPE seoclsname,
    l_rc                 TYPE ish_method_rc,
    lr_errorhandler      TYPE REF TO cl_ishmed_errorhandling.

* The alv_grid has to be specified.
  CHECK ir_alv_grid IS BOUND.

* Register the eventhandlers.
  SET HANDLER on_after_user_command     FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_before_user_command    FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_button_click           FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_data_changed           FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_data_changed_finished  FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_double_click           FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_drag                   FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_drop                   FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_drop_complete          FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_hotspot_click          FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_menu_button            FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_toolbar                FOR ir_alv_grid ACTIVATION i_activation.
  SET HANDLER on_user_command           FOR ir_alv_grid ACTIVATION i_activation.

* Further processing only on activation.
  CHECK i_activation = abap_true.

* Register edit event.
  CALL METHOD ir_alv_grid->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_enter
    EXCEPTIONS
      error      = 1
      OTHERS     = 2.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    l_clsname = cl_ish_utl_rtti=>get_class_name( me ).
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '011'
        i_mv1           = l_rc
        i_mv2           = 'GR_GRID'
        i_mv3           = l_clsname
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD _register_model_eventhandlers.

  DATA lr_tabmdl            TYPE REF TO if_ish_gui_table_model.
  DATA lr_structmdl         TYPE REF TO if_ish_gui_structure_model.

  CHECK ir_model IS BOUND.

  IF ir_model = _get_main_model( ).
    TRY.
        lr_tabmdl ?= _get_main_model( ).
        SET HANDLER on_model_added    FOR lr_tabmdl ACTIVATION i_activation.
        SET HANDLER on_model_removed  FOR lr_tabmdl ACTIVATION i_activation.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
    RETURN.
  ENDIF.

  TRY.
      lr_structmdl ?= ir_model.
      SET HANDLER on_model_changed FOR lr_structmdl ACTIVATION i_activation.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD _remove_row_by_model.

  FIELD-SYMBOLS <lt_outtab>     TYPE table.

* The model has to be bound.
  CHECK ir_model IS BOUND.

* Get the index of the model.
  r_idx_removed = _get_idx_by_model( ir_model = ir_model ).
  CHECK r_idx_removed > 0.

* Delete the row.
  IF gr_outtab IS BOUND.
    ASSIGN gr_outtab->* TO <lt_outtab>.
    DELETE <lt_outtab> INDEX r_idx_removed.
  ENDIF.

* Deregister the row model events.
  _register_model_eventhandlers( ir_model     = ir_model
                                 i_activation = abap_false ).

ENDMETHOD.


METHOD _replace_model.

  DATA lr_row           TYPE REF TO data.

* Initial checking.
  CHECK ir_old_model IS BOUND.
  CHECK ir_new_model IS BOUND.
  CHECK ir_old_model <> ir_new_model.

* Get the row for the old model.
  lr_row = _get_row_by_model( ir_model = ir_old_model ).
  CHECK lr_row IS BOUND.

* Fill the row
  r_changed = _fill_row(
     ir_model = ir_new_model
     ir_row   = lr_row ).

* (De-)Register the model eventhandlers.
  _register_model_eventhandlers(
      ir_model     = ir_old_model
      i_activation = abap_false ).
  _register_model_eventhandlers(
      ir_model     = ir_new_model
      i_activation = abap_true ).

ENDMETHOD.


METHOD _set_cursor_at_refresh_display.

  DATA:
    l_row_idx                 TYPE lvc_index,
    l_col_fieldname           TYPE ish_fieldname,
    lr_application            TYPE REF TO if_ish_gui_application,
    ls_crspos_message         TYPE rn1message,
    lr_alv_grid               TYPE REF TO cl_gui_alv_grid.

* Get the application.
  lr_application = get_application( ).
  CHECK lr_application IS BOUND.

  lr_alv_grid = get_alv_grid( ).

* The crspos_message of the application has first priority.
* If there is a crspos_message, we have to set the cursor only if it belongs to us.
* If there is no crspos_message, we have to set the cursor only if we have the focus.
  ls_crspos_message = lr_application->get_crspos_message( ).
  CHECK ls_crspos_message IS NOT INITIAL.

  CALL METHOD _get_rowcol_by_message
    EXPORTING
      is_message      = ls_crspos_message
    IMPORTING
      e_row_idx       = l_row_idx
      e_col_fieldname = l_col_fieldname.

  CHECK l_row_idx IS NOT INITIAL AND l_col_fieldname IS NOT INITIAL.

  if_ish_gui_grid_view~set_selected_cell(
    i_row_idx       = l_row_idx
    i_col_fieldname = l_col_fieldname ).

  lr_application->clear_crspos_message( ).
  lr_application->set_focussed_view( ir_view = me ).

*  if_ish_gui_view~set_focus( ).

  CALL METHOD cl_gui_alv_grid=>set_focus
    EXPORTING
      control           = lr_alv_grid
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.

ENDMETHOD.


METHOD _set_dral_values.

  DATA ls_dral_hash               LIKE LINE OF gt_dral_hash.
  DATA ls_dral_values             TYPE rn1_gui_dral_values.
  DATA ls_dral                    TYPE lvc_s_dral.
  DATA lt_dral                    TYPE lvc_t_dral.
  DATA lr_alv_grid                TYPE REF TO cl_gui_alv_grid.

  FIELD-SYMBOLS <ls_dral_hash>    LIKE LINE OF gt_dral_hash.
  FIELD-SYMBOLS <ls_dral_values>  TYPE rn1_gui_dral_values.

  READ TABLE gt_dral_hash
    WITH TABLE KEY dral_handle = i_handle
    ASSIGNING <ls_dral_hash>.
  IF sy-subrc = 0.
    <ls_dral_hash>-t_dral_values = it_values.
  ELSE.
    ls_dral_hash-dral_handle    = i_handle.
    ls_dral_hash-t_dral_values  = it_values.
    INSERT ls_dral_hash INTO TABLE gt_dral_hash.
    ASSIGN ls_dral_hash TO <ls_dral_hash>.
  ENDIF.

  LOOP AT <ls_dral_hash>-t_dral_values ASSIGNING <ls_dral_values>.
    ls_dral-handle    = i_handle.
    ls_dral-value     = <ls_dral_values>-dral_value.
    ls_dral-int_value = <ls_dral_values>-dral_key.
    INSERT ls_dral INTO TABLE lt_dral.
  ENDLOOP.

  lr_alv_grid = get_alv_grid( ).
  CHECK lr_alv_grid IS BOUND.

  lr_alv_grid->set_drop_down_table( it_drop_down_alias = lt_dral ).

ENDMETHOD.


METHOD _set_vcode.

  DATA: lr_alv_grid            TYPE REF TO cl_gui_alv_grid.

* First call the super method to do default processing.
  r_changed = super->_set_vcode( i_vcode = i_vcode ).

* Further processing only if the vcode was changed.
  CHECK r_changed = abap_true.

* Get the alv_grid.
  lr_alv_grid = get_alv_grid( ).
  CHECK lr_alv_grid IS BOUND.

* Set ready for input.
  IF g_vcode = co_vcode_display.
    lr_alv_grid->set_ready_for_input( i_ready_for_input = 0 ).
  ELSE.
    lr_alv_grid->set_ready_for_input( i_ready_for_input = 1 ).
  ENDIF.

* Refresh table display to change the toolbar menu.
  lr_alv_grid->refresh_table_display( ).

ENDMETHOD.
ENDCLASS.
