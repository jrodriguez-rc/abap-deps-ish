class CL_ISH_COMPLDEGREE definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_COMPLDEGREE
*"* do not include other source files here!!!

  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_SNAPSHOT_OBJECT .
  interfaces IF_ISH_SNAPSHOT_CALLBACK .
  interfaces IF_ISH_CONSTANT_DEFINITION .

  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_COMPLDEGREE type ISH_OBJECT_TYPE value 12188. "#EC NOTEXT

  methods CHECK
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods CHECK_LOCK
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      value(IS_N1COMPLDEGREE) type N1COMPLDEGREE
      value(I_NAME) type N1COMPLDEGREE_NAME optional
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE
    importing
      value(I_MONCON_ID) type N1MONCON_ID
      value(I_COUNT_TOTAL) type N1COMPLDEGREE_TOTAL default 0
      value(I_COUNT_COMPLETED) type N1COMPLDEGREE_COMPLETED default 0
      value(I_NAME) type N1COMPLDEGREE_NAME optional
    returning
      value(RR_COMPLDEGREE) type ref to CL_ISH_COMPLDEGREE
    raising
      CX_ISH_STATIC_HANDLER .
  methods DESTROY .
  methods GET_COUNT_COMPLETED
  final
    returning
      value(R_COUNT_COMPLETED) type N1COMPLDEGREE_COMPLETED .
  methods GET_COUNT_TOTAL
  final
    returning
      value(R_COUNT_TOTAL) type N1COMPLDEGREE_TOTAL .
  methods GET_ICON
    returning
      value(R_ICON) type N1COMPLDEGREE_ICON .
  methods GET_ID
    returning
      value(R_COMPLDEGREE_ID) type N1COMPLDEGREE_ID .
  methods GET_N1COMPLDEGREE
    returning
      value(RS_N1COMPLDEGREE) type N1COMPLDEGREE .
  methods GET_NAME
    returning
      value(R_NAME) type N1COMPLDEGREE_NAME .
  methods GET_PERCENTAGE
    returning
      value(R_PERCENTAGE) type N1COMPLDEGREE_PERCENTAGE .
  type-pools ABAP .
  methods GET_TEXT
    importing
      value(I_ATTRIBUTE_SINGULAR) type STRING default SPACE
      value(I_ATTRIBUTE_PLURAL) type STRING default SPACE
      value(I_INCL_PROCENTAGE) type ABAP_BOOL default ABAP_OFF
    returning
      value(R_TEXT) type N1COMPLDEGREE_TEXT .
  methods IS_CHANGED
    returning
      value(R_CHANGED) type ABAP_BOOL .
  methods IS_LOCKED
    returning
      value(R_LOCKED) type ABAP_BOOL .
  methods IS_MARKED_FOR_DELETION
    returning
      value(R_DELETIONMARK) type ABAP_BOOL .
  methods IS_NEW
    returning
      value(R_NEW) type ABAP_BOOL .
  class-methods LOAD
    importing
      value(I_ID) type N1COMPLDEGREE_ID
      value(IS_N1COMPLDEGREE) type N1COMPLDEGREE optional
      value(I_NAME) type N1COMPLDEGREE_NAME optional
    returning
      value(RR_COMPLDEGREE) type ref to CL_ISH_COMPLDEGREE
    raising
      CX_ISH_STATIC_HANDLER .
  methods LOCK
    raising
      CX_ISH_STATIC_HANDLER .
  methods MARK_FOR_DELETION .
  methods RECALCULATE .
  methods REFRESH .
  methods SAVE
    importing
      value(I_UPDATE_TASK) type ABAP_BOOL default ABAP_ON
      value(I_COMMIT) type ABAP_BOOL default ABAP_ON
    preferred parameter I_UPDATE_TASK
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_COUNT_COMPLETED
    importing
      value(I_COUNT_COMPLETED) type N1COMPLDEGREE_COMPLETED .
  methods SET_COUNT_TOTAL
    importing
      value(I_COUNT_TOTAL) type N1COMPLDEGREE_TOTAL .
  methods UNLOCK .
