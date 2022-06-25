class CL_ISH_ENTITY_OBJECT definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_ENTITY_OBJECT
*"* do not include other source files here!!!

  interfaces IF_ISH_CB_DESTROYABLE .
  interfaces IF_ISH_DBENTRY_GET .
  interfaces IF_ISH_DBENTRY_OWNER .
  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_GUI_CB_STRUCTURE_MODEL .
  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .
  interfaces IF_ISH_GUI_XSTRUCTURE_MODEL .
  interfaces IF_ISH_ENTITY_OBJECT_OWNER .

  aliases DESTROY
    for IF_ISH_DESTROYABLE~DESTROY .
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
  aliases GET_UPDAT
    for IF_ISH_DBENTRY_GET~GET_UPDAT .
  aliases GET_UPTIM
    for IF_ISH_DBENTRY_GET~GET_UPTIM .
  aliases GET_UPUSR
    for IF_ISH_DBENTRY_GET~GET_UPUSR .
  aliases IS_DESTROYED
    for IF_ISH_DESTROYABLE~IS_DESTROYED .
  aliases IS_FIELD_CHANGEABLE
    for IF_ISH_GUI_XSTRUCTURE_MODEL~IS_FIELD_CHANGEABLE .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_DESTROYABLE~IS_IN_DESTROY_MODE .
  aliases IS_READONLY
    for IF_ISH_GUI_XSTRUCTURE_MODEL~IS_READONLY .
  aliases SET_DATA
    for IF_ISH_GUI_XSTRUCTURE_MODEL~SET_DATA .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases EV_AFTER_DESTROY
    for IF_ISH_DESTROYABLE~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_DESTROYABLE~EV_BEFORE_DESTROY .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .

  data CO_FIELDNAME_EOID type ISH_FIELDNAME value 'EOID'. "#EC NOTEXT .

  events EV_G_MARKED_FOR_DEL_CHANGED .
  events EV_STOKZ_CHANGED .

  type-pools ABAP .
  methods CHECK
    importing
      !I_CHECK_UNCHANGED_DATA type ABAP_BOOL default ABAP_FALSE
    preferred parameter I_CHECK_UNCHANGED_DATA
    returning
      value(RR_RESULT) type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !IR_OWNER type ref to IF_ISH_ENTITY_OBJECT_OWNER
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_AFTER_COMMIT
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_AFTER_ROLLBACK
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_BEFORE_SAVE
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_CLEAR_ALL_SNAPSHOTS
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_CLEAR_SNAPSHOT
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_COLLECT_T_BO2SAVE
    returning
      value(RT_BO) type ISH_T_BO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_MARK_FOR_DELETION
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_RELOAD
    importing
      !IS_DATA type DATA
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_RESET
  final
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_SAVE
    importing
      !I_USER type SYUNAME
      !I_DATE type SYDATUM
      !I_TIME type SYUZEIT
      !I_TCODE type SYTCODE
      !I_TIMESTAMP type TIMESTAMPL
    returning
      value(R_SAVED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_SNAPSHOT
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_TOUCH
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_UNDO
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods EO4OWNER_UNTOUCH
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DFIES_BY_FIELDNAME
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_SPRAS type SYLANGU default SY-LANGU
    returning
      value(RS_DFIES) type DFIES .
  methods GET_EOID
    returning
      value(R_EOID) type N1EOID .
  methods GET_OWNER
  final
    returning
      value(RR_OWNER) type ref to IF_ISH_ENTITY_OBJECT_OWNER .
  methods HAS_SNAPSHOT
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    returning
      value(R_HAS_SNAPSHOT) type ABAP_BOOL .
  methods IS_CHANGED
    returning
      value(R_CHANGED) type ABAP_BOOL .
  methods IS_DELETED
    returning
      value(R_DELETED) type ABAP_BOOL .
  methods IS_FIELD_CHANGED
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_CHANGED) type ABAP_BOOL .
  methods IS_MARKED_FOR_DELETION
    returning
      value(R_MARKED_FOR_DELETION) type ABAP_BOOL .
  methods IS_NEW
  final
    returning
      value(R_NEW) type ABAP_BOOL .
  methods IS_TOUCHED
    returning
      value(R_TOUCHED) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_ENTITY_OBJECT
*"* do not include other source files here!!!

  data GR_CB_OBJ type ref to OBJECT .
  data GT_CHANGED_FIELD type ISH_T_FIELDNAME .
  data G_CB_DBENTRY_CONSTRUCTION type ABAP_BOOL .
  data G_CB_DEPEO_CONSTRUCTION type ABAP_BOOL .
  data G_COLLECT_CHANGES type ABAP_BOOL .

  methods ON_DBENTRY_AFTER_DESTROY
    for event EV_AFTER_DESTROY of IF_ISH_DESTROYABLE
    importing
      !SENDER .
  methods ON_DBENTRY_CHANGED
    for event EV_CHANGED of IF_ISH_GUI_STRUCTURE_MODEL
    importing
      !ET_CHANGED_FIELD
      !SENDER .
  methods _ACTIVATE_COLLECT_CHANGES
    returning
      value(R_ACTIVATED) type ABAP_BOOL .
  methods _CHECK_DESTROYED
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DEACTIVATE_COLLECT_CHANGES .
  methods _DESTROY
  abstract .
  methods _GET_DBENTRY4FIELDNAME
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(RR_DBENTRY) type ref to CL_ISH_DBENTRY .
  methods _GET_MAIN_DBENTRY
  abstract
    returning
      value(RR_MAIN_DBENTRY) type ref to CL_ISH_DBENTRY .
  methods _GET_T_DBENTRY
  abstract
    returning
      value(RT_DBENTRY) type ISH_T_DBE_OBJH .
  methods _GET_T_DBENTRY2SAVE
    importing
      !IT_DEPEO2SAVE type ISH_T_EO_OBJH optional
    returning
      value(RT_DBENTRY) type ISH_T_DBE_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_T_DEPEO2SAVE
    returning
      value(RT_EO) type ISH_T_EO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_T_LOADED_DEPEO
    returning
      value(RT_EO) type ISH_T_EO_OBJH .
  methods _ON_DBENTRY_AFTER_DESTROY
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY .
  methods _RAISE_EV_CHANGED
    importing
      !I_CHANGED_FIELD type ISH_FIELDNAME optional
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME optional
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME .
  methods _REGISTER_DBENTRY_EVENTS
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
      !I_ACTIVATION type ABAP_BOOL default ABAP_TRUE .
  methods _RELOAD
  abstract
    importing
      !IS_DATA type DATA
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _RESET
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_ENTITY_OBJECT
*"* do not include other source files here!!!

  data GR_OWNER type ref to IF_ISH_ENTITY_OBJECT_OWNER .
  data G_DESTROY_MODE type ABAP_BOOL .

  methods ON_OWNER_DESTROYED
    for event EV_AFTER_DESTROY of IF_ISH_DESTROYABLE
    importing
      !SENDER .
