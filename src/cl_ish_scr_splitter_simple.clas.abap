class CL_ISH_SCR_SPLITTER_SIMPLE definition
  public
  inheriting from CL_ISH_SCR_SPLITTER
  create protected .

*"* public components of class CL_ISH_SCR_SPLITTER_SIMPLE
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_SCR_SPLITTER_SIMPLE type ISH_OBJECT_TYPE value 7092. "#EC NOTEXT

  class-methods CREATE
    importing
      !IR_CONTAINER type ref to CL_GUI_CONTAINER optional
      value(I_CONTAINER_NAME) type ISH_FIELDNAME optional
      value(I_ALIAS_NAME) type CHAR14 default SPACE
      value(I_ROWS) type I default 1
      value(I_COLS) type I default 1
      value(I_READ_PROPERTIES) type ISH_ON_OFF default SPACE
      value(I_SAVE_PROPERTIES) type ISH_ON_OFF default SPACE
    exporting
      !ER_INSTANCE type ref to CL_ISH_SCR_SPLITTER_SIMPLE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_SETTINGS
    importing
      value(I_ALIAS_NAME) type CHAR14 optional
      value(I_ALIAS_NAME_X) type ISH_ON_OFF default SPACE
      value(I_ROWS) type I optional
      value(I_ROWS_X) type ISH_ON_OFF default SPACE
      value(I_COLS) type I optional
      value(I_COLS_X) type ISH_ON_OFF default SPACE
      value(I_READ_PROPERTIES) type ISH_ON_OFF optional
      value(I_READ_PROPERTIES_X) type ISH_ON_OFF default SPACE
      value(I_SAVE_PROPERTIES) type ISH_ON_OFF optional
      value(I_SAVE_PROPERTIES_X) type ISH_ON_OFF default SPACE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_ROWS_COLUMNS
    importing
      value(I_ROWS) type I
      value(I_COLS) type I
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_SPLITTER_SIMPLE
*"* do not include other source files here!!!

  methods COMPLETE_CONSTRUCTION
    importing
      !IR_CONTAINER type ref to CL_GUI_CONTAINER optional
      value(I_CONTAINER_NAME) type ISH_FIELDNAME optional
      value(I_ALIAS_NAME) type CHAR14 default SPACE
      value(I_ROWS) type I default 1
      value(I_COLS) type I default 1
      value(I_READ_PROPERTIES) type ISH_ON_OFF default SPACE
      value(I_SAVE_PROPERTIES) type ISH_ON_OFF default SPACE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_SCR_SPLITTER_SIMPLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_SPLITTER_SIMPLE IMPLEMENTATION.


METHOD complete_construction.

* Initializations.
  e_rc = 0.

* Set own attributes.
  gs_parent-container      = ir_container.
  gs_parent-container_name = i_container_name.
  g_alias_name             = i_alias_name.
  g_rows                   = i_rows.
  g_cols                   = i_cols.
  g_read_properties        = i_read_properties.
  g_save_properties        = i_save_properties.

ENDMETHOD.


METHOD create.

  DATA: lr_instance  TYPE REF TO cl_ish_scr_splitter_simple.

* Initializations.
  e_rc = 0.
  CLEAR er_instance.

* Create the object.
  CREATE OBJECT lr_instance.

* Complete construction.
  CALL METHOD lr_instance->complete_construction
    EXPORTING
      ir_container      = ir_container
      i_container_name  = i_container_name
      i_alias_name      = i_alias_name
      i_rows            = i_rows
      i_cols            = i_cols
      i_read_properties = i_read_properties
      i_save_properties = i_save_properties
    IMPORTING
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  er_instance = lr_instance.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_scr_splitter_simple.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_splitter_simple.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD initialize_settings.

* Initializations.
  e_rc = 0.

* Take over the settings.

* alias_name.
  IF i_alias_name_x = on.
    g_alias_name = i_alias_name.
  ENDIF.

* rows.
  IF i_rows_x = on.
    g_rows = i_rows.
  ENDIF.

* cols.
  IF i_cols_x = on.
    g_cols = i_cols.
  ENDIF.

* save_properties.
  IF i_save_properties_x = on.
    g_save_properties = i_save_properties.
  ENDIF.

ENDMETHOD.


METHOD set_rows_columns .

  g_rows = i_rows.
  g_cols = i_cols.

ENDMETHOD.
ENDCLASS.
