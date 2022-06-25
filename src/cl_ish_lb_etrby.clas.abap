class CL_ISH_LB_ETRBY definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_ETRBY
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_EINRI) type EINRI
      value(I_ETRBY) type N1CORDER-ETRBY
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_ETRBY
*"* do not include other source files here!!!

  data G_ETRBY type N1CORDER-ETRBY .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_STSMA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_ETRBY IMPLEMENTATION.


METHOD fill_listbox .

* definitions
  DATA: l_einri                  TYPE tn01-einri,
        l_new                    TYPE ish_on_off.
* object references
  DATA: lr_lb_object             TYPE REF TO cl_ish_listbox,
        lr_lb_etrby              TYPE REF TO cl_ish_lb_etrby.

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_ETRBY'
      i_p1         = i_etrby
*     Give also the etrby as identifier, because if this
*     type has also a set LOEKZ, maybe no entry for this type
*     would be shown in the listbox (if this listbox was build
*     for another dynpro-field, where the entries with set LOEKZ
*     have been deleted from the internal table)
    IMPORTING
      er_lb_object = lr_lb_object.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  lr_lb_etrby ?= lr_lb_object.
* set acutal etrby
  lr_lb_etrby->g_etrby   =  i_etrby.
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


METHOD GENERATE_VRM_VALUES .

  DATA: ls_vrm         LIKE LINE OF gt_vrm_values,
        lt_dd07v       TYPE TABLE OF dd07v.

  FIELD-SYMBOLS: <ls_dd07v>   TYPE dd07v.

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* get domain values
  CALL FUNCTION 'GET_DOMAIN_VALUES'
    EXPORTING
      domname               = 'N1CORDETRBY'
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

* Generate the entries.
  LOOP AT lt_dd07v ASSIGNING <ls_dd07v>.
    ls_vrm-key  = <ls_dd07v>-domvalue_l.
    ls_vrm-text = <ls_dd07v>-ddtext.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
