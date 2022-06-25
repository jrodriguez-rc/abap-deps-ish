class CL_ISH_SCR_COLLAPSIBLE definition
  public
  inheriting from CL_ISH_SCREEN
  create public .

*"* public components of class CL_ISH_SCR_COLLAPSIBLE
*"* do not include other source files here!!!
public section.
  type-pools CNTB .
  type-pools ICON .

  interfaces IF_ISH_SCR_COLLAPSIBLE .

  aliases EV_SWITCH
    for IF_ISH_SCR_COLLAPSIBLE~EV_SWITCH .

  constants CO_FIELDNAME_SUBSCREEN type ISH_FIELDNAME value 'G_CO_SUBSCREEN'. "#EC NOTEXT
  constants CO_OTYPE_SCR_COLLAPSIBLE type ISH_OBJECT_TYPE value 12017. "#EC NOTEXT
  constants CO_STATE_COLLAPSE type I value 1. "#EC NOTEXT
  constants CO_STATE_EXPAND type I value 2. "#EC NOTEXT

  methods SWITCH_BUTTON .
  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      !ER_INSTANCE type ref to CL_ISH_SCR_COLLAPSIBLE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SCREEN_ACTIVE
    exporting
      !ER_SCREEN_ACTIVE type ref to IF_ISH_SCREEN
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_SCREEN_ACTIVE
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SCR_PB_COLL
    exporting
      !ER_SCR_PB_COLL type ref to CL_ISH_SCR_PUSHBUTTON
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_BUTTON_COLLAPSE
    importing
      value(I_ICON) type N1_ICON optional
      value(I_ICON_X) type ISH_ON_OFF default OFF
      value(I_INFO) type STRING optional
      value(I_INFO_X) type ISH_ON_OFF default OFF
      value(I_ACTIVE) type ISH_ON_OFF optional
      value(I_ACTIVE_X) type ISH_ON_OFF default OFF
      value(I_INPUT) type ISH_ON_OFF optional
      value(I_INPUT_X) type ISH_ON_OFF default OFF .
  methods SET_BUTTON_CURRENT
    importing
      value(I_ICON) type N1_ICON optional
      value(I_ICON_X) type ISH_ON_OFF default OFF
      value(I_INFO) type STRING optional
      value(I_INFO_X) type ISH_ON_OFF default OFF
      value(I_ACTIVE) type ISH_ON_OFF optional
      value(I_ACTIVE_X) type ISH_ON_OFF default OFF
      value(I_INPUT) type ISH_ON_OFF optional
      value(I_INPUT_X) type ISH_ON_OFF default OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_BUTTON_EXPAND
    importing
      value(I_ICON) type N1_ICON optional
      value(I_ICON_X) type ISH_ON_OFF default OFF
      value(I_INFO) type STRING optional
      value(I_INFO_X) type ISH_ON_OFF default OFF
      value(I_ACTIVE) type ISH_ON_OFF optional
      value(I_ACTIVE_X) type ISH_ON_OFF default OFF
      value(I_INPUT) type ISH_ON_OFF optional
      value(I_INPUT_X) type ISH_ON_OFF default OFF .
  type-pools CO .
  methods SET_INITIAL_STATE
    importing
      value(I_STATE) type I default CO_STATE_EXPAND .
  methods DO_NOT_SET_CURSORFIELD .
  methods DO_SET_CURSORFIELD .

  methods IF_ISH_SCREEN~CLEAR_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~GET_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~GET_DEFAULT_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~REMIND_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~SET_CURSOR
    redefinition .
  methods IF_ISH_SCREEN~SET_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_COLLAPSIBLE
