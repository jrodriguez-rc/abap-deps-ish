class CL_ISH_CONFIG_SPLITTER definition
  public
  create protected .

*"* public components of class CL_ISH_CONFIG_SPLITTER
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONFIG_SPLITTER .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .
  aliases DESTROY
    for IF_ISH_CONFIG_SPLITTER~DESTROY .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases INITIALIZE_COLUMN_PROPERTIES
    for IF_ISH_CONFIG_SPLITTER~INITIALIZE_COLUMN_PROPERTIES .
  aliases INITIALIZE_COMMON_PROPERTIES
    for IF_ISH_CONFIG_SPLITTER~INITIALIZE_COMMON_PROPERTIES .
  aliases INITIALIZE_ROW_PROPERTIES
    for IF_ISH_CONFIG_SPLITTER~INITIALIZE_ROW_PROPERTIES .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases MODIFY_PROPERTIES
    for IF_ISH_CONFIG_SPLITTER~MODIFY_PROPERTIES .

  constants CO_OTYPE_CONFIG_SPLITTER type ISH_OBJECT_TYPE value 3017. "#EC NOTEXT

  class-methods CREATE
    exporting
      !ER_INSTANCE type ref to CL_ISH_CONFIG_SPLITTER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_CONFIG_SPLITTER
*"* do not include other source files here!!!

  methods FILL_INSTANCE_BY_CONFIG
    importing
      !IR_CONFIG type ref to CL_ISH_CONFIG_SPLITTER
      value(I_COPY) type ISH_ON_OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_CONFIG_SPLITTER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_CONFIG_SPLITTER IMPLEMENTATION.


METHOD create.

  CREATE OBJECT er_instance.

ENDMETHOD.


METHOD FILL_INSTANCE_BY_CONFIG.
* not implemented jet
ENDMETHOD.


METHOD if_ish_config_splitter~clone.
  DATA: lr_config TYPE REF TO cl_ish_config_splitter,
        l_rc      TYPE ish_method_rc.

  CALL METHOD cl_ish_config_splitter=>create
    IMPORTING
      er_instance = lr_config
      e_rc        = l_rc.
  IF l_rc <> 0.
    EXIT.
  ENDIF.

  CALL METHOD lr_config->fill_instance_by_config
    EXPORTING
      ir_config = me
      i_copy    = off
    IMPORTING
      e_rc      = l_rc.
  IF l_rc <> 0.
    EXIT.
  ENDIF.
  rr_config = lr_config.
ENDMETHOD.


METHOD if_ish_config_splitter~copy.
  DATA: lr_config TYPE REF TO cl_ish_config_splitter,
        l_rc      TYPE ish_method_rc.

  CALL METHOD cl_ish_config_splitter=>create
    IMPORTING
      er_instance = lr_config
      e_rc        = l_rc.
  IF l_rc <> 0.
    EXIT.
  ENDIF.

  CALL METHOD lr_config->fill_instance_by_config
    EXPORTING
      ir_config = me
      i_copy    = off
    IMPORTING
      e_rc      = l_rc.
  IF l_rc <> 0.
    EXIT.
  ENDIF.
  rr_config = lr_config.
ENDMETHOD.


METHOD if_ish_config_splitter~destroy.
ENDMETHOD.


METHOD if_ish_config_splitter~initialize_column_properties.

* The default implementation does not do anything.
* Redefine this method in derived classes if you have any specialities.

  e_rc = 0.

ENDMETHOD.


METHOD if_ish_config_splitter~initialize_common_properties.

* The default implementation does not do anything.
* Redefine this method in derived classes if you have any specialities.

  e_rc = 0.

ENDMETHOD.


METHOD if_ish_config_splitter~initialize_row_properties.

* The default implementation does not do anything.
* Redefine this method in derived classes if you have any specialities.

  e_rc = 0.

ENDMETHOD.


METHOD if_ish_config_splitter~modify_properties.

* The default implementation does not do anything.
* Redefine this method in derived classes if you have any specialities.

  e_rc = 0.
  e_modified = off.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_config_splitter.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  IF i_object_type = co_otype_config_splitter.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_config_splitter.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.
ENDCLASS.
