FUNCTION ishmed_wp_care_unit_list_func.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_FCODE) TYPE  RSEU1-FUNC
*"     VALUE(I_FIELDNAME) TYPE  LVC_FNAME OPTIONAL
*"     VALUE(I_LISTKZ) TYPE  RNWP_CARE_UNIT_LIST-LISTKZ
*"  EXPORTING
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"     VALUE(E_REFRESH) TYPE  N1FLD-REFRESH
*"     VALUE(E_FUNC_DONE) TYPE  ISH_TRUE_FALSE
*"     VALUE(E_FUNCTION) LIKE  RSEU1-FUNC
*"  TABLES
*"      T_ISH_OBJECTS TYPE  ISH_T_DRAG_DROP_DATA OPTIONAL
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------
  TYPES:
  BEGIN OF ty_obj_mark,
     obj_mov        TYPE REF TO cl_ishmed_none_oo_nbew,
     obj_app        TYPE REF TO cl_ish_appointment,         " ID 18200
     obj_case       TYPE REF TO cl_ishmed_none_oo_nfal,
     obj_pat        TYPE REF TO cl_ishmed_none_oo_npat,
     obj_prov       TYPE REF TO cl_ish_patient_provisional,
     obj_prereg     TYPE REF TO cl_ishmed_prereg,           "MED-42773
  END OF ty_obj_mark,
  tyt_obj_mark    TYPE STANDARD TABLE OF ty_obj_mark.

  DATA: s_ish_object  LIKE LINE OF t_ish_objects,
        lt_movements  TYPE ishmed_t_care_unit_list_head,
        l_movement    TYPE rnwp_care_unit_list_head,
        l_done        LIKE off,
        l_fcode       LIKE rseu1-func,
        l_func_code   TYPE n1fcode,
        l_wa_msg      LIKE bapiret2,
        l_dok_flag    TYPE c,
*        l_popup       TYPE c,           " Selektionsoption OP-Programm
        l_viewid      TYPE nviewid,
        l_viewtype    TYPE nviewtype,
        l_wplaceid    TYPE nwplaceid,
        l_einri       LIKE nfal-einri,
        l_rc          TYPE ish_method_rc,
        l_cr_own_env  TYPE ish_on_off,
        l_pap_key     TYPE rnpap-key,
        l_oepf        LIKE nbew-orgpf,  " Pflegerische OE
        l_planoe      TYPE norg-orgid,
        l_bewty       TYPE nbew-bewty,
        l_save        TYPE ish_on_off,
        l_commit      TYPE ish_on_off,
        l_enqueue     TYPE ish_on_off,
        l_ishmed_used TYPE i.

  DATA: lt_n1orgpar   LIKE TABLE OF n1orgpar WITH HEADER LINE,
        lt_selvar     TYPE TABLE OF rsparams,
        l_selvar      LIKE LINE OF lt_selvar.

  DATA: l_wa_wplaceid  TYPE nwplace-wplaceid,
        l_wa_viewid    TYPE nwview-viewid,
        l_wa_viewtype  TYPE nwview-viewtype,
        l_wa_wplaceid2 TYPE nwplace-wplaceid,
        l_wa_viewid2   TYPE nwview-viewid,
        l_wa_viewtype2 TYPE nwview-viewtype.

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        lr_environment   TYPE REF TO cl_ish_environment,
        lr_lock          TYPE REF TO cl_ishmed_lock,
        lt_obj_mark      TYPE tyt_obj_mark,
        l_obj_mark       LIKE LINE OF lt_obj_mark,
        lt_objects       TYPE ish_objectlist,
        l_object         LIKE LINE OF lt_objects,
        lt_parameter     TYPE ishmed_t_parameter,
        l_parameter      LIKE LINE OF lt_parameter,
        lt_messages      TYPE ishmed_t_bapiret2.

* ED, ID 20128: local data declarations -> BEGIN
  DATA: lt_fal_out  LIKE nfal OCCURS 1,
        l_exit      TYPE ish_on_off,
        l_fal       LIKE nfal,         "Case details
        lt_fal      LIKE nfal OCCURS 1,"Case table used for function
        l_errfal    LIKE sy-subrc.     "Check errors patient/case

  REFRESH: lt_fal_out, lt_fal.
* ED, ID 20128 -> END

  DATA: l_cancelled TYPE ish_on_off.      "Grill, med-31462

* Initialisierungen
  CLEAR: l_done, l_fcode, l_wa_msg, l_dok_flag, l_einri,
         l_oepf, l_viewid, l_viewtype, l_wplaceid, l_bewty.

  CLEAR:   t_messages, lt_movements, l_movement, lt_n1orgpar.
  REFRESH: t_messages, lt_movements, lt_n1orgpar, lt_selvar,
           lt_objects, lt_parameter, lt_obj_mark.

  l_fcode = i_fcode.

  e_function  = l_fcode.
  e_refresh   = 0.
  e_func_done = true.
  l_dok_flag  = off.

  l_enqueue   = on.
  l_commit    = on.
  l_save      = on.

  CREATE OBJECT lr_errorhandler.

  CALL FUNCTION 'MESSAGES_INITIALIZE'.

* Environment
  CLEAR: lr_environment, l_cr_own_env.
  CALL METHOD cl_ishmed_functions=>get_environment
    EXPORTING
      i_caller       = 'ISHMED_WP_CARE_UNIT_LIST_FUNC'
      i_npol_set     = on
    IMPORTING
      e_env_created  = l_cr_own_env
      e_rc           = e_rc
    CHANGING
      c_environment  = lr_environment
      c_errorhandler = lr_errorhandler.
  IF e_rc <> 0.
    EXIT.
  ENDIF.

* create lock object
  CREATE OBJECT lr_lock.

