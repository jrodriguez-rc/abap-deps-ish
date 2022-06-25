FUNCTION ishmed_wp_view_010_func.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_FCODE) TYPE  RSEU1-FUNC
*"     VALUE(I_FIELDNAME) TYPE  LVC_FNAME OPTIONAL
*"  EXPORTING
*"     REFERENCE(E_RC) TYPE  SY-SUBRC
*"     REFERENCE(E_REFRESH) TYPE  N1FLD-REFRESH
*"     REFERENCE(E_FUNC_DONE) TYPE  ISH_TRUE_FALSE
*"     REFERENCE(E_FUNCTION) TYPE  RSEU1-FUNC
*"  TABLES
*"      T_ISH_OBJECTS TYPE  ISH_T_DRAG_DROP_DATA OPTIONAL
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"      T_SELVAR STRUCTURE  RSPARAMS OPTIONAL
*"----------------------------------------------------------------------

  TYPES:
  BEGIN OF ty_obj_mark,
     obj_ordpos     TYPE REF TO cl_ishmed_prereg,
     obj_case       TYPE REF TO cl_ishmed_none_oo_nfal,
     obj_pat        TYPE REF TO cl_ishmed_none_oo_npat,
     obj_prov       TYPE REF TO cl_ish_patient_provisional,
  END OF ty_obj_mark,
  tyt_obj_mark      TYPE STANDARD TABLE OF ty_obj_mark.

  DATA: s_ish_object     LIKE LINE OF t_ish_objects,
        lt_marked        TYPE tyt_marked,
        l_marked         TYPE ty_marked,
        l_cnt_patients   TYPE i,
        l_cnt_fall       TYPE i,
        l_cnt_app        TYPE i,
        l_cnt_vkg        TYPE i,
        l_cnt_pap        TYPE i,
        l_einri          LIKE tn01-einri,
        l_view_id        TYPE nviewid,
        l_view_type      TYPE nviewtype,
        l_wplaceid       TYPE nwplace-wplaceid,
        l_planoe         TYPE orgid,
        l_fcode          LIKE rseu1-func,
        l_wa_msg         LIKE bapiret2.
  DATA: l_wa_wplaceid    TYPE nwplace-wplaceid,
        l_wa_viewid      TYPE nwview-viewid,
        l_wa_viewtype    TYPE nwview-viewtype,
        l_wa_wplaceid2   TYPE nwplace-wplaceid,
        l_wa_viewid2     TYPE nwview-viewid,
        l_wa_viewtype2   TYPE nwview-viewtype.
  DATA: lr_error         TYPE REF TO cl_ishmed_errorhandling,
        lr_env           TYPE REF TO cl_ish_environment,
        l_cr_own_env     TYPE ish_on_off,
        lt_obj_mark      TYPE tyt_obj_mark,
        l_obj_mark       LIKE LINE OF lt_obj_mark,
        lt_objects       TYPE ish_objectlist,
        l_object         LIKE LINE OF lt_objects,
        lt_parameter     TYPE ishmed_t_parameter,
        l_parameter      LIKE LINE OF lt_parameter,
        lt_messages      TYPE bapiret2_t,
        lt_cancel_obj    TYPE ish_objectlist,
        lr_corder        TYPE REF TO cl_ish_corder,
        l_cancel         TYPE ish_on_off,
        l_pap_key        TYPE rnpap-key,
        lr_txtobject     TYPE REF TO cl_ishmed_cpos_question,
        l_cposquestionid TYPE n1cposquestionid,
        l_rc             TYPE ish_method_rc,
        l_auth           TYPE ish_true_false.

* initialization
  CLEAR: l_fcode, l_wa_msg, l_einri, l_view_id, l_view_type.

  CLEAR:   t_messages, l_wplaceid.
  REFRESH: t_messages, lt_marked.
  REFRESH: lt_objects, lt_parameter, lt_obj_mark, lt_cancel_obj.

  l_fcode = i_fcode.

  e_func_done = true.

