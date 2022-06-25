class CL_ISH_SCREEN_COLLAPSIBLE_STD definition
  public
  inheriting from CL_ISH_SCREEN_STD
  abstract
  create protected .

*"* public components of class CL_ISH_SCREEN_COLLAPSIBLE_STD
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_SCREEN_COLLAPSIBLE .

  aliases GET_EMBEDDED_SCREENS
    for IF_ISH_SCREEN_COLLAPSIBLE~GET_EMBEDDED_SCREENS .
  aliases GET_SCREEN_ACTIVE
    for IF_ISH_SCREEN_COLLAPSIBLE~GET_SCREEN_ACTIVE .
  aliases GET_SCR_COLLAPSIBLE
    for IF_ISH_SCREEN_COLLAPSIBLE~GET_SCR_COLLAPSIBLE .
  aliases SWITCH
    for IF_ISH_SCREEN_COLLAPSIBLE~SWITCH .

  constants CO_OTYPE_COLLAPSIBLE_STD type ISH_OBJECT_TYPE value 3012. "#EC NOTEXT

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~GET_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~GET_DEFAULT_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~GET_DEF_CRS_POSSIBLE
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCREEN_COLLAPSIBLE_STD
*"* do not include other source files here!!!

  data GR_SCR_COLLAPSIBLE type ref to CL_ISH_SCR_COLLAPSIBLE .
  data GT_SCR_EMBEDDED type ISH_T_SCREEN_OBJECTS .

  methods GET_INITIAL_PROPERTIES
    exporting
      !ER_SCREEN_ACTIVE type ref to IF_ISH_SCREEN
      value(E_STATE) type I
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_EMBEDDED_SCREENS
  abstract
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_EV_SWITCH
    for event EV_SWITCH of IF_ISH_SCR_COLLAPSIBLE .

  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods INITIALIZE_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_SCREEN_COLLAPSIBLE_STD
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCREEN_COLLAPSIBLE_STD IMPLEMENTATION.


METHOD get_initial_properties .

  DATA: lr_scr_embedded  TYPE REF TO if_ish_screen.

* Initializations.
  CLEAR er_screen_active.
  e_state = cl_ish_scr_collapsible=>co_state_expand.
  e_rc = 0.

* Default implementation: Use the first embedded screen.
  READ TABLE gt_scr_embedded
    INTO lr_scr_embedded
    INDEX 1.
  CHECK sy-subrc = 0.

* Export
  er_screen_active = lr_scr_embedded.

ENDMETHOD.


METHOD HANDLE_EV_SWITCH .

  CALL METHOD switch.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_collapsible_std.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_collapsible_std.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen_collapsible~get_embedded_screens .

  rt_screen = gt_scr_embedded.

ENDMETHOD.


METHOD if_ish_screen_collapsible~get_screen_active .

  CHECK NOT gr_scr_collapsible IS INITIAL.

* Wrap to collapsible screen.
  CALL METHOD gr_scr_collapsible->get_screen_active
    IMPORTING
      er_screen_active = er_screen_active
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen_collapsible~get_scr_collapsible .

  DATA: lr_scr_collapsible  TYPE REF TO cl_ish_scr_collapsible.

* Initializations.
  e_rc = 0.
  er_scr_collapsible = gr_scr_collapsible.

* Already loaded?
  CHECK gr_scr_collapsible IS INITIAL.

* Further processing only if specified.
  CHECK i_create = on.

* Create collapsible screen object.
  CALL METHOD cl_ish_scr_collapsible=>create
    IMPORTING
      er_instance     = lr_scr_collapsible
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Initialize the collapsible screen object.
  CALL METHOD lr_scr_collapsible->initialize
    EXPORTING
      i_main_object      = gr_main_object
      i_vcode            = g_vcode
      i_caller           = g_caller
      i_environment      = gr_environment
      i_lock             = gr_lock
      i_config           = gr_config
      i_use_tndym_cursor = g_use_tndym_cursor
    IMPORTING
      e_rc               = e_rc
    CHANGING
      c_errorhandler     = cr_errorhandler.
  CHECK e_rc = 0.

* Remember the collapsible screen.
  gr_scr_collapsible = lr_scr_collapsible.

* Export.
  er_scr_collapsible = gr_scr_collapsible.

ENDMETHOD.


METHOD if_ish_screen_collapsible~switch .

  DATA: lr_scr_active      TYPE REF TO if_ish_screen,
        lr_scr_next        TYPE REF TO if_ish_screen,
        lr_scr_embedded    TYPE REF TO if_ish_screen,
        l_set_scr_next     TYPE ish_on_off,
        l_rc               TYPE ish_method_rc.

  CHECK NOT gr_scr_collapsible IS INITIAL.

* Get the currently active screen.
  CALL METHOD gr_scr_collapsible->get_screen_active
    IMPORTING
      er_screen_active = lr_scr_active
      e_rc             = l_rc.
  CHECK l_rc = 0.

* Get the next screen.
* The next screen is the one after the currently active screen
* or the first of self's embedded screens.
  CLEAR lr_scr_next.
  l_set_scr_next = off.
  LOOP AT gt_scr_embedded INTO lr_scr_embedded.
    CHECK NOT lr_scr_embedded IS INITIAL.
    IF lr_scr_next IS INITIAL.
      lr_scr_next = lr_scr_embedded.
    ENDIF.
    IF lr_scr_embedded = lr_scr_active.
      l_set_scr_next = on.
      CONTINUE.
    ENDIF.
    IF l_set_scr_next = on.
      lr_scr_next = lr_scr_embedded.
      EXIT.
    ENDIF.
  ENDLOOP.