ENDCLASS.



CLASS CL_ISH_ENTITY_OBJECT IMPLEMENTATION.


METHOD check.

  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.
  DATA lr_tmp_result                    TYPE REF TO cl_ish_result.

* Process the dependent entity objects.
  lt_depeo = _get_t_loaded_depeo( ).
  LOOP AT lt_depeo INTO lr_depeo.
    CHECK lr_depeo IS BOUND.
    lr_tmp_result = lr_depeo->check( i_check_unchanged_data = i_check_unchanged_data ).
    IF lr_tmp_result IS BOUND.
      lr_tmp_result->merge( ir_other_result = rr_result ).
      rr_result = lr_tmp_result.
    ENDIF.
  ENDLOOP.

* Process the dbentries.
  lt_dbentry = _get_t_dbentry( ).
  LOOP AT lt_dbentry INTO lr_dbentry.
    CHECK lr_dbentry IS BOUND.
    lr_tmp_result = lr_dbentry->check( i_check_unchanged_data = i_check_unchanged_data ).
    IF lr_tmp_result IS BOUND.
      lr_tmp_result->merge( ir_other_result = rr_result ).
      rr_result = lr_tmp_result.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD constructor.

  DATA lr_destroyable           TYPE REF TO if_ish_destroyable.

* Initial checking.
  IF ir_owner IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

* Callback.
  ir_owner->cb_construction( ).

* Set data.
  gr_owner = ir_owner.

* If the owner will get destroyed self has also to be destroyed.
  TRY.
      lr_destroyable ?= gr_owner.
      SET HANDLER on_owner_destroyed FOR lr_destroyable ACTIVATION abap_true.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD eo4owner_after_commit.

  DATA l_deactivate_collect_changes     TYPE abap_bool.
  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

  _check_destroyed( ).

* Callback.
  gr_owner->cb_after_commit( ir_eo = me ).

* Process the dbentries.
  l_deactivate_collect_changes = _activate_collect_changes( ).
  TRY.
      lt_dbentry = _get_t_dbentry( ).
      LOOP AT lt_dbentry INTO lr_dbentry.
        gr_cb_obj = lr_dbentry.
        IF lr_dbentry->dbe4owner_after_commit( ) IS NOT INITIAL.
          r_changed = abap_true.
        ENDIF.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
      IF l_deactivate_collect_changes = abap_true.
        _deactivate_collect_changes( ).
      ENDIF.
  ENDTRY.
  CLEAR gr_cb_obj.
  IF l_deactivate_collect_changes = abap_true.
    _deactivate_collect_changes( ).
  ENDIF.

* Process the dependent entity objects.
  TRY.
      lt_depeo = _get_t_loaded_depeo( ).
      LOOP AT lt_depeo INTO lr_depeo.
        gr_cb_obj = lr_depeo.
        IF lr_depeo->eo4owner_after_commit( ) IS NOT INITIAL.
          r_changed = abap_true.
        ENDIF.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD eo4owner_after_rollback.

  DATA l_deactivate_collect_changes     TYPE abap_bool.
  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

  _check_destroyed( ).

* Callback.
  gr_owner->cb_after_rollback( ir_eo = me ).

* Process the dbentries.
  l_deactivate_collect_changes = _activate_collect_changes( ).
  TRY.
      lt_dbentry = _get_t_dbentry( ).
      LOOP AT lt_dbentry INTO lr_dbentry.
        gr_cb_obj = lr_dbentry.
        IF lr_dbentry->dbe4owner_after_rollback( ) IS NOT INITIAL.
          r_changed = abap_true.
        ENDIF.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
      IF l_deactivate_collect_changes = abap_true.
        _deactivate_collect_changes( ).
      ENDIF.
  ENDTRY.
  CLEAR gr_cb_obj.
  IF l_deactivate_collect_changes = abap_true.
    _deactivate_collect_changes( ).
  ENDIF.

* Process the dependent entity objects.
  TRY.
      lt_depeo = _get_t_loaded_depeo( ).
      LOOP AT lt_depeo INTO lr_depeo.
        gr_cb_obj = lr_depeo.
        IF lr_depeo->eo4owner_after_rollback( ) IS NOT INITIAL.
          r_changed = abap_true.
        ENDIF.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD eo4owner_before_save.

  DATA l_deactivate_collect_changes     TYPE abap_bool.
  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

  _check_destroyed( ).

* Callback.
  gr_owner->cb_before_save( ir_eo = me ).