*"* do not include other source files here!!!

  data GR_SCR_PB_COLL type ref to CL_ISH_SCR_PUSHBUTTON .
  data G_ACTIVE_COLLAPSE type ISH_ON_OFF value ON .
  data G_ACTIVE_EXPAND type ISH_ON_OFF value ON .
  data G_ICON_COLLAPSE type N1_ICON value ICON_DATA_AREA_COLLAPSE .
  data G_ICON_EXPAND type N1_ICON value ICON_DATA_AREA_EXPAND .
  data G_INFO_COLLAPSE type STRING .
  data G_INFO_EXPAND type STRING .
  data G_INITIAL_STATE type I value CO_STATE_EXPAND .
  data G_INPUT_COLLAPSE type ISH_ON_OFF value ON .
  data G_INPUT_EXPAND type ISH_ON_OFF value ON .
  data G_SET_FIRST_CURSORFIELD type ISH_ON_OFF value off .

  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods INITIALIZE_PARENT
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_COLLAPSIBLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_COLLAPSIBLE IMPLEMENTATION.


METHOD constructor.

  CALL METHOD super->constructor.

ENDMETHOD.


METHOD create .

* definitions
  DATA: l_rc                    TYPE ish_method_rc.
* ---------- ---------- ----------
* create instance for errorhandling if necessary
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* create instance
  CREATE OBJECT er_instance
    EXCEPTIONS
      instance_not_possible = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
*   Eine Instanz der Klasse & konnte nicht angelegt werden
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1BASE'
        i_num  = '003'
        i_mv1  = 'CL_ISH_SCR_COLLAPSIBLE'
        i_last = ' '.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD do_not_set_cursorfield.

  g_set_first_cursorfield = off.

ENDMETHOD.


METHOD do_set_cursorfield.

  g_set_first_cursorfield = on.

ENDMETHOD.


METHOD get_screen_active .

  DATA: ls_field_val  TYPE rnfield_value.

* Initializations
  CLEAR: e_rc,
         er_screen_active.

* Get the field value for the screen instance.
  CALL METHOD gr_screen_values->get_data
    EXPORTING
      i_fieldname    = co_fieldname_subscreen
    IMPORTING
      e_field_value  = ls_field_val
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Export the screen instance.
  er_screen_active ?= ls_field_val-object.

ENDMETHOD.


METHOD GET_SCR_PB_COLL .

  DATA: l_icon    LIKE g_icon_expand,
        l_info    LIKE g_info_expand,
        l_active  LIKE g_active_expand,
        l_input   LIKE g_input_expand.

* Initializations.
  er_scr_pb_coll = gr_scr_pb_coll.
  e_rc = 0.

* Already loaded?
  CHECK gr_scr_pb_coll IS INITIAL.

* Set pushbutton properties depending on g_initial_state.
  IF g_initial_state = co_state_collapse.
    l_icon    = g_icon_collapse.
    l_info    = g_info_collapse.
    l_active  = g_active_collapse.
    l_input   = g_input_collapse.
  ELSE.
    l_icon    = g_icon_expand.
    l_info    = g_info_expand.
    l_active  = g_active_expand.
    l_input   = g_input_expand.
  ENDIF.

* Get a new pushbutton object.
  CALL METHOD cl_ish_scr_pushbutton=>checkout
    EXPORTING
      i_pbtype          = cl_ish_scr_pushbutton=>co_pbtype_icon2
      i_icon            = l_icon
      i_info            = l_info
      i_active          = l_active
      i_input           = l_input
    IMPORTING
      er_scr_pushbutton = gr_scr_pb_coll
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Export the pushbutton object.
  er_scr_pb_coll = gr_scr_pb_coll.

ENDMETHOD.


METHOD if_ish_screen~clear_cursorfield .

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        l_rc       TYPE ish_method_rc.

* Get active subscreen.
  CALL METHOD get_screen_active
    IMPORTING
      er_screen_active = lr_screen
      e_rc             = l_rc.
  CHECK l_rc = 0.
  CHECK NOT lr_screen IS INITIAL.

* Wrap to subscreen.
  CALL METHOD lr_screen->clear_cursorfield.

ENDMETHOD.


METHOD if_ish_screen~destroy .

  DATA: l_rc  TYPE ish_method_rc.

* Destroy super class(es).
  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Destroy the pushbutton.
  IF NOT gr_scr_pb_coll IS INITIAL.
    CALL METHOD gr_scr_pb_coll->destroy
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~get_cursorfield .

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        l_rc       TYPE ish_method_rc.

