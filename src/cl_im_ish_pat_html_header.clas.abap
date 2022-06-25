class CL_IM_ISH_PAT_HTML_HEADER definition
  public
  final
  create public .

*"* public components of class CL_IM_ISH_PAT_HTML_HEADER
*"* do not include other source files here!!!
public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_ISH_PAT_HTML_HEADER .

  types:
    BEGIN OF ty_scrm_fattr ,
                 n1scrm  TYPE n1scrm,
                 n1fattr TYPE n1fattr,
           END OF ty_scrm_fattr .
  types:
    TYT_SCRM_FATTR type standard table of ty_scrm_fattr .
protected section.
*"* protected components of class CL_IM_ISH_PAT_HTML_HEADER
*"* do not include other source files here!!!
private section.
*"* private components of class CL_IM_ISH_PAT_HTML_HEADER
*"* do not include other source files here!!!

  data GT_SCRM_FATTR type TYT_SCRM_FATTR .
  data GR_CORDER type ref to CL_ISH_CORDER .

  methods FILL_T_HEAD_COMP_SCREEN_MODIF .
  methods GET_FATTR_VALUE_FOR_FNAME
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    exporting
      !R_FATTR_ID type N1FATTR_VALUE-FATTR_VALUE_ID .
  methods GET_ISH_INACTIVE_FIELD_FLAG
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_EINRI type EINRI
    exporting
      !E_INACTIVE type NPDOK-XFELD .
ENDCLASS.



CLASS CL_IM_ISH_PAT_HTML_HEADER IMPLEMENTATION.


METHOD fill_t_head_comp_screen_modif.
* Created By AM,25.07.2012
* Created For Isis : MED-47907
* Details:
* Returns the screen modifications for the head components

  DATA lr_comp_order TYPE REF TO cl_ish_comp_order.
  DATA lr_comp_patient TYPE REF TO cl_ish_comp_patient. "Oana B
  DATA lr_comp_waiting_list TYPE REF TO cl_ish_comp_waiting_list. "Oana B
  DATA l_rc              TYPE ish_method_rc.
  DATA lt_cordpos        TYPE ish_t_cordpos.
  DATA lr_prereg         TYPE REF TO cl_ishmed_prereg.
  DATA lr_cordpos        TYPE REF TO cl_ishmed_cordpos.
  DATA lr_cordtyp        TYPE REF TO cl_ishmed_cordtyp.
  DATA l_stsma           TYPE j_stsma.
  DATA l_estat           TYPE j_estat.
  DATA lt_scrm_order     TYPE ishmed_t_scrm. "Oana B
  DATA lt_scrm_patient   TYPE ishmed_t_scrm. "Oana B
  DATA lt_scrm_waiting_list TYPE ishmed_t_scrm.
  DATA lt_scrm           TYPE ishmed_t_scrm.
  DATA lr_scrm           TYPE REF TO cl_ishmed_scrm.
  DATA ls_n1scrm         TYPE n1scrm.
  DATA lr_fattr          TYPE REF TO cl_ishmed_fattr.
  DATA ls_n1fattr        TYPE n1fattr.
  DATA l_fattr_value_id  TYPE numc4.
  DATA ls_scrm_fattr TYPE ty_scrm_fattr.
  DATA lt_scrm_fattr TYPE tyt_scrm_fattr.
  DATA l_append          TYPE ish_on_off.

  CHECK gr_corder IS NOT INITIAL.

*get order component object
  gr_corder->get_comphead_order(
   IMPORTING
      er_comp_order   = lr_comp_order    " IS-H: Bausteinklasse Auftragsdaten
     e_rc            = l_rc              " IS-H: Returncode bei Methodenaufrufen
  ).

  CHECK l_rc = 0.

*get patient component object   " Oana B
  gr_corder->get_comphead_patient(
  IMPORTING
     er_comp_patient   = lr_comp_patient    " IS-H: Bausteinklasse Patientdaten
     e_rc            = l_rc                 " IS-H: Returncode bei Methodenaufrufen
     ) .


  CHECK l_rc = 0.

*get waiting list component object

  gr_corder->get_comphead_waiting_list(
    IMPORTING
      er_comp_waiting_list = lr_comp_waiting_list    " IS-H: Bausteinklasse Warteliste
      e_rc                 =  l_rc   " IS-H: Returncode bei Methodenaufrufen
  ).

  CHECK l_rc = 0.

*get all order positions
  CALL METHOD gr_corder->get_t_cordpos
    IMPORTING
      et_cordpos = lt_cordpos
      e_rc       = l_rc.


  CHECK l_rc = 0.

* Loop cordpos objects.
  LOOP AT lt_cordpos INTO lr_prereg.
*   Casting.
    TRY.
        lr_cordpos ?= lr_prereg.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.

*   Get the cordtyp.
    lr_cordtyp = lr_cordpos->get_cordtyp_med( ).

*   Process only if there is already a cordtyp.
    CHECK NOT lr_cordtyp IS INITIAL.

*   Get the actual stsma + estat.
    CALL METHOD lr_cordpos->get_status
      IMPORTING
        e_stsma = l_stsma
        e_estat = l_estat
        e_rc    = l_rc.

    CHECK l_rc = 0.

    CHECK NOT l_stsma IS INITIAL.
    CHECK NOT l_estat IS INITIAL.

*FILL Modifications Table with Order Componenent Values

*   Get the defined scrm definitions.
    CALL METHOD lr_cordtyp->get_t_scrm
      EXPORTING
        i_compid        = lr_comp_order->get_compid( )
        i_screenid      = cl_ishmed_scr_order=>co_otype_scr_order_med
        i_stsma         = l_stsma
        i_estat         = l_estat
        i_fattr_type_id = cl_ishmed_fattr_type=>co_display
      IMPORTING
        et_scrm         = lt_scrm_order.        "Oana B
    APPEND LINES OF lt_scrm_order TO lt_scrm.   "Oana B

*   Get the defined scrm definitions for patient component. "Oana B
    CALL METHOD lr_cordtyp->get_t_scrm
      EXPORTING
        i_compid        = lr_comp_patient->get_compid( )
        i_screenid      = cl_ish_scr_patient=>co_otype_scr_patient
        i_stsma         = l_stsma
        i_estat         = l_estat
        i_fattr_type_id = cl_ishmed_fattr_type=>co_display
      IMPORTING
        et_scrm         = lt_scrm_patient.        "Oana B
    APPEND LINES OF lt_scrm_patient TO lt_scrm.   "Oana B

