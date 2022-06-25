class CL_ISH_GUI_DOCKCONT_VIEW definition
  public
  inheriting from CL_ISH_GUI_CONTAINER_VIEW
  create protected .

public section.
*"* public components of class CL_ISH_GUI_DOCKCONT_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_DOCKCONT_VIEW .

  aliases GET_DOCKCONT_LAYOUT
    for IF_ISH_GUI_DOCKCONT_VIEW~GET_DOCKCONT_LAYOUT .
  aliases GET_DOCKING_CONTAINER
    for IF_ISH_GUI_DOCKCONT_VIEW~GET_DOCKING_CONTAINER .
  aliases GET_EXTENSION
    for IF_ISH_GUI_DOCKCONT_VIEW~GET_EXTENSION .
  aliases GET_SIDE
    for IF_ISH_GUI_DOCKCONT_VIEW~GET_SIDE .
  aliases SET_EXTENSION
    for IF_ISH_GUI_DOCKCONT_VIEW~SET_EXTENSION .
  aliases SET_SIDE
    for IF_ISH_GUI_DOCKCONT_VIEW~SET_SIDE .

  class-methods CREATE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_DOCKCONT_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_AND_INITIALIZE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_MDY_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_DOCKCONT_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !I_CTRNAME type N1GUI_ELEMENT_NAME optional
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_DOCKCONT_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_MDY_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_DOCKCONT_LAYOUT optional
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .

  methods IF_ISH_GUI_VIEW~ACTUALIZE_LAYOUT
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_DOCKCONT_VIEW
*"* do not include other source files here!!!

  methods _INIT_DOCKCONT_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_DOCKCONT_LAYOUT optional
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _LOAD_OR_CREATE_LAYOUT
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_USERNAME type USERNAME default SY-UNAME
    returning
      value(RR_LAYOUT) type ref to CL_ISH_GUI_DOCKCONT_LAYOUT .

  methods _CREATE_CONTROL
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_DOCKCONT_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_DOCKCONT_VIEW IMPLEMENTATION.


