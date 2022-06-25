FUNCTION ishmed_vm_get_roles_for_user .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_UNAME) TYPE  SYST_UNAME DEFAULT SY-UNAME
*"     VALUE(I_PLACETYPE) TYPE  NWPLACETYPE DEFAULT '001'
*"  EXPORTING
*"     REFERENCE(E_REFUSER) TYPE  US_REFUS
*"     REFERENCE(ET_ROLES) TYPE  USTYP_T_AGR
*"  EXCEPTIONS
*"      UNAME_NOT_EXIST
*"----------------------------------------------------------------------

  DATA: lt_rollen_user    TYPE ustyp_t_agr,
        lt_rollen_refuser TYPE ustyp_t_agr,
        l_refuser         TYPE us_refus,
        ls_ssm_cust       TYPE ssm_cust.

  REFRESH: lt_rollen_user.
  REFRESH: lt_rollen_refuser.

  CLEAR l_refuser.

* Aktivitätsgruppen (Rollen) des Benutzers lesen (gepuffert)
  CALL FUNCTION 'SUSR_USER_AGR_ACTIVITYGR_GET'
    EXPORTING
      user_name           = i_uname
    TABLES
      user_activitygroups = lt_rollen_user.

  DELETE lt_rollen_user WHERE from_dat > sy-datum
                           OR to_dat   < sy-datum.


  IF i_placetype = '001'.             " Reference User only for Clinical Workplace

    SELECT SINGLE * FROM ssm_cust INTO ls_ssm_cust WHERE id = 'REFUS_EASY'.
  IF sy-subrc = 0 AND ls_ssm_cust-path EQ 'YES'.
    CLEAR l_refuser.
    SELECT SINGLE refuser FROM usrefus INTO l_refuser WHERE bname = i_uname. "#EC CI_GENBUFF
    IF NOT l_refuser IS INITIAL.
*   Aktivitätsgruppen (Rollen) des Referenzbenutzers lesen (gepuffert)
      CALL FUNCTION 'SUSR_USER_AGR_ACTIVITYGR_GET'
        EXPORTING
          user_name           = l_refuser
        TABLES
          user_activitygroups = lt_rollen_refuser.

      DELETE lt_rollen_refuser WHERE from_dat > sy-datum
                                  OR to_dat   < sy-datum.

      APPEND LINES OF lt_rollen_refuser TO lt_rollen_user.
      SORT lt_rollen_user BY agr_name.
      DELETE ADJACENT DUPLICATES FROM lt_rollen_user COMPARING agr_name.
      ENDIF.
    ENDIF.
  ENDIF.

  e_refuser = l_refuser.
  et_roles = lt_rollen_user.

ENDFUNCTION.
