class CL_IM_ISHMED_TC_CHECK definition
  public
  inheriting from CL_FB_ISHMED_TC_CHECK
  final
  create public .

public section.

  methods IF_EX_ISHMED_TC_CHECK~CHECK
    redefinition .
  methods IF_EX_ISHMED_TC_CHECK~CHECK_PATIENT_PROVISIONAL
    redefinition .
protected section.

  aliases RESP_TYPE_SPECIAL
    for IF_ISHMED_TC_CONSTANT_DEF~CO_RESP_TYPE_SPECIAL .

  methods CHECK_REQUEST
    importing
      !I_INSTITUTION_ID type EINRI
      !I_PATIENT_ID type PATNR optional
      !I_CASE_ID type FALNR optional
      !IT_MATRIX type RN1TC_MATRIX_T
      !I_PATIENT_PROVISIONAL_ID type ISH_PAPID optional
      !I_COMPANION type ISH_TRUE_FALSE default FALSE
    exporting
      !E_TC_EXIST type ISH_TRUE_FALSE
      !E_RESP_TYPE type N1TC_OU_RESP_TYPE
    changing
      !C_TC_REQUEST_POSSIBLE type ISH_TRUE_FALSE optional
      !C_TC_SPECIAL_REQUEST type ISH_TRUE_FALSE optional .
  methods CHECK_CLINICAL_ORDER
    importing
      !I_INSTITUTION_ID type EINRI
      !I_PATIENT_ID type PATNR optional
      !I_CASE_ID type FALNR optional
      !IT_MATRIX type RN1TC_MATRIX_T
      !I_PATIENT_PROVISIONAL_ID type ISH_PAPID optional
      !I_COMPANION type ISH_TRUE_FALSE default FALSE
    exporting
      !E_TC_EXIST type ISH_TRUE_FALSE
      !E_RESP_TYPE type N1TC_OU_RESP_TYPE
    changing
      !C_TC_REQUEST_POSSIBLE type ISH_TRUE_FALSE optional
      !C_TC_SPECIAL_REQUEST type ISH_TRUE_FALSE optional .
  methods CHECK_ANCHOR_SERVICE
    importing
      !I_INSTITUTION_ID type EINRI
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR optional
      !IT_MATRIX type RN1TC_MATRIX_T
      !I_COMPANION type ISH_TRUE_FALSE default FALSE
    exporting
      !E_TC_EXIST type ISH_TRUE_FALSE
      !E_RESP_TYPE type N1TC_OU_RESP_TYPE
    changing
      !C_TC_REQUEST_POSSIBLE type ISH_TRUE_FALSE optional
      !C_TC_SPECIAL_REQUEST type ISH_TRUE_FALSE optional .
  methods GET_ENDDAT_CLINICAL_ORDER
    importing
      !I_VKGID type N1VKGID
      !I_CORDERID type N1CORDID
      !I_APCNID type N1APCNID optional
    returning
      value(R_ENDDAT) type SY-DATUM .
  methods GET_ENDDAT_REQUEST
    importing
      !I_ANFID type ANFID
    returning
      value(R_ENDDAT) type SY-DATUM .
  methods CHECK_AUTHORITY
    importing
      !I_INSTITUTION_ID type EINRI
      !I_PATIENT_ID type PATNR
    returning
      value(R_NO_AUTH) type XFELD .
private section.
ENDCLASS.



CLASS CL_IM_ISHMED_TC_CHECK IMPLEMENTATION.


method CHECK_ANCHOR_SERVICE.

  TYPES BEGIN OF anchor_service.
  TYPES: LNRLS TYPE nlem-LNRLS,
         EINRI TYPE nlem-EINRI,
         PATNR TYPE nlem-PATNR,
         FALNR TYPE nlem-FALNR,
         ANKLS TYPE nlem-ANKLS,
         ERBOE TYPE nlem-ERBOE,
         ANFOE TYPE nlei-ANFOE,                                 " MED-61543 Note 2318333 Bi
         IBGDT TYPE nlem-IBGDT.
  TYPES END OF anchor_service.

  DATA: lt_anchor_service TYPE TABLE OF anchor_service,
        l_days_gone       TYPE i,
        l_days_appl       TYPE i,
        l_tc_exist        TYPE ish_true_false,
        l_tc_req_possible TYPE ish_true_false,
        l_usr_auth_ou     TYPE ish_true_false,
        l_resp_type       TYPE n1tc_ou_resp_type VALUE resp_type_case.


  FIELD-SYMBOLS: <anchor_service> TYPE anchor_service,
                 <matrix>   TYPE rn1tc_matrix.

*MED-53751 Beginn
   IF i_case_id IS INITIAL and i_companion EQ false. "MED-70773 By C5004356
    l_resp_type = resp_type_patient.
  ENDIF.
