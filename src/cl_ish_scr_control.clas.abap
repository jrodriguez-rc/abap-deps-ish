class CL_ISH_SCR_CONTROL definition
  public
  inheriting from CL_ISH_SCREEN
  abstract
  create public .

*"* public components of class CL_ISH_SCR_CONTROL
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_SCR_CONTROL .

  aliases CO_UCOMM_SYSEV
    for IF_ISH_SCR_CONTROL~CO_UCOMM_SYSEV .
  aliases CO_UCOMM_SYSEV_ERROR
    for IF_ISH_SCR_CONTROL~CO_UCOMM_SYSEV_ERROR .
  aliases BUILD_UCOMM
    for IF_ISH_SCR_CONTROL~BUILD_UCOMM .
  aliases DESTROY_INCL_EMBCNTL
    for IF_ISH_SCR_CONTROL~DESTROY_INCL_EMBCNTL .
  aliases GET_CONTAINER
    for IF_ISH_SCR_CONTROL~GET_CONTAINER .
  aliases GET_ORIGINAL_UCOMM
    for IF_ISH_SCR_CONTROL~GET_ORIGINAL_UCOMM .
  aliases IS_DRAGDROP_SUPPORTED
    for IF_ISH_SCR_CONTROL~IS_DRAGDROP_SUPPORTED .
  aliases IS_SYSEV_UCOMM
    for IF_ISH_SCR_CONTROL~IS_SYSEV_UCOMM .
  aliases IS_UCOMM_SUPPORTED
    for IF_ISH_SCR_CONTROL~IS_UCOMM_SUPPORTED .
  aliases PAI_INCL_EMBCNTL
    for IF_ISH_SCR_CONTROL~PAI_INCL_EMBCNTL .
  aliases PBO_INCL_EMBCNTL
    for IF_ISH_SCR_CONTROL~PBO_INCL_EMBCNTL .
  aliases RAISE_EV_SYSTEM_EVENT
    for IF_ISH_SCR_CONTROL~RAISE_EV_SYSTEM_EVENT .
  aliases SET_EV_SYSTEM_EVENT_RESULT
    for IF_ISH_SCR_CONTROL~SET_EV_SYSTEM_EVENT_RESULT .
  aliases SET_OKCODE_SYSEV
    for IF_ISH_SCR_CONTROL~SET_OKCODE_SYSEV .
  aliases SET_OKCODE_SYSEV_ERROR
    for IF_ISH_SCR_CONTROL~SET_OKCODE_SYSEV_ERROR .
  aliases SUPPORT_DRAGDROP
    for IF_ISH_SCR_CONTROL~SUPPORT_DRAGDROP .
  aliases EV_SYSTEM_EVENT
    for IF_ISH_SCR_CONTROL~EV_SYSTEM_EVENT .

  constants CO_OTYPE_SCR_CONTROL type ISH_OBJECT_TYPE value 3013. "#EC NOTEXT

  methods CONSTRUCTOR .
  class-methods ELIMINATE_SYSEV
    changing
      !C_UCOMM type SY-UCOMM .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~RAISE_EV_USER_COMMAND
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_CONTROL
*"* do not include other source files here!!!

  class-data G_LAST_CNTL_ID type N_NUMC5 value 0 .
  data G_CNTL_ID type N_NUMC5 value 0 .
  data G_SYSEV_RC type ISH_METHOD_RC .
  data G_UCOMM type SY-UCOMM .
  data GR_SYSEV_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  data G_EV_SYSEV_HANDLED type ISH_ON_OFF .
  data G_EV_SYSEV_RC type ISH_METHOD_RC .
  data GR_EV_SYSEV_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  data G_REMIND_CURSORFIELD type ISH_ON_OFF .
  data G_SUPPORT_DRAGDROP type ISH_ON_OFF value ON .

  methods INITIALIZE_PARENT
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_CONTROL
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_CONTROL IMPLEMENTATION.


METHOD constructor.

  CALL METHOD super->constructor.

