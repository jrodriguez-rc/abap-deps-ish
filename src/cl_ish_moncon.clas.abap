class CL_ISH_MONCON definition
  public
  create protected

  global friends CL_ISH_MONCON_AREA .

public section.
*"* public components of class CL_ISH_MONCON
*"* do not include other source files here!!!

  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_SNAPSHOT_OBJECT .
  interfaces IF_ISH_SNAPSHOT_CALLBACK .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISHMED_CTS .

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

  constants CO_OTYPE_MONCON type ISH_OBJECT_TYPE value 12185. "#EC NOTEXT
  constants CO_TRA_MONCON type CHAR4 value 'N1MC'. "#EC NOTEXT

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
      !IR_AREA type ref to CL_ISH_MONCON_AREA
      value(I_ID) type N1MONCON_ID
      value(I_NAME) type N1MONCON_NAME optional
      value(I_TIMESTAMP) type TIMESTAMPL optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods CREATE_COMPLSTAGE
    returning
      value(RR_COMPLSTAGE) type ref to CL_ISH_COMPLSTAGE
    raising
      CX_ISH_STATIC_HANDLER .
  methods CREATE_COPY
    returning
      value(RR_MONCON_COPY) type ref to CL_ISH_MONCON
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_AREA
  final
    returning
      value(RR_AREA) type ref to CL_ISH_MONCON_AREA .
  methods GET_COMPLSTAGE
    importing
      value(I_ID) type N1COMPLSTAGE_ID
    returning
      value(RR_COMPLSTAGE) type ref to CL_ISH_COMPLSTAGE
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_COMPLSTAGES
    returning
      value(RT_COMPLSTAGE) type ISH_T_COMPLSTAGE_OBJ
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_ID
    returning
      value(R_MONCON_ID) type N1MONCON_ID .
  methods GET_NAME
    returning
      value(R_NAME) type N1MONCON_NAME .
  type-pools ABAP .
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
  methods LOCK
    raising
      CX_ISH_STATIC_HANDLER .
  methods MARK_FOR_DELETION .
  methods REFRESH
    raising
      CX_ISH_STATIC_HANDLER .
  methods SAVE
    importing
      value(I_UPDATE_TASK) type ABAP_BOOL default ABAP_ON
      value(I_COMMIT) type ABAP_BOOL default ABAP_ON
    preferred parameter I_UPDATE_TASK
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_NAME
    importing
      value(I_NAME) type N1MONCON_NAME .
  methods UNLOCK .
protected section.
*"* protected components of class CL_ISH_MONCON
*"* do not include other source files here!!!

  data GR_SNAPSHOTHANDLER type ref to CL_ISH_SNAPSHOTHANDLER .
  data GT_COMPLSTAGE type ISH_T_COMPLSTAGE_OBJ .
  type-pools ABAP .
  data G_COMPLSTAGES_LOADED type ABAP_BOOL .
  data G_DELETIONMARK type ABAP_BOOL .
  data G_LOCKED type ABAP_BOOL .
  data G_NAME type N1MONCON_NAME .
  data G_NAME_ORIG type N1MONCON_NAME .
  data G_NEW type ABAP_BOOL .

  class-methods CREATE
    importing
      !IR_AREA type ref to CL_ISH_MONCON_AREA
      value(I_NAME) type N1MONCON_NAME optional
    returning
      value(RR_MONCON) type ref to CL_ISH_MONCON
    raising
      CX_ISH_STATIC_HANDLER .
  methods DESTROY .
  methods GET_SNAPSHOTHANDLER
    returning
      value(RR_SNAPSHOTHANDLER) type ref to CL_ISH_SNAPSHOTHANDLER .
  class-methods LOAD
    importing
      !IR_AREA type ref to CL_ISH_MONCON_AREA
      value(IS_N1MONCON) type N1MONCON
      value(IS_N1MONCONT) type N1MONCONT
    returning
      value(RR_MONCON) type ref to CL_ISH_MONCON
    raising
      CX_ISH_STATIC_HANDLER .
  methods LOAD_COMPLSTAGES .
  methods _CHECK
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_MONCON
*"* do not include other source files here!!!

  data GR_AREA type ref to CL_ISH_MONCON_AREA .
  data G_ID type N1MONCON_ID .
  data G_TIMESTAMP type TIMESTAMPL .
