class CL_ISH_LB_MONCON definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_MONCON
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_FIELDNAME) type VRM_ID
      value(I_MONCON_ID) type N1MONCON_ID optional
      value(I_AREA_ID) type N1MONCON_AREAID
      value(I_REFRESH) type ISH_ON_OFF default OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_MONCON
*"* do not include other source files here!!!

  data G_AREA_ID type N1MONCON_AREAID .
  data G_MONCON_ID type N1MONCON_ID .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_MONCON
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_MONCON IMPLEMENTATION.


METHOD fill_listbox .

  DATA: lr_lb_object    TYPE REF TO cl_ish_listbox,
        lr_lb_moncon    TYPE REF TO cl_ish_lb_moncon,
        l_new           TYPE ish_on_off.

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_MONCON'
      i_p1         = i_moncon_id
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox object is new -> save parameters.
  IF l_new = on.
    lr_lb_moncon ?= lr_lb_object.
    lr_lb_moncon->g_moncon_id = i_moncon_id.
    lr_lb_moncon->g_area_id   = i_area_id.
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

  DATA: ls_vrm                LIKE LINE OF gt_vrm_values,
        lt_moncon             TYPE TABLE OF v_n1moncon.

  FIELD-SYMBOLS: <ls_moncon>  TYPE v_n1moncon.

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* Get all available records
  SELECT * FROM v_n1moncon INTO TABLE lt_moncon
         WHERE  area_id  = g_area_id
         AND    spras    = sy-langu.

* Now process the records
  LOOP AT lt_moncon ASSIGNING <ls_moncon>.
    CLEAR ls_vrm.
    ls_vrm-key  = <ls_moncon>-moncon_id.
    ls_vrm-text = <ls_moncon>-moncon_name.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

  IF g_moncon_id IS NOT INITIAL.
    READ TABLE lt_moncon with key moncon_id = g_moncon_id
      TRANSPORTING no fields.
    IF sy-subrc <> 0.
      CLEAR ls_vrm.
      ls_vrm-key  = g_moncon_id.
      ls_vrm-text = g_moncon_id.
      APPEND ls_vrm TO gt_vrm_values.
    ENDIF.
  ENDIF.

  SORT gt_vrm_values BY text.

ENDMETHOD.
ENDCLASS.
