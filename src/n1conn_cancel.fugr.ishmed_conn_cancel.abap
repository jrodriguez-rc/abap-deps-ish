FUNCTION ishmed_conn_cancel.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_INSTITUTION) TYPE  EINRI
*"     VALUE(I_SAVE) TYPE  ISH_ON_OFF DEFAULT ON
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT ON
*"     VALUE(I_ENQUEUE) TYPE  ISH_ON_OFF DEFAULT ON
*"     VALUE(IT_CANCEL_DATA) TYPE  ISHMED_T_CONN_CANCEL_DATA
*"  EXPORTING
*"     VALUE(ET_MESSAGES) TYPE  ISHMED_T_BAPIRET2
*"     VALUE(E_MAXTY) TYPE  ISH_BAPIRETMAXTY
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"----------------------------------------------------------------------

  DATA: lr_errorhandler       TYPE REF TO cl_ishmed_errorhandling,
        lr_environment        TYPE REF TO cl_ish_environment,
        l_cr_own_env          TYPE ish_on_off,
        l_rc                  TYPE ish_method_rc,
        ls_data               LIKE LINE OF it_cancel_data,
        lt_erboe              TYPE ishmed_t_orgid,
        l_erboe               LIKE LINE OF lt_erboe,
        lt_objects            TYPE ish_objectlist,
        ls_object             LIKE LINE OF lt_objects,
        ls_pap_key            TYPE rnpap_key,
        ls_nipp_key           TYPE rnipp_key,
        ls_ndip_key           TYPE rndip_key,
        ls_npcp_key           TYPE rnpcp_key,
        ls_nwlm_key           TYPE rnwlm_key,
        l_app_cancel          TYPE ish_on_off,
        l_srv_cancel          TYPE ish_on_off,
        l_vkg_cancel          TYPE ish_on_off,
        l_pap_cancel          TYPE ish_on_off,
        l_req_cancel          TYPE ish_on_off,
        l_ord_cancel          TYPE ish_on_off,
        l_srv_with_app_cancel TYPE ish_on_off,
        l_movement_cancel     TYPE ish_on_off,
        lr_corder             TYPE REF TO cl_ish_corder,
        lr_prereg             TYPE REF TO cl_ishmed_prereg,
        lr_req                TYPE REF TO cl_ishmed_request,
        lr_app                TYPE REF TO cl_ish_appointment,
        lr_app_constr         TYPE REF TO cl_ish_app_constraint,
        lr_app_constr_d       TYPE REF TO cl_ish_app_constraint_d,
        lr_team               TYPE REF TO cl_ishmed_team,
        lr_srv                TYPE REF TO cl_ishmed_service,
        lr_vitpar             TYPE REF TO cl_ishmed_vitpar,
        lr_context            TYPE REF TO cl_ish_context,
        lr_pap                TYPE REF TO cl_ish_patient_provisional,
        lr_insurance          TYPE REF TO cl_ish_insurance_policy_prov,
        lr_procedure          TYPE REF TO cl_ish_prereg_procedure,
        lr_diagnosis          TYPE REF TO cl_ish_prereg_diagnosis,
        lr_absence            TYPE REF TO cl_ish_waiting_list_absence,
        lr_me_order           TYPE REF TO cl_ishmed_me_order,
        lr_me_event           TYPE REF TO cl_ishmed_me_event,
        lr_me_event_drug      TYPE REF TO cl_ishmed_me_event_drug,
        lr_me_eaddoc          TYPE REF TO cl_ishmed_me_eaddoc,
        lr_me_eprepdoc        TYPE REF TO cl_ishmed_me_eprepdoc,
        lr_me_order_drug      TYPE REF TO cl_ishmed_me_order_drug,
        lr_me_order_rate      TYPE REF TO cl_ishmed_me_order_rate,
        lr_cycle              TYPE REF TO cl_ishmed_cycle,
        lr_cycledef           TYPE REF TO cl_ishmed_cycledef.

  DATA: l_result_rfc          TYPE abap_bool VALUE abap_false. " Checkman Note 3085869 Bi

* initialize
  e_rc = 0.
  CLEAR: e_maxty, et_messages[].

  CHECK it_cancel_data[] IS NOT INITIAL.

* create errorhandler
  CREATE OBJECT lr_errorhandler.

* <<< Checkman Note 3085869 Bi
* authorization check
  cl_rfc=>check_rfc_external_direct(
  RECEIVING
  direct_external_call = l_result_rfc
  EXCEPTIONS
    kernel_too_old       = 1
    unexpected_error     = 2
    OTHERS               = 3
    ).

  IF sy-subrc <> 0.
    e_rc = 11.
    CALL METHOD cl_ish_utl_base=>collect_messages
    EXPORTING
      i_typ           = 'E'
      i_kla           = 'N1CORDMG'
      i_num           = '002'
      i_mv1           = 'RFC'
    CHANGING
      cr_errorhandler = lr_errorhandler.
    CALL METHOD lr_errorhandler->get_messages
    IMPORTING
      t_messages      = et_messages.
