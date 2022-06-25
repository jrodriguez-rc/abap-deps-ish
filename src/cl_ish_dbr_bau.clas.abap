class CL_ISH_DBR_BAU definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_DBR_BAU
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

  class-methods GET_BAU_BY_BAUID
    importing
      value(I_BAUID) type BAUID
      value(I_READ_DB) type ISH_ON_OFF default OFF
    exporting
      value(ES_NBAU) type NBAU
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_BAU_ALL
    importing
      value(I_EINRI) type EINRI
    exporting
      value(ET_NBAU) type ISHMED_T_NBAU
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_BAU_BY_BAUID
    importing
      !IT_BAUID type STANDARD TABLE
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_FIELDNAME_BAU) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_NBAU) type ISHMED_T_NBAU
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_BAU_BY_BAUID_RANGE
    importing
      value(IT_BAUID) type ISH_T_R_BAUID optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
    exporting
      value(ET_NBAU) type ISHMED_T_NBAU
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DBR_PAT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DBR_BAU
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBR_BAU IMPLEMENTATION.


METHOD get_bau_by_bauid.

  e_rc = 0.

  CLEAR: es_nbau.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CALL FUNCTION 'ISH_READ_NBAU'
    EXPORTING
      ss_bauid  = i_bauid
    IMPORTING
      ss_nbau   = es_nbau
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.

  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    IF cr_errorhandler IS BOUND.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD get_t_bau_all.

  DATA: l_status          TYPE ish_on_off.
  DATA: lt_result_objec   TYPE tswhactor.
  DATA: lt_object_bau     TYPE hrobject_t.
  DATA: l_plvar           TYPE objec-plvar.
  DATA: lt_infotypes      TYPE rninfty_bu.
  DATA: l_reqinfotypes    TYPE rnreqinfty_bu.
  DATA: l_object          TYPE hrobject.

  FIELD-SYMBOLS: <l_result_objec> TYPE swhactor.

  e_rc = 0.

  REFRESH: et_nbau.

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
        i_bu_read              = on
        i_rel_flg              = on
        i_del_flg              = on
        i_starting_date        = sy-datum
        i_ending_date          = sy-datum
        i_instn_flg            = on
      IMPORTING
*        et_result_struc        = lt_struc_filtered
        et_result_tab          = lt_result_objec
*        et_not_released_object = lt_not_released
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
      CHECK <l_result_objec>-otype = 'N0'.
      MOVE-CORRESPONDING <l_result_objec> TO l_object.
      l_object-plvar = l_plvar.
      APPEND l_object TO lt_object_bau.
    ENDLOOP.

*   check if there are organizational units
    IF lt_object_bau IS NOT INITIAL.

      l_reqinfotypes-inf1000 = on.
      l_reqinfotypes-inf1002 = on.
      l_reqinfotypes-inf1028 = on.
      l_reqinfotypes-inf6080 = on.
      l_reqinfotypes-inf6091 = on.

      CALL FUNCTION 'ISH_OM_INFTY_BU_GET'
        EXPORTING
          it_objects     = lt_object_bau
          i_req_infty    = l_reqinfotypes
          i_f4_mode      = on
        IMPORTING
          e_infty_bu     = lt_infotypes
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

      CALL FUNCTION 'ISH_OM_NBAU_FILL'
        EXPORTING
          i_infty_bu = lt_infotypes
        IMPORTING
          et_nbau    = et_nbau.

    ENDIF.

  ELSE.

    SELECT * FROM nbau INTO TABLE et_nbau             "#EC CI_SGLSELECT "#EC CI_NOFIELD
                       WHERE loekz <> on.

  ENDIF.

  SORT et_nbau BY bauid.

ENDMETHOD.


METHOD get_t_bau_by_bauid.

  TYPES: BEGIN OF ty_bauid,
           bauid               TYPE nbau-bauid,
         END OF ty_bauid,
         tyt_bauid             TYPE STANDARD TABLE OF ty_bauid.

  DATA: lt_bauid               TYPE tyt_bauid,
        ls_bauid               TYPE ty_bauid,
        ls_nbau                LIKE LINE OF et_nbau,
        l_status               TYPE ish_on_off,
        l_data                 TYPE REF TO data,
        l_rc                   TYPE ish_method_rc.

  FIELD-SYMBOLS: <l_field_bau> TYPE any,
                 <l_imp_bauid> TYPE any,
                 <ls_bauid>    TYPE ty_bauid.

  e_rc = 0.

  REFRESH: et_nbau, lt_bauid.

  CHECK it_bauid[] IS NOT INITIAL.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF it_bauid[] IS NOT INITIAL.
    CREATE DATA l_data LIKE LINE OF it_bauid.
    ASSIGN l_data->* TO <l_imp_bauid>.
    LOOP AT it_bauid INTO <l_imp_bauid>.
      sy-subrc = 4.
      IF i_fieldname_bau IS NOT INITIAL.
        ASSIGN COMPONENT i_fieldname_bau OF STRUCTURE <l_imp_bauid>
            TO <l_field_bau>.
      ENDIF.
      IF sy-subrc <> 0.
        ASSIGN COMPONENT 'BAUID' OF STRUCTURE <l_imp_bauid>
            TO <l_field_bau>.
        IF sy-subrc <> 0.
          ASSIGN COMPONENT 'ZIMMR' OF STRUCTURE <l_imp_bauid>
              TO <l_field_bau>.
        ENDIF.
      ENDIF.
      CHECK sy-subrc = 0.
      ls_bauid-bauid = <l_field_bau>.
      CHECK ls_bauid-bauid IS NOT INITIAL.
      APPEND ls_bauid TO lt_bauid.
    ENDLOOP.
  ENDIF.

  CHECK lt_bauid[] IS NOT INITIAL.

  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status = l_status
    EXCEPTIONS
      OTHERS   = 0.

  IF l_status EQ on.

    CALL FUNCTION 'ISH_OM_BU_GET'
      EXPORTING
        it_bauid       = lt_bauid
      IMPORTING
        et_nbau        = et_nbau
      EXCEPTIONS
        nothing_found  = 1
        internal_error = 2
        OTHERS         = 3.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
    ENDIF.

  ELSE.

    LOOP AT lt_bauid ASSIGNING <ls_bauid>.
      CLEAR: l_rc, ls_nbau.
      CALL METHOD cl_ish_dbr_bau=>get_bau_by_bauid
        EXPORTING
          i_bauid         = <ls_bauid>-bauid
          i_read_db       = i_read_db
        IMPORTING
          es_nbau         = ls_nbau
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ELSE.
        APPEND ls_nbau TO et_nbau.
      ENDIF.
    ENDLOOP.

  ENDIF.

ENDMETHOD.


METHOD get_t_bau_by_bauid_range.

  DATA: l_status  TYPE ish_on_off.

  e_rc = 0.

  REFRESH: et_nbau.

*  CHECK it_bauid[] IS NOT INITIAL.  " DO NOT CHECK !!! = is allowed!

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status = l_status
    EXCEPTIONS
      OTHERS   = 0.

  IF l_status EQ on.
    CALL FUNCTION 'ISH_OM_BU_GET'
      EXPORTING
        itr_bauid      = it_bauid
      IMPORTING
        et_nbau        = et_nbau
      EXCEPTIONS
        nothing_found  = 1
        internal_error = 2
        OTHERS         = 3.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
    ENDIF.
  ELSE.
    SELECT * FROM nbau INTO TABLE et_nbau
           WHERE  bauid IN it_bauid.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
    ENDIF.
  ENDIF.

ENDMETHOD.
ENDCLASS.