ENDCLASS.



CLASS CL_ISH_MONCON IMPLEMENTATION.


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
        i_num           = '108'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD constructor.

  DATA: lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.

  IF ir_area IS INITIAL OR i_id IS INITIAL.
    CREATE OBJECT lr_errorhandler.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_MONCON'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ELSE.
    me->gr_area     = ir_area.
    me->g_id        = i_id.
    me->g_name      = i_name.
    me->g_timestamp = i_timestamp.
  ENDIF.

ENDMETHOD.


METHOD create.

  DATA: l_id         LIKE g_id,
        l_timestamp  LIKE g_timestamp.

  GET TIME STAMP FIELD l_timestamp.

  CALL METHOD cl_ish_utl_base=>generate_uuid_with_prefix
    RECEIVING
      r_uuid = l_id.

*  TRY.
  CREATE OBJECT rr_moncon
    EXPORTING
      ir_area     = ir_area
      i_id        = l_id
      i_name      = i_name
      i_timestamp = l_timestamp.
*    CATCH cx_ish_static_handler .
*  ENDTRY.

  rr_moncon->g_new = abap_on.

ENDMETHOD.


METHOD create_complstage.

  DATA: ls_complstage     LIKE LINE OF gt_complstage.

*  TRY.
  CALL METHOD cl_ish_complstage=>create
    EXPORTING
      ir_moncon     = me
*      IS_DATA       =
    RECEIVING
      rr_complstage = rr_complstage.
*   CATCH CX_ISH_STATIC_HANDLER .
*  ENDTRY.

  IF rr_complstage IS BOUND.
    CLEAR ls_complstage.
    ls_complstage-complstage_id = rr_complstage->get_id( ).
    ls_complstage-r_complstage  = rr_complstage.
    INSERT ls_complstage INTO TABLE gt_complstage.
  ENDIF.

ENDMETHOD.


METHOD create_copy.

  DATA: ls_data         TYPE rn1complstage_data,
        ls_complstage   LIKE LINE OF gt_complstage,
        lr_complstage   TYPE REF TO cl_ish_complstage.

*  TRY.
  CALL METHOD gr_area->create_config
*    EXPORTING
*      I_NAME    =
    RECEIVING
      rr_moncon = rr_moncon_copy.
*   CATCH CX_ISH_STATIC_HANDLER .
*  ENDTRY.

  CHECK rr_moncon_copy IS BOUND.

  LOOP AT gt_complstage INTO ls_complstage.
    CLEAR: lr_complstage, ls_data.
    ls_data-completion_low =
       ls_complstage-r_complstage->get_completion_low( ).
    ls_data-completion_high =
       ls_complstage-r_complstage->get_completion_high( ).
    ls_data-completion_icon =
       ls_complstage-r_complstage->get_completion_icon( ).
    ls_data-completion_name =
       ls_complstage-r_complstage->get_completion_name( ).
    TRY.
        CALL METHOD rr_moncon_copy->create_complstage
          RECEIVING
            rr_complstage = lr_complstage.
      CATCH cx_ish_static_handler .
        CONTINUE.
    ENDTRY.
    CHECK lr_complstage IS BOUND.
    CALL METHOD lr_complstage->set_completion_low
      EXPORTING
        i_completion_low = ls_data-completion_low.
    CALL METHOD lr_complstage->set_completion_high
      EXPORTING
        i_completion_high = ls_data-completion_high.
    CALL METHOD lr_complstage->set_completion_icon
      EXPORTING
        i_completion_icon = ls_data-completion_icon.
    CALL METHOD lr_complstage->set_completion_name
      EXPORTING
        i_completion_name = ls_data-completion_name.
  ENDLOOP.

ENDMETHOD.


METHOD destroy.

  DATA: ls_complstage   LIKE LINE OF gt_complstage.

