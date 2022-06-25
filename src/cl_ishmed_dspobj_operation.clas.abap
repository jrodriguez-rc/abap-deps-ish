class CL_ISHMED_DSPOBJ_OPERATION definition
  public
  final
  create public .

public section.
*"* public components of class CL_ISHMED_DSPOBJ_OPERATION
*"* do not include other source files here!!!
  type-pools ICON .

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_DISPLAY_OBJECT .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases G_NODE_OPEN
    for IF_ISH_DISPLAY_OBJECT~G_NODE_OPEN .
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
  aliases CLOSE_NODE
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

  constants CO_OTYPE_DSPOBJ_OPERATION type ISH_OBJECT_TYPE value 1000. "#EC NOTEXT

  methods GET_ANCHOR_SERVICE
    returning
      value(RR_SERVICE) type ref to CL_ISHMED_SERVICE .
  methods GET_AN_ANCHOR_SERVICE
    returning
      value(RR_SERVICE) type ref to CL_ISHMED_SERVICE .
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
  methods GET_T_TEAM
    returning
      value(RT_TEAM) type ISHMED_T_TEAM_OBJECT .
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
      NO_OPERATION .
  methods GET_DATA_DETAIL
    exporting
      value(E_ERBOE) type N1WP11ERBOE
      value(E_ANPOE) type N1WP11ANPOE
      value(E_ANFOE) type N1WP11ANFOE .
  class-methods GET_NO_MERGED_FIELDS
    exporting
      value(ET_NO_MERGE_FIELDS) type ISH_T_FIELDNAME .
  methods SET_PATIENTS_ANONYM
    importing
      value(I_ANONYM) type ISH_ON_OFF .
  methods SET_TEAM_AUFGABEN
    importing
      !IT_AUFG1 type ISHMED_T_VORGANG optional
      !IT_AUFG2 type ISHMED_T_VORGANG optional
      !IT_AUFG3 type ISHMED_T_VORGANG optional
      !IT_AUFG4 type ISHMED_T_VORGANG optional .
  methods SET_NDIA
    importing
      !IT_NDIA type ISH_T_NDIA .
protected section.
*"* protected components of class CL_ISHMED_DSPOBJ_OPERATION
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
  data GT_NDIA type ISH_T_NDIA .
private section.
*"* private components of class CL_ISHMED_DSPOBJ_OPERATION
*"* do not include other source files here!!!

  data G_NOSAVE type ISH_ON_OFF .
  data GT_AUFG1 type ISHMED_T_VORGANG .
  data GT_AUFG2 type ISHMED_T_VORGANG .
  data GT_AUFG3 type ISHMED_T_VORGANG .
  data GT_AUFG4 type ISHMED_T_VORGANG .
  data GT_SERVICES type ISHMED_T_SERVICE_OBJECT .
  data GT_TEAM type ISHMED_T_TEAM_OBJECT .
  data G_ANCHOR_SERVICE type N1SERVICE_OBJECT .
  data G_ANFOE type N1WP11ANFOE .
  data G_ANONYM type ISH_ON_OFF .
  data G_ANPOE type N1WP11ANPOE .
  data G_AN_ANCHOR_SERVICE type N1SERVICE_OBJECT .
  data G_APPOINTMENT type N1APPOINTMENT_OBJECT .
  data G_ERBOE type N1WP11ERBOE .
  data G_MOVEMENT type N1NONE_OO_NBEW_OBJECT .
  data G_PREREG type N1PREREG_OBJECT .
  data G_REQUEST type N1REQUEST_OBJECT .
ENDCLASS.



CLASS CL_ISHMED_DSPOBJ_OPERATION IMPLEMENTATION.


METHOD constructor .

  DATA: l_rc          TYPE sy-subrc,
        l_environment TYPE REF TO cl_ish_environment.

* Die Instanz nur anlegen, wenn der Constructor aus der Methode
* CREATE aufgerufen wird. Direkte Aufrufe des Constructors dürfen
* nicht möglich sein
  IF g_construct = off.
    RAISE instance_not_possible.
  ENDIF.

* Alle globalen Datenstrukturen initialisieren
  CALL METHOD me->initialize.

* Notwendige Übergabedaten prüfen
  IF i_object IS INITIAL.
    RAISE instance_not_possible.
  ENDIF.
  IF i_environment IS INITIAL.
    RAISE instance_not_possible.
  ELSE.
    l_environment = i_environment.
  ENDIF.

  g_cancelled_data = i_cancelled_data.

* Prüfen, ob das Objekt überhaupt eine OPERATION ist
  CALL METHOD me->set_main_data
    EXPORTING
      i_object         = i_object
      i_check_only     = i_check_only
    IMPORTING
      e_rc             = l_rc
    CHANGING
      c_environment    = l_environment.
*      C_ERRORHANDLER =

  CASE l_rc.
    WHEN 0.
*     OK -> Objekt ist eine Operation
      g_object    = i_object.
      g_node_open = i_node_open.
    WHEN 99.
*     Objekt ist keine Operation (wohl aber ein Termin oder Bew.)
      RAISE no_operation.            " Keine OP-Bewegung/Termin
    WHEN OTHERS.
*     Fehler
      RAISE instance_not_possible.
  ENDCASE.

ENDMETHOD.


METHOD get_anchor_service.
  rr_service = g_anchor_service.
ENDMETHOD.


METHOD get_an_anchor_service.
  rr_service = g_an_anchor_service.
ENDMETHOD.


METHOD get_appointment.
  rr_appointment = g_appointment.
ENDMETHOD.


METHOD get_data_detail .

* Operierende OE
  e_erboe = g_erboe.

* Anf. OE pfleg.
  e_anpoe = g_anpoe.

* Anf. OE fachl.
  e_anfoe = g_anfoe.

ENDMETHOD.


METHOD get_movement.
  rr_movement = gr_movement.
ENDMETHOD.


METHOD get_no_merged_fields .


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


METHOD get_t_team.
  rt_team = gt_team.
ENDMETHOD.


METHOD if_ish_display_object~close_node .

  clear e_rc.

* Errorhandler instanzieren, falls nötig
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  g_node_open = off.

  CALL METHOD me->convert_for_display
    EXPORTING
      it_fieldcat    = it_fieldcat
    IMPORTING
      ET_OUTTAB      = et_outtab
      E_RC           = e_rc
    CHANGING
      C_ERRORHANDLER = c_errorhandler.

ENDMETHOD.


METHOD if_ish_display_object~convert_for_display .

  TYPES: BEGIN OF ty_team,
           team      TYPE n1lsteam,
           obj       TYPE REF TO cl_ishmed_team,
         END OF ty_team.

  DATA: lt_outtab          LIKE et_outtab,
        l_outtab           LIKE LINE OF lt_outtab,
        l_outtab_all       LIKE LINE OF lt_outtab,
        ls_sel_crit        LIKE LINE OF it_selection_criteria,
        l_icon             TYPE nwicons-icon,
        lt_napp            TYPE ish_t_napp,
        l_napp             LIKE LINE OF lt_napp,
        l_ntmn             TYPE ntmn,
        l_nbew             TYPE nbew,
        l_n1anf            TYPE n1anf,
        l_n1vkg            TYPE n1vkg,
        l_a_nlei           TYPE nlei,
        l_a_nlem           TYPE nlem,
        l_afn_ntmn         TYPE vntmn,
*        lt_afn_napp        TYPE ishmed_t_vnapp,
        l_icon_image       TYPE tv_image,
        l_cnt              TYPE i,
        l_place_holder(1)  TYPE c VALUE '-',
        l_dialo_exists     TYPE ish_on_off,
        l_released         TYPE ish_on_off,
        ls_n1applan        TYPE n1applan,
        l_most_lines(1)    TYPE c,
        l_rc               TYPE sy-subrc,
        l_apri             TYPE n1apri-apri,
        l_aprie            TYPE n1aprie,
        l_apritxt          TYPE n1apritxt,
        l_dsp_team         TYPE ish_on_off,
        l_dsp_ztmk         TYPE ish_on_off,
        l_dsp_vma          TYPE ish_on_off,
        l_dsp_afn          TYPE ish_on_off,
        l_dsp_anfv         TYPE ish_on_off,
        l_dsp_n1ptint      TYPE ish_on_off,
        l_dsp_context      TYPE ish_on_off,
        l_dsp_modcomment   TYPE ish_on_off,
        l_dsp_released     TYPE ish_on_off,
        l_dsp_kurz         TYPE ish_on_off,
        l_dsp_prgs_end     TYPE ish_on_off,
        l_cx_object        TYPE rn1_cx_objects,
        l_cx_key           TYPE string,
        lt_context         TYPE ish_t_context,
        l_context          LIKE LINE OF lt_context,
        lt_n1anmsz         TYPE STANDARD TABLE OF n1anmsz,
        l_n1anmsz          LIKE LINE OF lt_n1anmsz,
        l_gpart            TYPE ngpa-gpart,
        l_ifge             TYPE n1ifg-ifge,
        l_ifgicon          TYPE n1ifg-icon,
        l_ifgtxt           TYPE n1ifgt-ifgtxt,
        l_lin_srv          TYPE i,
        l_lin_team         TYPE i,
        l_lin_diag         TYPE i,
        l_lin_aufg1        TYPE i,
        l_lin_aufg2        TYPE i,
        l_lin_aufg3        TYPE i,
        l_lin_aufg4        TYPE i,
        l_lin_team1        TYPE i,
        l_lin_team2        TYPE i,
        l_lin_team3        TYPE i,
        l_lin_team4        TYPE i,
        lt_n1lsteam        TYPE TABLE OF ty_team,
        l_n1lsteam         LIKE LINE OF lt_n1lsteam,
        l_team_data        TYPE n1lsteam,
        lt_opteam          TYPE TABLE OF rn1op_team,
        lt_opteam1         TYPE TABLE OF rn1op_team,
        lt_opteam2         TYPE TABLE OF rn1op_team,
        lt_opteam3         TYPE TABLE OF rn1op_team,
        lt_opteam4         TYPE TABLE OF rn1op_team,
        l_opteam           LIKE LINE OF lt_opteam,
        l_opteam1          LIKE LINE OF lt_opteam,
        l_opteam2          LIKE LINE OF lt_opteam,
        l_opteam3          LIKE LINE OF lt_opteam,
        l_opteam4          LIKE LINE OF lt_opteam,
        lt_diag            TYPE ishmed_t_diag,
        l_diag             LIKE LINE OF lt_diag,
*        lt_diagnosis       TYPE ish_objectlist,
*        ls_object          LIKE LINE OF lt_diagnosis,
*        lr_diagnosis       TYPE REF TO cl_ish_prereg_diagnosis,
*        ls_data_diag       TYPE rndip_attrib,
*        l_dtext1           TYPE nkdi-dtext1,
*        l_n2opdia          TYPE n2opdiagnosen,
*        lt_tline           TYPE ish_t_textmodule_tline,
*        l_tline            TYPE tline,
*        lt_ndia            TYPE STANDARD TABLE OF ndia,
*        l_ndia             TYPE ndia,
*        lt_dia             TYPE STANDARD TABLE OF rndi1,
*        l_dia              TYPE rndi1,
        l_aufg             LIKE LINE OF gt_aufg1,
        l_found            TYPE ish_on_off,
        l_op_beg           TYPE ish_on_off,
        l_service          LIKE LINE OF gt_services,
        l_team             LIKE LINE OF gt_team,
        lt_cordpos_adm     TYPE ish_t_cordpos,
        lr_cordpos_adm     LIKE LINE OF lt_cordpos_adm,
        ls_nbew_adm        TYPE nbew,
        lt_zeiten          TYPE STANDARD TABLE OF rn2zeiten,
        l_zeiten           LIKE LINE OF lt_zeiten,
        lt_natm            TYPE ishmed_t_vnatm,
        l_natm             LIKE LINE OF lt_natm,
        lt_pobnr_date      TYPE ishmed_t_pobnr_date,
        ls_pobnr_date      LIKE LINE OF lt_pobnr_date,
        lt_pobdc           TYPE ishmed_t_pobdc_by_pobnr_date,
        ls_pobdc           LIKE LINE OF lt_pobdc,
        lr_pobdc           TYPE REF TO cl_ishmed_pobdc,
        l_modcomment_cnt   TYPE i,
        l_modcomment_found TYPE ish_on_off,
        l_pap              TYPE REF TO cl_ish_patient_provisional,
        l_corder           TYPE REF TO cl_ish_corder,
        l_app_constr       TYPE REF TO cl_ish_app_constraint,
        l_n1corder         TYPE n1corder,
        l_n1apcn           TYPE n1apcn,
        l_pobnr            TYPE ish_pobnr,
        l_prgs_dauer       TYPE ish_tmdauer,
        l_prgs_date        TYPE sy-datum,
        l_prgs_time        TYPE sy-uzeit,
        lr_zpber           TYPE RANGE OF n2ztpdef-zpber,
        l_zpber            LIKE LINE OF lr_zpber.

  data: l_instance         type ref to cl_ishmed_none_oo_nfal,  "MED-51267 NedaV
        l_nfal             type nfal.                           "MED-51267 NedaV

