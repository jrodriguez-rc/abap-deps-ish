class CL_ISH_GUI_XTABSTRIP_VIEW definition
  public
  inheriting from CL_ISH_GUI_TABSTRIP_VIEW
  create public .

public section.
*"* public components of class CL_ISH_GUI_XTABSTRIP_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_XTABSTRIP_VIEW .

  aliases GET_IDX_BY_TAB_NAME
    for IF_ISH_GUI_XTABSTRIP_VIEW~GET_IDX_BY_TAB_NAME .
  aliases GET_IDX_BY_VIEW
    for IF_ISH_GUI_XTABSTRIP_VIEW~GET_IDX_BY_VIEW .
  aliases GET_IDX_BY_VIEW_NAME
    for IF_ISH_GUI_XTABSTRIP_VIEW~GET_IDX_BY_VIEW_NAME .
  aliases GET_TAB_LABEL
    for IF_ISH_GUI_XTABSTRIP_VIEW~GET_TAB_LABEL .
  aliases GET_TAB_NAME
    for IF_ISH_GUI_XTABSTRIP_VIEW~GET_TAB_NAME .
  aliases GET_TAB_VIEW
    for IF_ISH_GUI_XTABSTRIP_VIEW~GET_TAB_VIEW .
  aliases SET_TAB_LABEL
    for IF_ISH_GUI_XTABSTRIP_VIEW~SET_TAB_LABEL .
  aliases SET_TAB_VIEW
    for IF_ISH_GUI_XTABSTRIP_VIEW~SET_TAB_VIEW .

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    preferred parameter I_ELEMENT_NAME .
  methods GET_T_TABSTRIP_VIEW
    returning
      value(RT_TABSTRIP_VIEW) type ISH_T_GUI_SDY_VIEWS .
  type-pools CO .
  methods INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .

  methods IF_ISH_GUI_TABSTRIP_VIEW~GET_ACTIVE_TAB_VIEW
    redefinition .
  methods IF_ISH_GUI_TABSTRIP_VIEW~SET_ACTIVE_TAB_BY_NAME
    redefinition .
  methods IF_ISH_GUI_TABSTRIP_VIEW~SET_ACTIVE_TAB_BY_VIEW
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_XTABSTRIP_VIEW
*"* do not include other source files here!!!

  data GT_XTABDEF type ISH_T_GUI_XTABDEF .

  methods ON_TAB_VIEW_DESTROYED
    for event EV_AFTER_DESTROY of IF_ISH_DESTROYABLE
    importing
      !SENDER .
  methods _ADJUST_ACTIVETAB .
  methods _GET_XTABDEF_BY_IDX
    importing
      !I_IDX type I
    returning
      value(RS_XTABDEF) type ref to RN1GUI_XTABDEF .
  methods _GET_XTABDEF_BY_TAB_NAME
    importing
      !I_TAB_NAME type N1GUI_ELEMENT_NAME
    returning
      value(RS_XTABDEF) type ref to RN1GUI_XTABDEF .
  methods _GET_XTABDEF_BY_VIEW
    importing
      !IR_VIEW type ref to IF_ISH_GUI_SDY_VIEW
    returning
      value(RS_XTABDEF) type ref to RN1GUI_XTABDEF .
  methods _GET_XTABDEF_LABEL
    importing
      !IR_XTABDEF type ref to RN1GUI_XTABDEF
    returning
      value(R_LABEL) type N1GUI_XTAB_LABEL .
  methods _INIT_XTABSTRIP_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods _SET_ACTIVE_TAB
    importing
      !IR_S_XTABDEF type ref to RN1GUI_XTABDEF
      !I_SET_FOCUS type ABAP_BOOL default ABAP_TRUE
    returning
      value(RR_ACTIVE_TAB_VIEW) type ref to IF_ISH_GUI_SDY_VIEW
    raising
      CX_ISH_STATIC_HANDLER .

  methods _CONNECT_TO_DYNPRO
    redefinition .
  methods _DESTROY
    redefinition .
  methods _MODIFY_SCREEN
    redefinition .
  methods _PROCESS_COMMAND_REQUEST
    redefinition .
  methods __BEFORE_CALL_SUBSCREEN
    redefinition .
  methods __PBO
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_XTABSTRIP_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_XTABSTRIP_VIEW IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

