class CL_ISH_GUI_APPLICATION definition
  public
  inheriting from CL_ISH_GUI_ELEMENT
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_APPLICATION
*"* do not include other source files here!!!
  type-pools VRM .

  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_GUI_APPLICATION .
  interfaces IF_ISH_GUI_REQUEST_PROCESSOR .
  interfaces IF_ISH_GUI_REQUEST_SENDER .

  aliases CO_UCOMM_BACK
    for IF_ISH_GUI_APPLICATION~CO_UCOMM_BACK .
  aliases CO_UCOMM_CANCEL
    for IF_ISH_GUI_APPLICATION~CO_UCOMM_CANCEL .
  aliases CO_UCOMM_CHECK
    for IF_ISH_GUI_APPLICATION~CO_UCOMM_CHECK .
  aliases CO_UCOMM_CONFIG_LAYOUT
    for IF_ISH_GUI_APPLICATION~CO_UCOMM_CONFIG_LAYOUT .
  aliases CO_UCOMM_DELETE
    for IF_ISH_GUI_APPLICATION~CO_UCOMM_DELETE .
  aliases CO_UCOMM_END
    for IF_ISH_GUI_APPLICATION~CO_UCOMM_END .
  aliases CO_UCOMM_ENTER
    for IF_ISH_GUI_APPLICATION~CO_UCOMM_ENTER .
  aliases CO_UCOMM_SAVE
    for IF_ISH_GUI_APPLICATION~CO_UCOMM_SAVE .
  aliases CO_UCOMM_SWI2DIS
    for IF_ISH_GUI_APPLICATION~CO_UCOMM_SWI2DIS .
  aliases CO_UCOMM_SWI2UPD
    for IF_ISH_GUI_APPLICATION~CO_UCOMM_SWI2UPD .
  aliases CO_UCOMM_TRANSPORT
    for IF_ISH_GUI_APPLICATION~CO_UCOMM_TRANSPORT .
  aliases BUILD_ALV_VARIANT_REPORT
    for IF_ISH_GUI_APPLICATION~BUILD_ALV_VARIANT_REPORT .
  aliases CANCEL_NEXT_MDYEVT_PROC
    for IF_ISH_GUI_APPLICATION~CANCEL_NEXT_MDYEVT_PROC .
  aliases CLEAR_CRSPOS_MESSAGE
    for IF_ISH_GUI_APPLICATION~CLEAR_CRSPOS_MESSAGE .
  aliases DESTROY
    for IF_ISH_GUI_APPLICATION~DESTROY .
  aliases GET_ALV_VARIANT_REPORT_PREFIX
    for IF_ISH_GUI_APPLICATION~GET_ALV_VARIANT_REPORT_PREFIX .
  aliases GET_CRSPOS_MESSAGE
    for IF_ISH_GUI_APPLICATION~GET_CRSPOS_MESSAGE .
  aliases GET_FOCUSSED_VIEW
    for IF_ISH_GUI_APPLICATION~GET_FOCUSSED_VIEW .
  aliases GET_LAYOUT
    for IF_ISH_GUI_APPLICATION~GET_LAYOUT .
  aliases GET_MAIN_CONTROLLER
    for IF_ISH_GUI_APPLICATION~GET_MAIN_CONTROLLER .
  aliases GET_STARTUP_SETTINGS
    for IF_ISH_GUI_APPLICATION~GET_STARTUP_SETTINGS .
  aliases GET_VCODE
    for IF_ISH_GUI_APPLICATION~GET_VCODE .
  aliases IS_DESTROYED
    for IF_ISH_GUI_APPLICATION~IS_DESTROYED .
  aliases IS_EMBEDDED
    for IF_ISH_GUI_APPLICATION~IS_EMBEDDED .
  aliases IS_INITIALIZED
    for IF_ISH_GUI_APPLICATION~IS_INITIALIZED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_GUI_APPLICATION~IS_IN_DESTROY_MODE .
  aliases IS_IN_INITIALIZATION_MODE
    for IF_ISH_GUI_APPLICATION~IS_IN_INITIALIZATION_MODE .
  aliases IS_ISH_SCRM_SUPPORTED
    for IF_ISH_GUI_APPLICATION~IS_ISH_SCRM_SUPPORTED .
  aliases IS_NEXT_MDYEVT_PROC_CANCELLED
    for IF_ISH_GUI_APPLICATION~IS_NEXT_MDYEVT_PROC_CANCELLED .
  aliases IS_PAI_IN_PROCESS
    for IF_ISH_GUI_APPLICATION~IS_PAI_IN_PROCESS .
  aliases IS_PBO_IN_PROCESS
    for IF_ISH_GUI_APPLICATION~IS_PBO_IN_PROCESS .
  aliases IS_RUNNING
    for IF_ISH_GUI_APPLICATION~IS_RUNNING .
  aliases LOAD_LAYOUT
    for IF_ISH_GUI_APPLICATION~LOAD_LAYOUT .
  aliases PROCESS_REQUEST
    for IF_ISH_GUI_APPLICATION~PROCESS_REQUEST .
  aliases RUN
    for IF_ISH_GUI_APPLICATION~RUN .
  aliases SAVE_LAYOUT
    for IF_ISH_GUI_APPLICATION~SAVE_LAYOUT .
  aliases SET_FOCUSSED_VIEW
    for IF_ISH_GUI_APPLICATION~SET_FOCUSSED_VIEW .
  aliases SET_VCODE
    for IF_ISH_GUI_APPLICATION~SET_VCODE .
  aliases EV_AFTER_DESTROY
    for IF_ISH_GUI_APPLICATION~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_GUI_APPLICATION~EV_BEFORE_DESTROY .

  constants CO_DEF_MESSAGES_VIEW_NAME type N1GUI_ELEMENT_NAME value 'MESSAGES_VIEW'. "#EC NOTEXT
  constants CO_UCOMM_CRSPOS type SYUCOMM value '#GUI_CRSPOS'. "#EC NOTEXT
  constants CO_UCOMM_EXIT_BY_CONTROL_EVENT type SYUCOMM value '#GUI_EXIT_BY_CONTROL_EVENT'. "#EC NOTEXT
  constants CO_UCOMM_NOPROC type SYUCOMM value '#GUI_NOPROC'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional .
  methods GET_MAIN_VIEW
    returning
      value(RR_MAIN_VIEW) type ref to IF_ISH_GUI_MDY_VIEW .
protected section.
*"* protected components of class CL_ISH_GUI_APPLICATION
*"* do not include other source files here!!!

  data GR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE .
  data GR_FOCUSSED_VIEW type ref to IF_ISH_GUI_VIEW .
  data GR_LAYOUT type ref to CL_ISH_GUI_APPL_LAYOUT .
  data GR_MAIN_CONTROLLER type ref to IF_ISH_GUI_MAIN_CONTROLLER .
  data GR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING .
  data GR_OKCODE_REQUEST type ref to CL_ISH_GUI_OKCODE_REQUEST .
  data GR_REQUEST_4_ARP type ref to CL_ISH_GUI_REQUEST .
  data GR_RUN_RESULT type ref to CL_ISH_GUI_APPL_RESULT .
  data GR_STARTUP_SETTINGS type ref to CL_ISH_GUI_STARTUP_SETTINGS .
  data GS_CRSPOS_MESSAGE type RN1MESSAGE .
  type-pools ABAP .
  data G_CANCEL_NEXT_MDYEVT_PROC type ABAP_BOOL .
  data G_CONTROL_EVENT_IN_PROCESS type ABAP_BOOL .
  data G_DEFAULT_UCOMM type SYUCOMM .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .
  data G_EMBEDDED type ABAP_BOOL .
  data G_INITIALIZATION_MODE type ABAP_BOOL .
  data G_INITIALIZED type ABAP_BOOL .
  data G_MESSAGES_VIEW_NAME type N1GUI_ELEMENT_NAME .
  data G_PAI_IN_PROCESS type ABAP_BOOL .
  data G_PBO_IN_PROCESS type ABAP_BOOL .
  data G_RUNNING type ABAP_BOOL .
  data G_VCODE type TNDYM-VCODE .

  methods ON_MDY_EXIT
    for event EV_EXIT of IF_ISH_GUI_MDY_VIEW
    importing
      !SENDER .
  methods ON_MESSAGE_CLICK
    for event MESSAGE_CLICK of CL_ISHMED_ERRORHANDLING
    importing
      !E_MESSAGE
      !SENDER .
  methods ON_MESSAGE_FUNCTION
    for event MESSAGE_FUNCTION of CL_ISHMED_ERRORHANDLING
    importing
      !E_UCOMM
      !SENDER .
  methods _ADJUST_TO_LAYOUT
    importing
      !IR_LAYOUT type ref to CL_ISH_GUI_LAYOUT
      !I_CONFIG_RC type ISH_METHOD_RC optional
    returning
      value(RR_MESSAGES) type ref to CL_ISHMED_ERRORHANDLING
    raising
      CX_ISH_STATIC_HANDLER .
  methods _AFTER_COMMAND_REQUEST
    importing
      !IR_COMMAND_REQUEST type ref to CL_ISH_GUI_COMMAND_REQUEST
      !IR_RESPONSE type ref to CL_ISH_GUI_RESPONSE
    changing
      !C_EXIT type ABAP_BOOL .
  methods _AFTER_EVENT_REQUEST
    importing
      !IR_EVENT_REQUEST type ref to CL_ISH_GUI_EVENT_REQUEST
      !IR_RESPONSE type ref to CL_ISH_GUI_RESPONSE optional
    changing
      !C_EXIT type ABAP_BOOL .
  methods _AFTER_PAI
    importing
      !IR_DYNPRO_EVENT type ref to CL_ISH_GUI_DYNPRO_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _AFTER_PAI_MAIN
    importing
      !IR_DYNPRO_EVENT type ref to CL_ISH_GUI_DYNPRO_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _AFTER_PBO
    importing
      !IR_DYNPRO_EVENT type ref to CL_ISH_GUI_DYNPRO_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _AFTER_PBO_MAIN
    importing
      !IR_DYNPRO_EVENT type ref to CL_ISH_GUI_DYNPRO_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _AFTER_RUN .
  methods _ARE_VIEWS_CHANGED
    returning
      value(R_CHANGED) type ABAP_BOOL .
  methods _BEFORE_COMMAND_REQUEST
    importing
      !IR_COMMAND_REQUEST type ref to CL_ISH_GUI_COMMAND_REQUEST
    changing
      !C_NO_FURTHER_PROCESSING type ABAP_BOOL
      !C_EXIT type ABAP_BOOL .
  methods _BEFORE_EVENT_REQUEST
    importing
      !IR_EVENT_REQUEST type ref to CL_ISH_GUI_EVENT_REQUEST
    changing
      !C_NO_FURTHER_PROCESSING type ABAP_BOOL
      !C_EXIT type ABAP_BOOL .
  methods _BEFORE_PAI
    importing
      !IR_DYNPRO_EVENT type ref to CL_ISH_GUI_DYNPRO_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _BEFORE_PAI_MAIN
    importing
      !IR_DYNPRO_EVENT type ref to CL_ISH_GUI_DYNPRO_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _BEFORE_PBO
    importing
      !IR_DYNPRO_EVENT type ref to CL_ISH_GUI_DYNPRO_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _BEFORE_PBO_MAIN
    importing
      !IR_DYNPRO_EVENT type ref to CL_ISH_GUI_DYNPRO_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _BEFORE_RUN
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_LOAD_VIEW_LAYOUT
    importing
      !IR_VIEW type ref to IF_ISH_GUI_VIEW
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER optional
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_USERNAME type USERNAME default SY-UNAME
    returning
      value(R_LOAD) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_SAVE_VIEW_LAYOUT
    importing
      !IR_VIEW type ref to IF_ISH_GUI_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_LAYOUT
      !I_EXPLICIT type ABAP_BOOL
      !I_USERNAME type USERNAME default SY-UNAME
    returning
      value(R_SAVE) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_VIEWS
    returning
      value(RR_RESULT) type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CMD_EXIT_BY_CONTROL_EVENT
    importing
      !IR_COMMAND_REQUEST type ref to CL_ISH_GUI_COMMAND_REQUEST
    returning
      value(R_EXIT) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _COLLECT_EXCEPTION
    importing
      !IR_EXCEPTION type ref to CX_ROOT .
  methods _COLLECT_MESSAGE
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
  methods _COLLECT_MESSAGES
    importing
      !IR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING .
  methods _COLLECT_MESSAGE_BY_SYST
    importing
      !I_TYP type SY-MSGTY default SY-MSGTY
      !I_PAR type BAPIRET2-PARAMETER optional
      !I_ROW type BAPIRET2-ROW optional
      !I_FIELD type BAPIRET2-FIELD optional
      !IR_OBJECT type NOBJECTREF optional
      !I_LINE_KEY type CHAR100 optional .
  methods _CREATE_MAIN_CONTROLLER
  abstract
    returning
      value(RR_MAIN_CONTROLLER) type ref to IF_ISH_GUI_MAIN_CONTROLLER
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CREATE_MESSAGES
    returning
      value(RR_MESSAGES) type ref to CL_ISHMED_ERRORHANDLING .
  methods _CREATE_MESSAGES_VIEW
    returning
      value(RR_MESSAGES_VIEW) type ref to IF_ISH_GUI_CONTAINER_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CREATE_RUN_RESULT
    returning
      value(RR_RESULT) type ref to CL_ISH_GUI_APPL_RESULT
    exceptions
      CX_ISH_STATIC_HANDLER .
  methods _DESTROY .
  methods _DISPLAY_MESSAGES
    returning
      value(R_DISPLAYED) type ABAP_BOOL .
  methods _FINALIZE_RUN_RESULT
    returning
      value(RR_RESULT) type ref to CL_ISH_GUI_APPL_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_LAYOINTKEY
    returning
      value(R_LAYOINTKEY) type N1GUILAYOINTKEY .
  methods _GET_MESSAGES_VIEW
    returning
      value(RR_MESSAGES_VIEW) type ref to IF_ISH_GUI_CONTAINER_VIEW .
  methods _GET_MESSAGES_VIEW_TITLE
    returning
      value(R_TITLE) type LVC_TITLE .
  methods _GET_OKCODEREQ_BY_CONTROLEV
    importing
      !IR_CONTROL_EVENT type ref to CL_ISH_GUI_CONTROL_EVENT
    returning
      value(RR_OKCODE_REQUEST) type ref to CL_ISH_GUI_OKCODE_REQUEST .
  methods _HELP_REQUEST
    importing
      !IR_DYNPRO_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_PROCESSED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  interface IF_ISH_GUI_VIEW load .
  methods _INIT_APPL
    importing
      !I_VCODE type TNDYM-VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
      !IR_LAYOUT type ref to CL_ISH_GUI_APPL_LAYOUT optional
      !I_MESSAGES_VIEW_NAME type N1GUI_ELEMENT_NAME default CO_DEF_MESSAGES_VIEW_NAME
      !I_DEFAULT_UCOMM type SYUCOMM default SPACE
      !I_EMBEDDED type ABAP_BOOL default ABAP_FALSE
      !IR_STARTUP_SETTINGS type ref to CL_ISH_GUI_STARTUP_SETTINGS optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods _PROCESS_COMMAND_REQUEST
    importing
      !IR_COMMAND_REQUEST type ref to CL_ISH_GUI_COMMAND_REQUEST
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROCESS_CONTROL_EVENT
    importing
      !IR_CONTROL_EVENT type ref to CL_ISH_GUI_CONTROL_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROCESS_DYNPRO_EVENT
    importing
      !IR_DYNPRO_EVENT type ref to CL_ISH_GUI_DYNPRO_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROCESS_EVENT_REQUEST
    importing
      !IR_EVENT_REQUEST type ref to CL_ISH_GUI_EVENT_REQUEST
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROCESS_EXCEPTION_EVENT
    importing
      !IR_EXCEPTION_EVENT type ref to CL_ISH_GUI_EXCEPTION_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROCESS_MDY_EVENT
    importing
      !IR_MDY_EVENT type ref to CL_ISH_GUI_MDY_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROCESS_MESSAGE_EVENT
    importing
      !IR_MESSAGE_EVENT type ref to CL_ISH_GUI_MESSAGE_EVENT
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _RUN
  abstract
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SET_VCODE
    importing
      !I_VCODE type ISH_VCODE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _VALUE_REQUEST
    importing
      !IR_DYNPRO_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW
      !I_FIELDNAME type ISH_FIELDNAME
    exporting
      !E_PROCESSED type ABAP_BOOL
      !ET_CHANGED_FIELD type ISH_T_DYNPREAD
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_GUI_APPLICATION
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_APPLICATION IMPLEMENTATION.