if lr_comp_waiting_list is not initial.
*   Get the defined scrm definitions for patient component. "Oana B
    CALL METHOD lr_cordtyp->get_t_scrm
      EXPORTING
        i_compid        = lr_comp_waiting_list->get_compid( )
        i_screenid      = cl_ish_scr_waiting_list=>co_otype_scr_waiting_list
        i_stsma         = l_stsma
        i_estat         = l_estat
        i_fattr_type_id = cl_ishmed_fattr_type=>co_display
      IMPORTING
        et_scrm         = lt_scrm_waiting_list.        "Oana B
    APPEND LINES OF lt_scrm_waiting_list TO lt_scrm.   "Oana B
endif.

*   Build table for screen modification.
    LOOP AT lt_scrm INTO lr_scrm.
*     Get SCRM data.
      CHECK NOT lr_scrm IS INITIAL.
      CALL METHOD lr_scrm->get_data
        RECEIVING
          rs_n1scrm = ls_n1scrm.
*     Get FATTR data.
      CALL METHOD lr_scrm->get_fattr
        RECEIVING
          rr_fattr = lr_fattr.
      CHECK NOT lr_fattr IS INITIAL.
      CALL METHOD lr_fattr->get_data
        RECEIVING
          rs_n1fattr = ls_n1fattr.
*     Check for an existing entry.
      CLEAR: ls_scrm_fattr, l_append.
      READ TABLE lt_scrm_fattr
      WITH KEY n1scrm-compid    = ls_n1scrm-compid
*              screenid?
               n1scrm-fieldname = ls_n1scrm-fieldname
      INTO ls_scrm_fattr.
      IF sy-subrc = 0.
*       Compare priority (0001-high ... 9999-low).
        IF ls_scrm_fattr-n1fattr-prio > ls_n1fattr-prio.
*         Delete existing entry with lower priority.
          DELETE lt_scrm_fattr INDEX sy-tabix.
          l_append = abap_true.
        ENDIF.
      ELSE.
        l_append = abap_true.
      ENDIF.
      IF l_append = abap_true.
*       Append new entry.
        CLEAR ls_scrm_fattr.
        ls_scrm_fattr-n1scrm  = ls_n1scrm.
        ls_scrm_fattr-n1fattr = ls_n1fattr.
        APPEND ls_scrm_fattr TO lt_scrm_fattr.
      ENDIF.
    ENDLOOP.  "lt_scrm
*END FILL Modifications Table with Order Componenent Values

  ENDLOOP.

  gt_scrm_fattr = lt_scrm_fattr.

ENDMETHOD.


METHOD get_fattr_value_for_fname.
* Created By AM,22.05.2012
* Created For Isis : MED-47907
* Details:
*  get fattr id for a fieldname

  FIELD-SYMBOLS <fs_scrm_fattr> TYPE ty_scrm_fattr.

  IF gt_scrm_fattr IS INITIAL.
    fill_t_head_comp_screen_modif( ).
  ENDIF.

  LOOP AT gt_scrm_fattr ASSIGNING <fs_scrm_fattr> WHERE n1scrm-fieldname = i_fieldname.
    r_fattr_id = <fs_scrm_fattr>-n1fattr-fattr_value_id.
  ENDLOOP.


ENDMETHOD.


METHOD get_ish_inactive_field_flag.
* Created By AM,22.05.2012
* Created For Isis : MED-47907
* Details:
*  get the inaktiv flag for an ish field

  DATA: i_fieldname_prefix TYPE ish_fieldname,
        i_fieldname_sufix TYPE ish_fieldname.

  IF i_fieldname IS NOT INITIAL.

    SPLIT i_fieldname AT '-' INTO i_fieldname_prefix i_fieldname_sufix.

  ENDIF.

  CASE i_fieldname_prefix.
    WHEN 'DLOOP'.
      CALL FUNCTION 'ISH_MODIFIED_FIELD'
        EXPORTING
          pname     = 'SAPLNADR'
          dynnr     = '0750'
          einri     = i_einri
          field     = i_fieldname
        IMPORTING
          inactive  = e_inactive
        EXCEPTIONS
          not_found = 1.
    WHEN 'RN1_DYNP_ORDER_MED'.
      CALL FUNCTION 'ISH_MODIFIED_FIELD'
        EXPORTING
          pname     = 'SAPLN1_SDY_ORDER_MED'
          dynnr     = '0100'
          einri     = i_einri
          field     = i_fieldname
        IMPORTING
          inactive  = e_inactive
        EXCEPTIONS
          not_found = 1.
    WHEN 'NPAT'.
      CALL FUNCTION 'ISH_MODIFIED_FIELD'
        EXPORTING
          pname     = 'SAPLN1VPS'
          dynnr     = '0100'
          einri     = i_einri
          field     = i_fieldname
        IMPORTING
          inactive  = e_inactive
        EXCEPTIONS
          not_found = 1.
    WHEN 'RN1_DYNP_WAITING_LIST'.
      CALL FUNCTION 'ISH_MODIFIED_FIELD'
        EXPORTING
          pname     = 'SAPLNCORD'
          dynnr     = '0400'
          einri     = i_einri
          field     = i_fieldname
        IMPORTING
          inactive  = e_inactive
        EXCEPTIONS
          not_found = 1.
  ENDCASE.

ENDMETHOD.


METHOD if_ex_ish_pat_html_header~change .

  DATA: lr_tab             TYPE REF TO cl_dd_table_element,
        lr_col0            TYPE REF TO cl_dd_area,
        lr_service         TYPE REF TO cl_ishmed_service,
        lr_environment     TYPE REF TO cl_ish_environment,
