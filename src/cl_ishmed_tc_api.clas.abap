class CL_ISHMED_TC_API definition
  public
  final
  create protected .

public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISHMED_TC_CONSTANT_DEF .

  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases RESP_TYPE_CASE
    for IF_ISHMED_TC_CONSTANT_DEF~CO_RESP_TYPE_CASE .
  aliases RESP_TYPE_PATIENT
    for IF_ISHMED_TC_CONSTANT_DEF~CO_RESP_TYPE_PATIENT .
  aliases RESP_TYPE_SPECIAL
    for IF_ISHMED_TC_CONSTANT_DEF~CO_RESP_TYPE_SPECIAL .
  aliases SECURITY_LEVEL_LIVE_GRANT
    for IF_ISHMED_TC_CONSTANT_DEF~CO_S_LEVEL_LIVE_GRANT .
  aliases SECURITY_LEVEL_LIVE_PROHIBITED
    for IF_ISHMED_TC_CONSTANT_DEF~CO_S_LEVEL_LIVE_PROHIBITED .
  aliases SECURITY_LEVEL_OFF
    for IF_ISHMED_TC_CONSTANT_DEF~CO_S_LEVEL_OFF .
  aliases SECURITY_LEVEL_TEST_GRANT
    for IF_ISHMED_TC_CONSTANT_DEF~CO_S_LEVEL_TEST_GRANT .
  aliases SECURITY_LEVEL_TEST_PROHIBITED
    for IF_ISHMED_TC_CONSTANT_DEF~CO_S_LEVEL_TEST_PROHIBITED .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .

  class-methods CHECK_AUTHORITY_TEST_ADMIN
    importing
      !I_INSTITUTION_ID type EINRI
    raising
      CX_ISHMED_TC_AUTHORITY .
  class-methods CHECK_AUTHORITY_DELEGATION
    importing
      !I_INSTITUTION_ID type EINRI
    raising
      CX_ISHMED_TC_AUTHORITY .
  class-methods CHECK_AUTHORITY_REPORTING
    importing
      !I_INSTITUTION_ID type EINRI
    raising
      CX_ISHMED_TC_AUTHORITY .
  class-methods CLASS_CONSTRUCTOR .
  class-methods LOAD
    importing
      !I_INSTITUTION_ID type EINRI
    returning
      value(RR_API) type ref to CL_ISHMED_TC_API
    raising
      CX_ISHMED_TC .
  methods CHECK
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR optional
      !I_DIALOG_MODE type ISH_ON_OFF default CL_ISHMED_TC_API=>ON
      !IS_LOG_INFO type RN1TC_LOG_INFO optional
    exporting
      !E_TC_EXIST type ISH_TRUE_FALSE
      !E_TC_REQUEST_POSSIBLE type ISH_TRUE_FALSE
      !ES_MESSAGE type BAPIRET2
    raising
      CX_ISHMED_TC .
  methods CHECK_IN_LIST
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR optional
      !IS_LOG_INFO type RN1TC_LOG_INFO optional
    returning
      value(R_TC_EXIST) type ISH_TRUE_FALSE
    raising
      CX_ISHMED_TC .
  methods CHECK_PATIENT_PROVISIONAL
    importing
      !I_PATIENT_PROVISIONAL_ID type ISH_PAPID
    exporting
      !E_TC_EXIST type ISH_TRUE_FALSE
      !ES_MESSAGE type BAPIRET2
    raising
      CX_ISHMED_TC .
  methods CONSTRUCTOR
    importing
      !I_INSTITUTION_ID type EINRI
    raising
      CX_ISHMED_TC .
  methods GET_MATRIX
    exporting
      !ET_TC_MATRIX type RN1TC_MATRIX_T .
  methods IS_ACTIVE_FOR_USER
    returning
      value(R_VALUE) type ISH_TRUE_FALSE .
  methods REFRESH .
  methods REQUEST_DELEGATION
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR
      !I_UNAME type XUBNAME
    raising
      CX_ISHMED_TC_DELEGATION_CANCEL
      CX_ISHMED_TC_AUTHORITY
      CX_ISHMED_TC .
  methods REQUEST_TC
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR
      !IS_LOG_INFO type RN1TC_LOG_INFO optional
      !I_DIALOG_MODE type ISH_ON_OFF default CL_ISHMED_TC_API=>ON
      !I_REASON1 type N1TC_REASON optional
      !I_VIP type VIPKZ optional
      !I_EMERGENCY type N1TC_EMERGENCY_REQUEST optional
    raising
      CX_ISHMED_TC_REQUEST_CANCELED
      CX_ISHMED_TC .
  methods SAVE .
  methods REINIT_FOR_TEST .
  methods SET_GLOB_SETTINGS_FOR_TEST
    importing
      !I_SECURITY_LEVEL type N1TC_SECURITY_LEVEL default SECURITY_LEVEL_OFF
      !I_DECAY_TIME type N1TC_DECAY_TIME default 0
      !I_UNAME type XUBNAME default SY-UNAME .
  methods IS_ACTIVE
    returning
      value(R_ACTIVE) type ISH_TRUE_FALSE .
protected section.

  data GT_EVENT_SAVE type ISHMED_T_EVENT .

  methods ADD_EVENTS .
  methods RAISE_EVENTS_AFTER_COMMIT .