* Daten der markierten Bewegung übernehmen
* Falls keine Bewegung markiert wurde werden immer Einri, Orgpf, Orgfa
* belegt übergeben
  CLEAR l_obj_mark.
  SORT t_ish_objects BY objectset objectid.
  LOOP AT t_ish_objects INTO s_ish_object.
    CASE s_ish_object-objectid.
      WHEN '00'.                       " Einrichtung
        l_movement-einri = s_ish_object-objectlow.
        l_einri          = l_movement-einri.
      WHEN '01'.                       " Patient
        l_movement-patnr = s_ish_object-objectlow.
        IF l_fcode = 'CORDS' OR l_fcode = 'ACRE'   OR
           l_fcode = 'VKGC'  OR l_fcode = 'MEORDI' OR
           l_fcode = 'VPEF'  OR l_fcode = 'VPSF'   OR
           l_fcode = 'MEORDU' OR l_fcode = 'CR_ANAMN' OR    "MED-30727
           l_fcode = 'MEADMINBC' OR                         "KG, MED-40981
           l_fcode = 'CWD_DIS' OR                           "MED-46655
           l_fcode = 'N1SNSE1' OR                           "MED-50882
           l_fcode = 'N1SNSE2' OR                           "MED-50882
           l_fcode = 'N1SNSE3' OR                           "MED-50882
         ( l_fcode = 'SLCT' AND
         ( i_fieldname = 'ANF_ICON' OR
           i_fieldname = 'DOK_ICON' OR
           i_fieldname = 'CHDVER'   OR                      "KG, MED-43708
           i_fieldname = 'MEDDOK_ICON' ) ).
          IF NOT l_movement-patnr IS INITIAL.
            CALL METHOD cl_ishmed_none_oo_npat=>load
              EXPORTING
                i_einri        = l_einri
                i_patnr        = l_movement-patnr
              IMPORTING
                e_instance     = l_obj_mark-obj_pat
                e_rc           = l_rc
              CHANGING
                c_errorhandler = lr_errorhandler.
          ENDIF.
        ENDIF.
      WHEN '02'.                       " Fall
        l_movement-falnr = s_ish_object-objectlow.
        IF l_fcode = 'CORDS' OR l_fcode = 'ACRE'   OR
           l_fcode = 'VKGC'  OR l_fcode = 'MEORDI' OR
           l_fcode = 'VPEF'  OR l_fcode = 'VPSF'   OR
           l_fcode = 'MEORDU' OR l_fcode = 'CR_ANAMN' OR    "MED-30727
           l_fcode = 'MEADMINBC' OR                         "KG, MED-40981
           l_fcode = 'CWD_DIS' OR                           "MED-46655
           l_fcode = 'N1SNSE1' OR                           "MED-50882
           l_fcode = 'N1SNSE2' OR                           "MED-50882
           l_fcode = 'N1SNSE3' OR                           "MED-50882
         ( l_fcode = 'SLCT' AND
           ( i_fieldname = 'ANF_ICON' OR
             i_fieldname = 'DOK_ICON' OR
             i_fieldname = 'CHDVER'   OR                    "KG, MED-43708
             i_fieldname = 'MEDDOK_ICON' ) ).
          IF NOT l_movement-falnr IS INITIAL.
            CALL METHOD cl_ishmed_none_oo_nfal=>load
              EXPORTING
                i_einri        = l_einri
                i_falnr        = l_movement-falnr
              IMPORTING
                e_instance     = l_obj_mark-obj_case
                e_rc           = l_rc
              CHANGING
                c_errorhandler = lr_errorhandler.
          ENDIF.
        ENDIF.
      WHEN '03'.                       " Bewegung
        l_movement-lfdnr = s_ish_object-objectlow.
        IF l_fcode = 'CORDS' OR l_fcode = 'ACRE'   OR
           l_fcode = 'VKGC'  OR l_fcode = 'MEORDI' OR
           l_fcode = 'VPEF'  OR l_fcode = 'VPSF'   OR
           l_fcode = 'MEORDU' OR l_fcode = 'CR_ANAMN' OR    "MED-30727
           l_fcode = 'MEADMINBC' OR                         "KG, MED-40981
         ( l_fcode = 'SLCT' AND
         ( i_fieldname = 'ANF_ICON' OR
           i_fieldname = 'DOK_ICON' OR
           i_fieldname = 'MEDDOK_ICON' ) ).
          IF NOT l_movement-lfdnr IS INITIAL.
            CALL METHOD cl_ishmed_none_oo_nbew=>load
              EXPORTING
                i_einri        = l_einri
                i_falnr        = l_movement-falnr
                i_lfdnr        = l_movement-lfdnr
              IMPORTING
                e_instance     = l_obj_mark-obj_mov
                e_rc           = l_rc
              CHANGING
                c_errorhandler = lr_errorhandler.
          ENDIF.
        ENDIF.
      WHEN '04'.                       " Pfleg. OE
        l_movement-orgpf = s_ish_object-objectlow.
      WHEN '05'.                       " Fachl. OE
        l_movement-orgfa = s_ish_object-objectlow.
      WHEN '06'.                       "Zimmer
        l_movement-zimmr_mark = s_ish_object-objectlow.     " ID 14223
      WHEN '07'.                       "Bettenstellplatz
        l_movement-bett_mark = s_ish_object-objectlow.      " ID 14223
      WHEN '08'.                       "Behandelnde Person
      WHEN '09'.                       "Dokumente
      WHEN '10'.                       "Anforderung
      WHEN '13'.                       "Datum               " ID 14223
        l_movement-date_mark = s_ish_object-objectlow.      " ID 14223
      WHEN '14'.                       "Termin                HB 7904
        l_movement-tmnid = s_ish_object-objectlow.
