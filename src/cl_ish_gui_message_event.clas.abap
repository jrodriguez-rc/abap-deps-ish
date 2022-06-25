class CL_ISH_GUI_MESSAGE_EVENT definition
  public
  inheriting from CL_ISH_GUI_EVENT_REQUEST
  create protected .

public section.
*"* public components of class CL_ISH_GUI_MESSAGE_EVENT
*"* do not include other source files here!!!

  class-methods CREATE
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !IR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_MESSAGE_EVENT .
  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !IR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_MESSAGES
  final
    returning
      value(RR_MESSAGES) type ref to CL_ISHMED_ERRORHANDLING .
protected section.
*"* protected components of class CL_ISH_GUI_MESSAGE_EVENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_MESSAGE_EVENT
*"* do not include other source files here!!!

  data GR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING .
ENDCLASS.



CLASS CL_ISH_GUI_MESSAGE_EVENT IMPLEMENTATION.


METHOD constructor.

  IF ir_messages IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  super->constructor( ir_sender = ir_sender ).

  CREATE OBJECT gr_messages.
  gr_messages->copy_messages( i_copy_from = ir_messages ).

ENDMETHOD.


METHOD create.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender   = ir_sender
          ir_messages = ir_messages.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_messages.

  CHECK gr_messages IS BOUND.

  CREATE OBJECT rr_messages.
  rr_messages->copy_messages( i_copy_from = gr_messages ).

ENDMETHOD.
ENDCLASS.
