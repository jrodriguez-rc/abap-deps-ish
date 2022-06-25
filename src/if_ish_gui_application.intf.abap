*"* components of interface IF_ISH_GUI_APPLICATION
interface IF_ISH_GUI_APPLICATION
  public .


  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_GUI_ELEMENT .
  interfaces IF_ISH_GUI_REQUEST_PROCESSOR .
  interfaces IF_ISH_GUI_REQUEST_SENDER .

  aliases DESTROY
    for IF_ISH_DESTROYABLE~DESTROY .
  aliases GET_ELEMENT_ID
    for IF_ISH_GUI_ELEMENT~GET_ELEMENT_ID .
  aliases GET_ELEMENT_NAME
    for IF_ISH_GUI_ELEMENT~GET_ELEMENT_NAME .
  aliases IS_DESTROYED
    for IF_ISH_DESTROYABLE~IS_DESTROYED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_DESTROYABLE~IS_IN_DESTROY_MODE .
  aliases PROCESS_REQUEST
    for IF_ISH_GUI_REQUEST_PROCESSOR~PROCESS_REQUEST .
  aliases EV_AFTER_DESTROY
    for IF_ISH_DESTROYABLE~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_DESTROYABLE~EV_BEFORE_DESTROY .

  constants CO_UCOMM_BACK type SYUCOMM value 'BACK'. "#EC NOTEXT
  constants CO_UCOMM_CANCEL type SYUCOMM value 'CANCEL'. "#EC NOTEXT
  constants CO_UCOMM_CHECK type SYUCOMM value 'CHECK'. "#EC NOTEXT
  constants CO_UCOMM_CONFIG_LAYOUT type SYUCOMM value 'CONFIG_LAYOUT'. "#EC NOTEXT
  constants CO_UCOMM_DELETE type SYUCOMM value 'DELETE'. "#EC NOTEXT
  constants CO_UCOMM_END type SYUCOMM value 'END'. "#EC NOTEXT
  constants CO_UCOMM_ENTER type SYUCOMM value 'ENTER'. "#EC NOTEXT
  constants CO_UCOMM_SAVE type SYUCOMM value 'SAVE'. "#EC NOTEXT
  constants CO_UCOMM_SWI2DIS type SYUCOMM value 'SWI2DIS'. "#EC NOTEXT
  constants CO_UCOMM_SWI2UPD type SYUCOMM value 'SWI2UPD'. "#EC NOTEXT
  constants CO_UCOMM_TRANSPORT type SYUCOMM value 'TRANSPORT'. "#EC NOTEXT

  methods BUILD_ALV_VARIANT_REPORT
    importing
      !IR_VIEW type ref to IF_ISH_GUI_VIEW optional
    returning
      value(R_REPORT) type REPID .
  methods CANCEL_NEXT_MDYEVT_PROC .
  methods CLEAR_CRSPOS_MESSAGE .
  methods GET_ALV_VARIANT_REPORT_PREFIX
    importing
      !IR_VIEW type ref to IF_ISH_GUI_VIEW optional
    returning
      value(R_PREFIX) type STRING .
  methods GET_CRSPOS_MESSAGE
    returning
      value(RS_CRSPOS_MESSAGE) type RN1MESSAGE .
  methods GET_FOCUSSED_VIEW
    returning
      value(RR_VIEW) type ref to IF_ISH_GUI_VIEW .
  methods GET_LAYOUT
    returning
      value(RR_LAYOUT) type ref to CL_ISH_GUI_APPL_LAYOUT .
  methods GET_MAIN_CONTROLLER
    returning
      value(RR_MAIN_CONTROLLER) type ref to IF_ISH_GUI_MAIN_CONTROLLER .
  methods GET_STARTUP_SETTINGS
    returning
      value(RR_STARTUP_SETTINGS) type ref to CL_ISH_GUI_STARTUP_SETTINGS .
  methods GET_VCODE
    returning
      value(R_VCODE) type TNDYM-VCODE .
  type-pools ABAP .
  methods IS_EMBEDDED
    returning
      value(R_EMBEDDED) type ABAP_BOOL .
  methods IS_INITIALIZED
    returning
      value(R_INITIALIZED) type ABAP_BOOL .
  methods IS_IN_INITIALIZATION_MODE
    returning
      value(R_INITIALIZATION_MODE) type ABAP_BOOL .
  methods IS_ISH_SCRM_SUPPORTED
    importing
      !IR_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW optional
    returning
      value(R_SUPPORTED) type ABAP_BOOL .
  methods IS_NEXT_MDYEVT_PROC_CANCELLED
    returning
      value(R_CANCELLED) type ABAP_BOOL .
  methods IS_PAI_IN_PROCESS
    returning
      value(R_PAI_IN_PROCESS) type ABAP_BOOL .
  methods IS_PBO_IN_PROCESS
    returning
      value(R_PBO_IN_PROCESS) type ABAP_BOOL .
  methods IS_RUNNING
    returning
      value(R_RUNNING) type ABAP_BOOL .
  methods LOAD_LAYOUT
    importing
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME
      !I_USERNAME type USERNAME default SY-UNAME
    returning
      value(RR_LAYOUT) type ref to CL_ISH_GUI_LAYOUT
    raising
      CX_ISH_STATIC_HANDLER .
  methods LOAD_VIEW_LAYOUT
    importing
      !IR_VIEW type ref to IF_ISH_GUI_VIEW
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER optional
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_USERNAME type USERNAME default SY-UNAME
    returning
      value(RR_LAYOUT) type ref to CL_ISH_GUI_LAYOUT
    raising
      CX_ISH_STATIC_HANDLER .
  methods RUN
    returning
      value(RR_RESULT) type ref to CL_ISH_GUI_APPL_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods SAVE_LAYOUT
    importing
      !IR_LAYOUT type ref to CL_ISH_GUI_LAYOUT
      !I_USERNAME type USERNAME default SY-UNAME
      !I_ERDAT type RI_ERDAT default SY-DATUM
      !I_ERTIM type RI_ERTIM default SY-UZEIT
      !I_ERUSR type RI_ERNAM default SY-UNAME
    returning
      value(R_SAVED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods SAVE_VIEW_LAYOUT
    importing
      !IR_VIEW type ref to IF_ISH_GUI_VIEW
      !I_EXPLICIT type ABAP_BOOL
      !I_USERNAME type USERNAME default SY-UNAME
      !I_ERDAT type RI_ERDAT default SY-DATUM
      !I_ERTIM type RI_ERTIM default SY-UZEIT
      !I_ERUSR type RI_ERNAM default SY-UNAME
    returning
      value(R_SAVED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_FOCUSSED_VIEW
    importing
      !IR_VIEW type ref to IF_ISH_GUI_VIEW
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods SET_VCODE
    importing
      !I_VCODE type ISH_VCODE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
