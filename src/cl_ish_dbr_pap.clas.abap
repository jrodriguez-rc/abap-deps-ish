class CL_ISH_DBR_PAP definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_DBR_PAP
*"* do not include other source files here!!!
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

  class-methods GET_PAP_BY_PAPID
    importing
      value(I_PAPID) type ISH_PAPID
      value(I_READ_DB) type ISH_ON_OFF default OFF
    exporting
      value(ES_NPAP) type NPAP
      value(ES_NADR) type NADR
      value(ET_NADR2) type ISH_T_NADR2
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_PAP_BY_PAPID
    importing
      !IT_PAPID type STANDARD TABLE
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_FIELDNAME_PAP) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_NPAP) type ISHMED_T_NPAP
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_PAP_BY_PAPID_RANGE
    importing
      value(IT_PAPID) type ISH_T_R_PAPID optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
    exporting
      value(ET_NPAP) type ISHMED_T_NPAP
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DBR_PAT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DBR_PAP
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBR_PAP IMPLEMENTATION.


METHOD get_pap_by_papid.

  e_rc = 0.

  CLEAR: es_npap, es_nadr, et_nadr2[].

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF es_nadr IS REQUESTED OR et_nadr2 IS REQUESTED.
    CALL FUNCTION 'ISH_NPAP_READ'
      EXPORTING
        i_papid      = i_papid
        i_read_db    = i_read_db
        i_read_storn = on
      IMPORTING
        es_npap      = es_npap
        es_nadr      = es_nadr
        et_nadr2     = et_nadr2
      EXCEPTIONS
        not_found    = 1
        is_blocked   = 2               "DPP
        OTHERS       = 3.
  ELSE.
    CALL FUNCTION 'ISH_NPAP_READ'
      EXPORTING
        i_papid      = i_papid
        i_read_db    = i_read_db
        i_read_storn = on
      IMPORTING
        es_npap      = es_npap
      EXCEPTIONS
        not_found    = 1
        is_blocked   = 2               "DPP
        OTHERS       = 3.
  ENDIF.

  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    IF cr_errorhandler IS BOUND.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD get_t_pap_by_papid.

  TYPES: BEGIN OF ty_papid,
           papid               TYPE npap-papid,
         END OF ty_papid,
         tyt_papid             TYPE STANDARD TABLE OF ty_papid.

  DATA: lt_papid               TYPE tyt_papid,
        ls_papid               TYPE ty_papid,
        ls_npap                LIKE LINE OF et_npap,
        lt_npap                TYPE ish_t_npap,
