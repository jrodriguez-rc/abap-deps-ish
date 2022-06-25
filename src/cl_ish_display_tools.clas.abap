class CL_ISH_DISPLAY_TOOLS definition
  public
  abstract
  create public .

public section.
  interface IF_ISH_LIST_DISPLAY load .

  interfaces IF_ISH_CONSTANT_DEFINITION .

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

  class-methods CLEAR_BUFFER .
  class-methods CONVERT_OUTTAB
    importing
      value(IT_OUTTAB) type STANDARD TABLE
    exporting
      value(ET_OUTTAB_COMPLETE) type ISHMED_T_DISPLAY_FIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_ADPAT_DATA
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(IT_SELECTION_CRITERIA) type ISHMED_T_RSPARAMS optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_OUTTAB_LINE) type RN1DISPLAY_FIELDS
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_CASE_DATA
    importing
      value(I_FALNR) type FALNR optional
      value(IT_FIELDCAT) type LVC_T_FCAT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_NFAL) type NFAL
    changing
      value(C_OUTTAB_LINE) type RN1DISPLAY_FIELDS
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_CLIM_DATA
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(IT_SELECTION_CRITERIA) type ISHMED_T_RSPARAMS optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_OUTTAB_LINE) type RN1DISPLAY_FIELDS
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_IM_DATA
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(IT_SELECTION_CRITERIA) type ISHMED_T_RSPARAMS optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_OUTTAB_LINE) type RN1DISPLAY_FIELDS
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_DBC_DATA
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(IT_SELECTION_CRITERIA) type ISHMED_T_RSPARAMS optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_OUTTAB_LINE) type RN1DISPLAY_FIELDS
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_KURZ_DATA
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_OUTTAB_LINE) type RN1DISPLAY_FIELDS
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_PATHWAY_DATA
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(IT_SELECTION_CRITERIA) type ISHMED_T_RSPARAMS optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_OUTTAB_LINE) type RN1DISPLAY_FIELDS
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_PATIENT_DATA
    importing
      value(I_PATNR) type PATNR optional
      value(I_PAPID) type ISH_PAPID optional
      value(I_PAP) type ref to CL_ISH_PATIENT_PROVISIONAL optional
      value(I_ANONYM) type ISH_ON_OFF optional
      value(I_DSP_CORD_EXIST) type ISH_ON_OFF default OFF
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      !IR_CORDER type ref to CL_ISH_CORDER optional
      !IR_REQUEST type ref to CL_ISHMED_REQUEST optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_NPAT) type NPAT
      value(E_NPAP) type NPAP
    changing
      value(C_OUTTAB_LINE) type RN1DISPLAY_FIELDS
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_SERVICE_DATA
    importing
      !I_SERVICE type N1SERVICE_OBJECT
      value(I_NLEI) type NLEI optional
      value(I_NLEM) type NLEM optional
      value(I_NODE_CLOSED) type ISH_ON_OFF
      value(I_PLACE_HOLDER) type CHAR1 default '-'
      value(I_ANCHOR) type N1SERVICE_OBJECT optional
      !IT_SERVICES type ISHMED_T_SERVICE_OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_OUTTAB_LINE) type RN1DISPLAY_FIELDS
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_T_ADM_DATA
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(I_CANCELLED_DATA) type ISH_ON_OFF default ABAP_FALSE
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_OUTTAB type ISHMED_T_DISPLAY_FIELDS
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_T_ADPAT_DATA
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CT_OUTTAB) type ISHMED_T_DISPLAY_FIELDS
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_T_CASE_DATA
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_OUTTAB type ISHMED_T_DISPLAY_FIELDS
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_T_CONTEXT_DATA
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(I_NO_SAVE) type ISH_ON_OFF default ABAP_FALSE
      value(I_CANCELLED_DATA) type ISH_ON_OFF default ABAP_FALSE
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_OUTTAB type ISHMED_T_DISPLAY_FIELDS
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_T_PATHWAY_DATA
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(IT_SELECTION_CRITERIA) type ISHMED_T_RSPARAMS optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_OUTTAB type ISHMED_T_DISPLAY_FIELDS
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FINALIZE_OUTTAB
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(I_NO_SAVE) type ISH_ON_OFF default ABAP_FALSE
      value(I_CANCELLED_DATA) type ISH_ON_OFF default ABAP_FALSE
      value(IT_SELECTION_CRITERIA) type ISHMED_T_RSPARAMS optional
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_OUTTAB type ISHMED_T_DISPLAY_FIELDS
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DATA
    importing
      value(IT_OUTTAB) type STANDARD TABLE
      value(IT_OBJECT) type ISH_OBJECTLIST optional
    exporting
      value(ET_OBJECT) type ISH_OBJECTLIST
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DRAG_DROP_FOR_WP
    importing
      value(I_DRAGDROPOBJ) type ref to OBJECT optional
    exporting
      value(E_WP_DRAGDROPOBJ) type ref to CL_ISH_WP_DRAG_DROP_CONTAINER
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_OUTTAB_FOR_ROWID
    importing
      value(IT_OUTTAB) type STANDARD TABLE
      value(I_INDEX) type LVC_INDEX optional
      value(IT_INDEX_ROWS) type LVC_T_ROW optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ET_OUTTAB_LINES) type STANDARD TABLE
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_ROWID_FOR_OBJECT
    importing
      value(IT_OUTTAB) type STANDARD TABLE
      value(IT_OBJECT) type ISH_OBJECTLIST optional
    exporting
      value(ET_INDEX_ROWS) type LVC_T_ROW
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_SEL_OBJECT
    importing
      value(I_DSPCLS) type ref to OBJECT
      value(I_SEL_ATTRIBUTE) type ISH_SEL_OBJECT-ATTRIBUTE default '*'
      value(I_FIELDNAME) type LVC_FNAME default SPACE
      value(IT_OUTTAB) type ISHMED_T_DISPLAY_FIELDS
    exporting
      value(ET_SEL_OBJECT) type ISH_T_SEL_OBJECT .
  class-methods GET_SORT_CRITERIA
    importing
      value(I_SORT) type N1SORTNO
    exporting
      value(ET_SORT) type LVC_T_SORT
      value(ET_SORT_DETAIL) type ISHMED_T_DISPLAY_SORT_DYN
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_WP_ICON
    importing
      value(I_EINRI) type EINRI
      value(I_INDICATOR) type NWICONS-COL_INDICATOR
    exporting
      value(E_ICON) type NWICONS-ICON .
  class-methods GET_WP_ISH_OBJECT
    importing
      value(I_SEL_ATTRIBUTE) type ISH_SEL_OBJECT-ATTRIBUTE default '*'
      value(I_SET_EXTERN_VALUES) type ISH_ON_OFF default SPACE
      value(I_INSTITUTION) type EINRI
      value(I_VIEW_ID) type NWVIEW-VIEWID
      value(I_VIEW_TYPE) type NWVIEW-VIEWTYPE
      value(IT_OBJECT) type ISH_T_SEL_OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ET_ISH_OBJECT) type ISH_T_DRAG_DROP_DATA
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods MERGE_COLUMN
    importing
      value(I_FIELDNAME) type LVC_FNAME
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CT_OUTTAB) type STANDARD TABLE
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods PREPARE_OUTTAB_FOR_SORT
    importing
      value(I_SORT) type N1SORTNO
      value(IT_SORT_DETAIL) type ISHMED_T_DISPLAY_SORT_DYN optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CT_OUTTAB) type STANDARD TABLE optional
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods REFRESH_DATA
    importing
      value(IT_OBJECT) type ISH_OBJECTLIST
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CT_OUTTAB) type STANDARD TABLE
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods REMOVE_DATA
    importing
      value(IT_OBJECT) type ISH_OBJECTLIST
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CT_OUTTAB) type STANDARD TABLE
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods REWORK_FCAT_FOR_SORT
    importing
      !IT_SELECTION_CRITERIA type ISHMED_T_RSPARAMS
    changing
      !CT_FIELDCAT type LVC_T_FCAT .
  class-methods SORT_OUTTAB
    importing
      value(IT_SORT) type LVC_T_SORT optional
      value(IT_SORT_OBJECT) type ISHMED_T_SORT_OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CT_OUTTAB) type STANDARD TABLE optional
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods SORT_SERVICES
    importing
      value(I_SORT_FIELD) type LVC_FNAME default 'SORTLEIST'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CT_SERVICES) type ISHMED_T_SERVICE_OBJECT optional
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DISPLAY_TOOLS
*"* do not include other source files here!!!
private section.

  class-data GS_NPATBUFFER type NPAT .
  class-data GS_NAMEBUFFER type RN1DISPLAY_FIELDS .
*"* private components of class CL_ISH_DISPLAY_TOOLS
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DISPLAY_TOOLS IMPLEMENTATION.


  METHOD clear_buffer.

    FREE gs_npatbuffer.
    FREE gs_namebuffer.

  ENDMETHOD.


METHOD convert_outtab.

* Workareas
  DATA:          l_outtab_complete      LIKE LINE OF et_outtab_complete.
* Datenreferenz
  DATA:          l_work_area            TYPE REF TO data.
* Feldsymbole
  FIELD-SYMBOLS: <l_outtab>             TYPE ANY.
* ---------- ---------- ----------
* Initialisierung
  CLEAR e_rc.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: et_outtab_complete[].
* ---------- ---------- ----------
* Workarea zur Ausgabetabelle definieren.
  CREATE DATA l_work_area LIKE LINE OF it_outtab.
  ASSIGN l_work_area->* TO <l_outtab>.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  LOOP AT it_outtab INTO <l_outtab>.
    MOVE-CORRESPONDING <l_outtab> TO l_outtab_complete.
    INSERT l_outtab_complete INTO TABLE et_outtab_complete.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.


METHOD fill_adpat_data .

* variables
  DATA: lt_outtab_tmp        TYPE ishmed_t_display_fields.

* initialization
  CLEAR: e_rc, lt_outtab_tmp[].

  IF c_errorhandler IS INITIAL AND c_errorhandler IS REQUESTED.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  APPEND c_outtab_line TO lt_outtab_tmp.

* ISHMED allergy documentation                                      6.05
  CALL FUNCTION 'ISH_N2_DP_AD'
    EXPORTING
      i_institution = c_outtab_line-einri
      i_dispvar     = it_fieldcat[]
    CHANGING
      c_view_list   = lt_outtab_tmp.

  READ TABLE lt_outtab_tmp INTO c_outtab_line INDEX 1.

ENDMETHOD.


METHOD fill_case_data .

  TYPES: BEGIN OF ty_doc,
           falnr     TYPE ndoc-falnr,
           lfdbew    TYPE ndoc-lfdbew,
           dtid      TYPE ndoc-dtid,
           dtvers    TYPE ndoc-dtvers,
           medok     TYPE ndoc-medok,
         END OF ty_doc.

* Hilfsfelder und -strukturen
  DATA: l_date             TYPE sy-datum,
        l_time             TYPE sy-uzeit,
        l_rc               TYPE ish_method_rc,
        l_icon             TYPE nwicon,
        l_dsp_akt          TYPE ish_on_off,
        l_dsp_dok          TYPE ish_on_off,
        l_dsp_dok_art      TYPE ish_on_off,
        l_tnkla            TYPE tnkla,
        lt_nfal            TYPE STANDARD TABLE OF nfal,
        l_nfal             TYPE nfal,
        lt_nfkl            TYPE STANDARD TABLE OF nfkl,
        l_akt_bew          TYPE nbew,
        ls_nbau            TYPE nbau,
        lt_doc             TYPE TABLE OF ty_doc,
        l_doc              LIKE LINE OF lt_doc,
        lr_medok           TYPE RANGE OF ndoc-medok,
        l_medok            LIKE LINE OF lr_medok.

  FIELD-SYMBOLS: <ls_fieldcat>  LIKE LINE OF it_fieldcat.

* Initialisierung
  CLEAR: e_rc, e_nfal.
  CLEAR: l_nfal, l_tnkla.
  REFRESH: lt_nfal, lt_nfkl.

  IF c_errorhandler IS INITIAL AND c_errorhandler IS REQUESTED.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Anzuzeigende Daten anhand des Feldkatalogs bestimmen
  CLEAR: l_dsp_akt, l_dsp_dok, l_dsp_dok_art.
  LOOP AT it_fieldcat ASSIGNING <ls_fieldcat> WHERE no_out = off.
    CASE <ls_fieldcat>-fieldname.
      WHEN 'DOKKZ_ICON'.
        l_dsp_dok = on.
      WHEN 'MEDDOK_ICON' OR 'LABDOK_ICON'.
        l_dsp_dok     = on.
        l_dsp_dok_art = on.
      WHEN 'ORGPF_AKT' OR 'ROOM_AKT' OR 'ROOM_AKT_KB'.
        l_dsp_akt = on.
    ENDCASE.
  ENDLOOP.

* Falldaten
  IF NOT i_falnr IS INITIAL.
*   Fallbezogenes Objekt
    c_outtab_line-falnr = i_falnr.
    CALL FUNCTION 'ISH_REFRESH_NFAL'.             " MED-8787 (ID 18539)
*   Fall lesen
    CALL FUNCTION 'ISH_READ_NFAL'
      EXPORTING
        ss_einri           = c_outtab_line-einri
        ss_falnr           = c_outtab_line-falnr
        ss_message_no_auth = off                            " BA 2011
*       ss_read_db         = on                             " ID 18539
      IMPORTING
        ss_nfal            = l_nfal
      EXCEPTIONS
        not_found          = 1
        not_found_archived = 2
        no_authority       = 3
        OTHERS             = 4.
    IF sy-subrc = 0.
      e_nfal = l_nfal.
      APPEND l_nfal TO lt_nfal.
*     Patientennummer unbedingt auch aus dem Fall befüllen
      c_outtab_line-patnr = l_nfal-patnr.
*     Fallart intern
      c_outtab_line-falar = l_nfal-falar.
*     Fallart extern
      CALL FUNCTION 'ISH_CONVERT_CASETYPE_OUTPUT'
        EXPORTING
          ss_einri = c_outtab_line-einri
          ss_falai = c_outtab_line-falar
        IMPORTING
          ss_falae = c_outtab_line-falare
        EXCEPTIONS
          OTHERS   = 0.
    ENDIF.
  ENDIF.

* Privatpatient-Kennzeichen (auch für fallfreie Objekte ermitteln!)
  l_tnkla-klfart_int = '10'.
  IF NOT c_outtab_line-falnr IS INITIAL.
    CALL FUNCTION 'ISHMED_GET_PRIVATPATIENT_DATA'
      EXPORTING
        i_tnkla = l_tnkla
      TABLES
        t_nfal  = lt_nfal
        t_nfkl  = lt_nfkl.
  ENDIF.
  IF NOT c_outtab_line-date IS INITIAL.
    l_date = c_outtab_line-date.
  ELSE.
    l_date = sy-datum.
  ENDIF.
*  IF NOT c_outtab_line-date IS INITIAL.    "REM MED-33432
  IF NOT c_outtab_line-time IS INITIAL.                     "MED-33432
    l_time = c_outtab_line-time.
  ELSE.
    l_time = sy-uzeit.
  ENDIF.
  CALL FUNCTION 'ISHMED_CHECK_PRIVATPATIENT'
    EXPORTING
      i_einri  = c_outtab_line-einri
      i_falnr  = c_outtab_line-falnr
      i_date   = l_date
      i_time   = l_time
      i_object = c_outtab_line-object
    IMPORTING
      e_privkz = c_outtab_line-privp
    TABLES
      t_nfkl   = lt_nfkl.
*    CHANGING
*      c_bekat  = l_bekat.
  IF c_outtab_line-privp = on.
    CALL METHOD cl_ish_display_tools=>get_wp_icon
      EXPORTING
        i_einri     = c_outtab_line-einri
        i_indicator = '022'
      IMPORTING
        e_icon      = l_icon.
    c_outtab_line-privp_icon = l_icon.
  ENDIF.

* Aktuelle Pfleg. OE / Zimmer des Patienten ermitteln
  IF l_dsp_akt = on AND NOT c_outtab_line-falnr IS INITIAL
                    AND     c_outtab_line-falar <> '2'.     " ID 19633
    CLEAR l_akt_bew.
    CALL FUNCTION 'ISHMED_SEARCH_ORGFA'
      EXPORTING
        i_falnr       = c_outtab_line-falnr
        i_einri       = c_outtab_line-einri
        i_datum       = sy-datum                            "MED-44001
        i_zeit        = sy-uzeit                            "MED-44001
        i_nfal        = l_nfal
        i_no_planb    = 'X'                                 "MED-44001
      IMPORTING
        e_nbew        = l_akt_bew
      EXCEPTIONS
        no_valid_nfal = 1
        no_valid_nbew = 2
        OTHERS        = 3.
    IF sy-subrc = 0.
      c_outtab_line-orgpf_akt = l_akt_bew-orgpf.
      IF NOT l_akt_bew-zimmr IS INITIAL.
        CALL METHOD cl_ish_dbr_bau=>get_bau_by_bauid
          EXPORTING
            i_bauid = l_akt_bew-zimmr
          IMPORTING
            es_nbau = ls_nbau
            e_rc    = l_rc.
        IF l_rc <> 0.
          CLEAR: c_outtab_line-room_akt, c_outtab_line-room_akt_kb.
        ELSE.
          c_outtab_line-room_akt    = ls_nbau-bkurz.
          c_outtab_line-room_akt_kb = ls_nbau-baukb.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.      " Aktuelle Pfleg. OE / Zimmer des Patienten ermitteln

* Dokumente vorhanden
  IF l_dsp_dok = on AND NOT c_outtab_line-falnr IS INITIAL.
*   Rangetab der Dokarten befüllen
    CLEAR l_medok.  REFRESH lr_medok.
    l_medok-sign   = 'I'.
    l_medok-option = 'EQ'.
    l_medok-low    = 'X'.                " Medizinische Dokumente
    APPEND l_medok TO lr_medok.          " UND
    l_medok-low    = 'L'.                " Laborbefunde
    APPEND l_medok TO lr_medok.