private section.

  aliases COMPONENT_ISH
    for IF_ISHMED_TC_CONSTANT_DEF~CO_COMPONENT_ISH .
  aliases COMPONENT_ISHMED
    for IF_ISHMED_TC_CONSTANT_DEF~CO_COMPONENT_ISHMED .
  aliases TC_TYPE_NORMAL
    for IF_ISHMED_TC_CONSTANT_DEF~CO_TC_TYPE_NORMAL .
  aliases TC_TYPE_TEMPORARY
    for IF_ISHMED_TC_CONSTANT_DEF~CO_TC_TYPE_TEMPORARY .

  types:
    BEGIN OF lty_rn1tc_buffer,
           institution_id   TYPE einri,
           patient_id       TYPE patnr,
           case_id          TYPE falnr,
           uname            TYPE xubname,
           insert_date      TYPE ri_erdat,
           insert_time      TYPE ri_ertim,
           tc_type          TYPE n1tc_type,
           resp_type        TYPE n1tc_ou_resp_type,
           request_id       TYPE n1tc_request_id,
           exist            TYPE ish_true_false,
           request_possible TYPE ish_true_false,
           dialog_mode      type ish_on_off,     "MED-49016
         END OF lty_rn1tc_buffer .
  types:
    lty_rn1tc_buffer_t TYPE STANDARD TABLE OF lty_rn1tc_buffer .
  types:
    BEGIN OF lty_rn1tc_prov_buffer,
           institution_id  TYPE einri,
           patient_prov_id TYPE ish_papid,
           uname           TYPE xubname,
           insert_date     TYPE ri_erdat,
           insert_time     TYPE ri_ertim,
           exist           TYPE ish_true_false,
         END OF lty_rn1tc_prov_buffer .
  types:
    lty_rn1tc_prov_buffer_t TYPE STANDARD TABLE OF lty_rn1tc_prov_buffer .

  class-data GR_API type ref to CL_ISHMED_TC_API .
  data GT_MATRIX type RN1TC_MATRIX_T .
  class-data G_REFERENCE_DAY type DATS .
  class-data G_SECURITY_LEVEL type N1TC_SECURITY_LEVEL value SECURITY_LEVEL_OFF ##NO_TEXT.
  data GT_TC_PROV_BUFFER type LTY_RN1TC_PROV_BUFFER_T .
  data GT_TC_BUFFER_TEST type LTY_RN1TC_BUFFER_T .
  data GT_TC_BUFFER type LTY_RN1TC_BUFFER_T .
  class-data G_INSTITUTION_ID type EINRI .
  data:
    gt_access_log TYPE TABLE OF n1tc_access_log .
  class-data G_DECAYTIME type N1TC_DECAY_TIME value 0 ##NO_TEXT.
  data:
    gt_buffer_db TYPE TABLE OF n1tc_buffer .
  data:
    gt_prov_buffer_db TYPE TABLE OF n1tc_buffer_pap .
  data:
    gt_tc_request TYPE TABLE OF n1tc_request .
  data GS_REQUEST type RN1TC_REQUEST_DB .
  class-data G_NO_CLEAR_BUFFER type N1TC_NO_CLEAR_BUFFER .

  methods CHECK_PAT_PROV_TC_INTERNAL
    importing
      !I_PATIENT_PROVISIONAL_ID type ISH_PAPID
    exporting
      !E_TC_EXIST type ISH_TRUE_FALSE
    raising
      CX_ISHMED_TC .
  methods CHECK_TC_FROM_BUFFER_TEST
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR
      !IS_LOG_INFO type RN1TC_LOG_INFO optional
    exporting
      !E_TC_BUFFER_READ type ISH_ON_OFF
      !E_TC_EXIST type ISH_TRUE_FALSE
      !E_TC_REQUEST_POSSIBLE type ISH_TRUE_FALSE .
  methods CHECK_TC_FROM_BUFFER
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR
      !IS_LOG_INFO type RN1TC_LOG_INFO optional
      !I_DIALOG_MODE type ISH_ON_OFF default CL_ISHMED_TC_API=>OFF
    exporting
      !E_TC_BUFFER_READ type ISH_ON_OFF
      !E_TC_EXIST type ISH_TRUE_FALSE
      !E_TC_REQUEST_POSSIBLE type ISH_TRUE_FALSE .
  methods CHECK_TC_FROM_DB_BUFFER
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR optional
      !IS_LOG_INFO type RN1TC_LOG_INFO optional
    returning
      value(R_TC_EXIST) type ISH_TRUE_FALSE .
  methods CHECK_TC_FROM_PROV_BUFFER
    importing
      !I_PATIENT_PROVISIONAL_ID type ISH_PAPID
    exporting
      !E_TC_BUFFER_READ type ISH_ON_OFF
      !E_TC_EXIST type ISH_TRUE_FALSE .
  methods CHECK_TC_FROM_PROV_DB_BUFFER
    importing
      !I_PATIENT_PROVISIONAL_ID type ISH_PAPID
    returning
      value(R_TC_EXIST) type ISH_TRUE_FALSE .
  methods CHECK_TC_FROM_REQUEST
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR optional
      !IS_LOG_INFO type RN1TC_LOG_INFO optional
    returning
      value(R_TC_EXIST) type ISH_TRUE_FALSE .
  methods CHECK_TC_INTERNAL
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR optional
    exporting
      !E_TC_REQUEST_POSSIBLE type ISH_TRUE_FALSE
      !E_TC_EXIST type ISH_TRUE_FALSE
      !E_RESP_TYPE type N1TC_OU_RESP_TYPE
    raising
      CX_ISHMED_TC .
  methods SET_TC_TO_BUFFER_TEST
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR
      !I_TC_TYPE type N1TC_TYPE
      !I_REQUEST_ID type N1TC_REQUEST_ID
      !I_RESP_TYPE type N1TC_OU_RESP_TYPE
      !I_EXIST type ISH_TRUE_FALSE
      !I_REQUEST_POSSIBLE type ISH_TRUE_FALSE
      !I_TO_DB type ISH_ON_OFF default ON .
  methods SET_TC_TO_BUFFER
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR
      !I_TC_TYPE type N1TC_TYPE
      !I_REQUEST_ID type N1TC_REQUEST_ID
      !I_RESP_TYPE type N1TC_OU_RESP_TYPE
      !I_EXIST type ISH_TRUE_FALSE
      !I_REQUEST_POSSIBLE type ISH_TRUE_FALSE
      !I_TO_DB type ISH_ON_OFF default ON
      !I_DIALOG_MODE type ISH_ON_OFF default CL_ISHMED_TC_API=>OFF .
  methods SET_TC_TO_PROV_BUFFER
    importing
      !I_PATIENT_PROVISIONAL_ID type ISH_PAPID
      !I_TC_TYPE type N1TC_TYPE default TC_TYPE_NORMAL
      !I_REQUEST_ID type N1TC_REQUEST_ID optional
      !I_EXIST type ISH_TRUE_FALSE
      !I_TO_DB type ISH_ON_OFF default ON .
  methods TIME_EXPIRED_TEST
    importing
      !I_INSERT_DATE type RI_ERDAT
      !I_INSERT_TIME type RI_ERTIM
    returning
      value(R_EXPIRED) type ISH_TRUE_FALSE .
  methods TIME_EXPIRED
    importing
      !I_INSERT_DATE type RI_ERDAT
      !I_INSERT_TIME type RI_ERTIM
    returning
      value(R_EXPIRED) type ISH_TRUE_FALSE .
  methods WRITE_ACCESS_LOG
    importing
      !I_REQUEST_ID type N1TC_REQUEST_ID
      !IS_LOG_INFO type RN1TC_LOG_INFO .
  methods WRITE_TC_DELEGATION
    importing
      !IS_REQUEST type RN1TC_REQUEST_DB
      !IS_LOG_INFO type RN1TC_LOG_INFO optional .
  methods WRITE_TC_REQUEST
    importing
      !IS_REQUEST type RN1TC_REQUEST_DB
      !IS_LOG_INFO type RN1TC_LOG_INFO optional
      !I_WITH_DB_BUFFER type ISH_ON_OFF default ON .
  methods WRITE_TO_BUFFER_DB
    importing
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR
      !I_TC_TYPE type N1TC_TYPE
      !I_RESP_TYPE type N1TC_OU_RESP_TYPE
      !I_REQUEST_ID type N1TC_REQUEST_ID .
  methods WRITE_TO_PROV_BUFFER_DB
    importing
      !I_PATIENT_PROVISIONAL_ID type ISH_PAPID
      !I_TC_TYPE type N1TC_TYPE
      !I_REQUEST_ID type N1TC_REQUEST_ID optional .
  methods _SAVE_ACCESS_LOG .
  methods _SAVE_BUFFER_DB .
  methods _SAVE_PROV_BUFFER_DB .
  methods _SAVE_TC_REQUEST .
  methods _CHECK_SPECIAL
    returning
      value(R_RESULT) type ISH_TRUE_FALSE .
  methods _DEL_PAT_RESULT_FROM_BUFFER
    importing
      !I_PATIENT_ID type PATNR .
ENDCLASS.



CLASS CL_ISHMED_TC_API IMPLEMENTATION.


  METHOD add_events.
* new method IXX-12373
    DATA: ls_tc_request TYPE n1tc_request,
          ls_tc_ev_data TYPE rn1tc_event_data.

    LOOP AT gt_tc_request INTO ls_tc_request.
      ls_tc_ev_data-tc = ls_tc_request.


      APPEND NEW cl_ishmed_event_tc(  is_tc_ev_data = ls_tc_ev_data
                                             i_evdefid         = cl_ishmed_evappl_tc=>co_evdefid_created
                                             i_repid           = sy-repid )
      TO gt_event_save.
    ENDLOOP.
  ENDMETHOD.


METHOD check.
  DATA l_buffer_read TYPE ish_on_off.
  DATA ls_request    TYPE rn1tc_request_db.
  DATA l_resp_type   TYPE n1tc_ou_resp_type.
  DATA l_message     TYPE string.

*init return value
  e_tc_exist = false.
  e_tc_request_possible = false.
* set default resonsebility typ
  l_resp_type = resp_type_patient.

  CLEAR es_message.

* write log entry
  LOG-POINT ID ish_tc_check SUBKEY '1_MAIN' FIELDS g_institution_id.
  LOG-POINT ID ish_tc_check SUBKEY '1_MAIN' FIELDS i_patient_id.
  LOG-POINT ID ish_tc_check SUBKEY '1_MAIN' FIELDS i_case_id.
  LOG-POINT ID ish_tc_check SUBKEY '1_MAIN' FIELDS g_security_level.
*sec Level dazu

* check if customizing for user/System lead to a TC anyway
  if is_active_for_user( ) = false.
    e_tc_exist = true.
    RETURN.
  ENDIF.

* exclude some internal transaction from TC check, because the TC should be created here
  IF _check_special( ) = true.
*   --------------------------------------------------> exit
    e_tc_exist = true.
    RETURN.
  ENDIF.

* check if the result can be found in the internal memory (Buffer)
*  check_tc_from_buffer( ... )                        REMOVED WITH MED-67292 Note 2611762 Bi

* For the unlikely case that the Security level is change with in a day we have to devide the Buffer
* into test and prod
  IF ( g_security_level = security_level_test_prohibited OR
       g_security_level = security_level_test_grant ).

    check_tc_from_buffer_test(
      EXPORTING
        i_patient_id     = i_patient_id
        i_case_id        = i_case_id
        is_log_info      = is_log_info
      IMPORTING
        e_tc_buffer_read      = l_buffer_read
        e_tc_exist            = e_tc_exist
        e_tc_request_possible = e_tc_request_possible
        ).

    IF l_buffer_read = on.
      e_tc_exist = true.
      RETURN.
    ENDIF.
  ENDIF.

* right now we have not implementet a Shard Memory Objekt --- but you never know
*  e_tc_exist = check_tc_from_smo( i_institution_id = i_institution_id i_patient_id = i_patient_id ).
*  CHECK e_tc_exist = off.

* Check from the persictence buffe (is the TC checked bevor)
  e_tc_exist = check_tc_from_db_buffer( i_patient_id = i_patient_id i_case_id = i_case_id is_log_info = is_log_info ).
  save( ).
  IF e_tc_exist = true.
    l_message = text-203.
*log result
    LOG-POINT ID ish_tc_check SUBKEY '3_DB_BUFFER' FIELDS l_message.
    RETURN.
  ENDIF.

