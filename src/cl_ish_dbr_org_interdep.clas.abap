class CL_ISH_DBR_ORG_INTERDEP definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_DBR_ORG_INTERDEP
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

  class-methods GET_T_ORG_INTERDEP_DOWN
    importing
      value(I_ORGBE) type ORGID optional
      !IT_ORGBE type STANDARD TABLE optional
      !IT_ORGBE_RANGE type ISH_T_R_ORGUNIT optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_BEGDT) type SY-DATUM default SY-DATUM
      value(I_ENDDT) type SY-DATUM default SY-DATUM
      value(I_FIELDNAME_ORGBE) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_TN10I) type ISHMED_T_TN10I
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_ORG_INTERDEP_UP
    importing
      value(I_ORGIN) type ORGID optional
      !IT_ORGIN type STANDARD TABLE optional
      !IT_ORGIN_RANGE type ISH_T_R_ORGUNIT optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_BEGDT) type SY-DATUM default SY-DATUM
      value(I_ENDDT) type SY-DATUM default SY-DATUM
      value(I_FIELDNAME_ORGIN) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_TN10I) type ISHMED_T_TN10I
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_ORG_INTERDEP
    importing
      value(I_ORGIN) type ORGID optional
      value(I_ORGBE) type ORGID optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_BEGDT) type SY-DATUM default SY-DATUM
      value(I_ENDDT) type SY-DATUM default SY-DATUM
    exporting
      value(ET_TN10I) type ISHMED_T_TN10I
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DBR_PAT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DBR_ORG_INTERDEP
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBR_ORG_INTERDEP IMPLEMENTATION.


METHOD get_t_org_interdep.

  DATA: l_status               TYPE ish_on_off.

  e_rc = 0.

  REFRESH: et_tn10i.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Check SAP OM Switch
  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status   = l_status
    EXCEPTIONS
      not_active = 0.

  IF l_status EQ on.

    CALL FUNCTION 'ISH_OM_INTERDEP_GET'
      EXPORTING
        i_lower_orgid  = i_orgin
        i_upper_orgid  = i_orgbe
        i_begdt        = i_begdt
        i_enddt        = i_enddt
        i_read_db      = i_read_db
      IMPORTING
        et_tn10i       = et_tn10i
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
    ENDIF.

  ELSE.

    IF i_orgin IS NOT INITIAL AND i_orgbe IS NOT INITIAL.
      IF i_begdt IS NOT INITIAL AND i_enddt IS NOT INITIAL.
        SELECT * FROM tn10i INTO TABLE et_tn10i
          WHERE  orgin  = i_orgin
            AND  orgbe  = i_orgbe
            AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
             OR ( begdt = '00000000'
             AND  enddt = '00000000' ) ).
      ELSE.
        SELECT * FROM tn10i INTO TABLE et_tn10i
          WHERE  orgin  = i_orgin
            AND  orgbe  = i_orgbe.
      ENDIF.
    ELSEIF i_orgin IS INITIAL AND i_orgbe IS INITIAL.
      SELECT * FROM tn10i INTO TABLE et_tn10i
        WHERE ( begdt <= i_enddt  AND  enddt >= i_begdt )
           OR ( begdt = '00000000'
           AND  enddt = '00000000' ).
    ELSEIF i_orgin IS NOT INITIAL AND i_enddt IS INITIAL.
      SELECT * FROM tn10i INTO TABLE et_tn10i
        WHERE  orgin  = i_orgin
          AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
           OR ( begdt = '00000000'
           AND  enddt = '00000000' ) ).
    ELSEIF i_orgin IS INITIAL AND i_enddt IS NOT INITIAL.
      SELECT * FROM tn10i INTO TABLE et_tn10i
        WHERE  orgbe  = i_orgbe
          AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
           OR ( begdt = '00000000'
           AND  enddt = '00000000' ) ).
    ENDIF.

  ENDIF.

