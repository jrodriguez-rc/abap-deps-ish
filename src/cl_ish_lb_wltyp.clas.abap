class CL_ISH_LB_WLTYP definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_WLTYP
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_EINRI) type EINRI
      value(I_WLTYP) type ISH_WLTYPE optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_WLTYP
*"* do not include other source files here!!!

  data G_EINRI type EINRI .
  data G_WLTYP type ISH_WLTYPE .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_STSMA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_WLTYP IMPLEMENTATION.


METHOD fill_listbox .

  DATA: l_cordtypid   TYPE n1cordtyp-cordtypid,
        lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_wltyp   TYPE REF TO cl_ish_lb_wltyp,
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
      i_classname  = 'CL_ISH_LB_WLTYP'
      i_p1         = i_einri
      i_p2         = i_wltyp
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox object is new -> save parameters.
  IF l_new = on.
    lr_lb_wltyp ?= lr_lb_object.
    lr_lb_wltyp->g_einri = i_einri.
    lr_lb_wltyp->g_wltyp = i_wltyp.
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
        lt_tn42a       TYPE TABLE OF tn42a.

  FIELD-SYMBOLS: <ls_tn42a>  TYPE tn42a.

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
      FROM tn42a
      INTO TABLE lt_tn42a
      WHERE einri = g_einri.

* Remove values with delete-flag.
  DELETE lt_tn42a
    WHERE loekz =  on
      AND wltyp <> g_wltyp.

* Fill gt_vrm_values
  LOOP AT lt_tn42a ASSIGNING <ls_tn42a>.
    ls_vrm-key  = <ls_tn42a>-wltyp.
*   Get text.
    SELECT SINGLE wlttx
        FROM tn42t
        INTO ls_vrm-text
        WHERE spras = sy-langu
          AND einri = g_einri
          AND wltyp = <ls_tn42a>-wltyp.
    IF sy-subrc <> 0.
      ls_vrm-text = ls_vrm-key.
    ENDIF.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
