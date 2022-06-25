class CL_ISH_GUI_TABSTRIP_VIEW definition
  public
  inheriting from CL_ISH_GUI_SDY_VIEW
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_TABSTRIP_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_TABSTRIP_VIEW .

  aliases GET_ACTIVE_TAB_NAME
    for IF_ISH_GUI_TABSTRIP_VIEW~GET_ACTIVE_TAB_NAME .
  aliases GET_ACTIVE_TAB_VIEW
    for IF_ISH_GUI_TABSTRIP_VIEW~GET_ACTIVE_TAB_VIEW .
  aliases SET_ACTIVE_TAB_BY_NAME
    for IF_ISH_GUI_TABSTRIP_VIEW~SET_ACTIVE_TAB_BY_NAME .
  aliases SET_ACTIVE_TAB_BY_VIEW
    for IF_ISH_GUI_TABSTRIP_VIEW~SET_ACTIVE_TAB_BY_VIEW .
  aliases EV_ACTIVETAB_CHANGED
    for IF_ISH_GUI_TABSTRIP_VIEW~EV_ACTIVETAB_CHANGED .

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    preferred parameter I_ELEMENT_NAME .
protected section.
*"* protected components of class CL_ISH_GUI_TABSTRIP_VIEW
*"* do not include other source files here!!!

  data GR_TABSTRIP type ref to SCXTAB_TABSTRIP .

  methods _INIT_TABSTRIP_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW optional
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
      !IR_TABSTRIP type ref to SCXTAB_TABSTRIP
    raising
      CX_ISH_STATIC_HANDLER .

  methods _ADD_CHILD_VIEW
    redefinition .
  methods _DESTROY
    redefinition .
  methods _MODIFY_SCREEN
    redefinition .
  methods _PROCESS_COMMAND_REQUEST
    redefinition .
  methods __BEFORE_CALL_SUBSCREEN
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_TABSTRIP_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_TABSTRIP_VIEW IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

ENDMETHOD.


METHOD if_ish_gui_tabstrip_view~get_active_tab_name.

  CHECK gr_tabstrip IS BOUND.

  r_active_tab_name = gr_tabstrip->activetab.

ENDMETHOD.


METHOD if_ish_gui_tabstrip_view~get_active_tab_view.

  DATA l_active_tab_name              TYPE n1gui_element_name.

  l_active_tab_name = get_active_tab_name( ).

  TRY.
      rr_active_tab_view ?= get_child_view_by_name( l_active_tab_name ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_tabstrip_view~set_active_tab_by_name.

  DATA l_old_activetab            TYPE n1gui_element_name.
  DATA lt_child_view              TYPE ish_t_gui_viewid_hash.

  FIELD-SYMBOLS <ls_child_view>   TYPE rn1_gui_viewid_hash.

* The tab_name has to be specified.
  IF i_tab_name IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_ACTIVE_TAB_BY_NAME'
        i_mv3        = 'CL_ISH_GUI_TABSTRIP_VIEW' ).
  ENDIF.

* gr_tabstrip has to be bound.
  IF gr_tabstrip IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'SET_ACTIVE_TAB_BY_NAME'
        i_mv3        = 'CL_ISH_GUI_TABSTRIP_VIEW' ).
  ENDIF.

* Set the activetab.
  IF i_tab_name <> gr_tabstrip->activetab.
    l_old_activetab = gr_tabstrip->activetab.
    gr_tabstrip->activetab = i_tab_name.
    RAISE EVENT ev_activetab_changed
      EXPORTING
        e_old_activetab = l_old_activetab
        e_new_activetab = i_tab_name.
  ENDIF.

* Export.
  rr_active_tab_view = get_active_tab_view( ).

* Set the focus.
  IF i_set_focus = abap_true AND
     rr_active_tab_view IS BOUND.
    IF rr_active_tab_view->set_focus( ) = abap_false.
      lt_child_view = rr_active_tab_view->get_child_views( ).
      LOOP AT lt_child_view ASSIGNING <ls_child_view>.
        CHECK <ls_child_view>-r_view IS BOUND.
        IF <ls_child_view>-r_view->set_focus( ) = abap_true.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_tabstrip_view~set_active_tab_by_view.

  DATA l_tab_name           TYPE n1gui_element_name.

  IF ir_view IS BOUND.
    l_tab_name = ir_view->get_element_name( ).
  ENDIF.

  set_active_tab_by_name(
      i_tab_name  = l_tab_name
      i_set_focus = i_set_focus ).

ENDMETHOD.


METHOD _add_child_view.

  DATA lr_sdy_view            TYPE REF TO if_ish_gui_sdy_view.

* The child view as to be a sdy_view.
  TRY.
      lr_sdy_view ?= ir_child_view.
    CATCH cx_sy_move_cast_error.
  ENDTRY.

* Further processing by the super method.
  super->_add_child_view( ir_child_view = ir_child_view ).

ENDMETHOD.


METHOD _destroy.

  super->_destroy( ).

  IF gr_tabstrip IS BOUND.
    CLEAR gr_tabstrip->activetab.
    CLEAR gr_tabstrip.
  ENDIF.

ENDMETHOD.


METHOD _init_tabstrip_view.

* The tabstrip reference has to be specified.
  IF ir_tabstrip IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_INIT_TABSTRIP_VIEW'
        i_mv3        = 'CL_ISH_GUI_TABSTRIP_VIEW' ).
  ENDIF.

* Further processing by _init_dynpro_view.
  _init_sdy_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      i_repid           = i_repid
      i_dynnr           = i_dynnr
      i_vcode           = i_vcode ).

* Initialize attributes.
  gr_tabstrip = ir_tabstrip.

ENDMETHOD.


METHOD _modify_screen.

* No processing because of the tabstrip buttons.

ENDMETHOD.


METHOD _process_command_request.

  DATA l_tabstrip         TYPE n1gui_element_name.
  DATA lx_root            TYPE REF TO cx_root.

* Process only on valid request.
  CHECK ir_command_request IS BOUND.

* If the fcode is a tabstrip we have to set the active tab.
  l_tabstrip = ir_command_request->get_fcode( ).
  IF get_child_view_by_name( i_view_name = l_tabstrip ) IS BOUND.
    TRY.
        set_active_tab_by_name(
            i_tab_name  = l_tabstrip
            i_set_focus = abap_true ).
      CATCH cx_ish_static_handler INTO lx_root.
        _propagate_exception( lx_root ).
    ENDTRY.
    rr_response = cl_ish_gui_response=>create(
        ir_request   = ir_command_request
        ir_processor = me ).
    RETURN.
  ENDIF.

* For all other fcodes call the super method.
  rr_response = super->_process_command_request( ir_command_request ).

ENDMETHOD.


METHOD __before_call_subscreen.

  DATA l_subscreen_name           TYPE n1gui_element_name.

* The subscreen is the one for the activetab.
  IF gr_tabstrip IS BOUND.
    l_subscreen_name = gr_tabstrip->activetab.
  ELSE.
    l_subscreen_name = i_subscreen_name.
  ENDIF.

* Now call the super method with the right subscreen name.
  CALL METHOD super->__before_call_subscreen
    EXPORTING
      i_repid           = i_repid
      i_dynnr           = i_dynnr
      i_subscreen_name  = l_subscreen_name
    IMPORTING
      e_subscreen_repid = e_subscreen_repid
      e_subscreen_dynnr = e_subscreen_dynnr.

ENDMETHOD.
ENDCLASS.
