class CL_ISH_DND_GRID definition
  public
  inheriting from CL_ISH_DND
  create public .

*"* public components of class CL_ISH_DND_GRID
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_DND_GRID type ISH_OBJECT_TYPE value 4027. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID optional
      !IS_ROW type LVC_S_ROW optional
      !IS_COL type LVC_S_COL optional
      !IS_ROW_NO type LVC_S_ROID optional .
  methods GET_SCR_ALV_GRID
    returning
      value(RR_SCR_ALV_GRID) type ref to IF_ISH_SCR_ALV_GRID .
  methods GET_ROW
    returning
      value(RS_ROW) type LVC_S_ROW .
  methods GET_COL
    returning
      value(RS_COL) type LVC_S_COL .
  methods GET_ROW_NO
    returning
      value(RS_ROW_NO) type LVC_S_ROID .
  methods SET_SCR_ALV_GRID
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods SET_ROW
    importing
      !IS_ROW type LVC_S_ROW
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods SET_COL
    importing
      !IS_COL type LVC_S_COL
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods SET_ROW_NO
    importing
      !IS_ROW_NO type LVC_S_ROID
    returning
      value(R_SUCCESS) type ISH_ON_OFF .

  methods DESTROY
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods SET_SCR_CONTROL
    redefinition .
protected section.
*"* protected components of class CL_ISH_DND_GRID
*"* do not include other source files here!!!

  data GS_ROW type LVC_S_ROW .
  data GS_COL type LVC_S_COL .
  data GS_ROW_NO type LVC_S_ROID .
private section.
*"* private components of class CL_ISH_DND_GRID
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DND_GRID IMPLEMENTATION.


METHOD constructor.

  CALL METHOD super->constructor
    EXPORTING
      ir_scr_control = ir_scr_alv_grid.

  gs_row          = is_row.
  gs_col          = is_col.
  gs_row_no       = is_row_no.

ENDMETHOD.


METHOD destroy.

  super->destroy( ).

  CLEAR: gs_col,
         gs_row,
         gs_row_no.

ENDMETHOD.


METHOD get_col.

  rs_col = gs_col.

ENDMETHOD.


METHOD get_row.

  rs_row = gs_row.

ENDMETHOD.


METHOD get_row_no.

  rs_row_no = gs_row_no.

ENDMETHOD.


METHOD get_scr_alv_grid.

  CLEAR rr_scr_alv_grid.

  CHECK gr_scr_control IS BOUND.
  CHECK gr_scr_control->is_inherited_from(
          cl_ish_scr_alv_grid=>co_otype_scr_alv_grid ) = on.

  rr_scr_alv_grid ?= gr_scr_control.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dnd_grid.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dnd_grid.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD set_col.

  gs_col = is_col.

  r_success = on.

ENDMETHOD.


METHOD set_row.

  gs_row = is_row.

  r_success = on.

ENDMETHOD.


METHOD set_row_no.

  gs_row_no = is_row_no.

  r_success = on.

ENDMETHOD.


METHOD set_scr_alv_grid.

  gr_scr_control = ir_scr_alv_grid.

  r_success = on.

ENDMETHOD.


METHOD set_scr_control.

* Initializations.
  r_success = off.

* Checking.
  IF ir_scr_control IS BOUND.
    CHECK ir_scr_control->is_inherited_from(
            cl_ish_scr_alv_grid=>co_otype_scr_alv_grid ) = on.
  ENDIF.

* Perform.
  r_success = super->set_scr_control( ir_scr_control ).

ENDMETHOD.
ENDCLASS.