*        lt_partner             TYPE ish_t_npat_pk,
*        ls_partner             LIKE LINE OF lt_partner,
        lt_part                TYPE ish_t_pnt_pk,
        ls_part                LIKE LINE OF lt_part,
        lt_rc                  TYPE ish_bapiret2_tab_type,
        ls_rc                  LIKE LINE OF lt_rc,
        l_status               TYPE ish_on_off,
        l_data                 TYPE REF TO data,
        l_rc                   TYPE ish_method_rc.

  FIELD-SYMBOLS: <l_field_pap> TYPE ANY,
                 <l_imp_papid> TYPE ANY,
                 <ls_papid>    TYPE ty_papid.

  e_rc = 0.

  REFRESH: et_npap, lt_papid, lt_part.

  CHECK it_papid[] IS NOT INITIAL.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF it_papid[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_papid.
    ASSIGN l_data->* TO <l_imp_papid>.
    LOOP AT it_papid INTO <l_imp_papid>.
      sy-subrc = 4.
      IF i_fieldname_pap IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_pap OF STRUCTURE <l_imp_papid>
            TO <l_field_pap>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'PAPID' OF STRUCTURE <l_imp_papid>
            TO <l_field_pap>.
      ENDIF.
      CHECK sy-subrc = 0.
      ls_papid-papid = <l_field_pap>.
      CHECK ls_papid-papid IS NOT INITIAL.
      APPEND ls_papid TO lt_papid.
    ENDLOOP.
  ENDIF.

  CHECK lt_papid[] IS NOT INITIAL.

  CALL FUNCTION 'ISH_SAP_BP_CHECK_ACTIVE'
    IMPORTING
      e_status = l_status
    EXCEPTIONS
      OTHERS   = 0.

  IF l_status = on.

    LOOP AT lt_papid ASSIGNING <ls_papid>.
*      CLEAR ls_partner.
*      ls_partner-patnr = <ls_papid>-papid.
*      APPEND ls_partner TO lt_partner.
      CLEAR ls_part.
      ls_part-partner = <ls_papid>-papid.
      APPEND ls_part TO lt_part.
    ENDLOOP.

*    CALL FUNCTION 'ISH_PNT_API_PARTNER_GET'
*      EXPORTING
*        it_old_partner = lt_partner
*        i_map_ind      = '2'
*      IMPORTING
*        et_partner     = lt_part
*        et_rc          = lt_rc.
*    IF lt_rc IS INITIAL.
    CALL FUNCTION 'ISH_PPT_API_GET_MULTI'
      EXPORTING
        it_ppt_pk = lt_part
        i_read_db = i_read_db
      IMPORTING
        et_npap   = lt_npap
        et_rc     = lt_rc.
    IF lt_rc IS INITIAL.
      et_npap = lt_npap.
    ELSE.
      e_rc = 4.
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
    ENDIF.
*    ELSE.
*      e_rc = 4.
*    ENDIF.

  ELSE.

    LOOP AT lt_papid ASSIGNING <ls_papid>.
      CLEAR: l_rc, ls_npap.
      CALL METHOD cl_ish_dbr_pap=>get_pap_by_papid
        EXPORTING
          i_papid         = <ls_papid>-papid
          i_read_db       = i_read_db
        IMPORTING
          es_npap         = ls_npap
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ELSE.
        APPEND ls_npap TO et_npap.
      ENDIF.
    ENDLOOP.

  ENDIF.

ENDMETHOD.


METHOD get_t_pap_by_papid_range.

  DATA: lv_status       TYPE ish_on_off.
**        lt_partner_rng  TYPE rnrangepatnr_tt,
*        lt_partner      TYPE ish_t_pnt_pk,
*        lt_npap         TYPE ish_t_npap,
*        lt_rc           TYPE ish_bapiret2_tab_type,
*        ls_rc           LIKE LINE OF lt_rc.

  e_rc = 0.

  REFRESH: et_npap.

  CLEAR: lv_status. "lt_partner, lt_npap, lt_rc.

*  CHECK it_papid[] IS NOT INITIAL.  " DO NOT CHECK -> is allowed!!!

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
**    lt_partner_rng[] = it_papid[].
**    CALL FUNCTION 'ISH_PNT_API_PARTNER_GET'
**      EXPORTING
**        it_old_partner_rng = lt_partner_rng
**        i_map_ind          = '1'
**      IMPORTING
**        et_partner         = lt_partner
**        et_rc              = lt_rc.
**    IF lt_rc IS INITIAL.
*      CALL FUNCTION 'ISH_PPT_API_GET_MULTI'
*        EXPORTING
*          it_ppt_pk = lt_partner
*          i_read_db = i_read_db
*        IMPORTING
*          et_npap   = lt_npap
*          et_rc     = lt_rc.
*      IF lt_rc IS INITIAL.
*        et_npap = lt_npap.
*      ELSE.
*        e_rc = 4.
*      IF cr_errorhandler IS BOUND.
*        LOOP AT lt_rc INTO ls_rc.
*          CALL METHOD cr_errorhandler->collect_messages
*            EXPORTING
*              i_typ  = ls_rc-type
*              i_kla  = ls_rc-id
*              i_num  = ls_rc-number
*              i_mv1  = ls_rc-message_v1
*              i_mv2  = ls_rc-message_v2
*              i_mv3  = ls_rc-message_v3
*              i_mv4  = ls_rc-message_v4
*              i_last = ' '.
*        ENDLOOP.
*      ENDIF.
*      ENDIF.
**    ELSE.
**      e_rc = 4.
**    ENDIF.
  ELSE.
    SELECT * FROM npap INTO TABLE et_npap
             WHERE papid IN it_papid.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
    ENDIF.
  ENDIF.

ENDMETHOD.
ENDCLASS.
