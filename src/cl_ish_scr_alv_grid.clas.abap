class CL_ISH_SCR_ALV_GRID definition
  public
  inheriting from CL_ISH_SCR_ALV_CONTROL
  abstract
  create public .

*"* public components of class CL_ISH_SCR_ALV_GRID
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_ALV_CONTROL_CONSTANTS .
  interfaces IF_ISH_SCR_ALV_GRID .

  aliases CO_UCOMM_BUTTON_CLICK
    for IF_ISH_SCR_ALV_GRID~CO_UCOMM_BUTTON_CLICK .
  aliases CO_UCOMM_DOUBLE_CLICK
    for IF_ISH_SCR_ALV_GRID~CO_UCOMM_DOUBLE_CLICK .
  aliases CO_UCOMM_HOTSPOT_CLICK
    for IF_ISH_SCR_ALV_GRID~CO_UCOMM_HOTSPOT_CLICK .
  aliases CO_UCOMM_ONDRAG
    for IF_ISH_SCR_ALV_GRID~CO_UCOMM_ONDRAG .
  aliases CO_UCOMM_ONDROP
    for IF_ISH_SCR_ALV_GRID~CO_UCOMM_ONDROP .
  aliases CO_UCOMM_ONDROPCOMPLETE
    for IF_ISH_SCR_ALV_GRID~CO_UCOMM_ONDROPCOMPLETE .
  aliases CO_UCOMM_ONDROPGETFLAVOR
    for IF_ISH_SCR_ALV_GRID~CO_UCOMM_ONDROPGETFLAVOR .
  aliases APPEND_ROW
    for IF_ISH_SCR_ALV_GRID~APPEND_ROW .
  aliases BUILD_UCOMM_ROW_COL
    for IF_ISH_SCR_ALV_GRID~BUILD_UCOMM_ROW_COL .
  aliases DELECT_ROW
    for IF_ISH_SCR_ALV_GRID~DELECT_ROW .
  aliases DELECT_ROWS
    for IF_ISH_SCR_ALV_GRID~DELECT_ROWS .
  aliases DISABLE_CELL
    for IF_ISH_SCR_ALV_GRID~DISABLE_CELL .
  aliases DISABLE_ROW
    for IF_ISH_SCR_ALV_GRID~DISABLE_ROW .
  aliases ENABLE_CELL
    for IF_ISH_SCR_ALV_GRID~ENABLE_CELL .
  aliases ENABLE_ROW
    for IF_ISH_SCR_ALV_GRID~ENABLE_ROW .
  aliases GET_ALLOW_NEW_ROWS
    for IF_ISH_SCR_ALV_GRID~GET_ALLOW_NEW_ROWS .
  aliases GET_ALV_GRID
    for IF_ISH_SCR_ALV_GRID~GET_ALV_GRID .
  aliases GET_CELL_FIELDVAL
    for IF_ISH_SCR_ALV_GRID~GET_CELL_FIELDVAL .
  aliases GET_COLUMN_FIELDVALS
    for IF_ISH_SCR_ALV_GRID~GET_COLUMN_FIELDVALS .
  aliases GET_CONFIG_ALV_GRID
    for IF_ISH_SCR_ALV_GRID~GET_CONFIG_ALV_GRID .
  aliases GET_CURRENT_CELL_FIELDVAL
    for IF_ISH_SCR_ALV_GRID~GET_CURRENT_CELL_FIELDVAL .
  aliases GET_FIELDCAT
    for IF_ISH_SCR_ALV_GRID~GET_FIELDCAT .
  aliases GET_FILTER
    for IF_ISH_SCR_ALV_GRID~GET_FILTER .
  aliases GET_LAYOUT
    for IF_ISH_SCR_ALV_GRID~GET_LAYOUT .
  aliases GET_REMIND_SELECTED_ROWS
    for IF_ISH_SCR_ALV_GRID~GET_REMIND_SELECTED_ROWS .
  aliases GET_ROW_FIELDVAL
    for IF_ISH_SCR_ALV_GRID~GET_ROW_FIELDVAL .
  aliases GET_ROW_FIELDVALS
    for IF_ISH_SCR_ALV_GRID~GET_ROW_FIELDVALS .
  aliases GET_ROW_FIELDVAL_OBJECT
    for IF_ISH_SCR_ALV_GRID~GET_ROW_FIELDVAL_OBJECT .
  aliases GET_ROW_FIELDVAL_OBJECTS
    for IF_ISH_SCR_ALV_GRID~GET_ROW_FIELDVAL_OBJECTS .
  aliases GET_SELECTED_ROW_FIELDVAL
    for IF_ISH_SCR_ALV_GRID~GET_SELECTED_ROW_FIELDVAL .
  aliases GET_SELECTED_ROW_FIELDVALS
    for IF_ISH_SCR_ALV_GRID~GET_SELECTED_ROW_FIELDVALS .
  aliases GET_SORT
    for IF_ISH_SCR_ALV_GRID~GET_SORT .
  aliases GET_TOOLBAR_FUNCTIONS
    for IF_ISH_SCR_ALV_GRID~GET_TOOLBAR_FUNCTIONS .
  aliases GET_TOOLBAR_FVAR
    for IF_ISH_SCR_ALV_GRID~GET_TOOLBAR_FVAR .
  aliases GET_UCOMM_COL
    for IF_ISH_SCR_ALV_GRID~GET_UCOMM_COL .
  aliases GET_UCOMM_ROW
    for IF_ISH_SCR_ALV_GRID~GET_UCOMM_ROW .
  aliases GET_VARIANT
    for IF_ISH_SCR_ALV_GRID~GET_VARIANT .
  aliases IS_CELL_ENABLED
    for IF_ISH_SCR_ALV_GRID~IS_CELL_ENABLED .
  aliases IS_ROW_ENABLED
    for IF_ISH_SCR_ALV_GRID~IS_ROW_ENABLED .
  aliases REMOVE_ROW
    for IF_ISH_SCR_ALV_GRID~REMOVE_ROW .
  aliases SELECT_ROW
    for IF_ISH_SCR_ALV_GRID~SELECT_ROW .
  aliases SELECT_ROWS
    for IF_ISH_SCR_ALV_GRID~SELECT_ROWS .
  aliases SET_ALLOW_NEW_ROWS
    for IF_ISH_SCR_ALV_GRID~SET_ALLOW_NEW_ROWS .
  aliases SET_CELL_FIELDVAL
    for IF_ISH_SCR_ALV_GRID~SET_CELL_FIELDVAL .
  aliases SET_COLUMN_FIELDVALS
    for IF_ISH_SCR_ALV_GRID~SET_COLUMN_FIELDVALS .
  aliases SET_DEFAULT_CURSOR
    for IF_ISH_SCR_ALV_GRID~SET_DEFAULT_CURSOR .
  aliases SET_FILTER
    for IF_ISH_SCR_ALV_GRID~SET_FILTER .
  aliases SET_LAYOUT
    for IF_ISH_SCR_ALV_GRID~SET_LAYOUT .
  aliases SET_REMIND_SELECTED_ROWS
    for IF_ISH_SCR_ALV_GRID~SET_REMIND_SELECTED_ROWS .
  aliases SET_SORT
    for IF_ISH_SCR_ALV_GRID~SET_SORT .
  aliases SET_TOOLBAR_FUNCTIONS
    for IF_ISH_SCR_ALV_GRID~SET_TOOLBAR_FUNCTIONS .
  aliases SET_TOOLBAR_FVAR
    for IF_ISH_SCR_ALV_GRID~SET_TOOLBAR_FVAR .
  aliases SET_VARIANT
    for IF_ISH_SCR_ALV_GRID~SET_VARIANT .
  aliases EV_BAD_CELLS
    for IF_ISH_SCR_ALV_GRID~EV_BAD_CELLS .

  constants CO_OTYPE_SCR_ALV_GRID type ISH_OBJECT_TYPE value 3015. "#EC NOTEXT
  data G_FIELDNAME_CELLSTYLE type ISH_FIELDNAME read-only .
  data G_FIELDNAME_FILTERMARK type ISH_FIELDNAME read-only .
  data G_FIELDNAME_IS_CHANGED type ISH_FIELDNAME read-only .
  data G_FIELDNAME_IS_EMPTY type ISH_FIELDNAME read-only .
  data G_FIELDNAME_IS_NEW type ISH_FIELDNAME read-only .
  data G_FIELDNAME_ROW_ID type ISH_FIELDNAME read-only .
  data G_FILTER_SET type ISH_ON_OFF .

  methods GET_VCODE_FOR_BUTTON
    importing
      !IR_BUTTON type ref to CL_ISH_GRID_BUTTON
      !IS_OUTTAB type ANY
    returning
      value(R_VCODE) type TNDYM-VCODE .
  methods MODIFY_CELLSTYLE
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_ENABLE type ISH_ON_OFF
      !I_DISABLE_F4 type ISH_ON_OFF default OFF
    exporting
      !E_MODIFIED type ISH_ON_OFF
    changing
      !CS_OUTTAB type ANY .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~CHECK
    redefinition .
  methods IF_ISH_SCREEN~CHECK_CHANGES
    redefinition .
  methods IF_ISH_SCREEN~CREATE_ALL_LISTBOXES
    redefinition .
  methods IF_ISH_SCREEN~DELETE_EMPTY_LINES
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~INITIALIZE
    redefinition .
  methods IF_ISH_SCREEN~MODIFY_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~PROCESS_AFTER_INPUT
    redefinition .
  methods IF_ISH_SCREEN~PROCESS_BEFORE_OUTPUT
    redefinition .
  methods IF_ISH_SCREEN~REMIND_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_FROM_DY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_ALV_GRID
*"* do not include other source files here!!!

  data GR_ALV_GRID type ref to CL_GUI_ALV_GRID .
  data GR_BUTTONHANDLER type ref to CL_ISH_GRID_BUTTONHANDLER .
  data GR_CELLMERGER type ref to CL_ISH_GRID_CELLMERGER .
  data GR_LISTBOXHANDLER type ref to CL_ISH_GRID_LISTBOXHANDLER .
  data GR_OUTTAB type ref to DATA .
  data GR_SELECTOR type ref to CL_ISH_GRID_SELECTOR .
  data GS_LAYOUT type LVC_S_LAYO .
  data GS_REFRESH_STABLE type LVC_S_STBL .
  data GS_VARIANT type DISVARIANT .
  data GT_BAD_CELL type LVC_T_MODI .
  data GT_DROP_DOWN_ALIAS type LVC_T_DRAL .
  data GT_EXCL_FUNC type UI_FUNCTIONS .
  data GT_F4 type LVC_T_F4 .
  data GT_FIELDCAT type LVC_T_FCAT .
  data GT_FILTER type LVC_T_FILT .
  data GT_FILTER_TMP type LVC_T_FILT .
  data GT_MODIFIED_CELLS type LVC_T_MODI .
  data GT_SELECTED_ROWS type ISH_T_FIELDNAME .
  data GT_SORT type LVC_T_SORT .
  data GT_SORT_TMP type LVC_T_SORT .
  data GT_TOOLBAR_BUTTON type ISH_T_V_NWBUTTON .
  data GT_TOOLBAR_FVARP type ISH_T_V_NWFVARP .
  data G_ALLOW_NEW_ROWS type ISH_ON_OFF value ON. "#EC NOTEXT .
  data G_APPL_EVENTS type ISH_ON_OFF .
  data G_FIELDCAT_CHANGED type ISH_ON_OFF .
  data G_HANDLE_AFTER_REFRESH type ISH_ON_OFF value OFF. "#EC NOTEXT .
  data G_HANDLE_FILTER_IS_CHANGED type ISH_ON_OFF value OFF. "#EC NOTEXT .
  data G_HANDLE_FILTER_IS_EMPTY type ISH_ON_OFF value OFF. "#EC NOTEXT .
  data G_HANDLE_FILTER_IS_NEW type ISH_ON_OFF value OFF. "#EC NOTEXT .
  data G_LAST_ROW_ID type N_NUMC5 value 0. "#EC NOTEXT .
  data G_LAYOUT_SET type ISH_ON_OFF value OFF. "#EC NOTEXT .
  data G_MIN_ROWS type I value 5. "#EC NOTEXT .
  data G_PAI_CODE type CHAR10 .
  data G_REFRESH_SOFT type CHAR01 .
  data G_REMIND_SELECTED_ROWS type ISH_ON_OFF value OFF. "#EC NOTEXT .
  data G_ROWS_TO_APPEND type I value 5. "#EC NOTEXT .
  data G_SET_FILTER_AFTER_UCOMM type ISH_ON_OFF .
  data G_SET_SORT_AFTER_UCOMM type ISH_ON_OFF .
  data G_SORTORDER_IS_CHANGED type I value 0. "#EC NOTEXT .
  data G_SORTORDER_IS_EMPTY type I value 0. "#EC NOTEXT .
  data G_SORTORDER_IS_NEW type I value 0. "#EC NOTEXT .
  data G_SORT_SET type ISH_ON_OFF .
  data G_TOOLBAR_FVARID type NFVARID .
  data G_TOOLBAR_FVAR_SET type ISH_ON_OFF value OFF. "#EC NOTEXT .
  data G_TOOLBAR_VIEWTYPE type NVIEWTYPE .
  data G_VARIANT_SAVE type CHAR1 .
  data G_VARIANT_SAVE_SET type ISH_ON_OFF value OFF. "#EC NOTEXT .
  data G_VARIANT_SET type ISH_ON_OFF value OFF. "#EC NOTEXT .

  methods IS_F4_IN_DISPLAY_MODE
    importing
      value(I_FIELDNAME) type ISH_FIELDNAME
      value(I_ROWNUMBER) type INT4
    returning
      value(R_MODE_DISPLAY) type ISH_ON_OFF .
  methods ACTUALIZE_FILTERMARK
    importing
      !IT_FILTER type LVC_T_FILT optional .
  methods ADD_MERGE_FIELDS
    exporting
      value(ET_FIELDS) type ISH_T_MERGE_FIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CR_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods APPEND_EMPTY_OUTTAB_ENTRIES
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_EXCL_FUNC
    exporting
      !E_EXCL_FUNC_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_F4
    exporting
      !E_F4_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_FIELDCAT
    exporting
      !E_FIELDCAT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_FILTER
    exporting
      !E_FILTER_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_LAYOUT
    exporting
      !E_LAYOUT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_REFRESH_INFO
    exporting
      !E_REFRESH_INFO_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_SORT
    exporting
      !E_SORT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_VARIANT
    exporting
      !E_VARIANT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_T_SCRMOD
    importing
      !IT_MODIFIED type ISHMED_T_SCREEN
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_HANDLE_BEFORE_UCOMM
    importing
      !I_UCOMM type SY-UCOMM optional
    returning
      value(R_HANDLE) type ISH_ON_OFF .
  methods CHECK_HANDLE_FILTERMARK
    returning
      value(R_HANDLE) type ISH_ON_OFF .
  methods CHECK_HANDLE_SORTORDER
    returning
      value(R_HANDLE) type ISH_ON_OFF .
  methods CREATE_EMPTY_COLUMN
    importing
      !IS_ROW_FIELDVAL type RNFIELD_VALUE
      !IS_DFIES type DFIES
    exporting
      !ES_COL_FIELDVAL type RNFIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_EMPTY_COLUMNS
    importing
      !IS_ROW_FIELDVAL type RNFIELD_VALUE
    exporting
      !ET_COL_FIELDVAL type ISH_T_FIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_EMPTY_OUTTAB_ENTRY
    exporting
      !ER_OUTTAB_ENTRY type ref to DATA
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_EMPTY_ROW
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME optional
    exporting
      !ES_ROW_FIELDVAL type RNFIELD_VALUE
      !ET_COL_FIELDVAL type ISH_T_FIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_FIELDCAT_PROPERTIES
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CS_FIELDCAT type LVC_S_FCAT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_GRID_EXCL_FUNC
    exporting
      !ET_EXCL_FUNC type UI_FUNCTIONS
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_GRID_F4
    exporting
      !ET_F4 type LVC_T_F4
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_GRID_FIELDCAT
    exporting
      !ET_FIELDCAT type LVC_T_FCAT
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_GRID_FILTER
    exporting
      !ET_FILTER type LVC_T_FILT
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_GRID_LAYOUT
    exporting
      !ES_LAYOUT type LVC_S_LAYO
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_GRID_MENU_BUTTON
    changing
      !C_UCOMM type SY-UCOMM optional
      !CR_CTMENU type ref to CL_CTMENU optional .
  methods CREATE_GRID_REFRESH_INFO
    exporting
      !ES_REFRESH_STABLE type LVC_S_STBL
      !E_REFRESH_SOFT type CHAR01
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_GRID_SORT
    exporting
      !ET_SORT type LVC_T_SORT
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_GRID_TOOLBAR
    changing
      !CR_TOOLBAR type ref to CL_ALV_EVENT_TOOLBAR_SET optional
      !C_INTERACTIVE type CHAR01 optional .
  methods CREATE_GRID_VARIANT
    exporting
      !ES_VARIANT type DISVARIANT
      !E_VARIANT_SAVE type CHAR1
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DESTROY_GRID
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DISPLAY_MSG_AFTER_SYSEV
    importing
      !IR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  methods DOES_OUTTAB_ENTRY_FIT_FILTER
    importing
      !IS_OUTTAB type ANY
      !IT_FILTER type LVC_T_FILT optional
    preferred parameter IT_FILTER
    returning
      value(R_FITS) type ISH_ON_OFF .
  methods FINALIZE_GRID_EXCL_FUNC
    exporting
      !E_EXCL_FUNC_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CT_EXCL_FUNC type UI_FUNCTIONS optional
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FINALIZE_GRID_F4
    exporting
      !E_F4_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CT_F4 type LVC_T_F4
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FINALIZE_GRID_FIELDCAT
    exporting
      !E_FIELDCAT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CT_FIELDCAT type LVC_T_FCAT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FINALIZE_GRID_FILTER
    exporting
      !E_FILTER_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CT_FILTER type LVC_T_FILT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FINALIZE_GRID_LAYOUT
    exporting
      !E_LAYOUT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CS_LAYOUT type LVC_S_LAYO
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FINALIZE_GRID_MENU_BUTTON
    changing
      !CR_CTMENU type ref to CL_CTMENU optional
      !C_UCOMM type SY-UCOMM optional .
  methods FINALIZE_GRID_REFRESH_INFO
    exporting
      !E_REFRESH_INFO_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CS_REFRESH_STABLE type LVC_S_STBL
      !C_REFRESH_SOFT type CHAR01
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FINALIZE_GRID_SORT
    exporting
      !E_SORT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CT_SORT type LVC_T_SORT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FINALIZE_GRID_TOOLBAR
    changing
      !CR_TOOLBAR type ref to CL_ALV_EVENT_TOOLBAR_SET optional
      !C_INTERACTIVE type CHAR01 optional .
  methods FINALIZE_GRID_VARIANT
    exporting
      !E_VARIANT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CS_VARIANT type DISVARIANT
      !C_VARIANT_SAVE type CHAR1
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FINALIZE_OUTTAB
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_BUTTONHANDLER
    importing
      !I_CREATE type ISH_ON_OFF default ON
    returning
      value(RR_BUTTONHANDLER) type ref to CL_ISH_GRID_BUTTONHANDLER .
  methods GET_CELLMERGER
    importing
      value(I_CREATE) type ISH_ON_OFF default ON
    returning
      value(RR_CELLMERGER) type ref to CL_ISH_GRID_CELLMERGER .
  methods GET_FILTERMARK_FILTER
    returning
      value(RT_FILTER) type LVC_T_FILT .
  methods GET_LISTBOXHANDLER
    importing
      !I_CREATE type ISH_ON_OFF default ON
    returning
      value(RR_LISTBOXHANDLER) type ref to CL_ISH_GRID_LISTBOXHANDLER .
  methods GET_NEXT_ROW_FIELDNAME
    returning
      value(R_ROW_FIELDNAME) type ISH_FIELDNAME .
  methods GET_OUTTAB_DDFIELDS
    exporting
      !ET_DDFIELDS type DDFIELDS
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_OUTTAB_STRUCT_NAME
    exporting
      !E_STRUCTURE_NAME type DD02L-TABNAME
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ROW_FIELDNAME_BY_INDEX
    importing
      !I_ROW type I
    exporting
      !E_ROW_FIELDNAME type ISH_FIELDNAME
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ROW_INDEX_BY_FIELDNAME
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
    exporting
      !E_ROW type I
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SELECTOR
    importing
      value(I_CREATE) type ISH_ON_OFF default ON
    returning
      value(RR_SELECTOR) type ref to CL_ISH_GRID_SELECTOR .
  methods GET_TOOLBAR_STB_BUTTON
    importing
      !IS_BUTTON type V_NWBUTTON
    returning
      value(RS_STB_BUTTON) type STB_BUTTON .
  methods HANDLE_AFTER_REFRESH
    for event AFTER_REFRESH of CL_GUI_ALV_GRID .
  methods HANDLE_AFTER_USER_COMMAND
    for event AFTER_USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM
      !E_SAVED
      !E_NOT_PROCESSED .
  methods HANDLE_BEFORE_USER_COMMAND
    for event BEFORE_USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM .
  methods HANDLE_BUTTON_CLICK
    for event BUTTON_CLICK of CL_GUI_ALV_GRID
    importing
      !ES_COL_ID
      !ES_ROW_NO .
  methods HANDLE_CONTEXT_MENU_REQUEST
    for event CONTEXT_MENU_REQUEST of CL_GUI_ALV_GRID
    importing
      !E_OBJECT .
  methods HANDLE_DATA_CHANGED
    for event DATA_CHANGED of CL_GUI_ALV_GRID
    importing
      !ER_DATA_CHANGED
      !E_ONF4
      !E_ONF4_BEFORE
      !E_ONF4_AFTER
      !E_UCOMM .
  methods HANDLE_DATA_CHANGED_FINISHED
    for event DATA_CHANGED_FINISHED of CL_GUI_ALV_GRID
    importing
      !E_MODIFIED
      !ET_GOOD_CELLS .
  methods HANDLE_DOUBLE_CLICK
    for event DOUBLE_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO .
  methods HANDLE_HOTSPOT_CLICK
    for event HOTSPOT_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW_ID
      !E_COLUMN_ID
      !ES_ROW_NO .
  methods HANDLE_MENU_BUTTON
    for event MENU_BUTTON of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_UCOMM .
  methods HANDLE_ONDRAG
    for event ONDRAG of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO
      !E_DRAGDROPOBJ
      !SENDER .
  methods HANDLE_ONDRAG_INTERNAL
    importing
      !IR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT
      !IR_DND_SOURCE type ref to CL_ISH_DND_GRID
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_ONDROP
    for event ONDROP of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO
      !E_DRAGDROPOBJ
      !SENDER .
  methods HANDLE_ONDROPCOMPLETE
    for event ONDROPCOMPLETE of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO
      !E_DRAGDROPOBJ
      !SENDER .
  methods HANDLE_ONDROPCOMPLETE_INTERNAL
    importing
      !IR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT
      !IR_DND_SOURCE type ref to CL_ISH_DND
      !IR_DND_TARGET type ref to CL_ISH_DND_GRID
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_ONDROPGETFLAVOR
    for event ONDROPGETFLAVOR of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO
      !E_DRAGDROPOBJ
      !E_FLAVORS
      !SENDER .
  methods HANDLE_ONDROPGETFLAVOR_INTERN
    importing
      !IR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT
      !IR_DND_SOURCE type ref to CL_ISH_DND
      !IR_DND_TARGET type ref to CL_ISH_DND_GRID
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_ONDROP_INTERNAL
    importing
      !IR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT
      !IR_DND_SOURCE type ref to CL_ISH_DND
      !IR_DND_TARGET type ref to CL_ISH_DND_GRID
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_ONF4
    for event ONF4 of CL_GUI_ALV_GRID
    importing
      !E_FIELDNAME
      !E_FIELDVALUE
      !ES_ROW_NO
      !ER_EVENT_DATA
      !ET_BAD_CELLS
      !E_DISPLAY .
  methods HANDLE_PRINT_END_OF_LIST
    for event PRINT_END_OF_LIST of CL_GUI_ALV_GRID .
  methods HANDLE_PRINT_END_OF_PAGE
    for event PRINT_END_OF_PAGE of CL_GUI_ALV_GRID .
  methods HANDLE_PRINT_TOP_OF_LIST
    for event PRINT_TOP_OF_LIST of CL_GUI_ALV_GRID .
  methods HANDLE_PRINT_TOP_OF_PAGE
    for event PRINT_TOP_OF_PAGE of CL_GUI_ALV_GRID
    importing
      !TABLE_INDEX .
  methods HANDLE_TOOLBAR
    for event TOOLBAR of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_INTERACTIVE .
  methods HANDLE_USER_COMMAND
    for event USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM .
  methods INITIALIZE_ALT_SELECTION
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_APPL_EVENTS .
  methods INITIALIZE_BUTTONDEFS
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_CELL_MERGING
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_FIELDNAMES .
  methods INITIALIZE_GRID
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_HANDLE_FILTER .
  methods INITIALIZE_LISTBOXDEFS
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_R_OUTTAB
  abstract
    returning
      value(R_NEW_OUTTAB) type ISH_ON_OFF .
  methods INITIALIZE_SORTORDER .
  methods INTERN_SET_DEFAULT_CURSOR
    importing
      !I_SET_FOCUS type ISH_ON_OFF default OFF
      !IS_ROW_ID type LVC_S_ROW optional
      !IS_COL_ID type LVC_S_COL optional
    exporting
      !E_CURSOR_SET type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods IS_ALT_SELECTION_ACTIVE
    importing
      value(I_FIELDNAME) type ISH_FIELDNAME optional
    returning
      value(E_IS_ACTIVE) type ISH_ON_OFF .
  methods IS_CELLMERGING_ACTIVE
    importing
      value(I_FIELDNAME) type ISH_FIELDNAME optional
    returning
      value(R_IS_ACTIVE) type ISH_ON_OFF .
  methods IS_OUTTAB_FIELD_ENABLED
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_ROW_IDX type I
    returning
      value(R_ENABLED) type ISH_ON_OFF .
  methods IS_TECHNICAL_FILTER
    importing
      !IT_FILTER type LVC_T_FILT
    returning
      value(R_IS_TECHNICAL_FILTER) type ISH_ON_OFF .
  methods IS_TECHNICAL_SORT
    importing
      !IT_SORT type LVC_T_SORT
    returning
      value(R_IS_TECHNICAL_SORT) type ISH_ON_OFF .
  methods IS_TECHNICAL_SORTFIELD
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_IS_TECHNICAL_SORTFIELD) type ISH_ON_OFF .
  methods IS_UCOMM_ENABLED
    importing
      !I_UCOMM type SY-UCOMM
    returning
      value(R_ENABLED) type ISH_ON_OFF .
  methods MODIFY_FIELDCAT
    importing
      !IT_MODIFIED type ISHMED_T_SCREEN
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods OK_CODE_SCREEN_INTERNAL
    exporting
      !E_RC type ISH_METHOD_RC
      !E_OKCODE_HANDLED type ISH_ON_OFF
    changing
      !C_OKCODE type SY-UCOMM
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PREPARE_FOR_DRAG_AND_DROP
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_BUTTON_CLICK
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_BUTTON_CLICK_INTERNAL
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_COL_FIELDNAME type ISH_FIELDNAME
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_DOUBLE_CLICK
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_DOUBLE_CLICK_INTERNAL
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_COL_FIELDNAME type ISH_FIELDNAME
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_HOTSPOT_CLICK
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_HOTSPOT_CLICK_INTERNAL
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_COL_FIELDNAME type ISH_FIELDNAME
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_PRINT_END_OF_LIST .
  methods PROCESS_PRINT_END_OF_LIST_INT .
  methods PROCESS_PRINT_END_OF_PAGE .
  methods PROCESS_PRINT_END_OF_PAGE_INT .
  methods PROCESS_PRINT_TOP_OF_LIST .
  methods PROCESS_PRINT_TOP_OF_LIST_INT .
  methods PROCESS_PRINT_TOP_OF_PAGE
    importing
      !TABLE_INDEX type SYINDEX .
  methods PROCESS_PRINT_TOP_OF_PAGE_INT
    importing
      !I_TABLE_INDEX type SYINDEX .
  methods PROCESS_SYSEV_BUTTON_CLICK
    importing
      !I_ROW_IDX type INT4
      !I_FIELDNAME_BUTTON type ISH_FIELDNAME
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_BUTTON_CLICK_INT
    importing
      !I_ROW_IDX type INT4
      !I_FIELDNAME_BUTTON type ISH_FIELDNAME
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_DOUBLE_CLICK
    importing
      !I_ROW_IDX type INT4
      !I_FIELDNAME_DOUBLE_CLICK type ISH_FIELDNAME
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_DOUBLE_CLICK_INT
    importing
      !I_ROW_IDX type INT4
      !I_FIELDNAME_DOUBLE_CLICK type ISH_FIELDNAME
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_HOTSPOT_CLICK
    importing
      !I_ROW_IDX type INT4
      !I_FIELDNAME_HOTSPOT type ISH_FIELDNAME
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_HOTSPOT_CLICK_IN
    importing
      !I_ROW_IDX type INT4
      !I_FIELDNAME_HOTSPOT type ISH_FIELDNAME
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_UCOMM
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_UCOMM_INTERNAL
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_USER_COMMAND
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_USER_COMMAND_INTERNAL
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REFRESH_GRID
    importing
      !I_REFRESH_DROP_DOWN_TABLE type ISH_ON_OFF default OFF
      !I_REFRESH_FIELDCAT type ISH_ON_OFF default OFF
      !I_REFRESH_LAYOUT type ISH_ON_OFF default OFF
      !I_REFRESH_VARIANT type ISH_ON_OFF default OFF
      !I_REFRESH_SORT type ISH_ON_OFF default OFF
      !I_REFRESH_FILTER type ISH_ON_OFF default OFF
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REMIND_SELECTED_ROWS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_ALT_SELECTED_ROWS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_FIELD_FOR_ALT_SELECTION
    exporting
      value(E_SEL_FIELD) type FDNAME
      value(E_GROUP_FIELD) type FDNAME
      value(E_MARK_GROUP) type ISH_ON_OFF
      value(E_MARK_SINGLE) type ISH_ON_OFF
      value(ER_CELLMERGER) type ref to CL_ISH_GRID_CELLMERGER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_GRID_HANDLERS
    importing
      !I_ACTIVATION type ISH_ON_OFF default ON
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_SELECTED_ROWS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSFORM_TO_TECHNICAL_FILTER
    importing
      !IT_FRONTEND_FILTER type LVC_T_FILT
    returning
      value(RT_TECHNICAL_FILTER) type LVC_T_FILT .
  methods TRANSFORM_TO_TECHNICAL_SORT
    importing
      !IT_FRONTEND_SORT type LVC_T_SORT
    returning
      value(RT_TECHNICAL_SORT) type LVC_T_SORT .
  methods TRANSPORT_COLUMN_FROM_OUTTAB
    importing
      !IR_FIELDVAL_ROW type ref to CL_ISH_FIELD_VALUES
      !IS_OUTTAB type ANY
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CS_FIELDVAL_COL type RNFIELD_VALUE
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSPORT_COLUMN_TO_OUTTAB
    importing
      !IR_FIELDVAL_ROW type ref to CL_ISH_FIELD_VALUES
      !IS_FIELDVAL_COL type RNFIELD_VALUE
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CS_OUTTAB type ANY
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSPORT_MODIFIED_CELLS
    importing
      !IT_MODI type LVC_T_MODI optional
    exporting
      !ET_MODIFIED_FV type ISH_T_FIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSPORT_ROW_FROM_OUTTAB
    importing
      !IS_OUTTAB type ANY
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CS_FIELDVAL_ROW type RNFIELD_VALUE
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSPORT_ROW_TO_OUTTAB
    importing
      !IS_FIELDVAL_ROW type RNFIELD_VALUE
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CS_OUTTAB type ANY
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods BUILD_MESSAGE
    redefinition .
  methods COMPLETE_FIELD_VALUES
    redefinition .
  methods FILL_ALL_LABELS
    redefinition .
  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods IS_MESSAGE_HANDLED
    redefinition .
  methods MODIFY_SCREEN_INTERNAL
    redefinition .
  methods SET_CURSOR_INTERNAL
    redefinition .
  methods SET_OK_CODE_AFTER_F4
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_ALV_GRID
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_ALV_GRID IMPLEMENTATION.


METHOD actualize_filtermark.

  DATA: lt_range      TYPE ishmed_t_rn1range,
        ls_range      TYPE rn1range.

  FIELD-SYMBOLS: <lt_filter>      TYPE lvc_t_filt,
                 <ls_filter>      TYPE lvc_s_filt,
                 <lt_outtab>      TYPE STANDARD TABLE,
                 <ls_outtab>      TYPE ANY,
                 <l_field>        TYPE ANY,
                 <l_filtermark>   TYPE ANY,
                 <l_is_changed>   TYPE ANY,
                 <l_is_empty>     TYPE ANY,
                 <l_is_new>       TYPE ANY.

* Initial checking.
  CHECK gr_outtab IS BOUND.

* Assign the outtab.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  CHECK sy-subrc = 0.

* Process only if filtermark should be used.
  CHECK check_handle_filtermark( ) = on.

* Assign <lt_filter>.
  IF it_filter IS SUPPLIED.
    ASSIGN it_filter TO <lt_filter>.
  ELSE.
    ASSIGN gt_filter TO <lt_filter>.
  ENDIF.

* Initialize filtermark with ON.
  LOOP AT <lt_outtab> ASSIGNING <ls_outtab>.
    ASSIGN COMPONENT g_fieldname_filtermark
      OF STRUCTURE <ls_outtab>
      TO <l_filtermark>.
    CHECK sy-subrc = 0.
    <l_filtermark> = on.
  ENDLOOP.

* Further processing only if a filter is specified.
  CHECK LINES( <lt_filter> ) > 0.

* Process each filter criterium.
  LOOP AT <lt_filter> ASSIGNING <ls_filter>.
*   Build the filter range.
    CLEAR: lt_range,
           ls_range.
    ls_range-sign   = <ls_filter>-sign.
    ls_range-option = <ls_filter>-option.
    ls_range-low    = <ls_filter>-low.
    ls_range-high   = <ls_filter>-high.
    APPEND ls_range TO lt_range.
*   Process the outtab for this filter range.
    LOOP AT <lt_outtab> ASSIGNING <ls_outtab>.
*     Assign the filtermark.
      ASSIGN COMPONENT g_fieldname_filtermark
        OF STRUCTURE <ls_outtab>
        TO <l_filtermark>.
      CHECK sy-subrc = 0.
*     If filtermark already processed -> continue.
      CHECK <l_filtermark> = on.
*     Handle IS_CHANGED
      IF g_handle_filter_is_changed = on AND
         NOT g_fieldname_is_changed IS INITIAL.
        ASSIGN COMPONENT g_fieldname_is_changed
          OF STRUCTURE <ls_outtab>
          TO <l_is_changed>.
        CHECK sy-subrc = 0.
        CHECK <l_is_changed> = off.
      ENDIF.
