class CL_ISH_ACTSNAPHANDLER definition
  public
  create public .

public section.
*"* public components of class CL_ISH_ACTSNAPHANDLER
*"* do not include other source files here!!!

  interfaces IF_ISH_DESTROYABLE
      final methods DESTROY
                    IS_DESTROYED
                    IS_IN_DESTROY_MODE .

  aliases DESTROY
    for IF_ISH_DESTROYABLE~DESTROY .
  aliases IS_DESTROYED
    for IF_ISH_DESTROYABLE~IS_DESTROYED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_DESTROYABLE~IS_IN_DESTROY_MODE .
  aliases EV_AFTER_DESTROY
    for IF_ISH_DESTROYABLE~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_DESTROYABLE~EV_BEFORE_DESTROY .

  events EV_ACTSNAP_ADDED
    exporting
      value(E_ACTION_ID) type SYSUUID_C .
  events EV_ACTSNAP_REMOVED
    exporting
      value(E_ACTION_ID) type SYSUUID_C .

  methods CLEAR_ACTION_SNAPSHOT
    importing
      !I_ACTION_ID type SYSUUID_C
    returning
      value(RS_ACTSNAP) type RN1_ACTION_SNAPSHOT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !IR_SNAPSHOTABLE type ref to IF_ISH_SNAPSHOTABLE
      !I_MAX_NR_OF_SNAPSHOTS type I default 5
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods GET_ACTION_CONTENT
    importing
      !I_ACTION_ID type SYSUUID_C
      !I_NAME type N1CONTENTNAME
    exporting
      !E_NOT_FOUND type ABAP_BOOL
    changing
      !C_CONTENT type ANY
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_ACTION_TEXT_BY_ID
    importing
      !I_ACTION_ID type SYSUUID_C
    returning
      value(R_ACTION_TEXT) type N1STRING .
  methods GET_MAX_NR_OF_SNAPSHOTS
  final
    returning
      value(R_MAX_NR_OF_SNAPSHOTS) type I .
  methods GET_T_ACTION_ID
    returning
      value(RT_ACTION_ID) type ISH_T_SYSUUID_C .
  methods HAS_ACTION_SNAPSHOT
    importing
      !I_ACTION_ID type SYSUUID_C
    returning
      value(R_HAS_SNAPSHOT) type ABAP_BOOL .
  methods SET_MAX_NR_OF_SNAPSHOTS
    importing
      !I_MAX_NR_OF_SNAPSHOTS type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods SNAPSHOT_ACTION
    importing
      !I_ACTION_TEXT type N1STRING
      !IR_CONTENTS type ref to CL_ISH_NAMED_CONTENT_LIST optional
    returning
      value(R_ACTION_ID) type SYSUUID_C
    raising
      CX_ISH_STATIC_HANDLER .
  methods UNDO_ACTION
    importing
      !I_ACTION_ID type SYSUUID_C
    returning
      value(RS_ACTSNAP) type RN1_ACTION_SNAPSHOT
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_ACTSNAPHANDLER
*"* do not include other source files here!!!

  methods _CHECK_DESTROYED
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DESTROY .
private section.
*"* private components of class CL_ISH_ACTSNAPHANDLER
*"* do not include other source files here!!!

  data GR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE .
  data GR_SNAPSHOTABLE type ref to IF_ISH_SNAPSHOTABLE .
  data GT_ACTSNAP type ISH_T_ACTION_SNAPSHOT_HASH .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .
  data G_MAX_NR_OF_SNAPSHOTS type I value 5. "#EC NOTEXT .
ENDCLASS.



CLASS CL_ISH_ACTSNAPHANDLER IMPLEMENTATION.


METHOD clear_action_snapshot.

  _check_destroyed( ).

* Get the actsnap entry.
  READ TABLE gt_actsnap
    WITH TABLE KEY action_id = i_action_id
    INTO rs_actsnap.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CLEAR_ACTION_SNAPSHOT'
        i_mv3        = 'CL_ISH_ACTSNAPHANDLER' ).
  ENDIF.

* Clear the snapshot.
  gr_snapshotable->clear_snapshot( rs_actsnap-snapkey ).

* Remove the actsnap entry.
  DELETE TABLE gt_actsnap WITH TABLE KEY action_id = i_action_id.
  RAISE EVENT ev_actsnap_removed
    EXPORTING
      e_action_id = i_action_id.

ENDMETHOD.


METHOD constructor.

  IF ir_snapshotable IS NOT BOUND OR
     i_max_nr_of_snapshots < 1.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_ACTSNAPHANDLER' ).
  ENDIF.

  gr_snapshotable       = ir_snapshotable.
  g_max_nr_of_snapshots = i_max_nr_of_snapshots.
  gr_cb_destroyable     = ir_cb_destroyable.

ENDMETHOD.


METHOD get_action_content.

  FIELD-SYMBOLS <ls_actsnap>            TYPE rn1_action_snapshot.

  _check_destroyed( ).

  READ TABLE gt_actsnap
    WITH TABLE KEY action_id = i_action_id
    ASSIGNING <ls_actsnap>.
  IF sy-subrc <> 0 OR
     <ls_actsnap>-r_contents IS NOT BOUND.
    e_not_found = abap_true.
    RETURN.
  ENDIF.

  CALL METHOD <ls_actsnap>-r_contents->get_content
    EXPORTING
      i_name      = i_name
    IMPORTING
      e_not_found = e_not_found
    CHANGING
      c_content   = c_content.

ENDMETHOD.


