class CL_ISH_SCR_CONTEXT definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

*"* public components of class CL_ISH_SCR_CONTEXT
*"* do not include other source files here!!!
public section.

  constants CO_DEFAULT_TABNAME type TABNAME value 'N1CORDER'. "#EC NOTEXT
  class-data G_FIELDNAME_CXSTA type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_CXVALD type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_CXRSP type ISH_FIELDNAME read-only .
  data G_LOCK type RN1LOCK_OBJ .
  data GR_CONTEXT_SUBSCREEN type ref to CL_ISHMED_SUBSCR_CTX_USERDEF .
  data G_PGM_CONTEXT type SY-REPID .
  data G_DYNNR_CONTEXT type SY-DYNNR .
  data GT_TABSTRIP type ISH_T_CONTEXT_TABSTRIP .
  constants CO_SUB_CTX_USERDEF1 type SY-UCOMM value 'SUB_CTX_USERDEF01'. "#EC NOTEXT
  constants CO_SUB_CTX_USERDEF type SY-UCOMM value 'SUB_CTX_USERDEF'. "#EC NOTEXT
  constants CO_SUB_CTX_USERDEF2 type SY-UCOMM value 'SUB_CTX_USERDEF02'. "#EC NOTEXT
  constants CO_SUB_CTX_USERDEF3 type SY-UCOMM value 'SUB_CTX_USERDEF03'. "#EC NOTEXT
  constants CO_SUB_CTX_USERDEF4 type SY-UCOMM value 'SUB_CTX_USERDEF04'. "#EC NOTEXT
  constants CO_SUB_CTX_USERDEF5 type SY-UCOMM value 'SUB_CTX_USERDEF05'. "#EC NOTEXT
  data G_TABSTRIP_DYNPRO type RN1_TABSTRIP_DYNPRO .
  constants CO_OTYPE_SCR_CONTEXT type ISH_OBJECT_TYPE value 7077. "#EC NOTEXT

  class-methods CREATE_ICON
    importing
      value(I_ICONNAME) type NCXSICON
      value(I_ICONTEXT) type NCXTYPNM
      value(I_INFOTEXT) type NCXTYPNM
    exporting
      value(E_ICONFIELD) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_TABSTRIP_DYN
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_TABSTRIP) type RN1_DYNP_CONTEXT_TABSTRIP
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DEFAULT_TAB
    importing
      value(I_REGCARD) type CHAR18
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNCTION) type SY-UCOMM
      value(E_SCROLL_POSITION) type SY-UCOMM
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_CTX_USERDEF_SUBSCR
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CR_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING
      value(C_FUNCTION) type SY-UCOMM .
  methods OPTION_FOR_REAL_PATIENT
    importing
      value(IR_CTX_SUBSCR) type ref to CL_ISHMED_SUBSCR_CTX_USERDEF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INIT_TABSTRIP
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INIT_CONTEXT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_TABSTRIP_DATA
    exporting
      value(ET_TABSTRIP) type ISH_T_CONTEXT_TABSTRIP
      value(E_TABSTRIP_DYNPRO) type RN1_TABSTRIP_DYNPRO .
  methods GET_FIRST_ACTIVE_TAB
    exporting
      value(E_FUNCTION) type SY-UCOMM
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DYNPRO_CONTEXT_SUB
    exporting
      value(E_PGM_CONTEXT_SUB) type SY-REPID
      value(E_DYNNR_CONTEXT_SUB) type SY-DYNNR .
  methods GET_CONTEXTS_FOR_CORDTYPS
    importing
      value(I_CXTYP) type NCXTY-CXTYP
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ET_NCXTY) type ISHMED_T_CONTEXTTYP
      value(ET_NOCTY) type ISHMED_T_NOCTY
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_TABSTRIP_ACTIVE_DYN
    importing
      value(I_ID_SUB) type SY-UCOMM
    exporting
      value(E_ACTIVE) type ISH_TRUE_FALSE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods ADD_CTX_FOR_CORDER
    importing
      value(IT_NCXTY) type ISHMED_T_CONTEXTTYP
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CONTEXT_FOR_MAIN_OBJECT
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ET_CONTEXT_TRIGGER) type ISH_OBJECTLIST
      value(ET_CONTEXT) type ISH_OBJECTLIST
      value(ET_CONTEXT_OBJECT_RELATIONS) type ISH_OBJECTLIST
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INIT_CTX_USERDEF_SUBSCR
    importing
      value(IT_TABSTRIP_DYN) type ISH_T_CONTEXT_TABSTRIP
      value(IR_CONTEXT) type ref to CL_ISH_CONTEXT
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_CTX_USERDEF) type ref to CL_ISHMED_SUBSCR_CTX_USERDEF
    changing
      !CR_ERRORHANDLING type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCR_CONTEXT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DYNPRO_CONTEXT
    exporting
      value(E_PGM_CONTEXT) type SY-REPID
      value(E_DYNNR_CONTEXT) type SY-DYNNR .
  methods REFRESH_TABSTRIP
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~GET_FIELDS_DEFINITION
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_FROM_DY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
  methods IF_ISH_SCREEN~IS_FIELD_INITIAL
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_CONTEXT
*"* do not include other source files here!!!

  methods GET_CORDER
    returning
      value(RR_CORDER) type ref to CL_ISH_CORDER .

  methods BUILD_MESSAGE
    redefinition .
  methods CREATE_LISTBOX_INTERNAL
    redefinition .
  methods FILL_ALL_LABELS
    redefinition .
  methods FILL_LABEL_INTERNAL
    redefinition .
  methods FILL_T_SCRM_FIELD
    redefinition .
  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods INITIALIZE_INTERNAL
    redefinition .
  methods INITIALIZE_PARENT
    redefinition .
  methods MODIFY_SCREEN_INTERNAL
    redefinition .
  methods VALUE_REQUEST_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_CONTEXT
*"* do not include other source files here!!!

  data GT_N1CORDTYP type ISHMED_T_N1CORDTYP .
  data GT_NCXTY type ISHMED_T_CONTEXTTYP .

  methods HANDLE_ON_BEFORE_USER_COMMAND
    for event BEFORE_USER_COMMAND of CL_ISHMED_SUBSCR_CTX_USERDEF
    importing
      !E_UCOMM
      !E_SUBSCR_INSTANCE .
ENDCLASS.



CLASS CL_ISH_SCR_CONTEXT IMPLEMENTATION.


METHOD add_ctx_for_corder .

* Lokale Tabellen
  DATA: lt_ncxty                TYPE ishmed_t_contexttyp,
        lt_ncxtyt               TYPE ishmed_t_ncxtyt,
        lt_ctx_trigger          TYPE ish_objectlist.
* Workareas
  DATA: ls_object                LIKE LINE OF lt_ctx_trigger,
        ls_ncxty                 LIKE LINE OF lt_ncxty.
* Hilfsfelder und -strukturen
  DATA: ls_n1corder             TYPE n1corder,
        l_rc                    TYPE ish_method_rc,
        l_objid                 TYPE rn1_objectids,
        ls_nctx                  TYPE nctx,
*        l_mode                  TYPE ish_modus,
        l_key                   TYPE string,
        l_cto_attributes        TYPE rncto_restricted,
        l_objtyid               TYPE nocty-objtyid,
        l_new                   TYPE ish_on_off.
* Objekt-Instanzen
  DATA: lr_context               TYPE REF TO cl_ish_context,
        lr_corder                TYPE REF TO cl_ish_corder.
* ---------- ---------- ----------
* Initialisierungen
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

* ---------- ---------- ----------
* Pro Kontext wird eine Registerkarte angezeigt.
* Pro Zurodnung einen Kontext instanzieren.
  LOOP AT it_ncxty INTO ls_ncxty.
    CLEAR: ls_nctx.
    ls_nctx-mandt  =  ls_ncxty-mandt.
    ls_nctx-cxtyp  =  ls_ncxty-cxtyp.
    ls_nctx-stdef  =  ls_ncxty-stdef.
    CALL METHOD cl_ish_context=>create
      EXPORTING
        i_nctx         = ls_nctx
        i_environment  = gr_environment
      IMPORTING
        e_instance     = lr_context
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    CHECK l_rc = 0.
    IF l_rc = 0.
      CLEAR: l_cto_attributes.
      l_cto_attributes-ctoty    =  '0'.   " Auslöser
      l_cto_attributes-ctoty_x  =  on.
      CALL METHOD lr_context->add_obj_to_context
        EXPORTING
          i_object       = lr_corder
          i_attributes   = l_cto_attributes
        IMPORTING
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
*     Vorbelegung des Kontext durchführen
      CALL METHOD lr_context->preallocation
        IMPORTING
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      CALL METHOD lr_corder->add_connection
        EXPORTING
          i_object = lr_context.
    ENDIF.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDLOOP.
  IF e_rc <> 0.
    EXIT.
  ENDIF.
* ---------- ----------

ENDMETHOD.


method BUILD_MESSAGE.

* Call super method.
  CALL METHOD super->build_message
    EXPORTING
      is_message    = is_message
      i_cursorfield = i_cursorfield
    IMPORTING
      es_message    = es_message.

endmethod.


METHOD check_tabstrip_active_dyn .

  CLEAR: e_rc.
  e_active = false.

* Benutzerdef. Kontext
  IF i_id_sub  =  co_sub_ctx_userdef1  OR
     i_id_sub  =  co_sub_ctx_userdef2  OR
     i_id_sub  =  co_sub_ctx_userdef3  OR
     i_id_sub  =  co_sub_ctx_userdef4  OR
     i_id_sub  =  co_sub_ctx_userdef5.
    e_active = true.
  ENDIF.

ENDMETHOD.


METHOD class_constructor .

* Set fieldnames
  g_fieldname_cxsta  = 'RN1_DYNP_CONTEXT-CXSTA'.
  g_fieldname_cxvald = 'RN1_DYNP_CONTEXT-CXVALD'.
  g_fieldname_cxrsp  = 'RN1_DYNP_CONTEXT-CXRSP'.

ENDMETHOD.


METHOD CONSTRUCTOR .

* Construct super class(es).
  CALL METHOD super->constructor.

* Set gr_default_tabname.
  GET REFERENCE OF co_default_tabname INTO gr_default_tabname.

ENDMETHOD.


METHOD CREATE .

* create instance for errorhandling if necessary
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* create instance
  CREATE OBJECT er_instance
    EXCEPTIONS
      instance_not_possible = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
    e_rc = 1.
*   the instance couldn't be created
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '003'
        i_mv1           = 'CL_ISH_SCR_CONTEXT'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD create_icon .

  CLEAR: e_rc.

  DATA: l_infotext     TYPE icont-quickinfo.

  l_infotext   = i_infotext.
  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = i_iconname
      text   = i_icontext
      info   = l_infotext
    IMPORTING
      RESULT = e_iconfield.

ENDMETHOD.


METHOD CREATE_LISTBOX_INTERNAL .

** Initializations
*  CLEAR: e_rc.
*
*  CASE i_fieldname.
*    WHEN g_fieldname_wltyp.
*      CALL METHOD create_listbox_wltyp
*        IMPORTING
*          er_lb_object    = er_lb_object
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*    WHEN g_fieldname_wlpri.
*      CALL METHOD create_listbox_wlpri
*        IMPORTING
*          er_lb_object    = er_lb_object
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*    WHEN g_fieldname_wuzpi.
*      CALL METHOD create_listbox_wuzpi
*        IMPORTING
*          er_lb_object    = er_lb_object
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*    WHEN g_fieldname_wujhr.
*      CALL METHOD create_listbox_wujhr
*        IMPORTING
*          er_lb_object    = er_lb_object
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*    WHEN g_fieldname_wumnt.
*      CALL METHOD create_listbox_wumnt
*        IMPORTING
*          er_lb_object    = er_lb_object
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*    WHEN g_fieldname_wlrrn.
*      CALL METHOD create_listbox_wlrrn
*        IMPORTING
*          er_lb_object    = er_lb_object
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*
*  ENDCASE.

