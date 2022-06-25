class CL_ISH_SCR_SPLITTER definition
  public
  inheriting from CL_ISH_SCR_CONTROL
  abstract
  create public .

public section.
*"* public components of class CL_ISH_SCR_SPLITTER
*"* do not include other source files here!!!

  interfaces IF_ISH_SCR_SPLITTER .

  aliases CO_MODE_ABSOLUTE
    for IF_ISH_SCR_SPLITTER~CO_MODE_ABSOLUTE .
  aliases CO_MODE_RELATIVE
    for IF_ISH_SCR_SPLITTER~CO_MODE_RELATIVE .
  aliases BUILD_CELL_FROM_FIELDNAME
    for IF_ISH_SCR_SPLITTER~BUILD_CELL_FROM_FIELDNAME .
  aliases BUILD_FIELDNAME_FROM_CELL
    for IF_ISH_SCR_SPLITTER~BUILD_FIELDNAME_FROM_CELL .
  aliases GET_BORDER
    for IF_ISH_SCR_SPLITTER~GET_BORDER .
  aliases GET_CELL_CONTAINER
    for IF_ISH_SCR_SPLITTER~GET_CELL_CONTAINER .
  aliases GET_CELL_FIELDVAL
    for IF_ISH_SCR_SPLITTER~GET_CELL_FIELDVAL .
  aliases GET_CELL_SCREEN
    for IF_ISH_SCR_SPLITTER~GET_CELL_SCREEN .
  aliases GET_COLUMN_MODE
    for IF_ISH_SCR_SPLITTER~GET_COLUMN_MODE .
  aliases GET_COLUMN_PROPERTIES
    for IF_ISH_SCR_SPLITTER~GET_COLUMN_PROPERTIES .
  aliases GET_COLUMN_SASH_MOVABLE
    for IF_ISH_SCR_SPLITTER~GET_COLUMN_SASH_MOVABLE .
  aliases GET_COLUMN_SASH_VISIBLE
    for IF_ISH_SCR_SPLITTER~GET_COLUMN_SASH_VISIBLE .
  aliases GET_COLUMN_VISIBLE
    for IF_ISH_SCR_SPLITTER~GET_COLUMN_VISIBLE .
  aliases GET_COLUMN_WIDTH
    for IF_ISH_SCR_SPLITTER~GET_COLUMN_WIDTH .
  aliases GET_COMMON_PROPERTIES
    for IF_ISH_SCR_SPLITTER~GET_COMMON_PROPERTIES .
  aliases GET_CONFIG_SPLITTER
    for IF_ISH_SCR_SPLITTER~GET_CONFIG_SPLITTER .
  aliases GET_DEF_BORDER
    for IF_ISH_SCR_SPLITTER~GET_DEF_BORDER .
  aliases GET_DEF_COLUMN_MODE
    for IF_ISH_SCR_SPLITTER~GET_DEF_COLUMN_MODE .
  aliases GET_DEF_COLUMN_PROPERTIES
    for IF_ISH_SCR_SPLITTER~GET_DEF_COLUMN_PROPERTIES .
  aliases GET_DEF_COLUMN_SASH_MOVABLE
    for IF_ISH_SCR_SPLITTER~GET_DEF_COLUMN_SASH_MOVABLE .
  aliases GET_DEF_COLUMN_SASH_VISIBLE
    for IF_ISH_SCR_SPLITTER~GET_DEF_COLUMN_SASH_VISIBLE .
  aliases GET_DEF_COLUMN_VISIBLE
    for IF_ISH_SCR_SPLITTER~GET_DEF_COLUMN_VISIBLE .
  aliases GET_DEF_COLUMN_WIDTH
    for IF_ISH_SCR_SPLITTER~GET_DEF_COLUMN_WIDTH .
  aliases GET_DEF_COMMON_PROPERTIES
    for IF_ISH_SCR_SPLITTER~GET_DEF_COMMON_PROPERTIES .
  aliases GET_DEF_ROW_HEIGHT
    for IF_ISH_SCR_SPLITTER~GET_DEF_ROW_HEIGHT .
  aliases GET_DEF_ROW_MODE
    for IF_ISH_SCR_SPLITTER~GET_DEF_ROW_MODE .
  aliases GET_DEF_ROW_PROPERTIES
    for IF_ISH_SCR_SPLITTER~GET_DEF_ROW_PROPERTIES .
  aliases GET_DEF_ROW_SASH_MOVABLE
    for IF_ISH_SCR_SPLITTER~GET_DEF_ROW_SASH_MOVABLE .
  aliases GET_DEF_ROW_SASH_VISIBLE
    for IF_ISH_SCR_SPLITTER~GET_DEF_ROW_SASH_VISIBLE .
  aliases GET_DEF_ROW_VISIBLE
    for IF_ISH_SCR_SPLITTER~GET_DEF_ROW_VISIBLE .
  aliases GET_EMBEDDED_CONTROLS
    for IF_ISH_SCR_SPLITTER~GET_EMBEDDED_CONTROLS .
  aliases GET_NR_OF_COLUMNS
    for IF_ISH_SCR_SPLITTER~GET_NR_OF_COLUMNS .
  aliases GET_NR_OF_ROWS
    for IF_ISH_SCR_SPLITTER~GET_NR_OF_ROWS .
  aliases GET_READ_PROPERTIES
    for IF_ISH_SCR_SPLITTER~GET_READ_PROPERTIES .
  aliases GET_ROW_HEIGHT
    for IF_ISH_SCR_SPLITTER~GET_ROW_HEIGHT .
  aliases GET_ROW_MODE
    for IF_ISH_SCR_SPLITTER~GET_ROW_MODE .
  aliases GET_ROW_PROPERTIES
    for IF_ISH_SCR_SPLITTER~GET_ROW_PROPERTIES .
  aliases GET_ROW_SASH_MOVABLE
    for IF_ISH_SCR_SPLITTER~GET_ROW_SASH_MOVABLE .
  aliases GET_ROW_SASH_VISIBLE
    for IF_ISH_SCR_SPLITTER~GET_ROW_SASH_VISIBLE .
  aliases GET_ROW_VISIBLE
    for IF_ISH_SCR_SPLITTER~GET_ROW_VISIBLE .
  aliases GET_SAVE_PROPERTIES
    for IF_ISH_SCR_SPLITTER~GET_SAVE_PROPERTIES .
  aliases GET_SPLITTER_CONTAINER
    for IF_ISH_SCR_SPLITTER~GET_SPLITTER_CONTAINER .
  aliases IS_CELL_VISIBLE
    for IF_ISH_SCR_SPLITTER~IS_CELL_VISIBLE .
  aliases READ_COLUMN_PROPERTIES
    for IF_ISH_SCR_SPLITTER~READ_COLUMN_PROPERTIES .
  aliases READ_COMMON_PROPERTIES
    for IF_ISH_SCR_SPLITTER~READ_COMMON_PROPERTIES .
  aliases READ_PROPERTIES
    for IF_ISH_SCR_SPLITTER~READ_PROPERTIES .
  aliases READ_ROW_PROPERTIES
    for IF_ISH_SCR_SPLITTER~READ_ROW_PROPERTIES .
  aliases SAVE_COLUMN_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SAVE_COLUMN_PROPERTIES .
  aliases SAVE_COMMON_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SAVE_COMMON_PROPERTIES .
  aliases SAVE_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SAVE_PROPERTIES .
  aliases SAVE_ROW_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SAVE_ROW_PROPERTIES .
  aliases SET_ALIAS_NAME
    for IF_ISH_SCR_SPLITTER~SET_ALIAS_NAME .
  aliases SET_BORDER
    for IF_ISH_SCR_SPLITTER~SET_BORDER .
  aliases SET_CELL_SCREEN
    for IF_ISH_SCR_SPLITTER~SET_CELL_SCREEN .
  aliases SET_COLUMN_MODE
    for IF_ISH_SCR_SPLITTER~SET_COLUMN_MODE .
  aliases SET_COLUMN_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SET_COLUMN_PROPERTIES .
  aliases SET_COLUMN_SASH_MOVABLE
    for IF_ISH_SCR_SPLITTER~SET_COLUMN_SASH_MOVABLE .
  aliases SET_COLUMN_SASH_VISIBLE
    for IF_ISH_SCR_SPLITTER~SET_COLUMN_SASH_VISIBLE .
  aliases SET_COLUMN_VISIBLE
    for IF_ISH_SCR_SPLITTER~SET_COLUMN_VISIBLE .
  aliases SET_COLUMN_WIDTH
    for IF_ISH_SCR_SPLITTER~SET_COLUMN_WIDTH .
  aliases SET_COMMON_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SET_COMMON_PROPERTIES .
  aliases SET_DEF_BORDER
    for IF_ISH_SCR_SPLITTER~SET_DEF_BORDER .
  aliases SET_DEF_COLUMN_MODE
    for IF_ISH_SCR_SPLITTER~SET_DEF_COLUMN_MODE .
  aliases SET_DEF_COLUMN_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SET_DEF_COLUMN_PROPERTIES .
  aliases SET_DEF_COLUMN_SASH_MOVABLE
    for IF_ISH_SCR_SPLITTER~SET_DEF_COLUMN_SASH_MOVABLE .
  aliases SET_DEF_COLUMN_SASH_VISIBLE
    for IF_ISH_SCR_SPLITTER~SET_DEF_COLUMN_SASH_VISIBLE .
  aliases SET_DEF_COLUMN_VISIBLE
    for IF_ISH_SCR_SPLITTER~SET_DEF_COLUMN_VISIBLE .
  aliases SET_DEF_COLUMN_WIDTH
    for IF_ISH_SCR_SPLITTER~SET_DEF_COLUMN_WIDTH .
  aliases SET_DEF_COMMON_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SET_DEF_COMMON_PROPERTIES .
  aliases SET_DEF_ROW_HEIGHT
    for IF_ISH_SCR_SPLITTER~SET_DEF_ROW_HEIGHT .
  aliases SET_DEF_ROW_MODE
    for IF_ISH_SCR_SPLITTER~SET_DEF_ROW_MODE .
  aliases SET_DEF_ROW_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SET_DEF_ROW_PROPERTIES .
  aliases SET_DEF_ROW_SASH_MOVABLE
    for IF_ISH_SCR_SPLITTER~SET_DEF_ROW_SASH_MOVABLE .
  aliases SET_DEF_ROW_SASH_VISIBLE
    for IF_ISH_SCR_SPLITTER~SET_DEF_ROW_SASH_VISIBLE .
  aliases SET_DEF_ROW_VISIBLE
    for IF_ISH_SCR_SPLITTER~SET_DEF_ROW_VISIBLE .
  aliases SET_READ_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SET_READ_PROPERTIES .
  aliases SET_ROW_HEIGHT
    for IF_ISH_SCR_SPLITTER~SET_ROW_HEIGHT .
  aliases SET_ROW_MODE
    for IF_ISH_SCR_SPLITTER~SET_ROW_MODE .
  aliases SET_ROW_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SET_ROW_PROPERTIES .
  aliases SET_ROW_SASH_MOVABLE
    for IF_ISH_SCR_SPLITTER~SET_ROW_SASH_MOVABLE .
  aliases SET_ROW_SASH_VISIBLE
    for IF_ISH_SCR_SPLITTER~SET_ROW_SASH_VISIBLE .
  aliases SET_ROW_VISIBLE
    for IF_ISH_SCR_SPLITTER~SET_ROW_VISIBLE .
  aliases SET_SAVE_PROPERTIES
    for IF_ISH_SCR_SPLITTER~SET_SAVE_PROPERTIES .
  aliases SPLIT_CELL
    for IF_ISH_SCR_SPLITTER~SPLIT_CELL .

  constants CO_NUSRDAT_SPLTCOMMON type ISH_USRPARM value 'SPLTCOMMON'. "#EC NOTEXT
  constants CO_NUSRDAT_SPLTC type ISH_USRPARM value 'SPLTC'. "#EC NOTEXT
  constants CO_NUSRDAT_SPLTR type ISH_USRPARM value 'SPLTR'. "#EC NOTEXT
  constants CO_OTYPE_SCR_SPLITTER type ISH_OBJECT_TYPE value 3018. "#EC NOTEXT

  methods CONSTRUCTOR .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~INITIALIZE
    redefinition .
  methods IF_ISH_SCREEN~MODIFY_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_FROM_DY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_SPLITTER