ENDMETHOD.


METHOD get_t_tabstrip_view.

  FIELD-SYMBOLS <ls_xtabdef>  TYPE rn1gui_xtabdef.

  LOOP AT gt_xtabdef ASSIGNING <ls_xtabdef>.
    CHECK <ls_xtabdef>-r_view IS BOUND.
    INSERT <ls_xtabdef>-r_view INTO TABLE rt_tabstrip_view.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_tabstrip_view~get_active_tab_view.

  DATA lr_s_xtabdef           TYPE REF TO rn1gui_xtabdef.

  CHECK gr_tabstrip IS BOUND.

  lr_s_xtabdef = _get_xtabdef_by_tab_name( gr_tabstrip->activetab ).
  CHECK lr_s_xtabdef IS BOUND.

  rr_active_tab_view = lr_s_xtabdef->r_view.

ENDMETHOD.


METHOD if_ish_gui_tabstrip_view~set_active_tab_by_name.

  DATA lr_s_xtabdef               TYPE REF TO rn1gui_xtabdef.

* Get the xtabdef for the given view.
  lr_s_xtabdef = _get_xtabdef_by_tab_name( i_tab_name ).

* Set the activetab.
  rr_active_tab_view = _set_active_tab(
      ir_s_xtabdef = lr_s_xtabdef
      i_set_focus  = i_set_focus ).

ENDMETHOD.


METHOD if_ish_gui_tabstrip_view~set_active_tab_by_view.

  DATA lr_s_xtabdef               TYPE REF TO rn1gui_xtabdef.

* Get the xtabdef for the given view.
  lr_s_xtabdef = _get_xtabdef_by_view( ir_view ).

* Set the activetab.
  _set_active_tab(
      ir_s_xtabdef = lr_s_xtabdef
      i_set_focus  = i_set_focus ).

ENDMETHOD.


METHOD if_ish_gui_xtabstrip_view~get_idx_by_tab_name.

  CHECK i_tab_name IS NOT INITIAL.

  READ TABLE gt_xtabdef
    WITH TABLE KEY tab_name = i_tab_name
    TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_idx = sy-tabix.

ENDMETHOD.


METHOD if_ish_gui_xtabstrip_view~get_idx_by_view.

  CHECK ir_view IS BOUND.

  READ TABLE gt_xtabdef
    WITH KEY r_view = ir_view
    TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_idx = sy-tabix.

ENDMETHOD.


METHOD if_ish_gui_xtabstrip_view~get_idx_by_view_name.

  DATA lr_view            TYPE REF TO if_ish_gui_sdy_view.

  CHECK i_view_name IS NOT INITIAL.

  TRY.
      lr_view ?= get_child_view_by_name( i_view_name ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  r_idx = get_idx_by_view( lr_view ).

ENDMETHOD.


METHOD if_ish_gui_xtabstrip_view~get_tab_label.

  DATA lr_s_xtabdef                     TYPE REF TO rn1gui_xtabdef.

  lr_s_xtabdef = _get_xtabdef_by_idx( i_idx ).
  IF lr_s_xtabdef IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_TAB_LABEL'
        i_mv3        = 'CL_ISH_GUI_XTABSTRIP_VIEW' ).
  ENDIF.

  r_label = _get_xtabdef_label( lr_s_xtabdef ).

ENDMETHOD.


METHOD if_ish_gui_xtabstrip_view~get_tab_name.

  DATA lr_s_xtabdef                     TYPE REF TO rn1gui_xtabdef.

  lr_s_xtabdef = _get_xtabdef_by_idx( i_idx ).
  IF lr_s_xtabdef IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_TAB_NAME'
        i_mv3        = 'CL_ISH_GUI_XTABSTRIP_VIEW' ).
  ENDIF.

  r_tab_name = lr_s_xtabdef->tab_name.