*   Dokumente selektieren
    REFRESH lt_doc.
    SELECT falnr lfdbew dtid dtvers medok
           FROM ndoc INTO TABLE lt_doc
           WHERE einri EQ c_outtab_line-einri
             AND falnr EQ c_outtab_line-falnr
             AND storn EQ off
             AND loekz EQ off
             AND medok IN lr_medok.
    DESCRIBE TABLE lt_doc.
    IF sy-tfill > 0.
      LOOP AT lt_doc INTO l_doc WHERE falnr  = c_outtab_line-falnr.
*                                  AND lfdbew = c_outtab_line-lfdbew.  " REM MED-40956
*       Dokument(e) zum Fall bzw. zur Bewegung vorhanden
        CALL METHOD cl_ish_display_tools=>get_wp_icon
          EXPORTING
            i_einri     = c_outtab_line-einri
            i_indicator = '002'             " Dokument(e) vorhanden
          IMPORTING
            e_icon      = l_icon.
        c_outtab_line-dokkz_icon = l_icon.
        EXIT.
      ENDLOOP.
*     Auch auf Vorhandensein von Med. Dok. oder Labordok. prüfen
      IF l_dsp_dok_art = on.
        LOOP AT lt_doc INTO l_doc WHERE falnr  = c_outtab_line-falnr.
*                                    AND lfdbew = c_outtab_line-lfdbew.  " REM MED-40956
          IF NOT c_outtab_line-meddok_icon IS INITIAL AND
             NOT c_outtab_line-labdok_icon IS INITIAL.
            EXIT.
          ENDIF.
          CASE l_doc-medok.
            WHEN 'X'.
*             Med. Dokument(e) zum Fall bzw. zur Bewegung vorhanden
              CALL METHOD cl_ish_display_tools=>get_wp_icon
                EXPORTING
                  i_einri     = c_outtab_line-einri
                  i_indicator = '078'    " Med.Dokument(e) vorhanden
                IMPORTING
                  e_icon      = l_icon.
              c_outtab_line-meddok_icon = l_icon.
            WHEN 'L'.
*             Labordokument(e) zum Fall bzw. zur Bewegung vorhanden
              CALL METHOD cl_ish_display_tools=>get_wp_icon
                EXPORTING
                  i_einri     = c_outtab_line-einri
                  i_indicator = '079'    " Lab.Dokument(e) vorhanden
                IMPORTING
                  e_icon      = l_icon.
              c_outtab_line-labdok_icon = l_icon.
          ENDCASE.
        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDIF.      " Dokumente vorhanden

ENDMETHOD.


METHOD fill_clim_data .

* variables
  DATA: lt_outtab_tmp        TYPE ishmed_t_display_fields.

* initialization
  CLEAR: e_rc, lt_outtab_tmp[].

  IF c_errorhandler IS INITIAL AND c_errorhandler IS REQUESTED.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  APPEND c_outtab_line TO lt_outtab_tmp.

* ISHMED allergy documentation                                      6.05
  CALL FUNCTION 'ISH_N2_DP_CLIM'
    EXPORTING
      i_institution = c_outtab_line-einri
      i_dispvar     = it_fieldcat[]
    CHANGING
      c_view_list   = lt_outtab_tmp.

  READ TABLE lt_outtab_tmp INTO c_outtab_line INDEX 1.

ENDMETHOD.


METHOD fill_dbc_data .

* variables
  DATA: lt_outtab_tmp        TYPE ishmed_t_display_fields.

* initialization
  CLEAR: e_rc, lt_outtab_tmp[].

  IF c_errorhandler IS INITIAL AND c_errorhandler IS REQUESTED.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  APPEND c_outtab_line TO lt_outtab_tmp.

* IS-H NL - DBC for cases                                           6.01
  CALL FUNCTION 'ISH_NL_DP_DBC'
    EXPORTING
      i_institution = c_outtab_line-einri
      i_dispvar     = it_fieldcat[]
    CHANGING
      c_view_list   = lt_outtab_tmp.

  READ TABLE lt_outtab_tmp INTO c_outtab_line INDEX 1.

ENDMETHOD.


METHOD FILL_IM_DATA .

* variables
  DATA: lt_outtab_tmp        TYPE ishmed_t_display_fields.

* initialization
  CLEAR: e_rc, lt_outtab_tmp[].

  IF c_errorhandler IS INITIAL AND c_errorhandler IS REQUESTED.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  APPEND c_outtab_line TO lt_outtab_tmp.

* ISHMED Bildstudie                                                 6.06
  CALL FUNCTION 'ISH_N1_DP_IM'
    EXPORTING
      i_institution = c_outtab_line-einri
      i_dispvar     = it_fieldcat[]
    CHANGING
      c_view_list   = lt_outtab_tmp.

  READ TABLE lt_outtab_tmp INTO c_outtab_line INDEX 1.

ENDMETHOD.


METHOD fill_kurz_data .

* Hilfsfelder und -strukturen
  DATA: l_dsp_room_k       TYPE ish_on_off,
        l_dsp_planoe_k     TYPE ish_on_off.
  DATA: l_dsp_room_kb      TYPE ish_on_off,
        l_dsp_planoe_kb    TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_fieldcat>  LIKE LINE OF it_fieldcat.

* Initialisierung
  CLEAR: e_rc.

  IF c_errorhandler IS INITIAL AND c_errorhandler IS REQUESTED.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Anzuzeigende Daten anhand des Feldkatalogs bestimmen
  CLEAR: l_dsp_room_k,  l_dsp_planoe_k,
         l_dsp_room_kb, l_dsp_planoe_kb.
  LOOP AT it_fieldcat ASSIGNING <ls_fieldcat> WHERE no_out = off.
    CASE <ls_fieldcat>-fieldname.
      WHEN 'ROOM_K'.
        l_dsp_room_k = on.
      WHEN 'PLANOE_K'.
        l_dsp_planoe_k = on.
      WHEN 'ROOM_KB'.
        l_dsp_room_kb = on.
      WHEN 'PLANOE_KB'.
        l_dsp_planoe_kb = on.
    ENDCASE.
  ENDLOOP.

* short key (Kürzel) and short description (Kurzbezeichnung) for room
  IF ( l_dsp_room_k = on OR l_dsp_room_kb = on ) AND
     c_outtab_line-room IS NOT INITIAL.
    CALL METHOD cl_ish_utl_base_descr=>get_descr_room
      EXPORTING
        i_bauid = c_outtab_line-room
      IMPORTING
        e_baukb = c_outtab_line-room_kb
        e_bkurz = c_outtab_line-room_k.
  ENDIF.

* short key (Kürzel) and short description (Kurzbezeichnung) for plan OU
  IF ( l_dsp_planoe_k = on OR l_dsp_planoe_kb = on ) AND
     c_outtab_line-planoe IS NOT INITIAL.
    CALL METHOD cl_ish_utl_base_descr=>get_descr_orgunit
      EXPORTING
        i_einri = c_outtab_line-einri
        i_orgid = c_outtab_line-planoe
      IMPORTING
        e_orgkb = c_outtab_line-planoe_kb
        e_okurz = c_outtab_line-planoe_k.
  ENDIF.

ENDMETHOD.


METHOD fill_pathway_data .

* variables
  DATA: l_guideline_act      TYPE ish_on_off,
        lt_outtab_tmp        TYPE ishmed_t_display_fields.

* initialization
  CLEAR: e_rc, l_guideline_act, lt_outtab_tmp[].

  IF c_errorhandler IS INITIAL AND c_errorhandler IS REQUESTED.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* pathway active?
  CLEAR l_guideline_act.
  CALL METHOD cl_ishmed_fct_guideline=>is_in_use
    EXPORTING
      i_institution = c_outtab_line-einri
    RECEIVING
      r_use         = l_guideline_act.

  CHECK l_guideline_act = on.

  APPEND c_outtab_line TO lt_outtab_tmp.

* get patient pathway data
  CALL FUNCTION 'ISH_N2_GL_DP_PATIENT_PATHWAY'
    EXPORTING
      i_institution        = c_outtab_line-einri
      i_dispvar            = it_fieldcat[]
    TABLES
      i_selection_criteria = it_selection_criteria[]
    CHANGING
      c_view_list          = lt_outtab_tmp.

  READ TABLE lt_outtab_tmp INTO c_outtab_line INDEX 1.

ENDMETHOD.


METHOD fill_patient_data .

* Hilfsfelder und -strukturen
  DATA: l_rc               TYPE ish_method_rc,
        l_icon             TYPE nwicons-icon,
        l_dsp_anfv         TYPE ish_on_off,
        l_nrsf             TYPE nrsf,                       "#EC NEEDED
        l_npat             TYPE npat,
        l_npap             TYPE npap,
        l_rnpap_key        TYPE rnpap_key,
        l_rnpap_attrib     TYPE rnpap_attrib,
        l_tn18t            TYPE tn18t,
        l_n1anf_tmp        TYPE n1anf,                      "#EC NEEDED
        l_n1corder_tmp     TYPE n1corder,                   "#EC NEEDED
        l_exist            TYPE ish_on_off,
        l_active(1)        TYPE c,
        l_tn00q            TYPE tn00q.

  FIELD-SYMBOLS: <ls_fieldcat>  LIKE LINE OF it_fieldcat.

* Initialisierung
  CLEAR: e_rc, e_npat, e_npap.
  CLEAR: l_rc, l_npat, l_npap, l_rnpap_key, l_rnpap_attrib.

  IF c_errorhandler IS INITIAL AND c_errorhandler IS REQUESTED.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Anzuzeigende Daten anhand des Feldkatalogs bestimmen  * * * * * * *
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  CLEAR: l_dsp_anfv.
  LOOP AT it_fieldcat ASSIGNING <ls_fieldcat> WHERE no_out = off.
    CASE <ls_fieldcat>-fieldname.
      WHEN 'ANFV_ICON'.
        l_dsp_anfv = on.
        IF i_dsp_cord_exist = off.
          l_dsp_anfv = off.
        ENDIF.
    ENDCASE.
  ENDLOOP.

* Patientendaten
  IF NOT i_patnr IS INITIAL.
*   Echter Patient ----------------------------------------------------
    c_outtab_line-patnr = i_patnr.
*   Use NPAT buffer, if available                     " MED-61845 Note 2305161 Bi
    IF i_patnr EQ gs_npatbuffer-patnr.                " MED-61845 Note 2305161 Bi
      l_npat = gs_npatbuffer.                         " MED-61845 Note 2305161 Bi
      l_rc   = 0.                                     " MED-61845 Note 2305161 Bi
    ELSE.                                             " MED-61845 Note 2305161 Bi
      CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
      EXPORTING
        i_patnr         = c_outtab_line-patnr
      IMPORTING
        e_rc            = l_rc
        es_npat         = l_npat
      CHANGING
        cr_errorhandler = c_errorhandler.
*     Write to buffer                                 " MED-61845 Note 2305161 Bi
      gs_npatbuffer = l_npat.                         " MED-61845 Note 2305161 Bi
    ENDIF.                                            " MED-61845 Note 2305161 Bi
    IF l_rc = 0.
*     Patientenname
      IF i_anonym = off.
        c_outtab_line-nnams = l_npat-nnams.
        c_outtab_line-vnams = l_npat-vnams.
        c_outtab_line-gbnam = l_npat-gbnam.
      ELSE.
        c_outtab_line-nnams   = 'N.N.'(001).
        c_outtab_line-vnams   = 'N.N.'(001).
        c_outtab_line-gbnam   = 'N.N.'(001).
      ENDIF.
*     Geschlecht
      CALL FUNCTION 'ISH_CONVERT_SEX_OUTPUT'
        EXPORTING
          ss_gschl  = l_npat-gschl
        IMPORTING
          ss_gschle = c_outtab_line-gschle
        EXCEPTIONS
          OTHERS    = 0.
*     Geburtsdatum
      c_outtab_line-gbdat = l_npat-gbdat.
*     Risikoinformationen vorhanden?
*      Begin MED-50961
      "Due to buffering of the patientrecord in this function the updated riskf fieldvalue is not detected,
      "so the table nrsf has to be read
*     START MED-40483 2010/06/21
*     riskfactor is in npat so it is not necessary to read nrsf
*        IF l_npat-riskf = abap_true.
*          c_outtab_line-risiko = on.
*          CALL METHOD cl_ish_display_tools=>get_wp_icon
*            EXPORTING
*              i_einri     = c_outtab_line-einri
*              i_indicator = '006'
*            IMPORTING
*              e_icon      = l_icon.
*          c_outtab_line-risiko_icon = l_icon.
*        ENDIF.
*      End MED-50961
*      -->Begin MED-50961, CJ 02.07.2013
        SELECT * FROM nrsf INTO l_nrsf UP TO 1 ROWS
               WHERE  patnr  = c_outtab_line-patnr
               AND    loekz  = off.
          EXIT.
        ENDSELECT.
        IF sy-subrc = 0.
          c_outtab_line-risiko = on.
          CALL METHOD cl_ish_display_tools=>get_wp_icon
            EXPORTING
              i_einri     = c_outtab_line-einri
              i_indicator = '006'
            IMPORTING
              e_icon      = l_icon.
          c_outtab_line-risiko_icon = l_icon.
        ENDIF.
*     END MED-40483
*        <--End MED-50961, CJ 02.07.2013
*     Todesdaten                                              ID 12038
      IF l_npat-todkz = on.
        CALL METHOD cl_ish_display_tools=>get_wp_icon
          EXPORTING
            i_einri     = c_outtab_line-einri
            i_indicator = '090'
          IMPORTING
            e_icon      = l_icon.
        c_outtab_line-todkz_icon = l_icon.
        c_outtab_line-toddt = l_npat-toddt.
        c_outtab_line-todzt = l_npat-todzt.
        c_outtab_line-toddb = l_npat-toddb.
        c_outtab_line-todzb = l_npat-todzb.
        CLEAR l_tn18t.
        CALL FUNCTION 'ISH_READ_TNTEXT_TABLES'
          EXPORTING
            einri       = c_outtab_line-einri
            read_db     = off
            read_tn18t  = on
            tn18t_todur = l_npat-todur
          IMPORTING
            o_tn18t     = l_tn18t
          EXCEPTIONS
            OTHERS      = 0.
        c_outtab_line-todur_txt  = l_tn18t-tutxt.
      ENDIF.
    ELSE.
      c_outtab_line-nnams   = 'N.N.'(001).
      c_outtab_line-vnams   = 'N.N.'(001).
      c_outtab_line-pnamec  = 'N.N.'(001).
      c_outtab_line-pnamec1 = 'N.N.'(001).
      EXIT.
    ENDIF.
    e_npat = l_npat.
  ELSEIF NOT i_pap IS INITIAL.
*   Vorläufiger Patient -----------------------------------------------
    CALL METHOD i_pap->get_data
*      EXPORTING                           " Fichte, Nr 9249
*        i_authority_check = ' '           " Fichte, Nr 9249
      IMPORTING
        es_key            = l_rnpap_key
        es_data           = l_rnpap_attrib
        e_rc              = l_rc
      CHANGING
        c_errorhandler    = c_errorhandler.
    IF l_rc = 0.
      IF i_anonym = off.
        c_outtab_line-nnams  = l_rnpap_attrib-nname.
        c_outtab_line-vnams  = l_rnpap_attrib-vname.
        c_outtab_line-gbnam  = l_rnpap_attrib-gbnam.
      ELSE.
        c_outtab_line-nnams  = 'N.N.'(001).
        c_outtab_line-vnams  = 'N.N.'(001).
        c_outtab_line-gbnam  = 'N.N.'(001).
      ENDIF.
*     Geschlecht
      c_outtab_line-gschle  = l_rnpap_attrib-gschle.
*     Geburtsdatum
      c_outtab_line-gbdat   = l_rnpap_attrib-gbdat.
    ELSE.
      c_outtab_line-nnams   = 'N.N.'(001).
      c_outtab_line-vnams   = 'N.N.'(001).
      c_outtab_line-pnamec  = 'N.N.'(001).
      c_outtab_line-pnamec1 = 'N.N.'(001).
      EXIT.
    ENDIF.
    MOVE-CORRESPONDING l_rnpap_key    TO l_npap.            "#EC ENHOK
    MOVE-CORRESPONDING l_rnpap_attrib TO l_npap.            "#EC ENHOK
    CALL FUNCTION 'ISH_CONVERT_SEX_INPUT'
      EXPORTING
        ss_gschle = l_rnpap_attrib-gschle
      IMPORTING
        ss_gschl  = l_npap-gschl
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.
    IF sy-subrc <> 0.
      CLEAR l_npap-gschl.
    ENDIF.
    e_npap = l_npap.
  ELSEIF NOT i_papid IS INITIAL.
*   Vorläufiger Patient -----------------------------------------------
    CALL METHOD cl_ish_dbr_pap=>get_pap_by_papid
      EXPORTING
        i_papid         = i_papid
      IMPORTING
        es_npap         = l_npap
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
    IF l_rc = 0.
*     Patientenname
      IF i_anonym = off.
        c_outtab_line-nnams = l_npap-nnams.
        c_outtab_line-vnams = l_npap-vnams.
        c_outtab_line-gbnam = l_npap-gbnam.
      ELSE.
        c_outtab_line-nnams   = 'N.N.'(001).
        c_outtab_line-vnams   = 'N.N.'(001).
        c_outtab_line-gbnam   = 'N.N.'(001).
      ENDIF.
*     Geschlecht
      CALL FUNCTION 'ISH_CONVERT_SEX_OUTPUT'
        EXPORTING
          ss_gschl  = l_npap-gschl
        IMPORTING
          ss_gschle = c_outtab_line-gschle
        EXCEPTIONS
          OTHERS    = 0.
