*"* components of interface IF_ISH_GUI_TOOLBAR_VIEW
interface IF_ISH_GUI_TOOLBAR_VIEW
  public .


  interfaces IF_ISH_GUI_CONTROL_VIEW .

  aliases CO_VCODE_DISPLAY
    for IF_ISH_GUI_CONTROL_VIEW~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_GUI_CONTROL_VIEW~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_GUI_CONTROL_VIEW~CO_VCODE_UPDATE .
  aliases DESTROY
    for IF_ISH_GUI_CONTROL_VIEW~DESTROY .
  aliases FIRST_DISPLAY
    for IF_ISH_GUI_CONTROL_VIEW~FIRST_DISPLAY .
  aliases GET_APPLICATION
    for IF_ISH_GUI_CONTROL_VIEW~GET_APPLICATION .
  aliases GET_CHILD_VIEWS
    for IF_ISH_GUI_CONTROL_VIEW~GET_CHILD_VIEWS .
  aliases GET_CHILD_VIEW_BY_ID
    for IF_ISH_GUI_CONTROL_VIEW~GET_CHILD_VIEW_BY_ID .
  aliases GET_CHILD_VIEW_BY_NAME
    for IF_ISH_GUI_CONTROL_VIEW~GET_CHILD_VIEW_BY_NAME .
  aliases GET_CONTROL
    for IF_ISH_GUI_CONTROL_VIEW~GET_CONTROL .
  aliases GET_CONTROLLER
    for IF_ISH_GUI_CONTROL_VIEW~GET_CONTROLLER .
  aliases GET_CONTROL_LAYOUT
    for IF_ISH_GUI_CONTROL_VIEW~GET_CONTROL_LAYOUT .
  aliases GET_ELEMENT_ID
    for IF_ISH_GUI_CONTROL_VIEW~GET_ELEMENT_ID .
  aliases GET_ELEMENT_NAME
    for IF_ISH_GUI_CONTROL_VIEW~GET_ELEMENT_NAME .
  aliases GET_LAYOUT
    for IF_ISH_GUI_CONTROL_VIEW~GET_LAYOUT .
  aliases GET_PARENT_VIEW
    for IF_ISH_GUI_CONTROL_VIEW~GET_PARENT_VIEW .
  aliases GET_VCODE
    for IF_ISH_GUI_CONTROL_VIEW~GET_VCODE .
  aliases GET_VISIBILITY
    for IF_ISH_GUI_CONTROL_VIEW~GET_VISIBILITY .
  aliases HAS_FOCUS
    for IF_ISH_GUI_CONTROL_VIEW~HAS_FOCUS .
  aliases IS_DESTROYED
    for IF_ISH_GUI_CONTROL_VIEW~IS_DESTROYED .
  aliases IS_FIRST_DISPLAY_DONE
    for IF_ISH_GUI_CONTROL_VIEW~IS_FIRST_DISPLAY_DONE .
  aliases IS_INITIALIZED
    for IF_ISH_GUI_CONTROL_VIEW~IS_INITIALIZED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_GUI_CONTROL_VIEW~IS_IN_DESTROY_MODE .
  aliases IS_IN_FIRST_DISPLAY_MODE
    for IF_ISH_GUI_CONTROL_VIEW~IS_IN_FIRST_DISPLAY_MODE .
  aliases IS_IN_INITIALIZATION_MODE
    for IF_ISH_GUI_CONTROL_VIEW~IS_IN_INITIALIZATION_MODE .
  aliases PROCESS_REQUEST
    for IF_ISH_GUI_CONTROL_VIEW~PROCESS_REQUEST .
  aliases REFRESH_DISPLAY
    for IF_ISH_GUI_CONTROL_VIEW~REFRESH_DISPLAY .
  aliases REGISTER_CHILD_VIEW
    for IF_ISH_GUI_CONTROL_VIEW~REGISTER_CHILD_VIEW .
  aliases SET_FOCUS
    for IF_ISH_GUI_CONTROL_VIEW~SET_FOCUS .
  aliases SET_VCODE
    for IF_ISH_GUI_CONTROL_VIEW~SET_VCODE .
  aliases SET_VISIBILITY
    for IF_ISH_GUI_CONTROL_VIEW~SET_VISIBILITY .
  aliases EV_AFTER_DESTROY
    for IF_ISH_GUI_CONTROL_VIEW~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_GUI_CONTROL_VIEW~EV_BEFORE_DESTROY .
  aliases EV_VISIBILITY_CHANGED
    for IF_ISH_GUI_CONTROL_VIEW~EV_VISIBILITY_CHANGED .

  methods GET_TOOLBAR
    returning
      value(RR_TOOLBAR) type ref to CL_GUI_TOOLBAR .
  methods GET_TOOLBAR_LAYOUT
    returning
      value(RR_TOOLBAR_LAYOUT) type ref to CL_ISH_GUI_TOOLBAR_LAYOUT .
endinterface.