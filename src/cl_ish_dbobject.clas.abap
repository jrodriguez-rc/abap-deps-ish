class CL_ISH_DBOBJECT definition
  public
  abstract
  create public
  shared memory enabled .

*"* public components of class CL_ISH_DBOBJECT
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

  constants CO_OTYPE_DBOBJECT type ISH_OBJECT_TYPE value 12161. "#EC NOTEXT
protected section.
*"* protected components of class CL_ISH_DBOBJECT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DBOBJECT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBOBJECT IMPLEMENTATION.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dbobject.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_type  TYPE ish_object_type.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_type.

  IF l_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dbobject.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.
ENDCLASS.