*       ID 18200: make instance of appointment
        IF l_fcode = 'CORDS' OR l_fcode = 'ACRE'   OR
           l_fcode = 'VKGC'  OR l_fcode = 'MEORDI' OR
           l_fcode = 'VPEF'  OR l_fcode = 'VPSF'   OR
           l_fcode = 'MEORDU' OR l_fcode = 'CR_ANAMN' OR    "MED-30727
         ( l_fcode = 'SLCT' AND
         ( i_fieldname = 'ANF_ICON' OR
           i_fieldname = 'DOK_ICON' OR
           i_fieldname = 'MEDDOK_ICON' ) ).
          IF NOT l_movement-tmnid IS INITIAL.
            CALL METHOD cl_ish_appointment=>load
              EXPORTING
                i_tmnid        = l_movement-tmnid
                i_environment  = lr_environment
              IMPORTING
                e_rc           = l_rc
                e_instance     = l_obj_mark-obj_app
              CHANGING
                c_errorhandler = lr_errorhandler.
          ENDIF.
        ENDIF.
      WHEN '15'.                       "Vormerkung            HB 7904
        l_movement-vkgid = s_ish_object-objectlow.
        IF l_fcode = 'SLCT' AND i_fieldname = 'KZTXT'.      "MED-42773
          IF NOT l_movement-vkgid IS INITIAL.               "MED-42773
            CALL METHOD cl_ishmed_prereg=>load
              EXPORTING
                i_mandt        = sy-mandt
                i_einri        = l_einri
                i_vkgid        = l_movement-vkgid
                i_environment  = lr_environment
              IMPORTING
                e_instance     = l_obj_mark-obj_prereg
                e_rc           = l_rc
              CHANGING
                c_errorhandler = lr_errorhandler.           "MED-42773
          ENDIF.                                            "MED-42773
        ENDIF.                                              "MED-42773
      WHEN '16'.                       "ID vorl.Patient       HB 7904
        l_movement-papid = s_ish_object-objectlow.
        IF l_fcode = 'CORDS' OR l_fcode = 'ACRE'   OR
           l_fcode = 'VKGC'  OR l_fcode = 'MEORDI' OR
           l_fcode = 'VPEF'  OR l_fcode = 'VPSF'   OR
           l_fcode = 'MEORDU' OR l_fcode = 'CR_ANAMN' OR    "MED-30727
           l_fcode = 'MEADMINBC' OR                         "KG, MED-40981
         ( l_fcode = 'SLCT' AND
         ( i_fieldname = 'ANF_ICON' OR
           i_fieldname = 'DOK_ICON' OR
           i_fieldname = 'MEDDOK_ICON' ) ).
          IF NOT l_movement-papid IS INITIAL.
            CLEAR l_pap_key.
            l_pap_key-papid  = l_movement-papid.
            CALL METHOD cl_ish_patient_provisional=>load
              EXPORTING
                i_key         = l_pap_key
                i_environment = lr_environment
              IMPORTING
                e_instance    = l_obj_mark-obj_prov
              EXCEPTIONS
                OTHERS        = 0.
          ENDIF.
        ENDIF.
      WHEN '96'.
        l_viewid   = s_ish_object-objectlow.
      WHEN '97'.
        l_viewtype = s_ish_object-objectlow.
    ENDCASE.
    AT END OF objectset.
      l_movement-listkz = i_listkz.
      APPEND l_movement TO lt_movements.
      CLEAR l_movement.
      IF NOT l_obj_mark IS INITIAL.
        APPEND l_obj_mark TO lt_obj_mark.
      ENDIF.
      CLEAR l_obj_mark.
    ENDAT.
  ENDLOOP.

*>>> IXX-18332 FM
  e_func_done = false.
* check for patient authority
  PERFORM do_check_auth_pat_for_func
                      TABLES   t_messages
                      USING    lt_movements
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

* Objektliste erstellen
  LOOP AT lt_obj_mark INTO l_obj_mark.
    IF NOT l_obj_mark-obj_mov IS INITIAL.
      l_object-object = l_obj_mark-obj_mov.
      APPEND l_object TO lt_objects.
      CONTINUE.
    ENDIF.
    IF NOT l_obj_mark-obj_app IS INITIAL.                   " ID 18200
      l_object-object = l_obj_mark-obj_app.                 " ID 18200
      APPEND l_object TO lt_objects.                        " ID 18200
      CONTINUE.                                             " ID 18200
    ENDIF.                                                  " ID 18200
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
    IF NOT l_obj_mark-obj_prereg IS INITIAL.                "MED-42773
      l_object-object = l_obj_mark-obj_prereg.              "MED-42773
      APPEND l_object TO lt_objects.                        "MED-42773
      CONTINUE.                                             "MED-42773
    ENDIF.                                                  "MED-42773
  ENDLOOP.

* Vorbelegungen Einrichtung, ORGPF (falls nichts markiert)
  READ TABLE lt_movements INTO l_movement INDEX 1.
  l_einri = l_movement-einri.
  l_oepf  = l_movement-orgpf.

* ID 8505: Arbeitsumfeld ermittlen
  CALL FUNCTION 'ISH_WP_ACTIVE_VIEWS_TRANSFER'
    IMPORTING
      e_wplace_id  = l_wa_wplaceid
      e_view_id    = l_wa_viewid
      e_view_type  = l_wa_viewtype
      e_wplace_id2 = l_wa_wplaceid2
      e_view_id2   = l_wa_viewid2
      e_view_type2 = l_wa_viewtype2.
  IF l_viewid = l_wa_viewid AND l_viewtype = l_wa_viewtype.
    l_wplaceid = l_wa_wplaceid.
  ELSEIF l_viewid = l_wa_viewid2 AND l_viewtype = l_wa_viewtype2.
    l_wplaceid = l_wa_wplaceid2.
  ENDIF.

* ID 8505: Selektionsvariante ermitteln
  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_viewid   = l_viewid
      i_viewtype = l_viewtype
      i_caller   = 'LN1WPU03'
      i_placeid  = l_wplaceid
    TABLES
      t_selvar   = lt_selvar.

* ID 10894: Selektionskriterien auch in globale Felder stellen
  CLEAR: g_institution, g_key_date, g_key_time,
         g_history_period, g_planning_period.
  REFRESH: gr_treat_ou, gr_dept_ou, gr_room.
  LOOP AT lt_selvar INTO l_selvar.
    CASE l_selvar-selname.
      WHEN 'SE_EINRI'.
        g_institution     = l_selvar-low.
      WHEN 'KEYDATE'.
        g_key_date        = l_selvar-low.
      WHEN 'KEYTIME'.
        g_key_time        = l_selvar-low.
      WHEN 'HISTHORZ'.
        g_history_period  = l_selvar-low.
      WHEN 'PLANHORZ'.
        g_planning_period = l_selvar-low.
      WHEN 'R_TREAOU'.
        CHECK l_selvar-low NE space.
        MOVE-CORRESPONDING l_selvar TO gr_treat_ou.
        APPEND gr_treat_ou.
      WHEN 'R_DEPTOU'.
        CHECK l_selvar-low NE space.
        MOVE-CORRESPONDING l_selvar TO gr_dept_ou.
        APPEND gr_dept_ou.
      WHEN 'R_ROOM'.
        CHECK l_selvar-low NE space.
        MOVE-CORRESPONDING l_selvar TO gr_room.
        APPEND gr_room.
    ENDCASE.
  ENDLOOP.
* set the actual time for refreshing
  IF g_key_date EQ sy-datum.
    g_key_time = sy-uzeit.
  ENDIF.

