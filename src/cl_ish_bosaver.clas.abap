class CL_ISH_BOSAVER definition
  public
  final
  create private .

public section.
*"* public components of class CL_ISH_BOSAVER
*"* do not include other source files here!!!

  type-pools ABAP .
  class-methods EXECUTE_CHECK
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT optional
      !IT_BO type ISH_T_BO_OBJH optional
      !I_CHECK_UNCHANGED_DATA type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_RESULT) type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods EXECUTE_SAVE
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT optional
      !IT_BO type ISH_T_BO_OBJH optional
      !I_USER type SYUNAME default SY-UNAME
      !I_DATE type SYDATUM default SY-DATUM
      !I_TIME type SYUZEIT default SY-UZEIT
      !I_TCODE type SYTCODE default SY-TCODE
      !I_TIMESTAMP type TIMESTAMPL optional
      !I_IGNORE_WARNINGS type ABAP_BOOL default ABAP_TRUE
      !I_COMMIT type ABAP_BOOL default ABAP_FALSE
    exporting
      !ET_SAVE_RESULT type ISH_T_BOSAVERESULT_OBJH
      !ER_CHECK_RESULT type ref to CL_ISH_RESULT
      !ER_ALL_MESSAGES type ref to CL_ISHMED_ERRORHANDLING
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_AFTER_COMMIT
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_AFTER_ROLLBACK
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_BEFORE_SAVE
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_CHECK
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_CLEAR_SAVER
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_COLLECT
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_SAVE
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_SET_SAVER
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CHECK_HAS_BO
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_SAVE_STATUS
    returning
      value(R_SAVE_STATUS) type N1BOSAVESTATUS .
  methods GET_T_BO
    returning
      value(RT_BO) type ISH_T_BO_OBJH .
  methods HAS_BO
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    returning
      value(R_HAS_BO) type ABAP_BOOL .
  PROTECTED SECTION.
*"* protected components of class CL_ISH_BOSAVER
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_BOSAVER
*"* do not include other source files here!!!

  data GR_CB_BO type ref to IF_ISH_BUSINESS_OBJECT .
  data GR_CB_BO_CLEAR_SAVER type ref to IF_ISH_BUSINESS_OBJECT .
  data GR_CB_BO_SET_SAVER type ref to IF_ISH_BUSINESS_OBJECT .
  data GT_BO type ISH_T_BO_OBJH .
  data G_SAVE_STATUS type N1BOSAVESTATUS .

  class-methods _NEW_INSTANCE
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT optional
      !IT_BO type ISH_T_BO_OBJH optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_BOSAVER
    raising
      CX_ISH_STATIC_HANDLER .
  methods ON_TRANSACTION_FINISHED
    for event TRANSACTION_FINISHED of CL_SYSTEM_TRANSACTION_STATE
    importing
      !KIND .
  methods _ADD_BO
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    returning
      value(R_ADDED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _AFTER_COMMIT
    returning
      value(RT_INVALIDATED_BO) type ISH_T_BO_OBJH .
  methods _AFTER_ROLLBACK
    returning
      value(RT_INVALIDATED_BO) type ISH_T_BO_OBJH .
  methods _BEFORE_SAVE
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK
    importing
      !I_CHECK_UNCHANGED_DATA type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_RESULT) type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CLEAR .
  methods _COLLECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _COLLECT_BO
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _EXECUTE_CHECK
    importing
      !I_CHECK_UNCHANGED_DATA type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_RESULT) type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _EXECUTE_SAVE
    importing
      !I_USER type SYUNAME default SY-UNAME
      !I_DATE type SYDATUM default SY-DATUM
      !I_TIME type SYUZEIT default SY-UZEIT
      !I_TCODE type SYTCODE default SY-TCODE
      !I_TIMESTAMP type TIMESTAMPL optional
      !I_IGNORE_WARNINGS type ABAP_BOOL default ABAP_TRUE
      !I_COMMIT type ABAP_BOOL default ABAP_FALSE
    exporting
      !ET_SAVE_RESULT type ISH_T_BOSAVERESULT_OBJH
      !ER_CHECK_RESULT type ref to CL_ISH_RESULT
      !ER_ALL_MESSAGES type ref to CL_ISHMED_ERRORHANDLING
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
      value(RT_SAVE_RESULT) type ISH_T_BOSAVERESULT_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
