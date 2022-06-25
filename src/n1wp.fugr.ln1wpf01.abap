*----------------------------------------------------------------------*
***INCLUDE LN1WPF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_DIAGNOSE
*&---------------------------------------------------------------------*
FORM get_field_diagnose USING p_bew TYPE rnwp_care_unit_list.

  DATA: l_bew   LIKE nbew,
        h_bew   LIKE nbew,
        l_orgfa LIKE norg.
  DATA: l_ndia      LIKE ndia.

  DATA: $orgfa      LIKE nbew-orgfa.
  DATA: $diaty      LIKE ndia-ewdia.

  DATA: lt_nbew     LIKE TABLE OF nbew.
  DATA: lt_ndia     LIKE TABLE OF ndia.
  DATA: lt_orgfa    LIKE TABLE OF norg.

* get all diagnosis for that case
*  CLEAR p_bew-diagnose.                                 " REM ID 16135
  CLEAR lt_ndia. REFRESH lt_ndia.
  LOOP AT gt_ndia INTO l_ndia WHERE falnr = p_bew-falnr.
    APPEND l_ndia TO lt_ndia.
  ENDLOOP.

* exit if there are no diagnosis
  DESCRIBE TABLE lt_ndia.
  CHECK sy-tfill > 0.

* get all movements for that case
  CLEAR lt_nbew. REFRESH lt_nbew.
  LOOP AT gt_nbew INTO l_bew WHERE einri = p_bew-einri
                               AND falnr = p_bew-falnr.     "#EC *
    APPEND l_bew TO lt_nbew.
  ENDLOOP.

* get text of the diagnosis
  CLEAR l_bew.

* ID 7123: Bei Abgängen und Abwesenheiten sollen Diagnosen
*          für die 'alte' OE angezeigt werden
  READ TABLE gt_nbew INTO l_bew WITH TABLE KEY einri = p_bew-einri
                                               falnr = p_bew-falnr
                                               lfdnr = p_bew-lfdnr.
  IF p_bew-listkz = 'D' OR l_bew-bewty = '6' OR l_bew-bewty = '7'.
*   Suche die letzte Aufnahme-/Verlegungsbewegung
    CLEAR l_bew.
    PERFORM get_last_mov TABLES   lt_nbew
                         USING    p_bew-lfdnr
                         CHANGING l_bew.
  ELSE.
    CLEAR l_bew.
  ENDIF.

  IF l_bew IS INITIAL.
    l_bew-mandt = p_bew-mandt.
    l_bew-einri = p_bew-einri.
    l_bew-falnr = p_bew-falnr.
    l_bew-lfdnr = p_bew-lfdnr.
    l_bew-orgfa = p_bew-orgfa.
  ENDIF.

* Nur Diagnosen des entsprechenden Fachbereichs
  l_orgfa-orgid = l_bew-orgfa.
  APPEND l_orgfa TO lt_orgfa.

* get actual diagnosis for the dept. OU
* (Aktuelle Diagnose zm Fachbereich lesen)
  CALL FUNCTION 'ISHMED_READ_NDIA_AKTUELL'
    EXPORTING
      ss_nbew        = l_bew
      ss_refresh     = on
      ss_use_orgfa   = on
    IMPORTING
      ss_ndia        = l_ndia
    TABLES
      t_ndia         = lt_ndia
      t_nbew         = lt_nbew
      t_orgfa        = lt_orgfa
    EXCEPTIONS
      not_found_ndia = 01.
  IF sy-subrc EQ 0.
*   if the free text is initial, try to find the text for the
*   catalogue
    IF l_ndia-ditxt IS INITIAL.
      IF NOT l_ndia-dkey1 IS INITIAL.
        PERFORM find_nkdi USING    l_ndia-dkat1 l_ndia-dkey1
                          CHANGING l_ndia-ditxt.
      ELSE.
        IF NOT l_ndia-dkey2 IS INITIAL.
          PERFORM find_nkdi USING    l_ndia-dkat2 l_ndia-dkey2
                            CHANGING l_ndia-ditxt.
        ENDIF.
      ENDIF.
    ENDIF.
*   authority check, if the diagnosis can be shown
    IF l_ndia-lfdbew EQ l_bew-lfdnr.
      $orgfa = l_bew-orgfa.
    ELSE.
      READ TABLE lt_nbew INTO h_bew WITH KEY einri = l_ndia-einri
                                             falnr = l_ndia-falnr
                                             lfdnr = l_ndia-lfdbew.
      IF sy-subrc = 0.
        $orgfa = h_bew-orgfa.
      ELSE.
        SELECT SINGLE orgfa FROM nbew INTO $orgfa
          WHERE einri = l_ndia-einri
            AND falnr = l_ndia-falnr
            AND lfdnr = l_ndia-lfdbew.
        IF sy-subrc NE 0.
          CLEAR: $orgfa, l_bew.
        ENDIF.
      ENDIF.
    ENDIF.
    IF l_ndia-ewdia EQ on.
      $diaty = '1'.                    " Einweisungsdiagnose
    ELSE.
      $diaty = '2'.                    " Behandlungsdiagnose
    ENDIF.
    AUTHORITY-CHECK OBJECT 'N_NDIA_ORG'
              ID 'N_EINRI' FIELD l_ndia-einri
              ID 'N_ORGFA' FIELD $orgfa
              ID 'N_DIATY' FIELD $diaty
              ID 'N_DKAT1' FIELD l_ndia-dkat1
              ID 'N_DKEY1' FIELD l_ndia-dkey1
              ID 'N_DIASP' FIELD l_ndia-sperr
              ID 'ACTVT'   FIELD '03'.
    IF sy-subrc NE 0.
      l_ndia-ditxt(50) =
             'Keine Berechtigung zur Anzeige der Diagnose!'(001).
    ENDIF.
    p_bew-diagnose  = l_ndia-ditxt.
    p_bew-lfdnr_dia = l_ndia-lfdnr.                         " ID 8575
    p_bew-lfdnr_dia_tech = l_ndia-lfdnr.                    " MED-38816
  ENDIF.

ENDFORM.                               " GET_FIELD_DIAGNOSE

*&---------------------------------------------------------------------*
*&      Form  FIND_NKDI
*&---------------------------------------------------------------------*
FORM find_nkdi USING     VALUE(p_dkat)  LIKE nkdi-dkat
                         VALUE(p_dkey)  LIKE nkdi-dkey
               CHANGING  p_diag         LIKE ndia-ditxt.

  DATA: l_nkdi    TYPE ty_nkdi.

* get the diagnosis catalogue
  CLEAR p_diag.
  READ TABLE gt_nkdi INTO l_nkdi WITH TABLE KEY spras = sy-langu
                                                dkat  = p_dkat
                                                dkey  = p_dkey.
  IF sy-subrc = 0.
    p_diag = l_nkdi-dtext1.
  ELSE.
    SELECT SINGLE spras dkat dkey dtext1 FROM nkdi INTO l_nkdi
                    WHERE spras = sy-langu
                      AND dkat  = p_dkat
                      AND dkey  = p_dkey.
    IF sy-subrc = 0.
      INSERT l_nkdi INTO TABLE gt_nkdi.
      p_diag = l_nkdi-dtext1.
    ENDIF.
  ENDIF.

ENDFORM.                               " FIND_NKDI

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_ORGPF_AKT
*&---------------------------------------------------------------------*
FORM get_field_orgpf_akt USING p_bew TYPE rnwp_care_unit_list.

  DATA: help_oe LIKE norg-orgid,
        akt_bew LIKE nbew,
        lt_nbew LIKE TABLE OF nbew,
        l_bew   LIKE nbew,
        l_nfal  LIKE nfal,
        l_fal   TYPE ty_fal.


* get acutal treat. OU of the case (OE wo Patient aktuell liegt)

  CLEAR:   p_bew-orgpf_akt, akt_bew, help_oe, l_fal, l_nfal.
  REFRESH: lt_nbew.

  CHECK NOT p_bew-falnr IS INITIAL.                         " ID 9652

* get case
  READ TABLE gt_fal INTO l_fal WITH TABLE KEY falnr = p_bew-falnr.
  MOVE-CORRESPONDING l_fal TO l_nfal.                       "#EC ENHOK

* get all movements for that case
  LOOP AT gt_nbew INTO l_bew WHERE einri = p_bew-einri
                               AND falnr = p_bew-falnr.     "#EC *
    APPEND l_bew TO lt_nbew.
  ENDLOOP.
  DESCRIBE TABLE lt_nbew.
  IF sy-tfill = 0.
    SELECT * FROM nbew INTO TABLE lt_nbew
           WHERE  einri  = p_bew-einri
           AND    falnr  = p_bew-falnr.
  ENDIF.

  CALL FUNCTION 'ISHMED_SEARCH_ORGFA'
    EXPORTING
      i_falnr       = p_bew-falnr
      i_einri       = p_bew-einri
      i_orgpf       = help_oe  " dummy
      i_nfal        = l_nfal
      i_no_planb    = 'X'  "keine Planbewegungen "ED, ID 6872
    IMPORTING
      e_nbew        = akt_bew
    TABLES
      t_nbew        = lt_nbew
    EXCEPTIONS
      no_valid_nfal = 1
      no_valid_nbew = 2
      OTHERS        = 3.
  IF sy-subrc = 0.
    p_bew-orgpf_akt = akt_bew-orgpf.
  ELSE.
    p_bew-orgpf_akt = p_bew-orgpf.
  ENDIF.

ENDFORM.                               " GET_FIELD_ORGPF_AKT

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_BEH_ARZT
*&---------------------------------------------------------------------*
FORM get_field_beh_arzt USING p_bew TYPE rnwp_care_unit_list.

  DATA: l_nfpz  TYPE ty_nfpz,
        l_bew   TYPE nbew,                                  " ID 11443
        lt_nbew TYPE TABLE OF nbew.                         " ID 11443

* get the treating doctor for that case
  CLEAR p_bew-beh_arzt.

  CHECK NOT p_bew-falnr IS INITIAL.                         " ID 9652
  CHECK NOT p_bew-lfdnr IS INITIAL.                         " ID 9652

* ID 11443: Bei Abgängen und Abwesenheiten soll der Arzt für die 'alte'
*           OE angezeigt werden!
* get all movements for that case
  CLEAR lt_nbew. REFRESH lt_nbew.
  LOOP AT gt_nbew INTO l_bew WHERE einri = p_bew-einri
                               AND falnr = p_bew-falnr.     "#EC *
    APPEND l_bew TO lt_nbew.
  ENDLOOP.
  CLEAR l_bew.
  READ TABLE gt_nbew INTO l_bew WITH TABLE KEY einri = p_bew-einri
                                               falnr = p_bew-falnr
                                               lfdnr = p_bew-lfdnr.
  IF p_bew-listkz = 'D' OR l_bew-bewty = '6' OR l_bew-bewty = '7'.
*   Suche die letzte Aufnahme-/Verlegungsbewegung
    CLEAR l_bew.
    PERFORM get_last_mov TABLES   lt_nbew
                         USING    p_bew-lfdnr
                         CHANGING l_bew.
  ELSE.
    CLEAR l_bew.
  ENDIF.
  IF l_bew IS INITIAL.
    l_bew-mandt = p_bew-mandt.
    l_bew-einri = p_bew-einri.
    l_bew-falnr = p_bew-falnr.
    l_bew-lfdnr = p_bew-lfdnr.
  ENDIF.
* ID 11443: End of Insert

  READ TABLE gt_nfpz INTO l_nfpz WITH TABLE KEY einri = l_bew-einri
                                                falnr = l_bew-falnr.
  IF sy-subrc = 0.
*    p_bew-beh_arzt = l_nfpz-pernr.                      " REM ID 11443
    IF l_nfpz-lfdbw <> l_bew-lfdnr.
      READ TABLE gt_nfpz INTO l_nfpz WITH KEY einri = l_bew-einri
                                              falnr = l_bew-falnr
                                              lfdbw = l_bew-lfdnr.
      IF sy-subrc = 0.
        p_bew-beh_arzt = l_nfpz-pernr.
      ENDIF.
    ELSE.                                                   " ID 11443
      p_bew-beh_arzt = l_nfpz-pernr.                        " ID 11443
    ENDIF.
  ENDIF.

ENDFORM.                               " GET_FIELD_BEH_ARZT

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_BEH_ARZT_NAME
*&---------------------------------------------------------------------*
FORM get_field_beh_arzt_name USING p_bew TYPE rnwp_care_unit_list.

  DATA: l_ngpa    TYPE ty_ngpa,
        l_wa_ngpa LIKE ngpa,
        l_pnamec  TYPE ish_pnamec.

* get the name of the treating doctor ...
  CLEAR p_bew-beh_arzt_name.

* ... if there is one
  CHECK NOT p_bew-beh_arzt IS INITIAL.

  READ TABLE gt_ngpa INTO l_ngpa WITH TABLE KEY gpart = p_bew-beh_arzt.
  IF sy-subrc = 0.
    CLEAR l_wa_ngpa.
    MOVE-CORRESPONDING l_ngpa TO l_wa_ngpa.                 "#EC ENHOK
    CALL METHOD cl_ish_utl_base_gpa=>get_name_gpa
      EXPORTING
        i_gpart = l_wa_ngpa-gpart
        is_ngpa = l_wa_ngpa
        i_list  = on
      IMPORTING
        e_pname = l_pnamec.
    p_bew-beh_arzt_name = l_pnamec.
  ENDIF.

ENDFORM.                               " GET_FIELD_BEH_ARZT_NAME

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_ANF_ICON
*&---------------------------------------------------------------------*
FORM get_field_anf_icon USING p_bew TYPE rnwp_care_unit_list.

* check if there are clinical orders or requests for that patient
  CLEAR p_bew-anf_icon.

  CHECK NOT p_bew-patnr IS INITIAL.                         " ID 9652

  READ TABLE gt_cord WITH TABLE KEY patnr = p_bew-patnr
                     TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    p_bew-anf_icon = g_anf_icon.
    EXIT.
  ENDIF.

  READ TABLE gt_anf WITH TABLE KEY patnr = p_bew-patnr
                    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    p_bew-anf_icon = g_anf_icon.
  ENDIF.

ENDFORM.                               " GET_FIELD_ANF_ICON

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_KA_ICON
*&---------------------------------------------------------------------*
FORM get_field_ka_icon USING p_bew TYPE rnwp_care_unit_list.

* check if there are medical records for that patient
  CLEAR p_bew-ka_icon.

  CHECK NOT p_bew-patnr IS INITIAL.                         " ID 9652

  READ TABLE gt_ka WITH TABLE KEY patnr = p_bew-patnr
             TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    p_bew-ka_icon = g_ka_icon.
  ENDIF.

ENDFORM.                               " GET_FIELD_KA_ICON

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_PFL_ICON
*&---------------------------------------------------------------------*
FORM get_field_pfl_icon USING p_bew TYPE rnwp_care_unit_list.
  DATA: l_timestamp TYPE timestamp,                         "MED-54909
        l_psstamp   TYPE timestamp.

  FIELD-SYMBOLS: <ls_pfl_n1srv>  TYPE ty_pfl_n1srv.

* check if there are nursing services for that case
  CLEAR p_bew-pfl_icon.

  IF p_bew-patnr IS NOT INITIAL.
    IF g_check_ppd = abap_false.
      READ TABLE gt_pfl_n1srv WITH TABLE KEY patnr = p_bew-patnr
                 TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        p_bew-pfl_icon = g_pfl_icon.
        EXIT.
      ENDIF.
    ELSE.
*     Leer - keine Pflegeleistungen geplant
*     Grün - Pflegeleistungen freigegeben        (G_PFL_ICON_G)
*     Rot  - Pflegeleistungen überfällig         (G_PFL_ICON_R)
      IF gt_pfl_n1srv[] IS NOT INITIAL.
        LOOP AT gt_pfl_n1srv ASSIGNING <ls_pfl_n1srv>
                             WHERE patnr = p_bew-patnr.
          EXIT.
        ENDLOOP.
        IF sy-subrc = 0 AND <ls_pfl_n1srv>-psdat IS NOT INITIAL.
          GET TIME STAMP FIELD l_timestamp.

          CONVERT DATE <ls_pfl_n1srv>-psdat TIME <ls_pfl_n1srv>-pstim
                  INTO TIME STAMP l_psstamp TIME ZONE sy-zonlo.

          IF l_psstamp < l_timestamp.
            p_bew-pfl_icon = g_pfl_icon_r.
          ELSE.
            p_bew-pfl_icon = g_pfl_icon_g.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

  IF g_check_ppd = abap_false.
    IF p_bew-falnr IS NOT INITIAL.                          " ID 9652
      READ TABLE gt_pfl_nlem WITH TABLE KEY falnr = p_bew-falnr
                 TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        p_bew-pfl_icon = g_pfl_icon.
      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.                               " GET_FIELD_PFL_ICON

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_PFLL_ICON                          MED-29612
*&---------------------------------------------------------------------*
FORM get_field_pfll_icon USING p_bew TYPE rnwp_care_unit_list.

  DATA: ls_nlem     LIKE LINE OF gt_pfll_nlem,
        ls_nlei     TYPE nlei,
        ls_n1lssta  TYPE n1lssta,
        l_only_quit TYPE ish_on_off.

  STATICS: l_quit TYPE n1lssta-lsstae, " anw.spez. Wert für QUITTIERT
           l_stor TYPE n1lssta-lsstae. " anw.spez. Wert für STORNIERT

* check if there are nursing services for case and check state
  CLEAR p_bew-pfll_icon.

  CHECK p_bew-falnr IS NOT INITIAL.

* Ermittlung des anwenderspezifischen Werts für AUFGELÖST u. STORNIERT
  IF l_quit IS INITIAL OR l_quit EQ space OR
     l_stor IS INITIAL OR l_stor EQ space.
    SELECT * FROM n1lssta INTO ls_n1lssta
      WHERE einri  = g_institution
        AND lssta IN ('QU','ST')
        AND loekz  = off.
      CASE ls_n1lssta-lssta.
        WHEN 'QU'.
          l_quit = ls_n1lssta-lsstae.
        WHEN 'ST'.
          l_stor = ls_n1lssta-lsstae.
      ENDCASE.
    ENDSELECT.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
  ENDIF.

* Leer - keine Pflegeleistungen geplant
* Grün - Pflegeleistungen freigegeben        (G_PFLL_ICON_G)
* Rot  - Pflegeleistungen nicht freigegeben  (G_PFLL_ICON_R)

  l_only_quit = on.
  LOOP AT gt_pfll_nlem INTO ls_nlem WHERE falnr = p_bew-falnr.
    CHECK ls_nlem-lsstae <> l_stor.
    IF ls_nlem-lsstae <> l_quit.
      l_only_quit = off.
      EXIT.
    ENDIF.
  ENDLOOP.
  IF sy-subrc = 0.
    IF l_only_quit = off.
      p_bew-pfll_icon = g_pfll_icon_r.
    ELSE.
      p_bew-pfll_icon = g_pfll_icon_g.
    ENDIF.
  ENDIF.

ENDFORM.                               " GET_FIELD_PFLL_ICON

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_PFLP_ICON
*&---------------------------------------------------------------------*
FORM get_field_pflp_icon USING p_bew TYPE rnwp_care_unit_list.

  DATA: l_datum      LIKE sy-datum.
  DATA: l_wa_nlei    TYPE nlei.
  DATA: ls_n1nrsph   TYPE n1nrsph.
  DATA: l_n1pmn      TYPE n1orgpar-n1parwert.
  DATA: l_viewtype   TYPE nwview-viewtype.

* check if there is a nursing plan for the case
  CLEAR: p_bew-pflp_icon.
  CLEAR: l_n1pmn.

  l_datum = g_key_date + 1.

  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
    CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
      EXPORTING
        i_einri     = g_institution
        i_ou        = p_bew-orgpf
        i_par_name  = 'N1PMN'
      IMPORTING
        e_par_value = l_n1pmn.
  ENDIF.

  IF l_n1pmn IS NOT INITIAL.

    IF p_bew-patnr IS NOT INITIAL.
      READ TABLE gt_pflp_n1nrsph INTO ls_n1nrsph WITH KEY patnr = p_bew-patnr
                 BINARY SEARCH.
      IF sy-subrc EQ 0.
        LOOP AT gt_pflp_n1nrsph INTO ls_n1nrsph
             WHERE patnr     = p_bew-patnr
               AND end_date IS INITIAL.
          IF ls_n1nrsph-orgpf IN gr_treat_ou.
            CALL FUNCTION 'ISH_WP_ACTIVE_VIEWS_TRANSFER'
              IMPORTING
                e_view_type = l_viewtype.                                                          "MED-89026
            IF l_viewtype = '001' OR l_viewtype = '002'.                                           "MED-89026
              IF ls_n1nrsph-orgpf = p_bew-orgpf AND ls_n1nrsph-orgfa = p_bew-orgfa.                "MED-89026
                IF ls_n1nrsph-pupd_end_date >  ls_n1nrsph-pupd_start_date AND
                   ls_n1nrsph-pupd_end_date >= l_datum.
                  p_bew-pflp_icon = g_pflp_icon_f.  " Pfl.plan fertiggestellt
                ELSE.
                  p_bew-pflp_icon = g_pflp_icon_nf. " Pfl.plan noch nicht fertig
                ENDIF.
              ELSE.                                                                                "MED-89026
                p_bew-pflp_icon = g_pflp_icon_229. " Pflegeplan zu übernehmen                      "MED-89026
              ENDIF.                                                                               "MED-89026
            ELSE.                                                                                  "MED-89026
              IF ls_n1nrsph-pupd_end_date >  ls_n1nrsph-pupd_start_date AND
                 ls_n1nrsph-pupd_end_date >= l_datum.                                              "MED-89026
                p_bew-pflp_icon = g_pflp_icon_f.  " Pfl.plan fertiggestellt                        "MED-89026
              ELSE.                                                                                "MED-89026
                p_bew-pflp_icon = g_pflp_icon_nf. " Pfl.plan noch nicht fertig                     "MED-89026
              ENDIF.                                                                               "MED-89026
            ENDIF.                                                                                 "MED-89026
          ELSE.
            CALL FUNCTION 'ISH_WP_ACTIVE_VIEWS_TRANSFER'
              IMPORTING
                e_view_type = l_viewtype.
            IF l_viewtype = '003'.
              p_bew-pflp_icon = g_pflp_icon_230. " Pflegeplan bereits übernommen
            ELSE.
              p_bew-pflp_icon = g_pflp_icon_229. " Pflegeplan zu übernehmen
            ENDIF.
          ENDIF.
          EXIT.
        ENDLOOP.
      ELSE.
        CLEAR p_bew-pflp_icon.             " kein Pflegeplan vorhanden
      ENDIF.
    ENDIF.

  ELSE.

    IF g_n1pflank IS NOT INITIAL AND
      p_bew-falnr IS NOT INITIAL.                           " ID 9652
      READ TABLE gt_pflp_nlei INTO l_wa_nlei WITH KEY falnr = p_bew-falnr
                 BINARY SEARCH.
*     es wird der aktuell gültigste Pflegeplan pro Fall selektiert
      IF sy-subrc EQ 0.
        IF l_wa_nlei-storn = 'X'.
          p_bew-pflp_icon = g_pflp_icon_de. "Pflegeplan beendet
        ELSE.
          IF l_wa_nlei-iendt >  l_wa_nlei-ibgdt AND
             l_wa_nlei-iendt >= l_datum.    "id 5542, >= statt <=
            p_bew-pflp_icon = g_pflp_icon_f. " Pfl.plan fertiggestellt
          ELSE.
            p_bew-pflp_icon = g_pflp_icon_nf." Pfl.plan noch nicht fertig
          ENDIF.
        ENDIF.
      ELSE.
        CLEAR p_bew-pflp_icon.             " kein Pflegeplan vorhanden
      ENDIF.
    ENDIF.

  ENDIF.

ENDFORM.                               " GET_FIELD_PFLP_ICON

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_EVAL_ICON
*&---------------------------------------------------------------------*
FORM get_field_eval_icon USING p_bew TYPE rnwp_care_unit_list.

  DATA: ls_eval_pat LIKE LINE OF gt_eval_pat.

  CLEAR p_bew-eval_exist_icon.

  DESCRIBE TABLE gt_eval_pat.
  IF sy-tfill = 0.
    EXIT.
  ENDIF.

  IF p_bew-patnr IS NOT INITIAL.
    READ TABLE gt_eval_pat INTO ls_eval_pat
      WITH KEY patnr = p_bew-patnr.
    IF sy-subrc = 0.
      IF ls_eval_pat-eval_wa-plan_date < sy-datum OR
         ( ls_eval_pat-eval_wa-plan_date = sy-datum AND ls_eval_pat-eval_wa-plan_time < sy-uzeit ).
        p_bew-eval_exist_icon = g_eval_icon_f.
      ELSEIF ls_eval_pat-eval_wa-plan_date = sy-datum AND ls_eval_pat-eval_wa-plan_time >= sy-uzeit.
        p_bew-eval_exist_icon = g_eval_icon_o.
      ELSEIF ls_eval_pat-eval_wa-plan_date > sy-datum.
        p_bew-eval_exist_icon = g_eval_icon_k.
      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.                    "get_field_eval_icon

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_DOK_ICON
*&---------------------------------------------------------------------*
FORM get_field_dok_icon USING p_bew TYPE rnwp_care_unit_list.

* check if there are documents for that case
  CLEAR p_bew-dok_icon.

  CHECK NOT p_bew-falnr IS INITIAL.                         " ID 9652

  READ TABLE gt_dok WITH TABLE KEY falnr = p_bew-falnr
             TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    p_bew-dok_icon = g_dok_icon.
  ENDIF.

ENDFORM.                               " GET_FIELD_DOK_ICON

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_MEDDOK_ICON                         ID 10488
*&---------------------------------------------------------------------*
FORM get_field_meddok_icon USING p_bew TYPE rnwp_care_unit_list.

  DATA: l_dok   TYPE ty_dok.

* check if there are medical documents for that case
  CLEAR p_bew-meddok_icon.

  CHECK NOT p_bew-falnr IS INITIAL.

  READ TABLE gt_dok INTO l_dok WITH TABLE KEY falnr = p_bew-falnr.
  IF sy-subrc = 0 AND l_dok-meddok = on.
    p_bew-meddok_icon = g_meddok_icon.
  ENDIF.

ENDFORM.                               " GET_FIELD_MEDDOK_ICON

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_LABDOK_ICON                         ID 10488
*&---------------------------------------------------------------------*
FORM get_field_labdok_icon USING p_bew TYPE rnwp_care_unit_list.

  DATA: l_dok   TYPE ty_dok.

* check if there are labor documents for that case
  CLEAR p_bew-labdok_icon.

  CHECK NOT p_bew-falnr IS INITIAL.

  READ TABLE gt_dok INTO l_dok WITH TABLE KEY falnr = p_bew-falnr.
  IF sy-subrc = 0 AND l_dok-labdok = on.
    p_bew-labdok_icon = g_labdok_icon.
  ENDIF.

ENDFORM.                               " GET_FIELD_LABDOK_ICON

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_ICON_DOC
*&---------------------------------------------------------------------*
FORM get_field_icon_doc USING p_bew TYPE rnwp_care_unit_list.

  DATA: l_n2flag   TYPE ty_n2flag.

* get icon-document
  CLEAR p_bew-icon_doc.

  CHECK NOT p_bew-falnr IS INITIAL.                         " ID 9652

  READ TABLE gt_n2flag INTO l_n2flag WITH TABLE KEY falnr = p_bew-falnr.
  IF sy-subrc = 0.
    p_bew-icon_doc = l_n2flag-icon.
  ENDIF.

ENDFORM.                               " GET_FIELD_ICON_DOC

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_INFO_EXIT
*&---------------------------------------------------------------------*
FORM get_field_info_exit USING p_bew TYPE rnwp_care_unit_list.

* get additional information from the user-exit
  CLEAR p_bew-info_exit.

* only filled from User-Exit !

ENDFORM.                               " GET_FIELD_INFO_EXIT

*&---------------------------------------------------------------------*
*&      Form  GET_FIELDS_FAT
*&---------------------------------------------------------------------*
FORM get_fields_fat USING p_bew TYPE rnwp_care_unit_list.

  DATA: l_n1fat    TYPE ty_fat,
        l_found    LIKE off,
        l_n1tat    TYPE n1tat,
        l_n1transt TYPE n1transt.

  STATICS: lt_n1tat    TYPE HASHED TABLE OF n1tat
                            WITH UNIQUE KEY spras einri tpae.

  STATICS: lt_n1transt TYPE HASHED TABLE OF n1transt
                            WITH UNIQUE KEY spras einri trans.

* get fields of transport order
  CLEAR: p_bew-fatid, p_bew-datag, p_bew-uztag,
         p_bew-orgag, p_bew-bauag, p_bew-fat_tpae, p_bew-fat_tpatx,
         p_bew-orgzl, p_bew-bauzl, p_bew-fname, p_bew-fstatus,
         p_bew-trans, p_bew-trava_icon, p_bew-transtxt.

  CHECK NOT p_bew-patnr IS INITIAL OR                       " ID 9652
        NOT p_bew-papid IS INITIAL.

  CHECK NOT p_bew-orgpf IS INITIAL.                         " ID 9652

* ID 8961: get texts of transport types
  DESCRIBE TABLE lt_n1tat.
  IF sy-tfill = 0.
    SELECT * FROM n1tat INTO TABLE lt_n1tat
           WHERE  spras  = sy-langu.
  ENDIF.

* get texts for means of transportation
  DESCRIBE TABLE lt_n1transt.
  IF sy-tfill = 0.
    SELECT * FROM n1transt INTO TABLE lt_n1transt
           WHERE  spras  = sy-langu.
  ENDIF.

  l_found = off.
  LOOP AT gt_n1fat INTO l_n1fat WHERE patnr = p_bew-patnr
                                AND   papid = p_bew-papid
                                AND   orgag = p_bew-orgpf
                                OR    patnr = p_bew-patnr   " ID 7101
                                AND   papid = p_bew-papid   " ID 7101
                                AND   orgzl = p_bew-orgpf.  " ID 7101
    READ TABLE gt_n1fst WITH TABLE KEY fstid = l_n1fat-fstid
               TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      p_bew-orgag     = l_n1fat-orgag.
      p_bew-bauag     = l_n1fat-bauag.
      p_bew-orgzl     = l_n1fat-orgzl.
      p_bew-bauzl     = l_n1fat-bauzl.
      IF l_n1fat-tptyp = '1'.                               " ID 7101
        p_bew-datag   = l_n1fat-datag.
        p_bew-uztag   = l_n1fat-uztag.
      ELSE.                                                 " ID 7101
        p_bew-datag   = l_n1fat-datzl.
        p_bew-uztag   = l_n1fat-uztzl.                      " ID 7101
      ENDIF.                                                " ID 7101
      p_bew-fat_tpae  = l_n1fat-tpae.
      p_bew-fatid     = l_n1fat-fatid.
      p_bew-fname     = l_n1fat-fname.
      p_bew-fstatus   = l_n1fat-fstat.
*     ID 8961: get text of transport type
      READ TABLE lt_n1tat INTO l_n1tat
                 WITH TABLE KEY spras = sy-langu
                                einri = l_n1fat-einri
                                tpae  = l_n1fat-tpae.
      IF sy-subrc = 0.
        p_bew-fat_tpatx = l_n1tat-tpatxt.
      ENDIF.
      p_bew-trans     = l_n1fat-trans.
      IF l_n1fat-trava = on.
        p_bew-trava_icon = g_trava_icon.
      ENDIF.
      IF l_n1fat-trans IS NOT INITIAL.
        READ TABLE lt_n1transt INTO l_n1transt
                   WITH TABLE KEY spras = sy-langu
                                  einri = l_n1fat-einri
                                  trans = l_n1fat-trans.
        IF sy-subrc = 0.
          p_bew-transtxt = l_n1transt-transtxt.
        ENDIF.
      ENDIF.
      l_found = on.
      EXIT.
    ENDIF.
  ENDLOOP.
  IF l_found = off.
    p_bew-uztag = '        '.          " nicht 00:00 anzeigen
  ENDIF.

ENDFORM.                               " GET_FIELDS_FAT

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_BATMP_ICON
*&---------------------------------------------------------------------*
FORM get_field_batmp_icon USING p_bew TYPE rnwp_care_unit_list.

  CHECK p_bew-patnr IS NOT INITIAL OR p_bew-falnr IS NOT INITIAL. "MED-34421

* check if there are temp. TCs for that case/patient
  CALL FUNCTION 'ISH_N2_TEMPTT_CHECK'
    EXPORTING
      im_einri  = p_bew-einri
      im_patnr  = p_bew-patnr
      im_falnr  = p_bew-falnr
    EXCEPTIONS
      no_temptc = 1
      error     = 2
      OTHERS    = 3.
  IF sy-subrc = 0.
    p_bew-batmp_icon = g_batmp_icon.
  ENDIF.

ENDFORM.                               " GET_FIELD_BATMP_ICON

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_KA
*&---------------------------------------------------------------------*
FORM fill_table_ka.

  DATA: l_ka   TYPE ty_ka.

* get medical record information (Krankenakten)
  CLEAR gt_ka. REFRESH gt_ka.

  DESCRIBE TABLE gt_pat.                                    " ID 9652
  CHECK sy-tfill > 0.                                       " ID 9652

  SELECT patnr dokar FROM ndoc INTO TABLE gt_ka
         FOR ALL ENTRIES IN gt_pat
         WHERE patnr EQ gt_pat-patnr
           AND einri EQ gt_pat-einri
           AND medok EQ space
           AND storn EQ off
           AND loekz EQ off.
  IF sy-subrc = 0.
*   Berechtigungsprüfung, ob Benutzer für die Dokumentart zumindest
*   die Anzeige-Berechtigung hat
    LOOP AT gt_ka INTO l_ka.
      AUTHORITY-CHECK OBJECT 'C_DRAW_TCD'
          ID 'DOKAR'  FIELD l_ka-dokar
          ID 'ACTVT'  FIELD '03'.
      CHECK sy-subrc NE 0.
      DELETE TABLE gt_ka FROM l_ka.
    ENDLOOP.
  ENDIF.

ENDFORM.                               " FILL_TABLE_KA

*&---------------------------------------------------------------------*
*&      Form  fill_table_pfl_nlem
*&---------------------------------------------------------------------*
FORM fill_table_pfl_nlem .

  DATA: ppr_dbeg  LIKE tnppr-ppr_dbeg. " Dienstbeginn für PPR-Erfassung
  DATA: ppr_dend  LIKE tnppr-ppr_dend. " Dienstende   für PPR-Erfassung

  STATICS: a_aufg LIKE n1lssta-lsstae. " anw.spez. Wert für AUFGELÖST
  STATICS: a_stor LIKE n1lssta-lsstae. " anw.spez. Wert für STORNIERT
*                                                            "MED-56791
  STATICS: a_ange LIKE n1lssta-lsstae. " anw.spez. Wert für ANGEORDNET
  STATICS: a_erbr LIKE n1lssta-lsstae. " anw.spez. Wert für ERBRACHT
*  CONSTANTS:
*    co_ao  TYPE n1lsstae VALUE 'AO',       " Wert angeordnet
*    co_don TYPE n1lsstae VALUE 'DON'.      " Wert erbracht

  DATA: s_datum   LIKE nlei-ibgdt.

  DATA: l_n1lssta LIKE n1lssta,
        l_tnppr   LIKE tnppr.

  RANGES: r_zeit  FOR  nlei-ibzt.

  DATA:   l_tn00r       LIKE tn00r,                         "MED-54909
          l_ishmed_used TYPE i,
          l_end_date    TYPE n1nrsph_end_date,
          l_n1pmn       TYPE n1orgpar-n1parwert,
          l_orgpf       TYPE nbew-orgpf.
  RANGES lr_orgpf       FOR nbew-orgpf.

  DATA:  l_n1nrsservp      TYPE n1parwert. "MED-83195

* get nursing service information (Pflegeleistungen)
  CLEAR gt_pfl_nlem. REFRESH gt_pfl_nlem.
  CLEAR gt_pfl_n1srv. REFRESH gt_pfl_n1srv.

* Zeitraum: aktueller Tag + 1 (akt. Tag = Selektionsdatum)
  CLEAR s_datum.
* NUR Selektionsdatum + 1
  s_datum = g_key_date + 1.

* Ermittlung des anwenderspezifischen Werts für AUFGELÖST u. STORNIERT
* ANGEORDNET u. ERBRACHT
  IF a_aufg IS INITIAL OR a_aufg EQ space OR
     a_stor IS INITIAL OR a_stor EQ space OR
     a_ange IS INITIAL OR a_ange EQ space OR                 "MED-56791
     a_erbr IS INITIAL OR a_erbr EQ space.
    SELECT * FROM n1lssta INTO l_n1lssta
      WHERE einri = g_institution
        AND lssta IN ('AL','ST','AO','ER')
        AND loekz = off.
      CASE l_n1lssta-lssta.
        WHEN 'AL'.
          a_aufg = l_n1lssta-lsstae.
        WHEN 'ST'.
          a_stor = l_n1lssta-lsstae.
        WHEN 'AO'.
          a_ange = l_n1lssta-lsstae.
        WHEN 'ER'.
          a_erbr = l_n1lssta-lsstae.
      ENDCASE.
    ENDSELECT.
    IF sy-subrc NE 0.
      EXIT.
    ENDIF.
  ENDIF.

* BEGIN MED-83195
 CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
    EXPORTING
      i_einri     = g_institution
      i_ou        = '*'
      i_par_name  = cl_ishmed_orgpar_n1nrsservp=>c_parid_n1nrsservp
    IMPORTING
      e_par_value = l_n1nrsservp.
* END MED-83195

IF l_n1nrsservp EQ ' '.       "MED-83195
* Dienstbeginn und Dienstende für PPR-Erfassung lesen
  SELECT * FROM tnppr INTO l_tnppr
           WHERE einri EQ g_institution
             AND begdt LE g_key_date
             AND enddt GE g_key_date.
    ppr_dbeg = l_tnppr-ppr_dbeg.
    ppr_dend = l_tnppr-ppr_dend.
    EXIT.
  ENDSELECT.

* Zeitpunkt: Dienstbeginn bis Dienstende für PPR-Erfassung
  CLEAR r_zeit.  REFRESH r_zeit.
  r_zeit-sign   = 'I'.
  r_zeit-option = 'BT'.
  r_zeit-low    = ppr_dbeg.
  r_zeit-high   = ppr_dend.
  APPEND r_zeit.
ELSE.                           "MED-83195
* ignore nursing duty times
  CLEAR r_zeit.  REFRESH r_zeit."MED-83195
  r_zeit-sign   = 'I'.          "MED-83195
  r_zeit-option = 'BT'.         "MED-83195
  r_zeit-low    = '000001'.     "MED-83195
  r_zeit-high   = '235959'.     "MED-83195
  APPEND r_zeit.                "MED-83195
ENDIF.                          "MED-83195

  DESCRIBE TABLE gt_fal.                                    " ID 9652
  IF sy-tfill > 0.                                          " ID 9652