*"* do not include other source files here!!!

  data GS_DEF_SPLITPROP type RN1_SPLITPROP .
  data GT_DEF_SPLITPROP_ROW type ISH_T_SPLITPROP_ROW .
  data GT_DEF_SPLITPROP_COL type ISH_T_SPLITPROP_COL .
  data GS_SPLITPROP_X type RN1_SPLITPROP_X .
  data GS_SPLITPROP_CNTL type RN1_SPLITPROP .
  data GT_SPLITPROP_ROW_X type ISH_T_SPLITPROP_ROW_X .
  data GT_SPLITPROP_ROW_CNTL type ISH_T_SPLITPROP_ROW .
  data GT_SPLITPROP_COL_X type ISH_T_SPLITPROP_COL_X .
  data GT_SPLITPROP_COL_CNTL type ISH_T_SPLITPROP_COL .
  data GR_SPLITTER_CONTAINER type ref to CL_GUI_SPLITTER_CONTAINER .
  data G_COLS type I value 1. "#EC NOTEXT .
  data G_ROWS type I value 1. "#EC NOTEXT .
  data G_ALIAS_NAME type CHAR14 value SPACE. "#EC NOTEXT .
  data G_READ_PROPERTIES type ISH_ON_OFF value SPACE. "#EC NOTEXT .
  data G_SAVE_PROPERTIES type ISH_ON_OFF value SPACE. "#EC NOTEXT .

  methods READ_COLUMN_PROPERTIES_INTERN
    importing
      !I_COL type I
      !I_CHECK_DOMAINS type ISH_ON_OFF default ON
    exporting
      !ES_SPLITPROP_COL type RN1_SPLITPROP_COL
      !E_PROP_FOUND type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods READ_COMMON_PROPERTIES_INTERN
    importing
      !I_CHECK_DOMAINS type ISH_ON_OFF default ON
    exporting
      !ES_SPLITPROP type RN1_SPLITPROP
      !E_PROP_FOUND type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods READ_ROW_PROPERTIES_INTERN
    importing
      !I_ROW type I
      !I_CHECK_DOMAINS type ISH_ON_OFF default ON
    exporting
      !ES_SPLITPROP_ROW type RN1_SPLITPROP_ROW
      !E_PROP_FOUND type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SAVE_COLUMN_PROPERTIES_INTERN
    importing
      !I_COL type I optional
      !I_CHECK_DOMAINS type ISH_ON_OFF default ON
      !IS_SPLITPROP_COL type RN1_SPLITPROP_COL optional
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SAVE_COMMON_PROPERTIES_INTERN
    importing
      !IS_SPLITPROP type RN1_SPLITPROP optional
      !I_CHECK_DOMAINS type ISH_ON_OFF default ON
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SAVE_ROW_PROPERTIES_INTERN
    importing
      !I_ROW type I optional
      !IS_SPLITPROP_ROW type RN1_SPLITPROP_ROW optional
      !I_CHECK_DOMAINS type ISH_ON_OFF default ON
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_SPLITPROP_TO_CNTL
    importing
      !IS_SPLITPROP_X type RN1_SPLITPROP_X
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_SPLITPROP_ROW_TO_CNTL
    importing
      !IS_SPLITPROP_ROW_X type RN1_SPLITPROP_ROW_X
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_SPLITPROP_ROW_FROM_CNTL
    importing
      !IS_SPLITPROP_ROW_X type RN1_SPLITPROP_ROW_X
    exporting
      !ES_SPLITPROP_ROW_CNTL type RN1_SPLITPROP_ROW
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_SPLITPROP_COL_TO_CNTL
    importing
      !IS_SPLITPROP_COL_X type RN1_SPLITPROP_COL_X
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_SPLITPROP_COL_FROM_CNTL
    importing
      !IS_SPLITPROP_COL_X type RN1_SPLITPROP_COL_X
    exporting
      !ES_SPLITPROP_COL_CNTL type RN1_SPLITPROP_COL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods MODIFY_PROPERTIES_INTERNAL
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_SAVE_PROPERTIES
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_PROPERTIES
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_ALIAS_NAME
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_ROWS_COLUMNS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_DEF_COLUMN_PROPERTIES
    importing
      value(I_COL) type I
    returning
      value(RS_SPLITPROP_COL) type RN1_SPLITPROP_COL .
  methods CREATE_DEF_ROW_PROPERTIES
    importing
      value(I_ROW) type I
    returning
      value(RS_SPLITPROP_ROW) type RN1_SPLITPROP_ROW .

  methods INITIALIZE_FIELD_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_SPLITTER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_SPLITTER IMPLEMENTATION.


METHOD constructor.

  CALL METHOD super->constructor.

* Initialize the default generally properties.
  gs_def_splitprop-show_border = on.
  gs_def_splitprop-col_mode    = co_mode_relative.
  gs_def_splitprop-row_mode    = co_mode_relative.

ENDMETHOD.


METHOD create_def_column_properties .

* Initializations.
  CLEAR rs_splitprop_col.

* Build rs_splitprop_col.
  rs_splitprop_col-id           = i_col.
  IF gs_splitprop_x-col_mode = co_mode_relative.
    rs_splitprop_col-width = 100 / g_cols.
  ELSE.
    rs_splitprop_col-width = 10.
  ENDIF.
  rs_splitprop_col-visible      = on.
  rs_splitprop_col-sash_movable = on.
  rs_splitprop_col-sash_visible = on.

ENDMETHOD.


METHOD create_def_row_properties .

* Initializations.
  CLEAR rs_splitprop_row.

* Build rs_splitprop_row.
  rs_splitprop_row-id           = i_row.
  IF gs_splitprop_x-row_mode = co_mode_relative.
    rs_splitprop_row-height = 100 / g_rows.
  ELSE.
    rs_splitprop_row-height = 100.
  ENDIF.
  rs_splitprop_row-visible      = on.
  rs_splitprop_row-sash_movable = on.
  rs_splitprop_row-sash_visible = on.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_scr_splitter.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_splitter.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~destroy.

  DATA: l_rc                TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Save properties.
  IF g_save_properties = on.
    CALL METHOD save_properties
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

* Call the super method.
  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~initialize .

* This method forces derived classes to initialize own attributes.

* Initializations.
  e_rc = 0.

* First set the own attributes from the parameters.
  gr_main_object     = i_main_object.
  gr_environment     = i_environment.
  gr_lock            = i_lock.
  gr_config          = i_config.
  g_caller           = i_caller.
  g_vcode            = i_vcode.
  g_use_tndym_cursor = i_use_tndym_cursor.
  g_first_time       = on.

* Initialize g_alias_name.
  CALL METHOD initialize_alias_name
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Initialize g_save_properties.
  CALL METHOD initialize_save_properties
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Initialize number or rows and columns.
  CALL METHOD initialize_rows_columns
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Initialize the properties.
  CALL METHOD initialize_properties
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Further initialization via super class.
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

ENDMETHOD.


METHOD if_ish_screen~modify_screen.

* We can not use the logic of the super class.
* In a splitter screen we use this method
* to set the splitter properties.

  DATA: l_modified          TYPE ish_on_off,
        lr_config_splitter  TYPE REF TO if_ish_config_splitter.

* Initializations.
  e_rc = 0.

* Let the configuration modify the properties.
  CALL METHOD get_config_splitter
    IMPORTING
      er_config_splitter = lr_config_splitter
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT lr_config_splitter IS INITIAL.
    CALL METHOD lr_config_splitter->modify_properties
      EXPORTING
        ir_scr_splitter = me
      IMPORTING
        e_rc            = e_rc
        e_modified      = l_modified
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Do own modifications.
  IF l_modified = off.
    CALL METHOD modify_properties_internal
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~transport_from_dy.

* In a splitter control we just handle the attributes for
* the splitter properties.

  DATA: l_row  TYPE i,
        l_col  TYPE i.

  FIELD-SYMBOLS: <ls_col_x>     TYPE rn1_splitprop_col_x,
                 <ls_row_x>     TYPE rn1_splitprop_row_x.

* Initializations.
  e_rc = 0.

* Common properties.
* Clear the xflag fields.
  CLEAR: gs_splitprop_x-show_border_x,
         gs_splitprop_x-col_mode_x,
         gs_splitprop_x-row_mode_x.
* Actualize gs_splitprop_cntl.
  CLEAR gs_splitprop_cntl.
  MOVE-CORRESPONDING gs_splitprop_x TO gs_splitprop_cntl.

* Column properties.
* Actualize and clear the xflag fields.
  LOOP AT gt_splitprop_col_x ASSIGNING <ls_col_x>.
    l_col = <ls_col_x>-id.
    CALL METHOD get_column_properties
      EXPORTING
        i_col        = l_col
        i_force_cntl = on.
    CLEAR: <ls_col_x>-width_x,
           <ls_col_x>-visible_x,
           <ls_col_x>-sash_movable_x,
           <ls_col_x>-sash_visible_x.
  ENDLOOP.

* Row properties.
* Actualize and clear the xflag fields.
  LOOP AT gt_splitprop_row_x ASSIGNING <ls_row_x>.
    l_row = <ls_row_x>-id.
    CALL METHOD get_row_properties
      EXPORTING
        i_row        = l_row
        i_force_cntl = on.
    CLEAR: <ls_row_x>-height_x,
           <ls_row_x>-visible_x,
           <ls_row_x>-sash_movable_x,
           <ls_row_x>-sash_visible_x.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy.

* In a splitter control we set the splitter properties in this method.

  DATA: ls_col_cntl           TYPE rn1_splitprop_col,
        ls_row_cntl           TYPE rn1_splitprop_row,
        ls_col_x              TYPE rn1_splitprop_col_x,
        ls_row_x              TYPE rn1_splitprop_row_x,
        l_count_visible_cols  TYPE i,
        l_count_visible_rows  TYPE i,
        l_cntl_visible        TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_col_x>     TYPE rn1_splitprop_col_x,
                 <ls_row_x>     TYPE rn1_splitprop_row_x,
                 <ls_col_cntl>  TYPE rn1_splitprop_col,
                 <ls_row_cntl>  TYPE rn1_splitprop_row.

* Initializations.
  e_rc = 0.

  DO 1 TIMES.

*   Common properties.
    CALL METHOD trans_splitprop_to_cntl
      EXPORTING
        is_splitprop_x  = gs_splitprop_x
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.

*   Column properties.
*   Determine the number of visible columns.
    l_count_visible_cols = 0.
    LOOP AT gt_splitprop_col_x ASSIGNING <ls_col_x>.
      IF <ls_col_x>-visible = on.
        l_count_visible_cols = l_count_visible_cols + 1.
      ENDIF.
    ENDLOOP.
    LOOP AT gt_splitprop_col_x ASSIGNING <ls_col_x>.
      ls_col_x = <ls_col_x>.
*     If we have only one visible column we
*     do not show the sash.
      IF l_count_visible_cols < 2.
        ls_col_x-sash_movable   = off.
        ls_col_x-sash_visible   = off.
      ENDIF.
*     Modify the column of the splitter control
      CALL METHOD trans_splitprop_col_to_cntl
        EXPORTING
          is_splitprop_col_x = ls_col_x
        IMPORTING
          e_rc               = e_rc
        CHANGING
          cr_errorhandler    = cr_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
*     Actualize the col_cntl table.
      IF <ls_col_x>-visible = on.
*       Delete visible col_cntl entries.
*       They will be actualized on demand.
        DELETE TABLE gt_splitprop_col_cntl
          WITH TABLE KEY id = <ls_col_x>-id.
      ELSE.
*       Actualize invisible col_cntl entries.
*       They can not be modified at the gui.
        READ TABLE gt_splitprop_col_cntl
          ASSIGNING <ls_col_cntl>
          WITH TABLE KEY id = <ls_col_x>-id.
        IF sy-subrc = 0.
          <ls_col_cntl>-width        = <ls_col_x>-width.
          <ls_col_cntl>-visible      = <ls_col_x>-visible.
          <ls_col_cntl>-sash_movable = <ls_col_x>-sash_movable.
          <ls_col_cntl>-sash_visible = <ls_col_x>-sash_visible.
        ELSE.
          CLEAR ls_col_cntl.
          MOVE-CORRESPONDING <ls_col_x> TO ls_col_cntl.
          INSERT ls_col_cntl INTO TABLE gt_splitprop_col_cntl.
        ENDIF.
      ENDIF.
*     Clear the x-flags.
      CLEAR: <ls_col_x>-width_x,
             <ls_col_x>-visible_x,
             <ls_col_x>-sash_movable_x,
             <ls_col_x>-sash_visible_x.
    ENDLOOP.
    CHECK e_rc = 0.

*   Row properties.
*   Determine the number of visible rows.
    l_count_visible_rows = 0.
    LOOP AT gt_splitprop_row_x ASSIGNING <ls_row_x>.
      IF <ls_row_x>-visible = on.
        l_count_visible_rows = l_count_visible_rows + 1.
      ENDIF.
    ENDLOOP.
    LOOP AT gt_splitprop_row_x ASSIGNING <ls_row_x>.
      ls_row_x = <ls_row_x>.
*     If we have only one visible row we
*     do not show the sash.
      IF l_count_visible_rows < 2.
        ls_row_x-sash_movable   = off.
        ls_row_x-sash_visible   = off.
      ENDIF.
*     Modify the row of the splitter control
      CALL METHOD trans_splitprop_row_to_cntl
        EXPORTING
          is_splitprop_row_x = ls_row_x
        IMPORTING
          e_rc               = e_rc
        CHANGING
          cr_errorhandler    = cr_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
*     Actualize the row_cntl table.
      IF <ls_row_x>-visible = on.
*       Delete visible row_cntl entries.
*       They will be actualized on demand.
        DELETE TABLE gt_splitprop_row_cntl
          WITH TABLE KEY id = <ls_row_x>-id.
      ELSE.