*     Geburtsdatum
      c_outtab_line-gbdat = l_npap-gbdat.
    ELSE.
      c_outtab_line-nnams   = 'N.N.'(001).
      c_outtab_line-vnams   = 'N.N.'(001).
      c_outtab_line-pnamec  = 'N.N.'(001).
      c_outtab_line-pnamec1 = 'N.N.'(001).
      EXIT.
    ENDIF.
    e_npap = l_npap.
  ELSE.
    c_outtab_line-nnams   = 'N.N.'(001).
    c_outtab_line-vnams   = 'N.N.'(001).
    c_outtab_line-pnamec  = 'N.N.'(001).
    c_outtab_line-pnamec1 = 'N.N.'(001).
    EXIT.
  ENDIF.

* Felder für Patienten und vorläufige Patienten befüllen -------------

* Patientenname und Patientenname inkl. Alter und Geschlecht
  IF i_anonym = off.
*   Use buffer for name, if available                 " MED-61845 Note 2305161 Bi
    IF NOT l_npat-patnr IS INITIAL AND                " MED-62651 note 2350157 BM
      NOT gs_namebuffer-patnr IS INITIAL AND          " MED-62651 note 2350157 BM
      l_npat-patnr EQ gs_namebuffer-patnr AND         " MED-61845 Note 2305161 Bi
      l_npap-papid IS INITIAL.                        " MED-61845 Note 2305161 Bi
      c_outtab_line-pnamec  = gs_namebuffer-pnamec.   " MED-61845 Note 2305161 Bi
      c_outtab_line-pnamec1 = gs_namebuffer-pnamec1.  " MED-61845 Note 2305161 Bi
      c_outtab_line-agepat  = gs_namebuffer-agepat.   " MED-61845 Note 2305161 Bi
    ELSE.                                             " MED-61845 Note 2305161 Bi
      CALL METHOD cl_ish_utl_base_patient=>get_name_patient
      EXPORTING
        i_patnr        = l_npat-patnr
        i_papid        = l_npap-papid
        i_list         = on
        is_npat        = l_npat
        is_npap        = l_npap
      IMPORTING
        e_pname        = c_outtab_line-pnamec
        e_pname_agesex = c_outtab_line-pnamec1
        e_age          = c_outtab_line-agepat.
*     Write to buffer                                 " MED-61845 Note 2305161 Bi
      gs_namebuffer       = c_outtab_line.            " MED-61845 Note 2305161 Bi
      gs_namebuffer-patnr = l_npat-patnr.             " MED-61845 Note 2305161 Bi
      ENDIF.                                          " MED-61845 Note 2305161 Bi
  ELSE.
    c_outtab_line-pnamec  = 'N.N.'(001).
    c_outtab_line-pnamec1 = 'N.N.'(001).
  ENDIF.

* Klinische Aufträge und/oder Anforderungen vorhanden
  IF l_dsp_anfv = on.
*   get parameter if requests and/or clinical orders are active
    CLEAR: l_active, l_exist.
*   START MED-40483
    IF ir_corder IS BOUND OR ir_request IS BOUND.
      l_exist = abap_true.
    ELSE.
*   END MED-40483
      PERFORM ren00q IN PROGRAM sapmnpa0 USING c_outtab_line-einri
                                               'N1CORDER'
                                               l_tn00q-value.
      MOVE l_tn00q-value(1) TO l_active.
*     select clinical orders
      IF l_active IS INITIAL OR l_active = 'O'.
        IF NOT c_outtab_line-patnr IS INITIAL.
          SELECT * FROM n1corder INTO l_n1corder_tmp UP TO 1 ROWS
                 WHERE  patnr  = c_outtab_line-patnr
                 AND    storn  = off.
            EXIT.
          ENDSELECT.
          IF sy-subrc = 0.
            l_exist = on.
          ENDIF.
        ELSEIF NOT l_npap-papid IS INITIAL.
          SELECT * FROM n1corder INTO l_n1corder_tmp UP TO 1 ROWS
                 WHERE  papid  = l_npap-papid
                 AND    storn  = off.
            EXIT.
          ENDSELECT.
          IF sy-subrc = 0.
            l_exist = on.
          ENDIF.
        ENDIF.
      ENDIF. "IF l_active IS INITIAL OR l_active = 'O'.
      IF l_exist = off.
*       select requests
        IF l_active IS INITIAL OR l_active = 'R'.
          IF NOT c_outtab_line-patnr IS INITIAL.
            SELECT * FROM n1anf INTO l_n1anf_tmp UP TO 1 ROWS
                   WHERE  einri  = c_outtab_line-einri
                   AND    storn  = off
                   AND    patnr  = c_outtab_line-patnr.
              EXIT.
            ENDSELECT.
            IF sy-subrc = 0.
              l_exist = on.
            ENDIF.
          ENDIF.
        ENDIF. "IF l_active IS INITIAL OR l_active = 'R'.
      ENDIF."IF l_exist = off.
    ENDIF."IF ir_corder IS BOUND OR ir_request IS BOUND.
    IF l_exist = on.
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = c_outtab_line-einri
          i_indicator = '001'   " Kl.Auftrag/Anforderung vorhanden
        IMPORTING
          e_icon      = l_icon.
      c_outtab_line-anfv_icon = l_icon.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD fill_service_data .

  TYPES: BEGIN OF ty_txt,
           lnrls           TYPE lnrls,
           txt             TYPE ish_conc_ktxt,
           len             TYPE i,
           len_fix         TYPE i,
         END OF ty_txt.

* Hilfsfelder und -strukturen
  DATA: l_green            TYPE ish_on_off,
        l_red              TYPE ish_on_off,
        l_icon             TYPE nwicons-icon,
        l_srv_cnt          TYPE i,
        l_rc               TYPE ish_method_rc,
        l_filled           TYPE ish_on_off,
        l_lgrbez           TYPE n1lagrgt-lgrbez,
        l_ifg              TYPE n1ifg-ifg,
        l_ifge             TYPE n1ifg-ifge,
        l_ifgicon          TYPE n1ifg-icon,
        l_ifgtxt           TYPE n1ifgt-ifgtxt,
        l_nlei             TYPE nlei,
        l_nlem             TYPE nlem,
        l_nlei_tmp         TYPE nlei,
        l_nlem_tmp         TYPE nlem,
*        l_srv_ktxt1        TYPE ntpt-ktxt1,
        l_srv_ktxtconc     TYPE ish_conc_ktxt,              " MED-33838
        l_srv_ktxtconc_tmp TYPE ish_conc_ktxt,              " MED-33838
        l_txtlen           TYPE i,                          " MED-33838
        l_txtlen_tmp       TYPE i,                          " MED-33838
        l_txtlen_act       TYPE i,                          " MED-33838
        l_txtlen_sum       TYPE i,                          " MED-33838
        l_txtlen_rest      TYPE i,                          " MED-33838
        l_len_fix          TYPE i,                          " MED-33838
        l_len_fix_old      TYPE i,                          " MED-33838
        ls_txt             TYPE ty_txt,                     " MED-33838
        lt_txt             TYPE TABLE OF ty_txt,            " MED-33838
        l_first_do         TYPE ish_on_off,                 " MED-33838
        l_service          LIKE LINE OF it_services.

* Initialisierung
  CLEAR: e_rc.

  IF c_errorhandler IS INITIAL AND c_errorhandler IS REQUESTED.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Leistungsdaten
  CHECK NOT i_service IS INITIAL.

  IF i_nlei IS INITIAL OR i_nlem IS INITIAL.
    CALL METHOD i_service->get_data
      IMPORTING
        e_rc           = e_rc
        e_nlei         = l_nlei
        e_nlem         = l_nlem
      CHANGING
        c_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ELSE.
    l_nlei = i_nlei.
    l_nlem = i_nlem.
  ENDIF.

* Wieviele Leistungen hat das Anzeigeobjekt insgesamt?
* Denn falls es mehr als 1 Leistung hat, dann muß bei der
* einzeiligen Darstellung bei nicht vorhandenen Werten ein
* Platzhalter angezeigt werden, damit jede Leistung
* korrekt mit der dazugehörigen Lokalisation, Lagerungsart,
* ergänzendem Text, usw. ersichtlich ist
  DESCRIBE TABLE it_services.
  l_srv_cnt = sy-tfill.

* Leistungsobjekt
  IF i_node_closed = off OR c_outtab_line-srvobj IS INITIAL.
    c_outtab_line-srvobj = i_service.
  ENDIF.

* Leistungscode
  IF l_nlei-leist  IS INITIAL AND l_srv_cnt      > 1  AND
     i_node_closed  = on      AND NOT NOT i_place_holder IS INITIAL.
    l_nlei-leist = i_place_holder.
  ENDIF.
  IF i_node_closed = off OR c_outtab_line-srv IS INITIAL.
    c_outtab_line-srv = l_nlei-leist.
  ELSE.
    CONCATENATE c_outtab_line-srv l_nlei-leist
                INTO c_outtab_line-srv SEPARATED BY ', '.
  ENDIF.

* MED-33838: DELETE
** Leistungstext ...
*    IF l_nlei-leitx <> space.
**     ... aus der Leistung (wenn befüllt)
*      l_srv_ktxt1 = l_nlei-leitx.
*    ELSE.
**     ... aus den Stammdaten
*      CALL FUNCTION 'ISHMED_READ_NTPT'
*        EXPORTING
*          i_einri = c_outtab_line-einri
*          i_talst = l_nlei-leist
*          i_tarif = l_nlei-haust
*        IMPORTING
*          e_ktxt1 = l_srv_ktxt1.
*    ENDIF.
*    IF l_srv_ktxt1   IS INITIAL AND l_srv_cnt      > 1  AND
*      i_node_closed  = on       AND NOT i_place_holder IS INITIAL.
*      l_srv_ktxt1 = i_place_holder.
*    ENDIF.
*    IF i_node_closed = off OR c_outtab_line-srv_bez IS INITIAL.
*      c_outtab_line-srv_bez = l_srv_ktxt1.
*    ELSE.
*      CONCATENATE c_outtab_line-srv_bez l_srv_ktxt1
*                  INTO c_outtab_line-srv_bez SEPARATED BY ', '.
*    ENDIF.

* MED-33838: INSERT
* Leistungstext ...
  CLEAR l_srv_ktxtconc.
  IF l_srv_cnt = 1 OR i_node_closed = off.
*   only 1 service or node is open (no concatenate necessary)
    IF l_nlei-leitx <> space.
*     ... aus der Leistung (wenn befüllt)
      l_srv_ktxtconc = l_nlei-leitx.
    ELSE.
*     ... aus den Stammdaten
      CALL FUNCTION 'ISHMED_READ_NTPT'
        EXPORTING
          i_einri    = c_outtab_line-einri
          i_talst    = l_nlei-leist
          i_tarif    = l_nlei-haust
        IMPORTING
          e_ktxtconc = l_srv_ktxtconc.
    ENDIF.
    c_outtab_line-srv_bez = l_srv_ktxtconc.
  ELSE.
*   if there are more than 1 services,
*   we have to check the length of all service texts
*   for the concatenate (just a length of 120 is available)
    IF l_nlei-leitx <> space.
*     ... aus der Leistung (wenn befüllt)
      l_srv_ktxtconc = l_nlei-leitx.
    ELSE.
*     ... aus den Stammdaten
      CALL FUNCTION 'ISHMED_READ_NTPT'
        EXPORTING
          i_einri    = c_outtab_line-einri
          i_talst    = l_nlei-leist
          i_tarif    = l_nlei-haust
        IMPORTING
          e_ktxtconc = l_srv_ktxtconc.
    ENDIF.
    IF l_srv_ktxtconc IS INITIAL AND l_srv_cnt      > 1  AND
       i_node_closed  = on       AND i_place_holder IS NOT INITIAL.
      l_srv_ktxtconc = i_place_holder.
    ELSE.
      l_txtlen = strlen( c_outtab_line-srv_bez ).
*     no more cutting necessary if summary field contains already 120
      IF l_txtlen < 120.
        l_txtlen_act = strlen( l_srv_ktxtconc ).
        IF l_txtlen_act > 40.
*         this is a very long text, so maybe we have to cut it off
          CLEAR: lt_txt, l_txtlen_sum.
*         first get a table with text lengths for all services
          LOOP AT it_services INTO l_service.
            CLEAR l_srv_ktxtconc_tmp.
            CALL METHOD l_service->get_data
              IMPORTING
                e_rc           = l_rc
                e_nlei         = l_nlei_tmp
              CHANGING
                c_errorhandler = c_errorhandler.
            CHECK l_rc = 0.
            IF l_nlei_tmp-leitx <> space.
              l_srv_ktxtconc_tmp = l_nlei_tmp-leitx.
            ELSE.
              CALL FUNCTION 'ISHMED_READ_NTPT'
                EXPORTING
                  i_einri    = c_outtab_line-einri
                  i_talst    = l_nlei_tmp-leist
                  i_tarif    = l_nlei_tmp-haust
                IMPORTING
                  e_ktxtconc = l_srv_ktxtconc_tmp.
            ENDIF.
            IF l_srv_ktxtconc_tmp IS INITIAL AND
               i_place_holder     IS NOT INITIAL.
              l_srv_ktxtconc_tmp = i_place_holder.
            ENDIF.
            CHECK l_srv_ktxtconc_tmp IS NOT INITIAL.
            l_txtlen_tmp = strlen( l_srv_ktxtconc_tmp ).
            l_txtlen_sum = l_txtlen_sum + l_txtlen_tmp.
            CLEAR ls_txt.
            ls_txt-lnrls = l_nlei_tmp-lnrls.
            ls_txt-txt   = l_srv_ktxtconc_tmp.
            ls_txt-len   = l_txtlen_tmp.
            APPEND ls_txt TO lt_txt.
          ENDLOOP.
          IF l_txtlen_sum > 120.
*           all texts together exceed the length of 120, so we have to cut off
            l_txtlen_rest = 120.
            l_first_do = on.
*           we need a DO-ENDDO because in first run, each text gets a maximum
*           length of 40. in second run the length is exceeded by another 40 and so on
            DO 15 TIMES.
              IF l_txtlen_rest <= 0.
*               leave if all text space is occupied
                EXIT.
              ENDIF.
              LOOP AT lt_txt INTO ls_txt.
                CHECK l_txtlen_rest > 0.            " stop if no more space available
                CHECK ls_txt-len_fix < ls_txt-len.  " dont handle if max length reached
                l_len_fix_old = ls_txt-len_fix.
                CLEAR l_len_fix.
                IF ls_txt-len > 40.
                  l_len_fix = 40.
                ELSE.
                  l_len_fix = ls_txt-len.
                ENDIF.
                IF l_len_fix > l_txtlen_rest.
                  l_len_fix = l_txtlen_rest.
                ENDIF.
                ls_txt-len_fix = ls_txt-len_fix + l_len_fix.
                IF ls_txt-len_fix > ls_txt-len.
                  ls_txt-len_fix = ls_txt-len.
                  l_len_fix = ls_txt-len - l_len_fix_old.
                ENDIF.
                MODIFY lt_txt FROM ls_txt.
                l_txtlen_rest = l_txtlen_rest - l_len_fix.
*               in first run of do-enddo we have to substract 2 for ',' between services
                CHECK l_first_do = on.
                l_txtlen_rest = l_txtlen_rest - 2.
              ENDLOOP.
              l_first_do = off.
            ENDDO.
*           finally read the right length for the actual service text
            SORT lt_txt BY lnrls.
            READ TABLE lt_txt INTO ls_txt
                 WITH KEY lnrls = l_nlei-lnrls BINARY SEARCH.
            IF sy-subrc = 0 AND ls_txt-len_fix > 0.
              l_srv_ktxtconc = l_srv_ktxtconc(ls_txt-len_fix).
            ELSE.
              CLEAR l_srv_ktxtconc.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
    IF i_node_closed = off OR c_outtab_line-srv_bez IS INITIAL.
      c_outtab_line-srv_bez = l_srv_ktxtconc.
    ELSE.
      CONCATENATE c_outtab_line-srv_bez l_srv_ktxtconc
                  INTO c_outtab_line-srv_bez SEPARATED BY ', '.
    ENDIF.
  ENDIF.

* Ergänzender Text
  IF l_nlem-ergtx  IS INITIAL AND l_srv_cnt      > 1  AND
     i_node_closed  = on      AND NOT i_place_holder IS INITIAL.
    l_filled = off.
    LOOP AT it_services INTO l_service.
      CALL METHOD l_service->get_data
        IMPORTING
          e_rc           = l_rc
          e_nlem         = l_nlem_tmp
        CHANGING
          c_errorhandler = c_errorhandler.
      CHECK l_rc = 0.
      IF NOT l_nlem_tmp-ergtx IS INITIAL.
        l_filled = on.
        EXIT.
      ENDIF.
    ENDLOOP.
    IF l_filled = on.
      l_nlem-ergtx = i_place_holder.
    ENDIF.
  ENDIF.
  IF i_node_closed = off OR c_outtab_line-srv_ergtx IS INITIAL.
    c_outtab_line-srv_ergtx = l_nlem-ergtx.
  ELSE.
    CONCATENATE c_outtab_line-srv_ergtx l_nlem-ergtx
                INTO c_outtab_line-srv_ergtx SEPARATED BY ', '.
  ENDIF.

* Lokalisation
  IF l_nlem-lslok  IS INITIAL AND l_srv_cnt      > 1  AND
     i_node_closed  = on      AND NOT i_place_holder IS INITIAL.
    l_filled = off.
    LOOP AT it_services INTO l_service.
      CALL METHOD l_service->get_data
        IMPORTING
          e_rc           = l_rc
          e_nlem         = l_nlem_tmp
        CHANGING
          c_errorhandler = c_errorhandler.
      CHECK l_rc = 0.
      IF NOT l_nlem_tmp-lslok IS INITIAL.
        l_filled = on.
        EXIT.
      ENDIF.
    ENDLOOP.
    IF l_filled = on.
      l_nlem-lslok = i_place_holder.
    ENDIF.
  ENDIF.
  IF i_node_closed = off OR c_outtab_line-srv_lslok IS INITIAL.
    c_outtab_line-srv_lslok = l_nlem-lslok.
  ELSE.
    CONCATENATE c_outtab_line-srv_lslok l_nlem-lslok
                INTO c_outtab_line-srv_lslok SEPARATED BY ', '.
  ENDIF.

