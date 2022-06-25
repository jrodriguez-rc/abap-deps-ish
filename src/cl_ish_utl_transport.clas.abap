class CL_ISH_UTL_TRANSPORT definition
  public
  create public .

public section.

*"* public components of class CL_ISH_UTL_TRANSPORT
*"* do not include other source files here!!!
  class-methods TRANSPORT_LAYOUT
    importing
      value(I_VIEWTYPE) type NVIEWTYPE
      value(I_LAYOUT) type SLIS_VARI
    exporting
      value(E_TASK) type E070-TRKORR
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods TRANSPORT_SVAR
    importing
      value(I_SVARIANTID) type VARIANT
      value(I_SVAR_REPID) type REPID
    exporting
      value(E_TASK) type TRKORR
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods TRANSPORT_FVAR
    importing
      value(I_FVARID) type NFVARID
      value(I_VIEWTYPE) type NVIEWTYPE
    exporting
      value(E_TASK) type TRKORR
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  type-pools ABAP .
  class-methods IS_ALLOWED
    returning
      value(IS_ALLOWED) type ABAP_BOOL .
protected section.

  types:
    BEGIN OF gty_sys_params,
         systemedit          TYPE tadir-edtflag,
         systemname          TYPE sy-sysid,
         systemtype          TYPE sy-sysid,
         system_client_edit  TYPE t000-cccoractiv,
         sys_cliinddep_edit  TYPE t000-ccnocliind,
         system_client_role  TYPE t000-cccategory,
         ev_sfw_bcset_rec    TYPE t000-ccorigcont,
         ev_c_system         TYPE trpari-s_checked,
       END OF gty_sys_params .

  class-data GS_SYS_PARAMS type GTY_SYS_PARAMS .

  class-methods INIT_SYS_PARAMS .
*"* protected components of class CL_ISH_UTL_TRANSPORT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_TRANSPORT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_TRANSPORT IMPLEMENTATION.


METHOD INIT_SYS_PARAMS.

* Process only if not already read.
  CHECK gs_sys_params IS INITIAL.

* Read the system parameters.
  CALL FUNCTION 'TR_SYS_PARAMS'
    IMPORTING
      systemedit         = gs_sys_params-systemedit
      systemname         = gs_sys_params-systemname
      systemtype         = gs_sys_params-systemtype
      system_client_edit = gs_sys_params-system_client_edit
      sys_cliinddep_edit = gs_sys_params-sys_cliinddep_edit
      system_client_role = gs_sys_params-system_client_role
      ev_sfw_bcset_rec   = gs_sys_params-ev_sfw_bcset_rec
      ev_c_system        = gs_sys_params-ev_c_system
    EXCEPTIONS
      no_systemname      = 1
      no_systemtype      = 2
      OTHERS             = 3.
  IF sy-subrc <> 0.
    CLEAR gs_sys_params.
  ENDIF.

ENDMETHOD.


METHOD is_allowed.

* Init gs_sys_params.
  init_sys_params( ).

* transport in actual client not aollowed
  IF gs_sys_params-system_client_edit = '3'.
    is_allowed = abap_false.
    RETURN.
  ENDIF.

  is_allowed = abap_true.

ENDMETHOD.


METHOD transport_fvar.

  DATA: l_act_fvar   TYPE nfvarid,
        l_task       TYPE trkorr,
        l_order      TYPE trkorr,
        lt_e071      TYPE tr_objects,
        ls_t000      TYPE t000,
        lt_e071k     TYPE tr_keys.

* Initializations.
  e_rc = 0.

* No actual fvar -> message.
  IF i_fvarid IS INITIAL.
    e_rc = 1.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '067'
        i_par           = 'RN1ME_DYNP_DWS_CCON_ME'
        i_field         = 'FVAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.


* Transport the actual fvar.
  PERFORM tp_vw_fvar IN PROGRAM sapln_wp
              TABLES
                 lt_e071
                 lt_e071k
              USING
                 i_viewtype
                 i_fvarid
                 l_task.

* function module does not work as assumed - no possibility to choose an existing transport order
* so use other function modules.
  DO 1 TIMES.

