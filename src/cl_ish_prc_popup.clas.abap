class CL_ISH_PRC_POPUP definition
  public
  create protected .

*"* public components of class CL_ISH_PRC_POPUP
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_PRC_POPUP .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .
  aliases AFTER_PAI
    for IF_ISH_PRC_POPUP~AFTER_PAI .
  aliases AFTER_PBO
    for IF_ISH_PRC_POPUP~AFTER_PBO .
  aliases BEFORE_PAI_SUBSCREEN
    for IF_ISH_PRC_POPUP~BEFORE_PAI_SUBSCREEN .
  aliases BEFORE_PBO_SUBSCREEN
    for IF_ISH_PRC_POPUP~BEFORE_PBO_SUBSCREEN .
  aliases CHECK
    for IF_ISH_PRC_POPUP~CHECK .
  aliases CHECK_CHANGES
    for IF_ISH_PRC_POPUP~CHECK_CHANGES .
  aliases COLLECT_MESSAGES
    for IF_ISH_PRC_POPUP~COLLECT_MESSAGES .
  aliases DESTROY
    for IF_ISH_PRC_POPUP~DESTROY .
  aliases EXIT_COMMAND
    for IF_ISH_PRC_POPUP~EXIT_COMMAND .
  aliases GET_CALLBACK
    for IF_ISH_PRC_POPUP~GET_CALLBACK .
  aliases GET_CHECK_CHANGES_ON_CANCEL
    for IF_ISH_PRC_POPUP~GET_CHECK_CHANGES_ON_CANCEL .
  aliases GET_CHECK_ON_CHOICE
    for IF_ISH_PRC_POPUP~GET_CHECK_ON_CHOICE .
  aliases GET_CONFIG
    for IF_ISH_PRC_POPUP~GET_CONFIG .
  aliases GET_EXIT_ON_WARNINGS
    for IF_ISH_PRC_POPUP~GET_EXIT_ON_WARNINGS .
  aliases GET_POPUP_POSITION
    for IF_ISH_PRC_POPUP~GET_POPUP_POSITION .
  aliases GET_POPUP_TITLE
    for IF_ISH_PRC_POPUP~GET_POPUP_TITLE .
  aliases GET_SCREEN
    for IF_ISH_PRC_POPUP~GET_SCREEN .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases GET_VCODE
    for IF_ISH_PRC_POPUP~GET_VCODE .
  aliases INITIALIZE
    for IF_ISH_PRC_POPUP~INITIALIZE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases PAI
    for IF_ISH_PRC_POPUP~PAI .
  aliases PBO
    for IF_ISH_PRC_POPUP~PBO .
  aliases RUN
    for IF_ISH_PRC_POPUP~RUN .
  aliases USER_COMMAND
    for IF_ISH_PRC_POPUP~USER_COMMAND .

  data G_UCOMM_CANCEL type SY-UCOMM read-only value 'CAN' .
  data G_UCOMM_CHOICE type SY-UCOMM read-only value 'CHOICE' .
  data G_UCOMM_CRSPOS type SY-UCOMM read-only value 'CRSPOS' .
  data G_UCOMM_01 type RNFUNC-FCODE value 'FUNC1' .
  data G_UCOMM_02 type RNFUNC-FCODE value 'FUNC2' .
  data G_UCOMM_03 type RNFUNC-FCODE value 'FUNC3' .
  constants CO_OTYPE_PRC_POPUP type ISH_OBJECT_TYPE value 6032. "#EC NOTEXT

  class-methods CALCULATE_DYNNR
    importing
      value(I_ROWS) type I
      value(I_COLS) type I
    returning
      value(R_DYNNR) type SY-DYNNR .
  methods CONSTRUCTOR
    importing
      value(IR_SCREEN) type ref to IF_ISH_SCREEN .
  class-methods CREATE
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      value(I_PRC_CLASS_NAME) type STRING optional
      value(I_PRC_OBJECT_TYPE) type I optional
      value(I_USE_BADI) type ISH_ON_OFF default ON
      value(I_REFRESH_BADI_INSTANCE) type ISH_ON_OFF default OFF
      value(I_FORCE_BADI_ERRORS) type ISH_ON_OFF default OFF
      value(I_CREATE_OWN) type ISH_ON_OFF default ON
    exporting
      !ER_PRC_POPUP type ref to IF_ISH_PRC_POPUP
      value(E_CREATED_BY_BADI) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_CONTAINER_NAME
    importing
      value(I_COLUMNS) type I default 50
      value(I_ROWS) type I default 20
    returning
      value(R_CONTAINER_NAME) type ISH_FIELDNAME .
  class-methods SHOW_POPUP
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      value(I_PRC_CLASS_NAME) type STRING optional
      value(I_PRC_OBJECT_TYPE) type I optional
      !IR_CONFIG type ref to IF_ISH_CONFIG optional
      value(I_STARTPOS_COL) type I default 0
      value(I_STARTPOS_ROW) type I default 0
      value(I_ENDPOS_COL) type I default 0
      value(I_ENDPOS_ROW) type I default 0
      value(I_POPUP_TITLE) type CHAR70 optional
      value(I_VCODE) type TNDYM-VCODE optional
      value(I_CHECK_CHANGES_ON_CANCEL) type ISH_ON_OFF default ON
      value(I_CHECK_ON_CHOICE) type ISH_ON_OFF default ON
      value(I_EXIT_ON_WARNINGS) type ISH_ON_OFF default OFF
      value(IR_CALLBACK) type ref to IF_ISH_POPUP_CALLBACK optional
    exporting
      value(E_CANCELLED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_PRC_POPUP
*"* do not include other source files here!!!

  class-data GR_BADI type ref to IF_EX_N1_CREATE_PRC_POPUP .
  data G_ABORT_BECAUSE_OF_WARNINGS type ISH_ON_OFF .
  data G_CANCELLED type ISH_ON_OFF .
  data G_CHECK_CHANGES_ON_CANCEL type ISH_ON_OFF value ON. "#EC NOTEXT .
  data G_CHECK_ON_CHOICE type ISH_ON_OFF value ON. "#EC NOTEXT .
  data G_DYNNR type SY-DYNNR .
  data G_ENDPOS_COL type I .
  data G_ENDPOS_ROW type I .
  data G_EXIT_ON_WARNINGS type ISH_ON_OFF value OFF. "#EC NOTEXT .
  data G_OWN_SCREEN type ISH_ON_OFF .
  data G_POPUP_TITLE type CHAR70 .
  data G_STARTPOS_COL type I .
  data G_STARTPOS_ROW type I .
  data G_VCODE type TNDYM-VCODE .
  data GR_CONFIG type ref to IF_ISH_CONFIG .
  data GR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  data GR_OKCODE type ref to DATA .
  data GR_PARENT_SUBSCREEN type ref to DATA .
  data GR_SCREEN type ref to IF_ISH_SCREEN .
  data GR_CALLBACK type ref to IF_ISH_POPUP_CALLBACK .
  data GS_HANDLE_WARNING type RNWARNING .
  data GR_FUNC_01 type ref to DATA .
  data GR_FUNC_02 type ref to DATA .
  data GR_FUNC_03 type ref to DATA .

  methods BUILD_FUNCTIONS
    exporting
      value(ET_EXCL_FUNCTIONS) type ISH_T_EXCL_FUNC
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHANGE_FUNCTIONS_INTERNAL
    exporting
      value(ET_EXCL_FUNC) type ISH_T_EXCL_FUNC
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CT_NEW_FUNC) type ISH_T_FUNC optional
      value(CT_CHANGEABLE_FUNC) type ISH_T_FUNC optional
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_CHANGES_SCREENS
    exporting
      value(E_CHANGED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_SCREENS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CLEAR_OKCODE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods COUPLE .
  methods DISPLAY_MESSAGES
    importing
      value(IR_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING
      value(I_TOP) type I default 30
      value(I_LEFT) type I default 30
      value(I_AMODAL) type ISH_ON_OFF default ON
      value(I_HANDLE_WARNINGS) type ISH_ON_OFF default '*' .
  methods GET_SCREENS
    returning
      value(RT_SCREEN) type ISH_T_SCREEN_OBJECTS .
  methods HANDLE_MESSAGE_CLICK
    for event MESSAGE_CLICK of CL_ISHMED_ERRORHANDLING
    importing
      !E_MESSAGE .
  methods HANDLE_MESSAGE_FUNCTION
    for event MESSAGE_FUNCTION of CL_ISHMED_ERRORHANDLING
    importing
      !E_UCOMM .
  methods INITIALIZE_DYNNR
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_PARENT_SUBSCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_GUI_STATUS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_GUI_TITLE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_VCODE_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods START .
  methods TRANSPORT_FROM_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSPORT_TO_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods UCOMM_CHOICE
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_EXIT) type ISH_ON_OFF
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods USER_COMMAND_INTERNAL
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_EXIT) type ISH_ON_OFF
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_PRC_POPUP
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_PRC_POPUP IMPLEMENTATION.


