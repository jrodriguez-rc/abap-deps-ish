class CL_ISH_GUI_DD_VIEW definition
  public
  inheriting from CL_ISH_GUI_CONTROL_VIEW
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_DD_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_DD_VIEW .

  aliases GET_DD
    for IF_ISH_GUI_DD_VIEW~GET_DD .

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    preferred parameter I_ELEMENT_NAME .
protected section.
*"* protected components of class CL_ISH_GUI_DD_VIEW
*"* do not include other source files here!!!

  data GR_DD type ref to CL_DD_DOCUMENT .

  methods ON_MODEL_CHANGED
    for event EV_CHANGED of IF_ISH_GUI_STRUCTURE_MODEL
    importing
      !ET_CHANGED_FIELD .
  methods ON_MODEL_ENTRY_ADDED
    for event EV_ENTRY_ADDED of IF_ISH_GUI_TABLE_MODEL
    importing
      !ER_ENTRY .
  methods ON_MODEL_ENTRY_REMOVED
    for event EV_ENTRY_REMOVED of IF_ISH_GUI_TABLE_MODEL
    importing
      !ER_ENTRY .
  methods _INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_CONTROL_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _INITIALIZE_DD
    importing
      !IR_DD type ref to CL_DD_DOCUMENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _MERGE_DD
  abstract
    importing
      !IR_DD type ref to CL_DD_DOCUMENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SHOW_DD
    importing
      !IR_PARENT_CONTAINER type ref to CL_GUI_CONTAINER optional
    raising
      CX_ISH_STATIC_HANDLER .

  methods _CREATE_CONTROL
    redefinition .
  methods _DESTROY
    redefinition .
  methods _FIRST_DISPLAY
    redefinition .
  methods _REFRESH_DISPLAY
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_DD_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_DD_VIEW IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

ENDMETHOD.


METHOD if_ish_gui_dd_view~get_dd.
  rr_dd = gr_dd.
ENDMETHOD.


METHOD on_model_changed.
  TRY.
      CALL METHOD me->_show_dd.
    CATCH cx_ish_static_handler .                       "#EC NO_HANDLER
*  do nothing
  ENDTRY.
ENDMETHOD.


METHOD on_model_entry_added.
  TRY.
      CALL METHOD me->_show_dd.
    CATCH cx_ish_static_handler .                       "#EC NO_HANDLER
*  do nothing
  ENDTRY.
ENDMETHOD.


METHOD on_model_entry_removed.
  TRY.
      CALL METHOD me->_show_dd.
    CATCH cx_ish_static_handler .                       "#EC NO_HANDLER
*  do nothing
  ENDTRY.
ENDMETHOD.


METHOD _create_control.
  DATA lr_parent_container_view         TYPE REF TO if_ish_gui_container_view.
  DATA lr_parent_container              TYPE REF TO cl_gui_container.
* ----- ----- -----
  TRY.
      lr_parent_container_view ?= get_parent_view( ).
      lr_parent_container = lr_parent_container_view->get_container_for_child_view( me ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_parent_container.
  ENDTRY.
  IF lr_parent_container IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
    i_typ        = 'E'
    i_kla        = 'N1BASE'
    i_num        = '030'
    i_mv1        = '1'
    i_mv2        = '_CREATE_CONTROL'
    i_mv3        = 'CL_ISH_GUI_DD_VIEW' ).
  ENDIF.
* ----- ----- -----
* create dynamic document instance
  CREATE OBJECT gr_dd.
* create dynamic document
  CALL METHOD me->_show_dd
    EXPORTING
      ir_parent_container = lr_parent_container.

  rr_control = gr_dd->html_control.
* ----- ----- -----
ENDMETHOD.


METHOD _destroy.
  DATA lr_structure_model       TYPE REF TO if_ish_gui_structure_model.
  DATA lr_table_model           TYPE REF TO if_ish_gui_table_model.


  IF gr_controller IS BOUND.

    TRY.
        lr_structure_model ?= gr_controller->get_model( ).
        IF lr_structure_model IS BOUND.
          SET HANDLER on_model_changed FOR lr_structure_model ACTIVATION abap_false.
        ENDIF.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.

    TRY.
        lr_table_model ?= gr_controller->get_model( ).
        IF lr_table_model IS BOUND.
          SET HANDLER on_model_entry_added FOR lr_table_model ACTIVATION abap_false.
          SET HANDLER on_model_entry_removed FOR lr_table_model ACTIVATION abap_false.
        ENDIF.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
  ENDIF.

  CALL METHOD super->_destroy.
ENDMETHOD.