*   Ermittlung all jener Leistungen aus der NLEM, deren IBGDT zwischen
*   dem aktuellen Tag + 1 liegen und nicht storniert sind und deren
*   IBZT zwischen PPR_DBEG und PPR_DEND liegen (Dienstbeginn und -ende
*   für die PPR-Erfassung)
*    SELECT falnr ibgdt ibzt lsstae lnrls
*           FROM nlem INTO TABLE gt_pfl_nlem
*           FOR ALL ENTRIES IN gt_fal
*           WHERE einri    EQ g_institution
*             AND ibgdt    EQ s_datum     " Aktueller Tag + 1
*             AND falnr    EQ gt_fal-falnr
*             AND lsstae   NOT IN (a_aufg, a_stor)
*             AND ankls    EQ space
*             AND n1pfllei EQ on.         " nur Pflegeleistungen
*    DELETE gt_pfl_nlem WHERE NOT ibzt IN r_zeit.
    SELECT falnr ibgdt ibzt lsstae lnrls ankls n1pfllei     "MED-58787
           FROM nlem INTO TABLE gt_pfl_nlem
           FOR ALL ENTRIES IN gt_fal
           WHERE falnr    EQ gt_fal-falnr
             AND einri    EQ g_institution
             AND ibgdt    EQ s_datum     " Aktueller Tag + 1
             and ibzt     IN r_zeit
             AND lsstae   NOT IN (a_aufg, a_stor)
             AND ankls    EQ space
             AND n1pfllei EQ on.         " nur Pflegeleistungen
  ENDIF.

* 6.05: select new care services too
  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.     "MED-54909
    g_check_ppd = abap_true.

    LOOP AT gr_treat_ou INTO lr_orgpf.
      CLEAR l_orgpf.
      l_orgpf = lr_orgpf-low.
      CHECK l_orgpf IS NOT INITIAL.

      CLEAR l_n1pmn.
      CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
        EXPORTING
          i_einri     = g_institution
          i_ou        = l_orgpf
          i_par_name  = 'N1PMN'
        IMPORTING
          e_par_value = l_n1pmn.

*     Check if all selected treating ou's use the new nursing plan.
      CHECK l_n1pmn <> 'P'.

*     At least one ou use still uses the old nursing plan.
      g_check_ppd = abap_false.
      EXIT.
    ENDLOOP.
  ELSE.
    g_check_ppd = abap_false.
  ENDIF.

  IF g_check_ppd = abap_false.
    DESCRIBE TABLE gt_pat.
    IF sy-tfill > 0.
*    SELECT patnr psdat pstim status srvid
*           FROM n1srv INTO TABLE gt_pfl_n1srv
*           FOR ALL ENTRIES IN gt_pat
*           WHERE  einri   = g_institution
*           AND    patnr   = gt_pat-patnr
*           AND    status  NOT IN (a_aufg, a_stor)
*           AND    psdat   = s_datum
*           AND    stokz   = off.
*      DELETE gt_pfl_n1srv WHERE NOT pstim IN r_zeit.
      SELECT patnr psdat pstim status srvid stokz einri     "MED-58787
             FROM n1srv INTO TABLE gt_pfl_n1srv
             FOR ALL ENTRIES IN gt_pat
             WHERE   patnr   = gt_pat-patnr
             AND     psdat   = s_datum
             AND     pstim   IN r_zeit
             AND     status  NOT IN (a_aufg, a_stor)
             AND     stokz   = off
             AND     einri   = g_institution.
      SORT gt_pfl_n1srv BY patnr ASCENDING
                           psdat ASCENDING
                           pstim ASCENDING.
    ENDIF.
  ELSE.
    DESCRIBE TABLE gt_pat.
    IF sy-tfill > 0.
      s_datum = g_key_date + 7.
*      SELECT patnr psdat pstim status srvid
*             FROM n1srv INTO TABLE gt_pfl_n1srv
*             FOR ALL ENTRIES IN gt_pat
*             WHERE  einri   = g_institution
*             AND    patnr   = gt_pat-patnr
*             AND    status  IN (a_ange, a_erbr)             "MED-56791
**            AND    status  IN (co_ao, co_don)
*             AND    psdat   <= s_datum
*             AND    stokz   = off.
*      DELETE gt_pfl_n1srv WHERE NOT pstim IN r_zeit.
      SELECT patnr psdat pstim status srvid                 "MED-58787
             FROM n1srv INTO TABLE gt_pfl_n1srv
             FOR ALL ENTRIES IN gt_pat
             WHERE   patnr   = gt_pat-patnr
             AND     psdat   <= s_datum
             AND     pstim   IN r_zeit
             AND     status  IN (a_ange, a_erbr)
             AND     stokz   = off
             AND     einri   = g_institution.
      SORT gt_pfl_n1srv BY patnr ASCENDING
                           psdat ASCENDING
                           pstim ASCENDING.

    ENDIF.
  ENDIF.

ENDFORM.                    " fill_table_pfl_nlem

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_PFLL_NLEM                 (MED-29612)
*&---------------------------------------------------------------------*
FORM fill_table_pfll_nlem.

  STATICS: a_aufg LIKE n1lssta-lsstae. " anw.spez. Wert für AUFGELÖST
  STATICS: a_stor LIKE n1lssta-lsstae. " anw.spez. Wert für STORNIERT

  DATA: l_n1lssta    LIKE n1lssta,
        ls_pfll_nlem TYPE ty_pfl_nlem,
        lt_nllz      TYPE STANDARD TABLE OF nllz,
        ls_nllz      TYPE nllz.

* get nursing service information (Pflegeleistungen)
  CLEAR gt_pfll_nlem. REFRESH gt_pfll_nlem.

  DESCRIBE TABLE gt_fal.
  CHECK sy-tfill > 0.

* Ermittlung des anwenderspezifischen Werts für AUFGELÖST u. STORNIERT
  IF a_aufg IS INITIAL OR a_aufg EQ space OR
     a_stor IS INITIAL OR a_stor EQ space.
    SELECT * FROM n1lssta INTO l_n1lssta
      WHERE einri = g_institution
        AND lssta IN ('AL','ST')
        AND loekz = off.
      CASE l_n1lssta-lssta.
        WHEN 'AL'.
          a_aufg = l_n1lssta-lsstae.
        WHEN 'ST'.
          a_stor = l_n1lssta-lsstae.
      ENDCASE.
    ENDSELECT.
    IF sy-subrc NE 0.
      EXIT.
    ENDIF.
  ENDIF.

  SELECT falnr ibgdt ibzt lsstae lnrls
         FROM nlem INTO TABLE gt_pfll_nlem
         FOR ALL ENTRIES IN gt_fal
         WHERE einri    EQ g_institution
           AND ibgdt    LE g_key_date
           AND falnr    EQ gt_fal-falnr
           AND lsstae   NOT IN (a_aufg, a_stor)
           AND ankls    EQ space
           AND n1pfllei EQ on.         " only careservices

  DELETE gt_pfll_nlem WHERE ibgdt = g_key_date
                        AND ibzt  > g_key_time_sel.

  IF gt_pfll_nlem[] IS NOT INITIAL.
    SELECT * FROM nllz INTO TABLE lt_nllz
      FOR ALL ENTRIES IN gt_pfll_nlem
      WHERE lnrls1 = gt_pfll_nlem-lnrls.
    IF lt_nllz[] IS NOT INITIAL.
      SORT lt_nllz BY lnrls1.
      LOOP AT gt_pfll_nlem INTO ls_pfll_nlem.
        READ TABLE lt_nllz INTO ls_nllz
             WITH KEY lnrls1 = ls_pfll_nlem-lnrls
             BINARY SEARCH.
        CHECK sy-subrc = 0.
        DELETE gt_pfll_nlem.
      ENDLOOP.
    ENDIF.
  ENDIF.

ENDFORM.                               " FILL_TABLE_PFLL_NLEM

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_DOK
*&---------------------------------------------------------------------*
FORM fill_table_dok USING VALUE(p_med_or_lab)  TYPE ish_on_off.

  DATA: l_dok     LIKE LINE OF gt_dok,                      " ID 10488
        lt_dok    LIKE gt_dok,                              " ID 10488
        l_dok_tmp LIKE LINE OF lt_dok.                      " ID 10488

  RANGES: r_medok FOR ndoc-medok.

* get document information
  CLEAR gt_dok. REFRESH gt_dok.

  DESCRIBE TABLE gt_fal.                                    " ID 9652
  CHECK sy-tfill > 0.                                       " ID 9652

* Rangetab der Dokarten befüllen                            " ID 10488
  CLEAR r_medok.  REFRESH r_medok.
  r_medok-sign   = 'I'.
  r_medok-option = 'EQ'.
  r_medok-low    = 'X'.                " Medizinische Dokumente
  APPEND r_medok.                      " UND
  r_medok-low    = 'L'.                " Laborbefunde
  APPEND r_medok.

  SELECT falnr medok FROM ndoc
         APPENDING CORRESPONDING FIELDS OF TABLE gt_dok
         FOR ALL ENTRIES IN gt_fal
         WHERE einri EQ gt_fal-einri
           AND falnr EQ gt_fal-falnr
           AND storn EQ off
           AND loekz EQ off
           AND medok IN r_medok.

* ID 10488: Med.Dok.-Kz und Lab.Dok.-Kz in der Tabelle befüllen
  IF p_med_or_lab = on.
    lt_dok[] = gt_dok[].
    LOOP AT gt_dok INTO l_dok.
      LOOP AT lt_dok INTO l_dok_tmp WHERE falnr = l_dok-falnr.
        CASE l_dok_tmp-medok.
          WHEN 'X'.
            l_dok-meddok = on.
          WHEN 'L'.
            l_dok-labdok = on.
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
        IF l_dok-meddok = on AND l_dok-labdok = on.
          EXIT.
        ENDIF.
      ENDLOOP.
      MODIFY gt_dok FROM l_dok.
    ENDLOOP.
  ENDIF.

  DELETE ADJACENT DUPLICATES FROM gt_dok COMPARING falnr.

ENDFORM.                               " FILL_TABLE_DOK

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_N2FLAG
*&---------------------------------------------------------------------*
FORM fill_table_n2flag.

  TYPES: BEGIN OF ty_pcode,
           einri LIKE ndoc-einri,
           falnr LIKE ndoc-falnr,
           pcode LIKE ndoc-pcode,
           dokar TYPE ndoc-dokar,                           " ID 11879
           doknr TYPE ndoc-doknr,                           " ID 11879
           dokvr TYPE ndoc-dokvr,                           " ID 11879
         END OF ty_pcode.

  DATA: lt_docpcode TYPE TABLE OF ty_pcode WITH NON-UNIQUE KEY falnr.
  DATA: l_docpcode  TYPE ty_pcode.

  DATA: l_n2flag    TYPE ty_n2flag.
  DATA: l_fal       TYPE ty_fal.

  DATA: h_tn2flag   LIKE TABLE OF tn2flag.
  DATA: l_tn2flag   LIKE tn2flag.

  DATA: h_ndoc      LIKE TABLE OF ndoc.
  DATA: l_ndoc      LIKE ndoc.

* get icon-document information
  CLEAR gt_n2flag.   REFRESH gt_n2flag.
  CLEAR lt_docpcode. REFRESH lt_docpcode.

  DESCRIBE TABLE gt_fal.                                    " ID 9652
  CHECK sy-tfill > 0.                                       " ID 9652

* read all documents with presentation code for all cases
  SELECT einri falnr pcode dokar doknr dokvr
                           FROM ndoc INTO TABLE lt_docpcode
                           FOR ALL ENTRIES IN gt_fal
                           WHERE falnr = gt_fal-falnr
                           AND   einri = gt_fal-einri
                           AND   storn = off
                           AND   loekz = off.
  DELETE lt_docpcode WHERE pcode IS INITIAL.
* ID 11879: delete duplicate documents (older versions!)
  SORT lt_docpcode BY dokar ASCENDING doknr ASCENDING dokvr DESCENDING.
  DELETE ADJACENT DUPLICATES FROM lt_docpcode COMPARING dokar doknr.
  DESCRIBE TABLE lt_docpcode.
  CHECK sy-tfill > 0.

  LOOP AT gt_fal INTO l_fal.
    CLEAR: h_ndoc, h_tn2flag. REFRESH: h_ndoc, h_tn2flag.
    LOOP AT lt_docpcode INTO l_docpcode WHERE falnr = l_fal-falnr.
      l_ndoc-einri = l_docpcode-einri.
      l_ndoc-falnr = l_docpcode-falnr.
      l_ndoc-pcode = l_docpcode-pcode.
      l_ndoc-doknr = l_docpcode-doknr.                      "MED-32961
      APPEND l_ndoc TO h_ndoc.
    ENDLOOP.
    SORT h_ndoc BY einri pcode.
    DELETE ADJACENT DUPLICATES FROM h_ndoc COMPARING einri pcode.
    DESCRIBE TABLE h_ndoc.
    CHECK sy-tfill > 0.
*   call with all presentation codes of the documents of that case
    CALL FUNCTION 'ISHMED_DOKU_GET_PRCODE'
      TABLES
        i_ndoc    = h_ndoc
        i_tn2flag = h_tn2flag
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.
    CHECK sy-subrc = 0.
*   the presentation code with the highest priority for the documents
*   of that case has been found
    READ TABLE h_tn2flag INTO l_tn2flag INDEX 1.
    CHECK NOT l_tn2flag-flagid IS INITIAL.
    l_n2flag       = l_tn2flag.
    l_n2flag-falnr = l_fal-falnr.
    INSERT l_n2flag INTO TABLE gt_n2flag.
  ENDLOOP.

ENDFORM.                               " FILL_TABLE_N2FLAG

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_FAT
*&---------------------------------------------------------------------*
FORM fill_table_fat.

  DATA: l_n1fat   TYPE ty_fat.
  DATA: ls_ngpa   TYPE ngpa.
  DATA: l_rc      TYPE ish_method_rc.

* get all open patient transport orders and
* display the most recent
* Offene Transportaufträge (nur Hintransporte für die
* Belegungen) suchen und den jüngsten anzeigen
  CLEAR gt_n1fat. REFRESH gt_n1fat.

  DESCRIBE TABLE gt_n1fst.
  IF sy-tfill = 0.
    SELECT * FROM n1fst INTO TABLE gt_n1fst WHERE fsend = ' '.
  ENDIF.

  DESCRIBE TABLE gt_pat.
  IF sy-tfill > 0.
    SELECT fatid einri patnr fstid orgag bauag datag uztag
           orgzl bauzl datzl uztzl tpae tptyp fhrid papid
           trans trava
           FROM n1fat INTO CORRESPONDING FIELDS OF TABLE gt_n1fat
           FOR ALL ENTRIES IN gt_pat
           WHERE patnr = gt_pat-patnr
             AND einri = gt_pat-einri
             AND datag = g_key_date
             AND tptyp IN ('1','2')
             AND storn = off.
  ENDIF.

  DESCRIBE TABLE gt_pap.
  IF sy-tfill > 0.
    SELECT fatid einri patnr fstid orgag bauag datag uztag
           orgzl bauzl datzl uztzl tpae tptyp fhrid papid
           trans trava
           FROM n1fat APPENDING CORRESPONDING FIELDS OF TABLE gt_n1fat
           FOR ALL ENTRIES IN gt_pap
           WHERE papid = gt_pap-papid
             AND datag = g_key_date
             AND tptyp IN ('1','2')
             AND storn = off.
  ENDIF.

  LOOP AT gt_n1fat INTO l_n1fat.
    IF NOT l_n1fat-fstid IS INITIAL.
      SELECT SINGLE fsted FROM n1fstt INTO l_n1fat-fstat
             WHERE  spras  = sy-langu
             AND    fstid  = l_n1fat-fstid.
    ENDIF.
    IF NOT l_n1fat-fhrid IS INITIAL.
      CALL METHOD cl_ish_dbr_gpa=>get_gpa_by_gpart
        EXPORTING
          i_gpart = l_n1fat-fhrid
        IMPORTING
          es_ngpa = ls_ngpa
          e_rc    = l_rc.
      IF l_rc = 0.
        l_n1fat-fname = ls_ngpa-kname.
      ENDIF.
    ENDIF.
    MODIFY gt_n1fat FROM l_n1fat.
  ENDLOOP.

  SORT gt_n1fat BY patnr papid datag uztag.

ENDFORM.                               " FILL_TABLE_FAT

*&---------------------------------------------------------------------*
*&      Form  GET_ICON
*&---------------------------------------------------------------------*
*       get icon to be displayed
*----------------------------------------------------------------------*
*      -->P_INDICATOR   Column Indicator
*      <--P_ICON        Icon
*----------------------------------------------------------------------*
FORM get_icon USING    VALUE(p_indicator)    LIKE nwicons-col_indicator
              CHANGING p_icon                LIKE nwicons-icon.

  CALL METHOD cl_ish_display_tools=>get_wp_icon
    EXPORTING
      i_einri     = g_institution
      i_indicator = p_indicator
    IMPORTING
      e_icon      = p_icon.

*  DATA: lt_nwicons  LIKE TABLE OF nwicons.
*  DATA: l_nwicons   LIKE nwicons.
*
*  CLEAR p_icon.
*  CLEAR l_nwicons.
*  CLEAR lt_nwicons. REFRESH lt_nwicons.
*  l_nwicons-einri         = g_institution.
*  l_nwicons-col_indicator = p_indicator.
*  APPEND l_nwicons TO lt_nwicons.
*
*  CALL FUNCTION 'ISHMED_NWICONS_GET'
*    TABLES
*      t_nwicons = lt_nwicons.
*
*  READ TABLE lt_nwicons INTO l_nwicons INDEX 1.
*  CHECK sy-subrc = 0.
*  IF l_nwicons-letter IS INITIAL.
*    p_icon = l_nwicons-icon.
*  ELSE.
*    p_icon = l_nwicons-letter.
*  ENDIF.

ENDFORM.                               " GET_ICON

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_NDIA
*&---------------------------------------------------------------------*
FORM fill_table_ndia.

* read diagnosis for all cases
  CLEAR gt_ndia. REFRESH gt_ndia.

  DESCRIBE TABLE gt_fal.                                    " ID 9652
  CHECK sy-tfill > 0.                                       " ID 9652

  SELECT * FROM ndia INTO TABLE gt_ndia
         FOR ALL ENTRIES IN gt_fal
         WHERE  einri  = gt_fal-einri
         AND    falnr  = gt_fal-falnr
         AND    storn  = off.   "LE, 22.11.01 ID 8532

ENDFORM.                               " FILL_TABLE_NDIA

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_NBEW
*&---------------------------------------------------------------------*
FORM fill_table_nbew.

* read movements for all cases
  CLEAR gt_nbew. REFRESH gt_nbew.

  DESCRIBE TABLE gt_fal.                                    " ID 9652
  CHECK sy-tfill > 0.                                       " ID 9652

  SELECT * FROM nbew INTO TABLE gt_nbew
         FOR ALL ENTRIES IN gt_fal
         WHERE  einri  = gt_fal-einri
         AND    falnr  = gt_fal-falnr.

ENDFORM.                               " FILL_TABLE_NBEW

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_PFLP_LEI
*&---------------------------------------------------------------------*
FORM fill_table_pflp_lei.

  DATA: l_tn00r       LIKE tn00r,
        l_ishmed_used TYPE i,
        l_end_date    TYPE n1nrsph_end_date.
  DATA l_n1pmn          TYPE n1orgpar-n1parwert.    "MED-42622 - see domain n1nrs_ps_n1pmn
  DATA l_check_n1pflank TYPE abap_bool.                     "MED-42622
  DATA l_orgpf          TYPE nbew-orgpf.                    "MED-42622
  RANGES lr_orgpf       FOR nbew-orgpf.                     "MED-42622


* read 'Pflegeankerleistungen' for all cases
  REFRESH gt_pflp_nlei.
  REFRESH gt_pflp_n1nrsph.

* - - - - BEGIN MED-42622 C. Honeder
  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
    l_check_n1pflank = abap_false.

    LOOP AT gr_treat_ou INTO lr_orgpf.
      CLEAR l_orgpf.
      l_orgpf = lr_orgpf-low.
      CHECK l_orgpf IS NOT INITIAL.

      CLEAR l_n1pmn.
      CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
        EXPORTING
          i_einri     = g_institution
          i_ou        = l_orgpf
          i_par_name  = 'N1PMN'
        IMPORTING
          e_par_value = l_n1pmn.

*     Check if all selected treating ou's use the new nursing plan.
      CHECK l_n1pmn <> 'P'.

*     At least one ou use still uses the old nursing plan.
*     So we have to check the system parameter N1PFLANK
      l_check_n1pflank = abap_true.
      EXIT.
    ENDLOOP.
  ELSE.
    l_check_n1pflank = abap_true.
  ENDIF.
* - - - - END MED-42622 C. Honeder

  IF l_check_n1pflank = abap_true.                          "MED-42622
    DESCRIBE TABLE gt_fal.                                  " ID 9652
    IF sy-tfill > 0.                                        " ID 9652
      CALL FUNCTION 'ISH_TN00R_READ'
        EXPORTING
          ss_einri  = g_institution
          ss_param  = 'N1PFLANK'
        IMPORTING
          ss_value  = l_tn00r-value
        EXCEPTIONS
          not_found = 1.
      IF sy-subrc <> 0.
*       Falls IS-H*MED im Einsatz ist -> Meldung ausgeben
        PERFORM check_ishmed CHANGING l_ishmed_used.
        IF l_ishmed_used = true.
          MESSAGE i500.
*       Bitte den Systemparamter N1PFLANK pflegen
        ENDIF.
        EXIT.
      ENDIF.
      g_n1pflank = l_tn00r-value.
      IF g_n1pflank IS NOT INITIAL.
        SELECT * FROM nlei INTO TABLE gt_pflp_nlei
               FOR ALL ENTRIES IN gt_fal
               WHERE  einri  = gt_fal-einri
               AND    falnr  = gt_fal-falnr
               AND    leist  = g_n1pflank.
        SORT gt_pflp_nlei BY falnr ASCENDING
                             pbgdt DESCENDING
                             pbzt  DESCENDING.
      ENDIF.
    ENDIF.
  ENDIF.                                                    "MED-42622

* 6.05: get new care data too
  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
    DESCRIBE TABLE gt_pat.
    IF sy-tfill > 0.
      SELECT * FROM n1nrsph INTO TABLE gt_pflp_n1nrsph
             FOR ALL ENTRIES IN gt_pat
             WHERE  plan_type = cl_ishmed_nrs_bo_plan_i=>co_plantype_inpatient
             AND    einri     = g_institution
             AND    patnr     = gt_pat-patnr
             AND    end_date  = l_end_date.
      SORT gt_pflp_n1nrsph BY patnr ASCENDING
                              erdat DESCENDING
                              ertim DESCENDING.
    ENDIF.
  ENDIF.

ENDFORM.                               " FILL_TABLE_PFLP_LEI

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_EVAL
*&---------------------------------------------------------------------*
FORM fill_table_eval.

  DATA: l_date     TYPE n1nrspee_realdate,
        l_end_date TYPE n1nrsph_end_date.

  DATA: ls_eval    TYPE n1nrspee,
        ls_n1nrsph TYPE n1nrsph.

  DESCRIBE TABLE gt_pat.
  IF sy-tfill > 0.
    SELECT * FROM n1nrsph INTO TABLE gt_pflp_eval
           FOR ALL ENTRIES IN gt_pat
           WHERE  plan_type = cl_ishmed_nrs_bo_plan_i=>co_plantype_inpatient
           AND    einri     = g_institution
           AND    patnr     = gt_pat-patnr
           AND    end_date  = l_end_date.
    IF sy-subrc = 0.
      SORT gt_pflp_eval BY patnr ASCENDING
                           erdat DESCENDING
                           ertim DESCENDING.

      SELECT * FROM n1nrspee INTO TABLE gt_eval
        FOR ALL ENTRIES IN gt_pflp_eval
        WHERE nrsphid   = gt_pflp_eval-nrsphid
        AND   real_date = l_date
        AND   stokz     = ' '.

      IF sy-subrc = 0.
        CLEAR gt_eval_pat.                                  "MED-44358
        LOOP AT gt_eval INTO ls_eval.
          MOVE-CORRESPONDING ls_eval TO gs_eval_pat-eval_wa.
          READ TABLE gt_pflp_eval INTO ls_n1nrsph
            WITH KEY nrsphid = ls_eval-nrsphid.
          gs_eval_pat-patnr = ls_n1nrsph-patnr.
          APPEND gs_eval_pat TO gt_eval_pat.
        ENDLOOP.
        SORT gt_eval_pat BY patnr ASCENDING
                            eval_wa-plan_date ASCENDING
                            eval_wa-plan_time ASCENDING.
      ELSE.
        CLEAR: gt_eval_pat[].
      ENDIF.
    ELSE.
      CLEAR: gt_eval_pat[].
    ENDIF.
  ENDIF.

ENDFORM.                    "fill_table_eval

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_NFPZ
*&---------------------------------------------------------------------*
FORM fill_table_nfpz.

* get the treating doctors for all cases
  CLEAR gt_nfpz. REFRESH gt_nfpz.

  DESCRIBE TABLE gt_fal.                                    " ID 9652
  CHECK sy-tfill > 0.                                       " ID 9652

  SELECT einri falnr pernr lfdnr lfdbw farzt FROM nfpz
         INTO TABLE gt_nfpz
         FOR ALL ENTRIES IN gt_fal
         WHERE  einri    = gt_fal-einri
         AND    falnr    = gt_fal-falnr
         AND    storn    = off.
  DELETE gt_nfpz WHERE farzt <> '6'.   " behandelnder Arzt

ENDFORM.                               " FILL_TABLE_NFPZ

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_NGPA
*&---------------------------------------------------------------------*
FORM fill_table_ngpa.

  DATA: lt_nfpz TYPE TABLE OF ty_nfpz,
        lt_ngpa TYPE ishmed_t_ngpa,
        ls_ngpa TYPE ty_ngpa.

  FIELD-SYMBOLS: <ls_ngpa>  TYPE ngpa.

* get the names for all treating doctors
  CLEAR gt_ngpa. REFRESH gt_ngpa.
  CLEAR lt_nfpz. REFRESH lt_nfpz.
  CLEAR lt_ngpa. REFRESH lt_ngpa.

  DESCRIBE TABLE gt_nfpz.
  CHECK sy-tfill > 0.
  lt_nfpz[] = gt_nfpz[].
  SORT lt_nfpz BY pernr.
  DELETE ADJACENT DUPLICATES FROM lt_nfpz COMPARING pernr.
  CHECK lt_nfpz[] IS NOT INITIAL.

*  SELECT gpart titel vorsw name1 name2 FROM ngpa INTO TABLE gt_ngpa
*         FOR ALL ENTRIES IN lt_nfpz
*         WHERE  gpart  = lt_nfpz-pernr.

  CALL METHOD cl_ish_dbr_gpa=>get_t_gpa_by_gpart
    EXPORTING
      it_gpart = lt_nfpz
    IMPORTING
      et_ngpa  = lt_ngpa.

  LOOP AT lt_ngpa ASSIGNING <ls_ngpa>.
    MOVE-CORRESPONDING <ls_ngpa> TO ls_ngpa.                "#EC ENHOK
    INSERT ls_ngpa INTO TABLE gt_ngpa.
  ENDLOOP.

ENDFORM.                               " FILL_TABLE_NGPA

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_ANF
*&---------------------------------------------------------------------*
FORM fill_table_anf.

  DATA: l_pat       TYPE ty_pat.
*  DATA: l_active(1) TYPE c,"REM MED-34000
*        l_tn00q     TYPE tn00q."REM MED-34000

* get the requests for all patients

  DESCRIBE TABLE gt_pat.                                    " ID 9652
  CHECK sy-tfill > 0.                                       " ID 9652

** get parameter if requests and/or clinical orders are active
*  READ TABLE gt_pat INTO l_pat INDEX 1."REM MED-34000
*  CLEAR l_active.
*  PERFORM ren00q(sapmnpa0) USING l_pat-einri 'N1CORDER' l_tn00q-value.
*  MOVE l_tn00q-value(1) TO l_active.

* select requests
*  IF l_active IS INITIAL OR l_active = 'R'."REM MED-34000
  SELECT patnr einri FROM n1anf INTO TABLE gt_anf
      FOR ALL ENTRIES IN gt_pat
      WHERE einri EQ gt_pat-einri
        AND patnr EQ gt_pat-patnr
        AND storn EQ off.
*  ENDIF."REM MED-34000

* select clinical orders
*  IF l_active IS INITIAL OR l_active = 'O'."REM MED-34000
  SELECT patnr FROM n1corder INTO TABLE gt_cord
         FOR ALL ENTRIES IN gt_pat
         WHERE  patnr  = gt_pat-patnr
           AND  storn  = off.
*  ENDIF."REM MED-34000

ENDFORM.                               " FILL_TABLE_ANF

*&---------------------------------------------------------------------*
*&      Form  CHECK_MARKED
*&---------------------------------------------------------------------*
*       Prüfen, ob die erlaubte Anzahl Zeilen markiert wurde
*----------------------------------------------------------------------*
*      <-- PT_MESSAGES  Meldungen
*      --> PT_MOVEMENTS Bewegungen/Fälle/Basisdaten
*      --> P_FCODE      Funktionscode
*      <-- P_RC         Returncode (0 = OK, 1 = Error)
*----------------------------------------------------------------------*
FORM check_marked TABLES   pt_messages      STRUCTURE bapiret2
                  USING    pt_movements     TYPE
                                            ishmed_t_care_unit_list_head
                           VALUE(p_fcode)   LIKE rseu1-func
                  CHANGING p_rc             LIKE sy-subrc.

  DATA: l_wa_msg      LIKE bapiret2,
        l_rc          LIKE sy-subrc, " 0=OK, 1=nichts markiert, 2=zuviel
        l_movement    TYPE rnwp_care_unit_list_head,
        l_anz         LIKE sy-tabix,
        l_patnam(30)  TYPE c,
        l_npat        TYPE npat,
        l_npap        TYPE npap,
        l_retcode     TYPE ish_method_rc,
        l_fct_txt(20) TYPE c.
  DATA: l_n1pmn       TYPE n1orgpar-n1parwert.              "MED-42695

  CLEAR: p_rc, l_rc, l_anz, l_movement, l_npat, l_npap, l_patnam,
         l_fct_txt.

* Check ob irgendein Fall/Bewegung übergeben wurde.
  IF p_fcode = 'OMON' OR p_fcode = 'PORG' OR p_fcode = 'TMNL' OR
     p_fcode = 'PTRI' OR p_fcode = 'N1IPC1'.
*   OP-Monitor, Patientenorganizer, Terminübersicht, Patientenprofil, Fahrauftragsanlage
*   auch für Termine aufrufbar (muß keine Bewegung da sein)
    DESCRIBE TABLE pt_movements LINES l_anz.
  ELSE.
*   MED-41932: Begin of DELETE
*    READ TABLE pt_movements INTO l_movement INDEX 1.
*    IF l_movement-falnr IS INITIAL AND l_movement-lfdnr IS INITIAL.
*      l_anz = 0.                         "Keine Bewegung markiert
*    ELSE.
*      DESCRIBE TABLE pt_movements LINES l_anz.
*    ENDIF.
*   MED-41932: End of DELETE
*   MED-41932: Begin of INSERT
    LOOP AT pt_movements INTO l_movement WHERE falnr IS NOT INITIAL
                                            OR lfdnr IS NOT INITIAL.
      l_anz = l_anz + 1.
    ENDLOOP.
*   MED-41932: End of INSERT
  ENDIF.

* Hier muß der gesamte Funktionsvorrat geprüft werden
  CASE p_fcode.
*   Genau 1 Patient muß markiert sein
*   OP-Monitor, Krankenakte,
*   Offene Punkte Patient, Besuche Anzeigen, Ändern, Anlegen
*   Formular Auswahl, Formular Standard, Formular Protokoll,
*   Leistungsnacherfassung pflegen, Leistungsnacherfassung anz.
*   Pflegeleistungsnacherfassung änder, anzeigen und nacherfassen
*   Pflegeprofil-Hitliste, Pflegebericht, Leistungsübersicht,
*   Patientenhistorie
*   Transportauftrag anlegen
    WHEN 'OMON' OR 'KAUE' OR 'POPT' OR 'BDIS' OR
         'BINS' OR 'BUPD' OR 'FORA' OR 'FORS' OR 'FPRO' OR
         'FORM' OR 'HLPP' OR 'PLUE' OR 'PHIS' OR 'PTRI' OR
*         'N1IPC1' OR   "MED-55753   Tako Peter 05.21.2014
         'NHLPP'.                                           "ID 19770
      CASE l_anz.
        WHEN 0.       l_rc = 1.
        WHEN 1.                                             " OK
        WHEN OTHERS.  l_rc = 2.
      ENDCASE.
*   Mindestens 1 Patient muß markiert sein
*   Pflegestufen geplant, Pfl. Leistungen kopieren,
*   Pflegeplan PORG -> Patientenorganizer aufrufen
*   Vitalparameter (Einzelerfassung + Sammelerf. + Anzeigen im Pat.org.)
*   BATMP - Temporäre Behandlungsaufträge
*   Pflegeplan anlegen (P1NW), Pflegeplan Übersicht (P1UE) -> MED-30825
    WHEN 'PPR0' OR 'CPFL' OR 'N1P1' OR 'PORG' OR 'PFVB' OR
         'VPEF' OR 'VPSF' OR 'VPPO' OR 'BATMP' OR
         'P1NW' OR 'P1UE'.
* - - - - - - BEGIN MED-42695 C. Honeder.
*   If we have no movement and the table has one, we use this movement.
      IF l_movement IS INITIAL AND lines( pt_movements ) = 1.
        READ TABLE pt_movements INDEX 1 INTO l_movement.
      ENDIF.

*   Check if the new nursing plan is active.
      CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
        EXPORTING
          i_einri     = l_movement-einri
          i_ou        = l_movement-orgpf
          i_par_name  = 'N1PMN'
        IMPORTING
          e_par_value = l_n1pmn.

*     For the given fcode also 0 selected rows are allowed -> We will bring the
*     patsearch in a later moment.
*     For all other fcodes processing is as usual.
      IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true  AND
         l_n1pmn IS NOT INITIAL                             AND
         p_fcode =  'P1UE'.
        l_rc = 0.
      ELSE.
        CASE l_anz.
          WHEN 0.       l_rc = 1.
          WHEN OTHERS.  l_rc = 0.
        ENDCASE.
      ENDIF.

*     Clear the movement!
      CLEAR l_movement.

*      CASE l_anz.
*        WHEN 0.       l_rc = 1.
*        WHEN OTHERS.  l_rc = 0.
*      ENDCASE.
* - - - - - - END MED-42695 C. Honeder
*   0 oder 1 Patient muß markiert sein
*   Dokument anlegen, Dokumentenliste, Dokumente-fallbezogen,
*   Dokumente-patientenbezogen, Laborkumulativbefund,
*   Perinatalmonitor, Intensivmonitor, Diagnosen, Patientenprofil
    WHEN 'DCRE' OR 'DOKS' OR 'DOKF' OR 'DOKP' OR 'LABK' OR 'N1PM' OR
         'IMON' OR 'DIA' OR 'N1IPC1'.    "MED-55753   Tako Peter 05.21.2014
      CASE l_anz.
        WHEN 0 OR 1.   l_rc = 0.
        WHEN OTHERS.   l_rc = 2.
      ENDCASE.
*   Egal wieviele Patienten markiert sind
*   VKGC - Vormerkung anlegen,
**   VKGL01, VKGL02, VKGL03, VKGLB - Vormerkliste Varianten
*   AUFE - Anforderungen Einwilligungen fehlen,
*   AUNU - Nüchternliste
*   DIA+ - Globales Diagnosekennzeichen
*   ACRE - Anforderung anlegen
*   AUES - Anforderungsübersicht
**   AUEV - Anforderungsübersicht Variantenauswahl
**   AUES - Anforderungsübersicht Normal
**   VKGL - Vormerkliste Patienten
*   OPPD - OP-Programm - Datum
*   OPPG - OP-Programm
*   APFL - Arbeitsliste Pflegerische Leistungen
*   N1PL - Pflegeübersicht
*   N1PL - Pflegearbeitsliste
*   TMNL - Terminkalender Patient Me
*   WIDB - Wiederbestellung
*   PTS_INSO - Fahrauftrag ohne Patient anlegen
    WHEN OTHERS.
      EXIT.
  ENDCASE.

* Richtige Anzahl markiert?
  CASE l_rc.
    WHEN 0.                              " OK
    WHEN 1.                              " kein Patient markiert
      p_rc = 1.
*     Für bestimmte FCODEs andere Meldung (ID 7896)
      CASE p_fcode.
        WHEN 'KAUE' OR 'PUPD'.                              "OR 'N1P1'.
*         & ist noch nicht aufgenommen, & nicht verfügbar
          CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
            EXPORTING
              i_patnr = l_movement-patnr
            IMPORTING
              es_npat = l_npat
              e_rc    = l_retcode.
          IF l_retcode = 0.
            CONCATENATE l_npat-nname l_npat-vname INTO l_patnam
                                                  SEPARATED BY space.
          ELSE.
            CALL METHOD cl_ish_dbr_pap=>get_pap_by_papid
              EXPORTING
                i_papid = l_movement-papid
              IMPORTING
                es_npap = l_npap
                e_rc    = l_retcode.
            IF l_rc = 0.
              CONCATENATE l_npap-nname l_npap-vname INTO l_patnam
                                                    SEPARATED BY space.
            ELSE.
              l_patnam = 'Patient'(016).
            ENDIF.
          ENDIF.
          IF p_fcode = 'KAUE'.
            l_fct_txt = 'Krankenakten'(013).
          ENDIF.
          IF p_fcode = 'PUPD'.
            l_fct_txt = 'Pflegeleistungen'(014).
          ENDIF.
          IF p_fcode = 'N1P1'.
            l_fct_txt = 'Pflegeplan'(015).
          ENDIF.
          PERFORM build_bapiret2(sapmn1pa)
                  USING    'E' 'NF1' '644' l_patnam l_fct_txt
                           space space space space space
                  CHANGING l_wa_msg.
        WHEN OTHERS.
*         Bitte markieren Sie einen Patienten
          PERFORM build_bapiret2(sapmn1pa)
                  USING 'E' 'NF' '759' space space space space
                                       space space space
                  CHANGING l_wa_msg.
      ENDCASE.
      APPEND l_wa_msg TO pt_messages.
    WHEN 2.                              " zuviele Patienten markiert
      p_rc = 1.
*     Nur genau 1 Patienten markieren
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '054' space space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
  ENDCASE.

ENDFORM.                               " CHECK_MARKED

*&---------------------------------------------------------------------*
*&      Form  CALL_DIAGNOSE
*&---------------------------------------------------------------------*
*       Aufruf Funktion 'Diagnose'
*----------------------------------------------------------------------*
*      <-- PT_MESSAGES   Meldungen
*      --> PT_MOVEMENTS  Bewegung
*      <-- P_RC          Returncode (0=OK, 1=Error, 2=Cancel)
*      <-- P_REFRESH     Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_diagnose TABLES   pt_messages  STRUCTURE bapiret2
                   USING    pt_movements TYPE
                                         ishmed_t_care_unit_list_head
                   CHANGING p_rc         LIKE sy-subrc
                            p_refresh    LIKE n1fld-refresh.

  DATA: lt_nbew       LIKE TABLE OF nbew,
        l_bew         LIKE nbew,
        l_fal         LIKE nfal,
        l_einri       LIKE nfal-einri,
        l_uname       LIKE sy-uname,
        l_telnr       LIKE addr3_val-tel_extens,
        l_telstrg(20) TYPE c,
        l_tcauth      TYPE c,            "Berechtigung für Transaktion
        l_movement    TYPE rnwp_care_unit_list_head,
        l_wa_msg      LIKE bapiret2,
        l_uname_tmp   TYPE sy-uname.       "Benutzerabhängiger Kontrollfluss

  CLEAR: p_rc, p_refresh, l_bew, l_fal, l_einri, l_tcauth, l_movement,
         l_wa_msg.

  CLEAR lt_nbew. REFRESH lt_nbew.