METHOD build_functions .

* local tables
  DATA: lt_excl_func            TYPE ish_t_excl_func,
        lt_new_func             TYPE ish_t_func,
        lt_changeable_func      TYPE ish_t_func.
* field symbols
  FIELD-SYMBOLS:
        <ls_data>               TYPE smp_dyntxt.
* workareas
  DATA: ls_new_func             LIKE LINE OF lt_new_func,
        ls_chg_func             LIKE LINE OF lt_changeable_func,
        ls_excl                 LIKE LINE OF et_excl_functions.
* definitions
  DATA: l_rc                    TYPE ish_method_rc.
* object references
  DATA: lr_data                 TYPE REF TO data.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* set possible dynamic functions into table
  CLEAR: lt_new_func.
* ----------
  CLEAR: ls_new_func.
  ls_new_func-fcode = g_ucomm_01.
  INSERT ls_new_func INTO TABLE lt_new_func.
* ----------
  CLEAR: ls_new_func.
  ls_new_func-fcode = g_ucomm_02.
  INSERT ls_new_func INTO TABLE lt_new_func.
* ----------
  CLEAR: ls_new_func.
  ls_new_func-fcode = g_ucomm_03.
  INSERT ls_new_func INTO TABLE lt_new_func.
* ---------- ---------- ----------
* let configuration append, change, exclude functions
  IF NOT gr_config IS INITIAL.
    CALL METHOD gr_config->change_functions
      EXPORTING
        ir_main_object     = me
      IMPORTING
        et_excl_func       = lt_excl_func
        e_rc               = l_rc
      CHANGING
        ct_new_func        = lt_new_func
        ct_changeable_func = lt_changeable_func
        cr_errorhandler    = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------
* let subclasses append, change, exclude functions
  CALL METHOD me->change_functions_internal
    IMPORTING
      et_excl_func       = lt_excl_func
      e_rc               = l_rc
    CHANGING
      ct_new_func        = lt_new_func
      ct_changeable_func = lt_changeable_func
      cr_errorhandler    = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  LOOP AT lt_new_func INTO ls_new_func.
*   ----------
*   if dynamic function isn't active append
*   it to excluding functions
    IF ls_new_func-active = off.
      ls_excl-func = ls_new_func-fcode.
      INSERT ls_excl INTO TABLE lt_excl_func.
      CONTINUE.
    ENDIF.
