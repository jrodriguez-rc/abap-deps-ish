class CL_ISH_SCR_TOOLBAR definition
  public
  inheriting from CL_ISH_SCR_CONTROL
  create protected .

public section.
*"* public components of class CL_ISH_SCR_TOOLBAR
*"* do not include other source files here!!!

  interfaces IF_ISH_SCR_TOOLBAR .

  aliases GET_CONFIG_TOOLBAR
    for IF_ISH_SCR_TOOLBAR~GET_CONFIG_TOOLBAR .
  aliases GET_FCODE_FROM_UCOMM
    for IF_ISH_SCR_TOOLBAR~GET_FCODE_FROM_UCOMM .
  aliases GET_FVAR
    for IF_ISH_SCR_TOOLBAR~GET_FVAR .
  aliases GET_TOOLBAR
    for IF_ISH_SCR_TOOLBAR~GET_TOOLBAR .
  aliases SET_FVAR
    for IF_ISH_SCR_TOOLBAR~SET_FVAR .

  constants CO_EVENT_DDCLICKED type STRING value 'DDCLICKED'. "#EC NOTEXT
  constants CO_EVENT_FUNCSEL type STRING value 'FUNCSEL'. "#EC NOTEXT
  constants CO_OTYPE_SCR_TOOLBAR type ISH_OBJECT_TYPE value 12230. "#EC NOTEXT

  class-methods CREATE
    exporting
      !ER_INSTANCE type ref to CL_ISH_SCR_TOOLBAR
      !ER_INTERFACE type ref to IF_ISH_SCREEN
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~PROCESS_BEFORE_OUTPUT
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_TOOLBAR
*"* do not include other source files here!!!

  data GR_TOOLBAR type ref to CL_GUI_TOOLBAR .
  data GR_FVAR type ref to CL_ISH_FVAR .

  methods ADD_FVAR_BUTTON
    importing
      !IR_BUTTON type ref to CL_ISH_FVAR_BUTTON
      !I_INCL_FUNCTIONS type ISH_ON_OFF default ON
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods ADD_FVAR_BUTTONS
    importing
      !IR_FVAR type ref to CL_ISH_FVAR
      !I_INCL_FUNCTIONS type ISH_ON_OFF default ON
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods ADD_FVAR_FUNCTION
    importing
      !IR_FUNCTION type ref to CL_ISH_FVAR_FUNCTION
      !I_BUTTON_FCODE type ANY optional
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods ADD_FVAR_FUNCTIONS
    importing
      !IR_BUTTON type ref to CL_ISH_FVAR_BUTTON
      !I_BUTTON_FCODE type ANY optional
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_UCOMM_TOOLBAR
    importing
      !I_EVENT type STRING
      !I_FCODE type UI_FUNC
    returning
      value(R_UCOMM) type SY-UCOMM .
  methods CREATE_BUTTONS
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_BUTTONS_INTERNAL
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DESTROY_TOOLBAR
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DISPLAY_MSG_AFTER_SYSEV
    importing
      !IR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  methods HANDLE_DROPDOWN_CLICKED
    for event DROPDOWN_CLICKED of CL_GUI_TOOLBAR
    importing
      !FCODE
      !POSX
      !POSY .
  methods HANDLE_FUNCTION_SELECTED
    for event FUNCTION_SELECTED of CL_GUI_TOOLBAR
    importing
      !FCODE .
  methods PROCESS_DDCLICKED
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_DDCLICKED_INTERNAL
    importing
      !I_FCODE type UI_FUNC
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_FUNCSEL
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_FUNCSEL_INTERNAL
    importing
      !I_FCODE type UI_FUNC
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_DDCLICKED
    importing
      !I_FCODE type UI_FUNC
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_DDCLICKED_INTERN
    importing
      !I_FCODE type UI_FUNC
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_FUNCSEL
    importing
      !I_FCODE type UI_FUNC
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_FUNCSEL_INTERNAL
    importing
      !I_FCODE type UI_FUNC
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_TOOLBAR_HANDLERS
    importing
      !I_ACTIVATION type ISH_ON_OFF default ON
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods INITIALIZE_FIELD_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_TOOLBAR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_TOOLBAR IMPLEMENTATION.