* Lagerungsart (Bezeichnung)
  IF NOT l_nlem-lidi IS INITIAL.
    CALL FUNCTION 'ISHMED_READ_N1LAGRG'
      EXPORTING
        i_einri  = c_outtab_line-einri
        i_lidi   = l_nlem-lidi
      IMPORTING
        e_lgrbez = l_lgrbez
        e_rc     = l_rc.
  ELSE.
    CLEAR: l_rc, l_lgrbez.
  ENDIF.
  IF ( l_rc <> 0 OR l_lgrbez IS INITIAL ) AND l_srv_cnt > 1 AND
     i_node_closed  = on AND NOT i_place_holder IS INITIAL.
    l_filled = off.
    LOOP AT it_services INTO l_service.
      CALL METHOD l_service->get_data
        IMPORTING
          e_rc           = l_rc
          e_nlem         = l_nlem_tmp
        CHANGING
          c_errorhandler = c_errorhandler.
      CHECK l_rc = 0.
      IF NOT l_nlem_tmp-lidi IS INITIAL.
        l_filled = on.
        EXIT.
      ENDIF.
    ENDLOOP.
    IF l_filled = on.
      l_lgrbez = i_place_holder.
    ENDIF.
  ENDIF.
  IF i_node_closed = off OR c_outtab_line-srv_lgrbez IS INITIAL.
    c_outtab_line-srv_lgrbez = l_lgrbez.
  ELSE.
    CONCATENATE c_outtab_line-srv_lgrbez l_lgrbez
                INTO c_outtab_line-srv_lgrbez SEPARATED BY ', '.
  ENDIF.

* Einwilligung Patient
  IF i_node_closed = off.
*   Je Leistung befüllen
    c_outtab_line-patein = l_nlem-patein.
    CASE l_nlem-patein.
*     Einwilligung nicht erforderlich
      WHEN ' '.
*     Einwilligung vorhanden
      WHEN 'X'.
        CALL METHOD cl_ish_display_tools=>get_wp_icon
          EXPORTING
            i_einri     = c_outtab_line-einri
            i_indicator = '015'                  " grüne Ampel
          IMPORTING
            e_icon      = l_icon.
        c_outtab_line-patein_icon = l_icon.
*     Einwilligung erforderlich
      WHEN 'O'.
        CALL METHOD cl_ish_display_tools=>get_wp_icon
          EXPORTING
            i_einri     = c_outtab_line-einri
            i_indicator = '017'                  " rote Ampel
          IMPORTING
            e_icon      = l_icon.
        c_outtab_line-patein_icon = l_icon.
    ENDCASE.
  ELSE.
*   Für alle Leistungen 'gesammelt' befüllen
    CLEAR: l_green, l_red.
    LOOP AT it_services INTO l_service.
      CALL METHOD l_service->get_data
        IMPORTING
          e_rc           = e_rc
          e_nlem         = l_nlem_tmp
        CHANGING
          c_errorhandler = c_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
      CASE l_nlem_tmp-patein.
        WHEN ' '.                  " Einwilligung nicht erforderl.
        WHEN 'X'.                  " Einwilligung vorhanden
          l_green = on.
        WHEN 'O'.                  " Einwilligung erforderlich
          l_red   = on.
      ENDCASE.
    ENDLOOP.
    CHECK e_rc = 0.
    IF l_red = off AND l_green = off.
*     leer lassen
    ELSEIF l_red = on AND l_green = off.
      c_outtab_line-patein = 'O'.
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = c_outtab_line-einri
          i_indicator = '017'                  " rote Ampel
        IMPORTING
          e_icon      = l_icon.
      c_outtab_line-patein_icon = l_icon.
    ELSEIF l_red = on AND l_green = on.
      c_outtab_line-patein = 'Y'.
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = c_outtab_line-einri
          i_indicator = '016'                  " gelbe Ampel
        IMPORTING
          e_icon      = l_icon.
      c_outtab_line-patein_icon = l_icon.
    ELSEIF l_red = off AND l_green = on.
      c_outtab_line-patein = 'X'.
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = c_outtab_line-einri
          i_indicator = '015'                  " grüne Ampel
        IMPORTING
          e_icon      = l_icon.
      c_outtab_line-patein_icon = l_icon.
    ENDIF.
  ENDIF.

* Patient nüchtern (ID 15147)
  IF i_node_closed = off.
*   Je Leistung befüllen
    c_outtab_line-patnue = l_nlem-patnue.
  ELSE.
*   Für alle Leistungen 'gesammelt' befüllen
*   Nur dann das Icon 'Patient nüchtern' in der Sammelzeile
*   anzeigen, wenn alle Leistungen das KZ auf ON gesetzt haben
    c_outtab_line-patnue = '?'.
    LOOP AT it_services INTO l_service.
      CALL METHOD l_service->get_data
        IMPORTING
          e_rc           = e_rc
          e_nlem         = l_nlem_tmp
        CHANGING
          c_errorhandler = c_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
      IF c_outtab_line-patnue = '?'.
        c_outtab_line-patnue = l_nlem_tmp-patnue.
      ELSEIF c_outtab_line-patnue = on AND l_nlem_tmp-patnue = off.
        c_outtab_line-patnue = l_nlem_tmp-patnue.
      ENDIF.
    ENDLOOP.
    CHECK e_rc = 0.
    IF c_outtab_line-patnue = '?'.
      CLEAR c_outtab_line-patnue.
    ENDIF.
  ENDIF.
  IF c_outtab_line-patnue = on.
    CALL METHOD cl_ish_display_tools=>get_wp_icon
      EXPORTING
        i_einri     = c_outtab_line-einri
        i_indicator = '014'
      IMPORTING
        e_icon      = l_icon.
    c_outtab_line-patnue_icon = l_icon.
  ELSE.
    CALL METHOD cl_ish_display_tools=>get_wp_icon
      EXPORTING
        i_einri     = c_outtab_line-einri
        i_indicator = '053'
      IMPORTING
        e_icon      = l_icon.
    c_outtab_line-patnue_icon = l_icon.
  ENDIF.

* Infektionsgrad
* - bei OPs --> aus der Ankerleistung ermitteln
* - sonst aus den Einzelleistungen
  CLEAR l_ifg.
  IF NOT i_anchor IS INITIAL.
    IF c_outtab_line-seqno = 1 OR i_node_closed = on.
      CALL METHOD i_anchor->get_data
        IMPORTING
          e_rc           = l_rc
          e_nlem         = l_nlem_tmp
        CHANGING
          c_errorhandler = c_errorhandler.
      CHECK l_rc = 0.
      IF NOT l_nlem_tmp-ifg IS INITIAL.
        l_ifg = l_nlem_tmp-ifg.
      ENDIF.
    ENDIF.
  ELSE.
    IF NOT l_nlem-ifg IS INITIAL.
      IF c_outtab_line-ifgr IS INITIAL.
        l_ifg = l_nlem-ifg.
      ENDIF.
    ENDIF.
  ENDIF.
  IF NOT l_ifg IS INITIAL.
    CALL FUNCTION 'ISHMED_READ_N1IFG'
      EXPORTING
        i_einri   = c_outtab_line-einri
        i_ifg     = l_ifg
      IMPORTING
        e_ifge    = l_ifge
        e_ifgicon = l_ifgicon
        e_ifgtxt  = l_ifgtxt
        e_rc      = l_rc.
    IF l_rc = 0.
      c_outtab_line-ifgr      = l_ifge.
      c_outtab_line-ifgr_icon = l_ifgicon.
      c_outtab_line-ifgr_txt  = l_ifgtxt.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD fill_t_adm_data .
*MED-40483

  DATA l_dsp_afn          TYPE ish_on_off.
  DATA l_rc               TYPE ish_method_rc.
  DATA lr_prereg          TYPE REF TO cl_ishmed_prereg.
  DATA lr_cordpos         TYPE REF TO cl_ishmed_prereg.
  DATA lr_corder          TYPE REF TO cl_ish_corder.
  DATA lr_dspo_oper       TYPE REF TO cl_ishmed_dspobj_operation.
  DATA lr_dspo_app        TYPE REF TO cl_ishmed_dspobj_appointment.
  DATA lt_cordpos         TYPE ish_t_cordpos.
  DATA lt_einri_falnr     TYPE ish_einri_falnr_tab_type.
  DATA lt_nbew            TYPE STANDARD TABLE OF nbew
                          WITH NON-UNIQUE SORTED KEY case COMPONENTS einri falnr.
  DATA ls_einri_falnr     LIKE LINE OF lt_einri_falnr.
  DATA ls_nbew            LIKE LINE OF lt_nbew.
  DATA ls_ntmn            TYPE vntmn.


  FIELD-SYMBOLS <ls_fieldcat> LIKE LINE OF it_fieldcat.
  FIELD-SYMBOLS <ls_outtab>   LIKE LINE OF ct_outtab.
* ----- ----- -----
  CLEAR e_rc.
* ----- ----- -----
  IF ct_outtab IS INITIAL.
    RETURN.
  ENDIF.
* ----- ----- -----
  CLEAR: l_dsp_afn.
  LOOP AT it_fieldcat ASSIGNING <ls_fieldcat> WHERE no_out = off.
    CASE <ls_fieldcat>-fieldname.
      WHEN 'AFNOE' OR 'AFNDT' OR 'AFNZT'.
        l_dsp_afn = on.
    ENDCASE.
  ENDLOOP.

  IF l_dsp_afn = abap_false.
    RETURN.
  ENDIF.
  LOOP AT ct_outtab ASSIGNING <ls_outtab>
    WHERE seqno = 1.
    CLEAR: lr_prereg.
    TRY .
        lr_dspo_oper ?= <ls_outtab>-dspobj.
        lr_prereg = lr_dspo_oper->get_prereg( ).
      CATCH cx_sy_move_cast_error.
        TRY .
            lr_dspo_app ?= <ls_outtab>-dspobj.
            lr_prereg = lr_dspo_app->get_prereg( ).
          CATCH cx_sy_move_cast_error.
            CONTINUE.
        ENDTRY.
    ENDTRY.
*   ----- ----- -----
    IF lr_prereg IS NOT INITIAL AND  <ls_outtab>-falnr IS NOT INITIAL.
      CLEAR ls_einri_falnr.
      ls_einri_falnr-einri = <ls_outtab>-einri.
      ls_einri_falnr-falnr = <ls_outtab>-falnr.
      APPEND ls_einri_falnr TO lt_einri_falnr.
    ENDIF.
  ENDLOOP.
  IF lt_einri_falnr IS NOT INITIAL.
    SELECT * FROM nbew INTO TABLE lt_nbew
      FOR ALL ENTRIES IN lt_einri_falnr
           WHERE  einri  = lt_einri_falnr-einri
           AND    falnr  = lt_einri_falnr-falnr
           AND    bewty  = '1'
           AND    storn  = off.
  ENDIF.
* ----- ----- -----
  LOOP AT ct_outtab ASSIGNING <ls_outtab>
    WHERE seqno = 1.
    CLEAR: lr_prereg.
    TRY .
        lr_dspo_oper ?= <ls_outtab>-dspobj.
        lr_prereg = lr_dspo_oper->get_prereg( ).
      CATCH cx_sy_move_cast_error.
        TRY .
            lr_dspo_app ?= <ls_outtab>-dspobj.
            lr_prereg = lr_dspo_app->get_prereg( ).
          CATCH cx_sy_move_cast_error.
            CONTINUE.
        ENDTRY.
    ENDTRY.
*   ----- ----- -----
    IF lr_prereg IS NOT INITIAL.
      IF <ls_outtab>-falnr IS NOT INITIAL.
        READ TABLE lt_nbew INTO ls_nbew
        WITH TABLE KEY case COMPONENTS einri = <ls_outtab>-einri
                                       falnr = <ls_outtab>-falnr.
        IF sy-subrc = 0.
          <ls_outtab>-afnoe = ls_nbew-orgpf.
          <ls_outtab>-afndt = ls_nbew-bwidt.
          <ls_outtab>-afnzt = ls_nbew-bwizt.
        ENDIF.
      ENDIF.
      IF <ls_outtab>-afnoe IS INITIAL.
        CALL METHOD lr_prereg->get_corder
          IMPORTING
            er_corder       = lr_corder
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        IF e_rc <> 0.
          RETURN.
        ENDIF.

        CALL METHOD lr_corder->get_t_cordpos
          EXPORTING
            i_cancelled_datas = i_cancelled_data
            i_bewty           = '1'
            ir_environment    = ir_environment
          IMPORTING
            et_cordpos        = lt_cordpos
            e_rc              = l_rc
          CHANGING
            cr_errorhandler   = cr_errorhandler.
        IF l_rc = 0.
          LOOP AT lt_cordpos INTO lr_cordpos.
            CALL METHOD cl_ishmed_prereg=>get_admission_appmnt
              EXPORTING
                i_cancelled_datas = i_cancelled_data
                i_prereg          = lr_cordpos
                i_environment     = ir_environment
              IMPORTING
                e_rc              = l_rc
                e_ntmn            = ls_ntmn
              CHANGING
                c_errorhandler    = cr_errorhandler.
            IF l_rc = 0 AND NOT ls_ntmn IS INITIAL.
              <ls_outtab>-afnoe = ls_ntmn-tmnoe.
              <ls_outtab>-afndt = ls_ntmn-tmndt.
              <ls_outtab>-afnzt = ls_ntmn-tmnzt.
              EXIT.
            ENDIF. " IF l_rc = 0 AND NOT ls_ntmn IS INITIAL.
          ENDLOOP.
        ENDIF. " IF l_rc = 0.
      ENDIF. " IF <ls_outtab>-afnoe IS INITIAL.
    ENDIF. " IF lr_prereg IS NOT INITIAL.
  ENDLOOP.
* ----- ----- -----
ENDMETHOD.


METHOD fill_t_adpat_data .
* MED-40483
* variables
  DATA lt_outtab TYPE ishmed_t_display_fields.
  DATA ls_outtab LIKE LINE OF ct_outtab.
  FIELD-SYMBOLS <ls_outtab> LIKE LINE OF ct_outtab.

* initialization
  CLEAR: e_rc.

  IF ct_outtab IS INITIAL.
    RETURN.
  ENDIF.

  LOOP AT ct_outtab ASSIGNING <ls_outtab>
    WHERE seqno = 1.
    APPEND <ls_outtab> TO  lt_outtab.
  ENDLOOP.
  IF lt_outtab IS INITIAL.
    RETURN.
  ENDIF.

* ISHMED allergy documentation                                      6.05
  CALL FUNCTION 'ISH_N2_DP_AD'
    EXPORTING
      i_institution = <ls_outtab>-einri
      i_dispvar     = it_fieldcat[]
    CHANGING
      c_view_list   = lt_outtab.

  LOOP AT lt_outtab INTO ls_outtab.
    READ TABLE ct_outtab ASSIGNING <ls_outtab>
     WITH KEY dspobj = ls_outtab-dspobj
              seqno = ls_outtab-seqno.
    IF sy-subrc = 0.
      <ls_outtab> = ls_outtab.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD fill_t_case_data .

* MED-40483

  TYPES: BEGIN OF ty_doc,
           falnr     TYPE ndoc-falnr,
           lfdbew    TYPE ndoc-lfdbew,
           dtid      TYPE ndoc-dtid,
           dtvers    TYPE ndoc-dtvers,
           medok     TYPE ndoc-medok,
         END OF ty_doc.
  TYPES tyt_doc TYPE SORTED TABLE OF ty_doc WITH NON-UNIQUE KEY falnr.

  DATA l_date                TYPE sy-datum.
  DATA l_time                TYPE sy-uzeit.
  DATA l_einri               TYPE einri.
  DATA l_rc                  TYPE ish_method_rc.
  DATA l_icon_privat_patient TYPE nwicon.
  DATA l_icon_doc            TYPE nwicon.
  DATA l_icon_med_doc        TYPE nwicon.
  DATA l_icon_lab_doc        TYPE nwicon.
  DATA l_dsp_akt             TYPE ish_on_off.
  DATA l_dsp_dok             TYPE ish_on_off.
  DATA l_dsp_dok_art         TYPE ish_on_off.

  DATA lt_nfal               TYPE STANDARD TABLE OF nfal WITH NON-UNIQUE KEY falnr einri.
  DATA lt_nfal_se            TYPE STANDARD TABLE OF nfal.
  DATA lt_nfkl               TYPE STANDARD TABLE OF nfkl WITH NON-UNIQUE SORTED KEY falnr COMPONENTS falnr .
  DATA lt_nfkl_se            TYPE STANDARD TABLE OF nfkl.
  DATA lt_doc                TYPE tyt_doc.
  DATA ltr_medok             TYPE RANGE OF ndoc-medok.
  DATA lt_nbew               TYPE ish_t_nbew.

  DATA ls_tnkla              TYPE tnkla.
  DATA ls_akt_bew            TYPE nbew.
  DATA ls_nfal               LIKE LINE OF lt_nfal.
  DATA ls_nbau               TYPE nbau.
  DATA ls_medok              LIKE LINE OF ltr_medok.

  FIELD-SYMBOLS <ls_fieldcat>  LIKE LINE OF it_fieldcat.
  FIELD-SYMBOLS <ls_outtab>    LIKE LINE OF ct_outtab.
  FIELD-SYMBOLS <ls_doc>       LIKE LINE OF lt_doc.
  FIELD-SYMBOLS <ls_nfkl>      LIKE LINE OF lt_nfkl.
* ----- ----- -----
* Initialisierung
  CLEAR: e_rc.
  REFRESH: lt_nfal.
* ----- ----- -----
  IF ct_outtab IS INITIAL.
    RETURN.
  ENDIF.
