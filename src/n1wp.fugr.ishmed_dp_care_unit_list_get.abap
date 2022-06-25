FUNCTION ishmed_dp_care_unit_list_get.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_DISPVAR) TYPE  LVC_T_FCAT
*"  TABLES
*"      T_CARE_UNIT_LIST TYPE  ISHMED_T_CARE_UNIT_LIST
*"      T_SELECTION_CRITERIA STRUCTURE  RSPARAMS
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------
  DATA: l_dispvar   TYPE lvc_s_fcat,
        l_list_head TYPE rnwp_care_unit_list_head.
  DATA: lt_falar TYPE TABLE OF ty_fal,
        l_falar  TYPE ty_fal.
  DATA: l_pat               TYPE ty_pat,
        l_pap               TYPE ty_pap,
        l_fal               TYPE ty_fal,
        lt_vardata          LIKE TABLE OF rn1uex,
        lt_h_vardata        LIKE TABLE OF rn1uex,
        l_vardata           LIKE rn1uex,
        l_listkz            TYPE n1dplistkz,                " ID 8690
        l_viewid            TYPE nwview-viewid,             " ID 8690
        l_oe                LIKE norg-orgid,                " ID 7248
        lt_n1orgpar         LIKE TABLE OF n1orgpar WITH HEADER LINE,
        l_med_or_lab        TYPE ish_on_off,                " ID 10488
        l_tab_fieldname(60) TYPE c.
  DATA: l_dis_diagnose      LIKE off,
        l_dis_orgpf_akt     LIKE off,
        l_dis_beh_arzt      LIKE off,
        l_dis_beh_arzt_name LIKE off,
        l_dis_anf_icon      LIKE off,
        l_dis_ka_icon       LIKE off,
        l_dis_pfl_icon      LIKE off,
        l_dis_pfll_icon     LIKE off,                       "MED-29612
        l_dis_pflp_icon     LIKE off,
        l_dis_eval_icon     LIKE off,                       "MED-33285
        l_dis_dok_icon      LIKE off,
        l_dis_meddok_icon   LIKE off,                       " ID 10488
        l_dis_labdok_icon   LIKE off,                       " ID 10488
        l_dis_icon_doc      LIKE off,
        l_dis_info_exit     LIKE off,
        l_dis_datag         LIKE off,
        l_dis_uztag         LIKE off,
        l_dis_orgag         LIKE off,
        l_dis_bauag         LIKE off,
        l_dis_orgzl         LIKE off,
        l_dis_bauzl         LIKE off,
        l_dis_fat_tpae      LIKE off,
        l_dis_fat_tpatx     LIKE off,                       " ID 8961
        l_dis_fname         LIKE off,
        l_dis_fstatus       LIKE off,
        l_dis_trans         LIKE off,
        l_dis_transtxt      LIKE off,
        l_dis_trava_icon    LIKE off,
        l_dis_batmp_icon    LIKE off,
        l_dis_chdver_icon            LIKE off,                      "KG MED-43708
        l_disp_emar_pending_activity LIKE off. " IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 31/05/2018
  DATA: l_uex_orgpf_akt     LIKE off,
        l_uex_beh_arzt      LIKE off,
        l_uex_beh_arzt_name LIKE off,
        l_uex_anf_icon      LIKE off,
        l_uex_ka_icon       LIKE off,
        l_uex_pfl_icon      LIKE off,
        l_uex_pfll_icon     LIKE off,                       "MED-29612
        l_uex_pflp_icon     LIKE off,
        l_uex_eval_icon     LIKE off,                       "MED-33285
        l_uex_dok_icon      LIKE off,
        l_uex_meddok_icon   LIKE off,                       " ID 10488
        l_uex_labdok_icon   LIKE off,                       " ID 10488
        l_uex_icon_doc      LIKE off,
        l_uex_info_exit     LIKE off,
        l_uex_datag         LIKE off,
        l_uex_uztag         LIKE off,
        l_uex_orgag         LIKE off,
        l_uex_bauag         LIKE off,
        l_uex_orgzl         LIKE off,
        l_uex_bauzl         LIKE off,
        l_uex_fat_tpae      LIKE off,
        l_uex_fat_tpatx     LIKE off,                       " ID 8961
        l_uex_fname         LIKE off,
        l_uex_fstatus       LIKE off,
        l_uex_trans         LIKE off,
        l_uex_transtxt      LIKE off,
        l_uex_trava_icon    LIKE off,
        l_uex_batmp_icon    LIKE off,
        l_uex_chdver_icon   LIKE off.                      "KG, MED-43708

  DATA: l_care_unit_list     TYPE rnwp_care_unit_list.      "AN261102

  "START IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 31/05/2018
  DATA: lr_helper_class TYPE REF TO cl_ishmed_me_dp_001_helper.
* END" IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 31/05/2018

  FIELD-SYMBOLS: <fieldname> TYPE any.

  CLEAR:   t_messages, gt_pat, gt_pap, gt_fal, lt_vardata.
  REFRESH: t_messages, gt_pat, gt_pap, gt_fal, lt_vardata.

  g_call_counter = g_call_counter + 1.                      " ID 7248

