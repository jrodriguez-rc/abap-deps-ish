class CL_ISH_LB_COMPCON definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_COMPCON
*"* do not include other source files here!!!
public section.

  type-pools VRM .
  class-methods FILL_LISTBOX
    importing
      value(I_FIELDNAME) type VRM_ID
      value(I_COMPID) type N1COMPID default SPACE
      value(I_REFRESH) type ISH_ON_OFF default ''
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ER_LB_OBJECT type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_COMPCON
*"* do not include other source files here!!!

  data G_COMPID type N1COMPID .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_LB_COMPCON
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_COMPCON IMPLEMENTATION.


METHOD fill_listbox.

  DATA: lr_lb_object  TYPE REF TO cl_ish_listbox,
        lr_lb_compcon TYPE REF TO cl_ish_lb_compcon,
        l_new         TYPE ish_on_off.

* Get the listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_COMPCON'
      i_p2         = i_compid
    IMPORTING
      er_lb_object = lr_lb_object
      e_new        = l_new.
  IF lr_lb_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox object is new -> save parameters.
  IF l_new = on.
    lr_lb_compcon ?= lr_lb_object.
    lr_lb_compcon->g_compid  = i_compid.
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


METHOD generate_vrm_values.

  DATA: ls_vrm        LIKE LINE OF gt_vrm_values,
        lt_n1compcon  TYPE ish_t_n1compcon,
        lt_n1compcont TYPE TABLE OF n1compcont.

  FIELD-SYMBOLS: <ls_n1compcon>  TYPE n1compcon,
                 <ls_n1compcont> TYPE n1compcont.

* Initializations
  CLEAR e_rc.

* Refresh?
  IF i_refresh = on.
    REFRESH gt_vrm_values.
  ENDIF.

* Processing needed?
  CHECK gt_vrm_values IS INITIAL.

* do the selection
  SELECT * FROM n1compcon INTO TABLE lt_n1compcon
    WHERE compid = g_compid.

  CHECK sy-subrc = 0.
  SELECT * FROM n1compcont INTO TABLE lt_n1compcont
    FOR ALL ENTRIES IN lt_n1compcon
    WHERE compconid = lt_n1compcon-compconid
      AND spras     = sy-langu.

* Now process the component configurations.
  LOOP AT lt_n1compcon ASSIGNING <ls_n1compcon>.
    CLEAR ls_vrm.
    READ TABLE lt_n1compcont ASSIGNING <ls_n1compcont>
      WITH KEY compconid = <ls_n1compcon>-compconid.
    CHECK sy-subrc = 0.
    ls_vrm-key  = <ls_n1compcont>-compconid.
    ls_vrm-text = <ls_n1compcont>-name.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.

  SORT gt_vrm_values BY text.

ENDMETHOD.
ENDCLASS.