ENDMETHOD.


METHOD FILL_ALL_LABELS .

** Initializations
*  CLEAR: e_rc.
*
** WLRRN_TXT
*  CALL METHOD me->fill_label
*    EXPORTING
*      i_fieldname     = g_fieldname_wlhsp_txt
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.

ENDMETHOD.


METHOD FILL_LABEL_INTERNAL .

** Initializations
*  CLEAR: e_rc.
*
*  CASE i_fieldname.
** KHANS
*    WHEN g_fieldname_wlhsp_txt.
*      CALL METHOD fill_label_wlhsp_txt
*        IMPORTING
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      CHECK e_rc = 0.
*  ENDCASE.

ENDMETHOD.


METHOD fill_t_scrm_field .

  DATA: ls_scrm_field  TYPE rn1_scrm_field.

  REFRESH gt_scrm_field.

* cxsta
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_cxsta.
  ls_scrm_field-fieldlabel = 'Status'(001).
  APPEND ls_scrm_field TO gt_scrm_field.

* cxvald
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_cxvald.
  ls_scrm_field-fieldlabel = 'Gültig bis'(002).
  APPEND ls_scrm_field TO gt_scrm_field.

* cxrsp
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_cxrsp.
  ls_scrm_field-fieldlabel = 'Verantwortlich'(003).
  APPEND ls_scrm_field TO gt_scrm_field.

ENDMETHOD.


METHOD get_contexts_for_cordtyps .

  DATA: lr_corder TYPE REF TO cl_ish_corder,
        ls_n1cordtyp TYPE n1cordtyp,
        lt_cordtyp TYPE ish_t_cordtyp,
        lr_cordtyp TYPE REF TO cl_ish_cordtyp,
        l_objtyid TYPE nocty-objtyid,
        lt_ncxty              TYPE ishmed_t_contexttyp,
        lt_nocty              TYPE ishmed_t_nocty,
        l_rc TYPE ish_method_rc.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

* first get all cordtyps from corder
  CALL METHOD lr_corder->get_t_cordtyp
    EXPORTING
*    I_CANCELLED_DATAS = OFF
      ir_environment    = gr_environment
    IMPORTING
      et_cordtyp        = lt_cordtyp
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

  LOOP AT lt_cordtyp INTO lr_cordtyp.
    CALL METHOD lr_cordtyp->get_data
      IMPORTING
        es_n1cordtyp = ls_n1cordtyp.
    CHECK NOT ls_n1cordtyp IS INITIAL.
    l_objtyid = ls_n1cordtyp-cordtypid.
*   Geforderte Reihenfolge aus dem Stammdaten ermitteln.
    CALL METHOD cl_ish_master_dp=>read_context_for_object
      EXPORTING
        i_objty         = '012' "cordtyp
        i_objtyid       = l_objtyid
        i_cxtyp         = i_cxtyp
        i_assgn         = '05' "contexts of a corder
        i_buffer_active = on
        i_read_db       = off
      IMPORTING
        e_rc            = l_rc
        et_ncxty        = lt_ncxty
        et_nocty        = lt_nocty
      CHANGING
        c_errorhandler  = cr_errorhandler.
    CHECK l_rc = 0.
    IF NOT lt_ncxty[] IS INITIAL.
      APPEND LINES OF lt_ncxty TO et_ncxty.
    ENDIF.
    IF NOT lt_nocty[] IS INITIAL.
      APPEND LINES OF lt_nocty TO et_nocty.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD get_context_for_main_object .

  DATA: lr_corder TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

  CALL METHOD cl_ish_corder=>get_context_for_corder
    EXPORTING
      ir_corder                   = lr_corder
      ir_environment              = gr_environment
*    I_CANCELLED_DATAS           =
    IMPORTING
    ET_CONTEXT                    = et_context
    ET_CONTEXT_OBJECT_RELATIONS   = et_context_object_relations
      et_context_trigger          = et_context_trigger
      e_rc                        = e_rc
    CHANGING
      cr_errorhandler             = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD GET_CORDER .

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.

  rr_corder ?= gr_main_object.

ENDMETHOD.


METHOD get_dynpro_context .

  IF g_tabstrip_dynpro-dynpro IS INITIAL AND
     g_tabstrip_dynpro-program IS INITIAL.
    e_pgm_context = g_pgm_context.
    e_dynnr_context = g_dynnr_context.
  ELSE.
    e_pgm_context = g_tabstrip_dynpro-program.
    e_dynnr_context = g_tabstrip_dynpro-dynpro.
  ENDIF.

ENDMETHOD.


method GET_DYNPRO_CONTEXT_SUB .
endmethod.


METHOD get_first_active_tab .

  CLEAR: e_rc.

  DATA: l_pos TYPE i.

* Workareas
  DATA: l_tabstrip_dyn         LIKE LINE OF gt_tabstrip,
        l_rc                   TYPE ish_method_rc.
* Hilfsfelder und -strukturen
  DATA:  l_active              TYPE ish_true_false.

* Registerkarte mit der höchsten Priorität default-mäßig
* aufschlagen.
  SORT gt_tabstrip BY sort.
  LOOP AT gt_tabstrip INTO l_tabstrip_dyn.
    CALL METHOD me->check_tabstrip_active_dyn
      EXPORTING
        i_id_sub        = l_tabstrip_dyn-id_sub
      IMPORTING
        e_active        = l_active
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK l_rc = 0.
    IF l_active = true.
      e_function = l_tabstrip_dyn-id_sub.
      EXIT.
    ENDIF.
  ENDLOOP.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD get_tabstrip_data .

  CLEAR: et_tabstrip[], e_tabstrip_dynpro.

  et_tabstrip[] = gt_tabstrip.
  e_tabstrip_dynpro = g_tabstrip_dynpro.

ENDMETHOD.


METHOD handle_on_before_user_command .

*       Vor dem Ausführen div. Funktionen eines benutzerdef. Kontextes
*       muss die Vormerkung gespeichert werden.
*       Falls bei diesem Vorgang Warnungen auftreten muss es möglich
*       sein - nach dem Bestätigen der Warnung - mit der Verarbeitung
*       fortzufahren. Falls man sich noch in der Bearbeitung eines
*       "Ereignisbehandlers" befinden ist es nicht nötig die Funktion
*       selbst nochmals aufzurufen (vgl. Parameter p_call_function).

* Hilfsfelder und -strukturen
  DATA: l_flag             TYPE ish_on_off,
        l_rc               TYPE ish_method_rc,
        ls_n1corder        TYPE n1corder,
        l_patnr            TYPE npat-patnr,
        l_patnr_x          TYPE ish_on_off,
        l_pap_x            TYPE ish_on_off,
        l_abort            TYPE ish_on_off,
        l_npat_necessary   TYPE ish_on_off.
* Objekt-Instanzen
  DATA: lr_pap             TYPE REF TO cl_ish_patient_provisional,
        lr_ctx_userdef     TYPE REF TO cl_ishmed_ctx_userdef,
        lr_corder          TYPE REF TO cl_ish_corder,
        lr_errorhandler    TYPE REF TO cl_ishmed_errorhandling,
        lr_patient_sub     TYPE REF TO cl_ishmed_patient_provisional.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

* ---------- ---------- ----------
* Bevor ein neues Objekt in den Kontext eingebunden wird, bzw.
* bevor ein Planungsvorgang erfolgen darf (kann) muss die Vormerkung
* gespeichert werden.
  CHECK e_ucomm = cl_ishmed_ctx_dialog=>co_fc_request_create OR
        e_ucomm = cl_ishmed_ctx_dialog=>co_fc_scheduling OR
        e_ucomm = 'ORGID'. "ED, ID 19338
* ---------- ---------- ----------
* Initialisierung
  CLEAR: l_abort.
* ---------- ---------- ----------
  CHECK NOT e_subscr_instance IS INITIAL.
  CALL METHOD e_subscr_instance->get_data
    IMPORTING
      e_ctx_userdef = lr_ctx_userdef.
  CALL METHOD lr_ctx_userdef->abort_function
    EXPORTING
      i_ucomm = space.
* ---------- ---------- ----------
* Um eine Anforderung anzulegen ist ein realer Patient Voraussetzung.
* => Glob. Attribut setzen, wird im Unterprogramm save berücksichtigt.
  IF e_ucomm = cl_ishmed_ctx_dialog=>co_fc_request_create.
    l_npat_necessary  =  on.
  ENDIF.

* first clear the user command
  CALL METHOD me->clear_ev_user_commend_result.

* raise event that the process has to save before calling function
  RAISE EVENT ev_user_command
    EXPORTING
      ir_screen = me
      i_ucomm   = if_ish_screen~co_ucomm_scr_save.

  l_npat_necessary  =  off.

* if error -> display
  IF g_ev_ucomm_result_rc <> 0.
    CALL METHOD gr_ev_ucomm_result_error->display_messages
      EXPORTING
        i_amodal               = on
        i_refresh_amodal_popup = on.
    l_abort = on.
  ENDIF.

* ---------- ----------
* check if the function can be started
  IF g_ev_ucomm_result_done = on AND
     g_ev_ucomm_result_supported = on AND
     g_ev_ucomm_result_rc = 0.
    l_abort = off.

* Display information that clinical order was saved.
  MESSAGE s137(n1cordmg). "Grill, ID-19881

*   Wurden die Änderungen gespeichert muss der neue Patient an den
*   Subscreen übergeben werden.
    CALL METHOD lr_corder->get_data
      IMPORTING
        es_n1corder     = ls_n1corder
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
    CHECK l_rc = 0.
*   ----------
    IF l_npat_necessary = on AND ls_n1corder-patnr IS INITIAL.
      l_abort = on.
    ELSE.
      l_abort = off.
    ENDIF.
  ELSE.
*   Die Änderungen wurden nicht gespeichert, die eigentliche Funktion
*   darf nicht ausgeführt werden.
    l_abort  =  on.
  ENDIF.
* ---------- ---------- ----------
  IF l_abort = on.
*   Die eigentliche Funktion darf nicht ausgeführt werden.
    IF NOT e_subscr_instance IS INITIAL.
      CALL METHOD lr_ctx_userdef->abort_function
        EXPORTING
          i_ucomm = e_ucomm.
    ENDIF.
  ELSE.
* don't call function!!
*    IF p_call_function = on.
*      CALL METHOD l_ctx_userdef->handle_on_user_command
*        EXPORTING
*          e_ucomm = g_saved_message-okcode2.
*    ENDIF.
  ENDIF.
* ---------- ---------- ----------


ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~GET_TYPE .

  e_object_type = co_otype_scr_context."ID-16230

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_context.
    r_is_inherited_from = on.
  ELSE.
*-- ID-16230
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
*--  r_is_inherited_from = off. ID-16230
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~destroy .

  CLEAR: e_rc.

  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* destroy also the instances of the container of the context
  CALL FUNCTION 'ISHMED_DESTROY_SUBSCR_CONTEXT'.

ENDMETHOD.


METHOD if_ish_screen~get_fields_definition .

  DATA: ls_parent  TYPE rnscr_parent.

* Use the old subscreen's dynpro.
  ls_parent = gs_parent.
  gs_parent-repid = g_pgm_context.
  gs_parent-dynnr = g_dynnr_context.

* Call super method.
  CALL METHOD super->if_ish_screen~get_fields_definition
    IMPORTING
      et_fields_definition = et_fields_definition
      e_rc                 = e_rc
    CHANGING
      c_errorhandler       = c_errorhandler.

* Reset gs_parent.
  gs_parent = ls_parent.

ENDMETHOD.


METHOD if_ish_screen~is_field_initial.

  DATA: l_rc       TYPE ish_method_rc,
        lt_context TYPE ish_objectlist,
        ls_object  LIKE LINE OF lt_context,
        ls_nctx    TYPE nctx,
        lr_context TYPE REF TO cl_ish_context.

