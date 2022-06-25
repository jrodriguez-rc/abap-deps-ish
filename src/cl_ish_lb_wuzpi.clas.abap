class CL_ISH_LB_WUZPI definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_WUZPI
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_EINRI) type EINRI
      value(I_ZPITY) type N1ZPI-ZPITY optional
      value(I_ZPI) type N1ZPI-ZPI optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_WUZPI
*"* do not include other source files here!!!

  data G_EINRI type EINRI .
  data G_ZPITY type N1ZPI-ZPITY .
  data G_ZPI type N1ZPI-ZPI .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_STSMA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_WUZPI IMPLEMENTATION.


METHOD fill_listbox .

  DATA: l_cordtypid   TYPE n1cordtyp-cordtypid,
        lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_wuzpi   TYPE REF TO cl_ish_lb_wuzpi,
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
      i_classname  = 'CL_ISH_LB_WUZPI'
*      i_p1         = i_einri
*      i_p2         = i_zpity
*      i_p3         = i_zpi
      i_p1         = i_zpi
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox object is new -> save parameters.
  IF l_new = on.
    lr_lb_wuzpi ?= lr_lb_object.
    lr_lb_wuzpi->g_einri = i_einri.
    lr_lb_wuzpi->g_zpity = i_zpity.
    lr_lb_wuzpi->g_zpi   = i_zpi.
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
        lt_n1zpi       TYPE TABLE OF n1zpi.

  FIELD-SYMBOLS: <ls_n1zpi>  TYPE n1zpi.

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
  SELECT * FROM n1zpi INTO TABLE lt_n1zpi    "#EC CI_BYPASS
      WHERE einri = g_einri
        AND zpity = g_zpity
   ORDER BY rfgnr.

* Remove values with delete-flag.
  DELETE lt_n1zpi
    WHERE loekz =  on
      AND zpity <> g_zpity.

* Fill gt_vrm_values
  LOOP AT lt_n1zpi ASSIGNING <ls_n1zpi>.
*    CONCATENATE g_einri g_zpity <ls_n1zpi>-zpi INTO ls_vrm-key.
    ls_vrm-key = <ls_n1zpi>-zpi.
*   Get text.
    SELECT SINGLE zpitxt
        FROM n1zpit
        INTO ls_vrm-text
        WHERE spras = sy-langu
          AND einri = g_einri
          AND zpie = <ls_n1zpi>-zpie.
    IF sy-subrc <> 0.
      ls_vrm-text = ls_vrm-key.
    ENDIF.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
