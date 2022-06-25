FUNCTION ishmed_popup_appointment.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_TITLE) TYPE  ISH_CHAR70 DEFAULT SPACE
*"     VALUE(I_SELECT) TYPE  ISH_ON_OFF DEFAULT ON
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(E_APPOINTMENT) TYPE REF TO  CL_ISH_APPOINTMENT
*"     VALUE(E_NTMN) TYPE  NTMN
*"  TABLES
*"      IT_APPOINTMENTS TYPE  ISHMED_T_APPOINTMENT_OBJECT OPTIONAL
*"      IT_NTMN STRUCTURE  NTMN OPTIONAL
*"  CHANGING
*"     VALUE(C_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------

  TYPES: BEGIN OF ty_f4,
           appmnt       TYPE REF TO cl_ish_appointment,
           type(10)     TYPE c,
           tmnoe        TYPE ntmn-tmnoe,
           resource(15) TYPE c,
           leist        TYPE nlei-leist,
           date(10)     TYPE c,
           time         TYPE sy-uzeit,
           text         TYPE nlei-leitx,
         END OF ty_f4,
         tyt_f4 TYPE STANDARD TABLE OF ty_f4.
  DATA: l_rc           TYPE ish_method_rc,
        l_vcode        TYPE tndym-vcode,
        lt_appmnt      TYPE ishmed_t_appointment_object,
        l_appmnt       TYPE REF TO cl_ish_appointment,
        l_ntmn         TYPE ntmn.
  DATA: lt_f4          TYPE tyt_f4,
        l_wa_f4        TYPE ty_f4,
        lt_marked      TYPE tyt_f4,
        lt_fcat        TYPE lvc_t_fcat,
        l_wa_fcat      TYPE lvc_s_fcat.
  DATA: l_title(50)    TYPE c,
        l_height       TYPE i,
        l_tfill        TYPE sy-tfill,
        l_ntpt         TYPE ntpt,
        lt_vnlei       TYPE TABLE OF vnlei,
        l_wa_nlei      TYPE vnlei,
        lt_napp        TYPE ish_t_napp,
        l_napp         TYPE napp,
        l_environment  TYPE REF TO cl_ish_environment.

* Führer, ID. 9738 Neue Datendefinitionen
  DATA: lt_npob        TYPE ishmed_t_npob,
        l_npob         LIKE LINE OF lt_npob.

* Koppensteiner, ID 10745 - Begin
  DATA: lt_vnlem       TYPE TABLE OF vnlem,
*        l_wa_nlem      TYPE vnlem,
        l_idx          TYPE sy-tabix.
* Koppensteiner, ID 10745 - End

* Initialisierungen
  e_rc = 0.
  CLEAR: e_appointment, e_ntmn.

  REFRESH: lt_f4,
           lt_marked,
           lt_fcat,
           lt_appmnt.

  l_vcode = 'DIS'.
  IF i_select = on.
    l_vcode = 'UPD'.
  ENDIF.
  IF i_title IS INITIAL.
    l_title = 'Terminauswahl'(009).
  ELSE.
    l_title = i_title.
  ENDIF.

  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Objekte des prov. Pat. auf neuen realen Pat. umhängen
* Fichte, Nr 12007: Use CREATE instead of constructor
  CALL METHOD cl_ish_fac_environment=>create
    EXPORTING
      i_program_name = 'ISHMED_POPUP_APPOINTMENT'
    IMPORTING
      e_instance     = l_environment
      e_rc           = l_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* Fichte, Nr 12007 - End

* Termine der Tabelle IT_NTMN verwenden - - - - - - - - - - - - - - - -
  LOOP AT it_ntmn INTO l_ntmn.
    CALL METHOD cl_ish_appointment=>load
      EXPORTING
        i_tmnid        = l_ntmn-tmnid
        i_environment  = l_environment
      IMPORTING
        e_rc           = l_rc
        e_instance     = l_appmnt
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      EXIT.
    ENDIF.
    IF NOT l_appmnt IS INITIAL.
      APPEND l_appmnt TO lt_appmnt.
    ENDIF.
  ENDLOOP.

