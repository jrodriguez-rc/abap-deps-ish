FUNCTION ishmed_dummy_service_range .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_SERVICE) TYPE  RN1SERVICECODE
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"  EXPORTING
*"     REFERENCE(E_RC) TYPE  ISH_METHOD_RC
*"  CHANGING
*"     VALUE(C_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------

* ---------- ---------- ----------
* Lokale Tabellen
  DATA: lt_services          TYPE ishmed_t_servicecode,
        lt_n1xlei            TYPE ishmed_t_n1xlei,
        lt_norg              TYPE STANDARD TABLE OF norg,
        lt_nn1xlei           TYPE STANDARD TABLE OF vn1xlei,
        lt_on1xlei           TYPE STANDARD TABLE OF vn1xlei.
* Workareas
  DATA: l_service            LIKE LINE OF lt_services,
        l_n1xlei             LIKE LINE OF lt_n1xlei,
        l_vn1xlei            LIKE LINE OF lt_nn1xlei,
        l_norg               LIKE LINE OF lt_norg.
* Hilfsfelder und -strukturen
  DATA: l_rc                 TYPE ish_method_rc,
        l_min_date           TYPE sy-datum          VALUE '19000101',
        l_max_date           TYPE sy-datum          VALUE '99991231',
        l_ntpk               TYPE ntpk.
* ---------- ---------- ----------
* Initialisierung
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  e_rc = 0.
  CLEAR: lt_services, lt_n1xlei.
* ---------- ---------- ----------
  IF i_service IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
  INSERT i_service INTO TABLE lt_services.
* ---------- ---------- ----------
* Gültigkeitszeitraum der Leistung ermitteln.
  CALL FUNCTION 'ISH_READ_NTPK'
       EXPORTING
            einri     = i_service-einri
            talst     = i_service-talst
            tarif     = i_service-tarif
       IMPORTING
            e_ntpk    = l_ntpk
       EXCEPTIONS
            not_found = 1
            OTHERS    = 2.
  IF sy-subrc = 0.
    l_min_date  =  l_ntpk-begdt.
    l_max_date  =  l_ntpk-enddt.
  ELSE.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  CALL FUNCTION 'ISHMED_READ_N1XLEI'
       EXPORTING
            it_services = lt_services
       IMPORTING
            e_rc        = l_rc
       CHANGING
            ct_n1xlei   = lt_n1xlei.
* ---------- ---------- ----------
* Alle Org.Einheiten ermitteln, für die ein Besuchstermin geplant
* werden kann.
  READ TABLE gt_norg INTO l_norg
     WITH KEY einri = i_service-einri.
  IF sy-subrc <> 0.
    CLEAR: gt_norg.
*   ID 19129: replace select
*    SELECT * FROM norg INTO TABLE lt_norg "#EC CI_SGLSELECT
*       WHERE ambes = on
*         AND einri = i_service-einri
*         AND freig = on
*         AND loekz = off.
    CALL METHOD cl_ish_dbr_org=>get_t_org_by_orgid_range
      EXPORTING
        i_read_db = on
        i_einri   = i_service-einri
      IMPORTING
        et_norg   = lt_norg.
    DELETE lt_norg WHERE freig = off.
    DELETE lt_norg WHERE loekz = on.
    DELETE lt_norg WHERE ambes = off.
    gt_norg = lt_norg.
  ENDIF.
* ---------- ---------- ----------
* Jene Org.Einheiten entfernen, für die bereits ein Eintrag im
* Leistungsspektrum vorhanden ist.
  LOOP AT lt_n1xlei INTO l_n1xlei.
    DELETE lt_norg WHERE orgid = l_n1xlei-orgid.
  ENDLOOP.
* ---------- ---------- ----------
* Leistung in das Leistungsspektrum eintragen.
  CLEAR: lt_nn1xlei, lt_on1xlei.
  LOOP AT lt_norg INTO l_norg.
    CLEAR: l_vn1xlei.
    l_vn1xlei-mandt  =  i_service-mandt.
    l_vn1xlei-einri  =  i_service-einri.
    l_vn1xlei-tarif  =  i_service-tarif.
    l_vn1xlei-talst  =  i_service-talst.
    l_vn1xlei-orgid  =  l_norg-orgid.
    l_vn1xlei-begdt  =  l_min_date.
    l_vn1xlei-enddt  =  l_max_date.
    l_vn1xlei-erdat  =  sy-datum.
    l_vn1xlei-erusr  =  sy-uname.
    l_vn1xlei-kz     =  'I'.
    INSERT l_vn1xlei INTO TABLE lt_nn1xlei.
  ENDLOOP.
* ---------- ---------- ----------
  IF lt_nn1xlei IS INITIAL.
*   Keine Änderung nötig - FB verlassen
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  CALL FUNCTION 'R3MED_UPDATE_N1XLEI'
       EXPORTING
            datum   = sy-datum
            tcode   = sy-tcode
            uname   = sy-uname
            uzeit   = sy-uzeit
       TABLES
            nn1xlei = lt_nn1xlei
            on1xlei = lt_on1xlei.
* Falls das Leistungsspektrum geändert wird auch den Puffer
* zurücksetzen ... damit spätere Aufrufer keine "alten" Daten
* erhalten.
  CLEAR: lt_services.
  CALL FUNCTION 'ISHMED_READ_N1XLEI'
       EXPORTING
            it_services   = lt_services
            i_buffer_init = 'X'.
  IF i_commit = on.
    COMMIT WORK.
  ENDIF.
* ---------- ---------- ----------

ENDFUNCTION.