* ----- ----- -----
* Anzuzeigende Daten anhand des Feldkatalogs bestimmen
  CLEAR: l_dsp_akt, l_dsp_dok, l_dsp_dok_art.
  LOOP AT it_fieldcat ASSIGNING <ls_fieldcat> WHERE no_out = off.
    CASE <ls_fieldcat>-fieldname.
      WHEN 'DOKKZ_ICON'.
        l_dsp_dok = on.
      WHEN 'MEDDOK_ICON' OR 'LABDOK_ICON'.
        l_dsp_dok     = on.
        l_dsp_dok_art = on.
      WHEN 'ORGPF_AKT' OR 'ROOM_AKT' OR 'ROOM_AKT_KB'.
        l_dsp_akt = on.
    ENDCASE.
  ENDLOOP.
* ----- ----- -----
* Fallbezogenes Objekt
  CALL FUNCTION 'ISH_REFRESH_NFAL'.             " MED-8787 (ID 18539)
* read case data
  LOOP AT ct_outtab ASSIGNING <ls_outtab>
    WHERE falnr IS NOT INITIAL
       AND seqno = 1.
    CLEAR ls_nfal.
*   Fall lesen
    CALL FUNCTION 'ISH_READ_NFAL'
      EXPORTING
        ss_einri           = <ls_outtab>-einri
        ss_falnr           = <ls_outtab>-falnr
        ss_message_no_auth = off                            " BA 2011
*       ss_read_db         = on                             " ID 18539
      IMPORTING
        ss_nfal            = ls_nfal
      EXCEPTIONS
        not_found          = 1
        not_found_archived = 2
        no_authority       = 3
        OTHERS             = 4.
    IF sy-subrc = 0.
      INSERT ls_nfal INTO TABLE lt_nfal.
*     Patientennummer unbedingt auch aus dem Fall befüllen
      <ls_outtab>-patnr = ls_nfal-patnr.
*     Fallart intern
      <ls_outtab>-falar = ls_nfal-falar.
*     Fallart extern
      CALL FUNCTION 'ISH_CONVERT_CASETYPE_OUTPUT'
        EXPORTING
          ss_einri = <ls_outtab>-einri
          ss_falai = <ls_outtab>-falar
        IMPORTING
          ss_falae = <ls_outtab>-falare
        EXCEPTIONS
          OTHERS   = 0.
    ENDIF.

  ENDLOOP.
* ----- ----- -----
  READ TABLE ct_outtab ASSIGNING <ls_outtab> INDEX 1.
  IF sy-subrc = 0.
    l_einri = <ls_outtab>-einri.
  ENDIF.
* ----- ----- -----
* read movement data
  IF lt_nfal IS NOT INITIAL.
    SELECT * FROM nbew INTO TABLE lt_nbew
      FOR ALL ENTRIES IN lt_nfal
           WHERE einri = lt_nfal-einri
             AND falnr = lt_nfal-falnr
             AND ( bewty = '4' OR bewty = '1' OR bewty = '3' )
             AND storn = off.
    IF l_dsp_dok = on .
*     Rangetab der Dokarten befüllen
      CLEAR: ls_medok, ltr_medok.
      ls_medok-sign   = 'I'.
      ls_medok-option = 'EQ'.
      ls_medok-low    = 'X'.                " Medizinische Dokumente
      APPEND ls_medok TO ltr_medok.          " UND
      ls_medok-low    = 'L'.                " Laborbefunde
      APPEND ls_medok TO ltr_medok.
*     read document data
      REFRESH lt_doc.
      SELECT falnr lfdbew dtid dtvers medok
             FROM ndoc INTO TABLE lt_doc
         FOR ALL ENTRIES IN lt_nfal
             WHERE einri EQ lt_nfal-einri
               AND falnr EQ lt_nfal-falnr
               AND storn EQ off
               AND loekz EQ off
               AND medok IN ltr_medok.
    ENDIF.
*   ----- ----- -----
*   get icons for document
    IF lt_doc IS NOT INITIAL.
*     get icon document for case or movement existing
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = l_einri
          i_indicator = '002'             " Dokument(e) vorhanden
        IMPORTING
          e_icon      = l_icon_doc.
*     get icon med. document for case or movement existing
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = l_einri
          i_indicator = '078'    " Med.Dokument(e) vorhanden
        IMPORTING
          e_icon      = l_icon_med_doc.
*     get icon lab. document for case or movement existing
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = l_einri
          i_indicator = '079'    " Lab.Dokument(e) vorhanden
        IMPORTING
          e_icon      = l_icon_lab_doc.
    ENDIF.
  ENDIF.
* ----- ----- -----
* get icon for privat patient
  CALL METHOD cl_ish_display_tools=>get_wp_icon
    EXPORTING
      i_einri     = l_einri
      i_indicator = '022'
    IMPORTING
      e_icon      = l_icon_privat_patient.

* ----- ----- -----
  IF lt_nfal IS NOT INITIAL.
*   get privat patient data for cases
    CLEAR: ls_tnkla.
    ls_tnkla-klfart_int = '10'.
    CALL FUNCTION 'ISHMED_GET_PRIVATPATIENT_DATA'
      EXPORTING
        i_tnkla = ls_tnkla
      TABLES
        t_nfal  = lt_nfal
        t_nfkl  = lt_nfkl.
  ENDIF.

* fill outtab
  LOOP AT ct_outtab ASSIGNING <ls_outtab> WHERE seqno = 1.
    CLEAR: lt_nfkl_se, lt_nfal_se, ls_nfal.
*   Privatpatient-Kennzeichen (auch für fallfreie Objekte ermitteln!)
    IF NOT <ls_outtab>-falnr IS INITIAL.
*     read case classification
      LOOP AT lt_nfkl ASSIGNING <ls_nfkl>
         USING KEY falnr
         WHERE falnr = <ls_outtab>-falnr.
        APPEND <ls_nfkl> TO lt_nfkl_se.
      ENDLOOP.
    ENDIF. "IF NOT <ls_outtab>-falnr IS INITIAL.

    IF NOT <ls_outtab>-date IS INITIAL.
      l_date = <ls_outtab>-date.
    ELSE.
      l_date = sy-datum.
    ENDIF.
    IF NOT <ls_outtab>-time IS INITIAL.
      l_time = <ls_outtab>-time.
    ELSE.
      l_time = sy-uzeit.
    ENDIF.
    CALL FUNCTION 'ISHMED_CHECK_PRIVATPATIENT'
      EXPORTING
        i_einri  = <ls_outtab>-einri
        i_falnr  = <ls_outtab>-falnr
        i_date   = l_date
        i_time   = l_time
        i_object = <ls_outtab>-object
      IMPORTING
        e_privkz = <ls_outtab>-privp
      TABLES
        t_nfkl   = lt_nfkl.
    IF <ls_outtab>-privp = on.
*     ext icon privat patient
      <ls_outtab>-privp_icon = l_icon_privat_patient.
    ENDIF.

*   Aktuelle Pfleg. OE / Zimmer des Patienten ermitteln
    IF l_dsp_akt = on AND <ls_outtab>-falnr IS NOT INITIAL
                      AND <ls_outtab>-falar <> '2'.         " ID 19633
      CLEAR ls_akt_bew.
*     read case data for outtab
      READ TABLE lt_nfal INTO ls_nfal
        WITH TABLE KEY falnr = <ls_outtab>-falnr
                       einri = <ls_outtab>-einri.
      IF sy-subrc = 0.
        CALL FUNCTION 'ISHMED_SEARCH_ORGFA'
          EXPORTING
            i_falnr       = <ls_outtab>-falnr
            i_einri       = <ls_outtab>-einri
            i_datum       = sy-datum                        "MED-44001
            i_zeit        = sy-uzeit                        "MED-44001
            i_nfal        = ls_nfal
            i_no_planb    = 'X'                             "MED-44001
          IMPORTING
            e_nbew        = ls_akt_bew
          TABLES
            t_nbew        = lt_nbew
          EXCEPTIONS
            no_valid_nfal = 1
            no_valid_nbew = 2
            OTHERS        = 3.
        IF sy-subrc = 0.
          <ls_outtab>-orgpf_akt = ls_akt_bew-orgpf.
          IF NOT ls_akt_bew-zimmr IS INITIAL.
            CALL METHOD cl_ish_dbr_bau=>get_bau_by_bauid
              EXPORTING
                i_bauid = ls_akt_bew-zimmr
              IMPORTING
                es_nbau = ls_nbau
                e_rc    = l_rc.
            IF l_rc <> 0.
              CLEAR: <ls_outtab>-room_akt, <ls_outtab>-room_akt_kb.
            ELSE.
              <ls_outtab>-room_akt    = ls_nbau-bkurz.
              <ls_outtab>-room_akt_kb = ls_nbau-baukb.
            ENDIF. " IF l_rc <> 0.
          ENDIF. " IF NOT l_akt_bew-zimmr IS INITIAL.
        ENDIF.  " IF sy-subrc = 0.
      ENDIF." IF sy-subrc = 0.
    ENDIF.      " Aktuelle Pfleg. OE / Zimmer des Patienten ermitteln

*   Dokumente vorhanden
    IF ( l_dsp_dok = on OR l_dsp_dok_art = on )
       AND <ls_outtab>-falnr IS NOT INITIAL AND lt_doc IS NOT INITIAL.
      IF l_dsp_dok = abap_true.
        READ TABLE lt_doc TRANSPORTING NO FIELDS
          WITH KEY falnr  = <ls_outtab>-falnr.
        IF sy-subrc = 0.
*         Dokument(e) zum Fall bzw. zur Bewegung vorhanden
          <ls_outtab>-dokkz_icon = l_icon_doc.
        ENDIF.
      ENDIF. "IF l_dsp_dok = abap_true.

*     Auch auf Vorhandensein von Med. Dok. oder Labordok. prüfen
      IF l_dsp_dok_art = abap_true.
        LOOP AT lt_doc ASSIGNING <ls_doc>
           WHERE falnr = <ls_outtab>-falnr.
          IF NOT <ls_outtab>-meddok_icon IS INITIAL AND
             NOT <ls_outtab>-labdok_icon IS INITIAL.
            CONTINUE.
          ENDIF.
          CASE <ls_doc>-medok.
            WHEN 'X'.
*             Med. Dokument(e) zum Fall bzw. zur Bewegung vorhanden
              <ls_outtab>-meddok_icon = l_icon_med_doc.
            WHEN 'L'.
*             Labordokument(e) zum Fall bzw. zur Bewegung vorhanden
              <ls_outtab>-labdok_icon = l_icon_lab_doc.
          ENDCASE.
        ENDLOOP. "LOOP AT lt_doc ASSIGNING <ls_doc>
      ENDIF. "IF l_dsp_dok_art = abap_true.
    ENDIF.      " Dokumente vorhanden

  ENDLOOP.
* ----- ----- -----
ENDMETHOD.


METHOD fill_t_context_data .
*MED-40483

  TYPES: BEGIN OF ty_conext,
    r_object TYPE REF TO cl_ish_run_data,
    s_cx_object TYPE rn1_cx_objects,
  END OF ty_conext.
  TYPES tyt_context TYPE HASHED TABLE OF ty_conext WITH UNIQUE KEY r_object.


  DATA l_dsp_context TYPE ish_on_off.
  DATA l_cx_key           TYPE string.

  DATA lr_dspo_oper  TYPE REF TO cl_ishmed_dspobj_operation.
  DATA lr_dspo_app   TYPE REF TO cl_ishmed_dspobj_appointment.
  DATA lr_request    TYPE REF TO cl_ishmed_request.
  DATA lr_prereg     TYPE REF TO cl_ishmed_prereg.

  DATA lt_cx_objects TYPE ishmed_t_cx_objects.
  DATA lt_context    TYPE ish_t_context.
  DATA lt_cx_obj_con TYPE tyt_context.

  DATA ls_cx_object  LIKE LINE OF lt_cx_objects.
  DATA ls_n1anf      TYPE n1anf.
  DATA ls_n1vkg      TYPE n1vkg.
  DATA ls_cx_obj_con LIKE LINE OF lt_cx_obj_con.


  FIELD-SYMBOLS <ls_fieldcat> LIKE LINE OF it_fieldcat.
  FIELD-SYMBOLS <ls_outtab>   LIKE LINE OF ct_outtab.
  FIELD-SYMBOLS <ls_context>  LIKE LINE OF lt_context.
* ----- ----- -----
  CLEAR e_rc.
* ----- ----- -----
  IF ct_outtab IS INITIAL.
    RETURN.
  ENDIF.
* ----- ----- -----
  CLEAR: l_dsp_context.
  LOOP AT it_fieldcat ASSIGNING <ls_fieldcat> WHERE no_out = off.
    CASE <ls_fieldcat>-fieldname.
      WHEN 'KONTEXT1'    OR 'KONTEXT2'    OR 'KONTEXT3'    OR
           'CXSTA1'      OR 'CXSTA2'      OR 'CXSTA3'      OR
           'CXSTA_ICON1' OR 'CXSTA_ICON2' OR 'CXSTA_ICON3'.
        l_dsp_context = on.
    ENDCASE.
  ENDLOOP.

  IF l_dsp_context = abap_false.
    RETURN.
  ENDIF.
* ----- ----- -----
  LOOP AT ct_outtab ASSIGNING <ls_outtab> WHERE seqno = 1.
    CLEAR: lr_prereg, lr_request, ls_cx_object, ls_cx_obj_con.
    TRY .
        lr_dspo_oper ?= <ls_outtab>-dspobj.
        lr_prereg = lr_dspo_oper->get_prereg( ).
        IF lr_prereg IS INITIAL.
          lr_request = lr_dspo_oper->get_request( ).
        ENDIF.
      CATCH cx_sy_move_cast_error.
        TRY .
            lr_dspo_app ?= <ls_outtab>-dspobj.
            lr_prereg = lr_dspo_app->get_prereg( ).
            IF lr_prereg IS INITIAL.
              lr_request = lr_dspo_app->get_request( ).
            ENDIF.
          CATCH cx_sy_move_cast_error.
            CONTINUE.
        ENDTRY.
    ENDTRY.
*   ----- ----- -----
*   Anforderungsdaten- bzw. Daten der Klinischen Auftragsposition lesen
    IF lr_request IS NOT INITIAL.
*     request
      CALL METHOD lr_request->get_data
        IMPORTING
          e_rc           = e_rc
          e_n1anf        = ls_n1anf
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF e_rc <> 0.
        RETURN.
      ENDIF.
*       Objekt-Schlüssel für Zuordnung zu einem Kontext ermitteln.
      CALL METHOD cl_ishmed_request=>build_key_string
        EXPORTING
          i_mandt = sy-mandt
          i_einri = ls_n1anf-einri
          i_anfid = ls_n1anf-anfid
        IMPORTING
          e_key   = l_cx_key.
      CALL METHOD cl_ish_context=>get_key_for_obj
        EXPORTING
          i_object_type = cl_ishmed_request=>co_otype_request
          i_key         = l_cx_key
        IMPORTING
          e_key         = ls_cx_object-objtyid
          e_type        = ls_cx_object-objty.
      APPEND ls_cx_object TO lt_cx_objects.
      ls_cx_obj_con-r_object = lr_request.
      ls_cx_obj_con-s_cx_object = ls_cx_object.
      INSERT ls_cx_obj_con INTO TABLE lt_cx_obj_con.
    ELSEIF NOT lr_prereg IS INITIAL.
*     cordpos
      CALL METHOD lr_prereg->get_data
        IMPORTING
          e_rc           = e_rc
          e_n1vkg        = ls_n1vkg
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF e_rc <> 0.
        RETURN.
      ENDIF.
*     Objekt-Schlüssel für Zuordnung zu einem Kontext ermitteln.
      CALL METHOD cl_ish_corder=>build_key_string
        EXPORTING
          i_mandt    = sy-mandt
          i_corderid = ls_n1vkg-corderid
        IMPORTING
          e_key      = l_cx_key.
      CALL METHOD cl_ish_context=>get_key_for_obj
        EXPORTING
          i_object_type = cl_ish_corder=>co_otype_corder
          i_key         = l_cx_key
        IMPORTING
          e_key         = ls_cx_object-objtyid
          e_type        = ls_cx_object-objty.
      APPEND ls_cx_object TO lt_cx_objects.
      ls_cx_obj_con-r_object = lr_prereg.
      ls_cx_obj_con-s_cx_object = ls_cx_object.
      INSERT ls_cx_obj_con INTO TABLE lt_cx_obj_con.
    ELSE.
      CONTINUE.
    ENDIF.
  ENDLOOP.

  IF lt_cx_objects IS INITIAL.
    RETURN.
  ENDIF.
* ----- ----- -----
  IF i_no_save = abap_true.
    CALL METHOD cl_ishmed_run_dp=>read_context_for_object
      EXPORTING
        it_objects        = lt_cx_objects
*        i_ctoty           = '0'   " Auslöser des Kontext           "REM MED-46032
        i_ctx_nbr         = '3'   " Anzahl zu suchende Kontexte
        i_cancelled_datas = i_cancelled_data
        i_environment     = ir_environment
        i_buffer_active   = abap_true
        i_read_db         = abap_false
      IMPORTING
        et_context        = lt_context.
  ELSE.
    CALL METHOD cl_ishmed_run_dp=>read_context_for_object
      EXPORTING
        it_objects        = lt_cx_objects
*        i_ctoty           = '0'   " Auslöser des Kontext           "REM MED-46032
        i_ctx_nbr         = '3'   " Anzahl zu suchende Kontexte
        i_cancelled_datas = i_cancelled_data
        i_buffer_active   = abap_true
        i_read_db         = abap_false
      IMPORTING
        et_context        = lt_context.
  ENDIF.

  IF lt_context IS INITIAL.
    RETURN.
  ENDIF.