*Sta/PN/MED-40483
  DATA: lt_rn2ztpdef       TYPE TABLE OF rn2ztpdef,
        lt_srgtimes        TYPE ishmed_t_srgtimes.
  DATA: ls_n2zeiten        TYPE n2zeiten.

  FIELD-SYMBOLS:
        <ls_rn2ztpdef>     LIKE LINE OF lt_rn2ztpdef,
        <ls_srgtimes>      LIKE LINE OF lt_srgtimes.
*End/PN/MED-40483

  DATA: lt_text TYPE STANDARD TABLE OF text132,    "MED-60929 AGujev
        ls_text TYPE text132,                      "MED-60929 AGujev
        l_besond_string TYPE string,               "MED-60929 AGujev
        lt_tline    TYPE ish_t_textmodule_tline,   "MED-60929 AGujev
        l_tline                 TYPE tline,        "MED-60929 AGujev
        l_besond_string_short TYPE n1corder-rmcord,          "MED-65136 Madalina P.
        l_length_longtext     TYPE int2,                     "MED-65136 Madalina P.
        l_length_besond       TYPE int2,                     "MED-65136 Madalina P.
        l_lines               TYPE int2,                     "MED-65136 Madalina P.
        l_length_dictionary   TYPE int2,                     "MED-65852 Madalina P.
        lr_elem_descr         TYPE REF TO cl_abap_elemdescr. "MED-65852 Madalina P.


  FIELD-SYMBOLS: <ls_fieldcat>  LIKE LINE OF it_fieldcat.

  CLEAR e_rc.
  REFRESH et_outtab.
  REFRESH lt_outtab.
  REFRESH gt_outtab.

  REFRESH: lt_napp, lt_n1lsteam, lt_opteam, lt_diag, lt_zeiten,
           lt_opteam1, lt_opteam2, lt_opteam3, lt_opteam4.
  CLEAR: l_napp, l_ntmn, l_nbew, l_a_nlei, l_a_nlem,
         l_n1lsteam, l_n1anf, l_n1vkg, l_n1corder,
         l_n1apcn, l_app_constr.
  CLEAR: l_cnt, l_lin_srv, l_lin_team, l_lin_diag, l_icon_image,
         l_pobnr, l_prgs_dauer, l_prgs_date, l_prgs_time.

* Errorhandler instanzieren, falls nötig
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Grundlegende OP-Daten lesen
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Anzuzeigende Daten anhand des Feldkatalogs bestimmen  * * * * * * *
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  CLEAR: l_dsp_team, l_dsp_ztmk, l_dsp_afn, l_dsp_n1ptint, l_dsp_anfv,
         l_dsp_vma, l_dsp_context, l_dsp_modcomment, l_dsp_released,
         l_dsp_kurz, l_dsp_prgs_end.
  LOOP AT it_fieldcat ASSIGNING <ls_fieldcat> WHERE no_out = off.
    CASE <ls_fieldcat>-fieldname.
      WHEN 'TEAM1' OR 'TEAM1_KURZ' OR 'TEAM2' OR 'TEAM2_KURZ' OR
           'TEAM3' OR 'TEAM3_KURZ' OR 'TEAM4' OR 'TEAM4_KURZ'.
        l_dsp_team = on.
      WHEN 'VMA'.
        l_dsp_vma = on.
      WHEN 'ANFV_ICON'.
        l_dsp_anfv = on.
      WHEN 'ZTMK_BEZ' OR 'ZTMK_ZEIT'.
        l_dsp_ztmk = on.
      WHEN 'AFNOE' OR 'AFNDT' OR 'AFNZT'.
        l_dsp_afn = on.
      WHEN 'N1PTINT'.
        l_dsp_n1ptint = on.
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
      WHEN 'PRGS_TIME_END'.                                 " MED-41209
        l_dsp_prgs_end = on.                                " MED-41209
    ENDCASE.
  ENDLOOP.

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* OP-Team-Aufgaben für Spaltenbefüllung aufbereiten * * * * * * * * *
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

* ID 17973: select team data for BADI (if active)
  IF l_dsp_team = off.
    CALL FUNCTION 'SXC_EXIT_CHECK_ACTIVE'
      EXPORTING
        exit_name  = 'N1_WP_OP'
      EXCEPTIONS
        not_active = 1.
    IF sy-subrc = 0.
      l_dsp_team = on.
    ENDIF.
  ENDIF.

  IF l_dsp_team = on.
    DESCRIBE TABLE gt_aufg1 LINES l_lin_aufg1.
    DESCRIBE TABLE gt_aufg2 LINES l_lin_aufg2.
    DESCRIBE TABLE gt_aufg3 LINES l_lin_aufg3.
    DESCRIBE TABLE gt_aufg4 LINES l_lin_aufg4.

    IF l_lin_aufg1 = 0 AND l_lin_aufg2 = 0 AND
       l_lin_aufg3 = 0 AND l_lin_aufg4 = 0.
*     Wenn keine Aufgaben für die Spalten definiert wurden,
*     dann alle Team-Mitarbeiter in die 1. Teamspalte stellen
*     MED-31642: Begin of INSERT
      LOOP AT gt_team INTO l_team.
        CALL METHOD l_team->get_data
          IMPORTING
            e_rc           = e_rc
            e_n1lsteam     = l_team_data
          CHANGING
            c_errorhandler = c_errorhandler.
        IF e_rc <> 0.
          EXIT.
        ENDIF.
        CHECK NOT l_team_data-gpart IS INITIAL OR
              NOT l_team_data-name1 IS INITIAL.
        CLEAR l_n1lsteam.
        l_n1lsteam-team = l_team_data.
        l_n1lsteam-obj  = l_team.
        APPEND l_n1lsteam TO lt_n1lsteam.
      ENDLOOP.
      CHECK e_rc = 0.
      SORT lt_n1lsteam BY team-znr.
      LOOP AT lt_n1lsteam INTO l_n1lsteam.
        CLEAR l_opteam.
        CALL METHOD cl_ishmed_team=>build_one_team_name
          EXPORTING
            i_team      = l_n1lsteam-obj
          IMPORTING
            e_longname  = l_opteam-team1
            e_shortname = l_opteam-team1_kurz.
        CHECK NOT l_opteam-team1      IS INITIAL OR
              NOT l_opteam-team1_kurz IS INITIAL.
        APPEND l_opteam TO lt_opteam.
      ENDLOOP.
*     MED-31642: End of INSERT
*     MED-31642: Begin of DELETE
*      LOOP AT gt_team INTO l_team.
*        CLEAR l_opteam.
*        CALL METHOD cl_ishmed_team=>build_one_team_name
*          EXPORTING
*            i_team      = l_team
*          IMPORTING
*            e_longname  = l_opteam-team1
*            e_shortname = l_opteam-team1_kurz.
*        CHECK NOT l_opteam-team1      IS INITIAL OR
*              NOT l_opteam-team1_kurz IS INITIAL.
*        APPEND l_opteam TO lt_opteam.
*      ENDLOOP.
*     MED-31642: End of DELETE
    ELSE.
*     Daten der Teamsätze holen
      LOOP AT gt_team INTO l_team.
        CALL METHOD l_team->get_data
          IMPORTING
            e_rc           = e_rc
            e_n1lsteam     = l_team_data
          CHANGING
            c_errorhandler = c_errorhandler.
        IF e_rc <> 0.
          EXIT.
        ENDIF.
        CHECK NOT l_team_data-gpart IS INITIAL OR
              NOT l_team_data-name1 IS INITIAL.
        CLEAR l_n1lsteam.
        l_n1lsteam-team = l_team_data.
        l_n1lsteam-obj  = l_team.
        APPEND l_n1lsteam TO lt_n1lsteam.
      ENDLOOP.
      CHECK e_rc = 0.
"      SORT lt_n1lsteam BY team-vorgang.           "MED-55293 Madalina P. If multiple entries of the same type (vorgang), then those entries should be sorted by znr in the team column
       SORT lt_n1lsteam BY team-vorgang team-znr.  "MED-55293 Madalina P.
*     1. Teamspalte befüllen
      IF l_lin_aufg1 > 0.
        LOOP AT gt_aufg1 INTO l_aufg.
          l_found = off.
          LOOP AT lt_n1lsteam INTO l_n1lsteam
               WHERE team-vorgang = l_aufg.
            l_found = on.
            CLEAR l_opteam.
            CALL METHOD cl_ishmed_team=>build_one_team_name
              EXPORTING
                i_team      = l_n1lsteam-obj
              IMPORTING
                e_longname  = l_opteam-team1
                e_shortname = l_opteam-team1_kurz.
            CHECK NOT l_opteam-team1      IS INITIAL OR
                  NOT l_opteam-team1_kurz IS INITIAL.
            APPEND l_opteam TO lt_opteam1.
          ENDLOOP.
          IF l_found = off.
            l_opteam-team1_kurz = '??'.
            l_opteam-team1      = '??'.
            APPEND l_opteam TO lt_opteam1.
          ENDIF.
        ENDLOOP.
      ENDIF.
*     2. Teamspalte befüllen
      IF l_lin_aufg2 > 0.
        LOOP AT gt_aufg2 INTO l_aufg.
          l_found = off.
          LOOP AT lt_n1lsteam INTO l_n1lsteam
               WHERE team-vorgang = l_aufg.
            l_found = on.
            CLEAR l_opteam.
            CALL METHOD cl_ishmed_team=>build_one_team_name
              EXPORTING
                i_team      = l_n1lsteam-obj
              IMPORTING
                e_longname  = l_opteam-team2
                e_shortname = l_opteam-team2_kurz.
            CHECK NOT l_opteam-team2      IS INITIAL OR
                  NOT l_opteam-team2_kurz IS INITIAL.
            APPEND l_opteam TO lt_opteam2.
          ENDLOOP.
          IF l_found = off.
            l_opteam-team2_kurz = '??'.
            l_opteam-team2      = '??'.
            APPEND l_opteam TO lt_opteam2.
          ENDIF.
        ENDLOOP.
      ENDIF.
*     3. Teamspalte befüllen
      IF l_lin_aufg3 > 0.
        LOOP AT gt_aufg3 INTO l_aufg.
          l_found = off.
          LOOP AT lt_n1lsteam INTO l_n1lsteam
               WHERE team-vorgang = l_aufg.
            l_found = on.
            CLEAR l_opteam.
            CALL METHOD cl_ishmed_team=>build_one_team_name
              EXPORTING
                i_team      = l_n1lsteam-obj
              IMPORTING
                e_longname  = l_opteam-team3
                e_shortname = l_opteam-team3_kurz.
            CHECK NOT l_opteam-team3      IS INITIAL OR
                  NOT l_opteam-team3_kurz IS INITIAL.
            APPEND l_opteam TO lt_opteam3.
          ENDLOOP.
          IF l_found = off.
            l_opteam-team3_kurz = '??'.
            l_opteam-team3      = '??'.
            APPEND l_opteam TO lt_opteam3.
          ENDIF.
        ENDLOOP.
      ENDIF.
*     4. Teamspalte befüllen
      IF l_lin_aufg4 > 0.
        LOOP AT gt_aufg4 INTO l_aufg.
          l_found = off.
          LOOP AT lt_n1lsteam INTO l_n1lsteam
               WHERE team-vorgang = l_aufg.
            l_found = on.
            CLEAR l_opteam.
            CALL METHOD cl_ishmed_team=>build_one_team_name
              EXPORTING
                i_team      = l_n1lsteam-obj
              IMPORTING
                e_longname  = l_opteam-team4
                e_shortname = l_opteam-team4_kurz.
            CHECK NOT l_opteam-team4      IS INITIAL OR
                  NOT l_opteam-team4_kurz IS INITIAL.
            APPEND l_opteam TO lt_opteam4.
          ENDLOOP.
          IF l_found = off.
            l_opteam-team4_kurz = '??'.
            l_opteam-team4      = '??'.
            APPEND l_opteam TO lt_opteam4.
          ENDIF.
        ENDLOOP.
      ENDIF.
