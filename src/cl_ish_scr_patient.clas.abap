class CL_ISH_SCR_PATIENT definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

*"* public components of class CL_ISH_SCR_PATIENT
*"* do not include other source files here!!!
public section.

  constants CO_DEFAULT_TABNAME type TABNAME value 'NPAT'. "#EC NOTEXT
  constants CO_FIELDNAME_PATNR type ISH_FIELDNAME value 'PATNR'. "#EC NOTEXT
  constants CO_FIELDNAME_PAP type ISH_FIELDNAME value 'PAP'. "#EC NOTEXT
  constants CO_OTYPE_SCR_PATIENT type ISH_OBJECT_TYPE value 7013. "#EC NOTEXT

  methods GET_SCR_PATIENT_SUB
    returning
      value(RR_SCR_PATIENT_SUB) type ref to CL_ISHMED_PATIENT_PROVISIONAL .
  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCR_PATIENT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DYNPRO_PAT
    exporting
      value(E_PGM_PAT) type SY-REPID
      value(E_DYNNR_PAT) type SY-DYNNR .
  methods DEQUEUE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHANGE_PAT_PROVI
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_PATNR) type NPAT-PATNR
      !ER_PAT_PROVI type ref to CL_ISH_PATIENT_PROVISIONAL
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_A
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~CLEAR_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~GET_DEF_CRS_POSSIBLE
    redefinition .
  methods IF_ISH_SCREEN~GET_FIELDS_DEFINITION
    redefinition .
  methods IF_ISH_SCREEN~GET_FIELDS_VALUE
    redefinition .
  methods IF_ISH_SCREEN~IS_FIELD_INITIAL
    redefinition .
  methods IF_ISH_SCREEN~SET_CURSOR
    redefinition .
  methods IF_ISH_SCREEN~SET_FIELDVAL_FROM_DATA
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_FROM_DY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_PATIENT
*"* do not include other source files here!!!

  data GR_PATIENT_SUB type ref to CL_ISHMED_PATIENT_PROVISIONAL .
  data GR_PAT_PROVI type ref to CL_ISH_PATIENT_PROVISIONAL .
  data G_PGM_PAT type SY-REPID .
  data G_DYNNR_PAT type SY-DYNNR .

  methods BUILD_MESSAGE
    redefinition .
  methods FILL_T_SCRM_FIELD
    redefinition .
  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods INITIALIZE_INTERNAL
    redefinition .
  methods INITIALIZE_PARENT
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_PATIENT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_PATIENT IMPLEMENTATION.


METHOD build_message.

  DATA: l_rc                  TYPE ish_method_rc,
        l_ok                  TYPE ish_on_off,
        l_type                TYPE i,
        lr_prov_pat           TYPE REF TO cl_ish_patient_provisional,
        lr_corder             TYPE REF TO cl_ish_corder.

* Call super method.
  CALL METHOD super->build_message
    EXPORTING
      is_message    = is_message
      i_cursorfield = i_cursorfield
    IMPORTING
      es_message    = es_message.

* get provisional patient of object
  CALL METHOD cl_ish_utl_base_patient=>get_patient_of_obj
    EXPORTING
      ir_object = gr_main_object
    IMPORTING
      er_pap    = lr_prov_pat
      e_rc      = l_rc.
  CHECK l_rc = 0.

* Handle only errors on selfs main object.
  IF NOT is_message-object IS INITIAL       AND
     NOT is_message-object = gr_main_object AND
     NOT is_message-object = lr_prov_pat.
    CLEAR: es_message-parameter,
           es_message-field.
    EXIT.
  ENDIF.

* Wrap es_message-parameter.
  CASE es_message-parameter.
    WHEN 'N1CORDER' OR 'IS_DATA' OR 'NPAP'.
      es_message-parameter = 'NPAT'.
      CASE es_message-field.
        WHEN 'PAPID'.
          es_message-field = 'NNAME'.
      ENDCASE.
  ENDCASE.

* set cursor
  CALL METHOD gr_patient_sub->set_cursor
    CHANGING
      c_rn1message = es_message.

ENDMETHOD.


METHOD change_pat_provi.

  DATA: l_dynnr_pat   TYPE sy-dynnr,
        l_pgm_pat     TYPE sy-repid,
        lt_dynpfields TYPE TABLE OF dynpread,
        ls_dynpfields TYPE dynpread,
        ls_pat_provi  TYPE rnpap_attrib,
        l_patnr       TYPE npat-patnr,
        ls_npat       TYPE npat,
        lt_fields     TYPE dyfatc_tab,
        ls_fields     TYPE rpy_dyfatc,
        ls_change     TYPE rnpap_attrib_x,
        l_gschl       TYPE npat-gschl.

* initialize the local fields, workareas and tables
  CLEAR: l_dynnr_pat,
         l_pgm_pat,
         ls_dynpfields,
         ls_pat_provi,
         l_patnr,
         ls_npat,
         ls_change,
         ls_fields.
  REFRESH: lt_dynpfields,
           lt_fields.
* initialize the exporting parameters
  CLEAR: e_rc,
         e_patnr,
         er_pat_provi.

* if errorhandler is initial -> initialize
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.


* now get the program and dynpro of the patient subscreen
  l_dynnr_pat = g_dynnr_pat.
  l_pgm_pat   = g_pgm_pat.

  IF l_dynnr_pat IS INITIAL.
    CALL METHOD me->get_dynpro_pat
      IMPORTING
        e_dynnr_pat = l_dynnr_pat.
  ENDIF.

  IF l_pgm_pat IS INITIAL.
    CALL METHOD me->get_dynpro_pat
      IMPORTING
        e_pgm_pat = l_pgm_pat.
  ENDIF.

* only go on if the program and dynpro are not initial
  CHECK NOT l_dynnr_pat IS INITIAL AND
        NOT l_pgm_pat IS INITIAL.

* get the dynpro fields
  CALL FUNCTION 'RPY_DYNPRO_READ'
    EXPORTING
      progname             = l_pgm_pat
      dynnr                = l_dynnr_pat
    TABLES
      fields_to_containers = lt_fields
    EXCEPTIONS
      cancelled            = 1
      not_found            = 2
      permission_error     = 3
      OTHERS               = 4.
  e_rc = sy-subrc.
  IF e_rc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = sy-msgty
        i_kla = sy-msgid
        i_num = sy-msgno
        i_mv1 = sy-msgv1
        i_mv2 = sy-msgv2
        i_mv3 = sy-msgv3
        i_mv4 = sy-msgv4.
    EXIT.
  ENDIF.
  CHECK NOT lt_fields[] IS INITIAL.
