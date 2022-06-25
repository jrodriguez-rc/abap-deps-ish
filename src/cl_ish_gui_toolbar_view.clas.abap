class CL_ISH_GUI_TOOLBAR_VIEW definition
  public
  inheriting from CL_ISH_GUI_CONTROL_VIEW
  create protected .

public section.
*"* public components of class CL_ISH_GUI_TOOLBAR_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_TOOLBAR_VIEW .

  aliases GET_TOOLBAR
    for IF_ISH_GUI_TOOLBAR_VIEW~GET_TOOLBAR .
  aliases GET_TOOLBAR_LAYOUT
    for IF_ISH_GUI_TOOLBAR_VIEW~GET_TOOLBAR_LAYOUT .

  constants CO_CMDRESULT_NOPROC type I value '0'. "#EC NOTEXT
  constants CO_CMDRESULT_OKCODE type I value '2'. "#EC NOTEXT
  constants CO_CMDRESULT_PROCESSED type I value '1'. "#EC NOTEXT

  class-methods CREATE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_TOOLBAR_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_TOOLBAR_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !IR_FVAR type ref to CL_ISH_FVAR optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GUI_TOOLBAR_VIEW
*"* do not include other source files here!!!

  data GR_FVAR type ref to CL_ISH_FVAR .

  methods ON_DROPDOWN_CLICKED
    for event DROPDOWN_CLICKED of CL_GUI_TOOLBAR
    importing
      !FCODE
      !POSX
      !POSY
      !SENDER .
  methods ON_FUNCTION_SELECTED
    for event FUNCTION_SELECTED of CL_GUI_TOOLBAR
    importing
      !FCODE
      !SENDER .
  methods _BUILD_BUTTONS
    importing
      !IR_TOOLBAR type ref to CL_GUI_TOOLBAR optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods _INIT_TOOLBAR_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_CONTROL_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !IR_FVAR type ref to CL_ISH_FVAR optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods _OWN_CMD
    importing
      !IR_TOOLBAR_EVENT type ref to CL_ISH_GUI_TOOLBAR_EVENT
      !IR_ORIG_REQUEST type ref to CL_ISH_GUI_REQUEST
    returning
      value(R_CMDRESULT) type I
    raising
      CX_ISH_STATIC_HANDLER .

  methods _CREATE_CONTROL
    redefinition .
  methods _DESTROY
    redefinition .
  methods _FIRST_DISPLAY
    redefinition .
  methods _PROCESS_COMMAND_REQUEST
    redefinition .
  methods _PROCESS_EVENT_REQUEST
    redefinition .
  methods _REFRESH_DISPLAY
    redefinition .
  methods _SET_VCODE
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_TOOLBAR_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_TOOLBAR_VIEW IMPLEMENTATION.


