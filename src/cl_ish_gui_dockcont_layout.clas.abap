class CL_ISH_GUI_DOCKCONT_LAYOUT definition
  public
  inheriting from CL_ISH_GUI_CONTAINER_LAYOUT
  create public .

public section.
*"* public components of class CL_ISH_GUI_DOCKCONT_LAYOUT
*"* do not include other source files here!!!

  constants CO_FIELDNAME_EXTENSION type ISH_FIELDNAME value 'EXTENSION'. "#EC NOTEXT
  constants CO_FIELDNAME_SIDE type ISH_FIELDNAME value 'SIDE'. "#EC NOTEXT

  type-pools ABAP .
  class CL_GUI_DOCKING_CONTAINER definition load .
  class-methods LOAD_OR_CREATE
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_USERNAME type USERNAME default SY-UNAME
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !I_CHECK_ELEMENT_NAME type ABAP_BOOL default ABAP_TRUE
      !I_SIDE type N1GUI_DOCKCONT_SIDE default CL_GUI_DOCKING_CONTAINER=>DOCK_AT_LEFT
      !I_SIDE_X type ABAP_BOOL default ABAP_FALSE
      !I_EXTENSION type N1GUI_DOCKCONT_EXTENSION default 300
      !I_EXTENSION_X type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_DOCKCONT_LAYOUT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_SIDE type N1GUI_DOCKCONT_SIDE default CL_GUI_DOCKING_CONTAINER=>DOCK_AT_LEFT
      !I_EXTENSION type N1GUI_DOCKCONT_EXTENSION default 300 .
  methods GET_DATA
    returning
      value(RS_DATA) type RN1_GUI_LAYO_DOCKCONT_DATA .
  methods GET_EXTENSION
    returning
      value(R_EXTENSION) type N1GUI_DOCKCONT_EXTENSION .
  methods GET_SIDE
    returning
      value(R_SIDE) type N1GUI_DOCKCONT_SIDE .
  methods SET_EXTENSION
    importing
      !I_EXTENSION type N1GUI_DOCKCONT_EXTENSION
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_SIDE
    importing
      !I_SIDE type N1GUI_DOCKCONT_SIDE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .

  methods NEW_CONFIG_CTR
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_DOCKCONT_LAYOUT
*"* do not include other source files here!!!

  data GS_DATA type RN1_GUI_LAYO_DOCKCONT_DATA .

  methods _GET_T_DATAREF
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_DOCKCONT_LAYOUT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_DOCKCONT_LAYOUT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name        = i_element_name
      i_layout_name         = i_layout_name ).

  gs_data-side      = i_side.
  gs_data-extension = i_extension.

ENDMETHOD.


METHOD get_data.

  rs_data = gs_data.

ENDMETHOD.


METHOD get_extension.

  r_extension = gs_data-extension.

ENDMETHOD.


METHOD get_side.

  r_side = gs_data-side.

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
    IF i_side_x = abap_true.
      rr_instance->set_side( i_side ).
    ENDIF.
    IF i_extension_x = abap_true.
      rr_instance->set_extension( i_extension ).
    ENDIF.
*   The layout was loaded.
    RETURN.
  ENDDO.

* The layout was not loaded. So create it.
  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name = i_element_name
      i_layout_name  = i_layout_name
      i_side         = i_side
      i_extension    = i_extension.

ENDMETHOD.


METHOD new_config_ctr.

  DATA lr_parent_view                   TYPE REF TO if_ish_gui_dynpro_view.
  DATA lr_config_ctr                    TYPE REF TO cl_ish_gc_simple.
  DATA lr_config_view                   TYPE REF TO cl_ish_gv_sdy_simple.

* The parent controller has to be specified.
  IF ir_parent_controller IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'NEW_CONFIG_CTR'
        i_mv3        = 'CL_ISH_GUI_DOCKCONT_LAYOUT' ).
  ENDIF.

* Get the parent view.
  TRY.
      lr_parent_view ?= ir_parent_controller->get_view( ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_parent_view.
  ENDTRY.

* Create and initialize the config ctr + view.
  lr_config_ctr = cl_ish_gc_simple=>create(
      i_element_name = i_ctrname ).
  lr_config_view = cl_ish_gv_sdy_simple=>create(
      i_element_name = i_viewname ).
  lr_config_ctr->initialize(
      ir_parent_controller  = ir_parent_controller
      ir_model              = me
      ir_view               = lr_config_view
      i_vcode               = i_vcode ).
  lr_config_view->initialize(
      ir_controller     = lr_config_ctr
      ir_parent_view    = lr_parent_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode
      i_repid           = 'SAPLN1_GUI_SDY_LAYO_DOCKCONT'
      i_dynnr           = '0100'
      i_dynpstruct_name = 'RN1_GUI_DYNP_LAYO_DOCKCONT'
      it_dynplay_vcode  = it_layout_vcode ).

* Export
  rr_config_ctr = lr_config_ctr.

ENDMETHOD.


METHOD set_extension.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_extension
      i_content   = i_extension ).

ENDMETHOD.


METHOD set_side.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_side
      i_content   = i_side ).

ENDMETHOD.


METHOD _get_t_dataref.

  DATA lr_data            TYPE REF TO data.

  rt_dataref = super->_get_t_dataref( ).

  GET REFERENCE OF gs_data INTO lr_data.

  INSERT lr_data INTO TABLE rt_dataref.

ENDMETHOD.
ENDCLASS.