* ---------------------------------------------------------------------
* get selection criteria for care unit list
* ---------------------------------------------------------------------
  CLEAR: g_institution, g_key_date, g_key_time, g_key_time_sel,
         g_history_period, g_planning_period.
  REFRESH: gr_treat_ou, gr_dept_ou, gr_room.
  LOOP AT t_selection_criteria.
    CASE t_selection_criteria-selname.
      WHEN 'SE_EINRI'.
        g_institution     = t_selection_criteria-low.
      WHEN 'KEYDATE'.
        g_key_date        = t_selection_criteria-low.
      WHEN 'KEYTIME'.
        g_key_time        = t_selection_criteria-low.
        g_key_time_sel    = t_selection_criteria-low.       " MED-29612
      WHEN 'HISTHORZ'.
        g_history_period  = t_selection_criteria-low.
      WHEN 'PLANHORZ'.
        g_planning_period = t_selection_criteria-low.
      WHEN 'R_TREAOU'.
        CHECK t_selection_criteria-low NE space.
        MOVE-CORRESPONDING t_selection_criteria TO gr_treat_ou.
        APPEND gr_treat_ou.
      WHEN 'R_DEPTOU'.
        CHECK t_selection_criteria-low NE space.
        MOVE-CORRESPONDING t_selection_criteria TO gr_dept_ou.
        APPEND gr_dept_ou.
      WHEN 'R_ROOM'.
        CHECK t_selection_criteria-low NE space.
        MOVE-CORRESPONDING t_selection_criteria TO gr_room.
        APPEND gr_room.
    ENDCASE.
  ENDLOOP.

* set the actual time for refreshing
  IF g_key_date EQ sy-datum.
    g_key_time = sy-uzeit.
  ENDIF.
  IF g_key_time_sel IS INITIAL.                             " MED-29612
    g_key_time_sel = sy-uzeit.                              " MED-29612
  ENDIF.                                                    " MED-29612


* check obligatory selection criteria
  CHECK NOT g_institution IS INITIAL AND
        NOT g_key_date    IS INITIAL.

* ID 8690: if another view is called - initialize counter
  CALL FUNCTION 'ISH_WP_ACTIVE_VIEWS_TRANSFER'
    IMPORTING
      e_view_id = l_viewid.
  IF g_call_viewid_last <> l_viewid.
    g_call_counter = 1.
    g_diagdisp     = off.
  ENDIF.
  g_call_viewid_last = l_viewid.

* ID 7248: at first time called, display diagnosis of user-exit
*          (if active and parameter is set)
  IF g_diagdisp = off AND g_call_counter = 1.
    CLEAR lt_n1orgpar. REFRESH lt_n1orgpar.
    CLEAR l_oe.
    READ TABLE gr_treat_ou INDEX 1.
    IF sy-subrc = 0.
      l_oe = gr_treat_ou-low.
    ELSE.
      READ TABLE gr_dept_ou INDEX 1.
      IF sy-subrc = 0.
        l_oe = gr_dept_ou-low.
      ENDIF.
    ENDIF.
    PERFORM read_n1orgpar(sapl0n1s) TABLES lt_n1orgpar
                                    USING  g_institution l_oe
                                           'N1MLDIAG'    sy-datum.
    DESCRIBE TABLE lt_n1orgpar.
    IF sy-tfill > 0.
      READ TABLE lt_n1orgpar INDEX 1.
      IF lt_n1orgpar-n1parwert = 'F'.
        g_diagdisp = on.
      ENDIF.
    ENDIF.
  ENDIF.

