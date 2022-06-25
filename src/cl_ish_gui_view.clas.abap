class CL_ISH_GUI_VIEW definition
  public
  inheriting from CL_ISH_GUI_ELEMENT
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_VIEW
*"* do not include other source files here!!!
  type-pools ICON .
  type-pools VRM .

  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_GUI_CB_STRUCTURE_MODEL .
  interfaces IF_ISH_GUI_REQUEST_PROCESSOR .
  interfaces IF_ISH_GUI_REQUEST_SENDER .
  interfaces IF_ISH_GUI_VIEW .

  aliases CO_VCODE_DISPLAY
    for IF_ISH_GUI_VIEW~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_GUI_VIEW~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_GUI_VIEW~CO_VCODE_UPDATE .
  aliases ACTUALIZE_LAYOUT
    for IF_ISH_GUI_VIEW~ACTUALIZE_LAYOUT .
  aliases DESTROY
    for IF_ISH_GUI_VIEW~DESTROY .
  aliases GET_ALV_VARIANT_REPORT_SUFFIX
    for IF_ISH_GUI_VIEW~GET_ALV_VARIANT_REPORT_SUFFIX .
  aliases GET_APPLICATION
    for IF_ISH_GUI_VIEW~GET_APPLICATION .
  aliases GET_CHILD_VIEWS
    for IF_ISH_GUI_VIEW~GET_CHILD_VIEWS .
  aliases GET_CHILD_VIEW_BY_ID
    for IF_ISH_GUI_VIEW~GET_CHILD_VIEW_BY_ID .
  aliases GET_CHILD_VIEW_BY_NAME
    for IF_ISH_GUI_VIEW~GET_CHILD_VIEW_BY_NAME .
  aliases GET_CONTROLLER
    for IF_ISH_GUI_VIEW~GET_CONTROLLER .
  aliases GET_ERRORFIELD_MESSAGES
    for IF_ISH_GUI_VIEW~GET_ERRORFIELD_MESSAGES .
  aliases GET_LAYOUT
    for IF_ISH_GUI_VIEW~GET_LAYOUT .
  aliases GET_PARENT_VIEW
    for IF_ISH_GUI_VIEW~GET_PARENT_VIEW .
  aliases GET_T_ERRORFIELD
    for IF_ISH_GUI_VIEW~GET_T_ERRORFIELD .
  aliases GET_T_VIEW_ERRORFIELDS
    for IF_ISH_GUI_VIEW~GET_T_VIEW_ERRORFIELDS .
  aliases GET_VCODE
    for IF_ISH_GUI_VIEW~GET_VCODE .
  aliases HAS_ERRORFIELDS
    for IF_ISH_GUI_VIEW~HAS_ERRORFIELDS .
  aliases HAS_FOCUS
    for IF_ISH_GUI_VIEW~HAS_FOCUS .
  aliases IS_DESTROYED
    for IF_ISH_GUI_VIEW~IS_DESTROYED .
  aliases IS_FIRST_DISPLAY_DONE
    for IF_ISH_GUI_VIEW~IS_FIRST_DISPLAY_DONE .
  aliases IS_INITIALIZED
    for IF_ISH_GUI_VIEW~IS_INITIALIZED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_GUI_VIEW~IS_IN_DESTROY_MODE .
  aliases IS_IN_FIRST_DISPLAY_MODE
    for IF_ISH_GUI_VIEW~IS_IN_FIRST_DISPLAY_MODE .
  aliases IS_IN_INITIALIZATION_MODE
    for IF_ISH_GUI_VIEW~IS_IN_INITIALIZATION_MODE .
  aliases PROCESS_REQUEST
    for IF_ISH_GUI_VIEW~PROCESS_REQUEST .
  aliases REGISTER_CHILD_VIEW
    for IF_ISH_GUI_VIEW~REGISTER_CHILD_VIEW .
  aliases SAVE_LAYOUT
    for IF_ISH_GUI_VIEW~SAVE_LAYOUT .
  aliases SET_FOCUS
    for IF_ISH_GUI_VIEW~SET_FOCUS .
  aliases SET_VCODE
    for IF_ISH_GUI_VIEW~SET_VCODE .
  aliases EV_AFTER_DESTROY
    for IF_ISH_GUI_VIEW~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_GUI_VIEW~EV_BEFORE_DESTROY .

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    preferred parameter I_ELEMENT_NAME .
protected section.
*"* protected components of class CL_ISH_GUI_VIEW
*"* do not include other source files here!!!

  data GR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE .
  data GR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER .
  data GR_LAYOUT type ref to CL_ISH_GUI_VIEW_LAYOUT .
  data GR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW .
  data GT_CHILD_VIEW type ISH_T_GUI_VIEWNAME_HASH .
  data GT_ERRORFIELD type ISHMED_T_GUI_ERRORFIELD_H .
  type-pools ABAP .
  data G_CB_LAYOUT type ABAP_BOOL .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .
  data G_FIRST_DISPLAY_DONE type ABAP_BOOL .
  data G_FIRST_DISPLAY_MODE type ABAP_BOOL .
  data G_INITIALIZATION_MODE type ABAP_BOOL .
  data G_INITIALIZED type ABAP_BOOL .
  data G_VCODE type TNDYM-VCODE .

  methods ON_CHILDVIEW_AFTER_DESTROY
    for event EV_AFTER_DESTROY of IF_ISH_GUI_VIEW
    importing
      !SENDER .
  methods ON_CHILDVIEW_BEFORE_DESTROY
    for event EV_BEFORE_DESTROY of IF_ISH_GUI_VIEW
    importing
      !SENDER .
  methods _ADD_CHILD_VIEW
    importing
      !IR_CHILD_VIEW type ref to IF_ISH_GUI_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DESTROY .
  methods _GET_ERRORFIELD_MESSAGES
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(RR_MESSAGES) type ref to CL_ISHMED_ERRORHANDLING .
  methods _GET_MODEL
    returning
      value(RR_MODEL) type ref to IF_ISH_GUI_MODEL .
  methods _GET_OKCODEREQ_BY_CONTROLEV
    importing
      !IR_CONTROL_EVENT type ref to CL_ISH_GUI_CONTROL_EVENT
    returning
      value(RR_OKCODE_REQUEST) type ref to CL_ISH_GUI_OKCODE_REQUEST .
  methods _INIT_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW optional
      !IR_LAYOUT type ref to CL_ISH_GUI_VIEW_LAYOUT optional
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _IS_PAI_IN_PROCESS
    returning
      value(R_PAI_IN_PROCESS) type ABAP_BOOL .
  methods _LOAD_LAYOUT
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_USERNAME type USERNAME default SY-UNAME
    returning
      value(RR_LAYOUT) type ref to CL_ISH_GUI_LAYOUT .
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
  methods _PROPAGATE_MESSAGE
    importing
      !I_TYP type SY-MSGTY
      !I_KLA type SY-MSGID
      !I_NUM type SY-MSGNO
      !I_MV1 type ANY optional
      !I_MV2 type ANY optional
      !I_MV3 type ANY optional
      !I_MV4 type ANY optional
      !I_PAR type BAPIRET2-PARAMETER optional
      !I_ROW type BAPIRET2-ROW optional
      !I_FIELD type BAPIRET2-FIELD optional
      !IR_OBJECT type NOBJECTREF optional
      !I_LINE_KEY type CHAR100 optional
      !IR_ERROR_OBJ type ref to CL_ISH_ERROR optional .
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
  methods _REMOVE_CHILD_VIEW
    importing
      !IR_CHILD_VIEW type ref to IF_ISH_GUI_VIEW
    returning
      value(R_REMOVED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REMOVE_ERRORFIELD
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_REMOVED) type ABAP_BOOL .
  methods _SET_CHILD_VIEW_VCODE
    importing
      !IR_CHILD_VIEW type ref to IF_ISH_GUI_VIEW
      !I_VCODE type ISH_VCODE
      !I_WITH_CHILD_VIEWS type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SET_ERRORFIELD
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_FIELDNAME type ISH_FIELDNAME
      !IR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING .
  methods _SET_VCODE
    importing
      !I_VCODE type TNDYM-VCODE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods __GET_FIELD_CONTENT
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_FIELDNAME type ISH_FIELDNAME
    changing
      !C_CONTENT type ANY
    raising
      CX_ISH_STATIC_HANDLER .
  methods __SET_FIELD_CONTENT
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_CONTENT type ANY
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_GUI_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_VIEW IMPLEMENTATION.


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


