class CL_ISHMED_NONE_OO_N2VDNOTE definition
  public
  final
  create public .

*"* public components of class CL_ISHMED_NONE_OO_N2VDNOTE
*"* do not include other source files here!!!
public section.

  interfaces IF_ISHMED_NONE_OO_DATA .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_DATA_OBJECT .
  interfaces IF_ISH_GET_INSTITUTION .
  interfaces IF_ISH_GET_PATIENT .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_OBJECTBASE .
  interfaces IF_ISH_SNAPSHOT_OBJECT .

  aliases CO_MAX_SNAPSHOTS
    for IF_ISHMED_NONE_OO_DATA~CO_MAX_SNAPSHOTS .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases ADD_CONNECTION
    for IF_ISH_OBJECTBASE~ADD_CONNECTION .
  aliases BUILD_LINE_KEY
    for IF_ISHMED_NONE_OO_DATA~BUILD_LINE_KEY .
  aliases CHECK
    for IF_ISH_OBJECTBASE~CHECK .
  aliases CLEAR_LOCK
    for IF_ISH_OBJECTBASE~CLEAR_LOCK .
  aliases CONNECT
    for IF_ISH_OBJECTBASE~CONNECT .
  aliases DISCONNECT
    for IF_ISH_OBJECTBASE~DISCONNECT .
  aliases GET_CONNECTIONS
    for IF_ISH_OBJECTBASE~GET_CONNECTIONS .
  aliases GET_DATA_FIELD
    for IF_ISHMED_NONE_OO_DATA~GET_DATA_FIELD .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases INITIALIZE
    for IF_ISHMED_NONE_OO_DATA~INITIALIZE .
  aliases IS_A
    for IF_ISHMED_NONE_OO_DATA~IS_A .
  aliases IS_ACTIVE
    for IF_ISH_DATA_OBJECT~IS_ACTIVE .
  aliases IS_ACTUAL
    for IF_ISH_OBJECTBASE~IS_ACTUAL .
  aliases IS_CANCELLED
    for IF_ISH_DATA_OBJECT~IS_CANCELLED .
  aliases IS_CHANGED
    for IF_ISH_DATA_OBJECT~IS_CHANGED .
  aliases IS_COMPLETE
    for IF_ISH_OBJECTBASE~IS_COMPLETE .
  aliases IS_HIDDEN
    for IF_ISH_OBJECTBASE~IS_HIDDEN .
  aliases IS_INHERITED_FROM
    for IF_ISHMED_NONE_OO_DATA~IS_INHERITED_FROM .
  aliases IS_NEW
    for IF_ISH_DATA_OBJECT~IS_NEW .
  aliases REFRESH
    for IF_ISHMED_NONE_OO_DATA~REFRESH .
  aliases REMOVE_CONNECTION
    for IF_ISH_OBJECTBASE~REMOVE_CONNECTION .
  aliases SAVE
    for IF_ISH_OBJECTBASE~SAVE .
  aliases SNAPSHOT
    for IF_ISH_SNAPSHOT_OBJECT~SNAPSHOT .
  aliases UNDO
    for IF_ISH_SNAPSHOT_OBJECT~UNDO .

  constants CO_OTYPE_NONE_OO_N2VDNOTE type ISH_OBJECT_TYPE value 505. "#EC NOTEXT
  constants CO_OTYPE_PROGRESS_DOCUMENT type ISH_OBJECT_TYPE value 121. "#EC NOTEXT
  constants CO_OTYPE_PROGRESS_ENTRY type ISH_OBJECT_TYPE value 122. "#EC NOTEXT
  data G_N2VDNOTE type N2VDNOTE .

  methods GET_DATA
    exporting
      value(E_RC) type I
      value(E_N2VDNOTE) type N2VDNOTE
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHANGE
    importing
      value(I_N2VDNOTE) type N2VDNOTE .
  class-methods LOAD
    importing
      value(I_MANDT) type MANDT default SY-MANDT
      value(I_NOTEKEY) type N2VDNOTE-NOTEKEY optional
      value(I_N2VDNOTE) type N2VDNOTE optional
      value(I_READ_DB) type ISH_ON_OFF default 'X'
    exporting
      value(E_INSTANCE) type ref to CL_ISHMED_NONE_OO_N2VDNOTE
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONSTRUCTOR
    importing
      value(I_MANDT) type MANDT optional
      value(I_NOTEKEY) type N2VDNOTE-NOTEKEY optional
      value(I_N2VDNOTE) type N2VDNOTE optional
      value(I_READ_DB) type ISH_ON_OFF default 'X'
    exceptions
      INSTANCE_NOT_POSSIBLE
      RECORD_NOT_FOUND .
