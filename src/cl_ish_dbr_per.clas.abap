class CL_ISH_DBR_PER definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_DBR_PER
*"* do not include other source files here!!!

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
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
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

  class-methods GET_PER_BY_PERNR
    importing
      value(I_PERNR) type RI_PERNR
      value(I_READ_DB) type ISH_ON_OFF default OFF
    exporting
      value(ES_NPER) type NPER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_PER_BY_PERNR
    importing
      !IT_PERNR type STANDARD TABLE
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_FIELDNAME_PER) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_NPER) type ISHMED_T_NPER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_PER_BY_PERNR_RANGE
    importing
      value(IT_PERNR) type ISH_T_R_PERNR optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
    exporting
      value(ET_NPER) type ISHMED_T_NPER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DBR_PAT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DBR_PER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBR_PER IMPLEMENTATION.


METHOD get_per_by_pernr.

  DATA: l_buffer   TYPE ish_on_off.

  e_rc = 0.

  CLEAR: es_nper.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF i_read_db = on.
    l_buffer = off.
  ELSE.
    l_buffer = on.
  ENDIF.

  CALL FUNCTION 'ISH_READ_NPER'
    EXPORTING
      ss_pernr     = i_pernr
      ss_buffer    = l_buffer
    IMPORTING
      nper_e       = es_nper
    EXCEPTIONS
      not_found    = 1
      no_authority = 2
      OTHERS       = 3.

  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    IF cr_errorhandler IS BOUND.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD get_t_per_by_pernr.

  TYPES: BEGIN OF ty_pernr,
           pernr               TYPE nper-pernr,
         END OF ty_pernr,
         tyt_pernr             TYPE STANDARD TABLE OF ty_pernr.

  DATA: lt_pernr               TYPE tyt_pernr,
        ls_pernr               TYPE ty_pernr,
        ls_nper                LIKE LINE OF et_nper,
        lt_ngpa                TYPE ish_t_gpart,
        ls_ngpa                LIKE LINE OF lt_ngpa,
        lt_nper                TYPE ish_t_nper,
        l_data                 TYPE REF TO data,
        l_rc                   TYPE ish_method_rc,
        l_status               TYPE ish_on_off,
        lt_bpk                 TYPE ish_t_bup_pk,
        lt_ppk                 TYPE ish_t_prs_pk,
        lt_rc                  TYPE ish_bapiret2_tab_type.

  FIELD-SYMBOLS: <l_field_per> TYPE any,
                 <l_imp_pernr> TYPE any,
                 <ls_pernr>    TYPE ty_pernr.

  e_rc = 0.

  REFRESH: et_nper, lt_pernr, lt_ngpa.

  CHECK it_pernr[] IS NOT INITIAL.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF it_pernr[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_pernr.
    ASSIGN l_data->* TO <l_imp_pernr>.
    LOOP AT it_pernr INTO <l_imp_pernr>.
      sy-subrc = 4.
      IF i_fieldname_per IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_per OF STRUCTURE <l_imp_pernr>
            TO <l_field_per>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'PERNR' OF STRUCTURE <l_imp_pernr>
            TO <l_field_per>.
        IF sy-subrc <> 0.
          ASSIGN COMPONENT 'GPART' OF STRUCTURE <l_imp_pernr>
              TO <l_field_per>.
        ENDIF.
      ENDIF.
      CHECK sy-subrc = 0.
      ls_pernr-pernr = <l_field_per>.
      CHECK ls_pernr-pernr IS NOT INITIAL.
      APPEND ls_pernr TO lt_pernr.
    ENDLOOP.
  ENDIF.

  CHECK lt_pernr[] IS NOT INITIAL.

  CALL FUNCTION 'ISH_SAP_BP_CHECK_ACTIVE'
    IMPORTING
      e_status   = l_status
    EXCEPTIONS
      not_active = 0.

  IF l_status = on.

    LOOP AT lt_pernr INTO ls_pernr.
      ls_ngpa-gpart = ls_pernr-pernr.
      APPEND ls_ngpa TO lt_ngpa.
    ENDLOOP.

    CALL FUNCTION 'ISH_BP_API_PARTNER_GET'
      EXPORTING
        it_gpartner = lt_ngpa
        i_map_ind   = '2'
      IMPORTING
        et_partner  = lt_bpk
        et_rc       = lt_rc.
    IF lt_rc IS INITIAL.
      lt_ppk = lt_bpk.
      CALL FUNCTION 'ISH_PRS_API_GET_MULTI'
        EXPORTING
          it_prs_pk = lt_ppk
          i_read_db = i_read_db
        IMPORTING
          et_nper   = lt_nper
          et_rc     = lt_rc.
      IF lt_rc IS INITIAL.
        et_nper = lt_nper.
      ELSE.
        e_rc = 4.
      ENDIF.
    ELSE.
      e_rc = 4.
    ENDIF.

  ELSE.

    LOOP AT lt_pernr ASSIGNING <ls_pernr>.
      CLEAR: l_rc, ls_nper.
      CALL METHOD cl_ish_dbr_per=>get_per_by_pernr
        EXPORTING
          i_pernr         = <ls_pernr>-pernr
          i_read_db       = i_read_db
        IMPORTING
          es_nper         = ls_nper
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ELSE.
        APPEND ls_nper TO et_nper.
      ENDIF.
    ENDLOOP.

  ENDIF.

ENDMETHOD.


METHOD get_t_per_by_pernr_range.

  DATA: lt_nper           TYPE ish_t_nper,
        lv_read_db        TYPE ish_on_off,
        lv_status         TYPE ish_on_off,
        lt_ngpa_part_rng  TYPE ish_yt_gpartner,
        lt_bpk            TYPE ish_t_bup_pk,
        lt_ppk            TYPE ish_t_prs_pk,
        lt_rc             TYPE ish_bapiret2_tab_type.

  e_rc = 0.

  REFRESH: et_nper.

* CHECK it_pernr[] IS NOT INITIAL.  " DO NOT CHECK !!! = is allowed!

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* The direct select based on ranges on PERNR is redirected to
* GET_MULTI function module for table NPER
* if status of switch is on (SAP BP is active).
* Mapping of range of GPART to list of PARTNERs is done before
* calling GETMULTI function module.
  CLEAR: lt_ngpa_part_rng, lt_nper, lv_read_db, lv_status.

  lv_read_db = i_read_db.
  lt_ngpa_part_rng = it_pernr[].

  CALL FUNCTION 'ISH_SAP_BP_CHECK_ACTIVE'
    IMPORTING
      e_status   = lv_status
    EXCEPTIONS
      not_active = 0.

  IF lv_status EQ on.
    CALL FUNCTION 'ISH_BP_API_PARTNER_GET'
      EXPORTING
        it_gpartner_rng = lt_ngpa_part_rng
        i_map_ind       = '4'
      IMPORTING
        et_partner      = lt_bpk
        et_rc           = lt_rc.
    IF lt_rc IS INITIAL.
      lt_ppk = lt_bpk.
      CALL FUNCTION 'ISH_PRS_API_GET_MULTI'
        EXPORTING
          it_prs_pk       = lt_ppk
          i_read_db       = lv_read_db
        IMPORTING
          et_nper         = lt_nper
          et_rc           = lt_rc.
      IF lt_rc IS INITIAL.
        et_nper = lt_nper.
      ELSE.
        e_rc = 4.
      ENDIF.
    ELSE.
      e_rc = 4.
    ENDIF.
  ELSE.
    SELECT * FROM nper INTO TABLE et_nper
           WHERE  pernr IN it_pernr.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
    ENDIF.
  ENDIF.

ENDMETHOD.
ENDCLASS.
