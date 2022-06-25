CLASS ltc_ishmed_event_tc_pao DEFINITION DEFERRED.
CLASS cl_ishmed_event_tc      DEFINITION LOCAL FRIENDS ltc_ishmed_event_tc_pao.
CLASS ltc_ishmed_event_tc_pao DEFINITION FOR TESTING ##class_final
  DURATION SHORT
  RISK LEVEL HARMLESS
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>ltc_Ishmed_Event_Tc_Pao
*?</TEST_CLASS>
*?<TEST_MEMBER>gr_under_test
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>CL_ISHMED_EVENT_TC
*?</OBJECT_UNDER_TEST>
*?<OBJECT_IS_LOCAL/>
*?<GENERATE_FIXTURE/>
*?<GENERATE_CLASS_FIXTURE/>
*?<GENERATE_INVOCATION/>
*?<GENERATE_ASSERT_EQUAL/>
*?</TESTCLASS_OPTIONS>
*?</asx:values>
*?</asx:abap>
  PRIVATE SECTION.
    DATA      gr_under_test               TYPE REF TO cl_ishmed_event_tc.  "class under test
    DATA      gs_event_data               TYPE   rn1tc_event_data.

    CONSTANTS co_request_id               TYPE n1tc_request_id    VALUE 'co_reqid_______________________I'.
    CONSTANTS co_institution_id           TYPE einri              VALUE 'UTZZ'.
    CONSTANTS co_patient_id               TYPE patnr              VALUE 'UT00012345'.
    CONSTANTS co_i_repid                  TYPE n1eventrepid       VALUE 'UTzzzzzzz'.

    METHODS   setup.
    METHODS   get_patient                                         FOR TESTING.
    METHODS   get_institution                                     FOR TESTING.
    METHODS   get_type                                            FOR TESTING.

    METHODS   is_inherited_from_same                              FOR TESTING.
    METHODS   is_inherited_from_base                              FOR TESTING.
    METHODS   is_inherited_from_fail                              FOR TESTING.

    METHODS   destroy                                             FOR TESTING.
    METHODS   get_async_data                                      FOR TESTING.
    METHODS   get_business_key                                    FOR TESTING.
    METHODS   raise                                               FOR TESTING.
    METHODS   raise_with_result                                   FOR TESTING.
ENDCLASS.       "ltc_Ishmed_Event_Tc_Pao


CLASS ltc_ishmed_event_tc_pao IMPLEMENTATION.

  METHOD setup.

    gs_event_data-tc-patient_id                  = co_patient_id.
    gs_event_data-tc-institution_id              = co_institution_id.
    gs_event_data-tc-request_id                  = co_request_id.

    TRY.
        CREATE OBJECT gr_under_test
          EXPORTING
            is_tc_ev_data = gs_event_data                                    "Eventmgmt: ID einer Anwendungsdefinition
            i_evdefid     = cl_ishmed_evappl_tc=>co_evdefid_created          "Eventmgmt: ID einer Ereignisdefinition
            i_repid       = co_i_repid                                       "Eventmgmt: Programm, das ein Ereignis ausgelöst hat
            i_mode        = 'D'                                              "Eventmgmt: Modus eines Ereignisses
            i_user        = sy-uname                                         "Eventmgmt: Benutzer, der ein Ereignis ausgelöst hat
*           I_TCODE       = i_Tcode                                          "Eventmgmt: Transaktion, die ein Ereignis ausgelöst hat
          .
      CATCH cx_root  ##CATCH_ALL.
        CLEAR gr_under_test.
    ENDTRY.

    IF gr_under_test IS NOT BOUND.
      cl_abap_unit_assert=>fail(
          msg    = 'Could not retrieve gr_under_test! '
          level  =  if_aunit_constants=>critical
          quit   =  if_aunit_constants=>class
      ).

    ENDIF.

  ENDMETHOD.

  METHOD get_patient.
*    CLEAR e_patnr.
*    CLEAR e_papid.
*    CLEAR er_pap.
*    CLEAR e_rc.
*
*    e_patnr = gs_tc_ev_data-tc-patient_id.

    DATA l_rc                          TYPE ish_method_rc.
    DATA lr_patient_provisional        TYPE REF TO cl_ish_patient_provisional.
    DATA lr_env                        TYPE REF TO cl_ish_environment.

    DATA l_patnr                       TYPE npat-patnr VALUE 'patbla'  ##no_text.
    DATA l_papnr                       TYPE npat-patnr VALUE 'papbla'  ##no_text.

* ---------- ---------- ----------
    call METHOD cl_ish_fac_environment=>CREATE
      EXPORTING
        i_program_name = 'DUMMY'
        i_use_one_env  = ' '
      IMPORTING
        e_instance     = lr_env
        e_rc           = l_rc.

    IF l_rc <> 0.
      cl_abap_unit_assert=>fail(
          msg    = 'Could not create environment in get_patient'
          level  = if_aunit_constants=>critical
          quit   = if_aunit_constants=>class
          ).
    ENDIF.