* set additional parameter for function
  CLEAR l_parameter.
  l_parameter-type  = '001'.                        " view id
  l_parameter-value = l_viewid.
  APPEND l_parameter TO lt_parameter.
  CLEAR l_parameter.
  l_parameter-type  = '002'.                        " view type
  l_parameter-value = l_viewtype.
  APPEND l_parameter TO lt_parameter.
  CLEAR l_parameter.
  l_parameter-type  = '003'.                        " workplace id
  l_parameter-value = l_wplaceid.
  APPEND l_parameter TO lt_parameter.
  CLEAR l_parameter.
  l_parameter-type  = '004'.                        " workplace type
  l_parameter-value = '001'.
  APPEND l_parameter TO lt_parameter.

  SELECT SINGLE planoe FROM nwplace_001 INTO l_planoe
         WHERE  wplacetype  = '001'
         AND    wplaceid    = l_wplaceid.
  IF sy-subrc = 0 AND NOT l_planoe IS INITIAL.
    l_parameter-type  = '005'.                      " planning OU
    l_parameter-value = l_planoe.
    APPEND l_parameter TO lt_parameter.
*  ELSE.
*    IF l_oepf IS NOT INITIAL.
*      l_parameter-type  = '005'.                    " planning OU
*      l_parameter-value = l_oepf.
*      APPEND l_parameter TO lt_parameter.
*    ENDIF.
  ENDIF.

* Hotspots aus dem Stationsarbeitsplatz
  IF l_fcode = 'SLCT'.
*   ID 6423: Falls IS-H*MED inaktiv ist -> Meldung ausgeben
    PERFORM check_ishmed CHANGING l_ishmed_used.
    IF l_ishmed_used = false.
      CASE i_fieldname.
        WHEN 'DIAGNOSE'.
          e_function  = 'NP61'.   " IS-H Diagnosenerfassung
          e_func_done = false.
          EXIT.
        WHEN 'ORGPF_AKT'   OR 'BEH_ARZT'    OR 'BEH_ARZT_NAME'   OR
             'ANF_ICON'    OR 'KA_ICON'     OR 'PFL_ICON'        OR
             'PFLP_ICON'   OR 'DOK_ICON'    OR 'ICON_DOC'        OR
             'MEDDOK_ICON' OR 'LABDOK_ICON' OR 'PFLL_ICON'       OR
             'INFO_EXIT'   OR 'DATAG'       OR 'UZTAG'           OR
             'ORGAG'       OR 'BAUAG'       OR 'ORGZL'           OR
             'BAUZL'       OR 'FAT_TPAE'    OR 'FNAME'           OR
             'FSTATUS'     OR 'KZTXT'       OR 'EVAL_EXIST_ICON'.
          e_rc = 1.
*         Hotspot-Funktion nur möglich, wenn IS-H*MED aktiv ist
          PERFORM build_bapiret2(sapmn1pa)
                  USING 'S' 'NF1' '534' space space space space
                                        space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO t_messages.
          EXIT.
        WHEN OTHERS.
*         Felder von APPEND-Struktur zulassen!!!
*         (Int. Meldung 2771216 2001)
      ENDCASE.
    ENDIF.
    CASE i_fieldname.
      WHEN 'PATHWAY_STATE_ICON'.               "note 0773855
        e_func_done = false.
        e_function  = 'N2GU'.                "Patientenpfad bearbeiten
        EXIT.
      WHEN 'PATHWAY_PROPOSAL_ICON'.
        e_func_done = false.
        e_function  = 'N2GP'.                "Pfadvorschlag bearbeiten
        EXIT.
        WHEN'ADPAT_STATE_ICON'.               "Allergie bearbeiten
        e_func_done = false.
        e_function  = 'N2AD1'.
        EXIT.
      WHEN 'DIAGNOSE'.
        l_fcode = 'DIA'.
      WHEN 'ORGPF_AKT'.
        EXIT.
      WHEN 'BEH_ARZT'.
        EXIT.
      WHEN 'BEH_ARZT_NAME'.
        EXIT.
      WHEN 'ANF_ICON'.
        CLEAR l_fcode.   " = 'AUES'.
        PERFORM check_hotspot TABLES   t_messages
                              USING    'N1WP_AHS'
                                       l_einri
                                       l_wplaceid
                              CHANGING l_rc.
        CASE l_rc.
*          WHEN 0.           " Aufruf Anforderungsübersicht
**           does not exist anymore (since 4.72)
          WHEN 0 OR 2.      " Aufruf Anforderungssicht
            l_fcode = 'AUES_VIEW'.
          WHEN OTHERS.
            EXIT.
        ENDCASE.
      WHEN 'KA_ICON'.
        l_fcode = 'KAUE'.
      WHEN 'PFL_ICON'.
        l_fcode = 'PUPD'.
      WHEN 'PFLL_ICON'.
        l_fcode = 'N1PL'.
      WHEN 'PFLP_ICON'.
        l_fcode = 'N1P1'.
      WHEN 'EVAL_EXIST_ICON'.
        l_fcode = 'N1EVAL'.
      WHEN 'DOK_ICON' OR 'MEDDOK_ICON'.
        l_fcode = 'DOKS'.
        l_dok_flag = on.
        PERFORM check_hotspot TABLES   t_messages
                              USING    'N1WP_DHS'
                                       l_einri
                                       l_wplaceid
                              CHANGING l_rc.
        CASE l_rc.
          WHEN 0.           " Aufruf Dokumentenübersicht
          WHEN 2.           " Aufruf Dokumentensicht
            l_fcode = 'DOKS_VIEW'.
          WHEN OTHERS.
            EXIT.
        ENDCASE.
      WHEN 'LABDOK_ICON'.                                   " ID 10488
        l_fcode = 'LABK'.
      WHEN 'ICON_DOC'.
        l_fcode = '1+1'.               "Funktionscode den es nicht gibt
      WHEN 'INFO_EXIT'.
        l_fcode = 'DOKS'.
      WHEN 'KZTXT'.                    "IS-H-Feld: Bemerkung (ID 8281)
*        l_fcode = 'KZTXT'.                            " REM ID 13197
*       ID 13197: call admission
        e_function  = 'NP12'.   " IS-H Aufnahme ändern
        IF NOT l_movement-einri IS INITIAL AND
           NOT l_movement-falnr IS INITIAL AND
           NOT l_movement-lfdnr IS INITIAL.
          SELECT SINGLE bewty FROM nbew INTO l_bewty
                 WHERE  einri  = l_movement-einri
                 AND    falnr  = l_movement-falnr
                 AND    lfdnr  = l_movement-lfdnr.
          IF sy-subrc = 0.
            CASE l_bewty.
              WHEN '2'.
                e_function  = 'NP98'.   " IS-H Entlassung ändern
              WHEN '3'.
                e_function  = 'NV12'.   " IS-H Verlegung ändern
              WHEN '4'.
                e_function  = 'NP42'.   " IS-H Besuch ändern
              WHEN '6' OR '7'.
                e_function  = 'NP92'.   " IS-H Abwesenheit ändern
            ENDCASE.
          ENDIF.
        ELSEIF NOT l_movement-tmnid IS INITIAL AND
               NOT l_movement-vkgid IS INITIAL.             "MED-42773