*   ----------
    CASE ls_new_func-fcode.
      WHEN g_ucomm_01.
        lr_data = gr_func_01.
      WHEN g_ucomm_02.
        lr_data = gr_func_02.
      WHEN g_ucomm_03.
        lr_data = gr_func_03.
      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
    ASSIGN lr_data->* TO <ls_data>.
    IF sy-subrc = 0.
      <ls_data>-text         =  ls_new_func-ftext.
      <ls_data>-icon_id      =  ls_new_func-icon.
      <ls_data>-icon_text    =  ls_new_func-icon_text.
      <ls_data>-quickinfo    =  ls_new_func-icon_qinfo.
    ENDIF.
  ENDLOOP.
* ---------- ---------- ----------
* disable function choice in display mode
  IF g_vcode = co_vcode_display.
    ls_excl-func = g_ucomm_choice.
    INSERT ls_excl INTO TABLE lt_excl_func.
  ENDIF.
* ---------- ---------- ----------
* returnc excluding functions
  et_excl_functions = lt_excl_func.
* ---------- ---------- ----------

ENDMETHOD.


METHOD calculate_dynnr .

  DATA: l_dynnr(4)  TYPE n.

* handle special dynpros, which are not available in all combinations
  IF i_rows = 13 AND
     i_cols = 105.
    r_dynnr = '0611'.
    EXIT.
  ENDIF.

* Calculate the base:
*   rows<=4: 100
*         6: 200
*         8: 300
*        10: 400
*        12: 500
*        14: 600
*        16: 700
*        18: 800
*        20: 900
*        22: 1000
*        24: 1100
*        26: 1200
*        28: 1300
*        30: 1400
  IF i_rows <= 20.
    l_dynnr = 900.
  ELSE.
    l_dynnr = 1400.
  ENDIF.

* Calculate the rest:
*   cols<=10: base + 1
*         20: base + 2
*         30: base + 3
*         40: base + 4
*         50: base + 5
*         60: base + 6
*         70: base + 7
*         80: base + 8
*         90: base + 9
*        100: base + 10
*        110: base + 11
*        120: base + 12
  IF i_cols <= 50.
    l_dynnr = l_dynnr + 5.
  ELSEIF i_cols <= 110.
    l_dynnr = l_dynnr + 11.
  ELSE.
    l_dynnr = l_dynnr + 12.
  ENDIF.

  r_dynnr = l_dynnr.

ENDMETHOD.


METHOD change_functions_internal .

* no standard implementation (at the moment)
* redefine this method if you have any specialities

ENDMETHOD.


METHOD check_changes_screens.

  DATA: lt_screen  TYPE ish_t_screen_objects,
        lr_screen  TYPE REF TO if_ish_screen.

* Initilizations.
  e_rc      = 0.
  e_changed = off.

* No check_changes in display mode.
  CHECK NOT g_vcode = co_vcode_display.

* Get all screens.
  lt_screen = get_screens( ).

* Check changes of each screen.
  LOOP AT lt_screen INTO lr_screen.
    CHECK NOT lr_screen IS INITIAL.
    CALL METHOD lr_screen->check_changes
      IMPORTING
        e_rc           = e_rc
        e_changed      = e_changed
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF e_rc <> 0 OR
       e_changed = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD check_screens.

  DATA: lt_screen  TYPE ish_t_screen_objects,
        lr_screen  TYPE REF TO if_ish_screen.

* Initilizations.
  e_rc      = 0.

* No check in display mode.
  CHECK NOT g_vcode = co_vcode_display.

* Get all screens.
  lt_screen = get_screens( ).

* Check each screen.
  LOOP AT lt_screen INTO lr_screen.
    CHECK NOT lr_screen IS INITIAL.
    CALL METHOD lr_screen->check
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD clear_okcode .

  FIELD-SYMBOLS: <l_okcode>  TYPE sy-ucomm.

  CHECK gr_okcode IS BOUND.

* Assign the okcode.
  ASSIGN gr_okcode->* TO <l_okcode>.
  CHECK sy-subrc = 0.

* Clear the ok_code.
  CLEAR <l_okcode>.

ENDMETHOD.


METHOD constructor.

  gr_screen = ir_screen.

ENDMETHOD.


METHOD couple .

  CALL FUNCTION 'ISH_SDY_POPUP_INIT'
    EXPORTING
      ir_process          = me
    IMPORTING
      er_okcode           = gr_okcode
      er_parent_subscreen = gr_parent_subscreen
      er_func_01          = gr_func_01
      er_func_02          = gr_func_02
      er_func_03          = gr_func_03.

ENDMETHOD.


METHOD create .

  DATA: l_rc  TYPE ish_method_rc.

* Initializations.
  e_rc              = 0.
  e_created_by_badi = off.
  CLEAR er_prc_popup.

  CHECK NOT ir_screen IS INITIAL.

* Let the badi handle the creation.
  DO 1 TIMES.
*   Process the badi only if specified.
    CHECK i_use_badi = on.
*   Handle i_refresh_badi_instance.
    IF i_refresh_badi_instance = on.
      CLEAR gr_badi.
    ENDIF.
*   Load the badi instance if not already done.
    IF gr_badi IS INITIAL.
*     Check if the badi is active.
      CALL FUNCTION 'SXC_EXIT_CHECK_ACTIVE'
        EXPORTING
          exit_name  = 'N1_CREATE_PRC_POPUP'
        EXCEPTIONS
          not_active = 1
          OTHERS     = 2.
*     If the badi is not active do not process the badi.
      CHECK sy-subrc = 0.
