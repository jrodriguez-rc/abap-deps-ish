class CL_ISH_DATA_OBJECT definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_DATA_OBJECT
*"* do not include other source files here!!!

  interfaces IF_ISH_DATA_OBJECT
      abstract methods CHECK_CHANGES
                       GET_KEY_STRING
                       IS_CANCELLED .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_OBJECT_TYPES .
  interfaces IF_ISH_SNAPSHOT_OBJECT .

  aliases CO_BUFFER_CLEAR
    for IF_ISH_DATA_OBJECT~CO_BUFFER_CLEAR .
  aliases CO_BUFFER_REFRESH
    for IF_ISH_DATA_OBJECT~CO_BUFFER_REFRESH .
  aliases CO_BUFFER_USE
    for IF_ISH_DATA_OBJECT~CO_BUFFER_USE .
  aliases CO_MAX_SNAPSHOTS
    for IF_ISH_DATA_OBJECT~CO_MAX_SNAPSHOTS .
  aliases CO_MODE_DELETE
    for IF_ISH_DATA_OBJECT~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_DATA_OBJECT~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_DATA_OBJECT~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_DATA_OBJECT~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_DATA_OBJECT~CO_MODE_UPDATE .
  aliases FALSE
    for IF_ISH_DATA_OBJECT~FALSE .
  aliases OFF
    for IF_ISH_DATA_OBJECT~OFF .
  aliases ON
    for IF_ISH_DATA_OBJECT~ON .
  aliases TRUE
    for IF_ISH_DATA_OBJECT~TRUE .
  aliases DESTROY
    for IF_ISH_DATA_OBJECT~DESTROY .
  aliases GET_CHECKING_DATE
    for IF_ISH_DATA_OBJECT~GET_CHECKING_DATE .
  aliases GET_KEY_STRING
    for IF_ISH_DATA_OBJECT~GET_KEY_STRING .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_ACTIVE
    for IF_ISH_DATA_OBJECT~IS_ACTIVE .
  aliases IS_CANCELLED
    for IF_ISH_DATA_OBJECT~IS_CANCELLED .
  aliases IS_CHANGED
    for IF_ISH_DATA_OBJECT~IS_CHANGED .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases IS_NEW
    for IF_ISH_DATA_OBJECT~IS_NEW .
  aliases REFRESH
    for IF_ISH_DATA_OBJECT~REFRESH .
  aliases SNAPSHOT
    for IF_ISH_SNAPSHOT_OBJECT~SNAPSHOT .
  aliases UNDO
    for IF_ISH_SNAPSHOT_OBJECT~UNDO .
  aliases EV_DESTROYED
    for IF_ISH_DATA_OBJECT~EV_DESTROYED .
  aliases EV_REFRESHED
    for IF_ISH_DATA_OBJECT~EV_REFRESHED .

  constants CO_OTYPE_DATA_OBJECT type ISH_OBJECT_TYPE value 3001. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      value(I_MODE) type ISH_MODUS optional .
  class-methods GET_SNAPSHOT_KEY
    returning
      value(R_SNAPSHOT_KEY) type ISH_SNAPKEY .
  methods BUILD_SNAPSHOT
    exporting
      value(ES_SNAPSHOT) type ISH_SNAPSHOT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DATA_OBJECT
*"* do not include other source files here!!!

  aliases G_ACTIVE
    for IF_ISH_DATA_OBJECT~G_ACTIVE .
  aliases G_MODE
    for IF_ISH_DATA_OBJECT~G_MODE .

  data GT_SNAPSHOTS type ISH_T_SNAPSHOT .

  methods CREATE_SNAPSHOT_OBJECT
  abstract
    exporting
      value(E_SNAPSHOT_OBJECT) type ref to CL_ISH_SNAPSHOT
      value(E_RC) type SY-SUBRC .
  methods UNDO_SNAPSHOT_OBJECT
  abstract
    importing
      value(I_SNAPSHOT_OBJECT) type ref to CL_ISH_SNAPSHOT
    exporting
      value(E_RC) type SY-SUBRC .
  methods SNAPSHOT_CONNECTION
    exporting
      value(E_CONNECTION_KEY) type ISH_SNAPKEY .
  methods UNDO_CONNECTION
    importing
      value(I_CONNECTION_KEY) type ISH_SNAPKEY .
