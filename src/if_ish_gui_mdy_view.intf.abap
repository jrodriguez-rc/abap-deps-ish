*"* components of interface IF_ISH_GUI_MDY_VIEW
interface IF_ISH_GUI_MDY_VIEW
  public .


  interfaces IF_ISH_GUI_DYNPRO_VIEW .

  aliases CO_UCOMM_POV_PROCESSED
    for IF_ISH_GUI_DYNPRO_VIEW~CO_UCOMM_POV_PROCESSED .
  aliases CO_VCODE_DISPLAY
    for IF_ISH_GUI_DYNPRO_VIEW~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_GUI_DYNPRO_VIEW~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_GUI_DYNPRO_VIEW~CO_VCODE_UPDATE .
  aliases ACTUALIZE_LAYOUT
    for IF_ISH_GUI_DYNPRO_VIEW~ACTUALIZE_LAYOUT .
  aliases DESTROY
    for IF_ISH_GUI_DYNPRO_VIEW~DESTROY .
  aliases GET_APPLICATION
    for IF_ISH_GUI_DYNPRO_VIEW~GET_APPLICATION .
  aliases GET_CHILD_VIEWS
    for IF_ISH_GUI_DYNPRO_VIEW~GET_CHILD_VIEWS .
  aliases GET_CHILD_VIEW_BY_ID
    for IF_ISH_GUI_DYNPRO_VIEW~GET_CHILD_VIEW_BY_ID .
  aliases GET_CHILD_VIEW_BY_NAME
    for IF_ISH_GUI_DYNPRO_VIEW~GET_CHILD_VIEW_BY_NAME .
  aliases GET_CONTROLLER
    for IF_ISH_GUI_DYNPRO_VIEW~GET_CONTROLLER .
  aliases GET_DYNNR
    for IF_ISH_GUI_DYNPRO_VIEW~GET_DYNNR .
  aliases GET_DYNPRO_LAYOUT
    for IF_ISH_GUI_DYNPRO_VIEW~GET_DYNPRO_LAYOUT .
  aliases GET_ELEMENT_ID
    for IF_ISH_GUI_DYNPRO_VIEW~GET_ELEMENT_ID .
  aliases GET_ELEMENT_NAME
    for IF_ISH_GUI_DYNPRO_VIEW~GET_ELEMENT_NAME .
  aliases GET_LAYOUT
    for IF_ISH_GUI_DYNPRO_VIEW~GET_LAYOUT .
  aliases GET_PARENT_VIEW
    for IF_ISH_GUI_DYNPRO_VIEW~GET_PARENT_VIEW .
  aliases GET_REPID
    for IF_ISH_GUI_DYNPRO_VIEW~GET_REPID .
  aliases GET_VCODE
    for IF_ISH_GUI_DYNPRO_VIEW~GET_VCODE .
  aliases HAS_FOCUS
    for IF_ISH_GUI_DYNPRO_VIEW~HAS_FOCUS .
  aliases IS_DESTROYED
    for IF_ISH_GUI_DYNPRO_VIEW~IS_DESTROYED .
  aliases IS_INITIALIZED
    for IF_ISH_GUI_DYNPRO_VIEW~IS_INITIALIZED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_GUI_DYNPRO_VIEW~IS_IN_DESTROY_MODE .
  aliases IS_IN_INITIALIZATION_MODE
    for IF_ISH_GUI_DYNPRO_VIEW~IS_IN_INITIALIZATION_MODE .
  aliases PROCESS_REQUEST
    for IF_ISH_GUI_DYNPRO_VIEW~PROCESS_REQUEST .
  aliases REGISTER_CHILD_VIEW
    for IF_ISH_GUI_DYNPRO_VIEW~REGISTER_CHILD_VIEW .
  aliases SET_FOCUS
    for IF_ISH_GUI_DYNPRO_VIEW~SET_FOCUS .
  aliases SET_VCODE
    for IF_ISH_GUI_DYNPRO_VIEW~SET_VCODE .
  aliases EV_AFTER_DESTROY
    for IF_ISH_GUI_DYNPRO_VIEW~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_GUI_DYNPRO_VIEW~EV_BEFORE_DESTROY .

  constants CO_DEF_MAIN_VIEW_NAME type N1GUI_ELEMENT_NAME value 'MAIN_VIEW'. "#EC NOTEXT

  events EV_EXIT .

  methods GET_MAIN_CONTROLLER
    returning
      value(RR_MAIN_CONTROLLER) type ref to IF_ISH_GUI_MAIN_CONTROLLER .
  methods GET_PFSTATUS
    returning
      value(RR_PFSTATUS) type ref to CL_ISH_GUI_MDY_PFSTATUS .
  methods GET_TITLEBAR
    returning
      value(RR_TITLEBAR) type ref to CL_ISH_GUI_MDY_TITLEBAR .
  methods GET_T_PFSTATUS
    returning
      value(RT_PFSTATUS) type ISH_T_GUI_MDYPFSTATNAME_HASH .
  methods GET_T_TITLEBAR
    returning
      value(RT_TITLEBAR) type ISH_T_GUI_MDYTITLENAME_HASH .
endinterface.