ENDMETHOD.


METHOD if_ish_gui_xtabstrip_view~get_tab_view.

  DATA lr_s_xtabdef                     TYPE REF TO rn1gui_xtabdef.

  lr_s_xtabdef = _get_xtabdef_by_idx( i_idx ).
  IF lr_s_xtabdef IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_TAB_VIEW'
        i_mv3        = 'CL_ISH_GUI_XTABSTRIP_VIEW' ).
  ENDIF.

  rr_view = lr_s_xtabdef->r_view.

ENDMETHOD.


METHOD if_ish_gui_xtabstrip_view~set_tab_label.

  DATA lr_s_xtabdef                     TYPE REF TO rn1gui_xtabdef.

  FIELD-SYMBOLS <l_label>               TYPE data.

  lr_s_xtabdef = _get_xtabdef_by_idx( i_idx ).
  IF lr_s_xtabdef IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_TAB_LABEL'
        i_mv3        = 'CL_ISH_GUI_XTABSTRIP_VIEW' ).
  ENDIF.

  IF lr_s_xtabdef->r_tab IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'SET_TAB_LABEL'
        i_mv3        = 'CL_ISH_GUI_XTABSTRIP_VIEW' ).
  ENDIF.

  ASSIGN lr_s_xtabdef->r_tab->* TO <l_label>.

  <l_label> = i_label.

ENDMETHOD.


METHOD if_ish_gui_xtabstrip_view~set_tab_view.

  DATA lr_s_xtabdef                     TYPE REF TO rn1gui_xtabdef.
  DATA l_view_name                      TYPE n1gui_element_name.

  lr_s_xtabdef = _get_xtabdef_by_idx( i_idx ).
  IF lr_s_xtabdef IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_TAB_VIEW'
        i_mv3        = 'CL_ISH_GUI_XTABSTRIP_VIEW' ).
  ENDIF.

  IF ir_view IS BOUND.
    l_view_name = ir_view->get_element_name( ).
    IF get_child_view_by_name( l_view_name ) <> ir_view.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = 'SET_TAB_VIEW'
          i_mv3        = 'CL_ISH_GUI_XTABSTRIP_VIEW' ).
    ENDIF.
  ENDIF.

  lr_s_xtabdef->r_view = ir_view.

  IF ir_view IS BOUND.
    SET HANDLER on_tab_view_destroyed FOR ir_view ACTIVATION abap_true.
  ENDIF.

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
        i_mv3        = 'CL_ISH_GUI_XTABSTRIP_VIEW' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
*     Init the xtabstrip view.
      _init_xtabstrip_view(
          ir_controller     = ir_controller
          ir_parent_view    = ir_parent_view
          i_vcode           = i_vcode ).
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD on_tab_view_destroyed.

  DATA lr_view            TYPE REF TO if_ish_gui_sdy_view.
  DATA lr_s_xtabdef       TYPE REF TO rn1gui_xtabdef.

  CHECK sender IS BOUND.

  TRY.
      lr_view ?= sender.
    CATCH cx_sy_move_cast_error.
  ENDTRY.

  lr_s_xtabdef = _get_xtabdef_by_view( lr_view ).
  CHECK lr_s_xtabdef IS BOUND.

  CLEAR lr_s_xtabdef->r_view.

  SET HANDLER on_tab_view_destroyed FOR lr_view ACTIVATION abap_false.

ENDMETHOD.


METHOD _adjust_activetab.

  DATA l_old_activetab        TYPE n1gui_element_name.
  DATA l_idx_start            TYPE i.
  DATA l_lines_xtabdef        TYPE i.
  DATA l_idx_next             TYPE i.
  DATA lt_idx                 TYPE TABLE OF i.
  DATA lr_s_xtabdef           TYPE REF TO rn1gui_xtabdef.

  FIELD-SYMBOLS <l_idx>       TYPE i.

  CHECK gr_tabstrip IS BOUND.

* Remember the actual (=old) activetab.
  l_old_activetab = gr_tabstrip->activetab.

