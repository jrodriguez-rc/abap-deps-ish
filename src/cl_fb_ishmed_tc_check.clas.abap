class CL_FB_ISHMED_TC_CHECK definition
  public
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_ISHMED_TC_CHECK .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISHMED_TC_CONSTANT_DEF .
protected section.

  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases RESP_TYPE_CASE
    for IF_ISHMED_TC_CONSTANT_DEF~CO_RESP_TYPE_CASE .
  aliases RESP_TYPE_PATIENT
    for IF_ISHMED_TC_CONSTANT_DEF~CO_RESP_TYPE_PATIENT .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .

  class-data GRT_PREREG_STATUS type ISH_T_RANGEVKGST .

  methods CHECK_MOVEMENTS
    importing
      !I_INSTITUTION_ID type EINRI
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR optional
      !IT_MATRIX type RN1TC_MATRIX_T
    exporting
      !E_TC_REQUEST_POSSIBLE type ISH_TRUE_FALSE
      !E_TC_EXIST type ISH_TRUE_FALSE
      !E_RESP_TYPE type N1TC_OU_RESP_TYPE
    changing
      !C_TC_SPECIAL_REQUEST type ISH_TRUE_FALSE optional
      !C_TC_COMPANION type ISH_TRUE_FALSE optional .
  methods CHECK_APPOINTMENTS
    importing
      !I_INSTITUTION_ID type EINRI
      !I_PATIENT_ID type PATNR optional
      !I_PATIENT_PROVISIONAL_ID type ISH_PAPID optional
      !IT_MATRIX type RN1TC_MATRIX_T
    exporting
      !E_TC_EXIST type ISH_TRUE_FALSE
      !E_RESP_TYPE type N1TC_OU_RESP_TYPE
    changing
      !C_TC_REQUEST_POSSIBLE type ISH_TRUE_FALSE optional
      !C_TC_SPECIAL_REQUEST type ISH_TRUE_FALSE optional .
  methods CHECK_PREREGISTRATIONS
    importing
      !I_INSTITUTION_ID type EINRI
      !I_PATIENT_ID type PATNR optional
      !I_PATIENT_PROVISIONAL_ID type ISH_PAPID optional
      !IT_MATRIX type RN1TC_MATRIX_T
    exporting
      !E_TC_EXIST type ISH_TRUE_FALSE
      !E_RESP_TYPE type N1TC_OU_RESP_TYPE
    changing
      !C_TC_REQUEST_POSSIBLE type ISH_TRUE_FALSE optional
      !C_TC_SPECIAL_REQUEST type ISH_TRUE_FALSE optional .
private section.
ENDCLASS.



CLASS CL_FB_ISHMED_TC_CHECK IMPLEMENTATION.


METHOD check_appointments.

  TYPES BEGIN OF appointment.
  TYPES: falnr TYPE ntmn-falnr,                  "note 2104867
         tmnlb TYPE ntmn-tmnlb,                                     " MED-62667 Note 2360294 Bi
         bwidt TYPE napp-bwidt,
         bwizt TYPE napp-bwizt,
         orgfa TYPE napp-orgfa,
         orgpf TYPE napp-orgpf,
         erdat TYPE ntmn-erdat.
  TYPES END OF appointment.

  DATA: lt_app            TYPE TABLE OF appointment,
        l_days_gone       TYPE i,
        l_days_appl       TYPE i,
        l_tc_exist        TYPE ish_true_false,
        l_tc_req_possible TYPE ish_true_false,
        l_pat_in_ou       TYPE ish_true_false,
        l_usr_auth_ou     TYPE ish_true_false,
        l_message         type string,
        l_ver_date        TYPE DATS,"MED-80752
        l_lead_time       type n1tc_lead_time. "MED-80752


  FIELD-SYMBOLS: <app>      TYPE appointment,
                 <matrix>   TYPE rn1tc_matrix.

* MED-80752 Begin
  SELECT SINGLE lead_time FROM tn1tc_glob_set
         INTO l_lead_time WHERE institution_id EQ i_institution_id.
* MED-80752 End

* get appointment data of a patient with real master data
  IF i_patient_id IS SUPPLIED.
*    SELECT a~falnr a~erdat b~bwidt b~bwizt b~orgpf b~orgfa         " MED-62667 Note 2360294 Bi
    SELECT a~falnr a~tmnlb a~erdat b~bwidt b~bwizt b~orgpf b~orgfa  " MED-62667 Note 2360294 Bi
             INTO CORRESPONDING FIELDS OF TABLE lt_app
             FROM ( ntmn AS a
               INNER JOIN napp AS b ON a~tmnid = b~tmnid )
               WHERE a~patnr = i_patient_id
               AND   a~einri = i_institution_id
*               AND   a~falnr = space            "note 2104867
               AND   a~endpl = false
               AND   a~storn = off.
* get appointment data of a patient with provisional data
  ELSEIF i_patient_provisional_id IS SUPPLIED.
