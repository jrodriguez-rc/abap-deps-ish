*-------------------------------------------------------------------
***INCLUDE LN2DPF01 .
*-------------------------------------------------------------------
*----------------------------------------------------------------------*
*      Form  DIAGN_FALL
*----------------------------------------------------------------------*
* Ermitteln der Diagnosen für den Fall
*-----------------------------------------------------------------------
FORM diagn_fall USING $falnr.
* Sonst werden nur die fallübergreifenden Diagnosen ermittelt
  SELECT * FROM ndia WHERE einri =  g_einri
                     AND   falnr =  $falnr
                     AND   diabz NE space
                     AND   storn = off.
    MOVE ndia-lfdnr  TO dia_tab-lfdnr.
    MOVE ndia-lfdbew TO dia_tab-lfdbew.
    MOVE $falnr      TO dia_tab-falnr.
    MOVE ndia-ditxt  TO dia_tab-ditxt.
    MOVE ndia-dkat1  TO dia_tab-dkat1.
    MOVE ndia-dkey1  TO dia_tab-dkey1.
    MOVE ndia-dtyp1  TO dia_tab-dtyp1.
    MOVE ndia-diabz  TO dia_tab-diabz.
    MOVE ndia-dialo  TO dia_tab-dialo.
    MOVE ndia-diagw  TO dia_tab-diagw.
    MOVE ndia-diazs  TO dia_tab-diazs.
    MOVE ndia-diadt  TO dia_tab-diadt.
    APPEND dia_tab.
    anzdia = anzdia + 1.
  ENDSELECT.
ENDFORM.                               " DIAGN_FALL

*----------------------------------------------------------------------*
*      Form  DIAGN_PAT
*----------------------------------------------------------------------*
* Aufruf der Diagnosenermittlung für jeden Fall des Patienten
*----------------------------------------------------------------------*
FORM diagn_pat.
  LOOP AT teil_nfal.
    PERFORM diagn_fall USING teil_nfal-falnr.
  ENDLOOP.
ENDFORM.                               " DIAGN_PAT

*----------------------------------------------------------------------*
*      Form  FUELL_FALL_TAB
*----------------------------------------------------------------------*
* Alle Fälle des Patienten werden in einer  internen Tabelle gespeichert
*----------------------------------------------------------------------*
FORM fuell_fall_tab.
  SELECT * FROM nfal INTO TABLE teil_nfal
     WHERE einri = g_einri
     AND   patnr = g_patnr.

ENDFORM.                               " FUELL_FALL_TAB

*---------------------------------------------------------------------*
*      Form  DIA_LISTE
*----------------------------------------------------------------------*
* Ausgabe der Diagnosenliste
*----------------------------------------------------------------------*
FORM dia_liste.
  DATA: dkey_concat   LIKE ndia-dkey1.

* Listaufbereitung gesteuert durch PARAMETER DLD
  IF para_dld IS INITIAL.
    GET PARAMETER ID 'DLD' FIELD para_dld.
  ENDIF.
  IF para_dld = on.
    SORT dia_tab BY diadt DESCENDING.
  ELSE.
    SORT dia_tab BY diadt DESCENDING.
  ENDIF.

  CLEAR:  dia_tab.
  hide_counter = 1.
  MOVE 'Keine Diagnose'(001) TO dia_tab-ditxt.
  INSERT dia_tab INDEX 1.
  anzdia = anzdia + 1.
  flag = off.
  LOOP AT dia_tab.
    IF flag EQ on.
      flag = off.
    ELSE.
      flag = on.
    ENDIF.
    PERFORM col_normal USING flag.

*   Fallübergreifende Diagnosen sollen farblich hervorgehoben werden
    IF dia_tab-diabz EQ on.
      PERFORM col_positive USING flag.
    ENDIF.
    hide_counter = sy-tabix.
