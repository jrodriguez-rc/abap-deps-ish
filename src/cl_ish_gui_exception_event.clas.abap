class CL_ISH_GUI_EXCEPTION_EVENT definition
  public
  inheriting from CL_ISH_GUI_EVENT_REQUEST
  create protected .

public section.
*"* public components of class CL_ISH_GUI_EXCEPTION_EVENT
*"* do not include other source files here!!!

  class-methods CREATE
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !IR_EXCEPTION type ref to CX_ROOT
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_EXCEPTION_EVENT .
  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !IR_EXCEPTION type ref to CX_ROOT
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_EXCEPTION
  final
    returning
      value(RR_EXCEPTION) type ref to CX_ROOT .
protected section.
*"* protected components of class CL_ISH_GUI_EXCEPTION_EVENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_EXCEPTION_EVENT
*"* do not include other source files here!!!

  data GR_EXCEPTION type ref to CX_ROOT .
ENDCLASS.



CLASS CL_ISH_GUI_EXCEPTION_EVENT IMPLEMENTATION.


METHOD constructor.

  IF ir_exception IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  super->constructor( ir_sender = ir_sender ).

  gr_exception = ir_exception.

ENDMETHOD.


METHOD create.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender    = ir_sender
          ir_exception = ir_exception.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_exception.

  rr_exception = gr_exception.

ENDMETHOD.
ENDCLASS.