protected section.
*"* protected components of class CL_ISH_COMPLDEGREE
*"* do not include other source files here!!!

  data GR_SNAPSHOTHANDLER type ref to CL_ISH_SNAPSHOTHANDLER .
  data GS_N1COMPLDEGREE type N1COMPLDEGREE .
  data GS_N1COMPLDEGREE_ORIG type N1COMPLDEGREE .
  data G_DELETIONMARK type ABAP_BOOL .
  data G_LOCKED type ABAP_BOOL .
  data G_NAME type N1COMPLDEGREE_NAME .
  data G_NAME_ORIG type N1COMPLDEGREE_NAME .
  data G_NEW type ABAP_BOOL .

  methods GET_SNAPSHOTHANDLER
    returning
      value(RR_SNAPSHOTHANDLER) type ref to CL_ISH_SNAPSHOTHANDLER .
  methods _CHECK
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_COMPLDEGREE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMPLDEGREE IMPLEMENTATION.


METHOD check.

  DATA: l_rc  TYPE ish_method_rc.

* Initializations.
  CLEAR: e_rc.

* Check only if self is changed
  CHECK is_changed( ) = abap_on.

* Check now
  CALL METHOD me->_check
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


METHOD check_lock.

  DATA: lr_errorhandler     TYPE REF TO cl_ishmed_errorhandling.

* Check only if self is not new.
  CHECK is_new( ) = abap_off.

  IF is_locked( ) = abap_off.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '119'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD constructor.

  DATA: lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.

  IF is_n1compldegree-moncon_id IS INITIAL.
    CREATE OBJECT lr_errorhandler.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_COMPLDEGREE'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  me->gs_n1compldegree = is_n1compldegree.
  me->g_name           = i_name.

  IF gs_n1compldegree-compldegree_id IS INITIAL.
    CALL METHOD cl_ish_utl_base=>generate_uuid
      RECEIVING
        r_uuid = me->gs_n1compldegree-compldegree_id.
    g_new = abap_on.
  ENDIF.

  IF me->gs_n1compldegree-area_id IS INITIAL.
    SELECT SINGLE area_id FROM n1moncon
           INTO me->gs_n1compldegree-area_id
           WHERE  moncon_id = me->gs_n1compldegree-moncon_id.
    IF sy-subrc <> 0.
      CREATE OBJECT lr_errorhandler.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '007'
          i_mv1           = 'CL_ISH_COMPLDEGREE'
        CHANGING
          cr_errorhandler = lr_errorhandler.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.
    ENDIF.
  ENDIF.

  IF me->gs_n1compldegree-completion_icon IS INITIAL OR
     me->g_name                           IS INITIAL.
    CALL METHOD me->recalculate.
  ENDIF.

ENDMETHOD.


METHOD create.

  DATA: ls_n1compldegree         TYPE n1compldegree.

  CLEAR ls_n1compldegree.
  ls_n1compldegree-mandt           = sy-mandt.
  ls_n1compldegree-moncon_id       = i_moncon_id.
  ls_n1compldegree-count_total     = i_count_total.
  ls_n1compldegree-count_completed = i_count_completed.

*  TRY.
  CREATE OBJECT rr_compldegree
    EXPORTING
      is_n1compldegree = ls_n1compldegree
      i_name           = i_name.
*    CATCH cx_ish_static_handler .
*  ENDTRY.

ENDMETHOD.


METHOD destroy.

* Unlock self.
  CALL METHOD me->unlock.

* destroy snapshot handler
  IF gr_snapshothandler IS BOUND.
    CALL METHOD gr_snapshothandler->destroy.
  ENDIF.

* Clear attributes.
  CLEAR: gr_snapshothandler,
         g_deletionmark,
         gs_n1compldegree,
         gs_n1compldegree_orig,
         g_locked,
         g_name,
         g_name_orig,
         g_new.

ENDMETHOD.


METHOD get_count_completed.

  r_count_completed = gs_n1compldegree-count_completed.

ENDMETHOD.


METHOD get_count_total.

  r_count_total = gs_n1compldegree-count_total.

ENDMETHOD.


METHOD get_icon.

  r_icon = gs_n1compldegree-completion_icon.

ENDMETHOD.


METHOD get_id.

  r_compldegree_id = gs_n1compldegree-compldegree_id.

ENDMETHOD.


