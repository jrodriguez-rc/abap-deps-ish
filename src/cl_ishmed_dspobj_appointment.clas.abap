class CL_ISHMED_DSPOBJ_APPOINTMENT definition
  public
  create public .

public section.
*"* public components of class CL_ISHMED_DSPOBJ_APPOINTMENT
*"* do not include other source files here!!!
  type-pools ICON .

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_DISPLAY_OBJECT .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases G_NODE_OPEN
    for IF_ISH_DISPLAY_OBJECT~G_NODE_OPEN .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .
  aliases CLODE_NODE
    for IF_ISH_DISPLAY_OBJECT~CLOSE_NODE .
  aliases CONVERT_FOR_DISPLAY
    for IF_ISH_DISPLAY_OBJECT~CONVERT_FOR_DISPLAY .
  aliases DESTROY
    for IF_ISH_DISPLAY_OBJECT~DESTROY .
  aliases GET_DATA
    for IF_ISH_DISPLAY_OBJECT~GET_DATA .
  aliases GET_FIELDCATALOG
    for IF_ISH_DISPLAY_OBJECT~GET_FIELDCATALOG .
  aliases GET_MERGED_VALUES
    for IF_ISH_DISPLAY_OBJECT~GET_MERGED_VALUES .
  aliases GET_TYPE
    for IF_ISH_DISPLAY_OBJECT~GET_TYPE .
  aliases IS_CANCELLED
    for IF_ISH_DISPLAY_OBJECT~IS_CANCELLED .
  aliases LOAD
    for IF_ISH_DISPLAY_OBJECT~LOAD .
  aliases OPEN_NODE
    for IF_ISH_DISPLAY_OBJECT~OPEN_NODE .
  aliases REMOVE_DATA
    for IF_ISH_DISPLAY_OBJECT~REMOVE_DATA .
  aliases SET_NODE
    for IF_ISH_DISPLAY_OBJECT~SET_NODE .
  aliases AFTER_READ
    for IF_ISH_DISPLAY_OBJECT~AFTER_READ .

  constants CO_OTYPE_DSPOBJ_APPOINTMENT type ISH_OBJECT_TYPE value 1001. "#EC NOTEXT

  methods GET_APPOINTMENT
    returning
      value(RR_APPOINTMENT) type ref to CL_ISH_APPOINTMENT .
  methods GET_MOVEMENT
    returning
      value(RR_MOVEMENT) type ref to CL_ISHMED_MOVEMENT .
  methods GET_PREREG
    returning
      value(RR_PREREG) type ref to CL_ISHMED_PREREG .
  methods GET_REQUEST
    returning
      value(RR_REQUEST) type ref to CL_ISHMED_REQUEST .
  methods GET_T_SERVICE
    returning
      value(RT_SERVICE) type ISHMED_T_SERVICE_OBJECT .
  methods SET_NOSAVE
    importing
      value(I_NOSAVE) type ISH_ON_OFF .
  methods CONSTRUCTOR
    importing
      !I_OBJECT type N1OBJECTREF
      !I_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT
      value(I_NODE_OPEN) type ISH_ON_OFF default 'X'
      value(I_CANCELLED_DATA) type ISH_ON_OFF default SPACE
      value(I_CHECK_ONLY) type ISH_ON_OFF default 'X'
    exceptions
      INSTANCE_NOT_POSSIBLE
      NO_APPOINTMENT .
  methods GET_DATA_DETAIL
    exporting
      value(E_ERBOE) type ERBOE
      value(E_ANPOE) type ANPOE
      value(E_ANFOE) type ANFOE .
  class-methods GET_NO_MERGED_FIELDS
    exporting
      value(ET_NO_MERGE_FIELDS) type ISH_T_FIELDNAME .
  methods SET_PATIENTS_ANONYM
    importing
      value(I_ANONYM) type ISH_ON_OFF .
protected section.
*"* protected components of class CL_ISHMED_DSPOBJ_APPOINTMENT
*"* do not include other source files here!!!

  aliases GT_OUTTAB
    for IF_ISH_DISPLAY_OBJECT~GT_OUTTAB .
  aliases GT_SUBOBJECTS
    for IF_ISH_DISPLAY_OBJECT~GT_SUBOBJECTS .
  aliases G_CANCELLED
    for IF_ISH_DISPLAY_OBJECT~G_CANCELLED .
  aliases G_CANCELLED_DATA
    for IF_ISH_DISPLAY_OBJECT~G_CANCELLED_DATA .
  aliases G_CONSTRUCT
    for IF_ISH_DISPLAY_OBJECT~G_CONSTRUCT .
  aliases G_ENVIRONMENT
    for IF_ISH_DISPLAY_OBJECT~G_ENVIRONMENT .
  aliases G_OBJECT
    for IF_ISH_DISPLAY_OBJECT~G_OBJECT .
  aliases INITIALIZE
    for IF_ISH_DISPLAY_OBJECT~INITIALIZE .
  aliases SET_MAIN_DATA
    for IF_ISH_DISPLAY_OBJECT~SET_MAIN_DATA .

  data GR_MOVEMENT type ref to CL_ISHMED_MOVEMENT .
private section.
*"* private components of class CL_ISHMED_DSPOBJ_APPOINTMENT
*"* do not include other source files here!!!

  data G_NOSAVE type ISH_ON_OFF .
  data GT_SERVICES type ISHMED_T_SERVICE_OBJECT .
  data G_ANFOE type ANFOE .
  data G_ANONYM type ISH_ON_OFF .
  data G_ANPOE type ANPOE .
  data G_APPOINTMENT type N1APPOINTMENT_OBJECT .
  data G_ERBOE type ERBOE .
  data G_MOVEMENT type N1NONE_OO_NBEW_OBJECT .
  data G_PREREG type N1PREREG_OBJECT .
  data G_REQUEST type N1REQUEST_OBJECT .
ENDCLASS.



CLASS CL_ISHMED_DSPOBJ_APPOINTMENT IMPLEMENTATION.


METHOD constructor.

* Hilfsfelder und -strukturen.
  DATA: l_rc              TYPE sy-subrc.
* Objekt-Instanzen
  DATA: l_environment     TYPE REF TO cl_ish_environment.

* ---------- ---------- ----------
* Die Instanz nur anlegen, wenn der Constructor aus der Methode
* LOAD aufgerufen wird. Direkte Aufrufe des Constructors dürfen
* nicht möglich sein
  IF g_construct = off.
    RAISE instance_not_possible.
  ENDIF.
* ---------- ---------- ----------
* Alle globalen Datenstrukturen initialisieren
  CALL METHOD me->initialize.
* ---------- ---------- ----------
* Notwendige Übergabedaten prüfen
  IF i_object IS INITIAL.
    RAISE instance_not_possible.
  ENDIF.
  IF i_environment IS INITIAL.
    RAISE instance_not_possible.
  ELSE.
    l_environment = i_environment.
  ENDIF.
* ---------- ---------- ----------
  g_cancelled_data = i_cancelled_data.

* Prüfen, ob das Objekt überhaupt ein Termin ist
  CALL METHOD me->set_main_data
    EXPORTING
      i_object         = i_object
      i_check_only     = i_check_only
    IMPORTING
      e_rc             = l_rc
    CHANGING
      c_environment    = l_environment.
  CASE l_rc.
    WHEN 0.
      g_object    = i_object.
      g_node_open = i_node_open.
    WHEN OTHERS.
*     Fehler (Objekt ist kein Termin)
      RAISE no_appointment.
  ENDCASE.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_appointment.
  rr_appointment = g_appointment.
ENDMETHOD.


METHOD get_data_detail .

* Erbringende OE
  e_erboe = g_erboe.

* Pflegerische OE
  e_anpoe = g_anpoe.

* Fachliche OE
  e_anfoe = g_anfoe.

ENDMETHOD.


METHOD get_movement.
  rr_movement = gr_movement.
ENDMETHOD.


METHOD GET_NO_MERGED_FIELDS .

  DATA: l_nmf               LIKE LINE OF et_no_merge_fields.

  REFRESH et_no_merge_fields.

  CLEAR l_nmf.

* alle diese Feldnamen auch in der Tabelle retournieren
  l_nmf = 'SRV'.            APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'SRV_BEZ'.        APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'SRV_ERGTX'.      APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'SRV_LSLOK'.      APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'SRV_LGRBEZ'.     APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'PATEIN_ICON'.    APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'IFGR'.           APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'IFGR_ICON'.      APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'IFGR_TXT'.       APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'DIAGNOSE'.       APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'DIALO'.          APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'TEAM1'.          APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'TEAM1_KURZ'.     APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'TEAM2'.          APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'TEAM2_KURZ'.     APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'TEAM3'.          APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'TEAM3_KURZ'.     APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'TEAM4'.          APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'TEAM4_KURZ'.     APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'SEQNO'.          APPEND l_nmf TO et_no_merge_fields.
  l_nmf = 'RFG'.            APPEND l_nmf TO et_no_merge_fields. " 15002
  l_nmf = 'OPENCLOSE'.      APPEND l_nmf TO et_no_merge_fields. " 15002

ENDMETHOD.


METHOD get_prereg.
  rr_prereg = g_prereg.
ENDMETHOD.


METHOD get_request.
  rr_request = g_request.
ENDMETHOD.


METHOD get_t_service.
  rt_service = gt_services.
ENDMETHOD.


METHOD if_ish_display_object~close_node .

  CLEAR e_rc.

* Errorhandler instanzieren, falls nötig
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  g_node_open = off.

  CALL METHOD me->convert_for_display
    EXPORTING
      it_fieldcat    = it_fieldcat
    IMPORTING
      et_outtab      = et_outtab
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.

ENDMETHOD.


METHOD if_ish_display_object~convert_for_display.

