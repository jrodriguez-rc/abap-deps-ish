FUNCTION ishmed_dp_preregistration.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_DISPVAR) TYPE  LVC_T_FCAT
*"  TABLES
*"      T_PREREG_LIST TYPE  ISH_T_PREREG_LIST
*"      T_SELECTION_CRITERIA STRUCTURE  RSPARAMS
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: l_dispvar            TYPE lvc_s_fcat,
        l_med_or_lab         TYPE ish_on_off,               " ID 10488
        l_pat                TYPE ty_pat,
        l_pap                TYPE ty_pap,                   "MED-34000
        l_fal                TYPE ty_fal,
        l_vkg                TYPE ty_vkg.
  DATA: lt_falar             TYPE TABLE OF ty_fal,
        l_falar              TYPE ty_fal.
  DATA: l_dis_afnoeakt       LIKE off,
        l_dis_visoeakt       LIKE off,
        l_dis_icon_anf       LIKE off,
        l_dis_icon_doc       LIKE off,
        l_dis_meddok_icon    LIKE off,                      " ID 10488
        l_dis_labdok_icon    LIKE off,                      " ID 10488
        l_dis_vklei          LIKE off,
        l_dis_lktar          LIKE off,
        l_dis_lklst          LIKE off,
        l_dis_lkbez          LIKE off,
        l_dis_vkleilok       LIKE off,
*        l_dis_risk_icon      LIKE off,                      " ID 11887
        l_dis_vkleibez       LIKE off,                      " ID 10562
        l_dis_preregro       LIKE off,                      " ID 10792
        l_dis_preregrosn     LIKE off,                      " ID 10792
        l_dis_preregdr       LIKE off,                      " ID 10792
        l_dis_aprie          LIKE off,                      " ID 18836
        l_dis_apritxt        LIKE off,                      " ID 18836
        l_dis_cposquest      LIKE off,                      " MED-34502
        l_dis_status         LIKE off,
        l_dis_trtgp          LIKE off,
        l_dis_trtgp_txt      LIKE off.

  DATA: l_ishmed_active      LIKE off.

* Prüfen, ob ISHMED aktiv ist.
  l_ishmed_active = on.
  CALL FUNCTION 'ISHMED_AUTHORITY'
    EXCEPTIONS
      ishmed_not_activ = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
    l_ishmed_active = off.
  ENDIF.

  CHECK l_ishmed_active = on.

  CLEAR:   t_messages, gt_pat, gt_pap, gt_fal, gt_vkg, gt_lem, gt_lei,
           gt_dok, gt_anf, gt_cord_pat, gt_cord_pap, gt_tmn, gt_bew. "MED-34000
  REFRESH: t_messages, gt_pat, gt_pap, gt_fal, gt_vkg, gt_lem, gt_lei,
           gt_dok, gt_anf, gt_cord_pat, gt_cord_pap, gt_tmn, gt_bew. "MED-34000

  CALL FUNCTION 'STATUS_BUFFER_REFRESH'.                    " ID 17440

* ---------------------------------------------------------------------
* get selection criteria for preregistration list
* ---------------------------------------------------------------------
  CLEAR: g_institution.

  LOOP AT t_selection_criteria.
    CASE t_selection_criteria-selname.
      WHEN 'SE_EINRI'.
        g_institution     = t_selection_criteria-low.
        EXIT.
    ENDCASE.
  ENDLOOP.

* check obligatory selection criteria
  CHECK NOT g_institution IS INITIAL.

* ---------------------------------------------------------------------
* check display variant for ISHMED fields to be displayed
* ---------------------------------------------------------------------
  CLEAR: l_dis_afnoeakt,    l_dis_visoeakt,    l_dis_icon_anf,
         l_dis_icon_doc,    l_dis_vklei,       l_dis_lktar,
         l_dis_meddok_icon, l_dis_labdok_icon, l_dis_vkleilok,
         l_dis_lklst,       l_dis_lkbez,       l_dis_vkleibez,
         l_dis_status,      l_dis_trtgp,       l_dis_trtgp_txt,
         l_dis_preregro,    l_dis_preregrosn,  l_dis_preregdr,
         l_dis_cposquest.

  LOOP AT i_dispvar INTO l_dispvar WHERE no_out IS INITIAL.
    CASE l_dispvar-fieldname.
      WHEN 'AFNOEAKT' OR 'AFNOEAKT_K' OR 'AFNOEAKT_KB'.     " MED-34600 chg
        l_dis_afnoeakt      = on.
      WHEN 'VISOEAKT' OR 'VISOEAKT_K' OR 'VISOEAKT_KB'.     " MED-34600 chg
        l_dis_visoeakt      = on.
      WHEN 'ICON_ANF'.
        l_dis_icon_anf      = on.
      WHEN 'ICON_DOC'.
        l_dis_icon_doc      = on.
      WHEN 'MEDDOK_ICON'.                                   " ID 10488
        l_dis_meddok_icon   = on.                           " ID 10488
      WHEN 'LABDOK_ICON'.                                   " ID 10488
        l_dis_labdok_icon   = on.                           " ID 10488
      WHEN 'VKLEI'.
        l_dis_vklei         = on.
      WHEN 'LKTAR'.
        l_dis_lktar         = on.
      WHEN 'LKLST'.
        l_dis_lklst         = on.
      WHEN 'LKBEZ'.
        l_dis_lkbez         = on.
      WHEN 'VKLEILOK'.
        l_dis_vkleilok      = on.