*   check client - possibly the transport is not allowed
*   SELECT SINGLE * FROM t000 INTO ls_t000.   "MED-47759 M.Rebegea 12.07.2012
    SELECT SINGLE * FROM t000 INTO ls_t000 WHERE mandt = sy-mandt. "MED-47759 M.Rebegea 12.07.2012
    IF ls_t000-cccoractiv = 3.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'SV'
          i_num           = '130'
          i_mv1           = sy-mandt
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = 1.
      EXIT.
    ENDIF.

    CALL FUNCTION 'TR_ORDER_CHOICE_CORRECTION'
      EXPORTING
        iv_category            = 'CUST'
        iv_cli_dep             = 'X'
      IMPORTING
        ev_order               = l_order
        ev_task                = l_task
      EXCEPTIONS
        invalid_category       = 1
        no_correction_selected = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0 AND sy-subrc <> 2.
      e_rc = 1.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ELSEIF sy-subrc = 2.
      EXIT.
    ENDIF.
    CHECK l_task IS NOT INITIAL.

    e_task = l_task.

    CALL FUNCTION 'TR_APPEND_TO_COMM_OBJS_KEYS'
      EXPORTING
        wi_suppress_key_check          = ' '
        wi_trkorr                      = l_task
      TABLES
        wt_e071                        = lt_e071
        wt_e071k                       = lt_e071k
      EXCEPTIONS
        key_char_in_non_char_field     = 1
        key_check_keysyntax_error      = 2
        key_inttab_table               = 3
        key_longer_field_but_no_generc = 4
        key_missing_key_master_fields  = 5
        key_missing_key_tablekey       = 6
        key_non_char_but_no_generic    = 7
        key_no_key_fields              = 8
        key_string_longer_char_key     = 9
        key_table_has_no_fields        = 10
        key_table_not_activ            = 11
        key_unallowed_key_function     = 12
        key_unallowed_key_object       = 13
        key_unallowed_key_objname      = 14
        key_unallowed_key_pgmid        = 15
        key_without_header             = 16
        ob_check_obj_error             = 17
        ob_devclass_no_exist           = 18
        ob_empty_key                   = 19
        ob_generic_objectname          = 20
        ob_ill_delivery_transport      = 21
        ob_ill_lock                    = 22
        ob_ill_parts_transport         = 23
        ob_ill_source_system           = 24
        ob_ill_system_object           = 25
        ob_ill_target                  = 26
        ob_inttab_table                = 27
        ob_local_object                = 28
        ob_locked_by_other             = 29
        ob_modif_only_in_modif_order   = 30
        ob_name_too_long               = 31
        ob_no_append_of_corr_entry     = 32
        ob_no_append_of_c_member       = 33
        ob_no_consolidation_transport  = 34
        ob_no_original                 = 35
        ob_no_shared_repairs           = 36
        ob_no_systemname               = 37
        ob_no_systemtype               = 38
        ob_no_tadir                    = 39
        ob_no_tadir_not_lockable       = 40
        ob_privat_object               = 41
        ob_repair_only_in_repair_order = 42
        ob_reserved_name               = 43
        ob_syntax_error                = 44
        ob_table_has_no_fields         = 45
        ob_table_not_activ             = 46
        tr_enqueue_failed              = 47
        tr_errors_in_error_table       = 48
        tr_ill_korrnum                 = 49
        tr_lockmod_failed              = 50
        tr_lock_enqueue_failed         = 51
        tr_not_owner                   = 52
        tr_no_systemname               = 53
        tr_no_systemtype               = 54
        tr_order_not_exist             = 55
        tr_order_released              = 56
        tr_order_update_error          = 57
        tr_wrong_order_type            = 58
        ob_invalid_target_system       = 59
        tr_no_authorization            = 60
        ob_wrong_tabletyp              = 61
        ob_wrong_category              = 62
        ob_system_error                = 63
        ob_unlocal_objekt_in_local_ord = 64
        tr_wrong_client                = 65
        ob_wrong_client                = 66
        key_wrong_client               = 67
        OTHERS                         = 68.

    IF sy-subrc <> 0.
      e_rc = 1.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.
  ENDDO.
  IF e_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N2DWSWL_ADMIN'
        i_num           = '029'
        i_par           = 'RN1ME_DYNP_DWS_CCON_ME'
        i_field         = 'FVAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD transport_layout.

  DATA: lt_avar      TYPE ish_t_avar,
        l_rc         TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_avar> TYPE rnavar.

* Initializations.
  CLEAR: e_task,
         l_rc.
  e_rc = 0.

* No layout -> message.
  IF i_layout IS INITIAL.
    e_rc = 1.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '066'
        i_par           = 'RN1_DYNP_MEDSRV_PROP'
        i_field         = 'LAYOUT'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Get all layout data
  CALL FUNCTION 'ISHMED_VM_AVAR_GET'
    EXPORTING
      i_viewtype   = i_viewtype
      i_avariantid = i_layout
    IMPORTING
      e_rc         = l_rc
    TABLES
      et_avar      = lt_avar.

  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* No actual layout -> message.
  IF lt_avar[] IS INITIAL.
    e_rc = 1.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '066'
        i_par           = 'RN1_DYNP_MEDSRV_PROP'
        i_field         = 'LAYOUT'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

  LOOP AT lt_avar ASSIGNING <ls_avar>.
    <ls_avar>-type = '*'.
  ENDLOOP.

* Transport the actual layout.
  IF e_rc = 0.
    CALL FUNCTION 'LT_VARIANTS_TRANSPORT'
      IMPORTING
        e_task                      = e_task
      TABLES
        t_variants                  = lt_avar
      EXCEPTIONS
        client_unknown              = 1
        no_transports_allowed       = 2
        variants_table_empty        = 3
        no_transport_order_selected = 4
        OTHERS                      = 5.
    e_rc = sy-subrc.
    IF e_rc <> 0.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
  ENDIF.

  IF e_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N2DWSWL_ADMIN'
        i_num           = '029'
        i_par           = 'RN1_DYNP_MEDSRV_PROP'
        i_field         = 'LAYOUT'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD transport_svar.

  DATA: l_task       TYPE trkorr,
        l_order      TYPE trkorr,
        lt_e071      TYPE tr_objects,
        lt_e071k     TYPE tr_keys,
        ls_t000      TYPE t000,
        l_act_svar   TYPE variant.

