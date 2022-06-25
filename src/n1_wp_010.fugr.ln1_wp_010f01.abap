*----------------------------------------------------------------------*
***INCLUDE LN1_WP_010F01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  check_marked
*&---------------------------------------------------------------------*
FORM check_marked TABLES   pt_messages       STRUCTURE bapiret2
                  USING    value(p_cnt_pat)  TYPE i
                           value(p_cnt_tmn)  TYPE i
                           value(p_cnt_fall) TYPE i
                           value(p_cnt_vkg)  TYPE i
                           value(p_cnt_pap)  TYPE i
                           value(p_fcode)    LIKE rseu1-func
                  CHANGING p_rc              LIKE sy-subrc.

  DATA: l_wa_msg    LIKE bapiret2,
        l_rc        LIKE sy-subrc.
*       L_RC: 0=OK, 1=nichts markiert, 2=zuviel, n=ungültig

  CLEAR: p_rc, l_rc.

* Hier muß der gesamte Funktionsvorrat geprüft werden
* Genaue Dokumentation siehe auch am Ende dieses Forms!
  CASE p_fcode.
*   ------------------------------------------------------------------
*   Genau 1 Vormerkung mit 1 Patienten muß markiert sein
*   Vorläufige Patienten dürfen NICHT markiert sein
*   ------------------------------------------------------------------
*   MINS - Dokument anlegen
*   POPT - Patient Offene Punkte
    WHEN 'MINS' OR 'POPT'.

      CASE p_cnt_vkg.
        WHEN 0.        l_rc = 1.                  "Nichts markiert
        WHEN 1.                                   "OK
*         OK - genau 1 Vormerkung markiert
          IF p_cnt_pat <> 1 AND p_cnt_pap > 0.
*           Vorläufige Patienten nicht erlaubt
            l_rc = 3.                             "NPAP markiert
          ENDIF.
        WHEN OTHERS.   l_rc = 2.                  "Zuviel markiert
      ENDCASE.
*   ------------------------------------------------------------------
*   Mind. 1 Vormerkung mit mind. 1 Patienten muß markiert sein
*   Vorläufige Patienten dürfen NICHT markiert sein
*   ------------------------------------------------------------------
*   ANFUE - Anforderungsübersicht
*   MDIS  - Dokumentenübersicht
    WHEN 'ANFUE' OR 'MDIS'.
      CASE p_cnt_vkg.
        WHEN 0.        l_rc = 1.                  "Nichts markiert
        WHEN OTHERS.                              "OK
*         OK - mind. 1 Vormerkung markiert
          IF p_cnt_pat < 1 OR p_cnt_pap > 0.
*           Vorläufige Patienten nicht erlaubt
            l_rc = 3.                             "NPAP markiert
          ENDIF.
      ENDCASE.
*   ------------------------------------------------------------------
*   Mind. 1 Vormerkung muß markiert sein
*   ob mit Patient oder Vorläufigem Patient ist egal
*   ------------------------------------------------------------------
*   ANFI  - Anforderung anlegen
*   PLTM  - Plantafel aufrufen
*   PLKT  - Tagplaner aufrufen
*   CORD_CANC - Klin. Auftrag stornieren (ID 18657)
    WHEN 'ANFI' OR 'PLTM' OR 'PLKT' OR 'CORD_CANC'.
      CASE p_cnt_vkg.
        WHEN 0.        l_rc = 1.                  "Nichts markiert
        WHEN OTHERS.                              "OK
*         OK - mind. 1 Vormerkung markiert
      ENDCASE.
*   ------------------------------------------------------------------
*   Mind. 1 fallfreie Vormerkung muß markiert sein
*   ob mit Patient oder Vorläufigem Patient ist egal
*   (es dürfen aber nur Vormerkungen von 1 Patienten sein)
*   ------------------------------------------------------------------
*   FALL - Fall zuordnen
    WHEN 'FALL'.
      CASE p_cnt_vkg.
        WHEN 0.        l_rc = 1.                  "Nichts markiert
        WHEN OTHERS.                              "OK
*         OK - mind. 1 Vormerkung markiert
          IF p_cnt_fall > 0.
*           nur fallfreie Vormerkungen erlaubt
            l_rc = 4.                             "Fall markiert
          ENDIF.
          IF p_cnt_pat > 1 OR p_cnt_pap > 1.
*           nur max. 1 Patient oder Vorläufiger Patient erlaubt
            l_rc = 5.                             "Zuviel NPAT/NPAP
          ENDIF.
      ENDCASE.
*   ------------------------------------------------------------------
*   Egal wieviele und welche Einträge markiert sind
*   ------------------------------------------------------------------
    WHEN OTHERS.
      EXIT.
  ENDCASE.

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Richtige Anzahl markiert?
  CASE l_rc.
    WHEN 0.                                                 " OK
    WHEN 1.
      p_rc = 1.
*     Bitte markieren Sie eine Vormerkung
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '771' space space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
    WHEN 2.
      p_rc = 1.
*     Bitte markieren Sie nur eine Vormerkung
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '772' space space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
    WHEN 3.
      p_rc = 1.
*     Funktion für vorläufige Patientendaten nicht erlaubt
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '655' space space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
    WHEN 4.
      p_rc = 1.
*     Bitte nur fallfreie Vormerkungen markieren
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '764' space space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
    WHEN 5.
      p_rc = 1.
*     Bitte markieren Sie nur Vormerkungen desselben Patienten
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '107' space space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
    WHEN OTHERS.
*     Bitte einen gültigen Eintrag markieren
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '110' space space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
  ENDCASE.

* ********************************************************************
* Aufstellung über mögliche/nötige Markierungen jeder Funktion
* ********************************************************************
* >0 ... mind. 1 Objekt muß markiert sein                            *
* 1 .... genau 1 Objekt muß markiert sein                            *
* 0 .... es darf kein solches Objekt markiert sein                   *
* - .... egal ob ein solches Objekt markiert ist                     *
* ********************************************************************
* Funktion  !  Vormerkung  !  Patient  !  Vorl. Pat.  !  Fall        *
* ********************************************************************
* MINS      !     1        !     1     !      0       !     -        *
* ANFUE     !     >0       !     >0    !      0       !     -        *
* FALL      !     >0       !     1   oder     1       !     0        *
* ANFI      !     >0       !     -     !      -       !     -        *
* PLTM      !     >0       !     -     !      -       !     -        *
* PLKT      !     >0       !     -     !      -       !     -        *
* MDIS      !     >0       !     >0    !      0       !     -        *
* POPT      !     >0       !     1     !      0       !     -        *
* ********************************************************************