*     Get instance of the BADI.
      CALL METHOD cl_exithandler=>get_instance
        EXPORTING
          exit_name                     = 'N1_CREATE_PRC_POPUP'
          null_instance_accepted        = on
        CHANGING
          instance                      = gr_badi
        EXCEPTIONS
          no_reference                  = 1
          no_interface_reference        = 2
          no_exit_interface             = 3
          class_not_implement_interface = 4
          single_exit_multiply_active   = 5
          cast_error                    = 6
          exit_not_existing             = 7
          data_incons_in_exit_managem   = 8
          OTHERS                        = 9.
      l_rc = sy-subrc.
      IF l_rc <> 0.
        CLEAR gr_badi.
*       Handle i_force_badi_errors.
        IF i_force_badi_errors = off.
          e_rc = l_rc.
*         BADI & kann nicht instanziert werden (Fehler &)
          CALL METHOD cl_ish_utl_base=>collect_messages
            EXPORTING
              i_typ           = 'E'
              i_kla           = 'N1BASE'
              i_num           = '029'
              i_mv1           = 'N1_CREATE_PRC_POPUP'
              i_mv2           = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          EXIT.
        ENDIF.
      ENDIF.
    ENDIF.
*   Process the badi.
    CHECK NOT gr_badi IS INITIAL.
    CALL METHOD gr_badi->create_prc_popup
      EXPORTING
        ir_screen         = ir_screen
        i_prc_object_type = i_prc_object_type
      IMPORTING
        er_prc_popup      = er_prc_popup
        e_rc              = l_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    IF l_rc <> 0.
      IF NOT er_prc_popup IS INITIAL.
        CALL METHOD er_prc_popup->destroy.
        CLEAR er_prc_popup.
      ENDIF.
      IF i_force_badi_errors = off.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.
    CHECK NOT er_prc_popup IS INITIAL.
*   Check the created object.
*   It has to inherit from the given object type.
    IF er_prc_popup->is_inherited_from( i_prc_object_type ) = off.
      CALL METHOD er_prc_popup->destroy.
      IF i_force_badi_errors = off.
        e_rc = 1.
*       BADI &1 lieferte falsches Objekt
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = '064'
            i_mv1           = 'N1_CREATE_PRC_POPUP'
          CHANGING
            cr_errorhandler = cr_errorhandler.
        EXIT.
      ENDIF.
    ENDIF.
  ENDDO.
  CHECK e_rc = 0.

* Further processing only if the badi did not create the object.
  IF NOT er_prc_popup IS INITIAL.
    e_created_by_badi = on.
    EXIT.
  ENDIF.

* Further processing only if specified.
  CHECK i_create_own = on.

  IF i_prc_class_name IS INITIAL AND
     ( i_prc_object_type IS INITIAL OR
       i_prc_object_type = co_otype_prc_popup ).
    i_prc_class_name = 'CL_ISH_PRC_POPUP'.
  ENDIF.

* Do own screen creation.
  CATCH SYSTEM-EXCEPTIONS dyn_call_meth_excp_not_found   = 1
                          dyn_call_meth_class_not_found  = 2
                          dyn_call_meth_classconstructor = 3
                          dyn_call_meth_constructor      = 4
                          dyn_call_meth_not_found        = 5
                          dyn_call_meth_no_class_method  = 6
                          dyn_call_meth_private          = 7
                          dyn_call_meth_protected        = 8
                          dyn_call_meth_param_kind       = 9
                          dyn_call_meth_param_litl_move  = 10
                          dyn_call_meth_param_tab_type   = 11
                          dyn_call_meth_param_type       = 12
                          dyn_call_meth_param_missing    = 13
                          dyn_call_meth_parref_initial   = 14
                          dyn_call_meth_param_not_found  = 15
                          dyn_call_meth_ref_is_initial   = 16.
    CREATE OBJECT er_prc_popup TYPE (i_prc_class_name)
      EXPORTING
        ir_screen = ir_screen.
  ENDCATCH.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    IF NOT er_prc_popup IS INITIAL.
      CALL METHOD er_prc_popup->destroy.
      CLEAR er_prc_popup.
    ENDIF.
    e_rc = l_rc.
*   Objekt der Klasse &1 kann nicht instanziert werden (Fehler &2)
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '065'
        i_mv1           = i_prc_class_name
        i_mv2           = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Export.
  e_created_by_badi = off.

ENDMETHOD.


METHOD display_messages.

  DATA: l_display_messages      TYPE ish_on_off.

  FIELD-SYMBOLS: <l_okcode>  TYPE sy-ucomm.

  CHECK gr_okcode IS BOUND.
  ASSIGN gr_okcode->* TO <l_okcode>.

  IF i_handle_warnings = '*'.
    i_handle_warnings = gs_handle_warning-accept.
  ENDIF.

* handle warnings
  IF i_handle_warnings = on.
    CALL METHOD cl_ish_utl_base=>handle_warnings
      EXPORTING
        ir_errorhandler    = ir_errorhandler
        i_okcode           = <l_okcode>
        i_ignore_object    = on
      IMPORTING
        e_display_messages = l_display_messages
      CHANGING
        cs_handle_warning  = gs_handle_warning.
    IF l_display_messages = on.
      g_abort_because_of_warnings = on.
    ENDIF.
    CHECK l_display_messages = on.
  ENDIF.
* ---------- ----------

* display

  IF ir_errorhandler <> gr_errorhandler AND
     NOT gr_errorhandler IS INITIAL.

    CALL METHOD gr_errorhandler->copy_messages
      EXPORTING
        i_copy_from = ir_errorhandler.

  ENDIF.

  CHECK NOT gr_errorhandler IS INITIAL.

  CALL METHOD gr_errorhandler->display_messages
    EXPORTING
      i_top         = i_top
      i_left        = i_left
      i_amodal      = i_amodal
      i_send_if_one = on
      i_control     = off.
* ---------- ----------

ENDMETHOD.