* check if the user make a explicit request for TC
  e_tc_exist = check_tc_from_request( i_patient_id = i_patient_id
                                      i_case_id = i_case_id
                                      is_log_info = is_log_info ).
  save( ).
  IF e_tc_exist = true.
    l_message = text-204.
* log result
    LOG-POINT ID ish_tc_check SUBKEY '4_REQUEST' FIELDS l_message.
    RETURN.
  ENDIF.
*

* now if the check is not done bevore with a valide (positive) result, check the TC by the given
* relationship between the User an the Patient (movement, appointment ...)
  check_tc_internal(
    EXPORTING
      i_patient_id          = i_patient_id    " IS-H: Patientennummer
      i_case_id             = i_case_id    " IS-H: Fallnummer
    IMPORTING
      e_tc_request_possible = e_tc_request_possible    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
      e_tc_exist            = e_tc_exist    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
      e_resp_type           = l_resp_type
  ).

* in dialog mode the dialog should be called automaticly
*  IF e_tc_exist = false AND e_tc_request_possible = true AND i_dialog_mode = on.   " MED-60843 Note 2255594 Bi
  IF e_tc_exist = false AND e_tc_request_possible = true AND i_dialog_mode = on     " MED-60843 Note 2255594 Bi
                        OR i_dialog_mode EQ off AND gs_request IS NOT INITIAL.      " MED-60843 Note 2255594 Bi
* tc can requested
    IF ( g_security_level = security_level_live_prohibited OR
         g_security_level = security_level_live_grant ).

      TRY.
          MOVE-CORRESPONDING gs_request TO ls_request.                              " MED-60843 Note 2255594 Bi
          ls_request-institution_id = g_institution_id.
          ls_request-patient_id = i_patient_id.
          ls_request-case_id = i_case_id.
          ls_request-insert_user = sy-uname.
          ls_request-insert_date = sy-datum.
          ls_request-resp_type   = l_resp_type.
          CLEAR gs_request.                                                         " MED-60843 Note 2255594 Bi

          CALL FUNCTION 'ISHMED_TC_REQUEST_DLG'
            EXPORTING
              i_dialog_mode = i_dialog_mode                                         " MED-60843 Note 2255594 Bi
            CHANGING
              cs_request = ls_request.
        CATCH cx_ishmed_tc_request_canceled.
          set_tc_to_buffer(
              EXPORTING
                i_patient_id = i_patient_id    " IS-H: Patientennummer
                i_case_id    = i_case_id       " IS-H: Fallnummer
                i_tc_type    = tc_type_normal  " Typ des Behandlungsatuftags
                i_resp_type  =  ls_request-resp_type
                i_request_id = ''              " Schlüssel eines Temporären Behandlungsauftrags
                i_exist      = false
                i_request_possible = true
                i_to_db      = false  " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
                i_dialog_mode = i_dialog_mode       "MED-49016
               ).
          e_tc_exist = false.

          es_message-number = '700'.
          es_message-id   = 'N1TC'.
          es_message-type = 'S'.

          MESSAGE ID es_message-id TYPE es_message-type NUMBER es_message-number
               INTO es_message-message
               WITH es_message-message_v1 es_message-message_v2.

* is replaced
*          CALL FUNCTION 'SX_MESSAGE_TEXT_BUILD'
*            EXPORTING
*              msgid               = es_message-id
*              msgnr               = es_message-number
*              msgv1               = es_message-message_v1
*              msgv2               = es_message-message_v2
*            IMPORTING
*              message_text_output = es_message-message.

          save( ).

          l_message = text-205.
          LOG-POINT ID ish_tc_check SUBKEY '6_RESULT' FIELDS l_message.

          RETURN.
      ENDTRY.

* enter the request to internal table (data will be save to db in method save)
      write_tc_request(
        EXPORTING
        is_request       = ls_request
        is_log_info      = is_log_info ).

      e_tc_exist = true.
      l_message = text-206.
      LOG-POINT ID ish_tc_check SUBKEY '6_RESULT' FIELDS l_message.

    ELSE.
* in test mode there is no need for request at all
      e_tc_exist = true.
      IF i_dialog_mode = on.
        IF i_case_id IS INITIAL.
          MESSAGE i012(n1tc) WITH text-100 i_patient_id.
        ELSE.
          MESSAGE i012(n1tc) WITH text-101 i_case_id.
        ENDIF.
        set_tc_to_buffer_test(
          EXPORTING
            i_patient_id = i_patient_id    " IS-H: Patientennummer
            i_case_id    = i_case_id       " IS-H: Fallnummer
            i_tc_type    = tc_type_normal  " Typ des Behandlungsatuftags
            i_resp_type  = l_resp_type
            i_request_id = ''              " Schlüssel eines Temporären Behandlungsauftrags
            i_exist      = e_tc_exist    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
            i_request_possible = e_tc_request_possible ).
      ENDIF.
      l_message = text-207.
      LOG-POINT ID ish_tc_check SUBKEY '6_RESULT' FIELDS l_message.
      RETURN.
    ENDIF.

  ELSEIF e_tc_exist = true.
* TC granted
    set_tc_to_buffer(
      EXPORTING
        i_patient_id = i_patient_id    " IS-H: Patientennummer
        i_case_id    = i_case_id       " IS-H: Fallnummer
        i_tc_type    = tc_type_normal  " Typ des Behandlungsatuftags
        i_resp_type  = l_resp_type
        i_request_id = ''              " Schlüssel eines Temporären Behandlungsauftrags
        i_exist      = true    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
        i_request_possible = e_tc_request_possible
    ).
    l_message = text-208.
    LOG-POINT ID ish_tc_check SUBKEY '6_RESULT' FIELDS l_message.
  ELSE.
* No TC
    IF ( g_security_level = security_level_live_prohibited OR
         g_security_level = security_level_live_grant ).

      set_tc_to_buffer(
        EXPORTING
          i_patient_id = i_patient_id    " IS-H: Patientennummer
          i_case_id    = i_case_id       " IS-H: Fallnummer
          i_tc_type    = tc_type_normal  " Typ des Behandlungsatuftags
          i_resp_type  = l_resp_type
          i_request_id = ''              " Schlüssel eines Temporären Behandlungsauftrags
          i_exist      = false    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
          i_request_possible = e_tc_request_possible
          i_dialog_mode = i_dialog_mode         "MED-49016
      ).
      CLEAR es_message.
      IF e_tc_request_possible = true.
        es_message-number = '010'.
      ELSE.
        es_message-number = '011'.
      ENDIF.
      IF i_case_id IS INITIAL.
        es_message-message_v1 = text-100.
        CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
          EXPORTING
            input  = i_patient_id
          IMPORTING
            output = es_message-message_v2.
      ELSE.
        es_message-message_v1 = text-101.
        CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
          EXPORTING
            input  = i_case_id
          IMPORTING
            output = es_message-message_v2.
      ENDIF.
      es_message-id   = 'N1TC'.
      es_message-type = 'S'.

      MESSAGE ID es_message-id TYPE es_message-type NUMBER es_message-number
           INTO es_message-message
           WITH es_message-message_v1 es_message-message_v2.

* is replaced
*      CALL FUNCTION 'SX_MESSAGE_TEXT_BUILD'
*        EXPORTING
*          msgid               = es_message-id
*          msgnr               = es_message-number
*          msgv1               = es_message-message_v1
*          msgv2               = es_message-message_v2
*        IMPORTING
*          message_text_output = es_message-message.

      l_message = text-209.
      LOG-POINT ID ish_tc_check SUBKEY '6_RESULT' FIELDS l_message.
    ELSE.
* in test mode even a neqative result will be OK
      e_tc_exist = true.
      IF i_dialog_mode = on.
        IF i_case_id IS INITIAL.
          MESSAGE i013(n1tc) WITH text-100 i_patient_id.
        ELSE.
          MESSAGE i013(n1tc) WITH text-101 i_case_id.
        ENDIF.
        set_tc_to_buffer_test(
          EXPORTING
            i_patient_id = i_patient_id    " IS-H: Patientennummer
            i_case_id    = i_case_id       " IS-H: Fallnummer
            i_tc_type    = tc_type_normal  " Typ des Behandlungsatuftags
            i_resp_type  = l_resp_type
            i_request_id = ''              " Schlüssel eines Temporären Behandlungsauftrags
            i_exist      = e_tc_exist    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
            i_request_possible = e_tc_request_possible ).
      ENDIF.
      l_message = text-207.
      LOG-POINT ID ish_tc_check SUBKEY '6_RESULT' FIELDS l_message.
      RETURN.
    ENDIF.
  ENDIF.

  save( ).

ENDMETHOD.