*MED-53751 Beginn

* get movement data
*  SELECT LNRLS EINRI PATNR FALNR ANKLS ERBOE IBGDT             " MED-61543 Note 2318333 Bi
  SELECT LNRLS EINRI PATNR FALNR ANKLS ERBOE ANFOE IBGDT        " MED-61543 Note 2318333 Bi
           INTO CORRESPONDING FIELDS OF TABLE lt_anchor_service
*           FROM nlem                                           " MED-61543 Note 2318333 Bi
           FROM v_nlem                                          " MED-61543 Note 2318333 Bi
             WHERE patnr = i_patient_id
             AND   einri = i_institution_id
             AND   storn NE 'X'.                                " MED-75185 Note 2855851 Mas

* check first the inpatient movements
  DELETE lt_anchor_service WHERE ANKLS is INITIAL.
  SORT lt_anchor_service BY ibgdt DESCENDING.
  l_tc_exist = false.

  LOOP AT lt_anchor_service ASSIGNING <anchor_service>.
    c_tc_special_request = false. "Data for anchor service found so no special request possible MED-70766 By C5004356
    LOOP AT it_matrix ASSIGNING <matrix>.
*     treatment contract was only given on case level
      IF <matrix>-resp_type = 'C' AND i_case_id IS NOT INITIAL.
        CHECK <anchor_service>-falnr = i_case_id.
      ENDIF.
      l_usr_auth_ou = false.
* <<< MED-61543 Note 2318333 Bi
*      IF <matrix>-deptou = <anchor_service>-ERBOE or
*         <matrix>-treaou = <anchor_service>-ERBOE.
*        l_usr_auth_ou = true.
*      ENDIF.
* MED-77577 Begin
* NebenOP
      IF <anchor_service>-ANKLS EQ 'N' and
         ( <matrix>-treaou = <anchor_service>-ERBOE or <matrix>-deptou = <anchor_service>-ERBOE ).
        l_usr_auth_ou = true.
      ENDIF.
* MED-77577 End
      IF ( <matrix>-deptou = <anchor_service>-ANFOE AND
         ( <matrix>-treaou = <anchor_service>-ERBOE OR
           <matrix>-treaou IS INITIAL ) )
           OR ( <matrix>-classification = '*' ). " MED-73352
        l_usr_auth_ou = true.
      ENDIF.
* >>> MED-61543 Note 2318333 Bi
      IF l_usr_auth_ou = true.
        l_days_gone = sy-datum - <anchor_service>-ibgdt.
        l_days_appl = <matrix>-days_ext + <matrix>-days_appl.
*       is the allowed follow-up periode (days_ext) valid?
        IF l_days_gone <= <matrix>-days_ext OR <matrix>-days_ext EQ '99999'.
          l_tc_exist = true.
          c_tc_request_possible = false.
          l_resp_type = <matrix>-resp_type.
        ENDIF.
*       is the allowed request periode (days_appl) valid?
        IF l_days_gone <= l_days_appl OR <matrix>-days_appl EQ '99999'.
          c_tc_request_possible = true.
          if l_resp_type = resp_type_case and i_companion EQ false. "MED-70773 By C5004356.  "MED-58837
             l_resp_type = <matrix>-resp_type.
          endif.
        ENDIF.
        EXIT.
      ENDIF.
    ENDLOOP.
    IF l_tc_exist = true.
      EXIT.
    ENDIF.
  ENDLOOP.
  e_tc_exist = l_tc_exist.
  e_resp_type = l_resp_type.

endmethod.


  method CHECK_AUTHORITY.

    DATA l_inactive TYPE abap_bool.

    l_inactive = cl_ishmed_utl_wp_func=>check_pat_is_inactive( i_patient_id = i_patient_id ).

    IF l_inactive = abap_true.
      r_no_auth = 'X'.
    else.
      r_no_auth = ' '.
    ENDIF.

  endmethod.


METHOD check_clinical_order.

  TYPES BEGIN OF corder.
  TYPES: corderid TYPE n1corder-corderid,
         vkgid    TYPE n1vkg-vkgid,
         orddep   TYPE n1corder-orddep,
         orgfa    TYPE n1vkg-orgfa,
         trtoe    TYPE n1vkg-trtoe,
         etroe    TYPE n1corder-etroe,
         falnr    TYPE n1vkg-falnr,
         apcnid   TYPE n1vkg-apcnid,                 " MED-49320
         erdat    TYPE n1vkg-erdat.
  TYPES END OF corder.

  DATA: lt_corder         TYPE TABLE OF corder,
        l_days_gone       TYPE i,
        l_days_appl       TYPE i,
        ls_status         TYPE rnrangevkgst,
        l_status          TYPE tn42c-wlsta,
        l_tc_exist        TYPE ish_true_false,
        l_tc_req_possible TYPE ish_true_false,
        l_resp_type       TYPE n1tc_ou_resp_type VALUE resp_type_case,
        l_pat_in_ou       TYPE ish_true_false,
        l_usr_auth_ou     TYPE ish_true_false,
        l_enddat          TYPE sy-datum,
        l_message         TYPE string.

  FIELD-SYMBOLS: <ls_corder> TYPE corder,
                 <matrix>    TYPE rn1tc_matrix.