*        lr_object          TYPE ish_object,                     "REM MED-9409
        lt_service         TYPE ish_objectlist,
        ls_service         LIKE LINE OF lt_service,
        lt_nlei            TYPE STANDARD TABLE OF nlei,
        ls_nlei            LIKE LINE OF lt_nlei,
        lt_nlem            TYPE STANDARD TABLE OF nlem,
        ls_nlem            LIKE LINE OF lt_nlem,
        l_coltxt           TYPE sdydo_text_element,
        l_coltxt1          TYPE sdydo_text_element,
        l_coltxt2          TYPE sdydo_text_element,
        l_fontsize         TYPE sdydo_attribute,
        ls_npat            TYPE npat,
        ls_npap            TYPE npap,
        l_srv_ktxt1        TYPE ntpt-ktxt1,
        l_orgid            TYPE orgid,
        l_rc               TYPE ish_method_rc,
        l_header(500)      TYPE c,
        l_service(500)     TYPE c,
        l_pname(70)        TYPE c,
        l_gbdat            TYPE npat-gbdat,
        l_age              TYPE i,
        l_age_char(3)      TYPE c,
        l_gschl            TYPE npat-gschl,
        l_gschle           TYPE tn17t-gschle.
*        l_type             TYPE i.                              "REM MED-9409
  DATA: lr_pap             TYPE REF TO cl_ish_patient_provisional,
        l_order_oe(15)     TYPE c,
        l_spec_div_oe(15)  TYPE c,
        lr_error           TYPE REF TO cl_ishmed_errorhandling,
        ls_pap             TYPE rnpap_attrib,
        l_pname_pat        TYPE ish_pnamec,
        lr_col1            TYPE REF TO cl_dd_area,
        lr_col2            TYPE REF TO cl_dd_area,
        lr_col3            TYPE REF TO cl_dd_area,
        lr_col4            TYPE REF TO cl_dd_area,
        lr_col5            TYPE REF TO cl_dd_area,
        lr_col6            TYPE REF TO cl_dd_area,
        l_ishmed           TYPE ish_on_off,
        lr_corder          TYPE REF TO cl_ish_corder,
        lr_corder_med      TYPE REF TO cl_ishmed_corder,
        l_object           TYPE REF TO cl_ish_objectbase,
        l_object_type      TYPE i,
        l_inherited_from   TYPE ish_on_off,
        l_number(15)       TYPE c,
        ls_n1corder        TYPE n1corder,
        l_oe               TYPE norg-orgkb,
        l_oe_f             TYPE norg-orgkb,
        l_gp               TYPE ish_pnamec,
        l_prgnr            TYPE n1cordnr,
        l_gschl_html(15)   TYPE c,
        l_gschltxt         TYPE tn17t-gschltxt,
        l_phone_number     TYPE n1corder-rckruf,
        l_icon             TYPE char30,
        l_gpart            TYPE n1corder-etrgp,
        l_gpart_txt(15)    TYPE c,
        l_wladt_txt(10)    TYPE c,
        l_wladt(10)        TYPE c,
        l_wladt_int        TYPE sy-datum,
        l_title            TYPE n1corder-cordtitle,
        l_title_txt(10)    TYPE c,
        ls_adr             TYPE nadr.
DATA:   lr_identify        TYPE REF TO if_ish_identify_object.     "MED-9409
DATA: l_gender_text TYPE ish_sex_specialization_txt. "Gratzl MED-75262 note 2863262
  DATA: l_sex_external_ud TYPE gschle.                 "CDuerr, MED-83285

* BEGIN MED-47907 Oana Bocarnea
  DATA: l_fieldname   TYPE ish_fieldname,
        l_fattr_value TYPE n1fattr_value-fattr_value_id.

  DATA: l_nname_pat  TYPE ish_pnamec,
        l_vname_pat  TYPE ish_pnamec,
        l_npat_gbdat TYPE sdydo_text_element.

  DATA: l_ish_inactive_flag type ish_on_off.
* END MED-47907 Oana Bocarnea

  FIELD-SYMBOLS: <telno> TYPE rnadr_telephone.

* initialization
  CLEAR:   ls_nlei, ls_nlem, l_orgid.

  REFRESH: lt_nlei, lt_nlem.

* check the caller
  CASE called_from.

* ------------------------------------------------------------
*   process team planning
* ------------------------------------------------------------
    WHEN 'CL_ISHMED_PRC_TEAM'.
*     check if service
      IF NOT ish_object IS INITIAL.
*-------- BEGIN C.Honeder MED-9409
        IF ish_object->is_inherited_from( cl_ishmed_service=>co_otype_med_service ) = abap_on.
*        lr_object-object ?= ish_object.
*        CALL METHOD lr_object-object->('GET_TYPE')
*          IMPORTING
*            e_object_type = l_type.

*       check if med_service
*        IF l_type = cl_ishmed_service=>co_otype_med_service.
*-------- END C.Honeder MED-9409
          lr_service ?= ish_object.
          CALL METHOD lr_service->get_data
            IMPORTING
              e_rc   = l_rc
              e_nlei = ls_nlei
              e_nlem = ls_nlem.
          IF l_rc = 0.
*           org. unit
            l_orgid = ls_nlei-erboe.
            APPEND ls_nlei TO lt_nlei.
            APPEND ls_nlem TO lt_nlem.
          ENDIF.
*       check if anchor_service
*        CALL METHOD lr_object-object->('GET_TYPE')               "REM MED-9409
*          IMPORTING                                              "REM MED-9409
*            e_object_type = l_type.                              "REM MED-9409

*        ELSEIF l_type = cl_ishmed_service=>co_otype_anchor_srv.   "REM MED-9409
        ELSEIF ish_object->is_inherited_from( cl_ishmed_service=>co_otype_anchor_srv ) = abap_on. "MED-9409
          lr_service ?= ish_object.
          CALL METHOD lr_service->get_data
            IMPORTING
              e_rc   = l_rc
              e_nlei = ls_nlei
              e_nlem = ls_nlem.
          IF l_rc = 0.
*           org. unit
            l_orgid = ls_nlei-erboe.
*           do not append LT_NLEI (no display of anchor service)
            APPEND ls_nlem TO lt_nlem.
          ENDIF.
*         get environment out of service
          CALL METHOD lr_service->get_environment
            IMPORTING
              e_environment = lr_environment.
