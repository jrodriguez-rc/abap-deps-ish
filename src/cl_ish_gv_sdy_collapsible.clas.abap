class CL_ISH_GV_SDY_COLLAPSIBLE definition
  public
  inheriting from CL_ISH_GUI_SDY_VIEW
  create public .

public section.
*"* public components of class CL_ISH_GV_SDY_COLLAPSIBLE
*"* do not include other source files here!!!

  constants CO_DEF_CTRNAME_COLLAPSED type N1GUI_ELEMENT_NAME value 'COLLAPSED_CTR'. "#EC NOTEXT
  constants CO_DEF_VIEWNAME_COLLAPSED type N1GUI_ELEMENT_NAME value 'COLLAPSED_VIEW'. "#EC NOTEXT
  constants CO_DEF_CTRNAME_EXPANDED type N1GUI_ELEMENT_NAME value 'EXPANDED_CTR'. "#EC NOTEXT
  constants CO_DEF_VIEWNAME_EXPANDED type N1GUI_ELEMENT_NAME value 'EXPANDED_VIEW'. "#EC NOTEXT

  methods COLLAPSE .
  methods EXPAND .
  methods GET_COLLAPSED_CTR
    returning
      value(RR_CTR) type ref to IF_ISH_GUI_CONTROLLER .
  methods GET_EXPANDED_CTR
    returning
      value(RR_CTR) type ref to IF_ISH_GUI_CONTROLLER .
  methods SWITCH .
  methods GET_COLLAPSED_VIEW
    returning
      value(RR_VIEW) type ref to IF_ISH_GUI_SDY_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_EXPANDED_VIEW
    returning
      value(RR_VIEW) type ref to IF_ISH_GUI_SDY_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools CO .
  methods INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
      !I_CTRNAME_COLLAPSED type N1GUI_ELEMENT_NAME default CO_DEF_CTRNAME_COLLAPSED
      !I_VIEWNAME_COLLAPSED type N1GUI_ELEMENT_NAME default CO_DEF_VIEWNAME_COLLAPSED
      !I_CTRNAME_EXPANDED type N1GUI_ELEMENT_NAME default CO_DEF_CTRNAME_EXPANDED
      !I_VIEWNAME_EXPANDED type N1GUI_ELEMENT_NAME default CO_DEF_VIEWNAME_EXPANDED
      !I_INITIALLY_COLLAPSED type ISH_ON_OFF optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GV_SDY_COLLAPSIBLE
*"* do not include other source files here!!!

  constants CO_DYNNR_FROM type SYDYNNR value '0101'. "#EC NOTEXT
  constants CO_DYNNR_TO type SYDYNNR value '0199'. "#EC NOTEXT
  constants CO_REPID type SYREPID value 'SAPLN1_GUI_SDY_COLLAPSIBLE'. "#EC NOTEXT
  data G_CTRNAME_COLLAPSED type N1GUI_ELEMENT_NAME .
  data G_VIEWNAME_COLLAPSED type N1GUI_ELEMENT_NAME .
  data G_CTRNAME_EXPANDED type N1GUI_ELEMENT_NAME .
  data G_VIEWNAME_EXPANDED type N1GUI_ELEMENT_NAME .
  data G_COLLAPSED type ISH_ON_OFF .
  constants CO_PB_COLLAPSE_PREFIX type STRING value 'PB_COLLAPSIBLE_'. "#EC NOTEXT
  constants CO_SC_AREA_NAME type N1GUI_ELEMENT_NAME value 'SC_AREA'. "#EC NOTEXT

  methods _CONNECT_TO_DYNPRO
    redefinition .
  methods _PROCESS_COMMAND_REQUEST
    redefinition .
  methods _TRANSPORT_MODEL_TO_DYNPRO
    redefinition .
  methods __BEFORE_CALL_SUBSCREEN
    redefinition .
private section.
*"* private components of class CL_ISH_GV_SDY_COLLAPSIBLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GV_SDY_COLLAPSIBLE IMPLEMENTATION.


METHOD collapse.

  CHECK g_collapsed = space.

  switch( ).

ENDMETHOD.


METHOD expand.

  CHECK g_collapsed = 'X'.

  switch( ).

ENDMETHOD.


METHOD get_collapsed_ctr.

  CHECK gr_controller IS BOUND.

  rr_ctr = gr_controller->get_child_controller_by_name( g_ctrname_collapsed ).

ENDMETHOD.


METHOD get_collapsed_view.

  TRY.
      rr_view ?= get_child_view_by_name( g_viewname_collapsed ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'GET_COLLAPSED_VIEW'
          i_mv3        = 'CL_ISH_GUI_SDY_COLLAPSIBLE' ).
  ENDTRY.

ENDMETHOD.


METHOD get_expanded_ctr.

  CHECK gr_controller IS BOUND.

  rr_ctr = gr_controller->get_child_controller_by_name( g_ctrname_expanded ).

ENDMETHOD.