* Unlock self.
  CALL METHOD me->unlock.

* destroy completion stages
  LOOP AT gt_complstage INTO ls_complstage.
    CALL METHOD ls_complstage-r_complstage->destroy.
  ENDLOOP.

* destroy snapshot handler
  IF gr_snapshothandler IS BOUND.
    CALL METHOD gr_snapshothandler->destroy.
  ENDIF.

* Clear attributes.
  CLEAR: gr_area,
         gr_snapshothandler,
         gt_complstage[],
         g_complstages_loaded,
         g_deletionmark,
         g_id,
         g_locked,
         g_name,
         g_name_orig,
         g_new,
         g_timestamp.

ENDMETHOD.


METHOD get_area.

  rr_area = gr_area.

ENDMETHOD.


METHOD get_complstage.

  DATA: ls_complstage         LIKE LINE OF gt_complstage,
        lr_errorhandler       TYPE REF TO cl_ishmed_errorhandling.

  CLEAR rr_complstage.

  IF g_complstages_loaded = abap_off AND g_new = abap_off.
    CALL METHOD me->load_complstages.
  ENDIF.

 READ TABLE gt_complstage INTO ls_complstage
      WITH TABLE KEY complstage_id = i_id.
  IF sy-subrc = 0.
    rr_complstage = ls_complstage-r_complstage.
  ELSE.
    CREATE OBJECT lr_errorhandler.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_MONCON'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD get_complstages.

  REFRESH rt_complstage.

  IF g_complstages_loaded = abap_off AND g_new = abap_off.
    CALL METHOD me->load_complstages.
  ENDIF.

  rt_complstage[] = gt_complstage[].

ENDMETHOD.


METHOD get_id.

  r_moncon_id = g_id.

ENDMETHOD.


METHOD get_name.

  r_name = g_name.

ENDMETHOD.


METHOD get_snapshothandler.

  IF gr_snapshothandler IS INITIAL.
    CREATE OBJECT gr_snapshothandler.
  ENDIF.

  rr_snapshothandler = gr_snapshothandler.

ENDMETHOD.


METHOD if_ishmed_cts~get_object_list.

  DATA: ls_object    LIKE LINE OF ct_object_list.

* append infoitem to object-list
  CLEAR ls_object.

  ls_object-pgmid    = 'R3TR'.
  ls_object-object   = co_tra_moncon.
  ls_object-obj_name = g_id.
  APPEND ls_object TO ct_object_list.