* Lokale Tabellen
  DATA: lt_napp                 TYPE ishmed_t_napp,
        lt_outtab               LIKE et_outtab,
        lt_context              TYPE ish_t_context,
        lt_diag                 TYPE ishmed_t_diag,
        lt_diagnosis            TYPE ish_objectlist,
        ls_object               LIKE LINE OF lt_diagnosis,
        lr_diagnosis            TYPE REF TO cl_ish_prereg_diagnosis,
        ls_data_diag            TYPE rndip_attrib,
        l_dtext1                TYPE nkdi-dtext1,
        lt_tline                TYPE ish_t_textmodule_tline,
        lt_dia                  TYPE STANDARD TABLE OF rndi1,
        lt_natm                 TYPE ishmed_t_vnatm,
        lt_pobnr_date           TYPE ishmed_t_pobnr_date,
        lt_pobdc                TYPE ishmed_t_pobdc_by_pobnr_date.
* Workareas
  DATA: l_napp                  LIKE LINE OF lt_napp,
        l_tline                 TYPE tline,
        l_fieldcat              LIKE LINE OF it_fieldcat,
        ls_sel_crit             LIKE LINE OF it_selection_criteria,
        l_diag                  LIKE LINE OF lt_diag,
        l_dia                   TYPE rndi1,
        l_natm                  LIKE LINE OF lt_natm,
        ls_pobnr_date           LIKE LINE OF lt_pobnr_date,
        ls_pobdc                LIKE LINE OF lt_pobdc,
        l_context               LIKE LINE OF lt_context,
        l_service               LIKE LINE OF gt_services,
        l_outtab_all            LIKE LINE OF lt_outtab,
        l_outtab                LIKE LINE OF lt_outtab.
* Hilfsfelder und -strukturen
  DATA: l_rc                    TYPE ish_method_rc,
        l_icon_image            TYPE tv_image,
        l_icon                  TYPE nwicons-icon,
        l_cnt                   TYPE i,
        l_most_lines(1)         TYPE c,
        l_modcomment_cnt        TYPE i,
        l_modcomment_found      TYPE ish_on_off,
        l_place_holder(1)       TYPE c VALUE '-',
        l_dialo_exists          TYPE ish_on_off,
        l_apri                  TYPE n1apri-apri,
        l_aprie                 TYPE n1aprie,
        l_apritxt               TYPE n1apritxt,
        l_ifge                  TYPE n1ifg-ifge,
        l_ifgicon               TYPE n1ifg-icon,
        l_ifgtxt                TYPE n1ifgt-ifgtxt,
        l_lin_srv               TYPE i,
        l_lin_diag              TYPE i,
        l_released              TYPE ish_on_off,
        ls_n1applan             TYPE n1applan,
        l_ntmn                  TYPE ntmn,
        l_nbew                  TYPE nbew,
        l_n1anf                 TYPE n1anf,
        l_n1vkg                 TYPE n1vkg,
        l_n1corder              TYPE n1corder,
        l_dsp_afn               TYPE ish_on_off,
        l_dsp_n1ptint           TYPE ish_on_off,
        l_dsp_anfv              TYPE ish_on_off,
        l_dsp_context           TYPE ish_on_off,
        l_dsp_modcomment        TYPE ish_on_off,
        l_dsp_released          TYPE ish_on_off,
        l_dsp_kurz              TYPE ish_on_off,
        l_cx_object             TYPE rn1_cx_objects,
        l_cx_key                TYPE string.
* Objekt-Instanzen
  DATA: l_pap                   TYPE REF TO cl_ish_patient_provisional,
        l_corder                TYPE REF TO cl_ish_corder,
        lr_pobdc                TYPE REF TO cl_ishmed_pobdc.

  DATA: lt_text TYPE STANDARD TABLE OF text132,    "MED-60929 AGujev
        ls_text TYPE text132,                      "MED-60929 AGujev
        l_besond_string TYPE string.               "MED-60929 AGujev

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: et_outtab[], lt_outtab[], gt_outtab[].
  CLEAR: l_n1anf, l_n1vkg, l_nbew, l_ntmn, l_n1corder.
* ---------- ---------- ----------
* Grundlegende Termin-Daten lesen
  CALL METHOD me->set_main_data
    EXPORTING
      i_object       = g_object
      i_check_only   = off            " nicht prüfen -> lesen!
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_environment  = g_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Sortierfelder aus den Selektionskriterien ermitteln,
* denn diese müssen (für die Sortierung) auch dann befüllt werden,
* wenn sie nicht angezeigt werden (MED-44243)
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  CALL METHOD cl_ish_display_tools=>rework_fcat_for_sort
    EXPORTING
      it_selection_criteria = it_selection_criteria
    CHANGING
      ct_fieldcat           = it_fieldcat.

* ----------
* Anzuzeigende Daten anhand des Feldkatalogs bestimmen
  CLEAR: l_dsp_context, l_dsp_afn, l_dsp_n1ptint, l_dsp_kurz,
         l_dsp_anfv, l_dsp_modcomment, l_dsp_released.
  LOOP AT it_fieldcat INTO l_fieldcat WHERE no_out = off.
    CASE l_fieldcat-fieldname.
      WHEN 'AFNOE' OR 'AFNDT' OR 'AFNZT'.
        l_dsp_afn = on.
      WHEN 'N1PTINT'.
        l_dsp_n1ptint = on.
      WHEN 'ANFV_ICON'.
        l_dsp_anfv = on.
      WHEN 'KONTEXT1'    OR 'KONTEXT2'    OR 'KONTEXT3'    OR
           'CXSTA1'      OR 'CXSTA2'      OR 'CXSTA3'      OR
           'CXSTA_ICON1' OR 'CXSTA_ICON2' OR 'CXSTA_ICON3'.
        l_dsp_context = on.
      WHEN 'MODCOMMENT' OR 'MODCOMMENT_ICON'.
        l_dsp_modcomment = on.
      WHEN 'RELEASED_ICON'   OR 'APCOMMENT'       OR
           'RELEASE_STATINT' OR 'RELEASE_STATEXT'.
        l_dsp_released = on.
      WHEN 'ROOM_K' OR 'PLANOE_K' OR 'ROOM_KB' OR 'PLANOE_KB'.
        l_dsp_kurz = on.
    ENDCASE.
  ENDLOOP.

* ----------
* Alle Daten holen
* ----------
* Daten des Termins holen
  CALL METHOD g_appointment->get_data
    EXPORTING
      i_fill_appointment = off
    IMPORTING
      es_ntmn            = l_ntmn
      et_napp            = lt_napp
      e_rc               = e_rc
    CHANGING
      c_errorhandler     = c_errorhandler.
  CHECK e_rc = 0.
  SORT lt_napp BY zimmr DESCENDING pernr ASCENDING.
  READ TABLE lt_napp INTO l_napp INDEX 1.
* ----------
* Patienten mit vorl. Stammdaten ermitteln.
  CALL METHOD cl_ish_appointment=>get_patient_provi
    EXPORTING
      i_appmnt       = g_appointment
      i_environment  = g_environment
    IMPORTING
      e_pat_provi    = l_pap
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
* ----------
* Daten der Bewegung holen
  CLEAR: l_nbew.
* START MED-40483 2010/07/07
  IF gr_movement IS NOT INITIAL.
    CALL METHOD gr_movement->get_data
      IMPORTING
        e_rc           = l_rc
        e_nbew         = l_nbew
      CHANGING
        c_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      RETURN.
    ENDIF.
  ENDIF.
* END MED-40483
  IF NOT g_movement IS INITIAL.
    CALL METHOD g_movement->get_data
      IMPORTING
        e_rc           = l_rc
        e_nbew         = l_nbew
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.
* ----------
* Klinischen Auftrag (Header) zur Auftragsposition ermitteln
  CLEAR l_corder.
  IF NOT g_prereg IS INITIAL.
    CALL METHOD g_prereg->get_corder
      EXPORTING
        ir_environment  = g_environment
      IMPORTING
        er_corder       = l_corder
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    IF NOT l_corder IS INITIAL.
      CALL METHOD l_corder->get_data
        IMPORTING
          es_n1corder     = l_n1corder
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      CHECK e_rc = 0.
    ENDIF.
  ENDIF.
* ----------
* Anforderungs- bzw. Klinische Auftragspositionsdaten holen
  IF NOT g_request IS INITIAL.
*   Anforderung
    CALL METHOD g_request->get_data
      IMPORTING
        e_rc           = e_rc
        e_n1anf        = l_n1anf
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
*   Diagnose der Anforderung
    IF l_n1anf-falnr IS INITIAL.
*     Fallfreie Anforderung
      IF NOT l_n1anf-ditxt IS INITIAL AND l_n1anf-diltx IS INITIAL.
        CLEAR l_diag.
        l_diag-diagnose = l_n1anf-ditxt.
        l_diag-object   = g_request.
        APPEND l_diag TO lt_diag.
      ELSE.
        CALL METHOD g_request->get_text
          EXPORTING
            i_text_id      = cl_ishmed_request=>co_text_ditxt
          IMPORTING
            e_rc           = e_rc
            et_tline       = lt_tline
          CHANGING
            c_errorhandler = c_errorhandler.
        CHECK e_rc = 0.
        READ TABLE lt_tline INTO l_tline INDEX 1.
        IF sy-subrc = 0.
          CLEAR l_diag.
          l_diag-diagnose = l_tline-tdline.
          l_diag-object   = g_request.
          APPEND l_diag TO lt_diag.
        ENDIF.
      ENDIF.
    ELSE.
*     Fallbezogene Anforderung
      IF NOT l_n1anf-faldia IS INITIAL AND
         NOT l_n1anf-lfddia IS INITIAL.
*       Diagnose der Anforderung lesen
        CALL FUNCTION 'ISH_READ_NDIA'
          EXPORTING
            einri   = l_n1anf-einri
            falnr   = l_n1anf-faldia
            lfdnr   = l_n1anf-lfddia
            afdia   = on
            bhdia   = on
            endia   = on
            ewdia   = on
            fhdia   = on
            khdia   = on
            opdia   = on
          IMPORTING
            rc      = l_rc
          TABLES
            ss_ndia = lt_dia.
        IF l_rc = 0.
          READ TABLE lt_dia INTO l_dia INDEX 1.
          IF sy-subrc = 0.
            CLEAR l_diag.
            IF l_dia-ditxt IS INITIAL.
              l_diag-diagnose = l_dia-dtext1.
            ELSE.
              l_diag-diagnose = l_dia-ditxt.
            ENDIF.