METHOD get_expanded_view.

  TRY.
      rr_view ?= get_child_view_by_name( g_viewname_expanded ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'GET_EXPANDED_VIEW'
          i_mv3        = 'CL_ISH_GUI_SDY_COLLAPSIBLE' ).
  ENDTRY.

ENDMETHOD.


METHOD initialize.

  DATA l_dynnr                          TYPE sydynnr.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GV_SDY_COLLAPSIBLE' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
*     Checkout the dynpro.
      l_dynnr = cl_ish_gui_dynpro_connector=>connect_free(
          ir_view      = me
          i_repid      = co_repid
          i_dynnr_from = co_dynnr_from
          i_dynnr_to   = co_dynnr_to ).
*     Call super method.
      _init_sdy_view( ir_controller     = ir_controller
                      i_repid           = co_repid
                      i_dynnr           = l_dynnr
                      i_vcode           = i_vcode
                      i_dynpstruct_name = 'RN1_DYNP_GUI_COLLAPSIBLE_PB' ).

      g_ctrname_collapsed  = i_ctrname_collapsed.
      g_viewname_collapsed = i_viewname_collapsed.
      g_ctrname_expanded  = i_ctrname_expanded.
      g_viewname_expanded = i_viewname_expanded.
      g_collapsed = i_initially_collapsed.
    CLEANUP.
      g_initialization_mode = abap_false.
      IF l_dynnr IS NOT INITIAL.
        cl_ish_gui_dynpro_connector=>disconnect(
            ir_view        = me
            i_repid        = co_repid
            i_dynnr        = l_dynnr ).
      ENDIF.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD switch.

  IF g_collapsed = 'X'.
    g_collapsed = space.
  ELSE.
    g_collapsed = 'X'.
  ENDIF.

ENDMETHOD.


METHOD _connect_to_dynpro.

* Connecting to dynpro is done in initialize.

ENDMETHOD.


METHOD _process_command_request.

  DATA: l_fcode     TYPE ui_func,
        l_own_fcode TYPE ui_func,
        l_dynnr     TYPE sy-dynnr.

  CHECK ir_command_request IS BOUND.

  l_dynnr = get_dynnr( ).
  CONCATENATE co_pb_collapse_prefix l_dynnr INTO l_own_fcode.

  l_fcode = ir_command_request->get_fcode( ).
  IF l_fcode = l_own_fcode.
    switch( ).
  ELSE.
    rr_response = super->_process_command_request( ir_command_request ).
  ENDIF.

ENDMETHOD.


METHOD _transport_model_to_dynpro.

  DATA:
    lr_model                    TYPE REF TO if_ish_gui_structure_model,
    l_fieldname                 TYPE ish_fieldname,
    lx_root                     TYPE REF TO cx_root.

  FIELD-SYMBOLS:
    <ls_dynpstruct>             TYPE data,
    <ls_component>              TYPE abap_compdescr,
    <l_field>                   TYPE ANY.

  CALL METHOD super->_transport_model_to_dynpro
    EXPORTING
      i_repid       = i_repid
      i_dynnr       = i_dynnr
    CHANGING
      cs_dynpstruct = cs_dynpstruct.

  ASSIGN cs_dynpstruct TO <ls_dynpstruct>.

  CONCATENATE 'PB_' i_dynnr INTO l_fieldname.

* Assign the dynpro structure field.
  ASSIGN COMPONENT l_fieldname
    OF STRUCTURE <ls_dynpstruct>
    TO <l_field>.
  CHECK sy-subrc = 0.

  IF g_collapsed = 'X'.
    <l_field> = icon_data_area_expand.
  ELSE.
    <l_field> = icon_data_area_collapse.
  ENDIF.

* Set cs_dynpstruct.
  cs_dynpstruct = <ls_dynpstruct>.

ENDMETHOD.


METHOD __before_call_subscreen.

  DATA: lr_view           TYPE REF TO if_ish_gui_view,
        lr_dynpro_view    TYPE REF TO if_ish_gui_dynpro_view.

  IF i_subscreen_name = co_sc_area_name.
    e_subscreen_repid = 'SAPLN1SC'.
    e_subscreen_dynnr = '0001'.
    IF g_collapsed = 'X'.
      lr_view = get_child_view_by_name( g_viewname_collapsed ).
    ELSE.
      lr_view = get_child_view_by_name( g_viewname_expanded ).
    ENDIF.
    CHECK lr_view IS BOUND.
    lr_dynpro_view ?= lr_view.
    e_subscreen_repid = lr_dynpro_view->get_repid( ).
    e_subscreen_dynnr = lr_dynpro_view->get_dynnr( ).
  ELSE.
    CALL METHOD super->__before_call_subscreen
      EXPORTING
        i_repid           = i_repid
        i_dynnr           = i_dynnr
        i_subscreen_name  = i_subscreen_name
      IMPORTING
        e_subscreen_repid = e_subscreen_repid
        e_subscreen_dynnr = e_subscreen_dynnr.
  ENDIF.

ENDMETHOD.
ENDCLASS.