* get the parameters (IS-H*MED objects) for the function
  CLEAR l_obj_mark.
  SORT t_ish_objects BY objectset objectid.
  CLEAR l_marked.
  LOOP AT t_ish_objects INTO s_ish_object.
    CASE s_ish_object-objectid.
      WHEN '00'.                       " Einrichtung
        l_marked-einri    = s_ish_object-objectlow.
        l_einri           = l_marked-einri.
      WHEN '01'.                       " Patient
        l_marked-patnr    = s_ish_object-objectlow.
      WHEN '02'.                       " Fall
        l_marked-falnr    = s_ish_object-objectlow.
      WHEN '03'.                       " Bewegung
      WHEN '04'.                       " Pfleg. OE
      WHEN '05'.                       " Fachl. OE
      WHEN '06'.                       " Zimmer
      WHEN '07'.                       " Bettenstellplatz
      WHEN '08'.                       " Behandelnde Person
      WHEN '09'.                       " Dokumente
      WHEN '10'.                       " Anforderung
      WHEN '14'.                       " Termin
        l_marked-tmnid    = s_ish_object-objectlow.
      WHEN '15'.                       " Vormerkung
        l_marked-vkgid    = s_ish_object-objectlow.
      WHEN '16'.                       " Vorl.Patient
        l_marked-papid    = s_ish_object-objectlow.
      WHEN '89'.                                            " MED-34502
        l_cposquestionid  = s_ish_object-objectlow.         " MED-34502
      WHEN '96'.                       " View ID
        l_view_id         = s_ish_object-objectlow.
      WHEN '97'.                       " View Type
        l_view_type       = s_ish_object-objectlow.
      WHEN '99'.                       " Var. Info
    ENDCASE.

    AT END OF objectset.
      IF NOT l_marked-vkgid IS INITIAL.
        APPEND l_marked TO lt_marked.
      ENDIF.
      CLEAR l_marked.
    ENDAT.
  ENDLOOP.

* Wenn keine Einträge markiert wurden, die Einrichtung aus dem
* globalen Feld übernehmen ...
  IF l_einri IS INITIAL.
    l_einri = g_institution.
  ENDIF.
  CHECK NOT l_einri IS INITIAL.

*>>> IXX-18332 FM
  e_func_done = false.
* check for patient authority
  PERFORM do_check_auth_pat_for_func
                      TABLES   t_messages
                      USING    lt_marked
                      CHANGING e_rc
                               e_func_done.
  IF e_rc > 0.
    EXIT.                            "--> raus
  ENDIF.
*  function executed ?
  IF e_func_done = true.
    EXIT.                            "--> raus
  ENDIF.

  e_func_done = true.
*<<< IXX-18332 FM

* Arbeitsumfeld ermittlen
  CALL FUNCTION 'ISH_WP_ACTIVE_VIEWS_TRANSFER'
    IMPORTING
      e_wplace_id  = l_wa_wplaceid
      e_view_id    = l_wa_viewid
      e_view_type  = l_wa_viewtype
      e_wplace_id2 = l_wa_wplaceid2
      e_view_id2   = l_wa_viewid2
      e_view_type2 = l_wa_viewtype2.
  IF l_view_id = l_wa_viewid AND l_view_type = l_wa_viewtype.
    l_wplaceid = l_wa_wplaceid.
  ELSEIF l_view_id = l_wa_viewid2 AND l_view_type = l_wa_viewtype2.
    l_wplaceid = l_wa_wplaceid2.
  ELSE.
    CLEAR l_wplaceid.
  ENDIF.

* ID 8977: Planende/Eintragende OE des Arbeitsumfelds lesen
  CLEAR l_planoe.
  IF NOT l_wplaceid IS INITIAL.
    SELECT SINGLE planoe FROM nwplace_001 INTO l_planoe
           WHERE  wplacetype  = '001'
           AND    wplaceid    = l_wplaceid.
  ENDIF.

* Feststellen welche Art von Einträgen markiert wurden
  CLEAR: l_cnt_app, l_cnt_patients, l_cnt_fall, l_cnt_vkg, l_cnt_pap.
  LOOP AT lt_marked INTO l_marked.
    IF NOT l_marked-patnr IS INITIAL.
      l_cnt_patients = l_cnt_patients + 1.
    ENDIF.
    IF NOT l_marked-falnr IS INITIAL.
      l_cnt_fall = l_cnt_fall + 1.
    ENDIF.
    IF NOT l_marked-vkgid IS INITIAL.
      l_cnt_vkg = l_cnt_vkg + 1.
    ENDIF.
    IF NOT l_marked-papid IS INITIAL.
      l_cnt_pap = l_cnt_pap + 1.
    ENDIF.
    IF NOT l_marked-tmnid IS INITIAL.
      l_cnt_app = l_cnt_app + 1.
    ENDIF.
  ENDLOOP.                             " lt_marked

