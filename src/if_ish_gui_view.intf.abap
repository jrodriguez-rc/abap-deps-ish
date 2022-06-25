*"* components of interface IF_ISH_GUI_VIEW
interface IF_ISH_GUI_VIEW
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

  constants CO_VCODE_DISPLAY type TNDYM-VCODE value 'DIS'. "#EC NOTEXT
  constants CO_VCODE_INSERT type TNDYM-VCODE value 'INS'. "#EC NOTEXT
  constants CO_VCODE_UPDATE type TNDYM-VCODE value 'UPD'. "#EC NOTEXT

  methods ACTUALIZE_LAYOUT
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_ALV_VARIANT_REPORT_SUFFIX
    returning
      value(R_SUFFIX) type STRING .
  methods GET_APPLICATION
    returning
      value(RR_APPLICATION) type ref to IF_ISH_GUI_APPLICATION .
  type-pools ABAP .
  methods GET_CHILD_VIEWS
    importing
      !I_WITH_SUBCHILDREN type ABAP_BOOL default ABAP_FALSE
    returning
      value(RT_CHILD_VIEW) type ISH_T_GUI_VIEWID_HASH .
  methods GET_CHILD_VIEW_BY_ID
    importing
      !I_VIEW_ID type N1GUI_ELEMENT_ID
      !I_WITH_SUBCHILDREN type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_CHILD_VIEW) type ref to IF_ISH_GUI_VIEW .
  methods GET_CHILD_VIEW_BY_NAME
    importing
      !I_VIEW_NAME type N1GUI_ELEMENT_NAME
    returning
      value(RR_CHILD_VIEW) type ref to IF_ISH_GUI_VIEW .
  methods GET_CONTROLLER
    returning
      value(RR_CONTROLLER) type ref to IF_ISH_GUI_CONTROLLER .
  methods GET_ERRORFIELD_MESSAGES
    importing
      !I_WITH_CHILD_VIEWS type ABAP_BOOL default ABAP_FALSE
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_FIELDNAME type ISH_FIELDNAME optional
    preferred parameter IR_MODEL
    returning
      value(RR_MESSAGES) type ref to CL_ISHMED_ERRORHANDLING .
  methods GET_LAYOUT
    returning
      value(RR_LAYOUT) type ref to CL_ISH_GUI_VIEW_LAYOUT .
  methods GET_PARENT_VIEW
    returning
      value(RR_PARENT_VIEW) type ref to IF_ISH_GUI_VIEW .
  methods GET_T_ERRORFIELD
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_FIELDNAME type ISH_FIELDNAME optional
    returning
      value(RT_ERRORFIELD) type ISHMED_T_GUI_ERRORFIELD_H .
  methods GET_T_VIEW_ERRORFIELDS
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_FIELDNAME type ISH_FIELDNAME optional
    returning
      value(RT_VIEW_ERRORFIELDS) type ISHMED_T_GV_ERRORFIELDS_H .
  methods GET_VCODE
    returning
      value(R_VCODE) type TNDYM-VCODE .
  methods HAS_ERRORFIELDS
    importing
      !I_WITH_CHILD_VIEWS type ABAP_BOOL default ABAP_FALSE
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_FIELDNAME type ISH_FIELDNAME optional
    preferred parameter IR_MODEL
    returning
      value(R_HAS_ERRORFIELDS) type ABAP_BOOL .
  methods HAS_FOCUS
    returning
      value(R_HAS_FOCUS) type ABAP_BOOL .
  methods IS_FIRST_DISPLAY_DONE
    returning
      value(R_DONE) type ABAP_BOOL .
  methods IS_INITIALIZED
    returning
      value(R_INITIALIZED) type ABAP_BOOL .
  methods IS_IN_FIRST_DISPLAY_MODE
    returning
      value(R_FIRST_DISPLAY_MODE) type ABAP_BOOL .
  methods IS_IN_INITIALIZATION_MODE
    returning
      value(R_INITIALIZATION_MODE) type ABAP_BOOL .
  methods REGISTER_CHILD_VIEW
    importing
      !IR_CHILD_VIEW type ref to IF_ISH_GUI_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods SAVE_LAYOUT
    importing
      !I_USERNAME type USERNAME default SY-UNAME
      !I_ERDAT type RI_ERDAT default SY-DATUM
      !I_ERTIM type RI_ERTIM default SY-UZEIT
      !I_ERUSR type RI_ERNAM default SY-UNAME
    returning
      value(R_SAVED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_FOCUS
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods SET_VCODE
    importing
      !I_VCODE type TNDYM-VCODE
      !I_WITH_CHILD_VIEWS type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