METHOD constructor.

  super->constructor( i_element_name = i_element_name ).

  gr_cb_destroyable   = ir_cb_destroyable.

ENDMETHOD.


METHOD get_main_view.

  DATA:
    lr_main_controller          TYPE REF TO if_ish_gui_main_controller.

  lr_main_controller = get_main_controller( ).
  CHECK lr_main_controller IS BOUND.

  rr_main_view = lr_main_controller->get_mdy_view( ).

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


METHOD if_ish_gui_application~build_alv_variant_report.

  DATA l_prefix           TYPE string.
  DATA l_suffix           TYPE string.

  l_prefix = get_alv_variant_report_prefix( ir_view = ir_view ).

  IF ir_view IS BOUND.
    l_suffix = ir_view->get_alv_variant_report_suffix( ).
  ENDIF.

  IF l_prefix IS INITIAL.
    r_report = l_suffix.
  ELSE.
    CONCATENATE
      l_prefix
      l_suffix
      INTO r_report
      SEPARATED BY '.'.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_application~cancel_next_mdyevt_proc.

  g_cancel_next_mdyevt_proc = abap_true.

ENDMETHOD.


METHOD if_ish_gui_application~clear_crspos_message.

  CLEAR: gs_crspos_message.

ENDMETHOD.


METHOD if_ish_gui_application~get_alv_variant_report_prefix.

* By default no prefix.

ENDMETHOD.


METHOD if_ish_gui_application~get_crspos_message.

  rs_crspos_message = gs_crspos_message.

ENDMETHOD.


METHOD if_ish_gui_application~get_focussed_view.

  rr_view = gr_focussed_view.

ENDMETHOD.


METHOD if_ish_gui_application~get_layout.

  rr_layout = gr_layout.

ENDMETHOD.


METHOD if_ish_gui_application~get_main_controller.

  rr_main_controller = gr_main_controller.

ENDMETHOD.


METHOD if_ish_gui_application~get_startup_settings.

  rr_startup_settings = gr_startup_settings.

ENDMETHOD.


METHOD if_ish_gui_application~get_vcode.

  r_vcode = g_vcode.

ENDMETHOD.


METHOD if_ish_gui_application~is_embedded.

  r_embedded = g_embedded.

ENDMETHOD.


METHOD if_ish_gui_application~is_initialized.

  r_initialized = g_initialized.

ENDMETHOD.


METHOD if_ish_gui_application~is_in_initialization_mode.

  r_initialization_mode = g_initialization_mode.

ENDMETHOD.


METHOD if_ish_gui_application~is_ish_scrm_supported.

  r_supported = abap_true.

ENDMETHOD.


METHOD if_ish_gui_application~is_next_mdyevt_proc_cancelled.

  r_cancelled = g_cancel_next_mdyevt_proc.

ENDMETHOD.


METHOD if_ish_gui_application~is_pai_in_process.

  r_pai_in_process = g_pai_in_process.

ENDMETHOD.


METHOD if_ish_gui_application~is_pbo_in_process.

  r_pbo_in_process = g_pbo_in_process.

ENDMETHOD.


METHOD if_ish_gui_application~is_running.

  r_running = g_running.

ENDMETHOD.


METHOD if_ish_gui_application~load_layout.

  DATA l_internal_key               TYPE n1guilayointkey.

* Get the internal key.
  l_internal_key = _get_layointkey( ).

* Load the layout with the specified username.
  rr_layout = cl_ish_gui_layout=>load(
      i_layout_name  = i_layout_name
      i_username     = i_username
      i_internal_key = l_internal_key ).

* If there is no layout for the specified username we try to load the default layout (no username).
  IF rr_layout IS NOT BOUND AND
     i_username IS NOT INITIAL.
    rr_layout = cl_ish_gui_layout=>load(
        i_layout_name  = i_layout_name
        i_internal_key = l_internal_key ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_application~load_view_layout.

  DATA l_layout_name            TYPE n1gui_layout_name.

* The view has to be specified.
  CHECK ir_view IS BOUND.

* Check if the view layout should be loaded.
  CHECK _check_load_view_layout(
      ir_view         = ir_view
      ir_controller   = ir_controller
      ir_parent_view  = ir_parent_view
      i_layout_name   = i_layout_name
      i_username      = i_username ) = abap_true.

* Determine the layout name.
  IF i_layout_name IS INITIAL.
    l_layout_name = ir_view->get_element_name( ).
  ELSE.
    l_layout_name = i_layout_name.
  ENDIF.

* Load the layout.
  rr_layout = load_layout(
      i_layout_name = l_layout_name
      i_username    = i_username ).

ENDMETHOD.


METHOD if_ish_gui_application~run.

* If we are not initialized -> error.
  IF is_initialized( ) = abap_false.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'RUN'
        i_mv3        = 'CL_ISH_GUI_APPLICATION' ).
  ENDIF.

* If we are already running -> error.
  IF is_running( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'RUN'
        i_mv3        = 'CL_ISH_GUI_APPLICATION' ).
  ENDIF.

* We are running.
  g_running = abap_true.

* Create the run result.
  TRY.
      gr_run_result = _create_run_result( ).
    CLEANUP.
      g_running = abap_false.
  ENDTRY.

* Before run.
  TRY.
      _before_run( ).
    CLEANUP.
      CLEAR gr_run_result.
      g_running = abap_false.
  ENDTRY.

* Further processing only if self is not embedded.
  CHECK g_embedded = abap_false.

* Run.
  TRY.
      _run( ).
    CLEANUP.
      _after_run( ).
      CLEAR gr_run_result.
      g_running = abap_false.
  ENDTRY.

* Finalize the result.
  TRY.
      rr_result = _finalize_run_result( ).
    CLEANUP.
      _after_run( ).
      CLEAR gr_run_result.
      g_running = abap_false.
  ENDTRY.

* After run.
  _after_run( ).

* Clear gr_run_result.
  CLEAR gr_run_result.

* We are no more running.
  g_running = abap_false.

ENDMETHOD.


METHOD if_ish_gui_application~save_layout.

  DATA l_internal_key               TYPE n1guilayointkey.

* Process only on given layout.
  CHECK ir_layout IS BOUND.

* Get the internal key.
  l_internal_key = _get_layointkey( ).

* Save the layout.
  ir_layout->save(
      i_username     = i_username
      i_internal_key = l_internal_key
      i_erdat        = i_erdat
      i_ertim        = i_ertim
      i_erusr        = i_erusr ).

* The layout was saved.
  r_saved = abap_true.

ENDMETHOD.


METHOD if_ish_gui_application~save_view_layout.

  DATA lr_layout                    TYPE REF TO cl_ish_gui_layout.

* The view has to be specified.
  CHECK ir_view IS BOUND.

* Actualize the layout.
  ir_view->actualize_layout( ).

* Get the layout.
  lr_layout = ir_view->get_layout( ).
  CHECK lr_layout IS BOUND.

* Check if the layout should be saved.
  CHECK _check_save_view_layout(
      ir_view     = ir_view
      ir_layout   = lr_layout
      i_explicit  = i_explicit
      i_username  = i_username ) = abap_true.

* Save the layout.
  r_saved = save_layout(
      ir_layout  = lr_layout
      i_username = i_username
      i_erdat    = i_erdat
      i_ertim    = i_ertim
      i_erusr    = i_erusr ).

ENDMETHOD.


METHOD if_ish_gui_application~set_focussed_view.

  gr_focussed_view = ir_view.

  r_success = abap_true.

