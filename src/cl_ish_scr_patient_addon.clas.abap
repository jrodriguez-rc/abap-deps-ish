class CL_ISH_SCR_PATIENT_ADDON definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

*"* public components of class CL_ISH_SCR_PATIENT_ADDON
*"* do not include other source files here!!!
public section.

  constants CO_DYNPG_DUMMY type SY-REPID value 'SAPLN1_SDY_PATIENT_ADDON'. "#EC NOTEXT
  constants CO_DYNNR_DUMMY type SY-DYNNR value '0110'. "#EC NOTEXT
  constants CO_OTYPE_SCR_PATIENT_ADDON type ISH_OBJECT_TYPE value 7015. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_SCR_ADDON type ref to IF_ISH_SCREEN optional .
  class-methods CREATE
    importing
      !IR_SCR_ADDON type ref to IF_ISH_SCREEN optional
    exporting
      !ER_INSTANCE type ref to CL_ISH_SCR_PATIENT_ADDON
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SCR_PATIENT
    exporting
      !ER_SCR_PATIENT type ref to CL_ISH_SCR_PATIENT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SCR_ADDON
    exporting
      !ER_SCR_ADDON type ref to IF_ISH_SCREEN
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PBO
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_PATIENT_ADDON
*"* do not include other source files here!!!

  data GR_SCR_PATIENT type ref to CL_ISH_SCR_PATIENT .
  data GR_DYNPG_PATIENT type ref to DATA .
  data GR_DYNNR_PATIENT type ref to DATA .
  data GR_SCR_ADDON type ref to IF_ISH_SCREEN .
  data GR_DYNPG_ADDON type ref to DATA .
  data GR_DYNNR_ADDON type ref to DATA .

  methods PBO_INTERNAL
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      !IR_DYNPG type ref to DATA
      !IR_DYNNR type ref to DATA .

  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods INITIALIZE_INTERNAL
    redefinition .
  methods INITIALIZE_PARENT
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_PATIENT_ADDON
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_PATIENT_ADDON IMPLEMENTATION.


METHOD constructor .

* Construct super class(es).
  CALL METHOD super->constructor.

* Set gr_scr_addon.
  gr_scr_addon = ir_scr_addon.

ENDMETHOD.


METHOD create .

* Initializations.
  e_rc = 0.

* Create instance
  CREATE OBJECT er_instance
    EXPORTING
      ir_scr_addon = ir_scr_addon.

ENDMETHOD.


METHOD get_scr_addon .

  DATA: lr_scr_addon  TYPE REF TO if_ish_screen,
        lr_scr_order  TYPE REF TO cl_ish_scr_order.

* Initializations
  e_rc = 0.
  er_scr_addon = gr_scr_addon.

* Already loaded?
  CHECK gr_scr_addon IS INITIAL.

* Create addon screen depending on main object.
  IF gr_main_object->is_inherited_from(
                       cl_ish_corder=>co_otype_corder ) = on.
*   ORDER
    CALL METHOD cl_ish_fac_scr_order=>create
      IMPORTING
        er_instance     = lr_scr_order
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    lr_scr_addon = lr_scr_order.
  ENDIF.

* Remember screen object.
  gr_scr_addon = lr_scr_addon.

* Export screen object.
  er_scr_addon = gr_scr_addon.

ENDMETHOD.


METHOD get_scr_patient .

  DATA: lr_scr_patient  TYPE REF TO cl_ish_scr_patient,
        lr_corder       TYPE REF TO cl_ish_corder,
        lr_comp_patient TYPE REF TO cl_ish_comp_patient,
        lt_screen       TYPE ish_t_screen_objects,
        lr_screen       TYPE REF TO if_ish_screen.

* Initializations.
  e_rc = 0.
  er_scr_patient = gr_scr_patient.

* Already loaded?
  CHECK gr_scr_patient IS INITIAL.

* Create the screen object depending on gr_main_object.
  IF NOT gr_main_object IS INITIAL.
    IF gr_main_object->is_inherited_from(
                cl_ish_corder=>co_otype_corder ) = on.
      lr_corder ?= gr_main_object.
      CALL METHOD lr_corder->get_comphead_patient
        EXPORTING
          i_vcode         = g_vcode
          i_caller        = g_caller
          ir_environment  = gr_environment
          ir_lock         = gr_lock
          ir_config       = gr_config
        IMPORTING
          er_comp_patient = lr_comp_patient
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
      IF NOT lr_comp_patient IS INITIAL.
        lt_screen = lr_comp_patient->get_defined_screens( ).
        LOOP AT lt_screen INTO lr_screen.
          CHECK NOT lr_screen IS INITIAL.
          IF lr_screen->is_inherited_from(
                cl_ish_scr_patient=>co_otype_scr_patient ) = on.
            lr_scr_patient ?= lr_screen.
            EXIT.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDIF.
  IF lr_scr_patient IS INITIAL.
    CALL METHOD cl_ish_scr_patient=>create
      IMPORTING
        er_instance     = lr_scr_patient
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Remember the screen object.
  gr_scr_patient = lr_scr_patient.

