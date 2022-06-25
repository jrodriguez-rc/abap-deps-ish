class CL_ISH_DNDEV_GRID definition
  public
  inheriting from CL_ISH_DNDEV
  create public .

*"* public components of class CL_ISH_DNDEV_GRID
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_DNDEV_GRID type ISH_OBJECT_TYPE value 4032. "#EC NOTEXT

  type-pools CNDD .
  methods CONSTRUCTOR
    importing
      !IR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT optional
      !IR_SOURCE type ref to CL_ISH_DND optional
      !IR_TARGET type ref to CL_ISH_DND_GRID optional
      !IT_FLAVOR type CNDD_FLAVORS optional .
  methods GET_TARGET
    returning
      value(RR_TARGET) type ref to CL_ISH_DND_GRID .
  methods GET_FLAVORS
    returning
      value(RT_FLAVOR) type CNDD_FLAVORS .
  methods SET_TARGET
    importing
      !IR_TARGET type ref to CL_ISH_DND_GRID
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods SET_FLAVORS
    importing
      !IT_FLAVOR type CNDD_FLAVORS
    returning
      value(R_SUCCESS) type ISH_ON_OFF .

  methods DESTROY
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_DNDEV_GRID
*"* do not include other source files here!!!

  data GR_TARGET type ref to CL_ISH_DND_GRID .
  data GT_FLAVOR type CNDD_FLAVORS .
private section.
*"* private components of class CL_ISH_DNDEV_GRID
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DNDEV_GRID IMPLEMENTATION.


METHOD constructor.

  CALL METHOD super->constructor
    EXPORTING
      ir_dragdropobj = ir_dragdropobj
      ir_source      = ir_source.

  gr_target = ir_target.
  gt_flavor = it_flavor.

ENDMETHOD.


METHOD destroy.

  super->destroy( ).

* The target object must not be destroyed here but by the caller.

  CLEAR: gr_target,
         gt_flavor.

ENDMETHOD.


METHOD get_flavors.

  rt_flavor = gt_flavor.

ENDMETHOD.


METHOD get_target.

  rr_target = gr_target.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dndev_grid.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dndev_grid.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD set_flavors.

  gt_flavor = it_flavor.

  r_success = on.

ENDMETHOD.


METHOD set_target.

  gr_target = ir_target.

  r_success = on.

ENDMETHOD.
ENDCLASS.