*       Actualize invisible row_cntl entries.
*       They can not be modified at the gui.
        READ TABLE gt_splitprop_row_cntl
          ASSIGNING <ls_row_cntl>
          WITH TABLE KEY id = <ls_row_x>-id.
        IF sy-subrc = 0.
          <ls_row_cntl>-height       = <ls_row_x>-height.
          <ls_row_cntl>-visible      = <ls_row_x>-visible.
          <ls_row_cntl>-sash_movable = <ls_row_x>-sash_movable.
          <ls_row_cntl>-sash_visible = <ls_row_x>-sash_visible.
        ELSE.
          CLEAR ls_row_cntl.
          MOVE-CORRESPONDING <ls_row_x> TO ls_row_cntl.
          INSERT ls_row_cntl INTO TABLE gt_splitprop_row_cntl.
        ENDIF.
      ENDIF.
*     Clear the x-flags.
      CLEAR: <ls_row_x>-height_x,
             <ls_row_x>-visible_x,
             <ls_row_x>-sash_movable_x,
             <ls_row_x>-sash_visible_x.
    ENDLOOP.
    CHECK e_rc = 0.

*   If we have no visible cell we hide the splitter control.
*   If we have at least one visible cell we show the splitter control.
    IF gr_splitter_container IS BOUND.
      IF l_count_visible_rows < 1 OR
         l_count_visible_cols < 1.
        l_cntl_visible = off.
      ELSE.
        l_cntl_visible = on.
      ENDIF.
      CALL METHOD gr_splitter_container->set_visible
        EXPORTING
          visible           = l_cntl_visible
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
    ENDIF.

  ENDDO.

ENDMETHOD.


METHOD if_ish_scr_splitter~build_cell_from_fieldname.

  DATA: l_row_id     TYPE n_numc5,
        l_col_id     TYPE n_numc5.

  SPLIT i_fieldname
    AT '.'
    INTO l_row_id
         l_col_id.

  e_row = l_row_id.
  e_col = l_col_id.

ENDMETHOD.


METHOD if_ish_scr_splitter~build_fieldname_from_cell .

  DATA: l_row_id     TYPE n_numc5,
        l_col_id     TYPE n_numc5.

  l_row_id = i_row.
  l_col_id = i_col.
  CONCATENATE l_row_id
              l_col_id
         INTO e_fieldname
    SEPARATED BY '.'.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_alias_name.

  r_alias_name = g_alias_name.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_border.

  DATA: ls_splitprop_x      TYPE rn1_splitprop_x,
        ls_splitprop_cntl   TYPE rn1_splitprop.

* Initializations.
  e_rc = 0.
  CLEAR: e_show_border,
         e_show_border_x,
         e_show_border_cntl.

* Use method get_common_properties.
  CALL METHOD get_common_properties
    IMPORTING
      es_splitprop_x    = ls_splitprop_x
      es_splitprop_cntl = ls_splitprop_cntl
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  e_show_border      = ls_splitprop_x-show_border.
  e_show_border_x    = ls_splitprop_x-show_border_x.
  e_show_border_cntl = ls_splitprop_cntl-show_border.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_cell_container.

  DATA: lr_splitter_container  TYPE REF TO cl_gui_splitter_container,
        lr_cell_container      TYPE REF TO cl_gui_container.

* Initializations.
  e_rc = 0.
  CLEAR er_cell_container.

* Get the splitter container.
  CALL METHOD get_splitter_container
    EXPORTING
      i_create              = i_create
    IMPORTING
      er_splitter_container = lr_splitter_container
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_splitter_container IS INITIAL.

* Get the cell container.
  CALL METHOD lr_splitter_container->get_container
    EXPORTING
      row       = i_row
      column    = i_col
    RECEIVING
      container = lr_cell_container.
  CHECK NOT lr_cell_container IS INITIAL.

* Export.
  er_cell_container = lr_cell_container.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_cell_fieldval.

  DATA: l_fieldname  TYPE ish_fieldname,
        ls_fv        TYPE rnfield_value.

* Initializations.
  e_rc = 0.
  CLEAR es_cell_fieldval.

  CHECK NOT gr_screen_values IS INITIAL.

* Build the cell fieldname.
  CALL METHOD build_fieldname_from_cell
    EXPORTING
      i_row       = i_row
      i_col       = i_col
    IMPORTING
      e_fieldname = l_fieldname.

* Get the corresponding field value.
  CALL METHOD gr_screen_values->get_data
    EXPORTING
      i_fieldname    = l_fieldname
    IMPORTING
      e_field_value  = ls_fv
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT ls_fv IS INITIAL.

* Export.
  es_cell_fieldval = ls_fv.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_cell_screen.

  DATA: ls_fv      TYPE rnfield_value,
        l_visible  TYPE ish_on_off.

* Initializations.
  e_rc = 0.
  CLEAR er_screen.

* Handle i_only_visible.
  IF i_only_visible = on.
    CALL METHOD is_cell_visible
      EXPORTING
        i_row           = i_row
        i_col           = i_col
      IMPORTING
        e_visible       = l_visible
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK l_visible = on.
  ENDIF.

* Get the cell field value.
  CALL METHOD get_cell_fieldval
    EXPORTING
      i_row            = i_row
      i_col            = i_col
    IMPORTING
      es_cell_fieldval = ls_fv
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Check the cell field value.
  CHECK ls_fv-type = co_fvtype_screen.
  CHECK NOT ls_fv-object IS INITIAL.

* Export.
  er_screen ?= ls_fv-object.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_column_mode.

  DATA: ls_splitprop_x      TYPE rn1_splitprop_x,
        ls_splitprop_cntl   TYPE rn1_splitprop.

* Initializations.
  e_rc = 0.
  CLEAR: e_mode,
         e_mode_x,
         e_mode_cntl.

* Use method get_common_properties.
  CALL METHOD get_common_properties
    IMPORTING
      es_splitprop_x    = ls_splitprop_x
      es_splitprop_cntl = ls_splitprop_cntl
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  e_mode      = ls_splitprop_x-col_mode.
  e_mode_x    = ls_splitprop_x-col_mode_x.
  e_mode_cntl = ls_splitprop_cntl-col_mode.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_column_properties.

  DATA: ls_col_cntl  TYPE rn1_splitprop_col,
        l_cntl_found TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_col_x>     TYPE rn1_splitprop_col_x,
                 <ls_col_cntl>  TYPE rn1_splitprop_col.

* Initializations.
  e_rc = 0.
  CLEAR: es_splitprop_col_x,
         es_splitprop_col_cntl.

* Read the corresponding col_x entry from gt_splitprop_col_x.
* This entry has to exist.
  READ TABLE gt_splitprop_col_x
    ASSIGNING <ls_col_x>
    WITH TABLE KEY id = i_col.
  CHECK sy-subrc = 0.

* Now get the corresponding col_cntl entry from gt_splitprop_col_cntl.
* This entry may not exist since visible gt_splitprop_col_cntl entries
* are cleared at every pai beginning.
  READ TABLE gt_splitprop_col_cntl
    ASSIGNING <ls_col_cntl>
    WITH TABLE KEY id = i_col.
  IF sy-subrc = 0.
    l_cntl_found = on.
  ELSE.
    l_cntl_found = off.
  ENDIF.

* If the caller wants to force cntl reading we delete the
* corresponding gt_splitprop_col_cntl entry to build it again.
* But only if the column is visible (invisible columns can
* not be modified at the gui).
  IF l_cntl_found = on.
    IF i_force_cntl = on AND
       <ls_col_cntl>-visible = on.
      DELETE TABLE gt_splitprop_col_cntl
        WITH TABLE KEY id = i_col.
      l_cntl_found = off.
    ENDIF.
  ENDIF.

* If the col_cntl entry does not already exist
* we have to get it from the splitter control.
  IF l_cntl_found = off.
*   Get the col_cntl properties.
    CALL METHOD trans_splitprop_col_from_cntl
      EXPORTING
        is_splitprop_col_x    = <ls_col_x>
      IMPORTING
        es_splitprop_col_cntl = ls_col_cntl
        e_rc                  = e_rc
      CHANGING
        cr_errorhandler       = cr_errorhandler.
    CHECK e_rc = 0.
    ASSIGN ls_col_cntl TO <ls_col_cntl>.
*   Add the col_cntl properties to gt_splitprop_col_cntl.
    INSERT ls_col_cntl INTO TABLE gt_splitprop_col_cntl.
*   Since the col_cntl properties are the actual ones
*   we have to actualize the col_x properties.
*   But we have to take care not to overwrite properties
*   which have been set explicitely.
    IF <ls_col_x>-width_x = off.
      <ls_col_x>-width = ls_col_cntl-width.
    ENDIF.
    IF <ls_col_x>-sash_movable_x = off.
      <ls_col_x>-sash_movable = ls_col_cntl-sash_movable.
    ENDIF.
    IF <ls_col_x>-sash_visible_x = off.
      <ls_col_x>-sash_visible = ls_col_cntl-sash_visible.
    ENDIF.
  ENDIF.

* Export.
  es_splitprop_col_x    = <ls_col_x>.
  es_splitprop_col_cntl = <ls_col_cntl>.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_column_sash_movable.

  DATA: ls_col_x      TYPE rn1_splitprop_col_x,
        ls_col_cntl   TYPE rn1_splitprop_col.

* Initializations.
  e_rc = 0.
  CLEAR: e_movable,
         e_movable_x,
         e_movable_cntl.

* Use method get_column_properties.
  CALL METHOD get_column_properties
    EXPORTING
      i_col                 = i_col
      i_force_cntl          = i_force_cntl
    IMPORTING
      es_splitprop_col_x    = ls_col_x
      es_splitprop_col_cntl = ls_col_cntl
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  e_movable      = ls_col_x-sash_movable.
  e_movable_x    = ls_col_x-sash_movable_x.
  e_movable_cntl = ls_col_cntl-sash_movable.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_column_sash_visible.

  DATA: ls_col_x      TYPE rn1_splitprop_col_x,
        ls_col_cntl   TYPE rn1_splitprop_col.

* Initializations.
  e_rc = 0.
  CLEAR: e_visible,
         e_visible_x,
         e_visible_cntl.

* Use method get_column_properties.
  CALL METHOD get_column_properties
    EXPORTING
      i_col                 = i_col
      i_force_cntl          = i_force_cntl
    IMPORTING
      es_splitprop_col_x    = ls_col_x
      es_splitprop_col_cntl = ls_col_cntl
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  e_visible      = ls_col_x-sash_visible.
  e_visible_x    = ls_col_x-sash_visible_x.
  e_visible_cntl = ls_col_cntl-sash_visible.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_column_visible.

  FIELD-SYMBOLS: <ls_col_x>  TYPE rn1_splitprop_col_x.

* Initializations.
  e_rc = 0.
  CLEAR: e_visible,
         e_visible_x,
         e_visible_cntl.

* Do not use method get_column_properties
* since the visible property can not be changed by the gui.

* Get the column properties.
* They have to exist.
  READ TABLE gt_splitprop_col_x
    ASSIGNING <ls_col_x>
    WITH TABLE KEY id = i_col.
  CHECK sy-subrc = 0.

* Export.
  e_visible      = <ls_col_x>-visible.
  e_visible_x    = <ls_col_x>-visible_x.
  e_visible_cntl = <ls_col_x>-visible.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_column_width.

  DATA: ls_col_x      TYPE rn1_splitprop_col_x,
        ls_col_cntl   TYPE rn1_splitprop_col.

* Initializations.
  e_rc = 0.
  CLEAR: e_width,
         e_width_x,
         e_width_cntl.

* Use method get_column_properties.
  CALL METHOD get_column_properties
    EXPORTING
      i_col                 = i_col
      i_force_cntl          = i_force_cntl
    IMPORTING
      es_splitprop_col_x    = ls_col_x
      es_splitprop_col_cntl = ls_col_cntl
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  e_width      = ls_col_x-width.
  e_width_x    = ls_col_x-width_x.
  e_width_cntl = ls_col_cntl-width.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_common_properties.

* Since the common properties are actualized
* at every pbo ending and pai beginning
* we just have to return them.

  es_splitprop_x    = gs_splitprop_x.
  es_splitprop_cntl = gs_splitprop_cntl.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_config_splitter.

  DATA: lr_config           TYPE REF TO if_ish_config,
        lr_config_splitter  TYPE REF TO if_ish_config_splitter.

* Initializations.
  e_rc = 0.
  CLEAR er_config_splitter.

* Get the config object.
  lr_config = get_config( ).
  CHECK NOT lr_config IS INITIAL.

* Get the splitter config object.
  CALL METHOD lr_config->get_config_splitter
    EXPORTING
      ir_scr_splitter    = me
    IMPORTING
      er_config_splitter = lr_config_splitter
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  er_config_splitter = lr_config_splitter.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_border.

  r_show_border = gs_def_splitprop-show_border.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_column_mode.

  r_mode = gs_def_splitprop-col_mode.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_column_properties.

  DATA: ls_splitprop_col  TYPE rn1_splitprop_col.

  FIELD-SYMBOLS: <ls_splitprop_col>  TYPE rn1_splitprop_col.

* Initializations.
  CLEAR rs_splitprop_col.

  CHECK i_col <= g_cols.

