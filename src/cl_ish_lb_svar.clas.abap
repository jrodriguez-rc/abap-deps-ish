class CL_ISH_LB_SVAR definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_SVAR
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_FIELDNAME) type VRM_ID
      value(I_VIEWTYPE) type NVIEWTYPE
      value(I_REFRESH) type ISH_ON_OFF default ''
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_SVAR
*"* do not include other source files here!!!

  data G_REPORT type REPID .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_SVAR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_SVAR IMPLEMENTATION.


METHOD fill_listbox.

  DATA: lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_svar    TYPE REF TO cl_ish_lb_svar,
        l_new         TYPE ish_on_off,
        l_viewid      TYPE nviewid,
        l_report      TYPE repid.

  IF NOT i_viewtype IS INITIAL.
    PERFORM get_report_selvar IN PROGRAM sapln1workplace USING i_viewtype
                                                 l_viewid
                                        CHANGING l_report.
  endif.
* Get the listbox object
    CALL METHOD cl_ish_listbox=>get_lb_object
      EXPORTING
        i_refresh    = i_refresh
        i_classname  = 'CL_ISH_LB_SVAR'
        i_p1         = l_report
      IMPORTING
        er_lb_object = lr_lb_object
        e_new        = l_new.
    IF lr_lb_object IS INITIAL.
      e_rc = 1.
      EXIT.
    ENDIF.

* If the listbox object is new -> save parameters.
    IF l_new = on.
      lr_lb_svar ?= lr_lb_object.
      lr_lb_svar->g_report = l_report.
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

  DATA: ls_vrm         LIKE LINE OF gt_vrm_values,
        lt_vartext     TYPE TABLE OF rsvartext,
        l_rc           TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_vartext>  TYPE rsvartext.

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* Get all available layouts.
  CALL FUNCTION 'RS_ALL_VARIANTS_4_1_REPORT'
    EXPORTING
      program             = g_report
      text                = 'X'
    TABLES
      var_txt             = lt_vartext
    EXCEPTIONS
      report_not_existent = 1
      OTHERS              = 2.
  IF sy-subrc <> 0.
    REFRESH lt_vartext.
  ENDIF.

* l_rc<>0 means that there are no seleciton variants.
  CHECK l_rc = 0.

* Now process the selection variants.
  LOOP AT lt_vartext ASSIGNING <ls_vartext>.
*    CHECK <ls_vartext>-langu = sy-langu.
    CLEAR ls_vrm.
    ls_vrm-key  = <ls_vartext>-variant.
    ls_vrm-text = <ls_vartext>-vtext.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

  SORT gt_vrm_values BY text.

ENDMETHOD.
ENDCLASS.