* ----- ----- -----
  LOOP AT ct_outtab ASSIGNING <ls_outtab> WHERE seqno = 1.
    CLEAR: lr_prereg, lr_request, ls_cx_object.
    TRY .
        lr_dspo_oper ?= <ls_outtab>-dspobj.
        lr_prereg = lr_dspo_oper->get_prereg( ).
        IF lr_prereg IS INITIAL.
          lr_request = lr_dspo_oper->get_request( ).
        ENDIF.
      CATCH cx_sy_move_cast_error.
        TRY .
            lr_dspo_app ?= <ls_outtab>-dspobj.
            lr_prereg = lr_dspo_app->get_prereg( ).
            IF lr_prereg IS INITIAL.
              lr_request = lr_dspo_app->get_request( ).
            ENDIF.
          CATCH cx_sy_move_cast_error.
            CONTINUE.
        ENDTRY.
    ENDTRY.

*   Anforderungsdaten- bzw. Daten der Klinischen Auftragsposition lesen
    IF lr_request IS NOT INITIAL.
      READ TABLE lt_cx_obj_con INTO ls_cx_obj_con
       WITH TABLE KEY r_object = lr_request.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.
    ELSEIF NOT lr_prereg IS INITIAL.
      READ TABLE lt_cx_obj_con INTO ls_cx_obj_con
       WITH TABLE KEY r_object = lr_prereg.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.
    ELSE.
      CONTINUE.
    ENDIF.
*   ----- ----- -----
    LOOP AT lt_context ASSIGNING <ls_context>
       WHERE objty = ls_cx_obj_con-s_cx_object-objty
        AND objid = ls_cx_obj_con-s_cx_object-objtyid.
      CASE <ls_context>-nbr.
        WHEN 1.
          <ls_outtab>-kontext1    = <ls_context>-cxtypsn.
          <ls_outtab>-cxid1       = <ls_context>-cxid.
          <ls_outtab>-cxsta1      = <ls_context>-cxstanm.
          <ls_outtab>-cxsta_icon1 = <ls_context>-cxsicon.
        WHEN 2.
          <ls_outtab>-kontext2    = <ls_context>-cxtypsn.
          <ls_outtab>-cxid2       = <ls_context>-cxid.
          <ls_outtab>-cxsta2      = <ls_context>-cxstanm.
          <ls_outtab>-cxsta_icon2 = <ls_context>-cxsicon.
        WHEN 3.
          <ls_outtab>-kontext3    = <ls_context>-cxtypsn.
          <ls_outtab>-cxid3       = <ls_context>-cxid.
          <ls_outtab>-cxsta3      = <ls_context>-cxstanm.
          <ls_outtab>-cxsta_icon3 = <ls_context>-cxsicon.
      ENDCASE.
    ENDLOOP.
  ENDLOOP.
* ----- ----- -----
ENDMETHOD.


METHOD fill_t_pathway_data .

* variables
  DATA lt_outtab TYPE ishmed_t_display_fields.
  DATA ls_outtab LIKE LINE OF ct_outtab.
  FIELD-SYMBOLS <ls_outtab> LIKE LINE OF ct_outtab.

* initialization
  CLEAR: e_rc.

  IF ct_outtab IS INITIAL.
    RETURN.
  ENDIF.

  LOOP AT ct_outtab ASSIGNING <ls_outtab>
    WHERE seqno = 1.
    APPEND <ls_outtab> TO  lt_outtab.
  ENDLOOP.
  IF lt_outtab IS INITIAL.
    RETURN.
  ENDIF.
* pathway active?
  IF cl_ishmed_fct_guideline=>is_in_use(
       i_institution = <ls_outtab>-einri ) = abap_false.
    RETURN.
  ENDIF.


* get patient pathway data
  CALL FUNCTION 'ISH_N2_GL_DP_PATIENT_PATHWAY'
    EXPORTING
      i_institution        = <ls_outtab>-einri
      i_dispvar            = it_fieldcat[]
    TABLES
      i_selection_criteria = it_selection_criteria[]
*     I_REFRESH_CASE       =
    CHANGING
      c_view_list          = lt_outtab.

  LOOP AT lt_outtab INTO ls_outtab.
    READ TABLE ct_outtab ASSIGNING <ls_outtab>
     WITH KEY dspobj = ls_outtab-dspobj
              seqno = ls_outtab-seqno.
    IF sy-subrc = 0.
      <ls_outtab> = ls_outtab.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD finalize_outtab.

  DATA l_rc   TYPE ish_method_rc.
* ----- ----- ----
  CLEAR: e_rc.
* ----- ----- ----
  IF ct_outtab IS INITIAL.
    RETURN.
  ENDIF.

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

* ----- ----- ----
* build case data
  CALL METHOD cl_ish_display_tools=>fill_t_case_data
    EXPORTING
      it_fieldcat     = it_fieldcat
    IMPORTING
      e_rc            = l_rc
    CHANGING
      ct_outtab       = ct_outtab
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.
* ----- ----- ----
* build context data
  CALL METHOD cl_ish_display_tools=>fill_t_context_data
    EXPORTING
      it_fieldcat      = it_fieldcat
      i_no_save        = i_no_save
      i_cancelled_data = i_cancelled_data
      ir_environment   = ir_environment
    IMPORTING
      e_rc             = l_rc
    CHANGING
      ct_outtab        = ct_outtab
      cr_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.
* ----- ----- ----
* build allergy data
  CALL METHOD cl_ish_display_tools=>fill_t_adpat_data
    EXPORTING
      it_fieldcat     = it_fieldcat
    IMPORTING
      e_rc            = e_rc
    CHANGING
      ct_outtab       = ct_outtab
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.
* ----- ----- ----
* build pathway data
  CALL METHOD cl_ish_display_tools=>fill_t_pathway_data
    EXPORTING
      it_fieldcat           = it_fieldcat
      it_selection_criteria = it_selection_criteria
    IMPORTING
      e_rc                  = e_rc
    CHANGING
      ct_outtab             = ct_outtab
      cr_errorhandler       = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.
* ----- ----- ----
  CALL METHOD cl_ish_display_tools=>fill_t_adm_data
    EXPORTING
      it_fieldcat      = it_fieldcat
      i_cancelled_data = i_cancelled_data
      ir_environment   = ir_environment
    IMPORTING
      e_rc             = e_rc
    CHANGING
      ct_outtab        = ct_outtab
      cr_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.
* ----- ----- ----
ENDMETHOD.


METHOD get_data .

* Lokale Tabellen
  DATA:          lt_object                  TYPE ish_objectlist,
                 lt_dspobj                  TYPE ish_objectlist.
* Workareas
  DATA:          l_object                   LIKE LINE OF lt_object.
* Datenreferenz
  DATA:          l_work_area                TYPE REF TO data.
* Feldsymbole
  FIELD-SYMBOLS: <l_outtab>                 TYPE ANY,
                 <l_dspobj>                 TYPE ANY,
                 <l_impobj>                 TYPE ANY.
* ---------- ---------- ----------
* Initialisierung
  CLEAR e_rc.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: et_object[].
* ---------- ---------- ----------
* Workarea zur Ausgabetabelle definieren.
  CREATE DATA l_work_area LIKE LINE OF it_outtab.
  ASSIGN l_work_area->* TO <l_outtab>.
* ---------- ---------- ----------
  CLEAR: lt_dspobj[].
  LOOP AT it_outtab INTO <l_outtab>.
*   ----------
*   Anzeigeobjekt ermitteln
    ASSIGN COMPONENT 'DSPOBJ' OF STRUCTURE <l_outtab>
       TO <l_dspobj>.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
      EXIT.
    ENDIF.
*   Erzeugendes Objekt ermitteln
    ASSIGN COMPONENT 'IMPOBJ' OF STRUCTURE <l_outtab>
       TO <l_impobj>.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
      EXIT.
    ENDIF.
*   ----------
    IF <l_dspobj> IS INITIAL.
      CONTINUE.
    ENDIF.
*   ----------
*   Auswahl einschränken (falls gewünscht)
    IF NOT it_object[] IS INITIAL.
      READ TABLE it_object TRANSPORTING NO FIELDS
         WITH KEY object = <l_impobj>.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.
    ENDIF.
*   ----------
    l_object-object = <l_dspobj>.
    INSERT l_object INTO TABLE lt_dspobj.
*   ----------
  ENDLOOP.
* ---------- ---------- ----------
* Mehrfach vorkommende Anzeige-Objekte entfernen.
  SORT lt_dspobj BY object.
  DELETE ADJACENT DUPLICATES FROM lt_dspobj
     COMPARING object.
* ---------- ---------- ----------
  LOOP AT lt_dspobj INTO l_object.
*   ----------
*   Objekte aus dem Anzeigeobjekt ermitteln.
    CLEAR: lt_object[].
    CALL METHOD l_object-object->('GET_DATA')
      IMPORTING
        et_object = lt_object.
    APPEND LINES OF lt_object TO et_object.
*   ----------
  ENDLOOP.
  IF e_rc <> 0.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD GET_DRAG_DROP_FOR_WP .

* Hilfsfelder und -strukturen
  DATA: l_relative_name       TYPE string.
* Objekt-Instanzen
  DATA: l_descr_obj           TYPE REF TO cl_abap_typedescr,
        l_display_dd_obj      TYPE REF TO cl_ish_display_drag_drop_cont.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Prüfen ob es sich bei dem DD-Objekt um ein Objekt der
* Display-Klasse (Sichttyp OP) handelt.
  CALL METHOD cl_abap_typedescr=>describe_by_object_ref
    EXPORTING
      p_object_ref         = i_dragdropobj
    RECEIVING
      p_descr_ref          = l_descr_obj
    EXCEPTIONS
      reference_is_initial = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  CALL METHOD l_descr_obj->get_relative_name
    RECEIVING
      p_relative_name = l_relative_name.
  IF l_relative_name = 'CL_ISH_DISPLAY_DRAG_DROP_CONT'.
    l_display_dd_obj ?= i_dragdropobj.
    e_wp_dragdropobj = l_display_dd_obj->g_wp_drag_drop_cont.
  ELSEIF l_relative_name = 'CL_ISH_WP_DRAG_DROP_CONTAINER'.
    e_wp_dragdropobj ?= i_dragdropobj.
  ELSE.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_outtab_for_rowid .

* Workareas
  DATA:          l_index_row                LIKE LINE OF it_index_rows.
* Datenreferenz
  DATA:          l_work_area                TYPE REF TO data.
* Feldsymbole
  FIELD-SYMBOLS: <l_outtab>                 TYPE ANY.
* ---------- ---------- ----------
* Initialisierung
  CLEAR e_rc.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: et_outtab_lines[].
* ---------- ---------- ----------
* Workarea zur Ausgabetabelle definieren.
  CREATE DATA l_work_area LIKE LINE OF it_outtab.
  ASSIGN l_work_area->* TO <l_outtab>.
* ---------- ---------- ----------
  IF NOT i_index IS INITIAL.
*   Einzel-Index wurde übergeben.
    READ TABLE it_outtab INTO <l_outtab>
       INDEX i_index.
    IF sy-subrc = 0.
      INSERT <l_outtab> INTO TABLE et_outtab_lines.
    ENDIF.
  ELSE.
*   n-Indizes wurden übergeben.
    LOOP AT it_index_rows INTO l_index_row.
      READ TABLE it_outtab INTO <l_outtab>
         INDEX l_index_row-index.
      IF sy-subrc = 0.
        INSERT <l_outtab> INTO TABLE et_outtab_lines.
      ENDIF.
    ENDLOOP.
  ENDIF.
  IF e_rc <> 0.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_rowid_for_object .

* Workareas
  DATA:          l_index_row                LIKE LINE OF et_index_rows.
* Datenreferenz
  DATA:          l_work_area                TYPE REF TO data.
* Feldsymbole
  FIELD-SYMBOLS: <l_outtab>                 TYPE ANY,
                 <l_impobj>                 TYPE ANY.
* Hilfsfelder und -strukturen
  DATA:          l_index                    TYPE sy-tabix.
* ---------- ---------- ----------
* Initialisierung
  CLEAR e_rc.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: et_index_rows[].
* ---------- ---------- ----------
* Workarea zur Ausgabetabelle definieren.
  CREATE DATA l_work_area LIKE LINE OF it_outtab.
  ASSIGN l_work_area->* TO <l_outtab>.
* ---------- ---------- ----------
  LOOP AT it_outtab INTO <l_outtab>.
*   ----------
    l_index = sy-tabix.
*   ----------
*   Benötigte Felder der OUTTAB in entsprechende Feldsymbole
*   übernehmen.
    ASSIGN COMPONENT 'IMPOBJ' OF STRUCTURE <l_outtab>
       TO <l_impobj>.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
      EXIT.
    ENDIF.
*   ----------
*   Prüfen ob der Eintrag gesucht wird und falls ja Index in
*   Rückgabetabelle speichern.
    CLEAR: l_index_row.
    READ TABLE it_object TRANSPORTING NO FIELDS
       WITH KEY object = <l_impobj>.
    IF sy-subrc = 0.
      l_index_row-index = l_index.
      INSERT l_index_row INTO TABLE et_index_rows.
    ENDIF.
*   ----------
  ENDLOOP.
  IF e_rc <> 0.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_sel_object.

* Workareas
  DATA: l_outtab                    LIKE LINE OF it_outtab,
        l_sel_object                LIKE LINE OF et_sel_object.
* ---------- ---------- ----------
* Initialisierung
  CLEAR: et_sel_object[].
* ---------- ---------- ----------
  LOOP AT it_outtab INTO l_outtab.
*   ----------
    IF l_outtab-impobj IS INITIAL.
      CONTINUE.
    ENDIF.
*   ----------
*   OO-Daten
    READ TABLE et_sel_object TRANSPORTING NO FIELDS
       WITH KEY object    = l_outtab-impobj
                subobject = l_outtab-object.
    IF sy-subrc <> 0.
      CLEAR: l_sel_object.
*     erzeug. Objekt
      l_sel_object-object    = l_outtab-impobj.
      l_sel_object-subobject = l_outtab-object.
      l_sel_object-dspobj    = l_outtab-dspobj.
      l_sel_object-dspcls    = i_dspcls.
      l_sel_object-seqno     = l_outtab-seqno.
      l_sel_object-attribute = if_ish_list_display=>co_sel_object.
      INSERT l_sel_object INTO TABLE et_sel_object.
    ENDIF.
*   Auch andere ausgewählte Objekte berücksichtigen
*   (zb Einzelleistung, ...)
    IF i_fieldname(3) = 'SRV' OR
       i_fieldname   IS INITIAL.
      IF NOT l_outtab-srvobj IS INITIAL.
        CLEAR: l_sel_object.
*       erzeug. Objekt
        l_sel_object-object    = l_outtab-impobj.
        l_sel_object-subobject = l_outtab-srvobj.
        l_sel_object-dspobj    = l_outtab-dspobj.
        l_sel_object-dspcls    = i_dspcls.
        l_sel_object-seqno     = l_outtab-seqno.
        l_sel_object-attribute = if_ish_list_display=>co_sel_srvobj.
        INSERT l_sel_object INTO TABLE et_sel_object.
      ENDIF.
    ENDIF.
  ENDLOOP.
* ---------- ---------- ----------
* Falls nur ausgewählte Einträge eines bestimmten Attributes
* (untergeordnete Objekte, ...) gewünscht werden dies berücksichtigen.
  IF i_sel_attribute <> '*'.
    DELETE et_sel_object   WHERE attribute <> i_sel_attribute.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_sort_criteria.

* Workareas
  DATA: l_sort                 LIKE LINE OF et_sort,
        l_sort_detail          TYPE rn1display_sort_dyn.
* Hilfsfelder und -strukturen
*  DATA: l_rc                   TYPE ish_method_rc.

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: et_sort[], et_sort_detail[].
* ---------- ---------- ----------
  CASE i_sort.
*   Standard-Sortierung für OP
    WHEN if_ish_list_display=>co_sort_op_std.
*     Datum
      CLEAR l_sort.
      l_sort-spos              = '001'.
      l_sort-fieldname         = 'DATE'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'DATE'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Planende OrgEinheit
      CLEAR l_sort.
      l_sort-spos              = '002'.
      l_sort-fieldname         = 'PLANOE'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'PLANOE'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Behandlungsraum
      CLEAR l_sort.
      l_sort-spos              = '003'.
      l_sort-fieldname         = 'ROOM'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'ROOM'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Not-Operation
      CLEAR l_sort.
      l_sort-spos              = '004'.
      l_sort-fieldname         = 'EMERG_OP'.
      l_sort-down              = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'EMERG_OP'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     tagesgenauer Termin
      CLEAR l_sort.
      l_sort-spos              = '005'.
      l_sort-fieldname         = 'TMTAG'.
      l_sort-down              = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'TMTAG'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Uhrzeit
      CLEAR l_sort.
      l_sort-spos              = '006'.
      l_sort-fieldname         = 'SORT01'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'TIME'.
      l_sort_detail-sort_field = 'SORT01'.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Priorität
      CLEAR l_sort.
      l_sort-spos              = '007'.
      l_sort-fieldname         = 'PRIO'.
      l_sort-down              = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'PRIO'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Nachname
      CLEAR l_sort.
      l_sort-spos              = '008'.
      l_sort-fieldname         = 'NNAMS'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'NNAMS'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Vorname
      CLEAR l_sort.
      l_sort-spos              = '009'.
      l_sort-fieldname         = 'VNAMS'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'VNAMS'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Schlüssel eines Objektes
      CLEAR l_sort.
      l_sort-spos              = '010'.
      l_sort-fieldname         = 'KEYNO'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'KEYNO'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Laufende Satznummer
      CLEAR l_sort.
      l_sort-spos              = '011'.
      l_sort-fieldname         = 'SEQNO'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
*      CLEAR l_sort_detail.
*      l_sort_detail-fieldname  = 'SEQNO'.
*      l_sort_detail-sort_field = l_sort_detail-fieldname.
*      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*   Sortierung nach Datum
    WHEN if_ish_list_display=>co_sort_date.
