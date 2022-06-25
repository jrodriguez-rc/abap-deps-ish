class CL_ISH_BUSINESS_OBJECT definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_BUSINESS_OBJECT
*"* do not include other source files here!!!

  interfaces IF_ISH_BUSINESS_OBJECT
      final methods DEREGISTER_OWNER
                    GET_BOSAVER
                    HAS_OWNER
                    IS_READONLY
                    REGISTER_OWNER
                    SAVE .
  interfaces IF_ISH_CB_DESTROYABLE .
  interfaces IF_ISH_DBENTRY_GET .
  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_ENTITY_OBJECT_OWNER .
  interfaces IF_ISH_GUI_CB_STRUCTURE_MODEL .
  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .
  interfaces IF_ISH_SNAPSHOTABLE .
  interfaces IF_ISH_GUI_XSTRUCTURE_MODEL .

  aliases CO_SAVESTAT_AFTER_COMMIT
    for IF_ISH_BUSINESS_OBJECT~CO_SAVESTAT_AFTER_COMMIT .
  aliases CO_SAVESTAT_AFTER_ROLLBACK
    for IF_ISH_BUSINESS_OBJECT~CO_SAVESTAT_AFTER_ROLLBACK .
  aliases CO_SAVESTAT_BEFORE_SAVE
    for IF_ISH_BUSINESS_OBJECT~CO_SAVESTAT_BEFORE_SAVE .
  aliases CO_SAVESTAT_CHECK
    for IF_ISH_BUSINESS_OBJECT~CO_SAVESTAT_CHECK .
  aliases CO_SAVESTAT_COLLECT
    for IF_ISH_BUSINESS_OBJECT~CO_SAVESTAT_COLLECT .
  aliases CO_SAVESTAT_NOSAVE
    for IF_ISH_BUSINESS_OBJECT~CO_SAVESTAT_NOSAVE .
  aliases CO_SAVESTAT_SAVE
    for IF_ISH_BUSINESS_OBJECT~CO_SAVESTAT_SAVE .
  aliases CO_SAVESTAT_WAIT
    for IF_ISH_BUSINESS_OBJECT~CO_SAVESTAT_WAIT .
  aliases CHECK
    for IF_ISH_BUSINESS_OBJECT~CHECK .
  aliases CLEAR_ALL_SNAPSHOTS
    for IF_ISH_BUSINESS_OBJECT~CLEAR_ALL_SNAPSHOTS .
  aliases CLEAR_SNAPSHOT
    for IF_ISH_BUSINESS_OBJECT~CLEAR_SNAPSHOT .
  aliases DEREGISTER_OWNER
    for IF_ISH_BUSINESS_OBJECT~DEREGISTER_OWNER .
  aliases DESTROY
    for IF_ISH_DESTROYABLE~DESTROY .
  aliases GET_ACTIVE_SNAPKEY
    for IF_ISH_BUSINESS_OBJECT~GET_ACTIVE_SNAPKEY .
  aliases GET_BOID
    for IF_ISH_BUSINESS_OBJECT~GET_BOID .
  aliases GET_BOSAVER
    for IF_ISH_BUSINESS_OBJECT~GET_BOSAVER .
  aliases GET_DATA
    for IF_ISH_GUI_XSTRUCTURE_MODEL~GET_DATA .
  aliases GET_ERDAT
    for IF_ISH_DBENTRY_GET~GET_ERDAT .
  aliases GET_ERTIM
    for IF_ISH_DBENTRY_GET~GET_ERTIM .
  aliases GET_ERUSR
    for IF_ISH_DBENTRY_GET~GET_ERUSR .
  aliases GET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT .
  aliases GET_INVALID_MESSAGES
    for IF_ISH_BUSINESS_OBJECT~GET_INVALID_MESSAGES .
  aliases GET_LODAT
    for IF_ISH_DBENTRY_GET~GET_LODAT .
  aliases GET_LOEKZ
    for IF_ISH_DBENTRY_GET~GET_LOEKZ .
  aliases GET_LOTIM
    for IF_ISH_DBENTRY_GET~GET_LOTIM .
  aliases GET_LOUSR
    for IF_ISH_DBENTRY_GET~GET_LOUSR .
  aliases GET_MANDT
    for IF_ISH_DBENTRY_GET~GET_MANDT .
  aliases GET_ORIG_ERDAT
    for IF_ISH_DBENTRY_GET~GET_ORIG_ERDAT .
  aliases GET_ORIG_ERTIM
    for IF_ISH_DBENTRY_GET~GET_ORIG_ERTIM .
  aliases GET_ORIG_ERUSR
    for IF_ISH_DBENTRY_GET~GET_ORIG_ERUSR .
  aliases GET_ORIG_FIELD_CONTENT
    for IF_ISH_DBENTRY_GET~GET_ORIG_FIELD_CONTENT .
  aliases GET_ORIG_LODAT
    for IF_ISH_DBENTRY_GET~GET_ORIG_LODAT .
  aliases GET_ORIG_LOEKZ
    for IF_ISH_DBENTRY_GET~GET_ORIG_LOEKZ .
  aliases GET_ORIG_LOTIM
    for IF_ISH_DBENTRY_GET~GET_ORIG_LOTIM .
  aliases GET_ORIG_LOUSR
    for IF_ISH_DBENTRY_GET~GET_ORIG_LOUSR .
  aliases GET_ORIG_MANDT
    for IF_ISH_DBENTRY_GET~GET_ORIG_MANDT .
  aliases GET_ORIG_SPRAS
    for IF_ISH_DBENTRY_GET~GET_ORIG_SPRAS .
  aliases GET_ORIG_STODAT
    for IF_ISH_DBENTRY_GET~GET_ORIG_STODAT .
  aliases GET_ORIG_STOID
    for IF_ISH_DBENTRY_GET~GET_ORIG_STOID .
  aliases GET_ORIG_STOKZ
    for IF_ISH_DBENTRY_GET~GET_ORIG_STOKZ .
  aliases GET_ORIG_STOTIM
    for IF_ISH_DBENTRY_GET~GET_ORIG_STOTIM .
  aliases GET_ORIG_STOUSR
    for IF_ISH_DBENTRY_GET~GET_ORIG_STOUSR .
  aliases GET_ORIG_TIMESTAMP
    for IF_ISH_DBENTRY_GET~GET_ORIG_TIMESTAMP .
  aliases GET_ORIG_UPDAT
    for IF_ISH_DBENTRY_GET~GET_ORIG_UPDAT .
  aliases GET_ORIG_UPTIM
    for IF_ISH_DBENTRY_GET~GET_ORIG_UPTIM .
  aliases GET_ORIG_UPUSR
    for IF_ISH_DBENTRY_GET~GET_ORIG_UPUSR .
  aliases GET_SAVE_STATUS
    for IF_ISH_BUSINESS_OBJECT~GET_SAVE_STATUS .
  aliases GET_SPRAS
    for IF_ISH_DBENTRY_GET~GET_SPRAS .
  aliases GET_STODAT
    for IF_ISH_DBENTRY_GET~GET_STODAT .
  aliases GET_STOID
    for IF_ISH_DBENTRY_GET~GET_STOID .
  aliases GET_STOKZ
    for IF_ISH_DBENTRY_GET~GET_STOKZ .
  aliases GET_STOTIM
    for IF_ISH_DBENTRY_GET~GET_STOTIM .
  aliases GET_STOUSR
    for IF_ISH_DBENTRY_GET~GET_STOUSR .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS .
  aliases GET_TIMESTAMP
    for IF_ISH_DBENTRY_GET~GET_TIMESTAMP .
  aliases GET_T_CHANGED_EO
    for IF_ISH_BUSINESS_OBJECT~GET_T_CHANGED_EO .
  aliases GET_T_LOADED_EO
    for IF_ISH_BUSINESS_OBJECT~GET_T_LOADED_EO .
  aliases GET_T_OWNER
    for IF_ISH_BUSINESS_OBJECT~GET_T_OWNER .
  aliases GET_UPDAT
    for IF_ISH_DBENTRY_GET~GET_UPDAT .
  aliases GET_UPTIM
    for IF_ISH_DBENTRY_GET~GET_UPTIM .
  aliases GET_UPUSR
    for IF_ISH_DBENTRY_GET~GET_UPUSR .
  aliases HAS_ENTITY_OBJECT
    for IF_ISH_BUSINESS_OBJECT~HAS_ENTITY_OBJECT .
  aliases HAS_OWNER
    for IF_ISH_BUSINESS_OBJECT~HAS_OWNER .
  aliases HAS_SNAPSHOT
    for IF_ISH_BUSINESS_OBJECT~HAS_SNAPSHOT .
  aliases INVALIDATE
    for IF_ISH_BUSINESS_OBJECT~INVALIDATE .
  aliases IS_CHANGED
    for IF_ISH_BUSINESS_OBJECT~IS_CHANGED .
  aliases IS_DELETED
    for IF_ISH_BUSINESS_OBJECT~IS_DELETED .
  aliases IS_DESTROYED
    for IF_ISH_DESTROYABLE~IS_DESTROYED .
  aliases IS_FIELD_CHANGEABLE
    for IF_ISH_GUI_XSTRUCTURE_MODEL~IS_FIELD_CHANGEABLE .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases IS_INVALID
    for IF_ISH_BUSINESS_OBJECT~IS_INVALID .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_DESTROYABLE~IS_IN_DESTROY_MODE .
  aliases IS_MARKED_FOR_DELETION
    for IF_ISH_BUSINESS_OBJECT~IS_MARKED_FOR_DELETION .
  aliases IS_NEW
    for IF_ISH_BUSINESS_OBJECT~IS_NEW .
  aliases IS_READONLY
    for IF_ISH_BUSINESS_OBJECT~IS_READONLY .
  aliases IS_TOUCHED
    for IF_ISH_BUSINESS_OBJECT~IS_TOUCHED .
  aliases MARK_FOR_DELETION
    for IF_ISH_BUSINESS_OBJECT~MARK_FOR_DELETION .
  aliases REGISTER_OWNER
    for IF_ISH_BUSINESS_OBJECT~REGISTER_OWNER .
  aliases RELOAD
    for IF_ISH_BUSINESS_OBJECT~RELOAD .
  aliases RESET
    for IF_ISH_BUSINESS_OBJECT~RESET .
  aliases SAVE
    for IF_ISH_BUSINESS_OBJECT~SAVE .
  aliases SET_DATA
    for IF_ISH_GUI_XSTRUCTURE_MODEL~SET_DATA .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases SNAPSHOT
    for IF_ISH_BUSINESS_OBJECT~SNAPSHOT .
  aliases TOUCH
    for IF_ISH_BUSINESS_OBJECT~TOUCH .
  aliases UNDO
    for IF_ISH_BUSINESS_OBJECT~UNDO .
  aliases UNTOUCH
    for IF_ISH_BUSINESS_OBJECT~UNTOUCH .
  aliases EV_AFTER_DESTROY
    for IF_ISH_DESTROYABLE~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_DESTROYABLE~EV_BEFORE_DESTROY .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .
  aliases EV_INVALIDATED
    for IF_ISH_BUSINESS_OBJECT~EV_INVALIDATED .

  events EV_G_MARKED_FOR_DEL_CHANGED .
  events EV_STOKZ_CHANGED .