* Prüfen ob Patient übergeben wird
  READ TABLE pt_movements INTO l_movement INDEX 1.
  l_einri = l_movement-einri.
  IF l_movement-patnr IS INITIAL AND
     l_movement-falnr IS INITIAL.
*   Kein Patient wurde markiert --> Einstiegsbild anzeigen
    SET PARAMETER ID 'EIN' FIELD l_einri.
    SET PARAMETER ID 'FAL' FIELD space.
    SET PARAMETER ID 'PZF' FIELD space.
    SET PARAMETER ID 'PAT' FIELD space.
    SET PARAMETER ID 'PZP' FIELD space.
    SET PARAMETER ID 'OEF' FIELD space.
    SET PARAMETER ID 'NBO' FIELD space.
    PERFORM call_tcode(sapmnpa0) USING 'NP61' l_einri off l_tcauth.
    IF l_tcauth EQ false.
*     Keine Berechtigung für diese Transaktion
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '000'
                    'Keine Berechtigung für diese Transaktion'(006)
                    space space space space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    ENDIF.
  ELSE.
*   Nur 1 Bewegung wird übergeben
    READ TABLE pt_movements INTO l_movement INDEX 1.
    CHECK sy-subrc = 0.
*   Fall lesen
    SELECT SINGLE * FROM nfal INTO l_fal
           WHERE  einri  = l_movement-einri
           AND    falnr  = l_movement-falnr.
    IF sy-subrc <> 0.
      p_rc = 1.
      EXIT.
    ENDIF.
*   Bei Abgängen sollen Diagnosen für die 'alte' OE bearbeitet werden
    IF l_movement-listkz = 'D'.
*     Alle Bewegungen zum Fall aus dem Puffer holen
      LOOP AT gt_nbew INTO l_bew WHERE einri = l_movement-einri
                                   AND falnr = l_movement-falnr. "#EC *
        APPEND l_bew TO lt_nbew.
      ENDLOOP.
*     Wenn im Puffer nichts gefunden wird, aus der DB lesen
      DESCRIBE TABLE lt_nbew.
      IF sy-tfill = 0.
        SELECT * FROM nbew INTO TABLE lt_nbew
               WHERE  einri  = l_movement-einri
               AND    falnr  = l_movement-falnr
               AND    storn  = off.
      ENDIF.
*     Suche letzte Aufnahme- oder Verlegungsbewegung
      PERFORM get_last_mov TABLES   lt_nbew
                           USING    l_movement-lfdnr
                           CHANGING l_bew.
    ENDIF.
*   Bewegung für Belegungen und Zugänge oder wenn für Abgänge keine gef.
    IF l_bew IS INITIAL.
      READ TABLE gt_nbew INTO l_bew
           WITH TABLE KEY einri = l_movement-einri
                          falnr = l_movement-falnr
                          lfdnr = l_movement-lfdnr.
      IF sy-subrc <> 0.
        SELECT SINGLE * FROM nbew INTO l_bew
               WHERE  einri  = l_movement-einri
               AND    falnr  = l_movement-falnr
               AND    lfdnr  = l_movement-lfdnr.
        IF sy-subrc <> 0.
          p_rc = 1.
          EXIT.
        ENDIF.
      ENDIF.
    ENDIF.

*   Da der Funktionsbaustein gesperrte Fälle nicht korrekt meldet,
*   vor dem Aufruf Fall sperren/entsperren
    CALL FUNCTION 'ISHMED_ENQUEUE_ENFAL'
      EXPORTING
        einri          = l_movement-einri
        falnr          = l_movement-falnr
        i_caller       = 'LN1WPF01,1'
        _scope         = '3'
      EXCEPTIONS
        foreign_lock   = 4
        system_failure = 12.
*   Sperrergebnis auswerten in rufendem Programm
    CASE sy-subrc.
      WHEN 0.
*       Alles OK.
      WHEN 4.
        l_uname = sy-msgv1.
        l_uname_tmp = sy-uname.                                            "Benutzerabhängiger Kontrollfluss
*        IF l_uname = sy-uname.                                            "Benutzerabhängiger Kontrollfluss
        IF l_uname = l_uname_tmp. "#EC *      "Benutzerabhängiger Kontrollfluss
*         Sie haben den Fall & & bereits gesperrt
          PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '657' l_movement-falnr space space space
                                       space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
          EXIT.
        ELSE.
*         Fall & & bereits gesperrt durch &
          PERFORM read_user_telnr(sapmn1pa) USING l_uname
                                                  l_telnr l_telstrg.
          PERFORM build_bapiret2(sapmn1pa)
                  USING 'E' 'NF' '658' l_movement-falnr space l_uname
                                       l_telstrg space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
          EXIT.
        ENDIF.
      WHEN OTHERS.
*       Fall & & konnte nicht gesperrt werden. SY-SUBRC = &
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'N1' '227' l_movement-falnr space space
                                     sy-subrc space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
    ENDCASE.

*   Fall wieder entsperren
    CALL FUNCTION 'ISHMED_DEQUEUE_ENFAL'
      EXPORTING
        einri    = l_movement-einri
        falnr    = l_movement-falnr
        i_caller = 'LN1WPF01,1'
        _scope   = '3'.

*   Aufruf der Diagnosenübersicht
    CALL FUNCTION 'ISHMED_DIAGNOSEN'
      EXPORTING
        ss_list            = off
        ss_lock            = true
        ss_nbew            = l_bew
        ss_nfal            = l_fal
        ss_tcode           = 'N222'
      EXCEPTIONS
        ss_enq_error       = 01
        ss_nfal_not_found  = 02
        ss_tcode_not_valid = 03.

    CASE sy-subrc.
      WHEN 0.
        p_refresh = 1.
      WHEN 1.
        p_rc = 1.
*       Fehler beim Sperren des Falls &
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '081' l_fal-falnr space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
      WHEN OTHERS.
        p_rc = 1.
*       Fehler bei der Verarbeitung (Nr. &)
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '139' sy-subrc space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
    ENDCASE.
  ENDIF.
ENDFORM.                               " CALL_DIAGNOSE

*&---------------------------------------------------------------------*
*&      Form  GET_LAST_MOV
*&---------------------------------------------------------------------*
*       Suche die letzte Aufnahme- oder Verlegungsbewegung
*----------------------------------------------------------------------*
*      --> PT_NBEW  Alle Bewegungen des Falls
*      --> P_BEWNR  Bewegung, die auf der Liste angezeigt wird
*      <-- P_NBEW   Letzte Aufnahme- oder Verlegungsbewegung
*----------------------------------------------------------------------*
FORM get_last_mov TABLES   pt_nbew         STRUCTURE nbew
                  USING    VALUE(p_bewnr)  LIKE nbew-lfdnr
                  CHANGING p_nbew          LIKE nbew.

  DATA: lt_h_nbew LIKE TABLE OF nbew,
        h_bew     LIKE nbew.

  CLEAR p_nbew.

  CLEAR lt_h_nbew. REFRESH lt_h_nbew.

  lt_h_nbew[] = pt_nbew[].

  SORT lt_h_nbew BY bwidt DESCENDING bwizt DESCENDING.
  READ TABLE lt_h_nbew INTO h_bew WITH KEY lfdnr = p_bewnr.
  IF sy-subrc = 0.
    DELETE lt_h_nbew WHERE bwidt > h_bew-bwidt
                        OR bwidt = h_bew-bwidt
                       AND bwizt > h_bew-bwizt.
  ENDIF.
  DELETE lt_h_nbew WHERE storn = on.                        " ID 7574
  LOOP AT lt_h_nbew INTO h_bew WHERE bewty = '1'   "Aufnahme
                                  OR bewty = '3'.  "Verlegung
    IF h_bew-lfdnr <> p_bewnr.
      p_nbew = h_bew.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDFORM.                               " GET_LAST_MOV

*&---------------------------------------------------------------------*
*&      Form  CALL_USEREXIT_FUNC
*&---------------------------------------------------------------------*
*       Aufruf des User-Exits 'Funktionen'
*----------------------------------------------------------------------*
*      <-- PT_MESSAGES   Meldungen
*      --> PT_SELVAR     Selektionsvariante (ID 8505)
*      --> PT_MOVEMENTS  Bewegungen
*      --> P_FCODE       Funktionscode
*      <-- P_RC          Returncode (0=OK, 1=Error, 2=Cancel)
*      <-- P_REFRESH     Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*      <-- P_DONE        User-Exit-Fkt. korrekt ausgeführt (TRUE/FALSE)
*----------------------------------------------------------------------*
FORM call_userexit_func TABLES   pt_messages     STRUCTURE bapiret2
                                 pt_selvar       STRUCTURE rsparams
                        USING    pt_movements    TYPE
                                          ishmed_t_care_unit_list_head
                                 VALUE(p_fcode)  LIKE rseu1-func
                        CHANGING p_rc            LIKE sy-subrc
                                 p_refresh       LIKE n1fld-refresh
                                 p_done          LIKE off.

  DATA: lt_nbew      LIKE TABLE OF nbew,
        l_bew        LIKE nbew,
        lt_mm_marked TYPE ishmed_t_care_unit_list_head,     " ID 8521
        lt_movements TYPE ishmed_t_care_unit_list_head,
        l_movement   TYPE rnwp_care_unit_list.

  p_done = off.
  CLEAR: p_rc, p_refresh.

  REFRESH: lt_movements, lt_mm_marked.

* ID 7123: Bei Abgängen und Abwesenheiten sollen Diagnosen
*          für die 'alte' OE angezeigt werden
  lt_movements[] = pt_movements[].
  READ TABLE lt_movements INTO l_movement INDEX 1.
  IF sy-subrc = 0.
*   ID 8521: für Abgangssicht auch tatsächl. markierte Bew. übergeben
    IF l_movement-listkz = 'D'.
      lt_mm_marked[] = pt_movements[].
    ENDIF.
    LOOP AT lt_movements INTO l_movement.
      CLEAR l_bew.
      READ TABLE gt_nbew INTO l_bew
           WITH TABLE KEY einri = l_movement-einri
                          falnr = l_movement-falnr
                          lfdnr = l_movement-lfdnr.
      IF sy-subrc <> 0.
        SELECT SINGLE * FROM nbew INTO l_bew
               WHERE  einri  = l_movement-einri
               AND    falnr  = l_movement-falnr
               AND    lfdnr  = l_movement-lfdnr.
      ENDIF.
      IF l_movement-listkz = 'D' OR
         l_bew-bewty = '6' OR l_bew-bewty = '7'.
*       get all movements for that case
        CLEAR lt_nbew. REFRESH lt_nbew.
        LOOP AT gt_nbew INTO l_bew WHERE einri = l_movement-einri
                                     AND falnr = l_movement-falnr.
          APPEND l_bew TO lt_nbew.
        ENDLOOP.
        DESCRIBE TABLE lt_nbew.
        IF sy-tfill = 0.
          SELECT * FROM nbew INTO TABLE lt_nbew
                 WHERE  einri  = l_movement-einri
                 AND    falnr  = l_movement-falnr.
        ENDIF.
        CLEAR l_bew.
*       Suche die letzte Aufnahme-/Verlegungsbewegung
        PERFORM get_last_mov TABLES   lt_nbew
                             USING    l_movement-lfdnr
                             CHANGING l_bew.
        IF NOT l_bew IS INITIAL.
          l_movement-lfdnr = l_bew-lfdnr.
          l_movement-orgfa = l_bew-orgfa.
          l_movement-orgpf = l_bew-orgpf.
          MODIFY lt_movements FROM l_movement.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDIF.

* 'EXIT_SAPLN1WP_002'
  CALL CUSTOMER-FUNCTION '002'
    EXPORTING
      it_movements        = lt_movements
      it_movements_marked = lt_mm_marked              " ID 8521
      i_fcode             = p_fcode
      i_dia_dsp           = g_diagdisp                " ID 7456
    IMPORTING
      e_done              = p_done
      e_refresh           = p_refresh
      e_rc                = p_rc
    TABLES
      t_messages          = pt_messages
      t_selvar            = pt_selvar.                " ID 8505

* When there was a function code which is only used by the customer
* always set p_done = on
  CASE p_fcode.
    WHEN '+001' OR '+002' OR '+003'.
      p_done = on.
  ENDCASE.

ENDFORM.                               " CALL_USEREXIT_FUNC

*&---------------------------------------------------------------------*
*&      Form  ADD_VARDATA
*&---------------------------------------------------------------------*
*       Add fields to be displayed out of ALV-fieldcatalog to
*       variable data table for user-exit
*----------------------------------------------------------------------*
*      <-> PT_VARDATA  table with fields for user-exit
*      --> P_DISPVAR   record out of fieldcatalog
*----------------------------------------------------------------------*
FORM add_vardata TABLES   pt_vardata       STRUCTURE rn1uex
                 USING    VALUE(p_dispvar) LIKE      lvc_s_fcat.

  DATA: l_vardata  LIKE rn1uex.

* Sonderfall Diagnose: auch das globale KZ muß gesetzt sein
  IF g_diagdisp = off AND p_dispvar-fieldname = 'DIAGNOSE'.
*    exit.                                              " REM ID 7456
    p_dispvar-fieldname = 'DIAGNOSE_STD'.                   " ID 7456
  ENDIF.

  CLEAR l_vardata.
  l_vardata-o_name   = p_dispvar-fieldname.
  l_vardata-n_name   = p_dispvar-fieldname.
  l_vardata-o_leng   = p_dispvar-outputlen.
  l_vardata-n_leng   = p_dispvar-outputlen.
* l_vardata-n_value  = leer ! (wird vom User-Exit befüllt)
  l_vardata-n_header = p_dispvar-reptext.
* l_vardata-use_uex  = leer ! (wird vom User-Exit befüllt)
  APPEND l_vardata TO pt_vardata.

ENDFORM.                               " ADD_VARDATA

*&---------------------------------------------------------------------*
*&      Form  CALL_USEREXIT_DISP
*&---------------------------------------------------------------------*
*       Aufruf des User-Exits 'Feldanzeige'
*----------------------------------------------------------------------*
*      <-> PT_VARDATA    Felder und Werte
*      --> PT_SELVAR     Selektionsvariante
*      --> P_LIST_DATA   Daten (Patient, Fall, Bewegung, Listkz, ...)
*      --> P_CHECK_ONLY  Nur prüfen, ob UEx-Wert angez. wird (ON/OFF)
*----------------------------------------------------------------------*
FORM call_userexit_disp TABLES   pt_vardata          STRUCTURE rn1uex
                                 pt_selvar           STRUCTURE rsparams
                        USING    VALUE(p_list_data)  TYPE
                                               rnwp_care_unit_list_head
                                 VALUE(p_check_only) LIKE off.

  DATA: lt_nbew         LIKE TABLE OF nbew,
        l_bew           LIKE nbew,
        l_list_data_dep TYPE rnwp_care_unit_list_head.

* Bei P_CHECK_ONLY = ON stellt der User-Exit nur fest, ob der Wert
* aus dem User-Exit angezeigt werden soll (USE_UEX).
* Bei P_CHECK_ONLY = OFF stellt der User-Exit auch den Feldwert fest
* (N_VALUE)

* ID 7123: Bei Abgängen und Abwesenheiten sollen Diagnosen
*          für die 'alte' OE angezeigt werden
  CLEAR: l_bew, l_list_data_dep.
  READ TABLE gt_nbew INTO l_bew
       WITH TABLE KEY einri = p_list_data-einri
                      falnr = p_list_data-falnr
                      lfdnr = p_list_data-lfdnr.
  IF sy-subrc <> 0.
    IF NOT p_list_data-einri IS INITIAL AND                 "ID 17146
       NOT p_list_data-falnr IS INITIAL AND                 "ID 17146
       NOT p_list_data-lfdnr IS INITIAL.                    "ID 17146
      SELECT SINGLE * FROM nbew INTO l_bew
             WHERE  einri  = p_list_data-einri
             AND    falnr  = p_list_data-falnr
             AND    lfdnr  = p_list_data-lfdnr.
    ENDIF.                                                  "ID 17146
  ENDIF.
  IF p_list_data-listkz = 'D' OR l_bew-bewty = '6' OR l_bew-bewty = '7'.
*   ID 8521: für Abgangssicht auch tatsächl. markierte Bew. übergeben
    l_list_data_dep = p_list_data.
*   get all movements for that case
    CLEAR lt_nbew. REFRESH lt_nbew.
    LOOP AT gt_nbew INTO l_bew WHERE einri = p_list_data-einri
                                 AND falnr = p_list_data-falnr. "#EC *
      APPEND l_bew TO lt_nbew.
    ENDLOOP.
    DESCRIBE TABLE lt_nbew.
    IF sy-tfill = 0.
      IF NOT p_list_data-einri IS INITIAL  AND              "ID 17146
         NOT p_list_data-falnr IS INITIAL.                  "ID 17146
        SELECT * FROM nbew INTO TABLE lt_nbew
               WHERE  einri  = p_list_data-einri
               AND    falnr  = p_list_data-falnr.
      ENDIF.                                                "ID 17146
    ENDIF.
    CLEAR l_bew.
*   Suche die letzte Aufnahme-/Verlegungsbewegung
    PERFORM get_last_mov TABLES   lt_nbew
                         USING    p_list_data-lfdnr
                         CHANGING l_bew.
    IF NOT l_bew IS INITIAL.
      p_list_data-lfdnr = l_bew-lfdnr.
      p_list_data-orgfa = l_bew-orgfa.
      p_list_data-orgpf = l_bew-orgpf.
    ENDIF.
  ENDIF.

* 'EXIT_SAPLN1WP_001'
  CALL CUSTOMER-FUNCTION '001'
    EXPORTING
      i_list_data        = p_list_data
      i_list_data_depart = l_list_data_dep            " ID 8521
      i_check_only       = p_check_only
    TABLES
      t_vardata          = pt_vardata
      t_selvar           = pt_selvar.

ENDFORM.                               " CALL_USEREXIT_DISP

*&---------------------------------------------------------------------*
*&      Form  GET_FALL_BEWEGUNG
*&---------------------------------------------------------------------*
*       Sucht zum aktuellen Fall die letztgültigen Bewegungsdaten
*       (Hopfgartner: 2000-02-22)
*----------------------------------------------------------------------*
*      -->P_MOVEMENT    Fall/Einrichtung/Bewegung
*      <--P_FAL         Datensatz mit aktuellen Falldaten
*      <--P_BEW         Datensatz mit aktuellen Bewegungsdaten
*      <--L_ERRFAL      Fehlercode (0=OK, 1=Kein Fall, 2=Keine Bewegung)
*----------------------------------------------------------------------*
FORM get_fall_bewegung USING    p_movement TYPE rnwp_care_unit_list_head
                       CHANGING p_fal LIKE nfal
                                p_bew LIKE nbew
                                p_errfal LIKE sy-subrc.

* Falldaten lesen
  SELECT SINGLE * FROM nfal INTO p_fal
         WHERE  einri  = p_movement-einri
         AND    falnr  = p_movement-falnr.
  IF sy-subrc <> 0.
    p_errfal = 1.
    EXIT.
  ENDIF.

* Bewegungsdaten lesen
  IF p_bew IS INITIAL.
    READ TABLE gt_nbew INTO p_bew
         WITH TABLE KEY einri = p_movement-einri
                        falnr = p_movement-falnr
                        lfdnr = p_movement-lfdnr.
    IF sy-subrc <> 0.
      SELECT SINGLE * FROM nbew INTO p_bew
             WHERE  einri  = p_movement-einri
             AND    falnr  = p_movement-falnr
             AND    lfdnr  = p_movement-lfdnr.
      IF sy-subrc <> 0.
        p_errfal = 2.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.                               " GET_FALL_BEWEGUNG

*&---------------------------------------------------------------------*
*&      Form  CALL_MEDDOKU
*&---------------------------------------------------------------------*
*       Aufruf medizinische Dokumentation (Hopfgartner: 2000-02-28)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      -->P_fcode         Funktionscode
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_meddoku TABLES   pt_messages    STRUCTURE bapiret2
                  USING    p_lt_movements TYPE
                                          ishmed_t_care_unit_list_head
                           p_fcode      LIKE rseu1-func
                  CHANGING p_rc         LIKE sy-subrc
                           p_refresh    LIKE n1fld-refresh.

* Datendefinitionen
  DATA: l_bew      LIKE nbew,
        l_fal      LIKE nfal,
        l_npat     LIKE npat,
        l_movement TYPE rnwp_care_unit_list_head,
        l_wa_msg   LIKE bapiret2,
        l_errfal   LIKE sy-subrc,     "Fehlerprüfung Fall/Bewegung
        l_lines    LIKE sy-tabix,     "Anzahl Zeilen
        l_selkr    LIKE rn200-selkr,  "Selektionskriterien für Doku
        l_trcode   LIKE sy-tcode,     "Transaktionscode.
*        l_extcode   LIKE sy-tcode,     "Ausgeführter Transaktionscode
        l_einri    LIKE ndia-einri,   "Einrichtung
        ltc_auth   TYPE i,            "Flag ob Berechtigung für Tcode
        lt_nbew    TYPE TABLE OF nbew,                      " ID 11429
        l_oepf     LIKE nbew-orgpf,        "Pflegerische OE
        l_oefa     LIKE nbew-orgfa.        "Fachliche OE

* Daten für den Aufruf Call_Meddoku
  DATA:  BEGIN OF l_meddoku_ndoc OCCURS 1.
          INCLUDE STRUCTURE ndoc.
  DATA: END OF l_meddoku_ndoc.

* Initialisierung
  CLEAR: p_rc, p_refresh, l_bew, l_fal, l_npat, l_movement, l_wa_msg,
         l_errfal, l_lines, l_selkr, l_trcode, l_einri,
         ltc_auth, l_oepf, l_oefa.

  CLEAR: l_meddoku_ndoc.      REFRESH: l_meddoku_ndoc.
  l_meddoku_ndoc-medok = 'X'.          "Keine MED Dokumente gestattet

  ltc_auth = false.
  l_selkr = space.

* Check ob Fall übergeben wurde oder ohne Markierung
  READ TABLE p_lt_movements INTO l_movement INDEX 1.
  l_einri = l_movement-einri.
  l_oepf = l_movement-orgpf.
  l_oefa = l_movement-orgfa.

  IF l_movement-falnr IS INITIAL AND l_movement-patnr IS INITIAL.
    l_lines = 0.                       "Keine Bewegung markiert
  ELSE.
    DESCRIBE TABLE p_lt_movements LINES l_lines.
    IF sy-tfill > 1.
      PERFORM build_bapiret2(sapmn1pa)
        USING 'E' 'NF' '054' l_movement-falnr space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.

    ENDIF.
  ENDIF.

* Es kann entweder kein Patient oder 1 Patient markiert gewesen sein.
  CASE l_lines.
    WHEN 0.
*     Löschen von Variablen im Memory
      SET PARAMETER ID 'PAT' FIELD space.
      SET PARAMETER ID 'PZP' FIELD space.
      SET PARAMETER ID 'FAL' FIELD space.
      SET PARAMETER ID 'PZF' FIELD space.
    WHEN OTHERS.
*     Fall- und Bewegungsdaten lesen zum Fall (nur 1 möglich)
      READ TABLE p_lt_movements INTO l_movement INDEX 1.

*     ID 11443: Begin of Insert
*     Bei Abgängen soll die 'alte' Bewegung verwendet werden
      IF l_movement-listkz = 'D'.
        REFRESH lt_nbew.
*       Alle Bewegungen zum Fall aus dem Puffer holen
        LOOP AT gt_nbew INTO l_bew
                WHERE einri = l_movement-einri
                  AND falnr = l_movement-falnr.             "#EC *
          APPEND l_bew TO lt_nbew.
        ENDLOOP.
*       Wenn im Puffer nichts gefunden wird, aus der DB lesen
        DESCRIBE TABLE lt_nbew.
        IF sy-tfill = 0.
          SELECT * FROM nbew INTO TABLE lt_nbew
                 WHERE  einri  = l_movement-einri
                 AND    falnr  = l_movement-falnr
                 AND    storn  = off.
        ENDIF.
*       Suche letzte Aufnahme- oder Verlegungsbewegung
        CLEAR l_bew.
        PERFORM get_last_mov TABLES   lt_nbew
                             USING    l_movement-lfdnr
                             CHANGING l_bew.
        IF NOT l_bew IS INITIAL.
          l_movement-lfdnr = l_bew-lfdnr.
          l_movement-orgpf = l_bew-orgpf.
          CLEAR l_bew.
        ENDIF.
      ENDIF.
*     ID 11443: End of Insert

      PERFORM get_fall_bewegung USING     l_movement
                                CHANGING  l_fal
                                          l_bew
                                          l_errfal.
*     Fehler in Bezug auf den Fall/Bewegung
      CASE l_errfal.
        WHEN 1.
          PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF' '051' l_movement-falnr space space space
                                       space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
          EXIT.
        WHEN 2.
          PERFORM build_bapiret2(sapmn1pa)
                  USING 'E' 'NF' '076' space space space space
                                       space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
          EXIT.
*         Fall/Bewegung ist OK.
        WHEN 0.
*         Daten aus NPAT für den aktuellen Fall lesen.
          PERFORM get_patient_data TABLES   pt_messages
                                   USING    l_fal
                                   CHANGING l_npat
                                            p_rc.
          CHECK p_rc EQ 0.
      ENDCASE.
  ENDCASE.
* Vorbelegung der Übergabeparameter abhängig vom Funktionscode

  l_trcode = 'N204'.   "Vorbelegung Transaktionscode für FuB

  CASE p_fcode.
*   *******************************************************************
*   Neues Dokument anlegen
*   *******************************************************************
    WHEN 'DCRE'.
      CASE l_lines.
        WHEN 0.
          l_trcode = 'N201'.                                " ID 8962
*         Aufruf mit Selektionsbildschirm nur Einrichtung übergeben
          l_meddoku_ndoc-einri = l_einri.
*   Auch beim allgemeinen Einstieg in das EB der Dokumentenliste sollte
*   keine Auswahl eines technischen Dokuments möglich sein
*   Daher wird die Variable NDOC-MEDOK = X in die Memory-ID 'NDOC-MEDOK'
*   exportieren, welche in dem Programm SAPMN2EI importiert werden muß
          l_meddoku_ndoc-medok = 'X'.
          EXPORT l_meddoku_ndoc-medok TO MEMORY ID 'NDOC-MEDOK'.
        WHEN OTHERS.
          l_trcode = 'N201'.
*         Daten in die Übergabetablle für FuB ISH_N2_MEDICAL_DOCUMENT
*         schreiben
          l_meddoku_ndoc-mandt = l_fal-mandt.
          l_meddoku_ndoc-einri = l_fal-einri.
          l_meddoku_ndoc-patnr = l_fal-patnr.
          l_meddoku_ndoc-falnr = l_fal-falnr.
*         Anlegen technischer Dokumente ist nicht gestattet
          l_meddoku_ndoc-medok = 'X'.
          l_meddoku_ndoc-orgfa = l_bew-orgfa.
          l_meddoku_ndoc-orgpf = l_bew-orgpf.
*         Annahme Erbringende OE ist immer die OE für welche die
*         Stationsliste aufgerufen wurde.
          l_meddoku_ndoc-orgle = l_meddoku_ndoc-orgpf.
          l_meddoku_ndoc-lfdbew = l_bew-lfdnr.
*          APPEND l_meddoku_ndoc.
      ENDCASE.

*   ******************************************************************
*   Dokumentenliste je nach Aufrufendem Fcode Daten vorbelegen
*   ******************************************************************
    WHEN 'DF01'. " Dokumentenliste - Freigegebene - Befunde
      l_selkr = 'SEL01'.
      l_meddoku_ndoc-orgpf = l_oepf.
      l_meddoku_ndoc-orgla = l_oepf.                        " ID 2309
    WHEN 'DO01'. " Dokumentenliste - Offene Dokumente - Mitarbeiter
      l_selkr = 'SEL02'.
    WHEN 'DO02'. " Dokumentenliste - Offene Dokumente - Dok. OE
      l_selkr = 'SEL03'.
      l_meddoku_ndoc-orgdo = l_oepf.
    WHEN 'DH01'. " Dokumentenliste - Dokumente heute - Mitarbeiter
      l_selkr = 'SEL04'.
    WHEN 'DH02'. " Dokumentenliste - Dokumente heute - Dok. OE
      l_selkr = 'SEL05'.
      l_meddoku_ndoc-orgdo = l_oepf.
    WHEN 'DH03'. " Dokumentenliste - Dokumente heute - Fachl. OE
      l_selkr = 'SEL06'.
      l_meddoku_ndoc-orgfa = l_oefa.
    WHEN OTHERS.
      CLEAR l_selkr.

  ENDCASE.                             "Ende Case für FCodes

* ID 13574: preallocate set/get-parameter DTY (document type)
  IF l_trcode = 'N201'.
    CALL FUNCTION 'ISHMED_SET_GET_DTY'
      EXPORTING
        i_institution = l_einri
        i_date        = sy-datum
        i_orgid       = l_oepf.
  ENDIF.

  IF l_lines EQ 1 OR NOT l_selkr IS INITIAL.
    l_meddoku_ndoc-mandt  = l_bew-mandt.
    l_meddoku_ndoc-einri  = l_bew-einri.
    l_meddoku_ndoc-patnr  = l_npat-patnr.
*   PATIENTENBEZOGENE Übersicht => ohne Fallnummer
    IF p_fcode NE 'DOKP'.
      l_meddoku_ndoc-falnr  = l_fal-falnr.
    ENDIF.

    APPEND l_meddoku_ndoc.

*   Da beim Aufruf von Dokument anlegen auf der Dokumentenliste von
*   der GSD nicht der übergebene Key, sondern SET/GET-Parameter
*   verwendet wird, muß dieser hier noch gesetzt werden, da sonst ein
*   Dokument zu einem ganz anderen Patienten angelegt wird
    SET PARAMETER ID 'PAT' FIELD l_npat-patnr.
    SET PARAMETER ID 'PZP' FIELD l_npat-pziff.
    IF p_fcode EQ 'DOKP'.
      SET PARAMETER ID 'FAL' FIELD space.
      SET PARAMETER ID 'PZF' FIELD space.
    ELSE.
      SET PARAMETER ID 'FAL' FIELD l_fal-falnr.
      SET PARAMETER ID 'PZF' FIELD l_fal-fziff.
    ENDIF.

*   Ab hier erfolgt der eigentliche Aufruf der Bausteine.
    CALL FUNCTION 'ISH_N2_MEDICAL_DOCUMENT'
      EXPORTING
        ss_einri           = l_einri
        ss_tcode           = l_trcode
        ss_selkr           = l_selkr
        ss_set_screen_flag = ' '                            " ID15875
      TABLES
        ss_ndoc            = l_meddoku_ndoc
      EXCEPTIONS
        no_document        = 1
        no_insert          = 2
        cancel             = 3.

    CASE sy-subrc.
      WHEN 0.
        p_rc = 0.
        p_refresh = 1.
      WHEN 1.
*       Fehler bei der Verarbeitung (Nr. &)
        PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' sy-subrc space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
      WHEN 2 OR 3.                     " Abbruch, kein Dokument
        p_rc = 2.
        p_refresh = 0.
    ENDCASE.
  ELSE.
*   Um zum Einstiegsbild der Dokumentenselektion zu gelangen, muß man
*   die Transaktion N204 direkt aufrufen => funkt. über FBS nicht
    PERFORM call_tcode(sapmnpa0) USING l_trcode l_einri off ltc_auth.
    IF ltc_auth EQ false.
*     Fehler bei der Verarbeitung (Nr. &)
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' sy-subrc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
    ENDIF.
    p_rc = 0.
    p_refresh = 2.
  ENDIF.

* BEGIN BODEN M. 18.12.2002 ID 10202
*  Erzeugte eine Systemabbruchsmeldung
*  SET SCREEN sy-dynnr.                                    " ID 6768
* BEGIN BODEN M. 18.12.2002 ID 10202

ENDFORM.                               " CALL_MEDDOKU

*&---------------------------------------------------------------------*
*&      Form  CALL_MONITOR_OP
*&---------------------------------------------------------------------*
*       Aufruf OP-Monitor aus dem Stationsarbeitsplatz
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      -->PR_ENVIRONMENT  Environment
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_monitor_op TABLES   pt_messages STRUCTURE bapiret2
                     USING    p_lt_movements TYPE
                                          ishmed_t_care_unit_list_head
                              pr_environment TYPE REF TO
                                          cl_ish_environment
                     CHANGING p_rc LIKE sy-subrc
                              p_refresh LIKE n1fld-refresh.

* Datendefinitionen
  DATA: l_bew         LIKE nbew,
        l_fal         LIKE nfal,
        l_npat        LIKE npat,
        l_nbew        TYPE nbew,                            " ID 9789
        l_orgid       TYPE orgid,                           " ID 9789
        lt_nlem_anker TYPE TABLE OF nlem,                   " ID 9789
        ls_nlem       TYPE nlem,                            " ID 14859
        l_tn00r       TYPE tn00r,
        l_movement    TYPE rnwp_care_unit_list_head,
        l_wa_msg      LIKE bapiret2,
        l_errfal      LIKE sy-subrc,     "Fehlerprüfung Fall/Bewegung
        l_wa_n1anftyp TYPE n1anftyp.     "Workarea für n1anftyp

  DATA: l_open_nodes(5) TYPE c VALUE 'XXXXX'.

* Zusätzliche Datendefinitionen übernommen aus alter Stationsliste
  DATA: display       LIKE tnt0  OCCURS 2  WITH HEADER LINE.
  DATA: in1anf        LIKE n1anf OCCURS 10 WITH HEADER LINE.
  DATA: lt_n1vkg TYPE TABLE OF n1vkg,                       " ID 11089
        l_n1vkg  LIKE LINE OF lt_n1vkg.                     " ID 11089
  DATA: flag(1)       TYPE c.
  DATA: patname(30)   TYPE c.
  DATA: n2anklop      LIKE nlei-leist.

  DATA: BEGIN OF in2anklop OCCURS 20.
  DATA: lnrls LIKE nlei-lnrls.
  DATA: ibgdt LIKE nlei-ibgdt.
  DATA: ibzt  LIKE nlei-ibzt.
  DATA: lfdbew LIKE nlei-lfdbew.                            " ID 9789
  DATA: END   OF in2anklop.

  DATA: BEGIN OF inllz OCCURS 20.
  DATA: lnrls2 LIKE nllz-lnrls2.
  DATA: END   OF inllz.

  DATA: BEGIN OF inlem OCCURS 20.
  DATA: anfid LIKE nlem-anfid,
        vkgid LIKE nlem-vkgid.                              " ID 11089
  DATA: END   OF inlem.

  DATA: op_n1anf LIKE n1anf,
        op_n1vkg LIKE n1vkg.                                " ID 11089

* Initialisierung
  CLEAR: p_rc, p_refresh, l_bew, l_fal, l_npat, l_movement, l_wa_msg,
         l_errfal, n2anklop, l_orgid, l_nbew.

* Es ist immer genau ein Patient markiert

* Fall- und Bewegungsdaten lesen zum Fall (nur 1 möglich)
  READ TABLE p_lt_movements INTO l_movement INDEX 1.
  PERFORM get_fall_bewegung USING     l_movement
                            CHANGING  l_fal
                                      l_bew
                                      l_errfal.

* in der Zugangssicht sind auch Aufnahmetermine wählbar!
  IF NOT l_movement-tmnid IS INITIAL.
    CLEAR l_errfal.
    l_fal-einri = l_movement-einri.
    l_fal-patnr = l_movement-patnr.
  ENDIF.

* Fehler in Bezug auf den Fall/Bewegung
  CASE l_errfal.
    WHEN 1.
      PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF' '051' l_movement-falnr space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 2.
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '076' space space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
*   Fall/Bewegung ist OK.
    WHEN 0.
  ENDCASE.

* Daten aus NPAT für den aktuellen Fall lesen.
  PERFORM get_patient_data TABLES   pt_messages
                           USING    l_fal
                           CHANGING l_npat
                                    p_rc.
  CHECK p_rc EQ 0.

* Aufruf des OP-Monitors mit der jüngsten OP
  CLEAR op_n1anf.
* Ermitteln der Ankerleistung aus dem Parameter N2ANKLOP
  IF n2anklop IS INITIAL.
    PERFORM ren00r(sapmnpa0) USING l_fal-einri 'N2ANKLOP' l_tn00r-value.
    n2anklop = l_tn00r-value.
  ENDIF.

  IF NOT l_fal-falnr IS INITIAL.
    SELECT lnrls ibgdt ibzt lfdbew FROM nlei INTO TABLE in2anklop
        WHERE einri EQ l_fal-einri
          AND falnr EQ l_fal-falnr
          AND leist EQ n2anklop
          AND storn EQ off.
  ENDIF.
* ID 9789: auch fallfreie OPs zum Patienten berücksichtigen
  SELECT * FROM nlem INTO TABLE lt_nlem_anker
         WHERE  patnr  = l_fal-patnr
*         AND    falnr  = space                         " REM ID 19221
         AND    ankls  = 'X'.
  IF sy-subrc = 0.
    DELETE lt_nlem_anker WHERE falnr IS NOT INITIAL.        " ID 19221
    IF lt_nlem_anker[] IS NOT INITIAL.                      " ID 19221
      SELECT lnrls ibgdt ibzt lfdbew FROM nlei APPENDING TABLE in2anklop
          FOR ALL ENTRIES IN lt_nlem_anker
          WHERE lnrls EQ lt_nlem_anker-lnrls
            AND storn EQ off.
    ENDIF.                                                  " ID 19221
  ENDIF.
  SORT in2anklop BY ibgdt DESCENDING ibzt DESCENDING lnrls.

  LOOP AT in2anklop.
*   ID 14859: Begin of INSERT
*   check if this is a clinical order
    REFRESH: in1anf, lt_n1vkg, inllz, inlem.
    SELECT SINGLE * FROM nlem INTO ls_nlem
           WHERE lnrls = in2anklop-lnrls.
    CHECK sy-subrc = 0.

    IF NOT ls_nlem-vkgid IS INITIAL.

      SELECT SINGLE * FROM n1vkg INTO l_n1vkg
             WHERE vkgid  = ls_nlem-vkgid
               AND patnr <> space
               AND auspr EQ 'OP'
               AND storn EQ off.
      CHECK sy-subrc = 0.
      APPEND l_n1vkg TO lt_n1vkg.

    ELSE.
*     ID 14859: End of INSERT

*     Einlesen aller zur Ankerleistung gehörenden Leistungen über
*     NLLZ (Zuordnungstyp F -> angeforderte Maßnahmen)
      SELECT lnrls2 FROM nllz INTO TABLE inllz
          WHERE einri  EQ l_fal-einri
            AND lnrls1 EQ in2anklop-lnrls
            AND zotyp  EQ 'F'.