*      t_ws_messages   = et_errormessages.
    RETURN.
  ENDIF.

  IF l_result_rfc = abap_true.
    AUTHORITY-CHECK OBJECT 'N_1CORDER'
    ID 'N_EINRI' FIELD i_institution
    ID 'N_ETRBY'  DUMMY
    ID 'N_ETROE'  DUMMY
    ID 'N_ETRGP'  DUMMY
    ID 'N_ORDDEP' DUMMY
    ID 'N_VKGOE'  DUMMY
    ID 'N_ORGFA'  DUMMY
    ID 'STSMA'    DUMMY
    ID 'N_STATUS' DUMMY
    ID 'ACTVT' FIELD '85'.  " Cancel
    IF sy-subrc <> 0.
      lr_errorhandler->collect_messages(
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1CORDMG'
        i_num           = '107'
        ).
      lr_errorhandler->get_messages(
      IMPORTING
        t_messages      =  et_messages
*        t_ws_messages   =  et_errormessages
        ).
      RETURN.
    ENDIF.
  ENDIF.
* >>> Checkman Note 3085869 Bi

* create local environment
  CALL METHOD cl_ishmed_functions=>get_environment
    EXPORTING
      i_caller       = 'ISHMED_CONN_CORDER'
      i_npol_set     = on
    IMPORTING
      e_env_created  = l_cr_own_env
      e_rc           = l_rc
    CHANGING
      c_environment  = lr_environment
      c_errorhandler = lr_errorhandler.

  IF l_rc <> 0.
    CALL METHOD lr_errorhandler->get_messages
      IMPORTING
        t_messages = et_messages
        e_maxty    = e_maxty.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* get/set objects to cancel
  REFRESH lt_objects.
  LOOP AT it_cancel_data INTO ls_data.
    CLEAR ls_object.
    IF ls_data-corderid IS NOT INITIAL.
*     clinical order
      CALL METHOD cl_ish_fac_corder=>load
        EXPORTING
          i_corderid      = ls_data-corderid
          ir_environment  = lr_environment
        IMPORTING
          er_instance     = lr_corder
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_corder.
    ELSEIF ls_data-vkgid IS NOT INITIAL.
*     clinical order position
      CALL METHOD cl_ishmed_prereg=>load
        EXPORTING
          i_vkgid        = ls_data-vkgid
          i_environment  = lr_environment
        IMPORTING
          e_instance     = lr_prereg
          e_rc           = l_rc
        CHANGING
          c_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_prereg.
    ELSEIF ls_data-einri IS NOT INITIAL AND
           ls_data-anfid IS NOT INITIAL.
*     request
      CALL METHOD cl_ishmed_request=>load
        EXPORTING
          i_mandt        = sy-mandt
          i_einri        = ls_data-einri
          i_anfid        = ls_data-anfid
          i_environment  = lr_environment
        IMPORTING
          e_rc           = l_rc
          e_instance     = lr_req
        CHANGING
          c_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_app.
    ELSEIF ls_data-tmnid IS NOT INITIAL.
*     appointment
      CALL METHOD cl_ish_appointment=>load
        EXPORTING
          i_tmnid        = ls_data-tmnid
          i_environment  = lr_environment
        IMPORTING
          e_rc           = l_rc
          e_instance     = lr_app
        CHANGING
          c_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_app.
    ELSEIF ls_data-apcnid IS NOT INITIAL.
*     appointment constraint
      CALL METHOD cl_ish_app_constraint=>load
        EXPORTING
          i_apcnid        = ls_data-apcnid
          ir_environment  = lr_environment
        IMPORTING
          e_rc            = l_rc
          er_instance     = lr_app_constr
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_app_constr.
    ELSEIF ls_data-apcndid IS NOT INITIAL.
*     appointment constraint dependencies
      CALL METHOD cl_ish_app_constraint_d=>load
        EXPORTING
          i_apcndid       = ls_data-apcndid
          ir_environment  = lr_environment
        IMPORTING
          e_rc            = l_rc
          er_instance     = lr_app_constr_d
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_app_constr_d.
    ELSEIF ls_data-lnrls IS NOT INITIAL AND
           ls_data-vrgnr IS NOT INITIAL.
*     team
      CALL METHOD cl_ishmed_team=>load
        EXPORTING
          i_lnrls        = ls_data-lnrls
          i_vrgnr        = ls_data-vrgnr
          i_environment  = lr_environment
        IMPORTING
          e_rc           = l_rc
          e_instance     = lr_team
        CHANGING
          c_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_team.
    ELSEIF ls_data-lnrls IS NOT INITIAL.