* give the fields in the dynprofield table
  LOOP AT lt_fields INTO ls_fields WHERE type = 'TEMPLATE'.
    ls_dynpfields-fieldname = ls_fields-name.
    APPEND ls_dynpfields TO lt_dynpfields.
  ENDLOOP.
  CHECK NOT lt_dynpfields[] IS INITIAL.

  CALL FUNCTION 'ISH_DYNP_VALUES_READ'
    EXPORTING
      dyname               = l_pgm_pat
      dynumb               = l_dynnr_pat
    TABLES
      dynpfields           = lt_dynpfields
    EXCEPTIONS
      invalid_abapworkarea = 1
      invalid_dynprofield  = 2
      invalid_dynproname   = 3
      invalid_dynpronummer = 4
      invalid_request      = 5
      no_fielddescription  = 6
      undefind_error       = 7
      OTHERS               = 8.
  e_rc = sy-subrc.
  IF e_rc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = sy-msgty
        i_kla = sy-msgid
        i_num = sy-msgno
        i_mv1 = sy-msgv1
        i_mv2 = sy-msgv2
        i_mv3 = sy-msgv3
        i_mv4 = sy-msgv4.
    EXIT.
  ENDIF.
  CHECK NOT lt_dynpfields[] IS INITIAL.

* get the fields and the values
  LOOP AT lt_dynpfields INTO ls_dynpfields.
    CASE ls_dynpfields-fieldname.
      WHEN 'NPAT-NNAME'.
        ls_pat_provi-nname = ls_dynpfields-fieldvalue.
        ls_change-nnamex = on.
      WHEN 'NPAT-TITEL'.
        ls_pat_provi-titel = ls_dynpfields-fieldvalue.
        ls_change-titelx = on.
      WHEN 'NPAT-VNAME'.
        ls_pat_provi-vname = ls_dynpfields-fieldvalue.
        ls_change-vnamex = on.
      WHEN 'NPAT-NAMZU'.
        ls_pat_provi-namzu = ls_dynpfields-fieldvalue.
        ls_change-namzux = on.
      WHEN 'NPAT-GBNAM'.
        ls_pat_provi-gbnam = ls_dynpfields-fieldvalue.
        ls_change-gbnamx = on.
      WHEN 'NPAT-VORSW'.
        ls_pat_provi-vorsw = ls_dynpfields-fieldvalue.
        ls_change-vorswx = on.
      WHEN 'NPAT-GBDAT'.
        ls_pat_provi-gbdat = ls_dynpfields-fieldvalue.
        ls_change-gbdatx = on.
      WHEN 'NPAT-GSCHL'.
        IF NOT ls_dynpfields-fieldvalue IS INITIAL.
          l_gschl = ls_dynpfields-fieldvalue.
          CALL FUNCTION 'ISH_CONVERT_SEX_OUTPUT'
            EXPORTING
              ss_gschl  = l_gschl
              ss_langu  = sy-langu
            IMPORTING
              ss_gschle = ls_pat_provi-gschle
            EXCEPTIONS
              not_found = 1
              OTHERS    = 2.
          IF sy-subrc <> 0.
            CLEAR ls_pat_provi-gschle.
          ENDIF.
          ls_change-gschlex = on.
        ENDIF.
      WHEN 'RNPB2-EXTNR'.
        ls_pat_provi-extnr = ls_dynpfields-fieldvalue.
        ls_change-extnrx = on.
      WHEN 'NPAT-PATNR'.
        l_patnr = ls_dynpfields-fieldvalue.
    ENDCASE.
  ENDLOOP.

* if not PATNR is initial then search if it's a real patient
  IF NOT l_patnr IS INITIAL.

* Begin 19129 Söldner Christian 16.02.2006
*    SELECT SINGLE * FROM npat INTO ls_npat
*                    WHERE patnr = l_patnr.
*    IF sy-subrc EQ 0 AND NOT ls_npat-patnr IS INITIAL.
    DATA: l_rc           TYPE ish_method_rc.
    CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
      EXPORTING
        i_patnr         = l_patnr
        i_read_db       = on
        i_no_buffer     = on
      IMPORTING
        es_npat         = ls_npat
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc EQ 0.
* End 19129 Söldner Christian 16.02.2006
      CALL METHOD gr_patient_sub->set_data
        EXPORTING
          i_patnr        = ls_npat-patnr
          i_patnr_x      = 'X'
        IMPORTING
          e_rc           = e_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
      e_patnr = l_patnr.
    ELSE.
*
      IF gr_pat_provi IS INITIAL.
        CALL METHOD cl_ish_patient_provisional=>create
          EXPORTING
            is_data             = ls_pat_provi
            i_environment       = gr_environment
          IMPORTING
            e_instance          = gr_pat_provi
          EXCEPTIONS
            missing_environment = 1
            no_authority        = 2
            OTHERS              = 3.

        e_rc = sy-subrc.
        IF e_rc <> 0.
          CALL METHOD cr_errorhandler->collect_messages
            EXPORTING
              i_typ = sy-msgty
              i_kla = sy-msgid
              i_num = sy-msgno
              i_mv1 = sy-msgv1
              i_mv2 = sy-msgv2
              i_mv3 = sy-msgv3
              i_mv4 = sy-msgv4.
          EXIT.
        ENDIF.

      ELSE.

*   change the instance of the patient provisional
        CALL METHOD gr_pat_provi->change
          EXPORTING
            is_data           = ls_pat_provi
            is_what_to_change = ls_change
          IMPORTING
            e_rc              = e_rc
          CHANGING
            c_errorhandler    = cr_errorhandler.
        CHECK e_rc = 0.
      ENDIF.
    ENDIF.
  ELSE.
    IF gr_pat_provi IS INITIAL.
      CALL METHOD cl_ish_patient_provisional=>create
        EXPORTING
          is_data             = ls_pat_provi
          i_environment       = gr_environment
        IMPORTING
          e_instance          = gr_pat_provi
        EXCEPTIONS
          missing_environment = 1
          no_authority        = 2
          OTHERS              = 3.

      e_rc = sy-subrc.
      IF e_rc <> 0.
        CALL METHOD cr_errorhandler->collect_messages
          EXPORTING
            i_typ = sy-msgty
            i_kla = sy-msgid
            i_num = sy-msgno
            i_mv1 = sy-msgv1
            i_mv2 = sy-msgv2
            i_mv3 = sy-msgv3
            i_mv4 = sy-msgv4.
        EXIT.
      ENDIF.

    ELSE.

