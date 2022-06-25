class CL_ISH_UTL_BASE_PATIENT definition
  public
  abstract
  create public .

public section.
  type-pools ABAP .

  interfaces IF_ISH_CONSTANT_DEFINITION .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .

  class-methods GET_RISK_ICON
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
    exporting
      value(E_ICON) type NWICON
      value(E_RISK) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CHECK_PATIENT
    importing
      value(I_PATNR) type PATNR
    returning
      value(R_EXIST) type ISH_ON_OFF .
  class-methods CHECK_PATIENT_DECEASED
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      value(I_MSG) type ISH_ON_OFF default ON
      value(I_TYPE) type SY-MSGTY default 'S'
      value(I_EINRI) type EINRI default ' '
      value(I_FUNCTION) type ISH_FUNKT default 'NPAT'
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_PATIENT_DECEASED type ISH_ON_OFF
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CHECK_PATIENT_PLAN_CHAR_SEX
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      value(I_MSG) type ISH_ON_OFF default ON
      value(I_TYPE) type SY-MSGTY default 'S'
      value(I_DATE) type D
      value(I_BAUID) type BAUID
      value(I_FUNCTION) type ISH_FUNKT default 'NPAT'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CHECK_PATIENT_OF_OBJ
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      value(I_READ_DB_PATIENT) type ISH_ON_OFF default SPACE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CHECK_PATIENT_PROVI_OF_OBJ
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      value(I_READ_DB_PATIENT) type ISH_ON_OFF default OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods COMPARE_PATIENT_OF_OBJ
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      !IR_OBJECT_COMPARATIVE type ref to IF_ISH_IDENTIFY_OBJECT
      !I_MSG type ISH_ON_OFF default ON
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods COMPARE_PATIENT_PROVI_OF_OBJ
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      !IR_OBJECT_COMPARATIVE type ref to IF_ISH_IDENTIFY_OBJECT
      !I_MSG type ISH_ON_OFF default ON
      !I_READ_OVER_CONNECT type ISH_ON_OFF default ON
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_NAME_PATIENT
    importing
      !I_PATNR type PATNR optional
      !I_PAPID type ISH_PAPID optional
      !I_LIST type ISH_ON_OFF default OFF
      !IS_NPAT type NPAT optional
      !IS_NPAP type NPAP optional
    exporting
      !E_PNAME type ANY
      !E_PNAME_AGESEX type ANY
      !E_PNAME_AGESEXGDAT type ANY
      !E_AGE type ISH_AGE
      !E_GENDER type GSCHLE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_OBJ_FOR_PATIENT
    importing
      value(I_PATNR) type PATNR optional
      value(I_PAPID) type ISH_PAPID optional
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT
    exporting
      !ER_OBJECT type N1OBJECTREF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_PAP_FOR_OBJECT
    importing
      !I_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      !I_READ_OVER_CONNECT type ISH_ON_OFF default ON
    exporting
      !E_PAP_OBJ type ref to CL_ISH_PATIENT_PROVISIONAL
      !E_NPAP type NPAP
      !E_FOUND type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_PATIENT_OF_OBJ
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
    exporting
      !E_PATNR type NPAT-PATNR
      !E_PAPID type NPAP-PAPID
      !ER_PAP type ref to CL_ISH_PATIENT_PROVISIONAL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_PATNAME_FOR_OBJECT
    importing
      !I_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
    exporting
      value(E_NNAMS) type NPAT-NNAMS
      value(E_VNAMS) type NPAT-VNAMS
      value(E_PNAMEC) type ISH_PNAMEC
      value(E_PNAME_AGESEX) type ISH_PNAMEC
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods IS_OBJECT_OF_PATIENT_TMP
    importing
      !IR_IDENTIFY_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      !IT_TMP_OBJECT type ISH_T_IDENTIFY_OBJECT
    exporting
      value(E_PAT_IS_TMP) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods IS_PATIENT_TMP
    importing
      value(I_PATNR) type PATNR optional
      !IR_PAP type ref to CL_ISH_PATIENT_PROVISIONAL optional
      !IT_TMP_OBJECT type ISH_T_IDENTIFY_OBJECT
    exporting
      value(E_PAT_IS_TMP) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_NAME_PATIENT_NEW
    importing
      !I_EINRI type EINRI
      !I_PATNR type PATNR optional
      !I_PAPID type ISH_PAPID optional
      !I_LIST type ISH_ON_OFF default OFF
    exporting
      !E_PNAME type ANY
      !E_PNAME_AGESEX type ANY
      !E_AGE type ISH_AGE
      !E_GENDER type GSCHLE
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_UTL_BASE_PATIENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_BASE_PATIENT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_BASE_PATIENT IMPLEMENTATION.


METHOD check_patient.

  DATA l_rc   TYPE ish_method_rc.

  CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
    EXPORTING
      i_patnr = i_patnr
    IMPORTING
      e_rc    = l_rc.

  IF l_rc = 0.
    r_exist = on.
  ELSE.
    r_exist = off.
  ENDIF.

ENDMETHOD.


METHOD check_patient_deceased.

  DATA: l_rc    TYPE ish_method_rc,
        l_patnr TYPE patnr,
        l_papid TYPE ish_papid,
        l_einri TYPE einri,            "note 2133469
        ls_npat TYPE npat.
  DATA: lr_pap TYPE REF TO cl_ish_patient_provisional.
* ----- ------- ------- -------
  CLEAR: e_rc, e_patient_deceased.
* ----- ------- ------- -------
* get patient for movement object
  CALL METHOD cl_ish_utl_base_patient=>get_patient_of_obj
    EXPORTING
      ir_object       = ir_object
    IMPORTING
      e_patnr         = l_patnr
      e_papid         = l_papid
      er_pap          = lr_pap
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0 .
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ----- ------- -------
  IF l_patnr IS NOT INITIAL.
