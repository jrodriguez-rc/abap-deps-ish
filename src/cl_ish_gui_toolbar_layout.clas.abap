class CL_ISH_GUI_TOOLBAR_LAYOUT definition
  public
  inheriting from CL_ISH_GUI_CONTROL_LAYOUT
  create public .

public section.
*"* public components of class CL_ISH_GUI_TOOLBAR_LAYOUT
*"* do not include other source files here!!!

  constants CO_FIELDNAME_FVAR_FVARID type ISH_FIELDNAME value 'FVAR_FVARID'. "#EC NOTEXT
  constants CO_FIELDNAME_FVAR_VIEWTYPE type ISH_FIELDNAME value 'FVAR_VIEWTYPE'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_FVAR_VIEWTYPE type NVIEWTYPE optional
      !I_FVAR_FVARID type NFVARID optional
    preferred parameter I_ELEMENT_NAME .
  methods GET_FVAR
    returning
      value(RR_FVAR) type ref to CL_ISH_FVAR
    raising
      CX_ISH_FVAR .
  methods GET_FVAR_FVARID
    returning
      value(R_FVAR_FVARID) type NFVARID .
  methods GET_FVAR_VIEWTYPE
    returning
      value(R_FVAR_VIEWTYPE) type NVIEWTYPE .
  methods SET_FVAR_FVARID
    importing
      !I_FVAR_FVARID type NFVARID
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_FVAR_VIEWTYPE
    importing
      !I_FVAR_VIEWTYPE type NVIEWTYPE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GUI_TOOLBAR_LAYOUT
*"* do not include other source files here!!!

  data GS_DATA type RN1_GUI_LAYO_TOOLBAR_DATA .

  methods _GET_T_DATAREF
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_TOOLBAR_LAYOUT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_TOOLBAR_LAYOUT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name  = i_element_name
      i_layout_name   = i_layout_name ).

  gs_data-fvar_viewtype = i_fvar_viewtype.
  gs_data-fvar_fvarid   = i_fvar_fvarid.

ENDMETHOD.


METHOD get_fvar.

  CHECK gs_data-fvar_viewtype IS NOT INITIAL.
  CHECK gs_data-fvar_fvarid IS NOT INITIAL.

  rr_fvar = cl_ish_fvar_mgr=>get_fvar(
      i_viewtype = gs_data-fvar_viewtype
      i_fvarid   = gs_data-fvar_fvarid ).

ENDMETHOD.


METHOD get_fvar_fvarid.

  r_fvar_fvarid = gs_data-fvar_fvarid.

ENDMETHOD.


METHOD get_fvar_viewtype.

  r_fvar_viewtype = gs_data-fvar_viewtype.

ENDMETHOD.


METHOD set_fvar_fvarid.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_fvar_fvarid
      i_content   = i_fvar_fvarid ).

ENDMETHOD.


METHOD set_fvar_viewtype.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_fvar_viewtype
      i_content   = i_fvar_viewtype ).

ENDMETHOD.


METHOD _get_t_dataref.

  DATA lr_data            TYPE REF TO data.

  rt_dataref = super->_get_t_dataref( ).

  GET REFERENCE OF gs_data INTO lr_data.

  INSERT lr_data INTO TABLE rt_dataref.

ENDMETHOD.
ENDCLASS.