* ---------------------------------------------------------------------
* check display variant for medical fields to be displayed
* ---------------------------------------------------------------------
  CLEAR: l_dis_diagnose,  l_dis_orgpf_akt, l_dis_beh_arzt,
         l_dis_anf_icon,  l_dis_ka_icon,   l_dis_pfl_icon,
         l_dis_pflp_icon, l_dis_dok_icon,  l_dis_icon_doc,
         l_dis_meddok_icon, l_dis_labdok_icon, l_dis_pfll_icon,
         l_dis_info_exit, l_dis_beh_arzt_name, l_dis_eval_icon,
         l_dis_datag, l_dis_uztag, l_dis_orgag,
         l_dis_bauag, l_dis_orgzl, l_dis_bauzl,
         l_dis_fat_tpae, l_dis_fat_tpatx, l_dis_fname, l_dis_fstatus,
         l_dis_trans, l_dis_trava_icon, l_dis_transtxt,
         l_dis_batmp_icon,
         l_dis_chdver_icon, l_disp_emar_pending_activity.           "KG, MED-43708

  LOOP AT i_dispvar INTO l_dispvar WHERE no_out IS INITIAL.
    CASE l_dispvar-fieldname.
      WHEN 'DIAGNOSE'.
        l_dis_diagnose      = on.
      WHEN 'ORGPF_AKT'.
        l_dis_orgpf_akt     = on.
      WHEN 'BEH_ARZT'.
        l_dis_beh_arzt      = on.
      WHEN 'BEH_ARZT_NAME'.
        l_dis_beh_arzt_name = on.
      WHEN 'ANF_ICON'.
        l_dis_anf_icon      = on.
      WHEN 'KA_ICON'.
        l_dis_ka_icon       = on.
      WHEN 'PFL_ICON'.
        l_dis_pfl_icon      = on.
      WHEN 'PFLL_ICON'.                                     "MED-29612
        l_dis_pfll_icon     = on.                           "MED-29612
      WHEN 'PFLP_ICON'.
        l_dis_pflp_icon     = on.
      WHEN 'EVAL_EXIST_ICON'.                               "MED-33285
        l_dis_eval_icon     = on.                           "MED-33285
      WHEN 'DOK_ICON'.
        l_dis_dok_icon      = on.
      WHEN 'MEDDOK_ICON'.                                   " ID 10488
        l_dis_meddok_icon   = on.                           " ID 10488
      WHEN 'LABDOK_ICON'.                                   " ID 10488
        l_dis_labdok_icon   = on.                           " ID 10488
      WHEN 'ICON_DOC'.
        l_dis_icon_doc      = on.
      WHEN 'INFO_EXIT'.
        l_dis_info_exit     = on.
      WHEN 'DATAG'.
        l_dis_datag         = on.
      WHEN 'UZTAG'.
        l_dis_uztag         = on.
      WHEN 'ORGZL'.
        l_dis_orgzl         = on.
      WHEN 'BAUZL'.
        l_dis_bauzl         = on.
      WHEN 'ORGAG'.
        l_dis_orgag         = on.
      WHEN 'BAUAG'.
        l_dis_bauag         = on.
      WHEN 'FAT_TPAE'.
        l_dis_fat_tpae      = on.
      WHEN 'FAT_TPATX'.                                     " ID 8961
        l_dis_fat_tpatx     = on.                           " ID 8961
      WHEN 'FNAME'.
        l_dis_fname         = on.
      WHEN 'FSTATUS'.
        l_dis_fstatus       = on.
      WHEN 'TRANS'.
        l_dis_trans         = on.
      WHEN 'TRANSTXT'.
        l_dis_transtxt      = on.
      WHEN 'TRAVA_ICON'.
        l_dis_trava_icon    = on.
      WHEN 'BATMP_ICON'.
        l_dis_batmp_icon    = on.
*     KG, MED-43708 - Begin
      WHEN 'CHDVER'.
        l_dis_chdver_icon   = on.
*     KG, MED-43708 - End
      WHEN 'PATHWAY_STATE'      OR 'PATHWAY_STATE_TXT'  OR
           'PATHWAY_STATE_ICON' OR 'PROFESSIONS'.
*       GSD-fields (patient pathway data)
        CONTINUE.
      WHEN 'FATID' OR 'LFDNR_DIA' OR 'LFDNR_DIA_TECH'.      " MED-38816
*       technical fields
        CONTINUE.
*     IS-H-fields of occupancy-, arrival- and departure-list
      WHEN 'ABWPAT' OR 'ABWP_ICON' OR 'AGEPAT' OR 'BEGLPAT' OR
           'BEGLP_ICON' OR 'BEKAT' OR 'BEKTX'  OR 'BETT'    OR
           'BETTKB' OR 'BEWTY' OR 'BLOCK_ICON' OR 'BWART'   OR
           'BWATX'  OR 'BWEDT'     OR 'BWEZT'  OR 'BWIDT'   OR
           'BWIZT'  OR 'CLASS'     OR 'CLKTXT' OR 'CT'      OR
           'FALAR'  OR 'FALARE'    OR 'FALNR'  OR 'FZIFF'   OR
           'GBDAT'  OR 'GBNAM'     OR 'GBNAMS' OR 'GSCHLE'  OR
           'INFKZ'  OR 'INFKZ_ICON' OR 'KRZAN' OR 'KZTXT'   OR
           'LFDNR'  OR 'NNAME'     OR 'NNAMS'  OR 'NOTAN'   OR
           'ORGFA'  OR 'ORGFAKB'   OR 'ORGPF'  OR 'ORGPFKB' OR
           'PATGRP' OR 'PATNR'     OR 'PLANB'  OR 'PLANE'   OR
           'PLANR'  OR 'PNAMEC'    OR 'PNAMEC1' OR 'PRIVPAT' OR
           'PRIVP_ICON' OR 'PZIFF' OR 'RISKPAT' OR 'HREF'   OR
           'RISKP_ICON' OR 'TELNR' OR 'VNAME'  OR 'VNAMS'   OR
           'ZIMMERKB'   OR 'ZIMMR' OR 'HANDLE' OR 'DATETIME'   OR
           'AUFDT'      OR 'AUFDT_DAYS'        OR 'PLNDC'      OR
           'PLNDC_ICON' OR 'SRGDT'             OR 'SRGDT_DAYS' OR
           'TARIF'      OR 'TARLS'             OR 'KTXTCONC'   OR
           'CASE_VWD'   OR 'MGVD' OR 'OGVD'    OR 'UGVD'       OR
           'DAYS_OGVD'  OR 'DAYS_OGVD_ICON'    OR 'DAYS_UGVD'  OR
           'DAYS_UGVD_ICON' OR 'DAYS_MGVD'     OR 'RVNUM'      OR
           'DAYS_MGVD_ICON' OR 'REL_OGVD'      OR 'BLOCKE'     OR
           'REL_UGVD'       OR 'REL_MGVD'      OR 'BLOCKB'     OR
           'DAYS_TO_OGVD'   OR 'FACHS'         OR 'FACHSTXT'   OR
           'BLOCKR'         OR 'GBNAS'         OR 'VIP_ICON'   OR
           'BLOCKRT'        OR 'VIPKZ'.
        CONTINUE.