ENDFORM.                               " CHECK_MARKED
*&---------------------------------------------------------------------*
*&      Form  doc_list
*&---------------------------------------------------------------------*
FORM doc_list TABLES   pt_messages      STRUCTURE bapiret2
              USING    pt_marked        TYPE tyt_marked
                       value(p_einri)   TYPE einri
              CHANGING p_rc             TYPE sy-subrc
                       p_refresh        TYPE n1fld-refresh.

  DATA: l_marked         TYPE ty_marked,
        l_wa_msg         TYPE bapiret2,
        lt_ndoc          TYPE TABLE OF ndoc,
        l_ndoc           TYPE ndoc.

  CLEAR: p_rc, p_refresh.
  REFRESH: lt_ndoc.

* Erzeugen der Selektionskriterien für die Dokumentliste
  LOOP AT pt_marked INTO l_marked.
*   1. Selektionskriterium: Patient
    l_ndoc-mandt = sy-mandt.
    l_ndoc-einri = p_einri.
    l_ndoc-patnr = l_marked-patnr.
    l_ndoc-medok = 'X'.                 " Nur med. Dok.
    APPEND l_ndoc TO lt_ndoc.
*   2. Selektionskriterium: Fall
    IF l_marked-falnr <> space.
      l_ndoc-mandt = sy-mandt.
      l_ndoc-einri = p_einri.
      l_ndoc-patnr = l_marked-patnr.
      l_ndoc-falnr = l_marked-falnr.
      l_ndoc-medok = 'X'.               " Nur med. Dok.
      APPEND l_ndoc TO lt_ndoc.
    ENDIF.
  ENDLOOP.

* Dokumentliste aufrufen
  CALL FUNCTION 'ISH_N2_MEDICAL_DOCUMENT'
    EXPORTING
      ss_einri    = p_einri
      ss_tcode    = 'N204'
    TABLES
      ss_ndoc     = lt_ndoc
    EXCEPTIONS
      no_document = 1
      no_insert   = 2
      cancel      = 3
      OTHERS      = 4.

  CASE sy-subrc.
    WHEN 0.
      p_rc = 0.
      p_refresh = 1.
    WHEN 1.
*     Für die Selektionskriterien liegen keine Dokumente vor
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '748' space space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
    WHEN 2 OR 3.                     " Abbruch, kein Dokument
      p_rc = 2.
      p_refresh = 0.
  ENDCASE.

ENDFORM.                               " DOC_LIST
*&---------------------------------------------------------------------*
*&      Form  doc_create
*&---------------------------------------------------------------------*
FORM doc_create TABLES   pt_messages      STRUCTURE bapiret2
                USING    pt_marked        TYPE tyt_marked
                         value(p_einri)   TYPE einri
                CHANGING p_rc             TYPE sy-subrc
                         p_refresh        TYPE n1fld-refresh.

  DATA: lt_ndoc        TYPE TABLE OF ndoc,
        l_ndoc         TYPE ndoc,
        l_wa_msg       TYPE bapiret2,
        l_etroe        TYPE n1vkg-etroe,
        l_marked       TYPE ty_marked.

  CLEAR: p_rc, p_refresh.

  READ TABLE pt_marked INTO l_marked INDEX 1.
  CHECK sy-subrc = 0 AND NOT l_marked-patnr IS INITIAL.

* 1 Patient markiert -> OK
  SELECT SINGLE etroe FROM n1vkg INTO l_etroe
                      WHERE vkgid = l_marked-vkgid.

  CLEAR l_ndoc.
  REFRESH lt_ndoc.

  l_ndoc-mandt = sy-mandt.
  l_ndoc-einri = p_einri.
  l_ndoc-orgdo = l_etroe.
  l_ndoc-patnr = l_marked-patnr.
  l_ndoc-falnr = l_marked-falnr.
  l_ndoc-medok = 'X'.                   " Nur med. Dok.
  GET PARAMETER ID 'VMA' FIELD l_ndoc-mitarb.
  APPEND l_ndoc TO lt_ndoc.

* ID 13574: preallocate set/get-parameter DTY (document type)
  IF tcode = 'N201'.
    CALL FUNCTION 'ISHMED_SET_GET_DTY'
      EXPORTING
        i_institution = p_einri
        i_date        = sy-datum
        i_orgid       = l_ndoc-orgdo.
  ENDIF.

* FB jetzt aufrufen
  CALL FUNCTION 'ISH_N2_MEDICAL_DOCUMENT'
    EXPORTING
      ss_einri           = p_einri
      ss_tcode           = 'N201'
*     ss_set_screen_flag = 'X' "REM MED-33621
    TABLES
      ss_ndoc            = lt_ndoc
    EXCEPTIONS
      no_document        = 1
      no_insert          = 2
      cancel             = 3
      OTHERS             = 4.

  CASE sy-subrc.
    WHEN 0.
      p_rc = 0.
      p_refresh = 1.
    WHEN 1.
*     Für die Selektionskriterien liegen keine Dokumente vor
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '748' space space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
    WHEN 2 OR 3.                     " Abbruch, kein Dokument
      p_rc = 2.
      p_refresh = 0.
  ENDCASE.

ENDFORM.                               " DOC_CREATE
*&---------------------------------------------------------------------*
*&      Form  pat_monitor
*&---------------------------------------------------------------------*
FORM pat_monitor TABLES   pt_messages       STRUCTURE bapiret2
                 USING    pt_marked         TYPE tyt_marked
                          value(p_einri)    TYPE einri
                 CHANGING p_rc              TYPE sy-subrc
                          p_refresh         TYPE n1fld-refresh.

  DATA: lt_rn1po_call  TYPE TABLE OF rn1po_call,
        l_rn1po_call   LIKE LINE OF lt_rn1po_call,
        l_marked       TYPE ty_marked,
        l_n1vkg        TYPE n1vkg,
        l_plnoe        TYPE orgid.

  CLEAR: p_rc, p_refresh.

  LOOP AT pt_marked INTO l_marked.
    SELECT SINGLE * FROM n1vkg INTO l_n1vkg
           WHERE  vkgid  = l_marked-vkgid.
    CHECK sy-subrc = 0. " AND NOT l_n1vkg-patnr IS INITIAL.
    l_plnoe = l_n1vkg-orgid.
    READ TABLE lt_rn1po_call TRANSPORTING NO FIELDS
      WITH KEY patnr = l_n1vkg-patnr
               papid = l_n1vkg-papid.
    IF sy-subrc <> 0.
      CLEAR: l_rn1po_call.
      l_rn1po_call-patnr  = l_n1vkg-patnr.
      l_rn1po_call-papid  = l_n1vkg-papid.
      l_rn1po_call-einri  = l_n1vkg-einri.
      l_rn1po_call-falnr  = l_n1vkg-falnr.
      l_rn1po_call-falar  = l_n1vkg-falar.
      l_rn1po_call-lfdbew = ' '.
      l_rn1po_call-lfddia = ' '.
      l_rn1po_call-orgfa  = l_n1vkg-orgfa.
      l_rn1po_call-orgpf  = l_n1vkg-orgid.
      l_rn1po_call-uname  = sy-uname.
      l_rn1po_call-repid  = sy-repid.
      l_rn1po_call-viewid = ' '.
      INSERT l_rn1po_call INTO TABLE lt_rn1po_call.
    ENDIF.
  ENDLOOP.