*     service
      CALL METHOD cl_ishmed_service=>load
        EXPORTING
          i_lnrls        = ls_data-lnrls
          i_environment  = lr_environment
        IMPORTING
          e_rc           = l_rc
          e_instance     = lr_srv
        CHANGING
          c_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_srv.
    ELSEIF ls_data-vpid IS NOT INITIAL.
*     vitalparameter
      CALL METHOD cl_ishmed_vitpar=>load
        EXPORTING
          i_mandt        = sy-mandt
          i_vpid         = ls_data-vpid
          i_environment  = lr_environment
        IMPORTING
          e_rc           = l_rc
          e_instance     = lr_vitpar
        CHANGING
          c_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_vitpar.
    ELSEIF ls_data-vpid IS NOT INITIAL.
*     context
      CALL METHOD cl_ish_context=>load
        EXPORTING
          i_cxid         = ls_data-cxid
          i_environment  = lr_environment
        IMPORTING
          e_rc           = l_rc
          e_instance     = lr_context
        CHANGING
          c_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_context.
    ELSEIF ls_data-ippno IS NOT INITIAL.
*     insurance policy
      CLEAR ls_nipp_key.
      ls_nipp_key-ippno = ls_data-ippno.
      CALL METHOD cl_ish_insurance_policy_prov=>load
        EXPORTING
          is_key              = ls_nipp_key
          i_environment       = lr_environment
        IMPORTING
          e_instance          = lr_insurance
        EXCEPTIONS
          missing_environment = 1
          not_found           = 2
          OTHERS              = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
      ls_object-object = lr_insurance.
    ELSEIF ls_data-dipno IS NOT INITIAL.
*     diagnosis
      CLEAR ls_ndip_key.
      ls_ndip_key-dipno = ls_data-dipno.
      CALL METHOD cl_ish_prereg_diagnosis=>load
        EXPORTING
          is_key              = ls_ndip_key
          i_environment       = lr_environment
        IMPORTING
          e_instance          = lr_diagnosis
        EXCEPTIONS
          missing_environment = 1
          not_found           = 2
          OTHERS              = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
      ls_object-object = lr_diagnosis.
    ELSEIF ls_data-pcpno IS NOT INITIAL.
*     procedure
      CLEAR ls_npcp_key.
      ls_npcp_key-pcpno = ls_data-pcpno.
      CALL METHOD cl_ish_prereg_procedure=>load
        EXPORTING
          is_key              = ls_npcp_key
          i_environment       = lr_environment
        IMPORTING
          e_instance          = lr_procedure
        EXCEPTIONS
          missing_environment = 1
          not_found           = 2
          OTHERS              = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
      ls_object-object = lr_procedure.
    ELSEIF ls_data-absno IS NOT INITIAL.
*     waiting list absence
      CLEAR ls_nwlm_key.
      ls_nwlm_key-absno = ls_data-absno.
      CALL METHOD cl_ish_waiting_list_absence=>load
        EXPORTING
          is_key              = ls_nwlm_key
          i_environment       = lr_environment
        IMPORTING
          e_instance          = lr_absence
        EXCEPTIONS
          missing_environment = 1
          not_found           = 2
          OTHERS              = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
      ls_object-object = lr_absence.
    ELSEIF ls_data-gencyid IS NOT INITIAL.
*     cycle
      CALL METHOD cl_ishmed_cycle=>load
        EXPORTING
          i_gencyid      = ls_data-gencyid
          i_environment  = lr_environment
        IMPORTING
          e_rc           = l_rc
          e_instance     = lr_cycle
        CHANGING
          c_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_cycle.
    ELSEIF ls_data-cydefid IS NOT INITIAL.
*     cycle definition
      CALL METHOD cl_ishmed_cycledef=>load
        EXPORTING
          i_cydefid      = ls_data-cydefid
          i_environment  = lr_environment
        IMPORTING
          e_rc           = l_rc
          e_instance     = lr_cycledef
        CHANGING
          c_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_cycledef.
    ELSEIF ls_data-meordid IS NOT INITIAL.
*     medication order
      CALL METHOD cl_ishmed_me_order=>load
        EXPORTING
          i_mandt         = sy-mandt
          i_meordid       = ls_data-meordid
          ir_environment  = lr_environment
        IMPORTING
          e_rc            = l_rc
          er_instance     = lr_me_order
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_me_order.
    ELSEIF ls_data-meevtid IS NOT INITIAL.
*     medication event
      CALL METHOD cl_ishmed_me_event=>load
        EXPORTING
          i_mandt         = sy-mandt
          i_meevtid       = ls_data-meevtid
          ir_environment  = lr_environment
        IMPORTING
          e_rc            = l_rc
          er_instance     = lr_me_event
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_me_event.
    ELSEIF ls_data-edrugid IS NOT INITIAL.
