class CL_ISH_COMPONENT_CUST definition
  public
  inheriting from CL_ISH_COMPONENT
  abstract
  create public .

*"* public components of class CL_ISH_COMPONENT_CUST
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_COMPONENT_CUST .

  constants CO_OTYPE_COMPONENT_CUST type ISH_OBJECT_TYPE value 3011. "#EC NOTEXT

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMPONENT_CUST
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_COMPONENT_CUST
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMPONENT_CUST IMPLEMENTATION.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_component_cust.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_component_cust.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