*    SELECT a~falnr a~erdat b~bwidt b~bwizt b~orgpf b~orgfa         " MED-62667 Note 2360294 Bi
    SELECT a~falnr a~tmnlb a~erdat b~bwidt b~bwizt b~orgpf b~orgfa  " MED-62667 Note 2360294 Bi
             INTO CORRESPONDING FIELDS OF TABLE lt_app
             FROM ( ntmn AS a
               INNER JOIN napp AS b ON a~tmnid = b~tmnid )
               WHERE a~papid = i_patient_provisional_id
               AND   a~einri = i_institution_id
*               AND   a~falnr = space            "note 2104867
               AND   a~endpl = false
               AND   a~storn = off.
  ENDIF.
* check the appointments
*  DELETE lt_app WHERE falnr <> space.            "note 2104867     " MED-62667 Note 2360294 Bi
  DELETE lt_app WHERE falnr <> space AND tmnlb <> space.            " MED-62667 Note 2360294 Bi
  SORT lt_app BY bwidt DESCENDING bwizt DESCENDING.
  l_tc_exist = false.
  e_resp_type = resp_type_patient.
  l_tc_req_possible = c_tc_request_possible.

  LOOP AT lt_app ASSIGNING <app>.
    c_tc_special_request = false.                        " note 2784755
    l_pat_in_ou = false.
    IF sy-datum BETWEEN <app>-erdat AND <app>-bwidt.
      l_pat_in_ou = true.
    ENDIF.
*   treatment contracts only on case level are not taken into account
    LOOP AT it_matrix ASSIGNING <matrix> WHERE ( resp_type = 'P'      AND
                                                 classification = 'F' AND
                                                 deptou = <app>-orgfa )
                                         OR    ( resp_type = 'P'      AND
                                                 classification = 'O' AND
                                                 deptou = <app>-orgfa AND
                                                 treaou = <app>-orgpf )
                                         OR     ( classification = '*') .  " MED-73352
      IF l_pat_in_ou = true.
* MED-80752 Begin
        l_ver_date = <app>-bwidt - l_lead_time.
        IF l_lead_time gt 0 AND ( sy-datum lt l_ver_date ) AND i_patient_id IS SUPPLIED.
          l_tc_req_possible = true.
          EXIT.
        ELSE.
        l_tc_exist = true.
        l_tc_req_possible = false.
        l_message = text-104.
        LOG-POINT ID ish_tc_check SUBKEY '52_APPOINTMENT' FIELDS l_message.
        LOG-POINT ID ish_tc_check SUBKEY '52_APPOINTMENT' FIELDS <app>-orgfa.
        LOG-POINT ID ish_tc_check SUBKEY '52_APPOINTMENT' FIELDS <app>-orgpf.
        EXIT.
      ENDIF.
* MED-80752 End
      ENDIF.
      IF l_pat_in_ou = false.
        l_days_gone = sy-datum - <app>-bwidt.
        l_days_appl = <matrix>-days_ext + <matrix>-days_appl.
*         is the allowed follow-up periode (days_ext) valid?
*         is the allowed request periode (days_appl) valid?
        IF l_days_gone <= <matrix>-days_ext OR <matrix>-days_ext = '99999'.
          l_tc_exist = true.
          l_tc_req_possible = false.
          l_message = text-105.
          LOG-POINT ID ish_tc_check SUBKEY '52_APPOINTMENT' FIELDS l_message.
          LOG-POINT ID ish_tc_check SUBKEY '52_APPOINTMENT' FIELDS <app>-orgfa.
          LOG-POINT ID ish_tc_check SUBKEY '52_APPOINTMENT' FIELDS <app>-orgpf.
          EXIT.
        ENDIF.
*MED-84361 Begin
        IF ( l_days_gone <= l_days_appl OR <matrix>-days_appl = '99999' ) AND
           i_patient_id IS SUPPLIED.
          l_tc_req_possible = true.
          EXIT.
        ENDIF.
        if ( l_days_gone <= l_days_appl or <matrix>-days_appl = '99999' ) and
           i_patient_provisional_id is supplied.
*new concept of extending the request time as follow up time for provisional patients
          l_tc_exist = true.
          l_tc_req_possible = false.
          l_message = text-105.
          LOG-POINT ID ish_tc_check SUBKEY '52_APPOINTMENT' FIELDS l_message.
          LOG-POINT ID ish_tc_check SUBKEY '52_APPOINTMENT' FIELDS <app>-orgfa.
          LOG-POINT ID ish_tc_check SUBKEY '52_APPOINTMENT' FIELDS <app>-orgpf.
          exit.
        endif.
*MED-84361 End
      ENDIF.
    ENDLOOP.
    IF l_tc_exist = true.
      EXIT.
    ENDIF.
  ENDLOOP.
  IF l_tc_exist = true.
    e_tc_exist = l_tc_exist.
    c_tc_request_possible = l_tc_req_possible.
  ELSE.
    c_tc_request_possible = l_tc_req_possible.
  ENDIF.

