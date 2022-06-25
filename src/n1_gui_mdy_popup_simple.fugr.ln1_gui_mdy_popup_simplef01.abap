***Begin of MED-48629, Jitareanu Cristina 24.10.2012  "für die Rekonstruktion der Fallliste

*----------------------------------------------------------------------*
***INCLUDE LN1_GUI_MDY_POPUP_SIMPLEF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  FILL_EXCLTAB
*&---------------------------------------------------------------------*
*       We have to build the Pop-up for the Fallliste
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
* Gemeinsame Befehle der Reports auswerten
*----------------------------------------------------------------------*
FORM user_comm_common.
  fcode = sy-ucomm.
  CASE sy-ucomm.
    WHEN 'END'.                        "Beenden
      fcode = 'END'.
      clear gs_nfal.
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN 'LBCK'.                       "Zurück zu aufruf. Dynpro
      SET SCREEN 0.
      LEAVE SCREEN.
    WHEN 'CAN'.                        "Abbrechen
      fcode = 'CAN'.
       clear gs_nfal.
      SET SCREEN 0.
      LEAVE SCREEN.
****Start: MED-52333 M.Rebegea 09.12.2013   Cancel Button
    WHEN 'ECAN'.
      fcode = 'ECAN'.
      clear gs_nfal.
      SET SCREEN 0.
      LEAVE SCREEN.
****End: MED-52333 M.Rebegea 09.12.2013   Cancel Button
  ENDCASE.                             " CASE SY-UCOMM
ENDFORM.                               " USER_COMM_COMMON


*&---------------------------------------------------------------------*
*&      Form  COL_HEADING
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->VALUE      text
*      -->(INTEN)    text
*----------------------------------------------------------------------*
FORM col_heading USING VALUE(inten) LIKE rnpa1-mark.        "#EC CALLED
  FORMAT COLOR COL_HEADING.
* Hell ausgeben oder normal ?
  IF inten EQ 'X'.
    FORMAT INTENSIFIED ON.
  ELSE.
    FORMAT INTENSIFIED OFF.
  ENDIF.
  merk_colour = '2'.
  merk_intens = inten.
ENDFORM.                    "COL_HEADING
*---------

FORM top_of_page_fallist.
  DATA: pat_name(40).

  DATA: l_ebene          TYPE c,
        l_standard_text  TYPE lvc_string,
        l_anzeigetext    TYPE lvc_string.

* Patient + System-Datum ausgeben
  READ TABLE outtab_nfal INDEX 1.
  IF sy-subrc <> 0.
    RAISE read_error.
  ENDIF.

  DATA: l_rc          TYPE ish_method_rc,
        ls_npat       TYPE npat.
  CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
    EXPORTING
      i_patnr     = outtab_nfal-patnr
      i_read_db   = 'X'
      i_no_buffer = 'X'
    IMPORTING
      es_npat     = ls_npat
      e_rc        = l_rc.
  IF l_rc = 0.
    npat = ls_npat.
  ELSE.
    CLEAR npat.
  ENDIF.
  SELECT SINGLE * FROM tn17t
                  WHERE spras = sy-langu
                  AND   gschl = npat-gschl.
  IF sy-subrc <> 0.
    CLEAR tn17t.
  ENDIF.

  CALL METHOD cl_ish_utl_base_patient=>get_name_patient
    EXPORTING
      i_patnr = npat-patnr
      is_npat = npat
    IMPORTING
      e_pname = pat_name.

  CLEAR: l_ebene,
         l_standard_text,
         l_anzeigetext.

  l_ebene         = 'U'.
  l_standard_text = 'Medizinischer Text'(f12).
  l_anzeigetext   = l_standard_text.
  PERFORM badi_aufrufen USING outtab_nfal
                              l_ebene
                              l_standard_text
                              l_anzeigetext.
* Schreiben der Textzeilen
  WRITE:  /1(8)  'Name'(f15).
  PERFORM col_background USING ' '.
  WRITE:    (40) pat_name.
  PERFORM col_background USING 'X'.
  WRITE:  55(8)  'Geschl.'(f16).
  PERFORM col_background USING ' '.
  WRITE:    (1)  tn17t-gschle.
  PERFORM col_background USING 'X'.
  WRITE:  73(8)  'Geb.Dat.'(f17).
  PERFORM col_background USING ' '.
  WRITE:    (8)  npat-gbdat DD/MM/YY NO-GAP.
  SKIP.
  WRITE: /1(93) sy-uline.