*         get services for op anchor service
          CALL METHOD cl_ishmed_service=>get_serv_for_op
            EXPORTING
              i_service     = lr_service
              i_environment = lr_environment
            IMPORTING
              e_rc          = l_rc
              et_services   = lt_service.
          LOOP AT lt_service INTO ls_service.
            lr_service ?= ls_service-object.
            CALL METHOD lr_service->get_data
              IMPORTING
                e_rc   = l_rc
                e_nlei = ls_nlei.
            IF l_rc = 0.
              APPEND ls_nlei TO lt_nlei.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.

*     get patient
      IF NOT patient IS INITIAL.
        CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
          EXPORTING
            i_patnr = patient
          IMPORTING
            es_npat = ls_npat
            e_rc    = l_rc.
        IF l_rc = 0.
*         get data
          CALL METHOD cl_ish_utl_base_patient=>get_name_patient
            EXPORTING
              i_patnr = patient
              is_npat = ls_npat
            IMPORTING
              e_pname = l_pname.
          l_pname_pat = l_pname.
          l_gschl     = ls_npat-gschl.
          l_gbdat     = ls_npat-gbdat.
        ELSE.
          EXIT.
        ENDIF.
*     get prov. patient
      ELSEIF patient IS INITIAL AND NOT ish_object IS INITIAL.
        READ TABLE lt_nlem INTO ls_nlem INDEX 1.
        IF sy-subrc <> 0.
          EXIT.
        ENDIF.
        CALL METHOD cl_ish_dbr_pap=>get_pap_by_papid
          EXPORTING
            i_papid = ls_nlem-papid
          IMPORTING
            es_npap = ls_npap
            e_rc    = l_rc.
        IF l_rc = 0.
*         get data
          CALL METHOD cl_ish_utl_base_patient=>get_name_patient
            EXPORTING
              i_papid = ls_npap-papid
              is_npap = ls_npap
            IMPORTING
              e_pname = l_pname.
          l_pname_pat = l_pname.
          l_gschl     = ls_npap-gschl.
          l_gbdat     = ls_npap-gbdat.
        ENDIF.
      ENDIF.
*     sex
      CALL FUNCTION 'ISH_CONVERT_SEX_OUTPUT'
        EXPORTING
          ss_gschl  = l_gschl
        IMPORTING
          ss_gschle = l_gschle
        EXCEPTIONS
          OTHERS    = 1.
*     begin Gratzl MED-75262 note 2863262
      CALL FUNCTION 'ISH_SEXUAL_IDENTITY_CHECK'
        EXPORTING
          i_sex_internal              = ls_npat-gschl
          i_sex_special               = ls_npat-sex_special
        IMPORTING
          e_sex_special_txt           = l_gender_text
          e_sex_external_ud           = l_sex_external_ud           "CDuerr, MED-83285
        EXCEPTIONS
          sexual_identity_not_defined = 1.
      l_gschle = l_gender_text(1).
      IF l_gschle IS INITIAL.                                       "CDuerr, MED-83285
        l_gschle = l_sex_external_ud.                               "CDuerr, MED-83285
      ENDIF.                                                        "CDuerr, MED-83285
*     end Gratzl MED-75262 note 2863262
*     calculate age
      IF NOT l_gbdat IS INITIAL.
        CALL FUNCTION 'ISH_FIND_AGE'
          EXPORTING
            date_of_birth = l_gbdat
          IMPORTING
            age           = l_age
          EXCEPTIONS
            age_negative  = 1
            OTHERS        = 2.
        IF sy-subrc = 0 AND l_age > 0 AND l_age < 250.
          l_age_char = l_age.
        ENDIF.
      ENDIF.

*     build header [name(age, sex): service, service, ...]
      IF NOT l_pname IS INITIAL.
*       name
        CONCATENATE l_pname '(' INTO l_header SEPARATED BY space.
*       age
        IF NOT l_age_char IS INITIAL.
          CONCATENATE l_header l_age_char INTO l_header.
        ENDIF.
*       sex
        IF NOT l_gschle IS INITIAL.
          CONCATENATE l_header ',' INTO l_header.
          CONCATENATE l_header l_gschle INTO l_header SEPARATED BY space.
        ENDIF.
        CONCATENATE l_header ')' INTO l_header.
      ENDIF.

      IF NOT lt_nlei[] IS INITIAL.
        CONCATENATE l_header ':' INTO l_header.
      ENDIF.

*     get service text
      LOOP AT lt_nlei INTO ls_nlei.
        IF ls_nlei-leitx <> space.
*         ... aus der Leistung (wenn befüllt)
          l_srv_ktxt1 = ls_nlei-leitx.
        ELSE.
*         ... aus den Stammdaten
          CALL FUNCTION 'ISHMED_READ_NTPT'
            EXPORTING
              i_einri = institution
              i_talst = ls_nlei-leist
              i_tarif = ls_nlei-haust
            IMPORTING
              e_ktxt1 = l_srv_ktxt1.
        ENDIF.
        IF NOT l_srv_ktxt1 IS INITIAL AND l_service IS INITIAL.
          l_service = l_srv_ktxt1.
        ELSEIF NOT l_service IS INITIAL.
          CONCATENATE l_service ',' INTO l_service.
          CONCATENATE l_service l_srv_ktxt1 INTO l_service
                            SEPARATED BY space.
        ENDIF.
      ENDLOOP.

      IF NOT l_orgid IS INITIAL.
        IF NOT l_service IS INITIAL.
          CONCATENATE l_service ':' INTO l_service.
        ELSE.
          CONCATENATE l_header ':' INTO l_header.
        ENDIF.
      ENDIF.

*     set output
      l_coltxt  = l_header.
      l_coltxt1 = l_service.
      l_coltxt2 = l_orgid.

*     clear document
      CALL METHOD dyn_document->initialize_document
        EXPORTING
          background_color = dyn_document->col_background_level2
          no_margins       = 'X'.

*     set table
      CALL METHOD dyn_document->add_table
        EXPORTING
          no_of_columns               = 1
*         cell_background_transparent = ''
          border                      = '0'
          width                       = '100%'
        IMPORTING
          table                       = lr_tab.
*     set column
      CALL METHOD lr_tab->add_column
        EXPORTING
          width  = '100%'
*         bg_color = '8'
        IMPORTING
          column = lr_col0.