*   change the instance of the patient provisional
      CALL METHOD gr_pat_provi->change
        EXPORTING
          is_data           = ls_pat_provi
          is_what_to_change = ls_change
        IMPORTING
          e_rc              = e_rc
        CHANGING
          c_errorhandler    = cr_errorhandler.
      CHECK e_rc = 0.
      CLEAR e_patnr.
    ENDIF.
  ENDIF.

  er_pat_provi = gr_pat_provi.
ENDMETHOD.


METHOD constructor .

* Construct super class(es).
  CALL METHOD super->constructor.

* Set gr_default_tabname.
  GET REFERENCE OF co_default_tabname INTO gr_default_tabname.

ENDMETHOD.


METHOD create .

* create instance for errorhandling if necessary
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* create instance
  CREATE OBJECT er_instance
    EXCEPTIONS
      instance_not_possible = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
    e_rc = 1.
*   the instance could not be created
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '003'
        i_mv1           = 'CL_ISH_SCR_PATIENT_SUBSCREEN'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD dequeue .

  IF NOT gr_patient_sub IS INITIAL.
    CALL METHOD gr_patient_sub->dequeue
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD fill_t_scrm_field .

  DATA: ls_scrm_field  TYPE rn1_scrm_field.

  REFRESH gt_scrm_field.

* nname
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'NPAT-NNAME'.
  ls_scrm_field-fieldlabel = 'Nachname'(002).
  APPEND ls_scrm_field TO gt_scrm_field.

* vname
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'NPAT-VNAME'.
  ls_scrm_field-fieldlabel = 'Vorname'(003).
  APPEND ls_scrm_field TO gt_scrm_field.

* gbnam
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'NPAT-GBNAM'.
  ls_scrm_field-fieldlabel = 'Geburtsname'(004).
  APPEND ls_scrm_field TO gt_scrm_field.

* gbdat
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'NPAT-GBDAT'.
  ls_scrm_field-fieldlabel = 'Geburtsdatum'(005).
  APPEND ls_scrm_field TO gt_scrm_field.

* BEGIN MED-61234 Madalina P. 01.02.2016
* unknown_gbdat
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'NPAT-UNKNOWN_GBDAT'.
  ls_scrm_field-fieldlabel = 'Unbekanntes Geburtsdatum'(017).
  APPEND ls_scrm_field TO gt_scrm_field.
* END MED-61234 Madalina P. 01.02.2016

* gschl
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'NPAT-GSCHL'.
  ls_scrm_field-fieldlabel = 'Geschlecht'(006).
  APPEND ls_scrm_field TO gt_scrm_field.

* titel
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'NPAT-TITEL'.
  ls_scrm_field-fieldlabel = 'Titel'(008).
  APPEND ls_scrm_field TO gt_scrm_field.

* namzu
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'NPAT-NAMZU'.
  ls_scrm_field-fieldlabel = 'Namenszusatz'(009).
  APPEND ls_scrm_field TO gt_scrm_field.

* vorsw
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'NPAT-VORSW'.
  ls_scrm_field-fieldlabel = 'Namensvors.'(010).
  APPEND ls_scrm_field TO gt_scrm_field.

* patnr
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'NPAT-PATNR'.
  ls_scrm_field-fieldlabel = 'Patient'(001).
  APPEND ls_scrm_field TO gt_scrm_field.

* extnr
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'RNPB2-EXTNR'.
  ls_scrm_field-fieldlabel = 'Ext. Patient'(011).
  APPEND ls_scrm_field TO gt_scrm_field.

ENDMETHOD.


METHOD get_dynpro_pat .

  e_pgm_pat = g_pgm_pat.
  e_dynnr_pat = g_dynnr_pat.

ENDMETHOD.


METHOD get_scr_patient_sub .

  rr_scr_patient_sub = gr_patient_sub.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_scr_patient.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~IS_A .

  DATA: l_object_type                 TYPE i.

* ---------- ---------- ----------
  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF l_object_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  IF i_object_type = co_otype_scr_patient.
    r_is_inherited_from = on.
  ELSE.
*-- ID-16230
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
*--  r_is_inherited_from = off. ID-16230
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~clear_cursorfield .

  DATA: l_cursorfield      TYPE ish_fieldname,
        ls_message         TYPE rn1message.

  CLEAR: ls_message.
  IF NOT gr_patient_sub IS INITIAL.
    CALL METHOD gr_patient_sub->set_cursor
      CHANGING
        c_rn1message = ls_message.
  ENDIF.
  CLEAR: g_scr_cursorfield.

ENDMETHOD.


METHOD if_ish_screen~destroy .

* Call super method.
  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

* Clear selfs references.
  CLEAR: gr_patient_sub,
         gr_pat_provi.

ENDMETHOD.


METHOD if_ish_screen~get_def_crs_possible .

  DATA: l_repid            TYPE sy-repid,
        l_dynnr            TYPE sy-dynnr.

  l_repid = gs_parent-repid.
  l_dynnr = gs_parent-dynnr.

  gs_parent-repid = g_pgm_pat.
  gs_parent-dynnr = g_dynnr_pat.

  CALL METHOD super->if_ish_screen~get_def_crs_possible
    IMPORTING
      e_crs_field_prio1 = e_crs_field_prio1
      er_crs_scr_prio1  = er_crs_scr_prio1
      e_crs_field_prio2 = e_crs_field_prio2
      er_crs_scr_prio2  = er_crs_scr_prio2
      e_crs_field_prio3 = e_crs_field_prio3
      er_crs_scr_prio3  = er_crs_scr_prio3
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.

* as priority 2 and 3 cursorfield return ever last name
* of patient
  IF g_vcode <> co_vcode_display.
    e_crs_field_prio2 = 'NPAT-NNAME'.
    er_crs_scr_prio2  = me.
  ENDIF.
  e_crs_field_prio3 = 'NPAT-NNAME'.
  er_crs_scr_prio3  = me.

  gs_parent-repid = l_repid.
  gs_parent-dynnr = l_dynnr.