* special handling for some functions
  CLEAR: lr_env, l_cr_own_env, lr_error.
  IF l_fcode = 'CORDP_STD'  OR
     l_fcode = 'CORDP_USER' OR
     l_fcode = 'CORDP_CORD' OR
     l_fcode = 'CORDP_CPOS' OR
     l_fcode = 'CORDP_CORA' OR
     l_fcode = 'CORDP_CPOA' OR
     l_fcode = 'CORD_CANC'  OR                              " ID 18657
     ( l_fcode     = 'SLCT'        AND
     ( i_fieldname = 'ICON_DOC'    OR
       i_fieldname = 'ICON_ANF'    OR                       " MED-34000
       i_fieldname = 'CPOSQUEST'   OR                       " MED-34502
       i_fieldname =  'MEDDOK_ICON' ) ).
*   create errorhandler + environment for some functions
    CREATE OBJECT lr_error.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        i_caller       = 'ISHMED_WP_VIEW_010_FUNC'
        i_npol_set     = on
      IMPORTING
        e_env_created  = l_cr_own_env
        e_rc           = e_rc
      CHANGING
        c_environment  = lr_env
        c_errorhandler = lr_error.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
*   create object list for some functions
    LOOP AT lt_marked INTO l_marked.
      CLEAR: l_rc, l_obj_mark.
      IF NOT l_marked-vkgid IS INITIAL.
        CALL METHOD cl_ishmed_prereg=>load
          EXPORTING
            i_mandt        = sy-mandt
            i_einri        = l_einri
            i_vkgid        = l_marked-vkgid
            i_environment  = lr_env
          IMPORTING
            e_instance     = l_obj_mark-obj_ordpos
            e_rc           = l_rc
          CHANGING
            c_errorhandler = lr_error.
      ENDIF.
      IF NOT l_marked-falnr IS INITIAL.
        CALL METHOD cl_ishmed_none_oo_nfal=>load
          EXPORTING
            i_einri        = l_einri
            i_falnr        = l_marked-falnr
          IMPORTING
            e_instance     = l_obj_mark-obj_case
            e_rc           = l_rc
          CHANGING
            c_errorhandler = lr_error.
      ENDIF.
      IF NOT l_marked-patnr IS INITIAL.
        CALL METHOD cl_ishmed_none_oo_npat=>load
          EXPORTING
            i_einri        = l_einri
            i_patnr        = l_marked-patnr
          IMPORTING
            e_instance     = l_obj_mark-obj_pat
            e_rc           = l_rc
          CHANGING
            c_errorhandler = lr_error.
      ENDIF.
      IF NOT l_marked-papid IS INITIAL.
        CLEAR l_pap_key.
        l_pap_key-papid = l_marked-papid.
        CALL METHOD cl_ish_patient_provisional=>load
          EXPORTING
            i_key               = l_pap_key
            i_environment       = lr_env
          IMPORTING
            e_instance          = l_obj_mark-obj_prov
          EXCEPTIONS
            missing_environment = 1
            not_found           = 2
            OTHERS              = 3.
        IF sy-subrc <> 0.
        ENDIF.
      ENDIF.
      CHECK l_rc = 0.
      IF NOT l_obj_mark IS INITIAL.
        APPEND l_obj_mark TO lt_obj_mark.
      ENDIF.
    ENDLOOP.                             " lt_marked
    LOOP AT lt_obj_mark INTO l_obj_mark.
      IF NOT l_obj_mark-obj_ordpos IS INITIAL.
        l_object-object = l_obj_mark-obj_ordpos.
        APPEND l_object TO lt_objects.
        CONTINUE.
      ENDIF.
      IF NOT l_obj_mark-obj_case IS INITIAL.
        l_object-object = l_obj_mark-obj_case.
        APPEND l_object TO lt_objects.
        CONTINUE.
      ENDIF.
      IF NOT l_obj_mark-obj_pat IS INITIAL.
        l_object-object = l_obj_mark-obj_pat.
        APPEND l_object TO lt_objects.
        CONTINUE.
      ENDIF.
      IF NOT l_obj_mark-obj_prov IS INITIAL.
        l_object-object = l_obj_mark-obj_prov.
        APPEND l_object TO lt_objects.
        CONTINUE.
      ENDIF.
    ENDLOOP.