*     Nun die 4 Tabellen in eine einzige gesamte Teamtabelle vereinigen
      DESCRIBE TABLE lt_opteam1 LINES l_lin_team1.
      DESCRIBE TABLE lt_opteam2 LINES l_lin_team2.
      DESCRIBE TABLE lt_opteam3 LINES l_lin_team3.
      DESCRIBE TABLE lt_opteam4 LINES l_lin_team4.
      CLEAR l_cnt.
      DO.
        CLEAR l_opteam.
        l_cnt = l_cnt + 1.
        IF l_cnt > l_lin_team1 AND l_cnt > l_lin_team2 AND
           l_cnt > l_lin_team3 AND l_cnt > l_lin_team4.
          EXIT.
        ENDIF.
        IF l_lin_team1 >= l_cnt.
          READ TABLE lt_opteam1 INTO l_opteam1 INDEX l_cnt.
          IF sy-subrc = 0.
            l_opteam-team1_kurz = l_opteam1-team1_kurz.
            l_opteam-team1      = l_opteam1-team1.
          ENDIF.
        ENDIF.
        IF l_lin_team2 >= l_cnt.
          READ TABLE lt_opteam2 INTO l_opteam2 INDEX l_cnt.
          IF sy-subrc = 0.
            l_opteam-team2_kurz = l_opteam2-team2_kurz.
            l_opteam-team2      = l_opteam2-team2.
          ENDIF.
        ENDIF.
        IF l_lin_team3 >= l_cnt.
          READ TABLE lt_opteam3 INTO l_opteam3 INDEX l_cnt.
          IF sy-subrc = 0.
            l_opteam-team3_kurz = l_opteam3-team3_kurz.
            l_opteam-team3      = l_opteam3-team3.
          ENDIF.
        ENDIF.
        IF l_lin_team4 >= l_cnt.
          READ TABLE lt_opteam4 INTO l_opteam4 INDEX l_cnt.
          IF sy-subrc = 0.
            l_opteam-team4_kurz = l_opteam4-team4_kurz.
            l_opteam-team4      = l_opteam4-team4.
          ENDIF.
        ENDIF.
        APPEND l_opteam TO lt_opteam.
      ENDDO.
    ENDIF.
  ENDIF.

  CLEAR l_cnt.

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Alle Daten holen
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

* Daten der OP-Ankerleistung lesen
  IF NOT g_anchor_service IS INITIAL.
    CALL METHOD g_anchor_service->get_data
      IMPORTING
        e_rc           = e_rc
        e_nlei         = l_a_nlei
        e_nlem         = l_a_nlem
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    IF l_a_nlem-patnr IS INITIAL.                           "MED-40483
*     Patienten mit vorl. Stammdaten ermitteln.
      CALL METHOD cl_ishmed_service=>get_patient_provi
        EXPORTING
          i_service          = g_anchor_service
          i_environment      = g_environment
          i_read_over_prereg = on
        IMPORTING
          e_pat_provi        = l_pap
          e_rc               = e_rc
        CHANGING
          c_errorhandler     = c_errorhandler.
      CHECK e_rc = 0.
    ENDIF.                                                  "MED-40483
  ENDIF.
* Daten der OP-Bewegung lesen
* START MED-40483 2010/07/07
  IF gr_movement IS NOT INITIAL.
    CALL METHOD gr_movement->get_data
*      EXPORTING
*        i_fill_mvmt    = SPACE
      IMPORTING
        e_rc           = e_rc
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
        e_rc           = e_rc
        e_nbew         = l_nbew
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
  ENDIF.
* Daten des OP-Termins lesen
  IF NOT g_appointment IS INITIAL.
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
    IF l_ntmn-patnr IS INITIAL AND l_pap IS INITIAL.        "MED-40483
*     Patienten mit vorl. Stammdaten ermitteln.
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
    ENDIF.                                                  "MED-40483
  ENDIF.

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

* Anforderungsdaten- bzw. Daten der Klinischen Auftragsposition lesen
  IF NOT g_request IS INITIAL.
*   Anforderung ------------------------------------------------------
    CALL METHOD g_request->get_data
      IMPORTING
        e_rc           = e_rc
        e_n1anf        = l_n1anf
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
  ELSEIF NOT g_prereg IS INITIAL.
*   Klinische Auftragsposition (ehemals Vormerkung)--------------------
    CALL METHOD g_prereg->get_data
      IMPORTING
        e_rc           = e_rc
        e_n1vkg        = l_n1vkg
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
*   Terminvorgabe (falls noch kein Termin vorhanden ist)
*    IF g_appointment IS INITIAL.                       " REM MED-32767
    CALL METHOD g_prereg->get_app_constraint
      EXPORTING
        i_cancelled_datas = g_cancelled_data
        ir_environment    = g_environment
      IMPORTING
        er_app_constraint = l_app_constr
        e_rc              = e_rc
      CHANGING
        cr_errorhandler   = c_errorhandler.
    CHECK e_rc = 0.
    IF NOT l_app_constr IS INITIAL.
      CALL METHOD l_app_constr->get_data
        IMPORTING
          e_rc            = e_rc
          es_n1apcn       = l_n1apcn
        CHANGING
          cr_errorhandler = c_errorhandler.
      CHECK e_rc = 0.
    ENDIF.
*    ENDIF.                                             " REM MED-32767
  ENDIF.

* Diagnosen ermitteln
  CALL METHOD cl_ishmed_utl_op=>get_op_diag
    EXPORTING
      ir_service      = g_anchor_service
*     START MED-40483 2010/07/07 HP
      ir_corder       = l_corder
      ir_request      = g_request
      it_dia_mov      = gt_ndia
*     END MED-40483
    IMPORTING
      et_diag         = lt_diag
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Felder für alle Zeilen der OP befüllen
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* (das sind vor allem technische Felder, denn 'sichtbare' Felder
* sollen in den 'Folgezeilen' der OP meist nicht erneut angezeigt
* werden)
  CLEAR l_outtab_all.

* Erzeugendes Objekt (Termin, Anforderung, Klin. Auftragsposition, ...)
  l_outtab_all-impobj = g_object.

* Anzeigeobjekt selbst
  l_outtab_all-dspobj = me.

* Identifier (Objekt) / Einrichtung / Interner Schlüssel (für Sort)
  IF NOT g_anchor_service IS INITIAL.
    l_outtab_all-object   = g_anchor_service.
    l_outtab_all-einri    = l_a_nlei-einri.
    l_outtab_all-keyno    = 'ANK'.
    l_outtab_all-keyno+3  = l_a_nlei-lnrls.
  ELSEIF NOT g_appointment IS INITIAL.
    l_outtab_all-object   = g_appointment.
    l_outtab_all-einri    = l_ntmn-einri.
    l_outtab_all-keyno    = 'TMN'.
    l_outtab_all-keyno+3  = l_ntmn-tmnid.
  ELSEIF NOT g_movement IS INITIAL.
    l_outtab_all-object   = g_movement.
    l_outtab_all-einri    = l_nbew-einri.
    l_outtab_all-keyno    = 'BEW'.
    l_outtab_all-keyno+3  = l_nbew-falnr.
    l_outtab_all-keyno+13 = l_nbew-lfdnr.
* START MED-40483 2010/07/07
  ELSEIF NOT gr_movement IS INITIAL.
    l_outtab_all-object   = gr_movement.
    l_outtab_all-einri    = l_nbew-einri.
    l_outtab_all-keyno    = 'BEW'.
    l_outtab_all-keyno+3  = l_nbew-falnr.
    l_outtab_all-keyno+13 = l_nbew-lfdnr.
* END MED-40483
  ENDIF.

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* 1. OP-Zeile befüllen
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  CLEAR l_outtab.
  l_outtab = l_outtab_all.

* OP begonnen?
  IF NOT g_anchor_service IS INITIAL.
    CALL FUNCTION 'ISHMED_CHECK_OP_BEGONNEN'
      EXPORTING
        i_einri  = l_outtab-einri
        i_anklei = l_a_nlei-lnrls
        i_nlei   = l_a_nlei
        i_nlem   = l_a_nlem
        i_nbew   = l_nbew
      IMPORTING
        e_op_beg = l_op_beg.
  ELSE.
*   Not-OP ohne Ankerleistung ist nie begonnen
    l_op_beg = off.
  ENDIF.
  IF l_op_beg = on.
    CALL METHOD cl_ish_display_tools=>get_wp_icon
      EXPORTING
        i_einri     = l_outtab-einri
        i_indicator = '086'             " OP begonnen
      IMPORTING
        e_icon      = l_icon.
    l_outtab-opbeg = l_icon.
  ELSE.
    CALL METHOD cl_ish_display_tools=>get_wp_icon
      EXPORTING
        i_einri     = l_outtab-einri
        i_indicator = '085'             " OP nicht begonnen
      IMPORTING
        e_icon      = l_icon.
    l_outtab-opbeg = l_icon.
  ENDIF.

* Planungsdaten (OE, Datum, Zeit, Raum, Bewegung)
  IF NOT l_nbew IS INITIAL.
    l_outtab-planoe    = l_nbew-orgpf.
    l_outtab-date      = l_nbew-bwidt.
    l_outtab-time      = l_nbew-bwizt.
    l_outtab-room      = l_nbew-zimmr.
    l_outtab-lfdbew    = l_nbew-lfdnr.
    CALL METHOD cl_ish_utl_apmg=>get_pobnr_by_movement
      EXPORTING
        is_nbew = l_nbew
      IMPORTING
        e_pobnr = l_pobnr.
  ELSEIF NOT l_ntmn IS INITIAL.
    l_outtab-planoe    = l_ntmn-tmnoe.
    l_outtab-date      = l_ntmn-tmndt.
    l_outtab-time      = l_ntmn-tmnzt.
    l_outtab-room      = l_napp-zimmr.
    l_outtab-tmtag     = l_ntmn-tmtag.
    l_outtab-lfdbew    = l_ntmn-tmnlb.
    l_pobnr            = l_napp-pobnr.
  ELSEIF NOT l_n1apcn IS INITIAL.
    l_outtab-planoe    = l_a_nlei-erboe.
*    l_outtab-date      = l_n1apcn-wdate.         " REM MED-34863
*    l_outtab-time      = l_n1apcn-wtime.         " REM MED-34863
*    l_outtab-room      = l_n1apcn-troom.
    l_outtab-lfdbew    = l_a_nlei-lfdbew.
  ENDIF.
  IF l_outtab-planoe IS INITIAL AND NOT l_a_nlei-erboe IS INITIAL.
    l_outtab-planoe    = l_a_nlei-erboe.
  ENDIF.
  IF l_outtab-date IS INITIAL.
    IF NOT l_a_nlem-wbgdt IS INITIAL.
      l_outtab-date    = l_a_nlem-wbgdt.
      l_outtab-time    = l_a_nlem-wbgzt.
    ELSE.
      l_outtab-date    = l_a_nlei-ibgdt.
      l_outtab-time    = l_a_nlei-ibzt.
    ENDIF.
  ENDIF.
*  IF l_outtab-room IS INITIAL AND NOT l_a_nlem-zimmr IS INITIAL.
*    l_outtab-room      = l_a_nlem-zimmr.
*  ENDIF.
  IF l_outtab-lfdbew IS INITIAL AND NOT l_a_nlei-lfdbew IS INITIAL.
    l_outtab-lfdbew    = l_a_nlei-lfdbew.
  ENDIF.

* MED-41209: Begin of INSERT
* Wenn die OP begonnen ist, dann die OP-begonnen-Zeit befüllen
  IF l_op_beg = on.
    l_outtab-opbeg_time = l_nbew-bwizt.
  ENDIF.
* Prüfen ob ein Ablauf vorhanden ist
  IF l_dsp_prgs_end = on.
    CALL METHOD cl_ishmed_utl_op=>get_op_prgs
      EXPORTING
        ir_service      = g_anchor_service
      IMPORTING
        e_prgs_date     = l_prgs_date
        e_prgs_time     = l_prgs_time
        e_prgs_duration = l_prgs_dauer
        e_prgs_time_end = l_outtab-prgs_time_end.
  ELSE.
    CALL METHOD cl_ishmed_utl_op=>get_op_prgs
      EXPORTING
        ir_service      = g_anchor_service
      IMPORTING
        e_prgs_date     = l_prgs_date
        e_prgs_time     = l_prgs_time
        e_prgs_duration = l_prgs_dauer.
  ENDIF.
* Wenn die Ablaufbeginnzeit vorhanden ist, dann anzeigen (z.b. Saaleintritt)
  IF l_prgs_date IS NOT INITIAL AND l_prgs_time IS NOT INITIAL.
    l_outtab-date          = l_prgs_date.
    l_outtab-time          = l_prgs_time.
    l_outtab-prgs_time_beg = l_prgs_time.
  ENDIF.
* MED-41209: End of INSERT

* Erbringende OE
  IF NOT l_a_nlei-erboe IS INITIAL.
    l_outtab-erboe = l_a_nlei-erboe.
  ELSE.
    l_outtab-erboe = l_outtab-planoe.
  ENDIF.
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