METHOD if_ish_gui_cb_structure_model~cb_set_field_content.

  CHECK ir_model IS BOUND.

  IF ir_model = gr_layout.
    CHECK g_cb_layout = abap_true.
    r_continue = abap_true.
    RETURN.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_request_processor~after_request_processing.

  DATA lr_event_request         TYPE REF TO cl_ish_gui_event_request.
  DATA lr_command_request       TYPE REF TO cl_ish_gui_command_request.
  DATA lr_okcode_request        TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_controller            TYPE REF TO if_ish_gui_controller.
  DATA lt_child_view            TYPE ish_t_gui_viewid_hash.

  FIELD-SYMBOLS <ls_child_view> TYPE rn1_gui_viewid_hash.

* Event requests are propagated to the controller.
* Command requests are propagated to the child views.
  TRY.
      lr_event_request ?= ir_request.
      lr_controller = get_controller( ).
      CHECK lr_controller IS BOUND.
      lr_controller->if_ish_gui_request_processor~after_request_processing(
          ir_request  = ir_request
          ir_response = ir_response ).
    CATCH cx_sy_move_cast_error.
      TRY.
          lr_okcode_request ?= ir_request.
          lr_controller = get_controller( ).
          CHECK lr_controller IS BOUND.
          lr_controller->if_ish_gui_request_processor~after_request_processing(
              ir_request  = ir_request
              ir_response = ir_response ).
        CATCH cx_sy_move_cast_error.
          TRY.
              lr_command_request ?= ir_request.
              lt_child_view = get_child_views( ).
              LOOP AT lt_child_view ASSIGNING <ls_child_view>.
                CHECK <ls_child_view>-r_view IS BOUND.
                <ls_child_view>-r_view->if_ish_gui_request_processor~after_request_processing(
                    ir_request  = ir_request
                    ir_response = ir_response ).
              ENDLOOP.
            CATCH cx_sy_move_cast_error.                "#EC NO_HANDLER
          ENDTRY.
      ENDTRY.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_request_processor~process_request.

  DATA:
    lr_event_request      TYPE REF TO cl_ish_gui_event_request,
    lr_command_request    TYPE REF TO cl_ish_gui_command_request.

