CLASS ltc_ishmed_alappl_tc_pao     DEFINITION DEFERRED.
CLASS cl_ishmed_alappl_tc          DEFINITION LOCAL FRIENDS  ltc_ishmed_alappl_tc_pao.
CLASS ltc_ishmed_alappl_tc_pao     DEFINITION FOR TESTING ##class_final
  DURATION SHORT
  RISK LEVEL HARMLESS
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>ltc_Ishmed_Alappl_Tc_Pao
*?</TEST_CLASS>
*?<TEST_MEMBER>gr_under_test
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>CL_ISHMED_ALAPPL_TC
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
    DATA gr_under_test TYPE REF TO cl_ishmed_alappl_tc.  "class under test
    DATA      gs_event_data               TYPE rn1tc_event_data.

    CONSTANTS co_request_id               TYPE n1tc_request_id    VALUE 'co_reqid_______________________I'.
    CONSTANTS co_institution_id           TYPE einri              VALUE 'UTZZ'.
    CONSTANTS co_patient_id               TYPE patnr              VALUE 'UT00012345'.
    CONSTANTS co_i_repid                  TYPE n1eventrepid       VALUE 'UTzzzzzzz'.

    METHODS setup.
    METHODS get_async_data
      IMPORTING
        is_ev_data             TYPE rn1tc_event_data
      RETURNING
        VALUE(rs_n1asyncevent) TYPE n1asyncevent.

    METHODS get_type                                             FOR TESTING.

    METHODS is_inherited_from_same                               FOR TESTING.
    METHODS is_inherited_from_base                               FOR TESTING.
    METHODS is_inherited_from_fail                               FOR TESTING.

    METHODS create_alentry_internal                              FOR TESTING.
    METHODS get_doku_obj                                         FOR TESTING.
    METHODS get_evappl_tc                                        FOR TESTING.
ENDCLASS.       "ltc_Ishmed_Alappl_Tc_Pao


CLASS ltc_ishmed_alappl_tc_pao IMPLEMENTATION.

  METHOD setup.

    DATA lr_almaster  TYPE REF TO cl_ishmed_almaster.
    DATA lr_almappl   TYPE REF TO cl_ishmed_almappl.

    gs_event_data-tc-patient_id                  = co_patient_id.
    gs_event_data-tc-institution_id              = co_institution_id.
    gs_event_data-tc-request_id                  = co_request_id.

    lr_almaster = cl_ishmed_almaster=>create( ).
    lr_almappl  = lr_almaster->get_almappl_by_id( cl_ishmed_evappl_tc=>co_evapplid_tc ).
    TRY.
        gr_under_test ?= lr_almappl->get_alappl( ).
      CATCH cx_sy_move_cast_error.
        cl_abap_unit_assert=>fail(
               msg    = 'Could not retrieve gr_under_test! '
               level  =  if_aunit_constants=>critical
               quit   =  if_aunit_constants=>class
           ).
    ENDTRY.

  ENDMETHOD.

  METHOD get_async_data.

    DATA lr_event   TYPE REF TO cl_ishmed_event_tc.

    rs_n1asyncevent-evapplid = cl_ishmed_evappl_tc=>co_evapplid_tc.
    rs_n1asyncevent-evdefid  = cl_ishmed_evappl_tc=>co_evdefid_created.

    TRY.
        CREATE OBJECT lr_event
          EXPORTING
            is_tc_ev_data = is_ev_data
            i_evdefid     = cl_ishmed_evappl_tc=>co_evdefid_created
            i_repid       = co_i_repid
            i_mode        = 'D'
            i_user        = sy-uname.
      CATCH cx_root  ##CATCH_ALL.
        RETURN.
    ENDTRY.

    TRY.
        rs_n1asyncevent-async_data = lr_event->get_async_data( ).
      CATCH cx_ish_static_handler INTO DATA(lx_exp).
        cl_abap_unit_assert=>fail( msg = 'get async data from event raised exception'
                                   detail = lx_exp->get_longtext( ) ).
    ENDTRY.
  ENDMETHOD.

  METHOD get_type.

    DATA e_object_type TYPE ish_object_type.

    gr_under_test->if_ish_identify_object~get_type(
     IMPORTING
       e_object_type = e_object_type
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = e_object_type
      exp   = cl_ishmed_alappl_tc=>co_otype_alappl_tc
    ).

  ENDMETHOD.

  METHOD is_inherited_from_same.

    cl_abap_unit_assert=>assert_true( gr_under_test->if_ish_identify_object~is_inherited_from( cl_ishmed_alappl_tc=>co_otype_alappl_tc ) ).

  ENDMETHOD.

  METHOD is_inherited_from_base.

    cl_abap_unit_assert=>assert_true( gr_under_test->if_ish_identify_object~is_inherited_from( cl_ishmed_alappl=>co_otype_alappl ) ).

  ENDMETHOD.

  METHOD is_inherited_from_fail.

    cl_abap_unit_assert=>assert_false( gr_under_test->if_ish_identify_object~is_inherited_from( 123 ) ).

  ENDMETHOD.

  METHOD create_alentry_internal.

    DATA ls_n1asyncevent TYPE n1asyncevent.
    DATA lr_alentry_act  TYPE REF TO cl_ishmed_alentry_tc.
    DATA lr_alentry_exp  TYPE REF TO cl_ishmed_alentry_tc.

    gs_event_data-tc-req_type = 'T'.
    ls_n1asyncevent = get_async_data( gs_event_data ).

    TRY.
        lr_alentry_exp = cl_ishmed_alentry_tc=>create_tc_by_asyncevent( ls_n1asyncevent ).
        lr_alentry_act ?= gr_under_test->create_alentry_internal( ls_n1asyncevent ).
      CATCH cx_ish_static_handler INTO DATA(lx_exp).
        cl_abap_unit_assert=>fail( msg = 'create_alentry_internal raised exception'
                                   detail = lx_exp->get_longtext( ) ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act   = cl_abap_typedescr=>describe_by_object_ref( lr_alentry_act )
      exp   = cl_abap_typedescr=>describe_by_object_ref( lr_alentry_exp )
    ).

  ENDMETHOD.

  METHOD get_doku_obj.

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_doku_obj( )
      exp   = 'N1_ALAPPL_TC'
    ).

  ENDMETHOD.

  METHOD get_evappl_tc.

    DATA lr_alappl TYPE REF TO cl_ishmed_evappl_tc.

    lr_alappl =  gr_under_test->get_evappl_tc( ).
    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act    = lr_alappl
    ).

  ENDMETHOD.

ENDCLASS.
