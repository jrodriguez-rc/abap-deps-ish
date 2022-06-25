class CL_ISH_LB_RFSRC definition
  public
  inheriting from CL_ISH_LISTBOX
  create public .

*"* public components of class CL_ISH_LB_RFSRC
*"* do not include other source files here!!!
public section.

  class-methods FILL_LISTBOX
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
      value(I_EINRI) type TN01-EINRI
      value(I_BEWTY) type BEWTY
      value(I_RFSRC) type N1VKG-RFSRC
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX .
protected section.
*"* protected components of class CL_ISH_LB_RFSRC
*"* do not include other source files here!!!

  data G_EINRI type TN01-EINRI .
  data G_BEWTY type BEWTY .
  data G_RFSRC type N1VKG-RFSRC .

  methods GENERATE_VRM_VALUES
    redefinition .
private section.
*"* private components of class CL_ISHMED_LB_TRANSP
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LB_RFSRC IMPLEMENTATION.


METHOD fill_listbox .

* definitions
  DATA: l_einri                  TYPE tn01-einri,
        l_bewty                  TYPE bewty,
        l_new                    TYPE ish_on_off.
* object references
  DATA: lr_lb_object             TYPE REF TO cl_ish_listbox,
        lr_lb_rfsrc             TYPE REF TO cl_ish_lb_rfsrc.
* ---------- ---------- ----------
* check parameters.
  IF i_einri IS INITIAL OR i_bewty IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  l_einri = i_einri.
  l_bewty = i_bewty.
* ---------- ---------- ----------
* get listbox object
  CALL METHOD cl_ish_listbox=>get_lb_object
    EXPORTING
      i_refresh    = i_refresh
      i_classname  = 'CL_ISH_LB_RFSRC'
      i_p1         = l_einri
      i_p2         = l_bewty
      i_p3         = i_rfsrc
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
    lr_lb_rfsrc          ?= lr_lb_object.
    lr_lb_rfsrc->g_einri =  l_einri.
    lr_lb_rfsrc->g_bewty =  l_bewty.
    lr_lb_rfsrc->g_rfsrc =  i_rfsrc.
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

* workareas
  DATA: BEGIN OF ls_refsrc,
          refsrc    TYPE tn14y-refsrc,
          refsrctxt TYPE tn14y-refsrctxt,
        END OF ls_refsrc.

  DATA: lt_refsrc                 LIKE STANDARD TABLE OF ls_refsrc.
  FIELD-SYMBOLS: <refsrc>         LIKE LINE OF lt_refsrc.
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
* get referral types
  SELECT a~refsrc b~refsrctxt FROM
                 tn14h AS a INNER JOIN tn14y AS b      "#EC CI_BUFFJOIN
                         ON a~einri = b~einri AND
                            a~bewty = b~bewty AND
                            a~refsrc = b~refsrc
                            INTO TABLE lt_refsrc
                         WHERE a~einri   EQ g_einri
                           AND a~bewty   EQ g_bewty
                           AND b~spras   EQ sy-langu
                           AND a~inact   EQ off.       "IXX-239 NPopa 4.11.2014

* add values
  LOOP AT lt_refsrc ASSIGNING <refsrc>.
    ls_vrm-key  = <refsrc>-refsrc.
    ls_vrm-text = <refsrc>-refsrctxt.
    APPEND ls_vrm TO gt_vrm_values.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
