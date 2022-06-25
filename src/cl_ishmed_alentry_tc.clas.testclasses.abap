CLASS ltc_ishmed_alentry_tc_pao     DEFINITION DEFERRED.
CLASS cl_ishmed_alentry_tc          DEFINITION LOCAL FRIENDS ltc_ishmed_alentry_tc_pao .
CLASS ltc_ishmed_alentry_tc_pao     DEFINITION FOR TESTING ##class_final
  DURATION SHORT
  RISK LEVEL HARMLESS
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>ltc_Ishmed_Alentry_Tc_Pao
*?</TEST_CLASS>
*?<TEST_MEMBER>gr_under_test
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>CL_ISHMED_ALENTRY_TC
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
    DATA      gr_under_test                TYPE REF TO cl_ishmed_alentry_tc.  "class under test
    DATA      gs_event_data                TYPE rn1tc_event_data.

    CONSTANTS co_request_id                TYPE n1tc_request_id    VALUE 'co_reqid_______________________I'.
    CONSTANTS co_institution_id            TYPE einri              VALUE 'UTZZ'.
    CONSTANTS co_patient_id                TYPE patnr              VALUE 'UT00012345'.
    CONSTANTS co_i_repid                   TYPE n1eventrepid       VALUE 'UTzzzzzzz'.


    METHODS setup.
    METHODS get_event_data
      RETURNING
        VALUE(rs_n1asyncevent) TYPE n1asyncevent.

    METHODS  get_type                      FOR TESTING.

    METHODS  is_inherited_from_same        FOR TESTING.
    METHODS  is_inherited_from_base        FOR TESTING.
    METHODS  is_inherited_from_fail        FOR TESTING.

    METHODS  clone_data                    FOR TESTING.

    METHODS  create_tc_by_asyncevent       FOR TESTING.
    METHODS  create_tc_by_asyncevent_fail  FOR TESTING.

    METHODS  destroy_internal              FOR TESTING.
    METHODS  get_data_tc                   FOR TESTING.
    METHODS  init_by_asyncevent_req_type_t FOR TESTING.
    METHODS  init_by_asyncevent_req_type_d FOR TESTING.
    METHODS  init_by_asyncevent_req_id     FOR TESTING.
    METHODS  init_by_asyncevent_fail       FOR TESTING.
ENDCLASS.       "ltc_Ishmed_Alentry_Tc_Pao