*  DATA: BEGIN OF ls_n1moncon_key,
*          mandt        TYPE n1moncon-mandt,
*          moncon_id    TYPE n1moncon-moncon_id,
*        END OF ls_n1moncon_key.
*
*  DATA: BEGIN OF ls_n1moncont_key,
*          mandt        TYPE n1moncont-mandt,
*          spras        TYPE n1moncont-spras,
*          moncon_id    TYPE n1moncont-moncon_id,
*        END OF ls_n1moncont_key.
*
*  DATA: ls_complstage  LIKE LINE OF gt_complstage.
*
*  DATA: lt_object_list LIKE ct_object_list,
*        lt_key_list    LIKE ct_key_list.
*
*  DATA: ls_obj         LIKE LINE OF ct_object_list,
*        ls_key         LIKE LINE OF ct_key_list.
*
** Initializations.
*  REFRESH: ct_object_list, ct_key_list.
*
** n1moncon obj.
*  CLEAR: ls_obj.
*  ls_obj-pgmid    = 'R3TR'.
*  ls_obj-object   = 'TABU'.
*  ls_obj-objfunc  = 'K'.
*  ls_obj-obj_name = 'N1MONCON'.
*  APPEND ls_obj TO ct_object_list.
*
** n1moncont obj.
*  CLEAR: ls_obj.
*  ls_obj-pgmid    = 'R3TR'.
*  ls_obj-object   = 'TABU'.
*  ls_obj-objfunc  = 'K'.
*  ls_obj-obj_name = 'N1MONCONT'.
*  APPEND ls_obj TO ct_object_list.
*
** n1moncon key.
*  CLEAR: ls_key, ls_n1moncon_key.
*  ls_n1moncon_key-mandt     = sy-mandt.
*  ls_n1moncon_key-moncon_id = g_id.
*  ls_key-pgmid      = 'R3TR'.
*  ls_key-object     = 'TABU'.
*  ls_key-mastertype = 'TABU'.
*  ls_key-objname    = 'N1MONCON'.
*  ls_key-mastername = 'N1MONCON'.
*  ls_key-tabkey     = ls_n1moncon_key.
*  APPEND ls_key TO ct_key_list.
*
** n1moncont key.
*  CLEAR: ls_key, ls_n1moncont_key.
*  ls_n1moncont_key-mandt     = sy-mandt.
*  ls_n1moncont_key-spras     = sy-langu.
*  ls_n1moncont_key-moncon_id = g_id.
*  ls_key-pgmid      = 'R3TR'.
*  ls_key-object     = 'TABU'.
*  ls_key-mastertype = 'TABU'.
*  ls_key-objname    = 'N1MONCONT'.
*  ls_key-mastername = 'N1MONCONT'.
*  ls_key-tabkey     = ls_n1moncont_key.
*  APPEND ls_key TO ct_key_list.
*
** completion stages
*  LOOP AT gt_complstage INTO ls_complstage.
*    REFRESH: lt_object_list, lt_key_list.
**    TRY.
*    CALL METHOD
*      ls_complstage-r_complstage->if_ishmed_cts~get_object_list
*      CHANGING
*        ct_object_list = lt_object_list
*        ct_key_list    = lt_key_list.
**     CATCH CX_ISHMED_CTS .
**    ENDTRY.
*    APPEND LINES OF lt_object_list TO ct_object_list.
*    APPEND LINES OF lt_key_list    TO ct_key_list.
*  ENDLOOP.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_moncon.

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

  IF i_object_type = co_otype_moncon.
    r_is_inherited_from = abap_on.
  ELSE.
    r_is_inherited_from = abap_off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_snapshot_callback~create_snapshot_object.

  DATA: lr_snapobj  TYPE REF TO cl_ish_snap_moncon.

* Initializations.
  e_rc = 0.

* Create the snapshot object.
  CREATE OBJECT lr_snapobj.

* Snapshot attributes.
  lr_snapobj->gr_area              = gr_area.
  lr_snapobj->gt_complstage        = gt_complstage.
  lr_snapobj->g_complstages_loaded = g_complstages_loaded.
  lr_snapobj->g_deletionmark       = g_deletionmark.
  lr_snapobj->g_id                 = g_id.
  lr_snapobj->g_locked             = g_locked.
  lr_snapobj->g_name               = g_name.
  lr_snapobj->g_name_orig          = g_name_orig.
  lr_snapobj->g_new                = g_new.
  lr_snapobj->g_timestamp          = g_timestamp.

* Export.
  er_snapobj = lr_snapobj.

ENDMETHOD.


METHOD if_ish_snapshot_callback~undo_snapshot_object.

  DATA: lr_snapobj  TYPE REF TO cl_ish_snap_moncon.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK ir_snapobj IS BOUND.

* Cast to the specific snapshot object.
  lr_snapobj ?= ir_snapobj.

* Undo attributes.
  gr_area              = lr_snapobj->gr_area.
  gt_complstage        = lr_snapobj->gt_complstage.
  g_complstages_loaded = lr_snapobj->g_complstages_loaded.
  g_locked             = lr_snapobj->g_locked.
  g_name               = lr_snapobj->g_name.
  g_name_orig          = lr_snapobj->g_name_orig.
  g_timestamp          = lr_snapobj->g_timestamp.
  g_deletionmark       = lr_snapobj->g_deletionmark.
  g_id                 = lr_snapobj->g_id.
  g_new                = lr_snapobj->g_new.

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

  DATA: ls_complstage LIKE LINE OF gt_complstage.

  r_changed = abap_off.

  IF me->is_new( )                 = abap_on OR
     me->is_marked_for_deletion( ) = abap_on.
    r_changed = abap_on.
  ELSE.
    IF g_name <> g_name_orig.
      r_changed = abap_on.
    ELSE.
      LOOP AT gt_complstage INTO ls_complstage.
        IF ls_complstage-r_complstage->is_changed( ) = abap_on.
          r_changed = abap_on.
          EXIT.
        ENDIF.
      ENDLOOP.
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