protected section.
*"* protected components of class CL_ISH_BUSINESS_OBJECT
*"* do not include other source files here!!!

  data GR_CB_OBJ type ref to OBJECT .
  type-pools ABAP .
  data G_CB_EO_CONSTRUCTION type ABAP_BOOL .

  methods _RESET_ENTITY_OBJECT
    importing
      !IR_EO type ref to CL_ISH_ENTITY_OBJECT
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods ON_MAIN_EO_CHANGED
    for event EV_CHANGED of IF_ISH_GUI_STRUCTURE_MODEL
    importing
      !ET_CHANGED_FIELD
      !SENDER .
  methods _AFTER_COMMIT
    returning
      value(RT_CHANGED_EO) type ISH_T_EO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _AFTER_ROLLBACK
    returning
      value(RT_CHANGED_EO) type ISH_T_EO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _BEFORE_SAVE
    raising
      CX_ISH_STATIC_HANDLER .
  methods _COLLECT_T_BO2SAVE
    returning
      value(RT_BO) type ISH_T_BO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CB_SET_FIELD_CONTENT
  abstract
    importing
      !IR_MODEL type ref to IF_ISH_GUI_STRUCTURE_MODEL
      !I_FIELDNAME type ISH_FIELDNAME
      !I_CONTENT type ANY
    returning
      value(R_CONTINUE) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK
  abstract
    importing
      !I_CHECK_UNCHANGED_DATA type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_RESULT) type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_DESTROYED
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_ENTITY_OBJECTS
    importing
      !I_CHECK_UNCHANGED_DATA type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_RESULT) type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_INVALID
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_READONLY
  final
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_REGISTER_OWNER
    importing
      !IR_OWNER type ref to IF_ISH_BUSINESS_OBJECT_OWNER
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CLEAR_ALL_SNAPSHOTS
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CLEAR_SNAPSHOT
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DESTROY
  abstract .
  methods _END_FUNCSNAP_ERROR
  final .
  methods _END_FUNCSNAP_SUCCESS
  final
    returning
      value(R_SNAPKEY) type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_FUNCSNAPHANDLER
  final
    returning
      value(RR_FUNCSNAPHANDLER) type ref to CL_ISH_BOFUNCSNAPHANDLER
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_MAIN_EO
  abstract
    returning
      value(RR_MAIN_EO) type ref to CL_ISH_ENTITY_OBJECT .
  methods _GET_T_EO_2_SAVE
    returning
      value(RT_EO) type ISH_T_EO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_T_LOADED_EO
  abstract
    returning
      value(RT_LOADED_EO) type ISH_T_EO_OBJH .
  methods _IS_READONLY
    returning
      value(R_READONLY) type ABAP_BOOL .
  methods _MARK_FOR_DELETION
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REGISTER_ON_MAIN_EO_CHANGED .
  methods _RELOAD
  abstract
    returning
      value(RT_CHANGED_EO) type ISH_T_EO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _RESET
    returning
      value(RT_CHANGED_EO) type ISH_T_EO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _RESET_ENTITY_OBJECTS
    importing
      !IT_EO type ISH_T_EO_OBJH optional
    returning
      value(RT_CHANGED_EO) type ISH_T_EO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SAVE
    importing
      !I_USER type SYUNAME
      !I_DATE type SYDATUM
      !I_TIME type SYUZEIT
      !I_TCODE type SYTCODE
      !I_TIMESTAMP type TIMESTAMPL
    returning
      value(RR_RESULT) type ref to CL_ISH_BOSAVE_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SNAPSHOT
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _START_FUNCSNAP
  final
    importing
      !I_FCODE type UI_FUNC
      !I_FORCE_SNAPSHOT type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_SNAPKEY) type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods _UNDO
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    returning
      value(RT_CHANGED_EO) type ISH_T_EO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_BUSINESS_OBJECT