CLASS ltc_ishmed_alentry_tc_pao IMPLEMENTATION.

  METHOD setup.

    gs_event_data-tc-patient_id                  = co_patient_id.
    gs_event_data-tc-institution_id              = co_institution_id.
    gs_event_data-tc-request_id                  = co_request_id.


    CREATE OBJECT gr_under_test.

    IF gr_under_test IS NOT BOUND.
      cl_abap_unit_assert=>fail(
        EXPORTING
                msg    = 'Could not retrieve gr_under_test! '
                level  =  if_aunit_constants=>critical
                quit   =  if_aunit_constants=>class
      ).
    ENDIF.

    gr_under_test->gs_data_tc = gs_event_data.

  ENDMETHOD.

  METHOD get_event_data.

    DATA lr_event   TYPE REF TO cl_ishmed_event_tc.

    rs_n1asyncevent-evapplid = cl_ishmed_evappl_tc=>co_evapplid_tc.
    rs_n1asyncevent-evdefid  = cl_ishmed_evappl_tc=>co_evdefid_created.

    TRY.
        CREATE OBJECT lr_event
          EXPORTING
            is_tc_ev_data = gs_event_data
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
      exp   = gr_under_test->co_otype_alentry_tc
    ).

  ENDMETHOD.

  METHOD is_inherited_from_same.

    cl_abap_unit_assert=>assert_true( gr_under_test->if_ish_identify_object~is_inherited_from( gr_under_test->co_otype_alentry_tc ) ).

  ENDMETHOD.

  METHOD is_inherited_from_base.

    cl_abap_unit_assert=>assert_true( gr_under_test->if_ish_identify_object~is_inherited_from( gr_under_test->co_otype_alentry ) ).

  ENDMETHOD.

  METHOD is_inherited_from_fail.

    cl_abap_unit_assert=>assert_false( gr_under_test->if_ish_identify_object~is_inherited_from( 999 ) ).

  ENDMETHOD.

  METHOD clone_data.

    DATA lr_clone TYPE REF TO cl_ishmed_alentry_tc.

    TRY.
        lr_clone ?= gr_under_test->create_clone( ).
      CATCH cx_sy_move_cast_error.
        CLEAR lr_clone.
    ENDTRY.
    cl_abap_unit_assert=>assert_bound( lr_clone ).
    cl_abap_unit_assert=>assert_equals(
        act                  = lr_clone->gs_data_tc
        exp                  = gr_under_test->gs_data_tc
    ).

  ENDMETHOD.

  METHOD create_tc_by_asyncevent.

    DATA lr_alentry      TYPE REF TO cl_ishmed_alentry_tc.
    DATA ls_n1asyncevent TYPE n1asyncevent.

    gs_event_data-tc-req_type = 'T'.

    ls_n1asyncevent            = get_event_data( ).

    TRY.
        lr_alentry = cl_ishmed_alentry_tc=>create_tc_by_asyncevent( is_n1asyncevent = ls_n1asyncevent  ).
        cl_abap_unit_assert=>assert_equals(
            act                  = lr_alentry->gs_data_tc
            exp                  = gs_event_data
            ).
      CATCH cx_ish_static_handler INTO DATA(lx_exp).
        IF lx_exp->gr_errorhandler IS NOT INITIAL.
          lx_exp->gr_errorhandler->get_messages( IMPORTING  t_messages = DATA(lt_msg) ).    " liefert alle gesammelten Nachrichten zurück
          LOOP AT lt_msg INTO DATA(ls_msg) ##needed.
          ENDLOOP.
        ENDIF.
        cl_abap_unit_assert=>fail( msg = 'create_tc_by_asyncevent raised exception'
                                   detail = ls_msg-message
                                  ).
    ENDTRY.

  ENDMETHOD.

  METHOD create_tc_by_asyncevent_fail.

    DATA ls_n1asyncevent TYPE n1asyncevent.

    ls_n1asyncevent            = get_event_data( ).
    ls_n1asyncevent-async_data = 'DUMMY'.

    TRY.
        cl_abap_unit_assert=>assert_initial( cl_ishmed_alentry_tc=>create_tc_by_asyncevent(  ls_n1asyncevent ) ).
      CATCH cx_ish_static_handler INTO DATA(lx_exp).
        cl_abap_unit_assert=>assert_equals(
          act   = lx_exp->gr_msgtyp
          exp   = 'E'
     ).
    ENDTRY.
  ENDMETHOD.

  METHOD destroy_internal.

    gr_under_test->destroy_internal(  ).
    cl_abap_unit_assert=>assert_initial( gr_under_test->get_data_tc( ) ).

  ENDMETHOD.

  METHOD get_data_tc.

    cl_abap_unit_assert=>assert_equals(
        act                  = gr_under_test->get_data_tc( )
        exp                  = gs_event_data
     ).

  ENDMETHOD.

  METHOD init_by_asyncevent_req_type_t.

