*----------------------------------------------------------------------*
***INCLUDE LN1_WP_010F02 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  fill_table_anf
*&---------------------------------------------------------------------*
FORM fill_table_anf.

*  DATA: l_pat    TYPE ty_pat.                        "REM MED-34000

  REFRESH gt_anf.
  REFRESH: gt_cord_pat, gt_cord_pap.                        "MED-34000
  DESCRIBE TABLE gt_pat.
*  CHECK sy-tfill > 0.                                "REM MED-34000
  IF sy-tfill > 0.                                          "MED-34000
*   get request information
    SELECT patnr FROM n1anf INTO TABLE gt_anf
        FOR ALL ENTRIES IN gt_pat
        WHERE einri EQ gt_pat-einri
          AND patnr EQ gt_pat-patnr
          AND storn EQ off.

*   select clinical orders
    SELECT patnr FROM n1corder INTO TABLE gt_cord_pat
           FOR ALL ENTRIES IN gt_pat
           WHERE  patnr  = gt_pat-patnr
             AND  storn  = off.                             "MED-34000
  ENDIF.                                                    "MED-34000
  DESCRIBE TABLE gt_pap.                                    "MED-34000
  IF sy-tfill > 0.                                          "MED-34000
    SELECT papid FROM n1corder INTO TABLE gt_cord_pap
           FOR ALL ENTRIES IN gt_pap
           WHERE  papid  = gt_pap-papid
             AND  storn  = off.                             "MED-34000
  ENDIF.                                                    "MED-34000

ENDFORM.                    " fill_table_anf
*&---------------------------------------------------------------------*
*&      Form  get_icon
*&---------------------------------------------------------------------*
FORM get_icon USING    value(p_indicator)    LIKE nwicons-col_indicator
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
*&      Form  fill_table_dok
*&---------------------------------------------------------------------*
FORM fill_table_dok USING value(p_med_or_lab)  TYPE ish_on_off.

  DATA: l_fal     TYPE ty_fal,
        l_dok     LIKE LINE OF gt_dok,
        lt_dok    LIKE gt_dok,
        l_dok_tmp LIKE LINE OF lt_dok.

  RANGES: r_medok FOR ndoc-medok.

* get document information
  REFRESH gt_dok.

  DESCRIBE TABLE gt_pat.
  CHECK sy-tfill > 0.

* Rangetab der Dokarten befüllen
  CLEAR r_medok.  REFRESH r_medok.
  r_medok-sign   = 'I'.
  r_medok-option = 'EQ'.
  r_medok-low    = 'X'.                " Medizinische Dokumente
  APPEND r_medok.                      " UND
  r_medok-low    = 'L'.                " Laborbefunde
  APPEND r_medok.

* get documents for patients
  SELECT patnr medok FROM ndoc
         APPENDING TABLE gt_dok
         FOR ALL ENTRIES IN gt_pat
         WHERE einri EQ gt_pat-einri
           AND patnr EQ gt_pat-patnr
           AND storn EQ off
           AND loekz EQ off
           AND medok IN r_medok.

* ID 10488: Med.Dok.-Kz und Lab.Dok.-Kz in der Tabelle befüllen
  IF p_med_or_lab = on.
    lt_dok[] = gt_dok[].
    LOOP AT gt_dok INTO l_dok.
      LOOP AT lt_dok INTO l_dok_tmp WHERE patnr = l_dok-patnr.
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

  DELETE ADJACENT DUPLICATES FROM gt_dok COMPARING patnr.

ENDFORM.                    " fill_table_dok
*&---------------------------------------------------------------------*
*&      Form  fill_table_nlem
*&---------------------------------------------------------------------*
FORM fill_table_nlem.

  DATA: ls_lei     TYPE ty_lei,
        ls_ntpt    TYPE ntpt.

  DATA: nlei_index TYPE sy-tabix.