ENDMETHOD.


METHOD if_ish_screen~get_fields_definition .

  DATA: l_repid            TYPE sy-repid,
        l_dynnr            TYPE sy-dynnr.

  l_repid = gs_parent-repid.
  l_dynnr = gs_parent-dynnr.

  gs_parent-repid = g_pgm_pat.
  gs_parent-dynnr = g_dynnr_pat.

  CALL METHOD super->if_ish_screen~get_fields_definition
    IMPORTING
      et_fields_definition = et_fields_definition
      e_rc                 = e_rc
    CHANGING
      c_errorhandler       = c_errorhandler.

  gs_parent-repid = l_repid.
  gs_parent-dynnr = l_dynnr.

ENDMETHOD.


METHOD if_ish_screen~get_fields_value .

  DATA:          lt_fielddef          TYPE dyfatc_tab,
                 lt_field_values      TYPE ish_t_field_value,
                 lt_fields_value      TYPE ish_t_screen_fields,
                 ls_fields_value      LIKE LINE OF lt_fields_value,
                 lr_pap               TYPE REF TO
* ED, int. M. 0120061532 0001261428 2005: false instance
*                                      cl_ishmed_patient_provisional,
                                      cl_ish_patient_provisional,
                 l_patnr              TYPE npat-patnr,
                 l_npat               TYPE npat,
                 l_npap               TYPE npap,
                 l_long_name          TYPE xfeld,          "note 2068025
* ED, int. M. 0120061532 0001261428 2005: new local parameters -> BEGIN
                 ls_data TYPE rnpap_attrib,
                 l_rc    TYPE ish_method_rc,
                 l_gschl TYPE npat-gschl,
                 ls_key  TYPE rnpap_key.
* ED, int. M. 0120061532 0001261428 2005 -> END

  FIELD-SYMBOLS: <ls_fielddef>        TYPE rpy_dyfatc,
                 <ls_field_values>    TYPE rnfield_value,
                 <ls_fields_value>    TYPE rn1_screen_fields.

* Init
  e_rc = 0.

* Check/create errorhandler
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  CALL FUNCTION 'ISH_TN00_READ_LONG_NPAT_NADR'              "note 2068025
     EXPORTING
       SS_MANDT                       = sy-mandt
     IMPORTING
       SS_LONG_NPAT_NADR_ACTIVE       = l_long_name
     EXCEPTIONS
       OTHERS                         = 0.
* Get field values
  CALL METHOD me->get_fields
*  EXPORTING
*    I_CONV_TO_EXTERN = SPACE
    IMPORTING
      et_field_values  = lt_field_values
      e_rc             = e_rc
   CHANGING
    c_errorhandler     = cr_errorhandler.

* Loop field values
  LOOP AT lt_field_values ASSIGNING <ls_field_values>.
    CLEAR ls_fields_value.
    CASE <ls_field_values>-fieldname.
*     Patient
      WHEN co_fieldname_patnr.
*       Read from db
        l_patnr = <ls_field_values>-value.
* ED, int. M. 0120061532 0001261428 2005: check if real patient
        CHECK NOT l_patnr IS INITIAL.
        CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
          EXPORTING
            i_patnr   = l_patnr
            i_read_db = on
            i_no_buffer = on       "MED-69970 AGujev
         "MED-69970: we don't save data from database in NPOL buffer because we may overwrite entries made by the user!
          IMPORTING
            es_npat   = l_npat.
*       Prepare/append field data
*       PATNR
        ls_fields_value-label_name = 'NPAT-PATNR'.
        ls_fields_value-label_text = 'Patient'(001).
        ls_fields_value-value_name = 'NPAT-PATNR'.
        ls_fields_value-value_text = <ls_field_values>-value.
        APPEND ls_fields_value TO lt_fields_value.
        IF l_long_name = on.                               "begin note 2068025
*         NNAME_LONG
          ls_fields_value-label_name = 'NPAT-NNAME_LONG'.
          ls_fields_value-label_text = 'Nachname'(002).
          ls_fields_value-value_name = 'NPAT-NNAME_LONG'.
          ls_fields_value-value_text = l_npat-nname_long.
          APPEND ls_fields_value TO lt_fields_value.
*         VNAME_LONG
          ls_fields_value-label_name = 'NPAT-VNAME_LONG'.
          ls_fields_value-label_text = 'Vorname'(003).
          ls_fields_value-value_name = 'NPAT-VNAME_LONG'.
          ls_fields_value-value_text = l_npat-vname_long.
          APPEND ls_fields_value TO lt_fields_value.
*         GBNAM_LONG
          ls_fields_value-label_name = 'NPAT-GBNAM_LONG'.
          ls_fields_value-label_text = 'Geburtsname'(004).
          ls_fields_value-value_name = 'NPAT-GBNAM_LONG'.
          ls_fields_value-value_text = l_npat-gbnam_long.
          APPEND ls_fields_value TO lt_fields_value.
* MED-57660 Begin
*        ELSE.
         ENDIF.
* MED-57660 End
*         NNAME
          ls_fields_value-label_name = 'NPAT-NNAME'.
          ls_fields_value-label_text = 'Nachname'(002).
          ls_fields_value-value_name = 'NPAT-NNAME'.
          ls_fields_value-value_text = l_npat-nname.
          APPEND ls_fields_value TO lt_fields_value.
*         VNAME
          ls_fields_value-label_name = 'NPAT-VNAME'.
          ls_fields_value-label_text = 'Vorname'(003).
          ls_fields_value-value_name = 'NPAT-VNAME'.
          ls_fields_value-value_text = l_npat-vname.
          APPEND ls_fields_value TO lt_fields_value.
*         GBNAM
          ls_fields_value-label_name = 'NPAT-GBNAM'.
          ls_fields_value-label_text = 'Geburtsname'(004).
          ls_fields_value-value_name = 'NPAT-GBNAM'.
          ls_fields_value-value_text = l_npat-gbnam.
          APPEND ls_fields_value TO lt_fields_value.
* MED-57660 Begin
*        ENDIF.                                             "end note 2068025
* MED-57660 End
*       GBDAT
        ls_fields_value-label_name = 'NPAT-GBDAT'.
        ls_fields_value-label_text = 'Geburtsdatum'(005).
        ls_fields_value-value_name = 'NPAT-GBDAT'.
        ls_fields_value-value_text = l_npat-gbdat.
