class CL_ISH_GUI_SPLITTER_VIEW definition
  public
  inheriting from CL_ISH_GUI_CONTAINER_VIEW
  create public .

public section.
*"* public components of class CL_ISH_GUI_SPLITTER_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_SPLITTER_VIEW .

  aliases CO_MODE_ABSOLUTE
    for IF_ISH_GUI_SPLITTER_VIEW~CO_MODE_ABSOLUTE .
  aliases CO_MODE_RELATIVE
    for IF_ISH_GUI_SPLITTER_VIEW~CO_MODE_RELATIVE .
  aliases CO_ORIENTATION_HORIZONTAL
    for IF_ISH_GUI_SPLITTER_VIEW~CO_ORIENTATION_HORIZONTAL .
  aliases CO_ORIENTATION_VERTICAL
    for IF_ISH_GUI_SPLITTER_VIEW~CO_ORIENTATION_VERTICAL .
  aliases CO_SPLITVIS_BOTH
    for IF_ISH_GUI_SPLITTER_VIEW~CO_SPLITVIS_BOTH .
  aliases CO_SPLITVIS_BOTTOM_RIGHT
    for IF_ISH_GUI_SPLITTER_VIEW~CO_SPLITVIS_BOTTOM_RIGHT .
  aliases CO_SPLITVIS_TOP_LEFT
    for IF_ISH_GUI_SPLITTER_VIEW~CO_SPLITVIS_TOP_LEFT .
  aliases GET_BOTTOM_RIGHT_CONTAINER
    for IF_ISH_GUI_SPLITTER_VIEW~GET_BOTTOM_RIGHT_CONTAINER .
  aliases GET_BOTTOM_RIGHT_VIEW
    for IF_ISH_GUI_SPLITTER_VIEW~GET_BOTTOM_RIGHT_VIEW .
  aliases GET_SASH_POSITION
    for IF_ISH_GUI_SPLITTER_VIEW~GET_SASH_POSITION .
  aliases GET_SPLITTER_CONTAINER
    for IF_ISH_GUI_SPLITTER_VIEW~GET_SPLITTER_CONTAINER .
  aliases GET_SPLITTER_LAYOUT
    for IF_ISH_GUI_SPLITTER_VIEW~GET_SPLITTER_LAYOUT .
  aliases GET_SPLITTER_VISIBILITY
    for IF_ISH_GUI_SPLITTER_VIEW~GET_SPLITTER_VISIBILITY .
  aliases GET_TOP_LEFT_CONTAINER
    for IF_ISH_GUI_SPLITTER_VIEW~GET_TOP_LEFT_CONTAINER .
  aliases GET_TOP_LEFT_VIEW
    for IF_ISH_GUI_SPLITTER_VIEW~GET_TOP_LEFT_VIEW .
  aliases SET_SASH_POSITION
    for IF_ISH_GUI_SPLITTER_VIEW~SET_SASH_POSITION .
  aliases SET_SPLITTER_VISIBILITY
    for IF_ISH_GUI_SPLITTER_VIEW~SET_SPLITTER_VISIBILITY .

  class-methods CREATE_AND_INITIALIZE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_SPLITTER_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_CTRNAME type N1GUI_ELEMENT_NAME optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_SPLITTER_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_AND_INIT_BY_DYNPVIEW
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_SPLITTER_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_CTRNAME type N1GUI_ELEMENT_NAME optional
      !I_SDY_CTRNAME type N1GUI_ELEMENT_NAME optional
      !I_SDY_VIEWNAME type N1GUI_ELEMENT_NAME optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_SPLITTER_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods INIT_SPLITTER_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_SPLITTER_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .

  methods IF_ISH_GUI_CONTAINER_VIEW~GET_CONTAINER_FOR_CHILD_VIEW
    redefinition .
  methods IF_ISH_GUI_VIEW~ACTUALIZE_LAYOUT
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_SPLITTER_VIEW
*"* do not include other source files here!!!

  data G_HIDDEN_SASH_POSITION type I .
  data G_SPLITTER_VISIBILITY type N1GUI_SPLITTER_VISIBILITY .

  methods _INIT_SPLITTER_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_SPLITTER_LAYOUT optional
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SET_CELL_EXTENSION
    importing
      !IR_LAYOUT type ref to CL_ISH_GUI_SPLITTER_LAYOUT
      !IR_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER
      !I_CELL_ID type I
      !I_EXTENSION type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SET_SASH_VISIBILITY
    importing
      !IR_LAYOUT type ref to CL_ISH_GUI_SPLITTER_LAYOUT
      !IR_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER
      !I_VISIBILITY type I
    raising
      CX_ISH_STATIC_HANDLER .

  methods _ADD_CHILD_VIEW
    redefinition .
  methods _CREATE_CONTROL
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_SPLITTER_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_SPLITTER_VIEW IMPLEMENTATION.