* get services for all preregistrations
  REFRESH gt_lem.
  REFRESH gt_lei.

  SELECT vkgid lnrls sortleist tmnid lslok FROM nlem INTO TABLE gt_lem
         FOR ALL ENTRIES IN gt_vkg
         WHERE vkgid = gt_vkg-vkgid
           AND ankls = space.

  DESCRIBE TABLE gt_lem.
  CHECK sy-tfill > 0.

  SELECT lnrls leist haust storn einri leitx FROM nlei
         INTO TABLE gt_lei
         FOR ALL ENTRIES IN gt_lem
         WHERE lnrls = gt_lem-lnrls.

  CLEAR: nlei_index.
  LOOP AT gt_lei INTO ls_lei.
    nlei_index = sy-tabix.
    IF ls_lei-leitx IS INITIAL.
      CLEAR ls_ntpt.
      CALL FUNCTION 'ISH_READ_NTPT'
        EXPORTING
          einri     = ls_lei-einri
          talst     = ls_lei-leist
          tarif     = ls_lei-haust
        IMPORTING
          e_ntpt    = ls_ntpt
        EXCEPTIONS
          not_found = 1
          OTHERS    = 2.
      IF sy-subrc = 0.
        ls_lei-leitx = ls_ntpt-ktxt1.
        MODIFY gt_lei FROM ls_lei INDEX nlei_index TRANSPORTING leitx.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " fill_table_nlem
*&---------------------------------------------------------------------*
*&      Form  fill_table_tmn
*&---------------------------------------------------------------------*
FORM fill_table_tmn.

  DATA: lt_vkg              TYPE TABLE OF ty_vkg,
        lt_vkg_apcn         TYPE TABLE OF ty_vkg,
        l_vkg_apcn          LIKE LINE OF lt_vkg_apcn,
        l_vkg               LIKE LINE OF gt_vkg.

* get appointments for all preregistrations
  CLEAR gt_tmn. REFRESH gt_tmn.

  REFRESH: lt_vkg, lt_vkg_apcn.

  CHECK NOT gt_vkg[] IS INITIAL.

* get appointment constraints for order positions first
  lt_vkg[] = gt_vkg[].
  DELETE lt_vkg WHERE NOT apcnid IS INITIAL.

  IF NOT lt_vkg[] IS INITIAL.
    SELECT vkgid apcnid objnr trtgp FROM n1vkg INTO TABLE lt_vkg_apcn
           FOR ALL ENTRIES IN lt_vkg
           WHERE  vkgid  = lt_vkg-vkgid.
    IF sy-subrc = 0.
      LOOP AT gt_vkg INTO l_vkg WHERE apcnid IS INITIAL.
        READ TABLE lt_vkg_apcn INTO l_vkg_apcn
                   WITH KEY vkgid = l_vkg-vkgid.
        CHECK sy-subrc = 0.
        l_vkg-apcnid = l_vkg_apcn-apcnid.
        l_vkg-objnr  = l_vkg_apcn-objnr.
        l_vkg-trtgp  = l_vkg_apcn-trtgp.
        MODIFY gt_vkg FROM l_vkg.
      ENDLOOP.
    ENDIF.
  ENDIF.

* get appointments for appointment constraints now
  REFRESH lt_vkg.
  lt_vkg[] = gt_vkg[].
  DELETE lt_vkg WHERE apcnid IS INITIAL.
  IF NOT lt_vkg[] IS INITIAL.
*    SELECT apcnid tmnid falnr tmnlb FROM ntmn INTO TABLE gt_tmn      "MED-54431 Cristina G
    SELECT apcnid tmnid falnr tmnlb tmnoe FROM ntmn INTO TABLE gt_tmn "MED-54431 Cristina G
           FOR ALL ENTRIES IN lt_vkg
           WHERE  apcnid  = lt_vkg-apcnid
           AND    storn   = off.
  ENDIF.

ENDFORM.                    " fill_table_tmn
*&---------------------------------------------------------------------*
*&      Form  fill_table_bew
*&---------------------------------------------------------------------*
FORM fill_table_bew USING value(p_all_for_case)   TYPE ish_on_off.

  DATA: lt_tmn      TYPE TABLE OF ty_tmn.

  REFRESH gt_bew.

  IF p_all_for_case = on.