METHOD get_container_name .

  DATA: l_dynnr     TYPE sy-dynnr,
        l_numc4(4)  TYPE n.

* Calculate a dynnr.
  l_dynnr = calculate_dynnr( i_rows = i_rows
                             i_cols = i_columns ).

  l_numc4 = l_dynnr.
  l_numc4 = l_numc4 + 1000.
  l_dynnr = l_numc4.

* Now set the container name.
  CONCATENATE 'CC_POPUP_'
              l_dynnr
         INTO r_container_name.

ENDMETHOD.


METHOD get_screens.

  DATA: l_rc  TYPE ish_method_rc.

* Initializations.
  CLEAR rt_screen.

  CHECK NOT gr_screen IS INITIAL.

  CALL METHOD cl_ish_utl_screen=>get_screen_instances
    EXPORTING
      i_screen          = gr_screen
      i_embedded_scr    = on
      i_only_next_level = off
    IMPORTING
      et_screens        = rt_screen
      e_rc              = l_rc.
  IF l_rc <> 0.
    CLEAR rt_screen.
    APPEND gr_screen TO rt_screen.
  ENDIF.

ENDMETHOD.


METHOD handle_message_click.

  DATA: lt_screen     TYPE ish_t_screen_objects,
        lr_screen     TYPE REF TO if_ish_screen,
        l_cursor_set  TYPE ish_on_off.

* Inform the screens about the message to set the cursor.
  lt_screen = get_screens( ).
  LOOP AT lt_screen INTO lr_screen.
    CHECK NOT lr_screen IS INITIAL.
    CALL METHOD lr_screen->set_cursor
      EXPORTING
        i_rn1message = e_message
        i_set_cursor = off
      IMPORTING
        e_cursor_set = l_cursor_set.
    IF l_cursor_set = on.
      EXIT.
    ENDIF.
  ENDLOOP.

* If any screen set the cursor
* we raise ok_code CRSPOS.
  CALL METHOD cl_gui_cfw=>set_new_ok_code
    EXPORTING
      new_code = g_ucomm_crspos.

ENDMETHOD.


METHOD handle_message_function.

* Handle warning ignoring.

  CHECK e_ucomm = 'MSG_ENTER'.

* ignore warnings
  gs_handle_warning-accept = on.

* executing the function done before accepting the warnings
  CALL METHOD cl_gui_cfw=>set_new_ok_code
    EXPORTING
      new_code = gs_handle_warning-okcode.


ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_prc_popup.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_object_type  TYPE i.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF l_object_type = co_otype_prc_popup.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_prc_popup.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_prc_popup~after_pai.

* Transport data from screen.
  CALL METHOD transport_from_screen.

ENDMETHOD.


METHOD if_ish_prc_popup~after_pbo.

  e_rc = 0.

  CLEAR g_abort_because_of_warnings.

  IF NOT gr_errorhandler IS INITIAL.
    CALL METHOD me->display_messages
      EXPORTING
        ir_errorhandler = gr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD if_ish_prc_popup~before_pai_subscreen.

* Initializations.
  e_rc = 0.

  CHECK NOT gr_screen IS INITIAL.

* Couple the screen with its function group.
  CALL METHOD gr_screen->before_call_subscreen
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_prc_popup~before_pbo_subscreen.

* Initializations.
  e_rc = 0.

  CHECK NOT gr_screen IS INITIAL.

* Couple the screen with its function group.
  CALL METHOD gr_screen->before_call_subscreen
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_prc_popup~check.

  DATA: l_rc            TYPE ish_method_rc,
        l_max_errortype TYPE text15.

* Initializations.
  e_rc = 0.

* No check_changes in display mode.
  CHECK NOT g_vcode = co_vcode_display.

* Check the screen.
  CALL METHOD check_screens
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Integrate the callback object.
  IF NOT gr_callback IS INITIAL.
    CALL METHOD gr_callback->check
      EXPORTING
        ir_prc_popup    = me
        ir_screen       = gr_screen
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

  IF g_exit_on_warnings = off.
    CALL METHOD cr_errorhandler->get_max_errortype
      IMPORTING
        e_max_errortype = l_max_errortype.
    IF l_max_errortype = 'W'.

      CALL METHOD me->display_messages
        EXPORTING
          ir_errorhandler   = cr_errorhandler
          i_handle_warnings = on.

      IF g_abort_because_of_warnings = on.
        e_rc = 77.
      ELSE.
        e_rc = 0.
      ENDIF.
    ELSEIF l_max_errortype = 'A' OR
           l_max_errortype = 'E' OR
           l_max_errortype = 'X'.
      IF e_rc = 0.
        e_rc = 1.
      ENDIF.
    ENDIF.
  ELSE.
    CALL METHOD cr_errorhandler->get_max_errortype
      IMPORTING
        e_max_errortype = l_max_errortype.
    IF l_max_errortype = 'W'.
      e_rc = 0.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_prc_popup~check_changes.

* Initializations.
  e_rc = 0.
  e_changed = off.

* No check_changes in display mode.
  CHECK NOT g_vcode = co_vcode_display.

* Check sy-datar.
  IF sy-datar = on.
    e_changed = on.
    EXIT.
  ENDIF.

* check_changes of screen.
  CALL METHOD check_changes_screens
    IMPORTING
      e_rc            = e_rc
      e_changed       = e_changed
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK e_changed = off.

* Integrate the callback object.
  IF NOT gr_callback IS INITIAL.
    CALL METHOD gr_callback->check_changes
      EXPORTING
        ir_prc_popup    = me
        ir_screen       = gr_screen
      IMPORTING
        e_changed       = e_changed
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK e_changed = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_prc_popup~collect_messages.

  CHECK NOT ir_errorhandler IS INITIAL.