* Get active subscreen.
  CALL METHOD get_screen_active
    IMPORTING
      er_screen_active = lr_screen
      e_rc             = l_rc.
  CHECK l_rc = 0.
  CHECK NOT lr_screen IS INITIAL.

* Wrap to subscreen.
  CALL METHOD lr_screen->get_cursorfield
    IMPORTING
      e_cursorfield = e_cursorfield
      er_screen     = er_screen.

ENDMETHOD.


METHOD if_ish_screen~get_default_cursorfield .

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        l_rc       TYPE ish_method_rc.

* Get active subscreen.
  CALL METHOD get_screen_active
    IMPORTING
      er_screen_active = lr_screen
      e_rc             = l_rc.
  CHECK l_rc = 0.
  CHECK NOT lr_screen IS INITIAL.

* Wrap to subscreen.
  CALL METHOD lr_screen->get_default_cursorfield
    IMPORTING
      e_cursorfield = e_cursorfield
      er_screen     = er_screen.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen .

* Initializations.
  e_rc = 0.

* Process only if there is a pushbutton object.
  CHECK NOT gr_scr_pb_coll IS INITIAL.

* Process only if this pushbutton was clicked.
  CHECK c_okcode = gr_scr_pb_coll->get_ucomm( ).

* Change the properties of the pushbutton.
  CALL METHOD switch_button.

* Raise event EV_SWITH to change displayed screen.
  RAISE EVENT ev_switch.

* Clear all cursorfields and set flag to position cursor.
  RAISE EVENT ev_clear_all_cursorfields.
  g_set_first_cursorfield = on.

ENDMETHOD.


METHOD if_ish_screen~remind_cursorfield .

* Not needed.

ENDMETHOD.


METHOD if_ish_screen~set_cursor .

  DATA: l_cursorfield  TYPE ish_fieldname,
        lr_screen      TYPE REF TO if_ish_screen.

* Process only if cursor should be positioned on default cursorfield.
  CHECK g_set_first_cursorfield = on.
  g_set_first_cursorfield = off.

* Process only if there are no errors.
  CHECK i_rn1message  IS INITIAL.
  CHECK i_cursorfield IS INITIAL.
  CHECK gs_message    IS INITIAL.

* Set cursor to first cursorfield in subscreen.
  CALL METHOD me->get_default_cursorfield
    IMPORTING
      e_cursorfield = l_cursorfield
      er_screen     = lr_screen.
  IF NOT lr_screen IS INITIAL.
    CALL METHOD lr_screen->set_cursorfield
      EXPORTING
        i_cursorfield = l_cursorfield.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~set_cursorfield .

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        l_rc       TYPE ish_method_rc.

* Get active subscreen.
  CALL METHOD get_screen_active
    IMPORTING
      er_screen_active = lr_screen
      e_rc             = l_rc.
  CHECK l_rc = 0.
  CHECK NOT lr_screen IS INITIAL.

* Wrap to subscreen.
  CALL METHOD lr_screen->set_cursorfield
    EXPORTING
      i_cursorfield = i_cursorfield.

ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .
  CALL FUNCTION 'ISHMED_SET_SCR_COLLAPSIBLE'
    EXPORTING
      ir_screen = me.
ENDMETHOD.


METHOD initialize_field_values.

* local tables
  DATA: lt_field_val            TYPE ish_t_field_value.
* workareas
  DATA: ls_field_val            TYPE rnfield_value.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
  CLEAR: lt_field_val.
* ----------
* initialize every screen field
  CLEAR: ls_field_val.
  ls_field_val-fieldname = co_fieldname_subscreen.
  ls_field_val-type      = 'S'.       " screen instance
  INSERT ls_field_val INTO TABLE lt_field_val.
* ----------
* set values
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      it_field_values = lt_field_val
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
* ---------- ---------- ----------

ENDMETHOD.


METHOD initialize_parent .

  CLEAR: gs_parent.

  gs_parent-repid  = 'SAPLN_SDY_COLLAPSIBLE'.
  gs_parent-dynnr  = '0100'.
  gs_parent-type   = co_scr_parent_type_dynpro.

