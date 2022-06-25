class CL_ISH_DBR_BAU_HIER definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_DBR_BAU_HIER
*"* do not include other source files here!!!

  interfaces IF_ISH_CONSTANT_DEFINITION .

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
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
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

  class-methods GET_T_BAU_HIER
    importing
      value(I_BELOW) type ISH_ON_OFF default ON
      value(I_ABOVE) type ISH_ON_OFF default OFF
      value(I_BAUID) type BAUID optional
      !IT_BAUID type STANDARD TABLE optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_FIELDNAME_BAU) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_TN11H) type ISHMED_T_TN11H
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DBR_PAT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DBR_BAU_HIER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBR_BAU_HIER IMPLEMENTATION.


METHOD get_t_bau_hier.

  DATA: lt_bauid               TYPE ishmed_t_bauid,
        ls_bauid               LIKE LINE OF lt_bauid,
        lt_tn11h               TYPE ishmed_t_tn11h,
        lt_bauid_om            TYPE ishmed_t_ishid,
        l_status               TYPE ish_on_off,
        l_data                 TYPE REF TO data.

  FIELD-SYMBOLS: <l_field_bau> TYPE any,
                 <l_imp_bauid> TYPE any.

  e_rc = 0.

  REFRESH: et_tn11h, lt_tn11h, lt_bauid.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF i_bauid IS INITIAL AND it_bauid[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_bauid.
    ASSIGN l_data->* TO <l_imp_bauid>.
    LOOP AT it_bauid INTO <l_imp_bauid>.
      sy-subrc = 4.
      IF i_fieldname_bau IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_bau OF STRUCTURE <l_imp_bauid>
            TO <l_field_bau>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'BAUID' OF STRUCTURE <l_imp_bauid>
            TO <l_field_bau>.
        IF sy-subrc <> 0.
          ASSIGN COMPONENT 'UEBBE' OF STRUCTURE <l_imp_bauid>
              TO <l_field_bau>.
          IF sy-subrc <> 0.
            ASSIGN COMPONENT 'UNTBE' OF STRUCTURE <l_imp_bauid>
                TO <l_field_bau>.
            IF sy-subrc <> 0.
              ASSIGN COMPONENT 'LOW' OF STRUCTURE <l_imp_bauid>
                  TO <l_field_bau>.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
      CHECK sy-subrc = 0.
      ls_bauid-bauid = <l_field_bau>.
      CHECK ls_bauid-bauid IS NOT INITIAL.
      APPEND ls_bauid TO lt_bauid.
    ENDLOOP.
  ENDIF.

* Check SAP OM Switch
  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status   = l_status
    EXCEPTIONS
      not_active = 0.

  IF l_status EQ on.

    IF i_below = on.
      REFRESH lt_tn11h.
      lt_bauid_om[] = lt_bauid[].
      CALL FUNCTION 'ISH_OM_BLD_HRCHY_LEVEL_DOWN'
        EXPORTING
          i_upper_bauid  = i_bauid
          it_upper_bauid = lt_bauid_om
          i_read_db      = i_read_db
        IMPORTING
          et_tn11h       = lt_tn11h
        EXCEPTIONS
          nothing_found  = 1
          not_valid      = 2
          internal_error = 3
          OTHERS         = 4.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
          CHANGING
            cr_errorhandler = cr_errorhandler.
        EXIT.
      ELSE.
        APPEND LINES OF lt_tn11h TO et_tn11h.
      ENDIF.
    ENDIF.
    IF i_above = on.
      REFRESH lt_tn11h.
      lt_bauid_om[] = lt_bauid[].
      CALL FUNCTION 'ISH_OM_BLD_HRCHY_LEVEL_UP'
        EXPORTING
          i_lower_bauid  = i_bauid
          it_lower_bauid = lt_bauid_om
          i_read_db      = i_read_db
        IMPORTING
          et_tn11h       = lt_tn11h
        EXCEPTIONS
          nothing_found  = 1
          not_valid      = 2
          internal_error = 3
          OTHERS         = 4.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
          CHANGING
            cr_errorhandler = cr_errorhandler.
        EXIT.
      ELSE.
        APPEND LINES OF lt_tn11h TO et_tn11h.
      ENDIF.
    ENDIF.

*MED-53386: Begin
    SORT et_tn11h BY untbe uebbe.
    DELETE ADJACENT DUPLICATES FROM et_tn11h COMPARING untbe uebbe.
*MED-53386: End

  ELSE.

    IF i_bauid IS INITIAL AND lt_bauid[] IS INITIAL.
      SELECT * FROM tn11h INTO TABLE et_tn11h.
    ELSE.
      IF i_below = on.
        IF i_bauid IS NOT INITIAL.
          SELECT * FROM tn11h INTO TABLE et_tn11h
                 WHERE  uebbe  = i_bauid.
        ELSE.
          SELECT * FROM tn11h INTO TABLE et_tn11h
                 FOR ALL ENTRIES IN lt_bauid
                 WHERE  uebbe  = lt_bauid-bauid.
        ENDIF.
      ENDIF.
      IF i_above = on.
        IF i_bauid IS NOT INITIAL.
          SELECT * FROM tn11h APPENDING TABLE et_tn11h
                 WHERE  untbe  = i_bauid.
        ELSE.
          SELECT * FROM tn11h APPENDING TABLE et_tn11h
                 FOR ALL ENTRIES IN lt_bauid
                 WHERE  untbe  = lt_bauid-bauid.
        ENDIF.
      ENDIF.
      SORT et_tn11h BY untbe uebbe.
      DELETE ADJACENT DUPLICATES FROM et_tn11h COMPARING untbe uebbe.
    ENDIF.

  ENDIF.

ENDMETHOD.
ENDCLASS.
