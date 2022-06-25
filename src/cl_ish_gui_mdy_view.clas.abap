class CL_ISH_GUI_MDY_VIEW definition
  public
  inheriting from CL_ISH_GUI_DYNPRO_VIEW
  abstract
  create public

  global friends CL_ISH_GUI_DYNPRO_CONNECTOR .

public section.
*"* public components of class CL_ISH_GUI_MDY_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_MDY_VIEW .

  aliases CO_DEF_MAIN_VIEW_NAME
    for IF_ISH_GUI_MDY_VIEW~CO_DEF_MAIN_VIEW_NAME .
  aliases GET_MAIN_CONTROLLER
    for IF_ISH_GUI_MDY_VIEW~GET_MAIN_CONTROLLER .
  aliases GET_PFSTATUS
    for IF_ISH_GUI_MDY_VIEW~GET_PFSTATUS .
  aliases GET_TITLEBAR
    for IF_ISH_GUI_MDY_VIEW~GET_TITLEBAR .
  aliases GET_T_PFSTATUS
    for IF_ISH_GUI_MDY_VIEW~GET_T_PFSTATUS .
  aliases GET_T_TITLEBAR
    for IF_ISH_GUI_MDY_VIEW~GET_T_TITLEBAR .
  aliases EV_EXIT
    for IF_ISH_GUI_MDY_VIEW~EV_EXIT .
protected section.
*"* protected components of class CL_ISH_GUI_MDY_VIEW
*"* do not include other source files here!!!

  data GR_PFSTATUS type ref to CL_ISH_GUI_MDY_PFSTATUS .
  data GR_TITLEBAR type ref to CL_ISH_GUI_MDY_TITLEBAR .
  data GT_PFSTATUS type ISH_T_GUI_MDYPFSTATNAME_HASH .
  data GT_TITLEBAR type ISH_T_GUI_MDYTITLENAME_HASH .

  methods _ADJUST_PFSTATUS_TO_VCODE
    importing
      !I_OLD_VCODE type TNDYM-VCODE optional
      !I_NEW_VCODE type TNDYM-VCODE optional .
  methods _ADJUST_TITLEBAR_TO_VCODE
    importing
      !I_OLD_VCODE type TNDYM-VCODE optional
      !I_NEW_VCODE type TNDYM-VCODE optional .
  methods _INIT_MDY_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_MAIN_CONTROLLER
      !IR_LAYOUT type ref to CL_ISH_GUI_DYNPRO_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !I_REPID type SYREPID
      !I_DYNNR type SYDYNNR
      !I_DYNNR_TO type SYDYNNR optional
      !IR_TITLEBAR type ref to CL_ISH_GUI_MDY_TITLEBAR optional
      !IT_TITLEBAR type ISH_T_GUI_MDYTITLENAME_HASH optional
      !IR_PFSTATUS type ref to CL_ISH_GUI_MDY_PFSTATUS optional
      !IT_PFSTATUS type ISH_T_GUI_MDYPFSTATNAME_HASH optional
      !I_DYNPSTRUCT_NAME type TABNAME optional
      !IT_DYNPLAY_VCODE type ISH_T_GUI_DYNPLAY_VCODE_H optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SET_PFSTATUS
    importing
      !IR_PFSTATUS type ref to CL_ISH_GUI_MDY_PFSTATUS optional .
  methods _SET_TITLEBAR
    importing
      !IR_TITLEBAR type ref to CL_ISH_GUI_MDY_TITLEBAR optional .
  type-pools ABAP .
  methods __EXIT_COMMAND
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
      !I_UCOMM type SY-UCOMM
    returning
      value(R_EXIT) type ABAP_BOOL .
  methods __USER_COMMAND
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
      !I_UCOMM type SY-UCOMM
    returning
      value(R_EXIT) type ABAP_BOOL .

  methods _SET_VCODE
    redefinition .
  methods __BEFORE_PBO
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_MDY_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_MDY_VIEW IMPLEMENTATION.


