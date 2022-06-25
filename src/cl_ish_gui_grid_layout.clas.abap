class CL_ISH_GUI_GRID_LAYOUT definition
  public
  inheriting from CL_ISH_GUI_CONTROL_LAYOUT
  create public .

public section.
*"* public components of class CL_ISH_GUI_GRID_LAYOUT
*"* do not include other source files here!!!

  constants CO_FIELDNAME_DISVAR_VARIANT type ISH_FIELDNAME value 'DISVAR_VARIANT'. "#EC NOTEXT
  constants CO_FIELDNAME_FVAR_FVARID type ISH_FIELDNAME value 'FVAR_FVARID'. "#EC NOTEXT
  constants CO_FIELDNAME_FVAR_VIEWTYPE type ISH_FIELDNAME value 'FVAR_VIEWTYPE'. "#EC NOTEXT

  class-methods LOAD_OR_CREATE
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_USERNAME type USERNAME default SY-UNAME
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !I_CHECK_ELEMENT_NAME type ABAP_BOOL default ABAP_TRUE
      !I_FVAR_VIEWTYPE type NVIEWTYPE optional
      !I_FVAR_VIEWTYPE_X type ABAP_BOOL default ABAP_FALSE
      !I_FVAR_FVARID type NFVARID optional
      !I_FVAR_FVARID_X type ABAP_BOOL default ABAP_FALSE
      !I_DISVAR_VARIANT type SLIS_VARI optional
      !I_DISVAR_VARIANT_X type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_GRID_LAYOUT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_FVAR_VIEWTYPE type NVIEWTYPE optional
      !I_FVAR_FVARID type NFVARID optional
      !I_DISVAR_VARIANT type SLIS_VARI optional
    preferred parameter I_ELEMENT_NAME .
  methods GET_DATA
    returning
      value(RS_DATA) type RN1_GUI_LAYO_GRID_DATA .
  methods GET_DISVAR_VARIANT
    returning
      value(R_DISVAR_VARIANT) type SLIS_VARI .
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
  methods SET_DISVAR_VARIANT
    importing
      !I_DISVAR_VARIANT type SLIS_VARI
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
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
*"* protected components of class CL_ISH_GUI_GRID_LAYOUT
*"* do not include other source files here!!!

  data GS_DATA type RN1_GUI_LAYO_GRID_DATA .
private section.
*"* private components of class CL_ISH_GUI_GRID_LAYOUT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_GRID_LAYOUT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name  = i_element_name
      i_layout_name   = i_layout_name ).

  gs_data-fvar_viewtype         = i_fvar_viewtype.
  gs_data-fvar_fvarid           = i_fvar_fvarid.
  gs_data-disvar_variant        = i_disvar_variant.

ENDMETHOD.


METHOD get_data.

  rs_data = gs_data.

ENDMETHOD.


METHOD GET_DISVAR_VARIANT.

  r_disvar_variant = gs_data-disvar_variant.

ENDMETHOD.


METHOD GET_FVAR.

  CHECK gs_data-fvar_viewtype IS NOT INITIAL.
  CHECK gs_data-fvar_fvarid IS NOT INITIAL.

  rr_fvar = cl_ish_fvar_mgr=>get_fvar(
      i_viewtype = gs_data-fvar_viewtype
      i_fvarid   = gs_data-fvar_fvarid ).

ENDMETHOD.


METHOD GET_FVAR_FVARID.

  r_fvar_fvarid = gs_data-fvar_fvarid.

ENDMETHOD.


METHOD GET_FVAR_VIEWTYPE.

  r_fvar_viewtype = gs_data-fvar_viewtype.

ENDMETHOD.


METHOD load_or_create.

  DATA l_layout_name            TYPE n1gui_layout_name.

* Try to load the layout.
  DO 1 TIMES.
*   Loading is done by the application -> the application has to be specified.
    CHECK ir_application IS BOUND.
*   Determine the layout name.
    IF i_layout_name IS INITIAL.
      l_layout_name = i_element_name.
    ELSE.
      l_layout_name = i_layout_name.
    ENDIF.
    CHECK l_layout_name IS NOT INITIAL.
*   Let the application load the layout.
    TRY.
        rr_instance ?= ir_application->load_layout(
            i_layout_name = l_layout_name
            i_username    = i_username ).
      CATCH cx_ish_static_handler
            cx_sy_move_cast_error.
        CLEAR rr_instance.
    ENDTRY.
    CHECK rr_instance IS BOUND.
*   Check the element_name.
    IF i_check_element_name = abap_true AND
       rr_instance->get_element_name( ) <> i_element_name.
      CLEAR rr_instance.
      EXIT.
    ENDIF.
*   Take over the specified properties.
    IF i_fvar_viewtype_x = abap_true.
      rr_instance->set_fvar_viewtype( i_fvar_viewtype ).
    ENDIF.
    IF i_fvar_fvarid_x = abap_true.
      rr_instance->set_fvar_fvarid( i_fvar_fvarid ).
    ENDIF.
    IF i_disvar_variant_x = abap_true.
      rr_instance->set_disvar_variant( i_disvar_variant ).
    ENDIF.
*   The layout was loaded.
    RETURN.
  ENDDO.

* The layout was not loaded. So create it.
  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name   = i_element_name
      i_layout_name    = i_layout_name
      i_fvar_viewtype  = i_fvar_viewtype
      i_fvar_fvarid    = i_fvar_fvarid
      i_disvar_variant = i_disvar_variant.

ENDMETHOD.


METHOD SET_DISVAR_VARIANT.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_disvar_variant
      i_content   = i_disvar_variant ).

ENDMETHOD.


METHOD SET_FVAR_FVARID.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_fvar_fvarid
      i_content   = i_fvar_fvarid ).

ENDMETHOD.


METHOD SET_FVAR_VIEWTYPE.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_fvar_viewtype
      i_content   = i_fvar_viewtype ).

ENDMETHOD.
ENDCLASS.