METHOD add_fvar_button.

  DATA: l_fcode       TYPE ui_func,
        l_icon        TYPE scrficon,
        l_butn_type   TYPE tb_btype,
        l_text        TYPE nbuttontxt,
        l_quickinfo   TYPE scrficon_q.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK gr_toolbar IS BOUND.
  CHECK ir_button IS BOUND.

* Add the button.
  l_fcode = ir_button->get_fcode( ).
  l_icon = ir_button->get_icon( ).
  l_butn_type = ir_button->get_buttontype( ).
  l_text = ir_button->get_text( ).
  l_quickinfo = ir_button->get_quickinfo( ).

  CALL METHOD gr_toolbar->add_button
    EXPORTING
      fcode            = l_fcode
      icon             = l_icon
      butn_type        = l_butn_type
      text             = l_text
      quickinfo        = l_quickinfo
    EXCEPTIONS
      cntl_error       = 1
      cntb_btype_error = 2
      cntb_error_fcode = 3
      OTHERS           = 4.
  e_rc = sy-subrc.
  IF e_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_TOOLBAR'
        i_mv3           = 'CL_ISH_SCR_TOOLBAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Add the functions if specified.
  IF i_incl_functions = on.
    CALL METHOD add_fvar_functions
      EXPORTING
        ir_button       = ir_button
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD add_fvar_buttons.

  DATA: lt_button  TYPE ish_t_fvar_button_obj,
        lr_button  TYPE REF TO cl_ish_fvar_button.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK ir_fvar IS BOUND.

* Get all buttons of the given fvar.
  lt_button = ir_fvar->get_all_buttons( ).
  CHECK lt_button IS NOT INITIAL.

* Add the buttons.
  LOOP AT lt_button INTO lr_button.
    CHECK lr_button IS BOUND.
    CALL METHOD add_fvar_button
      EXPORTING
        ir_button        = lr_button
        i_incl_functions = i_incl_functions
      IMPORTING
        e_rc             = e_rc
      CHANGING
        cr_errorhandler  = cr_errorhandler.
    CHECK e_rc = 0.
  ENDLOOP.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD add_fvar_function.

  DATA: l_button_fcode  TYPE ui_func,
        lr_button       TYPE REF TO cl_ish_fvar_button,
        lr_ctmenu       TYPE REF TO cl_ctmenu,
        l_text40        TYPE gui_text.

  FIELD-SYMBOLS: <ls_ctxmenu>  TYPE stb_btnmnu.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK gr_toolbar IS BOUND.
  CHECK ir_function IS BOUND.

* Get the fcode of the corresponding button.
  IF i_button_fcode IS SUPPLIED.
    TRY.
        l_button_fcode = i_button_fcode.
      CATCH cx_root.
        RETURN.
    ENDTRY.
  ELSE.
    lr_button = ir_function->get_button( ).
    CHECK lr_button IS BOUND.
    l_button_fcode = lr_button->get_fcode( ).
  ENDIF.

* Get or create the ctmenu.
  READ TABLE gr_toolbar->m_table_ctxmenu with key function = l_button_fcode ASSIGNING <ls_ctxmenu>.
  IF sy-subrc = 0.
    lr_ctmenu = <ls_ctxmenu>-ctmenu.
  ENDIF.
  IF lr_ctmenu IS NOT BOUND.
    CREATE OBJECT lr_ctmenu.
  ENDIF.