*   get all movements for all cases
    DESCRIBE TABLE gt_fal.
    IF sy-tfill > 0.
      SELECT einri falnr lfdnr bewty orgpf orgfa storn planb bwidt bwizt
                FROM nbew INTO TABLE gt_bew
                FOR ALL ENTRIES IN gt_fal
                WHERE  einri  = gt_fal-einri
                AND    falnr  = gt_fal-falnr.
    ENDIF.
  ELSE.
*   get only admission movements for all preregistration appointments
    DESCRIBE TABLE gt_tmn.
    IF sy-tfill > 0.
      REFRESH lt_tmn.
      lt_tmn[] = gt_tmn[].
      DELETE lt_tmn WHERE tmnlb IS INITIAL.
      DESCRIBE TABLE lt_tmn.
      IF sy-tfill > 0.
        SELECT einri falnr lfdnr bewty orgpf orgfa
               storn planb bwidt bwizt
               FROM nbew INTO TABLE gt_bew
               FOR ALL ENTRIES IN lt_tmn
               WHERE  einri  = g_institution
               AND    falnr  = lt_tmn-falnr
               AND    lfdnr  = lt_tmn-tmnlb
               AND    bewty  = '4'            " Aufnahme-/Besuchstermin
               AND    storn  = off.
      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.                    " fill_table_bew
*&---------------------------------------------------------------------*
*&      Form  fill_table_n1compa
*&---------------------------------------------------------------------*
FORM fill_table_n1compa.

  DATA: lt_vkg              TYPE TABLE OF ty_vkg,
        lt_vkg_apcn         TYPE TABLE OF ty_vkg,
        l_vkg_apcn          LIKE LINE OF lt_vkg_apcn,
        l_vkg               LIKE LINE OF gt_vkg.

* get order position data
  CLEAR gt_n1compa. REFRESH gt_n1compa.

  CHECK NOT gt_vkg[] IS INITIAL.

  SELECT * FROM n1compa INTO TABLE gt_n1compa
           FOR ALL ENTRIES IN gt_vkg
           WHERE  vkgid  = gt_vkg-vkgid
             AND  compid = cl_ishmed_comp_cpos_question=>co_compid.

  SORT gt_n1compa BY vkgid.

ENDFORM.                    " fill_table_n1compa
*&---------------------------------------------------------------------*
*&      Form  fill_table_nrsf
*&---------------------------------------------------------------------*
*       Risikofaktoren zu allen Patienten einlesen          ID 11887
*----------------------------------------------------------------------*
*FORM fill_table_nrsf .
*
** get risk information
*  REFRESH gt_nrsf.
*
*  DESCRIBE TABLE gt_pat.
*  CHECK sy-tfill > 0.
*
*  SELECT patnr FROM nrsf INTO TABLE gt_nrsf
*                         FOR ALL ENTRIES IN gt_pat
*                         WHERE patnr = gt_pat-patnr
*                           AND loekz = off.
*
*ENDFORM.                    " fill_table_nrsf
*&---------------------------------------------------------------------*
*&      Form  get_field_anf_icon
*&---------------------------------------------------------------------*
FORM get_field_anf_icon USING p_bew TYPE rnwp_prereg_list.

*  DATA: l_anf      TYPE ty_anf.                              "REM MED-34000

* check if there are clinical orders or requests for that patient "MED-34000
  CLEAR p_bew-icon_anf.                                     "MED-34000

*  CHECK NOT p_bew-patnr IS INITIAL.      "REM MED-34000
  IF NOT p_bew-patnr IS INITIAL.                            "MED-34000
*   BEGIN BM MED-34000
    READ TABLE gt_cord_pat WITH TABLE KEY patnr = p_bew-patnr
                         TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      p_bew-icon_anf = g_anf_icon.
      EXIT.
    ENDIF.
*   END BM MED-34000

*  READ TABLE gt_anf INTO l_anf WITH TABLE KEY patnr = p_bew-patnr "REM MED-34000
    READ TABLE gt_anf WITH TABLE KEY patnr = p_bew-patnr
                          TRANSPORTING NO FIELDS.           "MED-34000
    IF sy-subrc = 0.
      p_bew-icon_anf = g_anf_icon.
    ENDIF.