*  IF NOT lt_rn1po_call[] IS INITIAL. "Grill, ID-18609
*   don't sort patient table (ID 13826)
**   Tabelle nach Patient sortieren
*    SORT lt_rn1po_call BY mandt einri patnr.

*   FBS Patientenorganizers/Patientenhistorie aufrufen
  CALL FUNCTION 'ISHMED_DISPLAY_PATDATA'
    EXPORTING
      i_plnoe      = l_plnoe
    TABLES
      t_rn1po_call = lt_rn1po_call.
*  ENDIF.  "Grill, ID-18609

ENDFORM.                               " PAT_MONITOR
*&---------------------------------------------------------------------*
*&      Form  pat_tmn_list
*&---------------------------------------------------------------------*
FORM pat_tmn_list TABLES   pt_messages       STRUCTURE bapiret2
                  USING    pt_marked         TYPE tyt_marked
                           value(p_einri)    TYPE einri
                  CHANGING p_rc              TYPE sy-subrc
                           p_refresh         TYPE n1fld-refresh.

  DATA: l_ntmn           TYPE ntmn,
        l_wa_msg         TYPE bapiret2,
        ls_marked        TYPE ty_marked,
        ls_rn1po_call    TYPE rn1po_call,
        lt_rn1po_call    TYPE ishmed_t_rn1po_call,
        ls_n1vkg         TYPE n1vkg,
        l_plnoe         TYPE orgid.

  CLEAR: p_rc, p_refresh, l_plnoe, ls_n1vkg.

* get patients and provisional patients from marked entries
  LOOP AT pt_marked INTO ls_marked
    WHERE NOT patnr IS INITIAL OR
          NOT papid IS INITIAL.
    READ TABLE lt_rn1po_call TRANSPORTING NO FIELDS
      WITH KEY patnr = ls_marked-patnr
               papid = ls_marked-papid.
    IF sy-subrc <> 0.
      ls_rn1po_call-einri = ls_marked-einri.
      ls_rn1po_call-patnr = ls_marked-patnr.
      ls_rn1po_call-papid = ls_marked-papid.
      APPEND ls_rn1po_call TO lt_rn1po_call.
    ENDIF.
    IF l_plnoe IS INITIAL.
      SELECT SINGLE * FROM n1vkg INTO ls_n1vkg
                    WHERE vkgid = ls_marked-vkgid.
      CHECK sy-subrc = 0.
      l_plnoe = ls_n1vkg-orgid.
    ENDIF.
  ENDLOOP.

* call appointment calendar for patients
  CALL FUNCTION 'ISHMED_DISPLAY_APPCAL'
    EXPORTING
      i_einri       = g_institution
      i_popup       = 'X'
      i_plnoe       = l_plnoe
    TABLES
      it_rn1po_call = lt_rn1po_call.

  p_rc = 0.
  p_refresh = 2.

ENDFORM.                    "pat_tmn_list
*&---------------------------------------------------------------------*
*&      Form  call_lab_data
*&---------------------------------------------------------------------*
FORM call_lab_data TABLES   pt_messages      STRUCTURE bapiret2
                   USING    pt_marked        TYPE tyt_marked
                   CHANGING p_rc             TYPE sy-subrc
                            p_refresh        TYPE n1fld-refresh.

  DATA: l_wa_msg       TYPE bapiret2,
        l_orgid        TYPE norg-orgid,
        l_n1vkg        TYPE n1vkg,
        l_display_mode(1)  TYPE c,
        l_marked       TYPE ty_marked.

  CLEAR: p_rc, p_refresh, l_orgid, l_marked, l_wa_msg, l_n1vkg.

* Check ob Fall übergeben wurde oder ohne Markierung
* Verarbeitung (entweder keiner oder 1 Datensatz markiert)
  READ TABLE pt_marked INTO l_marked INDEX 1.
  IF sy-subrc = 0 AND NOT l_marked-vkgid IS INITIAL.
    SELECT SINGLE * FROM n1vkg INTO l_n1vkg
                    WHERE vkgid = l_marked-vkgid.
    IF sy-subrc = 0.
      l_orgid = l_n1vkg-etroe.
    ENDIF.
  ENDIF.

  CALL FUNCTION 'ISH_N2_DISPLAY_LAB_DATA'
    EXPORTING
      ss_einri          = l_marked-einri
      ss_patnr          = l_marked-patnr
      ss_falnr          = l_marked-falnr
      ss_oe             = l_orgid
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
    WHEN OTHERS.
*     Fehler bei der Verarbeitung (Nr. &)
      PERFORM build_bapiret2(sapmn1pa)
              USING sy-msgty sy-msgid sy-msgno
                    sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
  ENDCASE.

ENDFORM.                               " CALL_LAB_DATA

*&---------------------------------------------------------------------*
*&      Form  vkg_fall_assign
*&---------------------------------------------------------------------*
FORM vkg_fall_assign TABLES   pt_messages       STRUCTURE bapiret2
                     USING    pt_marked         TYPE tyt_marked
                              value(p_einri)    TYPE einri
                     CHANGING p_rc              TYPE sy-subrc
                              p_refresh         TYPE n1fld-refresh.

  DATA: ls_marked      TYPE ty_marked,
        ls_npap        TYPE npap,
        l_papid        TYPE npap-papid,
        l_vkgid        TYPE n1vkg-vkgid,
        l_papname(40)  TYPE c,
        l_patname(40)  TYPE c,
        l_patnr        TYPE npat-patnr,
        l_popup        TYPE c,
        l_wa_msg       TYPE bapiret2,
        l_rc           TYPE ish_method_rc.

  DATA: ls_in1vkg      TYPE n1vkg,
        lt_in1vkg      TYPE TABLE OF n1vkg,
        ls_npat        TYPE npat,
        lt_npat        TYPE TABLE OF npat,
        lt_messages    TYPE bapiret2_t,
        lr_env         TYPE REF TO cl_ish_environment,
        lr_error       TYPE REF TO cl_ishmed_errorhandling.