* Add the function.
  l_button_fcode = ir_function->get_fcode( ).
  l_text40 = ir_function->get_text40( ).

  lr_ctmenu->add_function( fcode = l_button_fcode
                           text  =  l_text40 ).
  CALL METHOD gr_toolbar->set_static_ctxmenu
    EXPORTING
      fcode                = l_button_fcode
      ctxmenu              = lr_ctmenu
    EXCEPTIONS
      ctmenu_error         = 1
      cntl_error           = 2
      cntb_error_parameter = 3
      OTHERS               = 4.
  e_rc = sy-subrc.
  IF e_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_TOOLBAR'
        i_mv3           = 'CL_ISH_SCR_TOOLBAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD add_fvar_functions.

  DATA: lt_function      TYPE ish_t_fvar_function_obj,
        lr_function      TYPE REF TO cl_ish_fvar_function,
        l_button_fcode   TYPE ui_func.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK ir_button IS BOUND.

* Get the button fcode.
  IF i_button_fcode IS SUPPLIED.
    TRY.
        l_button_fcode = i_button_fcode.
      CATCH cx_root.
        RETURN.
    ENDTRY.
  ELSE.
    l_button_fcode = ir_button->get_fcode( ).
  ENDIF.
  CHECK l_button_fcode IS NOT INITIAL.

* Get the functions.
  lt_function = ir_button->get_all_functions( ).
  CHECK lt_function IS NOT INITIAL.

* Add the functions.
  LOOP AT lt_function INTO lr_function.
    CALL METHOD add_fvar_function
      EXPORTING
        ir_function     = lr_function
        i_button_fcode  = l_button_fcode
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDLOOP.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD build_ucomm_toolbar.

* Initial checking.
  CHECK i_event IS NOT INITIAL.
  CHECK i_fcode IS NOT INITIAL.

  r_ucomm = i_event.

* Add the control id.
  CALL METHOD build_ucomm
    CHANGING
      c_ucomm = r_ucomm.

* Add the fcode.
  CONCATENATE r_ucomm
              i_fcode
         INTO r_ucomm
    SEPARATED BY '.'.

ENDMETHOD.


METHOD create.

  CREATE OBJECT er_instance.
  er_interface = er_instance.

ENDMETHOD.


METHOD create_buttons.

  DATA: lr_config_toolbar    TYPE REF TO if_ish_config_toolbar.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK gr_toolbar IS BOUND.

* Delete the actual buttons.
  CALL METHOD gr_toolbar->delete_all_buttons
    EXCEPTIONS
      cntl_error = 1
      OTHERS     = 2.
  e_rc = sy-subrc.
  IF e_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_TOOLBAR'
        i_mv3           = 'CL_ISH_SCR_TOOLBAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Create the buttons.
  CALL METHOD create_buttons_internal
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Let the configuration modify the toolbar.
  DO 1 TIMES.
    CALL METHOD get_config_toolbar
      IMPORTING
        er_config_toolbar = lr_config_toolbar
        e_rc              = e_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK lr_config_toolbar IS BOUND.
    CALL METHOD lr_config_toolbar->modify_toolbar
      EXPORTING
        ir_scr_toolbar  = me
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDDO.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD create_buttons_internal.

* The base class handles function variants.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK gr_fvar IS BOUND.

* Add the fvar buttons.
  CALL METHOD add_fvar_buttons
    EXPORTING
      ir_fvar          = gr_fvar
      i_incl_functions = on
    IMPORTING
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.

ENDMETHOD.


METHOD destroy_toolbar.

  DATA: l_rc  TYPE ish_method_rc.

* Initializations.
  CLEAR: e_rc.

* Process only if we have a toolbar object.
  CHECK gr_toolbar IS BOUND.

* Deactivate the handlers.
  CALL METHOD set_toolbar_handlers
    EXPORTING
      i_activation    = off
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Free the toolbar.
  CALL METHOD gr_toolbar->free
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_TOOLBAR'
        i_mv3           = 'CL_ISH_SCR_TOOLBAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

* Clear the gr_toolbar attribute.
  CLEAR gr_toolbar.