*   T	temp. Beantragung
*   D	Delegation
    DATA    lr_enum_req_type TYPE REF TO cl_ish_enum.
    DATA    l_objid_msgtext  TYPE string.

    gs_event_data-tc-req_type = 'T'.

    TRY.
    lr_enum_req_type = cl_ish_enum=>get_instance_by_domname( i_domname = 'N1TC_REQ_TYPE' ).
    IF lr_enum_req_type IS BOUND.
      l_objid_msgtext = lr_enum_req_type->get_text_by_id( i_id = gs_event_data-tc-req_type ).
    ENDIF.
      CATCH cx_ish_static_handler  INTO DATA(lx_exp).
        cl_abap_unit_assert=>fail( msg = 'init_by_asyncevent_req_type_t raised exception'
                                   detail = lx_exp->get_longtext( ) ).
    ENDTRY.

    TRY.
        gr_under_test->init_by_asyncevent( get_event_data( ) ).
      CATCH cx_ish_static_handler  INTO lx_exp.
        cl_abap_unit_assert=>fail( msg = 'init by asyncevent raised exception'
                                   detail = lx_exp->get_longtext( ) ).
    ENDTRY.


    DATA(act)  = gr_under_test->get_almsg( ).
    DATA(ext)  = gr_under_test->build_almsg( l_objid_msgtext ).
    cl_abap_unit_assert=>assert_equals( act = act
                                        exp = ext ).

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_ctx_objid( )
      exp   = co_request_id
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_einri( )
      exp   = co_institution_id
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_ctx_patnr( )
      exp   = co_patient_id
    ).

  ENDMETHOD.

  METHOD init_by_asyncevent_req_type_d.

*   T	temp. Beantragung
*   D	Delegation
    DATA    lr_enum_req_type TYPE REF TO cl_ish_enum.
    DATA    l_objid_msgtext  TYPE string.

    gs_event_data-tc-req_type = 'D'.

    TRY.
    lr_enum_req_type = cl_ish_enum=>get_instance_by_domname( i_domname = 'N1TC_REQ_TYPE' ).
    IF lr_enum_req_type IS BOUND.
      l_objid_msgtext = lr_enum_req_type->get_text_by_id( i_id = gs_event_data-tc-req_type ).
    ENDIF.
      CATCH cx_ish_static_handler  INTO DATA(lx_exp).
        cl_abap_unit_assert=>fail( msg = 'init_by_asyncevent_req_type_d raised exception'
                                   detail = lx_exp->get_longtext( ) ).
    ENDTRY.


    TRY.
        gr_under_test->init_by_asyncevent( get_event_data( ) ).
      CATCH cx_ish_static_handler  INTO lx_exp.
        cl_abap_unit_assert=>fail( msg = 'init by asyncevent raised exception'
                                   detail = lx_exp->get_longtext( ) ).
    ENDTRY.


    DATA(act)  = gr_under_test->get_almsg( ).
    DATA(ext)  = gr_under_test->build_almsg( l_objid_msgtext ).
    cl_abap_unit_assert=>assert_equals( act = act
                                        exp = ext ).

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_ctx_objid( )
      exp   = co_request_id
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_einri( )
      exp   = co_institution_id
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_ctx_patnr( )
      exp   = co_patient_id
    ).

  ENDMETHOD.

  METHOD init_by_asyncevent_req_id.

    CLEAR  gs_event_data-tc-req_type.

    TRY.
        gr_under_test->init_by_asyncevent( get_event_data( ) ).
      CATCH cx_ish_static_handler  INTO DATA(lx_exp).
        cl_abap_unit_assert=>fail( msg = 'init by asyncevent raised exception'
                                   detail = lx_exp->get_longtext( ) ).
    ENDTRY.


    DATA(act)  = gr_under_test->get_almsg( ).
    DATA(ext)  = gr_under_test->build_almsg( co_request_id   ).
    cl_abap_unit_assert=>assert_equals( act = act
                                        exp = ext ).

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_ctx_objid( )
      exp   = co_request_id
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_einri( )
      exp   = co_institution_id
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_ctx_patnr( )
      exp   = co_patient_id
    ).

  ENDMETHOD.

  METHOD init_by_asyncevent_fail .

    DATA ls_n1asyncevent TYPE n1asyncevent.

    TRY.
        ls_n1asyncevent = get_event_data( ).
        ls_n1asyncevent-evapplid = 'DUMMY'.
        gr_under_test->init_by_asyncevent( ls_n1asyncevent  ).
      CATCH cx_ish_static_handler INTO DATA(lx_exp).
        cl_abap_unit_assert=>assert_equals(
          act   = lx_exp->gr_msgtyp
          exp   = 'E'
     ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