* Process the dbentries.
  l_deactivate_collect_changes = _activate_collect_changes( ).
  TRY.
      lt_dbentry = _get_t_dbentry( ).
      LOOP AT lt_dbentry INTO lr_dbentry.
        gr_cb_obj = lr_dbentry.
        lr_dbentry->dbe4owner_before_save( ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
      IF l_deactivate_collect_changes = abap_true.
        _deactivate_collect_changes( ).
      ENDIF.
  ENDTRY.
  IF l_deactivate_collect_changes = abap_true.
    _deactivate_collect_changes( ).
  ENDIF.

* Process the dependent entity objects.
  TRY.
      lt_depeo = _get_t_loaded_depeo( ).
      LOOP AT lt_depeo INTO lr_depeo.
        gr_cb_obj = lr_depeo.
        lr_depeo->eo4owner_before_save( ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD eo4owner_clear_all_snapshots.

  DATA l_deactivate_collect_changes     TYPE abap_bool.
  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

  _check_destroyed( ).

* Callback.
  gr_owner->cb_clear_all_snapshots( ir_eo = me ).

* Process the dbentries.
  l_deactivate_collect_changes = _activate_collect_changes( ).
  TRY.
      lt_dbentry = _get_t_dbentry( ).
      LOOP AT lt_dbentry INTO lr_dbentry.
        gr_cb_obj = lr_dbentry.
        lr_dbentry->dbe4owner_clear_all_snapshots( ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
      IF l_deactivate_collect_changes = abap_true.
        _deactivate_collect_changes( ).
      ENDIF.
  ENDTRY.
  CLEAR gr_cb_obj.
  IF l_deactivate_collect_changes = abap_true.
    _deactivate_collect_changes( ).
  ENDIF.

* Process the dependent entity objects.
  TRY.
      lt_depeo = _get_t_loaded_depeo( ).
      LOOP AT lt_depeo INTO lr_depeo.
        gr_cb_obj = lr_depeo.
        lr_depeo->eo4owner_clear_all_snapshots( ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD eo4owner_clear_snapshot.

  DATA l_deactivate_collect_changes     TYPE abap_bool.
  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

  _check_destroyed( ).

* Callback.
  gr_owner->cb_clear_snapshot(
      ir_eo     = me
      i_snapkey = i_snapkey ).

* Process the dbentries.
  l_deactivate_collect_changes = _activate_collect_changes( ).
  TRY.
      lt_dbentry = _get_t_dbentry( ).
      LOOP AT lt_dbentry INTO lr_dbentry.
        gr_cb_obj = lr_dbentry.
        lr_dbentry->dbe4owner_clear_snapshot( i_snapkey = i_snapkey ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
      IF l_deactivate_collect_changes = abap_true.
        _deactivate_collect_changes( ).
      ENDIF.
  ENDTRY.
  CLEAR gr_cb_obj.
  IF l_deactivate_collect_changes = abap_true.
    _deactivate_collect_changes( ).
  ENDIF.

* Process the dependent entity objects.
  TRY.
      lt_depeo = _get_t_loaded_depeo( ).
      LOOP AT lt_depeo INTO lr_depeo.
        gr_cb_obj = lr_depeo.
        lr_depeo->eo4owner_clear_snapshot( i_snapkey = i_snapkey ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD eo4owner_collect_t_bo2save.

* By default no business objects to save.

ENDMETHOD.


METHOD eo4owner_mark_for_deletion.

  DATA l_deactivate_collect_changes     TYPE abap_bool.
  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

  _check_destroyed( ).

* Callback.
  gr_owner->cb_mark_for_deletion( ir_eo = me ).

* Process the dbentries.
  l_deactivate_collect_changes = _activate_collect_changes( ).
  TRY.
      lt_dbentry = _get_t_dbentry( ).
      LOOP AT lt_dbentry INTO lr_dbentry.
        gr_cb_obj = lr_dbentry.
        lr_dbentry->dbe4owner_mark_for_deletion( ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
      IF l_deactivate_collect_changes = abap_true.
        _deactivate_collect_changes( ).
      ENDIF.
  ENDTRY.
  CLEAR gr_cb_obj.
  IF l_deactivate_collect_changes = abap_true.
    _deactivate_collect_changes( ).
  ENDIF.

* Process the dependent entity objects.
  TRY.
      lt_depeo = _get_t_loaded_depeo( ).
      LOOP AT lt_depeo INTO lr_depeo.
        gr_cb_obj = lr_depeo.
        lr_depeo->eo4owner_mark_for_deletion( ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD eo4owner_reload.

  _check_destroyed( ).

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* No processing if self is new.
  CHECK is_new( ) = abap_false.

* Callback.
  gr_owner->cb_reload( ir_eo = me ).

* Internal processing.
  r_changed = _reload( is_data = is_data ).

ENDMETHOD.


METHOD eo4owner_reset.

  _check_destroyed( ).

* No processing if self is new.
  CHECK is_new( ) = abap_false.

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* Callback.
  gr_owner->cb_reset( ir_eo = me ).

* Internal processing.
  r_changed = _reset( ).

ENDMETHOD.


METHOD eo4owner_save.

  DATA lr_main_dbentry                  TYPE REF TO cl_ish_dbentry.
  DATA l_deactivate_collect_changes     TYPE abap_bool.
  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

  _check_destroyed( ).

* Callback.
  gr_owner->cb_save( ir_eo = me ).

* No processing if the main dbentry is deleted or new and marked for deletion.
  lr_main_dbentry = _get_main_dbentry( ).
  IF lr_main_dbentry IS BOUND.
    CHECK lr_main_dbentry->is_deleted( ) = abap_false.
    IF lr_main_dbentry->is_new( ) = abap_true AND
       lr_main_dbentry->is_marked_for_deletion( ) = abap_true.
      RETURN.
    ENDIF.
  ENDIF.

* Get the dbentries to save.
  lt_dbentry = _get_t_dbentry2save( ).

* Get the dependent entity objects to save.
  lt_depeo = _get_t_depeo2save( ).

* Further processing only if we have any objects to save.
  CHECK lt_dbentry IS NOT INITIAL OR
        lt_depeo IS NOT INITIAL.

* If we have any objects to save we have to touch the main dbentry.
  DO 1 TIMES.
    CHECK lr_main_dbentry IS BOUND.
    READ TABLE lt_dbentry WITH TABLE KEY table_line = lr_main_dbentry TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      INSERT lr_main_dbentry INTO TABLE lt_dbentry.
    ENDIF.
    gr_cb_obj = lr_main_dbentry.
    TRY.
        lr_main_dbentry->dbe4owner_touch( ).
      CLEANUP.
        CLEAR gr_cb_obj.
    ENDTRY.
    CLEAR gr_cb_obj.
  ENDDO.

* Process the dbentries.
  l_deactivate_collect_changes = _activate_collect_changes( ).
  TRY.
      lt_dbentry = _get_t_dbentry2save( ).
      LOOP AT lt_dbentry INTO lr_dbentry.
        gr_cb_obj = lr_dbentry.
        CHECK lr_dbentry->dbe4owner_save(
            i_user      = i_user
            i_date      = i_date
            i_time      = i_time
            i_tcode     = i_tcode
            i_timestamp = i_timestamp ) = abap_true.
        r_saved = abap_true.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
      IF l_deactivate_collect_changes = abap_true.
        _deactivate_collect_changes( ).
      ENDIF.
  ENDTRY.
  CLEAR gr_cb_obj.
  IF l_deactivate_collect_changes = abap_true.
    _deactivate_collect_changes( ).
  ENDIF.

* Process the dependent entity objects.
  TRY.
      LOOP AT lt_depeo INTO lr_depeo.
        gr_cb_obj = lr_depeo.
        CHECK lr_depeo->eo4owner_save(
            i_user      = i_user
            i_date      = i_date
            i_time      = i_time
            i_tcode     = i_tcode
            i_timestamp = i_timestamp ) = abap_true.
        r_saved = abap_true.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD eo4owner_snapshot.

  DATA l_deactivate_collect_changes     TYPE abap_bool.
  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

  _check_destroyed( ).

* Callback.
  gr_owner->cb_snapshot(
      ir_eo     = me
      i_snapkey = i_snapkey ).

* Process the dbentries.
  l_deactivate_collect_changes = _activate_collect_changes( ).
  TRY.
      lt_dbentry = _get_t_dbentry( ).
      LOOP AT lt_dbentry INTO lr_dbentry.
        gr_cb_obj = lr_dbentry.
        lr_dbentry->dbe4owner_snapshot( i_snapkey = i_snapkey ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
      IF l_deactivate_collect_changes = abap_true.
        _deactivate_collect_changes( ).
      ENDIF.
  ENDTRY.
  CLEAR gr_cb_obj.
  IF l_deactivate_collect_changes = abap_true.
    _deactivate_collect_changes( ).
  ENDIF.

* Process the dependent entity objects.
  TRY.
      lt_depeo = _get_t_loaded_depeo( ).
      LOOP AT lt_depeo INTO lr_depeo.
        gr_cb_obj = lr_depeo.
        lr_depeo->eo4owner_snapshot( i_snapkey = i_snapkey ).
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD eo4owner_touch.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  _check_destroyed( ).

* Callback.
  gr_owner->cb_touch( ir_eo = me ).

* Touch the main dbentry.
  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.
  gr_cb_obj = lr_main_dbentry.
  TRY.
      lr_main_dbentry->dbe4owner_touch( ).
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD eo4owner_undo.

  DATA l_deactivate_collect_changes     TYPE abap_bool.
  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

  _check_destroyed( ).

* Callback.
  gr_owner->cb_undo(
      ir_eo     = me
      i_snapkey = i_snapkey ).

* Process the dbentries.
  l_deactivate_collect_changes = _activate_collect_changes( ).
  TRY.
      lt_dbentry = _get_t_dbentry( ).
      LOOP AT lt_dbentry INTO lr_dbentry.
        gr_cb_obj = lr_dbentry.
        CHECK lr_dbentry->dbe4owner_undo( i_snapkey ) IS NOT INITIAL.
        r_changed = abap_true.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
      IF l_deactivate_collect_changes = abap_true.
        _deactivate_collect_changes( ).
      ENDIF.
  ENDTRY.
  CLEAR gr_cb_obj.
  IF l_deactivate_collect_changes = abap_true.
    _deactivate_collect_changes( ).
  ENDIF.

* Process the dependent entity objects.
  TRY.
      lt_depeo = _get_t_loaded_depeo( ).
      LOOP AT lt_depeo INTO lr_depeo.
        CHECK lr_depeo->has_snapshot( i_snapkey ) = abap_true.
        gr_cb_obj = lr_depeo.
        IF lr_depeo->eo4owner_undo( i_snapkey ) = abap_true.
          r_changed = abap_true.
        ENDIF.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD eo4owner_untouch.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  _check_destroyed( ).

* Callback.
  gr_owner->cb_untouch( ir_eo = me ).

* Untouch the main dbentry.
  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.
  gr_cb_obj = lr_main_dbentry.
  TRY.
      lr_main_dbentry->dbe4owner_untouch( ).
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD get_dfies_by_fieldname.

  DATA lr_dbentry           TYPE REF TO cl_ish_dbentry.

  lr_dbentry = _get_dbentry4fieldname( i_fieldname ).
  CHECK lr_dbentry IS BOUND.

  rs_dfies = lr_dbentry->get_dfies_by_fieldname(
      i_fieldname = i_fieldname
      i_spras     = i_spras ).

ENDMETHOD.


METHOD get_eoid.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_eoid = lr_main_dbentry->get_dbeid( ).

ENDMETHOD.


METHOD get_owner.

  rr_owner = gr_owner.

ENDMETHOD.


METHOD has_snapshot.

  DATA lr_main_dbentry      TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_has_snapshot = lr_main_dbentry->has_snapshot( i_snapkey ).

ENDMETHOD.


METHOD if_ish_cb_destroyable~cb_destroy.

  CHECK ir_destroyable = gr_cb_obj.

  r_continue = abap_true.

ENDMETHOD.


METHOD if_ish_dbentry_get~get_erdat.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_erdat = lr_main_dbentry->get_erdat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_ertim.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_ertim = lr_main_dbentry->get_ertim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_erusr.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_erusr = lr_main_dbentry->get_erusr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_lodat.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_lodat = lr_main_dbentry->get_lodat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_loekz.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_loekz = lr_main_dbentry->get_loekz( ).

ENDMETHOD.


method IF_ISH_DBENTRY_GET~GET_LOTIM.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_lotim = lr_main_dbentry->get_lotim( ).

endmethod.


METHOD if_ish_dbentry_get~get_lousr.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_lousr = lr_main_dbentry->get_lousr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_mandt.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_mandt = lr_main_dbentry->get_mandt( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_erdat.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_erdat = lr_main_dbentry->get_orig_erdat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_ertim.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_ertim = lr_main_dbentry->get_orig_ertim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_erusr.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_erusr = lr_main_dbentry->get_orig_erusr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_field_content.

  DATA lr_dbentry           TYPE REF TO cl_ish_dbentry.

  lr_dbentry = _get_dbentry4fieldname( i_fieldname = i_fieldname ).
  CHECK lr_dbentry IS BOUND.

  CALL METHOD lr_dbentry->get_orig_field_content
    EXPORTING
      i_fieldname = i_fieldname
    CHANGING
      c_content   = c_content.

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_lodat.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_lodat = lr_main_dbentry->get_orig_lodat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_loekz.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_loekz = lr_main_dbentry->get_orig_loekz( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_lotim.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_lotim = lr_main_dbentry->get_orig_lotim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_lousr.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_lousr = lr_main_dbentry->get_orig_lousr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_mandt.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_mandt = lr_main_dbentry->get_orig_mandt( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_spras.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_spras = lr_main_dbentry->get_orig_spras( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_stodat.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_stodat = lr_main_dbentry->get_orig_stodat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_stoid.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_stoid = lr_main_dbentry->get_orig_stoid( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_stokz.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_stokz = lr_main_dbentry->get_orig_stokz( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_stotim.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_stotim = lr_main_dbentry->get_orig_stotim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_stousr.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_stousr = lr_main_dbentry->get_orig_stousr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_timestamp.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_timestamp = lr_main_dbentry->get_orig_timestamp( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_updat.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_updat = lr_main_dbentry->get_orig_updat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_uptim.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_uptim = lr_main_dbentry->get_orig_uptim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_orig_upusr.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_upusr = lr_main_dbentry->get_orig_upusr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_spras.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_spras = lr_main_dbentry->get_spras( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_stodat.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_stodat = lr_main_dbentry->get_stodat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_stoid.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_stoid = lr_main_dbentry->get_stoid( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_stokz.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_stokz = lr_main_dbentry->get_stokz( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_stotim.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_stotim = lr_main_dbentry->get_stotim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_stousr.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_stousr = lr_main_dbentry->get_stousr( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_timestamp.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_timestamp = lr_main_dbentry->get_timestamp( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_updat.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_updat = lr_main_dbentry->get_updat( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_uptim.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_uptim = lr_main_dbentry->get_uptim( ).

ENDMETHOD.


METHOD if_ish_dbentry_get~get_upusr.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_upusr = lr_main_dbentry->get_upusr( ).

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_after_commit.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_AFTER_COMMIT'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_after_rollback.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_AFTER_ROLLBACK'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_before_save.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_BEFORE_SAVE_DBE'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_clear_all_snapshots.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_CLEAR_ALL_SNAPSHOTS'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_clear_snapshot.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_CLEAR_SNAPSHOT'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_construction.

  IF g_cb_dbentry_construction = abap_false.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_CONSTRUCTION'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_mark_for_deletion.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_MARK_FOR_DELETION'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_reload.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_RELOAD'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_reset.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_RESET'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_save.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_SAVE'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_snapshot.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_SNAPSHOT'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_touch.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_TOUCH'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_undo.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_UNDO'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~cb_untouch.

  IF ir_dbentry <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_UNTOUCH'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dbentry_owner~get_active_snapkey.

  CHECK gr_owner IS BOUND.

  r_snapkey = gr_owner->get_active_snapkey( ).

ENDMETHOD.


METHOD if_ish_destroyable~destroy.

  DATA lr_destroyable_owner             TYPE REF TO if_ish_destroyable.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

* No processing if self is already destroyed.
  IF is_destroyed( ) = abap_true.
    r_destroyed = abap_true.
    RETURN.
  ENDIF.

* Callback.
* A callback is only needed if the owner is not destroyed.
  TRY.
      lr_destroyable_owner ?= gr_owner.
    CATCH cx_sy_move_cast_error.
      CLEAR lr_destroyable_owner.
  ENDTRY.
  IF lr_destroyable_owner IS NOT BOUND OR
     lr_destroyable_owner->is_destroyed( ) = abap_false.
    CHECK gr_owner->cb_destroy( me ) = abap_true.
  ENDIF.

* We are in destroy mode.
  g_destroy_mode = abap_true.

* Raise event ev_before_destroy.
  RAISE EVENT ev_before_destroy.

* Deregister the dbentry eventhandlers.
  lt_dbentry = _get_t_dbentry( ).
  LOOP AT lt_dbentry INTO lr_dbentry.
    _register_dbentry_events(
        ir_dbentry   = lr_dbentry
        i_activation = abap_false ).
  ENDLOOP.

* Internal processing.
  _destroy( ).

* Destroy attributes.
  CLEAR gr_cb_obj.
  CLEAR gt_changed_field.
  CLEAR g_cb_dbentry_construction.
  CLEAR g_collect_changes.

* Now we are destroyed.
  IF lr_destroyable_owner IS BOUND.
    SET HANDLER on_owner_destroyed FOR lr_destroyable_owner ACTIVATION abap_false.
  ENDIF.
  CLEAR gr_owner.
  g_destroy_mode = abap_false.

* Raise event ev_after_destroy.
  RAISE EVENT ev_after_destroy.

* Export.
  r_destroyed = abap_true.

ENDMETHOD.


METHOD if_ish_destroyable~is_destroyed.

  IF gr_owner IS NOT BOUND.
    r_destroyed = abap_true.
  ENDIF.

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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_before_save.

  IF ir_eo <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_BEFORE_SAVE_DEPEO'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~cb_construction.

  IF g_cb_depeo_construction = abap_false.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_CONSTRUCTION'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
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
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_entity_object_owner~get_active_snapkey.

  r_snapkey = if_ish_dbentry_owner~get_active_snapkey( ).

ENDMETHOD.


METHOD if_ish_gui_cb_structure_model~cb_set_field_content.

  DATA lr_dbentry           TYPE REF TO cl_ish_dbentry.

* Check.
  IF ir_model <> gr_cb_obj.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

* Further processing only if the given model is a dbentry.
  TRY.
      lr_dbentry ?= ir_model.
    CATCH cx_sy_move_cast_error.
      r_continue = abap_true.
      RETURN.
  ENDTRY.

* No processing if the field is not changeable.
  IF is_field_changeable( i_fieldname ) = abap_false.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'CB_SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

* Callback.
  r_continue = gr_owner->cb_set_field_content(
      ir_model    = me
      i_fieldname = i_fieldname
      i_content   = i_content ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA lr_dbentry           TYPE REF TO cl_ish_dbentry.

  CASE i_fieldname.
    WHEN co_fieldname_eoid.
      c_content = get_eoid( ).
    WHEN OTHERS.
*     Get the corresponding dbentry.
      lr_dbentry = _get_dbentry4fieldname( i_fieldname ).
      IF lr_dbentry IS NOT BOUND.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '1'
            i_mv2        = 'GET_FIELD_CONTENT'
            i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
      ENDIF.

*     Wrap to the corresponding data object.
      CALL METHOD lr_dbentry->get_field_content
        EXPORTING
          i_fieldname = i_fieldname
        CHANGING
          c_content   = c_content.
  ENDCASE.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  DATA lt_dbentry                   TYPE ish_t_dbe_objh.
  DATA lr_dbentry                   TYPE REF TO cl_ish_dbentry.
  DATA lt_tmp_fieldname             TYPE ish_t_fieldname.

  FIELD-SYMBOLS <l_tmp_fieldname> TYPE ish_fieldname.

* Get the dbentries.
  lt_dbentry = _get_t_dbentry( ).

* Sum up the supported fields of each data object.
  LOOP AT lt_dbentry INTO lr_dbentry.
    CHECK lr_dbentry IS BOUND.
    lt_tmp_fieldname = lr_dbentry->get_supported_fields( ).
    IF rt_supported_fieldname IS INITIAL.
      rt_supported_fieldname = lt_tmp_fieldname.
    ELSE.
      LOOP AT lt_tmp_fieldname ASSIGNING <l_tmp_fieldname>.
        READ TABLE rt_supported_fieldname FROM <l_tmp_fieldname> TRANSPORTING NO FIELDS.
        CHECK sy-subrc <> 0.
        INSERT <l_tmp_fieldname> INTO TABLE rt_supported_fieldname.
      ENDLOOP.
    ENDIF.
  ENDLOOP.

* Add the eoid.
  INSERT co_fieldname_eoid INTO TABLE rt_supported_fieldname.

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  DATA lt_fieldname               TYPE ish_t_fieldname.

  lt_fieldname = get_supported_fields( ).

  READ TABLE lt_fieldname FROM i_fieldname TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_supported = abap_true.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  DATA lr_dbentry                     TYPE REF TO cl_ish_dbentry.

* Get the corresponding dbentry.
  lr_dbentry = _get_dbentry4fieldname( i_fieldname ).
  IF lr_dbentry IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

* Wrap to the corresponding dbentry.
  gr_cb_obj = lr_dbentry.
  TRY.
      r_changed = lr_dbentry->set_field_content(
          i_fieldname = i_fieldname
          i_content   = i_content ).
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~get_data.

  DATA lr_structdescr                     TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname                        TYPE ish_fieldname.

  FIELD-SYMBOLS <ls_component>            TYPE abap_compdescr.
  FIELD-SYMBOLS <l_target_field>          TYPE ANY.

  _check_destroyed( ).

* cs_data has to be a structure.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( cs_data ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'GET_DATA'
          i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDTRY.

* Take over fields.
  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE cs_data
      TO <l_target_field>.
    CHECK sy-subrc = 0.
    CHECK is_field_supported( l_fieldname ) = abap_true.
    CALL METHOD get_field_content
      EXPORTING
        i_fieldname = l_fieldname
      CHANGING
        c_content   = <l_target_field>.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~is_field_changeable.

  DATA lr_dbentry           TYPE REF TO cl_ish_dbentry.

* No processing on destroyed object.
  CHECK is_destroyed( ) = abap_false.

* Check readonly.
  CHECK is_readonly( ) = abap_false.

* Get the dbentry.
  lr_dbentry = _get_dbentry4fieldname( i_fieldname ).
  CHECK lr_dbentry IS BOUND.

* Call the dbentry.
  r_changeable = lr_dbentry->is_field_changeable( i_fieldname ).

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~is_readonly.

  DATA lr_bo                  TYPE REF TO if_ish_business_object.
  DATA lr_lockable            TYPE REF TO if_ish_lockable.

  r_readonly = abap_true.

* If self is destroyed self is readonly.
  CHECK is_destroyed( ) = abap_false.

* Check the owner.
  TRY.
      lr_bo ?= gr_owner.
      CHECK lr_bo->is_readonly( ) = abap_false.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

* Only if self is a lockable object:
*   If self is not locked self is readonly.
  TRY.
      lr_lockable ?= me.
      CHECK lr_lockable->is_locked( ) = abap_true.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

* Self is not readonly.
  r_readonly = abap_false.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~set_data.

  DATA lr_structdescr                     TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname                        TYPE ish_fieldname.
  DATA l_fieldname_x                      TYPE ish_fieldname.
  DATA l_deactivate_collect_changes       TYPE abap_bool.
  DATA l_rc                               TYPE ish_method_rc.
  DATA lr_messages                        TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_static                          TYPE REF TO cx_ish_static_handler.

  FIELD-SYMBOLS <ls_component>            TYPE abap_compdescr.
  FIELD-SYMBOLS <l_source_field>          TYPE ANY.
  FIELD-SYMBOLS <l_source_field_x>        TYPE ANY.
  FIELD-SYMBOLS <l_target_field>          TYPE ANY.

  _check_destroyed( ).

* cs_data has to be a structure.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( is_data ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'SET_DATA'
          i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDTRY.

  l_deactivate_collect_changes = _activate_collect_changes( ).

  TRY.

      LOOP AT lr_structdescr->components ASSIGNING <ls_component>.

        l_fieldname = <ls_component>-name.

        IF it_field2change IS NOT INITIAL.
          READ TABLE it_field2change FROM l_fieldname TRANSPORTING NO FIELDS.
          CHECK sy-subrc = 0.
        ENDIF.

        IF i_handle_xfields = abap_true.
          CONCATENATE l_fieldname 'X' INTO l_fieldname_x SEPARATED BY '_'.
          ASSIGN COMPONENT l_fieldname_x
            OF STRUCTURE is_data
            TO <l_source_field_x>.
          CHECK sy-subrc = 0.
          CHECK <l_source_field_x> = abap_true.
        ENDIF.

        IF i_soft = abap_true.
          CHECK is_field_changeable( l_fieldname ) = abap_true.
        ENDIF.

        ASSIGN COMPONENT l_fieldname
          OF STRUCTURE is_data
          TO <l_source_field>.
        CHECK sy-subrc = 0.

        TRY.
            CHECK set_field_content(
                i_fieldname = l_fieldname
                i_content   = <l_source_field> ) = abap_true.
          CATCH cx_ish_static_handler INTO lx_static.
            l_rc = 1.
            IF lr_messages IS BOUND.
              IF lx_static->gr_errorhandler IS BOUND.
                lr_messages->copy_messages( i_copy_from = lx_static->gr_errorhandler ).
              ENDIF.
            ELSE.
              lr_messages = lx_static->gr_errorhandler.
            ENDIF.
            CONTINUE.
        ENDTRY.

        INSERT l_fieldname INTO TABLE rt_changed_field.

      ENDLOOP.

    CLEANUP.

      IF l_deactivate_collect_changes = abap_true.
        _deactivate_collect_changes( ).
      ENDIF.
  ENDTRY.

  IF l_deactivate_collect_changes = abap_true.
    _deactivate_collect_changes( ).
  ENDIF.

  IF l_rc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_messages.
  ENDIF.

ENDMETHOD.


METHOD is_changed.

  DATA lr_main_dbentry                  TYPE REF TO cl_ish_dbentry.
  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

* Self is not changed if our main dbentry is deleted or new and marked for deletion.
  lr_main_dbentry = _get_main_dbentry( ).
  IF lr_main_dbentry IS BOUND.
    CHECK lr_main_dbentry->is_deleted( ) = abap_false.
    IF lr_main_dbentry->is_new( ) = abap_true AND
       lr_main_dbentry->is_marked_for_deletion( ) = abap_true.
      RETURN.
    ENDIF.
  ENDIF.

* Process the dependent entity objects.
  lt_depeo = _get_t_loaded_depeo( ).
  LOOP AT lt_depeo INTO lr_depeo.
    CHECK lr_depeo IS BOUND.
    CHECK lr_depeo->is_changed( ) = abap_true.
    r_changed = abap_true.
    RETURN.
  ENDLOOP.

* Process the dbentries.
  lt_dbentry = _get_t_dbentry( ).
  LOOP AT lt_dbentry INTO lr_dbentry.
    CHECK lr_dbentry IS BOUND.
    CHECK lr_dbentry->is_changed( ) = abap_true.
    r_changed = abap_true.
    RETURN.
  ENDLOOP.

ENDMETHOD.


METHOD is_deleted.

  DATA lr_main_dbentry      TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_deleted = lr_main_dbentry->is_deleted( ).

ENDMETHOD.


METHOD is_field_changed.

  DATA lr_dbentry           TYPE REF TO cl_ish_dbentry.

  lr_dbentry = _get_dbentry4fieldname( i_fieldname ).
  CHECK lr_dbentry IS BOUND.

  r_changed = lr_dbentry->is_field_changed( i_fieldname ).

ENDMETHOD.


METHOD is_marked_for_deletion.

  DATA lr_main_dbentry      TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_marked_for_deletion = lr_main_dbentry->is_marked_for_deletion( ).

ENDMETHOD.


METHOD is_new.

  DATA lr_main_dbentry      TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_new = lr_main_dbentry->is_new( ).

ENDMETHOD.


METHOD is_touched.

  DATA lr_main_dbentry      TYPE REF TO cl_ish_dbentry.

  lr_main_dbentry = _get_main_dbentry( ).
  CHECK lr_main_dbentry IS BOUND.

  r_touched = lr_main_dbentry->is_touched( ).

ENDMETHOD.


METHOD on_dbentry_after_destroy.

  DATA lr_dbentry           TYPE REF TO cl_ish_dbentry.

* Check the sender.
  CHECK sender IS BOUND.
  TRY.
      lr_dbentry ?= sender.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Deregister the eventhandlers.
  _register_dbentry_events(
      ir_dbentry   = lr_dbentry
      i_activation = abap_false ).

* Internal processing to clear the attribute.
  _on_dbentry_after_destroy( lr_dbentry ).

ENDMETHOD.


METHOD on_dbentry_changed.

  DATA lr_dbentry                           TYPE REF TO cl_ish_dbentry.

  FIELD-SYMBOLS <l_changed_field>           TYPE ish_fieldname.

* Check the sender.
  CHECK sender IS BOUND.
  TRY.
      lr_dbentry ?= sender.
    CATCH cx_sy_move_cast_error.
  ENDTRY.
  CHECK lr_dbentry->get_owner( ) = me.

* Collect changes?
  IF g_collect_changes = abap_true.
    LOOP AT et_changed_field ASSIGNING <l_changed_field>.
      READ TABLE gt_changed_field FROM <l_changed_field> TRANSPORTING NO FIELDS.
      CHECK sy-subrc <> 0.
      INSERT <l_changed_field> INTO TABLE gt_changed_field.
    ENDLOOP.
    RETURN.
  ENDIF.

* Raise our ev_changed event.
  _raise_ev_changed( it_changed_field = et_changed_field ).

ENDMETHOD.


METHOD on_owner_destroyed.

* Check the sender (has to be our owner).
  CHECK sender IS BOUND.
  CHECK sender = gr_owner.

* Or owner was destroyed.
* So we have to destroy ourself.
  destroy( ).

ENDMETHOD.


METHOD _activate_collect_changes.

  CHECK g_collect_changes = abap_false.

  g_collect_changes = abap_true.

  r_activated = abap_true.

ENDMETHOD.


METHOD _check_destroyed.

  IF is_destroyed( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_DESTROYED'
        i_mv3        = 'CL_ISH_ENTITY_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD _deactivate_collect_changes.

  DATA lt_changed_field           TYPE ish_t_fieldname.

* Reset g_collect_changes.
  g_collect_changes = abap_false.

* Raise ev_changed.
  CHECK gt_changed_field IS NOT INITIAL.
  lt_changed_field = gt_changed_field.
  CLEAR gt_changed_field.
  _raise_ev_changed( it_changed_field = lt_changed_field ).

ENDMETHOD.


METHOD _get_dbentry4fieldname.

  DATA lr_main_dbentry                TYPE REF TO cl_ish_dbentry.
  DATA lt_dbentry                     TYPE ish_t_dbe_objh.
  DATA lr_dbentry                     TYPE REF TO cl_ish_dbentry.

* The main dbentry has first priority.
  lr_main_dbentry = _get_main_dbentry( ).
  IF lr_main_dbentry IS BOUND AND
     lr_main_dbentry->is_field_supported( i_fieldname ) = abap_true.
    rr_dbentry = lr_main_dbentry.
    RETURN.
  ENDIF.

* The field is not supported by the main dbentry.
* So use the other dbentries.
  lt_dbentry = _get_t_dbentry( ).
  LOOP AT lt_dbentry INTO lr_dbentry.
    CHECK lr_dbentry IS BOUND.
    CHECK lr_dbentry <> lr_main_dbentry.
    CHECK lr_dbentry->is_field_supported( i_fieldname ) = abap_true.
    rr_dbentry = lr_dbentry.
    RETURN.
  ENDLOOP.

ENDMETHOD.


METHOD _get_t_dbentry2save.

  DATA lr_main_dbentry            TYPE REF TO cl_ish_dbentry.
  DATA lt_dbentry                 TYPE ish_t_dbe_objh.
  DATA lr_dbentry                 TYPE REF TO cl_ish_dbentry.

* Get the dbentries.
  lt_dbentry = _get_t_dbentry( ).

* Return the relevant dbentries.
  LOOP AT lt_dbentry INTO lr_dbentry.
    CHECK lr_dbentry IS BOUND.
    CHECK lr_dbentry->is_touched( ) = abap_true OR
          lr_dbentry->is_changed( ) = abap_true.
    INSERT lr_dbentry INTO TABLE rt_dbentry.
  ENDLOOP.

* If there is any dbentry to save or there is any depeo to save
* we have also to save the main dbentry (timestamp).
  DO 1 TIMES.
    lr_main_dbentry = _get_main_dbentry( ).
    CHECK lr_main_dbentry IS BOUND.
    READ TABLE rt_dbentry WITH TABLE KEY table_line = lr_main_dbentry TRANSPORTING NO FIELDS.
    CHECK sy-subrc <> 0.
    IF it_depeo2save IS SUPPLIED.
      CHECK rt_dbentry IS NOT INITIAL OR
            it_depeo2save IS NOT INITIAL.
    ELSE.
      CHECK rt_dbentry IS NOT INITIAL OR
            _get_t_depeo2save( ) IS NOT INITIAL.
    ENDIF.
    INSERT lr_main_dbentry INTO TABLE rt_dbentry.
  ENDDO.

ENDMETHOD.


METHOD _get_t_depeo2save.

  DATA lt_depeo                   TYPE ish_t_eo_objh.
  DATA lr_depeo                   TYPE REF TO cl_ish_entity_object.

* Get the dependent entity objects.
  lt_depeo = _get_t_loaded_depeo( ).

* Return the relevant entity objects.
  LOOP AT lt_depeo INTO lr_depeo.
    CHECK lr_depeo IS BOUND.
    CHECK lr_depeo->is_touched( ) = abap_true OR
          lr_depeo->is_changed( ) = abap_true.
    INSERT lr_depeo INTO TABLE rt_eo.
  ENDLOOP.

ENDMETHOD.


METHOD _get_t_loaded_depeo.

* No dependent entity objects by default.

ENDMETHOD.


method _ON_DBENTRY_AFTER_DESTROY.
endmethod.


METHOD _raise_ev_changed.

  rt_changed_field = it_changed_field.
  IF i_changed_field IS NOT INITIAL.
    INSERT i_changed_field INTO TABLE rt_changed_field.
  ENDIF.

  READ TABLE rt_changed_field
    FROM cl_ish_dbentry=>co_fieldname_g_marked_for_del
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    RAISE EVENT ev_g_marked_for_del_changed.
  ENDIF.

  READ TABLE rt_changed_field
    FROM cl_ish_dbentry=>co_fieldname_stokz
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    RAISE EVENT ev_stokz_changed.
  ENDIF.

  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = rt_changed_field.

ENDMETHOD.


METHOD _register_dbentry_events.

  CHECK ir_dbentry IS BOUND.

  IF i_activation = abap_true.
    CHECK ir_dbentry->get_owner( ) = me.
  ENDIF.

  SET HANDLER on_dbentry_changed        FOR ir_dbentry ACTIVATION i_activation.
  SET HANDLER on_dbentry_after_destroy  FOR ir_dbentry ACTIVATION i_activation.

ENDMETHOD.


METHOD _reset.

  DATA l_deactivate_collect_changes     TYPE abap_bool.
  DATA lt_depeo                         TYPE ish_t_eo_objh.
  DATA lr_depeo                         TYPE REF TO cl_ish_entity_object.
  DATA lt_dbentry                       TYPE ish_t_dbe_objh.
  DATA lr_dbentry                       TYPE REF TO cl_ish_dbentry.

* Process the dbentries.
  l_deactivate_collect_changes = _activate_collect_changes( ).
  TRY.
      lt_dbentry = _get_t_dbentry( ).
      LOOP AT lt_dbentry INTO lr_dbentry.
        gr_cb_obj = lr_dbentry.
        IF lr_dbentry->dbe4owner_reset( ) IS NOT INITIAL.
          r_changed = abap_true.
        ENDIF.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
      IF l_deactivate_collect_changes = abap_true.
        _deactivate_collect_changes( ).
      ENDIF.
  ENDTRY.
  CLEAR gr_cb_obj.
  IF l_deactivate_collect_changes = abap_true.
    _deactivate_collect_changes( ).
  ENDIF.

* Process the dependent entity objects.
  TRY.
      lt_depeo = _get_t_loaded_depeo( ).
      LOOP AT lt_depeo INTO lr_depeo.
        CHECK lr_depeo->is_deleted( ) = abap_false.
        gr_cb_obj = lr_depeo.
        IF lr_depeo->is_new( ) = abap_true.
          CHECK lr_depeo->is_marked_for_deletion( ) = abap_false.
          lr_depeo->eo4owner_mark_for_deletion( ).
        ELSE.
          CHECK lr_depeo->eo4owner_reset( ) = abap_true.
        ENDIF.
        r_changed = abap_true.
      ENDLOOP.
    CLEANUP.
      CLEAR gr_cb_obj.
  ENDTRY.
  CLEAR gr_cb_obj.

ENDMETHOD.
ENDCLASS.
