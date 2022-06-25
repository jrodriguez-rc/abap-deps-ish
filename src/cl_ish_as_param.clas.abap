class CL_ISH_AS_PARAM definition
  public
  abstract
  create public
  shared memory enabled

  global friends CL_ISH_AS_LOADER
                 CL_ISH_AS_MASTER .

*"* public components of class CL_ISH_AS_PARAM
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_AS_PARAM type ISH_OBJECT_TYPE value 12029. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_PARAMID type N1ASPARAMID
      !I_DEFAULT_VALUE type N1ASVALUE default SPACE .
  methods GET_DEFAULT_VALUE
    returning
      value(R_VALUE) type N1ASVALUE .
  methods GET_PARAMID
  final
    returning
      value(R_PARAMID) type N1ASPARAMID .
  methods INVALIDATE
  final .
  methods IS_INVALID
  final
    returning
      value(R_INVALID) type ISH_ON_OFF .
protected section.
*"* protected components of class CL_ISH_AS_PARAM
*"* do not include other source files here!!!

  methods CREATE_ASM_PARAM
  abstract
    returning
      value(RR_ASM_PARAM) type ref to CL_ISH_ASM_PARAM
    raising
      CX_ISH_STATIC_HANDLER .
  methods DESTROY
  abstract .
  methods INITIALIZE
  abstract .
private section.
*"* private components of class CL_ISH_AS_PARAM
*"* do not include other source files here!!!

  data G_DEFAULT_VALUE type N1ASVALUE .
  data G_INVALID type ISH_ON_OFF .
  data G_PARAMID type N1ASPARAMID .
ENDCLASS.



CLASS CL_ISH_AS_PARAM IMPLEMENTATION.


METHOD constructor.

  g_paramid       = i_paramid.
  g_default_value = i_default_value.

ENDMETHOD.


METHOD get_default_value.

  r_value = g_default_value.

ENDMETHOD.


METHOD get_paramid.

  r_paramid = g_paramid.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_as_param.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_type  TYPE ish_object_type.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_type.

  IF i_object_type = l_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_as_param.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD invalidate.

  g_invalid = on.

ENDMETHOD.


METHOD is_invalid.

  r_invalid = g_invalid.

ENDMETHOD.
ENDCLASS.