*   get data for patnr
    CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
      EXPORTING
        i_patnr         = l_patnr
        i_read_db       = on
*       Fichte, MED-60781: Do not put read data into (NPOL-) buffer,
*       or otherwise changes on the address within NV2000 would get
*       lost!
        i_no_buffer     = on
*       Fichte, MED-60781 - End
      IMPORTING
        es_npat         = ls_npat
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   ----- ------- -------
    IF ls_npat-todkz = on.
      e_patient_deceased = on.
*     ----- ------- -------
      IF i_msg = on.
        IF cr_errorhandler IS INITIAL.
          CREATE OBJECT cr_errorhandler.
        ENDIF.
*       Patient & & ist verstorben
        IF i_einri IS SUPPLIED.                "note 2133469
          l_einri = i_einri.
        ELSE.
          l_einri = ls_npat-einri.
        ENDIF.
        CALL METHOD cr_errorhandler->collect_messages
          EXPORTING
            i_typ        =  i_type             " note 1305433
            i_kla        = 'N1'
            i_num        = '081'
            i_mv1        = ls_npat-nname
            i_mv2        = ls_npat-vname
            i_last       = space
            i_object     = ir_object
            i_einri      = l_einri             "note 2133469
            i_function   = i_function          " note 1305433
            i_read_tn21m = on
          IMPORTING
            e_rc_tn21m   = l_rc.

        e_rc = l_rc.
      ENDIF.
    ENDIF.
  ENDIF.
* ----- ------- -------
* patient provisional to be alive
  IF lr_pap IS NOT INITIAL.
    e_patient_deceased = off.
  ENDIF.
* ----- ------- -------
ENDMETHOD.


METHOD CHECK_PATIENT_OF_OBJ .

* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_einri                 TYPE tn01-einri,
        l_patnr                 TYPE npat-patnr,
        l_tmp_patnr             TYPE npat-patnr,
        l_fld_not_found         TYPE ish_on_off,
        l_cancelled             TYPE ish_on_off,
        ls_npat                 TYPE npat.
* object references
  DATA: lr_run                  TYPE REF TO cl_ish_run_data.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* check if main object is for run data
* ... then there is a method "get_data_field"
  IF ir_object->is_inherited_from(
      cl_ish_run_data=>co_otype_run_data ) = off.
    EXIT.
  ENDIF.
  lr_run ?= ir_object.
* ---------- ---------- ----------
* get institution of object
  l_einri = cl_ish_utl_base=>get_institution_of_obj( lr_run ).
* ----------
* get patient of object
  CALL METHOD lr_run->get_data_field
    EXPORTING
      i_fill          = off
      i_fieldname     = 'PATNR'
    IMPORTING
      e_rc            = l_rc
      e_field         = l_patnr
      e_fld_not_found = l_fld_not_found
    CHANGING
      c_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  CHECK l_fld_not_found = off.
* ----------
* check if object is cancelled
  CALL METHOD lr_run->is_cancelled
    IMPORTING
      e_cancelled = l_cancelled.
* ---------- ---------- ----------
* process method only if there is a patient
  CHECK NOT l_patnr IS INITIAL.
* ---------- ---------- ----------
* read patient
  CLEAR: l_rc,
         ls_npat.
*  JG, 22.12.04, int. message 0120031469 0002900495 2004
*  patient can not be changed in nv2000
*  set unter comment
*  CALL FUNCTION 'ISH_READ_NPAT'
*    EXPORTING
*      ss_einri      = l_einri
*      ss_patnr      = l_patnr
*      ss_read_db    = i_read_db_patient
*      ss_check_auth = off
*    IMPORTING
*      ss_npat       = ls_npat
*    EXCEPTIONS
*      not_found     = 1
*      no_authority  = 2
*      no_einri      = 3
*      OTHERS        = 4.
*

  CALL FUNCTION 'ISH_PATIENT_POOL_GET'
    EXPORTING
      ss_patnr     = l_patnr
      ss_einri     = l_einri
    IMPORTING
      ss_npat_curr = ls_npat.
* JG end 22.12.04
*  MED-50634 technische Korrektur begin
*  l_rc = sy-subrc.
*  IF l_rc <> 0.
**   don't display leading zeros
*    IF l_patnr CO ' 0123456789'.
*      WRITE l_patnr TO l_tmp_patnr NO-ZERO.
*    ENDIF.
*    e_rc = 161.
**   Patient & & nicht vorhanden
*    CALL METHOD cl_ish_utl_base=>collect_messages
*      EXPORTING
*        i_typ           = 'E'
*        i_kla           = 'N1'
*        i_num           = '014'
*        i_mv1           = l_tmp_patnr
*        i_mv2           = space
*        ir_object       = ir_object
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*  ENDIF.
*  MED-50634 technische Korrektur end
* ----------
* check if patient is cancelled
  IF l_cancelled   = off AND
     ls_npat-storn = on.
    e_rc = 162.
*   don't display leading zeros
    IF l_patnr CO ' 0123456789'.
      WRITE l_patnr TO l_tmp_patnr NO-ZERO.
    ENDIF.
*   Patient & & ist storniert
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1'
        i_num           = '018'
        i_mv1           = l_tmp_patnr
        i_mv2           = space
        ir_object       = ir_object
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD CHECK_PATIENT_PLAN_CHAR_SEX.

  DATA: l_rc    TYPE ish_method_rc,
        l_patnr TYPE patnr,
        ls_npat TYPE npat,
        ls_npap TYPE rnpap_attrib,
        l_gschl TYPE npat-gschl,
        ls_tn11p  TYPE tn11p,
        lt_tn11p  TYPE TABLE OF tn11p.
  DATA: l_status  TYPE ish_on_off. " To Identify the status of ISH-OM switch
  .
  DATA: lr_pap TYPE REF TO cl_ish_patient_provisional.