*     name(age, sex)
      CALL METHOD lr_col0->add_text
        EXPORTING
          text         = l_coltxt
          sap_fontsize = cl_dd_area=>large
          sap_emphasis = cl_dd_area=>strong.
*     service, service, ...
      CALL METHOD lr_col0->add_text
        EXPORTING
          text = l_coltxt1.
*     org. unit
      CALL METHOD lr_col0->add_text
        EXPORTING
          text = l_coltxt2.


* -------------------------------------------------------------------
*   process clinical order
* -------------------------------------------------------------------
    WHEN 'CL_ISH_PRC_CORDER'.

      CHECK NOT ish_object IS INITIAL.
      CHECK ish_object->is_inherited_from(
          cl_ish_corder=>co_otype_corder ) = 'X'.
      lr_corder ?= ish_object.
*     ish or ishmed?
      IF ish_object->is_inherited_from(
          cl_ishmed_corder=>co_otype_corder_med ) = 'X'.
        l_ishmed = 'X'.
      ENDIF.

*MED-47907,AM
*set global corder attribute,
      gr_corder = lr_corder.
*END MED-47907

*     get data from main object = clinical order
      CALL METHOD lr_corder->get_data
        IMPORTING
          es_n1corder     = ls_n1corder
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = lr_error.
      CHECK l_rc = 0.

*     set font size
      l_fontsize = cl_dd_area=>large.

      IF NOT patient IS INITIAL.
*       get patient
        CALL METHOD cl_ish_dbr_pat=>get_pat_data_by_patnr
          EXPORTING
            i_patnr     = patient
            i_with_nadr = 'X'
            i_einri     = institution
          IMPORTING
            es_npat     = ls_npat
            es_nadr     = ls_adr
            e_rc        = l_rc.
        IF l_rc = 0.
*         get data
          CALL METHOD cl_ish_utl_base_patient=>get_name_patient
            EXPORTING
              i_patnr = patient
              is_npat = ls_npat
            IMPORTING
              e_pname = l_pname.
          l_pname_pat = l_pname.
          l_gschl     = ls_npat-gschl.
          l_gbdat     = ls_npat-gbdat.
        ELSE.
          EXIT.
        ENDIF.
      ELSEIF patient IS INITIAL.
*       get prov. patient
        CALL METHOD cl_ish_utl_base_patient=>get_pap_for_object
          EXPORTING
            i_object       = ish_object
          IMPORTING
            e_pap_obj      = lr_pap
            e_rc           = l_rc
          CHANGING
            c_errorhandler = lr_error.
        IF l_rc NE 0.
          EXIT.
        ENDIF.
        IF NOT lr_pap IS INITIAL.
          CALL METHOD lr_pap->get_data
            IMPORTING
              es_data        = ls_pap
              e_rc           = l_rc
            CHANGING
              c_errorhandler = lr_error.
          IF l_rc NE 0.
            EXIT.
          ENDIF.
          MOVE-CORRESPONDING ls_pap TO ls_npat.
          MOVE-CORRESPONDING ls_pap TO ls_adr.
          READ TABLE ls_pap-telno ASSIGNING <telno> INDEX 1.
          IF sy-subrc EQ 0.
            ls_adr-telnr = <telno>-telnr.
          ENDIF.
          CALL FUNCTION 'ISH_CONVERT_SEX_INPUT'
            EXPORTING
              ss_gschle = ls_pap-gschle
            IMPORTING
              ss_gschl  = ls_npat-gschl
            EXCEPTIONS
              not_found = 1
              OTHERS    = 2.
          l_rc = sy-subrc.
          CHECK l_rc = 0.
        ENDIF.
*       patient name
        CALL METHOD cl_ish_utl_base_patient=>get_patname_for_object
          EXPORTING
            i_object       = lr_corder
          IMPORTING
            e_pnamec       = l_pname_pat
            e_rc           = l_rc
          CHANGING
            c_errorhandler = lr_error.
      ENDIF.
*     clear document
      CALL METHOD dyn_document->initialize_document
        EXPORTING
          background_color = dyn_document->col_background_level2
          no_margins       = 'X'.

*     set table and columns (first column: left margin)
      CALL METHOD dyn_document->add_table
        EXPORTING
          no_of_columns = 7
          border        = '0'
          width         = '100%'
        IMPORTING
          table         = lr_tab.

      CALL METHOD lr_tab->add_column
        EXPORTING
          width  = '1%'
        IMPORTING
          column = lr_col0.
      CALL METHOD lr_tab->add_column
        EXPORTING
          width  = '12%'
        IMPORTING
          column = lr_col1.
      CALL METHOD lr_tab->add_column
        EXPORTING
          width  = '37%'
        IMPORTING
          column = lr_col2.
      CALL METHOD lr_tab->add_column
        EXPORTING
          width  = '10%'
        IMPORTING
          column = lr_col3.
      CALL METHOD lr_tab->add_column
        EXPORTING
          width  = '15%'
        IMPORTING
          column = lr_col4.
      CALL METHOD lr_tab->add_column
        EXPORTING
          width  = '10%'
        IMPORTING
          column = lr_col5.
      CALL METHOD lr_tab->add_column
        EXPORTING
          width  = '15%'
        IMPORTING
          column = lr_col6.

*     set font size
*      l_fontsize = cl_dd_area=>large.

*     first row: patient name, birth date, order oe, Specialized
*     division oe

*   - patient name and date
      CALL METHOD lr_tab->span_columns
        EXPORTING
          col_start_span = lr_col1
          no_of_cols     = 2.

*BEGIN  REM MED-47907 Oana Bocarnea                                           REM MED-47907
*        IF ls_npat-gbdat IS INITIAL.                                         REM MED-47907
*          WRITE space TO l_coltxt.                                           REM MED-47907
*        ELSE.                                                                REM MED-47907
*          WRITE ls_npat-gbdat TO l_coltxt DD/MM/YYYY.                        REM MED-47907
*        ENDIF.                                                               REM MED-47907
*      ENDIF.                                                                 REM MED-47907

*        IF l_coltxt NE space.                                                REM MED-47907
*          CONCATENATE ',' l_coltxt INTO l_coltxt SEPARATED BY space.         REM MED-47907
*          CONCATENATE l_pname_pat l_coltxt INTO l_coltxt.                    REM MED-47907
*        ELSE.                                                                REM MED-47907
*        l_coltxt = l_pname_pat.                                              REM MED-47907
*        ENDIF.                                                               REM MED-47907
* END REM MED-47907 Oana Bocarnea