* Initialisierungen
  CLEAR: p_rc, p_refresh.

  REFRESH: lt_in1vkg, lt_npat.
  CLEAR:   ls_marked, ls_npap, l_papname, l_patname,
           ls_in1vkg, lr_env, lr_error.

  READ TABLE pt_marked INTO ls_marked INDEX 1.
  CHECK sy-subrc = 0.

* Vormerkung für vorläufige PatStammdaten -> PatIdentifikation nötig
  IF NOT ls_marked-papid IS INITIAL.
    CALL METHOD cl_ishmed_functions=>switch_and_delete_npap
      EXPORTING
        i_einri        = p_einri
        i_papid        = ls_marked-papid
      IMPORTING
        e_patnr        = l_patnr
        e_rc           = l_rc
      CHANGING
        c_errorhandler = lr_error
        c_environment  = lr_env.
    CASE l_rc.
      WHEN 0.
*       OK
      WHEN 2.
        p_rc = 2.                           " Cancel
      WHEN OTHERS.
        p_rc = 1.                           " Error
        CALL METHOD lr_error->get_messages
          IMPORTING
            t_messages = lt_messages.
        LOOP AT lt_messages INTO l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
        ENDLOOP.
    ENDCASE.
  ENDIF.

  IF NOT lr_env IS INITIAL.                                 " ID 14700
    CALL METHOD cl_ish_utl_base=>destroy_env
      CHANGING
        cr_environment = lr_env.
  ENDIF.                                                    " ID 14700

  IF p_rc <> 0.
    EXIT.
  ENDIF.

* Check: Vormerkung(en) bereits einem Fall zugeordnet?
  LOOP AT pt_marked INTO ls_marked.
    SELECT SINGLE * FROM n1vkg INTO ls_in1vkg
                    WHERE vkgid = ls_marked-vkgid.
    IF NOT ls_marked-falnr IS INITIAL.
      CLEAR: l_patname.
      CALL METHOD cl_ish_utl_base_patient=>get_name_patient
        EXPORTING
          i_patnr = ls_marked-patnr
          i_list  = on
        IMPORTING
          e_pname = l_patname.
*     Msg: Vormerkung hat bereits Bezug zu Fall Nr. .....
      PERFORM build_bapiret2(sapmn1pa)
           USING 'E' 'NF1' '108' l_patname
                                 ls_in1vkg-orgid
                                 ls_in1vkg-falnr
                                 space space space space
           CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
    ELSE.
*     Vormerkung ok
      APPEND ls_in1vkg TO lt_in1vkg.
    ENDIF.
  ENDLOOP.

  READ TABLE lt_in1vkg INTO ls_in1vkg INDEX 1.
  CHECK sy-subrc = 0.

  IF NOT ls_in1vkg-patnr IS INITIAL.
    CLEAR l_papid.
  ENDIF.

* Abgleich vorläufiger <> echter Patient erfolgt
  IF NOT ls_marked-papid IS INITIAL AND NOT l_patnr IS INITIAL.
    LOOP AT lt_in1vkg INTO ls_in1vkg.
      ls_in1vkg-patnr = l_patnr.
      CLEAR ls_in1vkg-papid.
      MODIFY lt_in1vkg FROM ls_in1vkg TRANSPORTING patnr papid.
    ENDLOOP.
  ENDIF.

  CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
    EXPORTING
      i_patnr   = ls_in1vkg-patnr
      i_read_db = on
    IMPORTING
      es_npat   = ls_npat
      e_rc      = l_rc.
  CHECK l_rc = 0.

  l_popup = 'B'.     " Bestätigungspopup nach Fallauswahl

* Fallbezug herstellen
  CALL FUNCTION 'ISHMED_MAKE_FALLBEZUG'
    EXPORTING
*     I_NFAL           =
      i_npat           = ls_npat
*     I_NBEW           =
      i_popup          = l_popup
*     I_MODE           = ' '
      i_savetab        = 'X'
      i_check_lock_pat = 'X'                                "MED-42937
*     I_CHECK_CASE     = 'X'
      i_einri          = p_einri
      i_commit         = 'X'
      i_papid          = l_papid
*     i_control        = 'X'                                "MED-31673
    TABLES
      t_n1vkg          = lt_in1vkg
    EXCEPTIONS
      fal_not_fnd      = 1
      no_anf_vkg       = 2
      fal_not_valid    = 3
      cancel           = 4
      OTHERS           = 5.

  CASE sy-subrc.
    WHEN 0.
      p_rc = 0.
      p_refresh = 1.
    WHEN 1.
*     Fall nicht gefunden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '109' ls_npat-patnr p_einri
                                    space space space
                                    space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
    WHEN 2.
*     Nichts gefunden/geändert - aber OK
      p_rc = 0.
      p_refresh = 0.
    WHEN 3.
*     Fall nicht korrekt
* Begin, Siegl, Med-31673
      PERFORM build_bapiret2(sapmn1pa)
                 USING 'E' 'NF' '813' ls_marked-falnr space space space
                       space space space
*              USING 'E' 'NF' '051' ls_marked-falnr space space space
*                                   space space space
* End, Siegl, Med-31673
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
    WHEN 4.
      p_rc = 2.            " Cancel
      p_refresh = 0.
    WHEN OTHERS.
*     Fehler in der Bearbeitung
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '139' sy-subrc space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
  ENDCASE.

* Den GUI-Status des Klinischen Arbeitsplatzes wieder setzen,
* da er sonst weg sein kann ...
  CALL FUNCTION 'ISH_WP_GUI_SET'
    EXPORTING
      i_user_id = sy-uname.