*  TRY.
  CREATE OBJECT rr_moncon
    EXPORTING
      ir_area     = ir_area
      i_id        = is_n1moncon-moncon_id
      i_name      = is_n1moncont-moncon_name
      i_timestamp = is_n1moncon-timestamp.
*    CATCH cx_ish_static_handler .
*  ENDTRY.

  rr_moncon->g_name_orig = is_n1moncont-moncon_name.

ENDMETHOD.


METHOD load_complstages.

  DATA: lt_n1complstage     TYPE TABLE OF n1complstage,
        ls_n1complstage     LIKE LINE OF lt_n1complstage,
        lt_n1complstaget    TYPE HASHED TABLE OF n1complstaget
                            WITH UNIQUE KEY complstage_id,
        ls_n1complstaget    LIKE LINE OF lt_n1complstaget,
        ls_complstage       LIKE LINE OF gt_complstage,
        lr_complstage       TYPE REF TO cl_ish_complstage.

  g_complstages_loaded = abap_on.

  REFRESH: lt_n1complstage, lt_n1complstaget.

  SELECT * FROM n1complstage INTO TABLE lt_n1complstage
         WHERE  moncon_id  = g_id.
  CHECK sy-subrc = 0.
  SELECT * FROM n1complstaget INTO TABLE lt_n1complstaget
         FOR ALL ENTRIES IN lt_n1complstage
         WHERE  spras          = sy-langu
         AND    moncon_id      = g_id
         AND    complstage_id  = lt_n1complstage-complstage_id.

  LOOP AT lt_n1complstage INTO ls_n1complstage.
    READ TABLE lt_n1complstaget INTO ls_n1complstaget
         WITH TABLE KEY complstage_id = ls_n1complstage-complstage_id.
    IF sy-subrc <> 0.
      CLEAR ls_n1complstaget.
    ENDIF.
    CLEAR lr_complstage.
    TRY.
        CALL METHOD cl_ish_complstage=>load
          EXPORTING
            ir_moncon        = me
            is_n1complstage  = ls_n1complstage
            is_n1complstaget = ls_n1complstaget
          RECEIVING
            rr_complstage    = lr_complstage.
      CATCH cx_ish_static_handler .
        CONTINUE.
    ENDTRY.
    CHECK lr_complstage IS BOUND.
    CLEAR ls_complstage.
    ls_complstage-complstage_id = ls_n1complstage-complstage_id.
    ls_complstage-r_complstage  = lr_complstage.
    INSERT ls_complstage INTO TABLE gt_complstage.
  ENDLOOP.

ENDMETHOD.


METHOD lock.

  DATA: l_timestamp        TYPE n1moncon-timestamp,
        lr_errorhandler    TYPE REF TO cl_ishmed_errorhandling.

* Lock only if self is not already locked.
  CHECK is_locked( ) = abap_off.

* Lock only if self is not new.
  CHECK is_new( ) = abap_off.

* Enqueue.
  CALL FUNCTION 'ENQUEUE_EN1MONCON'
    EXPORTING
      moncon_id      = g_id
      x_moncon_id    = abap_on
    EXCEPTIONS
      foreign_lock   = 1
      system_failure = 2
      OTHERS         = 3.

* Handle the result.
  CASE sy-subrc.
    WHEN  0.
    WHEN  1.
*     Already locked.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '098'
          i_mv1           = g_id
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
          i_num           = '099'
          i_mv1           = g_id
        CHANGING
          cr_errorhandler = lr_errorhandler.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.
  ENDCASE.