* Determine the start index for processing.
  IF gr_tabstrip->activetab IS INITIAL.
    l_idx_start = 1.
  ELSE.
    l_idx_start = get_idx_by_tab_name( gr_tabstrip->activetab ).
  ENDIF.
  CHECK l_idx_start > 0.

* Build a table with all indices in right order.
  l_lines_xtabdef = LINES( gt_xtabdef ).
  l_idx_next = l_idx_start.
  WHILE l_idx_next <= l_lines_xtabdef.
    INSERT l_idx_next INTO TABLE lt_idx.
    l_idx_next = l_idx_next + 1.
  ENDWHILE.
  l_idx_next = 1.
  WHILE l_idx_next < l_idx_start.
    INSERT l_idx_next INTO TABLE lt_idx.
    l_idx_next = l_idx_next + 1.
  ENDWHILE.

* Process the tabs.
  LOOP AT lt_idx ASSIGNING <l_idx>.
*   Get the corresponding xtabdef.
    lr_s_xtabdef = _get_xtabdef_by_idx( <l_idx> ).
    IF lr_s_xtabdef IS NOT BOUND.
      EXIT.
    ENDIF.
*   Check tab validity.
    CHECK lr_s_xtabdef->r_view IS BOUND.
    CHECK _get_xtabdef_label( lr_s_xtabdef ) IS NOT INITIAL.
*   Set the activetab.
    IF l_old_activetab <> lr_s_xtabdef->tab_name.
      gr_tabstrip->activetab = lr_s_xtabdef->tab_name.
      RAISE EVENT ev_activetab_changed
        EXPORTING
          e_old_activetab = l_old_activetab
          e_new_activetab = gr_tabstrip->activetab.
    ENDIF.
*   We are ready.
    RETURN.
  ENDLOOP.

* We did not find any valid tab. So clear the activetab.
  CLEAR gr_tabstrip->activetab.
  IF l_old_activetab <> gr_tabstrip->activetab.
    RAISE EVENT ev_activetab_changed
      EXPORTING
        e_old_activetab = l_old_activetab
        e_new_activetab = gr_tabstrip->activetab.
  ENDIF.