*        BEGIN OF IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 31/05/2018
      WHEN 'EMAR_PEND_ACT' .
        l_disp_emar_pending_activity = on.
*        END OF IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 31/05/2018
      WHEN OTHERS.                         " customer defined fields
*       add to vardata for user-exit
    ENDCASE.
*   add fields to be displayed for user-exit
    PERFORM add_vardata TABLES lt_vardata
                        USING  l_dispvar.
  ENDLOOP.

* ---------------------------------------------------------------------
* check if user-exit-values should be displayed
* ---------------------------------------------------------------------
  READ TABLE t_care_unit_list INDEX 1 INTO l_care_unit_list. " ID 8690
  IF sy-subrc = 0.
    l_listkz = l_care_unit_list-listkz.
  ENDIF.                                                    " ID 8690
  CLEAR l_list_head.
  l_list_head-listkz = l_listkz.                            " ID 8690
  PERFORM call_userexit_disp TABLES  lt_vardata t_selection_criteria
                             USING   l_list_head
                                     on.              " check only !

* ID 8690: Wenn im User-Exit definiert wurde, daß das Diagnose-Feld
*          übersteuert werden soll, dann auch das glob. KZ setzen
  READ TABLE lt_vardata INTO l_vardata WITH KEY o_name  = 'DIAGNOSE'
                                                use_uex = on.
  IF sy-subrc = 0.
    g_diagdisp = on.
  ENDIF.

  CLEAR: l_uex_orgpf_akt, l_uex_beh_arzt,
         l_uex_anf_icon,  l_uex_ka_icon,   l_uex_pfl_icon,
         l_uex_pflp_icon, l_uex_dok_icon,  l_uex_icon_doc,
         l_uex_info_exit, l_uex_beh_arzt_name, l_uex_pfll_icon,
         l_uex_meddok_icon, l_uex_labdok_icon, l_uex_eval_icon,
         l_uex_datag, l_uex_uztag, l_uex_orgag,
         l_uex_bauag, l_uex_orgzl, l_uex_bauzl,
         l_uex_fat_tpae, l_uex_fat_tpatx, l_uex_fname, l_uex_fstatus,
         l_uex_chdver_icon.                                           "KG, MED-43708

  LOOP AT lt_vardata INTO l_vardata WHERE use_uex = on.
    CASE l_vardata-o_name.
      WHEN 'ORGPF_AKT'.
        l_uex_orgpf_akt     = on.
      WHEN 'BEH_ARZT'.
        l_uex_beh_arzt      = on.
      WHEN 'BEH_ARZT_NAME'.
        l_uex_beh_arzt_name = on.
      WHEN 'ANF_ICON'.
        l_uex_anf_icon      = on.
      WHEN 'KA_ICON'.
        l_uex_ka_icon       = on.
      WHEN 'PFL_ICON'.
        l_uex_pfl_icon      = on.
      WHEN 'PFLL_ICON'.                                     "MED-29612
        l_uex_pfll_icon     = on.                           "MED-29612
      WHEN 'PFLP_ICON'.
        l_uex_pflp_icon     = on.
      WHEN 'EVAL_EXIST_ICON'.
        l_uex_eval_icon     = on.
      WHEN 'DOK_ICON'.
        l_uex_dok_icon      = on.
      WHEN 'MEDDOK_ICON'.                                   " ID 10488
        l_uex_meddok_icon   = on.                           " ID 10488
      WHEN 'ICON_DOC'.
        l_uex_icon_doc      = on.
      WHEN 'INFO_EXIT'.
        l_uex_info_exit     = on.
      WHEN 'DATAG'.
        l_uex_datag         = on.
      WHEN 'UZTAG'.
        l_uex_uztag         = on.
      WHEN 'ORGZL'.
        l_uex_orgzl         = on.
      WHEN 'BAUZL'.
        l_uex_bauzl         = on.
      WHEN 'ORGAG'.
        l_uex_orgag         = on.
      WHEN 'BAUAG'.
        l_uex_bauag         = on.
      WHEN 'FAT_TPAE'.
        l_uex_fat_tpae      = on.
      WHEN 'FAT_TPATX'.                                     " ID 8961
        l_uex_fat_tpatx     = on.                           " ID 8961
      WHEN 'FNAME'.
        l_uex_fname         = on.
      WHEN 'FSTATUS'.
        l_uex_fstatus       = on.
