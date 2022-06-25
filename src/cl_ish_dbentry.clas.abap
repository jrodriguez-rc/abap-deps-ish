class CL_ISH_DBENTRY definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_DBENTRY
*"* do not include other source files here!!!

  interfaces IF_ISH_DBENTRY_GET .
  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .
  interfaces IF_ISH_GUI_XSTRUCTURE_MODEL .

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

  constants CO_CDCHNGIND_DELETE type CDCHNGIND value 'D'. "#EC NOTEXT
  constants CO_CDCHNGIND_INSERT type CDCHNGIND value 'I'. "#EC NOTEXT
  constants CO_CDCHNGIND_UPDATE type CDCHNGIND value 'U'. "#EC NOTEXT
  constants CO_FIELDNAME_ERDAT type ISH_FIELDNAME value 'ERDAT'. "#EC NOTEXT
  constants CO_FIELDNAME_ERTIM type ISH_FIELDNAME value 'ERTIM'. "#EC NOTEXT
  constants CO_FIELDNAME_ERUSR type ISH_FIELDNAME value 'ERUSR'. "#EC NOTEXT
  constants CO_FIELDNAME_G_DELETED type ISH_FIELDNAME value '#G_DELETED'. "#EC NOTEXT
  constants CO_FIELDNAME_G_MARKED_FOR_DEL type ISH_FIELDNAME value '#G_MARKED_FOR_DELETION'. "#EC NOTEXT
  constants CO_FIELDNAME_G_NEW type ISH_FIELDNAME value '#G_NEW'. "#EC NOTEXT
  constants CO_FIELDNAME_G_TOUCHED type ISH_FIELDNAME value '#G_TOUCHED'. "#EC NOTEXT
  constants CO_FIELDNAME_LODAT type ISH_FIELDNAME value 'LODAT'. "#EC NOTEXT
  constants CO_FIELDNAME_LOEKZ type ISH_FIELDNAME value 'LOEKZ'. "#EC NOTEXT
  constants CO_FIELDNAME_LOTIM type ISH_FIELDNAME value 'LOTIM'. "#EC NOTEXT
  constants CO_FIELDNAME_LOUSR type ISH_FIELDNAME value 'LOUSR'. "#EC NOTEXT
  constants CO_FIELDNAME_MANDT type ISH_FIELDNAME value 'MANDT'. "#EC NOTEXT
  constants CO_FIELDNAME_SPRAS type ISH_FIELDNAME value 'SPRAS'. "#EC NOTEXT
  constants CO_FIELDNAME_STODAT type ISH_FIELDNAME value 'STODAT'. "#EC NOTEXT
  constants CO_FIELDNAME_STOID type ISH_FIELDNAME value 'STOID'. "#EC NOTEXT
  constants CO_FIELDNAME_STOKZ type ISH_FIELDNAME value 'STOKZ'. "#EC NOTEXT
  constants CO_FIELDNAME_STOTIM type ISH_FIELDNAME value 'STOTIM'. "#EC NOTEXT
  constants CO_FIELDNAME_STOUSR type ISH_FIELDNAME value 'STOUSR'. "#EC NOTEXT
  constants CO_FIELDNAME_TIMESTAMP type ISH_FIELDNAME value 'TIMESTAMP'. "#EC NOTEXT
  constants CO_FIELDNAME_UPDAT type ISH_FIELDNAME value 'UPDAT'. "#EC NOTEXT
  constants CO_FIELDNAME_UPTIM type ISH_FIELDNAME value 'UPTIM'. "#EC NOTEXT
  constants CO_FIELDNAME_UPUSR type ISH_FIELDNAME value 'UPUSR'. "#EC NOTEXT

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
      !IR_OWNER type ref to IF_ISH_DBENTRY_OWNER
      !I_NEW type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_AFTER_COMMIT
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_AFTER_ROLLBACK
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_BEFORE_SAVE
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_CLEAR_ALL_SNAPSHOTS
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_CLEAR_SNAPSHOT
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_MARK_FOR_DELETION
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_RELOAD
    importing
      !IS_DATA type DATA
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_RESET
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_SAVE
    importing
      !I_USER type SY-UNAME
      !I_DATE type SY-DATUM
      !I_TIME type SY-UZEIT
      !I_TCODE type SY-TCODE
      !I_TIMESTAMP type TIMESTAMPL
    returning
      value(R_SAVED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_SNAPSHOT
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_TOUCH
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_UNDO
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods DBE4OWNER_UNTOUCH
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DBEID
  abstract
    returning
      value(R_DBEID) type N1DBEID .
  methods GET_DFIES_BY_FIELDNAME
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_SPRAS type SYLANGU default SY-LANGU
    returning
      value(RS_DFIES) type DFIES .
  methods GET_ORIG_DATA
    changing
      !CS_DATA type DATA
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_OWNER
  final
    returning
      value(RR_OWNER) type ref to IF_ISH_DBENTRY_OWNER .
  methods GET_STRUCTDESCR
    returning
      value(RR_STRUCTDESCR) type ref to CL_ABAP_STRUCTDESCR .
  methods GET_TABNAME
    returning
      value(R_TABNAME) type TABNAME .
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
*"* protected components of class CL_ISH_DBENTRY
*"* do not include other source files here!!!

  methods _AUTOGEN_ERINFO
    importing
      !I_USER type SYUNAME
      !I_DATE type SYDATUM
      !I_TIME type SYUZEIT
    changing
      !CS_DATA type DATA .
  methods _AUTOGEN_LOINFO
    importing
      !I_USER type SYUNAME
      !I_DATE type SYDATUM
      !I_TIME type SYUZEIT
    changing
      !CS_DATA type DATA .
  methods _AUTOGEN_STINFO
    importing
      !I_USER type SYUNAME
      !I_DATE type SYDATUM
      !I_TIME type SYUZEIT
    changing
      !CS_DATA type DATA .
  methods _AUTOGEN_TIMESTAMP
    importing
      !I_TIMESTAMP type TIMESTAMPL
    changing
      !CS_DATA type DATA .
  methods _AUTOGEN_UPINFO
    importing
      !I_USER type SYUNAME
      !I_DATE type SYDATUM
      !I_TIME type SYUZEIT
    changing
      !CS_DATA type DATA .
  methods _CHANGE_ACT_DATA
    importing
      !IS_DATA type DATA
      !I_CHECK type ABAP_BOOL default ABAP_TRUE
      !I_RAISE_EV_CHANGED type ABAP_BOOL default ABAP_TRUE
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK
  abstract
    importing
      !I_CHECK_UNCHANGED_DATA type ABAP_BOOL default ABAP_FALSE
    preferred parameter I_CHECK_UNCHANGED_DATA
    returning
      value(RR_RESULT) type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_DESTROYED
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_FIELD_CHANGEABLE
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_SAVE_NOT_IN_PROCESS
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_SET_FIELD_CONTENT
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_CONTENT type ANY
    returning
      value(R_ALLOWED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DESTROY
  abstract .
  methods _FILL_DATA2SAVE
    importing
      !I_USER type SY-UNAME
      !I_DATE type SY-DATUM
      !I_TIME type SY-UZEIT
      !I_TCODE type SY-TCODE
      !I_TIMESTAMP type TIMESTAMPL
    changing
      !CS_DATA2SAVE type DATA
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_AUTOGEN_ERINFO
    returning
      value(R_AUTOGEN) type ABAP_BOOL .
  methods _GET_AUTOGEN_LOINFO
    returning
      value(R_AUTOGEN) type ABAP_BOOL .
  methods _GET_AUTOGEN_STINFO
    returning
      value(R_AUTOGEN) type ABAP_BOOL .
  methods _GET_AUTOGEN_TIMESTAMP
    returning
      value(R_AUTOGEN) type ABAP_BOOL .
  methods _GET_AUTOGEN_UPINFO
    returning
      value(R_AUTOGEN) type ABAP_BOOL .
  methods _GET_R_ACT_DATA
  abstract
    returning
      value(RR_ACT_DATA) type ref to DATA .
  methods _GET_R_ORIG_DATA
    returning
      value(RR_ORIG_DATA) type ref to DATA .
  methods _GET_R_SAVED_DATA
    returning
      value(RR_SAVED_DATA) type ref to DATA .
  methods _IS_FIELD_CHANGEABLE
  abstract
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_CHANGEABLE) type ABAP_BOOL .
  methods _RAISE_EV_CHANGED
    importing
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME .
  methods _SAVE
  abstract
    importing
      !IS_DATA2SAVE type DATA
      !I_KZ type CDCHNGIND
      !IS_ORIG_DATA type DATA optional
      !I_USER type SYUNAME
      !I_DATE type SYDATUM
      !I_TIME type SYUZEIT
      !I_TCODE type SYTCODE
      !I_TIMESTAMP type TIMESTAMPL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SET_ACT_FIELD_CONTENT
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_CONTENT type ANY
      !I_CHECK type ABAP_BOOL default ABAP_TRUE
      !I_RAISE_EV_CHANGED type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SNAPSHOT
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_DBENTRY
*"* do not include other source files here!!!

  data GR_ORIG_DATA type ref to DATA .
  data GR_OWNER type ref to IF_ISH_DBENTRY_OWNER .
  data GR_SAVED_DATA type ref to DATA .
  data GT_SNAPSHOT type ISH_T_DBESNAP_HASH .
  type-pools ABAP .
  data G_DELETED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .
  data G_MARKED_FOR_DELETION type ABAP_BOOL .
  data G_NEW type ABAP_BOOL .
  data G_TOUCHED type ABAP_BOOL .

  methods ON_OWNER_DESTROYED
    for event EV_AFTER_DESTROY of IF_ISH_DESTROYABLE
    importing
      !SENDER .
ENDCLASS.



CLASS CL_ISH_DBENTRY IMPLEMENTATION.


METHOD check.

* No processing on destroyed object.
  _check_destroyed( ).

* No processing on deleted objects.
  CHECK is_deleted( ) = abap_false.

* No processing if self is marked for deletion.
  CHECK is_marked_for_deletion( ) = abap_false.

* Internal processing.
  rr_result = _check( i_check_unchanged_data = i_check_unchanged_data ).

ENDMETHOD.


METHOD constructor.

  DATA l_active_snapkey         TYPE ish_snapkey.
  DATA ls_snapshot              LIKE LINE OF gt_snapshot.
  DATA lr_destroyable           TYPE REF TO if_ish_destroyable.

* Initial checking.
  IF ir_owner IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_DBENTRY' ).
  ENDIF.

* Callback.
  ir_owner->cb_construction( ).

* Set data.
  gr_owner  = ir_owner.
  g_new     = i_new.

* On new object: create initial snapshots.
* In case of undo self will be marked for deletion.
  IF i_new = abap_true.
    l_active_snapkey = gr_owner->get_active_snapkey( ).
    ls_snapshot-snapkey = 1.
    WHILE ls_snapshot-snapkey <= l_active_snapkey.
      ls_snapshot-marked_for_deletion = abap_true.
      INSERT ls_snapshot INTO TABLE gt_snapshot.
      ls_snapshot-snapkey = ls_snapshot-snapkey + 1.
    ENDWHILE.
  ENDIF.

* Register on_owner_destroyed.
  TRY.
      lr_destroyable ?= gr_owner.
      SET HANDLER on_owner_destroyed  FOR lr_destroyable ACTIVATION abap_true.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD dbe4owner_after_commit.

  DATA lt_changed_field_1               TYPE ish_t_fieldname.
  DATA lt_changed_field_2               TYPE ish_t_fieldname.

  FIELD-SYMBOLS <ls_saved_data>         TYPE data.

* No processing on destroyed object.
  _check_destroyed( ).

* Callback.
  gr_owner->cb_after_commit( ir_dbentry = me ).

* Process only on saved data.
  CHECK gr_saved_data IS BOUND.

* No processing on deleted objects.
  CHECK is_deleted( ) = abap_false.

* Self is no more new.
  IF g_new = abap_true.
    g_new = abap_false.
    INSERT co_fieldname_g_new INTO TABLE lt_changed_field_1.
  ENDIF.

* Self is no more touched.
  IF g_touched = abap_true.
    g_touched = abap_false.
    INSERT co_fieldname_g_touched INTO TABLE lt_changed_field_1.
  ENDIF.

* Handle deletion.
  IF is_marked_for_deletion( ) = abap_true.
    g_deleted = abap_true.
    g_marked_for_deletion = abap_false.
    INSERT co_fieldname_g_deleted INTO TABLE lt_changed_field_1.
    INSERT co_fieldname_g_marked_for_del INTO TABLE lt_changed_field_1.
  ENDIF.

* Set saved data as actual data.
  ASSIGN gr_saved_data->* TO <ls_saved_data>.
  lt_changed_field_2 = _change_act_data(
      is_data             = <ls_saved_data>
      i_check             = abap_false
      i_raise_ev_changed  = abap_false ).

* Clear saved and orig data.
  CLEAR gr_orig_data.
  CLEAR gr_saved_data.

* Handle rt_changed_field.
  rt_changed_field = lt_changed_field_1.
  APPEND LINES OF lt_changed_field_2 TO rt_changed_field.

* Raise event ev_changed.
  _raise_ev_changed( rt_changed_field ).

ENDMETHOD.


METHOD dbe4owner_after_rollback.

* No processing on destroyed object.
  _check_destroyed( ).

* Callback.
  gr_owner->cb_after_rollback( ir_dbentry = me ).

* Process only on saved data.
  CHECK gr_saved_data IS BOUND.

* Clear gr_saved_data.
  CLEAR gr_saved_data.

ENDMETHOD.


METHOD dbe4owner_before_save.

* No processing on destroyed object.
  _check_destroyed( ).

* Callback.
  gr_owner->cb_before_save( ir_dbentry = me ).

ENDMETHOD.


METHOD dbe4owner_clear_all_snapshots.

* No processing on destroyed object.
  _check_destroyed( ).

* Callback.
  gr_owner->cb_clear_all_snapshots( ir_dbentry = me ).

* No processing if save is in process.
  _check_save_not_in_process( ).

* Clear all snapshots.
  CLEAR gt_snapshot.

ENDMETHOD.


METHOD dbe4owner_clear_snapshot.

  DATA ls_snapshot                      LIKE LINE OF gt_snapshot.

  FIELD-SYMBOLS <ls_snapshot>           LIKE LINE OF gt_snapshot.

* No processing on destroyed object.
  _check_destroyed( ).

* Callback.
  gr_owner->cb_clear_snapshot(
      ir_dbentry  = me
      i_snapkey   = i_snapkey ).

* No processing if save is in process.
  _check_save_not_in_process( ).

* Clear the snapshot.
  READ TABLE gt_snapshot WITH TABLE KEY snapkey = i_snapkey INTO ls_snapshot.
  CHECK sy-subrc = 0.
  DELETE TABLE gt_snapshot WITH TABLE KEY snapkey = i_snapkey.
  ls_snapshot-snapkey = ls_snapshot-snapkey - 1.
  CHECK ls_snapshot-snapkey > 0.
  INSERT ls_snapshot INTO TABLE gt_snapshot.

ENDMETHOD.


METHOD dbe4owner_mark_for_deletion.

  DATA l_snapkey            TYPE ish_snapkey.

* No processing if self is destroyed.
  _check_destroyed( ).

* Process only on changes.
  CHECK g_marked_for_deletion = abap_false.

* Callback.
  gr_owner->cb_mark_for_deletion( ir_dbentry = me ).

* Snapshot if needed.
  IF gr_saved_data IS NOT BOUND.
    l_snapkey = gr_owner->get_active_snapkey( ).
    IF l_snapkey IS NOT INITIAL AND
       has_snapshot( l_snapkey ) = abap_false.
      _snapshot( i_snapkey = l_snapkey ).
    ENDIF.
  ENDIF.

* Mark self for deletion.
  g_marked_for_deletion = abap_true.

* Export.
  INSERT co_fieldname_g_marked_for_del INTO TABLE rt_changed_field.

* Raise event ev_changed.
  _raise_ev_changed( rt_changed_field ).

ENDMETHOD.


METHOD dbe4owner_reload.

  DATA lr_act_data                      TYPE REF TO data.
  DATA lt_changed_field_1               TYPE ish_t_fieldname.
  DATA lt_changed_field_2               TYPE ish_t_fieldname.

  FIELD-SYMBOLS <ls_act_data>           TYPE data.

* No processing on destroyed object.
  _check_destroyed( ).

* Callback.
  gr_owner->cb_reload( ir_dbentry = me ).

* No processing if save is in process.
  _check_save_not_in_process( ).

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* Get actual data.
  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_act_data>.

* Check is_data.
  IF cl_abap_typedescr=>describe_by_data( p_data = <ls_act_data> ) <>
        cl_abap_typedescr=>describe_by_data( p_data = is_data ).
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'DBE4OWNER_RELOAD'
        i_mv3        = 'CL_ISH_DBENTRY' ).
  ENDIF.

