class CL_ISH_DBR_ORG definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_DBR_ORG
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

  class-data GT_BUF_EINRI_ORG type ISHMED_T_NORG_HASH .

  class-methods GET_ORG_BY_ORGID
    importing
      value(I_ORGID) type ORGID
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_EINRI) type EINRI default SPACE
    exporting
      value(ES_NORG) type NORG
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_ORG_ALL
    importing
      value(I_EINRI) type EINRI
    exporting
      value(ET_NORG) type ISHMED_T_NORG
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_ORG_BY_INST
    importing
      value(I_EINRI) type EINRI
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_ORGID) type ORGID
    exporting
      value(ET_NORG) type ISHMED_T_NORG
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_ORG_BY_ORGID
    importing
      !IT_ORGID type STANDARD TABLE
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_EINRI) type EINRI default SPACE
      value(I_FIELDNAME_ORG) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_NORG) type ISHMED_T_NORG
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_ORG_BY_ORGID_RANGE
    importing
      value(IT_ORGID) type ISH_T_R_ORGUNIT optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_EINRI) type EINRI default SPACE
    exporting
      value(ET_NORG) type ISHMED_T_NORG
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_ORG_BY_ORGID_TRUNCATED
    importing
      value(I_ORGID) type ORGID
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_EINRI) type EINRI default SPACE
    exporting
      value(ET_ORGID) type ISH_T_ORGID
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods REFRESH_BUFFER .
protected section.

  types:
*"* protected components of class CL_ISH_DBR_ORG
*"* do not include other source files here!!!
    BEGIN OF  TY_TRUNC_ORG ,
      trunc   TYPE ORGID,
      t_orgid TYPE HASHED TABLE OF RN1ORGID WITH UNIQUE KEY orgid,
    END OF TY_TRUNC_ORG .
  types:
    tyt_TRUNC_ORG  TYPE HASHED TABLE OF ty_TRUNC_ORG WITH UNIQUE KEY trunc .

  class-data GT_TRUNC_ORGID type TYT_TRUNC_ORG .
  class-data GT_BUF_ORG_PARTIAL type ISHMED_T_NORG_HASH .
private section.
*"* private components of class CL_ISH_DBR_ORG
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBR_ORG IMPLEMENTATION.


METHOD get_org_by_orgid.

  e_rc = 0.

  CLEAR: es_norg.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CALL FUNCTION 'ISH_READ_NORG'
    EXPORTING
      einri         = i_einri
      orgid         = i_orgid
    IMPORTING
      norg_e        = es_norg
    EXCEPTIONS
      missing_orgid = 1
      OTHERS        = 2.

  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    IF cr_errorhandler IS BOUND.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD get_t_org_all.

  DATA: l_status          TYPE ish_on_off.
  DATA: lt_result_objec   TYPE ishmed_t_swhactor.
  DATA: lt_object_ou      TYPE hrobject_t.
  DATA: l_plvar           TYPE objec-plvar.
  DATA: lt_infotypes      TYPE rninfty_ou.
  DATA: l_reqinfotypes    TYPE rnreqinfty_ou.
  DATA: l_object          TYPE hrobject.

  FIELD-SYMBOLS: <l_result_objec> TYPE swhactor.

  e_rc = 0.

  REFRESH: et_norg.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Check SAP OM Switch
  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status = l_status
    EXCEPTIONS
      OTHERS   = 0.

  IF l_status = on.

*   get the hierarchy under the given institution
    CALL FUNCTION 'ISH_OM_HRCHY_FILTER'
      EXPORTING
        i_instn                = i_einri
        i_interdep             = on
        i_bu_read              = off
        i_rel_flg              = on
        i_del_flg              = on
        i_starting_date        = sy-datum
        i_ending_date          = sy-datum
        i_instn_flg            = on
      IMPORTING
*       et_result_struc        = lt_struc_filtered
        et_result_tab          = lt_result_objec
*       et_not_released_object = lt_not_released
      EXCEPTIONS
        nothing_found          = 1
        not_valid              = 1
        OTHERS                 = 2.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
      IF cr_errorhandler IS BOUND.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
          CHANGING
            cr_errorhandler = cr_errorhandler.
        EXIT.
      ENDIF.
    ENDIF.