ENDMETHOD.


METHOD if_ish_gui_application~set_vcode.

  r_changed = _set_vcode( i_vcode = i_vcode ).

ENDMETHOD.


METHOD if_ish_gui_request_processor~after_request_processing.

  DATA lr_control_event           TYPE REF TO cl_ish_gui_control_event.
  DATA l_exit                     TYPE abap_bool.

* The request has to be specified.
  CHECK ir_request IS BOUND.

* After control event processing.
  IF gr_request_4_arp = ir_request.
    CLEAR gr_request_4_arp.
    TRY.
        lr_control_event ?= ir_request.
        IF g_control_event_in_process = abap_true.
          CALL METHOD _after_event_request
            EXPORTING
              ir_event_request = lr_control_event
              ir_response      = ir_response
            CHANGING
              c_exit           = l_exit.
          IF l_exit = abap_true.
            process_request(
                ir_request = cl_ish_gui_okcode_request=>create(
                  ir_sender    = me
                  ir_processor = me
                  i_ucomm      = co_ucomm_exit_by_control_event ) ).
          ELSE.
            _display_messages( ).
          ENDIF.
        ENDIF.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_request_processor~process_request.

  DATA lr_event_request               TYPE REF TO cl_ish_gui_event_request.
  DATA lr_mdy_event                   TYPE REF TO cl_ish_gui_mdy_event.
  DATA lr_control_event               TYPE REF TO cl_ish_gui_control_event.
  DATA lr_command_request             TYPE REF TO cl_ish_gui_command_request.
  DATA lr_okcode_request              TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_main_controller             TYPE REF TO if_ish_gui_main_controller.
  DATA lr_main_view                   TYPE REF TO if_ish_gui_mdy_view.
  DATA l_cfw_rc                       TYPE i.
  DATA l_okcode                       TYPE syucomm.
  DATA l_last_ucomm                   TYPE syucomm.
  DATA l_no_further_processing        TYPE abap_bool.
  DATA l_exit                         TYPE abap_bool.

* The request has to be specified.
  CHECK ir_request IS BOUND.

* We have to be running.
  CHECK is_running( ) = abap_true.

* Processing depends on the reqeust type.
  TRY.
*     Event request?
      lr_event_request ?= ir_request.
*     Process mdy events only if not cancelled.
      IF g_cancel_next_mdyevt_proc = abap_true.
        TRY.
            lr_mdy_event ?= lr_event_request.
            g_cancel_next_mdyevt_proc = abap_false.
            rr_response = cl_ish_gui_response=>create(
                ir_request   = ir_request
                ir_processor = me
                i_rc         = cl_ish_gui_response=>co_rc_cancelled
                i_exit       = abap_false ).
            RETURN.
          CATCH cx_sy_move_cast_error.                  "#EC NO_HANDLER
        ENDTRY.
      ENDIF.
*     Handle the run_result.
      IF gr_run_result IS BOUND.
        TRY.
            lr_mdy_event ?= ir_request.
            l_last_ucomm = lr_mdy_event->get_ucomm( ).
            gr_run_result->set_last_ucomm( l_last_ucomm ).
          CATCH cx_sy_move_cast_error.                  "#EC NO_HANDLER
        ENDTRY.
      ENDIF.
*     before_event_request.
      l_no_further_processing = abap_false.
      l_exit = abap_false.
      TRY.
          lr_mdy_event ?= lr_event_request.
          IF lr_mdy_event->is_exit_command( ) = abap_true.
            l_exit = abap_true.
          ENDIF.
        CATCH cx_sy_move_cast_error.                    "#EC NO_HANDLER
      ENDTRY.
      CALL METHOD _before_event_request
        EXPORTING
          ir_event_request        = lr_event_request
        CHANGING
          c_no_further_processing = l_no_further_processing
          c_exit                  = l_exit.
      IF l_no_further_processing = abap_true.
        rr_response = cl_ish_gui_response=>create(
            ir_request    = ir_request
            ir_processor  = me
            i_exit        = l_exit ).
        RETURN.
      ENDIF.
*     Process the event request.
      rr_response = _process_event_request( ir_event_request = lr_event_request ).
*     after_event_request.
      TRY.
          lr_control_event ?= lr_event_request.
        CATCH cx_sy_move_cast_error.
          CLEAR lr_control_event.
      ENDTRY.
      IF lr_control_event IS BOUND.
        gr_request_4_arp = lr_control_event.
      ELSE.
        IF rr_response IS BOUND.
          l_exit = rr_response->get_exit( ).
        ENDIF.
        CALL METHOD _after_event_request
          EXPORTING
            ir_event_request = lr_event_request
            ir_response      = rr_response
          CHANGING
            c_exit           = l_exit.
        IF rr_response IS BOUND.
          rr_response->set_exit( i_exit = l_exit ).
        ELSEIF l_exit = abap_true.
          rr_response = cl_ish_gui_response=>create(
              ir_request    = ir_request
              ir_processor  = me
              i_exit        = l_exit ).
        ENDIF.
      ENDIF.
    CATCH cx_sy_move_cast_error.
      TRY.
*         Command request?
          lr_command_request ?= ir_request.
*         before_command_request.
          l_no_further_processing = abap_false.
          l_exit = abap_false.
          CALL METHOD _before_command_request
            EXPORTING
              ir_command_request      = lr_command_request
            CHANGING
              c_no_further_processing = l_no_further_processing
              c_exit                  = l_exit.
          IF l_no_further_processing = abap_true.
            rr_response = cl_ish_gui_response=>create(
                ir_request    = ir_request
                ir_processor  = me
                i_exit        = l_exit ).
            RETURN.
          ENDIF.
*         First we process the command request ourself.
          rr_response = _process_command_request( ir_command_request = lr_command_request ).
*         If the command request was not processed we propagate it to our main controller.
          IF rr_response IS NOT BOUND.
            lr_main_controller = get_main_controller( ).
            IF lr_main_controller IS BOUND.
              rr_response = lr_main_controller->process_request( ir_request = ir_request ).
            ENDIF.
          ENDIF.
*         after_command_request.
          IF l_exit = abap_false AND
             rr_response IS BOUND.
            l_exit = rr_response->get_exit( ).
          ENDIF.
          CALL METHOD _after_command_request
            EXPORTING
              ir_command_request = lr_command_request
              ir_response        = rr_response
            CHANGING
              c_exit             = l_exit.
          IF rr_response IS BOUND.
            rr_response->set_exit( i_exit = l_exit ).
          ELSEIF l_exit = abap_true.
            rr_response = cl_ish_gui_response=>create(
                ir_request    = ir_request
                ir_processor  = me
                i_exit        = l_exit ).
          ENDIF.
        CATCH cx_sy_move_cast_error.
          TRY.
*             OKCODE request
              lr_okcode_request ?= ir_request.
*             The request has to be valid.
              CHECK lr_okcode_request->get_ucomm( ) IS NOT INITIAL.
              CHECK lr_okcode_request->get_processor( ) IS NOT INITIAL.
*             Raise the new okcode.
*             The okcode request will be processed in method _process_mdy_event.
              l_okcode = lr_okcode_request->get_ucomm( ).
              CALL METHOD cl_gui_cfw=>set_new_ok_code
                EXPORTING
                  new_code = l_okcode
                IMPORTING
                  rc       = l_cfw_rc.
              CHECK l_cfw_rc = cl_gui_cfw=>rc_posted.
*             Create the response.
              rr_response = cl_ish_gui_response=>create( ir_request   = ir_request
                                                         ir_processor = me ).
*             Remember the okcode_request.
              gr_okcode_request = lr_okcode_request.
            CATCH cx_sy_move_cast_error.                "#EC NO_HANDLER
          ENDTRY.
      ENDTRY.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_request_sender~get_okcodereq_by_controlev.

* No propagating.

* Own processing.
  rr_okcode_request = _get_okcodereq_by_controlev( ir_control_event ).

ENDMETHOD.


METHOD on_mdy_exit.

  DATA lr_tmp_messages            TYPE REF TO cl_ishmed_errorhandling.

  CHECK sender IS BOUND.
  CHECK sender = get_main_view( ).

  IF gr_messages IS BOUND.
    CALL METHOD cl_ish_utl_base=>copy_messages
      EXPORTING
        i_copy_from     = gr_messages
      CHANGING
        cr_errorhandler = lr_tmp_messages.
    gr_messages->initialize( ).
    CALL METHOD cl_ish_utl_base=>copy_messages
      EXPORTING
        i_copy_from     = lr_tmp_messages
      CHANGING
        cr_errorhandler = gr_messages.
  ENDIF.

  SET HANDLER on_mdy_exit FOR sender ACTIVATION abap_false.

ENDMETHOD.


METHOD on_message_click.

* Remember the message.
  gs_crspos_message = e_message.

* Set new okcode.
  cl_gui_cfw=>set_new_ok_code( new_code = co_ucomm_crspos ).

ENDMETHOD.


METHOD on_message_function.

  CHECK sender IS BOUND.
  CHECK sender = gr_messages.

  CASE e_ucomm.
    WHEN 'MSG_CLOSED'.
      gr_messages->initialize( ).
**** Start MED-47677 M.Rebegea 18.06.2012
    WHEN 'MSG_ENTER'.
      gr_messages->initialize( ).
**** End MED-47677 M.Rebegea 18.06.2012
  ENDCASE.

ENDMETHOD.


METHOD _adjust_to_layout.

  DATA lr_layout_copy                 TYPE REF TO cl_ish_gui_appl_layout.
  DATA l_copy_use_msg_viewer          TYPE n1gui_appl_use_msg_viewer.

  CHECK ir_layout IS BOUND.
  CHECK gr_layout IS BOUND.

* Process only on appl layout.
  TRY.
      lr_layout_copy ?= ir_layout.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Adjust use_msg_viewer.
  l_copy_use_msg_viewer = lr_layout_copy->get_use_msg_viewer( ).
  gr_layout->set_use_msg_viewer( i_use_msg_viewer = l_copy_use_msg_viewer ).

ENDMETHOD.


METHOD _after_command_request.

  DATA lr_badiappl            TYPE REF TO if_ish_gui_badiappl.
  DATA l_badiapplid           TYPE n1gui_badiapplid.

  DATA lr_okcode_request      TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_control_event       TYPE REF TO cl_ish_gui_control_event.

  DATA lr_drawers_event       TYPE REF TO cl_ish_gui_drawers_event.
  DATA lr_drawers_view        TYPE REF TO if_ish_gui_drawers_view.
  DATA lr_badi_a_drwevent     TYPE REF TO ish_gui_a_drwevent.

  DATA lr_grid_event          TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_grid_view           TYPE REF TO if_ish_gui_grid_view.
  DATA lr_badi_a_gridevent    TYPE REF TO ish_gui_a_gridevent.

  DATA lr_toolbar_event       TYPE REF TO cl_ish_gui_toolbar_event.
  DATA lr_toolbar_view        TYPE REF TO if_ish_gui_toolbar_view.
  DATA lr_badi_a_tbevent      TYPE REF TO ish_gui_a_tbevent.

  DATA lr_tree_event          TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_tree_view           TYPE REF TO if_ish_gui_tree_view.
  DATA lr_badi_a_treeevent    TYPE REF TO ish_gui_a_treeevent.

  DATA lr_badi_a_ucomm        TYPE REF TO ish_gui_a_ucomm.

  DATA lr_messages            TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_root                TYPE REF TO cx_root.

* Initial checking.
  CHECK ir_command_request IS BOUND.

* Self must be a badiappl.
  TRY.
      lr_badiappl ?= me.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
* Get the badiapplid.
  l_badiapplid = lr_badiappl->get_badiapplid( ).
  CHECK l_badiapplid IS NOT INITIAL.

* Call badi after_<control>event
  DO 1 TIMES.
    lr_okcode_request = ir_command_request->get_okcode_request( ).
    CHECK lr_okcode_request IS BOUND.
    DO 1 TIMES.
      lr_control_event = lr_okcode_request->get_control_event( ).
      CHECK lr_control_event IS BOUND.
      CLEAR lr_messages.
