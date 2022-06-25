class CL_ISH_GUI_CONTROLLER definition
  public
  inheriting from CL_ISH_GUI_ELEMENT
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_CONTROLLER
*"* do not include other source files here!!!
  type-pools VRM .

  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_GUI_CONTROLLER .
  interfaces IF_ISH_GUI_REQUEST_PROCESSOR .
  interfaces IF_ISH_GUI_REQUEST_SENDER .

  aliases DESTROY
    for IF_ISH_GUI_CONTROLLER~DESTROY .
  aliases GET_APPLICATION
    for IF_ISH_GUI_CONTROLLER~GET_APPLICATION .
  aliases GET_CHILD_CONTROLLERS
    for IF_ISH_GUI_CONTROLLER~GET_CHILD_CONTROLLERS .
  aliases GET_CHILD_CONTROLLER_BY_ID
    for IF_ISH_GUI_CONTROLLER~GET_CHILD_CONTROLLER_BY_ID .
  aliases GET_CHILD_CONTROLLER_BY_NAME
    for IF_ISH_GUI_CONTROLLER~GET_CHILD_CONTROLLER_BY_NAME .
  aliases GET_MAIN_CONTROLLER
    for IF_ISH_GUI_CONTROLLER~GET_MAIN_CONTROLLER .
  aliases GET_MODEL
    for IF_ISH_GUI_CONTROLLER~GET_MODEL .
  aliases GET_PARENT_CONTROLLER
    for IF_ISH_GUI_CONTROLLER~GET_PARENT_CONTROLLER .
  aliases GET_VCODE
    for IF_ISH_GUI_CONTROLLER~GET_VCODE .
  aliases GET_VIEW
    for IF_ISH_GUI_CONTROLLER~GET_VIEW .
  aliases IS_DESTROYED
    for IF_ISH_GUI_CONTROLLER~IS_DESTROYED .
  aliases IS_INITIALIZED
    for IF_ISH_GUI_CONTROLLER~IS_INITIALIZED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_GUI_CONTROLLER~IS_IN_DESTROY_MODE .
  aliases IS_IN_INITIALIZATION_MODE
    for IF_ISH_GUI_CONTROLLER~IS_IN_INITIALIZATION_MODE .
  aliases PROCESS_REQUEST
    for IF_ISH_GUI_CONTROLLER~PROCESS_REQUEST .
  aliases REGISTER_CHILD_CONTROLLER
    for IF_ISH_GUI_CONTROLLER~REGISTER_CHILD_CONTROLLER .
  aliases SET_VCODE
    for IF_ISH_GUI_CONTROLLER~SET_VCODE .
  aliases EV_AFTER_DESTROY
    for IF_ISH_GUI_CONTROLLER~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_GUI_CONTROLLER~EV_BEFORE_DESTROY .

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    preferred parameter I_ELEMENT_NAME .
protected section.
*"* protected components of class CL_ISH_GUI_CONTROLLER
*"* do not include other source files here!!!

  data GR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE .
  data GR_MODEL type ref to IF_ISH_GUI_MODEL .
  data GR_PARENT_CTR type ref to IF_ISH_GUI_CONTROLLER .
  data GR_VIEW type ref to IF_ISH_GUI_VIEW .
  data GT_CHILD_CTR type ISH_T_GUI_CTRNAME_HASH .
  type-pools ABAP .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .
  data G_INITIALIZATION_MODE type ABAP_BOOL .
  data G_INITIALIZED type ABAP_BOOL .
  data G_VCODE type TNDYM-VCODE .

  methods ON_CHILDCTR_AFTER_DESTROY
    for event EV_AFTER_DESTROY of IF_ISH_GUI_CONTROLLER
    importing
      !SENDER .
  methods ON_CHILDCTR_BEFORE_DESTROY
    for event EV_BEFORE_DESTROY of IF_ISH_GUI_CONTROLLER
    importing
      !SENDER .
  methods _ADD_CHILD_CONTROLLER
    importing
      !IR_CHILD_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DESTROY .
  methods _GET_OKCODEREQ_BY_CONTROLEV
    importing
      !IR_CONTROL_EVENT type ref to CL_ISH_GUI_CONTROL_EVENT
    returning
      value(RR_OKCODE_REQUEST) type ref to CL_ISH_GUI_OKCODE_REQUEST .
  interface IF_ISH_GUI_VIEW load .
  methods _INIT_CTR
    importing
      !IR_PARENT_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER optional
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !IR_VIEW type ref to IF_ISH_GUI_VIEW optional
      !I_VCODE type TNDYM-VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _PROCESS_COMMAND_REQUEST
    importing
      !IR_COMMAND_REQUEST type ref to CL_ISH_GUI_COMMAND_REQUEST
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROCESS_EVENT_REQUEST
    importing
      !IR_EVENT_REQUEST type ref to CL_ISH_GUI_EVENT_REQUEST
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROPAGATE_EXCEPTION
    importing
      !IR_EXCEPTION type ref to CX_ROOT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROPAGATE_MESSAGES
    importing
      !IR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROPAGATE_REQUEST
    importing
      !IR_REQUEST type ref to CL_ISH_GUI_REQUEST
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _REMOVE_CHILD_CONTROLLER
    importing
      !IR_CHILD_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
    returning
      value(R_REMOVED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SET_VCODE
    importing
      !I_VCODE type TNDYM-VCODE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_GUI_CONTROLLER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_CONTROLLER IMPLEMENTATION.


METHOD constructor.

  super->constructor( i_element_name = i_element_name ).

  gr_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD if_ish_destroyable~destroy.

* Process only if we are not already destroyed or in destroy mode.
  CHECK is_destroyed( )       = abap_false.
  CHECK is_in_destroy_mode( ) = abap_false.

* Callback.
  IF gr_cb_destroyable IS BOUND.
    CHECK gr_cb_destroyable->cb_destroy( ir_destroyable = me ) = abap_true.
  ENDIF.

* Raise event before_destroy.
  RAISE EVENT ev_before_destroy.

* Set self in destroy mode.
  g_destroy_mode = abap_true.

* Destroy.
  _destroy( ).

* We are destroyed.
  g_destroy_mode = abap_false.
  g_destroyed    = abap_true.

* Export.
  r_destroyed = abap_true.

* Raise event after_destroy.
  RAISE EVENT ev_after_destroy.

ENDMETHOD.


METHOD if_ish_destroyable~is_destroyed.

  r_destroyed = g_destroyed.

ENDMETHOD.


METHOD if_ish_destroyable~is_in_destroy_mode.

  r_destroy_mode = g_destroy_mode.

ENDMETHOD.


METHOD if_ish_gui_controller~get_application.

  DATA:
    lr_parent_controller          TYPE REF TO if_ish_gui_controller.

  lr_parent_controller = get_parent_controller( ).
  CHECK lr_parent_controller IS BOUND.

  rr_application = lr_parent_controller->get_application( ).

ENDMETHOD.


METHOD if_ish_gui_controller~get_child_controllers.

  DATA:
    ls_tmp_ctr      TYPE rn1_gui_ctrid_hash,
    lt_tmp_ctr      TYPE ish_t_gui_ctrid_hash.

  FIELD-SYMBOLS:
    <ls_child_ctr>  LIKE LINE OF gt_child_ctr.

  LOOP AT gt_child_ctr ASSIGNING <ls_child_ctr>.

    ls_tmp_ctr-controller_id = <ls_child_ctr>-r_controller->get_element_id( ).
    ls_tmp_ctr-r_controller  = <ls_child_ctr>-r_controller.
    INSERT ls_tmp_ctr INTO TABLE rt_child_controller.

    IF i_with_subchildren = abap_true.
      lt_tmp_ctr = <ls_child_ctr>-r_controller->get_child_controllers( i_with_subchildren = abap_true ).
      INSERT LINES OF lt_tmp_ctr INTO TABLE rt_child_controller.
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_controller~get_child_controller_by_id.

  FIELD-SYMBOLS:
    <ls_child_ctr>  LIKE LINE OF gt_child_ctr.

  LOOP AT gt_child_ctr ASSIGNING <ls_child_ctr>.

    IF <ls_child_ctr>-r_controller->get_element_id( ) = i_controller_id.
      rr_child_controller = <ls_child_ctr>-r_controller.
      EXIT.
    ENDIF.

    IF i_with_subchildren = abap_true.
      rr_child_controller = <ls_child_ctr>-r_controller->get_child_controller_by_id( i_controller_id    = i_controller_id
                                                                                     i_with_subchildren = abap_true ).
      IF rr_child_controller IS BOUND.
        EXIT.
      ENDIF.
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_controller~get_child_controller_by_name.

  FIELD-SYMBOLS:
    <ls_child_ctr>  LIKE LINE OF gt_child_ctr.

  READ TABLE gt_child_ctr
    WITH TABLE KEY controller_name = i_controller_name
    ASSIGNING <ls_child_ctr>.
  CHECK sy-subrc = 0.

  rr_child_controller = <ls_child_ctr>-r_controller.

ENDMETHOD.


METHOD if_ish_gui_controller~get_main_controller.

  DATA:
    lr_parent_controller          TYPE REF TO if_ish_gui_controller.

  WHILE rr_main_controller IS NOT BOUND.
    lr_parent_controller = get_parent_controller( ).
    IF lr_parent_controller IS NOT BOUND.
      EXIT.
    ENDIF.
    rr_main_controller = lr_parent_controller->get_main_controller( ).
  ENDWHILE.

ENDMETHOD.


METHOD if_ish_gui_controller~get_model.

  rr_model = gr_model.

ENDMETHOD.


METHOD if_ish_gui_controller~get_parent_controller.

  rr_parent_controller = gr_parent_ctr.

ENDMETHOD.


METHOD if_ish_gui_controller~get_vcode.

  r_vcode = g_vcode.

ENDMETHOD.


METHOD if_ish_gui_controller~get_view.

  rr_view = gr_view.

ENDMETHOD.


METHOD if_ish_gui_controller~is_initialized.

  r_initialized = g_initialized.

ENDMETHOD.


METHOD if_ish_gui_controller~is_in_initialization_mode.

  r_initialization_mode = g_initialization_mode.

ENDMETHOD.


METHOD if_ish_gui_controller~register_child_controller.

  _add_child_controller( ir_child_controller = ir_child_controller ).

ENDMETHOD.


METHOD if_ish_gui_controller~set_vcode.

  DATA:
    lt_child_ctr       TYPE ish_t_gui_ctrid_hash,
    lr_view            TYPE REF TO if_ish_gui_view,
    lr_errorhandler    TYPE REF TO cl_ishmed_errorhandling,
    lx_root            TYPE REF TO cx_root.

  FIELD-SYMBOLS:
    <ls_child_ctr>    TYPE rn1_gui_ctrid_hash.

* Process only if self is valid.
  IF is_initialized( )     = abap_false OR
     is_destroyed( )       = abap_true  OR
     is_in_destroy_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'SET_VCODE'
        i_mv3 = 'CL_ISH_GUI_CONTROLLER' ).
  ENDIF.