* Termine der Tabelle IT_APPOINTMENTS verwenden - - - - - - - - - - -
  APPEND LINES OF it_appointments TO lt_appmnt.

* ev. doppelte rauslöschen
  IF NOT it_ntmn[] IS INITIAL AND NOT it_appointments[] IS INITIAL.
    SORT lt_appmnt.
    DELETE ADJACENT DUPLICATES FROM lt_appmnt.
  ENDIF.

* Ausgabetabelle bilden - - - - - - - - - - - - - - - - - - - - - - -
  LOOP AT lt_appmnt INTO l_appmnt.
    CLEAR: l_ntmn, l_wa_nlei.
    REFRESH: lt_napp, lt_vnlei.
    CALL METHOD l_appmnt->get_data
      EXPORTING
        i_fill_appointment = off
      IMPORTING
        es_ntmn            = l_ntmn
        et_napp            = lt_napp
        e_rc               = l_rc
      CHANGING
        c_errorhandler     = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
    CALL METHOD cl_ish_appointment=>get_services_for_appmnt
      EXPORTING
        i_appointment     = l_appmnt
        i_environment     = l_environment
      IMPORTING
        e_rc              = l_rc
*       ET_SERVICES       =
        et_nlei           = lt_vnlei
        et_nlem           = lt_vnlem  "Koppensteiner, ID 10745
      CHANGING
        c_errorhandler    = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.

*   Koppensteiner, ID 10745 - Begin
    DELETE lt_vnlem WHERE ankls <> space.
    LOOP AT lt_vnlei INTO l_wa_nlei.
      l_idx = sy-tabix.
      READ TABLE lt_vnlem TRANSPORTING NO FIELDS " INTO l_wa_nlem
                 WITH KEY lnrls = l_wa_nlei-lnrls.
      IF sy-subrc <> 0.
        DELETE lt_vnlei INDEX l_idx.
      ENDIF.
    ENDLOOP.
*   Koppensteiner, ID 10745 - End

    l_wa_f4-appmnt = l_appmnt.
    IF l_ntmn-bewty = '1'.
      l_wa_f4-type = 'Aufnahme'(016).
    ELSE.
      l_wa_f4-type = 'Besuch'(017).
    ENDIF.
    WRITE l_ntmn-tmndt TO l_wa_f4-date DD/MM/YYYY.
    l_wa_f4-time   = l_ntmn-tmnzt.
    l_wa_f4-tmnoe  = l_ntmn-tmnoe.
    LOOP AT lt_napp INTO l_napp.
*    Führer, ID. 9738 2/4.63B - Beginn
*    Ressource anhand der POBNR ermitteln (vgl. Termine mit Raum und
*    Person)
      CLEAR: lt_npob[].
      CALL METHOD cl_ishmed_master_dp=>read_planning_object
        EXPORTING
          i_pobnr         = l_napp-pobnr
          i_orgid         = l_napp-orgpf
          i_get_pobnr     = ' '
          i_buffer_active = on
          i_read_db       = off
        IMPORTING
          et_npob         = lt_npob
          e_rc            = l_rc
        CHANGING
          c_errorhandler  = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      READ TABLE lt_npob INTO l_npob INDEX 1.
      IF sy-subrc = 0.
        IF NOT l_npob-bauid IS INITIAL.
          l_wa_f4-resource = l_npob-bauid.
        ELSEIF NOT l_npob-pernr IS INITIAL.
          l_wa_f4-resource = l_npob-pernr.
        ELSE.
          l_wa_f4-resource = l_npob-orgid.
        ENDIF.
      ELSE.
        CLEAR l_wa_f4-resource.
      ENDIF.