ENDCLASS.



CLASS CL_ISH_BOSAVER IMPLEMENTATION.


METHOD cb_after_commit.

  IF ir_bo <> gr_cb_bo OR
     g_save_status <> if_ish_business_object=>co_savestat_after_commit.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_AFTER_COMMIT'
        i_mv3        = 'CL_ISH_BOSAVER' ).
  ENDIF.

ENDMETHOD.                    "cb_after_commit


METHOD cb_after_rollback.

  IF ir_bo <> gr_cb_bo OR
     g_save_status <> if_ish_business_object=>co_savestat_after_rollback.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_AFTER_ROLLBACK'
        i_mv3        = 'CL_ISH_BOSAVER' ).
  ENDIF.

ENDMETHOD.                    "CB_AFTER_ROLLBACK


 METHOD cb_before_save.

   IF ir_bo <> gr_cb_bo OR
      g_save_status <> if_ish_business_object=>co_savestat_before_save.
     cl_ish_utl_exception=>raise_static(
         i_typ        = 'E'
         i_kla        = 'N1BASE'
         i_num        = '030'
         i_mv1        = '1'
         i_mv2        = 'CB_BEFORE_SAVE'
         i_mv3        = 'CL_ISH_BOSAVER' ).
   ENDIF.

 ENDMETHOD.                    "CB_BEFORE_SAVE


METHOD cb_check.

  IF ir_bo <> gr_cb_bo OR
     g_save_status <> if_ish_business_object=>co_savestat_check.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_CHECK'
        i_mv3        = 'CL_ISH_BOSAVER' ).
  ENDIF.

ENDMETHOD.                    "CB_CHECK


METHOD cb_clear_saver.

  IF ir_bo <> gr_cb_bo_clear_saver.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_CLEAR_SAVER'
        i_mv3        = 'CL_ISH_BOSAVER' ).
  ENDIF.

ENDMETHOD.                    "CB_CLEAR_SAVER


METHOD cb_collect.

  IF ir_bo <> gr_cb_bo OR
     g_save_status <> if_ish_business_object=>co_savestat_collect.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_COLLECT'
        i_mv3        = 'CL_ISH_BOSAVER' ).
  ENDIF.

ENDMETHOD.                    "CB_COLLECT


METHOD cb_save.

  IF ir_bo <> gr_cb_bo OR
     g_save_status <> if_ish_business_object=>co_savestat_save.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_SAVE'
        i_mv3        = 'CL_ISH_BOSAVER' ).
  ENDIF.

ENDMETHOD.                    "CB_SAVE


METHOD cb_set_saver.

  IF ir_bo <> gr_cb_bo_set_saver.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_SET_SAVER'
        i_mv3        = 'CL_ISH_BOSAVER' ).
  ENDIF.

ENDMETHOD.                    "CB_SET_SAVER


METHOD check_has_bo.

  IF has_bo( ir_bo ) = abap_false.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CHECK_HAS_BO'
        i_mv3        = 'CL_ISH_BOSAVER' ).
  ENDIF.

ENDMETHOD.                    "check_has_bo


METHOD execute_check.

  DATA lr_saver         TYPE REF TO cl_ish_bosaver.

* Create the saver.
  lr_saver = _new_instance(
      ir_bo = ir_bo
      it_bo = it_bo ).

* Execute
  TRY.
      rr_result = lr_saver->_execute_check( i_check_unchanged_data = i_check_unchanged_data ).
    CLEANUP.
      lr_saver->_clear( ).
  ENDTRY.

* Clear the saver.
  lr_saver->_clear( ).

ENDMETHOD.                    "check


METHOD execute_save.

  DATA lr_saver         TYPE REF TO cl_ish_bosaver.

* Initializations.
  CLEAR et_save_result.
  CLEAR er_check_result.
  CLEAR er_all_messages.

* Create the saver.
  lr_saver = _new_instance(
      ir_bo = ir_bo
      it_bo = it_bo ).

* Execute
  TRY.
      CALL METHOD lr_saver->_execute_save
        EXPORTING
          i_user            = i_user
          i_date            = i_date
          i_time            = i_time
          i_tcode           = i_tcode
          i_timestamp       = i_timestamp
          i_ignore_warnings = i_ignore_warnings
          i_commit          = i_commit
        IMPORTING
          et_save_result    = et_save_result
          er_check_result   = er_check_result
          er_all_messages   = er_all_messages.
    CLEANUP.