*         call prereg
          l_fcode = 'CORDU'.                                "MED-42773
        ENDIF.
      WHEN 'BATMP_ICON'.
        l_fcode = 'BATMP'.
      WHEN OTHERS.                     "customer defined fields
        l_fcode = i_fieldname.
    ENDCASE.
  ENDIF.

* Prüfen, ob die erlaubte Anzahl Bewegungen markiert wurde
  PERFORM check_marked TABLES   t_messages
                       USING    lt_movements
                                l_fcode
                       CHANGING e_rc.
  CHECK e_rc = 0.

* Aufruf der gewünschten User-Exit-Funktion (wenn vorhanden)
* ID 7456: auch den FCODE 'DIA' an den User-Exit übergeben!
*  IF l_fcode = 'DIA' AND g_diagdisp = off.  " Standard-Fkt
**   1. Sonderfall Diagnosen: Das globale Kennzeichen G_DIAGDISP
**   gibt an, ob in der Diagnose der Standard-Wert oder der
**   User-Exit-Wert steht und dementsprechend soll die Standard-
**   oder User-Exit-Funktion aufgerufen werden
*    l_done = off.
*  ELSEIF l_fcode = 'DIA+'.
  IF l_fcode = 'DIA+'.
*   2. Sonderfall Diagnosen: Die Standard-Funktion zum Umsetzen
*   des globalen Kennzeichens G_DIAGDISP soll aufgerufen werden
    l_done = off.
  ELSE.
*   Bei allen anderen Funktionen wird zuerst versucht, eine
*   ev. vorhandene User-Exit-Funktion aufzurufen.
*   Wenn keine User-Exit-Funktion implementiert ist, dann wird
*   die Standard-Funktion aufgerufen
    PERFORM call_userexit_func TABLES   t_messages lt_selvar
                               USING    lt_movements
                                        l_fcode
                               CHANGING e_rc e_refresh l_done.
  ENDIF.

* Falls die User-Exit-Funktion erfolgreich aufgerufen wurde,
* braucht die Standard-Funktion nicht mehr aufgerufen werden
  CHECK l_done = off.

  IF l_fcode = 'OMON'.
    IF cl_ishmed_switch_check=>ishmed_edp( ) = on.          "MED-34721
      l_fcode = 'OPDWS'.
    ENDIF.                                                  "MED-34721
  ENDIF.

* change fcode or set additional parameter for some functions
  CASE l_fcode.
    WHEN 'ACRE' OR 'VKGC'.
      l_fcode = 'CORDI'.
*     MED-34863: set data refresh = OFF
      CLEAR l_parameter.
      l_parameter-type  = '036'.
      l_parameter-value = off.
      APPEND l_parameter TO lt_parameter.
    WHEN 'CORDS'.
      CLEAR l_parameter.
      l_parameter-type  = '008'.
      l_parameter-value = '004'.   " viewtype clinical orders
      APPEND l_parameter TO lt_parameter.
      CLEAR l_parameter.
      l_parameter-type  = '001'.                        " view id
      l_parameter-value = l_viewid.
      APPEND l_parameter TO lt_parameter.
      CLEAR l_parameter.
    WHEN 'AUES_VIEW'.
      l_fcode = 'VIEW'.
      CLEAR l_parameter.
      l_parameter-type  = '008'.
      l_parameter-value = '004'.            " viewtype clin.orders
      APPEND l_parameter TO lt_parameter.
    WHEN 'DOKS_VIEW'.
      l_fcode = 'VIEW'.
      CLEAR l_parameter.
      l_parameter-type  = '008'.
      l_parameter-value = '006'.            " viewtype documents
      APPEND l_parameter TO lt_parameter.
    WHEN 'OPDWS' OR 'SURGSELWS'.
      PERFORM get_op_for_dws TABLES   t_messages
                             USING    lt_movements
                                      lr_environment
                             CHANGING lt_objects
                                      e_rc.
      IF e_rc <> 0.
        IF l_cr_own_env = on.
          CALL METHOD cl_ish_utl_base=>destroy_env
            CHANGING
              cr_environment = lr_environment.
        ENDIF.
        EXIT.
      ENDIF.
* ED, ID 20128: NP51 -> BEGIN
    WHEN 'NP51'. "nursing category
      DESCRIBE TABLE lt_movements.
      IF sy-tfill = 1. "only if one movement!!
        READ TABLE lt_movements INTO l_movement
              INDEX 1.
        CLEAR l_fal.
*   Get detail data for case
        PERFORM get_case USING     l_movement
                         CHANGING  l_fal
                                   l_errfal.
        IF l_errfal = 0.
          IF l_fal-falar = '2'. "outpatient
            APPEND l_fal TO lt_fal_out.
            DELETE lt_movements
                   WHERE falnr = l_movement-falnr.
          ELSEIF l_fal-falar = '1'.
            APPEND l_fal TO lt_fal.
          ENDIF.
        ENDIF.

        l_exit = off.
        PERFORM set_case_in_table_popup USING
              lt_fal lt_fal_out l_exit.
        IF l_exit = on.
          e_refresh = 0. "no refresh
        ENDIF.
      ENDIF.
* ED, ID 20128 -> END

  ENDCASE.

* Aufruf der gewünschten Standard-Funktion
  CASE l_fcode.