*      IF NOT l_napp-zimmr IS INITIAL.
*        l_wa_f4-resource = l_napp-zimmr.
*      ELSEIF NOT l_napp-pernr IS INITIAL.
*        l_wa_f4-resource = l_napp-pernr.
*      ELSE.
*        CLEAR l_wa_f4-resource.
*      ENDIF.
*      Führer, ID. 9738 2/4.63B - Ende
    ENDLOOP.
    DESCRIBE TABLE lt_vnlei.
    IF sy-tfill > 0.
      l_tfill = sy-tfill.
      READ TABLE lt_vnlei INTO l_wa_nlei INDEX 1.
      l_wa_f4-leist  = l_wa_nlei-leist.
      IF l_tfill > 1 AND NOT l_wa_f4-leist IS INITIAL.
        CONCATENATE l_wa_f4-leist ', ...' INTO l_wa_f4-leist.
      ENDIF.
      IF NOT l_wa_nlei-leitx IS INITIAL.
        l_wa_f4-text = l_wa_nlei-leitx.
      ELSE.
        CALL FUNCTION 'ISH_READ_NTPT'
          EXPORTING
            einri  = l_wa_nlei-einri
            spras  = sy-langu
            talst  = l_wa_nlei-leist
            tarif  = l_wa_nlei-haust
          IMPORTING
            e_ntpt = l_ntpt
          EXCEPTIONS
            OTHERS = 2.
        IF sy-subrc = 0.
          l_wa_f4-text = l_ntpt-ktxt1.
        ENDIF.
      ENDIF.
      IF l_tfill > 1 AND NOT l_wa_f4-text IS INITIAL.
        CONCATENATE l_wa_f4-text ', ...' INTO l_wa_f4-text.
      ENDIF.
    ENDIF.
    APPEND l_wa_f4 TO lt_f4.
  ENDLOOP.

* Fichte, Nr 12007: Destroy the env, because now it isn"t
* used any more (and it will be removed from ISH_MANAGER)
  IF e_rc <> 0  AND  NOT l_environment IS INITIAL.
    CALL METHOD cl_ish_utl_base=>destroy_env
      CHANGING
        cr_environment = l_environment.
    CLEAR l_environment.
  ENDIF.
  CHECK e_rc = 0.

* Kein Termin vorhanden => Methode beenden und nichts zurückliefern
  DESCRIBE TABLE lt_f4.
  IF sy-tfill = 0.
*   Fichte, Nr 12007: Destroy the env, because now it isn"t
*   used any more (and it will be removed from ISH_MANAGER)
    IF NOT l_environment IS INITIAL.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = l_environment.
      CLEAR l_environment.
    ENDIF.
    EXIT.
  ELSEIF sy-tfill = 1.
*   Nur 1 Termin -> Termin zurückgeben:
    READ TABLE lt_f4 INTO l_wa_f4 INDEX 1.
    CALL METHOD l_wa_f4-appmnt->get_data
      EXPORTING
        i_fill_appointment = off
      IMPORTING
        es_ntmn            = l_ntmn
        e_rc               = l_rc
      CHANGING
        c_errorhandler     = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
    ELSE.
      e_appointment = l_wa_f4-appmnt.
      e_ntmn        = l_ntmn.
    ENDIF.
*   Fichte, Nr 12007: Destroy the env, because now it isn"t
*   used any more (and it will be removed from ISH_MANAGER)
    IF NOT l_environment IS INITIAL.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = l_environment.
      CLEAR l_environment.
    ENDIF.
    EXIT.
  ENDIF.