* Initializations.
  IF gr_errorhandler IS INITIAL.
    CREATE OBJECT gr_errorhandler.
  ENDIF.

* Append messages from ir_errorhandler to gr_errorhandler.
  CALL METHOD gr_errorhandler->copy_messages
    EXPORTING
      i_copy_from = ir_errorhandler.

ENDMETHOD.


METHOD if_ish_prc_popup~destroy.

  DATA: l_rc  TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Destroy the screen.
  IF g_own_screen = on AND
     NOT gr_screen IS INITIAL.
    CALL METHOD gr_screen->destroy
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

* Clear own attributes.
  CLEAR: g_startpos_col,
         g_startpos_row,
         g_own_screen,
         g_endpos_col,
         g_endpos_row,
         g_vcode,
         gr_screen.

* Deactivate the errorhandling.
  IF NOT gr_errorhandler IS INITIAL.
    SET HANDLER handle_message_click
      FOR gr_errorhandler
      ACTIVATION off.
    SET HANDLER handle_message_function
      FOR gr_errorhandler
      ACTIVATION off.
  ENDIF.
  CLEAR gr_errorhandler.

ENDMETHOD.


METHOD if_ish_prc_popup~exit_command.

  DATA: l_changed          TYPE ish_on_off,
        l_exit             TYPE ish_on_off,
        l_answer(1)        TYPE c.

* Initializations.
  e_rc        = 0.
  e_exit      = on.
  g_cancelled = on.

* initialize errorhandler
  IF NOT gr_errorhandler IS INITIAL.
    CALL METHOD gr_errorhandler->initialize( ).
  ENDIF.

* No further processing in display mode.
  CHECK NOT g_vcode = co_vcode_display.

* Integrate the callback object.
  IF NOT gr_callback IS INITIAL.
    l_exit = off.
    CALL METHOD gr_callback->exit_command
      EXPORTING
        ir_prc_popup    = me
      IMPORTING
        e_exit          = l_exit
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
*   Leave if the callback object specified.
    CHECK l_exit = off.
  ENDIF.

  CHECK get_check_changes_on_cancel( ) = on.

* Check for changes.
  CALL METHOD check_changes
    IMPORTING
      e_changed       = l_changed
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* No changes? -> exit.
  CHECK l_changed = on.

* Changes? -> ask for confirmation.
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      diagnose_object       = 'ISH_INP_CANCEL'
      text_question         = 'Möchten Sie wirklich abbrechen?'(001)
      default_button        = '2'                     " No
      display_cancel_button = ' '
      popup_type            = 'ICON_MESSAGE_WARNING'
    IMPORTING
      answer                = l_answer
    EXCEPTIONS
      text_not_found        = 1
      OTHERS                = 2.
  e_rc = sy-subrc.
  CHECK e_rc = 0.
  CHECK NOT l_answer = 1.

* no Exit.
  e_exit      = off.
  g_cancelled = off.

ENDMETHOD.


METHOD if_ish_prc_popup~get_callback.

  rr_callback = gr_callback.

ENDMETHOD.


METHOD if_ish_prc_popup~get_check_changes_on_cancel.

  r_check_changes = g_check_changes_on_cancel.

ENDMETHOD.


METHOD if_ish_prc_popup~get_check_on_choice.

  r_check = g_check_on_choice.

ENDMETHOD.


METHOD if_ish_prc_popup~get_config.

  rr_config = gr_config.

ENDMETHOD.


METHOD if_ish_prc_popup~get_exit_on_warnings.

  r_exit = g_exit_on_warnings.

ENDMETHOD.


METHOD if_ish_prc_popup~get_popup_position.

  e_startpos_col = g_startpos_col.
  e_startpos_row = g_startpos_row.
  e_endpos_col   = g_endpos_col.
  e_endpos_row   = g_endpos_row.

ENDMETHOD.


METHOD if_ish_prc_popup~get_popup_title.

  r_popup_title = g_popup_title.

ENDMETHOD.


METHOD if_ish_prc_popup~get_screen.

  rr_screen = gr_screen.

ENDMETHOD.


METHOD if_ish_prc_popup~get_vcode.

  r_vcode = g_vcode.

ENDMETHOD.


METHOD if_ish_prc_popup~initialize.

* Initializations.
  e_rc = 0.
  clear gs_handle_warning.
  clear g_abort_because_of_warnings.

* Handle parameters.
  g_popup_title              = i_popup_title.
  g_check_changes_on_cancel  = i_check_changes_on_cancel.
  g_check_on_choice          = i_check_on_choice.
  g_exit_on_warnings         = i_exit_on_warnings.
  gr_config                  = ir_config.
  g_startpos_col             = i_startpos_col.
  g_startpos_row             = i_startpos_row.
  g_endpos_col               = i_endpos_col.
  g_endpos_row               = i_endpos_row.
  g_vcode                    = i_vcode.
  gr_callback                = ir_callback.

* Initialize the errorhandling.
  CREATE OBJECT gr_errorhandler.
  SET HANDLER handle_message_click
    FOR gr_errorhandler
    ACTIVATION on.
  SET HANDLER handle_message_function
    FOR gr_errorhandler
    ACTIVATION on.

ENDMETHOD.


METHOD if_ish_prc_popup~pai.

  DATA: l_init_errorhandler  TYPE ish_on_off,
        l_hide_errorhandler  TYPE ish_on_off,
        l_rc                 TYPE ish_method_rc.

  FIELD-SYMBOLS: <l_okcode>  TYPE sy-ucomm.

* Handle gr_errorhandler.
  IF gr_errorhandler IS INITIAL.
    l_init_errorhandler = off.
    l_hide_errorhandler = off.
  ELSE.
    l_init_errorhandler = on.
    l_hide_errorhandler = on.