*   clinical order (or request) insert (CORDI)
*   -> CORDI (ACRE+VKGC) is handled in ISH_WP_VIEW_010_FUNC now!!!
*   clinical order search (CORDS)
*   medication order create (MEORDI)
*   call view (VIEW)
*   vital signs / Vitalparameter Einzel-/Sammelerfassung (VPEF/VPSF)
*   OP workplace in DWS (OPDWS)
*   CWD_DIS (call Clinic WinData with patient)
*   N1SNSE* call electronical patient record application (SENSE) MED-50882
    WHEN 'CORDI' OR 'CORDS' OR 'MEORDI' OR 'VIEW' OR
         'VPEF'  OR 'VPSF'  OR 'OPDWS' OR
         'MEORDU' OR 'CR_ANAMN' OR 'SURGSELWS' OR           " MED-30727
         'MEADMINBC' OR 'CORDU' OR                          " KG, MED-40981 "MED-42773
         'N1SNSE1' OR 'N1SNSE2' OR 'N1SNSE3' OR             " MED-50882
         'CWD_DIS'.                                         " MED-46655
      l_func_code = l_fcode.
      CALL METHOD cl_ishmed_functions=>execute
        EXPORTING
          i_fcode        = l_func_code
          i_einri        = l_einri
          i_caller       = 'ISHMED_WP_CARE_UNIT_LIST_FUNC'
          i_save         = l_save
          i_commit       = l_commit
          i_enqueue      = l_enqueue
          it_objects     = lt_objects
          it_parameter   = lt_parameter
        IMPORTING
          e_rc           = e_rc
          e_func_done    = e_func_done
          e_refresh      = e_refresh
        CHANGING
          c_errorhandler = lr_errorhandler
          c_environment  = lr_environment
          c_lock         = lr_lock.
*   Nächster Tag (Next Day) MED-46307
    WHEN 'NDAY_123'.
      PERFORM go_next_prev          USING    l_viewid
                                             l_viewtype
                                             l_wplaceid
                                             l_einri
                                             on
                                             off
                                             off
                                    CHANGING e_rc
                                             e_refresh.

*   Voriger Tag (Previous Day) MED-46307
    WHEN 'PDAY_123'.
      PERFORM go_next_prev          USING    l_viewid
                                             l_viewtype
                                             l_wplaceid
                                             l_einri
                                             off
                                             on
                                             off
                                    CHANGING e_rc
                                             e_refresh.
*   Kalender (Calendar) MED-46307
    WHEN 'CALEND_123'.
      PERFORM go_next_prev          USING    l_viewid
                                             l_viewtype
                                             l_wplaceid
                                             l_einri
                                             off
                                             off
                                             on
                                    CHANGING e_rc
                                             e_refresh.
*   Switchen des Diagnose-Kennzeichens
    WHEN 'DIA+'.
      PERFORM check_uex_diag_display TABLES   t_messages lt_selvar
                                     USING    i_listkz      " ID 8690
                                     CHANGING e_rc.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
      IF g_diagdisp = on.
        g_diagdisp = off.              " Standard-Wert anzeigen
      ELSE.
        g_diagdisp = on.               " User-Exit-Wert anzeigen
      ENDIF.
      e_refresh = 2.                   " Gesamte Liste aktualisieren
*   Diagnosenübersicht
    WHEN 'DIA'.
      PERFORM call_diagnose TABLES   t_messages
                            USING    lt_movements
                            CHANGING e_rc          e_refresh.
**   Anforderungssicht (ID 7664)
*    WHEN 'AUES_VIEW'.
*      PERFORM call_view TABLES   t_messages    t_ish_objects
*                        USING    '004'         l_einri
*                        CHANGING e_rc          e_refresh.
**   Dokumentensicht (ID 7664)
*    WHEN 'DOKS_VIEW'.
*      PERFORM call_view TABLES   t_messages    t_ish_objects
*                        USING    '006'         l_einri
*                        CHANGING e_rc          e_refresh.
*   OP-Monitor aufrufen
    WHEN 'OMON'.
      PERFORM call_monitor_op TABLES   t_messages
                              USING    lt_movements
                                       lr_environment
                              CHANGING e_rc          e_refresh.
*   Laborkumulativbefund aufrufen
    WHEN 'LABK'.
      PERFORM call_labor_kum_bef TABLES   t_messages
                                 USING    lt_movements
                                 CHANGING e_rc          e_refresh.
*   Dokument erstellen / Dokumentenliste unterschiedliche Aufrufarten
    WHEN 'DCRE' OR 'DOKP' OR 'DOKL' OR 'DF01' OR 'DO01' OR 'DO02' OR
         'DH01' OR 'DH02' OR 'DH03'.
      PERFORM call_meddoku TABLES   t_messages
                           USING    lt_movements
                                    l_fcode
                           CHANGING e_rc
                                    e_refresh.
*   Dokumentenliste DOKF
    WHEN 'DOKF'.
      l_fcode = 'DOKL'.
      PERFORM call_meddoku TABLES   t_messages
                           USING    lt_movements
                                    l_fcode
                           CHANGING e_rc
                                    e_refresh.
*   Dokumentenliste DOKS
    WHEN 'DOKS'.
      CASE l_dok_flag.
        WHEN off.
          PERFORM read_n1orgpar(sapl0n1s) TABLES lt_n1orgpar
                                          USING l_einri    l_oepf
                                               'N1DOKLIST' sy-datum.
          READ TABLE lt_n1orgpar WITH KEY n1parid = 'N1DOKLIST'.
        WHEN on.
          PERFORM read_n1orgpar(sapl0n1s) TABLES lt_n1orgpar
                                          USING l_einri    l_oepf
                                                'N1DOK_KZ' sy-datum.
          READ TABLE lt_n1orgpar WITH KEY einri   = l_einri
                                          orgid   = l_oepf
                                          n1parid = 'N1DOK_KZ'.
      ENDCASE.
      l_dok_flag = off.
      CASE lt_n1orgpar-n1parwert.
        WHEN 'P'.                      "Dokumentenuebersicht Patbez
          l_fcode = 'DOKP'.
          PERFORM call_meddoku TABLES   t_messages
                               USING    lt_movements
                                        l_fcode
                               CHANGING e_rc
                                        e_refresh.
        WHEN 'F' OR ' '.               "Dokumentenuebersicht Fallbez
          l_fcode = 'DOKL'.
          PERFORM call_meddoku TABLES   t_messages
                               USING    lt_movements
                                        l_fcode
                               CHANGING e_rc
                                        e_refresh.
      ENDCASE.
*   Terminliste
    WHEN 'TMNL'.
      PERFORM call_termin_list TABLES   t_messages
                               USING    lt_movements
                               CHANGING e_rc          e_refresh.
*   Prioritäten Beschreibung
    WHEN '1+1'.
      PERFORM call_display_code TABLES   t_messages
                                USING    lt_movements
                                CHANGING e_rc          e_refresh.

*   Krankenakte Übersicht
    WHEN 'KAUE'.
      PERFORM call_patient_file TABLES   t_messages
                                USING    lt_movements
                                CHANGING e_rc          e_refresh.
*   Perinatalmonitor
    WHEN 'N1PM'.
      PERFORM call_perinatmonitor TABLES   t_messages
                                  USING    lt_movements
                                  CHANGING e_rc      e_refresh.