*    IF NPAT-GBDAT <> 0.
*      ALTER = SY-DATUM(4) - NPAT-GBDAT(4).
**    falls der Geburtstag noch nicht in diesem Jahr war 1 abziehen...
*      IF SY-DATUM+4(4) < NPAT-GBDAT+4(4).
*        SUBTRACT 1 FROM ALTER.
*      ENDIF.
        APPEND ls_fields_value TO lt_fields_value.
*       GSCHL
        ls_fields_value-label_name = 'NPAT-GSCHL'.
        ls_fields_value-label_text = 'Geschlecht'(006).
        ls_fields_value-value_name = 'NPAT-GSCHL'.
        ls_fields_value-value_text = l_npat-gschl.
        APPEND ls_fields_value TO lt_fields_value.
*       TELF1
        ls_fields_value-label_name = 'NPAT-TELF1'.
        ls_fields_value-label_text = 'Telefon'(007).
        ls_fields_value-value_name = 'NPAT-TELF1'.
        ls_fields_value-value_text = l_npat-telf1.
        APPEND ls_fields_value TO lt_fields_value.
*       TITEL
        ls_fields_value-label_name = 'NPAT-TITEL'.
        ls_fields_value-label_text = 'Titel'(008).
        ls_fields_value-value_name = 'NPAT-TITEL'.
        ls_fields_value-value_text = l_npat-titel.
        APPEND ls_fields_value TO lt_fields_value.
*       NAMZU
        ls_fields_value-label_name = 'NPAT-NAMZU'.
        ls_fields_value-label_text = 'Namenszusatz'(009).
        ls_fields_value-value_name = 'NPAT-NAMZU'.
        ls_fields_value-value_text = l_npat-namzu.
        APPEND ls_fields_value TO lt_fields_value.
*       VORSW
        ls_fields_value-label_name = 'NPAT-VORSW'.
        ls_fields_value-label_text = 'Namensvors.'(010).
        ls_fields_value-value_name = 'NPAT-VORSW'.
        ls_fields_value-value_text = l_npat-vorsw.
        APPEND ls_fields_value TO lt_fields_value.
*       EXTNR
        ls_fields_value-label_name = 'NPAT-EXTNR'.
        ls_fields_value-label_text = 'Ext. Patient'(011).
        ls_fields_value-value_name = 'NPAT-EXTNR'.
        ls_fields_value-value_text = l_npat-extnr.
        APPEND ls_fields_value TO lt_fields_value.
*       EMAIL
*        ls_fields_value-label_name = 'NPAT-NNAME'.
*        ls_fields_value-label_text = 'Nachname'.
*        ls_fields_value-value_name = 'NPAT-NNAME'.
*        ls_fields_value-value_text = l_npat-nname.
*        APPEND ls_fields_value TO lt_fields_value.
*     Provisional patient
      WHEN co_fieldname_pap.

* ED, int. M. 0120061532 0001261428 2005 -> BEGIN
*        ls_fields_value-label_name = 'PAPID'.
*        ls_fields_value-label_text = 'Vorl.Patient'(012).
*        ls_fields_value-value_name = 'PAPID'.
*        ls_fields_value-value_text = '123456'.
        IF NOT <ls_field_values>-object IS INITIAL.
          lr_pap ?= <ls_field_values>-object.
          CALL METHOD lr_pap->get_data
            IMPORTING
              es_key         = ls_key
              es_data        = ls_data
              e_rc           = e_rc
            CHANGING
              c_errorhandler = cr_errorhandler.
          IF l_rc <> 0.
            e_rc = l_rc.
            EXIT.
          ENDIF.
*         PAPID
          IF NOT ls_key-papid IS INITIAL.
            ls_fields_value-label_name = 'PAPID'.
            ls_fields_value-label_text = 'Vorl.Patient'(012).
            ls_fields_value-value_name = 'PAPID'.
            ls_fields_value-value_text = ls_key-papid.
            APPEND ls_fields_value TO lt_fields_value.
          ENDIF.
          IF l_long_name = on.                             "begin note 2068025
*           NNAME_LONG
            ls_fields_value-label_name = 'NPAT-NNAME_LONG'.
            ls_fields_value-label_text = 'Nachname'(002).
            ls_fields_value-value_name = 'NPAT-NNAME_LONG'.
            ls_fields_value-value_text = ls_data-nname_long.
            APPEND ls_fields_value TO lt_fields_value.
*           VNAME_LONG
            ls_fields_value-label_name = 'NPAT-VNAME_LONG'.
            ls_fields_value-label_text = 'Vorname'(003).
            ls_fields_value-value_name = 'NPAT-VNAME_LONG'.
            ls_fields_value-value_text = ls_data-vname_long.
            APPEND ls_fields_value TO lt_fields_value.
*           GBNAM_LONG
            ls_fields_value-label_name = 'NPAT-GBNAM_LONG'.
            ls_fields_value-label_text = 'Geburtsname'(004).
            ls_fields_value-value_name = 'NPAT-GBNAM_LONG'.
            ls_fields_value-value_text = ls_data-gbnam_long.
            APPEND ls_fields_value TO lt_fields_value.
* MED-57660 Begin
*          ELSE.
          ENDIF.
* MED-57660 End
*           NNAME
            ls_fields_value-label_name = 'NPAT-NNAME'.
            ls_fields_value-label_text = 'Nachname'(002).
            ls_fields_value-value_name = 'NPAT-NNAME'.
            ls_fields_value-value_text = ls_data-nname.
            APPEND ls_fields_value TO lt_fields_value.
*           VNAME
            ls_fields_value-label_name = 'NPAT-VNAME'.
            ls_fields_value-label_text = 'Vorname'(003).
            ls_fields_value-value_name = 'NPAT-VNAME'.
            ls_fields_value-value_text = ls_data-vname.
            APPEND ls_fields_value TO lt_fields_value.
*           GBNAM
            ls_fields_value-label_name = 'NPAT-GBNAM'.
            ls_fields_value-label_text = 'Geburtsname'(004).
            ls_fields_value-value_name = 'NPAT-GBNAM'.
            ls_fields_value-value_text = ls_data-gbnam.
            APPEND ls_fields_value TO lt_fields_value.