* Überschrift zur Fallzeile
  PERFORM col_group USING 'X'.
  WRITE: /1     sy-vline NO-GAP,
           (2)  space,
           (10) 'Fallnummer'(f01),
           (1)  '  ',                  " Prüfziffer-Fall
           (14) 'Fallart'(f02),
           (6)  'BehKat'(f03),
           (8)  '1.Kont.'(f04),
           (8)  'L.Kont.'(f05),
          93   sy-vline NO-GAP.
  PERFORM col_heading USING 'X'.
  WRITE: /1     sy-vline NO-GAP,
           (2)  space,
           (8)  'Beh. OE'(f06),
           (8)  'Zimmer'(f21),
           (8)  'Fachl.OE'(f07),
           (8)  'Datum'(f13),
           (5)  'Zeit'(f14),
           (2)  'BA'(f08),
           (3)  'Pri'(f09),
           (2)  'SE'(f10),
           (2)  'Tp'(f11),
*          (33) 'Medizinischer Text'(f12),
           (33) l_anzeigetext,
          93   sy-vline NO-GAP.
  WRITE: /1(93) sy-uline.

  FORMAT RESET.
ENDFORM.                               " TOP_OF_PAGE_FALLIST

TOP-OF-PAGE.
  PERFORM top_of_page_fallist.

TOP-OF-PAGE DURING LINE-SELECTION.
  PERFORM top_of_page_fallist.

*----------------------------------------------------------------------*
* Zeitpunktelement AT USER-COMMAND für die Reports                     *
*----------------------------------------------------------------------*
AT USER-COMMAND.
  PERFORM user_comm_common.

  PERFORM user_comm_fallist.



*----------------------------------------------------------------------*
* User-Command auswerten in der Falliste                               *
*----------------------------------------------------------------------*
FORM user_comm_fallist.

  DATA: a_fcode LIKE fcode.
  DATA: textname    LIKE thead-tdname.
  DATA: BEGIN OF nbew_tkey,            " Textschlüssel für Langtext
          einri LIKE nbew-einri,
          falnr LIKE nbew-falnr,
          lfdnr LIKE nbew-lfdnr.
  DATA: END OF nbew_tkey.
  DATA: l_rc LIKE sy-subrc.
  DATA: l_fall LIKE sy-ucomm,
        l_ucomm LIKE sy-ucomm,
        l_no_fall(1) TYPE c,
        l_check_datas LIKE g_check_datas,
        l_falnr LIKE nfal-falnr.

  DATA: lt_found_timeslots TYPE ish_t_ats_list_data.

  CLEAR: outtab_nbew, outtab_nfal.

  fcode = sy-ucomm.

  CASE sy-ucomm.
    WHEN 'SEL'.                        "Auswählen
      GET CURSOR FIELD feldname.
      CASE feldname.
        WHEN 'OUTTAB_NFAL-FALNR'.

              READ TABLE outtab_nfal[] INTO gs_nfal INDEX fal_out_index.

            "To get analized again in the PAI and to exit the function
            SET SCREEN 0.
            LEAVE SCREEN.

      ENDCASE.