* ---------- ---------- ----------

    CREATE OBJECT lr_patient_provisional
      EXPORTING
        i_environment       = lr_env        " Environment
      EXCEPTIONS
        missing_environment = 1.            " Environment fehlt

    IF sy-subrc <> 0.
      cl_abap_unit_assert=>fail(
          msg    = 'Could not create patient_provisional in get_patient'
          level  = if_aunit_constants=>critical
          quit   = if_aunit_constants=>class
          ).
    ENDIF.

    l_rc = 1.
    gr_under_test->if_ish_get_patient~get_patient(
       IMPORTING
        e_patnr         = l_patnr                         " Nummer eines realen Patienten
        e_papid         = l_papnr                         " Nummer eines Patienten mit vorl. Stammdaten
        er_pap          = lr_patient_provisional          " Instanz eines Patienten mit vorl. Stammdaten
        e_rc            = l_rc                            " Returncode
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = l_patnr
      exp   = co_patient_id
    ).

    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act              = l_papnr
    ).

    cl_abap_unit_assert=>assert_initial(
       EXPORTING
         act              = lr_patient_provisional
     ).

    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act              = l_rc
    ).

  ENDMETHOD.

  METHOD get_institution.

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->if_ish_get_institution~get_institution( )
      exp   = co_institution_id
    ).

  ENDMETHOD.

  METHOD get_type.

    DATA e_object_type TYPE ish_object_type.

    gr_under_test->if_ish_identify_object~get_type(
     IMPORTING
       e_object_type = e_object_type
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = e_object_type
      exp   = cl_ishmed_event_tc=>co_otype_event_tc
    ).

  ENDMETHOD.

  METHOD is_inherited_from_same.

    cl_abap_unit_assert=>assert_true( gr_under_test->if_ish_identify_object~is_inherited_from( cl_ishmed_event_tc=>co_otype_event_tc ) ).

  ENDMETHOD.

  METHOD is_inherited_from_base.

    cl_abap_unit_assert=>assert_true( gr_under_test->if_ish_identify_object~is_inherited_from( cl_ishmed_event=>co_otype_event ) ).

  ENDMETHOD.

  METHOD is_inherited_from_fail.

    cl_abap_unit_assert=>assert_false( gr_under_test->if_ish_identify_object~is_inherited_from( 123 ) ).

  ENDMETHOD.

  METHOD destroy.

    gr_under_test->destroy( ).

    cl_abap_unit_assert=>assert_initial( act = gr_under_test->get_common_data( ) ).
    cl_abap_unit_assert=>assert_initial( act = gr_under_test->gs_tc_ev_data ).

  ENDMETHOD.

  METHOD get_async_data.

    DATA r_async_data TYPE n1serialized.
    DATA l_expected   TYPE n1serialized.

    CALL TRANSFORMATION id
        SOURCE struct = gs_event_data
        RESULT XML l_expected.

    TRY.
        r_async_data = gr_under_test->get_async_data(  ).
      CATCH cx_ish_static_handler INTO DATA(lx_exp).
        cl_abap_unit_assert=>fail( msg    = 'get_async_data failed'
                                   detail = lx_exp->get_text( ) ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = r_async_data
        exp                  = l_expected
    ).


  ENDMETHOD.

  METHOD get_business_key.

    DATA r_value TYPE n1evmg_business_key.

    r_value = gr_under_test->get_business_key(  ).

    cl_abap_unit_assert=>assert_equals(
      act   = r_value
      exp   = co_request_id
    ).

  ENDMETHOD.

  METHOD raise.

    TRY.
        cl_ishmed_event_tc=>raise(
          EXPORTING
        is_tc_ev_data  = gs_event_data
        i_evdefid      = cl_ishmed_evappl_tc=>co_evdefid_created
        i_repid        = sy-repid
        i_mode         = 'D'
        i_user         = sy-uname
        ).

      CATCH cx_root  ##CATCH_ALL.
        cl_abap_unit_assert=>fail(
           msg    = 'raise failed'
           ).
    ENDTRY.


  ENDMETHOD.

  METHOD raise_with_result.

    DATA lr_ishmed_evmgr_result TYPE REF TO cl_ishmed_evmgr_result.

    TRY.
        lr_ishmed_evmgr_result =  cl_ishmed_event_tc=>raise_with_result(
          EXPORTING
        is_tc_ev_data  = gs_event_data
        i_evdefid      = cl_ishmed_evappl_tc=>co_evdefid_created
        i_repid        = sy-repid
        i_mode         = 'D'
        i_user         = sy-uname
        ).

      CATCH cx_root  ##CATCH_ALL.
        CLEAR lr_ishmed_evmgr_result.
    ENDTRY.

    cl_abap_unit_assert=>assert_bound(
      act   = lr_ishmed_evmgr_result
      msg   = 'No result object!'
    ).


  ENDMETHOD.

ENDCLASS.
