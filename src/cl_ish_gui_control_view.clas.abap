class CL_ISH_GUI_CONTROL_VIEW definition
  public
  inheriting from CL_ISH_GUI_VIEW
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_CONTROL_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_CONTROL_VIEW .

  aliases FIRST_DISPLAY
    for IF_ISH_GUI_CONTROL_VIEW~FIRST_DISPLAY .
  aliases GET_CONTROL
    for IF_ISH_GUI_CONTROL_VIEW~GET_CONTROL .
  aliases GET_CONTROL_LAYOUT
    for IF_ISH_GUI_CONTROL_VIEW~GET_CONTROL_LAYOUT .
  aliases GET_VISIBILITY
    for IF_ISH_GUI_CONTROL_VIEW~GET_VISIBILITY .
  aliases REFRESH_DISPLAY
    for IF_ISH_GUI_CONTROL_VIEW~REFRESH_DISPLAY .
  aliases SET_VISIBILITY
    for IF_ISH_GUI_CONTROL_VIEW~SET_VISIBILITY .
  aliases EV_VISIBILITY_CHANGED
    for IF_ISH_GUI_CONTROL_VIEW~EV_VISIBILITY_CHANGED .

  class-events EV_DISPATCH .
  class-events EV_FLUSH .

  type-pools ABAP .
  class-methods ACTIVATE_FLUSH_BUFFER
    returning
      value(R_ACTIVATED) type ABAP_BOOL .
  class-methods DISPATCH .
  class-methods FLUSH .
  class-methods IS_FLUSH_BUFFER_ACTIVE
    returning
      value(R_FLUSH_BUFFER_ACTIVE) type ABAP_BOOL .
  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    preferred parameter I_ELEMENT_NAME .

  methods IF_ISH_GUI_VIEW~SET_FOCUS
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_CONTROL_VIEW
*"* do not include other source files here!!!

  data GR_CONTROL type ref to CL_GUI_CONTROL .
  data G_VISIBLE type ABAP_BOOL .

  methods ON_CHILD_VISIBILITY_CHANGED
    for event EV_VISIBILITY_CHANGED of IF_ISH_GUI_CONTROL_VIEW
    importing
      !E_VISIBLE
      !SENDER .
  methods ON_DISPATCH
    for event EV_DISPATCH of CL_ISH_GUI_CONTROL_VIEW .
  methods _CREATE_CONTROL
  abstract
    returning
      value(RR_CONTROL) type ref to CL_GUI_CONTROL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CREATE_CONTROL_ON_DEMAND
    returning
      value(RR_CONTROL) type ref to CL_GUI_CONTROL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _FIRST_DISPLAY
  abstract
    raising
      CX_ISH_STATIC_HANDLER .
  methods _INIT_CONTROL_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_CONTROL_LAYOUT optional
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REFRESH_DISPLAY
  abstract
    importing
      !I_FORCE type ABAP_BOOL default ABAP_FALSE
    raising
      CX_ISH_STATIC_HANDLER .

  methods _ADD_CHILD_VIEW
    redefinition .
  methods _DESTROY
    redefinition .
  methods _REMOVE_CHILD_VIEW
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_CONTROL_VIEW
*"* do not include other source files here!!!

  types:
    BEGIN OF gty_flush_tree,
      r_alv_tree  TYPE REF TO cl_gui_alv_tree,
    END OF gty_flush_tree .
  types:
    gtyt_flush_tree  TYPE HASHED TABLE OF gty_flush_tree WITH UNIQUE KEY r_alv_tree .
  types:
    BEGIN OF gty_flush_grid,
      r_alv_grid    TYPE REF TO cl_gui_alv_grid,
      stable_row    TYPE abap_bool,
      stable_col    TYPE abap_bool,
      soft_refresh  TYPE abap_bool,
    END OF gty_flush_grid .
  types:
    gtyt_flush_grid  TYPE HASHED TABLE OF gty_flush_grid WITH UNIQUE KEY r_alv_grid .

  class-data G_FLUSH_BUFFER_ACTIVE type ABAP_BOOL value ABAP_FALSE. "#EC NOTEXT .
ENDCLASS.



CLASS CL_ISH_GUI_CONTROL_VIEW IMPLEMENTATION.


METHOD activate_flush_buffer.

  CHECK g_flush_buffer_active = abap_false.

  g_flush_buffer_active = abap_true.

  r_activated = abap_true.

ENDMETHOD.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

ENDMETHOD.


METHOD dispatch.

  RAISE EVENT ev_dispatch.

ENDMETHOD.


METHOD flush.

  RAISE EVENT ev_flush.

  g_flush_buffer_active = abap_false.

ENDMETHOD.