*      GET CURSOR FIELD feldname.
*      CASE feldname.
*        WHEN 'OUTTAB_NBEW-MEDTX'.
*          nbew_tkey-einri = outtab_nbew-einri.
*          nbew_tkey-falnr = outtab_nbew-falnr.
*          nbew_tkey-lfdnr = outtab_nbew-lfdnr.
*          textname   = nbew_tkey.
*          PERFORM show_ltext USING 'NBEW' '0003' textname
*                                   outtab_nbew-meltx.
**       Nr 4652: Knotenkennzeichen wechseln
*        WHEN 'OUTTAB_NFAL-NODE'.
*          READ TABLE outtab_nfal INDEX fal_out_index.
*          IF sy-subrc = 0.
*            CASE outtab_nfal-node.
*              WHEN g_node_plus.
*                outtab_nfal-node = g_node_minus.
*              WHEN g_node_minus.
*                outtab_nfal-node = g_node_plus.
*            ENDCASE.
*            MODIFY outtab_nfal INDEX fal_out_index.
*          ENDIF.
*          sy-lsind = sy-lsind - 1.
*          PERFORM show_fallist.
**         Nr 4652 - Ende
*
*        WHEN OTHERS.
**           Nur Bewegungen der Vergangenheit dürfen auswählbar sein
*          IF outtab_nbew-bwidt > sy-datum  OR
*             ( outtab_nbew-bwidt = sy-datum  AND
*               outtab_nbew-bwizt > sy-uzeit ).
** Meldung entfernt (Nr. 949)
***             Nur Bewegungen vor & / & sind für diese Funktion erlaubt
**              MESSAGE E123 WITH SY-DATUM SY-UZEIT.
*          ENDIF.   " IF OUTTAB_NBEW-BWIDT > SY-DATUM  OR  ...
*
**         nur ambulante Besuche dürfen auswählbar sein (Ambulanzkarte)
*          IF sel_amb_bew = 'X' AND outtab_nbew-bewty NE '4'.
*            MESSAGE e924(nf).
**           Bitte wählen Sie einen ambulante Bewegung aus
*          ENDIF.
*      ENDCASE.
  ENDCASE.                             " CASE SY-UCOMM
ENDFORM.                               " USER_COMM_FALLIST
*

FORM show_ltext USING VALUE(textobject) VALUE(textid)
                      VALUE(textname) VALUE(ltxkz).
  DATA: txobj         LIKE thead-tdobject.
  DATA: BEGIN OF icdtxt OCCURS 3.      " Änderungsbelegtabelle
          INCLUDE STRUCTURE cdtxt.
  DATA: END OF icdtxt.

* TEXTOBJECT einer Dummy-Var. zuweisen, da sonst die Länge nicht paßt
* und es beim Aufruf des FB zu einem Laufzeitfehler kommt!
  txobj = textobject.
  CALL FUNCTION 'ISHMED_SAPSCRIPT'
    EXPORTING
*     SS_KTEXT_I    = KTEXT
      ss_ltext_i    = ltxkz
      ss_textid     = textid
      ss_textname   = textname
      ss_textobject = txobj
      ss_vcode      = 'DIS'
*      IMPORTING
*     SS_KTEXT_E    = KTEXT
*     SS_LTEXT_E    = LTXKZ
    TABLES
      ss_icdtxt     = icdtxt.
ENDFORM.                    "show_ltext


*&---------------------------------------------------------------------*
*&      Form  FILL_EXCLTAB
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM fill_excltab .

  DATA: l_check_datas LIKE g_check_datas.

  CLEAR excl_tab. REFRESH excl_tab.

*  die Anlegen-Buttons sollen weg
  PERFORM append_excltab USING 'AMB_FALL'.
  PERFORM append_excltab USING 'STAT_FALL'.


* Ausschalten gewisser Funktionen
  IF vcode = 'DIS'.
    PERFORM append_excltab USING 'NFAL'.   " Neuer Fall
    PERFORM append_excltab USING 'NBEW'.   " Neue Bewegung
    PERFORM append_excltab USING 'ABES'.   " Bewegung ändern
    PERFORM append_excltab USING 'SEL '.   " Auswählen
* Fall-Buttons im Anzeigemodus immer deaktivieren
    PERFORM append_excltab USING 'AMB_FALL'.
    PERFORM append_excltab USING 'STAT_FALL'.
    PERFORM append_excltab USING 'AMB_AUFN'.
    PERFORM append_excltab USING 'STAT_AUFN'.
  ELSE.
    IF new_case <> 'X'.
      PERFORM append_excltab USING 'NFAL'.
    ENDIF.
    IF new_bew  <> 'X'.
      PERFORM append_excltab USING 'NBEW'.
    ENDIF.
    IF chg_bew  <> 'X'.
      PERFORM append_excltab USING 'ABES'.
    ENDIF.
*   Fall-Buttons deaktivieren, wenn vom Aufrufer gewünscht
    IF g_case_buttons <> 'X'.
      PERFORM append_excltab USING 'AMB_FALL'.
      PERFORM append_excltab USING 'STAT_FALL'.
      PERFORM append_excltab USING 'AMB_AUFN'.
      PERFORM append_excltab USING 'STAT_AUFN'.