METHOD get_n1compldegree.

  rs_n1compldegree = gs_n1compldegree.

ENDMETHOD.


METHOD get_name.

  r_name = g_name.

ENDMETHOD.


METHOD get_percentage.

  CLEAR r_percentage.

  CHECK gs_n1compldegree-count_total     IS NOT INITIAL.
  CHECK gs_n1compldegree-count_completed IS NOT INITIAL.

  r_percentage = gs_n1compldegree-count_completed * 100 /
                 gs_n1compldegree-count_total.

ENDMETHOD.


METHOD get_snapshothandler.

  IF gr_snapshothandler IS INITIAL.
    CREATE OBJECT gr_snapshothandler.
  ENDIF.

  rr_snapshothandler = gr_snapshothandler.

ENDMETHOD.


METHOD get_text.

  DATA: l_completed(10)       TYPE c,
        l_total(10)           TYPE c,
        l_percentage          TYPE n1compldegree_percentage,
        l_perct_char          TYPE char10,
        l_attribute           TYPE string.

  CLEAR r_text.

  l_completed = gs_n1compldegree-count_completed.
  l_total     = gs_n1compldegree-count_total.

  PERFORM del_lead_zero IN PROGRAM sapmn1pa USING l_completed.
  PERFORM del_lead_zero IN PROGRAM sapmn1pa USING l_total.

  CONDENSE: l_completed, l_total.

  IF i_attribute_singular IS NOT INITIAL AND
     i_attribute_plural   IS NOT INITIAL.
    IF l_total = 1.
      l_attribute = i_attribute_singular.
    ELSE.
      l_attribute = i_attribute_plural.
    ENDIF.
    CONCATENATE l_completed
                'von'(001)
                l_total
                l_attribute
                'erledigt'(002)
                INTO r_text SEPARATED BY space.
  ELSE.
    CONCATENATE l_completed
                'von'(001)
                l_total
                'erledigt'(002)
                INTO r_text SEPARATED BY space.
  ENDIF.

  IF i_incl_procentage = abap_on.
    l_percentage  = get_percentage( ).
    l_perct_char  = l_percentage.
    PERFORM del_lead_zero IN PROGRAM sapmn1pa USING l_perct_char.
    CONDENSE l_perct_char.
    CONCATENATE r_text '(' l_perct_char ' % )'
           INTO r_text SEPARATED BY space.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_compldegree.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_type  TYPE ish_object_type.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_type.

  IF i_object_type = l_type.
    r_is_a = abap_on.
  ELSE.
    r_is_a = abap_off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_compldegree.
    r_is_inherited_from = abap_on.
  ELSE.
    r_is_inherited_from = abap_off.
  ENDIF.

ENDMETHOD.


METHOD IF_ISH_SNAPSHOT_CALLBACK~CREATE_SNAPSHOT_OBJECT.

  DATA: lr_snapobj  TYPE REF TO cl_ish_snap_compldegree.

* Initializations.
  e_rc = 0.

* Create the snapshot object.
  CREATE OBJECT lr_snapobj.

* Snapshot attributes.
*  lr_snapobj->gr_area              = gr_area.
*  lr_snapobj->gt_complstage        = gt_complstage.
*  lr_snapobj->g_complstages_loaded = g_complstages_loaded.
*  lr_snapobj->g_deletionmark       = g_deletionmark.
*  lr_snapobj->g_id                 = g_id.
*  lr_snapobj->g_locked             = g_locked.
*  lr_snapobj->g_name               = g_name.
*  lr_snapobj->g_name_orig          = g_name_orig.
*  lr_snapobj->g_new                = g_new.
*  lr_snapobj->g_timestamp          = g_timestamp.

* Export.
  er_snapobj = lr_snapobj.

ENDMETHOD.


METHOD if_ish_snapshot_callback~undo_snapshot_object.

  DATA: lr_snapobj  TYPE REF TO cl_ish_snap_compldegree.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK ir_snapobj IS BOUND.

* Cast to the specific snapshot object.
  lr_snapobj ?= ir_snapobj.