METHOD if_ish_gui_control_view~first_display.

  DATA:
    lt_child_view    TYPE ish_t_gui_viewid_hash,
    lr_control_view  TYPE REF TO if_ish_gui_control_view,
    lr_control       TYPE REF TO cl_gui_control,
    lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
    lx_root          TYPE REF TO cx_root.

  FIELD-SYMBOLS:
    <ls_child_view>    LIKE LINE OF lt_child_view.

* Self has to be valid (= initialized, not destroyed, ... ).
  IF is_initialized( )           = abap_false OR
     is_destroyed( )             = abap_true  OR
     is_in_destroy_mode( )       = abap_true  OR
     is_in_first_display_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'FIRST_DISPLAY'
        i_mv3        = 'CL_ISH_GUI_CONTROL_VIEW' ).
  ENDIF.

* First display for self.
  IF is_first_display_done( ) = abap_false.
    g_first_display_mode = abap_true.
    TRY.
        _first_display( ).
      CLEANUP.
        g_first_display_mode = abap_false.
    ENDTRY.
  ENDIF.

* If we have the focus we have to set the control's focus.
  IF has_focus( ) = abap_true.
    lr_control = get_control( ).
    IF lr_control IS BOUND.
      CALL METHOD cl_gui_control=>set_focus
        EXPORTING
          control = lr_control
        EXCEPTIONS
          OTHERS  = 0.
    ENDIF.
  ENDIF.

* First display for self was done.
  g_first_display_mode = abap_false.
  g_first_display_done = abap_true.

* Further processing only if first_display should also be done for the child views.
  CHECK i_with_child_views = abap_true.

* First display for the child views.
* Any errors are collected and thrown at the end of this method.
  lt_child_view = get_child_views( i_with_subchildren = abap_false ).
  LOOP AT lt_child_view ASSIGNING <ls_child_view>.
    CHECK <ls_child_view>-r_view IS BOUND.
    TRY.
        lr_control_view ?= <ls_child_view>-r_view.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
    TRY.
        lr_control_view->first_display( i_with_child_views = abap_true ).
      CATCH cx_ish_static_handler INTO lx_root.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
          EXPORTING
            i_exceptions    = lx_root
          CHANGING
            cr_errorhandler = lr_errorhandler.
        CONTINUE.
    ENDTRY.
  ENDLOOP.

* On any errors throw an exception.
  IF lr_errorhandler IS BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_control_view~get_control.

  rr_control = gr_control.

ENDMETHOD.


METHOD if_ish_gui_control_view~get_control_layout.

  TRY.
      rr_control_layout ?= get_layout( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_control_view~get_visibility.

  r_visible = g_visible.

ENDMETHOD.


METHOD if_ish_gui_control_view~refresh_display.

  DATA:
    lt_child_view    TYPE ish_t_gui_viewid_hash,
    lr_control_view  TYPE REF TO if_ish_gui_control_view,
    lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
    lx_root          TYPE REF TO cx_root.

  FIELD-SYMBOLS:
    <ls_child_view>    LIKE LINE OF lt_child_view.

  IF is_initialized( )        = abap_false OR
     is_destroyed( )          = abap_true  OR
     is_in_destroy_mode( )    = abap_true  OR
     is_first_display_done( ) = abap_false.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  _refresh_display( i_force = i_force ).

  CHECK i_with_child_views = abap_true.

  lt_child_view = get_child_views( i_with_subchildren = abap_false ).
  LOOP AT lt_child_view ASSIGNING <ls_child_view>.
    CHECK <ls_child_view>-r_view IS BOUND.
    TRY.
        lr_control_view ?= <ls_child_view>-r_view.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
    TRY.
        IF lr_control_view->is_first_display_done( ) = abap_true.
          lr_control_view->refresh_display( i_force            = i_force
                                            i_with_child_views = abap_true ).
        ELSE.
          lr_control_view->first_display( i_with_child_views = abap_true ).
        ENDIF.
      CATCH cx_ish_static_handler INTO lx_root.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
          EXPORTING
            i_exceptions    = lx_root
          CHANGING
            cr_errorhandler = lr_errorhandler.
        CONTINUE.
    ENDTRY.
  ENDLOOP.

  IF lr_errorhandler IS BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_control_view~set_visibility.

* Process only on changes.
  CHECK i_visible <> g_visible.

* Set the visibility of the control
  IF gr_control IS BOUND.
    CALL METHOD gr_control->set_visible
      EXPORTING
        visible = i_visible
      EXCEPTIONS
        OTHERS  = 1.
    IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static_by_syst( ir_object = me ).
    ENDIF.
  ENDIF.

* Set g_visible.
  g_visible = i_visible.

* Raise event ev_visibility_changed.
  RAISE EVENT ev_visibility_changed
    EXPORTING
      e_visible = i_visible.

* Self was changed.
  r_changed = abap_true.

ENDMETHOD.


METHOD if_ish_gui_view~set_focus.

  DATA:
    lr_control            TYPE REF TO cl_gui_control,
    lr_application        TYPE REF TO if_ish_gui_application,
    lr_focussed_view      TYPE REF TO if_ish_gui_view.

* Get the application.
  lr_application = get_application( ).
  CHECK lr_application IS BOUND.

* Remember the actual focussed view.
  lr_focussed_view = lr_application->get_focussed_view( ).

* Set the focussed view of the application.
  r_success = lr_application->set_focussed_view( ir_view = me ).
  CHECK r_success = abap_true.

* If first display was not already done, that's all for the moment.
* The focus to our control will be set at first display.
  CHECK is_first_display_done( ) = abap_true.

* Now set the focus to our control.
* If it fails we have to reset the application's focussed view.
  lr_control = get_control( ).
  IF lr_control IS BOUND.
    CALL METHOD cl_gui_control=>set_focus
      EXPORTING
        control = lr_control
      EXCEPTIONS
        OTHERS  = 1.
    CHECK sy-subrc = 0.
    r_success = abap_true.
    RETURN.
  ENDIF.

* The focus could not be set to our control -> Reset the old focussed view.
  lr_application->set_focussed_view( ir_view = lr_focussed_view ).

ENDMETHOD.


METHOD is_flush_buffer_active.

  r_flush_buffer_active = g_flush_buffer_active.

ENDMETHOD.


method ON_CHILD_VISIBILITY_CHANGED.
endmethod.


METHOD on_dispatch.

* No default processing.

ENDMETHOD.


METHOD _add_child_view.

  DATA:
    lr_control_view    TYPE REF TO if_ish_gui_control_view.

* The child view has to be a control view.
  TRY.
      lr_control_view ?= ir_child_view.
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = '_ADD_CHILD_VIEW'
          i_mv3        = 'CL_ISH_GUI_CONTROL_VIEW' ).
  ENDTRY.

