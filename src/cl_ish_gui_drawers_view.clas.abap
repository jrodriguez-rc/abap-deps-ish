class CL_ISH_GUI_DRAWERS_VIEW definition
  public
  inheriting from CL_ISH_GUI_CONTAINER_VIEW
  create protected .

public section.
*"* public components of class CL_ISH_GUI_DRAWERS_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_DRAWERS_VIEW .

  aliases DISABLE_DRAWER
    for IF_ISH_GUI_DRAWERS_VIEW~DISABLE_DRAWER .
  aliases ENABLE_DRAWER
    for IF_ISH_GUI_DRAWERS_VIEW~ENABLE_DRAWER .
  aliases GET_OPENED_DRAWER_NAME
    for IF_ISH_GUI_DRAWERS_VIEW~GET_OPEN_DRAWER_NAME .
  aliases OPEN_DRAWER_BY_NAME
    for IF_ISH_GUI_DRAWERS_VIEW~OPEN_DRAWER_BY_NAME .

  constants CO_MAX_DRAWERS type I value 8. "#EC NOTEXT
  constants CO_TOOLBAR_HEIGHT type I value 24. "#EC NOTEXT

  class-methods CREATE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_DRAWERS_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_DRAWERS_LAYOUT optional
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
      !IT_DRAWERDEF type ISHMED_T_GUI_DRAWERDEF_HASH
      !I_OPEN_DRAWER_NAME type N1GUI_ELEMENT_NAME optional
    raising
      CX_ISH_STATIC_HANDLER .

  methods IF_ISH_GUI_CONTAINER_VIEW~GET_CONTAINER_FOR_CHILD_VIEW
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_DRAWERS_VIEW
*"* do not include other source files here!!!

  types:
    BEGIN OF gty_toolbar,
           drawer_name          TYPE n1gui_element_name,
           r_toolbar            TYPE REF TO cl_gui_toolbar,
         END OF gty_toolbar .
  types:
    gtyt_toolbar  TYPE HASHED TABLE OF gty_toolbar WITH UNIQUE KEY drawer_name .

  data GT_DRAWERDEF type ISHMED_T_GUI_DRAWERDEF_HASH .
  data GT_TOOLBAR type GTYT_TOOLBAR .
  data G_OPEN_DRAWER_NAME type N1GUI_ELEMENT_NAME .

  methods ON_DRAWER_SELECTED
    for event FUNCTION_SELECTED of CL_GUI_TOOLBAR
    importing
      !FCODE
      !SENDER .
  methods _GET_ROW_BY_DRAWER_NAME
    importing
      !I_DRAWER_NAME type N1GUI_ELEMENT_NAME
    returning
      value(R_ROW) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_SPLITTER
    returning
      value(RR_SPLITTER) type ref to CL_GUI_SPLITTER_CONTAINER
    raising
      CX_ISH_STATIC_HANDLER .
  methods _INIT_DRAWERS_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_DRAWERS_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !IT_DRAWERDEF type ISHMED_T_GUI_DRAWERDEF_HASH
      !I_OPEN_DRAWER_NAME type N1GUI_ELEMENT_NAME optional
    raising
      CX_ISH_STATIC_HANDLER .

  methods _ADD_CHILD_VIEW
    redefinition .
  methods _CREATE_CONTROL
    redefinition .
  methods _DESTROY
    redefinition .
  methods _PROCESS_COMMAND_REQUEST
    redefinition .
  methods _PROCESS_EVENT_REQUEST
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_DRAWERS_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_DRAWERS_VIEW IMPLEMENTATION.


METHOD CREATE.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name = i_element_name.

ENDMETHOD.


METHOD if_ish_gui_container_view~get_container_for_child_view.

  DATA lr_splitter      TYPE REF TO cl_gui_splitter_container.
  DATA l_row            TYPE i.
  DATA l_element_name   TYPE N1GUI_ELEMENT_NAME.

* The child view has to be specified.
  CHECK ir_child_view IS BOUND.

* Get the splitter.
  TRY.
      lr_splitter = _get_splitter( ).
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

* Get the row for the child_view.
  l_element_name = ir_child_view->get_element_name( ).
  TRY.
      l_row = _get_row_by_drawer_name( l_element_name ) + 1.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