METHOD create.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD if_ish_gui_toolbar_view~get_toolbar.

  TRY.
      rr_toolbar ?= get_control( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_toolbar_view~get_toolbar_layout.

  TRY.
      rr_toolbar_layout ?= get_layout( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD initialize.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'INITIALIZE'
          i_mv3        = 'CL_ISH_GUI_TOOLBAR_VIEW' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      _init_toolbar_view(
          ir_controller     = ir_controller
          ir_parent_view    = ir_parent_view
          ir_layout         = ir_layout
          i_vcode           = i_vcode
          ir_fvar           = ir_fvar ).
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD on_dropdown_clicked.

  on_function_selected( fcode  = fcode
                        sender = sender ).

ENDMETHOD.


METHOD on_function_selected.

  DATA lr_request         TYPE REF TO cl_ish_gui_toolbar_event.
  DATA lr_response        TYPE REF TO cl_ish_gui_response.

  lr_request = cl_ish_gui_toolbar_event=>create( ir_sender = me
                                                 i_fcode   = fcode ).
* Propagate the request.
  lr_response = _propagate_request( ir_request = lr_request ).

* After request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD _build_buttons.

  DATA lr_toolbar                 TYPE REF TO cl_gui_toolbar.
  DATA lr_layout                  TYPE REF TO cl_ish_gui_toolbar_layout.
  DATA lr_fvar                    TYPE REF TO cl_ish_fvar.

* Get the toolbar.
  IF ir_toolbar IS BOUND.
    lr_toolbar = ir_toolbar.
  ELSE.
    lr_toolbar = get_toolbar( ).
  ENDIF.
  CHECK lr_toolbar IS BOUND.

* Delete all buttons.
  CALL METHOD lr_toolbar->delete_all_buttons
    EXCEPTIONS
      OTHERS = 1.

* Get the fvar.
  TRY.
      lr_layout ?= get_layout( ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_layout.
  ENDTRY.
  CHECK lr_layout IS BOUND.
  lr_fvar = lr_layout->get_fvar( ).
  CHECK lr_fvar IS BOUND.

* Let the fvar build the toolbar.
  lr_fvar->add_to_toolbar( ir_toolbar = lr_toolbar ).

ENDMETHOD.


METHOD _create_control.

  DATA:
    lr_toolbar                TYPE REF TO cl_gui_toolbar,
    lr_parent_container_view  TYPE REF TO if_ish_gui_container_view,
    lr_parent_container       TYPE REF TO cl_gui_container,
    lt_event                  TYPE cntl_simple_events,
    ls_event                  LIKE LINE OF lt_event,
    lx_root                   TYPE REF TO cx_root.

  FIELD-SYMBOLS:
    <ls_event>                LIKE LINE OF lt_event.

* Get the parent container.
  TRY.
      lr_parent_container_view ?= get_parent_view( ).
      lr_parent_container = lr_parent_container_view->get_container_for_child_view( me ).
    CATCH cx_root INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

* Create the toolbar.
  CREATE OBJECT lr_toolbar
    EXPORTING
      parent             = lr_parent_container
    EXCEPTIONS
      cntl_install_error = 1
      cntl_error         = 2
      cntb_wrong_version = 3
      OTHERS             = 4.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static_by_syst( i_typ     = 'E'
                                                ir_object = me ).
  ENDIF.

* Register self for the toolbar events.
  SET HANDLER on_function_selected FOR lr_toolbar ACTIVATION abap_true.
  SET HANDLER on_dropdown_clicked  FOR lr_toolbar ACTIVATION abap_true.

* Get the registered events.
  CALL METHOD lr_toolbar->get_registered_events
    IMPORTING
      events     = lt_event
    EXCEPTIONS
      cntl_error = 1
      OTHERS     = 2.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static_by_syst( i_typ     = 'E'
                                                ir_object = me ).
  ENDIF.

* function_selected
  READ TABLE lt_event WITH KEY eventid = cl_gui_toolbar=>m_id_function_selected ASSIGNING <ls_event>.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR: ls_event.
    ls_event-eventid    = cl_gui_toolbar=>m_id_function_selected.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.
* dropdown_clicked
  READ TABLE lt_event WITH KEY eventid = cl_gui_toolbar=>m_id_dropdown_clicked ASSIGNING <ls_event>.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR: ls_event.
    ls_event-eventid    = cl_gui_toolbar=>m_id_dropdown_clicked.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.

* Set registered events.
  CALL METHOD lr_toolbar->set_registered_events
    EXPORTING
      events                    = lt_event
    EXCEPTIONS
      cntl_error                = 1
      cntl_system_error         = 2
      illegal_event_combination = 3
      OTHERS                    = 4.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static_by_syst( i_typ     = 'E'
                                                ir_object = me ).
  ENDIF.

* Build the buttons
  _build_buttons( ir_toolbar = lr_toolbar ).

* Export.
  rr_control = lr_toolbar.

ENDMETHOD.


METHOD _destroy.

  super->_destroy( ).

  CLEAR gr_fvar.

ENDMETHOD.


METHOD _first_display.

* Just create the toolbar.
  _create_control_on_demand( ).

ENDMETHOD.


METHOD _init_toolbar_view.

  _init_control_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode ).

  gr_fvar = ir_fvar.

ENDMETHOD.


METHOD _own_cmd.

  CASE ir_toolbar_event->get_fcode( ).

*   No standard functions.

    WHEN OTHERS.
      r_cmdresult = co_cmdresult_noproc.
      RETURN.

  ENDCASE.

ENDMETHOD.


METHOD _process_command_request.

  DATA lr_okcode_request        TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_toolbar_event         TYPE REF TO cl_ish_gui_toolbar_event.
  DATA lx_root                  TYPE REF TO cx_root.

* The command_request has to be specified.
  CHECK ir_command_request IS BOUND.

* The command_request has to be created by an okcode_request.
  lr_okcode_request = ir_command_request->get_okcode_request( ).
  CHECK lr_okcode_request IS BOUND.

* The okcode_request has to be created by a toolbar_event.
  TRY.
      lr_toolbar_event ?= lr_okcode_request->get_control_event( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_toolbar_event IS BOUND.

* The toolbar_event has to belong to self.
  CHECK lr_toolbar_event->get_sender( ) = me.

* Process the toolbar_event.
  TRY.

      CHECK _own_cmd(
          ir_toolbar_event  = lr_toolbar_event
          ir_orig_request   = ir_command_request ) = co_cmdresult_processed.

      rr_response = cl_ish_gui_response=>create( ir_request   = ir_command_request
                                                 ir_processor = me ).

*   On errors we have to propagate the exception.
    CATCH cx_ish_static_handler INTO lx_root.

      _propagate_exception( lx_root ).
      rr_response = cl_ish_gui_response=>create( ir_request   = ir_command_request
                                                 ir_processor = me ).
      RETURN.

  ENDTRY.

ENDMETHOD.


METHOD _process_event_request.

  DATA lr_toolbar_event         TYPE REF TO cl_ish_gui_toolbar_event.
  DATA lr_tmp_messages          TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_root                  TYPE REF TO cx_root.
  DATA lr_okcode_request        TYPE REF TO cl_ish_gui_okcode_request.

* The event request has to be specified.
  CHECK ir_event_request IS BOUND.

* The event request has to belong to self.
  CHECK ir_event_request->get_sender( ) = me.

* The event request has to be a toolbar event.
  TRY.
      lr_toolbar_event ?= ir_event_request.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Process the toolbar event.
  TRY.

      CASE _own_cmd( ir_toolbar_event   = lr_toolbar_event
                     ir_orig_request = ir_event_request ).
        WHEN co_cmdresult_noproc.
*         We havn't processed the event
          RETURN.
        WHEN co_cmdresult_processed.
*         We have processed the event
          rr_response = cl_ish_gui_response=>create( ir_request   = ir_event_request
                                                     ir_processor = me ).
        WHEN co_cmdresult_okcode.
*         Create an okcode request for our event and propagate it
          lr_okcode_request = cl_ish_gui_okcode_request=>create_by_control_event(
                                              ir_sender         = me
                                              ir_processor      = me
                                              ir_control_event  = lr_toolbar_event ).

          _propagate_request( lr_okcode_request ).

          rr_response = cl_ish_gui_response=>create( ir_request   = ir_event_request
                                                     ir_processor = me ).
      ENDCASE.

*   On errors we have to display the messages.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( lx_root ).
      rr_response = cl_ish_gui_response=>create( ir_request   = ir_event_request
                                                 ir_processor = me ).

  ENDTRY.

ENDMETHOD.


METHOD _refresh_display.

* Not needed.

ENDMETHOD.


METHOD _set_vcode.

* On vcode changes we have to rebuild the buttons.

  r_changed = super->_set_vcode( i_vcode = i_vcode ).
  CHECK r_changed = abap_true.

  _build_buttons( ).

ENDMETHOD.
ENDCLASS.