*     Handle IS_EMPTY
      IF g_handle_filter_is_empty = on AND
         NOT g_fieldname_is_empty IS INITIAL.
        ASSIGN COMPONENT g_fieldname_is_empty
          OF STRUCTURE <ls_outtab>
          TO <l_is_empty>.
        CHECK sy-subrc = 0.
        CHECK <l_is_empty> = off.
      ENDIF.
*     Handle IS_NEW
      IF g_handle_filter_is_new = on.
        ASSIGN COMPONENT g_fieldname_is_new
          OF STRUCTURE <ls_outtab>
          TO <l_is_new>.
        CHECK sy-subrc = 0.
        CHECK <l_is_new> = off.
      ENDIF.
*     Check the filter range.
      ASSIGN COMPONENT <ls_filter>-fieldname
        OF STRUCTURE <ls_outtab>
        TO <l_field>.
      CHECK sy-subrc = 0.
      CHECK NOT <l_field> IN lt_range.
*     This outtab entry does not match the filter range.
      <l_filtermark> = off.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.


METHOD add_merge_fields.
* --- --- --- --- --- --- --- --- --- --- ---
* The default implementation does nothing.
* Redefine this method if needed.
  e_rc = 0.
* --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD append_empty_outtab_entries .

  DATA: l_rows            TYPE i,
        l_row_idx         TYPE int4,
        l_rows_to_append  TYPE i,
        lr_outtab_entry   TYPE REF TO data,
        l_rc              TYPE ish_method_rc.

  FIELD-SYMBOLS: <lt_outtab>      TYPE STANDARD TABLE,
                 <ls_outtab>      TYPE ANY,
                 <l_row_id>       TYPE ANY.

* No empty lines in display mode.
  CHECK g_vcode <> co_vcode_display.

* No empty lines if no new rows allowed.
  CHECK g_allow_new_rows = on.

* The number of empty lines to append depends on
* g_min_rows and g_rows_to_append.
  IF g_min_rows       < 1 AND
     g_rows_to_append < 1.
    EXIT.
  ENDIF.

* Processing can only be done if the outtab is available.
  CHECK gr_outtab IS BOUND.

* Assign the outtab.
  ASSIGN gr_outtab->* TO <lt_outtab>.

* Get the number of actual rows.
  DESCRIBE TABLE <lt_outtab> LINES l_rows.

* Determine the number of rows to append.
  l_rows_to_append = 0.
  IF l_rows < g_min_rows.
    l_rows_to_append = g_min_rows - l_rows.
  ENDIF.
  IF l_rows_to_append < g_rows_to_append.
    l_rows_to_append = g_rows_to_append.
  ENDIF.

* Further processing only if there are rows to append.
  CHECK NOT l_rows_to_append = 0.

* Append empty outtab entries.
  l_row_idx = l_rows.
  DO l_rows_to_append TIMES.

*   Create an empty outtab entry.
    CALL METHOD create_empty_outtab_entry
      IMPORTING
        er_outtab_entry = lr_outtab_entry
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    CHECK lr_outtab_entry IS BOUND.
    ASSIGN lr_outtab_entry->* TO <ls_outtab>.
    CHECK sy-subrc = 0.

*   Set the row_id.
    DO 1 TIMES.
      CHECK NOT g_fieldname_row_id IS INITIAL.
      ASSIGN COMPONENT g_fieldname_row_id
        OF STRUCTURE <ls_outtab>
        TO <l_row_id>.
      CHECK sy-subrc = 0.
      <l_row_id> = get_next_row_fieldname( ).
    ENDDO.

*   Handle button fields.
    IF gr_buttonhandler IS BOUND.
      CALL METHOD gr_buttonhandler->finalize_outtab_entry
        CHANGING
          cs_outtab = <ls_outtab>.
    ENDIF.

*   Handle listbox fields.
    IF gr_listboxhandler IS BOUND.
      CALL METHOD gr_listboxhandler->finalize_outtab_entry
        EXPORTING
          i_row_idx          = l_row_idx
        IMPORTING
          e_rc               = l_rc
        CHANGING
          cs_outtab          = <ls_outtab>
          ct_drop_down_alias = gt_drop_down_alias
          cr_errorhandler    = cr_errorhandler.
    ENDIF.

*   Append the outtab entry.
    APPEND <ls_outtab> TO <lt_outtab>.

*   Increment the row index.
    l_row_idx = l_row_idx + 1.

  ENDDO.

ENDMETHOD.


METHOD BUILD_GRID_EXCL_FUNC .

  DATA: lr_config_alv_grid       TYPE REF TO if_ish_config_alv_grid,
        lt_excl_func             TYPE ui_functions,
        l_excl_func_changed      TYPE ish_on_off,
        l_tmp_excl_func_changed  TYPE ish_on_off,
        l_rc                     TYPE ish_method_rc.

* Initializations.
  e_rc               = 0.
  e_excl_func_changed = off.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  lt_excl_func        = gt_excl_func.
  l_excl_func_changed = off.


* If the table of excluding functions is initial
* we first create it.
  IF lt_excl_func IS INITIAL.
    CALL METHOD create_grid_excl_func
      IMPORTING
        et_excl_func    = lt_excl_func
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF NOT lt_excl_func IS INITIAL.
      l_excl_func_changed = on.
    ENDIF.
  ENDIF.

* Now let the configuration modify the table of excluding functions.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF NOT lr_config_alv_grid IS INITIAL.
    l_tmp_excl_func_changed = off.
    CALL METHOD lr_config_alv_grid->build_grid_excl_func
      EXPORTING
        ir_scr_alv_grid     = me
      IMPORTING
        e_rc                = l_rc
        e_excl_func_changed = l_tmp_excl_func_changed
      CHANGING
        ct_excl_func        = lt_excl_func
        cr_errorhandler     = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_excl_func_changed = off.
      l_excl_func_changed = l_tmp_excl_func_changed.
    ENDIF.
  ENDIF.

* No do the specific excl_func modification.
  l_tmp_excl_func_changed = off.
  CALL METHOD finalize_grid_excl_func
    IMPORTING
      e_excl_func_changed = l_tmp_excl_func_changed
      e_rc                = l_rc
    CHANGING
      ct_excl_func        = lt_excl_func
      cr_errorhandler     = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF l_excl_func_changed = off.
    l_excl_func_changed = l_tmp_excl_func_changed.
  ENDIF.

* Remember the table of excluding functions.
  IF l_excl_func_changed = on.
    gt_excl_func = lt_excl_func.
  ENDIF.

* Export.
  e_excl_func_changed = l_excl_func_changed.

ENDMETHOD.


METHOD BUILD_GRID_F4 .

  DATA: lr_config_alv_grid      TYPE REF TO if_ish_config_alv_grid,
        lt_f4                   TYPE lvc_t_f4,
        l_f4_changed            TYPE ish_on_off,
        l_tmp_f4_changed        TYPE ish_on_off,
        l_rc                    TYPE ish_method_rc.

* Initializations.
  e_rc         = 0.
  e_f4_changed = off.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  lt_f4        = gt_f4.
  l_f4_changed = off.


* If the f4 table is initial we first create it.
  IF lt_f4 IS INITIAL.
    CALL METHOD create_grid_f4
      IMPORTING
        et_f4           = lt_f4
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF NOT lt_f4 IS INITIAL.
      l_f4_changed = on.
    ENDIF.
  ENDIF.

* Now let the configuration modify the f4 table.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF NOT lr_config_alv_grid IS INITIAL.
    l_tmp_f4_changed = off.
    CALL METHOD lr_config_alv_grid->build_grid_f4
      EXPORTING
        ir_scr_alv_grid = me
      IMPORTING
        e_rc            = l_rc
        e_f4_changed    = l_tmp_f4_changed
      CHANGING
        ct_f4           = lt_f4
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_f4_changed = off.
      l_f4_changed = l_tmp_f4_changed.
    ENDIF.
  ENDIF.

* Now do the specific f4 table modification.
  l_tmp_f4_changed = off.
  CALL METHOD finalize_grid_f4
    IMPORTING
      e_f4_changed    = l_tmp_f4_changed
      e_rc            = l_rc
    CHANGING
      ct_f4           = lt_f4
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF l_f4_changed = off.
    l_f4_changed = l_tmp_f4_changed.
  ENDIF.

* Remember the field catalogue.
  IF l_f4_changed = on.
    gt_f4 = lt_f4.
  ENDIF.

* Export.
  e_f4_changed = l_f4_changed.

ENDMETHOD.


METHOD build_grid_fieldcat .

  DATA: lr_config_alv_grid      TYPE REF TO if_ish_config_alv_grid,
        lt_fieldcat             TYPE lvc_t_fcat,
        l_fieldcat_changed      TYPE ish_on_off,
        l_tmp_fieldcat_changed  TYPE ish_on_off,
        l_rc                    TYPE ish_method_rc.

* Initializations.
  e_rc               = 0.
  e_fieldcat_changed = off.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  lt_fieldcat        = gt_fieldcat.
  l_fieldcat_changed = off.


* If the field catalogue is initial
* we first create it.
  IF lt_fieldcat IS INITIAL.
    CALL METHOD create_grid_fieldcat
      IMPORTING
        et_fieldcat     = lt_fieldcat
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF NOT lt_fieldcat IS INITIAL.
      l_fieldcat_changed = on.
    ENDIF.
  ENDIF.

* Now let the configuration modify the field catalogue.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF NOT lr_config_alv_grid IS INITIAL.
    l_tmp_fieldcat_changed = off.
    CALL METHOD lr_config_alv_grid->build_grid_fieldcat
      EXPORTING
        ir_scr_alv_grid    = me
      IMPORTING
        e_rc               = l_rc
        e_fieldcat_changed = l_tmp_fieldcat_changed
      CHANGING
        ct_fieldcat        = lt_fieldcat
        cr_errorhandler    = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_fieldcat_changed = off.
      l_fieldcat_changed = l_tmp_fieldcat_changed.
    ENDIF.
  ENDIF.

* No do the specific field catalogue modification.
  l_tmp_fieldcat_changed = off.
  CALL METHOD finalize_grid_fieldcat
    IMPORTING
      e_fieldcat_changed = l_tmp_fieldcat_changed
      e_rc               = l_rc
    CHANGING
      ct_fieldcat        = lt_fieldcat
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF l_fieldcat_changed = off.
    l_fieldcat_changed = l_tmp_fieldcat_changed.
  ENDIF.

* let the cellmerger modify the fieldcat
  l_tmp_fieldcat_changed = off.
  IF gr_cellmerger IS BOUND.
    CALL METHOD gr_cellmerger->modify_fieldcat
      IMPORTING
        e_rc            = l_rc
        e_changed       = l_tmp_fieldcat_changed
      CHANGING
        ct_fieldcat     = lt_fieldcat
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_fieldcat_changed = off.
      l_fieldcat_changed = l_tmp_fieldcat_changed.
    ENDIF.
  ENDIF.

* let the selector modify the fieldcat
  l_tmp_fieldcat_changed = off.
  IF gr_selector IS BOUND.
    CALL METHOD gr_selector->modify_fieldcat
      IMPORTING
        e_rc            = l_rc
        e_is_changed    = l_tmp_fieldcat_changed
      CHANGING
        ct_fieldcat     = lt_fieldcat
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_fieldcat_changed = off.
      l_fieldcat_changed = l_tmp_fieldcat_changed.
    ENDIF.
  ENDIF.

* Remember the field catalogue.
  IF l_fieldcat_changed = on.
    gt_fieldcat = lt_fieldcat.
  ENDIF.

* Export.
  e_fieldcat_changed = l_fieldcat_changed.

ENDMETHOD.


METHOD build_grid_filter .

  DATA: lr_config_alv_grid      TYPE REF TO if_ish_config_alv_grid,
        lt_filter               TYPE lvc_t_filt,
        l_filter_changed        TYPE ish_on_off,
        l_tmp_filter_changed    TYPE ish_on_off,
        l_rc                    TYPE ish_method_rc.

* Initializations.
  e_rc               = 0.
  e_filter_changed = off.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  lt_filter        = get_filter( ).
  l_filter_changed = off.

* Create the filter criteria.
  IF g_first_time = on AND
     g_filter_set = off.
    CALL METHOD create_grid_filter
      IMPORTING
        et_filter       = lt_filter
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    l_filter_changed = on.
  ENDIF.

* Now let the configuration modify the filter criteria.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF NOT lr_config_alv_grid IS INITIAL.
    l_tmp_filter_changed = off.
    CALL METHOD lr_config_alv_grid->build_grid_filter
      EXPORTING
        ir_scr_alv_grid  = me
      IMPORTING
        e_rc             = l_rc
        e_filter_changed = l_tmp_filter_changed
      CHANGING
        ct_filter        = lt_filter
        cr_errorhandler  = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_filter_changed = off.
      l_filter_changed = l_tmp_filter_changed.
    ENDIF.
  ENDIF.

* Now do the specific filter criteria modification.
  l_tmp_filter_changed = off.
  CALL METHOD finalize_grid_filter
    IMPORTING
      e_filter_changed = l_tmp_filter_changed
      e_rc             = l_rc
    CHANGING
      ct_filter        = lt_filter
      cr_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF l_filter_changed = off.
    l_filter_changed = l_tmp_filter_changed.
  ENDIF.

* now let the cellmerger, if active, do the modifications
  IF is_cellmerging_active( ) = on AND g_appl_events = on.
    l_tmp_filter_changed = off.
    CALL METHOD gr_cellmerger->modify_filter
      IMPORTING
        e_rc              = l_rc
        e_changed         = l_tmp_filter_changed
      CHANGING
        ct_filtercriteria = lt_filter
        cr_errorhandler   = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_filter_changed = off.
      l_filter_changed = l_tmp_filter_changed.
    ENDIF.
  ENDIF.

* Handle g_filter_set.
  IF g_filter_set = on.
    g_filter_set = off.
    l_filter_changed = on.
  ENDIF.

* Remember the filter criteria.
  IF l_filter_changed = on.
    gt_filter = lt_filter.
  ENDIF.

* Export.
  e_filter_changed = l_filter_changed.

ENDMETHOD.


METHOD BUILD_GRID_LAYOUT .

  DATA: lr_config_alv_grid    TYPE REF TO if_ish_config_alv_grid,
        ls_layout             TYPE lvc_s_layo,
        l_layout_changed      TYPE ish_on_off,
        l_tmp_layout_changed  TYPE ish_on_off,
        l_rc                  TYPE ish_method_rc.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  l_layout_changed = off.
  ls_layout        = gs_layout.

* If the layout is empty we first create it.
  IF ls_layout IS INITIAL.
    CALL METHOD create_grid_layout
      IMPORTING
        es_layout       = ls_layout
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF NOT ls_layout IS INITIAL.
      l_layout_changed = on.
    ENDIF.
  ENDIF.

* Let the configuration build the layout.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF NOT lr_config_alv_grid IS INITIAL.
    l_tmp_layout_changed = off.
    CALL METHOD lr_config_alv_grid->build_grid_layout
      EXPORTING
        ir_scr_alv_grid  = me
      IMPORTING
        e_layout_changed = l_tmp_layout_changed
        e_rc             = l_rc
      CHANGING
        cs_layout        = ls_layout
        cr_errorhandler  = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_layout_changed = off.
      l_layout_changed = l_tmp_layout_changed.
    ENDIF.
  ENDIF.

* Let derived classes build the layout.
  CALL METHOD finalize_grid_layout
    IMPORTING
      e_layout_changed = l_tmp_layout_changed
      e_rc             = l_rc
    CHANGING
      cs_layout        = ls_layout
      cr_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF l_layout_changed = off.
    l_layout_changed = l_tmp_layout_changed.
  ENDIF.

* Remember the layout
  IF l_layout_changed = on.
    gs_layout = ls_layout.
  ENDIF.

* Export.
  e_layout_changed = l_layout_changed.

ENDMETHOD.


METHOD BUILD_GRID_REFRESH_INFO .

  DATA: lr_config_alv_grid          TYPE REF TO if_ish_config_alv_grid,
        ls_refresh_stable           TYPE lvc_s_stbl,
        l_refresh_soft              TYPE char01,
        l_refresh_info_changed      TYPE ish_on_off,
        l_tmp_refresh_info_changed  TYPE ish_on_off,
        l_rc                        TYPE ish_method_rc.

* Initializations.
  e_rc                   = 0.
  e_refresh_info_changed = off.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  ls_refresh_stable      = gs_refresh_stable.
  l_refresh_soft         = g_refresh_soft.
  l_refresh_info_changed = off.


* If the refresh info is initial we first create it.
  IF ls_refresh_stable IS INITIAL AND
     l_refresh_soft IS INITIAL.
    CALL METHOD create_grid_refresh_info
      IMPORTING
        es_refresh_stable = ls_refresh_stable
        e_refresh_soft    = l_refresh_soft
        e_rc              = l_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF NOT ls_refresh_stable IS INITIAL OR
       NOT l_refresh_soft    IS INITIAL.
      l_refresh_info_changed = on.
    ENDIF.
  ENDIF.

* Now let the configuration modify the refresh info.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF NOT lr_config_alv_grid IS INITIAL.
    l_tmp_refresh_info_changed = off.
    CALL METHOD lr_config_alv_grid->build_grid_refresh_info
      EXPORTING
        ir_scr_alv_grid        = me
      IMPORTING
        e_rc                   = l_rc
        e_refresh_info_changed = l_tmp_refresh_info_changed
      CHANGING
        cs_refresh_stable      = ls_refresh_stable
        c_refresh_soft         = l_refresh_soft
        cr_errorhandler        = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_refresh_info_changed = off.
      l_refresh_info_changed = l_tmp_refresh_info_changed.
    ENDIF.
  ENDIF.

* No do the specific field catalogue modification.
  l_tmp_refresh_info_changed = off.
  CALL METHOD finalize_grid_refresh_info
    IMPORTING
      e_refresh_info_changed = l_tmp_refresh_info_changed
      e_rc                   = l_rc
    CHANGING
      cs_refresh_stable      = ls_refresh_stable
      c_refresh_soft         = l_refresh_soft
      cr_errorhandler        = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF l_refresh_info_changed = off.
    l_refresh_info_changed = l_tmp_refresh_info_changed.
  ENDIF.

* Remember the refresh info.
  IF l_refresh_info_changed = on.
    gs_refresh_stable = ls_refresh_stable.
    g_refresh_soft = l_refresh_soft.
  ENDIF.

* Export.
  e_refresh_info_changed = l_refresh_info_changed.

ENDMETHOD.


METHOD build_grid_sort .

  DATA: lr_config_alv_grid      TYPE REF TO if_ish_config_alv_grid,
        lt_sort                 TYPE lvc_t_sort,
        l_sort_changed          TYPE ish_on_off,
        l_tmp_sort_changed      TYPE ish_on_off,
        l_rc                    TYPE ish_method_rc.

* Initializations.
  e_rc               = 0.
  e_sort_changed = off.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  lt_sort        = get_sort( ).
  l_sort_changed = off.

* Create the sort criteria.
  IF g_first_time = on AND
     g_sort_set   = off.
    CALL METHOD create_grid_sort
      IMPORTING
        et_sort         = lt_sort
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    l_sort_changed = on.
  ENDIF.

* Now let the configuration modify the sort criteria.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF NOT lr_config_alv_grid IS INITIAL.
    l_tmp_sort_changed = off.
    CALL METHOD lr_config_alv_grid->build_grid_sort
      EXPORTING
        ir_scr_alv_grid = me
      IMPORTING
        e_rc            = l_rc
        e_sort_changed  = l_tmp_sort_changed
      CHANGING
        ct_sort         = lt_sort
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_sort_changed = off.
      l_sort_changed = l_tmp_sort_changed.
    ENDIF.
  ENDIF.

* Now do the specific sort modification.
  l_tmp_sort_changed = off.
  CALL METHOD finalize_grid_sort
    IMPORTING
      e_sort_changed  = l_tmp_sort_changed
      e_rc            = l_rc
    CHANGING
      ct_sort         = lt_sort
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF l_sort_changed = off.
    l_sort_changed = l_tmp_sort_changed.
  ENDIF.

* Now let the Cellmerger, if active, modify the sortcriteria
  l_tmp_sort_changed = off.
  IF is_cellmerging_active( ) = on AND g_appl_events = on.
    CALL METHOD gr_cellmerger->modify_sort
      IMPORTING
        e_rc            = l_rc
        e_changed       = l_tmp_sort_changed
      CHANGING
        ct_sortcriteria = lt_sort
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_sort_changed = off.
      l_sort_changed = l_tmp_sort_changed.
    ENDIF.
  ENDIF.

* Handle g_sort_set.
  IF g_sort_set = on.
    g_sort_set = off.
    l_sort_changed = on.
  ENDIF.

* Remember the sort criteria.
  IF l_sort_changed = on.
    gt_sort = lt_sort.
  ENDIF.

* Export.
  e_sort_changed = l_sort_changed.

ENDMETHOD.


METHOD build_grid_variant .

  DATA: lr_config_alv_grid      TYPE REF TO if_ish_config_alv_grid,
        ls_variant              TYPE disvariant,
        l_variant_save          TYPE char1,
        l_variant_changed       TYPE ish_on_off,
        l_tmp_variant_changed   TYPE ish_on_off,
        l_rc                    TYPE ish_method_rc.

* Initializations.
  e_rc               = 0.
  e_variant_changed = off.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  ls_variant        = gs_variant.
  l_variant_save    = g_variant_save.
  l_variant_changed = off.

* On first_time we have to create the variant.
  IF g_first_time = on.
    CALL METHOD create_grid_variant
      IMPORTING
        es_variant      = ls_variant
        e_variant_save  = l_variant_save
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    l_variant_changed = on.
  ENDIF.

* Now let the configuration modify the variant.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF NOT lr_config_alv_grid IS INITIAL.
    l_tmp_variant_changed = off.
    CALL METHOD lr_config_alv_grid->build_grid_variant
      EXPORTING
        ir_scr_alv_grid   = me
      IMPORTING
        e_rc              = l_rc
        e_variant_changed = l_tmp_variant_changed
      CHANGING
        cs_variant        = ls_variant
        c_variant_save    = l_variant_save
        cr_errorhandler   = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF l_variant_changed = off.
      l_variant_changed = l_tmp_variant_changed.
    ENDIF.
  ENDIF.

* Now do the specific variant modification.
  l_tmp_variant_changed = off.
  CALL METHOD finalize_grid_variant
    IMPORTING
      e_variant_changed = l_tmp_variant_changed
      e_rc              = l_rc
    CHANGING
      cs_variant        = ls_variant
      c_variant_save    = l_variant_save
      cr_errorhandler   = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF l_variant_changed = off.
    l_variant_changed = l_tmp_variant_changed.
  ENDIF.

* If the variant was set it is changed.
  IF g_variant_set       = on OR
     g_variant_save_set  = on.
    g_variant_set      = off.
    g_variant_save_set = off.
    l_variant_changed  = on.
  ENDIF.

* Remember the variant settings.
  IF l_variant_changed = on.
    gs_variant     = ls_variant.
    g_variant_save = l_variant_save.
  ENDIF.

* Export.
  e_variant_changed = l_variant_changed.

ENDMETHOD.


METHOD build_message.

  DATA: l_field  TYPE bapi_fld.

* First call the super method.
  CALL METHOD super->build_message
    EXPORTING
      is_message    = is_message
      i_cursorfield = i_cursorfield
    IMPORTING
      es_message    = es_message.

  CLEAR l_field.

* Integrate the buttonhandler.
  IF gr_buttonhandler IS BOUND.
    l_field = gr_buttonhandler->get_cursorfield( es_message-field ).
    IF NOT l_field IS INITIAL.
      es_message-field = l_field.
    ENDIF.
  ENDIF.

* Integrate the listboxhandler.
  IF l_field IS INITIAL AND
     gr_listboxhandler IS BOUND.
    l_field = gr_listboxhandler->get_cursorfield( es_message-field ).
    IF NOT l_field IS INITIAL.
      es_message-field = l_field.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD BUILD_T_SCRMOD .

  DATA: ls_scrmod           TYPE screen,
        l_rc                TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fieldcat>  TYPE lvc_s_fcat,
                 <ls_modified>  TYPE rn1screen.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Build the screen attribute table.
  CLEAR: gt_scrmod.
  LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
    CLEAR ls_scrmod.
*   Name
    ls_scrmod-name = <ls_fieldcat>-fieldname.
*   Active
    IF <ls_fieldcat>-tech = on.
      ls_scrmod-active = false.
    ENDIF.
*   Input
    IF <ls_fieldcat>-edit = on.
      ls_scrmod-input = true.
    ENDIF.
*   Required
    READ TABLE it_modified
      WITH KEY name = <ls_fieldcat>-fieldname
      ASSIGNING <ls_modified>.
    IF sy-subrc = 0.
      ls_scrmod-required = <ls_modified>-required.
    ENDIF.
*   Append to gt_scrmod.
    APPEND ls_scrmod TO gt_scrmod.
  ENDLOOP.

ENDMETHOD.


METHOD check_handle_before_ucomm .

* Initializations.
  r_handle = off.

* Handle only system functions (beginning with '&').
  CHECK NOT i_ucomm IS INITIAL.
  CHECK i_ucomm(1) = '&'.

* Do not handle printing functions.
  CHECK NOT i_ucomm(6) = '&PRINT'.

* Yes, we have to handle before_user_command.
  r_handle = on.

ENDMETHOD.


METHOD check_handle_filtermark.

* Initializations.
  r_handle = off.

* Handle only if we have the filtermark fieldname.
  CHECK NOT g_fieldname_filtermark IS INITIAL.

* Handle only if we have at least one of the special filter fields.
  CHECK ( g_handle_filter_is_changed = on AND
          NOT g_fieldname_is_changed IS INITIAL ) OR
        ( g_handle_filter_is_empty = on AND
          NOT g_fieldname_is_empty IS INITIAL ) OR
        ( g_handle_filter_is_new = on AND
          NOT g_fieldname_is_new IS INITIAL ).

* Yes, we handle the filtermark.
  r_handle = on.

ENDMETHOD.


METHOD check_handle_sortorder.

* Initializations.
  r_handle = off.

* Check the settings.
  CHECK ( g_sortorder_is_changed > 0 AND
          NOT g_fieldname_is_changed IS INITIAL ) OR
        ( g_sortorder_is_empty > 0 AND
          NOT g_fieldname_is_empty IS INITIAL ) OR
        ( g_sortorder_is_new > 0 AND
          NOT g_fieldname_is_new IS INITIAL ).

* Yes, we are working with sortorder fields.
  r_handle = on.

ENDMETHOD.


METHOD complete_field_values.

  DATA: lt_fv_row         TYPE ish_t_field_value,
        lt_fv_col         TYPE ish_t_field_value,
        lr_fv             TYPE REF TO cl_ish_field_values,
        lr_outtab_entry   TYPE REF TO data.

  FIELD-SYMBOLS:
        <ls_outtab>       TYPE ANY,
        <ls_fv_row>       TYPE rnfield_value,
        <ls_fv_col>       TYPE rnfield_value,
        <l_field>         TYPE ANY.

* Initializations.
  e_rc = 0.

* Process only if there is an outtab.
  CHECK gr_outtab IS BOUND.

* Process only if there are field values.
  CHECK NOT gr_screen_values IS INITIAL.

* Get a new empty outtab entry.
  CALL METHOD create_empty_outtab_entry
    IMPORTING
      er_outtab_entry = lr_outtab_entry
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  ASSIGN lr_outtab_entry->* TO <ls_outtab>.
  CHECK sy-subrc = 0.

* Get the row fieldvals.
  CALL METHOD get_row_fieldvals
    IMPORTING
      et_row_fieldval = lt_fv_row
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Set the initial value for each row.
  LOOP AT lt_fv_row ASSIGNING <ls_fv_row>.
*   Process only if there is a further field value.
    CHECK <ls_fv_row>-type = co_fvtype_fv.
    CHECK NOT <ls_fv_row>-object IS INITIAL.
*   Get the column field values.
    lr_fv ?= <ls_fv_row>-object.
    CALL METHOD lr_fv->get_data
      IMPORTING
        et_field_values = lt_fv_col
        e_rc            = e_rc
      CHANGING
        c_errorhandler  = cr_errorhandler.
*   Change field values.
    LOOP AT lt_fv_col ASSIGNING <ls_fv_col>.
*     Process only field values of type single value.
      CHECK <ls_fv_col>-type = co_fvtype_single.
*     Get the corresponding screen value.
      ASSIGN COMPONENT <ls_fv_col>-fieldname
        OF STRUCTURE <ls_outtab>
        TO <l_field>.
      CHECK sy-subrc = 0.
*     Set the initial_value.
      <ls_fv_col>-initial_value = <l_field>.
    ENDLOOP.
*   Change data in screen values.
    CALL METHOD lr_fv->set_data
      EXPORTING
        it_field_values = lt_fv_col
      IMPORTING
        e_rc            = e_rc
      CHANGING
        c_errorhandler  = cr_errorhandler.
  ENDLOOP.

ENDMETHOD.


METHOD create_empty_column .

  DATA: l_fieldname  TYPE ish_fieldname.

* Initializations.
  e_rc = 0.
  CLEAR es_col_fieldval.

  CHECK NOT is_row_fieldval-fieldname IS INITIAL.

* Handle button fields.
  IF gr_buttonhandler IS BOUND.
    l_fieldname = is_dfies-fieldname.
    IF gr_buttonhandler->is_field_supported( l_fieldname ) = on.
      es_col_fieldval =
        gr_buttonhandler->create_empty_column( l_fieldname ).
      EXIT.
    ENDIF.
  ENDIF.

* Handle listbox fields.
  IF gr_listboxhandler IS BOUND.
    l_fieldname = is_dfies-fieldname.
    IF gr_listboxhandler->is_field_supported( l_fieldname ) = on.
      es_col_fieldval =
        gr_listboxhandler->create_empty_column( l_fieldname ).
      EXIT.
    ENDIF.
  ENDIF.

* No column fieldval for filtermark.
  CHECK NOT is_dfies-fieldname = g_fieldname_filtermark.

* type.
  CASE is_dfies-inttype.
    WHEN 'r'.  " object reference
      es_col_fieldval-type = co_fvtype_identify.
    WHEN 'h'   " table
      OR 'l'.  " data reference
*     These types are not supported.
      EXIT.
    WHEN OTHERS.
      es_col_fieldval-type = co_fvtype_single.
  ENDCASE.

* fieldname.
  es_col_fieldval-fieldname = is_dfies-fieldname.

* value.
  CASE es_col_fieldval-fieldname.
    WHEN g_fieldname_row_id.
      es_col_fieldval-value = is_row_fieldval-fieldname.
    WHEN g_fieldname_is_empty.
      es_col_fieldval-value = on.
    WHEN g_fieldname_is_new.
      es_col_fieldval-value = on.
  ENDCASE.

ENDMETHOD.


METHOD create_empty_columns .

  DATA: lt_ddfields           TYPE ddfields,
        lt_col_fieldval       TYPE ish_t_field_value,
        ls_col_fieldval       TYPE rnfield_value.

  FIELD-SYMBOLS: <ls_dfies>  TYPE dfies.

* Initializations.
  e_rc = 0.
  CLEAR et_col_fieldval.

  CHECK NOT is_row_fieldval-fieldname IS INITIAL.

* Get the outtab ddfields.
  CALL METHOD get_outtab_ddfields
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Loop at the outtab ddfields.
  LOOP AT lt_ddfields ASSIGNING <ls_dfies>.
*   Create the corresponding empty column field value.
    CALL METHOD create_empty_column
      EXPORTING
        is_row_fieldval = is_row_fieldval
        is_dfies        = <ls_dfies>
      IMPORTING
        es_col_fieldval = ls_col_fieldval
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
*   Do not append initial columns.
    CHECK NOT ls_col_fieldval IS INITIAL.
*   Add the column field value to lt_col_fieldval.
    APPEND ls_col_fieldval TO lt_col_fieldval.
  ENDLOOP.
  CHECK e_rc = 0.

* Export.
  et_col_fieldval = lt_col_fieldval.

ENDMETHOD.


METHOD create_empty_outtab_entry .

* ATTENTION: Take care that the returned data reference is valid.
*            This means that we have to use CREATE DATA to create
*            the reference.
*            Do not return the reference to a local variable.

  DATA: l_outtab_struct_name  TYPE dd02l-tabname,
        lr_outtab_entry       TYPE REF TO data.

  FIELD-SYMBOLS: <ls_outtab>   TYPE ANY,
                 <l_is_empty>  TYPE ANY,
                 <l_is_new>    TYPE ANY.

* Get the outtab structure name.
  CALL METHOD get_outtab_struct_name
    IMPORTING
      e_structure_name = l_outtab_struct_name
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT l_outtab_struct_name IS INITIAL.

* Instantiate the outtab entry.
  CATCH SYSTEM-EXCEPTIONS create_data_errors = 1.
    CREATE DATA lr_outtab_entry TYPE (l_outtab_struct_name).
  ENDCATCH.
  CHECK sy-subrc = 0.
  CHECK lr_outtab_entry IS BOUND.

* Handle IS_EMPTY.
  DO 1 TIMES.
    CHECK NOT g_fieldname_is_empty IS INITIAL.
    ASSIGN lr_outtab_entry->* TO <ls_outtab>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT g_fieldname_is_empty
      OF STRUCTURE <ls_outtab>
      TO <l_is_empty>.
    CHECK sy-subrc = 0.
    <l_is_empty> = on.
  ENDDO.

* Handle IS_NEW.
  DO 1 TIMES.
    CHECK NOT g_fieldname_is_new IS INITIAL.
    ASSIGN lr_outtab_entry->* TO <ls_outtab>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT g_fieldname_is_new
      OF STRUCTURE <ls_outtab>
      TO <l_is_new>.
    CHECK sy-subrc = 0.
    <l_is_new> = on.
  ENDDO.

* Export
  er_outtab_entry = lr_outtab_entry.

ENDMETHOD.


METHOD create_empty_row .

  DATA: l_row_fieldname  TYPE ish_fieldname,
        lr_row_fieldval  TYPE REF TO cl_ish_field_values,
        ls_row_fieldval  TYPE rnfield_value,
        lt_col_fieldval  TYPE ish_t_field_value.

* Initializations.
  e_rc = 0.
  CLEAR: es_row_fieldval,
         et_col_fieldval.

* Get the row fieldname.
  l_row_fieldname = i_row_fieldname.
  IF l_row_fieldname IS INITIAL.
    l_row_fieldname = get_next_row_fieldname( ).
    CHECK NOT l_row_fieldname IS INITIAL.
  ENDIF.

* Create the row field value object.
  CALL METHOD cl_ish_field_values=>create
    IMPORTING
      e_instance     = lr_row_fieldval
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_row_fieldval IS INITIAL.