ENDMETHOD.


METHOD get_t_org_interdep_down.

  DATA: lt_orgbe               TYPE ishmed_t_orgid,
        ls_orgbe               LIKE LINE OF lt_orgbe,
        lt_orgid_om            TYPE ish_t_ishid,
        lt_orgbe_range         TYPE rnrangeishid_t,
        ls_orgbe_range         LIKE LINE OF lt_orgbe_range,
        ls_oe_range            LIKE LINE OF it_orgbe_range,
        l_status               TYPE ish_on_off,
        l_data                 TYPE REF TO data.

  FIELD-SYMBOLS: <l_field_org> TYPE any,
                 <l_imp_orgid> TYPE any.

  e_rc = 0.

  REFRESH: et_tn10i, lt_orgbe, lt_orgbe_range.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF i_orgbe IS INITIAL AND it_orgbe[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_orgbe.
    ASSIGN l_data->* TO <l_imp_orgid>.
    LOOP AT it_orgbe INTO <l_imp_orgid>.
      sy-subrc = 4.
      IF i_fieldname_orgbe IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_orgbe OF STRUCTURE <l_imp_orgid>
            TO <l_field_org>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'ORGID' OF STRUCTURE <l_imp_orgid>
            TO <l_field_org>.
        IF sy-subrc <> 0.
          ASSIGN COMPONENT 'ORGBE' OF STRUCTURE <l_imp_orgid>
              TO <l_field_org>.
          IF sy-subrc <> 0.
            ASSIGN COMPONENT 'ORGIN' OF STRUCTURE <l_imp_orgid>
                TO <l_field_org>.
            IF sy-subrc <> 0.
              ASSIGN COMPONENT 'LOW' OF STRUCTURE <l_imp_orgid>
                  TO <l_field_org>.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
      CHECK sy-subrc = 0.
      ls_orgbe-orgid = <l_field_org>.
      CHECK ls_orgbe-orgid IS NOT INITIAL.
      APPEND ls_orgbe TO lt_orgbe.
    ENDLOOP.
  ENDIF.

* Check SAP OM Switch
  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status   = l_status
    EXCEPTIONS
      not_active = 0.

  IF l_status EQ on.

    IF it_orgbe_range[] IS NOT INITIAL.
      LOOP AT it_orgbe_range INTO ls_oe_range.
        ls_orgbe_range = ls_oe_range.
        APPEND ls_orgbe_range TO lt_orgbe_range.
      ENDLOOP.
    ENDIF.

    lt_orgid_om[] = lt_orgbe[].
    CALL FUNCTION 'ISH_OM_INTERDEP_LEVEL_DOWN'
      EXPORTING
        i_upper_orgid  = i_orgbe
        it_orgid       = lt_orgid_om
        itr_orgid      = lt_orgbe_range
        i_begdt        = i_begdt
        i_enddt        = i_enddt
        i_read_db      = i_read_db
      IMPORTING
        et_tn10i       = et_tn10i
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
    ENDIF.

  ELSE.

    IF i_orgbe IS NOT INITIAL.
      SELECT * FROM tn10i INTO TABLE et_tn10i
             WHERE  orgbe  = i_orgbe
             AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
                OR ( begdt = '00000000'
                AND  enddt = '00000000' ) ).
    ELSEIF it_orgbe_range IS NOT INITIAL.
      SELECT * FROM tn10i INTO TABLE et_tn10i
             WHERE  orgbe  IN it_orgbe_range
             AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
                OR ( begdt = '00000000'
                AND  enddt = '00000000' ) ).
    ELSE.
      SELECT * FROM tn10i INTO TABLE et_tn10i
             FOR ALL ENTRIES IN lt_orgbe
             WHERE  orgbe  = lt_orgbe-orgid
             AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
                OR ( begdt = '00000000'
                AND  enddt = '00000000' ) ).
    ENDIF.

  ENDIF.

