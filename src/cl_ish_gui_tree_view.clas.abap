class CL_ISH_GUI_TREE_VIEW definition
  public
  inheriting from CL_ISH_GUI_CONTROL_VIEW
  create public .

public section.
*"* public components of class CL_ISH_GUI_TREE_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_TREE_VIEW .

  aliases CHECK_MODEL
    for IF_ISH_GUI_TREE_VIEW~CHECK_MODEL .
  aliases CHECK_MODELS
    for IF_ISH_GUI_TREE_VIEW~CHECK_MODELS .
  aliases CHECK_NKEY
    for IF_ISH_GUI_TREE_VIEW~CHECK_NKEY .
  aliases CHECK_NKEYS
    for IF_ISH_GUI_TREE_VIEW~CHECK_NKEYS .
  aliases COLLAPSE_ALL_NODES
    for IF_ISH_GUI_TREE_VIEW~COLLAPSE_ALL_NODES .
  aliases COLLAPSE_NODE
    for IF_ISH_GUI_TREE_VIEW~COLLAPSE_NODE .
  aliases COLLAPSE_NODES
    for IF_ISH_GUI_TREE_VIEW~COLLAPSE_NODES .
  aliases DESELECT_ALL
    for IF_ISH_GUI_TREE_VIEW~DESELECT_ALL .
  aliases EXPAND_ALL_NODES
    for IF_ISH_GUI_TREE_VIEW~EXPAND_ALL_NODES .
  aliases EXPAND_NODE
    for IF_ISH_GUI_TREE_VIEW~EXPAND_NODE .
  aliases EXPAND_NODES
    for IF_ISH_GUI_TREE_VIEW~EXPAND_NODES .
  aliases GET_ALL_CHECKED_CHILD_MODELS
    for IF_ISH_GUI_TREE_VIEW~GET_ALL_CHECKED_CHILD_MODELS .
  aliases GET_ALL_CHECKED_CHILD_NKEYS
    for IF_ISH_GUI_TREE_VIEW~GET_ALL_CHECKED_CHILD_NKEYS .
  aliases GET_ALL_CHILD_NKEYS
    for IF_ISH_GUI_TREE_VIEW~GET_ALL_CHILD_NKEYS .
  aliases GET_ALV_TREE
    for IF_ISH_GUI_TREE_VIEW~GET_ALV_TREE .
  aliases GET_ALV_TREE_TOOLBAR
    for IF_ISH_GUI_TREE_VIEW~GET_ALV_TREE_TOOLBAR .
  aliases GET_CHECKED_CHILD_MODELS
    for IF_ISH_GUI_TREE_VIEW~GET_CHECKED_CHILD_MODELS .
  aliases GET_CHECKED_CHILD_NKEYS
    for IF_ISH_GUI_TREE_VIEW~GET_CHECKED_CHILD_NKEYS .
  aliases GET_CHECKED_MODELS
    for IF_ISH_GUI_TREE_VIEW~GET_CHECKED_MODELS .
  aliases GET_CHECKED_NKEYS
    for IF_ISH_GUI_TREE_VIEW~GET_CHECKED_NKEYS .
  aliases GET_CHECKED_PARENT_MODEL
    for IF_ISH_GUI_TREE_VIEW~GET_CHECKED_PARENT_MODEL .
  aliases GET_CHECKED_PARENT_NKEY
    for IF_ISH_GUI_TREE_VIEW~GET_CHECKED_PARENT_NKEY .
  aliases GET_CHILD_NKEYS
    for IF_ISH_GUI_TREE_VIEW~GET_CHILD_NKEYS .
  aliases GET_MODEL_BY_NKEY
    for IF_ISH_GUI_TREE_VIEW~GET_MODEL_BY_NKEY .
  aliases GET_NKEYS_BY_MODEL
    for IF_ISH_GUI_TREE_VIEW~GET_NKEYS_BY_MODEL .
  aliases GET_NKEY_BY_CHILD_MODEL
    for IF_ISH_GUI_TREE_VIEW~GET_NKEY_BY_CHILD_MODEL .
  aliases GET_PARENT_MODEL_BY_NKEY
    for IF_ISH_GUI_TREE_VIEW~GET_PARENT_MODEL_BY_NKEY .
  aliases GET_PARENT_NKEY
    for IF_ISH_GUI_TREE_VIEW~GET_PARENT_NKEY .
  aliases GET_PARENT_NKEYS
    for IF_ISH_GUI_TREE_VIEW~GET_PARENT_NKEYS .
  aliases GET_ROOT_NKEYS
    for IF_ISH_GUI_TREE_VIEW~GET_ROOT_NKEYS .
  aliases GET_SELECTED_MODEL
    for IF_ISH_GUI_TREE_VIEW~GET_SELECTED_MODEL .
  aliases GET_SELECTED_MODELS
    for IF_ISH_GUI_TREE_VIEW~GET_SELECTED_MODELS .
  aliases GET_SELECTED_NKEY
    for IF_ISH_GUI_TREE_VIEW~GET_SELECTED_NKEY .
  aliases GET_SELECTED_NKEYS
    for IF_ISH_GUI_TREE_VIEW~GET_SELECTED_NKEYS .
  aliases GET_TREE_LAYOUT
    for IF_ISH_GUI_TREE_VIEW~GET_TREE_LAYOUT .
  aliases HAS_PARENT_NKEY
    for IF_ISH_GUI_TREE_VIEW~HAS_PARENT_NKEY .
  aliases IS_NKEY_CHECKED
    for IF_ISH_GUI_TREE_VIEW~IS_NKEY_CHECKED .
  aliases SET_SELECTED_MODEL
    for IF_ISH_GUI_TREE_VIEW~SET_SELECTED_MODEL .
  aliases SET_SELECTED_MODELS
    for IF_ISH_GUI_TREE_VIEW~SET_SELECTED_MODELS .
  aliases SET_SELECTED_NKEY
    for IF_ISH_GUI_TREE_VIEW~SET_SELECTED_NKEY .
  aliases SET_SELECTED_NKEYS
    for IF_ISH_GUI_TREE_VIEW~SET_SELECTED_NKEYS .
  aliases UNCHECK_MODEL
    for IF_ISH_GUI_TREE_VIEW~UNCHECK_MODEL .
  aliases UNCHECK_MODELS
    for IF_ISH_GUI_TREE_VIEW~UNCHECK_MODELS .
  aliases UNCHECK_NKEY
    for IF_ISH_GUI_TREE_VIEW~UNCHECK_NKEY .
  aliases UNCHECK_NKEYS
    for IF_ISH_GUI_TREE_VIEW~UNCHECK_NKEYS .

  constants CO_CMDRESULT_EXIT type I value '3'. "#EC NOTEXT
  constants CO_CMDRESULT_NOPROC type I value '0'. "#EC NOTEXT
  constants CO_CMDRESULT_OKCODE type I value '2'. "#EC NOTEXT
  constants CO_CMDRESULT_PROCESSED type I value '1'. "#EC NOTEXT
  constants CO_FCODE_COLLAPSE type UI_FUNC value '&COLLAPSE'. "#EC NOTEXT
  constants CO_FCODE_EXPAND type UI_FUNC value '&EXPAND'. "#EC NOTEXT
  constants CO_FCODE_NOPROC type UI_FUNC value 'NOPROC'. "#EC NOTEXT
  constants CO_FCODE_SEARCH type UI_FUNC value '&FIND'. "#EC NOTEXT
  constants CO_NKEY_VIRTUALROOT type LVC_NKEY value '&VIRTUALROOT'. "#EC NOTEXT

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    preferred parameter I_ELEMENT_NAME .
  methods INIT_TREE_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_TREE_LAYOUT optional
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
      !I_OUTTAB_STRUCTNAME type TABNAME
    raising
      CX_ISH_STATIC_HANDLER .

  methods IF_ISH_GUI_VIEW~ACTUALIZE_LAYOUT
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_TREE_VIEW
*"* do not include other source files here!!!

  types:
    BEGIN OF gty_nkey,
      nkey            TYPE lvc_nkey,
      parent_nkey     type lvc_nkey,
      r_model         type ref to if_ish_gui_model,
    END OF gty_nkey .
  types:
    gtyt_nkey  TYPE HASHED TABLE OF gty_nkey WITH UNIQUE KEY nkey .
  types:
    BEGIN OF gty_model,
      r_model  TYPE REF TO if_ish_gui_model,
      t_nkey   TYPE lvc_t_nkey,
    END OF gty_model .
  types:
    gtyt_model  TYPE HASHED TABLE OF gty_model WITH UNIQUE KEY r_model .

  data GR_OUTTAB type ref to DATA .
  data GR_TMP_EXPHIER_MOVE type ref to CL_ISH_GM_STRUCTURE_SIMPLE .
  data GR_TMP_MODEL_MOVE type ref to IF_ISH_GUI_MODEL .
  data GT_MODEL type GTYT_MODEL .
  data GT_NKEY type GTYT_NKEY .
  type-pools ABAP .
  data G_ON_MODEL_ADDED_DEACTIVATED type ABAP_BOOL .

  class-methods _CHECK_R_OUTTAB
    importing
      !IR_OUTTAB type ref to DATA
    raising
      CX_ISH_STATIC_HANDLER .
  methods ON_AFTER_USER_COMMAND
    for event AFTER_USER_COMMAND of CL_GUI_ALV_TREE
    importing
      !UCOMM
      !SENDER .
  methods ON_BEFORE_USER_COMMAND
    for event BEFORE_USER_COMMAND of CL_GUI_ALV_TREE
    importing
      !UCOMM
      !SENDER .
  methods ON_BUTTON_CLICK
    for event BUTTON_CLICK of CL_GUI_ALV_TREE
    importing
      !FIELDNAME
      !NODE_KEY
      !SENDER .
  methods ON_CHECKBOX_CHANGE
    for event CHECKBOX_CHANGE of CL_GUI_ALV_TREE
    importing
      !CHECKED
      !FIELDNAME
      !NODE_KEY
      !SENDER .
  methods ON_DRAG
    for event ON_DRAG of CL_GUI_ALV_TREE
    importing
      !DRAG_DROP_OBJECT
      !FIELDNAME
      !NODE_KEY
      !SENDER .
  methods ON_DRAG_MULTIPLE
    for event ON_DRAG_MULTIPLE of CL_GUI_ALV_TREE
    importing
      !DRAG_DROP_OBJECT
      !FIELDNAME
      !NODE_KEY_TABLE
      !SENDER .
  methods ON_DROP
    for event ON_DROP of CL_GUI_ALV_TREE
    importing
      !DRAG_DROP_OBJECT
      !NODE_KEY
      !SENDER .
  methods ON_DROPDOWN_CLICKED
    for event DROPDOWN_CLICKED of CL_GUI_TOOLBAR
    importing
      !FCODE
      !POSX
      !POSY
      !SENDER .
  methods ON_EXPAND_NC
    for event EXPAND_NC of CL_GUI_ALV_TREE
    importing
      !NODE_KEY
      !SENDER .
  methods ON_FUNCTION_SELECTED
    for event FUNCTION_SELECTED of CL_GUI_TOOLBAR
    importing
      !FCODE
      !SENDER .
  methods ON_HOTSPOT_CLICK
    for event LINK_CLICK of CL_GUI_ALV_TREE
    importing
      !FIELDNAME
      !NODE_KEY
      !SENDER .
  methods ON_ITEM_CTX_REQUEST
    for event ITEM_CONTEXT_MENU_REQUEST of CL_GUI_ALV_TREE
    importing
      !FIELDNAME
      !MENU
      !NODE_KEY
      !SENDER .
  methods ON_ITEM_CTX_SELECTED
    for event ITEM_CONTEXT_MENU_SELECTED of CL_GUI_ALV_TREE
    importing
      !FCODE
      !FIELDNAME
      !NODE_KEY
      !SENDER .
  methods ON_ITEM_DOUBLE_CLICK
    for event ITEM_DOUBLE_CLICK of CL_GUI_ALV_TREE
    importing
      !FIELDNAME
      !NODE_KEY
      !SENDER .
  methods ON_ITEM_KEYPRESS
    for event ITEM_KEYPRESS of CL_GUI_ALV_TREE
    importing
      !FIELDNAME
      !KEY
      !NODE_KEY
      !SENDER .
  methods ON_LINK_CLICK
    for event LINK_CLICK of CL_GUI_ALV_TREE
    importing
      !FIELDNAME
      !NODE_KEY
      !SENDER .
  methods ON_MODEL_ADDED
    for event EV_ENTRY_ADDED of IF_ISH_GUI_TABLE_MODEL
    importing
      !ER_ENTRY
      !SENDER .
  methods ON_MODEL_ADDED_ADJUST
    for event EV_ENTRY_ADDED of IF_ISH_GUI_TABLE_MODEL
    importing
      !ER_ENTRY
      !SENDER .
  methods ON_MODEL_CHANGED
    for event EV_CHANGED of IF_ISH_GUI_STRUCTURE_MODEL
    importing
      !ET_CHANGED_FIELD
      !SENDER .
  methods ON_MODEL_REMOVED
    for event EV_ENTRY_REMOVED of IF_ISH_GUI_TABLE_MODEL
    importing
      !ER_ENTRY
      !SENDER .
  methods ON_MODEL_REMOVED_ADJUST
    for event EV_ENTRY_REMOVED of IF_ISH_GUI_TABLE_MODEL
    importing
      !ER_ENTRY
      !SENDER .
  methods ON_NODE_CTX_REQUEST
    for event NODE_CONTEXT_MENU_REQUEST of CL_GUI_ALV_TREE
    importing
      !MENU
      !NODE_KEY
      !SENDER .
  methods ON_NODE_CTX_SELECTED
    for event NODE_CONTEXT_MENU_SELECTED of CL_GUI_ALV_TREE
    importing
      !FCODE
      !NODE_KEY
      !SENDER .
  methods ON_NODE_DOUBLE_CLICK
    for event NODE_DOUBLE_CLICK of CL_GUI_ALV_TREE
    importing
      !NODE_KEY
      !SENDER .
  methods ON_NODE_KEYPRESS
    for event NODE_KEYPRESS of CL_GUI_ALV_TREE
    importing
      !KEY
      !NODE_KEY
      !SENDER .
  methods _ADD_FVAR_BUTTON_TO_TOOLBAR
    importing
      !IR_BUTTON type ref to CL_ISH_FVAR_BUTTON
      !IR_TOOLBAR type ref to CL_GUI_TOOLBAR
    returning
      value(R_ADDED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _ADD_FVAR_FUNCTION_TO_CTMENU
    importing
      !IR_CTMENU type ref to CL_CTMENU
      !IR_FUNCTION type ref to CL_ISH_FVAR_FUNCTION
    returning
      value(R_ADDED) type ABAP_BOOL .
  class CL_GUI_COLUMN_TREE definition load .
  methods _ADD_NODE
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_RELAT_NKEY type LVC_NKEY optional
      !I_RELATIONSHIP type I default CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
      !IS_OUTTAB type DATA
      !IS_LAYN type LVC_S_LAYN optional
      !IT_LAYI type LVC_T_LAYI optional
      !I_NODE_TEXT type LVC_VALUE optional
    returning
      value(R_NKEY) type LVC_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _ADD_NODES_BY_MODEL
    importing
      !IR_PARENT_MODEL type ref to IF_ISH_GUI_MODEL optional
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_CALCULATE_RELATIONSHIP type ABAP_BOOL default ABAP_TRUE
    returning
      value(RT_NKEY_ADDED) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _ADD_TREE_TO_FLUSH_BUFFER
    importing
      !IR_ALV_TREE type ref to CL_GUI_ALV_TREE .
  methods _ADJUST_CHILD_NODES_CBXCHG
    importing
      !I_ORIG_NKEY type LVC_NKEY
      !I_NKEY type LVC_NKEY
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_CHECKED type ABAP_BOOL
      !I_EXPAND type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _ADJUST_NODES_TO_VCODE
    importing
      !I_OLD_VCODE type ISH_VCODE
      !I_NEW_VCODE type ISH_VCODE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _ADJUST_PARENT_NODE_CBXCHG
    importing
      !I_ORIG_NKEY type LVC_NKEY
      !I_NKEY type LVC_NKEY
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_CHECKED type ABAP_BOOL
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_CTMENU_FVAR
    importing
      !IR_TOOLBAR type ref to CL_GUI_TOOLBAR
      !IR_FVAR type ref to CL_ISH_FVAR
      !I_FCODE type UI_FUNC
    returning
      value(RR_CTMENU) type ref to CL_CTMENU .
  methods _BUILD_CTMENU_OWN
    importing
      !IR_TOOLBAR type ref to CL_GUI_TOOLBAR
      !I_FCODE type UI_FUNC
    returning
      value(RR_CTMENU) type ref to CL_CTMENU .
  methods _BUILD_EXCLUDING_FUNCTIONS
    returning
      value(RT_EXCLFUNC) type UI_FUNCTIONS
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_FCAT
    returning
      value(RT_FCAT) type LVC_T_FCAT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_HIERARCHY_HEADER
    returning
      value(RS_HIERARCHY_HEADER) type TREEV_HHDR
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_TBMENU_FVAR
    importing
      !IR_TOOLBAR type ref to CL_GUI_TOOLBAR
      !IR_FVAR type ref to CL_ISH_FVAR
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_TBMENU_OWN
    importing
      !IR_TOOLBAR type ref to CL_GUI_TOOLBAR
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_TOOLBAR_MENU
    importing
      !IR_TOOLBAR type ref to CL_GUI_TOOLBAR
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BUILD_VARIANT
    exporting
      !ES_VARIANT type DISVARIANT
      !E_SAVE type CHAR01 .
  methods _CHANGE_NODE
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_NKEY type LVC_NKEY
      !IS_OUTTAB type DATA
      !IS_LACN type LVC_S_LACN optional
      !IT_LACI type LVC_T_LACI optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_TEXT_X type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHANGE_NODES_BY_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME optional
    returning
      value(RT_NKEY_CHANGED) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHANGE_NODE_BY_MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_NKEY type LVC_NKEY
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME optional
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHANGE_TOOLBAR_MENU
    importing
      !IR_TOOLBAR type ref to CL_GUI_TOOLBAR
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CMD_COLLAPSE
    importing
      !IR_TREE_EVENT type ref to CL_ISH_GUI_TREE_EVENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CMD_DROPDOWN_CLICKED
    importing
      !IR_TREE_EVENT type ref to CL_ISH_GUI_TREE_EVENT
    returning
      value(R_CMDRESULT) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CMD_EXPAND
    importing
      !IR_TREE_EVENT type ref to CL_ISH_GUI_TREE_EVENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CMD_NODE_CTX_REQUEST
    importing
      !IR_TREE_EVENT type ref to CL_ISH_GUI_TREE_EVENT
    returning
      value(R_CMDRESULT) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CMD_ON_DRAG
    importing
      !IR_TREE_EVENT type ref to CL_ISH_GUI_TREE_EVENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CMD_ON_DRAG_MULTIPLE
    importing
      !IR_TREE_EVENT type ref to CL_ISH_GUI_TREE_EVENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CMD_ON_DROP
    importing
      !IR_TREE_EVENT type ref to CL_ISH_GUI_TREE_EVENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DESTROY_DND .
  methods _FILL_OUTTAB_LINE
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME optional
    changing
      !CS_OUTTAB type DATA
    raising
      CX_ISH_STATIC_HANDLER .
  methods _FRONTEND_UPDATE
    importing
      !I_FORCE type ABAP_BOOL default ABAP_FALSE .
  methods _GET_CHILD_MODELS
    importing
      !IR_PARENT_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(RT_CHILD_MODEL) type ISH_T_GUI_MODEL_OBJHASH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_CHILD_NKEYS_CBXCHG
    importing
      !I_ORIG_NKEY type LVC_NKEY
      !I_NKEY type LVC_NKEY
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_CHECKED type ABAP_BOOL
    returning
      value(RT_CHILD_NKEY) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_DNDID4MODEL
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(R_DNDID) type INT2
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_EXPANDED_HIERARCHY
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(RR_HIERARCHY) type ref to CL_ISH_GM_STRUCTURE_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_FCODE_BUTTONTYPE
    importing
      !I_FCODE type UI_FUNC
    returning
      value(R_BUTTONTYPE) type TB_BTYPE .
  methods _GET_LACI
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_NKEY type LVC_NKEY
      !IS_OUTTAB type DATA
      !IT_LAYI type LVC_T_LAYI
    returning
      value(RT_LACI) type LVC_T_LACI
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_LACN
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_NKEY type LVC_NKEY
      !IS_OUTTAB type DATA
      !IS_LAYN type LVC_S_LAYN
    returning
      value(RS_LACN) type LVC_S_LACN
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_LAYI
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !IS_OUTTAB type DATA
    returning
      value(RT_LAYI) type LVC_T_LAYI
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_LAYN
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !IS_OUTTAB type DATA
    returning
      value(RS_LAYN) type LVC_S_LAYN
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_MAIN_MODEL
    returning
      value(RR_MAIN_MODEL) type ref to IF_ISH_GUI_MODEL .
  methods _GET_MODEL_BY_TREE_EVENT
    importing
      !IR_TREE_EVENT type ref to CL_ISH_GUI_TREE_EVENT
    returning
      value(RR_MODEL) type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_NODE_SELECTION_MODE
    returning
      value(R_MODE) type I .
  methods _GET_NODE_TEXT
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_NKEY type LVC_NKEY optional
      !IS_OUTTAB type DATA
    returning
      value(R_NODE_TEXT) type LVC_VALUE
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_PARENT_NKEY_CBXCHG
    importing
      !I_ORIG_NKEY type LVC_NKEY
      !I_NKEY type LVC_NKEY
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_CHECKED type ABAP_BOOL
    returning
      value(R_PARENT_NKEY) type LVC_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_RELAT_4_NEW_MODEL
    importing
      !I_PARENT_NKEY type LVC_NKEY optional
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_CALCULATE_RELATIONSHIP type ABAP_BOOL default ABAP_TRUE
    exporting
      !E_RELAT_NKEY type LVC_NKEY
      !E_RELATIONSHIP type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_SHOW_MAIN_MODEL
    returning
      value(R_SHOW_MAIN_MODEL) type ABAP_BOOL .
  methods _GET_STARTUP_EXPAND_LEVEL
    returning
      value(R_STARTUP_EXPAND_LEVEL) type I .
  methods _INIT_TREE_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_TREE_LAYOUT optional
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
      !IR_OUTTAB type ref to DATA
    raising
      CX_ISH_STATIC_HANDLER .
  methods _IS_FCODE_DISABLED
    importing
      !I_FCODE type UI_FUNC
    returning
      value(R_DISABLED) type ABAP_BOOL .
  methods _IS_FCODE_SUPPORTED
    importing
      !I_FCODE type UI_FUNC
    returning
      value(R_SUPPORTED) type ABAP_BOOL .
  methods _IS_MODEL_VALID
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(R_IS_VALID) type ABAP_BOOL .
  methods _LOAD_CHILD_MODELS
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_LEVEL_COUNT type I default 1
    returning
      value(R_LOADED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _LOAD_OR_CREATE_LAYOUT
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_USERNAME type USERNAME default SY-UNAME
    returning
      value(RR_LAYOUT) type ref to CL_ISH_GUI_TREE_LAYOUT .
  methods _ON_NODE_CHECKBOX_CHANGE
    importing
      !I_NKEY type LVC_NKEY
      !I_FIELDNAME type LVC_FNAME
      !I_CHECKED type ABAP_BOOL
      !I_EXPAND type ABAP_BOOL default ABAP_TRUE .
  methods _OWN_CMD
    importing
      !IR_TREE_EVENT type ref to CL_ISH_GUI_TREE_EVENT
      !IR_ORIG_REQUEST type ref to CL_ISH_GUI_REQUEST
    returning
      value(R_CMDRESULT) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _PREPARE_DND
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REGISTER_ALV_TREE_EVENTS
    importing
      !IR_ALV_TREE type ref to CL_GUI_ALV_TREE
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REGISTER_MODEL_EVENTS
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_ACTIVATION type ABAP_BOOL default ABAP_TRUE .
  methods _REGISTER_STRUCTMDL_EVENTS
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_ACTIVATION type ABAP_BOOL default ABAP_TRUE .
  methods _REGISTER_TABMDL_EVENTS
    importing
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_ACTIVATION type ABAP_BOOL default ABAP_TRUE .
  methods _REGISTER_TOOLBAR_EVENTS
    importing
      !IR_TOOLBAR type ref to CL_GUI_TOOLBAR
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REMOVE_NODE
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(RT_NKEY_REMOVED) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REMOVE_NODES_BY_MODEL
    importing
      !IR_PARENT_MODEL type ref to IF_ISH_GUI_MODEL optional
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
    returning
      value(RT_NKEY_REMOVED) type LVC_T_NKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SET_EXPANDED_HIERARCHY
    importing
      !I_NKEY type LVC_NKEY
      !IR_HIERARCHY type ref to CL_ISH_GM_STRUCTURE_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SET_TABLE_FOR_FIRST_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .
  methods __GET_ENTRIES
    importing
      !IR_TABMDL type ref to IF_ISH_GUI_TABLE_MODEL
    returning
      value(RT_CHILD_MODEL) type ISH_T_GUI_MODEL_OBJHASH
    raising
      CX_ISH_STATIC_HANDLER .
  methods __ON_NODE_CHECKBOX_CHANGE
    importing
      !I_ORIG_NKEY type LVC_NKEY
      !I_NKEY type LVC_NKEY
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !I_CHECKED type ABAP_BOOL
      !I_ADJUST_PARENT_NODE type ABAP_BOOL
      !I_ADJUST_CHILD_NODES type ABAP_BOOL
      !I_EXPAND type ABAP_BOOL default ABAP_TRUE
      !I_ADJUST_FROM_PARENT type ABAP_BOOL default ABAP_FALSE
      !I_ADJUST_FROM_CHILD type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_CHANGED) type ABAP_BOOL
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
*"* private components of class CL_ISH_GUI_TREE_VIEW
*"* do not include other source files here!!!

  types:
    BEGIN OF gty_flush_buffer,
    r_alv_tree    TYPE REF TO cl_gui_alv_tree,
  END OF gty_flush_buffer .
  types:
    gtyt_flush_buffer  TYPE HASHED TABLE OF gty_flush_buffer WITH UNIQUE KEY r_alv_tree .

  class-data GT_FLUSH_BUFFER type GTYT_FLUSH_BUFFER .

  class-methods ON_FLUSH
    for event EV_FLUSH of CL_ISH_GUI_CONTROL_VIEW .
ENDCLASS.



CLASS CL_ISH_GUI_TREE_VIEW IMPLEMENTATION.


METHOD class_constructor.

* Register the flush event.
  SET HANDLER on_flush ACTIVATION abap_true.

ENDMETHOD.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~check_model.

  DATA lt_model           TYPE ish_t_gui_model_objhash.

  CHECK ir_model IS BOUND.

  INSERT ir_model INTO TABLE lt_model.

  rt_checked_nkey = check_models( it_model = lt_model ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~check_models.

  DATA lr_model               TYPE REF TO if_ish_gui_model.
  DATA lt_tmp_nkey            TYPE lvc_t_nkey.
  DATA lt_nkey                TYPE lvc_t_nkey.

  FIELD-SYMBOLS <l_nkey>      TYPE lvc_nkey.

  CHECK it_model IS NOT INITIAL.

  LOOP AT it_model INTO lr_model.
    lt_tmp_nkey = get_nkeys_by_model( ir_model = lr_model ).
    LOOP AT lt_tmp_nkey ASSIGNING <l_nkey>.
      READ TABLE lt_nkey FROM <l_nkey> TRANSPORTING NO FIELDS.
      CHECK sy-subrc <> 0.
      APPEND <l_nkey> TO lt_nkey.
    ENDLOOP.
  ENDLOOP.

  rt_checked_nkey = check_nkeys( it_nkey = lt_nkey ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~check_nkey.

  DATA lt_nkey            TYPE lvc_t_nkey.

  CHECK i_nkey IS NOT INITIAL.

  INSERT i_nkey INTO TABLE lt_nkey.

  check_nkeys( it_nkey = lt_nkey ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~check_nkeys.

  DATA lt_nkey                              TYPE lvc_t_nkey.
  DATA lr_s_outtab                          TYPE REF TO data.
  DATA lr_alv_tree                          TYPE REF TO cl_gui_alv_tree.
  DATA lt_layi                              TYPE lvc_t_layi.
  DATA lt_laci                              TYPE lvc_t_laci.
  DATA ls_laci                              TYPE lvc_s_laci.

  FIELD-SYMBOLS <l_nkey>                    TYPE lvc_nkey.
  FIELD-SYMBOLS <lt_outtab>                 TYPE table.
  FIELD-SYMBOLS <ls_outtab>                 TYPE data.
  FIELD-SYMBOLS <ls_layi>                   TYPE lvc_s_layi.

* Get the nkeys to check.
  IF it_nkey IS INITIAL.
*    lt_nkey = get_checked_nkeys( ).
  ELSE.
    lt_nkey = it_nkey.
  ENDIF.
  CHECK lt_nkey IS NOT INITIAL.

* Get the alv_tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Create an empty outtab line.
  CHECK gr_outtab IS BOUND.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  CREATE DATA lr_s_outtab LIKE LINE OF <lt_outtab>.
  ASSIGN lr_s_outtab->* TO <ls_outtab>.

* Now check the nodes.
  LOOP AT lt_nkey ASSIGNING <l_nkey>.

    CHECK <l_nkey> IS NOT INITIAL.
    REFRESH lt_layi.

*   Get the item layout.
    CALL METHOD lr_alv_tree->get_outtab_line
      EXPORTING
        i_node_key     = <l_nkey>
      IMPORTING
        e_outtab_line  = <ls_outtab>
        et_item_layout = lt_layi
      EXCEPTIONS
        OTHERS         = 1.
    CHECK sy-subrc = 0.

*   Build the changing item layout.
    CLEAR lt_laci.
    LOOP AT lt_layi ASSIGNING <ls_layi>.
      CHECK <ls_layi>-fieldname = cl_gui_alv_tree=>c_hierarchy_column_name.
      CHECK <ls_layi>-chosen = abap_false.
      CLEAR ls_laci.
      MOVE-CORRESPONDING <ls_layi> TO ls_laci.
      ls_laci-chosen    = abap_true.
      ls_laci-u_chosen  = abap_true.
      INSERT ls_laci INTO TABLE lt_laci.
      EXIT.
    ENDLOOP.
    CHECK lt_laci IS NOT INITIAL.

*   Change the node.
    CALL METHOD lr_alv_tree->change_node
      EXPORTING
        i_node_key     = <l_nkey>
        i_outtab_line  = <ls_outtab>
        it_item_layout = lt_laci
      EXCEPTIONS
        OTHERS         = 1.
    CHECK sy-subrc = 0.

*   Handle rt_checked_nkey.
    INSERT <l_nkey> INTO TABLE rt_checked_nkey.

  ENDLOOP.

* Update the frontend.
  _frontend_update( ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~collapse_all_nodes.

* Get the root nodes.
  rt_nkey_collapsed = get_root_nkeys( ).

* Collapse the root nodes.
  collapse_nodes( it_nkey = rt_nkey_collapsed ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~collapse_node.

  DATA lr_alv_tree            TYPE REF TO cl_gui_alv_tree.

  CHECK i_nkey IS NOT INITIAL.

* Get the alv tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Collapse the node.
  CALL METHOD lr_alv_tree->collapse_subtree
    EXPORTING
      i_node_key = i_nkey
    EXCEPTIONS
      OTHERS     = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'COLLAPSE_NODE'
        i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

* Export.
  r_collapsed = abap_true.

ENDMETHOD.


METHOD if_ish_gui_tree_view~collapse_nodes.

  DATA l_flush_buffer_activated             TYPE abap_bool.

  FIELD-SYMBOLS <l_nkey>                    TYPE lvc_nkey.

* Activate the flush buffer to avoid flickering.
  l_flush_buffer_activated = activate_flush_buffer( ).

* Collapse the nodes.
* On errors we may have at least to flush.
  TRY.
      LOOP AT it_nkey ASSIGNING <l_nkey>.
        IF collapse_node( i_nkey = <l_nkey> ) = abap_true.
          r_collapsed = abap_true.
        ENDIF.
      ENDLOOP.
    CLEANUP.
      IF l_flush_buffer_activated = abap_true.
        flush( ).
      ENDIF.
  ENDTRY.

* Flush.
  IF l_flush_buffer_activated = abap_true.
    flush( ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_tree_view~deselect_all.

  DATA lr_alv_tree                  TYPE REF TO cl_gui_alv_tree.
  DATA l_tmp_rc                     TYPE sy-subrc.

* Process only if first display is already done.
  CHECK is_first_display_done( ) = abap_true.

* Get the alv tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

  CALL METHOD lr_alv_tree->unselect_all
    EXCEPTIONS
      OTHERS = 1.
  l_tmp_rc = sy-subrc.

* The nodes were selected.
  IF l_tmp_rc = 0.
    r_deselected = abap_true.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_tree_view~expand_all_nodes.

* Get the root nodes.
  rt_nkey_expanded = get_root_nkeys( ).

* Expand the root nodes.
  expand_nodes(
      it_nkey          = rt_nkey_expanded
      i_expand_subtree = abap_true ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~expand_node.

  DATA lr_alv_tree            TYPE REF TO cl_gui_alv_tree.
  DATA lr_model               TYPE REF TO if_ish_gui_model.
  DATA l_level_count          TYPE i.

  CHECK i_nkey IS NOT INITIAL.

* Get the alv tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Get the model for the nkey.
  lr_model = get_model_by_nkey( i_nkey = i_nkey ).
  CHECK lr_model IS BOUND.

* Load the child models.
  IF i_expand_subtree = abap_true.
    l_level_count = 99.
  ELSE.
    l_level_count = i_level_count.
  ENDIF.
  CHECK l_level_count > 0.
  CHECK _load_child_models(
      ir_model      = lr_model
      i_level_count = l_level_count ) = abap_true.

* Register the tabmodel events for the given model.
  _register_tabmdl_events(
      ir_model     = lr_model
      i_activation = abap_true ).

* Expand the node.
  CALL METHOD lr_alv_tree->expand_node
    EXPORTING
      i_node_key       = i_nkey
      i_level_count    = i_level_count
      i_expand_subtree = i_expand_subtree
    EXCEPTIONS
      OTHERS           = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'EXPAND_NODE'
        i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

* Export.
  r_expanded = abap_true.

ENDMETHOD.


METHOD if_ish_gui_tree_view~expand_nodes.

  DATA l_flush_buffer_activated             TYPE abap_bool.

  FIELD-SYMBOLS <l_nkey>                    TYPE lvc_nkey.

* Activate the flush buffer to avoid flickering.
  l_flush_buffer_activated = activate_flush_buffer( ).

* Expand the nodes.
* On errors we may have at least to flush.
  TRY.
      LOOP AT it_nkey ASSIGNING <l_nkey>.
        IF expand_node(
            i_nkey           = <l_nkey>
            i_level_count    = i_level_count
            i_expand_subtree = i_expand_subtree ) = abap_true.
          r_expanded = abap_true.
        ENDIF.
      ENDLOOP.
    CLEANUP.
      IF l_flush_buffer_activated = abap_true.
        flush( ).
      ENDIF.
  ENDTRY.

* Flush.
  IF l_flush_buffer_activated = abap_true.
    flush( ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_all_checked_child_models.

  DATA lt_nkey                TYPE lvc_t_nkey.
  DATA lr_model               TYPE REF TO if_ish_gui_model.

  FIELD-SYMBOLS <l_nkey>      TYPE lvc_nkey.

  lt_nkey = get_all_checked_child_nkeys( i_nkey = i_nkey ).

  LOOP AT lt_nkey ASSIGNING <l_nkey>.
    lr_model = get_model_by_nkey( i_nkey = <l_nkey> ).
    CHECK lr_model IS BOUND.
    INSERT lr_model INTO TABLE rt_model.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_all_checked_child_nkeys.

  DATA lt_child_nkey                TYPE lvc_t_nkey.
  DATA lt_checked_nkey              TYPE lvc_t_nkey.

  FIELD-SYMBOLS <l_checked_nkey>    TYPE lvc_nkey.
  FIELD-SYMBOLS <l_nkey>            TYPE lvc_nkey.

  lt_child_nkey = get_all_child_nkeys( i_nkey = i_nkey ).
  CHECK lt_child_nkey IS NOT INITIAL.

  lt_checked_nkey = get_checked_nkeys( ).
  CHECK lt_checked_nkey IS NOT INITIAL.

  LOOP AT lt_checked_nkey ASSIGNING <l_checked_nkey>.
    READ TABLE lt_child_nkey FROM <l_checked_nkey> ASSIGNING <l_nkey>.
    CHECK sy-subrc = 0.
    INSERT <l_nkey> INTO TABLE rt_nkey.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_all_child_nkeys.

  DATA lr_alv_tree        TYPE REF TO cl_gui_alv_tree.

  FIELD-SYMBOLS <l_nkey>  TYPE lvc_nkey.

* Initial checking.
  CHECK i_nkey IS NOT INITIAL.

* Get the alv_tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Get the children
  CALL METHOD lr_alv_tree->get_subtree
    EXPORTING
      i_node_key       = i_nkey
    IMPORTING
      et_subtree_nodes = rt_nkey.

* Remove self from rt_nkey.
  READ TABLE rt_nkey WITH KEY table_line = i_nkey TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.
  CHECK sy-tabix <> 0.
  DELETE rt_nkey INDEX sy-tabix.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_alv_tree.

  TRY.
      rr_alv_tree ?= get_control( ).
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_alv_tree_toolbar.

  DATA lr_alv_tree            TYPE REF TO cl_gui_alv_tree.

  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

  CALL METHOD lr_alv_tree->get_toolbar_object
    IMPORTING
      er_toolbar = rr_toolbar.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_checked_child_models.

  DATA lt_nkey                TYPE lvc_t_nkey.
  DATA lr_model               TYPE REF TO if_ish_gui_model.

  FIELD-SYMBOLS <l_nkey>      TYPE lvc_nkey.

  lt_nkey = get_checked_child_nkeys( i_nkey = i_nkey ).

  LOOP AT lt_nkey ASSIGNING <l_nkey>.
    lr_model = get_model_by_nkey( i_nkey = <l_nkey> ).
    CHECK lr_model IS BOUND.
    INSERT lr_model INTO TABLE rt_model.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_checked_child_nkeys.

  DATA lt_child_nkey                TYPE lvc_t_nkey.
  DATA lt_checked_nkey              TYPE lvc_t_nkey.

  FIELD-SYMBOLS <l_checked_nkey>    TYPE lvc_nkey.
  FIELD-SYMBOLS <l_nkey>            TYPE lvc_nkey.

  lt_child_nkey = get_child_nkeys( i_nkey = i_nkey ).
  CHECK lt_child_nkey IS NOT INITIAL.

  lt_checked_nkey = get_checked_nkeys( ).
  CHECK lt_checked_nkey IS NOT INITIAL.

  LOOP AT lt_checked_nkey ASSIGNING <l_checked_nkey>.
    READ TABLE lt_child_nkey FROM <l_checked_nkey> ASSIGNING <l_nkey>.
    CHECK sy-subrc = 0.
    INSERT <l_nkey> INTO TABLE rt_nkey.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_checked_models.

  DATA lt_nkey                TYPE lvc_t_nkey.
  DATA lr_model               TYPE REF TO if_ish_gui_model.

  FIELD-SYMBOLS <l_nkey>      TYPE lvc_nkey.

  lt_nkey = get_checked_nkeys( ).

  LOOP AT lt_nkey ASSIGNING <l_nkey>.
    lr_model = get_model_by_nkey( i_nkey = <l_nkey> ).
    CHECK lr_model IS BOUND.
    INSERT lr_model INTO TABLE rt_model.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_checked_nkeys.

  DATA lr_alv_tree            TYPE REF TO cl_gui_alv_tree.
  DATA lt_chit                TYPE lvc_t_chit.

  FIELD-SYMBOLS <ls_chit>     TYPE lvc_s_chit.

  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

  CALL METHOD lr_alv_tree->get_checked_items
    IMPORTING
      et_checked_items = lt_chit.

  LOOP AT lt_chit ASSIGNING <ls_chit>.
    INSERT <ls_chit>-nodekey INTO TABLE rt_nkey.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_checked_parent_model.

  rr_parent_model = get_model_by_nkey( i_nkey = get_checked_parent_nkey( i_nkey = i_nkey ) ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_checked_parent_nkey.

  r_parent_nkey = get_parent_nkey( i_nkey = i_nkey ).
  CHECK r_parent_nkey IS NOT INITIAL.

  IF is_nkey_checked( i_nkey = r_parent_nkey ) = abap_false.
    CLEAR r_parent_nkey.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_child_nkeys.

  DATA lr_alv_tree        TYPE REF TO cl_gui_alv_tree.
  DATA lt_nkey            TYPE lvc_t_nkey.
  DATA l_tmp_parent_nkey  TYPE lvc_nkey.

  FIELD-SYMBOLS <l_nkey>  TYPE lvc_nkey.

* Initial checking.
  CHECK i_nkey IS NOT INITIAL.

* Get the alv_tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Get the children
  CALL METHOD lr_alv_tree->get_children
    EXPORTING
      i_node_key  = i_nkey
    IMPORTING
      et_children = rt_nkey.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_model_by_nkey.

  FIELD-SYMBOLS:
    <ls_nkey>  LIKE LINE OF gt_nkey.

  READ TABLE gt_nkey
    WITH TABLE KEY nkey = i_nkey
    ASSIGNING <ls_nkey>.
  CHECK sy-subrc = 0.

  rr_model = <ls_nkey>-r_model.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_nkeys_by_model.

  FIELD-SYMBOLS:
    <ls_model>        LIKE LINE OF gt_model.

  READ TABLE gt_model
    WITH TABLE KEY r_model = ir_model
    ASSIGNING <ls_model>.
  CHECK sy-subrc = 0.

  rt_nkey = <ls_model>-t_nkey.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_nkey_by_child_model.

  DATA lr_alv_tree        TYPE REF TO cl_gui_alv_tree.
  DATA lt_nkey            TYPE lvc_t_nkey.
  DATA l_parent_nkey      TYPE lvc_nkey.
  DATA l_tmp_parent_nkey  TYPE lvc_nkey.

  FIELD-SYMBOLS <l_nkey>  TYPE lvc_nkey.

* Initial checking.
  CHECK ir_child_model IS BOUND.

* Get the alv_tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Get the nkeys for the child_model.
  lt_nkey = get_nkeys_by_model( ir_child_model ).
  CHECK lt_nkey IS NOT INITIAL.

* i_parent_nkey: space means &VIRTUALROOT.
  IF i_parent_nkey IS INITIAL.
    l_parent_nkey = co_nkey_virtualroot.
  ELSE.
    l_parent_nkey = i_parent_nkey.
  ENDIF.

* Now determine "the" nkey.
  LOOP AT lt_nkey ASSIGNING <l_nkey>.
    CALL METHOD lr_alv_tree->get_parent
      EXPORTING
        i_node_key        = <l_nkey>
      IMPORTING
        e_parent_node_key = l_tmp_parent_nkey.
    CHECK l_tmp_parent_nkey = l_parent_nkey.
    r_nkey = <l_nkey>.
    RETURN.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_parent_model_by_nkey.

  rr_model = get_model_by_nkey( i_nkey = get_parent_nkey( i_nkey = i_nkey ) ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_parent_nkey.

  DATA lr_alv_tree    TYPE REF TO cl_gui_alv_tree.

  lr_alv_tree = get_alv_tree( ).

  CHECK lr_alv_tree IS BOUND.

  CALL METHOD lr_alv_tree->get_parent
    EXPORTING
      i_node_key        = i_nkey
    IMPORTING
      e_parent_node_key = r_parent_nkey.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_parent_nkeys.

  DATA l_nkey           TYPE lvc_nkey.

  l_nkey = get_parent_nkey( i_child_nkey ).
  WHILE l_nkey IS NOT INITIAL.
    INSERT l_nkey INTO TABLE rt_parent_nkey.
    l_nkey = get_parent_nkey( l_nkey ).
  ENDWHILE.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_root_nkeys.

  DATA lr_alv_tree            TYPE REF TO cl_gui_alv_tree.

* Get the alv tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Get the root nodes.
  CALL METHOD lr_alv_tree->get_children
    EXPORTING
      i_node_key  = co_nkey_virtualroot
    IMPORTING
      et_children = rt_root_nkey
    EXCEPTIONS
      OTHERS      = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'GET_ROOT_NKEYS'
        i_mv3 = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_selected_model.

  DATA l_selected_nkey    TYPE lvc_nkey.

  l_selected_nkey = get_selected_nkey( ).
  rr_model = get_model_by_nkey( l_selected_nkey ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_selected_models.

  DATA:
    lt_nkey   TYPE lvc_t_nkey,
    lr_model  TYPE REF TO if_ish_gui_model.

  FIELD-SYMBOLS:
    <l_nkey>  TYPE lvc_nkey.

  lt_nkey = get_selected_nkeys( ).

  LOOP AT lt_nkey ASSIGNING <l_nkey>.
    lr_model = get_model_by_nkey( i_nkey = <l_nkey> ).
    CHECK lr_model IS BOUND.
    INSERT lr_model INTO TABLE rt_model.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_selected_nkey.

  DATA lt_nkey                TYPE lvc_t_nkey.

  lt_nkey = get_selected_nkeys( ).

  IF LINES( lt_nkey ) > 1.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '144' ).
  ENDIF.

  READ TABLE lt_nkey
    INDEX 1
    INTO r_nkey.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_selected_nkeys.

  DATA:
    lr_alv_tree      TYPE REF TO cl_gui_alv_tree,
    l_nkey           TYPE lvc_nkey.

* Get the alv tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Get the selected node nkeys from the alv tree.
  CALL METHOD lr_alv_tree->get_selected_nodes
    CHANGING
      ct_selected_nodes = rt_nkey
    EXCEPTIONS
      OTHERS            = 1.
  CHECK sy-subrc = 0.

* If no nodes are selected, get the selected item nkeys from the alv tree.
  IF rt_nkey IS INITIAL.
    CALL METHOD lr_alv_tree->get_selected_item
      IMPORTING
        e_selected_node = l_nkey
      EXCEPTIONS
        OTHERS          = 1.
    CHECK sy-subrc = 0.
    CHECK l_nkey IS NOT INITIAL.
    INSERT l_nkey INTO TABLE rt_nkey.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_tree_view~get_tree_layout.

  TRY.
      rr_tree_layout ?= get_layout( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_tree_view~has_parent_nkey.

  DATA l_nkey           TYPE lvc_nkey.

  l_nkey = get_parent_nkey( i_child_nkey ).
  WHILE l_nkey IS NOT INITIAL.
    IF l_nkey = i_parent_nkey.
      r_has_parent_nkey = abap_true.
      RETURN.
    ENDIF.
    l_nkey = get_parent_nkey( l_nkey ).
  ENDWHILE.

ENDMETHOD.


METHOD if_ish_gui_tree_view~is_nkey_checked.

  DATA lt_nkey            TYPE lvc_t_nkey.

  lt_nkey = get_checked_nkeys( ).

  READ TABLE lt_nkey FROM i_nkey TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_checked = abap_true.

ENDMETHOD.


METHOD if_ish_gui_tree_view~set_selected_model.

  DATA lt_nkeys       TYPE lvc_t_nkey.

  lt_nkeys = get_nkeys_by_model( ir_model = ir_model ).
  r_selected = set_selected_nkeys( lt_nkeys  ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~set_selected_models.

  DATA lt_nkey                TYPE lvc_t_nkey.
  DATA lt_tmp_nkey            TYPE lvc_t_nkey.
  DATA lr_model               TYPE REF TO if_ish_gui_model.

  LOOP AT it_model INTO lr_model.
    lt_tmp_nkey = get_nkeys_by_model( ir_model = lr_model ).
    INSERT LINES OF lt_tmp_nkey INTO TABLE lt_nkey.
  ENDLOOP.

  r_selected = set_selected_nkeys( it_nkey = lt_nkey ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~set_selected_nkey.

  DATA lt_nkey    TYPE lvc_t_nkey.

  CHECK i_nkey IS NOT INITIAL.

  INSERT i_nkey INTO TABLE lt_nkey.
  r_selected = set_selected_nkeys( it_nkey = lt_nkey ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~set_selected_nkeys.

  DATA lt_nkey                      TYPE lvc_t_nkey.
  DATA lr_alv_tree                  TYPE REF TO cl_gui_alv_tree.
  DATA l_tmp_rc                     TYPE sy-subrc.

  FIELD-SYMBOLS <l_nkey>            TYPE lvc_nkey.

* Process only if first display is already done.
  CHECK is_first_display_done( ) = abap_true.

* Get the alv tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Unselect the actual selected nodes.
  lt_nkey = get_selected_nkeys( ).
  CALL METHOD lr_alv_tree->unselect_nodes
    EXPORTING
      it_node_key = lt_nkey
    EXCEPTIONS
      OTHERS      = 1.
  CLEAR lt_nkey.

* Process only on given nkeys.
  LOOP AT it_nkey ASSIGNING <l_nkey>.
    READ TABLE gt_nkey
      WITH TABLE KEY nkey = <l_nkey>
      TRANSPORTING NO FIELDS.
    CHECK sy-subrc = 0.
    INSERT <l_nkey> INTO TABLE lt_nkey.
  ENDLOOP.
  CHECK lt_nkey  IS NOT INITIAL.

* Before setting the selected nodes we have to update the frontend (or else we may have short dump).
  _frontend_update( i_force = abap_true ).

* Set the selected nodes.
  CALL METHOD lr_alv_tree->set_selected_nodes
    EXPORTING
      it_selected_nodes = lt_nkey
    EXCEPTIONS
      OTHERS            = 1.
  l_tmp_rc = sy-subrc.

* Update the frontend.
  _frontend_update( i_force = abap_true ).

* The nodes were selected.
  IF l_tmp_rc = 0.
    r_selected = abap_true.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_tree_view~uncheck_model.

  DATA lt_model           TYPE ish_t_gui_model_objhash.

  CHECK ir_model IS BOUND.

  INSERT ir_model INTO TABLE lt_model.

  rt_unchecked_nkey = uncheck_models( it_model = lt_model ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~uncheck_models.

  DATA lr_model               TYPE REF TO if_ish_gui_model.
  DATA lt_tmp_nkey            TYPE lvc_t_nkey.
  DATA lt_nkey                TYPE lvc_t_nkey.

  FIELD-SYMBOLS <l_nkey>      TYPE lvc_nkey.

  CHECK it_model IS NOT INITIAL.

  LOOP AT it_model INTO lr_model.
    lt_tmp_nkey = get_nkeys_by_model( ir_model = lr_model ).
    LOOP AT lt_tmp_nkey ASSIGNING <l_nkey>.
      READ TABLE lt_nkey FROM <l_nkey> TRANSPORTING NO FIELDS.
      CHECK sy-subrc <> 0.
      APPEND <l_nkey> TO lt_nkey.
    ENDLOOP.
  ENDLOOP.

  rt_unchecked_nkey = uncheck_nkeys( it_nkey = lt_nkey ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~uncheck_nkey.

  DATA lt_nkey            TYPE lvc_t_nkey.

  CHECK i_nkey IS NOT INITIAL.

  INSERT i_nkey INTO TABLE lt_nkey.

  uncheck_nkeys( it_nkey = lt_nkey ).

ENDMETHOD.


METHOD if_ish_gui_tree_view~uncheck_nkeys.

  DATA lt_nkey                              TYPE lvc_t_nkey.
  DATA lr_s_outtab                          TYPE REF TO data.
  DATA lr_alv_tree                          TYPE REF TO cl_gui_alv_tree.
  DATA lt_layi                              TYPE lvc_t_layi.
  DATA lt_laci                              TYPE lvc_t_laci.
  DATA ls_laci                              TYPE lvc_s_laci.

  FIELD-SYMBOLS <l_nkey>                    TYPE lvc_nkey.
  FIELD-SYMBOLS <lt_outtab>                 TYPE table.
  FIELD-SYMBOLS <ls_outtab>                 TYPE data.
  FIELD-SYMBOLS <ls_layi>                   TYPE lvc_s_layi.

* Get the nkeys to uncheck.
  IF it_nkey IS INITIAL.
    lt_nkey = get_checked_nkeys( ).
  ELSE.
    lt_nkey = it_nkey.
  ENDIF.
  CHECK lt_nkey IS NOT INITIAL.

* Get the alv_tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Create an empty outtab line.
  CHECK gr_outtab IS BOUND.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  CREATE DATA lr_s_outtab LIKE LINE OF <lt_outtab>.
  ASSIGN lr_s_outtab->* TO <ls_outtab>.

* Now uncheck the nodes.
  LOOP AT lt_nkey ASSIGNING <l_nkey>.

    CHECK <l_nkey> IS NOT INITIAL.
    REFRESH lt_layi.

*   Get the item layout.
    CALL METHOD lr_alv_tree->get_outtab_line
      EXPORTING
        i_node_key     = <l_nkey>
      IMPORTING
        e_outtab_line  = <ls_outtab>
        et_item_layout = lt_layi
      EXCEPTIONS
        OTHERS         = 1.
    CHECK sy-subrc = 0.

*   Build the changing item layout.
    CLEAR lt_laci.
    LOOP AT lt_layi ASSIGNING <ls_layi>.
      CHECK <ls_layi>-fieldname = cl_gui_alv_tree=>c_hierarchy_column_name.
      CHECK <ls_layi>-chosen = abap_true.
      CLEAR ls_laci.
      MOVE-CORRESPONDING <ls_layi> TO ls_laci.
      ls_laci-chosen    = abap_false.
      ls_laci-u_chosen  = abap_true.
      INSERT ls_laci INTO TABLE lt_laci.
      EXIT.
    ENDLOOP.
    CHECK lt_laci IS NOT INITIAL.

*   Change the node.
    CALL METHOD lr_alv_tree->change_node
      EXPORTING
        i_node_key     = <l_nkey>
        i_outtab_line  = <ls_outtab>
        it_item_layout = lt_laci
      EXCEPTIONS
        OTHERS         = 1.
    CHECK sy-subrc = 0.

*   Handle rt_unchecked_nkey.
    INSERT <l_nkey> INTO TABLE rt_unchecked_nkey.

  ENDLOOP.

* Update the frontend.
  _frontend_update( ).

ENDMETHOD.


METHOD if_ish_gui_view~actualize_layout.

  DATA lr_layout            TYPE REF TO cl_ish_gui_tree_layout.
  DATA lr_alv_tree          TYPE REF TO cl_gui_alv_tree.
  DATA l_hierhead_width     TYPE i.

* Call the super method.
  super->actualize_layout( ).

* Further processing only on existing alv_tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Get the tree layout.
  lr_layout = get_tree_layout( ).
  CHECK lr_layout IS BOUND.

* Adjust the hierhead_width.
  CALL METHOD lr_alv_tree->get_hierarchy_header_width
    IMPORTING
      e_width = l_hierhead_width.
  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      cntl_system_error = 1
      cntl_error        = 2
      OTHERS            = 3.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static_by_syst( ir_object = me ).
  ENDIF.
  g_cb_layout = abap_true.
  TRY.
      lr_layout->set_hierhead_width( i_hierhead_width = l_hierhead_width ).
    CLEANUP.
      g_cb_layout = abap_false.
  ENDTRY.
  g_cb_layout = abap_false.

ENDMETHOD.


METHOD init_tree_view.

  DATA lr_outtab                    TYPE REF TO data.

* Self has to be not initialized.
  IF is_initialized( )            = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'INIT_TREE_VIEW'
        i_mv3 = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

* Create the outtab.
  IF i_outtab_structname IS NOT INITIAL.
    TRY.
        CREATE DATA lr_outtab TYPE (i_outtab_structname).
      CATCH cx_root.                                     "#EC CATCH_ALL
        cl_ish_utl_exception=>raise_static(
            i_typ = 'E'
            i_kla = 'N1BASE'
            i_num = '030'
            i_mv1 = '1'
            i_mv2 = 'INIT_TREE_VIEW'
            i_mv3 = 'CL_ISH_GUI_TREE_VIEW' ).
    ENDTRY.
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  _init_tree_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode
      ir_outtab         = lr_outtab ).

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD on_after_user_command.

  CHECK sender IS BOUND.
  CHECK sender = get_alv_tree( ).

ENDMETHOD.


METHOD on_before_user_command.

  DATA lr_alv_tree            TYPE REF TO cl_gui_alv_tree.
  DATA lt_nkey                TYPE lvc_t_nkey.
  DATA lr_model               TYPE REF TO if_ish_gui_model.

  FIELD-SYMBOLS <l_nkey>      TYPE lvc_nkey.

* Get the alv_tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Check the sender.
  CHECK sender = lr_alv_tree.

* Process the ucomm.
  CASE ucomm.

*   co_fcode_expand.
*   This fcode usually is handled by the alv_tree itself.
*   But we have to first load the child models of the selected nkeys.
*   If no nkeys are selected we have to process_cmd_expand (all nodes will be expanded).
*   On errors we have also to process _cmd_expand (to handle the error messages).
*   If we can load the child models we need not process _cmd_expand (so switch the fcode).
    WHEN co_fcode_expand.
      lt_nkey = get_selected_nkeys( ).
      CHECK lt_nkey IS NOT INITIAL.
      LOOP AT lt_nkey ASSIGNING <l_nkey>.
        lr_model = get_model_by_nkey( i_nkey = <l_nkey> ).
        TRY.
            _load_child_models(
                ir_model      = lr_model
                i_level_count = 99 ).
          CATCH cx_ish_static_handler.
            RETURN.
        ENDTRY.
      ENDLOOP.
      lr_alv_tree->set_user_command( i_fcode = CO_FCODE_NOPROC ).

*   co_fcode_collapse.
*   This fcode usually is handled by the alv_tree itself.
*   But if no nkey is selected we have to collapse the root nodes.
*   In this case we have to process _cmd_collapse.
*   If nkeys are selected we need not process _cmd_collapse (so switch the fcode).
    WHEN co_fcode_collapse.
      lt_nkey = get_selected_nkeys( ).
      CHECK lt_nkey IS INITIAL.
      lr_alv_tree->set_user_command( i_fcode = CO_FCODE_NOPROC ).

  ENDCASE.

ENDMETHOD.


METHOD on_button_click.

  DATA l_col_fieldname            TYPE ish_fieldname.
  DATA lr_node_model              TYPE REF TO if_ish_gui_model.
  DATA lr_tree_request            TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

  l_col_fieldname = fieldname.
  lr_node_model = get_model_by_nkey( i_nkey = node_key ).
  lr_tree_request = cl_ish_gui_tree_event=>create( ir_sender = me
                                             i_fcode         = cl_ish_gui_tree_event=>co_fcode_button_click
                                             ir_node_model   = lr_node_model
                                             i_nkey          = node_key
                                             i_col_fieldname = l_col_fieldname ).

  lr_response = _propagate_request( ir_request = lr_tree_request ).

  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_request
      ir_response = lr_response ).

ENDMETHOD.


method ON_CHECKBOX_CHANGE.

* For default processing redefine this method and implement the following coding:

*  _on_node_checkbox_change(
*      i_nkey      = node_key
*      i_fieldname = fieldname
*      i_checked   = checked ).

ENDMETHOD.


METHOD on_drag.

  DATA lr_node_model              TYPE REF TO if_ish_gui_model.
  DATA lr_tree_request            TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

* Get the node model.
  TRY.
      lr_node_model = get_model_by_nkey( i_nkey = node_key ).
    CATCH cx_ish_static_handler.
      CLEAR lr_node_model.
  ENDTRY.

* Create request
  lr_tree_request = cl_ish_gui_tree_event=>create(
      ir_sender         = me
      i_fcode           = cl_ish_gui_tree_event=>co_fcode_on_drag
      ir_node_model     = lr_node_model
      i_nkey            = node_key
      ir_dragdropobject = drag_drop_object ).

* Propagate the request.
  lr_response = _propagate_request( ir_request = lr_tree_request ).

* after request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_drag_multiple.

  DATA lr_node_model              TYPE REF TO if_ish_gui_model.
  DATA lr_tree_request            TYPE REF TO cl_ish_gui_tree_event.
  DATA lt_node_model              TYPE ish_t_gui_model_obj.
  DATA lt_nkey                    TYPE lvc_t_nkey.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

  FIELD-SYMBOLS <l_nkey>          TYPE lvc_nkey.

* Get the node models.
  LOOP AT node_key_table ASSIGNING <l_nkey>.
    TRY.
        lr_node_model = get_model_by_nkey( i_nkey = <l_nkey> ).
        CHECK lr_node_model IS BOUND.
        APPEND lr_node_model TO lt_node_model.
        APPEND <l_nkey>      TO lt_nkey.
      CATCH cx_ish_static_handler.
        CONTINUE.
    ENDTRY.
  ENDLOOP.

* Create request
  lr_tree_request = cl_ish_gui_tree_event=>create(
      ir_sender         = me
      i_fcode           = cl_ish_gui_tree_event=>co_fcode_on_drag_multiple
      it_node_model     = lt_node_model
      it_nkey           = lt_nkey
      ir_dragdropobject = drag_drop_object ).

* Propagate the request.
  lr_response = _propagate_request( ir_request = lr_tree_request ).

* after request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_drop.

  DATA lr_node_model              TYPE REF TO if_ish_gui_model.
  DATA lr_tree_request            TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

  TRY.
      lr_node_model = get_model_by_nkey( i_nkey = node_key ).
    CATCH cx_ish_static_handler.
      CLEAR lr_node_model.
  ENDTRY.

  lr_tree_request = cl_ish_gui_tree_event=>create(
      ir_sender         = me
      i_fcode           = cl_ish_gui_tree_event=>co_fcode_on_drop
      ir_node_model     = lr_node_model
      i_nkey            = node_key
      ir_dragdropobject = drag_drop_object ).

  lr_response = _propagate_request( ir_request = lr_tree_request ).

  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_dropdown_clicked.

  DATA lr_tree_event            TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_response              TYPE REF TO cl_ish_gui_response.

  lr_tree_event = cl_ish_gui_tree_event=>create_dropdown_clicked(
      ir_sender         = me
      i_fcode_ddclicked = fcode
      i_posx            = posx
      i_posy            = posy ).

  lr_response = _propagate_request( ir_request = lr_tree_event ).

  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_event
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_expand_nc.

  DATA lr_model                       TYPE REF TO if_ish_gui_model.
  DATA lt_child_model                 TYPE ish_t_gui_model_objhash.
*  DATA lr_child_model                 TYPE REF TO if_ish_gui_model.      "MED-48304 M.Rebegea 07.09.2012
  DATA l_activate_on_model_added      TYPE abap_bool.
  DATA l_flush                        TYPE abap_bool.
  DATA lx_static                      TYPE REF TO cx_ish_static_handler.

  FIELD-SYMBOLS <l_child_model_fs>    TYPE REF TO if_ish_gui_model.       "MED-48304 M.Rebegea 07.09.2012

* Process only on valid sender.
  CHECK sender = get_control( ).

* Get the model for the node_key.
  lr_model = get_model_by_nkey( i_nkey = node_key ).
  CHECK lr_model IS BOUND.

* Now we have to deactivate the on_model_added eventhandler
* because we add the child models right here.
* This must be done because the parent model may have already some children.
  IF g_on_model_added_deactivated = abap_false.
    g_on_model_added_deactivated = abap_true.
    l_activate_on_model_added = abap_true.
  ENDIF.

* On any errors we have to reset g_on_model_added_deactivated + flush.
  TRY.

*     For better performance we activate the flush_buffer
*     and flush after processing.
      IF is_flush_buffer_active( ) = abap_false.
        activate_flush_buffer( ).
        l_flush = abap_true.
      ENDIF.

*     Get the child models for the model.
      TRY.
          lt_child_model = _get_child_models( ir_parent_model = lr_model ).
        CATCH cx_ish_static_handler INTO lx_static.
          IF lx_static->gr_errorhandler IS BOUND.
            lx_static->gr_errorhandler->display_messages( ).
          ENDIF.
          RETURN.
      ENDTRY.

*     Add the child models.
*      LOOP AT lt_child_model INTO lr_child_model.           "MED-48304 M.Rebegea 07.09.2012
       LOOP AT lt_child_model ASSIGNING <l_child_model_fs>.  "MED-48304 M.Rebegea 07.09.2012
*        CHECK lr_child_model IS BOUND.                      "MED-48304 M.Rebegea 07.09.2012
         CHECK <l_child_model_fs> IS BOUND.                  "MED-48304 M.Rebegea 07.09.2012
        TRY.
            _add_nodes_by_model( ir_parent_model          = lr_model
*                                 ir_model                 = lr_child_model    "MED-48304 M.Rebegea 07.09.2012
                                 ir_model                 = <l_child_model_fs> "MED-48304 M.Rebegea 07.09.2012
                                 i_calculate_relationship = abap_false ).
          CATCH cx_ish_static_handler INTO lx_static.
            IF lx_static->gr_errorhandler IS BOUND.
              lx_static->gr_errorhandler->display_messages( ).
            ENDIF.
            RETURN.
        ENDTRY.
      ENDLOOP.

*     Register the tabmodel events for the given model.
      _register_tabmdl_events(
          ir_model     = lr_model
          i_activation = abap_true ).

    CLEANUP.
*     Reactivate the on_model_added eventhandler.
      IF l_activate_on_model_added = abap_true.
        g_on_model_added_deactivated = abap_false.
      ENDIF.
*     Now flush.
      IF l_flush = abap_true.
        flush( ).
      ENDIF.

  ENDTRY.

* Reactivate the on_model_added eventhandler.
  IF l_activate_on_model_added = abap_true.
    g_on_model_added_deactivated = abap_false.
  ENDIF.

* Now flush.
  IF l_flush = abap_true.
    flush( ).
  ENDIF.

ENDMETHOD.


METHOD on_flush.

  DATA:
    l_result                   TYPE i.

  FIELD-SYMBOLS:
    <ls_flush_buffer>          LIKE LINE OF gt_flush_buffer.

  LOOP AT gt_flush_buffer ASSIGNING <ls_flush_buffer>.
    CALL METHOD <ls_flush_buffer>-r_alv_tree->is_valid
      IMPORTING
        result = l_result.
    CHECK l_result = 1.
    CHECK <ls_flush_buffer>-r_alv_tree->is_alive( ) <> cl_gui_control=>state_dead.
    <ls_flush_buffer>-r_alv_tree->frontend_update( ).
  ENDLOOP.

  CLEAR: gt_flush_buffer.

ENDMETHOD.


METHOD on_function_selected.

  DATA lr_tree_request            TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.


* Create request
  lr_tree_request = cl_ish_gui_tree_event=>create(
                ir_sender = me
                i_fcode   = fcode ).

* Propagate the request.
  lr_response = _propagate_request( ir_request = lr_tree_request ).

* After request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_hotspot_click.

  DATA l_col_fieldname            TYPE ish_fieldname.
  DATA lr_node_model              TYPE REF TO if_ish_gui_model.
  DATA lr_tree_request            TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

* Propagate the request.
  l_col_fieldname = fieldname.
  lr_node_model = get_model_by_nkey( i_nkey = node_key ).
  lr_tree_request = cl_ish_gui_tree_event=>create( ir_sender = me
                                             i_fcode         = cl_ish_gui_tree_event=>co_fcode_hotspot_click
                                             ir_node_model   = lr_node_model
                                             i_nkey          = node_key
                                             i_col_fieldname = l_col_fieldname ).

  lr_response = _propagate_request( ir_request = lr_tree_request ).

  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_item_ctx_request.

  on_node_ctx_request( menu     = menu
                       node_key = node_key
                       sender   = sender ).

ENDMETHOD.


METHOD on_item_ctx_selected.

  on_node_ctx_selected( fcode    = fcode
                        node_key = node_key
                        sender   = sender ).

ENDMETHOD.


METHOD on_item_double_click.

  DATA l_fieldname              TYPE ish_fieldname.
  DATA lr_node_model            TYPE REF TO if_ish_gui_model.
  DATA lr_tree_request          TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_response              TYPE REF TO cl_ish_gui_response.

  l_fieldname = fieldname.

  lr_node_model    = get_model_by_nkey( i_nkey = node_key ).
  lr_tree_request = cl_ish_gui_tree_event=>create(
      ir_sender       = me
      i_fcode         = cl_ish_gui_tree_event=>co_fcode_item_double_click
      ir_node_model   = lr_node_model
      i_nkey          = node_key
      i_col_fieldname = l_fieldname ).

  lr_response = _propagate_request( ir_request = lr_tree_request ).

  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_request
      ir_response = lr_response ).

ENDMETHOD.


method ON_ITEM_KEYPRESS.
endmethod.


METHOD on_link_click.

  DATA l_col_fieldname            TYPE ish_fieldname.
  DATA lr_tree_request            TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

  l_col_fieldname = fieldname.
  lr_tree_request = cl_ish_gui_tree_event=>create(
      ir_sender       = me
      i_fcode         = cl_ish_gui_tree_event=>co_fcode_link_click
      ir_node_model   = get_model_by_nkey( i_nkey = node_key )
      i_nkey          = node_key
      i_col_fieldname = l_col_fieldname ).

  lr_response = _propagate_request( ir_request = lr_tree_request ).

  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_model_added.

  DATA lr_tmp_model_move      TYPE REF TO if_ish_gui_model.
  DATA lr_tmp_exphier_move    TYPE REF TO cl_ish_gm_structure_simple.
  DATA lr_exphier_model       TYPE REF TO if_ish_gui_model.
  DATA lt_nkey                TYPE lvc_t_nkey.
  DATA l_nkey                 TYPE lvc_nkey.
  DATA lx_root                TYPE REF TO cx_root.

* Process only if this method is active (see on_expand_nc).
  CHECK g_on_model_added_deactivated = abap_false.

* Handle moving.
  lr_tmp_model_move = gr_tmp_model_move.
  CLEAR gr_tmp_model_move.
  lr_tmp_exphier_move = gr_tmp_exphier_move.
  CLEAR gr_tmp_exphier_move.

* Add the nodes.
  TRY.
      CHECK _add_nodes_by_model( ir_parent_model = sender
                                 ir_model        = er_entry ) IS NOT INITIAL.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( ir_exception = lx_root ).
  ENDTRY.

* Handle moving.
  DO 1 TIMES.
    CHECK lr_tmp_model_move IS BOUND.
    CHECK lr_tmp_model_move = er_entry.
    CHECK get_selected_models( ) IS INITIAL.
    TRY.
        set_selected_model( lr_tmp_model_move ).
      CATCH cx_ish_static_handler.
        EXIT.
    ENDTRY.
  ENDDO.
  DO 1 TIMES.
    CHECK lr_tmp_exphier_move IS BOUND.
    TRY.
        CALL METHOD lr_tmp_exphier_move->get_field_content
          EXPORTING
            i_fieldname = 'R_MODEL'
          CHANGING
            c_content   = lr_exphier_model.
      CATCH cx_ish_static_handler.
        EXIT.
    ENDTRY.
    lt_nkey = get_nkeys_by_model( ir_model = lr_exphier_model ).
    CHECK lt_nkey IS NOT INITIAL.
    READ TABLE lt_nkey INTO l_nkey INDEX 1.
    CHECK sy-subrc = 0.
    CHECK l_nkey IS NOT INITIAL.
    TRY.
        _set_expanded_hierarchy(
            i_nkey        = l_nkey
            ir_hierarchy  = lr_tmp_exphier_move ).
      CATCH cx_ish_static_handler.
        EXIT.
    ENDTRY.
  ENDDO.

* Update the frontend.
  _frontend_update( ).

ENDMETHOD.


METHOD on_model_added_adjust.

  DATA lx_root                    TYPE REF TO cx_root.

* Process only if this method is active (see on_expand_nc).
  CHECK g_on_model_added_deactivated = abap_false.

* Adjust the sender.
  TRY.
      CHECK _change_nodes_by_model( ir_model = sender ) IS NOT INITIAL.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( lx_root ).
      RETURN.
  ENDTRY.

* Update the frontend.
  _frontend_update( ).

ENDMETHOD.


METHOD on_model_changed.

  DATA:
    lx_root        TYPE REF TO cx_root.

* Change the nodes.
  TRY.
      _change_nodes_by_model( ir_model         = sender
                              it_changed_field = et_changed_field ).
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( ir_exception = lx_root ).
  ENDTRY.

* Update the frontend.
  _frontend_update( ).

ENDMETHOD.


METHOD on_model_removed.

  DATA lr_tmp_model_move          TYPE REF TO if_ish_gui_model.
  DATA lr_tmp_exphier_move        TYPE REF TO cl_ish_gm_structure_simple.
  DATA lt_nkey                TYPE lvc_t_nkey.
  DATA l_nkey                 TYPE lvc_nkey.
  DATA lx_root                    TYPE REF TO cx_root.

* Handle moving.
  DO 1 TIMES.
    CHECK gr_tmp_model_move IS NOT BOUND.
    CHECK er_entry IS BOUND.
    TRY.
        CHECK er_entry = get_selected_model( ).
      CATCH cx_ish_static_handler.
        EXIT.
    ENDTRY.
    lr_tmp_model_move = er_entry.
  ENDDO.
  DO 1 TIMES.
    CHECK gr_tmp_exphier_move IS NOT BOUND.
    TRY.
        l_nkey = get_selected_nkey( ).
      CATCH cx_ish_static_handler.
        CLEAR l_nkey.
    ENDTRY.
    lt_nkey = get_nkeys_by_model( ir_model = er_entry ).
    CHECK lt_nkey IS NOT INITIAL.
    IF l_nkey IS NOT INITIAL.
      READ TABLE lt_nkey FROM l_nkey TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        CLEAR l_nkey.
      ENDIF.
    ENDIF.
    IF l_nkey IS INITIAL.
      READ TABLE lt_nkey INTO l_nkey INDEX 1.
      CHECK sy-subrc = 0.
    ENDIF.
    CHECK l_nkey IS NOT INITIAL.
    TRY.
        lr_tmp_exphier_move = _get_expanded_hierarchy( i_nkey = l_nkey ).
      CATCH cx_ish_static_handler.
        CLEAR lr_tmp_exphier_move.
    ENDTRY.
  ENDDO.

* Remove the nodes.
  TRY.
      CHECK _remove_nodes_by_model( ir_parent_model = sender
                                    ir_model        = er_entry ) IS NOT INITIAL.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( lx_root ).
  ENDTRY.

* Handle moving.
  gr_tmp_model_move = lr_tmp_model_move.
  gr_tmp_exphier_move = lr_tmp_exphier_move.

* Update the frontend.
  _frontend_update( ).

ENDMETHOD.


METHOD on_model_removed_adjust.

  DATA lx_root                    TYPE REF TO cx_root.

* Adjust the sender.
  TRY.
      CHECK _change_nodes_by_model( ir_model = sender ) IS NOT INITIAL.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( lx_root ).
      RETURN.
  ENDTRY.

* Update the frontend.
  _frontend_update( ).

ENDMETHOD.


METHOD on_node_ctx_request.

  DATA lr_tree_request            TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

  lr_tree_request = cl_ish_gui_tree_event=>create_node_ctx_request(
      ir_sender     = me
      ir_ctmenu     = menu
      ir_node_model = get_model_by_nkey( node_key )
      i_nkey        = node_key
      it_node_model = get_selected_models( )
      it_nkey       = get_selected_nkeys( ) ).

  lr_response = _propagate_request( ir_request = lr_tree_request ).

  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_node_ctx_selected.

  DATA lr_tree_request            TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

  lr_tree_request = cl_ish_gui_tree_event=>create(
      ir_sender     = me
      i_fcode       = fcode
      ir_node_model = get_model_by_nkey( i_nkey = node_key ) ).

  lr_response = _propagate_request( ir_request = lr_tree_request ).

  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD on_node_double_click.

  DATA lr_node_model              TYPE REF TO if_ish_gui_model.
  DATA lr_tree_request            TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_response                TYPE REF TO cl_ish_gui_response.

  lr_node_model   = get_model_by_nkey( i_nkey = node_key ).
  lr_tree_request = cl_ish_gui_tree_event=>create(
      ir_sender     = me
      i_fcode       = cl_ish_gui_tree_event=>co_fcode_node_double_click
      ir_node_model = lr_node_model
      i_nkey        = node_key ).

  lr_response = _propagate_request( ir_request = lr_tree_request  ).

  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_tree_request
      ir_response = lr_response ).

ENDMETHOD.


method ON_NODE_KEYPRESS.
endmethod.


METHOD _add_fvar_button_to_toolbar.

  CHECK ir_toolbar IS BOUND.
  CHECK ir_button IS BOUND.

  r_added = ir_button->add_to_toolbar(
               ir_toolbar   = ir_toolbar
               i_disabled   = _is_fcode_disabled( ir_button->get_fcode( ) )
               i_buttontype = _get_fcode_buttontype( ir_button->get_fcode( ) ) ).

ENDMETHOD.


METHOD _add_fvar_function_to_ctmenu.

  CHECK ir_ctmenu IS BOUND.
  CHECK ir_function IS BOUND.

  ir_function->add_to_ctmenu(
      ir_ctmenu   = ir_ctmenu
      i_disabled  = _is_fcode_disabled( ir_function->get_fcode( ) ) ).

  r_added = abap_true.

ENDMETHOD.


METHOD _add_node.

  DATA:
    lr_alv_tree        TYPE REF TO cl_gui_alv_tree,
    ls_nkey            LIKE LINE OF gt_nkey,
    ls_model           LIKE LINE OF gt_model,
    l_nkey_added       TYPE abap_bool,
    lr_structmdl       TYPE REF TO if_ish_gui_structure_model,
    lr_tabmdl          TYPE REF TO if_ish_gui_table_model,
    l_parent_nkey      TYPE lvc_nkey.

  FIELD-SYMBOLS:
    <ls_model>         LIKE LINE OF gt_model.

* Get the alv tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Add the node to the alv tree.
  CALL METHOD lr_alv_tree->add_node
    EXPORTING
      i_relat_node_key = i_relat_nkey
      i_relationship   = i_relationship
      is_outtab_line   = is_outtab
      is_node_layout   = is_layn
      it_item_layout   = it_layi
      i_node_text      = i_node_text
    IMPORTING
      e_new_node_key   = r_nkey
    EXCEPTIONS
      OTHERS           = 1.
  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* Further processing only if the model is specified.
  CHECK ir_model IS BOUND.

* We have to adjust gt_nkey + gt_model.
* On errors we have to undo processing.
  TRY.

*     Adjust gt_nkey.
      IF i_relationship = cl_gui_column_tree=>relat_first_child OR
         i_relationship = cl_gui_column_tree=>relat_last_child.
        l_parent_nkey = i_relat_nkey.
      ELSE.
        l_parent_nkey = get_parent_nkey( i_relat_nkey ).
      ENDIF.
      ls_nkey-nkey        = r_nkey.
      ls_nkey-parent_nkey = l_parent_nkey.
      ls_nkey-r_model     = ir_model.
      INSERT ls_nkey INTO TABLE gt_nkey.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE cx_ish_static_handler.
      ENDIF.
      l_nkey_added = abap_true.

*     Adjust gt_model.
      READ TABLE gt_model
        WITH TABLE KEY r_model = ir_model
        ASSIGNING <ls_model>.
      IF sy-subrc = 0.
        INSERT r_nkey INTO TABLE <ls_model>-t_nkey.
      ELSE.
        ls_model-r_model = ir_model.
        INSERT r_nkey INTO TABLE ls_model-t_nkey.
        INSERT ls_model INTO TABLE gt_model.
      ENDIF.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE cx_ish_static_handler.
      ENDIF.

    CLEANUP.

*     An error has occured during adjusting gt_nkey or gt_model.
*     Now we have to undo processing.
      IF l_nkey_added = abap_true.
        DELETE TABLE gt_nkey WITH TABLE KEY nkey = r_nkey.
      ENDIF.
      CALL METHOD lr_alv_tree->delete_subtree
        EXPORTING
          i_node_key                = r_nkey
          i_update_parents_expander = abap_true
        EXCEPTIONS
          OTHERS                    = 1.

  ENDTRY.

* The node was successfully added.
* Now we register self for the structmodel events.
  _register_structmdl_events(
      ir_model     = ir_model
      i_activation = abap_true ).

ENDMETHOD.


METHOD _add_nodes_by_model.

  DATA lr_outtab_entry    TYPE REF TO data.
  DATA l_node_text        TYPE lvc_value.
  DATA ls_layn            TYPE lvc_s_layn.
  DATA lt_layi            TYPE lvc_t_layi.
  DATA lt_nkey_parent     TYPE lvc_t_nkey.
  DATA l_relat_nkey       TYPE lvc_nkey.
  DATA l_relationship     TYPE i.
  DATA l_nkey             TYPE lvc_nkey.

  FIELD-SYMBOLS:
    <lt_outtab>        TYPE table,
    <ls_outtab>        TYPE data,
    <l_nkey_parent>    TYPE lvc_nkey.

* The node model has to be specified.
  CHECK ir_model IS BOUND.

* Check if the model is valid.
  CHECK _is_model_valid( ir_model ) = abap_true.

* The outtab reference has to be bound.
  CHECK gr_outtab IS BOUND.

* Create an empty outtab entry.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  CREATE DATA lr_outtab_entry LIKE LINE OF <lt_outtab>.
  ASSIGN lr_outtab_entry->* TO <ls_outtab>.

* Fill the new outtab entry.
  CALL METHOD _fill_outtab_line
    EXPORTING
      ir_model  = ir_model
    CHANGING
      cs_outtab = <ls_outtab>.

* Get the node layout.
  ls_layn = _get_layn( ir_model  = ir_model
                       is_outtab = <ls_outtab> ).

* Get the item layout.
  lt_layi = _get_layi( ir_model  = ir_model
                       is_outtab = <ls_outtab> ).

* Get the node text.
  l_node_text = _get_node_text( ir_model  = ir_model
                                is_outtab = <ls_outtab> ).

* Get the nkeys for the parent model.
  IF ir_parent_model IS BOUND.
    lt_nkey_parent = get_nkeys_by_model( ir_model = ir_parent_model ).
    IF lt_nkey_parent IS INITIAL AND ir_parent_model = _get_main_model( ).
      APPEND space TO lt_nkey_parent.
    ENDIF.
  ELSE.
    APPEND space TO lt_nkey_parent.
  ENDIF.

* Add the nodes.
* But add nodes only under those parents which do not already have the child model.
  LOOP AT lt_nkey_parent ASSIGNING <l_nkey_parent>.
    CHECK get_nkey_by_child_model(
        i_parent_nkey   = <l_nkey_parent>
        ir_child_model  = ir_model ) IS INITIAL.
    CALL METHOD _get_relat_4_new_model
      EXPORTING
        i_parent_nkey            = <l_nkey_parent>
        ir_model                 = ir_model
        i_calculate_relationship = i_calculate_relationship
      IMPORTING
        e_relat_nkey             = l_relat_nkey
        e_relationship           = l_relationship.
    l_nkey = _add_node( ir_model        = ir_model
                        i_relat_nkey    = l_relat_nkey
                        i_relationship  = l_relationship
                        is_outtab       = <ls_outtab>
                        is_layn         = ls_layn
                        it_layi         = lt_layi
                        i_node_text     = l_node_text ).
    CHECK l_nkey IS NOT INITIAL.
    APPEND l_nkey TO rt_nkey_added.
  ENDLOOP.

ENDMETHOD.


METHOD _add_tree_to_flush_buffer.

  DATA:
    ls_flush_buffer            LIKE LINE OF gt_flush_buffer.

  CHECK ir_alv_tree IS BOUND.

  ls_flush_buffer-r_alv_tree = ir_alv_tree.
  INSERT ls_flush_buffer INTO TABLE gt_flush_buffer.

ENDMETHOD.


METHOD _adjust_child_nodes_cbxchg.

  DATA lt_child_nkey                TYPE lvc_t_nkey.
  DATA lt_tmp_nkey                  TYPE lvc_t_nkey.
  DATA l_tmp_nkey                   TYPE lvc_nkey.

  FIELD-SYMBOLS <l_tmp_nkey>        TYPE lvc_nkey.

* Initial checking.
  CHECK i_nkey IS NOT INITIAL.
  CHECK ir_model IS BOUND.

* Load the child models.
  CHECK _load_child_models( ir_model ) = abap_true.

* Get the child nkeys to process.
  lt_child_nkey = _get_child_nkeys_cbxchg(
      i_orig_nkey = i_orig_nkey
      i_nkey      = i_nkey
      ir_model    = ir_model
      i_checked   = i_checked ).
  CHECK  lt_child_nkey IS NOT INITIAL.

* Expand the given node.
  IF i_expand = abap_true.
    expand_node( i_nkey ).
  ENDIF.

* Check/Uncheck the child nkeys.
  IF i_checked = abap_true.
    lt_tmp_nkey = check_nkeys( lt_child_nkey ).
  ELSE.
    lt_tmp_nkey = uncheck_nkeys( lt_child_nkey ).
  ENDIF.
  CHECK lt_tmp_nkey IS NOT INITIAL.

* Process _adjust_child_nodes_cbxchg for the changed child nodes.
  LOOP AT lt_tmp_nkey ASSIGNING <l_tmp_nkey> .
    _adjust_child_nodes_cbxchg(
        i_orig_nkey = i_orig_nkey
        i_nkey      = <l_tmp_nkey>
        ir_model    = get_model_by_nkey( <l_tmp_nkey> )
        i_checked   = i_checked
        i_expand    = i_expand ).
  ENDLOOP.

* Export.
  r_changed = abap_true.

ENDMETHOD.


METHOD _adjust_nodes_to_vcode.

  DATA ls_nkey   LIKE LINE OF gt_nkey.
  DATA l_changed TYPE abap_bool.

  LOOP AT gt_nkey  INTO ls_nkey.
    CALL METHOD me->_change_node_by_model
      EXPORTING
        ir_model         = ls_nkey-r_model
        i_nkey           = ls_nkey-nkey
*        it_changed_field =
      RECEIVING
        r_changed        = l_changed.
    IF l_changed = abap_true.
      r_changed = l_changed.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD _adjust_parent_node_cbxchg.

  DATA l_parent_nkey                TYPE lvc_nkey.
  DATA lt_tmp_nkey                  TYPE lvc_t_nkey.

* Initial checking.
  CHECK i_nkey IS NOT INITIAL.
  CHECK ir_model IS BOUND.

* Get the parent_nkey.
  l_parent_nkey = _get_parent_nkey_cbxchg(
      i_orig_nkey = i_orig_nkey
      i_nkey      = i_nkey
      ir_model    = ir_model
      i_checked   = i_checked ).
  CHECK l_parent_nkey IS NOT INITIAL.

* Check/Uncheck the parent.
  CLEAR lt_tmp_nkey.
  INSERT l_parent_nkey INTO TABLE lt_tmp_nkey.
  IF i_checked = abap_true.
    CHECK check_nkeys( lt_tmp_nkey ) IS NOT INITIAL.
  ELSE.
    CHECK uncheck_nkeys( lt_tmp_nkey ) IS NOT INITIAL.
  ENDIF.

* Process _adjust_parent_node_cbxchg for the parent.
  _adjust_parent_node_cbxchg(
      i_orig_nkey = i_orig_nkey
      i_nkey      = l_parent_nkey
      ir_model    = get_model_by_nkey( l_parent_nkey )
      i_checked   = i_checked ).

* Export.
  r_changed = abap_true.

ENDMETHOD.


METHOD _build_ctmenu_fvar.

  DATA lr_button                TYPE REF TO cl_ish_fvar_button.
  DATA lt_function              TYPE ish_t_fvar_function_obj.
  DATA lr_function              TYPE REF TO cl_ish_fvar_function.

  CHECK ir_toolbar IS BOUND.
  CHECK ir_fvar IS BOUND.
  CHECK i_fcode IS NOT INITIAL.

  lr_button = ir_fvar->get_button_by_fcode( i_fcode = i_fcode ).
  CHECK lr_button IS BOUND.

  lt_function = lr_button->get_all_functions( ).
  CHECK lt_function IS NOT INITIAL.

  CREATE OBJECT rr_ctmenu.

  LOOP AT lt_function INTO lr_function.
    _add_fvar_function_to_ctmenu(
        ir_ctmenu   = rr_ctmenu
        ir_function = lr_function ).
  ENDLOOP.

ENDMETHOD.


METHOD _build_ctmenu_own.
ENDMETHOD.


METHOD _build_excluding_functions.

  APPEND cl_gui_alv_tree=>mc_fc_calculate         TO rt_exclfunc.
  APPEND cl_gui_alv_tree=>mc_fc_print_back        TO rt_exclfunc.
  APPEND cl_gui_alv_tree=>mc_fc_print_prev        TO rt_exclfunc.

ENDMETHOD.


METHOD _build_fcat.

  DATA lr_tabledescr                    TYPE REF TO cl_abap_tabledescr.
  DATA lr_structdescr                   TYPE REF TO cl_abap_structdescr.
  DATA l_outtab_structname              TYPE dd02l-tabname.
  DATA l_clsname                        TYPE seoclsname.
  DATA l_rc                             TYPE ish_method_rc.
  DATA lr_errorhandler                  TYPE REF TO cl_ishmed_errorhandling.

  FIELD-SYMBOLS <lt_outtab>             TYPE table.
  FIELD-SYMBOLS <ls_fcat>               TYPE lvc_s_fcat.

* The outtab structure has to be bound.
  IF gr_outtab IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.
  ASSIGN gr_outtab->* TO <lt_outtab>.

* Get the outtab structure name.
  TRY.
      lr_tabledescr ?= cl_abap_typedescr=>describe_by_data( p_data = <lt_outtab> ).
      lr_structdescr ?= lr_tabledescr->get_table_line_type( ).
      l_outtab_structname = lr_structdescr->get_relative_name( ).
    CATCH cx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDTRY.

* Build the default fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = l_outtab_structname
    CHANGING
      ct_fieldcat            = rt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    l_clsname = cl_ish_utl_rtti=>get_class_name( me ).
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '011'
        i_mv1           = l_rc
        i_mv2           = 'GR_ALV_TREE'
        i_mv3           = l_clsname
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  IF l_outtab_structname = 'RN1_GUI_OT_TREE_DUMMY'.
    LOOP AT rt_fcat ASSIGNING <ls_fcat>.
      CASE <ls_fcat>-fieldname.
        WHEN 'DUMMY'.
          <ls_fcat>-tech = abap_true.
      ENDCASE.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD _build_hierarchy_header.

  DATA lr_layout                    TYPE REF TO cl_ish_gui_tree_layout.

  lr_layout = get_tree_layout( ).
  CHECK lr_layout IS BOUND.

  rs_hierarchy_header-width     = lr_layout->get_hierhead_width( ).
  rs_hierarchy_header-heading   = lr_layout->get_hierhead_heading( ).
  rs_hierarchy_header-tooltip   = lr_layout->get_hierhead_tooltip( ).

ENDMETHOD.


METHOD _build_tbmenu_fvar.

  DATA lt_button                  TYPE ish_t_fvar_button_obj.
  DATA lr_button                  TYPE REF TO cl_ish_fvar_button.
  DATA l_add_separator            TYPE abap_bool.

  CHECK ir_toolbar IS BOUND.
  CHECK ir_fvar IS BOUND.

* Add the buttons.
  lt_button = ir_fvar->get_all_buttons( ).
  LOOP AT lt_button INTO lr_button.
    IF _add_fvar_button_to_toolbar(
            ir_toolbar  = ir_toolbar
            ir_button   = lr_button ) = abap_true.
      l_add_separator = abap_true.
    ENDIF.
  ENDLOOP.

* Separator
  IF l_add_separator = abap_true.
    CALL METHOD ir_toolbar->add_button
      EXPORTING
        fcode     = space
        icon      = space
        butn_type = cntb_btype_sep
      EXCEPTIONS
        OTHERS    = 1.
  ENDIF.

ENDMETHOD.


METHOD _build_tbmenu_own.

* No default processing.

ENDMETHOD.


METHOD _build_toolbar_menu.

  DATA lr_layout            TYPE REF TO cl_ish_gui_tree_layout.
  DATA lr_fvar              TYPE REF TO cl_ish_fvar.

  CHECK ir_toolbar IS BOUND.

* Delete all buttons.
  CALL METHOD ir_toolbar->delete_all_buttons
    EXCEPTIONS
      OTHERS = 1.

* Get the fvar.
  lr_layout = get_tree_layout( ).
  CHECK lr_layout IS BOUND.
  lr_fvar = lr_layout->get_fvar( ).
* Reload the fvar (might be changed in the meantime).
  IF lr_fvar IS BOUND.
    lr_fvar->reload( ).
  ENDIF.

* If we have a fvar we build the toolbar by the fvar.
* If not we build an own toolbar.
  IF lr_fvar IS BOUND.
    _build_tbmenu_fvar(
        ir_toolbar  = ir_toolbar
        ir_fvar     = lr_fvar ).
  ELSE.
    _build_tbmenu_own(
        ir_toolbar  = ir_toolbar ).
  ENDIF.

ENDMETHOD.


METHOD _build_variant.

  DATA lr_application       TYPE REF TO if_ish_gui_application.
  DATA lr_layout            TYPE REF TO cl_ish_gui_tree_layout.
*  DATA l_layout_variant     TYPE slis_vari.
*  DATA ls_user_variant      TYPE disvariant.

  CLEAR es_variant.
  CLEAR e_save.

  lr_application = get_application( ).
  CHECK lr_application IS BOUND.

* Default settings.
  es_variant-report   = lr_application->build_alv_variant_report( ir_view = me ).
  es_variant-handle   = 'TREE'.
  es_variant-username = sy-uname.
  IF cl_ish_utl_base=>get_auth_vm_def( ) = abap_true.
    e_save = 'A'.
  ELSE.
    e_save = 'U'.
  ENDIF.

* If the layout has a variant we use it.
  lr_layout = get_tree_layout( ).
  IF lr_layout IS BOUND.
    es_variant-variant = lr_layout->get_disvar_variant( ).
  ENDIF.
** If the layout has a variant we use it.
** But only if we do not have a default user-specific disvariant.
*  DO 1 TIMES.
*    lr_layout = get_tree_layout( ).
*    CHECK lr_layout IS BOUND.
*    l_layout_variant = lr_layout->get_disvar_variant( ).
*    CHECK l_layout_variant IS NOT INITIAL.
*    ls_user_variant-report = es_variant-report.
*    CALL FUNCTION 'LVC_VARIANT_DEFAULT_GET'
*      EXPORTING
*        i_save     = 'U'
*      CHANGING
*        cs_variant = ls_user_variant
*      EXCEPTIONS
*        OTHERS     = 1.
*    IF sy-subrc = 0.
*      CHECK ls_user_variant-username IS INITIAL.
*    ENDIF.
*    es_variant-variant = l_layout_variant.
*  ENDDO.

ENDMETHOD.


METHOD _change_node.

  DATA:
    lr_alv_tree      TYPE REF TO cl_gui_alv_tree.

* Get the alv tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Change the node.
  CALL METHOD lr_alv_tree->change_node
    EXPORTING
      i_node_key     = i_nkey
      i_outtab_line  = is_outtab
      is_node_layout = is_lacn
      it_item_layout = it_laci
      i_node_text    = i_node_text
      i_u_node_text  = i_node_text_x
    EXCEPTIONS
      OTHERS         = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = '_CHANGE_NODE'
        i_mv3 = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

* The node was changed.
  r_changed = abap_true.

ENDMETHOD.


METHOD _change_nodes_by_model.

  DATA:
    lt_nkey            TYPE lvc_t_nkey.

  FIELD-SYMBOLS:
    <l_nkey>           TYPE lvc_nkey.

* Check if the model is valid.
  CHECK _is_model_valid( ir_model ) = abap_true.

* Get the nkeys for the model.
  lt_nkey = get_nkeys_by_model( ir_model = ir_model ).

* Change the nodes.
  LOOP AT lt_nkey ASSIGNING <l_nkey>.
    CHECK _change_node_by_model( ir_model         = ir_model
                                 i_nkey           = <l_nkey>
                                 it_changed_field = it_changed_field ) = abap_true.
    INSERT <l_nkey> INTO TABLE rt_nkey_changed.
  ENDLOOP.

ENDMETHOD.


METHOD _change_node_by_model.

  DATA:
    lr_alv_tree              TYPE REF TO cl_gui_alv_tree,
    lr_outtab_entry          TYPE REF TO data,
    lr_new_outtab_entry      TYPE REF TO data,
    l_node_text              TYPE lvc_value,
    l_new_node_text          TYPE lvc_value,
    l_node_text_x            TYPE abap_bool,
    ls_layn                  TYPE lvc_s_layn,
    lt_layi                  TYPE lvc_t_layi,
    ls_lacn                  TYPE lvc_s_lacn,
    lt_laci                  TYPE lvc_t_laci.

  FIELD-SYMBOLS:
    <lt_outtab>              TYPE table,
    <ls_outtab>              TYPE data,
    <ls_new_outtab>          TYPE data.

* The model has to be specified.
  CHECK ir_model IS BOUND.

* The nkey has to be specified.
  CHECK i_nkey IS NOT INITIAL.

* The outtab reference has to be bound.
  CHECK gr_outtab IS BOUND.
  ASSIGN gr_outtab->* TO <lt_outtab>.

* Get the alv tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Create an outtab entry for the actual line.
  CREATE DATA lr_outtab_entry LIKE LINE OF <lt_outtab>.
  ASSIGN lr_outtab_entry->* TO <ls_outtab>.

* Get the outtab entry from the alv tree.
  CALL METHOD lr_alv_tree->get_outtab_line
    EXPORTING
      i_node_key     = i_nkey
    IMPORTING
      e_outtab_line  = <ls_outtab>
      e_node_text    = l_node_text
      et_item_layout = lt_layi
      es_node_layout = ls_layn
    EXCEPTIONS
      OTHERS         = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = '_CHANGE_NODE_BY_MODEL'
        i_mv3 = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

* Create an outtab entry for the new line.
  CREATE DATA lr_new_outtab_entry LIKE LINE OF <lt_outtab>.
  ASSIGN lr_new_outtab_entry->* TO <ls_new_outtab>.
  <ls_new_outtab> = <ls_outtab>.

* Fill the outtab entry.
  CALL METHOD _fill_outtab_line
    EXPORTING
      ir_model         = ir_model
      it_changed_field = it_changed_field
    CHANGING
      cs_outtab        = <ls_new_outtab>.

* Get the node layout.
  ls_lacn = _get_lacn( ir_model  = ir_model
                       i_nkey    = i_nkey
                       is_outtab = <ls_outtab>
                       is_layn   = ls_layn ).

* Get the item layout.
  lt_laci = _get_laci( ir_model  = ir_model
                       i_nkey    = i_nkey
                       is_outtab = <ls_outtab>
                       it_layi   = lt_layi ).

* Get the new node text.
  l_new_node_text = _get_node_text( ir_model  = ir_model
                                    is_outtab = <ls_outtab> ).
  IF l_new_node_text <> l_node_text.
    l_node_text_x = abap_true.
  ENDIF.

* If nothing changed -> do nothing.
  CHECK <ls_new_outtab> <> <ls_outtab> OR
        ls_lacn IS NOT INITIAL         OR
        lt_laci IS NOT INITIAL         OR
        l_node_text_x = abap_true.

* Change the node.
  r_changed = _change_node( ir_model      = ir_model
                            i_nkey        = i_nkey
                            is_outtab     = <ls_new_outtab>
                            is_lacn       = ls_lacn
                            it_laci       = lt_laci
                            i_node_text   = l_new_node_text
                            i_node_text_x = l_node_text_x ).

ENDMETHOD.


METHOD _change_toolbar_menu.

  DATA l_disabled                     TYPE abap_bool.
  DATA l_enabled                      TYPE abap_bool.

  FIELD-SYMBOLS <ls_button>           TYPE stb_button.

  CHECK ir_toolbar IS BOUND.

  LOOP AT ir_toolbar->m_table_button ASSIGNING <ls_button>.
    l_disabled = _is_fcode_disabled( <ls_button>-function ).
    CHECK l_disabled <> <ls_button>-disabled.
    IF l_disabled = abap_true.
      l_enabled = abap_false.
    ELSE.
      l_enabled = abap_true.
    ENDIF.
    CALL METHOD ir_toolbar->set_button_state
      EXPORTING
        enabled = l_enabled
        fcode   = <ls_button>-function
      EXCEPTIONS
        OTHERS  = 1.
  ENDLOOP.

ENDMETHOD.


METHOD _check_r_outtab.

  DATA lr_typedescr         TYPE REF TO cl_abap_typedescr.
  DATA lr_tabledescr        TYPE REF TO cl_abap_tabledescr.

  IF ir_outtab IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_R_OUTTAB'
        i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

  CALL METHOD cl_abap_typedescr=>describe_by_data_ref
    EXPORTING
      p_data_ref  = ir_outtab
    RECEIVING
      p_descr_ref = lr_typedescr
    EXCEPTIONS
      OTHERS      = 1.
  IF sy-subrc <> 0 OR
     lr_typedescr IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_CHECK_R_OUTTAB'
        i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

  TRY.
      lr_tabledescr ?= lr_typedescr.
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '3'
          i_mv2        = '_CHECK_R_OUTTAB'
          i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDTRY.

  IF lr_tabledescr->table_kind <> lr_tabledescr->tablekind_std.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '4'
        i_mv2        = '_CHECK_R_OUTTAB'
        i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _cmd_collapse.

  DATA l_nkey             TYPE lvc_nkey.
  DATA lt_nkey            TYPE lvc_t_nkey.

  CHECK ir_tree_event IS BOUND.

* Get the nkeys.
  l_nkey = ir_tree_event->get_nkey( ).
  IF l_nkey IS INITIAL.
    lt_nkey = get_selected_nkeys( ).
  ELSE.
    APPEND l_nkey TO lt_nkey.
  ENDIF.

* Collapse.
* On no nkeys collapse all.
  IF lt_nkey IS INITIAL.
    collapse_all_nodes( ).
  ELSE.
    collapse_nodes( it_nkey = lt_nkey ).
  ENDIF.

ENDMETHOD.


METHOD _cmd_dropdown_clicked.

  DATA lr_toolbar               TYPE REF TO cl_gui_toolbar.
  DATA lr_layout                TYPE REF TO cl_ish_gui_tree_layout.
  DATA lr_fvar                  TYPE REF TO cl_ish_fvar.
  DATA lr_ctmenu                TYPE REF TO cl_ctmenu.

  CHECK ir_tree_event IS BOUND.

  r_cmdresult = co_cmdresult_processed.

* Get the toolbar.
  lr_toolbar = get_alv_tree_toolbar( ).
  CHECK lr_toolbar IS BOUND.

* Get the fvar.
  lr_layout = get_tree_layout( ).
  CHECK lr_layout IS BOUND.
  TRY.
      lr_fvar = lr_layout->get_fvar( ).
    CATCH cx_ish_static_handler.
      CLEAR lr_fvar.
  ENDTRY.

* If we have a fvar we build the ctmenu by the fvar.
* If not we build an own ctmenu.
  IF lr_fvar IS BOUND.
    lr_ctmenu = _build_ctmenu_fvar(
        ir_toolbar  = lr_toolbar
        ir_fvar     = lr_fvar
        i_fcode     = ir_tree_event->get_fcode_ddclicked( ) ).
  ELSE.
    lr_ctmenu = _build_ctmenu_own(
        ir_toolbar  = lr_toolbar
        i_fcode     = ir_tree_event->get_fcode_ddclicked( ) ).
  ENDIF.
  CHECK lr_ctmenu IS BOUND.

* Track the ctmenu.
  CALL METHOD lr_toolbar->track_context_menu
    EXPORTING
      context_menu = lr_ctmenu
      posx         = ir_tree_event->get_posx( )
      posy         = ir_tree_event->get_posy( )
    EXCEPTIONS
      OTHERS       = 0.

ENDMETHOD.


METHOD _cmd_expand.

  DATA l_nkey             TYPE lvc_nkey.
  DATA lt_nkey            TYPE lvc_t_nkey.

  CHECK ir_tree_event IS BOUND.

* Get the nkeys.
  l_nkey = ir_tree_event->get_nkey( ).
  IF l_nkey IS INITIAL.
    lt_nkey = get_selected_nkeys( ).
  ELSE.
    APPEND l_nkey TO lt_nkey.
  ENDIF.

* Expand.
* On no nkeys expand all.
  IF lt_nkey IS INITIAL.
    expand_all_nodes( ).
  ELSE.
    expand_nodes(
        it_nkey          = lt_nkey
        i_expand_subtree = abap_true ).
  ENDIF.

ENDMETHOD.


METHOD _cmd_node_ctx_request.

  r_cmdresult = co_cmdresult_noproc.

ENDMETHOD.


METHOD _cmd_on_drag.

  DATA lr_dragdropobject            TYPE REF TO cl_dragdropobject.
  DATA lt_node_model                TYPE ish_t_gui_model_obj.
  DATA lr_node_model                TYPE REF TO if_ish_gui_model.
  DATA lr_table_model               TYPE REF TO cl_ish_gm_table.
  DATA lr_info_object               TYPE REF TO object.
  DATA lr_drop_processor            TYPE REF TO if_ish_gui_drop_processor.


  CHECK ir_tree_event IS BOUND.

  lr_dragdropobject = ir_tree_event->get_dragdropobject( ).
  CHECK lr_dragdropobject IS BOUND.

  CASE ir_tree_event->get_fcode( ).
    WHEN cl_ish_gui_tree_event=>co_fcode_on_drag.
      lr_info_object = ir_tree_event->get_node_model( ).
    WHEN cl_ish_gui_tree_event=>co_fcode_on_drag_multiple.
      lt_node_model = ir_tree_event->get_t_node_model( ).
      lr_table_model = cl_ish_gm_table=>create( ).
      CHECK lr_table_model IS BOUND.
      LOOP AT lt_node_model INTO lr_node_model.
        CHECK lr_node_model IS BOUND.
        CHECK lr_table_model->has_entry( ir_entry = lr_node_model ) = abap_false.
        lr_table_model->add_entry( ir_entry = lr_node_model ).
      ENDLOOP.
      lr_info_object = lr_table_model.
  ENDCASE.

* Set the dragdropobject->object.
  TRY.
      lr_drop_processor ?= me.
      CREATE OBJECT lr_dragdropobject->object
        TYPE
        cl_ish_gui_drag_object
        EXPORTING
          ir_drag_view      = me
          ir_drag_request   = ir_tree_event
          ir_drop_processor = lr_drop_processor
          ir_info_object    = lr_info_object.
    CATCH cx_sy_move_cast_error.
      lr_dragdropobject->object = lr_info_object.
  ENDTRY.

ENDMETHOD.


METHOD _CMD_ON_DRAG_MULTIPLE.

  DATA lr_dragdropobject      TYPE REF TO cl_dragdropobject.

  CHECK ir_tree_event IS BOUND.

  lr_dragdropobject = ir_tree_event->get_dragdropobject( ).
  CHECK lr_dragdropobject IS BOUND.

  lr_dragdropobject->object = ir_tree_event->get_node_model( ).

ENDMETHOD.


METHOD _cmd_on_drop.

  DATA lr_dragdropobject        TYPE REF TO cl_dragdropobject.
  DATA lr_drag_object           TYPE REF TO cl_ish_gui_drag_object.
  DATA lr_drop_processor        TYPE REF TO if_ish_gui_drop_processor.

* Check the tree_event.
  CHECK ir_tree_event IS BOUND.
  CHECK ir_tree_event->get_sender( ) = me.

* Get the dragdrop object.
  lr_dragdropobject = ir_tree_event->get_dragdropobject( ).
  CHECK lr_dragdropobject IS BOUND.
  CHECK lr_dragdropobject->object IS BOUND.

* Get the drag_object.
  TRY.
      lr_drag_object ?= lr_dragdropobject->object.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Get the drop_processor.
  lr_drop_processor = lr_drag_object->get_drop_processor( ).
  CHECK lr_drop_processor IS BOUND.

* Let the drop_processor process the on_drop request.
  lr_drop_processor->process(
      ir_drag_object  = lr_drag_object
      ir_drop_view    = me
      ir_drop_request = ir_tree_event ).

ENDMETHOD.


METHOD _create_control.

  DATA lr_parent_container_view   TYPE REF TO if_ish_gui_container_view.
  DATA lr_parent_container        TYPE REF TO cl_gui_container.
  DATA l_node_selection_mode      TYPE i.

* Get the parent container.
  TRY.
      lr_parent_container_view ?= get_parent_view( ).
      lr_parent_container = lr_parent_container_view->get_container_for_child_view( me ).
    CATCH cx_root.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = '_CREATE_CONTROL'
          i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDTRY.
  IF lr_parent_container IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

* Create the alv tree.
  l_node_selection_mode = _get_node_selection_mode( ).
  CREATE OBJECT rr_control
    TYPE
      cl_gui_alv_tree
    EXPORTING
      parent              = lr_parent_container
      node_selection_mode = l_node_selection_mode
      no_html_header      = abap_true
    EXCEPTIONS
      OTHERS              = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _destroy.

  DATA lr_alv_tree                    TYPE REF TO cl_gui_alv_tree.
  DATA lr_toolbar                     TYPE REF TO cl_gui_toolbar.

  FIELD-SYMBOLS <ls_model>            LIKE LINE OF gt_model.

* Destroy drag&drop.
  _destroy_dnd( ).

* Deregister the model events.
  LOOP AT gt_model ASSIGNING <ls_model>.
    _register_model_events(
        ir_model     = <ls_model>-r_model
        i_activation = abap_false ).
  ENDLOOP.

* Deregister the alv_tree + toolbar events.
  lr_alv_tree = get_alv_tree( ).
  IF lr_alv_tree IS BOUND.
    SET HANDLER on_after_user_command   FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_before_user_command  FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_checkbox_change      FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_drag                 FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_drag_multiple        FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_drop                 FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_expand_nc            FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_hotspot_click        FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_item_ctx_request     FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_item_ctx_selected    FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_item_double_click    FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_item_keypress        FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_link_click           FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_node_ctx_request     FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_node_ctx_selected    FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_node_double_click    FOR lr_alv_tree ACTIVATION abap_false.
    SET HANDLER on_node_keypress        FOR lr_alv_tree ACTIVATION abap_false.
    CALL METHOD lr_alv_tree->get_toolbar_object
      IMPORTING
        er_toolbar = lr_toolbar.
    IF lr_toolbar IS BOUND.
      SET HANDLER on_dropdown_clicked   FOR lr_toolbar ACTIVATION abap_false.
      SET HANDLER on_function_selected  FOR lr_toolbar ACTIVATION abap_false.
    ENDIF.
  ENDIF.

* Clear the help tables.
  CLEAR gt_model.
  CLEAR gt_nkey.

* Clear the rest.
  CLEAR gr_outtab.
  CLEAR gr_tmp_model_move.
  CLEAR gt_model.
  CLEAR gt_nkey.
  CLEAR g_on_model_added_deactivated.

* Call the super method.
  super->_destroy( ).

ENDMETHOD.


method _DESTROY_DND.
endmethod.


METHOD _fill_outtab_line.

  DATA lr_structdescr           TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname              TYPE ish_fieldname.
  DATA lx_root                  TYPE REF TO cx_root.

  FIELD-SYMBOLS <ls_component>  TYPE abap_compdescr.
  FIELD-SYMBOLS <l_field>       TYPE any.

* Get the structure descriptor for the outtab line.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = cs_outtab ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_structdescr IS BOUND.

* Fill the outtab line.
  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
    CHECK l_fieldname IS NOT INITIAL.
    IF it_changed_field IS NOT INITIAL.
      READ TABLE it_changed_field FROM l_fieldname TRANSPORTING NO FIELDS.
      CHECK sy-subrc = 0.
    ENDIF.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE cs_outtab
      TO <l_field>.
    CHECK sy-subrc = 0.
    TRY.
        CALL METHOD __get_field_content
          EXPORTING
            ir_model    = ir_model
            i_fieldname = l_fieldname
          CHANGING
            c_content   = <l_field>.
      CATCH cx_ish_static_handler INTO lx_root.
        _propagate_exception( ir_exception = lx_root ).
        CONTINUE.
    ENDTRY.
  ENDLOOP.

ENDMETHOD.


METHOD _first_display.

  DATA lr_alv_tree            TYPE REF TO cl_gui_alv_tree.
  DATA lr_main_model          TYPE REF TO if_ish_gui_model.
  DATA lt_child_model         TYPE ish_t_gui_model_objhash.
  DATA lr_child_model         TYPE REF TO if_ish_gui_model.
  DATA lt_tmp_nkey            TYPE lvc_t_nkey.
  DATA lt_new_nkey            TYPE lvc_t_nkey.
  DATA l_startup_expand_level TYPE i.

  FIELD-SYMBOLS: <l_new_nkey>     TYPE lvc_nkey.
  FIELD-SYMBOLS: <l_tmp_nkey>     TYPE lvc_nkey.

* Create the alv tree.
  _create_control_on_demand( ).
  lr_alv_tree = get_alv_tree( ).
  IF lr_alv_tree IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_FIRST_DISPLAY'
        i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

* Set table for first display.
  _set_table_for_first_display( ).

* Get the main model.
  lr_main_model = _get_main_model( ).

* Add the first-level nodes.
  IF _get_show_main_model( ) = abap_true.
    lt_new_nkey = _add_nodes_by_model( ir_model = lr_main_model ).
  ELSE.
    lt_child_model = _get_child_models( ir_parent_model = lr_main_model ).
    LOOP AT lt_child_model INTO lr_child_model.
      lt_tmp_nkey = _add_nodes_by_model( ir_model = lr_child_model ).
*     Collect the nkeys
      LOOP AT lt_tmp_nkey ASSIGNING <l_new_nkey>.
        INSERT <l_new_nkey> INTO TABLE lt_new_nkey.
      ENDLOOP.
    ENDLOOP.
    _register_tabmdl_events(
        ir_model     = lr_main_model
        i_activation = abap_true ).
  ENDIF.

* If we have an expand level, expand all collected nkeys
* with the depth of the startup level
  l_startup_expand_level = _get_startup_expand_level( ).
  IF l_startup_expand_level <> 0.
    LOOP AT lt_new_nkey ASSIGNING <l_new_nkey>.
      expand_node( i_nkey         = <l_new_nkey>
                   i_level_count  = l_startup_expand_level ).
    ENDLOOP.
  ENDIF.

* If we have a startup expand level we might have so many nodes, that the scrollbar
* would be at the bottom. So set the top node.
  IF _get_startup_expand_level( ) > 0.
    lt_tmp_nkey = get_root_nkeys( ).
    CHECK lt_tmp_nkey IS NOT INITIAL.

*   Get the top node key.
    READ TABLE lt_tmp_nkey INDEX 1 ASSIGNING <l_tmp_nkey>.

*   Set the top nkey as top node.
*   A implicit frontend update will be done.
    CALL METHOD lr_alv_tree->set_top_node
      EXPORTING
        i_node_key = <l_tmp_nkey>
      EXCEPTIONS
        OTHERS     = 1.
  ELSE.
*   Update the frontend.
    lr_alv_tree->frontend_update( ).
  ENDIF.

ENDMETHOD.


METHOD _frontend_update.

  DATA:
    lr_alv_tree            TYPE REF TO cl_gui_alv_tree.

* Get the alv_tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Process only if first display is already done.
  CHECK is_first_display_done( ) = abap_true.

* Buffer the refresh if the flush_buffer is active.
* Immediate refresh if the flush_buffer is not active.
  IF i_force = abap_false AND is_flush_buffer_active( ) = abap_true.
    _add_tree_to_flush_buffer( ir_alv_tree = lr_alv_tree ).
  ELSE.
    lr_alv_tree->frontend_update( ).
  ENDIF.

ENDMETHOD.


METHOD _get_child_models.

  DATA lr_tabmdl                TYPE REF TO if_ish_gui_table_model.
  DATA lt_child_model           TYPE ish_t_gui_model_objhash.
  DATA lr_child_model           TYPE REF TO if_ish_gui_model.

* The parent model has to be a table model.
  TRY.
      lr_tabmdl ?= ir_parent_model.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_tabmdl IS BOUND.

* Get the entries of the table model and check if they are valid.
  lt_child_model = __get_entries( ir_tabmdl = lr_tabmdl ).
  LOOP AT lt_child_model INTO lr_child_model.
    CHECK _is_model_valid( lr_child_model ) = abap_true.
    INSERT lr_child_model INTO TABLE rt_child_model.
  ENDLOOP.

ENDMETHOD.


METHOD _get_child_nkeys_cbxchg.

  rt_child_nkey = get_child_nkeys( i_nkey ).

ENDMETHOD.


method _GET_DNDID4MODEL.
endmethod.


METHOD _get_expanded_hierarchy.

  DATA lr_alv_tree        TYPE REF TO cl_gui_alv_tree.
  DATA lt_expanded_nkey   TYPE lvc_t_nkey.
  DATA lt_child_nkey      TYPE lvc_t_nkey.
  DATA ls_hier_data       TYPE rn1_gui_tree_hier.
  DATA lr_child_model     TYPE REF TO cl_ish_gm_structure_simple.

  FIELD-SYMBOLS <l_nkey>  TYPE lvc_nkey.

  CHECK i_nkey IS NOT INITIAL.

  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

  CALL METHOD lr_alv_tree->get_expanded_nodes
    CHANGING
      ct_expanded_nodes = lt_expanded_nkey
    EXCEPTIONS
      OTHERS            = 1.
  CHECK sy-subrc = 0.
  CHECK lt_expanded_nkey IS NOT INITIAL.

  READ TABLE lt_expanded_nkey FROM i_nkey TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  CALL METHOD lr_alv_tree->get_children
    EXPORTING
      i_node_key  = i_nkey
    IMPORTING
      et_children = lt_child_nkey
    EXCEPTIONS
      OTHERS      = 1.
  CHECK sy-subrc = 0.
  CHECK lt_child_nkey IS NOT INITIAL.

  LOOP AT lt_child_nkey ASSIGNING <l_nkey>.
    READ TABLE lt_expanded_nkey FROM <l_nkey> TRANSPORTING NO FIELDS.
    CHECK sy-subrc = 0.
    lr_child_model = _get_expanded_hierarchy( i_nkey = <l_nkey> ).
    CHECK lr_child_model IS BOUND.
    INSERT lr_child_model INTO TABLE ls_hier_data-t_child_model.
  ENDLOOP.

  ls_hier_data-nkey = i_nkey.
  ls_hier_data-r_model  = get_model_by_nkey( i_nkey ).

  rr_hierarchy = cl_ish_gm_structure_simple=>create_by_data( is_data = ls_hier_data ).
  CHECK rr_hierarchy IS BOUND.

ENDMETHOD.


METHOD _get_fcode_buttontype.

  r_buttontype = -1.

ENDMETHOD.


method _GET_LACI.
endmethod.


METHOD _get_lacn.

  DATA lr_alv_tree          TYPE REF TO cl_gui_alv_tree.
  DATA lr_treenode_mdl      TYPE REF TO if_ish_gui_treenode_model.
  DATA lt_child_nkey        TYPE lvc_t_nkey.
  DATA l_dndid              TYPE int2.

  CHECK ir_model IS BOUND.

* Get the alv_tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Node icon.
  TRY.
      lr_treenode_mdl ?= ir_model.
      rs_lacn-n_image   = lr_treenode_mdl->get_node_icon( ).
      rs_lacn-exp_image = rs_lacn-n_image.
      IF is_layn-n_image <> rs_lacn-n_image.
        rs_lacn-u_n_image = abap_true.
      ENDIF.
      IF is_layn-exp_image <> rs_lacn-exp_image.
        rs_lacn-u_exp_imag = abap_true.
      ENDIF.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

* expander + isfolder.
  IF _get_child_models( ir_parent_model = ir_model ) IS INITIAL.
    IF is_layn-expander = abap_true.
      rs_lacn-expander    = abap_false.
      rs_lacn-u_expander  = abap_true.
    ENDIF.
    IF is_layn-isfolder = abap_true.
      CALL METHOD lr_alv_tree->get_children
        EXPORTING
          i_node_key  = i_nkey
        IMPORTING
          et_children = lt_child_nkey
        EXCEPTIONS
          OTHERS      = 1.
*     Resetting the isfolder flag is only allowed if the alv-tree has no child nodes anymore.
*     Otherwise this will lead to a shortdump or a message type x error (AC_SYSTEM_FLUSH)!
      IF sy-subrc = 0 AND
         lt_child_nkey IS INITIAL.
        rs_lacn-isfolder    = abap_false.
        rs_lacn-u_isfolder  = abap_true.
      ENDIF.
    ENDIF.
  ELSE.
    IF is_layn-expander = abap_false.
      rs_lacn-expander    = abap_true.
      rs_lacn-u_expander  = abap_true.
    ENDIF.
    IF is_layn-isfolder = abap_false.
      rs_lacn-isfolder    = abap_true.
      rs_lacn-u_isfolder  = abap_true.
    ENDIF.
  ENDIF.

* Get the dndhandle.
  l_dndid = _get_dndid4model( ir_model = ir_model ).
  IF is_layn-dragdropid <> l_dndid.
    rs_lacn-dragdropid = l_dndid.
    rs_lacn-u_dragdrop = abap_true.
  ENDIF.

ENDMETHOD.


method _GET_LAYI.
endmethod.


METHOD _get_layn.

  DATA lr_treenode_mdl        TYPE REF TO if_ish_gui_treenode_model.
  DATA lr_tabmdl              TYPE REF TO if_ish_gui_table_model.

  CHECK ir_model IS BOUND.

* Node icon.
  TRY.
      lr_treenode_mdl ?= ir_model.
      rs_layn-n_image   = lr_treenode_mdl->get_node_icon( ).
      rs_layn-exp_image = rs_layn-n_image.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

* isfolder + expander.
  IF _get_child_models( ir_parent_model = ir_model ) IS NOT INITIAL.
    rs_layn-isfolder  = abap_true.
    rs_layn-expander  = abap_true.
  ENDIF.

* Set the dragdropid.
  rs_layn-dragdropid = _get_dndid4model( ir_model = ir_model ).

ENDMETHOD.


METHOD _get_main_model.

  rr_main_model = _get_model( ).

ENDMETHOD.


METHOD _get_model_by_tree_event.

  DATA l_nkey                   TYPE lvc_nkey.

  CHECK ir_tree_event IS BOUND.

  rr_model = ir_tree_event->get_node_model( ).
  CHECK rr_model IS NOT BOUND.

  l_nkey = ir_tree_event->get_nkey( ).
  IF l_nkey IS INITIAL.
    rr_model = get_selected_model( ).
  ELSE.
    rr_model = get_model_by_nkey( i_nkey = l_nkey ).
  ENDIF.

ENDMETHOD.


METHOD _get_node_selection_mode.

  r_mode = cl_gui_column_tree=>node_sel_mode_single.

ENDMETHOD.


METHOD _get_node_text.

  DATA lr_treenode_model            TYPE REF TO if_ish_gui_treenode_model.

  CHECK ir_model IS BOUND.

  TRY.
      lr_treenode_model ?= ir_model.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  r_node_text = lr_treenode_model->get_node_text( ).

ENDMETHOD.


METHOD _get_parent_nkey_cbxchg.

  DATA lr_alv_tree                  TYPE REF TO cl_gui_alv_tree.
  DATA l_parent_nkey                TYPE lvc_nkey.
  DATA lt_sibling_nkey              TYPE lvc_t_nkey.
  DATA lt_checked_nkey              TYPE lvc_t_nkey.
  DATA l_sibling_checked            TYPE abap_bool.
  DATA lt_tmp_nkey                  TYPE lvc_t_nkey.
  DATA l_tmp_nkey                   TYPE lvc_nkey.
  DATA lr_tmp_model                 TYPE REF TO if_ish_gui_model.

  FIELD-SYMBOLS <l_tmp_nkey>        TYPE lvc_nkey.

* Initial checking.
  CHECK i_nkey IS NOT INITIAL.
  CHECK ir_model IS BOUND.

* Get the alv_tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Get the parent_nkey.
  l_parent_nkey = get_parent_nkey( i_nkey ).
  CHECK l_parent_nkey IS NOT INITIAL.

* On unchecking we only have to process if there is no more checked sibling.
  IF i_checked = abap_false.
*   Get the sibling nkeys.
    CALL METHOD lr_alv_tree->get_prev_sibling
      EXPORTING
        i_node_key      = i_nkey
      IMPORTING
        e_prev_node_key = l_tmp_nkey.
    WHILE l_tmp_nkey IS NOT INITIAL.
      INSERT l_tmp_nkey INTO TABLE lt_sibling_nkey.
      CALL METHOD lr_alv_tree->get_prev_sibling
        EXPORTING
          i_node_key      = l_tmp_nkey
        IMPORTING
          e_prev_node_key = l_tmp_nkey.
    ENDWHILE.
    CALL METHOD lr_alv_tree->get_next_sibling
      EXPORTING
        i_node_key      = i_nkey
      IMPORTING
        e_next_node_key = l_tmp_nkey.
    WHILE l_tmp_nkey IS NOT INITIAL.
      INSERT l_tmp_nkey INTO TABLE lt_sibling_nkey.
      CALL METHOD lr_alv_tree->get_next_sibling
        EXPORTING
          i_node_key      = l_tmp_nkey
        IMPORTING
          e_next_node_key = l_tmp_nkey.
    ENDWHILE.
*   Determine if any sibling is checked.
    IF lt_sibling_nkey IS NOT INITIAL.
      lt_checked_nkey = get_checked_nkeys( ).
      LOOP AT lt_checked_nkey ASSIGNING <l_tmp_nkey>.
        READ TABLE lt_sibling_nkey FROM <l_tmp_nkey> TRANSPORTING NO FIELDS.
        CHECK sy-subrc = 0.
        l_sibling_checked = abap_true.
        EXIT.
      ENDLOOP.
    ENDIF.
*   No further processing if any sibling is checked.
    CHECK l_sibling_checked = abap_false.
  ENDIF.

* Export.
  r_parent_nkey = l_parent_nkey.

ENDMETHOD.


METHOD _get_relat_4_new_model.

  DATA lr_parent_xtblmdl            TYPE REF TO if_ish_gui_xtable_model.
  DATA lr_previous_model            TYPE REF TO if_ish_gui_model.
  DATA l_previous_nkey              TYPE lvc_nkey.
  DATA l_parent_nkey                TYPE lvc_nkey.
  DATA lt_nkey                      TYPE lvc_t_nkey.

* Initializations.
  e_relat_nkey    = i_parent_nkey.
  e_relationship  = cl_gui_column_tree=>relat_last_child.

* Calculate the relationship only if specified.
  CHECK i_calculate_relationship = abap_true.

* Process only on given model.
  CHECK ir_model IS BOUND.
* Process only if the model is not the main model
  CHECK ir_model <> _get_main_model( ).

* Get the parent xtable_model.
  TRY.
      IF i_parent_nkey IS INITIAL.
        lr_parent_xtblmdl ?= _get_main_model( ).
*       If there is exactly one node key, it's our node key.
*       If there is no node key: the root node will not be shown -> Continue
*       If there are more node keys -> Continue
        lt_nkey = get_nkeys_by_model( lr_parent_xtblmdl ).
        DESCRIBE TABLE lt_nkey.
        IF sy-tfill = 1.
          READ TABLE lt_nkey INDEX 1 INTO l_parent_nkey.
        ENDIF.
      ELSE.
        lr_parent_xtblmdl ?= get_model_by_nkey( i_nkey = i_parent_nkey ).
        l_parent_nkey = i_parent_nkey.
      ENDIF.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_parent_xtblmdl IS BOUND.

* Determine the nkey for the previous sibling.
  TRY.
      lr_previous_model = lr_parent_xtblmdl->get_previous_entry(
          ir_next_entry = ir_model ).
      WHILE lr_previous_model IS BOUND AND l_previous_nkey IS INITIAL.
        l_previous_nkey = get_nkey_by_child_model(
            i_parent_nkey   = l_parent_nkey
            ir_child_model  = lr_previous_model ).
        IF l_previous_nkey IS INITIAL.
          lr_previous_model = lr_parent_xtblmdl->get_previous_entry(
              ir_next_entry = lr_previous_model ).
        ENDIF.
      ENDWHILE.
    CATCH cx_ish_static_handler.
      RETURN. "add as last child
  ENDTRY.

* Add the node after the previous sibling.
  IF l_previous_nkey IS INITIAL.
    e_relationship = cl_gui_column_tree=>relat_first_child.
  ELSE.
    e_relat_nkey    = l_previous_nkey.
    e_relationship  = cl_gui_column_tree=>relat_next_sibling.
  ENDIF.

ENDMETHOD.


METHOD _get_show_main_model.

  DATA lr_layout            TYPE REF TO cl_ish_gui_tree_layout.

  lr_layout = get_tree_layout( ).
  CHECK lr_layout IS BOUND.

  r_show_main_model = lr_layout->get_show_main_model( ).

ENDMETHOD.


METHOD _get_startup_expand_level.

  DATA lr_layout            TYPE REF TO cl_ish_gui_tree_layout.

  lr_layout = get_tree_layout( ).
  CHECK lr_layout IS BOUND.

  r_startup_expand_level = lr_layout->get_startup_expand_level( ).

ENDMETHOD.


METHOD _init_tree_view.

  DATA lr_layout                    TYPE REF TO cl_ish_gui_tree_layout.
  DATA lx_root                      TYPE REF TO cx_root.

* Check outtab
  _check_r_outtab( ir_outtab = ir_outtab ).

* Handle the layout.
  IF ir_layout IS BOUND.
    lr_layout = ir_layout.
  ELSE.
    lr_layout = _load_or_create_layout(
        ir_controller  = ir_controller
        ir_parent_view = ir_parent_view ).
  ENDIF.

* Further processing by _init_control_view.
  _init_control_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = lr_layout
      i_vcode           = i_vcode ).

* Prepare drag&drop behaviour.
  _prepare_dnd( ).

* Initialize attributes.
  gr_outtab = ir_outtab.

ENDMETHOD.


METHOD _is_fcode_disabled.

* By default all fcodes are enabled.

  r_disabled = abap_false.

ENDMETHOD.


METHOD _is_fcode_supported.

* If we have a fvar only those fcodes are supported which are contained by the fvar.
* If we have no fvar all fcodes are supported.

  DATA lr_layout            TYPE REF TO cl_ish_gui_tree_layout.
  DATA lr_fvar              TYPE REF TO cl_ish_fvar.

  r_supported = abap_true.

  lr_layout = get_tree_layout( ).
  CHECK lr_layout IS BOUND.

  TRY.
      lr_fvar = lr_layout->get_fvar( ).
    CATCH cx_ish_fvar.
      RETURN.
  ENDTRY.
  CHECK lr_fvar IS BOUND.

  r_supported = lr_fvar->has_fcode( i_fcode = i_fcode ).

ENDMETHOD.


METHOD _is_model_valid.

  CHECK ir_model IS BOUND.

* By default each model is valid.
  r_is_valid = abap_true.

ENDMETHOD.


METHOD _load_child_models.

  DATA l_level_count          TYPE i.
  DATA lt_child_model         TYPE ish_t_gui_model_objhash.
  DATA lr_child_model         TYPE REF TO if_ish_gui_model.
  DATA lt_nkeys               TYPE lvc_t_nkey.
  DATA l_nkey                 TYPE lvc_nkey.

  CHECK ir_model IS BOUND.
  CHECK i_level_count > 0.

* Get the child models.
  lt_child_model = _get_child_models( ir_parent_model = ir_model ).

* The child models were read. So register the tabmdl events for ir_model.
  _register_tabmdl_events( ir_model = ir_model ).

* Further processing only on child models.
  CHECK lt_child_model IS NOT INITIAL.

* Calculate the level_count for the next stage.
  l_level_count = i_level_count - 1.

* Add the models.
  LOOP AT lt_child_model INTO lr_child_model.

    _add_nodes_by_model(
        ir_parent_model           = ir_model
        ir_model                  = lr_child_model
        i_calculate_relationship  = abap_false ).

    CHECK l_level_count > 0.

    _load_child_models(
        ir_model      = lr_child_model
        i_level_count = l_level_count ).

  ENDLOOP.

* Export.
  r_loaded = abap_true.

ENDMETHOD.


METHOD _load_or_create_layout.

  DATA l_element_name           TYPE n1gui_element_name.

  TRY.
      rr_layout ?= _load_layout(
          ir_controller   = ir_controller
          ir_parent_view  = ir_parent_view
          i_layout_name   = i_layout_name
          i_username      = i_username ).
    CATCH cx_sy_move_cast_error.
      CLEAR rr_layout.
  ENDTRY.

  IF rr_layout IS NOT BOUND.
    l_element_name = get_element_name( ).
    CREATE OBJECT rr_layout
      EXPORTING
        i_element_name = l_element_name
        i_layout_name  = i_layout_name.
  ENDIF.

ENDMETHOD.


METHOD _on_node_checkbox_change.

  DATA lr_model           TYPE REF TO if_ish_gui_model.
  DATA lx_static          TYPE REF TO cx_ish_static_handler.

* Process only on node checkbox (hierarchy column).
  CHECK i_fieldname = cl_gui_alv_tree=>c_hierarchy_column_name.

* Get the model.
  lr_model = get_model_by_nkey( i_nkey ).
  CHECK lr_model IS BOUND.

* Process.
  TRY.
      CHECK __on_node_checkbox_change(
          i_orig_nkey           = i_nkey
          i_nkey                = i_nkey
          ir_model              = lr_model
          i_checked             = i_checked
          i_adjust_parent_node  = abap_true
          i_adjust_child_nodes  = abap_true
          i_expand              = abap_false ) = abap_true.
      IF i_expand = abap_true.
        expand_node(
            i_nkey           = i_nkey
            i_expand_subtree = abap_true ).
      ENDIF.
    CATCH cx_ish_static_handler INTO lx_static.
      _propagate_exception( lx_static ).
  ENDTRY.

* Update the frontend.
* We have to flush.
  IF is_flush_buffer_active( ) = abap_true.
    _frontend_update( i_force = abap_true ).
  ELSE.
    _frontend_update( i_force = abap_false ).
  ENDIF.

ENDMETHOD.


METHOD _own_cmd.

  CHECK ir_tree_event IS BOUND.

  CASE ir_tree_event->get_fcode( ).

*   collapse
    WHEN co_fcode_collapse.
      r_cmdresult = co_cmdresult_processed.
      _cmd_collapse( ir_tree_event = ir_tree_event ).

*   dropdown_clicked
    WHEN cl_ish_gui_tree_event=>co_fcode_dropdown_clicked.
      r_cmdresult = _cmd_dropdown_clicked( ir_tree_event = ir_tree_event ).

*   expand
    WHEN co_fcode_expand.
      r_cmdresult = co_cmdresult_processed.
      _cmd_expand( ir_tree_event = ir_tree_event ).

*   node_ctx_request
    WHEN cl_ish_gui_tree_event=>co_fcode_node_ctx_request.
      r_cmdresult = _cmd_node_ctx_request( ir_tree_event = ir_tree_event ).

*   on_drag
*   on_drag_multiple
    WHEN cl_ish_gui_tree_event=>co_fcode_on_drag OR
         cl_ish_gui_tree_event=>co_fcode_on_drag_multiple.
      r_cmdresult = co_cmdresult_processed.
      _cmd_on_drag( ir_tree_event = ir_tree_event ).

*   on_drop
    WHEN cl_ish_gui_tree_event=>co_fcode_on_drop.
      r_cmdresult = co_cmdresult_processed.
      _cmd_on_drop( ir_tree_event = ir_tree_event ).

    WHEN OTHERS.
*     We haven't processed the event
      r_cmdresult = co_cmdresult_noproc.
      RETURN.

  ENDCASE.

ENDMETHOD.


method _PREPARE_DND.
endmethod.


METHOD _process_command_request.

  DATA lr_okcode_request        TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_tree_event            TYPE REF TO cl_ish_gui_tree_event.
  DATA l_exit                   TYPE abap_bool.
  DATA lx_root                  TYPE REF TO cx_root.

* The command_request has to be specified.
  CHECK ir_command_request IS BOUND.

* The command_request has to be created by an okcode_request.
  lr_okcode_request = ir_command_request->get_okcode_request( ).
  CHECK lr_okcode_request IS BOUND.

* The okcode_request has to be created by a tree_event.
  TRY.
      lr_tree_event ?= lr_okcode_request->get_control_event( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_tree_event IS BOUND.

* The tree_event has to belong to self.
  CHECK lr_tree_event->get_sender( ) = me.

* Process the tree_event.
  TRY.

      CASE _own_cmd(
               ir_tree_event   = lr_tree_event
               ir_orig_request = ir_command_request ).
        WHEN co_cmdresult_processed.
          l_exit = abap_false.
        WHEN co_cmdresult_exit.
          l_exit = abap_true.
        WHEN OTHERS.
          RETURN.
      ENDCASE.

      rr_response = cl_ish_gui_response=>create(
          ir_request    = ir_command_request
          ir_processor  = me
          i_exit        = l_exit ).

*   On errors we have to propagate the exception.
    CATCH cx_ish_static_handler INTO lx_root.

      _propagate_exception( lx_root ).
      rr_response = cl_ish_gui_response=>create( ir_request   = ir_command_request
                                                 ir_processor = me ).
      RETURN.

  ENDTRY.

ENDMETHOD.


METHOD _process_event_request.

  DATA lr_tree_event            TYPE REF TO cl_ish_gui_tree_event.
  DATA lr_tmp_messages          TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_root                  TYPE REF TO cx_root.
  DATA lr_okcode_request        TYPE REF TO cl_ish_gui_okcode_request.

* The event_request has to be specified.
  CHECK ir_event_request IS BOUND.

* The event_request has to belong to self.
  CHECK ir_event_request->get_sender( ) = me.

* The event_request has to be a tree_event.
  TRY.
      lr_tree_event ?= ir_event_request.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Process the tree_event.
  TRY.

      CASE _own_cmd( ir_tree_event   = lr_tree_event
                     ir_orig_request = ir_event_request ).
        WHEN co_cmdresult_noproc.
*         We havn't processed the event
          RETURN.
        WHEN co_cmdresult_processed.
*         We have processed the event
          rr_response = cl_ish_gui_response=>create( ir_request   = ir_event_request
                                                     ir_processor = me ).
        WHEN co_cmdresult_exit.
*         We have processed the event and want to exit.
          rr_response = cl_ish_gui_response=>create( ir_request   = ir_event_request
                                                     ir_processor = me
                                                     i_exit       = abap_true ).
        WHEN co_cmdresult_okcode.
*         Create an okcode request for our event and propagate it
          lr_okcode_request = cl_ish_gui_okcode_request=>create_by_control_event(
                                              ir_sender         = me
                                              ir_processor      = me
                                              ir_control_event  = lr_tree_event ).

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


method _REFRESH_DISPLAY.
endmethod.


METHOD _register_alv_tree_events.

  DATA: lt_event         TYPE cntl_simple_events,
        ls_event         TYPE cntl_simple_event.

  FIELD-SYMBOLS: <ls_event>  TYPE cntl_simple_event.

* Initial checking.
  CHECK ir_alv_tree IS BOUND.

* Get the registered events.
  CALL METHOD ir_alv_tree->get_registered_events
    IMPORTING
      events     = lt_event
    EXCEPTIONS
      cntl_error = 1
      OTHERS     = 2.
  CHECK sy-subrc = 0.

* checkbox_change.
  READ TABLE lt_event
    ASSIGNING <ls_event>
    WITH KEY
       eventid = cl_gui_column_tree=>eventid_checkbox_change.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR ls_event.
    ls_event-eventid = cl_gui_column_tree=>eventid_checkbox_change.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.

* item_context_menu_request.
  READ TABLE lt_event
    ASSIGNING <ls_event>
    WITH KEY
       eventid = cl_gui_column_tree=>eventid_item_context_menu_req.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR ls_event.
    ls_event-eventid = cl_gui_column_tree=>eventid_item_context_menu_req.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.

* item_double_click.
  READ TABLE lt_event
    ASSIGNING <ls_event>
    WITH KEY eventid = cl_gui_column_tree=>eventid_item_double_click.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR ls_event.
    ls_event-eventid = cl_gui_column_tree=>eventid_item_double_click.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.

* item_keypress.
  READ TABLE lt_event
    ASSIGNING <ls_event>
    WITH KEY eventid = cl_gui_column_tree=>eventid_item_keypress.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR ls_event.
    ls_event-eventid = cl_gui_column_tree=>eventid_item_keypress.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.

* node_context_menu_request.
  READ TABLE lt_event
    ASSIGNING <ls_event>
    WITH KEY
       eventid = cl_gui_column_tree=>eventid_node_context_menu_req.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR ls_event.
    ls_event-eventid = cl_gui_column_tree=>eventid_node_context_menu_req.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.

* node_double_click.
  READ TABLE lt_event
    ASSIGNING <ls_event>
    WITH KEY
       eventid = cl_gui_column_tree=>eventid_node_double_click.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR ls_event.
    ls_event-eventid = cl_gui_column_tree=>eventid_node_double_click.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.

* node_keypress.
  READ TABLE lt_event
    ASSIGNING <ls_event>
    WITH KEY eventid = cl_gui_column_tree=>eventid_node_keypress.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR ls_event.
    ls_event-eventid = cl_gui_column_tree=>eventid_node_keypress.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.

* link_click.
  READ TABLE lt_event
    ASSIGNING <ls_event>
    WITH KEY
       eventid = cl_gui_column_tree=>eventid_link_click.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR ls_event.
    ls_event-eventid = cl_gui_column_tree=>eventid_link_click.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.

* Set the registered events.
  CALL METHOD ir_alv_tree->set_registered_events
    EXPORTING
      events                    = lt_event
    EXCEPTIONS
      cntl_error                = 1
      cntl_system_error         = 2
      illegal_event_combination = 3.

* Register the eventhandlers.
  SET HANDLER on_after_user_command   FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_before_user_command  FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_checkbox_change      FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_drag                 FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_drag_multiple        FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_drop                 FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_expand_nc            FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_item_ctx_request     FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_item_ctx_selected    FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_item_double_click    FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_item_keypress        FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_link_click           FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_node_ctx_request     FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_node_ctx_selected    FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_node_double_click    FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_node_keypress        FOR ir_alv_tree ACTIVATION abap_true.
  SET HANDLER on_hotspot_click        FOR ir_alv_tree ACTIVATION abap_true.

ENDMETHOD.


METHOD _register_model_events.

  _register_structmdl_events(
      ir_model     = ir_model
      i_activation = i_activation ).

  _register_tabmdl_events(
      ir_model     = ir_model
      i_activation = i_activation ).

ENDMETHOD.


METHOD _register_structmdl_events.

  DATA lr_structmdl           TYPE REF TO if_ish_gui_structure_model.
  DATA lr_tabmdl              TYPE REF TO if_ish_gui_table_model.

  CHECK ir_model IS BOUND.

  TRY.
      lr_structmdl ?= ir_model.
      SET HANDLER on_model_changed FOR lr_structmdl ACTIVATION i_activation.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_tabmdl ?= ir_model.
      SET HANDLER on_model_added_adjust   FOR lr_tabmdl ACTIVATION i_activation.
      SET HANDLER on_model_removed_adjust FOR lr_tabmdl ACTIVATION i_activation.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD _register_tabmdl_events.

  DATA lr_tabmdl              TYPE REF TO if_ish_gui_table_model.

  CHECK ir_model IS BOUND.

  TRY.
      lr_tabmdl ?= ir_model.
      SET HANDLER on_model_added          FOR lr_tabmdl ACTIVATION i_activation.
      SET HANDLER on_model_removed        FOR lr_tabmdl ACTIVATION i_activation.
      SET HANDLER on_model_added_adjust   FOR lr_tabmdl ACTIVATION abap_false.
      SET HANDLER on_model_removed_adjust FOR lr_tabmdl ACTIVATION abap_false.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD _register_toolbar_events.

  DATA: lt_event         TYPE cntl_simple_events,
        ls_event         TYPE cntl_simple_event.

  FIELD-SYMBOLS: <ls_event>  TYPE cntl_simple_event.

* Initial checking.
  CHECK ir_toolbar IS BOUND.

* Get the registered events.
  CALL METHOD ir_toolbar->get_registered_events
    IMPORTING
      events     = lt_event
    EXCEPTIONS
      cntl_error = 1
      OTHERS     = 2.
  CHECK sy-subrc = 0.

* function_selected.
  READ TABLE lt_event
    ASSIGNING <ls_event>
    WITH KEY eventid = cl_gui_toolbar=>m_id_function_selected.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR ls_event.
    ls_event-eventid    = cl_gui_toolbar=>m_id_function_selected.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.

* dropdown clicked.
  READ TABLE lt_event
    ASSIGNING <ls_event>
    WITH KEY eventid = cl_gui_toolbar=>m_id_dropdown_clicked.
  IF sy-subrc = 0.
    <ls_event>-appl_event = abap_false.
  ELSE.
    CLEAR ls_event.
    ls_event-eventid    = cl_gui_toolbar=>m_id_dropdown_clicked.
    ls_event-appl_event = abap_false.
    APPEND ls_event TO lt_event.
  ENDIF.

* Set the registered events.
  CALL METHOD ir_toolbar->set_registered_events
    EXPORTING
      events                    = lt_event
    EXCEPTIONS
      cntl_error                = 1
      cntl_system_error         = 2
      illegal_event_combination = 3.

* Register the eventhandlers.
  SET HANDLER on_function_selected  FOR ir_toolbar ACTIVATION abap_true.
  SET HANDLER on_dropdown_clicked   FOR ir_toolbar ACTIVATION abap_true.

ENDMETHOD.


METHOD _remove_node.

  DATA:
    lr_alv_tree          TYPE REF TO cl_gui_alv_tree,
    lr_model             TYPE REF TO if_ish_gui_model,
    lr_tabmdl            TYPE REF TO if_ish_gui_table_model,
    lr_structmdl         TYPE REF TO if_ish_gui_structure_model.

  FIELD-SYMBOLS:
    <l_nkey>             TYPE lvc_nkey,
    <l_tmp_nkey>         TYPE lvc_nkey,
    <ls_model>           LIKE LINE OF gt_model.

* Get the alv tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* On removing a node we have also to remove its sub-nodes.
* Therefore we have to determine all nkeys which have to be removed.
  CALL METHOD lr_alv_tree->get_subtree
    EXPORTING
      i_node_key       = i_nkey
    IMPORTING
      et_subtree_nodes = rt_nkey_removed.

* Remove the node (including its subnodes) from the alv_tree.
  CALL METHOD lr_alv_tree->delete_subtree
    EXPORTING
      i_node_key                = i_nkey
      i_update_parents_folder   = abap_true
      i_update_parents_expander = abap_true
    EXCEPTIONS
      OTHERS                    = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_REMOVE_NODE'
        i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

* Now we have to
*   - deregister self for the node model events.
*   - adjust gt_nkey.
*   - adjust gt_model.
  LOOP AT rt_nkey_removed ASSIGNING <l_nkey>.

*   Get the model for the nkey.
    lr_model = get_model_by_nkey( i_nkey = <l_nkey> ).

*   Adjust gt_nkey.
    DELETE TABLE gt_nkey WITH TABLE KEY nkey = <l_nkey>.

*   Adjust gt_model.
*   If the last occurrence of the node model has to be removed
*   we have to delete the gt_model entry and deregister the node model eventhandlers.
*   If not we just delete the nkey entry of gt_model.
    IF lr_model IS BOUND.
      READ TABLE gt_model
        WITH TABLE KEY r_model = lr_model
        ASSIGNING <ls_model>.
      IF sy-subrc = 0.
        IF lines( <ls_model>-t_nkey ) > 1.
*         Michael Manoch, 30.07.2007
*         delete <table> from <table_line> does not work.
*          DELETE <ls_model>-t_nkey FROM <l_nkey>.
          LOOP AT <ls_model>-t_nkey ASSIGNING <l_tmp_nkey>.
            IF <l_nkey> = <l_tmp_nkey>.
              DELETE <ls_model>-t_nkey.
            ENDIF.
          ENDLOOP.
        ELSE.
          DELETE TABLE gt_model WITH TABLE KEY r_model = lr_model.
          _register_model_events(
              ir_model     = lr_model
              i_activation = abap_false ).
        ENDIF.
      ENDIF.
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD _remove_nodes_by_model.

  DATA lr_alv_tree            TYPE REF TO cl_gui_alv_tree.
  DATA lr_parent_model        TYPE REF TO if_ish_gui_model.
  DATA l_parent_nkey          TYPE lvc_nkey.
  DATA lt_tmp_nkey_removed    TYPE lvc_t_nkey.
  DATA ls_parent_model        LIKE LINE OF gt_model.
  DATA ls_model               LIKE LINE OF gt_model.
  DATA lx_root                TYPE REF TO cx_root.

  FIELD-SYMBOLS:
    <l_nkey>             TYPE lvc_nkey.

* The model has to be given.
  CHECK ir_model IS BOUND.

* Get the alv_tree.
  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

* Determine the nkeys of the parent model.
* If the parent model has no nkeys we further process only if it is not our main model.
  IF ir_parent_model IS BOUND.
    READ TABLE gt_model
      WITH TABLE KEY r_model = ir_parent_model
      INTO ls_parent_model.
    IF sy-subrc = 0.
      lr_parent_model = ir_parent_model.
    ELSE.
      CHECK ir_parent_model = _get_main_model( ).
    ENDIF.
  ENDIF.

* Determine the nkeys of the model.
  READ TABLE gt_model
    WITH TABLE KEY r_model = ir_model
    INTO ls_model.
  CHECK sy-subrc = 0.

* Remove the nodes.
  LOOP AT ls_model-t_nkey ASSIGNING <l_nkey>.
*   If the parent model was given we should only remove the nodes under the parent model.
    IF lr_parent_model IS BOUND.
      CALL METHOD lr_alv_tree->get_parent
        EXPORTING
          i_node_key        = <l_nkey>
        IMPORTING
          e_parent_node_key = l_parent_nkey.
      READ TABLE ls_parent_model-t_nkey FROM l_parent_nkey TRANSPORTING NO FIELDS.
      CHECK sy-subrc = 0.
    ENDIF.
*   Remove the node.
    TRY.
        lt_tmp_nkey_removed = _remove_node( i_nkey = <l_nkey> ).
        INSERT LINES OF lt_tmp_nkey_removed INTO TABLE rt_nkey_removed.
      CATCH cx_ish_static_handler INTO lx_root.
        _propagate_exception( ir_exception = lx_root ).
    ENDTRY.
  ENDLOOP.

ENDMETHOD.


METHOD _set_expanded_hierarchy.

  DATA ls_hier_data       TYPE rn1_gui_tree_hier.
  DATA lr_model           TYPE REF TO if_ish_gui_model.
  DATA lr_hier_model      TYPE REF TO cl_ish_gm_structure_simple.
  DATA lr_child_model     TYPE REF TO if_ish_gui_model.
  DATA l_child_nkey       TYPE lvc_nkey.

  FIELD-SYMBOLS <l_nkey>  TYPE lvc_nkey.

  CHECK i_nkey IS NOT INITIAL.
  CHECK ir_hierarchy IS BOUND.

  CALL METHOD ir_hierarchy->get_data
    CHANGING
      cs_data = ls_hier_data.

  CHECK ls_hier_data-r_model = get_model_by_nkey( i_nkey ).

  CHECK expand_node( i_nkey = i_nkey ) = abap_true.

  LOOP AT ls_hier_data-t_child_model INTO lr_model.
    CHECK lr_model IS BOUND.
    TRY.
        lr_hier_model ?= lr_model.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
    CALL METHOD lr_hier_model->get_field_content
      EXPORTING
        i_fieldname = 'R_MODEL'
      CHANGING
        c_content   = lr_child_model.
    CHECK lr_child_model IS BOUND.
    l_child_nkey = get_nkey_by_child_model(
        i_parent_nkey  = i_nkey
        ir_child_model = lr_child_model ).
    _set_expanded_hierarchy(
        i_nkey = l_child_nkey
        ir_hierarchy  = lr_hier_model ).
  ENDLOOP.

ENDMETHOD.


METHOD _set_table_for_first_display.

  DATA:
    lr_alv_tree              TYPE REF TO cl_gui_alv_tree,
    lr_toolbar               TYPE REF TO cl_gui_toolbar,
    lt_fcat                  TYPE lvc_t_fcat,
    ls_hierarchy_header      TYPE treev_hhdr,
    lt_exclfunc              TYPE ui_functions,
    ls_variant               TYPE disvariant,
    l_variant_save           TYPE char01.

  FIELD-SYMBOLS:
    <lt_outtab>              TYPE table.

* Get the alv_tree.
  lr_alv_tree = get_alv_tree( ).
  IF lr_alv_tree IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_SET_TABLE_FOR_FIRST_DISPLAY'
        i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.

* Get the toolbar.
  CALL METHOD lr_alv_tree->get_toolbar_object
    IMPORTING
      er_toolbar = lr_toolbar.

* The outtab reference has to be bound.
  IF gr_outtab IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_SET_TABLE_FOR_FIRST_DISPLAY'
        i_mv3        = 'CL_ISH_GUI_TREE_VIEW' ).
  ENDIF.
  ASSIGN gr_outtab->* TO <lt_outtab>.

* Build the hierarchy header.
  ls_hierarchy_header = _build_hierarchy_header( ).

* Build the fieldcatalog.
  lt_fcat = _build_fcat( ).

* Build the excluding functions.
  lt_exclfunc = _build_excluding_functions( ).

* Build the variant.
  CALL METHOD _build_variant
    IMPORTING
      es_variant = ls_variant
      e_save     = l_variant_save.

* Register tree events.
  _register_alv_tree_events( ir_alv_tree = lr_alv_tree ).

* Register toolbar events.
  _register_toolbar_events( ir_toolbar = lr_toolbar ).

* Build the toolbar.
  _build_toolbar_menu( ir_toolbar = lr_toolbar ).

* Set table for first display.
  CALL METHOD lr_alv_tree->set_table_for_first_display
    EXPORTING
      is_variant           = ls_variant
      i_save               = l_variant_save
      is_hierarchy_header  = ls_hierarchy_header
      it_toolbar_excluding = lt_exclfunc
    CHANGING
      it_outtab            = <lt_outtab>
      it_fieldcatalog      = lt_fcat.

ENDMETHOD.


METHOD _set_vcode.

  DATA: lr_alv_tree    TYPE REF TO cl_gui_alv_tree,
        lr_toolbar     TYPE REF TO cl_gui_toolbar.

  r_changed = super->_set_vcode( i_vcode = i_vcode ).

  CHECK r_changed = abap_true.

  lr_alv_tree = get_alv_tree( ).
  CHECK lr_alv_tree IS BOUND.

  CALL METHOD lr_alv_tree->get_toolbar_object
    IMPORTING
      er_toolbar = lr_toolbar.
  IF lr_toolbar IS BOUND.
    _change_toolbar_menu( lr_toolbar ).
  ENDIF.

  IF _adjust_nodes_to_vcode( i_old_vcode = i_vcode i_new_vcode = i_vcode ) = abap_true.
    _frontend_update( ).
  ENDIF.

ENDMETHOD.


METHOD __get_entries.

  CHECK ir_tabmdl IS BOUND.

  rt_child_model = ir_tabmdl->get_entries( ).

ENDMETHOD.


METHOD __on_node_checkbox_change.

* Initial checking.
  CHECK i_nkey IS NOT INITIAL.
  CHECK ir_model IS BOUND.

* Adjust the child nodes.
  IF i_adjust_child_nodes = abap_true.
    IF _adjust_child_nodes_cbxchg(
        i_orig_nkey = i_orig_nkey
        i_nkey      = i_nkey
        ir_model    = ir_model
        i_checked   = i_checked
        i_expand    = i_expand ) = abap_true.
      r_changed = abap_true.
    ENDIF.
  ENDIF.

* Adjust the parent node.
  IF i_adjust_parent_node = abap_true.
    IF _adjust_parent_node_cbxchg(
        i_orig_nkey = i_orig_nkey
        i_nkey      = i_nkey
        ir_model    = ir_model
        i_checked   = i_checked ) = abap_true.
      r_changed = abap_true.
    ENDIF.
  ENDIF.

ENDMETHOD.
ENDCLASS.
