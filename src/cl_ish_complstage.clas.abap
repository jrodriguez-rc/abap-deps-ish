class CL_ISH_COMPLSTAGE definition
  public
  create protected

  global friends CL_ISH_MONCON .

*"* public components of class CL_ISH_COMPLSTAGE
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_SNAPSHOT_OBJECT .
  interfaces IF_ISH_SNAPSHOT_CALLBACK .

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

  constants CO_OTYPE_COMPLSTAGE type ISH_OBJECT_TYPE value 12186. "#EC NOTEXT

  methods CHECK
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !IR_MONCON type ref to CL_ISH_MONCON
      value(I_ID) type N1COMPLSTAGE_ID
      value(IS_DATA) type RN1COMPLSTAGE_DATA optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_COMPLETION_HIGH
    returning
      value(R_COMPLETION_HIGH) type N1COMPLSTAGE_HIGH .
  methods GET_COMPLETION_ICON
    returning
      value(R_COMPLETION_ICON) type N1COMPLSTAGE_ICON .
  methods GET_COMPLETION_LOW
    returning
      value(R_COMPLETION_LOW) type N1COMPLSTAGE_LOW .
  methods GET_COMPLETION_NAME
    returning
      value(R_COMPLETION_NAME) type N1COMPLSTAGE_NAME .
  methods GET_ID
  final
    returning
      value(R_ID) type N1COMPLSTAGE_ID .
  type-pools ABAP .
  methods IS_CHANGED
    returning
      value(R_CHANGED) type ABAP_BOOL .
  methods IS_MARKED_FOR_DELETION
    returning
      value(R_DELETIONMARK) type ABAP_BOOL .
  methods IS_NEW
    returning
      value(R_NEW) type ABAP_BOOL .
  methods MARK_FOR_DELETION .
  methods REFRESH
    importing
      value(IS_N1COMPLSTAGE) type N1COMPLSTAGE optional
      value(IS_N1COMPLSTAGET) type N1COMPLSTAGET optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_COMPLETION_HIGH
    importing
      value(I_COMPLETION_HIGH) type N1COMPLSTAGE_HIGH .
  methods SET_COMPLETION_ICON
    importing
      value(I_COMPLETION_ICON) type N1COMPLSTAGE_ICON .
  methods SET_COMPLETION_LOW
    importing
      value(I_COMPLETION_LOW) type N1COMPLSTAGE_LOW .
  methods SET_COMPLETION_NAME
    importing
      value(I_COMPLETION_NAME) type N1COMPLSTAGE_NAME .
protected section.
*"* protected components of class CL_ISH_COMPLSTAGE
*"* do not include other source files here!!!

  data GR_SNAPSHOTHANDLER type ref to CL_ISH_SNAPSHOTHANDLER .
  data GS_DATA type RN1COMPLSTAGE_DATA .
  data GS_DATA_ORIG type RN1COMPLSTAGE_DATA .
  data G_DELETIONMARK type ABAP_BOOL .
  data G_NEW type ABAP_BOOL .

  class-methods CREATE
    importing
      !IR_MONCON type ref to CL_ISH_MONCON
      value(IS_DATA) type RN1COMPLSTAGE_DATA optional
    returning
      value(RR_COMPLSTAGE) type ref to CL_ISH_COMPLSTAGE
    raising
      CX_ISH_STATIC_HANDLER .
  methods DESTROY .
  methods GET_SNAPSHOTHANDLER
    returning
      value(RR_SNAPSHOTHANDLER) type ref to CL_ISH_SNAPSHOTHANDLER .
  class-methods LOAD
    importing
      !IR_MONCON type ref to CL_ISH_MONCON
      value(IS_N1COMPLSTAGE) type N1COMPLSTAGE
      value(IS_N1COMPLSTAGET) type N1COMPLSTAGET
    returning
      value(RR_COMPLSTAGE) type ref to CL_ISH_COMPLSTAGE
    raising
      CX_ISH_STATIC_HANDLER .
  methods SAVE
    importing
      value(I_UPDATE_TASK) type ABAP_BOOL default ABAP_ON
      value(I_COMMIT) type ABAP_BOOL default ABAP_ON
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_COMPLSTAGE
*"* do not include other source files here!!!

  data GR_MONCON type ref to CL_ISH_MONCON .
  data G_ID type N1COMPLSTAGE_ID .
ENDCLASS.



CLASS CL_ISH_COMPLSTAGE IMPLEMENTATION.


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


METHOD constructor.

  DATA: lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.

  IF ir_moncon IS INITIAL OR i_id IS INITIAL.
    CREATE OBJECT lr_errorhandler.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_COMPLSTAGE'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ELSE.
    me->gr_moncon = ir_moncon.
    me->gs_data   = is_data.
    me->g_id      = i_id.
  ENDIF.

ENDMETHOD.


METHOD create.

  DATA: l_id         LIKE g_id.

  CALL METHOD cl_ish_utl_base=>generate_uuid_with_prefix
    RECEIVING
      r_uuid = l_id.