* BEGIN MED-47907 Oana Bocarnea, 01.08.2012

      SPLIT l_pname_pat AT ',' INTO l_nname_pat l_vname_pat.

      l_fieldname = 'NPAT-VNAME'.
      get_fattr_value_for_fname( EXPORTING i_fieldname = l_fieldname IMPORTING r_fattr_id = l_fattr_value ).
      get_ish_inactive_field_flag( exporting i_fieldname = l_fieldname i_einri = institution importing e_inactive = l_ish_inactive_flag  ).
      IF l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive AND l_ish_inactive_flag = abap_false.
        WRITE l_vname_pat TO l_coltxt .
      ENDIF.

      l_fieldname = 'NPAT-NNAME'.
      get_fattr_value_for_fname( EXPORTING i_fieldname = l_fieldname IMPORTING r_fattr_id = l_fattr_value ).
      get_ish_inactive_field_flag( exporting i_fieldname = l_fieldname i_einri = institution importing e_inactive = l_ish_inactive_flag  ).
      IF l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive AND l_ish_inactive_flag = abap_false.
        IF l_coltxt IS NOT INITIAL.
          CONCATENATE l_nname_pat ' ' l_coltxt INTO l_coltxt.
        ELSE.
          WRITE l_nname_pat TO l_coltxt.
        ENDIF.
      ENDIF.

      l_fieldname = 'NPAT-GBDAT'.
      get_fattr_value_for_fname( EXPORTING i_fieldname = l_fieldname IMPORTING r_fattr_id = l_fattr_value ).
      get_ish_inactive_field_flag( exporting i_fieldname = l_fieldname i_einri = institution importing e_inactive = l_ish_inactive_flag  ).
      IF l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive AND l_ish_inactive_flag = abap_false.
        IF ls_npat-gbdat IS NOT INITIAL.
         IF l_coltxt IS INITIAL.
           WRITE ls_npat-gbdat TO l_coltxt DD/MM/YYYY.
         ELSE.
           WRITE ls_npat-gbdat TO l_npat_gbdat DD/MM/YYYY.
              CONCATENATE l_coltxt ',' l_npat_gbdat INTO l_coltxt SEPARATED BY SPACE.
         ENDIF.
        ENDIF.
      ENDIF.
*END MED-47907 Oana Bocarnea, 01.08.2012
      IF NOT l_coltxt IS INITIAL.            "MED-47907 Oana B
      CALL METHOD lr_col0->add_text
        EXPORTING
          text = ' '.
        CALL METHOD lr_col1->add_text
        EXPORTING
          text         = l_coltxt
          sap_emphasis = cl_dd_area=>strong
          sap_fontsize = l_fontsize.
      ENDIF.                                 "MED-47907 Oana B

* - phone

*BEGIN MED-47907 Alex Maie

     l_fieldname = 'DLOOP-TELNR'.
     get_ish_inactive_field_flag( exporting i_fieldname = l_fieldname i_einri = institution importing e_inactive = l_ish_inactive_flag  ).
      IF NOT ls_adr-telnr IS INITIAL AND l_ish_inactive_flag = abap_false.
*END MED-47907 Alex Maie
        CALL METHOD lr_col2->add_icon
          EXPORTING
            sap_icon = 'ICON_PHONE'.
        l_coltxt = ls_adr-telnr.
        CALL METHOD lr_col2->add_text
          EXPORTING
            text = l_coltxt.
      ENDIF. " MED-47907 Oana B

*   - order oe
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
      l_fieldname = 'RN1_DYNP_ORDER_MED-ETROEGP'.
      get_fattr_value_for_fname( EXPORTING i_fieldname = l_fieldname IMPORTING r_fattr_id = l_fattr_value ).
      get_ish_inactive_field_flag( exporting i_fieldname = l_fieldname i_einri = institution importing e_inactive = l_ish_inactive_flag  ).
*END MED-47907,  Oana Bocarnea
      IF l_ishmed = 'X'.
        l_order_oe = 'Veranlasser:'(004).
        IF NOT ls_n1corder-etroe IS INITIAL.
*         name of oe
          CALL METHOD cl_ish_utl_base_descr=>get_descr_orgunit
            EXPORTING
              i_einri         = ls_n1corder-einri
              i_orgid         = ls_n1corder-etroe
            IMPORTING
              e_orgkb         = l_oe
              e_rc            = l_rc
            CHANGING
              cr_errorhandler = lr_error.
          l_coltxt = l_order_oe.
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
          IF NOT l_coltxt IS INITIAL AND l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive
             AND l_ish_inactive_flag = abap_false.
*END MED-47907,  Oana Bocarnea
            CALL METHOD lr_col3->add_text
            EXPORTING
              text         = l_coltxt
              sap_emphasis = cl_dd_area=>strong.
          l_coltxt = l_oe.
          CALL METHOD lr_col4->add_text
            EXPORTING
              text = l_coltxt.
          ENDIF. "MED-47907, Oana B
        ELSEIF NOT ls_n1corder-etrgp IS INITIAL.
          CALL METHOD cl_ish_utl_base_gpa=>get_name_gpa
            EXPORTING
              i_gpart         = ls_n1corder-etrgp
            IMPORTING
              e_pname         = l_gp
              e_rc            = l_rc
            CHANGING
              cr_errorhandler = lr_error.
          l_coltxt = l_order_oe.
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
          IF NOT l_coltxt IS INITIAL AND l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive
             AND l_ish_inactive_flag = abap_false.
*END MED-47907,  Oana Bocarnea
            CALL METHOD lr_col3->add_text
            EXPORTING
              text         = l_coltxt
              sap_emphasis = cl_dd_area=>strong.
          l_coltxt = l_gp.
          CALL METHOD lr_col4->add_text
            EXPORTING
              text = l_coltxt.
          ENDIF. "MED-47907, Oana B
        ENDIF.
      ELSE.
        l_order_oe = 'Veranlasser:'(004).
        l_coltxt = l_order_oe.
        IF NOT ls_n1corder-etroe IS INITIAL.
          l_oe = ls_n1corder-etroe.
          l_coltxt = l_order_oe.
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
          IF NOT l_coltxt IS INITIAL AND l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive
             AND l_ish_inactive_flag = abap_false.
