class CL_ISH_LB_FALAR definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_FALAR
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_FALAR) type NFAL-FALAR
      value(I_BEWTY) type BEWTY optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_FALAR
*"* do not include other source files here!!!

  data G_FALAR type NFAL-FALAR .
  data G_BEWTY type BEWTY .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_FALAR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_FALAR IMPLEMENTATION.


METHOD fill_listbox .

  DATA: l_new                    TYPE ish_on_off.

  DATA: lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_falar             TYPE REF TO cl_ish_lb_falar.
* ---------- ---------- ----------

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_FALAR'
      i_p1         = i_falar
      i_p2         = i_bewty                  "ID: 14675
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

  lr_lb_falar            ?= lr_lb_object.
  IF l_new = on.
    lr_lb_falar->g_falar =  i_falar.
*   Käfer, ID: 14675 - Begin
    lr_lb_falar->g_bewty = i_bewty.
*   Käfer, ID: 14675 - End
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
        lt_dd07t       TYPE TABLE OF dd07t.

  FIELD-SYMBOLS: <ls_dd07t>   TYPE dd07t.

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* Read from db
  SELECT *
    FROM dd07t INTO TABLE lt_dd07t
    WHERE domname    = 'FALLART'   AND
          ddlanguage =  sy-langu.

* Generate the entries.
  LOOP AT lt_dd07t ASSIGNING <ls_dd07t>.
*   Käfer, ID: 14675 - Begin
    IF g_bewty = '1' AND <ls_dd07t>-domvalue_l = '2'.
      CONTINUE.
    ENDIF.
*   Käfer, ID: 14520 - End
    ls_vrm-key  = <ls_dd07t>-domvalue_l.
    ls_vrm-text = <ls_dd07t>-ddtext.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