* MED-57660 Begin
*          ENDIF.                                           "end note 2068025
* MED-57660 End
*         GBDAT
          ls_fields_value-label_name = 'NPAT-GBDAT'.
          ls_fields_value-label_text = 'Geburtsdatum'(005).
          ls_fields_value-value_name = 'NPAT-GBDAT'.
          ls_fields_value-value_text = ls_data-gbdat.
          APPEND ls_fields_value TO lt_fields_value.
*         GSCHL
          IF NOT ls_data-gschle IS INITIAL.
            CALL FUNCTION 'ISH_CONVERT_SEX_INPUT'
              EXPORTING
                ss_gschle = ls_data-gschle
              IMPORTING
                ss_gschl  = l_gschl
              EXCEPTIONS
                not_found = 1
                OTHERS    = 2.
            IF sy-subrc <> 0.
              CLEAR l_gschl.
            ENDIF.
          ENDIF.
          ls_fields_value-label_name = 'NPAT-GSCHL'.
          ls_fields_value-label_text = 'Geschlecht'(006).
          ls_fields_value-value_name = 'NPAT-GSCHL'.
          ls_fields_value-value_text = l_gschl.
          APPEND ls_fields_value TO lt_fields_value.
*         TITEL
          ls_fields_value-label_name = 'NPAT-TITEL'.
          ls_fields_value-label_text = 'Titel'(008).
          ls_fields_value-value_name = 'NPAT-TITEL'.
          ls_fields_value-value_text = ls_data-titel.
          APPEND ls_fields_value TO lt_fields_value.
*         NAMZU
          ls_fields_value-label_name = 'NPAT-NAMZU'.
          ls_fields_value-label_text = 'Namenszusatz'(009).
          ls_fields_value-value_name = 'NPAT-NAMZU'.
          ls_fields_value-value_text = ls_data-namzu.
          APPEND ls_fields_value TO lt_fields_value.
*         VORSW
          ls_fields_value-label_name = 'NPAT-VORSW'.
          ls_fields_value-label_text = 'Namensvors.'(010).
          ls_fields_value-value_name = 'NPAT-VORSW'.
          ls_fields_value-value_text = ls_data-vorsw.
          APPEND ls_fields_value TO lt_fields_value.
*         EXTNR
          ls_fields_value-label_name = 'NPAT-EXTNR'.
          ls_fields_value-label_text = 'Ext. Patient'(011).
          ls_fields_value-value_name = 'NPAT-EXTNR'.
          ls_fields_value-value_text = ls_data-extnr.
          APPEND ls_fields_value TO lt_fields_value.
*         ANRDE
          ls_fields_value-label_name = 'NPAT-ANRED'.
          ls_fields_value-label_text = 'Anrede'(014).
          ls_fields_value-value_name = 'NPAT-ANRED'.
          ls_fields_value-value_text = ls_data-anrde.
          APPEND ls_fields_value TO lt_fields_value.
*         RVNUM
          ls_fields_value-label_name = 'NPAT-RVNUM'.
          ls_fields_value-label_text = 'Sozialvers.num.'(015).
          ls_fields_value-value_name = 'NPAT-RVNUM'.
          ls_fields_value-value_text = ls_data-rvnum.
          APPEND ls_fields_value TO lt_fields_value.
        ENDIF.
* ED, int. M. 0120061532 0001261428 2005 -> END

      WHEN OTHERS.
    ENDCASE.
  ENDLOOP.

* Return table with field values
  et_fields_value = lt_fields_value.

ENDMETHOD.


METHOD if_ish_screen~is_field_initial.

* ED, int. M. 0120061532 0001261428 2005 -> BEGIN
  DATA: lt_fields_value TYPE ish_t_screen_fields,
        ls_fields_value LIKE LINE OF lt_fields_value,
        l_rc            TYPE ish_method_rc.

* first check normal fields
  CALL METHOD super->if_ish_screen~is_field_initial
    EXPORTING
      i_fieldname = i_fieldname
      i_rownumber = i_rownumber
    RECEIVING
      r_initial   = r_initial.

  CHECK r_initial = on.
* now check subscreen fields
  CALL METHOD me->get_fields_value
*    EXPORTING
*      I_CONV_TO_EXTERN = SPACE
    IMPORTING
      et_fields_value  = lt_fields_value
      e_rc             = l_rc.
  CHECK l_rc = 0.
  READ TABLE lt_fields_value INTO ls_fields_value
        WITH KEY value_name = i_fieldname.
  CHECK sy-subrc EQ 0.
* Check if value is initial.
  CHECK NOT ls_fields_value-value_text IS INITIAL.
* RW 08.06.2005: Additional check for date GBDAT.
  IF i_fieldname = 'NPAT-GBDAT'.
    CHECK NOT ls_fields_value-value_text = '00000000'.
  ENDIF.
* if value is not initial -> set return parameter!!
  r_initial = off.

ENDMETHOD.


METHOD if_ish_screen~set_cursor .

  DATA: l_cursorfield      TYPE ish_fieldname,
        ls_message         TYPE rn1message.

* Initializations.
  e_cursor_set = off.
  e_rc         = 0.

* Remind message.
  CALL METHOD remind_message
    EXPORTING
      is_message    = i_rn1message
      i_cursorfield = i_cursorfield
    IMPORTING
      e_cursor_set  = e_cursor_set.

* if there is no cursorfield set try to get it
* from embedded patient subscreen
  IF g_scr_cursorfield IS INITIAL.
    l_cursorfield = gr_patient_sub->get_cursorfield( ).
  ELSE.
    l_cursorfield = g_scr_cursorfield.
  ENDIF.

* If message is handled by self or self has
* a cursorfield -> e_cursor_set=on.
  IF e_cursor_set = off.
    IF is_message_handled( gs_message ) = on OR
       NOT l_cursorfield IS INITIAL.
      e_cursor_set = on.
    ENDIF.
  ENDIF.

* Position the cursor.
  CHECK NOT gr_patient_sub IS INITIAL.
  IF i_set_cursor = on.
    IF e_cursor_set = on.
*     determine cursorfield.
      IF is_message_handled( gs_message ) = on.
        ls_message = gs_message.
      ELSE.
        SPLIT l_cursorfield AT '-'
           INTO ls_message-parameter ls_message-field.
      ENDIF.
      CALL METHOD gr_patient_sub->set_cursor
        CHANGING
          c_rn1message = ls_message.
    ENDIF.
    CLEAR: gs_message,
           g_scr_cursorfield.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~set_fieldval_from_data .