* ----- ------- ------- -------
  CLEAR: e_rc, l_gschl. ", cr_errorhandler.
* ----- ------- ------- -------
* get patient number/provisional patient data for appointment object
  CALL METHOD cl_ish_utl_base_patient=>get_patient_of_obj
    EXPORTING
      ir_object       = ir_object
    IMPORTING
      e_patnr         = l_patnr
*     e_papid         = l_papid
      er_pap          = lr_pap
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0 .
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ----- ------- -------
*   get data for patnr
  IF l_patnr IS NOT INITIAL.
    CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
      EXPORTING
        i_patnr         = l_patnr
        i_read_db       = on
*       Fichte, MED-60781: Do not put read data into (NPOL-) buffer,
*       or otherwise changes on the address within NV2000 would get
*       lost!
        i_no_buffer     = on
*       Fichte, MED-60781 - End
      IMPORTING
        es_npat         = ls_npat
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.

    IF ls_npat-gschl IS NOT INITIAL.
      MOVE ls_npat-gschl TO l_gschl.
    ELSE.
      RETURN.
    ENDIF.

* get data for provisional patient
  ELSEIF lr_pap IS BOUND. "appointment for provisional patient
    CALL METHOD lr_pap->get_data
      IMPORTING
*       ES_KEY          =
        es_data         = ls_npap
*       ES_DATA_TEXT    =
*       ES_DATA_DB      =
*       ES_DATA_TEXT_DB =
*       E_MODE          =
        E_RC            = l_rc
      CHANGING
        c_errorhandler  = cr_errorhandler.

    IF l_rc <> 0 .
      e_rc = l_rc.
      EXIT.
    ENDIF.

    IF ls_npap-gschle IS NOT INITIAL.
      CALL FUNCTION 'ISH_CONVERT_SEX_INPUT'
        EXPORTING
          SS_GSCHLE   = ls_npap-gschle
        IMPORTING
          SS_GSCHL    = l_gschl
*         SS_GSCHLTXT =
*         SS_ANRDS    =
        EXCEPTIONS
          NOT_FOUND   = 1
          OTHERS      = 2.
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.
    ELSE.
      RETURN.
    ENDIF.
  ENDIF.

*   ----- ------- -------
* check whether SAP OM is active
  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      E_STATUS   = l_status
    EXCEPTIONS
      NOT_ACTIVE = 1
      OTHERS     = 2.

  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.

*   ----- -------- ---------
* get planning characteristics
  IF l_gschl IS NOT INITIAL.
    IF l_status EQ off.  " If the switch is off, select recordsets from TN11P
      SELECT * FROM tn11p INTO TABLE lt_tn11p
        WHERE bauid EQ i_bauid
            AND begdt LE i_date
            AND enddt GE i_date.
    ELSE.              " If switch is ON, call function module to read infotype tables for TN11P records.
      CALL FUNCTION 'ISH_OM_PLAN_DATA_GET'
        EXPORTING
*         I_OBJID        =
*         IT_OBJID       =
          I_BAUID        = i_bauid
*         IT_BAUID       =
          I_BEGDT        = i_date
          I_ENDDT        = i_date
*         I_ACCCAT       =
*         IT_ACCCAT      =
*         I_DEPT_FLAG    =
        IMPORTING
*         ET_P6093       =
*         ET_P1001       =
          ET_TN11P       = lt_tn11p
        EXCEPTIONS
          NOTHING_FOUND  = 1
          INTERNAL_ERROR = 2
          OTHERS         = 3.
      .
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.
    ENDIF.

* check sex
    LOOP at lt_tn11p INTO ls_tn11p WHERE bauid EQ i_bauid.
      IF ls_tn11p-gschl NE l_gschl AND
         ls_tn11p-gschl IS NOT INITIAL.
        IF i_msg = on.
          IF cr_errorhandler IS INITIAL.
            CREATE OBJECT cr_errorhandler.
          ENDIF.
        ENDIF.
        CASE ls_tn11p-gschl.
          WHEN '1'.
*            Bauliche Einheit & ist für männliche Patienten reserviert
            CALL METHOD cr_errorhandler->collect_messages
              EXPORTING
                i_typ = i_type
                i_kla = 'N1'
                i_num = '262'
                i_mv1 = ls_tn11p-bauid
                i_mv2 = ls_tn11p-begdt
                i_mv3 = ls_tn11p-enddt.
*                  i_last       = space
*                  i_object     = ir_object
*                  i_einri      = ls_npat-einri
*                  i_function   = i_function
*                  i_read_tn21m = on
*                IMPORTING
*                  e_rc_tn21m   = l_rc
*                  e_rc = l_rc.
          WHEN '2'.
*            Bauliche Einheit & ist für weibliche Patienten reserviert
            CALL METHOD cr_errorhandler->collect_messages
              EXPORTING
                i_typ = i_type
                i_kla = 'N1'
                i_num = '261'
                i_mv1 = ls_tn11p-bauid
                i_mv2 = ls_tn11p-begdt
                i_mv3 = ls_tn11p-enddt.
*                  i_last       = space
*                  i_object     = ir_object
*                  i_einri      = ls_npat-einri
*                  i_function   = i_function
*                  i_read_tn21m = on
*                IMPORTING
*                  e_rc_tn21m   = l_rc
*                  e_rc = l_rc.
        ENDCASE.
      ENDIF.
    ENDLOOP.
  ENDIF.

* ----- ------- -------
ENDMETHOD.


METHOD check_patient_provi_of_obj .

* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_einri                 TYPE tn01-einri,
        l_papid                 TYPE npap-papid,
        l_tmp_papid             TYPE npap-papid,
        l_fld_not_found         TYPE ish_on_off,
        l_found                 TYPE ish_on_off,
        l_new                   TYPE ish_on_off,
        l_exists                TYPE ish_on_off,
        l_key                   TYPE string.