* Set own vcode.
  r_changed = _set_vcode( i_vcode = i_vcode ).

* Set the vcode of the child controllers.
  IF i_with_child_controllers = abap_true.
    lt_child_ctr = get_child_controllers( i_with_subchildren = abap_false ).
    LOOP AT lt_child_ctr ASSIGNING <ls_child_ctr>.
      CHECK <ls_child_ctr>-r_controller IS BOUND.
      TRY.
          <ls_child_ctr>-r_controller->set_vcode( i_vcode                  = i_vcode
                                                  i_with_child_controllers = abap_true ).
        CATCH cx_ish_static_handler INTO lx_root.
          CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
            EXPORTING
              i_exceptions    = lx_root
            CHANGING
              cr_errorhandler = lr_errorhandler.
          CONTINUE.
      ENDTRY.
    ENDLOOP.
  ENDIF.

* Set the vcode of the view.
  lr_view = get_view( ).
  IF lr_view IS BOUND.
    TRY.
        lr_view->set_vcode( i_vcode            = i_vcode
                            i_with_child_views = i_with_child_controllers ).
      CATCH cx_ish_static_handler INTO lx_root.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
          EXPORTING
            i_exceptions    = lx_root
          CHANGING
            cr_errorhandler = lr_errorhandler.
    ENDTRY.
  ENDIF.

