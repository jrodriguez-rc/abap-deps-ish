class CL_ISH_LB_DOMAIN definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_DOMAIN
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      !I_REFRESH type ISH_ON_OFF default OFF
      !I_FIELDNAME type VRM_ID
      !I_DOMAIN_NAME type DDOBJNAME
    exporting
      !E_RC type ISH_METHOD_RC
      !ER_LB_OBJECT type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_DOMAIN
*"* do not include other source files here!!!

  data G_DOMAIN_NAME type DDOBJNAME .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_DOMAIN
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_DOMAIN IMPLEMENTATION.


METHOD fill_listbox.

  DATA: lr_lb_object   TYPE REF TO cl_ish_listbox,
        lr_lb_domain   TYPE REF TO cl_ish_lb_domain,
        l_new          TYPE ish_on_off.

* Initializations.
  CLEAR: e_rc,
         er_lb_object.

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_DOMAIN'
      i_p1         = i_domain_name
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF NOT lr_lb_object IS BOUND.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox object is new -> save parameters.
  IF l_new = on.
    lr_lb_domain ?= lr_lb_object.
    lr_lb_domain->g_domain_name = i_domain_name.
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


METHOD generate_vrm_values.

  DATA: ls_vrm          LIKE LINE OF gt_vrm_values,
        lt_dd07v        TYPE STANDARD TABLE OF dd07v.

  FIELD-SYMBOLS: <ls_dd07v>  TYPE dd07v.
* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* Read domain values
  CALL FUNCTION 'DDUT_DOMVALUES_GET'
    EXPORTING
      name          = g_domain_name
      langu         = sy-langu
    TABLES
      dd07v_tab     = lt_dd07v
    EXCEPTIONS
      illegal_input = 1
      OTHERS        = 2.
  CHECK sy-subrc = 0.

* Fill gt_vrm_values
  LOOP AT lt_dd07v ASSIGNING <ls_dd07v>.
    ls_vrm-key  = <ls_dd07v>-domvalue_l.
    ls_vrm-text = <ls_dd07v>-ddtext.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
