class CL_ISH_DBR_BAU_ORG definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_DBR_BAU_ORG
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

  class-methods GET_T_BAU_BELOW_ORG
    importing
      value(I_ORGID) type ORGID optional
      !IT_ORGID type STANDARD TABLE optional
      !IT_ORGID_RANGE type ISH_T_R_ORGUNIT optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_BEGDT) type SY-DATUM default SY-DATUM
      value(I_ENDDT) type SY-DATUM default SY-DATUM
      value(I_FIELDNAME_ORGID) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_TN11O) type ISHMED_T_TN11O
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_BAU_ORG
    importing
      value(I_BAUID) type BAUID optional
      value(I_ORGID) type ORGID optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_BEGDT) type SY-DATUM default SY-DATUM
      value(I_ENDDT) type SY-DATUM default SY-DATUM
    exporting
      value(ET_TN11O) type ISHMED_T_TN11O
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_ORG_ABOVE_BAU
    importing
      value(I_BAUID) type BAUID optional
      !IT_BAUID type STANDARD TABLE optional
      !IT_BAUID_RANGE type ISH_T_R_BAUID optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_BEGDT) type SY-DATUM default SY-DATUM
      value(I_ENDDT) type SY-DATUM default SY-DATUM
      value(I_FIELDNAME_BAUID) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_TN11O) type ISHMED_T_TN11O
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DBR_PAT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DBR_BAU_ORG
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBR_BAU_ORG IMPLEMENTATION.


