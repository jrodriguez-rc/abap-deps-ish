class CL_ISHMED_EVENT_TC definition
  public
  inheriting from CL_ISHMED_EVENT
  create public

  global friends CL_ISHMED_EVLOADER .

public section.

  interfaces IF_ISH_GET_PATIENT .
  interfaces IF_ISH_GET_INSTITUTION .

  constants CO_OTYPE_EVENT_TC type ISH_OBJECT_TYPE value 13919 ##NO_TEXT.

  methods CONSTRUCTOR
    importing
      !IS_TC_EV_DATA type RN1TC_EVENT_DATA
      !I_EVDEFID type N1EVDEFID
      !I_REPID type N1EVENTREPID
      !I_MODE type N1EVENTMODE optional
      !I_USER type N1EVENTUSER optional
      !I_TCODE type N1EVENTTCODE optional .
  class-methods RAISE
    importing
      !IS_TC_EV_DATA type RN1TC_EVENT_DATA
      !I_EVDEFID type N1EVDEFID
      !I_REPID type N1EVENTREPID
      !I_MODE type N1EVENTMODE optional
      !I_USER type N1EVENTUSER optional
      !I_TCODE type N1EVENTTCODE optional .
  class-methods RAISE_WITH_RESULT
    importing
      !IS_TC_EV_DATA type RN1TC_EVENT_DATA
      !I_EVDEFID type N1EVDEFID
      !I_REPID type N1EVENTREPID
      !I_MODE type N1EVENTMODE optional
      !I_USER type N1EVENTUSER optional
      !I_TCODE type N1EVENTTCODE optional
    returning
      value(RR_EVMGR_RESULT) type ref to CL_ISHMED_EVMGR_RESULT .

  methods DESTROY
    redefinition .
  methods GET_ASYNC_DATA
    redefinition .
  methods GET_BUSINESS_KEY
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.

  data GS_TC_EV_DATA type RN1TC_EVENT_DATA .
private section.
ENDCLASS.



CLASS CL_ISHMED_EVENT_TC IMPLEMENTATION.


  METHOD constructor.

*   Call the super constructor.
    CALL METHOD super->constructor
      EXPORTING
        i_evapplid = cl_ishmed_evappl_tc=>co_evapplid_tc
        i_evdefid  = i_evdefid
        i_repid    = i_repid
        i_mode     = i_mode
        i_user     = i_user
        i_tcode    = i_tcode.

* Set base item data
    gs_tc_ev_data = is_tc_ev_data.

  ENDMETHOD.


  METHOD destroy.
    super->destroy( ).
    CLEAR gs_tc_ev_data.
  ENDMETHOD.


  method GET_ASYNC_DATA.
*    serialize the tc event data

    CALL TRANSFORMATION id
        SOURCE struct = gs_tc_ev_data
        RESULT XML r_async_data.
  endmethod.


  METHOD get_business_key.

    r_value = gs_tc_ev_data-tc-request_id.

  ENDMETHOD.


  METHOD if_ish_get_institution~get_institution.

    r_einri = gs_tc_ev_data-tc-institution_id.

  ENDMETHOD.


  METHOD if_ish_get_patient~get_patient.

    CLEAR e_patnr.
    CLEAR e_papid.
    CLEAR er_pap.
    CLEAR e_rc.

    e_patnr = gs_tc_ev_data-tc-patient_id.

  ENDMETHOD.


  METHOD if_ish_identify_object~get_type.
    e_object_type = co_otype_event_tc.
  ENDMETHOD.


  METHOD if_ish_identify_object~is_inherited_from.
    IF i_object_type = co_otype_event_tc.
      r_is_inherited_from = on.
    ELSE.
      r_is_inherited_from = super->is_inherited_from( i_object_type ).
    ENDIF.
  ENDMETHOD.


  METHOD raise.

    DATA: lr_event  TYPE REF TO cl_ishmed_event_tc.

* Create the event object.
    CREATE OBJECT lr_event
      EXPORTING
        is_tc_ev_data = is_tc_ev_data
        i_evdefid     = i_evdefid
        i_mode        = i_mode
        i_user        = i_user
        i_tcode       = i_tcode
        i_repid       = i_repid.

* Process the event.
    cl_ishmed_evmgr=>process_event_with_result( lr_event ).

* Destroy the event object.
    lr_event->destroy( ).

  ENDMETHOD.


  METHOD raise_with_result.

    DATA: lr_event  TYPE REF TO cl_ishmed_event_tc.

* Create the event object.
    CREATE OBJECT lr_event
      EXPORTING
        is_tc_ev_data = is_tc_ev_data
        i_evdefid     = i_evdefid
        i_mode        = i_mode
        i_user        = i_user
        i_tcode       = i_tcode
        i_repid       = i_repid.

* Process the event.
    rr_evmgr_result = cl_ishmed_evmgr=>process_event_with_result( lr_event ).

* Destroy the event object.
    lr_event->destroy( ).

  ENDMETHOD.
ENDCLASS.