* initialize
  r_initial = off.
  CLEAR: l_rc, lt_context[], ls_object, ls_nctx, lr_context.

* call super method if field not CXSTA and not CXRSP
  IF i_fieldname <> g_fieldname_cxsta AND i_fieldname <> g_fieldname_cxrsp.
    CALL METHOD super->if_ish_screen~is_field_initial
      EXPORTING
        i_fieldname = i_fieldname
        i_rownumber = i_rownumber
      RECEIVING
        r_initial   = r_initial.
    EXIT.
  ENDIF.

* get contexts
  CALL METHOD me->get_context_for_main_object
    IMPORTING
      e_rc                        = l_rc
*    ET_CONTEXT_TRIGGER          =
    et_context                  = lt_context.
*    ET_CONTEXT_OBJECT_RELATIONS =
*  CHANGING
*    CR_ERRORHANDLER             =
  LOOP AT lt_context INTO ls_object
    WHERE NOT object IS INITIAL.
    CLEAR: lr_context, ls_nctx.
*   ---------- ----------
*   get data from context
    lr_context ?= ls_object-object.
    CALL METHOD lr_context->get_data
*    EXPORTING
*      I_FILL_CONTEXT = OFF
      IMPORTING
*      E_ENVIRONMENT  =
        e_rc           = l_rc
        e_nctx         = ls_nctx.
*    CHANGING
*      C_ERRORHANDLER =
    IF l_rc <> 0.
      EXIT.
    ENDIF.
    IF ls_nctx-stdef = on.
      IF i_fieldname = g_fieldname_cxsta AND ls_nctx-cxsta IS INITIAL.
        r_initial = on.
      ELSEIF i_fieldname = g_fieldname_cxrsp AND ls_nctx-cxrsp IS INITIAL.
        r_initial = on.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen .

  DATA: l_tabstrip_dyn TYPE rn1_dynp_context_tabstrip,
        l_okcode       TYPE sy-ucomm,
        lr_corder      TYPE REF TO cl_ish_corder, "ED, ID 18096
        ls_n1corder    TYPE n1corder. "ED, ID 18096

* ED, ID 18096: get main object -> BEGIN
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.
  CHECK lr_corder IS BOUND.
* ED, ID 18096 -> END

  CLEAR e_rc.

  l_okcode = c_okcode.

*  CALL METHOD gr_context_subscreen->ok_code_subscreen
*    IMPORTING
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = c_errorhandler
*      c_okcode       = c_okcode.

  CASE l_okcode.
    WHEN 'CONTEXT'.
      CLEAR c_okcode.
*      IF NOT g_saved_message-object IS INITIAL.
*        l_subscr_ctx_userdef ?= g_saved_message-object.
*        PERFORM before_ctx_function
*          USING g_saved_message-okcode2
*                g_saved_message-okcode2_txt
*                l_subscr_ctx_userdef
*                'X'.              " -> call function
*        PERFORM after_ctx_function
*           USING g_saved_message-okcode2
*                 l_subscr_ctx_userdef.
*      ENDIF.
    WHEN   OTHERS.
      IF l_okcode(3) = 'SUB'.
        CLEAR c_okcode.
        READ TABLE gt_tabstrip INTO l_tabstrip_dyn
           WITH KEY function = l_okcode.
        IF sy-subrc = 0.
          g_tabstrip_dynpro-function = l_tabstrip_dyn-id_sub.
        ENDIF.
      ENDIF.

  ENDCASE.

  CALL METHOD cl_gui_cfw=>dispatch.

* ED, ID 18096: if function (appointment, request) was cancelled and
* clinical order itself was cancelled too, exit the dialog!! -> BEGIN
  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  IF ls_n1corder-storn = on.
    c_okcode = cl_ish_prc_corder=>co_okcode_exit_from_context.
    MESSAGE s143(n1cordmg) WITH ls_n1corder-prgnr ls_n1corder-patnr.
    EXIT.
  ENDIF.
* ED, ID 18096 -> END

ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .

* call the fub for component context
  CALL FUNCTION 'ISH_SDY_CONTEXT_INIT'
    EXPORTING
      ir_scr_context  = me
    IMPORTING
      es_parent       = gs_parent
      e_rc            = e_rc
    CHANGING
      cr_dynp_data    = gr_scr_data
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD IF_ISH_SCREEN~TRANSPORT_FROM_DY .

* Transport is done by old subscreen.

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy .

** Lokale Tabellen
*  DATA: lt_ncxty                TYPE ishmed_t_contexttyp,
*        lt_ncxtyt               TYPE ishmed_t_ncxtyt,
*        lt_ctx_trigger          TYPE ish_objectlist.
** Workareas
*  DATA: l_object                LIKE LINE OF lt_ctx_trigger,
*        l_ncxty                 LIKE LINE OF lt_ncxty.
** Hilfsfelder und -strukturen
*  DATA: ls_n1corder             TYPE n1corder,
*        l_rc                    TYPE ish_method_rc,
*        l_objid                 TYPE rn1_objectids,
*        l_nctx                  TYPE nctx,
**        l_mode                  TYPE ish_modus,
*        l_key                   TYPE string,
*        l_cto_attributes        TYPE rncto_restricted,
*        l_objtyid               TYPE nocty-objtyid,
*        l_new                   TYPE ish_on_off.
** Objekt-Instanzen
*  DATA: lr_context              TYPE REF TO cl_ish_context,
*        lr_corder               TYPE REF TO cl_ish_corder.
** ---------- ---------- ----------
** Initialisierungen
*  e_rc = 0.
*  IF cr_errorhandler IS INITIAL.
*    CREATE OBJECT cr_errorhandler.
*  ENDIF.
** ---------- ---------- ----------
** only connect if the corder is new
** ---------- ----------
*  lr_corder = get_corder( ).
*  CALL METHOD lr_corder->is_new
*    IMPORTING
*      e_new = l_new.
*  CHECK l_new = on.
** ---------- ---------- ----------
** get data from corder
*  CALL METHOD lr_corder->get_data
*    EXPORTING
*      i_fill          = off
*    IMPORTING
*      es_n1corder     = ls_n1corder
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
** ---------- ---------- ----------
** Bei Änderung des Vormerkungstyp müssen die Kontexttypen neu ermittelt
** werden.
** ---------- ----------
*  CLEAR: lt_ncxty.
*  IF NOT ls_n1corder-corderid IS INITIAL.
*    l_objtyid = ls_n1corder-corderid.
** ----------
*    CALL METHOD cl_ish_master_dp=>read_context_for_object
*      EXPORTING
*        i_objty         = '013' "clinical order
*        i_objtyid       = l_objtyid
*        i_assgn         = '05' "context clinical order
*        i_buffer_active = space
*        i_read_db       = space
*      IMPORTING
*        e_rc            = e_rc
*        et_ncxty        = lt_ncxty
*      CHANGING
*        c_errorhandler  = cr_errorhandler.
*    CHECK e_rc = 0.
*  ENDIF.
** ---------- ---------- ----------
** Pro Kontext wird eine Registerkarte angezeigt.
** Pro Zurodnung einen Kontext instanzieren.
*  LOOP AT lt_ncxty INTO l_ncxty.
*    CLEAR: l_nctx.
*    l_nctx-mandt  =  l_ncxty-mandt.
*    l_nctx-cxtyp  =  l_ncxty-cxtyp.
*    l_nctx-stdef  =  l_ncxty-stdef.
*    CALL METHOD cl_ish_context=>create
*      EXPORTING
*        i_nctx         = l_nctx
*        i_environment  = gr_environment
*      IMPORTING
*        e_instance     = lr_context
*        e_rc           = l_rc
*      CHANGING
*        c_errorhandler = cr_errorhandler.
*    IF l_rc = 0.
*      CLEAR: l_cto_attributes.
*      l_cto_attributes-ctoty    =  '0'.   " Auslöser
*      l_cto_attributes-ctoty_x  =  on.
*      CALL METHOD lr_context->add_obj_to_context
*        EXPORTING
*          i_object       = lr_corder
*          i_attributes   = l_cto_attributes
*        IMPORTING
*          e_rc           = l_rc
*        CHANGING
*          c_errorhandler = cr_errorhandler.
*      IF l_rc <> 0.
*        e_rc = l_rc.
*        EXIT.
*      ENDIF.
**     Vorbelegung des Kontext durchführen
*      CALL METHOD lr_context->preallocation
*        IMPORTING
*          e_rc           = l_rc
*        CHANGING
*          c_errorhandler = cr_errorhandler.
*    ENDIF.
*    CHECK e_rc = 0.
*  ENDLOOP.
** ---------- ----------


ENDMETHOD.


METHOD INITIALIZE_FIELD_VALUES .

  DATA: lt_field_val            TYPE ish_t_field_value,
        ls_field_val            TYPE rnfield_value.

* Initializations.
  e_rc = 0.

** initialize every screen field
*  CLEAR: lt_field_val,
*         ls_field_val.
*  ls_field_val-fieldname = g_fieldname_wltyp.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = g_fieldname_wladt.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = g_fieldname_wuzpi.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = g_fieldname_wujhr.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = g_fieldname_wumnt.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = g_fieldname_aufds.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = g_fieldname_wlrrn.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = g_fieldname_wlrdt.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = g_fieldname_wlhsp.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = g_fieldname_wlpri.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = g_fieldname_wlhsp_txt.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*
** set values
*  CALL METHOD gr_screen_values->set_data
*    EXPORTING
*      it_field_values = lt_field_val
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      c_errorhandler  = cr_errorhandler.

ENDMETHOD.


METHOD initialize_internal .

  DATA: l_einri       TYPE tn01-einri.

** Michael Manoch, 13.07.2004, ID 14907   START
*  DATA: lr_corder      TYPE REF TO cl_ish_corder,
*        l_new          TYPE ish_on_off,
*        lt_cordpos     TYPE ish_t_cordpos,
*        lr_cordpos     TYPE REF TO cl_ishmed_prereg,
*        lr_cordtyp     TYPE REF TO cl_ish_cordtyp,
*        ls_n1cordtyp   TYPE n1cordtyp,
*        l_rc           TYPE ish_method_rc.
** Michael Manoch, 13.07.2004, ID 14907   END

* initialize
  e_rc = 0.
  CLEAR: g_tabstrip_dynpro-dynpro,
         g_tabstrip_dynpro-program,
         gt_ncxty[],
         gt_n1cordtyp[].
* set subscreen
  g_pgm_context   = 'SAPLNCORD'.
  g_dynnr_context = '0500'.
  IF g_first_time = on.
    g_tabstrip_dynpro-function = co_sub_ctx_userdef1.
  ENDIF.

** Michael Manoch, 13.07.2004, ID 14907   START
** Initialize gt_n1cordtyp with all cordtyps of all
** saved cordpos.
*
*  DO 1 TIMES.
*
*    CLEAR gt_n1cordtyp.
*
**   Get the corder object.
*    CHECK NOT gr_main_object IS INITIAL.
*    CHECK gr_main_object->is_inherited_from(
*          cl_ish_corder=>co_otype_corder ) = 'X'.
*    lr_corder ?= gr_main_object.
*
**   On new corder -> ready.
*    CALL METHOD lr_corder->is_new
*      IMPORTING
*        e_new = l_new.
*    CHECK l_new = on.
*    CLEAR gt_n1cordtyp.
*
**   Get all cordpos which are already saved.
*    CALL METHOD lr_corder->get_t_cordpos
*      IMPORTING
*        et_cordpos      = lt_cordpos
*        e_rc            = l_rc
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    IF l_rc <> 0.
*      e_rc = l_rc.
*      EXIT.
*    ENDIF.
*    CHECK NOT lt_cordpos IS INITIAL.
*    LOOP AT lt_cordpos INTO lr_cordpos.
*      IF lr_cordpos IS INITIAL.
*        DELETE lt_cordpos.
*        CONTINUE.
*      ENDIF.
*      CALL METHOD lr_cordpos->is_new
*        IMPORTING
*          e_new = l_new.
*      IF l_new = on.
*        DELETE lt_cordpos.
*        CONTINUE.
*      ENDIF.
*    ENDLOOP.
*    CHECK NOT lt_cordpos IS INITIAL.
*
**   For each cordpos add its cordtyp to gt_n1cordtyp.
*    LOOP AT lt_cordpos INTO lr_cordpos.
*      lr_cordtyp = lr_cordpos->get_cordtyp( ).
*      CHECK NOT lr_cordtyp IS INITIAL.
*      CALL METHOD lr_cordtyp->get_data
*        IMPORTING
*          es_n1cordtyp = ls_n1cordtyp.
*      READ TABLE gt_n1cordtyp
*        WITH KEY cordtypid = ls_n1cordtyp-cordtypid
*        TRANSPORTING NO FIELDS.
*      CHECK NOT sy-subrc = 0.
*      APPEND ls_n1cordtyp TO gt_n1cordtyp.
*    ENDLOOP.
*
*  ENDDO.
*
** Michael Manoch, 13.07.2004, ID 14907   END