ENDMETHOD.


METHOD set_button_collapse .

*-- begin Grill, ID-18097
  IF gr_scr_pb_coll IS BOUND.
    IF gr_scr_pb_coll->get_icon( ) = g_icon_collapse.
      CALL METHOD gr_scr_pb_coll->set_properties
        EXPORTING
          i_icon     = i_icon
          i_icon_x   = i_icon_x
          i_info     = i_info
          i_info_x   = i_info_x
          i_active   = i_active
          i_active_x = i_active_x
          i_input    = i_input
          i_input_x  = i_input_x.
    ENDIF.
  ENDIF.
*-- end Grill, ID-18097

  IF i_icon_x = on.
    g_icon_collapse = i_icon.
  ENDIF.
  IF i_info_x = on.
    g_info_collapse = i_info.
  ENDIF.
  IF i_active_x = on.
    g_active_collapse = i_active.
  ENDIF.
  IF i_input_x = on.
    g_input_collapse = i_input.
  ENDIF.

ENDMETHOD.


METHOD set_button_current .

* Get the pushbutton.
  CALL METHOD get_scr_pb_coll
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT gr_scr_pb_coll IS INITIAL.

* Set the pushbutton properties.
  CALL METHOD gr_scr_pb_coll->set_properties
    EXPORTING
      i_icon     = i_icon
      i_icon_x   = i_icon_x
      i_info     = i_info
      i_info_x   = i_info_x
      i_active   = i_active
      i_active_x = i_active_x
      i_input    = i_input
      i_input_x  = i_input_x.

ENDMETHOD.


METHOD set_button_expand .

*-- begin Grill, ID-18097
  IF gr_scr_pb_coll IS BOUND.
    IF gr_scr_pb_coll->get_icon( ) = g_icon_expand.
      CALL METHOD gr_scr_pb_coll->set_properties
        EXPORTING
          i_icon     = i_icon
          i_icon_x   = i_icon_x
          i_info     = i_info
          i_info_x   = i_info_x
          i_active   = i_active
          i_active_x = i_active_x
          i_input    = i_input
          i_input_x  = i_input_x.
    ENDIF.
  ENDIF.
*-- end Grill, ID-18097

  IF i_icon_x = on.
    g_icon_expand = i_icon.
  ENDIF.
  IF i_info_x = on.
    g_info_expand = i_info.
  ENDIF.
  IF i_active_x = on.
    g_active_expand = i_active.
  ENDIF.
  IF i_input_x = on.
    g_input_expand = i_input.
  ENDIF.

ENDMETHOD.


METHOD set_initial_state .

  g_initial_state = i_state.

ENDMETHOD.


METHOD set_screen_active.

* definitions
  DATA: ls_field_val             TYPE rnfield_value.
* ---------- ---------- ----------
  CLEAR: ls_field_val.
  ls_field_val-fieldname = co_fieldname_subscreen.
  ls_field_val-type      = co_fvtype_screen.
  ls_field_val-object    = ir_screen.
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      i_field_value  = ls_field_val
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
* ---------- ---------- ----------

ENDMETHOD.


METHOD switch_button.

* Process only if there is a pushbutton object.
  CHECK NOT gr_scr_pb_coll IS INITIAL.

* Switch to collapse or expand mode.
  IF gr_scr_pb_coll->get_icon( ) = g_icon_collapse.
    CALL METHOD gr_scr_pb_coll->set_properties
      EXPORTING
        i_icon     = g_icon_expand
        i_icon_x   = on
        i_info     = g_info_expand
        i_info_x   = on
        i_active   = g_active_expand
        i_active_x = on
        i_input    = g_input_expand
        i_input_x  = on.
  ELSE.
    CALL METHOD gr_scr_pb_coll->set_properties
      EXPORTING
        i_icon     = g_icon_collapse
        i_icon_x   = on
        i_info     = g_info_collapse
        i_info_x   = on
        i_active   = g_active_collapse
        i_active_x = on
        i_input    = g_input_collapse
        i_input_x  = on.
  ENDIF.

ENDMETHOD.
ENDCLASS.