* The request has to be specified.
  CHECK ir_request IS BOUND.

* Wrap to the corresponding method.
  TRY.
*     Event request?
      lr_event_request ?= ir_request.
      rr_response = _process_event_request( ir_event_request = lr_event_request ).
    CATCH cx_sy_move_cast_error.
      TRY.
*         Command request?
          lr_command_request ?= ir_request.
          rr_response = _process_command_request( ir_command_request = lr_command_request ).
        CATCH cx_sy_move_cast_error.
      ENDTRY.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_request_sender~get_okcodereq_by_controlev.

  DATA lr_parent_view           TYPE REF TO if_ish_gui_view.

* First propagate to the controller.
  IF gr_controller IS BOUND.
    rr_okcode_request =
      gr_controller->if_ish_gui_request_sender~get_okcodereq_by_controlev( ir_control_event ).
    CHECK rr_okcode_request IS NOT BOUND.
  ENDIF.

* Propagate to the parent view.
  lr_parent_view = get_parent_view( ).
  IF lr_parent_view IS BOUND.
    rr_okcode_request =
      lr_parent_view->if_ish_gui_request_sender~get_okcodereq_by_controlev( ir_control_event ).
    CHECK rr_okcode_request IS NOT BOUND.
  ENDIF.

* Now do own processing.
  rr_okcode_request = _get_okcodereq_by_controlev( ir_control_event ).

ENDMETHOD.


METHOD if_ish_gui_view~actualize_layout.

* No implementation in the base class.

ENDMETHOD.


METHOD if_ish_gui_view~get_alv_variant_report_suffix.

  r_suffix = cl_ish_utl_rtti=>get_class_name( me ).

ENDMETHOD.


METHOD if_ish_gui_view~get_application.

  DATA:
    lr_controller        TYPE REF TO if_ish_gui_controller.

  lr_controller = get_controller( ).
  CHECK lr_controller IS BOUND.

  rr_application = lr_controller->get_application( ).

ENDMETHOD.


