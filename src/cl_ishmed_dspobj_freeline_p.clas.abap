class CL_ISHMED_DSPOBJ_FREELINE_P definition
  public
  final
  create public .

public section.
*"* public components of class CL_ISHMED_DSPOBJ_FREELINE_P
*"* do not include other source files here!!!
  type-pools ICON .

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_DISPLAY_OBJECT .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
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

  constants CO_OTYPE_DSPOBJ_FREELINE_PLAN type ISH_OBJECT_TYPE value 1002. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_OBJECT type N1OBJECTREF
      !I_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !I_NODE_OPEN type ISH_ON_OFF default ' '
      value(I_CHECK_ONLY) type ISH_ON_OFF default 'X'
    exceptions
      INSTANCE_NOT_POSSIBLE
      NO_OPERATION .
protected section.
*"* protected components of class CL_ISHMED_DSPOBJ_FREELINE_P
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
  aliases G_NODE_OPEN
    for IF_ISH_DISPLAY_OBJECT~G_NODE_OPEN .
  aliases G_OBJECT
    for IF_ISH_DISPLAY_OBJECT~G_OBJECT .
  aliases INITIALIZE
    for IF_ISH_DISPLAY_OBJECT~INITIALIZE .
  aliases SET_MAIN_DATA
    for IF_ISH_DISPLAY_OBJECT~SET_MAIN_DATA .

  data G_PLAN_DATA type RN1FREELINE_PLAN .
private section.
*"* private components of class CL_ISHMED_DSPOBJ_FREELINE_P
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISHMED_DSPOBJ_FREELINE_P IMPLEMENTATION.


METHOD CONSTRUCTOR .

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
  l_environment = i_environment.

* Prüfen, ob das Objekt angelegt werden kann
  CALL METHOD me->set_main_data
    EXPORTING
      i_object      = i_object
      i_check_only  = i_check_only
    IMPORTING
      e_rc          = l_rc
    CHANGING
      c_environment = l_environment.
*      C_ERRORHANDLER =

  CASE l_rc.
    WHEN 0.
*     OK
      g_object    = i_object.
      g_node_open = i_node_open.
    WHEN OTHERS.
*     Fehler
      RAISE instance_not_possible.
  ENDCASE.

ENDMETHOD.


METHOD IF_ISH_DISPLAY_OBJECT~CLOSE_NODE .

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

  DATA: lt_outtab          LIKE et_outtab,
        l_outtab           LIKE LINE OF lt_outtab,
        l_fieldcat         LIKE LINE OF it_fieldcat,
        ls_sel_crit        LIKE LINE OF it_selection_criteria,
        lt_natm            TYPE ishmed_t_vnatm,
        l_natm             LIKE LINE OF lt_natm,
        lt_pobnr_date      TYPE ishmed_t_pobnr_date,
        ls_pobnr_date      LIKE LINE OF lt_pobnr_date,
        lt_pobdc           TYPE ishmed_t_pobdc_by_pobnr_date,
        ls_pobdc           LIKE LINE OF lt_pobdc,
        lr_pobdc           TYPE REF TO cl_ishmed_pobdc,
        l_modcomment_cnt   TYPE i,
        l_modcomment_found TYPE ish_on_off,
        l_dsp_kurz         TYPE ish_on_off,
        l_dsp_modcomment   TYPE ish_on_off,
        l_dsp_released     TYPE ish_on_off,
        l_released         TYPE ish_on_off,
        ls_n1applan        TYPE n1applan,
        l_rc               TYPE ish_method_rc,
        l_icon             TYPE nwicons-icon,
        l_freeline         TYPE REF TO cl_ishmed_none_oo_freeline_p.

  CLEAR e_rc.
  REFRESH et_outtab.
  REFRESH lt_outtab.
  REFRESH gt_outtab.

* Errorhandler instanzieren, falls nötig
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Grundlegende OP-Daten lesen
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