* local structures
  DATA: ls_npap                 TYPE npap.

* object references
  DATA: lr_run                  TYPE REF TO cl_ish_run_data,
        lr_pap                  TYPE REF TO cl_ish_patient_provisional.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  CLEAR: l_new, l_found, l_rc, l_key, l_exists.
* ---------- ---------- ----------
* check if main object is for run data
* ... then there is a method "get_data_field"
  IF ir_object->is_inherited_from(
      cl_ish_run_data=>co_otype_run_data ) = off.
    EXIT.
  ENDIF.
  lr_run ?= ir_object.
* ---------- ---------- ----------
* get institution of object
  l_einri = cl_ish_utl_base=>get_institution_of_obj( lr_run ).
* ----------
* get patient of object
  CALL METHOD lr_run->get_data_field
    EXPORTING
      i_fill          = off
      i_fieldname     = 'PAPID'
    IMPORTING
      e_rc            = l_rc
      e_field         = l_papid
      e_fld_not_found = l_fld_not_found
    CHANGING
      c_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  CHECK l_fld_not_found = off.
* ---------- ---------- ----------
* get patient provisional for object
  CALL METHOD cl_ish_utl_base_patient=>get_pap_for_object
    EXPORTING
      i_object       = lr_run
    IMPORTING
      e_pap_obj      = lr_pap
      e_found        = l_found
      e_rc           = l_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  IF       l_rc    <> 0       OR
     ( NOT l_papid IS INITIAL AND
           lr_pap  IS INITIAL ).
    e_rc = 171.
*   Patient mit vorläufigen Stammdaten nicht vorhanden
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'NFCL'
        i_num           = '078'
        ir_object       = ir_object
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD COMPARE_PATIENT_OF_OBJ .

* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_patnr                 TYPE npat-patnr,
        l_patnr_c               TYPE npat-patnr,
        l_fld_not_found         TYPE ish_on_off,
        l_cls_name              TYPE seoclass-clsname,
        l_cls_name_c            TYPE seoclass-clsname,
        ls_nfal                 TYPE nfal.
* object references
  DATA: lr_run                  TYPE REF TO cl_ish_run_data,
        lr_run_c                TYPE REF TO cl_ish_run_data.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* check if main object is for run data
* ... then there is a method "get_data_field"
  IF ir_object->is_inherited_from(
      cl_ish_run_data=>co_otype_run_data ) = off.
    EXIT.
  ENDIF.
  lr_run ?= ir_object.
* ----------
  IF ir_object_comparative->is_inherited_from(
      cl_ish_run_data=>co_otype_run_data ) = off.
    EXIT.
  ENDIF.
*Sta/PN/18126pkt6/2005/09/27
*  lr_run_c ?= ir_object.
  lr_run_c ?= ir_object_comparative.
*End/PN/18126pkt6/2005/09/27
* ---------- ---------- ----------
* get patient of object
  CALL METHOD lr_run->get_data_field
    EXPORTING
      i_fill          = off
      i_fieldname     = 'PATNR'
    IMPORTING
      e_rc            = l_rc
      e_field         = l_patnr
      e_fld_not_found = l_fld_not_found
    CHANGING
      c_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  CHECK l_fld_not_found = off.
* ----------
* get patient for comparison
  CALL METHOD lr_run_c->get_data_field
    EXPORTING
      i_fill          = off
      i_fieldname     = 'PATNR'
    IMPORTING
      e_rc            = l_rc
      e_field         = l_patnr_c
      e_fld_not_found = l_fld_not_found
    CHANGING
      c_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  CHECK l_fld_not_found = off.
* ----------
* get class name of object
  l_cls_name   = cl_ish_utl_rtti=>get_class_name( lr_run ).
* get class name of object for comparison
  l_cls_name_c = cl_ish_utl_rtti=>get_class_name( lr_run_c ).
* ---------- ---------- ----------
  IF l_patnr <> l_patnr_c.
    e_rc = 160.
    IF i_msg = on. "PN/18126pkt6/2005/09/27
*   & &: Patientennummer passt nicht zu &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'NFCL'
        i_num           = '264'
        i_mv1           = l_cls_name
        i_mv3           = l_cls_name_c
        ir_object       = ir_object
      CHANGING
        cr_errorhandler = cr_errorhandler.
    ENDIF. "PN/18126pkt6/2005/09/27
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD COMPARE_PATIENT_PROVI_OF_OBJ .

* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_patnr                 TYPE npat-patnr,
        l_patnr_c               TYPE npat-patnr,
        l_fld_not_found         TYPE ish_on_off,
        l_cls_name              TYPE seoclass-clsname,
        l_cls_name_c            TYPE seoclass-clsname,
        ls_nfal                 TYPE nfal.
* object references
  DATA: lr_run                  TYPE REF TO cl_ish_run_data,
        lr_run_c                TYPE REF TO cl_ish_run_data,
        lr_pap                  TYPE REF TO cl_ish_patient_provisional,
        lr_pap_c                TYPE REF TO cl_ish_patient_provisional.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* check if main object is for run data
* ... then there is a method "get_data_field"
  IF ir_object->is_inherited_from(
      cl_ish_run_data=>co_otype_run_data ) = off.
    EXIT.
  ENDIF.
  lr_run ?= ir_object.
* ----------
  IF ir_object_comparative->is_inherited_from(
      cl_ish_run_data=>co_otype_run_data ) = off.
    EXIT.
  ENDIF.
*Sta/PN/18126pkt6/2005/09/27
*  lr_run_c ?= ir_object.
  lr_run_c ?= ir_object_comparative.