* Further processing by the super method.
  super->_add_child_view( ir_child_view = ir_child_view ).

* Register self for the ev_visibility_changed event of the new child view.
  SET HANDLER on_child_visibility_changed FOR lr_control_view ACTIVATION abap_true.

ENDMETHOD.


METHOD _create_control_on_demand.

* If the control does already exist -> return it.
  IF gr_control IS BOUND.
    rr_control = gr_control.
    RETURN.
  ENDIF.

* Create the control.
  gr_control = _create_control( ).
  IF gr_control IS NOT BOUND.
    CALL METHOD cl_ish_utl_exception=>raise_static(
      i_typ = 'E'
      i_kla = 'N1BASE'
      i_num = '030'
      i_mv1 = '1'
      i_mv2 = '_CREATE_CONTROL_ON_DEMAND'
      i_mv3 = 'CL_ISH_GUI_CONTROL_VIEW' ).
  ENDIF.

* Set the dispatch eventhandler.
  SET HANDLER on_dispatch ACTIVATION abap_true.

* Set the visibility.
  g_visible = abap_true.

* Export.
  rr_control = gr_control.

ENDMETHOD.


METHOD _destroy.

  DATA lr_control_view                    TYPE REF TO if_ish_gui_control_view.

  FIELD-SYMBOLS <ls_child_view>           LIKE LINE OF gt_child_view.

* Call the super method.
  super->_destroy( ).

* Deregister the eventhandlers.
  SET HANDLER on_dispatch ACTIVATION abap_false.
  LOOP AT gt_child_view ASSIGNING <ls_child_view>.
    CHECK <ls_child_view>-r_view IS BOUND.
    TRY.
        lr_control_view ?= <ls_child_view>-r_view.
        SET HANDLER on_child_visibility_changed FOR lr_control_view ACTIVATION abap_false.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
  ENDLOOP.

* Free the control.
  IF gr_control IS BOUND.
    CALL METHOD gr_control->free
      EXCEPTIONS
        OTHERS = 1.
  ENDIF.

* Clear attributes.
  CLEAR gr_control.
  g_visible = abap_false.

ENDMETHOD.


METHOD _init_control_view.

* The parent view has to be specified.
  IF ir_parent_view IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_INIT_CONTROL_VIEW'
        i_mv3        = 'CL_ISH_GUI_CONTROL_VIEW' ).
  ENDIF.

* Further initialization by _init_view.
  _init_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode ).

ENDMETHOD.


METHOD _remove_child_view.

  DATA:
    lr_control_view            TYPE REF TO if_ish_gui_control_view.

* First call the super method to remove the child view.
  r_removed = super->_remove_child_view( ir_child_view = ir_child_view ).

* Now deregister self for the ev_child_visibility_changed event of the removed child view.
  IF r_removed = abap_true AND
     ir_child_view IS BOUND.
    TRY.
        lr_control_view ?= ir_child_view.
        SET HANDLER on_child_visibility_changed FOR lr_control_view ACTIVATION abap_false.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
  ENDIF.

ENDMETHOD.
ENDCLASS.