ENDMETHOD.


METHOD INITIALIZE_PARENT .

  CLEAR: gs_parent.

  gs_parent-repid = 'SAPLN1_SDY_CONTEXT'.
  gs_parent-dynnr = '0100'.
  gs_parent-type = co_scr_parent_type_dynpro.

ENDMETHOD.


METHOD init_context .

* Lokale Tabellen
  DATA: lt_ncxty                TYPE ishmed_t_contexttyp,
        lt_ncxtyt               TYPE ishmed_t_ncxtyt,
        lt_ctx_trigger          TYPE ish_objectlist.
* Workareas
  DATA: ls_object                LIKE LINE OF lt_ctx_trigger,
        ls_ncxty                 LIKE LINE OF lt_ncxty.
* Hilfsfelder und -strukturen
  DATA: ls_n1vkg                 TYPE n1vkg,
        l_rc                    TYPE ish_method_rc,
        l_objid                 TYPE rn1_objectids,
        ls_nctx                  TYPE nctx,
*        l_mode                  TYPE ish_modus,
        l_key                   TYPE string,
        l_cto_attributes        TYPE rncto_restricted,
        l_objtyid               TYPE nocty-objtyid,
        l_new                   TYPE ish_on_off,
        lt_cordtyp              TYPE ish_t_cordtyp,
        ls_n1cordtyp            TYPE n1cordtyp,
        ls_n1corder             TYPE n1corder,
        ls_n1cordtyp_g          TYPE n1cordtyp,
        ls_ncxty_g              TYPE ncxty.
* Objekt-Instanzen
  DATA: lr_context              TYPE REF TO cl_ish_context,
        lr_cordtyp              TYPE REF TO cl_ish_cordtyp,
        lr_corder               TYPE REF TO cl_ish_corder,
        l_found                 TYPE ish_on_off. "ED, ID 17836

* Käfer, ID: 17836 - Begin
  DATA: lt_context_trigger TYPE ish_objectlist,
        lr_context_tmp TYPE REF TO cl_ish_context,
        lr_identify_object TYPE REF TO if_ish_identify_object,
        ls_nctx_tmp TYPE nctx,
        ls_ncxty_tmp TYPE ncxty,
        lt_ncxty_all TYPE TABLE OF ncxty.
* Käfer, ID: 17836 - End

  DATA: l_cancelled TYPE ish_on_off.                        "ID 19269

*-- begin Grill, med-29336
  DATA: lr_compdef    TYPE REF TO cl_ish_compdef,
        l_has_compdef TYPE ish_on_off.
*-- end Grill, med-29336

* ---------- ---------- ----------
* Initialisierungen
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Kontexte nur mit KLAU (=Auslöser) verbinden wenn dieser neu
* angelegt wird.
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

* ED, ID 17836: comment!!
*** Michael Manoch, 13.07.2004, ID 14907   START
*** Do not check if lr_corder is new.
*** Instead only use those cordtyps which are new and
*** have not been already processed.
*  CALL METHOD lr_corder->is_new
*    IMPORTING
*      e_new = l_new.
*  CHECK l_new = on.
*** Michael Manoch, 13.07.2004, ID 14907   END
* ---------- ---------- ----------

* Käfer, ID: 17836 - Begin
* first ascertain the context-objects allready connected to the
* clinical order
  CALL METHOD cl_ish_corder=>get_context_for_corder
    EXPORTING
      ir_corder          = lr_corder
      ir_environment     = gr_environment
    IMPORTING
      et_context_trigger = lt_context_trigger
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  CHECK e_rc = 0.
* Begin Siegl, ID 19269
  CALL METHOD lr_corder->if_ish_data_object~is_cancelled
    IMPORTING
      e_cancelled = l_cancelled.
  CHECK l_cancelled = off.
* End Siegl, ID 19269
* put the types of the found context into a local table,
* in further processing this table will help us avoiding creation of
* double context entries
  LOOP AT lt_context_trigger INTO ls_object.
    CHECK NOT ls_object-object IS INITIAL.
    lr_identify_object ?= ls_object-object.
    IF lr_identify_object->is_inherited_from(
      cl_ish_context=>co_otype_context ) = on.
      lr_context_tmp ?= lr_identify_object.
      CLEAR ls_nctx_tmp.
      CALL METHOD lr_context_tmp->get_data
        IMPORTING
          e_rc           = l_rc
          e_nctx         = ls_nctx_tmp
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        CONTINUE.
      ENDIF.
      CLEAR ls_ncxty_tmp.
      READ TABLE gt_ncxty TRANSPORTING NO FIELDS
        WITH KEY cxtyp = ls_nctx_tmp-cxtyp.
      CHECK sy-subrc <> 0.
      ls_ncxty_tmp-cxtyp = ls_nctx_tmp-cxtyp.
      APPEND ls_ncxty_tmp TO lt_ncxty_all.
    ENDIF.
  ENDLOOP.
* get all cordtypes
  CALL METHOD lr_corder->get_t_cordtyp
    EXPORTING
      ir_environment  = gr_environment
    IMPORTING
      et_cordtyp      = lt_cordtyp
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* get all context-types which are defined in the different
* order types
  LOOP AT lt_cordtyp INTO lr_cordtyp.
    CALL METHOD lr_cordtyp->get_data
      IMPORTING
        es_n1cordtyp = ls_n1cordtyp.
    CLEAR: lt_ncxty[].
    IF NOT ls_n1cordtyp-cordtypid IS INITIAL.
      l_objtyid = ls_n1cordtyp-cordtypid.
*-- begin Grill, med-29336
*-- get compdef
      CALL METHOD cl_ish_compdef=>get_compdef
        EXPORTING
          i_obtyp    = cl_ish_cordtyp=>co_obtyp
          i_classid  = 'CL_ISH_COMP_CONTEXT'
        IMPORTING
          er_compdef = lr_compdef.
*-- has ass compdef?
      IF lr_compdef IS BOUND.
        CALL METHOD lr_cordtyp->has_ass_compdef
          EXPORTING
            ir_compdef        = lr_compdef
          RECEIVING
            r_has_ass_compdef = l_has_compdef.
        CHECK l_has_compdef EQ on.
      ENDIF.
*-- end Grill, med-29336
* ----------
      CALL METHOD cl_ish_master_dp=>read_context_for_object
        EXPORTING
          i_objty         = '012' "cordtyp
          i_objtyid       = l_objtyid
          i_assgn         = '05' "contexts for clinical order
          i_buffer_active = space
          i_read_db       = space
        IMPORTING
          e_rc            = l_rc
          et_ncxty        = lt_ncxty
        CHANGING
          c_errorhandler  = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.
*   delete the contexttypes, for which a context allready exists
    LOOP AT lt_ncxty INTO ls_ncxty.
      READ TABLE lt_ncxty_all WITH KEY cxtyp = ls_ncxty-cxtyp
                   INTO ls_ncxty_g.
      IF sy-subrc <> 0.
        APPEND ls_ncxty TO lt_ncxty_all.
      ELSE.
        DELETE lt_ncxty.
      ENDIF.
    ENDLOOP.
*   now create for each remaining context type a contextobject
    IF NOT lt_ncxty[] IS INITIAL.
*     ---------- ---------- ----------
*     Pro Kontext wird eine Registerkarte angezeigt.
*     Pro Zurodnung einen Kontext instanzieren.
      CALL METHOD add_ctx_for_corder
        EXPORTING
          it_ncxty        = lt_ncxty
        IMPORTING
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
*     ---------- ---------- ----------
    ENDIF.

  ENDLOOP.
** Daten des KLAU ermitteln.
*  CALL METHOD lr_corder->get_data
*    EXPORTING
*      i_fill          = off
*    IMPORTING
*      es_n1corder     = ls_n1corder
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
** get all cordtypes
*  CALL METHOD lr_corder->get_t_cordtyp
*    EXPORTING
**    I_CANCELLED_DATAS = OFF
*      ir_environment    = gr_environment
*    IMPORTING
*      et_cordtyp        = lt_cordtyp
*      e_rc              = e_rc
*    CHANGING
*      cr_errorhandler   = cr_errorhandler.
*  CHECK e_rc = 0.
*
** ED, ID 17836: change loop -> BEGIN
*  LOOP AT gt_n1cordtyp INTO ls_n1cordtyp_g.
*    l_found = off.
*    LOOP AT lt_cordtyp INTO lr_cordtyp.
*      CALL METHOD lr_cordtyp->get_data
*        IMPORTING
*          es_n1cordtyp = ls_n1cordtyp.
*      IF ls_n1cordtyp-cordtypid = ls_n1cordtyp_g-cordtypid.
*        l_found = on.
*        EXIT.
*      ENDIF.
*    ENDLOOP.
*    IF l_found = off.
*      DELETE gt_n1cordtyp.
*    ENDIF.
*  ENDLOOP.
*  CLEAR: ls_n1cordtyp_g, ls_n1cordtyp.
** ED, ID 17836 -> END
*
*  LOOP AT lt_cordtyp INTO lr_cordtyp.
*    CALL METHOD lr_cordtyp->get_data
*      IMPORTING
*        es_n1cordtyp = ls_n1cordtyp.
*    READ TABLE gt_n1cordtyp WITH KEY
*       cordtypid = ls_n1cordtyp-cordtypid INTO ls_n1cordtyp_g.
*    IF sy-subrc <> 0. "new cordtyp -> new context
*      APPEND ls_n1cordtyp TO gt_n1cordtyp.
*    ELSE.
*      CONTINUE.
*    ENDIF.
** ---------- ---------- ----------
** Bei Änderung des Auftragstyp müssen die Kontexttypen neu ermittelt
** werden.
** ---------- ----------
**    CLEAR: lt_ncxty.
*    CLEAR: lt_ncxty[]. "ED, ID 17836
*    IF NOT ls_n1cordtyp-cordtypid IS INITIAL.
*      l_objtyid = ls_n1cordtyp-cordtypid.
** ----------
*      CALL METHOD cl_ish_master_dp=>read_context_for_object
*        EXPORTING
*          i_objty         = '012' "cordtyp
*          i_objtyid       = l_objtyid
*          i_assgn         = '05' "contexts for clinical order
*          i_buffer_active = space
*          i_read_db       = space
*        IMPORTING
*          e_rc            = l_rc
*          et_ncxty        = lt_ncxty
*        CHANGING
*          c_errorhandler  = cr_errorhandler.
*      IF l_rc <> 0.
*        e_rc = l_rc.
*        EXIT.
*      ENDIF.
*    ENDIF.
*    LOOP AT lt_ncxty INTO ls_ncxty.
*      READ TABLE gt_ncxty WITH KEY cxtyp = ls_ncxty-cxtyp
*                   INTO ls_ncxty_g.
*      IF sy-subrc <> 0.
*        APPEND ls_ncxty TO gt_ncxty.
*      ELSE.
*        DELETE lt_ncxty.
*      ENDIF.
*    ENDLOOP.
*    IF NOT lt_ncxty[] IS INITIAL.
**     ---------- ---------- ----------
**     Pro Kontext wird eine Registerkarte angezeigt.
**     Pro Zurodnung einen Kontext instanzieren.
*      CALL METHOD add_ctx_for_corder
*        EXPORTING
*          it_ncxty        = lt_ncxty
*        IMPORTING
*          e_rc            = l_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      IF l_rc <> 0.
*        e_rc = l_rc.
*        EXIT.
*      ENDIF.
**     ---------- ---------- ----------
*    ENDIF.
*  ENDLOOP.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*    EXIT.
*  ENDIF.
*  gt_ncxty[] = lt_ncxty[].
* Käfer, ID: 17836 - End

