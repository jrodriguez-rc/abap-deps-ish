class CL_ISH_DBR_ORG_HIER definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_DBR_ORG_HIER
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

  class-methods GET_T_ORG_HIER
    importing
      value(I_BELOW) type ISH_ON_OFF default ON
      value(I_ABOVE) type ISH_ON_OFF default OFF
      value(I_ORGID) type ORGID optional
      !IT_ORGID type STANDARD TABLE optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_BEGDT) type SY-DATUM default SY-DATUM
      value(I_ENDDT) type SY-DATUM default SY-DATUM
      value(I_FIELDNAME_ORG) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_TN10H) type ISHMED_T_TN10H
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DBR_PAT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DBR_ORG_HIER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBR_ORG_HIER IMPLEMENTATION.


METHOD get_t_org_hier.

  DATA: lt_orgid               TYPE ishmed_t_orgid,
        ls_orgid               LIKE LINE OF lt_orgid,
        lt_orgid_om            TYPE ishmed_t_ishid,
        lt_tn10h               TYPE ishmed_t_tn10h,
        l_status               TYPE ish_on_off,
        l_data                 TYPE REF TO data.

  FIELD-SYMBOLS: <l_field_org> TYPE any,
                 <l_imp_orgid> TYPE any.

  e_rc = 0.

  REFRESH: et_tn10h, lt_tn10h, lt_orgid.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF i_orgid IS INITIAL AND it_orgid[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_orgid.
    ASSIGN l_data->* TO <l_imp_orgid>.
    LOOP AT it_orgid INTO <l_imp_orgid>.
      sy-subrc = 4.
      IF i_fieldname_org IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_org OF STRUCTURE <l_imp_orgid>
            TO <l_field_org>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'ORGID' OF STRUCTURE <l_imp_orgid>
            TO <l_field_org>.
        IF sy-subrc <> 0.
          ASSIGN COMPONENT 'UEBOR' OF STRUCTURE <l_imp_orgid>
              TO <l_field_org>.
          IF sy-subrc <> 0.
            ASSIGN COMPONENT 'UNTOR' OF STRUCTURE <l_imp_orgid>
                TO <l_field_org>.
            IF sy-subrc <> 0.
              ASSIGN COMPONENT 'LOW' OF STRUCTURE <l_imp_orgid>
                  TO <l_field_org>.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
      CHECK sy-subrc = 0.
      ls_orgid-orgid = <l_field_org>.
      CHECK ls_orgid-orgid IS NOT INITIAL.
      APPEND ls_orgid TO lt_orgid.
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
      REFRESH lt_tn10h.
      lt_orgid_om[] = lt_orgid[].
      CALL FUNCTION 'ISH_OM_ORG_HRCHY_LEVEL_DOWN'
        EXPORTING
          i_upper_orgid  = i_orgid
          it_orgid       = lt_orgid_om
          i_begdt        = i_begdt
          i_enddt        = i_enddt
          i_read_db      = i_read_db
        IMPORTING
          et_tn10h       = lt_tn10h
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
      ELSE.
        APPEND LINES OF lt_tn10h TO et_tn10h.
      ENDIF.
    ENDIF.
    IF i_above = on.
      REFRESH lt_tn10h.
      lt_orgid_om[] = lt_orgid[].
      CALL FUNCTION 'ISH_OM_ORG_HRCHY_LEVEL_UP'
        EXPORTING
          i_lower_orgid  = i_orgid
          it_orgid       = lt_orgid_om
          i_begdt        = i_begdt
          i_enddt        = i_enddt
          i_read_db      = i_read_db
        IMPORTING
          et_tn10h       = lt_tn10h
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
      ELSE.
        APPEND LINES OF lt_tn10h TO et_tn10h.
      ENDIF.
    ENDIF.

  ELSE.

    IF i_orgid IS INITIAL AND lt_orgid[] IS INITIAL.
      SELECT * FROM tn10h INTO TABLE et_tn10h
             WHERE ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
                OR   ( begdt = '00000000'
                AND    enddt = '00000000' ) ).
    ELSE.
      IF i_below = on.
        IF i_orgid IS NOT INITIAL.
          SELECT * FROM tn10h INTO TABLE et_tn10h
                 WHERE  uebor  = i_orgid
                 AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
                    OR ( begdt = '00000000'
                    AND  enddt = '00000000' ) ).
        ELSE.
          SELECT * FROM tn10h INTO TABLE et_tn10h
                 FOR ALL ENTRIES IN lt_orgid
                 WHERE  uebor  = lt_orgid-orgid
                 AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
                    OR ( begdt = '00000000'
                    AND  enddt = '00000000' ) ).
        ENDIF.
      ENDIF.
      IF i_above = on.
        IF i_orgid IS NOT INITIAL.
          SELECT * FROM tn10h APPENDING TABLE et_tn10h
                 WHERE  untor  = i_orgid
                 AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
                    OR ( begdt = '00000000'
                    AND  enddt = '00000000' ) ).
        ELSE.
          SELECT * FROM tn10h APPENDING TABLE et_tn10h
                 FOR ALL ENTRIES IN lt_orgid
                 WHERE  untor  = lt_orgid-orgid
                 AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
                    OR ( begdt = '00000000'
                    AND  enddt = '00000000' ) ).
        ENDIF.
      ENDIF.
    ENDIF.

  ENDIF.

ENDMETHOD.
ENDCLASS.