* Get the corresponding entry.
  READ TABLE gt_def_splitprop_col
    ASSIGNING <ls_splitprop_col>
    WITH TABLE KEY id = i_col.

* If the entry was not found we create one and insert it.
  IF sy-subrc <> 0.
    ls_splitprop_col = create_def_column_properties( i_col ).
    INSERT ls_splitprop_col INTO TABLE gt_def_splitprop_col.
    ASSIGN ls_splitprop_col TO <ls_splitprop_col>.
  ENDIF.

* Export.
  rs_splitprop_col = <ls_splitprop_col>.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_column_sash_movable.

  DATA: ls_splitprop_col  TYPE rn1_splitprop_col.

  ls_splitprop_col = get_def_column_properties( i_col ).

  r_movable = ls_splitprop_col-sash_movable.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_column_sash_visible.

  DATA: ls_splitprop_col  TYPE rn1_splitprop_col.

  ls_splitprop_col = get_def_column_properties( i_col ).

  r_visible = ls_splitprop_col-sash_visible.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_column_visible.

  DATA: ls_splitprop_col  TYPE rn1_splitprop_col.

  ls_splitprop_col = get_def_column_properties( i_col ).

  r_visible = ls_splitprop_col-visible.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_column_width.

  DATA: ls_splitprop_col  TYPE rn1_splitprop_col.

  ls_splitprop_col = get_def_column_properties( i_col ).

  r_width = ls_splitprop_col-width.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_common_properties .

  rs_splitprop = gs_def_splitprop.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_row_height.

  DATA: ls_splitprop_row  TYPE rn1_splitprop_row.

  ls_splitprop_row = get_def_row_properties( i_row ).

  r_height = ls_splitprop_row-height.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_row_mode.

  r_mode = gs_def_splitprop-row_mode.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_row_properties.

  DATA: ls_splitprop_row  TYPE rn1_splitprop_row.

  DATA: lr_splitter_container  TYPE REF TO cl_gui_splitter_container,
        lr_container           TYPE REF TO cl_gui_container,
        l_height               TYPE i,
        l_rc                   TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_splitprop_row>  TYPE rn1_splitprop_row.

* Initializations.
  CLEAR rs_splitprop_row.

* Get the corresponding entry.
  READ TABLE gt_def_splitprop_row
    ASSIGNING <ls_splitprop_row>
    WITH TABLE KEY id = i_row.

* If the entry was not found we create one and insert it.
  IF sy-subrc <> 0.
    ls_splitprop_row = create_def_row_properties( i_row ).
    INSERT ls_splitprop_row INTO TABLE gt_def_splitprop_row.
    ASSIGN ls_splitprop_row TO <ls_splitprop_row>.
  ENDIF.

* Export.
  rs_splitprop_row = <ls_splitprop_row>.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_row_sash_movable.

  DATA: ls_splitprop_row  TYPE rn1_splitprop_row.

  ls_splitprop_row = get_def_row_properties( i_row ).

  r_movable = ls_splitprop_row-sash_movable.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_row_sash_visible.

  DATA: ls_splitprop_row  TYPE rn1_splitprop_row.

  ls_splitprop_row = get_def_row_properties( i_row ).

  r_visible = ls_splitprop_row-sash_visible.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_def_row_visible.

  DATA: ls_splitprop_row  TYPE rn1_splitprop_row.

  ls_splitprop_row = get_def_row_properties( i_row ).

  r_visible = ls_splitprop_row-visible.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_embedded_controls.

  DATA: lt_fv           TYPE ish_t_field_value,
        lr_scr_control  TYPE REF TO if_ish_scr_control,
        l_col           TYPE i,
        l_row           TYPE i,
        l_visible       TYPE ish_on_off,
        lt_scr_control  TYPE ish_t_scr_control,
        l_rc            TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fv>  TYPE rnfield_value.

* Initializations.
  e_rc = 0.
  CLEAR: et_scr_control,
         lt_scr_control.

* Get the field values.
  CALL METHOD get_fields
    IMPORTING
      et_field_values = lt_fv
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Now do pbo for the embedded control screens.
  LOOP AT lt_fv ASSIGNING <ls_fv>.
*   Handle only field values which are control screens.
    CHECK <ls_fv>-type = co_fvtype_screen.
    CHECK NOT <ls_fv>-object IS INITIAL.
    CHECK <ls_fv>-object->is_inherited_from(
                cl_ish_scr_control=>co_otype_scr_control ) = on.
*   Handle i_object_type.
    IF NOT i_object_type IS INITIAL.
      CHECK <ls_fv>-object->is_inherited_from( i_object_type ) = on.
    ENDIF.
*   Handle i_only_visible.
    IF i_only_visible = on.
*     Get col/row.
      CALL METHOD build_cell_from_fieldname
        EXPORTING
          i_fieldname = <ls_fv>-fieldname
        IMPORTING
          e_col       = l_col
          e_row       = l_row.
*     Check visibility of the column.
      CALL METHOD get_column_visible
        EXPORTING
          i_col           = l_col
        IMPORTING
          e_visible       = l_visible
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        CONTINUE.
      ENDIF.
      CHECK l_visible = on.
*     Check visibility of the row.
      CALL METHOD get_row_visible
        EXPORTING
          i_row           = l_row
        IMPORTING
          e_visible       = l_visible
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        CONTINUE.
      ENDIF.
      CHECK l_visible = on.
    ENDIF.
*   The control screen should be returned -> build lt_scr_control.
    lr_scr_control ?= <ls_fv>-object.
    APPEND lr_scr_control TO lt_scr_control.
  ENDLOOP.

* Export.
  et_scr_control = lt_scr_control.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_nr_of_columns.

  r_cols = g_cols.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_nr_of_rows.

  r_rows = g_rows.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_read_properties.

  r_read_properties = g_read_properties.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_row_height.

  DATA: ls_row_x      TYPE rn1_splitprop_row_x,
        ls_row_cntl   TYPE rn1_splitprop_row.

* Initializations.
  e_rc = 0.
  CLEAR: e_height,
         e_height_x,
         e_height_cntl.

* Use method get_row_properties.
  CALL METHOD get_row_properties
    EXPORTING
      i_row                 = i_row
      i_force_cntl          = i_force_cntl
    IMPORTING
      es_splitprop_row_x    = ls_row_x
      es_splitprop_row_cntl = ls_row_cntl
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  e_height      = ls_row_x-height.
  e_height_x    = ls_row_x-height_x.
  e_height_cntl = ls_row_cntl-height.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_row_mode.

  DATA: ls_splitprop_x      TYPE rn1_splitprop_x,
        ls_splitprop_cntl   TYPE rn1_splitprop.

* Initializations.
  e_rc = 0.
  CLEAR: e_mode,
         e_mode_x,
         e_mode_cntl.

* Use method get_common_properties.
  CALL METHOD get_common_properties
    IMPORTING
      es_splitprop_x    = ls_splitprop_x
      es_splitprop_cntl = ls_splitprop_cntl
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  e_mode      = ls_splitprop_x-row_mode.
  e_mode_x    = ls_splitprop_x-row_mode_x.
  e_mode_cntl = ls_splitprop_cntl-row_mode.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_row_properties.

  DATA: ls_row_cntl  TYPE rn1_splitprop_row,
        l_cntl_found TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_row_x>     TYPE rn1_splitprop_row_x,
                 <ls_row_cntl>  TYPE rn1_splitprop_row.

* Initializations.
  e_rc = 0.
  CLEAR: es_splitprop_row_x,
         es_splitprop_row_cntl.

* Read the corresponding row_x entry from gt_splitprop_row_x.
* This entry has to exist.
  READ TABLE gt_splitprop_row_x
    ASSIGNING <ls_row_x>
    WITH TABLE KEY id = i_row.
  CHECK sy-subrc = 0.

* Now get the corresponding row_cntl entry from gt_splitprop_row_cntl.
* This entry may not exist since visible gt_splitprop_row_cntl entries
* are cleared at every pai beginning.
  READ TABLE gt_splitprop_row_cntl
    ASSIGNING <ls_row_cntl>
    WITH TABLE KEY id = i_row.
  IF sy-subrc = 0.
    l_cntl_found = on.
  ELSE.
    l_cntl_found = off.
  ENDIF.

* If the caller wants to force cntl reading we delete the
* corresponding gt_splitprop_row_cntl entry to build it again.
* But only if the row is visible (invisible rows can
* not be modified at the gui).
  IF l_cntl_found = on.
    IF i_force_cntl = on AND
       <ls_row_cntl>-visible = on.
      DELETE TABLE gt_splitprop_row_cntl
        WITH TABLE KEY id = i_row.
      l_cntl_found = off.
    ENDIF.
  ENDIF.

* If the row_cntl entry does not already exist
* we have to get it from the splitter control.
  IF l_cntl_found = off.
*   Get the row_cntl properties.
    CALL METHOD trans_splitprop_row_from_cntl
      EXPORTING
        is_splitprop_row_x    = <ls_row_x>
      IMPORTING
        es_splitprop_row_cntl = ls_row_cntl
        e_rc                  = e_rc
      CHANGING
        cr_errorhandler       = cr_errorhandler.
    CHECK e_rc = 0.
    ASSIGN ls_row_cntl TO <ls_row_cntl>.
*   Add the row_cntl properties to gt_splitprop_row_cntl.
    INSERT ls_row_cntl INTO TABLE gt_splitprop_row_cntl.
*   Since the row_cntl properties are the actual ones
*   we have to actualize the row_x properties.
*   But we have to take care not to overwrite properties
*   which have been set explicitely.
    IF <ls_row_x>-height_x = off.
      <ls_row_x>-height = ls_row_cntl-height.
    ENDIF.
    IF <ls_row_x>-sash_movable_x = off.
      <ls_row_x>-sash_movable = ls_row_cntl-sash_movable.
    ENDIF.
    IF <ls_row_x>-sash_visible_x = off.
      <ls_row_x>-sash_visible = ls_row_cntl-sash_visible.
    ENDIF.
  ENDIF.

* Export.
  es_splitprop_row_x    = <ls_row_x>.
  es_splitprop_row_cntl = <ls_row_cntl>.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_row_sash_movable.

  DATA: ls_row_x      TYPE rn1_splitprop_row_x,
        ls_row_cntl   TYPE rn1_splitprop_row.

* Initializations.
  e_rc = 0.
  CLEAR: e_movable,
         e_movable_x,
         e_movable_cntl.

* Use method get_row_properties.
  CALL METHOD get_row_properties
    EXPORTING
      i_row                 = i_row
      i_force_cntl          = i_force_cntl
    IMPORTING
      es_splitprop_row_x    = ls_row_x
      es_splitprop_row_cntl = ls_row_cntl
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  e_movable      = ls_row_x-sash_movable.
  e_movable_x    = ls_row_x-sash_movable_x.
  e_movable_cntl = ls_row_cntl-sash_movable.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_row_sash_visible.

  DATA: ls_row_x      TYPE rn1_splitprop_row_x,
        ls_row_cntl   TYPE rn1_splitprop_row.

* Initializations.
  e_rc = 0.
  CLEAR: e_visible,
         e_visible_x,
         e_visible_cntl.

* Use method get_row_properties.
  CALL METHOD get_row_properties
    EXPORTING
      i_row                 = i_row
      i_force_cntl          = i_force_cntl
    IMPORTING
      es_splitprop_row_x    = ls_row_x
      es_splitprop_row_cntl = ls_row_cntl
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  e_visible      = ls_row_x-sash_visible.
  e_visible_x    = ls_row_x-sash_visible_x.
  e_visible_cntl = ls_row_cntl-sash_visible.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_row_visible.

  FIELD-SYMBOLS: <ls_row_x>  TYPE rn1_splitprop_row_x.

* Initializations.
  e_rc = 0.
  CLEAR: e_visible,
         e_visible_x,
         e_visible_cntl.

* Do not use method get_row_properties
* since the visible property can not be changed by the gui.

* Get the row properties.
* They have to exist.
  READ TABLE gt_splitprop_row_x
    ASSIGNING <ls_row_x>
    WITH TABLE KEY id = i_row.
  CHECK sy-subrc = 0.

* Export.
  e_visible      = <ls_row_x>-visible.
  e_visible_x    = <ls_row_x>-visible_x.
  e_visible_cntl = <ls_row_x>-visible.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_save_properties.

  r_save_properties = g_save_properties.

ENDMETHOD.


METHOD if_ish_scr_splitter~get_splitter_container.

  DATA: lr_container           TYPE REF TO cl_gui_container,
        lr_splitter_container  TYPE REF TO cl_gui_splitter_container.

* Initializations.
  e_rc = 0.
  er_splitter_container = gr_splitter_container.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* If the splitter container was already created we are ready.
  CHECK gr_splitter_container IS INITIAL.

* The splitter container was not already created.
* Further processing only if the caller wants to create it.
  CHECK i_create = on.

* Get the container.
  CALL METHOD get_container
    EXPORTING
      i_create        = on
    IMPORTING
      er_container    = lr_container
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_container IS INITIAL.

* Instantiate the splitter container.
  CREATE OBJECT lr_splitter_container
    EXPORTING
      parent            = lr_container
      rows              = g_rows
      columns           = g_cols
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.
  e_rc = sy-subrc.
  IF e_rc <> 0.