ENDMETHOD.


METHOD init_ctx_userdef_subscr .

* ---------- ---------- ----------
* Workareas
  DATA: l_tabstrip        TYPE rn1_dynp_context_tabstrip.
* Hilfsfelder und -strukturen
  DATA: l_rc              TYPE ish_method_rc,
        l_object          TYPE REF TO object,
        l_top             TYPE i,
        l_left            TYPE i,
        l_einri           TYPE tn01-einri.
* Objekt-Instanzen
  DATA:  lr_ctx_userdef    TYPE REF TO cl_ishmed_subscr_ctx_userdef,
         lr_context        TYPE REF TO cl_ish_context,
         lr_corder         TYPE REF TO cl_ish_corder,
         lr_corder_med     TYPE REF TO cl_ishmed_corder, "ED, ID 15282
         l_aggregation     TYPE ish_on_off, "ED, ID 15282
         l_is_base_item    TYPE ish_on_off. "ED, ID 16882
* ---------- ---------- ----------
* Initialisierungen
  e_rc = 0.

* get main object
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

* get the institution
  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

* ---------- ---------- ----------
* Prüfen ob es für den Kontext bereits einen Subscreen gibt.
  LOOP AT it_tabstrip_dyn INTO l_tabstrip
     WHERE id_sub = co_sub_ctx_userdef1
        OR id_sub = co_sub_ctx_userdef2
        OR id_sub = co_sub_ctx_userdef3
        OR id_sub = co_sub_ctx_userdef4
        OR id_sub = co_sub_ctx_userdef5.
    IF l_tabstrip-subscr IS INITIAL.
      CONTINUE.
    ENDIF.
    CLEAR: lr_ctx_userdef.
    lr_ctx_userdef ?= l_tabstrip-subscr.
    IF NOT lr_ctx_userdef IS INITIAL.
      CALL METHOD lr_ctx_userdef->get_data
        IMPORTING
          e_context = lr_context.
      IF lr_context = ir_context.
        CALL METHOD lr_ctx_userdef->set_data
          EXPORTING
            i_input_fields = 'X'.  " Default
        er_ctx_userdef = lr_ctx_userdef.
        EXIT.
      ENDIF.
    ENDIF.
  ENDLOOP.
*  IF er_ctx_userdef IS INITIAL.
*    CALL METHOD g_planing_subscreen->get_data
*      IMPORTING
*        e_ctx_userdef_sub = l_ctx_userdef.
*    IF NOT l_ctx_userdef IS INITIAL.
*      CALL METHOD l_ctx_userdef->get_data
*        IMPORTING
*          e_context = l_context.
*      IF l_context = p_context.
*        CALL METHOD l_ctx_userdef->set_data
*          EXPORTING
*            i_input_fields = 'X'.  " Default
*        p_ctx_userdef = l_ctx_userdef.
*        EXIT.
*      ENDIF.
*    ENDIF.
*  ENDIF.

* ED, ID 15282: corder aggregation -> set vcode DISPLAY -> BEGIN
* get KZ AGGREGATION
  IF gr_main_object->is_inherited_from(
            cl_ishmed_corder=>co_otype_corder_med ) = on.
    lr_corder_med ?= gr_main_object.
    CHECK NOT lr_corder_med IS INITIAL.
    l_aggregation = lr_corder_med->is_aggregation_object( ).
    l_is_base_item   =
                  lr_corder_med->is_base_item_object( ). "ED, ID 16882
    IF l_aggregation = on OR
       l_is_base_item = on. "ED, ID 16882
      g_vcode = co_vcode_display.
    ENDIF.
  ENDIF.
* ED, ID 15282 -> END

* Käfer, ID: 18689 - Test
  g_lock-lock_obj = gr_lock.
* Käfer, ID: 18689 - Test
* ---------- ---------- ----------
* Falls notwendig Subscreen-Instanz neu anlegen.
  IF er_ctx_userdef IS INITIAL.
*   Subscreenklasse instanzieren
    CREATE OBJECT er_ctx_userdef
      EXPORTING
        i_caller       =  'CL_ISH_SCR_CONTEXT'
        i_einri        =  l_einri
        i_vcode        =  g_vcode
        i_environment  =  gr_environment
        i_lock         =  g_lock.
*        i_plnoe        =  g_plan_oe.
    l_rc = sy-subrc.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   ---------- ----------
*   Set event-handler
    SET HANDLER me->handle_on_before_user_command FOR er_ctx_userdef.
*   ---------- ----------
*   An den Subscreen die KLAU-instanz übergeben.
    l_object  ?=  lr_corder.
    CALL METHOD er_ctx_userdef->set_data
      EXPORTING
        i_object  = l_object
        i_context = ir_context.
  ENDIF.
* ---------- ---------- ----------
** An den Subscreen die Position für das Message-Popup übergeben
*  PERFORM get_position_msg_popup
*     CHANGING l_top l_left.
*  CALL METHOD p_ctx_userdef->set_position_message_popup
*    EXPORTING
*      i_top_pos_msg_popup  = l_top
*      i_left_pos_msg_popup = l_left.
* Nun dem Subscreen diese Klasse übergeben
  CALL FUNCTION 'ISHMED_SET_SUBSCR_CONTEXT'
    EXPORTING
      i_ctx_userdef_sub = er_ctx_userdef.
* ---------- ---------- ----------

ENDMETHOD.


METHOD init_tabstrip .

* Konstante
  CONSTANTS: co_sub_func(3)   TYPE c VALUE 'SUB'.

  DATA: l_rc                  TYPE ish_method_rc,
        lt_ctx_trigger        TYPE ish_objectlist,
        lr_context            TYPE REF TO cl_ish_context,
        l_tabix               TYPE sy-tabix,
        l_nctx                TYPE nctx,
        l_tabstrip_dyn        LIKE LINE OF gt_tabstrip,
        l_object              TYPE ish_object,
        lt_ncxty              TYPE ishmed_t_contexttyp,
        lt_nocty              TYPE ishmed_t_nocty,
        l_nocty               TYPE nocty,
        l_ncxty               TYPE ncxty,
        lt_ncxtyt             TYPE ishmed_t_ncxtyt,
        l_ncxtyt              TYPE ncxtyt,
        lt_ncxst              TYPE ishmed_t_ncxst,
        l_ncxst               TYPE ncxst,
        l_icon                TYPE ncxsicon,
        l_text_km_nein(132),
        l_sort_no(3)          TYPE n,
        lt_tabstrip_copy      TYPE ish_t_context_tabstrip,
        ls_tabstrip_copy      TYPE rn1_dynp_context_tabstrip,
        l_icontext            TYPE ncxtypnm.
  DATA: lr_ctx_subscr         TYPE REF TO cl_ishmed_subscr_ctx_userdef.

  CLEAR: gt_tabstrip[]. "clear every call of the method
* B e n u t z e r d e f i n i e r t e   K o n t e x t e ... (max. 5)
* die ben.def. Kontexte absteigend einordnen
* ----------
* Jene Kontexte ermitteln, deren Auslöser der KLAU ist.
  CALL METHOD me->get_context_for_main_object
    IMPORTING
      et_context_trigger = lt_ctx_trigger
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
* Sortierung vornehmen damit die Vergabe der "id_sub" konstant
* bleibt. Registerkarte mit Kontext geöffnet, die entsprechende
* ID steht in dem globalen Feld g_tabstrip_dynpro-function.
* Falls sich die ID ändert würde nun eine andere Registerkarte
* geöffnet sein.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  SORT lt_ctx_trigger BY object.
* ----------
  LOOP AT lt_ctx_trigger INTO l_object.
    lr_context  ?=  l_object-object.
*   ----------
    l_tabix  =  sy-tabix.
*   ----------
*   Daten des Kontext (cxtyp, cxsta erforderlich) ermitteln.
    CALL METHOD lr_context->get_data
      IMPORTING
        e_rc           = l_rc
        e_nctx         = l_nctx
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   ----------
*   Identifikation
    CASE l_tabix.
      WHEN 1.
        l_tabstrip_dyn-id_sub = co_sub_ctx_userdef1.
      WHEN 2.
        l_tabstrip_dyn-id_sub = co_sub_ctx_userdef2.
      WHEN 3.
        l_tabstrip_dyn-id_sub = co_sub_ctx_userdef3.
      WHEN 4.
        l_tabstrip_dyn-id_sub = co_sub_ctx_userdef4.
      WHEN 5.
        l_tabstrip_dyn-id_sub = co_sub_ctx_userdef5.
      WHEN OTHERS.
        EXIT.
    ENDCASE.
*   ----------
*   Zuerst (wenn nötig) eine neue Instanz für den Subscreen
*   ermitteln.
    CLEAR: lr_ctx_subscr.
    CALL METHOD me->init_ctx_userdef_subscr
      EXPORTING
        ir_context       = lr_context
        it_tabstrip_dyn  = gt_tabstrip
      IMPORTING
        er_ctx_userdef   = lr_ctx_subscr
        e_rc             = l_rc
      CHANGING
        cr_errorhandling = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    l_tabstrip_dyn-subscr  ?=  lr_ctx_subscr.
*   ----------
*   Dem Subscreen mitteilen ob noch die Möglichkeit besteht einen
*   realen Patienten auszuwählen bzw. anzulegen.
    CALL METHOD me->option_for_real_patient
      EXPORTING
        ir_ctx_subscr   = lr_ctx_subscr
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   ----------
*   Reihenfolge und Bezeichnung der Registerkarte bestimmen.
*   ----------
*   Die dem Auftragstypen zugeordneten Kontexte ermitteln,
*   daraus kann dann die   R e i h e n f o l g e   abgeleitet werden.
    CALL METHOD me->get_contexts_for_cordtyps
      EXPORTING
        i_cxtyp         = l_nctx-cxtyp
      IMPORTING
        e_rc            = l_rc
        et_ncxty        = lt_ncxty
        et_nocty        = lt_nocty
      CHANGING
        cr_errorhandler = cr_errorhandler.

    IF l_rc = 0.
      READ TABLE lt_nocty INTO l_nocty
         INDEX 1.
      IF sy-subrc = 0.
        l_tabstrip_dyn-sort =  l_nocty-objpri.
*     Käfer, ID: 17836 - Begin
*     a context, whose definition is not defined within the order type,
*     has to be displayed too.
      ELSE.
        l_tabstrip_dyn-sort = '00'.
*     Käfer, ID: 17836 - End
      ENDIF.
      READ TABLE lt_ncxty INTO l_ncxty INDEX 1.
      IF sy-subrc <> 0.
*       Käfer, ID: 17836 - Begin
        SELECT SINGLE * FROM ncxty INTO l_ncxty
          WHERE cxtyp = l_nctx-cxtyp.
        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.
*        CONTINUE.
*       Käfer, ID: 17836 - End
      ENDIF.
    ELSE.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   ----------