* Return the row container.
  rr_container = lr_splitter->get_container( row    = l_row
                                             column = 1 ).

ENDMETHOD.


METHOD if_ish_gui_drawers_view~disable_drawer.

  DATA l_fcode                  TYPE ui_func.

  FIELD-SYMBOLS <ls_drawerdef>  TYPE rn1_gui_drawerdef.
  FIELD-SYMBOLS <ls_toolbar>    TYPE gty_toolbar.

* Initial checking.
  CHECK i_drawer_name IS NOT INITIAL.

* Proceed only if the given drawer is defined and it is disabled.
  READ TABLE gt_drawerdef WITH KEY drawer_name  = i_drawer_name
                                   disabled     = abap_false ASSIGNING <ls_drawerdef>.
  CHECK sy-subrc = 0.
  <ls_drawerdef>-disabled = abap_true.

* Get the toolbar.
  READ TABLE gt_toolbar WITH KEY drawer_name = i_drawer_name ASSIGNING <ls_toolbar>.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'ENABLE_DRAWER'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

* Disable the drawer.
  l_fcode = i_drawer_name.
  <ls_toolbar>-r_toolbar->set_button_state(
                            fcode = l_fcode
                            enabled = abap_false ).

ENDMETHOD.


METHOD if_ish_gui_drawers_view~enable_drawer.

  DATA l_fcode                  TYPE ui_func.

  FIELD-SYMBOLS <ls_drawerdef>  TYPE rn1_gui_drawerdef.
  FIELD-SYMBOLS <ls_toolbar>    TYPE gty_toolbar.

* Initial checking.
  CHECK i_drawer_name IS NOT INITIAL.

* Proceed only if the given drawer is defined and it is disabled.
  READ TABLE gt_drawerdef WITH KEY drawer_name  = i_drawer_name
                                   disabled     = abap_true ASSIGNING <ls_drawerdef>.
  CHECK sy-subrc = 0.
  <ls_drawerdef>-disabled = abap_false.

* Get the toolbar.
  READ TABLE gt_toolbar WITH KEY drawer_name = i_drawer_name ASSIGNING <ls_toolbar>.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'ENABLE_DRAWER'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

* Enable the drawer.
* Set button state don't work here. So delete the
* old button and add a new one.
  l_fcode = i_drawer_name.
  <ls_toolbar>-r_toolbar->delete_button( l_fcode ).
  <ls_toolbar>-r_toolbar->add_button(
      fcode       = l_fcode
      icon        = <ls_drawerdef>-icon
      is_disabled = <ls_drawerdef>-disabled
      butn_type   = cntb_btype_outlookbutton
      text        = <ls_drawerdef>-caption
      quickinfo   = <ls_drawerdef>-quickinfo ).

ENDMETHOD.


METHOD if_ish_gui_drawers_view~get_open_drawer_name.

  r_open_drawer_name = g_open_drawer_name.

ENDMETHOD.


