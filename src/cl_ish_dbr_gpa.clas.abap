class CL_ISH_DBR_GPA definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_DBR_GPA
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

  class-methods GET_GPA_BY_GPART
    importing
      value(I_GPART) type GPARTNER
      value(I_READ_DB) type ISH_ON_OFF default OFF
    exporting
      value(ES_NGPA) type NGPA
      value(ES_NADR) type NADR
      value(ET_NADR2) type ISH_T_NADR2
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_GPA_BY_GPART
    importing
      !IT_GPART type STANDARD TABLE
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_FIELDNAME_GPA) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_NGPA) type ISHMED_T_NGPA
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_GPA_BY_GPART_RANGE
    importing
      value(IT_GPART) type ISH_T_R_GPARTNER optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
    exporting
      value(ET_NGPA) type ISHMED_T_NGPA
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_GPA_BY_GPART_TRUNCATED
    importing
      value(I_GPART) type N1COTAVGPART
      value(I_READ_DB) type ISH_ON_OFF default OFF
    exporting
      value(ET_GPA_ID) type ISH_T_GPART
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods REFRESH_BUFFER .
protected section.
*"* protected components of class CL_ISH_DBR_GPA
*"* do not include other source files here!!!

  types:
    BEGIN OF ty_trunc_gpa,
      trunc  TYPE gpartner,
      t_gpart TYPE HASHED TABLE OF rnbup_gpart WITH UNIQUE KEY gpart,
    END OF ty_trunc_gpa .
  types:
    tyt_trunc_gpa  TYPE HASHED TABLE OF ty_trunc_gpa WITH UNIQUE KEY trunc .

  class-data GT_TRUNC_GPART type TYT_TRUNC_GPA .
private section.
*"* private components of class CL_ISH_DBR_GPA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBR_GPA IMPLEMENTATION.


METHOD get_gpa_by_gpart.

  DATA: l_buffer   TYPE ish_on_off.

  e_rc = 0.

  CLEAR: es_ngpa, es_nadr, et_nadr2[].

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF i_read_db = on.
    l_buffer = off.
  ELSE.
    l_buffer = on.
  ENDIF.

  IF es_nadr IS REQUESTED OR et_nadr2 IS REQUESTED.
    CALL FUNCTION 'ISH_READ_NGPA'
      EXPORTING
        gpart        = i_gpart
        ss_with_nadr = on
        ss_buffer    = l_buffer
      IMPORTING
        ngpa_e       = es_ngpa
        nadr_e       = es_nadr
      TABLES
        nadr_telnr   = et_nadr2
      EXCEPTIONS
        not_found    = 1
        no_authority = 2
        OTHERS       = 3.
  ELSE.
    CALL FUNCTION 'ISH_READ_NGPA'
      EXPORTING
        gpart        = i_gpart
        ss_with_nadr = off
        ss_buffer    = l_buffer
      IMPORTING
        ngpa_e       = es_ngpa
      EXCEPTIONS
        not_found    = 1
        no_authority = 2
        OTHERS       = 3.
  ENDIF.

  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    IF cr_errorhandler IS BOUND.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
* CDuerr, MED-74862 - begin
* UNDO the changes of MED-69975
**-->begin of MED-69975 AGujev
**the function module returns business partners even if they have deletion flag set - we need to check this!
*    ELSE.
*      IF es_ngpa-loekz = 'X'.
*        CLEAR es_ngpa.
*        e_rc = 3.
*      ENDIF.
*<--end of MED-69975 AGujev
  ENDIF.

ENDMETHOD.