*   Ermittlung der   B e z e i c h n u n g   der Registerkarte.
*   Bezeichnung zu dem Kontexttyp ermitteln.
    CALL METHOD cl_ish_master_dp=>read_contexttype_text
      EXPORTING
        i_spras         = sy-langu
        i_cxtyp         = l_nctx-cxtyp
        i_buffer_active = on
        i_read_db       = off
      IMPORTING
        e_rc            = l_rc
        et_ncxtyt       = lt_ncxtyt
      CHANGING
        c_errorhandler  = cr_errorhandler.
    IF l_rc = 0.
      READ TABLE lt_ncxtyt INTO l_ncxtyt INDEX 1.
      IF sy-subrc <> 0.
*        e_rc = sy-subrc.
*        EXIT.
        CLEAR l_ncxtyt.
      ENDIF.
*     Stammdaten des Kontextstatus ermitteln (Icon).
      CLEAR: l_icon.
      IF NOT l_nctx-cxsta IS INITIAL.
        CALL METHOD cl_ish_master_dp=>read_context_status
          EXPORTING
            i_spras         = sy-langu
            i_cxtyp         = l_nctx-cxtyp
            i_cxsta         = l_nctx-cxsta
            i_buffer_active = on
            i_read_db       = off
          IMPORTING
            e_rc            = l_rc
            et_ncxst        = lt_ncxst
          CHANGING
            c_errorhandler  = cr_errorhandler.
        IF l_rc = 0.
          READ TABLE lt_ncxst INTO l_ncxst
             WITH KEY cxsta = l_nctx-cxsta.
          IF sy-subrc = 0.
            l_icon = l_ncxst-cxsicon.
          ENDIF.
        ENDIF.
      ENDIF.
      IF l_icon IS INITIAL.
        IF NOT l_ncxtyt IS INITIAL.
          l_tabstrip_dyn-text = l_ncxtyt-cxtypnm.
        ELSE.
          l_tabstrip_dyn-text = l_ncxty-cxtyp.
        ENDIF.
      ELSE.
        IF l_ncxtyt IS INITIAL.
          l_icontext = l_ncxty-cxtyp.
        ELSE.
          l_icontext = l_ncxtyt-cxtypnm.
        ENDIF.
        CALL METHOD create_icon
          EXPORTING
            i_iconname      = l_icon
            i_icontext      = l_icontext
            i_infotext      = l_icontext
          IMPORTING
            e_iconfield     = l_text_km_nein
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
        l_tabstrip_dyn-text  =  l_text_km_nein.
      ENDIF.
    ENDIF.
    l_tabstrip_dyn-cxtyp = l_ncxty-cxtyp.
    lt_tabstrip_copy[] = gt_tabstrip[].
    READ TABLE lt_tabstrip_copy INTO ls_tabstrip_copy
             WITH KEY cxtyp = l_ncxty-cxtyp.
    IF sy-subrc <> 0.
*   ----------
      INSERT l_tabstrip_dyn INTO TABLE gt_tabstrip.
    ENDIF.
*   ----------
  ENDLOOP.
  CHECK e_rc = 0.
* ---------- ---------- ----------
* Durchgehende Sortierung sicherstellen.
* ED, ID 17836: new sort (sort also by text)
*  sort gt_tabstrip by sort.
  SORT gt_tabstrip BY sort DESCENDING text ASCENDING.
  l_sort_no = 0.
  LOOP AT gt_tabstrip INTO l_tabstrip_dyn.
    l_sort_no = l_sort_no + 1.
    l_tabstrip_dyn-sort = l_sort_no.
    MODIFY gt_tabstrip FROM l_tabstrip_dyn.
  ENDLOOP.
* ---------- ---------- ----------
* Funktion der Registerkarte bestimmen.
  LOOP AT gt_tabstrip INTO l_tabstrip_dyn.
*   ----------
    CONCATENATE co_sub_func l_tabstrip_dyn-sort
       INTO l_tabstrip_dyn-function.
    MODIFY gt_tabstrip FROM l_tabstrip_dyn.
*   ----------
  ENDLOOP.

ENDMETHOD.


METHOD modify_screen_internal.

  DATA: l_rc                  TYPE ish_method_rc,
        lt_ctx_trigger        TYPE ish_objectlist,
        l_object              TYPE ish_object,
        l_option_pat          TYPE ish_on_off,
        lt_functions          TYPE ishmed_t_appointment_functions,
        lt_tabstrip           TYPE ish_t_context_tabstrip,
        ls_tabstrip           LIKE LINE OF lt_tabstrip,
        l_function            LIKE LINE OF lt_functions,
        lr_context            TYPE REF TO cl_ish_context,
        lr_ctx_userdef        TYPE REF TO cl_ishmed_ctx_userdef,
        lr_ctx_subscr         TYPE REF TO cl_ishmed_subscr_ctx_userdef.

*-- Begin data declarations, ID-17286
  DATA: l_icon                TYPE ncxsicon,
        l_nctx                TYPE nctx,
        lt_ncxtyt             TYPE ishmed_t_ncxtyt,
        l_ncxtyt              TYPE ncxtyt,
        lt_ncxst              TYPE ishmed_t_ncxst,
        l_ncxst               TYPE ncxst,
        l_tabstrip_dyn        LIKE LINE OF gt_tabstrip,
        l_ncxty               TYPE ncxty,
        l_icontext            TYPE ncxtypnm,
        lt_tabstrip_copy      TYPE ish_t_context_tabstrip,
        ls_tabstrip_copy      TYPE rn1_dynp_context_tabstrip,
        lt_ncxty              TYPE ishmed_t_contexttyp,
        lt_nocty              TYPE ishmed_t_nocty,
        l_nocty               TYPE nocty,
        l_sort_no(3)          TYPE n,
        l_text_km_nein(132).
* Konstante
  CONSTANTS: co_sub_func(3)   TYPE c VALUE 'SUB'.

*-- Begin Grill, ID-16625
  CHECK g_vcode NE co_vcode_display.
*-- End Grill, ID-16625

*-- get context
  CALL METHOD me->get_context_for_main_object
    IMPORTING
      et_context_trigger = lt_ctx_trigger
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  SORT lt_ctx_trigger BY object.

*  LOOP AT lt_ctx_trigger INTO l_object. "ID- 17286
*    lr_context  ?=  l_object-object.    "ID- 17286

  CALL METHOD me->get_tabstrip_data
    IMPORTING
      et_tabstrip = lt_tabstrip.
  LOOP AT lt_tabstrip INTO ls_tabstrip.
    lr_ctx_subscr ?= ls_tabstrip-subscr.
*-- If the patient a real patient
    CALL METHOD me->option_for_real_patient
      EXPORTING
        ir_ctx_subscr   = lr_ctx_subscr
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*-- get context-data
    CALL METHOD lr_ctx_subscr->get_data
      IMPORTING
        e_ctx_userdef = lr_ctx_userdef
        e_option_pat  = l_option_pat.
    IF NOT lr_ctx_userdef IS INITIAL. "ED, ID 17285
      CALL METHOD lr_ctx_userdef->get_default_functions
        IMPORTING
          et_functions   = lt_functions
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      READ TABLE lt_functions INTO l_function
       WITH KEY function = cl_ishmed_ctx_dialog=>co_fc_request_create.
      IF sy-subrc EQ 0 AND
         l_option_pat = off.
        l_function-disabled = on.
      ELSEIF l_option_pat = on.
        l_function-disabled = off.
      ENDIF.
*-- Begin Grill, ID-16625
      IF NOT lt_functions[] IS INITIAL
          AND NOT l_function-function IS INITIAL. "ED, ID 17836
        MODIFY lt_functions FROM l_function INDEX sy-tabix.
        CALL METHOD lr_ctx_userdef->change_functions
          EXPORTING
            it_defined_functions = lt_functions
          IMPORTING
            e_rc                 = l_rc
          CHANGING
            c_errorhandler       = cr_errorhandler.
        IF l_rc NE 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
      ENDIF.
*-- End Grill, ID-16625

*-- Begin Grill, ID-17286
*-- get context
      CALL METHOD lr_ctx_subscr->get_data
        IMPORTING
          e_context = lr_context.
*-- get data
      CALL METHOD lr_context->get_data
        IMPORTING
          e_rc           = l_rc
          e_nctx         = l_nctx
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF l_rc NE 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
*   Die dem Auftragstypen zugeordneten Kontexte ermitteln,
*   daraus kann dann die   R e i h e n f o l g e   abgeleitet werden.
      CALL METHOD me->get_contexts_for_cordtyps
        EXPORTING
          i_cxtyp         = l_nctx-cxtyp
        IMPORTING
          e_rc            = l_rc
          et_ncxty        = lt_ncxty
          et_nocty        = lt_nocty
        CHANGING
          cr_errorhandler = cr_errorhandler.

      IF l_rc = 0.
        READ TABLE lt_nocty INTO l_nocty
           INDEX 1.
        IF sy-subrc = 0.
          l_tabstrip_dyn-sort =  l_nocty-objpri.
        ENDIF.
        READ TABLE lt_ncxty INTO l_ncxty INDEX 1.
        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.
      ELSE.
        e_rc = l_rc.
        EXIT.
      ENDIF.
*-- read contexttype
      CALL METHOD cl_ish_master_dp=>read_contexttype_text
        EXPORTING
          i_spras         = sy-langu
          i_cxtyp         = l_nctx-cxtyp
          i_buffer_active = on
          i_read_db       = off
        IMPORTING
          e_rc            = l_rc
          et_ncxtyt       = lt_ncxtyt
        CHANGING
          c_errorhandler  = cr_errorhandler.
      IF l_rc = 0.
        READ TABLE lt_ncxtyt INTO l_ncxtyt INDEX 1.
        IF sy-subrc <> 0.
          CLEAR l_ncxtyt.
        ENDIF.
*     Stammdaten des Kontextstatus ermitteln (Icon).
        CLEAR: l_icon.
        IF NOT l_nctx-cxsta IS INITIAL.
          CALL METHOD cl_ish_master_dp=>read_context_status
            EXPORTING
              i_spras         = sy-langu
              i_cxtyp         = l_nctx-cxtyp
              i_cxsta         = l_nctx-cxsta
              i_buffer_active = on
              i_read_db       = off
            IMPORTING
              e_rc            = l_rc
              et_ncxst        = lt_ncxst
            CHANGING
              c_errorhandler  = cr_errorhandler.
          IF l_rc = 0.
            READ TABLE lt_ncxst INTO l_ncxst
               WITH KEY cxsta = l_nctx-cxsta.
            IF sy-subrc = 0.
              l_icon = l_ncxst-cxsicon.
            ENDIF.
          ENDIF.
        ENDIF.
        IF l_icon IS INITIAL.
          IF NOT l_ncxtyt IS INITIAL.
            l_tabstrip_dyn-text = l_ncxtyt-cxtypnm.
          ELSE.
            l_tabstrip_dyn-text = l_ncxty-cxtyp.
          ENDIF.
        ELSE.
          IF l_ncxtyt IS INITIAL.
            l_icontext = l_ncxty-cxtyp.
          ELSE.
            l_icontext = l_ncxtyt-cxtypnm.
          ENDIF.
          CALL METHOD create_icon
            EXPORTING
              i_iconname      = l_icon
              i_icontext      = l_icontext
              i_infotext      = l_icontext
            IMPORTING
              e_iconfield     = l_text_km_nein
              e_rc            = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          CHECK e_rc = 0.
          l_tabstrip_dyn-text   =  l_text_km_nein.
        ENDIF.
      ENDIF.
      l_tabstrip_dyn-cxtyp = l_ncxty-cxtyp.
      lt_tabstrip_copy[] = gt_tabstrip[].
      READ TABLE lt_tabstrip_copy INTO ls_tabstrip_copy
               WITH KEY cxtyp = l_ncxty-cxtyp.
      IF sy-subrc EQ 0.
        ls_tabstrip_copy-text = l_tabstrip_dyn-text.
        MODIFY gt_tabstrip FROM ls_tabstrip_copy
        TRANSPORTING text WHERE cxtyp = ls_tabstrip_copy-cxtyp.
      ENDIF.
    ENDIF.
