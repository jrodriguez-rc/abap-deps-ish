class CL_ISH_CONNECTIVITY definition
  public
  create protected

  global friends CL_ISH_FAC_CONNECTIVITY .

*"* public components of class CL_ISH_CONNECTIVITY
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CALLER .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

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
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_CONNECTIVITY type ISH_OBJECT_TYPE value 4034. "#EC NOTEXT

  methods CHECK
    importing
      !IT_OBJECTS type ISH_T_IDENTIFY_OBJECT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods EXPORT
    importing
      !IT_OBJECTS type ISH_T_IDENTIFY_OBJECT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_CONNECTIVITY
*"* do not include other source files here!!!

  data G_CALLER type N1CALLER .
  data G_EINRI type EINRI .

  methods COMPLETE_CONSTRUCTION
    importing
      value(I_CALLER) type N1CALLER
      !I_EINRI type EINRI .
  class-methods CREATE
    importing
      value(I_CALLER) type N1CALLER
      value(I_EINRI) type EINRI
    exporting
      !ER_INSTANCE type ref to CL_ISH_CONNECTIVITY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DATA_FOR_OBJECT
    importing
      !IR_OBJECT type N1_REF_IDENTIFY_OBJECT
    exporting
      !ET_OBJECTS type ISH_T_IDENTIFY_OBJECT_DEPEND
      value(E_NO_EXPORT) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_CONNECTIVITY
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_CONNECTIVITY IMPLEMENTATION.


METHOD check.

  DATA: lt_objects      TYPE ish_t_identify_object_depend,
        lt_objects_tmp  TYPE ish_t_identify_object_depend,
        lr_object       LIKE LINE OF it_objects,
        lt_obj          TYPE ish_objectlist,
        ls_obj          LIKE LINE OF lt_obj,
        l_no_export     TYPE ish_on_off,
        l_rc            TYPE ish_method_rc,
        l_key           TYPE ish_snapkey,
        lr_environment  TYPE REF TO cl_ish_environment,
        lr_exit         TYPE REF TO if_ex_n1_connectivity.

  e_rc = 0.
  REFRESH: lt_objects, lt_obj.

* get all data connected with objects
  LOOP AT it_objects INTO lr_object.
    REFRESH lt_objects_tmp.
    CALL METHOD me->get_data_for_object
      EXPORTING
        ir_object       = lr_object
      IMPORTING
        et_objects      = lt_objects_tmp
        e_no_export     = l_no_export
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    CHECK l_no_export = off.
    APPEND LINES OF lt_objects_tmp TO lt_objects.
  ENDLOOP.
  CHECK e_rc = 0.
  CHECK lt_objects[] IS NOT INITIAL.

* check if the BAdI is implemented
  CALL FUNCTION 'SXC_EXIT_CHECK_ACTIVE'
    EXPORTING
      exit_name  = 'N1_CONNECTIVITY'
    EXCEPTIONS
      not_active = 1
      OTHERS     = 2.

  CHECK sy-subrc = 0.

* create BAdI instance
  CALL METHOD cl_exithandler=>get_instance
    EXPORTING
      exit_name              = 'N1_CONNECTIVITY'
      null_instance_accepted = 'X'
    CHANGING
      instance               = lr_exit.

  CHECK lr_exit IS BOUND.

* get environment
  LOOP AT it_objects INTO lr_object.
    CLEAR ls_obj.
    ls_obj-object = lr_object.
    APPEND ls_obj TO lt_obj.
  ENDLOOP.
  CALL METHOD cl_ishmed_functions=>get_environment
    EXPORTING
      it_objects     = lt_obj
      i_caller       = 'CL_ISH_CONNECTIVITY->CHECK'
      i_env_create   = off
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_environment  = lr_environment
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* snapshot environment
  IF lr_environment IS BOUND.
    CALL METHOD lr_environment->if_ish_snapshot_object~snapshot
      IMPORTING
        e_rc  = e_rc
        e_key = l_key.
    CHECK e_rc = 0.
  ENDIF.

* call BAdI to check data for export to another system
  CALL METHOD lr_exit->exit_check
    EXPORTING
      i_caller        = g_caller
      it_objects      = lt_objects
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler
    EXCEPTIONS
      OTHERS          = 0.

* undo environment
  IF lr_environment IS BOUND.
    CALL METHOD lr_environment->if_ish_snapshot_object~undo
      EXPORTING
        i_key = l_key
      IMPORTING
        e_rc  = l_rc.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD complete_construction.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  g_caller = i_caller.
  g_einri  = i_einri.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD create.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
* create object
  CREATE OBJECT er_instance.
  e_rc = sy-subrc.
  IF e_rc <> 0.
    CLEAR er_instance.
    EXIT.
  ENDIF.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  CALL METHOD er_instance->complete_construction
    EXPORTING
      i_caller = i_caller
      i_einri  = i_einri.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD export.

  DATA: lt_objects      TYPE ish_t_identify_object_depend,
        lt_objects_tmp  TYPE ish_t_identify_object_depend,
        lr_object       LIKE LINE OF it_objects,
        lt_obj          TYPE ish_objectlist,
        ls_obj          LIKE LINE OF lt_obj,
        l_rc            TYPE ish_method_rc,
        l_no_export     TYPE ish_on_off,
        l_key           TYPE ish_snapkey,
        lr_environment  TYPE REF TO cl_ish_environment,
        lr_exit         TYPE REF TO if_ex_n1_connectivity.

  e_rc = 0.
  REFRESH: lt_objects, lt_obj.