ENDMETHOD.


METHOD get_t_org_interdep_up.

  DATA: lt_orgin               TYPE ishmed_t_orgid,
        ls_orgin               LIKE LINE OF lt_orgin,
        lt_orgid_om            TYPE ish_t_ishid,
        lt_orgin_range         TYPE rnrangeishid_t,
        ls_orgin_range         LIKE LINE OF lt_orgin_range,
        ls_oe_range            LIKE LINE OF it_orgin_range,
        l_status               TYPE ish_on_off,
        l_data                 TYPE REF TO data.

  FIELD-SYMBOLS: <l_field_org> TYPE any,
                 <l_imp_orgid> TYPE any.

  e_rc = 0.

  REFRESH: et_tn10i, lt_orgin, lt_orgin_range.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF i_orgin IS INITIAL AND it_orgin[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_orgin.
    ASSIGN l_data->* TO <l_imp_orgid>.
    LOOP AT it_orgin INTO <l_imp_orgid>.
      sy-subrc = 4.
      IF i_fieldname_orgin IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_orgin OF STRUCTURE <l_imp_orgid>
            TO <l_field_org>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'ORGID' OF STRUCTURE <l_imp_orgid>
            TO <l_field_org>.
        IF sy-subrc <> 0.
          ASSIGN COMPONENT 'ORGIN' OF STRUCTURE <l_imp_orgid>
              TO <l_field_org>.
          IF sy-subrc <> 0.
            ASSIGN COMPONENT 'ORGBE' OF STRUCTURE <l_imp_orgid>
                TO <l_field_org>.
            IF sy-subrc <> 0.
              ASSIGN COMPONENT 'LOW' OF STRUCTURE <l_imp_orgid>
                  TO <l_field_org>.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
      CHECK sy-subrc = 0.
      ls_orgin-orgid = <l_field_org>.
      CHECK ls_orgin-orgid IS NOT INITIAL.
      APPEND ls_orgin TO lt_orgin.
    ENDLOOP.
  ENDIF.

* Check SAP OM Switch
  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status   = l_status
    EXCEPTIONS
      not_active = 0.

  IF l_status EQ on.

    IF it_orgin_range[] IS NOT INITIAL.
      LOOP AT it_orgin_range INTO ls_oe_range.
        ls_orgin_range = ls_oe_range.
        APPEND ls_orgin_range TO lt_orgin_range.
      ENDLOOP.
    ENDIF.

    lt_orgid_om[] = lt_orgin[].
    CALL FUNCTION 'ISH_OM_INTERDEP_LEVEL_UP'
      EXPORTING
        i_lower_orgid  = i_orgin
        it_orgid       = lt_orgid_om
        itr_orgid      = lt_orgin_range
        i_begdt        = i_begdt
        i_enddt        = i_enddt
        i_read_db      = i_read_db
      IMPORTING
        et_tn10i       = et_tn10i
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
    ENDIF.

  ELSE.

    IF i_orgin IS NOT INITIAL.
      SELECT * FROM tn10i INTO TABLE et_tn10i
             WHERE  orgin  = i_orgin
             AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
                OR ( begdt = '00000000'
                AND  enddt = '00000000' ) ).
    ELSEIF it_orgin_range IS NOT INITIAL.
      SELECT * FROM tn10i INTO TABLE et_tn10i
             WHERE  orgin  IN it_orgin_range
             AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
                OR ( begdt = '00000000'
                AND  enddt = '00000000' ) ).
    ELSE.
      SELECT * FROM tn10i INTO TABLE et_tn10i
             FOR ALL ENTRIES IN lt_orgin
             WHERE  orgin  = lt_orgin-orgid
             AND ( ( begdt <= i_enddt  AND  enddt >= i_begdt )
                OR ( begdt = '00000000'
                AND  enddt = '00000000' ) ).
    ENDIF.

  ENDIF.

ENDMETHOD.
ENDCLASS.