*MED-53751 Beginn
  IF i_case_id IS INITIAL and i_companion EQ false. "MED-70773 By C5004356
    l_resp_type = resp_type_patient.
  ENDIF.
*MED-53751 Beginn

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

* get request data of a patient with real master data
  IF i_patient_id IS SUPPLIED.
    SELECT a~corderid a~orddep a~etroe b~vkgid b~erdat b~falnr b~trtoe b~orgfa
             INTO CORRESPONDING FIELDS OF TABLE lt_corder
             FROM n1corder AS a INNER JOIN n1vkg AS b ON a~corderid = b~corderid
               WHERE a~patnr = i_patient_id
               AND   a~einri = i_institution_id
               AND   a~wlsta IN grt_prereg_status
               AND   a~storn = off
               AND   b~storn = off.
* Rückbau aufgrund Kundenrückfrage MED-87396
*               AND   b~prereg = off. "MED-80752
* get request data of a patient with provisional data
  ELSEIF i_patient_provisional_id IS SUPPLIED.
    SELECT a~corderid a~orddep a~etroe b~vkgid b~erdat b~falnr b~trtoe b~orgfa b~apcnid
             INTO CORRESPONDING FIELDS OF TABLE lt_corder
             FROM n1corder AS a INNER JOIN n1vkg AS b ON a~corderid = b~corderid
               WHERE a~papid = i_patient_provisional_id
               AND   a~einri = i_institution_id
               AND   a~wlsta IN grt_prereg_status
               AND   a~storn = off
               AND   b~storn = off.
* Rückbau aufgrund Kundenrückfrage MED-87396
*               AND   b~prereg = off. "MED-80752
  ENDIF.

  SORT lt_corder BY erdat DESCENDING.
  l_tc_exist = false.
  l_tc_req_possible = c_tc_request_possible.

  LOOP AT lt_corder ASSIGNING <ls_corder>.
    c_tc_special_request = false. "Data for clinical order found so no special request possible MED-70766 By C5004356
    l_pat_in_ou = false.
    l_usr_auth_ou = false.
    LOOP AT it_matrix ASSIGNING <matrix>.
*     treatment contract was only given on case level
      IF <matrix>-resp_type = 'C' AND i_case_id IS NOT INITIAL.
        CHECK <ls_corder>-falnr = i_case_id.
      ENDIF.
      l_usr_auth_ou = false.
      IF <matrix>-classification = 'F' AND <matrix>-deptou = <ls_corder>-orgfa.                                     .
        l_usr_auth_ou = true.
      ENDIF.
      IF <matrix>-classification = 'O' AND
         ( <matrix>-deptou = <ls_corder>-orgfa AND
           <matrix>-treaou = <ls_corder>-trtoe
         ).
        l_usr_auth_ou = true.
      ENDIF.
* MED-73352 Begin
      IF <matrix>-classification = '*'.                                     .
        l_usr_auth_ou = true.
      ENDIF.
* MED-73352 End
      IF l_usr_auth_ou = true.
        l_enddat = get_enddat_clinical_order(                           " MED-49320
                            i_corderid = <ls_corder>-corderid
                            i_vkgid = <ls_corder>-vkgid
                            i_apcnid = <ls_corder>-apcnid
                            ).
        IF sy-datum BETWEEN <ls_corder>-erdat AND l_enddat.
          l_pat_in_ou = true.
        ENDIF.
        IF l_pat_in_ou = true.
          l_tc_exist = true.
          l_tc_req_possible = false.
          l_resp_type = <matrix>-resp_type.
          l_message = text-106.
          LOG-POINT ID ish_tc_check SUBKEY '54_CLINICAL_ORDER' FIELDS l_message.
          LOG-POINT ID ish_tc_check SUBKEY '54_CLINICAL_ORDER' FIELDS <ls_corder>-orgfa.
          LOG-POINT ID ish_tc_check SUBKEY '54_CLINICAL_ORDER' FIELDS <ls_corder>-orddep.
          EXIT.
        ELSE.
          l_days_gone = sy-datum - l_enddat.
          l_days_appl = <matrix>-days_ext + <matrix>-days_appl.