*     ID 9789: wenn keine Leistungen angefordert -> Not-OP
      IF sy-subrc <> 0.
        IF NOT l_fal-falnr IS INITIAL.
          IF in2anklop-lfdbew IS INITIAL.                   " ID 14859
            CONTINUE.                                       " ID 14859
          ELSE.                                             " ID 14859
            SELECT SINGLE * FROM nbew INTO l_nbew
                   WHERE  einri  = l_fal-einri
                   AND    falnr  = l_fal-falnr
                   AND    lfdnr  = in2anklop-lfdbew.
            IF sy-subrc = 0.
              EXIT.
            ELSE.                                           " ID 14859
              CONTINUE.                                     " ID 14859
            ENDIF.
          ENDIF.                                            " ID 14859
        ENDIF.
        CONTINUE.                                           " ID 14859
      ENDIF.

*     Einlesen der NLEM-Einträge zu den Leistungen, um zur Anf.ID
*     zu gelangen
*     SELECT anfid FROM nlem INTO TABLE inlem           " REM ID 11089
      SELECT anfid vkgid FROM nlem INTO TABLE inlem         " ID 11089
          FOR ALL ENTRIES IN inllz
          WHERE lnrls EQ inllz-lnrls2.
      CHECK sy-subrc EQ 0.

*     Einlesen aller Anforderungen zu den NLEM-Einträgen
      SELECT * FROM n1anf INTO TABLE in1anf
          FOR ALL ENTRIES IN inlem
          WHERE einri EQ l_fal-einri
            AND anfid EQ inlem-anfid
            AND storn EQ off.
      DELETE in1anf WHERE anfid IS INITIAL.
*      CHECK sy-subrc EQ 0.                             " REM ID 11089
*      IF sy-subrc <> 0.                " Begin ID 11089  REM ID 14859
      IF in1anf[] IS INITIAL.                               " ID 14859
*       Einlesen aller Vormerkungen zu den NLEM-Einträgen
*       Überprüfung, ob die Vormerkung auch eine OP-Vormerkung ist
        SELECT * FROM n1vkg INTO TABLE lt_n1vkg
            FOR ALL ENTRIES IN inlem
            WHERE einri EQ l_fal-einri
              AND vkgid EQ inlem-vkgid
              AND patnr <> space
              AND auspr EQ 'OP'
              AND storn EQ off.
        CHECK sy-subrc = 0.
        DELETE lt_n1vkg WHERE vkgid IS INITIAL.
      ENDIF.                                            " End ID 11089

    ENDIF.                                                  " ID 14859

*   Sortierung der IN1ANF, damit bei zeitgleichen OP-Anforderungen
*   zumindest immer dieselbe für den OP-Monitor genommen wird
    SORT in1anf BY mandt einri anfid.
    SORT lt_n1vkg BY mandt einri vkgid.                     " ID 11089

    LOOP AT in1anf.
*     Überprüfung, ob die Anforderung auch eine OP-Anforderung ist
      SELECT SINGLE * FROM n1anftyp INTO l_wa_n1anftyp
             WHERE anfty EQ in1anf-anfty
               AND auspr EQ 'OP'.
      CHECK sy-subrc EQ 0.
      op_n1anf = in1anf.
      EXIT.
    ENDLOOP.
    IF sy-subrc <> 0.                                 " Begin ID 11089
      LOOP AT lt_n1vkg INTO l_n1vkg.
        op_n1vkg = l_n1vkg.
        EXIT.
      ENDLOOP.
      CHECK NOT op_n1vkg IS INITIAL.
    ELSE.                                               " End ID 11089
      CHECK NOT op_n1anf IS INITIAL.
    ENDIF.                                                  " ID 11089
    EXIT.
  ENDLOOP.

  IF op_n1anf IS INITIAL AND l_nbew IS INITIAL AND
     op_n1vkg IS INITIAL.                                   " ID 11089
*   Für die "verkettete" Ausgabe des Patientennamens, Titel etc. auf
*   Listen muß eine andere Form-Routine der SAP aufgerufen werden
    PERFORM concat_name_list(sapmnpa0)
            USING l_npat-titel l_npat-vorsw
                  l_npat-nname l_npat-vname
                  patname.
*   Der Patient hat keine OP-Anf und Bewegung vorhanden
    PERFORM build_bapiret2(sapmn1pa)
             USING 'E' 'NF1' '370' patname space space space
                                   space space space
             CHANGING l_wa_msg.
    APPEND l_wa_msg TO pt_messages.
    p_rc = 1.
    p_refresh = 0.
    EXIT.
  ENDIF.         " op_n1anf is initial and l_nbew is initial.

  CLEAR display. REFRESH display.
  display-einri = l_fal-einri.

  DO 6 TIMES.
    CASE sy-index.
      WHEN 1.
        display-zotyp = 'LSV'.         " Präop.
      WHEN 2.
        display-zotyp = 'LSN'.         " Postop.
      WHEN 3.
        display-zotyp = 'LSI'.         " Intraop.
      WHEN 4.
        display-zotyp = 'DOK'.         " Dokumente
      WHEN 5.
        display-zotyp = 'DIA'.         " Diagnosen
      WHEN 6.
        display-zotyp = 'RIS'.         " Risikofaktoren
    ENDCASE.
*   OP-Monitor: 'X'...Geschlossen!!!
    flag = l_open_nodes(1).
    IF flag = 'X'.
      display-pflkz = space.
    ELSE.
      display-pflkz = 'X'.
    ENDIF.
    APPEND display.
    SHIFT l_open_nodes LEFT BY 1 PLACES.
  ENDDO.

  IF NOT op_n1anf IS INITIAL.                               " ID 9789
    l_orgid = op_n1anf-orgid.                               " ID 9789
  ELSEIF NOT op_n1vkg IS INITIAL.                           " ID 11089
    l_orgid = op_n1vkg-etroe.                               " ID 11089
  ELSE.                                                     " ID 9789
    l_orgid = l_nbew-orgpf.                                 " ID 9789
  ENDIF.                                                    " ID 9789

  CALL FUNCTION 'ISHMED_OP_MONITOR'
    EXPORTING
      i_orgid        = l_orgid
      i_n1anf        = op_n1anf
      i_n1vkg        = op_n1vkg                             " ID 11089
      i_nbew         = l_nbew                               " ID 5143
      ir_environment = pr_environment
    TABLES
      display        = display
    EXCEPTIONS
      OTHERS         = 1.
  CASE sy-subrc.
    WHEN 0.
      p_rc = 0.
      p_refresh = 1.
    WHEN OTHERS.
*     Fehler bei der Verarbeitung (Nr. &)
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' sy-subrc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
  ENDCASE.

ENDFORM.                               " CALL_MONITOR_OP

*&---------------------------------------------------------------------*
*&      Form  GET_OP_FOR_DWS
*&---------------------------------------------------------------------*
*       OPs für den Aufruf des OP-Arbeitsplatzes im DWS ermitteln
*----------------------------------------------------------------------*
*      <-- PT_MESSAGES     Meldungen
*      --> PT_MOVEMENTS    Bewegungen
*      --> PR_ENVIRONMENT  Environment
*      <-- PT_OBJECTS      Operationen (Ankerleistungen)
*      <-- P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*----------------------------------------------------------------------*
FORM get_op_for_dws TABLES   pt_messages  STRUCTURE bapiret2
                    USING    pt_movements TYPE
                                          ishmed_t_care_unit_list_head
                             pr_environment TYPE REF TO
                                            cl_ish_environment
                    CHANGING pt_objects     TYPE ish_objectlist
                             p_rc           TYPE sy-subrc.

  TYPES: BEGIN OF ty_n2anklop,
           lnrls  TYPE nlei-lnrls,
           ibgdt  TYPE nlei-ibgdt,
           ibzt   TYPE nlei-ibzt,
           lfdbew TYPE nlei-lfdbew,
           dif    TYPE i,        "MED-48003 AGujev
         END   OF ty_n2anklop.

  DATA l_dif TYPE i.                  "MED-48003 AGujev
  FIELD-SYMBOLS <fs_n2anklop> TYPE ty_n2anklop.   "MED-48003 AGujev

  DATA: lt_n2anklop TYPE TABLE OF ty_n2anklop,
        ls_n2anklop LIKE LINE OF lt_n2anklop.

  DATA: ls_bew        TYPE nbew,
        ls_fal        TYPE nfal,
        lt_nlem_anker TYPE TABLE OF nlem,
        ls_tn00r      TYPE tn00r,
        ls_movement   TYPE rnwp_care_unit_list_head,
        ls_object     LIKE LINE OF pt_objects,
        l_wa_msg      TYPE bapiret2,
        l_errfal      TYPE sy-subrc,
        l_n2anklop    TYPE nlei-leist,
        l_rc          TYPE ish_method_rc,
        lr_srv        TYPE REF TO cl_ishmed_service.

  CLEAR: p_rc, l_n2anklop, pt_objects[].

  LOOP AT pt_movements INTO ls_movement.

    CLEAR:   ls_fal, ls_bew, l_errfal, l_wa_msg.
    REFRESH: lt_n2anklop, lt_nlem_anker.

    IF ls_movement-einri IS INITIAL OR
       ls_movement-patnr IS INITIAL.
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '413' space space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      EXIT.
    ENDIF.

*   get case and movement data
    PERFORM get_fall_bewegung USING     ls_movement
                              CHANGING  ls_fal
                                        ls_bew
                                        l_errfal.

*   in der Zugangssicht sind auch Aufnahmetermine wählbar!
    IF ls_movement-tmnid IS NOT INITIAL.
      CLEAR l_errfal.
      ls_fal-einri = ls_movement-einri.
      ls_fal-patnr = ls_movement-patnr.
    ENDIF.

*   error with case/movement
    CASE l_errfal.
      WHEN 1.
        PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '051' ls_movement-falnr space space space
                                   space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        EXIT.
      WHEN 2.
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '076' space space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        EXIT.
    ENDCASE.

*   get name of anchor service from parameter N2ANKLOP
    IF l_n2anklop IS INITIAL.
      PERFORM ren00r(sapmnpa0)
        USING ls_fal-einri 'N2ANKLOP' ls_tn00r-value.
      l_n2anklop = ls_tn00r-value.
    ENDIF.

*   get surgeries for case
    IF ls_fal-falnr IS NOT INITIAL.
      SELECT lnrls ibgdt ibzt lfdbew FROM nlei INTO TABLE lt_n2anklop
          WHERE einri EQ ls_fal-einri
            AND falnr EQ ls_fal-falnr
            AND leist EQ l_n2anklop
            AND storn EQ off.
    ENDIF.
*--> MED-48003 if surgeries were found for the case we have to consider only these!
    IF lt_n2anklop[] IS INITIAL.                            "MED-48003
*   get surgeries for patient (caseless)
      SELECT * FROM nlem INTO TABLE lt_nlem_anker
             WHERE  patnr  = ls_fal-patnr
             AND    ankls  = 'X'.
      IF sy-subrc = 0.
*--> MED-48003 if there are no surgeries for the given case, we search for caseless surgeries
*--> MED-48003 if there are no caseless surgeries, we search for surgeries from different cases!
        LOOP AT lt_nlem_anker TRANSPORTING NO FIELDS WHERE falnr IS INITIAL. "MED-48003
        ENDLOOP.                                            "MED-48003
        IF sy-subrc = 0.                                    "MED-48003
          DELETE lt_nlem_anker WHERE falnr IS NOT INITIAL.
        ENDIF.                                              "MED-48003
        IF lt_nlem_anker[] IS NOT INITIAL.
          SELECT lnrls ibgdt ibzt lfdbew FROM nlei
                 APPENDING TABLE lt_n2anklop
                 FOR ALL ENTRIES IN lt_nlem_anker
                 WHERE lnrls EQ lt_nlem_anker-lnrls
                   AND storn EQ off.
        ENDIF.
      ENDIF.
    ENDIF.                                                  "MED-48003

*   get latest surgery
*    SORT lt_n2anklop BY ibgdt DESCENDING ibzt DESCENDING lnrls.  "MED-48003
*-->begin of MED-48003 AGujev
*MED-48003 we find the surgery which is closest to the day of the selection
*******************************************************************
    LOOP AT lt_n2anklop ASSIGNING <fs_n2anklop>.
      l_dif = <fs_n2anklop>-ibgdt - sy-datum.
      IF l_dif < 0.
        l_dif = l_dif * -1.
      ENDIF.
      <fs_n2anklop>-dif = l_dif.
    ENDLOOP.
    SORT lt_n2anklop BY dif ASCENDING.
*******************************************************************
*<--end of MED-48003   AGujev

    READ TABLE lt_n2anklop INTO ls_n2anklop INDEX 1.
    CHECK sy-subrc = 0.


    CALL METHOD cl_ishmed_service=>load
      EXPORTING
        i_lnrls       = ls_n2anklop-lnrls
        i_environment = pr_environment
      IMPORTING
        e_instance    = lr_srv
        e_rc          = l_rc.
    CHECK l_rc = 0.

    CLEAR ls_object.
    ls_object-object = lr_srv.
    APPEND ls_object TO pt_objects.

  ENDLOOP.

  CHECK p_rc = 0.

  IF pt_objects IS INITIAL.
*   Zu diesem Patienten wurde keine Operation gefunden
    PERFORM build_bapiret2(sapmn1pa)
             USING 'E' 'N1SRVDO_MED' '040' space space space space
                                           space space space
             CHANGING l_wa_msg.
    APPEND l_wa_msg TO pt_messages.
    p_rc = 1.
    EXIT.
  ENDIF.

ENDFORM.                               " GET_OP_FOR_DWS

*&---------------------------------------------------------------------*
*&      Form  GET_PATIENT_DATA
*&---------------------------------------------------------------------*
*       Patientendaten zu einem Fall ermitteln
*----------------------------------------------------------------------*
*      <--PT_MESSAGES   Meldungen
*      -->P_FAL         Fall für den die Patientendaten ermittelt werden
*      <--P_NPAT        Patientendaten
*      <--P_RC          Errorcode (0=OK, 1=Patient nicht gefunden)
*----------------------------------------------------------------------*
FORM get_patient_data TABLES   pt_messages STRUCTURE bapiret2
                      USING    p_fal LIKE nfal
                      CHANGING p_npat LIKE npat
                               p_rc LIKE sy-subrc.

* Datendefinition
  DATA: l_wa_msg LIKE bapiret2,
        l_rc     TYPE ish_method_rc.

* Initialisierungen
  CLEAR: l_wa_msg.

* Patientendaten holen
  CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
    EXPORTING
      i_patnr   = p_fal-patnr
      i_read_db = on
    IMPORTING
      es_npat   = p_npat
      e_rc      = l_rc.

  IF l_rc NE 0.
    PERFORM build_bapiret2(sapmn1pa)
             USING 'E' 'NF' '387' p_fal-patnr space space space
                                  space space space
             CHANGING l_wa_msg.
    APPEND l_wa_msg TO pt_messages.
    p_rc = 1.
  ENDIF.

ENDFORM.                               " GET_PATIENT_DATA

*&---------------------------------------------------------------------*
*&      Form  CALL_LABOR_KUM_BEF
*&---------------------------------------------------------------------*
*       Laborkumulativbefund aufrufen aus dem Stationsarbeitsplatz
*       (Hopfgartner: 2000-02-29)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_labor_kum_bef TABLES   pt_messages STRUCTURE bapiret2
                        USING    p_lt_movements TYPE
                                          ishmed_t_care_unit_list_head
                        CHANGING p_rc LIKE sy-subrc
                                 p_refresh LIKE n1fld-refresh.

* Datendefinitionen
  DATA: l_bew             LIKE nbew,
        l_fal             LIKE nfal,
        l_display_mode(1) TYPE c,
        l_movement        TYPE rnwp_care_unit_list_head,
        l_wa_msg          LIKE bapiret2,
        l_errfal          LIKE sy-subrc.     "Fehlerprüfung Fall/Bewegung

* Initialisierung
  CLEAR: p_rc, p_refresh, l_bew, l_fal, l_movement, l_wa_msg, l_errfal.


* Check ob Fall übergeben wurde oder ohne Markierung
* Verarbeitung (entweder keiner oder 1 Datensatz markiert)
  READ TABLE p_lt_movements INTO l_movement INDEX 1.
  IF l_movement-falnr IS INITIAL AND l_movement-patnr IS INITIAL.

    CALL FUNCTION 'ISH_N2_DISPLAY_LAB_DATA'
      EXPORTING
        ss_einri          = l_movement-einri
        ss_oe             = l_movement-orgpf
      IMPORTING
        e_display_mode    = l_display_mode
      EXCEPTIONS
        err_nodata        = 1
        err_system_failed = 2
        OTHERS            = 3.

    CASE sy-subrc.
      WHEN 0.
        p_rc = 0.
        IF l_display_mode = '1'. " see OSS 513015 2009/note 1353714
          p_refresh = 2.
        ELSE.
          p_refresh = 0.
        ENDIF.
*     AE, 23.5.2002: Hinweis 522011 (CSS 247825)
*     Exception 1 wie die anderen behandeln (keine eigene Meldung,
*     sondern die vom FuB ausgeben!)
*      when 1.
**       Keine Labordaten vorhanden
*        perform build_bapiret2(sapmn1pa)
*                using 'E' 'NG' '477' l_fal-patnr space space space
*                                     space space space
*                changing l_wa_msg.
*        append l_wa_msg to pt_messages.
*        p_rc = 1.
*        p_refresh = 0.
*      when 2 or 3.
      WHEN OTHERS.
*       Fehler bei der Verarbeitung (Nr. &)
        PERFORM build_bapiret2(sapmn1pa)
                USING sy-msgty sy-msgid sy-msgno
                      sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                      space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
    ENDCASE.
  ELSE.
*   Fall- und Bewegungsdaten lesen zum Fall (nur 1 möglich)
    READ TABLE p_lt_movements INTO l_movement INDEX 1.
    PERFORM get_fall_bewegung USING     l_movement
                              CHANGING  l_fal
                                        l_bew
                                        l_errfal.
*   Fehler in Bezug auf den Fall/Bewegung
    CASE l_errfal.
      WHEN 1.
        PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '051' l_movement-falnr space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
      WHEN 2.
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '076' space space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
*     Fall/Bewegung ist OK.
      WHEN 0.
        CALL FUNCTION 'ISH_N2_DISPLAY_LAB_DATA'
          EXPORTING
            ss_einri          = l_fal-einri
            ss_patnr          = l_fal-patnr
            ss_falnr          = l_fal-falnr
            ss_oe             = l_bew-orgpf
          IMPORTING
            e_display_mode    = l_display_mode
          EXCEPTIONS
            err_nodata        = 1
            err_system_failed = 2
            OTHERS            = 3.

        CASE sy-subrc.
          WHEN 0.
            p_rc = 0.
            IF l_display_mode = '1'. " see OSS 513015 2009/note 1353714
              p_refresh = 2.
            ELSE.
              p_refresh = 0.
            ENDIF.
*         AE, 23.5.2002: Hinweis 522011 (CSS 247825)
*         Exception 1 wie die anderen behandeln (keine eigene Meldung,
*         sondern die vom FuB ausgeben!)
*          when 1.
**           Keine Labordaten vorhanden
*            perform build_bapiret2(sapmn1pa)
*                    using 'E' 'NG' '477' l_fal-patnr space space space
*                                         space space space
*                    changing l_wa_msg.
*            append l_wa_msg to pt_messages.
*            p_rc = 1.
*            p_refresh = 0.
*          when 2 or 3.
          WHEN OTHERS.
*           Fehler bei der Verarbeitung (Nr. &)
            PERFORM build_bapiret2(sapmn1pa)
                    USING sy-msgty sy-msgid sy-msgno
                          sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                          space space space
                    CHANGING l_wa_msg.
            APPEND l_wa_msg TO pt_messages.
            p_rc = 1.
            p_refresh = 0.
        ENDCASE.
    ENDCASE.
  ENDIF.

ENDFORM.                               " CALL_LABOR_KUM_BEF

*&---------------------------------------------------------------------*
*&      Form  CALL_TERMIN_LIST
*&---------------------------------------------------------------------*
*     Terminliste für einen Patienten vom Stationsarbeitsplatz aufrufen
*     (Hopfgartner: 2000-03-01)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_termin_list TABLES   pt_messages STRUCTURE
                                          bapiret2          "#EC NEEDED
                      USING    p_lt_movements TYPE
                                          ishmed_t_care_unit_list_head
                      CHANGING p_rc      LIKE sy-subrc
                               p_refresh LIKE n1fld-refresh.

  DATA: l_movement    TYPE rnwp_care_unit_list_head,
        lt_rn1po_call TYPE TABLE OF rn1po_call,
        l_rn1po_call  LIKE LINE OF lt_rn1po_call,
        l_plnoe       TYPE orgid.

* Initialisierung
  CLEAR: p_rc, p_refresh, l_movement.

* get planning ou
  PERFORM get_pln_ou CHANGING l_plnoe.

  REFRESH lt_rn1po_call.
  LOOP AT p_lt_movements INTO l_movement.
    CHECK NOT l_movement-patnr IS INITIAL OR
          NOT l_movement-papid IS INITIAL.
    READ TABLE lt_rn1po_call TRANSPORTING NO FIELDS
      WITH KEY patnr = l_movement-patnr
               papid = l_movement-papid.
    IF sy-subrc <> 0.
      l_rn1po_call-einri = l_movement-einri.
      l_rn1po_call-patnr = l_movement-patnr.
      l_rn1po_call-papid = l_movement-papid.
      INSERT l_rn1po_call INTO TABLE lt_rn1po_call.
    ENDIF.
  ENDLOOP.

  CALL FUNCTION 'ISHMED_DISPLAY_APPCAL'
    EXPORTING
      i_einri       = g_institution
      i_popup       = 'X'
      i_plnoe       = l_plnoe
    TABLES
      it_rn1po_call = lt_rn1po_call.

  p_rc = 0.
  p_refresh = 2.

ENDFORM.                               " CALL_TERMIN_LIST

*&---------------------------------------------------------------------*
*&      Form  CALL_DISPLAY_CODE
*&---------------------------------------------------------------------*
*     Anzeige Displacode bei Selektion Hotspot Icon_doku in WP
*     (Hopfgartner: 2000-03-01)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_display_code TABLES   pt_messages STRUCTURE bapiret2
                       USING    p_lt_movements TYPE
                                          ishmed_t_care_unit_list_head
                       CHANGING p_rc  LIKE sy-subrc
                                p_refresh LIKE n1fld-refresh.

* Datendefinitionen
  DATA: l_movement TYPE rnwp_care_unit_list_head,
        l_wa_msg   LIKE bapiret2.


  DATA: BEGIN OF lt_tn2flag OCCURS 1.  " Präsentationscode Dokument
          INCLUDE STRUCTURE tn2flag.
  DATA:   falnr LIKE ndoc-falnr.
  DATA: END OF lt_tn2flag.

  DATA: BEGIN OF lth_tn2flag OCCURS 1. " PCode Dokument ohne Fall
          INCLUDE STRUCTURE tn2flag.
  DATA: END OF lth_tn2flag.

  DATA: lt_ndoc LIKE ndoc OCCURS 1 WITH HEADER LINE.

  DATA: l_n2flag LIKE gt_n2flag.

* Initialisierung
  CLEAR: p_rc, p_refresh, l_movement, l_wa_msg.

  CLEAR: lt_ndoc.        REFRESH: lt_ndoc.
  CLEAR: lt_tn2flag.     REFRESH: lt_tn2flag.
  CLEAR: l_n2flag.       REFRESH: l_n2flag.
  CLEAR: lth_tn2flag.    REFRESH: lth_tn2flag.

  l_n2flag[] = gt_n2flag[].   "Daten aus der globalen Tabelle übernehmen

* Immer genau 1 Datensatz wird übergeben

* Fall- und Bewegungsdaten lesen zum Fall (nur 1 möglich)
  READ TABLE p_lt_movements INTO l_movement INDEX 1.
  CHECK sy-subrc = 0.

  CHECK NOT l_movement-falnr IS INITIAL.

  READ TABLE l_n2flag INTO lt_tn2flag WITH KEY falnr = l_movement-falnr
                                               einri = l_movement-einri
                                               mand = sy-mandt.
  IF sy-subrc = 0.
    APPEND lt_tn2flag.
  ELSE.
*  Selber nach Dokumenten und Prioritäten suchen wenn keine gefunden
    SELECT * FROM ndoc INTO TABLE lt_ndoc WHERE falnr = l_movement-falnr
                                          AND   storn = ' ' " ID 2968
                                          AND   loekz = ' '. " ID 2968
    DELETE lt_ndoc WHERE pcode IS INITIAL.

    IF NOT lt_ndoc[] IS INITIAL.
      CALL FUNCTION 'ISHMED_DOKU_GET_PRCODE'
        TABLES
          i_ndoc    = lt_ndoc
          i_tn2flag = lt_tn2flag
        EXCEPTIONS
          not_found = 1
          OTHERS    = 2.
      CASE sy-subrc.
        WHEN 1 OR 2.
*        Keine Dokumente vorhanden.
          PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '402' space space space space
                                     space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
          EXIT.
        WHEN 0.
*       Alles OK.
      ENDCASE.
    ENDIF.
  ENDIF.
  READ TABLE lt_tn2flag INTO lth_tn2flag INDEX 1.
  CHECK sy-subrc = 0.

* Check Priorität ist '000'
  IF lth_tn2flag-prio EQ '000'.
*    PERFORM build_bapiret2(sapmn1pa)
*            USING 'E' 'NF' '550' space space space space
*                                 space space space
*            CHANGING l_wa_msg.
*    APPEND l_wa_msg TO pt_messages.
*    p_rc = 1.
    p_refresh = 0.
    EXIT.
  ELSE.
    CALL FUNCTION 'ISHMED_POPUP_PCODE'
      TABLES
        i_tn2flag        = lth_tn2flag
      EXCEPTIONS
        flagid_not_found = 1
        OTHERS           = 2.
    CASE sy-subrc.
      WHEN 0.
*       Alles OK.
        p_rc = 0.
        p_refresh = 0.
        EXIT.
      WHEN 1.
        PERFORM build_bapiret2(sapmn1pa)
        USING 'E' 'NF' '298' lth_tn2flag-flagid space space space
                                   space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
      WHEN OTHERS.
*       Fehler bei der Verarbeitung (Nr. &)
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '139' sy-subrc space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
    ENDCASE.
  ENDIF.

ENDFORM.                               " CALL_DISPLAY_CODE

*&---------------------------------------------------------------------*
*&      Form  CALL_PATIENT_FILE
*&---------------------------------------------------------------------*
*       Vormerkungliste OE bezogen aus dem Stationsarbeitsplatz
*       (Hopfgartner: 2000-03-07)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_patient_file TABLES   pt_messages STRUCTURE bapiret2
                       USING    p_lt_movements TYPE
                                          ishmed_t_care_unit_list_head
                       CHANGING p_rc LIKE sy-subrc
                                p_refresh LIKE n1fld-refresh.
* Datendefinitionen
  DATA: l_bew         LIKE nbew,
        l_fal         LIKE nfal,
        l_npat        LIKE npat,
        l_movement    TYPE rnwp_care_unit_list_head,
        l_wa_msg      LIKE bapiret2,
        l_uname       LIKE sy-uname,
        l_telnr       LIKE addr3_val-tel_extens,
        l_telstrg(20) TYPE c,
        l_kacount     LIKE sy-tfill,     "Anzahl Krankenakten zum Fall
        l_errfal      LIKE sy-subrc,     "Fehlerprüfung Fall/Bewegung
        l_uname_tmp   TYPE sy-uname.   "Benutzerabhängiger Kontrollfluss

* Initialisierung
  CLEAR: p_rc, p_refresh, l_bew, l_fal, l_npat, l_movement, l_wa_msg,
         l_uname, l_telnr, l_telstrg(20), l_kacount, l_errfal.

* Fall- und Bewegungsdaten lesen zum Fall (nur 1 möglich)
  READ TABLE p_lt_movements INTO l_movement INDEX 1.
  PERFORM get_fall_bewegung USING     l_movement
                            CHANGING  l_fal
                                      l_bew
                                      l_errfal.

* Fehler in Bezug auf den Fall/Bewegung
  CASE l_errfal.
    WHEN 1.
      PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF' '051' l_movement-falnr space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 2.
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '076' space space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
*   Fall/Bewegung ist OK.
    WHEN 0.
*     Daten aus NPAT für den aktuellen Fall lesen.
      PERFORM get_patient_data TABLES   pt_messages
                               USING    l_fal
                               CHANGING l_npat
                                        p_rc.
      IF p_rc NE 0.                    "Falls Problem beim Patienten
        EXIT.
      ENDIF.
*     Fall sperren (aus alter Stationsarbeitsliste)
      CALL FUNCTION 'ISHMED_ENQUEUE_ENFAL'
        EXPORTING
          einri          = l_movement-einri
          falnr          = l_movement-falnr
          i_caller       = 'LN1WPF01,2'
          _scope         = '3'
        EXCEPTIONS
          foreign_lock   = 4
          system_failure = 12.
*     Sperrergebnis auswerten in rufendem Programm
      l_uname_tmp = sy-uname.   "Benutzerabhängiger Kontrollfluss
      CASE sy-subrc.
        WHEN 0.
*         Alles OK.
        WHEN 4.
          l_uname = sy-msgv1.
*          IF l_uname = sy-uname.                            "#EC *   "Benutzerabhängiger Kontrollfluss
          IF l_uname = l_uname_tmp.                                  "Benutzerabhängiger Kontrollfluss
*           Sie haben den Fall & & bereits gesperrt
            PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '657' l_movement-falnr space space space
                                         space space space
                    CHANGING l_wa_msg.
            APPEND l_wa_msg TO pt_messages.
            p_rc = 1.
            p_refresh = 0.
            EXIT.
          ELSE.
*           Fall & & bereits gesperrt durch &
            PERFORM read_user_telnr(sapmn1pa) USING l_uname
                                                    l_telnr l_telstrg.
            PERFORM build_bapiret2(sapmn1pa)
                    USING 'E' 'NF' '658' l_movement-falnr space l_uname
                                         l_telstrg space space space
                    CHANGING l_wa_msg.
            APPEND l_wa_msg TO pt_messages.
            p_rc = 1.
            p_refresh = 0.
            EXIT.
          ENDIF.
        WHEN OTHERS.
*         Fall & & konnte nicht gesperrt werden. SY-SUBRC = &
          PERFORM build_bapiret2(sapmn1pa)
                  USING 'E' 'N1' '227' l_movement-falnr space space
                                       sy-subrc space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
          EXIT.
      ENDCASE.

*     Aufruf der Krankenaktenverwaltung
      CALL FUNCTION 'ISHMED_KA_VERWALTUNG'
        EXPORTING
          ss_einri       = l_movement-einri
          ss_npat        = l_npat
          ss_nfal        = l_fal
          ss_orgfa       = l_bew-orgfa
*         SS_TITEL       = ' '
        IMPORTING
          ss_kacnt       = l_kacount
        EXCEPTIONS
          parm_invalid   = 1
          popup_canceled = 2
          system_error   = 3
          OTHERS         = 4.

      CASE sy-subrc.
        WHEN 0.
*         Alles OK.
*         Fall entsperren
          CALL FUNCTION 'ISHMED_DEQUEUE_ENFAL'
            EXPORTING
              einri    = l_movement-einri
              falnr    = l_movement-falnr
              i_caller = 'LN1WPF01,2'
              _scope   = '3'.
          IF l_kacount GE 1.
            p_refresh = 1.
          ELSE.
            p_refresh = 0.
          ENDIF.
          p_rc = 0.
          EXIT.
        WHEN 2.
*         Abbruch
          p_rc = 2.
          p_refresh = 0.
          CALL FUNCTION 'ISHMED_DEQUEUE_ENFAL'
            EXPORTING
              einri    = l_movement-einri
              falnr    = l_movement-falnr
              i_caller = 'LN1WPF01,3'
              _scope   = '3'.
          EXIT.
        WHEN 1 OR 3 OR 4.
*         Fehler in der Bearbeitung
          PERFORM build_bapiret2(sapmn1pa)
                  USING 'E' 'NF' '139' sy-subrc space space space
                                       space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
          CALL FUNCTION 'ISHMED_DEQUEUE_ENFAL'
            EXPORTING
              einri    = l_movement-einri
              falnr    = l_movement-falnr
              i_caller = 'LN1WPF01,4'
              _scope   = '3'.
          EXIT.
      ENDCASE.
  ENDCASE.

ENDFORM.                               " CALL_PATIENT_FILE

*&---------------------------------------------------------------------*
*&      Form  CALL_PERINATMONITOR
*&---------------------------------------------------------------------*
*       Perinatalmonitor aus dem WP aufrufen
*       (Hopfgartner 2000-03-08)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_perinatmonitor TABLES pt_messages STRUCTURE bapiret2
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Datendefinitionen
  DATA: l_movement    TYPE rnwp_care_unit_list_head,
        l_wa_msg      LIKE bapiret2,
        l_uname       LIKE sy-uname,
        l_telnr       LIKE addr3_val-tel_extens,
        l_telstrg(20) TYPE c,
        l_uname_tmp   TYPE sy-uname.       "Benutzerabhängiger Kontrollfluss

* Initialisierung
  CLEAR: p_rc, p_refresh, l_movement, l_wa_msg, l_uname,
         l_telnr, l_telstrg(20).

* Entweder 1 Patient oder kein Patient
  READ TABLE p_lt_movements INTO l_movement INDEX 1.

  CALL FUNCTION 'ISHMED_PERINATMONITOR'
    EXPORTING
      i_einri     = l_movement-einri
      i_falnr     = l_movement-falnr
    EXCEPTIONS
      read_error  = 1
      cancel      = 2
      fall_locked = 3
      OTHERS      = 4.
  CASE sy-subrc.
    WHEN 0.
*     Alles OK.
      p_rc = 0.
      p_refresh = 2.
    WHEN 1 OR 4.
*     Error
      p_rc = 1.
      p_refresh = 0.
    WHEN 2.
*     Cancel
      p_rc = 2.
      p_refresh = 0.
    WHEN 3.
*     Fall gesperrt
      l_uname = sy-msgv1.
      l_uname_tmp = sy-uname.                                  "Benutzerabhängiger Kontrollfluss
*     IF l_uname = sy-uname.                        "#EC *     "Benutzerabhängiger Kontrollfluss
      IF l_uname = l_uname_tmp.                                "Benutzerabhängiger Kontrollfluss
*       Sie haben den Fall & & bereits gesperrt
        PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF' '657' l_movement-falnr space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
      ELSE.
*       Fall & & bereits gesperrt durch &
        PERFORM read_user_telnr(sapmn1pa) USING l_uname
                                                l_telnr l_telstrg.
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '658' l_movement-falnr space l_uname
                                     l_telstrg space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
      ENDIF.
  ENDCASE.

ENDFORM.                               " CALL_PERINATMONITOR

*&---------------------------------------------------------------------*
*&      Form  CALL_WIEDERBESTELLUNG
*&---------------------------------------------------------------------*
*       Wiederbestellung (Termin Wiederholbesuch) aufrufen
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      -->P_PLANOE        Planende OE
*      -->P_ENVIRONMENT   Environment
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_wiederbestellung
          TABLES   pt_messages     STRUCTURE bapiret2
          USING    p_lt_movements  TYPE ishmed_t_care_unit_list_head
                   VALUE(p_planoe) TYPE norg-orgid
                   pr_environment  TYPE REF TO cl_ish_environment
          CHANGING p_rc            LIKE sy-subrc
                   p_refresh       LIKE n1fld-refresh.

* Datendefinitionen
  DATA: l_bew       LIKE nbew,
        lt_bew      LIKE nbew OCCURS 1 WITH HEADER LINE,
        l_fal       LIKE nfal,
        l_planoe    LIKE nbew-orgpf,
        l_rc        TYPE sy-subrc,
        l_cancel    TYPE ish_on_off,
        l_movement  TYPE rnwp_care_unit_list_head,
        l_wa_msg    LIKE bapiret2,
        l_date      LIKE nbew-bwidt,
        l_n1parwert TYPE n1orgpar-n1parwert,
        l_not_found TYPE ish_on_off,
        l_errfal    LIKE sy-subrc.     "Fehlerprüfung Fall/Bewegung

  DATA: lr_planning_grid TYPE REF TO cl_ishmed_planning_grid,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  DATA: lt_rn1wbdat TYPE ishmed_t_rn1wbdat,
        lt_workpool TYPE ishmed_t_pg_workpool,
        lt_messages TYPE ishmed_t_bapiret2,
        l_rn1wbdat  LIKE rn1wbdat,
        l_count     TYPE i.

* Initialize
  CLEAR: p_rc, p_refresh, l_bew, l_fal, l_planoe, l_movement,
         l_wa_msg, l_date, l_errfal.

  CLEAR:   lt_bew, lt_workpool[].
  REFRESH: lt_bew.

* instance errorhandler
  CREATE OBJECT lr_errorhandler.

* ---------- ---------- ---------- ---------- ---------- ----------
* JG 09.02.2004 ID 13144
* make decission which planning-orgunit to take
* OE-Vorbelegung für Wiederbestellung ermitteln
  l_planoe = p_planoe.
  PERFORM get_pln_ou CHANGING l_planoe.

  CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
    EXPORTING
      i_einri         = g_institution
      i_ou            = l_planoe
      i_par_name      = 'N1TMDISP'
      i_date          = sy-datum
    IMPORTING
      e_par_value     = l_n1parwert
      e_not_found     = l_not_found
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.
  IF l_rc <> 0.
    p_rc = 1.
    p_refresh = 0.
    CALL METHOD lr_errorhandler->get_messages
      IMPORTING
        t_messages = lt_messages.
    DESCRIBE TABLE lt_messages.
    IF sy-tfill > 0.
      APPEND LINES OF lt_messages TO pt_messages.
    ELSE.
*     Error
*     Fehler in der Bearbeitung
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' l_rc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
    ENDIF.
    EXIT.
  ENDIF.

  IF l_rc = 0.
    IF l_not_found = on.
*     set default value - planning grid
      l_n1parwert = '2'.
    ENDIF.
  ELSE.
    p_rc = l_rc.
  ENDIF.
* ---------- ---------- ----------

* l_n1parwert Plantafel = 2, Besuchsdispo = 1
  IF l_n1parwert EQ '2'.
*   possibilities: nothing marked, 1 marked or more objects marked
    PERFORM get_objs_for_wiedb TABLES   pt_messages
                               USING    p_lt_movements
                                        pr_environment
                               CHANGING p_rc
                                        p_refresh
                                        lt_workpool.

    CALL METHOD cl_ishmed_planning_grid=>create
      EXPORTING
        i_einri        = g_institution
      IMPORTING
        e_instance     = lr_planning_grid
        e_rc           = l_rc
      CHANGING
        c_errorhandler = lr_errorhandler.
    IF l_rc EQ 0.
      CALL METHOD lr_planning_grid->call_planning_grid
        EXPORTING
          i_planoe        = l_planoe
          i_usage         = co_usage_follow_up_visit
          it_workpool     = lt_workpool
        IMPORTING
          e_cancel        = l_cancel
          e_rc            = p_rc
        CHANGING
          cr_errorhandler = lr_errorhandler.
    ENDIF.
    IF l_rc <> 0.
      p_rc = 1.
      p_refresh = 0.
      CALL METHOD lr_errorhandler->get_messages
        IMPORTING
          t_messages = lt_messages.
      DESCRIBE TABLE lt_messages.
      IF sy-tfill > 0.
        APPEND LINES OF lt_messages TO pt_messages.
      ELSE.