* Build the row field value.
  CLEAR ls_row_fieldval.
  ls_row_fieldval-fieldname = l_row_fieldname.
  ls_row_fieldval-type      = co_fvtype_fv.
  ls_row_fieldval-object    = lr_row_fieldval.

* Create the empty columns for this row.
  CALL METHOD create_empty_columns
    EXPORTING
      is_row_fieldval = ls_row_fieldval
    IMPORTING
      et_col_fieldval = lt_col_fieldval
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lt_col_fieldval IS INITIAL.

* Add the columns to the row.
  CALL METHOD lr_row_fieldval->set_data
    EXPORTING
      it_field_values = lt_col_fieldval
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  IF es_row_fieldval IS SUPPLIED.
    es_row_fieldval = ls_row_fieldval.
  ENDIF.
  IF et_col_fieldval IS SUPPLIED.
    et_col_fieldval = lt_col_fieldval.
  ENDIF.

ENDMETHOD.


METHOD create_fieldcat_properties .

* Initializations.
  e_rc = 0.

* Handle special fields.
  CASE cs_fieldcat-fieldname.
*   Tech fields.
    WHEN g_fieldname_row_id      OR
         g_fieldname_cellstyle   OR
         g_fieldname_filtermark  OR
         g_fieldname_is_changed  OR
         g_fieldname_is_empty    OR
         g_fieldname_is_new.
      cs_fieldcat-tech = on.
    WHEN OTHERS.
*     Handle the data type of the field.
      CASE cs_fieldcat-inttype.
        WHEN 'u' OR    " flat struct
             'v' OR    " deep struct
             'h' OR    " table
             'r' OR    " object reference
             'l'.      " data reference
*         These data types are not supported.
*         So these fields are tech fields.
          cs_fieldcat-tech = on.
        WHEN OTHERS.
*         These data types are supported.
*         So make these fields editable.
          cs_fieldcat-edit       = on.
*         F4 has to be handled by self
*           - to allow the configuration handle f4.
*           - to raise data_changed after f4.
          cs_fieldcat-f4availabl = on.
*         Set seltext + tooltip.
          IF cs_fieldcat-seltext IS INITIAL.
            cs_fieldcat-seltext = cs_fieldcat-scrtext_l.
          ENDIF.
          IF cs_fieldcat-tooltip IS INITIAL.
            cs_fieldcat-tooltip = cs_fieldcat-scrtext_l.
          ENDIF.
      ENDCASE.
  ENDCASE.

ENDMETHOD.


METHOD create_grid_excl_func .

* Initializations.
  e_rc = 0.
  CLEAR et_excl_func.

* The default implementation excludes the following functions.
  APPEND cl_gui_alv_grid=>mc_fc_check              TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_refresh            TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_loc_copy_row       TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_loc_delete_row     TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_loc_append_row     TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_loc_insert_row     TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_loc_move_row       TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_loc_copy           TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_loc_cut            TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_loc_paste          TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_loc_paste_new_row  TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_loc_undo           TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_detail             TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_graph              TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_print_back         TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_print_prev         TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_mb_view               TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_mb_export             TO et_excl_func.
  APPEND cl_gui_alv_grid=>mc_fc_info               TO et_excl_func.

ENDMETHOD.


METHOD CREATE_GRID_F4 .

* The default implementation creates a f4-entry for each field
* which has f4availabl set to 'X'.
* Redefine this method (and call the super method) if you have
* any specialities.

  DATA: ls_f4  TYPE lvc_s_f4.

  FIELD-SYMBOLS: <ls_fieldcat>  TYPE lvc_s_fcat.

* Initializations.
  e_rc = 0.
  CLEAR et_f4.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Generate et_f4.
  LOOP AT gt_fieldcat
          ASSIGNING <ls_fieldcat>
          WHERE f4availabl = on.
*   Generate a f4 entry.
    CLEAR: ls_f4.
    ls_f4-fieldname  = <ls_fieldcat>-fieldname.
    ls_f4-register   = on.
    ls_f4-getbefore  = on.
    ls_f4-chngeafter = off.
    INSERT ls_f4 INTO TABLE et_f4.
  ENDLOOP.

ENDMETHOD.


METHOD create_grid_fieldcat .

* The default implementation uses LVC_FIELDCATALOG_MERGE to
* create a field catalogue.
* Redefine this method in derived classes (and call the super method)
* if you have any specialities.

  DATA: l_outtab_struct_name  TYPE dd02l-tabname,
        lt_fieldcat           TYPE lvc_t_fcat,
        l_fieldname           TYPE ish_fieldname,
        l_rc                  TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fieldcat>  TYPE lvc_s_fcat.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Processing can only be done if outtab is available.
  CHECK gr_outtab IS BOUND.

* Get the structure name of the outtab.
  CALL METHOD get_outtab_struct_name
    IMPORTING
      e_structure_name = l_outtab_struct_name
      e_rc             = l_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* Get the default field catalogue.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = l_outtab_struct_name
    CHANGING
      ct_fieldcat            = lt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
*   Fehler & beim Aufruf des Funktionsbausteines &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '019'
        i_mv1           = e_rc
        i_mv2           = 'LVC_FIELDCATALOG_MERGE'
        ir_object       = me
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Create the fieldcat properties.
  LOOP AT lt_fieldcat ASSIGNING <ls_fieldcat>.
*   Create fieldcat properties for this fieldcat entry.
    CALL METHOD create_fieldcat_properties
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cs_fieldcat     = <ls_fieldcat>
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.
  ENDLOOP.
  CHECK e_rc = 0.

* Handle button fields.
  IF gr_buttonhandler IS BOUND.
    CALL METHOD gr_buttonhandler->modify_fieldcat_properties
      CHANGING
        ct_fieldcat = lt_fieldcat.
  ENDIF.

* Handle listbox fields.
  IF gr_listboxhandler IS BOUND.
    CALL METHOD gr_listboxhandler->modify_fieldcat_properties
      CHANGING
        ct_fieldcat = lt_fieldcat.
  ENDIF.

* Export the field catalogue.
  et_fieldcat = lt_fieldcat.

ENDMETHOD.


METHOD CREATE_GRID_FILTER .

* The default implementation does not use filter criteria.
* Redefine this method in derived classes if you have
* any specialities.

  e_rc = 0.
  CLEAR et_filter.

ENDMETHOD.


METHOD create_grid_layout .

* The default implementation creates a default layout.
* Redefine this method in derived classes (and call the super method)
* if you have any specialities.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Set the default layout properties.
  es_layout-no_toolbar = off.
  es_layout-no_totline = on.
  es_layout-no_merging = on.
* Selection of multiple rows
  es_layout-sel_mode   = 'C'.
* Set the fieldname for the style-column
  es_layout-stylefname = g_fieldname_cellstyle.
* Do not allow the delete key.
  es_layout-no_rowins  = on.

ENDMETHOD.


METHOD create_grid_menu_button.

  DATA: l_fcode     TYPE sy-ucomm,
        l_text      TYPE gui_text,
        l_ucomm     TYPE sy-ucomm,
        l_disabled  TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_button>  TYPE v_nwbutton,
                 <ls_fvarp>   TYPE v_nwfvarp.

* Initial checking.
  CHECK NOT cr_ctmenu IS INITIAL.

* Get the button number.
  READ TABLE gt_toolbar_button
    ASSIGNING <ls_button>
    WITH KEY fcode = c_ucomm.
  CHECK sy-subrc = 0.

* Process the corresponding fvarp entries.
  LOOP AT gt_toolbar_fvarp ASSIGNING <ls_fvarp>.
    CHECK <ls_fvarp>-buttonnr = <ls_button>-buttonnr.
    l_fcode = <ls_fvarp>-fcode.
    l_text  = <ls_fvarp>-txt.
    l_ucomm = <ls_fvarp>-fcode.
    IF is_ucomm_enabled( l_ucomm ) = on.
      l_disabled = off.
    ELSE.
      l_disabled = on.
    ENDIF.
    CALL METHOD cr_ctmenu->add_function
      EXPORTING
        fcode    = l_fcode
        text     = l_text
        disabled = l_disabled.
  ENDLOOP.

ENDMETHOD.


METHOD create_grid_refresh_info .

* Redefine this method in derived classes if you have any specialities.

* Initializations.
  e_rc = 0.

* The default implementation keeps the actual row and col stable.
* That means that the entry which is now visible in the first row
* stays also in the first row after the grid is refreshed.
  CLEAR: es_refresh_stable.
  es_refresh_stable-row = on.
  es_refresh_stable-col = on.

* The default implementation does no soft refresh.
  CLEAR: e_refresh_soft.

ENDMETHOD.


METHOD CREATE_GRID_SORT .

* The default implementation uses no sort criteria.
* Redefine this method in derived classes if you have
* any specialities.

  e_rc = 0.
  CLEAR et_sort.

ENDMETHOD.


METHOD create_grid_toolbar .

* The default implementation handles function variants.
* Redefine this method if you have any specialities.

  DATA: lt_button LIKE gt_toolbar_button,
        ls_toolb  TYPE stb_button,
        l_idx     TYPE i.

  FIELD-SYMBOLS: <ls_button>  TYPE v_nwbutton.

* Initial checking.
  CHECK NOT cr_toolbar             IS INITIAL.
  CHECK NOT cr_toolbar->mt_toolbar IS INITIAL.

* Get the toolbar buttons.
  CALL METHOD get_toolbar_functions
    IMPORTING
      et_button = lt_button.

* Further processing only if we have toolbar buttons.
  CHECK NOT lt_button IS INITIAL.

* Now build the toolbar buttons.
  l_idx = 0.
  LOOP AT lt_button ASSIGNING <ls_button>.
    ls_toolb = get_toolbar_stb_button( <ls_button> ).
    CHECK NOT ls_toolb IS INITIAL.
    l_idx = l_idx + 1.
    INSERT ls_toolb INTO cr_toolbar->mt_toolbar INDEX l_idx.
  ENDLOOP.


ENDMETHOD.


METHOD create_grid_variant .

* The default implementation sets a default variant
* using GS_VARIANT and G_VARIANT_SAVE.
* Redefine this method if you have any specialities.

* Initializations.
  e_rc = 0.
  CLEAR: es_variant,
         e_variant_save.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Build es_variant.
  IF g_variant_set = on.
*   GS_VARIANT was already specified -> use it.
    es_variant = gs_variant.
  ELSE.
*   Build a default variant.
    CLEAR es_variant.
    es_variant-report   = cl_ish_utl_rtti=>get_class_name( me ).
    es_variant-username = sy-uname.
    es_variant-handle   = 'GRID'.
  ENDIF.

* Build e_variant_save.
  IF g_variant_save_set = on.
*   G_VARIANT was already specified -> use it.
    e_variant_save = g_variant_save.
  ELSE.
*   Default: Save user defined and global variants
    e_variant_save = 'A'.
  ENDIF.

ENDMETHOD.


METHOD DESTROY_GRID .

  DATA: l_rc  TYPE ish_method_rc.

* Processing is only needed if we have already an alv_grid.
  CHECK NOT gr_alv_grid IS INITIAL.

* Deactivate the handlers.
  CALL METHOD me->set_grid_handlers
    EXPORTING
      i_activation    = off
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Free the alv_grid.
  CALL METHOD gr_alv_grid->free
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
*   Fehler & beim Anlegen des Controls & (Klasse &)
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_ALV_GRID'
        i_mv3           = 'CL_ISH_SCR_ALV_GRID'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

* Clear the gr_alv_grid attribute.
  CLEAR gr_alv_grid.

ENDMETHOD.


METHOD display_msg_after_sysev.

  CHECK ir_errorhandler IS BOUND.

  CALL METHOD ir_errorhandler->display_messages
    EXPORTING
      i_amodal          = off
      i_show_double_msg = off
      i_send_if_one     = on
      i_control         = on.

ENDMETHOD.


METHOD does_outtab_entry_fit_filter.

  DATA: lt_filter        TYPE lvc_t_filt,
        lt_range              TYPE ishmed_t_rn1range,
        ls_range              TYPE rn1range.

  FIELD-SYMBOLS: <l_field>        TYPE ANY,
                 <ls_filter>      TYPE lvc_s_filt.

* Initializations.
  r_fits = on.

* Handle it_filter.
  lt_filter = it_filter.
  IF lt_filter IS INITIAL.
    lt_filter = transform_to_technical_filter( gt_filter ).
  ENDIF.
  CHECK NOT lt_filter IS INITIAL.

* Check is_outtab against the filter.
  LOOP AT lt_filter ASSIGNING <ls_filter>.
*   Build the filter range.
    CLEAR: lt_range,
           ls_range.
    ls_range-sign   = <ls_filter>-sign.
    ls_range-option = <ls_filter>-option.
    ls_range-low    = <ls_filter>-low.
    ls_range-high   = <ls_filter>-high.
    APPEND ls_range TO lt_range.
*   Check the filter range.
    ASSIGN COMPONENT <ls_filter>-fieldname
      OF STRUCTURE is_outtab
      TO <l_field>.
    CHECK sy-subrc = 0.
    CHECK NOT <l_field> IN lt_range.
*   The outtab entry does not fit the filter.
    r_fits = off.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD fill_all_labels.

  DATA: l_fieldname        TYPE ish_fieldname,
        l_label_text(100)  TYPE c,
        l_label_not_set    TYPE ish_on_off,
        l_rc               TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fieldcat>  TYPE lvc_s_fcat.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Loop at the field catalogue.
  LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
*   Get the label for the column.
    l_fieldname = <ls_fieldcat>-fieldname.
    CALL METHOD fill_label
      EXPORTING
        i_fieldname     = l_fieldname
      IMPORTING
        e_label_text    = l_label_text
        e_label_not_set = l_label_not_set
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.
    CHECK l_label_not_set = off.
*   Modify the field catalogue.
*Sta/MED-34863
*    cutting the label is not necessary
*    IF <ls_fieldcat>-outputlen > 0.
*      WRITE l_label_text(<ls_fieldcat>-outputlen) TO l_label_text.
*    ENDIF.
*End/MED-34863
    <ls_fieldcat>-coltext = l_label_text.
    <ls_fieldcat>-seltext = l_label_text.
  ENDLOOP.

ENDMETHOD.


METHOD FINALIZE_GRID_EXCL_FUNC .

* The default implementation does not handle excluding functions.
* Redefine this method if you have any specialities.

ENDMETHOD.


METHOD finalize_grid_f4.

* The default implementation does not handle f4.
* Redefine this method if you have any specialities.

ENDMETHOD.


METHOD FINALIZE_GRID_FIELDCAT .

* The default implementation does not handle fieldcat.
* Redefine this method if you have any specialities.

ENDMETHOD.


METHOD finalize_grid_filter.

* The default implementation does nothing.
* Redefine in derived classes if needed.

ENDMETHOD.


METHOD FINALIZE_GRID_LAYOUT .

* The default implementation does not handle layout.
* Redefine this method if you have any specialities.

ENDMETHOD.


method FINALIZE_GRID_MENU_BUTTON.

* The default implementation does not handle menu buttons.
* Redefine this method if you have any specialities.

endmethod.


METHOD finalize_grid_refresh_info.

* The default implementation does not handle refresh info.
* Redefine this method if you have any specialities.

ENDMETHOD.


METHOD finalize_grid_sort.

* The default implementation does not handle sort.
* Redefine this method if you have any specialities.

ENDMETHOD.


METHOD finalize_grid_toolbar.

* The default implementation does not handle toolbar.
* Redefine this method if you have any specialities.

ENDMETHOD.


METHOD finalize_grid_variant.

* The default implementation does not handle variant.
* Redefine this method if you have any specialities.

ENDMETHOD.


METHOD finalize_outtab.

  DATA: l_rc  TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Append emtpy outtab entries.
  CALL METHOD append_empty_outtab_entries
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Actualize the filtermark.
  CALL METHOD actualize_filtermark.

ENDMETHOD.


METHOD get_buttonhandler.

  rr_buttonhandler = gr_buttonhandler.

  CHECK rr_buttonhandler IS INITIAL.
  CHECK i_create = on.

  gr_buttonhandler =
    cl_ish_grid_buttonhandler=>create_buttonhandler( me ).
  rr_buttonhandler = gr_buttonhandler.

ENDMETHOD.


METHOD get_cellmerger.

  rr_cellmerger = gr_cellmerger.

  CHECK rr_cellmerger IS INITIAL.
  CHECK i_create = on.

  rr_cellmerger = cl_ish_grid_cellmerger=>create_cellmerger( me ).
  gr_cellmerger = rr_cellmerger.

ENDMETHOD.


METHOD get_filtermark_filter .

  DATA: l_outtab_struct_name  TYPE dd02l-tabname,
        ls_filter             TYPE lvc_s_filt,
        l_rc                  TYPE ish_method_rc.

* Initializations.
  CLEAR rt_filter.

* Get the outtab structure name.
  CALL METHOD get_outtab_struct_name
    IMPORTING
      e_structure_name = l_outtab_struct_name
      e_rc             = l_rc.
  CHECK l_rc = 0.
  CHECK NOT l_outtab_struct_name IS INITIAL.

* Build the filtermark filter.
  CLEAR: rt_filter,
         ls_filter.
  ls_filter-fieldname = g_fieldname_filtermark.
  ls_filter-tabname   = '1'.
  ls_filter-intlen    = 1.
  ls_filter-inttype   = 'C'.
  ls_filter-order     = 1.
  ls_filter-ref_field = g_fieldname_filtermark.
  ls_filter-ref_table = l_outtab_struct_name.
  ls_filter-low       = on.
  ls_filter-sign      = 'I'.
  ls_filter-option    = 'EQ'.
  APPEND ls_filter TO rt_filter.

ENDMETHOD.


METHOD get_listboxhandler .

  rr_listboxhandler = gr_listboxhandler.

  CHECK rr_listboxhandler IS INITIAL.
  CHECK i_create = on.

  gr_listboxhandler =
    cl_ish_grid_listboxhandler=>create_listboxhandler( me ).
  rr_listboxhandler = gr_listboxhandler.

ENDMETHOD.


METHOD get_next_row_fieldname.

  g_last_row_id = g_last_row_id + 1.

  r_row_fieldname = g_last_row_id.

ENDMETHOD.


METHOD get_outtab_ddfields.

  DATA: l_outtab_struct_name  TYPE dd02l-tabname,
        l_string              TYPE string,
        lt_ddfields           TYPE ddfields.

* Initializations.
  e_rc = 0.
  CLEAR et_ddfields.

* Get the outtab structure name.
  CALL METHOD get_outtab_struct_name
    IMPORTING
      e_structure_name = l_outtab_struct_name
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.
  CHECK NOT l_outtab_struct_name IS INITIAL.

* Get the outtab structure fields.
  l_string = l_outtab_struct_name.
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
    EXPORTING
      i_data_name     = l_string
      ir_object       = me
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  et_ddfields = lt_ddfields.

ENDMETHOD.


METHOD GET_OUTTAB_STRUCT_NAME .

  DATA: lr_typedescr  TYPE REF TO cl_abap_typedescr,
        lr_tabledescr TYPE REF TO cl_abap_tabledescr,
        lr_datadescr  TYPE REF TO cl_abap_datadescr.

* Initializations.
  CLEAR: e_rc,
         e_structure_name.

* Processing can only be done if the outtab is available.
  CHECK gr_outtab IS BOUND.

* Get the typedescr object for gr_outtab.
  lr_typedescr = cl_abap_typedescr=>describe_by_data_ref( gr_outtab ).

* Cast to a tabledescr object.
  CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
    lr_tabledescr ?= lr_typedescr.
  ENDCATCH.
  CHECK sy-subrc = 0.

* Get the line_type datadescr object.
  lr_datadescr = lr_tabledescr->get_table_line_type( ).
  CHECK NOT lr_datadescr IS INITIAL.

* Get the structure name.
  e_structure_name = lr_datadescr->get_relative_name( ).

ENDMETHOD.


METHOD get_row_fieldname_by_index.

  FIELD-SYMBOLS: <lt_outtab>  TYPE table,
                 <ls_outtab>  TYPE ANY,
                 <l_row_id>   TYPE ANY.

* Initializations.
  e_rc = 0.
  CLEAR e_row_fieldname.

* Processing can only be done if the outtab is available.
  CHECK gr_outtab IS BOUND.

* Processing can only be done if g_fieldname_row_id is known.
  CHECK NOT g_fieldname_row_id IS INITIAL.

* Assign the outtab.
  ASSIGN gr_outtab->* TO <lt_outtab>.

* Get the corresponding outtab entry.
  READ TABLE <lt_outtab>
    ASSIGNING <ls_outtab>
    INDEX i_row.
  CHECK sy-subrc = 0.

* Get the row_id.
  ASSIGN COMPONENT g_fieldname_row_id
    OF STRUCTURE <ls_outtab>
    TO <l_row_id>.

* Export.
  e_row_fieldname = <l_row_id>.

ENDMETHOD.


METHOD get_row_index_by_fieldname.

  FIELD-SYMBOLS: <lt_outtab>  TYPE table.

* Initializations.
  e_rc = 0.
  CLEAR e_row.

* Processing can only be done if the outtab is available.
  CHECK gr_outtab IS BOUND.

* Processing can only be done if g_fieldname_row_id is known.
  CHECK NOT g_fieldname_row_id IS INITIAL.

* Assign the outtab.
  ASSIGN gr_outtab->* TO <lt_outtab>.

* Get the corresponding outtab entry.
  READ TABLE <lt_outtab>
    WITH KEY (g_fieldname_row_id) = i_row_fieldname
    TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

* Export.
  e_row = sy-tabix.

ENDMETHOD.


method GET_SELECTOR.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  rr_selector = gr_selector.

  CHECK NOT rr_selector IS bound.
  CHECK i_create = on.

  gr_selector = cl_ish_grid_selector=>create_selector( me ).
  rr_selector = gr_selector.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
endmethod.


METHOD get_toolbar_stb_button.

  DATA: l_ucomm  TYPE sy-ucomm.

  FIELD-SYMBOLS: <ls_button>  TYPE v_nwbutton.

* Initializations.
  CLEAR rs_stb_button.

* Handle seperators.
  IF is_button-fcode IS INITIAL.
    rs_stb_button-butn_type = cntb_btype_sep.
    EXIT.
  ENDIF.

* The buttontype depends on wether there are sub-menus.
  READ TABLE gt_toolbar_fvarp
    WITH KEY buttonnr = is_button-buttonnr
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    rs_stb_button-butn_type = cntb_btype_dropdown.
  ELSE.
    rs_stb_button-butn_type = cntb_btype_button.
  ENDIF.
* Set disabled.
  l_ucomm = is_button-fcode.
  IF is_ucomm_enabled( l_ucomm ) = on.
    rs_stb_button-disabled = off.
  ELSE.
    rs_stb_button-disabled = on.
  ENDIF.
* Build the rest.
  rs_stb_button-function  = is_button-fcode.
  rs_stb_button-icon      = is_button-icon.
  rs_stb_button-quickinfo = is_button-icon_q.
  rs_stb_button-text      = is_button-buttontxt.

ENDMETHOD.


METHOD get_vcode_for_button.

  DATA: l_row_fieldname  TYPE ish_fieldname.

  FIELD-SYMBOLS: <l_row_id>  TYPE ANY.

* Initializations.
  r_vcode = g_vcode.

* Now check if the row fieldval is disabled.

* Initial checking.
  CHECK NOT g_vcode = co_vcode_display.
  CHECK NOT g_fieldname_row_id IS INITIAL.
  CHECK gr_screen_values IS BOUND.

* Default: display.
  r_vcode = co_vcode_display.

* Get the row_id.
  ASSIGN COMPONENT g_fieldname_row_id
    OF STRUCTURE is_outtab
    TO <l_row_id>.
  CHECK sy-subrc = 0.
  l_row_fieldname = <l_row_id>.

* If the row is disabled we return display.
  CHECK gr_screen_values->get_attr_disabled( l_row_fieldname ) = off.

* The row fieldval is enabled.
  r_vcode = g_vcode.

ENDMETHOD.


METHOD handle_after_refresh.

  DATA: l_refresh_fieldcat  TYPE ish_on_off,
        l_refresh_grid      TYPE ish_on_off.

  FIELD-SYMBOLS: <lt_outtab> TYPE STANDARD TABLE.

* Initializations.
  l_refresh_grid     = off.
  l_refresh_fieldcat = off.

* Initial checking.
  CHECK g_handle_after_refresh = on.
  CHECK gr_outtab IS BOUND.

* reset the global attribut
  g_handle_after_refresh = off.

* Do cellmerging
  IF is_cellmerging_active( ) = on.
*   Assign the outtab.
    ASSIGN gr_outtab->* TO <lt_outtab>.
*   do cellmerging.
    CALL METHOD gr_cellmerger->do_cell_merging
      EXPORTING
        it_fieldcat = gt_fieldcat
      CHANGING
        ct_outtab   = <lt_outtab>.
*   Refresh the grid.
    l_refresh_grid     = on.
    l_refresh_fieldcat = on.
  ENDIF.

* Refresh the grid.
  IF l_refresh_grid = on.
    CALL METHOD refresh_grid
      EXPORTING
        i_refresh_fieldcat = l_refresh_fieldcat.
  ENDIF.

ENDMETHOD.


METHOD handle_after_user_command.

  DATA: lt_sort_front               TYPE lvc_t_sort,
        lt_sort_tech                TYPE lvc_t_sort,
        lt_filter_front             TYPE lvc_t_filt,
        lt_filter_tech              TYPE lvc_t_filt,
        l_sort_changed              TYPE ish_on_off,
        l_filter_changed            TYPE ish_on_off,
        l_rc                        TYPE ish_method_rc.

* ------------------------------------------
* first clear g_handle_after_refresh
  g_handle_after_refresh = off.
* ------------------------------------------
* Process only if needed.
  CHECK check_handle_before_ucomm( e_ucomm ) = on.
* ------------------------------------------
* Handle sort criteria.
  l_sort_changed = off.
  DO 1 TIMES.
*   On cancellation just reset the sort.
    IF e_not_processed        = on AND
       g_set_sort_after_ucomm = on.
      CALL METHOD gr_alv_grid->set_sort_criteria
        EXPORTING
          it_sort                   = gt_sort_tmp
        EXCEPTIONS
          no_fieldcatalog_available = 1
          OTHERS                    = 2.
      EXIT.
    ENDIF.
*   The ucomm was processed.
*   So we set l_sort_changed.
    l_sort_changed = on.
  ENDDO.
* ------------------------------------------
* Handle filter criteria.
  l_filter_changed = off.
  DO 1 TIMES.
*   On cancellation just reset the filter.
    IF e_not_processed          = on AND
       g_set_filter_after_ucomm = on.
      CALL METHOD gr_alv_grid->set_filter_criteria
        EXPORTING
          it_filter                 = gt_filter_tmp
        EXCEPTIONS
          no_fieldcatalog_available = 1
          OTHERS                    = 2.
      EXIT.
    ENDIF.
*   The ucomm was processed.
*   So we set l_filter_changed.
    l_filter_changed = on.
  ENDDO.
* ------------------------------------------
* get actual fieldcat
  CALL METHOD gr_alv_grid->get_frontend_fieldcatalog
    IMPORTING
      et_fieldcatalog = gt_fieldcat.
* ------------------------------------------
* get actual layout
  CALL METHOD gr_alv_grid->get_frontend_layout
    IMPORTING
      es_layout = gs_layout.
* ------------------------------------------
* On sort changes actualize the sort.
  IF l_sort_changed = on.
*   Get the new frontend sort.
    CALL METHOD gr_alv_grid->get_sort_criteria
      IMPORTING
        et_sort = lt_sort_front.
*   Remember the new frontend sort.
    CALL METHOD set_sort
      EXPORTING
        it_sort = lt_sort_front.
*   When working with system events the frontend has to be updated.
    IF g_appl_events = off.
*     Transform the frontend to a technical sort.
      lt_sort_tech = transform_to_technical_sort( lt_sort_front ).
*     Set the technical sort in the grid.
      CALL METHOD gr_alv_grid->set_sort_criteria
        EXPORTING
          it_sort                   = lt_sort_tech
        EXCEPTIONS
          no_fieldcatalog_available = 1
          OTHERS                    = 2.
    ENDIF.
  ENDIF.
* ------------------------------------------
* On filter changes actualize the filtermark and the filter.
  IF l_filter_changed = on.
*   Get the new frontend filter.
    CALL METHOD gr_alv_grid->get_filter_criteria
      IMPORTING
        et_filter = lt_filter_front.
*   Remember the new frontend filter.
    CALL METHOD set_filter
      EXPORTING
        it_filter = lt_filter_front.
*   When working with system events the frontend has to be updated.
    IF g_appl_events = off.
*     Actualize the filtermark.
      CALL METHOD actualize_filtermark.
*     Transform the frontend to a technical filter.
      lt_filter_tech = transform_to_technical_filter( lt_filter_front ).
*     Set the technical filter in the grid.
      CALL METHOD gr_alv_grid->set_filter_criteria
        EXPORTING
          it_filter                 = lt_filter_tech
        EXCEPTIONS
          no_fieldcatalog_available = 1
          OTHERS                    = 2.
    ENDIF.
  ENDIF.
* ------------------------------------------
* handle g_handle_after_refresh (only on system events)
  IF g_appl_events = off AND
     ( l_sort_changed   = on OR
       l_filter_changed = on ).
    g_handle_after_refresh = on.
*   Refresh the grid.
    CALL METHOD refresh_grid.
  ENDIF.

ENDMETHOD.


METHOD handle_before_user_command.

  DATA: lt_filter           TYPE lvc_t_filt,
        lt_sort             TYPE lvc_t_sort.

* Initilizations.
  g_set_filter_after_ucomm = off.
  g_set_sort_after_ucomm   = off.

* Process only if needed.
  CHECK check_handle_before_ucomm( e_ucomm ) = on.

* Handle the filter.
  DO 1 TIMES.
*   Get the grid's filter criteria
    CALL METHOD gr_alv_grid->get_filter_criteria
      IMPORTING
        et_filter = lt_filter.
*   Process only if the grid's filter is a technical filter.
    CHECK is_technical_filter( lt_filter ) = on.
*   A technical filter is active.
*   So reset the grid's filter.
    CALL METHOD gr_alv_grid->set_filter_criteria
      EXPORTING
        it_filter                 = gt_filter
      EXCEPTIONS
        no_fieldcatalog_available = 1
        OTHERS                    = 2.
*   At after_user_command we have to handle the filter.
    gt_filter_tmp = lt_filter.
    g_set_filter_after_ucomm = on.
  ENDDO.

* Handle the sort.
  DO 1 TIMES.
*   Get the grid's sort criteria
    CALL METHOD gr_alv_grid->get_sort_criteria
      IMPORTING
        et_sort = lt_sort.
*   Process only if the grid's sort is a technical sort.
    CHECK is_technical_sort( lt_sort ) = on.
*   A technical sort is active.
*   So reset the grid's sort.
    CALL METHOD gr_alv_grid->set_sort_criteria
      EXPORTING
        it_sort                   = gt_sort
      EXCEPTIONS
        no_fieldcatalog_available = 1
        OTHERS                    = 2.
*   At after_user_command we have to handle the sort.
    gt_sort_tmp = lt_sort.
    g_set_sort_after_ucomm   = on.
  ENDDO.

ENDMETHOD.


METHOD handle_button_click.

  DATA: l_ucomm                  TYPE sy-ucomm,
        l_row                    TYPE i,
        l_row_fieldname          TYPE ish_fieldname,
        l_col_fieldname          TYPE ish_fieldname,
        l_handled                TYPE ish_on_off,
        lt_modi                  TYPE lvc_t_modi,
        lr_errorhandler          TYPE REF TO cl_ishmed_errorhandling,
        l_rc                     TYPE ish_method_rc.

* Get the row and column fieldname.
  l_row = es_row_no-row_id.
  CALL METHOD get_row_fieldname_by_index
    EXPORTING
      i_row           = l_row
    IMPORTING
      e_row_fieldname = l_row_fieldname
      e_rc            = l_rc.
  CHECK l_rc = 0.
  l_col_fieldname = es_col_id-fieldname.

* Build the ucomm.
  CALL METHOD build_ucomm_row_col
    EXPORTING
      i_original_ucomm = co_ucomm_button_click
      i_row_fieldname  = l_row_fieldname
      i_col_fieldname  = l_col_fieldname
    IMPORTING
      e_ucomm          = l_ucomm.

* Remember the ucomm.
  g_ucomm = l_ucomm.

* On application events we have to raise ev_user_command.
  IF g_appl_events = on.
    CALL METHOD raise_ev_user_command
      EXPORTING
        ir_screen = me
        i_ucomm   = l_ucomm.
    EXIT.
  ENDIF.

* Now process the button_click system event.
  CALL METHOD process_sysev_button_click
    EXPORTING
      i_row_idx          = l_row
      i_fieldname_button = l_col_fieldname
    IMPORTING
      e_handled          = l_handled
      et_modi            = lt_modi
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = lr_errorhandler.

* If the system event was not handled by self
* we raise event ev_system_event to allow the framework (e.g. process)
* to process the system event.
  IF l_rc      = 0   AND
     l_handled = off.
    CALL METHOD raise_ev_system_event
      EXPORTING
        i_ucomm         = l_ucomm
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* On errors
*   - Remember the returncode and errorhandler.
*   - Raise a special ok_code.
  IF l_rc <> 0.
    CALL METHOD set_okcode_sysev_error
      EXPORTING
        i_rc            = l_rc
        ir_errorhandler = lr_errorhandler.
    EXIT.
  ENDIF.

* If the button_click system event was not handled
* we have to raise a new ok_code.
  IF l_handled = off.
    CALL METHOD set_okcode_sysev
      EXPORTING
        i_ucomm = l_ucomm.
    EXIT.
  ENDIF.

* The button_click system event was handled.

* Take over modified cells
  IF NOT lt_modi IS INITIAL.
*   Remember the modified cells.
    APPEND LINES OF lt_modi TO gt_modified_cells.
*   Refresh the grid.
    CALL METHOD refresh_grid
      EXPORTING
        i_refresh_drop_down_table = off
        i_refresh_fieldcat        = off
        i_refresh_layout          = off
        i_refresh_variant         = off
        i_refresh_sort            = off
        i_refresh_filter          = off
      IMPORTING
        e_rc                      = l_rc
      CHANGING
        cr_errorhandler           = lr_errorhandler.
*   On errors
*     - Remember the returncode and errorhandler.
*     - Raise a special ok_code.
    IF l_rc <> 0.
      CALL METHOD set_okcode_sysev_error
        EXPORTING
          i_rc            = l_rc
          ir_errorhandler = lr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.

* Display messages.
  display_msg_after_sysev( lr_errorhandler ).

ENDMETHOD.


METHOD handle_context_menu_request .

* Just set g_pai_code to avoid pbo-processing.
  IF g_appl_events = on.
    g_pai_code = 'CTX_MENU'.
  ENDIF.

ENDMETHOD.


METHOD handle_data_changed.

  DATA: l_handled        TYPE ish_on_off,
        l_rc             TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_mod_cell>  TYPE lvc_s_modi.