ENDMETHOD.


METHOD check_movements.

* note 2784755: grant Treatment contract also for companions, but level CASE

  TYPES BEGIN OF movement.
  TYPES: falnr TYPE nfal-falnr,
         falar TYPE nfal-falar,
         bewty TYPE nbew-bewty,
         bwart TYPE nbew-bwart, "Note 2040227
         planb TYPE nbew-planb,
         bwidt TYPE nbew-bwidt,
         bwizt TYPE nbew-bwizt,
         bwedt TYPE nbew-bwedt,
         bwezt TYPE nbew-bwezt,
         erdat TYPE nbew-erdat,
         orgfa TYPE nbew-orgfa,
         orgpf TYPE nbew-orgpf,
         compa TYPE ish_on_off. "Note 2040227
  TYPES END OF movement.

  DATA: lt_mov            TYPE TABLE OF movement,
        lt_mov_inp        TYPE TABLE OF movement,
        lt_mov_out        TYPE TABLE OF movement,
        lt_tn14b          TYPE TABLE OF tn14b,  "Note 2040227
        l_days_gone       TYPE i,
        l_days_appl       TYPE i,
        l_tc_exist        TYPE ish_true_false,
        l_tc_req_possible TYPE ish_true_false,
        l_pat_in_ou       TYPE ish_true_false,
        l_usr_auth_ou     TYPE ish_true_false,
        l_pat_in_hospital TYPE ish_true_false,
        l_resp_type       TYPE n1tc_ou_resp_type VALUE resp_type_patient,
        l_message         TYPE string.

  DATA: l_comp_tc                      TYPE ish_true_false,    " note 2784755
        l_comp_tc_req_possible         TYPE ish_true_false,    " note 2784755
        l_comp_tc_exist                TYPE ish_true_false,    " note 2784755
        l_comp_resp_type               TYPE n1tc_ou_resp_type, " note 2784755
        l_comp_in_hospital             TYPE ish_true_false,    " note 2784755
        l_tc_comp_in_hosp_req_possible TYPE ish_true_false,    " note 2784755
        l_comp_in_ou                   TYPE ish_true_false.    " note 2784755

  FIELD-SYMBOLS: <mov>      TYPE movement,
                 <matrix>   TYPE rn1tc_matrix,
                 <tn14b>    TYPE tn14b. "Note 2040227

* get movement data
*>Note 2040227
*  SELECT a~falnr a~falar b~bewty b~bwidt b~bwizt
  SELECT a~falnr a~falar b~bewty b~bwart b~bwidt b~bwizt
*<Note 2040227
         b~bwedt b~bwezt b~orgpf b~orgfa b~planb b~erdat
           INTO CORRESPONDING FIELDS OF TABLE lt_mov
           FROM ( nfal AS a
             INNER JOIN nbew AS b ON a~falnr = b~falnr AND
                                     a~einri = b~einri )
             WHERE a~patnr = i_patient_id
             AND   a~einri = i_institution_id
             AND   b~storn = ' '.
*>Note 2040227: Companion cases/movements shall not be considered in treatment auth checks
* Read Companion movement types
  SELECT * FROM tn14b INTO TABLE lt_tn14b WHERE einri EQ i_institution_id
                                            AND ( beglt EQ ON OR beglm EQ ON )
    ORDER BY einri bewty bwart.
  IF lt_tn14b IS NOT INITIAL.
*Merge companion mvmnt types into mvmnt table
    LOOP AT lt_mov ASSIGNING <mov>.
      IF <mov>-bewty = '1'." Admission
        READ TABLE lt_tn14b WITH KEY bewty = <mov>-bewty bwart = <mov>-bwart TRANSPORTING NO FIELDS
          BINARY SEARCH.
        IF sy-subrc = 0.
          <mov>-compa = ON.
          MODIFY lt_mov FROM <mov> TRANSPORTING compa WHERE falnr = <mov>-falnr.
        ENDIF.
      ENDIF.
    ENDLOOP.
    LOOP AT lt_mov ASSIGNING <mov>.
      IF <mov>-bewty = '4'." outpat visit
        READ TABLE lt_tn14b WITH KEY bewty = <mov>-bewty bwart = <mov>-bwart TRANSPORTING NO FIELDS
          BINARY SEARCH.
        IF sy-subrc = 0.
          <mov>-compa = ON.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDIF.
*<Note 2040227
  IF NOT lt_mov IS INITIAL.                      " note 2784755
    c_tc_special_request = false.                " note 2784755
  ENDIF.                                         " note 2784755
* check first the inpatient movements
  lt_mov_inp = lt_mov.
  DELETE lt_mov_inp WHERE bewty = '4' OR bewty = '6'.
  SORT lt_mov_inp BY bwidt DESCENDING bwizt DESCENDING.
  l_tc_exist = false.
  l_tc_req_possible = false.
  l_pat_in_hospital = false.
  LOOP AT lt_mov_inp ASSIGNING <mov>.