* Undo attributes.
  gs_n1compldegree      = lr_snapobj->gs_n1compldegree.
  gs_n1compldegree_orig = lr_snapobj->gs_n1compldegree_orig.
  g_locked              = lr_snapobj->g_locked.
  g_name                = lr_snapobj->g_name.
  g_name_orig           = lr_snapobj->g_name_orig.
  g_deletionmark        = lr_snapobj->g_deletionmark.
  g_new                 = lr_snapobj->g_new.

ENDMETHOD.


METHOD if_ish_snapshot_object~destroy_snapshot.             "#EC NEEDED

* new since ID 19361 Implement if you needed

ENDMETHOD.


METHOD if_ish_snapshot_object~snapshot.

  DATA: lr_hdl  TYPE REF TO cl_ish_snapshothandler.

* Initializations.
  e_rc = 0.
  CLEAR e_key.

* Get the snapshothandler.
  lr_hdl = get_snapshothandler( ).
  CHECK lr_hdl IS BOUND.

* Snapshot.
  CALL METHOD lr_hdl->snapshot
    EXPORTING
      ir_callback = me
    IMPORTING
      e_snapkey   = e_key
      e_rc        = e_rc.

ENDMETHOD.


METHOD if_ish_snapshot_object~undo.

  DATA: lr_hdl  TYPE REF TO cl_ish_snapshothandler.

* Initializations.
  e_rc = 0.

* Get the snapshothandler.
  lr_hdl = get_snapshothandler( ).
  CHECK lr_hdl IS BOUND.

* Snapshot.
  CALL METHOD lr_hdl->undo
    EXPORTING
      ir_callback = me
      i_snapkey   = i_key
    IMPORTING
      e_rc        = e_rc.

ENDMETHOD.


METHOD is_changed.

  r_changed = abap_off.

  IF me->is_new( )                 = abap_on OR
     me->is_marked_for_deletion( ) = abap_on.
    r_changed = abap_on.
  ELSE.
    IF gs_n1compldegree <> gs_n1compldegree_orig.
      r_changed = abap_on.
    ENDIF.
    IF g_name <> g_name_orig.
      r_changed = abap_on.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD is_locked.

  r_locked = g_locked.

ENDMETHOD.


METHOD is_marked_for_deletion.

  r_deletionmark = g_deletionmark.

ENDMETHOD.


METHOD is_new.

  r_new = g_new.

ENDMETHOD.


METHOD load.

  DATA: ls_n1compldegree    TYPE n1compldegree,
        l_name              TYPE n1compldegree_name,
        lr_errorhandler     TYPE REF TO cl_ishmed_errorhandling.

  CLEAR: ls_n1compldegree, l_name.

  ls_n1compldegree = is_n1compldegree.
  l_name           = i_name.

  IF ls_n1compldegree IS INITIAL.
    SELECT SINGLE * FROM n1compldegree INTO ls_n1compldegree
           WHERE  compldegree_id  = i_id.
    IF sy-subrc <> 0.
      CREATE OBJECT lr_errorhandler.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '007'
          i_mv1           = 'CL_ISH_COMPLDEGREE'
        CHANGING
          cr_errorhandler = lr_errorhandler.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.
    ENDIF.
  ENDIF.

  IF l_name IS INITIAL.
    SELECT SINGLE completion_name FROM n1compldegreet INTO l_name
           WHERE  spras           = sy-langu
           AND    compldegree_id  = i_id.
    IF sy-subrc <> 0.
      CREATE OBJECT lr_errorhandler.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '007'
          i_mv1           = 'CL_ISH_COMPLDEGREE'
        CHANGING
          cr_errorhandler = lr_errorhandler.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.
    ENDIF.
  ENDIF.

*  TRY.
  CREATE OBJECT rr_compldegree
    EXPORTING
      is_n1compldegree = ls_n1compldegree
      i_name           = l_name.
*  CATCH cx_ish_static_handler .
*  ENDTRY.

  rr_compldegree->gs_n1compldegree_orig =
                  rr_compldegree->gs_n1compldegree.
  rr_compldegree->g_name_orig = rr_compldegree->g_name.

ENDMETHOD.


METHOD lock.

  DATA: l_timestamp        TYPE n1compldegree-timestamp,
        lr_errorhandler    TYPE REF TO cl_ishmed_errorhandling.