METHOD CHECK_AUTHORITY_DELEGATION.

  AUTHORITY-CHECK OBJECT 'N_TC_DG'
           ID 'N_EINRI' FIELD i_institution_id
           ID 'ACTVT'   FIELD '01'.

  IF sy-subrc = 0.
    RETURN.
  ENDIF.

  RAISE EXCEPTION TYPE cx_ishmed_tc_authority
    EXPORTING
      textid = cx_ishmed_tc_authority=>no_auth_for_delegation.

ENDMETHOD.


METHOD check_authority_reporting.

  AUTHORITY-CHECK OBJECT 'N_EINR_REP'
           ID 'N_EINRI' FIELD i_institution_id
           ID 'REPID'   FIELD 'RN1TC_REPORTING'.

  IF sy-subrc = 0.
    RETURN.
  ENDIF.

  RAISE EXCEPTION TYPE cx_ishmed_tc_authority
    EXPORTING
      textid = cx_ishmed_tc_authority=>no_auth_for_reporting.

ENDMETHOD.


METHOD CHECK_AUTHORITY_TEST_ADMIN.

  AUTHORITY-CHECK OBJECT 'N_TC_DG'
           ID 'N_EINRI' FIELD i_institution_id
           ID 'ACTVT'   FIELD '48'.

  IF sy-subrc = 0.
    RETURN.
  ENDIF.

  RAISE EXCEPTION TYPE cx_ishmed_tc_authority
    EXPORTING
      textid = cx_ishmed_tc_authority=>no_auth_for_delegation.

ENDMETHOD.


METHOD check_in_list.
  DATA l_buffer_read TYPE ish_on_off.
  DATA l_resp_type TYPE n1tc_ou_resp_type.
  data l_tc_request_possible type ish_true_false.

*init return value
  r_tc_exist = false.

* check if TC Security Level is off ->> retun true
  IF g_security_level = security_level_off.
*   --------------------------------------------------> exit
    r_tc_exist = true.
    RETURN.
  ENDIF.

*if Matric empty and level 2 or 4 return true.
  IF lines( gt_matrix ) EQ 0 AND
    ( g_security_level = security_level_test_grant OR
      g_security_level = security_level_live_grant ).
*   --------------------------------------------------> exit
    r_tc_exist = true.
    RETURN.
  ENDIF.

  check_tc_from_buffer(
    EXPORTING
      i_patient_id     = i_patient_id
      i_case_id        = i_case_id
      is_log_info      = is_log_info
    IMPORTING
      e_tc_buffer_read = l_buffer_read
      e_tc_exist       = r_tc_exist
      ).

  CHECK l_buffer_read = off.

* right now we have not implementet a Shard Memory Objekt --- but you never know
*  r_tc_exist = check_tc_from_smo( i_institution_id = i_institution_id i_patient_id = i_patient_id ).
*  CHECK r_tc_exist = off.

  r_tc_exist = check_tc_from_db_buffer( i_patient_id = i_patient_id i_case_id = i_case_id ).
  CHECK r_tc_exist = false.


  r_tc_exist = check_tc_from_request( i_patient_id = i_patient_id
                                      i_case_id = i_case_id
                                      is_log_info = is_log_info ).
  CHECK r_tc_exist = false.


  check_tc_internal(
    EXPORTING
      i_patient_id          = i_patient_id    " IS-H: Patientennummer
      i_case_id             = i_case_id    " IS-H: Fallnummer
    IMPORTING
      e_tc_request_possible = l_tc_request_possible    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
      e_tc_exist            = r_tc_exist    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
      e_resp_type           = l_resp_type
  ).


  set_tc_to_buffer(
     EXPORTING
       i_patient_id = i_patient_id    " IS-H: Patientennummer
       i_case_id    = i_case_id       " IS-H: Fallnummer
       i_tc_type    = tc_type_normal  " Typ des Behandlungsatuftags
       i_resp_type  = l_resp_type
       i_request_id = ''              " Schlüssel eines Temporären Behandlungsauftrags
       i_exist      = r_tc_exist    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
       i_request_possible = l_tc_request_possible
   ).



ENDMETHOD.


METHOD check_patient_provisional.
  DATA l_buffer_read TYPE ish_on_off.
*  DATA ls_request TYPE rn1tc_request_db.
*init return value
  e_tc_exist = false.
*  e_tc_request_possible = false.

  CLEAR es_message.

* check if TC Security Level is off ->> retun true
  IF g_security_level = security_level_off.
*   --------------------------------------------------> exit
    e_tc_exist = true.
    RETURN.
  ENDIF.
*
*if Matric empty and level 2 or 4 return true.
  IF lines( gt_matrix ) EQ 0 AND
    ( g_security_level = security_level_test_grant OR
      g_security_level = security_level_live_grant ).
*   --------------------------------------------------> exit
    e_tc_exist = true.
    RETURN.
  ENDIF.
*
*
  check_tc_from_prov_buffer(
    EXPORTING
      i_patient_provisional_id     = i_patient_provisional_id
    IMPORTING
      e_tc_buffer_read = l_buffer_read
      e_tc_exist       = e_tc_exist
      ).


  IF l_buffer_read = on.
*    l_message = text-202.
*    LOG-POINT ID ish_tc_check SUBKEY '2_BUFFER' FIELDS l_message.
*    LOG-POINT ID ish_tc_check SUBKEY '2_BUFFER' FIELDS e_tc_exist.
    IF e_tc_exist = false. "and i_dialog_mode = on.
      es_message-number = '017'.
      es_message-message_v1 = text-100.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
        EXPORTING
          input  = i_patient_provisional_id
        IMPORTING
          output = es_message-message_v2.
      es_message-id   = 'N1TC'.
      es_message-type = 'S'.
      CALL FUNCTION 'SX_MESSAGE_TEXT_BUILD'
        EXPORTING
          msgid               = es_message-id
          msgnr               = es_message-number
          msgv1               = es_message-message_v1
          msgv2               = es_message-message_v2
        IMPORTING
          message_text_output = es_message-message.
    ENDIF.

    RETURN.
  ENDIF.

  e_tc_exist = check_tc_from_prov_db_buffer( i_patient_provisional_id = i_patient_provisional_id ).
  save( ).
  CHECK e_tc_exist = false.
*
*
  check_pat_prov_tc_internal(
    EXPORTING
      i_patient_provisional_id = i_patient_provisional_id    " IS-H: Patientennummer
    IMPORTING
      e_tc_exist               = e_tc_exist    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
  ).
*
  IF e_tc_exist = true.
    set_tc_to_prov_buffer(
      EXPORTING
        i_patient_provisional_id     = i_patient_provisional_id
        i_exist      = true    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
    ).
  ELSE.
    IF ( g_security_level = security_level_live_prohibited OR
         g_security_level = security_level_live_grant ).
      set_tc_to_prov_buffer(
        EXPORTING
          i_patient_provisional_id     = i_patient_provisional_id
          i_exist      = false    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
      ).
      CLEAR es_message.
      es_message-number = '011'.
      es_message-id   = 'N1TC'.
      es_message-type = 'S'.
      CALL FUNCTION 'SX_MESSAGE_TEXT_BUILD'
        EXPORTING
          msgid               = sy-msgid
          msgnr               = es_message-id
        IMPORTING
          message_text_output = es_message-message.
    ELSE.
      e_tc_exist = true.

      CLEAR es_message.
      es_message-number = '013'.
      es_message-id   = 'N1TC'.
      es_message-type = 'S'.
      CALL FUNCTION 'SX_MESSAGE_TEXT_BUILD'
        EXPORTING
          msgid               = sy-msgid
          msgnr               = es_message-id
        IMPORTING
          message_text_output = es_message-message.
    ENDIF.
  ENDIF.

  save( ).

ENDMETHOD.


METHOD check_pat_prov_tc_internal.
*----------------------------------------------------------
  DATA lr_badi              TYPE REF TO ishmed_tc_check.
*----------------------------------------------------------

*init return value
  e_tc_exist = false.

  TRY.
      IF cl_ishmed_switch_check=>ishmed_main( ) = on.
        GET BADI lr_badi
          FILTERS
            component = component_ishmed.
      ELSE.
        GET BADI lr_badi
          FILTERS
            component = component_ish.
      ENDIF.
    CATCH cx_badi_not_implemented.
      RAISE EXCEPTION TYPE cx_ishmed_tc.
  ENDTRY.

  CHECK lr_badi IS BOUND.

  CALL BADI lr_badi->check_patient_provisional
    EXPORTING
      i_institution_id         = g_institution_id         " IS-H: Einrichtung
      i_patient_provisional_id = i_patient_provisional_id " IS-H: Patientennummer
      it_matrix                = gt_matrix    " Die OE-USER Zuordungsmatrix des Behandlungsauftrages
    IMPORTING
      e_tc_exist               = e_tc_exist.    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')

ENDMETHOD.


METHOD check_tc_from_buffer.
  FIELD-SYMBOLS: <ls_buffer> TYPE lty_rn1tc_buffer.