*       Error Fehler in der Bearbeitung
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '139' l_rc space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
      ENDIF.
      EXIT.
    ENDIF.
    IF l_cancel EQ on.
      p_refresh = 0.
    ELSE.
      p_refresh = 1.
    ENDIF.
    EXIT.
* END JG 09.02.2004 ID 13144
* ---------- ---------- ---------- ---------- ---------- ----------
  ELSE.
*   Fall- und Bewegungsdaten lesen zum Fall
*   (mindestens 1 Patient möglich)
    LOOP AT p_lt_movements INTO l_movement.
      PERFORM get_fall_bewegung USING     l_movement
                                CHANGING  l_fal
                                          l_bew
                                          l_errfal.
      CASE l_errfal.
        WHEN 1.
          PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '051' l_movement-falnr space space space
                                       space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
          EXIT.
        WHEN 2.
          PERFORM build_bapiret2(sapmn1pa)
                  USING 'E' 'NF' '076' space space space space
                                       space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
          EXIT.
        WHEN 0.
*         Fall/Bewegung ist OK.
          APPEND l_bew TO lt_bew.
          l_count = l_count + 1.
          l_rn1wbdat-einri = l_bew-einri.
          l_rn1wbdat-orgid = l_bew-orgpf.
          l_rn1wbdat-falnr = l_bew-falnr.
          l_rn1wbdat-patnr = l_fal-patnr.
          l_rn1wbdat-sort  = l_count.
          INSERT l_rn1wbdat INTO TABLE lt_rn1wbdat.
      ENDCASE.
    ENDLOOP.

*   ACHTUNG: entfernen wenn lt_bew verwendet wird
    READ TABLE lt_bew INTO l_bew INDEX 1.
*   Neue Bewegung jetzt anlegen
    l_date = sy-datum + 1.               " Frühestens morgen!

    CALL FUNCTION 'ISHMED_CALL_WIEDERBEST'
      EXPORTING
        i_datum      = l_date
        i_zeit       = '000000'
*   ACHTUNG: nur 1 Fall übergeben, ist mit dem FUB zu ändern!!
        i_nbew       = l_bew
        i_title      = 'Wiederbestellung'(010)
        i_all_marked = lt_rn1wbdat
*       I_SHOW_LIST  = ' '
*       I_NTMN       =
      EXCEPTIONS
        read_error   = 1
        cancelled    = 2
        OTHERS       = 3.

    CASE sy-subrc.
      WHEN 0.
*       Alles ok
        p_rc = 0.
        p_refresh = 1.
      WHEN '1'.
*       Fehler beim Anlegen der Wiederbestellung
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '199' space space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
      WHEN '2'.
*       Aktion wurde vom Benutzer abgebrochen
        p_rc = 2.
        p_refresh = 0.
      WHEN OTHERS.
        EXIT.
    ENDCASE.
  ENDIF.

ENDFORM.                               " CALL_WIEDERBESTELLUNG

*&---------------------------------------------------------------------*
*&      Form  CALL_INTENSIVMONITOR
*&---------------------------------------------------------------------*
*       Intensivmonitor aus dem WP aufrufen
*       (Hopfgartner 2000-03-08)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_intensivmonitor TABLES pt_messages STRUCTURE bapiret2
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Datendefinitionen
  DATA: l_fal      LIKE nfal OCCURS 10 WITH HEADER LINE,
        l_movement TYPE rnwp_care_unit_list_head,
        l_wa_msg   LIKE bapiret2.

  DATA: l_occupancy_list TYPE ish_t_occupancy_list,
        l_arrival_list   TYPE ish_t_arrival_list,
        l_departure_list TYPE ish_t_departure_list.

* Initialisierung
  CLEAR: p_rc, p_refresh, l_fal, l_movement,
         l_wa_msg, l_occupancy_list, l_arrival_list,
         l_departure_list.

  REFRESH: l_fal, l_occupancy_list, l_arrival_list,
           l_departure_list.

* Entweder 1 Patient oder kein Patient
  READ TABLE p_lt_movements INTO l_movement INDEX 1.
  IF l_movement-falnr IS INITIAL AND
     l_movement-patnr IS INITIAL.
*   Kein Patient/Fall wurde übergeben
*   Aktuelle Belegung/Zugänge/Abgänge holen
    CALL FUNCTION 'ISH_KEY_TIME_MOVEMENTS_GET'
      EXPORTING
        i_institution     = g_institution
        i_key_date        = g_key_date
        i_key_time        = g_key_time
        i_planning_period = g_planning_period
        i_history_period  = g_history_period
*       I_INCLUDING_FREE_BEDS = ' '
      TABLES
        e_occupancy_list  = l_occupancy_list
        e_arrival_list    = l_arrival_list
        e_departure_list  = l_departure_list
        i_rtab_dept_ou    = gr_dept_ou
        i_rtab_treat_ou   = gr_treat_ou.
*            I_RTAB_TREAT_ROOM     =
*            I_REFRESH_CASE        =
*       EXCEPTIONS
*            NO_MOVEMENTS_EXIST    = 1
*            OTHERS                = 2.
    CASE l_movement-listkz.
      WHEN 'O'.                        "Belegungsliste
        SELECT * FROM nfal INTO TABLE l_fal
                FOR ALL ENTRIES IN l_occupancy_list
                WHERE einri = g_institution AND
                      falnr = l_occupancy_list-falnr.
      WHEN 'A'.                        "Zugangsliste
        SELECT * FROM nfal INTO TABLE l_fal
                FOR ALL ENTRIES IN l_arrival_list
                WHERE einri = g_institution AND
                      falnr = l_arrival_list-falnr.

      WHEN 'D'.                        "Abgangsliste
        SELECT * FROM nfal INTO TABLE l_fal
                FOR ALL ENTRIES IN l_departure_list
                WHERE einri = g_institution AND
                      falnr = l_departure_list-falnr.
    ENDCASE.

    CALL FUNCTION 'ISHMED_MEHRFACHLISTE_INTDOKU'
      EXPORTING
        einri     = l_movement-einri
        orgid     = l_movement-orgpf
*       datum     = l_date
      TABLES
        falnr     = l_fal
*       outtab    = output
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.
    CASE sy-subrc.
      WHEN 0.
*       Alles OK
        p_rc = 0.
        p_refresh = 2.
        EXIT.
      WHEN 1 OR 2.
*       Fehler in der Bearbeitung
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '139' sy-subrc space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
    ENDCASE.
  ELSE.
*   Fall wurde übergeben
    CALL FUNCTION 'ISHMED_BAUMSTRUKT_INTENSIVDOKU'
      EXPORTING
        einri     = l_movement-einri
        falnr     = l_movement-falnr
*       seldt     = sel_datum
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.
    CASE sy-subrc.
      WHEN 0.
*       Alles OK
        p_rc = 0.
        p_refresh = 1.
        EXIT.
      WHEN 1 OR 2.
*       Fehler in der Bearbeitung
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '139' sy-subrc space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
    ENDCASE.
  ENDIF.

ENDFORM.                               " CALL_INTENSIVMONITOR

*&---------------------------------------------------------------------*
*&      Form  CALL_OPPROGRAMM
*&---------------------------------------------------------------------*
*       OP-Programm aus dem Stationsarbeitsplatz aufrufen
*       (Hopfgartner: 2000-03-10)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      -->P_POPUP         Aufruf mit Datumsselektion oder ohne (on/off)
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
*FORM call_opprogramm TABLES   pt_messages STRUCTURE bapiret2
*                      USING   p_lt_movements TYPE
*                                      ishmed_t_care_unit_list_head
*                               p_popup TYPE c
*                      CHANGING p_rc LIKE sy-subrc
*                               p_refresh LIKE n1fld-refresh.
*
** Datendefinitionen
*  DATA: l_bew       LIKE nbew,
*        l_fal       LIKE nfal OCCURS 1 WITH HEADER LINE,
*        l_einri     LIKE nfal-einri,
*        l_oepf      LIKE nbew-orgpf,
*        l_movement  TYPE rnwp_care_unit_list_head,
*        l_wa_msg    LIKE bapiret2,
*        l_date      LIKE nlei-pbgdt,   "Selektionsdatum
*        l_errfal    LIKE sy-subrc.     "Fehlerprüfung Fall/Bewegung
*
*  RANGES: lr_anpoe FOR norg-orgid,
*          lr_erboe FOR norg-orgid,
*          lr_bauid FOR nbau-bauid,
*          lr_gpart FOR ngpa-gpart.
*
*  DATA: lt_erboe TYPE STANDARD TABLE OF rn1oerng,
*        lt_anpoe TYPE STANDARD TABLE OF rn1oerng,
*        lt_bauid TYPE STANDARD TABLE OF rn1baurng,
*        lt_gpart TYPE STANDARD TABLE OF rn1gparng.
*
*  DATA: l_occupancy_list TYPE ish_t_occupancy_list,
*        l_arrival_list   TYPE ish_t_arrival_list,
*        l_departure_list TYPE ish_t_departure_list.
*
** Initialisierung
*  CLEAR: p_rc, p_refresh, l_bew, l_einri, l_oepf, l_movement,
*         l_date, l_errfal.
*
*  CLEAR:   lr_erboe, lr_anpoe, lr_bauid, lr_gpart, l_fal,
*           l_occupancy_list, l_arrival_list, l_departure_list.
*  REFRESH: lr_erboe, lr_anpoe, lr_bauid, lr_gpart, l_fal,
*           l_occupancy_list, l_arrival_list, l_departure_list.
*
*  REFRESH: lt_erboe, lt_anpoe, lt_bauid, lt_gpart. "AN281102 SLIN
*
** Check ob mind. 1 Patient oder kein Patient übergeben wurde
*  READ TABLE p_lt_movements INTO l_movement INDEX 1.
*  l_einri = l_movement-einri.
*  l_oepf = l_movement-orgpf.
*
*  lr_anpoe-sign   = 'I'.
*  lr_anpoe-option = 'EQ'.
*  lr_anpoe-low    = l_oepf.
*  APPEND lr_anpoe.
*
*  IF l_movement-falnr IS INITIAL AND
*     l_movement-patnr IS INITIAL.
**   Kein Patient markiert alle Fälle
**   Aktuelle Belegung/Zugänge/Abgänge holen
*    CALL FUNCTION 'ISH_KEY_TIME_MOVEMENTS_GET'
*         EXPORTING
*              i_institution         = g_institution
*              i_key_date            = g_key_date
*              i_key_time            = g_key_time
*              i_planning_period     = g_planning_period
*              i_history_period      = g_history_period
*        TABLES
*             e_occupancy_list      = l_occupancy_list
*             e_arrival_list        = l_arrival_list
*             e_departure_list      = l_departure_list
*             i_rtab_dept_ou        = gr_dept_ou
*             i_rtab_treat_ou       = gr_treat_ou.
*    CASE l_movement-listkz.
*      WHEN 'O'.                        "Belegungsliste
*        SELECT * FROM nfal INTO TABLE l_fal
*                FOR ALL ENTRIES IN l_occupancy_list
*                WHERE einri = g_institution AND
*                      falnr = l_occupancy_list-falnr.
*      WHEN 'A'.                        "Zugangsliste
*        SELECT * FROM nfal INTO TABLE l_fal
*                FOR ALL ENTRIES IN l_arrival_list
*                WHERE einri = g_institution AND
*                      falnr = l_arrival_list-falnr.
*
*      WHEN 'D'.                        "Abgangsliste
*        SELECT * FROM nfal INTO TABLE l_fal
*                FOR ALL ENTRIES IN l_departure_list
*                WHERE einri = g_institution AND
*                      falnr = l_departure_list-falnr.
*    ENDCASE.
*
*
*  ELSE.
**   Mindestens 1 Patient/Fall
**   Alle markierten Fälle zusammenfassen für FuB
*    LOOP AT p_lt_movements INTO l_movement.
**     Fall- und Bewegungsdaten lesen zum Fall
*      PERFORM get_fall_bewegung USING     l_movement
*                                CHANGING  l_fal
*                                          l_bew
*                                          l_errfal.
*      CASE l_errfal.
*        WHEN 1.
*          PERFORM build_bapiret2(sapmn1pa)
*          USING 'E' 'NF' '051' l_movement-falnr space space space
*                                       space space space
*                  CHANGING l_wa_msg.
*          APPEND l_wa_msg TO pt_messages.
*          p_rc = 1.
*          p_refresh = 0.
*          EXIT.
*        WHEN 2.
*          PERFORM build_bapiret2(sapmn1pa)
*                  USING 'E' 'NF' '076' space space space space
*                                       space space space
*                  CHANGING l_wa_msg.
*          APPEND l_wa_msg TO pt_messages.
*          p_rc = 1.
*          p_refresh = 0.
*          EXIT.
*        WHEN 0.
**         Alles OK
*      ENDCASE.
**     Fall an die Falltabelle anhängen
*      APPEND l_fal.
*      CLEAR: l_fal.
*    ENDLOOP.
*  ENDIF.
*
*  IF p_popup = off.
**   OP-Programm mit aktuellem Selektionsdatum der Stationsliste
*    l_date = g_key_date.
*  ELSE.
**   Mit  Popup --> OP Datum in Popup eingeben
*    CALL FUNCTION 'ISHMED_POPUP_ENTDT'
*         EXPORTING
*            titel        = 'OP-Datum'(003)
*            fieldtext    = 'Operationen für:'(002)
*         IMPORTING
*            e_entdt      = l_date
*         EXCEPTIONS
*            cancel       = 1
*            OTHERS       = 2.
*    CASE sy-subrc.
*      WHEN 0.
**       Alles OK.
*      WHEN 1.
**       Cancel
*        p_rc = 2.
*        p_refresh = 0.
*        EXIT.
*      WHEN 2.
**       Fehler in der Bearbeitung
*        PERFORM build_bapiret2(sapmn1pa)
*                USING 'E' 'NF' '139' sy-subrc space space space
*                                     space space space
*                CHANGING l_wa_msg.
*        APPEND l_wa_msg TO pt_messages.
*        p_rc = 1.
*        p_refresh = 0.
*        EXIT.
*    ENDCASE.
*  ENDIF.
*
*  lt_erboe = lr_erboe[].
*  lt_anpoe = lr_anpoe[].
*  lt_bauid = lr_bauid[].
*  lt_gpart = lr_gpart[].
*
*  CALL FUNCTION 'ISHMED_OP_PROGRAMM'
*       EXPORTING
*            i_einri         = l_einri
*            i_opdatum       = l_date
*            i_tcode_calling = sy-tcode
*            i_sicht         = 'A'
*            i_select        = 'F'
*            i_selztmk       = off
*            i_grp_seite     = on
*       TABLES
*            ri_erboe_sicht  = lt_erboe
*            ri_anpoe_sicht  = lt_anpoe
*            ri_bauid_sicht  = lt_bauid
*            ri_gpart_sicht  = lt_gpart
*            i_falltab       = l_fal
*       EXCEPTIONS
*            no_auth         = 1
*            OTHERS          = 2.
*
*  CASE sy-subrc.
*    WHEN 0.
**     Alles OK
*      p_rc = 0.
*      p_refresh = 2.
*    WHEN 1.
**     Keine Berechtigung für diese Transaktion
*      PERFORM build_bapiret2(sapmn1pa)
*              USING 'E' 'NF1' '000'
*                    'Keine Berechtigung für diese Transaktion'(006)
*                    space space space space space space
*              CHANGING l_wa_msg.
*      APPEND l_wa_msg TO pt_messages.
*      p_rc = 1.
*      p_refresh = 0.
*      EXIT.
*    WHEN 2.
**     Fehler in der Bearbeitung
*      PERFORM build_bapiret2(sapmn1pa)
*              USING 'E' 'NF' '139' sy-subrc space space space
*                                   space space space
*              CHANGING l_wa_msg.
*      APPEND l_wa_msg TO pt_messages.
*      p_rc = 1.
*      p_refresh = 0.
*      EXIT.
*  ENDCASE.
*
*ENDFORM.                               " CALL_OPPROGRAMM

*&---------------------------------------------------------------------*
*&      Form  CALL_PATIENT_OPEN_ISSUES
*&---------------------------------------------------------------------*
*       Offene Punkte Liste aus dem Stationsarbeitsplatz aufrufen
*       (Hopfgartner: 2000-03-14)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      -->PR_ENVIRONMENT  Environment
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_patient_open_issues
                      TABLES   pt_messages STRUCTURE bapiret2
                      USING    p_lt_movements TYPE
                                          ishmed_t_care_unit_list_head
                               pr_environment TYPE REF TO
                                          cl_ish_environment
                      CHANGING p_rc LIKE sy-subrc
                               p_refresh LIKE n1fld-refresh.
* Datendefinitionen
  DATA: l_fal      LIKE nfal,
        l_einri    LIKE nfal-einri,
        l_oepf     LIKE nbew-orgpf,
        l_movement TYPE rnwp_care_unit_list_head,
        l_wa_msg   LIKE bapiret2.
  DATA: lt_n1orgpar   LIKE n1orgpar OCCURS 10 WITH HEADER LINE.
  DATA: l_n1ofpdat TYPE i,    " Tage +/- Sy-Datum = Entlassungsdatum
        l_n1ofppop LIKE on,   " Popup "Entlassungsdatum" bringen ?
        l_edatum   LIKE nbew-bwidt. " Vorbelegung Entlassungsdatum

* Initialisierung
  CLEAR: p_rc, p_refresh, l_fal, l_einri, l_oepf, l_movement,
         l_wa_msg, l_n1ofpdat, l_n1ofppop, l_edatum.

  CLEAR: lt_n1orgpar. REFRESH: lt_n1orgpar.

* Lesen der übergebenen Fall/Patientendaten
* (immer nur 1 Patient möglich)
  READ TABLE p_lt_movements INTO l_movement INDEX 1.
  l_einri = l_movement-einri.
  l_oepf = l_movement-orgpf.
  l_fal-falnr = l_movement-falnr.
  l_fal-patnr = l_movement-patnr.

* Einlesen Customizing Parameter N1OFPDAT + N1OFPPOP
  PERFORM read_n1orgpar(sapl0n1s) TABLES lt_n1orgpar
                                  USING l_einri
                                        l_oepf
                                        'N1OFPDAT'
                                        sy-datum.

  READ TABLE lt_n1orgpar INDEX 1.
  IF sy-subrc EQ 0.
    l_n1ofpdat = lt_n1orgpar-n1parwert.
    l_edatum = sy-datum + l_n1ofpdat.
  ELSE.
    l_edatum = sy-datum.
  ENDIF.

  CLEAR: lt_n1orgpar. REFRESH: lt_n1orgpar.
  PERFORM read_n1orgpar(sapl0n1s) TABLES lt_n1orgpar
                                  USING  l_einri
                                         l_oepf
                                         'N1OFPPOP'
                                         sy-datum.
  READ TABLE lt_n1orgpar INDEX 1.
  IF sy-subrc EQ 0.
    l_n1ofppop = lt_n1orgpar-n1parwert.
  ELSE.
    l_n1ofppop = on.
  ENDIF.

  SET PARAMETER ID 'ORG' FIELD l_oepf.                      " ID 4067

* Aufruf des FuB
  CALL FUNCTION 'ISHMED_PATIENT_OFFENE_PUNKTE'
    EXPORTING
      i_einri         = l_einri
      i_patnr         = l_fal-patnr
      i_falnr         = l_fal-falnr
      i_popup         = l_n1ofppop
      i_entdt         = l_edatum
      ir_environment  = pr_environment
    EXCEPTIONS
      cancel          = 1
      patnr_not_valid = 2
      falnr_not_valid = 3
      fall_pat_error  = 4
      OTHERS          = 5.
  CASE sy-subrc.
    WHEN 0.
*     Alles OK.
      p_rc = 0.
      p_refresh = 1.
      EXIT.
    WHEN 1.
*     Abbruch
      p_rc = 2.
      p_refresh = 0.
      EXIT.
    WHEN 2.
*     Patientennummer nicht korrekt
      PERFORM build_bapiret2(sapmn1pa)
               USING 'E' 'NF' '387' l_fal-patnr space space space
                                    space space space
               CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 3.
*     Fall nicht korrekt
      PERFORM build_bapiret2(sapmn1pa)
      USING 'E' 'NF' '051' l_fal-falnr space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 4 OR 5.
*     Fehler in der Bearbeitung
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' sy-subrc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
  ENDCASE.

ENDFORM.                               " CALL_PATIENT_OPEN_ISSUES

*&---------------------------------------------------------------------*
*&      Form  CALL_PATIENT_VISIT
*&---------------------------------------------------------------------*
*       Besuche/Folgebesuche anzeigen, ändern oder anlegen
*       (Hopfgartner 2000-03-14)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      -->P_FCODE         Funktionscode
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_patient_visit TABLES pt_messages STRUCTURE bapiret2
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                             p_fcode        LIKE rseu1-func
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Datendefinitionen
  DATA: l_bew       LIKE nbew,
        l_fal       LIKE nfal,
        l_tcode     LIKE rn1k3-n1c004, "Transaktionscode für FuB
        l_show_list LIKE on,           "Parameter des FuB
        l_movement  TYPE rnwp_care_unit_list_head,
        l_fcode     TYPE ish_fcode_dtm,                     " ID 9617
        l_wa_msg    LIKE bapiret2,
        l_errfal    LIKE sy-subrc.     "Fehlerprüfung Fall/Bewegung

* Initialisierung
  CLEAR: p_rc, p_refresh, l_bew, l_fal, l_tcode, l_show_list,
         l_movement, l_wa_msg, l_errfal.

  l_show_list = on.

* Je nach aufrufendem Funktionscode Werte vorbelegen
  CASE p_fcode.
    WHEN 'BDIS'.
      l_tcode = 'NP43'.
    WHEN 'BINS'.
      l_tcode = 'NP41'.
    WHEN 'BUPD'.
      l_tcode = 'NP42'.
  ENDCASE.

* Lesen übergebene Fall/Patientendaten
  READ TABLE p_lt_movements INTO l_movement INDEX 1.

* Fall- und Bewegungsdaten lesen zum Fall
  PERFORM get_fall_bewegung USING     l_movement
                            CHANGING  l_fal
                                      l_bew
                                      l_errfal.
  CASE l_errfal.
    WHEN 1.
      PERFORM build_bapiret2(sapmn1pa)
      USING 'E' 'NF' '051' l_movement-falnr space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 2.
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '076' space space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 0.
*     Alles OK
  ENDCASE.

  CASE l_movement-listkz.                                   " ID 9617
    WHEN 'O'.
      l_fcode = 'NWP001'.
    WHEN 'A'.
      l_fcode = 'NWP002'.
    WHEN 'D'.
      l_fcode = 'NWP003'.
  ENDCASE.

  CALL FUNCTION 'ISHMED_BESUCH'
    EXPORTING
      ss_nbew            = l_bew
      ss_nfal            = l_fal
      ss_tcode           = l_tcode
      ss_lock            = true  " false 29.10.1996 Pigall Andreas
      ss_list            = l_show_list
      ss_fcode           = l_fcode                          " ID 9617
    EXCEPTIONS
      ss_enq_error       = 01
      ss_nfal_not_found  = 02
      ss_tcode_not_valid = 03.

  CASE sy-subrc.
    WHEN 0.
*     Alles OK.
      p_rc = 0.
      p_refresh = 1.
      EXIT.
    WHEN 1.
*     Fehler beim sperren des Fall &
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '081' l_fal-falnr space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 2 OR 3.
*     Fehler in der Bearbeitung
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' sy-subrc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
  ENDCASE.

ENDFORM.                               " CALL_PATIENT_VISIT

*&---------------------------------------------------------------------*
*&      Form  CALL_NURSE_WORKLIST
*&---------------------------------------------------------------------*
*       Nurse Worklist - executed from the clinical workplace
*       (Hopfgartner 2000-03-15)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_nurse_worklist TABLES pt_messages STRUCTURE
                                            bapiret2        "#EC NEEDED
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Declarations
  DATA: l_movement        TYPE rnwp_care_unit_list_head.
  DATA: l_care_active     LIKE on.           " Pflege aktiv

  RANGES: lr_selpat       FOR npat-patnr.    " Range patient_id

* ED, ID 20128: local data declarations -> BEGIN
  DATA: lt_fal_out   LIKE nfal OCCURS 1,
        lt_movements TYPE ishmed_t_care_unit_list_head,
        l_exit       TYPE ish_on_off,
        l_fal        LIKE nfal,         "Case details
        lt_fal       LIKE nfal OCCURS 1, "Case table used for function
        l_errfal     LIKE sy-subrc.     "Check errors patient/case

  REFRESH: lt_fal_out, lt_fal.
* ED, ID 20128 -> END

* Initialisation
  CLEAR: p_rc, p_refresh, l_movement, lr_selpat.
  REFRESH: lr_selpat.

* ED, ID 20128 -> BEGIN
  lt_movements[] = p_lt_movements[].
  LOOP AT lt_movements INTO l_movement.
    CLEAR l_fal.
*   Get detail data for case
    PERFORM get_case USING    l_movement
                     CHANGING l_fal
                              l_errfal.
    IF l_errfal = 0.
      IF l_fal-falar = '2'. "outpatient
        APPEND l_fal TO lt_fal_out.
        DELETE lt_movements WHERE falnr = l_movement-falnr.
      ELSEIF l_fal-falar = '1'.
        APPEND l_fal TO lt_fal.
      ENDIF.
    ENDIF.
  ENDLOOP.
  l_exit = off.
  PERFORM set_case_in_table_popup USING lt_fal lt_fal_out l_exit.
  IF l_exit = on.
    p_refresh = 0. "no refresh
    EXIT.
  ENDIF.
* ED, ID 20128 -> END

* Prepare report call
  READ TABLE lt_movements INTO l_movement INDEX 1.

  IF l_movement-patnr IS INITIAL AND
     l_movement-falnr IS INITIAL.
    CALL FUNCTION 'ISHMED_CARE_ACTIVE'
      EXPORTING
        i_einri       = l_movement-einri
        i_message     = on
      IMPORTING
        e_care_active = l_care_active.

    CHECK l_care_active = on.
*   Call report without patient_id´s
    SUBMIT rn1pflka VIA SELECTION-SCREEN
      WITH einri     EQ l_movement-einri " institution
      WITH oe_von    EQ l_movement-orgpf " organizational element
*     WITH patnr     IN lr_selpat        " selection range patient_id
      WITH begdt     EQ g_key_date       " selection date global
    AND RETURN.
  ELSE.
*   Build patient_id range -
*   only when at least one patien/case was selected
    lr_selpat-option = 'EQ'.
    lr_selpat-sign   = 'I'.

    LOOP AT lt_movements INTO l_movement.
      lr_selpat-low = l_movement-patnr.
      APPEND lr_selpat.
    ENDLOOP.

*   Call report with patient_id´s
    READ TABLE lt_movements INTO l_movement INDEX 1.
    CALL FUNCTION 'ISHMED_CARE_ACTIVE'
      EXPORTING
        i_einri       = l_movement-einri
        i_message     = on
      IMPORTING
        e_care_active = l_care_active.

    CHECK l_care_active = on.
    SUBMIT rn1pflka VIA SELECTION-SCREEN
      WITH einri     EQ l_movement-einri " institution
      WITH oe_von    EQ l_movement-orgpf " organizational element
      WITH patnr     IN lr_selpat      " selection range patient_id
      WITH begdt     EQ g_key_date     " selection date global
    AND RETURN.
  ENDIF.

* Set return parameter (OK and refresh all)
  p_rc = 0.
  p_refresh = 2.

ENDFORM.                               " CALL_NURSE_WORKLIST

*&---------------------------------------------------------------------*
*&      Form  CALL_CLINICAL_SERVICES
*&---------------------------------------------------------------------*
*       Clinical Services - executed from the clinical workplace
*       Choice is made on function code from the caller
*       (Hopfgartner 2000-03-15)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*      -->P_FCODE         Function code to be executed
*      -->P_WPLACEID      Workplace ID
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_clinical_services TABLES pt_messages STRUCTURE bapiret2
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                             p_fcode        LIKE rseu1-func
                             p_wplaceid     TYPE nwplace-wplaceid
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Declarations
  DATA: l_bew      LIKE nbew,         "Movement details
        l_fal      LIKE nfal,         "Case details
        l_movement TYPE rnwp_care_unit_list_head, "Work area movement
        l_wa_msg   LIKE bapiret2,     "Work area error messages
        l_tcode    LIKE sy-tcode,     "Transaction code
        l_used_for LIKE rnt61-mark VALUE 'A', "Usage code
        l_errfal   LIKE sy-subrc.     "Check errors patient/case

* ED, ID 20128: local data declarations -> BEGIN
  DATA: lt_fal_out   LIKE nfal OCCURS 1,
        lt_movements TYPE ishmed_t_care_unit_list_head,
        l_exit       TYPE ish_on_off,
        lt_fal       LIKE nfal OCCURS 1. "Case table used for function

  DATA: l_n1pmn      TYPE n1orgpar-n1parwert.

  REFRESH: lt_fal_out, lt_fal.
* ED, ID 20128 -> END

* Initialisation
  CLEAR: p_rc, p_refresh, l_bew, l_fal, l_movement, l_wa_msg, l_tcode,
         l_errfal.

* Depending on p_fcode set different values for function call
  CASE p_fcode.
    WHEN 'LNFU'.
      l_tcode = 'PFL'.                 " Change mode
      l_used_for = 'A'.                " Enter services
    WHEN 'LNFD'.
      l_tcode = 'DIS'.                 " Display
      l_used_for = 'A'.                " Enter Services
*    when 'PINS'.
*      used_for = 'B'.                  " Pflegeplanung (!)
*      tcode = 'PHL'.                   " Pflegemodus + Hitliste
    WHEN 'PUPD'.
      l_used_for = 'B'.                " Nursingplan
*      l_tcode = 'PHL'.                 " Enter services with hitlist    " MED-53473 M.Rebegea 30.01.2014
      l_tcode = 'PHN'.                   "Enter services with hitlist    " MED-53473 M.Rebegea 30.01.2014
    WHEN 'PDIS'.
      l_tcode = 'DIS'.                 " Display Mode
      l_used_for = 'B'.                " Nursingplan
    WHEN 'NERF'.
      l_used_for =  'B'.               "Nursingplan
      l_tcode    =  'PHN'.             "Enter services with hitlist
    WHEN OTHERS.
      l_tcode = 'DIS'.                 " Display Mode
      l_used_for = 'A'.                " Enter services
  ENDCASE.

* ED, ID 20128 -> BEGIN
  lt_movements[] = p_lt_movements[].
  IF l_used_for = 'B'. "used for nurse planning
    IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
      READ TABLE lt_movements INTO l_movement INDEX 1.
      CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
        EXPORTING
          i_einri     = l_movement-einri
          i_ou        = l_movement-orgpf
          i_par_name  = 'N1PMN'
        IMPORTING
          e_par_value = l_n1pmn.
      IF l_n1pmn IS NOT INITIAL.
        PERFORM call_add_nrs_service
          TABLES   pt_messages
          USING    lt_movements l_n1pmn l_tcode
          CHANGING p_rc p_refresh.
        EXIT.
      ENDIF.
    ENDIF.
    LOOP AT lt_movements INTO l_movement.
      CLEAR l_fal.
*     Get detail data for case
      PERFORM get_case USING    l_movement
                       CHANGING l_fal
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
    ENDLOOP.
    l_exit = off.
    CLEAR: l_fal, l_errfal.
    PERFORM set_case_in_table_popup USING lt_fal lt_fal_out l_exit.
    IF l_exit = on.
      p_refresh = 0. "no refresh
      EXIT.
    ENDIF.
  ENDIF.
* ED, ID 20128 -> END

* Only 1 Case/Patient is possible
  READ TABLE lt_movements INTO l_movement INDEX 1.

* ID 13624: no entry marked is possible too
  IF l_movement-falnr IS INITIAL.
    CLEAR l_bew.
    l_bew-mandt = sy-mandt.
    l_bew-einri = l_movement-einri.
    SELECT SINGLE erboe FROM nwplace_001 INTO l_bew-orgpf
           WHERE  wplacetype  = '001'
           AND    wplaceid    = p_wplaceid.
  ELSE.
*   Get detail data for case and movement
    PERFORM get_fall_bewegung USING     l_movement
                              CHANGING  l_fal
                                        l_bew
                                        l_errfal.
    CASE l_errfal.
      WHEN 1.
        PERFORM build_bapiret2(sapmn1pa)
        USING 'E' 'NF' '051' l_movement-falnr space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
      WHEN 2.
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '076' space space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
      WHEN 0.
*       OK
    ENDCASE.
  ENDIF.

* Function call
  CALL FUNCTION 'ISHMED_LEISTUNGSNACHERFASSUNG'
    EXPORTING
      ss_nbew            = l_bew
      ss_used_for        = l_used_for
      ss_vcode           = l_tcode
    EXCEPTIONS
      ss_nbew_not_found  = 01
      ss_vcode_not_valid = 02.

  CASE sy-subrc.
    WHEN 0.
*     Everything OK.
      p_rc = 0.
      p_refresh = 2.
      EXIT.
    WHEN 1.
*     Error: movement not found
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '076' space space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 2.
*     Error during execution
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' sy-subrc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
  ENDCASE.

ENDFORM.                               " CALL_CLINICAL_SERVICES

*&---------------------------------------------------------------------*
*&      Form  CALL_HLPP_SERVICES
*&---------------------------------------------------------------------*
*       Nursing Services Hit list - executed from the clinical workplace
*       (Hopfgartner 2000-03-15)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_hlpp_services TABLES pt_messages STRUCTURE bapiret2
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                             p_fcode        LIKE rseu1-func "ID 19770
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Declarations
  DATA: l_bew      LIKE nbew,         "Movement details
        l_fal      LIKE nfal,         "Case details
        l_movement TYPE rnwp_care_unit_list_head, "Work area movement
        l_wa_msg   LIKE bapiret2,     "Work area error messages
        l_errfal   LIKE sy-subrc.     "Check errors patient/case

  DATA: l_flag_on  TYPE ish_on_off VALUE 'X',               "ID 19770
        l_rc       TYPE sy-subrc,                           "ID 19770
        l_flag_off TYPE ish_on_off VALUE ' '.               "ID 19770

* ED, ID 20128: local data declarations -> BEGIN
  DATA: lt_fal_out   LIKE nfal OCCURS 1,
        lt_movements TYPE ishmed_t_care_unit_list_head,
        l_exit       TYPE ish_on_off,
        lt_fal       LIKE nfal OCCURS 1. "Case table used for function

  DATA: l_tcode      LIKE sy-tcode.     "Transaction code
  DATA: l_n1pmn      TYPE n1orgpar-n1parwert.

  REFRESH: lt_fal_out, lt_fal.
* ED, ID 20128 -> END

* Initialisation
  CLEAR: p_rc, p_refresh, l_bew, l_fal, l_movement, l_wa_msg, l_errfal.

* Depending on p_fcode set different values for function call
  CASE p_fcode.
    WHEN 'HLPP'.
      l_tcode = 'PHL'.
    WHEN 'NHLPP'.
      l_tcode = 'PHN'.
  ENDCASE.

* ED, ID 20128 -> BEGIN
  lt_movements[] = p_lt_movements[].

  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
    READ TABLE lt_movements INTO l_movement INDEX 1.
    CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
      EXPORTING
        i_einri     = l_movement-einri
        i_ou        = l_movement-orgpf
        i_par_name  = 'N1PMN'
      IMPORTING
        e_par_value = l_n1pmn.
    IF l_n1pmn IS NOT INITIAL.
      PERFORM call_add_nrs_service
        TABLES   pt_messages
        USING    lt_movements l_n1pmn l_tcode
        CHANGING p_rc p_refresh.
      EXIT.
    ENDIF.
  ENDIF.

  LOOP AT lt_movements INTO l_movement.
    CLEAR l_fal.
*   Get detail data for case
    PERFORM get_case USING    l_movement
                     CHANGING l_fal
                              l_errfal.
    IF l_errfal = 0.
      IF l_fal-falar = '2'. "outpatient
        APPEND l_fal TO lt_fal_out.
        DELETE lt_movements WHERE falnr = l_movement-falnr.
      ELSEIF l_fal-falar = '1'.
        APPEND l_fal TO lt_fal.
      ENDIF.
    ENDIF.
  ENDLOOP.
  l_exit = off.
  PERFORM set_case_in_table_popup USING lt_fal lt_fal_out l_exit.
  IF l_exit = on.
    p_refresh = 0.
    EXIT.
  ENDIF.
* ED, ID 20128 -> END

* Only 1 Case/Patient is possible
  READ TABLE lt_movements INTO l_movement INDEX 1.

* Get detail data for case and movement
  PERFORM get_fall_bewegung USING     l_movement
                            CHANGING  l_fal
                                      l_bew
                                      l_errfal.
  CASE l_errfal.
    WHEN 1.
      PERFORM build_bapiret2(sapmn1pa)
      USING 'E' 'NF' '051' l_movement-falnr space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 2.
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '076' space space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 0.
*     OK
  ENDCASE.

* Depending on p_fcode set different values for function call (ID 19770)
  IF p_fcode EQ 'NHLPP'.
    CALL FUNCTION 'ISH_SET_PARAMETER_ID'
      EXPORTING
        i_parameter_id    = 'PFLEG_PROF_NACHERF'
        i_parameter_value = l_flag_on.
  ENDIF.

* Call function
  CALL FUNCTION 'ISHMED_CREATE_PFLEGEPROFIL'
    EXPORTING
      i_einri     = l_bew-einri
*     i_gpart     = v_gpart
*     I_TITLE     = ' '
*     I_LOCK_TAB  = 'X'
      i_nbew      = l_bew
    EXCEPTIONS
      read_error  = 1
      cancel      = 2
      end         = 3
      fall_locked = 4
      sys_error   = 5
      no_auth     = 6
      OTHERS      = 7.

  l_rc = sy-subrc.                                          "ID 19770

* ID 19770:
  IF p_fcode EQ 'NHLPP'.
    CALL FUNCTION 'ISH_SET_PARAMETER_ID'
      EXPORTING
        i_parameter_id    = 'PFLEG_PROF_NACHERF'
        i_parameter_value = l_flag_off.
  ENDIF.

* CASE sy-subrc.  "REM ID 19770
  CASE l_rc.                                                "ID 19770
    WHEN 0.
*     OK
      p_rc = 0.
      p_refresh = 2.
      EXIT.
    WHEN 1.
*     No hitlist for this organizational unit
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '215' l_bew-orgpf space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 2.
*     Cancel
      p_rc = 2.
      p_refresh = 0.
      EXIT.
    WHEN 3.
*     End
      p_rc = 0.
      p_refresh = 2.
      EXIT.
    WHEN 4 OR 5.
*     Locking problem
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '081' l_fal-falnr space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 6.
*     No authorization for this transaction
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '000'
                    'Keine Berechtigung für diese Transaktion'(006)
                    space space space space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 7.
*     Error during execution
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' sy-subrc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
  ENDCASE.

ENDFORM.                               " CALL_HLPP_SERVICES