protected section.
*"* protected components of class CL_ISHMED_NONE_OO_NDOC
*"* do not include other source files here!!!

  aliases G_ACTIVE
    for IF_ISH_DATA_OBJECT~G_ACTIVE .
  aliases G_ENVIRONMENT
    for IF_ISH_OBJECTBASE~G_ENVIRONMENT .
  aliases G_MODE
    for IF_ISH_DATA_OBJECT~G_MODE .
  aliases G_OBJECTBASE
    for IF_ISH_OBJECTBASE~G_OBJECTBASE .
private section.
*"* private components of class CL_ISHMED_NONE_OO_N2VDNOTE
*"* do not include other source files here!!!

  class-data G_CONSTRUCT type ISH_ON_OFF .
  data GT_SNAPSHOT type ISHMED_T_NONE_OO_N2VDNOTE_SNAP .
ENDCLASS.



CLASS CL_ISHMED_NONE_OO_N2VDNOTE IMPLEMENTATION.


METHOD change .

  g_n2vdnote = i_n2vdnote.

ENDMETHOD.


METHOD constructor .

  DATA: ls_n2vdnote     TYPE n2vdnote.

* Die Instanz nur anlegen, wenn der Constructor aus der Methode
* CREATE aufgerufen wird. Direkte Aufrufe des Constructors dürfen
* nicht möglich sein
  IF g_construct <> 'X'.
    RAISE instance_not_possible.
  ENDIF.

* Alle globalen Datenstrukturen initialisieren
  CALL METHOD me->initialize.

  IF i_read_db = on.
*   Verlaufseintrag einlesen
    SELECT SINGLE * FROM n2vdnote INTO ls_n2vdnote
           WHERE  notekey = i_notekey.
    IF sy-subrc = 0.
      g_n2vdnote = ls_n2vdnote.
    ELSE.
      RAISE record_not_found.
    ENDIF.
  ELSE.
    g_n2vdnote = i_n2vdnote.
  ENDIF.

ENDMETHOD.


METHOD get_data .

  e_rc = 0.

  CLEAR: e_n2vdnote.

** Errorhandler ist nicht obligatorisch
*  IF c_errorhandler IS INITIAL.
*    CREATE OBJECT c_errorhandler.
*  ENDIF.

  e_n2vdnote = g_n2vdnote.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~build_line_key .

  CLEAR e_line_key.

  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = g_n2vdnote
      i_datatype = 'N2VDNOTE'
    IMPORTING
      e_line_key = e_line_key.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~get_data_field .

  DATA: l_rc                 TYPE ish_method_rc,
        l_n2vdnote           TYPE n2vdnote.
  FIELD-SYMBOLS: <lfs_field> TYPE ANY.

* Initialisierungen
  e_rc = 0.
  CLEAR e_field.
  e_fld_not_found = 'X'.

  CHECK NOT i_fieldname IS INITIAL.

  e_fld_not_found = ' '.

* Befüllung gewünscht?
  CALL METHOD me->get_data
    IMPORTING
      e_rc           = l_rc
      e_n2vdnote     = l_n2vdnote
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* Feld nun suchen
  ASSIGN COMPONENT i_fieldname OF STRUCTURE l_n2vdnote
                   TO <lfs_field>.
  IF sy-subrc <> 0.
    e_fld_not_found = 'X'.
    EXIT.
  ENDIF.

  e_field = <lfs_field>.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~initialize .

  CLEAR g_n2vdnote.

  g_active = on.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~refresh .

  DATA: l_n2vdnote   TYPE n2vdnote.

  e_rc = 0.

  CHECK NOT g_n2vdnote IS INITIAL.

  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  SELECT SINGLE * FROM n2vdnote INTO l_n2vdnote
         WHERE  notekey = g_n2vdnote-notekey.
  IF sy-subrc = 0.
    g_n2vdnote = l_n2vdnote.
  ELSE.
    e_rc = 1.
  ENDIF.

ENDMETHOD.