*   Wenn der Freitext zur Diagnose leer ist, soll der Katalogtext
*   ausgegeben werden
    IF dia_tab-ditxt IS INITIAL.
      PERFORM ish_read_nkdi USING dia_tab-dkat1 dia_tab-dkey1
                                  nkdi find_nkdi.
      IF find_nkdi EQ false.
        CLEAR nkdi.
      ENDIF.
      MOVE 'X' TO dia_tab-katkz.
      MOVE nkdi-dtext1 TO dia_tab-ditxt.
      MOVE nkdi-dtext2(10) TO dia_tab-ditxt+40(10).
    ENDIF.

*   Diagnosenaufbereitung
    CONCATENATE dia_tab-dkey1 dia_tab-dtyp1 INTO dkey_concat.

    WRITE:/ sy-vline NO-GAP.
    IF NOT dia_tab-diadt IS INITIAL.
      WRITE dia_tab-diadt NO-GAP.
    ENDIF.
    WRITE: 12 sy-vline NO-GAP.
    IF dia_tab-katkz  EQ on.
      WRITE icon_checked AS ICON.
    ELSE.
      WRITE dia_tab-katkz.
    ENDIF.
    WRITE: 15 sy-vline NO-GAP,
           (54) dia_tab-ditxt,
           70 sy-vline NO-GAP,
           71 dia_tab-dialo NO-GAP, 74 sy-vline NO-GAP,
           75 dia_tab-diagw NO-GAP, 78 sy-vline NO-GAP,
           79 dia_tab-diazs NO-GAP, 82 sy-vline NO-GAP.
    PERFORM col_key USING flag.
    WRITE: 83 dia_tab-dkat1 NO-GAP, 86 sy-vline NO-GAP,
           87(10) dkey_concat NO-GAP.
    PERFORM col_normal USING flag.
    WRITE: sy-vline NO-GAP,
           98 dia_tab-falnr,
          108 sy-vline.
    HIDE: dia_tab-lfdnr, dia_tab-falnr,
          dia_tab-dkey1, dia_tab-dkat1, dia_tab-dtyp1,
          dia_tab-dialo, dia_tab-dialotext,
          dia_tab-diagw, dia_tab-diazs, hide_counter.
    CLEAR: hide_counter.
  ENDLOOP.
  WRITE:/(108) sy-uline.
  HIDE: hide_counter.
ENDFORM.                               " DIA_LISTE

*----------------------------------------------------------------------*
*      Form  AUSW_DIA
*----------------------------------------------------------------------*
*  Auswahl einer Diagnose
*----------------------------------------------------------------------*
FORM ausw_dia.
  IF g_vcode = 'UPD' AND auth = true.
*    IF sy-curow LE 6 OR hide_counter GT anzdia.
    IF sy-curow LE 3 OR hide_counter GT anzdia.
      MESSAGE e113.EXIT.
    ENDIF.
  ENDIF.
  IF dia_tab-falnr IS INITIAL.
    enodiag = 1.
  ELSE.
    efalnr = dia_tab-falnr.
    elfdnr = dia_tab-lfdnr.
    ekat   = dia_tab-dkat1.
    ekey   = dia_tab-dkey1.
    edialo = dia_tab-dialo.
    editxt = dia_tab-ditxt.
    edialotext = dia_tab-dialotext.
  ENDIF.
ENDFORM.                               " AUSW_DIA
*&---------------------------------------------------------------------*
*&      Form  CHECK_AUTHORITY
*&---------------------------------------------------------------------*
*       Berechtigungsprüfung für Diagnosen
*       - Prüfen, ob Berechtigung zum Erfassen von Diagnosen vorliegt
*         sonst nur Anzeige möglich
*----------------------------------------------------------------------*
FORM check_authority.
  DATA: nbewtab TYPE TABLE OF vnbew,                        "note 613731
        actvt   TYPE tact-actvt.

* Berechtigungsprüfung von Diagnosen für fachl. OE
  auth = true.
  IF NOT g_orgfa IS INITIAL.