*         is the allowed follow-up periode (days_ext) valid?
*         is the allowed request periode (days_appl) valid?
          IF l_days_gone <= <matrix>-days_ext OR <matrix>-days_ext = '99999'.
            l_tc_exist = true.
            l_tc_req_possible = false.
            l_message = text-107.
            LOG-POINT ID ish_tc_check SUBKEY '54_CLINICAL_ORDER' FIELDS l_message.
            LOG-POINT ID ish_tc_check SUBKEY '54_CLINICAL_ORDER' FIELDS <ls_corder>-orgfa.
            LOG-POINT ID ish_tc_check SUBKEY '54_CLINICAL_ORDER' FIELDS <ls_corder>-orddep.
          ENDIF.
*MED-84361 Begin
          IF ( l_days_gone <= l_days_appl OR <matrix>-days_appl = '99999' ) AND
             i_patient_id IS SUPPLIED.
            l_tc_req_possible = true.
            if l_resp_type = resp_type_case and i_companion EQ false. "MED-70773 By C5004356.  "MED-58837
               l_resp_type = <matrix>-resp_type.
            endif.
          ENDIF.
          if ( l_days_gone <= l_days_appl or <matrix>-days_appl = '99999' ) and
             i_patient_provisional_id is supplied.
*new concept of extending the request time as follow up time for provisional patients
            l_tc_exist = true.
            l_tc_req_possible = false.
          endif.
*MED-84361 End
          EXIT.
        ENDIF.
      ENDIF.
      IF l_tc_exist = true.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

  e_tc_exist = l_tc_exist.
  c_tc_request_possible = l_tc_req_possible.
  e_resp_type = l_resp_type.

ENDMETHOD.


METHOD check_request.

  DATA: lt_n1anf     TYPE TABLE OF n1anf,
        l_days_gone       TYPE i,
        l_days_appl       TYPE i,
        l_tc_exist        TYPE ish_true_false,
        l_tc_req_possible TYPE ish_true_false,
        l_resp_type       TYPE n1tc_ou_resp_type VALUE resp_type_case,
        l_pat_in_ou       TYPE ish_true_false,
        l_usr_auth_ou     TYPE ish_true_false,
        l_enddat          TYPE sy-datum,
        l_message         type string.

  FIELD-SYMBOLS: <ls_n1anf> type n1anf,
                 <matrix>   TYPE rn1tc_matrix.

*MED-53751 Beginn
  IF i_case_id IS INITIAL and i_companion EQ false. "MED-70773 By C5004356
    l_resp_type = resp_type_patient.
  ENDIF.
*MED-53751 Beginn

* get request data of a patient with real master data
  IF i_patient_id IS SUPPLIED.
    SELECT * FROM n1anf INTO TABLE lt_n1anf
           WHERE patnr = i_patient_id
           AND   einri = i_institution_id
           AND   storn = off.
* get request data of a patient with provisional data
  ELSEIF i_patient_provisional_id IS SUPPLIED.
    SELECT * FROM n1anf INTO TABLE lt_n1anf
           WHERE papid = i_patient_provisional_id
           AND   einri = i_institution_id
           AND   storn = off.
  ENDIF.

  SORT lt_n1anf BY erdat DESCENDING.
  l_tc_exist = false.
  l_tc_req_possible = c_tc_request_possible.

  LOOP AT lt_n1anf ASSIGNING <ls_n1anf>.
    c_tc_special_request = false. "Data for request found so no special request possible MED-70766 By C5004356
    l_pat_in_ou = false.
    l_usr_auth_ou = false.
    LOOP AT it_matrix ASSIGNING <matrix>.
*     treatment contract was only given on case level
      IF <matrix>-resp_type = 'C' AND i_case_id IS NOT INITIAL.
        CHECK <ls_n1anf>-falnr = i_case_id.
      ENDIF.
      l_usr_auth_ou = false.

*     +++ begin note 1925526 +++
*     IF <matrix>-classification = 'F' AND ( <matrix>-deptou = <ls_n1anf>-anfoe ).                                     .
*       l_usr_auth_ou = true.
*     ENDIF.
*     IF <matrix>-classification = 'O' AND
*        ( <matrix>-deptou = <ls_n1anf>-anfoe AND
*          <matrix>-treaou = <ls_n1anf>-anpoe
*        ).
*       l_usr_auth_ou = true.
*     ENDIF.

      IF <matrix>-classification = 'F' AND ( <matrix>-deptou = <ls_n1anf>-orgid ).                                     .
        l_usr_auth_ou = true.
      ENDIF.
      IF <matrix>-classification = 'O' AND
         ( <matrix>-deptou = <ls_n1anf>-orgid OR
           <matrix>-treaou = <ls_n1anf>-orgid
         ).
        l_usr_auth_ou = true.
      ENDIF.
