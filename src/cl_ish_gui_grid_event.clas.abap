class CL_ISH_GUI_GRID_EVENT definition
  public
  inheriting from CL_ISH_GUI_CONTROL_EVENT
  create protected .

*"* public components of class CL_ISH_GUI_GRID_EVENT
*"* do not include other source files here!!!
public section.

  constants CO_FCODE_BUTTON_CLICK type UI_FUNC value 'BUTTON_CLICK'. "#EC NOTEXT
  constants CO_FCODE_DOUBLE_CLICK type UI_FUNC value 'DOUBLE_CLICK'. "#EC NOTEXT
  constants CO_FCODE_HOTSPOT_CLICK type UI_FUNC value 'HOTSPOT_CLICK'. "#EC NOTEXT
  constants CO_FCODE_ON_DRAG type UI_FUNC value 'ONDRAG'. "#EC NOTEXT
  constants CO_FCODE_ON_DROP type UI_FUNC value 'ONDROP'. "#EC NOTEXT
  constants CO_FCODE_ON_DROP_COMPLETE type UI_FUNC value 'ONDROPCOMPLETE'. "#EC NOTEXT

  type-pools ABAP .
  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_GRID_VIEW
      !I_FCODE type UI_FUNC
      !I_STARTUP_ACTION type ABAP_BOOL default ABAP_TRUE
      !IR_ROW_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_ROW_IDX type LVC_INDEX optional
      !I_COL_FIELDNAME type ISH_FIELDNAME optional
      !IR_DRAGDROPOBJECT type ref to CL_DRAGDROPOBJECT optional
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE
    importing
      !IR_SENDER type ref to IF_ISH_GUI_GRID_VIEW
      !I_FCODE type UI_FUNC
      !IR_ROW_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_ROW_IDX type LVC_INDEX optional
      !I_COL_FIELDNAME type ISH_FIELDNAME optional
      !IR_DRAGDROPOBJECT type ref to CL_DRAGDROPOBJECT optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_GRID_EVENT .
  methods GET_COL_FIELDNAME
  final
    returning
      value(R_COL_FIELDNAME) type ISH_FIELDNAME .
  methods GET_DRAGDROPOBJECT
    returning
      value(RR_DRAGDROPOBJECT) type ref to CL_DRAGDROPOBJECT .
  methods GET_GRID_VIEW
  final
    returning
      value(RR_GRID_VIEW) type ref to IF_ISH_GUI_GRID_VIEW .
  methods GET_ROW_IDX
  final
    returning
      value(R_ROW_IDX) type LVC_INDEX .
  methods GET_ROW_MODEL
  final
    returning
      value(RR_ROW_MODEL) type ref to IF_ISH_GUI_MODEL .
protected section.
*"* protected components of class CL_ISH_GUI_GRID_EVENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_GRID_EVENT
*"* do not include other source files here!!!

  data GR_DRAGDROPOBJECT type ref to CL_DRAGDROPOBJECT .
  data GR_ROW_MODEL type ref to IF_ISH_GUI_MODEL .
  data G_COL_FIELDNAME type ISH_FIELDNAME .
  data G_ROW_IDX type LVC_INDEX .
ENDCLASS.



CLASS CL_ISH_GUI_GRID_EVENT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      ir_sender         = ir_sender
      i_fcode           = i_fcode
      i_startup_action  = i_startup_action ).

  gr_row_model      = ir_row_model.
  g_row_idx         = i_row_idx.
  g_col_fieldname   = i_col_fieldname.
  gr_dragdropobject = ir_dragdropobject.

ENDMETHOD.


METHOD create.

  DATA l_startup_action                   TYPE abap_bool.

  CASE i_fcode.
    WHEN co_fcode_on_drop OR
         co_fcode_on_drop_complete.
      l_startup_action = abap_false.
    WHEN OTHERS.
      l_startup_action = abap_true.
  ENDCASE.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender         = ir_sender
          i_fcode           = i_fcode
          ir_row_model      = ir_row_model
          i_row_idx         = i_row_idx
          i_col_fieldname   = i_col_fieldname
          ir_dragdropobject = ir_dragdropobject
          i_startup_action  = l_startup_action.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_col_fieldname.

  r_col_fieldname = g_col_fieldname.

ENDMETHOD.


METHOD get_dragdropobject.

  rr_dragdropobject = gr_dragdropobject.

ENDMETHOD.


METHOD get_grid_view.

  TRY.
      rr_grid_view ?= get_control_view( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_row_idx.

  r_row_idx = g_row_idx.

ENDMETHOD.


METHOD get_row_model.

  rr_row_model = gr_row_model.

ENDMETHOD.
ENDCLASS.