* BEGIN MED-46861 #RISK#
    l_pat_in_ou = false.
*   requesting a treatment contract is generally possible if
*   the patient still stays in the hospital or  if he has a
*   planed movement (planb <> space)
    IF <mov>-planb = space AND
       ( sy-datum BETWEEN <mov>-bwidt AND <mov>-bwedt OR
         <mov>-bwedt = '99991231' )                         OR
       <mov>-planb <> space AND
       sy-datum BETWEEN <mov>-erdat AND <mov>-bwidt.
      l_pat_in_ou = true.
      IF <mov>-planb = space.
        l_pat_in_hospital = true.
        l_tc_req_possible = true.
      ENDIF.
    ENDIF.
* END MED-46861 #RISK#
    LOOP AT it_matrix ASSIGNING <matrix> WHERE ( classification = 'F' AND
                                                 deptou = <mov>-orgfa )
                                         OR    ( classification = 'O' AND
                                                 deptou = <mov>-orgfa AND
                                                 treaou = <mov>-orgpf )
                                         OR    ( classification = '*' ). " MED-73352
*     treatment contract was only given on case level
      IF ( <matrix>-resp_type = 'C' or <mov>-compa = on ) AND i_case_id IS NOT INITIAL. " note 2784755
        CHECK <mov>-falnr = i_case_id.
      ENDIF.
      l_usr_auth_ou = false.
      IF <matrix>-classification = 'F' AND <matrix>-deptou = <mov>-orgfa.
        l_usr_auth_ou = true.
      ENDIF.
      IF <matrix>-classification = 'O' AND
         <matrix>-deptou = <mov>-orgfa AND
         <matrix>-treaou = <mov>-orgpf.
        l_usr_auth_ou = true.
      ENDIF.
*  MED-73352 Begin
      IF <matrix>-classification = '*'.
        l_usr_auth_ou = true.
      ENDIF.
*  MED-73352 End
      IF NOT i_case_id IS INITIAL.                       " note 2784755
*>Note 2040227: Disregard companion movements for granting the TA
*               BUT make TA requestable for companion movements according to OU customizing
*       changed system behaviour regarding companions    " note 2784755
      IF l_usr_auth_ou = true and <mov>-compa = ON.
        l_usr_auth_ou = false. " !prevent TA granting further down this loop
        IF <mov>-planb = space.
          l_days_gone = sy-datum - <mov>-bwedt.
        ENDIF.
        IF <mov>-planb <> space.
          l_days_gone = sy-datum - <mov>-bwidt.
        ENDIF.
        l_days_appl = <matrix>-days_ext + <matrix>-days_appl.
*       is the allowed request periode (days_appl) valid?
        IF l_days_gone <= l_days_appl OR <matrix>-days_appl EQ '99999'.
            IF NOT i_case_id IS INITIAL AND i_case_id = <mov>-falnr.     " note 2784755
              IF l_pat_in_ou = true or l_days_gone <= <matrix>-days_ext. " note 2784755
                l_comp_tc_exist = true.                                  " note 2784755
              ELSE.                                                      " note 2784755
                l_comp_tc_req_possible = true.                           " note 2784755
              ENDIF.                                                     " note 2784755
              l_comp_resp_type = 'C'.                                    " note 2784755
            ELSE.                                                        " note 2784755
              l_comp_tc_req_possible = true.                             " note 2784755
              l_comp_resp_type = 'C'.                                    " note 2784755
            ENDIF.                                                       " note 2784755
            EXIT. " exit matrix-loop
        ENDIF.
      ENDIF.
*<Note 2040227
      ENDIF.
      IF l_pat_in_ou = true AND l_usr_auth_ou = true.
        IF <mov>-compa = off.
        l_tc_exist = true.
        l_tc_req_possible = false.
        l_resp_type = <matrix>-resp_type.
        ELSE.
          IF i_case_id IS INITIAL.
            IF <mov>-compa = on.
              l_comp_tc_exist = true.
              l_comp_tc_req_possible = false.
              l_comp_resp_type = 'C'.
            ENDIF.
          ENDIF.
        ENDIF.
        l_message = TEXT-100.
        LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS l_message.
        LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS <mov>-orgfa.
        LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS <mov>-orgpf.
        EXIT.
      ENDIF.
      IF l_pat_in_ou = false AND l_usr_auth_ou = true.
        IF <mov>-planb = space.
          l_days_gone = sy-datum - <mov>-bwedt.
        ENDIF.
        IF <mov>-planb <> space.
          l_days_gone = sy-datum - <mov>-bwidt.
        ENDIF.
        l_days_appl = <matrix>-days_ext + <matrix>-days_appl.
