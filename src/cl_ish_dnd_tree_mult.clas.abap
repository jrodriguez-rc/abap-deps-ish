class CL_ISH_DND_TREE_MULT definition
  public
  inheriting from CL_ISH_DND_TREE
  create public .

*"* public components of class CL_ISH_DND_TREE_MULT
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_DND_TREE_MULT type ISH_OBJECT_TYPE value 4030. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_SCR_ALV_TREE type ref to IF_ISH_SCR_ALV_TREE optional
      !I_FIELDNAME type LVC_FNAME optional
      !IT_NKEY type LVC_T_NKEY optional .
  methods GET_T_NKEY
    returning
      value(RT_NKEY) type LVC_T_NKEY .
  methods HAS_NKEY
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(R_HAS_NKEY) type ISH_ON_OFF .
  methods ADD_NKEY
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods REMOVE_NKEY
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods SET_T_NKEY
    importing
      !IT_NKEY type LVC_T_NKEY
    returning
      value(R_SUCCESS) type ISH_ON_OFF .

  methods DESTROY
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_DND_TREE_MULT
*"* do not include other source files here!!!

  data GT_NKEY type LVC_T_NKEY .
private section.
*"* private components of class CL_ISH_DND_TREE_MULT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DND_TREE_MULT IMPLEMENTATION.


METHOD add_nkey.

  r_success = off.

  CHECK has_nkey( i_nkey ) = on.

  APPEND i_nkey TO gt_nkey.

  r_success = on.

ENDMETHOD.


METHOD constructor.

  CALL METHOD super->constructor
    EXPORTING
      ir_scr_alv_tree = ir_scr_alv_tree
      i_fieldname     = i_fieldname.

  gt_nkey = it_nkey.

ENDMETHOD.


METHOD destroy.

  super->destroy( ).

  CLEAR gt_nkey.

ENDMETHOD.


METHOD get_t_nkey.

  rt_nkey = gt_nkey.

ENDMETHOD.


METHOD has_nkey.

  r_has_nkey = off.

  READ TABLE gt_nkey
    FROM i_nkey
    TRANSPORTING NO FIELDS.
  CHECK sy-subrc <> 0.

  r_has_nkey = on.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dnd_tree_mult.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dnd_tree_mult.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD remove_nkey.

  r_success = off.

  DELETE gt_nkey FROM i_nkey.
  CHECK sy-subrc = 0.

  r_success = on.

ENDMETHOD.


METHOD set_t_nkey.

  gt_nkey = it_nkey.

  r_success = on.

ENDMETHOD.
ENDCLASS.