METHOD get_action_text_by_id.

  FIELD-SYMBOLS <ls_actsnap>            TYPE rn1_action_snapshot.

  READ TABLE gt_actsnap
    WITH TABLE KEY action_id = i_action_id
    ASSIGNING <ls_actsnap>.

  CHECK sy-subrc = 0.

  r_action_text = <ls_actsnap>-action_text.

ENDMETHOD.


METHOD get_max_nr_of_snapshots.

  r_max_nr_of_snapshots = g_max_nr_of_snapshots.

ENDMETHOD.


METHOD get_t_action_id.

  FIELD-SYMBOLS <ls_actsnap>            TYPE rn1_action_snapshot.

  LOOP AT gt_actsnap ASSIGNING <ls_actsnap>.
    INSERT <ls_actsnap>-action_id INTO rt_action_id INDEX 1.
  ENDLOOP.

ENDMETHOD.


METHOD has_action_snapshot.

  READ TABLE gt_actsnap
    WITH TABLE KEY action_id = i_action_id
    TRANSPORTING NO FIELDS.

  CHECK sy-subrc = 0.

  r_has_snapshot = abap_true.

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
  IF gr_cb_destroyable IS BOUND.
    CHECK gr_cb_destroyable->cb_destroy( me ) = abap_false.
  ENDIF.

* We are in destroy mode.
  g_destroy_mode = abap_true.

* Raise event ev_before_destroy.
  RAISE EVENT ev_before_destroy.

* Internal processing.
  _destroy( ).

* Destroy attributes.
  CLEAR gr_snapshotable.
  CLEAR gt_actsnap.

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


METHOD set_max_nr_of_snapshots.

  FIELD-SYMBOLS <ls_actsnap>            TYPE rn1_action_snapshot.

  _check_destroyed( ).

* The max_nr_of_snapshots has to be greater than 0.
  IF i_max_nr_of_snapshots < 1.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_MAX_NR_OF_SNAPSHOTS'
        i_mv3        = 'CL_ISH_ACTSNAPHANDLER' ).
  ENDIF.

* Clear and remove action snapshots if needed.
  WHILE lines( gt_actsnap ) > i_max_nr_of_snapshots.
    LOOP AT gt_actsnap ASSIGNING <ls_actsnap>.
      clear_action_snapshot( <ls_actsnap>-action_id ).
      EXIT.
    ENDLOOP.
  ENDWHILE.

* Set g_max_nr_of_snapshots.
  g_max_nr_of_snapshots = i_max_nr_of_snapshots.

ENDMETHOD.


METHOD snapshot_action.

  DATA ls_actsnap                 TYPE rn1_action_snapshot.

  FIELD-SYMBOLS <ls_actsnap>      TYPE rn1_action_snapshot.

  _check_destroyed( ).

* The action_text has to be specified.
  IF i_action_text IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SNAPSHOT_ACTION'
        i_mv3        = 'CL_ISH_ACTSNAPHANDLER' ).
  ENDIF.

* Snapshot the action.
  ls_actsnap-action_id    = cl_ish_utl_base=>generate_uuid( ).
  ls_actsnap-action_text  = i_action_text.
  ls_actsnap-snapkey      = gr_snapshotable->snapshot( ).
  ls_actsnap-r_contents   = ir_contents.
  INSERT ls_actsnap INTO TABLE gt_actsnap.
  RAISE EVENT ev_actsnap_added
    EXPORTING
      e_action_id = ls_actsnap-action_id.

* Clear the first action snapshot if needed.
  DO 1 TIMES.
    CHECK lines( gt_actsnap ) > g_max_nr_of_snapshots.
    LOOP AT gt_actsnap ASSIGNING <ls_actsnap>.
      EXIT.
    ENDLOOP.
    CHECK <ls_actsnap> IS ASSIGNED.
    gr_snapshotable->clear_snapshot( <ls_actsnap>-snapkey ).
    DELETE TABLE gt_actsnap WITH TABLE KEY action_id = <ls_actsnap>-snapkey.
    RAISE EVENT ev_actsnap_removed
      EXPORTING
        e_action_id = <ls_actsnap>-action_id.
  ENDDO.

* Export.
  r_action_id = ls_actsnap-action_id.

ENDMETHOD.


METHOD undo_action.

  DATA l_remove                         TYPE abap_bool.
  DATA l_action_id                      TYPE sysuuid_c.

  FIELD-SYMBOLS <ls_actsnap>            TYPE rn1_action_snapshot.

  _check_destroyed( ).

* Get the actsnap entry.
  READ TABLE gt_actsnap
    WITH TABLE KEY action_id = i_action_id
    into rs_actsnap.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'UNDO_ACTION'
        i_mv3        = 'CL_ISH_ACTSNAPHANDLER' ).
  ENDIF.

* Undo the snapshot.
  gr_snapshotable->undo( rs_actsnap-snapkey ).

* Remove the actsnap entries.
  LOOP AT gt_actsnap ASSIGNING <ls_actsnap>.
    IF <ls_actsnap>-action_id = i_action_id.
      l_remove = abap_true.
    ENDIF.
    CHECK l_remove = abap_true.
    l_action_id = <ls_actsnap>-action_id.
    DELETE TABLE gt_actsnap WITH TABLE KEY action_id = l_action_id.
    RAISE EVENT ev_actsnap_removed
      EXPORTING
        e_action_id = l_action_id.
  ENDLOOP.

ENDMETHOD.


METHOD _check_destroyed.

  IF is_destroyed( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_DESTROYED'
        i_mv3        = 'CL_ISH_ACTSNAPHANDLER' ).
  ENDIF.

ENDMETHOD.


method _DESTROY.
endmethod.
ENDCLASS.