* get all data connected with objects
  LOOP AT it_objects INTO lr_object.
    REFRESH lt_objects_tmp.
    CALL METHOD me->get_data_for_object
      EXPORTING
        ir_object       = lr_object
      IMPORTING
        et_objects      = lt_objects_tmp
        e_no_export     = l_no_export
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    CHECK l_no_export = off.
    APPEND LINES OF lt_objects_tmp TO lt_objects.
  ENDLOOP.
  CHECK e_rc = 0.
  CHECK lt_objects[] IS NOT INITIAL.

* check if the BAdI is implemented
  CALL FUNCTION 'SXC_EXIT_CHECK_ACTIVE'
    EXPORTING
      exit_name  = 'N1_CONNECTIVITY'
    EXCEPTIONS
      not_active = 1
      OTHERS     = 2.

  CHECK sy-subrc = 0.

* create BAdI instance
  CALL METHOD cl_exithandler=>get_instance
    EXPORTING
      exit_name              = 'N1_CONNECTIVITY'
      null_instance_accepted = 'X'
    CHANGING
      instance               = lr_exit.

  CHECK lr_exit IS BOUND.

* get environment
  LOOP AT it_objects INTO lr_object.
    CLEAR ls_obj.
    ls_obj-object = lr_object.
    APPEND ls_obj TO lt_obj.
  ENDLOOP.
  CALL METHOD cl_ishmed_functions=>get_environment
    EXPORTING
      it_objects     = lt_obj
      i_caller       = 'CL_ISH_CONNECTIVITY->EXPORT'
      i_env_create   = off
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_environment  = lr_environment
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* snapshot environment
  IF lr_environment IS BOUND.
    CALL METHOD lr_environment->if_ish_snapshot_object~snapshot
      IMPORTING
        e_rc  = e_rc
        e_key = l_key.
    CHECK e_rc = 0.
  ENDIF.

* call BAdI to export data to another system
  CALL METHOD lr_exit->exit_export
    EXPORTING
      i_caller        = g_caller
      it_objects      = lt_objects
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler
    EXCEPTIONS
      OTHERS          = 0.

* undo environment
  IF lr_environment IS BOUND.
    CALL METHOD lr_environment->if_ish_snapshot_object~undo
      EXPORTING
        i_key = l_key
      IMPORTING
        e_rc  = l_rc.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD get_data_for_object.

  DATA: ls_object          LIKE LINE OF et_objects,
*        l_type             TYPE i,                             "REM MED-9409
        lt_run_data        TYPE ish_t_objectbase,
        lr_corder          TYPE REF TO cl_ish_corder,
        lr_app             TYPE REF TO cl_ish_appointment.
  DATA: lr_identify        TYPE REF TO if_ish_identify_object.      "MED-9409

  e_rc = 0.
  e_no_export = off.
  REFRESH et_objects.

  CHECK ir_object IS BOUND.

*-------- BEGIN C.Honeder MED-9409
  TRY.
    lr_identify ?= ir_object.
    IF ir_object->is_inherited_from( cl_ish_corder=>co_otype_corder ) = on OR
       ir_object->is_inherited_from( cl_ishmed_corder=>co_otype_corder_med ) = on .

*  CALL METHOD ir_object->('GET_TYPE')
*    IMPORTING
*      e_object_type = l_type.

*  CASE l_type.
*   clinical order
*    WHEN cl_ish_corder=>co_otype_corder OR
*         cl_ishmed_corder=>co_otype_corder_med.
*-------- END C.Honeder MED-9409
      lr_corder ?= ir_object.
*     get all connected data
      CALL METHOD cl_ish_utl_cord=>get_t_run_data
        EXPORTING
          ir_corder       = lr_corder
        IMPORTING
          et_run_data     = lt_run_data
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CLEAR ls_object.
      ls_object-object = ir_object.
      APPEND LINES OF lt_run_data TO ls_object-depend.
      APPEND ls_object TO et_objects.
*   appointment
     ELSEIF ir_object->is_inherited_from( cl_ish_appointment=>co_otype_appointment ) = on.      "MED-9409
*    WHEN cl_ish_appointment=>co_otype_appointment.                                         "REM MED-9409
      lr_app ?= ir_object.
*     get all connected data
      CALL METHOD cl_ish_utl_apmg=>get_t_run_data
        EXPORTING
          ir_app          = lr_app
        IMPORTING
          et_run_data     = lt_run_data
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CLEAR ls_object.
      ls_object-object = ir_object.
      APPEND LINES OF lt_run_data TO ls_object-depend.
      APPEND ls_object TO et_objects.
*-- begin Grill, med-29067
    ELSEIF ir_object->is_inherited_from( cl_ishmed_cordpos=>co_otype_cordpos_med ) = on OR       "MED-9409
           ir_object->is_inherited_from( cl_ishmed_prereg=>co_otype_prereg ) = on.               "MED-9409
*    WHEN cl_ishmed_cordpos=>co_otype_cordpos_med OR                                         "REM MED-9409
*         cl_ishmed_prereg=>co_otype_prereg.                                                 "REM MED-9409
      ls_object-object = ir_object.
      APPEND ls_object TO et_objects.
*-- end Grill, med-29067
    ELSE.                                                    "MED-9409
*    WHEN OTHERS.                                       "REM MED-9409
      e_no_export = on.
      EXIT.
  ENDIF.
*  ENDCASE.                                             "REM MED-9409
  CATCH cx_sy_move_cast_error.    "#EC NO_HANDLER           "MED-9409
  ENDTRY.                                                   "MED-9409
ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_connectivity.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.


  DATA: l_object_type TYPE i.
  CALL METHOD me->get_type
    IMPORTING
      e_object_type = l_object_type.

  IF l_object_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_connectivity.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.
ENDCLASS.
