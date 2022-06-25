class CL_ISH_GUI_TEXTEDIT_VIEW definition
  public
  inheriting from CL_ISH_GUI_CONTROL_VIEW
  create public .

public section.
*"* public components of class CL_ISH_GUI_TEXTEDIT_VIEW
*"* do not include other source files here!!!

  methods GET_TEXTEDIT
    returning
      value(RR_GUI_TEXTEDIT) type ref to CL_GUI_TEXTEDIT .
  methods GET_TEXT
    returning
      value(R_TEXT) type STRING .
  methods INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_CONTROL_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !I_FIELDNAME_TEXT type ISH_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GUI_TEXTEDIT_VIEW
*"* do not include other source files here!!!

  data G_FIELDNAME_TEXT type ISH_FIELDNAME .

  methods ON_MODEL_CHANGED
    for event EV_CHANGED of IF_ISH_GUI_STRUCTURE_MODEL
    importing
      !ET_CHANGED_FIELD
      !SENDER .

  methods ON_DISPATCH
    redefinition .
  methods _CREATE_CONTROL
    redefinition .
  methods _DESTROY
    redefinition .
  methods _FIRST_DISPLAY
    redefinition .
  methods _REFRESH_DISPLAY
    redefinition .
  methods _SET_VCODE
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_TEXTEDIT_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_TEXTEDIT_VIEW IMPLEMENTATION.


METHOD get_text.

  DATA: lr_gui_textedit TYPE REF TO cl_gui_textedit,
        l_text          TYPE        string.

* get textedit controller
  lr_gui_textedit = get_textedit( ).
  CHECK lr_gui_textedit IS BOUND.

* get text
  CALL METHOD lr_gui_textedit->get_textstream
    IMPORTING
      text   = l_text
    EXCEPTIONS
      OTHERS = 1.

  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      OTHERS = 1.

  r_text = l_text.

ENDMETHOD.