*      WHEN 'RISK_ICON'.                                     " ID 11887
*        l_dis_risk_icon     = on.                           " ID 11887
      WHEN 'VKLEIBEZ'.                                      " ID 10562
        l_dis_vkleibez      = on.                           " ID 10562
      WHEN 'PREREGRO'.
        l_dis_preregro      = on.
      WHEN 'PREREGROSN'.
        l_dis_preregrosn    = on.
      WHEN 'PREREGDR'.
        l_dis_preregdr      = on.
      WHEN 'APRIE'.                                         " ID 18836
        l_dis_aprie         = on.                           " ID 18836
      WHEN 'APRITXT'.                                       " ID 18836
        l_dis_apritxt       = on.                           " ID 18836
      WHEN 'CPOSQUEST'.                                     " MED-34502
        l_dis_cposquest     = on.                           " MED-34502
      WHEN 'STATUS' OR 'STATUS_TEXT'.
        l_dis_status        = on.
      WHEN 'TRTGP'.
        l_dis_trtgp         = on.
      WHEN 'TRTGP_TXT'.
        l_dis_trtgp_txt     = on.
      WHEN OTHERS.
    ENDCASE.
  ENDLOOP.

* ---------------------------------------------------------------------
* fill global tables with all patients/cases/preregistrations
* ---------------------------------------------------------------------
  LOOP AT t_prereg_list where no_tc_icon is initial. " note 3001083
    IF NOT t_prereg_list-patnr IS INITIAL.
      READ TABLE gt_pat INTO l_pat
                 WITH TABLE KEY patnr = t_prereg_list-patnr.
      IF sy-subrc <> 0.
        l_pat-patnr = t_prereg_list-patnr.
        l_pat-einri = g_institution.
        INSERT l_pat INTO TABLE gt_pat.
      ENDIF.
    ENDIF.
*   BEGIN MED-34000
    IF NOT t_prereg_list-papid IS INITIAL.
      READ TABLE gt_pap INTO l_pap
                 WITH TABLE KEY papid = t_prereg_list-papid.
      IF sy-subrc <> 0.
        l_pap-papid = t_prereg_list-papid.
        l_pap-einri = g_institution.
        INSERT l_pap INTO TABLE gt_pap.
      ENDIF.
    ENDIF.
*   END MED-34000
    IF NOT t_prereg_list-falnr IS INITIAL.
      READ TABLE gt_fal INTO l_fal
                 WITH TABLE KEY falnr = t_prereg_list-falnr.
      IF sy-subrc <> 0.
        l_fal-falnr = t_prereg_list-falnr.
        l_fal-einri = g_institution.
        l_fal-vkgid = t_prereg_list-vkgid.
        INSERT l_fal INTO TABLE gt_fal.
      ENDIF.
    ENDIF.
    IF NOT t_prereg_list-vkgid IS INITIAL.
      l_vkg-vkgid  = t_prereg_list-vkgid.
*      l_vkg-apcnid = t_prereg_list-apcnid.  " dzt. noch nicht drinn!
      INSERT l_vkg INTO TABLE gt_vkg.
    ENDIF.
  ENDLOOP.
  DESCRIBE TABLE gt_vkg.
  CHECK sy-tfill > 0.

* BEGIN MED-34000
  DELETE ADJACENT DUPLICATES FROM gt_pat COMPARING patnr.
  DELETE ADJACENT DUPLICATES FROM gt_pap COMPARING papid.
* END MED-34000

* read additional case info (FALAR) if AFNOEAKT is requested
  DESCRIBE TABLE gt_fal.
  IF sy-tfill > 0.
    IF l_dis_afnoeakt = on.
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
  ENDIF.

* ---------------------------------------------------------------------
* get global information for all requested medical fields
* ---------------------------------------------------------------------

* ANF_ICON
  IF l_dis_icon_anf = on.
    PERFORM fill_table_anf.
    PERFORM get_icon USING '001' CHANGING g_anf_icon.
  ENDIF.

* DOK_ICON
  IF l_dis_icon_doc    = on OR
     l_dis_meddok_icon = on OR                              " ID 10488
     l_dis_labdok_icon = on.                                " ID 10488
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

