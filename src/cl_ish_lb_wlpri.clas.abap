class CL_ISH_LB_WLPRI definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_WLPRI
*"* do not include other source files here!!!
public section.

  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_EINRI) type TN01-EINRI
      value(I_WLPRI) type N1CORDER-WLPRI
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_WLPRI
*"* do not include other source files here!!!

  data G_EINRI type TN01-EINRI .
  data G_WLPRI type N1CORDER-WLPRI .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISHMED_LB_TRANSP
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_WLPRI IMPLEMENTATION.


METHOD FILL_LISTBOX .

* definitions
  DATA: l_einri                  TYPE tn01-einri,
        l_new                    TYPE ish_on_off.
* object references
  DATA: lr_lb_object             TYPE REF TO cl_ish_listbox,
        lr_lb_WLPRI              TYPE REF TO cl_ish_lb_WLPRI.
* ---------- ---------- ----------
* ceck parameters.
  IF i_einri IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  l_einri = i_einri.
* ---------- ---------- ----------
* get listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_WLPRI'
      i_p1         = l_einri
      i_p2         = i_wlpri
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* if listbox object is new save parameters
  IF l_new = on.
    lr_lb_WLPRI          ?= lr_lb_object.
    lr_lb_WLPRI->g_einri =  l_einri.
    lr_lb_wlpri->g_wlpri = i_wlpri.
  ENDIF.
* ---------- ---------- ----------
* now call method of superclass to fill the listbox
  CALL METHOD lr_lb_object->fill_listbox_internal
    EXPORTING
      i_refresh   = i_refresh
      i_fieldname = i_fieldname
    IMPORTING
      e_rc        = e_rc.
  CHECK e_rc = 0.
* ---------- ---------- ----------
* return listbox object
  er_lb_object = lr_lb_object.
* ---------- ---------- ----------

ENDMETHOD.


METHOD generate_vrm_values .

* local tables
  DATA: lt_tn14p                TYPE STANDARD TABLE OF tn14p.
* workareas
  FIELD-SYMBOLS:
        <ls_tn14p>              LIKE LINE OF lt_tn14p.
  DATA: ls_vrm                   LIKE LINE OF gt_vrm_values.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* refresh if necessary
  IF i_refresh = on.
    CLEAR: gt_vrm_values.
  ENDIF.
* ---------- ---------- ----------
* if listbox isn't empty leave method
  CHECK gt_vrm_values IS INITIAL.
* ---------- ---------- ----------
* listbox is empty
* check needed parameters
  CHECK NOT g_einri IS INITIAL.
* ---------- ---------- ----------
* get transport types
  CLEAR: lt_tn14p.
  SELECT * FROM tn14p INTO TABLE lt_tn14p
     WHERE einri =  g_einri.

* Remove values with delete-flag.
  DELETE lt_tn14p
    WHERE loekz =  on
      AND wlpri <> g_wlpri.

  SORT lt_tn14p BY wlpri DESCENDING wlpri.
  LOOP AT lt_tn14p ASSIGNING <ls_tn14p>.
    ls_vrm-key = <ls_tn14p>-wlpri.
*   get description of transport type
    SELECT SINGLE prtxt FROM tn14q
       INTO ls_vrm-text
          WHERE spras = sy-langu
            AND einri = g_einri
            AND wlpri = ls_vrm-key.
    IF sy-subrc <> 0.
      ls_vrm-text = ls_vrm-key.
    ENDIF.
    INSERT ls_vrm INTO TABLE gt_vrm_values.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