* Reset g_marked_for_deletion.
  IF g_marked_for_deletion = abap_true.
    g_marked_for_deletion = abap_false.
    INSERT co_fieldname_g_marked_for_del INTO TABLE lt_changed_field_1.
  ENDIF.

* Reset g_touched.
  IF g_touched = abap_true.
    g_touched = abap_false.
    INSERT co_fieldname_g_touched INTO TABLE lt_changed_field_1.
  ENDIF.

* Change actual data.
  lt_changed_field_2 = _change_act_data(
      is_data            = is_data
      i_check            = abap_false
      i_raise_ev_changed = abap_false ).

* Clear orig data.
  CLEAR gr_orig_data.

* Build rt_changed_field.
  rt_changed_field = lt_changed_field_1.
  APPEND LINES OF lt_changed_field_2 TO rt_changed_field.

* Raise event ev_changed.
  _raise_ev_changed( rt_changed_field ).

ENDMETHOD.


METHOD dbe4owner_reset.

  DATA lt_changed_field_1                 TYPE ish_t_fieldname.
  DATA lt_changed_field_2                 TYPE ish_t_fieldname.

  FIELD-SYMBOLS <ls_orig_data>            TYPE data.

* No processing on destroyed object.
  _check_destroyed( ).

* Callback.
  gr_owner->cb_reset( ir_dbentry = me ).