*End/PN/18126pkt6/2005/09/27
* ---------- ---------- ----------
* get patient provisional of object
  CALL METHOD cl_ish_utl_base_patient=>get_pap_for_object
    EXPORTING
      i_object       = lr_run
      i_read_over_connect = i_read_over_connect  "PN/19657/2006/07/20
    IMPORTING
      e_pap_obj      = lr_pap
      e_rc           = l_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ----------
* get patient provisional for comparison
  CALL METHOD cl_ish_utl_base_patient=>get_pap_for_object
    EXPORTING
      i_object       = lr_run_c
      i_read_over_connect = i_read_over_connect  "PN/19657/2006/07/20
    IMPORTING
      e_pap_obj      = lr_pap_c
      e_rc           = l_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ----------
* get class name of object
  l_cls_name   = cl_ish_utl_rtti=>get_class_name( lr_run ).
* get class name of object for comparison
  l_cls_name_c = cl_ish_utl_rtti=>get_class_name( lr_run_c ).
* ---------- ---------- ----------
  IF lr_pap <> lr_pap_c.
    e_rc = 170.
    IF i_msg = on. "PN/18126pkt6/2005/09/27
*   & &: Patient mit vorl. Stammdaten passt nicht zu &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'NFCL'
        i_num           = '265'
        i_mv1           = l_cls_name
        i_mv3           = l_cls_name_c
        ir_object       = ir_object
      CHANGING
        cr_errorhandler = cr_errorhandler.
    ENDIF. "PN/18126pkt6/2005/09/27
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_name_patient.

* definitions
  DATA: ls_npat          TYPE npat,
        ls_npap          TYPE npap,
        l_string         TYPE string,
        l_gdat(10)       TYPE c.

* initialization
  e_rc = 0.
  CLEAR: e_pname, e_pname_agesex,
         e_pname_agesexgdat.

  IF cr_errorhandler IS INITIAL AND cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* get name of patient
  IF i_patnr IS NOT INITIAL OR is_npat IS NOT INITIAL.

*   real patient
    IF is_npat IS INITIAL AND i_patnr IS NOT INITIAL.
      IF cr_errorhandler IS INITIAL.
        CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
          EXPORTING
            i_patnr = i_patnr
          IMPORTING
            es_npat = ls_npat
            e_rc    = e_rc.
      ELSE.
        CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
          EXPORTING
            i_patnr         = i_patnr
          IMPORTING
            es_npat         = ls_npat
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
    ELSE.
      ls_npat = is_npat.
    ENDIF.
    IF e_pname_agesex     IS REQUESTED OR
       e_pname_agesexgdat IS REQUESTED OR
       e_age              IS REQUESTED OR
       e_gender           IS REQUESTED.
      CALL FUNCTION 'ISH_PATNAME_GET'
        EXPORTING
          i_einri          = ls_npat-einri
          i_patnr          = ls_npat-patnr
          i_read_npat      = off
          i_npat           = ls_npat
          i_npat_complete  = on
          i_list           = i_list
        IMPORTING
          e_pnamec         = e_pname
          e_pnamec1        = l_string
          e_age            = e_age
          e_gender         = e_gender
        EXCEPTIONS
          patnr_not_found  = 1
          no_authority     = 2
          no_einri         = 3
          gender_not_found = 0         " does not matter
          age_not_found    = 0         " does not matter
          OTHERS           = 4.
      IF sy-subrc <> 0 AND e_pname IS INITIAL.
        IF cr_errorhandler IS BOUND.
          CALL METHOD cr_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'N1'
              i_num  = '014'
              i_mv1  = i_patnr
              i_last = space.
        ENDIF.
        e_rc = 1.
        EXIT.
      ENDIF.
      IF e_pname_agesex IS REQUESTED.
        e_pname_agesex = l_string.
      ENDIF.
      IF e_pname_agesex IS INITIAL.
        e_pname_agesex = e_pname.
      ENDIF.
      IF e_pname_agesexgdat IS REQUESTED.
        WRITE ls_npat-gbdat TO l_gdat DD/MM/YYYY.
        CONCATENATE l_string
*                    ' geb. '
                    ' geb.'(001)    "MED-50634
                    l_gdat
                    INTO e_pname_agesexgdat
                    SEPARATED BY space.
      ENDIF.
    ELSE.
      CALL FUNCTION 'ISH_NPAT_CONCATENATE'
        EXPORTING
          ss_einri         = ls_npat-einri
          ss_patnr         = ls_npat-patnr
          ss_read_npat     = off
          ss_npat          = ls_npat
          ss_npat_complete = on
          ss_list          = i_list
        IMPORTING
          ss_pname         = e_pname.
    ENDIF.

  ELSEIF i_papid IS NOT INITIAL OR is_npap IS NOT INITIAL.