*  DATA lr_s_xtabdef           TYPE REF TO rn1gui_xtabdef.
*  DATA l_valid                TYPE abap_bool.
*  DATA l_idx_start            TYPE i.
*  DATA l_idx_next             TYPE i.
*  DATA l_old_activetab        TYPE n1gui_element_name.
*
*  CHECK gr_tabstrip IS BOUND.
*
*  l_old_activetab = gr_tabstrip->activetab.
*
** On no actual activetab start with the first xtabdef.
*  IF gr_tabstrip->activetab IS INITIAL.
*    lr_s_xtabdef = _get_xtabdef_by_idx( 1 ).
*    CHECK lr_s_xtabdef IS BOUND.
*    CHECK lr_s_xtabdef->r_tab IS BOUND.
*    gr_tabstrip->activetab = lr_s_xtabdef->tab_name.
*    _adjust_activetab( ).
*    IF gr_tabstrip->activetab IS NOT INITIAL.
*      RAISE EVENT ev_activetab_changed
*        EXPORTING
*          e_old_activetab = l_old_activetab
*          e_new_activetab = gr_tabstrip->activetab.
*    ENDIF.
*    RETURN.
*  ENDIF.
*
** Get the xtabdef for the actual activetab.
*  lr_s_xtabdef = _get_xtabdef_by_tab_name( gr_tabstrip->activetab ).
*  IF lr_s_xtabdef IS NOT BOUND OR
*     lr_s_xtabdef->r_tab IS NOT BOUND.
*    CLEAR gr_tabstrip->activetab.
*    RAISE EVENT ev_activetab_changed
*      EXPORTING
*        e_old_activetab = l_old_activetab
*        e_new_activetab = gr_tabstrip->activetab.
*    RETURN.
*  ENDIF.
*
** Determine if the actual activetab is valid.
*  l_valid = abap_false.
*  DO 1 TIMES.
*    CHECK lr_s_xtabdef->r_view IS BOUND.
*    CHECK _get_xtabdef_label( lr_s_xtabdef ) IS NOT INITIAL.
*    l_valid = abap_true.
*  ENDDO.
*
** Adjusting only on invalid activetab.
*  CHECK l_valid = abap_false.
*
** Clear the activetab.
*  CLEAR gr_tabstrip->activetab.
*
** Determine the start index for processing.
*  l_idx_start = get_idx_by_tab_name( lr_s_xtabdef->tab_name ).
*  IF l_idx_start <= 0.
*    RAISE EVENT ev_activetab_changed
*      EXPORTING
*        e_old_activetab = l_old_activetab
*        e_new_activetab = gr_tabstrip->activetab.
*    RETURN.
*  ENDIF.
*
** Process the following tabs.
*  l_idx_next  = l_idx_start + 1.
*  WHILE l_idx_start <= l_idx_next AND gr_tabstrip->activetab IS INITIAL.
*    lr_s_xtabdef = _get_xtabdef_by_idx( l_idx_next ).
*    IF lr_s_xtabdef IS NOT BOUND OR
*       lr_s_xtabdef->r_tab IS NOT BOUND.
*      EXIT.
*    ENDIF.
*    gr_tabstrip->activetab = lr_s_xtabdef->tab_name.
*    _adjust_activetab( ).
*    l_idx_next = l_idx_next + 1.
*  ENDWHILE.
*
** Further processing only on no valid following tab.
*  IF gr_tabstrip->activetab IS NOT INITIAL.
*    RAISE EVENT ev_activetab_changed
*      EXPORTING
*        e_old_activetab = l_old_activetab
*        e_new_activetab = gr_tabstrip->activetab.
*    RETURN.
*  ENDIF.
*
** Process the tabs from 1 to actual tab.
*  l_idx_next = 1.
*  WHILE l_idx_start >= l_idx_next AND gr_tabstrip->activetab IS INITIAL.
*    lr_s_xtabdef = _get_xtabdef_by_idx( l_idx_next ).
*    IF lr_s_xtabdef IS NOT BOUND OR
*       lr_s_xtabdef->r_tab IS NOT BOUND.
*      EXIT.
*    ENDIF.
*    gr_tabstrip->activetab = lr_s_xtabdef->tab_name.
*    _adjust_activetab( ).
*    l_idx_next = l_idx_next + 1.
*  ENDWHILE.
*
*  RAISE EVENT ev_activetab_changed
*    EXPORTING
*      e_old_activetab = l_old_activetab
*      e_new_activetab = gr_tabstrip->activetab.

ENDMETHOD.


METHOD _connect_to_dynpro.

* The xtabstrip view connects self with the dynpro in method initialize.

ENDMETHOD.


METHOD _destroy.

  FIELD-SYMBOLS <ls_xtabdef>            TYPE rn1gui_xtabdef.

  LOOP AT gt_xtabdef ASSIGNING <ls_xtabdef>.
    CHECK <ls_xtabdef>-r_view IS BOUND.
    SET HANDLER on_tab_view_destroyed FOR <ls_xtabdef>-r_view ACTIVATION abap_false.
  ENDLOOP.

  CLEAR gt_xtabdef.

  super->_destroy( ).

ENDMETHOD.


METHOD _get_xtabdef_by_idx.

  CHECK i_idx > 0.

  READ TABLE gt_xtabdef
    INDEX i_idx
    REFERENCE INTO rs_xtabdef.

ENDMETHOD.


METHOD _get_xtabdef_by_tab_name.

  READ TABLE gt_xtabdef
    WITH TABLE KEY tab_name = i_tab_name
    REFERENCE INTO rs_xtabdef.

ENDMETHOD.


METHOD _get_xtabdef_by_view.

  CHECK ir_view IS BOUND.

  READ TABLE gt_xtabdef
    WITH KEY r_view = ir_view
    REFERENCE INTO rs_xtabdef.