*END MED-47907,  Oana Bocarnea
            CALL METHOD lr_col3->add_text
            EXPORTING
              text         = l_coltxt
              sap_emphasis = cl_dd_area=>strong.
          l_coltxt = l_oe.
          CALL METHOD lr_col4->add_text
            EXPORTING
              text = l_coltxt.
          ENDIF. "MED-47907 , Oana B
        ELSEIF NOT ls_n1corder-etrgp IS INITIAL.
          l_gp = ls_n1corder-etrgp.
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
          IF NOT l_coltxt IS INITIAL AND l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive
             AND l_ish_inactive_flag = abap_false.
*END MED-47907,  Oana Bocarnea
          CALL METHOD lr_col3->add_text
            EXPORTING
              text         = l_coltxt
              sap_emphasis = cl_dd_area=>strong.
          l_coltxt = l_gp.
          CALL METHOD lr_col4->add_text
            EXPORTING
              text = l_coltxt.
          ENDIF. "MED-47907, Oana B
        ENDIF.
      ENDIF.
*      CALL METHOD lr_tab->span_columns
*        EXPORTING
*          col_start_span = lr_col3
*          no_of_cols     = 2.

*     specialized division oe
      IF l_ishmed = 'X'.
*BEGIN MED-47907, Oana Bocarnea
        l_fieldname = 'RN1_DYNP_ORDER_MED-ORDDEP'.
        get_fattr_value_for_fname( EXPORTING i_fieldname = l_fieldname IMPORTING r_fattr_id = l_fattr_value ).
        get_ish_inactive_field_flag( exporting i_fieldname = l_fieldname i_einri = institution importing e_inactive = l_ish_inactive_flag  ).
*END MED-47907,  Oana Bocarnea
        l_spec_div_oe = 'Fachabt:'(002).
*       name of oe
        CALL METHOD cl_ish_utl_base_descr=>get_descr_orgunit
          EXPORTING
            i_einri         = ls_n1corder-einri
            i_orgid         = ls_n1corder-orddep
          IMPORTING
            e_orgkb         = l_oe_f
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = lr_error.
        l_coltxt = l_spec_div_oe.
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
        IF NOT l_coltxt IS INITIAL AND l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive
           AND l_ish_inactive_flag = abap_false.
*END MED-47907,  Oana Bocarnea
          CALL METHOD lr_col5->add_text
          EXPORTING
            text         = l_coltxt
            sap_emphasis = cl_dd_area=>strong.
        l_coltxt = l_oe_f.
        CALL METHOD lr_col6->add_text
          EXPORTING
            text = l_coltxt.
*        CALL METHOD lr_tab->span_columns
*          EXPORTING
*            col_start_span = lr_col5
*            no_of_cols     = 2.
        ENDIF.                             "MED-47907, Oana B
      ENDIF.

*     new row: sex, date of admission, number of clinical order
      CALL METHOD lr_tab->new_row
        EXPORTING
          sap_color = cl_dd_area=>list_background.

      IF NOT ls_npat-gschl IS INITIAL.
        CLEAR l_coltxt.
        l_gschl_html = 'Geschl.:'(003).
*       sex
        CALL FUNCTION 'ISH_CONVERT_SEX_OUTPUT'
          EXPORTING
            ss_gschl    = ls_npat-gschl
          IMPORTING
            ss_gschle   = l_gschle
            ss_gschltxt = l_gschltxt
          EXCEPTIONS
            OTHERS      = 1.
        l_rc = sy-subrc.
        CHECK l_rc = 0.
*       begin Gratzl MED-75262 note 2863262
        CALL FUNCTION 'ISH_SEXUAL_IDENTITY_CHECK'
          EXPORTING
            i_sex_internal              = ls_npat-gschl
            i_sex_special               = ls_npat-sex_special
          IMPORTING
            e_sex_special_txt           = l_gender_text
          EXCEPTIONS
            sexual_identity_not_defined = 1.
*       end Gratzl MED-75262 note 2863262
        l_coltxt = l_gschl_html.
        CALL METHOD lr_col1->add_text
          EXPORTING
            text         = l_coltxt
            sap_emphasis = cl_dd_area=>strong.
*        l_coltxt = l_gschltxt.     "CDuerr, MED-83285
        l_coltxt = l_gender_text. "Gratzl MED-75262 note 2863262
        IF l_coltxt IS INITIAL.     "CDuerr, MED-83285
          l_coltxt = l_gschltxt.    "CDuerr, MED-83285
        ENDIF.                      "CDuerr, MED-83285
        CALL METHOD lr_col2->add_text
          EXPORTING
            text = l_coltxt.
*        CALL METHOD lr_tab->span_columns
*          EXPORTING
*            col_start_span = lr_col1
*            no_of_cols     = 2.
      ENDIF.

*     date of admission
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
      l_fieldname = 'RN1_DYNP_WAITING_LIST-WLADT'.
      get_fattr_value_for_fname( EXPORTING i_fieldname = l_fieldname IMPORTING r_fattr_id = l_fattr_value ).
      get_ish_inactive_field_flag( exporting i_fieldname = l_fieldname i_einri = institution importing e_inactive = l_ish_inactive_flag  ).
*END MED-47907,  Oana Bocarnea
      IF NOT ls_n1corder-wladt IS INITIAL.
        l_wladt_int = ls_n1corder-wladt.
        l_wladt =
        cl_ish_utl_base_conv=>conv_date_to_extern( l_wladt_int ).
      ENDIF.
      l_wladt_txt = 'Aufn.:'(008).
      l_coltxt = l_wladt_txt.
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
      IF NOT l_coltxt IS INITIAL AND l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive
         AND l_ish_inactive_flag = abap_false.
*END MED-47907,  Oana Bocarnea
        CALL METHOD lr_col3->add_text
        EXPORTING
          text         = l_coltxt
          sap_emphasis = cl_dd_area=>strong.
      l_coltxt = l_wladt.
      CALL METHOD lr_col4->add_text
        EXPORTING
          text = l_coltxt.