* BEGIN MED-34000
  ELSEIF NOT p_bew-papid IS INITIAL.                        "MED-34000
    READ TABLE gt_cord_pap WITH TABLE KEY papid = p_bew-papid
                         TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      p_bew-icon_anf = g_anf_icon.
      EXIT.
    ENDIF.
  ENDIF.
* END MED-34000
ENDFORM.                               " GET_FIELD_ANF_ICON
*&---------------------------------------------------------------------*
*&      Form  get_field_icon_doc
*&---------------------------------------------------------------------*
FORM get_field_icon_doc USING p_bew TYPE rnwp_prereg_list.

  DATA: l_dok        TYPE ty_dok.

  CHECK NOT p_bew-patnr IS INITIAL.

  READ TABLE gt_dok INTO l_dok WITH TABLE KEY patnr = p_bew-patnr.
  IF sy-subrc = 0.
    p_bew-icon_doc = g_dok_icon.
  ENDIF.

ENDFORM.                    " get_field_icon_doc

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_MEDDOK_ICON                         ID 10488
*&---------------------------------------------------------------------*
FORM get_field_meddok_icon USING p_bew TYPE rnwp_prereg_list.

  DATA: l_dok   TYPE ty_dok.

* check if there are medical documents for that patient
  CLEAR p_bew-meddok_icon.

  CHECK NOT p_bew-patnr IS INITIAL.

  READ TABLE gt_dok INTO l_dok WITH TABLE KEY patnr = p_bew-patnr.
  IF sy-subrc = 0 AND l_dok-meddok = on.
    p_bew-meddok_icon = g_meddok_icon.
  ENDIF.

ENDFORM.                               " GET_FIELD_MEDDOK_ICON

*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_LABDOK_ICON                         ID 10488
*&---------------------------------------------------------------------*
FORM get_field_labdok_icon USING p_bew TYPE rnwp_prereg_list.

  DATA: l_dok   TYPE ty_dok.

* check if there are labor documents for that patient
  CLEAR p_bew-labdok_icon.

  CHECK NOT p_bew-patnr IS INITIAL.

  READ TABLE gt_dok INTO l_dok WITH TABLE KEY patnr = p_bew-patnr.
  IF sy-subrc = 0 AND l_dok-labdok = on.
    p_bew-labdok_icon = g_labdok_icon.
  ENDIF.

ENDFORM.                               " GET_FIELD_LABDOK_ICON

*&---------------------------------------------------------------------*
*&      Form  get_field_afnoe_akt
*&---------------------------------------------------------------------*
FORM get_field_afnoe_akt USING p_bew TYPE rnwp_prereg_list.

  DATA: l_help_oe   LIKE norg-orgid,
        l_akt_bew   LIKE nbew,
        lt_nbew     LIKE TABLE OF nbew,
        l_nbew      LIKE nbew,
        l_bew       TYPE ty_bew,
        l_nfal      LIKE nfal,
        l_fal       TYPE ty_fal.

  FIELD-SYMBOLS: <fs_vkg> TYPE ty_vkg, "MED-54431 Cristina Geanta
                 <fs_tmn> TYPE ty_tmn. "MED-54431 Cristina Geanta

* get acutal treat. OU of the case (OE wo Patient aktuell liegt)
  CLEAR:   p_bew-afnoeakt,
           l_akt_bew, l_help_oe, l_fal, l_nfal, l_bew, l_nbew.
  REFRESH: lt_nbew.

* MED-54431 Cristina Geanta 05.03.2014
* Get planned admissions and preregistrated appointments
  READ TABLE gt_bew INTO l_bew WITH KEY falnr = p_bew-falnr
                                        storn = ' '.
  IF l_bew-orgpf IS INITIAL OR sy-subrc NE 0.
    READ TABLE gt_vkg ASSIGNING <fs_vkg> WITH KEY vkgid = p_bew-vkgid.
    CHECK sy-subrc = 0.

    READ TABLE gt_tmn ASSIGNING <fs_tmn> WITH KEY apcnid = <fs_vkg>-apcnid.
    IF sy-subrc = 0.
      p_bew-afnoeakt = <fs_tmn>-tmnoe.
      CALL METHOD cl_ish_utl_base_descr=>get_descr_orgunit
        EXPORTING
          i_einri = g_institution
          i_orgid = p_bew-afnoeakt
        IMPORTING
          e_orgkb = p_bew-afnoeakt_kb
          e_okurz = p_bew-afnoeakt_k.
    ENDIF.
  ELSE.