ENDFORM.                               " VKG_FALL_ASSIGN
*&---------------------------------------------------------------------*
*&      Form  PAT_OPEN_POINTS
*&---------------------------------------------------------------------*
FORM pat_open_points TABLES   pt_messages       STRUCTURE bapiret2
                     USING    pt_marked         TYPE tyt_marked
                              value(p_einri)    TYPE einri
                     CHANGING p_rc              TYPE sy-subrc
                              p_refresh         TYPE n1fld-refresh.


  DATA:  ls_n1orgpar    TYPE n1orgpar,
         lt_n1orgpar    TYPE TABLE OF n1orgpar,
         l_wa_msg       TYPE bapiret2,
         ls_marked      TYPE ty_marked.
  DATA:  l_n1ofpdat     TYPE i,           " Tage +/- sy-datum =
                                          " Entlassungsdatum
         l_n1ofppop     TYPE ish_on_off,  " Popup 'Entlassungsdatum'
                                          " bringen
         l_edatum       TYPE sy-datum.
  DATA:  ls_n1vkg       TYPE n1vkg,
         l_orgid        TYPE norg-orgid.

  CLEAR: p_rc, p_refresh.
  CLEAR: ls_marked.
  READ TABLE pt_marked INTO ls_marked INDEX 1.
  CHECK sy-subrc = 0.

* Erbr. OE aus markiertem Eintrag nehmen
* Vorbelegung 'Entlassungsdatum'
  CLEAR:  ls_n1orgpar, ls_n1vkg.
  REFRESH lt_n1orgpar.

  SELECT SINGLE * FROM n1vkg INTO ls_n1vkg
                  WHERE vkgid = ls_marked-vkgid.
  CHECK sy-subrc = 0.
  l_orgid = ls_n1vkg-orgid.

  PERFORM read_n1orgpar IN PROGRAM sapl0n1s TABLES   lt_n1orgpar
                                            USING    p_einri
                                                     l_orgid
                                                     'N1OFPDAT'
                                                     sy-datum.

  READ TABLE lt_n1orgpar INTO ls_n1orgpar INDEX 1.
  IF sy-subrc = 0.
    l_n1ofpdat = ls_n1orgpar-n1parwert.
    l_edatum   = sy-datum + l_n1ofpdat.
  ELSE.
    l_edatum   = sy-datum.
  ENDIF.

* Popup 'Entlassungsdatum' bringen
  CLEAR:   ls_n1orgpar.
  REFRESH: lt_n1orgpar.

  PERFORM read_n1orgpar IN PROGRAM sapl0n1s TABLES   lt_n1orgpar
                                            USING    p_einri
                                                     l_orgid
                                                     'N1OFPPOP'
                                                     sy-datum.
  READ TABLE lt_n1orgpar INTO ls_n1orgpar INDEX 1.
  IF sy-subrc = 0.
    l_n1ofppop = ls_n1orgpar-n1parwert.
  ELSE.
    l_n1ofppop = on.
  ENDIF.

  CALL FUNCTION 'ISHMED_PATIENT_OFFENE_PUNKTE'
    EXPORTING
      i_einri         = p_einri
      i_patnr         = ls_marked-patnr
      i_falnr         = ls_marked-falnr
      i_popup         = l_n1ofppop
      i_entdt         = l_edatum
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
      p_rc = 2.                " Cancel
      p_refresh = 0.
      EXIT.
    WHEN 2.
*     Patientennummer nicht korrekt
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '387' ls_marked-patnr space space space
                                   space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      p_refresh = 0.
      EXIT.
    WHEN 3.
*     Fall nicht korrekt
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF' '051' ls_marked-falnr space space space
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

ENDFORM.                    " PAT_OPEN_POINTS
*&---------------------------------------------------------------------*
*&      Form  vkg_plan_tafel
*&---------------------------------------------------------------------*
FORM vkg_plan_tafel TABLES   p_t_messages      STRUCTURE bapiret2
                    USING    pt_marked         TYPE tyt_marked
                             value(p_einri)    TYPE einri
                             value(p_planoe)   TYPE orgid
                    CHANGING p_rc              TYPE sy-subrc
                             p_refresh         TYPE n1fld-refresh.

  DATA:  lt_sort      TYPE ishmed_t_plantsort,
         ls_sort      LIKE LINE OF lt_sort.
  DATA:  ls_marked    TYPE ty_marked,
         ls_n1vkg     TYPE n1vkg,
         lt_n1vkg     TYPE TABLE OF n1vkg,
         ls_nlei      TYPE nlei,
         lt_nlei      TYPE TABLE OF nlei,
         ls_nlem      TYPE nlem,
         lt_nlem      TYPE TABLE OF nlem.
  DATA:  ls_npat      TYPE npat,
         lt_npat      TYPE TABLE OF npat.
  DATA:  l_rc         TYPE i,
         l_count      TYPE i.

  CLEAR:  ls_marked, ls_n1vkg, p_rc, p_refresh.

  READ TABLE pt_marked INTO ls_marked INDEX 1.
  CHECK sy-subrc = 0.

* get order positions out of marked table here directly
  CLEAR ls_marked.
  LOOP AT pt_marked INTO ls_marked WHERE NOT vkgid IS INITIAL.
    SELECT SINGLE * FROM n1vkg INTO ls_n1vkg
                    WHERE vkgid = ls_marked-vkgid.
    CHECK sy-subrc = 0.
    APPEND ls_n1vkg TO lt_n1vkg.
  ENDLOOP.

* Überhaupt noch welche übrig?
  DESCRIBE TABLE lt_n1vkg.
* Falls keine Einträge ausgewählt sind wird die Plantafel
* nur mit einem Patienten (=unbekannt) aufgerufen.
  IF sy-tfill = 0.
    CLEAR ls_npat.
    INSERT ls_npat INTO TABLE lt_npat.
  ENDIF.

* Leistungen zu den Vormerkungen aufbereiten
  REFRESH: lt_nlei, lt_nlem.
  LOOP AT lt_n1vkg INTO ls_n1vkg.
    SELECT * FROM nlem INTO ls_nlem
             WHERE vkgid = ls_n1vkg-vkgid
             AND   ankls = space.
      APPEND ls_nlem TO lt_nlem.
      SELECT SINGLE * FROM nlei INTO ls_nlei
                      WHERE lnrls = ls_nlem-lnrls.
      APPEND ls_nlei TO lt_nlei.
    ENDSELECT.
  ENDLOOP.

  CLASS cl_ishmed_todo_list DEFINITION LOAD.