*    PERFORM fill_nbewtab(sapmnpa0) TABLES nbewtab
*                                   USING  g_einri
*                                          ll_falnr.
*    PERFORM del_nbewtab_stor(sapmnpa0) TABLES nbewtab.
**
*    IF g_vcode = 'DIS'.
*      actvt = '03'.             "anzeigen
*    ELSE.
*      actvt = '02'.             "aendern
*    ENDIF.
*    CALL FUNCTION 'ISH_AUTH_DIAGNOSIS_ORGFA'
*      EXPORTING
*        ss_einri     = g_einri
*        ss_orgfa     = g_orgfa
*        ss_act       = actvt
*      TABLES
*        ss_nbewtab   = nbewtab
*      EXCEPTIONS
*        no_authority = 1
*        OTHERS       = 2.
*    IF sy-subrc <> 0.
*      IF actvt = '02'.
*        auth = false.
*      ELSE.
*        RAISE not_found.
*      ENDIF.
*    ENDIF.
  ENDIF.
ENDFORM.                               " CHECK_AUTHORITY

*-----------------------------------------------------------------------
* FORM UPDATE_NFAL
*-----------------------------------------------------------------------
* Verbuchen der Ldf.Nr. der Diagnose
*-----------------------------------------------------------------------
FORM update_nfal USING old_nfal   STRUCTURE nfal
                         new_nfal STRUCTURE nfal
                         value(int_tcode).

  DATA: BEGIN OF dummy_nbew OCCURS 1.
          INCLUDE STRUCTURE vnbew.
  DATA: END OF dummy_nbew.
  DATA: BEGIN OF dummy_xnbew OCCURS 1.
          INCLUDE STRUCTURE vnbew.
  DATA: END OF dummy_xnbew.
  DATA: BEGIN OF dummy_ynbew OCCURS 1.
          INCLUDE STRUCTURE vnbew.
  DATA: END OF dummy_ynbew.
  DATA: BEGIN OF dummy_cdtxt OCCURS 1.
          INCLUDE STRUCTURE cdtxt.
  DATA: END OF dummy_cdtxt.

  CALL FUNCTION 'ISH_VERBUCHER_NFAL'
*         IN UPDATE TASK
       EXPORTING
            o_tnfal     = old_nfal
            tcode       = int_tcode
            tnfal       = new_nfal
            upd_icdtxt_nfal = space
            up_date     = sy-datum
            up_time     = sy-uzeit
            vcode_nfal  = 'UPD'
       TABLES
            icdtxt_nfal = dummy_cdtxt
            nbewtab     = dummy_nbew
            xnbew       = dummy_xnbew
            ynbew       = dummy_ynbew.

ENDFORM.                    "update_nfal

*&---------------------------------------------------------------------*
*&      Form  ISH_READ_NKDI
*&---------------------------------------------------------------------*
*       Einlesen/Anzeigen Diagnosekatalogdaten gepuffert
*----------------------------------------------------------------------*
*      -->DKAT  Diagnoseskatalog
*      -->DKEY  Diagnose
*      -->NKDI  Headline NKDI
*      -->FLAG  Flag, ob TRUE od. FALSE
*----------------------------------------------------------------------*
FORM ish_read_nkdi USING    value(dkat)
                            value(dkey)
                            $nkdi STRUCTURE nkdi
                            flag.
  IF dkat IS INITIAL OR
     dkey IS INITIAL.
    flag = false.
    CLEAR $nkdi.
    EXIT.
  ENDIF.
* Aufruf des FBS ISH_READ_NKDI, um Daten der NKDI zu ermitteln
  CALL FUNCTION 'ISH_N2_READ_NKDI'
    EXPORTING
      dkat      = dkat
      dkey      = dkey
      spras     = sy-langu
    IMPORTING
      e_nkdi    = $nkdi
    EXCEPTIONS
      not_found = 01.

  CASE sy-subrc.
    WHEN 0.
      flag = true.
    WHEN OTHERS.
      flag = false.
      CLEAR $nkdi.
  ENDCASE.

ENDFORM.                               " ISH_READ_NKDI