*     KG, MED-43708 - Begin
      WHEN 'CHDVER'.
        l_uex_chdver_icon   = on.
*     KG, MED-43708 - End
    ENDCASE.
  ENDLOOP.
  DELETE lt_vardata WHERE use_uex = off.

* ---------------------------------------------------------------------
* fill global table with all patients
* ---------------------------------------------------------------------
  LOOP AT t_care_unit_list INTO l_care_unit_list
     WHERE NOT patnr IS INITIAL.
    READ TABLE gt_pat INTO l_pat WITH TABLE KEY
                                 patnr = l_care_unit_list-patnr.
    CHECK sy-subrc <> 0.
    l_pat-patnr = l_care_unit_list-patnr.
    l_pat-einri = l_care_unit_list-einri.
    INSERT l_pat INTO TABLE gt_pat.
  ENDLOOP.
*  DESCRIBE TABLE gt_pat.                                " REM ID 9652
*  CHECK sy-tfill > 0.                                   " REM ID 9652
  LOOP AT t_care_unit_list INTO l_care_unit_list
     WHERE NOT papid IS INITIAL.
    READ TABLE gt_pap INTO l_pap WITH TABLE KEY
                                 papid = l_care_unit_list-papid.
    CHECK sy-subrc <> 0.
    l_pap-papid = l_care_unit_list-papid.
    INSERT l_pap INTO TABLE gt_pap.
  ENDLOOP.

* ---------------------------------------------------------------------
* fill global table with all cases
* ---------------------------------------------------------------------
  LOOP AT t_care_unit_list INTO l_care_unit_list
     WHERE NOT falnr IS INITIAL.
    READ TABLE gt_fal INTO l_fal WITH TABLE KEY
                                 falnr = l_care_unit_list-falnr.
    CHECK sy-subrc <> 0.
    l_fal-falnr = l_care_unit_list-falnr.
    l_fal-einri = l_care_unit_list-einri.
    INSERT l_fal INTO TABLE gt_fal.
  ENDLOOP.
  DESCRIBE TABLE gt_fal.
*  CHECK sy-tfill > 0.                                   " REM ID 9652
  IF sy-tfill > 0.                                          " ID 9652
*   read additional case info (FALAR) if ORGPF_AKT is requested
    IF l_dis_orgpf_akt = on AND l_uex_orgpf_akt = off.
      REFRESH lt_falar.
      SELECT falnr einri falar FROM nfal INTO TABLE lt_falar
             FOR ALL ENTRIES IN gt_fal
             WHERE  einri  = gt_fal-einri
             AND    falnr  = gt_fal-falnr.
      LOOP AT lt_falar INTO l_falar.
        MODIFY gt_fal FROM l_falar TRANSPORTING falar
                      WHERE falnr = l_falar-falnr.
      ENDLOOP.
    ENDIF.
  ENDIF.                                                    " ID 9652

* ---------------------------------------------------------------------
* get global information for all requested medical fields
* ---------------------------------------------------------------------
  PERFORM fill_table_nbew.                                  " MED-33152

* DIAGNOSE (und LFDNR_DIA)
  IF l_dis_diagnose = on.
    PERFORM fill_table_ndia.
*    PERFORM fill_table_nbew.                          " REM MED-33152
  ENDIF.

* ORGPF_AKT

* BEH_ARZT
  IF l_dis_beh_arzt      = on AND l_uex_beh_arzt      = off OR
     l_dis_beh_arzt_name = on AND l_uex_beh_arzt_name = off.
    PERFORM fill_table_nfpz.
  ENDIF.

* BEH_ARZT_NAME
  IF l_dis_beh_arzt_name = on AND l_uex_beh_arzt_name = off.
    PERFORM fill_table_ngpa.
  ENDIF.

* ANF_ICON
  IF l_dis_anf_icon = on AND l_uex_anf_icon = off.
    PERFORM fill_table_anf.
    PERFORM get_icon USING '001' CHANGING g_anf_icon.
  ENDIF.

* KA_ICON
  IF l_dis_ka_icon = on AND l_uex_ka_icon = off.
    PERFORM fill_table_ka.
    PERFORM get_icon USING '005' CHANGING g_ka_icon.
  ENDIF.

* PFL_ICON
  IF l_dis_pfl_icon  = on AND l_uex_pfl_icon  = off.
    PERFORM fill_table_pfl_nlem.
    PERFORM get_icon USING '007' CHANGING g_pfl_icon.
    PERFORM get_icon USING '170' CHANGING g_pfl_icon_r.     "MED-54909
    PERFORM get_icon USING '247' CHANGING g_pfl_icon_g.
  ENDIF.

* PFLL_ICON                                                (MED-29612)
  IF l_dis_pfll_icon = on AND l_uex_pfll_icon = off.
    PERFORM fill_table_pfll_nlem.
    PERFORM get_icon USING '169' CHANGING g_pfll_icon_g.
    PERFORM get_icon USING '170' CHANGING g_pfll_icon_r.
  ENDIF.

