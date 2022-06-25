class CL_ISH_DND_TREE_SINGLE definition
  public
  inheriting from CL_ISH_DND_TREE
  create public .

*"* public components of class CL_ISH_DND_TREE_SINGLE
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_DND_TREE_SINGLE type ISH_OBJECT_TYPE value 4029. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_SCR_ALV_TREE type ref to IF_ISH_SCR_ALV_TREE optional
      !I_FIELDNAME type LVC_FNAME optional
      !I_NKEY type LVC_NKEY optional .
  methods GET_NKEY
    returning
      value(R_NKEY) type LVC_NKEY .
  methods SET_NKEY
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(R_SUCCESS) type ISH_ON_OFF .

  methods DESTROY
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_DND_TREE_SINGLE
*"* do not include other source files here!!!

  data G_NKEY type LVC_NKEY .
private section.
*"* private components of class CL_ISH_DND_TREE_SINGLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DND_TREE_SINGLE IMPLEMENTATION.


METHOD constructor.

  CALL METHOD super->constructor
    EXPORTING
      ir_scr_alv_tree = ir_scr_alv_tree
      i_fieldname     = i_fieldname.

  g_nkey = i_nkey.

ENDMETHOD.


METHOD destroy.

  super->destroy( ).

  CLEAR g_nkey.

ENDMETHOD.


METHOD get_nkey.

  r_nkey = g_nkey.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dnd_tree_single.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dnd_tree_single.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD set_nkey.

  g_nkey = i_nkey.

  r_success = on.

ENDMETHOD.
ENDCLASS.