METHOD if_ish_gui_view~get_child_views.

  DATA:
    ls_tmp_view      TYPE rn1_gui_viewid_hash,
    lt_tmp_view      TYPE ish_t_gui_viewid_hash.

  FIELD-SYMBOLS:
    <ls_child_view>  LIKE LINE OF gt_child_view.

  LOOP AT gt_child_view ASSIGNING <ls_child_view>.

    ls_tmp_view-view_id = <ls_child_view>-r_view->get_element_id( ).
    ls_tmp_view-r_view  = <ls_child_view>-r_view.
    INSERT ls_tmp_view INTO TABLE rt_child_view.

    IF i_with_subchildren = abap_true.
      lt_tmp_view = <ls_child_view>-r_view->get_child_views( i_with_subchildren = abap_true ).
      INSERT LINES OF lt_tmp_view INTO TABLE rt_child_view.
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_view~get_child_view_by_id.

  FIELD-SYMBOLS:
    <ls_child_view>  LIKE LINE OF gt_child_view.

  LOOP AT gt_child_view ASSIGNING <ls_child_view>.

    IF <ls_child_view>-r_view->get_element_id( ) = i_view_id.
      rr_child_view = <ls_child_view>-r_view.
      EXIT.
    ENDIF.

    IF i_with_subchildren = abap_true.
      rr_child_view = <ls_child_view>-r_view->get_child_view_by_id( i_view_id          = i_view_id
                                                                    i_with_subchildren = abap_true ).
      IF rr_child_view IS BOUND.
        EXIT.
      ENDIF.
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_view~get_child_view_by_name.

  FIELD-SYMBOLS:
    <ls_child_view>  LIKE LINE OF gt_child_view.

  READ TABLE gt_child_view
    WITH TABLE KEY view_name = i_view_name
    ASSIGNING <ls_child_view>.
  CHECK sy-subrc = 0.

  rr_child_view = <ls_child_view>-r_view.

ENDMETHOD.


METHOD if_ish_gui_view~get_controller.

  rr_controller = gr_controller.

ENDMETHOD.


METHOD if_ish_gui_view~get_errorfield_messages.

  DATA lt_view_errorfields              TYPE ishmed_t_gv_errorfields_h.
  DATA ls_view_errorfields              TYPE rn1_gv_errorfields.

  FIELD-SYMBOLS <ls_view_errorfields>   TYPE rn1_gv_errorfields.
  FIELD-SYMBOLS <ls_errorfield>         TYPE rn1_gui_errorfield.

  IF i_with_child_views = abap_true.
    lt_view_errorfields = get_t_view_errorfields(
                              ir_model    = ir_model
                              i_fieldname = i_fieldname ).
  ELSE.
    ls_view_errorfields-t_errorfield = get_t_errorfield(
        ir_model    = ir_model
        i_fieldname = i_fieldname ).
    INSERT ls_view_errorfields INTO TABLE lt_view_errorfields.
  ENDIF.

  LOOP AT lt_view_errorfields ASSIGNING <ls_view_errorfields>.
    LOOP AT <ls_view_errorfields>-t_errorfield ASSIGNING <ls_errorfield>.
      CALL METHOD cl_ish_utl_base=>copy_messages
        EXPORTING
          i_copy_from     = <ls_errorfield>-r_messages
        CHANGING
          cr_errorhandler = rr_messages.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_view~get_layout.

  rr_layout = gr_layout.

ENDMETHOD.


METHOD if_ish_gui_view~get_parent_view.

  rr_parent_view = gr_parent_view.

ENDMETHOD.


METHOD if_ish_gui_view~get_t_errorfield.

  FIELD-SYMBOLS <ls_errorfield>           LIKE LINE OF gt_errorfield.

  IF ir_model IS NOT BOUND AND
     i_fieldname IS INITIAL.
    rt_errorfield = gt_errorfield.
  ELSE.
    LOOP AT gt_errorfield ASSIGNING <ls_errorfield>.
      IF ir_model IS BOUND.
        CHECK <ls_errorfield>-r_model = ir_model.
      ENDIF.
      IF i_fieldname IS NOT INITIAL.
        CHECK <ls_errorfield>-fieldname = i_fieldname.
      ENDIF.
      INSERT <ls_errorfield> INTO TABLE rt_errorfield.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_view~get_t_view_errorfields.

  DATA ls_view_errorfields                    TYPE rn1_gv_errorfields.
  DATA lt_child_view_errorfields              TYPE ishmed_t_gv_errorfields_h.

  FIELD-SYMBOLS <ls_child_view>               LIKE LINE OF gt_child_view.
  FIELD-SYMBOLS <ls_child_view_errorfields>   TYPE rn1_gv_errorfields.

  ls_view_errorfields-r_view        = me.
  ls_view_errorfields-t_errorfield  = get_t_errorfield(
                                          ir_model    = ir_model
                                          i_fieldname = i_fieldname ).
  INSERT ls_view_errorfields INTO TABLE rt_view_errorfields.

  LOOP AT gt_child_view ASSIGNING <ls_child_view>.
    lt_child_view_errorfields = <ls_child_view>-r_view->get_t_view_errorfields(
                                    ir_model    = ir_model
                                    i_fieldname = i_fieldname ).
    LOOP AT lt_child_view_errorfields ASSIGNING <ls_child_view_errorfields>.
      INSERT <ls_child_view_errorfields> INTO TABLE rt_view_errorfields.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_view~get_vcode.

  r_vcode = g_vcode.