**
*    else.
*      if g_check_datas = ' '.
*        perform append_excltab using 'AMB_AUFN'. "ED, ID 7442
*        perform append_excltab using 'STAT_AUFN'. "ED, ID 7442
*      elseif g_check_datas = '*'.
*        clear l_check_datas.
*        perform ren00r(sapmnpa0)
*              using einri 'N1PTAMAF' l_check_datas.
*        if l_check_datas <> 'X'.
*          perform append_excltab using 'AMB_AUFN'. "ED, ID 7442
*          perform append_excltab using 'STAT_AUFN'. "ED, ID 7442
*        endif.
*      elseif g_check_datas <> 'X' and g_check_datas <> ' '
*             and g_check_datas <> '*'.
*        perform append_excltab using 'AMB_AUFN'. "ED, ID 7442
*        perform append_excltab using 'STAT_AUFN'. "ED, ID 7442
*      endif.
**
    ENDIF.
  ENDIF.

* Fichte, 7.5.97: Aufgrund zahlreicher Anfragen, weshalb der Button
* "Neue Bewegung" nicht vorhanden ist, nehme ich diese Abfrage heraus
*  IF THE_BEW-STATU IS INITIAL  OR  THE_BEW-ORGPF IS INITIAL.
*    PERFORM APPEND_EXCLTAB USING 'NBEW'.   " Neue Bewegung
*  ENDIF.

ENDFORM.                    " FILL_EXCLTAB
*&---------------------------------------------------------------------*
*&      Form  APPEND_EXCLTAB
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0014   text
*----------------------------------------------------------------------*
FORM append_excltab  USING funk.
  READ TABLE excl_tab WITH KEY funk.
  IF sy-subrc <> 0.
    MOVE funk TO excl_tab-funktion.
    APPEND excl_tab.
  ENDIF.
ENDFORM.                    " APPEND_EXCLTAB



*&---------------------------------------------------------------------*
*&      Form  SHOW_FALLIST
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM show_fallist .

  DATA: intens(1),
         ext_stat LIKE tn14e-status_ex,
         fall_txt LIKE tn15t-fatxt.
  DATA: BEGIN OF intab_nbew OCCURS 50.
          INCLUDE STRUCTURE nbew.
  DATA: END OF intab_nbew.
  DATA: l_flag TYPE c.

  DATA: BEGIN OF temp_sort_nfal OCCURS 0.
          INCLUDE STRUCTURE nfal.

  DATA:   node(2).
  DATA: END OF temp_sort_nfal.

* Definitionen für Badi zum Übersteuern des Feldes "Medizinischer Text"
  DATA: l_ebene          TYPE c,
        l_standard_text  TYPE lvc_string,
        l_anzeigetext    TYPE lvc_string.

* Zuerst die Table passend sortieren
* Fichte, Nr 7208: OUTTAB_NFAL so sortieren, dass der aktuellste
* gültige(!) Fall zuerst kommt
*  SORT outtab_nfal BY falnr.
* Falls das BEGDT leer ist, wird es aus der ersten Bewegung
* ergänzt. Da ich das BEGDT der NFAL nicht verändern möchte,
* benutze ich zur Sortierung als Zwischenspeicher das UPDAT

  SORT outtab_nbew BY bwidt.

  LOOP AT outtab_nfal.
*   Ist der Fall überhaupt noch gültig?
    CALL FUNCTION 'ISHMED_IS_FALL_CLOSED'
      EXPORTING
        i_einri   = outtab_nfal-einri
        i_falnr   = outtab_nfal-falnr
*       I_DATUM   = SY-DATUM
        i_caller  = 'SAPLN1LI'
      IMPORTING
        e_closed  = l_flag
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.
    IF l_flag <> '0'.
*     Fall ist ungültig => Er kommt nach hinten
      outtab_nfal-updat = '19000101'.
      MODIFY outtab_nfal.
      CONTINUE.
    ENDIF.

*   Jetzt prüfen, ob der Fall abgerechnet ist
    CALL FUNCTION 'ISHMED_IS_CASE_ACCOUNTED'
      EXPORTING
        i_einri       = outtab_nfal-einri
        i_falnr       = outtab_nfal-falnr
*       I_ABR_STRING  = '2'
        i_show_msg    = ' '
        i_vcode       = 'UPD'
        i_prgname     = 'SAPLN1LI'
      IMPORTING
        e_case_locked = l_flag
