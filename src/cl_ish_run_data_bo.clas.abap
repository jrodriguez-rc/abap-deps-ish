class CL_ISH_RUN_DATA_BO definition
  public
  inheriting from CL_ISH_RUN_DATA
  abstract
  create public .

public section.
*"* public components of class CL_ISH_RUN_DATA_BO
*"* do not include other source files here!!!

  constants CO_OTYPE_RUN_DATA_BO type ISH_OBJECT_TYPE value 13761. "#EC NOTEXT

  methods IF_ISH_DATA_OBJECT~CHECK_CHANGES
    redefinition .
  methods IF_ISH_DATA_OBJECT~GET_KEY_STRING
    redefinition .
  methods IF_ISH_DATA_OBJECT~IS_CANCELLED
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_OBJECTBASE~CLEAR_LOCK
    redefinition .
  methods IF_ISH_OBJECTBASE~SET_LOCK
    redefinition .
  methods IF_ISH_OBJECTBASE~SAVE
    redefinition .
protected section.
*"* protected components of class CL_ISH_RUN_DATA_BO
*"* do not include other source files here!!!

  data GR_BO type ref to IF_ISH_BUSINESS_OBJECT .
  data G_LOCKKEY type N1UUID .

  methods CREATE_SNAPSHOT_OBJECT
    redefinition .
  methods INITIALIZE_AFTER_DESTROY
    redefinition .
  methods SAVE_INTERNAL
    redefinition .
  methods UNDO_SNAPSHOT_OBJECT
    redefinition .
private section.
*"* private components of class CL_ISH_RUN_DATA_BO
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_RUN_DATA_BO IMPLEMENTATION.


METHOD create_snapshot_object.

  DATA l_snapkey      TYPE ish_snapkey.
  DATA lr_snapshot_bo TYPE REF TO cl_ish_snapshot_bo.

  CHECK gr_bo IS BOUND.

* No processing if save is pending.
  IF gr_bo->get_save_status( ) <> cl_ish_business_object=>co_savestat_nosave.
    RETURN.
  ENDIF.

  TRY.
    l_snapkey = gr_bo->snapshot( ).
    CATCH cx_ish_static_handler.
      e_rc = 1.
  ENDTRY.

  CHECK l_snapkey IS NOT INITIAL.

  CREATE OBJECT lr_snapshot_bo
    EXPORTING
      i_snapkey = l_snapkey.

  e_snapshot_object = lr_snapshot_bo.

ENDMETHOD.


METHOD if_ish_data_object~check_changes.

  CHECK gr_bo IS BOUND.

  IF gr_bo->is_new( ) = abap_true.
    e_mode = 'I'.
  ELSEIF gr_bo->is_changed( ) = abap_true.
    e_mode = 'U'.
  ELSEIF gr_bo->is_deleted( ) = abap_true.
    e_mode = 'D'.
  ENDIF.

ENDMETHOD.


METHOD if_ish_data_object~get_key_string.

* ?? offen

ENDMETHOD.


METHOD if_ish_data_object~is_cancelled.

  DATA lr_dbentry_get     TYPE REF TO if_ish_dbentry_get.

  CHECK gr_bo IS BOUND.

  TRY.
    lr_dbentry_get ?= gr_bo.
    CATCH cx_sy_move_cast_error.  "#EC NO_HANDLER
  ENDTRY.

  IF lr_dbentry_get IS BOUND.
    e_cancelled = lr_dbentry_get->get_stokz( ).
  ENDIF.

  e_deleted = gr_bo->is_deleted( ).

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_run_data_bo.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_run_data_bo.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


method IF_ISH_OBJECTBASE~CLEAR_LOCK.

  DATA lr_lockable      TYPE REF TO if_ish_lockable.

  CHECK gr_bo IS BOUND.

  TRY.
    lr_lockable ?= gr_bo.
    CATCH cx_sy_move_cast_error.  " #EC NO_HANDLER
  ENDTRY.

  CHECK lr_lockable IS BOUND.

  TRY.
    lr_lockable->unlock( g_lockkey ).
    CATCH cx_ish_static_handler.
      e_rc = 1.
  ENDTRY.

endmethod.


method IF_ISH_OBJECTBASE~SAVE.

  CALL METHOD save_internal
    EXPORTING
      i_testrun           = i_testrun
      i_tcode             = i_tcode
      i_save_conn_objects = i_save_conn_objects
    IMPORTING
      e_rc                = e_rc
    CHANGING
      c_errorhandler      = c_errorhandler.

endmethod.


method IF_ISH_OBJECTBASE~SET_LOCK.

  DATA lr_lockable      TYPE REF TO if_ish_lockable.

  CHECK gr_bo IS BOUND.

  TRY.
    lr_lockable ?= gr_bo.
    CATCH cx_sy_move_cast_error.  " #EC NO_HANDLER
  ENDTRY.

  CHECK lr_lockable IS BOUND.

  TRY.
    g_lockkey = lr_lockable->lock( ).
    CATCH cx_ish_static_handler.
      e_rc = 1.
  ENDTRY.

endmethod.


METHOD initialize_after_destroy.

* Offen ???

ENDMETHOD.


METHOD save_internal.

  DATA lr_result      TYPE REF TO cl_ish_bosave_result.
  DATA lx_static      TYPE REF TO cx_ish_static_handler.
  DATA lr_messages    TYPE REF TO cl_ishmed_errorhandling.

  CHECK gr_bo IS BOUND.

  IF i_testrun = abap_false.
    TRY.
        lr_result = gr_bo->save( i_tcode = i_tcode ).
      CATCH cx_ish_static_handler INTO lx_static.
        e_rc = 1.                                "MED-59481 note 2174429
        CALL METHOD lx_static->get_errorhandler
          IMPORTING
            er_errorhandler   = lr_messages.
        IF c_errorhandler IS BOUND.
          c_errorhandler->copy_messages( i_copy_from = lr_messages ).
        ELSE.
          c_errorhandler = lr_messages.
        ENDIF.
    ENDTRY.
  ENDIF.

  IF lr_result IS BOUND.
    e_rc = lr_result->get_rc( ).
    IF c_errorhandler IS BOUND.
      c_errorhandler->copy_messages( i_copy_from = lr_result->get_messages( ) ).
    ELSE.
      c_errorhandler = lr_result->get_messages( ).
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD undo_snapshot_object.

  DATA l_snapkey      TYPE ish_snapkey.
  DATA lr_snapshot_bo TYPE REF TO cl_ish_snapshot_bo.

  CHECK i_snapshot_object IS BOUND.
  CHECK gr_bo IS BOUND.

  TRY.
    lr_snapshot_bo ?= i_snapshot_object.
    CATCH cx_sy_move_cast_error.    "#EC NO_HANDLER
  ENDTRY.

  CHECK lr_snapshot_bo IS BOUND.

  l_snapkey = lr_snapshot_bo->get_snapkey( ).

  CHECK l_snapkey IS NOT INITIAL.

  TRY.
    gr_bo->undo( l_snapkey ).
    CATCH cx_ish_static_handler.
      e_rc = 1.
  ENDTRY.

ENDMETHOD.
ENDCLASS.
