*----------------------------------------------------------------------*
***INCLUDE LN1TC_DIALOGP01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&       Class (Implementation)  lcl_tc_ttc_helper
*&---------------------------------------------------------------------*
*        Text
*----------------------------------------------------------------------*
CLASS lcl_tc_ttc_helper IMPLEMENTATION.
  METHOD constructor.
    gs_data = is_data.
  ENDMETHOD.                    "constructor

*Begin MED-70773 by C5004356
  METHOD check_patient_companion.

  TYPES BEGIN OF movement.
  TYPES: falnr TYPE nfal-falnr,
         falar TYPE nfal-falar,
         bewty TYPE nbew-bewty,
         bwart TYPE nbew-bwart,
         planb TYPE nbew-planb,
         bwidt TYPE nbew-bwidt,
         bwizt TYPE nbew-bwizt,
         bwedt TYPE nbew-bwedt,
         bwezt TYPE nbew-bwezt,
         erdat TYPE nbew-erdat,
         orgfa TYPE nbew-orgfa,
         orgpf TYPE nbew-orgpf,
         compa TYPE ish_on_off.
  TYPES END OF movement.

  DATA: lt_mov            TYPE TABLE OF movement,
        lt_tn14b          TYPE TABLE OF tn14b,
        l_message         TYPE string.

  FIELD-SYMBOLS: <mov>      TYPE movement.


  SELECT a~falnr a~falar b~bewty b~bwart b~bwidt b~bwizt
         b~bwedt b~bwezt b~orgpf b~orgfa b~planb b~erdat
           INTO CORRESPONDING FIELDS OF TABLE lt_mov
           FROM ( nfal AS a
             INNER JOIN nbew AS b ON a~falnr = b~falnr AND
                                     a~einri = b~einri )
             WHERE a~patnr = i_patient_id
             AND   a~einri = gs_data-institution_id
             and   a~falnr = i_case_id
             AND   b~storn = ' '.

  SELECT * FROM tn14b INTO TABLE lt_tn14b WHERE einri EQ gs_data-institution_id
                                            AND ( beglt EQ ON OR beglm EQ ON )
    ORDER BY einri bewty bwart.

  IF lt_tn14b IS NOT INITIAL.
*Merge companion mvmnt types into mvmnt table
    LOOP AT lt_mov ASSIGNING <mov>.
      IF <mov>-bewty = '1'." Admission
        READ TABLE lt_tn14b WITH KEY bewty = <mov>-bewty bwart = <mov>-bwart TRANSPORTING NO FIELDS
          BINARY SEARCH.
        IF sy-subrc = 0.
          r_companion = ON.
          RETURN.
        ENDIF.
      ENDIF.
    ENDLOOP.
    LOOP AT lt_mov ASSIGNING <mov>.
      IF <mov>-bewty = '4'." outpat visit
        READ TABLE lt_tn14b WITH KEY bewty = <mov>-bewty bwart = <mov>-bwart TRANSPORTING NO FIELDS
          BINARY SEARCH.
        IF sy-subrc = 0.
          r_companion = ON.
          RETURN.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDIF.

 ENDMETHOD.                    "check_patient_companion
*End MED-70773 by C5004356

  METHOD check_emergency_possible.

***********************************************************************
* an emergency is possible, if the patient is in the hospital
***********************************************************************
    DATA lt_cases TYPE ish_t_falnr.
    DATA l_falnr TYPE falnr.

* BEGIN MED-46861 #RISK#

*    IF gs_data-case_id IS INITIAL.
      SELECT falnr FROM nfal INTO TABLE lt_cases WHERE einri = gs_data-institution_id
                                                 AND patnr = gs_data-patient_id
                                                 AND storn NE 'X'.

      LOOP AT lt_cases INTO l_falnr.
        r_emergency_possible = check_patient_present( i_case_id = l_falnr ).
        IF r_emergency_possible = on.
          RETURN.
        ENDIF.
      ENDLOOP.
*    ELSE.
*      r_emergency_possible = check_patient_present( i_case_id = gs_data-case_id ).
*    ENDIF.

* END MED-46861 #RISK#

  ENDMETHOD.                    "check_emergency_possible

  METHOD check_patient_present.
***********************************************************************
* check if case is nor cloased so patien is stay in the hospital
***********************************************************************
    DATA ls_nfal TYPE nfal.

    CALL FUNCTION 'ISH_READ_NFAL'
      EXPORTING
        ss_einri           = gs_data-institution_id
        ss_falnr           = i_case_id
*       SS_READ_DB         = ' '
*       SS_CHECK_AUTH      = 'X'
        ss_message_no_auth = ' '
*       SS_NO_BUFFERING    = ' '
*       SS_CHECK_ARCHIVE   = ' '
        i_tc_auth          = ' '
      IMPORTING
        ss_nfal            = ls_nfal