ENDMETHOD.


METHOD display_msg_after_sysev.

  CHECK ir_errorhandler IS BOUND.

  CALL METHOD ir_errorhandler->display_messages
    EXPORTING
      i_amodal          = off
      i_show_double_msg = off
      i_send_if_one     = on
      i_control         = on.

ENDMETHOD.


METHOD handle_dropdown_clicked.

  DATA: l_ucomm          TYPE sy-ucomm,
        l_handled        TYPE ish_on_off,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_rc             TYPE ish_method_rc.

* Initial checking.
  CHECK fcode IS NOT INITIAL.

* Process the system event.
  CALL METHOD process_sysev_ddclicked
    EXPORTING
      i_fcode         = fcode
    IMPORTING
      e_handled       = l_handled
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.
  IF l_rc <> 0.
    CALL METHOD set_okcode_sysev_error
      EXPORTING
        i_rc            = l_rc
        ir_errorhandler = lr_errorhandler.
    EXIT.
  ENDIF.

* Build the ucomm.
  l_ucomm = build_ucomm_toolbar( i_event = co_event_ddclicked
                                 i_fcode = fcode ).
  CHECK NOT l_ucomm IS INITIAL.

* If the system event was not handled by self
* we raise event ev_system_event to allow the framework (e.g. process)
* to process the system event.
  IF l_handled = off.
    CALL METHOD raise_ev_system_event
      EXPORTING
        i_ucomm         = l_ucomm
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
    IF l_rc <> 0.
      CALL METHOD set_okcode_sysev_error
        EXPORTING
          i_rc            = l_rc
          ir_errorhandler = lr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.

* If the system event was not handled we have to raise a new ok_code.
  IF l_handled = off.
    CALL METHOD set_okcode_sysev
      EXPORTING
        i_ucomm = l_ucomm.
    EXIT.
  ENDIF.

* The system event was handled.
* So at last display messages.
  display_msg_after_sysev( lr_errorhandler ).

ENDMETHOD.


METHOD handle_function_selected.

  DATA: l_ucomm          TYPE sy-ucomm,
        l_handled        TYPE ish_on_off,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_rc             TYPE ish_method_rc.

* Initial checking.
  CHECK fcode IS NOT INITIAL.

* Process the system event.
  CALL METHOD process_sysev_funcsel
    EXPORTING
      i_fcode         = fcode
    IMPORTING
      e_handled       = l_handled
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.
  IF l_rc <> 0.
    CALL METHOD set_okcode_sysev_error
      EXPORTING
        i_rc            = l_rc
        ir_errorhandler = lr_errorhandler.
    EXIT.
  ENDIF.

* Build the ucomm.
  l_ucomm = build_ucomm_toolbar( i_event = co_event_funcsel
                                 i_fcode = fcode ).
  CHECK NOT l_ucomm IS INITIAL.

* If the system event was not handled by self
* we raise event ev_system_event to allow the framework (e.g. process)
* to process the system event.
  IF l_handled = off.
    CALL METHOD raise_ev_system_event
      EXPORTING
        i_ucomm         = l_ucomm
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
    IF l_rc <> 0.
      CALL METHOD set_okcode_sysev_error
        EXPORTING
          i_rc            = l_rc
          ir_errorhandler = lr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.

* If the system event was not handled we have to raise a new ok_code.
  IF l_handled = off.
    CALL METHOD set_okcode_sysev
      EXPORTING
        i_ucomm = l_ucomm.
    EXIT.
  ENDIF.

* The system event was handled.
* So at last display messages.
  display_msg_after_sysev( lr_errorhandler ).

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_scr_toolbar.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_scr_toolbar.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~destroy.

* Initializations.
  CLEAR: e_rc.

* Destroy the toolbar object.
  CALL METHOD destroy_toolbar
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

* Call the super method.
  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen.

