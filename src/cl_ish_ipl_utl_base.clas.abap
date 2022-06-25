class CL_ISH_IPL_UTL_BASE definition
  public
  abstract
  create public

  global friends CL_ISH_UTL_BASE
                 CL_ISH_UTL_BASE_CASE
                 CL_ISH_UTL_BASE_PATIENT .

*"* public components of class CL_ISH_IPL_UTL_BASE
*"* do not include other source files here!!!
public section.

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
protected section.
*"* protected components of class CL_ISH_IPL_UTL_BASE
*"* do not include other source files here!!!

  class-methods GET_PAP_FOR_OBJECT
    importing
      !I_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      !I_READ_OVER_CONNECT type ISH_ON_OFF
    exporting
      !E_PAP_OBJ type ref to CL_ISH_PATIENT_PROVISIONAL
      value(E_NPAP) type NPAP
      value(E_FOUND) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_CASE_OF_OBJ
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
    exporting
      !E_FALNR type NFAL-FALNR
      !ES_NFAL type NFAL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
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
private section.
*"* private components of class CL_ISH_IPL_UTL_BASE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_IPL_UTL_BASE IMPLEMENTATION.


METHOD get_case_of_obj .

* definitions
  DATA: l_rc                 TYPE ish_method_rc,
        l_is_impl            TYPE ish_on_off,
        l_falnr              TYPE nfal-falnr,
        l_not_found          TYPE ish_on_off,
        l_einri              TYPE tn01-einri,
        ls_nfal              TYPE nfal.
* object references
  DATA: lr_get_case          TYPE REF TO if_ish_get_case,
        lr_run               TYPE REF TO cl_ish_run_data.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  CLEAR: e_falnr, es_nfal.
* ---------- ---------- ----------
* object is mandatory
  IF ir_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* check if objeckt implement interface "IF_ISH_GET_CASE"
* -> if yes call method "get_case" of interface
* START MED-34863 2010/01/26 Performance HP
*  CALL METHOD cl_ish_utl_base=>is_interface_implemented
*    EXPORTING
*      ir_object        = ir_object
*      i_interface_name = 'IF_ISH_GET_CASE'
*    RECEIVING
*      r_is_implemented = l_is_impl.
*  IF l_is_impl = on.
  TRY .
*   END MED-34863
*   cast object
      lr_get_case ?= ir_object.
      IF es_nfal IS SUPPLIED.
        CALL METHOD lr_get_case->get_case
          IMPORTING
            e_falnr         = e_falnr
            es_nfal         = es_nfal
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
      ELSE.
        CALL METHOD lr_get_case->get_case
          IMPORTING
            e_falnr         = e_falnr
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
      ENDIF.
*   leave method
      EXIT.
*  START MED-34863 2010/01/26 Performace HP
*  ENDIF.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
* nothing to do
  ENDTRY.
* END MED-34863

* ---------- ---------- ----------
* object doesn't implement IF_ISH_GET_CASE
* -> try to find patient via method "get_data_field"
* ---------- ----------
* to do so it's necessary that object is for trancaction data,
* because than it's cleat that there is a method "get_data_field"
* ---------- ----------
  IF ir_object->is_inherited_from( cl_ish_run_data=>co_otype_run_data ) = on.
*   ---------- ----------
*   cast to transaction data
    lr_run ?= ir_object.
*   ---------- ----------
*   try to get FALNR
    CLEAR: l_falnr, l_not_found.
    CALL METHOD lr_run->get_data_field
      EXPORTING
        i_fill          = off
        i_fieldname     = 'FALNR'
      IMPORTING
        e_rc            = l_rc
        e_field         = l_falnr
        e_fld_not_found = l_not_found
      CHANGING
        c_errorhandler  = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ----------
  IF NOT l_falnr IS INITIAL.
    e_falnr = l_falnr.