* Further processing only if there is a next screen.
  CHECK NOT lr_scr_next IS INITIAL.

* Switch
  CALL METHOD gr_scr_collapsible->set_screen_active
    EXPORTING
      ir_screen = lr_scr_next.

ENDMETHOD.


METHOD if_ish_screen~destroy .

  DATA: l_rc               TYPE ish_method_rc.

* Call super method.
  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.   " on error continue working
    e_rc = l_rc.
  ENDIF.

* Destroy collapsible screen
  IF NOT gr_scr_collapsible IS INITIAL.
    CALL METHOD gr_scr_collapsible->destroy
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.   " on error continue working
      e_rc = l_rc.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~get_cursorfield .

  DATA: lr_scr_active  TYPE REF TO if_ish_screen,
        l_rc           TYPE ish_method_rc.

* Initializations.
  e_cursorfield = g_scr_cursorfield.
  er_screen     = me.

* Get the active subscreen.
  CALL METHOD get_screen_active
    IMPORTING
      er_screen_active = lr_scr_active
      e_rc             = l_rc.
  CHECK l_rc = 0.
  CHECK NOT lr_scr_active IS INITIAL.

* Wrap to active subscreen.
  CALL METHOD lr_scr_active->get_cursorfield
    IMPORTING
      e_cursorfield = e_cursorfield
      er_screen     = er_screen.

ENDMETHOD.


METHOD if_ish_screen~get_default_cursorfield .

  DATA: lr_scr_active  TYPE REF TO if_ish_screen,
        l_rc           TYPE ish_method_rc.

* Initializations.
  e_cursorfield = g_scr_cursorfield.
  er_screen     = me.

* Get the active subscreen.
  CALL METHOD get_screen_active
    IMPORTING
      er_screen_active = lr_scr_active
      e_rc             = l_rc.
  CHECK l_rc = 0.
  CHECK NOT lr_scr_active IS INITIAL.

* Wrap to active subscreen.
  CALL METHOD lr_scr_active->get_default_cursorfield
    IMPORTING
      e_cursorfield = e_cursorfield
      er_screen     = er_screen.

ENDMETHOD.


METHOD if_ish_screen~get_def_crs_possible .

  DATA: lr_scr_active  TYPE REF TO if_ish_screen,
        l_rc           TYPE ish_method_rc.

* Initializations.
  CLEAR: e_crs_field_prio1,
         er_crs_scr_prio1,
         e_crs_field_prio2,
         er_crs_scr_prio2,
         e_crs_field_prio3,
         er_crs_scr_prio3.
  e_rc = 0.

* Get the active subscreen.
  CALL METHOD get_screen_active
    IMPORTING
      er_screen_active = lr_scr_active
      e_rc             = l_rc.
  CHECK l_rc = 0.
  CHECK NOT lr_scr_active IS INITIAL.

* Wrap to active subscreen.
  CALL METHOD lr_scr_active->get_def_crs_possible
    IMPORTING
      e_crs_field_prio1 = e_crs_field_prio1
      er_crs_scr_prio1  = er_crs_scr_prio1
      e_crs_field_prio2 = e_crs_field_prio2
      er_crs_scr_prio2  = er_crs_scr_prio2
      e_crs_field_prio3 = e_crs_field_prio3
      er_crs_scr_prio3  = er_crs_scr_prio3
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen .

  CHECK NOT gr_scr_collapsible IS INITIAL.

* Wrap to collapsible screen.
  CALL METHOD gr_scr_collapsible->ok_code_screen
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler
      c_okcode       = c_okcode.

ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .

  CHECK NOT gr_scr_collapsible IS INITIAL.

* Wrap to collapsible screen.
  CALL METHOD gr_scr_collapsible->set_instance_for_display
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD initialize_field_values .

* No own field values.
* Use GR_SCR_COLLAPSIBLE field values instead.
* Implemented in method INITIALIZE_INTERNAL.

ENDMETHOD.


METHOD initialize_internal .

  DATA: lr_scr_active_initial  TYPE REF TO if_ish_screen,
        l_state_initial        TYPE i.

* Initialize the collapsible screen.
  CALL METHOD get_scr_collapsible
    EXPORTING
      i_create        = on
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Create and initialize the embedded screens.
  CALL METHOD initialize_embedded_screens
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get the initial properties.
  CALL METHOD get_initial_properties
    IMPORTING
      er_screen_active = lr_scr_active_initial
      e_state          = l_state_initial
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Set the initial active subscreen.
  CALL METHOD gr_scr_collapsible->set_screen_active
    EXPORTING
      ir_screen       = lr_scr_active_initial
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Set the initial state.
  CALL METHOD gr_scr_collapsible->set_initial_state
    EXPORTING
      i_state = l_state_initial.

* Use the field values of the collapsible screen.
  CALL METHOD gr_scr_collapsible->get_data
    IMPORTING
      e_screen_values = gr_screen_values.

* Use the parent of the collapsible screen.
  CALL METHOD gr_scr_collapsible->get_parent
    IMPORTING
      es_parent = gs_parent.

* Register self for switch event.
  SET HANDLER handle_ev_switch FOR gr_scr_collapsible.

ENDMETHOD.
ENDCLASS.