*     Datum
      CLEAR l_sort.
      l_sort-spos              = '001'.
      l_sort-fieldname         = 'DATE'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'DATE'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Uhrzeit
      CLEAR l_sort.
      l_sort-spos              = '002'.
      l_sort-fieldname         = 'SORT01'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'TIME'.
      l_sort_detail-sort_field = 'SORT01'.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Nachname
      CLEAR l_sort.
      l_sort-spos              = '003'.
      l_sort-fieldname         = 'NNAMS'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'NNAMS'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Vorname
      CLEAR l_sort.
      l_sort-spos              = '004'.
      l_sort-fieldname         = 'VNAMS'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'VNAMS'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Schlüssel eines Objektes
      CLEAR l_sort.
      l_sort-spos              = '005'.
      l_sort-fieldname         = 'KEYNO'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'KEYNO'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Laufende Satznummer
      CLEAR l_sort.
      l_sort-spos              = '006'.
      l_sort-fieldname         = 'SEQNO'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
*      CLEAR l_sort_detail.
*      l_sort_detail-fieldname  = 'SEQNO'.
*      l_sort_detail-sort_field = l_sort_detail-fieldname.
*      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*   Sortierung nach Anforderer
    WHEN if_ish_list_display=>co_sort_requester.
*     Anfordernde OrgEinheit
      CLEAR l_sort.
      l_sort-spos              = '001'.
      l_sort-fieldname         = 'ANPOE'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'ANPOE'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Nachname
      CLEAR l_sort.
      l_sort-spos              = '002'.
      l_sort-fieldname         = 'NNAMS'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'NNAMS'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Vorname
      CLEAR l_sort.
      l_sort-spos              = '003'.
      l_sort-fieldname         = 'VNAMS'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'VNAMS'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Schlüssel eines Objektes
      CLEAR l_sort.
      l_sort-spos              = '004'.
      l_sort-fieldname         = 'KEYNO'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'KEYNO'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Laufende Satznummer
      CLEAR l_sort.
      l_sort-spos              = '005'.
      l_sort-fieldname         = 'SEQNO'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
*      CLEAR l_sort_detail.
*      l_sort_detail-fieldname  = 'SEQNO'.
*      l_sort_detail-sort_field = l_sort_detail-fieldname.
*      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*   Sortierung nach operierenden OrgEinheit
    WHEN if_ish_list_display=>co_sort_opou.
*     Erbringende OrgEinheit
      CLEAR l_sort.
      l_sort-spos              = '001'.
      l_sort-fieldname         = 'ERBOE'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'ERBOE'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Nachname
      CLEAR l_sort.
      l_sort-spos              = '002'.
      l_sort-fieldname         = 'NNAMS'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'NNAMS'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Vorname
      CLEAR l_sort.
      l_sort-spos              = '003'.
      l_sort-fieldname         = 'VNAMS'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'VNAMS'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Schlüssel eines Objektes
      CLEAR l_sort.
      l_sort-spos              = '004'.
      l_sort-fieldname         = 'KEYNO'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
      CLEAR l_sort_detail.
      l_sort_detail-fieldname  = 'KEYNO'.
      l_sort_detail-sort_field = l_sort_detail-fieldname.
      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
*     Laufende Satznummer
      CLEAR l_sort.
      l_sort-spos              = '005'.
      l_sort-fieldname         = 'SEQNO'.
      l_sort-up                = on.
      APPEND l_sort TO et_sort.
*     ----------
*      CLEAR l_sort_detail.
*      l_sort_detail-fieldname  = 'SEQNO'.
*      l_sort_detail-sort_field = l_sort_detail-fieldname.
*      APPEND l_sort_detail TO et_sort_detail.
*     ---------- ----------
  ENDCASE.

ENDMETHOD.


METHOD get_wp_icon .

  DATA: lt_nwicons  TYPE TABLE OF nwicons,
        l_nwicons   LIKE LINE OF lt_nwicons.

  CLEAR e_icon.

  CLEAR l_nwicons.
  REFRESH lt_nwicons.

  l_nwicons-einri         = i_einri.
  l_nwicons-col_indicator = i_indicator.
  APPEND l_nwicons TO lt_nwicons.

  CALL FUNCTION 'ISHMED_NWICONS_GET'
    TABLES
      t_nwicons = lt_nwicons.

  READ TABLE lt_nwicons INTO l_nwicons INDEX 1.
  CHECK sy-subrc = 0.
  IF l_nwicons-letter IS INITIAL.
    e_icon = l_nwicons-icon.
  ELSE.
    e_icon = l_nwicons-letter.
  ENDIF.

ENDMETHOD.


METHOD get_wp_ish_object .

* Lokale Tabellen
  DATA: lt_sel_object               TYPE ish_t_sel_object,
        lt_object                   TYPE ish_objectlist,
        lt_nfal                     TYPE ishmed_t_nfal,
        lt_npat                     TYPE ishmed_t_npat,
        lt_npap                     TYPE ishmed_t_npap,
        lt_ntmn                     TYPE ishmed_t_ntmn,
        lt_nbew                     TYPE ishmed_t_nbew.
* Workareas
  DATA: l_ish_object                LIKE LINE OF et_ish_object,
        l_sel_object                LIKE LINE OF it_object,
        l_object                    LIKE LINE OF lt_object,
        l_nfal                      LIKE LINE OF lt_nfal,
        l_npat                      LIKE LINE OF lt_npat,
        l_npap                      LIKE LINE OF lt_npap,
        l_ntmn                      LIKE LINE OF lt_ntmn,
        l_nbew                      LIKE LINE OF lt_nbew.
* Hilfsfelder und -strukturen
  DATA: l_objectset                 TYPE ish_objectset_id.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: l_objectset.
* ---------- ---------- ----------
* Einige Felder nur 1x mit Objectset 0 einfügen
* Einrichtung
  CLEAR: l_ish_object.
  l_ish_object-objectid = '00'.
  l_ish_object-objectlow = i_institution.
  l_ish_object-objectset = l_objectset.
  INSERT l_ish_object INTO TABLE et_ish_object.
* Sicht-ID
  CLEAR: l_ish_object.
  l_ish_object-objectid = '96'.
  l_ish_object-objectlow = i_view_id.
  l_ish_object-objectset = l_objectset.
  INSERT l_ish_object INTO TABLE et_ish_object.
* Sicht-Typ
  CLEAR: l_ish_object.
  l_ish_object-objectid = '97'.
  l_ish_object-objectlow = i_view_type.
  l_ish_object-objectset = l_objectset.
  INSERT l_ish_object INTO TABLE et_ish_object.
* ---------- ---------- ----------
* Objectset auf 1 hochzählen
  l_objectset = l_objectset + 1.
* ---------- ---------- ----------
  REFRESH lt_sel_object.
  APPEND LINES OF it_object TO lt_sel_object.
* ---------- ----------
* Falls nur ausgewählte Einträge eines bestimmten Attributes
* (untergeordnete Objekte, ...) gewünscht werden, dies berücksichtigen.
  IF i_sel_attribute <> '*'.
    DELETE lt_sel_object WHERE attribute <> i_sel_attribute.
  ENDIF.
* ---------- ---------- ----------
* Objekte setzen
  LOOP AT lt_sel_object INTO l_sel_object.
*   Anzeigeobjekt
    IF NOT l_sel_object-dspobj IS INITIAL.
      CLEAR: l_ish_object.
      l_ish_object-objectid  = '88'.
      l_ish_object-objectref = l_sel_object-dspobj.
      l_ish_object-objectlow = if_ish_list_display=>co_sel_dspobj.
      l_ish_object-objectset = l_objectset.
      INSERT l_ish_object INTO TABLE et_ish_object.
    ENDIF.
*   Erzeugendes Objekt
    IF NOT l_sel_object-object IS INITIAL.
      CLEAR: l_ish_object.
      l_ish_object-objectid  = '90'.
      l_ish_object-objectref = l_sel_object-object.
      l_ish_object-objectlow = if_ish_list_display=>co_sel_impobj.
      l_ish_object-objectset = l_objectset.
      INSERT l_ish_object INTO TABLE et_ish_object.
    ENDIF.
*   Subobjekt (Ankerleistung, Einzelleistung, ...)
    IF NOT l_sel_object-subobject IS INITIAL.
      CLEAR: l_ish_object.
      l_ish_object-objectid  = '91'.
      l_ish_object-objectref = l_sel_object-subobject.
      l_ish_object-objectlow = l_sel_object-attribute.
      l_ish_object-objectset = l_objectset.
      INSERT l_ish_object INTO TABLE et_ish_object.
    ENDIF.
*   Display-Klasse
    IF NOT l_sel_object-dspcls IS INITIAL.
      CLEAR: l_ish_object.
      l_ish_object-objectid  = '93'.
      l_ish_object-objectref = l_sel_object-dspcls.
      l_ish_object-objectlow = if_ish_list_display=>co_sel_dspcls.
      l_ish_object-objectset = l_objectset.
      INSERT l_ish_object INTO TABLE et_ish_object.
    ENDIF.
*   Laufende Satznummer
    CLEAR: l_ish_object.
    l_ish_object-objectid  = '99'.
    l_ish_object-objectlow = l_sel_object-seqno.
    l_ish_object-objectset = l_objectset.
    INSERT l_ish_object INTO TABLE et_ish_object.
*   ----- ----- -----
*   Externe Werte (Patient, Fall, ...) befüllen
    IF i_set_extern_values = on AND
       l_sel_object-attribute = if_ish_list_display=>co_sel_object.
*     (Vorläufiger) Patient und Fall ermitteln
      CLEAR:   l_object, l_npat, l_npap, l_nfal, l_ntmn, l_nbew.
      REFRESH: lt_object, lt_npat, lt_npap, lt_nfal, lt_ntmn, lt_nbew.
      l_object-object = l_sel_object-subobject.
      INSERT l_object INTO TABLE lt_object.
      CALL METHOD cl_ishmed_functions=>get_patients_and_cases
        EXPORTING
          it_objects     = lt_object
        IMPORTING
          e_rc           = e_rc
          et_nfal        = lt_nfal
          et_npat        = lt_npat
          et_npap        = lt_npap
        CHANGING
          c_errorhandler = c_errorhandler.
      IF e_rc = 0.
*       Patient
        READ TABLE lt_npat INTO l_npat INDEX 1.
        IF sy-subrc = 0.
          CLEAR: l_ish_object.
          l_ish_object-objectid     = '01'.
          l_ish_object-objectlow    = l_npat-patnr.
          l_ish_object-objectlow+10 = l_npat-pziff.
          l_ish_object-objectset    = l_objectset.
          INSERT l_ish_object INTO TABLE et_ish_object.
        ENDIF.
*       Vorläufiger Patient
        READ TABLE lt_npap INTO l_npap INDEX 1.
        IF sy-subrc = 0.
          CLEAR: l_ish_object.
          l_ish_object-objectid  = '16'.
          l_ish_object-objectlow = l_npap-papid.
          l_ish_object-objectset = l_objectset.
          INSERT l_ish_object INTO TABLE et_ish_object.
        ENDIF.
*       Fall
        READ TABLE lt_nfal INTO l_nfal INDEX 1.
        IF sy-subrc = 0.
          CLEAR: l_ish_object.
          l_ish_object-objectid     = '02'.
          l_ish_object-objectlow    = l_nfal-falnr.
          l_ish_object-objectlow+10 = l_nfal-fziff.
          l_ish_object-objectset    = l_objectset.
          INSERT l_ish_object INTO TABLE et_ish_object.
        ENDIF.
      ENDIF.
*     Termin und Bewegung ermitteln
      CALL METHOD cl_ishmed_functions=>get_apps_and_movs
        EXPORTING
          it_objects     = lt_object
        IMPORTING
          e_rc           = e_rc
          et_ntmn        = lt_ntmn
          et_nbew        = lt_nbew
        CHANGING
          c_errorhandler = c_errorhandler.
      IF e_rc = 0.
*       Termin
        READ TABLE lt_ntmn INTO l_ntmn INDEX 1.
        IF sy-subrc = 0.
          CLEAR: l_ish_object.
          l_ish_object-objectid  = '14'.
          l_ish_object-objectlow = l_ntmn-tmnid.
          l_ish_object-objectset = l_objectset.
          INSERT l_ish_object INTO TABLE et_ish_object.
* <<< MED-67520 Note 2624283 Bi
          IF l_ntmn-tmnoe IS NOT INITIAL.
            CLEAR: l_ish_object.
            l_ish_object-objectid  = '04'.
            l_ish_object-objectlow = l_ntmn-tmnoe.
            l_ish_object-objectset = l_objectset.
            INSERT l_ish_object INTO TABLE et_ish_object.
          ENDIF.
* >>> MED-67520 Note 2624283 Bi
        ENDIF.
*       Bewegung
        READ TABLE lt_nbew INTO l_nbew INDEX 1.
        IF sy-subrc = 0.
          CLEAR: l_ish_object.
          l_ish_object-objectid  = '03'.
          l_ish_object-objectlow = l_nbew-lfdnr.
          l_ish_object-objectset = l_objectset.
          INSERT l_ish_object INTO TABLE et_ish_object.
* <<< MED-67520 Note 2624283 Bi
          IF l_nbew-orgpf IS NOT INITIAL.
            CLEAR: l_ish_object.
            l_ish_object-objectid  = '04'.
            l_ish_object-objectlow = l_nbew-orgpf.
            l_ish_object-objectset = l_objectset.
            MODIFY TABLE et_ish_object FROM l_ish_object.
            IF sy-subrc EQ 4.
              INSERT l_ish_object INTO TABLE et_ish_object.
            ENDIF.
          ENDIF.
* >>> MED-67520 Note 2624283 Bi
        ENDIF.
      ENDIF.
    ENDIF.
*   ----- ----- -----
    l_objectset = l_objectset + 1.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.


METHOD merge_column .

* Hilfsfelder und -strukturen
  DATA:          l_merged_values        TYPE rn1display_fields,
                 l_rc                   TYPE ish_method_rc. "#EC NEEDED

* Datenreferenz
  DATA:          l_work_area            TYPE REF TO data,
                 l_last_field           TYPE REF TO data.
* Objekt-Instanz
  DATA:          l_object               TYPE REF TO object.
* Feldsymbole:
  FIELD-SYMBOLS: <l_outtab>             TYPE ANY,
                 <l_field>              TYPE ANY,
                 <l_last_field>         TYPE ANY,
*                 <l_last_outtab>        TYPE ANY,
                 <l_dspobj>             TYPE ANY,
                 <l_merge_field>        TYPE ANY.
* ---------- ---------- ----------
* Initialisierung
  CLEAR e_rc.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Workarea zur Ausgabetabelle definieren.
  CREATE DATA l_work_area LIKE LINE OF ct_outtab.
  ASSIGN l_work_area->* TO <l_outtab>.
* ---------- ---------- ----------
* Gewünschte Spalte bestimmen
  CHECK NOT i_fieldname IS INITIAL.
  ASSIGN COMPONENT i_fieldname OF STRUCTURE <l_outtab>
         TO <l_field>.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Assign für "Save"-Feld durchführen
  CREATE DATA l_last_field LIKE <l_field>.
  ASSIGN l_last_field->* TO <l_last_field>.
* ---------- ---------- ----------
* Ausgabetabelle für die gewünschte Spalte mergen
  LOOP AT ct_outtab INTO <l_outtab>.
*   ----------
*   Anzeigeobjekt bestimmen
    ASSIGN COMPONENT 'DSPOBJ' OF STRUCTURE <l_outtab>
           TO <l_dspobj>.
    IF sy-subrc <> 0.
      CONTINUE.
    ENDIF.
    l_object = <l_dspobj>.
*   ----------
    CALL METHOD l_object->('GET_MERGED_VALUES')
      IMPORTING
        e_outtab = l_merged_values
        e_rc     = l_rc.
    ASSIGN COMPONENT i_fieldname OF STRUCTURE l_merged_values
           TO <l_merge_field>.
    IF sy-subrc <> 0.
      CONTINUE.
    ENDIF.
*   ----------
    ASSIGN COMPONENT i_fieldname OF STRUCTURE <l_outtab>
           TO <l_field>.
    IF sy-subrc <> 0.
      CONTINUE.
    ENDIF.
*   ----------
*    ASSIGN COMPONENT i_fieldname OF STRUCTURE <l_last_outtab>
*           TO <l_last_field>.
*    IF sy-subrc <> 0.
*      CONTINUE.
*    ENDIF.
*    IF NOT <l_last_outtab> IS INITIAL.
*      IF NOT <l_merge_field> IS INITIAL.
*        <l_last_field> = <l_merge_field>.
*      ENDIF.
*    ENDIF.
*   ----------
    IF NOT <l_merge_field> IS INITIAL.
      IF <l_merge_field> = <l_last_field>.
        <l_last_field> = <l_merge_field>.
        CLEAR: <l_field>.
        MODIFY ct_outtab FROM <l_outtab>.
      ELSE.
        <l_last_field> = <l_field>.
      ENDIF.
    ELSE.
      IF <l_field> = <l_last_field>.
        <l_last_field> = <l_field>.
        CLEAR: <l_field>.
        MODIFY ct_outtab FROM <l_outtab>.
      ELSE.
        <l_last_field> = <l_field>.
      ENDIF.
    ENDIF.
  ENDLOOP.
* ---------- ---------- --------

ENDMETHOD.


METHOD prepare_outtab_for_sort .

* Lokale Typen
  TYPES:         BEGIN OF ty_dsp_sort,
                    dspobj             TYPE REF TO object,
                    sort_line          TYPE rn1display_fields,
                    no_merge_fields    TYPE ish_t_fieldname,
                 END   OF ty_dsp_sort,
                 tyt_dsp_sort          TYPE STANDARD TABLE OF
                                       ty_dsp_sort.
* Lokale Tabellen
  DATA:          lt_sort_detail        TYPE ishmed_t_display_sort_dyn,
                 lt_dsp_sort           TYPE tyt_dsp_sort.
* Workareas
  DATA:          l_sort_detail         LIKE LINE OF lt_sort_detail,
*                 l_object              TYPE ish_object,
                 l_dsp_sort            LIKE LINE OF lt_dsp_sort.
* Hilfsfelder und -strukturen
  DATA:          l_rc                  TYPE ish_method_rc,
                 l_empty               TYPE ish_on_off,
                 l_ddic_field          TYPE tabfield.