* OP-Dauer
  IF NOT l_prgs_dauer IS INITIAL.                           " MED-41209
    l_outtab-dauer  = l_prgs_dauer.                         " MED-41209
  ELSEIF NOT l_nbew IS INITIAL.
    l_outtab-dauer  = l_napp-dauer.
  ELSEIF NOT l_ntmn IS INITIAL.
    l_outtab-dauer  = l_napp-dauer.
  ELSEIF NOT l_n1apcn IS INITIAL.
    l_outtab-dauer  = l_n1apcn-trdrn.
  ELSE.
    l_outtab-dauer  = l_a_nlem-dauer.
  ENDIF.

* Fall- und Patientendaten
  IF NOT l_nbew IS INITIAL.
    l_outtab-falnr  = l_nbew-falnr.
    IF NOT l_a_nlem-patnr IS INITIAL.
      l_outtab-patnr = l_a_nlem-patnr.
        else.                                "MED-51267 NedaV
          l_outtab-patnr  = l_ntmn-patnr.    "MED-51267 NedaV
      endif.
  ELSEIF NOT l_ntmn IS INITIAL.
    l_outtab-falnr  = l_ntmn-falnr.
    l_outtab-patnr  = l_ntmn-patnr.
  ELSE.
    l_outtab-falnr  = l_a_nlei-falnr.
    l_outtab-patnr  = l_a_nlem-patnr.
  ENDIF.

    "Begin of MED-51267 NedaV
      if g_anonym is initial.
    if l_outtab-patnr is initial and not l_nbew is initial.
      call method cl_ishmed_none_oo_nfal=>load
        exporting
          i_mandt        = l_nbew-mandt
          i_einri        = l_nbew-einri
          i_falnr        = l_nbew-falnr
*         i_nfal         =
          i_read_db      = 'X'
        importing
          e_instance     = l_instance
          e_rc           =  l_rc     "MED-59190 AGujev
        changing
          c_errorhandler = c_errorhandler.

     IF l_rc = 0 AND l_instance IS BOUND.  "MED-59190 AGujev
    call method l_instance->get_data
      importing
*         e_rc           =     " Returncode
        e_nfal         =     l_nfal
      changing
        c_errorhandler =   c_errorhandler.  " IS-H*MED: Klasse zur Fehlerabarbeitung

    l_outtab-patnr = l_nfal-patnr.
      ENDIF.          "MED-59190 AGujev
    endif.
        endif.
    "End of MED-51267 NedaV
* Klinische Aufträge und/oder Anforderungen vorhanden
    if l_dsp_anfv = on.
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
* casedata will filled at an other place (FILL_T_CASE_DATA)
** Falldaten (auch für fallfreie Objekte aufrufen!)
*  CALL METHOD cl_ish_display_tools=>fill_case_data
*    EXPORTING
*      i_falnr        = l_outtab-falnr
*      it_fieldcat    = it_fieldcat
*    IMPORTING
*      e_rc           = e_rc
**     e_nfal         = l_nfal
*    CHANGING
*      c_outtab_line  = l_outtab
*      c_errorhandler = c_errorhandler.
*  CHECK e_rc = 0.
* END MED-40483

* Patientendaten
  CALL METHOD cl_ish_display_tools=>fill_patient_data
    EXPORTING
      i_patnr          = l_outtab-patnr
      i_papid          = l_a_nlem-papid
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
*  patient and allegiedata will filled at an other place
** Patientenpfad
*  CALL METHOD cl_ish_display_tools=>fill_pathway_data
*    EXPORTING
*      it_fieldcat           = it_fieldcat
*      it_selection_criteria = it_selection_criteria
*    IMPORTING
*      e_rc                  = e_rc
*    CHANGING
*      c_outtab_line         = l_outtab
*      c_errorhandler        = c_errorhandler.
*  CHECK e_rc = 0.
*
** Allergiedaten
*  CALL METHOD cl_ish_display_tools=>fill_adpat_data
*    EXPORTING
*      it_fieldcat           = it_fieldcat
*      it_selection_criteria = it_selection_criteria
*    IMPORTING
*      e_rc                  = e_rc
*    CHANGING
*      c_outtab_line         = l_outtab
*      c_errorhandler        = c_errorhandler.
*  CHECK e_rc = 0.
* END MED-40483

* i.s.h.med Bildstudie
  CALL METHOD cl_ish_display_tools=>fill_im_data
    EXPORTING
      it_fieldcat           = it_fieldcat
      it_selection_criteria = it_selection_criteria
    IMPORTING
      e_rc                  = e_rc
    CHANGING
      c_outtab_line         = l_outtab
      c_errorhandler        = c_errorhandler.
  CHECK e_rc = 0.

* IS-H NL - DBC for cases                                           6.01
  CALL METHOD cl_ish_display_tools=>fill_dbc_data
    EXPORTING
      it_fieldcat    = it_fieldcat
*     it_selection_criteria = it_selection_criteria
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_outtab_line  = l_outtab
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Anforderungsdaten, Daten der Auftragsposition bzw. Not-OP-Daten
  IF NOT g_request IS INITIAL.
*   Anforderung ------------------------------------------------------
*   Icon für Angeforderte OP setzen (Element)
    CALL FUNCTION 'ISHMED_GET_DATA_ICON_AND_TEXT'
      EXPORTING
        i_object          = g_request
        i_icon_with_qinfo = on
      IMPORTING
        e_rc              = e_rc
        e_icon            = l_icon_image
      CHANGING
        c_errorhandler    = c_errorhandler.
    CHECK e_rc = 0.
*   Priorität (primär aus dem Termin, wenn vorhanden)
    IF NOT g_appointment IS INITIAL.
      l_outtab-prio = l_ntmn-bwprio.
    ELSE.
      l_outtab-prio = l_n1anf-apri.
    ENDIF.
*   Anfordernd pflegerische OE
    l_outtab-anpoe = l_n1anf-anpoe.
*   Anfordernd fachliche OE
    l_outtab-anfoe = l_n1anf-anfoe.
*   Wunschdatum
*    l_outtab-wdate = l_a_nlem-wbgdt.        " REM MED-34863
*   Wunschzeit
*    l_outtab-wtime = l_a_nlem-wbgzt.        " REM MED-34863
*   MED-34863: get desired date/time
    CALL METHOD cl_ishmed_utl_base=>get_desired_time_srv
      EXPORTING
        is_nlei = l_a_nlei
        is_nlem = l_a_nlem
      IMPORTING
        e_date  = l_outtab-wdate
        e_time  = l_outtab-wtime.
*   Wunschraum
    l_outtab-wroom = l_a_nlem-zimmr.
*   Wunschzeitpunktinterpretation + Bezeichnung
    IF NOT l_a_nlem-wbzpi IS INITIAL.
      CALL FUNCTION 'ISHMED_READ_N1ZPI'
        EXPORTING
          i_einri  = l_outtab-einri
          i_zpi    = l_a_nlem-wbzpi
        IMPORTING
          e_zpie   = l_outtab-wzpie
          e_zpitxt = l_outtab-wzpitxt
          e_rc     = l_rc.
      IF l_rc <> 0.
        CLEAR: l_outtab-wzpie, l_outtab-wzpitxt.
      ENDIF.
    ENDIF.
*   Besonderheiten
    l_outtab-besond = l_n1anf-bhanf.
  ELSEIF NOT g_prereg IS INITIAL.
*   Klin. Auftragsposition -------------------------------------------
*   Icon für Vorgemerkte OP setzen (Element)
    CALL FUNCTION 'ISHMED_GET_DATA_ICON_AND_TEXT'
      EXPORTING
        i_object          = g_prereg
        i_icon_with_qinfo = on
      IMPORTING
        e_rc              = e_rc
        e_icon            = l_icon_image
      CHANGING
        c_errorhandler    = c_errorhandler.
    CHECK e_rc = 0.
*   Priorität (primär aus dem Termin, wenn vorhanden)
    IF NOT g_appointment IS INITIAL.
      l_outtab-prio = l_ntmn-bwprio.
    ELSE.
      l_outtab-prio  = l_n1corder-ordpri.
    ENDIF.
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
*   Wunschdatum
*    l_outtab-wdate  = l_n1apcn-wdate.        " REM MED-34863
*   Wunschzeit
*    l_outtab-wtime  = l_n1apcn-wtime.        " REM MED-34863
*   MED-34863: get desired date/time
    CALL METHOD cl_ishmed_utl_base=>get_desired_time_srv
      EXPORTING
        is_nlei   = l_a_nlei
        is_nlem   = l_a_nlem
        is_n1apcn = l_n1apcn
      IMPORTING
        e_date    = l_outtab-wdate
        e_time    = l_outtab-wtime.
*   Wunschraum
    l_outtab-wroom  = l_n1apcn-troom.
*   Wunschmonat
    l_outtab-wumnt  = l_n1apcn-wumnt.
*   Wunschjahr
    l_outtab-wujhr  = l_n1apcn-wujhr.
*   Wunschzeitpunktinterpretation + Bezeichnung
    IF NOT l_n1apcn-wuzpi IS INITIAL.
      CALL FUNCTION 'ISHMED_READ_N1ZPI'
        EXPORTING
          i_einri  = l_outtab-einri
          i_zpi    = l_n1apcn-wuzpi
        IMPORTING
          e_zpie   = l_outtab-wzpie
          e_zpitxt = l_outtab-wzpitxt
          e_rc     = l_rc.
      IF l_rc <> 0.
        CLEAR: l_outtab-wzpie, l_outtab-wzpitxt.
      ENDIF.
    ENDIF.
  ELSE.
*   Not-OP -----------------------------------------------------------
    l_outtab-emerg_op = on.
*   Icon für Not-OP setzen (Element)
    IF NOT g_movement IS INITIAL
      OR gr_movement IS NOT INITIAL.                        "MED-40483
      CALL FUNCTION 'ISHMED_GET_DATA_ICON_AND_TEXT'
        EXPORTING
*         i_object          = g_movement
          i_data_line       = l_nbew
          i_data_name       = 'NBEW'
          i_icon_with_qinfo = on
        IMPORTING
          e_rc              = e_rc
          e_icon            = l_icon_image
        CHANGING
          c_errorhandler    = c_errorhandler.
    ELSEIF NOT g_appointment IS INITIAL.
*     darf eigentlich nicht vorkommen!!!
      CALL FUNCTION 'ISHMED_GET_DATA_ICON_AND_TEXT'
        EXPORTING
          i_object          = g_appointment
          i_icon_with_qinfo = on
        IMPORTING
          e_rc              = e_rc
          e_icon            = l_icon_image
        CHANGING
          c_errorhandler    = c_errorhandler.
    ENDIF.
    CHECK e_rc = 0.
*   Priorität
    l_outtab-prio = l_nbew-bwprio.
*   Anfordernd pflegerische OE
    IF NOT g_anchor_service IS INITIAL.
      l_outtab-anpoe = l_a_nlei-anpoe.
    ELSE.
      l_outtab-anpoe = l_nbew-orgpf.
    ENDIF.
*   Anfordernd fachliche OE
    l_outtab-anfoe = l_nbew-orgfa.
  ENDIF.

*-->begin of MED-60929 AGujev
*if field bemerkung is filled we need to convert it to external format (for special characters)
   IF l_outtab-besond IS NOT INITIAL.
    CLEAR lt_tline[].  "MED-61281 AGujev
    CLEAR l_tline.     "MED-61281 AGujev
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
*-->begin of MED-65136 Madalina P.
* Check if the length of the longtext is greater than the length of the bemerkung field (BESOND)
* If it is, then the last 3 characters should be replaced with "..."
    IF l_corder IS BOUND.         " MED-65818 Note 2535141 Bi
      l_besond_string_short = l_besond_string.

    CLEAR lt_tline.
    l_corder->get_text(
      EXPORTING
        i_text_id      = cl_ish_corder=>co_text_rmcord
      IMPORTING
        e_rc           = l_rc
        et_tline       = lt_tline ).
    IF l_rc = 0.
      READ TABLE lt_tline INDEX 1 INTO l_tline.
*      ENDIF.                                                       "MED-65852 Madalina P.

    l_besond_string = l_tline-tdline.

    l_length_longtext = strlen( l_besond_string ).
    l_length_besond = strlen( l_besond_string_short ).

    DESCRIBE TABLE lt_tline LINES l_lines.

    IF l_length_longtext > l_length_besond OR l_lines > 1.
