class CL_ISH_LB_WLSTA definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_WLSTA
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_EINRI) type EINRI
      value(I_WLSTA) type ISH_WLSTATUS optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_WLSTA
*"* do not include other source files here!!!

  data G_EINRI type EINRI .
  data G_WLSTA type ISH_WLSTATUS .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_STSMA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_WLSTA IMPLEMENTATION.


METHOD fill_listbox .

  DATA: l_cordtypid   TYPE n1cordtyp-cordtypid,
        lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_wlsta   TYPE REF TO cl_ish_lb_wlsta,
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
      i_classname  = 'CL_ISH_LB_WLSTA'
      i_p1         = i_einri
      i_p2         = i_wlsta
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox object is new -> save parameters.
  IF l_new = on.
    lr_lb_wlsta ?= lr_lb_object.
    lr_lb_wlsta->g_einri = i_einri.
    lr_lb_wlsta->g_wlsta = i_wlsta.
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
        lt_tn42v       TYPE TABLE OF tn42v,
        ls_tn42c       TYPE tn42c.

  FIELD-SYMBOLS: <ls_tn42v>  TYPE tn42v.

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
      FROM tn42v
      INTO TABLE lt_tn42v
      WHERE einri = g_einri  AND
            spras = sy-langu.

* Fill gt_vrm_values
  LOOP AT lt_tn42v ASSIGNING <ls_tn42v>.
*   Check LOEKZ
    SELECT SINGLE *
      FROM tn42c
      INTO ls_tn42c
      WHERE einri = <ls_tn42v>-einri
        AND wlsta = <ls_tn42v>-wlsta.
    CHECK sy-subrc = 0.
    CHECK ls_tn42c-loekz = off OR
          <ls_tn42v>-wlsta = g_wlsta.
*   Append listbox entry.
    ls_vrm-key  = <ls_tn42v>-wlsta.
    ls_vrm-text = <ls_tn42v>-wlstx.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