METHOD create_and_initialize.

  DATA lr_ctr           TYPE REF TO cl_ish_gc_simple.
  DATA lr_parent_ctr    TYPE REF TO if_ish_gui_controller.

  lr_ctr = cl_ish_gc_simple=>create(
      i_element_name    = i_ctrname
      ir_cb_destroyable = ir_cb_destroyable ).

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable.

  IF ir_parent_view IS BOUND.
    lr_parent_ctr = ir_parent_view->get_controller( ).
  ENDIF.
  lr_ctr->initialize(
      ir_parent_controller = lr_parent_ctr
      ir_model             = ir_model
      ir_view              = rr_instance
      i_vcode              = i_vcode ).

  rr_instance->init_splitter_view(
      ir_controller   = lr_ctr
      ir_parent_view  = ir_parent_view
      ir_layout       = ir_layout
      i_vcode         = i_vcode ).

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
      i_vcode                 = i_vcode
      i_viewname_sdy_custcont = i_sdy_viewname ).
  lr_custcont_view = lr_sdy_custcont_ctr->get_custcont_view( ).

* Create the view.
  rr_instance = create_and_initialize(
      i_element_name            = i_element_name
      ir_cb_destroyable         = ir_cb_destroyable
      ir_parent_view            = lr_custcont_view
      ir_layout                 = ir_layout
      i_vcode                   = i_vcode
      ir_model                  = ir_model
      i_ctrname                 = i_ctrname ).

ENDMETHOD.


