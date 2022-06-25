class CL_ISH_LB_ANFTY definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_ANFTY
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_ANFTY) type N1ANFTYP-ANFTY optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_ANFTY
*"* do not include other source files here!!!

  data G_ANFTY type N1ANFTYP-ANFTY .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_STSMA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_ANFTY IMPLEMENTATION.


METHOD fill_listbox .

  DATA: lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_anfty   TYPE REF TO cl_ish_lb_anfty,
        l_new         TYPE ish_on_off.

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_ANFTY'
      i_p1         = i_anfty
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* Save parameters.
  IF l_new = on.
    lr_lb_anfty ?= lr_lb_object.
    lr_lb_anfty->g_anfty = i_anfty.
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

  DATA: lt_n1anftyp  TYPE TABLE OF n1anftyp,
        ls_vrm         LIKE LINE OF gt_vrm_values.

  FIELD-SYMBOLS: <ls_n1anftyp>  TYPE n1anftyp.

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* Get all anfty from n1anftyp.
  SELECT *
    FROM n1anftyp
    INTO TABLE lt_n1anftyp.

  LOOP AT lt_n1anftyp ASSIGNING <ls_n1anftyp>.
    CHECK <ls_n1anftyp>-loekz = off OR
          <ls_n1anftyp>-anfty = g_anfty.
    CLEAR ls_vrm.
    ls_vrm-key  = <ls_n1anftyp>-anfty.
    ls_vrm-text = ls_vrm-key.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

  SORT gt_vrm_values BY text.

ENDMETHOD.
ENDCLASS.