*init
  e_tc_buffer_read = off.
  e_tc_exist = false.
  e_tc_request_possible = false.

  LOOP AT gt_tc_buffer ASSIGNING <ls_buffer>
    WHERE institution_id = g_institution_id AND
          patient_id = i_patient_id AND
          insert_date = sy-datum.
    IF ( <ls_buffer>-resp_type = resp_type_patient ) OR
       ( i_case_id IS INITIAL AND <ls_buffer>-resp_type = resp_type_case ) OR
       ( <ls_buffer>-case_id EQ i_case_id AND <ls_buffer>-resp_type = resp_type_case ).  "JV 28.07.11
      IF <ls_buffer>-exist = false.
* MED-49016 Beginn
* do to performance issues we save also the neg result for one second in the buffer, but the first dialog request in a LOW has to processs
* under all circumstances
        if i_dialog_mode = on and i_dialog_mode NE <ls_buffer>-dialog_mode. "and g_decaytime = 0.
          continue.
        endif.
* MED-49016 End
* if out of date
        IF time_expired( i_insert_date = <ls_buffer>-insert_date i_insert_time = <ls_buffer>-insert_time ) = true.
*          or g_decaytime = 0 ).
          DELETE gt_tc_buffer.
          RETURN.
        ENDIF.
* If no TC on Pat-Level and a case is given the buffer can't be use because there can be a tc on Case Level
        IF ( <ls_buffer>-resp_type = resp_type_patient ) AND i_case_id IS NOT INITIAL.
          CONTINUE.
        ENDIF.
      ENDIF.
      e_tc_buffer_read = on.
      e_tc_exist = <ls_buffer>-exist.
      e_tc_request_possible = <ls_buffer>-request_possible.
      IF <ls_buffer>-tc_type = tc_type_temporary AND is_log_info IS SUPPLIED AND is_log_info IS NOT INITIAL.
        write_access_log(
          EXPORTING
            i_request_id = <ls_buffer>-request_id    " Schlüssel eines Temporären Behandlungsauftrags
            is_log_info  = is_log_info           " Informationen zum Loggen von Zugriffen über temp. Beh. Auftr
        ).
      ENDIF.
      RETURN.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD CHECK_TC_FROM_BUFFER_TEST.
  FIELD-SYMBOLS: <ls_buffer> TYPE lty_rn1tc_buffer.

*init
  e_tc_buffer_read = off.
  e_tc_exist = false.
  e_tc_request_possible = false.

  LOOP AT gt_tc_buffer_test ASSIGNING <ls_buffer>
    WHERE institution_id = g_institution_id AND
          patient_id = i_patient_id AND
          insert_date = sy-datum.
    IF ( <ls_buffer>-resp_type = resp_type_patient ) or
       ( I_CASE_ID is INITIAL and <ls_buffer>-resp_type = resp_type_case ) or
       ( <ls_buffer>-case_id EQ i_case_id and <ls_buffer>-resp_type = resp_type_case ).  "JV 28.07.11
      if ( time_expired_test( i_insert_date = <ls_buffer>-insert_date i_insert_time = <ls_buffer>-insert_time ) = true ).
        delete gt_tc_buffer_test.
        return.
      endif.
      e_tc_buffer_read = on.
      e_tc_exist = <ls_buffer>-exist.
      e_tc_request_possible = <ls_buffer>-request_possible.
      RETURN.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD check_tc_from_db_buffer.
  DATA lt_buffer_db TYPE TABLE OF n1tc_buffer.
  FIELD-SYMBOLS: <ls_buffer_db> TYPE n1tc_buffer.

*init
  r_tc_exist = false.

  SELECT * FROM n1tc_buffer INTO TABLE lt_buffer_db
    WHERE institution_id = g_institution_id AND
          patient_id = i_patient_id AND
          uname = sy-uname AND
          insert_date = sy-datum.

  IF sy-subrc = 0.
    LOOP AT lt_buffer_db ASSIGNING <ls_buffer_db>.
    IF ( <ls_buffer_db>-resp_type = resp_type_patient ) or
       ( I_CASE_ID is INITIAL and <ls_buffer_db>-resp_type = resp_type_case ) or
       ( <ls_buffer_db>-case_id EQ i_case_id and <ls_buffer_db>-resp_type = resp_type_case ).  "JV 28.07.11
        set_tc_to_buffer(
          EXPORTING
            i_patient_id       = i_patient_id    " IS-H: Patientennummer
            i_case_id          = i_case_id    " IS-H: Fallnummer
            i_tc_type          = <ls_buffer_db>-tc_type    " Typ des Behandlungsatuftags
            i_request_id       = <ls_buffer_db>-request_id    " Schlüssel eines Temporären Behandlungsauftrags
            i_resp_type        = <ls_buffer_db>-resp_type
            i_exist            = true    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
            i_request_possible = true
            i_to_db            = off
        ).
        IF <ls_buffer_db>-tc_type = tc_type_temporary and is_log_info is SUPPLIED.
          write_access_log(
            EXPORTING
              i_request_id = <ls_buffer_db>-request_id    " Schlüssel eines Temporären Behandlungsauftrags
              is_log_info  = is_log_info           " Informationen zum Loggen von Zugriffen über temp. Beh. Auftr
          ).
        ENDIF.
        r_tc_exist = true.
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDMETHOD.


METHOD check_tc_from_prov_buffer.
  FIELD-SYMBOLS: <ls_buffer> TYPE lty_rn1tc_prov_buffer.

*init
  e_tc_buffer_read = off.
  e_tc_exist = false.

  LOOP AT gt_tc_prov_buffer ASSIGNING <ls_buffer>
    WHERE institution_id = g_institution_id AND
          patient_prov_id = i_patient_provisional_id AND
          insert_date = sy-datum.
    IF <ls_buffer>-exist = false AND
       time_expired( i_insert_date = <ls_buffer>-insert_date i_insert_time = <ls_buffer>-insert_time ) = true.
      DELETE gt_tc_prov_buffer.
      RETURN.
    ENDIF.
    e_tc_buffer_read = on.
    e_tc_exist = <ls_buffer>-exist.
    RETURN.
  ENDLOOP.

ENDMETHOD.


METHOD check_tc_from_prov_db_buffer.
  DATA lt_buffer_db TYPE TABLE OF n1tc_buffer_pap.
  FIELD-SYMBOLS: <ls_buffer_db> TYPE n1tc_buffer_pap.

*init
  r_tc_exist = false.

  SELECT * FROM n1tc_buffer_pap INTO TABLE lt_buffer_db
    WHERE institution_id = g_institution_id AND
          patient_prov_id = i_patient_provisional_id AND
          uname = sy-uname AND
          insert_date = sy-datum.

  IF sy-subrc = 0.
    LOOP AT lt_buffer_db ASSIGNING <ls_buffer_db>.
      set_tc_to_prov_buffer(
        EXPORTING
          i_patient_provisional_id = i_patient_provisional_id   " IS-H: Patientennummer
          i_tc_type                = <ls_buffer_db>-tc_type    " Typ des Behandlungsatuftags
          i_request_id             = <ls_buffer_db>-request_id    " Schlüssel eines Temporären Behandlungsauftrags
          i_exist                  = true    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
          i_to_db                  = off
      ).
      r_tc_exist = true.
  ENDLOOP.
ENDIF.
ENDMETHOD.


METHOD check_tc_from_request.
  DATA lt_request_db TYPE TABLE OF n1tc_request.
  FIELD-SYMBOLS: <ls_request_db> TYPE n1tc_request.
*init
  r_tc_exist = false.

  SELECT * FROM n1tc_request INTO TABLE lt_request_db
    WHERE institution_id = g_institution_id AND
          patient_id = i_patient_id AND
          uname = sy-uname AND
          insert_date = sy-datum.

  IF sy-subrc = 0.
    LOOP AT lt_request_db ASSIGNING <ls_request_db>.
     IF ( <ls_request_db>-resp_type = resp_type_patient ) or
        ( I_CASE_ID is INITIAL and <ls_request_db>-resp_type = resp_type_case ) or
        ( <ls_request_db>-case_id EQ i_case_id and <ls_request_db>-resp_type = resp_type_case ).  "JV 28.07.11
          set_tc_to_buffer(
            EXPORTING
              i_patient_id       = i_patient_id    " IS-H: Patientennummer
              i_case_id          = i_case_id    " IS-H: Fallnummer
              i_tc_type          = tc_type_temporary    " Typ des Behandlungsatuftags
              i_resp_type        = <ls_request_db>-resp_type
              i_request_id       = <ls_request_db>-request_id    " Schlüssel eines Temporären Behandlungsauftrags
              i_exist            = true    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
              i_request_possible = true
        ).
        IF is_log_info IS SUPPLIED and is_log_info is NOT INITIAL.
          write_access_log(
            EXPORTING
              i_request_id    = <ls_request_db>-request_id    " Schlüssel eines Temporären Behandlungsauftrags
              is_log_info = is_log_info           " Informationen zum Loggen von Zugriffen über temp. Beh. Auftr
          ).
        ENDIF.
        r_tc_exist = true.
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDMETHOD.