* Clear gt_bad_cell.
  CLEAR gt_bad_cell.

* Further processing only if we have a protocol.
  CHECK er_data_changed IS BOUND.

* Determine and remind the bad cells.
  LOOP AT er_data_changed->mt_mod_cells ASSIGNING <ls_mod_cell>.
    READ TABLE er_data_changed->mt_good_cells
      WITH KEY row_id     = <ls_mod_cell>-row_id
               sub_row_id = <ls_mod_cell>-sub_row_id
               fieldname  = <ls_mod_cell>-fieldname
      TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      APPEND <ls_mod_cell> TO gt_bad_cell.
    ENDIF.
  ENDLOOP.

* On bad cells data_changed_finished will not be processed.
* Therefore we have to process the good cells right here.
  IF NOT gt_bad_cell IS INITIAL.
    LOOP AT er_data_changed->mt_good_cells ASSIGNING <ls_mod_cell>.
*     Handle listbox fields.
      IF gr_listboxhandler IS BOUND.
        l_handled = off.
        CALL METHOD gr_listboxhandler->process_data_changed_finished
          EXPORTING
            is_modi   = <ls_mod_cell>
          IMPORTING
            e_handled = l_handled
          CHANGING
            ct_modi   = gt_modified_cells.
        CHECK l_handled = off.
      ENDIF.
*     Handle normal fields.
      APPEND <ls_mod_cell> TO gt_modified_cells.
    ENDLOOP.
  ENDIF.

* On bad cells we raise ev_bad_cells.
  IF NOT gt_bad_cell IS INITIAL.
    RAISE EVENT ev_bad_cells.
  ENDIF.

ENDMETHOD.


METHOD handle_data_changed_finished.

  DATA: l_handled        TYPE ish_on_off,
        l_enter_pressed  TYPE ish_on_off,
        lr_ish_alv_grid  TYPE REF TO cl_ish_gui_alv_grid.

  FIELD-SYMBOLS: <ls_modi>  TYPE lvc_s_modi.

* Clear gt_bad_cell.
  CLEAR gt_bad_cell.

* Process the event.
  DO 1 TIMES.

    CHECK e_modified = on.
    CHECK NOT et_good_cells IS INITIAL.

*   Remember the modified cells
*   but take care of the listbox and button fields.
    LOOP AT et_good_cells ASSIGNING <ls_modi>.
*     Handle listbox fields.
      IF gr_listboxhandler IS BOUND.
        l_handled = off.
        CALL METHOD gr_listboxhandler->process_data_changed_finished
          EXPORTING
            is_modi   = <ls_modi>
          IMPORTING
            e_handled = l_handled
          CHANGING
            ct_modi   = gt_modified_cells.
        CHECK l_handled = off.
      ENDIF.
*     Handle normal fields.
      APPEND <ls_modi> TO gt_modified_cells.
    ENDLOOP.

  ENDDO.

* Determine if the user pressed enter in our grid.
  l_enter_pressed = off.
  TRY.
      lr_ish_alv_grid ?= gr_alv_grid.
      IF lr_ish_alv_grid->ish_get_act_eventid( ) =
                            cl_gui_alv_grid=>mc_evt_enter.
        l_enter_pressed = on.
      ENDIF.
    CATCH cx_sy_move_cast_error.
  ENDTRY.

* On enter in our grid we have to remind the cursorfield
* We have to remind the cursorfield.
  IF l_enter_pressed = on.
    g_remind_cursorfield = on.
  ENDIF.

* When working with system events we have to raise a new ok_code
* if the user pressed enter.
  IF g_appl_events   = off AND
     l_enter_pressed = on.
    CALL METHOD cl_gui_cfw=>set_new_ok_code
      EXPORTING
        new_code = 'TEST'.
  ENDIF.

ENDMETHOD.


METHOD handle_double_click.

  DATA: l_ucomm           TYPE sy-ucomm,
        l_row             TYPE i,
        l_row_fieldname   TYPE ish_fieldname,
        l_col_fieldname   TYPE ish_fieldname,
        l_handled         TYPE ish_on_off,
        lt_modi           TYPE lvc_t_modi,
        l_dbclk_ucomm     TYPE sy-ucomm,
        ls_toolbar_button TYPE v_nwbutton,
        ls_toolbar_fvarp  TYPE v_nwfvarp,
        lt_index_rows     TYPE lvc_t_row,
        lt_row_no         TYPE lvc_t_roid,
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling,
        l_rc              TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_nwbutton>  TYPE v_nwbutton,
                 <ls_nwfvarp>   TYPE v_nwfvarp.

* When working with function variants the double_click may be defined
* for a specific function.
  CLEAR l_dbclk_ucomm.
  DO 1 TIMES.
*   Is there a button for double_click?
    IF NOT gt_toolbar_button IS INITIAL.
      READ TABLE gt_toolbar_button
        WITH KEY dbclk = on
        ASSIGNING <ls_nwbutton>.
      IF sy-subrc = 0.
        l_dbclk_ucomm = <ls_nwbutton>-fcode.
      ENDIF.
    ENDIF.
    CHECK l_dbclk_ucomm IS INITIAL.
*   Is there a fvarp for double_click?
    CHECK NOT gt_toolbar_fvarp  IS INITIAL.
    READ TABLE gt_toolbar_fvarp
      WITH KEY dbclk = on
      ASSIGNING <ls_nwfvarp>.
    CHECK sy-subrc = 0.
    l_ucomm = <ls_nwfvarp>-fcode.
  ENDDO.
  IF NOT l_dbclk_ucomm IS INITIAL.
*   Set the doubleclicked row as a selected row.
    IF gr_alv_grid IS BOUND.
      IF NOT e_row IS INITIAL.
        CLEAR lt_index_rows.
        APPEND e_row TO lt_index_rows.
        CALL METHOD gr_alv_grid->set_selected_rows
          EXPORTING
            it_index_rows = lt_index_rows.
      ELSE.
        CLEAR lt_row_no.
        APPEND es_row_no TO lt_row_no.
        CALL METHOD gr_alv_grid->set_selected_rows
          EXPORTING
            it_row_no = lt_row_no.
      ENDIF.
    ENDIF.
*   handle_user_command
    CALL METHOD handle_user_command
      EXPORTING
        e_ucomm = l_dbclk_ucomm.
*   Exit the double_click processing.
    EXIT.
  ENDIF.

* Get the row and column fieldname.
  l_row = e_row-index.
  CALL METHOD get_row_fieldname_by_index
    EXPORTING
      i_row           = l_row
    IMPORTING
      e_row_fieldname = l_row_fieldname
      e_rc            = l_rc.
  CHECK l_rc = 0.
  l_col_fieldname = e_column-fieldname.

* Build the ucomm.
  CALL METHOD build_ucomm_row_col
    EXPORTING
      i_original_ucomm = co_ucomm_double_click
      i_row_fieldname  = l_row_fieldname
      i_col_fieldname  = l_col_fieldname
    IMPORTING
      e_ucomm          = l_ucomm.

* Remember the ucomm.
  g_ucomm = l_ucomm.

* On application events we have to raise ev_user_command.
  IF g_appl_events = on.
    CALL METHOD raise_ev_user_command
      EXPORTING
        ir_screen = me
        i_ucomm   = l_ucomm.
    EXIT.
  ENDIF.

* Now process the double_click system event.
  CALL METHOD process_sysev_double_click
    EXPORTING
      i_row_idx                = l_row
      i_fieldname_double_click = l_col_fieldname
    IMPORTING
      e_handled                = l_handled
      et_modi                  = lt_modi
      e_rc                     = l_rc
    CHANGING
      cr_errorhandler          = lr_errorhandler.

* If the system event was not handled by self
* we raise event ev_system_event to allow the framework (e.g. process)
* to process the system event.
  IF l_rc      = 0   AND
     l_handled = off.
    CALL METHOD raise_ev_system_event
      EXPORTING
        i_ucomm         = l_ucomm
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* On errors
*   - Remember the returncode and errorhandler.
*   - Raise a special ok_code.
  IF l_rc <> 0.
    CALL METHOD set_okcode_sysev_error
      EXPORTING
        i_rc            = l_rc
        ir_errorhandler = lr_errorhandler.
    EXIT.
  ENDIF.

* If the double_click system event was not handled
* we have to raise a new ok_code.
  IF l_handled = off.
    CALL METHOD set_okcode_sysev
      EXPORTING
        i_ucomm = l_ucomm.
    EXIT.
  ENDIF.

* The double_click system event was handled.

* Take over modified cells.
  IF NOT lt_modi IS INITIAL.
*   Remember the modified cells.
    APPEND LINES OF lt_modi TO gt_modified_cells.
*   Refresh the grid.
    CALL METHOD refresh_grid
      EXPORTING
        i_refresh_drop_down_table = off
        i_refresh_fieldcat        = off
        i_refresh_layout          = off
        i_refresh_variant         = off
        i_refresh_sort            = off
        i_refresh_filter          = off
      IMPORTING
        e_rc                      = l_rc
      CHANGING
        cr_errorhandler           = lr_errorhandler.
*   On errors
*     - Remember the returncode and errorhandler.
*     - Raise a special ok_code.
    IF l_rc <> 0.
      CALL METHOD set_okcode_sysev_error
        EXPORTING
          i_rc            = l_rc
          ir_errorhandler = lr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.

* Display messages.
  display_msg_after_sysev( lr_errorhandler ).

ENDMETHOD.


METHOD handle_hotspot_click .

  DATA: l_ucomm          TYPE sy-ucomm,
        l_row            TYPE i,
        l_row_fieldname  TYPE ish_fieldname,
        l_col_fieldname  TYPE ish_fieldname,
        l_handled        TYPE ish_on_off,
        lt_modi          TYPE lvc_t_modi,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_rc             TYPE ish_method_rc,
        l_is_active      TYPE ish_on_off,
        l_is_changed     TYPE ish_on_off.

  FIELD-SYMBOLS: <lt_outtab> TYPE STANDARD TABLE.

* Get the row and column fieldname.
  l_row = e_row_id-index.
  CALL METHOD get_row_fieldname_by_index
    EXPORTING
      i_row           = l_row
    IMPORTING
      e_row_fieldname = l_row_fieldname
      e_rc            = l_rc.
  CHECK l_rc = 0.
  l_col_fieldname = e_column_id-fieldname.

* check if alternative selection is active
  IF is_alt_selection_active( l_col_fieldname ) = on.
    ASSIGN gr_outtab->* TO <lt_outtab>.
*   do the alternative selection
    CALL METHOD gr_selector->do_selection
      EXPORTING
        i_row_idx           = l_row
        i_fieldname         = l_row_fieldname
      IMPORTING
        e_selection_changed = l_is_changed
      CHANGING
        ct_outtab           = <lt_outtab>
        cr_errorhandler     = lr_errorhandler.
*   if there are changes refresh the grid
    IF l_is_changed = on.
      CALL METHOD refresh_grid
        EXPORTING
          i_refresh_fieldcat = on
          i_refresh_layout   = on
        CHANGING
          cr_errorhandler    = lr_errorhandler.
    ENDIF.
    EXIT.
  ENDIF.

* Build the ucomm.
  CALL METHOD build_ucomm_row_col
    EXPORTING
      i_original_ucomm = co_ucomm_hotspot_click
      i_row_fieldname  = l_row_fieldname
      i_col_fieldname  = l_col_fieldname
    IMPORTING
      e_ucomm          = l_ucomm.

* Remember the ucomm.
  g_ucomm = l_ucomm.

* On application events we have to raise ev_user_command.
  IF g_appl_events = on.
    CALL METHOD raise_ev_user_command
      EXPORTING
        ir_screen = me
        i_ucomm   = l_ucomm.
    EXIT.
  ENDIF.

* Now process the hotspot_click system event.
  CALL METHOD process_sysev_hotspot_click
    EXPORTING
      i_row_idx           = l_row
      i_fieldname_hotspot = l_col_fieldname
    IMPORTING
      e_handled           = l_handled
      et_modi             = lt_modi
      e_rc                = l_rc
    CHANGING
      cr_errorhandler     = lr_errorhandler.

* If the system event was not handled by self
* we raise event ev_system_event to allow the framework (e.g. process)
* to process the system event.
  IF l_rc      = 0   AND
     l_handled = off.
    CALL METHOD raise_ev_system_event
      EXPORTING
        i_ucomm         = l_ucomm
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* On errors
*   - Remember the returncode and errorhandler.
*   - Raise a special ok_code.
  IF l_rc <> 0.
    CALL METHOD set_okcode_sysev_error
      EXPORTING
        i_rc            = l_rc
        ir_errorhandler = lr_errorhandler.
    EXIT.
  ENDIF.

* If the hotspot_click system event was not handled
* we have to raise a new ok_code.
  IF l_handled = off.
    CALL METHOD set_okcode_sysev
      EXPORTING
        i_ucomm = l_ucomm.
    EXIT.
  ENDIF.

* The button_click system event was handled.

* Take over modified cells.
  IF NOT lt_modi IS INITIAL.
*   Remember the modified cells.
    APPEND LINES OF lt_modi TO gt_modified_cells.
*   Refresh the grid.
    CALL METHOD refresh_grid
      EXPORTING
        i_refresh_drop_down_table = off
        i_refresh_fieldcat        = off
        i_refresh_layout          = off
        i_refresh_variant         = off
        i_refresh_sort            = off
        i_refresh_filter          = off
      IMPORTING
        e_rc                      = l_rc
      CHANGING
        cr_errorhandler           = lr_errorhandler.
*   On errors
*     - Remember the returncode and errorhandler.
*     - Raise a special ok_code.
    IF l_rc <> 0.
      CALL METHOD set_okcode_sysev_error
        EXPORTING
          i_rc            = l_rc
          ir_errorhandler = lr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.

* Display messages.
  display_msg_after_sysev( lr_errorhandler ).

ENDMETHOD.


METHOD handle_menu_button.

  DATA: lr_config_alv_grid      TYPE REF TO if_ish_config_alv_grid,
        l_rc                    TYPE ish_method_rc.

* Create the menu buttons.
  CALL METHOD create_grid_menu_button
    changing
      cr_ctmenu = e_object
      c_ucomm   = e_ucomm.

* Let the configuration handle the menu buttons.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc.
  IF l_rc <> 0.
    CLEAR lr_config_alv_grid.
  ENDIF.
  IF NOT lr_config_alv_grid IS INITIAL.
    CALL METHOD lr_config_alv_grid->build_grid_menu_button
      EXPORTING
        ir_scr_alv_grid = me
      CHANGING
        cr_ctmenu = e_object
        c_ucomm   = e_ucomm.
  ENDIF.

* Now do specific menu buttons handling.
  CALL METHOD finalize_grid_menu_button
    CHANGING
      cr_ctmenu = e_object
      c_ucomm   = e_ucomm.

ENDMETHOD.


METHOD handle_ondrag.

  DATA: lr_dnd_source       TYPE REF TO cl_ish_dnd_grid,
        lr_dndev            TYPE REF TO cl_ish_dndev,
        lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid,
        l_handled           TYPE ish_on_off,
        l_ucomm             TYPE sy-ucomm,
        lr_errorhandler     TYPE REF TO cl_ishmed_errorhandling,
        l_rc                TYPE ish_method_rc.

* Process only if drag&drop is supported.
  CHECK is_dragdrop_supported( ) = on.

* Create the dnd_source object.
  IF e_dragdropobj IS BOUND.
    CREATE OBJECT lr_dnd_source
      EXPORTING
        ir_scr_alv_grid = me
        is_row          = e_row
        is_col          = e_column
        is_row_no       = es_row_no.
  ENDIF.

* Let the configuration handle the event.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid.
  IF lr_config_alv_grid IS BOUND.
    CALL METHOD lr_config_alv_grid->handle_ondrag
      EXPORTING
        ir_dragdropobj  = e_dragdropobj
        ir_dnd_source   = lr_dnd_source
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* Now do own event processing.
  IF  l_rc      = 0
  AND l_handled = off.
    CALL METHOD handle_ondrag_internal
      EXPORTING
        ir_dragdropobj  = e_dragdropobj
        ir_dnd_source   = lr_dnd_source
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* If the system event was not handled by self
* we raise event ev_system_event to allow the framework (e.g. process)
* to process the system event.
  IF  l_rc      = 0
  AND l_handled = off.
*   Build the ucomm.
    l_ucomm = co_ucomm_ondrag.
    CALL METHOD build_ucomm
      CHANGING
        c_ucomm = l_ucomm.
*   Create the event object.
    CREATE OBJECT lr_dndev
      EXPORTING
        ir_dragdropobj = e_dragdropobj
        ir_source      = lr_dnd_source.
*   Raise the event.
    CALL METHOD raise_ev_system_event
      EXPORTING
        i_ucomm         = l_ucomm
        ir_object       = lr_dndev
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
*   Destroy the event object.
    lr_dndev->destroy( ).
  ENDIF.

* On errors we abort drag&drop.
  DO 1 TIMES.
    CHECK l_rc <> 0.
    CHECK e_dragdropobj IS BOUND.
    CHECK NOT e_dragdropobj->state = cl_dragdropobject=>state_aborted.
    e_dragdropobj->abort( ).
  ENDDO.

* On abort we have to destroy the dnd_source object.
  DO 1 TIMES.
    CHECK e_dragdropobj IS BOUND.
    CHECK e_dragdropobj->state = cl_dragdropobject=>state_aborted.
    CHECK lr_dnd_source IS BOUND.
    lr_dnd_source->destroy( ).
    CLEAR lr_dnd_source.
  ENDDO.

* On errors we set a special ok_code.
  IF l_rc <> 0.
    CALL METHOD set_okcode_sysev_error
      EXPORTING
        i_rc            = l_rc
        ir_errorhandler = lr_errorhandler.
    EXIT.
  ENDIF.

* Modify the drag_drop_object.
  IF e_dragdropobj IS BOUND.
    e_dragdropobj->object = lr_dnd_source.
  ENDIF.

ENDMETHOD.


METHOD handle_ondrag_internal.

* No default implementation.
* Redefine if needed.

  e_rc = 0.
  e_handled = off.

ENDMETHOD.


METHOD handle_ondrop.

  DATA: lr_dnd_source       TYPE REF TO cl_ish_dnd,
        lr_dnd_target       TYPE REF TO cl_ish_dnd_grid,
        lr_dndev            TYPE REF TO cl_ish_dndev_grid,
        lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid,
        l_handled           TYPE ish_on_off,
        l_ucomm             TYPE sy-ucomm,
        lr_errorhandler     TYPE REF TO cl_ishmed_errorhandling,
        l_rc                TYPE ish_method_rc.

* Process only if drag&drop is supported.
  CHECK is_dragdrop_supported( ) = on.

* Get the dnd_source object.
  IF e_dragdropobj         IS BOUND AND
     e_dragdropobj->object IS BOUND.
    TRY.
        lr_dnd_source ?= e_dragdropobj->object.
      CATCH cx_sy_move_cast_error.
        CLEAR lr_dnd_source.
    ENDTRY.
  ENDIF.

* Create the target object.
  IF e_dragdropobj IS BOUND.
    CREATE OBJECT lr_dnd_target
      EXPORTING
        ir_scr_alv_grid = me
        is_row          = e_row
        is_col          = e_column
        is_row_no       = es_row_no.
  ENDIF.

* Let the configuration handle the event.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid.
  IF lr_config_alv_grid IS BOUND.
    CALL METHOD lr_config_alv_grid->handle_ondrop
      EXPORTING
        ir_dragdropobj  = e_dragdropobj
        ir_dnd_source   = lr_dnd_source
        ir_dnd_target   = lr_dnd_target
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* Now do own event processing.
  IF  l_rc = 0
  AND l_handled = off.
    CALL METHOD handle_ondrop_internal
      EXPORTING
        ir_dragdropobj  = e_dragdropobj
        ir_dnd_source   = lr_dnd_source
        ir_dnd_target   = lr_dnd_target
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* If the system event was not handled by self
* we raise event ev_system_event to allow the framework (e.g. process)
* to process the system event.
  IF  l_rc      = 0
  AND l_handled = off.
*   Build the ucomm.
    l_ucomm = co_ucomm_ondrop.
    CALL METHOD build_ucomm
      CHANGING
        c_ucomm = l_ucomm.
*   Create the event object.
    CREATE OBJECT lr_dndev
      EXPORTING
        ir_dragdropobj = e_dragdropobj
        ir_source      = lr_dnd_source
        ir_target      = lr_dnd_target.
*   Raise the event.
    CALL METHOD raise_ev_system_event
      EXPORTING
        i_ucomm         = l_ucomm
        ir_object       = lr_dndev
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
*   Destroy the event object.
    lr_dndev->destroy( ).
  ENDIF.

* Destroy the dnd_target object.
  IF lr_dnd_target IS BOUND.
    lr_dnd_target->destroy( ).
    CLEAR lr_dnd_target.
  ENDIF.

* On errors we abort drag&drop.
  DO 1 TIMES.
    CHECK l_rc <> 0.
    CHECK e_dragdropobj IS BOUND.
    CHECK NOT e_dragdropobj->state = cl_dragdropobject=>state_aborted.
    e_dragdropobj->abort( ).
  ENDDO.

* On abort we have to destroy the dnd_source/target object.
  DO 1 TIMES.
    CHECK e_dragdropobj IS BOUND.
    CHECK e_dragdropobj->state = cl_dragdropobject=>state_aborted.
    CHECK lr_dnd_source IS BOUND.
    lr_dnd_source->destroy( ).
    CLEAR lr_dnd_source.
  ENDDO.

* On errors we set a special ok_code.
  IF l_rc <> 0.
    CALL METHOD set_okcode_sysev_error
      EXPORTING
        i_rc            = l_rc
        ir_errorhandler = lr_errorhandler.
    EXIT.
  ENDIF.

* Display messages.
  display_msg_after_sysev( lr_errorhandler ).

ENDMETHOD.


METHOD handle_ondropcomplete.

  DATA: lr_dnd_source       TYPE REF TO cl_ish_dnd,
        lr_dnd_target       TYPE REF TO cl_ish_dnd_grid,
        lr_dndev            TYPE REF TO cl_ish_dndev_grid,
        lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid,
        l_handled           TYPE ish_on_off,
        l_ucomm             TYPE sy-ucomm,
        lr_errorhandler     TYPE REF TO cl_ishmed_errorhandling,
        l_rc                TYPE ish_method_rc.

* Process only if drag&drop is supported.
  CHECK is_dragdrop_supported( ) = on.

* Get the dnd_source object.
  IF e_dragdropobj         IS BOUND AND
     e_dragdropobj->object IS BOUND.
    TRY.
        lr_dnd_source ?= e_dragdropobj->object.
      CATCH cx_sy_move_cast_error.
        CLEAR lr_dnd_source.
    ENDTRY.
  ENDIF.

* Create the target object.
  IF e_dragdropobj IS BOUND.
    CREATE OBJECT lr_dnd_target
      EXPORTING
        ir_scr_alv_grid = me
        is_row          = e_row
        is_col          = e_column
        is_row_no       = es_row_no.
  ENDIF.

* Let the configuration handle the event.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid.
  IF lr_config_alv_grid IS BOUND.
    CALL METHOD lr_config_alv_grid->handle_ondropcomplete
      EXPORTING
        ir_dragdropobj  = e_dragdropobj
        ir_dnd_source   = lr_dnd_source
        ir_dnd_target   = lr_dnd_target
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* Now do own event processing.
  IF  l_rc = 0
  AND l_handled = off.
    CALL METHOD handle_ondropcomplete_internal
      EXPORTING
        ir_dragdropobj  = e_dragdropobj
        ir_dnd_source   = lr_dnd_source
        ir_dnd_target   = lr_dnd_target
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* If the system event was not handled by self
* we raise event ev_system_event to allow the framework (e.g. process)
* to process the system event.
  IF  l_rc      = 0
  AND l_handled = off.
*   Build the ucomm.
    l_ucomm = co_ucomm_ondropcomplete.
    CALL METHOD build_ucomm
      CHANGING
        c_ucomm = l_ucomm.
*   Create the event object.
    CREATE OBJECT lr_dndev
      EXPORTING
        ir_dragdropobj = e_dragdropobj
        ir_source      = lr_dnd_source
        ir_target      = lr_dnd_target.
*   Raise the event.
    CALL METHOD raise_ev_system_event
      EXPORTING
        i_ucomm         = l_ucomm
        ir_object       = lr_dndev
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
*   Destroy the event object.
    lr_dndev->destroy( ).
  ENDIF.

* Destroy the dnd_target object.
  IF lr_dnd_target IS BOUND.
    lr_dnd_target->destroy( ).
    CLEAR lr_dnd_target.
  ENDIF.

* On errors we abort drag&drop.
  DO 1 TIMES.
    CHECK l_rc <> 0.
    CHECK e_dragdropobj IS BOUND.
    CHECK NOT e_dragdropobj->state = cl_dragdropobject=>state_aborted.
    e_dragdropobj->abort( ).
  ENDDO.

* On abort we have to destroy the dnd_source/target object.
  DO 1 TIMES.
    CHECK e_dragdropobj IS BOUND.
    CHECK e_dragdropobj->state = cl_dragdropobject=>state_aborted.
    CHECK lr_dnd_source IS BOUND.
    lr_dnd_source->destroy( ).
    CLEAR lr_dnd_source.
  ENDDO.

* On errors we set a special ok_code.
  IF l_rc <> 0.
    CALL METHOD set_okcode_sysev_error
      EXPORTING
        i_rc            = l_rc
        ir_errorhandler = lr_errorhandler.
    EXIT.
  ENDIF.

* Display messages.
  display_msg_after_sysev( lr_errorhandler ).

ENDMETHOD.


METHOD handle_ondropcomplete_internal.

* No default implementation.
* Redefine if needed.

  e_rc = 0.
  e_handled = off.

ENDMETHOD.


METHOD handle_ondropgetflavor.

  DATA: lr_dnd_source       TYPE REF TO cl_ish_dnd,
        lr_dnd_target       TYPE REF TO cl_ish_dnd_grid,
        lr_dndev            TYPE REF TO cl_ish_dndev_grid,
        lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid,
        l_handled           TYPE ish_on_off,
        l_ucomm             TYPE sy-ucomm,
        lr_errorhandler     TYPE REF TO cl_ishmed_errorhandling,
        l_rc                TYPE ish_method_rc.

* Process only if drag&drop is supported.
  CHECK is_dragdrop_supported( ) = on.

* Get the dnd_source object.
  IF e_dragdropobj         IS BOUND AND
     e_dragdropobj->object IS BOUND.
    TRY.
        lr_dnd_source ?= e_dragdropobj->object.
      CATCH cx_sy_move_cast_error.
        CLEAR lr_dnd_source.
    ENDTRY.
  ENDIF.

* Create the target object.
  IF e_dragdropobj IS BOUND.
    CREATE OBJECT lr_dnd_target
      EXPORTING
        ir_scr_alv_grid = me
        is_row          = e_row
        is_col          = e_column
        is_row_no       = es_row_no.
  ENDIF.

* Let the configuration handle the event.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid.
  IF lr_config_alv_grid IS BOUND.
    CALL METHOD lr_config_alv_grid->handle_ondrop
      EXPORTING
        ir_dragdropobj  = e_dragdropobj
        ir_dnd_source   = lr_dnd_source
        ir_dnd_target   = lr_dnd_target
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* Now do own event processing.
  IF  l_rc = 0
  AND l_handled = off.
    CALL METHOD handle_ondropgetflavor_intern
      EXPORTING
        ir_dragdropobj  = e_dragdropobj
        ir_dnd_source   = lr_dnd_source
        ir_dnd_target   = lr_dnd_target
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* If the system event was not handled by self
* we raise event ev_system_event to allow the framework (e.g. process)
* to process the system event.
  IF  l_rc      = 0
  AND l_handled = off.
*   Build the ucomm.
    l_ucomm = co_ucomm_ondropgetflavor.
    CALL METHOD build_ucomm
      CHANGING
        c_ucomm = l_ucomm.
*   Create the event object.
    CREATE OBJECT lr_dndev
      EXPORTING
        ir_dragdropobj = e_dragdropobj
        ir_source      = lr_dnd_source
        ir_target      = lr_dnd_target
        it_flavor      = e_flavors.
*   Raise the event.
    CALL METHOD raise_ev_system_event
      EXPORTING
        i_ucomm         = l_ucomm
        ir_object       = lr_dndev
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
*   Destroy the event object.
    lr_dndev->destroy( ).
  ENDIF.

* Destroy the dnd_target object.
  IF lr_dnd_target IS BOUND.
    lr_dnd_target->destroy( ).
    CLEAR lr_dnd_target.
  ENDIF.

* On errors we abort drag&drop.
  DO 1 TIMES.
    CHECK l_rc <> 0.
    CHECK e_dragdropobj IS BOUND.
    CHECK NOT e_dragdropobj->state = cl_dragdropobject=>state_aborted.
    e_dragdropobj->abort( ).
  ENDDO.

* On abort we have to destroy the dnd_source/target object.
  DO 1 TIMES.
    CHECK e_dragdropobj IS BOUND.
    CHECK e_dragdropobj->state = cl_dragdropobject=>state_aborted.
    CHECK lr_dnd_source IS BOUND.
    lr_dnd_source->destroy( ).
    CLEAR lr_dnd_source.
  ENDDO.

* On errors we set a special ok_code.
  IF l_rc <> 0.
    CALL METHOD set_okcode_sysev_error
      EXPORTING
        i_rc            = l_rc
        ir_errorhandler = lr_errorhandler.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD handle_ondropgetflavor_intern.

* No default implementation.
* Redefine if needed.

  e_rc = 0.
  e_handled = off.

ENDMETHOD.


METHOD handle_ondrop_internal.

* No default implementation.
* Redefine if needed.

  e_rc = 0.
  e_handled = off.

ENDMETHOD.


METHOD handle_onf4.

* The default implementation uses method value_request to process
* the f4 command.
* If working with system events, an ok_code is raised on selection.

  DATA: l_rc            TYPE ish_method_rc,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling,
        l_fieldname     TYPE ish_fieldname,
        l_fieldvalue    TYPE nfvvalue,
        l_rownumber     TYPE int4,
        l_value         TYPE nfvvalue,
        ls_modi         TYPE lvc_s_modi,
        l_selection     TYPE ish_on_off,
        l_selected      TYPE ish_on_off,
        l_called        TYPE ish_on_off.

  DATA: ls_help_info          TYPE help_info,
        l_selected_value      TYPE help_info-fldvalue,
        l_outtab_struct_name  TYPE dd02l-tabname,
        lt_dynpselect         TYPE STANDARD TABLE OF dselc,
        lt_dynpvaluetab       TYPE STANDARD TABLE OF dval.

* BEGIN MED 64389 Alina Robu
  DATA: lv_value_request TYPE i VALUE 1,
        lt_messages      TYPE ishmed_t_messages.
* END MED 64389 Alina Robu

  FIELD-SYMBOLS: <lt_modi>    TYPE lvc_t_modi,
                 <lt_outtab>  TYPE STANDARD TABLE,
                 <ls_outtab>  TYPE any,
                 <l_value>    TYPE any.

* Initializations
  CLEAR: l_rc,
         lr_errorhandler.
  l_fieldname  = e_fieldname.
  l_fieldvalue = e_fieldvalue.
  l_rownumber  = es_row_no-row_id.

* F4 is never handled by the alv_grid.
* So avoid calling the grids standard-f4-help.
  er_event_data->m_event_handled = on.

  WHILE lv_value_request = 1. "MED 64389 Alina Robu: call value request at least one time
    lv_value_request = 0. "MED 64389 Alina Robu: reset value to 0 to avoit infinite loop
* Call value request
  CALL METHOD value_request
    EXPORTING
      i_guicontrol_mode = on
      i_fieldname       = l_fieldname
      i_fieldvalue      = l_fieldvalue
      i_rownumber       = l_rownumber
    IMPORTING
      e_value           = l_value
      e_rc              = l_rc
      e_selected        = l_selected
      e_called          = l_called
    CHANGING
      cr_errorhandler   = lr_errorhandler.
  IF l_rc <> 0.
    CALL METHOD raise_ev_error
      EXPORTING
        ir_errorhandler = lr_errorhandler.
    EXIT.

 "ENDIF. --MED 64389 Alina Robu
* BEGIN MED 64389 Alina Robu
    "if value_request has been called and no cycle was selected
    "display message in status bar and show pop-up again
    ELSEIF l_value IS INITIAL AND l_selected = off AND l_called = on
      AND lr_errorhandler IS BOUND.    "++MED-65265 AGujev
      CLEAR lt_messages.
      CALL METHOD lr_errorhandler->get_messages
        IMPORTING
          t_extended_msg = lt_messages.

      READ TABLE lt_messages WITH KEY type = 'S' id = 'N1CORDMG_MED' number = '096' TRANSPORTING NO FIELDS.

      IF sy-subrc = 0.
        lv_value_request = 1.
        MESSAGE S096(N1CORDMG_MED).

        CALL METHOD cl_ish_utl_base=>remove_messages
          EXPORTING
            i_id              = 'N1CORDMG_MED'
            i_number          = '096'
          CHANGING
            cr_errorhandler   = lr_errorhandler.
      ENDIF.
    ENDIF.
  ENDWHILE.
* END MED 64389 Alina Robu

* If we could not handle f4 we have to do standard f4.
  IF l_called = off.
    DO 1 TIMES.
*     Get the outtab structure name.
      CALL METHOD get_outtab_struct_name
        IMPORTING
          e_structure_name = l_outtab_struct_name
          e_rc             = l_rc.
      CHECK l_rc = 0.
      CHECK NOT l_outtab_struct_name IS INITIAL.
*     Build ls_help_info.
      CLEAR: ls_help_info.
      ls_help_info-call       =  'T'.
      ls_help_info-object     =  'F'.
      ls_help_info-tabname    =  l_outtab_struct_name.
      ls_help_info-fieldname  =  e_fieldname.
*MED-38907
*      IF g_vcode = co_vcode_display.
*        ls_help_info-show     =  on.
*      ENDIF.
      ls_help_info-show       =  is_f4_in_display_mode( i_fieldname = l_fieldname
                                                        i_rownumber = l_rownumber ).
*MED-38907
*     Call standard f4.
      CALL FUNCTION 'HELP_START'
        EXPORTING
          help_infos   = ls_help_info
        IMPORTING
          selection    = l_selection
          select_value = l_selected_value
        TABLES
          dynpselect   = lt_dynpselect
          dynpvaluetab = lt_dynpvaluetab.
*     Handle user's input.
      IF l_selection = on.
        l_selected = on.
        l_value    = l_selected_value.
      ELSE.
        l_selected = off.
        CLEAR l_value.
      ENDIF.
    ENDDO.
  ENDIF.

* We have to remind the cursorfield.
  g_remind_cursorfield = on.

