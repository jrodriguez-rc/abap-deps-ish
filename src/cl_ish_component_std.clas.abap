class CL_ISH_COMPONENT_STD definition
  public
  inheriting from CL_ISH_COMPONENT
  abstract
  create public .

*"* public components of class CL_ISH_COMPONENT_STD
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_COMPONENT_STD .

  constants CO_OTYPE_COMPONENT_STD type ISH_OBJECT_TYPE value 3010. "#EC NOTEXT

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMPONENT_STD
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_COMPONENT_STD
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMPONENT_STD IMPLEMENTATION.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_component_std.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_component_std.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
