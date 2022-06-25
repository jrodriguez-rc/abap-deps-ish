class CL_ISH_PERS_TC definition
  public
  inheriting from CL_SUPER_PERS_ACCESS
  create public .

public section.

  methods CONSTRUCTOR .

  methods IF_PERS_EXTERNAL_TABLE~ROLE_TRANSPORT
    redefinition .
  methods IF_PERS_EXTERNAL_TABLE~SAVE_BUFFER
    redefinition .
protected section.

  methods _CHECK_PERIOD
    exceptions
      CHECK_PERIOD_FAILED .

  methods DIALOG_RESULT_PROCESS_ROLE
    redefinition .
private section.
ENDCLASS.



CLASS CL_ISH_PERS_TC IMPLEMENTATION.


method CONSTRUCTOR.

  data:
    l_fieldname type fieldname.

  call method super->constructor.

  create data me->buffer_line_role type TN1TC_RESP_ROLE .
  create data me->buffer_table_role type TN1TC_RESP_ROLE_T.

  me->table_role = 'TN1TC_RESP_ROLE'.
  me->field_role = 'AGR_NAME'.

  l_fieldname = 'ERDAT'.
  INSERT l_fieldname INTO TABLE dialog_fields_hide.
  l_fieldname = 'ERUSR'.
  INSERT l_fieldname INTO TABLE dialog_fields_hide.
  l_fieldname = 'UPDAT'.
  INSERT l_fieldname INTO TABLE dialog_fields_hide.
  l_fieldname = 'UPUSR'.
  INSERT l_fieldname INTO TABLE dialog_fields_hide.

endmethod.


method DIALOG_RESULT_PROCESS_ROLE.

*  CALL METHOD _check_period
*    EXCEPTIONS
*      check_period_failed = 1.
*  IF sy-subrc <> 0.
*    RAISE input_error.
*  ENDIF.

endmethod.


method IF_PERS_EXTERNAL_TABLE~ROLE_TRANSPORT.

  TYPES: BEGIN OF ty_key,
    mandt       TYPE sy-mandt,
    agr_name    TYPE n1tc_agr_name,
    ou_resp     TYPE n1tc_ou_resp,
    begdt       TYPE begda.
  TYPES: END OF ty_key.

  DATA: ls_transkey         TYPE LINE OF tr_keys,
        lt_transkey         TYPE         tr_keys,
        ls_object           TYPE LINE OF tredt_objects,
        lt_object           TYPE         tredt_objects,
        ls_resp_role        TYPE tn1tc_resp_role,
        lt_resp_role        TYPE STANDARD TABLE OF tn1tc_resp_role,
        ls_key              TYPE ty_key.

* select data
  SELECT * FROM tn1tc_resp_role INTO TABLE lt_resp_role
    WHERE agr_name = p_role_name.  "#EC CI_GENBUFF

  CHECK lt_resp_role IS NOT INITIAL.

  ls_object-pgmid    = 'R3TR'.
  ls_object-object   = 'TABU'.
  ls_object-objfunc  = 'K'.
  ls_object-obj_name = 'TN1TC_RESP_ROLE'.
  INSERT ls_object INTO TABLE lt_object.

  ls_transkey-pgmid      = 'R3TR'.
  ls_transkey-object     = 'TABU'.
  ls_transkey-mastertype = 'TABU'.
  ls_transkey-sortflag   = space.
  ls_transkey-flag       = space.
  ls_transkey-viewname   = space.
  ls_transkey-objfunc    = space.
  ls_transkey-objname    = 'TN1TC_RESP_ROLE'.
  ls_transkey-mastername = 'TN1TC_RESP_ROLE'.

  LOOP AT lt_resp_role INTO ls_resp_role.
    CLEAR ls_key.
    MOVE-CORRESPONDING ls_resp_role TO ls_key.
    CHECK ls_key IS NOT INITIAL.
    ls_transkey-tabkey = ls_key.
    INSERT ls_transkey INTO TABLE lt_transkey.
  ENDLOOP.

  CALL FUNCTION 'TR_OBJECTS_CHECK'
    TABLES
      wt_ko200                = lt_object
      wt_e071k                = lt_transkey
    EXCEPTIONS
      cancel_edit_other_error = 1
      show_only_other_error   = 2
      OTHERS                  = 3.

  IF sy-subrc <> 0.
    RAISE transport_failed.
  ENDIF.


* === einhängen
  CALL FUNCTION 'TR_OBJECTS_INSERT'
    EXPORTING
      wi_order                = p_order
    TABLES
      wt_ko200                = lt_object
      wt_e071k                = lt_transkey
    EXCEPTIONS
      cancel_edit_other_error = 1
      show_only_other_error   = 2
      OTHERS                  = 3.

  IF sy-subrc <> 0.
    RAISE transport_failed.
  ENDIF.

endmethod.