* END MED-54431 Cristina Geanta 05.03.2014

    CHECK NOT p_bew-falnr IS INITIAL.

* get actual admission
* get case
  READ TABLE gt_fal INTO l_fal WITH TABLE KEY falnr = p_bew-falnr.
  CHECK sy-subrc = 0.
  MOVE-CORRESPONDING l_fal TO l_nfal.

* get all movements for that case
  LOOP AT gt_bew INTO l_bew WHERE einri = g_institution
                              AND falnr = p_bew-falnr.
    CLEAR l_nbew.
    MOVE-CORRESPONDING l_bew TO l_nbew.
    APPEND l_nbew TO lt_nbew.
  ENDLOOP.
  DESCRIBE TABLE lt_nbew.
  IF sy-tfill = 0.
    SELECT * FROM nbew INTO TABLE lt_nbew
           WHERE  einri  = g_institution
           AND    falnr  = p_bew-falnr.
  ENDIF.

  CALL FUNCTION 'ISHMED_SEARCH_ORGFA'
    EXPORTING
      i_falnr       = p_bew-falnr
      i_einri       = g_institution
      i_orgpf       = l_help_oe  " dummy
      i_nfal        = l_nfal
*     CDuerr, MED-39031 - Begin
*      i_no_planb    = 'X'  " keine Planbewegungen ID 6872
      i_no_planb    = ' '
*     CDuerr, MED-39031 - End
    IMPORTING
      e_nbew        = l_akt_bew
    TABLES
      t_nbew        = lt_nbew
    EXCEPTIONS
      no_valid_nfal = 1
      no_valid_nbew = 2
      OTHERS        = 3.
  IF sy-subrc = 0.
    p_bew-afnoeakt = l_akt_bew-orgpf.
    CALL METHOD cl_ish_utl_base_descr=>get_descr_orgunit    " MED-34600
      EXPORTING
        i_einri = g_institution
        i_orgid = p_bew-afnoeakt
      IMPORTING
        e_orgkb = p_bew-afnoeakt_kb
        e_okurz = p_bew-afnoeakt_k.
  ENDIF.

  ENDIF. "MED-54431 Cristina Geanta 05.03.2014

ENDFORM.                    " get_field_afnoe_akt
*&---------------------------------------------------------------------*
*&      Form  GET_FIELD_RISK_ICON                             ID 11887
*&---------------------------------------------------------------------*
*FORM get_field_risk_icon USING p_bew TYPE rnwp_prereg_list.
*
*  DATA: l_nrsf   TYPE ty_nrsf.
*
** check if there are risk informations for that patient
*  CLEAR p_bew-risk_icon.
*
*  CHECK NOT p_bew-patnr IS INITIAL.
*
*  READ TABLE gt_nrsf INTO l_nrsf WITH TABLE KEY patnr = p_bew-patnr.
*  IF sy-subrc = 0.
*    p_bew-risk_icon = g_risk_icon.
*  ENDIF.
*
*ENDFORM.                               " GET_FIELD_RISK_ICON
*&---------------------------------------------------------------------*
*&      Form  get_field_VKLEI
*&---------------------------------------------------------------------*
FORM get_field_vklei USING p_bew TYPE rnwp_prereg_list.

  DATA: l_lem        LIKE LINE OF gt_lem,
        l_lei        LIKE LINE OF gt_lei.
  DATA: l_zaehler    TYPE i.

  l_zaehler = 0.

  LOOP AT gt_lem INTO l_lem WHERE vkgid = p_bew-vkgid.
    READ TABLE gt_lei INTO l_lei
               WITH TABLE KEY lnrls = l_lem-lnrls.