*   provisional patient
    IF is_npap IS INITIAL AND i_papid IS NOT INITIAL.
      IF cr_errorhandler IS INITIAL.
        CALL METHOD cl_ish_dbr_pap=>get_pap_by_papid
          EXPORTING
            i_papid = i_papid
          IMPORTING
            es_npap = ls_npap
            e_rc    = e_rc.
      ELSE.
        CALL METHOD cl_ish_dbr_pap=>get_pap_by_papid
          EXPORTING
            i_papid         = i_papid
          IMPORTING
            es_npap         = ls_npap
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
    ELSE.
      ls_npap = is_npap.
    ENDIF.
    IF e_pname_agesex     IS REQUESTED OR
       e_pname_agesexgdat IS REQUESTED OR
       e_age              IS REQUESTED OR
       e_gender           IS REQUESTED.
      CALL FUNCTION 'ISH_PAPNAME_GET'
        EXPORTING
          i_papid          = ls_npap-papid
          i_read_npap      = off
          i_npap           = ls_npap
          i_npap_complete  = on
          i_list           = i_list
        IMPORTING
          e_pname          = e_pname
          e_pnamega        = l_string
          e_age            = e_age
          e_gender         = e_gender
        EXCEPTIONS
          papid_not_found  = 1
          gender_not_found = 0         " does not matter
          age_not_found    = 0         " does not matter
          OTHERS           = 4.
      IF sy-subrc <> 0 AND e_pname IS INITIAL.
        IF cr_errorhandler IS BOUND.
          CALL METHOD cr_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'N1'
              i_num  = '014'
              i_mv1  = i_papid
              i_last = space.
        ENDIF.
        e_rc = 1.
        EXIT.
      ENDIF.
      IF e_pname_agesex IS REQUESTED.
        e_pname_agesex = l_string.
      ENDIF.
      IF e_pname_agesex IS INITIAL.
        e_pname_agesex = e_pname.
      ENDIF.
      IF e_pname_agesexgdat IS REQUESTED.
        WRITE ls_npap-gbdat TO l_gdat DD/MM/YYYY.
        CONCATENATE l_string
                    ' geb.'(001)    "MED-44955
                    l_gdat
                    INTO e_pname_agesexgdat
                    SEPARATED BY space.
      ENDIF.
    ELSE.
      CALL FUNCTION 'ISH_NPAP_CONCATENATE'
        EXPORTING
          ss_papid         = ls_npap-papid
          ss_read_npap     = off
          ss_npap          = ls_npap
          ss_npap_complete = on
          ss_list          = i_list
        IMPORTING
          ss_pname         = e_pname.
    ENDIF.

  ELSE.

*   no patient number provided
    IF cr_errorhandler IS BOUND.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1'
          i_num  = '014'
          i_mv1  = i_patnr
          i_last = space.
    ENDIF.
    e_rc = 1.
    EXIT.

  ENDIF.

ENDMETHOD.


METHOD get_name_patient_new.

* MED-63073: created this method -> this method is faster if you select for a buisness partner
* because in this case the function module ISH_READ_NPAT is not called.

* definitions
  DATA: ls_npat  TYPE npat,
        ls_npap  TYPE npap,
        l_string TYPE string.


  IF cr_errorhandler IS INITIAL AND cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* get name of patient
  IF i_patnr IS NOT INITIAL AND i_einri IS NOT INITIAL.

*   real patient
    IF e_pname_agesex     IS REQUESTED OR
       e_age              IS REQUESTED OR
       e_gender           IS REQUESTED.
      CALL FUNCTION 'ISH_PATNAME_GET'
        EXPORTING
          i_einri          = i_einri
          i_patnr          = i_patnr
          i_read_npat      = on
          i_list           = i_list
        IMPORTING
          e_pnamec         = e_pname
          e_pnamec1        = l_string
          e_age            = e_age
          e_gender         = e_gender
        EXCEPTIONS
          patnr_not_found  = 1
          no_authority     = 2
          no_einri         = 3
          gender_not_found = 0         " does not matter
          age_not_found    = 0         " does not matter
          OTHERS           = 4.
      IF sy-subrc <> 0 AND e_pname IS INITIAL.
        IF cr_errorhandler IS BOUND.
          CALL METHOD cr_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'N1'
              i_num  = '014'
              i_mv1  = i_patnr
              i_last = space.
        ENDIF.
        e_rc = 1.
        EXIT.
      ENDIF.
      IF e_pname_agesex IS REQUESTED.
        e_pname_agesex = l_string.
      ENDIF.
      IF e_pname_agesex IS INITIAL.
        e_pname_agesex = e_pname.
      ENDIF.
    ELSE.
      CALL FUNCTION 'ISH_NPAT_CONCATENATE'
        EXPORTING
          ss_einri     = i_einri
          ss_patnr     = i_patnr
          ss_read_npat = on
          ss_list      = i_list
        IMPORTING
          ss_pname     = e_pname.
    ENDIF.

  ELSEIF i_papid IS NOT INITIAL.

*   provisional patient
    IF e_pname_agesex   IS REQUESTED OR
     e_age              IS REQUESTED OR
     e_gender           IS REQUESTED.
      CALL FUNCTION 'ISH_PAPNAME_GET'
        EXPORTING
          i_papid          = i_papid
          i_read_npap      = on
          i_list           = i_list
        IMPORTING
          e_pname          = e_pname
          e_pnamega        = l_string
          e_age            = e_age
          e_gender         = e_gender
        EXCEPTIONS
          papid_not_found  = 1
          gender_not_found = 0         " does not matter
          age_not_found    = 0         " does not matter
          OTHERS           = 4.
      IF sy-subrc <> 0 AND e_pname IS INITIAL.
        IF cr_errorhandler IS BOUND.
          CALL METHOD cr_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'N1'
              i_num  = '014'
              i_mv1  = i_papid
              i_last = space.
        ENDIF.
        e_rc = 1.
        EXIT.
      ENDIF.
      IF e_pname_agesex IS REQUESTED.
        e_pname_agesex = l_string.
      ENDIF.
      IF e_pname_agesex IS INITIAL.
        e_pname_agesex = e_pname.
      ENDIF.
    ELSE.
      CALL FUNCTION 'ISH_NPAP_CONCATENATE'
        EXPORTING
          ss_papid     = i_papid
          ss_read_npap = on
          ss_list      = i_list
        IMPORTING
          ss_pname     = e_pname.
    ENDIF.

  ELSE.

*   no patient number provided
    IF cr_errorhandler IS BOUND.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1'
          i_num  = '014'
          i_mv1  = i_patnr
          i_last = space.
    ENDIF.
    e_rc = 1.
    EXIT.

  ENDIF.


ENDMETHOD.


