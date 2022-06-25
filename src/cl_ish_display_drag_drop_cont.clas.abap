class CL_ISH_DISPLAY_DRAG_DROP_CONT definition
  public
  create public .

*"* public components of class CL_ISH_DISPLAY_DRAG_DROP_CONT
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

  data GT_SEL_OBJECT type ISH_T_SEL_OBJECT .
  data G_WP_DRAG_DROP_CONT type ref to CL_ISH_WP_DRAG_DROP_CONTAINER .
  data GR_DD_CONT_VARIABLE type ref to IF_ISH_IDENTIFY_OBJECT .
  constants CO_OTYPE_DD_OBJ_DISPLAY type ISH_OBJECT_TYPE value 4005. "#EC NOTEXT
protected section.
*"* protected components of class CL_ISH_DISPLAY_DRAG_DROP_CONT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DISPLAY_DRAG_DROP_CONT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DISPLAY_DRAG_DROP_CONT IMPLEMENTATION.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_dd_obj_display.

ENDMETHOD.


METHOD if_ish_identify_object~is_a .

  IF i_object_type = co_otype_dd_obj_display.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_dd_obj_display.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.
ENDCLASS.
