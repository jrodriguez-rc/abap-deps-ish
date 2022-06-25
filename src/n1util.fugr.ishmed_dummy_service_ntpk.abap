FUNCTION ishmed_dummy_service_ntpk.
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
  DATA: lt_services          TYPE ishmed_t_servicecode.
* Workareas
  DATA: l_service            LIKE LINE OF lt_services.
* Hilfsfelder und -strukturen
  DATA: l_rc                 TYPE ish_method_rc,
        l_ntpk               TYPE ntpk,
        l_ontpk              TYPE ntpk.
* ---------- ---------- ----------
* Initialisierung
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  e_rc = 0.
  CLEAR: lt_services.
* ---------- ---------- ----------
  IF i_service IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
  INSERT i_service INTO TABLE lt_services.
* ---------- ---------- ----------
* Leistungsstamm lesen.
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
  l_rc = sy-subrc.
  CASE l_rc.
    WHEN 0.
    WHEN OTHERS.
*     Leistung & nicht im Leistungskatalog & vorhanden
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'NF1'
          i_num           = '768'
          i_mv1           = i_service-talst
          i_mv2           = i_service-tarif.
      e_rc = l_rc.
      EXIT.
  ENDCASE.
* ---------- ---------- ----------
  IF l_ntpk-n1medlei IS INITIAL OR
     l_ntpk-n1anfor  IS INITIAL.
    l_ontpk          =  l_ntpk.
    l_ntpk-n1medlei  =  'X'.
    l_ntpk-n1anfor   =  'X'.
  ELSE.
    CLEAR: l_ntpk.
  ENDIF.
* ---------- ---------- ----------
  IF l_ntpk     IS INITIAL.
*   Keine Änderung nötig - FB verlassen
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* quick & dirty: keine Sperre durchführen - update erfolgt genau 1x um
* die Kennzeichen entsprechend zu setzen
* ---------- ---------- ----------
  CALL FUNCTION 'ISH_UPDATE_NTPK'
       EXPORTING
            nntpk = l_ntpk
            ontpk = l_ontpk
            tcode = sy-tcode
            vcode = 'UPD'.
  IF i_commit = on.
    COMMIT WORK.
  ENDIF.
* ---------- ---------- ----------
* Nun Puffer der NTPK für die Dummy-Leistung initialisieren.
  CALL FUNCTION 'ISH_READ_NTPK'
       EXPORTING
            einri   = i_service-einri
            talst   = i_service-talst
            tarif   = i_service-tarif
            refresh = 'X'.
* ---------- ---------- ----------

ENDFUNCTION.