*   Fehler & beim Anlegen des Controls & (Klasse &)
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_SPLITTER_CONTAINER'
        i_mv3           = 'CL_ISH_SCR_SPLITTER_BASE'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Remember the splitter container.
  gr_splitter_container = lr_splitter_container.

* Export.
  er_splitter_container = gr_splitter_container.

ENDMETHOD.


METHOD if_ish_scr_splitter~is_cell_visible.

  DATA: l_visible  TYPE ish_on_off.

* Initializations.
  e_rc = 0.
  e_visible = off.

* Check visibility of the column.
  CALL METHOD get_column_visible
    EXPORTING
      i_col           = i_col
    IMPORTING
      e_visible       = l_visible
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK l_visible = on.

* Check visibility of the row.
  CALL METHOD get_row_visible
    EXPORTING
      i_row           = i_row
    IMPORTING
      e_visible       = l_visible
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK l_visible = on.

* Export.
  e_visible = on.

ENDMETHOD.


METHOD if_ish_scr_splitter~read_column_properties.

* Just wrap to the internal method.
  CALL METHOD read_column_properties_intern
    EXPORTING
      i_col            = i_col
      i_check_domains  = on
    IMPORTING
      es_splitprop_col = es_splitprop_col
      e_prop_found     = e_prop_found
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~read_common_properties.

* Just wrap to the internal method.
  CALL METHOD read_common_properties_intern
    EXPORTING
      i_check_domains = on
    IMPORTING
      es_splitprop    = es_splitprop
      e_prop_found    = e_prop_found
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~read_properties.

  DATA: ls_splitprop        TYPE rn1_splitprop,
        ls_splitprop_row    TYPE rn1_splitprop_row,
        ls_splitprop_col    TYPE rn1_splitprop_col,
        l_row               TYPE i,
        l_col               TYPE i,
        l_prop_found        TYPE ish_on_off,
        l_fcode             TYPE ish_fcode_usrdat,
        l_result            TYPE abap_bool,
        l_rc                TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK NOT g_alias_name IS INITIAL.

* Check domains.
  l_fcode = g_alias_name.
  CALL METHOD cl_ish_utl_base_check=>check_fixed_values
    EXPORTING
      i_data        = l_fcode
    RECEIVING
      r_result      = l_result
    EXCEPTIONS
      no_ddic_type  = 1
      not_supported = 2
      OTHERS        = 3.
  CHECK sy-subrc = 0.
  CHECK l_result = abap_true.

* Common properties.
  IF es_splitprop IS SUPPLIED.
    CALL METHOD read_common_properties_intern
      EXPORTING
        i_check_domains = off
      IMPORTING
        e_rc            = l_rc
        es_splitprop    = es_splitprop
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

* Row properties.
  l_row = 0.
  DO g_rows TIMES.
    l_row = l_row + 1.
    CALL METHOD read_row_properties_intern
      EXPORTING
        i_row            = l_row
        i_check_domains  = off
      IMPORTING
        es_splitprop_row = ls_splitprop_row
        e_prop_found     = l_prop_found
        e_rc             = l_rc
      CHANGING
        cr_errorhandler  = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.
    CHECK l_prop_found = on.
    APPEND ls_splitprop_row TO et_splitprop_row.
  ENDDO.

* Column properties.
  l_col = 0.
  DO g_cols TIMES.
    l_col = l_col + 1.
    CALL METHOD read_column_properties_intern
      EXPORTING
        i_col            = l_col
        i_check_domains  = off
      IMPORTING
        es_splitprop_col = ls_splitprop_col
        e_prop_found     = l_prop_found
        e_rc             = l_rc
      CHANGING
        cr_errorhandler  = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.
    CHECK l_prop_found = on.
    APPEND ls_splitprop_col TO et_splitprop_col.
  ENDDO.

ENDMETHOD.


METHOD if_ish_scr_splitter~read_row_properties.

* Just wrap to the internal method.
  CALL METHOD read_row_properties_intern
    EXPORTING
      i_row            = i_row
      i_check_domains  = on
    IMPORTING
      es_splitprop_row = es_splitprop_row
      e_prop_found     = e_prop_found
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~save_column_properties.

* Just wrap to the internal method.
  CALL METHOD save_column_properties_intern
    EXPORTING
      i_col            = i_col
      i_check_domains  = on
      is_splitprop_col = is_splitprop_col
    IMPORTING
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~save_common_properties.

* Just wrap to the internal method.
  CALL METHOD save_common_properties_intern
    EXPORTING
      is_splitprop    = is_splitprop
      i_check_domains = on
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~save_properties.

  DATA: ls_splitprop_x      TYPE rn1_splitprop_x,
        ls_splitprop        TYPE rn1_splitprop,
        ls_splitprop_row_x  TYPE rn1_splitprop_row_x,
        ls_splitprop_row    TYPE rn1_splitprop_row,
        ls_splitprop_col_x  TYPE rn1_splitprop_col_x,
        ls_splitprop_col    TYPE rn1_splitprop_col,
        l_row               TYPE i,
        l_col               TYPE i,
        l_fcode             TYPE ish_fcode_usrdat,
        l_result            TYPE abap_bool,
        l_rc                TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK NOT g_alias_name IS INITIAL.

* Check domains.
  l_fcode = g_alias_name.
  CALL METHOD cl_ish_utl_base_check=>check_fixed_values
    EXPORTING
      i_data        = l_fcode
    RECEIVING
      r_result      = l_result
    EXCEPTIONS
      no_ddic_type  = 1
      not_supported = 2
      OTHERS        = 3.
  CHECK sy-subrc = 0.
  CHECK l_result = abap_true.

* Common properties.
  CALL METHOD save_common_properties_intern
    EXPORTING
      i_check_domains = off
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Row properties.
  l_row = 0.
  DO g_rows TIMES.
    l_row = l_row + 1.
    CALL METHOD save_row_properties_intern
      EXPORTING
        i_row           = l_row
        i_check_domains = off
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.
  ENDDO.

* Column properties.
  l_col = 0.
  DO g_cols TIMES.
    l_col = l_col + 1.
    CALL METHOD save_column_properties_intern
      EXPORTING
        i_col           = l_col
        i_check_domains = off
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.
  ENDDO.

ENDMETHOD.


METHOD if_ish_scr_splitter~save_row_properties.

* Just wrap to the internal method.
  CALL METHOD save_row_properties_intern
    EXPORTING
      i_row            = i_row
      is_splitprop_row = is_splitprop_row
      i_check_domains  = on
    IMPORTING
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_alias_name.

  g_alias_name = i_alias_name.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_border.

  DATA: ls_splitprop_x  TYPE rn1_splitprop_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_splitprop_x.
  ls_splitprop_x-show_border   = i_show_border.
  ls_splitprop_x-show_border_x = on.

* Use method set_common_properties.
  CALL METHOD set_common_properties
    EXPORTING
      is_splitprop_x  = ls_splitprop_x
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_cell_screen.

  DATA: ls_fv               TYPE rnfield_value,
        lr_scr_control_old  TYPE REF TO if_ish_scr_control.

* Initializations.
  e_rc = 0.
  CLEAR er_scr_control_old.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CHECK NOT gr_screen_values IS INITIAL.

* Get the cell field value.
  CALL METHOD get_cell_fieldval
    EXPORTING
      i_row            = i_row
      i_col            = i_col
    IMPORTING
      es_cell_fieldval = ls_fv
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Check the cell field value.
*   - has to exist.
  IF ls_fv IS INITIAL.
*   Offen ???   Fehlermeldung anlegen.
    e_rc = 1.
    EXIT.
  ENDIF.
*   - its type has to be screen.
  IF ls_fv-type <> co_fvtype_screen.
*   Offen ???   Fehlermeldung anlegen.
    e_rc = 2.
    EXIT.
  ENDIF.

* Remember the old screen object.
  lr_scr_control_old ?= ls_fv-object.

* Update the cell field value.
  ls_fv-object = ir_scr_control.
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      i_field_value  = ls_fv
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  er_scr_control_old = lr_scr_control_old.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_column_mode.

  DATA: ls_splitprop_x  TYPE rn1_splitprop_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_splitprop_x.
  ls_splitprop_x-col_mode   = i_mode.
  ls_splitprop_x-col_mode_x = on.

* Use method set_common_properties.
  CALL METHOD set_common_properties
    EXPORTING
      is_splitprop_x  = ls_splitprop_x
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_column_properties.

  FIELD-SYMBOLS: <ls_col_x>     TYPE rn1_splitprop_col_x.

* Initializations.
  e_rc = 0.

* Read the corresponding col_x entry from gt_splitprop_col_x.
* This entry has to exist.
  READ TABLE gt_splitprop_col_x
    ASSIGNING <ls_col_x>
    WITH TABLE KEY id = is_splitprop_col_x-id.
  CHECK sy-subrc = 0.

* Take over the properties.
  IF is_splitprop_col_x-width_x = on.
    <ls_col_x>-width   = is_splitprop_col_x-width.
    <ls_col_x>-width_x = on.
  ENDIF.
  IF is_splitprop_col_x-visible_x = on.
    <ls_col_x>-visible   = is_splitprop_col_x-visible.
    <ls_col_x>-visible_x = on.
  ENDIF.
  IF is_splitprop_col_x-sash_movable_x = on.
    <ls_col_x>-sash_movable   = is_splitprop_col_x-sash_movable.
    <ls_col_x>-sash_movable_x = on.
  ENDIF.
  IF is_splitprop_col_x-sash_visible_x = on.
    <ls_col_x>-sash_visible   = is_splitprop_col_x-sash_visible.
    <ls_col_x>-sash_visible_x = on.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_column_sash_movable.

  DATA: ls_col_x  TYPE rn1_splitprop_col_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_col_x.
  ls_col_x-id             = i_col.
  ls_col_x-sash_movable   = i_movable.
  ls_col_x-sash_movable_x = on.

* Use method set_column_properties.
  CALL METHOD set_column_properties
    EXPORTING
      is_splitprop_col_x = ls_col_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_column_sash_visible.

  DATA: ls_col_x  TYPE rn1_splitprop_col_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_col_x.
  ls_col_x-id             = i_col.
  ls_col_x-sash_visible   = i_visible.
  ls_col_x-sash_visible_x = on.

* Use method set_column_properties.
  CALL METHOD set_column_properties
    EXPORTING
      is_splitprop_col_x = ls_col_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_column_visible.

  DATA: ls_col_x  TYPE rn1_splitprop_col_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_col_x.
  ls_col_x-id        = i_col.
  ls_col_x-visible   = i_visible.
  ls_col_x-visible_x = on.

* Use method set_column_properties.
  CALL METHOD set_column_properties
    EXPORTING
      is_splitprop_col_x = ls_col_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_column_width.

  DATA: ls_col_x  TYPE rn1_splitprop_col_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_col_x.
  ls_col_x-id      = i_col.
  ls_col_x-width   = i_width.
  ls_col_x-width_x = on.

* Use method set_column_properties.
  CALL METHOD set_column_properties
    EXPORTING
      is_splitprop_col_x = ls_col_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_common_properties.

* Initializations.
  e_rc = 0.

* Take over the properties.
  IF is_splitprop_x-show_border_x = on.
    gs_splitprop_x-show_border   = is_splitprop_x-show_border.
    gs_splitprop_x-show_border_x = on.
  ENDIF.
  IF is_splitprop_x-col_mode_x = on.
    gs_splitprop_x-col_mode   = is_splitprop_x-col_mode.
    gs_splitprop_x-col_mode_x = on.
  ENDIF.
  IF is_splitprop_x-row_mode_x = on.
    gs_splitprop_x-row_mode   = is_splitprop_x-row_mode.
    gs_splitprop_x-row_mode_x = on.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_border.

  gs_def_splitprop-show_border = i_show_border.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_column_mode.

  gs_def_splitprop-col_mode = i_mode.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_column_properties.

  DATA: l_col             TYPE i,
        ls_splitprop_col  TYPE rn1_splitprop_col.

  FIELD-SYMBOLS: <ls_splitprop_col>  TYPE rn1_splitprop_col.

  l_col = is_splitprop_col_x-id.

* Get the corresponding entry.
* If it does not exist it is created.
  ls_splitprop_col = get_def_column_properties( l_col ).

* Position on the corresponding entry.
  READ TABLE gt_def_splitprop_col
    ASSIGNING <ls_splitprop_col>
    WITH TABLE KEY id = l_col.
  CHECK sy-subrc = 0.

* Modify the corresponding entry.
  IF is_splitprop_col_x-width_x = on.
    <ls_splitprop_col>-width = is_splitprop_col_x-width.
  ENDIF.
  IF is_splitprop_col_x-visible_x = on.
    <ls_splitprop_col>-visible = is_splitprop_col_x-visible.
  ENDIF.
  IF is_splitprop_col_x-sash_movable_x = on.
    <ls_splitprop_col>-sash_movable = is_splitprop_col_x-sash_movable.
  ENDIF.
  IF is_splitprop_col_x-sash_visible_x = on.
    <ls_splitprop_col>-sash_visible = is_splitprop_col_x-sash_visible.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_column_sash_movable.

  DATA: ls_splitprop_col_x  TYPE rn1_splitprop_col_x.