*     +++ end note 1925526 +++
* MED-73352 Begin
      IF <matrix>-classification = '*'.                                     .
        l_usr_auth_ou = true.
      ENDIF.
* MED-73352 End

      IF l_usr_auth_ou = true.
        l_enddat = get_enddat_request( i_anfid = <ls_n1anf>-anfid ).
        IF sy-datum BETWEEN <ls_n1anf>-erdat AND l_enddat.
          l_pat_in_ou = true.
        ENDIF.
        IF l_pat_in_ou = true.
          l_tc_exist = true.
          l_tc_req_possible = false.
          l_resp_type = <matrix>-resp_type.
          l_message = text-106.
          LOG-POINT ID ish_tc_check SUBKEY '55_REQUEST' FIELDS l_message.
          LOG-POINT ID ish_tc_check SUBKEY '55_REQUEST' FIELDS <ls_n1anf>-anfoe.
          LOG-POINT ID ish_tc_check SUBKEY '55_REQUEST' FIELDS <ls_n1anf>-anpoe.
          EXIT.
        ELSE.
          l_days_gone = sy-datum - l_enddat.
          l_days_appl = <matrix>-days_ext + <matrix>-days_appl.
*         is the allowed follow-up periode (days_ext) valid?
*         is the allowed request periode (days_appl) valid?
          IF l_days_gone <= <matrix>-days_ext OR <matrix>-days_ext = '99999'.
            l_tc_exist = true.
            l_tc_req_possible = false.
            l_message = text-107.
            LOG-POINT ID ish_tc_check SUBKEY '55_REQUEST' FIELDS l_message.
            LOG-POINT ID ish_tc_check SUBKEY '55_REQUEST' FIELDS <ls_n1anf>-anfoe.
            LOG-POINT ID ish_tc_check SUBKEY '55_REQUEST' FIELDS <ls_n1anf>-anpoe.
          ENDIF.
*MED-84361 Begin
          IF ( l_days_gone <= l_days_appl OR <matrix>-days_appl = '99999' ) AND
             i_patient_id IS SUPPLIED.
            l_tc_req_possible = true.
            if l_resp_type = resp_type_case and i_companion EQ false. "MED-70773 By C5004356.  "MED-58837
               l_resp_type = <matrix>-resp_type.
            endif.
            if ( l_days_gone <= l_days_appl or <matrix>-days_appl = '99999' ) and
               i_patient_provisional_id is supplied.
*new concept of extending the request time as follow up time for provisional patients
              l_tc_exist = true.
              l_tc_req_possible = false.
            endif.
          ENDIF.
*MED-84361 End
          EXIT.
        ENDIF.
      ENDIF.
      IF l_tc_exist = true.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

  e_tc_exist = l_tc_exist.
  c_tc_request_possible = l_tc_req_possible.
  e_resp_type = l_resp_type.

ENDMETHOD.


METHOD get_enddat_clinical_order.

  TYPES: BEGIN OF ty_date,
           date TYPE sy-datum.
  TYPES: END OF ty_date.

  DATA: lt_date       TYPE STANDARD TABLE OF ty_date,
        lt_tmnid      TYPE STANDARD TABLE OF ish_tmnid.         " MED-61468 Note 2300913 Bi

  CHECK i_vkgid IS NOT INITIAL AND i_corderid IS NOT INITIAL.

* begin MED-49320
* <<< MED-61468 Note 2300913 Bi
* Performance improvement
** 1. priority: appointment = Plandatum
*  SELECT b~bwidt INTO TABLE lt_date
*    FROM ntmn AS a INNER JOIN napp AS b
*      ON a~tmnid = b~tmnid
*   WHERE a~vkgid = i_vkgid
*     AND a~storn = abap_false
*     AND b~storn = abap_false.
*
* 1. priority: appointment = Plandatum
* <<< MED-68767 Note 2690891 Bi
  CASE sy-dbsys.
    WHEN 'ORACLE'.
      SELECT  tmnid INTO TABLE lt_tmnid
        FROM  ntmn
        WHERE vkgid = i_vkgid
          AND storn = abap_false
      %_HINTS ORACLE 'INDEX("NTMN" "NTMN~7")'. "#EC CI_HINTS

    WHEN OTHERS.
* >>> MED-68767 Note 2690891 Bi
      SELECT  tmnid INTO TABLE lt_tmnid
        FROM  ntmn
        WHERE vkgid = i_vkgid
          AND storn = abap_false.

  ENDCASE.

  IF lt_tmnid IS NOT INITIAL.
    SELECT  bwidt INTO TABLE lt_date
      FROM  napp
      FOR ALL ENTRIES IN lt_tmnid
      WHERE tmnid = lt_tmnid-table_line
        AND storn = abap_false.
  ENDIF.