* No processing if save is in process.
  _check_save_not_in_process( ).

* No processing on new object.
  CHECK is_new( ) = abap_false.

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* Reset g_marked_for_deletion.
  IF g_marked_for_deletion = abap_true.
    g_marked_for_deletion = abap_false.
    INSERT co_fieldname_g_marked_for_del INTO TABLE lt_changed_field_1.
  ENDIF.

* Reset g_touched.
  IF g_touched = abap_true.
    g_touched = abap_false.
    INSERT co_fieldname_g_touched INTO TABLE lt_changed_field_1.
  ENDIF.

* Change actual data.
* Clear orig data.
  IF gr_orig_data IS BOUND.
    ASSIGN gr_orig_data->* TO <ls_orig_data>.
    lt_changed_field_2 = _change_act_data(
        is_data            = <ls_orig_data>
        i_check            = abap_false
        i_raise_ev_changed = abap_true ).
    CLEAR gr_orig_data.
  ENDIF.

* Build rt_changed_field.
  rt_changed_field = lt_changed_field_1.
  APPEND LINES OF lt_changed_field_2 TO rt_changed_field.

* Raise event ev_changed.
  _raise_ev_changed( rt_changed_field ).

ENDMETHOD.


METHOD dbe4owner_save.

  DATA lr_act_data                  TYPE REF TO data.
  DATA lr_data2save                 TYPE REF TO data.
  DATA l_kz                         TYPE cdchngind.
  DATA lr_messages                  TYPE REF TO cl_ishmed_errorhandling.

  FIELD-SYMBOLS <ls_act_data>       TYPE data.
  FIELD-SYMBOLS <ls_data2save>      TYPE data.
  FIELD-SYMBOLS <ls_orig_data>      TYPE data.

* No processing on destroyed object.
  _check_destroyed( ).

* Callback.
  gr_owner->cb_save( ir_dbentry = me ).

* No processing if self is deleted.
  CHECK is_deleted( ) = abap_false.

* No processing if self is new and marked for deletion.
  IF is_new( ) = abap_true AND is_marked_for_deletion( ) = abap_true.
    RETURN.
  ENDIF.

* Save only once.
  CHECK gr_saved_data IS NOT BOUND.

* Create data to save.
  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_act_data>.
  CREATE DATA lr_data2save LIKE <ls_act_data>.
  ASSIGN lr_data2save->* TO <ls_data2save>.
  <ls_data2save> = <ls_act_data>.
  CALL METHOD _fill_data2save
    EXPORTING
      i_user       = i_user
      i_date       = i_date
      i_time       = i_time
      i_tcode      = i_tcode
      i_timestamp  = i_timestamp
    CHANGING
      cs_data2save = <ls_data2save>.

* Determine the kz.
  IF is_new( ) = abap_true.
    l_kz = co_cdchngind_insert.
  ELSEIF is_marked_for_deletion( ) = abap_true.
    l_kz = co_cdchngind_delete.
  ELSE.
    l_kz = co_cdchngind_update.
  ENDIF.

* Internal processing.
  IF l_kz = co_cdchngind_update AND
     gr_orig_data IS BOUND.
    ASSIGN gr_orig_data->* TO <ls_orig_data>.
    _save(
        is_data2save = <ls_data2save>
        i_kz         = l_kz
        is_orig_data = <ls_orig_data>
        i_user       = i_user
        i_date       = i_date
        i_time       = i_time
        i_tcode      = i_tcode
        i_timestamp  = i_timestamp ).
  ELSE.
    _save(
        is_data2save = <ls_data2save>
        i_kz         = l_kz
        i_user       = i_user
        i_date       = i_date
        i_time       = i_time
        i_tcode      = i_tcode
        i_timestamp  = i_timestamp ).
  ENDIF.

* Remember saved data.
  gr_saved_data = lr_data2save.

* Self was saved.
  r_saved = abap_true.

ENDMETHOD.


METHOD dbe4owner_snapshot.

* No processing on destroyed object.
  _check_destroyed( ).

* Callback.
  gr_owner->cb_snapshot(
      ir_dbentry  = me
      i_snapkey   = i_snapkey ).

* No processing if save is in process.
  _check_save_not_in_process( ).

* Process.
  _snapshot( i_snapkey = i_snapkey ).

ENDMETHOD.


METHOD dbe4owner_touch.

  DATA l_snapkey            TYPE ish_snapkey.

* No processing on destroyed object.
  _check_destroyed( ).

* Process only on changes.
  CHECK g_touched = abap_false.

* Callback.
  gr_owner->cb_touch( ir_dbentry = me ).