ENDMETHOD.


METHOD if_ish_gui_view~has_errorfields.

  FIELD-SYMBOLS <ls_child_view>               LIKE LINE OF gt_child_view.

  IF get_t_errorfield(
      ir_model      = ir_model
      i_fieldname   = i_fieldname ) IS NOT INITIAL.
    r_has_errorfields = abap_true.
    RETURN.
  ENDIF.

  CHECK i_with_child_views = abap_true.

  LOOP AT gt_child_view ASSIGNING <ls_child_view>.
    r_has_errorfields = <ls_child_view>-r_view->has_errorfields(
        ir_model    = ir_model
        i_fieldname = i_fieldname ).
    CHECK r_has_errorfields = abap_true.
    RETURN.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_view~has_focus.

  DATA:
    lr_application            TYPE REF TO if_ish_gui_application.

  lr_application = get_application( ).
  CHECK lr_application IS BOUND.

  CHECK lr_application->get_focussed_view( ) = me.

  r_has_focus = abap_true.

ENDMETHOD.


METHOD if_ish_gui_view~is_first_display_done.

  r_done = g_first_display_done.

ENDMETHOD.


METHOD if_ish_gui_view~is_initialized.

  r_initialized = g_initialized.

ENDMETHOD.


METHOD if_ish_gui_view~is_in_first_display_mode.

  r_first_display_mode = g_first_display_mode.

ENDMETHOD.


METHOD if_ish_gui_view~is_in_initialization_mode.

  r_initialization_mode = g_initialization_mode.

ENDMETHOD.


METHOD if_ish_gui_view~register_child_view.

  _add_child_view( ir_child_view = ir_child_view ).

ENDMETHOD.


METHOD if_ish_gui_view~save_layout.

  DATA lr_application               TYPE REF TO if_ish_gui_application.

  lr_application = get_application( ).
  CHECK lr_application IS BOUND.

  r_saved = lr_application->save_view_layout(
      ir_view    = me
      i_explicit = abap_true
      i_username  = i_username
      i_erdat     = i_erdat
      i_ertim     = i_ertim
      i_erusr     = i_erusr ).

ENDMETHOD.


METHOD if_ish_gui_view~set_focus.

  DATA:
    lr_application            TYPE REF TO if_ish_gui_application.

  lr_application = get_application( ).
  CHECK lr_application IS BOUND.

  r_success = lr_application->set_focussed_view( ir_view = me ).

ENDMETHOD.


METHOD if_ish_gui_view~set_vcode.

  DATA:
    lt_child_view      TYPE ish_t_gui_viewid_hash,
    lr_errorhandler    TYPE REF TO cl_ishmed_errorhandling,
    lx_root            TYPE REF TO cx_root.

  FIELD-SYMBOLS:
    <ls_child_view>    TYPE rn1_gui_viewid_hash.

* Process only if self is valid.
  IF is_initialized( )     = abap_false OR
     is_destroyed( )       = abap_true  OR
     is_in_destroy_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_VCODE'
        i_mv3        = 'CL_ISH_GUI_VIEW' ).
  ENDIF.

* Set own vcode.
  r_changed = _set_vcode( i_vcode = i_vcode ).

* Set the vcode of the child views.
  IF i_with_child_views = abap_true.
    lt_child_view = get_child_views( i_with_subchildren = abap_false ).
    LOOP AT lt_child_view ASSIGNING <ls_child_view>.
      CHECK <ls_child_view>-r_view IS BOUND.
      TRY.
          _set_child_view_vcode(
              ir_child_view       = <ls_child_view>-r_view
              i_vcode             = i_vcode
              i_with_child_views  = abap_true ).
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

* Errorhandling
  IF lr_errorhandler IS BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD on_childview_after_destroy.

  DATA:
    lr_child_view        TYPE REF TO if_ish_gui_view,
    lx_root              TYPE REF TO cx_root.