ENDMETHOD.


METHOD _get_xtabdef_label.

  FIELD-SYMBOLS <l_label>           TYPE data.

  CHECK ir_xtabdef IS BOUND.
  CHECK ir_xtabdef->r_tab IS BOUND.

  ASSIGN ir_xtabdef->r_tab->* TO <l_label>.

  r_label = <l_label>.

ENDMETHOD.


METHOD _init_xtabstrip_view.

  DATA l_dynnr              TYPE sydynnr.
  DATA lr_tmp_data          TYPE REF TO data.
  DATA lr_tabstrip          TYPE REF TO scxtab_tabstrip.
  DATA lt_tabref            TYPE ish_t_dataref.
  DATA ls_xtabdef           TYPE rn1gui_xtabdef.
  DATA l_fix_tab_name       TYPE string.
  DATA l_idx                TYPE i.
  DATA l_idx_string         TYPE string.

* On any errors we have to disconnect from the dynpro.
  TRY.

*     Connect self with the next free dynpro.
      l_dynnr = cl_ish_gui_dynpro_connector=>connect_free(
          ir_view      = me
          i_repid      = 'SAPLN1_GUI_SDY_XTABSTRIP'
          i_dynnr_from = '0101'
          i_dynnr_to   = '0199' ).

*     Get the tabstrip reference and the tab references.
      CALL FUNCTION 'ISH_GUI_SDY_XTABSTRIP'
        EXPORTING
          i_dynnr     = l_dynnr
        IMPORTING
          er_tabstrip = lr_tmp_data
          et_tabref   = lt_tabref.
      lr_tabstrip ?= lr_tmp_data.

*     Build gt_xtabdef.
      CONCATENATE
        'TS'
        l_dynnr
        'TAB'
        INTO l_fix_tab_name
        SEPARATED BY '_'.
      l_idx = 0.
      CLEAR ls_xtabdef.
      LOOP AT lt_tabref INTO ls_xtabdef-r_tab.
        l_idx = l_idx + 1.
        l_idx_string = l_idx.
        CONCATENATE
          l_fix_tab_name
          l_idx_string
          INTO ls_xtabdef-tab_name.
        INSERT ls_xtabdef INTO TABLE gt_xtabdef.
      ENDLOOP.

*     Init the tabstrip view.
      _init_tabstrip_view(
          ir_controller     = ir_controller
          ir_parent_view    = ir_parent_view
          i_repid           = 'SAPLN1_GUI_SDY_XTABSTRIP'
          i_dynnr           = l_dynnr
          i_vcode           = i_vcode
          ir_tabstrip       = lr_tabstrip ).

    CLEANUP.

      cl_ish_gui_dynpro_connector=>disconnect(
          ir_view        = me
          i_repid        = 'SAPLN1_GUI_SDY_XTABSTRIP'
          i_dynnr        = l_dynnr ).

  ENDTRY.

ENDMETHOD.


METHOD _modify_screen.

  DATA lr_s_xtabdef             TYPE REF TO rn1gui_xtabdef.

* First call the super method.
  super->_modify_screen(
      i_repid = i_repid
      i_dynnr = i_dynnr ).

* Handle tabs.
  LOOP AT SCREEN.
    lr_s_xtabdef = _get_xtabdef_by_tab_name( screen-name ).
    CHECK lr_s_xtabdef IS BOUND.
    IF lr_s_xtabdef->r_view IS NOT BOUND OR
       _get_xtabdef_label( lr_s_xtabdef ) IS INITIAL.
      screen-active = 0.
    ELSE.
      CONTINUE.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.

ENDMETHOD.


METHOD _process_command_request.

  DATA l_tabstrip         TYPE n1gui_element_name.
  DATA lr_s_xtabdef       TYPE REF TO rn1gui_xtabdef.
  DATA lx_root            TYPE REF TO cx_root.

* Process only on valid request.
  CHECK ir_command_request IS BOUND.