*  TRY.
  CREATE OBJECT rr_complstage
    EXPORTING
      ir_moncon = ir_moncon
      i_id      = l_id
      is_data   = is_data.
*  CATCH cx_ish_static_handler .
*  ENDTRY.

  rr_complstage->g_new = abap_on.

ENDMETHOD.


METHOD destroy.

  CLEAR: gr_moncon,
         gr_snapshothandler,
         gs_data,
         gs_data_orig,
         g_deletionmark,
         g_id,
         g_new.

ENDMETHOD.


METHOD get_completion_high.

  r_completion_high = gs_data-completion_high.

ENDMETHOD.


METHOD get_completion_icon.

  r_completion_icon = gs_data-completion_icon.

ENDMETHOD.


METHOD get_completion_low.

  r_completion_low = gs_data-completion_low.

ENDMETHOD.


METHOD get_completion_name.

  r_completion_name = gs_data-completion_name.

ENDMETHOD.


METHOD get_id.

  r_id = g_id.

ENDMETHOD.


METHOD get_snapshothandler.

  IF gr_snapshothandler IS INITIAL.
    CREATE OBJECT gr_snapshothandler.
  ENDIF.

  rr_snapshothandler = gr_snapshothandler.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_complstage.

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

  IF i_object_type = co_otype_complstage.
    r_is_inherited_from = abap_on.
  ELSE.
    r_is_inherited_from = abap_off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_snapshot_callback~create_snapshot_object.

  DATA: lr_snapobj  TYPE REF TO cl_ish_snap_complstage.

* Initializations.
  e_rc = 0.

* Create the snapshot object.
  CREATE OBJECT lr_snapobj.

* Snapshot attributes.
  lr_snapobj->gr_moncon      = gr_moncon.
  lr_snapobj->gs_data        = gs_data.
  lr_snapobj->gs_data_orig   = gs_data_orig.
  lr_snapobj->g_deletionmark = g_deletionmark.
  lr_snapobj->g_id           = g_id.
  lr_snapobj->g_new          = g_new.

* Export.
  er_snapobj = lr_snapobj.

ENDMETHOD.


METHOD if_ish_snapshot_callback~undo_snapshot_object.

  DATA: lr_snapobj  TYPE REF TO cl_ish_snap_complstage.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK ir_snapobj IS BOUND.

* Cast to the specific snapshot object.
  lr_snapobj ?= ir_snapobj.

* Undo attributes.
  gr_moncon      = lr_snapobj->gr_moncon.
  gs_data        = lr_snapobj->gs_data.
  gs_data_orig   = lr_snapobj->gs_data_orig.
  g_deletionmark = lr_snapobj->g_deletionmark.
  g_id           = lr_snapobj->g_id.
  g_new          = lr_snapobj->g_new.

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
     me->is_marked_for_deletion( ) = abap_on OR
     gs_data <> gs_data_orig.
    r_changed = abap_on.
  ENDIF.

ENDMETHOD.


METHOD is_marked_for_deletion.

  r_deletionmark = g_deletionmark.

ENDMETHOD.


METHOD is_new.

  r_new = g_new.

ENDMETHOD.


METHOD load.

  DATA: ls_data           TYPE rn1complstage_data.

  CLEAR ls_data.
  MOVE-CORRESPONDING is_n1complstage  TO ls_data.           "#EC ENHOK
  MOVE-CORRESPONDING is_n1complstaget TO ls_data.           "#EC ENHOK

*  TRY.
  CREATE OBJECT rr_complstage
    EXPORTING
      ir_moncon = ir_moncon
      i_id      = is_n1complstage-complstage_id
      is_data   = ls_data.
*  CATCH cx_ish_static_handler .
*  ENDTRY.

  rr_complstage->gs_data_orig = ls_data.

ENDMETHOD.


METHOD mark_for_deletion.

  IF me->is_marked_for_deletion( ) = abap_off.
    g_deletionmark = abap_on.
  ENDIF.

ENDMETHOD.


METHOD refresh.

  DATA: l_moncon_id     TYPE n1moncon_id.

* Refresh only if self is not new.
  CHECK is_new( ) = abap_off.

* re-read data
  CLEAR: gs_data, gs_data_orig.
  IF is_n1complstage IS INITIAL OR is_n1complstaget IS INITIAL.
    l_moncon_id = gr_moncon->get_id( ).
    SELECT SINGLE * FROM n1complstage
           INTO CORRESPONDING FIELDS OF gs_data_orig
           WHERE moncon_id      = l_moncon_id
             AND complstage_id  = g_id.
    IF sy-subrc = 0.
      SELECT SINGLE * FROM n1complstaget
             INTO CORRESPONDING FIELDS OF gs_data_orig
             WHERE  spras          = sy-langu
               AND  moncon_id      = l_moncon_id
               AND  complstage_id  = g_id.
    ENDIF.
  ELSE.
    MOVE-CORRESPONDING is_n1complstage  TO gs_data_orig.    "#EC ENHOK
    MOVE-CORRESPONDING is_n1complstaget TO gs_data_orig.    "#EC ENHOK
  ENDIF.
  gs_data = gs_data_orig.

