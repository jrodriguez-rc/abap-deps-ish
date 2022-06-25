class CL_ISH_GUI_OKCODE_REQUEST definition
  public
  inheriting from CL_ISH_GUI_REQUEST
  create protected .

*"* public components of class CL_ISH_GUI_OKCODE_REQUEST
*"* do not include other source files here!!!
public section.

  constants CO_UCOMM_OKCODE_REQUEST type SYUCOMM value 'OKCODE_REQUEST'. "#EC NOTEXT

  class-methods CREATE
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !IR_PROCESSOR type ref to IF_ISH_GUI_REQUEST_PROCESSOR
      !I_UCOMM type SYUCOMM default CO_UCOMM_OKCODE_REQUEST
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_OKCODE_REQUEST .
  class-methods CREATE_BY_CONTROL_EVENT
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !IR_PROCESSOR type ref to IF_ISH_GUI_REQUEST_PROCESSOR
      !IR_CONTROL_EVENT type ref to CL_ISH_GUI_CONTROL_EVENT
      !I_UCOMM type SYUCOMM default CO_UCOMM_OKCODE_REQUEST
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_OKCODE_REQUEST .
  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !IR_PROCESSOR type ref to IF_ISH_GUI_REQUEST_PROCESSOR
      !I_UCOMM type SYUCOMM
      !IR_CONTROL_EVENT type ref to CL_ISH_GUI_CONTROL_EVENT optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_CONTROL_EVENT
    returning
      value(RR_CONTROL_EVENT) type ref to CL_ISH_GUI_CONTROL_EVENT .
  methods GET_PROCESSOR
    returning
      value(RR_PROCESSOR) type ref to IF_ISH_GUI_REQUEST_PROCESSOR .
  methods GET_UCOMM
    returning
      value(R_UCOMM) type SYUCOMM .
protected section.
*"* protected components of class CL_ISH_GUI_OKCODE_REQUEST
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_OKCODE_REQUEST
*"* do not include other source files here!!!

  data GR_CONTROL_EVENT type ref to CL_ISH_GUI_CONTROL_EVENT .
  data GR_PROCESSOR type ref to IF_ISH_GUI_REQUEST_PROCESSOR .
  data G_UCOMM type SYUCOMM .
ENDCLASS.



CLASS CL_ISH_GUI_OKCODE_REQUEST IMPLEMENTATION.


METHOD constructor.

  IF ir_processor IS NOT BOUND OR
     i_ucomm IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'CONSTRUCTOR'
        i_mv3 = 'CL_ISH_GUI_REQUEST' ).
  ENDIF.

  super->constructor( ir_sender = ir_sender ).

  gr_control_event = ir_control_event.
  gr_processor     = ir_processor.
  g_ucomm          = i_ucomm.

ENDMETHOD.


METHOD create.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender    = ir_sender
          ir_processor = ir_processor
          i_ucomm      = i_ucomm.
    CATCH cx_ish_static_handler .
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD create_by_control_event.

  CHECK ir_control_event IS BOUND.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender        = ir_sender
          ir_processor     = ir_processor
          i_ucomm          = i_ucomm
          ir_control_event = ir_control_event.
    CATCH cx_ish_static_handler .
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_control_event.

  rr_control_event = gr_control_event.

ENDMETHOD.


METHOD get_processor.

  rr_processor = gr_processor.

ENDMETHOD.


METHOD get_ucomm.

  r_ucomm = g_ucomm.

ENDMETHOD.
ENDCLASS.
