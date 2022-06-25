class CL_ISH_LB_FVAR definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_FVAR
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_FIELDNAME) type VRM_ID
      value(I_VIEWTYPE) type NVIEWTYPE optional
      value(I_REFRESH) type ISH_ON_OFF default ''
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_FVAR
*"* do not include other source files here!!!

  data G_VIEWTYPE type NVIEWTYPE .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_FVAR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_FVAR IMPLEMENTATION.


METHOD fill_listbox .

  DATA: lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_fvar    TYPE REF TO cl_ish_lb_fvar,
        l_new         TYPE ish_on_off.

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_FVAR'
      i_p1         = i_viewtype
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox object is new -> save parameters.
  IF l_new = on.
    lr_lb_fvar ?= lr_lb_object.
    lr_lb_fvar->g_viewtype = i_viewtype.
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

  DATA: ls_vrm        LIKE LINE OF gt_vrm_values,
        lt_fvar       TYPE TABLE OF v_nwfvar.

  FIELD-SYMBOLS: <ls_fvar>  TYPE v_nwfvar.

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* Get all available fvars.
  CALL FUNCTION 'ISHMED_VM_FVAR_GET'
    EXPORTING
      i_viewtype = g_viewtype
    TABLES
      t_fvar     = lt_fvar.

* Now process the fvars.
  LOOP AT lt_fvar ASSIGNING <ls_fvar>.
    CLEAR ls_vrm.
    ls_vrm-key  = <ls_fvar>-fvar.
    ls_vrm-text = <ls_fvar>-txt.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

  SORT gt_vrm_values BY text.

ENDMETHOD.
ENDCLASS.
