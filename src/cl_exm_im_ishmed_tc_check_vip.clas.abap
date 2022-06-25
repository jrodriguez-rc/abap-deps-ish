class CL_EXM_IM_ISHMED_TC_CHECK_VIP definition
  public
  final
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_ISHMED_TC_CHECK .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISHMED_TC_CONSTANT_DEF .

  methods CONSTRUCTOR .
protected section.
private section.

  data GR_STANDARD_TC_CHECK type ref to IF_EX_ISHMED_TC_CHECK .
ENDCLASS.



CLASS CL_EXM_IM_ISHMED_TC_CHECK_VIP IMPLEMENTATION.


  method CONSTRUCTOR.

     CREATE OBJECT gr_standard_tc_check TYPE cl_im_ishmed_tc_check.

  endmethod.


  method IF_EX_ISHMED_TC_CHECK~CHECK.

    DATA: l_tc_exist        TYPE ish_true_false VALUE if_ish_constant_definition~false,
          l_tc_req_possible TYPE ish_true_false VALUE if_ish_constant_definition~false,
          l_resp_type       TYPE n1tc_ou_resp_type VALUE if_ishmed_tc_constant_def~co_resp_type_patient.

    CHECK gr_standard_tc_check IS BOUND.

*Call IS-H*Med Standard Check of Treatment Authorisation:
    CALL METHOD gr_standard_tc_check->check
      EXPORTING
        i_institution_id      = i_institution_id
        i_patient_id          = i_patient_id
        i_case_id             = i_case_id
        it_matrix             = it_matrix
      IMPORTING
        e_tc_request_possible = l_tc_req_possible
        e_tc_exist            = l_tc_exist
        e_resp_type           = l_resp_type.

*In case TA is given, additonally check if patient is a VIP:
    IF l_tc_exist = if_ish_constant_definition~true.

      CALL METHOD CL_EXM_IM_ISH_TC_CHECK_VIP=>check_vip
        EXPORTING
          i_institution_id      = i_institution_id
          i_patient_id          = i_patient_id
          it_matrix             = it_matrix
        IMPORTING
          e_tc_exist            = l_tc_exist
          e_tc_request_possible = l_tc_req_possible.

    ENDIF.

    e_tc_request_possible = l_tc_req_possible.
    e_resp_type           = l_resp_type.
    e_tc_exist            = l_tc_exist.

  endmethod.


  method IF_EX_ISHMED_TC_CHECK~CHECK_PATIENT_PROVISIONAL.

    DATA: l_tc_exist        TYPE ish_true_false VALUE if_ish_constant_definition~false.


    CHECK gr_standard_tc_check IS BOUND.

*Note: Provisional patients do not have a VIP indicator.
*Call IS-H*Med Standard Check of Treatment Authorisation:
    CALL METHOD gr_standard_tc_check->check_patient_provisional
      EXPORTING
        i_institution_id         = i_institution_id
        i_patient_provisional_id = i_patient_provisional_id
        it_matrix                = it_matrix
      IMPORTING
        e_tc_exist               = l_tc_exist.

    e_tc_exist = l_tc_exist.

  endmethod.
ENDCLASS.