* This method implements special handling for ok_codes which
* have been raised by our handle-methods (eg handle_function_selected).

  DATA: l_ucomm           TYPE sy-ucomm,
        l_original_ucomm  TYPE sy-ucomm,
        l_ucomm_handled   TYPE ish_on_off.

* Process only if we have an ucomm.
  l_ucomm = c_okcode.
  CHECK NOT l_ucomm IS INITIAL.

* Handle system-event user commands.
  IF is_sysev_ucomm( l_ucomm ) = on.
*   Eliminate sysev from ucomm.
    CALL METHOD eliminate_sysev
      CHANGING
        c_ucomm = l_ucomm.
*   Raise ev_user_command.
    RAISE EVENT ev_user_command
      EXPORTING
        ir_screen = me
        i_ucomm   = l_ucomm.
  ENDIF.

* Set c_okcode.
  c_okcode = l_ucomm.

* Process only if the ucomm is supported by self.
  CHECK is_ucomm_supported( l_ucomm ) = on.

* Get the original ucomm.
  l_original_ucomm = get_original_ucomm( l_ucomm ).

* Now process the ucomm.
  CASE l_original_ucomm.
*   SystemEvent error.
    WHEN co_ucomm_sysev_error.
      CALL METHOD raise_ev_error
        EXPORTING
          ir_errorhandler = gr_sysev_errorhandler.
      l_ucomm_handled = on.
*   function_selected
    WHEN co_event_funcsel.
      CALL METHOD process_funcsel
        EXPORTING
          i_ucomm         = l_ucomm
        IMPORTING
          e_handled       = l_ucomm_handled
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
*   dropdown_clicked
    WHEN co_event_ddclicked.
      CALL METHOD process_ddclicked
        EXPORTING
          i_ucomm         = l_ucomm
        IMPORTING
          e_handled       = l_ucomm_handled
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
  ENDCASE.

* If the user command was handled clear c_okcode.
  IF l_ucomm_handled = on.
    CLEAR c_okcode.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~process_before_output.

* Initializations.
  e_rc = 0.

* Get the toolbar.
* If it does not already exist it will be fully created.
  CALL METHOD get_toolbar
    EXPORTING
      i_create        = on
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.



*  DATA: gr_model  TYPE REF TO cl_ish_toolbar_model.
*
*  DATA: lt_tb_button  TYPE ttb_button.
*
*  CHECK gr_model IS BOUND.
*  CHECK gr_toolbar IS BOUND.
*
*  lt_tb_button = gr_model->as_ttb_button( ).
*  CALL METHOD gr_toolbar->add_button_group
*    EXPORTING
*      data_table       = lt_tb_button
*    EXCEPTIONS
*      dp_error         = 1
*      cntb_error_fcode = 2
*      OTHERS           = 3.

ENDMETHOD.


METHOD if_ish_scr_toolbar~get_config_toolbar.

  DATA: lr_config_toolbar  TYPE REF TO if_ish_config_toolbar.

* Initializations.
  e_rc = 0.
  CLEAR er_config_toolbar.

* Get the toolbar config from the main config.
  CHECK NOT gr_config IS INITIAL.
  CALL METHOD gr_config->get_config_toolbar
    EXPORTING
      ir_scr_toolbar    = me
    IMPORTING
      er_config_toolbar = lr_config_toolbar
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  er_config_toolbar = lr_config_toolbar.

ENDMETHOD.


METHOD if_ish_scr_toolbar~get_fcode_from_ucomm.

  DATA: l_event           TYPE sy-ucomm,
        l_cntl_id         TYPE n_numc5,
        l_rest            TYPE string.

* Initial checking.
  CHECK i_ucomm IS NOT INITIAL.

* Process only if the ucomm is supported by self.
  CHECK is_ucomm_supported( i_ucomm ) = on.

* Split the ucomm in its parts:
*   - event
*   - control id
*   - fcode
*   - rest
  SPLIT i_ucomm
      AT '.'
    INTO l_event
         l_cntl_id
         r_fcode
         l_rest.