* START MED-65852 Madalina P.  - reworked this section because it did not cover al cases
*          l_length_besond = l_length_besond - 3.
*          CONCATENATE l_besond_string_short(l_length_besond) '...' INTO l_besond_string.
          TRY.
            lr_elem_descr ?= cl_abap_elemdescr=>describe_by_data( l_besond_string_short ).
            l_length_dictionary = lr_elem_descr->output_length.
            IF l_length_besond > ( l_length_dictionary - 3 ).
              l_length_besond = l_length_besond - 3.
            ENDIF.

            CONCATENATE l_besond_string_short(l_length_besond) '...' INTO l_besond_string.
          CATCH cx_sy_move_cast_error.
          ENDTRY.
* END MED-65852 Madalina P.
        ENDIF.
      ENDIF.                                                       "MED-65852 Madalina P.
    ENDIF.                        " MED-65818 Note 2535141 Bi
*<--end of MED-65136 Madalina P.
    CLEAR l_outtab-besond.
    l_outtab-besond = l_besond_string.
    CLEAR l_besond_string.    "MED-61281 AGujev
   ENDIF.
*<--end of MED-60929 AGujev

  g_anpoe = l_outtab-anpoe.
  g_anfoe = l_outtab-anfoe.

* Element
  l_outtab-element = l_icon_image.

* Weitere Daten der Priorität
  IF NOT l_outtab-prio IS INITIAL.
*   Priorität extern + Bezeichnung
    IF NOT g_appointment IS INITIAL OR
       NOT g_movement    IS INITIAL OR
       gr_movement IS NOT INITIAL OR                        "MED-40483
       NOT g_request     IS INITIAL OR
       NOT g_prereg      IS INITIAL.
*     Priorität der Anforderung oder des Klin. Auftrags
*     oder der Bewegung oder des Termins
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
    ENDIF.
*   Priorität (für Sortierung) korrekt formatieren
    IF l_outtab-prio CO ' 0123456789'.
      PERFORM format_numc_string IN PROGRAM sapmn1pa
              USING l_outtab-prio 3.
    ENDIF.
  ENDIF.

* von der Ankerleistung abhängige Daten -------------------------------
  IF NOT g_anchor_service IS INITIAL.
*   Icon für Planzeit manuell fixiert setzen
    IF l_a_nlem-pzman = on.
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = l_outtab-einri
          i_indicator = '084'             " Planzeit manuell fixiert
        IMPORTING
          e_icon      = l_icon.
      l_outtab-pzman = l_icon.
    ENDIF.
*   Icon für Anästhesist erforderlich setzen
    IF l_a_nlem-anerf = on.     " AND NOT g_request IS INITIAL.
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = l_outtab-einri
          i_indicator = '075'             " Anästhesist erforderlich
        IMPORTING
          e_icon      = l_icon.
      l_outtab-anerf_icon = l_icon.
    ENDIF.
*   Icon für Freigabe Operateur setzen
    IF l_a_nlem-pmedfg = on.
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = l_outtab-einri
          i_indicator = '077'             " Freigabe Operateur vorh.
        IMPORTING
          e_icon      = l_icon.
      l_outtab-pmedfg_icon = l_icon.
    ELSE.
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = l_outtab-einri
          i_indicator = '076'             " Freigabe Op. nicht vorh.
        IMPORTING
          e_icon      = l_icon.
      l_outtab-pmedfg_icon = l_icon.
    ENDIF.
*   Icon für Prämedikation vollständig setzen
    IF l_a_nlem-pmedvs = on.
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = l_outtab-einri
          i_indicator = '088'            " Prämedikation vollständig
        IMPORTING
          e_icon      = l_icon.
      l_outtab-pmedvs_icon = l_icon.
    ELSE.
      CALL METHOD cl_ish_display_tools=>get_wp_icon
        EXPORTING
          i_einri     = l_outtab-einri
          i_indicator = '087'          " Prämedik. nicht vollständig
        IMPORTING
          e_icon      = l_icon.
      l_outtab-pmedvs_icon = l_icon.
    ENDIF.
*   OP-Nummer
    l_outtab-opnr = l_a_nlem-opnr.
*   Zeitmarken (zeitlich letzte Zeitmarke)
    IF l_dsp_ztmk = on.
*Sta/PN/MED-40483
* srgtimes are already read -> get it from service
*        CALL FUNCTION 'ISH_N2_READ_OPZEITEN'
*          EXPORTING
*            ss_ankerleistung      = l_a_nlei-lnrls
*          TABLES
*            ss_zeiten             = lt_zeiten
*          EXCEPTIONS
*            no_ankerleistung      = 1
*            no_zeitpunkt          = 2
*            zeitpunkt_not_defined = 3
*            OTHERS                = 4.
      CLEAR: lt_srgtimes, lt_zeiten.
*     get srgtimes from service
      CALL METHOD g_anchor_service->get_t_srgtime
        EXPORTING
          i_read_db       = off
        IMPORTING
          et_srgtime      = lt_srgtimes
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
*     fill n2zeiten table with timedefinition data
      IF l_rc = 0 AND lt_srgtimes[] IS NOT INITIAL.
        CALL FUNCTION 'ISH_N2_READ_TIMEDEFINITION'
          EXPORTING
            ss_einrichtung  = l_outtab-einri
          TABLES
            ss_zeitpunkte   = lt_rn2ztpdef
          EXCEPTIONS
            no_einrichtung  = 1
            no_arbeitsplatz = 2
            OTHERS          = 3.
        IF sy-subrc = 0.
*-->begin of MED-53612 AGujev
*we have to ignore neben-OP times - sometimes same time definition is created for main OP and neben OP
*if we keep the N values, the read table below might not find the right  values (zpber = O)
          DELETE lt_rn2ztpdef WHERE zpber = 'N'.
*<--end of MED-53612 AGujev

*          SORT lt_rn2ztpdef BY zpid.                                     "MED-51467 NedaV
          SORT lt_rn2ztpdef BY zprefid.                                   "MED-51467 NedaV

          LOOP AT lt_srgtimes ASSIGNING <ls_srgtimes>.
            CLEAR: ls_n2zeiten, l_zeiten.
            CALL METHOD <ls_srgtimes>-obj->get_data
              IMPORTING
                es_n2zeiten = ls_n2zeiten.
            READ TABLE lt_rn2ztpdef ASSIGNING <ls_rn2ztpdef>
*                WITH KEY zpid = ls_n2zeiten-zpid BINARY SEARCH.           "MED-50289  NedaV
                 WITH KEY zprefid = ls_n2zeiten-zpid BINARY SEARCH.        "MED-50289  NedaV
            IF sy-subrc = 0.
              MOVE-CORRESPONDING ls_n2zeiten    TO l_zeiten. "#EC ENHOK
              MOVE-CORRESPONDING <ls_rn2ztpdef> TO l_zeiten. "#EC ENHOK
              APPEND l_zeiten TO lt_zeiten.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.
*End/PN/MED-40483
      IF sy-subrc = 0.
        DELETE lt_zeiten WHERE datum   IS INITIAL
                            OR uhrzeit IS INITIAL.
        DESCRIBE TABLE lt_zeiten.
        IF sy-tfill > 0.
          SORT lt_zeiten BY ankerleist datum DESCENDING
                            uhrzeit DESCENDING
                            zpnr DESCENDING               " MED-46334
                            zpber.
*         Bereichszuordnung auch prüfen
          CLEAR l_zpber. REFRESH: lr_zpber.
          l_zpber-sign   = 'I'.
          l_zpber-option = 'EQ'.
          l_zpber-low = 'O'. APPEND l_zpber TO lr_zpber.
          l_zpber-low = 'P'. APPEND l_zpber TO lr_zpber.
          l_zpber-low = 'A'. APPEND l_zpber TO lr_zpber.
          l_zpber-low = 'B'. APPEND l_zpber TO lr_zpber.
          LOOP AT lt_zeiten INTO l_zeiten WHERE zpber IN lr_zpber.
            l_outtab-ztmk_zeit = l_zeiten-uhrzeit.
            l_outtab-ztmk_bez  = l_zeiten-zpbez.
            EXIT.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDIF.       " Zeitmarken
  ENDIF.       " von der Ankerleistung abhängige Daten

* von der Bewegung abhängige Daten
  IF NOT g_movement IS INITIAL
    OR gr_movement IS NOT INITIAL.
*   Bemerkung zur Bewegung
    l_outtab-bem_bew = l_nbew-kztxt.
  ENDIF.

* vom Termin abhängige Daten
  IF NOT g_appointment IS INITIAL.
*   Änderungsgrund des Termins (Cause of Change)
    IF l_ntmn-causechng IS NOT INITIAL.
      l_outtab-causechng = l_ntmn-causechng.
    ELSEIF l_ntmn-csechgid IS NOT INITIAL.                  " MED-34701
      CALL METHOD cl_ishmed_utl_app_rls_causechg=>get_cause_change_for_id
        EXPORTING
          i_einri     = l_outtab-einri
          i_csechgid  = l_ntmn-csechgid
          i_read_db   = off
        IMPORTING
          e_csechgtxt = l_outtab-causechng.
    ENDIF.
*   Plandatum und -zeit
    l_outtab-tmpdt    = l_ntmn-tmpdt.
    l_outtab-tmpzt    = l_ntmn-tmpzt.
    l_outtab-tmdauer  = l_ntmn-tmndr.                       " MED-41209
  ENDIF.

* Freigabe (Appointment aleady released?)
* read if cell color should be changed or if column should be displayed
* NOT FOR: emergency OPs
*          day-based appointments
*          admission appointments
  IF l_outtab-emerg_op =  off AND
     l_outtab-tmtag    =  off AND
     l_ntmn-bewty      <> '1'.
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

* Verantw. Mitarbeiter
  IF l_dsp_vma = on.
    CLEAR l_gpart.
    IF NOT l_n1anf-anfid IS INITIAL.
*     Statusfortschreibung der Anforderung lesen
      SELECT * FROM n1anmsz INTO TABLE lt_n1anmsz
               WHERE einri = l_outtab-einri
                 AND anfid = l_n1anf-anfid.
      IF sy-subrc = 0.
*       Letzten VMA aus Statusfortschreibung ermitteln
        SORT lt_n1anmsz BY erdat DESCENDING ertim DESCENDING.
        READ TABLE lt_n1anmsz INTO l_n1anmsz INDEX 1.
        IF sy-subrc = 0.
          l_gpart = l_n1anmsz-gpart.
        ENDIF.
      ENDIF.
    ELSEIF NOT l_n1vkg-vkgid IS INITIAL.
*     VMA des Klinischen Auftrags
      l_gpart = l_n1corder-etrgp.
    ENDIF.       " Anforderung ODER Klinischer Auftrag
    IF NOT l_gpart IS INITIAL.
      CALL FUNCTION 'ISHMED_GET_VMA_TEXT'
        EXPORTING
          i_einri       = l_outtab-einri
          i_gpart       = l_gpart
        IMPORTING
          e_vmatext     = l_outtab-vma
        EXCEPTIONS
          vma_not_found = 1
          OTHERS        = 2.
      IF sy-subrc <> 0.
        CLEAR l_outtab-vma.
      ENDIF.
    ENDIF.
  ENDIF.       " Verantw. Mitarbeiter

* ID 13138: Tageskommentar ermitteln
  IF l_dsp_modcomment = on AND l_pobnr IS NOT INITIAL.
    IF cl_ishmed_switch_check=>ishmed_scd( ) = on.
      CLEAR ls_pobnr_date.
      ls_pobnr_date-pobnr = l_pobnr.
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
        LOOP AT lt_pobdc INTO ls_pobdc WHERE pobnr = l_pobnr
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
          i_einri         = l_outtab-einri
          i_pobnr         = l_pobnr
          i_date          = l_outtab-date
*         I_CANCELLED_DATAS =
*Sta/PN/MED-40483
*          adjustment from memory not necessary -> give no environment
*         i_environment   = g_environment
*End/PN/MED-40483
          i_buffer_active = on
*         I_READ_DB       = SPACE
        IMPORTING
          e_rc            = l_rc
          et_natm         = lt_natm
        CHANGING
          c_errorhandler  = c_errorhandler.
      IF l_rc = 0.
        READ TABLE lt_natm INTO l_natm INDEX 1.
        IF sy-subrc = 0.
          l_outtab-modcomment = l_natm-commnt.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