* Sortierung festlegen
  LOOP AT lt_n1vkg INTO ls_n1vkg.
    CLEAR ls_sort.
    l_count = l_count + 1.
    ls_sort-vkgid = ls_n1vkg-vkgid.
    ls_sort-kz    = cl_ishmed_todo_list=>co_prereg.
    ls_sort-sort  = l_count.
    INSERT ls_sort INTO TABLE lt_sort.
  ENDLOOP.

* Aufruf der Plantafel
  CALL FUNCTION 'ISHMED_POB_SCHEDULE'
    EXPORTING
      i_einri = p_einri
      i_plnoe = p_planoe         " Planende org.Einheit
      i_stdat = sy-datum
      i_sort  = lt_sort          " Sortierung
    IMPORTING
      e_rc    = l_rc
    TABLES
*     t_n1anf = a_n1anf
      t_n1vkg = lt_n1vkg
      t_nlei  = lt_nlei
      t_nlem  = lt_nlem
      t_npat  = lt_npat
*     t_ntmn  =
*     t_napp  =
    EXCEPTIONS
      OTHERS  = 1.

  IF sy-subrc = 0 AND l_rc = 0.
    p_rc = 0.
    p_refresh = 1.
  ELSEIF sy-subrc = 0 AND l_rc = 12.
    p_rc = 2.                             " Cancel
    p_refresh = 0.
  ELSE.
    p_rc = 1.
    p_refresh = 0.
  ENDIF.

ENDFORM.                    " vkg_plan_tafel
*&---------------------------------------------------------------------*
*&      Form  vkg_plan_tag
*&---------------------------------------------------------------------*
FORM vkg_plan_tag   TABLES   p_t_messages      STRUCTURE bapiret2
                    USING    pt_marked         TYPE tyt_marked
                             value(p_einri)    TYPE einri
                    CHANGING p_rc              TYPE sy-subrc
                             p_refresh         TYPE n1fld-refresh.

  DATA:   ls_marked    TYPE ty_marked,
          ls_n1vkg     TYPE n1vkg,
          lt_n1vkg     TYPE TABLE OF n1vkg,
          ls_nlem      TYPE nlem,
          lt_nlem      TYPE TABLE OF nlem,
          ls_nlei      TYPE nlei,
          lt_nlei      TYPE TABLE OF nlei,
          lt_ntmn      TYPE TABLE OF ntmn,
          l_vkgid      TYPE n1vkg-vkgid,
          l_orgid      TYPE norg-orgid,
          l_orgfa      TYPE norg-orgid.

  CLEAR:  l_orgid, ls_marked, ls_n1vkg, p_rc, p_refresh.

  READ TABLE pt_marked INTO ls_marked INDEX 1.
  CHECK sy-subrc = 0.

* get order positions out of marked table here directly
  CLEAR ls_marked.
  LOOP AT pt_marked INTO ls_marked WHERE NOT vkgid IS INITIAL.
    SELECT SINGLE * FROM n1vkg INTO ls_n1vkg
                    WHERE vkgid = ls_marked-vkgid.
    CHECK sy-subrc = 0.
    APPEND ls_n1vkg TO lt_n1vkg.
  ENDLOOP.

* Leistungen zu den übrigen Vormerkungen aufbereiten
  REFRESH: lt_nlei, lt_nlem.
  LOOP AT lt_n1vkg INTO ls_n1vkg.
    SELECT * FROM nlem INTO ls_nlem
             WHERE vkgid = ls_n1vkg-vkgid
             AND   ankls = space.
      APPEND ls_nlem TO lt_nlem.
      SELECT SINGLE * FROM nlei INTO ls_nlei
                      WHERE lnrls = ls_nlem-lnrls.
      APPEND ls_nlei TO lt_nlei.
    ENDSELECT.
  ENDLOOP.
  l_orgfa = '*'.
  l_orgid = '*'.
* Kontingentplaner aufrufen
* Aufnahmeplanung: Übergabe des Fachbereiches.
  PERFORM vkg_plan_tag_exec TABLES lt_n1vkg
                                   lt_nlei
                                   lt_nlem
                                   lt_ntmn
                            USING  p_einri
                                   l_orgid
                                   l_orgfa
                                   p_rc
                                   p_refresh.

ENDFORM.                    " vkg_plan_tag
*&---------------------------------------------------------------------*
*&      Form  vkg_plan_tag_exec
*&---------------------------------------------------------------------*
FORM vkg_plan_tag_exec TABLES   p_n1vkg   STRUCTURE n1vkg
                                p_nlei    STRUCTURE nlei
                                p_nlem    STRUCTURE nlem
                                p_ntmn    STRUCTURE ntmn
                       USING    p_einri   TYPE      einri
                                p_orgid   LIKE      norg-orgid
                                p_orgfa   LIKE      norg-orgid
                                p_rc      TYPE sy-subrc
                                p_refresh TYPE n1fld-refresh.

  DATA: l_datvo     TYPE sy-datum,
        l_datbi     TYPE sy-datum.
  DATA: ls_n1vkg    TYPE n1vkg,
        lt_n1vkg    TYPE STANDARD TABLE OF n1vkg,
        lt_nlei     TYPE STANDARD TABLE OF nlei,
        lt_nlem     TYPE STANDARD TABLE OF nlem,
        lt_ntmn     TYPE STANDARD TABLE OF ntmn,
        lt_sort     TYPE ishmed_t_plantsort,
        ls_sort     TYPE rn1plantsort.
  DATA: l_count     TYPE i,
        l_rc        TYPE sy-subrc.
  DATA: l_mode(2)   TYPE c.

  CLEAR: p_rc, p_refresh.

* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- *
* Um auf Konstante der Klasse der Eingangsliste des Tagplaners
* Zugriff zu haben (für die Sortierung von Vorteil).
  CLASS cl_ishmed_todo_list DEFINITION LOAD.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- *
* Übernahme der ausgewählten Vormerkungen.
  lt_n1vkg[] = p_n1vkg[].
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- *

* Sortierung festlegen
  LOOP AT lt_n1vkg INTO ls_n1vkg.
    CLEAR ls_sort.
    l_count = l_count + 1.
    ls_sort-vkgid = ls_n1vkg-vkgid.
    ls_sort-kz    = cl_ishmed_todo_list=>co_prereg.
    ls_sort-sort  = l_count.
    INSERT ls_sort INTO TABLE lt_sort.
  ENDLOOP.

* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- *
* Planungszeitraum für Kontingentplaner festlegen
  CALL FUNCTION 'ISHMED_TAGPLAN_GET_INTERVAL'
    EXPORTING
      einri     = p_einri
      orgid     = p_orgid
      datum     = sy-datum
    IMPORTING
      von_datum = l_datvo
      bis_datum = l_datbi
    EXCEPTIONS
      OTHERS    = 1.
  IF sy-subrc <> 0.
  ENDIF.
  IF NOT lt_sort IS INITIAL.
    l_mode = 'AL'.
  ENDIF.

* Tagplaner aufrufen
  CALL FUNCTION 'ISHMED_TAGPLAN_SHOW'
    EXPORTING
      einri           = p_einri
      orgid           = p_orgid
      i_orgfa         = p_orgfa
      von_datum       = l_datvo
      bis_datum       = l_datbi
      i_sort          = lt_sort
      i_planning_mode = l_mode
    IMPORTING
      e_rc            = l_rc
    TABLES
      t_n1vkg         = lt_n1vkg
      t_nlei          = lt_nlei
      t_nlem          = lt_nlem
      t_ntmn          = lt_ntmn
    EXCEPTIONS
      ocx_error       = 1
      OTHERS          = 2.

  IF sy-subrc = 0 AND l_rc = 0.
    p_rc = 0.
    p_refresh = 1.
  ELSEIF sy-subrc = 0 AND l_rc = 12.
    p_rc = 2.                         " Cancel
    p_refresh = 0.
  ELSE.
    p_rc = 1.
    p_refresh = 0.
  ENDIF.

ENDFORM.                    " vkg_plan_tag_exec
*&---------------------------------------------------------------------*
*&      Form  go_next_prev
*&---------------------------------------------------------------------*
*       switch to next or previous selection period
*----------------------------------------------------------------------*
FORM go_next_prev USING    value(p_view_id)   TYPE nviewid
                           value(p_view_type) TYPE nviewtype
                           value(p_wplace_id) TYPE nwplaceid
                           value(p_einri)     TYPE einri
                           value(p_next)      TYPE ish_on_off
                           value(p_prev)      TYPE ish_on_off
                           value(p_calender)  TYPE ish_on_off
                  CHANGING p_rc               TYPE sy-subrc
                           p_refresh          TYPE n1fld-refresh.


  DATA: lt_selvar       TYPE ishmed_t_rsparams,
        l_selvar        LIKE LINE OF lt_selvar,
        l_date_low_old  TYPE sy-datum,
        l_date_high_old TYPE sy-datum,
        l_date_low_new  TYPE sy-datum,
        l_date_high_new TYPE sy-datum,
        l_select_date   TYPE workflds-gkday,
        l_select_begin  TYPE sy-datum,
        l_select_end    TYPE sy-datum,
        l_repid         TYPE sy-repid,
        l_kh_cal        TYPE scal-fcalid,    "Krankenhauskalender
*        l_hol_cal       TYPE scal-fcalid,    "Ferienkalender
*        l_tfacd         TYPE tfacd,
        l_value         TYPE tn00r-value.

  CLEAR: p_rc, p_refresh, l_kh_cal, l_value,
         l_date_low_old, l_date_low_new,
         l_date_high_old, l_date_high_new,
         l_select_date, l_select_begin, l_select_end.

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

** get actual selection period  (not implemented yet)
*  LOOP AT lt_selvar INTO l_selvar
*                   WHERE selname = 'S_ADMDT1' OR
*                         selname = 'S_ADMDT2' OR
*                         selname = 'S_TRMDT1' OR
*                         selname = 'S_TRMDT2' OR
*                         selname = 'S_CXVLD1' OR
*                         selname = 'S_CXVLD2' OR
*                         selname = 'S_WLADT1' OR
*                         selname = 'S_WLADT2' OR
*                         selname = 'S_ABSDT1' OR
*                         selname = 'S_ABSDT2' OR
*                         selname = 'S_NABSD1' OR
*                         selname = 'S_NABSD2' OR
*                         selname = 'S_MOVDT1' OR
*                         selname = 'S_MOVDT2' OR
*                         selname = 'S_INSDT1' OR
*                         selname = 'S_INSDT2' OR
*                         selname = 'S_UPDDT1' OR
*                         selname = 'S_UPDDT2'.
*    CHECK l_selvar-low NE space AND l_selvar-low NE '00000000'.
*    l_date_low_old  = l_selvar-low.
*    l_date_high_old = l_selvar-low.
**   ...
*  ENDLOOP.

* switch to next or previous selection period
  IF p_next = on.
    EXIT.  " not implemented yet
  ELSEIF p_prev = on.
    EXIT.  " not implemented yet
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
        select_option_week           = on
        select_option_month          = on
      IMPORTING
        select_date                  = l_select_date
*       SELECT_WEEK                  =
        select_begin                 = l_select_begin
        select_end                   = l_select_end
*       SELECT_MONTH                 =
      EXCEPTIONS
        calendar_buffer_not_loadable = 1
        date_after_range             = 2
        date_before_range            = 3
        date_invalid                 = 4
        factory_calendar_not_found   = 5
        holiday_calendar_not_found   = 6
        parameter_conflict           = 7
        OTHERS                       = 8.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
  ELSE.
    EXIT.
  ENDIF.

* change info in selection variant
  IF p_calender = on.
    IF NOT l_select_begin IS INITIAL AND NOT l_select_end IS INITIAL.
*
      CLEAR: l_date_low_new, l_date_high_new.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_ADMDT1'.
        l_date_low_new  = l_selvar-low.
      ENDLOOP.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_ADMDT2'.
        l_date_high_new = l_selvar-low.
      ENDLOOP.
      IF ( l_date_low_new  <> space AND l_date_low_new  <> '00000000' ) OR
         ( l_date_high_new <> space AND l_date_high_new <> '00000000' ).
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_ADMDT1'.
          l_selvar-low = l_select_begin.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_ADMDT2'.
          l_selvar-low = l_select_end.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
      ENDIF.
*
      CLEAR: l_date_low_new, l_date_high_new.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_TRMDT1'.
        l_date_low_new  = l_selvar-low.
      ENDLOOP.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_TRMDT2'.
        l_date_high_new = l_selvar-low.
      ENDLOOP.
      IF ( l_date_low_new  <> space AND l_date_low_new  <> '00000000' ) OR
         ( l_date_high_new <> space AND l_date_high_new <> '00000000' ).
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_TRMDT1'.
          l_selvar-low = l_select_begin.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_TRMDT2'.
          l_selvar-low = l_select_end.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
      ENDIF.