* No actual fvar -> message.
  IF i_svariantid IS INITIAL.
    e_rc = 1.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '067'
        i_par           = 'RN1ME_DYNP_DWS_CCON_ME'
        i_field         = 'SVAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Transport the actual svar.
  PERFORM tp_vw_svar IN PROGRAM sapln_wp
                     TABLES lt_e071
                     USING  i_svar_repid
                            i_svariantid
                            l_task.

* function module does not work as assumed - no possibility to choose an existing transport order
* so use other function modules.
  DO 1 TIMES.

*   check client - possibly the transport is not allowed
    SELECT SINGLE * FROM t000 INTO ls_t000.
    IF ls_t000-cccoractiv = 3.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'SV'
          i_num           = '130'
          i_mv1           = sy-mandt
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = 1.
      EXIT.
    ENDIF.

    CALL FUNCTION 'TR_ORDER_CHOICE_CORRECTION'
      EXPORTING
        iv_category            = 'CUST'
        iv_cli_dep             = 'X'
      IMPORTING
        ev_order               = l_order
        ev_task                = l_task
      EXCEPTIONS
        invalid_category       = 1
        no_correction_selected = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0 AND sy-subrc <> 2.
      e_rc = 1.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ELSEIF sy-subrc = 2.
      EXIT.
    ENDIF.
    CHECK l_task IS NOT INITIAL.

    e_task = l_task.

    CALL FUNCTION 'TR_APPEND_TO_COMM_OBJS_KEYS'
      EXPORTING
        wi_suppress_key_check          = 'X'
        wi_trkorr                      = l_task
      TABLES
        wt_e071                        = lt_e071
        wt_e071k                       = lt_e071k
      EXCEPTIONS
        key_char_in_non_char_field     = 1
        key_check_keysyntax_error      = 2
        key_inttab_table               = 3
        key_longer_field_but_no_generc = 4
        key_missing_key_master_fields  = 5
        key_missing_key_tablekey       = 6
        key_non_char_but_no_generic    = 7
        key_no_key_fields              = 8
        key_string_longer_char_key     = 9
        key_table_has_no_fields        = 10
        key_table_not_activ            = 11
        key_unallowed_key_function     = 12
        key_unallowed_key_object       = 13
        key_unallowed_key_objname      = 14
        key_unallowed_key_pgmid        = 15
        key_without_header             = 16
        ob_check_obj_error             = 17
        ob_devclass_no_exist           = 18
        ob_empty_key                   = 19
        ob_generic_objectname          = 20
        ob_ill_delivery_transport      = 21
        ob_ill_lock                    = 22
        ob_ill_parts_transport         = 23
        ob_ill_source_system           = 24
        ob_ill_system_object           = 25
        ob_ill_target                  = 26
        ob_inttab_table                = 27
        ob_local_object                = 28
        ob_locked_by_other             = 29
        ob_modif_only_in_modif_order   = 30
        ob_name_too_long               = 31
        ob_no_append_of_corr_entry     = 32
        ob_no_append_of_c_member       = 33
        ob_no_consolidation_transport  = 34
        ob_no_original                 = 35
        ob_no_shared_repairs           = 36
        ob_no_systemname               = 37
        ob_no_systemtype               = 38
        ob_no_tadir                    = 39
        ob_no_tadir_not_lockable       = 40
        ob_privat_object               = 41
        ob_repair_only_in_repair_order = 42
        ob_reserved_name               = 43
        ob_syntax_error                = 44
        ob_table_has_no_fields         = 45
        ob_table_not_activ             = 46
        tr_enqueue_failed              = 47
        tr_errors_in_error_table       = 48
        tr_ill_korrnum                 = 49
        tr_lockmod_failed              = 50
        tr_lock_enqueue_failed         = 51
        tr_not_owner                   = 52
        tr_no_systemname               = 53
        tr_no_systemtype               = 54
        tr_order_not_exist             = 55
        tr_order_released              = 56
        tr_order_update_error          = 57
        tr_wrong_order_type            = 58
        ob_invalid_target_system       = 59
        tr_no_authorization            = 60
        ob_wrong_tabletyp              = 61
        ob_wrong_category              = 62
        ob_system_error                = 63
        ob_unlocal_objekt_in_local_ord = 64
        tr_wrong_client                = 65
        ob_wrong_client                = 66
        key_wrong_client               = 67
        OTHERS                         = 68.

    IF sy-subrc <> 0.
      e_rc = 1.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.
  ENDDO.

  IF e_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N2DWSWL_ADMIN'
        i_num           = '029'
        i_par           = 'RN1ME_DYNP_DWS_CCON_ME'
        i_field         = 'FVAR'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.
ENDCLASS.