* workareas
  FIELD-SYMBOLS:
        <ls_val>        LIKE LINE OF ct_field_values.
* definitions
  DATA: l_rc            TYPE ish_method_rc,
        l_patnr         TYPE npat-patnr.
* object references
  DATA: lr_pap          TYPE REF TO cl_ish_patient_provisional.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* main object is mandatory
  CHECK NOT gr_main_object IS INITIAL.
* ---------- ---------- ----------
  CALL METHOD cl_ish_utl_base_patient=>get_patient_of_obj
    EXPORTING
      ir_object       = gr_main_object
    IMPORTING
      e_patnr         = l_patnr
      er_pap          = lr_pap
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* change field values
* ----------
* set PATNR
  READ TABLE ct_field_values ASSIGNING <ls_val>
     WITH KEY fieldname = co_fieldname_patnr.
  IF sy-subrc = 0.
    <ls_val>-value = l_patnr.
  ENDIF.
* ----------
* set instance of patient provisional
  READ TABLE ct_field_values ASSIGNING <ls_val>
     WITH KEY fieldname = co_fieldname_pap.
  IF sy-subrc = 0.
    <ls_val>-object = lr_pap.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .

  CALL FUNCTION 'ISH_SDY_PATIENT_SUBSCREEN_INIT'
    EXPORTING
      ir_scr_patient_subscreen = me
    IMPORTING
      es_parent                = gs_parent
      e_rc                     = e_rc
    CHANGING
      cr_dynp_data             = gr_scr_data
      cr_errorhandler          = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~transport_from_dy .

  DATA: l_rc            TYPE ish_method_rc,
        ls_npat         TYPE npat,
        lr_pap          TYPE REF TO cl_ish_patient_provisional,
        lt_field_val    TYPE ish_t_field_value,
        ls_field_val    TYPE rnfield_value.

  DATA: l_patnr TYPE npat-patnr. "Grill, ID.17621
  DATA: l_okcode TYPE sy-ucomm. "ED, MED-31246

* Transport super class(es).
  CALL METHOD super->if_ish_screen~transport_from_dy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get subscreen data
  CLEAR: ls_npat,
         lr_pap.
  CALL METHOD gr_patient_sub->get_data
    IMPORTING
      e_npat         = ls_npat
      e_pap          = gr_pat_provi "lr_pap "ED, ID 14749
      e_rc           = e_rc
      e_patnr        = l_patnr "Grill, ID-17621
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* ED, MED-31246: get ok-code from patient subscreen -> BEGIN
  CALL METHOD gr_patient_sub->get_okcode
    IMPORTING
      e_okcode = l_okcode
      e_subrc  = e_rc.
  CHECK e_rc = 0.
* ED, MED-31246 -> END

*-- begin Grill, ID-17621
  IF ls_npat IS INITIAL AND
   NOT l_patnr IS INITIAL.
    ls_npat-patnr = l_patnr.
  ENDIF.
*-- end Grill, ID-17621

* Set screen values
  CLEAR: ls_field_val.
  ls_field_val-fieldname = 'PATNR'.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_npat-patnr.
  INSERT ls_field_val INTO TABLE lt_field_val.
  CLEAR ls_field_val.
  ls_field_val-fieldname = 'PAP'.
  ls_field_val-type      = co_fvtype_identify.
  ls_field_val-object    = gr_pat_provi. "lr_pap. "ED, ID 14749
  INSERT ls_field_val INTO TABLE lt_field_val.

* ----------
* set values
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      it_field_values = lt_field_val
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
* ---------- ---------- ----------

* ED, MED-31246 -> BEGIN
* if field(s) are required set event user_command
* at the end of the method to set the values in screen before!!
  IF l_okcode = 'TEST' AND
     sy-msgid = '00' AND
     sy-msgno = '55'.
*    CALL METHOD cl_ish_utl_base=>collect_messages
*      EXPORTING
*        i_typ           = 'E'
*        i_kla           = '00'
*        i_num           = '055'
**       i_mv1           =
**       i_mv2           =
**       i_mv3           =
**       i_mv4           =
**       i_par           =
**       i_row           =
**       i_field         =
**       ir_object       =
**       i_line_key      =
**       ir_error_obj    =
**       it_messages     =
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
    RAISE EVENT ev_user_command
      EXPORTING
        ir_screen = me
*    ir_object =
*    is_col_id =
*    is_row_no =
        i_ucomm   = 'ADR_ERROR'.
  ENDIF.
* ED, MED-31246 -> END

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy .

  DATA: l_einri         TYPE einri,
        l_rc            TYPE ish_method_rc,
        l_patnr         TYPE patnr,
        l_papid         TYPE ish_papid,
        l_srch_flag     TYPE ish_on_off,
        l_del_flag      TYPE ish_on_off,
        l_key           TYPE rnpap_key,
        l_found         TYPE ish_on_off,
        lt_field_val    TYPE ish_t_field_value,
        ls_key          TYPE rnpap_key,
        lt_messages     TYPE ishmed_t_messages, "ED, ID 20448
        ls_message      TYPE rn1message, "ED, ID 20448
        lt_message_auth TYPE ishmed_t_messages. "ED, ID 20448

  FIELD-SYMBOLS: <ls_field_val>    TYPE rnfield_value.

* object references
  DATA: lr_object_main  TYPE REF TO if_ish_identify_object,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.

* Call standard implementation.
  CALL METHOD super->if_ish_screen~transport_to_dy.

* ----------
* get values
  CALL METHOD gr_screen_values->get_data
    IMPORTING
      et_field_values = lt_field_val
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
* ---------- ---------- ----------
  LOOP AT lt_field_val ASSIGNING <ls_field_val>.
    CASE <ls_field_val>-fieldname.
      WHEN 'PATNR'.
        l_patnr = <ls_field_val>-value.
      WHEN 'PAP'.
        gr_pat_provi ?= <ls_field_val>-object.
    ENDCASE.
  ENDLOOP.
* ---------- ---------- ----------
* If there is no pap but there is a smartcard pap -> use smartcard pap.
  IF gr_pat_provi IS INITIAL.
    gr_pat_provi = gr_patient_sub->gr_pap_smartcard.
    CLEAR gr_patient_sub->gr_pap_smartcard.
  ENDIF.
