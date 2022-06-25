*----------------------------------------------------------------------*
***INCLUDE LN1WPF02.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  FILL_PENDING_ACTIVITY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_cs_care_unit_list  text
*      <--P_LR_HELPER_CLASS  text
*----------------------------------------------------------------------*
FORM fill_pending_activity  CHANGING cs_care_unit_list TYPE rnwp_care_unit_list
                                     cr_helper_class TYPE REF TO cl_ishmed_me_dp_001_helper.

*IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 09/07/2018

  DATA: l_column_indicator TYPE nwcolumn_icons,
        l_description      TYPE string,
        l_icon             TYPE nwicon,
        l_rc               TYPE ish_method_rc.

  IF cr_helper_class IS NOT BOUND.
    cl_ishmed_me_dp_001_helper=>create( IMPORTING er_instance = cr_helper_class ).
  ENDIF.

  cr_helper_class->set( EXPORTING i_patient_id   = cs_care_unit_list-patnr
                                  i_case_id      = cs_care_unit_list-falnr
                                  i_institution  = cs_care_unit_list-einri ).

  cr_helper_class->determine_emar_act_indicator(
                        EXPORTING i_department_id     = cs_care_unit_list-orgfa
                                  i_treatment_unit_id = cs_care_unit_list-orgpf
                        IMPORTING e_rc               = l_rc
                                  e_column_indicator = l_column_indicator
                                  e_description      = l_description ).

  IF l_rc EQ 0 AND l_column_indicator IS NOT INITIAL.
    PERFORM get_icon USING l_column_indicator CHANGING l_icon.
    CONCATENATE l_icon(3) '\Q' l_description '@' INTO cs_care_unit_list-emar_pend_act.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  LOAD_EMAR_BUFFERS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM load_emar_buffers .
*IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 09/07/2018
  DATA:lt_falnr_list TYPE TABLE OF falnr,
       ls_nfal       TYPE nfal,
       ls_fal        TYPE ty_fal.

  LOOP AT gt_fal INTO ls_fal.
    ls_nfal-falnr = ls_fal-falnr.
    APPEND ls_nfal-falnr TO lt_falnr_list.
  ENDLOOP.

  cl_ishmed_me_dp_001_helper=>load_buffers( EXPORTING it_cases_list    = lt_falnr_list
                                                      i_institution_id = g_institution ).
ENDFORM.