* >>> MED-61468 Note 2300913 Bi

  SORT lt_date BY date DESCENDING.
  LOOP AT lt_date INTO r_enddat.
    IF r_enddat IS NOT INITIAL.
      RETURN.
    ENDIF.
  ENDLOOP.

* 2. priority: appointment constraint (Wunschdatum)
  REFRESH lt_date.
  IF i_apcnid IS INITIAL.
    SELECT b~wdate INTO TABLE lt_date
      FROM n1vkg AS a INNER JOIN n1apcn AS b
        ON a~apcnid = b~apcnid
     WHERE a~vkgid = i_vkgid
       AND b~storn = abap_false.
  ELSE.
    SELECT wdate INTO TABLE lt_date
      FROM n1apcn
     WHERE apcnid = i_apcnid
       AND storn = abap_false.
  ENDIF.

  SORT lt_date BY date DESCENDING.
  LOOP AT lt_date INTO r_enddat.
    IF r_enddat IS NOT INITIAL.
      RETURN.
    ENDIF.
  ENDLOOP.

* 3. priority: date of service
  REFRESH lt_date.
  SELECT b~ibgdt INTO TABLE lt_date
    FROM nlem AS a INNER JOIN nlei AS b
      ON a~lnrls = b~lnrls
   WHERE a~vkgid    = i_vkgid
     AND b~storn    = abap_false.

  SORT lt_date BY date DESCENDING.
  LOOP AT lt_date INTO r_enddat.
    IF r_enddat IS NOT INITIAL.
      RETURN.
    ENDIF.
  ENDLOOP.

** first of all, check, if any service has a date
*  SELECT b~ibgdt INTO TABLE lt_date
*    FROM nlem AS a INNER JOIN nlei AS b
*      ON a~lnrls = b~lnrls
*   WHERE a~vkgid    = i_vkgid
*     AND b~storn    = abap_false.
*
*  SORT lt_date BY date DESCENDING.
*  LOOP AT lt_date INTO r_enddat.
*    IF r_enddat IS NOT INITIAL.
*      RETURN.
*    ENDIF.
*  ENDLOOP.
*
** if there is no service date, look for an appointment
*  SELECT b~bwidt INTO TABLE lt_date
*    FROM ntmn AS a INNER JOIN napp AS b
*      ON a~tmnid = b~tmnid
*   WHERE a~vkgid = i_vkgid
*     AND a~storn = abap_false
*     AND b~storn = abap_false.
*
*  SORT lt_date BY date DESCENDING.
*  LOOP AT lt_date INTO r_enddat.
*    IF r_enddat IS NOT INITIAL.
*      RETURN.
*    ENDIF.
*  ENDLOOP.
*
** if there is no appointment date, look for an appointment constraint
*  SELECT b~wdate INTO TABLE lt_date
*    FROM n1vkg AS a INNER JOIN n1apcn AS b
*      ON a~apcnid = b~apcnid
*   WHERE a~vkgid = i_vkgid
*     AND b~storn = abap_false.
*
*  SORT lt_date BY date DESCENDING.
*  LOOP AT lt_date INTO r_enddat.
*    IF r_enddat IS NOT INITIAL.
*      RETURN.
*    ENDIF.
*  ENDLOOP.
* end MED-49320

ENDMETHOD.


method GET_ENDDAT_REQUEST.

  TYPES: BEGIN OF ty_date,
    date     TYPE sy-datum.
  TYPES: END OF ty_date.

  DATA: lt_date       TYPE STANDARD TABLE OF ty_date.

  CHECK i_anfid IS NOT INITIAL.

* look for end state
  SELECT a~erdat INTO TABLE lt_date
    FROM n1anmsz AS a INNER JOIN n1ast AS b
      ON a~anstae = b~anstae
   WHERE b~ansta  = 40
     AND a~anfid  = i_anfid.  "#EC CI_BUFFJOIN

  SORT lt_date BY date DESCENDING.
  LOOP AT lt_date INTO r_enddat.
    IF r_enddat IS NOT INITIAL.
      RETURN.
    ENDIF.
  ENDLOOP.

* check, if any service has a date
  SELECT b~ibgdt INTO TABLE lt_date
    FROM nlem AS a INNER JOIN nlei AS b
      ON a~lnrls = b~lnrls
   WHERE a~anfid    = i_anfid
     AND b~storn    = abap_false.

  SORT lt_date BY date DESCENDING.
  LOOP AT lt_date INTO r_enddat.
    IF r_enddat IS NOT INITIAL.
      RETURN.
    ENDIF.
  ENDLOOP.

endmethod.