*     drawers_event.
      TRY.
          lr_drawers_event ?= lr_control_event.
          TRY.
              lr_drawers_view ?= lr_drawers_event->get_control_view( ).
            CATCH cx_sy_move_cast_error.
              RETURN.
          ENDTRY.
          CHECK lr_drawers_view IS BOUND.
          TRY.
              GET BADI lr_badi_a_drwevent
                FILTERS
                  n1gui_badiapplid = l_badiapplid
                CONTEXT
                  lr_badiappl.
            CATCH cx_badi INTO lx_root.
              _collect_exception( lx_root ).
              RETURN.
          ENDTRY.
          CHECK lr_badi_a_drwevent IS BOUND.
          CALL BADI lr_badi_a_drwevent->after_drawers_event
            EXPORTING
              ir_application   = me
              ir_drawers_event = lr_drawers_event
              ir_drawers_view  = lr_drawers_view
              ir_response      = ir_response
            CHANGING
              c_exit           = c_exit
              cr_messages      = lr_messages.
          _collect_messages( lr_messages ).
        CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
      ENDTRY.
*     grid_event.
      TRY.
          lr_grid_event ?= lr_control_event.
          TRY.
              lr_grid_view ?= lr_grid_event->get_control_view( ).
            CATCH cx_sy_move_cast_error.
              RETURN.
          ENDTRY.
          CHECK lr_grid_view IS BOUND.
          TRY.
              GET BADI lr_badi_a_gridevent
                FILTERS
                  n1gui_badiapplid = l_badiapplid
                CONTEXT
                  lr_badiappl.
            CATCH cx_badi INTO lx_root.
              _collect_exception( lx_root ).
              RETURN.
          ENDTRY.
          CHECK lr_badi_a_gridevent IS BOUND.
          CALL BADI lr_badi_a_gridevent->after_grid_event
            EXPORTING
              ir_application = me
              ir_grid_event  = lr_grid_event
              ir_grid_view   = lr_grid_view
              ir_response    = ir_response
            CHANGING
              c_exit         = c_exit
              cr_messages    = lr_messages.
          _collect_messages( lr_messages ).
        CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
      ENDTRY.
*     toolbar_event.
      TRY.
          lr_toolbar_event ?= lr_control_event.
          TRY.
              lr_toolbar_view ?= lr_toolbar_event->get_control_view( ).
            CATCH cx_sy_move_cast_error.
              RETURN.
          ENDTRY.
          CHECK lr_toolbar_view IS BOUND.
          TRY.
              GET BADI lr_badi_a_tbevent
                FILTERS
                  n1gui_badiapplid = l_badiapplid
                CONTEXT
                  lr_badiappl.
            CATCH cx_badi INTO lx_root.
              _collect_exception( lx_root ).
              RETURN.
          ENDTRY.
          CHECK lr_badi_a_tbevent IS BOUND.
          CALL BADI lr_badi_a_tbevent->after_toolbar_event
            EXPORTING
              ir_application   = me
              ir_toolbar_event = lr_toolbar_event
              ir_toolbar_view  = lr_toolbar_view
              ir_response      = ir_response
            CHANGING
              c_exit           = c_exit
              cr_messages      = lr_messages.
          _collect_messages( lr_messages ).
        CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
      ENDTRY.
*     tree_event.
      TRY.
          lr_tree_event ?= lr_control_event.
          TRY.
              lr_tree_view ?= lr_tree_event->get_control_view( ).
            CATCH cx_sy_move_cast_error.
              RETURN.
          ENDTRY.
          CHECK lr_tree_view IS BOUND.
          TRY.
              GET BADI lr_badi_a_treeevent
                FILTERS
                  n1gui_badiapplid = l_badiapplid
                CONTEXT
                  lr_badiappl.
            CATCH cx_badi INTO lx_root.
              _collect_exception( lx_root ).
              RETURN.
          ENDTRY.
          CHECK lr_badi_a_treeevent IS BOUND.
          CALL BADI lr_badi_a_treeevent->after_tree_event
            EXPORTING
              ir_application = me
              ir_tree_event  = lr_tree_event
              ir_tree_view   = lr_tree_view
              ir_response    = ir_response
            CHANGING
              c_exit         = c_exit
              cr_messages    = lr_messages.
          _collect_messages( lr_messages ).
        CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
      ENDTRY.
    ENDDO.
    RETURN.
  ENDDO.

* Call badi after_user_command
  TRY.
      GET BADI lr_badi_a_ucomm
        FILTERS
          n1gui_badiapplid = l_badiapplid
        CONTEXT
          lr_badiappl.
    CATCH cx_badi INTO lx_root.
      _collect_exception( lx_root ).
      RETURN.
  ENDTRY.
  CHECK lr_badi_a_ucomm IS BOUND.
  CALL BADI lr_badi_a_ucomm->after_user_command
    EXPORTING
      ir_application     = me
      ir_command_request = ir_command_request
      ir_response        = ir_response
    CHANGING
      c_exit             = c_exit
      cr_messages        = lr_messages.
  _collect_messages( lr_messages ).

ENDMETHOD.


METHOD _after_event_request.

  DATA lr_badiappl            TYPE REF TO if_ish_gui_badiappl.
  DATA l_badiapplid           TYPE n1gui_badiapplid.

  DATA lr_dynpro_event        TYPE REF TO cl_ish_gui_dynpro_event.
  DATA lr_dynpro_view         TYPE REF TO if_ish_gui_dynpro_view.
  DATA lr_badi_a_pbo          TYPE REF TO ish_gui_a_pbo.
  DATA l_repid                TYPE syrepid.
  DATA l_dynnr                TYPE sydynnr.

  DATA lr_mdy_event           TYPE REF TO cl_ish_gui_mdy_event.
  DATA lr_badi_a_exitcomm     TYPE REF TO ish_gui_a_exitcomm.

  DATA lr_control_event       TYPE REF TO cl_ish_gui_control_event.

  DATA lr_drawers_event       TYPE REF TO cl_ish_gui_drawers_event.
  DATA lr_drawers_view        TYPE REF TO if_ish_gui_drawers_view.
  DATA lr_badi_a_drwevent     TYPE REF TO ish_gui_a_drwevent.

  DATA lr_grid_event          TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_grid_view           TYPE REF TO if_ish_gui_grid_view.
  DATA lr_badi_a_gridevent    TYPE REF TO ish_gui_a_gridevent.

  DATA lr_toolbar_event       TYPE REF TO cl_ish_gui_toolbar_event.
  DATA lr_toolbar_view        TYPE REF TO if_ish_gui_toolbar_view.
  DATA lr_badi_a_tbevent      TYPE REF TO ish_gui_a_tbevent.

  DATA lr_tree_event          TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_tree_view           TYPE REF TO if_ish_gui_tree_view.
  DATA lr_badi_a_treeevent    TYPE REF TO ish_gui_a_treeevent.

  DATA lr_messages            TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_root                TYPE REF TO cx_root.

* Initial checking.
  CHECK ir_event_request IS BOUND.

* Self must be a badiappl.
  TRY.
      lr_badiappl ?= me.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
* Get the badiapplid.
  l_badiapplid = lr_badiappl->get_badiapplid( ).
  CHECK l_badiapplid IS NOT INITIAL.

* Call badi after_pbo.
  DO 1 TIMES.
    TRY.
        lr_dynpro_event ?= ir_event_request.
      CATCH cx_sy_move_cast_error.
        EXIT.
    ENDTRY.
    TRY.
        lr_dynpro_view ?= lr_dynpro_event->get_sender( ).
      CATCH cx_sy_move_cast_error.
        RETURN.
    ENDTRY.
    IF lr_dynpro_view IS NOT BOUND.
      RETURN.
    ENDIF.
    CASE lr_dynpro_event->get_processing_block( ).
      WHEN cl_ish_gui_dynpro_event=>co_procblock_after_pbo.
        TRY.
            GET BADI lr_badi_a_pbo
              FILTERS
                n1gui_badiapplid = l_badiapplid
              CONTEXT
                lr_badiappl.
          CATCH cx_badi INTO lx_root.
            _collect_exception( lx_root ).
            RETURN.
        ENDTRY.
        IF lr_badi_a_pbo IS NOT BOUND.
          RETURN.
        ENDIF.
        l_repid = lr_dynpro_view->get_repid( ).
        l_dynnr = lr_dynpro_view->get_dynnr( ).
        CALL BADI lr_badi_a_pbo->after_pbo
          EXPORTING
            ir_application = me
            ir_dynpro_view = lr_dynpro_view
            i_repid        = l_repid
            i_dynnr        = l_dynnr
          CHANGING
            cr_messages    = lr_messages.
        _collect_messages( lr_messages ).
    ENDCASE.
    RETURN.
  ENDDO.

* Call badi after_exit_command.
  DO 1 TIMES.
    TRY.
        lr_mdy_event ?= ir_event_request.
      CATCH cx_sy_move_cast_error.
        EXIT.
    ENDTRY.
    TRY.
        GET BADI lr_badi_a_exitcomm
          FILTERS
            n1gui_badiapplid = l_badiapplid
          CONTEXT
            lr_badiappl.
      CATCH cx_badi INTO lx_root.
        _collect_exception( lx_root ).
        RETURN.
    ENDTRY.
    IF lr_badi_a_exitcomm IS NOT BOUND.
      RETURN.
    ENDIF.
    CALL BADI lr_badi_a_exitcomm->after_exit_command
      EXPORTING
        ir_application = me
        ir_mdy_event   = lr_mdy_event
        ir_response    = ir_response
      CHANGING
        c_exit         = c_exit
        cr_messages    = lr_messages.
    _collect_messages( lr_messages ).
  ENDDO.

* Call badi after_<control>event
  DO 1 TIMES.
    TRY.
        lr_control_event ?= ir_event_request.
      CATCH cx_sy_move_cast_error.
        EXIT.
    ENDTRY.
    CLEAR lr_messages.
*   drawers_event.
    TRY.
        lr_drawers_event ?= lr_control_event.
        TRY.
            lr_drawers_view ?= lr_drawers_event->get_control_view( ).
          CATCH cx_sy_move_cast_error.
            RETURN.
        ENDTRY.
        CHECK lr_drawers_view IS BOUND.
        TRY.
            GET BADI lr_badi_a_drwevent
              FILTERS
                n1gui_badiapplid = l_badiapplid
              CONTEXT
                lr_badiappl.
          CATCH cx_badi INTO lx_root.
            _collect_exception( lx_root ).
            RETURN.
        ENDTRY.
        CHECK lr_badi_a_drwevent IS BOUND.
        CALL BADI lr_badi_a_drwevent->after_drawers_event
          EXPORTING
            ir_application   = me
            ir_drawers_event = lr_drawers_event
            ir_drawers_view  = lr_drawers_view
            ir_response      = ir_response
          CHANGING
            c_exit           = c_exit
            cr_messages      = lr_messages.
        _collect_messages( lr_messages ).
      CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
    ENDTRY.
*   grid_event.
    TRY.
        lr_grid_event ?= lr_control_event.
        TRY.
            lr_grid_view ?= lr_grid_event->get_control_view( ).
          CATCH cx_sy_move_cast_error.
            RETURN.
        ENDTRY.
        CHECK lr_grid_view IS BOUND.
        TRY.
            GET BADI lr_badi_a_gridevent
              FILTERS
                n1gui_badiapplid = l_badiapplid
              CONTEXT
                lr_badiappl.
          CATCH cx_badi INTO lx_root.
            _collect_exception( lx_root ).
            RETURN.
        ENDTRY.
        CHECK lr_badi_a_gridevent IS BOUND.
        CALL BADI lr_badi_a_gridevent->after_grid_event
          EXPORTING
            ir_application = me
            ir_grid_event  = lr_grid_event
            ir_grid_view   = lr_grid_view
            ir_response    = ir_response
          CHANGING
            c_exit         = c_exit
            cr_messages    = lr_messages.
        _collect_messages( lr_messages ).
      CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
    ENDTRY.