*     In case of errors we have to clear the saver.
      lr_saver->_clear( ).
  ENDTRY.

* If saver was successful we must not clear the saver.
* Either the saver did already clear itself (if i_commit=abap_true) or it waits for transaction_finished.

ENDMETHOD.                    "save


METHOD get_save_status.

  r_save_status = g_save_status.

ENDMETHOD.                    "get_processing_state


METHOD get_t_bo.

  rt_bo = gt_bo.

ENDMETHOD.                    "get_t_bo


METHOD has_bo.

  CHECK ir_bo IS BOUND.

  READ TABLE gt_bo WITH TABLE KEY table_line = ir_bo TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_has_bo = abap_true.

ENDMETHOD.                    "has_bo


METHOD on_transaction_finished.

  CHECK g_save_status = if_ish_business_object=>co_savestat_wait.

  CASE kind.
    WHEN 'C'.
      g_save_status = if_ish_business_object=>co_savestat_after_commit.
      _after_commit( ).
    WHEN 'R'.
      g_save_status = if_ish_business_object=>co_savestat_after_rollback.
      _after_rollback( ).
    WHEN OTHERS.
      RETURN.
  ENDCASE.

  _clear( ).

ENDMETHOD.                    "on_transaction_finished


METHOD _add_bo.

  CHECK ir_bo IS BOUND.

  CHECK has_bo( ir_bo ) = abap_false.

  gr_cb_bo_set_saver = ir_bo.
  TRY.
      ir_bo->bo4saver_set_saver( ir_saver = me ).
    CLEANUP.
      CLEAR gr_cb_bo_set_saver.
  ENDTRY.
  CLEAR gr_cb_bo_set_saver.

  INSERT ir_bo INTO TABLE gt_bo.

  r_added = abap_true.

ENDMETHOD.                    "_add_bo


METHOD _after_commit.

  DATA lr_bo                TYPE REF TO if_ish_business_object.
  DATA lx_static            TYPE REF TO cx_ish_static_handler.

  LOOP AT gt_bo INTO lr_bo.
    gr_cb_bo = lr_bo.
    TRY.
        lr_bo->bo4saver_after_commit( ).
      CATCH cx_ish_static_handler INTO lx_static.
        lr_bo->invalidate( ir_messages = lx_static->gr_errorhandler ).
        INSERT lr_bo INTO TABLE rt_invalidated_bo.
      CLEANUP.
        CLEAR gr_cb_bo.
    ENDTRY.
    CLEAR gr_cb_bo.
  ENDLOOP.

ENDMETHOD.                    "_after_commit


METHOD _after_rollback.

  DATA lr_bo                TYPE REF TO if_ish_business_object.
  DATA lx_static            TYPE REF TO cx_ish_static_handler.

  LOOP AT gt_bo INTO lr_bo.
    gr_cb_bo = lr_bo.
    TRY.
        lr_bo->bo4saver_after_rollback( ).
      CATCH cx_ish_static_handler INTO lx_static.
        lr_bo->invalidate( ir_messages = lx_static->gr_errorhandler ).
        INSERT lr_bo INTO TABLE rt_invalidated_bo.
      CLEANUP.
        CLEAR gr_cb_bo.
    ENDTRY.
    CLEAR gr_cb_bo.
  ENDLOOP.

ENDMETHOD.                    "_after_rollback


METHOD _before_save.

  DATA lr_bo            TYPE REF TO if_ish_business_object.

* Save is only allowed for valid editable business objects.
  LOOP AT gt_bo INTO lr_bo.
    IF lr_bo->is_invalid( ) = abap_true OR
       lr_bo->is_readonly( ) = abap_true.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = '_BEFORE_SAVE'
          i_mv3        = 'CL_ISH_BOSAVER' ).
    ENDIF.
  ENDLOOP.

