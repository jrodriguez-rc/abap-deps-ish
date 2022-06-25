class CL_ISH_GUI_DRAWERS_EVENT definition
  public
  inheriting from CL_ISH_GUI_CONTROL_EVENT
  create protected .

public section.
*"* public components of class CL_ISH_GUI_DRAWERS_EVENT
*"* do not include other source files here!!!

  class-methods CREATE
    importing
      !IR_SENDER type ref to IF_ISH_GUI_DRAWERS_VIEW
      !I_FCODE type UI_FUNC
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_DRAWERS_EVENT .
  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_DRAWERS_VIEW
      !I_FCODE type UI_FUNC
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DRAWERS_VIEW
    returning
      value(RR_DRAWERS_VIEW) type ref to IF_ISH_GUI_DRAWERS_VIEW .
protected section.
*"* protected components of class CL_ISH_GUI_TOOLBAR_EVENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_DRAWERS_EVENT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_DRAWERS_EVENT IMPLEMENTATION.


METHOD constructor.

  super->constructor( ir_sender = ir_sender
                      i_fcode   = i_fcode ).

ENDMETHOD.


METHOD create.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender = ir_sender
          i_fcode   = i_fcode.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_drawers_view.

  TRY.
      rr_drawers_view ?= get_control_view( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.
ENDCLASS.