*
      CLEAR: l_date_low_new, l_date_high_new.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_CXVLD1'.
        l_date_low_new  = l_selvar-low.
      ENDLOOP.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_CXVLD2'.
        l_date_high_new = l_selvar-low.
      ENDLOOP.
      IF ( l_date_low_new  <> space AND l_date_low_new  <> '00000000' ) OR
         ( l_date_high_new <> space AND l_date_high_new <> '00000000' ).
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_CXVLD1'.
          l_selvar-low = l_select_begin.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_CXVLD2'.
          l_selvar-low = l_select_end.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
      ENDIF.
*
      CLEAR: l_date_low_new, l_date_high_new.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_WLADT1'.
        l_date_low_new  = l_selvar-low.
      ENDLOOP.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_WLADT2'.
        l_date_high_new = l_selvar-low.
      ENDLOOP.
      IF ( l_date_low_new  <> space AND l_date_low_new  <> '00000000' ) OR
         ( l_date_high_new <> space AND l_date_high_new <> '00000000' ).
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_WLADT1'.
          l_selvar-low = l_select_begin.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_WLADT2'.
          l_selvar-low = l_select_end.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
      ENDIF.
*
      CLEAR: l_date_low_new, l_date_high_new.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_ABSDT1'.
        l_date_low_new  = l_selvar-low.
      ENDLOOP.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_ABSDT2'.
        l_date_high_new = l_selvar-low.
      ENDLOOP.
      IF ( l_date_low_new  <> space AND l_date_low_new  <> '00000000' ) OR
         ( l_date_high_new <> space AND l_date_high_new <> '00000000' ).
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_ABSDT1'.
          l_selvar-low = l_select_begin.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_ABSDT2'.
          l_selvar-low = l_select_end.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
      ENDIF.
*
      CLEAR: l_date_low_new, l_date_high_new.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_NABSD1'.
        l_date_low_new  = l_selvar-low.
      ENDLOOP.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_NABSD2'.
        l_date_high_new = l_selvar-low.
      ENDLOOP.
      IF ( l_date_low_new  <> space AND l_date_low_new  <> '00000000' ) OR
         ( l_date_high_new <> space AND l_date_high_new <> '00000000' ).
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_NABSD1'.
          l_selvar-low = l_select_begin.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_NABSD2'.
          l_selvar-low = l_select_end.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
      ENDIF.
*
      CLEAR: l_date_low_new, l_date_high_new.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_MOVDT1'.
        l_date_low_new  = l_selvar-low.
      ENDLOOP.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_MOVDT2'.
        l_date_high_new = l_selvar-low.
      ENDLOOP.
      IF ( l_date_low_new  <> space AND l_date_low_new  <> '00000000' ) OR
         ( l_date_high_new <> space AND l_date_high_new <> '00000000' ).
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_MOVDT1'.
          l_selvar-low = l_select_begin.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_MOVDT2'.
          l_selvar-low = l_select_end.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
      ENDIF.
*
      CLEAR: l_date_low_new, l_date_high_new.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_INSDT1'.
        l_date_low_new  = l_selvar-low.
      ENDLOOP.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_INSDT2'.
        l_date_high_new = l_selvar-low.
      ENDLOOP.
      IF ( l_date_low_new  <> space AND l_date_low_new  <> '00000000' ) OR
         ( l_date_high_new <> space AND l_date_high_new <> '00000000' ).
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_INSDT1'.
          l_selvar-low = l_select_begin.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_INSDT2'.
          l_selvar-low = l_select_end.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
      ENDIF.
*
      CLEAR: l_date_low_new, l_date_high_new.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_UPDDT1'.
        l_date_low_new  = l_selvar-low.
      ENDLOOP.
      LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_UPDDT2'.
        l_date_high_new = l_selvar-low.
      ENDLOOP.
      IF ( l_date_low_new  <> space AND l_date_low_new  <> '00000000' ) OR
         ( l_date_high_new <> space AND l_date_high_new <> '00000000' ).
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_UPDDT1'.
          l_selvar-low = l_select_begin.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
        LOOP AT lt_selvar INTO l_selvar WHERE selname = 'S_UPDDT2'.
          l_selvar-low = l_select_end.
          MODIFY lt_selvar FROM l_selvar.
        ENDLOOP.
      ENDIF.
*
    ELSEIF NOT l_select_date IS INITIAL.
      LOOP AT lt_selvar INTO l_selvar
                       WHERE selname = 'S_ADMDT1' OR
                             selname = 'S_TRMDT1' OR
                             selname = 'S_CXVLD1' OR
                             selname = 'S_WLADT1' OR
                             selname = 'S_ABSDT1' OR
                             selname = 'S_NABSD1' OR
                             selname = 'S_MOVDT1' OR
                             selname = 'S_INSDT1' OR
                             selname = 'S_UPDDT1' OR
                             selname = 'S_ADMDT2' OR
                             selname = 'S_TRMDT2' OR
                             selname = 'S_CXVLD2' OR
                             selname = 'S_WLADT2' OR
                             selname = 'S_ABSDT2' OR
                             selname = 'S_NABSD2' OR
                             selname = 'S_MOVDT2' OR
                             selname = 'S_INSDT2' OR
                             selname = 'S_UPDDT2'.
        CHECK l_selvar-low <> space AND l_selvar-low <> '00000000'.
        l_selvar-low = l_select_date.
        MODIFY lt_selvar FROM l_selvar.
      ENDLOOP.
    ELSE.
      EXIT.
    ENDIF.
  ELSE.
    EXIT.  " not implemented yet
  ENDIF.

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
*      -->P_LT_MARKED  text
*      <--P_E_RC  text
*      <--P_E_FUNC_DONE  text
*----------------------------------------------------------------------*
FORM do_check_auth_pat_for_func  TABLES   p_t_messages  STRUCTURE bapiret2
                                 USING    p_lt_marked   TYPE tyt_marked
                                 CHANGING p_e_rc        TYPE sy-subrc
                                          p_e_func_done TYPE ish_true_false.

   DATA: lt_patient  TYPE ishmed_t_pat,
         ls_patient  TYPE rn1pat,
         lt_bapiret  TYPE bapirettab,
         ls_marked   TYPE ty_marked.

  LOOP AT p_lt_marked INTO ls_marked.
    IF ls_marked-patnr IS NOT INITIAL.
      clear ls_patient.
      ls_patient-einri = ls_marked-einri.
      ls_patient-patnr = ls_marked-patnr.
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