* No processing if save is in process.
  _check_save_not_in_process( ).

* Snapshot if needed.
  IF gr_saved_data IS NOT BOUND.
    l_snapkey = gr_owner->get_active_snapkey( ).
    IF l_snapkey IS NOT INITIAL AND
       has_snapshot( l_snapkey ) = abap_false.
      _snapshot( i_snapkey = l_snapkey ).
    ENDIF.
  ENDIF.

* Touch self.
  g_touched = abap_true.

* Export.
  INSERT co_fieldname_g_touched INTO TABLE rt_changed_field.

* Raise event ev_changed.
  _raise_ev_changed( rt_changed_field ).

ENDMETHOD.


METHOD dbe4owner_undo.

  DATA l_snapshot_found                 TYPE abap_bool.

  FIELD-SYMBOLS <ls_snapshot>           LIKE LINE OF gt_snapshot.
  FIELD-SYMBOLS <ls_data>               TYPE data.

* No processing on destroyed object.
  _check_destroyed( ).

* Callback.
  gr_owner->cb_undo(
      ir_dbentry  = me
      i_snapkey   = i_snapkey ).

* No processing if save is in process.
  _check_save_not_in_process( ).

* Get the snapshot.
  LOOP AT gt_snapshot ASSIGNING <ls_snapshot>.
    IF <ls_snapshot>-snapkey >= i_snapkey.
      l_snapshot_found = abap_true.
      EXIT.
    ENDIF.
  ENDLOOP.
  CHECK l_snapshot_found = abap_true.

* Undo.
  IF <ls_snapshot>-r_act_data IS BOUND.
    ASSIGN <ls_snapshot>-r_act_data->* TO <ls_data>.
    rt_changed_field = _change_act_data(
        is_data            = <ls_data>
        i_check            = abap_false
        i_raise_ev_changed = abap_false ).
  ENDIF.
  gr_orig_data = <ls_snapshot>-r_orig_data.
  IF g_marked_for_deletion <> <ls_snapshot>-marked_for_deletion.
    g_marked_for_deletion = <ls_snapshot>-marked_for_deletion.
    INSERT co_fieldname_g_marked_for_del INTO TABLE rt_changed_field.
  ENDIF.
  IF g_touched <> <ls_snapshot>-touched.
    g_touched = <ls_snapshot>-touched.
    INSERT co_fieldname_g_touched INTO TABLE rt_changed_field.
  ENDIF.

* Delete the snapshot and all following ones.
  LOOP AT gt_snapshot ASSIGNING <ls_snapshot>.
    CHECK <ls_snapshot>-snapkey >= i_snapkey.
    DELETE TABLE gt_snapshot WITH TABLE KEY snapkey = <ls_snapshot>-snapkey.
  ENDLOOP.

* Raise event ev_changed.
  _raise_ev_changed( rt_changed_field ).

ENDMETHOD.


METHOD dbe4owner_untouch.

* No processing on destroyed object.
  _check_destroyed( ).

* Process only on changes.
  CHECK g_touched = abap_true.

* Callback.
  gr_owner->cb_untouch( ir_dbentry = me ).

* No processing if save is in process.
  _check_save_not_in_process( ).

* Untouch self.
  g_touched = abap_false.

* Export.
  INSERT co_fieldname_g_touched INTO TABLE rt_changed_field.

* Raise event ev_changed.
  _raise_ev_changed( rt_changed_field ).

ENDMETHOD.


METHOD get_dfies_by_fieldname.

  DATA lr_structdescr           TYPE REF TO cl_abap_structdescr.
  DATA lr_datadescr             TYPE REF TO cl_abap_datadescr.
  DATA lr_elemdescr             TYPE REF TO cl_abap_elemdescr.

  CHECK i_fieldname IS NOT INITIAL.

  lr_structdescr = get_structdescr( ).
  CHECK lr_structdescr IS BOUND.

  CALL METHOD lr_structdescr->get_component_type
    EXPORTING
      p_name      = i_fieldname
    RECEIVING
      p_descr_ref = lr_datadescr
    EXCEPTIONS
      OTHERS      = 1.
  CHECK sy-subrc = 0.

  TRY.
      lr_elemdescr ?= lr_datadescr.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  CALL METHOD lr_elemdescr->get_ddic_field
    EXPORTING
      p_langu    = i_spras
    RECEIVING
      p_flddescr = rs_dfies
    EXCEPTIONS
      OTHERS     = 1.

ENDMETHOD.


METHOD get_orig_data.

  DATA lr_structdescr                     TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname                        TYPE ish_fieldname.

  FIELD-SYMBOLS <ls_orig_data>            TYPE data.
  FIELD-SYMBOLS <ls_component>            TYPE abap_compdescr.
  FIELD-SYMBOLS <l_source_field>          TYPE ANY.
  FIELD-SYMBOLS <l_target_field>          TYPE ANY.

  _check_destroyed( ).

* On no orig_data we return actual data.
  IF gr_orig_data IS NOT BOUND.
    CALL METHOD get_data
      CHANGING
        cs_data = cs_data.
    RETURN.
  ENDIF.

* cs_data has to be a structure.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( cs_data ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'GET_ORIG_DATA'
          i_mv3        = 'CL_ISH_DBENTRY' ).
  ENDTRY.

* Get orig data.
  ASSIGN gr_orig_data->* TO <ls_orig_data>.

* Take over fields.
  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_orig_data>
      TO <l_source_field>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE cs_data
      TO <l_target_field>.
    CHECK sy-subrc = 0.
    <l_target_field> = <l_source_field>.
  ENDLOOP.

ENDMETHOD.


METHOD get_owner.

  rr_owner = gr_owner.

ENDMETHOD.


METHOD get_structdescr.

  DATA lr_act_data                        TYPE REF TO data.

  FIELD-SYMBOLS <ls_act_data>             TYPE data.

  CHECK is_destroyed( ) = abap_false.

  lr_act_data = _get_r_act_data( ).
  CHECK lr_act_data IS BOUND.

  ASSIGN lr_act_data->* TO <ls_act_data>.

  TRY.
      rr_structdescr ?= cl_abap_typedescr=>describe_by_data( <ls_act_data> ).
    CATCH cx_sy_move_cast_error.
      CLEAR rr_structdescr.
  ENDTRY.

ENDMETHOD.


METHOD get_tabname.

  DATA lr_act_data            TYPE REF TO data.
  DATA lr_typedescr           TYPE REF TO cl_abap_typedescr.

  lr_act_data = _get_r_act_data( ).

  lr_typedescr = cl_abap_typedescr=>describe_by_data_ref( lr_act_data ).

  r_tabname = lr_typedescr->get_relative_name( ).

ENDMETHOD.


METHOD has_snapshot.

  FIELD-SYMBOLS <ls_snapshot>           LIKE LINE OF gt_snapshot.

  LOOP AT gt_snapshot ASSIGNING <ls_snapshot>.
    CHECK <ls_snapshot>-snapkey >= i_snapkey.
    r_has_snapshot = abap_true.
    RETURN.
  ENDLOOP.

ENDMETHOD.


method IF_ISH_DBENTRY_GET~GET_ERDAT.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_erdat
        CHANGING
          c_content   = r_erdat.
    CATCH cx_ish_static_handler.
      CLEAR r_erdat.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ERTIM.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_ertim
        CHANGING
          c_content   = r_ertim.
    CATCH cx_ish_static_handler.
      CLEAR r_ertim.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ERUSR.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_erusr
        CHANGING
          c_content   = r_erusr.
    CATCH cx_ish_static_handler.
      CLEAR r_erusr.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_LODAT.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_lodat
        CHANGING
          c_content   = r_lodat.
    CATCH cx_ish_static_handler.
      CLEAR r_lodat.
  ENDTRY.