*  Stornierte Leistungen sollen nicht mehr angezeigt werden.
    CHECK sy-subrc = 0 AND l_lei-storn = ' '.               "ID 11580

    SHIFT l_lei-leist LEFT DELETING LEADING '0'.    "ID 10562/21.10.2002
    IF l_lem-lslok IS INITIAL.
      l_lem-lslok = '-'.
    ENDIF.

    l_zaehler = l_zaehler + 1.
    IF sy-subrc = 0.
      IF l_zaehler = 1.
        p_bew-vklei    = l_lei-leist.
        p_bew-vkleibez = l_lei-leitx.
        p_bew-vkleilok = l_lem-lslok.
      ELSE.
        CONCATENATE p_bew-vklei ', ' INTO p_bew-vklei.
        CONCATENATE p_bew-vklei l_lei-leist
                  INTO p_bew-vklei SEPARATED BY space.
        CONCATENATE p_bew-vkleibez ', ' INTO p_bew-vkleibez.
        CONCATENATE p_bew-vkleibez l_lei-leitx
                  INTO p_bew-vkleibez SEPARATED BY space.
        IF l_lem-lslok IS NOT INITIAL.
          CONCATENATE p_bew-vkleilok ', ' INTO p_bew-vkleilok.
          CONCATENATE p_bew-vkleilok l_lem-lslok
                    INTO p_bew-vkleilok SEPARATED BY space.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDLOOP.
  IF p_bew-vkleilok CO ' ,-'.
    CLEAR p_bew-vkleilok.
  ENDIF.

ENDFORM.                    " get_field_VKLEI
*&---------------------------------------------------------------------*
*&      Form  get_field_LKTAR
*&---------------------------------------------------------------------*
FORM get_field_lktar USING p_bew TYPE rnwp_prereg_list.

  DATA: l_lem             LIKE LINE OF gt_lem,
        l_lei             LIKE LINE OF gt_lei,
        l_nlem            TYPE nlem,
        l_nlei            TYPE nlei,
        lt_nlem           TYPE TABLE OF nlem,
        lt_nlei           TYPE TABLE OF nlei,
        l_lktar           TYPE ntpk-tarif,
        l_lklst           TYPE ntpk-talst,
        l_lkbez           TYPE ntpt-ktxt1,
        l_n1vkg           TYPE n1vkg.

  STATICS: l_zotyp        TYPE ntpz-zotyp.

  CLEAR:   l_lktar, l_lklst, l_lkbez, l_n1vkg.
  REFRESH: lt_nlem, lt_nlei.

  LOOP AT gt_lem INTO l_lem WHERE vkgid = p_bew-vkgid.
    READ TABLE gt_lei INTO l_lei WITH TABLE KEY lnrls = l_lem-lnrls.
    CHECK sy-subrc = 0.
    CLEAR: l_nlem, l_nlei.
    MOVE-CORRESPONDING l_lei TO l_nlei.
    MOVE-CORRESPONDING l_lem TO l_nlem.
    APPEND l_nlei TO lt_nlei.
    APPEND l_nlem TO lt_nlem.
  ENDLOOP.

  IF l_zotyp IS INITIAL.
    PERFORM ren00q(sapmnpa0) USING g_institution 'N1LKPZUO' l_zotyp.
  ENDIF.

  l_n1vkg-vkgid = p_bew-vkgid.

  CALL FUNCTION 'ISHMED_VKG_KLASSE'
    EXPORTING
      i_einri = g_institution
      i_zotyp = l_zotyp
      i_vkg   = l_n1vkg
    IMPORTING
      e_kltar = l_lktar
      e_kllst = l_lklst
      e_klbez = l_lkbez
    TABLES
      ti_nlei = lt_nlei
      ti_nlem = lt_nlem.

  p_bew-lktar = l_lktar.
  p_bew-lklst = l_lklst.
  p_bew-lkbez = l_lkbez.

