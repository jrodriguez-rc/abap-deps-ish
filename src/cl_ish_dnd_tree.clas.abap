class CL_ISH_DND_TREE definition
  public
  inheriting from CL_ISH_DND
  abstract
  create public .

*"* public components of class CL_ISH_DND_TREE
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_DND_TREE type ISH_OBJECT_TYPE value 4028. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_SCR_ALV_TREE type ref to IF_ISH_SCR_ALV_TREE optional
      !I_FIELDNAME type LVC_FNAME optional .
  methods GET_SCR_ALV_TREE
    returning
      value(RR_SCR_ALV_TREE) type ref to IF_ISH_SCR_ALV_TREE .
  methods GET_FIELDNAME
    returning
      value(R_FIELDNAME) type LVC_FNAME .
  methods SET_SCR_ALV_TREE
    importing
      !IR_SCR_ALV_TREE type ref to IF_ISH_SCR_ALV_TREE
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods SET_FIELDNAME
    importing
      !I_FIELDNAME type LVC_FNAME
    returning
      value(R_SUCCESS) type ISH_ON_OFF .

  methods DESTROY
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods SET_SCR_CONTROL
    redefinition .
protected section.
*"* protected components of class CL_ISH_DND_TREE
*"* do not include other source files here!!!

  data G_FIELDNAME type LVC_FNAME .
private section.
*"* private components of class CL_ISH_DND_TREE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DND_TREE IMPLEMENTATION.


METHOD constructor.

  CALL METHOD super->constructor
    EXPORTING
      ir_scr_control = ir_scr_alv_tree.

  g_fieldname      = i_fieldname.

ENDMETHOD.


METHOD destroy.

  super->destroy( ).

  CLEAR g_fieldname.

ENDMETHOD.


METHOD get_fieldname.

  r_fieldname = g_fieldname.

ENDMETHOD.


METHOD get_scr_alv_tree.

  CLEAR rr_scr_alv_tree.

  CHECK gr_scr_control IS BOUND.
  CHECK gr_scr_control->is_inherited_from(
          cl_ish_scr_alv_tree=>co_otype_scr_alv_tree ) = on.

  rr_scr_alv_tree ?= gr_scr_control.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dnd_tree.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dnd_tree.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD set_fieldname.

  g_fieldname = i_fieldname.

  r_success = on.

ENDMETHOD.


METHOD set_scr_alv_tree.

  gr_scr_control = ir_scr_alv_tree.

  r_success = on.

ENDMETHOD.


METHOD set_scr_control.

* Initializations.
  r_success = off.

* Checking.
  IF ir_scr_control IS BOUND.
    CHECK ir_scr_control->is_inherited_from(
            cl_ish_scr_alv_tree=>co_otype_scr_alv_tree ) = on.
  ENDIF.

* Perform.
  r_success = super->set_scr_control( ir_scr_control ).

ENDMETHOD.
ENDCLASS.