*&---------------------------------------------------------------------*
*&      Form  CALL_EXECUTE_TRANSACTION
*&---------------------------------------------------------------------*
*       Execute specifc transaction based on function code imported
*       (Hopfgartner 2000-03-15)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*      -->P_FCODE         Function code to be executed
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_execute_transaction TABLES pt_messages STRUCTURE bapiret2
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                             p_fcode        LIKE rseu1-func
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Declarations
  DATA: l_movement TYPE rnwp_care_unit_list_head, "Work area movement
        l_wa_msg   LIKE bapiret2,     "Work area error messages
        l_tcauth   TYPE c.            "Authorization for transaction
  DATA: l_care_active     LIKE on.          " Pflege aktiv
* Initialisation
  CLEAR: p_rc, p_refresh, l_movement, l_wa_msg, l_tcauth.

* Depending on p_fcode execute specific transaction
  CASE p_fcode.
    WHEN 'N1LP'.
*     Only read first line of movements (includes needed inforamtion)
      READ TABLE p_lt_movements INTO l_movement INDEX 1.
      CALL FUNCTION 'ISHMED_CARE_ACTIVE'
        EXPORTING
          i_einri       = l_movement-einri
          i_message     = on
        IMPORTING
          e_care_active = l_care_active.

      CHECK l_care_active = on.
*     Call the transaction N1LP
      PERFORM call_tcode(sapmnpa0) USING 'N1LP'
                                   l_movement-einri
                                   off
                                   l_tcauth.
      IF l_tcauth EQ false.
*       No authorization for this transaction
        PERFORM build_bapiret2(sapmn1pa)
                 USING 'E' 'NF1' '000'
                       'Keine Berechtigung für diese Transaktion'(006)
                       space space space space space space
                 CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
      ENDIF.
*     Everything is OK
      p_rc = 0.
      p_refresh = 2.
      EXIT.
  ENDCASE.

ENDFORM.                               " CALL_EXECUTE_TRANSACTION

*&---------------------------------------------------------------------*
*&      Form  CALL_NURSING_PLAN
*&---------------------------------------------------------------------*
*       Nursing Plan - executed from the clinical workplace
*       (Hopfgartner 2000-03-15)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_nursing_plan TABLES pt_messages STRUCTURE bapiret2
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                             VALUE(p_what)  TYPE c
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Declarations
  DATA: l_fal      LIKE nfal,         "Case details
        lt_fal     LIKE nfal OCCURS 1, "Case table used for function
        l_movement TYPE rnwp_care_unit_list_head, "Work area movement
        l_wa_msg   LIKE bapiret2,     "Work area error messages
        l_errfal   LIKE sy-subrc.     "Check errors patient/case

  DATA: l_n1pmn      TYPE n1orgpar-n1parwert.
  DATA: l_orgpf    TYPE nbew-orgpf,  "MED-80625
        lt_movements TYPE ishmed_t_care_unit_list_head. "MED-80625

* ED, ID 20128: local data declarations -> BEGIN
  DATA: lt_fal_out LIKE nfal OCCURS 1,
        l_exit     TYPE ish_on_off.

  REFRESH: lt_fal_out.
* ED, ID 20128 -> END

* Initialisation
  CLEAR: p_rc, p_refresh, l_fal, l_movement, l_wa_msg, l_errfal.
  CLEAR l_orgpf.  "MED-80625

  REFRESH: lt_fal.

* BEGIN MED-80625
  lt_movements[] = p_lt_movements[].
  READ TABLE p_lt_movements INTO l_movement INDEX 1.
  IF sy-subrc = 0 AND l_movement-orgpf CA '*'.
     SELECT SINGLE orgpf FROM nbew INTO l_orgpf
      WHERE einri = l_movement-einri
        AND falnr = l_movement-falnr
        AND lfdnr = l_movement-lfdnr.
      IF sy-subrc EQ 0.
        l_movement-orgpf = l_orgpf.
        MODIFY lt_movements INDEX 1 FROM l_movement TRANSPORTING ORGPF.
      ENDIF.
  ENDIF.
* END MED-80625

  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
*    READ TABLE p_lt_movements INTO l_movement INDEX 1. "MED-80625 MOVED UP

    CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
      EXPORTING
        i_einri     = l_movement-einri
        i_ou        = l_movement-orgpf
        i_par_name  = 'N1PMN'
      IMPORTING
        e_par_value = l_n1pmn.
    IF l_n1pmn IS NOT INITIAL.
      PERFORM call_nrs_plan
        TABLES   pt_messages
*        USING    p_lt_movements l_n1pmn p_what "REM MED-80625
        USING    lt_movements l_n1pmn p_what        "MED-80625
        CHANGING p_rc p_refresh.
      EXIT.
    ENDIF.
  ENDIF.

* AT least 1 Case/Patient is possible
*  LOOP AT p_lt_movements INTO l_movement."REM MED-80625
  LOOP AT lt_movements INTO l_movement.       "MED-80625
*   Get detail data for case
    PERFORM get_case USING     l_movement
                     CHANGING  l_fal
                               l_errfal.
    CASE l_errfal.
      WHEN 0.
*       OK.
*       ED, ID 20128: check case -> if outpatient, do not call
*                     nursing plan -> BEGIN
        IF l_fal-falar = '2'. "outpatient
          APPEND l_fal TO lt_fal_out.
          CLEAR l_fal.
          CONTINUE.
        ENDIF.
*       ED, ID 20128 -> END
      WHEN 1.
*       Add error messages, but continue
        PERFORM build_bapiret2(sapmn1pa)
          USING 'E' 'NF' '051' l_movement-falnr space space space
                                       space space space
          CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
    ENDCASE.
*   Copy case into case table for function call
    APPEND l_fal TO lt_fal.
    CLEAR l_fal.
  ENDLOOP.

* ED, ID 20128 -> BEGIN
  l_exit = off.
  PERFORM set_case_in_table_popup USING lt_fal lt_fal_out l_exit.
  IF l_exit = on.
    p_refresh = 0. "no refresh
    EXIT.
  ENDIF.
* ED, ID 20128 -> END

* Call function
  IF p_what EQ 'S'.
    DESCRIBE TABLE lt_fal.
    IF sy-tfill GT 1.
      PERFORM build_bapiret2(sapmn1pa)
        USING 'E' 'NF1' '438' space space space space
                                    space space space
        CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      EXIT.
    ENDIF.
    CALL FUNCTION 'ISHMED_PFLEGEPLAN_UEBERSICHT'
      EXPORTING
        i_einri = l_movement-einri
        i_orgid = l_movement-orgpf
        i_falnr = l_movement-falnr
        i_orgfa = l_movement-orgfa        "MED-49558 M.Rebegea 08.01.2013 Relevant beginning with 605
        i_patnr = l_movement-patnr        "MED-49558 M.Rebegea 08.01.2013 Relevant beginning with 605
      EXCEPTIONS
        OTHERS  = 1.
  ELSEIF p_what EQ 'N'.
    CALL FUNCTION 'ISHMED_PFLEGEPLAN'
      EXPORTING
        i_erboe          = l_movement-orgpf
        i_dat_von        = g_key_date
        i_dat_bis        = g_key_date
        make_new_nlei    = on
      TABLES
        t_nfal           = lt_fal
      EXCEPTIONS
        no_ankerleistung = 1
        OTHERS           = 2.
  ELSE.
    CALL FUNCTION 'ISHMED_PFLEGEPLAN'
      EXPORTING
        i_erboe          = l_movement-orgpf
        i_dat_von        = g_key_date  "global selection date
        i_dat_bis        = g_key_date  "global selection date
      TABLES
        t_nfal           = lt_fal
      EXCEPTIONS
        no_ankerleistung = 1
        OTHERS           = 2.
  ENDIF.                                                    "ID 6886
  CASE sy-subrc.
    WHEN 0.
*     OK
      p_rc = 0.
      p_refresh = 1.
    WHEN 1 OR 2.
*     Error during execution
*     alle Fehlernachrichten werden im fub pflegeplan ausgegeben
      p_rc = 1.
      p_refresh = 0.
  ENDCASE.

* GUI-Status des Stationsarbeitsplatzes setzen, da er sonst weg ist ...
  CALL FUNCTION 'ISH_WP_GUI_SET'
    EXPORTING
      i_user_id = sy-uname.

ENDFORM.                               " CALL_NURSING_PLAN

*&---------------------------------------------------------------------*
*&      Form  CALL_NURSE_SERVICELIST
*&---------------------------------------------------------------------*
*       Nurse Service List; shows services to be done by nurses
*       - executed from the clinical workplace
*       (Hopfgartner 2000-03-15)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_nurse_servicelist TABLES pt_messages STRUCTURE bapiret2
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Declarations
  DATA: l_fal      LIKE nfal,         "Case details
        lt_fal     LIKE nfal OCCURS 1, "Case table used for function
        l_movement TYPE rnwp_care_unit_list_head, "Work area movement
        l_wa_msg   LIKE bapiret2,     "Work area error messages
        l_errfal   LIKE sy-subrc.     "Check errors patient/case

* ED, ID 20128: local data declarations -> BEGIN
  DATA: lt_fal_out   LIKE nfal OCCURS 1,
        lt_movements TYPE ishmed_t_care_unit_list_head,
        l_exit       TYPE ish_on_off.

  REFRESH: lt_fal_out.
* ED, ID 20128 -> END

* Initialisation
  CLEAR: p_rc, p_refresh, l_fal, l_movement, l_wa_msg, l_errfal.

  REFRESH: lt_fal.

* ED, ID 20128 -> BEGIN
  lt_movements[] = p_lt_movements[].
  LOOP AT lt_movements INTO l_movement.
    CLEAR l_fal.
*   Get detail data for case
    PERFORM get_case USING    l_movement
                     CHANGING l_fal
                              l_errfal.
    IF l_errfal = 0.
      IF l_fal-falar = '2'. "outpatient
        APPEND l_fal TO lt_fal_out.
        DELETE lt_movements WHERE falnr = l_movement-falnr.
      ELSEIF l_fal-falar = '1'.
        APPEND l_fal TO lt_fal.
      ENDIF.
    ENDIF.
  ENDLOOP.
  l_exit = off.
  PERFORM set_case_in_table_popup USING lt_fal lt_fal_out l_exit.
  REFRESH: lt_fal.
  IF l_exit = on.
    p_refresh = 0. "no refresh
    EXIT.
  ENDIF.
* ED, ID 20128 -> END

* Check whether a patient/case has been selected
  READ TABLE lt_movements INTO l_movement INDEX 1.

  IF l_movement-patnr IS INITIAL AND
     l_movement-falnr IS INITIAL.
*   No case/patient selected no values for function call needed
  ELSE.
*   Build case table for function call
    LOOP AT lt_movements INTO l_movement.
*     Get detail data for case
      PERFORM get_case USING     l_movement
                       CHANGING  l_fal
                                 l_errfal.
      CASE l_errfal.
        WHEN 0.
*       OK
        WHEN 1.
*         Add error messages, but continue
          PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF' '051' l_movement-falnr space space space
                                         space space space
                    CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
      ENDCASE.
      APPEND l_fal TO lt_fal.
      CLEAR: l_fal.
    ENDLOOP.
  ENDIF.

* Call function
  CALL FUNCTION 'ISHMED_PFLEPLA_AL'
    TABLES
      x_nfal     = lt_fal
      x_movement = lt_movements
    EXCEPTIONS
      OTHERS     = 1.
  CASE sy-subrc.
    WHEN 0.
*     OK
      p_rc = 0.
      p_refresh = 1.
      EXIT.
    WHEN 1.
*     Error during execution
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' sy-subrc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
  ENDCASE.

ENDFORM.                               " CALL_NURSE_SERVICELIST

*&---------------------------------------------------------------------*
*&      Form  GET_CASE
*&---------------------------------------------------------------------*
*       Get Case details for the imported movement data
*       (Hopfgartner 2000-03-15)
*----------------------------------------------------------------------*
*      -->P_MOVEMENT  Movement
*      <--P_FAL       Case data
*      <--P_ERRFAL    Error code (0=OK, 1=case not found).
*----------------------------------------------------------------------*
FORM get_case USING    VALUE(p_movement) TYPE rnwp_care_unit_list_head
              CHANGING p_fal LIKE nfal
                       p_errfal LIKE sy-subrc.

* Initialisation
  CLEAR: p_errfal.

* Read case data from DB
  SELECT SINGLE * FROM nfal INTO p_fal
         WHERE  einri  = p_movement-einri
         AND    falnr  = p_movement-falnr.
  IF sy-subrc <> 0.
    p_errfal = 1.
    EXIT.
  ELSE.
    p_errfal = 0.
  ENDIF.

ENDFORM.                               " GET_CASE

*&---------------------------------------------------------------------*
*&      Form  CALL_NURSING_REPORTLIST
*&---------------------------------------------------------------------*
*       View or create nursing report - executed from the clinical WP
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_nursing_reportlist TABLES pt_messages STRUCTURE bapiret2
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Declarations
  DATA: l_movement              TYPE rnwp_care_unit_list_head,
        l_wa_msg                TYPE bapiret2,
        l_tcode                 TYPE sy-tcode,
*       Function Call Parameter for Document
        l_ndoc                  TYPE ndoc OCCURS 1 WITH HEADER LINE,
        l_wa_ndoc               TYPE ndoc,
*       determination of user specific vma parameter
        l_user                  TYPE usr05-bname,
        l_usr_param_value       TYPE usr05-parva,
*       Process multiple selection
        l_rc                    TYPE sy-subrc,
        l_lines                 TYPE sy-tfill,
        l_count_docs            TYPE i,
        l_apicontrol            TYPE rn2doc_apicontrol,
        l_doc_key               TYPE rn2doc_key,
*        l_worst_msgty      TYPE ish_bapiretmaxty,
        l_pmd_okcode            TYPE sy-ucomm,
        lt_command              TYPE TABLE OF n2cmd,
*       scroll in list with new entries
        l_diagnose_object       TYPE dokhl-object,
        l_text_question(60)     TYPE c,
        l_answer(1)             TYPE c,
        l_text_button_1(8)      TYPE c,
        l_text_button_2(8)      TYPE c,
        l_icon_button_1         TYPE icon-name,
        l_icon_button_2         TYPE icon-name,
        l_icon_cancel           TYPE icon-name,
        l_iv_quickinfo_button_1 TYPE text132,
        l_iv_quickinfo_button_2 TYPE text132.

* ED, ID 20128: local data declarations -> BEGIN
  DATA: lt_fal_out   LIKE nfal OCCURS 1,
        lt_movements TYPE ishmed_t_care_unit_list_head,
        l_exit       TYPE ish_on_off,
        l_fal        LIKE nfal,         "Case details
        lt_fal       LIKE nfal OCCURS 1, "Case table used for function
        l_errfal     LIKE sy-subrc.     "Check errors patient/case

  REFRESH: lt_fal_out, lt_fal.
* ED, ID 20128 -> END

* Initialisation
  CLEAR: p_rc, p_refresh, l_movement, l_wa_msg, l_tcode, l_wa_ndoc.
  CLEAR: l_ndoc. REFRESH: l_ndoc.
* popup to confirm
  l_text_question         = text-020.
  l_diagnose_object       = 'ISHMED_N2_DOKTYP_PUSHBUTTON'.
  l_text_button_1         = 'Dokument'(024).
  l_iv_quickinfo_button_1 = 'Nächstes Dokument'(021).
  l_icon_button_1         = icon_next_object.
  l_text_button_2         = 'Dokument'(024).
  l_iv_quickinfo_button_2 = 'Voriges Dokument'(022).
  l_icon_button_2         = icon_previous_object.
  l_icon_cancel           = icon_cancel.

* ED, ID 20128 -> BEGIN
  lt_movements[] = p_lt_movements[].
  LOOP AT lt_movements INTO l_movement.
    CLEAR l_fal.
*   Get detail data for case
    PERFORM get_case USING    l_movement
                     CHANGING l_fal
                              l_errfal.
    IF l_errfal = 0.
      IF l_fal-falar = '2'. "outpatient
        APPEND l_fal TO lt_fal_out.
        DELETE lt_movements WHERE falnr = l_movement-falnr.
      ELSEIF l_fal-falar = '1'.
        APPEND l_fal TO lt_fal.
      ENDIF.
    ENDIF.
  ENDLOOP.
  l_exit = off.
  PERFORM set_case_in_table_popup USING lt_fal lt_fal_out l_exit.
  IF l_exit = on.
    p_refresh = 0. "no refresh
    EXIT.
  ENDIF.
* ED, ID 20128 -> END

  DESCRIBE TABLE lt_movements LINES l_lines.
  l_count_docs = 1.

* process selected cases
  WHILE sy-subrc = 0.

*   At least 1 Case/Patient is possible
    READ TABLE lt_movements INTO l_movement INDEX l_count_docs.
    IF sy-subrc NE 0.                            "safety first !!
      EXIT.
    ENDIF.

*   stop recursive call
    CALL METHOD cl_ishmed_flag=>set_flag
      EXPORTING
        i_name = 'CALL_NURSING_REPORTLIST'.                 "ID 14444

*   Check whether a nursing document exists, based on this call the
*   correct transactioncode
    SELECT * FROM ndoc INTO TABLE l_ndoc
                       WHERE einri = l_movement-einri
                         AND patnr = l_movement-patnr
                         AND falnr = l_movement-falnr
                         AND dtid  = 'N4PVB'
                         AND loekz = ' '.

    IF sy-subrc NE 0.
*     insert document
      l_tcode = 'N201'.
*     user parameter VMA
      CLEAR l_ndoc. REFRESH l_ndoc.
      CLEAR: l_ndoc-mitarb, l_usr_param_value.
      l_user = sy-uname.

      CALL FUNCTION 'ISH_USR05_GET'
        EXPORTING
          ss_bname         = l_user
          ss_parid         = 'VMA'
        IMPORTING
          ss_value         = l_usr_param_value
        EXCEPTIONS
          parid_not_found  = 1
          bname_is_initial = 2
          parid_is_initial = 3
          OTHERS           = 4.
      IF sy-subrc = 0.
        l_ndoc-mitarb = l_usr_param_value.
      ENDIF.
*
      l_ndoc-orgdo = l_movement-orgpf.   "For a new document needed
      l_ndoc-mandt = sy-mandt.
      l_ndoc-einri = l_movement-einri.
      l_ndoc-patnr = l_movement-patnr.
      l_ndoc-falnr = l_movement-falnr.
      l_ndoc-dtid   = 'N4PVB'.
      APPEND l_ndoc.
*     Function call
      CALL FUNCTION 'ISH_N2_MEDICAL_DOCUMENT'
        EXPORTING
          ss_einri    = l_movement-einri
          ss_mode     = 'NOPU'
          ss_tcode    = l_tcode
        TABLES
          ss_ndoc     = l_ndoc
        EXCEPTIONS
          no_document = 1
          no_insert   = 2
          cancel      = 3
          OTHERS      = 4.
      CASE sy-subrc.
        WHEN 0.                            "OK
          p_rc = 0.
          p_refresh = 1.
*         EXIT.
        WHEN 1.                            "Error: no document
          PERFORM build_bapiret2(sapmn1pa)
                  USING 'E' 'NG' '012' space space space space
                                       space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
*         EXIT.
        WHEN 2 OR 3.                       "Cancel
          p_rc = 2.
          p_refresh = 0.
*         EXIT.
        WHEN 4.                            "Error during execution
          PERFORM build_bapiret2(sapmn1pa)
                  USING 'E' 'NF' '139' sy-subrc space space space
                                       space space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
*         EXIT.
      ENDCASE.
*     scroll in the list - backard/forward
      IF l_lines > 1.
        CLEAR l_rc.
        sy-subrc = 0.
        CLEAR l_rc.
      ENDIF.
    ELSE.
      SORT l_ndoc BY dokar ASCENDING doknr ASCENDING dokvr DESCENDING. "MED-29544
*     change dokuments
      READ TABLE l_ndoc INTO l_wa_ndoc INDEX 1.

      l_tcode = 'N202'.
      CALL FUNCTION 'ISH_N2_SET_APICONTROL_DEFAULT'
        EXPORTING
          im_method     = 'CHANGE'                        "p_method
        CHANGING
          ch_apicontrol = l_apicontrol.

      l_apicontrol-number   = l_lines.
      l_apicontrol-position = l_count_docs.
      MOVE-CORRESPONDING l_wa_ndoc TO l_doc_key.            "#EC ENHOK
      CALL FUNCTION 'ISH_N2_DOCUMENT_MAINTENANCE'
        EXPORTING
          im_apicontrol   = l_apicontrol
          im_document_key = l_doc_key
*         im_document_key_copy =
        IMPORTING
*         ex_worst_msgty  = l_worst_msgty
          ex_return_code  = l_pmd_okcode
        TABLES
          ext_return      = pt_messages
          imt_commands    = lt_command.

      CASE l_pmd_okcode.
        WHEN 'D+'.
          l_rc = 1.
        WHEN 'D-'.
          l_rc = 2.
        WHEN 'BACK'.
          l_rc = 8.
        WHEN 'END'.
          l_rc = 8.
        WHEN '%EX'.                        "wie END
          l_rc = 8.
        WHEN 'CAN'.
          l_rc = 8.
        WHEN 'RW'.                          "wie CAN
          l_rc = 8.
      ENDCASE.
    ENDIF.
    CASE l_rc.
      WHEN 0.                              "OK
        p_rc = 0.
        p_refresh = 1.
      WHEN 1.                              "next doc
*       nothing to do, because this is the standard
      WHEN 2.                              "next doc
*       the previous doc
        SUBTRACT 2 FROM l_count_docs.
      WHEN 8.                              "BACK, etc
        EXIT.                              " --> loop
    ENDCASE.

*   navigation for new documents
    IF l_tcode = 'N201' AND l_count_docs <= l_lines AND l_lines > 1.
*     first document in list
      IF l_count_docs = 1.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
*           TITLEBAR              = ' '
            diagnose_object       = l_diagnose_object
            text_question         = l_text_question
            text_button_1         = l_text_button_1
            icon_button_1         = l_icon_button_1
            text_button_2         = 'Abbruch'(023)
            icon_button_2         = l_icon_cancel
*           DEFAULT_BUTTON        = '1'
            display_cancel_button = ' '
*           USERDEFINED_F1_HELP   = ' '
*           START_COLUMN          = 25
*           START_ROW             = 6
*           POPUP_TYPE            = ' '
            iv_quickinfo_button_1 = l_iv_quickinfo_button_1
*           iv_quickinfo_button_2 = 'Abbruch'(023)
          IMPORTING
            answer                = l_answer.
        IF l_answer = '2'.
          EXIT.
        ENDIF.
      ENDIF.
*     last document in list
      IF l_count_docs = l_lines.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
*           TITLEBAR              = ' '
            diagnose_object       = l_diagnose_object
            text_question         = l_text_question
            text_button_1         = l_text_button_2
            icon_button_1         = l_icon_button_2
            text_button_2         = 'Abbruch'(023)
            icon_button_2         = l_icon_cancel
*           DEFAULT_BUTTON        = '1'
            display_cancel_button = ' '
*           USERDEFINED_F1_HELP   = ' '
*           START_COLUMN          = 25
*           START_ROW             = 6
*           POPUP_TYPE            = ' '
            iv_quickinfo_button_1 = l_iv_quickinfo_button_2
*           iv_quickinfo_button_2 = 'Abbruch'(023)
          IMPORTING
            answer                = l_answer.
        IF l_answer = '2'.
          EXIT.
        ELSE.
          SUBTRACT 2 FROM l_count_docs.
        ENDIF.
      ENDIF.
*     document between first and last entry
      IF l_count_docs > 1 AND l_count_docs < l_lines.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
*           TITLEBAR              = ' '
            diagnose_object       = l_diagnose_object
            text_question         = l_text_question
            text_button_1         = l_text_button_1
            icon_button_1         = l_icon_button_1
            text_button_2         = l_text_button_2
            icon_button_2         = l_icon_button_2
*           DEFAULT_BUTTON        = '1'
            display_cancel_button = 'X'
*           USERDEFINED_F1_HELP   = ' '
*           START_COLUMN          = 25
*           START_ROW             = 6
*           POPUP_TYPE            = ' '
            iv_quickinfo_button_1 = l_iv_quickinfo_button_1
            iv_quickinfo_button_2 = l_iv_quickinfo_button_2
          IMPORTING
            answer                = l_answer.
        IF l_answer = 'A'.
          EXIT.
        ELSEIF l_answer = '2'.
          SUBTRACT 2 FROM l_count_docs.
        ENDIF.
      ENDIF.
    ENDIF.

    ADD 1 TO l_count_docs.

  ENDWHILE.

  CALL METHOD cl_ishmed_flag=>del_flag
    EXPORTING
      i_name = 'CALL_NURSING_REPORTLIST'.                   "ID 14444

ENDFORM.                               " CALL_NURSING_REPORTLIST

*&---------------------------------------------------------------------*
*&      Form  CALL_NURSING_SCORE
*&---------------------------------------------------------------------*
*       Display/change planned nursing scores
*       - executed from the clinical WP
*       (Hopfgartner 2000-03-15)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_nursing_score TABLES pt_messages    STRUCTURE
                                              bapiret2      "#EC NEEDED
                        USING  p_lt_movements TYPE
                                         ishmed_t_care_unit_list_head
                        CHANGING p_rc         LIKE sy-subrc
                                 p_refresh    LIKE n1fld-refresh.

* Declarations
  DATA: l_movement  TYPE rnwp_care_unit_list_head, "Work area movement
        tcode       LIKE sy-tcode,       "Transaction code
        l_date_low  LIKE sy-datum,
        l_date_high LIKE sy-datum.
  DATA: l_care_active     LIKE on.          " care active

  RANGES: lr_falnr  FOR nfal-falnr.    "Range of cases

* ED, ID 20128: local data declarations -> BEGIN
  DATA: lt_fal_out   LIKE nfal OCCURS 1,
        lt_movements TYPE ishmed_t_care_unit_list_head,
        l_exit       TYPE ish_on_off,
        l_fal        LIKE nfal,         "Case details
        lt_fal       LIKE nfal OCCURS 1, "Case table used for function
        l_errfal     LIKE sy-subrc.     "Check errors patient/case

  REFRESH: lt_fal_out, lt_fal.
* ED, ID 20128 -> END

* Initialisation
  CLEAR: p_rc, p_refresh, l_movement, l_date_low, l_date_high.

  CLEAR: lr_falnr.              REFRESH: lr_falnr.

  l_date_low = sy-datum + 1.
  l_date_high = sy-datum + 8.
  lr_falnr-option = 'EQ'.
  lr_falnr-sign   = 'I'.

* Set tcode value for report call to transaction code of the previous
* "Medizinische Stationsliste" (care unit list) - necessary for correct
* processing!!
  tcode = 'N1ML'.

* ED, ID 20128 -> BEGIN
  lt_movements[] = p_lt_movements[].
  LOOP AT lt_movements INTO l_movement.
    CLEAR l_fal.
*   Get detail data for case
    PERFORM get_case USING    l_movement
                     CHANGING l_fal
                              l_errfal.
    IF l_errfal = 0.
      IF l_fal-falar = '2'. "outpatient
        APPEND l_fal TO lt_fal_out.
        DELETE lt_movements WHERE falnr = l_movement-falnr.
      ELSEIF l_fal-falar = '1'.
        APPEND l_fal TO lt_fal.
      ENDIF.
    ENDIF.
  ENDLOOP.
  l_exit = off.
  PERFORM set_case_in_table_popup USING lt_fal lt_fal_out l_exit.
  IF l_exit = on.
    p_refresh = 0. "no refresh
    EXIT.
  ENDIF.
* ED, ID 20128 -> END

* Copy cases into range of cases for report submit
  LOOP AT lt_movements INTO l_movement.
    lr_falnr-low = l_movement-falnr.
    APPEND lr_falnr.
  ENDLOOP.

* Set values for report
  READ TABLE lt_movements INTO l_movement INDEX 1.

  CALL FUNCTION 'ISHMED_CARE_ACTIVE'
    EXPORTING
      i_einri       = l_movement-einri
      i_message     = on
    IMPORTING
      e_care_active = l_care_active.

  CHECK l_care_active = on.

* Execute report
  EXPORT tcode TO MEMORY ID 'RN2UPPR0'.

  SUBMIT rn1uppr0
    WITH se_einri EQ l_movement-einri
    WITH se_orgid EQ l_movement-orgpf
    WITH ausbegdt EQ l_date_low
    WITH ausenddt EQ l_date_high
    WITH se_falnr IN lr_falnr
    WITH test_mod EQ space
  AND RETURN.

* No error checking here. Refresh all
  p_rc = 0.
  p_refresh = 2.

ENDFORM.                               " CALL_NURSING_SCORE

*&---------------------------------------------------------------------*
*&      Form  CALL_SERVICES_OVERVIEW
*&---------------------------------------------------------------------*
*       Display all Services of a patient
*       - executed from the clinical WP
*       (Hopfgartner 2000-03-15)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_services_overview TABLES pt_messages STRUCTURE bapiret2
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Declarations
  DATA: l_fal      LIKE nfal,         "Case details
        l_npat     LIKE npat,         "Patient details
        l_movement TYPE rnwp_care_unit_list_head, "Work area movement
        l_wa_msg   LIKE bapiret2,     "Work area error messages
        l_errfal   LIKE sy-subrc.     "Check errors patient/case

* Initialisation
  CLEAR: p_rc, p_refresh, l_fal, l_npat, l_movement, l_wa_msg, l_errfal.

* Only 1 Case/Patient is possible
  READ TABLE p_lt_movements INTO l_movement INDEX 1.

* Get detail data for case
  PERFORM get_case USING     l_movement
                   CHANGING  l_fal
                             l_errfal.
  CASE l_errfal.
    WHEN 0.
*   OK
    WHEN 1.
*     Add error messages, but continue
      PERFORM build_bapiret2(sapmn1pa)
        USING 'E' 'NF' '051' l_movement-falnr space space space
                                     space space space
                CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
  ENDCASE.

* Get detailed data for patient.
  PERFORM get_patient_data TABLES   pt_messages
                           USING    l_fal
                           CHANGING l_npat
                                    p_rc.
  CHECK p_rc EQ 0.

* Prepare for executing the report
  SET PARAMETER ID 'PAT' FIELD l_npat-patnr.
  SET PARAMETER ID 'PZP' FIELD l_npat-pziff.
  SET PARAMETER ID 'FAL' FIELD l_fal-falnr.
  SET PARAMETER ID 'PZF' FIELD l_fal-fziff.
  SET PARAMETER ID 'SFS' FIELD on.
  SUBMIT rn1lptls AND RETURN.

* No error checking. Refresh all.
  p_rc = 0.
  p_refresh = 2.

ENDFORM.                               " CALL_SERVICES_OVERVIEW

*&---------------------------------------------------------------------*
*&      Form  CALL_COPY_SERVICES
*&---------------------------------------------------------------------*
*       Copy Nursing Services of a patient/group of patients
*       - executed from the clinical WP
*       (Hopfgartner 2000-03-15)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_copy_services TABLES pt_messages STRUCTURE bapiret2
                      USING  p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                      CHANGING p_rc         LIKE sy-subrc
                               p_refresh    LIKE n1fld-refresh.

* Declarations
  DATA: l_bew       LIKE nbew,         "Movement details
        l_fal       LIKE nfal,         "Case details
        l_movement  TYPE rnwp_care_unit_list_head, "Work area movement
        l_wa_msg    LIKE bapiret2,     "Work area error messages
        l_date_from LIKE nbew-bwidt,
        l_date_to   LIKE nbew-bwidt,
        l_date_to1  LIKE nbew-bwidt,
        l_gpart     LIKE n1lsstz-gpart, "Responsible person
        l_errfal    LIKE sy-subrc.     "Check errors patient/case

* ED, ID 20128: local data declarations -> BEGIN
  DATA: lt_fal_out   LIKE nfal OCCURS 1,
        lt_movements TYPE ishmed_t_care_unit_list_head,
        l_exit       TYPE ish_on_off,
        l_n1pmn      TYPE n1parwert,
        lt_fal       LIKE nfal OCCURS 1. "Case table used for function

  REFRESH: lt_fal_out, lt_fal.
* ED, ID 20128 -> END

* Initialisation
  CLEAR: p_rc, p_refresh, l_bew, l_fal, l_movement, l_wa_msg, l_errfal.

* ED, ID 20128 -> BEGIN
  lt_movements[] = p_lt_movements[].

  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
    READ TABLE lt_movements INTO l_movement INDEX 1.
    CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
      EXPORTING
        i_einri     = l_movement-einri
        i_ou        = l_movement-orgpf
        i_par_name  = 'N1PMN'
      IMPORTING
        e_par_value = l_n1pmn.
    IF l_n1pmn IS NOT INITIAL.
      PERFORM call_nrssrv_copy
        TABLES   pt_messages
        USING    lt_movements l_n1pmn
        CHANGING p_rc p_refresh.
      EXIT.
    ENDIF.
  ENDIF.

  LOOP AT lt_movements INTO l_movement.
    CLEAR l_fal.
*   Get detail data for case
    PERFORM get_case USING    l_movement
                     CHANGING l_fal
                              l_errfal.
    IF l_errfal = 0.
      IF l_fal-falar = '2'. "outpatient
        APPEND l_fal TO lt_fal_out.
        DELETE lt_movements WHERE falnr = l_movement-falnr.
      ELSEIF l_fal-falar = '1'.
        APPEND l_fal TO lt_fal.
      ENDIF.
    ENDIF.
  ENDLOOP.
  l_exit = off.
  PERFORM set_case_in_table_popup USING lt_fal lt_fal_out l_exit.
  IF l_exit = on.
    p_refresh = 0.
    EXIT.
  ENDIF.
* ED, ID 20128 -> END

* Read first marked patient/case (at least one is there)
  READ TABLE lt_movements INTO l_movement INDEX 1.

* Get movement data for the first case
  PERFORM get_fall_bewegung USING     l_movement
                            CHANGING  l_fal
                                      l_bew
                                      l_errfal.
  CASE l_errfal.
    WHEN 1.
      PERFORM build_bapiret2(sapmn1pa)
      USING 'E' 'NF' '051' l_movement-falnr space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 2.
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '076' space space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 0.
*     OK
  ENDCASE.

* Call function: responsible person
  CALL FUNCTION 'ISHMED_VMA_COPY_SERVICES'
    EXPORTING
      i_einri    = l_bew-einri
      i_nbew     = l_bew
      i_lock_tab = on
    IMPORTING
      e_dat_von  = l_date_from
      e_dat_bis  = l_date_to
      e_dat_bis2 = l_date_to1
      e_gpart    = l_gpart
    EXCEPTIONS
      cancel     = 1
      OTHERS     = 2.
  CASE sy-subrc.
    WHEN 0.                            " Alles OK
    WHEN 1.                            " CANCEL
      p_rc = 2.
      p_refresh = 0.
      EXIT.
    WHEN OTHERS.
*     Error during execution
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' sy-subrc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
  ENDCASE.

* Copy Services for marked patients
  LOOP AT lt_movements INTO l_movement.
*   Get movement data case, on error continue
    PERFORM get_fall_bewegung USING     l_movement
                              CHANGING  l_fal
                                        l_bew
                                        l_errfal.
    CASE l_errfal.
      WHEN 1.
        PERFORM build_bapiret2(sapmn1pa)
        USING 'E' 'NF' '051' l_movement-falnr space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
      WHEN 2.
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '076' space space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
      WHEN 0.
*      OK
    ENDCASE.

    CALL FUNCTION 'ISHMED_COPY_SERVICES'
      EXPORTING
        i_einri     = l_bew-einri
        i_gpart     = l_gpart
        i_dat_von   = l_date_from
        i_dat_bis   = l_date_to
        i_dat_bis2  = l_date_to1
        i_nbew      = l_bew
      EXCEPTIONS
        read_error  = 1
        cancel      = 2
        end         = 3
        fall_locked = 4
        sys_error   = 5
        no_auth     = 6
        OTHERS      = 7.
    CASE sy-subrc.
      WHEN 0.                          " Alles OK
        p_rc = 0.
        p_refresh = 2.
      WHEN 1.                          " No service found, continue
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '338' l_date_from space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
      WHEN 2.                          " CANCEL
        p_rc = 2.
        p_refresh = 0.
      WHEN 3.
*       End
        p_rc = 0.
        p_refresh = 2.
        EXIT.
      WHEN 4  OR  5.
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '081' l_bew-falnr space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        EXIT.
      WHEN 6.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
      WHEN OTHERS.
*       Error during execution
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '139' sy-subrc space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
    ENDCASE.
    CLEAR: l_fal, l_bew.
  ENDLOOP.

ENDFORM.                               " CALL_COPY_SERVICES

*&---------------------------------------------------------------------*
*&      Form  call_patient_transport_request
*&---------------------------------------------------------------------*
*       Create, delete or change a patient transport request
*       - executed from the clinical WP
*       (Hopfgartner 2000-05-23)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*        -->P_FCODE       Function code to be executed
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_patient_transport_request
                      TABLES   pt_messages STRUCTURE bapiret2
                      USING    p_lt_movements TYPE
                                            ishmed_t_care_unit_list_head
                               p_fcode     LIKE rseu1-func
                      CHANGING p_rc        LIKE sy-subrc
                               p_refresh   LIKE n1fld-refresh.

* Declarations
  DATA: l_n1fat       TYPE n1fat,        "Patient transport request data
        l_movement    TYPE rnwp_care_unit_list_head, "Work area movement
        l_wa_msg      TYPE bapiret2,     "Work area error messages
        l_rc          TYPE sy-subrc,     "Error code function call
        l_bew         TYPE nbew,
        l_wa_messages TYPE rn1chkret,
        lt_messages   TYPE TABLE OF rn1chkret.

* Initialisation
  CLEAR: p_rc, p_refresh, l_n1fat, l_movement, l_wa_msg, l_rc,
         lt_messages.

* Read movement data into local work area; always 1 record there
* It may include a patient_id, but it is not mandatory
  READ TABLE p_lt_movements INTO l_movement INDEX 1.

  CASE p_fcode.
*   Insert a new patient transport request
    WHEN 'PTRI' OR 'PTS_INSO'.
      IF p_fcode = 'PTRI'.
*       Prepare needed data for function call
        IF NOT l_movement-patnr IS INITIAL.
          l_n1fat-patnr = l_movement-patnr.
        ELSEIF NOT l_movement-papid IS INITIAL.
          l_n1fat-papid = l_movement-papid.
        ENDIF.
*       ID 8031: auch Zimmer vorbelegen
        READ TABLE gt_nbew INTO l_bew
             WITH TABLE KEY einri = l_movement-einri
                            falnr = l_movement-falnr
                            lfdnr = l_movement-lfdnr.
        IF sy-subrc <> 0.
          SELECT SINGLE * FROM nbew INTO l_bew
                 WHERE  einri  = l_movement-einri
                 AND    falnr  = l_movement-falnr
                 AND    lfdnr  = l_movement-lfdnr.
        ENDIF.
        IF sy-subrc = 0 AND NOT l_bew-zimmr IS INITIAL.
          l_n1fat-bauag = l_bew-zimmr.
        ENDIF.
      ENDIF.
      l_n1fat-orgag = l_movement-orgpf.
      l_n1fat-einri = l_movement-einri.
      CALL FUNCTION 'ISHMED_PTS_ORDER_UPDATE'
        EXPORTING
          i_n1fat       = l_n1fat
          i_vcode       = 'INS'
          i_dialog      = 'X'    "Always with dialog
          i_event       = 'FATINS'
          i_orgid       = l_movement-orgpf
