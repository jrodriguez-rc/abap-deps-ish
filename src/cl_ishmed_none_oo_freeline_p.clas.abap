class CL_ISHMED_NONE_OO_FREELINE_P definition
  public
  final
  create public .

*"* public components of class CL_ISHMED_NONE_OO_FREELINE_P
*"* do not include other source files here!!!
public section.

  interfaces IF_ISHMED_NONE_OO_DATA .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_SNAPSHOT_OBJECT .

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
  aliases REFRESH
    for IF_ISHMED_NONE_OO_DATA~REFRESH .
  aliases SNAPSHOT
    for IF_ISH_SNAPSHOT_OBJECT~SNAPSHOT .
  aliases UNDO
    for IF_ISH_SNAPSHOT_OBJECT~UNDO .

  constants CO_OTYPE_NONE_OO_FREELINE_PLAN type ISH_OBJECT_TYPE value 501. "#EC NOTEXT

  methods GET_DATA
    exporting
      value(E_RC) type I
      value(E_PLAN_DATA) type RN1FREELINE_PLAN
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHANGE
    importing
      value(I_PLAN_DATA) type RN1FREELINE_PLAN .
  class-methods LOAD
    importing
      value(I_MANDT) type MANDT default SY-MANDT
      value(I_PLAN_DATA) type RN1FREELINE_PLAN
    exporting
      value(E_INSTANCE) type ref to CL_ISHMED_NONE_OO_FREELINE_P
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONSTRUCTOR
    importing
      value(I_MANDT) type MANDT
      value(I_PLAN_DATA) type RN1FREELINE_PLAN
    exceptions
      INSTANCE_NOT_POSSIBLE .
protected section.
*"* protected components of class CL_ISHMED_NONE_OO_FREELINE_P
*"* do not include other source files here!!!

  data G_PLAN_DATA type RN1FREELINE_PLAN .
private section.
*"* private components of class CL_ISHMED_NONE_OO_FREELINE_P
*"* do not include other source files here!!!

  class-data G_CONSTRUCT type ISH_ON_OFF .
ENDCLASS.



CLASS CL_ISHMED_NONE_OO_FREELINE_P IMPLEMENTATION.


METHOD change .

  g_plan_data = i_plan_data.

ENDMETHOD.


METHOD constructor .

* Die Instanz nur anlegen, wenn der Constructor aus der Methode
* CREATE aufgerufen wird. Direkte Aufrufe des Constructors dürfen
* nicht möglich sein
  IF g_construct <> 'X'.
    RAISE instance_not_possible.
  ENDIF.

* Alle globalen Datenstrukturen initialisieren
  CALL METHOD me->initialize.

  g_plan_data = i_plan_data.

ENDMETHOD.


METHOD get_data .

  e_rc = 0.
  CLEAR: e_plan_data.

* Errorhandler ist nicht obligatorisch
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  e_plan_data = g_plan_data.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~build_line_key .

  CLEAR e_line_key.

  e_line_key = 'EMP'.
  IF NOT g_plan_data-pobnr IS INITIAL.
    e_line_key+3  = g_plan_data-pobnr.
    e_line_key+13 = g_plan_data-orgid.
  ELSE.
    e_line_key+3  = g_plan_data-date.
  ENDIF.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~get_data_field .

  DATA: l_rc          TYPE ish_method_rc,
        l_plan_data   TYPE rn1freeline_plan.
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
      e_plan_data    = l_plan_data
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* Feld nun suchen
  ASSIGN COMPONENT i_fieldname OF STRUCTURE l_plan_data
                   TO <lfs_field>.
  IF sy-subrc <> 0.
    e_fld_not_found = 'X'.
    EXIT.
  ENDIF.

  e_field = <lfs_field>.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~initialize .

  CLEAR: g_plan_data.

ENDMETHOD.


METHOD if_ishmed_none_oo_data~refresh .

  DATA: l_nbew   TYPE nbew.

  e_rc = 0.

* Daten können nicht aktualisiert werden, da dies hier
* nur gemerkte Planungsdaten sind, die nicht seperat auf
* der DB gesichert sind

  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .
  e_object_type = co_otype_none_oo_freeline_plan.
ENDMETHOD.


METHOD if_ish_identify_object~is_a .

  DATA: l_object_type  TYPE i.

  CALL METHOD me->get_type
    IMPORTING
      e_object_type = l_object_type.

  IF l_object_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_none_oo_freeline_plan.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_snapshot_object~destroy_snapshot.
* new since ID 19361 Implement if you needed
ENDMETHOD.


METHOD if_ish_snapshot_object~snapshot .

* not implemented yet

ENDMETHOD.


METHOD if_ish_snapshot_object~undo .

* not implemented yet

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
      i_plan_data           = i_plan_data
    EXCEPTIONS
      instance_not_possible = 1
      OTHERS                = 2.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

  g_construct = ' '.

ENDMETHOD.
ENDCLASS.