METHOD get_t_gpa_by_gpart.

  DATA: lt_gpart               TYPE ish_t_gpart,
        ls_gpart               LIKE LINE OF lt_gpart,
        lt_ngpa                TYPE ish_yt_ngpa,
        ls_ngpa                LIKE LINE OF et_ngpa,
        l_data                 TYPE REF TO data,
        l_status               TYPE ish_on_off,
        l_rc                   TYPE ish_method_rc,
        lt_bpk                 TYPE ish_t_bup_pk,
        lt_rc                  TYPE ish_bapiret2_tab_type.

  FIELD-SYMBOLS: <l_field_gpa> TYPE any,
                 <l_imp_gpart> TYPE any,
                 <ls_gpart>    LIKE LINE OF lt_gpart.

  e_rc = 0.

  REFRESH: et_ngpa, lt_gpart, lt_ngpa.

  CHECK it_gpart[] IS NOT INITIAL.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF it_gpart[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_gpart.
    ASSIGN l_data->* TO <l_imp_gpart>.
    LOOP AT it_gpart INTO <l_imp_gpart>.
      sy-subrc = 4.
      IF i_fieldname_gpa IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_gpa OF STRUCTURE <l_imp_gpart>
            TO <l_field_gpa>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'GPART' OF STRUCTURE <l_imp_gpart>
            TO <l_field_gpa>.
        IF sy-subrc <> 0.
          ASSIGN COMPONENT 'PERNR' OF STRUCTURE <l_imp_gpart>
              TO <l_field_gpa>.
        ENDIF.
      ENDIF.
      CHECK sy-subrc = 0.
      ls_gpart-gpart = <l_field_gpa>.
      CHECK ls_gpart-gpart IS NOT INITIAL.
      APPEND ls_gpart TO lt_gpart.
    ENDLOOP.
  ENDIF.

  CHECK lt_gpart[] IS NOT INITIAL.

  CALL FUNCTION 'ISH_SAP_BP_CHECK_ACTIVE'
    IMPORTING
      e_status   = l_status
    EXCEPTIONS
      not_active = 0.

  IF l_status EQ on.

    CALL FUNCTION 'ISH_BP_API_PARTNER_GET'
      EXPORTING
        it_gpartner = lt_gpart
        i_map_ind   = '2'
      IMPORTING
        et_partner  = lt_bpk
        et_rc       = lt_rc.
    IF lt_rc IS INITIAL.
      CALL FUNCTION 'ISH_BUP_API_GET_MULTI'
        EXPORTING
          it_bup_pk = lt_bpk
          i_read_db = i_read_db
        IMPORTING
          et_ngpa   = lt_ngpa
          et_rc     = lt_rc.
      IF lt_rc IS INITIAL.
        et_ngpa = lt_ngpa.
      ELSE.
        e_rc = 4.
      ENDIF.
    ELSE.
      e_rc = 4.
    ENDIF.

  ELSE.

    LOOP AT lt_gpart ASSIGNING <ls_gpart>.
      CLEAR: l_rc, ls_ngpa.
      CALL METHOD cl_ish_dbr_gpa=>get_gpa_by_gpart
        EXPORTING
          i_gpart         = <ls_gpart>-gpart
          i_read_db       = i_read_db
        IMPORTING
          es_ngpa         = ls_ngpa
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ELSE.
        APPEND ls_ngpa TO et_ngpa.
      ENDIF.
    ENDLOOP.

  ENDIF.

ENDMETHOD.


METHOD get_t_gpa_by_gpart_range.

  DATA: lt_ngpa           TYPE ish_yt_ngpa,
        lv_read_db        TYPE ish_on_off,
        lv_status         TYPE ish_on_off,
        lt_ngpa_part_rng  TYPE ish_yt_gpartner,
        lt_bpk            TYPE ish_t_bup_pk,
        lt_rc             TYPE ish_bapiret2_tab_type.

  e_rc = 0.

  REFRESH: et_ngpa.

  CLEAR: lt_ngpa_part_rng, lt_ngpa, lv_read_db, lv_status.

* CHECK it_gpart[] IS NOT INITIAL.   " DO NOT CHECK !!! = is allowed!

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* The direct select based on ranges on GPART is redirected to
* GET_MULTI function module for table NBUP and BUT000
* if status of switch is on (SAP BP is active).
* Mapping of range of GPART to list of PARTNERs is done before
* calling GETMULTI function module.
  lv_read_db = i_read_db.
  lt_ngpa_part_rng[] = it_gpart[].

  CALL FUNCTION 'ISH_SAP_BP_CHECK_ACTIVE'
    IMPORTING
      e_status = lv_status
    EXCEPTIONS
      OTHERS   = 0.

  IF lv_status EQ on.
    CALL FUNCTION 'ISH_BP_API_PARTNER_GET'
      EXPORTING
        it_gpartner_rng = lt_ngpa_part_rng
        i_map_ind       = '4'
      IMPORTING
        et_partner      = lt_bpk
        et_rc           = lt_rc.
    IF lt_rc IS INITIAL.
      CALL FUNCTION 'ISH_BUP_API_GET_MULTI'
        EXPORTING
          it_bup_pk       = lt_bpk
          i_read_db       = lv_read_db
        IMPORTING
          et_ngpa         = lt_ngpa
          et_rc           = lt_rc.
      IF lt_rc IS INITIAL.
        et_ngpa = lt_ngpa.
      ELSE.
        e_rc = 4.
      ENDIF.
    ELSE.
      e_rc = 4.
    ENDIF.
  ELSE.
    SELECT * FROM ngpa INTO TABLE et_ngpa
             WHERE gpart IN it_gpart.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD get_t_gpa_by_gpart_truncated.
* NEW MED-34816
  DATA: lt_gpart          TYPE ISH_T_R_GPARTNER,
        ls_gpart          LIKE LINE OF lt_gpart,
        ls_trunc_gpart    LIKE LINE OF gt_trunc_gpart,
        lt_ngpa           TYPE ish_yt_ngpa,
        ls_gpart_gpart    like LINE OF ls_trunc_gpart-t_gpart.
  FIELD-SYMBOLS <ls_ngpa> like LINE OF lt_ngpa.
* ----- ---- ----
  CLEAR: e_rc, et_gpa_id.
* ----- ---- ----
  IF i_gpart IS INITIAL.
    RETURN.
  ENDIF.
* ----- ---- ----
  IF i_read_db = off.
    READ TABLE gt_trunc_gpart INTO ls_trunc_gpart
      WITH TABLE KEY trunc = i_gpart.
    IF sy-subrc = 0.
      et_gpa_id = ls_trunc_gpart-t_gpart.
      RETURN.
    ENDIF.
  ELSE.
    DELETE gt_trunc_gpart WHERE trunc = i_gpart.
  ENDIF.
* ----- ---- ----
  CLEAR ls_gpart.
  ls_gpart-sign   = 'I'.
  ls_gpart-option = 'CP'.
  ls_gpart-low    = i_gpart.
  APPEND ls_gpart TO lt_gpart.

  CALL METHOD cl_ish_dbr_gpa=>get_t_gpa_by_gpart_range
    EXPORTING
      it_gpart        = lt_gpart
      i_read_db       = i_read_db
    IMPORTING
      et_ngpa         = lt_ngpa
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF e_rc <> 0.
    RETURN.
  ENDIF.
* ----- ---- ----
  CLEAR ls_trunc_gpart.
  ls_trunc_gpart-trunc = i_gpart.
  LOOP AT lt_ngpa ASSIGNING <ls_ngpa>.
    ls_gpart_gpart-gpart = <ls_ngpa>-gpart.
    INSERT ls_gpart_gpart INTO TABLE ls_trunc_gpart-t_gpart.
  ENDLOOP.
  INSERT ls_trunc_gpart INTO TABLE gt_trunc_gpart.

* ----- ---- ----
  et_gpa_id = ls_trunc_gpart-t_gpart.
* ----- ---- ----
ENDMETHOD.


METHOD refresh_buffer.
* NEW MED-34816
  REFRESH gt_trunc_gpart.
ENDMETHOD.
ENDCLASS.