METHOD check_tc_internal.
*----------------------------------------------------------
  DATA lr_badi              TYPE REF TO ishmed_tc_check.
*----------------------------------------------------------

*init return value
  e_tc_exist = false.

  TRY.
      IF cl_ishmed_switch_check=>ishmed_main( ) = on.
        GET BADI lr_badi
          FILTERS
            component = component_ishmed.
      ELSE.
        GET BADI lr_badi
          FILTERS
            component = component_ish.
      ENDIF.
    CATCH cx_badi_not_implemented.
      RAISE EXCEPTION TYPE cx_ishmed_tc.
  ENDTRY.

  CHECK lr_badi IS BOUND.

  CALL BADI lr_badi->check
    EXPORTING
      i_institution_id      = g_institution_id    " IS-H: Einrichtung
      i_patient_id          = i_patient_id    " IS-H: Patientennummer
      i_case_id             = i_case_id    " IS-H: Fallnummer
      it_matrix             = gt_matrix    " Die OE-USER Zuordungsmatrix des Behandlungsauftrages
    IMPORTING
      e_tc_request_possible = e_tc_request_possible    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
      e_tc_exist            = e_tc_exist    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
      e_resp_type           = e_resp_type.

  if e_tc_exist = false and e_tc_request_possible = false and i_case_id is NOT INITIAL.
    e_resp_type = resp_type_case.
  endif.

ENDMETHOD.


METHOD class_constructor.
* Revised with MED-64596 Note 2461680 Bi
  DATA ls_flagentry   TYPE n1tc_buffer.

* Set day for API use
  g_reference_day = sy-datum.

* Automatic deletion of buffer can be switched off for deletion via batch-report
  GET PARAMETER ID 'EIN' FIELD g_institution_id.

* GS MED-76398 security level added
  SELECT SINGLE security_level no_clear_buffer FROM tn1tc_glob_set
  INTO (g_security_level, g_no_clear_buffer)
  WHERE institution_id EQ g_institution_id.

  IF g_security_level <> security_level_off.                 "MED-76398
  IF g_no_clear_buffer NE abap_true. " Automatic buffer deletion is NOT switched off
*   Check for flag entry first
    SELECT COUNT( * )
      FROM n1tc_buffer
      WHERE institution_id  = 'TCTC'
        AND patient_id      = 'TCTCTCTCTC'
        AND uname           = 'TC_FLAGENTRY'
        AND insert_date     = sy-datum .

    IF sy-subrc NE 0. " No entry found; old entries have not been removed today
*     Delete all buffer entries not from today
      DELETE FROM n1tc_buffer WHERE insert_date LT sy-datum.  "#EC CI_NOFIRST

*     Write flag for today
      ls_flagentry-institution_id = 'TCTC'.
      ls_flagentry-patient_id     = 'TCTCTCTCTC'.
      ls_flagentry-uname          = 'TC_FLAGENTRY'.
      ls_flagentry-insert_date    = sy-datum.
      MODIFY n1tc_buffer FROM ls_flagentry.

    ENDIF.
  ENDIF.
  ENDIF.                                                    "MED-76398

ENDMETHOD.


METHOD constructor.
*----------------------------------------------------------
  DATA lr_badi              TYPE REF TO ishmed_tc_build_matrix.
*----------------------------------------------------------
  g_institution_id = i_institution_id.

  SELECT SINGLE security_level decay_time FROM tn1tc_glob_set
     INTO (g_security_level, g_decaytime)
     WHERE institution_id EQ i_institution_id.

  IF sy-subrc NE 0.
    g_security_level = security_level_off.
    g_decaytime = 0.
  ENDIF.

  IF g_security_level NE security_level_off.
*get Matrix only once
    TRY.
        GET BADI lr_badi.
      CATCH cx_badi_not_implemented.
        RAISE EXCEPTION TYPE cx_ishmed_tc.
    ENDTRY.

    CHECK lr_badi IS BOUND.

    CALL BADI lr_badi->build_matrix
      EXPORTING
        i_institution_id = i_institution_id
      IMPORTING
        et_tc_matrix     = gt_matrix.
  ENDIF.

ENDMETHOD.


method GET_MATRIX.
  et_tc_matrix = gt_matrix.
endmethod.


method IS_ACTIVE.
* check if TC Security Level is off ->> retun true
  IF g_security_level = security_level_off.
    r_active = false.
  else.
    r_active = true.
  ENDIF.
endmethod.


  METHOD IS_ACTIVE_FOR_USER.
    DATA l_message     TYPE string.

    r_value = true.
* check if TC Security Level is off ->> retun true
    IF g_security_level = security_level_off.
*   --------------------------------------------------> exit
      r_value = false.
      l_message = text-200.
      LOG-POINT ID ish_tc_check SUBKEY '1_MAIN' FIELDS l_message.
      RETURN.
    ENDIF.

*if OU-Matrix empty and level 2 or 4 ->> return true.
    IF lines( gt_matrix ) EQ 0 AND
      ( g_security_level = security_level_test_grant OR
        g_security_level = security_level_live_grant ).
*   --------------------------------------------------> exit
      r_value = false.
      l_message = text-201.
* log result
      LOG-POINT ID ish_tc_check SUBKEY '1_MAIN' FIELDS l_message.
      RETURN.
    ENDIF.

  ENDMETHOD.


METHOD load.
* return valid instance of API
  IF gr_api IS NOT BOUND.
    CREATE OBJECT gr_api
      EXPORTING
        i_institution_id = i_institution_id.    " IS-H: Einrichtung
  ELSE.
* check if API is from yesterday -- if so all checks has to be done from scratch
    IF sy-datum NE g_reference_day or i_institution_id NE g_institution_id.
      FREE gr_api.
      CREATE OBJECT gr_api
        EXPORTING
          i_institution_id = i_institution_id.    " IS-H: Einrichtung
    ENDIF.
  ENDIF.
  rr_api = gr_api.
ENDMETHOD.


  method RAISE_EVENTS_AFTER_COMMIT.

* new method IXX-12373
    DATA: lr_event  TYPE REF TO cl_ishmed_event.

*   Process the reminded events.
    LOOP AT gt_event_save INTO lr_event.
      CHECK lr_event IS BOUND.
      cl_ishmed_evmgr=>process_event( lr_event ).
      lr_event->destroy( ).
    ENDLOOP.
    CLEAR: gt_event_save.

  endmethod.


method REFRESH.
  clear gt_tc_buffer.
  clear gt_tc_buffer_test.
  clear gt_tc_prov_buffer.
endmethod.


METHOD REINIT_FOR_TEST.
*----------------------------------------------------------
  DATA lr_badi              TYPE REF TO ishmed_tc_build_matrix.
*----------------------------------------------------------

* only use in test transaction -- for security reasons
  IF sy-tcode NE 'N1TC_TEST'.
    MESSAGE e003(n1tc).
*   Diese Funkltion darf nur für interne Testzwecke verwendet werden
    RETURN.
  ENDIF.

  CLEAR gt_tc_buffer.

*build matrix for given user
  IF g_security_level NE security_level_off.
    clear gt_matrix.
      TRY.
          GET BADI lr_badi.
        CATCH cx_badi_not_implemented.
          RETURN.
      ENDTRY.

      CHECK lr_badi IS BOUND.
      TRY.
          CALL BADI lr_badi->build_matrix
            EXPORTING
              i_institution_id = g_institution_id
            IMPORTING
              et_tc_matrix     = gt_matrix.
        CATCH cx_ishmed_tc_cust cx_ishmed_tc.
          CLEAR gt_matrix.
      ENDTRY.
  ELSE.
    CLEAR gt_matrix.
  ENDIF.

ENDMETHOD.


METHOD request_delegation.
  DATA ls_request TYPE rn1tc_request_db.
  DATA l_tc_exist TYPE ish_true_false.
  DATA l_tc_request_possible TYPE ish_true_false.
*  DATA l_resp_type TYPE n1tc_ou_resp_type.


  check_authority_delegation( i_institution_id = g_institution_id ).


  ls_request-resp_type = resp_type_patient.

  check(
    EXPORTING
      i_patient_id          = i_patient_id
      i_case_id             = i_case_id
      i_dialog_mode         = cl_ishmed_tc_api=>off
*    is_log_info           = is_log_info
    IMPORTING
      e_tc_exist            = l_tc_exist
      e_tc_request_possible = l_tc_request_possible
         ).

  IF l_tc_exist = false AND l_tc_request_possible = false.
    RAISE EXCEPTION TYPE cx_ishmed_tc
      EXPORTING
        gr_msgtyp = 'S'
        textid    = cx_ishmed_tc=>no_delegation_possible.
  ENDIF.

  ls_request-institution_id = g_institution_id.
  ls_request-patient_id = i_patient_id.
  ls_request-case_id = i_case_id.
  ls_request-insert_user = sy-uname.
  ls_request-uname = i_uname.
  ls_request-insert_date = sy-datum.


  CALL FUNCTION 'ISHMED_TC_DELEGATION_DLG'
    CHANGING
      cs_request = ls_request.

  write_tc_delegation(
    EXPORTING
      is_request       = ls_request
  ).

  save( ).

  MESSAGE s711(n1tc) WITH ls_request-uname.
