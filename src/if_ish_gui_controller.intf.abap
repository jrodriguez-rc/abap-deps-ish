*"* components of interface IF_ISH_GUI_CONTROLLER
interface IF_ISH_GUI_CONTROLLER
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

  methods GET_APPLICATION
    returning
      value(RR_APPLICATION) type ref to IF_ISH_GUI_APPLICATION .
  type-pools ABAP .
  methods GET_CHILD_CONTROLLERS
    importing
      !I_WITH_SUBCHILDREN type ABAP_BOOL default ABAP_FALSE
    returning
      value(RT_CHILD_CONTROLLER) type ISH_T_GUI_CTRID_HASH .
  methods GET_CHILD_CONTROLLER_BY_ID
    importing
      !I_CONTROLLER_ID type N1GUI_ELEMENT_ID
      !I_WITH_SUBCHILDREN type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_CHILD_CONTROLLER) type ref to IF_ISH_GUI_CONTROLLER .
  methods GET_CHILD_CONTROLLER_BY_NAME
    importing
      !I_CONTROLLER_NAME type N1GUI_ELEMENT_NAME
    returning
      value(RR_CHILD_CONTROLLER) type ref to IF_ISH_GUI_CONTROLLER .
  methods GET_MAIN_CONTROLLER
    returning
      value(RR_MAIN_CONTROLLER) type ref to IF_ISH_GUI_MAIN_CONTROLLER .
  methods GET_MODEL
    returning
      value(RR_MODEL) type ref to IF_ISH_GUI_MODEL .
  methods GET_PARENT_CONTROLLER
    returning
      value(RR_PARENT_CONTROLLER) type ref to IF_ISH_GUI_CONTROLLER .
  methods GET_VCODE
    returning
      value(R_VCODE) type TNDYM-VCODE .
  methods GET_VIEW
    returning
      value(RR_VIEW) type ref to IF_ISH_GUI_VIEW .
  methods IS_INITIALIZED
    returning
      value(R_INITIALIZED) type ABAP_BOOL .
  methods IS_IN_INITIALIZATION_MODE
    returning
      value(R_INITIALIZATION_MODE) type ABAP_BOOL .
  methods REGISTER_CHILD_CONTROLLER
    importing
      !IR_CHILD_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_VCODE
    importing
      !I_VCODE type TNDYM-VCODE
      !I_WITH_CHILD_CONTROLLERS type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
