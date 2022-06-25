FUNCTION ishmed_get_summary_for_object .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_OBJECT) TYPE REF TO  OBJECT
*"  EXPORTING
*"     VALUE(E_DATE) TYPE  SY-DATUM
*"     VALUE(E_TIME) TYPE  SY-UZEIT
*"     VALUE(E_DURATION) TYPE  ISH_TMDAUER
*"     VALUE(E_ROOM) TYPE  BAUID
*"     VALUE(E_DOCTOR) TYPE  RI_PERNR
*"     VALUE(E_DESIRED_TIME) TYPE  ISH_ON_OFF
*"     VALUE(E_APP_EXIST) TYPE  ISH_ON_OFF
*"     VALUE(E_DATE_OUTPUT) TYPE  N1CDATE
*"     VALUE(E_TIME_OUTPUT) TYPE  N1CTIME
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"  CHANGING
*"     VALUE(C_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------

  CLASS cl_ish_objectbase DEFINITION LOAD.
* Lokale Typen
  TYPES: BEGIN OF ty_dates,
           date                 TYPE nlei-ibgdt,
           time                 TYPE nlei-ibzt,
           date_output          TYPE n1cdate,
           time_output          TYPE n1ctime,
           duration             TYPE ntmn-tmndr,
           room                 TYPE napp-zimmr,
           doctor               TYPE napp-pernr,
           desired_time         TYPE ish_on_off,
           app_exist            TYPE ish_on_off,
         END OF ty_dates.
* Lokale Tabellen
  DATA:  lt_vnlei               TYPE ishmed_t_vnlei,
         lt_vnlem               TYPE ishmed_t_vnlem,
         lt_vntmn               TYPE ishmed_t_vntmn,
         lt_vnapp               TYPE ishmed_t_vnapp,
         lt_dates               TYPE TABLE OF ty_dates,
         lt_services            TYPE ish_objectlist,
         lt_appointments        TYPE ish_objectlist.
* Workareas
  DATA:  l_vnlei                LIKE LINE OF lt_vnlei,
         l_vnlem                LIKE LINE OF lt_vnlem,
         l_vntmn                LIKE LINE OF lt_vntmn,
         l_vnapp                LIKE LINE OF lt_vnapp,
         l_dates                TYPE ty_dates,
         l_srv                  LIKE LINE OF lt_services,
         l_app                  LIKE LINE OF lt_appointments.
* Hilfsfelder und -strukturen
  DATA:  l_obj_type             TYPE ish_object_type,
         l_request_obj          TYPE REF TO cl_ishmed_request,
         l_app_obj              TYPE REF TO cl_ish_appointment,
         l_srv_obj              TYPE REF TO cl_ishmed_service,
         l_environment          TYPE REF TO cl_ish_environment,
         l_rc                   TYPE ish_method_rc.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Typ des übergebenen Objektes ermitteln; dzt. sind nur Anforderungen
* und Vormerkungen erlaubt.
  CALL METHOD i_object->('GET_TYPE')
    IMPORTING
      e_object_type = l_obj_type.
  IF l_obj_type <> cl_ishmed_request=>co_otype_request AND
     l_obj_type <> cl_ishmed_prereg=>co_otype_prereg  AND
     l_obj_type <> cl_ishmed_cordpos=>co_otype_cordpos_med.
    e_rc = 2. " Objekt dzt. nicht unterstützt
    EXIT.
  ENDIF.
* Environment des übergebenen Objektes ermitteln
  CALL METHOD i_object->('GET_ENVIRONMENT')
    IMPORTING
      e_environment = l_environment.
* ---------- ---------- ----------
* Abhängig vom Objekttyp Daten zur Ermittlung der aggregierten Funktion
* für das übergebene Objekt ermitteln.
  CASE l_obj_type.
*   Anforderung
    WHEN cl_ishmed_request=>co_otype_request.
      l_request_obj ?= i_object.
*     Leistung und Termine der Anforderung ermitteln, diese werden für
*     die aggregierte Info herangezogen.
*     [Logik aus dem Sichttyp Anforderungen]
      CALL METHOD cl_ishmed_request=>get_services_for_request
        EXPORTING
          i_request         = l_request_obj
          i_environment     = l_environment
          i_empty_services  = on
          i_cancelled_datas = off
        IMPORTING
          e_rc              = l_rc
          et_services       = lt_services
*         et_appmnt         = lt_appointments
        CHANGING
          c_errorhandler    = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
  ENDCASE.
* ---------- ---------- ----------
  LOOP AT lt_services INTO l_srv.
    CLEAR: l_dates.
    l_srv_obj ?= l_srv-object.
    CALL METHOD cl_ishmed_service=>build_service_date_time
      EXPORTING
        i_service      = l_srv_obj
      IMPORTING
        e_rc           = l_rc
        e_date         = l_dates-date
        e_time         = l_dates-time
        e_date_output  = l_dates-date_output
        e_time_output  = l_dates-time_output
        e_desired_time = l_dates-desired_time
      CHANGING
        c_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      l_rc = e_rc.
      EXIT.
    ENDIF.
*   Termin ermitteln
    CALL METHOD cl_ishmed_service=>get_appmnt_for_service
      EXPORTING
        i_service          = l_srv_obj
        i_environment      = l_environment
      IMPORTING
        e_ntmn             = l_vntmn
        et_napp            = lt_vnapp
        e_appointment      = l_app_obj
        e_rc               = l_rc
      CHANGING
        c_errorhandler     = c_errorhandler.
    IF e_rc <> 0.
      l_rc = e_rc.
      EXIT.
    ENDIF.
    IF NOT l_app_obj IS INITIAL.
      l_dates-app_exist = on.
    ENDIF.
    LOOP AT lt_vnapp INTO l_vnapp.
      l_dates-duration  =  l_vntmn-tmndr.
      l_dates-room      =  l_vnapp-zimmr.
      l_dates-doctor    =  l_vnapp-pernr.
    ENDLOOP.
    INSERT l_dates INTO TABLE lt_dates.
  ENDLOOP.
  IF e_rc <> 0.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Korrekten Eintrag für die aggregierte Information bestimmen
* und die Rückgabefelder befüllen.
* Hilfstabelle nach Datum und Uhrzeit sortieren.
  SORT lt_dates BY date time.
  LOOP AT lt_dates INTO  l_dates.
    IF ( l_dates-date  =  sy-datum  AND
         l_dates-time  <  e_time    OR
         e_time        IS INITIAL ) OR
       ( l_dates-date  <  sy-datum  AND
         l_dates-date  >  e_date )  OR
       ( l_dates-date  >  sy-datum  AND
         e_date        IS INITIAL ).
      e_date          =  l_dates-date.
      e_time          =  l_dates-time.
      e_duration      =  l_dates-duration.
      e_room          =  l_dates-room.
      e_doctor        =  l_dates-doctor.
      e_desired_time  =  l_dates-desired_time.
      e_app_exist     =  l_dates-app_exist.
      e_date_output   =  l_dates-date_output.
      e_time_output   =  l_dates-time_output.
    ELSEIF     l_dates-date >  sy-datum AND
           NOT e_date       IS INITIAL.
    ENDIF.
  ENDLOOP.
* ---------- ---------- ----------
  IF e_date IS INITIAL.
    e_time  =  '        '.
  ENDIF.
* ---------- ---------- ----------

ENDFUNCTION.