*   Delegation für Benutzer [ &sy-uname ] erfolgreich angelegt.

ENDMETHOD.


METHOD request_tc.
  DATA l_tc_exist TYPE ish_true_false.
  DATA l_tc_request_possible TYPE ish_true_false.

* delete all negative result from buffer.
  _del_pat_result_from_buffer( i_patient_id ).

* <<< MED-60843 Note 2255594 Bi
* store data to request TC without dialog
  CLEAR gs_request.
  gs_request-reason1   = i_reason1.
  gs_request-vip       = i_vip.
  gs_request-emergency = i_emergency.
* >>> MED-60843 Note 2255594 Bi

  check(
    EXPORTING
      i_patient_id          = i_patient_id
      i_case_id             = i_case_id
*      i_dialog_mode         = cl_ishmed_tc_api=>on             " MED-60843 Note 2255594 Bi
      i_dialog_mode         = i_dialog_mode                     " MED-60843 Note 2255594 Bi
*    is_log_info           = is_log_info
    IMPORTING
      e_tc_exist            = l_tc_exist
      e_tc_request_possible = l_tc_request_possible
         ).
* MED-47234
  IF l_tc_exist = false AND l_tc_request_possible = true.
    RAISE EXCEPTION TYPE cx_ishmed_tc_request_canceled
      EXPORTING
        gr_msgtyp = 'S'
        textid    = cx_ishmed_tc_request_canceled=>cx_ishmed_tc_request_canceled.
* MED-47234
  ELSEIF l_tc_exist = false. " AND l_tc_request_possible = false.
    RAISE EXCEPTION TYPE cx_ishmed_tc
      EXPORTING
        gr_msgtyp = 'S'
        textid    = cx_ishmed_tc=>no_request_possible.
  ENDIF.

ENDMETHOD.


method SAVE.
data l_do_commit type ish_on_off VALUE off.


  if lines( gt_tc_request ) gt 0.
    _save_tc_request( ).
    l_do_commit = on.
  endif.

  if lines( gt_access_log ) GT 0.
    _save_access_log( ).
    l_do_commit = on.
  endif.

  if lines( gt_buffer_db ) GT 0.
    _save_buffer_db( ).
    l_do_commit = on.
  endif.

  if lines( gt_prov_buffer_db ) gt 0.
    _save_prov_buffer_db( ).
    l_do_commit = on.
  endif.

if l_do_commit = on.
  CALL FUNCTION 'DB_COMMIT'.
    CALL METHOD raise_events_after_commit( ). "IXX-12373
*  COMMIT WORK.
endif.

endmethod.


METHOD set_glob_settings_for_test.
*----------------------------------------------------------
  DATA lr_badi              TYPE REF TO ishmed_tc_build_matrix.
*----------------------------------------------------------

* only use in test transaction -- for security reasons
  IF sy-tcode NE 'N1TC_TEST'.
    MESSAGE e003(n1tc).
*   Diese Funkltion darf nur für interne Testzwecke verwendet werden
    RETURN.
  ENDIF.

*set global data
  g_security_level = i_security_level.
  g_decaytime = i_decay_time.

*build matrix for given user
  IF g_security_level NE security_level_off.
    IF lines( gt_matrix ) EQ 0.
*get Matrix only once
      TRY.
          GET BADI lr_badi.
        CATCH cx_badi_not_implemented.
          RETURN.
      ENDTRY.

      CHECK lr_badi IS BOUND.
      TRY.
          CALL BADI lr_badi->build_matrix_for_user
            EXPORTING
              i_institution_id = g_institution_id
              i_uname          = i_uname
            IMPORTING
              et_tc_matrix     = gt_matrix.
        CATCH cx_ishmed_tc_cust cx_ishmed_tc.
          CLEAR gt_matrix.
      ENDTRY.

    ENDIF.
  ELSE.
    CLEAR gt_matrix.
  ENDIF.

ENDMETHOD.


METHOD set_tc_to_buffer.
  FIELD-SYMBOLS: <ls_buffer> TYPE lty_rn1tc_buffer.
  FIELD-SYMBOLS: <ls_buffer_loop> TYPE lty_rn1tc_buffer.

  APPEND INITIAL LINE TO gt_tc_buffer ASSIGNING <ls_buffer>.
  <ls_buffer>-institution_id = g_institution_id.
  <ls_buffer>-patient_id = i_patient_id.
  <ls_buffer>-case_id = i_case_id.
  <ls_buffer>-uname = sy-uname.
  <ls_buffer>-insert_date = sy-datum.
  <ls_buffer>-insert_time = sy-uzeit.
  <ls_buffer>-tc_type = i_tc_type.
  <ls_buffer>-resp_type = i_resp_type.
  <ls_buffer>-request_id = i_request_id.
  <ls_buffer>-exist = i_exist.
  <ls_buffer>-request_possible = i_request_possible.
  <ls_buffer>-dialog_mode = i_dialog_mode.               "MED-49016



* MED-47234 (MED-49245)
  IF i_exist = true.
    _del_pat_result_from_buffer( i_patient_id ).
    IF i_to_db = on.
* MED-47234 (MED-49245)
    write_to_buffer_db(
      EXPORTING
        i_patient_id = i_patient_id    " IS-H: Patientennummer
        i_case_id    = i_case_id    " IS-H: Fallnummer
        i_tc_type    = i_tc_type    " Typ des Behandlungsatuftags
        i_resp_type  = i_resp_type
        i_request_id = i_request_id    " Schlüssel eines Temporären Behandlungsauftrags
    ).
    ENDIF.
  ENDIF.
ENDMETHOD.


METHOD SET_TC_TO_BUFFER_TEST.
  FIELD-SYMBOLS: <ls_buffer> TYPE lty_rn1tc_buffer.

  APPEND INITIAL LINE TO gt_tc_buffer_test ASSIGNING <ls_buffer>.
  <ls_buffer>-institution_id = g_institution_id.
  <ls_buffer>-patient_id = i_patient_id.
  <ls_buffer>-case_id = i_case_id.
  <ls_buffer>-uname = sy-uname.
  <ls_buffer>-insert_date = sy-datum.
  <ls_buffer>-insert_time = sy-uzeit.
  <ls_buffer>-tc_type = i_tc_type.
  <ls_buffer>-resp_type = i_resp_type.
  <ls_buffer>-request_id = i_request_id.
  <ls_buffer>-exist = i_exist.
  <ls_buffer>-request_possible = i_request_possible.


ENDMETHOD.


METHOD SET_TC_TO_PROV_BUFFER.
  FIELD-SYMBOLS: <ls_buffer> TYPE lty_rn1tc_prov_buffer.

  APPEND INITIAL LINE TO gt_tc_prov_buffer ASSIGNING <ls_buffer>.
  <ls_buffer>-institution_id = g_institution_id.
  <ls_buffer>-patient_prov_id = i_patient_provisional_id.
  <ls_buffer>-uname = sy-uname.
  <ls_buffer>-insert_date = sy-datum.
  <ls_buffer>-insert_time = sy-uzeit.
  <ls_buffer>-exist = i_exist.


  IF i_exist = true and i_to_db = on.
    write_to_prov_buffer_db(
      EXPORTING
        I_PATIENT_PROVISIONAL_ID = I_PATIENT_PROVISIONAL_ID
        i_tc_type                = i_tc_type    " Typ des Behandlungsatuftags
        i_request_id             = i_request_id    " Schlüssel eines Temporären Behandlungsauftrags
    ).
  ENDIF.
ENDMETHOD.


METHOD time_expired.

  DATA l_decaytime_in_sec TYPE int4.
  DATA l_res_secs TYPE int4.
  DATA lv_timestamp TYPE timestamp.
  DATA l_time TYPE tims.

  TRY.
      GET TIME STAMP FIELD lv_timestamp.

      cl_abap_tstmp=>systemtstmp_utc2syst(
        EXPORTING
          utc_tstmp = lv_timestamp    " UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss)
        IMPORTING
*       syst_date = syst_date    " System Datum
          syst_time = l_time    " System Zeit
      ).
    CATCH cx_parameter_invalid_range.    " Parameter mit ungültigem Wertebereich
      l_time = sy-uzeit.
  ENDTRY.

  TRY.

      l_decaytime_in_sec = g_decaytime.

      cl_abap_tstmp=>td_subtract(
        EXPORTING
          date1    = sy-datum
          time1    = l_time
          date2    = i_insert_date
          time2    = i_insert_time
        IMPORTING
          res_secs = l_res_secs
      ).

      IF l_res_secs LE l_decaytime_in_sec.
        r_expired = false.
      ELSE.
        r_expired = true.
      ENDIF.

    CATCH cx_parameter_invalid_range cx_parameter_invalid_type.    " Parameter mit ungültigem Wertebereich
      r_expired = true.
  ENDTRY.