*"* do not include other source files here!!!

  data GR_SAVER type ref to CL_ISH_BOSAVER .
  data GR_FUNCSNAPHANDLER type ref to CL_ISH_BOFUNCSNAPHANDLER .
  data GR_INVALID_MESSAGES type ref to CL_ISHMED_ERRORHANDLING .
  data GT_EMPTY_SNAPKEY type ISH_T_SNAPKEY .
  data GT_OWNER type ISH_T_BOOWNER_OBJH .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .
  data G_INVALID type ABAP_BOOL .
  data G_NEXT_SNAPKEY type ISH_SNAPKEY value 1. "#EC NOTEXT .

  methods ON_TRANSACTION_FINISHED
    for event TRANSACTION_FINISHED of CL_SYSTEM_TRANSACTION_STATE
    importing
      !KIND .
  methods __SAVE
    importing
      !I_USER type SYUNAME
      !I_DATE type SYDATUM
      !I_TIME type SYUZEIT
      !I_TCODE type SYTCODE
      !I_TIMESTAMP type TIMESTAMPL
    returning
      value(RR_RESULT) type ref to CL_ISH_BOSAVE_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
ENDCLASS.



CLASS CL_ISH_BUSINESS_OBJECT IMPLEMENTATION.


METHOD if_ish_business_object~bo4saver_after_commit.

  _check_destroyed( ).
  _check_invalid( ).

  IF gr_saver IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'BO4SAVER_AFTER_COMMIT'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

  gr_saver->cb_after_commit( ir_bo = me ).

  _after_commit( ).

  _clear_all_snapshots( ).

ENDMETHOD.


METHOD if_ish_business_object~bo4saver_after_rollback.

  _check_destroyed( ).
  _check_invalid( ).

  IF gr_saver IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'BO4SAVER_AFTER_ROLLBACK'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

  gr_saver->cb_after_rollback( ir_bo = me ).

  _after_rollback( ).

ENDMETHOD.


METHOD if_ish_business_object~bo4saver_before_save.

  _check_destroyed( ).
  _check_invalid( ).

  IF gr_saver IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'BO4SAVER_BEFORE_SAVE'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

  gr_saver->cb_before_save( ir_bo = me ).

  _before_save( ).

ENDMETHOD.


METHOD if_ish_business_object~bo4saver_check.

  _check_destroyed( ).
  _check_invalid( ).

  IF gr_saver IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'BO4SAVER_CHECK'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

  gr_saver->cb_check( ir_bo = me ).

  rr_result = _check( i_check_unchanged_data = i_check_unchanged_data ).

ENDMETHOD.


METHOD if_ish_business_object~bo4saver_clear_saver.

  IF gr_saver IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'BO4SAVER_CLEAR_SAVER'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

  gr_saver->cb_clear_saver( ir_bo = me ).

  CLEAR gr_saver.

ENDMETHOD.


METHOD if_ish_business_object~bo4saver_collect.

  _check_destroyed( ).
  _check_invalid( ).

  IF gr_saver IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'BO4SAVER_COLLECT'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

  gr_saver->cb_collect( ir_bo = me ).

  rt_bo = _collect_t_bo2save( ).

ENDMETHOD.


METHOD if_ish_business_object~bo4saver_save.

  DATA lr_owner           TYPE REF TO if_ish_business_object_owner.

  _check_destroyed( ).
  _check_invalid( ).

  IF gr_saver IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'BO4SAVER_SAVE'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

* Callback to the saver.
  gr_saver->cb_save( ir_bo = me ).

* Callback to the owners.
  LOOP AT gt_owner INTO lr_owner.
    lr_owner->cb_save( ir_bo = me ).
  ENDLOOP.

* Save.
  rr_save_result = _save(
    i_user      = i_user
    i_date      = i_date
    i_time      = i_time
    i_tcode     = i_tcode
    i_timestamp = i_timestamp ).

ENDMETHOD.


METHOD if_ish_business_object~bo4saver_set_saver.

  _check_destroyed( ).
  _check_invalid( ).

  IF gr_saver IS BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'BO4SAVER_SET_SAVER'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

  ir_saver->cb_set_saver( ir_bo = me ).

  gr_saver = ir_saver.

ENDMETHOD.


METHOD if_ish_business_object~check.

  DATA lr_tmp_result            TYPE REF TO cl_ish_result.

  _check_destroyed( ).
  _check_invalid( ).

* Check the entity objects.
  rr_result = _check_entity_objects(
      i_check_unchanged_data = i_check_unchanged_data ).

* Internal processing.
  lr_tmp_result = _check(
      i_check_unchanged_data = i_check_unchanged_data ).
  if rr_result is bound.
    rr_result->merge( lr_tmp_result ).
  else.
    rr_result = lr_tmp_Result.
  endif.

ENDMETHOD.


METHOD if_ish_business_object~clear_all_snapshots.

  DATA lr_owner           TYPE REF TO if_ish_business_object_owner.

  _check_destroyed( ).
  _check_invalid( ).

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* No processing if save is pending.
  CASE get_save_status( ).
    WHEN co_savestat_nosave OR
         co_savestat_after_commit OR
         co_savestat_after_rollback.
    WHEN OTHERS.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'CLEAR_ALL_SNAPSHOTS'
          i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDCASE.

* Callback.
  LOOP AT gt_owner INTO lr_owner.
    lr_owner->cb_clear_all_snapshots( ir_bo = me ).
  ENDLOOP.

* Clear all snapshots.
  _clear_all_snapshots( ).

ENDMETHOD.


METHOD if_ish_business_object~clear_snapshot.

  DATA lr_owner           TYPE REF TO if_ish_business_object_owner.

  _check_destroyed( ).
  _check_invalid( ).

* Process only on valid snapkey.
  CHECK has_snapshot( i_snapkey = i_snapkey ) = abap_true.

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* No processing if save is pending.
  CASE get_save_status( ).
    WHEN co_savestat_nosave OR
         co_savestat_after_commit OR
         co_savestat_after_rollback.
    WHEN OTHERS.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'CLEAR_SNAPSHOT'
          i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDCASE.

* Callback.
  LOOP AT gt_owner INTO lr_owner.
    lr_owner->cb_clear_snapshot(
        ir_bo     = me
        i_snapkey = i_snapkey ).
  ENDLOOP.

* Clear the snapshot.
  _clear_snapshot( i_snapkey = i_snapkey ).

* Handle g_next_snapkey.
  IF i_snapkey = g_next_snapkey - 1.
    g_next_snapkey = i_snapkey.
  ENDIF.

ENDMETHOD.


METHOD if_ish_business_object~deregister_owner.

  DATA lr_owner           TYPE REF TO if_ish_business_object_owner.

  CHECK ir_owner IS BOUND.

* Callback.
  ir_owner->cb_deregister_owner( ir_bo = me ).

* Deregister the owner.
  DELETE TABLE gt_owner WITH TABLE KEY table_line = ir_owner.

ENDMETHOD.


METHOD if_ish_business_object~get_active_snapkey.

  r_snapkey = g_next_snapkey - 1.

ENDMETHOD.


METHOD if_ish_business_object~get_boid.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_boid = lr_main_eo->get_eoid( ).

ENDMETHOD.


METHOD if_ish_business_object~get_bosaver.

  rr_bosaver = gr_saver.

ENDMETHOD.