* Klinischer Auftrag: Aufnahmetermin ermitteln
* Aufnahme-OE/-Datum/-Zeit befüllen
* ID 16088: if there is a case -> get admission for case
*           if there is no case -> get admission app from order
*START MED-40483 2010/08/30
*  OU date time will filled at an other place
*  IF l_dsp_afn = on AND NOT g_prereg IS INITIAL
*                    AND NOT l_corder IS INITIAL.
*    IF NOT l_outtab-falnr IS INITIAL.
*      SELECT * FROM nbew INTO ls_nbew_adm UP TO 1 ROWS
*             WHERE  einri  = l_outtab-einri
*             AND    falnr  = l_outtab-falnr
*             AND    bewty  = '1'
*             AND    storn  = off.
*        EXIT.
*      ENDSELECT.
*      IF sy-subrc = 0.
*        l_outtab-afnoe = ls_nbew_adm-orgpf.
*        l_outtab-afndt = ls_nbew_adm-bwidt.
*        l_outtab-afnzt = ls_nbew_adm-bwizt.
*      ENDIF.
**  ELSE.                                      " REM MED-42100
*    ENDIF.                                                " MED-42100
*    IF l_outtab-afnoe IS INITIAL.                         " MED-42100
*      CALL METHOD l_corder->get_t_cordpos
*        EXPORTING
*          i_cancelled_datas = g_cancelled_data
*          i_bewty           = '1'
*          ir_environment    = g_environment
*        IMPORTING
*          et_cordpos        = lt_cordpos_adm
*          e_rc              = l_rc
*        CHANGING
*          cr_errorhandler   = c_errorhandler.
*      IF l_rc = 0.
*        LOOP AT lt_cordpos_adm INTO lr_cordpos_adm.
*          CALL METHOD cl_ishmed_prereg=>get_admission_appmnt
*            EXPORTING
*              i_cancelled_datas = g_cancelled_data
*              i_prereg          = lr_cordpos_adm
*              i_environment     = g_environment
*            IMPORTING
*              e_rc              = l_rc
*              e_ntmn            = l_afn_ntmn
**             et_napp           = lt_afn_napp
*            CHANGING
*              c_errorhandler    = c_errorhandler.
*          IF l_rc = 0 AND NOT l_afn_ntmn IS INITIAL.
*            l_outtab-afnoe = l_afn_ntmn-tmnoe.
*            l_outtab-afndt = l_afn_ntmn-tmndt.
*            l_outtab-afnzt = l_afn_ntmn-tmnzt.
*            EXIT.
*          ENDIF.
*        ENDLOOP.
*      ENDIF.
*    ENDIF.
*  ENDIF.
* END MED-40483

* fill dispo type ... (ID 15002)
  IF l_dsp_n1ptint = on.
    IF NOT g_appointment IS INITIAL.
*     ... from appointment
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
    ELSE.
      IF NOT l_n1apcn-trtoe IS INITIAL AND
         NOT l_n1apcn-wdisp IS INITIAL.
*       ... or from appointment constraint
        SELECT SINGLE dtext FROM tn40a INTO l_outtab-n1ptint
               WHERE  spras  = sy-langu
               AND    einri  = l_outtab-einri
               AND    orgid  = l_n1apcn-trtoe
               AND    dispo  = l_n1apcn-wdisp.
      ENDIF.
    ENDIF.
  ENDIF.

* START MED-40483
* Context date will filled at an other place
** Kontexte ermitteln
*  IF l_dsp_context = on.
**   Prüfen, ob Anforderung oder Auftrag Auslöser eines Kontext ist
*    IF NOT l_n1anf-anfid    IS INITIAL OR
*     ( NOT l_n1vkg-vkgid    IS INITIAL AND
*       NOT l_n1vkg-corderid IS INITIAL ).
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
*      ELSE.                              " Klin. Auftrag
**       Objekt-Schlüssel für Zuordnung zu einem Kontext ermitteln.
*        CALL METHOD cl_ish_corder=>build_key_string
*          EXPORTING
*            i_mandt    = sy-mandt
*            i_corderid = l_n1vkg-corderid
*          IMPORTING
*            e_key      = l_cx_key.
*        CALL METHOD cl_ish_context=>get_key_for_obj
*          EXPORTING
*            i_object_type = cl_ish_corder=>co_otype_corder
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
*          i_cancelled_datas = g_cancelled_data
*          i_environment     = g_environment
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

* Weitere (vor allem techn.) Felder für alle Zeilen der OP füllen
  l_outtab_all-prio        = l_outtab-prio.
  l_outtab_all-emerg_op    = l_outtab-emerg_op.
  l_outtab_all-tmtag       = l_outtab-tmtag.
  l_outtab_all-lfdbew      = l_outtab-lfdbew.
  l_outtab_all-falnr       = l_outtab-falnr.                " BA 2011
  l_outtab_all-patnr       = l_outtab-patnr.                " BA 2011

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
* Nun bestimmen, ob die OP ein- oder mehrzeilig angezeigt wird ...
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

* OP-Leistungen vorhanden?
  DESCRIBE TABLE gt_services LINES l_lin_srv.
* OP-Team vorhanden?
  DESCRIBE TABLE lt_opteam LINES l_lin_team.
* Diagnosen vorhanden?
  DESCRIBE TABLE lt_diag LINES l_lin_diag.
  IF l_lin_srv = 0 AND l_lin_team = 0 AND l_lin_diag = 0.
*   keine OP-Leistungen, kein OP-Team und keine Diagnosen vorhanden
    l_outtab-seqno = 1.
    l_outtab-openclose = icon_space.
    APPEND l_outtab TO lt_outtab.
  ELSE.
*   OP-Leistungen, OP-Team oder Diagnosen vorhanden
*   Darstellung der OP ... (mehrzeilig/einzeilig) ...
    IF g_node_open = on.
*     ... mehrzeilig
      CLEAR l_most_lines.
      IF l_lin_srv >= l_lin_team AND l_lin_srv >= l_lin_diag.
        l_most_lines = 'S'.
      ELSEIF l_lin_team >= l_lin_srv AND l_lin_team >= l_lin_diag.
        l_most_lines = 'T'.
      ELSEIF l_lin_diag >= l_lin_srv AND l_lin_diag >= l_lin_team.
        l_most_lines = 'D'.
      ENDIF.
      CASE l_most_lines.
        WHEN 'S'.
*         Leistungen haben die meisten Zeilen
          LOOP AT gt_services INTO l_service.
*           Zähler für Zeilennummer innerhalb der OP hochzählen
            l_cnt = l_cnt + 1.
            IF l_cnt = 1.
*             1. Zeile der OP
              IF l_lin_srv > 1 OR l_lin_team > 1 OR l_lin_diag > 1.
*               'Offen'-Folder nur, wenn die OP mehr als 1 Zeile hat
                l_outtab-openclose = icon_open_folder.
              ELSE.
                l_outtab-openclose = icon_space.
              ENDIF.
            ELSE.
*             'Folgezeilen' der OP
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
            l_outtab-seqno   = l_cnt.
*           Leistungsdaten
            CALL METHOD cl_ish_display_tools=>fill_service_data
              EXPORTING
                i_service      = l_service
                i_node_closed  = off
                i_place_holder = l_place_holder
                i_anchor       = g_anchor_service
                it_services    = gt_services
              IMPORTING
                e_rc           = e_rc
              CHANGING
                c_outtab_line  = l_outtab
                c_errorhandler = c_errorhandler.
            IF e_rc <> 0.
              EXIT.
            ENDIF.
*           auch einen Teameintrag in diese Zeile stellen
            IF l_cnt <= l_lin_team.
              READ TABLE lt_opteam INTO l_opteam INDEX l_cnt.
              IF sy-subrc = 0.
                l_outtab-team1_kurz = l_opteam-team1_kurz.
                l_outtab-team2_kurz = l_opteam-team2_kurz.
                l_outtab-team3_kurz = l_opteam-team3_kurz.
                l_outtab-team4_kurz = l_opteam-team4_kurz.
                l_outtab-team1      = l_opteam-team1.
                l_outtab-team2      = l_opteam-team2.
                l_outtab-team3      = l_opteam-team3.
                l_outtab-team4      = l_opteam-team4.
              ENDIF.
            ELSE.
              CLEAR: l_outtab-team1_kurz, l_outtab-team1,
                     l_outtab-team2_kurz, l_outtab-team2,
                     l_outtab-team3_kurz, l_outtab-team3,
                     l_outtab-team4_kurz, l_outtab-team4.
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
        WHEN 'T'.
*         Teameinträge haben die meisten Zeilen
          LOOP AT lt_opteam INTO l_opteam.
*           Zähler für Zeilennummer innerhalb der OP hochzählen
            l_cnt = l_cnt + 1.
            IF l_cnt = 1.
*             1. Zeile der OP
              IF l_lin_srv > 1 OR l_lin_team > 1 OR l_lin_diag > 1.
*               'Offen'-Folder nur, wenn die OP mehr als 1 Zeile hat
                l_outtab-openclose = icon_open_folder.
              ELSE.
                l_outtab-openclose = icon_space.
              ENDIF.
            ELSE.
*             'Folgezeilen' der OP
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
            l_outtab-seqno = l_cnt.
*           Teamdaten
            l_outtab-team1_kurz = l_opteam-team1_kurz.
            l_outtab-team2_kurz = l_opteam-team2_kurz.
            l_outtab-team3_kurz = l_opteam-team3_kurz.
            l_outtab-team4_kurz = l_opteam-team4_kurz.
            l_outtab-team1      = l_opteam-team1.
            l_outtab-team2      = l_opteam-team2.
            l_outtab-team3      = l_opteam-team3.
            l_outtab-team4      = l_opteam-team4.
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
                    i_anchor       = g_anchor_service
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
*           Zähler für Zeilennummer innerhalb der OP hochzählen
            l_cnt = l_cnt + 1.
            IF l_cnt = 1.
*             1. Zeile der OP
              IF l_lin_srv > 1 OR l_lin_team > 1 OR l_lin_diag > 1.
*               'Offen'-Folder nur, wenn die OP mehr als 1 Zeile hat
                l_outtab-openclose = icon_open_folder.
              ELSE.
                l_outtab-openclose = icon_space.
              ENDIF.
            ELSE.
*             'Folgezeilen' der OP
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
                    i_anchor       = g_anchor_service
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
*           auch einen Teameintrag in diese Zeile stellen
            IF l_cnt <= l_lin_team.
              READ TABLE lt_opteam INTO l_opteam INDEX l_cnt.
              IF sy-subrc = 0.
                l_outtab-team1_kurz = l_opteam-team1_kurz.
                l_outtab-team2_kurz = l_opteam-team2_kurz.
                l_outtab-team3_kurz = l_opteam-team3_kurz.
                l_outtab-team4_kurz = l_opteam-team4_kurz.
                l_outtab-team1      = l_opteam-team1.
                l_outtab-team2      = l_opteam-team2.
                l_outtab-team3      = l_opteam-team3.
                l_outtab-team4      = l_opteam-team4.
              ENDIF.
            ELSE.
              CLEAR: l_outtab-team1_kurz, l_outtab-team1,
                     l_outtab-team2_kurz, l_outtab-team2,
                     l_outtab-team3_kurz, l_outtab-team3,
                     l_outtab-team4_kurz, l_outtab-team4.
            ENDIF.
            APPEND l_outtab TO lt_outtab.
          ENDLOOP.
      ENDCASE.
      CHECK e_rc = 0.
    ELSE.
*     ... einzeilig
*     OP-Leistungen
      LOOP AT gt_services INTO l_service.