*    ENDLOOP. "ID- 17286
  ENDLOOP.

ENDMETHOD.


METHOD option_for_real_patient .

  DATA: l_option_pat TYPE ish_true_false,
        lr_corder    TYPE REF TO cl_ish_corder,
        l_new        TYPE ish_on_off,
        lr_pat_prov  TYPE REF TO cl_ish_patient_provisional,
        l_rc         type ish_method_rc.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.
*-- Grill, ID-16625
*  CALL METHOD lr_corder->if_ish_data_object~is_new
*    IMPORTING
*      e_new = l_new.
*  IF l_new = on.
*    l_option_pat = on.
*  ELSE.
    CALL METHOD lr_corder->get_patient_provisional
      EXPORTING
        ir_environment         = gr_environment
      IMPORTING
        er_patient_provisional = lr_pat_prov
        e_rc                   = l_rc
      CHANGING
        cr_errorhandler        = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF lr_pat_prov IS INITIAL.
      l_option_pat = on.
    ENDIF.
*  ENDIF. "Grill, ID-16625

  CALL METHOD ir_ctx_subscr->set_data
    EXPORTING
      i_option_pat   = l_option_pat
      i_option_pat_x = on.

ENDMETHOD.


METHOD refresh_tabstrip.

  CONSTANTS: co_sub_func(3)   TYPE c VALUE 'SUB'.

  TYPES: BEGIN OF lty_avail_ucomm,
           id_sub TYPE sy-ucomm,
         END OF lty_avail_ucomm.

  DATA: lr_subscr_ctx_userdef TYPE REF TO cl_ishmed_subscr_ctx_userdef,
        lt_tabstrip_copy TYPE ish_t_context_tabstrip,
        lt_tabstrip_new  TYPE ish_t_context_tabstrip,
        lr_context TYPE REF TO cl_ish_context,
        lr_context_old TYPE REF TO cl_ish_context,
        lt_context_trigger TYPE ish_objectlist,
        lt_context_new TYPE TABLE OF n1objectref,
        ls_object TYPE ish_object,
        lr_identify_object TYPE REF TO if_ish_identify_object,
        l_found TYPE ish_on_off,
        lt_available_ucomm TYPE TABLE OF lty_avail_ucomm,
        ls_available_ucomm TYPE lty_avail_ucomm,
        ls_nctx TYPE nctx,
        lr_object TYPE REF TO object,
        l_rc TYPE ish_method_rc,
        ls_tabstrip TYPE rn1_dynp_context_tabstrip,
        lt_ncxty              TYPE ishmed_t_contexttyp,
        lt_nocty              TYPE ishmed_t_nocty,
        ls_nocty               TYPE nocty,
        ls_ncxty               TYPE ncxty,
        lt_ncxtyt             TYPE ishmed_t_ncxtyt,
        ls_ncxtyt              TYPE ncxtyt,
        lt_ncxst              TYPE ishmed_t_ncxst,
        ls_ncxst               TYPE ncxst,
        l_icon                TYPE ncxsicon,
        l_text_km_nein(132),
        l_sort_no(3)          TYPE n,
        l_icontext            TYPE ncxtypnm.

  FIELD-SYMBOLS: <ls_tabstrip> TYPE rn1_dynp_context_tabstrip.

  REFRESH: lt_context_new,
           lt_tabstrip_copy,
           lt_tabstrip_new,
           lt_context_trigger.


  IF gt_tabstrip IS INITIAL.

    CALL METHOD me->init_tabstrip
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.

  ELSE.
*   create a table for available ucomms
    REFRESH lt_available_ucomm.
    CLEAR ls_available_ucomm.
    ls_available_ucomm = co_sub_ctx_userdef1.
    APPEND ls_available_ucomm TO lt_available_ucomm.
    CLEAR ls_available_ucomm.
    ls_available_ucomm = co_sub_ctx_userdef2.
    APPEND ls_available_ucomm TO lt_available_ucomm.
    CLEAR ls_available_ucomm.
    ls_available_ucomm = co_sub_ctx_userdef3.
    APPEND ls_available_ucomm TO lt_available_ucomm.
    CLEAR ls_available_ucomm.
    ls_available_ucomm = co_sub_ctx_userdef4.
    APPEND ls_available_ucomm TO lt_available_ucomm.
    CLEAR ls_available_ucomm.
    ls_available_ucomm = co_sub_ctx_userdef5.
    APPEND ls_available_ucomm TO lt_available_ucomm.

*   copy the existing tabstrip - table
    lt_tabstrip_copy = gt_tabstrip.

*   get all context-objects connected to the clinical order
    REFRESH lt_context_trigger.
    CALL METHOD me->get_context_for_main_object
      IMPORTING
        e_rc               = e_rc
        et_context_trigger = lt_context_trigger
      CHANGING
        cr_errorhandler    = cr_errorhandler.
    CHECK e_rc = 0.

*   there are two possiblities in further processing
*   - context-object is allready within the TABSTRIP-TABLE
*      put the found entry into the new TABSTRIP-TABLE and
*      delete the corresponding entry from the table for
*      the available ucomms
*   - context-object is not within the TABSTRIP-TABLE
*      put the object into a special table.
*      this table will be executed lateron -> for each entry
*      must be made a new entry in TABSTRIP-TABLE
    LOOP AT lt_context_trigger INTO ls_object.
      CHECK NOT ls_object-object IS INITIAL.
      CLEAR lr_identify_object.
      lr_identify_object ?= ls_object-object.
      CHECK lr_identify_object->is_inherited_from(
        cl_ish_context=>co_otype_context ) = on.
      CLEAR lr_context.
      lr_context ?= lr_identify_object.
      l_found = off.
      LOOP AT lt_tabstrip_copy ASSIGNING <ls_tabstrip>.
        CHECK <ls_tabstrip>-subscr IS NOT INITIAL.
        CLEAR lr_subscr_ctx_userdef.
        lr_subscr_ctx_userdef ?= <ls_tabstrip>-subscr.
        CLEAR lr_context_old.
        CALL METHOD lr_subscr_ctx_userdef->get_data
          IMPORTING
            e_context = lr_context_old.
        CHECK NOT lr_context IS INITIAL.
        IF lr_context = lr_context_old.
          l_found = on.
          EXIT.
        ENDIF.
      ENDLOOP.
      IF l_found = on.
        APPEND <ls_tabstrip> TO lt_tabstrip_new.
        READ TABLE lt_available_ucomm TRANSPORTING NO FIELDS
          WITH KEY id_sub = <ls_tabstrip>-id_sub.
        CHECK sy-subrc = 0.
        DELETE lt_available_ucomm INDEX sy-tabix.

      ELSE.
        APPEND lr_context TO lt_context_new.
      ENDIF.

    ENDLOOP.

*   create new entries in TABSTRIP-TABLE for the context-objects
*   which are new
    LOOP AT lt_context_new INTO lr_object.
      CLEAR ls_tabstrip.
      CLEAR lr_context.
      lr_context ?= lr_object.
      CLEAR ls_nctx.
      CALL METHOD lr_context->get_data
        IMPORTING
          e_rc           = e_rc
          e_nctx         = ls_nctx
        CHANGING
          c_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
      READ TABLE lt_available_ucomm INTO ls_available_ucomm INDEX 1.
      CHECK sy-subrc = 0.
      ls_tabstrip-id_sub = ls_available_ucomm-id_sub.
      CLEAR lr_subscr_ctx_userdef.
      CALL METHOD me->init_ctx_userdef_subscr
        EXPORTING
          it_tabstrip_dyn  = lt_tabstrip_new
          ir_context       = lr_context
        IMPORTING
          e_rc             = l_rc
          er_ctx_userdef   = lr_subscr_ctx_userdef
        CHANGING
          cr_errorhandling = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      ls_tabstrip-subscr ?= lr_subscr_ctx_userdef.

      CALL METHOD me->option_for_real_patient
        EXPORTING
          ir_ctx_subscr   = lr_subscr_ctx_userdef
        IMPORTING
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.

      CALL METHOD me->get_contexts_for_cordtyps
        EXPORTING
          i_cxtyp         = ls_nctx-cxtyp
        IMPORTING
          e_rc            = l_rc
          et_ncxty        = lt_ncxty
          et_nocty        = lt_nocty
        CHANGING
          cr_errorhandler = cr_errorhandler.

      IF l_rc = 0.
        READ TABLE lt_nocty INTO ls_nocty
           INDEX 1.
        IF sy-subrc = 0.
          ls_tabstrip-sort =  ls_nocty-objpri.
        ELSE.
          ls_tabstrip-sort = '99'.
        ENDIF.

        READ TABLE lt_ncxty INTO ls_ncxty INDEX 1.
        IF sy-subrc <> 0.
          SELECT SINGLE * FROM ncxty INTO ls_ncxty
            WHERE cxtyp = ls_nctx-cxtyp.
          IF sy-subrc <> 0.
            CONTINUE.
          ENDIF.
        ENDIF.
      ELSE.
        e_rc = l_rc.
        EXIT.
      ENDIF.

      CALL METHOD cl_ish_master_dp=>read_contexttype_text
        EXPORTING
          i_spras         = sy-langu
          i_cxtyp         = ls_nctx-cxtyp
          i_buffer_active = on
          i_read_db       = off
        IMPORTING
          e_rc            = l_rc
          et_ncxtyt       = lt_ncxtyt
        CHANGING
          c_errorhandler  = cr_errorhandler.
      IF l_rc = 0.
        READ TABLE lt_ncxtyt INTO ls_ncxtyt INDEX 1.
        IF sy-subrc <> 0.
          CLEAR ls_ncxtyt.
        ENDIF.
*     Stammdaten des Kontextstatus ermitteln (Icon).
        CLEAR: l_icon.
        IF NOT ls_nctx-cxsta IS INITIAL.
          CALL METHOD cl_ish_master_dp=>read_context_status
            EXPORTING
              i_spras         = sy-langu
              i_cxtyp         = ls_nctx-cxtyp
              i_cxsta         = ls_nctx-cxsta
              i_buffer_active = on
              i_read_db       = off
            IMPORTING
              e_rc            = l_rc
              et_ncxst        = lt_ncxst
            CHANGING
              c_errorhandler  = cr_errorhandler.
          IF l_rc = 0.
            READ TABLE lt_ncxst INTO ls_ncxst
               WITH KEY cxsta = ls_nctx-cxsta.
            IF sy-subrc = 0.
              l_icon = ls_ncxst-cxsicon.
            ENDIF.
          ENDIF.
        ENDIF.
        IF l_icon IS INITIAL.
          IF NOT ls_ncxtyt IS INITIAL.
            ls_tabstrip-text = ls_ncxtyt-cxtypnm.
          ELSE.
            ls_tabstrip-text = ls_ncxty-cxtyp.
          ENDIF.
        ELSE.
          IF ls_ncxtyt IS INITIAL.
            l_icontext = ls_ncxty-cxtyp.
          ELSE.
            l_icontext = ls_ncxtyt-cxtypnm.
          ENDIF.
          CALL METHOD create_icon
            EXPORTING
              i_iconname      = l_icon
              i_icontext      = l_icontext
              i_infotext      = l_icontext
            IMPORTING
              e_iconfield     = l_text_km_nein
              e_rc            = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          CHECK e_rc = 0.
          ls_tabstrip-text  =  l_text_km_nein.
        ENDIF.
      ENDIF.
      ls_tabstrip-cxtyp = ls_ncxty-cxtyp.
      READ TABLE lt_tabstrip_new TRANSPORTING NO FIELDS
        WITH KEY cxtyp = ls_tabstrip-cxtyp.
      IF sy-subrc <> 0.
        APPEND ls_tabstrip TO lt_tabstrip_new.
      ENDIF.

    ENDLOOP.
    CHECK e_rc = 0.

    gt_tabstrip = lt_tabstrip_new.

    SORT gt_tabstrip BY sort text ASCENDING.
    l_sort_no = 0.
    LOOP AT gt_tabstrip INTO ls_tabstrip.
      l_sort_no = l_sort_no + 1.
      ls_tabstrip-sort = l_sort_no.
      MODIFY gt_tabstrip FROM ls_tabstrip.
    ENDLOOP.