METHOD if_ish_data_object~check_changes .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_data_object~destroy .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_data_object~get_cdoc_object .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_data_object~get_checking_date .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_data_object~get_key_string .

  CALL METHOD me->if_ishmed_none_oo_data~build_line_key
    IMPORTING
      e_line_key = e_key.

ENDMETHOD.


METHOD if_ish_data_object~is_active .

  e_active = g_active.

ENDMETHOD.


METHOD if_ish_data_object~is_cancelled .

  IF g_n2vdnote-cancelled = on.
    e_cancelled = on.
  ENDIF.

ENDMETHOD.


METHOD if_ish_data_object~is_changed .

* object is only for transport purpose -> so no changes are possible
  r_is_changed = off.

ENDMETHOD.


METHOD if_ish_data_object~is_new .

  e_new = off.

* this is only a transport object, so no changes can be done
* --> so it will be never new
*  IF g_mode = co_mode_insert.
*    e_new = on.
*  ENDIF.

ENDMETHOD.


METHOD if_ish_data_object~refresh .

  CALL METHOD me->if_ishmed_none_oo_data~refresh
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.

ENDMETHOD.


METHOD if_ish_get_institution~get_institution .

  DATA: l_einri     TYPE einri.

* institution in n2vdnote is initial!
* r_einri = g_n2vdnote-institution.

  CHECK g_n2vdnote-notekey IS NOT INITIAL.
  SELECT institution FROM n2vdnote_context INTO l_einri UP TO 1 ROWS
         WHERE notekey = g_n2vdnote-notekey.
    EXIT.
  ENDSELECT.
  IF sy-subrc = 0 AND l_einri IS NOT INITIAL.
    r_einri = l_einri.
  ENDIF.

ENDMETHOD.


METHOD if_ish_get_patient~get_patient.

  DATA: ls_n2vdnote  TYPE n2vdnote_context,
        ls_nfal      TYPE nfal.

  CHECK g_n2vdnote-notekey IS NOT INITIAL.
  SELECT * FROM n2vdnote_context INTO ls_n2vdnote UP TO 1 ROWS
         WHERE notekey = g_n2vdnote-notekey.
    EXIT.
  ENDSELECT.
  IF sy-subrc = 0 AND ls_n2vdnote-caseid IS NOT INITIAL.
    CALL FUNCTION 'ISH_READ_NFAL'
      EXPORTING
        ss_einri           = ls_n2vdnote-institution
        ss_falnr           = ls_n2vdnote-caseid
      IMPORTING
        ss_nfal            = ls_nfal
      EXCEPTIONS
        not_found          = 1
        not_found_archived = 2
        no_authority       = 3
        OTHERS             = 4.
    IF sy-subrc = 0 AND ls_nfal-patnr IS NOT INITIAL.
      e_patnr = ls_nfal-patnr.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_none_oo_n2vdnote.

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

  IF i_object_type = co_otype_none_oo_n2vdnote.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_objectbase~add_connection .

  CHECK NOT g_objectbase IS INITIAL.

  CALL METHOD g_objectbase->add_connection
    EXPORTING
      i_me                = me
      i_partner           = i_object
      i_partner_x         = i_object_x
      i_attribute         = i_attribute
      i_attribute_x       = i_attribute_x
      i_attrib_apply_to   = i_attrib_apply_to
      i_attrib_apply_to_x = i_attrib_apply_to_x.

ENDMETHOD.


METHOD if_ish_objectbase~check .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_objectbase~clear_lock .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_objectbase~connect .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_objectbase~delete_connection.
*New/PN/17828/2005/07/19

  CHECK NOT g_objectbase IS INITIAL.

  CALL METHOD g_objectbase->delete_connection
    EXPORTING
      i_me      = me
      i_partner = i_object
      i_type    = i_type.

ENDMETHOD.


METHOD if_ish_objectbase~disconnect .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_objectbase~get_authority_check .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_objectbase~get_connections .

* g_objectbase may not have been already set.
  CLEAR et_objects.
  CHECK NOT g_objectbase IS INITIAL.

  CALL METHOD g_objectbase->get_connections
    EXPORTING
      i_me               = me
      i_all_conn_objects = i_all_conn_objects
      i_type             = i_type
      i_inactive_conns   = i_inactive_conns
    IMPORTING
      et_objects         = et_objects.