*       Leistungsdaten
        CALL METHOD cl_ish_display_tools=>fill_service_data
          EXPORTING
            i_service      = l_service
            i_node_closed  = on
            i_place_holder = l_place_holder
            i_anchor       = g_anchor_service
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
*     OP-Team
      LOOP AT lt_opteam INTO l_opteam.
        IF NOT l_opteam-team1 IS INITIAL.
          REPLACE ',' WITH space INTO l_opteam-team1.
          CONDENSE l_opteam-team1.
          IF l_outtab-team1_kurz IS INITIAL.
            l_outtab-team1_kurz = l_opteam-team1_kurz.
            l_outtab-team1      = l_opteam-team1.
          ELSE.
            CONCATENATE l_outtab-team1_kurz l_opteam-team1_kurz
                        INTO l_outtab-team1_kurz SEPARATED BY ', '.
            CONCATENATE l_outtab-team1 l_opteam-team1
                        INTO l_outtab-team1 SEPARATED BY ', '.
          ENDIF.
        ENDIF.
        IF NOT l_opteam-team2 IS INITIAL.
          REPLACE ',' WITH space INTO l_opteam-team2.
          CONDENSE l_opteam-team2.
          IF l_outtab-team2_kurz IS INITIAL.
            l_outtab-team2_kurz = l_opteam-team2_kurz.
            l_outtab-team2      = l_opteam-team2.
          ELSE.
            CONCATENATE l_outtab-team2_kurz l_opteam-team2_kurz
                        INTO l_outtab-team2_kurz SEPARATED BY ', '.
            CONCATENATE l_outtab-team2 l_opteam-team2
                        INTO l_outtab-team2 SEPARATED BY ', '.
          ENDIF.
        ENDIF.
        IF NOT l_opteam-team3 IS INITIAL.
          REPLACE ',' WITH space INTO l_opteam-team3.
          CONDENSE l_opteam-team3.
          IF l_outtab-team3_kurz IS INITIAL.
            l_outtab-team3_kurz = l_opteam-team3_kurz.
            l_outtab-team3      = l_opteam-team3.
          ELSE.
            CONCATENATE l_outtab-team3_kurz l_opteam-team3_kurz
                        INTO l_outtab-team3_kurz SEPARATED BY ', '.
            CONCATENATE l_outtab-team3 l_opteam-team3
                        INTO l_outtab-team3 SEPARATED BY ', '.
          ENDIF.
        ENDIF.
        IF NOT l_opteam-team4 IS INITIAL.
          REPLACE ',' WITH space INTO l_opteam-team4.
          CONDENSE l_opteam-team4.
          IF l_outtab-team4_kurz IS INITIAL.
            l_outtab-team4_kurz = l_opteam-team4_kurz.
            l_outtab-team4      = l_opteam-team4.
          ELSE.
            CONCATENATE l_outtab-team4_kurz l_opteam-team4_kurz
                        INTO l_outtab-team4_kurz SEPARATED BY ', '.
            CONCATENATE l_outtab-team4 l_opteam-team4
                        INTO l_outtab-team4 SEPARATED BY ', '.
          ENDIF.
        ENDIF.
      ENDLOOP.
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
*     'Geschlossen'-Folder nur, wenn die OP mehr als 1 Zeile hat
      IF l_lin_srv > 1 OR l_lin_team > 1 OR l_lin_diag > 1.
        l_outtab-openclose = icon_closed_folder.
      ELSE.
        l_outtab-openclose = icon_space.
      ENDIF.
      APPEND l_outtab TO lt_outtab.
    ENDIF.     " IF g_node_open = on.

  ENDIF.     " IF l_lin_srv = 0 AND l_lin_team = 0.

  et_outtab[] = lt_outtab[].
  gt_outtab[] = lt_outtab[].

ENDMETHOD.


METHOD if_ish_display_object~destroy .

  CALL METHOD me->initialize.

  FREE: gt_subobjects,
        gt_outtab,
        gt_services,
        gt_team.

  FREE: g_object,
        g_environment.

  FREE: g_anchor_service,
        g_an_anchor_service,
        g_appointment,
        g_movement,
        g_prereg,
        g_request,
        g_anonym.

  FREE gr_movement.                                         "MED-40483

ENDMETHOD.


METHOD if_ish_display_object~get_data .

  DATA: l_object      LIKE LINE OF et_object,
        l_service     LIKE LINE OF gt_services,
        l_team        LIKE LINE OF gt_team.

  REFRESH: et_object.

* Erzeugendes Objekt
  IF NOT g_object IS INITIAL.
    l_object-object = g_object.
    APPEND l_object TO et_object.
  ENDIF.

* OP-Ankerleistung
  IF NOT g_anchor_service IS INITIAL.
    l_object-object = g_anchor_service.
    APPEND l_object TO et_object.
  ENDIF.

* AN-Ankerleistung
  IF NOT g_an_anchor_service IS INITIAL.
    l_object-object = g_an_anchor_service.
    APPEND l_object TO et_object.
  ENDIF.

* OP-Termin
  IF NOT g_appointment IS INITIAL.
    l_object-object = g_appointment.
    APPEND l_object TO et_object.
  ENDIF.

* OP-Bewegung
* START MED-40483 2010/07/07
  IF gr_movement IS NOT INITIAL.
    CLEAR l_object.
    l_object-object = gr_movement.
    APPEND l_object TO et_object.
  ENDIF.
* END MED-40483
  IF NOT g_movement IS INITIAL.
    l_object-object = g_movement.
    APPEND l_object TO et_object.
  ENDIF.

* OP-Anforderung
  IF NOT g_request IS INITIAL.
    l_object-object = g_request.
    APPEND l_object TO et_object.
  ENDIF.

* OP-Vormerkung
  IF NOT g_prereg IS INITIAL.
    l_object-object = g_prereg.
    APPEND l_object TO et_object.
  ENDIF.

* Leistungen
  LOOP AT gt_services INTO l_service.
    l_object-object = l_service.
    APPEND l_object TO et_object.
  ENDLOOP.

* Team
  LOOP AT gt_team INTO l_team.
    l_object-object = l_team.
    APPEND l_object TO et_object.
  ENDLOOP.

* Doppelte löschen
  SORT et_object BY object.
  DELETE ADJACENT DUPLICATES FROM et_object COMPARING object.

ENDMETHOD.


METHOD if_ish_display_object~get_fieldcatalog .

  DATA: lt_fieldcat   TYPE lvc_t_fcat,
        l_fieldcat    LIKE LINE OF lt_fieldcat.

* Diese Methode wird aus dem Sichttyp OP nicht aufgerufen,
* da der Sichttyp OP einen eigenen Feldkatalog für das
* Anzeigeobjekt 'Operation' bereitstellt!!!

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
* ... dazu den FuB des Sichttyp OP aufrufen, der die Überarbeitung
* durchführt (damit das nicht doppelt auszuprogrammieren und zu
* warten ist!)
* hier im Gegensatz zum Sichttyp OP aber nicht mit dem Feldkatalog
* der Struktur RN1WP_OP_LIST sondern der RN1DISPLAY_FIELDS übergeben
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

ENDMETHOD.


METHOD if_ish_display_object~get_merged_values .

  DATA: l_outtab          LIKE LINE OF gt_outtab.
*        l_nmf             LIKE LINE OF et_no_merge_fields.

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
  CALL METHOD cl_ishmed_dspobj_operation=>get_no_merged_fields
    IMPORTING
      et_no_merge_fields = et_no_merge_fields.

ENDMETHOD.


METHOD if_ish_display_object~get_type .

  e_object_type = co_otype_dspobj_operation.

ENDMETHOD.


METHOD if_ish_display_object~initialize .

  REFRESH: gt_subobjects,
           gt_outtab,
           gt_services,
           gt_team.

  CLEAR:   g_object,
           g_environment,
           g_cancelled,
           g_cancelled_data.

  CLEAR:   g_anchor_service,
           g_an_anchor_service,
           g_appointment,
           g_movement,
           g_prereg,
           g_request,
           g_anonym.

  CLEAR:   g_erboe,
           g_anpoe,
           g_anfoe.

  CLEAR gr_movement.                                        "MED-40483

ENDMETHOD.


method IF_ISH_DISPLAY_OBJECT~IS_CANCELLED .

  e_cancelled = g_cancelled.

endmethod.


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
  CREATE OBJECT e_instance TYPE cl_ishmed_dspobj_operation
    EXPORTING
      i_object              = i_object
      i_environment         = l_environment
      i_node_open           = i_node_open
      i_cancelled_data      = i_cancelled_data
      i_check_only          = i_check_only
    EXCEPTIONS
      instance_not_possible = 1
      no_operation          = 2
      OTHERS                = 4.
  l_rc = sy-subrc.
  g_construct = off.

  CASE l_rc.
    WHEN 0.
*     OK - Anzeigeobjekt 'Operation' wurde instanziert
    WHEN 2.
*     Objekt ist keine Operation
      e_rc = 99.        " Zu diesem Objekt existiert keine Operation
      CLEAR e_instance.
      EXIT.
    WHEN OTHERS.
*     Fehler beim Instanzieren des Anzeigeobjekts
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '779'       " Keine Operation vorhanden
          i_last = space.
      e_rc = 1.
      CLEAR e_instance.
      EXIT.
  ENDCASE.

* Prüfen, ob die OP storniert ist ...
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


METHOD if_ish_display_object~set_main_data .

  DATA: l_op_ok          TYPE ish_on_off,
        l_cancelled      TYPE ish_on_off,
        lt_object        TYPE ish_objectlist,
        l_object         LIKE LINE OF lt_object,
        lt_srv           TYPE ishmed_t_service_object,
        l_srv            LIKE LINE OF lt_srv,
        lt_a_srv         TYPE ishmed_t_service_object,
        l_a_srv          LIKE LINE OF lt_a_srv,
        lt_apps          TYPE ishmed_t_appointment_object,
        l_app            LIKE LINE OF lt_apps,
        lt_movs          TYPE ishmed_t_none_oo_nbew,
        l_mov            LIKE LINE OF lt_movs,
        lt_team          TYPE ish_objectlist,
        l_team_obj       LIKE LINE OF lt_team,
        l_team           LIKE LINE OF gt_team,
        l_vntmn          TYPE vntmn,
        l_nlei_anchor    TYPE nlei,
        l_nlei           TYPE nlei,
        l_nlem           TYPE nlem,
        l_nbew           TYPE nbew,
        ls_n1anf         TYPE n1anf,
        ls_n1corder      TYPE n1corder,
        lr_corder        TYPE REF TO cl_ish_corder,
        l_environment    TYPE REF TO cl_ish_environment.
  DATA l_read_over_anchor TYPE ish_on_off.
  DATA lt_moves           TYPE ishmed_t_movement.           "MED-40483
  DATA lr_move            TYPE REF TO cl_ishmed_movement.   "MED-40483

* Initialisierungen
  CLEAR: e_rc.

  REFRESH: gt_services,
           gt_team.

  CLEAR:   g_anchor_service,
           g_an_anchor_service,
           g_appointment,
           g_movement,
           g_prereg,
           g_request.

  CLEAR gr_movement.                                        "MED-40483

* Notwendige Übergabedaten prüfen
  IF i_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* Errorhandler instanzieren, falls nötig
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Übergebenes Objekt in Tabelle stellen
  REFRESH: lt_object.
  IF NOT i_object IS INITIAL.
    l_object-object = i_object.
    APPEND l_object TO lt_object.
  ENDIF.

* Environment ermitteln/instanzieren, falls nötig
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = lt_object
      CHANGING
        c_environment = c_environment.
  ENDIF.
  l_environment = c_environment.

* Operation anhand des übergebenen Objekts identifizieren ...
* ... also die Ankerleistung ermitteln
  REFRESH: lt_a_srv, lt_apps, lt_movs.
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects         = lt_object
      i_conn_srv         = on
*     aus Performancegründen vorerst nur die Haupt-OP-Ankerleistung
*     lesen, da die Anästhesie-Ankerleistung ohnehin noch nicht
*     hier im Anzeigeobjekt verwendet wird ...
      i_only_main_anchor = on
      i_cancelled_datas  = on
      i_read_db          = abap_false                        "MED-40483
    IMPORTING
      e_rc               = e_rc
      et_services        = lt_srv
      et_anchor_services = lt_a_srv
    CHANGING
      c_environment      = l_environment
      c_errorhandler     = c_errorhandler.
  IF e_rc <> 0.
    EXIT.
  ENDIF.

* Falls keine Ankerleistung gefunden wurde, dann kann es sich nur um
* eine Not-OP handeln, die eben noch keine Ankerleistung hat.
* Die Ankerleistung wird dann erst beim Ausführen einer Funktion für
* diese Not-OP angelegt ...
  DESCRIBE TABLE lt_a_srv.
  IF sy-tfill = 0.
*   ... daher diese Not-OP anhand der OP-Bewegung identifizieren
*   START MED-40483
      CALL METHOD cl_ishmed_functions=>get_apps_and_movs
        EXPORTING
          it_objects        = lt_object
          i_cancelled_datas = g_cancelled_data
          i_read_db         = abap_false
        IMPORTING
          e_rc              = e_rc
          et_appointments   = lt_apps
          et_movements      = lt_moves
        CHANGING
          c_environment     = l_environment
          c_errorhandler    = c_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
*   Nun auch noch prüfen, ob es sich bei dieser Bewegung auch
*   tatsächlich um eine OP-Bewegung handelt
      READ TABLE lt_moves INTO lr_move INDEX 1.
      IF sy-subrc = 0.
        CALL FUNCTION 'ISHMED_NBEW_CHECK_OP_TYPE'
          EXPORTING
            i_movement_obj = lr_move
          IMPORTING
            e_rc           = e_rc
            e_op_bew       = l_op_ok
          CHANGING
            c_errorhandler = c_errorhandler.
        IF e_rc <> 0.
          EXIT.
        ENDIF.
        IF l_op_ok = off.
          e_rc = 99.                            " Keine OP-Bewegung!
          EXIT.
        ELSE.
*       OK, es handelt sich um eine Not-OP (noch) ohne Ankerleistung!
*       also nur OP-Bewegung und ev. OP-Termin merken.
          gr_movement = lr_move.
          READ TABLE lt_apps INTO l_app INDEX 1.
          IF sy-subrc = 0.
            g_appointment = l_app.
          ENDIF.
        ENDIF.
      ELSE.