ENDFORM.                    " get_field_LKTAR
*&---------------------------------------------------------------------*
*&      Form  get_field_visoe_akt
*&---------------------------------------------------------------------*
FORM get_field_visoe_akt USING p_bew TYPE rnwp_prereg_list.

  DATA:   l_bew     LIKE LINE OF gt_bew,
          l_tmn     LIKE LINE OF gt_tmn,
          l_vkg     LIKE LINE OF gt_vkg.

  CLEAR:  l_bew, l_tmn, l_vkg.

* Prüfen, ob für die Vormerkung ein Besuchstermin vorhanden ist
  READ TABLE gt_vkg INTO l_vkg WITH TABLE KEY vkgid = p_bew-vkgid.
  CHECK sy-subrc = 0 AND NOT l_vkg-apcnid IS INITIAL.
  READ TABLE gt_tmn INTO l_tmn WITH TABLE KEY apcnid = l_vkg-apcnid.
  CHECK sy-subrc = 0 AND NOT l_tmn-tmnlb IS INITIAL.

  READ TABLE gt_bew INTO l_bew WITH TABLE KEY einri = g_institution
                                              falnr = l_tmn-falnr
                                              lfdnr = l_tmn-tmnlb.

  CHECK sy-subrc = 0 AND l_bew-bewty = '4' AND l_bew-storn = off.

  p_bew-visoeakt = l_bew-orgpf.

  CALL METHOD cl_ish_utl_base_descr=>get_descr_orgunit      " MED-34600
    EXPORTING
      i_einri = g_institution
      i_orgid = p_bew-visoeakt
    IMPORTING
      e_orgkb = p_bew-visoeakt_kb
      e_okurz = p_bew-visoeakt_k.

ENDFORM.                    " get_field_visoe_akt
*&---------------------------------------------------------------------*
*&      Form  get_field_preregro
*&---------------------------------------------------------------------*
FORM get_field_preregro USING p_bew TYPE rnwp_prereg_list.

  DATA: ls_nbau   TYPE nbau,
        l_tmn     LIKE LINE OF gt_tmn,
        l_vkg     LIKE LINE OF gt_vkg.
  DATA: l_rc      TYPE ish_method_rc.

  READ TABLE gt_vkg INTO l_vkg WITH TABLE KEY vkgid = p_bew-vkgid.
  CHECK sy-subrc = 0 AND NOT l_vkg-apcnid IS INITIAL.

  READ TABLE gt_tmn INTO l_tmn WITH TABLE KEY apcnid = l_vkg-apcnid.
  IF sy-subrc <> 0.
*   no appointment exists for order position (only app. constraint)
    SELECT SINGLE trdrn troom FROM n1apcn
           INTO (p_bew-preregdr, p_bew-preregro)
           WHERE  apcnid  = l_vkg-apcnid
           AND    storn   = off.
  ELSE.
*   appointment exists for order position
    SELECT SINGLE dauer zimmr FROM napp
           INTO (p_bew-preregdr, p_bew-preregro)
           WHERE tmnid = l_tmn-tmnid.
  ENDIF.

* get short description of room
  IF NOT p_bew-preregro IS INITIAL.
    CALL METHOD cl_ish_dbr_bau=>get_bau_by_bauid
      EXPORTING
        i_bauid = p_bew-preregro
      IMPORTING
        es_nbau = ls_nbau
        e_rc    = l_rc.
    IF l_rc = 0.
      p_bew-preregrosn = ls_nbau-baukb.
    ENDIF.
  ENDIF.

ENDFORM.                    " get_field_preregro
*&---------------------------------------------------------------------*
*&      Form  get_field_aprie
*&---------------------------------------------------------------------*
FORM get_field_aprie USING p_bew TYPE rnwp_prereg_list.

  DATA: l_apri      TYPE n1apri-apri,
        l_aprie     TYPE n1aprie,
        l_apritxt   TYPE n1apritxt.

  CHECK p_bew-prio IS NOT INITIAL.
  CHECK p_bew-prio <> '000'.

  CLEAR: l_apri, l_aprie, l_apritxt.
  l_apri = p_bew-prio.
  CALL FUNCTION 'ISHMED_APRIE'
    EXPORTING
      i_apri    = l_apri
      i_einri   = g_institution
    IMPORTING
      e_aprie   = l_aprie
      e_apritxt = l_apritxt
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.
  IF sy-subrc <> 0.
    CLEAR: p_bew-aprie, p_bew-apritxt.
  ELSE.
    p_bew-aprie   = l_aprie.
    p_bew-apritxt = l_apritxt.
  ENDIF.