*         is the allowed follow-up periode (days_ext) valid?
        IF l_days_gone <= <matrix>-days_ext OR <matrix>-days_ext EQ '99999'.
          IF <mov>-compa = off.                          " note 2784755
            l_tc_exist = true.
            l_tc_req_possible = false.
            l_resp_type = <matrix>-resp_type.
          ELSE.                                          " note 2784755
            IF i_case_id IS INITIAL.                     " note 2784755
              IF <mov>-compa = on.                       " note 2784755
                l_comp_tc_exist = true.                  " note 2784755
                l_comp_tc_req_possible = false.          " note 2784755
                l_comp_resp_type = 'C'.                  " note 2784755
              ENDIF.                                     " note 2784755
            ENDIF.                                       " note 2784755
          ENDIF.                                         " note 2784755
          l_message = text-101.
          LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS l_message.
          LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS <mov>-orgfa.
          LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS <mov>-orgpf.
        ENDIF.
*       is the allowed request periode (days_appl) valid?
        IF l_days_gone <= l_days_appl OR <matrix>-days_appl EQ '99999'.
          IF <mov>-compa = off.
            l_tc_req_possible = true.
            l_resp_type = <matrix>-resp_type.
          ELSE.
            IF i_case_id IS INITIAL.
              IF <mov>-compa = on.
                l_comp_tc_req_possible = true.
                l_comp_resp_type = 'C'.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
        EXIT.
      ENDIF.
    ENDLOOP.
    IF l_tc_exist = true.
      EXIT.
    ENDIF.
  ENDLOOP.
  e_tc_exist = l_tc_exist.
  e_tc_request_possible = l_tc_req_possible.
  e_resp_type = l_resp_type.
  IF l_tc_exist = true.
    EXIT.
  ENDIF.

* check the outpatient movements
  lt_mov_out = lt_mov.
  DELETE lt_mov_out WHERE bewty <> '4'.
  SORT lt_mov_out BY bwidt DESCENDING bwizt DESCENDING.

  LOOP AT lt_mov_out ASSIGNING <mov>.
    l_pat_in_ou = false.
*   requesting a treatment contract is generally possible if
*   the patient still stays in the hospital or  if he has a planed movement
* BEGIN MED-46861 #RISK#
    IF <mov>-planb = space AND sy-datum = <mov>-bwidt     OR
       <mov>-planb <> space AND sy-datum BETWEEN <mov>-erdat AND <mov>-bwidt.
      l_pat_in_ou = true.
      l_pat_in_hospital = true.
      l_tc_req_possible = true.
    ENDIF.
* END MED-46861 #RISK#
    LOOP AT it_matrix ASSIGNING <matrix> WHERE ( classification = 'F' AND
                                                 deptou = <mov>-orgfa )
                                         OR    ( classification = 'O' AND
                                                 deptou = <mov>-orgfa AND
                                                 treaou = <mov>-orgpf )
                                         OR    ( classification = '*' ). " MED-73352
*     treatment contract was only given on case level
      IF ( <matrix>-resp_type = 'C' or <mov>-compa = on ) AND i_case_id IS NOT INITIAL. " note 2784755
        CHECK <mov>-falnr = i_case_id.
      ENDIF.
      l_usr_auth_ou = false.
      IF <matrix>-classification = 'F' AND <matrix>-deptou = <mov>-orgfa.
        l_usr_auth_ou = true.
      ENDIF.
      IF <matrix>-classification = 'O' AND
         <matrix>-deptou = <mov>-orgfa AND
         <matrix>-treaou = <mov>-orgpf.
        l_usr_auth_ou = true.
      ENDIF.
*  MED-73352 Begin
      IF <matrix>-classification = '*'.
        l_usr_auth_ou = true.
      ENDIF.
*  MED-73352 End
      IF NOT i_case_id IS INITIAL.                       " note 2784755
*>Note 2040227: Disregard companion movements for granting the TA
*               BUT make TA requestable for companion movements according to OU customizing
*       changed system behaviour regarding companions    " note 2784755
      IF l_usr_auth_ou = true and <mov>-compa = ON.
        l_usr_auth_ou = false. " !prevent TA granting further down this loop
        IF <mov>-planb = space.
          l_days_gone = sy-datum - <mov>-bwedt.
        ENDIF.
        IF <mov>-planb <> space.
          l_days_gone = sy-datum - <mov>-bwidt.
        ENDIF.
        l_days_appl = <matrix>-days_ext + <matrix>-days_appl.
*         is the allowed request periode (days_appl) valid?
          IF l_days_gone <= l_days_appl OR <matrix>-days_appl EQ '99999'.
            IF NOT i_case_id IS INITIAL AND i_case_id = <mov>-falnr.     " note 2784755
              IF l_pat_in_ou = true or l_days_gone <= <matrix>-days_ext. " note 2784755
                l_comp_tc_exist = true.                                  " note 2784755
              ELSE.                                                      " note 2784755
                l_comp_tc_req_possible = true.                           " note 2784755
              ENDIF.                                                     " note 2784755
              l_comp_resp_type = 'C'.                                    " note 2784755
            ELSE.                                                        " note 2784755
              l_tc_req_possible = true.
              l_resp_type = <matrix>-resp_type.
            ENDIF.                                                       " note 2784755
          EXIT. " if req possible found true, exit matrix-loop
        ENDIF.
      ENDIF.