* Let the business objects do their before_save processing.
  TRY.
      LOOP AT gt_bo INTO gr_cb_bo.
        gr_cb_bo->bo4saver_before_save( ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_bo.
  ENDTRY.
  CLEAR gr_cb_bo.

ENDMETHOD.                    "_before_save


METHOD _check.

  DATA lr_bo                    TYPE REF TO if_ish_business_object.
  DATA lr_tmp_result            TYPE REF TO cl_ish_result.

  LOOP AT gt_bo INTO lr_bo.
    lr_tmp_result = lr_bo->check( i_check_unchanged_data = i_check_unchanged_data ).
    IF rr_result IS BOUND.
      rr_result->merge( lr_tmp_result ).
    ELSE.
      rr_result = lr_tmp_result.
    ENDIF.
  ENDLOOP.

ENDMETHOD.                    "_check


METHOD _clear.

  DATA lr_bo            TYPE REF TO if_ish_business_object.
  DATA lx_static        TYPE REF TO cx_ish_static_handler.

  LOOP AT gt_bo INTO lr_bo.
    gr_cb_bo_clear_saver = lr_bo.
    TRY.
        lr_bo->bo4saver_clear_saver( ).
      CATCH cx_ish_static_handler INTO lx_static.
        lr_bo->invalidate( ir_messages = lx_static->gr_errorhandler ).
    ENDTRY.
    CLEAR gr_cb_bo_clear_saver.
  ENDLOOP.

  SET HANDLER on_transaction_finished ACTIVATION abap_false.

  CLEAR gr_cb_bo.
  CLEAR gr_cb_bo_clear_saver.
  CLEAR gr_cb_bo_set_saver.
  CLEAR gt_bo.
  g_save_status = if_ish_business_object=>co_savestat_nosave.

ENDMETHOD.                    "_clear


METHOD _collect.

  DATA lr_bo                    TYPE REF TO if_ish_business_object.
  DATA lt_bo2collect            TYPE ish_t_bo_objh.
  DATA lr_bo2collect            TYPE REF TO if_ish_business_object.

  LOOP AT gt_bo INTO lr_bo.

    gr_cb_bo = lr_bo.
    TRY.
        lt_bo2collect = gr_cb_bo->bo4saver_collect( ).
      CLEANUP.
        CLEAR gr_cb_bo.
    ENDTRY.
    CLEAR gr_cb_bo.

    LOOP AT lt_bo2collect INTO lr_bo2collect.
      CHECK lr_bo2collect IS BOUND.
      _collect_bo( ir_bo = lr_bo2collect ).
    ENDLOOP.

  ENDLOOP.

ENDMETHOD.                    "_collect


METHOD _collect_bo.

  DATA lt_bo2collect            TYPE ish_t_bo_objh.
  DATA lr_bo2collect            TYPE REF TO if_ish_business_object.

  CHECK _add_bo( ir_bo ) = abap_true.

  gr_cb_bo = ir_bo.
  TRY.
      lt_bo2collect = ir_bo->bo4saver_collect( ).
    CLEANUP.
      CLEAR gr_cb_bo.
  ENDTRY.
  CLEAR gr_cb_bo.

  LOOP AT lt_bo2collect INTO lr_bo2collect.
    _collect_bo( lr_bo2collect ).
  ENDLOOP.

ENDMETHOD.                    "_collect_bo


METHOD _execute_check.

* collect
  g_save_status = if_ish_business_object=>co_savestat_collect.
  _collect( ).

* check
  g_save_status = if_ish_business_object=>co_savestat_check.
  rr_result = _check( i_check_unchanged_data = i_check_unchanged_data ).

ENDMETHOD.                    "_check


METHOD _execute_save.

  DATA lr_check_result            TYPE REF TO cl_ish_result.
  DATA lr_tmp_messages            TYPE REF TO cl_ishmed_errorhandling.
  DATA l_tmp_maxty                TYPE ish_bapiretmaxty.

* Michael Manoch, 20.07.2016   START
  DATA l_anything_saved     TYPE abap_bool VALUE abap_false.
  DATA lr_tmp_save_result   TYPE REF TO cl_ish_bosave_result.
* Michael Manoch, 20.07.2016   END

* Initializations.
  CLEAR et_save_result.
  CLEAR er_check_result.
  CLEAR er_all_messages.

* collect
  g_save_status = if_ish_business_object=>co_savestat_collect.
  _collect( ).

* check
  g_save_status = if_ish_business_object=>co_savestat_check.
  er_check_result = _check( ).

* Handle the check result.
  IF er_check_result IS BOUND.
    IF er_check_result->get_rc( ) > 0.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = er_check_result->get_messages( ).
    ENDIF.
    lr_tmp_messages = er_check_result->get_messages( ).
    IF lr_tmp_messages IS BOUND AND
       i_ignore_warnings = abap_false.
      CALL METHOD lr_tmp_messages->get_max_errortype
        IMPORTING
          e_maxty = l_tmp_maxty.
      IF l_tmp_maxty = 'W'.
        RAISE EXCEPTION TYPE cx_ish_static_handler
          EXPORTING
            gr_errorhandler = lr_tmp_messages.
      ENDIF.
    ENDIF.
  ENDIF.

* before_save
  g_save_status = if_ish_business_object=>co_savestat_before_save.
  _before_save( ).

* save
  g_save_status = if_ish_business_object=>co_savestat_save.
  TRY.
      et_save_result = _save(
          i_user      = i_user
          i_date      = i_date
          i_time      = i_time
          i_tcode     = i_tcode
          i_timestamp = i_timestamp ).
    CLEANUP.
      g_save_status = if_ish_business_object=>co_savestat_wait.
      _after_rollback( ).
  ENDTRY.

* Michael Manoch, 20.07.2016   START
* When nothing was saved we are done and have to clear self.
  LOOP AT et_save_result INTO lr_tmp_save_result.
    CHECK lr_tmp_save_result IS BOUND.
    CHECK lr_tmp_save_result->get_t_saved_eo( ) IS NOT INITIAL.
    l_anything_saved = abap_true.
    EXIT.
  ENDLOOP.
  IF l_anything_saved = abap_false.
    _clear( ).
    RETURN.
  ENDIF.
* Michael Manoch, 20.07.2016   END

* Now we have to wait for commit/rollback.
  g_save_status = if_ish_business_object=>co_savestat_wait.

* Commit now or wait for the transaction_finished event.
  IF i_commit = abap_true.
    COMMIT WORK AND WAIT.
    IF sy-subrc = 0.
      g_save_status = if_ish_business_object=>co_savestat_after_commit.
      IF _after_commit( ) IS NOT INITIAL.
        _clear( ).
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '1'
            i_mv2        = '_EXECUTE_SAVE'
            i_mv3        = 'CL_ISH_BOSAVER' ).
      ENDIF.
    ELSE.
      ROLLBACK WORK.
      g_save_status = if_ish_business_object=>co_savestat_after_rollback.
      _after_rollback( ).
      _clear( ).
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = '_EXECUTE_SAVE'
          i_mv3        = 'CL_ISH_BOSAVER' ).
    ENDIF.
    _clear( ).
  ELSE.
    SET HANDLER on_transaction_finished ACTIVATION abap_true.
  ENDIF.

