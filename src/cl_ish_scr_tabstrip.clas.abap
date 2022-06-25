class CL_ISH_SCR_TABSTRIP definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

*"* public components of class CL_ISH_SCR_TABSTRIP
*"* do not include other source files here!!!
public section.

  constants CO_MAX_DYNNR type I value 20. "#EC NOTEXT
  constants CO_MAX_TSPB type I value 20. "#EC NOTEXT
  constants CO_TSPB_PREFIX type ISH_FIELDNAME value 'TSPB_TAB'. "#EC NOTEXT
  constants CO_FIELDNAME_SUBSCREEN type ISH_FIELDNAME value 'SC_TABSTRIP'. "#EC NOTEXT
  constants CO_OTYPE_SCR_TABSTRIP type ISH_OBJECT_TYPE value 7039. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      value(I_DYNNR) type SY-DYNNR .
  class-methods CLASS_CONSTRUCTOR .
  class-methods CHECKOUT
    exporting
      !ER_SCR_TABSTRIP type ref to CL_ISH_SCR_TABSTRIP
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CLEAR_ALL_TSPB .
  methods GET_SUBSCREEN
    exporting
      !ER_SCREEN type ref to IF_ISH_SCREEN
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_TSPB_NAME
    importing
      value(I_IDX) type I
    returning
      value(R_NAME) type ISH_FIELDNAME .
  methods GET_TSPB_UCOMM
    importing
      value(I_IDX) type I
    returning
      value(R_UCOMM) type SY-UCOMM .
  methods PAI_SUBSCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PBO_SUBSCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_SUBSCREEN
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_TSPB
    importing
      value(I_IDX) type I
      value(I_TITLE) type TEXT100 optional
      value(I_TITLE_X) type ISH_ON_OFF default OFF
      value(I_ACTIVE) type ISH_ON_OFF optional
      value(I_ACTIVE_X) type ISH_ON_OFF default OFF
      value(I_INPUT) type ISH_ON_OFF optional
      value(I_INPUT_X) type ISH_ON_OFF default OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~CLEAR_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~GET_ACTIVE_TABSTRIP
    redefinition .
  methods IF_ISH_SCREEN~GET_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~GET_DEFAULT_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~REMIND_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~SET_ACTIVE_TABSTRIP
    redefinition .
  methods IF_ISH_SCREEN~SET_CURSOR
    redefinition .
  methods IF_ISH_SCREEN~SET_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_TABSTRIP
*"* do not include other source files here!!!

  data G_SET_FIRST_CURSORFIELD type ISH_ON_OFF value off .
  class-data GT_FREE_DYNNR type ISH_T_DYNNR .
  data GR_TS_TABSTRIP type ref to DATA .
  data GR_DYNPG_SUBSCREEN type ref to DATA .
  data GR_DYNNR_SUBSCREEN type ref to DATA .
  data GT_TSPB type ISH_T_TSPB .

  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods MODIFY_SCREEN_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_TABSTRIP
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_TABSTRIP IMPLEMENTATION.


METHOD checkout .

  DATA: l_dynnr          TYPE sy-dynnr,
        lr_scr_tabstrip  TYPE REF TO cl_ish_scr_tabstrip.

* Initializations.
  CLEAR: e_rc,
         er_scr_tabstrip.

* Get the next free dynnr.
  READ TABLE gt_free_dynnr INDEX 1 INTO l_dynnr.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* The dynnr is not free no more.
  DELETE TABLE gt_free_dynnr FROM l_dynnr.

* Create a new tabstrip object.
  CREATE OBJECT er_scr_tabstrip
    EXPORTING
      i_dynnr = l_dynnr.

ENDMETHOD.


METHOD class_constructor .

  DATA: l_dynnr  TYPE sy-dynnr.

  l_dynnr = '100'.
  DO co_max_dynnr TIMES.
    APPEND l_dynnr TO gt_free_dynnr.
    l_dynnr = l_dynnr + 1.
  ENDDO.

ENDMETHOD.