private section.
*"* private components of class CL_ISH_DATA_OBJECT
*"* do not include other source files here!!!

  class-data G_SNAPSHOT_KEY type ISH_SNAPKEY .
ENDCLASS.



CLASS CL_ISH_DATA_OBJECT IMPLEMENTATION.


method BUILD_SNAPSHOT.
  DATA: ls_snapshot TYPE ish_snapshot.

* Initializations.
  e_rc  = 0.
  CLEAR: ls_snapshot,
         es_snapshot.

* Notice the attributes G_MODE and G_ACTIVE.
  ls_snapshot-active = g_active.
  ls_snapshot-mode   = g_mode.

* The field L_WA_SNAPSHOT-CONNECTION_KEY is not used here.
* It is only considered in class CL_ISH_RUN_DATA.
  CALL METHOD snapshot_connection
    IMPORTING
      e_connection_key = ls_snapshot-connection_key.

* By calling method CREATE_SNAPSHOT_OBJECT derived classes can
* instantiate a snapshot object and fill it with their actual data.
* This snapshot object is noticed here.
  CALL METHOD create_snapshot_object
    IMPORTING
      e_snapshot_object = ls_snapshot-object
      e_rc              = e_rc.
  IF e_rc <> 0.
*   An error occured -> no SNAPSHOT.
    EXIT.
  ENDIF.

* Leave the KEY empty. Either it is not necessary or it is built
* somewhere else

* Now pass back the ready snapshot
  es_snapshot = ls_snapshot.
endmethod.


METHOD constructor .

  g_mode = i_mode.

ENDMETHOD.


METHOD get_snapshot_key .

  g_snapshot_key = g_snapshot_key + 1.
  r_snapshot_key = g_snapshot_key.

ENDMETHOD.


METHOD if_ish_data_object~destroy .

* Raise event ev_destroyed.
  RAISE EVENT ev_destroyed.

ENDMETHOD.


METHOD if_ish_data_object~get_cdoc_object.

  DATA: ls_tcdob   TYPE tcdob,
        l_key      TYPE string.

* Initializations.
  CLEAR: e_objectclas, e_objectid, ls_tcdob, l_key.

* If the tabname is specified.
  IF NOT i_tabname IS INITIAL.
*   Get CDOC objectclas for tabname.
    SELECT * FROM tcdob INTO ls_tcdob UP TO 1 ROWS
           WHERE tabname = i_tabname.                       "#EC *
      EXIT.
    ENDSELECT.
    IF sy-subrc = 0.
*     Return CDOC objectclas.
      e_objectclas = ls_tcdob-object.
    ENDIF.
  ENDIF.

* Return CDOC objectid for current object (Default implementation).

* In most cases the CDOC objectid is the object key without MANDT.
* First read the object key-string with MANDT. This is necessary for
* those implementations of get_key_string already handling parm
* i_with_mandt. In most implementations the parm is not handled and the
* key returned with MANDT.

* For different implementations the method has to be redefined.
  CALL METHOD get_key_string
    EXPORTING
      i_with_mandt = 'X'
    IMPORTING
      e_key        = l_key.

* Return CDOC objectid without MANDT.
  e_objectid = l_key+3.

ENDMETHOD.


METHOD if_ish_data_object~get_checking_date.                "#EC NEEDED

* Redefine in subclasses if necessary

ENDMETHOD.


METHOD if_ish_data_object~is_active .

  e_active = g_active.

ENDMETHOD.


METHOD if_ish_data_object~is_changed .

  DATA: l_mode  TYPE ish_modus.

* Initializations
  r_is_changed = on.

* Check changes
  CALL METHOD if_ish_data_object~check_changes
    IMPORTING
      e_mode = l_mode.

* Export r_is_changed
  IF l_mode = co_mode_unchanged.
    r_is_changed = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_data_object~is_new .

  e_new = off.
  IF g_mode = co_mode_insert.
    e_new = on.
  ENDIF.