*   On cursor positioning do not clear the errorhandler.
    IF gr_okcode IS BOUND.
      ASSIGN gr_okcode->* TO <l_okcode>.
      IF <l_okcode> = g_ucomm_crspos.
        l_init_errorhandler = off.
        l_hide_errorhandler = off.
      ENDIF.
    ENDIF.
  ENDIF.
  IF l_hide_errorhandler = on.
    CALL METHOD cl_ishmed_errorhandling=>set_visible
      EXPORTING
        i_visible = off.
  ENDIF.
  IF l_init_errorhandler = on.
    CALL METHOD gr_errorhandler->initialize.
  ENDIF.

  CHECK NOT gr_screen IS INITIAL.

* PAI for control screens.
  IF gr_screen->is_inherited_from(
            cl_ish_scr_control=>co_otype_scr_control ) = on.
    CALL METHOD gr_screen->process_after_input
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_prc_popup~pbo.

  DATA: l_rc       TYPE ish_method_rc.

  CHECK NOT gr_screen IS INITIAL.

* Clear the ok_code.
  CALL METHOD clear_okcode.

* Set title.
  CALL METHOD set_gui_title.

* Set status.
  CALL METHOD set_gui_status.

* Transport data to screen.
  CALL METHOD transport_to_screen.

* PBO for control screens.
  IF gr_screen->is_inherited_from(
            cl_ish_scr_control=>co_otype_scr_control ) = on.
    CALL METHOD gr_screen->process_before_output
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_prc_popup~run.

* Initializations.
  e_rc = 0.

  CHECK NOT gr_screen IS INITIAL.

* Set vcode in the screen.
  CALL METHOD me->set_vcode_screen
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Couple self with the function group.
  CALL METHOD couple.

* Decide which dynpro to use.
  CALL METHOD initialize_dynnr
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Initialize gr_parent_subscreen
  CALL METHOD initialize_parent_subscreen
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Start the popup.
  CALL METHOD start.

* Export.
  e_cancelled = g_cancelled.

* initialize errorhandler, when warnings were handled
  IF g_exit_on_warnings = off.
    CALL METHOD gr_errorhandler->initialize( ).
  ENDIF.

* export messages to calling errorhandler.
  IF NOT gr_errorhandler IS INITIAL.
    IF cr_errorhandler IS INITIAL.
      CREATE OBJECT cr_errorhandler.
    ENDIF.
    CALL METHOD cr_errorhandler->copy_messages
      EXPORTING
        i_copy_from = gr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD if_ish_prc_popup~user_command.

  DATA: lt_screen  TYPE ish_t_screen_objects,
        lr_screen  TYPE REF TO if_ish_screen.

  FIELD-SYMBOLS: <l_okcode>  TYPE sy-ucomm.

* Initializations.
  e_rc   = 0.
  e_exit = off.

* Start the event handling.
  cl_gui_cfw=>dispatch( ).

  CHECK gr_okcode IS BOUND.

* Assign the okcode.
  ASSIGN gr_okcode->* TO <l_okcode>.
  CHECK sy-subrc = 0.

* Integrate the callback object.
  IF NOT gr_callback IS INITIAL.
    CALL METHOD gr_callback->user_command
      EXPORTING
        ir_prc_popup    = me
      IMPORTING
        e_exit          = e_exit
        e_rc            = e_rc
      CHANGING
        c_okcode        = <l_okcode>
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
*   Leave if the callback object handled the okcode.
    CHECK NOT <l_okcode> IS INITIAL.
*   Leave if the callback object specified.
    CHECK e_exit = off.
  ENDIF.

* Let the configuration handle the okcode.
  IF NOT gr_config IS INITIAL.
    CALL METHOD gr_config->ok_code
      EXPORTING
        ir_object       = me
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler
        c_okcode        = <l_okcode>.
    CHECK e_rc = 0.
*   Leave if the config handled the okcode.
    CHECK NOT <l_okcode> IS INITIAL.
  ENDIF.

* Let the screens handle the okcode.
  lt_screen = get_screens( ).
  LOOP AT lt_screen INTO lr_screen.
    CHECK NOT lr_screen IS INITIAL.
    CALL METHOD lr_screen->ok_code_screen
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler
        c_okcode       = <l_okcode>.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
*   Leave if the screen handled the okcode.
    IF <l_okcode> IS INITIAL.
      EXIT.
    ENDIF.
  ENDLOOP.
  CHECK e_rc = 0.
* Leave if any screen handled the okcode.
  CHECK NOT <l_okcode> IS INITIAL.

* Handle the ok_code.
  CASE <l_okcode>.
    WHEN g_ucomm_choice.
      CALL METHOD ucomm_choice
        IMPORTING
          e_rc            = e_rc
          e_exit          = e_exit
        CHANGING
          cr_errorhandler = cr_errorhandler.
    WHEN OTHERS.
      CALL METHOD user_command_internal
        IMPORTING
          e_rc            = e_rc
          e_exit          = e_exit
        CHANGING
          cr_errorhandler = cr_errorhandler.
  ENDCASE.

ENDMETHOD.


METHOD initialize_dynnr.

  DATA: ls_dynpro_header  TYPE rpy_dyhead,
        ls_parent         TYPE rnscr_parent,
        l_suffix1         TYPE string,
        l_suffix2         TYPE string,
        l_rows            TYPE i,
        l_cols            TYPE i.

  CHECK NOT gr_screen IS INITIAL.

* The calculation depends on gr_screen.
  IF gr_screen->is_inherited_from(
            cl_ish_scr_control=>co_otype_scr_control ) = on.
*   g_dynnr for control screens is calculated via the container_name.
    CALL METHOD gr_screen->get_parent
      IMPORTING
        es_parent = ls_parent.
    SPLIT ls_parent-container_name
      AT   '_'
      INTO l_suffix1
           l_suffix2
           g_dynnr.
  ELSE.