* If the fcode is a tabstrip we have to set the active tab.
  l_tabstrip = ir_command_request->get_fcode( ).
  lr_s_xtabdef = _get_xtabdef_by_tab_name( l_tabstrip ).
  IF lr_s_xtabdef IS BOUND.
    CHECK lr_s_xtabdef->r_view IS BOUND.
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


METHOD _set_active_tab.

  DATA l_old_activetab            TYPE n1gui_element_name.
  DATA l_label                    TYPE n1gui_xtab_label.
  DATA lt_child_view              TYPE ish_t_gui_viewid_hash.

  FIELD-SYMBOLS <ls_child_view>   TYPE rn1_gui_viewid_hash.

* The xtabdef has to be specified.
  IF ir_s_xtabdef IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_SET_ACTIVE_TAB'
        i_mv3        = 'CL_ISH_GUI_XTABSTRIP_VIEW' ).
  ENDIF.

* gr_tabstrip has to be bound.
  IF gr_tabstrip IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_SET_ACTIVE_TAB'
        i_mv3        = 'CL_ISH_GUI_XTABSTRIP_VIEW' ).
  ENDIF.

* Check.
  IF _get_xtabdef_label( ir_s_xtabdef ) IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = 'SET_ACTIVE_TAB_BY_VIEW'
        i_mv3        = 'CL_ISH_GUI_XTABSTRIP_VIEW' ).
  ENDIF.
  IF ir_s_xtabdef->r_view IS NOT BOUND.
    l_label = _get_xtabdef_label( ir_s_xtabdef ).
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '141'
        i_mv1        =  l_label ).
  ENDIF.

* Set the active tab.
  IF ir_s_xtabdef->tab_name <> gr_tabstrip->activetab.
    l_old_activetab = gr_tabstrip->activetab.
    gr_tabstrip->activetab = ir_s_xtabdef->tab_name.
    RAISE EVENT ev_activetab_changed
      EXPORTING
        e_old_activetab = l_old_activetab
        e_new_activetab = gr_tabstrip->activetab.
  ENDIF.

* Export.
  rr_active_tab_view = ir_s_xtabdef->r_view.

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


METHOD __before_call_subscreen.

  DATA l_subscreen_name           TYPE n1gui_element_name.
  DATA lr_tmp_tabstrip            LIKE gr_tabstrip.

  FIELD-SYMBOLS <ls_xtabdef>      LIKE LINE OF gt_xtabdef.

* The subscreen is the one for the activetab.
  IF gr_tabstrip IS BOUND.
    l_subscreen_name = gr_tabstrip->activetab.
    IF l_subscreen_name IS NOT INITIAL.
      READ TABLE gt_xtabdef
        WITH TABLE KEY tab_name = l_subscreen_name
        ASSIGNING <ls_xtabdef>.
      IF sy-subrc = 0 AND
         <ls_xtabdef>-r_view IS BOUND.
        l_subscreen_name = <ls_xtabdef>-r_view->get_element_name( ).
      ENDIF.
    ENDIF.
  ELSE.
    l_subscreen_name = i_subscreen_name.
  ENDIF.

* Now call the super method with the right subscreen name.
  lr_tmp_tabstrip = gr_tabstrip.
  CLEAR gr_tabstrip.
  TRY.
      CALL METHOD super->__before_call_subscreen
        EXPORTING
          i_repid           = i_repid
          i_dynnr           = i_dynnr
          i_subscreen_name  = l_subscreen_name
        IMPORTING
          e_subscreen_repid = e_subscreen_repid
          e_subscreen_dynnr = e_subscreen_dynnr.
    CLEANUP.
      gr_tabstrip = lr_tmp_tabstrip.
  ENDTRY.
  gr_tabstrip = lr_tmp_tabstrip.

ENDMETHOD.


METHOD __pbo.

* Call the super method.
  CALL METHOD super->__pbo
    EXPORTING
      i_repid       = i_repid
      i_dynnr       = i_dynnr
    CHANGING
      cs_dynpstruct = cs_dynpstruct.

* Adjust the activetab.
  _adjust_activetab( ).

ENDMETHOD.
ENDCLASS.