* Check the sender.
  CHECK sender IS BOUND.
  TRY.
      lr_child_view ?= sender.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Remove the child view from self.
  TRY.
      _remove_child_view( ir_child_view = sender ).
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( ir_exception = lx_root ).
  ENDTRY.

ENDMETHOD.


method ON_CHILDVIEW_BEFORE_DESTROY.
endmethod.


METHOD _add_child_view.

  DATA:
    ls_child_view    LIKE LINE OF gt_child_view.

* The child view has to be given.
* The parent view of the given child view has to be self.
  IF ir_child_view IS NOT BOUND OR
     ir_child_view->get_parent_view( ) <> me.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_ADD_CHILD_VIEW'
        i_mv3        = 'CL_ISH_GUI_VIEW' ).
  ENDIF.

* Insert the child view into gt_child_view.
  ls_child_view-view_name = ir_child_view->get_element_name( ).
  ls_child_view-r_view    = ir_child_view.
  INSERT ls_child_view INTO TABLE gt_child_view.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_ADD_CHILD_VIEW'
        i_mv3        = 'CL_ISH_GUI_VIEW' ).
  ENDIF.

* Register the eventhandlers for the child view.
  SET HANDLER on_childview_before_destroy FOR ir_child_view ACTIVATION abap_true.
  SET HANDLER on_childview_after_destroy  FOR ir_child_view ACTIVATION abap_true.

ENDMETHOD.


METHOD _destroy.

  DATA lr_application                 TYPE REF TO if_ish_gui_application.
  DATA lx_root                        TYPE REF TO cx_root.

  FIELD-SYMBOLS <ls_child_view>       LIKE LINE OF gt_child_view.

* Autosave the layout.
  DO 1 TIMES.
    CHECK gr_layout IS BOUND.
    lr_application = get_application( ).
    CHECK lr_application IS BOUND.
    TRY.
        lr_application->save_view_layout(
            ir_view    = me
            i_explicit = abap_false ).
      CATCH cx_ish_static_handler INTO lx_root.
        _propagate_exception( lx_root ).
    ENDTRY.
  ENDDO.

* Deregister the eventhandlers.
  LOOP AT gt_child_view ASSIGNING <ls_child_view>.
    CHECK <ls_child_view>-r_view IS BOUND.
    SET HANDLER on_childview_before_destroy FOR <ls_child_view>-r_view ACTIVATION abap_false.
    SET HANDLER on_childview_after_destroy  FOR <ls_child_view>-r_view ACTIVATION abap_false.
  ENDLOOP.

* Destroy the child views.
  LOOP AT gt_child_view ASSIGNING <ls_child_view>.
    CHECK <ls_child_view>-r_view IS BOUND.
    <ls_child_view>-r_view->destroy( ).
  ENDLOOP.

* Clear attributes.
  CLEAR gr_controller.
  CLEAR gr_parent_view.
  CLEAR gt_child_view.
  CLEAR gt_errorfield.
  CLEAR gr_layout.
  CLEAR gr_cb_destroyable.
  g_first_display_done  = abap_false.
  g_first_display_mode  = abap_false.
  g_initialization_mode = abap_false.
  g_initialized         = abap_false.
  g_vcode               = co_vcode_display.

ENDMETHOD.


METHOD _get_errorfield_messages.

  FIELD-SYMBOLS <ls_errorfield>           LIKE LINE OF gt_errorfield.

  READ TABLE gt_errorfield
    WITH TABLE KEY
      r_model   = ir_model
      fieldname = i_fieldname
    ASSIGNING <ls_errorfield>.
  CHECK sy-subrc = 0.

  rr_messages = <ls_errorfield>-r_messages.

ENDMETHOD.


METHOD _get_model.

  CHECK gr_controller IS BOUND.

  rr_model = gr_controller->get_model( ).

ENDMETHOD.


METHOD _get_okcodereq_by_controlev.

* By default control events are processed without pai.
* Redefine this method if a control event has to be processed after pai.

ENDMETHOD.


METHOD _init_view.

* The controller has to be specified.
  IF ir_controller IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_INIT_VIEW'
        i_mv3        = 'CL_ISH_GUI_VIEW' ).
  ENDIF.

* Initialize attributes.
  gr_controller     = ir_controller.
  gr_parent_view    = ir_parent_view.
  gr_layout         = ir_layout.
  g_vcode           = i_vcode.
  IF g_vcode IS INITIAL.
    g_vcode = co_vcode_display.
  ENDIF.

* Set self as the layout's view.
  IF gr_layout IS BOUND.
    gr_layout->set_view( ir_view = me ).
  ENDIF.