*   find the acitve plan variant
    CALL FUNCTION 'ISH_OM_PLVAR_GET'
      IMPORTING
        e_plvar = l_plvar.

*   first split orgunits from building units
    LOOP AT lt_result_objec ASSIGNING <l_result_objec>.
      CHECK <l_result_objec>-otype = 'O'.
      MOVE-CORRESPONDING <l_result_objec> TO l_object.
      l_object-plvar = l_plvar.
      APPEND l_object TO lt_object_ou.
    ENDLOOP.

*   check if there are organizational units
    IF lt_object_ou IS NOT INITIAL.

      l_reqinfotypes-inf1000 = on.
      l_reqinfotypes-inf1002 = on.
      l_reqinfotypes-inf1027 = on.
      l_reqinfotypes-inf1028 = on.
      l_reqinfotypes-inf6080 = on.
      l_reqinfotypes-inf6081 = on.
      l_reqinfotypes-inf6082 = on.
      l_reqinfotypes-inf6085 = on.

      CALL FUNCTION 'ISH_OM_INFTY_OU_GET'
        EXPORTING
          it_objects     = lt_object_ou
          i_req_infty    = l_reqinfotypes
          i_f4_mode      = on
        IMPORTING
          e_infty_ou     = lt_infotypes
        EXCEPTIONS
          internal_error = 1
          OTHERS         = 2.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        IF cr_errorhandler IS BOUND.
          CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
            CHANGING
              cr_errorhandler = cr_errorhandler.
          EXIT.
        ENDIF.
      ENDIF.

      CALL FUNCTION 'ISH_OM_NORG_FILL'
        EXPORTING
          i_infty_ou = lt_infotypes
          i_instn    = i_einri
        IMPORTING
          et_norg    = et_norg.

    ENDIF.

  ELSE.

    SELECT * FROM norg INTO TABLE et_norg             "#EC CI_SGLSELECT
                       WHERE loekz <> on
                         AND einri  = i_einri.

  ENDIF.

  SORT et_norg BY orgid.

ENDMETHOD.


METHOD get_t_org_by_inst.

*  DATA: l_rc TYPE ish_method_rc.
  DATA: lt_norg TYPE ishmed_t_norg,
        ls_buf_einri_org TYPE rn1_buf_einri_org,
        lt_orgid TYPE ish_t_r_orgunit,
        ls_orgid TYPE rn1_r_orgunit.

*-- refresh
  CLEAR: ls_buf_einri_org.
  REFRESH: lt_norg, et_norg.

*-- read from buffer
  IF i_read_db EQ on.
    DELETE TABLE gt_buf_einri_org WITH TABLE KEY einri = i_einri.

    IF NOT i_orgid IS INITIAL.
      ls_orgid-sign = 'I'.
      ls_orgid-option = 'CP'.
      ls_orgid-low  = i_orgid.
      INSERT ls_orgid INTO TABLE lt_orgid.
    ENDIF.

    CALL METHOD cl_ish_dbr_org=>get_t_org_by_orgid_range
      EXPORTING
        it_orgid        = lt_orgid
        i_read_db       = on
        i_einri         = i_einri
      IMPORTING
        et_norg         = lt_norg
*       e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    et_norg[] = lt_norg[].
    ls_buf_einri_org-t_norg = lt_norg.
    ls_buf_einri_org-einri = i_einri. "MED-49098 Oana B, 05.11.2012
    INSERT ls_buf_einri_org INTO TABLE gt_buf_einri_org.
  ELSE.
    READ TABLE gt_buf_einri_org WITH TABLE KEY einri = i_einri INTO ls_buf_einri_org.
    IF sy-subrc NE 0.
      CALL METHOD cl_ish_dbr_org=>get_t_org_by_orgid_range
        EXPORTING
          i_einri         = i_einri
        IMPORTING
          et_norg         = lt_norg
*         e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      et_norg[] = lt_norg[].
      ls_buf_einri_org-t_norg = lt_norg.
      ls_buf_einri_org-einri = i_einri. "MED-49098 Oana B, 05.11.2012
      INSERT ls_buf_einri_org INTO TABLE gt_buf_einri_org.