endmethod.


METHOD if_ish_dbentry_get~get_loekz.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_loekz
        CHANGING
          c_content   = r_loekz.
    CATCH cx_ish_static_handler.
      CLEAR r_loekz.
  ENDTRY.

ENDMETHOD.


method IF_ISH_DBENTRY_GET~GET_LOTIM.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_lotim
        CHANGING
          c_content   = r_lotim.
    CATCH cx_ish_static_handler.
      CLEAR r_lotim.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_LOUSR.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_lousr
        CHANGING
          c_content   = r_lousr.
    CATCH cx_ish_static_handler.
      CLEAR r_lousr.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_MANDT.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_mandt
        CHANGING
          c_content   = r_mandt.
    CATCH cx_ish_static_handler.
      CLEAR r_mandt.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_ERDAT.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_erdat
        CHANGING
          c_content   = r_erdat.
    CATCH cx_ish_static_handler.
      CLEAR r_erdat.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_ERTIM.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_ertim
        CHANGING
          c_content   = r_ertim.
    CATCH cx_ish_static_handler.
      CLEAR r_ertim.
  ENDTRY.


endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_ERUSR.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_erusr
        CHANGING
          c_content   = r_erusr.
    CATCH cx_ish_static_handler.
      CLEAR r_erusr.
  ENDTRY.

endmethod.


METHOD if_ish_dbentry_get~get_orig_field_content.

  FIELD-SYMBOLS <ls_orig_data>            TYPE data.

* No processing on destroyed object.
  _check_destroyed( ).

  IF gr_orig_data IS NOT BOUND.
    CALL METHOD get_field_content
      EXPORTING
        i_fieldname = i_fieldname
      CHANGING
        c_content   = c_content.
  ELSE.
    ASSIGN gr_orig_data->* TO <ls_orig_data>.
    CALL METHOD cl_ish_utl_gui_structure_model=>get_field_content
      EXPORTING
        ir_model    = me
        is_data     = <ls_orig_data>
        i_fieldname = i_fieldname
      CHANGING
        c_content   = c_content.
  ENDIF.

ENDMETHOD.


method IF_ISH_DBENTRY_GET~GET_ORIG_LODAT.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_lodat
        CHANGING
          c_content   = r_lodat.
    CATCH cx_ish_static_handler.
      CLEAR r_lodat.
  ENDTRY.

endmethod.


METHOD if_ish_dbentry_get~get_orig_loekz.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_loekz
        CHANGING
          c_content   = r_loekz.
    CATCH cx_ish_static_handler.
      CLEAR r_loekz.
  ENDTRY.

ENDMETHOD.


method IF_ISH_DBENTRY_GET~GET_ORIG_LOTIM.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_lotim
        CHANGING
          c_content   = r_lotim.
    CATCH cx_ish_static_handler.
      CLEAR r_lotim.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_LOUSR.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_lousr
        CHANGING
          c_content   = r_lousr.
    CATCH cx_ish_static_handler.
      CLEAR r_lousr.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_MANDT.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_mandt
        CHANGING
          c_content   = r_mandt.
    CATCH cx_ish_static_handler.
      CLEAR r_mandt.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_SPRAS.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_spras
        CHANGING
          c_content   = r_spras.
    CATCH cx_ish_static_handler.
      CLEAR r_spras.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_STODAT.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_stodat
        CHANGING
          c_content   = r_stodat.
    CATCH cx_ish_static_handler.
      CLEAR r_stodat.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_STOID.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_stoid
        CHANGING
          c_content   = r_stoid.
    CATCH cx_ish_static_handler.
      CLEAR r_stoid.
  ENDTRY.

endmethod.


METHOD if_ish_dbentry_get~get_orig_stokz.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_stokz
        CHANGING
          c_content   = r_stokz.
    CATCH cx_ish_static_handler.
      CLEAR r_stokz.
  ENDTRY.

ENDMETHOD.


method IF_ISH_DBENTRY_GET~GET_ORIG_STOTIM.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_stotim
        CHANGING
          c_content   = r_stotim.
    CATCH cx_ish_static_handler.
      CLEAR r_stotim.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_STOUSR.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_stousr
        CHANGING
          c_content   = r_stousr.
    CATCH cx_ish_static_handler.
      CLEAR r_stousr.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_TIMESTAMP.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_timestamp
        CHANGING
          c_content   = r_timestamp.
    CATCH cx_ish_static_handler.
      CLEAR r_timestamp.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_UPDAT.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_updat
        CHANGING
          c_content   = r_updat.
    CATCH cx_ish_static_handler.
      CLEAR r_updat.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_UPTIM.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_uptim
        CHANGING
          c_content   = r_uptim.
    CATCH cx_ish_static_handler.
      CLEAR r_uptim.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_ORIG_UPUSR.

  TRY.
      CALL METHOD get_orig_field_content
        EXPORTING
          i_fieldname = co_fieldname_upusr
        CHANGING
          c_content   = r_upusr.
    CATCH cx_ish_static_handler.
      CLEAR r_upusr.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_SPRAS.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_spras
        CHANGING
          c_content   = r_spras.
    CATCH cx_ish_static_handler.
      CLEAR r_spras.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_STODAT.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_stodat
        CHANGING
          c_content   = r_stodat.
    CATCH cx_ish_static_handler.
      CLEAR r_stodat.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_STOID.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_stoid
        CHANGING
          c_content   = r_stoid.
    CATCH cx_ish_static_handler.
      CLEAR r_stoid.
  ENDTRY.

endmethod.


METHOD if_ish_dbentry_get~get_stokz.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_stokz
        CHANGING
          c_content   = r_stokz.
    CATCH cx_ish_static_handler.
      CLEAR r_stokz.
  ENDTRY.

ENDMETHOD.


method IF_ISH_DBENTRY_GET~GET_STOTIM.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_stotim
        CHANGING
          c_content   = r_stotim.
    CATCH cx_ish_static_handler.
      CLEAR r_stotim.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_STOUSR.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_stousr
        CHANGING
          c_content   = r_stousr.
    CATCH cx_ish_static_handler.
      CLEAR r_stousr.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_TIMESTAMP.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_timestamp
        CHANGING
          c_content   = r_timestamp.
    CATCH cx_ish_static_handler.
      CLEAR r_timestamp.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_UPDAT.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_updat
        CHANGING
          c_content   = r_updat.
    CATCH cx_ish_static_handler.
      CLEAR r_updat.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_UPTIM.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_uptim
        CHANGING
          c_content   = r_uptim.
    CATCH cx_ish_static_handler.
      CLEAR r_uptim.
  ENDTRY.

endmethod.


method IF_ISH_DBENTRY_GET~GET_UPUSR.

  TRY.
      CALL METHOD get_field_content
        EXPORTING
          i_fieldname = co_fieldname_upusr
        CHANGING
          c_content   = r_upusr.
    CATCH cx_ish_static_handler.
      CLEAR r_upusr.
  ENDTRY.

endmethod.


METHOD if_ish_destroyable~destroy.

  DATA lr_destroyable_owner             TYPE REF TO if_ish_destroyable.

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

* Internal processing.
  _destroy( ).

* Destroy attributes.
  CLEAR gr_orig_data.
  CLEAR gr_saved_data.
  CLEAR gt_snapshot.
  CLEAR g_deleted.
  CLEAR g_marked_for_deletion.
  CLEAR g_new.
  CLEAR g_touched.

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


METHOD if_ish_gui_structure_model~get_field_content.

  DATA lr_act_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_act_data>           TYPE data.