METHOD if_ish_gui_mdy_view~get_main_controller.

  TRY.
      rr_main_controller ?= get_controller( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_mdy_view~get_pfstatus.

  rr_pfstatus = gr_pfstatus.

ENDMETHOD.


METHOD if_ish_gui_mdy_view~get_titlebar.

  rr_titlebar = gr_titlebar.

ENDMETHOD.


METHOD if_ish_gui_mdy_view~get_t_pfstatus.

  rt_pfstatus = gt_pfstatus.

ENDMETHOD.


METHOD if_ish_gui_mdy_view~get_t_titlebar.

  rt_titlebar = gt_titlebar.

ENDMETHOD.


METHOD _adjust_pfstatus_to_vcode.

  FIELD-SYMBOLS:
    <ls_pfstatus>  LIKE LINE OF gt_pfstatus.

* Determine the available pfstatus for the new vcode.
  READ TABLE gt_pfstatus
    WITH TABLE KEY element_name = i_new_vcode
    ASSIGNING <ls_pfstatus>.
  CHECK sy-subrc = 0.

* Set the actual pfstatus.
  gr_pfstatus = <ls_pfstatus>-r_pfstatus.

ENDMETHOD.


METHOD _adjust_titlebar_to_vcode.

  FIELD-SYMBOLS:
    <ls_titlebar>  LIKE LINE OF gt_titlebar.

* Determine the available titlebar for the new vcode.
  READ TABLE gt_titlebar
    WITH TABLE KEY element_name = i_new_vcode
    ASSIGNING <ls_titlebar>.
  CHECK sy-subrc = 0.

* Set the actual titlebar.
  gr_titlebar = <ls_titlebar>-r_titlebar.

ENDMETHOD.


METHOD _init_mdy_view.

  DATA:
    lr_dummy_view        TYPE REF TO if_ish_gui_dynpro_view.

* Further initialization by _init_dynpro_view.
  _init_dynpro_view(
      ir_controller     = ir_controller
      ir_parent_view    = lr_dummy_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode
      i_repid           = i_repid
      i_dynnr           = i_dynnr
      i_dynnr_to        = i_dynnr_to
      i_dynpstruct_name = i_dynpstruct_name
      it_dynplay_vcode  = it_dynplay_vcode ).

* Initialize attributes.
  gr_titlebar = ir_titlebar.
  gt_titlebar = it_titlebar.
  gr_pfstatus = ir_pfstatus.
  gt_pfstatus = it_pfstatus.

* Adjust titlebar + pfstatus if needed.
  IF gr_titlebar IS NOT BOUND.
    _adjust_titlebar_to_vcode( i_old_vcode = space
                               i_new_vcode = g_vcode ).
  ENDIF.
  IF gr_pfstatus IS NOT BOUND.
    _adjust_pfstatus_to_vcode( i_old_vcode = space
                               i_new_vcode = g_vcode ).
  ENDIF.

ENDMETHOD.


METHOD _set_pfstatus.

  DATA:
    lr_pfstatus  TYPE REF TO cl_ish_gui_mdy_pfstatus,
    l_pfkey      TYPE sy-pfkey,
    l_repid      TYPE sy-repid,
    lt_exclfunc  TYPE syucomm_t.

* Determine the pfstatus to use.
  IF ir_pfstatus IS BOUND.
    lr_pfstatus = ir_pfstatus.
  ELSE.
    lr_pfstatus = gr_pfstatus.
  ENDIF.
  CHECK lr_pfstatus IS BOUND.

* Determine the pfkey (has to be specified).
  l_pfkey = lr_pfstatus->get_pfkey( ).
  CHECK l_pfkey IS NOT INITIAL.

* Determine the repid.
  l_repid = lr_pfstatus->get_repid( ).
  IF l_repid IS INITIAL.
    l_repid = sy-repid.
  ENDIF.
  CHECK l_repid IS NOT INITIAL.

* Determine the excluding functions.
  lt_exclfunc = lr_pfstatus->get_excluding_functions( ).

* Set the pfstatus.
  IF lt_exclfunc IS INITIAL.
    SET PF-STATUS l_pfkey OF PROGRAM l_repid.
  ELSE.
    SET PF-STATUS l_pfkey OF PROGRAM l_repid EXCLUDING lt_exclfunc.
  ENDIF.

ENDMETHOD.


METHOD _set_titlebar.

  DATA:
    lr_titlebar    TYPE REF TO cl_ish_gui_mdy_titlebar,
    l_title        TYPE sy-title,
    l_repid        TYPE sy-repid,
    l_par1         TYPE string,
    l_par2         TYPE string,
    l_par3         TYPE string,
    l_par4         TYPE string,
    l_par5         TYPE string,
    l_par6         TYPE string,
    l_par7         TYPE string,
    l_par8         TYPE string,
    l_par9         TYPE string.

* Determine the titlebar to use.
  IF ir_titlebar IS BOUND.
    lr_titlebar = ir_titlebar.
  ELSE.
    lr_titlebar = gr_titlebar.
  ENDIF.
  CHECK lr_titlebar IS BOUND.

* Determine the title (has to be specified).
  l_title = lr_titlebar->get_title( ).
  CHECK l_title IS NOT INITIAL.

* Determine the repid.
  l_repid = lr_titlebar->get_repid( ).
  IF l_repid IS INITIAL.
    l_repid = sy-repid.
  ENDIF.
  CHECK l_repid IS NOT INITIAL.

* Set the titlebar.
  IF lr_titlebar->has_parameters( ) = abap_false.
    SET TITLEBAR l_title OF PROGRAM l_repid.
  ELSE.
    l_par1 = lr_titlebar->get_parameter( i_idx = 1 ).
    l_par2 = lr_titlebar->get_parameter( i_idx = 2 ).
    l_par3 = lr_titlebar->get_parameter( i_idx = 3 ).
    l_par4 = lr_titlebar->get_parameter( i_idx = 4 ).
    l_par5 = lr_titlebar->get_parameter( i_idx = 5 ).
    l_par6 = lr_titlebar->get_parameter( i_idx = 6 ).
    l_par7 = lr_titlebar->get_parameter( i_idx = 7 ).
    l_par8 = lr_titlebar->get_parameter( i_idx = 8 ).
    l_par9 = lr_titlebar->get_parameter( i_idx = 9 ).
    SET TITLEBAR l_title OF PROGRAM l_repid WITH l_par1 l_par2 l_par3 l_par4 l_par5 l_par6 l_par7 l_par8 l_par9.
  ENDIF.

ENDMETHOD.


METHOD _set_vcode.

  DATA:
    l_old_vcode  TYPE tndym-vcode.

* Remember the old vcode.
  l_old_vcode = g_vcode.

* First call the super method to set the vcode.
  r_changed = super->_set_vcode( i_vcode = i_vcode ).

* On vcode changes we may have to adjust the titlebar + pfstatus.
  IF r_changed = abap_true.
    _adjust_titlebar_to_vcode( i_old_vcode = l_old_vcode
                               i_new_vcode = g_vcode ).
    _adjust_pfstatus_to_vcode( i_old_vcode = l_old_vcode
                               i_new_vcode = g_vcode ).
  ENDIF.

ENDMETHOD.


METHOD __before_pbo.

* First call the super method (to propagate the dynpro request).
  super->__before_pbo( i_repid = i_repid
                       i_dynnr = i_dynnr ).

* Set the titlebar.
  _set_titlebar( ).

* Set the pf-status.
  _set_pfstatus( ).

ENDMETHOD.


METHOD __exit_command.

  DATA:
    lr_controller     TYPE REF TO if_ish_gui_controller,
    lr_request        TYPE REF TO cl_ish_gui_mdy_event,
    lr_response       TYPE REF TO cl_ish_gui_response.

* Initializations.
  r_exit = abap_true.

* On exit we have to raise event ev_exit.
  DO 1 TIMES.

*   Get the controller.
    lr_controller = get_controller( ).
    CHECK lr_controller IS BOUND.

*   Create the mdy event request.
    lr_request = cl_ish_gui_mdy_event=>create( ir_sender         = me
                                               i_ucomm           = i_ucomm
                                               i_is_exit_command = abap_true ).

*   Let the controller process the request.
    lr_response = lr_controller->process_request( ir_request = lr_request ).

*   Do not exit if the request processing was cancelled.
    CHECK lr_response IS BOUND.
    r_exit = lr_response->get_exit( ).

  ENDDO.

* Raise event ev_exit.
  IF r_exit = abap_true.
    RAISE EVENT ev_exit.
  ENDIF.

ENDMETHOD.


METHOD __user_command.

  DATA:
    lr_controller     TYPE REF TO if_ish_gui_controller,
    lr_request        TYPE REF TO cl_ish_gui_mdy_event,
    lr_response       TYPE REF TO cl_ish_gui_response.

* Initializations.
  r_exit = abap_false.

* Get the controller.
  lr_controller = get_controller( ).
  CHECK lr_controller IS BOUND.

* Create the request.
  lr_request = cl_ish_gui_mdy_event=>create( ir_sender         = me
                                             i_ucomm           = i_ucomm
                                             i_is_exit_command = abap_false ).

* Let the controller process the request.
  lr_response = lr_controller->process_request( ir_request = lr_request ).

* Exit on exit response.
  CHECK lr_response IS BOUND.
  r_exit = lr_response->get_exit( ).

* Raise event ev_exit.
  IF r_exit = abap_true.
    RAISE EVENT ev_exit.
  ENDIF.

ENDMETHOD.
ENDCLASS.
