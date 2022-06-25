class CL_ISH_DBR_PAT definition
  public
  abstract
  create public .

public section.

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

  class-methods GET_PAT_BY_PATNR
    importing
      value(I_PATNR) type PATNR
      value(I_EINRI) type EINRI default '*'
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_NO_BUFFER) type ISH_ON_OFF default OFF
      value(I_TC_AUTH) type ISH_ON_OFF default ON
      value(I_WITH_NADR) type ISH_ON_OFF default ON
    exporting
      value(ES_NPAT) type NPAT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_RISK_INF_BY_PATNR
    importing
      value(I_PATNR) type PATNR
      value(I_EINRI) type EINRI default '*'
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_NO_BUFFER) type ISH_ON_OFF default OFF
    exporting
      value(E_HAS_RISK_INF) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_PAT_DATA_BY_PATNR
    importing
      value(I_PATNR) type PATNR
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_NO_BUFFER) type ISH_ON_OFF default OFF
      value(I_WITH_NPAE) type ISH_ON_OFF default OFF
      value(I_WITH_NADR) type ISH_ON_OFF default OFF
      value(I_EINRI) type EINRI default '*'
      value(I_CHECK_AUTH) type ISH_ON_OFF default ON
      value(I_CHECK_VIP) type ISH_ON_OFF default OFF
      value(I_CHECK_INACTIVE) type ISH_ON_OFF default OFF
      value(I_NO_MESSAGES) type ISH_ON_OFF default OFF
    exporting
      value(ES_NPAT) type NPAT
      value(ES_NPAE) type NPAE
      value(ES_NADR) type NADR
      value(ES_NADR2) type NADR
      value(ES_NADR_ABG) type NADR
      value(ES_NADR_AN1) type NADR
      value(ES_NADR_AN2) type NADR
      value(ET_TELNR) type ISH_T_NADR2
      value(ET_TELNR2) type ISH_T_NADR2
      value(ET_TELNR_ABG) type ISH_T_NADR2
      value(ET_TELNR_AN1) type ISH_T_NADR2
      value(ET_TELNR_AN2) type ISH_T_NADR2
      value(E_NOT_FOUND_IN_EINRI) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_PAT_BY_PATNR
    importing
      !IT_PATNR type STANDARD TABLE
      value(I_EINRI) type EINRI default '*'
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_NO_BUFFER) type ISH_ON_OFF default OFF
      value(I_FIELDNAME_PAT) type ISH_FIELDNAME default SPACE
      value(I_TC_AUTH) type ISH_ON_OFF default ON
      value(I_WITH_NADR) type ISH_ON_OFF default ON
    exporting
      value(ET_NPAT) type ISHMED_T_NPAT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_PAT_BY_PATNR_RANGE
    importing
      value(IT_PATNR) type ISH_T_R_PATNR optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_NO_BUFFER) type ISH_ON_OFF default OFF
      value(I_SELECT_ALL) type ISH_ON_OFF default OFF
    exporting
      value(ET_NPAT) type ISHMED_T_NPAT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DBR_PAT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DBR_PAT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBR_PAT IMPLEMENTATION.


METHOD get_pat_by_patnr.

  DATA: l_patnr     TYPE patnr,
        l_tmp_patnr TYPE patnr,
        lt_rc       TYPE ish_bapiret2_tab_type,
        ls_rc       LIKE LINE OF lt_rc.
  DATA: ls_nadr     TYPE nadr.                  " MED-57776

  e_rc = 0.

  CLEAR es_npat.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CALL FUNCTION 'ISH_READ_NPAT'
    EXPORTING
      ss_patnr        = i_patnr
      ss_einri        = i_einri                 " MED-46065
      ss_read_db      = i_read_db