* If the user selected a value we have to
* transport it to the grid-cell.
  IF l_selected = on.
    DO 1 TIMES.
      CHECK NOT er_event_data IS INITIAL.
      CHECK er_event_data->m_data IS BOUND.
      ASSIGN er_event_data->m_data->* TO <lt_modi>.
      CHECK sy-subrc = 0.
      CLEAR ls_modi.
      ls_modi-row_id    = es_row_no-row_id.
      ls_modi-fieldname = e_fieldname.
      ls_modi-value     = l_value.
      APPEND ls_modi TO <lt_modi>.
    ENDDO.
  ENDIF.

* If the user selected a value and we are in system-event mode
* we have to raise a new ok_code.
  IF l_selected    = on AND
     g_appl_events = off.
    CALL METHOD cl_gui_cfw=>set_new_ok_code
      EXPORTING
        new_code = '/00'.
  ENDIF.

ENDMETHOD.


METHOD handle_print_end_of_list .

* Now process the print_end_of_list event.
  CALL METHOD process_print_end_of_list.

ENDMETHOD.


METHOD handle_print_end_of_page .

* Now process the print_end_of_page event.
  CALL METHOD process_print_end_of_page.

ENDMETHOD.


METHOD handle_print_top_of_list .

* Now process the print_top_of_list event.
  CALL METHOD process_print_top_of_list.

ENDMETHOD.


METHOD handle_print_top_of_page .

* Now process the print_top_of_page event.
  CALL METHOD process_print_top_of_page
    EXPORTING
      table_index = table_index.

ENDMETHOD.


METHOD handle_toolbar.

  DATA: lr_config_alv_grid      TYPE REF TO if_ish_config_alv_grid,
        l_rc                    TYPE ish_method_rc.

* Create the default toolbar.
  CALL METHOD create_grid_toolbar
    CHANGING
      cr_toolbar    = e_object
      c_interactive = e_interactive.

* Let the configuration handle the toolbar.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc.
  IF l_rc <> 0.
    CLEAR lr_config_alv_grid.
  ENDIF.
  IF NOT lr_config_alv_grid IS INITIAL.
    CALL METHOD lr_config_alv_grid->build_grid_toolbar
      EXPORTING
        ir_scr_alv_grid = me
      CHANGING
        cr_toolbar      = e_object
        c_interactive   = e_interactive.
  ENDIF.

* Now do specific toolbar handling.
  CALL METHOD finalize_grid_toolbar
    CHANGING
      cr_toolbar    = e_object
      c_interactive = e_interactive.

ENDMETHOD.


METHOD handle_user_command.

  DATA: l_ucomm          TYPE sy-ucomm,
        l_handled        TYPE ish_on_off,
        lt_modi          TYPE lvc_t_modi,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_rc             TYPE ish_method_rc.

  CHECK NOT e_ucomm IS INITIAL.

* Build the ucomm.
  l_ucomm = e_ucomm.
  CALL METHOD build_ucomm
    CHANGING
      c_ucomm = l_ucomm.
  CHECK NOT l_ucomm IS INITIAL.

* Remember the ucomm.
  g_ucomm = l_ucomm.

* On application events we have to raise ev_user_command.
  IF g_appl_events = on.
    CALL METHOD raise_ev_user_command
      EXPORTING
        ir_screen = me
        i_ucomm   = l_ucomm.
    EXIT.
  ENDIF.

* Now process the user_command system event.
  CALL METHOD process_sysev_ucomm
    EXPORTING
      i_ucomm         = e_ucomm
    IMPORTING
      e_handled       = l_handled
      et_modi         = lt_modi
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

* If the system event was not handled by self
* we raise event ev_system_event to allow the framework (e.g. process)
* to process the system event.
  IF l_rc      = 0   AND
     l_handled = off.
    CALL METHOD raise_ev_system_event
      EXPORTING
        i_ucomm         = l_ucomm
      IMPORTING
        e_handled       = l_handled
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
  ENDIF.

* On errors raise a special ok_code.
  IF l_rc <> 0.
    CALL METHOD set_okcode_sysev_error
      EXPORTING
        i_rc            = l_rc
        ir_errorhandler = lr_errorhandler.
    EXIT.
  ENDIF.

* If the user_command system event was not handled
* we have to raise a new ok_code.
  IF l_handled = off.
    CALL METHOD set_okcode_sysev
      EXPORTING
        i_ucomm = l_ucomm.
    EXIT.
  ENDIF.

* The user_command system event was handled.

* Now take over modified cells.
  IF NOT lt_modi IS INITIAL.
*   Remember the modified cells.
    APPEND LINES OF lt_modi TO gt_modified_cells.
*   Refresh the grid.
    CALL METHOD refresh_grid
      EXPORTING
        i_refresh_drop_down_table = off
        i_refresh_fieldcat        = off
        i_refresh_layout          = off
        i_refresh_variant         = off
        i_refresh_sort            = off
        i_refresh_filter          = off
      IMPORTING
        e_rc                      = l_rc
      CHANGING
        cr_errorhandler           = lr_errorhandler.
*   On errors
*     - Remember the returncode and errorhandler.
*     - Raise a special ok_code.
    IF l_rc <> 0.
      CALL METHOD set_okcode_sysev_error
        EXPORTING
          i_rc            = l_rc
          ir_errorhandler = lr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.

* Display messages.
  display_msg_after_sysev( lr_errorhandler ).

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_scr_alv_grid.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_scr_alv_grid.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~check.

  DATA: l_row_fieldname      TYPE ish_fieldname,
        l_par                TYPE bapiret2-parameter,
        l_rc                 TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_dc_prot>  TYPE lvc_s_msg1.

* First call the super method.
  CALL METHOD super->if_ish_screen~check
    EXPORTING
      i_check_mandatory_fields = i_check_mandatory_fields
      i_check_field_values     = i_check_field_values
    IMPORTING
      e_rc                     = e_rc
    CHANGING
      cr_errorhandler          = cr_errorhandler.

* Handle gt_bad_cell.
  IF NOT gt_bad_cell IS INITIAL.
    e_rc = 1.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~check_changes.

* Initializations.
  e_rc      = 0.
  e_changed = off.

* Fire event data_changed/_finished.
  IF gr_alv_grid IS BOUND.
    gr_alv_grid->check_changed_data( ).
  ENDIF.

* Handle gt_modified_cells.
  IF NOT gt_modified_cells IS INITIAL.
    e_changed = on.
    EXIT.
  ENDIF.

* Handle gt_bad_cell.
  IF NOT gt_bad_cell IS INITIAL.
    e_changed = on.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~create_all_listboxes.

  DATA: l_row_idx  TYPE int4,
        l_rc       TYPE ish_method_rc.

  FIELD-SYMBOLS: <lt_outtab>     TYPE table,
                 <ls_outtab>     TYPE ANY.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK gr_listboxhandler IS BOUND.
  CHECK gr_outtab         IS BOUND.

* Assign the outtab.
  ASSIGN gr_outtab->* TO <lt_outtab>.

* Process each row.
  l_row_idx = 0.
  LOOP AT <lt_outtab> ASSIGNING <ls_outtab>.
    l_row_idx = l_row_idx + 1.
*   Let the listboxhandler process the row.
    CALL METHOD gr_listboxhandler->finalize_outtab_entry
      EXPORTING
        i_row_idx          = l_row_idx
      IMPORTING
        e_rc               = l_rc
      CHANGING
        cs_outtab          = <ls_outtab>
        ct_drop_down_alias = gt_drop_down_alias
        cr_errorhandler    = cr_errorhandler.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_screen~delete_empty_lines.

* The default implementation removes all row fieldvals
* which's column fieldvals are empty.
* The ROW_ID and CELLSTYLE columns are ignored.

  DATA: lt_row_fieldval  TYPE ish_t_field_value,
        lt_col_fieldval  TYPE ish_t_field_value,
        l_remove_row     TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_row_fieldval>  TYPE rnfield_value,
                 <ls_col_fieldval>  TYPE rnfield_value.

* Initializations.
  e_rc = 0.

* Get all row fieldvals.
  CALL METHOD get_row_fieldvals
    IMPORTING
      et_row_fieldval = lt_row_fieldval
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Now process each row.
  LOOP AT lt_row_fieldval ASSIGNING <ls_row_fieldval>.
*   Get the column fieldvals.
    CALL METHOD get_column_fieldvals
      EXPORTING
        i_row_fieldname = <ls_row_fieldval>-fieldname
      IMPORTING
        et_col_fieldval = lt_col_fieldval
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
*   Now check each column if it is empty.
*   ROW_ID and CELLSTYLE are ignored.
    l_remove_row = on.
    LOOP AT lt_col_fieldval ASSIGNING <ls_col_fieldval>.
      CHECK NOT <ls_col_fieldval>-fieldname = g_fieldname_row_id.
      CHECK NOT <ls_col_fieldval>-fieldname = g_fieldname_cellstyle.
      IF <ls_col_fieldval>-value <> <ls_col_fieldval>-initial_value OR
         <ls_col_fieldval>-object IS BOUND.
        l_remove_row = off.
        EXIT.
      ENDIF.
    ENDLOOP.
*   If one column is not empty we do not remove the row.
    CHECK l_remove_row = on.
*   The row is empty -> remove it.
    CALL METHOD remove_row
      EXPORTING
        i_row_fieldname = <ls_row_fieldval>-fieldname
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ENDLOOP.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_screen~destroy.

  DATA: l_rc  TYPE ish_method_rc.

  FIELD-SYMBOLS: <lt_outtab>  TYPE table.

* Clear self's instance attributes.
  CLEAR: gs_layout,
         gs_refresh_stable,
         gs_variant,
         gt_drop_down_alias,
         gt_excl_func,
         gt_f4,
         gt_fieldcat,
         gt_filter,
         gt_filter_tmp,
         gt_modified_cells,
         gt_sort,
         gt_sort_tmp,
         gt_toolbar_button,
         gt_toolbar_fvarp,
         g_allow_new_rows,
         g_appl_events,
         g_fieldcat_changed,
         g_fieldname_cellstyle,
         g_fieldname_filtermark,
         g_fieldname_is_changed,
         g_fieldname_is_empty,
         g_fieldname_is_new,
         g_fieldname_row_id,
         g_handle_after_refresh,
         g_handle_filter_is_changed,
         g_handle_filter_is_empty,
         g_handle_filter_is_new,
         g_min_rows,
         g_pai_code,
         g_refresh_soft,
         g_rows_to_append,
         g_set_filter_after_ucomm,
         g_set_sort_after_ucomm,
         g_sortorder_is_changed,
         g_sortorder_is_empty,
         g_sortorder_is_new,
         g_sort_set,
         g_toolbar_fvarid,
         g_toolbar_fvar_set,
         g_toolbar_viewtype,
         g_variant_save,
         g_variant_save_set,
         g_variant_set.
  IF gr_outtab IS BOUND.
    ASSIGN gr_outtab->* TO <lt_outtab>.
    IF sy-subrc = 0.
      CLEAR <lt_outtab>.
    ENDIF.
    CLEAR gr_outtab.
  ENDIF.

* Destroy the buttonhandler.
  IF gr_buttonhandler IS BOUND.
    CALL METHOD gr_buttonhandler->destroy.
    CLEAR gr_buttonhandler.
  ENDIF.

* Destroy the listboxhandler.
  IF gr_listboxhandler IS BOUND.
    CALL METHOD gr_listboxhandler->destroy.
    CLEAR gr_listboxhandler.
  ENDIF.

* Destroy the alv_grid.
  CALL METHOD destroy_grid
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Destroy the cellmerging handler
  IF gr_cellmerger IS BOUND.
    CALL METHOD gr_cellmerger->destroy.
    CLEAR gr_cellmerger.
  ENDIF.

* Destroy the selector handler
  IF gr_selector IS BOUND.
    CALL METHOD gr_selector->destroy.
    CLEAR gr_selector.
  ENDIF.

* Call super method.
  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~initialize.

* Initialize g_appl_events.
  CALL METHOD initialize_appl_events.

* Initialize the data reference to the outtab.
  CALL METHOD initialize_r_outtab.

* Initialize the fieldnames.
  CALL METHOD initialize_fieldnames.

* Initialize g_handle_filter_*.
  CALL METHOD initialize_handle_filter.

* Initialize g_sortorder_*.
  CALL METHOD initialize_sortorder.

* Initialize the button definitions.
  CALL METHOD initialize_buttondefs.

* Initialize the listbox definitions.
  CALL METHOD initialize_listboxdefs.

* Call super method.
  CALL METHOD super->if_ish_screen~initialize
    EXPORTING
      i_main_object      = i_main_object
      i_vcode            = i_vcode
      i_caller           = i_caller
      i_environment      = i_environment
      i_lock             = i_lock
      i_config           = i_config
      i_use_tndym_cursor = i_use_tndym_cursor
    IMPORTING
      e_rc               = e_rc
    CHANGING
      c_errorhandler     = c_errorhandler.

* Initialize the cellmerger
  CALL METHOD initialize_cell_merging.

* Initialize alternative selection
  CALL METHOD initialize_alt_selection.

ENDMETHOD.


METHOD if_ish_screen~modify_screen.

* There is no is-h screen modification for alv grids.
* Also we can not use the SCREEN-logic of the super class.

  DATA: lt_modified         TYPE ishmed_t_screen,
        ls_scrmod           TYPE screen,
        l_rc                TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fieldcat>  TYPE lvc_s_fcat,
                 <ls_modified>  TYPE rn1screen.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Let the configuration do screen modifications.
  IF NOT gr_config IS INITIAL.
    CALL METHOD gr_config->modify_screen
      EXPORTING
        ir_screen       = me
        i_vcode         = g_vcode
      IMPORTING
        et_modified     = lt_modified
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.

* Modify the field catalogue according to lt_modified.
  CALL METHOD modify_fieldcat
    EXPORTING
      it_modified     = lt_modified
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* Build the screen attribute table.
  CALL METHOD build_t_scrmod
    EXPORTING
      it_modified     = lt_modified
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* Call screen modification of each screen
  CALL METHOD modify_screen_internal
    EXPORTING
      it_modified     = lt_modified
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen.

* This method implements special handling for ok_codes which
* have been raised by our handle-methods (eg handle_user_command).

  DATA: l_ucomm           TYPE sy-ucomm,
        l_original_ucomm  TYPE sy-ucomm,
        l_ucomm_handled   TYPE ish_on_off.

* Process only if we have an ucomm.
  l_ucomm = c_okcode.
  IF l_ucomm IS INITIAL.
    l_ucomm = g_ucomm.
  ENDIF.
  CHECK NOT l_ucomm IS INITIAL.

* Handle system-event user commands.
  IF is_sysev_ucomm( l_ucomm ) = on.
*   Eliminate sysev from ucomm.
    CALL METHOD eliminate_sysev
      CHANGING
        c_ucomm = l_ucomm.
*   Raise ev_user_command.
    RAISE EVENT ev_user_command
      EXPORTING
        ir_screen = me
        i_ucomm   = l_ucomm.
  ENDIF.

* Set c_okcode.
  c_okcode = l_ucomm.

* Process only if the ucomm is supported by self.
  CHECK is_ucomm_supported( l_ucomm ) = on.

* Get the original ucomm.
  l_original_ucomm = get_original_ucomm( l_ucomm ).

* Now process the ucomm.
  CASE l_original_ucomm.
*   SystemEvent error.
    WHEN co_ucomm_sysev_error.
      CALL METHOD raise_ev_error
        EXPORTING
          ir_errorhandler = gr_sysev_errorhandler.
      l_ucomm_handled = on.
*   button_click
    WHEN co_ucomm_button_click.
      CALL METHOD process_button_click
        EXPORTING
          i_ucomm         = l_ucomm
        IMPORTING
          e_ucomm_handled = l_ucomm_handled
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
*   hotspot_click
    WHEN co_ucomm_hotspot_click.
      CALL METHOD process_hotspot_click
        EXPORTING
          i_ucomm         = l_ucomm
        IMPORTING
          e_ucomm_handled = l_ucomm_handled
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
*   double_click
    WHEN co_ucomm_double_click.
      CALL METHOD process_double_click
        EXPORTING
          i_ucomm         = l_ucomm
        IMPORTING
          e_ucomm_handled = l_ucomm_handled
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
*   normal user command
    WHEN OTHERS.
      CALL METHOD process_user_command
        EXPORTING
          i_ucomm         = l_ucomm
        IMPORTING
          e_ucomm_handled = l_ucomm_handled
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
  ENDCASE.

* If the user command was handled clear c_okcode.
  IF l_ucomm_handled = on.
    CLEAR c_okcode.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~process_after_input.

  DATA: l_rc    TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK NOT gr_alv_grid IS INITIAL.

* Fire event data_changed/_finished.
  gr_alv_grid->check_changed_data( ).

* No pai if we have bad cells.
  IF NOT gt_bad_cell IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* Remind the cursorfield.
  CALL METHOD remind_cursorfield.

* Transport outtab data to field values.
  CALL METHOD transport_from_dy
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* remind the marks if supplied
  IF g_remind_selected_rows = on.
    CALL METHOD remind_selected_rows
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~process_before_output.

  DATA: lr_alv_grid         TYPE REF TO cl_gui_alv_grid,
        l_fieldcat_changed  TYPE ish_on_off,
        l_layout_changed    TYPE ish_on_off,
        l_f4_changed        TYPE ish_on_off,
        l_excl_func_changed TYPE ish_on_off,
        l_variant_changed   TYPE ish_on_off,
        l_sort_changed      TYPE ish_on_off,
        l_filter_changed    TYPE ish_on_off,
        l_initialize_grid   TYPE ish_on_off,
        l_rc                TYPE ish_method_rc,
        l_tmp_refresh       TYPE ish_on_off.

  FIELD-SYMBOLS:  <lt_outtab> TYPE ANY.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  CLEAR lr_alv_grid.
  l_fieldcat_changed  = off.
  l_layout_changed    = off.
  l_variant_changed   = off.
  l_f4_changed        = off.
  l_excl_func_changed = off.
  l_initialize_grid   = off.

* No pbo if we have bad cells.
  IF NOT gt_bad_cell IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* Avoid pbo on context_menu.
  IF g_pai_code = 'CTX_MENU'.
    CLEAR g_pai_code.
    EXIT.
  ENDIF.

* Clear g_ucomm.
  CLEAR g_ucomm.

* Clear gt_modified_cells.
  CLEAR gt_modified_cells.

* Prepare for drag&drop.
  IF is_dragdrop_supported( ) = on.
    CALL METHOD prepare_for_drag_and_drop
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

* Build the alv_grid field catalogue.
  CALL METHOD build_grid_fieldcat
    IMPORTING
      e_fieldcat_changed = l_fieldcat_changed
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Build the alv_grid layout.
  CALL METHOD build_grid_layout
    IMPORTING
      e_layout_changed = l_layout_changed
      e_rc             = l_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Build the alv_grid F4.
  CALL METHOD build_grid_f4
    IMPORTING
      e_f4_changed    = l_f4_changed
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Build the alv_grid table with excluding functions.
  CALL METHOD build_grid_excl_func
    IMPORTING
      e_excl_func_changed = l_excl_func_changed
      e_rc                = l_rc
    CHANGING
      cr_errorhandler     = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Build the alv_grid variant.
  CALL METHOD build_grid_variant
    IMPORTING
      e_variant_changed = l_variant_changed
      e_rc              = l_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Build the alv_grid sort criteria.
  CALL METHOD build_grid_sort
    IMPORTING
      e_sort_changed  = l_sort_changed
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Build the alv_grid filter criteria.
  CALL METHOD build_grid_filter
    IMPORTING
      e_filter_changed = l_filter_changed
      e_rc             = l_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Build the refreshing info.
  CALL METHOD build_grid_refresh_info
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Transport the field values to the outtab.
  CALL METHOD transport_to_dy
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Fill labels (= column headers).
  CALL METHOD fill_all_labels
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Create all listboxes.
  CALL METHOD create_all_listboxes
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Modify screen (= Set tech+edit of the field catalogue).
* Table gt_scrmod is also handled in this method.
* Before calling modify_screen clear the field for fieldcat changes.
  g_fieldcat_changed = off.
  CALL METHOD modify_screen
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.
* Now set the flag for fieldcat changes.
  IF l_fieldcat_changed = off.
    l_fieldcat_changed = g_fieldcat_changed.
  ENDIF.

* No show the alv_grid.
* That means that either the alv_grid has to be
* (re-)initialized or it has to be refreshed.

* Determine if the alv_grid should be refreshed or initialized.
  l_initialize_grid = off.
  IF g_first_time        = on OR
     l_f4_changed        = on OR
     l_excl_func_changed = on.
    l_initialize_grid = on.
  ENDIF.

* Initialize/Refresh the alv_grid.
  IF l_initialize_grid = on.
*   Initialize the alv_grid.
    CALL METHOD initialize_grid
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ELSE.
*   Refresh the alv_grid.
*   Since the field catalogue and listboxes may have been changed in
*   fill_all_labels or modify_screen or create_all_listboxes
*   we have to refresh the field catalogue and the
*   drop down table every time.
    CALL METHOD refresh_grid
      EXPORTING
        i_refresh_drop_down_table = on
        i_refresh_fieldcat        = l_fieldcat_changed
        i_refresh_layout          = l_layout_changed
        i_refresh_variant         = l_variant_changed
        i_refresh_sort            = l_sort_changed
        i_refresh_filter          = l_filter_changed
      IMPORTING
        e_rc                      = l_rc
      CHANGING
        cr_errorhandler           = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   check if cellmerging is active and modify
*   the outtab if necessary
    l_tmp_refresh = off.
    IF is_cellmerging_active( ) = on.
      ASSIGN gr_outtab->* TO <lt_outtab>.
      CALL METHOD gr_cellmerger->do_cell_merging
        EXPORTING
          it_fieldcat     = gt_fieldcat
        IMPORTING
          e_rc            = l_rc
        CHANGING
          ct_outtab       = <lt_outtab>
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      l_tmp_refresh = on.
    ENDIF.
  ENDIF.

* mark the reminded rows if supplied
  IF g_remind_selected_rows = on.
    IF is_alt_selection_active( ) = on.
*     alternative selection is active
      CALL METHOD set_alt_selected_rows
        IMPORTING
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      l_tmp_refresh = on.
    ELSE.
*     normal selection
      CALL METHOD set_selected_rows
        IMPORTING
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.

* after cellmerging refresh the grid
  IF l_tmp_refresh = on.
    CALL METHOD refresh_grid
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.

* Set cursor.
  CALL METHOD set_cursor
    EXPORTING
      i_set_cursor   = on
    IMPORTING
      e_rc           = l_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Process before output finished.
  CALL METHOD set_first_time
    EXPORTING
      i_first_time = off.

* Set old field values (for "check_changes")
  CALL METHOD set_fields_old
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~remind_cursorfield.

  DATA: ls_row_fieldval   TYPE rnfield_value,
        ls_col_fieldval   TYPE rnfield_value,
        ls_row_id         TYPE lvc_s_row,
        ls_col_info       TYPE lvc_s_col,
        l_row             TYPE i,
        ls_col_id         TYPE lvc_s_col,
        l_rc              TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fieldcat>  TYPE lvc_s_fcat.

* Clear g_scr_cursorfield.
  CLEAR g_scr_cursorfield.

* Initial checking.
  CHECK g_remind_cursorfield = on.  " Yes we have to remind

* Now we have to clear g_remind_cursorfield.
  g_remind_cursorfield = off.

* Get the current cell fieldval.
  CALL METHOD get_current_cell_fieldval
    IMPORTING
      es_row_fieldval = ls_row_fieldval
      es_col_fieldval = ls_col_fieldval
      e_rc            = l_rc.
  IF l_rc <> 0.
    CLEAR: ls_row_fieldval,
           ls_col_fieldval.
  ENDIF.

* If we do not already have a fieldval for the current cell
* we get the fieldnames from the outtab.
  IF ls_row_fieldval-fieldname IS INITIAL OR
     ls_col_fieldval-fieldname IS INITIAL.
    IF gr_alv_grid IS BOUND.
      CALL METHOD gr_alv_grid->get_current_cell
        IMPORTING
          es_row_id = ls_row_id
          es_col_id = ls_col_id.
      l_row = ls_row_id-index.
      CALL METHOD get_row_fieldname_by_index
        EXPORTING
          i_row           = l_row
        IMPORTING
          e_row_fieldname = ls_row_fieldval-fieldname.
      ls_col_fieldval-fieldname = ls_col_id-fieldname.
      IF ls_col_fieldval-fieldname IS INITIAL.
*       use current position of grid
        CALL METHOD gr_alv_grid->get_scroll_info_via_id
          IMPORTING
            es_col_info = ls_col_info.
        ls_col_fieldval-fieldname = ls_col_info-fieldname.
        IF ls_col_fieldval-fieldname IS INITIAL.
          LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
            CHECK <ls_fieldcat>-tech   = off.
            CHECK <ls_fieldcat>-no_out = off.
            ls_col_fieldval-fieldname = <ls_fieldcat>-fieldname.
            EXIT.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

* Set g_scr_cursorfield.
  CONCATENATE ls_row_fieldval-fieldname
              '-'
              ls_col_fieldval-fieldname
         INTO g_scr_cursorfield.

ENDMETHOD.


METHOD if_ish_screen~transport_from_dy.

* The super method can not be used when working with alv_grids.
* In this redefinition we transport the data of the outtab to
* the field values.

  DATA: ls_row_fieldval      TYPE rnfield_value,
        lt_row_fieldval_new  TYPE ish_t_field_value,
        l_row_id_failure     TYPE ish_on_off,
        l_row_fieldname      TYPE ish_fieldname,
        l_rc                 TYPE ish_method_rc.

  FIELD-SYMBOLS: <lt_outtab>        TYPE table,
                 <ls_outtab>        TYPE ANY,
                 <l_row_id>         TYPE ANY.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Processing can only be done if there is already an alv_grid
* and gr_outtab is available.
  CHECK NOT gr_alv_grid IS INITIAL.
  CHECK gr_outtab IS BOUND.

* Processing can only be done if we have the fieldname of the row_id.
  CHECK NOT g_fieldname_row_id IS INITIAL.

* Assign the outtab.
  ASSIGN gr_outtab->* TO <lt_outtab>.

* Process each row.
  LOOP AT <lt_outtab> ASSIGNING <ls_outtab>.

*   Get the row_fieldname from the outtab entry.
    ASSIGN COMPONENT g_fieldname_row_id
      OF STRUCTURE <ls_outtab>
      TO <l_row_id>.
    IF sy-subrc <> 0.
      l_row_id_failure = on.
      EXIT.
    ENDIF.
    l_row_fieldname = <l_row_id>.

*   Get the corresponding row fieldval.
    CALL METHOD get_row_fieldval
      EXPORTING
        i_row_fieldname = l_row_fieldname
      IMPORTING
        es_row_fieldval = ls_row_fieldval
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.

*   If the corresponding row field value does not already exist
*   we create a new one, but only if the outtab is not empty.
    IF ls_row_fieldval IS INITIAL.
      CHECK NOT <ls_outtab> IS INITIAL.
      CALL METHOD create_empty_row
        IMPORTING
          es_row_fieldval = ls_row_fieldval
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        CONTINUE.
      ENDIF.
*     We also have to actualize the row_id in the outtab entry.
      <l_row_id> = ls_row_fieldval-fieldname.
    ENDIF.

    CHECK NOT ls_row_fieldval IS INITIAL.

*   Transport the row.
    CALL METHOD transport_row_from_outtab
      EXPORTING
        is_outtab       = <ls_outtab>
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cs_fieldval_row = ls_row_fieldval
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.

*   Build the new field values.
    APPEND ls_row_fieldval TO lt_row_fieldval_new.

  ENDLOOP.

* Leave on errors.
  CHECK e_rc = 0.

* Leave if the row_id could not be assigned.
  CHECK l_row_id_failure = off.

* Remove all old field values.
  CALL METHOD gr_screen_values->initialize
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Set the new field values.
  CALL METHOD set_fields
    EXPORTING
      i_conv_to_intern = on
      it_field_values  = lt_row_fieldval_new
      i_field_values_x = on
    IMPORTING
      e_rc             = l_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy.

* The super method can not be used when working with alv_grids.
* In this redefinition we transport the data of the field values
* to the outtab.

  DATA: lt_row_fieldval       TYPE ish_t_field_value,
        l_outtab_found        TYPE ish_on_off,
        lr_outtab_entry       TYPE REF TO data,
        l_rc                  TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_row_fieldval>  TYPE rnfield_value,
                 <lt_outtab>        TYPE table,
                 <ls_outtab>        TYPE ANY,
                 <l_row_id>         TYPE ANY.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Processing can only be done if the outtab is available.
  CHECK gr_outtab IS BOUND.

* Processing can only be done if the row_id is available.
  CHECK NOT g_fieldname_row_id IS INITIAL.

* Assign the outtab.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  CHECK sy-subrc = 0.

* Complete field values (set initial values).
  CALL METHOD me->complete_field_values
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get the row fieldvals.
  CALL METHOD get_row_fieldvals
    IMPORTING
      et_row_fieldval = lt_row_fieldval
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* Process each row.
  LOOP AT lt_row_fieldval ASSIGNING <ls_row_fieldval>.

*   Get the corresponding outtab-entry.
    l_outtab_found = on.
    READ TABLE <lt_outtab>
      ASSIGNING <ls_outtab>
      WITH KEY (g_fieldname_row_id) = <ls_row_fieldval>-fieldname.
    IF sy-subrc <> 0.
      l_outtab_found = off.
    ENDIF.

*   If the corresponding outtab entry does not already exist
*   we create a new one.
    IF l_outtab_found = off.
*     Get a new empty outtab entry.
      CALL METHOD create_empty_outtab_entry
        IMPORTING
          er_outtab_entry = lr_outtab_entry
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        CONTINUE.
      ENDIF.
      CHECK lr_outtab_entry IS BOUND.
      ASSIGN lr_outtab_entry->* TO <ls_outtab>.
      CHECK sy-subrc = 0.
    ENDIF.

*   Transport the row.
    CALL METHOD transport_row_to_outtab
      EXPORTING
        is_fieldval_row = <ls_row_fieldval>
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cs_outtab       = <ls_outtab>
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.

*   Append the new outtab entry to the outtab.
    IF l_outtab_found = off.
      APPEND <ls_outtab> TO <lt_outtab>.
    ENDIF.

  ENDLOOP.

* Remove outtab entries which have no corresponding row field value.
  LOOP AT <lt_outtab> ASSIGNING <ls_outtab>.
    ASSIGN COMPONENT g_fieldname_row_id
      OF STRUCTURE <ls_outtab>
      TO <l_row_id>.
    CHECK sy-subrc = 0.
    READ TABLE lt_row_fieldval
      WITH KEY fieldname = <l_row_id>
      TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      DELETE <lt_outtab>.
    ENDIF.
  ENDLOOP.

* Now finalize the outtab.
  CALL METHOD finalize_outtab
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~append_row.

  DATA: ls_row_fieldval  TYPE rnfield_value,
        lt_col_fieldval  TYPE ish_t_field_value,
        lr_row_fieldval  TYPE REF TO cl_ish_field_values.

  FIELD-SYMBOLS: <ls_col_fieldval>  TYPE rnfield_value,
                 <ls_col_fv>        TYPE rnfield_value.

* Initializations.
  e_rc = 0.
  CLEAR: es_row_fieldval,
         et_col_fieldval.

  CHECK NOT gr_screen_values IS INITIAL.

* Create an empty row fieldval.
  CALL METHOD create_empty_row
    EXPORTING                                         " AE, 29.09.2004
      i_row_fieldname = i_row_fieldname               " AE, 29.09.2004
    IMPORTING
      es_row_fieldval = ls_row_fieldval
      et_col_fieldval = lt_col_fieldval
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK NOT ls_row_fieldval        IS INITIAL.
  CHECK NOT ls_row_fieldval-object IS INITIAL.
  CHECK NOT lt_col_fieldval        IS INITIAL.

  lr_row_fieldval ?= ls_row_fieldval-object.

* Handle it_col_fieldval.
  LOOP AT it_col_fieldval ASSIGNING <ls_col_fv>.
*   Get the corresponding col fieldval.
    READ TABLE lt_col_fieldval
      ASSIGNING <ls_col_fieldval>
      WITH KEY fieldname = <ls_col_fv>-fieldname.
    CHECK sy-subrc = 0.
*   Take over the col fieldval.
    <ls_col_fieldval>-value  = <ls_col_fv>-value.
    <ls_col_fieldval>-object = <ls_col_fv>-object.
  ENDLOOP.

* Actualize the column fieldvals of the row.
  CALL METHOD lr_row_fieldval->set_data
    EXPORTING
      it_field_values = lt_col_fieldval
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Append the row fieldval to the screen values.
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      i_field_value  = ls_row_fieldval
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  IF es_row_fieldval IS SUPPLIED.
    es_row_fieldval = ls_row_fieldval.
  ENDIF.
  IF et_col_fieldval IS SUPPLIED.
    et_col_fieldval = lt_col_fieldval.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~build_ucomm_row_col.

  DATA: l_ucomm          TYPE sy-ucomm.

* Initializations.
  CLEAR e_ucomm.

* CHECK NOT l_ucomm IS INITIAL.
  CHECK NOT i_original_ucomm IS INITIAL.

  l_ucomm = i_original_ucomm.

* Add the control id.
  CALL METHOD build_ucomm
    CHANGING
      c_ucomm = l_ucomm.

* Add the row and column fieldname.
  CONCATENATE l_ucomm
              i_row_fieldname
              i_col_fieldname
         INTO e_ucomm
    SEPARATED BY '.'.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~delect_row.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  DATA:          l_idx     TYPE sy-index.
  FIELD-SYMBOLS: <l_row>   TYPE ish_fieldname.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  LOOP AT gt_selected_rows ASSIGNING <l_row>.
    IF <l_row> = i_row_fieldname.
      l_idx = sy-tabix.
      EXIT.
    ENDIF.
  ENDLOOP.
  DELETE gt_selected_rows INDEX l_idx.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD if_ish_scr_alv_grid~delect_rows.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  DATA:           l_rc       TYPE ish_method_rc.
  FIELD-SYMBOLS:  <l_row>    TYPE ish_fieldname.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  LOOP AT it_row_fieldname ASSIGNING <l_row>.
    CALL METHOD if_ish_scr_alv_grid~delect_row
      EXPORTING
        i_row_fieldname = <l_row>
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDLOOP.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD if_ish_scr_alv_grid~disable_cell.

  DATA: lr_fv_row  TYPE REF TO cl_ish_field_values,
        l_rc       TYPE ish_method_rc.

* Initializations.
  r_disabled = off.

* Get the corresponding row fieldval object.
  CALL METHOD get_row_fieldval_object
    EXPORTING
      i_row_fieldname = i_row_fieldname
      i_only_modified = off
    IMPORTING
      er_row_fieldval = lr_fv_row
      e_rc            = l_rc.
  CHECK l_rc = 0.
  CHECK lr_fv_row IS BOUND.

** Get the disabled attribute from the row fieldval object.
*  r_disabled = lr_fv_row->get_attr_disabled( i_col_fieldname ).

