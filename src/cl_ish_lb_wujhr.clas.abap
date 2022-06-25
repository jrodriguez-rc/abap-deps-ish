class CL_ISH_LB_WUJHR definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_WUJHR
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_WUJHR) type N1APCN-WUJHR optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_WUJHR
*"* do not include other source files here!!!

  data G_EINRI type EINRI .
  data G_WUJHR type N1APCN-WUJHR .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_STSMA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_WUJHR IMPLEMENTATION.


METHOD fill_listbox .

  DATA: lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_wujhr   TYPE REF TO cl_ish_lb_wujhr,
        l_new         TYPE ish_on_off.

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_WUJHR'
      i_p1         = i_wujhr
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox object is new -> save parameters.
  IF l_new = on.
    lr_lb_wujhr ?= lr_lb_object.
    lr_lb_wujhr->g_wujhr = i_wujhr.
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

  DATA: ls_vrm         LIKE LINE OF gt_vrm_values,
        l_x            TYPE i,
        l_y            TYPE i,
        l_year(4).

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* there are shown 10 years up from now
  l_x = sy-datum(4).

* if there is worked with a year which is in past tense, then
* also show it
  l_y = g_wujhr.
  IF l_y < l_x  AND  NOT g_wujhr IS INITIAL.
    l_year = l_y.
    ls_vrm-key  = l_year.
    ls_vrm-text = ls_vrm-key.
    APPEND ls_vrm TO gt_vrm_values.
  ENDIF.

* Fill gt_vrm_values
  DO 10 TIMES.
    CLEAR ls_vrm.
    l_year = l_x.
    ls_vrm-key  = l_year.
    ls_vrm-text = ls_vrm-key.
    APPEND ls_vrm TO gt_vrm_values.
    l_x = l_x + 1.
  ENDDO.

ENDMETHOD.
ENDCLASS.