* Errorhandling
  IF lr_errorhandler IS BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_request_processor~after_request_processing.

  DATA lr_event_request               TYPE REF TO cl_ish_gui_event_request.
  DATA lr_command_request             TYPE REF TO cl_ish_gui_command_request.
  DATA lr_okcode_request              TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_processor                   TYPE REF TO if_ish_gui_request_processor.
  DATA lt_child_ctr                   TYPE ish_t_gui_ctrid_hash.

  FIELD-SYMBOLS <ls_child_ctr>        TYPE rn1_gui_ctrid_hash.

* Event requests and okcode requests are propagated to the parent controller.
* Command requests are propagated to the child controllers.
  TRY.
      lr_event_request ?= ir_request.
      lr_processor = get_parent_controller( ).
      IF lr_processor IS NOT BOUND.
        lr_processor = get_application( ).
      ENDIF.
      CHECK lr_processor IS BOUND.
      lr_processor->after_request_processing(
          ir_request  = ir_request
          ir_response = ir_response ).
    CATCH cx_sy_move_cast_error.
      TRY.
          lr_okcode_request ?= ir_request.
          lr_processor = get_parent_controller( ).
          IF lr_processor IS NOT BOUND.
            lr_processor = get_application( ).
          ENDIF.
          CHECK lr_processor IS BOUND.
          lr_processor->after_request_processing(
              ir_request  = ir_request
              ir_response = ir_response ).
        CATCH cx_sy_move_cast_error.
          TRY.
              lr_command_request ?= ir_request.
              lt_child_ctr = get_child_controllers( ).
              LOOP AT lt_child_ctr ASSIGNING <ls_child_ctr>.
                CHECK <ls_child_ctr>-r_controller IS BOUND.
                <ls_child_ctr>-r_controller->if_ish_gui_request_processor~after_request_processing(
                    ir_request  = ir_request
                    ir_response = ir_response ).
              ENDLOOP.
            CATCH cx_sy_move_cast_error.                "#EC NO_HANDLER
          ENDTRY.
      ENDTRY.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_request_processor~process_request.

  DATA lr_event_request       TYPE REF TO cl_ish_gui_event_request.
  DATA lr_command_request     TYPE REF TO cl_ish_gui_command_request.
  DATA lr_okcode_request      TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_view                TYPE REF TO if_ish_gui_view.