* Handle the control id.
  g_last_cntl_id = g_last_cntl_id + 1.
  g_cntl_id = g_last_cntl_id.

ENDMETHOD.


METHOD eliminate_sysev.

  DATA: l_sysev    TYPE sy-ucomm,
        l_ucomm    TYPE sy-ucomm.

  SPLIT c_ucomm
      AT '.'
    INTO l_sysev
         l_ucomm.

  CHECK l_sysev = co_ucomm_sysev.

  c_ucomm = l_ucomm.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_scr_control.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = cl_ish_scr_control=>co_otype_scr_control.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~destroy.

  DATA: l_rc  TYPE ish_method_rc.

* Destroy the container.
  IF NOT gs_parent-container IS INITIAL.
    CALL METHOD gs_parent-container->free
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    l_rc = sy-subrc.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.
  CLEAR gs_parent-container.

* Further processing by the super method.
  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~raise_ev_user_command.

* On PAI we have to remind the cursorfield.
  g_remind_cursorfield = on.

* Further processing by the super method.
  CALL METHOD super->if_ish_screen~raise_ev_user_command
    EXPORTING
      ir_screen = ir_screen
      ir_object = ir_object
      is_col_id = is_col_id
      is_row_no = is_row_no
      i_ucomm   = i_ucomm.

ENDMETHOD.


METHOD if_ish_scr_control~build_ucomm.

* This method builds an unique user command consisting of
*   - the original ucomm
*   - '.' (dot)
*   - control id

  CHECK NOT c_ucomm IS INITIAL.

  CONCATENATE c_ucomm
              g_cntl_id
         INTO c_ucomm
    SEPARATED BY '.'.

ENDMETHOD.


METHOD if_ish_scr_control~destroy_incl_embcntl.

  DATA: lt_screen       TYPE ish_t_screen_objects,
        lr_screen       TYPE REF TO if_ish_screen,
        lr_scr_control  TYPE REF TO if_ish_scr_control,
        l_rc            TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Get the directly embedded screens.
  CALL METHOD cl_ish_utl_screen=>get_screen_instances
    EXPORTING
      i_screen          = me
      i_embedded_scr    = on
      i_only_next_level = on
    IMPORTING
      et_screens        = lt_screen
      e_rc              = l_rc
    CHANGING
      c_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Destroy the directly embedded screens.
  LOOP AT lt_screen INTO lr_screen.
    CHECK lr_screen IS BOUND.
    CHECK NOT lr_screen = me.
    CHECK lr_screen->is_inherited_from(
            co_otype_scr_control ) = on.
    lr_scr_control ?= lr_screen.
    CALL METHOD lr_scr_control->destroy_incl_embcntl
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

* Now destroy self.
  CALL METHOD destroy
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_control~get_container.

  DATA: lr_custom_container  TYPE REF TO cl_gui_custom_container.

* Initializations.
  CLEAR: e_rc,
         er_container.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Container already created?
  er_container = gs_parent-container.
  CHECK er_container IS INITIAL.

* Container not already created
* -> create it from container_name,
*    but only if the container_name is specified
*    and the user wants the container to be created.

  CHECK NOT gs_parent-container_name IS INITIAL.
  CHECK i_create = on.

* Instantiate the custom container.
  CREATE OBJECT lr_custom_container TYPE cl_gui_custom_container
    EXPORTING
      container_name              = gs_parent-container_name
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      OTHERS                      = 6.
  e_rc = sy-subrc.
  IF e_rc <> 0.
*   Fehler & beim Anlegen des Controls & (Klasse &)
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GS_PARENT-CONTAINER'
        i_mv3           = 'CL_GUI_CUSTOM_CONTAINER'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Remember the container object.
  gs_parent-container = lr_custom_container.

* Export.
  er_container = gs_parent-container.

ENDMETHOD.


METHOD if_ish_scr_control~get_original_ucomm.

* This method returns the original part of the given ucomm.

  DATA: l_ucomm    TYPE sy-ucomm,
        l_cntl_id  TYPE n_numc5,
        l_rest     TYPE string.

