class CL_ISH_SNAPSHOTHANDLER definition
  public
  create public .

*"* public components of class CL_ISH_SNAPSHOTHANDLER
*"* do not include other source files here!!!
public section.

  class-methods GET_SINGLETON
    returning
      value(RR_SNAPSHOTHANDLER) type ref to CL_ISH_SNAPSHOTHANDLER .
  methods CONSTRUCTOR
    importing
      !I_MAX_SNAPSHOTS type I default 100 .
  methods DESTROY
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SNAPSHOT
    importing
      !IR_CALLBACK type ref to IF_ISH_SNAPSHOT_CALLBACK
    exporting
      !E_SNAPKEY type ISH_SNAPKEY
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods UNDO
    importing
      !IR_CALLBACK type ref to IF_ISH_SNAPSHOT_CALLBACK
      !I_SNAPKEY type ISH_SNAPKEY
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_SNAPSHOTHANDLER
*"* do not include other source files here!!!

  class-data GR_SINGLETON type ref to CL_ISH_SNAPSHOTHANDLER .
  data G_MAX_SNAPSHOTS type I value 100 .
  data G_NEXT_SNAPKEY type ISH_SNAPKEY value 1 .
  data GT_SNAPSHOT type ISH_T_SNAPSHOT .

  methods GET_NEXT_SNAPKEY
    returning
      value(R_SNAPKEY) type ISH_SNAPKEY .
private section.
*"* private components of class CL_ISH_SNAPSHOTHANDLER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SNAPSHOTHANDLER IMPLEMENTATION.


METHOD constructor.

  IF i_max_snapshots > 0.
    g_max_snapshots = i_max_snapshots.
  ENDIF.

ENDMETHOD.


METHOD destroy.

* Initializations.
  e_rc = 0.

  CLEAR: gt_snapshot,
         g_max_snapshots,
         g_next_snapkey.

ENDMETHOD.


METHOD get_next_snapkey.

  r_snapkey = g_next_snapkey.

  g_next_snapkey = g_next_snapkey + 1.

ENDMETHOD.


METHOD get_singleton.

  IF gr_singleton IS INITIAL.
    CREATE OBJECT gr_singleton.
  ENDIF.

  rr_snapshothandler = gr_singleton.

ENDMETHOD.


METHOD snapshot.

  DATA: lr_snapobj  TYPE REF TO cl_ish_snapshot,
        ls_snapshot TYPE ish_snapshot.

* Initializations.
  e_rc = 0.
  CLEAR e_snapkey.

* Initial checking.
  CHECK ir_callback IS BOUND.

* Get the snapshot object.
  CALL METHOD ir_callback->create_snapshot_object
    IMPORTING
      er_snapobj      = lr_snapobj
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK lr_snapobj IS BOUND.

* Build the snapshot entry.
  CLEAR ls_snapshot.
  ls_snapshot-key    = get_next_snapkey( ).
  ls_snapshot-object = lr_snapobj.

* Append the snapshot entry.
  APPEND ls_snapshot TO gt_snapshot.

* Remove old snapshot entries.
  DELETE gt_snapshot FROM g_max_snapshots.

* Export.
  e_snapkey = ls_snapshot-key.

ENDMETHOD.


METHOD undo.

  FIELD-SYMBOLS: <ls_snapshot>  TYPE ish_snapshot.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK ir_callback   IS BOUND.
  CHECK NOT i_snapkey IS INITIAL.

* Get the corresponding snapshot entry.
  READ TABLE gt_snapshot
    ASSIGNING <ls_snapshot>
    WITH KEY key = i_snapkey.
  CHECK sy-subrc = 0.
  CHECK <ls_snapshot>-object IS BOUND.

* Undo.
  CALL METHOD ir_callback->undo_snapshot_object
    EXPORTING
      ir_snapobj      = <ls_snapshot>-object
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Remove the snapshot entry.
  DELETE gt_snapshot WHERE key = i_snapkey.

ENDMETHOD.
ENDCLASS.