* Set the disabled attribute from the row fieldval object.
  CALL METHOD lr_fv_row->set_attr_disabled
    EXPORTING
      i_fieldname = i_col_fieldname
      i_disabled  = on
    RECEIVING
      r_attr_set  = r_disabled.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~disable_row.

* Initializations.
  r_disabled = off.

* Initial checking.
  CHECK gr_screen_values IS BOUND.

** Get the disabled attribute from the screen values.
*  r_disabled = gr_screen_values->get_attr_disabled( i_row_fieldname ).

* Set the disabled attribute from the screen values.
  CALL METHOD gr_screen_values->set_attr_disabled
    EXPORTING
      i_fieldname = i_row_fieldname
      i_disabled  = on
    RECEIVING
      r_attr_set  = r_disabled.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~enable_cell.

  DATA: lr_fv_row  TYPE REF TO cl_ish_field_values,
        l_rc       TYPE ish_method_rc.

* Initializations.
  r_enabled = on.

* Get the corresponding row fieldval object.
  CALL METHOD get_row_fieldval_object
    EXPORTING
      i_row_fieldname = i_row_fieldname
      i_only_modified = off
    IMPORTING
      er_row_fieldval = lr_fv_row
      e_rc            = l_rc.
  CHECK l_rc = 0.
  CHECK lr_fv_row IS BOUND.

** Get the disabled attribute from the row fieldval object.
*  IF lr_fv_row->get_attr_disabled( i_col_fieldname ) = on.
*    r_enabled = off.
*  ENDIF.

* Set the disabled attribute from the row fieldval object.
  CALL METHOD lr_fv_row->set_attr_disabled
    EXPORTING
      i_fieldname = i_col_fieldname
      i_disabled  = off
    RECEIVING
      r_attr_set  = r_enabled.
  IF r_enabled = on.
    r_enabled = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~enable_row.

* Initializations.
  r_enabled = on.

* Initial checking.
  CHECK gr_screen_values IS BOUND.

** Get the disabled attribute from the screen values.
*  IF gr_screen_values->get_attr_disabled( i_row_fieldname ) = on.
*    r_enabled = off.
*  ENDIF.

* Set the disabled attribute from the screen values.
  CALL METHOD gr_screen_values->set_attr_disabled
    EXPORTING
      i_fieldname = i_row_fieldname
      i_disabled  = off
    RECEIVING
      r_attr_set  = r_enabled.
  IF r_enabled = on.
    r_enabled = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_allow_new_rows.

  r_allow_new_rows = g_allow_new_rows.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_alv_grid.

  DATA: lr_container  TYPE REF TO cl_gui_container,
        lr_alv_grid   TYPE REF TO cl_gui_alv_grid.

* Initializations.
  CLEAR: e_rc,
         er_alv_grid.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Already loaded?
  er_alv_grid = gr_alv_grid.
  CHECK er_alv_grid IS INITIAL.

* Not already loaded ->
*   -> instantiate the alv_grid,
*      but only if the user specified.

  CHECK i_create = on.

* Get the container.
  CALL METHOD get_container
    IMPORTING
      er_container    = lr_container
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_container IS INITIAL.

* Create the alv_grid object.
  CREATE OBJECT lr_alv_grid TYPE cl_ish_gui_alv_grid
    EXPORTING
      i_parent          = lr_container
      i_appl_events     = g_appl_events
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.
  e_rc = sy-subrc.
  IF e_rc <> 0.
*     Fehler & beim Anlegen des Controls & (Klasse &)
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_ALV_GRID'
        i_mv3           = 'CL_ISH_SCR_ALV_GRID'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Remember the alv_grid object.
  gr_alv_grid = lr_alv_grid.

* Export.
  er_alv_grid = gr_alv_grid.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_cell_fieldval.

  DATA: ls_row_fieldval  TYPE rnfield_value,
        lr_row_fieldval  TYPE REF TO cl_ish_field_values,
        ls_col_fieldval  TYPE rnfield_value,
        l_row            TYPE i.

* Initializations.
  e_rc = 0.
  CLEAR: es_row_fieldval,
         es_col_fieldval.

* Get the row fieldval.
  CALL METHOD get_row_fieldval
    EXPORTING
      i_row_fieldname = i_row_fieldname
    IMPORTING
      es_row_fieldval = ls_row_fieldval
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT ls_row_fieldval IS INITIAL.

* Get the row fieldval object.
  CHECK NOT ls_row_fieldval-object IS INITIAL.
  lr_row_fieldval ?= ls_row_fieldval-object.

* Get the cell field value.
  CALL METHOD lr_row_fieldval->get_data
    EXPORTING
      i_fieldname    = i_col_fieldname
    IMPORTING
      e_field_value  = ls_col_fieldval
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT ls_col_fieldval IS INITIAL.

* Handle i_only_modified.
  IF i_only_modified = on.
    CALL METHOD get_row_index_by_fieldname
      EXPORTING
        i_row_fieldname = ls_row_fieldval-fieldname
      IMPORTING
        e_row           = l_row
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    READ TABLE gt_modified_cells
      WITH KEY row_id    = l_row
               fieldname = i_col_fieldname
      TRANSPORTING NO FIELDS.
    CHECK sy-subrc = 0.
  ENDIF.

* Export.
  es_row_fieldval = ls_row_fieldval.
  es_col_fieldval = ls_col_fieldval.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_column_fieldvals.

  DATA: ls_row_fieldval  TYPE rnfield_value,
        lr_row_fieldval  TYPE REF TO cl_ish_field_values,
        lt_col_fieldval  TYPE ish_t_field_value,
        ls_col_fieldval  TYPE rnfield_value,
        lt_col_fieldname TYPE ish_t_fieldname,
        l_fieldname      TYPE ish_fieldname,
        l_row            TYPE i.

  FIELD-SYMBOLS: <l_col_fieldname>  TYPE ish_fieldname,
                 <ls_modi>          TYPE lvc_s_modi.

* Initializations.
  e_rc = 0.
  CLEAR: es_row_fieldval,
         et_col_fieldval.

* Get the row fieldval.
  CALL METHOD get_row_fieldval
    EXPORTING
      i_row_fieldname = i_row_fieldname
      i_only_modified = i_only_modified
    IMPORTING
      es_row_fieldval = ls_row_fieldval
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT ls_row_fieldval IS INITIAL.

* Get the row fieldval object.
  CHECK NOT ls_row_fieldval-object IS INITIAL.
  lr_row_fieldval ?= ls_row_fieldval-object.

* Build lt_col_fieldname depending on it_col_fieldname
* and i_only_modified.
  IF i_only_modified = off.
    lt_col_fieldname = it_col_fieldname.
  ELSE.
    CALL METHOD get_row_index_by_fieldname
      EXPORTING
        i_row_fieldname = ls_row_fieldval-fieldname
      IMPORTING
        e_row           = l_row
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    LOOP AT gt_modified_cells
            ASSIGNING <ls_modi>
            WHERE row_id = l_row.
      IF NOT it_col_fieldname IS INITIAL.
        l_fieldname = <ls_modi>-fieldname.
        READ TABLE it_col_fieldname
          FROM l_fieldname
          TRANSPORTING NO FIELDS.
        CHECK sy-subrc = 0.
      ENDIF.
      APPEND <ls_modi>-fieldname TO lt_col_fieldname.
    ENDLOOP.
  ENDIF.

* Get the column field values.
  IF lt_col_fieldname IS INITIAL.
*   Return all columns.
    CALL METHOD lr_row_fieldval->get_data
      IMPORTING
        et_field_values = lt_col_fieldval
        e_rc            = e_rc
      CHANGING
        c_errorhandler  = cr_errorhandler.
    CHECK e_rc = 0.
  ELSE.
*   Return only the specified columns.
    LOOP AT lt_col_fieldname ASSIGNING <l_col_fieldname>.
      CALL METHOD lr_row_fieldval->get_data
        EXPORTING
          i_fieldname    = <l_col_fieldname>
        IMPORTING
          e_field_value  = ls_col_fieldval
          e_rc           = e_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
      APPEND ls_col_fieldval TO lt_col_fieldval.
    ENDLOOP.
    CHECK e_rc = 0.
  ENDIF.

* Export.
  es_row_fieldval = ls_row_fieldval.
  et_col_fieldval = lt_col_fieldval.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_config_alv_grid.

  DATA: lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid.

* Initializations.
  e_rc = 0.
  CLEAR er_config_alv_grid.

* Get the alv_grid config from the main config.
  CHECK NOT gr_config IS INITIAL.
  CALL METHOD gr_config->get_config_alv_grid
    EXPORTING
      ir_scr_alv_grid    = me
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  er_config_alv_grid = lr_config_alv_grid.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_current_cell_fieldval.

  DATA: lr_alv_grid      TYPE REF TO cl_gui_alv_grid,
        ls_row_id        TYPE lvc_s_row,
        l_row            TYPE i,
        ls_col_id        TYPE lvc_s_col,
        l_row_fieldname  TYPE ish_fieldname,
        l_col_fieldname  TYPE ish_fieldname,
        ls_row_fieldval  TYPE rnfield_value,
        ls_col_fieldval  TYPE rnfield_value.

* Initializations.
  e_rc = 0.
  CLEAR: es_row_fieldval,
         es_col_fieldval.

* Get the alv_grid.
  CALL METHOD get_alv_grid
    IMPORTING
      er_alv_grid     = lr_alv_grid
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_alv_grid IS INITIAL.

* Get the current cell.
  CALL METHOD lr_alv_grid->get_current_cell
    IMPORTING
      es_row_id = ls_row_id
      es_col_id = ls_col_id.

* Get the corresponding row_id from the outtab.
  l_row = ls_row_id-index.
  CALL METHOD get_row_fieldname_by_index
    EXPORTING
      i_row           = l_row
    IMPORTING
      e_row_fieldname = l_row_fieldname
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* If the row fieldval does not already exist we have to create it.
  IF l_row_fieldname IS INITIAL.
    CALL METHOD append_row
      IMPORTING
        es_row_fieldval = ls_row_fieldval
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    l_row_fieldname = ls_row_fieldval-fieldname.
  ENDIF.

* Get the corresponding cell field value.
  l_col_fieldname = ls_col_id-fieldname.
  CALL METHOD get_cell_fieldval
    EXPORTING
      i_row_fieldname = l_row_fieldname
      i_col_fieldname = l_col_fieldname
    IMPORTING
      es_row_fieldval = ls_row_fieldval
      es_col_fieldval = ls_col_fieldval
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  es_row_fieldval = ls_row_fieldval.
  es_col_fieldval = ls_col_fieldval.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_fieldcat.

  DATA: l_rc      TYPE ish_method_rc,
        lr_err    TYPE REF TO cl_ishmed_errorhandling.

* initialize
  l_rc = 0.

* build fieldcat if necessary
  IF gt_fieldcat IS INITIAL AND
     i_build     =  on.
    CALL METHOD me->build_grid_fieldcat
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_err.
  ENDIF.

* return fieldcat
  CHECK l_rc = 0.
  rt_fieldcat = gt_fieldcat.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_filter.

  rt_filter = gt_filter.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_layout.

  rs_layout = gs_layout.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_remind_selected_rows.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  i_remind_sel = g_remind_selected_rows.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_row_fieldval.

  DATA: ls_row_fieldval  TYPE rnfield_value,
        l_row            TYPE i.

* Initializations.
  e_rc = 0.
  CLEAR es_row_fieldval.

  CHECK NOT gr_screen_values IS INITIAL.

* Get the corresponding row field value.
  CALL METHOD gr_screen_values->get_data
    EXPORTING
      i_fieldname    = i_row_fieldname
      i_type         = co_fvtype_fv
    IMPORTING
      e_field_value  = ls_row_fieldval
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Handle i_only_modified.
  IF i_only_modified = on.
    CALL METHOD get_row_index_by_fieldname
      EXPORTING
        i_row_fieldname = ls_row_fieldval-fieldname
      IMPORTING
        e_row           = l_row
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    READ TABLE gt_modified_cells
      WITH KEY row_id = l_row
      TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      CLEAR ls_row_fieldval.
    ENDIF.
  ENDIF.

* Export.
  es_row_fieldval = ls_row_fieldval.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_row_fieldvals.

  DATA: lt_row_fieldval  TYPE ish_t_field_value,
        ls_row_fieldval  TYPE rnfield_value,
        l_row_fieldname  TYPE ish_fieldname,
        lt_row_fieldname TYPE ish_t_fieldname.

  FIELD-SYMBOLS: <l_row_fieldname>  TYPE ish_fieldname,
                 <ls_modi>          TYPE lvc_s_modi.

* Initializations.
  e_rc = 0.
  CLEAR et_row_fieldval.

  CHECK NOT gr_screen_values IS INITIAL.

* Build lt_row_fieldname depending on it_row_fieldname
* and i_only_modified.
  IF i_only_modified = off.
*   Even unmodified rows should be returned.
*   So just take over it_row_fieldname.
    lt_row_fieldname = it_row_fieldname.
  ELSE.
*   Only modified rows should be returned.
    LOOP AT gt_modified_cells ASSIGNING <ls_modi>.
*     Get the row fieldname.
      CALL METHOD get_row_fieldname_by_index
        EXPORTING
          i_row           = <ls_modi>-row_id
        IMPORTING
          e_row_fieldname = l_row_fieldname
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
*     Take care of it_row_fieldname.
*     Only modified rows which are in it_row_fieldname
*     should be returned.
      IF NOT it_row_fieldname IS INITIAL.
        READ TABLE it_row_fieldname
          FROM l_row_fieldname
          TRANSPORTING NO FIELDS.
        CHECK sy-subrc = 0.
      ENDIF.
      APPEND l_row_fieldname TO lt_row_fieldname.
    ENDLOOP.
    CHECK e_rc = 0.
*   No modified rows -> return.
*    CHECK NOT lt_row_fieldname IS INITIAL.    "MED-50442
  ENDIF.

  IF lt_row_fieldname IS INITIAL.
*   Get all row fieldvals.
    CALL METHOD gr_screen_values->get_data
      IMPORTING
        et_field_values = lt_row_fieldval
        e_rc            = e_rc
      CHANGING
        c_errorhandler  = cr_errorhandler.
    CHECK e_rc = 0.
  ELSE.
*   Get the specified row fieldvals.
*   First delet duplicate lt_row_fieldname entries.
    SORT lt_row_fieldname.
    DELETE ADJACENT DUPLICATES FROM lt_row_fieldname.
    LOOP AT lt_row_fieldname ASSIGNING <l_row_fieldname>.
*     Get the row fieldval.
      CALL METHOD get_row_fieldval
        EXPORTING
          i_row_fieldname = <l_row_fieldname>
        IMPORTING
          es_row_fieldval = ls_row_fieldval
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
*     Append the row fieldval.
      APPEND ls_row_fieldval TO lt_row_fieldval.
    ENDLOOP.
  ENDIF.

* Export.
  et_row_fieldval = lt_row_fieldval.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_row_fieldval_object .

  DATA: ls_row_fieldval  TYPE rnfield_value.

* Initializations.
  e_rc = 0.
  CLEAR er_row_fieldval.

* Get the row field value.
  CALL METHOD get_row_fieldval
    EXPORTING
      i_row_fieldname = i_row_fieldname
      i_only_modified = i_only_modified
    IMPORTING
      es_row_fieldval = ls_row_fieldval
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  CHECK ls_row_fieldval-type = co_fvtype_fv.
  CHECK NOT ls_row_fieldval-object IS INITIAL.

* Export.
  er_row_fieldval ?= ls_row_fieldval-object.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_row_fieldval_objects.

  DATA: lt_row_fieldval  TYPE ish_t_field_value,
        lr_row_fieldval  TYPE REF TO cl_ish_field_values.

  FIELD-SYMBOLS: <ls_row_fieldval>  TYPE rnfield_value.

* Initializations.
  e_rc = 0.
  CLEAR et_row_fieldval_object.

* Get the row fieldvals.
  CALL METHOD get_row_fieldvals
    EXPORTING
      it_row_fieldname = it_row_fieldname
      i_only_modified  = i_only_modified
    IMPORTING
      et_row_fieldval  = lt_row_fieldval
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Build et_row_fieldval_object.
  LOOP AT lt_row_fieldval ASSIGNING <ls_row_fieldval>.
    CHECK NOT <ls_row_fieldval>-object IS INITIAL.
    lr_row_fieldval ?= <ls_row_fieldval>-object.
    APPEND lr_row_fieldval TO et_row_fieldval_object.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_selected_row_fieldval.

  DATA: lt_row_fieldval  TYPE ish_t_field_value,
        l_count_selrows  TYPE i.

  FIELD-SYMBOLS: <lt_outtab> TYPE STANDARD TABLE.

* Initializations.
  e_rc = 0.
  CLEAR: es_row_fieldval.
  ASSIGN gr_outtab->* TO <lt_outtab>.

* check if alternative selection is active
  IF is_alt_selection_active( ) = on.
    CALL METHOD gr_selector->get_selected_rows
      EXPORTING
        it_outtab       = <lt_outtab>
      IMPORTING
        e_rc            = e_rc
        et_sel          = lt_row_fieldval
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ELSE.
* Get the selected row fieldvals.
    CALL METHOD get_selected_row_fieldvals
      EXPORTING
        i_msgty_on_false_selection = space
        i_rc_on_false_selection    = 0
      IMPORTING
        et_row_fieldval            = lt_row_fieldval
        e_rc                       = e_rc
      CHANGING
        cr_errorhandler            = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.
* Handle I_*_ON_FALSE_SELECTION.
  DESCRIBE TABLE lt_row_fieldval LINES l_count_selrows.
  IF l_count_selrows <> 1 AND
     NOT i_msgty_on_false_selection = space.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = i_msgty_on_false_selection
        i_kla           = 'N1BASE'
        i_num           = '031'
        ir_object       = me
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = i_rc_on_false_selection.
    EXIT.
  ENDIF.

* Export.
  READ TABLE lt_row_fieldval INTO es_row_fieldval INDEX 1.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_selected_row_fieldvals.

  DATA: lr_alv_grid      TYPE REF TO cl_gui_alv_grid,
        lt_row_id        TYPE lvc_t_row,
        l_row            TYPE i,
        l_row_fieldname  TYPE ish_fieldname,
        ls_row_fieldval  TYPE rnfield_value,
        lt_row_fieldval  TYPE ish_t_field_value.

  FIELD-SYMBOLS: <ls_row_id>  TYPE lvc_s_row,
                 <lt_outtab>  TYPE STANDARD TABLE.

* Initializations.
  e_rc = 0.
  CLEAR: et_row_fieldval.

* Get the alv_grid.
  CALL METHOD get_alv_grid
    IMPORTING
      er_alv_grid     = lr_alv_grid
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_alv_grid IS INITIAL.

* check if alternative selection is active
  IF is_alt_selection_active( ) = on.
    ASSIGN gr_outtab->* TO <lt_outtab>.
    CALL METHOD gr_selector->get_selected_rows
      EXPORTING
        it_outtab       = <lt_outtab>
      IMPORTING
        e_rc            = e_rc
        et_index_rows   = lt_row_id
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ELSE.
*   Get the selected rows.
    CALL METHOD lr_alv_grid->get_selected_rows
      IMPORTING
        et_index_rows = lt_row_id.
  ENDIF.

* Get the corresponding row fieldvals.
  LOOP AT lt_row_id ASSIGNING <ls_row_id>.
*   Get the corresponding row_id from the outtab.
    l_row = <ls_row_id>-index.
    CALL METHOD get_row_fieldname_by_index
      EXPORTING
        i_row           = l_row
      IMPORTING
        e_row_fieldname = l_row_fieldname
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    IF l_row_fieldname IS INITIAL.
*     If the row fieldval does not already exist we have to create it.
      CALL METHOD append_row
        IMPORTING
          es_row_fieldval = ls_row_fieldval
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
      l_row_fieldname = ls_row_fieldval-fieldname.
    ELSE.
*     If the row fieldval does already exist we get it.
      CALL METHOD get_row_fieldval
        EXPORTING
          i_row_fieldname = l_row_fieldname
        IMPORTING
          es_row_fieldval = ls_row_fieldval
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
*   Append the row fieldval.
    APPEND ls_row_fieldval TO lt_row_fieldval.
  ENDLOOP.

* Handle I_*_ON_FALSE_SELECTION.
  IF lt_row_fieldval IS INITIAL AND
     NOT i_msgty_on_false_selection = space.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = i_msgty_on_false_selection
        i_kla           = 'N1BASE'
        i_num           = '032'
        ir_object       = me
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = i_rc_on_false_selection.
    EXIT.
  ENDIF.

* Export.
  et_row_fieldval = lt_row_fieldval.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_sort.

  rt_sort = gt_sort.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_toolbar_functions.

  DATA: lt_fvar   TYPE TABLE OF v_nwfvar,
        l_rc      TYPE ish_method_rc.

* Initializations.
  et_button = gt_toolbar_button.
  et_fvarp  = gt_toolbar_fvarp.

* If already loaded we are ready.
  CHECK gt_toolbar_button IS INITIAL.

* Initial checking.
  CHECK NOT g_toolbar_viewtype IS INITIAL.
  CHECK NOT g_toolbar_fvarid   IS INITIAL.

* Load the toolbar functions.
  CALL FUNCTION 'ISHMED_VM_FVAR_GET'
    EXPORTING
      i_viewtype       = g_toolbar_viewtype
      i_fvariantid     = g_toolbar_fvarid
      i_fill_txt_langu = off
    IMPORTING
      e_rc             = l_rc
    TABLES
      t_fvar           = lt_fvar
      t_fvarp          = gt_toolbar_fvarp
      t_button         = gt_toolbar_button.
  IF l_rc <> 0.
    CLEAR: gt_toolbar_button,
           gt_toolbar_fvarp.
  ENDIF.

* Export.
  et_button = gt_toolbar_button.
  et_fvarp  = gt_toolbar_fvarp.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_toolbar_fvar.

  e_viewtype = g_toolbar_viewtype.
  e_fvarid   = g_toolbar_fvarid.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_ucomm_col.

  DATA: l_original_ucomm  TYPE sy-ucomm,
        l_cntl_id         TYPE n_numc5,
        l_row_fieldname   TYPE ish_fieldname,
        l_rest            TYPE string.

* Initializations.
  CLEAR r_col_fieldname.

* Process only if the ucomm is supported by self.
  CHECK is_ucomm_supported( i_ucomm ) = on.

* Split the ucomm in its parts:
*   - original ucomm
*   - control id
*   - row fieldname
*   - column fieldname
*   - rest
  SPLIT i_ucomm
      AT '.'
    INTO l_original_ucomm
         l_cntl_id
         l_row_fieldname
         r_col_fieldname
         l_rest.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_ucomm_row.

  DATA: l_original_ucomm  TYPE sy-ucomm,
        l_cntl_id         TYPE n_numc5,
        l_rest            TYPE string.

* Initializations.
  CLEAR r_row_fieldname.

* Process only if the ucomm is supported by self.
  CHECK is_ucomm_supported( i_ucomm ) = on.

* Split the ucomm in its parts:
*   - original ucomm
*   - control id
*   - row fieldname
*   - rest
  SPLIT i_ucomm
      AT '.'
    INTO l_original_ucomm
         l_cntl_id
         r_row_fieldname
         l_rest.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~get_variant.

  es_variant     = gs_variant.
  e_variant_save = g_variant_save.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~is_cell_enabled.

  DATA: lr_fv_row  TYPE REF TO cl_ish_field_values,
        l_row      TYPE i,
        l_enabled  TYPE ish_on_off,
        l_rc       TYPE ish_method_rc.

* Initializations.
  r_enabled = off.

* Initial checking.
  CHECK NOT i_row_fieldname       IS INITIAL.
  CHECK NOT i_col_fieldname       IS INITIAL.
  CHECK gr_screen_values          IS BOUND.

* Handle g_vcode.
  CHECK NOT g_vcode = co_vcode_display.

* Check the cell fieldval.
  l_enabled = off.
  DO 1 TIMES.
*   Check the corresponding row fieldval.
    CHECK gr_screen_values->get_attr_disabled( i_row_fieldname ) = off.
*   Check the corresponding cell fieldval.
    lr_fv_row = gr_screen_values->get_value_fv( i_row_fieldname ).
    CHECK lr_fv_row IS BOUND.
    CHECK lr_fv_row->get_attr_disabled( i_col_fieldname ) = off.
*   The cell fieldval is enabled.
    l_enabled = on.
  ENDDO.
  CHECK l_enabled = on.

* Michael Manoch, 23.08.2005
* Checking the cellstyle is only neccessary if we have already a gui alv_grid.
  IF gr_alv_grid IS BOUND.
*   Get the corresponding row index.
    CALL METHOD get_row_index_by_fieldname
      EXPORTING
        i_row_fieldname = i_row_fieldname
      IMPORTING
        e_row           = l_row
        e_rc            = l_rc.
    CHECK l_rc = 0.
*   Check the outtab field.
    l_enabled = is_outtab_field_enabled(
                  i_fieldname = i_col_fieldname
                  i_row_idx   = l_row ).
  ENDIF.

* Export.
  r_enabled = l_enabled.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~is_row_enabled.

* Initializations.
  r_enabled = off.

* Initial checking.
  CHECK NOT i_row_fieldname       IS INITIAL.
  CHECK gr_screen_values          IS BOUND.

* Handle g_vcode.
  CHECK NOT g_vcode = co_vcode_display.

* Check the corresponding row fieldval.
  CHECK gr_screen_values->get_attr_disabled( i_row_fieldname ) = off.

* The row is enabled.
  r_enabled = on.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~remove_row.

  DATA: ls_row_fieldval  TYPE rnfield_value.

* Initializations.
  e_rc = 0.
  CLEAR es_row_fieldval.

  CHECK NOT gr_screen_values IS INITIAL.

* Get the specified row fieldval.
  CALL METHOD get_row_fieldval
    EXPORTING
      i_row_fieldname = i_row_fieldname
    IMPORTING
      es_row_fieldval = ls_row_fieldval
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* If the specified row fieldval does not exist we can exit.
  CHECK NOT ls_row_fieldval IS INITIAL.

* Remove the fieldval.
  CALL METHOD gr_screen_values->remove_data
    EXPORTING
      is_field_value  = ls_row_fieldval
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  IF es_row_fieldval IS SUPPLIED.
    es_row_fieldval = ls_row_fieldval.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~select_row.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  FIELD-SYMBOLS:    <l_row>    TYPE ish_fieldname.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
* initialize
  e_rc = 0.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
* check if the entry already exists
  READ TABLE gt_selected_rows FROM i_row_fieldname ASSIGNING <l_row>.
  e_rc = sy-subrc.
  CHECK sy-subrc <> 0.
* append new entry
  APPEND i_row_fieldname TO gt_selected_rows.
  e_rc = 0.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD if_ish_scr_alv_grid~select_rows.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  DATA:          l_rc      TYPE ish_method_rc.
  FIELD-SYMBOLS: <l_row>   TYPE ish_fieldname.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  LOOP AT it_row_fieldname ASSIGNING <l_row>.
    CALL METHOD if_ish_scr_alv_grid~select_row
      EXPORTING
        i_row_fieldname = <l_row>
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDLOOP.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD if_ish_scr_alv_grid~set_allow_new_rows.

  g_allow_new_rows = i_allow_new_rows.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~set_cell_fieldval.

  DATA: lr_row_fieldval  TYPE REF TO cl_ish_field_values.

* Initializations.
  e_rc = 0.

* Get the row fieldval object.
  CALL METHOD get_row_fieldval_object
    EXPORTING
      i_row_fieldname = i_row_fieldname
    IMPORTING
      er_row_fieldval = lr_row_fieldval
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_row_fieldval IS INITIAL.

* Set the cell fieldval.
  CALL METHOD lr_row_fieldval->set_data
    EXPORTING
      i_field_value  = is_col_fieldval
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~set_column_fieldvals.

  DATA: lr_row_fieldval  TYPE REF TO cl_ish_field_values.

* Initializations.
  e_rc = 0.

* Get the row fieldval object.
  CALL METHOD get_row_fieldval_object
    EXPORTING
      i_row_fieldname = i_row_fieldname
    IMPORTING
      er_row_fieldval = lr_row_fieldval
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_row_fieldval IS INITIAL.

* Set the column fieldvals.
  CALL METHOD lr_row_fieldval->set_data
    EXPORTING
      it_field_values = it_col_fieldval
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~set_default_cursor.

* Just wrap to the intern method.
  CALL METHOD intern_set_default_cursor
    EXPORTING
      i_set_focus     = i_set_focus
    IMPORTING
      e_cursor_set    = e_cursor_set
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~set_filter.

  gt_filter = it_filter.

  g_filter_set = on.

ENDMETHOD.


method IF_ISH_SCR_ALV_GRID~SET_LAYOUT.

  gs_layout = is_layout.

  g_layout_set = on.

endmethod.


METHOD if_ish_scr_alv_grid~set_remind_selected_rows.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  g_remind_selected_rows = i_remind_sel.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD if_ish_scr_alv_grid~set_sort.

  gt_sort = it_sort.

  g_sort_set = on.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~set_toolbar_functions.

  gt_toolbar_button = it_button.
  gt_toolbar_fvarp  = it_fvarp.

  IF NOT it_button IS INITIAL OR
     NOT it_fvarp  IS INITIAL.
    CLEAR: g_toolbar_viewtype,
           g_toolbar_fvarid.
  ENDIF.

  g_toolbar_fvar_set = on.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~set_toolbar_fvar.

  g_toolbar_viewtype = i_viewtype.
  g_toolbar_fvarid   = i_fvarid.

* Use the given button/fvarp, if specified.
* If not specified we have to clear the existing button/fvarp.
  IF NOT it_button IS INITIAL.
    gt_toolbar_button = it_button.
    gt_toolbar_fvarp  = it_fvarp.
  ELSEIF NOT i_viewtype IS INITIAL AND
         NOT i_fvarid   IS INITIAL.
    CLEAR: gt_toolbar_button,
           gt_toolbar_fvarp.
  ENDIF.

  g_toolbar_fvar_set = on.

ENDMETHOD.


METHOD if_ish_scr_alv_grid~set_variant.

  IF i_variant_x = on.
    gs_variant    = is_variant.
    g_variant_set = on.
  ENDIF.

  IF i_variant_save_x = on.
    g_variant_save      = i_variant_save.
    g_variant_save_set  = on.
  ENDIF.

ENDMETHOD.


METHOD initialize_alt_selection.
  DATA: l_selfield          TYPE fdname,
        l_groupfield        TYPE fdname,
        lr_selector         TYPE REF TO cl_ish_grid_selector,
        lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid,
        l_rc                TYPE ish_method_rc,
        l_mark_group        TYPE ish_on_off,
        l_mark_single       TYPE ish_on_off.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
* initialize
  CLEAR: l_selfield, l_groupfield.
  IF NOT cr_errorhandler IS BOUND.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
* check if the configuration has selection fields implemented
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

  IF lr_config_alv_grid IS BOUND.
    CALL METHOD lr_config_alv_grid->set_field_for_alt_selection
      IMPORTING
        e_selfield      = l_selfield
        e_groupfield    = l_groupfield
        e_mark_group    = l_mark_group
        e_mark_single   = l_mark_single
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.

    IF NOT l_selfield IS INITIAL.
      lr_selector = get_selector( ).
      CALL METHOD lr_selector->set_field_for_selection
        EXPORTING
          i_sel_field     = l_selfield
          i_group_field   = l_groupfield
          i_mark_group    = l_mark_group
          i_mark_single   = l_mark_single
          ir_cellmerger   = gr_cellmerger
        IMPORTING
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = l_rc.
*     the config has merge fields implemented
*     leave this method
      EXIT.
    ENDIF.
  ENDIF.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
* the config has no selection fields implemented
  CALL METHOD set_field_for_alt_selection
    IMPORTING
      e_sel_field     = l_selfield
      e_group_field   = l_groupfield
      e_mark_group    = l_mark_group
      e_mark_single   = l_mark_single
      er_cellmerger   = gr_cellmerger
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

  IF NOT l_selfield IS INITIAL.
    lr_selector = get_selector( ).
    CALL METHOD lr_selector->set_field_for_selection
      EXPORTING
        i_sel_field     = l_selfield
        i_group_field   = l_groupfield
        i_mark_group    = l_mark_group
        i_mark_single   = l_mark_single
        ir_cellmerger   = gr_cellmerger
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.
  e_rc = l_rc.
* --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD initialize_appl_events.

* The default implementation uses appl_events.
* Redefine if needed.

  g_appl_events = on.

ENDMETHOD.


METHOD initialize_buttondefs.

* This method has to be redefined in derived classes
* if buttons are used.

ENDMETHOD.


METHOD initialize_cell_merging.
* --- --- --- --- --- --- --- --- --- --- --- --- ---
  DATA: l_rc               TYPE ish_method_rc,
        lt_fields          TYPE ish_t_merge_fields,
        lr_config_alv_grid TYPE REF TO if_ish_config_alv_grid,
        lr_cellmerger      TYPE REF TO cl_ish_grid_cellmerger,
        l_acc_mode         TYPE abap_bool.
* --- --- --- --- --- --- --- --- --- --- --- --- ---
* check if accessibility mode is active
  CALL FUNCTION 'ISH_ACCESSIBILITY_MODE_GET'
    IMPORTING
      accessibility     = l_acc_mode
    EXCEPTIONS
      its_not_available = 1
      OTHERS            = 2.
  CHECK l_acc_mode = abap_off.
* --- --- --- --- --- --- --- --- --- --- --- --- ---
* initialize
  CLEAR lt_fields. REFRESH lt_fields.
* --- --- --- --- --- --- --- --- --- --- --- --- ---
  IF NOT cr_errorhandler IS BOUND.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* --- --- --- --- --- --- --- --- --- --- --- --- ---
* let the configuration add merge fields
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF lr_config_alv_grid IS BOUND.
* --- --- --- --- --- --- --- --- --- --- --- --- ---
    CALL METHOD lr_config_alv_grid->add_merge_fields
      IMPORTING
        et_fields       = lt_fields
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.

    IF NOT lt_fields IS INITIAL.
      lr_cellmerger = get_cellmerger( ).
      CALL METHOD lr_cellmerger->add_merge_fields
        EXPORTING
          it_fields       = lt_fields
        IMPORTING
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = l_rc.
*     the config has merge fields implemented
*     leave this method
      EXIT.
    ENDIF.
  ENDIF.
* --- --- --- --- --- --- --- --- --- --- --- --- ---
* configuration has no merge fields implemented
  CALL METHOD add_merge_fields
    IMPORTING
      et_fields       = lt_fields
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

  IF NOT lt_fields[] IS INITIAL.
    lr_cellmerger = get_cellmerger( ).
    CALL METHOD lr_cellmerger->add_merge_fields
      EXPORTING
        it_fields       = lt_fields
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.
  e_rc = 0.
