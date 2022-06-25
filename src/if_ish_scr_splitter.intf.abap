*"* components of interface IF_ISH_SCR_SPLITTER
interface IF_ISH_SCR_SPLITTER
  public .


  interfaces IF_ISH_SCR_CONTROL .

  aliases CO_FVTYPE_FV
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_FV .
  aliases CO_FVTYPE_IDENTIFY
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_IDENTIFY .
  aliases CO_FVTYPE_SCREEN
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_SCREEN .
  aliases CO_FVTYPE_SINGLE
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_SINGLE .
  aliases CO_UCOMM_SCR_HELP_REQUEST
    for IF_ISH_SCREEN~CO_UCOMM_SCR_HELP_REQUEST .
  aliases CO_UCOMM_SCR_SAVE
    for IF_ISH_SCREEN~CO_UCOMM_SCR_SAVE .
  aliases CREATE_ALL_LISTBOXES
    for IF_ISH_SCREEN~CREATE_ALL_LISTBOXES .
  aliases CREATE_LISTBOX
    for IF_ISH_SCREEN~CREATE_LISTBOX .
  aliases DELETE_EMPTY_LINES
    for IF_ISH_SCREEN~DELETE_EMPTY_LINES .
  aliases DESTROY
    for IF_ISH_SCREEN~DESTROY .
  aliases GET_ACTIVE_TABSTRIP
    for IF_ISH_SCREEN~GET_ACTIVE_TABSTRIP .
  aliases GET_CALLER
    for IF_ISH_SCREEN~GET_CALLER .
  aliases GET_CONFIG
    for IF_ISH_SCREEN~GET_CONFIG .
  aliases GET_CONTAINER
    for IF_ISH_SCR_CONTROL~GET_CONTAINER .
  aliases GET_CURSORFIELD
    for IF_ISH_SCREEN~GET_CURSORFIELD .
  aliases GET_DATA
    for IF_ISH_SCREEN~GET_DATA .
  aliases GET_DEFAULT_CURSORFIELD
    for IF_ISH_SCREEN~GET_DEFAULT_CURSORFIELD .
  aliases GET_DEF_CRS_POSSIBLE
    for IF_ISH_SCREEN~GET_DEF_CRS_POSSIBLE .
  aliases GET_DYNPRO_HEADER
    for IF_ISH_SCREEN~GET_DYNPRO_HEADER .
  aliases GET_DYNPRO_HEADER_COLUMNS
    for IF_ISH_SCREEN~GET_DYNPRO_HEADER_COLUMNS .
  aliases GET_ENVIRONMENT
    for IF_ISH_SCREEN~GET_ENVIRONMENT .
  aliases GET_FIELDS
    for IF_ISH_SCREEN~GET_FIELDS .
  aliases GET_FIELDS_CHANGEABLE
    for IF_ISH_SCREEN~GET_FIELDS_CHANGEABLE .
  aliases GET_FIELDS_DEFINITION
    for IF_ISH_SCREEN~GET_FIELDS_DEFINITION .
  aliases GET_FIELDS_VALUE
    for IF_ISH_SCREEN~GET_FIELDS_VALUE .
  aliases GET_HANDLE_MANDATORY_FIELDS
    for IF_ISH_SCREEN~GET_HANDLE_MANDATORY_FIELDS .
  aliases GET_LOCK
    for IF_ISH_SCREEN~GET_LOCK .
  aliases GET_MAIN_OBJECT
    for IF_ISH_SCREEN~GET_MAIN_OBJECT .
  aliases GET_PARENT
    for IF_ISH_SCREEN~GET_PARENT .
  aliases GET_SCRMOD_BY_FIELDNAME
    for IF_ISH_SCREEN~GET_SCRMOD_BY_FIELDNAME .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases GET_T_SCRMOD
    for IF_ISH_SCREEN~GET_T_SCRMOD .
  aliases GET_T_SCRM_FIELD
    for IF_ISH_SCREEN~GET_T_SCRM_FIELD .
  aliases GET_USE_TNDYM_CURSOR
    for IF_ISH_SCREEN~GET_USE_TNDYM_CURSOR .
  aliases HELP_REQUEST
    for IF_ISH_SCREEN~HELP_REQUEST .
  aliases INITIALIZE
    for IF_ISH_SCREEN~INITIALIZE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_FIELD_CHANGED
    for IF_ISH_SCREEN~IS_FIELD_CHANGED .
  aliases IS_FIELD_INITIAL
    for IF_ISH_SCREEN~IS_FIELD_INITIAL .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases MODIFY_SCREEN
    for IF_ISH_SCREEN~MODIFY_SCREEN .
  aliases OK_CODE_SCREEN
    for IF_ISH_SCREEN~OK_CODE_SCREEN .
  aliases PROCESS_AFTER_INPUT
    for IF_ISH_SCREEN~PROCESS_AFTER_INPUT .
  aliases PROCESS_BEFORE_OUTPUT
    for IF_ISH_SCREEN~PROCESS_BEFORE_OUTPUT .
  aliases RAISE_EV_ERROR
    for IF_ISH_SCREEN~RAISE_EV_ERROR .
  aliases RAISE_EV_USER_COMMAND
    for IF_ISH_SCREEN~RAISE_EV_USER_COMMAND .
  aliases REMIND_CURSORFIELD
    for IF_ISH_SCREEN~REMIND_CURSORFIELD .
  aliases SET_ACTIVE_TABSTRIP
    for IF_ISH_SCREEN~SET_ACTIVE_TABSTRIP .
  aliases SET_CALLER
    for IF_ISH_SCREEN~SET_CALLER .
  aliases SET_CONFIG
    for IF_ISH_SCREEN~SET_CONFIG .
  aliases SET_CURSOR
    for IF_ISH_SCREEN~SET_CURSOR .
  aliases SET_CURSORFIELD
    for IF_ISH_SCREEN~SET_CURSORFIELD .
  aliases SET_DATA
    for IF_ISH_SCREEN~SET_DATA .
  aliases SET_DATA_FROM_FIELDVAL
    for IF_ISH_SCREEN~SET_DATA_FROM_FIELDVAL .
  aliases SET_ENVIRONMENT
    for IF_ISH_SCREEN~SET_ENVIRONMENT .
  aliases SET_EV_USER_COMMAND_RESULT
    for IF_ISH_SCREEN~SET_EV_USER_COMMAND_RESULT .
  aliases SET_FIELDS
    for IF_ISH_SCREEN~SET_FIELDS .
  aliases SET_FIELDS_OLD
    for IF_ISH_SCREEN~SET_FIELDS_OLD .
  aliases SET_FIELDVAL_FROM_DATA
    for IF_ISH_SCREEN~SET_FIELDVAL_FROM_DATA .
  aliases SET_FIRST_TIME
    for IF_ISH_SCREEN~SET_FIRST_TIME .
  aliases SET_HANDLE_MANDATORY_FIELDS
    for IF_ISH_SCREEN~SET_HANDLE_MANDATORY_FIELDS .
  aliases SET_INSTANCE_FOR_DISPLAY
    for IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY .
  aliases SET_LOCK
    for IF_ISH_SCREEN~SET_LOCK .
  aliases SET_MAIN_OBJECT
    for IF_ISH_SCREEN~SET_MAIN_OBJECT .
  aliases SET_PARENT
    for IF_ISH_SCREEN~SET_PARENT .
  aliases SET_USE_TNDYM_CURSOR
    for IF_ISH_SCREEN~SET_USE_TNDYM_CURSOR .
  aliases TRANSPORT_FROM_DY
    for IF_ISH_SCREEN~TRANSPORT_FROM_DY .
  aliases TRANSPORT_TO_DY
    for IF_ISH_SCREEN~TRANSPORT_TO_DY .
  aliases VALUE_REQUEST
    for IF_ISH_SCREEN~VALUE_REQUEST .
  aliases EV_CLEAR_ALL_CURSORFIELDS
    for IF_ISH_SCREEN~EV_CLEAR_ALL_CURSORFIELDS .
  aliases EV_DATA_CHANGED_AT_OKCODE
    for IF_ISH_SCREEN~EV_DATA_CHANGED_AT_OKCODE .
  aliases EV_ERROR
    for IF_ISH_SCREEN~EV_ERROR .
  aliases EV_USER_COMMAND
    for IF_ISH_SCREEN~EV_USER_COMMAND .

  class CL_GUI_SPLITTER_CONTAINER definition load .
  constants CO_MODE_ABSOLUTE type I value CL_GUI_SPLITTER_CONTAINER=>MODE_ABSOLUTE. "#EC NOTEXT
  constants CO_MODE_RELATIVE type I value CL_GUI_SPLITTER_CONTAINER=>MODE_RELATIVE. "#EC NOTEXT

  class-methods BUILD_FIELDNAME_FROM_CELL
    importing
      value(I_ROW) type I
      value(I_COL) type I
    exporting
      value(E_FIELDNAME) type ISH_FIELDNAME .
  class-methods BUILD_CELL_FROM_FIELDNAME
    importing
      value(I_FIELDNAME) type ISH_FIELDNAME
    exporting
      value(E_COL) type I
      value(E_ROW) type I .
  methods GET_ALIAS_NAME
    returning
      value(R_ALIAS_NAME) type CHAR14 .
  methods GET_BORDER
    exporting
      value(E_SHOW_BORDER) type ISH_ON_OFF
      value(E_SHOW_BORDER_X) type BAPIUPDATE
      value(E_SHOW_BORDER_CNTL) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CELL_CONTAINER
    importing
      value(I_CREATE) type ISH_ON_OFF default 'X'
      value(I_ROW) type I
      value(I_COL) type I
    exporting
      !ER_CELL_CONTAINER type ref to CL_GUI_CONTAINER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CELL_FIELDVAL
    importing
      value(I_ROW) type I
      value(I_COL) type I
    exporting
      value(ES_CELL_FIELDVAL) type RNFIELD_VALUE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CELL_SCREEN
    importing
      value(I_ROW) type I
      value(I_COL) type I
      value(I_ONLY_VISIBLE) type ISH_ON_OFF default SPACE
    exporting
      !ER_SCREEN type ref to IF_ISH_SCR_CONTROL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_COLUMN_MODE
    exporting
      value(E_MODE) type I
      value(E_MODE_X) type BAPIUPDATE
      value(E_MODE_CNTL) type I
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_COLUMN_PROPERTIES
    importing
      value(I_COL) type I
      value(I_FORCE_CNTL) type ISH_ON_OFF default SPACE
    exporting
      !ES_SPLITPROP_COL_X type RN1_SPLITPROP_COL_X
      !ES_SPLITPROP_COL_CNTL type RN1_SPLITPROP_COL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_COLUMN_SASH_MOVABLE
    importing
      value(I_COL) type I
      value(I_FORCE_CNTL) type ISH_ON_OFF default SPACE
    exporting
      value(E_MOVABLE) type ISH_ON_OFF
      value(E_MOVABLE_X) type RN1_SPLITPROP_COL_X-SASH_MOVABLE_X
      value(E_MOVABLE_CNTL) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_COLUMN_SASH_VISIBLE
    importing
      value(I_COL) type I
      value(I_FORCE_CNTL) type ISH_ON_OFF default SPACE
    exporting
      value(E_VISIBLE) type ISH_ON_OFF
      value(E_VISIBLE_X) type BAPIUPDATE
      value(E_VISIBLE_CNTL) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_COLUMN_VISIBLE
    importing
      value(I_COL) type I
    exporting
      value(E_VISIBLE) type ISH_ON_OFF
      value(E_VISIBLE_X) type BAPIUPDATE
      value(E_VISIBLE_CNTL) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_COLUMN_WIDTH
    importing
      value(I_COL) type I
      value(I_FORCE_CNTL) type ISH_ON_OFF default SPACE
    exporting
      value(E_WIDTH) type I
      value(E_WIDTH_X) type BAPIUPDATE
      value(E_WIDTH_CNTL) type I
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_COMMON_PROPERTIES
    exporting
      !ES_SPLITPROP_X type RN1_SPLITPROP_X
      !ES_SPLITPROP_CNTL type RN1_SPLITPROP
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CONFIG_SPLITTER
    exporting
      value(ER_CONFIG_SPLITTER) type ref to IF_ISH_CONFIG_SPLITTER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DEF_BORDER
    returning
      value(R_SHOW_BORDER) type ISH_ON_OFF .
  methods GET_DEF_COLUMN_MODE
    returning
      value(R_MODE) type I .
  methods GET_DEF_COLUMN_PROPERTIES
    importing
      value(I_COL) type I
    returning
      value(RS_SPLITPROP_COL) type RN1_SPLITPROP_COL .
  methods GET_DEF_COLUMN_SASH_MOVABLE
    importing
      value(I_COL) type I
    returning
      value(R_MOVABLE) type ISH_ON_OFF .
  methods GET_DEF_COLUMN_SASH_VISIBLE
    importing
      value(I_COL) type I
    returning
      value(R_VISIBLE) type ISH_ON_OFF .
  methods GET_DEF_COLUMN_VISIBLE
    importing
      value(I_COL) type I
    returning
      value(R_VISIBLE) type ISH_ON_OFF .
  methods GET_DEF_COLUMN_WIDTH
    importing
      value(I_COL) type I
    returning
      value(R_WIDTH) type I .
  methods GET_DEF_COMMON_PROPERTIES
    returning
      value(RS_SPLITPROP) type RN1_SPLITPROP .
  methods GET_DEF_ROW_HEIGHT
    importing
      value(I_ROW) type I
    returning
      value(R_HEIGHT) type I .
  methods GET_DEF_ROW_MODE
    returning
      value(R_MODE) type I .
  methods GET_DEF_ROW_PROPERTIES
    importing
      value(I_ROW) type I
    returning
      value(RS_SPLITPROP_ROW) type RN1_SPLITPROP_ROW .
  methods GET_DEF_ROW_SASH_MOVABLE
    importing
      value(I_ROW) type I
    returning
      value(R_MOVABLE) type ISH_ON_OFF .
  methods GET_DEF_ROW_SASH_VISIBLE
    importing
      value(I_ROW) type I
    returning
      value(R_VISIBLE) type ISH_ON_OFF .
  methods GET_DEF_ROW_VISIBLE
    importing
      value(I_ROW) type I
    returning
      value(R_VISIBLE) type ISH_ON_OFF .
  methods GET_EMBEDDED_CONTROLS
    importing
      value(I_ONLY_VISIBLE) type ISH_ON_OFF default SPACE
      value(I_OBJECT_TYPE) type I default 0
    exporting
      !ET_SCR_CONTROL type ISH_T_SCR_CONTROL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_NR_OF_COLUMNS
    returning
      value(R_COLS) type I .
  methods GET_NR_OF_ROWS
    returning
      value(R_ROWS) type I .
  methods GET_READ_PROPERTIES
    returning
      value(R_READ_PROPERTIES) type ISH_ON_OFF .
  methods GET_ROW_HEIGHT
    importing
      value(I_ROW) type I
      value(I_FORCE_CNTL) type ISH_ON_OFF default SPACE
    exporting
      value(E_HEIGHT) type I
      value(E_HEIGHT_X) type BAPIUPDATE
      value(E_HEIGHT_CNTL) type I
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ROW_MODE
    exporting
      value(E_MODE) type I
      value(E_MODE_X) type BAPIUPDATE
      value(E_MODE_CNTL) type I
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ROW_PROPERTIES
    importing
      value(I_ROW) type I
      value(I_FORCE_CNTL) type ISH_ON_OFF default SPACE
    exporting
      !ES_SPLITPROP_ROW_X type RN1_SPLITPROP_ROW_X
      !ES_SPLITPROP_ROW_CNTL type RN1_SPLITPROP_ROW
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ROW_SASH_MOVABLE
    importing
      value(I_ROW) type I
      value(I_FORCE_CNTL) type ISH_ON_OFF default SPACE
    exporting
      value(E_MOVABLE) type ISH_ON_OFF
      value(E_MOVABLE_X) type BAPIUPDATE
      value(E_MOVABLE_CNTL) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ROW_SASH_VISIBLE
    importing
      value(I_ROW) type I
      value(I_FORCE_CNTL) type ISH_ON_OFF default SPACE
    exporting
      value(E_VISIBLE) type ISH_ON_OFF
      value(E_VISIBLE_X) type BAPIUPDATE
      value(E_VISIBLE_CNTL) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ROW_VISIBLE
    importing
      value(I_ROW) type I
    exporting
      value(E_VISIBLE) type ISH_ON_OFF
      value(E_VISIBLE_X) type BAPIUPDATE
      value(E_VISIBLE_CNTL) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SAVE_PROPERTIES
    returning
      value(R_SAVE_PROPERTIES) type ISH_ON_OFF .
  methods GET_SPLITTER_CONTAINER
    importing
      value(I_CREATE) type ISH_ON_OFF default 'X'
    exporting
      !ER_SPLITTER_CONTAINER type ref to CL_GUI_SPLITTER_CONTAINER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods IS_CELL_VISIBLE
    importing
      value(I_ROW) type I
      value(I_COL) type I
    exporting
      value(E_VISIBLE) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods READ_COLUMN_PROPERTIES
    importing
      value(I_COL) type I
    exporting
      !ES_SPLITPROP_COL type RN1_SPLITPROP_COL
      value(E_PROP_FOUND) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods READ_COMMON_PROPERTIES
    exporting
      !ES_SPLITPROP type RN1_SPLITPROP
      value(E_PROP_FOUND) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods READ_PROPERTIES
    exporting
      !ES_SPLITPROP type RN1_SPLITPROP
      !ET_SPLITPROP_COL type ISH_T_SPLITPROP_COL
      !ET_SPLITPROP_ROW type ISH_T_SPLITPROP_ROW
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods READ_ROW_PROPERTIES
    importing
      value(I_ROW) type I
    exporting
      !ES_SPLITPROP_ROW type RN1_SPLITPROP_ROW
      value(E_PROP_FOUND) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SAVE_COLUMN_PROPERTIES
    importing
      value(I_COL) type I optional
      !IS_SPLITPROP_COL type RN1_SPLITPROP_COL optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SAVE_COMMON_PROPERTIES
    importing
      !IS_SPLITPROP type RN1_SPLITPROP optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SAVE_PROPERTIES
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SAVE_ROW_PROPERTIES
    importing
      value(I_ROW) type I optional
      !IS_SPLITPROP_ROW type RN1_SPLITPROP_ROW optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_ALIAS_NAME
    importing
      value(I_ALIAS_NAME) type CHAR14 .
  methods SET_BORDER
    importing
      value(I_SHOW_BORDER) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_CELL_SCREEN
    importing
      !IR_SCR_CONTROL type ref to IF_ISH_SCR_CONTROL
      value(I_ROW) type I
      value(I_COL) type I
    exporting
      !ER_SCR_CONTROL_OLD type ref to IF_ISH_SCR_CONTROL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_COLUMN_MODE
    importing
      value(I_MODE) type I
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_COLUMN_PROPERTIES
    importing
      !IS_SPLITPROP_COL_X type RN1_SPLITPROP_COL_X
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_COLUMN_SASH_MOVABLE
    importing
      value(I_COL) type I
      value(I_MOVABLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_COLUMN_SASH_VISIBLE
    importing
      value(I_COL) type I
      value(I_VISIBLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_COLUMN_VISIBLE
    importing
      value(I_COL) type I
      value(I_VISIBLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_COLUMN_WIDTH
    importing
      value(I_COL) type I
      value(I_WIDTH) type I
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_COMMON_PROPERTIES
    importing
      !IS_SPLITPROP_X type RN1_SPLITPROP_X
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_BORDER
    importing
      value(I_SHOW_BORDER) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_COLUMN_MODE
    importing
      value(I_MODE) type I
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_COLUMN_PROPERTIES
    importing
      !IS_SPLITPROP_COL_X type RN1_SPLITPROP_COL_X
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_COLUMN_SASH_MOVABLE
    importing
      value(I_COL) type I
      value(I_MOVABLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_COLUMN_SASH_VISIBLE
    importing
      value(I_COL) type I
      value(I_VISIBLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_COLUMN_VISIBLE
    importing
      value(I_COL) type I
      value(I_VISIBLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_COLUMN_WIDTH
    importing
      value(I_COL) type I
      value(I_WIDTH) type I
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_COMMON_PROPERTIES
    importing
      !IS_SPLITPROP_X type RN1_SPLITPROP_X
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_ROW_HEIGHT
    importing
      value(I_ROW) type I
      value(I_HEIGHT) type I
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_ROW_MODE
    importing
      value(I_MODE) type I
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_ROW_PROPERTIES
    importing
      !IS_SPLITPROP_ROW_X type RN1_SPLITPROP_ROW_X
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_ROW_SASH_MOVABLE
    importing
      value(I_ROW) type I
      value(I_MOVABLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_ROW_SASH_VISIBLE
    importing
      value(I_ROW) type I
      value(I_VISIBLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEF_ROW_VISIBLE
    importing
      value(I_ROW) type I
      value(I_VISIBLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_READ_PROPERTIES
    importing
      value(I_READ_PROPERTIES) type ISH_ON_OFF default 'X' .
  methods SET_ROW_HEIGHT
    importing
      value(I_ROW) type I
      value(I_HEIGHT) type I
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_ROW_MODE
    importing
      value(I_MODE) type I
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_ROW_PROPERTIES
    importing
      !IS_SPLITPROP_ROW_X type RN1_SPLITPROP_ROW_X
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_ROW_SASH_MOVABLE
    importing
      value(I_ROW) type I
      value(I_MOVABLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_ROW_SASH_VISIBLE
    importing
      value(I_ROW) type I
      value(I_VISIBLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_ROW_VISIBLE
    importing
      value(I_ROW) type I
      value(I_VISIBLE) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_SAVE_PROPERTIES
    importing
      value(I_SAVE_PROPERTIES) type ISH_ON_OFF default 'X' .
  methods SPLIT_CELL
    importing
      value(I_ROW) type I
      value(I_COL) type I
      value(I_ROWS) type I
      value(I_COLS) type I
      value(I_ALIAS_NAME) type CHAR14 optional
      value(I_READ_PROPERTIES) type ISH_ON_OFF default SPACE
      value(I_SAVE_PROPERTIES) type ISH_ON_OFF default SPACE
    exporting
      !ER_SCR_SPLITTER_SIMPLE type ref to CL_ISH_SCR_SPLITTER_SIMPLE
      !ER_SCR_CONTROL_OLD type ref to IF_ISH_SCR_CONTROL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