ENDFORM.                    " get_field_aprie
*&---------------------------------------------------------------------*
*&      Form  get_field_status
*&---------------------------------------------------------------------*
FORM get_field_status USING p_bew TYPE rnwp_prereg_list.

  DATA:   ls_vkg      LIKE LINE OF gt_vkg,
          lr_estat    TYPE REF TO cl_ish_estat,
          l_rc        TYPE ish_method_rc.

  CLEAR:  ls_vkg, lr_estat, l_rc.

  READ TABLE gt_vkg INTO ls_vkg WITH TABLE KEY vkgid = p_bew-vkgid.
  CHECK sy-subrc = 0 AND NOT ls_vkg-objnr IS INITIAL.

* read status of order position
  CALL METHOD cl_ish_status=>read_status
    EXPORTING
      i_objnr  = ls_vkg-objnr
    IMPORTING
      er_estat = lr_estat
      e_rc     = l_rc.
  CHECK l_rc = 0 AND NOT lr_estat IS INITIAL.

  CALL METHOD lr_estat->get_txt04
    RECEIVING
      r_txt04 = p_bew-status.
  CALL METHOD lr_estat->get_txt30
    RECEIVING
      r_txt30 = p_bew-status_text.

ENDFORM.                    " get_field_status
*&---------------------------------------------------------------------*
*&      Form  get_field_trtgp
*&---------------------------------------------------------------------*
FORM get_field_trtgp USING p_bew TYPE rnwp_prereg_list.

  DATA:   ls_vkg      LIKE LINE OF gt_vkg.

  CLEAR:  ls_vkg.

  READ TABLE gt_vkg INTO ls_vkg WITH TABLE KEY vkgid = p_bew-vkgid.
  CHECK sy-subrc = 0 AND NOT ls_vkg-trtgp IS INITIAL.

  p_bew-trtgp = ls_vkg-trtgp.

ENDFORM.                    " get_field_trtgp
*&---------------------------------------------------------------------*
*&      Form  get_field_trtgp_txt
*&---------------------------------------------------------------------*
FORM get_field_trtgp_txt USING p_bew TYPE rnwp_prereg_list.

  DATA: l_pnamec TYPE ish_pnamec,
        l_rc     TYPE ish_method_rc.

  CHECK NOT p_bew-trtgp IS INITIAL.

  CALL METHOD cl_ish_utl_base_gpa=>get_name_gpa
    EXPORTING
      i_gpart = p_bew-trtgp
      i_list  = on
    IMPORTING
      e_pname = l_pnamec
      e_rc    = l_rc.
  IF l_rc <> 0.
    p_bew-trtgp_txt = p_bew-trtgp.
  ELSE.
    p_bew-trtgp_txt = l_pnamec.
  ENDIF.

ENDFORM.                    " get_field_trtgp_txt
*&---------------------------------------------------------------------*
*&      Form  get_field_cposquest
*&---------------------------------------------------------------------*
FORM get_field_cposquest USING p_bew TYPE rnwp_prereg_list.

  DATA: ls_n1compa        LIKE LINE OF gt_n1compa.
  DATA: ls_n1cposquestion TYPE n1cposquestion.

  CLEAR: ls_n1compa, ls_n1cposquestion.

  READ TABLE gt_n1compa INTO ls_n1compa WITH KEY vkgid = p_bew-vkgid
             BINARY SEARCH.
  CHECK sy-subrc = 0 AND ls_n1compa-extuid IS NOT INITIAL.

  SELECT SINGLE * FROM n1cposquestion INTO ls_n1cposquestion
         WHERE  cposquestionid  = ls_n1compa-extuid.
  CHECK sy-subrc = 0.

  p_bew-cposquest = ls_n1cposquestion-quest.
  p_bew-cposquestionid = ls_n1cposquestion-cposquestionid.

ENDFORM.                    " get_field_cposquest