* Build the changing structure.
  CLEAR ls_splitprop_col_x.
  ls_splitprop_col_x-id             = i_col.
  ls_splitprop_col_x-sash_movable_x = on.
  ls_splitprop_col_x-sash_movable   = i_movable.

* Use method set_def_column_properties.
  CALL METHOD set_def_column_properties
    EXPORTING
      is_splitprop_col_x = ls_splitprop_col_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_column_sash_visible.

  DATA: ls_splitprop_col_x  TYPE rn1_splitprop_col_x.

* Build the changing structure.
  CLEAR ls_splitprop_col_x.
  ls_splitprop_col_x-id             = i_col.
  ls_splitprop_col_x-sash_visible_x = on.
  ls_splitprop_col_x-sash_visible   = i_visible.

* Use method set_def_column_properties.
  CALL METHOD set_def_column_properties
    EXPORTING
      is_splitprop_col_x = ls_splitprop_col_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_column_visible.

  DATA: ls_splitprop_col_x  TYPE rn1_splitprop_col_x.

* Build the changing structure.
  CLEAR ls_splitprop_col_x.
  ls_splitprop_col_x-id        = i_col.
  ls_splitprop_col_x-visible_x = on.
  ls_splitprop_col_x-visible   = i_visible.

* Use method set_def_column_properties.
  CALL METHOD set_def_column_properties
    EXPORTING
      is_splitprop_col_x = ls_splitprop_col_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_column_width.

  DATA: ls_splitprop_col_x  TYPE rn1_splitprop_col_x.

* Build the changing structure.
  CLEAR ls_splitprop_col_x.
  ls_splitprop_col_x-id      = i_col.
  ls_splitprop_col_x-width_x = on.
  ls_splitprop_col_x-width   = i_width.

* Use method set_def_column_properties.
  CALL METHOD set_def_column_properties
    EXPORTING
      is_splitprop_col_x = ls_splitprop_col_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_common_properties .

  IF is_splitprop_x-show_border_x = on.
    gs_def_splitprop-show_border = is_splitprop_x-show_border.
  ENDIF.
  IF is_splitprop_x-row_mode_x = on.
    gs_def_splitprop-row_mode = is_splitprop_x-row_mode.
  ENDIF.
  IF is_splitprop_x-col_mode_x = on.
    gs_def_splitprop-col_mode = is_splitprop_x-col_mode.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_row_height.

  DATA: ls_row_x  TYPE rn1_splitprop_row_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_row_x.
  ls_row_x-id       = i_row.
  ls_row_x-height   = i_height.
  ls_row_x-height_x = on.

* Use method set_def_row_properties.
  CALL METHOD set_def_row_properties
    EXPORTING
      is_splitprop_row_x = ls_row_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_row_mode.

  gs_def_splitprop-row_mode = i_mode.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_row_properties.

  DATA: l_row             TYPE i,
        ls_splitprop_row  TYPE rn1_splitprop_row.

  FIELD-SYMBOLS: <ls_splitprop_row>  TYPE rn1_splitprop_row.

  l_row = is_splitprop_row_x-id.

* Get the corresponding entry.
* If it does not exist it is created.
  ls_splitprop_row = get_def_row_properties( l_row ).

* Position on the corresponding entry.
  READ TABLE gt_def_splitprop_row
    ASSIGNING <ls_splitprop_row>
    WITH TABLE KEY id = l_row.
  CHECK sy-subrc = 0.

* Modify the corresponding entry.
  IF is_splitprop_row_x-height_x = on.
    <ls_splitprop_row>-height = is_splitprop_row_x-height.
  ENDIF.
  IF is_splitprop_row_x-visible_x = on.
    <ls_splitprop_row>-visible = is_splitprop_row_x-visible.
  ENDIF.
  IF is_splitprop_row_x-sash_movable_x = on.
    <ls_splitprop_row>-sash_movable = is_splitprop_row_x-sash_movable.
  ENDIF.
  IF is_splitprop_row_x-sash_visible_x = on.
    <ls_splitprop_row>-sash_visible = is_splitprop_row_x-sash_visible.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_row_sash_movable.

  DATA: ls_row_x  TYPE rn1_splitprop_row_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_row_x.
  ls_row_x-id             = i_row.
  ls_row_x-sash_movable   = i_movable.
  ls_row_x-sash_movable_x = on.

* Use method set_def_row_properties.
  CALL METHOD set_def_row_properties
    EXPORTING
      is_splitprop_row_x = ls_row_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_row_sash_visible.

  DATA: ls_row_x  TYPE rn1_splitprop_row_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_row_x.
  ls_row_x-id             = i_row.
  ls_row_x-sash_visible   = i_visible.
  ls_row_x-sash_visible_x = on.

* Use method set_def_row_properties.
  CALL METHOD set_def_row_properties
    EXPORTING
      is_splitprop_row_x = ls_row_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_def_row_visible.

  DATA: ls_row_x  TYPE rn1_splitprop_row_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_row_x.
  ls_row_x-id        = i_row.
  ls_row_x-visible   = i_visible.
  ls_row_x-visible_x = on.

* Use method set_def_row_properties.
  CALL METHOD set_def_row_properties
    EXPORTING
      is_splitprop_row_x = ls_row_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_read_properties.

  g_read_properties = i_read_properties.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_row_height.

  DATA: ls_row_x  TYPE rn1_splitprop_row_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_row_x.
  ls_row_x-id       = i_row.
  ls_row_x-height   = i_height.
  ls_row_x-height_x = on.

* Use method set_row_properties.
  CALL METHOD set_row_properties
    EXPORTING
      is_splitprop_row_x = ls_row_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_row_mode.

  DATA: ls_splitprop_x  TYPE rn1_splitprop_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_splitprop_x.
  ls_splitprop_x-row_mode   = i_mode.
  ls_splitprop_x-row_mode_x = on.

* Use method set_common_properties.
  CALL METHOD set_common_properties
    EXPORTING
      is_splitprop_x  = ls_splitprop_x
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_row_properties.

  FIELD-SYMBOLS: <ls_row_x>     TYPE rn1_splitprop_row_x.

* Initializations.
  e_rc = 0.

* Read the corresponding row_x entry from gt_splitprop_row_x.
* This entry has to exist.
  READ TABLE gt_splitprop_row_x
    ASSIGNING <ls_row_x>
    WITH TABLE KEY id = is_splitprop_row_x-id.
  CHECK sy-subrc = 0.

* Take over the properties.
  IF is_splitprop_row_x-height_x = on.
    <ls_row_x>-height   = is_splitprop_row_x-height.
    <ls_row_x>-height_x = on.
  ENDIF.
  IF is_splitprop_row_x-visible_x = on.
    <ls_row_x>-visible   = is_splitprop_row_x-visible.
    <ls_row_x>-visible_x = on.
  ENDIF.
  IF is_splitprop_row_x-sash_movable_x = on.
    <ls_row_x>-sash_movable   = is_splitprop_row_x-sash_movable.
    <ls_row_x>-sash_movable_x = on.
  ENDIF.
  IF is_splitprop_row_x-sash_visible_x = on.
    <ls_row_x>-sash_visible   = is_splitprop_row_x-sash_visible.
    <ls_row_x>-sash_visible_x = on.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_row_sash_movable.

  DATA: ls_row_x  TYPE rn1_splitprop_row_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_row_x.
  ls_row_x-id             = i_row.
  ls_row_x-sash_movable   = i_movable.
  ls_row_x-sash_movable_x = on.

* Use method set_row_properties.
  CALL METHOD set_row_properties
    EXPORTING
      is_splitprop_row_x = ls_row_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_row_sash_visible.

  DATA: ls_row_x  TYPE rn1_splitprop_row_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_row_x.
  ls_row_x-id             = i_row.
  ls_row_x-sash_visible   = i_visible.
  ls_row_x-sash_visible_x = on.

* Use method set_row_properties.
  CALL METHOD set_row_properties
    EXPORTING
      is_splitprop_row_x = ls_row_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_row_visible.

  DATA: ls_row_x  TYPE rn1_splitprop_row_x.

* Initializations.
  e_rc = 0.

* Build the changing structure.
  CLEAR ls_row_x.
  ls_row_x-id        = i_row.
  ls_row_x-visible   = i_visible.
  ls_row_x-visible_x = on.

* Use method set_row_properties.
  CALL METHOD set_row_properties
    EXPORTING
      is_splitprop_row_x = ls_row_x
    IMPORTING
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_scr_splitter~set_save_properties.

  g_save_properties = i_save_properties.

ENDMETHOD.


METHOD if_ish_scr_splitter~split_cell.

  DATA: lr_cell_container       TYPE REF TO cl_gui_container,
        lr_scr_splitter_simple  TYPE REF TO cl_ish_scr_splitter_simple,
        lr_scr_control_old      TYPE REF TO if_ish_scr_control.

* Initializations.
  e_rc = 0.
  CLEAR er_scr_splitter_simple.

* Get the container for the specified cell.
  CALL METHOD get_cell_container
    EXPORTING
      i_row             = i_row
      i_col             = i_col
    IMPORTING
      er_cell_container = lr_cell_container
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Now create the splitter_simple object.
  CALL METHOD cl_ish_scr_splitter_simple=>create
    EXPORTING
      ir_container      = lr_cell_container
      i_rows            = i_rows
      i_cols            = i_cols
      i_alias_name      = i_alias_name
      i_read_properties = i_read_properties
      i_save_properties = i_save_properties
    IMPORTING
      er_instance       = lr_scr_splitter_simple
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_scr_splitter_simple IS INITIAL.

* Now add the splitter_simple to self.
  CALL METHOD set_cell_screen
    EXPORTING
      ir_scr_control     = lr_scr_splitter_simple
      i_row              = i_row
      i_col              = i_col
    IMPORTING
      er_scr_control_old = lr_scr_control_old
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  er_scr_splitter_simple = lr_scr_splitter_simple.
  er_scr_control_old     = lr_scr_control_old.

ENDMETHOD.


METHOD initialize_alias_name.

* The default implementation leaves g_alias_name as it is.
* Redefine this method in derived classes to initialize g_alias_name.

  e_rc = 0.

ENDMETHOD.


METHOD initialize_field_values .

* This method creates one field value for each cell.

  DATA: lt_fv        TYPE ish_t_field_value,
        ls_fv        TYPE rnfield_value,
        l_row        TYPE i,
        l_col        TYPE i,
        l_fieldname  TYPE ish_fieldname.

  CHECK NOT gr_screen_values IS INITIAL.

* g_rows and g_columns must not be empty.
  IF g_rows = 0 OR
     g_cols = 0.
*   Offen ???   Neue Fehlermeldung
    e_rc = 1.
    EXIT.
  ENDIF.

* Create one field value for each cell.
* The fieldname is generated via "row_id.col_id".
  CLEAR lt_fv.
  l_row = 0.
  DO g_rows TIMES.
*   Increment the row number.
    l_row = l_row + 1.
*   For each column in the actual row create one cell field value.
    l_col = 0.
    DO g_cols TIMES.
*     Increment the column number.
      l_col = l_col + 1.
*     Build the cell fieldname.
      CALL METHOD build_fieldname_from_cell
        EXPORTING
          i_row       = l_row
          i_col       = l_col
        IMPORTING
          e_fieldname = l_fieldname.
*     Create the cell field value.
*     The cell field value object is always a screen.
      CLEAR ls_fv.
      ls_fv-type      = co_fvtype_screen.
      ls_fv-fieldname = l_fieldname.
*     Build lt_fv.
      APPEND ls_fv TO lt_fv.
    ENDDO.
  ENDDO.

  CHECK e_rc = 0.

* Now set the screen values.
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      it_field_values = lt_fv
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD initialize_properties.

  DATA: l_row               TYPE i,
        l_col               TYPE i,
        ls_row_x            TYPE rn1_splitprop_row_x,
        ls_col_x            TYPE rn1_splitprop_col_x,
        ls_row_cntl         TYPE rn1_splitprop_row,
        ls_col_cntl         TYPE rn1_splitprop_col,
        l_prop_found        TYPE ish_on_off,
        ls_splitprop        TYPE rn1_splitprop,
        ls_splitprop_row    TYPE rn1_splitprop_row,
        ls_splitprop_col    TYPE rn1_splitprop_col,
        lr_config_splitter  TYPE REF TO if_ish_config_splitter.

* Initializations.
  e_rc = 0.

* Get the corresponding configuration object.
  CALL METHOD get_config_splitter
    IMPORTING
      er_config_splitter = lr_config_splitter
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  CHECK e_rc = 0.

* Common properties.
  CLEAR: gs_splitprop_x,
         gs_splitprop_cntl,
         ls_splitprop.
  l_prop_found = off.
* Read the previously saved properties.
  IF g_read_properties = on.
    CALL METHOD read_common_properties
      IMPORTING
        es_splitprop    = ls_splitprop
        e_prop_found    = l_prop_found
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.
* If no saved properties found use the default properties.
  IF l_prop_found = off.
    ls_splitprop = get_def_common_properties( ).
  ENDIF.