* ---------- ---------- ----------
* Funktion der Registerkarte bestimmen.
    LOOP AT gt_tabstrip INTO ls_tabstrip.
*   ----------
      CONCATENATE co_sub_func ls_tabstrip-sort
         INTO ls_tabstrip-function.
      MODIFY gt_tabstrip FROM ls_tabstrip.
*   ----------
    ENDLOOP.

  ENDIF.


ENDMETHOD.


METHOD set_ctx_userdef_subscr .

  CLEAR: e_rc.

* ---------- ---------- ----------
* Workareas
  DATA: l_tabstrip_dyn   LIKE LINE OF gt_tabstrip.
* Hilfsfelder und -strukturen
  DATA: l_index          TYPE sy-tabix,
        l_rc             TYPE ish_method_rc.
* Objekt-Instanzen
  DATA: lr_ctx_subscr     TYPE REF TO cl_ishmed_subscr_ctx_userdef,
        lr_corder         TYPE REF TO cl_ishmed_corder, "ED, ID 15282
        l_aggregation     TYPE ish_on_off, "ED, ID 15282
        l_is_base_item    TYPE ish_on_off. "ED, ID 16882
* ---------- ---------- ----------
  READ TABLE gt_tabstrip INTO l_tabstrip_dyn
     WITH KEY id_sub  =  c_function.
  IF sy-subrc = 0.
    lr_ctx_subscr  ?=  l_tabstrip_dyn-subscr.

*   ED, ID 15282: corder aggregation -> set vcode DISPLAY -> BEGIN
*   get KZ AGGREGATION
    IF gr_main_object->is_inherited_from(
              cl_ishmed_corder=>co_otype_corder_med ) = on.
      lr_corder ?= gr_main_object.
      CHECK NOT lr_corder IS INITIAL.
      l_aggregation = lr_corder->is_aggregation_object( ).
      l_is_base_item   =
                    lr_corder->is_base_item_object( ). "ED, ID 16882
      IF l_aggregation = on OR
         l_is_base_item = on. "ED, ID 16882
        g_vcode = co_vcode_display.
      ENDIF.
    ENDIF.
*   ED, ID 15282 -> END

*   Klasse für den Subscreen setzen.
    CALL FUNCTION 'ISH_SET_SUBSCR_CONTEXT'
      EXPORTING
        ir_ctx_userdef_sub = lr_ctx_subscr
        i_vcode            = g_vcode.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD set_default_tab .

* ---------- ---------- ----------
* Workareas
  DATA: l_tabstrip_dyn        LIKE LINE OF gt_tabstrip.
* Hilfsfelder und -strukturen
  DATA: l_ishmed_active       TYPE ish_on_off,
        l_active              TYPE ish_true_false,
        l_key                 TYPE string,
        l_cxid                TYPE nctx-cxid,
        l_regcard             TYPE char18. "ED, ID 17836
* Objekt-Instanzen
  DATA: l_ctx_userdef         TYPE REF TO cl_ishmed_subscr_ctx_userdef,
        lr_context             TYPE REF TO cl_ish_context,
        l_ishmed_auth         TYPE ish_on_off.
* ---------- ---------- ----------
  l_regcard = i_regcard.
  CLEAR:      e_function.

* Notice if IS-H*MED is active
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

* Initialisierung
  IF l_regcard IS INITIAL.
    l_regcard = 'SUB_CTX_USERDEF'. " Default
  ENDIF.

* ---------- ---------- ----------
  IF l_regcard(1) CN ' 0123456789'.
* P_REGCARD enthält die ID (=Konstante) einer fix definierten
* Registerkarte.
  ELSE.
* P_REGCARD enthält die ID eines Kontext. Den entsprechenden Subscreen
* ermitteln und die Registerkarte aufschlagen.
    LOOP AT gt_tabstrip INTO l_tabstrip_dyn
       WHERE id_sub = co_sub_ctx_userdef1
          OR id_sub = co_sub_ctx_userdef2
          OR id_sub = co_sub_ctx_userdef3
          OR id_sub = co_sub_ctx_userdef4
          OR id_sub = co_sub_ctx_userdef5.
      l_ctx_userdef ?= l_tabstrip_dyn-subscr.
      CALL METHOD l_ctx_userdef->('GET_DATA')
        IMPORTING
          e_context = lr_context.
      CALL METHOD lr_context->get_key_string
        IMPORTING
          e_key = l_key.
      CALL METHOD cl_ish_context=>build_data_key
        EXPORTING
          i_key  = l_key
        IMPORTING
          e_cxid = l_cxid.
      IF i_regcard = l_cxid.
        e_function = l_tabstrip_dyn-id_sub.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDIF.
* ---------- ---------- ----------
  CHECK NOT e_function IS INITIAL.
  g_tabstrip_dynpro-function = e_function. "ED, ID 17836
* ---------- ---------- ----------
* Scrollposition festlegen (dies darf nur geschehen wenn ausdrücklich
* eine bestimmte Registerkarte aufgeschlagen werden soll. Also nicht
* wenn der Benutzer selbst blättert.
  e_scroll_position  =  e_function.
* ---------- ---------- ----------

ENDMETHOD.


METHOD set_tabstrip_dyn .


  DATA: l_function     TYPE sy-ucomm,
        l_active       TYPE ish_on_off,
        l_active_tab   TYPE sy-ucomm,
        l_tab_name(50) TYPE c,
        l_no(2)        TYPE n.

* Typen
  TYPES: BEGIN OF ty_sort,
           id_sub             TYPE sy-ucomm,
           sort(2)            TYPE n,
         END   OF ty_sort,
         tyt_sort             TYPE TABLE OF ty_sort.
* Konstante
  CONSTANTS: co_sub_func(3)   TYPE c VALUE 'SUB'.
* Lokale Tabellen
  DATA:  lt_sort              TYPE tyt_sort,
         lt_nocty             TYPE ishmed_t_nocty.
* Workareas
  DATA:  l_tabstrip_dyn       LIKE LINE OF gt_tabstrip,
         l_sort               LIKE LINE OF lt_sort,
         l_nocty              LIKE LINE OF lt_nocty,
         l_nctx               TYPE nctx.
* Hilfsfelder und -strukturen
  DATA:  l_rc                 TYPE ish_method_rc,
         l_n1corder           TYPE n1corder,
         l_sort_no(2)         TYPE n,
         l_tabstrip_name(50)  TYPE c  VALUE 'TS_CONTEXT_TAB',
         l_objtyid            TYPE nocty-objtyid,
         l_srv_active         TYPE ish_on_off.
* Feldsymbole
  FIELD-SYMBOLS: <l_field>  TYPE ANY.
*  FIELD-SYMBOLS: <l_fs_tab> TYPE c.

  CLEAR: e_rc.
* ---------- ---------- ----------
*  LOOP AT SCREEN.
**   ----------
*    CLEAR: l_function.
**   ----------
*    IF screen-name(14) = 'TS_CONTEXT_TAB'.
**     ----------
**     Um die Dynpromodifikation der Registerkarten zu ignorieren
**     - diese hier nochmals aktiv setzen.
**     Muss erfolgen bevor Titel gesetzt wird da dieser sonst
**     ignoriert wird.
*      screen-input     = true.
*      screen-output    = true.
*      screen-invisible = false.
**     ----------
*      l_sort_no = screen-name+14(2).
*      READ TABLE gt_tabstrip INTO l_tabstrip_dyn
*         WITH KEY sort = l_sort_no.
*      IF sy-subrc = 0.
*        CONCATENATE l_tabstrip_name(14) l_tabstrip_dyn-sort
*           INTO l_tabstrip_name.
*        ASSIGN (l_tabstrip_name) TO <l_field>.
*        IF sy-subrc = 0.
*          <l_field> = l_tabstrip_dyn-text.
*        ENDIF.
*        l_function = l_tabstrip_dyn-id_sub.
*      ELSE.
*        screen-active = false.
*        MODIFY SCREEN.
*      ENDIF.
*    ENDIF.
*
*    IF NOT l_function IS INITIAL.
** ---------- ---------- ----------
**     Prüfung ob eine Registerkarte aktiv ist.
*      CALL METHOD me->check_tabstrip_active_dyn
*        EXPORTING
*          i_id_sub        = l_function
*        IMPORTING
*          e_active        = l_active
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      CHECK e_rc = 0.
*      screen-active    = l_active.
*      MODIFY SCREEN.
*    ENDIF.
*  ENDLOOP.

* ---------- ---------- ----------
* Nun aufgrund des Funktionscodes des Tabstrips den passenden
* Subscreen aktivieren
* Achtung: Die Funktionsbausteine zum Ansteuern der Subscreens
* wurden schon früher (schon im Funktionsbaustein) aufgerufen!
  CLEAR l_active_tab.
  DO.
    IF g_tabstrip_dynpro-function = l_active_tab.
      EXIT.
    ENDIF.
    IF NOT l_active_tab IS INITIAL.
      g_tabstrip_dynpro-function = l_active_tab.
    ENDIF.
    CASE g_tabstrip_dynpro-function.
*     Registerkarten für n-benutzerdefinierte Kontexte
      WHEN co_sub_ctx_userdef1 OR
           co_sub_ctx_userdef2 OR
           co_sub_ctx_userdef3 OR
           co_sub_ctx_userdef4 OR
           co_sub_ctx_userdef5.
        g_tabstrip_dynpro-program  =  'SAPLNCORD'.
        g_tabstrip_dynpro-dynpro   =  '0500'.
*       Korrekte Subscreen-Instanz (für aktuelle Registerkarte)
*       setzen.
        CALL METHOD me->set_ctx_userdef_subscr
          IMPORTING
            e_rc            = e_rc
          CHANGING
            c_function      = g_tabstrip_dynpro-function
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
*     ---------- ----------
      WHEN OTHERS.
        CALL METHOD me->get_first_active_tab
          IMPORTING
            e_function      = l_active_tab
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
        EXIT.
    ENDCASE.

    READ TABLE gt_tabstrip INTO l_tabstrip_dyn
       WITH KEY id_sub = g_tabstrip_dynpro-function.
    IF sy-subrc = 0.
      CONCATENATE 'TS_CONTEXT_TAB' l_tabstrip_dyn-sort INTO l_tab_name.
*      ASSIGN (l_tab_name) TO <l_fs_tab>.
*      <l_fs_tab> = l_tabstrip_dyn-text.
      e_tabstrip-function =  l_tabstrip_dyn-function.
    ENDIF.

*   Jetzt prüfen, ob der Subscreen überhaupt aktiv ist
    IF l_tab_name IS INITIAL.
      CALL METHOD me->get_first_active_tab
        IMPORTING
          e_function      = l_active_tab
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.

    ELSE.
      LOOP AT SCREEN.
        IF screen-name = l_tab_name  AND  screen-active = false.
          CALL METHOD me->get_first_active_tab
            IMPORTING
              e_function      = l_active_tab
              e_rc            = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          CHECK e_rc = 0.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDIF.
    IF l_active_tab IS INITIAL.
      EXIT.
    ENDIF.
  ENDDO.
* ---------- ---------- ----------

ENDMETHOD.


METHOD VALUE_REQUEST_INTERNAL .

** Initializations.
*  CLEAR: e_rc.
*
*  CASE i_fieldname.
*    WHEN g_fieldname_wlhsp.
*      CALL METHOD value_request_wlhsp
*        IMPORTING
*          e_called        = e_called
*          e_selected      = e_selected
*          e_value         = e_value
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      CHECK e_rc = 0.
*  ENDCASE.

ENDMETHOD.
ENDCLASS.