METHOD clear_all_tspb .

  FIELD-SYMBOLS: <ls_tspb>  TYPE rn1_tspb.

  LOOP AT gt_tspb assigning <ls_tspb>.
    CLEAR <ls_tspb>-title.
    <ls_tspb>-active = off.
  ENDLOOP.

ENDMETHOD.


METHOD constructor .

  DATA: ls_tspb  TYPE rn1_tspb.

* super constructor.
  CALL METHOD super->constructor.

* Set parent.
  CLEAR gs_parent.
  gs_parent-repid = 'SAPLN1_SDY_TABSTRIP'.
  gs_parent-dynnr = i_dynnr.
  gs_parent-type  = co_scr_parent_type_dynpro.

* Build gt_tspb.
  DO co_max_tspb TIMES.
    APPEND ls_tspb TO gt_tspb.
  ENDDO.

ENDMETHOD.


METHOD get_subscreen .

  DATA: ls_field_val  TYPE rnfield_value.

* Initializations.
  CLEAR: e_rc,
         er_screen.

  CHECK NOT gr_screen_values IS INITIAL.

* Get field value for subscreen.
  CALL METHOD gr_screen_values->get_data
    EXPORTING
      i_fieldname    = co_fieldname_subscreen
      i_type         = co_fvtype_screen
    IMPORTING
      e_field_value  = ls_field_val
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Export subscreen.
  er_screen ?= ls_field_val-object.

ENDMETHOD.


METHOD get_tspb_name .

  DATA: l_idx_string  TYPE string.

  l_idx_string = i_idx.

  CONCATENATE co_tspb_prefix
              l_idx_string
         INTO r_name.
  CONDENSE r_name NO-GAPS.

ENDMETHOD.


METHOD get_tspb_ucomm .

  DATA: l_tspb_name  TYPE ish_fieldname.

* Get technical name of ir_tspb.
  l_tspb_name = get_tspb_name( i_idx ).
  CHECK NOT l_tspb_name IS INITIAL.

* Build r_ucomm.
  CONCATENATE l_tspb_name
              gs_parent-dynnr
         INTO r_ucomm
    SEPARATED BY '_'.
  CONDENSE r_ucomm NO-GAPS.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_scr_tabstrip.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_tabstrip.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~clear_cursorfield .

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        l_rc       TYPE ish_method_rc.

* Get subscreen.
  CALL METHOD get_subscreen
    IMPORTING
      er_screen = lr_screen
      e_rc      = l_rc.
  CHECK l_rc = 0.
  CHECK NOT lr_screen IS INITIAL.

* Wrap to subscreen.
  CALL METHOD lr_screen->clear_cursorfield.

ENDMETHOD.


METHOD if_ish_screen~destroy .

* Free the dynnr.
  READ TABLE gt_free_dynnr FROM gs_parent-dynnr TRANSPORTING NO FIELDS.
  IF sy-subrc <> 0.
    APPEND gs_parent-dynnr TO gt_free_dynnr.
  ENDIF.

* super destroy.
  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~get_active_tabstrip .

  FIELD-SYMBOLS: <l_ts>  TYPE ANY.

* e_active_tabstrip.
  IF gr_ts_tabstrip IS BOUND.
    ASSIGN gr_ts_tabstrip->* TO <l_ts>.
    e_active_tabstrip = <l_ts>.
  ENDIF.

* e_pgm + e_dynnr.
  e_pgm   = gs_parent-repid.
  e_dynnr = gs_parent-dynnr.

* e_tabstrip_subscreen.
  CALL METHOD get_subscreen
    IMPORTING
      er_screen = e_tabstrip_subscreen.

ENDMETHOD.


METHOD if_ish_screen~get_cursorfield .

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        l_rc       TYPE ish_method_rc.

* Get subscreen.
  CALL METHOD get_subscreen
    IMPORTING
      er_screen = lr_screen
      e_rc      = l_rc.
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

* Get subscreen.
  CALL METHOD get_subscreen
    IMPORTING
      er_screen = lr_screen
      e_rc      = l_rc.
  CHECK l_rc = 0.
  CHECK NOT lr_screen IS INITIAL.