METHOD get_obj_for_patient.

  DATA: lr_pat      TYPE REF TO cl_ishmed_none_oo_npat,
        lr_pap      TYPE REF TO cl_ish_patient_provisional,
        ls_pap_key  TYPE rnpap_key.

  e_rc = 0.
  CLEAR er_object.

  IF cr_errorhandler IS INITIAL AND cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF i_patnr IS NOT INITIAL.
    CALL METHOD cl_ishmed_none_oo_npat=>load
      EXPORTING
        i_patnr        = i_patnr
      IMPORTING
        e_instance     = lr_pat
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    er_object = lr_pat.
  ELSEIF i_papid IS NOT INITIAL.
    CLEAR ls_pap_key.
    ls_pap_key-papid = i_papid.
    IF ir_environment IS INITIAL.
      e_rc = 1.
      EXIT.
    ENDIF.
    CALL METHOD cl_ish_patient_provisional=>load
      EXPORTING
        i_key               = ls_pap_key
        i_environment       = ir_environment
      IMPORTING
        e_instance          = lr_pap
      EXCEPTIONS
        missing_environment = 1
        not_found           = 2
        OTHERS              = 3.
    IF sy-subrc = 0.
      er_object = lr_pap.
    ELSE.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst.
      e_rc = 1.
      EXIT.
    ENDIF.
  ELSE.
    e_rc = 1.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD get_pap_for_object .

* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_ishmed_auth           TYPE ish_on_off.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* check if IS-H*MED is active
  l_ishmed_auth = on.
  CALL FUNCTION 'ISHMED_AUTHORITY'
    EXPORTING
      i_msg            = off
    EXCEPTIONS
      ishmed_not_activ = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
    l_ishmed_auth = off.
  ENDIF.
* ---------- ---------- ----------
  IF l_ishmed_auth = on.
*   IS-H*MED is acitve; call correct method
    IF e_npap IS SUPPLIED.                                  "MED-34863
      CALL METHOD cl_ishmed_ipl_utl_base=>get_pap_for_object_med
        EXPORTING
          i_object            = i_object
          i_read_over_connect = i_read_over_connect  "PN/19657/2006/07/20
        IMPORTING
          e_pap_obj           = e_pap_obj
          e_npap              = e_npap
          e_found             = e_found
          e_rc                = e_rc
        CHANGING
          c_errorhandler      = c_errorhandler.
*   START MED-34863 2010/01/28 HP Perfromace
    ELSE.
      CALL METHOD cl_ishmed_ipl_utl_base=>get_pap_for_object_med
        EXPORTING
          i_object            = i_object
          i_read_over_connect = i_read_over_connect  "PN/19657/2006/07/20
        IMPORTING
          e_pap_obj           = e_pap_obj
          e_found             = e_found
          e_rc                = e_rc
        CHANGING
          c_errorhandler      = c_errorhandler.
    ENDIF.
*   END MED-34863
  ELSEIF l_ishmed_auth = off.
*   IS-H*MED is not active; call correct method
    IF e_npap IS SUPPLIED.                                  "MED-34863
      CALL METHOD cl_ish_ipl_utl_base=>get_pap_for_object
        EXPORTING
          i_object            = i_object
          i_read_over_connect = i_read_over_connect  "PN/19657/2006/07/20
        IMPORTING
          e_pap_obj           = e_pap_obj
          e_npap              = e_npap
          e_found             = e_found
          e_rc                = e_rc
        CHANGING
          c_errorhandler      = c_errorhandler.
*   START MED-34863 2010/01/28 HP Perfromace
    ELSE.
      CALL METHOD cl_ish_ipl_utl_base=>get_pap_for_object
        EXPORTING
          i_object            = i_object
          i_read_over_connect = i_read_over_connect  "PN/19657/2006/07/20
        IMPORTING
          e_pap_obj           = e_pap_obj
          e_found             = e_found
          e_rc                = e_rc
        CHANGING
          c_errorhandler      = c_errorhandler.
    ENDIF.
*   END MED-34863
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD GET_PATIENT_OF_OBJ .

* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_ishmed_auth           TYPE ish_on_off.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* check if IS-H*MED is active
  l_ishmed_auth = on.
  CALL FUNCTION 'ISHMED_AUTHORITY'
    EXPORTING
      i_msg            = off
    EXCEPTIONS
      ishmed_not_activ = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
    l_ishmed_auth = off.
  ENDIF.
* ---------- ---------- ----------
  IF l_ishmed_auth = on.
*   IS-H*MED is acitve; call correct method
    CALL METHOD cl_ishmed_ipl_utl_base=>get_patient_of_obj_med
      EXPORTING
        ir_object       = ir_object
      IMPORTING
        e_patnr         = e_patnr
        e_papid         = e_papid
        er_pap          = er_pap
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ELSEIF l_ishmed_auth = off.
*   IS-H*MED is not active; call correct method
    CALL METHOD cl_ish_ipl_utl_base=>get_patient_of_obj
      EXPORTING
        ir_object       = ir_object
      IMPORTING
        e_patnr         = e_patnr
        e_papid         = e_papid
        er_pap          = er_pap
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_patname_for_object.

* definitions
  DATA: l_patnr           TYPE npat-patnr,
        l_papid           TYPE npap-papid,
        l_rnpap_key       TYPE rnpap_key,
        ls_npat           TYPE npat,
        ls_npap           TYPE npap,
        l_rc              TYPE ish_method_rc.
* object references
  DATA: lr_pap            TYPE REF TO cl_ish_patient_provisional.

* ---------- ---------- ----------
* Initialisierungen
  e_rc = 0.
  CLEAR: e_nnams, e_vnams, e_pnamec, e_pname_agesex.
* ---------- ---------- ----------
  IF i_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* ---------- ---------- ----------