* Let the configuration initialize the properties.
  IF NOT lr_config_splitter IS INITIAL.
    CALL METHOD lr_config_splitter->initialize_common_properties
      EXPORTING
        ir_scr_splitter    = me
        i_saved_prop_found = l_prop_found
      IMPORTING
        e_rc               = e_rc
      CHANGING
        cs_splitprop       = ls_splitprop
        cr_errorhandler    = cr_errorhandler.
  ENDIF.
* Initialize the common properties.
  MOVE-CORRESPONDING ls_splitprop TO gs_splitprop_x.
  gs_splitprop_x-show_border_x = on.
  gs_splitprop_x-col_mode_x    = on.
  gs_splitprop_x-row_mode_x    = on.

* Build the row properties.
  CLEAR: gt_splitprop_row_x,
         gt_splitprop_row_cntl.
  l_row = 0.
  DO g_rows TIMES.
    CLEAR: ls_row_x,
           ls_splitprop_row.
    l_row = l_row + 1.
    l_prop_found = off.
*   Read the previously saved properties.
    IF g_read_properties = on.
      CALL METHOD read_row_properties
        EXPORTING
          i_row            = l_row
        IMPORTING
          es_splitprop_row = ls_splitprop_row
          e_prop_found     = l_prop_found
          e_rc             = e_rc
        CHANGING
          cr_errorhandler  = cr_errorhandler.
      CHECK e_rc = 0.
    ENDIF.
*   If no saved properties found use the default properties.
    IF l_prop_found = off.
      ls_splitprop_row = get_def_row_properties( l_row ).
    ENDIF.
*   Let the configuration initialize the properties.
    IF NOT lr_config_splitter IS INITIAL.
      CALL METHOD lr_config_splitter->initialize_row_properties
        EXPORTING
          ir_scr_splitter    = me
          i_saved_prop_found = l_prop_found
        IMPORTING
          e_rc               = e_rc
        CHANGING
          cs_splitprop_row   = ls_splitprop_row
          cr_errorhandler    = cr_errorhandler.
    ENDIF.
*   Append gt_splitprop_row_x.
    MOVE-CORRESPONDING ls_splitprop_row TO ls_row_x.
    ls_row_x-height_x       = on.
    ls_row_x-sash_movable_x = on.
    ls_row_x-sash_visible_x = on.
    ls_row_x-visible_x      = on.
    INSERT ls_row_x INTO TABLE gt_splitprop_row_x.
*   Append gt_splitprop_row_cntl.
    CLEAR ls_row_cntl.
    MOVE-CORRESPONDING ls_row_x TO ls_row_cntl.
    INSERT ls_row_cntl INTO TABLE gt_splitprop_row_cntl.
  ENDDO.

* Build the column properties.
  CLEAR: gt_splitprop_col_x,
         gt_splitprop_col_cntl.
  l_col = 0.
  DO g_cols TIMES.
    CLEAR: ls_col_x,
           ls_splitprop_col.
    l_col = l_col + 1.
    l_prop_found = off.
*   Read the previously saved properties.
    IF g_read_properties = on.
      CALL METHOD read_column_properties
        EXPORTING
          i_col            = l_col
        IMPORTING
          es_splitprop_col = ls_splitprop_col
          e_prop_found     = l_prop_found
          e_rc             = e_rc
        CHANGING
          cr_errorhandler  = cr_errorhandler.
      CHECK e_rc = 0.
    ENDIF.
*   If no saved properties found use the default properties.
    IF l_prop_found = off.
      ls_splitprop_col = get_def_column_properties( l_col ).
    ENDIF.
*   Let the configuration initialize the properties.
    IF NOT lr_config_splitter IS INITIAL.
      CALL METHOD lr_config_splitter->initialize_column_properties
        EXPORTING
          ir_scr_splitter    = me
          i_saved_prop_found = l_prop_found
        IMPORTING
          e_rc               = e_rc
        CHANGING
          cs_splitprop_col   = ls_splitprop_col
          cr_errorhandler    = cr_errorhandler.
    ENDIF.
*   Append gt_splitprop_col_x.
    MOVE-CORRESPONDING ls_splitprop_col TO ls_col_x.
    ls_col_x-width_x        = on.
    ls_col_x-sash_movable_x = on.
    ls_col_x-sash_visible_x = on.
    ls_col_x-visible_x      = on.
    INSERT ls_col_x INTO TABLE gt_splitprop_col_x.
*   Append gt_splitprop_col_cntl.
    CLEAR ls_col_cntl.
    MOVE-CORRESPONDING ls_col_x TO ls_col_cntl.
    INSERT ls_col_cntl INTO TABLE gt_splitprop_col_cntl.
  ENDDO.

ENDMETHOD.


METHOD initialize_rows_columns.

* The default implementation leaves g_cols and g_rows as they are.
* Redefine this method in derived classes to initialize
* g_cols and g_rows.

  e_rc = 0.

ENDMETHOD.


METHOD initialize_save_properties.

* The default implementation leaves g_save_properties as it is.
* Redefine this method in derived classes to initialize
* g_save_properties.

  e_rc = 0.

ENDMETHOD.


METHOD modify_properties_internal .

* The default implementation does not make any modifications.
* Redefine this method in derived classes.
* You can use attribute G_FIRST_TIME to process only once.

  e_rc = 0.

ENDMETHOD.


METHOD read_column_properties_intern .

  DATA: l_fcode      TYPE ish_fcode_usrdat,
        l_param      TYPE ish_usrparm,
        l_col_id     TYPE n_numc5,
        l_value(10)  TYPE c,
        l_result     TYPE abap_bool.

* Initializations.
  e_rc = 0.
  CLEAR es_splitprop_col.
  e_prop_found = off.

* The alias name is needed.
  CHECK NOT g_alias_name IS INITIAL.

* Build l_fcode.
  l_fcode = g_alias_name.

* l_fcode has to be in domain ISH_FCODE_USRDAT.
  IF i_check_domains = on.
    CALL METHOD cl_ish_utl_base_check=>check_fixed_values
      EXPORTING
        i_data        = l_fcode
      RECEIVING
        r_result      = l_result
      EXCEPTIONS
        no_ddic_type  = 1
        not_supported = 2
        OTHERS        = 3.
    CHECK sy-subrc = 0.
    CHECK l_result = abap_true.
  ENDIF.

* Build l_param.
  l_col_id = i_col.
  CONCATENATE co_nusrdat_spltc
              l_col_id
         INTO l_param.

* Get the stringified properties.
  CALL FUNCTION 'ISH_NUSRDAT_READ_SINGLE'
    EXPORTING
      ss_fcode = l_fcode
      ss_param = l_param
    IMPORTING
      ss_value = l_value.
  CHECK NOT l_value IS INITIAL.

* Export.
  CONCATENATE l_col_id
              l_value
         INTO es_splitprop_col.
  e_prop_found     = on.

ENDMETHOD.


METHOD read_common_properties_intern .

  DATA: l_fcode      TYPE ish_fcode_usrdat,
        l_value(10)  TYPE c,
        l_result     TYPE abap_bool.

* Initializations.
  e_rc = 0.
  CLEAR es_splitprop.
  e_prop_found = off.

* The alias name is needed.
  CHECK NOT g_alias_name IS INITIAL.

* Build l_fcode.
  l_fcode = g_alias_name.

* l_fcode has to be in domain ISH_FCODE_USRDAT.
  IF i_check_domains = on.
    CALL METHOD cl_ish_utl_base_check=>check_fixed_values
      EXPORTING
        i_data        = l_fcode
      RECEIVING
        r_result      = l_result
      EXCEPTIONS
        no_ddic_type  = 1
        not_supported = 2
        OTHERS        = 3.
    CHECK sy-subrc = 0.
    CHECK l_result = abap_true.
  ENDIF.

* Get the stringified properties.
  CALL FUNCTION 'ISH_NUSRDAT_READ_SINGLE'
    EXPORTING
      ss_fcode = l_fcode
      ss_param = co_nusrdat_spltcommon
    IMPORTING
      ss_value = l_value.
  CHECK NOT l_value IS INITIAL.

* Export.
  es_splitprop = l_value.
  e_prop_found = on.

ENDMETHOD.


METHOD read_row_properties_intern .

  DATA: l_fcode      TYPE ish_fcode_usrdat,
        l_param      TYPE ish_usrparm,
        l_row_id     TYPE n_numc5,
        l_value(10)  TYPE c,
        l_result     TYPE abap_bool.

* Initializations.
  e_rc = 0.
  CLEAR es_splitprop_row.
  e_prop_found = off.

* The alias name is needed.
  CHECK NOT g_alias_name IS INITIAL.

* Build l_fcode.
  l_fcode = g_alias_name.

* l_fcode has to be in domain ISH_FCODE_USRDAT.
  IF i_check_domains = on.
    CALL METHOD cl_ish_utl_base_check=>check_fixed_values
      EXPORTING
        i_data        = l_fcode
      RECEIVING
        r_result      = l_result
      EXCEPTIONS
        no_ddic_type  = 1
        not_supported = 2
        OTHERS        = 3.
    CHECK sy-subrc = 0.
    CHECK l_result = abap_true.
  ENDIF.

* Build l_param.
  l_row_id = i_row.
  CONCATENATE co_nusrdat_spltr
              l_row_id
         INTO l_param.

* Get the stringified properties.
  CALL FUNCTION 'ISH_NUSRDAT_READ_SINGLE'
    EXPORTING
      ss_fcode = l_fcode
      ss_param = l_param
    IMPORTING
      ss_value = l_value.
  CHECK NOT l_value IS INITIAL.

* Export.
  CONCATENATE l_row_id
              l_value
         INTO es_splitprop_row.
  CONCATENATE l_row_id
              l_value
         INTO es_splitprop_row.
  e_prop_found     = on.

ENDMETHOD.


METHOD save_column_properties_intern .

  DATA: l_fcode             TYPE ish_fcode_usrdat,
        l_value(10)         TYPE c,
        l_result            TYPE abap_bool,
        l_param             TYPE ish_usrparm,
        ls_splitprop_col_x  TYPE rn1_splitprop_col_x,
        ls_splitprop_col    TYPE rn1_splitprop_col.

  FIELD-SYMBOLS: <ls_splitprop_col>  TYPE rn1_splitprop_col.

* Initializations.
  e_rc = 0.

* The alias name is needed.
  CHECK NOT g_alias_name IS INITIAL.

* Build l_fcode.
  l_fcode = g_alias_name.

* l_fcode has to be in domain ISH_FCODE_USRDAT.
  IF i_check_domains = on.
    CALL METHOD cl_ish_utl_base_check=>check_fixed_values
      EXPORTING
        i_data        = l_fcode
      RECEIVING
        r_result      = l_result
      EXCEPTIONS
        no_ddic_type  = 1
        not_supported = 2
        OTHERS        = 3.
    CHECK sy-subrc = 0.
    CHECK l_result = abap_true.
  ENDIF.

* Get the column properties.
  IF NOT is_splitprop_col IS INITIAL.
    ASSIGN is_splitprop_col TO <ls_splitprop_col>.
  ELSE.
    CALL METHOD get_column_properties
      EXPORTING
        i_col              = i_col
        i_force_cntl       = on
      IMPORTING
        es_splitprop_col_x = ls_splitprop_col_x
        e_rc               = e_rc
      CHANGING
        cr_errorhandler    = cr_errorhandler.
    CHECK e_rc = 0.
    MOVE-CORRESPONDING ls_splitprop_col_x TO ls_splitprop_col.
    ASSIGN ls_splitprop_col TO <ls_splitprop_col>.
  ENDIF.

* Build l_param.
  CONCATENATE co_nusrdat_spltc
              <ls_splitprop_col>-id
         INTO l_param.

* Build l_value (eliminate the id).
  l_value = <ls_splitprop_col>+5.

* Write the stringified properties.
  CALL FUNCTION 'ISH_NUSRDAT_WRITE_SINGLE'
    EXPORTING
      ss_fcode = l_fcode
      ss_param = l_param
      ss_value = l_value.

ENDMETHOD.


METHOD save_common_properties_intern .

  DATA: l_fcode         TYPE ish_fcode_usrdat,
        l_value(10)     TYPE c,
        l_result        TYPE abap_bool,
        ls_splitprop_x  TYPE rn1_splitprop_x,
        ls_splitprop    TYPE rn1_splitprop.

  FIELD-SYMBOLS: <ls_splitprop>  TYPE rn1_splitprop.

* Initializations.
  e_rc = 0.

* The alias name is needed.
  CHECK NOT g_alias_name IS INITIAL.

* Build l_fcode.
  l_fcode = g_alias_name.

* l_fcode has to be in domain ISH_FCODE_USRDAT.
  IF i_check_domains = on.
    CALL METHOD cl_ish_utl_base_check=>check_fixed_values
      EXPORTING
        i_data        = l_fcode
      RECEIVING
        r_result      = l_result
      EXCEPTIONS
        no_ddic_type  = 1
        not_supported = 2
        OTHERS        = 3.
    CHECK sy-subrc = 0.
    CHECK l_result = abap_true.
  ENDIF.