*       e_err_level   = l_flag
      EXCEPTIONS
        not_found     = 1
        OTHERS        = 2.
    IF l_flag = 'X'  OR  sy-subrc <> 0.
      outtab_nfal-updat = '19000101'.
      MODIFY outtab_nfal.
      CONTINUE.
    ENDIF.

    outtab_nfal-updat = outtab_nfal-begdt.
    IF outtab_nfal-updat < '19000101'  OR
       outtab_nfal-updat IS INITIAL.
*     Nur Ist-Bewegungen zählen
*     Fichte, Nr 7548: Fehlerkorrektur
*      loop at outtab_nbew where planb = space.
      LOOP AT outtab_nbew WHERE einri = outtab_nfal-einri
                          AND   falnr = outtab_nfal-falnr
                          AND   planb = space.
*       Fichte, Nr 7548 - Ende
        outtab_nfal-updat = outtab_nbew-bwidt.
        EXIT.
      ENDLOOP.
    ENDIF.
    MODIFY outtab_nfal.
  ENDLOOP.

  SORT outtab_nfal BY updat DESCENDING.

  IF g_kunden_sort = 'X'.
*    Die vom Kunden festgelegte Sortierung herstellen
    REFRESH temp_sort_nfal.
    LOOP AT the_nfal.
      READ TABLE outtab_nfal WITH KEY falnr = the_nfal-falnr.
      IF sy-subrc = 0.
        APPEND outtab_nfal TO temp_sort_nfal.
      ENDIF.
    ENDLOOP.
    REFRESH outtab_nfal.
    outtab_nfal[] = temp_sort_nfal[].
    REFRESH temp_sort_nfal.
  ENDIF.

  CASE sort_field.
    WHEN 'ORGPF'.
      SORT outtab_nbew BY orgpf.
    WHEN 'BEWNR'.
      SORT outtab_nbew BY lfdnr.
    WHEN 'BWIDT'.
      SORT outtab_nbew BY bwidt bwizt.
    WHEN 'BWIDTASC'.                                        "BM ID10305
      SORT outtab_nbew DESCENDING BY bwidt bwizt.           "BM ID10305
    WHEN 'BWSEQ'.
      CLEAR outtab. REFRESH outtab.                         "ID 4405
      LOOP AT outtab_nbew.                                  "ID 4405
        MOVE-CORRESPONDING outtab_nbew TO outtab.           "ID 4405
        APPEND outtab.                                      "ID 4405
      ENDLOOP.                                              "ID 4405
      SORT outtab BY bwidt bwizt.                           "ID 4405
      PERFORM build_sequence.
      intab_nbew[] = outtab_nbew[].                         "ID 4405
      LOOP AT outtab.                                       "ID 4405
        READ TABLE intab_nbew                               "ID 4405
          WITH KEY lfdnr = outtab-lfdnr.                    "ID 4405
        MOVE-CORRESPONDING intab_nbew TO outtab_nbew.       "ID 4405
        APPEND outtab_nbew.                                 "ID 4405
      ENDLOOP.                                              "ID 4405
  ENDCASE.                             " CASE SORT_FIELD

  CLEAR fal_out_index.                                      " ID 3632

* Ausgabe der Daten
  LOOP AT outtab_nfal.
    fal_out_index = sy-tabix.                               " ID 3632

*   Den Fall zuerst ausgeben
*   BAdi aufrufen
    CLEAR: l_ebene,
           l_standard_text,
           l_anzeigetext.

    l_ebene = 'F'.
    l_standard_text = ''.
    PERFORM badi_aufrufen USING  outtab_nfal
                                 l_ebene
                                 l_standard_text
                                 l_anzeigetext.

    NEW-LINE.
    PERFORM col_background USING ' '.
    WRITE: 1(93) sy-vline.                                  " Nr 4652
    IF outtab_nfal-falnr = gs_nfal_highlight-falnr.
*      Wenn ein bestimmter Fall vom Badi übergeben wurde, wird dieser
*      hervorgehoben auf der Liste angezeigt
      PERFORM col_group USING 'X'.
    ELSE.
      PERFORM col_group USING ' '.
    ENDIF.