* VISOEAKT, PREREGRO, PREREGROSN, PREREGDR, STATUS, STATUS_TEXT,
* TRTGP, TRTGP_TXT
  IF l_dis_visoeakt   = on OR
     l_dis_afnoeakt   = on OR    "MED-54431 Cristina Geanta 05.03.2014
     l_dis_preregro   = on OR                               " ID 12821
     l_dis_preregrosn = on OR                               " ID 12821
     l_dis_preregdr   = on OR                               " ID 12821
     l_dis_status     = on OR
     l_dis_trtgp      = on OR
     l_dis_trtgp_txt  = on.
    PERFORM fill_table_tmn.
  ENDIF.

* VISOEAKT, AFNOEAKT
  IF l_dis_afnoeakt = on.
    PERFORM fill_table_bew USING on.    " get all movements for cases
  ELSEIF l_dis_visoeakt = on.
    PERFORM fill_table_bew USING off.   " get only movem. for appointm.
  ENDIF.

** RISK_ICON    REM for OSS 142809 2006 (filled by IS-H)    " ID 11887
*  IF l_dis_risk_icon = on.
*    PERFORM fill_table_nrsf.
*    PERFORM get_icon USING '006' CHANGING g_risk_icon.
*  ENDIF.

* VISOEAKT, VKLEI, LKTAR, LKLST, LKBEZ, VKLEIBEZ, VKLEILOK
  IF l_dis_visoeakt   = on OR
     l_dis_vklei      = on OR
     l_dis_lktar      = on OR
     l_dis_lklst      = on OR
     l_dis_lkbez      = on OR
     l_dis_vkleilok   = on OR
     l_dis_vkleibez   = on.                                 " ID 10562
    PERFORM fill_table_nlem.
  ENDIF.

* CPOSQUEST (MED-34502)
  IF l_dis_cposquest = on.
    PERFORM fill_table_n1compa.
  ENDIF.

* ---------------------------------------------------------------------
* loop over all preregistrations to get field data if requested
* ---------------------------------------------------------------------
  LOOP AT t_prereg_list.

*   ANF_ICON
    IF l_dis_icon_anf = on.
      PERFORM get_field_anf_icon USING t_prereg_list.
    ENDIF.

*   ICON_DOC
    IF l_dis_icon_doc = on.
      PERFORM get_field_icon_doc USING t_prereg_list.
    ENDIF.

*   MEDDOK_ICON                                             (ID 10488)
    IF l_dis_meddok_icon = on.
      PERFORM get_field_meddok_icon USING t_prereg_list.
    ENDIF.

*   LABDOK_ICON                                             (ID 10488)
    IF l_dis_labdok_icon = on.
      PERFORM get_field_labdok_icon USING t_prereg_list.
    ENDIF.

**   RISK_ICON                                               (ID 11887)
*    IF l_dis_risk_icon = on.
*      PERFORM get_field_risk_icon USING t_prereg_list.
*    ENDIF.

*   AFNOEAKT
    IF l_dis_afnoeakt = on.
      PERFORM get_field_afnoe_akt USING t_prereg_list.
    ENDIF.

*   VISOEAKT
    IF l_dis_visoeakt = on.
      PERFORM get_field_visoe_akt USING t_prereg_list.
    ENDIF.

*   VKLEI, VKLEIBEZ, VKLEILOK
    IF l_dis_vklei    = on OR
       l_dis_vkleibez = on OR
       l_dis_vkleilok = on.
      PERFORM get_field_vklei USING t_prereg_list.
    ENDIF.

*   LKTAR, LKLST, LKBEZ
    IF l_dis_lktar = on OR
       l_dis_lklst = on OR
       l_dis_lkbez = on.
      PERFORM get_field_lktar USING t_prereg_list.
    ENDIF.

*   PREREGRO, PREREGROSN, PREREGDR (ID 10792)
    IF l_dis_preregro   = on OR
       l_dis_preregrosn = on OR
       l_dis_preregdr   = on.
      PERFORM get_field_preregro USING t_prereg_list.
    ENDIF.

*   APRIE, APRITXT (ID 18836)
    IF l_dis_aprie   = on OR
       l_dis_apritxt = on.
      PERFORM get_field_aprie USING t_prereg_list.
    ENDIF.

*   STATUS, STATUS_TEXT
    IF l_dis_status = on.
      PERFORM get_field_status USING t_prereg_list.
    ENDIF.

*   TRTGP
    IF l_dis_trtgp = on.
      PERFORM get_field_trtgp USING t_prereg_list.
    ENDIF.

*   TRTGP_TXT
    IF l_dis_trtgp_txt = on.
      PERFORM get_field_trtgp_txt USING t_prereg_list.
    ENDIF.

*   CPOSQUEST (MED-34502)
    IF l_dis_cposquest = on.
      PERFORM get_field_cposquest USING t_prereg_list.
    ENDIF.

*   return data
    MODIFY t_prereg_list.

  ENDLOOP.                        " T_PREREG_LIST

ENDFUNCTION.