ENDMETHOD.


METHOD TIME_EXPIRED_TEST.

  DATA l_decaytime_in_sec TYPE int4.
  DATA l_res_secs TYPE int4.
  DATA lv_timestamp TYPE timestamp.
  DATA l_time TYPE tims.

  TRY.
      GET TIME STAMP FIELD lv_timestamp.

      cl_abap_tstmp=>systemtstmp_utc2syst(
        EXPORTING
          utc_tstmp = lv_timestamp    " UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss)
        IMPORTING
*       syst_date = syst_date    " System Datum
          syst_time = l_time    " System Zeit
      ).
    CATCH cx_parameter_invalid_range.    " Parameter mit ungültigem Wertebereich
      l_time = sy-uzeit.
  ENDTRY.

  TRY.

      l_decaytime_in_sec = 5.

      cl_abap_tstmp=>td_subtract(
        EXPORTING
          date1    = sy-datum
          time1    = l_time
          date2    = i_insert_date
          time2    = i_insert_time
        IMPORTING
          res_secs = l_res_secs
      ).

      IF l_res_secs LE l_decaytime_in_sec.
        r_expired = false.
      ELSE.
        r_expired = true.
      ENDIF.

    CATCH cx_parameter_invalid_range cx_parameter_invalid_type.    " Parameter mit ungültigem Wertebereich
      r_expired = true.
  ENDTRY.
ENDMETHOD.


METHOD write_access_log.
  DATA ls_access_log TYPE n1tc_access_log.

  MOVE-CORRESPONDING is_log_info TO ls_access_log.  "#EC ENHOK
*  ls_access_log-mandt = sy-mandt.
  ls_access_log-request_id = i_request_id.
  ls_access_log-insert_date = sy-datum.
  ls_access_log-inst_time = sy-uzeit.
  ls_access_log-inst_user = sy-uname.
  TRY.
      ls_access_log-log_id = cl_system_uuid=>create_uuid_c32_static( ).
    CATCH cx_uuid_error.
      CALL FUNCTION 'GUID_CREATE'
        IMPORTING
*         EV_GUID_16 =
*         EV_GUID_22 =
          ev_guid_32 = ls_access_log-log_id. "#EC FB_OLDED
  ENDTRY.
  APPEND ls_access_log TO gt_access_log.

ENDMETHOD.


METHOD WRITE_TC_DELEGATION.
  DATA ls_request_db TYPE n1tc_request.

  clear ls_request_db.
  MOVE-CORRESPONDING is_request TO ls_request_db.

  TRY.
      ls_request_db-request_id = cl_system_uuid=>create_uuid_c32_static( ).
    CATCH cx_uuid_error.
      CALL FUNCTION 'GUID_CREATE'
        IMPORTING
*         EV_GUID_16 =
*         EV_GUID_22 =
          ev_guid_32 = ls_request_db-request_id. "#EC FB_OLDED
  ENDTRY.
  APPEND ls_request_db TO gt_tc_request.

  IF is_log_info IS SUPPLIED AND is_log_info IS NOT INITIAL.
    write_access_log(
      EXPORTING
        i_request_id    = ls_request_db-request_id    " Schlüssel eines Temporären Behandlungsauftrags
        is_log_info = is_log_info    " Informationen zum Loggen von Zugriffen über temp. Beh. Auftr
    ).
  ENDIF.


ENDMETHOD.


METHOD write_tc_request.
  DATA ls_request_db TYPE n1tc_request.

  MOVE-CORRESPONDING is_request TO ls_request_db.

  TRY.
      ls_request_db-request_id = cl_system_uuid=>create_uuid_c32_static( ).
    CATCH cx_uuid_error.
      CALL FUNCTION 'GUID_CREATE'
        IMPORTING
*         EV_GUID_16 =
*         EV_GUID_22 =
          ev_guid_32 = ls_request_db-request_id. "#EC FB_OLDED
  ENDTRY.
  APPEND ls_request_db TO gt_tc_request.

  IF is_log_info IS SUPPLIED AND is_log_info IS NOT INITIAL.
    write_access_log(
      EXPORTING
        i_request_id    = ls_request_db-request_id    " Schlüssel eines Temporären Behandlungsauftrags
        is_log_info = is_log_info    " Informationen zum Loggen von Zugriffen über temp. Beh. Auftr
    ).
  ENDIF.

  set_tc_to_buffer(
    EXPORTING
      i_patient_id       = ls_request_db-patient_id    " IS-H: Patientennummer
      i_case_id          = ls_request_db-case_id       " IS-H: Fallnummer
      i_tc_type          = tc_type_temporary  " Typ des Behandlungsatuftags
      i_resp_type        = ls_request_db-resp_type
      i_request_id       = ls_request_db-request_id              " Schlüssel eines Temporären Behandlungsauftrags
      i_exist            = true    " IS-H: Boolscher Datentyp für TRUE (='1') und FALSE (='0')
      i_request_possible = true
      i_to_db            = i_with_db_buffer
    ).

ENDMETHOD.


METHOD WRITE_TO_BUFFER_DB.
  FIELD-SYMBOLS: <ls_buffer_db> TYPE n1tc_buffer.

  APPEND INITIAL LINE TO gt_buffer_db ASSIGNING <ls_buffer_db>.
  <ls_buffer_db>-institution_id = g_institution_id.
  <ls_buffer_db>-patient_id = i_patient_id.
  <ls_buffer_db>-case_id = i_case_id.
  <ls_buffer_db>-uname = sy-uname.
  <ls_buffer_db>-insert_date = sy-datum.
  <ls_buffer_db>-tc_type = i_tc_type.
  <ls_buffer_db>-resp_type = i_resp_type.
  <ls_buffer_db>-request_id = i_request_id.

ENDMETHOD.


METHOD WRITE_TO_PROV_BUFFER_DB.
  FIELD-SYMBOLS: <ls_buffer_db> TYPE n1tc_buffer_pap.

  APPEND INITIAL LINE TO gt_prov_buffer_db ASSIGNING <ls_buffer_db>.
  <ls_buffer_db>-institution_id = g_institution_id.
  <ls_buffer_db>-patient_prov_id = i_patient_provisional_id.
  <ls_buffer_db>-uname = sy-uname.
  <ls_buffer_db>-insert_date = sy-datum.
  <ls_buffer_db>-tc_type = i_tc_type.
  <ls_buffer_db>-request_id = i_request_id.

ENDMETHOD.


METHOD _check_special.
  r_result = false.
  IF sy-tcode = 'N1TC_TEST' .
    IF sy-dynnr NE '0781' and sy-dynnr NE '0871'.
      r_result = true.
    ENDIF.
  ENDIF.
  IF  sy-tcode = 'N1TC_DELEGATE'.
    IF sy-dynnr NE '0060' and sy-dynnr NE '0101'.        " note 2907566
      r_result = true.
    ENDIF.
  ENDIF.
  IF  sy-tcode = 'N1TC_REPORT'.
    IF sy-dynnr NE '0500'.
      r_result = true.
    ENDIF.
  ENDIF.
ENDMETHOD.


method _DEL_PAT_RESULT_FROM_BUFFER.

DELETE gt_tc_buffer where institution_id = g_institution_id and patient_id = i_patient_id and exist = false.

DELETE gt_tc_buffer_test where institution_id = g_institution_id and patient_id = i_patient_id and exist = false.

endmethod.


METHOD _save_access_log.
  MODIFY n1tc_access_log FROM table gt_access_log.

  IF sy-subrc EQ 0.
    CLEAR gt_access_log.
  ENDIF.
ENDMETHOD.


METHOD _save_buffer_db.

  MODIFY n1tc_buffer FROM TABLE gt_buffer_db.

  IF sy-subrc EQ 0.
    CLEAR gt_buffer_db.
  ENDIF.

ENDMETHOD.


METHOD _save_prov_buffer_db.

  MODIFY n1tc_buffer_pap FROM TABLE gt_prov_buffer_db.

  IF sy-subrc EQ 0.
    CLEAR gt_prov_buffer_db.
  ENDIF.

ENDMETHOD.


METHOD _save_tc_request.
  MODIFY n1tc_request FROM TABLE gt_tc_request.

  IF sy-subrc EQ 0.
    add_events( ).  "IXX-12373
    CLEAR gt_tc_request.
  ENDIF.
ENDMETHOD.
ENDCLASS.
