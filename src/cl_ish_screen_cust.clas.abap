class CL_ISH_SCREEN_CUST definition
  public
  inheriting from CL_ISH_SCREEN
  abstract
  create public .

*"* public components of class CL_ISH_SCREEN_CUST
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_SCREEN_CUST .

  constants CO_OTYPE_SCREEN_CUST type ISH_OBJECT_TYPE value 3006. "#EC NOTEXT

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCREEN_CUST
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SCREEN_CUST
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCREEN_CUST IMPLEMENTATION.


METHOD IF_ISH_IDENTIFY_OBJECT~GET_TYPE .

  e_object_type = co_otype_screen_cust.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_screen_cust.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
