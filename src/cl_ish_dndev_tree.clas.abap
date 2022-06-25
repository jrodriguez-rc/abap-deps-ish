class CL_ISH_DNDEV_TREE definition
  public
  inheriting from CL_ISH_DNDEV
  create public .

*"* public components of class CL_ISH_DNDEV_TREE
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_DNDEV_TREE type ISH_OBJECT_TYPE value 4033. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT optional
      !IR_SOURCE type ref to CL_ISH_DND optional
      !IR_TARGET type ref to CL_ISH_DND_TREE optional
      !I_NKEY type LVC_NKEY optional .
  methods GET_NKEY
    returning
      value(R_NKEY) type LVC_NKEY .
  methods GET_TARGET
    returning
      value(RR_TARGET) type ref to CL_ISH_DND_TREE .
  methods SET_NKEY
    importing
      !I_NKEY type LVC_NKEY
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods SET_TARGET
    importing
      !IR_TARGET type ref to CL_ISH_DND_TREE
    returning
      value(R_SUCCESS) type ISH_ON_OFF .

  methods DESTROY
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_DNDEV_TREE
*"* do not include other source files here!!!

  data GR_TARGET type ref to CL_ISH_DND_TREE .
  data G_NKEY type LVC_NKEY .
private section.
*"* private components of class CL_ISH_DNDEV_TREE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DNDEV_TREE IMPLEMENTATION.


METHOD constructor.

  CALL METHOD super->constructor
    EXPORTING
      ir_dragdropobj = ir_dragdropobj
      ir_source      = ir_source.

  gr_target = ir_target.
  g_nkey    = i_nkey.

ENDMETHOD.


METHOD destroy.

  super->destroy( ).

* The target object must not be destroyed here but by the caller.

  CLEAR: gr_target,
         g_nkey.

ENDMETHOD.


METHOD get_nkey.

  r_nkey = g_nkey.

ENDMETHOD.


METHOD get_target.

  rr_target = gr_target.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dndev_tree.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dndev_tree.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD set_nkey.

  g_nkey = i_nkey.

  r_success = on.

ENDMETHOD.


METHOD set_target.

  gr_target = ir_target.

  r_success = on.

ENDMETHOD.
ENDCLASS.