*   Nr 4652: Knoten-Icon zum Öffnen der Bewegungen ausgeben
*    WRITE: 2(10) OUTTAB_NFAL-FALNR.
    IF outtab_nfal-node <> g_node_empty.
      FORMAT HOTSPOT ON.
    ENDIF.
    WRITE: 2 outtab_nfal-node AS SYMBOL.
    FORMAT HOTSPOT OFF.
    WRITE: (10) outtab_nfal-falnr.
    IF pziff_fal = 'X'.
      WRITE: (1) outtab_nfal-fziff.
    ELSE.
      WRITE: (1) ' '.
    ENDIF.
*   Fallart-Text ermitteln und ausgeben
    PERFORM get_fatxt USING einri outtab_nfal-falar fall_txt.
    WRITE: (14) fall_txt.
    WRITE: (6) outtab_nfal-bekat,
           (8) outtab_nfal-begdt DD/MM/YY,
           (8) outtab_nfal-enddt DD/MM/YY,
           (1)  space,                           "ID 9965 / KIEDL G.
           (33) l_anzeigetext.                   "ID 9965 / KIEDL G.
    WRITE: 93 sy-vline NO-GAP.                              " Nr 4652
    HIDE:  fal_out_index.                                   " ID 3632
    CLEAR: fal_out_index.                                   " ID 3632
*   Nr 4652: Bewegungen nur anzeigen, wenn Knoten geöffnet
    IF outtab_nfal-node = g_node_minus.
      intens = ' '.
      LOOP AT outtab_nbew WHERE falnr = outtab_nfal-falnr.
*       Ausgabe der Bewegungen zu diesem Fall
        out_index = sy-tabix.
        NEW-LINE.
        PERFORM col_background USING ' '.
        WRITE: 1(93) sy-vline.                              " Nr 4652
*       Nr 4652: 2 Zeichen frei lassen, wegen dem Knotensymbol
*        PERFORM COL_NORMAL USING INTENS.
*        WRITE: 2(8)  OUTTAB_NBEW-ORGPF,
        WRITE: 2(2)  space.
        PERFORM col_normal USING intens.
        WRITE:  (8)  outtab_nbew-orgpf,
                (8)  outtab_nbew-zimmr,
                (8)  outtab_nbew-orgfa,
                (8)  outtab_nbew-bwidt DD/MM/YY,
                (5)  outtab_nbew-bwizt USING EDIT MASK '__:__',
                (2)  outtab_nbew-bwart.
*       Externe BWPrio aus der internen ermitteln
        SELECT * FROM n1apri
                 WHERE einri = einri
                 AND   apri  = outtab_nbew-bwprio.
          EXIT.
        ENDSELECT.
        IF sy-subrc <> 0.
          CLEAR n1apri.
        ENDIF.
        WRITE: (3)  n1apri-aprie.
        PERFORM get_status_ext USING einri outtab_nbew-statu ext_stat.

*       BAdi aufrufen
        CLEAR: l_ebene,
               l_standard_text,
               l_anzeigetext.

        l_ebene = 'B'.
        l_standard_text = outtab_nbew-medtx.
        PERFORM badi_aufrufen USING  outtab_nbew
                                     l_ebene
                                     l_standard_text
                                     l_anzeigetext.
        WRITE: (2)  ext_stat,
               (2)  outtab_nbew-tpart,
*              (33) outtab_nbew-medtx.
               (33) l_anzeigetext.                 "ID 9966 / KIEDL G.
        WRITE: 93 sy-vline NO-GAP.                          " Nr 4652
        HIDE: outtab_nbew-falnr, outtab_nbew-lfdnr, out_index.
        CLEAR: out_index, outtab_nbew-falnr, outtab_nbew-lfdnr.
        IF intens = 'X'.
          intens = ' '.
        ELSE.
          intens = 'X'.
        ENDIF.
      ENDLOOP.                         " LOOP AT OUTTAB_NBEW WHERE ...
    ENDIF.                                                  " Nr 4652
    WRITE: /1(93) sy-uline.                                 " Nr 4652
  ENDLOOP.                             " LOOP AT OUTTAB_NFAL
* Keine Bewegungsdaten gefunden ==> Meldung 'drucken'
  IF sy-subrc <> 0.
    WRITE: /1 'Es existieren noch keine Bewegungen'(f20).
  ENDIF.
  SCROLL LIST INDEX 1 TO: PAGE sy-cpage LINE sy-staro, COLUMN sy-staco.

ENDFORM.                    " SHOW_FALLIST