*BEGIN MED-49098, Oana B 05.11.2012
    ELSE.
      et_norg[] = ls_buf_einri_org-t_norg.
*END MED-49098, Oana B 05.11.2012
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD get_t_org_by_orgid.

  TYPES: BEGIN OF ty_orgid,
           orgid               TYPE norg-orgid,
         END OF ty_orgid,
         tyt_orgid             TYPE STANDARD TABLE OF ty_orgid.

  DATA: lt_orgid               TYPE tyt_orgid,
        ls_orgid               TYPE ty_orgid,
        ls_norg                LIKE LINE OF et_norg,
        l_data                 TYPE REF TO data,
        l_status               TYPE ish_on_off,
        l_rc                   TYPE ish_method_rc.

  FIELD-SYMBOLS: <l_field_org> TYPE any,
                 <l_imp_orgid> TYPE any,
                 <ls_orgid>    TYPE ty_orgid.

*-->begin of MED-57755 AGujev
   DATA  ls_buf_org_partial TYPE rn1_buf_einri_org.
   DATA l_is_buffer_used TYPE ish_on_off.
   IF i_read_db EQ on.
     DELETE TABLE gt_buf_org_partial WITH TABLE KEY einri = i_einri.
   ENDIF.
*<--end of MED-57755 AGujev

  e_rc = 0.

  REFRESH: et_norg, lt_orgid.

  CHECK it_orgid[] IS NOT INITIAL.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF it_orgid[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_orgid.
    ASSIGN l_data->* TO <l_imp_orgid>.
    LOOP AT it_orgid INTO <l_imp_orgid>.
      sy-subrc = 4.
      IF i_fieldname_org IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_org OF STRUCTURE <l_imp_orgid>
            TO <l_field_org>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'ORGID' OF STRUCTURE <l_imp_orgid>
            TO <l_field_org>.
        IF sy-subrc <> 0.
          ASSIGN COMPONENT 'ORGPF' OF STRUCTURE <l_imp_orgid>
              TO <l_field_org>.
          IF sy-subrc <> 0.
            ASSIGN COMPONENT 'ORGFA' OF STRUCTURE <l_imp_orgid>
                TO <l_field_org>.
            IF sy-subrc <> 0.
              ASSIGN COMPONENT 'ERBOE' OF STRUCTURE <l_imp_orgid>
                  TO <l_field_org>.
              IF sy-subrc <> 0.
                ASSIGN COMPONENT 'ETROE' OF STRUCTURE <l_imp_orgid>
                    TO <l_field_org>.
                IF sy-subrc <> 0.
                  ASSIGN COMPONENT 'TRTOE' OF STRUCTURE <l_imp_orgid>
                      TO <l_field_org>.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
      CHECK sy-subrc = 0.
      ls_orgid-orgid = <l_field_org>.
      CHECK ls_orgid-orgid IS NOT INITIAL.
      APPEND ls_orgid TO lt_orgid.
    ENDLOOP.
  ENDIF.

  CHECK lt_orgid[] IS NOT INITIAL.

* Check SAP OM Switch
  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status = l_status
    EXCEPTIONS
      OTHERS   = 0.

  IF l_status = on.

*-->begin of MED-57755 AGujev
*for BPOM active we need to try and use the buffer
    IF i_read_db EQ on.   "buffer is disabled explicitly by the caller
*<--end of MED-57755 AGujev
    CALL FUNCTION 'ISH_OM_OU_GET'
      EXPORTING
        i_instn        = i_einri
        it_orgid       = lt_orgid
        i_read_db      = i_read_db
      IMPORTING
        et_norg        = et_norg
      EXCEPTIONS
        nothing_found  = 1
        internal_error = 2
        OTHERS         = 3.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
      IF cr_errorhandler IS BOUND.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
*-->begin of MED-57755 AGujev
     ELSE.
    "buffer the read data maybe it will be used later
    ls_buf_org_partial-t_norg = et_norg.
    SORT ls_buf_org_partial-t_norg BY orgid.
    ls_buf_org_partial-einri = i_einri.
    INSERT ls_buf_org_partial INTO TABLE gt_buf_org_partial.
*<--end of MED-57755 AGujev
    ENDIF.
*-->begin of MED-57755 AGujev
    ELSE.  "use buffer first!
       READ TABLE gt_buf_org_partial WITH TABLE KEY einri = i_einri INTO ls_buf_org_partial.
       IF sy-subrc EQ 0.
           l_is_buffer_used = on. "we need to know we used the buffer
           "we have to check if all information requested is buffered!
           LOOP AT lt_orgid ASSIGNING <ls_orgid>.
             READ TABLE ls_buf_org_partial-t_norg TRANSPORTING NO FIELDS WITH KEY orgid = <ls_orgid>-orgid BINARY SEARCH.
             IF sy-subrc = 0.
               DELETE lt_orgid.
             ENDIF.
           ENDLOOP.
           ELSE. "no buffer found - we have to read data again! - nothing to do here
       ENDIF.
    IF lt_orgid IS NOT INITIAL.    "still some information needed which was not in the buffer
    CALL FUNCTION 'ISH_OM_OU_GET'
      EXPORTING
        i_instn        = i_einri
        it_orgid       = lt_orgid
        i_read_db      = i_read_db
      IMPORTING
        et_norg        = et_norg
      EXCEPTIONS
        nothing_found  = 1
        internal_error = 2
        OTHERS         = 3.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
      IF cr_errorhandler IS BOUND.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
    ENDIF.
    ENDIF.
       "if everything was ok update the buffer and return values
    IF e_rc = 0.
       IF l_is_buffer_used = on.
      "we need to combine buffer data with read data and update buffer!
         IF lt_orgid IS INITIAL. "only buffer was used - easy!
           et_norg = ls_buf_org_partial-t_norg.
           ELSE.  "we need to combine both read and buffer data and update buffer!
           APPEND LINES OF et_norg TO ls_buf_org_partial-t_norg.
           REFRESH et_norg.
           et_norg = ls_buf_org_partial-t_norg.
           SORT ls_buf_org_partial-t_norg BY orgid.
           DELETE TABLE gt_buf_org_partial WITH TABLE KEY einri = i_einri.
           INSERT ls_buf_org_partial INTO TABLE gt_buf_org_partial.
         ENDIF.
         ELSE.  "buffer was not used - fill data into buffer
              ls_buf_org_partial-t_norg = et_norg.
              SORT ls_buf_org_partial-t_norg BY orgid.
              ls_buf_org_partial-einri = i_einri.
              INSERT ls_buf_org_partial INTO TABLE gt_buf_org_partial.
       ENDIF.
     ENDIF.
    ENDIF.
*<--end of MED-57755 AGujev
  ELSE.

    LOOP AT lt_orgid ASSIGNING <ls_orgid>.
      CLEAR: l_rc, ls_norg.
      CALL METHOD cl_ish_dbr_org=>get_org_by_orgid
        EXPORTING
          i_orgid         = <ls_orgid>-orgid
          i_read_db       = i_read_db
          i_einri         = i_einri
        IMPORTING
          es_norg         = ls_norg
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ELSE.
        APPEND ls_norg TO et_norg.
      ENDIF.
    ENDLOOP.

  ENDIF.

ENDMETHOD.


METHOD get_t_org_by_orgid_range.

  DATA: l_rc        TYPE sy-subrc,
        lt_norg     TYPE ishmed_t_norg,
        ltr_orgid   TYPE ishmed_t_rangeishid,
        l_status    TYPE ish_on_off.

  e_rc = 0.

  REFRESH: et_norg.

*  CHECK it_orgid[] IS NOT INITIAL.  " DO NOT CHECK !!! = is allowed!

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Check SAP OM Switch
  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status = l_status
    EXCEPTIONS
      OTHERS   = 0.

  IF l_status EQ off.
    IF i_einri IS INITIAL.
      SELECT * FROM norg INTO TABLE et_norg                 "#EC *
             WHERE orgid IN it_orgid.
      l_rc = sy-subrc.
    ELSE.
      SELECT * FROM norg INTO TABLE et_norg                 "#EC *
               WHERE orgid IN it_orgid
                 AND einri  = i_einri.
      l_rc = sy-subrc.
    ENDIF.
  ELSE.
    ltr_orgid[] = it_orgid[].
    IF i_einri IS INITIAL.
      CALL FUNCTION 'ISH_OM_OU_GET'
        EXPORTING
          itr_orgid      = ltr_orgid
          i_read_db_no_buffer = on               " note 2047585
        IMPORTING
          et_norg        = lt_norg
        EXCEPTIONS
          nothing_found  = 1
          internal_error = 2
          OTHERS         = 3.
    ELSE.
      CALL FUNCTION 'ISH_OM_OU_GET'
        EXPORTING
          itr_orgid      = ltr_orgid
          i_instn        = i_einri
          i_read_db_no_buffer = on               " note 2047585
        IMPORTING
          et_norg        = lt_norg
        EXCEPTIONS
          nothing_found  = 1
          internal_error = 2
          OTHERS         = 3.
    ENDIF.
    IF sy-subrc <> 0.
      l_rc = sy-subrc.
      IF cr_errorhandler IS BOUND.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
    ELSE.
      et_norg[] = lt_norg[].
    ENDIF.
  ENDIF.
  IF l_rc <> 0.
    e_rc = sy-subrc.
  ENDIF.

ENDMETHOD.


METHOD get_t_org_by_orgid_truncated.
*NEU MED-34816
  DATA ls_trunc_orgid    LIKE LINE OF gt_trunc_orgid.
  DATA lt_norg           TYPE ishmed_t_norg.
  DATA ltr_orgid         TYPE ish_t_r_orgunit.
  DATA lsr_orgid         LIKE LINE OF ltr_orgid.
  DATA ls_orgid          LIKE LINE OF ls_trunc_orgid-t_orgid.
  FIELD-SYMBOLS <ls_norg> LIKE LINE OF lt_norg.

  CLEAR: e_rc, et_orgid.

  IF i_orgid IS INITIAL.
    RETURN.
  ENDIF.

  IF i_read_db = off.
    READ TABLE gt_trunc_orgid INTO ls_trunc_orgid
     WITH TABLE KEY trunc = i_orgid.
    IF sy-subrc = 0.
      et_orgid = ls_trunc_orgid-t_orgid.
      RETURN.
    ENDIF.
  ELSE.
    DELETE gt_trunc_orgid WHERE trunc = i_orgid.
  ENDIF.

  CLEAR: lsr_orgid, ltr_orgid.
  lsr_orgid-sign   = 'I'.
  lsr_orgid-option = 'CP'.
  lsr_orgid-low    = i_orgid.
  APPEND lsr_orgid TO ltr_orgid.

  CALL METHOD cl_ish_dbr_org=>get_t_org_by_orgid_range
    EXPORTING
      it_orgid        = ltr_orgid
      i_read_db       = i_read_db
      i_einri         = i_einri
    IMPORTING
      et_norg         = lt_norg
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF e_rc <> 0.
    RETURN.
  ENDIF.

* ----- ---- ----
  CLEAR ls_trunc_orgid.
  ls_trunc_orgid-trunc = i_orgid.
  LOOP AT lt_norg ASSIGNING <ls_norg>.
    ls_orgid-orgid = <ls_norg>-orgid.
    INSERT ls_orgid INTO TABLE ls_trunc_orgid-t_orgid.
  ENDLOOP.
  INSERT ls_trunc_orgid INTO TABLE gt_trunc_orgid.

* ----- ---- ----
  et_orgid = ls_trunc_orgid-t_orgid.
* ----- ---- ----

ENDMETHOD.


METHOD refresh_buffer.

*-->begin of MED-55432 AGujev
  DATA l_status    TYPE ish_on_off.
* Check SAP OM Switch
  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status = l_status
    EXCEPTIONS
      OTHERS   = 0.
  IF l_status EQ off.
*in case BPOM is active, do not refresh the buffer!
*for BPOM the org structure takes a lot to load for each building of clinical order hitlist
*therefore refreshing the buffer tables is a performance killer
*<--end of MED-55432 AGujev
    REFRESH gt_buf_einri_org.
    REFRESH gt_trunc_orgid.                                 "MED-34816
    REFRESH gt_buf_org_partial.         "MED-57755 AGujev
  ENDIF.         "MED-55432 AGujev

ENDMETHOD.
ENDCLASS.