ENDMETHOD.                    "save


METHOD _new_instance.

  DATA lt_bo            TYPE ish_t_bo_objh.
  DATA lr_bo            TYPE REF TO if_ish_business_object.

  CREATE OBJECT rr_instance.

  lt_bo = it_bo.
  IF ir_bo IS BOUND.
    INSERT ir_bo INTO TABLE lt_bo.
  ENDIF.

  TRY.
      LOOP AT lt_bo INTO lr_bo.
        rr_instance->_add_bo( lr_bo ).
      ENDLOOP.
    CLEANUP.
      rr_instance->_clear( ).
  ENDTRY.

ENDMETHOD.                    "new_instance


METHOD _save.

  DATA l_timestamp          TYPE timestampl.
  DATA lr_bo                TYPE REF TO if_ish_business_object.
  DATA lr_save_result       TYPE REF TO cl_ish_bosave_result.
  DATA lx_static            TYPE REF TO cx_ish_static_handler.

  IF i_timestamp IS INITIAL.
    GET TIME STAMP FIELD l_timestamp.
  ELSE.
    l_timestamp = i_timestamp.
  ENDIF.

  LOOP AT gt_bo INTO lr_bo.
    gr_cb_bo = lr_bo.
    TRY.
        lr_save_result = lr_bo->bo4saver_save(
            i_user            = i_user
            i_date            = i_date
            i_time            = i_time
            i_tcode           = i_tcode
            i_timestamp       = l_timestamp ).
        IF lr_save_result IS BOUND.
          INSERT lr_save_result INTO TABLE rt_save_result.
        ENDIF.
      CLEANUP.
        CLEAR gr_cb_bo.
    ENDTRY.
    CLEAR gr_cb_bo.
  ENDLOOP.

ENDMETHOD.                    "_save
ENDCLASS.
