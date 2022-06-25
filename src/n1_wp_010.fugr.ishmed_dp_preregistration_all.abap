FUNCTION ISHMED_DP_PREREGISTRATION_ALL.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_PATIENT_RELATED) TYPE  ISH_ON_OFF DEFAULT ' '
*"     REFERENCE(IT_DISPVAR) TYPE  LVC_T_FCAT
*"  EXPORTING
*"     REFERENCE(ET_PREREG_LIST) TYPE  ISH_T_PREREG_LIST
*"  CHANGING
*"     REFERENCE(CT_SELVAR) TYPE  TY_RSPARAMS
*"----------------------------------------------------------------------

DATA:   l_rc                  TYPE ish_method_rc,
        l_done                TYPE ish_on_off.

* read the view data for ish
  CALL FUNCTION 'ISH_DP_PREREGISTRATION'
    EXPORTING
      i_patient_related    = i_patient_related
    TABLES
      i_selection_criteria = ct_selvar
      i_dispvar            = it_dispvar
*      i_ish_objects        =
      e_prereg_list        = et_prereg_list
    EXCEPTIONS
      no_prereg_exist      = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

* read the view data for ishmed
  CALL FUNCTION 'ISHMED_DP_PREREGISTRATION'
    EXPORTING
      i_dispvar            = it_dispvar
    TABLES
      t_prereg_list        = et_prereg_list
      t_selection_criteria = ct_selvar.

* BAdI ISH_WP_PREREG_VIEW
  PERFORM call_userexit_disp(SAPLN_WP_010)
                TABLES   et_prereg_list
                USING    it_dispvar[]
                CHANGING l_rc
                         l_done.

ENDFUNCTION.