*   set additional parameter for function
    CLEAR l_parameter.
    l_parameter-type  = '001'.                        " view id
    l_parameter-value = l_view_id.
    APPEND l_parameter TO lt_parameter.
    CLEAR l_parameter.
    l_parameter-type  = '002'.                        " view type
    l_parameter-value = l_view_type.
    APPEND l_parameter TO lt_parameter.
    CLEAR l_parameter.
    l_parameter-type  = '003'.                        " workplace id
    l_parameter-value = l_wplaceid.
    APPEND l_parameter TO lt_parameter.
    CLEAR l_parameter.
    l_parameter-type  = '004'.                        " workplace type
    l_parameter-value = '001'.
    APPEND l_parameter TO lt_parameter.
    CLEAR l_parameter.
    IF NOT l_planoe IS INITIAL.
      l_parameter-type  = '005'.                      " planning OU
      l_parameter-value = l_planoe.
      APPEND l_parameter TO lt_parameter.
    ENDIF.
  ENDIF.

* Hotspots auf der Vormerkliste aus dem Stationsarbeitsplatz
  IF l_fcode = 'SLCT'.
    CASE i_fieldname.
*     (Med.) Dokument vorhanden
      WHEN 'ICON_DOC' OR 'MEDDOK_ICON'.
        l_fcode = 'MDIS'.        " Display document(s)
        PERFORM check_hotspot(sapln1wp)                     " ID 10488
                             TABLES   t_messages
                             USING    'N1WP_DHS'
                                      l_einri
                                      l_wplaceid
                             CHANGING e_rc.
        CASE e_rc.
          WHEN 0.           " Aufruf Dokumentenübersicht
          WHEN 2.           " Aufruf Dokumentensicht
            e_rc = 0.
            l_fcode = 'DOKS_VIEW'.
          WHEN OTHERS.
            EXIT.
        ENDCASE.
*     Labordokument vorhanden
      WHEN 'LABDOK_ICON'.                                   " ID 10488
        l_fcode = 'LAB_DATA'.
*     Risikofaktoren vorhanden                                " ID 11887
      WHEN 'RISK_ICON'.
        e_func_done = false.
        e_function  = 'NP04'.
*       ID 20162: check authority for transaction code
        PERFORM check_tcode_authority IN PROGRAM sapmnpa0 USING 'NP04'
                                                                l_einri
                                                                l_auth.
        IF l_auth EQ false.
          e_function = 'NP05'.
        ENDIF.
        EXIT.
*     BEGIN MED-34000
      WHEN 'ICON_ANF'.
        CLEAR l_fcode.
        PERFORM check_hotspot(sapln1wp) TABLES   t_messages
                                        USING    'N1WP_AHS'
                                                 l_einri
                                                 l_wplaceid
                                        CHANGING l_rc.
        CASE l_rc.
          WHEN 0 OR 2.      " call clin.orders
            l_fcode = 'AUES_VIEW'.
          WHEN OTHERS.
            EXIT.
        ENDCASE.
*     END MED-34000
*     Feld Fragestellung Auftragsposition (MED-34502)
      WHEN 'CPOSQUEST'.
*       Langtext Fragestellung Auftragsposition
        IF l_cposquestionid IS NOT INITIAL.
          l_fcode = 'LTXT_SCR'.
        ELSE.
          EXIT.
        ENDIF.
      WHEN OTHERS.
*        l_fcode = i_fieldname.
    ENDCASE.
  ENDIF.

* change some function codes for execute OR set additional parameter
  CASE l_fcode.
    WHEN 'DOKS_VIEW'.
      l_fcode = 'VIEW'.
      CLEAR l_parameter.
      l_parameter-type  = '008'.
      l_parameter-value = '006'.            " viewtype documents
      APPEND l_parameter TO lt_parameter.
*   BEGIN MED-34000
    WHEN 'AUES_VIEW'.
      l_fcode = 'VIEW'.
      CLEAR l_parameter.
      l_parameter-type  = '008'.
      l_parameter-value = '004'.            " viewtype clin.orders
      APPEND l_parameter TO lt_parameter.