METHOD get_textedit.

  TRY.
      rr_gui_textedit ?= get_control( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD initialize.

  DATA lr_model                 TYPE REF TO if_ish_gui_structure_model.
  DATA l_text                   TYPE string.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'INITIALIZE_BY_FIELDNAME'
        i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
  ENDIF.

* The controller has to be specified.
  IF ir_controller IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = 'INITIALIZE_BY_FIELDNAME'
        i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
  ENDIF.

* Get the text.
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
        i_mv2        = 'INITIALIZE_BY_FIELDNAME'
        i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
  ENDIF.
  CALL METHOD lr_model->get_field_content
    EXPORTING
      i_fieldname = i_fieldname_text
    CHANGING
      c_content   = l_text.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      _init_control_view(
          ir_controller     = ir_controller
          ir_parent_view    = ir_parent_view
          ir_layout         = ir_layout
          i_vcode           = i_vcode ).
      g_fieldname_text = i_fieldname_text.
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD on_dispatch.

  DATA lr_textedit          TYPE REF TO cl_gui_textedit.
  DATA lr_xstructmdl        TYPE REF TO if_ish_gui_xstructure_model.
  DATA l_text               TYPE string.
  DATA lr_model             TYPE REF TO if_ish_gui_structure_model.
  DATA lx_root              TYPE REF TO cx_root.

  super->on_dispatch( ).

  CHECK gr_controller IS BOUND.
  CHECK is_first_display_done( ) = abap_true.

  CHECK g_vcode <> co_vcode_display.

  lr_textedit = get_textedit( ).
  CHECK lr_textedit IS BOUND.
  CHECK gr_controller IS BOUND.
  TRY.
      lr_xstructmdl ?= gr_controller->get_model( ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_xstructmdl.
  ENDTRY.
  IF lr_xstructmdl IS BOUND AND
     lr_xstructmdl->is_field_changeable( g_fieldname_text ) = abap_false.
    RETURN.
  ENDIF.

* Get the text from our control.
  l_text = get_text( ).

* Transport the text into the model.
  TRY.
      lr_model ?= gr_controller->get_model( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_model IS BOUND.
  TRY.
      lr_model->set_field_content(
          i_fieldname = g_fieldname_text
          i_content   = l_text ).
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( lx_root ).
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD on_model_changed.

  DATA: lr_gui_textedit  TYPE REF TO cl_gui_textedit,
        lx_root          TYPE REF TO cx_root,
        l_text           TYPE        string.

  CHECK sender IS BOUND.
  CHECK gr_controller IS BOUND.
  CHECK sender = gr_controller->get_model( ).

  CHECK g_fieldname_text IS NOT INITIAL.

* Process only on text changes
  READ TABLE et_changed_field FROM g_fieldname_text TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

* Get text.
  TRY.
      CALL METHOD sender->get_field_content
        EXPORTING
          i_fieldname = g_fieldname_text
        CHANGING
          c_content   = l_text.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( lx_root ).
      RETURN.
  ENDTRY.

* Get editor
  lr_gui_textedit = get_textedit( ).
  CHECK lr_gui_textedit IS BOUND.

* Set text
  CALL METHOD lr_gui_textedit->set_textstream
    EXPORTING
      text   = l_text
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
            i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
      CATCH cx_ish_static_handler INTO lx_root.
        _propagate_exception( lx_root ).
        RETURN.
    ENDTRY.
  ENDIF.

ENDMETHOD.


METHOD _create_control.

  DATA lr_parent_container_view         TYPE REF TO if_ish_gui_container_view.
  DATA lr_parent_container              TYPE REF TO cl_gui_container.
  DATA lr_textedit                      TYPE REF TO cl_gui_textedit.
  DATA lr_xstructmdl                    TYPE REF TO if_ish_gui_xstructure_model.

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
        i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
  ENDIF.

* Create the viewer.
  CREATE OBJECT lr_textedit
    EXPORTING
      parent = lr_parent_container
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
  ENDIF.

  CALL METHOD lr_textedit->set_statusbar_mode
    EXPORTING
      statusbar_mode = 0
    EXCEPTIONS
      OTHERS         = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
  ENDIF.
  CALL METHOD lr_textedit->set_toolbar_mode
    EXPORTING
      toolbar_mode = 0
    EXCEPTIONS
      OTHERS       = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '4'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
  ENDIF.
  IF gr_controller IS BOUND.
    TRY.
        lr_xstructmdl ?= gr_controller->get_model( ).
      CATCH cx_sy_move_cast_error.
        CLEAR lr_xstructmdl.
    ENDTRY.
  ENDIF.
  IF g_vcode = co_vcode_display OR
     ( lr_xstructmdl IS BOUND AND
       lr_xstructmdl->is_field_changeable( g_fieldname_text ) = abap_false ).
    CALL METHOD lr_textedit->set_readonly_mode
      EXPORTING
        readonly_mode = 1
      EXCEPTIONS
        OTHERS        = 1.
    IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '5'
          i_mv2        = '_CREATE_CONTROL'
          i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
    ENDIF.
  ENDIF.

* Export.
  rr_control = lr_textedit.

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

  DATA lr_gui_textedit            TYPE REF TO cl_gui_textedit.
  DATA lr_model                   TYPE REF TO if_ish_gui_structure_model.
  DATA l_text                     TYPE        string.

* Create the control.
  TRY.
      lr_gui_textedit ?= _create_control_on_demand( ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_gui_textedit.
  ENDTRY.
  IF lr_gui_textedit IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_FIRST_DISPLAY'
        i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
  ENDIF.

* Get the text from the model.
  IF g_fieldname_text IS NOT INITIAL.
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
          i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
    ENDIF.
    CALL METHOD lr_model->get_field_content
      EXPORTING
        i_fieldname = g_fieldname_text
      CHANGING
        c_content   = l_text.
  ENDIF.

* Show the text.
  CALL METHOD lr_gui_textedit->set_textstream
    EXPORTING
      text   = l_text
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '3'
          i_mv2        = '_FIRST_DISPLAY'
          i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
  ENDIF.

* Register the model_changed eventhandler.
  SET HANDLER on_model_changed  FOR lr_model ACTIVATION abap_true.

ENDMETHOD.


METHOD _refresh_display.

* not needed

ENDMETHOD.


METHOD _set_vcode.

  DATA lr_textedit            TYPE REF TO cl_gui_textedit.
  DATA lr_xstructmdl          TYPE REF TO if_ish_gui_xstructure_model.
  DATA l_readonly_mode        TYPE i.

* Call the super method.
  r_changed = super->_set_vcode( i_vcode ).

  CHECK r_changed = abap_true.

* Adjust the textedit.
  lr_textedit = get_textedit( ).
  CHECK lr_textedit IS BOUND.
  IF gr_controller IS BOUND.
    TRY.
        lr_xstructmdl ?= gr_controller->get_model( ).
      CATCH cx_sy_move_cast_error.
        CLEAR lr_xstructmdl.
    ENDTRY.
  ENDIF.
  IF g_vcode = co_vcode_display OR
     ( lr_xstructmdl IS BOUND AND
       lr_xstructmdl->is_field_changeable( g_fieldname_text ) = abap_false ).
    l_readonly_mode = 1.
  ELSE.
    l_readonly_mode = 0.
  ENDIF.
  CALL METHOD lr_textedit->set_readonly_mode
    EXPORTING
      readonly_mode = 1
    EXCEPTIONS
      OTHERS        = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '5'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_TEXTEDIT_VIEW' ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