* Initializations.
  CLEAR r_original_ucomm.

  CHECK NOT i_ucomm IS INITIAL.

* Process only if the ucomm is supported by self.
  CHECK is_ucomm_supported( i_ucomm ) = on.

* Split the ucomm into pieces separated by dots.
* The first part is the original ucomm.
  SPLIT i_ucomm
      AT '.'
    INTO r_original_ucomm
         l_rest.

ENDMETHOD.


METHOD if_ish_scr_control~is_dragdrop_supported.

  r_supported = g_support_dragdrop.

ENDMETHOD.


METHOD if_ish_scr_control~is_sysev_ucomm.

  DATA: l_sysev    TYPE sy-ucomm,
        l_ucomm    TYPE sy-ucomm,
        l_cntl_id  LIKE g_cntl_id,
        l_rest     TYPE string.

  r_is_sysev_ucomm = off.

  SPLIT i_ucomm
      AT '.'
    INTO l_sysev
         l_ucomm
         l_cntl_id
         l_rest.

  CHECK l_sysev = co_ucomm_sysev.
  CHECK l_cntl_id = g_cntl_id.

  r_is_sysev_ucomm = on.

ENDMETHOD.


METHOD if_ish_scr_control~is_ucomm_supported.

* This method returns if the given user command is supported by self.
* This is if the ucomm contains our control id.

  DATA: l_ucomm    TYPE sy-ucomm,
        l_cntl_id  TYPE n_numc5,
        l_rest     TYPE string.

* Initializations.
  r_supported = off.

  CHECK NOT i_ucomm IS INITIAL.

* Split the ucomm into pieces separated by dots.
* The second part is the control id.
  SPLIT i_ucomm
      AT '.'
    INTO l_ucomm
         l_cntl_id
         l_rest.

* The ucomm is only supported if the control id fits.
  CHECK l_cntl_id = g_cntl_id.

  r_supported = on.

ENDMETHOD.


METHOD if_ish_scr_control~pai_incl_embcntl.

  DATA: lt_screen       TYPE ish_t_screen_objects,
        lr_screen       TYPE REF TO if_ish_screen,
        lr_scr_control  TYPE REF TO if_ish_scr_control,
        l_rc            TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Get the directly embedded screens.
  CALL METHOD cl_ish_utl_screen=>get_screen_instances
    EXPORTING
      i_screen          = me
      i_embedded_scr    = on
      i_only_next_level = on
    IMPORTING
      et_screens        = lt_screen
      e_rc              = l_rc
    CHANGING
      c_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* PAI_INCL_EMBCNTL for the directly embedded screens.
  LOOP AT lt_screen INTO lr_screen.
    CHECK lr_screen IS BOUND.
    CHECK NOT lr_screen = me.
    CHECK lr_screen->is_inherited_from(
            co_otype_scr_control ) = on.
    IF i_object_type > 0.
      CHECK lr_screen->is_inherited_from( i_object_type ) = on.
    ENDIF.
    lr_scr_control ?= lr_screen.
    CALL METHOD lr_scr_control->pai_incl_embcntl
      EXPORTING
        i_object_type   = i_object_type
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

* Now do PAI for self.
  IF i_object_type = 0 OR
     is_inherited_from( i_object_type ) = on.
    CALL METHOD process_after_input
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_control~pbo_incl_embcntl.

  DATA: lt_screen       TYPE ish_t_screen_objects,
        lr_screen       TYPE REF TO if_ish_screen,
        lr_scr_control  TYPE REF TO if_ish_scr_control,
        l_rc            TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Get the directly embedded screens.
  CALL METHOD cl_ish_utl_screen=>get_screen_instances
    EXPORTING
      i_screen          = me
      i_embedded_scr    = on
      i_only_next_level = on
    IMPORTING
      et_screens        = lt_screen
      e_rc              = l_rc
    CHANGING
      c_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* PBO for the directly embedded screens.
  LOOP AT lt_screen INTO lr_screen.
    CHECK lr_screen IS BOUND.
    CHECK NOT lr_screen = me.
    CHECK lr_screen->is_inherited_from(
            co_otype_scr_control ) = on.
    IF i_object_type > 0.
      CHECK lr_screen->is_inherited_from( i_object_type ) = on.
    ENDIF.
    lr_scr_control ?= lr_screen.
    CALL METHOD lr_scr_control->pbo_incl_embcntl
      EXPORTING
        i_object_type   = i_object_type
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

