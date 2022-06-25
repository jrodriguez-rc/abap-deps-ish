class CL_ISH_HISTORY definition
  public
  create public .

public section.
*"* public components of class CL_ISH_HISTORY
*"* do not include other source files here!!!

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_SNAPSHOT_OBJECT .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .
  aliases DESTROY_SNAPSHOT
    for IF_ISH_SNAPSHOT_OBJECT~DESTROY_SNAPSHOT .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases SNAPSHOT
    for IF_ISH_SNAPSHOT_OBJECT~SNAPSHOT .
  aliases UNDO
    for IF_ISH_SNAPSHOT_OBJECT~UNDO .

  constants CO_MAX_SNAPSHOTS type I value 100. "#EC NOTEXT
  constants CO_OTYPE_HISTORY type ISH_OBJECT_TYPE value 12205. "#EC NOTEXT
  constants CO_ATYP_PREDEF type ISH_HIST_ACT_TYPE value 'P'. "#EC NOTEXT
  constants CO_ATYP_SPEC type ISH_HIST_ACT_TYPE value 'S'. "#EC NOTEXT
  constants CO_ACT_AFTER_PAI type ISH_HIST_ACTIVITY value 'AFTER_PAI'. "#EC NOTEXT
  constants CO_ACT_SAVE type ISH_HIST_ACTIVITY value 'IN_SAVE'. "#EC NOTEXT
  constants CO_FIELD_ACTIVE type ISH_FIELDNAME value 'ISH_SNAPSHOT-ACTIVE'. "#EC NOTEXT
  constants CO_FIELD_MODE type ISH_FIELDNAME value 'ISH_SNAPSHOT-MODE'. "#EC NOTEXT

  methods BUILD_ENTRY
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT optional
      !IT_OBJECT type ISH_T_IDENTIFY_OBJECT optional
      value(I_ACTIVITY) type ISH_HIST_ACTIVITY
      value(I_ACT_TYPE) type ISH_HIST_ACT_TYPE optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_SNAPSHOT
    exporting
      value(ES_SNAPSHOT) type ISH_SNAPSHOT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CREATE
    exporting
      !ER_INSTANCE type ref to CL_ISH_HISTORY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DELETE_ENTRIES
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT optional
      value(I_ACTIVITY) type ISH_HIST_ACTIVITY optional
      value(I_TIMESTAMP_FROM) type ISH_HIST_TIMESTAMP optional
      value(I_TIMESTAMP_TO) type ISH_HIST_TIMESTAMP optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DESTROY .
  methods GET_DATA
    exporting
      !ET_HISTORY type ISH_T_HISTORY .
  class-methods GET_SNAPSHOT_KEY
    returning
      value(R_SNAPSHOT_KEY) type ISH_SNAPKEY .
  methods GET_VALUES_OF_FIELD
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      !I_FIELDNAME type ISH_FIELDNAME
      value(I_ACTIVITY) type ISH_HIST_ACTIVITY optional
    exporting
      !ET_FIELDVALUE type ISH_T_HIST_FVALUE
      !ES_LAST_FIELDVALUE type ISH_HIST_FVALUE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HAS_FIELD_CHANGED
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      !I_FIELDNAME type ISH_FIELDNAME
      value(I_ACTIVITY) type ISH_HIST_ACTIVITY optional
    exporting
      value(E_CHANGED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE .
  methods RELEASE_TIMESTAMP .
  methods SET_TIMESTAMP .
protected section.
*"* protected components of class CL_ISH_HISTORY
*"* do not include other source files here!!!

  data GT_HISTORY type ISH_T_HISTORY .
  data G_TIMESTAMP type ISH_HIST_TIMESTAMP .
  data GT_SNAPSHOTS type ISH_T_SNAPSHOT .

  methods CREATE_SNAPSHOT_OBJECT
    exporting
      value(E_SNAPSHOT_OBJECT) type ref to CL_ISH_SNAPSHOT
      value(E_RC) type SY-SUBRC .
  methods UNDO_SNAPSHOT_OBJECT
    importing
      value(I_SNAPSHOT_OBJECT) type ref to CL_ISH_SNAPSHOT
    exporting
      value(E_RC) type SY-SUBRC .
private section.
*"* private components of class CL_ISH_HISTORY
*"* do not include other source files here!!!

  class-data G_SNAPSHOT_KEY type ISH_SNAPKEY .
ENDCLASS.



CLASS CL_ISH_HISTORY IMPLEMENTATION.


method BUILD_ENTRY.

  DATA: lt_object               TYPE ish_t_identify_object,
        lr_object               TYPE REF TO if_ish_identify_object,
        lr_data_object          TYPE REF TO cl_ish_data_object,
        ls_snapshot             TYPE ish_snapshot,
        ls_history              TYPE ish_history,
        l_is_inherited_from     TYPE ish_on_off,
        l_rc                    TYPE ish_method_rc.

* Initialize.
  e_rc = 0.

* Check parameter.
  if i_activity is initial.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '014'
        i_mv1           = 'CL_ISH_HISTORY'
        i_mv2           = 'BUILD_ENTRY'
        i_mv3           = 'I_ACTIVITY'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
    exit.
  endif.

  lt_object = it_object.
  if ir_object is bound.
    append ir_object to lt_object.
  endif.

* No objects given => exit.
  check not lt_object is initial.

* Check type of given objects.
  loop at lt_object into lr_object.
    check lr_object is bound.
    CALL METHOD lr_object->is_inherited_from
      EXPORTING
        i_object_type       = cl_ish_data_object=>co_otype_data_object
      RECEIVING
        r_is_inherited_from = l_is_inherited_from.
    if l_is_inherited_from = off.
*     Object is not a data object => exit.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '132'
          i_mv1           = 'CL_ISH_HISTORY'
          i_mv2           = 'BUILD_ENTRY'
          ir_object       = lr_object
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = 1.
      exit.
    endif.
  endloop.
  if e_rc <> 0.
*   At least one given object is not a data object => exit.
    exit.
  endif.

* Set timestamp.
  if g_timestamp is initial.
    CALL METHOD set_timestamp.
  endif.

* Append new entries to History Table.
  loop at lt_object into lr_object.
    check lr_object is bound.
*   Initialize.
    clear: lr_data_object,
           ls_snapshot,
           ls_history.
*   Convert to data object.
    try.
      lr_data_object ?= lr_object.
      catch cx_root.
*       Cast not successful => exit.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = '132'
            i_mv1           = 'CL_ISH_HISTORY'
            i_mv2           = 'BUILD_ENTRY'
            ir_object       = lr_object
          CHANGING
            cr_errorhandler = cr_errorhandler.
        e_rc = 1.
        exit.
    endtry.
    if not lr_data_object is bound.
*     Cast not successful => exit.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '132'
          i_mv1           = 'CL_ISH_HISTORY'
          i_mv2           = 'BUILD_ENTRY'
          ir_object       = lr_object
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = 1.
      exit.
    endif.
*   Build snapshot.
    CALL METHOD lr_data_object->build_snapshot
     IMPORTING
       es_snapshot     = ls_snapshot
       e_rc            = l_rc
     CHANGING
       cr_errorhandler = cr_errorhandler.
    if l_rc <> 0.
*     Snapshot not successful => exit.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '132'
          i_mv1           = 'CL_ISH_HISTORY'
          i_mv2           = 'BUILD_ENTRY'
          ir_object       = lr_data_object
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = 1.
      exit.
    endif.
*   Build entry and append to History Table.
    ls_history-activity  = i_activity.
    ls_history-act_type  = i_act_type.
    ls_history-timestamp = g_timestamp.
    ls_history-object    = lr_object.
    ls_history-content   = ls_snapshot.
    append ls_history to gt_history.
  endloop.
  if e_rc <> 0.
*   Error occurred => exit.
    exit.
  endif.

endmethod.


method BUILD_SNAPSHOT.

  DATA: ls_snapshot TYPE ish_snapshot.

* Initializations.
  e_rc  = 0.
  CLEAR: ls_snapshot,
         es_snapshot.

* Notice the attributes G_MODE and G_ACTIVE.
*  ls_snapshot-active = g_active.
*  ls_snapshot-mode   = g_mode.

* The field L_WA_SNAPSHOT-CONNECTION_KEY is not used here.
* It is only considered in class CL_ISH_RUN_DATA.
*  CALL METHOD snapshot_connection
*    IMPORTING
*      e_connection_key = ls_snapshot-connection_key.

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


method CREATE.

* Initialize.
  clear: er_instance,
         e_rc.

* Create History Object.
  CREATE OBJECT er_instance TYPE cl_ish_history.

* If creation not successful => exit.
  if not er_instance is bound.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '131'
        i_mv1           = 'CL_ISH_HISTORY'
        i_mv2           = 'CREATE'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
    exit.
  endif.

* Initialize History Object.
  CALL METHOD er_instance->initialize.

endmethod.


method CREATE_SNAPSHOT_OBJECT.

  DATA: lr_snapshot_object TYPE REF TO cl_ish_snap_history.

* Initializations
  CLEAR: e_rc.

* Create the snapshot object.
  CREATE OBJECT lr_snapshot_object.

* Save data.
  lr_snapshot_object->gt_history     = gt_history.
  lr_snapshot_object->g_timestamp    = g_timestamp.

  e_snapshot_object = lr_snapshot_object.

endmethod.


method DELETE_ENTRIES.

  FIELD-SYMBOLS: <ls_history> TYPE ish_history.

* Initialize.
  e_rc = 0.

* If all parameters initial => exit.
  if not ir_object    is bound   and
     i_activity       is initial and
     i_timestamp_from is initial and
     i_timestamp_to   is initial.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '133'
        i_mv1           = 'CL_ISH_HISTORY'
        i_mv2           = 'DELETE_ENTRIES'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
    exit.
  endif.

* Check given timestamps.
  if not i_timestamp_from is initial and
     not i_timestamp_to   is initial.
    if i_timestamp_from > i_timestamp_to.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '133'
          i_mv1           = 'CL_ISH_HISTORY'
          i_mv2           = 'DELETE_ENTRIES'
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = 1.
      exit.
    endif.
  endif.

* Loop at History Table.
  loop at gt_history assigning <ls_history>.
*   If object given => compare object.
    if ir_object is bound.
      check <ls_history>-object = ir_object.
    endif.
*   If activity given => compare activity.
    if not i_activity is initial.
      check <ls_history>-activity = i_activity.
    endif.
*   If timestamp given => compare timestamp.
    if not i_timestamp_from is initial.
      check <ls_history>-timestamp >= i_timestamp_from.
    endif.
    if not i_timestamp_to is initial.
      check <ls_history>-timestamp <= i_timestamp_to.
    endif.
*   Delete entry.
    delete table gt_history from <ls_history>.
  endloop.

endmethod.


method DESTROY.

* Initialize History Object.
  CALL METHOD initialize.

endmethod.


method GET_DATA.

* Return History Table.
  et_history = gt_history.

endmethod.


method GET_SNAPSHOT_KEY.

  g_snapshot_key = g_snapshot_key + 1.
  r_snapshot_key = g_snapshot_key.

endmethod.


METHOD get_values_of_field.

  DATA: lr_snapshot            TYPE REF TO cl_ish_snapshot,
        lt_hist_fvalue         TYPE ish_t_hist_fvalue,
        ls_hist_fvalue         TYPE ish_hist_fvalue,
        lt_string              TYPE TABLE OF string,
        l_string               TYPE string,
        l_attribute_name       TYPE ish_fieldname,
        ls_n1meorder           TYPE n1meorder,
        l_field_name           TYPE ish_fieldname,
        l_field_value          TYPE string,
        l_lines                TYPE i,
        ls_struct              TYPE REF TO data,
        l_type                 TYPE c,
        l_components           TYPE i,
        l_fieldtype            TYPE char200.

  FIELD-SYMBOLS: <ls_history>  TYPE ish_history,
                 <l_field>     TYPE any,
                 <ls_struct>   TYPE any.

* Initialize.
  CLEAR: et_fieldvalue[],
         es_last_fieldvalue,
         e_rc.

* Check parameter.
  IF ir_object IS INITIAL.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '014'
        i_mv1           = 'CL_ISH_HISTORY'
        i_mv2           = 'GET_VALUES_OF_FIELD'
        i_mv3           = 'IR_OBJECT'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
  ENDIF.
  IF i_fieldname IS INITIAL.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '014'
        i_mv1           = 'CL_ISH_HISTORY'
        i_mv2           = 'GET_VALUES_OF_FIELD'
        i_mv3           = 'I_FIELDNAME'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
  ENDIF.
  IF e_rc <> 0.
    EXIT.
  ENDIF.

* Split I_FIELDNAME into attribute name and field name.
  SPLIT i_fieldname AT '-' INTO TABLE lt_string.
  DESCRIBE TABLE lt_string LINES l_lines.
  CASE l_lines.
    WHEN 1.
*     Attribute name without field name.
      l_attribute_name = i_fieldname.
    WHEN 2.
*     Get first string as attribute name.
      READ TABLE lt_string INDEX 1 INTO l_string.
      IF l_string IS INITIAL.
*       No attribute name => error.
        e_rc = 1.
      ENDIF.
      l_attribute_name = l_string.
*     Get second string as field name.
      READ TABLE lt_string INDEX 2 INTO l_string.
      IF l_string IS INITIAL.
*       No field name => error.
        e_rc = 1.
      ENDIF.
      l_field_name = l_string.
    WHEN OTHERS.
*     No definite attribute/field name => error.
      e_rc = 1.
  ENDCASE.
  IF e_rc <> 0.
*   Given field name not correct => exit.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '134'
        i_mv1           = 'CL_ISH_HISTORY'
        i_mv2           = 'GET_VALUES_OF_FIELD'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Loop at History Table.
  LOOP AT gt_history ASSIGNING <ls_history>.
*   Compare object.
    CHECK <ls_history>-object = ir_object.
*   If activity given => compare activity.
    IF NOT i_activity IS INITIAL.
      CHECK <ls_history>-activity = i_activity.
    ENDIF.

*   Fichte, MED-41835(2): Is this one of the special fields which
*   all objects have (like MODE, ACTIVE)?
    IF i_fieldname = co_field_active  OR
       i_fieldname = co_field_mode.
      CASE i_fieldname.
        WHEN co_field_active.
          l_field_value = <ls_history>-content-active.
        WHEN co_field_mode.
          l_field_value = <ls_history>-content-mode.
      ENDCASE.

*     Build History Field Value and append to table.
      CLEAR: ls_hist_fvalue.
      ls_hist_fvalue-activity  = <ls_history>-activity.
      ls_hist_fvalue-timestamp = <ls_history>-timestamp.
      ls_hist_fvalue-fieldname = i_fieldname.
      ls_hist_fvalue-value     = l_field_value.
      APPEND ls_hist_fvalue TO lt_hist_fvalue.

      CONTINUE.
    ENDIF.
*   Fichte, MED-41835(2) - End

*   Get snapshot object.
    TRY.
      lr_snapshot ?= <ls_history>-content-object.
      CATCH cx_root.
*       Cast not successful => exit.
        e_rc = 1.
        EXIT.
    ENDTRY.
    IF NOT lr_snapshot IS BOUND.
*     No snapshot object => exit.
      e_rc = 1.
      EXIT.
    ENDIF.
*   Get snapshot attribute type.
    CALL METHOD lr_snapshot->get_attribute
      EXPORTING
        i_attribute_name = l_attribute_name
      IMPORTING
        e_type           = l_fieldtype
        e_rc             = e_rc
      CHANGING
        cr_errorhandler  = cr_errorhandler.
    IF e_rc <> 0.
*     Error occurred => exit.
      EXIT.
    ENDIF.
*   Create data object with attribute type.
    TRY.
      CREATE DATA ls_struct TYPE (l_fieldtype).
      ASSIGN ls_struct->* TO <ls_struct>.
      IF sy-subrc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
      CATCH cx_sy_create_data_error.
        e_rc = 1.
        EXIT.
    ENDTRY.
*   Get snapshot attribute reference into data object.
    CALL METHOD lr_snapshot->get_attribute
      EXPORTING
        i_attribute_name = l_attribute_name
      IMPORTING
        e_value          = <ls_struct>
        e_rc             = e_rc
      CHANGING
        cr_errorhandler  = cr_errorhandler.
    IF e_rc <> 0.
*     Error occurred => exit.
      EXIT.
    ENDIF.
*   Determine attribute type.
    DESCRIBE FIELD <ls_struct> TYPE l_type COMPONENTS l_components.
*   Get field value from data object.
    CASE l_type.
      WHEN 'u' OR 'v'.
*       Structure => get a single field value.
        IF l_field_name IS INITIAL.
**         Attribute is a structure, get all field values.
*          assign <ls_struct> to <l_field>.
*         Not supported.
          e_rc = 1.
          EXIT.
        ELSE.
          TRY.
*           Attribute is a structure, get a single field value.
            ASSIGN COMPONENT l_field_name OF STRUCTURE <ls_struct> TO <l_field>.
            IF sy-subrc <> 0.
              e_rc = 1.
              EXIT.
            ENDIF.
            CATCH cx_root.
              e_rc = 1.
              EXIT.
          ENDTRY.
        ENDIF.
      WHEN 'h'.
*       Internal table => not supported.
        e_rc = 1.
        EXIT.
      WHEN 'l' OR 'r'.
*       Data and object reference => not supported.
        e_rc = 1.
        EXIT.
      WHEN OTHERS.
*       Elementary type => attribute is a single field.
        TRY.
          ASSIGN <ls_struct> TO <l_field>.
          IF sy-subrc <> 0.
            e_rc = 1.
            EXIT.
          ENDIF.
          CATCH cx_root.
            e_rc = 1.
            EXIT.
        ENDTRY.
    ENDCASE.
    IF <l_field> IS ASSIGNED.
      TRY.
        l_field_value = <l_field>.
        IF sy-subrc <> 0.
          e_rc = 1.
          EXIT.
        ENDIF.
        CATCH cx_root.
          e_rc = 1.
          EXIT.
      ENDTRY.
    ELSE.
      e_rc = 1.
      EXIT.
    ENDIF.
*   Build History Field Value and append to table.
    ls_hist_fvalue-activity  = <ls_history>-activity.
    ls_hist_fvalue-timestamp = <ls_history>-timestamp.
    ls_hist_fvalue-fieldname = i_fieldname.
    ls_hist_fvalue-value     = l_field_value.
    APPEND ls_hist_fvalue TO lt_hist_fvalue.
  ENDLOOP.
  IF e_rc <> 0.
*   Error occurred => exit.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '134'
        i_mv1           = 'CL_ISH_HISTORY'
        i_mv2           = 'GET_VALUES_OF_FIELD'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Return sorted table of field values.
  SORT lt_hist_fvalue BY timestamp DESCENDING.
  et_fieldvalue = lt_hist_fvalue.

* Return last (newest) field value.
  READ TABLE lt_hist_fvalue INDEX 1 INTO es_last_fieldvalue.

ENDMETHOD.


METHOD has_field_changed.

  DATA: lt_string              TYPE TABLE OF string,
        l_string               TYPE string,
        l_attribute_name       TYPE ish_fieldname,
        l_field_name           TYPE ish_fieldname,
        l_field_value          TYPE string,
        l_lines                TYPE i,
        lt_fieldvalue          TYPE ish_t_hist_fvalue,
        ls_fieldvalue          TYPE ish_hist_fvalue,
        lr_data_object         TYPE REF TO cl_ish_data_object,
        ls_snapshot            TYPE ish_snapshot,
        lr_snapshot            TYPE REF TO cl_ish_snapshot,
        ls_struct              TYPE REF TO data,
        l_fieldtype            TYPE char200,
        lt_fieldname           TYPE ish_t_fieldname,
        lt_ddfields            TYPE ddfields,
        ls_dfies               TYPE dfies,
        lt_fval                TYPE ish_t_field_value,
        ls_fval                TYPE rnfield_value,
        l_type                 TYPE c,
        l_components           TYPE i,
        l_changed              TYPE ish_on_off,
        l_rc                   TYPE ish_method_rc.
  DATA: lr_typedescr           TYPE REF TO cl_abap_typedescr,
        lr_datadescr           TYPE REF TO cl_abap_datadescr,
        lr_tabledescr          TYPE REF TO cl_abap_tabledescr,
        l_type_kind            TYPE abap_typekind.

  FIELD-SYMBOLS: <ls_fvalue1>  TYPE ish_hist_fvalue,
                 <ls_fvalue2>  TYPE ish_hist_fvalue,
                 <l_attribute> TYPE any,
                 <l_field>     TYPE any,
                 <ls_struct>   TYPE any.

* Initialize.
  CLEAR: e_changed,
         e_rc.

* Check parameter.
  IF ir_object IS INITIAL.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '014'
        i_mv1           = 'CL_ISH_HISTORY'
        i_mv2           = 'HAS_FIELD_CHANGED'
        i_mv3           = 'IR_OBJECT'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
  ENDIF.
  IF i_fieldname IS INITIAL.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '014'
        i_mv1           = 'CL_ISH_HISTORY'
        i_mv2           = 'HAS_FIELD_CHANGED'
        i_mv3           = 'I_FIELDNAME'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
  ENDIF.
  IF e_rc <> 0.
    EXIT.
  ENDIF.

*------------------------------------------------------
* Split I_FIELDNAME into attribute name and field name.
*------------------------------------------------------
  SPLIT i_fieldname AT '-' INTO TABLE lt_string.
  DESCRIBE TABLE lt_string LINES l_lines.
  CASE l_lines.
    WHEN 1.
*     Attribute name without field name.
      l_attribute_name = i_fieldname.
    WHEN 2.
*     Get first string as attribute name.
      CLEAR l_string.
      READ TABLE lt_string INDEX 1 INTO l_string.
      IF l_string IS INITIAL.
*       No attribute name => error.
        e_rc = 1.
      ENDIF.
      l_attribute_name = l_string.
*     Get second string as field name.
      CLEAR l_string.
      READ TABLE lt_string INDEX 2 INTO l_string.
      IF l_string IS INITIAL.
*       No field name => error.
        e_rc = 1.
      ENDIF.
      l_field_name = l_string.
    WHEN OTHERS.
*     No definite attribute/field name => error.
      e_rc = 1.
  ENDCASE.
  IF e_rc <> 0.
*   Given field name not correct => exit.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '135'
        i_mv1           = 'CL_ISH_HISTORY'
        i_mv2           = 'HAS_FIELD_CHANGED'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

*-------------------------------------
* Get current field value from object.
*-------------------------------------
  DO 1 TIMES.
*   Convert to data object.
    TRY.
      lr_data_object ?= ir_object.
      CATCH cx_root.
*       Cast not successful => exit.
        e_rc = 1.
        EXIT.
    ENDTRY.
    IF NOT lr_data_object IS BOUND.
*     Cast not successful => exit.
      e_rc = 1.
      EXIT.
    ENDIF.
*   Build snapshot.
    CALL METHOD lr_data_object->build_snapshot
     IMPORTING
       es_snapshot     = ls_snapshot
       e_rc            = l_rc
     CHANGING
       cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
*     Snapshot not successful => exit.
      e_rc = 1.
      EXIT.
    ENDIF.

*   Fichte, MED-41835(2): Is this one of the special fields which
*   all objects have (like MODE, ACTIVE)?
    IF i_fieldname = co_field_active  OR
       i_fieldname = co_field_mode.
      APPEND i_fieldname TO lt_fieldname.
      EXIT.   " Leave DO 1 TIMES
    ENDIF.
*   Fichte, MED-41835(2) - End

*   Get snapshot object.
    TRY.
      lr_snapshot ?= ls_snapshot-object.
      CATCH cx_root.
*       Cast not successful => exit.
        e_rc = 1.
        EXIT.
    ENDTRY.
    IF NOT lr_snapshot IS BOUND.
*     No snapshot object => exit.
      e_rc = 1.
      EXIT.
    ENDIF.
*   Get snapshot attribute type.
    CALL METHOD lr_snapshot->get_attribute
      EXPORTING
        i_attribute_name = l_attribute_name
      IMPORTING
          e_type         = l_fieldtype
        e_rc             = l_rc
      CHANGING
        cr_errorhandler  = cr_errorhandler.
    IF l_rc <> 0.
*     Error occurred => exit.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   Create data object with attribute type.
    TRY.
      CREATE DATA ls_struct TYPE (l_fieldtype).
      ASSIGN ls_struct->* TO <ls_struct>.
      CATCH cx_sy_create_data_error.
        e_rc = 1.
        EXIT.
    ENDTRY.
*   Get snapshot attribute reference into data object.
    CALL METHOD lr_snapshot->get_attribute
      EXPORTING
        i_attribute_name = l_attribute_name
      IMPORTING
        e_value          = <ls_struct>
        e_rc             = l_rc
      CHANGING
        cr_errorhandler  = cr_errorhandler.
    IF l_rc <> 0 OR NOT <ls_struct> IS ASSIGNED.
*     Error occurred => exit.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   Determine attribute type.
    DESCRIBE FIELD <ls_struct> TYPE l_type COMPONENTS l_components.
*   Get field value from data object.
    CASE l_type.
      WHEN 'u' OR 'v'.
*       Structure => compare all components.
        IF l_field_name IS INITIAL.
*         No field name given => get all fields.
          l_string = l_fieldtype.
          CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
            EXPORTING
              i_data_name     = l_string
            IMPORTING
              et_ddfields     = lt_ddfields
              e_rc            = l_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          IF l_rc <> 0.
            e_rc = l_rc.
            EXIT.
          ENDIF.
          LOOP AT lt_ddfields INTO ls_dfies.
            CONCATENATE l_attribute_name
                        '-'
                        ls_dfies-fieldname
                   INTO l_field_name.
            CONDENSE l_field_name NO-GAPS.
            APPEND l_field_name TO lt_fieldname.
          ENDLOOP.
        ELSE.
*         Field name given.
*          append l_field_name to lt_fieldname.
          CONCATENATE l_attribute_name
                      '-'
                      l_field_name
                  INTO l_field_name.
          CONDENSE l_field_name NO-GAPS.
          APPEND l_field_name TO lt_fieldname.
        ENDIF.
      WHEN 'h'.
*       Internal table => not supported.
        e_rc = 1.
        EXIT.
*------------------------------------------------
* Internal table => still not supported (BEGIN).
*------------------------------------------------
**       Get the typedescr object for I_DATA_NAME.
*        l_string = l_fieldtype.
*        lr_typedescr = cl_abap_typedescr=>describe_by_name( l_string ).
*        try.
*          lr_tabledescr ?= lr_typedescr.
*          catch cx_root.
**           Cast not successful => exit.
*            e_rc = 1.
*            exit.
*        endtry.
**       Get table line type.
*        CALL METHOD LR_TABLEDESCR->GET_TABLE_LINE_TYPE
*          RECEIVING
*            P_DESCR_REF = lr_datadescr.
**       Get data type kind.
*        CALL METHOD CL_ABAP_DATADESCR=>GET_DATA_TYPE_KIND
*          EXPORTING
*            P_DATA      = lr_datadescr
*          RECEIVING
*            P_TYPE_KIND = l_type_kind.
*        case l_type_kind.
*          when 'u' or 'v'.
**           Structure => compare all components.
*            e_rc = 1.
*            exit.
*          when 'l' or 'r'.
**           Data and object reference => not supported.
*            e_rc = 1.
*            exit.
*          when others.
**           Elementary type => line type is a single field.
*            e_rc = 1.
*            exit.
*        endcase.  "l_type_kind
*------------------------------------------------
* Internal table => still not supported (END).
*------------------------------------------------
      WHEN 'l' OR 'r'.
*       Data and object reference => not supported.
        e_rc = 1.
        EXIT.
      WHEN OTHERS.
*       Elementary type => attribute is a single field.
        APPEND l_attribute_name TO lt_fieldname.
    ENDCASE.
  ENDDO.
  IF e_rc <> 0.
*   Error occurred => exit.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '135'
        i_mv1           = 'CL_ISH_HISTORY'
        i_mv2           = 'HAS_FIELD_CHANGED'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

*----------------------------------------------
* Compare field values (Object, History Table).
*----------------------------------------------
  CHECK NOT lt_fieldname[] IS INITIAL.

  LOOP AT lt_fieldname INTO l_field_name.
*   Get current field value.
*   Fichte, MED-41835(2): Is this one of the special fields which
*   all objects have (like MODE, ACTIVE)?
    IF l_field_name = co_field_active.
      ASSIGN COMPONENT 'ACTIVE' OF STRUCTURE ls_snapshot TO <l_field>.
    ELSEIF l_field_name = co_field_mode.
      ASSIGN COMPONENT 'MODE' OF STRUCTURE ls_snapshot TO <l_field>.
    ELSE.
      CASE l_type.
        WHEN 'u' OR 'v'.
*         Structure => get a single field value.
          SPLIT l_field_name AT '-' INTO TABLE lt_string.
          READ TABLE lt_string INDEX 2 INTO l_string.
          TRY.
            ASSIGN COMPONENT l_string OF STRUCTURE <ls_struct> TO <l_field>.
            IF sy-subrc <> 0.
              e_rc = 1.
              EXIT.
            ENDIF.
            CATCH cx_root.
              e_rc = 1.
              EXIT.
          ENDTRY.
        WHEN 'h'.
*         Internal table => not supported.
          e_rc = 1.
          EXIT.
        WHEN 'l' OR 'r'.
*         Data and object reference => not supported.
          e_rc = 1.
          EXIT.
        WHEN OTHERS.
*         Elementary type => attribute is a single field.
          TRY.
            ASSIGN <ls_struct> TO <l_field>.
            IF sy-subrc <> 0.
              e_rc = 1.
              EXIT.
            ENDIF.
            CATCH cx_root.
              e_rc = 1.
              EXIT.
          ENDTRY.
      ENDCASE.
    ENDIF.
*   Fichte, MED-41835(2) - End

    IF <l_field> IS ASSIGNED.
      DO 1 TIMES.
*       Get field values of History Table.
        CALL METHOD get_values_of_field
          EXPORTING
            ir_object          = ir_object
            i_fieldname        = l_field_name
            i_activity         = i_activity
          IMPORTING
            et_fieldvalue      = lt_fieldvalue
            e_rc               = l_rc
          CHANGING
            cr_errorhandler    = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.  "loop
        ENDIF.
*       Compare field values.
*       Fichte, MED-41835(2): If GET_VALUES_OF_FIELD does not return
*       any fieldvalues this means that the whole object (IR_OBJECT)
*       is new => set CHANGED = ON
        IF lt_fieldvalue[] IS INITIAL.
          l_changed = on.
          EXIT.
        ENDIF.
*       Fichte, MED-41835(2) - End
        l_changed = off.
        LOOP AT lt_fieldvalue ASSIGNING <ls_fvalue1>.
*         Compare with current field value.
          IF <ls_fvalue1>-value <> <l_field>.
            l_changed = on.
            EXIT.  "loop
          ENDIF.
*         Compare with previous field value (if available).
          IF <ls_fvalue2> IS ASSIGNED.
            IF <ls_fvalue1>-value <> <ls_fvalue2>-value.
              l_changed = on.
              EXIT.  "loop
            ENDIF.
          ENDIF.
*         Remember current field value.
          ASSIGN <ls_fvalue1> TO <ls_fvalue2>.
        ENDLOOP.
        IF l_changed = on.
          EXIT.  "do 1 times
        ENDIF.
      ENDDO.  "1 times.
      IF e_rc <> 0.
*       Error occurred => exit.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = '135'
            i_mv1           = 'CL_ISH_HISTORY'
            i_mv2           = 'HAS_FIELD_CHANGED'
          CHANGING
            cr_errorhandler = cr_errorhandler.
        EXIT.
      ENDIF.
*     Fichte, MED-41835: Exit if L_CHANGED = ON
      IF l_changed = on.
        EXIT.   " loop at lt_fieldname
      ENDIF.
*     Fichte, MED-41835 - End
    ENDIF.  "<l_field>
  ENDLOOP.  "lt_fieldname

* Return flag "Changed".
  e_changed = l_changed.

ENDMETHOD.


method IF_ISH_IDENTIFY_OBJECT~GET_TYPE.

* Return object type.
  e_object_type = co_otype_history.

endmethod.


method IF_ISH_IDENTIFY_OBJECT~IS_A.

  DATA: l_object_type TYPE i.

* Get object type.
  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

* Check object type.
  if l_object_type = i_object_type.
    r_is_a = on.
  else.
    r_is_a = off.
  endif.

endmethod.


method IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM.

* Check object type.
  if i_object_type = co_otype_history.
    r_is_inherited_from = on.
  else.
    r_is_inherited_from = off.
  endif.

endmethod.


method IF_ISH_SNAPSHOT_OBJECT~DESTROY_SNAPSHOT.

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

* Destroy snapshot object.
  CALL METHOD l_wa_snapshot-object->destroy.

* Delete from snapshot table.
  DELETE gt_snapshots WHERE key = i_key.

endmethod.


method IF_ISH_SNAPSHOT_OBJECT~SNAPSHOT.

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

endmethod.


method IF_ISH_SNAPSHOT_OBJECT~UNDO.

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
*  g_active = l_wa_snapshot-active.
*  g_mode   = l_wa_snapshot-mode.

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
*  CALL METHOD undo_connection
*    EXPORTING
*      i_connection_key = l_wa_snapshot-connection_key.

* This snapshot can now be deleted.
  DELETE gt_snapshots WHERE key = i_key.

endmethod.


method INITIALIZE.

* Initialize global attributes.
  clear: gt_history[],
         g_timestamp.

endmethod.


method RELEASE_TIMESTAMP.

* Initialize global timestamp.
  clear g_timestamp.

endmethod.


method SET_TIMESTAMP.

  data: l_timestamp  type timestampl,
        l_char(25)   type c.

* Get current timestamp (JJJJMMTThhmmss,mmmuuun).
  get time stamp field l_timestamp.

* Convert to CHAR.
  l_char = l_timestamp.
  condense l_char.

* Set global timestamp.
  g_timestamp = l_char.

endmethod.


method UNDO_SNAPSHOT_OBJECT.

  DATA: lr_snapshot_object TYPE REF TO cl_ish_snap_history.

* Initializations:
  CLEAR: e_rc.

* Cast the snapshot object.
  CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
    lr_snapshot_object ?= i_snapshot_object.
  ENDCATCH.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* Set attributes.
  gt_history     = lr_snapshot_object->gt_history.
  g_timestamp    = lr_snapshot_object->g_timestamp.

endmethod.
ENDCLASS.