* Check actuality.
  SELECT SINGLE timestamp FROM n1moncon INTO l_timestamp
         WHERE  moncon_id = g_id.
  IF l_timestamp <> g_timestamp.
*   Dequeue.
    CALL FUNCTION 'DEQUEUE_EN1MONCON'
      EXPORTING
        moncon_id   = g_id
        x_moncon_id = abap_on.
*   Data has been changed in the meantime.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '107'
        i_mv1           = g_id
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


METHOD refresh.

  DATA: ls_complstage     LIKE LINE OF gt_complstage,
        lt_n1complstage   TYPE HASHED TABLE OF n1complstage
                               WITH UNIQUE KEY complstage_id,
        ls_n1complstage   LIKE LINE OF lt_n1complstage,
        lt_n1complstaget  TYPE HASHED TABLE OF n1complstaget
                               WITH UNIQUE KEY complstage_id,
        ls_n1complstaget  LIKE LINE OF lt_n1complstaget,
        lr_complstage     TYPE REF TO cl_ish_complstage.

* Refresh only if self is not new.
  CHECK is_new( ) = abap_off.

* re-read monitoring configuration timestamp
  SELECT SINGLE timestamp FROM n1moncon INTO g_timestamp
         WHERE  moncon_id  = g_id.
  IF sy-subrc <> 0.
    CLEAR g_timestamp.
  ENDIF.

* re-read monitoring configuration name
  SELECT SINGLE moncon_name FROM n1moncont INTO g_name_orig
         WHERE  spras      = sy-langu
         AND    moncon_id  = g_id.
  IF sy-subrc <> 0.
    CLEAR g_name_orig.
  ENDIF.

* re-read completion stages
  IF g_complstages_loaded = abap_on.
    SELECT * FROM n1complstage INTO TABLE lt_n1complstage
           WHERE  moncon_id  = g_id.
    IF sy-subrc = 0.
      SELECT * FROM n1complstaget INTO TABLE lt_n1complstaget
             FOR ALL ENTRIES IN lt_n1complstage
             WHERE  spras          = sy-langu
             AND    moncon_id      = g_id
             AND    complstage_id  = lt_n1complstage-complstage_id.
    ENDIF.
    LOOP AT lt_n1complstage INTO ls_n1complstage.
      READ TABLE lt_n1complstaget INTO ls_n1complstaget
         WITH TABLE KEY complstage_id = ls_n1complstage-complstage_id.
      IF sy-subrc <> 0.
        CLEAR ls_n1complstaget.
      ENDIF.
      READ TABLE gt_complstage INTO ls_complstage
        WITH TABLE KEY complstage_id = ls_n1complstage-complstage_id.
      IF sy-subrc = 0.
        TRY.
            CALL METHOD ls_complstage-r_complstage->refresh
              EXPORTING
                is_n1complstage  = ls_n1complstage
                is_n1complstaget = ls_n1complstaget.
          CATCH cx_ish_static_handler .
            CONTINUE.
        ENDTRY.
      ELSE.
        CLEAR lr_complstage.
        TRY.
            CALL METHOD cl_ish_complstage=>load
              EXPORTING
                ir_moncon        = me
                is_n1complstage  = ls_n1complstage
                is_n1complstaget = ls_n1complstaget
              RECEIVING
                rr_complstage    = lr_complstage.
          CATCH cx_ish_static_handler .
            CONTINUE.
        ENDTRY.
        CHECK lr_complstage IS BOUND.
        CLEAR ls_complstage.
        ls_complstage-complstage_id = ls_n1complstage-complstage_id.
        ls_complstage-r_complstage  = lr_complstage.
        INSERT ls_complstage INTO TABLE gt_complstage.
      ENDIF.
    ENDLOOP.
    LOOP AT gt_complstage INTO ls_complstage.
      READ TABLE lt_n1complstage INTO ls_n1complstage
         WITH TABLE KEY complstage_id = ls_complstage-complstage_id.
      CHECK sy-subrc <> 0.
      IF ls_complstage-r_complstage IS BOUND.
        CALL METHOD ls_complstage-r_complstage->destroy.
      ENDIF.
      DELETE gt_complstage
             WHERE complstage_id = ls_complstage-complstage_id.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD save.

  DATA: l_rc              TYPE ish_method_rc,
        lt_nvn1moncon     TYPE ishmed_t_vn1moncon,
        ls_nvn1moncon     LIKE LINE OF lt_nvn1moncon,
        lt_ovn1moncon     TYPE ishmed_t_vn1moncon,
        lt_nvn1moncont    TYPE ishmed_t_vn1moncont,
        lt_ovn1moncont    TYPE ishmed_t_vn1moncont,
        ls_nvn1moncont    LIKE LINE OF lt_nvn1moncont,
        ls_complstage     LIKE LINE OF gt_complstage,
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.

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
  GET TIME STAMP FIELD g_timestamp.

