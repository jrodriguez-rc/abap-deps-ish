class CL_ISH_LB_LAYOUT definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_LAYOUT
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
*"* protected components of class CL_ISH_LB_LAYOUT
*"* do not include other source files here!!!

  data G_VIEWTYPE type NVIEWTYPE .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_LAYOUT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_LAYOUT IMPLEMENTATION.


METHOD fill_listbox .

  DATA: lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_layout  TYPE REF TO cl_ish_lb_layout,
        l_new         TYPE ish_on_off.

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_LAYOUT'
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
    lr_lb_layout ?= lr_lb_object.
    lr_lb_layout->g_viewtype = i_viewtype.
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
        lt_disvariant  TYPE ish_t_disvariant,
        l_rc           TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_disvariant>  TYPE disvariant.

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* Get all available layouts.
  CALL FUNCTION 'ISHMED_VM_AVAR_GET'
    EXPORTING
      i_viewtype    = g_viewtype
    IMPORTING
      e_rc          = l_rc
    TABLES
      et_disvariant = lt_disvariant.
* l_rc<>0 means that there are no layouts.
  CHECK l_rc = 0.

* Now process the layouts.
  LOOP AT lt_disvariant ASSIGNING <ls_disvariant>.
    CLEAR ls_vrm.
    ls_vrm-key  = <ls_disvariant>-variant.
    ls_vrm-text = <ls_disvariant>-text.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

  SORT gt_vrm_values BY text.

ENDMETHOD.
ENDCLASS.