METHOD create.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD create_and_initialize.

  DATA lr_ctr           TYPE REF TO cl_ish_gc_simple.
  DATA lr_parent_ctr    TYPE REF TO if_ish_gui_controller.

  lr_ctr = cl_ish_gc_simple=>create(
      i_element_name    = i_ctrname
      ir_cb_destroyable = ir_cb_destroyable ).

  rr_instance = cl_ish_gui_dockcont_view=>create(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

  IF ir_parent_view IS BOUND.
    lr_parent_ctr = ir_parent_view->get_controller( ).
  ENDIF.
  lr_ctr->initialize(
      ir_parent_controller = lr_parent_ctr
      ir_model             = ir_model
      ir_view              = rr_instance
      i_vcode              = i_vcode ).

  rr_instance->initialize(
      ir_controller   = lr_ctr
      ir_parent_view  = ir_parent_view
      ir_layout       = ir_layout
      i_vcode         = i_vcode ).

ENDMETHOD.


METHOD if_ish_gui_dockcont_view~get_dockcont_layout.

  TRY.
      rr_dockcont_layout ?= get_layout( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_dockcont_view~get_docking_container.

  TRY.
      rr_docking_container ?= get_control( ).
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_dockcont_view~get_extension.

  DATA lr_container           TYPE REF TO cl_gui_docking_container.
  DATA lr_layout              TYPE REF TO cl_ish_gui_dockcont_layout.

  lr_container = get_docking_container( ).
  IF lr_container IS NOT BOUND.
    lr_layout = get_dockcont_layout( ).
    CHECK lr_layout IS BOUND.
    r_extension = lr_layout->get_extension( ).
    RETURN.
  ENDIF.

  CALL METHOD lr_container->get_extension
    IMPORTING
      extension = r_extension
    EXCEPTIONS
      OTHERS    = 1.

ENDMETHOD.


METHOD if_ish_gui_dockcont_view~get_side.

  DATA lr_dockcont            TYPE REF TO cl_gui_docking_container.
  DATA lr_layout              TYPE REF TO cl_ish_gui_dockcont_layout.

  lr_dockcont = get_docking_container( ).
  IF lr_dockcont IS NOT BOUND.
    lr_layout = get_dockcont_layout( ).
    CHECK lr_layout IS BOUND.
    r_side = lr_layout->get_side( ).
    RETURN.
  ENDIF.

  CALL METHOD lr_dockcont->get_docking_side
    RECEIVING
      docking_side = r_side
    EXCEPTIONS
      OTHERS       = 1.

ENDMETHOD.


METHOD if_ish_gui_dockcont_view~set_extension.

  DATA lr_container           TYPE REF TO cl_gui_docking_container.
  DATA lr_layout              TYPE REF TO cl_ish_gui_dockcont_layout.

* Process only on changes.
  CHECK get_extension( ) <> i_extension.

* Get the container.
  lr_container = get_docking_container( ).

* Adjust the container.
  IF lr_container IS BOUND.
    CALL METHOD lr_container->set_extension
      EXPORTING
        extension  = i_extension
      EXCEPTIONS
        cntl_error = 1
        OTHERS     = 2.
    IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static_by_syst( ir_object = me ).
    ENDIF.
  ENDIF.

* Adjust the layout.
  lr_layout = get_dockcont_layout( ).
  IF lr_layout IS BOUND.
    g_cb_layout = abap_true.
    TRY.
        r_changed = lr_layout->set_extension( i_extension ).
      CLEANUP.
        CLEAR g_cb_layout.
    ENDTRY.
    CLEAR g_cb_layout.
  ENDIF.

* Self was changed.
  r_changed = abap_true.

ENDMETHOD.


METHOD if_ish_gui_dockcont_view~set_side.

  DATA lr_container           TYPE REF TO cl_gui_docking_container.
  DATA lr_layout              TYPE REF TO cl_ish_gui_dockcont_layout.

* Process only on changes.
  CHECK get_side( ) <> i_side.

* Adjust the container.
  lr_container = get_docking_container( ).
  IF lr_container IS BOUND.
    CALL METHOD lr_container->dock_at
      EXPORTING
        side              = i_side
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static_by_syst( ir_object = me ).
    ENDIF.
  ENDIF.

* Adjust the layout.
  lr_layout = get_dockcont_layout( ).
  IF lr_layout IS BOUND.
    g_cb_layout = abap_true.
    TRY.
        r_changed = lr_layout->set_side( i_side ).
      CLEANUP.
        CLEAR g_cb_layout.
    ENDTRY.
    CLEAR g_cb_layout.
  ENDIF.

* Self was changed.
  r_changed = abap_true.

ENDMETHOD.


METHOD if_ish_gui_view~actualize_layout.

  DATA lr_layout            TYPE REF TO cl_ish_gui_dockcont_layout.
  DATA lr_container         TYPE REF TO cl_gui_docking_container.
  DATA l_extension          TYPE i.

* Call the super method.
  super->actualize_layout( ).

* Get the docking container.
  lr_container = get_docking_container( ).
  CHECK lr_container IS BOUND.

* Get the dockcont layout.
  lr_layout = get_dockcont_layout( ).
  CHECK lr_layout IS BOUND.

* Actualize the extension.
  CALL METHOD lr_container->get_extension
    IMPORTING
      extension         = l_extension
    EXCEPTIONS
      cntl_error        = 1
      cntl_system_error = 2
      OTHERS            = 3.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static_by_syst( ir_object = me ).
  ENDIF.
  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      OTHERS = 1.
  CHECK sy-subrc = 0.
  g_cb_layout = abap_true.
  TRY.
      lr_layout->set_extension( l_extension ).
    CLEANUP.
      g_cb_layout = abap_false.
  ENDTRY.
  g_cb_layout = abap_false.

ENDMETHOD.


METHOD initialize.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GUI_DOCKCONT_VIEW' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      _init_dockcont_view(
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


METHOD _create_control.

  DATA lr_layout                  TYPE REF TO cl_ish_gui_dockcont_layout.
  DATA l_side                     TYPE i.
  DATA l_extension                TYPE i.

* The layout has to exist.
  lr_layout = get_dockcont_layout( ).
  IF lr_layout IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_DOCKCONT_VIEW' ).
  ENDIF.

* Create the control.
  l_side      = lr_layout->get_side( ).
  l_extension = lr_layout->get_extension( ).
  CREATE OBJECT rr_control
    TYPE
      cl_gui_docking_container
    EXPORTING
      side                     = l_side
      extension                = l_extension
    EXCEPTIONS
      OTHERS                   = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_DOCKCONT_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _init_dockcont_view.

  DATA lr_mdy_view            TYPE REF TO if_ish_gui_mdy_view.
  DATA lr_layout              TYPE REF TO cl_ish_gui_dockcont_layout.
  DATA lx_root                TYPE REF TO cx_root.

* The parent view has to be a mdy_view.
  TRY.
      lr_mdy_view ?= ir_parent_view.
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = '_INIT_DOCKCONT_VIEW'
          i_mv3        = 'CL_ISH_GUI_DOCKCONT_VIEW' ).
  ENDTRY.

* Handle the layout.
  IF ir_layout IS BOUND.
    lr_layout = ir_layout.
  ELSE.
    lr_layout = _load_or_create_layout(
       ir_controller  = ir_controller
       ir_parent_view = ir_parent_view ).
  ENDIF.

* Further initialization by _init_container_view.
  _init_container_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = lr_layout
      i_vcode           = i_vcode ).

ENDMETHOD.


METHOD _load_or_create_layout.

  DATA l_element_name           TYPE n1gui_element_name.

  TRY.
      rr_layout ?= _load_layout(
          ir_controller   = ir_controller
          ir_parent_view  = ir_parent_view
          i_layout_name   = i_layout_name
          i_username      = i_username ).
    CATCH cx_sy_move_cast_error.
      CLEAR rr_layout.
  ENDTRY.

  IF rr_layout IS NOT BOUND.
    l_element_name = get_element_name( ).
    CREATE OBJECT rr_layout
      EXPORTING
        i_element_name = l_element_name
        i_layout_name  = i_layout_name.
  ENDIF.

ENDMETHOD.
ENDCLASS.
