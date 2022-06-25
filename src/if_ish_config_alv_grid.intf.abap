*"* components of interface IF_ISH_CONFIG_ALV_GRID
interface IF_ISH_CONFIG_ALV_GRID
  public .


  interfaces IF_ISH_IDENTIFY_OBJECT .

  methods DESTROY
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_MENU_BUTTON
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID
    changing
      !CR_CTMENU type ref to CL_CTMENU optional
      !C_UCOMM type SY-UCOMM optional .
  methods PROCESS_BUTTON_CLICK
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_COL_FIELDNAME type ISH_FIELDNAME
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_DOUBLE_CLICK
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
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_COL_FIELDNAME type ISH_FIELDNAME
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_PRINT_TOP_OF_PAGE
    importing
      !I_TABLE_INDEX type SYINDEX
      !I_SCREEN type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_HANDLED type ISH_ON_OFF .
  methods PROCESS_PRINT_TOP_OF_LIST
    importing
      !I_SCREEN type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_HANDLED type ISH_ON_OFF .
  methods PROCESS_PRINT_END_OF_PAGE
    importing
      !I_SCREEN type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_HANDLED type ISH_ON_OFF .
  methods PROCESS_PRINT_END_OF_LIST
    importing
      !I_SCREEN type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_HANDLED type ISH_ON_OFF .
  methods PROCESS_SYSEV_BUTTON_CLICK
    importing
      !I_ROW_IDX type INT4
      !I_FIELDNAME_BUTTON type ISH_FIELDNAME
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CT_OUTTAB type STANDARD TABLE
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
      !CT_OUTTAB type STANDARD TABLE
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
      !CT_OUTTAB type STANDARD TABLE
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_UCOMM
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CT_OUTTAB type STANDARD TABLE
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_USER_COMMAND
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_EXCL_FUNC
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_EXCL_FUNC_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CT_EXCL_FUNC type UI_FUNCTIONS
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_F4
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_F4_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CT_F4 type LVC_T_F4
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_FIELDCAT
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_FIELDCAT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CT_FIELDCAT type LVC_T_FCAT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_FILTER
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_FILTER_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CT_FILTER type LVC_T_FILT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_LAYOUT
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_LAYOUT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CS_LAYOUT type LVC_S_LAYO
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_REFRESH_INFO
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_REFRESH_INFO_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CS_REFRESH_STABLE type LVC_S_STBL
      !C_REFRESH_SOFT type CHAR01
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_SORT
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_SORT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CT_SORT type LVC_T_SORT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_GRID_TOOLBAR
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID
    changing
      !CR_TOOLBAR type ref to CL_ALV_EVENT_TOOLBAR_SET optional
      !C_INTERACTIVE type CHAR01 optional .
  methods BUILD_GRID_VARIANT
    importing
      !IR_SCR_ALV_GRID type ref to IF_ISH_SCR_ALV_GRID
    exporting
      !E_VARIANT_CHANGED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CS_VARIANT type DISVARIANT
      !C_VARIANT_SAVE type CHAR1
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods ADD_MERGE_FIELDS
    exporting
      value(ET_FIELDS) type ISH_T_MERGE_FIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_FIELD_FOR_ALT_SELECTION
    exporting
      value(E_SELFIELD) type FDNAME
      value(E_GROUPFIELD) type FDNAME
      value(E_MARK_GROUP) type ISH_ON_OFF
      value(E_MARK_SINGLE) type ISH_ON_OFF
      value(ER_CELLMERGER) type ref to CL_ISH_GRID_CELLMERGER
      value(ER_SCREEN) type ref to CL_ISH_SCR_ALV_GRID
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_ONDRAG
    importing
      !IR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT
      !IR_DND_SOURCE type ref to CL_ISH_DND_GRID
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_ONDROP
    importing
      !IR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT
      !IR_DND_SOURCE type ref to CL_ISH_DND
      !IR_DND_TARGET type ref to CL_ISH_DND_GRID
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_ONDROPCOMPLETE
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
    importing
      !IR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT
      !IR_DND_SOURCE type ref to CL_ISH_DND
      !IR_DND_TARGET type ref to CL_ISH_DND_GRID
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CLONE
    returning
      value(RR_CONFIG) type ref to IF_ISH_CONFIG_ALV_GRID .
  methods COPY
    returning
      value(RR_CONFIG) type ref to IF_ISH_CONFIG_ALV_GRID .
endinterface.
