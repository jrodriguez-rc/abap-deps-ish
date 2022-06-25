class CL_ISH_LB_WUMNT definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_WUMNT
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_WUMNT) type N1APCN-WUMNT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_WUMNT
*"* do not include other source files here!!!

  data G_EINRI type EINRI .
  data G_WUMNT type N1APCN-WUMNT .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_STSMA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_WUMNT IMPLEMENTATION.


METHOD fill_listbox .

  DATA: lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_wumnt   TYPE REF TO cl_ish_lb_wumnt,
        l_new         TYPE ish_on_off.

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_WUMNT'
      i_p1         = i_wumnt
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox object is new -> save parameters.
  IF l_new = on.
    lr_lb_wumnt ?= lr_lb_object.
    lr_lb_wumnt->g_wumnt = i_wumnt.
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
        lt_dd07v   TYPE STANDARD TABLE OF dd07v,
        l_wa_dd07v LIKE LINE OF lt_dd07v.

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* get the domain values from the field n1monat
  CALL FUNCTION 'GET_DOMAIN_VALUES'
    EXPORTING
      domname               = 'N1MONAT'
*     TEXT                  = 'X'
      fill_dd07l_tab        = off
    TABLES
      values_tab            = lt_dd07v
    EXCEPTIONS
      no_values_found       = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.
  LOOP AT lt_dd07v INTO l_wa_dd07v.
    CLEAR ls_vrm.
    ls_vrm-key  = l_wa_dd07v-domvalue_l.
**   the field for wumnt has to be made alphanumeric, because
**   otherwise it would harm problems to with the listbox
*    CONCATENATE 'X' ls_vrm-key INTO ls_vrm-key.
    ls_vrm-text = l_wa_dd07v-ddtext.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