* Set values for update
  REFRESH: lt_nvn1moncon,  lt_ovn1moncon,
           lt_nvn1moncont, lt_ovn1moncont.
  CLEAR ls_nvn1moncon.
  ls_nvn1moncon-mandt        = sy-mandt.
  ls_nvn1moncon-moncon_id    = g_id.
  ls_nvn1moncon-area_id      = gr_area->get_id( ).
  ls_nvn1moncon-timestamp    = g_timestamp.
  IF is_new( ) = abap_on.
    ls_nvn1moncon-kz         = 'I'.
  ELSE.
    IF is_marked_for_deletion( ) = abap_on.
      ls_nvn1moncon-kz       = 'D'.
    ELSE.
      ls_nvn1moncon-kz       = 'U'.
    ENDIF.
  ENDIF.
  APPEND ls_nvn1moncon TO lt_nvn1moncon.
  CLEAR ls_nvn1moncont.
  ls_nvn1moncont-mandt       = sy-mandt.
  ls_nvn1moncont-spras       = sy-langu.
  ls_nvn1moncont-moncon_id   = g_id.
  ls_nvn1moncont-moncon_name = g_name.
  IF is_new( ) = abap_on.
    ls_nvn1moncont-kz        = 'I'.
  ELSE.
    IF is_marked_for_deletion( ) = abap_on.
      ls_nvn1moncont-kz      = 'D'.
    ELSE.
      ls_nvn1moncont-kz      = 'U'.
    ENDIF.
  ENDIF.
  APPEND ls_nvn1moncont TO lt_nvn1moncont.

* Save.
  IF i_update_task = abap_on.
    CALL FUNCTION 'ISH_UPDATE_N1MONCON' IN UPDATE TASK
      EXPORTING
        i_tcode       = sy-tcode
        it_nvn1moncon = lt_nvn1moncon
        it_ovn1moncon = lt_ovn1moncon.
    CALL FUNCTION 'ISH_UPDATE_N1MONCONT' IN UPDATE TASK
      EXPORTING
        i_tcode        = sy-tcode
        it_nvn1moncont = lt_nvn1moncont
        it_ovn1moncont = lt_ovn1moncont.
  ELSE.
    CALL FUNCTION 'ISH_UPDATE_N1MONCON'
      EXPORTING
        i_tcode       = sy-tcode
        it_nvn1moncon = lt_nvn1moncon
        it_ovn1moncon = lt_ovn1moncon.
    CALL FUNCTION 'ISH_UPDATE_N1MONCONT'
      EXPORTING
        i_tcode        = sy-tcode
        it_nvn1moncont = lt_nvn1moncont
        it_ovn1moncont = lt_ovn1moncont.
  ENDIF.

* Save completion stages
  LOOP AT gt_complstage INTO ls_complstage WHERE r_complstage IS BOUND.
*    TRY.
    CALL METHOD ls_complstage-r_complstage->save
      EXPORTING
        i_update_task = i_update_task
        i_commit      = i_commit.
*     CATCH CX_ISH_STATIC_HANDLER .
*    ENDTRY.
  ENDLOOP.

* Commit Work.
  IF i_commit = on.
    COMMIT WORK AND WAIT.
  ENDIF.

  g_new = abap_off.

ENDMETHOD.