METHOD if_ish_gui_drawers_view~get_open_view.

  TRY.
      rr_open_view ?= get_child_view_by_name( g_open_drawer_name ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_drawers_view~open_drawer_by_name.

  DATA l_row_toolbar_old                TYPE i.
  DATA l_row_content_old                TYPE i.
  DATA l_row_toolbar_new                TYPE i.
  DATA l_row_content_new                TYPE i.
  DATA lr_splitter                      TYPE REF TO cl_gui_splitter_container.

* Process only on changes.
  CHECK g_open_drawer_name <> i_drawer_name.

* The drawer name has to be specified.
  IF i_drawer_name IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'OPEN_DRAWER_BY_NAME'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

* Get the row of the actual opened drawer.
  IF g_open_drawer_name IS NOT INITIAL.
    l_row_toolbar_old = _get_row_by_drawer_name( g_open_drawer_name ).
    l_row_content_old = l_row_toolbar_old + 1.
  ENDIF.

* Get the row of the drawer to open.
  l_row_toolbar_new = _get_row_by_drawer_name( i_drawer_name ).
  l_row_content_new = l_row_toolbar_new + 1.

* Get the splitter.
  lr_splitter = _get_splitter( ).

* Close the actual opened content.
  CALL METHOD lr_splitter->set_row_height
    EXPORTING
      id     = l_row_content_old
      height = 0
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'OPEN_DRAWER_BY_NAME'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

* Open the new toolbar.
  CALL METHOD lr_splitter->set_row_height
    EXPORTING
      id     = l_row_toolbar_new
      height = co_toolbar_height
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = 'OPEN_DRAWER_BY_NAME'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

* Open the new content.
  CALL METHOD lr_splitter->set_row_height
    EXPORTING
      id     = l_row_content_new
      height = -1
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '4'
        i_mv2        = 'OPEN_DRAWER_BY_NAME'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

* Set g_opened_drawer_name.
  g_open_drawer_name = i_drawer_name.

  CALL METHOD cl_gui_cfw=>update_view
    EXCEPTIONS
      OTHERS = 1.

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
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      _init_drawers_view(
          ir_controller       = ir_controller
          ir_parent_view      = ir_parent_view
          ir_layout           = ir_layout
          i_vcode             = i_vcode
          it_drawerdef        = it_drawerdef
          i_open_drawer_name  = i_open_drawer_name ).
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD on_drawer_selected.

  DATA lr_request               TYPE REF TO cl_ish_gui_request.
  DATA lr_response              TYPE REF TO cl_ish_gui_response.

* no request if user clicked opened draw
  CHECK g_open_drawer_name <> fcode.

* Propagate the request.
  lr_request = cl_ish_gui_drawers_event=>create( ir_sender = me
                                                 i_fcode   = fcode ).
  lr_response = _propagate_request( ir_request = lr_request ).

* After request processing.
  if_ish_gui_request_processor~after_request_processing(
      ir_request  = lr_request
      ir_response = lr_response ).

ENDMETHOD.


METHOD _add_child_view.

  DATA: l_element_name        TYPE n1gui_element_name.

* The child view has to be specified.
  IF ir_child_view IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_ADD_CHILD_VIEW'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

* The given child view has to be defined in gt_drawerdef.
  l_element_name = ir_child_view->get_element_name( ).
  READ TABLE gt_drawerdef
    WITH TABLE KEY drawer_name = l_element_name
    TRANSPORTING NO FIELDS.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_ADD_CHILD_VIEW'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

* Further processing by the super method.
  super->_add_child_view( ir_child_view ).

ENDMETHOD.


METHOD _create_control.

  DATA lr_parent_container_view       TYPE REF TO if_ish_gui_container_view.
  DATA lr_parent_container            TYPE REF TO cl_gui_container.
  DATA l_rows                         TYPE i.
  DATA lr_splitter                    TYPE REF TO cl_gui_splitter_container.
  DATA l_row                          TYPE i.
  DATA l_height                       TYPE i.
  DATA lr_container                   TYPE REF TO cl_gui_container.
  DATA ls_toolbar                     LIKE LINE OF gt_toolbar.
  DATA l_fcode                        TYPE ui_func.
  DATA ls_event                       TYPE cntl_simple_event.
  DATA lt_event                       TYPE cntl_simple_events.
  DATA l_open_drawer_name             LIKE g_open_drawer_name.
  DATA lx_root                        TYPE REF TO cx_root.

  FIELD-SYMBOLS <ls_drawerdef>        LIKE LINE OF gt_drawerdef.

* Get the parent container.
  TRY.
      lr_parent_container_view ?= get_parent_view( ).
      lr_parent_container = lr_parent_container_view->get_container_for_child_view( ir_child_view = me ).
    CATCH cx_root INTO lx_root.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = '_CREATE_CONTROL'
          i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDTRY.

* Calculate the rows of the splitter (lines of drawers * 2).
  l_rows = LINES( gt_drawerdef ).
  IF l_rows < 1 OR
     l_rows > co_max_drawers.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.
  l_rows = l_rows * 2.

* Create the splitter.
  CREATE OBJECT lr_splitter
    EXPORTING
      parent  = lr_parent_container
      rows    = l_rows
      columns = 1
    EXCEPTIONS
      OTHERS  = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.
  CALL METHOD lr_splitter->set_border
    EXPORTING
      border = gfw_false
    EXCEPTIONS
      OTHERS = 0.
  CALL METHOD lr_splitter->set_row_mode
    EXPORTING
      mode   = cl_gui_splitter_container=>mode_absolute
    EXCEPTIONS
      OTHERS = 0.

* Setup the splitter layout and create the toolbars.
  l_row = 0.
  LOOP AT gt_drawerdef ASSIGNING <ls_drawerdef>.
*   Layout for the toolbar.
    l_row = l_row + 1.
    IF <ls_drawerdef>-hidden = abap_true.
      l_height = 0.
    ELSE.
      l_height = co_toolbar_height.
    ENDIF.
    CALL METHOD lr_splitter->set_row_height
      EXPORTING
        id     = l_row
        height = l_height
      EXCEPTIONS
        OTHERS = 0.
    CALL METHOD lr_splitter->set_row_sash
      EXPORTING
        id     = l_row
        type   = cl_gui_splitter_container=>type_movable
        value  = cl_gui_splitter_container=>false
      EXCEPTIONS
        OTHERS = 0.
    CALL METHOD lr_splitter->set_row_sash
      EXPORTING
        id     = l_row
        type   = cl_gui_splitter_container=>type_sashvisible
        value  = cl_gui_splitter_container=>false
      EXCEPTIONS
        OTHERS = 0.
*   Create the toolbar
    CALL METHOD lr_splitter->get_container
      EXPORTING
        row       = l_row
        column    = 1
      RECEIVING
        container = lr_container
      EXCEPTIONS
        OTHERS    = 0.
    CLEAR ls_toolbar.
    ls_toolbar-drawer_name = <ls_drawerdef>-drawer_name.
    CREATE OBJECT ls_toolbar-r_toolbar
      EXPORTING
        parent = lr_container
      EXCEPTIONS
        OTHERS = 0.
    INSERT ls_toolbar INTO TABLE gt_toolbar.
    CLEAR ls_event.
    ls_event-eventid = cl_gui_toolbar=>m_id_function_selected.
    APPEND ls_event TO lt_event.
    CALL METHOD ls_toolbar-r_toolbar->set_registered_events
      EXPORTING
        events = lt_event
      EXCEPTIONS
        OTHERS = 0.
    SET HANDLER on_drawer_selected FOR ls_toolbar-r_toolbar ACTIVATION abap_true.
    l_fcode     = <ls_drawerdef>-drawer_name.
    CALL METHOD ls_toolbar-r_toolbar->add_button
      EXPORTING
        fcode       = l_fcode
        icon        = <ls_drawerdef>-icon
        is_disabled = <ls_drawerdef>-disabled
        butn_type   = cntb_btype_outlookbutton
        text        = <ls_drawerdef>-caption
        quickinfo   = <ls_drawerdef>-quickinfo
      EXCEPTIONS
        OTHERS      = 0.
*   Layout for the content.
    l_row = l_row + 1.
    CALL METHOD lr_splitter->set_row_height
      EXPORTING
        id     = l_row
        height = 0
      EXCEPTIONS
        OTHERS = 0.
    CALL METHOD lr_splitter->set_row_sash
      EXPORTING
        id     = l_row
        type   = cl_gui_splitter_container=>type_movable
        value  = cl_gui_splitter_container=>false
      EXCEPTIONS
        OTHERS = 0.
  ENDLOOP.

* Open the active drawer.
  l_open_drawer_name = g_open_drawer_name.
  CLEAR g_open_drawer_name.
  gr_control = lr_splitter.
  TRY.
      open_drawer_by_name( l_open_drawer_name ).
    CLEANUP.
      CLEAR gr_control.
  ENDTRY.

* Export.
  rr_control = lr_splitter.

ENDMETHOD.


METHOD _DESTROY.

  FIELD-SYMBOLS <ls_toolbar>  LIKE LINE OF gt_toolbar.

  LOOP AT gt_toolbar ASSIGNING <ls_toolbar>.
    CHECK <ls_toolbar>-r_toolbar IS BOUND.
    CALL METHOD <ls_toolbar>-r_toolbar->free
      EXCEPTIONS
        OTHERS = 0.
  ENDLOOP.
  CLEAR gt_toolbar.

  super->_destroy( ).

ENDMETHOD.


METHOD _get_row_by_drawer_name.

  DATA l_row                            TYPE i.

  FIELD-SYMBOLS <ls_toolbar>            LIKE LINE OF gt_toolbar.

  LOOP AT gt_toolbar ASSIGNING <ls_toolbar>.
    l_row = l_row + 1.
    CHECK <ls_toolbar>-drawer_name = i_drawer_name.
    r_row = l_row * 2 - 1.
    EXIT.
  ENDLOOP.

  IF r_row IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_GET_ROW_BY_DRAWER_NAME'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _get_splitter.

  DATA lx_root            TYPE REF TO cx_root.

  TRY.
      rr_splitter ?= get_control( ).
    CATCH cx_sy_move_cast_error INTO lx_root.
      CLEAR rr_splitter.
  ENDTRY.

  IF rr_splitter IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_GET_SPLITTER'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _init_drawers_view.

  FIELD-SYMBOLS <ls_drawerdef>            LIKE LINE OF gt_drawerdef.

* Check the drawerdefs.
  IF LINES( it_drawerdef ) < 1 OR
     LINES( it_drawerdef ) > co_max_drawers.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_INIT_DRAWERS_VIEW'
        i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
  ENDIF.

* Check the specified opened drawer.
  IF i_open_drawer_name IS NOT INITIAL.
    READ TABLE it_drawerdef
      WITH TABLE KEY drawer_name = i_open_drawer_name
      TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = '_INIT_DRAWERS_VIEW'
          i_mv3        = 'CL_ISH_GUI_DRAWERS_VIEW' ).
    ENDIF.
  ENDIF.