*      ss_with_nadr    = 'X'                     " MED-57776  REM MED-64045
      ss_with_nadr    = i_with_nadr             "MED-64045
      ss_no_buffering = i_no_buffer
      i_tc_auth       = i_tc_auth               " MED-46136
    IMPORTING
      ss_npat         = es_npat
      ss_nadr         = ls_nadr                 " MED-57776
      et_rc           = lt_rc
    EXCEPTIONS
      not_found       = 1
      no_authority    = 2
      no_einri        = 3
      OTHERS          = 4.
  e_rc = sy-subrc.
* <<< MED-57776  Note 2089433  Bi
  IF ls_nadr IS NOT INITIAL.
    cl_ish_cm_util=>street_hsnm_get(
      EXPORTING
        i_nadr   = ls_nadr    " IS-H: Adressen (zentrale Adreßverwaltung)
      IMPORTING
        e_street = es_npat-stras
    ).
  ENDIF.
* >>> MED-57776  Note 2089433  Bi
  IF cr_errorhandler IS BOUND.
    LOOP AT lt_rc INTO ls_rc.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ  = ls_rc-type
          i_kla  = ls_rc-id
          i_num  = ls_rc-number
          i_mv1  = ls_rc-message_v1
          i_mv2  = ls_rc-message_v2
          i_mv3  = ls_rc-message_v3
          i_mv4  = ls_rc-message_v4
          i_last = ' '.
    ENDLOOP.
  ENDIF.
  IF e_rc <> 0.
    IF cr_errorhandler IS BOUND.
      CLEAR: l_patnr, l_tmp_patnr.
      l_patnr = i_patnr.
      IF l_patnr CO ' 0123456789'.
        WRITE l_patnr TO l_tmp_patnr NO-ZERO.
      ELSE.                                                 " MED-32910
        l_tmp_patnr = l_patnr.                              " MED-32910
      ENDIF.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1'
          i_num  = '014'
          i_mv1  = l_tmp_patnr
          i_last = space.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD get_pat_data_by_patnr.

  DATA: l_patnr     TYPE patnr,
        l_tmp_patnr TYPE patnr,
        lt_rc       TYPE ish_bapiret2_tab_type,
        ls_rc       LIKE LINE OF lt_rc.

  e_rc = 0.

  CLEAR: es_npat, es_npae, es_nadr, es_nadr2,
         es_nadr_abg, es_nadr_an1, es_nadr_an2,
         e_not_found_in_einri.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CALL FUNCTION 'ISH_READ_NPAT'
    EXPORTING
      ss_einri              = i_einri
      ss_patnr              = i_patnr
      ss_read_db            = i_read_db
      ss_with_npae          = i_with_npae
*      ss_with_nadr          = i_with_nadr
      ss_with_nadr          = 'X'                 " MED-57776
      ss_check_auth         = i_check_auth
      ss_check_vip          = i_check_vip
      ss_check_inactive     = i_check_inactive
      ss_no_messages        = i_no_messages
      ss_no_buffering       = i_no_buffer
      i_tc_excep            = 'X'     "++MED-64465   AGujev - consider also treatment contract errors
    IMPORTING
      ss_not_found_in_einri = e_not_found_in_einri
      ss_npae               = es_npae
      ss_npat               = es_npat
      ss_nadr               = es_nadr
      ss_nadr2              = es_nadr2
      ss_nadr_abg           = es_nadr_abg
      ss_nadr_an1           = es_nadr_an1
      ss_nadr_an2           = es_nadr_an2
      et_rc                 = lt_rc
    TABLES
      ss_telnr              = et_telnr
      ss_telnr2             = et_telnr2
      ss_telnr_abg          = et_telnr_abg
      ss_telnr_an1          = et_telnr_an1
      ss_telnr_an2          = et_telnr_an2
    EXCEPTIONS
      not_found             = 1
      no_authority          = 2
      no_einri              = 3
      no_treatment_contract = 4    "++MED-64465 AGujev
*      OTHERS                = 4.   "--MED-64465 AGujev
      OTHERS                = 5.   "++MED-64465 AGujev
*MED-64465 AGujev - no treatment contract error was not considered!
  e_rc = sy-subrc.