*   ----------
*   get data of case if necessary
    IF es_nfal IS SUPPLIED.
      l_einri = cl_ish_utl_base=>get_institution_of_obj( ir_object ).
      CALL FUNCTION 'ISH_READ_NFAL'
        EXPORTING
          ss_einri = l_einri
          ss_falnr = l_falnr
          i_tc_auth = off    "OSS_2868331 AG
          "don't need to check behandlungsauftrag here because it propagates other errors!
          "also for provisional patients when assigning a case the newly created patient
          "doesn't have behandlungsauftrag and it always returns an error which is not correct!
        IMPORTING
          ss_nfal  = ls_nfal
        EXCEPTIONS
          OTHERS   = 1.
      l_rc = sy-subrc.
      IF l_rc = 0.
        es_nfal = ls_nfal.
      ELSE.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.         " IF es_nfal IS SUPPLIED.
*   ----------
  ENDIF.           " IF NOT l_falnr IS INITIAL.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_pap_for_object.

* definitions
  DATA: l_rc                 TYPE ish_method_rc,
        l_is_impl            TYPE ish_on_off,
        l_patnr              TYPE npat-patnr,
        l_papid              TYPE npap-papid,
        l_not_found          TYPE ish_on_off,
        ls_pap_key           TYPE rnpap_key,
        ls_pap_data          TYPE rnpap_attrib,
        ls_npap              TYPE npap,
        l_found              TYPE ish_on_off.
* object references
  DATA: lr_get_pat           TYPE REF TO if_ish_get_patient,
        lr_pap               TYPE REF TO cl_ish_patient_provisional,
        lr_run               TYPE REF TO cl_ish_run_data,
        lr_corder            TYPE REF TO cl_ish_corder,
        lr_prereg            TYPE REF TO cl_ishmed_prereg,
        lr_ac                TYPE REF TO cl_ish_app_constraint,
        lr_app               TYPE REF TO cl_ish_appointment,
        lr_env               TYPE REF TO cl_ish_environment.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  CLEAR: e_pap_obj, e_npap, e_found.
* ---------- ---------- ----------
* object is mandatory
  IF i_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* check if objeckt implement interface "IF_ISH_GET_PATIENT"
* -> if yes call method "get_patient" of interface
* START MED-34864 2010/01/26 Perforamce HP
*  CALL METHOD cl_ish_utl_base=>is_interface_implemented
*    EXPORTING
*      ir_object        = i_object
*      i_interface_name = 'IF_ISH_GET_PATIENT'
*    RECEIVING
*      r_is_implemented = l_is_impl.
*  IF l_is_impl = on.
  TRY .
*   END MED-34863
*   cast object
      lr_get_pat ?= i_object.
      CALL METHOD lr_get_pat->get_patient
        IMPORTING
          e_patnr         = l_patnr
          er_pap          = lr_pap
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      IF l_rc = 0.
        IF lr_pap IS NOT INITIAL AND
           e_npap IS SUPPLIED.
*       get data for return
          CALL METHOD lr_pap->get_data
            IMPORTING
              es_key         = ls_pap_key
              es_data        = ls_pap_data
              e_rc           = l_rc
            CHANGING
              c_errorhandler = c_errorhandler.
          IF l_rc = 0.
            e_pap_obj  =  lr_pap.
            MOVE-CORRESPONDING ls_pap_key  TO e_npap.
            MOVE-CORRESPONDING ls_pap_data TO e_npap.
          ELSE.
            e_rc = l_rc.
            EXIT.
          ENDIF.
        ENDIF.       " IF NOT lr_pap IS INITIAL.
      ELSE.
        e_rc = l_rc.
        EXIT.
      ENDIF.
*   leave method
      EXIT.
* START MED-34863 2010/01/26 Performace HP
*  ENDIF.   " IF l_is_impl = on.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
* nothig to do
  ENDTRY.
* END MED-34863
* ---------- ---------- ----------
* process further checks only for transaction data
  IF i_object->is_inherited_from( cl_ish_run_data=>co_otype_run_data ) = on.
*   ---------- ---------
*   cast to transaction data
    lr_run ?= i_object.