* Wrap to subscreen.
  CALL METHOD lr_screen->get_default_cursorfield
    IMPORTING
      e_cursorfield = e_cursorfield
      er_screen     = er_screen.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen .

  DATA: l_idx    TYPE i,
        l_ucomm  TYPE sy-ucomm.

  FIELD-SYMBOLS: <ls_tspb>  TYPE rn1_tspb,
                 <l_ts>     TYPE ANY.

* Initializations.
  e_rc = 0.

* Get the pressed tabstrip pushbutton.
  l_idx = 0.
  LOOP AT gt_tspb ASSIGNING <ls_tspb>.
*   Iterate.
    l_idx = l_idx + 1.
    CHECK NOT <ls_tspb>-r_tspb IS INITIAL.
*   Get the tabstrip pushbutton ucomm.
    l_ucomm = get_tspb_ucomm( l_idx ).
    CHECK c_okcode = l_ucomm.
*   Set active tab.
    set_active_tabstrip( l_ucomm ).
    CLEAR c_okcode.
*   Clear all cursorfields and set flag to position cursor.
    RAISE EVENT ev_clear_all_cursorfields.
    g_set_first_cursorfield = on.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_screen~remind_cursorfield .

* Not needed.

ENDMETHOD.


METHOD if_ish_screen~set_active_tabstrip .

  FIELD-SYMBOLS: <l_ts>  TYPE ANY.

  IF gr_ts_tabstrip IS BOUND.
    ASSIGN gr_ts_tabstrip->* TO <l_ts>.
    <l_ts> = i_active_tabstrip.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~set_cursor .

  DATA: l_cursorfield  TYPE ish_fieldname,
        lr_screen      TYPE REF TO if_ish_screen.

* Process only if cursor should be possitioned.
  CHECK g_set_first_cursorfield = on.
  g_set_first_cursorfield = off.

* Handle default positioning only if ther is no error.
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

* Get subscreen.
  CALL METHOD get_subscreen
    IMPORTING
      er_screen = lr_screen
      e_rc      = l_rc.
  CHECK l_rc = 0.
  CHECK NOT lr_screen IS INITIAL.

* Wrap to subscreen.
  CALL METHOD lr_screen->set_cursorfield
    EXPORTING
      i_cursorfield = i_cursorfield.

ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .

  DATA: lt_tspb  TYPE ish_t_ref_data,
        lr_tspb  TYPE n1_ref_data.

  FIELD-SYMBOLS: <ls_tspb>  TYPE rn1_tspb.

* Couple self with function group.
  CALL FUNCTION 'ISH_SDY_TABSTRIP_INIT'
    EXPORTING
      ir_scr_tabstrip    = me
    IMPORTING
      er_ts_tabstrip     = gr_ts_tabstrip
      er_dynpg_subscreen = gr_dynpg_subscreen
      er_dynnr_subscreen = gr_dynnr_subscreen
      et_tspb            = lt_tspb
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

* Handle tabstrip pushbuttons.
  LOOP AT gt_tspb ASSIGNING <ls_tspb>.
    READ TABLE lt_tspb INTO lr_tspb INDEX sy-tabix.
    IF sy-subrc = 0.
      <ls_tspb>-r_tspb = lr_tspb.
    ELSE.
      CLEAR <ls_tspb>-r_tspb.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy .

  FIELD-SYMBOLS: <l_tspb>   TYPE ANY,
                 <ls_tspb>  TYPE rn1_tspb.

* Set tabstrip-pushbutton's text.
  LOOP AT gt_tspb ASSIGNING <ls_tspb>.
    IF <ls_tspb>-r_tspb IS BOUND.
      ASSIGN <ls_tspb>-r_tspb->* TO <l_tspb>.
      <l_tspb> = <ls_tspb>-title.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD initialize_field_values .

  DATA: ls_field_val  TYPE rnfield_value,
        lt_field_val  TYPE ish_t_field_value.

* Build field values
  CLEAR ls_field_val.
  ls_field_val-fieldname = co_fieldname_subscreen.
  ls_field_val-type      = co_fvtype_screen.
  INSERT ls_field_val INTO TABLE lt_field_val.