* PFLP_ICON
  IF l_dis_pflp_icon = on AND l_uex_pflp_icon = off.
    PERFORM fill_table_pflp_lei.
    PERFORM get_icon USING '008' CHANGING g_pflp_icon_f.
    PERFORM get_icon USING '009' CHANGING g_pflp_icon_nf.
    PERFORM get_icon USING '042' CHANGING g_pflp_icon_de.
    PERFORM get_icon USING '229' CHANGING g_pflp_icon_229.
    PERFORM get_icon USING '230' CHANGING g_pflp_icon_230.
  ENDIF.

* EVAL_ICON (MED-33285)
  IF l_dis_eval_icon = on AND l_uex_eval_icon = off.
    PERFORM fill_table_eval.
    PERFORM get_icon USING '226' CHANGING g_eval_icon_k.
    PERFORM get_icon USING '227' CHANGING g_eval_icon_o.
    PERFORM get_icon USING '228' CHANGING g_eval_icon_f.
  ENDIF.

* DOK_ICON
  IF ( l_dis_dok_icon    = on AND l_uex_dok_icon    = off ) OR
     ( l_dis_meddok_icon = on AND l_uex_meddok_icon = off ) OR " 10488
     ( l_dis_labdok_icon = on AND l_uex_labdok_icon = off ). " 10488
    IF l_dis_meddok_icon = on OR l_dis_labdok_icon = on.    " ID 10488
      l_med_or_lab = on.                                    " ID 10488
    ELSE.                                                   " ID 10488
      l_med_or_lab = off.                                   " ID 10488
    ENDIF.                                                  " ID 10488
    PERFORM fill_table_dok USING l_med_or_lab.
    PERFORM get_icon USING '002' CHANGING g_dok_icon.
    PERFORM get_icon USING '078' CHANGING g_meddok_icon.    " ID 10488
    PERFORM get_icon USING '079' CHANGING g_labdok_icon.    " ID 10488
  ENDIF.

* ICON_DOC
  IF l_dis_icon_doc = on AND l_uex_icon_doc = off.
    PERFORM fill_table_n2flag.
  ENDIF.

* KG, MED-43708 - Begin
  IF l_dis_chdver_icon = on AND l_uex_chdver_icon = off.
    PERFORM fill_table_patorder USING t_care_unit_list[].
    PERFORM get_icon USING '111' CHANGING g_chdver_icon.
  ENDIF.
* KG, MED-43708 - End

* INFO_EXIT
* only filled with user-exit-data

* FATID, DATAG, UZTAG, ORGAG, BAUAG, TRANS, TRANSTXT, TRAVA_ICON,
* ORGZL, BAUZL, FAT_TPAE, FAT_TPATX, FNAME, FSTATUS
  IF ( l_dis_datag      = on    AND
       l_uex_datag      = off )  OR
     ( l_dis_uztag      = on    AND
       l_uex_uztag      = off )  OR
     ( l_dis_orgag      = on    AND
       l_uex_orgag      = off )  OR
     ( l_dis_bauag      = on    AND
       l_uex_bauag      = off )  OR
     ( l_dis_orgzl      = on    AND
       l_uex_orgzl      = off )  OR
     ( l_dis_bauzl      = on    AND
       l_uex_bauzl      = off )  OR
     ( l_dis_fname      = on    AND
       l_uex_fname      = off )  OR
     ( l_dis_trans      = on    AND
       l_uex_trans      = off )  OR
     ( l_dis_transtxt   = on    AND
       l_uex_transtxt   = off )  OR
     ( l_dis_trava_icon = on    AND
       l_uex_trava_icon = off )  OR
     ( l_dis_fstatus    = on    AND
       l_uex_fstatus    = off )  OR
     ( l_dis_fat_tpatx  = on    AND                         " ID 8961
       l_uex_fat_tpatx  = off )  OR                         " ID 8961
     ( l_dis_fat_tpae   = on    AND
       l_uex_fat_tpae   = off ).
    PERFORM fill_table_fat.
    PERFORM get_icon USING '160' CHANGING g_trava_icon.
  ENDIF.

* BATMP_ICON
  IF l_dis_batmp_icon = on AND l_uex_batmp_icon = off.
    PERFORM get_icon USING '105' CHANGING g_batmp_icon.
  ENDIF.
  "START IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 31/05/2018
  IF l_disp_emar_pending_activity EQ on.

    PERFORM load_emar_buffers.

  ENDIF.
  "END IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 31/05/2018
* ---------------------------------------------------------------------
* loop over all movements to get field data if requested
* ---------------------------------------------------------------------
  LOOP AT t_care_unit_list INTO l_care_unit_list.

*   check obligatory fields
    CHECK NOT l_care_unit_list-einri  IS INITIAL AND
*          NOT l_care_unit_list-patnr  IS INITIAL AND   " REM ID 9652
*          NOT l_care_unit_list-falnr  IS INITIAL AND   " REM ID 9652
*          NOT l_care_unit_list-lfdnr  IS INITIAL AND   " REM ID 9652
          NOT l_care_unit_list-listkz IS INITIAL.

    IF l_care_unit_list-mandt IS INITIAL.
      l_care_unit_list-mandt = sy-mandt.
    ENDIF.

