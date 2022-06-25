class CL_ISH_LB_ESTAT definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_ESTAT
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      !IR_STSMA type ref to CL_ISH_STSMA
      value(I_ESTAT) type J_ESTAT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_ESTAT
*"* do not include other source files here!!!

  data GR_STSMA type ref to CL_ISH_STSMA .
  data G_ESTAT type J_ESTAT .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_STSMA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_ESTAT IMPLEMENTATION.


METHOD fill_listbox .

  DATA: lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_estat   TYPE REF TO cl_ish_lb_estat,
        l_stsma       TYPE j_stsma,
        l_new         TYPE ish_on_off.

* Get stsma id.
  IF NOT ir_stsma IS INITIAL.
    l_stsma = ir_stsma->get_stsma( ).
  ENDIF.

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_ESTAT'
      i_p1         = l_stsma
      i_p2         = i_estat
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox object is new -> save parameters.
  IF l_new = on.
    lr_lb_estat ?= lr_lb_object.
    lr_lb_estat->gr_stsma = ir_stsma.
    lr_lb_estat->g_estat  = i_estat.
  ENDIF.

* Process.
  CALL METHOD lr_lb_object->fill_listbox_internal
    EXPORTING
      i_refresh   = i_refresh
      i_fieldname = i_fieldname
    IMPORTING
      e_rc        = e_rc.
  CHECK e_rc = 0.

* Export the listbox object.
  er_lb_object = lr_lb_object.

ENDMETHOD.


METHOD generate_vrm_values .

  DATA: lt_estat             TYPE ish_t_estat,
        lr_estat             TYPE REF TO cl_ish_estat,
        l_estat              TYPE j_estat,
        ls_vrm               LIKE LINE OF gt_vrm_values,
        l_append             TYPE ish_on_off.

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* Process only if there is a stsma.
  CHECK NOT gr_stsma IS INITIAL.

* Get all estat.
  CALL METHOD gr_stsma->get_t_estat
    IMPORTING
      et_estat = lt_estat.

* For each estat one entry.
  l_append = on.
  LOOP AT lt_estat INTO lr_estat.
    CHECK NOT lr_estat IS INITIAL.
    CLEAR ls_vrm.
    CALL METHOD lr_estat->get_estat
      IMPORTING
        e_estat = l_estat.
    ls_vrm-key  = l_estat.
    ls_vrm-text = lr_estat->get_txt30( ).
    APPEND ls_vrm TO gt_vrm_values.
    IF l_append = on AND
       l_estat  = g_estat.
      l_append = off.
    ENDIF.
  ENDLOOP.
  IF l_append = on.
    ls_vrm-key  = g_estat.
    CALL METHOD gr_stsma->get_estat
      EXPORTING
        i_estat  = g_estat
      IMPORTING
        er_estat = lr_estat.
    IF lr_estat IS BOUND.
      ls_vrm-text = lr_estat->get_txt30( ).
    ELSE.
      ls_vrm-text = g_estat.
    ENDIF.
    APPEND ls_vrm TO gt_vrm_values.
  ENDIF.

ENDMETHOD.
ENDCLASS.