* Now do PBO for self.
  IF i_object_type = 0 OR
     is_inherited_from( i_object_type ) = on.
    CALL METHOD process_before_output
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_control~raise_ev_system_event.

* Initializations.
  e_handled = off.
  e_rc      = 0.

* Initialize the ev_sysev result.
  g_ev_sysev_handled = off.
  g_ev_sysev_rc      = 0.
  CLEAR gr_ev_sysev_errorhandler.

* Raise the event.
  RAISE EVENT ev_system_event
    EXPORTING
      i_ucomm   = i_ucomm
      ir_object = ir_object.


* Return the result.
  e_handled = g_ev_sysev_handled.
  e_rc      = g_ev_sysev_rc.
  IF gr_ev_sysev_errorhandler IS BOUND.
    IF cr_errorhandler IS BOUND.
      CALL METHOD cr_errorhandler->copy_messages
        EXPORTING
          i_copy_from = gr_ev_sysev_errorhandler.
    ELSE.
      cr_errorhandler = gr_ev_sysev_errorhandler.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_control~set_ev_system_event_result.

  IF i_handled = on.
    g_ev_sysev_handled = on.
  ENDIF.

  IF i_rc > g_ev_sysev_rc.
    g_ev_sysev_rc = i_rc.
  ENDIF.

  IF ir_errorhandler IS BOUND.
    IF gr_ev_sysev_errorhandler IS BOUND.
      CALL METHOD gr_ev_sysev_errorhandler->copy_messages
        EXPORTING
          i_copy_from = ir_errorhandler.
    ELSE.
      gr_ev_sysev_errorhandler = ir_errorhandler.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_control~set_okcode_sysev.

  DATA: l_ucomm  TYPE sy-ucomm.

* Build the ucomm.
  IF i_ucomm IS INITIAL.
    CONCATENATE co_ucomm_sysev
                g_cntl_id
           INTO l_ucomm
      SEPARATED BY '.'.
  ELSE.
    CONCATENATE co_ucomm_sysev
                i_ucomm
           INTO l_ucomm
      SEPARATED BY '.'.
  ENDIF.

* We set a new ok_code. So we have to remind the cursorfield at PAI.
  g_remind_cursorfield = on.

* Set the new ok_code.
  CALL METHOD cl_gui_cfw=>set_new_ok_code
    EXPORTING
      new_code = l_ucomm.

ENDMETHOD.


METHOD if_ish_scr_control~set_okcode_sysev_error.

  DATA: l_ucomm  TYPE sy-ucomm.

* Build the ucomm.
  CONCATENATE co_ucomm_sysev_error
              g_cntl_id
         INTO l_ucomm
    SEPARATED BY '.'.

* Remember returncode and errorhandler.
  g_sysev_rc            = i_rc.
  gr_sysev_errorhandler = ir_errorhandler.

* We set a new ok_code. So we have to remind the cursorfield at PAI.
  g_remind_cursorfield = on.

* Raise the ok_code.
  CALL METHOD cl_gui_cfw=>set_new_ok_code
    EXPORTING
      new_code = l_ucomm.

ENDMETHOD.


METHOD if_ish_scr_control~support_dragdrop.

  g_support_dragdrop = i_support_dragdrop.

ENDMETHOD.


METHOD initialize_parent.

  DATA: ls_parent  LIKE gs_parent.

  ls_parent = gs_parent.

  CLEAR gs_parent.
  gs_parent-container      = ls_parent-container.
  gs_parent-container_name = ls_parent-container_name.
  gs_parent-type           = co_scr_parent_type_container.

ENDMETHOD.
ENDCLASS.