*   toolbar_event.
    TRY.
        lr_toolbar_event ?= lr_control_event.
        TRY.
            lr_toolbar_view ?= lr_toolbar_event->get_control_view( ).
          CATCH cx_sy_move_cast_error.
            RETURN.
        ENDTRY.
        CHECK lr_toolbar_view IS BOUND.
        TRY.
            GET BADI lr_badi_a_tbevent
              FILTERS
                n1gui_badiapplid = l_badiapplid
              CONTEXT
                lr_badiappl.
          CATCH cx_badi INTO lx_root.
            _collect_exception( lx_root ).
            RETURN.
        ENDTRY.
        CHECK lr_badi_a_tbevent IS BOUND.
        CALL BADI lr_badi_a_tbevent->after_toolbar_event
          EXPORTING
            ir_application   = me
            ir_toolbar_event = lr_toolbar_event
            ir_toolbar_view  = lr_toolbar_view
            ir_response      = ir_response
          CHANGING
            c_exit           = c_exit
            cr_messages      = lr_messages.
        _collect_messages( lr_messages ).
      CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
    ENDTRY.
*   tree_event.
    TRY.
        lr_tree_event ?= lr_control_event.
        TRY.
            lr_tree_view ?= lr_tree_event->get_control_view( ).
          CATCH cx_sy_move_cast_error.
            RETURN.
        ENDTRY.
        CHECK lr_tree_view IS BOUND.
        TRY.
            GET BADI lr_badi_a_treeevent
              FILTERS
                n1gui_badiapplid = l_badiapplid
              CONTEXT
                lr_badiappl.
          CATCH cx_badi INTO lx_root.
            _collect_exception( lx_root ).
            RETURN.
        ENDTRY.
        CHECK lr_badi_a_treeevent IS BOUND.
        CALL BADI lr_badi_a_treeevent->after_tree_event
          EXPORTING
            ir_application = me
            ir_tree_event  = lr_tree_event
            ir_tree_view   = lr_tree_view
            ir_response    = ir_response
          CHANGING
            c_exit         = c_exit
            cr_messages    = lr_messages.
        _collect_messages( lr_messages ).
      CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
    ENDTRY.
    RETURN.
  ENDDO.

ENDMETHOD.


method _AFTER_PAI.
endmethod.


METHOD _after_pai_main.

* PAI processing finished.
  g_pai_in_process = abap_false.

ENDMETHOD.


method _AFTER_PBO.
endmethod.


METHOD _after_pbo_main.

* Create the response.
  rr_response = cl_ish_gui_response=>create( ir_request   = ir_dynpro_event
                                             ir_processor = me ).

* Flush.
  cl_ish_gui_control_view=>flush( ).

* Display the messages.
  _display_messages( ).

* PBO processing finished.
  g_pbo_in_process = abap_false.

ENDMETHOD.


METHOD _after_run.

* Destroy the main controller.
  IF gr_main_controller IS BOUND.
    gr_main_controller->destroy( ).
    CLEAR gr_main_controller.
  ENDIF.

* Deregister the messages eventhandlers.
  IF gr_messages IS BOUND.
    SET HANDLER on_message_click    FOR gr_messages ACTIVATION abap_false.
    SET HANDLER on_message_function FOR gr_messages ACTIVATION abap_false.
  ENDIF.

* Clear the okcode request.
  CLEAR gr_okcode_request.

ENDMETHOD.


METHOD _are_views_changed.

  DATA lr_main_view           TYPE REF TO if_ish_gui_view.

  lr_main_view = get_main_view( ).
  CHECK lr_main_view IS BOUND.

  r_changed = lr_main_view->has_errorfields(
      i_with_child_views = abap_true ).

ENDMETHOD.


METHOD _before_command_request.

  DATA lr_badiappl            TYPE REF TO if_ish_gui_badiappl.
  DATA l_badiapplid           TYPE n1gui_badiapplid.

  DATA lr_okcode_request      TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_control_event       TYPE REF TO cl_ish_gui_control_event.

  DATA lr_drawers_event       TYPE REF TO cl_ish_gui_drawers_event.
  DATA lr_drawers_view        TYPE REF TO if_ish_gui_drawers_view.
  DATA lr_badi_b_drwevent     TYPE REF TO ish_gui_b_drwevent.

  DATA lr_grid_event          TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_grid_view           TYPE REF TO if_ish_gui_grid_view.
  DATA lr_badi_b_gridevent    TYPE REF TO ish_gui_b_gridevent.

  DATA lr_toolbar_event       TYPE REF TO cl_ish_gui_toolbar_event.
  DATA lr_toolbar_view        TYPE REF TO if_ish_gui_toolbar_view.
  DATA lr_badi_b_tbevent      TYPE REF TO ish_gui_b_tbevent.

  DATA lr_tree_event          TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_tree_view           TYPE REF TO if_ish_gui_tree_view.
  DATA lr_badi_b_treeevent    TYPE REF TO ish_gui_b_treeevent.

  DATA lr_badi_b_ucomm        TYPE REF TO ish_gui_b_ucomm.

  DATA lr_messages            TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_root                TYPE REF TO cx_root.

* Initial checking.
  CHECK ir_command_request IS BOUND.

* Self must be a badiappl.
  TRY.
      lr_badiappl ?= me.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
* Get the badiapplid.
  l_badiapplid = lr_badiappl->get_badiapplid( ).
  CHECK l_badiapplid IS NOT INITIAL.

* Call badi before_<control>event
  DO 1 TIMES.
    lr_okcode_request = ir_command_request->get_okcode_request( ).
    CHECK lr_okcode_request IS BOUND.
    DO 1 TIMES.
      lr_control_event = lr_okcode_request->get_control_event( ).
      CHECK lr_control_event IS BOUND.
      CLEAR lr_messages.
*     drawers_event.
      TRY.
          lr_drawers_event ?= lr_control_event.
          TRY.
              lr_drawers_view ?= lr_drawers_event->get_control_view( ).
            CATCH cx_sy_move_cast_error.
              RETURN.
          ENDTRY.
          CHECK lr_drawers_view IS BOUND.
          TRY.
              GET BADI lr_badi_b_drwevent
                FILTERS
                  n1gui_badiapplid = l_badiapplid
                CONTEXT
                  lr_badiappl.
            CATCH cx_badi INTO lx_root.
              _collect_exception( lx_root ).
              RETURN.
          ENDTRY.
          CHECK lr_badi_b_drwevent IS BOUND.
          CALL BADI lr_badi_b_drwevent->before_drawers_event
            EXPORTING
              ir_application          = me
              ir_drawers_event        = lr_drawers_event
              ir_drawers_view         = lr_drawers_view
            CHANGING
              c_no_further_processing = c_no_further_processing
              c_exit                  = c_exit
              cr_messages             = lr_messages.
          _collect_messages( lr_messages ).
        CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
      ENDTRY.
*     grid_event.
      TRY.
          lr_grid_event ?= lr_control_event.
          TRY.
              lr_grid_view ?= lr_grid_event->get_control_view( ).
            CATCH cx_sy_move_cast_error.
              RETURN.
          ENDTRY.
          CHECK lr_grid_view IS BOUND.
          TRY.
              GET BADI lr_badi_b_gridevent
                FILTERS
                  n1gui_badiapplid = l_badiapplid
                CONTEXT
                  lr_badiappl.
            CATCH cx_badi INTO lx_root.
              _collect_exception( lx_root ).
              RETURN.
          ENDTRY.
          CHECK lr_badi_b_gridevent IS BOUND.
          CALL BADI lr_badi_b_gridevent->before_grid_event
            EXPORTING
              ir_application          = me
              ir_grid_event           = lr_grid_event
              ir_grid_view            = lr_grid_view
            CHANGING
              c_no_further_processing = c_no_further_processing
              c_exit                  = c_exit
              cr_messages             = lr_messages.
          _collect_messages( lr_messages ).
        CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
      ENDTRY.
*     toolbar_event.
      TRY.
          lr_toolbar_event ?= lr_control_event.
          TRY.
              lr_toolbar_view ?= lr_toolbar_event->get_control_view( ).
            CATCH cx_sy_move_cast_error.
              RETURN.
          ENDTRY.
          CHECK lr_toolbar_view IS BOUND.
          TRY.
              GET BADI lr_badi_b_tbevent
                FILTERS
                  n1gui_badiapplid = l_badiapplid
                CONTEXT
                  lr_badiappl.
            CATCH cx_badi INTO lx_root.
              _collect_exception( lx_root ).
              RETURN.
          ENDTRY.
          CHECK lr_badi_b_tbevent IS BOUND.
          CALL BADI lr_badi_b_tbevent->before_toolbar_event
            EXPORTING
              ir_application          = me
              ir_toolbar_event        = lr_toolbar_event
              ir_toolbar_view         = lr_toolbar_view
            CHANGING
              c_no_further_processing = c_no_further_processing
              c_exit                  = c_exit
              cr_messages             = lr_messages.
          _collect_messages( lr_messages ).
        CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
      ENDTRY.
*     tree_event.
      TRY.
          lr_tree_event ?= lr_control_event.
          TRY.
              lr_tree_view ?= lr_tree_event->get_control_view( ).
            CATCH cx_sy_move_cast_error.
              RETURN.
          ENDTRY.
          CHECK lr_tree_view IS BOUND.
          TRY.
              GET BADI lr_badi_b_treeevent
                FILTERS
                  n1gui_badiapplid = l_badiapplid
                CONTEXT
                  lr_badiappl.
            CATCH cx_badi INTO lx_root.
              _collect_exception( lx_root ).
              RETURN.
          ENDTRY.
          CHECK lr_badi_b_treeevent IS BOUND.
          CALL BADI lr_badi_b_treeevent->before_tree_event
            EXPORTING
              ir_application          = me
              ir_tree_event           = lr_tree_event
              ir_tree_view            = lr_tree_view
            CHANGING
              c_no_further_processing = c_no_further_processing
              c_exit                  = c_exit
              cr_messages             = lr_messages.
          _collect_messages( lr_messages ).
        CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
      ENDTRY.
    ENDDO.
    RETURN.
  ENDDO.

* Call badi before_user_command
  TRY.
      GET BADI lr_badi_b_ucomm
        FILTERS
          n1gui_badiapplid = l_badiapplid
        CONTEXT
          lr_badiappl.
    CATCH cx_badi INTO lx_root.
      _collect_exception( lx_root ).
      RETURN.
  ENDTRY.
  CHECK lr_badi_b_ucomm IS BOUND.
  CALL BADI lr_badi_b_ucomm->before_user_command
    EXPORTING
      ir_application          = me
      ir_command_request      = ir_command_request
    CHANGING
      c_no_further_processing = c_no_further_processing
      c_exit                  = c_exit
      cr_messages             = lr_messages.
  _collect_messages( lr_messages ).

ENDMETHOD.


METHOD _before_event_request.

  DATA lr_control_event       TYPE REF TO cl_ish_gui_control_event.
  DATA lr_sender              TYPE REF TO if_ish_gui_request_sender.
  DATA lr_okcode_request      TYPE REF TO cl_ish_gui_okcode_request.

  DATA lr_badiappl            TYPE REF TO if_ish_gui_badiappl.
  DATA l_badiapplid           TYPE n1gui_badiapplid.

  DATA lr_mdy_event           TYPE REF TO cl_ish_gui_mdy_event.
  DATA lr_badi_b_exitcomm     TYPE REF TO ish_gui_b_exitcomm.

  DATA lr_drawers_event       TYPE REF TO cl_ish_gui_drawers_event.
  DATA lr_drawers_view        TYPE REF TO if_ish_gui_drawers_view.
  DATA lr_badi_b_drwevent     TYPE REF TO ish_gui_b_drwevent.

  DATA lr_grid_event          TYPE REF TO cl_ish_gui_grid_event.
  DATA lr_grid_view           TYPE REF TO if_ish_gui_grid_view.
  DATA lr_badi_b_gridevent    TYPE REF TO ish_gui_b_gridevent.

  DATA lr_toolbar_event       TYPE REF TO cl_ish_gui_toolbar_event.
  DATA lr_toolbar_view        TYPE REF TO if_ish_gui_toolbar_view.
  DATA lr_badi_b_tbevent      TYPE REF TO ish_gui_b_tbevent.

  DATA lr_tree_event          TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_tree_view           TYPE REF TO if_ish_gui_tree_view.
  DATA lr_badi_b_treeevent    TYPE REF TO ish_gui_b_treeevent.

  DATA lr_messages            TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_root                TYPE REF TO cx_root.

