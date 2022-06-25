class CL_ISH_CONFIG_TOOLBAR definition
  public
  create public .

public section.
*"* public components of class CL_ISH_CONFIG_TOOLBAR
*"* do not include other source files here!!!

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_CONFIG_TOOLBAR .

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
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
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
    for IF_ISH_CONFIG_TOOLBAR~DESTROY .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases PROCESS_DDCLICKED
    for IF_ISH_CONFIG_TOOLBAR~PROCESS_DDCLICKED .
  aliases PROCESS_FUNCSEL
    for IF_ISH_CONFIG_TOOLBAR~PROCESS_FUNCSEL .
  aliases PROCESS_SYSEV_DDCLICKED
    for IF_ISH_CONFIG_TOOLBAR~PROCESS_SYSEV_DDCLICKED .
  aliases PROCESS_SYSEV_FUNCSEL
    for IF_ISH_CONFIG_TOOLBAR~PROCESS_SYSEV_FUNCSEL .

  constants CO_OTYPE_CONFIG_TOOLBAR type ISH_OBJECT_TYPE value 12232. "#EC NOTEXT

  class-methods CREATE
    exporting
      !ER_INSTANCE type ref to CL_ISH_CONFIG_TOOLBAR
      !ER_INTERFACE type ref to IF_ISH_CONFIG_TOOLBAR
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_CONFIG_TOOLBAR
*"* do not include other source files here!!!

  methods FILL_INSTANCE_BY_CONFIG
    importing
      !IR_CONFIG type ref to CL_ISH_CONFIG_TOOLBAR
      value(I_COPY) type ISH_ON_OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_CONFIG_TOOLBAR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_CONFIG_TOOLBAR IMPLEMENTATION.


METHOD create.

  CREATE OBJECT er_instance.
  er_interface = er_instance.

ENDMETHOD.


METHOD FILL_INSTANCE_BY_CONFIG.
* not implemented jet
ENDMETHOD.


METHOD if_ish_config_toolbar~clone.
  DATA: lr_config TYPE REF TO cl_ish_config_toolbar,
        l_rc      TYPE ish_method_rc.

  CALL METHOD cl_ish_config_toolbar=>create
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


METHOD if_ish_config_toolbar~copy.
  DATA: lr_config TYPE REF TO cl_ish_config_toolbar,
        l_rc      TYPE ish_method_rc.

  CALL METHOD cl_ish_config_toolbar=>create
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


METHOD if_ish_config_toolbar~destroy.

  e_rc = 0.

ENDMETHOD.


METHOD if_ish_config_toolbar~modify_toolbar.

  e_modified = off.
  e_rc       = 0.

ENDMETHOD.


METHOD if_ish_config_toolbar~process_ddclicked.

  e_handled = off.
  e_rc      = 0.

ENDMETHOD.


METHOD if_ish_config_toolbar~process_funcsel.

  e_handled = off.
  e_rc      = 0.

ENDMETHOD.


METHOD if_ish_config_toolbar~process_sysev_ddclicked.

  e_process_as_ucomm = off.
  e_handled          = off.
  e_rc               = 0.

ENDMETHOD.


METHOD if_ish_config_toolbar~process_sysev_funcsel.

  e_process_as_ucomm = off.
  e_handled          = off.
  e_rc               = 0.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_config_toolbar.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_object_type TYPE i.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.
  IF l_object_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_config_toolbar.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.
ENDCLASS.