*   ---------- ---------
*   initialize local values
    CLEAR: lr_env, ls_pap_key, ls_pap_data, lr_pap,
           ls_npap, l_found.
*   ---------- ---------
*   get environment
    CALL METHOD lr_run->get_environment
      IMPORTING
        e_environment = lr_env.
*   ---------- ---------
    IF lr_run->is_inherited_from( cl_ishmed_corder=>co_otype_corder ) = on.
*     corder
      lr_corder ?= i_object.
      CALL METHOD lr_corder->get_patient_provisional
        EXPORTING
          ir_environment         = lr_env
        IMPORTING
          er_patient_provisional = lr_pap
*         es_pap_key             = ls_pap_key   MED-34863 Performace
*         es_pap_data            = ls_pap_data  MED-34863 Performace
          e_rc                   = l_rc.
    ELSEIF lr_run->is_inherited_from( cl_ishmed_prereg=>co_otype_prereg ) = on.
*     preregistration (cordpos)
      lr_prereg ?= i_object.
      CALL METHOD cl_ishmed_prereg=>get_patient_provi
        EXPORTING
          i_prereg      = lr_prereg
          i_environment = lr_env
        IMPORTING
*         e_pap_key     = ls_pap_key  MED-34863 Performace
*         e_pap_data    = ls_pap_data MED-34863 Performace
          e_pat_provi   = lr_pap
          e_rc          = l_rc.
    ELSEIF lr_run->is_inherited_from( cl_ish_app_constraint=>co_otype_app_constraint ) = on.
*     appointment constraint
      lr_ac ?= i_object.
      CALL METHOD lr_ac->get_patient_provisional
        EXPORTING
          ir_environment         = lr_env
        IMPORTING
          er_patient_provisional = lr_pap
*         es_pap_key             = ls_pap_key    MED-34863 Performace
*         es_pap_data            = ls_pap_data   MED-34863 Performace
          e_rc                   = l_rc.
    ELSEIF lr_run->is_inherited_from( cl_ish_appointment=>co_otype_appointment ) = on.
*     appointment
      lr_app ?= i_object.
      CALL METHOD cl_ish_appointment=>get_patient_provi
        EXPORTING
          i_appmnt            = lr_app
          i_environment       = lr_env
          i_read_over_connect = i_read_over_connect  "PN/19657/2006/07/20
        IMPORTING
*         e_pap_key           = ls_pap_key       MED-34863 Performace
*         e_pap_data          = ls_pap_data      MED-34863 Performace
          e_pat_provi         = lr_pap
          e_rc                = l_rc.
    ELSEIF lr_run->is_inherited_from(
    cl_ishmed_patient_provisional=>co_otype_prov_patient ) = on.
*     patient with provisional data
      lr_pap ?= i_object.
*     START MED-34863 2010/01/28 HP Performace
*      CALL METHOD lr_pap->get_data
*        IMPORTING
*          es_key  = ls_pap_key
*          es_data = ls_pap_data
*          e_rc    = l_rc.
*      END MED-34863
    ENDIF.
  ENDIF. " IF i_object->is_inherited_from( cl_ish_run_data=>co_otype_run_data ) = on.
* ---------- ---------- ----------
* return values
  IF l_rc = 0.
    IF lr_pap IS INITIAL.
      e_found = off.
    ELSE.
      e_found    =  on.
      e_pap_obj  =  lr_pap.
*     START MED-34863 2010/01/28 HP Performace
      IF e_npap IS SUPPLIED.
        CALL METHOD lr_pap->get_data
          IMPORTING
            es_key  = ls_pap_key
            es_data = ls_pap_data
            e_rc    = l_rc.
*       END MED-34863
        IF ls_npap IS INITIAL.
          MOVE-CORRESPONDING ls_pap_key  TO e_npap.
          MOVE-CORRESPONDING ls_pap_data TO e_npap.
        ELSE.
          e_npap = ls_npap.
        ENDIF.
      ENDIF.      "MED-34863 Performace
    ENDIF.
  ELSE.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_patient_of_obj .