*   DIAGNOSE (und LFDNR_DIA)
*   ID 12708: LFDNR_DIA muß für den User-Exit immer befüllt werden!
    IF l_dis_diagnose = on.
      PERFORM get_field_diagnose USING l_care_unit_list.
    ENDIF.

*   ORGPF_AKT
    IF l_dis_orgpf_akt = on AND l_uex_orgpf_akt = off.
      PERFORM get_field_orgpf_akt USING l_care_unit_list.
    ENDIF.

*   BEH_ARZT
    IF l_dis_beh_arzt      = on AND l_uex_beh_arzt      = off OR
       l_dis_beh_arzt_name = on AND l_uex_beh_arzt_name = off. "ID 8013
      PERFORM get_field_beh_arzt USING l_care_unit_list.
    ENDIF.

*   BEH_ARZT_NAME
    IF l_dis_beh_arzt_name = on AND l_uex_beh_arzt_name = off.
      PERFORM get_field_beh_arzt_name USING l_care_unit_list.
    ENDIF.

*   ANF_ICON
    IF l_dis_anf_icon = on AND l_uex_anf_icon = off.
      PERFORM get_field_anf_icon USING l_care_unit_list.
    ENDIF.

*   KA_ICON
    IF l_dis_ka_icon = on AND l_uex_ka_icon = off.
      PERFORM get_field_ka_icon USING l_care_unit_list.
    ENDIF.

*   PFL_ICON
    IF l_dis_pfl_icon = on AND l_uex_pfl_icon = off.
      PERFORM get_field_pfl_icon USING l_care_unit_list.
    ENDIF.

*   PFLL_ICON                                              (MED-29612)
    IF l_dis_pfll_icon = on AND l_uex_pfll_icon = off.
      PERFORM get_field_pfll_icon USING l_care_unit_list.
    ENDIF.

*   PFLP_ICON
    IF l_dis_pflp_icon = on AND l_uex_pflp_icon = off.
      PERFORM get_field_pflp_icon USING l_care_unit_list.
    ENDIF.

*   EVAL_EXIST_ICON
    IF l_dis_eval_icon = on AND l_uex_eval_icon = off.
      PERFORM get_field_eval_icon USING l_care_unit_list.
    ENDIF.

*   DOK_ICON
    IF l_dis_dok_icon = on AND l_uex_dok_icon = off.
      PERFORM get_field_dok_icon USING l_care_unit_list.
    ENDIF.

*   MEDDOK_ICON                                             (ID 10488)
    IF l_dis_meddok_icon = on AND l_uex_meddok_icon = off.
      PERFORM get_field_meddok_icon USING l_care_unit_list.
    ENDIF.

*   LABDOK_ICON                                             (ID 10488)
    IF l_dis_labdok_icon = on AND l_uex_labdok_icon = off.
      PERFORM get_field_labdok_icon USING l_care_unit_list.
    ENDIF.

*   ICON_DOC
    IF l_dis_icon_doc = on AND l_uex_icon_doc = off.
      PERFORM get_field_icon_doc USING l_care_unit_list.
    ENDIF.

*   INFO_EXIT
    IF l_dis_info_exit = on AND l_uex_info_exit = off.
      PERFORM get_field_info_exit USING l_care_unit_list.
    ENDIF.

*   KG, MED-43708 - Begin
    IF l_dis_chdver_icon = on AND l_uex_chdver_icon = off.
      PERFORM get_field_chdver_icon USING l_care_unit_list.
    ENDIF.
*   KG, MED-43708 - End

*   FATID, DATAG, UZTAG, ORGAG, BAUAG, TRANS, TRAVA_ICON, TRANSTXT,
*   ORGZL, BAUZL, FAT_TPAE, FAT_TPATX, FNAME, FSTATUS
    IF ( l_dis_datag      = on    AND
         l_uex_datag      = off )  OR
       ( l_dis_uztag      = on    AND
         l_uex_uztag      = off )  OR
       ( l_dis_orgag      = on    AND
         l_uex_orgag      = off )  OR
       ( l_dis_bauag      = on    AND
         l_uex_bauag      = off )  OR
       ( l_dis_orgzl      = on    AND
         l_uex_orgzl      = off )  OR
       ( l_dis_bauzl      = on    AND
         l_uex_bauzl      = off )  OR
       ( l_dis_fname      = on    AND
         l_uex_fname      = off )  OR
       ( l_dis_fstatus    = on    AND
         l_uex_fstatus    = off )  OR
       ( l_dis_trans      = on    AND
         l_uex_trans      = off )  OR
       ( l_dis_transtxt   = on    AND
         l_uex_transtxt   = off )  OR
       ( l_dis_trava_icon = on    AND
         l_uex_trava_icon = off )  OR
       ( l_dis_fat_tpatx  = on    AND                       " ID 8961
         l_uex_fat_tpatx  = off )  OR                       " ID 8961
       ( l_dis_fat_tpae   = on    AND
         l_uex_fat_tpae   = off ).
      PERFORM get_fields_fat USING l_care_unit_list.
    ENDIF.