* Anzuzeigende Daten anhand des Feldkatalogs bestimmen
  CLEAR: l_dsp_modcomment, l_dsp_released, l_dsp_kurz.
  LOOP AT it_fieldcat INTO l_fieldcat WHERE no_out = off.
    CASE l_fieldcat-fieldname.
      WHEN 'MODCOMMENT' OR 'MODCOMMENT_ICON'.
        l_dsp_modcomment = on.
      WHEN 'RELEASED_ICON'   OR 'APCOMMENT'       OR
           'RELEASE_STATINT' OR 'RELEASE_STATEXT'.
        l_dsp_released = on.
      WHEN 'ROOM_K' OR 'PLANOE_K' OR 'ROOM_KB' OR 'PLANOE_KB'.
        l_dsp_kurz = on.
    ENDCASE.
  ENDLOOP.

* Ausgabetabelle befüllen
  IF NOT g_plan_data IS INITIAL.
    CLEAR l_outtab.
*   Erzeugendes Objekt (=Transportobjekt 'Freizeile Planung')
    l_outtab-impobj     = g_object.
*   Anzeigeobjekt selbst
    l_outtab-dspobj     = me.
*   Identifier (=Transportobjekt 'Freizeile Planung')
    l_outtab-object     = g_object.
    l_outtab-einri      = g_plan_data-einri.
    l_outtab-date       = g_plan_data-date.
    l_outtab-time       = g_plan_data-time.
    l_outtab-planoe     = g_plan_data-orgid.
    l_outtab-room       = g_plan_data-bauid.
*   Wochentag
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
*   Text 'frei' nur anzeigen, wenn eine OE vorhanden ist
    IF NOT g_plan_data-pobnr IS INITIAL.
      l_outtab-pnamec   = 'frei'(001).
      l_outtab-pnamec1  = 'frei'(001).
    ENDIF.
*   build line key
    l_freeline ?= g_object.
    CALL METHOD l_freeline->build_line_key
      IMPORTING
        e_line_key = l_outtab-keyno.
    l_outtab-seqno = '000'.                   " free line!
*   Zeiten (00:00) nicht anzeigen
    IF l_outtab-time IS INITIAL.
      IF g_plan_data-orgid IS INITIAL OR g_plan_data-pobnr IS INITIAL.
        l_outtab-time  = '      '.
      ENDIF.
    ENDIF.
    l_outtab-wtime         = '      '.
    l_outtab-tmpzt         = '      '.
    l_outtab-afnzt         = '      '.
    l_outtab-ztmk_zeit     = '      '.
    l_outtab-todzt         = '      '.
    l_outtab-todzb         = '      '.
    l_outtab-opbeg_time    = '      '.                      " MED-41209
    l_outtab-prgs_time_beg = '      '.                      " MED-41209
    l_outtab-prgs_time_end = '      '.                      " MED-41209

*   ID 13138: Tageskommentar ermitteln
    IF l_dsp_modcomment = on AND NOT g_plan_data-pobnr IS INITIAL.
      IF cl_ishmed_switch_check=>ishmed_scd( ) = on.
        CLEAR ls_pobnr_date.
        ls_pobnr_date-pobnr = g_plan_data-pobnr.
        ls_pobnr_date-date  = l_outtab-date.
        APPEND ls_pobnr_date TO lt_pobnr_date.
        CALL METHOD cl_ishmed_utl_pobdc=>get_pobdc_by_t_pobnr_date
          EXPORTING
            it_pobnr_date          = lt_pobnr_date
*             i_refresh              = ABAP_FALSE
*             i_check_pob_timestamp  = ABAP_FALSE
            ir_environment         = g_environment
*Sta/PN/MED-40483
*           adjustment from memory not necessary
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
          LOOP AT lt_pobdc INTO ls_pobdc WHERE pobnr = g_plan_data-pobnr
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
            i_pobnr           = g_plan_data-pobnr
            i_date            = l_outtab-date
*             I_CANCELLED_DATAS =
*Sta/PN/MED-40483
*            adjustment from memory not necessary
*            i_environment     = g_environment
*End/PN/MED-40483
            i_buffer_active   = off