ENDMETHOD.


METHOD if_ish_scr_toolbar~get_fvar.

  rr_fvar = gr_fvar.

ENDMETHOD.


METHOD if_ish_scr_toolbar~get_toolbar.

  DATA: lr_container  TYPE REF TO cl_gui_container,
        lr_toolbar    TYPE REF TO cl_gui_toolbar.

* Initializations.
  CLEAR: e_rc,
         er_toolbar.

* Already loaded?
  er_toolbar = gr_toolbar.
  CHECK er_toolbar IS NOT BOUND.

* Not already loaded ->
*   -> instantiate the toolbar,
*      but only if the user specified.

  CHECK i_create = on.

* Get the container.
  CALL METHOD get_container
    IMPORTING
      er_container    = lr_container
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_container IS INITIAL.

* Create the toolbar object.
  CREATE OBJECT lr_toolbar
    EXPORTING
    parent = lr_container
    EXCEPTIONS
    cntl_install_error = 1
    cntl_error = 2
    cntb_wrong_version = 3
    OTHERS = 4.
  e_rc = sy-subrc.
  IF e_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_TOOLBAR'
        i_mv3           = 'CL_ISH_SCR_TOOLBAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Remember the toolbar object.
  gr_toolbar = lr_toolbar.

* Export.
  er_toolbar = gr_toolbar.

* Set the toolbar handlers.
  CALL METHOD set_toolbar_handlers
    EXPORTING
      i_activation    = on
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Create the buttons.
  CALL METHOD create_buttons
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_toolbar~set_fvar.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK ir_fvar <> gr_fvar.

* Set gr_fvar.
  gr_fvar = ir_fvar.

* Create the buttons.
  CALL METHOD create_buttons
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD initialize_field_values.

* Most toolbar screens do not have any field values.

  CLEAR: e_rc.

ENDMETHOD.


METHOD process_ddclicked.

  DATA: l_fcode             TYPE ui_func,
        lr_config_toolbar   TYPE REF TO if_ish_config_toolbar.

* Initializations.
  e_rc      = 0.
  e_handled = off.

* Initial checking.
  CHECK NOT i_ucomm IS INITIAL.

* Get the fcode.
  l_fcode = get_fcode_from_ucomm( i_ucomm ).

* Let the configuration handle the fcode.
  CALL METHOD get_config_toolbar
    IMPORTING
      er_config_toolbar = lr_config_toolbar
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT lr_config_toolbar IS INITIAL.
    CALL METHOD lr_config_toolbar->process_ddclicked
      EXPORTING
        ir_scr_toolbar  = me
        i_fcode         = l_fcode
      IMPORTING
        e_handled       = e_handled
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc            = 0.
    CHECK e_handled = off.
  ENDIF.

* Do own fcode processing.
  CALL METHOD process_ddclicked_internal
    EXPORTING
      i_fcode         = l_fcode
    IMPORTING
      e_handled       = e_handled
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD process_ddclicked_internal.

* Redefine this method to do own ddclicked processing.

  e_handled = off.
  e_rc      = 0.

ENDMETHOD.


METHOD process_funcsel.

  DATA: l_fcode             TYPE ui_func,
        lr_config_toolbar   TYPE REF TO if_ish_config_toolbar.

* Initializations.
  e_rc      = 0.
  e_handled = off.

* Initial checking.
  CHECK NOT i_ucomm IS INITIAL.

* Get the fcode.
  l_fcode = get_fcode_from_ucomm( i_ucomm ).

* Let the configuration handle the fcode.
  CALL METHOD get_config_toolbar
    IMPORTING
      er_config_toolbar = lr_config_toolbar
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT lr_config_toolbar IS INITIAL.
    CALL METHOD lr_config_toolbar->process_funcsel
      EXPORTING
        ir_scr_toolbar  = me
        i_fcode         = l_fcode
      IMPORTING
        e_handled       = e_handled
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc            = 0.
    CHECK e_handled = off.
  ENDIF.