* Initial checking.
  CHECK ir_event_request IS BOUND.

* On control_event we have to determine if the control_event is processed right now or after pai.
  DO 1 TIMES.
    TRY.
        lr_control_event ?= ir_event_request.
      CATCH cx_sy_move_cast_error.
        EXIT.
    ENDTRY.
    lr_sender = lr_control_event->get_sender( ).
    CHECK lr_sender IS BOUND.
    lr_okcode_request = lr_sender->get_okcodereq_by_controlev( lr_control_event ).
    CHECK lr_okcode_request IS BOUND.
    process_request( ir_request = lr_okcode_request ).
    c_no_further_processing = abap_true.
    c_exit = abap_false.
    RETURN.
  ENDDO.

* Self must be a badiappl.
  TRY.
      lr_badiappl ?= me.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
* Get the badiapplid.
  l_badiapplid = lr_badiappl->get_badiapplid( ).
  CHECK l_badiapplid IS NOT INITIAL.

* Call badi before_exit_command.
  DO 1 TIMES.
    TRY.
        lr_mdy_event ?= ir_event_request.
      CATCH cx_sy_move_cast_error.
        EXIT.
    ENDTRY.
    DO 1 TIMES.
      TRY.
          GET BADI lr_badi_b_exitcomm
            FILTERS
              n1gui_badiapplid = l_badiapplid
            CONTEXT
              lr_badiappl.
        CATCH cx_badi INTO lx_root.
          _collect_exception( lx_root ).
          RETURN.
      ENDTRY.
      CHECK lr_badi_b_exitcomm IS BOUND.
      CALL BADI lr_badi_b_exitcomm->before_exit_command
        EXPORTING
          ir_application          = me
          ir_mdy_event            = lr_mdy_event
        CHANGING
          c_no_further_processing = c_no_further_processing
          c_exit                  = c_exit
          cr_messages             = lr_messages.
      _collect_messages( lr_messages ).
    ENDDO.
    RETURN.
  ENDDO.

* Call badi before_<control>event
  DO 1 TIMES.
    TRY.
        lr_control_event ?= ir_event_request.
      CATCH cx_sy_move_cast_error.
        EXIT.
    ENDTRY.
    CLEAR lr_messages.
*   drawers_event.
    TRY.
        lr_drawers_event ?= lr_control_event.
        TRY.
            lr_drawers_view ?= lr_drawers_event->get_control_view( ).
          CATCH cx_sy_move_cast_error.
            RETURN.
        ENDTRY.
        CHECK lr_drawers_view IS BOUND.
        TRY.
            GET BADI lr_badi_b_drwevent
              FILTERS
                n1gui_badiapplid = l_badiapplid
              CONTEXT
                lr_badiappl.
          CATCH cx_badi INTO lx_root.
            _collect_exception( lx_root ).
            RETURN.
        ENDTRY.
        CHECK lr_badi_b_drwevent IS BOUND.
        CALL BADI lr_badi_b_drwevent->before_drawers_event
          EXPORTING
            ir_application          = me
            ir_drawers_event        = lr_drawers_event
            ir_drawers_view         = lr_drawers_view
          CHANGING
            c_no_further_processing = c_no_further_processing
            c_exit                  = c_exit
            cr_messages             = lr_messages.
        _collect_messages( lr_messages ).
      CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
    ENDTRY.
*   grid_event.
    TRY.
        lr_grid_event ?= lr_control_event.
        TRY.
            lr_grid_view ?= lr_grid_event->get_control_view( ).
          CATCH cx_sy_move_cast_error.
            RETURN.
        ENDTRY.
        CHECK lr_grid_view IS BOUND.
        TRY.
            GET BADI lr_badi_b_gridevent
              FILTERS
                n1gui_badiapplid = l_badiapplid
              CONTEXT
                lr_badiappl.
          CATCH cx_badi INTO lx_root.
            _collect_exception( lx_root ).
            RETURN.
        ENDTRY.
        CHECK lr_badi_b_gridevent IS BOUND.
        CALL BADI lr_badi_b_gridevent->before_grid_event
          EXPORTING
            ir_application          = me
            ir_grid_event           = lr_grid_event
            ir_grid_view            = lr_grid_view
          CHANGING
            c_no_further_processing = c_no_further_processing
            c_exit                  = c_exit
            cr_messages             = lr_messages.
        _collect_messages( lr_messages ).
      CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
    ENDTRY.
*   toolbar_event.
    TRY.
        lr_toolbar_event ?= lr_control_event.
        TRY.
            lr_toolbar_view ?= lr_toolbar_event->get_control_view( ).
          CATCH cx_sy_move_cast_error.
            RETURN.
        ENDTRY.
        CHECK lr_toolbar_view IS BOUND.
        TRY.
            GET BADI lr_badi_b_tbevent
              FILTERS
                n1gui_badiapplid = l_badiapplid
              CONTEXT
                lr_badiappl.
          CATCH cx_badi INTO lx_root.
            _collect_exception( lx_root ).
            RETURN.
        ENDTRY.
        CHECK lr_badi_b_tbevent IS BOUND.
        CALL BADI lr_badi_b_tbevent->before_toolbar_event
          EXPORTING
            ir_application          = me
            ir_toolbar_event        = lr_toolbar_event
            ir_toolbar_view         = lr_toolbar_view
          CHANGING
            c_no_further_processing = c_no_further_processing
            c_exit                  = c_exit
            cr_messages             = lr_messages.
        _collect_messages( lr_messages ).
      CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
    ENDTRY.
*   tree_event.
    TRY.
        lr_tree_event ?= lr_control_event.
        TRY.
            lr_tree_view ?= lr_tree_event->get_control_view( ).
          CATCH cx_sy_move_cast_error.
            RETURN.
        ENDTRY.
        CHECK lr_tree_view IS BOUND.
        TRY.
            GET BADI lr_badi_b_treeevent
              FILTERS
                n1gui_badiapplid = l_badiapplid
              CONTEXT
                lr_badiappl.
          CATCH cx_badi INTO lx_root.
            _collect_exception( lx_root ).
            RETURN.
        ENDTRY.
        CHECK lr_badi_b_treeevent IS BOUND.
        CALL BADI lr_badi_b_treeevent->before_tree_event
          EXPORTING
            ir_application          = me
            ir_tree_event           = lr_tree_event
            ir_tree_view            = lr_tree_view
          CHANGING
            c_no_further_processing = c_no_further_processing
            c_exit                  = c_exit
            cr_messages             = lr_messages.
        _collect_messages( lr_messages ).
      CATCH cx_sy_move_cast_error.  "#EC_NOHANDLER
    ENDTRY.
    RETURN.
  ENDDO.

ENDMETHOD.


method _BEFORE_PAI.
endmethod.


METHOD _before_pai_main.

  DATA l_initialize_messages            TYPE abap_bool.

* PAI is in process.
  g_pai_in_process = abap_true.

* ControlEvent is not in process.
  g_control_event_in_process = abap_false.

* Create the response.
  rr_response = cl_ish_gui_response=>create( ir_request   = ir_dynpro_event
                                             ir_processor = me ).

* Initialize the messages.
* If we have a valid default_ucomm and the actual ucomm is initial
* we must not initialize the messages.
  l_initialize_messages = abap_false.
  DO 1 TIMES.
    CHECK gr_messages IS BOUND.
    l_initialize_messages = abap_true.
    CHECK ir_dynpro_event IS BOUND.
    CASE ir_dynpro_event->get_ucomm( ).
      WHEN co_ucomm_crspos OR
           co_ucomm_exit_by_control_event.
        l_initialize_messages = abap_false.
      WHEN space OR
           co_ucomm_noproc.
        IF g_default_ucomm IS NOT INITIAL.
          l_initialize_messages = abap_false.
        ENDIF.
    ENDCASE.
  ENDDO.
  IF l_initialize_messages = abap_true.
    gr_messages->initialize( ).
  ENDIF.

* Start gui controls eventhandling.
  cl_ish_gui_control_view=>dispatch( ).

ENDMETHOD.


method _BEFORE_PBO.
endmethod.


METHOD _before_pbo_main.

* PBO is in process.
  g_pbo_in_process = abap_true.

ENDMETHOD.


METHOD _before_run.

  DATA lr_mdy_view                  TYPE REF TO if_ish_gui_mdy_view.
  DATA lt_exclfunc                  TYPE syucomm_t.
  DATA lt_pfstatname                TYPE ish_t_gui_mdypfstatname_hash.
  DATA lt_pfstatus                  TYPE HASHED TABLE OF REF TO cl_ish_gui_mdy_pfstatus
                                          WITH UNIQUE KEY table_line.
  DATA lr_pfstatus                  TYPE REF TO cl_ish_gui_mdy_pfstatus.

  FIELD-SYMBOLS <ls_pfstatname>     TYPE rn1_gui_mdypfstatname_hash.
  FIELD-SYMBOLS <l_exclfunc>        TYPE syucomm.

* Create the main controller.
  gr_main_controller = _create_main_controller( ).

* Register the ev_exit event of the mdy_view.
  IF gr_main_controller IS BOUND.
    lr_mdy_view = gr_main_controller->get_mdy_view( ).
    IF lr_mdy_view IS BOUND.
      SET HANDLER on_mdy_exit FOR lr_mdy_view ACTIVATION abap_true.
    ENDIF.
  ENDIF.

* Handle the excluding functions of the layout.
  DO 1 TIMES.
    CHECK lr_mdy_view IS BOUND.
    CHECK gr_layout IS BOUND.
    lt_exclfunc = gr_layout->get_t_exclfunc( ).
    CHECK lt_exclfunc IS NOT INITIAL.
    lt_pfstatname = lr_mdy_view->get_t_pfstatus( ).
    LOOP AT lt_pfstatname ASSIGNING <ls_pfstatname>.
      CHECK <ls_pfstatname>-r_pfstatus IS BOUND.
      INSERT <ls_pfstatname>-r_pfstatus INTO TABLE lt_pfstatus.
    ENDLOOP.
    lr_pfstatus = lr_mdy_view->get_pfstatus( ).
    IF lr_pfstatus IS BOUND.
      INSERT lr_pfstatus INTO TABLE lt_pfstatus.
    ENDIF.
    LOOP AT lt_pfstatus INTO lr_pfstatus.
      CHECK lr_pfstatus IS BOUND.
      LOOP AT lt_exclfunc ASSIGNING <l_exclfunc>.
        lr_pfstatus->add_excluding_function( <l_exclfunc> ).
      ENDLOOP.
    ENDLOOP.
  ENDDO.

* Create the messages view.
  IF gr_layout IS BOUND AND
     gr_layout->get_use_msg_viewer( ) = abap_true.
    _create_messages_view( ).
  ENDIF.

* Create the messages object.
  gr_messages = _create_messages( ).

ENDMETHOD.


METHOD _check_load_view_layout.

* The view has to be specified.
  CHECK ir_view IS BOUND.

* Load the layout.
  r_load = abap_true.

ENDMETHOD.


METHOD _check_save_view_layout.

* No implicit layout saving by default.
  CHECK i_explicit = abap_true.

* The view has to be specified.
  CHECK ir_view IS BOUND.

* The view has to belong to self.
  CHECK ir_view->get_application( ) = me.

* The layout has to be specified.
  CHECK ir_layout IS BOUND.

* Save the layout.
  r_save = abap_true.

ENDMETHOD.


METHOD _check_views.

  DATA lr_main_view           TYPE REF TO if_ish_gui_view.
  DATA lr_messages            TYPE REF TO cl_ishmed_errorhandling.

  lr_main_view = get_main_view( ).
  CHECK lr_main_view IS BOUND.

  lr_messages = lr_main_view->get_errorfield_messages(
      i_with_child_views  = abap_true ).
  CHECK lr_messages IS BOUND.

  CREATE OBJECT rr_result
    EXPORTING
      i_rc        = 1
      ir_messages = lr_messages.