* definitions
  DATA: l_rc                 TYPE ish_method_rc,
        l_is_impl            TYPE ish_on_off,
        l_patnr              TYPE npat-patnr,
        l_papid              TYPE npap-papid,
        l_falnr              TYPE nfal-falnr,
        l_not_found          TYPE ish_on_off,
        l_einri              TYPE tn01-einri,
        ls_nfal              TYPE nfal,
        ls_pap_key           TYPE rnpap_key.
* object references
  DATA: lr_get_pat           TYPE REF TO if_ish_get_patient,
*        lr_pap               TYPE REF TO cl_ish_patient_provisional,
        lr_run               TYPE REF TO cl_ish_run_data.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  CLEAR: e_patnr, e_papid,er_pap.
* ---------- ---------- ----------
* object is mandatory
  IF ir_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* check if objeckt implement interface "IF_ISH_GET_PATIENT"
* -> if yes call method "get_patient" of interface
*  START MED-34863 2010/01/26 Performace HP
*  CALL METHOD cl_ish_utl_base=>is_interface_implemented
*    EXPORTING
*      ir_object        = ir_object
*      i_interface_name = 'IF_ISH_GET_PATIENT'
*    RECEIVING
*      r_is_implemented = l_is_impl.
*  IF l_is_impl = on.
  TRY .
*   END MED-34863
*   cast object
      lr_get_pat ?= ir_object.
      CALL METHOD lr_get_pat->get_patient
        IMPORTING
          e_patnr         = e_patnr
          e_papid         = e_papid
          er_pap          = er_pap
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
*   leave method
      EXIT.
*   START MED-34863 2010/01/26 Performace HP
*  ENDIF.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
*    nothing to do
  ENDTRY.
* END MED-34863
* ---------- ---------- ----------
* object doesn't implement IF_ISH_GET_PATIENT
* -> try to find patient via method "get_data_field"
* ---------- ----------
* to do so it's necessary that object is for trancaction data,
* because than it's cleat that there is a method "get_data_field"
* ---------- ----------
  CHECK ir_object->is_inherited_from( cl_ish_run_data=>co_otype_run_data ) = on.
* ---------- ----------
* cast to transaction data
  lr_run ?= ir_object.
* ---------- ----------
* try to get PATNR
  CLEAR: l_patnr, l_not_found.
  CALL METHOD lr_run->get_data_field
    EXPORTING
      i_fill          = off
      i_fieldname     = 'PATNR'
    IMPORTING
      e_rc            = l_rc
      e_field         = l_patnr
      e_fld_not_found = l_not_found
    CHANGING
      c_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ----------
  IF NOT l_patnr IS INITIAL.
    e_patnr = l_patnr.
  ELSE.
*   try to get PAP
    CALL METHOD cl_ish_utl_base_patient=>get_pap_for_object
      EXPORTING
        i_object       = lr_run
      IMPORTING
        e_pap_obj      = er_pap
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   -----
    IF     e_papid IS SUPPLIED AND
       NOT er_pap  IS INITIAL.
      CLEAR: l_papid, l_not_found.
      CALL METHOD er_pap->get_data
        IMPORTING
          es_key         = ls_pap_key
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF l_rc = 0.
        e_papid = ls_pap_key-papid.
      ELSE.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------
* it wasn't possible to find number of real patient or
* number of patient with provisional data
* ---------- ----------
  CHECK l_patnr IS INITIAL AND
        er_pap  IS INITIAL.
* ---------- ----------
* try to get FALNR
* with falnr you also can get the patient
  CLEAR: l_falnr, l_not_found.
  CALL METHOD cl_ish_utl_base_case=>get_case_of_obj
    EXPORTING
      ir_object       = ir_object
    IMPORTING
      e_falnr         = l_falnr
      es_nfal         = ls_nfal
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc = 0.
    IF NOT ls_nfal IS INITIAL.
      e_patnr = ls_nfal-patnr.
    ENDIF.
  ELSE.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