* Do own fcode processing.
  CALL METHOD process_funcsel_internal
    EXPORTING
      i_fcode         = l_fcode
    IMPORTING
      e_handled       = e_handled
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD process_funcsel_internal.

* Redefine this method to do own funcsel processing.

  e_handled = off.
  e_rc      = 0.

ENDMETHOD.


METHOD process_sysev_ddclicked.

  DATA: lr_config_toolbar   TYPE REF TO if_ish_config_toolbar,
        l_process_as_ucomm  TYPE ish_on_off.

* Initializations.
  e_rc      = 0.
  e_handled = off.

* Initial checking.
  CHECK NOT i_fcode IS INITIAL.

* Let the configuration handle the fcode.
  DO 1 TIMES.
    CHECK gr_config IS BOUND.
*   Get the toolbar config.
    CALL METHOD gr_config->get_config_toolbar
      IMPORTING
        er_config_toolbar = lr_config_toolbar
        e_rc              = e_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK lr_config_toolbar IS BOUND.
*   Process the fcode.
    CALL METHOD lr_config_toolbar->process_sysev_ddclicked
      EXPORTING
        ir_scr_toolbar     = me
        i_fcode            = i_fcode
      IMPORTING
        e_process_as_ucomm = l_process_as_ucomm
        e_handled          = e_handled
        e_rc               = e_rc
      CHANGING
        cr_errorhandler    = cr_errorhandler.
  ENDDO.
  CHECK e_rc               = 0.
  CHECK e_handled          = off.
  CHECK l_process_as_ucomm = off.

* Now do own fcode processing.
  CALL METHOD process_sysev_ddclicked_intern
    EXPORTING
      i_fcode         = i_fcode
    IMPORTING
      e_handled       = e_handled
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD process_sysev_ddclicked_intern.

* The base class handles function variants.

  DATA: lr_button    TYPE REF TO cl_ish_fvar_button,
        lt_function  TYPE ish_t_fvar_function_obj,
        lr_function  TYPE REF TO cl_ish_fvar_function,
        lr_ctmenu    TYPE REF TO cl_ctmenu,
        l_fcode      TYPE ui_func,
        l_text40     TYPE gui_text.

* Initializations.
  e_handled = off.
  e_rc      = 0.

* Initial checking.
  CHECK gr_toolbar IS BOUND.
  CHECK gr_fvar IS BOUND.

* Get the functions for the fcode.
  lr_button = gr_fvar->get_button_by_fcode( i_fcode ).
  CHECK lr_button IS BOUND.
  lt_function = lr_button->get_all_functions( ).
  CHECK lt_function IS NOT INITIAL.

* Build a context menu containing the functions.
  CREATE OBJECT lr_ctmenu.
  LOOP AT lt_function INTO lr_function.
    CHECK lr_function IS BOUND.
    l_fcode = lr_function->get_fcode( ).
    l_text40 = lr_function->get_text40( ).
    CALL METHOD lr_ctmenu->add_function
      EXPORTING
        fcode = l_fcode
        text  = l_text40.
  ENDLOOP.

* Set the context menu of the toolbar button.
  CALL METHOD gr_toolbar->set_static_ctxmenu
    EXPORTING
      fcode                = i_fcode
      ctxmenu              = lr_ctmenu
    EXCEPTIONS
      ctmenu_error         = 1
      cntl_error           = 2
      cntb_error_parameter = 3
      OTHERS               = 4.
  e_rc = sy-subrc.
  IF e_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_TOOLBAR'
        i_mv3           = 'CL_ISH_SCR_TOOLBAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD process_sysev_funcsel.

  DATA: lr_config_toolbar   TYPE REF TO if_ish_config_toolbar,
        l_process_as_ucomm  TYPE ish_on_off.

* Initializations.
  e_rc      = 0.
  e_handled = off.