*     medication event drug
      CALL METHOD cl_ishmed_me_event_drug=>load
        EXPORTING
          i_mandt         = sy-mandt
          i_edrugid       = ls_data-edrugid
          ir_environment  = lr_environment
        IMPORTING
          e_rc            = l_rc
          er_instance     = lr_me_event_drug
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_me_event_drug.
    ELSEIF ls_data-meevtid IS NOT INITIAL.
*     medication event administration document
      CALL METHOD cl_ishmed_me_eaddoc=>load
        EXPORTING
          i_mandt         = sy-mandt
          i_eaddocid      = ls_data-eaddocid
          ir_environment  = lr_environment
        IMPORTING
          e_rc            = l_rc
          er_instance     = lr_me_eaddoc
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_me_eaddoc.
    ELSEIF ls_data-eprepid IS NOT INITIAL.
*     medication event preparation document
      CALL METHOD cl_ishmed_me_eprepdoc=>load
        EXPORTING
          i_mandt         = sy-mandt
          i_eprepid       = ls_data-eprepid
          ir_environment  = lr_environment
        IMPORTING
          e_rc            = l_rc
          er_instance     = lr_me_eprepdoc
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_me_eprepdoc.
    ELSEIF ls_data-odrugid IS NOT INITIAL.
*     medication order drug
      CALL METHOD cl_ishmed_me_order_drug=>load
        EXPORTING
          i_mandt         = sy-mandt
          i_odrugid       = ls_data-odrugid
          ir_environment  = lr_environment
        IMPORTING
          e_rc            = l_rc
          er_instance     = lr_me_order_drug
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_me_order_drug.
    ELSEIF ls_data-orateid IS NOT INITIAL.
*     medication order rate
      CALL METHOD cl_ishmed_me_order_rate=>load
        EXPORTING
          i_mandt         = sy-mandt
          i_orateid       = ls_data-orateid
          ir_environment  = lr_environment
        IMPORTING
          e_rc            = l_rc
          er_instance     = lr_me_order_rate
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_object-object = lr_me_order_rate.
*
    ELSE.
      CONTINUE.
    ENDIF.
    CHECK ls_object-object IS BOUND.
    APPEND ls_object TO lt_objects.
  ENDLOOP.
  CHECK e_rc = 0.

  CHECK lt_objects[] IS NOT INITIAL.

  l_app_cancel = on.
  l_srv_cancel = on.
  l_vkg_cancel = on.
  l_pap_cancel = on.
  l_req_cancel = on.
  l_ord_cancel = on.
  l_movement_cancel = on.
  l_srv_with_app_cancel = '*'.

* get org.unit
  CLEAR: l_erboe, lt_erboe[].
  CALL METHOD cl_ishmed_functions=>get_erboes
    EXPORTING
      it_objects     = lt_objects
    IMPORTING
      e_rc           = l_rc
      et_erboe       = lt_erboe
    CHANGING
      c_errorhandler = lr_errorhandler.
  IF l_rc = 0.
    READ TABLE lt_erboe INTO l_erboe INDEX 1.
  ELSE.
    CALL METHOD lr_errorhandler->get_messages
      IMPORTING
        t_messages = et_messages
        e_maxty    = e_maxty.
    e_rc = l_rc.
    IF l_cr_own_env = on.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = lr_environment.
    ENDIF.
    EXIT.
  ENDIF.

* call cancel function
  CALL METHOD cl_ish_environment=>cancel_objects
    EXPORTING
      it_objects            = lt_objects
*      it_nbew               =
      i_popup               = off
      i_orgid               = l_erboe-orgid
      i_authority_check     = on
      i_app_cancel          = l_app_cancel
      i_srv_cancel          = l_srv_cancel
      i_vkg_cancel          = l_vkg_cancel
      i_pap_cancel          = l_pap_cancel
      i_req_cancel          = l_req_cancel
      i_corder_cancel       = l_ord_cancel
      i_movement_cancel     = l_movement_cancel
      i_srv_with_app_cancel = l_srv_with_app_cancel
      i_save                = i_save
      i_caller              = 'ISHMED_CONN_CANCEL'
      i_last_srv_cancel     = on
      i_enqueue             = i_enqueue
      i_commit              = i_commit
      i_called_from_conn    = on
    IMPORTING
      e_rc                  = l_rc
    CHANGING
      c_errorhandler        = lr_errorhandler.

  IF l_rc <> 0.
    CALL METHOD lr_errorhandler->get_messages
      IMPORTING
        t_messages = et_messages
        e_maxty    = e_maxty.
    e_rc = l_rc.
  ENDIF.

* destroy local environment
  IF l_cr_own_env = on.
    CALL METHOD cl_ish_utl_base=>destroy_env
      CHANGING
        cr_environment = lr_environment.
  ENDIF.

ENDFUNCTION.