* <<< MED-57776  Note 2089433  Bi
  IF es_nadr IS NOT INITIAL.
    cl_ish_cm_util=>street_hsnm_get(
      EXPORTING
        i_nadr   = es_nadr    " IS-H: Adressen (zentrale Adreßverwaltung)
      IMPORTING
        e_street = es_npat-stras
    ).
  ENDIF.
* >>> MED-57776  Note 2089433  Bi
  IF cr_errorhandler IS BOUND.
    LOOP AT lt_rc INTO ls_rc.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ  = ls_rc-type
          i_kla  = ls_rc-id
          i_num  = ls_rc-number
          i_mv1  = ls_rc-message_v1
          i_mv2  = ls_rc-message_v2
          i_mv3  = ls_rc-message_v3
          i_mv4  = ls_rc-message_v4
          i_last = ' '.
    ENDLOOP.
  ENDIF.
  IF e_rc <> 0.
    IF cr_errorhandler IS BOUND.
      CLEAR: l_patnr, l_tmp_patnr.
      l_patnr = i_patnr.
      IF l_patnr CO ' 0123456789'.
        WRITE l_patnr TO l_tmp_patnr NO-ZERO.
      ELSE.                                                 " MED-32910
        l_tmp_patnr = l_patnr.                              " MED-32910
      ENDIF.
      CASE sy-subrc.
        WHEN 2.
          CALL METHOD cr_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'N1'
              i_num  = '610'
              i_mv1  = l_tmp_patnr
              i_mv2  = space
              i_mv3  = i_einri
              i_last = space.
        WHEN 3.
          CALL METHOD cr_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'N1'
              i_num  = '117'
              i_mv1  = i_einri
              i_last = space.
*-->begin of MED-64465 AGujev
*give the right message when there is no treatment contract
        WHEN 4.
          CALL METHOD cr_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'N1TC'
              i_num  = '010'
              i_mv1  = sy-msgv1
              i_mv2  = l_tmp_patnr
              i_last = space.
*<--end of MED-64465 AGujev
        WHEN OTHERS.
          CALL METHOD cr_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'N1'
              i_num  = '014'
              i_mv1  = l_tmp_patnr
              i_last = space.
      ENDCASE.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD get_risk_inf_by_patnr.

  DATA: l_patnr       TYPE patnr,
        l_tmp_patnr   TYPE patnr,
        ls_npat       TYPE npat,
        lt_rc         TYPE ish_bapiret2_tab_type,
        ls_rc         LIKE LINE OF lt_rc.
* ------ ----- ------
  CLEAR: e_has_risk_inf, e_rc.
* ------ ----- ------

  CALL FUNCTION 'ISH_READ_NPAT'
    EXPORTING
      ss_patnr        = i_patnr
      ss_einri        = i_einri                 " MED-46065
      ss_read_db      = i_read_db
      ss_no_buffering = i_no_buffer
      ss_check_auth   = abap_false
    IMPORTING
      ss_npat         = ls_npat
      et_rc           = lt_rc
    EXCEPTIONS
      not_found       = 1
      no_authority    = 2
      no_einri        = 3
      OTHERS          = 4.
  e_rc = sy-subrc.

  IF e_rc <> 0.
    LOOP AT lt_rc INTO ls_rc.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = ls_rc-type
          i_kla           = ls_rc-id
          i_num           = ls_rc-number
          i_mv1           = ls_rc-message_v1
          i_mv2           = ls_rc-message_v2
          i_mv3           = ls_rc-message_v3
          i_mv4           = ls_rc-message_v4
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDLOOP.

    CLEAR: l_patnr, l_tmp_patnr.
    l_patnr = i_patnr.
    IF l_patnr CO ' 0123456789'.
      WRITE l_patnr TO l_tmp_patnr NO-ZERO.
    ELSE.
      l_tmp_patnr = l_patnr.
    ENDIF.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1'
        i_num           = '014'
        i_mv1           = l_tmp_patnr
      CHANGING
        cr_errorhandler = cr_errorhandler.
    RETURN.
  ENDIF.