*       SS_PATNR_ARCHIVE   =
      EXCEPTIONS
        not_found          = 1
        not_found_archived = 2
        no_authority       = 3
        OTHERS             = 4.
    IF sy-subrc <> 0.
      r_emergency_possible = off.
    ENDIF.

    IF ls_nfal-falar = 2.
      r_emergency_possible = check_out_patient_present( i_case_id = i_case_id ).
    ELSE.
      r_emergency_possible = check_in_patient_present( i_case_id = i_case_id ).
    ENDIF.

  ENDMETHOD.                    "check_patient_present

  METHOD check_out_patient_present.
    DATA ls_case_opt TYPE rnsfalnr.
    DATA lt_case_opt TYPE TABLE OF rnsfalnr.
    DATA lt_bew TYPE TABLE OF v_nbew.

    r_emergency_possible = off.

    ls_case_opt-sign = 'I'.
    ls_case_opt-option = 'EQ'.
    ls_case_opt-low = i_case_id.

    APPEND ls_case_opt TO lt_case_opt.

    CALL FUNCTION 'ISH_GET_MOVEMENTS'
      EXPORTING
        ss_abwes    = ' '
*       SS_AMBU     = 'X'
*       SS_AMBU_BES = 'X'
        ss_aufn     = ' '
*       SS_BEGINN   = SY-DATUM
        ss_einri    = gs_data-institution_id
        ss_ende     = sy-datum
        ss_entl     = ' '
*       SS_PLAN     = ' '
        SS_REFRESH  = 'X'
*       SS_STAT     = 'X'
*       SS_STORN    = ' '
*       SS_TSTAT    = 'X'
        ss_verl     = ' '
        SS_BUFFER   = ' '
      TABLES
        ss_falnr    = lt_case_opt
        ss_vnbew    = lt_bew
*       SS_FIELDCAT =
      EXCEPTIONS
        not_found   = 1
        OTHERS      = 2.
    IF sy-subrc = 0.
      r_emergency_possible = on.
      RETURN.
    ENDIF.

    CALL FUNCTION 'ISH_GET_MOVEMENTS'
      EXPORTING
        ss_abwes    = ' '
*       SS_AMBU     = 'X'
*       SS_AMBU_BES = 'X'
        ss_aufn     = ' '
*       SS_BEGINN   = SY-DATUM
        ss_einri    = gs_data-institution_id
        ss_ende     = '99991231'
        ss_entl     = ' '
*       SS_PLAN     = ' '
*       SS_REFRESH  = ' '
*       SS_STAT     = 'X'
*       SS_STORN    = ' '
*       SS_TSTAT    = 'X'
        ss_verl     = ' '
*       SS_BUFFER   = 'X'
      TABLES
        ss_falnr    = lt_case_opt
        ss_vnbew    = lt_bew
*       SS_FIELDCAT =
      EXCEPTIONS
        not_found   = 1
        OTHERS      = 2.

    IF sy-subrc = 0.
      r_emergency_possible = on.
      RETURN.
    ENDIF.

  ENDMETHOD.                    "check_out_patient_present

  METHOD check_in_patient_present.
    DATA ls_case_opt TYPE rnsfalnr.
    DATA lt_case_opt TYPE TABLE OF rnsfalnr.
    DATA lt_bew TYPE TABLE OF v_nbew.

    r_emergency_possible = off.

    ls_case_opt-sign = 'I'.
    ls_case_opt-option = 'EQ'.
    ls_case_opt-low = i_case_id.

    APPEND ls_case_opt TO lt_case_opt.

    CALL FUNCTION 'ISH_GET_MOVEMENTS'
      EXPORTING
*       SS_ABWES    = 'X'
        ss_ambu     = ' '
        ss_ambu_bes = ' '
*       SS_AUFN     = 'X'
*       SS_BEGINN   = SY-DATUM
        ss_einri    = gs_data-institution_id
        ss_ende     = '99991231'
*       SS_ENTL     = 'X'
*       SS_PLAN     = ' '
        SS_REFRESH  = 'X'
*       SS_STAT     = 'X'
*       SS_STORN    = ' '
*       SS_TSTAT    = 'X'
*       SS_VERL     = 'X'
        SS_BUFFER   = ' '
      TABLES
        ss_falnr    = lt_case_opt
        ss_vnbew    = lt_bew
*       SS_FIELDCAT =
      EXCEPTIONS
        not_found   = 1
        OTHERS      = 2.
    IF sy-subrc = 0.
      r_emergency_possible = on.
      RETURN.
    ENDIF.

  ENDMETHOD.                    "check_in_patient_present

  METHOD destroy.
    CLEAR gs_data.
  ENDMETHOD.                    "destroy

ENDCLASS.               "lcl_tc_ttc_helper
