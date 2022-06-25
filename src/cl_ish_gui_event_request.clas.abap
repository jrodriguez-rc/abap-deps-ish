class CL_ISH_GUI_EVENT_REQUEST definition
  public
  inheriting from CL_ISH_GUI_REQUEST
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_EVENT_REQUEST
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GUI_EVENT_REQUEST
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_EVENT_REQUEST
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_EVENT_REQUEST IMPLEMENTATION.


METHOD constructor.

  super->constructor( ir_sender = ir_sender ).

ENDMETHOD.
ENDCLASS.