method IF_PERS_EXTERNAL_TABLE~SAVE_BUFFER.

  FIELD-SYMBOLS: <buffer_table_role> TYPE STANDARD TABLE.
  DATA: l_subrc TYPE sysubrc.
  DATA: l_fieldname TYPE dfies-lfieldname.
  DATA: l_dfies TYPE dfies.

  FIELD-SYMBOLS: <l_any>          TYPE any.
  FIELD-SYMBOLS: <l_buffer_line>  TYPE any.

* check period
  CALL METHOD _check_period
    EXCEPTIONS
      check_period_failed = 1.
  IF sy-subrc <> 0.
    RAISE save_buffer_failed.
  ENDIF.

* save role data

* check user table name
  CALL FUNCTION 'DD_EXIST_TABLE'
    EXPORTING
      tabname = table_role
      status  = 'A'
    IMPORTING
      subrc   = l_subrc
    EXCEPTIONS
      OTHERS  = 0.

  IF l_subrc = 0.

* check fieldname
    l_fieldname = field_role.
    CALL FUNCTION 'DDIF_FIELDINFO_GET'
      EXPORTING
        tabname    = table_role
        fieldname  = field_role
        lfieldname = l_fieldname
      IMPORTING
        dfies_wa   = l_dfies
      EXCEPTIONS
        OTHERS     = 0.

    IF NOT l_dfies IS INITIAL.

*     assign field symbol
      ASSIGN buffer_table_role->* TO <buffer_table_role>.

      LOOP AT <buffer_table_role> ASSIGNING <l_buffer_line>.
        ASSIGN COMPONENT 'ERUSR' OF STRUCTURE <l_buffer_line> TO <l_any>.
        IF <l_any> IS INITIAL.
          <l_any> = sy-uname.
          ASSIGN COMPONENT 'ERDAT' OF STRUCTURE <l_buffer_line> TO <l_any>.
          <l_any> = sy-datum.
          ASSIGN COMPONENT 'UPUSR' OF STRUCTURE <l_buffer_line> TO <l_any>.
          CLEAR <l_any>.
          ASSIGN COMPONENT 'UPDAT' OF STRUCTURE <l_buffer_line> TO <l_any>.
          CLEAR <l_any>.
        ELSE.
          ASSIGN COMPONENT 'UPUSR' OF STRUCTURE <l_buffer_line> TO <l_any>.
          <l_any> = sy-uname.
          ASSIGN COMPONENT 'UPDAT' OF STRUCTURE <l_buffer_line> TO <l_any>.
          <l_any> = sy-datum.
        ENDIF.
      ENDLOOP.

*     delete old entries
      CALL METHOD me->remove_data_from_db
        EXPORTING
          p_dfies      = l_dfies
          p_owner_type = c_pers_type_role
        EXCEPTIONS
          OTHERS       = 0.

*     save buffer
      MODIFY (table_role) FROM TABLE <buffer_table_role>.

    ENDIF.

  ENDIF.

endmethod.


method _CHECK_PERIOD.

  FIELD-SYMBOLS: <lt_resp_role>     TYPE STANDARD TABLE.
  FIELD-SYMBOLS: <ls_resp_role>     TYPE tn1tc_resp_role.
  FIELD-SYMBOLS: <lt_resp_role_tmp> TYPE STANDARD TABLE.
  FIELD-SYMBOLS: <ls_resp_role_tmp> TYPE tn1tc_resp_role.

  ASSIGN buffer_table_role->* TO <lt_resp_role>.
  ASSIGN buffer_table_role->* TO <lt_resp_role_tmp>.
  LOOP AT <lt_resp_role> ASSIGNING <ls_resp_role>.
    IF <ls_resp_role>-begdt > <ls_resp_role>-enddt.
      MESSAGE e046(sv).
      RAISE check_period_failed.
    ENDIF.

    LOOP AT <lt_resp_role_tmp> ASSIGNING <ls_resp_role_tmp>.
      CHECK <ls_resp_role>-agr_name = <ls_resp_role_tmp>-agr_name AND
            <ls_resp_role>-ou_resp = <ls_resp_role_tmp>-ou_resp.

      CHECK <ls_resp_role>-begdt <> <ls_resp_role_tmp>-begdt OR
            <ls_resp_role>-mandt <> <ls_resp_role_tmp>-mandt.

      IF ( <ls_resp_role>-begdt GE <ls_resp_role_tmp>-begdt  AND
         <ls_resp_role>-begdt LE <ls_resp_role_tmp>-enddt ) OR
       ( <ls_resp_role>-enddt GE <ls_resp_role_tmp>-begdt  AND
         <ls_resp_role>-enddt LE <ls_resp_role_tmp>-enddt ) OR
       ( <ls_resp_role>-begdt LE <ls_resp_role_tmp>-begdt  AND
         <ls_resp_role>-enddt GE <ls_resp_role_tmp>-enddt ).

*     Der Gültigkeitszeitraum überlappt sich mit anderen Zeiträumen
      MESSAGE e154(n1tc)
         WITH <ls_resp_role>-ou_resp <ls_resp_role>-agr_name.

      RAISE check_period_failed.
    ENDIF.
    ENDLOOP.
  ENDLOOP.

endmethod.
ENDCLASS.
