class CL_ISH_DND definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_DND
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_DND type ISH_OBJECT_TYPE value 4026. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_SCR_CONTROL type ref to IF_ISH_SCR_CONTROL optional .
  methods DESTROY .
  methods GET_SCR_CONTROL
    returning
      value(RR_SCR_CONTROL) type ref to IF_ISH_SCR_CONTROL .
  methods SET_SCR_CONTROL
    importing
      !IR_SCR_CONTROL type ref to IF_ISH_SCR_CONTROL
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
protected section.
*"* protected components of class CL_ISH_DRAGDROP
*"* do not include other source files here!!!

  data GR_SCR_CONTROL type ref to IF_ISH_SCR_CONTROL .
private section.
*"* private components of class CL_ISH_DND
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DND IMPLEMENTATION.


METHOD constructor.

  gr_scr_control = ir_scr_control.

ENDMETHOD.


METHOD destroy.

  CLEAR gr_scr_control.

ENDMETHOD.


METHOD get_scr_control.

  rr_scr_control = gr_scr_control.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dnd.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_object_type  TYPE i.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF i_object_type = l_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dnd.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD set_scr_control.

  gr_scr_control = ir_scr_control.

  r_success = on.

ENDMETHOD.
ENDCLASS.
