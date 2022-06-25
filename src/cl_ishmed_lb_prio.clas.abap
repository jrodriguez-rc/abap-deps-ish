class CL_ISHMED_LB_PRIO definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISHMED_LB_PRIO
*"* do not include other source files here!!!
public section.

  data GT_N1APRI type ISHMED_T_N1APRI .

  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_EINRI) type TN01-EINRI
      value(I_PRIO) type N1APRI_D optional
      value(I_USE_INT_KEY) type ISH_ON_OFF default SPACE
      !I_CORDER_ISNEW_FLAG type ISH_ON_OFF default SPACE
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISHMED_LB_PRIO
*"* do not include other source files here!!!

  data G_EINRI type TN01-EINRI .
  data G_PRIO type NTMN-BWPRIO .
  data G_USE_INT_KEY type ISH_ON_OFF value OFF. "#EC NOTEXT .
  class-data G_CORDER_ISNEW_FLAG type ISH_ON_OFF value SPACE. "#EC NOTEXT .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISHMED_LB_PRIO
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISHMED_LB_PRIO IMPLEMENTATION.


METHOD fill_listbox .

* definitions
  DATA: l_einri                  TYPE tn01-einri,
        l_new                    TYPE ish_on_off.
* object references
  DATA: lr_lb_object             TYPE REF TO cl_ish_listbox,
        lr_lb_prio               TYPE REF TO cl_ishmed_lb_prio.
* ---------- ---------- ----------
* ceck parameters.
  IF i_einri IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  l_einri = i_einri.
* ---------- ---------- ----------

* ---------- ---------- ---------- ----------
*BEGIN MED-48734 Oana Bocarnea
* if corder is new parameter
  g_corder_isnew_flag = i_corder_isnew_flag.
*END MED-48734
* ---------- ---------- ---------- ----------
* get listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISHMED_LB_PRIO'
      i_p1         = l_einri
      i_p2         = i_prio
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* if listbox object is new save parameters
  lr_lb_prio ?= lr_lb_object.
  IF l_new = on.
    lr_lb_prio->g_einri = l_einri.
  ENDIF.
  lr_lb_prio->g_use_int_key = i_use_int_key.
* set acutal priority
  lr_lb_prio->g_prio = i_prio.
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
  DATA: lt_n1apri                TYPE ishmed_t_n1apri.
* workareas
  FIELD-SYMBOLS:
        <ls_n1apri>              LIKE LINE OF lt_n1apri.
  DATA: ls_vrm                   LIKE LINE OF gt_vrm_values.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* refresh if necessary
* refresh ALWAYS, because of using int./ext. key (g_use_int_key)!
*  IF i_refresh = on.
  CLEAR: gt_vrm_values.
*  ENDIF.
  CHECK gt_vrm_values IS INITIAL.
* ---------- ---------- ----------
* check needed parameters
  CHECK NOT g_einri IS INITIAL.
* ---------- ---------- ----------
* if necessary read all priorities
  IF gt_n1apri IS INITIAL.
    SELECT * FROM n1apri INTO TABLE gt_n1apri
       WHERE einri =  g_einri.
  ENDIF.
* ---------- ---------- ----------
* remove values with "delete flag"; but not the actual value
  lt_n1apri = gt_n1apri.
  IF g_corder_isnew_flag <> ON.               "MED-48734 Oana Bocarnea


  DELETE lt_n1apri WHERE loekz =  on
                     AND apri  <> g_prio.

  ELSE.                                       "MED-48734 Oana Bocarnea
   DELETE lt_n1apri WHERE loekz =  on.        "MED-48734 Oana Bocarnea
  ENDIF.                                      "MED-48734 Oana Bocarnea
* ---------- ---------- ----------
* sort priorities
  SORT lt_n1apri BY apri DESCENDING aprie.
* fill listbox table
  CLEAR: gt_vrm_values.
  LOOP AT lt_n1apri ASSIGNING <ls_n1apri>.
    IF g_use_int_key = off.
      ls_vrm-key = <ls_n1apri>-aprie.
    ELSE.
      ls_vrm-key = <ls_n1apri>-apri.
    ENDIF.
*   get description of priority
    SELECT SINGLE apritxt FROM n1aprit INTO ls_vrm-text
           WHERE spras = sy-langu
             AND einri = g_einri
             AND aprie = <ls_n1apri>-aprie.
    IF sy-subrc <> 0.
      ls_vrm-text = ls_vrm-key.
*   KG, MED-8608 - Begin
*   if there is no text defined for the initial priority, the corresponding entry must not
*   be taken over into gt_vrm_values to prevent showing a '0' (only when g_use_int_key = on)
*    ENDIF.
    ELSE.
      IF g_use_int_key = on AND <ls_n1apri>-apri IS INITIAL AND ls_vrm-text IS INITIAL.
        CONTINUE.
      ENDIF.
    ENDIF.
*   KG, MED-8608 - End
    INSERT ls_vrm INTO TABLE gt_vrm_values.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