* ------ ----- ------
  IF ls_npat-riskf IS NOT INITIAL.
    e_has_risk_inf = abap_true.
  ENDIF.
* ------ ----- ------
ENDMETHOD.


METHOD get_t_pat_by_patnr.

  TYPES: BEGIN OF ty_patnr,
           patnr               TYPE npat-patnr,
         END OF ty_patnr,
         tyt_patnr             TYPE STANDARD TABLE OF ty_patnr.

  DATA: lt_patnr               TYPE tyt_patnr,
        ls_patnr               TYPE ty_patnr,
        ls_npat                LIKE LINE OF et_npat,
        l_data                 TYPE REF TO data,
        l_rc                   TYPE ish_method_rc.

  FIELD-SYMBOLS: <l_field_pat> TYPE any,
                 <l_imp_patnr> TYPE any,
                 <ls_patnr>    TYPE ty_patnr.

  e_rc = 0.

  REFRESH: et_npat, lt_patnr.

  CHECK it_patnr[] IS NOT INITIAL.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF it_patnr[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_patnr.
    ASSIGN l_data->* TO <l_imp_patnr>.
    LOOP AT it_patnr INTO <l_imp_patnr>.
      sy-subrc = 4.
      IF i_fieldname_pat IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_pat OF STRUCTURE <l_imp_patnr>
            TO <l_field_pat>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'PATNR' OF STRUCTURE <l_imp_patnr>
            TO <l_field_pat>.
      ENDIF.
      CHECK sy-subrc = 0.
      ls_patnr-patnr = <l_field_pat>.
      CHECK ls_patnr-patnr IS NOT INITIAL.
      APPEND ls_patnr TO lt_patnr.
    ENDLOOP.
  ENDIF.

  CHECK lt_patnr[] IS NOT INITIAL.

  LOOP AT lt_patnr ASSIGNING <ls_patnr>.
    CLEAR: l_rc, ls_npat.
    CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
      EXPORTING
        i_patnr         = <ls_patnr>-patnr
        i_einri         = i_einri                 " MED-46065
        i_read_db       = i_read_db
        i_no_buffer     = i_no_buffer
        i_tc_auth       = i_tc_auth               " MED-46136
        i_with_nadr     = i_with_nadr             "MED-64045
      IMPORTING
        es_npat         = ls_npat
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ELSE.
      APPEND ls_npat TO et_npat.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD get_t_pat_by_patnr_range.

  DATA: lv_status       TYPE ish_on_off,
        lt_partner_rng  TYPE rnrangepatnr_tt,
        lt_partner      TYPE ish_t_pnt_pk,
        lt_npat         TYPE ish_t_npat,
        lt_rc           TYPE ish_bapiret2_tab_type,
        ls_rc           LIKE LINE OF lt_rc,
        l_max_msg       TYPE ish_bapiretmaxty,
        l_range_sel     TYPE ish_on_off.                  "AOPATREC-13

  field-symbols: <ls_patnr_rg> like line of it_patnr.     "AOPATREC-13

  e_rc = 0.

  REFRESH: et_npat.

  CLEAR: lt_partner_rng, lt_partner, lt_npat, lt_rc, lv_status.

*  CHECK it_patnr[] IS NOT INITIAL.  " DO NOT CHECK -> is allowed!!!

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CALL FUNCTION 'ISH_SAP_BP_CHECK_ACTIVE'
    IMPORTING
      e_status = lv_status
    EXCEPTIONS
      OTHERS   = 0.

  IF lv_status EQ on.
    lt_partner_rng[] = it_patnr[].
    CALL FUNCTION 'ISH_PNT_API_PARTNER_GET'
      EXPORTING
        it_old_partner_rng = lt_partner_rng
*MED-62709 AGujev - setting the right parameter below for function ISH_PNT_DB_MAP_PARTNER which will retrieve BP data
*        i_map_ind          = '1'        "--MED-62709 AGujev
        i_map_ind          = '3'        "++MED-62709 AGujev
      IMPORTING
        et_partner         = lt_partner
*       e_status           = l_status
        et_rc              = lt_rc.
    CLEAR l_max_msg.
    IF lt_rc IS NOT INITIAL.
      IF cr_errorhandler IS BOUND.
        LOOP AT lt_rc INTO ls_rc.
          CALL METHOD cr_errorhandler->collect_messages
            EXPORTING
              i_typ  = ls_rc-type
              i_kla  = ls_rc-id
              i_num  = ls_rc-number
              i_mv1  = ls_rc-message_v1
              i_mv2  = ls_rc-message_v2
              i_mv3  = ls_rc-message_v3
              i_mv4  = ls_rc-message_v4
              i_last = ' '.
        ENDLOOP.
      ENDIF.
      CALL FUNCTION 'ISH_BAPI_MSGTY_MAX_SEVERITY'
        IMPORTING
          ss_msgty   = l_max_msg
        TABLES
          ss_message = lt_rc.
    ENDIF.
    IF l_max_msg CA 'EAX'.
      e_rc = 4.
    ELSE.
      CALL FUNCTION 'ISH_PNT_API_GET_MULTI'
        EXPORTING
          it_pnt_pk = lt_partner
          i_read_db = i_read_db
        IMPORTING
          et_npat   = lt_npat
          et_rc     = lt_rc.
      CLEAR l_max_msg.
      IF lt_rc IS NOT INITIAL.
        IF cr_errorhandler IS BOUND.
          LOOP AT lt_rc INTO ls_rc.
            CALL METHOD cr_errorhandler->collect_messages
              EXPORTING
                i_typ  = ls_rc-type
                i_kla  = ls_rc-id
                i_num  = ls_rc-number
                i_mv1  = ls_rc-message_v1
                i_mv2  = ls_rc-message_v2
                i_mv3  = ls_rc-message_v3
                i_mv4  = ls_rc-message_v4
                i_last = ' '.
          ENDLOOP.
        ENDIF.
        CALL FUNCTION 'ISH_BAPI_MSGTY_MAX_SEVERITY'
          IMPORTING
            ss_msgty   = l_max_msg
          TABLES
            ss_message = lt_rc.
      ENDIF.
      IF l_max_msg CA 'EAX'.
        e_rc = 4.
      ELSE.
        et_npat = lt_npat.
      ENDIF.
    ENDIF.
  ELSE.
*-->begin of MED-48388 AGujev
*old code commented below
*in case it_patnr is too big, the following select was crashing!
*    SELECT * FROM npat INTO TABLE et_npat
*             WHERE patnr IN it_patnr.
    if i_select_all = on.
*     AOPATREG-13: select all entries, needed in ISHMED_PATREG_REST_DATA_PREP
      select * from npat into table et_npat. "#EC CI_NOWHERE
    else.
      loop at it_patnr assigning <ls_patnr_rg>.       "AOPATREC-13 beg
        if <ls_patnr_rg>-low ca '*+' or
           not <ls_patnr_rg>-high is initial.
          l_range_sel = on.
          exit.
        endif.
      endloop.                                        "AOPATREC-13 end
      IF it_patnr IS NOT INITIAL.
        if l_range_sel = off.
          SELECT * FROM npat INTO TABLE et_npat FOR ALL ENTRIES IN it_patnr
                WHERE patnr = it_patnr-low.
        else.
*         AOPATREC-13: in some cases it is wrong only to compare with
*                      it_patnr-low! -> Select with complete range
          select * from npat into table et_npat
            where patnr in it_patnr.
        endif.
      ENDIF.
*<--end of MED-48388 AGujev
    endif.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
    ENDIF.
  ENDIF.

ENDMETHOD.
ENDCLASS.