* Get the common properties.
  IF NOT is_splitprop IS INITIAL.
    ASSIGN is_splitprop TO <ls_splitprop>.
  ELSE.
    CALL METHOD get_common_properties
      IMPORTING
        es_splitprop_x  = ls_splitprop_x
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    MOVE-CORRESPONDING ls_splitprop_x TO ls_splitprop.
    ASSIGN ls_splitprop TO <ls_splitprop>.
  ENDIF.

* Build l_value.
  l_value = <ls_splitprop>.

* Write the stringified properties.
  CALL FUNCTION 'ISH_NUSRDAT_WRITE_SINGLE'
    EXPORTING
      ss_fcode = l_fcode
      ss_param = co_nusrdat_spltcommon
      ss_value = l_value.

ENDMETHOD.


METHOD save_row_properties_intern .

  DATA: l_fcode             TYPE ish_fcode_usrdat,
        l_value(10)         TYPE c,
        l_result            TYPE abap_bool,
        l_param             TYPE ish_usrparm,
        ls_splitprop_row_x  TYPE rn1_splitprop_row_x,
        ls_splitprop_row    TYPE rn1_splitprop_row.

  FIELD-SYMBOLS: <ls_splitprop_row>  TYPE rn1_splitprop_row.

* Initializations.
  e_rc = 0.

* The alias name is needed.
  CHECK NOT g_alias_name IS INITIAL.

* Build l_fcode.
  l_fcode = g_alias_name.

* l_fcode has to be in domain ISH_FCODE_USRDAT.
  IF i_check_domains = on.
    CALL METHOD cl_ish_utl_base_check=>check_fixed_values
      EXPORTING
        i_data        = l_fcode
      RECEIVING
        r_result      = l_result
      EXCEPTIONS
        no_ddic_type  = 1
        not_supported = 2
        OTHERS        = 3.
    CHECK sy-subrc = 0.
    CHECK l_result = abap_true.
  ENDIF.

* Get the row properties.
  IF NOT is_splitprop_row IS INITIAL.
    ASSIGN is_splitprop_row TO <ls_splitprop_row>.
  ELSE.
    CALL METHOD get_row_properties
      EXPORTING
        i_row              = i_row
        i_force_cntl       = on
      IMPORTING
        es_splitprop_row_x = ls_splitprop_row_x
        e_rc               = e_rc
      CHANGING
        cr_errorhandler    = cr_errorhandler.
    CHECK e_rc = 0.
    MOVE-CORRESPONDING ls_splitprop_row_x TO ls_splitprop_row.
    ASSIGN ls_splitprop_row TO <ls_splitprop_row>.
  ENDIF.

* Build l_param.
  CONCATENATE co_nusrdat_spltr
              <ls_splitprop_row>-id
         INTO l_param.

* Build l_value (eliminate the id).
  l_value = <ls_splitprop_row>+5.

* Write the stringified properties.
  CALL FUNCTION 'ISH_NUSRDAT_WRITE_SINGLE'
    EXPORTING
      ss_fcode = l_fcode
      ss_param = l_param
      ss_value = l_value.

ENDMETHOD.


METHOD trans_splitprop_col_from_cntl .

  DATA: lr_splitter_container  TYPE REF TO cl_gui_splitter_container,
        l_col                  TYPE i,
        l_method(30)           TYPE c,
        l_width                TYPE i.

* Initializations.
  e_rc = 0.
  CLEAR es_splitprop_col_cntl.

* Get the splitter container.
  CALL METHOD get_splitter_container
    IMPORTING
      er_splitter_container = lr_splitter_container
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_splitter_container IS INITIAL.

* Get the column properties, but only those
* which can be set at the frontend.
  l_col = is_splitprop_col_x-id.
  DO 1 TIMES.
*   width.
    l_method = 'GET_COLUMN_WIDTH'.
    CALL METHOD lr_splitter_container->get_column_width
      EXPORTING
        id                = l_col
      IMPORTING
        RESULT            = l_width
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    e_rc = sy-subrc.
    CHECK e_rc = 0.
  ENDDO.

* Errorhandling.
  IF e_rc <> 0.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = l_method
        i_mv3           = 'CL_GUI_SPLITTER_CONTAINER'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Flush to get the results.
  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      cntl_system_error = 1
      cntl_error        = 2
      OTHERS            = 3.
  e_rc = sy-subrc.
  IF e_rc <> 0.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = 'FLUSH'
        i_mv3           = 'CL_GUI_CFW'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Export.
  CLEAR es_splitprop_col_cntl.
  MOVE-CORRESPONDING is_splitprop_col_x TO es_splitprop_col_cntl.
  IF l_width > 0.
    es_splitprop_col_cntl-width = l_width.
  ENDIF.

ENDMETHOD.


METHOD trans_splitprop_col_to_cntl .

  DATA: lr_splitter_container  TYPE REF TO cl_gui_splitter_container,
        l_method(30)           TYPE c,
        ls_col_x               TYPE rn1_splitprop_col_x,
        l_id                   TYPE i,
        l_width                TYPE i,
        l_sash_movable         TYPE i,
        l_sash_visible         TYPE i.

* Initializations.
  e_rc = 0.

* Get the splitter container.
  CALL METHOD get_splitter_container
    IMPORTING
      er_splitter_container = lr_splitter_container
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

  DO 1 TIMES.
    l_id = is_splitprop_col_x-id.
*   Build ls_col_x: Properties for the control.
*   This is needed since the visible property generates
*   some other properties.
    CLEAR ls_col_x.
    ls_col_x = is_splitprop_col_x.
    IF is_splitprop_col_x-visible = off.
      ls_col_x-width          = 0.
      ls_col_x-sash_movable   = off.
      ls_col_x-sash_visible   = off.
    ENDIF.
*   width.
    l_width  = ls_col_x-width.
    l_method = 'SET_COLUMN_WIDTH'.
    CALL METHOD lr_splitter_container->set_column_width
      EXPORTING
        id                = l_id
        width             = l_width
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    e_rc = sy-subrc.
    CHECK e_rc = 0.
*   sash_movable.
    IF ls_col_x-sash_movable = on.
      l_sash_movable  = cl_gui_splitter_container=>true.
    ELSE.
      l_sash_movable  = cl_gui_splitter_container=>false.
    ENDIF.
    l_method = 'SET_COLUMN_SASH'.
    CALL METHOD lr_splitter_container->set_column_sash
      EXPORTING
        id                = l_id
        type              = cl_gui_splitter_container=>type_movable
        value             = l_sash_movable
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    e_rc = sy-subrc.
    CHECK e_rc = 0.
*   sash_visible.
    IF ls_col_x-sash_visible = on.
      l_sash_visible  = cl_gui_splitter_container=>true.
    ELSE.
      l_sash_visible  = cl_gui_splitter_container=>false.
    ENDIF.
    l_method = 'SET_COLUMN_SASH'.
    CALL METHOD lr_splitter_container->set_column_sash
      EXPORTING
        id                = l_id
        type            = cl_gui_splitter_container=>type_sashvisible
        value             = l_sash_visible
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    e_rc = sy-subrc.
    CHECK e_rc = 0.
  ENDDO.

* Errorhandling.
  IF e_rc <> 0.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = l_method
        i_mv3           = 'CL_GUI_SPLITTER_CONTAINER'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD trans_splitprop_row_from_cntl .

  DATA: lr_splitter_container  TYPE REF TO cl_gui_splitter_container,
        l_row                  TYPE i,
        l_method(30)           TYPE c,
        l_height               TYPE i.

* Initializations.
  e_rc = 0.
  CLEAR es_splitprop_row_cntl.

* Get the splitter container.
  CALL METHOD get_splitter_container
    IMPORTING
      er_splitter_container = lr_splitter_container
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_splitter_container IS INITIAL.

* Get the row properties.
  l_row = is_splitprop_row_x-id.
  DO 1 TIMES.
*   height.
    l_method = 'GET_ROW_HEIGHT'.
    CALL METHOD lr_splitter_container->get_row_height
      EXPORTING
        id                = l_row
      IMPORTING
        RESULT            = l_height
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    e_rc = sy-subrc.
    CHECK e_rc = 0.
  ENDDO.

* Errorhandling.
  IF e_rc <> 0.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = l_method
        i_mv3           = 'CL_GUI_SPLITTER_CONTAINER'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Flush to get the results.
  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      cntl_system_error = 1
      cntl_error        = 2
      OTHERS            = 3.
  e_rc = sy-subrc.
  IF e_rc <> 0.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = 'FLUSH'
        i_mv3           = 'CL_GUI_CFW'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Export.
  CLEAR es_splitprop_row_cntl.
  MOVE-CORRESPONDING is_splitprop_row_x TO es_splitprop_row_cntl.
  IF l_height > 0.
    es_splitprop_row_cntl-height = l_height.
  ENDIF.

ENDMETHOD.


METHOD trans_splitprop_row_to_cntl .

  DATA: lr_splitter_container  TYPE REF TO cl_gui_splitter_container,
        l_method(30)           TYPE c,
        ls_row_x               TYPE rn1_splitprop_row_x,
        l_id                   TYPE i,
        l_height               TYPE i,
        l_sash_movable         TYPE i,
        l_sash_visible         TYPE i.

* Initializations.
  e_rc = 0.

* Get the splitter container.
  CALL METHOD get_splitter_container
    IMPORTING
      er_splitter_container = lr_splitter_container
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

  DO 1 TIMES.
    l_id = is_splitprop_row_x-id.
*   Build ls_row_x: Properties for the control.
*   This is needed since the visible property generates
*   some other properties.
    CLEAR ls_row_x.
    ls_row_x = is_splitprop_row_x.
    IF is_splitprop_row_x-visible = off.
      ls_row_x-height         = 0.
      ls_row_x-sash_movable   = off.
      ls_row_x-sash_visible   = off.
    ENDIF.
*   height.
    l_height  = ls_row_x-height.
    l_method = 'SET_ROW_HEIGHT'.
    CALL METHOD lr_splitter_container->set_row_height
      EXPORTING
        id                = l_id
        height            = l_height
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    e_rc = sy-subrc.
    CHECK e_rc = 0.
*   sash_movable.
    IF ls_row_x-sash_movable = on.
      l_sash_movable  = cl_gui_splitter_container=>true.
    ELSE.
      l_sash_movable  = cl_gui_splitter_container=>false.
    ENDIF.
    l_method = 'SET_ROW_SASH'.
    CALL METHOD lr_splitter_container->set_row_sash
      EXPORTING
        id                = l_id
        type              = cl_gui_splitter_container=>type_movable
        value             = l_sash_movable
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    e_rc = sy-subrc.
    CHECK e_rc = 0.
*   sash_visible.
    IF ls_row_x-sash_visible = on.
      l_sash_visible  = cl_gui_splitter_container=>true.
    ELSE.
      l_sash_visible  = cl_gui_splitter_container=>false.
    ENDIF.
    l_method = 'SET_ROW_SASH'.
    CALL METHOD lr_splitter_container->set_row_sash
      EXPORTING
        id                = l_id
        type            = cl_gui_splitter_container=>type_sashvisible
        value             = l_sash_visible
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    e_rc = sy-subrc.
    CHECK e_rc = 0.
  ENDDO.

* Errorhandling.
  IF e_rc <> 0.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = l_method
        i_mv3           = 'CL_GUI_SPLITTER_CONTAINER'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD trans_splitprop_to_cntl .

  DATA: lr_splitter_container  TYPE REF TO cl_gui_splitter_container,
        l_method(30)           TYPE c,
        l_border               TYPE gfw_boolean,
        l_mode                 TYPE i.

* Initializations.
  e_rc = 0.

* Get the splitter container.
  CALL METHOD get_splitter_container
    IMPORTING
      er_splitter_container = lr_splitter_container
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

  DO 1 TIMES.
*   show_border.
    IF is_splitprop_x-show_border_x = on.
      IF is_splitprop_x-show_border = on.
        l_border = gfw_true.
      ELSE.
        l_border = gfw_false.
      ENDIF.
      l_method = 'SET_BORDER'.
      CALL METHOD lr_splitter_container->set_border
        EXPORTING
          border            = l_border
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      e_rc = sy-subrc.
      CHECK e_rc = 0.
    ENDIF.
*   col_mode.
    IF is_splitprop_x-col_mode_x = on.
      l_mode = is_splitprop_x-col_mode.
      l_method = 'SET_COLUMN_MODE'.
      CALL METHOD lr_splitter_container->set_column_mode
        EXPORTING
          mode              = l_mode
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      e_rc = sy-subrc.
      CHECK e_rc = 0.
    ENDIF.
*   row_mode.
    IF is_splitprop_x-row_mode_x = on.
      l_mode = is_splitprop_x-row_mode.
      l_method = 'SET_ROW_MODE'.
      CALL METHOD lr_splitter_container->set_row_mode
        EXPORTING
          mode              = l_mode
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      e_rc = sy-subrc.
      CHECK e_rc = 0.
    ENDIF.
  ENDDO.

* Errorhandling.
  IF e_rc <> 0.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = e_rc
        i_mv2           = l_method
        i_mv3           = 'CL_GUI_SPLITTER_CONTAINER'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

ENDMETHOD.
ENDCLASS.
