*"* components of interface IF_ISH_GUI_TREE_VIEW
interface IF_ISH_GUI_TREE_VIEW
  public .


  interfaces IF_ISH_GUI_CONTROL_VIEW .

  aliases CO_VCODE_DISPLAY
    for IF_ISH_GUI_CONTROL_VIEW~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_GUI_CONTROL_VIEW~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_GUI_CONTROL_VIEW~CO_VCODE_UPDATE .
  aliases ACTUALIZE_LAYOUT
    for IF_ISH_GUI_CONTROL_VIEW~ACTUALIZE_LAYOUT .
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
  aliases SAVE_LAYOUT
    for IF_ISH_GUI_CONTROL_VIEW~SAVE_LAYOUT .
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

  methods CHECK_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(RT_CHECKED_NKEY) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CHECK_MODELS
    importing
      !IT_MODEL type ISH_T_GUI_MODEL_OBJHASH
    returning
      value(RT_CHECKED_NKEY) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CHECK_NKEY
    importing
      !I_NKEY type LVC_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CHECK_NKEYS
    importing
      !IT_NKEY type LVC_T_NKEY optional
    returning
      value(RT_CHECKED_NKEY) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods COLLAPSE_ALL_NODES
    returning
      value(RT_NKEY_COLLAPSED) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods COLLAPSE_NODE
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(R_COLLAPSED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods COLLAPSE_NODES
    importing
      !IT_NKEY type LVC_T_NKEY
    returning
      value(R_COLLAPSED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods DESELECT_ALL
    returning
      value(R_DESELECTED) type ABAP_BOOL .
  methods EXPAND_ALL_NODES
    returning
      value(RT_NKEY_EXPANDED) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods EXPAND_NODE
    importing
      !I_NKEY type LVC_NKEY
      !I_LEVEL_COUNT type I default 1
      !I_EXPAND_SUBTREE type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_EXPANDED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods EXPAND_NODES
    importing
      !IT_NKEY type LVC_T_NKEY
      !I_LEVEL_COUNT type I default 1
      !I_EXPAND_SUBTREE type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_EXPANDED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_ALL_CHECKED_CHILD_MODELS
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(RT_MODEL) type ISH_T_GUI_MODEL_OBJHASH .
  methods GET_ALL_CHECKED_CHILD_NKEYS
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(RT_NKEY) type LVC_T_NKEY .
  methods GET_ALL_CHILD_NKEYS
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(RT_NKEY) type LVC_T_NKEY .
  methods GET_ALV_TREE
    returning
      value(RR_ALV_TREE) type ref to CL_GUI_ALV_TREE .
  methods GET_ALV_TREE_TOOLBAR
    returning
      value(RR_TOOLBAR) type ref to CL_GUI_TOOLBAR .
  methods GET_CHECKED_CHILD_MODELS
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(RT_MODEL) type ISH_T_GUI_MODEL_OBJHASH .
  methods GET_CHECKED_CHILD_NKEYS
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(RT_NKEY) type LVC_T_NKEY .
  methods GET_CHECKED_MODELS
    returning
      value(RT_MODEL) type ISH_T_GUI_MODEL_OBJHASH .
  methods GET_CHECKED_NKEYS
    returning
      value(RT_NKEY) type LVC_T_NKEY .
  methods GET_CHECKED_PARENT_MODEL
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(RR_PARENT_MODEL) type ref to IF_ISH_GUI_MODEL .
  methods GET_CHECKED_PARENT_NKEY
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(R_PARENT_NKEY) type LVC_NKEY .
  methods GET_CHILD_NKEYS
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(RT_NKEY) type LVC_T_NKEY .
  methods GET_MODEL_BY_NKEY
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(RR_MODEL) type ref to IF_ISH_GUI_MODEL .
  methods GET_NKEYS_BY_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(RT_NKEY) type LVC_T_NKEY .
  methods GET_NKEY_BY_CHILD_MODEL
    importing
      !I_PARENT_NKEY type LVC_NKEY
      !IR_CHILD_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(R_NKEY) type LVC_NKEY .
  methods GET_PARENT_MODEL_BY_NKEY
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(RR_MODEL) type ref to IF_ISH_GUI_MODEL .
  methods GET_PARENT_NKEY
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(R_PARENT_NKEY) type LVC_NKEY .
  methods GET_PARENT_NKEYS
    importing
      !I_CHILD_NKEY type LVC_NKEY
    returning
      value(RT_PARENT_NKEY) type LVC_T_NKEY .
  methods GET_ROOT_NKEYS
    returning
      value(RT_ROOT_NKEY) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_SELECTED_MODEL
    returning
      value(RR_MODEL) type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_SELECTED_MODELS
    returning
      value(RT_MODEL) type ISH_T_GUI_MODEL_OBJHASH .
  methods GET_SELECTED_NKEY
    returning
      value(R_NKEY) type LVC_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_SELECTED_NKEYS
    returning
      value(RT_NKEY) type LVC_T_NKEY .
  methods GET_TREE_LAYOUT
    returning
      value(RR_TREE_LAYOUT) type ref to CL_ISH_GUI_TREE_LAYOUT .
  methods HAS_PARENT_NKEY
    importing
      !I_CHILD_NKEY type LVC_NKEY
      !I_PARENT_NKEY type LVC_NKEY
    returning
      value(R_HAS_PARENT_NKEY) type ABAP_BOOL .
  methods IS_NKEY_CHECKED
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(R_CHECKED) type ABAP_BOOL .
  methods SET_SELECTED_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(R_SELECTED) type ABAP_BOOL .
  methods SET_SELECTED_MODELS
    importing
      !IT_MODEL type ISH_T_GUI_MODEL_OBJHASH
    returning
      value(R_SELECTED) type ABAP_BOOL .
  methods SET_SELECTED_NKEY
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(R_SELECTED) type ABAP_BOOL .
  methods SET_SELECTED_NKEYS
    importing
      !IT_NKEY type LVC_T_NKEY
    returning
      value(R_SELECTED) type ABAP_BOOL .
  methods UNCHECK_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(RT_UNCHECKED_NKEY) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods UNCHECK_MODELS
    importing
      !IT_MODEL type ISH_T_GUI_MODEL_OBJHASH
    returning
      value(RT_UNCHECKED_NKEY) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods UNCHECK_NKEY
    importing
      !I_NKEY type LVC_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods UNCHECK_NKEYS
    importing
      !IT_NKEY type LVC_T_NKEY optional
    preferred parameter IT_NKEY
    returning
      value(RT_UNCHECKED_NKEY) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