*         I_VORB_UPD    = ' '
*         I_NTMN        =
*         I_NTMN_OLD    =
          i_save        = 'X'
          i_commit      = 'X'
          i_update_task = ' '
          i_messages    = 'X'
        IMPORTING
          e_rc          = l_rc
        TABLES
*         T_NAPP        =
*         T_NAPP_OLD    =
*         T_N1FAT       =
*         T_N1FSZ       =
          t_messages    = lt_messages.
      CASE l_rc.
        WHEN '0'.
*         Everything is OK.
          p_rc = 0.
          p_refresh = 1.
        WHEN '1'.
*         Some Error occured.
*         Append all messages to message return structure
          LOOP AT lt_messages INTO l_wa_messages.
            MOVE-CORRESPONDING l_wa_messages TO l_wa_msg.   "#EC ENHOK
            APPEND l_wa_msg TO pt_messages.
            CLEAR l_wa_msg. CLEAR l_wa_messages.
          ENDLOOP.
          p_rc = 1.
          p_refresh = 0.
        WHEN '2'.
*         Cancel
          p_rc = 2.
          p_refresh = 0.
      ENDCASE.
  ENDCASE.

* GUI-Status des Stationsarbeitsplatzes setzen, da er sonst weg ist ...
* (durch die ev. hochkommende Fahrauftrags-Storno-AV-Liste)
  CALL FUNCTION 'ISH_WP_GUI_SET'                            " ID 8078
    EXPORTING
      i_user_id = sy-uname.

ENDFORM.                               " call_patient_transport_request
*--------------------------------------------------------------------
* Form Check_ISHMED
* Prüft ob ISHMED verwendet wird
*--------------------------------------------------------------------
FORM check_ishmed CHANGING l_ishmed_used TYPE i.

  DATA: l_wa_tn00 LIKE tn00.

  l_ishmed_used = false.

  SELECT SINGLE * FROM tn00 INTO l_wa_tn00
         WHERE keyfil = '1'.
  IF sy-subrc = 0.
    IF l_wa_tn00-ishmed = 'X'.
      l_ishmed_used = true.
    ENDIF.
  ENDIF.

ENDFORM.                               " CHECK_ISHMED
*&---------------------------------------------------------------------*
*&      Form  check_hotspot
*&---------------------------------------------------------------------*
*       In diesem UP wird geprüft, ob der Aufruf der entsprechenden
*       Funktion erlaubt ist -> Prüfung der entsprechenden
*       einrichtungsbezogenen Parameter                    (ID 6208)
*----------------------------------------------------------------------*
*      --> P_T_MESSAGES Meldungen
*      --> P_param      Parameter
*      --> P_einri      Einrichtung
*      --> P_wplaceid   Arbeitsumfeld ID
*      <-- P_RC         Returncode (0=OK, 1=not possible, 2=call view)
*----------------------------------------------------------------------*
FORM check_hotspot TABLES   pt_messages       STRUCTURE bapiret2
                   USING    VALUE(p_param)    TYPE any
                            VALUE(p_einri)    LIKE tn01-einri
                            VALUE(p_wplaceid) TYPE nwplace-wplaceid
                   CHANGING p_rc              LIKE sy-subrc.

  DATA: l_wa_msg   LIKE bapiret2,
        l_check(1) TYPE c,
        l_einri    TYPE einri,
        l_tn00r    LIKE tn00r.
  CLEAR: l_wa_msg, p_rc, l_check, l_tn00r.

* ID 12104: check parameter and institution
  CHECK NOT p_param IS INITIAL.

  l_einri = p_einri.
  IF l_einri IS INITIAL.
*   get institution from work environment
    IF NOT p_wplaceid IS INITIAL.
      SELECT SINGLE einri FROM nwplace_001 INTO l_einri
             WHERE  wplacetype  = '001'
             AND    wplaceid    = p_wplaceid.
    ENDIF.
    IF l_einri IS INITIAL.
*     get institution from user parameter
      GET PARAMETER ID 'EIN' FIELD l_einri.
    ENDIF.
    IF l_einri IS INITIAL.
      EXIT.
    ENDIF.
  ENDIF.

  CLEAR l_tn00r-value.
  CALL FUNCTION 'ISH_TN00R_READ'
    EXPORTING
      ss_einri  = l_einri
      ss_param  = p_param
    IMPORTING
      ss_value  = l_tn00r-value
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.
  IF sy-subrc = 0.
    MOVE l_tn00r-value(1) TO l_check.
  ENDIF.

  IF l_check = 'X'.                    "Aufruf der Funktion erlaubt
    p_rc = 0.
    EXIT.
  ELSEIF l_check = 'S'.                "Aufruf des Sichtenprogramms
    p_rc = 2.
    EXIT.
  ELSE.                   "Aufruf nicht erlaubt -> Message ausgeben
    p_rc = 1.
    IF p_param = 'N1WP_AHS'.         "Anforderungen
*     Fehlermeldung ausgeben -> Keine Funktion verknüpft
      PERFORM build_bapiret2(sapmn1pa)
              USING 'S' 'NF1' '524' space space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
    ELSEIF p_param = 'N1WP_DHS'.     "Dokumente
      PERFORM build_bapiret2(sapmn1pa)
              USING 'S' 'NF1' '525' space space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
    ENDIF.
    EXIT.
  ENDIF.

ENDFORM.                               " check_hotspot
*&---------------------------------------------------------------------*
*&      Form  check_uex_diag_display
*&---------------------------------------------------------------------*
*       Check if user-exit-value of diagnosis should be displayed
*----------------------------------------------------------------------*
FORM check_uex_diag_display TABLES   pt_messages STRUCTURE bapiret2
                                     pt_selvar   STRUCTURE rsparams
                            USING    p_listkz    TYPE n1dplistkz
                            CHANGING p_rc        LIKE sy-subrc.

  DATA: l_wa_msg    TYPE bapiret2,
        l_list_head TYPE rnwp_care_unit_list_head,
        l_dispvar   TYPE lvc_s_fcat,
        l_vardata   LIKE rn1uex,
        lt_vardata  LIKE TABLE OF rn1uex.

  CLEAR:  l_list_head, l_dispvar, l_vardata.
  REFRESH lt_vardata.

  p_rc = 1.

  l_list_head-listkz = p_listkz.                            " ID 8690

  l_dispvar-fieldname = 'DIAGNOSE'.

  l_vardata-o_name   = l_dispvar-fieldname.
  l_vardata-n_name   = l_dispvar-fieldname.
  APPEND l_vardata TO lt_vardata.

  PERFORM call_userexit_disp TABLES  lt_vardata pt_selvar
                             USING   l_list_head
                                     on.               " check only !

  LOOP AT lt_vardata INTO l_vardata WHERE o_name = 'DIAGNOSE'
                                    AND   use_uex = on.
    p_rc = 0.
  ENDLOOP.

* if user-exit-diagnosis should not be displayed -> send message when
* 'DIAG+/-'-button was pressed
  IF p_rc <> 0.
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF1' '535' space space space space
                                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO pt_messages.
  ENDIF.

ENDFORM.                    " check_uex_diag_display

*&---------------------------------------------------------------------*
*&      Form  call_patient_history
*&---------------------------------------------------------------------*
*       Patientenhistorie
*----------------------------------------------------------------------*
*      --> PT_MESSAGES   Meldungen
*      --> PT_MOVEMENTS  Bewegung
*      --> P_FCODE       Funktionscode (PORG, PHIS, VPPO)
*      <-- P_RC          Returncode (0=OK, 1=Error, 2=Cancel)
*      <-- P_REFRESH     Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_patient_history TABLES   pt_messages    STRUCTURE bapiret2
                          USING    pt_movements   TYPE
                                          ishmed_t_care_unit_list_head
                                   p_fcode        LIKE rseu1-func
                          CHANGING p_rc           LIKE sy-subrc
                                   p_refresh      LIKE n1fld-refresh
                                   pr_environment TYPE REF TO
                                                  cl_ish_environment.

  DATA: l_wa_msg   LIKE bapiret2,
        l_timeline TYPE ish_on_off,
        l_outpmap  TYPE ish_on_off.
  DATA: l_nrsnote      TYPE ish_on_off.                     "Med-41542
  DATA: l_ippdnote     TYPE ish_on_off.                     "Med-41919
  DATA: l_movement    TYPE rnwp_care_unit_list_head,
        lt_rn1po_call TYPE TABLE OF rn1po_call,
        l_rn1po_call  LIKE LINE OF lt_rn1po_call.
*        l_plnoe        TYPE orgid.
* CDuerr, MED-30034 - Begin
  DATA: l_plnoe        TYPE orgid.
* CDuerr, MED-30034 - End

* Initialisierung
  CLEAR: p_rc, p_refresh, l_movement.

*  PERFORM get_pln_ou CHANGING l_plnoe. "Grill, ID-18594

* CDuerr, MED-30034 - Begin
  GET PARAMETER ID 'WOE' FIELD l_plnoe.
  IF l_plnoe IS INITIAL.
    DESCRIBE TABLE gr_treat_ou.
    IF sy-tfill = 0.
      CLEAR l_plnoe.
    ENDIF.
    IF sy-tfill = 1.
      READ TABLE gr_treat_ou INDEX 1.
      l_plnoe = gr_treat_ou-low.
    ENDIF.
  ENDIF.
* CDuerr, MED-30034 - End

* Check ob keine Patienten markiert wurden
  READ TABLE pt_movements INTO l_movement INDEX 1.
  IF sy-subrc NE 0.
*   Fehlermeldung ausgeben -> mind. 1 Patient muss markiert werden
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF' '759' space space space space
                                 space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO pt_messages.
    p_rc = 1.
    p_refresh = 0.
    EXIT.
  ENDIF.

* ID 9263: Patientenorganizer mit Vitalparameter-Kurve anzeigen
  IF p_fcode = 'VPPO'.
    l_timeline = on.
  ELSE.
    l_timeline = off.
  ENDIF.

* ID 10186: Patientenorganizer mit Ambulanzkarte anzeigen
  IF p_fcode = 'AMPO'.
    l_outpmap = on.
  ELSE.
    l_outpmap = off.
  ENDIF.

* begin Gratzl MED-41542 16.07.2010
  IF p_fcode = 'N1NRSNOTE'.
    l_nrsnote = on.
  ELSE.
    l_nrsnote = off.
  ENDIF.
* end Gratzl MED-41542 16.07.2010

* begin Gratzl MED-41919 13.08.2010
  IF p_fcode = 'N2IPPDNOTE'.
    l_ippdnote = on.
  ELSE.
    l_ippdnote = off.
  ENDIF.
* end Gratzl MED-41919 13.08.2010

  LOOP AT pt_movements INTO l_movement.
    IF l_movement-patnr IS INITIAL.
      IF p_fcode <> 'PORG'.
*     Fehlermeldung ausgeben -> mind. 1 Patient muss markiert werden
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '759' space space space space
                                      space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
      ENDIF.
    ENDIF.
    READ TABLE lt_rn1po_call TRANSPORTING NO FIELDS
      WITH KEY patnr = l_movement-patnr
               papid = l_movement-papid.
    IF sy-subrc <> 0.
      MOVE-CORRESPONDING l_movement TO l_rn1po_call.        "#EC ENHOK
      l_rn1po_call-lfdbew = l_movement-lfdnr.
      l_rn1po_call-mandt = sy-mandt.
      l_rn1po_call-uname = sy-uname.
      l_rn1po_call-repid = sy-repid.
*    l_rn1po_call-viewid =       "keine Variable VIEWID gefunden
      INSERT l_rn1po_call INTO TABLE lt_rn1po_call.
    ENDIF.
  ENDLOOP.

* don't sort patients (ID 13826)
** Tabelle nach Patient sortieren
*  SORT lt_rn1po_call BY mandt einri patnr.
*  CLEAR l_rn1po_call.
*  LOOP AT lt_rn1po_call INTO l_rn1po_call.
*    IF NOT l_rn1po_call-patnr = l_patnr.
*      l_patnr = l_rn1po_call-patnr.
*    ELSE.
**    Fehlermeldung -> Patienten nur 1 mal auswählen
*      PERFORM build_bapiret2(sapmn1pa)
*              USING 'E' 'N1AR' '009' space space space space
*                                   space space space
*              CHANGING l_wa_msg.
*      APPEND l_wa_msg TO pt_messages.
*      p_rc = 1.
*      p_refresh = 0.
*      EXIT.
*    ENDIF.
*  ENDLOOP.

  IF NOT p_rc = 1.
    IF NOT lt_rn1po_call[] IS INITIAL.
*     start fullscreen not inplace (ANDERL N./KASSER W. 23.07.2001)
      CALL FUNCTION 'ISHMED_DISPLAY_PATDATA'
        EXPORTING
          i_skip         = 'X'
          i_timeline     = l_timeline                       " ID 9263
          i_outpmap      = l_outpmap                        " ID 10186
          i_plnoe        = l_plnoe
          i_nrsnote      = l_nrsnote                        "Med-41542
          i_ippdnote     = l_ippdnote                       "Med-41919
        TABLES
          t_rn1po_call   = lt_rn1po_call
        CHANGING
          cr_environment = pr_environment.                  " ID 14636
      p_rc = 0.
      p_refresh = 1.
    ENDIF.
  ENDIF.

ENDFORM.                               " call_patient_history

*&---------------------------------------------------------------------*
*&      Form  call_patient_profile
*&---------------------------------------------------------------------*
*       Patientenhistorie
*----------------------------------------------------------------------*
*      --> PT_MESSAGES   Meldungen
*      --> PT_MOVEMENTS  Bewegung
*      --> P_VIEWTYPE    (001/002/003)
*      <-- P_RC          Returncode (0=OK, 1=Error, 2=Cancel)
*      <-- P_REFRESH     Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_patient_profile TABLES   pt_messages    STRUCTURE bapiret2
                          USING    pt_movements   TYPE
                                          ishmed_t_care_unit_list_head
                                   p_viewtype LIKE nwview-viewtype
                          CHANGING p_rc           LIKE sy-subrc
                                   p_refresh      LIKE n1fld-refresh.

  DATA: l_wa_msg       LIKE bapiret2.

  DATA: l_movement    TYPE rnwp_care_unit_list_head,
        l_rn1ipc_call TYPE rn1ipc_call,
        lx_ipc_call   TYPE REF TO cx_ishmed_ipc_call.
*    Begin MED-55753 Tako Peter 21.05.2014
  DATA lt_patlist      TYPE STANDARD TABLE OF rnpatlist.
  DATA ls_patlist      TYPE rnpatlist.
  DATA ls_nfal         TYPE nfal.
  DATA ls_nbew         TYPE nbew.
  DATA lt_nfal         TYPE STANDARD TABLE OF nfal.
  DATA l_fall_lines    TYPE i.
  DATA l_fcode         TYPE string.
  DATA lr_exception    TYPE REF TO cx_root.                 "MED-63885
  DATA lr_if_t100      TYPE REF TO if_t100_message.         "MED-63885

* Initialisierung
  CLEAR: p_rc, p_refresh, l_movement.

* Check viewtype
  IF p_viewtype NOT BETWEEN '001' AND '003'.
    RETURN.
  ENDIF.

* Check ob keine Patienten markiert wurden
  READ TABLE pt_movements INTO l_movement INDEX 1.
  IF sy-subrc NE 0.
*   Fehlermeldung ausgeben -> mind. 1 Patient muss markiert werden
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF' '759' space space space space
                                 space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO pt_messages.
    p_rc = 1.
    p_refresh = 0.
    EXIT.
  ENDIF.

* Vorläufige Patienten
  IF l_movement-patnr IS INITIAL OR l_movement-falnr IS INITIAL.
*    Begin MED-55753 Tako Peter 21.05.2014
    CALL FUNCTION 'ISHMED_SEARCH_PATIENT_LIST'
      EXPORTING
        i_einri     = l_movement-einri
        i_show_list = abap_true
        i_no_patorg = abap_true
      TABLES
        et_patlist  = lt_patlist.

    DELETE lt_patlist WHERE patnr IS INITIAL AND papid IS INITIAL.
    READ TABLE lt_patlist INTO ls_patlist INDEX 1.

    l_movement-patnr = ls_patlist-patnr.

    IF l_movement-falnr IS INITIAL.

      SELECT * FROM nfal INTO TABLE lt_nfal
        WHERE einri = l_movement-einri
        AND   patnr = l_movement-patnr.

      l_fall_lines = lines( lt_nfal ).

      IF l_fall_lines > 1.
        CALL FUNCTION 'ISHMED_FALL_LIST'
          EXPORTING
            i_einri     = l_movement-einri
            i_patnr     = l_movement-patnr
            i_new_bew   = abap_false
            i_chg_bew   = abap_false
            i_sel_nbew  = abap_false
          IMPORTING
            e_fcode     = l_fcode
            e_nfal      = ls_nfal
            e_nbew      = ls_nbew
          EXCEPTIONS
            other_error = 1
            read_error  = 2
            OTHERS      = 3.

        IF sy-subrc <> 0 OR ls_nfal-falnr IS INITIAL.
*   Fehlermeldung ausgeben -> mind. 1 fall muss markiert werden
          PERFORM build_bapiret2(sapmn1pa)
                      USING 'E' 'N1BASE' '167' space space space space
                                           space space space
                      CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          p_refresh = 0.
          EXIT.
        ENDIF.

        IF ls_nfal-falnr IS NOT INITIAL.
          l_movement-falnr = ls_nfal-falnr.
        ENDIF.

        IF ls_nbew IS NOT INITIAL.
          l_movement-lfdnr = ls_nbew-lfdnr.
        ENDIF.

*       CASE l_fcode.
*         WHEN 'CAN' OR 'END'.
*           EXIT.
*       WHEN OTHERS.
*       ENDCASE.
      ELSEIF l_fall_lines = 1. "MED-56444, CM, 01.07.2014
        READ TABLE lt_nfal INTO ls_nfal INDEX 1.
        l_movement-falnr = ls_nfal-falnr.
      ELSE. "MED-56444, CM, 01.07.2014
        PERFORM build_bapiret2(sapmn1pa)
                    USING 'E' 'N1BASE' '169' l_movement-patnr space space space
                                         space space space
                    CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
        p_rc = 1.
        p_refresh = 0.
        EXIT.
      ENDIF.
    ENDIF.
    IF l_movement-patnr IS INITIAL.
*   Fehlermeldung ausgeben -> mind. 1 Patient muss markiert werden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '759' space space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

*  LOOP AT pt_movements INTO l_movement.
  MOVE-CORRESPONDING l_movement TO l_rn1ipc_call.           "#EC ENHOK
  l_rn1ipc_call-lfdbew = l_movement-lfdnr.
*  ENDLOOP.

  GET PARAMETER ID 'N1_PROFESSION_GROUP' FIELD l_rn1ipc_call-prof_group.

  IF NOT p_rc = 1.
    IF NOT l_rn1ipc_call IS INITIAL.
*     start patient profile in NWBC
      TRY.
          cl_ishmed_ipc_call=>navigate_from_nwp1(
              is_ipc_call      = l_rn1ipc_call ).

        CATCH cx_ishmed_ipc_call INTO lx_ipc_call.
          lr_exception = lx_ipc_call.                       "MED-63885
          WHILE lr_exception IS BOUND.                      "MED-63885
            TRY.                                            "MED-63885
                lr_if_t100 ?= lr_exception.                 "MED-63885
                "Begin MED-54448
          CALL FUNCTION 'ISH_BAPI_FILL_RETURN_PARAM'
            EXPORTING
              msgty  = 'S'
*                   msgid  = lx_ipc_call->if_t100_message~t100key-msgid     "REM MED-63885
*                   msgno  = lx_ipc_call->if_t100_message~t100key-msgno     "REM MED-63885
                    msgid  = lr_if_t100->t100key-msgid                      "MED-63885
                    msgno  = lr_if_t100->t100key-msgno                      "MED-63885
            IMPORTING
              return = l_wa_msg.

          APPEND l_wa_msg TO pt_messages.
              CATCH cx_root.                                "MED-63885
            ENDTRY.                                         "MED-63885
            lr_exception = lr_exception->previous.          "MED-63885
          ENDWHILE.                                         "MED-63885
          p_rc = 1.
          p_refresh = 0.
          RETURN.
          "End MED-54448
      ENDTRY.

      p_rc = 0.
      p_refresh = 1.
    ENDIF.
  ENDIF.

ENDFORM.                               " call_patient_profile

*&---------------------------------------------------------------------*
*&      Form  call_ish_form_select
*&---------------------------------------------------------------------*
*       asynchroner Aufruf Formulardruck (ANDERL N. 03.06.2002 ID 9720)
*       ACHTUNG: externe Aufrufer!
*       Klasse   CL_ISHMED_WPV007_FUNCTIONS + CL_ISHMED_FUNCTIONS
*       Methode  CALL_PRINT_FORM  aufgerufen!
*----------------------------------------------------------------------*
FORM call_ish_form_select TABLES   pt_nbew     STRUCTURE nbew
                                   pt_nfal     STRUCTURE nfal
                                   pt_messages STRUCTURE bapiret2
                          USING    p_einri     LIKE tn01-einri
                                   p_std_print TYPE ish_on_off
                                   p_std_event TYPE rnevt-event
                          CHANGING p_rc        LIKE sy-subrc.

  DATA: l_wa_msg          TYPE bapiret2.
  DATA: terminal          TYPE tnf07-terminal.

** Asynchroner Aufruf Formuardruck
*  DATA: end_of_print_task  LIKE false    VALUE false,
*        subrc_print_task   LIKE sy-subrc VALUE 0,
*        msg_print_task(80) TYPE c        VALUE space.  "#EC NEEDED

  CALL FUNCTION 'ISH_FORM_TH_USER_INFO'
    IMPORTING
      terminal = terminal
    EXCEPTIONS
      OTHERS   = 0.

*BEGIN MED-58185 Oana B 06.01.2015
** MED-38568 (check if maximum number of sessions is reached)
*  IF cl_ish_utl_base=>max_sessions_check( ) = on.
*    MESSAGE i027(14).
*    EXIT.
*  ENDIF.
*
*  end_of_print_task = false.
*  subrc_print_task = 0.
*  CALL FUNCTION 'ISH_FORM_SELECT'
*    STARTING NEW TASK 'PRINT'
*    PERFORMING end_form_select ON END OF TASK
*    EXPORTING
*      ss_applk              = 'N'
*      ss_einri              = p_einri
*      ss_event              = p_std_event
*      ss_st_print           = p_std_print
*      ss_terminal           = terminal
*    TABLES
*      ss_nbew               = pt_nbew
*      ss_nfal               = pt_nfal
*    EXCEPTIONS
*      error_occured         = 01
*      communication_failure = 8  MESSAGE msg_print_task
*      system_failure        = 12  MESSAGE msg_print_task
*    .                                                       "#EC *
*  WAIT UNTIL end_of_print_task EQ true.

*  CASE subrc_print_task.
*    WHEN 0.
***     Druckauftrag ausgeführt
**      PERFORM build_bapiret2 IN PROGRAM sapmn1pa
**              USING 'I' 'N1' '561' space space space space
**                                   space space space
**              CHANGING l_wa_msg.
**      APPEND l_wa_msg TO pt_messages.
**      EXIT.
*    WHEN OTHERS.
*      PERFORM build_bapiret2 IN PROGRAM sapmn1pa
*              USING 'S' sy-msgid sy-msgno sy-msgv1 sy-msgv2
*                                 sy-msgv3 sy-msgv4
*                                 space space space
*              CHANGING l_wa_msg.
*      APPEND l_wa_msg TO pt_messages.
*      p_rc = 1.
*      EXIT.
*  ENDCASE.

  CALL FUNCTION 'ISH_FORM_SELECT_IN_NEW_TASK'
    EXPORTING
      ss_applk              = 'N'
      ss_einri              = p_einri
      ss_event              = p_std_event
      ss_st_print           = p_std_print
      ss_terminal           = terminal
    TABLES
      ss_nbew               = pt_nbew
      ss_nfal               = pt_nfal
    EXCEPTIONS
          OTHERS        = 1.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

*END MED-58185 Oana B 06.01.2015

ENDFORM.                               " call_ish_form_select

*&---------------------------------------------------------------------*
*&      Form  end_form_select
*&---------------------------------------------------------------------*
*       Ende asynchroner Aufruf Formulardruck
*----------------------------------------------------------------------*
FORM end_form_select USING taskname TYPE any.               "#EC *

  RECEIVE RESULTS FROM FUNCTION 'ISH_FORM_SELECT'
          EXCEPTIONS error_occured         = 1
                     communication_failure = 8  MESSAGE msg_print_task
                     system_failure        = 12 MESSAGE msg_print_task.
  subrc_print_task  = sy-subrc.
  end_of_print_task = true.

ENDFORM.                    "end_form_select

*----------------------------------------------------------------------*
*       'Termin suchen für Wiederholbesuch' aufrufen
*       search follow-up-visit-app
*       (Garschall 2003-12-10 / ID 13144)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      -->P_PLANOE        Planende OE
*      -->P_WPLACEID      Workplace ID
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_wiederbest_suchen
         TABLES   pt_messages       STRUCTURE bapiret2
         USING    p_lt_movements    TYPE ishmed_t_care_unit_list_head
                  VALUE(p_planoe)   TYPE norg-orgid
                  pr_environment    TYPE REF TO cl_ish_environment
         CHANGING p_rc              LIKE sy-subrc
                  p_refresh         LIKE n1fld-refresh.

* Definitions
  DATA: l_oepf   TYPE nbew-orgpf,
        l_wa_msg TYPE bapiret2,
        l_rc     TYPE sy-subrc.

* local tables
  DATA: lt_workpool TYPE ishmed_t_pg_workpool,
        lt_messages TYPE ishmed_t_bapiret2.

* local references
  DATA: lr_errorhandler TYPE REF TO cl_ishmed_errorhandling,
        lr_plan_func    TYPE REF TO cl_ishmed_prc_planning_func,
        lr_plan         TYPE REF TO cl_ish_prc_planning_func.

* Initialize
  CLEAR: p_rc, p_refresh, l_oepf, l_wa_msg.
  CLEAR: lt_workpool[].

  CREATE OBJECT lr_errorhandler.

* get planning orgunit (JG 02.02.04)
  l_oepf = p_planoe.
  PERFORM get_pln_ou CHANGING l_oepf.

* get objects (nothing, patients, ..)
  PERFORM get_objs_for_wiedb TABLES   pt_messages
                             USING    p_lt_movements
                                      pr_environment
                             CHANGING p_rc
                                      p_refresh
                                      lt_workpool.
  CHECK p_rc = 0.

  CALL METHOD cl_ish_fac_prc_planning_func=>create
    IMPORTING
      er_instance     = lr_plan
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.
  CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
    lr_plan_func ?= lr_plan.
  ENDCATCH.
  IF l_rc <> 0.
    p_rc = 1.
    p_refresh = 0.
    CALL METHOD lr_errorhandler->get_messages
      IMPORTING
        t_messages = lt_messages.
    DESCRIBE TABLE lt_messages.
    IF sy-tfill > 0.
      APPEND LINES OF lt_messages TO pt_messages.
    ELSE.
*     Fehler in der Bearbeitung
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' l_rc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
    ENDIF.
    EXIT.
  ENDIF.

* ID 16528: set planning OU
  CALL METHOD lr_plan_func->set_planning_ou
    EXPORTING
      i_planoe = l_oepf.

  CALL METHOD lr_plan_func->planning_with_search
    EXPORTING
      i_with_dialog   = on
      i_einri         = g_institution
*     i_planoe        = l_oepf                       " REM ID 16528
      i_stdat         = sy-datum
      i_caller        = sy-repid
      i_usage         = co_usage_follow_up_visit
      i_save          = on
      it_workpool     = lt_workpool
      ir_environment  = pr_environment
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

  CASE l_rc.
    WHEN 0.
      p_refresh = 1.
    WHEN 2.                       " Cancel
      p_rc = 2.
      p_refresh = 0.
    WHEN OTHERS.                  " Error
      p_rc = 1.
      p_refresh = 0.
      CALL METHOD lr_errorhandler->get_messages
        IMPORTING
          t_messages = lt_messages.
      DESCRIBE TABLE lt_messages.
      IF sy-tfill > 0.
        APPEND LINES OF lt_messages TO pt_messages.
      ELSE.
*       Fehler in der Bearbeitung
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '139' l_rc space space space
                                     space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_messages.
      ENDIF.
  ENDCASE.

ENDFORM.                    " call_wiederbest_suchen
*&---------------------------------------------------------------------*
*&      Form  get_objs_for_wiedb "get objects for follow up visits
*&---------------------------------------------------------------------*
*       (Garschall 2004-01-30)
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->P_LT_MOVEMENTS  Bewegungen
*      -->PR_ENVIRONMENT  Environment
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*      <--P_LT_WORKPOOL   Workpool Daten
*----------------------------------------------------------------------*
FORM get_objs_for_wiedb
          TABLES   pt_messages    STRUCTURE bapiret2
          USING    p_lt_movements TYPE ishmed_t_care_unit_list_head
                   pr_environment TYPE REF TO cl_ish_environment
          CHANGING p_rc           LIKE sy-subrc
                   p_refresh      LIKE n1fld-refresh
                   p_lt_workpool  TYPE ishmed_t_pg_workpool.

  DATA: l_wa_msg        LIKE bapiret2.
  DATA: lt_messages     TYPE ishmed_t_bapiret2.
  DATA: ls_movement LIKE LINE OF p_lt_movements,
        ls_workpool LIKE LINE OF p_lt_workpool.
  DATA: ls_bew   LIKE nbew,
        ls_fal   LIKE nfal,
        l_errfal LIKE sy-subrc,     "Fehlerprüfung Fall/Bewegung
        l_rc     LIKE sy-subrc,
        l_count  TYPE i.
  DATA: lr_app          TYPE REF TO cl_ish_appointment,
        lr_outpat_vis   TYPE REF TO cl_ishmed_outpat_visit,
        lr_inpat_vis    TYPE REF TO cl_ishmed_inpat_admis,
        lr_none_oo_nbew TYPE REF TO cl_ishmed_none_oo_nbew,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.

* Initialize
  CLEAR: p_rc, p_refresh, ls_movement, l_errfal, l_rc, l_count.

* p_lt_movements has movements and stat. admission
* in p_lt_movements sind Bewegungen und stat. Aufnahmetermin
  LOOP AT p_lt_movements INTO ls_movement.
    IF NOT ls_movement-tmnid IS INITIAL.
      CALL METHOD cl_ish_appointment=>load
        EXPORTING
          i_mandt        = sy-mandt
          i_einri        = ls_movement-einri
          i_tmnid        = ls_movement-tmnid
          i_environment  = pr_environment
        IMPORTING
          e_rc           = l_rc
          e_instance     = lr_app
        CHANGING
          c_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
*       errorhandling after loop
        EXIT.
      ENDIF.

      ls_workpool-object = lr_app.
      ADD 1 TO l_count.
      ls_workpool-sort = l_count.
      APPEND ls_workpool TO p_lt_workpool.
      CLEAR ls_workpool.
    ELSE.
      IF NOT ls_movement-lfdnr IS INITIAL.
        PERFORM get_fall_bewegung USING   ls_movement
                                CHANGING  ls_fal
                                          ls_bew
                                          l_errfal.
        CASE l_errfal.
          WHEN 1.
            PERFORM build_bapiret2(sapmn1pa)
               USING 'E' 'NF' '051' ls_movement-falnr space space space
                                         space space space
                    CHANGING l_wa_msg.
            APPEND l_wa_msg TO pt_messages.
            p_rc = 1.
            p_refresh = 0.
            EXIT.
          WHEN 2.
            PERFORM build_bapiret2(sapmn1pa)
                    USING 'E' 'NF' '076' space space space space
                                         space space space
                    CHANGING l_wa_msg.
            APPEND l_wa_msg TO pt_messages.
            p_rc = 1.
            p_refresh = 0.
            EXIT.
          WHEN 0.
*           case/movement is ok
*           Fall/Bewegung ist OK.
            IF  NOT ls_movement-falnr IS INITIAL AND
                               NOT ls_movement-lfdnr IS INITIAL .
              IF ls_bew-bewty = '4' AND
                      ( NOT ls_movement-falnr IS INITIAL AND
                        NOT ls_movement-lfdnr IS INITIAL ).

                CALL METHOD cl_ish_fac_outpat_visit=>load
                  EXPORTING
                    i_einri        = ls_movement-einri
                    i_falnr        = ls_movement-falnr
                    i_lfdnr        = ls_movement-lfdnr
                    i_environment  = pr_environment
                  IMPORTING
                    e_instance     = lr_outpat_vis
                    e_rc           = l_rc
                  CHANGING
                    c_errorhandler = lr_errorhandler.
                IF l_rc <> 0.
*                 errorhandling after loop
                  EXIT.
                ENDIF.
                ls_workpool-object = lr_outpat_vis.
                ADD 1 TO l_count.
                ls_workpool-sort = l_count.
                APPEND ls_workpool TO p_lt_workpool.
                CLEAR ls_workpool.
              ELSEIF ls_bew-bewty = '1'.
                CALL METHOD cl_ish_fac_inpat_admis=>load
                  EXPORTING
                    i_einri        = ls_movement-einri
                    i_falnr        = ls_movement-falnr
                    i_lfdnr        = ls_movement-lfdnr
                    i_environment  = pr_environment
                  IMPORTING
                    e_instance     = lr_inpat_vis
                    e_rc           = l_rc
                  CHANGING
                    c_errorhandler = lr_errorhandler.
                IF l_rc <> 0.
*                  errorhanlding after loop
                  EXIT.
                ENDIF.
                ls_workpool-object = lr_inpat_vis.
                ADD 1 TO l_count.
                ls_workpool-sort = l_count.
                APPEND ls_workpool TO p_lt_workpool.
                CLEAR ls_workpool.
              ELSE. "wether 1 nor 4
                CALL METHOD cl_ishmed_none_oo_nbew=>load
                  EXPORTING
                    i_einri        = ls_movement-einri
                    i_falnr        = ls_movement-falnr
                    i_lfdnr        = ls_movement-lfdnr
                  IMPORTING
                    e_instance     = lr_none_oo_nbew
                    e_rc           = l_rc
                  CHANGING
                    c_errorhandler = lr_errorhandler.
                IF l_rc <> 0.
*                  errorhandling after loop
                  EXIT.
                ENDIF.
                ls_workpool-none_oo_data = lr_none_oo_nbew.
                ADD 1 TO l_count.
                ls_workpool-sort = l_count.
                APPEND ls_workpool TO p_lt_workpool.
                CLEAR ls_workpool.
              ENDIF.
            ELSE.
*             for the appointment search there were not taken
*             possible entries
*             Für die Terminsuche wurden keine gültigen Einträge
*             ausgewählt.
              PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'N1APMG_MED' '011' space space space space
                                   space space space
              CHANGING l_wa_msg.
              APPEND l_wa_msg TO pt_messages.
              p_rc = 1.
              EXIT.
            ENDIF.
        ENDCASE.
      ENDIF.
    ENDIF.
  ENDLOOP.

  l_count = 0.

  IF l_rc <> 0.
    p_refresh = 0.
    CALL METHOD lr_errorhandler->get_messages
      IMPORTING
        t_messages = lt_messages.
    DESCRIBE TABLE lt_messages.
    IF sy-tfill > 0.
      APPEND LINES OF lt_messages TO pt_messages.
    ELSE.
*     Fehler in der Bearbeitung
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' l_rc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
    ENDIF.
    p_rc = 1.
    p_refresh = 0.
  ENDIF.

  IF p_rc EQ 1.
    EXIT.
  ENDIF.

ENDFORM.                    " get_objs_for_wiedb
*&---------------------------------------------------------------------*
*&      Form  CALL_TEMPTT_DISPLAY
*&---------------------------------------------------------------------*
*       Temporäre Behandlungsaufträge anzeigen
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Meldungen
*      -->PT_MOVEMENTS    Bewegungen
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Aktualisieren (0=Nichts, 1=Zeilen, 2=Alles)
*----------------------------------------------------------------------*
FORM call_temptt_display
               TABLES   pt_messages  STRUCTURE bapiret2     "#EC NEEDED
               USING    pt_movements TYPE ishmed_t_care_unit_list_head
               CHANGING p_rc         LIKE sy-subrc
                        p_refresh    LIKE n1fld-refresh.

* Datendefinitionen
  DATA: ls_movement TYPE rnwp_care_unit_list_head,
        lr_einri    TYPE TABLE OF rn2range_einri,
        ls_einri    LIKE LINE OF lr_einri,
        lr_patnr    TYPE TABLE OF rnrangepatnr,
        ls_patnr    LIKE LINE OF lr_patnr,
        lr_falnr    TYPE TABLE OF rnrangefalnr,
        ls_falnr    LIKE LINE OF lr_falnr.

  CLEAR:   p_rc, p_refresh, ls_movement.
  REFRESH: lr_einri, lr_patnr, lr_falnr.

  LOOP AT pt_movements INTO ls_movement.
    CLEAR ls_einri.
    ls_einri-sign   = 'I'.
    ls_einri-option = 'EQ'.
    ls_einri-low    = ls_movement-einri.
    APPEND ls_einri TO lr_einri.
    IF NOT ls_movement-patnr IS INITIAL.
      CLEAR ls_patnr.
      ls_patnr-sign   = 'I'.
      ls_patnr-option = 'EQ'.
      ls_patnr-low    = ls_movement-patnr.
      APPEND ls_patnr TO lr_patnr.
    ENDIF.
    IF NOT ls_movement-falnr IS INITIAL.
      CLEAR ls_falnr.
      ls_falnr-sign   = 'I'.
      ls_falnr-option = 'EQ'.
      ls_falnr-low    = ls_movement-falnr.
      APPEND ls_falnr TO lr_falnr.
    ENDIF.
  ENDLOOP.

  SORT lr_einri BY low.
  SORT lr_patnr BY low.
  SORT lr_falnr BY low.

  DELETE ADJACENT DUPLICATES FROM lr_einri COMPARING low.
  DELETE ADJACENT DUPLICATES FROM lr_patnr COMPARING low.
  DELETE ADJACENT DUPLICATES FROM lr_falnr COMPARING low.

  CALL FUNCTION 'ISH_N2_TEMPTT_DISPLAY'
    TABLES
      filter_einri = lr_einri
      filter_patnr = lr_patnr
      filter_falnr = lr_falnr
    EXCEPTIONS
      no_temptc    = 1
      error        = 2
      OTHERS       = 3.
  CASE sy-subrc.
    WHEN 0.
*     OK
      p_rc = 0.
      p_refresh = 0.
      EXIT.
    WHEN 1.
*     no data found
      p_rc = 0.
      p_refresh = 0.
      EXIT.
    WHEN OTHERS.
*     error
      p_rc = 1.
      p_refresh = 0.
      EXIT.
  ENDCASE.

ENDFORM.                               " CALL_TEMPTT_DISPLAY
*&---------------------------------------------------------------------*
*&      Form  get_pln_ou
*&---------------------------------------------------------------------*
*       select planning org.unit
*----------------------------------------------------------------------*
FORM get_pln_ou  CHANGING p_pln_ou      TYPE norg-orgid.

  DATA: l_pln_ou      TYPE norg-orgid,
        lt_f4_fcat    TYPE lvc_t_fcat,
        ls_f4_fcat    TYPE lvc_s_fcat,
        l_rc          TYPE sy-subrc,
        lt_orgid_mark TYPE TABLE OF norg,
        lt_orgid      TYPE TABLE OF norg,
        ls_orgid      TYPE norg,
        lt_oe         TYPE ishmed_t_orgid,
        ls_oe         LIKE LINE OF lt_oe.


  REFRESH: lt_orgid, lt_orgid_mark, lt_f4_fcat.

  GET PARAMETER ID 'WOE' FIELD l_pln_ou.

  IF l_pln_ou IS INITIAL.
    l_pln_ou = p_pln_ou.
  ENDIF.

  IF l_pln_ou IS INITIAL.