* Lock only if self is not already locked.
  CHECK is_locked( ) = abap_off.

* Lock only if self is not new.
  CHECK is_new( ) = abap_off.

* Enqueue.
  CALL FUNCTION 'ENQUEUE_EN1COMPLDEGREE'
    EXPORTING
      compldegree_id   = gs_n1compldegree-compldegree_id
      x_compldegree_id = abap_on
    EXCEPTIONS
      foreign_lock     = 1
      system_failure   = 2
      OTHERS           = 3.

* Handle the result.
  CASE sy-subrc.
    WHEN  0.
    WHEN  1.
*     Already locked.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '120'
          i_mv1           = gs_n1compldegree-compldegree_id
          i_mv2           = sy-msgv1
        CHANGING
          cr_errorhandler = lr_errorhandler.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.
    WHEN OTHERS.
*     Any locking error.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '121'
          i_mv1           = gs_n1compldegree-compldegree_id
        CHANGING
          cr_errorhandler = lr_errorhandler.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.
  ENDCASE.

* Check actuality.
  SELECT SINGLE timestamp FROM n1compldegree INTO l_timestamp
         WHERE  compldegree_id = gs_n1compldegree-compldegree_id.
  IF l_timestamp <> gs_n1compldegree-timestamp.
*   Dequeue.
    CALL FUNCTION 'DEQUEUE_EN1COMPLDEGREE'
      EXPORTING
        compldegree_id   = gs_n1compldegree-compldegree_id
        x_compldegree_id = abap_on.
*   Data has been changed in the meantime.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '122'
        i_mv1           = gs_n1compldegree-compldegree_id
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

* Self is locked.
  g_locked = abap_on.

ENDMETHOD.


METHOD mark_for_deletion.

  IF me->is_marked_for_deletion( ) = abap_off.
    g_deletionmark = abap_on.
  ENDIF.

ENDMETHOD.


METHOD recalculate.

  DATA: ls_n1complstage    TYPE n1complstage,
        l_percentage       TYPE n1compldegree_percentage.

  CALL METHOD me->get_percentage
    RECEIVING
      r_percentage = l_percentage.

  SELECT * FROM n1complstage INTO ls_n1complstage UP TO 1 ROWS
         WHERE  moncon_id        = gs_n1compldegree-moncon_id
         AND    completion_low  <= l_percentage
         AND    completion_high >= l_percentage.
    EXIT.
  ENDSELECT.
  CHECK sy-subrc = 0.

  gs_n1compldegree-completion_icon = ls_n1complstage-completion_icon.

  SELECT SINGLE completion_name FROM n1complstaget INTO g_name
         WHERE  spras          = sy-langu
         AND    moncon_id      = gs_n1compldegree-moncon_id
         AND    complstage_id  = ls_n1complstage-complstage_id.

ENDMETHOD.


METHOD refresh.

  IF g_new = abap_off AND
     gs_n1compldegree-compldegree_id IS NOT INITIAL.
    SELECT SINGLE * FROM n1compldegree INTO gs_n1compldegree
           WHERE  compldegree_id  = gs_n1compldegree-compldegree_id.
    CHECK sy-subrc = 0.
  ENDIF.

  CALL METHOD me->recalculate.

ENDMETHOD.


METHOD save.

  DATA: l_rc                   TYPE ish_method_rc,
        lt_nvn1compldegree     TYPE ishmed_t_vn1compldegree,
        ls_nvn1compldegree     LIKE LINE OF lt_nvn1compldegree,
        lt_ovn1compldegree     TYPE ishmed_t_vn1compldegree,
        lt_nvn1compldegreet    TYPE ishmed_t_vn1compldegreet,
        lt_ovn1compldegreet    TYPE ishmed_t_vn1compldegreet,
        ls_nvn1compldegreet    LIKE LINE OF lt_nvn1compldegreet,
        lr_errorhandler        TYPE REF TO cl_ishmed_errorhandling.

* Check only if self is changed
  CHECK is_changed( ) = abap_on.

* Save only if object is locked.
  CALL METHOD me->check_lock.

* Check
  CALL METHOD me->_check
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.
  IF l_rc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

* Do not save if object is new and marked for deletion
  IF is_new( ) = abap_on AND is_marked_for_deletion( ) = abap_on.
    EXIT.
  ENDIF.