ENDMETHOD.


METHOD _cmd_exit_by_control_event.

  r_exit = abap_true.

ENDMETHOD.


METHOD _collect_exception.

  DATA:
    lr_messages            TYPE REF TO cl_ishmed_errorhandling.

* The exception has to be specified.
  CHECK ir_exception IS BOUND.

* Create the messages object.
  lr_messages = _create_messages( ).
  CHECK lr_messages IS BOUND.

* Collect the messages of the given exception.
  CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
    EXPORTING
      i_exceptions    = ir_exception
    CHANGING
      cr_errorhandler = lr_messages.

ENDMETHOD.


METHOD _collect_message .

  DATA:
    lr_messages            TYPE REF TO cl_ishmed_errorhandling.

* Collect only valid messages.
  CHECK i_typ IS NOT INITIAL.
  CHECK i_kla IS NOT INITIAL.
  CHECK i_num IS NOT INITIAL.

* Create the messages object.
  lr_messages = _create_messages( ).
  CHECK lr_messages IS BOUND.

* Collect the message.
  lr_messages->collect_messages( i_typ        = i_typ
                                 i_kla        = i_kla
                                 i_num        = i_num
                                 i_mv1        = i_mv1
                                 i_mv2        = i_mv2
                                 i_mv3        = i_mv3
                                 i_mv4        = i_mv4
                                 i_par        = i_par
                                 i_row        = i_row
                                 i_fld        = i_field
                                 i_last       = space
                                 i_object     = ir_object
                                 i_line_key   = i_line_key
                                 ir_error_obj = ir_error_obj ).

ENDMETHOD.


METHOD _collect_messages.

  DATA:
    lr_messages            TYPE REF TO cl_ishmed_errorhandling.

* The messages have to be specified.
  CHECK ir_messages IS BOUND.

* Create the messages object.
  lr_messages = _create_messages( ).
  CHECK lr_messages IS BOUND.

* Copy the given messages.
  lr_messages->copy_messages( i_copy_from = ir_messages ).

ENDMETHOD.


METHOD _collect_message_by_syst .

  DATA:
    lr_messages            TYPE REF TO cl_ishmed_errorhandling.

* Collect only valid messages.
  CHECK i_typ    IS NOT INITIAL.
  CHECK sy-msgid IS NOT INITIAL.
  CHECK sy-msgno IS NOT INITIAL.

* Create the messages object.
  lr_messages = _create_messages( ).
  CHECK lr_messages IS BOUND.

* Collect the message.
  lr_messages->collect_messages( i_typ      = i_typ
                                 i_kla      = sy-msgid
                                 i_num      = sy-msgno
                                 i_mv1      = sy-msgv1
                                 i_mv2      = sy-msgv2
                                 i_mv3      = sy-msgv3
                                 i_mv4      = sy-msgv4
                                 i_par      = i_par
                                 i_row      = i_row
                                 i_fld      = i_field
                                 i_last     = space
                                 i_object   = ir_object
                                 i_line_key = i_line_key ).

ENDMETHOD.


METHOD _create_messages.

  DATA:
    l_popup_static            TYPE abap_bool.

* Process only if the messages object was not already created.
  rr_messages = gr_messages.
  CHECK gr_messages IS NOT BOUND.

* Create the messages object.
*  IF _get_messages_view( ) IS BOUND.
    l_popup_static = abap_false.
*  ELSE.
*    l_popup_static = abap_true.
*  ENDIF.
  CREATE OBJECT gr_messages
    EXPORTING
      i_popup_static = l_popup_static.

* Register the eventhandlers for the messages object.
  SET HANDLER on_message_click     FOR gr_messages ACTIVATION abap_true.
  SET HANDLER on_message_function  FOR gr_messages ACTIVATION abap_true.

* Export.
  rr_messages = gr_messages.

ENDMETHOD.


METHOD _create_messages_view.

  DATA:
    lr_main_controller            TYPE REF TO if_ish_gui_main_controller,
    lr_main_view                  TYPE REF TO if_ish_gui_mdy_view,
    lr_messages_layout            TYPE REF TO cl_ish_gui_dockcont_layout,
    lr_messages_view              TYPE REF TO cl_ish_gui_dockcont_view.

* Process only if we do not already have the messages view.
  rr_messages_view = _get_messages_view( ).
  CHECK rr_messages_view IS NOT BOUND.

* Process only on valid messages view name.
  CHECK g_messages_view_name IS NOT INITIAL.

* The messages view can only be created if we have a main controller and main view.
  lr_main_controller = get_main_controller( ).
  CHECK lr_main_controller IS BOUND.
  lr_main_view = get_main_view( ).
  CHECK lr_main_view IS BOUND.

* Create the messages layout.
  CREATE OBJECT lr_messages_layout
    EXPORTING
      i_element_name = g_messages_view_name
      i_side         = cl_gui_docking_container=>dock_at_bottom
      i_extension    = 70.

* Create the messages view.
  lr_messages_view = cl_ish_gui_dockcont_view=>create( i_element_name = g_messages_view_name ).

* Initialize the messages view.
  TRY.
      lr_messages_view->initialize( ir_controller  = lr_main_controller
                                    ir_parent_view = lr_main_view
                                    ir_layout      = lr_messages_layout
                                    i_vcode        = g_vcode ).
    CLEANUP.
      lr_messages_view->destroy( ).
  ENDTRY.

* Export.
  rr_messages_view = lr_messages_view.

ENDMETHOD.


METHOD _create_run_result.

  CREATE OBJECT rr_result.

ENDMETHOD.


METHOD _destroy.

  DATA lr_main_view           TYPE REF TO if_ish_gui_mdy_view.

* Deregister the mdy_view events.
  lr_main_view = get_main_view( ).
  IF lr_main_view IS BOUND.
    SET HANDLER on_mdy_exit FOR lr_main_view ACTIVATION abap_false.
  ENDIF.

* Destroy the messages object.
  IF gr_messages IS BOUND.
    SET HANDLER on_message_click    FOR gr_messages ACTIVATION abap_false.
    SET HANDLER on_message_function FOR gr_messages ACTIVATION abap_false.
    gr_messages->initialize( ).
    CLEAR gr_messages.
  ENDIF.

* Destroy the main controller
  IF gr_main_controller IS BOUND.
    gr_main_controller->destroy( ).
    CLEAR gr_main_controller.
  ENDIF.

* Clear attributes.
  CLEAR gr_cb_destroyable.
  CLEAR gr_focussed_view.
  CLEAR gr_layout.
  CLEAR gr_okcode_request.
  CLEAR gr_request_4_arp.
  CLEAR gr_run_result.
  g_vcode    = if_ish_gui_view=>co_vcode_display.

ENDMETHOD.


METHOD _display_messages.

  DATA lr_main_view               TYPE REF TO if_ish_gui_mdy_view.
  DATA lr_messages_view           TYPE REF TO if_ish_gui_container_view.
  DATA lr_messages_container      TYPE REF TO cl_gui_container.
  DATA lt_msg                     TYPE ishmed_t_messages.
  DATA l_caption                  TYPE lvc_title.
  DATA l_maxty                    TYPE ish_bapiretmaxty.
  DATA l_send_if_one              TYPE c.
  DATA l_amodal                   TYPE abap_bool.

* Get the messages.
* Get the maxtype.
  IF gr_messages IS BOUND.
    CALL METHOD gr_messages->get_messages
      IMPORTING
        t_extended_msg = lt_msg.
    CALL METHOD gr_messages->get_max_errortype
      IMPORTING
        e_maxty = l_maxty.
  ENDIF.

* Calculate send_if_one.
  IF lines( lt_msg ) = 1 AND
     l_maxty = 'S'.
    l_send_if_one = 'X'.
  ELSE.
    l_send_if_one = '*'.
  ENDIF.

* Get the messages view.
  lr_messages_view = _get_messages_view( ).

* Create the messages view if it should be used.
* Destroy the messages view if it should not be used.
  IF gr_layout IS BOUND AND
     gr_layout->get_use_msg_viewer( ) = abap_true.
    IF lr_messages_view IS NOT BOUND.
      TRY.
          lr_messages_view = _create_messages_view( ).
        CATCH cx_ish_static_handler.                    "#EC NO_HANDLER
      ENDTRY.
    ENDIF.
  ELSE.
    IF lr_messages_view IS BOUND.
      TRY.
          lr_messages_view->set_visibility( i_visible = abap_false ).
        CATCH cx_ish_static_handler.
          lr_messages_view->destroy( ).
      ENDTRY.
      CLEAR: lr_messages_view.
    ENDIF.
  ENDIF.

* Show/hide the messages view.
  IF lr_messages_view IS BOUND.
    TRY.
        IF lt_msg IS INITIAL OR
           l_send_if_one = 'X'.
          IF lr_messages_view->is_first_display_done( ) = abap_true.
            lr_messages_view->set_visibility( i_visible = abap_false ).
          ENDIF.
        ELSE.
          IF lr_messages_view->is_first_display_done( ) = abap_false.
            lr_messages_view->first_display( ).
          ELSE.
            lr_messages_view->set_visibility( i_visible = abap_true ).
          ENDIF.
          lr_messages_container = lr_messages_view->get_container( ).
          IF lr_messages_container IS NOT BOUND.
            lr_messages_view->destroy( ).
            CLEAR: lr_messages_view.
          ENDIF.
        ENDIF.
      CATCH cx_ish_static_handler.
        lr_messages_view->destroy( ).
        CLEAR:
          lr_messages_view,
          lr_messages_container.
    ENDTRY.
  ENDIF.

* Further processing only if we have messages.
  CHECK gr_messages IS BOUND.
  CHECK lt_msg IS NOT INITIAL.

* Display the messages.
  IF lr_messages_container IS BOUND.
    l_caption = _get_messages_view_title( ).
  ENDIF.
  IF l_send_if_one = 'X'.
    l_amodal = abap_false.
  ELSE.
    l_amodal = abap_true.
  ENDIF.
  gr_messages->display_messages(
      i_amodal      = l_amodal
      i_parent      = lr_messages_container
      i_caption     = l_caption
      i_send_if_one = l_send_if_one ).

* Messages were displayed.
  IF l_send_if_one = '*'.
    r_displayed = abap_true.
  ENDIF.

ENDMETHOD.


METHOD _finalize_run_result.

  rr_result = gr_run_result.

ENDMETHOD.


METHOD _get_layointkey.

* The default implementation uses the applications element_name as internal layout key.
  r_layointkey = get_element_name( ).

ENDMETHOD.