*   Es muss zumindest eine OE vorhanden sein
    DESCRIBE TABLE gr_treat_ou.
    IF sy-tfill = 0.
      CLEAR l_pln_ou.
      p_pln_ou = l_pln_ou.
      EXIT.
    ENDIF.
*   Genau 1 Eintrag - ohne Popup übernehmen
    IF sy-tfill = 1.
      READ TABLE gr_treat_ou INDEX 1.
      l_pln_ou = gr_treat_ou-low.
      p_pln_ou = l_pln_ou.
      EXIT.
    ENDIF.

*   Aufbauen der F4-Hilfe
    REFRESH lt_oe.
    LOOP AT gr_treat_ou.
      ls_oe-orgid = gr_treat_ou-low.
      APPEND ls_oe TO lt_oe.
    ENDLOOP.

    CALL METHOD cl_ish_dbr_org=>get_t_org_by_orgid
      EXPORTING
        it_orgid = lt_oe
      IMPORTING
        et_norg  = lt_orgid.

*   Feldkatalog
    ls_f4_fcat-fieldname = 'ORGID'.
    ls_f4_fcat-ref_field = 'ORGID'.
    ls_f4_fcat-ref_table = 'NORG'.
    ls_f4_fcat-coltext   = 'OE'(017).
    ls_f4_fcat-outputlen = 10.
    APPEND ls_f4_fcat TO lt_f4_fcat.

    ls_f4_fcat-fieldname = 'ORGNA'.
    ls_f4_fcat-ref_field = 'ORGNA'.
    ls_f4_fcat-ref_table = 'NORG'.
    ls_f4_fcat-coltext   = 'Bezeichnung'(018).
    ls_f4_fcat-outputlen = 30.
    APPEND ls_f4_fcat TO lt_f4_fcat.

    CALL FUNCTION 'ISHMED_F4_ALLG_ACTIVEX'
      EXPORTING
        it_f4tab          = lt_orgid
        it_fieldcat       = lt_f4_fcat
        i_title           = 'Auswahl Planende OE'(019)
      IMPORTING
        e_rc              = l_rc
        et_marked_entries = lt_orgid_mark.

    IF l_rc = 0.
      READ TABLE lt_orgid_mark INTO ls_orgid INDEX 1.
      l_pln_ou = ls_orgid-orgid.
      p_pln_ou = l_pln_ou.
    ELSE.
      CLEAR l_pln_ou.
      p_pln_ou = l_pln_ou.
    ENDIF.

  ELSE.

    p_pln_ou = l_pln_ou.

  ENDIF.

ENDFORM.                    " get_pln_ou
*&---------------------------------------------------------------------*
*&      Form  set_case_in_table_popup
*&---------------------------------------------------------------------*
*       ED, ID 20128: put outpatient cases in popup
*----------------------------------------------------------------------*
FORM set_case_in_table_popup  USING pt_fal     TYPE ishmed_t_nfal
                                    pt_fal_out TYPE ishmed_t_nfal
                                    p_exit     TYPE ish_on_off.

  DATA: ls_npat     TYPE npat,
        ls_nfal     TYPE nfal,
        ls_text     TYPE rn1f4,
        lt_text     TYPE ishmed_t_rn1f4,
        l_title(50) TYPE c,
        l_key       TYPE rn1f4-key,
        l_vcode     TYPE tndym-vcode,
        l_headline  TYPE rn1f4.

  REFRESH lt_text.
  p_exit = off.
  IF pt_fal_out IS NOT INITIAL.                            "note 993764
    LOOP AT pt_fal_out INTO ls_nfal.
      CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
        EXPORTING
          i_patnr = ls_nfal-patnr
        IMPORTING
          es_npat = ls_npat.
      CHECK ls_npat IS NOT INITIAL.
      ls_text-key = sy-tabix.
      ls_text-code = ls_npat-vname.
      ls_text-text = ls_npat-nname.
      ls_text-other = ls_nfal-falnr.
      APPEND ls_text TO lt_text.
    ENDLOOP.
  ENDIF.

  l_title = 'Funktion ist für ambulante Faelle nicht zulaessig.'(002).

  l_headline-code = 'Vorname'(003).
  l_headline-text = 'Nachname'(004).
  l_headline-other = 'Fallnummer'(005).

* no inpatient and no outpatient case(s)
  IF pt_fal_out[] IS INITIAL.
    EXIT.
* only outpatient case(s)
  ELSEIF pt_fal[] IS INITIAL.
    l_vcode = 'DIS'.
* inpatient and outpatient case(s)
  ELSE.
    l_vcode = 'UPD'.
  ENDIF.

  CALL FUNCTION 'ISHMED_F4_ALLG'
    EXPORTING
      i_disp_other = 'X'
      i_len_code   = '30'
      i_len_text   = '30'
      i_title      = l_title
      i_vcode      = l_vcode
      i_activex    = 'X'
      i_headline   = l_headline
    IMPORTING
      e_key        = l_key
    TABLES
      t_f4tab      = lt_text.
  IF l_key IS INITIAL.
    p_exit = on.
    EXIT.
  ENDIF.

ENDFORM.                    " set_case_in_table_popup
*&---------------------------------------------------------------------*
*&      Form  call_add_nrs_service
*&---------------------------------------------------------------------*
*       call service adding
*----------------------------------------------------------------------*
FORM call_add_nrs_service
                 TABLES   pt_messages    TYPE bapiret2_t
                 USING    pt_movements   TYPE ishmed_t_care_unit_list_head
                          p_n1pmn        TYPE n1parwert
                          p_tcode        TYPE sy-tcode
                 CHANGING p_rc           TYPE ish_method_rc
                          p_refresh      TYPE n1fld-refresh.

  DATA: ls_message            LIKE LINE OF pt_messages,
        lt_messages_hlp       TYPE ishmed_t_bapiret2,
        l_rc                  TYPE ish_method_rc,
        ls_mov                LIKE LINE OF pt_movements,
        ls_msg                TYPE bapiret2,
        lr_errorhandler       TYPE REF TO cl_ishmed_errorhandling,
        lx_ish_static_handler TYPE REF TO cx_ish_static_handler,
        l_mode                TYPE n1srv_creationmode.

  p_rc = 0.
  p_refresh = 1.

  CASE p_tcode.
    WHEN 'PHL'.
      l_mode = cl_ishmed_srv_type=>co_creationmode_planned.
    WHEN 'DIS'.
      l_mode = cl_ishmed_srv_type=>co_creationmode_planned.
    WHEN 'PHN'.
      l_mode = cl_ishmed_srv_type=>co_creationmode_actual.
  ENDCASE.

  DESCRIBE TABLE pt_movements.
  IF sy-tfill <> 1.
    PERFORM build_bapiret2(sapmn1pa)
      USING 'E' 'NF1' '438' space space space space
                                  space space space
      CHANGING ls_msg.
    APPEND ls_msg TO pt_messages.
    p_rc = 1.
    EXIT.
  ENDIF.

  CLEAR ls_mov.
  READ TABLE pt_movements INTO ls_mov INDEX 1.
  IF sy-subrc <> 0.
    ls_mov-einri = g_institution.
  ENDIF.

  TRY.
      CALL METHOD cl_ishmed_nrs_ga_services=>execute_by_data
        EXPORTING
          i_einri        = ls_mov-einri
          i_patnr        = ls_mov-patnr
          i_orgfa        = ls_mov-orgfa
          i_orgpf        = ls_mov-orgpf
          i_falnr        = ls_mov-falnr           "MED-46984 C. Honeder
          i_creationmode = l_mode
          i_vcode        = if_ish_gui_view=>co_vcode_update.
    CATCH cx_ish_static_handler INTO lx_ish_static_handler.
      CALL METHOD lx_ish_static_handler->get_errorhandler
        IMPORTING
          er_errorhandler = lr_errorhandler.
      IF lr_errorhandler IS BOUND.
        CALL METHOD lr_errorhandler->get_messages
          IMPORTING
            t_messages = lt_messages_hlp.
        pt_messages[] = lt_messages_hlp[].
      ENDIF.
      p_rc = 1.
      EXIT.
  ENDTRY.

ENDFORM.                    " call_add_nrs_service
*&---------------------------------------------------------------------*
*&      Form  call_nrs_plan
*&---------------------------------------------------------------------*
*       call nursing plan
*----------------------------------------------------------------------*
FORM call_nrs_plan
                 TABLES   pt_messages    TYPE bapiret2_t
                 USING    pt_movements   TYPE ishmed_t_care_unit_list_head
                          p_n1pmn        TYPE n1parwert
                          p_what         TYPE c
                 CHANGING p_rc           TYPE ish_method_rc
                          p_refresh      TYPE n1fld-refresh.

  DATA: ls_message            LIKE LINE OF pt_messages,
        lt_messages_hlp       TYPE ishmed_t_bapiret2,
        l_rc                  TYPE ish_method_rc,
        ls_mov                LIKE LINE OF pt_movements,
        ls_nfal               TYPE nfal,
        ls_msg                TYPE bapiret2,
        lr_errorhandler       TYPE REF TO cl_ishmed_errorhandling,
        lx_ish_static_handler TYPE REF TO cx_ish_static_handler.
  DATA lt_patlist             TYPE TABLE OF rnpatlist.      "MED-42695
  DATA ls_patlist             TYPE rnpatlist.               "MED-42695

  p_rc = 0.
  p_refresh = 1.

  DESCRIBE TABLE pt_movements.
  IF sy-tfill <> 1.
    PERFORM build_bapiret2(sapmn1pa)
      USING 'E' 'NF1' '438' space space space space
                                  space space space
      CHANGING ls_msg.
    APPEND ls_msg TO pt_messages.
    p_rc = 1.
    EXIT.
  ENDIF.

  CLEAR ls_mov.
  READ TABLE pt_movements INTO ls_mov INDEX 1.
  IF sy-subrc <> 0.
    ls_mov-einri = g_institution.
  ENDIF.

  IF p_what EQ 'S'.
    IF ls_mov-falnr IS INITIAL.
* - - - - - BEGIN MED-42695 C. Honeder
      IF ls_mov-patnr IS INITIAL.
        CALL FUNCTION 'ISHMED_SEARCH_PATIENT_LIST'
          EXPORTING
            i_show_list = abap_true
            i_einri     = ls_mov-einri
            i_popup     = abap_true
            i_init      = abap_true
*           I_NO_PATORG = ' '
          TABLES
            et_patlist  = lt_patlist.
        CHECK lt_patlist IS NOT INITIAL.

        READ TABLE lt_patlist INDEX 1 INTO ls_patlist.
        ls_mov-patnr = ls_patlist-patnr.
        CHECK ls_mov-patnr IS NOT INITIAL.
      ENDIF.
* - - - - - END MED-42695 C. Honeder
      TRY.
          ls_nfal = cl_ishmed_srv_dbr_service=>determine_case_for_patient(
            i_einri = ls_mov-einri
            i_patnr = ls_mov-patnr ).
        CATCH cx_ish_static_handler INTO lx_ish_static_handler.
          CALL METHOD lx_ish_static_handler->get_errorhandler
            IMPORTING
              er_errorhandler = lr_errorhandler.
          IF lr_errorhandler IS BOUND.
            CALL METHOD lr_errorhandler->get_messages
              IMPORTING
                t_messages = lt_messages_hlp.
            pt_messages[] = lt_messages_hlp[].
          ENDIF.
          p_rc = 1.
          EXIT.
      ENDTRY.
      ls_mov-falnr = ls_nfal-falnr.
    ENDIF.
    CALL FUNCTION 'ISHMED_PFLEGEPLAN_UEBERSICHT'
      EXPORTING
        i_einri = ls_mov-einri
        i_orgid = ls_mov-orgpf
        i_falnr = ls_mov-falnr
        i_orgfa = ls_mov-orgfa        "MED-48643 M.Rebegea 11.10.2012
        i_patnr = ls_mov-patnr        "MED-49017 M.Rebegea 22.10.2012
      EXCEPTIONS
        OTHERS  = 0.
  ELSE.
    TRY.
        IF p_what EQ 'N'.
          cl_ishmed_nrs_plan_dialog_api=>execute_create_by_patnr(
              i_patnr             = ls_mov-patnr
              i_ctx_einri         = ls_mov-einri
              i_ctx_orgfa         = ls_mov-orgfa
              i_ctx_orgpf         = ls_mov-orgpf
              i_ctx_falnr         = ls_mov-falnr ).         "MED-46984
*             i_ctx_vma           =
*             i_plan_type         =
*             i_dws               = ABAP_TRUE
*             ir_startup_settings =
*             ir_layout           =
        ELSE.
          cl_ishmed_nrs_plan_dialog_api=>execute_by_patnr(
               i_patnr             = ls_mov-patnr
               i_ctx_einri         = ls_mov-einri
               i_ctx_orgfa         = ls_mov-orgfa
               i_ctx_orgpf         = ls_mov-orgpf
               i_ctx_falnr         = ls_mov-falnr ).        "MED-46984
*               i_ctx_vma           =
*               i_dws               = ABAP_TRUE
*               i_plan_type         =
*               i_allow_resume      = ABAP_TRUE
*               ir_startup_settings =
*               ir_layout           =
        ENDIF.


      CATCH cx_ish_static_handler INTO lx_ish_static_handler.
        CALL METHOD lx_ish_static_handler->get_errorhandler
          IMPORTING
            er_errorhandler = lr_errorhandler.
        IF lr_errorhandler IS BOUND.
          CALL METHOD lr_errorhandler->get_messages
            IMPORTING
              t_messages = lt_messages_hlp.
          pt_messages[] = lt_messages_hlp[].
        ENDIF.
        p_rc = 1.
        EXIT.
    ENDTRY.
  ENDIF.

ENDFORM.                    " call_nrs_plan

*&---------------------------------------------------------------------*
*&      Form  call_nrssrv_copy
*&---------------------------------------------------------------------*
*       call nurse service copy
*----------------------------------------------------------------------*
FORM call_nrssrv_copy
                 TABLES   pt_messages    TYPE bapiret2_t
                 USING    pt_movements   TYPE ishmed_t_care_unit_list_head
                          p_n1pmn        TYPE n1parwert
                 CHANGING p_rc           TYPE ish_method_rc
                          p_refresh      TYPE n1fld-refresh.

  DATA: ls_message            LIKE LINE OF pt_messages,
        lt_messages_hlp       TYPE ishmed_t_bapiret2,
        l_rc                  TYPE ish_method_rc,
        ls_mov                LIKE LINE OF pt_movements,
        ls_msg                TYPE bapiret2,
        lr_errorhandler       TYPE REF TO cl_ishmed_errorhandling,
        lx_ish_static_handler TYPE REF TO cx_ish_static_handler.

  p_rc = 0.
  p_refresh = 1.

  DESCRIBE TABLE pt_movements.
  IF sy-tfill <> 1.
    PERFORM build_bapiret2(sapmn1pa)
      USING 'E' 'NF1' '438' space space space space
                                  space space space
      CHANGING ls_msg.
    APPEND ls_msg TO pt_messages.
    p_rc = 1.
    EXIT.
  ENDIF.

  CLEAR ls_mov.
  READ TABLE pt_movements INTO ls_mov INDEX 1.
  IF sy-subrc <> 0.
    ls_mov-einri = g_institution.
  ENDIF.

  TRY.
      CALL METHOD cl_ishmed_srv_ga_copy_to=>execute_by_patnr
        EXPORTING
          i_einri  = ls_mov-einri
          i_patnr  = ls_mov-patnr
          ir_type  = cl_ishmed_srv_typemgr=>sget_type_by_id( cl_ishmed_srv_typemgr=>co_type_nrs )
          i_save   = abap_true
          i_commit = abap_true.
    CATCH cx_ish_static_handler INTO lx_ish_static_handler.
      CALL METHOD lx_ish_static_handler->get_errorhandler
        IMPORTING
          er_errorhandler = lr_errorhandler.
      IF lr_errorhandler IS BOUND.
        CALL METHOD lr_errorhandler->get_messages
          IMPORTING
            t_messages = lt_messages_hlp.
        pt_messages[] = lt_messages_hlp[].
      ENDIF.
      p_rc = 1.
      EXIT.
  ENDTRY.

ENDFORM.                    " call_nrssrv_copy

*&---------------------------------------------------------------------*
*       Nursing Plan - executed from the clinical workplace
*       for evaluation
*----------------------------------------------------------------------*
*      <--PT_MESSAGES     Messages
*      -->P_LT_MOVEMENTS  Movements
*      <--P_RC            Returncode (0=OK, 1=Error, 2=Cancel)
*      <--P_REFRESH       Refresh (0=no, 1=row, 2=all)
*----------------------------------------------------------------------*
FORM call_nrsplan_eval TABLES pt_messages STRUCTURE bapiret2
                       USING  p_lt_movements TYPE
                                             ishmed_t_care_unit_list_head
                              VALUE(p_what)  TYPE c
                       CHANGING p_rc         LIKE sy-subrc
                                p_refresh    LIKE n1fld-refresh.

  DATA: l_movement            LIKE LINE OF p_lt_movements,
        l_n1pmn               TYPE n1orgpar-n1parwert,
        ls_nrsph              TYPE n1nrsph,
        l_end_date            TYPE n1nrsph_end_date,
        lr_startup_settings   TYPE REF TO cl_ishmed_nrs_gass_plan,
        lt_messages           TYPE ishmed_t_bapiret2,
        ls_msg                TYPE bapiret2,
        lr_errorhandler       TYPE REF TO cl_ishmed_errorhandling,
        lx_ish_static_handler TYPE REF TO cx_ish_static_handler.

  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
    READ TABLE p_lt_movements INTO l_movement INDEX 1.
    CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
      EXPORTING
        i_einri     = l_movement-einri
        i_ou        = l_movement-orgpf
        i_par_name  = 'N1PMN'
      IMPORTING
        e_par_value = l_n1pmn.

    IF l_n1pmn IS NOT INITIAL.

* - - - - - BEGIN MED-44358 C. Honeder
**     Check whether an active nursing plan exists for the OU     "REM MED-44358
*      READ TABLE gt_pflp_eval INTO ls_nrsph                      "REM MED-44358
*        WITH KEY einri    = l_movement-einri                     "REM MED-44358
*                 patnr    = l_movement-patnr                     "REM MED-44358
*                 orgfa    = l_movement-orgfa                     "REM MED-44358
*                 orgpf    = l_movement-orgpf                     "REM MED-44358
*                 end_date = l_end_date.                          "REM MED-44358


*      IF sy-subrc = 0.                                           "REM MED-44358
      TRY.

          lr_startup_settings = cl_ishmed_nrs_gass_plan=>new_instance(
                  i_initial_pdet_tabstrip =
                   cl_ishmed_nrs_gm_ccon_plan=>co_pdet_tabstrip_evaluations ).

          cl_ishmed_nrs_plan_dialog_api=>execute_by_patnr(
               i_patnr             = l_movement-patnr
               i_ctx_einri         = l_movement-einri
               i_ctx_orgfa         = l_movement-orgfa
               i_ctx_orgpf         = l_movement-orgpf
               ir_startup_settings = lr_startup_settings
               i_ctx_falnr         = l_movement-falnr ).    "MED-46984
*                 i_ctx_vma           =
*                 i_dws               = ABAP_TRUE
*                 i_plan_type         =
*                 i_allow_resume      = ABAP_TRUE
*                 ir_layout           =

          p_refresh = 1.

        CATCH cx_ish_static_handler INTO lx_ish_static_handler.
          CALL METHOD lx_ish_static_handler->get_errorhandler
            IMPORTING
              er_errorhandler = lr_errorhandler.
          IF lr_errorhandler IS BOUND.
            CALL METHOD lr_errorhandler->get_messages
              IMPORTING
                t_messages = lt_messages.
            pt_messages[] = lt_messages[].
          ENDIF.
          p_rc = 1.
          EXIT.
      ENDTRY.
*      ELSE.                                                            "REM MED-44358
*        PERFORM build_bapiret2(sapmn1pa)                               "REM MED-44358
*          USING 'E' 'N1NURSE_MED' '150' space space space space        "REM MED-44358
*                                      space space space                "REM MED-44358
*          CHANGING ls_msg.                                             "REM MED-44358
*        APPEND ls_msg TO pt_messages.                                  "REM MED-44358
*        p_rc = 1.                                                      "REM MED-44358
*      ENDIF.                                                           "REM MED-44358
* - - - - - END MED-44358 C. Honeder
    ENDIF.
  ENDIF.

ENDFORM.                    "call_nrsplan_eval

*&---------------------------------------------------------------------*
*&      Form  FILL_TABLE_PATORDER
*&---------------------------------------------------------------------*
*       KG, MED-43708
*       reads medication orders for patient
*----------------------------------------------------------------------*
*      -->PT_CARE_UNIT_LIST  list of entries in view
*----------------------------------------------------------------------*
FORM fill_table_patorder  USING    pt_care_unit_list TYPE ishmed_t_care_unit_list.

  DATA: ls_patorder  TYPE ty_patorder,
        l_date_from  TYPE sy-datum,
        lt_status    TYPE ishmed_t_tn1ostatus,
        lt_meordid   TYPE ishmed_t_meordid,
        lt_n1meorder TYPE ishmed_t_n1meorder,
        l_date_to    TYPE sy-datum.

  FIELD-SYMBOLS: <ls_care_unit_list> LIKE LINE OF pt_care_unit_list,
                 <ls_n1meorder>      TYPE n1meorder.

*  REFRESH gt_patorder. "GT, MED-59285: Refresh moved in loop

* get all defined status not signed as deleted
  SELECT * FROM tn1ostatus INTO TABLE lt_status
    WHERE loekz = space.

* set the time period (current date - 2 days)
  l_date_to   = sy-datum.
  l_date_from = l_date_to - 2.

* now select and filter all medication orders for every
* patient in the list
  LOOP AT pt_care_unit_list ASSIGNING <ls_care_unit_list>.
    CLEAR ls_patorder.
    REFRESH: lt_meordid,
             lt_n1meorder.

    ls_patorder-patnr = <ls_care_unit_list>-patnr.

    DELETE TABLE gt_patorder WITH TABLE KEY patnr = ls_patorder-patnr. "GT, MED-59285: Refresh every patient

    CALL FUNCTION 'ISHMED_ME_READ_ORDERS_FOR_PAT'
      EXPORTING
        i_einri          = <ls_care_unit_list>-einri
        i_patnr          = <ls_care_unit_list>-patnr
        it_status        = lt_status
        i_date_from      = l_date_from
        i_date_to        = l_date_to
        i_refresh_buffer = 'C'
      IMPORTING
        et_n1meorder     = lt_n1meorder.

    CHECK lt_n1meorder IS NOT INITIAL.

*   now filter medication orders
    LOOP AT lt_n1meorder ASSIGNING <ls_n1meorder>.

*     ignore medication orders of others cases
      CHECK <ls_n1meorder>-falnr = <ls_care_unit_list>-falnr.

*     ignore anamnestic orders
      CHECK <ls_n1meorder>-meoext <> 'X'.

*     just take medication orders with changes
      CHECK <ls_n1meorder>-chdver = on.

*     corresponding dates have to be after checking date
      CHECK <ls_n1meorder>-erdat > l_date_from OR
            <ls_n1meorder>-updat > l_date_from OR
            <ls_n1meorder>-stdat > l_date_from.

      APPEND <ls_n1meorder>-meordid TO lt_meordid.
    ENDLOOP.
    CHECK lt_meordid IS NOT INITIAL.
    ls_patorder-t_meordid = lt_meordid.
    INSERT ls_patorder INTO TABLE gt_patorder.
  ENDLOOP.

ENDFORM.                    " FILL_TABLE_PATORDER

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_CHDVER_ICON
*&---------------------------------------------------------------------*
*       KG, MED-43708
*       form fills field CHDVER in outtab
*----------------------------------------------------------------------*
*      -->p_bew  current outtab entry
*----------------------------------------------------------------------*
FORM get_field_chdver_icon  USING p_bew TYPE rnwp_care_unit_list.

* just set the icon for patient with a corresponding entry in gt_patorder
  READ TABLE gt_patorder TRANSPORTING NO FIELDS
    WITH TABLE KEY patnr = p_bew-patnr.
  IF sy-subrc = 0.
    p_bew-chdver = g_chdver_icon.
  ENDIF.
ENDFORM.                    " GET_FIELD_CHDVER_ICON

*&---------------------------------------------------------------------*
*&      Form  CALL_ME_VIEW
*&---------------------------------------------------------------------*
*       KG, MED-43708
*       this form searches a special view for medication events and opens
*       it
*----------------------------------------------------------------------*
*      -->PT_MESSAGES
*      -->PT_OBJECTS
*      -->PT_PARAMETER
*      <--P_RC
*      <--P_REFRESH
*----------------------------------------------------------------------*
FORM call_me_view  TABLES   pt_messages STRUCTURE bapiret2
                      USING    p_einri    TYPE einri
                               pt_objects TYPE ish_objectlist
                               pt_parameter TYPE ishmed_t_parameter
                      CHANGING p_rc TYPE ish_method_rc
                               p_refresh TYPE n1fld-refresh.

  DATA: l_parameter      LIKE LINE OF pt_parameter,
        l_wplace_id_from TYPE nwplace-wplaceid,
        l_wplace_id      TYPE nwplace-wplaceid,
        l_view_type_from TYPE nwview-viewtype,
        l_view_id_from   TYPE nwview-viewid,
        l_patnr          TYPE patnr,
        l_view_id        TYPE nwview-viewid,
        lt_wp_views      TYPE TABLE OF v_nwpvz,
        ls_wp_view       TYPE v_nwpvz,
        l_viewtype_call  TYPE nwview-viewtype,
        lt_sel_obj       TYPE ish_t_sel_object,
        l_sel_obj        LIKE LINE OF lt_sel_obj,
        l_object         LIKE LINE OF pt_objects,
        lt_ish_objects   TYPE ish_t_drag_drop_data,
        l_rc             TYPE ish_method_rc,
        lt_selvar        TYPE TABLE OF rsparams,
        lt_messages      TYPE ishmed_t_bapiret2,
        ls_ish_selobject TYPE rnwp_ish_objects,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        ls_selvar        LIKE LINE OF lt_selvar.

  INTERFACE if_ish_list_display LOAD.

* initialization
  CLEAR p_rc.
  p_refresh = 0.

  CLEAR: l_parameter, l_viewtype_call,
         l_wplace_id_from, l_view_id_from, l_view_type_from,
         l_view_id.

  REFRESH: lt_sel_obj, lt_ish_objects, lt_wp_views.

* get calling view
  READ TABLE pt_parameter INTO l_parameter WITH KEY type = '001'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_view_id_from = l_parameter-value.
  ENDIF.

* get calling view-type
  READ TABLE pt_parameter INTO l_parameter WITH KEY type = '002'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_view_type_from = l_parameter-value.
  ENDIF.

* set wanted view-type
  l_viewtype_call = '012'.

* get calling wplace
  READ TABLE pt_parameter INTO l_parameter WITH KEY type = '003'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_wplace_id_from = l_parameter-value.
  ELSE.
    EXIT.
  ENDIF.

* build context data for the viewtype to call (patient, case, ...)
  LOOP AT pt_objects INTO l_object.
    CLEAR l_sel_obj.
    l_sel_obj-subobject = l_object-object.
    l_sel_obj-attribute = if_ish_list_display=>co_sel_object.
    APPEND l_sel_obj TO lt_sel_obj.
  ENDLOOP.
  CALL METHOD cl_ish_display_tools=>get_wp_ish_object
    EXPORTING
      i_sel_attribute     = '*'
      i_set_extern_values = on
      i_institution       = p_einri
      i_view_id           = l_view_id_from
      i_view_type         = l_view_type_from
      it_object           = lt_sel_obj
    IMPORTING
      e_rc                = p_rc
      et_ish_object       = lt_ish_objects
    CHANGING
      c_errorhandler      = lr_errorhandler.
  IF p_rc <> 0 AND lr_errorhandler IS BOUND.
    CALL METHOD lr_errorhandler->get_messages
      IMPORTING
        t_messages = lt_messages.
    pt_messages[] = lt_messages.
  ENDIF.

* check whether there are any changes on medication data?
* (check gt_patorder)
  READ TABLE lt_ish_objects INTO ls_ish_selobject
    WITH KEY objectid = '01'.
  IF sy-subrc = 0.
    l_patnr = ls_ish_selobject-objectlow.
  ENDIF.
  IF l_patnr IS NOT INITIAL.
    READ TABLE gt_patorder TRANSPORTING NO FIELDS
      WITH TABLE KEY patnr = l_patnr.
    IF sy-subrc <> 0.
      p_refresh = 0.
      p_rc = 0.
      RETURN.
    ENDIF.
  ENDIF.

* read all active views for the user
  CALL FUNCTION 'ISHMED_VM_PERSONAL_DATA_READ'
    EXPORTING
      i_uname  = sy-uname
      i_caller = 'CALL_ME_VIEW'
    TABLES
      t_nwpvz  = lt_wp_views.

  SORT lt_wp_views BY wplacetype wplaceid viewtype sortid.


* first search within the calling wplace
  LOOP AT lt_wp_views INTO ls_wp_view
                      WHERE wplaceid = l_wplace_id_from
                      AND   viewtype = l_viewtype_call.

    l_view_id = ls_wp_view-viewid.
    l_wplace_id = l_wplace_id_from.
    REFRESH lt_selvar.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid   = l_view_id
        i_viewtype = l_viewtype_call
        i_caller   = 'CALL_ME_VIEW'
        i_placeid  = l_wplace_id
      IMPORTING
        e_rc       = l_rc
      TABLES
        t_selvar   = lt_selvar.
*  check flag CHDVER in selection variant
*  only views with attribue S_CHDVER set are qualified
    READ TABLE lt_selvar INTO ls_selvar WITH KEY
       selname = 'S_CHDVER'.
    IF sy-subrc = 0.
      IF ls_selvar-low <> 'X'.
        CLEAR l_view_id.
        CLEAR l_wplace_id.
        CONTINUE.
      ENDIF.
    ELSE.
      CLEAR l_view_id.
      CLEAR l_wplace_id.
      CONTINUE.
    ENDIF.
    EXIT.
  ENDLOOP.
* if there is no view within the workplace get the first
* outside the workplace
  IF l_view_id IS INITIAL.
    LOOP AT lt_wp_views INTO ls_wp_view
                        WHERE wplaceid <> l_wplace_id_from
                        AND   viewtype = l_viewtype_call.
      l_view_id = ls_wp_view-viewid.
      l_wplace_id = ls_wp_view-wplaceid.
      REFRESH lt_selvar.
      CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
        EXPORTING
          i_viewid   = l_view_id
          i_viewtype = l_viewtype_call
          i_caller   = 'CALL_ME_VIEW'
          i_placeid  = l_wplace_id
        IMPORTING
          e_rc       = l_rc
        TABLES
          t_selvar   = lt_selvar.
*     check flag CHDVER in selection variant
*     only views with attribue S_CHDVER set are qualified
      READ TABLE lt_selvar INTO ls_selvar WITH KEY
        selname = 'S_CHDVER'.
      IF sy-subrc = 0.
        IF ls_selvar-low <> 'X'.
          CLEAR l_view_id.
          CLEAR l_wplace_id.
          CONTINUE.
        ENDIF.
      ELSE.
        CLEAR l_view_id.
        CLEAR l_wplace_id.
        CONTINUE.
      ENDIF.
      EXIT.
    ENDLOOP.
  ENDIF.

  IF NOT l_view_id IS INITIAL.
*   call new view
    CALL FUNCTION 'ISH_WP_VIEW_PROGRAM_CALL'
      EXPORTING
        i_institution_id      = p_einri
        i_wplace_id           = l_wplace_id
        i_user_id             = sy-uname
        i_view_id             = l_view_id
        i_view_type           = l_viewtype_call
      TABLES
        i_ish_objects         = lt_ish_objects
      EXCEPTIONS
        no_view_program_exist = 1
        OTHERS                = 2.
    IF sy-subrc <> 0.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = lr_errorhandler.
      CALL METHOD lr_errorhandler->get_messages
        IMPORTING
          t_messages = lt_messages.
      pt_messages[] = lt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    ENDIF.
  ELSE.
*   no corresponding view exists
    CALL METHOD lr_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1ME'
        i_num  = '000'
        i_mv1  = 'Keine Verordnungssicht mit Selektionskriterium'(025)
        i_mv2  = '"geänderte Medikation" vorhanden'(026)
        i_last = space.
    CALL METHOD lr_errorhandler->get_messages
      IMPORTING
        t_messages = lt_messages.
    pt_messages[] = lt_messages.

    p_rc = 1.
    p_refresh = 0.
    EXIT.
  ENDIF.

ENDFORM.                    " CALL_ME_VIEW
*&---------------------------------------------------------------------*
*&      Form  go_next_prev
*&---------------------------------------------------------------------*
*       switch to next or previous selection day (MED-46307)
*----------------------------------------------------------------------*
FORM go_next_prev USING    VALUE(p_view_id)   TYPE nviewid
                           VALUE(p_view_type) TYPE nviewtype
                           VALUE(p_wplace_id) TYPE nwplaceid
                           VALUE(p_einri)     TYPE einri
                           VALUE(p_next)      TYPE ish_on_off
                           VALUE(p_prev)      TYPE ish_on_off
                           VALUE(p_calender)  TYPE ish_on_off
                  CHANGING p_rc               TYPE sy-subrc
                           p_refresh          TYPE n1fld-refresh.


  DATA: lt_selvar     TYPE ishmed_t_rsparams,
        l_selvar      LIKE LINE OF lt_selvar,
        l_date_old    TYPE sy-datum,
        l_date_new    TYPE sy-datum,
        l_select_date TYPE workflds-gkday,
        l_repid       TYPE sy-repid,
        l_kh_cal      TYPE scal-fcalid,    "Krankenhauskalender
*        l_hol_cal       TYPE scal-fcalid,    "Ferienkalender
*        l_tfacd         TYPE tfacd,
        l_value       TYPE tn00r-value.

  CLEAR: p_rc, p_refresh, l_kh_cal, l_value,
         l_date_old, l_date_new, l_select_date.

  REFRESH lt_selvar.

* get holiday and factory calendar
  PERFORM ren00r IN PROGRAM sapmnpa0 USING p_einri 'KALENDER' l_value.
  IF l_value CO '0123456789'.
    l_kh_cal = l_value+8(2).
  ELSE.
    l_kh_cal = l_value(2).
  ENDIF.
*  SELECT SINGLE * FROM tfacd INTO l_tfacd WHERE ident = l_kh_cal.
*  IF sy-subrc EQ 0.
*    l_hol_cal = l_tfacd-hocid.
*  ENDIF.

  l_repid = sy-repid.

* get selection variant
  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_placeid  = p_wplace_id
      i_viewid   = p_view_id
      i_viewtype = p_view_type
      i_caller   = l_repid
    TABLES
      t_selvar   = lt_selvar.

* get actual selection period
  LOOP AT lt_selvar INTO l_selvar WHERE selname = 'KEYDATE'.
    l_date_old  = l_selvar-low.
  ENDLOOP.

* switch to next or previous selection day
  IF p_next = on.
    l_date_new  = l_date_old + 1.
  ELSEIF p_prev = on.
    l_date_new = l_date_old - 1.
  ELSEIF p_calender = on.
    CALL FUNCTION 'F4_DATE_CONTROL'
      EXPORTING
*       DATE_FOR_FIRST_MONTH         = SY-DATUM
*       DISPLAY                      = ' '
        factory_calendar_id          = l_kh_cal
*       GREGORIAN_CALENDAR_FLAG      = ' '
*       holiday_calendar_id          = l_hol_cal
*       HOLIDAY_STYLE                = '6'
*       PROGNAME_FOR_FIRST_MONTH     = ' '
*       WEEK_BEGIN_DAY               = 1
        select_option_week           = off
        select_option_month          = off
      IMPORTING
        select_date                  = l_select_date
*       select_begin                 = l_select_begin
*       select_end                   = l_select_end
      EXCEPTIONS
        calendar_buffer_not_loadable = 1
        date_after_range             = 2
        date_before_range            = 3
        date_invalid                 = 4
        factory_calendar_not_found   = 5
        holiday_calendar_not_found   = 6
        parameter_conflict           = 7
        OTHERS                       = 8.
    IF sy-subrc = 0.
      IF l_select_date IS NOT INITIAL.
        l_date_new  = l_select_date.
      ELSE.
        EXIT.
      ENDIF.
    ELSE.
      EXIT.
    ENDIF.
  ELSE.
    EXIT.
  ENDIF.

* change info in selection variant
  LOOP AT lt_selvar INTO l_selvar WHERE selname = 'KEYDATE'.
    l_selvar-low  = l_date_new.
    MODIFY lt_selvar FROM l_selvar.
  ENDLOOP.
  LOOP AT lt_selvar INTO l_selvar WHERE selname = 'DATE_FIX'.
    l_selvar-low  = on.
    MODIFY lt_selvar FROM l_selvar.
  ENDLOOP.

* update selection variant in buffer
  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_placeid  = p_wplace_id
      i_viewid   = p_view_id
      i_viewtype = p_view_type
      i_mode     = 'U'
      i_caller   = l_repid
    TABLES
      t_selvar   = lt_selvar.

  p_refresh = '2'.

ENDFORM.                    " go_next_prev
*>>> IXX-18332 FM
*&---------------------------------------------------------------------*
*&      Form  DO_CHECK_AUTH_PAT_FOR_FUNC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_T_MESSAGES  text
*      -->P_LT_MOVEMENT  text
*      <--P_E_RC  text
*      <--P_E_FUNC_DONE  text
*----------------------------------------------------------------------*
FORM do_check_auth_pat_for_func  TABLES   p_t_messages  STRUCTURE bapiret2
                                 USING    p_lt_movement TYPE ishmed_t_care_unit_list_head
                                 CHANGING p_e_rc        TYPE sy-subrc
                                          p_e_func_done TYPE ish_true_false.

   DATA: lt_patient  TYPE ishmed_t_pat,
         ls_patient  TYPE rn1pat,
         lt_bapiret  TYPE bapirettab,
         ls_movement TYPE rnwp_care_unit_list_head.

  LOOP AT p_lt_movement INTO ls_movement.
    IF ls_movement-patnr IS NOT INITIAL.
      clear ls_patient.
      ls_patient-einri = ls_movement-einri.
      ls_patient-patnr = ls_movement-patnr.
      APPEND ls_patient TO lt_patient.
    ENDIF.
  ENDLOOP.

  SORT lt_patient BY einri patnr.

  DELETE ADJACENT DUPLICATES FROM lt_patient.

  cl_ishmed_utl_wp_func=>check_pat_authority(
    EXPORTING
      it_patient = lt_patient
    CHANGING
      c_rc       = p_e_rc
      c_done     = p_e_func_done
      ct_bapiret = lt_bapiret
         ).

  IF p_e_rc > 0.
    p_t_messages[] = lt_bapiret.
  ENDIF.
ENDFORM.
*<<< IXX-18332 FM