* The request has to be specified.
  CHECK ir_request IS BOUND.

* Processing depends on the type of the request.
  TRY.
*     Event request?
      lr_event_request ?= ir_request.
*     Event requests first have to be propagated.
      rr_response = _propagate_request( ir_request = ir_request ).
*     If the event request was not processed we have to process it ourself.
      CHECK rr_response IS NOT BOUND.
      rr_response = _process_event_request( ir_event_request = lr_event_request ).
*     If we did not process the request we let the view process it.
      CHECK rr_response IS NOT BOUND.
      lr_view = get_view( ).
      IF lr_view IS BOUND.
        rr_response = lr_view->process_request( ir_request ).
      ENDIF.
    CATCH cx_sy_move_cast_error.
      TRY.
*         Command request?
          lr_command_request ?= ir_request.
*         First we process the command request ourself.
          rr_response = _process_command_request( ir_command_request = lr_command_request ).
*         If we did not process the command request we have to propagate it.
          CHECK rr_response IS NOT BOUND.
          rr_response = _propagate_request( ir_request = ir_request ).
*         If we did not process the request we let the view process it.
          CHECK rr_response IS NOT BOUND.
          lr_view = get_view( ).
          IF lr_view IS BOUND.
            rr_response = lr_view->process_request( ir_request ).
          ENDIF.
        CATCH cx_sy_move_cast_error.
          TRY.
*             OKCODE request?
              lr_okcode_request ?= ir_request.
*             OKCODE requests are just propagated.
              rr_response = _propagate_request( ir_request = ir_request ).
            CATCH cx_sy_move_cast_error.
          ENDTRY.
      ENDTRY.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_request_sender~get_okcodereq_by_controlev.

  DATA lr_application           TYPE REF TO if_ish_gui_application.