*<Note 2040227
      ENDIF.
      IF l_pat_in_ou = true AND l_usr_auth_ou = true.
        IF <mov>-compa = off.                            " note 2784755
        l_tc_exist = true.
        l_tc_req_possible = false.
        l_resp_type = <matrix>-resp_type.
        ELSE.                                            " note 2784755
          IF i_case_id IS INITIAL.                       " note 2784755
            IF <mov>-compa = on.                         " note 2784755
              l_comp_tc_exist = true.                    " note 2784755
              l_comp_tc_req_possible = false.            " note 2784755
              l_comp_resp_type = 'C'.                    " note 2784755
            ENDIF.                                       " note 2784755
          ENDIF.                                         " note 2784755
        ENDIF.                                           " note 2784755
        l_message = TEXT-102.
        LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS l_message.
        LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS <mov>-orgfa.
        LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS <mov>-orgpf.
        EXIT.
      ENDIF.
      IF l_pat_in_ou = false AND l_usr_auth_ou = true.
        IF <mov>-planb = space.
          l_days_gone = sy-datum - <mov>-bwedt.
        ENDIF.
        IF <mov>-planb <> space.
          l_days_gone = sy-datum - <mov>-bwidt.
        ENDIF.
        l_days_appl = <matrix>-days_ext + <matrix>-days_appl.
*         is the allowed follow-up periode (days_ext) valid?
        IF l_days_gone <= <matrix>-days_ext OR <matrix>-days_ext EQ '99999'.
          IF <mov>-compa = off.                          " note 2784755
            l_tc_exist = true.
            l_tc_req_possible = false.
            l_resp_type = <matrix>-resp_type.
          ELSE.                                          " note 2784755
            IF i_case_id IS INITIAL.                     " note 2784755
              IF <mov>-compa = on.                       " note 2784755
                l_comp_tc_exist = true.                  " note 2784755
                l_comp_tc_req_possible = false.          " note 2784755
                l_comp_resp_type = 'C'.                  " note 2784755
              ENDIF.                                     " note 2784755
            ENDIF.                                       " note 2784755
          ENDIF.                                         " note 2784755
          l_message = text-103.
          LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS l_message.
          LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS <mov>-orgfa.
          LOG-POINT ID ish_tc_check SUBKEY '51_MOVEMENT' FIELDS <mov>-orgpf.
        ENDIF.
*       is the allowed request periode (days_appl) valid?
        IF l_days_gone <= l_days_appl OR <matrix>-days_appl EQ '99999'.
          IF <mov>-compa = off.                          " note 2784755
            l_tc_req_possible = true.
            l_resp_type = <matrix>-resp_type.
            EXIT.                                        " note 2784755
          ELSE.                                          " note 2784755
            l_comp_tc_req_possible = false.              " note 2784755
            l_comp_resp_type = 'C'.                      " note 2784755
          ENDIF.                                         " note 2784755
        ENDIF.
        EXIT.
      ENDIF.
    ENDLOOP.
    IF l_tc_exist = true.
      EXIT.
    ENDIF.
  ENDLOOP.

* note 2784755 begin
  c_tc_companion = false.
  IF l_tc_exist = true AND l_resp_type = 'P'.
*   anwender hat sowieso BA patientenbezogen: nothing to do
  ELSEIF l_tc_exist = false AND l_comp_tc_exist = true.
    l_tc_exist = true.
    l_tc_req_possible = false.
    l_resp_type = 'C'.
    c_tc_companion = true.
  ELSEIF l_comp_tc_req_possible = true.
    l_tc_exist = false.
    l_tc_req_possible = true.
    l_resp_type = 'C'.
    c_tc_companion = true.
  ELSEIF l_tc_req_possible = true AND l_resp_type = 'P'.
    l_tc_exist = false.
    l_tc_req_possible = true.
  ENDIF.
* note 2784755 end

  e_tc_exist = l_tc_exist.
  e_tc_request_possible = l_tc_req_possible.
  e_resp_type = l_resp_type.
* if a treatment contract can be requested for a patient who has a present stay
* in the hospital, the treatment contract shall be requested on
* patient level (e_resp_type = P)
  IF e_tc_exist = false AND e_tc_request_possible = true AND
     l_pat_in_hospital = true.
    e_resp_type = resp_type_patient.
  ENDIF.
* Sinn u. Zweck dieser Zeilen ist fragwürdig u. erzeugt Fehlersituation  =>  note 1810704
* if a treatment contract is requested for a patient who hasn't a present stay
* in the hospital and without a given case Id, the treatment contract can only be
* requested for a given case Id
*  IF e_tc_exist = false AND e_tc_request_possible = true AND
*     l_pat_in_hospital = false AND i_case_id IS INITIAL.
*    e_tc_request_possible = false.
*  ENDIF.
ENDMETHOD.


