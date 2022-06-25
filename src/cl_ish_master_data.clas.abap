class CL_ISH_MASTER_DATA definition
  public
  inheriting from CL_ISH_DATA_OBJECT
  abstract
  create public .

*"* public components of class CL_ISH_MASTER_DATA
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_MASTER_DATA .

  aliases CHECK
    for IF_ISH_MASTER_DATA~CHECK .
  aliases SAVE
    for IF_ISH_MASTER_DATA~SAVE .

  constants CO_OTYPE_MASTER_DATA type ISH_OBJECT_TYPE value 3002. "#EC NOTEXT

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_MASTER_DATA
*"* do not include other source files here!!!

  methods SAVE_INTERNAL
  abstract
    importing
      value(I_TESTRUN) type ISH_ON_OFF default OFF
      value(I_TCODE) type SY-TCODE optional
    exporting
      value(E_RC) type I
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
private section.
*"* private components of class CL_ISH_MASTER_DATA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_MASTER_DATA IMPLEMENTATION.


METHOD if_ish_identify_object~get_type .
  e_object_type = co_otype_master_data.
ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_master_data.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


method IF_ISH_MASTER_DATA~CHECK.
endmethod.


METHOD if_ish_master_data~save .

* Initializations
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* SAVE only for active objects.
  CHECK g_active = on.

* Perform the real save.
  CALL METHOD save_internal
    EXPORTING
      i_testrun      = i_testrun
      i_tcode        = i_tcode
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.

ENDMETHOD.
ENDCLASS.