* First propagate to the parent controller or application.
  IF gr_parent_ctr IS BOUND.
    rr_okcode_request = gr_parent_ctr->if_ish_gui_request_sender~get_okcodereq_by_controlev( ir_control_event ).
  ELSE.
    lr_application = get_application( ).
    IF lr_application IS BOUND.
      rr_okcode_request = lr_application->if_ish_gui_request_sender~get_okcodereq_by_controlev( ir_control_event ).
    ENDIF.
  ENDIF.
  CHECK rr_okcode_request IS NOT BOUND.

* Now do own processing.
  rr_okcode_request = _get_okcodereq_by_controlev( ir_control_event ).

ENDMETHOD.


METHOD on_childctr_after_destroy.

  DATA:
    lr_child_ctr            TYPE REF TO if_ish_gui_controller,
    lx_root                 TYPE REF TO cx_root.

* Check the sender.
  CHECK sender IS BOUND.
  TRY.
      lr_child_ctr ?= sender.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Remove the child controller.
  TRY.
      _remove_child_controller( ir_child_controller = sender ).
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( ir_exception = lx_root ).
  ENDTRY.

ENDMETHOD.


method ON_CHILDCTR_BEFORE_DESTROY.
endmethod.


METHOD _add_child_controller.

  DATA:
    ls_child_ctr    LIKE LINE OF gt_child_ctr.

* The child controller has to be given.
* The parent controller of the given child controller has to be self.
  IF ir_child_controller IS NOT BOUND OR
     ir_child_controller->get_parent_controller( ) <> me.
    cl_ish_utl_exception=>raise_static(
       i_typ        = 'E'
       i_kla        = 'N1BASE'
       i_num        = '030'
       i_mv1        = '1'
       i_mv2        = '_ADD_CHILD_CONTROLLER'
       i_mv3        = 'CL_ISH_GUI_CONTROLLER' ).
  ENDIF.

* Insert the child controller into gt_child_ctr.
  ls_child_ctr-controller_name = ir_child_controller->get_element_name( ).
  ls_child_ctr-r_controller    = ir_child_controller.
  INSERT ls_child_ctr INTO TABLE gt_child_ctr.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
       i_typ        = 'E'
       i_kla        = 'N1BASE'
       i_num        = '030'
       i_mv1        = '2'
       i_mv2        = '_ADD_CHILD_CONTROLLER'
       i_mv3        = 'CL_ISH_GUI_CONTROLLER' ).
  ENDIF.

* Register the eventhandlers for the child controller.
  SET HANDLER on_childctr_before_destroy FOR ir_child_controller ACTIVATION abap_true.
  SET HANDLER on_childctr_after_destroy  FOR ir_child_controller ACTIVATION abap_true.

ENDMETHOD.


METHOD _destroy.

  FIELD-SYMBOLS:
    <ls_child_ctr>  LIKE LINE OF gt_child_ctr.

* Deregister the eventhandlers.
  SET HANDLER on_childctr_before_destroy FOR ALL INSTANCES ACTIVATION abap_false.
  SET HANDLER on_childctr_after_destroy  FOR ALL INSTANCES ACTIVATION abap_false.

* Destroy the child controllers.
  LOOP AT gt_child_ctr ASSIGNING <ls_child_ctr>.
    <ls_child_ctr>-r_controller->destroy( ).
  ENDLOOP.

* Destroy the view.
  IF gr_view IS BOUND.
    gr_view->destroy( ).
  ENDIF.

* Clear attributes.
  CLEAR:
    gr_model,
    gr_parent_ctr,
    gr_view,
    gt_child_ctr,
    gr_cb_destroyable.

* We are not initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_false.

ENDMETHOD.


METHOD _get_okcodereq_by_controlev.

* By default control events are processed without pai.
* Redefine this method if a control event has to be processed after pai.

ENDMETHOD.


METHOD _init_ctr.

* Initialize attributes.
  gr_parent_ctr  = ir_parent_controller.
  gr_model       = ir_model.
  gr_view        = ir_view.
  g_vcode        = i_vcode.

* Register self as child controller.
  IF gr_parent_ctr IS BOUND.
    gr_parent_ctr->register_child_controller( ir_child_controller = me ).
  ENDIF.

ENDMETHOD.


METHOD _process_command_request.
ENDMETHOD.


METHOD _process_event_request.
ENDMETHOD.