* Set fields.
  CALL METHOD set_fields
    EXPORTING
      it_field_values  = lt_field_val
      i_field_values_x = on
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD modify_screen_internal .

  DATA: l_tabname LIKE screen-name,
        l_idx     TYPE i.

  FIELD-SYMBOLS: <l_tspb>   TYPE ANY,
                 <ls_tspb>  TYPE rn1_tspb.

* Starting index.
  l_idx = 1.

  LOOP AT SCREEN.
*   Get tabstrip pushbutton name.
    l_tabname = get_tspb_name( l_idx ).
    CASE screen-name.
      WHEN l_tabname.
*       Read corresponding tspb-entry.
        READ TABLE gt_tspb ASSIGNING <ls_tspb> INDEX l_idx.
        CHECK sy-subrc = 0.
*       Set active flag.
        IF <ls_tspb>-active = on.
          screen-active = 1.
        ELSE.
          screen-active = 0.
        ENDIF.
*       Set input flag.
        IF <ls_tspb>-input = on.
          screen-input = 1.
        ELSE.
          screen-input = 0.
        ENDIF.
*       Iterate l_idx.
        l_idx = l_idx + 1.
      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.

ENDMETHOD.


METHOD pai_subscreen .

  DATA: lr_screen  TYPE REF TO if_ish_screen.

* Initializations.
  e_rc = 0.

* Get the subscreen.
  CALL METHOD get_subscreen
    IMPORTING
      er_screen       = lr_screen
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_screen IS INITIAL.

* Couple the subscreen with its function group.
  CALL METHOD lr_screen->before_call_subscreen
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD pbo_subscreen .

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        ls_parent  TYPE rnscr_parent.

  FIELD-SYMBOLS: <l_dynpg>  TYPE sy-repid,
                 <l_dynnr>  TYPE sy-dynnr.

* Initializations.
  e_rc = 0.
  IF gr_dynpg_subscreen IS BOUND.
    ASSIGN gr_dynpg_subscreen->* TO <l_dynpg>.
    <l_dynpg> = 'SAPLN1SC'.
  ENDIF.
  IF gr_dynnr_subscreen IS BOUND.
    ASSIGN gr_dynnr_subscreen->* TO <l_dynnr>.
    <l_dynnr> = '0001'.
  ENDIF.

* Get the subscreen.
  CALL METHOD get_subscreen
    IMPORTING
      er_screen       = lr_screen
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_screen IS INITIAL.

* Couple the subscreen with its function group.
  CALL METHOD lr_screen->before_call_subscreen
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get parent of the subscreen.
  CALL METHOD lr_screen->get_parent
    IMPORTING
      es_parent = ls_parent.

* Set dynpg + dynnr in N1_SDY_TABSTRIP.
  IF gr_dynpg_subscreen IS BOUND.
    ASSIGN gr_dynpg_subscreen->* TO <l_dynpg>.
    <l_dynpg> = ls_parent-repid.
  ENDIF.
  IF gr_dynnr_subscreen IS BOUND.
    ASSIGN gr_dynnr_subscreen->* TO <l_dynnr>.
    <l_dynnr> = ls_parent-dynnr.
  ENDIF.

ENDMETHOD.


METHOD set_subscreen .

  DATA: ls_field_val  TYPE rnfield_value.

  CHECK NOT gr_screen_values IS INITIAL.

* Build field value for subscreen.
  CLEAR ls_field_val.
  ls_field_val-fieldname = co_fieldname_subscreen.
  ls_field_val-type      = co_fvtype_screen.
  ls_field_val-object    = ir_screen.

* Set field value for subscreen.
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      i_field_value  = ls_field_val
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD set_tspb .

  FIELD-SYMBOLS: <ls_tspb>  TYPE rn1_tspb.

* Initializations.
  e_rc = 0.

* Get the tspb
  READ TABLE gt_tspb INDEX i_idx ASSIGNING <ls_tspb>.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* Set properties
  IF i_title_x = on.
    <ls_tspb>-title = i_title.
  ENDIF.
  IF i_active_x = on.
    <ls_tspb>-active = i_active.
  ENDIF.
  IF i_input_x = on.
    <ls_tspb>-input = i_input.
  ENDIF.

ENDMETHOD.
ENDCLASS.