*             I_READ_DB         = SPACE
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
*   ID 15455: Freigabe (does a released plan exist?)
*   read if cell color should be changed or
*   if column should be displayed
    CLEAR ls_sel_crit.
    READ TABLE it_selection_criteria INTO ls_sel_crit
                                     WITH KEY selname = 'P_RLPLAN'.
    IF l_dsp_released = on OR ls_sel_crit-low = off.
      CALL METHOD cl_ishmed_utl_app_rls=>check_app_released
        EXPORTING
          i_einri         = g_plan_data-einri
          i_pobnr         = g_plan_data-pobnr
          i_orgid         = g_plan_data-orgid
          i_date          = g_plan_data-date
          i_time          = g_plan_data-time
          ir_environment  = g_environment
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
*   ID 19134: get short key (Kürzel) for room and plan ou
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
*   append outtab-line
    APPEND l_outtab TO lt_outtab.
  ENDIF.

  et_outtab[] = lt_outtab[].
  gt_outtab[] = lt_outtab[].

ENDMETHOD.


METHOD if_ish_display_object~destroy .

  CALL METHOD me->initialize.

  FREE: gt_subobjects,
        gt_outtab.

  FREE: g_object,
        g_environment.

ENDMETHOD.


METHOD if_ish_display_object~get_data .

  DATA: l_object      LIKE LINE OF et_object.

  REFRESH: et_object.

* Erzeugendes Objekt (immer Transportobjekt 'Freizeile Planung')
  IF NOT g_object IS INITIAL.
    l_object-object = g_object.
    APPEND l_object TO et_object.
  ENDIF.

ENDMETHOD.


METHOD if_ish_display_object~get_fieldcatalog .

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
  LOOP AT lt_fieldcat INTO l_fieldcat.
    CASE l_fieldcat-fieldname.
*     patient data
      WHEN 'PNAMEC' OR 'PNAMEC1'.
        l_fieldcat-sp_group = 'P'.
        IF l_fieldcat-fieldname EQ 'PNAMEC1'.
          l_fieldcat-colddictxt = 'R'.
        ENDIF.
*     planning data
      WHEN 'DATE' OR 'TIME' OR 'ROOM' OR 'ERBOE'.
        l_fieldcat-sp_group = 'O'.
*     technical fields (all others)
      WHEN OTHERS.
        l_fieldcat-tech = on.
        l_fieldcat-no_out = on.
    ENDCASE.
    l_fieldcat-no_sum = on.
    l_fieldcat-tipddictxt = 'L'.
    l_fieldcat-ref_field = l_fieldcat-fieldname.
    l_fieldcat-seltext = l_fieldcat-scrtext_l.
    l_fieldcat-tooltip = l_fieldcat-scrtext_l.
    IF l_fieldcat-outputlen IS INITIAL.
      l_fieldcat-outputlen = l_fieldcat-dd_outlen.
    ENDIF.
*   time-fields -> don't display seconds
    IF l_fieldcat-fieldname EQ 'TIME'.
      l_fieldcat-edit_mask = '__:__'.
    ENDIF.
    l_fieldcat-tooltip    = l_fieldcat-seltext.
    l_fieldcat-tipddictxt = l_fieldcat-seltext.
    IF l_fieldcat-coltext IS INITIAL.
      l_fieldcat-coltext  = l_fieldcat-reptext.
    ENDIF.
    l_fieldcat-key = off.
    MODIFY lt_fieldcat FROM l_fieldcat.
  ENDLOOP.

* Feldkatalog zurückliefern
  et_fieldcat[] = lt_fieldcat[].

ENDMETHOD.


METHOD if_ish_display_object~get_merged_values .

  DATA: l_outtab          LIKE LINE OF gt_outtab,
        l_nmf             LIKE LINE OF et_no_merge_fields.

  CLEAR e_outtab.
  REFRESH et_no_merge_fields.

  LOOP AT gt_outtab INTO l_outtab WHERE seqno = 0.