* get patient first
  CALL METHOD cl_ish_utl_base_patient=>get_patient_of_obj
    EXPORTING
      ir_object       = i_object
    IMPORTING
      e_patnr         = l_patnr
      er_pap          = lr_pap
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* get ID of patient
  IF l_patnr IS INITIAL AND lr_pap IS NOT INITIAL.
    CALL METHOD lr_pap->get_data
      IMPORTING
        es_key         = l_rnpap_key
        e_rc           = l_rc
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc = 0.
      l_papid = l_rnpap_key-papid.
    ELSE.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------
* get name of patient
  CALL METHOD cl_ish_utl_base_patient=>get_name_patient
    EXPORTING
      i_patnr         = l_patnr
      i_papid         = l_papid
    IMPORTING
      e_pname         = e_pnamec
      e_pname_agesex  = e_pname_agesex
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  IF e_nnams IS REQUESTED OR e_vnams IS REQUESTED.
    IF l_patnr IS NOT INITIAL.
      CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
        EXPORTING
          i_patnr         = l_patnr
        IMPORTING
          es_npat         = ls_npat
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      IF l_rc = 0.
        e_nnams = ls_npat-nnams.
        e_vnams = ls_npat-vnams.
      ENDIF.
    ELSEIF l_papid IS NOT INITIAL.
      CALL METHOD cl_ish_dbr_pap=>get_pap_by_papid
        EXPORTING
          i_papid         = l_papid
        IMPORTING
          es_npap         = ls_npap
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      IF l_rc = 0.
        e_nnams = ls_npap-nnams.
        e_vnams = ls_npap-vnams.
      ENDIF.
    ENDIF.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_risk_icon.

* definitions
  DATA: l_patnr         TYPE patnr,
        l_einri         TYPE einri,
        l_found_risk    TYPE ish_on_off.

* initialization
  CLEAR: e_rc, e_icon, e_risk.

* check input
  CHECK ir_object IS BOUND.

* get patient
  CALL METHOD cl_ish_utl_base_patient=>get_patient_of_obj
    EXPORTING
      ir_object       = ir_object
    IMPORTING
      e_patnr         = l_patnr
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0 AND l_patnr IS NOT INITIAL.


* get institution
  l_einri = cl_ish_utl_base=>get_institution_of_obj( ir_object ).
  CHECK l_einri IS NOT INITIAL.
* START MED-40483 2010/08/04
* if riscinformation existing
  CALL METHOD cl_ish_dbr_pat=>get_risk_inf_by_patnr
    EXPORTING
      i_patnr         = l_patnr
      i_read_db       = off
      i_no_buffer     = off
    IMPORTING
      e_has_risk_inf  = e_risk
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF  e_rc <> 0.
    RETURN.
  ENDIF.
  IF e_risk IS INITIAL.
    RETURN.
  ENDIF.
** check if risks available
*    CALL FUNCTION 'ISH_CHECK_STORNO_NPAT_RISK'
*      EXPORTING
*        ss_einri      = l_einri
*        ss_patnr      = l_patnr
*      IMPORTING
*        ss_found_risk = l_found_risk.
*    CHECK l_found_risk = '1'.
*
*    e_risk = on.
* END MED-40483
* get icon
  CALL METHOD cl_ish_display_tools=>get_wp_icon
    EXPORTING
      i_einri     = l_einri
      i_indicator = '006'
    IMPORTING
      e_icon      = e_icon.

ENDMETHOD.


METHOD is_object_of_patient_tmp.

  DATA: l_patnr        TYPE patnr,
        l_rc           TYPE ish_method_rc.

  DATA: lr_pap         TYPE REF TO cl_ish_patient_provisional.
* ----- ----- ----- -----
  CLEAR: e_pat_is_tmp, e_rc.
  CHECK: ir_identify_object IS NOT INITIAL.
* ----- ----- ----- -----
* get patien
  CALL METHOD cl_ish_utl_base_patient=>get_patient_of_obj
    EXPORTING
      ir_object       = ir_identify_object
    IMPORTING
      e_patnr         = l_patnr
      er_pap          = lr_pap
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
* ----- ----- ----- -----
  IF l_rc <> 0 .
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ----- ----- ----- -----
  CALL METHOD cl_ish_utl_base_patient=>is_patient_tmp
    EXPORTING
      i_patnr         = l_patnr
      ir_pap          = lr_pap
      it_tmp_object   = it_tmp_object
    IMPORTING
      e_pat_is_tmp    = e_pat_is_tmp
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
* ----- ----- ----- -----
ENDMETHOD.


METHOD is_patient_tmp.
* ----- ----- ----- -----
* definitions
  DATA: l_patnr_tmp            TYPE npat-patnr,
        l_rc                   TYPE ish_method_rc.
* object references
  FIELD-SYMBOLS:
        <lr_id_obj>            TYPE REF TO if_ish_identify_object.

  DATA: lr_pap_tmp             TYPE REF TO cl_ish_patient_provisional.
* ----- ----- ----- -----
  CLEAR: e_pat_is_tmp, e_rc.
  IF i_patnr IS INITIAL AND ir_pap IS INITIAL.
    EXIT.
  ENDIF.

  LOOP AT it_tmp_object ASSIGNING <lr_id_obj>.
*   ----- ----- ----- -----
*   get patient of temp data
    CALL METHOD cl_ish_utl_base_patient=>get_patient_of_obj
      EXPORTING
        ir_object       = <lr_id_obj>
      IMPORTING
        e_patnr         = l_patnr_tmp
        er_pap          = lr_pap_tmp
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   ----- ----- ----- -----
*   compare patient of temp data and actual patient
    IF (     i_patnr =  l_patnr_tmp AND
         NOT i_patnr IS INITIAL )   OR
       (     ir_pap  =  lr_pap_tmp   AND
         NOT ir_pap  IS INITIAL ).
      e_pat_is_tmp = on.
      EXIT.   " no further checks necessary
    ENDIF.
* ----- ----- ----- -----
  ENDLOOP.
* ----- ----- ----- -----
ENDMETHOD.
ENDCLASS.