*&---------------------------------------------------------------------*
*&      Form  Badi_aufrufen
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_OUTTAB_NFAL  text
*      -->P_0381   text
*      -->P_L_ANZEIGETEXT  text
*----------------------------------------------------------------------*
FORM badi_aufrufen USING    p_outtab
                            p_ebene
                            p_standard_text
                            p_anzeigetext.

* Datendefinition für User-Exit
  DATA: l_exit           TYPE REF TO if_ex_ishmed_fall_list.

  DATA: l_ebene          TYPE c,
        l_standard_text  TYPE lvc_string,
        l_anzeigetext    TYPE lvc_string.

  DATA: ls_object_nfal   LIKE outtab_nfal,
        lt_object_nfal   LIKE TABLE OF outtab_nfal.

  DATA: ls_object_nbew   LIKE outtab_nbew,
        lt_object_nbew   LIKE TABLE OF outtab_nbew.

  CLEAR:   l_ebene,
           l_standard_text,
           l_anzeigetext.
  REFRESH: lt_object_nfal,
           lt_object_nbew.


  l_ebene         = p_ebene.
  l_standard_text = p_standard_text.
  l_anzeigetext   = p_standard_text.

* BADI-Fallermittlung für Fallzuordnung
* First check if the BADI is implemented

  CALL FUNCTION 'SXC_EXIT_CHECK_ACTIVE'
    EXPORTING
      exit_name  = 'ISHMED_FALL_LIST'
    EXCEPTIONS
      not_active = 1
      OTHERS     = 2.

  IF sy-subrc = 0.
*    BADI create instance
    CALL METHOD cl_exithandler=>get_instance
      EXPORTING
*       exit_name              = 'ishmed_fall_list'    "ID-19266
        exit_name              = 'ISHMED_FALL_LIST'    "ID-19266
        null_instance_accepted = ' '
      CHANGING
        instance               = l_exit.

    IF sy-subrc = 0.
*        BADI - UserExit
      CASE p_ebene.
        WHEN 'F' OR 'U'.
          APPEND p_outtab TO lt_object_nfal.
          CALL METHOD l_exit->fill_field
            EXPORTING
              i_ebene         = l_ebene
              i_object        = lt_object_nfal
              i_standard_text = l_standard_text
            CHANGING
              o_anzeigetext   = l_anzeigetext.

        WHEN 'B'.
          APPEND p_outtab TO lt_object_nbew.
          CALL METHOD l_exit->fill_field
            EXPORTING
              i_ebene         = l_ebene
              i_object        = lt_object_nbew
              i_standard_text = l_standard_text
            CHANGING
              o_anzeigetext   = l_anzeigetext.
      ENDCASE.
    ENDIF.
  ENDIF.

  p_anzeigetext = l_anzeigetext.

ENDFORM.                    " Badi_aufrufen


*----------------------------------------------------------------------*
* Form BUILD_SEQUENCE
* Reihen der OUTTAB_NBEW nach den Bewegungssequenzen
*----------------------------------------------------------------------*
FORM build_sequence.
  DATA: BEGIN OF temp OCCURS 30.
*          INCLUDE STRUCTURE OUTTAB_NBEW.                    "ID 4405
          INCLUDE STRUCTURE outtab.                         "ID 4405
  DATA: END OF temp.
  DATA: read_nr LIKE nbew-nfgref.

  CLEAR temp.   REFRESH temp.
  LOOP AT outtab.                                           "ID 3448
*  loop at outtab_nbew.                                      "ID 3448
    MOVE-CORRESPONDING outtab TO temp.                      "ID 3448
    temp-type = outtab-type.                                "ID 3448
*    temp = outtab_nbew.                                     "ID 3448
    APPEND temp.
  ENDLOOP.
  CLEAR outtab. REFRESH outtab.                             "ID 3448
*  clear outtab_nbew.   refresh outtab_nbew.                 "ID 3448
*  SORT TEMP BY BWIDT BWIZT.                                 "ID 4405
  read_nr = 0.
  DO.
    LOOP AT temp WHERE vgnref = read_nr.
      MOVE-CORRESPONDING temp TO outtab.                    "ID 3448
*      outtab_nbew = temp.                                   "ID 3448
      APPEND outtab.                                        "ID 3448
*      append outtab_nbew.                                   "ID 3448
      IF NOT temp-nfgref IS INITIAL.
        read_nr = temp-lfdnr.
      ELSE.
        CLEAR read_nr.
      ENDIF.
      DELETE temp.
      EXIT.
    ENDLOOP.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
  ENDDO.