* Register self as child view.
  IF gr_parent_view IS BOUND.
    gr_parent_view->register_child_view( ir_child_view = me ).
  ENDIF.

ENDMETHOD.


METHOD _is_pai_in_process.

  DATA lr_application           TYPE REF TO if_ish_gui_application.

  lr_application = get_application( ).
  CHECK lr_application IS BOUND.

  r_pai_in_process = lr_application->is_pai_in_process( ).

ENDMETHOD.


METHOD _load_layout.

  DATA lr_application                   TYPE REF TO if_ish_gui_application.
  DATA lr_exception_event               TYPE REF TO cl_ish_gui_exception_event.
  DATA lx_root                          TYPE REF TO cx_root.

  IF ir_controller IS BOUND.
    lr_application = ir_controller->get_application( ).
  ELSEIF ir_parent_view IS BOUND.
    lr_application = ir_parent_view->get_application( ).
  ENDIF.
  CHECK lr_application IS BOUND.

  TRY.
      rr_layout = lr_application->load_view_layout(
          ir_view         = me
          ir_controller   = ir_controller
          ir_parent_view  = ir_parent_view
          i_layout_name   = i_layout_name
          i_username      = i_username ).
    CATCH cx_ish_static_handler INTO lx_root.
      lr_exception_event = cl_ish_gui_exception_event=>create(
          ir_sender    = me
          ir_exception = lx_root ).
      lr_application->process_request( lr_exception_event ).
  ENDTRY.

ENDMETHOD.


method _PROCESS_COMMAND_REQUEST.
endmethod.


method _PROCESS_EVENT_REQUEST.
endmethod.


METHOD _propagate_exception.

  DATA:
    lr_controller  TYPE REF TO if_ish_gui_controller,
    lr_request     TYPE REF TO cl_ish_gui_exception_event.

* Get the controller.
  lr_controller = get_controller( ).
  CHECK lr_controller IS BOUND.

* Create the exception event request.
  lr_request = cl_ish_gui_exception_event=>create( ir_sender    = me
                                                   ir_exception = ir_exception ).

* Let the controller process the request.
  rr_response = lr_controller->process_request( ir_request = lr_request ).

ENDMETHOD.


METHOD _propagate_message .

  DATA lr_messages              TYPE REF TO cl_ishmed_errorhandling.

  CALL METHOD cl_ish_utl_base=>collect_messages
    EXPORTING
      i_typ           = i_typ
      i_kla           = i_kla
      i_num           = i_num
      i_mv1           = i_mv1
      i_mv2           = i_mv2
      i_mv3           = i_mv3
      i_mv4           = i_mv4
      i_par           = i_par
      i_row           = i_row
      i_field         = i_field
      ir_object       = ir_object
      i_line_key      = i_line_key
      ir_error_obj    = ir_error_obj
    CHANGING
      cr_errorhandler = lr_messages.

  _propagate_messages( ir_messages = lr_messages ).

ENDMETHOD.


METHOD _propagate_messages.

  DATA:
    lr_controller  TYPE REF TO if_ish_gui_controller,
    lr_request     TYPE REF TO cl_ish_gui_message_event.

* Get the controller.
  lr_controller = get_controller( ).
  CHECK lr_controller IS BOUND.

* Create the message event request.
  lr_request = cl_ish_gui_message_event=>create( ir_sender   = me
                                                 ir_messages = ir_messages ).

* Let the controller process the request.
  rr_response = lr_controller->process_request( ir_request = lr_request ).

ENDMETHOD.


METHOD _propagate_request.

  DATA lr_event_request         TYPE REF TO cl_ish_gui_event_request.
  DATA lr_command_request       TYPE REF TO cl_ish_gui_command_request.
  DATA lr_okcode_request        TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_controller            TYPE REF TO if_ish_gui_controller.
  DATA lt_child_view            TYPE ish_t_gui_viewid_hash.

  FIELD-SYMBOLS:
    <ls_child_view>        TYPE rn1_gui_viewid_hash.

* The request has to be specified.
  CHECK ir_request IS BOUND.