METHOD _get_messages_view.

  DATA:
    lr_main_view            TYPE REF TO if_ish_gui_mdy_view.

  CHECK g_messages_view_name IS NOT INITIAL.

  lr_main_view = get_main_view( ).
  CHECK lr_main_view IS BOUND.

  TRY.
      rr_messages_view ?= lr_main_view->get_child_view_by_name( i_view_name = g_messages_view_name ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD _get_messages_view_title.

  r_title = 'Meldungen'(001).

ENDMETHOD.


METHOD _get_okcodereq_by_controlev.

* By default control events are processed without pai.
* Redefine this method if a control event has to be processed after pai.

ENDMETHOD.


method _HELP_REQUEST.
endmethod.


METHOD _init_appl.

* Initialize attributes.
  g_vcode               = i_vcode.
  gr_layout             = ir_layout.
  g_messages_view_name  = i_messages_view_name.
  g_default_ucomm       = i_default_ucomm.
  g_embedded            = i_embedded.
  gr_startup_settings   = ir_startup_settings.

* Set self as the layout's application.
  IF gr_layout IS BOUND.
    gr_layout->set_application( ir_application = me ).
  ENDIF.

ENDMETHOD.


METHOD _process_command_request.

  DATA l_exit           TYPE abap_bool.
  DATA lx_root          TYPE REF TO cx_root.

  CHECK ir_command_request IS BOUND.

  TRY.
      CASE ir_command_request->get_fcode( ).
        WHEN co_ucomm_exit_by_control_event.
          l_exit = _cmd_exit_by_control_event( ir_command_request = ir_command_request ).
        WHEN OTHERS.
          RETURN.
      ENDCASE.
    CATCH cx_ish_static_handler INTO lx_root.
      _collect_exception( lx_root ).
      rr_response = cl_ish_gui_response=>create(
          ir_request   = ir_command_request
          ir_processor = me
          i_exit       = abap_false ).
      RETURN.
  ENDTRY.

  rr_response = cl_ish_gui_response=>create(
      ir_request   = ir_command_request
      ir_processor = me
      i_exit       = l_exit ).

ENDMETHOD.


METHOD _process_control_event.

  DATA lr_messages_view                   TYPE REF TO if_ish_gui_control_view.
  DATA l_set_new_okcode                   TYPE abap_bool.

  CHECK ir_control_event IS BOUND.

* We are in control event processing.
  g_control_event_in_process = abap_true.

* Further processing only if the control_event is a startup action.
  CHECK ir_control_event->is_startup_action( ) = abap_true.

* On starting control_event processing we have to initialize the messages.
* If the message_viewer is used and visible we have to raise a new okcode to adjust the dynpro.
  IF g_pai_in_process = abap_false AND
     g_pbo_in_process = abap_false.
    lr_messages_view = _get_messages_view( ).
    IF lr_messages_view IS BOUND AND
       lr_messages_view->get_visibility( ) = abap_true.
      l_set_new_okcode = abap_true.
    ENDIF.
  ENDIF.
  IF gr_messages IS BOUND.
    gr_messages->initialize( ).
  ENDIF.
  _display_messages( ).
  IF l_set_new_okcode = abap_true.
    CALL METHOD cl_gui_cfw=>set_new_ok_code
      EXPORTING
        new_code = co_ucomm_noproc.
  ENDIF.

ENDMETHOD.


METHOD _process_dynpro_event.

  DATA:
    lr_dynpro_value_event            TYPE REF TO cl_ish_gui_dynpro_value_event,
    lr_dynpro_help_event             TYPE REF TO cl_ish_gui_dynpro_help_event,
    l_processed                      TYPE abap_bool,
    lt_changed_field                 TYPE ish_t_dynpread,
    lr_messages                      TYPE REF TO cl_ishmed_errorhandling,
    lx_root                          TYPE REF TO cx_root,
    lr_dynpro_view                   TYPE REF TO if_ish_gui_dynpro_view,
    l_fieldname                      TYPE ish_fieldname,
    l_repid                          TYPE sy-repid,
    l_dynnr                          TYPE sy-dynnr.

* The event has to be specified.
  CHECK ir_dynpro_event IS BOUND.

* Process the dynpro event.
  CASE ir_dynpro_event->get_processing_block( ).

*   before_pai
    WHEN cl_ish_gui_dynpro_event=>co_procblock_before_pai.
      IF ir_dynpro_event->get_sender( ) = get_main_view( ).
        rr_response = _before_pai_main( ir_dynpro_event = ir_dynpro_event ).
      ELSE.
        rr_response = _before_pai( ir_dynpro_event = ir_dynpro_event ).
      ENDIF.

*   after_pai
    WHEN cl_ish_gui_dynpro_event=>co_procblock_after_pai.
      IF ir_dynpro_event->get_sender( ) = get_main_view( ).
        rr_response = _after_pai_main( ir_dynpro_event = ir_dynpro_event ).
      ELSE.
        rr_response = _after_pai( ir_dynpro_event = ir_dynpro_event ).
      ENDIF.

*   before_pbo
    WHEN cl_ish_gui_dynpro_event=>co_procblock_before_pbo.
      IF ir_dynpro_event->get_sender( ) = get_main_view( ).
        rr_response = _before_pbo_main( ir_dynpro_event = ir_dynpro_event ).
      ELSE.
        rr_response = _before_pbo( ir_dynpro_event = ir_dynpro_event ).
      ENDIF.

*   after_pbo
    WHEN cl_ish_gui_dynpro_event=>co_procblock_after_pbo.
      IF ir_dynpro_event->get_sender( ) = get_main_view( ).
        rr_response = _after_pbo_main( ir_dynpro_event = ir_dynpro_event ).
      ELSE.
        rr_response = _after_pbo( ir_dynpro_event = ir_dynpro_event ).
      ENDIF.

*   value_request
    WHEN cl_ish_gui_dynpro_value_event=>co_procblock_value_request.
*     Cast the given event to a dynpro_value_event.
      TRY.
          lr_dynpro_value_event ?= ir_dynpro_event.
        CATCH cx_sy_move_cast_error.
          RETURN.
      ENDTRY.
*     Process f4.
      TRY.
*         Process f4.
          lr_dynpro_view = lr_dynpro_value_event->get_dynpro_view( ).
          CHECK lr_dynpro_view IS BOUND.
          l_fieldname    = lr_dynpro_value_event->get_fieldname( ).
          CALL METHOD _value_request
            EXPORTING
              ir_dynpro_view   = lr_dynpro_view
              i_fieldname      = l_fieldname
            IMPORTING
              e_processed      = l_processed
              et_changed_field = lt_changed_field.
*         Further processing only if f4 was processed.
          CHECK l_processed = abap_true.
*         Create the response.
          rr_response = cl_ish_gui_response=>create( ir_request   = ir_dynpro_event
                                                     ir_processor = me ).
*         Complete pov.
          lr_dynpro_view->complete_pov(
              it_changed_field  = lt_changed_field ).
        CATCH cx_root INTO lx_root.
*         On any errors display the messages.
          CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
            EXPORTING
              i_exceptions    = lx_root
            CHANGING
              cr_errorhandler = lr_messages.
          CHECK lr_messages IS BOUND.
          lr_messages->display_messages( i_send_if_one = abap_true ).
          RETURN.
      ENDTRY.

*   help_request
    WHEN cl_ish_gui_dynpro_help_event=>co_procblock_help_request.
*     Cast the given event to a dynpro_value_event.
      TRY.
          lr_dynpro_help_event ?= ir_dynpro_event.
        CATCH cx_sy_move_cast_error.
          RETURN.
      ENDTRY.
*     Process f1.
      TRY.
*         Process f1.
          lr_dynpro_view = lr_dynpro_value_event->get_dynpro_view( ).
          l_fieldname = lr_dynpro_value_event->get_fieldname( ).
          CHECK _help_request( ir_dynpro_view = lr_dynpro_view
                               i_fieldname    = l_fieldname ) = abap_true.
*         Create the response.
          rr_response = cl_ish_gui_response=>create( ir_request   = ir_dynpro_event
                                                     ir_processor = me ).
        CATCH cx_root INTO lx_root.
*         On any errors display the messages.
          CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
            EXPORTING
              i_exceptions    = lx_root
            CHANGING
              cr_errorhandler = lr_messages.
          CHECK lr_messages IS BOUND.
          lr_messages->display_messages( i_send_if_one = abap_true ).
          RETURN.
      ENDTRY.

  ENDCASE.

ENDMETHOD.


METHOD _process_event_request.

  DATA:
    lr_control_event              TYPE REF TO cl_ish_gui_control_event,
    lr_dynpro_event               TYPE REF TO cl_ish_gui_dynpro_event,
    lr_exception_event            TYPE REF TO cl_ish_gui_exception_event,
    lr_mdy_event                  TYPE REF TO cl_ish_gui_mdy_event,
    lr_message_event              TYPE REF TO cl_ish_gui_message_event.

* The request has to be specified.
  CHECK ir_event_request IS BOUND.

* Processing depends on the request's type.
  TRY.
*     Control event?
      lr_control_event ?= ir_event_request.
      rr_response = _process_control_event( ir_control_event = lr_control_event ).
    CATCH cx_sy_move_cast_error.
      TRY.
*         Dynpro event?
          lr_dynpro_event ?= ir_event_request.
          rr_response = _process_dynpro_event( ir_dynpro_event = lr_dynpro_event ).
        CATCH cx_sy_move_cast_error.
          TRY.
*             Exception event?
              lr_exception_event ?= ir_event_request.
              rr_response = _process_exception_event( ir_exception_event = lr_exception_event ).
            CATCH cx_sy_move_cast_error.
              TRY.
*                 MDY event?
                  lr_mdy_event ?= ir_event_request.
                  rr_response = _process_mdy_event( ir_mdy_event = lr_mdy_event ).
                CATCH cx_sy_move_cast_error.
                  TRY.
*                     Message event?
                      lr_message_event ?= ir_event_request.
                      rr_response = _process_message_event( ir_message_event = lr_message_event ).
                    CATCH cx_sy_move_cast_error.        "#EC NO_HANDLER
                  ENDTRY.
              ENDTRY.
          ENDTRY.
      ENDTRY.
  ENDTRY.

ENDMETHOD.


METHOD _process_exception_event.

  DATA: lr_exception   TYPE REF TO cx_root.

* The event has to be specified.
  CHECK ir_exception_event IS BOUND.

* Create the response.
  rr_response = cl_ish_gui_response=>create( ir_request   = ir_exception_event
                                             ir_processor = me ).

* Collect the messages of the exception.
  lr_exception = ir_exception_event->get_exception( ).
  _collect_exception( lr_exception ).

* Display the messages.
  _display_messages( ).

ENDMETHOD.


METHOD _process_mdy_event.

  DATA:
    lr_processor                    TYPE REF TO if_ish_gui_request_processor,
    lr_command_request              TYPE REF TO cl_ish_gui_command_request,
    l_fcode                         TYPE ui_func.

* The event has to be specified.
  CHECK ir_mdy_event IS BOUND.

* Process only mdy events of the main dynpro.
  CHECK ir_mdy_event->get_sender( ) = get_main_view( ).

* Clear the crspos_message.
  IF ir_mdy_event->get_ucomm( ) <> co_ucomm_crspos.
    CLEAR: gs_crspos_message.
  ENDIF.

* Process only on valid user command.
  CHECK ir_mdy_event->get_ucomm( ) IS NOT INITIAL.
  CHECK ir_mdy_event->get_ucomm( ) <> co_ucomm_noproc.

* Process okcode requests.
  IF gr_okcode_request IS BOUND.
    IF gr_okcode_request->get_ucomm( ) = ir_mdy_event->get_ucomm( ).
      lr_processor = gr_okcode_request->get_processor( ).
      IF lr_processor IS BOUND.
        lr_command_request = cl_ish_gui_command_request=>create_by_okcode_request( ir_sender = me
                                                                                   ir_okcode_request = gr_okcode_request ).
        rr_response = lr_processor->process_request( ir_request = lr_command_request ).
        CLEAR: gr_okcode_request.
        RETURN.
      ENDIF.
    ENDIF.
    CLEAR: gr_okcode_request.
  ENDIF.

* Create the command request.
  l_fcode = ir_mdy_event->get_ucomm( ).
  lr_command_request = cl_ish_gui_command_request=>create_by_fcode( ir_sender = me
                                                                    i_fcode   = l_fcode ).
  CHECK lr_command_request IS BOUND.

* Process the command request.
  rr_response = process_request( ir_request = lr_command_request ).

ENDMETHOD.


METHOD _process_message_event.

  DATA: lr_err  TYPE REF TO cl_ishmed_errorhandling.

* The event has to be specified.
  CHECK ir_message_event IS BOUND.

* Create the response.
  rr_response = cl_ish_gui_response=>create( ir_request   = ir_message_event
                                             ir_processor = me ).

* Collect the messages of the exception.
  lr_err = ir_message_event->get_messages( ).
  _collect_messages( lr_err ).

* Display the messages.
  _display_messages( ).

ENDMETHOD.


METHOD _set_vcode.

  DATA lr_main_ctr            TYPE REF TO if_ish_gui_main_controller.

  CHECK i_vcode <> g_vcode.

  g_vcode = i_vcode.

  r_changed = abap_true.

  lr_main_ctr = get_main_controller( ).
  CHECK lr_main_ctr IS BOUND.

  lr_main_ctr->set_vcode(
      i_vcode                   = i_vcode
      i_with_child_controllers  = abap_true ).

ENDMETHOD.


method _VALUE_REQUEST.
endmethod.
ENDCLASS.
