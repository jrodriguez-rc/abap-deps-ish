class CL_ISH_GUI_HTML_VIEW definition
  public
  inheriting from CL_ISH_GUI_CONTROL_VIEW
  create public .

public section.
*"* public components of class CL_ISH_GUI_HTML_VIEW
*"* do not include other source files here!!!

  class-methods CREATE_AND_INIT_BY_CONTVIEW
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME
      !I_FIELDNAME_URL type N1GUI_ELEMENT_NAME
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !IR_LAYOUT type ref to CL_ISH_GUI_CONTROL_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !I_CTRNAME type N1GUI_ELEMENT_NAME
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_HTML_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_HTML_VIEWER
    returning
      value(RR_HTML_VIEWER) type ref to CL_GUI_HTML_VIEWER .
  class-methods CREATE_AND_INIT_BY_DYNPVIEW
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME
      !I_FIELDNAME_URL type N1GUI_ELEMENT_NAME
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IR_MODEL type ref to IF_ISH_GUI_MODEL
      !IR_LAYOUT type ref to CL_ISH_GUI_CONTROL_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !I_CTRNAME type N1GUI_ELEMENT_NAME
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW
      !I_SDY_CTRNAME type N1GUI_ELEMENT_NAME
      !I_SDY_VIEWNAME type N1GUI_ELEMENT_NAME
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_HTML_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_CONTROL_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !I_FIELDNAME_URL type ISH_FIELDNAME optional
      !I_URL type N1URL_WWW optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_URL
    returning
      value(R_URL) type N1URL_WWW .
  class-methods NEW_INSTANCE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_HTML_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_URL
    importing
      !I_URL type N1URL_WWW
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GUI_HTML_VIEW
*"* do not include other source files here!!!

  data G_FIELDNAME_URL type ISH_FIELDNAME .
  data G_URL type N1URL_WWW .

  methods ON_MODEL_CHANGED
    for event EV_CHANGED of IF_ISH_GUI_STRUCTURE_MODEL
    importing
      !ET_CHANGED_FIELD
      !SENDER .

  methods _CREATE_CONTROL
    redefinition .
  methods _DESTROY
    redefinition .
  methods _FIRST_DISPLAY
    redefinition .
  methods _REFRESH_DISPLAY
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_HTML_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_HTML_VIEW IMPLEMENTATION.


METHOD create_and_init_by_contview.

  DATA lr_ctr                 TYPE REF TO cl_ish_gc_simple.
  DATA lr_parent_ctr          TYPE REF TO if_ish_gui_controller.

* Create the controller.
  lr_ctr = cl_ish_gc_simple=>create(
      i_element_name    = i_ctrname
      ir_cb_destroyable = ir_cb_destroyable ).

