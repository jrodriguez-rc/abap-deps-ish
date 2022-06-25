class CL_ISH_GUI_COMMAND_REQUEST definition
  public
  inheriting from CL_ISH_GUI_REQUEST
  create protected .

public section.
*"* public components of class CL_ISH_GUI_COMMAND_REQUEST
*"* do not include other source files here!!!

  class-methods CREATE_BY_FCODE
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !I_FCODE type UI_FUNC
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_COMMAND_REQUEST .
  class-methods CREATE_BY_OKCODE_REQUEST
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !IR_OKCODE_REQUEST type ref to CL_ISH_GUI_OKCODE_REQUEST
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_COMMAND_REQUEST .
  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !I_FCODE type UI_FUNC
      !IR_OKCODE_REQUEST type ref to CL_ISH_GUI_OKCODE_REQUEST optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_FCODE
  final
    returning
      value(R_FCODE) type UI_FUNC .
  methods GET_OKCODE_REQUEST
  final
    returning
      value(RR_OKCODE_REQUEST) type ref to CL_ISH_GUI_OKCODE_REQUEST .
protected section.
*"* protected components of class CL_ISH_GUI_COMMAND_REQUEST
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_COMMAND_REQUEST
*"* do not include other source files here!!!

  data GR_OKCODE_REQUEST type ref to CL_ISH_GUI_OKCODE_REQUEST .
  data G_FCODE type UI_FUNC .
ENDCLASS.



CLASS CL_ISH_GUI_COMMAND_REQUEST IMPLEMENTATION.


METHOD constructor.

  IF i_fcode IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  super->constructor( ir_sender = ir_sender ).

  g_fcode           = i_fcode.
  gr_okcode_request = ir_okcode_request.

ENDMETHOD.


METHOD create_by_fcode.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender = ir_sender
          i_fcode   = i_fcode.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD create_by_okcode_request.

  DATA l_ucomm              TYPE syucomm.

  CHECK ir_okcode_request IS BOUND.
  l_ucomm = ir_okcode_request->get_ucomm( ).
  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender         = ir_sender
          i_fcode           = l_ucomm
          ir_okcode_request = ir_okcode_request.
    CATCH cx_ish_static_handler .
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_fcode.

  r_fcode = g_fcode.

ENDMETHOD.


METHOD get_okcode_request.

  rr_okcode_request = gr_okcode_request.

ENDMETHOD.
ENDCLASS.
