CLASS ltc_ishmed_evappl_tc_pao  DEFINITION DEFERRED.
CLASS cl_ishmed_evappl_tc       DEFINITION LOCAL FRIENDS ltc_ishmed_evappl_tc_pao .
CLASS ltc_ishmed_evappl_tc_pao  DEFINITION FOR TESTING   ##class_final
  DURATION SHORT
  RISK LEVEL HARMLESS
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>ltc_Ishmed_Evappl_Tc_Pao
*?</TEST_CLASS>
*?<TEST_MEMBER>gr_under_test
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>CL_ISHMED_EVAPPL_TC
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
    CLASS-DATA gr_evmaster                TYPE REF TO cl_ishmed_evmaster.
    DATA       gr_under_test              TYPE REF TO cl_ishmed_evappl_tc.  "class under test

    CONSTANTS co_request_id               TYPE n1tc_request_id    VALUE 'co_reqid_______________________I'.
    CONSTANTS co_institution_id           TYPE einri              VALUE 'UTZZ'.
    CONSTANTS co_patient_id               TYPE patnr              VALUE 'UT00012345'.

    CLASS-METHODS class_setup.
    METHODS setup.
    METHODS get_evdef
      IMPORTING
        !i_evdefid      TYPE n1evdefid
      RETURNING
        VALUE(rr_evdef) TYPE REF TO cl_ishmed_evdef.

    METHODS get_type                      FOR TESTING.

    METHODS is_inherited_from_same        FOR TESTING.
    METHODS is_inherited_from_base        FOR TESTING.
    METHODS is_inherited_from_fail        FOR TESTING.

    METHODS get_clsname                   FOR TESTING.
    METHODS get_async_event_data          FOR TESTING.
    METHODS get_clsname_alappl            FOR TESTING.

    METHODS is_logable_evdef_created      FOR TESTING.
    METHODS is_logable_evdef_init         FOR TESTING.
    METHODS is_logable_evdef_other        FOR TESTING.

    METHODS get_doku_obj                  FOR TESTING.
    METHODS get_doku_obj_for_evdef        FOR TESTING.

    METHODS get_evdef_name                FOR TESTING.
    METHODS get_evdef_name_others         FOR TESTING.

    METHODS get_evdef_short_name          FOR TESTING.
    METHODS get_evdef_short_name_others   FOR TESTING.

    METHODS get_initial_id                FOR TESTING.
    METHODS get_short_name                FOR TESTING.
ENDCLASS.       "ltc_Ishmed_Evappl_Tc_Pao


