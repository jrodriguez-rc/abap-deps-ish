class CL_ISH_SCR_GA definition
  public
  inheriting from CL_ISH_SCREEN
  abstract
  create public .

public section.
*"* public components of class CL_ISH_SCR_GA
*"* do not include other source files here!!!

  constants CO_OTYPE_SCR_GA type ISH_OBJECT_TYPE value 13764. "#EC NOTEXT

  methods GET_APPLICATION
    returning
      value(RR_APPLICATION) type ref to IF_ISH_GUI_APPLICATION .
  methods SET_APPLICATION
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~SET_DATA
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_GA
*"* do not include other source files here!!!

  data GR_APPLICATION type ref to IF_ISH_GUI_APPLICATION .

  methods INITIALIZE_FIELD_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_GA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_GA IMPLEMENTATION.


METHOD get_application.

  rr_application = gr_application.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_scr_ga.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_scr_ga.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~destroy.

  IF gr_application IS BOUND.
    gr_application->destroy( ).
    CLEAR gr_application.
  ENDIF.

  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen.

  DATA lr_main_ctr          TYPE REF TO if_ish_gui_main_controller.
  DATA lr_request           TYPE REF TO cl_ish_gui_mdy_event.

  CLEAR e_rc.

  CHECK gr_application IS BOUND.

  lr_main_ctr = gr_application->get_main_controller( ).
  CHECK lr_main_ctr IS BOUND.

  lr_request = cl_ish_gui_mdy_event=>create(
      ir_sender = lr_main_ctr->get_mdy_view( )
      i_ucomm   = c_okcode ).
  CHECK lr_request IS BOUND.

  IF gr_application->process_request( ir_request = lr_request ) IS BOUND.
    CLEAR c_okcode.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~set_data.

  DATA lx_static            TYPE REF TO cx_ish_static_handler.

  CALL METHOD super->if_ish_screen~set_data
    EXPORTING
      i_main_object      = i_main_object
      i_main_object_x    = i_main_object_x
      i_vcode            = i_vcode
      i_vcode_x          = i_vcode_x
      i_screen_values    = i_screen_values
      i_screen_values_x  = i_screen_values_x
      i_top_msg_popup    = i_top_msg_popup
      i_top_msg_popup_x  = i_top_msg_popup_x
      i_left_msg_popup   = i_left_msg_popup
      i_left_msg_popup_x = i_left_msg_popup_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      c_errorhandler     = c_errorhandler.

  CHECK gr_application IS BOUND.

  IF i_vcode_x = abap_true.
    TRY.
        gr_application->set_vcode( g_vcode ).
      CATCH cx_ish_static_handler INTO lx_static.
        e_rc = 1.
        IF lx_static->gr_errorhandler IS BOUND.
          CALL METHOD cl_ish_utl_base=>copy_messages
            EXPORTING
              i_copy_from     = lx_static->gr_errorhandler
            CHANGING
              cr_errorhandler = c_errorhandler.
        ENDIF.
    ENDTRY.
  ENDIF.

ENDMETHOD.


METHOD initialize_field_values.

* No field values.

ENDMETHOD.


METHOD set_application.

  gr_application = ir_application.

ENDMETHOD.
ENDCLASS.