* Create the view.
  rr_instance = new_instance(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

* Initialize the controller.
  IF ir_parent_view IS BOUND.
    lr_parent_ctr = ir_parent_view->get_controller( ).
  ENDIF.
  lr_ctr->initialize(
      ir_parent_controller = lr_parent_ctr
      ir_model             = ir_model
      ir_view              = rr_instance
      i_vcode              = i_vcode ).

* Initialize the view.
  rr_instance->initialize(
      ir_controller   = lr_ctr
      ir_layout       = ir_layout
      i_vcode         = i_vcode
      ir_parent_view  = ir_parent_view
      i_fieldname_url = i_fieldname_url ).

ENDMETHOD.


METHOD create_and_init_by_dynpview.

  DATA lr_parent_ctr                  TYPE REF TO if_ish_gui_controller.
  DATA lr_sdy_custcont_ctr            TYPE REF TO cl_ish_gc_sdy_custcont.
  DATA lr_custcont_view               TYPE REF TO if_ish_gui_container_view.

* Create the sdy_custcont controller.
  IF ir_parent_view IS BOUND.
    lr_parent_ctr = ir_parent_view->get_controller( ).
  ENDIF.
  lr_sdy_custcont_ctr = cl_ish_gc_sdy_custcont=>create_and_initialize(
      i_element_name          = i_sdy_ctrname
      ir_cb_destroyable       = ir_cb_destroyable
      ir_parent_controller    = lr_parent_ctr
      ir_model                = ir_model
      i_vcode                 = i_vcode
      i_viewname_sdy_custcont = i_sdy_viewname ).
  lr_custcont_view = lr_sdy_custcont_ctr->get_custcont_view( ).

* Create the view.
  rr_instance = create_and_init_by_contview(
      i_element_name    = i_element_name
      i_fieldname_url   = i_fieldname_url
      ir_cb_destroyable = ir_cb_destroyable
      ir_model          = ir_model
      ir_layout         = ir_layout
      i_vcode           = i_vcode
      i_ctrname         = i_ctrname
      ir_parent_view    = lr_custcont_view ).

ENDMETHOD.


METHOD get_html_viewer.

  TRY.
      rr_html_viewer ?= get_control( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_url.

  r_url = g_url.

ENDMETHOD.


METHOD initialize.

  DATA lr_model                 TYPE REF TO if_ish_gui_structure_model.
  DATA l_url                    TYPE n1url_www.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
  ENDIF.

* Either fieldname or url has to be specified.
  IF i_fieldname_url IS INITIAL AND
     i_url IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
  ENDIF.

* The controller has to be specified.
  IF ir_controller IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
  ENDIF.

* Get the url.
  IF i_fieldname_url IS INITIAL.
    l_url = i_url.
  ELSE.
    TRY.
        lr_model ?= ir_controller->get_model( ).
      CATCH cx_sy_move_cast_error.
        CLEAR lr_model.
    ENDTRY.
    IF lr_model IS NOT BOUND.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '4'
          i_mv2        = 'INITIALIZE'
          i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
    ENDIF.
    CALL METHOD lr_model->get_field_content
      EXPORTING
        i_fieldname = i_fieldname_url
      CHANGING
        c_content   = l_url.
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
      g_fieldname_url = i_fieldname_url.
      g_url = i_url.
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD new_instance.

* Create the object.
  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          i_element_name    = i_element_name
          ir_cb_destroyable = ir_cb_destroyable.
    CATCH cx_root.                                       "#EC CATCH_ALL
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'NEW_INSTANCE'
          i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
  ENDTRY.

ENDMETHOD.


METHOD on_model_changed.

  DATA lr_html_viewer             TYPE REF TO cl_gui_html_viewer.
  DATA lx_root                    TYPE REF TO cx_root.

* Process only on url changes.
  READ TABLE et_changed_field FROM g_fieldname_url TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

* Get the url.
  TRY.
      CALL METHOD sender->get_field_content
        EXPORTING
          i_fieldname = g_fieldname_url
        CHANGING
          c_content   = g_url.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( lx_root ).
      RETURN.
  ENDTRY.

* Get the html viewer.
  lr_html_viewer = get_html_viewer( ).
  CHECK lr_html_viewer IS BOUND.

* Show the url.
  CALL METHOD lr_html_viewer->show_url
    EXPORTING
      url    = g_url
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    TRY.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '1'
            i_mv2        = 'ON_MODEL_CHANGED'
            i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
      CATCH cx_ish_static_handler INTO lx_root.
        _propagate_exception( lx_root ).
        RETURN.
    ENDTRY.
  ENDIF.

ENDMETHOD.


METHOD set_url.

  DATA lr_html_viewer                   TYPE REF TO cl_gui_html_viewer.

  IF g_fieldname_url IS NOT INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_URL'
        i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
  ENDIF.

  g_url = i_url.

  CHECK is_first_display_done( ) = abap_true.

  lr_html_viewer = get_html_viewer( ).
  CHECK lr_html_viewer IS BOUND.

  CALL METHOD lr_html_viewer->show_url
    EXPORTING
      url    = g_url
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'SET_URL'
        i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _create_control.

  DATA lr_parent_container_view         TYPE REF TO if_ish_gui_container_view.
  DATA lr_parent_container              TYPE REF TO cl_gui_container.

* Get the parent container.
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
        i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
  ENDIF.

* Create the html_viewer.
  CREATE OBJECT rr_control
    TYPE
      cl_gui_html_viewer
    EXPORTING
      parent             = lr_parent_container
    EXCEPTIONS
      OTHERS             = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _destroy.

  DATA lr_model           TYPE REF TO if_ish_gui_structure_model.

  IF gr_controller IS BOUND.
    TRY.
        lr_model ?= gr_controller->get_model( ).
        IF lr_model IS BOUND.
          SET HANDLER on_model_changed  FOR lr_model ACTIVATION abap_false.
        ENDIF.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
  ENDIF.

  super->_destroy( ).

ENDMETHOD.


METHOD _first_display.

  DATA lr_html_viewer             TYPE REF TO cl_gui_html_viewer.
  DATA lr_model                   TYPE REF TO if_ish_gui_structure_model.

* Create the control.
  TRY.
      lr_html_viewer ?= _create_control_on_demand( ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_html_viewer.
  ENDTRY.
  IF lr_html_viewer IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_FIRST_DISPLAY'
        i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
  ENDIF.

* Get the url.
  IF g_fieldname_url IS NOT INITIAL.
    IF gr_controller IS BOUND.
      TRY.
          lr_model ?= gr_controller->get_model( ).
        CATCH cx_sy_move_cast_error.
          CLEAR lr_model.
      ENDTRY.
    ENDIF.
    IF lr_model IS NOT BOUND.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = '_FIRST_DISPLAY'
          i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
    ENDIF.
    CALL METHOD lr_model->get_field_content
      EXPORTING
        i_fieldname = g_fieldname_url
      CHANGING
        c_content   = g_url.
  ENDIF.

* Show the url.
  CALL METHOD lr_html_viewer->show_url
    EXPORTING
      url    = g_url
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = '_FIRST_DISPLAY'
        i_mv3        = 'CL_ISH_GUI_HTML_VIEW' ).
  ENDIF.

* Register the model_changed eventhandler.
  IF g_fieldname_url IS NOT INITIAL.
    SET HANDLER on_model_changed FOR lr_model ACTIVATION abap_true.
  ENDIF.

ENDMETHOD.


METHOD _refresh_display.

* Not needed.

ENDMETHOD.
ENDCLASS.