* Initial checking.
  CHECK NOT i_fcode IS INITIAL.

* Let the configuration handle the fcode.
  DO 1 TIMES.
    CHECK gr_config IS BOUND.
*   Get the toolbar config.
    CALL METHOD gr_config->get_config_toolbar
      IMPORTING
        er_config_toolbar = lr_config_toolbar
        e_rc              = e_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK lr_config_toolbar IS BOUND.
*   Process the fcode.
    CALL METHOD lr_config_toolbar->process_sysev_funcsel
      EXPORTING
        ir_scr_toolbar     = me
        i_fcode            = i_fcode
      IMPORTING
        e_process_as_ucomm = l_process_as_ucomm
        e_handled          = e_handled
        e_rc               = e_rc
      CHANGING
        cr_errorhandler    = cr_errorhandler.
  ENDDO.
  CHECK e_rc               = 0.
  CHECK e_handled          = off.
  CHECK l_process_as_ucomm = off.

* Now do own user_command processing.
  CALL METHOD process_sysev_funcsel_internal
    EXPORTING
      i_fcode         = i_fcode
    IMPORTING
      e_handled       = e_handled
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD process_sysev_funcsel_internal.

* Redefine this method to process the function_selected system event.

  e_handled = off.
  e_rc      = 0.

ENDMETHOD.


METHOD set_toolbar_handlers.

* The default implementation sets the following handlers.
* Redefine this method in derived classes (and call the super method)
* if you have any specialities.

  DATA: lt_event      TYPE cntl_simple_events,
        ls_event      LIKE LINE OF lt_event.

  FIELD-SYMBOLS: <ls_event>  LIKE LINE OF lt_event.

* Initializations.
  CLEAR: e_rc.

* Process only if we have a toolbar object.
  CHECK gr_toolbar IS BOUND.

* dropdown_clicked.
  SET HANDLER handle_dropdown_clicked FOR gr_toolbar ACTIVATION i_activation.

* function_selected.
  SET HANDLER handle_function_selected FOR gr_toolbar ACTIVATION i_activation.

* Register the events, but only on activation.
  CHECK i_activation = on.

* Get the registered events.
  CALL METHOD gr_toolbar->get_registered_events
    IMPORTING
      events     = lt_event
    EXCEPTIONS
      cntl_error = 1
      OTHERS     = 2.
  e_rc = sy-subrc.
  IF e_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_TOOLBAR'
        i_mv3           = 'CL_ISH_SCR_TOOLBAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* dropdown_clicked.
  READ TABLE lt_event with key eventid = cl_gui_toolbar=>m_id_dropdown_clicked ASSIGNING <ls_event>.
  IF sy-subrc = 0.
    <ls_event>-appl_event = off.
  ELSE.
    CLEAR: ls_event.
    ls_event-eventid    = cl_gui_toolbar=>m_id_dropdown_clicked.
    ls_event-appl_event = off.
    APPEND ls_event TO lt_event.
  ENDIF.

* function_selected
  READ TABLE lt_event with key eventid = cl_gui_toolbar=>m_id_function_selected ASSIGNING <ls_event>.
  IF sy-subrc = 0.
    <ls_event>-appl_event = off.
  ELSE.
    CLEAR: ls_event.
    ls_event-eventid    = cl_gui_toolbar=>m_id_function_selected.
    ls_event-appl_event = off.
    APPEND ls_event TO lt_event.
  ENDIF.

* Set registered events.
  CALL METHOD gr_toolbar->set_registered_events
    EXPORTING
      events                    = lt_event
    EXCEPTIONS
      cntl_error                = 1
      cntl_system_error         = 2
      illegal_event_combination = 3
      OTHERS                    = 4.
  e_rc = sy-subrc.
  IF e_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_TOOLBAR'
        i_mv3           = 'CL_ISH_SCR_TOOLBAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

ENDMETHOD.
ENDCLASS.