*   g_dynnr for subscreens is calculated via the subscreen dynpro.
    ls_dynpro_header = gr_screen->get_dynpro_header( ).
    l_rows = ls_dynpro_header-lines.
    l_cols = ls_dynpro_header-columns.
    g_dynnr = calculate_dynnr( i_rows = l_rows
                               i_cols = l_cols ).
  ENDIF.

ENDMETHOD.


METHOD initialize_parent_subscreen .

  DATA: ls_parent         TYPE rnscr_parent.

  FIELD-SYMBOLS: <ls_parent>  TYPE rnscr_parent.

  CHECK gr_parent_subscreen IS BOUND.

* Assign the parent.
  ASSIGN gr_parent_subscreen->* TO <ls_parent>.

* Initialize parent.
  CLEAR <ls_parent>.
  <ls_parent>-repid = 'SAPLNSC1'.
  <ls_parent>-dynnr = '0001'.

  CHECK NOT gr_screen IS INITIAL.

* Get and set the screen parent.
  CALL METHOD gr_screen->get_parent
    IMPORTING
      es_parent = ls_parent.
  <ls_parent> = ls_parent.

ENDMETHOD.


METHOD set_gui_status.

* local tables
  DATA: lt_excl_func            TYPE ish_t_excl_func.
* definitions
  DATA: l_rc                    TYPE ish_method_rc.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* build functions
  CALL METHOD me->build_functions
    IMPORTING
      et_excl_functions = lt_excl_func
      e_rc              = l_rc
    CHANGING
      c_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* set cua
  SET PF-STATUS '0100' OF PROGRAM 'SAPLN1_SDY_POPUP'
      EXCLUDING lt_excl_func.
* ---------- ---------- ----------

ENDMETHOD.


METHOD set_gui_title.

  DATA: l_popup_title TYPE char70.

* get the userdefined title
  l_popup_title = get_popup_title( ).

* when the userdefined title is initial -> take the title
* from the application before
  IF l_popup_title IS INITIAL.
    SET TITLEBAR '0100' OF PROGRAM 'SAPLN1_SDY_POPUP' WITH sy-title.
  ELSE.
   SET TITLEBAR '0100' OF PROGRAM 'SAPLN1_SDY_POPUP' WITH l_popup_title.
  ENDIF.

ENDMETHOD.


METHOD set_vcode_screen.

* Initializations.
  e_rc = 0.

  CHECK NOT gr_screen IS INITIAL.

* Set vcode in the screen.
  IF NOT g_vcode   IS INITIAL.
    CALL METHOD gr_screen->set_data
      EXPORTING
        i_vcode   = g_vcode
        i_vcode_x = on.
  ENDIF.

ENDMETHOD.


METHOD show_popup .

  DATA: lr_process  TYPE REF TO if_ish_prc_popup,
        l_rc        TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Create the process.
  CALL METHOD cl_ish_prc_popup=>create
    EXPORTING
      ir_screen         = ir_screen
      i_prc_class_name  = i_prc_class_name
      i_prc_object_type = i_prc_object_type
    IMPORTING
      er_prc_popup      = lr_process
      e_rc              = l_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.
  CHECK NOT lr_process IS INITIAL.

* Initialize the process.
  IF e_rc = 0.
    CALL METHOD lr_process->initialize
      EXPORTING
        i_popup_title             = i_popup_title
        i_check_changes_on_cancel = i_check_changes_on_cancel
        i_check_on_choice         = i_check_on_choice
        i_exit_on_warnings        = i_exit_on_warnings
        ir_config                 = ir_config
        i_startpos_col            = i_startpos_col
        i_startpos_row            = i_startpos_row
        i_endpos_col              = i_endpos_col
        i_endpos_row              = i_endpos_row
        i_vcode                   = i_vcode
        ir_callback               = ir_callback
      IMPORTING
        e_rc                      = l_rc
      CHANGING
        cr_errorhandler           = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

* Run the process.
  IF e_rc = 0.
    CALL METHOD lr_process->run
      IMPORTING
        e_cancelled     = e_cancelled
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

* Destroy the process.
  CALL METHOD lr_process->destroy
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


METHOD start.

  CALL FUNCTION 'ISH_SDY_POPUP_RUN'
    EXPORTING
      i_dynnr        = g_dynnr
      i_startpos_col = g_startpos_col
      i_startpos_row = g_startpos_row
      i_endpos_col   = g_endpos_col
      i_endpos_row   = g_endpos_row.

ENDMETHOD.


METHOD transport_from_screen.

* Initializations.
  e_rc = 0.

* No screen -> no transport.
  CHECK NOT gr_screen IS INITIAL.

* Integrate the callback object.
  IF NOT gr_callback IS INITIAL.
    CALL METHOD gr_callback->transport_from_screen
      EXPORTING
        ir_prc_popup    = me
        ir_screen       = gr_screen
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD transport_to_screen.

* Initializations.
  e_rc = 0.

* No screen -> no transport.
  CHECK NOT gr_screen IS INITIAL.

* Integrate the callback object.
  IF NOT gr_callback IS INITIAL.
    CALL METHOD gr_callback->transport_to_screen
      EXPORTING
        ir_prc_popup    = me
        ir_screen       = gr_screen
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD ucomm_choice .

  DATA: l_max_errortype  TYPE text15.

* Initializations.
  e_rc   = 0.
  e_exit = off.

* Check if specified.
  IF g_check_on_choice = on.
    CALL METHOD check
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Exit.
  e_exit = on.

ENDMETHOD.


METHOD user_command_internal.

* Empty implementation in base class
* Redefine in subclasses if necessary

ENDMETHOD.
ENDCLASS.