METHOD _propagate_exception.

  DATA lr_processor           TYPE REF TO if_ish_gui_request_processor.
  DATA lr_request             TYPE REF TO cl_ish_gui_exception_event.

  lr_processor = get_parent_controller( ).
  IF lr_processor IS NOT BOUND.
    lr_processor = get_application( ).
  ENDIF.
  CHECK lr_processor IS BOUND.

  lr_request = cl_ish_gui_exception_event=>create(
      ir_sender    = me
      ir_exception = ir_exception ).

  rr_response = lr_processor->process_request( ir_request = lr_request ).

ENDMETHOD.


METHOD _propagate_messages.

  DATA lr_processor           TYPE REF TO if_ish_gui_request_processor.
  DATA lr_request             TYPE REF TO cl_ish_gui_message_event.

  lr_processor = get_parent_controller( ).
  IF lr_processor IS NOT BOUND.
    lr_processor = get_application( ).
  ENDIF.
  CHECK lr_processor IS BOUND.

  lr_request = cl_ish_gui_message_event=>create(
      ir_sender   = me
      ir_messages = ir_messages ).

  rr_response = lr_processor->process_request( ir_request = lr_request ).

ENDMETHOD.


METHOD _propagate_request.

  DATA lr_event_request               TYPE REF TO cl_ish_gui_event_request.
  DATA lr_command_request             TYPE REF TO cl_ish_gui_command_request.
  DATA lr_okcode_request              TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_parent_controller           TYPE REF TO if_ish_gui_controller.
  DATA lr_processor                   TYPE REF TO if_ish_gui_request_processor.
  DATA lt_child_ctr                   TYPE ish_t_gui_ctrid_hash.

  FIELD-SYMBOLS <ls_child_ctr>        TYPE rn1_gui_ctrid_hash.

* The request has to be specified.
  CHECK ir_request IS BOUND.

* Event requests and okcode requests are propagated to the parent controller.
* Command requests are propagated to the child controllers.
  TRY.
      lr_event_request ?= ir_request.
      lr_processor = get_parent_controller( ).
      IF lr_processor IS NOT BOUND.
        lr_processor = get_application( ).
      ENDIF.
      CHECK lr_processor IS BOUND.
      rr_response = lr_processor->process_request( ir_request = ir_request ).
    CATCH cx_sy_move_cast_error.
      TRY.
          lr_okcode_request ?= ir_request.
          lr_processor = get_parent_controller( ).
          IF lr_processor IS NOT BOUND.
            lr_processor = get_application( ).
          ENDIF.
          CHECK lr_processor IS BOUND.
          rr_response = lr_processor->process_request( ir_request = ir_request ).
        CATCH cx_sy_move_cast_error.
          TRY.
              lr_command_request ?= ir_request.
              lt_child_ctr = get_child_controllers( ).
              LOOP AT lt_child_ctr ASSIGNING <ls_child_ctr>.
                CHECK <ls_child_ctr>-r_controller IS BOUND.
                rr_response = <ls_child_ctr>-r_controller->process_request( ir_request = ir_request ).
                IF rr_response IS BOUND.
                  EXIT.
                ENDIF.
              ENDLOOP.
            CATCH cx_sy_move_cast_error.                "#EC NO_HANDLER
          ENDTRY.
      ENDTRY.
  ENDTRY.

ENDMETHOD.


METHOD _remove_child_controller.

  DATA l_element_name    TYPE n1gui_element_name.

* The child controller has to be given.
  CHECK ir_child_controller IS BOUND.

* Delete the child controller from gt_child_ctr.
  l_element_name = ir_child_controller->get_element_name( ).
  DELETE TABLE gt_child_ctr WITH TABLE KEY controller_name = l_element_name.
  CHECK sy-subrc = 0.

* Deregister the eventhandlers for the child controller.
  SET HANDLER on_childctr_before_destroy FOR ir_child_controller ACTIVATION abap_false.
  SET HANDLER on_childctr_after_destroy  FOR ir_child_controller ACTIVATION abap_false.

* The child controller was removed.
  r_removed = abap_true.

ENDMETHOD.


METHOD _set_vcode.

  CHECK g_vcode <> i_vcode.

  g_vcode = i_vcode.

  r_changed = abap_true.

ENDMETHOD.
ENDCLASS.