* Export the screen object.
  er_scr_patient = gr_scr_patient.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_scr_patient_addon.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_patient_addon.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .

  CALL FUNCTION 'ISH_SDY_PATIENT_ADDON_INIT'
    EXPORTING
      ir_scr_patient_addon = me
    IMPORTING
      er_dynpg_patient     = gr_dynpg_patient
      er_dynnr_patient     = gr_dynnr_patient
      er_dynpg_addon       = gr_dynpg_addon
      er_dynnr_addon       = gr_dynnr_addon.

ENDMETHOD.


METHOD initialize_field_values .

  DATA: lt_field_val  TYPE ish_t_field_value,
        ls_field_val  TYPE rnfield_value.

* Initializations
  e_rc = 0.

* Initialize the fieldvalues for every subscreen.
* SC_PATIENT
  CALL METHOD get_scr_patient
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  ls_field_val-fieldname = 'SC_PATIENT'.
  ls_field_val-type      = 'S'.       " screen instance
  ls_field_val-object    = gr_scr_patient.
  INSERT ls_field_val INTO TABLE lt_field_val.
* SC_ADDON
  CALL METHOD get_scr_addon
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT gr_scr_addon IS INITIAL.
    ls_field_val-fieldname = 'SC_ADDON'.
    ls_field_val-type      = 'S'.       " screen instance
    ls_field_val-object    = gr_scr_addon.
    INSERT ls_field_val INTO TABLE lt_field_val.
  ENDIF.

* Set screen values
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      it_field_values = lt_field_val
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.

ENDMETHOD.


METHOD initialize_internal .

* Initializations
  e_rc = 0.

* Initialize the subscreens.

* SC_PATIENT
  CALL METHOD get_scr_patient
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CALL METHOD gr_scr_patient->initialize
    EXPORTING
      i_main_object  = gr_main_object
      i_vcode        = g_vcode
      i_caller       = g_caller
      i_environment  = gr_environment
      i_lock         = gr_lock
      i_config       = gr_config
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* And set old fieldvalues.
  CALL METHOD gr_scr_patient->set_fields_old.

* SC_ADDON
  CALL METHOD get_scr_addon
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT gr_scr_addon IS INITIAL.
    CALL METHOD gr_scr_addon->initialize
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
  ENDIF.

ENDMETHOD.


METHOD initialize_parent .

  CLEAR: gs_parent.

  gs_parent-repid  = 'SAPLN1_SDY_PATIENT_ADDON'.
  gs_parent-dynnr  = '0100'.
  gs_parent-type   = co_scr_parent_type_dynpro.

ENDMETHOD.


METHOD pbo .

* SC_PATIENT
  CALL METHOD get_scr_patient
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CALL METHOD pbo_internal
    EXPORTING
      ir_screen = gr_scr_patient
      ir_dynpg  = gr_dynpg_patient
      ir_dynnr  = gr_dynnr_patient.

* SC_ADDON
  CALL METHOD get_scr_addon
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CALL METHOD pbo_internal
    EXPORTING
      ir_screen = gr_scr_addon
      ir_dynpg  = gr_dynpg_addon
      ir_dynnr  = gr_dynnr_addon.

ENDMETHOD.


METHOD pbo_internal .

  DATA: ls_parent  TYPE rnscr_parent.

  FIELD-SYMBOLS: <l_dynpg>  TYPE sy-repid,
                 <l_dynnr>  TYPE sy-dynnr.

* Initializations
  IF ir_dynpg IS BOUND AND
     ir_dynnr IS BOUND.
    ASSIGN ir_dynpg->* TO <l_dynpg>.
    ASSIGN ir_dynnr->* TO <l_dynnr>.
    <l_dynpg> = co_dynpg_dummy.
    <l_dynnr> = co_dynnr_dummy.
  ENDIF.

  CHECK NOT ir_screen IS INITIAL.

* Set dynpg + dynnr in corresponding function group.
  IF ir_dynpg IS BOUND AND
     ir_dynnr IS BOUND.
    CALL METHOD ir_screen->get_parent
      IMPORTING
        es_parent = ls_parent.
    <l_dynpg> = ls_parent-repid.
    <l_dynnr> = ls_parent-dynnr.
  ENDIF.

* Couple the screen object with it's function group.
  CALL METHOD ir_screen->set_instance_for_display.

ENDMETHOD.
ENDCLASS.
