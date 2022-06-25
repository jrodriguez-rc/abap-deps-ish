class CL_ISH_GUI_REQUEST definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_REQUEST
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_SENDER
  final
    returning
      value(RR_SENDER) type ref to IF_ISH_GUI_REQUEST_SENDER .
protected section.
*"* protected components of class CL_ISH_GUI_REQUEST
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_REQUEST
*"* do not include other source files here!!!

  data GR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER .
ENDCLASS.



CLASS CL_ISH_GUI_REQUEST IMPLEMENTATION.


METHOD constructor.

  IF ir_sender IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  super->constructor( ).

  gr_sender = ir_sender.

ENDMETHOD.


METHOD get_sender.

  rr_sender = gr_sender.

ENDMETHOD.
ENDCLASS.