* Datenreferenz
  DATA:          l_work_area           TYPE REF TO data.
* Feldsymbole
  FIELD-SYMBOLS: <lt_outtab>           TYPE STANDARD TABLE,
                 <l_outtab>            TYPE ANY,
                 <l_field>             TYPE ANY,
                 <l_sort_field>        TYPE ANY,
                 <l_tmp_field>         TYPE ANY,
*                 <l_object>            TYPE ANY,
*                 <l_impobj>            TYPE ANY,
                 <l_dspobj>            TYPE ANY.

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Sortierung muss angegeben werden
  CHECK NOT i_sort IS INITIAL.
* ---------- ---------- ----------
  IF it_sort_detail[] IS INITIAL.
*   Details zur Sortierung ermitteln
    CALL METHOD cl_ish_display_tools=>get_sort_criteria
      EXPORTING
        i_sort         = i_sort
      IMPORTING
        et_sort_detail = lt_sort_detail
        e_rc           = l_rc
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ELSE.
*   Sortierkriterien für individuelle Sortierung übernehmen
    lt_sort_detail[] = it_sort_detail[].
  ENDIF.
* ---------- ---------- ----------
* Übernahme der Daten lt. Schnittstelle
  ASSIGN ct_outtab TO <lt_outtab>.
  <lt_outtab>      = ct_outtab.
  IF <lt_outtab>[] IS INITIAL.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Workarea zur Ausgabetabelle definieren.
  CREATE DATA l_work_area LIKE LINE OF ct_outtab.
  ASSIGN l_work_area->* TO <l_outtab>.
* ---------- ---------- ----------
  LOOP AT <lt_outtab> INTO <l_outtab>.
*   ---------- ----------
*   Anzeigeobjekt bestimmen
    ASSIGN COMPONENT 'DSPOBJ'
       OF STRUCTURE <l_outtab>
       TO <l_dspobj>.
    IF sy-subrc <> 0.
      CONTINUE.
    ENDIF.
*   ---------- ----------
    LOOP AT lt_sort_detail INTO l_sort_detail.
*     ---------- ----------
*     Feldinhalt bestimmen (der AUSGABETABELLE)
      ASSIGN COMPONENT l_sort_detail-fieldname
         OF STRUCTURE <l_outtab>
         TO <l_field>.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.
*     ---------- ----------
*     Falls für die Sortierung KEIN eigenes (Hilfs-) Feld
*     definiert wurde erfolgt die Sortierung nach dem
*     angegebenem Feld (FIELDNAME).
*     ----------
*     ACHTUNG: Sortierung kann nur korrekt erfolgen wenn
*     Feld nicht "gemerged" wird!
*     ----------
      IF l_sort_detail-sort_field IS INITIAL.
        l_sort_detail-sort_field = l_sort_detail-fieldname.
      ENDIF.
      ASSIGN COMPONENT l_sort_detail-sort_field
         OF STRUCTURE <l_outtab>
         TO <l_sort_field>.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.
*     ---------- ----------
*     Prüfen ob das entsprechende Feld INITIAL/LEER ist.
*     Schleifen-Durchlauf beenden wenn Wert für Sortierung
*     vorhanden ist.
      CLEAR: l_empty.
      l_ddic_field-tabname   = 'RN1DISPLAY_FIELDS'.
      l_ddic_field-fieldname = l_sort_detail-fieldname.
      CALL FUNCTION 'ISHMED_CHECK_FIELD_EMPTY'
        EXPORTING
          i_value      = <l_sort_field>
          i_ddic_field = l_ddic_field
        IMPORTING
          e_empty      = l_empty.
      IF l_empty = off.
        CONTINUE.
      ENDIF.
*     ---------- ----------
*     Feldinhalt für Sortierung bestimmen.
      READ TABLE lt_dsp_sort INTO l_dsp_sort
         WITH KEY dspobj = <l_dspobj>.
      IF sy-subrc <> 0.
        CLEAR: l_dsp_sort.
        l_dsp_sort-dspobj = <l_dspobj>.
        CALL METHOD l_dsp_sort-dspobj->('GET_MERGED_VALUES')
          IMPORTING
            e_outtab           = l_dsp_sort-sort_line
            et_no_merge_fields = l_dsp_sort-no_merge_fields
            e_rc               = l_rc
          CHANGING
            c_errorhandler     = c_errorhandler.
        IF l_rc = 0.
          INSERT l_dsp_sort INTO TABLE lt_dsp_sort.
        ELSE.
          CONTINUE.
        ENDIF.
      ENDIF.
*     ----------
*     Prüfen ob es sich um ein Feld handelt, welches gemerged
*     werden darf.
      READ TABLE l_dsp_sort-no_merge_fields TRANSPORTING NO FIELDS
         WITH KEY table_line = l_sort_detail-fieldname.
      IF sy-subrc = 0.
        CONTINUE.
      ENDIF.
*     ----------
*     Nun den korrekten Wert für die Sortierung in
*     entsprechends Feld übernehmen.
      ASSIGN COMPONENT l_sort_detail-fieldname
         OF STRUCTURE l_dsp_sort-sort_line
         TO <l_tmp_field>.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.
*     ----------
      <l_sort_field> = <l_tmp_field>.
*     ----------
    ENDLOOP.
    MODIFY <lt_outtab> FROM <l_outtab>.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.


METHOD refresh_data .

* Lokale Tabellen
  DATA:          lt_object          TYPE ish_objectlist.
* Workareas
  DATA:          l_object           LIKE LINE OF lt_object.
* Datenreferenz
  DATA:          l_work_area        TYPE REF TO data.
* Feldsymbole
  FIELD-SYMBOLS: <l_outtab>         TYPE ANY,
                 <l_impobj>         TYPE ANY.
* ---------- ---------- ----------
* Dieser Methode wird hier immer der gesamte Datenbestand übergeben,
* d.h. ...
* ... falls ein Objekt bereits in der Ausgabetabelle vorhanden ist,
*     dann muß hier nichts mehr getan werden.
* ... falls ein Objekt noch nicht in der Ausgabetabelle vorhanden ist,
*     dann muß hier eine neue Zeile (nur mit befülltem Übergabeobjekt
*     IMPOBJ) in die Ausgabetabelle eingefügt werden.
* ... und jene Ausgabetabellenzeilen, die nicht mehr im Datenbestand
*     vorhanden sind, müssen gelöscht werden.
* ---------- ---------- ----------
* Initialisierung
  CLEAR e_rc.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
  REFRESH: lt_object.
  lt_object[]   = it_object[].
* ---------- ---------- ----------
* Workarea zur Ausgabetabelle definieren.
  CREATE DATA l_work_area LIKE LINE OF ct_outtab.
  ASSIGN l_work_area->* TO <l_outtab>.
* ---------- ---------- ----------
  LOOP AT ct_outtab INTO <l_outtab>.
*   Benötigte Felder der OUTTAB in entsprechende Feldsymbole
*   übernehmen.
    ASSIGN COMPONENT 'IMPOBJ' OF STRUCTURE <l_outtab>
        TO <l_impobj>.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
      EXIT.
    ENDIF.
*   ----------
*   Prüfen, ob OO-Objekt bereits in Ausgabetabelle vorhanden ist
    READ TABLE it_object INTO l_object
               WITH KEY object = <l_impobj>.
    IF sy-subrc = 0.
*     OO-Objekt bereits in Ausgabetabelle vorhanden
      DELETE lt_object WHERE object = <l_impobj>.
    ELSE.
*     OO-Objekt NICHT in Ausgabetabelle vorhanden --> löschen!
      DELETE ct_outtab.
    ENDIF.
  ENDLOOP.
  IF e_rc <> 0.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Und nun noch NEUE Objekte in die Ausgabetabelle einfügen!
  LOOP AT lt_object INTO l_object.
    CLEAR <l_outtab>.
    ASSIGN COMPONENT 'IMPOBJ' OF STRUCTURE <l_outtab>
        TO <l_impobj>.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
      EXIT.
    ENDIF.
    <l_impobj> = l_object-object.
    INSERT <l_outtab> INTO TABLE ct_outtab.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.


METHOD REMOVE_DATA .

* Lokale Tabellen
* Workareas
  DATA:          l_object           LIKE LINE OF it_object. "#EC NEEDED
* Datenreferenz
  DATA:          l_work_area        TYPE REF TO data.
* Feldsymbole
  FIELD-SYMBOLS: <l_outtab>         TYPE ANY,
*                 <lt_outtab>        TYPE table,
*                 <l_field>          TYPE ANY,
                 <l_impobj>         TYPE ANY.
* ---------- ---------- ----------
* Übergebene Objekte werden aus der Ausgabetabelle entfernt.
* Erfolgt keine Übergabe von Objekten wird die gesamte Ausgabe=
* tabelle initialisiert.
* ---------- ---------- ----------
* Initialisierung
  CLEAR e_rc.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Workarea zur Ausgabetabelle definieren.
  CREATE DATA l_work_area LIKE LINE OF ct_outtab.
  ASSIGN l_work_area->* TO <l_outtab>.
* ---------- ---------- ----------
  IF it_object[] IS INITIAL.
    CLEAR: ct_outtab[].
  ELSE.
    LOOP AT ct_outtab INTO <l_outtab>.
*     Benötigte Felder der OUTTAB in entsprechende Feldsymbole
*     übernehmen.
      ASSIGN COMPONENT 'IMPOBJ' OF STRUCTURE <l_outtab>
         TO <l_impobj>.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
*     ----------
*     Prüfen, ob OO-Objekt bereits in Ausgabetabelle vorhanden ist
      READ TABLE it_object INTO l_object
                 WITH KEY object = <l_impobj>.
      IF sy-subrc = 0.
*       OO-Objekt bereits in Ausgabetabelle vorhanden
        DELETE ct_outtab FROM <l_outtab>.
      ENDIF.
    ENDLOOP.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD rework_fcat_for_sort.

  DATA: lt_sort            TYPE lvc_t_sort,
        ls_sort            TYPE lvc_s_sort.

  FIELD-SYMBOLS: <ls_fieldcat>  LIKE LINE OF ct_fieldcat.
  FIELD-SYMBOLS: <ls_sel_crit>  LIKE LINE OF it_selection_criteria.

* Feldkatalog temporär überarbeiten:
* Sortierfelder aus den Selektionskriterien ermitteln,
* denn diese Felder müssen (für die Sortierung) auch dann befüllt werden,
* wenn sie nicht angezeigt werden (MED-44243)

  REFRESH lt_sort.

  LOOP AT it_selection_criteria ASSIGNING <ls_sel_crit>.
    CASE <ls_sel_crit>-selname.
      WHEN 'P_NOPLAN'.
        IF <ls_sel_crit>-low = off.
          REFRESH lt_sort.
          EXIT.
        ENDIF.
      WHEN 'P_SOCOL1' OR 'P_SOCOL2' OR 'P_SOCOL3' OR
           'P_SOCOL4' OR 'P_SOCOL5' OR 'P_SOCOL6' OR 'P_SOCOL7'.
        IF NOT <ls_sel_crit>-low IS INITIAL.
          ls_sort-fieldname = <ls_sel_crit>-low.
          APPEND ls_sort TO lt_sort.
        ENDIF.
    ENDCASE.
  ENDLOOP.

  CHECK lt_sort[] IS NOT INITIAL.

  SORT lt_sort BY fieldname.

  LOOP AT ct_fieldcat ASSIGNING <ls_fieldcat> WHERE no_out = on.
    READ TABLE lt_sort INTO ls_sort
         WITH KEY fieldname = <ls_fieldcat>-fieldname BINARY SEARCH.
    CHECK sy-subrc = 0.
    <ls_fieldcat>-no_out = off.
    MODIFY ct_fieldcat FROM <ls_fieldcat>.
  ENDLOOP.

ENDMETHOD.


METHOD sort_outtab.

* Lokale Tabellen
  DATA:          lt_sort               TYPE lvc_t_sort,
                 lt_sort_object        TYPE ishmed_t_sort_object.
*                 lt_dsp_object         TYPE ish_objectlist,
*                 lt_outtab             TYPE ishmed_t_display_fields,
*                 lt_sort_outtab        TYPE ishmed_t_display_fields.
* Workareas
  DATA:          l_sort                LIKE LINE OF lt_sort,
                 l_sort_object         LIKE LINE OF lt_sort_object.
*                 l_object              TYPE ish_object,
*                 l_sort_outtab         LIKE LINE OF lt_outtab,
*                 l_outtab              LIKE LINE OF lt_outtab.
* Hilfsfelder und -strukturen
*  DATA:          l_rc                  TYPE ish_method_rc.
* Datenreferenz
  DATA:          l_work_area           TYPE REF TO data,
                 lt_copy_outtab        TYPE REF TO data.
* Feldsymbole
  FIELD-SYMBOLS: <lt_outtab>           TYPE STANDARD TABLE,
                 <lt_copy_outtab>      TYPE STANDARD TABLE,
                 <l_outtab>            TYPE ANY,
                 <l_field>             TYPE ANY,
*                 <l_dspobj>            TYPE ANY,
*                 <l_object>            TYPE ANY,
                 <l_impobj>            TYPE ANY.

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Übernahme der Daten lt. Schnittstelle
  lt_sort        = it_sort.
  lt_sort_object = it_sort_object.
  ASSIGN ct_outtab TO <lt_outtab>.
  <lt_outtab>      = ct_outtab.
  IF <lt_outtab>[] IS INITIAL.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Workarea zur Ausgabetabelle definieren.
  CREATE DATA l_work_area LIKE LINE OF ct_outtab.
  ASSIGN l_work_area->* TO <l_outtab>.
* Datenreferenz (KOPIE) ! der Ausgabetabelle
* erzeugen.
  CREATE DATA lt_copy_outtab LIKE ct_outtab.
  ASSIGN lt_copy_outtab->* TO <lt_copy_outtab>.
  <lt_copy_outtab> = ct_outtab.
* ---------- ---------- ----------
  READ TABLE <lt_outtab> INTO <l_outtab> INDEX 1.
  LOOP AT lt_sort INTO l_sort.
    ASSIGN COMPONENT l_sort-fieldname OF STRUCTURE <l_outtab>
       TO <l_field>.
    IF sy-subrc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
  ENDLOOP.
  IF NOT it_sort_object[] IS INITIAL.
    ASSIGN COMPONENT 'IMPOBJ' OF STRUCTURE <l_outtab>
       TO <l_impobj>.
    IF sy-subrc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
  ENDIF.
  IF e_rc <> 0.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
*  CLEAR: lt_sort_outtab[].
*  LOOP AT <lt_outtab> INTO <l_outtab>.
*    MOVE-CORRESPONDING <l_outtab> TO l_sort_outtab.
*    INSERT l_sort_outtab INTO TABLE lt_sort_outtab.
*  ENDLOOP.
* ---------- ---------- ----------
  IF NOT lt_sort[] IS INITIAL.
*   Sortierung anhand von Kriterien vornehmen.
    CALL FUNCTION 'LVC_SORT_APPLY'
      EXPORTING
        it_sort           = lt_sort
        i_as_text         = off                               "MED-31682
*       it_fieldcat       =
      TABLES
        ct_data           = ct_outtab.
*   ----------
  ELSEIF NOT lt_sort_object[] IS INITIAL.
*   Sortierung anhand von übergebenen Objektinstanzen vornehmen.
    CLEAR: ct_outtab[].
    SORT lt_sort_object BY sort ASCENDING.
    LOOP AT lt_sort_object INTO l_sort_object.
      LOOP AT <lt_copy_outtab> INTO <l_outtab>.
        ASSIGN COMPONENT 'IMPOBJ' OF STRUCTURE <l_outtab>
            TO <l_impobj>.
        IF sy-subrc <> 0.
          e_rc = 1.
          EXIT.
        ENDIF.
        IF <l_impobj> = l_sort_object-object.
          INSERT <l_outtab> INTO TABLE ct_outtab.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD sort_services .

  TYPES: BEGIN OF lty_sort,
           v_nlem          TYPE v_nlem,
           srv             TYPE REF TO cl_ishmed_service,
         END OF lty_sort,
         ltyt_sort         TYPE STANDARD TABLE OF lty_sort.

  DATA: lt_sort            TYPE ltyt_sort,
        l_sort             TYPE lty_sort,
        l_sort_field(40)   TYPE c,
        l_service          LIKE LINE OF ct_services,
        l_nlei             TYPE nlei,
        l_nlem             TYPE nlem,
        l_v_nlem           TYPE v_nlem.

  FIELD-SYMBOLS: <l_field> TYPE ANY.

  CLEAR e_rc.

  CLEAR l_v_nlem.

  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  DESCRIBE TABLE ct_services.
  CHECK sy-tfill > 0.

* check if sort field exists in NLEM or NLEI
  ASSIGN COMPONENT i_sort_field OF STRUCTURE l_v_nlem TO <l_field>.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* fill sort table with all service info
  LOOP AT ct_services INTO l_service.
    CALL METHOD l_service->get_data
      IMPORTING
        e_rc           = e_rc
        e_nlei         = l_nlei
        e_nlem         = l_nlem
      CHANGING
        c_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    CLEAR: l_v_nlem, l_sort.
    MOVE-CORRESPONDING l_nlei TO l_v_nlem.           "#EC ENHOK
    MOVE-CORRESPONDING l_nlem TO l_v_nlem.           "#EC ENHOK
    l_sort-v_nlem = l_v_nlem.
    l_sort-srv    = l_service.
    APPEND l_sort TO lt_sort.
  ENDLOOP.
  CHECK sy-subrc = 0.

* sort table by sort field
  CLEAR l_sort_field.
  CONCATENATE 'V_NLEM-' i_sort_field INTO l_sort_field.
  SORT lt_sort BY (l_sort_field).

* return sorted service table
  REFRESH ct_services.
  LOOP AT lt_sort INTO l_sort.
    l_service = l_sort-srv.
    APPEND l_service TO ct_services.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