*   END MED-34000
    WHEN 'LTXT_SCR'.                                        " MED-34502
*     append function parameter: text type
      CALL METHOD cl_ishmed_cpos_question=>load
        EXPORTING
          i_cposquestionid = l_cposquestionid
          ir_environment   = lr_env
        IMPORTING
          er_instance      = lr_txtobject.
      IF lr_txtobject IS BOUND.
        CLEAR l_parameter.
        l_parameter-type  = '006'.
        l_parameter-value = 'P'.
        APPEND l_parameter TO lt_parameter.
        CLEAR l_parameter.
        l_parameter-type   = '000'.
        l_parameter-object = lr_txtobject.
        APPEND l_parameter TO lt_parameter.
      ELSE.
        EXIT.
      ENDIF.
  ENDCASE.

* Prüfen, ob die erlaubte Anzahl und Art von Einträgen markiert wurde
  PERFORM check_marked TABLES   t_messages
                       USING    l_cnt_patients
                                l_cnt_app
                                l_cnt_fall
                                l_cnt_vkg
                                l_cnt_pap
                                l_fcode
                       CHANGING e_rc.
  CHECK e_rc = 0.

* Aufruf der gewünschten Funktion
  CASE l_fcode.
*   print functions for clinical order
    WHEN 'CORDP_STD'  OR 'CORDP_USER' OR 'CORDP_CORD' OR 'CORDP_CPOS' OR
         'CORDP_CORA' OR 'CORDP_CPOA' OR 'VIEW' OR 'LTXT_SCR'.
      CALL METHOD cl_ishmed_functions=>execute
        EXPORTING
          i_fcode        = l_fcode
          i_einri        = l_einri
          i_caller       = 'ISHMED_WP_VIEW_010_FUNC'
          i_save         = on
          i_commit       = on
          i_enqueue      = on
          it_objects     = lt_objects
          it_parameter   = lt_parameter
        IMPORTING
          e_rc           = l_rc
          e_refresh      = e_refresh
        CHANGING
          c_errorhandler = lr_error
          c_environment  = lr_env.
      CASE l_rc.
        WHEN 0.
*         ok
        WHEN 2.
*         cancel
        WHEN OTHERS.
*         error
          e_rc = 1.
      ENDCASE.
*     destroy local environment
      IF l_cr_own_env = on.
        CALL METHOD cl_ish_utl_base=>destroy_env
          CHANGING
            cr_environment = lr_env.
      ENDIF.
*     get messages
      IF NOT lr_error IS INITIAL.
        CALL METHOD lr_error->get_messages
          IMPORTING
            t_messages = lt_messages.
        t_messages[] = lt_messages[].
      ENDIF.

*   cancel clinical order (ID 18657)
    WHEN 'CORD_CANC'.
      CALL METHOD lr_env->refresh.            "MED-31264
      LOOP AT lt_obj_mark INTO l_obj_mark
           WHERE obj_ordpos IS NOT INITIAL.
        CLEAR lr_corder.
        CALL METHOD l_obj_mark-obj_ordpos->get_corder
          EXPORTING
            ir_environment  = lr_env
          IMPORTING
            er_corder       = lr_corder
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = lr_error.
        CHECK l_rc = 0.
        CHECK lr_corder IS BOUND.
        l_object-object = lr_corder.
        APPEND l_object TO lt_cancel_obj.
      ENDLOOP.
      CHECK lt_cancel_obj[] IS NOT INITIAL.
      CALL METHOD cl_ish_environment=>cancel_objects
        EXPORTING
          it_objects            = lt_cancel_obj
          i_popup               = 'X'
          i_authority_check     = 'X'
          i_app_cancel          = 'X'
          i_srv_cancel          = 'X'
          i_vkg_cancel          = 'X'
          i_pap_cancel          = 'X'
          i_req_cancel          = 'X'
          i_movement_cancel     = '*'
          i_srv_with_app_cancel = '*'
          i_save                = on
          i_caller              = 'WPV010'
          i_last_srv_cancel     = on
          i_enqueue             = on
          i_commit              = on
        IMPORTING
          e_rc                  = l_rc
          e_no_cancel           = l_cancel
        CHANGING
          c_errorhandler        = lr_error.
      IF l_cancel = on.