ENDFORM.                               " BUILD_SEQUENCE

*-----------------------------------------------------------------------
* Hintergrund
*-----------------------------------------------------------------------
FORM col_background USING VALUE(inten) LIKE rnpa1-mark.     "#EC CALLED
  FORMAT COLOR COL_BACKGROUND.
* Hell ausgeben oder normal ?
  IF inten EQ 'X'.
    FORMAT INTENSIFIED ON.
  ELSE.
    FORMAT INTENSIFIED OFF.
  ENDIF.
  merk_colour = '1'.
  merk_intens = inten.
ENDFORM.                    "COL_BACKGROUND

*-----------------------------------------------------------------------
* Hierarchieüberschriften
*-----------------------------------------------------------------------
FORM col_group USING VALUE(inten) LIKE rnpa1-mark.          "#EC CALLED
  FORMAT COLOR COL_GROUP.
* Hell ausgeben oder normal ?
  IF inten EQ 'X'.
    FORMAT INTENSIFIED ON.
  ELSE.
    FORMAT INTENSIFIED OFF.
  ENDIF.
  merk_colour = '8'.
  merk_intens = inten.
ENDFORM.                    "COL_GROUP
*--------------

*-----------------------------------------------------------------------
* Listenkörper
*-----------------------------------------------------------------------
FORM col_normal USING VALUE(inten) LIKE rnpa1-mark.         "#EC CALLED
  FORMAT COLOR COL_NORMAL.
* Hell ausgeben oder normal ?
  IF inten EQ 'X'.
    FORMAT INTENSIFIED ON.
  ELSE.
    FORMAT INTENSIFIED OFF.
  ENDIF.
  merk_colour = '3'.
  merk_intens = inten.
ENDFORM.                    "COL_NORMAL

*---------------------------------------------------------------------*
* Form GET_FATXT
* Lesen des Fallarttextes
*---------------------------------------------------------------------*
* -> p1: Einrichtung
* -> p2: Interne Fallart
* <- p3: Fallarttext
*---------------------------------------------------------------------*
FORM get_fatxt USING VALUE(einri) VALUE(falai) fatxt.
  CLEAR fatxt.
* Table beim ersten Mal (wenn sie leer ist) komplett einlesen
  DESCRIBE TABLE itn15t.
  IF sy-tfill < 1.
    SELECT * FROM tn15t INTO TABLE itn15t
                        WHERE spras = sy-langu
                        AND   einri = einri.
    IF sy-subrc <> 0.
      REFRESH itn15t.
      CLEAR itn15t.    " Leeren Datensatz in die ITN15T, damit nicht
      APPEND itn15t.                   " nocheinmal gelesen wird
    ENDIF.
  ENDIF.
  LOOP AT itn15t WHERE falai = falai.
    EXIT.
  ENDLOOP.
  IF sy-subrc = 0.
    fatxt = itn15t-fatxt.
  ENDIF.
ENDFORM.                    "get_fatxt

*&---------------------------------------------------------------------*
*&      Form  get_status_ext
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->VALUE      text
*      -->(EINRI)    text
*      -->VALUE      text
*      -->(INT_ST)   text
*      -->EXT_ST     text
*----------------------------------------------------------------------*
FORM get_status_ext USING VALUE(einri) VALUE(int_st) ext_st.
  CLEAR ext_st.
* Table beim ersten Mal (wenn sie leer ist) komplett einlesen
  DESCRIBE TABLE itn14e.
  IF sy-tfill < 1.
    SELECT * FROM tn14e INTO TABLE itn14e
                        WHERE einri = einri.
    IF sy-subrc <> 0.
      REFRESH itn14e.
      CLEAR itn14e.    " Leeren Datensatz in die ITN14E, damit nicht
      APPEND itn14e.                   " nocheinmal gelesen wird
    ENDIF.
  ENDIF.
  LOOP AT itn14e WHERE status_in = int_st.
    EXIT.
  ENDLOOP.
  IF sy-subrc = 0.
    ext_st = itn14e-status_ex.
  ENDIF.
ENDFORM.                               " GET_STATUS_EXT

***End of MED-48629, Jitareanu Cristina 24.10.2012  "für die Rekonstruktion der Fallliste
