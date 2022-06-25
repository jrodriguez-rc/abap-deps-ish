class CL_ISH_LB_IFG definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_IFG
*"* do not include other source files here!!!
public section.

  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_EINRI) type TN01-EINRI
      value(I_IFG) type N1CORDER-IFG
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_IFG
*"* do not include other source files here!!!

  data G_EINRI type TN01-EINRI .
  data G_IFG type N1CORDER-IFG .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISHMED_LB_TRANSP
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_IFG IMPLEMENTATION.


METHOD fill_listbox .

* definitions
  DATA: l_einri                  TYPE tn01-einri,
        l_new                    TYPE ish_on_off.
* object references
  DATA: lr_lb_object             TYPE REF TO cl_ish_listbox,
        lr_lb_ifg                TYPE REF TO cl_ish_lb_ifg.
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
      i_classname  = 'CL_ISH_LB_IFG'
      i_p1         = l_einri
      i_p2         = i_ifg
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
    lr_lb_ifg          ?= lr_lb_object.
    lr_lb_ifg->g_einri  = l_einri.
    lr_lb_ifg->g_ifg    = i_ifg.
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
  DATA: lt_n1ifg                TYPE STANDARD TABLE OF n1ifg.
* workareas
  FIELD-SYMBOLS:
        <ls_n1ifg>              LIKE LINE OF lt_n1ifg.
  DATA: ls_vrm                  LIKE LINE OF gt_vrm_values.
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
  CLEAR: lt_n1ifg.
  SELECT * FROM n1ifg INTO TABLE lt_n1ifg
     WHERE einri =  g_einri.

* Remove values with delete-flag.
  DELETE lt_n1ifg
    WHERE loekz =  on
      AND ifg <> g_ifg.

"  SORT lt_n1ifg BY ifg DESCENDING ifg.           "MED-58960 Madalina P. 24.06.2015
  SORT lt_n1ifg BY ifgprio DESCENDING ifgprio.    "MED-58960 Madalina P. 24.06.2015
  LOOP AT lt_n1ifg ASSIGNING <ls_n1ifg>.
    ls_vrm-key = <ls_n1ifg>-ifg.
*   get description of ifg
    SELECT SINGLE ifgtxt FROM n1ifgt
       INTO ls_vrm-text
          WHERE spras = sy-langu
            AND einri = g_einri
            AND ifge = <ls_n1ifg>-ifge.
    IF sy-subrc <> 0.
      ls_vrm-text = <ls_n1ifg>-ifge.
    ENDIF.
    INSERT ls_vrm INTO TABLE gt_vrm_values.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