METHOD if_ex_ishmed_tc_check~check.

  DATA: l_tc_exist        TYPE ish_true_false,
        l_tc_req_possible TYPE ish_true_false,
        l_tc_req_possible_old TYPE ish_true_false,        "MED-58837
        l_resp_type       TYPE n1tc_ou_resp_type VALUE resp_type_case,
        l_tc_special_request TYPE ish_true_false value true, "MED-70766 By C5004356
        l_tc_companion    TYPE ish_true_false value false, "MED-70766 By C5004356
        l_message         TYPE string.

  BREAK-POINT ID ish_tc_check.

  e_resp_type           = resp_type_case.                 "MED-58837
  e_tc_exist            = false.                          "MED-58837
  e_tc_request_possible = false.                          "MED-58837

* note 2905002 Begin
  if check_authority(
       i_institution_id = i_institution_id
       i_patient_id     = i_patient_id
     ) = 'X'.
    RETURN.
  endif.
* note 2905002 End

* give a treatment contract based on movements
  CALL METHOD check_movements
    EXPORTING
      i_institution_id      = i_institution_id
      i_patient_id          = i_patient_id
      i_case_id             = i_case_id
      it_matrix             = it_matrix
    IMPORTING
      e_tc_request_possible = l_tc_req_possible
      e_tc_exist            = l_tc_exist
      e_resp_type           = l_resp_type
    CHANGING
      c_tc_special_request  = l_tc_special_request "MED-70766 By C5004356.
      c_tc_companion        = l_tc_companion.      "MED-70766 By C5004356.

  IF l_tc_req_possible = true.                            "MED-58837
    e_resp_type = l_resp_type.
    l_tc_req_possible_old = true.
  ENDIF.

  IF l_tc_exist = true.
    e_tc_exist = l_tc_exist.
    e_tc_request_possible = l_tc_req_possible.
    e_resp_type = l_resp_type.
    l_message = text-100.
    LOG-POINT ID ish_tc_check SUBKEY '59_RESULT' FIELDS l_message.
    EXIT.
  ENDIF.

* give a treatment contract based on appointments
  CALL METHOD check_appointments
    EXPORTING
      i_institution_id      = i_institution_id
      i_patient_id          = i_patient_id
      it_matrix             = it_matrix
    IMPORTING
      e_tc_exist            = l_tc_exist
    CHANGING
      c_tc_request_possible = l_tc_req_possible
      c_tc_special_request  = l_tc_special_request. "MED-70766 By C5004356.

* begin MED-58837
  IF l_tc_req_possible = true AND l_tc_req_possible_old = false.
    e_resp_type = resp_type_patient.
  ENDIF.
* end MED-58837

  IF l_tc_exist = true.
    e_tc_exist = l_tc_exist.
    e_tc_request_possible = l_tc_req_possible.
    e_resp_type = resp_type_patient.
    l_message = text-101.
    LOG-POINT ID ish_tc_check SUBKEY '59_RESULT' FIELDS l_message.
    EXIT.
  ENDIF.

* give a treatment contract based on preregistrations
  CALL METHOD check_preregistrations
    EXPORTING
      i_institution_id      = i_institution_id
      i_patient_id          = i_patient_id
      it_matrix             = it_matrix
    IMPORTING
      e_tc_exist            = l_tc_exist
    CHANGING
      c_tc_request_possible = l_tc_req_possible
      c_tc_special_request  = l_tc_special_request. "MED-70766 By C5004356.

* begin MED-58837
  IF l_tc_req_possible = true AND l_tc_req_possible_old = false.
    e_resp_type = resp_type_patient.
  ENDIF.
* end MED-58837

  IF l_tc_exist = true.
    e_tc_exist = l_tc_exist.
    e_tc_request_possible = l_tc_req_possible.
    e_resp_type = resp_type_patient.
    l_message = text-102.
    LOG-POINT ID ish_tc_check SUBKEY '59_RESULT' FIELDS l_message.
    EXIT.
  ENDIF.

* give a treatment contract based on a clinical order
  CALL METHOD check_clinical_order
    EXPORTING
      i_institution_id      = i_institution_id
      i_patient_id          = i_patient_id
      i_case_id             = i_case_id
      it_matrix             = it_matrix
      i_companion           = l_tc_companion "MED-70766 By C5004356.
    IMPORTING
      e_tc_exist            = l_tc_exist
      e_resp_type           = l_resp_type
    CHANGING
      c_tc_request_possible = l_tc_req_possible
      c_tc_special_request  = l_tc_special_request. "MED-70766 By C5004356.

* begin MED-58837
  IF l_tc_req_possible = true AND e_resp_type = resp_type_case.
    e_resp_type = l_resp_type.
  ENDIF.
* end MED-58837

  IF l_tc_exist = true.
    e_tc_exist = l_tc_exist.
    e_tc_request_possible = l_tc_req_possible.
    e_resp_type = l_resp_type.
    l_message = text-103.
    LOG-POINT ID ish_tc_check SUBKEY '59_RESULT' FIELDS l_message.
    EXIT.
  ENDIF.

