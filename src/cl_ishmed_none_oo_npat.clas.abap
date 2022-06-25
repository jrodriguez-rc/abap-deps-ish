class CL_ISHMED_NONE_OO_NPAT definition
  public
  final
  create protected .

public section.
*"* public components of class CL_ISHMED_NONE_OO_NPAT
*"* do not include other source files here!!!

  interfaces IF_ISHMED_NONE_OO_DATA .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_GET_INSTITUTION .
  interfaces IF_ISH_GET_PATIENT .
  interfaces IF_ISH_IDENTIFY_OBJECT .
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
  aliases BUILD_LINE_KEY
    for IF_ISHMED_NONE_OO_DATA~BUILD_LINE_KEY .
  aliases GET_DATA_FIELD
    for IF_ISHMED_NONE_OO_DATA~GET_DATA_FIELD .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases INITIALIZE
    for IF_ISHMED_NONE_OO_DATA~INITIALIZE .
  aliases IS_INHERITED_FROM
    for IF_ISHMED_NONE_OO_DATA~IS_INHERITED_FROM .
  aliases REFRESH
    for IF_ISHMED_NONE_OO_DATA~REFRESH .
  aliases SNAPSHOT
    for IF_ISH_SNAPSHOT_OBJECT~SNAPSHOT .
  aliases UNDO
    for IF_ISH_SNAPSHOT_OBJECT~UNDO .

  constants CO_OTYPE_NONE_OO_NPAT type ISH_OBJECT_TYPE value 503. "#EC NOTEXT
  data G_NPAT type NPAT .

  methods GET_DATA
    exporting
      value(E_RC) type I
      value(E_NPAT) type NPAT
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHANGE
    importing
      value(I_NPAT) type NPAT .
  class-methods LOAD
    importing
      value(I_MANDT) type MANDT default SY-MANDT
      value(I_EINRI) type EINRI optional
      value(I_PATNR) type PATNR optional
      value(I_NPAT) type NPAT optional
      value(I_READ_DB) type ISH_ON_OFF default ON
    exporting
      value(E_INSTANCE) type ref to CL_ISHMED_NONE_OO_NPAT
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONSTRUCTOR
    importing
      value(I_MANDT) type MANDT optional
      value(I_EINRI) type EINRI optional
      value(I_PATNR) type PATNR optional
      value(I_NPAT) type NPAT optional
      value(I_READ_DB) type ISH_ON_OFF default ON
    exceptions
      INSTANCE_NOT_POSSIBLE
      RECORD_NOT_FOUND .
protected section.
*"* protected components of class CL_ISHMED_NONE_OO_NPAT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISHMED_NONE_OO_NPAT
*"* do not include other source files here!!!

  data GT_SNAPSHOT type ISHMED_T_NONE_OO_NPAT_SNAPSHOT .
ENDCLASS.



CLASS CL_ISHMED_NONE_OO_NPAT IMPLEMENTATION.


METHOD change .

  g_npat = i_npat.

ENDMETHOD.


METHOD constructor .

  DATA: l_npat     TYPE npat,
        l_rc       TYPE ish_method_rc.

* Alle globalen Datenstrukturen initialisieren
  CALL METHOD me->initialize.

  IF i_read_db = on.
*   Patient einlesen
    CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
      EXPORTING
        i_patnr     = i_patnr
        i_read_db   = on
        i_no_buffer = off
      IMPORTING
        es_npat     = l_npat
        e_rc        = l_rc.
    IF l_rc = 0.
      g_npat = l_npat.
    ELSE.
      RAISE record_not_found.
    ENDIF.
  ELSE.
    g_npat = i_npat.
  ENDIF.

ENDMETHOD.


METHOD get_data .

  e_rc = 0.
  CLEAR: e_npat.

* Errorhandler ist nicht obligatorisch
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  e_npat     = g_npat.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~build_line_key .

  CLEAR e_line_key.

  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = g_npat
      i_datatype = 'NPAT'
    IMPORTING
      e_line_key = e_line_key.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~get_data_field .

  DATA: l_rc     TYPE ish_method_rc,
        l_npat   TYPE npat.
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
      e_npat         = l_npat
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* Feld nun suchen
  ASSIGN COMPONENT i_fieldname OF STRUCTURE l_npat
                   TO <lfs_field>.
  IF sy-subrc <> 0.
    e_fld_not_found = 'X'.
    EXIT.
  ENDIF.

  e_field = <lfs_field>.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~initialize .

  CLEAR g_npat.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~refresh .

  DATA: l_npat   TYPE npat,
        l_rc     TYPE ish_method_rc.

  e_rc = 0.

  CHECK NOT g_npat IS INITIAL.

  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
    EXPORTING
      i_patnr     = g_npat-patnr
      i_read_db   = on
      i_no_buffer = off
    IMPORTING
      es_npat     = l_npat
      e_rc        = l_rc.

  IF l_rc = 0.
    g_npat = l_npat.
  ENDIF.

ENDMETHOD.


METHOD if_ish_get_institution~get_institution.

  r_einri = g_npat-einri.

ENDMETHOD.


METHOD if_ish_get_patient~get_patient.

  e_patnr = g_npat-patnr.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .
  e_object_type = co_otype_none_oo_npat.
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

  IF i_object_type = co_otype_none_oo_npat.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_snapshot_object~destroy_snapshot.
* new since ID 19361 Implement if you needed
ENDMETHOD.


METHOD if_ish_snapshot_object~snapshot .

  DATA: l_wa_snapshot TYPE rn1_none_oo_npat_snapshot.

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
  l_wa_snapshot-npat = g_npat.
* Den aktuellen Eintrag immer an erster Stelle einfügen
  INSERT l_wa_snapshot INTO gt_snapshot INDEX 1.

* Fichte, Nr 8597, 93: Es wird nur eine bestimmte Anzahl von
* Snapshot-Einträgen zugelassen, um nicht zuviel unnötigen
* Speicher zu verbrauchen
  DELETE gt_snapshot FROM co_max_snapshots.

  e_key = l_wa_snapshot-key.

ENDMETHOD.


METHOD if_ish_snapshot_object~undo .

  DATA: l_wa_snapshot TYPE rn1_none_oo_npat_snapshot.

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

  g_npat               = l_wa_snapshot-npat.

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

  CREATE OBJECT e_instance
    EXPORTING
      i_mandt               = i_mandt
      i_einri               = i_einri
      i_patnr               = i_patnr
      i_npat                = i_npat
      i_read_db             = i_read_db
    EXCEPTIONS
      instance_not_possible = 1
      record_not_found      = 2
      OTHERS                = 3.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

  CASE l_rc.
    WHEN 0.
*     OK
    WHEN OTHERS.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1'
          i_num  = '014'
          i_mv1  = i_patnr
          i_last = space.
  ENDCASE.

ENDMETHOD.
ENDCLASS.