* ---------- ---------- ----------
* maybe a patient was identified via the new electronic
* healthcare card
  IF l_patnr IS INITIAL AND gr_pat_provi IS INITIAL.
    CALL METHOD gr_patient_sub->get_data
      IMPORTING
        e_patnr = l_patnr.
  ENDIF.
* ---------- ---------- ----------
* Get papid from gr_pat_provi.
  IF NOT gr_pat_provi IS INITIAL.
    CALL METHOD gr_pat_provi->get_data
      IMPORTING
        es_key         = ls_key
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    l_papid = ls_key-papid.
  ENDIF.

  IF g_first_time = on.
    l_srch_flag = on.
    l_del_flag  = on.
* Button für Patientensuche und "Löschen" ausblenden, wenn
* schon vom Aufrufer ein Patient mitgegeben wird
    IF NOT l_patnr IS INITIAL OR NOT l_papid IS INITIAL.
      l_srch_flag = off.
      l_del_flag  = off.
    ENDIF.
  ELSE.
    CALL METHOD gr_patient_sub->get_data
      IMPORTING
        e_delete       = l_del_flag
        e_search       = l_srch_flag
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    CHECK l_rc = 0.
* ED, MED-30595 point 7: in changing mode do not show delete
* button for patient provisional -> BEGIN
    IF l_del_flag = on AND g_vcode = co_vcode_update AND
       NOT l_papid IS INITIAL.
      l_del_flag = off.
    ENDIF.
* ED, MED-30595 -> END
  ENDIF.

* Set screen data
  CALL METHOD gr_patient_sub->set_data
    EXPORTING
      i_patnr        = l_patnr
      i_patnr_x      = on
      i_vcode        = g_vcode
      i_vcode_x      = on
      i_pap          = gr_pat_provi
      i_pap_x        = on
      i_search       = l_srch_flag
      i_search_x     = on
      i_delete       = l_del_flag
      i_delete_x     = on
    IMPORTING
      e_rc           = l_rc
    CHANGING
      c_errorhandler = lr_errorhandler.

* ED, ID 20448: check if message from authority check
* is in local errorhandler -> if add it to the changing
* errorhandler -> BEGIN
  IF lr_errorhandler IS BOUND.
    CALL METHOD lr_errorhandler->get_messages
      IMPORTING
        t_extended_msg = lt_messages.
    READ TABLE lt_messages INTO ls_message
    WITH KEY id = 'N1'
             number = '611'.
    IF sy-subrc EQ 0 AND NOT ls_message-message_v1 IS INITIAL.

      IF NOT cr_errorhandler IS BOUND.
        CREATE OBJECT cr_errorhandler.
      ENDIF.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = ls_message-type
          i_kla           = ls_message-id
          i_num           = ls_message-number
          i_mv1           = ls_message-message_v1
          i_mv2           = ls_message-message_v2
          i_mv3           = ls_message-message_v3
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
  ENDIF.
* ED, ID 20448 -> END

  IF l_rc <> 0.
    EXIT.
  ENDIF.

* ED, ID:14749 - Begin
  CALL METHOD gr_patient_sub->get_data
    IMPORTING
      e_rc           = l_rc
      e_pap          = gr_pat_provi
    CHANGING
      c_errorhandler = cr_errorhandler.

* ED, ID:14749 - End

* Den Funktionsbaustein im Subscreen schon hier die Referenz
* auf die Subscreenklasse übergeben
  CALL FUNCTION 'ISHMED_SET_PATIENT_PROVISIONAL'
    EXPORTING
      i_pat_search_provisional = gr_patient_sub
      i_clear_smartcard        = off  "it is done in the process of KLAU
    IMPORTING
      e_screen_pat             = g_dynnr_pat
    CHANGING
      cr_errorhandler          = cr_errorhandler. "Grill, ID-17621
ENDMETHOD.


METHOD initialize_field_values .
* local tables
  DATA: lt_field_val            TYPE ish_t_field_value.
* workareas
  DATA: ls_field_val            TYPE rnfield_value.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
  CLEAR: lt_field_val.
* ----------
* initialize every screen field
  CLEAR: ls_field_val.
  ls_field_val-fieldname = co_fieldname_patnr.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = co_fieldname_pap.
  ls_field_val-type      = co_fvtype_identify.
  INSERT ls_field_val INTO TABLE lt_field_val.

* ----------
* set values
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      it_field_values = lt_field_val
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
* ---------- ---------- ----------
ENDMETHOD.


METHOD initialize_internal .

  DATA: l_version TYPE tn00-cvers,
        l_einri   TYPE tn01-einri,
        lr_object_main  TYPE REF TO if_ish_identify_object,
        l_ms1     TYPE sy-msgv1.

* set subscreen
  g_pgm_pat = 'SAPLN1VPS'.

* in version ES (SPAIN), show another dynpro
  CALL FUNCTION 'ISH_COUNTRY_VERSION_GET'
    IMPORTING
      ss_cvers = l_version.
  IF l_version = if_ish_constant_definition~cv_spain.
    g_dynnr_pat = '0101'.
  ELSE.
    g_dynnr_pat = '0100'.
  ENDIF.

* initialize the subscreen class
  IF gr_patient_sub IS INITIAL.
    lr_object_main ?= gr_main_object.
    l_einri = cl_ish_utl_base=>get_institution_of_obj( lr_object_main ).
    IF l_einri IS INITIAL.
      EXIT.
    ENDIF.
    CREATE OBJECT gr_patient_sub
      EXPORTING
        i_einri               = l_einri
        i_vcode               = g_vcode
        i_environment         = gr_environment
        i_lock                = gr_lock
        ir_screen             = me                 "RW ID 14654
      EXCEPTIONS
        instance_not_possible = 1
        wrong_input           = 2
        OTHERS                = 3.
    e_rc = sy-subrc.
    IF e_rc <> 0.
      l_ms1 = 'Fehler beim Instanzieren folgender Klasse: '(013).
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'NF'
          i_num           = '000'
          i_mv1           = l_ms1
          i_mv2           = 'CL_ISH_PATIENT_PROVISIONAL'
          ir_object       = me
        CHANGING
          cr_errorhandler = cr_errorhandler.

    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD initialize_parent .

  CLEAR: gs_parent.

  gs_parent-repid   = 'SAPLN1_SDY_PATIENT_SUBSCREEN'.
  gs_parent-dynnr   = '0100'.
  gs_parent-type    = co_scr_parent_type_dynpro.

ENDMETHOD.
ENDCLASS.