* Event requests are propagated to the controller.
* Command requests are propagated to the child views.
  TRY.
      lr_event_request ?= ir_request.
      lr_controller = get_controller( ).
      CHECK lr_controller IS BOUND.
      rr_response = lr_controller->process_request( ir_request = ir_request ).
    CATCH cx_sy_move_cast_error.
      TRY.
          lr_okcode_request ?= ir_request.
          lr_controller = get_controller( ).
          CHECK lr_controller IS BOUND.
          rr_response = lr_controller->process_request( ir_request = ir_request ).
        CATCH cx_sy_move_cast_error.
          TRY.
              lr_command_request ?= ir_request.
              lt_child_view = get_child_views( ).
              LOOP AT lt_child_view ASSIGNING <ls_child_view>.
                CHECK <ls_child_view>-r_view IS BOUND.
                rr_response = <ls_child_view>-r_view->process_request( ir_request = ir_request ).
                IF rr_response IS BOUND.
                  EXIT.
                ENDIF.
              ENDLOOP.
            CATCH cx_sy_move_cast_error.                "#EC NO_HANDLER
          ENDTRY.
      ENDTRY.
  ENDTRY.

ENDMETHOD.


METHOD _remove_child_view.

  DATA l_element_name TYPE n1gui_element_name.

* The child view has to be given.
  CHECK ir_child_view IS BOUND.

* Delete the child view from gt_child_view.
  l_element_name = ir_child_view->get_element_name( ).
  DELETE TABLE gt_child_view WITH TABLE KEY view_name = l_element_name.
  CHECK sy-subrc = 0.

* Deregister the eventhandlers for the child view.
  SET HANDLER on_childview_before_destroy FOR ir_child_view ACTIVATION abap_false.
  SET HANDLER on_childview_after_destroy  FOR ir_child_view ACTIVATION abap_false.

* The child view was removed.
  r_removed = abap_true.

ENDMETHOD.


METHOD _remove_errorfield.

  DELETE TABLE gt_errorfield
    WITH TABLE KEY
      r_model   = ir_model
      fieldname = i_fieldname.
  CHECK sy-subrc = 0.

  r_removed = abap_true.

ENDMETHOD.


METHOD _set_child_view_vcode.

  CHECK ir_child_view IS BOUND.

  ir_child_view->set_vcode(
      i_vcode            = i_vcode
      i_with_child_views = i_with_child_views ).

ENDMETHOD.


METHOD _set_errorfield.

  DATA ls_errorfield                      LIKE LINE OF gt_errorfield.

  FIELD-SYMBOLS <ls_errorfield>           LIKE LINE OF gt_errorfield.

  CHECK ir_model IS BOUND.
  CHECK i_fieldname IS NOT INITIAL.
  CHECK ir_messages IS BOUND.

  READ TABLE gt_errorfield
    WITH TABLE KEY
      r_model   = ir_model
      fieldname = i_fieldname
    ASSIGNING <ls_errorfield>.

  IF sy-subrc = 0.
    CALL METHOD cl_ish_utl_base=>copy_messages
      EXPORTING
        i_copy_from     = ir_messages
      CHANGING
        cr_errorhandler = <ls_errorfield>-r_messages.
  ELSE.
    ls_errorfield-r_model     = ir_model.
    ls_errorfield-fieldname   = i_fieldname.
    ls_errorfield-r_messages  = ir_messages.
    INSERT ls_errorfield INTO TABLE gt_errorfield.
  ENDIF.

ENDMETHOD.


METHOD _set_vcode.

  CHECK g_vcode <> i_vcode.

  g_vcode = i_vcode.

  r_changed = abap_true.

ENDMETHOD.


METHOD __get_field_content.

  DATA lr_structmdl           TYPE REF TO if_ish_gui_structure_model.

  CHECK ir_model IS BOUND.

  TRY.
      lr_structmdl ?= ir_model.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  CHECK lr_structmdl->is_field_supported( i_fieldname ) = abap_true.

  CALL METHOD lr_structmdl->get_field_content
    EXPORTING
      i_fieldname = i_fieldname
    CHANGING
      c_content   = c_content.

ENDMETHOD.


METHOD __set_field_content.

  DATA lr_structmdl           TYPE REF TO if_ish_gui_structure_model.

* Initial checking.
  CHECK ir_model IS BOUND.
  CHECK i_fieldname IS NOT INITIAL.

* The given model has to be a structure model.
  TRY.
      lr_structmdl ?= ir_model.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* The field has to be supported by the model.
  CHECK lr_structmdl->is_field_supported( i_fieldname = i_fieldname ) = abap_true.

* Set the field content.
  r_changed = lr_structmdl->set_field_content(
      i_fieldname = i_fieldname
      i_content   = i_content ).

ENDMETHOD.
ENDCLASS.
