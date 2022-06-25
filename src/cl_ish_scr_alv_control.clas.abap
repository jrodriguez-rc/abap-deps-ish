class CL_ISH_SCR_ALV_CONTROL definition
  public
  inheriting from CL_ISH_SCR_CONTROL
  abstract
  create public .

*"* public components of class CL_ISH_SCR_ALV_CONTROL
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_SCR_ALV_CONTROL type ISH_OBJECT_TYPE value 3014. "#EC NOTEXT

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_ALV_CONTROL
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SCR_ALV_CONTROL
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_ALV_CONTROL IMPLEMENTATION.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_scr_alv_control.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_scr_alv_control.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