METHOD _first_display.

  DATA lr_dd_viewer             TYPE REF TO cl_gui_control.
  DATA lr_structure_model       TYPE REF TO if_ish_gui_structure_model.
  DATA lr_table_model           TYPE REF TO if_ish_gui_table_model.

* Create the control.
  TRY.
      lr_dd_viewer = _create_control_on_demand( ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_dd_viewer.
  ENDTRY.
  IF lr_dd_viewer IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
    i_typ        = 'E'
    i_kla        = 'N1BASE'
    i_num        = '030'
    i_mv1        = '1'
    i_mv2        = '_FIRST_DISPLAY'
    i_mv3        = 'CL_ISH_GUI_DD_VIEW' ).
  ENDIF.

  IF gr_controller IS BOUND.

    TRY.
        lr_structure_model ?= gr_controller->get_model( ).
      CATCH cx_sy_move_cast_error.
        CLEAR lr_structure_model.
    ENDTRY.

    IF lr_structure_model IS BOUND.
      SET HANDLER on_model_changed FOR lr_structure_model ACTIVATION abap_true.
    ENDIF.

    TRY.
        lr_table_model ?= gr_controller->get_model( ).
      CATCH cx_sy_move_cast_error.
        CLEAR lr_table_model.
    ENDTRY.

    IF lr_table_model IS BOUND.
      SET HANDLER on_model_entry_added FOR lr_table_model ACTIVATION abap_true.
      SET HANDLER on_model_entry_removed FOR lr_table_model ACTIVATION abap_true.
    ENDIF.
  ENDIF.

* a model isn't obligatory for dynamic document view
*  IF lr_structure_model IS INITIAL AND lr_table_model IS INITIAL.
*    cl_ish_utl_exception=>raise_static(
*    i_typ        = 'E'
*    i_kla        = 'N1BASE'
*    i_num        = '030'
*    i_mv1        = '2'
*    i_mv2        = '_FIRST_DISPLAY'
*    i_mv3        = 'CL_ISH_GUI_DD_VIEW' ).
*  ENDIF.

ENDMETHOD.


METHOD _initialize.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
  is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
    i_typ        = 'E'
    i_kla        = 'N1BASE'
    i_num        = '030'
    i_mv1        = '1'
    i_mv2        = '_INITIALIZE'
    i_mv3        = 'CL_ISH_GUI_DD_VIEW' ).
  ENDIF.


* The controller has to be specified.
  IF ir_controller IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
    i_typ        = 'E'
    i_kla        = 'N1BASE'
    i_num        = '030'
    i_mv1        = '2'
    i_mv2        = '_INITIALIZE'
    i_mv3        = 'CL_ISH_GUI_DD_VIEW' ).
  ENDIF.


* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      _init_control_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode ).
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.
ENDMETHOD.


METHOD _initialize_dd.
  IF ir_dd IS INITIAL.
    cl_ish_utl_exception=>raise_static(
    i_typ        = 'E'
    i_kla        = 'N1BASE'
    i_num        = '030'
    i_mv1        = '1'
    i_mv2        = '_INITIALIZE_DD'
    i_mv3        = 'CL_ISH_GUI_DD_VIEW' ).
  ENDIF.

  CALL METHOD ir_dd->initialize_document
    EXPORTING
      background_color = cl_dd_area=>col_background_level2
      no_margins       = abap_true.
ENDMETHOD.


METHOD _refresh_display.
  CALL METHOD me->_show_dd.
ENDMETHOD.


METHOD _show_dd.

  IF gr_dd IS INITIAL.
    cl_ish_utl_exception=>raise_static(
    i_typ        = 'E'
    i_kla        = 'N1BASE'
    i_num        = '030'
    i_mv1        = '1'
    i_mv2        = '_SHOW_DD'
    i_mv3        = 'CL_ISH_GUI_DD_VIEW' ).
  ENDIF.

* initialize dynamic document
  me->_initialize_dd( ir_dd  = gr_dd ).
* fill dynamic document
  me->_merge_dd( ir_dd = gr_dd ).

* display the HTML Header Control
  CALL METHOD gr_dd->merge_document.

  CALL METHOD gr_dd->display_document
    EXPORTING
      reuse_control      = abap_true
      reuse_registration = abap_true
      parent             = ir_parent_container
    EXCEPTIONS
      html_display_error = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
    i_typ        = sy-msgty
    i_kla        = sy-msgid
    i_num        = sy-msgno
    i_mv1        = sy-msgv1
    i_mv2        = sy-msgv2
    i_mv3        = sy-msgv3
    i_mv4        = sy-msgv4 ).
  ENDIF.
ENDMETHOD.
ENDCLASS.
