class CL_ISH_GUI_CONTROL_EVENT definition
  public
  inheriting from CL_ISH_GUI_EVENT_REQUEST
  abstract
  create public .

*"* public components of class CL_ISH_GUI_CONTROL_EVENT
*"* do not include other source files here!!!
public section.

  type-pools ABAP .
  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_CONTROL_VIEW
      !I_FCODE type UI_FUNC
      !I_STARTUP_ACTION type ABAP_BOOL default ABAP_TRUE
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_CONTROL_VIEW
  final
    returning
      value(RR_CONTROL_VIEW) type ref to IF_ISH_GUI_CONTROL_VIEW .
  methods GET_FCODE
  final
    returning
      value(R_FCODE) type UI_FUNC .
  methods IS_STARTUP_ACTION
    returning
      value(R_STARTUP_ACTION) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_GUI_CONTROL_EVENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_CONTROL_EVENT
*"* do not include other source files here!!!

  data G_FCODE type UI_FUNC .
  data G_STARTUP_ACTION type ABAP_BOOL .
ENDCLASS.



CLASS CL_ISH_GUI_CONTROL_EVENT IMPLEMENTATION.


METHOD constructor.

  IF i_fcode IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'CONSTRUCTOR'
        i_mv3 = 'CL_ISH_GUI_CONTROL_EVENT' ).
  ENDIF.

  super->constructor( ir_sender = ir_sender ).

  g_fcode           = i_fcode.
  g_startup_action  = i_startup_action.

ENDMETHOD.


METHOD get_control_view.

  TRY.
      rr_control_view ?= get_sender( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_fcode.

  r_fcode = g_fcode.

ENDMETHOD.


METHOD is_startup_action.

  r_startup_action = g_startup_action.

ENDMETHOD.
ENDCLASS.