* Feldkatalog einrichten - - - - - - - - - - - - - - - - - - - - -
  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname = 'APPMNT'.
  l_wa_fcat-no_out    = on.
  l_wa_fcat-tech      = on.
  APPEND l_wa_fcat TO lt_fcat.

  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname = 'TYPE'.
  l_wa_fcat-inttype   = 'C'.
  l_wa_fcat-outputlen = 10.
  l_wa_fcat-dd_outlen = 10.
  l_wa_fcat-reptext   = 'Art'(018).
  APPEND l_wa_fcat TO lt_fcat.

  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname = 'DATE'.
  l_wa_fcat-inttype   = 'C'.
  l_wa_fcat-outputlen = 10.
  l_wa_fcat-dd_outlen = 10.
  l_wa_fcat-reptext   = 'Datum'(010).
  APPEND l_wa_fcat TO lt_fcat.

  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname = 'TIME'.
  l_wa_fcat-inttype   = 'C'.
  l_wa_fcat-outputlen = 5.
  l_wa_fcat-dd_outlen = 5.
  l_wa_fcat-datatype  = 'CHAR'.
  l_wa_fcat-edit_mask = '__:__'.
  l_wa_fcat-reptext   = 'Zeit'(011).
  APPEND l_wa_fcat TO lt_fcat.

  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname  = 'TMNOE'.
  l_wa_fcat-inttype    = 'C'.
  l_wa_fcat-outputlen  = 8.
  l_wa_fcat-dd_outlen  = 8.
  l_wa_fcat-datatype   = 'CHAR'.
  l_wa_fcat-reptext(8) = 'Org.Einh'(012).
  APPEND l_wa_fcat TO lt_fcat.

  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname = 'RESOURCE'.
  l_wa_fcat-inttype   = 'C'.
  l_wa_fcat-outputlen = 15.
  l_wa_fcat-dd_outlen = 15.
  l_wa_fcat-datatype  = 'CHAR'.
  l_wa_fcat-reptext   = 'Resource'(013).
  APPEND l_wa_fcat TO lt_fcat.

  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname = 'LEIST'.
  l_wa_fcat-inttype   = 'C'.
  l_wa_fcat-outputlen = 10.
  l_wa_fcat-reptext   = 'Leistung'(014).
  l_wa_fcat-emphasize = on.
  APPEND l_wa_fcat TO lt_fcat.

  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname = 'TEXT'.
  l_wa_fcat-inttype   = 'C'.
  l_wa_fcat-outputlen = 20.
  l_wa_fcat-dd_outlen = 50.
  l_wa_fcat-reptext   = 'Text'(015).
  APPEND l_wa_fcat TO lt_fcat.

* Auswahl-Popup bringen - - - - - - - - - - - - - - - - - - - - -
  DESCRIBE TABLE lt_f4.
  l_height = sy-tfill + 3.
  CALL FUNCTION 'ISHMED_F4_ALLG_ACTIVEX'
    EXPORTING
      it_f4tab          = lt_f4
      it_fieldcat       = lt_fcat
      i_height          = l_height
      i_vcode           = l_vcode
      i_mfsel           = off
      i_title           = l_title
    IMPORTING
      e_rc              = l_rc
      et_marked_entries = lt_marked.
  IF l_rc <> 0.
*   Fichte, Nr 12007: Destroy the env, because now it isn"t
*   used any more (and it will be removed from ISH_MANAGER)
    IF NOT l_environment IS INITIAL.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = l_environment.
      CLEAR l_environment.
    ENDIF.
    e_rc = 2.                                 " Cancel
    EXIT.
  ENDIF.

  READ TABLE lt_marked INTO l_wa_f4 INDEX 1.
  IF sy-subrc <> 0.
*   Fichte, Nr 12007: Destroy the env, because now it isn"t
*   used any more (and it will be removed from ISH_MANAGER)
    IF NOT l_environment IS INITIAL.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = l_environment.
      CLEAR l_environment.
    ENDIF.
    e_rc = 2.                                 " Cancel
  ELSE.
*   Gewählten Termin zurückliefern
    CALL METHOD l_wa_f4-appmnt->get_data
      EXPORTING
        i_fill_appointment = off
      IMPORTING
        es_ntmn            = l_ntmn
        e_rc               = l_rc
      CHANGING
        c_errorhandler     = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
    ELSE.
      e_appointment = l_wa_f4-appmnt.
      e_ntmn        = l_ntmn.
    ENDIF.
  ENDIF.

* Fichte, Nr 12007: Destroy the env, because now it isn"t
* used any more (and it will be removed from ISH_MANAGER)
  IF NOT l_environment IS INITIAL.
    CALL METHOD cl_ish_utl_base=>destroy_env
      CHANGING
        cr_environment = l_environment.
    CLEAR l_environment.
  ENDIF.

ENDFUNCTION.