*      CALL METHOD lr_tab->span_columns
*        EXPORTING
*          col_start_span = lr_col3
*          no_of_cols     = 2.
       ENDIF. "MED-47907, Oana B

*     number of clinical order

      CLEAR l_coltxt.
      IF l_ishmed = 'X'.
        l_number = 'Auftragsnr.:'(005).
      ELSE.
        l_number = 'Vormerknr.:'(006).
      ENDIF.

      l_fieldname = 'RN1_DYNP_ORDER_MED-PRGNR'. " MED-47907 Oana B
      l_prgnr = ls_n1corder-prgnr.
      CLEAR l_coltxt.
      l_coltxt = l_number.
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
      get_ish_inactive_field_flag( exporting i_fieldname = l_fieldname i_einri = institution importing e_inactive = l_ish_inactive_flag  ).
      IF NOT l_prgnr IS INITIAL AND l_ish_inactive_flag = abap_false.
*END MED-47907 Oana Bocarnea
      CALL METHOD lr_col5->add_text
        EXPORTING
          text         = l_coltxt
          sap_emphasis = cl_dd_area=>strong.
      CLEAR l_coltxt.
      IF l_prgnr CO ' 0123456789'.
        SHIFT l_prgnr LEFT DELETING LEADING '0'.
      ENDIF.
      l_coltxt = l_prgnr.
      CALL METHOD lr_col6->add_text
        EXPORTING
          text = l_coltxt.
*      CALL METHOD lr_tab->span_columns
*        EXPORTING
*          col_start_span = lr_col5
*          no_of_cols     = 2.
      ENDIF. " MED-47907 Oana B

*     new row
      CALL METHOD lr_tab->new_row
        EXPORTING
          sap_color = '8'.

*     clinical order title
*BEGIN MED-47907, Oana Bocarnea
      l_fieldname = 'RN1_DYNP_ORDER_MED-CORDTITLE'.
      get_fattr_value_for_fname( EXPORTING i_fieldname = l_fieldname IMPORTING r_fattr_id = l_fattr_value ).
      get_ish_inactive_field_flag( exporting i_fieldname = l_fieldname i_einri = institution importing e_inactive = l_ish_inactive_flag  ).
*END MED-47907, Oana Bocarnea
      l_title = ls_n1corder-cordtitle.
      l_title_txt = 'Auftragstitel:'(009).
      l_coltxt = l_title_txt.
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
      IF NOT l_coltxt IS INITIAL AND l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive
         AND l_ish_inactive_flag = abap_false.
*END MED-47907, Oana Bocarnea
      CALL METHOD lr_col1->add_text
        EXPORTING
          text         = l_coltxt
          sap_emphasis = cl_dd_area=>strong.
      l_coltxt = l_title.
      CALL METHOD lr_col2->add_text
        EXPORTING
          text = l_coltxt.
*      CALL METHOD lr_tab->span_columns
*        EXPORTING
*          col_start_span = lr_col1
*          no_of_cols     = 2.
      ENDIF.                             "MED-47907, Oana B

*     the person (coworker, physician)
*BEGIN MED-47907, Oana Bocarnea
      l_fieldname = 'RN1_DYNP_ORDER_MED-GPART'.
      get_fattr_value_for_fname( EXPORTING i_fieldname = l_fieldname IMPORTING r_fattr_id = l_fattr_value ).
      get_ish_inactive_field_flag( exporting i_fieldname = l_fieldname i_einri = institution importing e_inactive = l_ish_inactive_flag  ).
      l_gpart = ls_n1corder-etrgp.
*END MED-47907, Oana Bocarnea
      l_gpart_txt = 'Verantw. MA.:'(007).
      l_coltxt = l_gpart_txt.
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
      IF NOT l_coltxt IS INITIAL AND l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive
         AND l_ish_inactive_flag = abap_false .
*END MED-47907, Oana Bocarnea
      CALL METHOD lr_col3->add_text
        EXPORTING
          text         = l_coltxt
          sap_emphasis = cl_dd_area=>strong.

*     l_gpart = ls_n1corder-etrgp.    " REM MED-47907, Oana B
      IF l_gpart CO ' 0123456789'.
        SHIFT l_gpart LEFT DELETING LEADING '0'.
      ENDIF.
      l_coltxt = l_gpart.
      CALL METHOD lr_col4->add_text
        EXPORTING
          text = l_coltxt.
*      CALL METHOD lr_tab->span_columns
*        EXPORTING
*          col_start_span = lr_col3
*          no_of_cols     = 2.
      ENDIF.                             "MED-47907, Oana B

*     the phone
*BEGIN MED-47907,AM
      l_fieldname = 'RN1_DYNP_ORDER_MED-RCKRUF'.
      get_fattr_value_for_fname( EXPORTING i_fieldname = l_fieldname IMPORTING r_fattr_id = l_fattr_value ).
      get_ish_inactive_field_flag( exporting i_fieldname = l_fieldname i_einri = institution importing e_inactive = l_ish_inactive_flag  ).
*END MED-47907,AM
      l_phone_number = ls_n1corder-rckruf.
      l_icon = 'ICON_PHONE'.
      l_coltxt = l_phone_number.
*BEGIN MED-47907  Oana Bocarnea, 01.08.2012
      IF NOT l_coltxt IS INITIAL AND l_fattr_value <> cl_ishmed_fattr_value=>co_display_inactive
         AND l_ish_inactive_flag = abap_false.
*END MED-47907, Oana Bocarnea
        CALL METHOD lr_col5->add_icon
          EXPORTING
            sap_icon = l_icon.
*          SAP_SIZE         =
*          SAP_STYLE        =
*          SAP_COLOR        =
        CALL METHOD lr_col6->add_text
          EXPORTING
            text = l_coltxt.
*      CALL METHOD lr_tab->span_columns
*        EXPORTING
*          col_start_span = lr_col5
*          no_of_cols     = 2.
      ENDIF.

    WHEN OTHERS.

      EXIT.

  ENDCASE.

*MED-47907,AM, clear screen modifiactions , to ensure that at the next call we refresh the data
  FREE gt_scrm_fattr .
*END MED-47907

ENDMETHOD.                    "if_ex_ish_pat_html_header~change
ENDCLASS.