* --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD initialize_fieldnames.

  DATA: lt_ddfields  TYPE ddfields,
        l_rc         TYPE ish_method_rc.

* Initializations.
  CLEAR: g_fieldname_row_id,
         g_fieldname_cellstyle.

* Get the outtab ddfields.
  CALL METHOD get_outtab_ddfields
    IMPORTING
      et_ddfields = lt_ddfields
      e_rc        = l_rc.
  CHECK l_rc = 0.

* row_id.
  READ TABLE lt_ddfields
    WITH KEY fieldname = 'ROW_ID'
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    g_fieldname_row_id    = 'ROW_ID'.
  ENDIF.

* cellstyle.
  READ TABLE lt_ddfields
    WITH KEY fieldname = 'CELLSTYLE'
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    g_fieldname_cellstyle    = 'CELLSTYLE'.
  ENDIF.

* filtermark.
  READ TABLE lt_ddfields
    WITH KEY fieldname = 'FILTERMARK'
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    g_fieldname_filtermark = 'FILTERMARK'.
  ENDIF.

* is_changed.
  READ TABLE lt_ddfields
    WITH KEY fieldname = 'IS_CHANGED'
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    g_fieldname_is_changed = 'IS_CHANGED'.
  ENDIF.

* is_empty.
  READ TABLE lt_ddfields
    WITH KEY fieldname = 'IS_EMPTY'
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    g_fieldname_is_empty    = 'IS_EMPTY'.
  ENDIF.

* is_new.
  READ TABLE lt_ddfields
    WITH KEY fieldname = 'IS_NEW'
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    g_fieldname_is_new = 'IS_NEW'.
  ENDIF.

ENDMETHOD.


METHOD initialize_field_values.

* The default implementation does nothing.
* Redefine this method if you have any specialities.

ENDMETHOD.


METHOD initialize_grid.

  DATA: lr_alv_grid       TYPE REF TO cl_gui_alv_grid,
        l_rc              TYPE ish_method_rc.

  FIELD-SYMBOLS: <lt_outtab>  TYPE table.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Processing can only be done if the outtab is available.
  CHECK gr_outtab IS BOUND.

* Assign the outtab.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = 'SET_TABLE_FOR_FIRST_DISPLAY'
        i_mv3           = 'CL_GUI_ALV_GRID'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Get the alv_grid.
* If it does not already exist, it will be created.
  CALL METHOD get_alv_grid
    IMPORTING
      er_alv_grid     = lr_alv_grid
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  CHECK NOT lr_alv_grid IS INITIAL.

* Register the F4-table
  CALL METHOD lr_alv_grid->register_f4_for_fields
    EXPORTING
      it_f4 = gt_f4.

* Set the alv_grid drop_down table.
  CALL METHOD lr_alv_grid->set_drop_down_table
    EXPORTING
      it_drop_down_alias = gt_drop_down_alias.

* Set the alv_grid handler methods.
  CALL METHOD set_grid_handlers
    EXPORTING
      i_activation    = on
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* set_table_for_first_display.
  CALL METHOD lr_alv_grid->set_table_for_first_display
    EXPORTING
      is_variant                    = gs_variant
      i_save                        = g_variant_save
      is_layout                     = gs_layout
      it_toolbar_excluding          = gt_excl_func
    CHANGING
      it_outtab                     = <lt_outtab>
      it_fieldcatalog               = gt_fieldcat
      it_sort                       = gt_sort
      it_filter                     = gt_filter
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = 'SET_TABLE_FOR_FIRST_DISPLAY'
        i_mv3           = 'CL_GUI_ALV_GRID'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Set toolbar interactive.
  CALL METHOD gr_alv_grid->set_toolbar_interactive.

* After set_table_for_first_display some properties
* may have been changed (eg by using a variant with sort).
* Therefore we have to refresh these properties.
  CALL METHOD gr_alv_grid->get_sort_criteria
    IMPORTING
      et_sort = gt_sort.
  CALL METHOD gr_alv_grid->get_filter_criteria
    IMPORTING
      et_filter = gt_filter.
  CALL METHOD gr_alv_grid->get_frontend_fieldcatalog
    IMPORTING
      et_fieldcatalog = gt_fieldcat.
  CALL METHOD gr_alv_grid->get_frontend_layout
    IMPORTING
      es_layout = gs_layout.
* On variant filter we have to actualize the filtermark.
  CALL METHOD actualize_filtermark.

* do the cellmerging
  IF is_cellmerging_active( ) = on.
    CALL METHOD gr_cellmerger->do_cell_merging
      EXPORTING
        it_fieldcat     = gt_fieldcat
      IMPORTING
        e_rc            = l_rc
      CHANGING
        ct_outtab       = <lt_outtab>
        cr_errorhandler = cr_errorhandler.
  ENDIF.

* Refresh the grid.
  CALL METHOD refresh_grid
    EXPORTING
      i_refresh_drop_down_table = off
      i_refresh_fieldcat        = on
      i_refresh_layout          = on
      i_refresh_variant         = off
      i_refresh_sort            = on
      i_refresh_filter          = on
    IMPORTING
      e_rc                      = e_rc
    CHANGING
      cr_errorhandler           = cr_errorhandler.

ENDMETHOD.


METHOD initialize_handle_filter.

* The default implementation does not handle special filters.
* Redefine this method in derived classes if needed.

  g_handle_filter_is_changed = off.
  g_handle_filter_is_empty   = off.
  g_handle_filter_is_new     = off.

ENDMETHOD.


METHOD initialize_listboxdefs .

* This method has to be redefined in derived classes
* if listboxes are used.

ENDMETHOD.


METHOD initialize_sortorder.

* The default implementation does not handle special sorts.
* Redefine this method in derived classes if needed.

  g_sortorder_is_changed = 0.
  g_sortorder_is_empty   = 0.
  g_sortorder_is_new     = 0.

ENDMETHOD.


METHOD intern_set_default_cursor.

  DATA: lt_filter_tech        TYPE lvc_t_filt,
        l_row_idx             TYPE int4,
        ls_row_id             TYPE lvc_s_row,
        ls_col_id             TYPE lvc_s_col,
        l_rc                  TYPE ish_method_rc.

  FIELD-SYMBOLS: <lt_outtab>      TYPE STANDARD TABLE,
                 <ls_outtab>      TYPE ANY,
                 <ls_fcat>        TYPE lvc_s_fcat.

* Initializations.
  e_rc         = 0.
  e_cursor_set = off.

* Initial checking
  CHECK gr_alv_grid IS BOUND.

* Processing can only be done if the outtab is available.
  CHECK gr_outtab IS BOUND.

* Assign the outtab.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = 'SET_DEFAULT_CURSOR'
        i_mv3           = 'CL_ISH_SCR_ALV_GRID'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Get the technical filter criteria.
  lt_filter_tech = transform_to_technical_filter( gt_filter ).

* If is_row_id was specified we check if it fits the filter.
  CLEAR ls_row_id.
  DO 1 TIMES.
    CHECK NOT is_row_id-index IS INITIAL.
    READ TABLE <lt_outtab>
      ASSIGNING <ls_outtab>
      INDEX is_row_id-index.
    CHECK sy-subrc = 0.
    CHECK does_outtab_entry_fit_filter(
            it_filter = lt_filter_tech
            is_outtab = <ls_outtab> ) = on.
    ls_row_id = is_row_id.
  ENDDO.

* If is_row_id does not fit, we determine the default row.
  IF ls_row_id-index IS INITIAL.
*   Get the index of the first outtab entry.
    l_row_idx = 0.
    CLEAR ls_row_id.
    LOOP AT <lt_outtab> ASSIGNING <ls_outtab>.
*     Increment the row index.
      l_row_idx = l_row_idx + 1.
*     Check if the outtab entry fits the filter.
      CHECK does_outtab_entry_fit_filter(
              it_filter = lt_filter_tech
              is_outtab = <ls_outtab> ) = on.
*     This is the row to position the cursor.
      ls_row_id-index = l_row_idx.
      EXIT.
    ENDLOOP.
  ENDIF.
  CHECK NOT ls_row_id-index IS INITIAL.

* If is_col_id was specified we check if it fits the fieldcat.
  CLEAR ls_col_id.
  DO 1 TIMES.
    CHECK NOT is_col_id-fieldname IS INITIAL.
    READ TABLE gt_fieldcat
      ASSIGNING <ls_fcat>
      WITH KEY fieldname = is_col_id-fieldname.
    CHECK sy-subrc = 0.
    CHECK <ls_fcat>-tech   = off.
    CHECK <ls_fcat>-no_out = off.
    ls_col_id = is_col_id.
  ENDDO.

* If is_col_id does not fit, we determine the default fieldname.
  IF ls_col_id IS INITIAL.
*   Now get the fieldname of the first column.
    CLEAR ls_col_id.
    LOOP AT gt_fieldcat ASSIGNING <ls_fcat>.
      CHECK <ls_fcat>-tech   = off.
      CHECK <ls_fcat>-no_out = off.
      ls_col_id-fieldname = <ls_fcat>-fieldname.
      EXIT.
    ENDLOOP.
  ENDIF.
  CHECK NOT ls_col_id IS INITIAL.

* So set the current cell.
  CALL METHOD gr_alv_grid->set_current_cell_via_id
    EXPORTING
      is_row_id    = ls_row_id
      is_column_id = ls_col_id.

* The cursor was set.
  e_cursor_set = on.

* Set the focus.
  IF i_set_focus = on.
    CALL METHOD cl_gui_alv_grid=>set_focus
      EXPORTING
        control           = gs_parent-container
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
  ENDIF.

ENDMETHOD.


METHOD is_alt_selection_active.
* --- --- --- --- --- --- --- --- --- ---
  e_is_active = off.
  CHECK gr_selector IS BOUND.
  e_is_active = gr_selector->is_active( i_fieldname ).
* --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD is_cellmerging_active.
* --- --- --- --- --- --- --- --- --- --- ---
  r_is_active = off.
  CHECK gr_cellmerger IS BOUND.
  r_is_active = gr_cellmerger->is_active( i_fieldname ).
* --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD is_f4_in_display_mode.
*MED-38907

  DATA: l_field_enabled    TYPE ish_on_off.

  r_mode_display = off.

  l_field_enabled = is_outtab_field_enabled( i_fieldname = i_fieldname
                                             i_row_idx = i_rownumber ).
  CHECK l_field_enabled = off.

  r_mode_display = on.

ENDMETHOD.


METHOD is_message_handled.

* Special implementation for alv_grids.
* GS_MESSAGE-PARAMETER: row name
* GS_MESSAGE-FIELD:     column name

  DATA: l_row_fieldname       TYPE ish_fieldname,
        l_col_fieldname       TYPE ish_fieldname.

* Initializations.
  r_is_handled = off.

* Initial checking.
  CHECK gr_screen_values IS BOUND.
  l_row_fieldname = is_message-parameter.
  CHECK NOT l_row_fieldname IS INITIAL.
  l_col_fieldname = is_message-field.
  CHECK NOT l_col_fieldname IS INITIAL.

* Do we have the row?
  CHECK gr_screen_values->has_entry( l_row_fieldname ) = on.

* Do we have the column?
  READ TABLE gt_fieldcat
    WITH KEY fieldname = l_col_fieldname
    TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

* We have the corresponding field -> so the message is handled.
  r_is_handled = on.

ENDMETHOD.


METHOD is_outtab_field_enabled.

  DATA: lr_button  TYPE REF TO cl_ish_grid_button,
        l_rc       TYPE ish_method_rc.

  FIELD-SYMBOLS: <lt_outtab>     TYPE STANDARD TABLE,
                 <ls_outtab>     TYPE any,
                 <ls_fieldcat>   TYPE lvc_s_fcat,
                 <lt_cellstyle>  TYPE lvc_t_styl,
                 <ls_cellstyle>  TYPE lvc_s_styl.

* Initializations.
  r_enabled = off.

* Initial checking.
  CHECK NOT i_fieldname           IS INITIAL.
  CHECK NOT i_row_idx             IS INITIAL.
*  CHECK NOT g_fieldname_cellstyle IS INITIAL. "MED-38907
  CHECK gr_alv_grid               IS BOUND.
  CHECK gr_outtab                 IS BOUND.

* Handle g_vcode.
  CHECK NOT g_vcode = co_vcode_display.

*MED-38907
* Handle the fieldcat.
  READ TABLE gt_fieldcat
    ASSIGNING <ls_fieldcat>
    WITH KEY fieldname = i_fieldname.
  CHECK sy-subrc = 0.
  CHECK <ls_fieldcat>-tech = off.
  CHECK <ls_fieldcat>-edit = on.
*MED-38907

* Assign the outtab.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  CHECK sy-subrc = 0.

* Get the corresponding outtab entry.
  READ TABLE <lt_outtab>
    ASSIGNING <ls_outtab>
    INDEX i_row_idx.
  CHECK sy-subrc = 0.

* Handle buttons.
  IF gr_buttonhandler IS BOUND.
    lr_button = gr_buttonhandler->get_button(
                  i_fieldname = i_fieldname
                  is_outtab   = <ls_outtab> ).
    IF lr_button IS BOUND.
      r_enabled = lr_button->is_enabled( ).
      EXIT.
    ENDIF.
  ENDIF.

*MED-38907
** Handle the fieldcat.
*  READ TABLE gt_fieldcat
*    ASSIGNING <ls_fieldcat>
*    WITH KEY fieldname = i_fieldname.
*  CHECK sy-subrc = 0.
*  CHECK <ls_fieldcat>-tech = off.
*  CHECK <ls_fieldcat>-edit = on.
*MED-38907

  IF g_fieldname_cellstyle IS NOT INITIAL. "MED-38907
*   Assign the cellstyle field.
    ASSIGN COMPONENT g_fieldname_cellstyle
    OF STRUCTURE <ls_outtab>
    TO <lt_cellstyle>.
    CHECK sy-subrc = 0.

*   Assign the corresponding cellstyle entry.
    READ TABLE <lt_cellstyle>
      ASSIGNING <ls_cellstyle>
      WITH KEY fieldname = i_fieldname.
    IF sy-subrc = 0.
*     Handle the cellstyle entry.
      CHECK NOT <ls_cellstyle>-style =
                  cl_gui_alv_grid=>mc_style_disabled.
*MED-38907
      CHECK NOT <ls_cellstyle>-style2 =
                  cl_gui_alv_grid=>mc_style_disabled.
      CHECK NOT <ls_cellstyle>-style3 =
                  cl_gui_alv_grid=>mc_style_disabled.
      CHECK NOT <ls_cellstyle>-style4 =
                  cl_gui_alv_grid=>mc_style_disabled.
*MED-38907
    ENDIF.
  ENDIF. "MED-38907

* All checks successfully handled -> cell is enabled.
  r_enabled = on.

ENDMETHOD.


METHOD is_technical_filter.

  DATA: l_handle_filtermark  TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_filter>  TYPE lvc_s_filt.

* Initializations.
  r_is_technical_filter = off.

* No filter criteria -> not technical.
  CHECK NOT it_filter IS INITIAL.

* Get the flag for filtermark handling.
  l_handle_filtermark = check_handle_filtermark( ).

* Process each filter criterium.
* If we find at least one technical filter criterium
* this is a technical filter.
  LOOP AT it_filter ASSIGNING <ls_filter>.
*   Handle the filtermark.
    IF l_handle_filtermark = on.
      IF <ls_filter>-fieldname = g_fieldname_filtermark.
        r_is_technical_filter = on.
        EXIT.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD is_technical_sort.

  DATA: l_handle_sortorder  TYPE ish_on_off,
        l_fieldname         TYPE ish_fieldname.

  FIELD-SYMBOLS: <ls_sort>  TYPE lvc_s_sort.

* Initializations.
  r_is_technical_sort = off.

* No sort criteria -> not technical.
  CHECK NOT it_sort IS INITIAL.

* Get the flag for sortorder handling.
  l_handle_sortorder = check_handle_sortorder( ).

* Process each sort criterium.
* If we find at least one technical sort criterium
* this is a technical sort.
  LOOP AT it_sort ASSIGNING <ls_sort>.
*   Handle the sortorder.
    IF l_handle_sortorder = on.
      l_fieldname = <ls_sort>-fieldname.
      IF is_technical_sortfield( l_fieldname ) = on.
        r_is_technical_sort = on.
        EXIT.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD is_technical_sortfield.

* Initializations.
  r_is_technical_sortfield = off.

* No fieldname -> not technical.
  CHECK NOT i_fieldname IS INITIAL.

* IS_CHANGED
  IF i_fieldname = g_fieldname_is_changed AND
     g_sortorder_is_changed > 0.
    r_is_technical_sortfield = on.
    EXIT.
  ENDIF.

* IS_EMPTY
  IF i_fieldname = g_fieldname_is_empty AND
     g_sortorder_is_empty > 0.
    r_is_technical_sortfield = on.
    EXIT.
  ENDIF.

* IS_NEW
  IF i_fieldname = g_fieldname_is_new AND
     g_sortorder_is_new > 0.
    r_is_technical_sortfield = on.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD is_ucomm_enabled.

* The default implementation enables every ucomm.
* Redefine this method if needed.

  r_enabled = on.

ENDMETHOD.


METHOD modify_cellstyle .

  DATA: ls_cellstyle  TYPE lvc_s_styl.

  FIELD-SYMBOLS: <lt_cellstyle>  TYPE lvc_t_styl,
                 <l_cell>        TYPE ANY.
* Initializations.
  e_modified = off.

* Initial checking.
  CHECK NOT i_fieldname           IS INITIAL.
  CHECK NOT cs_outtab             IS INITIAL.
  CHECK NOT g_fieldname_cellstyle IS INITIAL.

* Integrate the buttonhandler.
  DO 1 TIMES.
    CHECK gr_buttonhandler IS BOUND.
    CHECK gr_buttonhandler->is_field_supported( i_fieldname ) = on.
    CALL METHOD gr_buttonhandler->modify_cellstyle
      EXPORTING
        i_fieldname  = i_fieldname
        i_enable     = i_enable
        i_disable_f4 = i_disable_f4
      IMPORTING
        e_modified   = e_modified
      CHANGING
        cs_outtab    = cs_outtab.
  ENDDO.
  CHECK e_modified = off.

* Now do own processing.

* Assign the cellstyle.
  CHECK NOT g_fieldname_cellstyle IS INITIAL.
  ASSIGN COMPONENT g_fieldname_cellstyle
    OF STRUCTURE cs_outtab
    TO <lt_cellstyle>.
  CHECK sy-subrc = 0.

* Assign the cell.
  ASSIGN COMPONENT i_fieldname
    OF STRUCTURE cs_outtab
    TO <l_cell>.
  CHECK sy-subrc = 0.

* Delete a maybe existing cellstyle entry.
  DELETE TABLE <lt_cellstyle> WITH TABLE KEY fieldname = i_fieldname.

* On enabling this is all we have to do.
  CHECK i_enable = off.

* Disable the cell.
  CLEAR: ls_cellstyle.
  ls_cellstyle-fieldname = i_fieldname.
  ls_cellstyle-style     = cl_gui_alv_grid=>mc_style_disabled.
  IF i_disable_f4 = on.
    ls_cellstyle-style2  = cl_gui_alv_grid=>mc_style_f4_no.
  ENDIF.
  INSERT ls_cellstyle INTO TABLE <lt_cellstyle>.

ENDMETHOD.


METHOD modify_fieldcat .

* This method synchronizes the modified fields with the field catalogue.
* If the field catalogue is changed, the flag for fieldcat changes
* is set.

  DATA: l_rc  TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fieldcat>  TYPE lvc_s_fcat,
                 <ls_modified>  TYPE rn1screen.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Modify the field catalogue according to lt_modified.
  LOOP AT it_modified ASSIGNING <ls_modified>.
*   Get the corresponding field catalogue entry.
    READ TABLE gt_fieldcat
      WITH KEY fieldname = <ls_modified>-name
      ASSIGNING <ls_fieldcat>.
    CHECK sy-subrc = 0.
*   Modify the field catalogue entry.
*   - tech
    IF <ls_modified>-active = false.
      IF <ls_fieldcat>-tech = off.
        <ls_fieldcat>-tech = on.
        g_fieldcat_changed = on.
      ENDIF.
    ELSE.
      IF <ls_fieldcat>-tech = on.
        <ls_fieldcat>-tech = off.
        g_fieldcat_changed = on.
      ENDIF.
    ENDIF.
*   - edit
    IF <ls_modified>-input = true.
      IF <ls_fieldcat>-edit = off.
        <ls_fieldcat>-edit = on.
        g_fieldcat_changed = on.
      ENDIF.
    ELSE.
      IF <ls_fieldcat>-edit = on.
        <ls_fieldcat>-edit = off.
        g_fieldcat_changed = on.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD modify_screen_internal.

* The default implementation sets the edit-field of the field catalogue
* to false in display mode.
* Redefine this method (and call the super-method) to do own
* modifications on the field catalogue.

  DATA: lr_alv_grid         TYPE REF TO cl_gui_alv_grid,
        l_ready_for_input   TYPE int4.

  FIELD-SYMBOLS: <ls_fieldcat>  TYPE lvc_s_fcat.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Get the alv_grid object.
  CALL METHOD get_alv_grid
    IMPORTING
      er_alv_grid     = lr_alv_grid
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_alv_grid IS INITIAL.

* Allow edit
  IF g_vcode = co_vcode_display.
    l_ready_for_input = 0.
  ELSE.
    l_ready_for_input = 1.
  ENDIF.
  CALL METHOD lr_alv_grid->set_ready_for_input
    EXPORTING
      i_ready_for_input = l_ready_for_input.

ENDMETHOD.


METHOD ok_code_screen_internal.

* This method should be redefined in derived classes.

ENDMETHOD.


METHOD prepare_for_drag_and_drop.

* No default implementation.
* Redefine if needed.

  e_rc = 0.

ENDMETHOD.


METHOD process_button_click.

  DATA: l_row_fieldname     TYPE ish_fieldname,
        l_col_fieldname     TYPE ish_fieldname,
        lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid,
        l_row_idx           TYPE int4,
        lt_modi             TYPE lvc_t_modi,
        lt_modified_fv      TYPE ish_t_field_value.

  FIELD-SYMBOLS: <lt_outtab>  TYPE STANDARD TABLE.

* Initializations.
  e_rc            = 0.
  e_ucomm_handled = off.

* Initial checking.
  CHECK NOT i_ucomm IS INITIAL.

* Get the row and column fieldname from the ucomm.
  l_row_fieldname = get_ucomm_row( i_ucomm ).
  l_col_fieldname = get_ucomm_col( i_ucomm ).

* Let the configuration handle the button click command.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT lr_config_alv_grid IS INITIAL.
    CALL METHOD lr_config_alv_grid->process_button_click
      EXPORTING
        i_row_fieldname = l_row_fieldname
        i_col_fieldname = l_col_fieldname
      IMPORTING
        e_handled       = e_ucomm_handled
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc            = 0.
    CHECK e_ucomm_handled = off.
  ENDIF.

* Let the buttonhandler process the button_click.
  DO 1 TIMES.
    CHECK gr_buttonhandler IS BOUND.
*   Get the row index.
    CALL METHOD get_row_index_by_fieldname
      EXPORTING
        i_row_fieldname = l_row_fieldname
      IMPORTING
        e_row           = l_row_idx
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
*   Assign the outtab.
    CHECK gr_outtab IS BOUND.
    ASSIGN gr_outtab->* TO <lt_outtab>.
    CHECK sy-subrc = 0.
*   Process the button_click.
    CALL METHOD gr_buttonhandler->process_button_click
      EXPORTING
        i_row_idx          = l_row_idx
        i_fieldname_button = l_col_fieldname
      IMPORTING
        e_handled          = e_ucomm_handled
        et_modi            = lt_modi
        e_rc               = e_rc
      CHANGING
        ct_outtab          = <lt_outtab>
        cr_errorhandler    = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK e_ucomm_handled = on.
*   We have to remind the cursorfield.
    g_remind_cursorfield = on.
    CALL METHOD remind_cursorfield.
*   Now process the result.
    IF NOT lt_modi IS INITIAL.
      CALL METHOD transport_modified_cells
        EXPORTING
          it_modi         = lt_modi
        IMPORTING
          et_modified_fv  = lt_modified_fv
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
      APPEND LINES OF lt_modi TO gt_modified_cells.
      RAISE EVENT ev_data_changed_at_okcode
        EXPORTING
          ir_screen    = me
          it_field_val = lt_modified_fv.
    ENDIF.
  ENDDO.
  CHECK e_rc            = 0.
  CHECK e_ucomm_handled = off.

* Do own button click processing.
  CALL METHOD process_button_click_internal
    EXPORTING
      i_row_fieldname = l_row_fieldname
      i_col_fieldname = l_col_fieldname
    IMPORTING
      e_ucomm_handled = e_ucomm_handled
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD process_button_click_internal .

* This method has to be redefined in derived classes if needed.

ENDMETHOD.


METHOD process_double_click .

  DATA: l_row_fieldname     TYPE ish_fieldname,
        l_col_fieldname     TYPE ish_fieldname,
        l_ucomm_handled     TYPE ish_on_off,
        lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid.

* Initializations.
  e_rc = 0.
  e_ucomm_handled = off.

  CHECK NOT i_ucomm IS INITIAL.

* Get the row and column fieldname from the ucomm.
  l_row_fieldname = get_ucomm_row( i_ucomm ).
  l_col_fieldname = get_ucomm_col( i_ucomm ).

* Let the configuration handle the double click command.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT lr_config_alv_grid IS INITIAL.
    CALL METHOD lr_config_alv_grid->process_double_click
      EXPORTING
        i_row_fieldname = l_row_fieldname
        i_col_fieldname = l_col_fieldname
      IMPORTING
        e_ucomm_handled = l_ucomm_handled
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Do own double click processing.
  IF l_ucomm_handled = off.
    CALL METHOD process_double_click_internal
      EXPORTING
        i_row_fieldname = l_row_fieldname
        i_col_fieldname = l_col_fieldname
      IMPORTING
        e_ucomm_handled = l_ucomm_handled
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Export.
  e_ucomm_handled = l_ucomm_handled.

ENDMETHOD.


METHOD process_double_click_internal .

* This method should be redefined by derived classes if needed.

ENDMETHOD.


METHOD process_hotspot_click .

  DATA: l_row_fieldname     TYPE ish_fieldname,
        l_col_fieldname     TYPE ish_fieldname,
        l_ucomm_handled     TYPE ish_on_off,
        lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid.

* Initializations.
  e_rc = 0.
  e_ucomm_handled = off.

  CHECK NOT i_ucomm IS INITIAL.

* Get the row and column fieldname from the ucomm.
  l_row_fieldname = get_ucomm_row( i_ucomm ).
  l_col_fieldname = get_ucomm_col( i_ucomm ).

* Let the configuration handle the hotspot click command.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT lr_config_alv_grid IS INITIAL.
    CALL METHOD lr_config_alv_grid->process_hotspot_click
      EXPORTING
        i_row_fieldname = l_row_fieldname
        i_col_fieldname = l_col_fieldname
      IMPORTING
        e_ucomm_handled = l_ucomm_handled
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Do own hotspot click processing.
  IF l_ucomm_handled = off.
    CALL METHOD process_hotspot_click_internal
      EXPORTING
        i_row_fieldname = l_row_fieldname
        i_col_fieldname = l_col_fieldname
      IMPORTING
        e_ucomm_handled = l_ucomm_handled
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Export.
  e_ucomm_handled = l_ucomm_handled.

ENDMETHOD.


METHOD process_hotspot_click_internal .

* This method should be redefined by derived classes if needed.

ENDMETHOD.


METHOD process_print_end_of_list .

  DATA: lr_config_alv_grid TYPE REF TO if_ish_config_alv_grid,
        l_rc               TYPE        ish_method_rc,
        lr_errorhandler    TYPE REF TO cl_ishmed_errorhandling,
        l_ucomm_handled    TYPE ish_on_off.

* Let the configuration handle the Event PRINT_END_OF_LIST.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = lr_errorhandler.
  CHECK l_rc = 0.
  IF NOT lr_config_alv_grid IS INITIAL.
    CALL METHOD lr_config_alv_grid->process_print_end_of_list
      EXPORTING
        i_screen  = me
      IMPORTING
        e_handled = l_ucomm_handled.
    CHECK l_ucomm_handled = off.
  ENDIF.

  CHECK l_ucomm_handled = off.
* Do own PRINT_END_OF_LIST processing.
  CALL METHOD process_print_end_of_list_int.

ENDMETHOD.


METHOD process_print_end_of_list_int .

* This method has to be redefined in derived classes if needed.

ENDMETHOD.


METHOD process_print_end_of_page .

  DATA: lr_config_alv_grid TYPE REF TO if_ish_config_alv_grid,
        l_rc               TYPE        ish_method_rc,
        lr_errorhandler    TYPE REF TO cl_ishmed_errorhandling,
        l_ucomm_handled    TYPE ish_on_off.

* Let the configuration handle the Event PRINT_END_OF_PAGE.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = lr_errorhandler.
  CHECK l_rc = 0.
  IF NOT lr_config_alv_grid IS INITIAL.
    CALL METHOD lr_config_alv_grid->process_print_end_of_page
      EXPORTING
        i_screen  = me
      IMPORTING
        e_handled = l_ucomm_handled.
    CHECK l_ucomm_handled = off.
  ENDIF.

  CHECK l_ucomm_handled = off.
* Do own PRINT_END_OF_PAGE processing.
  CALL METHOD process_print_end_of_page_int.

ENDMETHOD.


METHOD process_print_end_of_page_int .

* This method has to be redefined in derived classes if needed.

ENDMETHOD.


METHOD process_print_top_of_list .

  DATA: lr_config_alv_grid TYPE REF TO if_ish_config_alv_grid,
        l_rc               TYPE        ish_method_rc,
        lr_errorhandler    TYPE REF TO cl_ishmed_errorhandling,
        l_ucomm_handled    TYPE ish_on_off.

* Let the configuration handle the Event PRINT_TOP_OF_LIST.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = lr_errorhandler.
  CHECK l_rc = 0.
  IF NOT lr_config_alv_grid IS INITIAL.
    CALL METHOD lr_config_alv_grid->process_print_top_of_list
      EXPORTING
        i_screen  = me
      IMPORTING
        e_handled = l_ucomm_handled.
    CHECK l_ucomm_handled = off.
  ENDIF.

  CHECK l_ucomm_handled = off.
* Do own PRINT_TOP_OF_LIST processing.
  CALL METHOD process_print_top_of_list_int.

ENDMETHOD.


METHOD process_print_top_of_list_int .

* This method has to be redefined in derived classes if needed.

ENDMETHOD.


METHOD process_print_top_of_page .

  DATA: lr_config_alv_grid TYPE REF TO if_ish_config_alv_grid,
        l_rc               TYPE        ish_method_rc,
        lr_errorhandler    TYPE REF TO cl_ishmed_errorhandling,
        l_ucomm_handled    TYPE ish_on_off.

* Initial checking.
  CHECK NOT table_index IS INITIAL.

* Let the configuration handle the Event PRINT_TOP_OF_PAGE.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = lr_errorhandler.
  CHECK l_rc = 0.
  IF NOT lr_config_alv_grid IS INITIAL.
    CALL METHOD lr_config_alv_grid->process_print_top_of_page
      EXPORTING
        i_table_index = table_index
        i_screen      = me
      IMPORTING
        e_handled     = l_ucomm_handled.
    CHECK l_ucomm_handled = off.
  ENDIF.

  CHECK l_ucomm_handled = off.
* Do own PRINT_TOP_OF_PAGE processing.
  CALL METHOD process_print_top_of_page_int
    EXPORTING
      i_table_index = table_index.

ENDMETHOD.


METHOD process_print_top_of_page_int .

* This method has to be redefined in derived classes if needed.

ENDMETHOD.


METHOD process_sysev_button_click.

  DATA: lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid.

  FIELD-SYMBOLS: <lt_outtab>  TYPE STANDARD TABLE.

* Initializations.
  e_rc      = 0.
  e_handled = off.
  CLEAR et_modi.

* Initial checking.
  CHECK NOT i_row_idx          IS INITIAL.
  CHECK NOT i_fieldname_button IS INITIAL.

* Let the configuration handle the button_click.
  DO 1 TIMES.
*   Get the alv_grid config.
    CALL METHOD get_config_alv_grid
      IMPORTING
        er_config_alv_grid = lr_config_alv_grid
        e_rc               = e_rc
      CHANGING
        cr_errorhandler    = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK lr_config_alv_grid IS BOUND.
*   Assign the outtab.
    CHECK gr_outtab IS BOUND.
    ASSIGN gr_outtab->* TO <lt_outtab>.
    CHECK sy-subrc = 0.
*   Process the hotspot_click.
    CALL METHOD lr_config_alv_grid->process_sysev_button_click
      EXPORTING
      i_row_idx          = i_row_idx
      i_fieldname_button = i_fieldname_button
      IMPORTING
        e_handled        = e_handled
        et_modi          = et_modi
        e_rc             = e_rc
      CHANGING
        ct_outtab        = <lt_outtab>
        cr_errorhandler  = cr_errorhandler.
  ENDDO.
  CHECK e_rc      = 0.
  CHECK e_handled = off.

* Let the buttonhandler process the button_click.
  DO 1 TIMES.
    CHECK gr_buttonhandler IS BOUND.
*   Assign the outtab.
    CHECK gr_outtab IS BOUND.
    ASSIGN gr_outtab->* TO <lt_outtab>.
    CHECK sy-subrc = 0.
*   Process the button_click.
    CALL METHOD gr_buttonhandler->process_button_click
      EXPORTING
        i_row_idx          = i_row_idx
        i_fieldname_button = i_fieldname_button
      IMPORTING
        e_handled          = e_handled
        et_modi            = et_modi
        e_rc               = e_rc
      CHANGING
        ct_outtab          = <lt_outtab>
        cr_errorhandler    = cr_errorhandler.
  ENDDO.
  CHECK e_rc      = 0.
  CHECK e_handled = off.

* Now do own button click processing.
  CALL METHOD process_sysev_button_click_int
    EXPORTING
      i_row_idx          = i_row_idx
      i_fieldname_button = i_fieldname_button
    IMPORTING
      e_handled          = e_handled
      et_modi            = et_modi
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD process_sysev_button_click_int .

* This method should be redefined in derived classes if needed.

  e_handled = off.
  e_rc      = 0.
  CLEAR et_modi.

ENDMETHOD.


METHOD process_sysev_double_click .

  DATA: lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid.

  FIELD-SYMBOLS: <lt_outtab>  TYPE STANDARD TABLE.

* Initializations.
  e_rc      = 0.
  e_handled = off.
  CLEAR et_modi.

* Initial checking.
  CHECK NOT i_row_idx                IS INITIAL.
  CHECK NOT i_fieldname_double_click IS INITIAL.

* Let the configuration handle the double_click.
  DO 1 TIMES.
*   Get the alv_grid config.
    CALL METHOD get_config_alv_grid
      IMPORTING
        er_config_alv_grid = lr_config_alv_grid
        e_rc               = e_rc
      CHANGING
        cr_errorhandler    = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK lr_config_alv_grid IS BOUND.