*   Wiederbestellung
    WHEN 'WIDB'.
      PERFORM call_wiederbestellung TABLES   t_messages
                                    USING    lt_movements
                                             l_planoe
                                             lr_environment
                                    CHANGING e_rc    e_refresh.
*   Termin f. Wiederholbesuch suchen
    WHEN 'WIDB_S'.
      PERFORM call_wiederbest_suchen TABLES   t_messages
                                     USING    lt_movements
                                              l_planoe
                                              lr_environment
                                     CHANGING e_rc    e_refresh.
*   Intensivmonitor
    WHEN 'IMON'.
      PERFORM call_intensivmonitor TABLES   t_messages
                                   USING    lt_movements
                                   CHANGING e_rc      e_refresh.
*   OP-Programm Allgemein
*   removed with 7.00 (do not delete coding until next release)
    WHEN 'OPPG'.
      PERFORM deactivate_program(sapln1on).                 " ID 19391
*      l_popup = off.
*      PERFORM call_opprogramm TABLES   t_messages
*                              USING    lt_movements
*                                       l_popup
*                              CHANGING e_rc          e_refresh.
*   OP-Programm mit Datums-Popup
*   removed with 7.00 (do not delete coding until next release)
    WHEN 'OPPD'.
      PERFORM deactivate_program(sapln1on).                 " ID 19391
*      l_popup = on.
*      PERFORM call_opprogramm TABLES   t_messages
*                              USING    lt_movements
*                                       l_popup
*                              CHANGING e_rc          e_refresh.
*   Offene Punkte Patient
    WHEN 'POPT'.
      PERFORM call_patient_open_issues TABLES   t_messages
                                       USING    lt_movements
                                                lr_environment
                                       CHANGING e_rc e_refresh.
*   Besuche/Folgebesuche Patient anzeigen
    WHEN 'BDIS'.
      PERFORM call_patient_visit TABLES   t_messages
                                 USING    lt_movements
                                          l_fcode
                                 CHANGING e_rc       e_refresh.
*   Besuche/Folgebesuche Patient anlegen
    WHEN 'BINS'.
      PERFORM call_patient_visit TABLES   t_messages
                                 USING    lt_movements
                                          l_fcode
                                 CHANGING e_rc       e_refresh.
*   Besuche/Folgebesuche Patient ändern
    WHEN 'BUPD'.
      PERFORM call_patient_visit TABLES   t_messages
                                 USING    lt_movements
                                          l_fcode
                                 CHANGING e_rc       e_refresh.
*   Nurse worklist
    WHEN 'APFL'.
      PERFORM call_nurse_worklist TABLES   t_messages
                                  USING    lt_movements
                                  CHANGING e_rc      e_refresh.
*   Enter services
    WHEN 'LNFU'.
      PERFORM call_clinical_services TABLES   t_messages
                                     USING    lt_movements
                                              l_fcode
                                              l_wplaceid
                                     CHANGING e_rc   e_refresh.
*   Display services
    WHEN 'LNFD'.
      PERFORM call_clinical_services TABLES   t_messages
                                     USING    lt_movements
                                              l_fcode
                                              l_wplaceid
                                     CHANGING e_rc    e_refresh.
*   Enter nursing services 1
    WHEN 'PUPD'.
      PERFORM call_clinical_services TABLES   t_messages
                                     USING    lt_movements
                                              l_fcode
                                              l_wplaceid
                                     CHANGING e_rc    e_refresh.
*   Display nursing services
    WHEN 'PDIS'.
      PERFORM call_clinical_services TABLES   t_messages
                                     USING    lt_movements
                                              l_fcode
                                              l_wplaceid
                                     CHANGING e_rc    e_refresh.
*   Enter nursing services 2
    WHEN 'NERF'.
      PERFORM call_clinical_services TABLES   t_messages
                                     USING    lt_movements
                                              l_fcode
                                              l_wplaceid
                                     CHANGING e_rc      e_refresh.
*   Nursing services hitlist
    WHEN 'HLPP'.
      PERFORM call_hlpp_services TABLES   t_messages
                                 USING    lt_movements
                                          l_fcode           "ID 19770
                                 CHANGING e_rc          e_refresh.
*   Nursing services hitlist post
    WHEN 'NHLPP'.                                           "ID 19770
      PERFORM call_hlpp_services TABLES   t_messages
                                 USING    lt_movements
                                          l_fcode
                                 CHANGING e_rc          e_refresh.
*   Nursing overview via transaction call
    WHEN 'N1LP'.
      PERFORM call_execute_transaction TABLES   t_messages
                                       USING    lt_movements
                                                l_fcode
                                       CHANGING e_rc    e_refresh.
*   Nursing plan (ID 6886)
    WHEN 'N1P1'.
      PERFORM call_nursing_plan TABLES   t_messages
                                USING    lt_movements
                                         'C'
                                CHANGING e_rc           e_refresh.
*   Nursing plan, create new (ID 6886)
    WHEN 'P1NW'.
      PERFORM call_nursing_plan TABLES   t_messages
                                USING    lt_movements
                                         'N'
                                CHANGING e_rc           e_refresh.
*   Nursing plan, show list of all plans (ID 6886)
    WHEN 'P1UE'.
      PERFORM call_nursing_plan TABLES   t_messages
                                USING    lt_movements
                                         'S'
                                CHANGING e_rc           e_refresh.
*   Nursing plan evaluation (MED-33285)
    WHEN 'N1EVAL'.
      PERFORM call_nrsplan_eval TABLES   t_messages
                                USING    lt_movements
                                         'E'
                                CHANGING e_rc           e_refresh.
*   Nurse services worklist
    WHEN 'N1PL'.
      PERFORM call_nurse_servicelist TABLES   t_messages
                                     USING    lt_movements
                                     CHANGING e_rc      e_refresh.
*   Nursing report
    WHEN 'PFVB'.
      PERFORM call_nursing_reportlist TABLES   t_messages
                                      USING    lt_movements
                                      CHANGING e_rc     e_refresh.
*   Nursing score planned
    WHEN 'PPR0'.
      PERFORM call_nursing_score TABLES   t_messages
                                 USING    lt_movements
                                 CHANGING e_rc          e_refresh.
*   Overview Services
    WHEN 'PLUE'.
      PERFORM call_services_overview TABLES   t_messages
                                     USING    lt_movements
                                     CHANGING e_rc      e_refresh.
*   Copy Services
    WHEN 'CPFL'.
      PERFORM call_copy_services TABLES   t_messages
                                 USING    lt_movements
                                 CHANGING e_rc          e_refresh.