METHOD set_name.

  g_name = i_name.

ENDMETHOD.


METHOD unlock.

* Process only if self is locked.
  CHECK g_locked = on.

* Dequeue.
  CALL FUNCTION 'DEQUEUE_EN1MONCON'
    EXPORTING
      moncon_id   = g_id
      x_moncon_id = abap_on.

* Self is locked no more.
  g_locked = off.

ENDMETHOD.


METHOD _check.

  DATA: ls_complstage    LIKE LINE OF gt_complstage,
        l_last_idx       TYPE sy-tabix,
        l_rc             TYPE ish_method_rc,
        l_name           TYPE n1moncon_name,
        l_next_high      TYPE n1complstage-completion_high,
        lt_configs       TYPE ish_t_moncon_obj,
        ls_config        LIKE LINE OF lt_configs,
        lt_complst       TYPE TABLE OF rn1complstage_data,
        ls_complst       LIKE LINE OF lt_complst,
        ls_last_complst  LIKE LINE OF lt_complst.

* Initializations.
  CLEAR: e_rc.

* Check only if area is valid.
  CHECK gr_area->is_valid( ) = abap_on.

* Check only if self is not marked for deletion.
  CHECK is_marked_for_deletion( ) = abap_off.

* Errorhandling.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Checks.
  IF g_name IS INITIAL.
*   Check the name.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '116'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
  ELSE.
*   Check name against other monitoring configurations of area
    CALL METHOD gr_area->get_configs
      RECEIVING
        rt_config = lt_configs.
    LOOP AT lt_configs INTO ls_config WHERE r_moncon IS BOUND.
      CHECK ls_config-r_moncon <> me.
      CALL METHOD ls_config-r_moncon->get_name
        RECEIVING
          r_name = l_name.
      CHECK l_name IS NOT INITIAL.
      IF g_name = l_name.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = '117'
          CHANGING
            cr_errorhandler = cr_errorhandler.
        e_rc = 2.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDIF.

* Check completion stages
  LOOP AT gt_complstage INTO ls_complstage WHERE r_complstage IS BOUND.
    CALL METHOD ls_complstage-r_complstage->check
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.
    IF ls_complstage-r_complstage->is_marked_for_deletion( ) = abap_on.
      CONTINUE.
    ENDIF.
    CLEAR ls_complst.
    CALL METHOD ls_complstage-r_complstage->get_completion_low
      RECEIVING
        r_completion_low = ls_complst-completion_low.
    CALL METHOD ls_complstage-r_complstage->get_completion_high
      RECEIVING
        r_completion_high = ls_complst-completion_high.
    APPEND ls_complst TO lt_complst.
  ENDLOOP.

  SORT lt_complst BY completion_low.
  DESCRIBE TABLE lt_complst LINES l_last_idx.
  LOOP AT lt_complst INTO ls_complst.
    IF sy-tabix = 1.
      IF ls_complst-completion_low <> 0.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = '118'
          CHANGING
            cr_errorhandler = cr_errorhandler.
        e_rc = 3.
        EXIT.
      ENDIF.
    ELSE.
      IF ls_complst-completion_low <= ls_last_complst-completion_high.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = '118'
          CHANGING
            cr_errorhandler = cr_errorhandler.
        e_rc = 4.
        EXIT.
      ELSE.
        l_next_high = ls_last_complst-completion_high + 1.
        IF ls_complst-completion_low > l_next_high.
          CALL METHOD cl_ish_utl_base=>collect_messages
            EXPORTING
              i_typ           = 'E'
              i_kla           = 'N1BASE'
              i_num           = '118'
            CHANGING
              cr_errorhandler = cr_errorhandler.
          e_rc = 5.
          EXIT.
        ENDIF.
      ENDIF.
    ENDIF.
    IF sy-tabix = l_last_idx.
      IF ls_complst-completion_high <> 100.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = '118'
          CHANGING
            cr_errorhandler = cr_errorhandler.
        e_rc = 6.
        EXIT.
      ENDIF.
    ENDIF.
    ls_last_complst = ls_complst.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