*   BATMP_ICON
    IF l_dis_batmp_icon = on AND l_uex_batmp_icon = off.
      PERFORM get_field_batmp_icon USING l_care_unit_list.
    ENDIF.

*   fill field data from user-exit if requested
    DESCRIBE TABLE lt_vardata.
    IF sy-tfill > 0.
      REFRESH lt_h_vardata.
      lt_h_vardata[] = lt_vardata[].
      MOVE-CORRESPONDING l_care_unit_list TO l_list_head.
      PERFORM call_userexit_disp TABLES  lt_h_vardata
                                         t_selection_criteria
                                 USING   l_list_head
                                         off.           " get data !
      LOOP AT lt_h_vardata INTO l_vardata.
        CASE l_vardata-o_name.
          WHEN 'DIAGNOSE' OR 'DIAGNOSE_STD'.
            l_care_unit_list-diagnose      = l_vardata-n_value.
          WHEN 'ORGPF_AKT'.
            l_care_unit_list-orgpf_akt     = l_vardata-n_value.
          WHEN 'BEH_ARZT'.
            l_care_unit_list-beh_arzt      = l_vardata-n_value.
          WHEN 'BEH_ARZT_NAME'.
            l_care_unit_list-beh_arzt_name = l_vardata-n_value.
          WHEN 'ANF_ICON'.
            l_care_unit_list-anf_icon      = l_vardata-n_value.
          WHEN 'KA_ICON'.
            l_care_unit_list-ka_icon       = l_vardata-n_value.
          WHEN 'PFL_ICON'.
            l_care_unit_list-pfl_icon      = l_vardata-n_value.
          WHEN 'PFLL_ICON'.                                 "MED-29612
            l_care_unit_list-pfll_icon     = l_vardata-n_value. " 29612
          WHEN 'PFLP_ICON'.
            l_care_unit_list-pflp_icon     = l_vardata-n_value.
          WHEN 'EVAL_EXIST_ICON'.
            l_care_unit_list-eval_exist_icon = l_vardata-n_value.
          WHEN 'DOK_ICON'.
            l_care_unit_list-dok_icon      = l_vardata-n_value.
          WHEN 'MEDDOK_ICON'.                               " ID 10488
            l_care_unit_list-meddok_icon   = l_vardata-n_value. " 10488
          WHEN 'LABDOK_ICON'.                               " ID 10488
            l_care_unit_list-labdok_icon   = l_vardata-n_value. " 10488
          WHEN 'ICON_DOC'.
            l_care_unit_list-icon_doc      = l_vardata-n_value.
          WHEN 'INFO_EXIT'.
            l_care_unit_list-info_exit     = l_vardata-n_value.
*          WHEN 'FATID'.
*            l_care_unit_list-fatid         = l_vardata-n_value.
          WHEN 'DATAG'.
            l_care_unit_list-datag         = l_vardata-n_value.
          WHEN 'UZTAG'.
            l_care_unit_list-uztag         = l_vardata-n_value.
          WHEN 'ORGZL'.
            l_care_unit_list-orgzl         = l_vardata-n_value.
          WHEN 'BAUZL'.
            l_care_unit_list-bauzl         = l_vardata-n_value.
          WHEN 'ORGAG'.
            l_care_unit_list-orgag         = l_vardata-n_value.
          WHEN 'BAUAG'.
            l_care_unit_list-bauag         = l_vardata-n_value.
          WHEN 'FAT_TPAE'.
            l_care_unit_list-fat_tpae      = l_vardata-n_value.
          WHEN 'FAT_TPATX'.                                 " ID 8961
            l_care_unit_list-fat_tpatx     = l_vardata-n_value. " 8961
          WHEN 'FNAME'.
            l_care_unit_list-fname         = l_vardata-n_value.
          WHEN 'FSTATUS'.
            l_care_unit_list-fstatus       = l_vardata-n_value.
          WHEN 'BATMP_ICON'.
            l_care_unit_list-batmp_icon    = l_vardata-n_value.
          WHEN OTHERS.
*           customer defined fields
            CONCATENATE 'L_CARE_UNIT_LIST-' l_vardata-o_name
                        INTO l_tab_fieldname.
            ASSIGN (l_tab_fieldname) TO <fieldname>.
            IF sy-subrc = 0.
              <fieldname> = l_vardata-n_value.
            ENDIF.
        ENDCASE.
      ENDLOOP.
    ENDIF.
    "START IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 31/05/2018
    IF l_disp_emar_pending_activity EQ on.

      PERFORM fill_pending_activity CHANGING l_care_unit_list
                                             lr_helper_class.

    ENDIF.

    "END IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 31/05/2018
*   return data
    MODIFY t_care_unit_list FROM l_care_unit_list.

  ENDLOOP.                        " T_CARE_UNIT_LIST

ENDFUNCTION.