* Call the super method.
  _init_container_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode ).

* Initialize self.
  gt_drawerdef = it_drawerdef.
  IF i_open_drawer_name IS INITIAL.
    LOOP AT gt_drawerdef ASSIGNING <ls_drawerdef>.
      g_open_drawer_name = <ls_drawerdef>-drawer_name.
      EXIT.
    ENDLOOP.
  ELSE.
    g_open_drawer_name = i_open_drawer_name.
  ENDIF.

ENDMETHOD.


METHOD _process_command_request.

  DATA lr_okcode_request        TYPE REF TO cl_ish_gui_okcode_request.
  DATA lr_drawers_event         TYPE REF TO cl_ish_gui_drawers_event.
  DATA l_drawer_name            TYPE n1gui_element_name.
  DATA lx_root                  TYPE REF TO cx_root.

  CHECK ir_command_request IS BOUND.
  lr_okcode_request = ir_command_request->get_okcode_request( ).
  CHECK lr_okcode_request IS BOUND.
  TRY.
      lr_drawers_event ?= lr_okcode_request->get_control_event( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_drawers_event IS BOUND.
  CHECK lr_drawers_event->get_sender( ) = me.

  TRY.

      l_drawer_name = lr_drawers_event->get_fcode( ).
      open_drawer_by_name( i_drawer_name = l_drawer_name ).

      rr_response = cl_ish_gui_response=>create( ir_request   = ir_command_request
                                                 ir_processor = me ).

    CATCH cx_ish_static_handler INTO lx_root.

      _propagate_exception( lx_root ).
      rr_response = cl_ish_gui_response=>create( ir_request   = ir_command_request
                                                 ir_processor = me
                                                 i_exit       = abap_false ).
      RETURN.

  ENDTRY.

ENDMETHOD.


METHOD _process_event_request.

  DATA lr_drawers_event         TYPE REF TO cl_ish_gui_drawers_event.
  DATA l_drawer_name            TYPE n1gui_element_name.
  DATA lr_tmp_messages          TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_root                  TYPE REF TO cx_root.

  CHECK ir_event_request IS BOUND.
  CHECK ir_event_request->get_sender( ) = me.

  TRY.
      lr_drawers_event ?= ir_event_request.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  TRY.

      l_drawer_name = lr_drawers_event->get_fcode( ).
      open_drawer_by_name( i_drawer_name = l_drawer_name ).

      rr_response = cl_ish_gui_response=>create( ir_request   = ir_event_request
                                                 ir_processor = me ).

    CATCH cx_ish_static_handler INTO lx_root.

      CLEAR lr_tmp_messages.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
        EXPORTING
          i_exceptions    = lx_root
        CHANGING
          cr_errorhandler = lr_tmp_messages.
      IF lr_tmp_messages IS BOUND.
        lr_tmp_messages->display_messages( ).
      ENDIF.

      rr_response = cl_ish_gui_response=>create( ir_request   = ir_event_request
                                                 ir_processor = me ).

      RETURN.

  ENDTRY.

ENDMETHOD.
ENDCLASS.