* give a treatment contract based on request
  CALL METHOD check_request
    EXPORTING
      i_institution_id      = i_institution_id
      i_patient_id          = i_patient_id
      i_case_id             = i_case_id
      it_matrix             = it_matrix
      i_companion           = l_tc_companion "MED-70766 By C5004356.
    IMPORTING
      e_tc_exist            = l_tc_exist
      e_resp_type           = l_resp_type
    CHANGING
      c_tc_request_possible = l_tc_req_possible
      c_tc_special_request  = l_tc_special_request. "MED-70766 By C5004356.

* begin MED-58837
  IF l_tc_req_possible = true AND e_resp_type = resp_type_case.
    e_resp_type = l_resp_type.
  ENDIF.
* end MED-58837

  IF l_tc_exist = true.
    e_tc_exist = l_tc_exist.
    e_tc_request_possible = l_tc_req_possible.
    e_resp_type = l_resp_type.
    l_message = text-104.
    LOG-POINT ID ish_tc_check SUBKEY '59_RESULT' FIELDS l_message.
    EXIT.
  ENDIF.

* give a treatment contract based on request
  CALL METHOD check_anchor_service
    EXPORTING
      i_institution_id      = i_institution_id
      i_patient_id          = i_patient_id
      i_case_id             = i_case_id
      it_matrix             = it_matrix
      i_companion           = l_tc_companion "MED-70766 By C5004356.
    IMPORTING
      e_tc_exist            = l_tc_exist
      e_resp_type           = l_resp_type
    CHANGING
      c_tc_request_possible = l_tc_req_possible
      c_tc_special_request  = l_tc_special_request. "MED-70766 By C5004356.

  e_tc_exist = l_tc_exist.
  e_tc_request_possible = l_tc_req_possible.
  IF e_resp_type = resp_type_case.                        "MED-58837
    e_resp_type = l_resp_type.
  ENDIF.

  IF l_tc_exist = true.
    l_message = text-105.
    LOG-POINT ID ish_tc_check SUBKEY '59_RESULT' FIELDS l_message.
  ELSEIF l_tc_special_request = true. "BEGIN MED-70766 By C5004356.
    e_tc_request_possible = true.
    e_resp_type = resp_type_special.  "END MED-70766 By C5004356.
  ENDIF.

ENDMETHOD.


METHOD if_ex_ishmed_tc_check~check_patient_provisional.

  DATA: l_tc_exist        TYPE ish_true_false,
        l_message         TYPE string.

  BREAK-POINT id ish_tc_check.

* give a treatment contract based on appointments
  CALL METHOD check_appointments
    EXPORTING
      i_institution_id         = i_institution_id
      i_patient_provisional_id = i_patient_provisional_id
      it_matrix                = it_matrix
    IMPORTING
      e_tc_exist               = l_tc_exist.

  IF l_tc_exist = true.
    e_tc_exist = l_tc_exist.
    l_message = text-101.
    LOG-POINT ID ish_tc_check SUBKEY '59_RESULT' FIELDS l_message.
    EXIT.
  ENDIF.

* give a treatment contract based on preregistrations
  CALL METHOD check_preregistrations
    EXPORTING
      i_institution_id         = i_institution_id
      i_patient_provisional_id = i_patient_provisional_id
      it_matrix                = it_matrix
    IMPORTING
      e_tc_exist               = l_tc_exist.

  IF l_tc_exist = true.
    e_tc_exist = l_tc_exist.
    l_message = text-102.
    LOG-POINT ID ish_tc_check SUBKEY '59_RESULT' FIELDS l_message.
    EXIT.
  ENDIF.

* give a treatment contract based on a clinical order
  CALL METHOD check_clinical_order
    EXPORTING
      i_institution_id         = i_institution_id
      i_patient_provisional_id = i_patient_provisional_id
      it_matrix                = it_matrix
    IMPORTING
      e_tc_exist               = l_tc_exist.

  IF l_tc_exist = true.
    e_tc_exist = l_tc_exist.
    l_message = text-103.
    LOG-POINT ID ish_tc_check SUBKEY '59_RESULT' FIELDS l_message.
    EXIT.
  ENDIF.

* give a treatment contract based on request
  CALL METHOD check_request
    EXPORTING
      i_institution_id         = i_institution_id
      i_patient_provisional_id = i_patient_provisional_id
      it_matrix                = it_matrix
    IMPORTING
      e_tc_exist               = l_tc_exist.

  e_tc_exist = l_tc_exist.

  IF l_tc_exist = true.
    l_message = text-104.
    LOG-POINT ID ish_tc_check SUBKEY '59_RESULT' FIELDS l_message.
  ENDIF.

ENDMETHOD.
ENDCLASS.
