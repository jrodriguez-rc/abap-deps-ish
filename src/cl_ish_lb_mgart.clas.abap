class CL_ISH_LB_MGART definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_MGART
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_EINRI) type EINRI
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_WLTYP
*"* do not include other source files here!!!

  data G_EINRI type EINRI .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_STSMA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_MGART IMPLEMENTATION.


METHOD FILL_LISTBOX .

  DATA: l_cordtypid   TYPE n1cordtyp-cordtypid,
        lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_mgart   TYPE REF TO cl_ish_lb_mgart,
        l_new         TYPE ish_on_off.

* Check parameters.
  IF i_einri IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_MGART'
      i_p1         = i_einri
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox object is new -> save parameters.
  IF l_new = on.
    lr_lb_mgart ?= lr_lb_object.
    lr_lb_mgart->g_einri = i_einri.
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


METHOD GENERATE_VRM_VALUES .

  DATA: ls_vrm         LIKE LINE OF gt_vrm_values,
        lt_tn16t       TYPE TABLE OF tn16t.

  FIELD-SYMBOLS: <ls_tn16t>  TYPE tn16t.

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

  CHECK NOT g_einri IS INITIAL.

* Read from db
  SELECT *
      FROM tn16t
      INTO TABLE lt_tn16t
      WHERE einri = g_einri  AND
            spras = sy-langu.

* Fill gt_vrm_values
  LOOP AT lt_tn16t ASSIGNING <ls_tn16t>.
    ls_vrm-key  = <ls_tn16t>-mgart.
    ls_vrm-text = <ls_tn16t>-mtext.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