*       cancel has been cancelled from the user => do not refresh
      ELSE.
        IF l_rc NE 0.
          e_rc = 1.
        ELSE.
          e_refresh = 2.  "refresh the whole list
        ENDIF.
      ENDIF.

**   Anforderung anlegen                                (REM ID 12821)
*    WHEN 'ANFI'.
*      PERFORM call_request_create  TABLES   t_messages
*                                   USING    lt_marked
*                                            l_einri
*                                   CHANGING e_rc
*                                            e_refresh.
*
**   Anforderungsübersicht                              (REM ID 12821)
*    WHEN 'ANFUE'.
*      PERFORM call_request_view TABLES   t_messages
*                                USING    lt_marked
*                                         l_einri
*                                CHANGING e_rc
*                                         e_refresh.

*   Fall zuordnen
    WHEN 'FALL'.
      PERFORM vkg_fall_assign   TABLES   t_messages
                                USING    lt_marked
                                         l_einri
                                CHANGING e_rc
                                         e_refresh.

*   Dokumentenliste
    WHEN 'MDIS'.
      PERFORM doc_list          TABLES   t_messages
                                USING    lt_marked
                                         l_einri
                                CHANGING e_rc
                                         e_refresh.
*   Dokumente anlegen
    WHEN 'MINS'.
      PERFORM doc_create        TABLES   t_messages
                                USING    lt_marked
                                         l_einri
                                CHANGING e_rc
                                         e_refresh.

**   Dokumentensicht (ID 10488)
*    WHEN 'DOKS_VIEW'.
*      PERFORM call_view(sapln1wp) TABLES   t_messages
*                                           t_ish_objects
*                                  USING    '006'
*                                           l_einri
*                                  CHANGING e_rc
*                                           e_refresh.

*   Laborkumulativbefund (ID 10488)
    WHEN 'LAB_DATA'.
      PERFORM call_lab_data     TABLES   t_messages
                                USING    lt_marked
                                CHANGING e_rc
                                         e_refresh.

*   Plantafel
    WHEN 'PLTM'.
      PERFORM vkg_plan_tafel    TABLES   t_messages
                                USING    lt_marked
                                         l_einri
                                         l_planoe
                                CHANGING e_rc
                                         e_refresh.
*   Tagesgenaue Planung
    WHEN 'PLKT'.
      PERFORM vkg_plan_tag      TABLES   t_messages
                                USING    lt_marked
                                         l_einri
                                CHANGING e_rc
                                         e_refresh.

*   Offene Punkte Patient
    WHEN 'POPT'.
      PERFORM pat_open_points   TABLES   t_messages
                                USING    lt_marked
                                         l_einri
                                CHANGING e_rc
                                         e_refresh.

*   Patientenorganizer
    WHEN 'PORG'.
      PERFORM pat_monitor       TABLES   t_messages
                                USING    lt_marked
                                         l_einri
                                CHANGING e_rc
                                         e_refresh.

*   Terminübersicht
    WHEN 'TMNL'.
      PERFORM pat_tmn_list      TABLES   t_messages
                                USING    lt_marked
                                         l_einri
                                CHANGING e_rc
                                         e_refresh.

**   Weiter (GO_NEXT)
*    WHEN 'GO_NEXT'.
*      PERFORM go_next_prev          USING    l_view_id
*                                             l_view_type
*                                             l_wplaceid
*                                             l_einri
*                                             on
*                                             off
*                                             off
*                                    CHANGING e_rc
*                                             e_refresh.
*
**   Zurück (GO_PREV)
*    WHEN 'GO_PREV'.
*      PERFORM go_next_prev          USING    l_view_id
*                                             l_view_type
*                                             l_wplaceid
*                                             l_einri
*                                             off
*                                             on
*                                             off
*                                    CHANGING e_rc
*                                             e_refresh.

*   Kalender (CALENDAR)
    WHEN 'CALENDAR'.
      PERFORM go_next_prev          USING    l_view_id
                                             l_view_type
                                             l_wplaceid
                                             l_einri
                                             off
                                             off
                                             on
                                    CHANGING e_rc
                                             e_refresh.

* ------------>
    WHEN OTHERS.
*     Keine Fehlermeldung, wenn FCode nicht hier bekannt ist;
*     er könnte für IS-H im Workplace bekannt sein ...
      e_func_done = false.
      EXIT.
  ENDCASE.

ENDFUNCTION.
