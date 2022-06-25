class CL_ISH_GUI_RESPONSE definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_GUI_RESPONSE
*"* do not include other source files here!!!

  constants CO_RC_CANCELLED type ISH_METHOD_RC value 1. "#EC NOTEXT
  constants CO_RC_PROCESSED type ISH_METHOD_RC value 0. "#EC NOTEXT

  type-pools ABAP .
  class-methods CREATE
    importing
      !IR_REQUEST type ref to CL_ISH_GUI_REQUEST optional
      !IR_PROCESSOR type ref to IF_ISH_GUI_REQUEST_PROCESSOR optional
      !I_RC type ISH_METHOD_RC default CO_RC_PROCESSED
      !I_EXIT type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_RESPONSE .
  methods CONSTRUCTOR
    importing
      !IR_REQUEST type ref to CL_ISH_GUI_REQUEST optional
      !IR_PROCESSOR type ref to IF_ISH_GUI_REQUEST_PROCESSOR optional
      !I_RC type ISH_METHOD_RC default CO_RC_PROCESSED
      !I_EXIT type ABAP_BOOL default ABAP_FALSE .
  methods GET_EXIT
    returning
      value(R_EXIT) type ABAP_BOOL .
  methods GET_PROCESSOR
    returning
      value(RR_PROCESSOR) type ref to IF_ISH_GUI_REQUEST_PROCESSOR .
  methods GET_RC
    returning
      value(R_RC) type ISH_METHOD_RC .
  methods GET_REQUEST
    returning
      value(RR_REQUEST) type ref to CL_ISH_GUI_REQUEST .
  methods SET_EXIT
    importing
      !I_EXIT type ABAP_BOOL .
  methods SET_RC
    importing
      !I_RC type ISH_METHOD_RC .
protected section.
*"* protected components of class CL_ISH_GUI_RESPONSE
*"* do not include other source files here!!!

  data GR_PROCESSOR type ref to IF_ISH_GUI_REQUEST_PROCESSOR .
  data GR_REQUEST type ref to CL_ISH_GUI_REQUEST .
  data G_EXIT type ABAP_BOOL .
  data G_RC type ISH_METHOD_RC .
private section.
*"* private components of class CL_ISH_GUI_RESPONSE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_RESPONSE IMPLEMENTATION.


METHOD constructor.

  super->constructor( ).

  gr_request   = ir_request.
  gr_processor = ir_processor.
  g_rc         = i_rc.
  g_exit       = i_exit.

ENDMETHOD.


METHOD create.

  CREATE OBJECT rr_instance
    EXPORTING
      ir_request   = ir_request
      ir_processor = ir_processor
      i_rc         = i_rc
      i_exit       = i_exit.

ENDMETHOD.


METHOD get_exit.

  r_exit = g_exit.

ENDMETHOD.


METHOD get_processor.

  rr_processor = gr_processor.

ENDMETHOD.


METHOD get_rc.

  r_rc = g_rc.

ENDMETHOD.


METHOD get_request.

  rr_request = gr_request.

ENDMETHOD.


METHOD set_exit.

  g_exit = i_exit.

ENDMETHOD.


METHOD set_rc.

  g_rc = i_rc.

ENDMETHOD.
ENDCLASS.