method CHECK_PREREGISTRATIONS.

  TYPES BEGIN OF preregistration.
  TYPES: orgfa TYPE n1vkg-orgfa,
         trtoe TYPE n1apcn-trtoe,
         vkgid  TYPE n1vkg-vkgid,                 "MED-84361
         falnr  TYPE n1vkg-falnr,                 "note 2104867
         wdate TYPE n1apcn-wdate,
         aufds TYPE n1apcn-aufds,
         orddep TYPE n1corder-orddep,
         etroe TYPE n1corder-etroe ,
         erdat TYPE n1vkg-erdat.
  TYPES END OF preregistration.

* MED-84361 Begin
      TYPES: BEGIN OF ty_date,
               date TYPE sy-datum.
      TYPES: END OF ty_date.

      DATA: lt_date  TYPE STANDARD TABLE OF ty_date,
            lt_tmnid TYPE STANDARD TABLE OF ish_tmnid,
            l_enddat TYPE sy-datum.
* MED-84361 End

  DATA: lt_prereg         TYPE TABLE OF preregistration,
        ls_status         TYPE rnrangevkgst,
        l_status          TYPE tn42c-wlsta,
        l_date2check      TYPE d,
        l_days_gone       TYPE i,
        l_days_appl       TYPE i,
        l_tc_exist        TYPE ish_true_false,
        l_tc_req_possible TYPE ish_true_false,
        l_pat_in_ou       TYPE ish_true_false,
        l_usr_auth_ou     TYPE ish_true_false,
        l_message         TYPE string,
        l_ver_date        TYPE dats,                        "MED-80752
        l_lead_time       TYPE n1tc_lead_time.              "MED-80752

  FIELD-SYMBOLS: <prereg>   TYPE preregistration,
                 <matrix>   TYPE rn1tc_matrix.

* MED-80752 Begin
  SELECT SINGLE lead_time FROM tn1tc_glob_set
         INTO l_lead_time WHERE institution_id EQ i_institution_id.
* MED-80752 End

* get preregistrations
  l_tc_exist = false.
  l_tc_req_possible = c_tc_request_possible.

* read all active preregistration status
  IF grt_prereg_status[] IS INITIAL.
    ls_status-low = space. "when no status was set
    ls_status-option = 'EQ'.
    ls_status-sign = 'I'.
    APPEND ls_status TO grt_prereg_status.
    SELECT wlsta FROM tn42c INTO l_status
                        WHERE einri EQ i_institution_id
                        AND   wlrem EQ off.
      ls_status-low = l_status.
      APPEND ls_status TO grt_prereg_status.
    ENDSELECT.
  ENDIF.

* get preregistrations data of a patient with real master data
  IF i_patient_id IS SUPPLIED.
    SELECT a~orddep a~etroe b~vkgid b~falnr b~orgfa b~erdat c~trtoe c~wdate c~aufds
             INTO CORRESPONDING FIELDS OF TABLE lt_prereg
             FROM ( n1corder AS a
               INNER JOIN n1vkg AS b ON a~corderid = b~corderid
               INNER JOIN n1apcn AS c ON b~apcnid = c~apcnid )
               WHERE a~patnr = i_patient_id
               AND   a~einri = i_institution_id
               AND   a~wlsta IN grt_prereg_status
*               AND   b~falnr = space            "note 2104867
               AND   b~prereg = on
               AND   a~storn = off
               AND   b~storn = off.
* get appointment data of a patient with provisional data
  ELSEIF i_patient_provisional_id IS SUPPLIED.
    SELECT a~orddep a~etroe b~vkgid b~falnr b~orgfa b~erdat c~trtoe c~wdate c~aufds
             INTO CORRESPONDING FIELDS OF TABLE lt_prereg
             FROM ( n1corder AS a
               INNER JOIN n1vkg AS b ON a~corderid = b~corderid
               INNER JOIN n1apcn AS c ON b~apcnid = c~apcnid )
               WHERE a~papid = i_patient_provisional_id
               AND   a~einri = i_institution_id
               AND   a~wlsta IN grt_prereg_status
*               AND   b~falnr = space            "note 2104867
               AND   b~prereg = on
               AND   a~storn = off
               AND   b~storn = off.
  ENDIF.
* check preregistrations
  DELETE lt_prereg WHERE falnr <> space.         "note 2104867
  SORT lt_prereg BY erdat DESCENDING.

  LOOP AT lt_prereg ASSIGNING <prereg>.
    c_tc_special_request = false.                        " note 2784755
    l_pat_in_ou = false.
    CLEAR l_date2check.
    IF <prereg>-aufds IS NOT INITIAL.
      l_date2check = <prereg>-aufds.
    ELSEIF <prereg>-wdate IS NOT INITIAL.
      l_date2check = <prereg>-wdate.
    ENDIF.