ENDMETHOD.


METHOD save.

  DATA: l_rc                  TYPE ish_method_rc,
        lt_nvn1complstage     TYPE ishmed_t_vn1complstage,
        ls_nvn1complstage     LIKE LINE OF lt_nvn1complstage,
        lt_ovn1complstage     TYPE ishmed_t_vn1complstage,
        lt_nvn1complstaget    TYPE ishmed_t_vn1complstaget,
        lt_ovn1complstaget    TYPE ishmed_t_vn1complstaget,
        ls_nvn1complstaget    LIKE LINE OF lt_nvn1complstaget,
        lr_errorhandler       TYPE REF TO cl_ishmed_errorhandling.

* Save only if self is changed.
  CHECK is_changed( ) = abap_on.

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

* Set values for update
  REFRESH: lt_nvn1complstage,  lt_ovn1complstage,
           lt_nvn1complstaget, lt_ovn1complstaget.
  CLEAR ls_nvn1complstage.
  ls_nvn1complstage-mandt            = sy-mandt.
  ls_nvn1complstage-moncon_id        = gr_moncon->get_id( ).
  ls_nvn1complstage-complstage_id    = g_id.
  MOVE-CORRESPONDING gs_data TO ls_nvn1complstage.          "#EC ENHOK
  IF is_new( ) = abap_on.
    ls_nvn1complstage-kz             = 'I'.
  ELSE.
    IF is_marked_for_deletion( ) = abap_on.
      ls_nvn1complstage-kz           = 'D'.
    ELSE.
      ls_nvn1complstage-kz           = 'U'.
    ENDIF.
  ENDIF.
  APPEND ls_nvn1complstage TO lt_nvn1complstage.
  CLEAR ls_nvn1complstaget.
  ls_nvn1complstaget-mandt           = sy-mandt.
  ls_nvn1complstaget-spras           = sy-langu.
  ls_nvn1complstaget-moncon_id       = gr_moncon->get_id( ).
  ls_nvn1complstaget-complstage_id   = g_id.
  MOVE-CORRESPONDING gs_data TO ls_nvn1complstaget.         "#EC ENHOK
  IF is_new( ) = abap_on.
    ls_nvn1complstaget-kz            = 'I'.
  ELSE.
    IF is_marked_for_deletion( ) = abap_on.
      ls_nvn1complstaget-kz          = 'D'.
    ELSE.
      ls_nvn1complstaget-kz          = 'U'.
    ENDIF.
  ENDIF.
  APPEND ls_nvn1complstaget TO lt_nvn1complstaget.

* Save.
  IF i_update_task = abap_on.
    CALL FUNCTION 'ISH_UPDATE_N1COMPLSTAGE' IN UPDATE TASK
      EXPORTING
        i_tcode           = sy-tcode
        it_nvn1complstage = lt_nvn1complstage
        it_ovn1complstage = lt_ovn1complstage.
    CALL FUNCTION 'ISH_UPDATE_N1COMPLSTAGET' IN UPDATE TASK
      EXPORTING
        i_tcode            = sy-tcode
        it_nvn1complstaget = lt_nvn1complstaget
        it_ovn1complstaget = lt_ovn1complstaget.
  ELSE.
    CALL FUNCTION 'ISH_UPDATE_N1COMPLSTAGE'
      EXPORTING
        i_tcode           = sy-tcode
        it_nvn1complstage = lt_nvn1complstage
        it_ovn1complstage = lt_ovn1complstage.
    CALL FUNCTION 'ISH_UPDATE_N1COMPLSTAGET'
      EXPORTING
        i_tcode            = sy-tcode
        it_nvn1complstaget = lt_nvn1complstaget
        it_ovn1complstaget = lt_ovn1complstaget.
  ENDIF.

* Commit Work.
  IF i_commit = on.
    COMMIT WORK AND WAIT.
  ENDIF.

  g_new = abap_off.

ENDMETHOD.


METHOD set_completion_high.

  gs_data-completion_high = i_completion_high.

ENDMETHOD.


METHOD set_completion_icon.

  gs_data-completion_icon = i_completion_icon.

ENDMETHOD.


METHOD set_completion_low.

  gs_data-completion_low = i_completion_low.

ENDMETHOD.


METHOD set_completion_name.

  gs_data-completion_name = i_completion_name.

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

* Check self.
  IF gs_data-completion_low > gs_data-completion_high.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '109'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 10.
  ENDIF.

*  IF gs_data-completion_icon IS INITIAL.
*    CALL METHOD cl_ish_utl_base=>collect_messages
*      EXPORTING
*        i_typ           = 'E'
*        i_kla           = 'N1BASE'
*        i_num           = '114'
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    e_rc = 11.
*  ENDIF.
*
*  IF gs_data-completion_name IS INITIAL.
*    CALL METHOD cl_ish_utl_base=>collect_messages
*      EXPORTING
*        i_typ           = 'E'
*        i_kla           = 'N1BASE'
*        i_num           = '115'
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    e_rc = 12.
*  ENDIF.

ENDMETHOD.
ENDCLASS.