METHOD if_ish_business_object~get_invalid_messages.

  rr_messages = gr_invalid_messages.

ENDMETHOD.


METHOD if_ish_business_object~get_save_status.

  IF gr_saver IS NOT BOUND.
    r_save_status = co_savestat_nosave.
  ELSE.
    r_save_status = gr_saver->get_save_status( ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_business_object~get_t_changed_eo.

  DATA lt_eo            TYPE ish_t_eo_objh.
  DATA lr_eo            TYPE REF TO cl_ish_entity_object.

  CHECK is_destroyed( ) = abap_false.
  CHECK is_invalid( ) = abap_false.

  lt_eo = get_t_loaded_eo( ).
  LOOP AT lt_eo INTO lr_eo.
    CHECK lr_eo IS BOUND.
    IF i_incl_touched_eo = abap_true.
      CHECK lr_eo->is_touched( ) = abap_true OR
            lr_eo->is_changed( ) = abap_true.
    ELSE.
      CHECK lr_eo->is_changed( ) = abap_true.
    ENDIF.
    INSERT lr_eo INTO TABLE rt_changed_eo.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_business_object~get_t_loaded_eo.

  CHECK is_destroyed( ) = abap_false.
  CHECK is_invalid( ) = abap_false.

  rt_loaded_eo = _get_t_loaded_eo( ).

ENDMETHOD.


METHOD if_ish_business_object~get_t_owner.

  rt_owner = gt_owner.

ENDMETHOD.


METHOD if_ish_business_object~has_entity_object.

  DATA lt_eo            TYPE ish_t_eo_objh.

  lt_eo = get_t_loaded_eo( ).

  READ TABLE lt_eo WITH TABLE KEY table_line = ir_eo TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_has_eo = abap_true.

ENDMETHOD.


METHOD if_ish_business_object~has_owner.

  CHECK ir_owner IS BOUND.

  READ TABLE gt_owner WITH TABLE KEY table_line = ir_owner TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_has_owner = abap_true.

ENDMETHOD.


METHOD if_ish_business_object~has_snapshot.

  CHECK i_snapkey < g_next_snapkey.

  r_has_snapshot = abap_true.

ENDMETHOD.


METHOD if_ish_business_object~invalidate.

  IF ir_messages IS BOUND.
    CALL METHOD cl_ish_utl_base=>copy_messages
      EXPORTING
        i_copy_from     = ir_messages
      CHANGING
        cr_errorhandler = gr_invalid_messages.
  ENDIF.

  IF g_invalid = abap_false.
    g_invalid = abap_true.
    RAISE EVENT ev_invalidated
      EXPORTING
        er_messages = gr_invalid_messages.
  ENDIF.

ENDMETHOD.


METHOD if_ish_business_object~is_changed.

  DATA lt_eo            TYPE ish_t_eo_objh.
  DATA lr_eo            TYPE REF TO cl_ish_entity_object.

  CHECK is_destroyed( ) = abap_false.

  IF is_invalid( ) = abap_true.
    r_changed = abap_true.
    RETURN.
  ENDIF.

* Michael Manoch, 26.04.2011, MED-44341   START
* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* If self is new AND marked for deletion self is not changed.
  IF is_new( ) = abap_true AND is_marked_for_deletion( ) = abap_true.
    r_changed = abap_false.
    RETURN.
  ENDIF.

* If self is new OR marked for deletion self is changed.
  IF is_new( ) = abap_true OR is_marked_for_deletion( ) = abap_true.
    r_changed = abap_true.
    RETURN.
  ENDIF.
* Michael Manoch, 26.04.2011, MED-44341   END

  lt_eo = get_t_loaded_eo( ).
  LOOP AT lt_eo INTO lr_eo.
    CHECK lr_eo IS BOUND.
    IF i_incl_touched_eo = abap_true.
      CHECK lr_eo->is_touched( ) = abap_true OR
            lr_eo->is_changed( ) = abap_true.
    ELSE.
      CHECK lr_eo->is_changed( ) = abap_true.
    ENDIF.
    r_changed = abap_true.
    RETURN.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_business_object~is_deleted.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  CHECK is_destroyed( ) = abap_false.

  lr_main_eo = _get_main_eo( ).

  r_deleted = lr_main_eo->is_deleted( ).

ENDMETHOD.


METHOD if_ish_business_object~is_invalid.

  r_invalid = g_invalid.

ENDMETHOD.


METHOD if_ish_business_object~is_marked_for_deletion.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  CHECK is_destroyed( ) = abap_false.
  CHECK is_invalid( ) = abap_false.

  lr_main_eo = _get_main_eo( ).

  r_marked_for_deletion = lr_main_eo->is_marked_for_deletion( ).

ENDMETHOD.


METHOD if_ish_business_object~is_new.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  CHECK is_destroyed( ) = abap_false.

  lr_main_eo = _get_main_eo( ).

  r_new = lr_main_eo->is_new( ).

ENDMETHOD.


METHOD if_ish_business_object~is_readonly.

  DATA lr_owner           TYPE REF TO if_ish_business_object_owner.

  IF is_destroyed( ) = abap_true OR
     is_invalid( ) = abap_true.
    r_readonly = abap_true.
    RETURN.
  ENDIF.

* Callback
  LOOP AT gt_owner INTO lr_owner.
    IF lr_owner->cb_readonly( ir_bo = me ) = abap_true.
      r_readonly = abap_true.
      RETURN.
    ENDIF.
  ENDLOOP.

* Internal processing.
  r_readonly = _is_readonly( ).

ENDMETHOD.


METHOD if_ish_business_object~is_touched.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  CHECK is_destroyed( ) = abap_false.
  CHECK is_invalid( ) = abap_false.

  lr_main_eo = _get_main_eo( ).

  r_touched = lr_main_eo->is_touched( ).

ENDMETHOD.


METHOD if_ish_business_object~mark_for_deletion.

  DATA lr_owner           TYPE REF TO if_ish_business_object_owner.

  _check_destroyed( ).
  _check_invalid( ).

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* No processing if save is pending.
  IF get_save_status( ) <> co_savestat_nosave.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'MARK_FOR_DELETION'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

* Callback.
  LOOP AT gt_owner INTO lr_owner.
    lr_owner->cb_mark_for_deletion( ir_bo = me ).
  ENDLOOP.

* Mark for deletion.
  _mark_for_deletion( ).

ENDMETHOD.


METHOD if_ish_business_object~register_owner.

  CHECK ir_owner IS BOUND.
  CHECK has_owner( ir_owner ) = abap_false.

  _check_destroyed( ).
  _check_invalid( ).

  ir_owner->cb_register_owner( ir_bo = me ).

  _check_register_owner( ir_owner = ir_owner ).

  INSERT ir_owner INTO TABLE gt_owner.

ENDMETHOD.


METHOD if_ish_business_object~reload.

  DATA lr_owner           TYPE REF TO if_ish_business_object_owner.
  DATA lx_static          TYPE REF TO cx_ish_static_handler.

  _check_destroyed( ).

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* No processing if save is pending.
  IF get_save_status( ) <> co_savestat_nosave.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'RELOAD'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

* Callback.
  LOOP AT gt_owner INTO lr_owner.
    lr_owner->cb_reload( ir_bo = me ).
  ENDLOOP.

* Clear the invalidation status.
  g_invalid = abap_false.
  IF gr_invalid_messages IS BOUND.
    gr_invalid_messages->initialize( ).
    CLEAR gr_invalid_messages.
  ENDIF.

* Internal processing.
* If self is new we reset.
* If self is not new we reload.
  TRY.
      IF is_new( ) = abap_true.
        rt_changed_eo = _reset( ).
      ELSE.
        rt_changed_eo = _reload( ).
      ENDIF.
    CATCH cx_ish_static_handler INTO lx_static.
      invalidate( ir_messages = lx_static->gr_errorhandler ).
      RAISE EXCEPTION lx_static.
  ENDTRY.

* Clear all snapshots.
  _clear_all_snapshots( ).

ENDMETHOD.


METHOD if_ish_business_object~reset.

  DATA lr_owner           TYPE REF TO if_ish_business_object_owner.
  DATA lx_static          TYPE REF TO cx_ish_static_handler.

  _check_destroyed( ).

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* No processing if save is pending.
  IF get_save_status( ) <> co_savestat_nosave.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'RESET'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

* Callback.
  LOOP AT gt_owner INTO lr_owner.
    lr_owner->cb_reset( ir_bo = me ).
  ENDLOOP.

* Clear the invalidation status.
  g_invalid = abap_false.
  IF gr_invalid_messages IS BOUND.
    gr_invalid_messages->initialize( ).
    CLEAR gr_invalid_messages.
  ENDIF.

* Reset.
  TRY.
      rt_changed_eo = _reset( ).
    CATCH cx_ish_static_handler INTO lx_static.
      invalidate( ir_messages = lx_static->gr_errorhandler ).
      RAISE EXCEPTION lx_static.
  ENDTRY.

* Clear all snapshots.
  _clear_all_snapshots( ).

ENDMETHOD.


METHOD if_ish_business_object~save.

  DATA lt_save_result     TYPE ish_t_bosaveresult_objh.
  DATA lr_save_result     TYPE REF TO cl_ish_bosave_result.

  _check_destroyed( ).
  _check_invalid( ).

* No save if save is pending.
  IF get_save_status( ) <> co_savestat_nosave.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SAVE'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

* Save.
  CALL METHOD cl_ish_bosaver=>execute_save
    EXPORTING
      ir_bo             = me
      i_user            = i_user
      i_date            = i_date
      i_time            = i_time
      i_tcode           = i_tcode
      i_timestamp       = i_timestamp
      i_ignore_warnings = abap_true
      i_commit          = abap_false
    IMPORTING
      et_save_result    = lt_save_result.

* Export.
  LOOP AT lt_save_result INTO lr_save_result.
    CHECK lr_save_result->get_business_object( ) = me.
    rr_result = lr_save_result.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_business_object~snapshot.

  DATA lr_owner           TYPE REF TO if_ish_business_object_owner.

  _check_destroyed( ).
  _check_invalid( ).

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* No processing if save is pending.
  IF get_save_status( ) <> co_savestat_nosave.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SNAPSHOT'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

* Callback.
  LOOP AT gt_owner INTO lr_owner.
    lr_owner->cb_snapshot(
        ir_bo     = me
        i_snapkey = g_next_snapkey ).
  ENDLOOP.

* Export.
  r_snapkey = g_next_snapkey.

* Increment g_next_snapkey.
  g_next_snapkey = g_next_snapkey + 1.

ENDMETHOD.


METHOD if_ish_business_object~touch.

  DATA lr_owner             TYPE REF TO if_ish_business_object_owner.
  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  _check_destroyed( ).
  _check_invalid( ).

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* No processing if save is pending.
  IF get_save_status( ) <> co_savestat_nosave.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'TOUCH'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

* Callback.
  LOOP AT gt_owner INTO lr_owner.
    lr_owner->cb_touch( ir_bo = me ).
  ENDLOOP.

* Touch the main entity object.
  lr_main_eo = _get_main_eo( ).
  gr_cb_obj = lr_main_eo.
  TRY.
      lr_main_eo->eo4owner_touch( ).
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD if_ish_business_object~undo.

  DATA lr_owner           TYPE REF TO if_ish_business_object_owner.

  _check_destroyed( ).
  _check_invalid( ).

* Process only on valid snapkey.
  CHECK has_snapshot( i_snapkey = i_snapkey ) = abap_true.

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* No processing if save is pending.
  IF get_save_status( ) <> co_savestat_nosave.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'UNDO'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

* Callback.
  LOOP AT gt_owner INTO lr_owner.
    lr_owner->cb_undo(
        ir_bo     = me
        i_snapkey = i_snapkey ).
  ENDLOOP.

* Undo.
  rt_changed_eo = _undo( i_snapkey = i_snapkey ).

* Handle g_next_snapkey.
  g_next_snapkey = i_snapkey.

ENDMETHOD.


METHOD if_ish_business_object~untouch.

  DATA lr_owner             TYPE REF TO if_ish_business_object_owner.
  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  _check_destroyed( ).
  _check_invalid( ).

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* No processing if save is pending.
  IF get_save_status( ) <> co_savestat_nosave.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'UNTOUCH'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

* Callback.
  LOOP AT gt_owner INTO lr_owner.
    lr_owner->cb_untouch( ir_bo = me ).
  ENDLOOP.

* Touch the main entity object.
  lr_main_eo = _get_main_eo( ).
  gr_cb_obj = lr_main_eo.
  TRY.
      lr_main_eo->eo4owner_untouch( ).
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD if_ish_cb_destroyable~cb_destroy.

  CHECK ir_destroyable = gr_cb_obj.

  r_continue = abap_true.

ENDMETHOD.


METHOD if_ish_dbentry_get~get_erdat.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_erdat = lr_main_eo->get_erdat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_ertim.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_ertim = lr_main_eo->get_ertim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_erusr.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_erusr = lr_main_eo->get_erusr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_lodat.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_lodat = lr_main_eo->get_lodat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_loekz.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_loekz = lr_main_eo->get_loekz( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_lotim.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_lotim = lr_main_eo->get_lotim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_lousr.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_lousr = lr_main_eo->get_lousr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_mandt.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_mandt = lr_main_eo->get_mandt( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_erdat.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_erdat = lr_main_eo->get_orig_erdat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_ertim.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_ertim = lr_main_eo->get_orig_ertim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_erusr.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_erusr = lr_main_eo->get_orig_erusr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_field_content.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  CALL METHOD lr_main_eo->get_orig_field_content
    EXPORTING
      i_fieldname = i_fieldname
    CHANGING
      c_content   = c_content.

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_lodat.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_lodat = lr_main_eo->get_orig_lodat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_loekz.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_loekz = lr_main_eo->get_orig_loekz( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_lotim.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_lotim = lr_main_eo->get_orig_lotim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_lousr.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_lousr = lr_main_eo->get_orig_lousr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_mandt.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_mandt = lr_main_eo->get_orig_mandt( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_spras.

  r_spras = sy-langu.

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_stodat.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_stodat = lr_main_eo->get_orig_stodat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_stoid.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_stoid = lr_main_eo->get_orig_stoid( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_stokz.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_stokz = lr_main_eo->get_orig_stokz( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_stotim.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_stotim = lr_main_eo->get_orig_stotim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_stousr.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_stousr = lr_main_eo->get_orig_stousr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_timestamp.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_timestamp = lr_main_eo->get_orig_timestamp( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_updat.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_updat = lr_main_eo->get_orig_updat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_uptim.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_uptim = lr_main_eo->get_orig_uptim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_upusr.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_upusr = lr_main_eo->get_orig_upusr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_spras.

  r_spras = sy-langu.

ENDMETHOD.


METHOD if_ish_dbentry_get~get_stodat.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_stodat = lr_main_eo->get_stodat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_stoid.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_stoid = lr_main_eo->get_stoid( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_stokz.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_stokz = lr_main_eo->get_stokz( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_stotim.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_stotim = lr_main_eo->get_stotim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_stousr.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_stousr = lr_main_eo->get_stousr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_timestamp.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_timestamp = lr_main_eo->get_timestamp( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_updat.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_updat = lr_main_eo->get_updat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_uptim.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_uptim = lr_main_eo->get_uptim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_upusr.

  DATA lr_main_eo             TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_upusr = lr_main_eo->get_upusr( ).

ENDMETHOD.


METHOD if_ish_destroyable~destroy.

  DATA lr_owner           TYPE REF TO if_ish_business_object_owner.
  DATA lr_main_eo         TYPE REF TO cl_ish_entity_object.

* No processing if self is already destroyed.
  IF is_destroyed( ) = abap_true.
    r_destroyed = abap_true.
    RETURN.
  ENDIF.

* Callback.
  LOOP AT gt_owner INTO lr_owner.
    IF lr_owner->cb_destroy( me ) = abap_false.
      RETURN.
    ENDIF.
  ENDLOOP.

* We are in destroy mode.
  g_destroy_mode = abap_true.

* Raise event ev_before_destroy.
  RAISE EVENT ev_before_destroy.

* Deregister on_main_eo_changed.
  lr_main_eo = _get_main_eo( ).
  IF lr_main_eo IS BOUND.
    SET HANDLER on_main_eo_changed  FOR lr_main_eo ACTIVATION abap_false.
  ENDIF.

* Internal processing.
  _destroy( ).

* Destroy attributes.
  CLEAR gr_cb_obj.
  CLEAR g_cb_eo_construction.
  CLEAR gr_funcsnaphandler.
  CLEAR gr_saver.
  CLEAR gt_empty_snapkey.
  CLEAR gt_owner.
  IF gr_invalid_messages IS BOUND.
    gr_invalid_messages->initialize( ).
    CLEAR gr_invalid_messages.
  ENDIF.

* Now we are destroyed.
  g_destroyed = abap_true.
  g_destroy_mode = abap_false.

* Raise event ev_after_destroy.
  RAISE EVENT ev_after_destroy.

* Export.
  r_destroyed = abap_true.

ENDMETHOD.


METHOD if_ish_destroyable~is_destroyed.

  r_destroyed = g_destroyed.

ENDMETHOD.


METHOD if_ish_destroyable~is_in_destroy_mode.

  r_destroy_mode = g_destroy_mode.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_after_commit.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_AFTER_COMMIT'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_after_rollback.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_AFTER_ROLLBACK'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_before_save.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_BEFORE_SAVE'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_clear_all_snapshots.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_CLEAR_ALL_SNAPSHOTS'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_clear_snapshot.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_CLEAR_SNAPSHOT'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_construction.

  IF g_cb_eo_construction = abap_false.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_CONSTRUCTION'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_mark_for_deletion.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_MARK_FOR_DELETION'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_reload.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_RELOAD'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_reset.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_RESET'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_save.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_SAVE'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_snapshot.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_SNAPSHOT'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_touch.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_TOUCH'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_undo.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_UNDO'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_untouch.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_UNTOUCH'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~get_active_snapkey.

  r_snapkey = get_active_snapkey( ).

ENDMETHOD.


METHOD if_ish_gui_cb_structure_model~cb_set_field_content.

* Self must not be readonly.
  _check_readonly( ).

* Internal processing.
  r_continue = _cb_set_field_content(
      ir_model    = ir_model
      i_fieldname = i_fieldname
      i_content   = i_content ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  _check_destroyed( ).

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  CALL METHOD lr_main_eo->get_field_content
    EXPORTING
      i_fieldname = i_fieldname
    CHANGING
      c_content   = c_content.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  rt_supported_fieldname = lr_main_eo->get_supported_fields( ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_supported = lr_main_eo->is_field_supported( i_fieldname ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  _check_destroyed( ).

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_changed = lr_main_eo->set_field_content(
      i_fieldname = i_fieldname
      i_content   = i_content ).

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~get_data.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  _check_destroyed( ).

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  CALL METHOD lr_main_eo->get_data
    CHANGING
      cs_data = cs_data.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~is_field_changeable.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  r_changeable = lr_main_eo->is_field_changeable( i_fieldname ).

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~is_readonly.

  r_readonly = if_ish_business_object~is_readonly( ).

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~set_data.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  _check_destroyed( ).

  lr_main_eo = _get_main_eo( ).
  CHECK lr_main_eo IS BOUND.

  rt_changed_field = lr_main_eo->set_data(
      is_data          = is_data
      i_soft           = i_soft
      it_field2change  = it_field2change
      i_handle_xfields = i_handle_xfields ).

ENDMETHOD.


METHOD if_ish_snapshotable~clear_snapshot.

  clear_snapshot( i_snapkey = i_snapkey ).

ENDMETHOD.


METHOD if_ish_snapshotable~snapshot.

  r_snapkey = snapshot( ).

ENDMETHOD.


METHOD if_ish_snapshotable~undo.

  undo( i_snapkey = i_snapkey ).

ENDMETHOD.


METHOD on_main_eo_changed.

  CHECK sender IS BOUND.
  CHECK sender = _get_main_eo( ).

  READ TABLE et_changed_field
    FROM cl_ish_dbentry=>co_fieldname_g_marked_for_del
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    RAISE EVENT ev_g_marked_for_del_changed.
  ENDIF.

  READ TABLE et_changed_field
    FROM cl_ish_dbentry=>co_fieldname_stokz
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    RAISE EVENT ev_stokz_changed.
  ENDIF.

  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = et_changed_field.

ENDMETHOD.


METHOD on_transaction_finished.

** Process only if we are in waiting save status.
*  CHECK  g_save_status = co_savestat_wait.
*
** Process _after_commit/rollback.
*  TRY.
*      CASE kind.
*        WHEN 'C'.
*          _after_commit( ).
*        WHEN 'R'.
*          _after_rollback( ).
*      ENDCASE.
*    CATCH cx_ish_static_handler.
**     Offen ???   destroy/corrupt
*      RETURN.
*  ENDTRY.
*
** Deregister this eventhandler.
*  SET HANDLER on_transaction_finished ACTIVATION abap_false.
*
** Save was done.
*  g_save_status = co_savestat_nosave.

ENDMETHOD.


METHOD _after_commit.

  DATA lt_eo            TYPE ish_t_eo_objh.
  DATA lr_eo            TYPE REF TO cl_ish_entity_object.

* after_commit for the entity objects.
  lt_eo = get_t_loaded_eo( ).
  TRY.
      LOOP AT lt_eo INTO lr_eo.
        CHECK lr_eo IS BOUND.
        gr_cb_obj = lr_eo.
        CHECK lr_eo->eo4owner_after_commit( ) = abap_true.
        INSERT lr_eo INTO TABLE rt_changed_eo.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD _after_rollback.

  DATA lt_eo            TYPE ish_t_eo_objh.
  DATA lr_eo            TYPE REF TO cl_ish_entity_object.

* after_rollback for the entity objects.
  lt_eo = get_t_loaded_eo( ).
  TRY.
      LOOP AT lt_eo INTO lr_eo.
        CHECK lr_eo IS BOUND.
        gr_cb_obj = lr_eo.
        CHECK lr_eo->eo4owner_after_rollback( ) = abap_true.
        INSERT lr_eo INTO TABLE rt_changed_eo.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD _before_save.

  DATA lt_eo            TYPE ish_t_eo_objh.
  DATA lr_eo            TYPE REF TO cl_ish_entity_object.

* before_save for the entity objects.
  lt_eo = get_t_loaded_eo( ).
  TRY.
      LOOP AT lt_eo INTO lr_eo.
        CHECK lr_eo IS BOUND.
        gr_cb_obj = lr_eo.
        lr_eo->eo4owner_before_save( ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD _check_destroyed.

  IF is_destroyed( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_DESTROYED'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD _check_entity_objects.

  DATA lt_eo                    TYPE ish_t_eo_objh.
  DATA lr_eo                    TYPE REF TO cl_ish_entity_object.
  DATA lr_tmp_result            TYPE REF TO cl_ish_result.

  lt_eo = get_t_loaded_eo( ).
  LOOP AT lt_eo INTO lr_eo.
    CHECK lr_eo IS BOUND.
    lr_tmp_result = lr_eo->check( i_check_unchanged_data = i_check_unchanged_data ).
    if rr_result is bound.
      rr_result->merge( lr_tmp_result ).
    else.
      rr_result = lr_tmp_result.
    endif.
  ENDLOOP.

ENDMETHOD.


METHOD _check_invalid.

  IF g_invalid = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_INVALID'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD _check_readonly.

  IF is_readonly( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_READONLY'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD _check_register_owner.

* No checks by default.
* Redefine this method if only special owners are allowed.

ENDMETHOD.


METHOD _clear_all_snapshots.

  DATA lt_eo              TYPE ish_t_eo_objh.
  DATA lr_eo              TYPE REF TO cl_ish_entity_object.
  DATA l_rc               TYPE ish_method_rc.

* Clear all entity object snapshots.
  lt_eo = _get_t_loaded_eo( ).
  LOOP AT lt_eo INTO lr_eo.
    gr_cb_obj = lr_eo.
    TRY.
        lr_eo->eo4owner_clear_all_snapshots( ).
      CATCH cx_root.                                     "#EC CATCH_ALL
        l_rc = 1.
    ENDTRY.
  ENDLOOP.

* Handle g_next_snapkey.
  g_next_snapkey = 1.


* Errorhandling.
  IF l_rc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CLEAR_ALL_SNAPSHOTS'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD _clear_snapshot.

  DATA lt_eo              TYPE ish_t_eo_objh.
  DATA lr_eo              TYPE REF TO cl_ish_entity_object.
  DATA l_rc               TYPE ish_method_rc.

* Clear the entity objects snapshot.
  lt_eo = _get_t_loaded_eo( ).
  LOOP AT lt_eo INTO lr_eo.
    CHECK lr_eo->has_snapshot( i_snapkey ) = abap_true.
    gr_cb_obj = lr_eo.
    TRY.
        lr_eo->eo4owner_clear_snapshot( i_snapkey ).
      CATCH cx_root.                                     "#EC CATCH_ALL
        l_rc = 1.
    ENDTRY.
  ENDLOOP.
  IF l_rc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CLEAR_SNAPSHOT'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD _collect_t_bo2save.

  DATA lt_eo            TYPE ish_t_eo_objh.
  DATA lr_eo            TYPE REF TO cl_ish_entity_object.
  DATA lt_tmp_bo        TYPE ish_t_bo_objh.
  DATA lr_tmp_bo        TYPE REF TO if_ish_business_object.

* collect_t_bo2save for the entity objects.
  lt_eo = get_t_loaded_eo( ).
  TRY.
      LOOP AT lt_eo INTO lr_eo.
        CHECK lr_eo IS BOUND.
        gr_cb_obj = lr_eo.
        lt_tmp_bo = lr_eo->eo4owner_collect_t_bo2save( ).
        LOOP AT lt_tmp_bo INTO lr_tmp_bo.
          INSERT lr_tmp_bo INTO TABLE rt_bo.
        ENDLOOP.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD _end_funcsnap_error.

  DATA lx_static                        TYPE REF TO cx_ish_static_handler.

  TRY.
      _get_funcsnaphandler( )->end( i_success = abap_false ).
    CATCH cx_ish_static_handler INTO lx_static.
      invalidate( ir_messages = lx_static->gr_errorhandler ).
  ENDTRY.

ENDMETHOD.


METHOD _end_funcsnap_success.

  r_snapkey = _get_funcsnaphandler( )->end( i_success = abap_true ).

ENDMETHOD.


METHOD _get_funcsnaphandler.

  _check_destroyed( ).

  IF gr_funcsnaphandler IS NOT BOUND.
    gr_funcsnaphandler = cl_ish_bofuncsnaphandler=>new_instance( ir_bo = me ).
  ENDIF.

  rr_funcsnaphandler = gr_funcsnaphandler.

ENDMETHOD.


METHOD _get_t_eo_2_save.

  DATA lt_eo            TYPE ish_t_eo_objh.
  DATA lr_eo            TYPE REF TO cl_ish_entity_object.
  DATA lr_main_eo       TYPE REF TO cl_ish_entity_object.

* Get the loaded entity objects.
  lt_eo = _get_t_loaded_eo( ).

* Determine the entity objects to save.
  LOOP AT lt_eo INTO lr_eo.
*   No save on deleted entity objects.
    CHECK lr_eo->is_deleted( ) = abap_false.
*   No save if the entity object is new and marked for deletion.
    IF lr_eo->is_new( ) = abap_true AND
       lr_eo->is_marked_for_deletion( ) = abap_true.
      CONTINUE.
    ENDIF.
*   Save only touched or changed entity objects.
    CHECK lr_eo->is_touched( ) = abap_true OR
          lr_eo->is_changed( ) = abap_true.
*   This entity object has to be saved.
    INSERT lr_eo INTO TABLE rt_eo.
  ENDLOOP.

* If there is any entity objects to save we have also to save the main entity object (timestamp).
  DO 1 TIMES.
    CHECK rt_eo IS NOT INITIAL.
    lr_main_eo = _get_main_eo( ).
    CHECK lr_main_eo IS BOUND.
    READ TABLE rt_eo WITH TABLE KEY table_line = lr_main_eo TRANSPORTING NO FIELDS.
    CHECK sy-subrc <> 0.
    INSERT lr_main_eo INTO TABLE rt_eo.
  ENDDO.

ENDMETHOD.


METHOD _is_readonly.

  DATA lr_lockable            TYPE REF TO if_ish_lockable.

* Only if self is a lockable object:
*   If self is not locked self is readonly.
  TRY.
      lr_lockable ?= me.
      IF lr_lockable->is_locked( ) = abap_false.
        r_readonly = abap_true.
        RETURN.
      ENDIF.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD _mark_for_deletion.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  CHECK is_destroyed( ) = abap_false.

  lr_main_eo = _get_main_eo( ).

  gr_cb_obj = lr_main_eo.
  TRY.
      lr_main_eo->eo4owner_mark_for_deletion( ).
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD _register_on_main_eo_changed.

  DATA lr_main_eo           TYPE REF TO cl_ish_entity_object.

  lr_main_eo = _get_main_eo( ).

  CHECK lr_main_eo IS BOUND.

  SET HANDLER on_main_eo_changed  FOR lr_main_eo ACTIVATION abap_true.

ENDMETHOD.


METHOD _reset.

* Reset the entity objects.
  rt_changed_eo = _reset_entity_objects( ).

ENDMETHOD.


METHOD _reset_entity_object.

  CHECK ir_eo IS BOUND.

* New entity objects are marked for deletion.
* Existing entity objects are resetted.

  gr_cb_obj = ir_eo.
  TRY.
      IF ir_eo->is_new( ) = abap_true.
        IF ir_eo->is_marked_for_deletion( ) = abap_false.
          ir_eo->eo4owner_mark_for_deletion( ).
          r_changed = abap_true.
        ENDIF.
      ELSE.
        r_changed = ir_eo->eo4owner_reset( ).
      ENDIF.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD _reset_entity_objects.

  DATA lt_eo            TYPE ish_t_eo_objh.
  DATA lr_eo            TYPE REF TO cl_ish_entity_object.

  lt_eo = get_t_loaded_eo( ).

  LOOP AT lt_eo INTO lr_eo.
    CHECK lr_eo IS BOUND.
    CHECK lr_eo->is_deleted( ) = abap_false.
    IF _reset_entity_object( ir_eo = lr_eo ) = abap_true.
      INSERT lr_eo INTO TABLE rt_changed_eo.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD _save.

  DATA lt_eo            TYPE ish_t_eo_objh.
  DATA lr_eo            TYPE REF TO cl_ish_entity_object.
  DATA lt_saved_eo      TYPE ish_t_eo_objh.
  DATA lr_main_eo       TYPE REF TO cl_ish_entity_object.

* Get the entity objects to save.
  lt_eo = _get_t_eo_2_save( ).
  CHECK lt_eo IS NOT INITIAL.

* If we have entity objects to save
* we have to touch the main entity object.
  DO 1 TIMES.
    lr_main_eo = _get_main_eo( ).
    CHECK lr_main_eo IS BOUND.
    READ TABLE lt_eo WITH TABLE KEY table_line = lr_main_eo TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      INSERT lr_main_eo INTO TABLE lt_eo.
    ENDIF.
    gr_cb_obj = lr_main_eo.
    TRY.
        lr_main_eo->eo4owner_touch( ).
      CLEANUP.
        CLEAR gr_cb_obj.
    ENDTRY.
    CLEAR gr_cb_obj.
  ENDDO.

* Save the entity objects.
  TRY.
      LOOP AT lt_eo INTO lr_eo.
        gr_cb_obj = lr_eo.
        CHECK lr_eo->eo4owner_save(
            i_user      = i_user
            i_date      = i_date
            i_time      = i_time
            i_tcode     = i_tcode
            i_timestamp = i_timestamp ) = abap_true.
        INSERT lr_eo INTO TABLE lt_saved_eo.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

* Build the result.
  IF lt_saved_eo IS NOT INITIAL.
    CREATE OBJECT rr_result
      EXPORTING
        ir_bo       = me
        it_saved_eo = lt_saved_eo.
  ENDIF.

ENDMETHOD.


METHOD _snapshot.

  DATA lt_eo              TYPE ish_t_eo_objh.
  DATA lt_eo_undo         TYPE ish_t_eo_objh.
  DATA lr_eo              TYPE REF TO cl_ish_entity_object.

* Snapshot the entity objects.
  lt_eo = _get_t_loaded_eo( ).
  LOOP AT lt_eo INTO lr_eo.
    gr_cb_obj = lr_eo.
    TRY.
        lr_eo->eo4owner_snapshot( i_snapkey ).
      CLEANUP.
        LOOP AT lt_eo_undo INTO lr_eo.
          gr_cb_obj = lr_eo.
          TRY.
              lr_eo->eo4owner_undo( i_snapkey ).
            CATCH cx_root.                               "#EC CATCH_ALL
              CLEAR gr_cb_obj.
          ENDTRY.
        ENDLOOP.
        CLEAR gr_cb_obj.
    ENDTRY.
    CLEAR gr_cb_obj.
    INSERT lr_eo INTO TABLE lt_eo_undo.
  ENDLOOP.

ENDMETHOD.


METHOD _start_funcsnap.

  r_snapkey = _get_funcsnaphandler( )->start(
                  i_fcode           = i_fcode
                  i_force_snapshot  = i_force_snapshot ).

ENDMETHOD.


METHOD _undo.

  DATA lt_eo              TYPE ish_t_eo_objh.
  DATA lr_eo              TYPE REF TO cl_ish_entity_object.
  DATA l_rc               TYPE ish_method_rc.

* Undo the entity objects.
  lt_eo = _get_t_loaded_eo( ).
  LOOP AT lt_eo INTO lr_eo.
    CHECK lr_eo->is_destroyed( ) = abap_false.
    CHECK lr_eo->is_deleted( ) = abap_false.
    CHECK lr_eo->has_snapshot( i_snapkey ) = abap_true.
    gr_cb_obj = lr_eo.
    TRY.
        IF lr_eo->eo4owner_undo( i_snapkey ) = abap_true.
          INSERT lr_eo INTO TABLE rt_changed_eo.
        ENDIF.
      CATCH cx_root.                                     "#EC CATCH_ALL
        l_rc = 1.
    ENDTRY.
  ENDLOOP.
  CLEAR gr_cb_obj.
  IF l_rc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_UNDO'
        i_mv3        = 'CL_ISH_BUSINESS_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD __save.

*  DATA lr_check_result            TYPE REF TO cl_ish_result.
*  DATA lr_tmp_messages            TYPE REF TO cl_ishmed_errorhandling.
*  DATA lr_save_result             TYPE REF TO cl_ish_bosave_result.
*  DATA lx_static                  TYPE REF TO cx_ish_static_handler.
*
** Create the result.
*  CREATE OBJECT rr_result
*    EXPORTING
*      ir_bo = me.
*
** Check.
** Check is only needed if we have no owners.
** If we have owners the owners are responsible for checking.
*  IF gt_owner IS INITIAL.
*    g_save_status = co_savestat_check.
*    TRY.
*        lr_check_result = check( ).
*        IF lr_check_result IS BOUND.
*          IF lr_check_result->get_rc( ) > 0.
*            CREATE OBJECT lx_static
*              EXPORTING
*                gr_errorhandler = lr_tmp_messages.
*            RAISE EXCEPTION lx_static.
*          ENDIF.
*          rr_result->merge( ir_other_result = lr_check_result ).
*        ENDIF.
*      CLEANUP.
*        g_save_status = co_savestat_nosave.
*    ENDTRY.
*    g_save_status = co_savestat_nosave.
*  ENDIF.
*
** Before save.
*  g_save_status = co_savestat_before_save.
*  TRY.
*      _before_save( ).
*    CLEANUP.
*      g_save_status = co_savestat_nosave.
*  ENDTRY.
*  g_save_status = co_savestat_nosave.
*
** Save.
*  g_save_status = co_savestat_save.
*  TRY.
*      lr_save_result = _save(
*          i_user      = i_user
*          i_date      = i_date
*          i_time      = i_time
*          i_tcode     = i_tcode
*          i_timestamp = i_timestamp ).
*      rr_result->merge( ir_other_result = lr_save_result ).
*    CLEANUP.
*      g_save_status = co_savestat_nosave.
**     We have to process after_rollback to unlock the saved dbentries.
*      TRY.
*          _after_rollback( ).
*        CATCH cx_ish_static_handler.
**         Offen ???   destroy/corrupt
*      ENDTRY.
*  ENDTRY.
*  g_save_status = co_savestat_nosave.
*
** Register the on_transaction_finished eventhandler to process _after_commit/rollback
*  SET HANDLER on_transaction_finished ACTIVATION abap_true.
*
** Now we have to wait for commit/rollback.
*  g_save_status = co_savestat_wait.

ENDMETHOD.
ENDCLASS.