*   Laufende Satznummer
    CLEAR: l_outtab-seqno.

    e_outtab = l_outtab.

  ENDLOOP.

* alle diese Feldnamen auch in der Tabelle retournieren
  l_nmf = 'SEQNO'. APPEND l_nmf TO et_no_merge_fields.

ENDMETHOD.


METHOD IF_ISH_DISPLAY_OBJECT~GET_TYPE .

  e_object_type = co_otype_dspobj_freeline_plan.

ENDMETHOD.


METHOD IF_ISH_DISPLAY_OBJECT~INITIALIZE .

  REFRESH: gt_subobjects,
           gt_outtab.

  CLEAR:   g_object,
           g_environment,
           g_cancelled,
           g_cancelled_data.

ENDMETHOD.


METHOD if_ish_display_object~is_cancelled .

  e_cancelled = g_cancelled.

ENDMETHOD.


METHOD if_ish_display_object~load .

  DATA: l_rc          TYPE sy-subrc.

  CLEAR: e_rc, e_instance, e_cancelled.

* Errorhandler instanzieren, falls nötig
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Anzeigeobjekt instanzieren
  g_construct = on.
  CREATE OBJECT e_instance TYPE cl_ishmed_dspobj_freeline_p
    EXPORTING
      i_object              = i_object
      i_environment         = c_environment
      i_node_open           = i_node_open
      i_check_only          = i_check_only
    EXCEPTIONS
      instance_not_possible = 1
      OTHERS                = 2.
  l_rc = sy-subrc.
  g_construct = off.

  CASE l_rc.
    WHEN 0.
*     OK - Anzeigeobjekt wurde instanziert
    WHEN OTHERS.
*     Fehler beim Instanzieren des Anzeigeobjekts
      e_rc = 1.
      CLEAR e_instance.
      EXIT.
  ENDCASE.

* Ereignis auslösen: Daten wurden gelesen
  RAISE EVENT after_read
    EXPORTING
      i_object = e_instance.

ENDMETHOD.


METHOD IF_ISH_DISPLAY_OBJECT~OPEN_NODE .

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


METHOD if_ish_display_object~remove_data .  "#EC NEEDED

ENDMETHOD.


METHOD if_ish_display_object~set_main_data .

  DATA: l_object_type   TYPE i,
        l_freeline      TYPE REF TO cl_ishmed_none_oo_freeline_p,
        lt_object       TYPE ish_objectlist,
        l_object        LIKE LINE OF lt_object.

* Initialisierungen
  CLEAR e_rc.

  CLEAR: g_plan_data.

* Notwendige Übergabedaten prüfen
  IF i_object IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* Errorhandler instanzieren, falls nötig
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Prüfen, ob das Übergabeobjekt vom Type 'Freizeile Planung' ist
  CALL METHOD i_object->('GET_TYPE')
    IMPORTING
      e_object_type = l_object_type.
  IF l_object_type <>
     cl_ishmed_none_oo_freeline_p=>co_otype_none_oo_freeline_plan.
    e_rc = 1.
    EXIT.
  ENDIF.

  IF i_check_only = off.
*   Nicht mehr nur prüfen -> jetzt Daten auch global merken!
    l_freeline ?= i_object.
    CALL METHOD l_freeline->get_data
      IMPORTING
        e_rc           = e_rc
        e_plan_data    = g_plan_data
      CHANGING
        c_errorhandler = c_errorhandler.
  ENDIF.                                   " IF i_check_only = on.

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

* Zuletzt Environment ebenfalls global merken
  g_environment = c_environment.

ENDMETHOD.


METHOD IF_ISH_DISPLAY_OBJECT~SET_NODE .

  g_node_open = i_node_open.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.
  e_object_type = co_otype_dspobj_freeline_plan.            "MED-33929
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
  IF i_object_type = co_otype_dspobj_freeline_plan.         "MED-33929
    r_is_inherited_from = on.                               "MED-33929
  ENDIF.                                                    "MED-33929
endmethod.
ENDCLASS.