* No processing on destroyed object.
  CHECK is_destroyed( ) = abap_false.

  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_act_data>.
  CALL METHOD cl_ish_utl_gui_structure_model=>get_field_content
    EXPORTING
      ir_model    = me
      is_data     = <ls_act_data>
      i_fieldname = i_fieldname
    CHANGING
      c_content   = c_content.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  DATA lr_act_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_act_data>           TYPE data.

* No processing on destroyed object.
  CHECK is_destroyed( ) = abap_false.

  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_act_data>.

  rt_supported_fieldname = cl_ish_utl_gui_structure_model=>get_supported_fields( <ls_act_data> ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  DATA lt_supported_fieldname           TYPE ish_t_fieldname.

* No processing on destroyed object.
  CHECK is_destroyed( ) = abap_false.

  lt_supported_fieldname = get_supported_fields( ).
  READ TABLE lt_supported_fieldname FROM i_fieldname TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_supported = abap_true.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  DATA lr_act_data                      TYPE REF TO data.
  DATA l_error                          TYPE abap_bool.

  FIELD-SYMBOLS <ls_act_data>           TYPE data.
  FIELD-SYMBOLS <l_content>             TYPE data.

* No processing on destroyed object.
  _check_destroyed( ).

* Get actual data.
  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_act_data>.

* i_fieldname has to be specified.
  IF i_fieldname IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_DBENTRY' ).
  ENDIF.

* Assign the actual content.
  ASSIGN COMPONENT i_fieldname OF STRUCTURE <ls_act_data> TO <l_content>.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_DBENTRY' ).
  ENDIF.

* Check if assignment is allowed.
  IF cl_ish_utl_gui_structure_model=>is_assignment_allowed(
      i_source  = i_content
      i_target  = <l_content> ) = 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = 'SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_DBENTRY' ).
  ENDIF.

* Process only on changes.
  CHECK i_content <> <l_content>.

* Set field content.
  r_changed = _set_act_field_content(
      i_fieldname        = i_fieldname
      i_content          = i_content
      i_check            = abap_true
      i_raise_ev_changed = abap_true ).

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~get_data.

  DATA lr_structdescr                     TYPE REF TO cl_abap_structdescr.
  DATA lr_act_data                        TYPE REF TO data.
  DATA l_fieldname                        TYPE ish_fieldname.

  FIELD-SYMBOLS <ls_act_data>             TYPE data.
  FIELD-SYMBOLS <ls_component>            TYPE abap_compdescr.
  FIELD-SYMBOLS <l_source_field>          TYPE ANY.
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
          i_mv3        = 'CL_ISH_DBENTRY' ).
  ENDTRY.

* Get actual data.
  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_act_data>.

* Take over fields.
  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_act_data>
      TO <l_source_field>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE cs_data
      TO <l_target_field>.
    CHECK sy-subrc = 0.
    <l_target_field> = <l_source_field>.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~is_field_changeable.

* No processing on destroyed object.
  CHECK is_destroyed( ) = abap_false.

* Check readonly.
  CHECK is_readonly( ) = abap_false.

* The field is only changeable if it is supported.
  CHECK is_field_supported( i_fieldname ) = abap_true.

* mandt is not changeable.
  CHECK i_fieldname <> co_fieldname_mandt.

* spras is not changeable.
  CHECK i_fieldname <> co_fieldname_spras.

* Handle erinfo.
  IF _get_autogen_erinfo( ) = abap_true.
    CHECK i_fieldname <> co_fieldname_erdat.
    CHECK i_fieldname <> co_fieldname_ertim.
    CHECK i_fieldname <> co_fieldname_erusr.
  ENDIF.

* Handle upinfo.
  IF _get_autogen_upinfo( ) = abap_true.
    CHECK i_fieldname <> co_fieldname_updat.
    CHECK i_fieldname <> co_fieldname_uptim.
    CHECK i_fieldname <> co_fieldname_upusr.
  ENDIF.

* Handle loinfo.
  IF _get_autogen_loinfo( ) = abap_true.
    CHECK i_fieldname <> co_fieldname_lodat.
    CHECK i_fieldname <> co_fieldname_lotim.
    CHECK i_fieldname <> co_fieldname_lousr.
  ENDIF.

* Handle stinfo.
  IF _get_autogen_stinfo( ) = abap_true.
    CHECK i_fieldname <> co_fieldname_stodat.
    CHECK i_fieldname <> co_fieldname_stotim.
    CHECK i_fieldname <> co_fieldname_stousr.
  ENDIF.

* Handle the timestamp.
  IF _get_autogen_timestamp( ) = abap_true.
    CHECK i_fieldname <> co_fieldname_timestamp.
  ENDIF.

* Internal processing.
  r_changeable = _is_field_changeable( i_fieldname ).

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~is_readonly.

  DATA lr_xstructmdl_owner            TYPE REF TO if_ish_gui_xstructure_model.

  r_readonly = abap_true.

* If self is destroyed self is readonly.
  CHECK is_destroyed( ) = abap_false.

* Check the owner.
  TRY.
      lr_xstructmdl_owner ?= gr_owner.
      CHECK lr_xstructmdl_owner->is_readonly( ) = abap_false.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

* Self is not readonly.
  r_readonly = abap_false.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~set_data.

  DATA lr_act_data                        TYPE REF TO data.
  DATA lr_structdescr                     TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname                        TYPE ish_fieldname.
  DATA l_fieldname_x                      TYPE ish_fieldname.
  DATA l_rc                               TYPE ish_method_rc.
  DATA lr_messages                        TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_static                          TYPE REF TO cx_ish_static_handler.

  FIELD-SYMBOLS <ls_act_data>             TYPE data.
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
          i_mv3        = 'CL_ISH_DBENTRY' ).
  ENDTRY.

* Get actual data.
  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_act_data>.

  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.

    l_fieldname = <ls_component>-name.

    IF it_field2change IS NOT INITIAL.
      READ TABLE it_field2change FROM l_fieldname TRANSPORTING NO FIELDS.
      CHECK sy-subrc = 0.
    ENDIF.

    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE is_data
      TO <l_source_field>.
    CHECK sy-subrc = 0.

    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_act_data>
      TO <l_target_field>.
    CHECK sy-subrc = 0.

    IF i_handle_xfields = abap_true.
      CONCATENATE l_fieldname 'X' INTO l_fieldname_x SEPARATED BY '_'.
      ASSIGN COMPONENT l_fieldname
        OF STRUCTURE is_data
        TO <l_source_field_x>.
      CHECK sy-subrc = 0.
      CHECK <l_source_field_x> = abap_true.
    ENDIF.

    CHECK <l_source_field> <> <l_target_field>.

    IF i_soft = abap_true.
      CHECK is_field_changeable( l_fieldname ) = abap_true.
    ENDIF.

    TRY.
        CHECK _set_act_field_content(
            i_fieldname        = l_fieldname
            i_content          = <l_source_field>
            i_check            = abap_true
            i_raise_ev_changed = abap_false ) = abap_true.
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

  _raise_ev_changed( rt_changed_field ).

  IF l_rc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_messages.
  ENDIF.

ENDMETHOD.


METHOD is_changed.

  DATA lr_act_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_act_data>           TYPE data.
  FIELD-SYMBOLS <ls_orig_data>          TYPE data.

* No processing on destroyed object.
  CHECK is_destroyed( ) = abap_false.

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

* No orig data -> self is not changed.
  CHECK gr_orig_data IS BOUND.

* Compare actual and original data.
  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_act_data>.
  ASSIGN gr_orig_data->* TO <ls_orig_data>.
  CHECK <ls_act_data> <> <ls_orig_data>.

* Self is changed.
  r_changed = abap_true.

ENDMETHOD.