CLASS ltc_ishmed_evappl_tc_pao IMPLEMENTATION.

  METHOD class_setup.

    TRY.
        gr_evmaster = cl_ishmed_evmaster=>create( ).
      CATCH cx_root    ##CATCH_ALL.
        CLEAR gr_evmaster.
        cl_abap_unit_assert=>fail(
            msg    = 'Could not create evmaster'
            level  = if_aunit_constants=>critical
            quit   = if_aunit_constants=>class
        ).
    ENDTRY.

  ENDMETHOD.

  METHOD setup.

    TRY.
        gr_under_test ?= gr_evmaster->get_evmappl_by_id( i_evapplid = cl_ishmed_evappl_tc=>co_evapplid_tc )->get_evappl( ).
      CATCH cx_root    ##CATCH_ALL.
        CLEAR gr_under_test.
        cl_abap_unit_assert=>fail(
            msg    = 'Could not retrieve gr_under_test! '
            level  = if_aunit_constants=>critical
            quit   = if_aunit_constants=>class
        ).
    ENDTRY.

  ENDMETHOD.

  METHOD get_evdef.

    DATA(lr_evloader) = gr_under_test->get_evloader( ).
    DATA(lr_evappl) = lr_evloader->get_evappl_by_id( i_evapplid = cl_ishmed_evappl_tc=>co_evapplid_tc ).
    rr_evdef = lr_evappl->get_evdef_by_id( i_evdefid = i_evdefid ).

  ENDMETHOD.

  METHOD get_type.

    DATA l_object_type TYPE ish_object_type.

    gr_under_test->if_ish_identify_object~get_type( IMPORTING e_object_type = l_object_type ).

    cl_abap_unit_assert=>assert_equals( act = l_object_type
                                        exp = cl_ishmed_evappl_tc=>co_otype_evappl_tc
    ).

  ENDMETHOD.

  METHOD is_inherited_from_same.

    cl_abap_unit_assert=>assert_true( gr_under_test->if_ish_identify_object~is_inherited_from( cl_ishmed_evappl_tc=>co_otype_evappl_tc ) ).

  ENDMETHOD.

  METHOD is_inherited_from_base.

    cl_abap_unit_assert=>assert_true( gr_under_test->if_ish_identify_object~is_inherited_from( cl_ishmed_evappl=>co_otype_evappl ) ).

  ENDMETHOD.

  METHOD is_inherited_from_fail.

    cl_abap_unit_assert=>assert_false( gr_under_test->if_ish_identify_object~is_inherited_from( 999 ) ).

  ENDMETHOD.

  METHOD get_clsname.

    cl_abap_unit_assert=>assert_equals(
      act = cl_ishmed_evappl_tc=>if_ishmed_fac_evappl~get_clsname(  )
      exp =  'CL_ISHMED_EVAPPL_TC' ).

  ENDMETHOD.

  METHOD get_async_event_data.

    DATA lr_event        TYPE REF TO cl_ishmed_event_tc.

    DATA ls_event_data   TYPE rn1tc_event_data.
    DATA l_exp_data      TYPE n1serialized.
    DATA ls_act_data     TYPE n1serialized.

    ls_event_data-tc-patient_id                  = co_patient_id.
    ls_event_data-tc-institution_id              = co_institution_id.
    ls_event_data-tc-request_id                  = co_request_id.

    CALL TRANSFORMATION id
        SOURCE struct = ls_event_data
                RESULT XML l_exp_data.

    CREATE OBJECT lr_event
      EXPORTING
        is_tc_ev_data   = ls_event_data
        i_evdefid       = cl_ishmed_evappl=>co_evdefid_created
        i_repid         = sy-repid.
    TRY.
        ls_act_data = gr_under_test->if_ishmed_logable_evappl~get_async_event_data( lr_event ).
      CATCH cx_ish_static_handler INTO DATA(lx_exp).
        cl_abap_unit_assert=>fail( msg    = 'Should not fail'
                                   detail = lx_exp->get_text( ) ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals( act = ls_act_data
                                        exp = l_exp_data ).


  ENDMETHOD.

  METHOD get_clsname_alappl.

    cl_abap_unit_assert=>assert_equals( act = gr_under_test->if_ishmed_logable_evappl~get_clsname_alappl( )
                                        exp = 'CL_ISHMED_ALAPPL_TC' ).

  ENDMETHOD.

  METHOD is_logable_evdef_created.

    cl_abap_unit_assert=>assert_true( gr_under_test->if_ishmed_logable_evappl~is_logable_evdef( get_evdef( cl_ishmed_evappl_tc=>co_evdefid_created ) ) ).

  ENDMETHOD.

  METHOD is_logable_evdef_init.

    DATA lr_evdef    TYPE REF TO cl_ishmed_evdef ##NEEDED.
    cl_abap_unit_assert=>assert_false( gr_under_test->if_ishmed_logable_evappl~is_logable_evdef( lr_evdef ) ).

  ENDMETHOD.

  METHOD is_logable_evdef_other.

    DATA(lr_evloader) = gr_under_test->get_evloader( ).
    DATA(lr_evappl)   = lr_evloader->get_evappl_by_id( i_evapplid = cl_ishmed_evappl_allergy=>co_evapplid_allergy ).
    DATA(lr_evdef)    = lr_evappl->get_evdef_by_id( i_evdefid = cl_ishmed_evappl_allergy=>co_evdefid_created ).

    cl_abap_unit_assert=>assert_false( gr_under_test->if_ishmed_logable_evappl~is_logable_evdef( lr_evdef ) ).

  ENDMETHOD.

  METHOD get_doku_obj.

    cl_abap_unit_assert=>assert_equals(
      act = gr_under_test->get_doku_obj(  )
      exp = cl_ishmed_evappl_tc=>co_doku_obj_evappl_tc
      ).

  ENDMETHOD.

  METHOD get_doku_obj_for_evdef.

    cl_abap_unit_assert=>assert_equals(
    act = gr_under_test->get_doku_obj_for_evdef( gr_under_test->get_evdef_by_id( gr_under_test->co_evdefid_created  ) )
    exp = cl_ishmed_evappl_tc=>co_doku_obj_evdef_tc_created ).

  ENDMETHOD.

  METHOD get_evdef_name.

    CONCATENATE TEXT-001 TEXT-002 INTO DATA(l_name) SEPARATED BY space.
    cl_abap_unit_assert=>assert_equals(
            act = gr_under_test->get_evdef_name( cl_ishmed_evappl_tc=>co_evdefid_created )
            exp = l_name  ).

  ENDMETHOD.

  METHOD get_evdef_name_others.

    cl_abap_unit_assert=>assert_equals(
            act = gr_under_test->get_evdef_name( 'other' )
            exp = 'other'  ).

  ENDMETHOD.

  METHOD get_evdef_short_name.

    cl_abap_unit_assert=>assert_equals(
            act = gr_under_test->get_evdef_short_name( cl_ishmed_evappl_tc=>co_evdefid_created )
            exp = TEXT-004 ).


  ENDMETHOD.

  METHOD get_evdef_short_name_others.

    cl_abap_unit_assert=>assert_equals(
            act = gr_under_test->get_evdef_short_name( 'other' )
            exp = 'other' ).

  ENDMETHOD.

  METHOD get_initial_id.

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_initial_id(  )
      exp   = gr_under_test->co_evapplid_tc ).

  ENDMETHOD.

  METHOD get_short_name.

    cl_abap_unit_assert=>assert_equals(
      act   = gr_under_test->get_short_name(  )
      exp   = TEXT-001 ).

  ENDMETHOD.

ENDCLASS.