*           Lokalisation der Diagnose
            l_diag-dialo  = l_dia-dialo.
            l_diag-object = g_request.
            APPEND l_diag TO lt_diag.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ELSEIF NOT g_prereg IS INITIAL.
*   Klinische Auftragsposition
    CALL METHOD g_prereg->get_data
      IMPORTING
        e_rc           = e_rc
        e_n1vkg        = l_n1vkg
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
*   Diagnosen des Klinischen Auftrags
    IF NOT l_corder IS INITIAL.
      CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
        EXPORTING
          ir_corder       = l_corder
          ir_environment  = g_environment
        IMPORTING
          e_rc            = e_rc
          et_diagnosis    = lt_diagnosis
        CHANGING
          cr_errorhandler = c_errorhandler.
      CHECK e_rc = 0.
      LOOP AT lt_diagnosis INTO ls_object.
        CLEAR: l_diag, ls_data_diag.
        lr_diagnosis ?= ls_object-object.
        CALL METHOD lr_diagnosis->get_data
          IMPORTING
            es_data        = ls_data_diag
            e_rc           = l_rc
          CHANGING
            c_errorhandler = c_errorhandler.
        CHECK l_rc = 0.
        IF NOT ls_data_diag-ditxt IS INITIAL.
          IF ls_data_diag-diltx IS INITIAL.
            l_diag-diagnose = ls_data_diag-ditxt.
            l_diag-dialo    = ls_data_diag-dloc.
            l_diag-object   = lr_diagnosis.
            APPEND l_diag TO lt_diag.
          ELSE.
            REFRESH lt_tline.
            CALL METHOD lr_diagnosis->get_text
              EXPORTING
                i_text_id      = cl_ish_prereg_diagnosis=>co_text_diltxt
              IMPORTING
                e_rc           = l_rc
                et_tline       = lt_tline
              CHANGING
                c_errorhandler = c_errorhandler.
            IF l_rc = 0.
              LOOP AT lt_tline INTO l_tline
                               WHERE NOT tdline IS INITIAL.
                CLEAR l_diag.
                l_diag-diagnose = l_tline-tdline.
                l_diag-dialo    = ls_data_diag-dloc.
                l_diag-object   = lr_diagnosis.
                APPEND l_diag TO lt_diag.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ELSE.
          CLEAR l_dtext1.
          CALL FUNCTION 'ISH_FIND_DIAGNOSE_TEXT'
            EXPORTING
              dkat          = ls_data_diag-dcat
              dkey          = ls_data_diag-dkey
            IMPORTING
              dtext1        = l_dtext1
            EXCEPTIONS
              no_text_found = 1
              OTHERS        = 2.
          IF sy-subrc = 0 AND NOT l_dtext1 IS INITIAL.
            l_diag-diagnose = l_dtext1.
            l_diag-dialo    = ls_data_diag-dloc.
            l_diag-object   = lr_diagnosis.
            APPEND l_diag TO lt_diag.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDIF.

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Felder für alle Zeilen des Termins befüllen
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* (das sind vor allem technische Felder, denn 'sichtbare' Felder
* sollen in den 'Folgezeilen' des Termins meist nicht erneut angezeigt
* werden
  CLEAR l_outtab_all.

* Erzeugendes Objekt (Termin, Anforderung, Klin. Auftragsposition, ...)
  l_outtab_all-impobj = g_object.

* Anzeigeobjekt selbst
  l_outtab_all-dspobj = me.

* Identifier (Objekt) / Einrichtung / Interner Schlüssel (für Sort)
  l_outtab_all-object   = g_appointment.
  l_outtab_all-einri    = l_ntmn-einri.
  l_outtab_all-keyno    = 'TMN'.
  l_outtab_all-keyno+3  = l_ntmn-tmnid.

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* 1. Zeile befüllen
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  CLEAR l_outtab.
  l_outtab = l_outtab_all.

* Planungsdaten (OE, Datum, Zeit, Raum, Bewegung)
  l_outtab-planoe = l_ntmn-tmnoe.
  l_outtab-date   = l_ntmn-tmndt.
  l_outtab-time   = l_ntmn-tmnzt.
  l_outtab-room   = l_napp-zimmr.
  l_outtab-doctor = l_napp-pernr.
  l_outtab-tmtag  = l_ntmn-tmtag.
  l_outtab-lfdbew = l_ntmn-tmnlb.
  l_outtab-tmpdt  = l_ntmn-tmpdt.
  l_outtab-tmpzt  = l_ntmn-tmpzt.

* Erbringende OE
  l_outtab-erboe = l_outtab-planoe.
  g_erboe = l_outtab-erboe.

* Wochentag
  CALL FUNCTION 'ISH_GET_WEEKDAY_NAME'
    EXPORTING
      date        = l_outtab-date
      language    = sy-langu
    IMPORTING
      shorttext   = l_outtab-dayofweek
    EXCEPTIONS
      calendar_id = 1
      date_error  = 2
      not_found   = 3
      wrong_input = 4
      OTHERS      = 5.
  IF sy-subrc <> 0.
    CLEAR l_outtab-dayofweek.
  ENDIF.

* Dauer
  l_outtab-dauer   = l_napp-dauer.
  l_outtab-tmdauer = l_napp-dauer.                          " MED-41209

* Fall- und Patientendaten
  l_outtab-falnr = l_ntmn-falnr.
  l_outtab-patnr = l_ntmn-patnr.

* Klinische Aufträge und/oder Anforderungen vorhanden
  IF l_dsp_anfv = on.
    IF NOT g_request IS INITIAL OR NOT g_prereg IS INITIAL.
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = l_outtab-einri
          i_indicator = '001'   " Kl.Auftrag/Anforderung vorhanden
        IMPORTING
          e_icon      = l_icon.
      l_outtab-anfv_icon = l_icon.
*     OK - flag already set (don't set in FILL_PATIENT_DATA again)
      l_dsp_anfv = off.
    ENDIF.
  ENDIF.

* START MED-40483 2010/07/19
* casedata will filled for all lines
** Falldaten (auch für fallfreie Objekte aufrufen!)
*    CALL METHOD cl_ish_display_tools=>fill_case_data
*      EXPORTING
*        i_falnr        = l_outtab-falnr
*        it_fieldcat    = it_fieldcat
*      IMPORTING
*        e_rc           = e_rc
**       e_nfal         = l_nfal
*      CHANGING
*        c_outtab_line  = l_outtab
*        c_errorhandler = c_errorhandler.
*    CHECK e_rc = 0.
* END MED-40483

* Patientendaten
  CALL METHOD cl_ish_display_tools=>fill_patient_data
    EXPORTING
      i_patnr          = l_outtab-patnr
      i_papid          = l_ntmn-papid
      i_pap            = l_pap
      i_anonym         = g_anonym
      i_dsp_cord_exist = l_dsp_anfv
      it_fieldcat      = it_fieldcat
      ir_corder        = l_corder                           "MED-40483
      ir_request       = g_request                          "MED-40483
    IMPORTING
      e_rc             = e_rc
*     e_npat           = l_npat
*     e_npap           = l_npap
    CHANGING
      c_outtab_line    = l_outtab
      c_errorhandler   = c_errorhandler.
  CHECK e_rc = 0.

* ID 19134: get short key (Kürzel) for room and plan ou
  IF l_dsp_kurz = on.
    CALL METHOD cl_ish_display_tools=>fill_kurz_data
      EXPORTING
        it_fieldcat    = it_fieldcat
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_outtab_line  = l_outtab
        c_errorhandler = c_errorhandler.
  ENDIF.

* START MED-40483 2010/08/04
* patient and allergiedate will filled for all lines
** Patientenpfad
*    CALL METHOD cl_ish_display_tools=>fill_pathway_data
*      EXPORTING
*        it_fieldcat           = it_fieldcat
*        it_selection_criteria = it_selection_criteria
*      IMPORTING
*        e_rc                  = e_rc
*      CHANGING
*        c_outtab_line         = l_outtab
*        c_errorhandler        = c_errorhandler.
*    CHECK e_rc = 0.
*
** Allergiedaten
*    CALL METHOD cl_ish_display_tools=>fill_adpat_data
*      EXPORTING
*        it_fieldcat           = it_fieldcat
*        it_selection_criteria = it_selection_criteria
*      IMPORTING
*        e_rc                  = e_rc
*      CHANGING
*        c_outtab_line         = l_outtab
*        c_errorhandler        = c_errorhandler.
*    CHECK e_rc = 0.
* END MED-40483

* IS-H NL - DBC for cases                                           6.01
  CALL METHOD cl_ish_display_tools=>fill_dbc_data
    EXPORTING
      it_fieldcat           = it_fieldcat
*     it_selection_criteria = it_selection_criteria
    IMPORTING
      e_rc                  = e_rc
    CHANGING
      c_outtab_line         = l_outtab
      c_errorhandler        = c_errorhandler.
  CHECK e_rc = 0.

* Anforderungs-/Klinische Auftragspositionsdaten
  IF NOT g_request IS INITIAL.
*   Anfordernd pflegerische OE
    l_outtab-anpoe = l_n1anf-anpoe.
*   Anfordernd fachliche OE
    l_outtab-anfoe = l_n1anf-anfoe.
*   Besonderheiten
    l_outtab-besond = l_n1anf-bhanf.
  ELSEIF NOT g_prereg IS INITIAL.
*   Pflegerische OE (= veranlassende OE des Klin. Auftrags)
    l_outtab-anpoe = l_n1corder-etroe.
*   Fachliche OE
    l_outtab-anfoe = l_n1corder-orddep.   " l_n1vkg-orgfa.
*   Auftragsnummer
    l_outtab-prgnr = l_n1corder-prgnr.
*   Besonderheiten (Bemerkung)
    l_outtab-besond = l_n1corder-rmcord.
*   Infektionsgrad
    IF NOT l_n1corder-ifg IS INITIAL.
      CALL FUNCTION 'ISHMED_READ_N1IFG'
        EXPORTING
          i_einri   = l_outtab-einri
          i_ifg     = l_n1corder-ifg
        IMPORTING
          e_ifge    = l_ifge
          e_ifgicon = l_ifgicon
          e_ifgtxt  = l_ifgtxt
          e_rc      = l_rc.
      IF l_rc = 0.
        l_outtab-ifgr      = l_ifge.
        l_outtab-ifgr_icon = l_ifgicon.
        l_outtab-ifgr_txt  = l_ifgtxt.
      ENDIF.
    ENDIF.
  ENDIF.

*-->begin of MED-60929 AGujev
*if field bemerkung is filled we need to convert it to external format (for special characters)
   IF l_outtab-besond IS NOT INITIAL.
    CLEAR lt_tline[].
    CLEAR l_tline.
    CLEAR lt_text[].   "MED-61281 AGujev
    l_tline-tdline = l_outtab-besond.
    APPEND l_tline TO lt_tline.
    CALL FUNCTION 'CONVERT_ITF_TO_STREAM_TEXT'
          EXPORTING
            language    = sy-langu
          TABLES
            itf_text    = lt_tline
            text_stream = lt_text.
    LOOP AT lt_text INTO ls_text.
      CONCATENATE l_besond_string ls_text INTO l_besond_string SEPARATED BY space RESPECTING BLANKS.
    ENDLOOP.
    SHIFT l_besond_string LEFT DELETING LEADING space. "MED-61281 AGujev
    CLEAR l_outtab-besond.
    CLEAR lt_tline[].
    CLEAR l_tline.
    l_outtab-besond = l_besond_string.
    CLEAR l_besond_string.    "MED-61281 AGujev
   ENDIF.
*<--end of MED-60929 AGujev

  g_anpoe = l_outtab-anpoe.
  g_anfoe = l_outtab-anfoe.

* Priorität
  l_outtab-prio = l_ntmn-bwprio.
* Weitere Daten der Priorität
  IF NOT l_outtab-prio IS INITIAL.
*   Externe Prio und Bezeichnung der Prio ermitteln
    l_apri = l_outtab-prio.
    CALL FUNCTION 'ISHMED_APRIE'
      EXPORTING
        i_apri    = l_apri
        i_einri   = l_outtab-einri
      IMPORTING
        e_aprie   = l_aprie
        e_apritxt = l_apritxt
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.
    IF sy-subrc <> 0.
      CLEAR: l_outtab-aprie, l_outtab-apritxt.
    ELSE.
      l_outtab-aprie   = l_aprie.
      l_outtab-apritxt = l_apritxt.
    ENDIF.
*   Priorität (für Sortierung) korrekt formatieren
    IF l_outtab-prio CO ' 0123456789'.
      PERFORM format_numc_string IN PROGRAM sapmn1pa
              USING l_outtab-prio 3.
    ENDIF.
  ENDIF.

* Icon für Termin setzen
  CALL FUNCTION 'ISHMED_GET_DATA_ICON_AND_TEXT'
    EXPORTING
      i_object          = g_appointment
      i_icon_with_qinfo = on
    IMPORTING
      e_rc              = e_rc
      e_icon            = l_icon_image
    CHANGING
      c_errorhandler    = c_errorhandler.
  CHECK e_rc = 0.
  l_outtab-element = l_icon_image.

* von der Bewegung abhängige Daten
  IF NOT g_movement IS INITIAL
    OR gr_movement IS NOT INITIAL.                          "MED-40483
*   Bemerkung zur Bewegung
    l_outtab-bem_bew = l_nbew-kztxt.
  ENDIF.

* Änderungsgrund des Termins (Cause of Change)
  IF l_ntmn-causechng IS NOT INITIAL.
    l_outtab-causechng = l_ntmn-causechng.
  ELSEIF l_ntmn-csechgid IS NOT INITIAL.                    " MED-34701
    CALL METHOD cl_ishmed_utl_app_rls_causechg=>get_cause_change_for_id
      EXPORTING
        i_einri     = l_outtab-einri
        i_csechgid  = l_ntmn-csechgid
        i_read_db   = off
      IMPORTING
        e_csechgtxt = l_outtab-causechng.
  ENDIF.

* Freigabe (Appointment aleady released?)
* read if cell color should be changed or if column should be displayed
* NOT FOR: day-based appointments
*          admission appointments
  IF l_outtab-tmtag = off AND l_ntmn-bewty <> '1'.
    CLEAR ls_sel_crit.
    READ TABLE it_selection_criteria INTO ls_sel_crit
                                     WITH KEY selname = 'P_RLPLAN'.
    IF l_dsp_released = on OR ls_sel_crit-low = off.
      CALL METHOD cl_ishmed_utl_app_rls=>check_app_released
        EXPORTING
          ir_app          = g_appointment
        IMPORTING
          e_rc            = l_rc
          e_released      = l_released
          es_n1applan     = ls_n1applan
        CHANGING
          cr_errorhandler = c_errorhandler.
      IF l_released = on AND l_rc = 0.
        CALL METHOD cl_ish_display_tools=>get_wp_icon
          EXPORTING
            i_einri     = l_outtab-einri
            i_indicator = '139'                       " Freigabe
          IMPORTING
            e_icon      = l_icon.
        l_outtab-released_icon = l_icon.
*       Plan Bezeichnung (plan comment)
        l_outtab-apcomment = ls_n1applan-apcomment.
*       Freigabestatus (intern) - intern release status
        l_outtab-release_statint = ls_n1applan-rlstat.
*       display release status information (extern)
        IF NOT l_outtab-release_statint IS INITIAL.
*         Freigabestatus (extern) - intern release status
          SELECT SINGLE statext FROM n1rlstt
                 INTO   l_outtab-release_statext
                 WHERE  einri    = l_outtab-einri
                 AND    spras    = sy-langu
                 AND    statint  = l_outtab-release_statint.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

* Bei Aufnahmeterminen: Aufnahme-OE/-Datum/-Zeit befüllen
  IF l_dsp_afn = on AND l_ntmn-bewty = '1'.
    l_outtab-afnoe = l_ntmn-tmnoe.
    l_outtab-afndt = l_ntmn-tmndt.
    l_outtab-afnzt = l_ntmn-tmnzt.
  ENDIF.

* Dispotyp befüllen (ID 15002)
  IF l_dsp_n1ptint = on.
    LOOP AT lt_napp INTO l_napp.
      IF l_ntmn-bewty = '1'.
        CHECK NOT l_napp-ptinp IS INITIAL.
        SELECT SINGLE ptint FROM n1ptit INTO l_outtab-n1ptint
               WHERE  spras  = sy-langu
               AND    einri  = l_outtab-einri
               AND    ptinp  = l_napp-ptinp.
        CHECK sy-subrc = 0.
      ELSE.
        CHECK NOT l_napp-dspty IS INITIAL.
        SELECT SINGLE dtext FROM tn40a INTO l_outtab-n1ptint
               WHERE  spras  = sy-langu
               AND    einri  = l_outtab-einri
               AND    orgid  = l_napp-orgpf
               AND    dispo  = l_napp-dspty.
        CHECK sy-subrc = 0.
      ENDIF.
      EXIT.
    ENDLOOP.
  ENDIF.

* ID 13138: Tageskommentar ermitteln
  IF l_dsp_modcomment = on AND NOT l_napp-pobnr IS INITIAL.
    IF cl_ishmed_switch_check=>ishmed_scd( ) = on.
      CLEAR ls_pobnr_date.
      ls_pobnr_date-pobnr = l_napp-pobnr.
      ls_pobnr_date-date  = l_outtab-date.
      APPEND ls_pobnr_date TO lt_pobnr_date.
      CALL METHOD cl_ishmed_utl_pobdc=>get_pobdc_by_t_pobnr_date
        EXPORTING
          it_pobnr_date          = lt_pobnr_date
*         i_refresh              = ABAP_FALSE
*         i_check_pob_timestamp  = ABAP_FALSE
          ir_environment         = g_environment
*Sta/PN/MED-40483
*         adjustment from memory not necessary
          i_adjust_from_memory   = off
*End/PN/MED-40483
        IMPORTING
          et_pobdc_by_pobnr_date = lt_pobdc
          e_rc                   = l_rc
        CHANGING
          cr_errorhandler        = c_errorhandler.
      IF l_rc = 0.
        l_modcomment_cnt = 0.
        l_modcomment_found = off.
        LOOP AT lt_pobdc INTO ls_pobdc WHERE pobnr = l_napp-pobnr
                                         AND date  = l_outtab-date.
          READ TABLE ls_pobdc-t_pobdc INTO lr_pobdc INDEX 1.
          CHECK sy-subrc = 0.
          CHECK lr_pobdc IS BOUND.
          DESCRIBE TABLE ls_pobdc-t_pobdc.
          l_modcomment_cnt = l_modcomment_cnt + sy-tfill.
          CHECK l_modcomment_found = off.
          l_outtab-modcomment = lr_pobdc->get_comment( ).
          l_outtab-modcomment_ref = lr_pobdc.
          CALL METHOD cl_ish_display_tools=>get_wp_icon
            EXPORTING
              i_einri     = l_outtab-einri
              i_indicator = '225'
            IMPORTING
              e_icon      = l_icon.
          l_outtab-modcomment_icon = l_icon.
          l_modcomment_found = on.
        ENDLOOP.
        l_outtab-modcomment_cnt = l_modcomment_cnt.
      ENDIF.
    ELSE.
      REFRESH lt_natm.
        CALL METHOD cl_ish_run_dp=>read_dateoffermod_for_pob_date
          EXPORTING
            i_einri           = l_outtab-einri
            i_pobnr           = l_napp-pobnr
            i_date            = l_outtab-date
*           I_CANCELLED_DATAS =
*Sta/PN/MED-40483
*           adjust_buffer_from_memory not necessary -> give no environment
*           i_environment     = g_environment
*End/PN/MED-40483
            i_buffer_active   = on
*           I_READ_DB         = SPACE
          IMPORTING
            e_rc              = l_rc
            et_natm           = lt_natm
          CHANGING
            c_errorhandler    = c_errorhandler.
      IF l_rc = 0.
        READ TABLE lt_natm INTO l_natm INDEX 1.
        IF sy-subrc = 0.
          l_outtab-modcomment = l_natm-commnt.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

* START MED-40483
* context find out at an other time
* Kontexte ermitteln
*  IF l_dsp_context = on
**   Prüfen, ob Anforderung oder Klin. Auftrag Auslöser eines Kontext ist
*    IF NOT l_n1anf-anfid IS INITIAL OR NOT l_n1vkg-vkgid IS INITIAL.
*      CLEAR l_cx_object.
*      IF NOT l_n1anf-anfid IS INITIAL.   " Anforderung
**       Objekt-Schlüssel für Zuordnung zu einem Kontext ermitteln.
*        CALL METHOD cl_ishmed_request=>build_key_string
*          EXPORTING
*            i_mandt = sy-mandt
*            i_einri = l_outtab-einri
*            i_anfid = l_n1anf-anfid
*          IMPORTING
*            e_key   = l_cx_key.
*        CALL METHOD cl_ish_context=>get_key_for_obj
*          EXPORTING
*            i_object_type = cl_ishmed_request=>co_otype_request
*            i_key         = l_cx_key
*          IMPORTING
*            e_key         = l_cx_object-objtyid
*            e_type        = l_cx_object-objty.
*      ELSE.                              " Klin. Auftragsposition
**       Objekt-Schlüssel für Zuordnung zu einem Kontext ermitteln.
*        CALL METHOD cl_ishmed_prereg=>build_key_string
*          EXPORTING
*            i_mandt = sy-mandt
*            i_vkgid = l_n1vkg-vkgid
*          IMPORTING
*            e_key   = l_cx_key.
*        CALL METHOD cl_ish_context=>get_key_for_obj
*          EXPORTING
*            i_object_type = cl_ishmed_prereg=>co_otype_prereg
*            i_key         = l_cx_key
*          IMPORTING
*            e_key         = l_cx_object-objtyid
*            e_type        = l_cx_object-objty.
*      ENDIF.
*      CALL METHOD cl_ishmed_run_dp=>read_context_for_object
*        EXPORTING
*          i_object_type     = l_cx_object-objty
*          i_object_id       = l_cx_object-objtyid
**         IT_OBJECTS        =
**         i_ctoty           = '1' " am Kontext beteiligt
*          i_ctoty           = '0'   " Auslöser des Kontext
*          i_ctx_nbr         = '3'   " Anzahl zu suchende Kontexte
**         I_CANCELLED_DATAS = SPACE
**         I_ENVIRONMENT     =
*          i_buffer_active   = 'X'
**         I_READ_DB         = SPACE
*        IMPORTING
*          e_rc              = l_rc
**         ET_NCTO           =
**         ET_NCTX           =
*          et_context        = lt_context.
*      IF l_rc = 0.
*        LOOP AT lt_context INTO l_context.
*          CASE l_context-nbr.
*            WHEN 1.
*              l_outtab-kontext1    = l_context-cxtypsn.
*              l_outtab-cxid1       = l_context-cxid.
*              l_outtab-cxsta1      = l_context-cxstanm.
*              l_outtab-cxsta_icon1 = l_context-cxsicon.
*            WHEN 2.
*              l_outtab-kontext2    = l_context-cxtypsn.
*              l_outtab-cxid2       = l_context-cxid.
*              l_outtab-cxsta2      = l_context-cxstanm.
*              l_outtab-cxsta_icon2 = l_context-cxsicon.
*            WHEN 3.
*              l_outtab-kontext3    = l_context-cxtypsn.
*              l_outtab-cxid3       = l_context-cxid.
*              l_outtab-cxsta3      = l_context-cxstanm.
*              l_outtab-cxsta_icon3 = l_context-cxsicon.
*          ENDCASE.
*        ENDLOOP.
*      ENDIF.
*    ENDIF.
*  ENDIF.
* END MED-40483

* In den Zeitfeldern nicht 00:00 anzeigen
  IF l_outtab-wtime IS INITIAL.
    l_outtab-wtime     = '      '.
  ENDIF.
  IF l_outtab-tmpzt IS INITIAL.
    l_outtab-tmpzt     = '      '.
  ENDIF.
  IF l_outtab-afnzt IS INITIAL.
    l_outtab-afnzt     = '      '.
  ENDIF.
  IF l_outtab-ztmk_zeit IS INITIAL.
    l_outtab-ztmk_zeit = '      '.
  ENDIF.
  IF l_outtab-todzt IS INITIAL.
    l_outtab-todzt     = '      '.
  ENDIF.
  IF l_outtab-todzb IS INITIAL.
    l_outtab-todzb     = '      '.
  ENDIF.
  IF l_outtab-opbeg_time IS INITIAL.
    l_outtab-opbeg_time    = '      '.                      " MED-41209
  ENDIF.
  IF l_outtab-prgs_time_beg IS INITIAL.
    l_outtab-prgs_time_beg = '      '.                      " MED-41209
  ENDIF.
  IF l_outtab-prgs_time_end IS INITIAL.
    l_outtab-prgs_time_end = '      '.                      " MED-41209
  ENDIF.

* Weitere (vor allem techn.) Felder für alle Zeilen des Termins füllen
  l_outtab_all-prio        = l_outtab-prio.
  l_outtab_all-tmtag       = l_outtab-tmtag.
  l_outtab_all-lfdbew      = l_outtab-lfdbew.
  l_outtab_all-falnr       = l_outtab-falnr.                " BA 2011
  l_outtab_all-patnr       = l_outtab-patnr.                " BA 2011

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Nun bestimmen, ob der Termin ein- oder mehrzeilig angezeigt wird ...
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

* Leistungen vorhanden?
  DESCRIBE TABLE gt_services LINES l_lin_srv.
* Diagnosen vorhanden?
  DESCRIBE TABLE lt_diag LINES l_lin_diag.
  IF l_lin_srv = 0 AND l_lin_diag = 0.
*   keine Leistungen und Diagnosen vorhanden
    l_outtab-seqno = 1.
    l_outtab-openclose = icon_space.
    APPEND l_outtab TO lt_outtab.
  ELSE.
*   Leistungen vorhanden
*   Darstellung des Termins ... (mehrzeilig/einzeilig) ...
    IF g_node_open = on.
*     ... mehrzeilig
      CLEAR: l_most_lines, l_cnt.
      IF l_lin_srv >= l_lin_diag.
        l_most_lines = 'S'.
      ELSE.
        l_most_lines = 'D'.
      ENDIF.
      CASE l_most_lines.
        WHEN 'S'.
*         Leistungen haben die meisten Zeilen
          LOOP AT gt_services INTO l_service.
*           Zähler für Zeilennummer innerhalb des Termins hochzählen
            l_cnt = l_cnt + 1.
            IF l_cnt = 1.
*             1. Zeile des Termins
              IF l_lin_srv > 1 OR l_lin_diag > 1.
*               'Offen'-Folder nur, wenn der Termin mehr als 1 Zeile hat
                l_outtab-openclose = icon_open_folder.
              ELSE.
                l_outtab-openclose = icon_space.
              ENDIF.
            ELSE.
*             'Folgezeilen' des Termins
              CLEAR l_outtab.
*             Zeiten (00:00) in den Folgezeilen nicht anzeigen
              l_outtab-time          = '      '.
              l_outtab-wtime         = '      '.
              l_outtab-tmpzt         = '      '.
              l_outtab-afnzt         = '      '.
              l_outtab-ztmk_zeit     = '      '.
              l_outtab-todzt         = '      '.
              l_outtab-todzb         = '      '.
              l_outtab-opbeg_time    = '      '.            " MED-41209
              l_outtab-prgs_time_beg = '      '.            " MED-41209
              l_outtab-prgs_time_end = '      '.            " MED-41209
*             Felder übergeben, die in allen Zeilen befüllt sind
              l_outtab = l_outtab_all.
*             ... ohne Folder darstellen
              l_outtab-openclose = icon_space.
            ENDIF.
            l_outtab-seqno = l_cnt.
*           Leistungsdaten
            CALL METHOD cl_ish_display_tools=>fill_service_data
              EXPORTING
                i_service      = l_service
                i_node_closed  = off
                i_place_holder = l_place_holder
                it_services    = gt_services
              IMPORTING
                e_rc           = e_rc
              CHANGING
                c_outtab_line  = l_outtab
                c_errorhandler = c_errorhandler.
            IF e_rc <> 0.
              EXIT.
            ENDIF.
*           auch eine Diagnose in diese Zeile stellen
            IF l_cnt <= l_lin_diag.
              READ TABLE lt_diag INTO l_diag INDEX l_cnt.
              IF sy-subrc = 0.
                l_outtab-diagnose = l_diag-diagnose.
                l_outtab-dialo    = l_diag-dialo.
                l_outtab-diagobj  = l_diag-object.
              ENDIF.
            ELSE.
              CLEAR: l_outtab-diagnose, l_outtab-dialo,
                     l_outtab-diagobj.
            ENDIF.
            APPEND l_outtab TO lt_outtab.
          ENDLOOP.
        WHEN 'D'.
*         Diagnosen haben die meisten Zeilen
          LOOP AT lt_diag INTO l_diag.
*           Zähler für Zeilennummer innerhalb des Termins hochzählen
            l_cnt = l_cnt + 1.
            IF l_cnt = 1.
*             1. Zeile des Termins
              IF l_lin_srv > 1 OR l_lin_diag > 1.
*               'Offen'-Folder nur, wenn der Termin mehr als 1 Zeile hat
                l_outtab-openclose = icon_open_folder.
              ELSE.
                l_outtab-openclose = icon_space.
              ENDIF.
            ELSE.
*             'Folgezeilen' des Termins
              CLEAR l_outtab.
*             Felder übergeben, die in allen Zeilen befüllt sind
              l_outtab = l_outtab_all.
*             Zeiten (00:00) in den Folgezeilen nicht anzeigen
              l_outtab-time          = '      '.
              l_outtab-wtime         = '      '.
              l_outtab-tmpzt         = '      '.
              l_outtab-afnzt         = '      '.
              l_outtab-ztmk_zeit     = '      '.
              l_outtab-todzt         = '      '.
              l_outtab-todzb         = '      '.
              l_outtab-opbeg_time    = '      '.            " MED-41209
              l_outtab-prgs_time_beg = '      '.            " MED-41209
              l_outtab-prgs_time_end = '      '.            " MED-41209
*             ... ohne Folder darstellen
              l_outtab-openclose = icon_space.
            ENDIF.
            l_outtab-seqno    = l_cnt.
            l_outtab-diagnose = l_diag-diagnose.
            l_outtab-dialo    = l_diag-dialo.
            l_outtab-diagobj  = l_diag-object.
*           auch einen Leistungseintrag in diese Zeile stellen
            IF l_cnt <= l_lin_srv.
              READ TABLE gt_services INTO l_service INDEX l_cnt.
              IF sy-subrc = 0.
*               Leistungsdaten
                CALL METHOD cl_ish_display_tools=>fill_service_data
                  EXPORTING
                    i_service      = l_service
                    i_node_closed  = off
                    i_place_holder = l_place_holder
                    it_services    = gt_services
                  IMPORTING
                    e_rc           = e_rc
                  CHANGING
                    c_outtab_line  = l_outtab
                    c_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  EXIT.
                ENDIF.
              ENDIF.
            ENDIF.
            APPEND l_outtab TO lt_outtab.
          ENDLOOP.
      ENDCASE.
      CHECK e_rc = 0.
    ELSE.
*     ... einzeilig
*     Leistungen
      LOOP AT gt_services INTO l_service.
*       Leistungsdaten
        CALL METHOD cl_ish_display_tools=>fill_service_data
          EXPORTING
            i_service      = l_service
            i_node_closed  = on
            i_place_holder = l_place_holder
            it_services    = gt_services
          IMPORTING
            e_rc           = e_rc
          CHANGING
            c_outtab_line  = l_outtab
            c_errorhandler = c_errorhandler.
        IF e_rc <> 0.
          EXIT.
        ENDIF.
      ENDLOOP.
      CHECK e_rc = 0.
*     Diagnosen
      l_dialo_exists = off.
      LOOP AT lt_diag INTO l_diag WHERE NOT dialo IS INITIAL.
        l_dialo_exists = on.
        EXIT.
      ENDLOOP.
      LOOP AT lt_diag INTO l_diag.
        IF l_outtab-diagnose IS INITIAL.
          l_outtab-diagnose = l_diag-diagnose.
          l_outtab-dialo    = l_diag-dialo.
          IF l_outtab-dialo IS INITIAL.
            IF l_dialo_exists = on AND l_lin_diag > 1.
              l_outtab-dialo  = l_place_holder.
            ENDIF.
          ENDIF.
        ELSE.
          CONCATENATE l_outtab-diagnose l_diag-diagnose
                      INTO l_outtab-diagnose SEPARATED BY ', '.
          IF l_diag-dialo IS INITIAL.
            IF l_dialo_exists = on AND l_lin_diag > 1.
              CONCATENATE l_outtab-dialo l_place_holder
                          INTO l_outtab-dialo SEPARATED BY ', '.
            ENDIF.
          ELSE.
            CONCATENATE l_outtab-dialo l_diag-dialo
                        INTO l_outtab-dialo SEPARATED BY ', '.
          ENDIF.
        ENDIF.
      ENDLOOP.
      l_outtab-seqno = 1.
*     'Geschlossen'-Folder nur, wenn der Termin mehr als 1 Zeile hat
      IF l_lin_srv > 1.
        l_outtab-openclose = icon_closed_folder.
      ELSE.
        l_outtab-openclose = icon_space.
      ENDIF.
      APPEND l_outtab TO lt_outtab.
    ENDIF.     " IF g_node_open = on.

  ENDIF.     " IF l_lin_srv = 0.

  et_outtab[] = lt_outtab[].
  gt_outtab[] = lt_outtab[].

ENDMETHOD.


METHOD if_ish_display_object~destroy .

  CALL METHOD me->initialize.

  FREE: gt_subobjects,
        gt_outtab,
        gt_services.

  FREE: g_object,
        g_environment.

  FREE: g_appointment,
        g_movement,
        g_prereg,
        g_request.

  FREE: gr_movement.                                        "MED_40483

ENDMETHOD.


METHOD if_ish_display_object~get_data .

  DATA: l_object      LIKE LINE OF et_object,
        l_service     LIKE LINE OF gt_services.

  REFRESH: et_object.

* Erzeugendes Objekt
  IF NOT g_object IS INITIAL.
    l_object-object = g_object.
    APPEND l_object TO et_object.
  ENDIF.

* Termin
  IF NOT g_appointment IS INITIAL.
    l_object-object = g_appointment.
    APPEND l_object TO et_object.
  ENDIF.

* Bewegung
* START MED-40483 2010/07/07
  IF gr_movement is not initial.
    clear l_object.
    l_object-object = g_movement.
    APPEND l_object TO et_object.
  ENDIF.
* END MED-40483
  IF NOT g_movement IS INITIAL.
    l_object-object = g_movement.
    APPEND l_object TO et_object.
  ENDIF.

* Vormerkung
  IF NOT g_prereg IS INITIAL.
    l_object-object = g_prereg.
    APPEND l_object TO et_object.
  ENDIF.

* Anforderng
  IF NOT g_request IS INITIAL.
    l_object-object = g_request.
    APPEND l_object TO et_object.
  ENDIF.

* Leistungen
  LOOP AT gt_services INTO l_service.
    l_object-object = l_service.
    APPEND l_object TO et_object.
  ENDLOOP.

* Doppelte löschen
  SORT et_object BY object.
  DELETE ADJACENT DUPLICATES FROM et_object COMPARING object.

ENDMETHOD.


method IF_ISH_DISPLAY_OBJECT~GET_FIELDCATALOG .

  DATA: lt_fieldcat   TYPE lvc_t_fcat,
        l_fieldcat    LIKE LINE OF lt_fieldcat.

* Initialization
  CLEAR e_rc.
  REFRESH et_fieldcat.
  REFRESH lt_fieldcat.

* Errorhandler instanzieren, falls nötig
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Feldkatalog für DDIC-Struktur RN1DISPLAY_FIELDS ermitteln
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
     EXPORTING
              i_buffer_active        = on
              i_structure_name       = 'RN1DISPLAY_FIELDS'
*             I_CLIENT_NEVER_DISPLAY = 'X'
              i_bypassing_buffer     = on
     CHANGING
              ct_fieldcat            = lt_fieldcat
     EXCEPTIONS
              inconsistent_interface = 1
              program_error          = 2
              OTHERS                 = 3.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* Feldkatalog überarbeiten ...
* ... dazu DERZEIT den FuB des Sichttyp OP aufrufen, der die
* Überarbeitung durchführt
* (damit das nicht doppelt auszuprogrammieren und zu warten ist!)
* hier im Gegensatz zum Sichttyp OP aber nicht mit dem Feldkatalog
* der Struktur RN1WP_OP_LIST sondern der RN1DISPLAY_FIELDS übergeben
* diese Methode hier wird aber vom Sichttyp OP ohnehin nicht verwendet
* also wenn an das Anzeigeobjekt Termin andere Anforderungen gestellt
* werden sollten, kann man das ja ändern ...
  CALL FUNCTION 'ISHMED_VP_AVAR_011'
    CHANGING
      c_dispvar = lt_fieldcat.
* ... und nun alle jene Felder, die mit SP_GROUP = 'Z' (kundenspez.)
* zurückgeliefert werden, hier als technisch klassifizieren, da das
* hier alle Felder des Gesamtfeldkatalogs sind, die für das Anzeige-
* objekt 'Operation' irrelevant sind!
  LOOP AT lt_fieldcat INTO l_fieldcat WHERE sp_group = 'Z'.
*   als technisch klassifizieren und nicht anzeigen
    l_fieldcat-tech   = on.
    l_fieldcat-no_out = on.
    MODIFY lt_fieldcat FROM l_fieldcat.
  ENDLOOP.

* Feldkatalog zurückliefern
  et_fieldcat[] = lt_fieldcat[].

endmethod.


METHOD IF_ISH_DISPLAY_OBJECT~GET_MERGED_VALUES .

  DATA: l_outtab          LIKE LINE OF gt_outtab.

  CLEAR e_outtab.
  REFRESH et_no_merge_fields.

* Nur die 1. Zeile nehmen
  LOOP AT gt_outtab INTO l_outtab WHERE seqno = 1.

*   alle Felder/Spalten leer zurückliefern, die nicht in allen
*   Zeilen des Anzeigeobjekts den gleichen Wert enthalten
*   (also alle Spalten die mehrzeilig werden können, d.h.
*   die NICHT gemerged werden dürfen!)

*   Leistungsdaten
    CLEAR: l_outtab-srv, l_outtab-srv_bez, l_outtab-srv_ergtx,
           l_outtab-srv_lslok, l_outtab-srv_lgrbez,
           l_outtab-patein_icon, l_outtab-ifgr,
           l_outtab-ifgr_icon, l_outtab-ifgr_txt.

*   Diagnosedaten
    CLEAR: l_outtab-diagnose, l_outtab-dialo.

*   Teamdaten
    CLEAR: l_outtab-team1_kurz, l_outtab-team1,
           l_outtab-team2_kurz, l_outtab-team2,
           l_outtab-team3_kurz, l_outtab-team3,
           l_outtab-team4_kurz, l_outtab-team4.

*   Laufende Satznummer
    CLEAR: l_outtab-seqno.

    e_outtab = l_outtab.

  ENDLOOP.

* alle diese Feldnamen auch in der Tabelle retournieren
  CALL METHOD cl_ishmed_dspobj_appointment=>get_no_merged_fields
    IMPORTING
      et_no_merge_fields = et_no_merge_fields.

ENDMETHOD.


METHOD if_ish_display_object~get_type .

  e_object_type = co_otype_dspobj_appointment.

ENDMETHOD.


METHOD if_ish_display_object~initialize .

  REFRESH: gt_subobjects,
           gt_outtab,
           gt_services.

  CLEAR:   g_object,
           g_environment,
           g_cancelled,
           g_cancelled_data.

  CLEAR:   g_appointment,
           g_movement,
           g_prereg,
           g_request,
           g_anonym.

  CLEAR: gr_movement.                                       "MED-40483

ENDMETHOD.


METHOD if_ish_display_object~is_cancelled .

  e_cancelled = g_cancelled.

ENDMETHOD.


METHOD if_ish_display_object~load .

  DATA: l_rc          TYPE sy-subrc,
        lt_object     TYPE ish_objectlist,
        l_object      LIKE LINE OF lt_object,
        l_environment TYPE REF TO cl_ish_environment.

  CLEAR: e_rc, e_instance, e_cancelled.

* Errorhandler instanzieren, falls nötig
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Environment ermitteln/instanzieren, falls nötig
  IF c_environment IS INITIAL.
    REFRESH lt_object.
    IF NOT i_object IS INITIAL.
      l_object-object = i_object.
      APPEND l_object TO lt_object.
    ENDIF.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = lt_object
      CHANGING
        c_environment = c_environment.
  ENDIF.
  l_environment = c_environment.

* Anzeigeobjekt instanzieren
  g_construct = on.
  CREATE OBJECT e_instance TYPE cl_ishmed_dspobj_appointment
    EXPORTING
      i_object              = i_object
      i_environment         = l_environment
      i_node_open           = i_node_open
      i_cancelled_data      = i_cancelled_data
      i_check_only          = i_check_only
    EXCEPTIONS
      instance_not_possible = 1
      no_appointment        = 2
      OTHERS                = 3.
  l_rc = sy-subrc.
  g_construct = off.

  CASE l_rc.
    WHEN 0.
*     OK - Anzeigeobjekt 'Termin' wurde instanziert
    WHEN 2.
*     Objekt ist kein Termin
      e_rc = 99.        " Zu diesem Objekt existiert kein Termin
      CLEAR e_instance.
      EXIT.
    WHEN OTHERS.
*     Fehler beim Instanzieren des Anzeigeobjekts
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '117'       " Termin existiert nicht
          i_last = space.
      e_rc = 1.
      CLEAR e_instance.
      EXIT.
  ENDCASE.

* Prüfen, ob der Termin storniert ist ...
  CALL METHOD e_instance->('IS_CANCELLED')
    IMPORTING
      e_cancelled = e_cancelled.

* Ereignis auslösen: Daten wurden gelesen
  RAISE EVENT after_read
    EXPORTING
      i_object = e_instance.

ENDMETHOD.


METHOD if_ish_display_object~open_node .

  CLEAR e_rc.

* Errorhandler instanzieren, falls nötig
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  g_node_open = on.

  CALL METHOD me->convert_for_display
    EXPORTING
      it_fieldcat    = it_fieldcat
    IMPORTING
      et_outtab      = et_outtab
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.

ENDMETHOD.


METHOD if_ish_display_object~remove_data .                  "#EC NEEDED

ENDMETHOD.


METHOD if_ish_display_object~set_main_data.

* Lokale Tabellen
  DATA: lt_object                  TYPE ish_objectlist,
        lt_requests                TYPE ishmed_t_request_object,
        lt_preregs                 TYPE ishmed_t_prereg_object,
        lt_srv                     TYPE ishmed_t_service_object.
* Workareas
  DATA: l_object                   LIKE LINE OF lt_object.
* Hilfsfelder und -strukturen
  DATA: l_type                     TYPE i,
        l_rc                       TYPE ish_method_rc,
        l_nbew                     TYPE nbew,
        l_ntmn                     TYPE ntmn,
        ls_n1anf                   TYPE n1anf,
        ls_n1corder                TYPE n1corder,
        l_tmnid                    TYPE ntmn-tmnid.
* Objekt-Instanzen
  DATA: l_srv                      TYPE REF TO cl_ishmed_service,
        l_prereg                   TYPE REF TO cl_ishmed_prereg,
        l_request                  TYPE REF TO cl_ishmed_request,
        l_app                      TYPE REF TO cl_ish_appointment,
        l_environment              TYPE REF TO cl_ish_environment,
        l_mov                      TYPE REF TO cl_ishmed_none_oo_nbew,
        lr_corder                  TYPE REF TO cl_ish_corder.
  DATA lr_move     TYPE REF TO cl_ishmed_movement.
* ---------- ---------- ----------
* Initialisierung
  CLEAR: e_rc.

  REFRESH: gt_services.

  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Notwendige Übergabedaten prüfen
  IF i_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* ---------- ---------- ----------
* Übergebenes Objekt in Tabelle stellen
  REFRESH: lt_object.
  IF NOT i_object IS INITIAL.
    l_object-object = i_object.
    APPEND l_object TO lt_object.
  ENDIF.
* ---------- ---------- ----------
* Environment ermitteln/instanzieren, falls nötig
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = lt_object
      CHANGING
        c_environment = c_environment.
  ENDIF.
  l_environment = c_environment.
* ---------- ---------- ----------
* Übergebenes Objekt prüfen; folgende Objekte erlaubt:
* - Termin
* - Leistung (OP-/Behandlungstermin ermitteln)
* - Vormerkung (Aufnahmetermin ermitteln)
* - Bewegung (Termin ermitteln)
* START MED-40483 2010/07/07
* -- ---------- ----------
* Termin bestimmen.
*   Termin
    TRY .
        g_appointment ?= i_object.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
*       Leistung -> Termin ermitteln
        TRY .
            l_srv ?= i_object.
            CALL METHOD cl_ishmed_service=>get_appmnt_for_service
              EXPORTING
                i_service          = l_srv
                i_environment      = l_environment
                i_read_over_anchor = on
                i_cancelled_datas  = space
              IMPORTING
                e_appointment      = l_app
                e_rc               = l_rc
              CHANGING
                c_errorhandler     = c_errorhandler.
            IF l_rc = 0.
              g_appointment = l_app.
            ELSE.
              e_rc = l_rc.
              EXIT.
            ENDIF.
          CATCH cx_sy_move_cast_error.                  "#EC NO_HANDLER
*           Vormerkung -> Aufnahmetermin ermitteln
            TRY .
                l_prereg ?= i_object.
                CALL METHOD cl_ishmed_prereg=>get_admission_appmnt
                  EXPORTING
                    i_cancelled_datas = off
                    i_prereg          = l_prereg
                    i_environment     = l_environment
                  IMPORTING
                    e_rc              = l_rc
                    e_appmnt          = l_app
                  CHANGING
                    c_errorhandler    = c_errorhandler.
                IF l_rc = 0.
                  g_appointment = l_app.
                  g_prereg      = l_prereg.
                ELSE.
                  e_rc = l_rc.
                  EXIT.
                ENDIF.
              CATCH cx_sy_move_cast_error.              "#EC NO_HANDLER
*               Bewegung -> Termin ermitteln
                TRY .
                    lr_move ?= i_object.
                    CALL METHOD lr_move->get_data
                      IMPORTING
                        e_rc           = l_rc
                        e_nbew         = l_nbew
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF l_rc <> 0.
                      e_rc = l_rc.
                      EXIT.
                    ENDIF.
                    CALL METHOD cl_ishmed_outpat_visit_med=>get_appmnt_for_movement
                      EXPORTING
                        i_movement        = lr_move
                        i_cancelled_datas = space
                        i_mode_requested  = space
                      IMPORTING
                        e_rc              = l_rc
                        e_appmnt          = l_app
                      CHANGING
                        c_errorhandler    = c_errorhandler.
                    IF l_rc = 0.
                      g_appointment = l_app.
                      gr_movement    = lr_move.
                    ELSE.
                      e_rc = l_rc.
                      EXIT.
                    ENDIF.
                  CATCH cx_sy_move_cast_error.          "#EC NO_HANDLER
*                  nothing to do.
                ENDTRY.
            ENDTRY.
        ENDTRY.
    ENDTRY.

*    CALL METHOD i_object->('GET_TYPE')
*      IMPORTING
*        e_object_type = l_type.
*    IF l_type <> cl_ish_appointment=>co_otype_appointment AND
*       l_type <> cl_ishmed_service=>co_otype_med_service  AND
*       l_type <> cl_ishmed_prereg=>co_otype_prereg        AND
*       l_type <> cl_ishmed_cordpos=>co_otype_cordpos_med   AND
*       l_type <> cl_ishmed_none_oo_nbew=>co_otype_none_oo_nbew.
*      e_rc = 1.
*      EXIT.
*    ENDIF.
** ---------- ---------- ----------
** Termin bestimmen.
*    CASE l_type.
**   Termin
*      WHEN cl_ish_appointment=>co_otype_appointment.
*        g_appointment ?= i_object.
**   Leistung -> Termin ermitteln
*      WHEN cl_ishmed_service=>co_otype_med_service OR
*           cl_ishmed_service=>co_otype_anchor_srv.
*        l_srv ?= i_object.
*        CALL METHOD cl_ishmed_service=>get_appmnt_for_service
*          EXPORTING
*            i_service          = l_srv
*            i_environment      = l_environment
*            i_read_over_anchor = on
*            i_cancelled_datas  = space
*          IMPORTING
*            e_appointment      = l_app
*            e_rc               = l_rc
*          CHANGING
*            c_errorhandler     = c_errorhandler.
*        IF l_rc = 0.
*          g_appointment = l_app.
*        ELSE.
*          e_rc = l_rc.
*          EXIT.
*        ENDIF.
**   Vormerkung -> Aufnahmetermin ermitteln
*      WHEN cl_ishmed_prereg=>co_otype_prereg OR
*           cl_ishmed_cordpos=>co_otype_cordpos_med.
*        l_prereg ?= i_object.
*        CALL METHOD cl_ishmed_prereg=>get_admission_appmnt
*          EXPORTING
*            i_cancelled_datas = off
*            i_prereg          = l_prereg
*            i_environment     = l_environment
*          IMPORTING
*            e_rc              = l_rc
*            e_appmnt          = l_app
*          CHANGING
*            c_errorhandler    = c_errorhandler.
*        IF l_rc = 0.
*          g_appointment = l_app.
*          g_prereg      = l_prereg.
*        ELSE.
*          e_rc = l_rc.
*          EXIT.
*        ENDIF.
**   Bewegung -> Termin ermitteln
*      WHEN cl_ishmed_none_oo_nbew=>co_otype_none_oo_nbew.
*        l_mov ?= i_object.
*        CALL METHOD l_mov->get_data
*          IMPORTING
*            e_rc           = l_rc
*            e_nbew         = l_nbew
*          CHANGING
*            c_errorhandler = c_errorhandler.
*        IF l_rc <> 0.
*          e_rc = l_rc.
*          EXIT.
*        ENDIF.
*        IF NOT l_nbew-falnr IS INITIAL AND
*           NOT l_nbew-lfdnr IS INITIAL.
*          SELECT tmnid FROM ntmn INTO l_tmnid UP TO 1 ROWS
*             WHERE einri = l_nbew-einri
*               AND falnr = l_nbew-falnr
*               AND tmnlb = l_nbew-lfdnr
*               AND bewty = '4'
*               AND storn = off.
*            EXIT.
*          ENDSELECT.
*          IF     sy-subrc =  0 AND
*             NOT l_tmnid  IS INITIAL.
*            CALL METHOD cl_ish_appointment=>load
*              EXPORTING
*                i_tmnid        = l_tmnid
*                i_environment  = l_environment
*              IMPORTING
*                e_rc           = l_rc
*                e_instance     = l_app
*              CHANGING
*                c_errorhandler = c_errorhandler.
*            IF l_rc = 0.
*              g_appointment = l_app.
*              g_movement    = l_mov.
*            ELSE.
*              e_rc = l_rc.
*              EXIT.
*            ENDIF.
*          ENDIF.
*        ENDIF.
*    ENDCASE.
* END MED-40483
* ---------- ---------- ----------
* Termin muss vorhanden sein.
  IF g_appointment IS INITIAL.
    e_rc = 1.
    EXIT.
  ELSE.
*   prüfen, ob der Termin storniert ist
    CALL METHOD g_appointment->get_data
      EXPORTING
        i_fill_appointment = off
      IMPORTING
        es_ntmn            = l_ntmn
        e_rc               = l_rc
      CHANGING
        c_errorhandler     = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ELSE.
      IF l_ntmn-storn = on.
*       Termin ist storniert!
        g_cancelled = on.
*       Wenn der Termin storniert ist, dann auch das Kennzeichen
*       'Stornierte Daten lesen' auf ON setzen, damit alle Daten
*       zum stornierten Termin gefunden werden können
        g_cancelled_data = on.
      ENDIF.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------
  IF i_check_only = off.
*   Daten dazulesen und merken ...
    REFRESH lt_srv.
*   Leistungen
    CALL METHOD cl_ishmed_functions=>get_services
      EXPORTING
        it_objects         = lt_object
        i_conn_srv         = on
        i_only_main_anchor = on
        i_cancelled_datas  = g_cancelled_data
        i_read_db          = abap_false                     "MED-40483
      IMPORTING
        e_rc               = l_rc
        et_services        = lt_srv
      CHANGING
        c_environment      = l_environment
        c_errorhandler     = c_errorhandler.
    IF l_rc = 0.
*     Leistungen nach dem Feld NLEM-SORTLEIST sortieren
      DESCRIBE TABLE lt_srv.
      IF sy-tfill > 1.
        CALL METHOD cl_ish_display_tools=>sort_services
          EXPORTING
            i_sort_field   = 'SORTLEIST'
          IMPORTING
            e_rc           = e_rc
          CHANGING
            ct_services    = lt_srv
            c_errorhandler = c_errorhandler.
        IF e_rc <> 0.
          EXIT.
        ENDIF.
      ENDIF.
      gt_services[] = lt_srv[].
    ELSE.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   ---------- ---------- ----------
*   Falls es sich um einen Aufnahmetermin handelt auch Vormerkung
*   bestimmen.
    IF g_prereg IS INITIAL.
      CALL METHOD cl_ish_appointment=>get_prereg_for_appmnt
        EXPORTING
          i_cancelled_datas = g_cancelled_data
          i_appointment     = g_appointment
          i_environment     = l_environment
        IMPORTING
          e_rc              = l_rc
          e_prereg          = l_prereg
        CHANGING
          c_errorhandler    = c_errorhandler.
      IF l_rc = 0.
        IF NOT l_prereg IS INITIAL.
          g_prereg = l_prereg.
        ELSE.
*         keine Vormerkung gefunden,
*         d.h. es handelt sich nicht um einen Aufnahmetermin,
*         daher die Vormerkung oder Anforderung zum Besuchstermin
*         ermitteln
          CALL METHOD cl_ishmed_functions=>get_requests
            EXPORTING
              it_objects        = lt_object
              i_cancelled_datas = g_cancelled_data
              i_read_db         = abap_false                "MED-40483
            IMPORTING
              e_rc              = l_rc
              et_requests       = lt_requests
            CHANGING
              c_environment     = l_environment
              c_errorhandler    = c_errorhandler.
          IF l_rc = 0.
            READ TABLE lt_requests INTO l_request INDEX 1.
            IF sy-subrc = 0.
              g_request = l_request.
            ELSE.
              CALL METHOD cl_ishmed_functions=>get_preregistrations
                EXPORTING
                  it_objects        = lt_object
                  i_cancelled_datas = g_cancelled_data
                  i_read_db         = abap_false            "MED-40483
                IMPORTING
                  e_rc              = l_rc
                  et_preregs        = lt_preregs
                CHANGING
                  c_environment     = l_environment
                  c_errorhandler    = c_errorhandler.
              IF l_rc = 0.
                READ TABLE lt_preregs INTO l_prereg INDEX 1.
                IF sy-subrc = 0.
                  g_prereg = l_prereg.
                ENDIF.
              ELSE.
                e_rc = l_rc.
                EXIT.
              ENDIF.
            ENDIF.
          ELSE.
            e_rc = l_rc.
            EXIT.
          ENDIF.
        ENDIF.
      ELSE.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.
*   ---------- ---------- ----------
*   Falls es sich um einen Termin mit Bewegungsbezug handelt - und
*   die Bewegung noch nicht vorhanden ist - die Bewegung bestimmen
    IF g_movement IS INITIAL AND l_ntmn-tmnlb IS NOT INITIAL.
      CALL METHOD cl_ishmed_none_oo_nbew=>load
        EXPORTING
          i_einri        = l_ntmn-einri
          i_falnr        = l_ntmn-falnr
          i_lfdnr        = l_ntmn-tmnlb
        IMPORTING
          e_instance     = l_mov
          e_rc           = l_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc = 0.
        g_movement = l_mov.
      ELSE.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.
*   ---------- ---------- ----------
*   Globale Detaildaten befüllen
    g_erboe = l_ntmn-tmnoe.
    IF g_request IS NOT INITIAL.
      CALL METHOD g_request->get_data
        IMPORTING
          e_rc           = e_rc
          e_n1anf        = ls_n1anf
        CHANGING
          c_errorhandler = c_errorhandler.
      IF e_rc = 0.
        g_anpoe = ls_n1anf-anpoe.
        g_anfoe = ls_n1anf-anfoe.
      ELSE.
        EXIT.
      ENDIF.
    ENDIF.
    IF g_prereg IS NOT INITIAL.
      CALL METHOD g_prereg->get_corder
        EXPORTING
          ir_environment  = l_environment
        IMPORTING
          er_corder       = lr_corder
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      IF e_rc = 0.
        CALL METHOD lr_corder->get_data
          IMPORTING
            es_n1corder     = ls_n1corder
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = c_errorhandler.
        IF e_rc = 0.
          g_anpoe = ls_n1corder-etroe.
          g_anfoe = ls_n1corder-orddep.
        ELSE.
          EXIT.
        ENDIF.
      ELSE.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

* Zuletzt Environment ebenfalls global merken
  g_environment = c_environment.

ENDMETHOD.


METHOD if_ish_display_object~set_node .

  g_node_open = i_node_open.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.
  e_object_type = co_otype_dspobj_appointment.    "MED-33929
ENDMETHOD.


method IF_ISH_IDENTIFY_OBJECT~IS_A.
  DATA: l_object_type TYPE i.                   "MED-33929

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.            "MED-33929
  IF l_object_type = i_object_type.             "MED-33929
    r_is_a = on.                                "MED-33929
  ELSE.                                         "MED-33929
    r_is_a = off.                               "MED-33929
  ENDIF.                                        "MED-33929
endmethod.


method IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM.
  IF i_object_type = co_otype_dspobj_appointment.   "MED-33929
    r_is_inherited_from = on.                       "MED-33929
  ENDIF.                                            "MED-33929
endmethod.


METHOD set_nosave.
*New/PN/MED-40483
  g_nosave = i_nosave.
ENDMETHOD.


METHOD set_patients_anonym .

  g_anonym = i_anonym.

ENDMETHOD.
ENDCLASS.