* Set actual time stamp
  GET TIME STAMP FIELD gs_n1compldegree-timestamp.

* Set values for update
  REFRESH: lt_nvn1compldegree,  lt_ovn1compldegree,
           lt_nvn1compldegreet, lt_ovn1compldegreet.
  CLEAR ls_nvn1compldegree.
  ls_nvn1compldegree           = gs_n1compldegree.
  IF is_new( ) = abap_on.
    ls_nvn1compldegree-kz      = 'I'.
  ELSE.
    IF is_marked_for_deletion( ) = abap_on.
      ls_nvn1compldegree-kz    = 'D'.
    ELSE.
      ls_nvn1compldegree-kz    = 'U'.
    ENDIF.
  ENDIF.
  APPEND ls_nvn1compldegree TO lt_nvn1compldegree.
  CLEAR ls_nvn1compldegreet.
  ls_nvn1compldegreet-mandt           = sy-mandt.
  ls_nvn1compldegreet-spras           = sy-langu.
  ls_nvn1compldegreet-compldegree_id  = gs_n1compldegree-compldegree_id.
  ls_nvn1compldegreet-completion_name = g_name.
  IF is_new( ) = abap_on.
    ls_nvn1compldegreet-kz            = 'I'.
  ELSE.
    IF is_marked_for_deletion( ) = abap_on.
      ls_nvn1compldegreet-kz          = 'D'.
    ELSE.
      ls_nvn1compldegreet-kz          = 'U'.
    ENDIF.
  ENDIF.
  APPEND ls_nvn1compldegreet TO lt_nvn1compldegreet.

* Save.
  IF i_update_task = abap_on.
    CALL FUNCTION 'ISH_UPDATE_N1COMPLDEGREE' IN UPDATE TASK
      EXPORTING
        i_tcode            = sy-tcode
        it_nvn1compldegree = lt_nvn1compldegree
        it_ovn1compldegree = lt_ovn1compldegree.
    CALL FUNCTION 'ISH_UPDATE_N1COMPLDEGREET' IN UPDATE TASK
      EXPORTING
        i_tcode             = sy-tcode
        it_nvn1compldegreet = lt_nvn1compldegreet
        it_ovn1compldegreet = lt_ovn1compldegreet.
  ELSE.
    CALL FUNCTION 'ISH_UPDATE_N1COMPLDEGREE'
      EXPORTING
        i_tcode            = sy-tcode
        it_nvn1compldegree = lt_nvn1compldegree
        it_ovn1compldegree = lt_ovn1compldegree.
    CALL FUNCTION 'ISH_UPDATE_N1COMPLDEGREET'
      EXPORTING
        i_tcode             = sy-tcode
        it_nvn1compldegreet = lt_nvn1compldegreet
        it_ovn1compldegreet = lt_ovn1compldegreet.
  ENDIF.

* Commit Work.
  IF i_commit = on.
    COMMIT WORK AND WAIT.
  ENDIF.

  g_new = abap_off.

ENDMETHOD.


METHOD set_count_completed.

  gs_n1compldegree-count_completed = i_count_completed.

  CALL METHOD me->recalculate.

ENDMETHOD.


METHOD set_count_total.

  gs_n1compldegree-count_total = i_count_total.

  CALL METHOD me->recalculate.

ENDMETHOD.


METHOD unlock.

* Process only if self is locked.
  CHECK g_locked = on.

* Dequeue.
  CALL FUNCTION 'DEQUEUE_EN1COMPLDEGREE'
    EXPORTING
      compldegree_id   = gs_n1compldegree-compldegree_id
      x_compldegree_id = abap_on.

* Self is locked no more.
  g_locked = off.

ENDMETHOD.


METHOD _check.

* Initializations.
  CLEAR: e_rc.

* Check only if self is not marked for deletion.
  CHECK is_marked_for_deletion( ) = abap_off.

* Errorhandling.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Area ID and monitoring konfiguration ID have to be filled
  IF gs_n1compldegree-moncon_id IS INITIAL OR
     gs_n1compldegree-area_id   IS INITIAL.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_COMPLDEGREE'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.
ENDCLASS.