METHOD get_t_bau_below_org.

  DATA: lt_orgid               TYPE ishmed_t_orgid,
        ls_orgid               LIKE LINE OF lt_orgid,
        lt_orgid_om            TYPE ishmed_t_ishid,
        l_status               TYPE ish_on_off,
        l_data                 TYPE REF TO data.

  FIELD-SYMBOLS: <l_field_org> TYPE any,
                 <l_imp_orgid> TYPE any.

  e_rc = 0.

  REFRESH: et_tn11o, lt_orgid.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF i_orgid IS INITIAL AND it_orgid[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_orgid.
    ASSIGN l_data->* TO <l_imp_orgid>.
    LOOP AT it_orgid INTO <l_imp_orgid>.
      sy-subrc = 4.
      IF i_fieldname_orgid IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_orgid OF STRUCTURE <l_imp_orgid>
            TO <l_field_org>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'ORGID' OF STRUCTURE <l_imp_orgid>
            TO <l_field_org>.
        IF sy-subrc <> 0.
          ASSIGN COMPONENT 'LOW' OF STRUCTURE <l_imp_orgid>
              TO <l_field_org>.
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

    lt_orgid_om[] = lt_orgid[].
    CALL FUNCTION 'ISH_OM_BU_ASSIGNED_TO_OU_GET'
      EXPORTING
        i_orgid        = i_orgid
        it_orgid       = lt_orgid_om
        itr_orgid      = it_orgid_range
        i_enddt        = i_enddt
        i_begdt        = i_begdt
        i_read_db      = i_read_db
      IMPORTING
        et_tn11o       = et_tn11o
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

    IF i_begdt IS NOT INITIAL AND i_enddt IS NOT INITIAL.
      IF i_orgid IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               WHERE  orgid  = i_orgid
                 AND  begdt <= i_enddt
                 AND  enddt >= i_begdt.
      ELSEIF it_orgid_range IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               WHERE  orgid  IN it_orgid_range
                 AND  begdt <= i_enddt
                 AND  enddt >= i_begdt.
      ELSE.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               FOR ALL ENTRIES IN lt_orgid
               WHERE  orgid  = lt_orgid-orgid
                 AND  begdt <= i_enddt
                 AND  enddt >= i_begdt.
      ENDIF.
    ELSE.
      IF i_orgid IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               WHERE  orgid  = i_orgid.
      ELSEIF it_orgid_range IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               WHERE  orgid  IN it_orgid_range.
      ELSE.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               FOR ALL ENTRIES IN lt_orgid
               WHERE  orgid  = lt_orgid-orgid.
      ENDIF.
    ENDIF.

  ENDIF.

ENDMETHOD.


METHOD get_t_bau_org.

  DATA: l_status   TYPE ish_on_off.

  e_rc = 0.

  REFRESH: et_tn11o.

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

    CALL FUNCTION 'ISH_OM_BU_OU_ASSIGNMENT_GET'
      EXPORTING
        i_orgid        = i_orgid
        i_bauid        = i_bauid
        i_enddt        = i_enddt
        i_begdt        = i_begdt
        i_read_db      = i_read_db
      IMPORTING
        et_tn11o       = et_tn11o
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

    IF i_bauid IS NOT INITIAL AND i_orgid IS NOT INITIAL.
      IF i_begdt IS NOT INITIAL AND i_enddt IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
          WHERE  bauid  = i_bauid
            AND  orgid  = i_orgid
            AND  begdt <= i_enddt
            AND  enddt >= i_begdt.
      ELSE.
        SELECT * FROM tn11o INTO TABLE et_tn11o
          WHERE  bauid  = i_bauid
            AND  orgid  = i_orgid.
      ENDIF.
    ELSEIF i_bauid IS INITIAL AND i_orgid IS NOT INITIAL.
      IF i_begdt IS NOT INITIAL AND i_enddt IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
          WHERE  orgid  = i_orgid
            AND  begdt <= i_enddt
            AND  enddt >= i_begdt.
      ELSE.
        SELECT * FROM tn11o INTO TABLE et_tn11o
          WHERE  orgid  = i_orgid.
      ENDIF.
    ELSEIF i_bauid IS NOT INITIAL AND i_orgid IS INITIAL.
      IF i_begdt IS NOT INITIAL AND i_enddt IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
          WHERE  bauid  = i_bauid
            AND  begdt <= i_enddt
            AND  enddt >= i_begdt.
      ELSE.
        SELECT * FROM tn11o INTO TABLE et_tn11o
          WHERE  bauid  = i_bauid.
      ENDIF.
    ELSE.
      IF i_begdt IS NOT INITIAL AND i_enddt IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
          WHERE  begdt <= i_enddt
            AND  enddt >= i_begdt.
      ELSE.
        SELECT * FROM tn11o INTO TABLE et_tn11o.
      ENDIF.
    ENDIF.

  ENDIF.

ENDMETHOD.


METHOD get_t_org_above_bau.

  DATA: lt_bauid               TYPE ishmed_t_bauid,
        ls_bauid               LIKE LINE OF lt_bauid,
        lt_bauid_om            TYPE ishmed_t_ishid,
        l_status               TYPE ish_on_off,
        l_data                 TYPE REF TO data.

  FIELD-SYMBOLS: <l_field_bau> TYPE any,
                 <l_imp_bauid> TYPE any.

  e_rc = 0.

  REFRESH: et_tn11o, lt_bauid.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF i_bauid IS INITIAL AND it_bauid[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_bauid.
    ASSIGN l_data->* TO <l_imp_bauid>.
    LOOP AT it_bauid INTO <l_imp_bauid>.
      sy-subrc = 4.
      IF i_fieldname_bauid IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_bauid OF STRUCTURE <l_imp_bauid>
            TO <l_field_bau>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'BAUID' OF STRUCTURE <l_imp_bauid>
            TO <l_field_bau>.
        IF sy-subrc <> 0.
          ASSIGN COMPONENT 'ZIMMR' OF STRUCTURE <l_imp_bauid>
              TO <l_field_bau>.
          IF sy-subrc <> 0.
            ASSIGN COMPONENT 'LOW' OF STRUCTURE <l_imp_bauid>
                TO <l_field_bau>.
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

    lt_bauid_om[] = lt_bauid[].
    CALL FUNCTION 'ISH_OM_OU_ASSIGNED_TO_BU_GET'
      EXPORTING
        i_bauid        = i_bauid
        it_bauid       = lt_bauid_om
        itr_bauid      = it_bauid_range
        i_enddt        = i_enddt
        i_begdt        = i_begdt
        i_read_db      = i_read_db
      IMPORTING
        et_tn11o       = et_tn11o
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

    IF i_begdt IS NOT INITIAL AND i_enddt IS NOT INITIAL.
      IF i_bauid IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               WHERE  bauid  = i_bauid
                 AND  begdt <= i_enddt
                 AND  enddt >= i_begdt.
      ELSEIF it_bauid_range IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               WHERE  bauid  IN it_bauid_range
                 AND  begdt <= i_enddt
                 AND  enddt >= i_begdt.
      ELSE.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               FOR ALL ENTRIES IN lt_bauid
               WHERE  bauid  = lt_bauid-bauid
                 AND  begdt <= i_enddt
                 AND  enddt >= i_begdt.
      ENDIF.
    ELSE.
      IF i_bauid IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               WHERE  bauid  = i_bauid.
      ELSEIF it_bauid_range IS NOT INITIAL.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               WHERE  bauid  IN it_bauid_range.
      ELSE.
        SELECT * FROM tn11o INTO TABLE et_tn11o
               FOR ALL ENTRIES IN lt_bauid
               WHERE  bauid  = lt_bauid-bauid.
      ENDIF.
    ENDIF.
  ENDIF.

ENDMETHOD.
ENDCLASS.