ENDMETHOD.


METHOD if_ish_objectbase~get_data_field .

  CALL METHOD me->if_ishmed_none_oo_data~get_data_field
    EXPORTING
      i_fill          = i_fill
      i_fieldname     = i_fieldname
    IMPORTING
      e_rc            = e_rc
      e_field         = e_field
      e_fld_not_found = e_fld_not_found
    CHANGING
      c_errorhandler  = c_errorhandler.

ENDMETHOD.


METHOD if_ish_objectbase~get_environment .

  e_environment = g_environment.

ENDMETHOD.


METHOD if_ish_objectbase~get_force_erup_data .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_objectbase~hide .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_objectbase~is_actual .

  e_actual = on.

ENDMETHOD.


METHOD if_ish_objectbase~is_complete .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_objectbase~is_hidden .

  r_hidden = off.

ENDMETHOD.


METHOD if_ish_objectbase~remove_connection .

  CHECK NOT g_objectbase IS INITIAL.

  CALL METHOD g_objectbase->remove_connection
    EXPORTING
      i_me      = me
      i_partner = i_object
      i_type    = i_type.

ENDMETHOD.


METHOD if_ish_objectbase~save .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_objectbase~set_authority_check .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_objectbase~set_force_erup_data .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_objectbase~set_lock .

* not implemented
* (object is only used for transport purpose of N2VDNOTE-record)

ENDMETHOD.


METHOD if_ish_snapshot_object~destroy_snapshot.
* new since ID 19361 Implement if you needed
ENDMETHOD.


METHOD if_ish_snapshot_object~snapshot .

  DATA: l_wa_snapshot TYPE rn1_none_oo_n2vdnote_snapshot.

* Hier einen Schnappschuss der globalen Klassenattribute
* vornehmen, d.h. sie in eigene Variablen wegsichern
  e_rc = 0.
  CLEAR l_wa_snapshot.

* Jeder Snapshot bekommt einen eindeutigen Schlüssel. Der wird
* in der Central-Klasse ausgefasst
  CALL METHOD cl_ish_objectcentral=>get_snapshot_key
    IMPORTING
      e_key = l_wa_snapshot-key.

* Snapshot nun ziehen, d.h. die wichtigen Attribute der
* Klasse in die Tabelle GT_SNAPSHOT schreiben
  l_wa_snapshot-n2vdnote = g_n2vdnote.
* Den aktuellen Eintrag immer an erster Stelle einfügen
  INSERT l_wa_snapshot INTO gt_snapshot INDEX 1.

* Fichte, Nr 8597, 93: Es wird nur eine bestimmte Anzahl von
* Snapshot-Einträgen zugelassen, um nicht zuviel unnötigen
* Speicher zu verbrauchen
  DELETE gt_snapshot FROM co_max_snapshots.

  e_key = l_wa_snapshot-key.

ENDMETHOD.


METHOD if_ish_snapshot_object~undo .

  DATA: l_wa_snapshot TYPE rn1_none_oo_n2vdnote_snapshot.

  e_rc = 0.

* Snapshot mit dem Key einlesen und wieder in die globalen Attribute
* reinschreiben
  CLEAR l_wa_snapshot.

  READ TABLE gt_snapshot INTO l_wa_snapshot
                         WITH KEY key = i_key.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

  g_n2vdnote = l_wa_snapshot-n2vdnote.

* Dieser Snapshot kann nun gelöscht werden
  DELETE gt_snapshot WHERE key = i_key.

ENDMETHOD.


METHOD load .

  DATA: l_rc     TYPE sy-subrc.

  e_rc = 0.
  CLEAR e_instance.

  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  g_construct = 'X'.

  CREATE OBJECT e_instance
    EXPORTING
      i_mandt               = i_mandt
      i_notekey             = i_notekey
      i_n2vdnote            = i_n2vdnote
      i_read_db             = i_read_db
    EXCEPTIONS
      instance_not_possible = 1
      record_not_found      = 2
      OTHERS                = 3.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

  g_construct = ' '.

  CASE l_rc.
    WHEN 0.
*     OK
    WHEN OTHERS.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '001'
          i_mv1  = 'Verlaufseintrag nicht vorhanden'(001)
          i_mv2  = i_notekey
          i_last = space.
  ENDCASE.

ENDMETHOD.
ENDCLASS.