METHOD is_deleted.

  r_deleted = g_deleted.

ENDMETHOD.


METHOD is_field_changed.

  DATA lr_act_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_act_data>           TYPE data.
  FIELD-SYMBOLS <l_act_data>            TYPE data.
  FIELD-SYMBOLS <ls_orig_data>          TYPE data.
  FIELD-SYMBOLS <l_orig_data>           TYPE data.

* No processing on destroyed object.
  CHECK is_destroyed( ) = abap_false.

* The field has to be supported.
  CHECK is_field_supported( i_fieldname ) = abap_true.

* No orig data -> not changed.
  CHECK gr_orig_data IS BOUND.

* Get actual field content.
  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_act_data>.
  ASSIGN COMPONENT i_fieldname
    OF STRUCTURE <ls_act_data>
    TO <l_act_data>.

* Get orig field content.
  ASSIGN gr_orig_data->* TO <ls_orig_data>.
  ASSIGN COMPONENT i_fieldname
    OF STRUCTURE <ls_orig_data>
    TO <l_orig_data>.

* Compare field content.
  CHECK <l_act_data> <> <l_orig_data>.

* The field is changed.
  r_changed = abap_true.

ENDMETHOD.


METHOD is_marked_for_deletion.

  r_marked_for_deletion = g_marked_for_deletion.

ENDMETHOD.


METHOD is_new.

  r_new = g_new.

ENDMETHOD.


METHOD is_touched.

  r_touched = g_touched.

ENDMETHOD.


METHOD on_owner_destroyed.

* Check the sender (has to be our owner).
  CHECK sender IS BOUND.
  CHECK sender = gr_owner.

* Or owner was destroyed.
* So we have to destroy ourself.
  destroy( ).

ENDMETHOD.


METHOD _autogen_erinfo.

  FIELD-SYMBOLS <l_date>              TYPE ri_erdat.
  FIELD-SYMBOLS <l_time>              TYPE ri_ertim.
  FIELD-SYMBOLS <l_user>              TYPE ri_ernam.

  ASSIGN COMPONENT co_fieldname_erdat
    OF STRUCTURE cs_data
    TO <l_date> CASTING.
  IF sy-subrc = 0.
    <l_date> = i_date.
  ENDIF.
  ASSIGN COMPONENT co_fieldname_ertim
    OF STRUCTURE cs_data
    TO <l_time> CASTING.
  IF sy-subrc = 0.
    <l_time> = i_time.
  ENDIF.
  ASSIGN COMPONENT co_fieldname_erusr
    OF STRUCTURE cs_data
    TO <l_user> CASTING.
  IF sy-subrc = 0.
    <l_user> = i_user.
  ENDIF.

ENDMETHOD.


METHOD _autogen_loinfo.

  FIELD-SYMBOLS <l_date>              TYPE ri_lodat.
  FIELD-SYMBOLS <l_time>              TYPE ri_lotim.
  FIELD-SYMBOLS <l_user>              TYPE ri_lousr.

  ASSIGN COMPONENT co_fieldname_lodat
    OF STRUCTURE cs_data
    TO <l_date> CASTING.
  IF sy-subrc = 0.
    <l_date> = i_date.
  ENDIF.
  ASSIGN COMPONENT co_fieldname_lotim
    OF STRUCTURE cs_data
    TO <l_time> CASTING.
  IF sy-subrc = 0.
    <l_time> = i_time.
  ENDIF.
  ASSIGN COMPONENT co_fieldname_lousr
    OF STRUCTURE cs_data
    TO <l_user> CASTING.
  IF sy-subrc = 0.
    <l_user> = i_user.
  ENDIF.

ENDMETHOD.


METHOD _autogen_stinfo.

  FIELD-SYMBOLS <l_date>              TYPE storn_dat.
  FIELD-SYMBOLS <l_time>              TYPE ish_storn_tim.
  FIELD-SYMBOLS <l_user>              TYPE storn_user.

  ASSIGN COMPONENT co_fieldname_stodat
    OF STRUCTURE cs_data
    TO <l_date> CASTING.
  IF sy-subrc = 0.
    <l_date> = i_date.
  ENDIF.
  ASSIGN COMPONENT co_fieldname_stotim
    OF STRUCTURE cs_data
    TO <l_time> CASTING.
  IF sy-subrc = 0.
    <l_time> = i_time.
  ENDIF.
  ASSIGN COMPONENT co_fieldname_stousr
    OF STRUCTURE cs_data
    TO <l_user> CASTING.
  IF sy-subrc = 0.
    <l_user> = i_user.
  ENDIF.

ENDMETHOD.


METHOD _autogen_timestamp.

  FIELD-SYMBOLS <l_timestamp>         TYPE timestampl.

  ASSIGN COMPONENT co_fieldname_timestamp
    OF STRUCTURE cs_data
    TO <l_timestamp> CASTING.
  IF sy-subrc = 0.
    <l_timestamp> = i_timestamp.
  ENDIF.

ENDMETHOD.


METHOD _autogen_upinfo.

  FIELD-SYMBOLS <l_date>              TYPE ri_updat.
  FIELD-SYMBOLS <l_time>              TYPE ri_uptim.
  FIELD-SYMBOLS <l_user>              TYPE ri_upnam.

  ASSIGN COMPONENT co_fieldname_updat
    OF STRUCTURE cs_data
    TO <l_date> CASTING.
  IF sy-subrc = 0.
    <l_date> = i_date.
  ENDIF.
  ASSIGN COMPONENT co_fieldname_uptim
    OF STRUCTURE cs_data
    TO <l_time> CASTING.
  IF sy-subrc = 0.
    <l_time> = i_time.
  ENDIF.
  ASSIGN COMPONENT co_fieldname_upusr
    OF STRUCTURE cs_data
    TO <l_user> CASTING.
  IF sy-subrc = 0.
    <l_user> = i_user.
  ENDIF.

ENDMETHOD.


METHOD _change_act_data.

  DATA lr_act_data                        TYPE REF TO data.
  DATA lr_structdescr                     TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname                        TYPE ish_fieldname.

  FIELD-SYMBOLS <ls_act_data>             TYPE data.
  FIELD-SYMBOLS <ls_component>            TYPE abap_compdescr.
  FIELD-SYMBOLS <l_source_field>          TYPE any.
  FIELD-SYMBOLS <l_target_field>          TYPE any.

  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_act_data>.

  lr_structdescr ?= cl_abap_typedescr=>describe_by_data( <ls_act_data> ).

  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.

    l_fieldname = <ls_component>-name.

    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE is_data
      TO <l_source_field>.
    CHECK sy-subrc = 0.

    CHECK _set_act_field_content(
        i_fieldname        = l_fieldname
        i_content          = <l_source_field>
        i_check            = i_check
        i_raise_ev_changed = abap_false ) = abap_true.

    INSERT l_fieldname INTO TABLE rt_changed_field.

  ENDLOOP.

  IF i_raise_ev_changed = abap_true.
    _raise_ev_changed( rt_changed_field ).
  ENDIF.

ENDMETHOD.


METHOD _check_destroyed.

  IF is_destroyed( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_DESTROYED'
        i_mv3        = 'CL_ISH_DBENTRY' ).
  ENDIF.

ENDMETHOD.


METHOD _check_field_changeable.

  DATA l_tabname            TYPE tabname.
  DATA l_par                TYPE bapiret2-parameter.
  DATA l_field              TYPE bapiret2-field.

  IF is_field_changeable( i_fieldname ) = abap_false.
    l_par = get_tabname( ).
    l_field = i_fieldname.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '150'
        i_mv1        = i_fieldname
        i_par        = l_par
        i_field      = l_field
        ir_object    = gr_owner ).
  ENDIF.