METHOD if_ish_gui_container_view~get_container_for_child_view.

  DATA lr_layout                    TYPE REF TO cl_ish_gui_splitter_layout.

  CHECK ir_child_view IS BOUND.

  lr_layout = get_splitter_layout( ).
  CHECK lr_layout IS BOUND.

  IF lr_layout->get_top_left_name( ) = ir_child_view->get_element_name( ).
    rr_container = get_top_left_container( ).
  ELSEIF lr_layout->get_bottom_right_name( ) = ir_child_view->get_element_name( ).
    rr_container = get_bottom_right_container( ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_splitter_view~get_bottom_right_container.

  DATA lr_splitter_container                    TYPE REF TO cl_gui_splitter_container.
  DATA lr_layout                                TYPE REF TO cl_ish_gui_splitter_layout.
  DATA l_row                                    TYPE i.
  DATA l_col                                    TYPE i.

  lr_splitter_container = get_splitter_container( ).
  CHECK lr_splitter_container IS BOUND.

  lr_layout = get_splitter_layout( ).
  CHECK lr_layout IS BOUND.

  IF lr_layout->get_orientation( ) = co_orientation_horizontal.
    l_row = 1.
    l_col = 2.
  ELSE.
    l_row = 2.
    l_col = 1.
  ENDIF.

  rr_container = lr_splitter_container->get_container(
      row       = l_row
      column    = l_col ).

ENDMETHOD.


METHOD if_ish_gui_splitter_view~get_bottom_right_view.

  DATA lr_layout                                TYPE REF TO cl_ish_gui_splitter_layout.
  DATA l_element_name                           TYPE n1gui_element_name.

  lr_layout = get_splitter_layout( ).
  CHECK lr_layout IS BOUND.

  l_element_name = lr_layout->get_bottom_right_name( ).

  TRY.
      rr_view ?= get_child_view_by_name( l_element_name ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_splitter_view~get_sash_position.

  DATA lr_layout            TYPE REF TO cl_ish_gui_splitter_layout.
  DATA lr_splitter          TYPE REF TO cl_gui_splitter_container.

* Get the splitter layout.
  lr_layout = get_splitter_layout( ).
  IF lr_layout IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'GET_SASH_POSITION'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.

* Get the splitter container.
  lr_splitter = get_splitter_container( ).

* If the splitter container does not already exist we use the layoutn.
  IF lr_splitter IS NOT BOUND.
    r_sash_position = lr_layout->get_sash_position( ).
    RETURN.
  ENDIF.

* The splitter container already exists.

* If only one cell is shown we use g_hidden_sash_position.
  IF g_splitter_visibility <> co_splitvis_both.
    r_sash_position = g_hidden_sash_position.
    RETURN.
  ENDIF.

* Both cells are shown.
* Use the splitter position of the splitter container.
  IF lr_layout->get_orientation( ) = co_orientation_horizontal.
    CALL METHOD lr_splitter->get_column_width
      EXPORTING
        id     = 1
      IMPORTING
        RESULT = r_sash_position
      EXCEPTIONS
        OTHERS = 1.
  ELSE.
    CALL METHOD lr_splitter->get_row_height
      EXPORTING
        id     = 1
      IMPORTING
        RESULT = r_sash_position
      EXCEPTIONS
        OTHERS = 1.
  ENDIF.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '2'
        i_mv2 = 'GET_SASH_POSITION'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.
  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '3'
        i_mv2 = 'GET_SASH_POSITION'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_splitter_view~get_splitter_container.

  TRY.
      rr_splitter_container ?= get_container( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_splitter_view~get_splitter_layout.

  TRY.
      rr_splitter_layout ?= get_layout( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_splitter_view~get_splitter_visibility.

  DATA lr_layout            TYPE REF TO cl_ish_gui_splitter_layout.

* If the splitter container does already exist we use g_splitter_visibility.
* If not we use the layout.

  IF get_splitter_container( ) IS BOUND.
    r_splitter_visibility = g_splitter_visibility.
  ELSE.
    lr_layout = get_splitter_layout( ).
    CHECK lr_layout IS BOUND.
    r_splitter_visibility = lr_layout->get_splitter_visibility( ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_splitter_view~get_top_left_container.

  DATA lr_splitter_container                    TYPE REF TO cl_gui_splitter_container.

  lr_splitter_container = get_splitter_container( ).
  CHECK lr_splitter_container IS BOUND.

  rr_container = lr_splitter_container->get_container(
      row       = 1
      column    = 1 ).

ENDMETHOD.


METHOD if_ish_gui_splitter_view~get_top_left_view.

  DATA lr_layout                                TYPE REF TO cl_ish_gui_splitter_layout.
  DATA l_element_name                           TYPE n1gui_element_name.

  lr_layout = get_splitter_layout( ).
  CHECK lr_layout IS BOUND.

  l_element_name = lr_layout->get_top_left_name( ).

  TRY.
      rr_view ?= get_child_view_by_name( l_element_name ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_splitter_view~set_sash_position.

  DATA lr_layout            TYPE REF TO cl_ish_gui_splitter_layout.
  DATA lr_splitter          TYPE REF TO cl_gui_splitter_container.
  DATA l_result             TYPE i.

* Get the splitter layout.
  lr_layout = get_splitter_layout( ).
  IF lr_layout IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'SET_SASH_POSITION'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.

* Get the splitter container.
  lr_splitter = get_splitter_container( ).

* If the splitter container does not already exist we use the layout.
  IF lr_splitter IS NOT BOUND.
    r_changed = lr_layout->set_sash_position( i_sash_position = i_sash_position ).
    RETURN.
  ENDIF.

* The splitter container does already exist.

* If just one cell is shown we just set g_hidden_sash_position.
  IF g_splitter_visibility <> co_splitvis_both.
    CHECK g_hidden_sash_position <> i_sash_position.
    g_hidden_sash_position = i_sash_position.
    r_changed = abap_true.
    RETURN.
  ENDIF.

* Both cells are shown.
* Set the sash position of the splitter.
  IF lr_layout->get_orientation( ) = co_orientation_horizontal.
      CALL METHOD lr_splitter->set_column_width
      EXPORTING
        id     = 1
        width  = i_sash_position
      IMPORTING
        RESULT = l_result
      EXCEPTIONS
        OTHERS = 1.
  ELSE.
    CALL METHOD lr_splitter->set_row_height
      EXPORTING
        id     = 1
        height = i_sash_position
      IMPORTING
        RESULT = l_result
      EXCEPTIONS
        OTHERS = 1.
  ENDIF.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '2'
        i_mv2 = 'SET_SASH_POSITION'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.
  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '3'
        i_mv2 = 'SET_SASH_POSITION'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.
*  IF l_result = 0.
*    cl_ish_utl_exception=>raise_static(
*        i_typ = 'E'
*        i_kla = 'N1BASE'
*        i_num = '030'
*        i_mv1 = '3'
*        i_mv2 = 'SET_SASH_POSITION'
*        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
*  ENDIF.
  r_changed = abap_true.

ENDMETHOD.


METHOD if_ish_gui_splitter_view~set_splitter_visibility.

  DATA lr_layout                  TYPE REF TO cl_ish_gui_splitter_layout.
  DATA lr_splitter                TYPE REF TO cl_gui_splitter_container.
  DATA l_hidden_sash_position     TYPE i.
  DATA l_cell_id                  TYPE i.
  DATA l_extension                TYPE i.

* Get the splitter layout.
  lr_layout = get_splitter_layout( ).
  IF lr_layout IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'SET_SPLITTER_VISIBILITY'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.

* Get the splitter container.
  lr_splitter = get_splitter_container( ).

* If the splitter container does not already exist we just set the layout.
  IF lr_splitter IS NOT BOUND.
    r_changed = lr_layout->set_splitter_visibility( i_splitter_visibility ).
    RETURN.
  ENDIF.

* The splitter container is bound -> actualize the visibility.

* Process only on changes.
  CHECK i_splitter_visibility <> g_splitter_visibility.

* Switching from both to top_left/bottom_right.
  IF g_splitter_visibility = co_splitvis_both.
*   Remind the actual sash position.
    l_hidden_sash_position = get_sash_position( ).
*   Hide the sash.
    _set_sash_visibility(
        ir_layout     = lr_layout
        ir_splitter   = lr_splitter
        i_visibility  = 0 ).
*   Hide the cell.
    IF lr_layout->get_mode( ) = co_mode_relative.
      l_extension = 100.
      IF i_splitter_visibility = co_splitvis_top_left.
        l_cell_id = 1.
      ELSE.
        l_cell_id = 2.
      ENDIF.
    ELSE.
      l_extension = 0.
      IF i_splitter_visibility = co_splitvis_top_left.
        l_cell_id = 2.
      ELSE.
        l_cell_id = 1.
      ENDIF.
    ENDIF.
    _set_cell_extension(
      ir_layout   = lr_layout
      ir_splitter = lr_splitter
      i_cell_id   = l_cell_id
      i_extension = l_extension ).
*   The splitter_visibility was set.
*   Now set attributes and return.
    g_hidden_sash_position = l_hidden_sash_position.
    g_splitter_visibility  = i_splitter_visibility.
    r_changed = abap_true.
    RETURN.
  ENDIF.

* Switching from top_left/bottom_right to both.
  IF i_splitter_visibility = co_splitvis_both.
*   Show the sash.
    _set_sash_visibility(
        ir_layout     = lr_layout
        ir_splitter   = lr_splitter
        i_visibility  = 1 ).
*   Show the cell.
    _set_cell_extension(
      ir_layout   = lr_layout
      ir_splitter = lr_splitter
      i_cell_id   = 1
      i_extension = g_hidden_sash_position ).
*   The splitter_visibility was set.
*   Now set attributes and return.
    CLEAR g_hidden_sash_position.
    g_splitter_visibility  = i_splitter_visibility.
    r_changed = abap_true.
    RETURN.
  ENDIF.

* Switching from top_left/bottom_right to bottom_right/top_left.
  IF i_splitter_visibility = co_splitvis_top_left.
    _set_cell_extension(
      ir_layout   = lr_layout
      ir_splitter = lr_splitter
      i_cell_id   = 1
      i_extension = 100 ).
  ELSE.
    _set_cell_extension(
      ir_layout   = lr_layout
      ir_splitter = lr_splitter
      i_cell_id   = 2
      i_extension = 100 ).
  ENDIF.
  CLEAR g_hidden_sash_position.
  g_splitter_visibility  = i_splitter_visibility.
  r_changed = abap_true.

ENDMETHOD.


METHOD if_ish_gui_view~actualize_layout.

  DATA lr_layout                  TYPE REF TO cl_ish_gui_splitter_layout.
  DATA lr_splitter                TYPE REF TO cl_gui_splitter_container.
  DATA l_splitter_visibility      TYPE n1gui_splitter_visibility.
  DATA l_sash_position            TYPE i.

* Call the super method.
  super->actualize_layout( ).

* Further processing only on existing splitter container.
  lr_splitter = get_splitter_container( ).
  CHECK lr_splitter IS BOUND.

* Get the splitter layout.
  lr_layout = get_splitter_layout( ).
  CHECK lr_layout IS BOUND.

** Adjust the splitter_visibility.
*  l_splitter_visibility = get_splitter_visibility( ).
*  lr_layout->set_splitter_visibility( l_splitter_visibility ).
*
** Adjust the sash position.
*  l_sash_position = get_sash_position( ).
*  lr_layout->set_sash_position( l_sash_position ).

ENDMETHOD.


METHOD init_splitter_view.

* Self has to be not initialized.
  IF is_initialized( )            = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'INIT_SPLITTER_VIEW'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  _init_splitter_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode ).

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD _add_child_view.

  DATA lr_layout                    TYPE REF TO cl_ish_gui_splitter_layout.

  CHECK ir_child_view IS BOUND.

  lr_layout = get_splitter_layout( ).
  IF lr_layout IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = '_ADD_CHILD_VIEW'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.

  CASE ir_child_view->get_element_name( ).
    WHEN lr_layout->get_top_left_name( ) OR
         lr_layout->get_bottom_right_name( ).
    WHEN OTHERS.
      cl_ish_utl_exception=>raise_static(
          i_typ = 'E'
          i_kla = 'N1BASE'
          i_num = '030'
          i_mv1 = '2'
          i_mv2 = '_ADD_CHILD_VIEW'
          i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDCASE.

  super->_add_child_view( ir_child_view = ir_child_view ).

ENDMETHOD.


METHOD _create_control.

  DATA lr_layout                  TYPE REF TO cl_ish_gui_splitter_layout.
  DATA lr_parent_container_view   TYPE REF TO if_ish_gui_container_view.
  DATA lr_parent_container        TYPE REF TO cl_gui_container.
  DATA l_rows                     TYPE i.
  DATA l_cols                     TYPE i.
  DATA lr_splitter_container      TYPE REF TO cl_gui_splitter_container.
  DATA l_sash_position            TYPE i.
  DATA l_splitter_visibility      TYPE n1gui_splitter_visibility.
  DATA l_mode                     TYPE n1gui_splitter_mode.
  DATA l_mode_i                   TYPE i.
  DATA l_sash_movable             TYPE n1gui_splitter_sashmovable.
  DATA l_sash_movable_i           TYPE i.
  DATA l_result                   TYPE i.

* Get the splitter layout.
  lr_layout = get_splitter_layout( ).
  IF lr_layout IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = '_CREATE_CONTROL'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.

* Get the parent container.
  TRY.
      lr_parent_container_view ?= get_parent_view( ).
      lr_parent_container = lr_parent_container_view->get_container_for_child_view( ir_child_view = me ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_parent_container.
  ENDTRY.
  IF lr_parent_container IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '2'
        i_mv2 = '_CREATE_CONTROL'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.

* Create the splitter container.
  IF lr_layout->get_orientation( ) = co_orientation_horizontal.
    l_rows = 1.
    l_cols = 2.
  ELSE.
    l_rows = 2.
    l_cols = 1.
  ENDIF.
  CREATE OBJECT lr_splitter_container
    EXPORTING
      parent  = lr_parent_container
      rows    = l_rows
      columns = l_cols
    EXCEPTIONS
      others  = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '3'
        i_mv2 = '_CREATE_CONTROL'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.

* Set the mode.
  DO 1 TIMES.
    l_mode = lr_layout->get_mode( ).
    CASE l_mode.
      WHEN co_mode_absolute.
        l_mode_i = lr_splitter_container->mode_absolute.
      WHEN co_mode_relative.
        l_mode_i = lr_splitter_container->mode_relative.
      WHEN OTHERS.
        EXIT.
    ENDCASE.
    CALL METHOD lr_splitter_container->set_row_mode
      EXPORTING
        mode   = l_mode_i
      IMPORTING
        result = l_result
      EXCEPTIONS
        OTHERS = 1.
    CALL METHOD lr_splitter_container->set_column_mode
      EXPORTING
        mode   = l_mode_i
      IMPORTING
        result = l_result
      EXCEPTIONS
        OTHERS = 1.
    CALL METHOD cl_gui_cfw=>flush
      EXCEPTIONS
        OTHERS = 1.
  ENDDO.

* Set the sash_movable.
  DO 1 TIMES.
    l_sash_movable = lr_layout->get_sash_movable( ).
    IF l_sash_movable = abap_true.
      l_sash_movable_i = 1.
    ENDIF.
    CALL METHOD lr_splitter_container->set_row_sash
      EXPORTING
        id     = 1
        type   = lr_splitter_container->type_movable
        value  = l_sash_movable_i
      IMPORTING
        result = l_result
      EXCEPTIONS
        OTHERS = 1.
    CALL METHOD lr_splitter_container->set_column_sash
      EXPORTING
        id     = 1
        type   = lr_splitter_container->type_movable
        value  = l_sash_movable_i
      IMPORTING
        result = l_result
      EXCEPTIONS
        OTHERS = 1.
    CALL METHOD cl_gui_cfw=>flush
      EXCEPTIONS
        OTHERS = 1.
  ENDDO.

* Set the sash position and splitter visibility.
  gr_control            = lr_splitter_container.
  g_splitter_visibility = co_splitvis_both.
  TRY.
      l_sash_position = lr_layout->get_sash_position( ).
      set_sash_position( l_sash_position ).
      l_splitter_visibility = lr_layout->get_splitter_visibility( ).
      set_splitter_visibility( l_splitter_visibility ).
    CLEANUP.
      CLEAR gr_control.
      CLEAR g_splitter_visibility.
      CALL METHOD lr_splitter_container->free
        EXCEPTIONS
          OTHERS = 1.
  ENDTRY.
  CLEAR gr_control.

* Export.
  rr_control = lr_splitter_container.

ENDMETHOD.


METHOD _init_splitter_view.

  DATA lr_layout              TYPE REF TO cl_ish_gui_splitter_layout.
  DATA l_element_name         TYPE n1gui_element_name.

* Handle the layout.
  IF ir_layout IS BOUND.
    lr_layout = ir_layout.
  ELSE.
    l_element_name = get_element_name( ).
    CREATE OBJECT lr_layout
      EXPORTING
        i_element_name = l_element_name.
  ENDIF.

* Initialize the container view.
  _init_container_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = lr_layout
      i_vcode           = i_vcode ).

ENDMETHOD.


METHOD _set_cell_extension.

  DATA l_result                   TYPE i.

  IF ir_layout->get_orientation( ) = co_orientation_horizontal.
    CALL METHOD ir_splitter->set_column_width
      EXPORTING
        id     = i_cell_id
        width  = i_extension
      IMPORTING
        RESULT = l_result
      EXCEPTIONS
        OTHERS = 1.
  ELSE.
    CALL METHOD ir_splitter->set_row_height
      EXPORTING
        id     = i_cell_id
        height = i_extension
      IMPORTING
        RESULT = l_result
      EXCEPTIONS
        OTHERS = 1.
  ENDIF.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = '_SET_CELL_EXTENSION'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.
  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '2'
        i_mv2 = '_SET_CELL_EXTENSION'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _set_sash_visibility.

  DATA l_result                   TYPE i.

* Set the sash visibility.
  IF ir_layout->get_orientation( ) = co_orientation_horizontal.
    CALL METHOD ir_splitter->set_column_sash
      EXPORTING
        id     = 1
        type   = ir_splitter->type_sashvisible
        value  = i_visibility
      IMPORTING
        RESULT = l_result
      EXCEPTIONS
        OTHERS = 1.
  ELSE.
    CALL METHOD ir_splitter->set_row_sash
      EXPORTING
        id     = 1
        type   = ir_splitter->type_sashvisible
        value  = i_visibility
      IMPORTING
        RESULT = l_result
      EXCEPTIONS
        OTHERS = 1.
  ENDIF.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = '_SET_SASH_VISIBILITY'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.
  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '2'
        i_mv2 = '_SET_SASH_VISIBILITY'
        i_mv3 = 'CL_ISH_GUI_SPLITTER_VIEW' ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