*     Keine Bewegung vorhanden
        READ TABLE lt_apps INTO l_app INDEX 1.
        IF sy-subrc = 0.
*       Termin ohne Bewegung und ohne Ankerleistung ist
*       eigentlich nie eine Operation!
          e_rc = 99.                            " Kein OP-Termin!
        ELSE.
          e_rc = 1.
        ENDIF.
        EXIT.
      ENDIF.
*   Globale Detaildaten befüllen
      IF gr_movement IS NOT INITIAL.
        CALL METHOD gr_movement->get_data
          IMPORTING
            e_rc           = e_rc
            e_nbew         = l_nbew
          CHANGING
            c_errorhandler = c_errorhandler.
        IF e_rc = 0.
          g_erboe = l_nbew-orgpf.
          g_anpoe = l_nbew-orgpf.
          g_anfoe = l_nbew-orgfa.
        ELSE.
          EXIT.
        ENDIF.
      ENDIF.

*      CALL METHOD cl_ishmed_functions=>get_apps_and_movs
*        EXPORTING
*          it_objects        = lt_object
*          i_cancelled_datas = g_cancelled_data
*        IMPORTING
*          e_rc              = e_rc
*          et_appointments   = lt_apps
*          et_movements_none = lt_movs
*        CHANGING
*          c_environment     = l_environment
*          c_errorhandler    = c_errorhandler.
*      IF e_rc <> 0.
*        EXIT.
*      ENDIF.
**   Nun auch noch prüfen, ob es sich bei dieser Bewegung auch
**   tatsächlich um eine OP-Bewegung handelt
*      READ TABLE lt_movs INTO l_mov INDEX 1.
*      IF sy-subrc = 0.
*        CALL FUNCTION 'ISHMED_NBEW_CHECK_OP_TYPE'
*          EXPORTING
*            i_movement     = l_mov
*          IMPORTING
*            e_rc           = e_rc
*            e_op_bew       = l_op_ok
*          CHANGING
*            c_errorhandler = c_errorhandler.
*        IF e_rc <> 0.
*          EXIT.
*        ENDIF.
*        IF l_op_ok = off.
*          e_rc = 99.                            " Keine OP-Bewegung!
*          EXIT.
*        ELSE.
**       OK, es handelt sich um eine Not-OP (noch) ohne Ankerleistung!
**       also nur OP-Bewegung und ev. OP-Termin merken.
*          g_movement = l_mov.
*          READ TABLE lt_apps INTO l_app INDEX 1.
*          IF sy-subrc = 0.
*            g_appointment = l_app.
*          ENDIF.
*        ENDIF.
*      ELSE.
**     Keine Bewegung vorhanden
*        READ TABLE lt_apps INTO l_app INDEX 1.
*        IF sy-subrc = 0.
**       Termin ohne Bewegung und ohne Ankerleistung ist
**       eigentlich nie eine Operation!
*          e_rc = 99.                            " Kein OP-Termin!
*        ELSE.
*          e_rc = 1.
*        ENDIF.
*        EXIT.
*      ENDIF.
**   Globale Detaildaten befüllen
*      IF g_movement IS NOT INITIAL.
*        CALL METHOD g_movement->get_data
*          IMPORTING
*            e_rc           = e_rc
*            e_nbew         = l_nbew
*          CHANGING
*            c_errorhandler = c_errorhandler.
*        IF e_rc = 0.
*          g_erboe = l_nbew-orgpf.
*          g_anpoe = l_nbew-orgpf.
*          g_anfoe = l_nbew-orgfa.
*        ELSE.
*          EXIT.
*        ENDIF.
*      ENDIF.
*   END MED-40483
  ELSE.
*   Es handelt sich um eine OP mit Ankerleistung!
*   Das kann eine angeforderte, vorgemerkte oder auch Not-OP sein.
*   Prüfen, ob die OP storniert ist (nicht nur im Prüfmodus!)
    l_cancelled = on.
    LOOP AT lt_a_srv INTO l_a_srv.
      CALL METHOD l_a_srv->get_data
        IMPORTING
          e_rc           = e_rc
          e_nlei         = l_nlei
          e_nlem         = l_nlem
        CHANGING
          c_errorhandler = c_errorhandler.
      IF e_rc = 0.
        IF l_nlem-ankls = 'X' AND l_nlei-storn = off.
          l_cancelled = off.
          EXIT.
        ENDIF.
      ELSE.
        EXIT.
      ENDIF.
    ENDLOOP.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    IF l_cancelled = on.
*     OP ist storniert!
      g_cancelled = on.
*     Wenn die OP storniert ist, dann auch das Kennzeichen 'Stornierte
*     Daten lesen' auf ON setzen, damit alle Daten zur stornierten OP
*     gefunden werden können
      g_cancelled_data = on.
    ENDIF.
    IF i_check_only = off.
*     Globale Daten ermitteln und merken, nur wenn nicht im 'Prüfmodus'!
*     Leistungen global merken
      LOOP AT lt_a_srv INTO l_a_srv.
        CALL METHOD l_a_srv->get_data
          IMPORTING
            e_rc           = e_rc
            e_nlei         = l_nlei
            e_nlem         = l_nlem
          CHANGING
            c_errorhandler = c_errorhandler.
        IF e_rc = 0.
*         Stornierte Leistungen nur behalten, wenn die Anzeige von
*         stornierten Daten gewünscht ist oder wenn die OP storniert ist
          IF g_cancelled_data = off AND l_nlei-storn = on.
            CONTINUE.
          ENDIF.
          IF l_nlem-ankls = 'X'.
*           OP-Ankerleistung
            g_anchor_service = l_a_srv.
            l_nlei_anchor = l_nlei.
          ELSEIF l_nlem-ankls = 'A'.
*           AN-Ankerleistung
            g_an_anchor_service = l_a_srv.
          ENDIF.
        ELSE.
          EXIT.
        ENDIF.
      ENDLOOP.
      IF e_rc <> 0 OR g_anchor_service IS INITIAL.
        EXIT.
      ENDIF.
*     OP-Leistungen
      IF g_cancelled_data = off.
*       Stornierte Leistungen nur behalten, wenn die Anzeige von
*       stornierten Daten gewünscht ist oder wenn die OP storniert ist
        LOOP AT lt_srv INTO l_srv.
          CALL METHOD l_srv->get_data
            IMPORTING
              e_rc           = e_rc
              e_nlei         = l_nlei
            CHANGING
              c_errorhandler = c_errorhandler.
          IF e_rc = 0.
            IF l_nlei-storn = on.
              DELETE lt_srv.
            ENDIF.
          ELSE.
            EXIT.
          ENDIF.
        ENDLOOP.
        IF e_rc <> 0.
          EXIT.
        ENDIF.
      ENDIF.
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
*     OP-Termin
*     START MED-40483 2010/06/30
        IF g_nosave = abap_true.
          l_read_over_anchor = abap_true.
        ELSE.
          l_read_over_anchor = abap_false.
        ENDIF.
*       END MED-40483
        CALL METHOD cl_ishmed_service=>get_appmnt_for_service
          EXPORTING
            i_service          = g_anchor_service
            i_environment      = l_environment
            i_read_over_anchor = l_read_over_anchor "MED-40483
            i_cancelled_datas  = g_cancelled_data
          IMPORTING
            e_ntmn             = l_vntmn
            e_appointment      = g_appointment
            e_rc               = e_rc
          CHANGING
            c_errorhandler     = c_errorhandler.

      IF e_rc <> 0.
        EXIT.
      ENDIF.
*     OP-Bewegung
      IF NOT g_appointment IS INITIAL AND NOT l_vntmn-tmnlb IS INITIAL.
*       START MED-40483 2010/07/07
*       this object works now with the rundata object of movement
          CALL METHOD g_appointment->get_movement
            EXPORTING
              i_cancelled_datas = g_cancelled_data
            IMPORTING
              er_movement       = lr_move
              e_rc              = e_rc
            CHANGING
              cr_errorhandler   = c_errorhandler.
          IF e_rc <> 0.
            EXIT.
          ENDIF.
          gr_movement = lr_move.
*          CALL METHOD cl_ishmed_none_oo_nbew=>load
*            EXPORTING
*              i_einri        = l_vntmn-einri
*              i_falnr        = l_vntmn-falnr
*              i_lfdnr        = l_vntmn-tmnlb
*            IMPORTING
*              e_instance     = l_mov
*              e_rc           = e_rc
*            CHANGING
*              c_errorhandler = c_errorhandler.
*          IF e_rc <> 0.
*            EXIT.
*          ENDIF.
*          g_movement = l_mov.
*       END MED-40483
      ELSEIF NOT l_nlei-lfdbew IS INITIAL.
*       START MED-40483 2010/07/07
*       this object works now with the rundata object of movement
          CALL METHOD cl_ishmed_service=>get_movement_for_service
            EXPORTING
              i_service          = g_anchor_service
              i_read_over_anchor = abap_false
              i_cancelled_datas  = g_cancelled_data
            IMPORTING
              e_movement         = lr_move
              e_rc               = e_rc
            CHANGING
              c_errorhandler     = c_errorhandler.
          IF e_rc <> 0.
            EXIT.
          ENDIF.
          gr_movement = lr_move.
*          CALL METHOD cl_ishmed_none_oo_nbew=>load
*            EXPORTING
*              i_einri        = l_nlei-einri
*              i_falnr        = l_nlei-falnr
*              i_lfdnr        = l_nlei-lfdbew
*            IMPORTING
*              e_instance     = l_mov
*              e_rc           = e_rc
*            CHANGING
*              c_errorhandler = c_errorhandler.
*          IF e_rc <> 0.
*            EXIT.
*          ENDIF.
*          g_movement = l_mov.
*       END MED-40483
      ENDIF.
*     OP-Anforderung bzw. Klinische OP-Auftragsposition
      CALL METHOD cl_ishmed_service=>get_serv_for_anfo_vkg
        EXPORTING
          i_service         = g_anchor_service
          i_environment     = l_environment
          i_cancelled_datas = g_cancelled_data
        IMPORTING
          e_rc              = e_rc
          e_request         = g_request
          e_prereg          = g_prereg
        CHANGING
          c_errorhandler    = c_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
      IF g_request IS INITIAL AND g_prereg IS INITIAL.
        LOOP AT gt_services INTO l_srv.
          CALL METHOD cl_ishmed_service=>get_serv_for_anfo_vkg
            EXPORTING
              i_service         = l_srv
              i_environment     = l_environment
              i_cancelled_datas = g_cancelled_data
            IMPORTING
              e_rc              = e_rc
              e_request         = g_request
              e_prereg          = g_prereg
            CHANGING
              c_errorhandler    = c_errorhandler.
          IF e_rc <> 0.
            EXIT.
          ELSE.
            IF NOT g_request IS INITIAL OR NOT g_prereg IS INITIAL.
              EXIT.
            ENDIF.
          ENDIF.
        ENDLOOP.
        IF e_rc <> 0.
          EXIT.
        ENDIF.
      ENDIF.
*     OP-Team
      CALL METHOD cl_ishmed_service=>get_team_for_service
        EXPORTING
          i_service         = g_anchor_service
          i_environment     = l_environment
          i_cancelled_datas = g_cancelled_data
          i_read_db         = abap_false                     "MED-40483
        IMPORTING
          e_rc              = e_rc
          et_team           = lt_team
        CHANGING
          c_errorhandler    = c_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
      LOOP AT lt_team INTO l_team_obj.
        l_team ?= l_team_obj-object.
        APPEND l_team TO gt_team.
      ENDLOOP.
*     Globale Detaildaten befüllen
      g_erboe = l_nlei_anchor-erboe.
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
  ENDIF.

* Zuletzt Environment ebenfalls global merken
  g_environment = l_environment.

ENDMETHOD.


METHOD if_ish_display_object~set_node .

  g_node_open = i_node_open.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.
  e_object_type = co_otype_dspobj_operation.                "MED-33929
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


METHOD if_ish_identify_object~is_inherited_from.
  IF i_object_type = co_otype_dspobj_operation.             "MED-33929
    r_is_inherited_from = on.                               "MED-33929
  ENDIF.                                                    "MED-33929
ENDMETHOD.


METHOD SET_NDIA.
* MED-40483
  gt_ndia = it_ndia.
ENDMETHOD.


METHOD set_nosave.
*New/PN/MED-40483
  g_nosave = i_nosave.
ENDMETHOD.


METHOD set_patients_anonym .

  g_anonym = i_anonym.

ENDMETHOD.


METHOD set_team_aufgaben .

  gt_aufg1[] = it_aufg1[].
  gt_aufg2[] = it_aufg2[].
  gt_aufg3[] = it_aufg3[].
  gt_aufg4[] = it_aufg4[].

ENDMETHOD.
ENDCLASS.