ENDMETHOD.


METHOD if_ish_data_object~refresh .

* Raise event ev_refreshed.
  RAISE EVENT ev_refreshed.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .
  e_object_type = co_otype_data_object.
ENDMETHOD.


METHOD if_ish_identify_object~is_a .

  DATA: l_object_type TYPE i.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.
  IF l_object_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_data_object.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_snapshot_object~destroy_snapshot.
* new since ID 19361
  DATA: l_wa_snapshot TYPE ish_snapshot.

* Initializations.
  e_rc = 0.
  CLEAR l_wa_snapshot.

* Determine the snapshot entry.
  READ TABLE gt_snapshots INTO l_wa_snapshot WITH KEY key = i_key.
  IF sy-subrc <> 0.
*   An error occured -> no destroy.
    e_rc = 1.
    EXIT.
  ENDIF.

*Sta/PN/MED-40483
* check if snapshot object is available
* because it could be initial when using
* callback object for snapshot
  IF l_wa_snapshot-object IS BOUND.
*End/PN/MED-40483
*   destroy intanz of snapshot
    CALL METHOD l_wa_snapshot-object->destroy.
  ENDIF. "PN/MED-40483

* This snapshot can now be deleted.
  DELETE gt_snapshots WHERE key = i_key.

ENDMETHOD.


METHOD if_ish_snapshot_object~snapshot .

  DATA: l_wa_snapshot TYPE ish_snapshot.

* Initializations.
  e_rc  = 0.
  e_key = 0.
  CLEAR l_wa_snapshot.

* Call the method to create the snapshot (without it's key)
  CALL METHOD build_snapshot
   IMPORTING
     es_snapshot     = l_wa_snapshot
     e_rc            = e_rc.
  IF e_rc <> 0.
*   An error occurred -> no SNAPSHOT.
    EXIT.
  ENDIF.

* Every snapshot gets a unique key.
  l_wa_snapshot-key = get_snapshot_key( ).

* Insert the actual snapshot entry at first position.
  INSERT l_wa_snapshot INTO gt_snapshots INDEX 1.

* The constant CO_MAX_SNAPSHOTS specifies the maximum count
* of snapshots.
* If more than CO_MAX_SNAPSHOTS entries are in GT_SNAPSHOT,
* delete the oldest entries.
  DELETE gt_snapshots FROM co_max_snapshots.

  e_key = l_wa_snapshot-key.

ENDMETHOD.


METHOD if_ish_snapshot_object~undo .

  DATA: l_wa_snapshot TYPE ish_snapshot.

* Initializations.
  e_rc = 0.
  CLEAR l_wa_snapshot.

* Determine the snapshot entry.
  READ TABLE gt_snapshots INTO l_wa_snapshot WITH KEY key = i_key.
  IF sy-subrc <> 0.
*   An error occured -> no UNDO.
    e_rc = 1.
    EXIT.
  ENDIF.

* Undo the attributes G_ACTIVE and G_MODE.
  g_active = l_wa_snapshot-active.
  g_mode   = l_wa_snapshot-mode.

* Allow derived classes to undo their data.
  CALL METHOD undo_snapshot_object
    EXPORTING
      i_snapshot_object = l_wa_snapshot-object
    IMPORTING
      e_rc              = e_rc.
  IF e_rc <> 0.
*   An error occured -> no UNDO.
    EXIT.
  ENDIF.

* The field L_WA_SNAPSHOT-CONNECTION_KEY is not used here.
* It is only considered in class CL_ISH_RUN_DATA.
  CALL METHOD undo_connection
    EXPORTING
      i_connection_key = l_wa_snapshot-connection_key.

* This snapshot can now be deleted.
  DELETE gt_snapshots WHERE key = i_key.

ENDMETHOD.


METHOD snapshot_connection .

* Default: No snapshot key for connections.
  CLEAR e_connection_key.

ENDMETHOD.


METHOD undo_connection .                                    "#EC NEEDED

* Default: No undo handling for connections.

ENDMETHOD.
ENDCLASS.