**   Change Short Text of Movement - Bemerkung der Bewegung (ID 8281)
*    REM ID 13197
*    WHEN 'KZTXT'.
*      PERFORM call_nbew_kztxt_update  TABLES   t_messages
*                                      USING    lt_movements
*                                      CHANGING e_rc         e_refresh.
*   Patient transport order
*   PTRI = insert new transport order with patient
*   PTS_INSO = insert new transport order without patient
    WHEN 'PTRI' OR 'PTS_INSO'.
      PERFORM call_patient_transport_request
                            TABLES   t_messages
                            USING    lt_movements
                                     l_fcode
                            CHANGING e_rc          e_refresh.

*   Patient organizer OR patient history (ID 6543/6057) OR
*   Vitalparameter (Anzeigen - als Kurve im Patientenorg.) ID 9263
*   Ambulanzkarte  (im Patientenorganizer)                 ID 10186
*   Code 'N1NRSNOTE' = Pflegeverlaufsnotizen anzeigen      MED-41542
*   code 'N2IPPDNOTE' = stat. Pflegeverlaufsnotizen        MED-41695
    WHEN 'PORG' OR 'PHIS' OR 'VPPO' OR 'AMPO' OR
         'N1NRSNOTE' OR 'N2IPPDNOTE'.
      PERFORM call_patient_history  TABLES   t_messages
                                    USING    lt_movements
                                             l_fcode
                                    CHANGING e_rc         e_refresh
                                             lr_environment. " ID 14636
*   Patient profile only when NWBC is active
    WHEN 'N1IPC1'.
* <<< IXX-8750/MED-62681 Note 2414870
*      PERFORM call_patient_profile  TABLES   t_messages
*                                    USING    lt_movements
*                                             l_viewtype
*                                    CHANGING e_rc         e_refresh.
*
      cl_ishmed_ipc_call=>determine_context_and_navigate(
        EXPORTING
          it_ish_objects = t_ish_objects[]
        IMPORTING
          et_messages    = lt_messages ).

      IF lt_messages IS NOT INITIAL.
        APPEND LINES OF lt_messages TO t_messages[].
        e_rc = 1.

      ENDIF.
      e_refresh = 0.                        " MED-65204 Note 2514072 Bi
* >>> IXX-8750/MED-62681 Note 2414870

*   Temporäre Behandlungsaufträge
    WHEN 'BATMP'.
      PERFORM call_temptt_display   TABLES   t_messages
                                    USING    lt_movements
                                    CHANGING e_rc         e_refresh.

*-- begin Grill, med-31462
    WHEN 'CR_ADHOC'.

      READ TABLE lt_movements INTO l_movement INDEX 1.
      IF sy-subrc EQ 0.
        CALL FUNCTION 'ISHMED_ME_CALL_ADHOC_ADMIN_EVT'
          EXPORTING
            i_caller        = 'ISHMED_WP_VIEW_013_FUNC'
            i_einri         = l_movement-einri
            i_patnr         = l_movement-patnr
            i_falnr         = l_movement-falnr
            i_orgpf         = l_movement-orgpf
            i_orgfa         = l_movement-orgfa
            ir_environment  = lr_environment
          IMPORTING
            e_cancelled     = l_cancelled
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = lr_errorhandler.
        e_refresh = 2.
        e_func_done = 1.
      ENDIF.
*-- end Grill, med-31462

*   KG, MED-43708 - Begin
    WHEN 'CHDVER'.
      PERFORM call_me_view TABLES t_messages
                            USING l_einri
                                  lt_objects
                                  lt_parameter
                         CHANGING e_rc e_refresh.
      e_func_done = 1.
*   KG, MED-43708 - End

* <<< MED-64655 Note 2467596 Bi
   WHEN 'N1BMP'.  " Bundesmedikationsplan
     cl_ishmed_aid_med_plan=>call_from_cws(
        EXPORTING
          it_ish_objects  = t_ish_objects[]
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = lr_errorhandler ).

*    CWS can only handle errors with rc = 1 " MED-66198 Note 2556210 Bi
     IF e_rc GT 1.
       e_rc = 1.
     ENDIF.

     e_refresh    = 1.
     e_func_done  = true.
* >>> MED-64655 Note 2467596 Bi

*  RD, IXX-18141, HMVO, begin
   WHEN 'N3HMVO_OV'.  " Heilmittelverordnungsübersicht
     CL_ISH_HMVO_KLAP=>CALL_OV_FROM_KLAP(
        EXPORTING
          it_ish_objects  = t_ish_objects[]
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = lr_errorhandler ).

*    CWS can only handle errors with rc = 1 " MED-66198 Note 2556210 Bi
     IF e_rc GT 1.
       e_rc = 1.
     ENDIF.

     e_refresh    = 1.
     e_func_done  = true.
*    RD, IXX-18141, HMVO, end

    WHEN OTHERS.
*     Keine Fehlermeldung, wenn FCode nicht hier bekannt ist;
*     er könnte für IS-H im Workplace bekannt sein ...
      e_func_done = false.
  ENDCASE.

* Fichte, IXX-13797: In order to be able to add new functions in different
* teams at the same time without blocking each other, this method can be
* used to add functions in several classes. These classes have to implement
* interface IF_ISHMED_WP_FUNC
  IF e_func_done = '0'.
    CALL METHOD cl_ishmed_utl_wp_func=>execute_function
      EXPORTING
        i_fcode         = l_fcode
        i_view_id       = l_viewid
        i_view_type     = l_viewtype
        i_wplaceid      = l_wplaceid
        i_fieldname     = i_fieldname
        it_ish_objects  = t_ish_objects[]
      IMPORTING
        e_func_done     = e_func_done
        e_refresh       = e_refresh
        e_rc            = l_rc
      CHANGING
        ct_message      = t_messages[].
    IF l_rc <> 0.
      e_rc = 1.
    ENDIF.
  ENDIF.
* Fichte, IXX-13797 - End

* destroy local environment
  IF l_cr_own_env = on.
    CALL METHOD cl_ish_utl_base=>destroy_env
      CHANGING
        cr_environment = lr_environment.
  ENDIF.

* Fehler-Meldungen zurückgeben
  CALL METHOD lr_errorhandler->get_messages
    IMPORTING
      t_messages = lt_messages.
  LOOP AT lt_messages INTO l_wa_msg.
    APPEND l_wa_msg TO t_messages.
  ENDLOOP.

ENDFUNCTION.