ENDMETHOD.


METHOD _check_save_not_in_process.

  IF gr_saved_data IS BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_SAVE_NOT_IN_PROCESS'
        i_mv3        = 'CL_ISH_DBENTRY' ).
  ENDIF.

ENDMETHOD.


METHOD _check_set_field_content.

* Is field changeable?
  _check_field_changeable( i_fieldname = i_fieldname ).

* Allowed.
  r_allowed = abap_true.

ENDMETHOD.


METHOD _fill_data2save.

* Autogen erinfo.
  DO 1 TIMES.
    CHECK g_new = abap_true.
    CHECK _get_autogen_erinfo( ) = abap_true.
    CALL METHOD _autogen_erinfo
      EXPORTING
        i_user  = i_user
        i_date  = i_date
        i_time  = i_time
      CHANGING
        cs_data = cs_data2save.
  ENDDO.

* Autogen upinfo.
  DO 1 TIMES.
    CHECK g_new = abap_false.
    CHECK _get_autogen_upinfo( ) = abap_true.
    CHECK is_changed( ) = abap_true OR is_touched( ) = abap_true.
    CALL METHOD _autogen_upinfo
      EXPORTING
        i_user  = i_user
        i_date  = i_date
        i_time  = i_time
      CHANGING
        cs_data = cs_data2save.
  ENDDO.

* Autogen loinfo.
  DO 1 TIMES.
    CHECK _get_autogen_loinfo( ) = abap_true.
    CHECK get_loekz( ) = abap_true.
    CHECK get_orig_loekz( ) = abap_false.
    CALL METHOD _autogen_loinfo
      EXPORTING
        i_user  = i_user
        i_date  = i_date
        i_time  = i_time
      CHANGING
        cs_data = cs_data2save.
  ENDDO.

* Autogen stinfo.
  DO 1 TIMES.
    CHECK _get_autogen_stinfo( ) = abap_true.
    CHECK get_stokz( ) = abap_true.
    CHECK get_orig_stokz( ) = abap_false.
    CALL METHOD _autogen_stinfo
      EXPORTING
        i_user  = i_user
        i_date  = i_date
        i_time  = i_time
      CHANGING
        cs_data = cs_data2save.
  ENDDO.

* Autogen timestamp.
  DO 1 TIMES.
    CHECK _get_autogen_timestamp( ) = abap_true.
    CALL METHOD _autogen_timestamp
      EXPORTING
        i_timestamp = i_timestamp
      CHANGING
        cs_data     = cs_data2save.
  ENDDO.

ENDMETHOD.


METHOD _get_autogen_erinfo.

  IF is_field_supported( co_fieldname_erdat ) = abap_true.
    r_autogen = abap_true.
  ENDIF.

ENDMETHOD.


METHOD _get_autogen_loinfo.

  IF is_field_supported( co_fieldname_lodat ) = abap_true.
    r_autogen = abap_true.
  ENDIF.

ENDMETHOD.


METHOD _get_autogen_stinfo.

  IF is_field_supported( co_fieldname_stodat ) = abap_true.
    r_autogen = abap_true.
  ENDIF.

ENDMETHOD.


METHOD _get_autogen_timestamp.

  IF is_field_supported( co_fieldname_timestamp ) = abap_true.
    r_autogen = abap_true.
  ENDIF.

ENDMETHOD.


METHOD _get_autogen_upinfo.

  IF is_field_supported( co_fieldname_updat ) = abap_true.
    r_autogen = abap_true.
  ENDIF.

ENDMETHOD.


METHOD _get_r_orig_data.

  rr_orig_data = gr_orig_data.

ENDMETHOD.


METHOD _get_r_saved_data.

  rr_saved_data = gr_saved_data.

ENDMETHOD.


METHOD _raise_ev_changed.

  READ TABLE it_changed_field FROM co_fieldname_g_marked_for_del TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    RAISE EVENT ev_g_marked_for_del_changed.
  ENDIF.

  READ TABLE it_changed_field FROM co_fieldname_stokz TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    RAISE EVENT ev_stokz_changed.
  ENDIF.

  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = it_changed_field.

ENDMETHOD.


METHOD _set_act_field_content.

  DATA lr_act_data                      TYPE REF TO data.
  DATA lt_changed_field                 TYPE ish_t_fieldname.
  DATA l_snapkey                        TYPE ish_snapkey.

  FIELD-SYMBOLS <ls_act_data>           TYPE data.
  FIELD-SYMBOLS <ls_orig_data>          TYPE data.
  FIELD-SYMBOLS <l_content>             TYPE data.

* Assign actual data.
  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_act_data>.

* Assign the actual content.
  ASSIGN COMPONENT i_fieldname OF STRUCTURE <ls_act_data> TO <l_content>.

* Process only on changes.
  CHECK <l_content> <> i_content.

* Check
  IF i_check = abap_true.
*   Internal checks.
    IF i_check = abap_true.
      _check_set_field_content(
          i_fieldname = i_fieldname
          i_content   = i_content ).
    ENDIF.
*   Callback.
    IF i_check = abap_true.
      CHECK gr_owner->cb_set_field_content(
          ir_model    = me
          i_fieldname = i_fieldname
          i_content   = i_content ) = abap_true.
    ENDIF.
*   No processing if save is in process.
    _check_save_not_in_process( ).
  ENDIF.

* Handle orig data.
  IF gr_saved_data IS NOT BOUND AND
     g_new = abap_false AND
     gr_orig_data IS NOT BOUND.
    CREATE DATA gr_orig_data LIKE <ls_act_data>.
    ASSIGN gr_orig_data->* TO <ls_orig_data>.
    <ls_orig_data> = <ls_act_data>.
  ENDIF.

* Snapshot if needed.
  IF gr_saved_data IS NOT BOUND.
    l_snapkey = gr_owner->get_active_snapkey( ).
    IF l_snapkey IS NOT INITIAL AND
       has_snapshot( l_snapkey ) = abap_false.
      _snapshot( i_snapkey = l_snapkey ).
    ENDIF.
  ENDIF.

* Set field content.
  <l_content> = i_content.

* Raise event ev_changed.
  IF i_raise_ev_changed = abap_true.
    INSERT i_fieldname INTO TABLE lt_changed_field.
    _raise_ev_changed( lt_changed_field ).
  ENDIF.

* Export.
  r_changed = abap_true.

ENDMETHOD.


METHOD _snapshot.

  DATA ls_snapshot            LIKE LINE OF gt_snapshot.
  DATA lr_act_data            TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>     TYPE data.
  FIELD-SYMBOLS <ls_data2>    TYPE data.

* No processing if save is in process.
  _check_save_not_in_process( ).

* Build the snapshot.

  ls_snapshot-snapkey = i_snapkey.

  lr_act_data = _get_r_act_data( ).
  ASSIGN lr_act_data->* TO <ls_data>.
  CREATE DATA ls_snapshot-r_act_data LIKE <ls_data>.
  ASSIGN ls_snapshot-r_act_data->* TO <ls_data2>.
  <ls_data2> = <ls_data>.

  IF gr_orig_data IS BOUND.
    ASSIGN gr_orig_data->* TO <ls_data>.
    CREATE DATA ls_snapshot-r_orig_data LIKE <ls_data>.
    ASSIGN ls_snapshot-r_orig_data->* TO <ls_data2>.
    <ls_data2> = <ls_data>.
  ENDIF.

  ls_snapshot-marked_for_deletion = g_marked_for_deletion.

  ls_snapshot-touched = g_touched.

  INSERT ls_snapshot INTO TABLE gt_snapshot.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_SNAPSHOT'
        i_mv3        = 'CL_ISH_DBENTRY' ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
