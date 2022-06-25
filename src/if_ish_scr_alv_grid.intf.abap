*"* components of interface IF_ISH_SCR_ALV_GRID
interface IF_ISH_SCR_ALV_GRID
  public .


  interfaces IF_ISH_SCR_CONTROL .

  aliases BUILD_UCOMM
    for IF_ISH_SCR_CONTROL~BUILD_UCOMM .
  aliases GET_CONTAINER
    for IF_ISH_SCR_CONTROL~GET_CONTAINER .
  aliases GET_ORIGINAL_UCOMM
    for IF_ISH_SCR_CONTROL~GET_ORIGINAL_UCOMM .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_DRAGDROP_SUPPORTED
    for IF_ISH_SCR_CONTROL~IS_DRAGDROP_SUPPORTED .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases IS_UCOMM_SUPPORTED
    for IF_ISH_SCR_CONTROL~IS_UCOMM_SUPPORTED .
  aliases SUPPORT_DRAGDROP
    for IF_ISH_SCR_CONTROL~SUPPORT_DRAGDROP .

  constants CO_UCOMM_DOUBLE_CLICK type SY-UCOMM value 'DOUBLE_CLICK'. "#EC NOTEXT
  constants CO_UCOMM_HOTSPOT_CLICK type SY-UCOMM value 'HOTSPOT_CLICK'. "#EC NOTEXT
  constants CO_UCOMM_BUTTON_CLICK type SY-UCOMM value 'BUTTON_CLICK'. "#EC NOTEXT
  constants CO_UCOMM_ONDRAG type SY-UCOMM value 'ONDRAG'. "#EC NOTEXT
  constants CO_UCOMM_ONDROP type SY-UCOMM value 'ONDROP'. "#EC NOTEXT
  constants CO_UCOMM_ONDROPCOMPLETE type SY-UCOMM value 'ONDROPCOMPLETE'. "#EC NOTEXT
  constants CO_UCOMM_ONDROPGETFLAVOR type SY-UCOMM value 'ONDROPGETFLAVOR'. "#EC NOTEXT

  events EV_BAD_CELLS .

  methods APPEND_ROW
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME optional
      !IT_COL_FIELDVAL type ISH_T_FIELD_VALUE optional
    exporting
      !ES_ROW_FIELDVAL type RNFIELD_VALUE
      !ET_COL_FIELDVAL type ISH_T_FIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_UCOMM_ROW_COL
    importing
      !I_ORIGINAL_UCOMM type SY-UCOMM
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_COL_FIELDNAME type ISH_FIELDNAME
    exporting
      value(E_UCOMM) type SY-UCOMM .
  methods DELECT_ROW
    importing
      value(I_ROW_FIELDNAME) type ISH_FIELDNAME
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CR_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DELECT_ROWS
    importing
      value(IT_ROW_FIELDNAME) type ISH_T_FIELDNAME
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CR_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DISABLE_CELL
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_COL_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_DISABLED) type ISH_ON_OFF .
  methods DISABLE_ROW
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_DISABLED) type ISH_ON_OFF .
  methods ENABLE_CELL
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_COL_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_ENABLED) type ISH_ON_OFF .
  methods ENABLE_ROW
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_ENABLED) type ISH_ON_OFF .
  methods GET_ALLOW_NEW_ROWS
    returning
      value(R_ALLOW_NEW_ROWS) type ISH_ON_OFF .
  methods GET_ALV_GRID
    importing
      !I_CREATE type ISH_ON_OFF default 'X'
    exporting
      !ER_ALV_GRID type ref to CL_GUI_ALV_GRID
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CELL_FIELDVAL
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_COL_FIELDNAME type ISH_FIELDNAME
      !I_ONLY_MODIFIED type ISH_ON_OFF default SPACE
    exporting
      !ES_ROW_FIELDVAL type RNFIELD_VALUE
      !ES_COL_FIELDVAL type RNFIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_COLUMN_FIELDVALS
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !IT_COL_FIELDNAME type ISH_T_FIELDNAME optional
      !I_ONLY_MODIFIED type ISH_ON_OFF default SPACE
    exporting
      !ES_ROW_FIELDVAL type RNFIELD_VALUE
      !ET_COL_FIELDVAL type ISH_T_FIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CONFIG_ALV_GRID
    exporting
      !ER_CONFIG_ALV_GRID type ref to IF_ISH_CONFIG_ALV_GRID
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CURRENT_CELL_FIELDVAL
    exporting
      !ES_ROW_FIELDVAL type RNFIELD_VALUE
      !ES_COL_FIELDVAL type RNFIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_FIELDCAT
    importing
      !I_BUILD type ISH_ON_OFF optional
    returning
      value(RT_FIELDCAT) type LVC_T_FCAT .
  methods GET_FILTER
    returning
      value(RT_FILTER) type LVC_T_FILT .
  methods GET_LAYOUT
    returning
      value(RS_LAYOUT) type LVC_S_LAYO .
  methods GET_REMIND_SELECTED_ROWS
    returning
      value(I_REMIND_SEL) type ISH_ON_OFF .
  methods GET_ROW_FIELDVAL
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_ONLY_MODIFIED type ISH_ON_OFF default SPACE
    exporting
      !ES_ROW_FIELDVAL type RNFIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ROW_FIELDVALS
    importing
      !IT_ROW_FIELDNAME type ISH_T_FIELDNAME optional
      !I_ONLY_MODIFIED type ISH_ON_OFF default SPACE
    exporting
      !ET_ROW_FIELDVAL type ISH_T_FIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ROW_FIELDVAL_OBJECT
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_ONLY_MODIFIED type ISH_ON_OFF default SPACE
    exporting
      !ER_ROW_FIELDVAL type ref to CL_ISH_FIELD_VALUES
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ROW_FIELDVAL_OBJECTS
    importing
      !IT_ROW_FIELDNAME type ISH_T_FIELDNAME optional
      !I_ONLY_MODIFIED type ISH_ON_OFF default SPACE
    exporting
      !ET_ROW_FIELDVAL_OBJECT type ISH_T_FIELD_VALUE_OBJECT
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SELECTED_ROW_FIELDVAL
    importing
      !I_MSGTY_ON_FALSE_SELECTION type SY-MSGTY default SPACE
      !I_RC_ON_FALSE_SELECTION type ISH_METHOD_RC default 0
    exporting
      !ES_ROW_FIELDVAL type RNFIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SELECTED_ROW_FIELDVALS
    importing
      !I_MSGTY_ON_FALSE_SELECTION type SY-MSGTY default SPACE
      !I_RC_ON_FALSE_SELECTION type ISH_METHOD_RC default 0
    exporting
      !ET_ROW_FIELDVAL type ISH_T_FIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SORT
    returning
      value(RT_SORT) type LVC_T_SORT .
  methods GET_TOOLBAR_FUNCTIONS
    exporting
      !ET_BUTTON type ISH_T_V_NWBUTTON
      !ET_FVARP type ISH_T_V_NWFVARP .
  methods GET_TOOLBAR_FVAR
    exporting
      !E_VIEWTYPE type NVIEWTYPE
      !E_FVARID type NFVARID .
  methods GET_UCOMM_COL
    importing
      !I_UCOMM type SY-UCOMM
    returning
      value(R_COL_FIELDNAME) type ISH_FIELDNAME .
  methods GET_UCOMM_ROW
    importing
      !I_UCOMM type SY-UCOMM
    returning
      value(R_ROW_FIELDNAME) type ISH_FIELDNAME .
  methods GET_VARIANT
    exporting
      !ES_VARIANT type DISVARIANT
      !E_VARIANT_SAVE type CHAR1 .
  methods IS_CELL_ENABLED
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !I_COL_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_ENABLED) type ISH_ON_OFF .
  methods IS_ROW_ENABLED
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_ENABLED) type ISH_ON_OFF .
  methods REMOVE_ROW
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
    exporting
      !ES_ROW_FIELDVAL type RNFIELD_VALUE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SELECT_ROW
    importing
      value(I_ROW_FIELDNAME) type ISH_FIELDNAME
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CR_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SELECT_ROWS
    importing
      value(IT_ROW_FIELDNAME) type ISH_T_FIELDNAME
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CR_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_ALLOW_NEW_ROWS
    importing
      !I_ALLOW_NEW_ROWS type ISH_ON_OFF default 'X' .
  methods SET_CELL_FIELDVAL
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !IS_COL_FIELDVAL type RNFIELD_VALUE
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_COLUMN_FIELDVALS
    importing
      !I_ROW_FIELDNAME type ISH_FIELDNAME
      !IT_COL_FIELDVAL type ISH_T_FIELD_VALUE
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEFAULT_CURSOR
    importing
      !I_SET_FOCUS type ISH_ON_OFF default SPACE
    exporting
      !E_CURSOR_SET type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_FILTER
    importing
      !IT_FILTER type LVC_T_FILT .
  methods SET_LAYOUT
    importing
      !IS_LAYOUT type LVC_S_LAYO .
  methods SET_REMIND_SELECTED_ROWS
    importing
      value(I_REMIND_SEL) type ISH_ON_OFF .
  methods SET_SORT
    importing
      !IT_SORT type LVC_T_SORT .
  methods SET_TOOLBAR_FUNCTIONS
    importing
      !IT_BUTTON type ISH_T_V_NWBUTTON
      !IT_FVARP type ISH_T_V_NWFVARP optional .
  methods SET_TOOLBAR_FVAR
    importing
      !I_VIEWTYPE type NVIEWTYPE
      !I_FVARID type NFVARID
      !IT_BUTTON type ISH_T_V_NWBUTTON optional
      !IT_FVARP type ISH_T_V_NWFVARP optional .
  methods SET_VARIANT
    importing
      !IS_VARIANT type DISVARIANT
      !I_VARIANT_X type ISH_ON_OFF
      !I_VARIANT_SAVE type CHAR1
      !I_VARIANT_SAVE_X type ISH_ON_OFF .
endinterface.