* MED-84361 Begin
    IF l_date2check IS INITIAL.
      REFRESH lt_date.
      SELECT b~ibgdt INTO TABLE lt_date
        FROM nlem AS a INNER JOIN nlei AS b
          ON a~lnrls = b~lnrls
       WHERE a~vkgid    = <prereg>-vkgid
         AND b~storn    = abap_false.

      SORT lt_date BY date DESCENDING.
      LOOP AT lt_date INTO l_enddat.
        IF l_enddat IS NOT INITIAL.
          l_date2check = l_enddat.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDIF.
* MED-84361 End

    IF sy-datum BETWEEN <prereg>-erdat AND l_date2check OR
       l_date2check IS INITIAL.
      l_pat_in_ou = true.
    endif.
* MED-80752 Begin
    IF l_date2check IS NOT INITIAL.
      l_ver_date = l_date2check - l_lead_time.
    ENDIF.
* "MED-80752 End.

*   treatment contracts only on case level are not taken into account
    LOOP AT it_matrix ASSIGNING <matrix> WHERE ( resp_type = 'P'      AND
                                                 classification = 'F' and
                                                 deptou = <prereg>-orgfa )
                                         or    ( resp_type = 'P'      and
                                                 classification = 'O' and
                                                 deptou = <prereg>-orgfa and
                                                 treaou = <prereg>-trtoe )
                                         or     ( classification = '*' ).   " MED-73352
      if l_pat_in_ou = true.
* MED-80752 Begin
        IF l_date2check IS INITIAL AND i_patient_id IS SUPPLIED.
          l_tc_req_possible = true.
          EXIT.
        ELSEIF l_lead_time GT 0 AND ( sy-datum LT l_ver_date ) AND i_patient_id IS SUPPLIED.
          l_tc_req_possible = true.
          EXIT.
        ELSE.
          l_tc_exist = true.
        l_tc_req_possible = false.
        l_message = text-104.
        LOG-POINT ID ish_tc_check SUBKEY '53_PREREGISTRATION' FIELDS l_message.
        LOG-POINT ID ish_tc_check SUBKEY '53_PREREGISTRATION' FIELDS <prereg>-orgfa.
        LOG-POINT ID ish_tc_check SUBKEY '53_PREREGISTRATION' FIELDS <prereg>-orddep.
        exit.
      endif.
* "MED-80752 End.
      ENDIF.
      IF l_pat_in_ou = false AND l_date2check IS NOT INITIAL.
        l_days_gone = sy-datum - l_date2check.
        l_days_appl = <matrix>-days_ext + <matrix>-days_appl.
*         is the allowed follow-up periode (days_ext) valid?
*         is the allowed request periode (days_appl) valid?
        if l_days_gone <= <matrix>-days_ext or <matrix>-days_ext = '99999'.
          l_tc_exist = true.
          l_tc_req_possible = false.
          l_message = text-105.
          LOG-POINT ID ish_tc_check SUBKEY '53_PREREGISTRATION' FIELDS l_message.
          LOG-POINT ID ish_tc_check SUBKEY '53_PREREGISTRATION' FIELDS <prereg>-orgfa.
          LOG-POINT ID ish_tc_check SUBKEY '53_PREREGISTRATION' FIELDS <prereg>-orddep.
          exit.
        endif.
*MED-84361 Begin
        IF ( l_days_gone <= l_days_appl OR <matrix>-days_appl = '99999' ) AND
           i_patient_id IS SUPPLIED.
          l_tc_req_possible = true.
          EXIT.
        ENDIF.
        IF ( l_days_gone <= l_days_appl OR <matrix>-days_appl = '99999' ) AND
           i_patient_provisional_id IS SUPPLIED.
*new concept of extending the request time as follow up time for provisional patients
          l_tc_exist = true.
          l_tc_req_possible = false.
          l_message = TEXT-105.
          LOG-POINT ID ish_tc_check SUBKEY '53_PREREGISTRATION' FIELDS l_message.
          LOG-POINT ID ish_tc_check SUBKEY '53_PREREGISTRATION' FIELDS <prereg>-orgfa.
          LOG-POINT ID ish_tc_check SUBKEY '53_PREREGISTRATION' FIELDS <prereg>-orddep.
          EXIT.
        ENDIF.
*MED-84361 End
      endif.
    endloop.
    IF l_tc_exist = true.
      EXIT.
    ENDIF.
  ENDLOOP.

  e_tc_exist = l_tc_exist.
  e_resp_type = resp_type_patient.
  c_tc_request_possible = l_tc_req_possible.

endmethod.


method IF_EX_ISHMED_TC_CHECK~CHECK.
  e_tc_exist = true.
  e_tc_request_possible = true.
  e_resp_type = resp_type_patient.
endmethod.


METHOD if_ex_ishmed_tc_check~check_patient_provisional.
  e_tc_exist = true.
ENDMETHOD.
ENDCLASS.
