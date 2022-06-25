class CL_ISH_DBR_BAU_PLAN definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_DBR_BAU_PLAN
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

  class-methods GET_BAU_PLAN_BY_BAUID
    importing
      value(I_BAUID) type BAUID
      value(I_BEGDT) type SY-DATUM default SY-DATUM
      value(I_ENDDT) type SY-DATUM default SY-DATUM
      value(I_READ_DB) type ISH_ON_OFF default OFF
    exporting
      value(ES_TN11P) type TN11P
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_T_BAU_PLAN_BY_BAUID
    importing
      !IT_BAUID type STANDARD TABLE
      value(I_BEGDT) type SY-DATUM default SY-DATUM
      value(I_ENDDT) type SY-DATUM default SY-DATUM
      value(I_READ_DB) type ISH_ON_OFF default OFF
      value(I_FIELDNAME_BAU) type ISH_FIELDNAME default SPACE
    exporting
      value(ET_TN11P) type ISH_T_TN11P
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DBR_PAT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DBR_BAU_PLAN
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBR_BAU_PLAN IMPLEMENTATION.


METHOD get_bau_plan_by_bauid.

  DATA: l_status   TYPE ish_on_off.

  e_rc = 0.

  CLEAR: es_tn11p.

  IF cr_errorhandler IS INITIAL AND
     cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Check SAP OM Switch
  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status   = l_status
    EXCEPTIONS
      not_active = 0.

  IF l_status EQ on.

*  CALL FUNCTION 'ISH_OM_API_PLAN_DATA_GET'  ???xxx!!!
*    EXPORTING
*      bauid   = i_bauid
*      begdt   = i_begdt
*      enddt   = i_enddt
*    IMPORTING
*      tn11p_s = es_tn11p
*    EXCEPTIONS
*      OTHERS  = 1.
*  IF sy-subrc <> 0.
*    e_rc = sy-subrc.
*    IF cr_errorhandler IS BOUND.
*      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*    ENDIF.
*  ENDIF.

  ELSE.

    SELECT SINGLE * FROM tn11p INTO es_tn11p
           WHERE  bauid  = i_bauid
           AND    enddt >= i_begdt
           AND    begdt <= i_enddt.

  ENDIF.

ENDMETHOD.


METHOD get_t_bau_plan_by_bauid.

  TYPES: BEGIN OF ty_bauid,
           bauid               TYPE nbau-bauid,
         END OF ty_bauid,
         tyt_bauid             TYPE STANDARD TABLE OF ty_bauid.

  DATA: lt_bauid               TYPE tyt_bauid,
        ls_bauid               TYPE ty_bauid,
        l_data                 TYPE REF TO data,
        l_status               TYPE ish_on_off,
        l_rc                   TYPE ish_method_rc.

  FIELD-SYMBOLS: <l_field_bau> TYPE any,
                 <l_imp_bauid> TYPE any,
                 <ls_bauid>    TYPE ty_bauid.

  e_rc = 0.

  REFRESH: et_tn11p, lt_bauid.

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

* Check SAP OM Switch
  CALL FUNCTION 'ISH_SAP_OM_CHECK_ACTIVE'
    IMPORTING
      e_status   = l_status
    EXCEPTIONS
      not_active = 0.

  IF l_status EQ on.

*  CALL FUNCTION 'ISH_OM_API_PLAN_DATA_GET'  ???!!!
*    EXPORTING
*      bauid_t = it_bauid
*      begdt   = i_begdt
*      enddt   = i_enddt
*    IMPORTING
*      tn11p_t = et_tn11p
*    EXCEPTIONS
*      OTHERS  = 1.
*  IF sy-subrc <> 0.
*    e_rc = sy-subrc.
*    IF cr_errorhandler IS BOUND.
*      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*    ENDIF.
*  ENDIF.

  ELSE.

    SELECT * FROM tn11p INTO TABLE et_tn11p
          FOR ALL ENTRIES IN lt_bauid
          WHERE bauid =  lt_bauid-bauid
            AND enddt >= i_begdt
            AND begdt <= i_enddt.

  ENDIF.

ENDMETHOD.
ENDCLASS.