*   Assign the outtab.
    CHECK gr_outtab IS BOUND.
    ASSIGN gr_outtab->* TO <lt_outtab>.
    CHECK sy-subrc = 0.
*   Process the double_click.
    CALL METHOD lr_config_alv_grid->process_sysev_double_click
      EXPORTING
      i_row_idx           = i_row_idx
      i_fieldname_double_click = i_fieldname_double_click
      IMPORTING
        e_handled         = e_handled
        et_modi           = et_modi
        e_rc              = e_rc
      CHANGING
        ct_outtab         = <lt_outtab>
        cr_errorhandler   = cr_errorhandler.
  ENDDO.
  CHECK e_rc      = 0.
  CHECK e_handled = off.

* Now do own double_click processing.
  CALL METHOD process_sysev_double_click_int
    EXPORTING
      i_row_idx                = i_row_idx
      i_fieldname_double_click = i_fieldname_double_click
    IMPORTING
      e_handled                = e_handled
      et_modi                  = et_modi
      e_rc                     = e_rc
    CHANGING
      cr_errorhandler          = cr_errorhandler.

ENDMETHOD.


METHOD process_sysev_double_click_int .

* This method should be redefined in derived classes if needed.

  e_handled = off.
  e_rc      = 0.
  CLEAR et_modi.

ENDMETHOD.


METHOD process_sysev_hotspot_click .

  DATA: lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid.

  FIELD-SYMBOLS: <lt_outtab>  TYPE STANDARD TABLE.

* Initializations.
  e_rc      = 0.
  e_handled = off.
  CLEAR et_modi.

* Initial checking.
  CHECK NOT i_row_idx            IS INITIAL.
  CHECK NOT i_fieldname_hotspot  IS INITIAL.

* Let the configuration handle the hotspot_click.
  DO 1 TIMES.
*   Get the alv_grid config.
    CALL METHOD get_config_alv_grid
      IMPORTING
        er_config_alv_grid = lr_config_alv_grid
        e_rc               = e_rc
      CHANGING
        cr_errorhandler    = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK lr_config_alv_grid IS BOUND.
*   Assign the outtab.
    CHECK gr_outtab IS BOUND.
    ASSIGN gr_outtab->* TO <lt_outtab>.
    CHECK sy-subrc = 0.
*   Process the hotspot_click.
    CALL METHOD lr_config_alv_grid->process_sysev_hotspot_click
      EXPORTING
      i_row_idx           = i_row_idx
      i_fieldname_hotspot = i_fieldname_hotspot
      IMPORTING
        e_handled         = e_handled
        et_modi           = et_modi
        e_rc              = e_rc
      CHANGING
        ct_outtab         = <lt_outtab>
        cr_errorhandler   = cr_errorhandler.
  ENDDO.
  CHECK e_rc      = 0.
  CHECK e_handled = off.

* Now do own hotspot_click processing.
  CALL METHOD process_sysev_hotspot_click_in
    EXPORTING
      i_row_idx           = i_row_idx
      i_fieldname_hotspot = i_fieldname_hotspot
    IMPORTING
      e_handled           = e_handled
      et_modi             = et_modi
      e_rc                = e_rc
    CHANGING
      cr_errorhandler     = cr_errorhandler.

ENDMETHOD.


METHOD process_sysev_hotspot_click_in .

* This method should be redefined in derived classes if needed.

  e_handled = off.
  e_rc      = 0.
  CLEAR et_modi.

ENDMETHOD.


METHOD process_sysev_ucomm .

  DATA: lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid.

  FIELD-SYMBOLS: <lt_outtab>  TYPE STANDARD TABLE.

* Initializations.
  e_rc      = 0.
  e_handled = off.
  CLEAR et_modi.

* Initial checking.
  CHECK NOT i_ucomm IS INITIAL.

* Let the configuration handle the user_command.
  DO 1 TIMES.
*   Get the alv_grid config.
    CALL METHOD get_config_alv_grid
      IMPORTING
        er_config_alv_grid = lr_config_alv_grid
        e_rc               = e_rc
      CHANGING
        cr_errorhandler    = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK lr_config_alv_grid IS BOUND.
*   Assign the outtab.
    CHECK gr_outtab IS BOUND.
    ASSIGN gr_outtab->* TO <lt_outtab>.
    CHECK sy-subrc = 0.
*   Process the user_command.
    CALL METHOD lr_config_alv_grid->process_sysev_ucomm
      EXPORTING
        i_ucomm         = i_ucomm
      IMPORTING
        e_handled       = e_handled
        et_modi         = et_modi
        e_rc            = e_rc
      CHANGING
        ct_outtab       = <lt_outtab>
        cr_errorhandler = cr_errorhandler.
  ENDDO.
  CHECK e_rc      = 0.
  CHECK e_handled = off.

* Now do own user_command processing.
  CALL METHOD process_sysev_ucomm_internal
    EXPORTING
      i_ucomm         = i_ucomm
    IMPORTING
      e_handled       = e_handled
      et_modi         = et_modi
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD process_sysev_ucomm_internal .

* This method should be redefined by derived classes if needed.

ENDMETHOD.


METHOD process_user_command .

  DATA: l_original_ucomm    TYPE sy-ucomm,
        l_ucomm_handled     TYPE ish_on_off,
        lr_config_alv_grid  TYPE REF TO if_ish_config_alv_grid.

* Initializations.
  e_rc = 0.
  e_ucomm_handled = off.

* Get the original ucomm.
  l_original_ucomm = get_original_ucomm( i_ucomm ).

  CHECK NOT l_original_ucomm IS INITIAL.

* Let the configuration handle the user command.
  CALL METHOD get_config_alv_grid
    IMPORTING
      er_config_alv_grid = lr_config_alv_grid
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT lr_config_alv_grid IS INITIAL.
    CALL METHOD lr_config_alv_grid->process_user_command
      EXPORTING
        i_ucomm         = l_original_ucomm
      IMPORTING
        e_ucomm_handled = l_ucomm_handled
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Do own user command processing.
  IF l_ucomm_handled = off.
    CALL METHOD process_user_command_internal
      EXPORTING
        i_ucomm         = l_original_ucomm
      IMPORTING
        e_ucomm_handled = l_ucomm_handled
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Export.
  e_ucomm_handled = l_ucomm_handled.

ENDMETHOD.


METHOD process_user_command_internal .

* This method should be redefined by derived classes if needed.

ENDMETHOD.


METHOD refresh_grid.

  DATA: lr_alv_grid           TYPE REF TO cl_gui_alv_grid,
        lt_sort_tech          TYPE lvc_t_sort,
        lt_filter_tech        TYPE lvc_t_filt,
        l_filter_set          TYPE ish_on_off,
        ls_row_id             TYPE lvc_s_row,
        ls_col_id             TYPE lvc_s_col,
        l_rc                  TYPE ish_method_rc.

  FIELD-SYMBOLS: <lt_outtab>      TYPE STANDARD TABLE,
                 <ls_outtab>      TYPE ANY.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Processing can only be done if there is already an alv_grid.
  CHECK NOT gr_alv_grid IS INITIAL.

* Processing can only be done if the outtab is available.
  CHECK gr_outtab IS BOUND.

* Assign the outtab.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = 'SET_TABLE_FOR_FIRST_DISPLAY'
        i_mv3           = 'CL_GUI_ALV_GRID'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Handle i_refresh_drop_down_table.
  IF i_refresh_drop_down_table = on.
    CALL METHOD gr_alv_grid->set_drop_down_table
      EXPORTING
        it_drop_down_alias = gt_drop_down_alias.
  ENDIF.

* Handle i_refresh_fieldcat.
  IF i_refresh_fieldcat = on.
    CALL METHOD gr_alv_grid->set_frontend_fieldcatalog
      EXPORTING
        it_fieldcatalog = gt_fieldcat.
  ENDIF.

* Handle i_refresh_layout.
  IF i_refresh_layout = on OR
     g_layout_set     = on.
*   Reset the layout_set flag.
    g_layout_set = off.
*   Set the layout.
    CALL METHOD gr_alv_grid->set_frontend_layout
      EXPORTING
        is_layout = gs_layout.
  ENDIF.

* Handle i_refresh_variant.
  IF i_refresh_variant  = on OR
     g_variant_set      = on OR
     g_variant_save_set = on.
*   Reset the variant_set flags.
    g_variant_set      = off.
    g_variant_save_set = off.
*   Set the variant.
    CALL METHOD gr_alv_grid->set_variant
      EXPORTING
        is_variant = gs_variant
        i_save     = g_variant_save.
  ENDIF.

* Handle sort criteria.
  IF i_refresh_sort = on OR
     g_sort_set     = on.
*   Reset the sort_set flag.
    g_sort_set = off.
*   Get the technical sort criteria.
    lt_sort_tech = transform_to_technical_sort( gt_sort ).
*   Set the grid's sort criteria.
    CALL METHOD gr_alv_grid->set_sort_criteria
      EXPORTING
        it_sort                   = lt_sort_tech
      EXCEPTIONS
        no_fieldcatalog_available = 1
        OTHERS                    = 2.
    l_rc = sy-subrc.
*   Errorhandling.
    IF l_rc <> 0.
      e_rc = l_rc.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '030'
          i_mv1           = e_rc
          i_mv2           = 'SET_SORT_CRITERIA'
          i_mv3           = 'CL_GUI_ALV_GRID'
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.

* Handle filter criteria.
  IF i_refresh_filter = on OR
     g_filter_set     = on.
*   Reset the filter_set flag.
    g_filter_set = off.
*   Remember that the filter is set.
    l_filter_set = on.
*   On filter changes we have to actualize the filtermark.
    CALL METHOD actualize_filtermark.
*   Get the technical filter criteria.
    lt_filter_tech = transform_to_technical_filter( gt_filter ).
*   Set the grid's filter.
    CALL METHOD gr_alv_grid->set_filter_criteria
      EXPORTING
        it_filter                 = lt_filter_tech
      EXCEPTIONS
        no_fieldcatalog_available = 1
        OTHERS                    = 2.
    l_rc = sy-subrc.
*   Errorhandling.
    IF l_rc <> 0.
      e_rc = l_rc.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '030'
          i_mv1           = e_rc
          i_mv2           = 'SET_FILTER_CRITERIA'
          i_mv3           = 'CL_GUI_ALV_GRID'
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.

** CDuerr, MED-33778 - Begin
*  CALL METHOD gr_alv_grid->set_frontend_fieldcatalog
*    EXPORTING
*      it_fieldcatalog = gt_fieldcat[].
** CDuerr, MED-33778 - End

* refresh_table_display.
  CALL METHOD gr_alv_grid->refresh_table_display
    EXPORTING
      is_stable      = gs_refresh_stable
      i_soft_refresh = g_refresh_soft
    EXCEPTIONS
      finished       = 1
      OTHERS         = 2.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = 'REFRESH_TABLE_DISPLAY'
        i_mv3           = 'CL_GUI_ALV_GRID'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* On first_time or on filter changes the current cell
* might not fit the technical filter.
* Therefore we have to reset the default cursor position
* without setting the focus.
  IF g_first_time = on OR
     l_filter_set = on.
    CLEAR: ls_row_id,
           ls_col_id.
    IF g_first_time = off.
      CALL METHOD gr_alv_grid->get_current_cell
        IMPORTING
          es_row_id = ls_row_id
          es_col_id = ls_col_id.
    ENDIF.
    CALL METHOD intern_set_default_cursor
      EXPORTING
        i_set_focus     = off
        is_row_id       = ls_row_id
        is_col_id       = ls_col_id
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD remind_selected_rows.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  DATA:           lt_row_fieldval    TYPE ish_t_field_value,
                  l_rc               TYPE ish_method_rc.
  FIELD-SYMBOLS:  <l_row_fval>       TYPE rnfield_value.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
* initialize
  CLEAR gt_selected_rows.

  IF NOT cr_errorhandler IS BOUND.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* get selected rows
  CALL METHOD if_ish_scr_alv_grid~get_selected_row_fieldvals
    IMPORTING
      et_row_fieldval = lt_row_fieldval
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* remember the selection
  LOOP AT lt_row_fieldval ASSIGNING <l_row_fval>.
    CALL METHOD if_ish_scr_alv_grid~select_row
      EXPORTING
        i_row_fieldname = <l_row_fval>-fieldname
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDLOOP.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD set_alt_selected_rows.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  FIELD-SYMBOLS:
        <l_row>     TYPE ish_fieldname,
        <lt_outtab> TYPE STANDARD TABLE.

  DATA: l_idx       TYPE sy-index,
        l_rc        TYPE ish_method_rc.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
* initialize
  CLEAR l_idx.
  ASSIGN gr_outtab->* TO <lt_outtab>.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  LOOP AT gt_selected_rows ASSIGNING <l_row>.
*   get the index in outtab
    READ TABLE <lt_outtab> WITH KEY (g_fieldname_row_id) = <l_row>
      TRANSPORTING NO FIELDS.
    l_idx = sy-tabix.
*   do the alternative selection
    CALL METHOD gr_selector->do_selection
      EXPORTING
        i_row_idx       = l_idx
        i_fieldname     = <l_row>
        i_select        = on
      IMPORTING
        e_rc            = l_rc
      CHANGING
        ct_outtab       = <lt_outtab>
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDLOOP.
  e_rc = 0.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD set_cursor_internal.

* Special implementation for alv_grids.
* GS_MESSAGE-PARAMETER: row fieldname
* GS_MESSAGE-FIELD:     column fieldname
* G_SCR_CURSORFIELD:    The first part (until -) is the row fieldname,
*                       the second part is the column fieldname.

  DATA: ls_row_id             TYPE lvc_s_row,
        ls_col_id             TYPE lvc_s_col,
        l_row                 TYPE i,
        l_row_fieldname       TYPE ish_fieldname,
        l_col_fieldname       TYPE ish_fieldname,
        l_rc                  TYPE ish_method_rc.

* Process only if the alv_grid is available.
  CHECK NOT gs_parent-container IS INITIAL.
  CHECK NOT gr_alv_grid  IS INITIAL.

* Process only if we have cursor info.
  IF g_scr_cursorfield IS INITIAL AND
     gs_message        IS INITIAL.
    EXIT.
  ENDIF.

* Get the row and column fieldname.
  IF NOT g_scr_cursorfield IS INITIAL.
    SPLIT g_scr_cursorfield
        AT '-'
      INTO l_row_fieldname
           l_col_fieldname.
  ELSE.
    l_row_fieldname = gs_message-parameter.
    l_col_fieldname = gs_message-field.
  ENDIF.
  CHECK NOT l_row_fieldname IS INITIAL.
  CHECK NOT l_col_fieldname IS INITIAL.

* Build row_id and col_id.
  CALL METHOD get_row_index_by_fieldname
    EXPORTING
      i_row_fieldname = l_row_fieldname
    IMPORTING
      e_row           = l_row
      e_rc            = l_rc.
  CHECK l_rc = 0.
  CLEAR: ls_row_id,
         ls_col_id.
  ls_row_id-index     = l_row.
  ls_col_id-fieldname = l_col_fieldname.

* Set the cursor.
  CALL METHOD intern_set_default_cursor
    EXPORTING
      i_set_focus = on
      is_row_id   = ls_row_id
      is_col_id   = ls_col_id.

ENDMETHOD.


METHOD set_field_for_alt_selection.

* default implementation does nothing
  e_rc = 0.

ENDMETHOD.


METHOD set_grid_handlers.

* The default implementation sets the following handlers.
* Redefine this method in derived classes (and call the super method)
* if you have any specialities.

  DATA: l_rc  TYPE ish_method_rc.

* Process only if the alv_grid is available.
  CHECK NOT gr_alv_grid IS INITIAL.

* toolbar
  SET HANDLER handle_toolbar FOR gr_alv_grid
    ACTIVATION i_activation.

* menu_buttons
  SET HANDLER handle_menu_button FOR gr_alv_grid
    ACTIVATION i_activation.

* onf4
  SET HANDLER handle_onf4 FOR gr_alv_grid
    ACTIVATION i_activation.

* data_changed
  SET HANDLER handle_data_changed FOR gr_alv_grid
    ACTIVATION i_activation.

* data_changed_finished
  SET HANDLER handle_data_changed_finished FOR gr_alv_grid
    ACTIVATION i_activation.

* user_command
  SET HANDLER handle_user_command FOR gr_alv_grid
    ACTIVATION i_activation.

* button_click
  SET HANDLER handle_button_click FOR gr_alv_grid
    ACTIVATION i_activation.

* hotspot_click
  SET HANDLER handle_hotspot_click FOR gr_alv_grid
    ACTIVATION i_activation.

* double_click
  SET HANDLER handle_double_click FOR gr_alv_grid
    ACTIVATION i_activation.

* after_refresh
  SET HANDLER handle_after_refresh FOR gr_alv_grid
    ACTIVATION i_activation.

* before_user_command
  SET HANDLER handle_before_user_command FOR gr_alv_grid
    ACTIVATION i_activation.

* after_user_command
  SET HANDLER handle_after_user_command FOR gr_alv_grid
    ACTIVATION i_activation.

* context_menu_request
  SET HANDLER handle_context_menu_request FOR gr_alv_grid
    ACTIVATION i_activation.

* Print end of list
  SET HANDLER handle_print_end_of_list FOR gr_alv_grid
    ACTIVATION i_activation.

* Print end of page
  SET HANDLER handle_print_end_of_page FOR gr_alv_grid
    ACTIVATION i_activation.

* Print top of list
  SET HANDLER handle_print_top_of_list FOR gr_alv_grid
    ACTIVATION i_activation.

* Print top of page
  SET HANDLER handle_print_top_of_page FOR gr_alv_grid
    ACTIVATION i_activation.

* ondrag
  SET HANDLER handle_ondrag
    FOR gr_alv_grid
    ACTIVATION i_activation.

* ondrop
  SET HANDLER handle_ondrop
    FOR gr_alv_grid
    ACTIVATION i_activation.

* ondropcomplete
  SET HANDLER handle_ondropcomplete
    FOR gr_alv_grid
    ACTIVATION i_activation.

* ondropgetflavor
  SET HANDLER handle_ondropgetflavor
    FOR gr_alv_grid
    ACTIVATION i_activation.

* register_edit_event
  IF i_activation = on.
    CALL METHOD gr_alv_grid->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_enter
      EXCEPTIONS
        error      = 1
        OTHERS     = 2.
    l_rc = sy-subrc.
    IF l_rc <> 0.
      e_rc = l_rc.
*     Fehler & beim Aufruf der Methode & der Klasse &
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '030'
          i_mv1           = e_rc
          i_mv2           = 'REGISTER_EDIT_EVENT'
          i_mv3           = 'CL_GUI_ALV_GRID'
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD set_ok_code_after_f4.

* After processing f4 we have to remind the cursorfield
* and set a new ok_code.

  g_remind_cursorfield = on.

  CALL METHOD cl_gui_cfw=>set_new_ok_code
    EXPORTING
      new_code = 'TEST'.

ENDMETHOD.


METHOD set_selected_rows.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  DATA:  lr_alv_grid    TYPE REF TO cl_gui_alv_grid,
         l_rc           TYPE ish_method_rc,
         lt_index_rows  TYPE lvc_t_row,
         l_index_row    TYPE lvc_s_row.
  FIELD-SYMBOLS:
         <l_row>        TYPE ish_fieldname,
         <lt_outtab>    TYPE STANDARD TABLE.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
* initialize
  CLEAR lt_index_rows. REFRESH lt_index_rows.
  ASSIGN gr_outtab->* TO <lt_outtab>.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  CALL METHOD if_ish_scr_alv_grid~get_alv_grid
    IMPORTING
      er_alv_grid     = lr_alv_grid
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
* get the index in outtab
  LOOP AT gt_selected_rows ASSIGNING <l_row>.
    READ TABLE <lt_outtab>
      WITH KEY (g_fieldname_row_id) = <l_row> TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      CONTINUE.
    ENDIF.
    l_index_row-index = sy-tabix.
    APPEND l_index_row TO lt_index_rows.
  ENDLOOP.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
* select the rows in the alv-grid
  CALL METHOD lr_alv_grid->set_selected_rows
    EXPORTING
      it_index_rows = lt_index_rows.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD transform_to_technical_filter.

  DATA: l_changed  TYPE ish_on_off.

* Initializations.
  rt_technical_filter = it_frontend_filter.

* No filter -> ready.
  CHECK NOT it_frontend_filter IS INITIAL.

* Handle cellmerging filter criteria
  IF is_cellmerging_active( ) = on.
*   Let the cellmerger modify the filter.
    CALL METHOD gr_cellmerger->modify_filter
      IMPORTING
        e_changed         = l_changed
      CHANGING
        ct_filtercriteria = rt_technical_filter.
*   If the cellmerger changed the filter we have to
*   actualize the filtermark.
    IF l_changed = on.
      CALL METHOD actualize_filtermark
        EXPORTING
          it_filter = rt_technical_filter.
    ENDIF.
  ENDIF.

* Handle the filtermark.
  IF check_handle_filtermark( ) = on.
    rt_technical_filter = get_filtermark_filter( ).
  ENDIF.

ENDMETHOD.


METHOD transform_to_technical_sort.

  TYPES: BEGIN OF lty_sortfield,
           order      TYPE i,
           fieldname  TYPE ish_fieldname,
         END OF lty_sortfield.

  DATA: lt_sortfield        TYPE TABLE OF lty_sortfield,
        ls_sortfield        TYPE lty_sortfield,
        ls_sort             TYPE lvc_s_sort,
        l_idx               TYPE i,
        l_count_sortfields  TYPE i.

  FIELD-SYMBOLS: <ls_sortfield>  TYPE lty_sortfield,
                 <ls_sort>       TYPE lvc_s_sort.

* Initializations.
  rt_technical_sort = it_frontend_sort.

* Handle sortorder fields.
  DO 1 TIMES.
*   Initial checking.
    CHECK g_sortorder_is_changed > 0 OR
          g_sortorder_is_empty   > 0 OR
          g_sortorder_is_new     > 0.
*   Build lt_sortfield.
    IF g_sortorder_is_changed > 0 AND
       NOT g_fieldname_is_changed IS INITIAL.
      CLEAR ls_sortfield.
      ls_sortfield-order     = g_sortorder_is_changed.
      ls_sortfield-fieldname = g_fieldname_is_changed.
      APPEND ls_sortfield TO lt_sortfield.
    ENDIF.
    IF g_sortorder_is_empty > 0 AND
       NOT g_fieldname_is_empty IS INITIAL.
      CLEAR ls_sortfield.
      ls_sortfield-order     = g_sortorder_is_empty.
      ls_sortfield-fieldname = g_fieldname_is_empty.
      APPEND ls_sortfield TO lt_sortfield.
    ENDIF.
    IF g_sortorder_is_new > 0 AND
       NOT g_fieldname_is_new IS INITIAL.
      CLEAR ls_sortfield.
      ls_sortfield-order     = g_sortorder_is_new.
      ls_sortfield-fieldname = g_fieldname_is_new.
      APPEND ls_sortfield TO lt_sortfield.
    ENDIF.
    CHECK NOT lt_sortfield IS INITIAL.
    SORT lt_sortfield BY order DESCENDING.
*   Get the number of sortfields.
    l_count_sortfields = LINES( lt_sortfield ).
*   Increment the spos of the existing sort criteria.
    LOOP AT rt_technical_sort ASSIGNING <ls_sort>.
      <ls_sort>-spos = <ls_sort>-spos + l_count_sortfields.
    ENDLOOP.
*   Now append/change the technical sortfields.
    LOOP AT lt_sortfield ASSIGNING <ls_sortfield>.
      CLEAR ls_sort.
      ls_sort-spos      = <ls_sortfield>-order.
      ls_sort-fieldname = <ls_sortfield>-fieldname.
      ls_sort-up        = on.
      READ TABLE rt_technical_sort
        ASSIGNING <ls_sort>
        WITH KEY fieldname = <ls_sortfield>-fieldname
                 spos      = <ls_sortfield>-order.
      IF sy-subrc = 0.
        <ls_sort> = ls_sort.
      ELSE.
        APPEND ls_sort TO rt_technical_sort.
      ENDIF.
    ENDLOOP.
*   Now sort the sort criteria by spos.
    SORT rt_technical_sort BY spos.
*   Now recalculate the spos.
    l_idx = 0.
    LOOP AT rt_technical_sort ASSIGNING <ls_sort>.
      l_idx = l_idx + 1.
      <ls_sort>-spos = l_idx.
    ENDLOOP.
  ENDDO.

* Handle cellmerging sort criteria
  IF is_cellmerging_active( ) = on.
    CALL METHOD gr_cellmerger->modify_sort
      CHANGING
        ct_sortcriteria = rt_technical_sort.
  ENDIF.

ENDMETHOD.


METHOD transport_column_from_outtab.

* The default implementation transports every field.
* Redefine this method if you have special fields (e.g. key-fields,
* which must not be changed).

  FIELD-SYMBOLS: <l_value>      TYPE ANY,
                 <ls_fieldcat>  TYPE lvc_s_fcat.

* Assign the outtab value.
  ASSIGN COMPONENT cs_fieldval_col-fieldname
    OF STRUCTURE is_outtab
    TO <l_value>.
  e_rc = sy-subrc.
  CHECK e_rc = 0.

* check if field is a merge field
  CHECK is_cellmerging_active( cs_fieldval_col-fieldname ) = off.

* Get the data type of the outtab field.
  READ TABLE gt_fieldcat
    ASSIGNING <ls_fieldcat>
    WITH KEY fieldname = cs_fieldval_col-fieldname.
  CHECK sy-subrc = 0.

* Modify the column field value.
  CASE <ls_fieldcat>-inttype.
    WHEN 'v' OR    " deep struct
         'h' OR    " table
         'l'.      " data reference
*     These data types are not supported.
    WHEN 'r'.      " object reference
      cs_fieldval_col-object = <l_value>.
    WHEN OTHERS.   " single value
      cs_fieldval_col-value = <l_value>.
  ENDCASE.

ENDMETHOD.


METHOD transport_column_to_outtab.

* The default implementation transports every field.
* Redefine this method if you have special fields.

  DATA: l_enable  TYPE ish_on_off.

  FIELD-SYMBOLS: <l_value>      TYPE ANY.

* Initializations.
  e_rc = 0.

* Assign the outtab value.
  ASSIGN COMPONENT is_fieldval_col-fieldname
    OF STRUCTURE cs_outtab
    TO <l_value>.
  e_rc = sy-subrc.
  CHECK e_rc = 0.

* Modify the outtab value.
  CASE is_fieldval_col-type.
    WHEN co_fvtype_single.
      <l_value> = is_fieldval_col-value.
    WHEN OTHERS.
      CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
        <l_value> ?= is_fieldval_col-object.
      ENDCATCH.
      IF sy-subrc <> 0.
        CLEAR <l_value>.
      ENDIF.
  ENDCASE.

* En-/Disable the cell.
  IF is_fieldval_col-disabled = on.
    l_enable = off.
  ELSE.
    l_enable = on.
  ENDIF.
  CALL METHOD modify_cellstyle
    EXPORTING
      i_fieldname = is_fieldval_col-fieldname
      i_enable    = l_enable
    CHANGING
      cs_outtab   = cs_outtab.

ENDMETHOD.


METHOD transport_modified_cells.

  DATA: lt_modi          TYPE lvc_t_modi,
        l_row_idx        TYPE int4,
        l_fieldname      TYPE ish_fieldname,
        l_row_fieldname  TYPE ish_fieldname,
        ls_fv_row        TYPE rnfield_value,
        ls_fv_row_modi   TYPE rnfield_value,
        ls_fv_col        TYPE rnfield_value,
        lr_fv_row        TYPE REF TO cl_ish_field_values,
        lr_fv_row_modi   TYPE REF TO cl_ish_field_values,
        lt_fv_col        TYPE ish_t_field_value.

  FIELD-SYMBOLS: <ls_modi>   TYPE lvc_s_modi,
                 <lt_outtab> TYPE STANDARD TABLE,
                 <ls_outtab> TYPE any.
* Initializations.
  e_rc = 0.
  CLEAR et_modified_fv.

* Build lt_modi.
  lt_modi = it_modi.
  IF lt_modi IS INITIAL.
    lt_modi = gt_modified_cells.
  ENDIF.
  CHECK NOT lt_modi IS INITIAL.

* Sort lt_modi by row_id.
  SORT lt_modi BY row_id.

* Dereference gr_outtab
  CHECK gr_outtab IS BOUND.
  ASSIGN gr_outtab->* TO <lt_outtab>.
  CHECK sy-subrc = 0.

* Process the modified cells.
  CLEAR: l_row_idx.
  LOOP AT lt_modi ASSIGNING <ls_modi>.
    IF l_row_idx <> <ls_modi>-row_id.
      CLEAR lr_fv_row.
*     Get the corresponding row fieldname.
      CALL METHOD get_row_fieldname_by_index
        EXPORTING
          i_row           = <ls_modi>-row_id
        IMPORTING
          e_row_fieldname = l_row_fieldname
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
      CHECK NOT l_row_fieldname IS INITIAL.
*     Get the corresponding row fieldval object.
      CALL METHOD get_row_fieldval
        EXPORTING
          i_row_fieldname = l_row_fieldname
          i_only_modified = off
        IMPORTING
          es_row_fieldval = ls_fv_row
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
      CHECK NOT ls_fv_row IS INITIAL.
      CHECK NOT ls_fv_row-object IS INITIAL.
      lr_fv_row ?= ls_fv_row-object.
*     Get the corresponding outtab entry.
      READ TABLE <lt_outtab>
        ASSIGNING <ls_outtab>
        INDEX <ls_modi>-row_id.
      CHECK sy-subrc = 0.
*     Add the row to et_modified_fv.
      IF et_modified_fv IS SUPPLIED.
        ls_fv_row_modi = ls_fv_row.
        CLEAR ls_fv_row_modi-object.
        CALL METHOD cl_ish_field_values=>create
          IMPORTING
            e_instance     = lr_fv_row_modi
            e_rc           = e_rc
          CHANGING
            c_errorhandler = cr_errorhandler.
        IF e_rc <> 0.
          EXIT.
        ENDIF.
        ls_fv_row_modi-object = lr_fv_row_modi.
        APPEND ls_fv_row_modi TO et_modified_fv.
      ENDIF.
*     Actualize l_row_idx.
      l_row_idx = <ls_modi>-row_id.
    ENDIF.
    CHECK lr_fv_row IS BOUND.
*   Get the corresponding cell fieldval.
    l_fieldname = <ls_modi>-fieldname.
    CALL METHOD lr_fv_row->get_data
      EXPORTING
        i_fieldname    = l_fieldname
      IMPORTING
        e_field_value  = ls_fv_col
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    CHECK NOT ls_fv_col IS INITIAL.
*   Transport the column.
    CALL METHOD transport_column_from_outtab
      EXPORTING
        ir_fieldval_row = lr_fv_row
        is_outtab       = <ls_outtab>
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cs_fieldval_col = ls_fv_col
        cr_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
*   Set the column fieldval.
    CALL METHOD lr_fv_row->set_data
      EXPORTING
        i_field_value  = ls_fv_col
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
*   Add the column to et_modified_fv.
    IF lr_fv_row_modi IS BOUND.
      CALL METHOD lr_fv_row_modi->set_data
        EXPORTING
          i_field_value  = ls_fv_col
        IMPORTING
          e_rc           = e_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD transport_row_from_outtab.

  DATA: lr_fv_row    TYPE REF TO cl_ish_field_values,
        lt_fv_col    TYPE ish_t_field_value,
        ls_fv_col    TYPE rnfield_value,
        l_rc         TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fv_col>      TYPE rnfield_value.

* Initializations.
  e_rc = 0.

* Check cs_fieldval_row.
  CHECK NOT cs_fieldval_row-object IS INITIAL.
  CHECK cs_fieldval_row-type = co_fvtype_fv.

* Get the column field values.
  lr_fv_row ?= cs_fieldval_row-object.
  CALL METHOD lr_fv_row->get_data
    IMPORTING
      et_field_values = lt_fv_col
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Clear the messagetype of the row.
  CLEAR cs_fieldval_row-msgtype.

* Process each column.
  LOOP AT lt_fv_col ASSIGNING <ls_fv_col>.
*   Clear the messagetype of the column.
    CLEAR <ls_fv_col>-msgtype.
*   Transport column.
    CALL METHOD transport_column_from_outtab
      EXPORTING
        ir_fieldval_row = lr_fv_row
        is_outtab       = is_outtab
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cs_fieldval_col = <ls_fv_col>
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

* Modify the row.
  CALL METHOD lr_fv_row->set_data
    EXPORTING
      it_field_values = lt_fv_col
    IMPORTING
      e_rc            = l_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Now transport the button fields.
  IF NOT gr_buttonhandler IS INITIAL.
    gr_buttonhandler->finalize_row( ir_row_fieldval = lr_fv_row
                                    is_outtab       = is_outtab ).
  ENDIF.

* Now transport the listbox fields.
  IF NOT gr_listboxhandler IS INITIAL.
    gr_listboxhandler->finalize_row( ir_row_fieldval = lr_fv_row
                                     is_outtab       = is_outtab ).
  ENDIF.

ENDMETHOD.


METHOD transport_row_to_outtab.

  DATA: lr_fv_row    TYPE REF TO cl_ish_field_values,
        lt_fv_col    TYPE ish_t_field_value,
        ls_fv_col    TYPE rnfield_value,
        l_rc         TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fv_col>  TYPE rnfield_value.

* Initializations.
  e_rc = 0.

* Check is_fieldval_row.
  CHECK NOT is_fieldval_row-object IS INITIAL.
  CHECK is_fieldval_row-type = co_fvtype_fv.

* Get the column field values.
  lr_fv_row ?= is_fieldval_row-object.
  CALL METHOD lr_fv_row->get_data
    IMPORTING
      et_field_values = lt_fv_col
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Process each column.
  LOOP AT lt_fv_col ASSIGNING <ls_fv_col>.
*   On row disabling we have to disable every cell.
    IF is_fieldval_row-disabled = on.
      <ls_fv_col>-disabled = on.
    ENDIF.
*   Transport column.
    CALL METHOD transport_column_to_outtab
      EXPORTING
        ir_fieldval_row = lr_fv_row
        is_fieldval_col = <ls_fv_col>
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cs_outtab       = cs_outtab
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

* Now process the row's button fields.
  IF gr_buttonhandler IS BOUND.
    CALL METHOD gr_buttonhandler->finalize_outtab_entry
      CHANGING
        cs_outtab = cs_outtab.
  ENDIF.

* Listboxfields are handled separately in create_all_listboxes.

* Now process the cellmerging
  IF gr_cellmerger IS BOUND.
    CALL METHOD gr_cellmerger->finalize_outtab_entry
      CHANGING
        cs_outtab = cs_outtab.
  ENDIF.

ENDMETHOD.
ENDCLASS.
