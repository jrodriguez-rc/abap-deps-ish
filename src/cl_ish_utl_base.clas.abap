class CL_ISH_UTL_BASE definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_UTL_BASE
*"* do not include other source files here!!!
  type-pools ABAP .

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

  class-methods IS_OU_COORD_UNIT
    importing
      value(I_ORGID) type ORGID optional
      value(IS_NORG) type NORG optional
    exporting
      value(E_IS_COORD_UNIT) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods APPEND_MESSAGE_FOR_EXCEPTION
    importing
      !IR_EXCEPTION type ref to CX_ROOT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  class-methods CALCULATE_DURATION_TIME
    importing
      value(I_DATE_FORM) type DATS optional
      value(I_DATE_TO) type DATS optional
      value(I_TIME_FROM) type SY-UZEIT
      value(I_TIME_TO) type SY-UZEIT
    exporting
      !E_DURATION_MIN type ISH_DZEIT
      !E_DURATION_SEC type SYTABIX
      !E_RC type ISH_METHOD_RC .
  class-methods CHANGE
    importing
      value(IS_DATA_X) type ANY
      value(IT_FIELDNAME_IGNORE) type FIELDNAME_TAB optional
      value(IT_FIELDNAME_MAPPING) type ISH_T_FIELDNAME_MAPPING optional
      value(I_SET_XFLAGS) type ISH_ON_OFF default OFF
      value(I_DATA_NAME) type STRING optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_CHANGED) type ISH_ON_OFF
      value(ET_CHANGED_FIELDS) type DDFIELDS
    changing
      value(CS_DATA) type ANY
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods COLLECT_MESSAGES
    importing
      value(I_TYP) type SY-MSGTY optional
      value(I_KLA) type SY-MSGID optional
      value(I_NUM) type SY-MSGNO optional
      !I_MV1 type ANY optional
      !I_MV2 type ANY optional
      !I_MV3 type ANY optional
      !I_MV4 type ANY optional
      value(I_PAR) type BAPIRET2-PARAMETER optional
      value(I_ROW) type BAPIRET2-ROW optional
      value(I_FIELD) type BAPIRET2-FIELD optional
      value(IR_OBJECT) type NOBJECTREF optional
      value(I_LINE_KEY) type CHAR100 optional
      !IR_ERROR_OBJ type ref to CL_ISH_ERROR optional
      value(IT_MESSAGES) type ISHMED_T_MESSAGES optional
      !I_TN21M type ISH_ON_OFF default ' '
      !I_EINRI type EINRI optional
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods COLLECT_MESSAGES_BY_BAPIRET
    importing
      value(I_BAPIRET) type BAPIRET2
      value(IR_OBJECT) type NOBJECTREF optional
      value(I_LINE_KEY) type CHAR100 optional
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods COLLECT_MESSAGES_BY_EXCEPTION
    importing
      !I_EXCEPTIONS type ref to CX_ROOT optional
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING
      !IT_DWS_MESSAGE type ISHMED_T_MESSAGES optional .
  class-methods COLLECT_MESSAGES_BY_SYST
    importing
      value(I_TYP) type SY-MSGTY optional
      value(I_PAR) type BAPIRET2-PARAMETER optional
      value(I_ROW) type BAPIRET2-ROW optional
      value(I_FIELD) type BAPIRET2-FIELD optional
      value(IR_OBJECT) type NOBJECTREF optional
      value(I_LINE_KEY) type CHAR100 optional
      !IR_ERROR_OBJ type ref to CL_ISH_ERROR optional
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CONVERT_STRING_TO_TABLE
    importing
      value(I_STRING) type STRING
      value(I_TABLINE_LENGTH) type I
    exporting
      !ET_TABLE type TABLE .
  class-methods CONVERT_STRING_TO_TABLE_NOWRAP
    importing
      value(I_STRING) type STRING
      value(I_TABLINE_LENGTH) type I
    exporting
      !ET_TABLE type TABLE .
  class-methods COPY_MESSAGES
    importing
      value(I_COPY_FROM) type ref to CL_ISHMED_ERRORHANDLING
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CREATE_CONFIG
    importing
      !I_OBJECT_TYPE type I optional
      !I_FACTORY_NAME type STRING optional
      !I_CLASS_NAME type STRING optional
      !I_USE_BADI type ISH_ON_OFF default ON
      !I_REFRESH_BADI_INSTANCE type ISH_ON_OFF default OFF
      !I_FORCE_BADI_ERRORS type ISH_ON_OFF default OFF
      !I_CREATE_OWN type ISH_ON_OFF default ON
    exporting
      !ER_CONFIG type ref to IF_ISH_CONFIG
      !E_CREATED_BY_BADI type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CREATE_SET_ERROR
    importing
      value(I_ERROR) type N1_ERROR
    returning
      value(RR_ERROR) type ref to CL_ISH_ERROR .
  class-methods DESTROY_ENV
    importing
      value(I_FINAL) type ISH_ON_OFF default ON
    changing
      !CR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT .
  class-methods EXISTS_INSTITUTION
    importing
      value(I_INSTITUTION) type EINRI
      !I_CALLER type ref to OBJECT optional
    exporting
      !E_EXISTS type ISH_ON_OFF
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GENERATE_GUID
    returning
      value(R_GUID) type SYSUUID_22 .
  class-methods GENERATE_UUID
    returning
      value(R_UUID) type SYSUUID_C .
  class-methods GENERATE_UUID_WITH_PREFIX
    returning
      value(R_UUID) type ISH_UUID_P .
  class-methods GET_ALL_CONNS_ENDING_AT_PAP
    importing
      !IR_OBJ type ref to IF_ISH_IDENTIFY_OBJECT optional
      !IT_OBJ type ISH_T_IDENTIFY_OBJECT optional
    exporting
      !ET_CONN_OBJ type ISH_OBJECTLIST
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_AUTH_VM_DEF
    returning
      value(R_HAS_AUTH) type ISH_ON_OFF .
  class-methods GET_CUSTOMER_ID
    importing
      value(I_IDNAME) type N1BASE_IDNAME optional
    returning
      value(R_CLSID) type I .
  class-methods GET_ENVIRONMENTS
    importing
      value(IT_RUN_DATA) type ISH_T_RUN_DATA
    returning
      value(RT_ENVIRONMENTS) type ISH_T_RUN_DATA .
  class-methods GET_ID_OBJECTS_OF_OBJLIST
    importing
      value(IT_OBJLIST) type ISH_OBJECTLIST
    returning
      value(RT_ID_OBJECTS) type ISH_T_IDENTIFY_OBJECT .
  class-methods GET_INSTITUTION_OF_OBJ
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
    returning
      value(R_EINRI) type TN01-EINRI .
  class-methods GET_MESSAGES_OF_EXCEPTION
    importing
      !I_EXCEPTION type ref to CX_ROOT optional
    exporting
      !E_WORST_MSGTY type ISH_BAPIRETMAXTY
      !ET_MESSAGE type ISHMED_T_MESSAGES
      !ET_BAPIRET2 type ISHMED_T_BAPIRET2 .
  class-methods GET_MESSAGE_TEXT
    changing
      !CS_MESSAGE type BAPIRET2 .
  class-methods GET_NOTKZ_ICON
    importing
      !IR_MOV type ref to CL_ISHMED_MOVEMENT
    exporting
      value(E_ICON) type NWICON
      value(E_NOTKZ) type RI_NOTKZ
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_ORGFA
    importing
      value(I_EINRI) type EINRI
      value(I_ORGID) type ORGID
      value(I_VALDT) type SY-DATUM default SY-DATUM
      value(I_PAR) type BAPIRET2-PARAMETER optional
      value(I_FLD) type BAPIRET2-FIELD optional
      !IR_OBJECT type ref to OBJECT optional
    exporting
      value(E_ORGFA) type ORGID
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_OU_HIER
    importing
      !I_SEL_BU type ISH_ON_OFF default ON
      !I_INDERDIS type ISH_ON_OFF default ON
      !I_ZIMKZ type ISH_ON_OFF default ON
      !I_BETTKZ type ISH_ON_OFF default ON
      !I_DATUM type SY-DATUM default SY-DATUM
      !I_EINRI type EINRI
      !I_SPERR type ISH_ON_OFF default OFF
      !I_LOEKZ type ISH_ON_OFF default OFF
      !I_FREIG type ISH_ON_OFF default ON
      !I_START_OU type ORGID default SPACE
    returning
      value(RT_OU_HIER) type ISH_T_OE_HIER
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods GET_TELEPHONE_NUMBER_OF_USER
    importing
      value(I_USER) type SY-UNAME
    exporting
      value(E_NUMBER) type STRING
      value(E_NUMBER_DESCR) type STRING .
  class-methods GET_USER_NAME
    importing
      value(I_USER) type SY-UNAME default SY-UNAME
    returning
      value(R_NAME) type ADRP-NAME_TEXT .
  class-methods GET_VALUE_OF_DATA_REF
    importing
      !IR_DATA_REF type ref to DATA
      value(I_FIELDNAME) type ISH_FIELDNAME
    exporting
      value(E_VALUE) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods HANDLE_WARNINGS
    importing
      !IR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING
      value(I_OKCODE) type SYUCOMM
      value(I_IGNORE_OBJECT) type ISH_ON_OFF default ' '
    exporting
      value(E_DISPLAY_MESSAGES) type ISH_ON_OFF
      value(E_ONLY_WARNINGS_EXIST) type ISH_ON_OFF
    changing
      !CS_HANDLE_WARNING type RNWARNING .
  class-methods IS_BACKGROUND
    returning
      value(R_VALUE) type ABAP_BOOL .
  class-methods IS_GUI_CONTROL_VALID
    importing
      !IR_GUI_CONTROL type ref to CL_GUI_CONTROL
    returning
      value(R_VALID) type ISH_ON_OFF .
  class-methods IS_INTERFACE_IMPLEMENTED
    importing
      value(IR_OBJECT) type ref to OBJECT
      value(I_INTERFACE_NAME) type SEOCLSNAME
    returning
      value(R_IS_IMPLEMENTED) type ISH_ON_OFF .
  class-methods IS_NUMERIC
    importing
      value(I_VALUE) type SIMPLE
    returning
      value(R_NUMERIC) type ISH_ON_OFF .
  class-methods IS_OBJ_OP
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
    exporting
      value(E_IS_OP) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods IS_T_ERROR_DERIVED_FROM
    importing
      value(IT_ERROR_DERIVED) type ISHMED_T_OBJTYPE_N1ERROR optional
      value(IT_ERROR_INHERITED) type ISHMED_T_OBJTYPE_N1ERROR optional
      !IR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !IR_ERROR_OBJ type ref to CL_ISH_ERROR optional
      value(IT_MESSAGES) type ISHMED_T_MESSAGES optional
    exporting
      value(E_DERIVED) type ISH_ON_OFF
      value(E_ALL_DERIVED) type ISH_ON_OFF
      value(ET_MESSAGES) type ISHMED_T_MESSAGES .
  class-methods MAX_SESSIONS_CHECK
    returning
      value(E_LIMIT_REACHED) type ISH_ON_OFF .
  class-methods MESSAGE_TEXT_SPLIT
    importing
      value(I_TEXT) type C
    exporting
      value(E_MSGVAR1) type SYMSGV
      value(E_MSGVAR2) type SYMSGV
      value(E_MSGVAR3) type SYMSGV
      value(E_MSGVAR4) type SYMSGV .
  class-methods NORMALIZE_STRING
    importing
      !I_STRING type STRING
    returning
      value(R_STRING) type STRING .
  class-methods REMOVE_MESSAGES
    importing
      !I_ID type SYMSGID optional
      !I_NUMBER type SYMSGNO optional
      !IT_MESSAGES type ISHMED_T_MESSAGES optional
      !IT_ERR_DER_EXCEPT type ISHMED_T_OBJTYPE_N1ERROR optional
      !IT_ERR_INH_EXCEPT type ISHMED_T_OBJTYPE_N1ERROR optional
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods SET_MESSAGE_BY_SYST
    returning
      value(RS_MESSAGE) type SCX_T100KEY .
  class-methods SET_VALUE_TO_DATA_REF
    importing
      !IR_DATA_REF type ref to DATA
      value(I_FIELDNAME) type ISH_FIELDNAME
      value(I_VALUE) type ANY
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods SWITCH_ON_OFF_TO_TRUE_FALSE
    importing
      value(I_ON_OFF) type ISH_ON_OFF optional
    returning
      value(R_TRUE_FALSE) type ISH_TRUE_FALSE .
protected section.
*"* protected components of class CL_ISH_UTL_BASE
*"* do not include other source files here!!!

  class-data GR_BADI_CREATE_CONFIG type ref to IF_EX_N1_CREATE_CONFIG .
  class-data G_AUTH_VM_DEF type ISH_ON_OFF .
  class-data G_AUTH_VM_DEF_READ type ISH_ON_OFF .
private section.

*"* private components of class CL_ISH_UTL_BASE
*"* do not include other source files here!!!
  class-methods GET_T100_ATTR
    importing
      !I_ATT type SCX_ATTRNAME
      !IR_EXC type ref to CX_ROOT
    returning
      value(R_RESULT) type SYMSGV .
ENDCLASS.



CLASS CL_ISH_UTL_BASE IMPLEMENTATION.


METHOD append_message_for_exception .

  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CLEAR e_rc.

  CALL METHOD cr_errorhandler->append_message_for_exception
    EXPORTING
      ir_exception = ir_exception
    IMPORTING
      e_rc         = e_rc.

ENDMETHOD.


METHOD calculate_duration_time.
  DATA: diff TYPE i.

  CLEAR e_rc.
* ------ ------ ----- ------ -------
  IF i_date_form IS INITIAL
      AND i_date_to IS INITIAL.
    e_duration_sec = i_time_to - i_time_from.
    e_duration_min = e_duration_sec / 60.
  ELSEIF i_date_form IS NOT INITIAL
         AND i_date_to IS NOT INITIAL.
    diff = i_date_to - i_date_form.
    IF diff < 6 AND diff > -6.
      e_duration_sec =  ( ( i_date_to - i_date_form ) * 86400 )
               +    ( i_time_to - i_time_from ).
      e_duration_min = e_duration_sec / 60.
    ELSE.
      e_duration_sec = 0.
      e_duration_min = 0.
      e_rc = 1.
    ENDIF.
* ------ ------ ----- ------ -------
  ENDIF.
  IF e_duration_sec < 0.
    e_rc = -1.
  ENDIF.
* ------ ------ ----- ------ -------
ENDMETHOD.


METHOD change .

  DATA: l_rc            TYPE ish_method_rc,
        l_data_name     TYPE string,
        lr_data_tmp     TYPE REF TO data,
        lt_ddfields     TYPE ddfields,
        l_fieldname     TYPE fieldname,
        l_fieldname_x   TYPE fieldname,
        l_fieldname_xx  TYPE fieldname.

  FIELD-SYMBOLS: <ls_dfies>             TYPE dfies,
                 <ls_data_tmp>          TYPE ANY,
                 <l_field>              TYPE ANY,
                 <l_field_x>            TYPE ANY,
                 <l_field_xx>           TYPE ANY,
                 <ls_fieldname_mapping> TYPE rn1_fieldname_mapping.

* Initializations
  CLEAR: e_rc.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  l_data_name = i_data_name.
  IF l_data_name IS INITIAL.
    l_data_name = 'CS_DATA'.
  ENDIF.

* Work on temporary data.
  CREATE DATA lr_data_tmp LIKE cs_data.
  ASSIGN lr_data_tmp->* TO <ls_data_tmp>.
* Fichte, 1.10.03: Assign the given data to the pointer, because
* of course this data must be changed. If this assignment would
* not be done, the data in CS_DATA would get cleared
  <ls_data_tmp> = cs_data.
* Get the DDIC info for cs_data.
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct
    EXPORTING
      is_data         = <ls_data_tmp>
      i_data_name     = l_data_name
      ir_object       = ir_object
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

  CHECK e_rc = 0.

* Now change the requested fields.
  LOOP AT lt_ddfields ASSIGNING <ls_dfies>.

*   l_fieldname: Fieldname in cs_data structure.
    l_fieldname = <ls_dfies>-fieldname.

*   l_fieldname_x:  Fieldname in is_data_x structure.
*   l_fieldname_xx: Fieldname of the X-flag field in is_data_x.
    READ TABLE it_fieldname_mapping
      WITH KEY fieldname = l_fieldname
      ASSIGNING <ls_fieldname_mapping>.
    IF sy-subrc = 0.
      l_fieldname_x  = <ls_fieldname_mapping>-fieldname_x.
      l_fieldname_xx = <ls_fieldname_mapping>-fieldname_xx.
    ELSE.
      l_fieldname_x = l_fieldname.
      CONCATENATE l_fieldname
                  '_X'
             INTO l_fieldname_xx.
    ENDIF.

*   Ignore field?
    READ TABLE it_fieldname_ignore
      FROM l_fieldname
      TRANSPORTING NO FIELDS.
    CHECK sy-subrc <> 0.

*   Check X-flag.
    ASSIGN COMPONENT l_fieldname_xx
      OF STRUCTURE is_data_x
      TO <l_field_xx>.
    CHECK sy-subrc = 0.
    CHECK <l_field_xx> = on.

*   Assign cs_data field.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_data_tmp>
      TO <l_field>.
    CHECK sy-subrc = 0.

*   Assign is_data_x field
    ASSIGN COMPONENT l_fieldname_x
      OF STRUCTURE is_data_x
      TO <l_field_x>.
    CHECK sy-subrc = 0.

*   Change field
    IF <l_field> <> <l_field_x>.
      <l_field> = <l_field_x>.
      e_changed = on.
*     Handle et_changed_fields.
      IF et_changed_fields IS SUPPLIED OR
         i_set_xflags = on.
        APPEND <ls_dfies> TO et_changed_fields.
      ENDIF.
    ENDIF.

  ENDLOOP.

  CHECK e_rc = 0.

* Handle i_set_xflags.
  IF i_set_xflags = on.
    LOOP AT et_changed_fields ASSIGNING <ls_dfies>.
*     l_fieldname: Fieldname of the X-flag field in cs_data.
      CONCATENATE <ls_dfies>-fieldname
                  '_X'
             INTO l_fieldname.
*   Assign cs_data field.
      ASSIGN COMPONENT l_fieldname
        OF STRUCTURE <ls_data_tmp>
        TO <l_field>.
      CHECK sy-subrc = 0.
*   Set X-flag.
      <l_field> = on.
    ENDLOOP.
  ENDIF.

* Set cs_data.
  cs_data = <ls_data_tmp>.

ENDMETHOD.


METHOD collect_messages .
  DATA: l_par TYPE bapiret2-parameter.

  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CLEAR: l_par.
  l_par = i_par.
* Fichte, MED-61367: Just for easier debugging if TYPE = 'E'
  IF i_typ = 'E'.
    DATA: l_useless TYPE c.
    l_useless = 'X'.
  ENDIF.
* Fichte, MED-61367 - End
  CALL METHOD cr_errorhandler->collect_messages
    EXPORTING
      i_typ        = i_typ
      i_kla        = i_kla
      i_num        = i_num
      i_mv1        = i_mv1
      i_mv2        = i_mv2
      i_mv3        = i_mv3
      i_mv4        = i_mv4
      i_par        = l_par
      i_row        = i_row
      i_fld        = i_field
      t_messages   = it_messages
      i_last       = space
      i_object     = ir_object
      i_line_key   = i_line_key
      ir_error_obj = ir_error_obj
      i_read_tn21m = i_tn21m            "MED-47677 Rares Roman
      i_einri      = i_einri.           "MED-47677 Rares Roman
ENDMETHOD.


METHOD collect_messages_by_bapiret .
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CALL METHOD cr_errorhandler->collect_messages
    EXPORTING
      i_typ      = i_bapiret-type
      i_kla      = i_bapiret-id
      i_num      = i_bapiret-number
      i_mv1      = i_bapiret-message_v1
      i_mv2      = i_bapiret-message_v2
      i_mv3      = i_bapiret-message_v3
      i_mv4      = i_bapiret-message_v4
      i_par      = i_bapiret-parameter
      i_row      = i_bapiret-row
      i_fld      = i_bapiret-field
      i_last     = space
      i_object   = ir_object
      i_line_key = i_line_key.
ENDMETHOD.


METHOD collect_messages_by_exception.
  DATA lr_ish_exception TYPE REF TO cx_ish_static_handler.
  DATA lr_message       TYPE REF TO if_t100_message.
  DATA lr_ext_handler   TYPE REF TO if_ishmed_xt_exception.
  DATA l_text           TYPE c LENGTH 250.
  DATA l_text1          TYPE symsgv.
  DATA l_text2          TYPE symsgv.
  DATA l_program        TYPE syrepid.
  DATA l_include        TYPE syrepid.
  DATA l_line           TYPE i.
  DATA lt_msg           TYPE ishmed_t_messages.

* Preconditions............................................
  IF i_exceptions IS NOT BOUND.
    RETURN.
  ENDIF.

  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Supress default text of selected dws classes if requested
* see OSS 0000443868 2009; should be solved by a generalized solution
  IF i_exceptions->previous IS BOUND.
    CASE cl_ish_utl_rtti=>get_class_name( ir_object = i_exceptions ).
      WHEN 'CX_ISHMED_DWS_OBJECT'
        OR 'CX_ISHMED_DWS_CONTROLLER'
        OR 'CX_ISHMED_DWS'.

        TRY.
            lr_ish_exception ?= i_exceptions.

*            if lr_ish_exception->gr_errorhandler is not bound. ni: ausgesternt
              "process next exception
              cl_ish_utl_base=>collect_messages_by_exception(
                EXPORTING
                  i_exceptions    = i_exceptions->previous
                CHANGING
                  cr_errorhandler = cr_errorhandler ).

              RETURN. "Return from recursive stack; cut path

*            ENDIF.

          CATCH cx_sy_move_cast_error.                  "#EC NO_HANDLER
        ENDTRY.

    ENDCASE.

  ENDIF.
*->

* Call extendend handler processing if requested
  TRY.
      lr_ext_handler ?= i_exceptions.

      IF lr_ext_handler->eval( ) = abap_false.
        "process next exception
        IF i_exceptions->previous IS BOUND.
          cl_ish_utl_base=>collect_messages_by_exception(
            EXPORTING
              i_exceptions    = i_exceptions->previous
            CHANGING
              cr_errorhandler = cr_errorhandler ).
        ENDIF.
      ENDIF.

    CATCH cx_sy_move_cast_error.
      FREE lr_ext_handler.
      "Continue with default handling
  ENDTRY.

* get message from if_t100_message
  TRY.
      lr_message ?= i_exceptions.
    CATCH cx_sy_move_cast_error.
      FREE lr_message.
  ENDTRY.

* get message from cx_ish_static_handler derived classes
  TRY.
      lr_ish_exception ?= i_exceptions.
    CATCH cx_sy_move_cast_error.
      FREE lr_ish_exception.
  ENDTRY.


*** add T100 Exception:
  IF lr_message IS BOUND.
    DATA: l_attr1 TYPE symsgv,
          l_attr2 TYPE symsgv,
          l_attr3 TYPE symsgv,
          l_attr4 TYPE symsgv.

    l_attr1 = get_t100_attr( ir_exc = i_exceptions
                i_att = lr_message->t100key-attr1 ).
    l_attr2 = get_t100_attr( ir_exc = i_exceptions
                i_att = lr_message->t100key-attr2 ).
    l_attr3 = get_t100_attr( ir_exc = i_exceptions
                i_att = lr_message->t100key-attr3 ).
    l_attr4 = get_t100_attr( ir_exc = i_exceptions
                i_att = lr_message->t100key-attr4 ).

    IF lr_ish_exception IS NOT BOUND.
*     add t100 error text without severity
      cl_ish_utl_base=>collect_messages(
        EXPORTING
          i_typ           = 'E'
          i_kla           = lr_message->t100key-msgid
          i_num           = lr_message->t100key-msgno
          i_mv1           = l_attr1
          i_mv2           = l_attr2
          i_mv3           = l_attr3
          i_mv4           = l_attr4
        CHANGING
          cr_errorhandler = cr_errorhandler ).

    ELSE. " ==> lr_ish_exception IS BOUND.
*     add t100 error text with severity
*     Suppress default text if there are other messages
      IF lr_ish_exception->gr_errorhandler IS BOUND.
        lr_ish_exception->gr_errorhandler->get_messages(
          IMPORTING
            t_extended_msg = lt_msg ).
      ENDIF.

      IF  lines( lt_msg ) = 0
      AND lr_message->t100key <> lr_message->default_textid.
        cl_ish_utl_base=>collect_messages(
          EXPORTING
            i_typ           = lr_ish_exception->gr_msgtyp
            i_kla           = lr_message->t100key-msgid
            i_num           = lr_message->t100key-msgno
            i_mv1           = l_attr1
            i_mv2           = l_attr2
            i_mv3           = l_attr3
            i_mv4           = l_attr4
          CHANGING
            cr_errorhandler = cr_errorhandler ).
      ENDIF.
    ENDIF.

  ENDIF. "end: t100 exception

** add messages from errorhandler
  IF lr_ish_exception IS BOUND.
    IF lr_ish_exception->gr_errorhandler IS BOUND.
      cr_errorhandler->copy_messages( i_copy_from = lr_ish_exception->gr_errorhandler ).
    ENDIF.
  ENDIF.

** otherwise add message from exception text
  IF lr_ish_exception IS NOT BOUND AND lr_message IS NOT BOUND.
    l_text = i_exceptions->get_text( ).
    MOVE l_text(50) TO l_text1.
    MOVE l_text+50(50) TO l_text2.
    CALL METHOD i_exceptions->get_source_position
      IMPORTING
        program_name = l_program
        include_name = l_include
        source_line  = l_line.

    IF l_text IS NOT  INITIAL.
*MESSAGE e156(n1base) WITH '&' '&'.
*   &
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ    = 'E'
          i_kla    = 'N1BASE'
          i_num    = '156'
          i_mv1    = l_text1
          i_mv2    = l_text2
          i_mv3    = l_include
          i_mv4    = l_line
          i_last   = space
          i_object = i_exceptions.
    ENDIF.
  ENDIF.

** process previous element
  IF i_exceptions->previous IS BOUND.
    cl_ish_utl_base=>collect_messages_by_exception(
      EXPORTING
        i_exceptions    = i_exceptions->previous
      CHANGING
        cr_errorhandler = cr_errorhandler ).
  ENDIF.

ENDMETHOD.


METHOD collect_messages_by_syst .

  DATA: l_typ      TYPE sy-msgty.

  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF i_typ IS INITIAL.
    l_typ = sy-msgty.
  ELSE.
    l_typ = i_typ.
  ENDIF.

  CALL METHOD cr_errorhandler->collect_messages
    EXPORTING
      i_typ        = l_typ
      i_kla        = sy-msgid
      i_num        = sy-msgno
      i_mv1        = sy-msgv1
      i_mv2        = sy-msgv2
      i_mv3        = sy-msgv3
      i_mv4        = sy-msgv4
      i_par        = i_par
      i_row        = i_row
      i_fld        = i_field
      i_last       = space
      i_object     = ir_object
      i_line_key   = i_line_key
      ir_error_obj = ir_error_obj.

ENDMETHOD.


METHOD convert_string_to_table.
  DATA: l_length      TYPE i,
        l_offset      TYPE i,
        l_full_lines  TYPE i,
        l_last_length TYPE i.

  DATA: ls_table TYPE string.
  IF i_string IS INITIAL.
    EXIT.
  ENDIF.
* get string length
  l_length = STRLEN( i_string ).
* get number of full lines
  l_full_lines  = l_length DIV i_tabline_length.
* get length of last line
  l_last_length = l_length MOD i_tabline_length.

* append full lines to output table
  DO l_full_lines TIMES.
    ls_table = i_string+l_offset(i_tabline_length).
    APPEND ls_table TO et_table.
    l_offset = l_offset + i_tabline_length.
  ENDDO.

* append last line to output table
  ls_table = i_string+l_offset(l_last_length).
  APPEND ls_table TO et_table.
ENDMETHOD.


  METHOD convert_string_to_table_nowrap.

    DATA: l_string   TYPE string,
          l_wlen     TYPE i,
          l_pos      TYPE i.

    CHECK i_string IS NOT INITIAL.
    l_string = i_string.

*   Ggf. Zeilenvorschübe rausschmeißen
    REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf IN l_string WITH ` `.
    CONDENSE l_string.

    l_wlen = strlen( l_string ).

*   Solange Stringlänge < max. Zeilenbreite
    WHILE l_wlen GT i_tabline_length.
      l_pos = i_tabline_length + 2 .
*     Vorsicht! Letzte Zeile kann kürzer sein als l_wlen
      IF l_pos > l_wlen.
        l_pos = l_wlen.
      ENDIF.
      WHILE l_pos GE 2.
        l_pos = l_pos - 1.
        IF l_pos GT i_tabline_length AND l_string+l_pos(1) = ` `.
          EXIT.
        ENDIF.
        IF l_pos LE i_tabline_length AND l_string+l_pos(1) CO '/;- '.
          EXIT.
        ENDIF.
      ENDWHILE.
      IF l_pos GT 2.
        ADD 1 TO l_pos.
        APPEND l_string(l_pos) TO et_table.
        SHIFT l_string BY l_pos PLACES.
      ELSE.
        APPEND l_string(i_tabline_length) TO et_table.
        SHIFT l_string BY i_tabline_length PLACES.
      ENDIF.
      l_wlen = strlen( l_string ).
    ENDWHILE.

*   Letzte Zeile noch ausgeben
    APPEND l_string TO et_table.

  ENDMETHOD.


METHOD copy_messages .
* Michael Manoch, 29.08.2007
* Creation of cr_errorhandler only on valid i_copy_from.

  DATA lt_msg           TYPE ishmed_t_messages.

  CHECK i_copy_from IS BOUND.

  CALL METHOD i_copy_from->get_messages
    IMPORTING
      t_extended_msg = lt_msg.
  CHECK lt_msg IS NOT INITIAL.

  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CALL METHOD cr_errorhandler->copy_messages
    EXPORTING
      i_copy_from = i_copy_from.

ENDMETHOD.


METHOD create_config.

  DATA: l_class  TYPE string,
        l_rc     TYPE ish_method_rc.

* Initializations.
  e_rc              = 0.
  e_created_by_badi = off.
  CLEAR er_config.

* Let the badi handle the creation.
  DO 1 TIMES.
*   Process the badi only if specified.
    CHECK i_use_badi = on.
*   Handle i_refresh_badi_instance.
    IF i_refresh_badi_instance = on.
      CLEAR gr_badi_create_config.
    ENDIF.
*   Load the badi instance if not already done.
    IF gr_badi_create_config IS INITIAL.
*     Check if the badi is active.
      CALL FUNCTION 'SXC_EXIT_CHECK_ACTIVE'
        EXPORTING
          exit_name  = 'N1_CREATE_CONFIG'
        EXCEPTIONS
          not_active = 1
          OTHERS     = 2.
*     If the badi is not active do not process the badi.
      CHECK sy-subrc = 0.
*     Get instance of the BADI.
      CALL METHOD cl_exithandler=>get_instance
        EXPORTING
          exit_name                     = 'N1_CREATE_CONFIG'
          null_instance_accepted        = on
        CHANGING
          instance                      = gr_badi_create_config
        EXCEPTIONS
          no_reference                  = 1
          no_interface_reference        = 2
          no_exit_interface             = 3
          class_not_implement_interface = 4
          single_exit_multiply_active   = 5
          cast_error                    = 6
          exit_not_existing             = 7
          data_incons_in_exit_managem   = 8
          OTHERS                        = 9.
      l_rc = sy-subrc.
      IF l_rc <> 0.
        CLEAR gr_badi_create_config.
*       Handle i_force_badi_errors.
        IF i_force_badi_errors = off.
          e_rc = l_rc.
*         BADI & kann nicht instanziert werden (Fehler &)
          CALL METHOD cl_ish_utl_base=>collect_messages
            EXPORTING
              i_typ           = 'E'
              i_kla           = 'N1BASE'
              i_num           = '029'
              i_mv1           = 'N1_CREATE_CONFIG'
              i_mv2           = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          EXIT.
        ENDIF.
      ENDIF.
    ENDIF.
*   Process the badi.
    CHECK NOT gr_badi_create_config IS INITIAL.
    CALL METHOD gr_badi_create_config->create_config
      EXPORTING
        i_object_type   = i_object_type
      IMPORTING
        er_config       = er_config
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      IF NOT er_config IS INITIAL.
        CALL METHOD er_config->destroy.
        CLEAR er_config.
      ENDIF.
      IF i_force_badi_errors = off.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.
    CHECK NOT er_config IS INITIAL.
*   Check the created object.
*   It has to inherit from the given object type.
    IF NOT i_object_type IS INITIAL.
      IF er_config->is_inherited_from( i_object_type ) = off.
        CALL METHOD er_config->destroy.
        IF i_force_badi_errors = off.
          e_rc = 1.
*         BADI &1 lieferte falsches Objekt
          CALL METHOD cl_ish_utl_base=>collect_messages
            EXPORTING
              i_typ           = 'E'
              i_kla           = 'N1BASE'
              i_num           = '064'
              i_mv1           = 'N1_CREATE_CONFIG'
            CHANGING
              cr_errorhandler = cr_errorhandler.
          EXIT.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDDO.
  CHECK e_rc = 0.

* Further processing only if the badi did not create the object.
  IF NOT er_config IS INITIAL.
    e_created_by_badi = on.
    EXIT.
  ENDIF.

* Further processing only if specified.
  CHECK i_create_own = on.

* For own creation we need a class name.
  CLEAR l_class.
  IF NOT i_factory_name IS INITIAL.
    l_class = i_factory_name.
  ELSE.
    l_class = i_class_name.
  ENDIF.
  CHECK NOT l_class IS INITIAL.

* Do own component creation.
  CATCH SYSTEM-EXCEPTIONS dyn_call_meth_excp_not_found   = 1
                          dyn_call_meth_class_not_found  = 2
                          dyn_call_meth_classconstructor = 3
                          dyn_call_meth_constructor      = 4
                          dyn_call_meth_not_found        = 5
                          dyn_call_meth_no_class_method  = 6
                          dyn_call_meth_private          = 7
                          dyn_call_meth_protected        = 8
                          dyn_call_meth_param_kind       = 9
                          dyn_call_meth_param_litl_move  = 10
                          dyn_call_meth_param_tab_type   = 11
                          dyn_call_meth_param_type       = 12
                          dyn_call_meth_param_missing    = 13
                          dyn_call_meth_parref_initial   = 14
                          dyn_call_meth_param_not_found  = 15
                          dyn_call_meth_ref_is_initial   = 16.
    CALL METHOD (l_class)=>create
      IMPORTING
        er_interface    = er_config
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDCATCH.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    IF NOT er_config IS INITIAL.
      CALL METHOD er_config->destroy.
      CLEAR er_config.
    ENDIF.
    e_rc = l_rc.
*   Objekt der Klasse &1 kann nicht instanziert werden (Fehler &2)
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '065'
        i_mv1           = l_class
        i_mv2           = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD create_set_error.

* definitions
  DATA: l_rc              TYPE ish_method_rc.
* ----------- ---------- ----------
* create errorclass
  CALL METHOD cl_ish_error=>create
    IMPORTING
      er_instance = rr_error
      e_rc        = l_rc.
  IF l_rc <> 0.
    CLEAR: rr_error.
    EXIT.
  ENDIF.
* ----------- ---------- ----------
* set error
  CALL METHOD rr_error->set_error
    EXPORTING
      i_error = i_error.
* ----------- ---------- ----------

ENDMETHOD.


METHOD destroy_env .

  IF cr_environment IS NOT INITIAL.
    CALL METHOD cr_environment->if_ish_data_object~destroy
      EXPORTING
        i_final = i_final.
  ENDIF.

  CLEAR cr_environment.

ENDMETHOD.


METHOD exists_institution .

*initialize
  CLEAR: e_exists.

  IF c_errorhandler IS NOT BOUND.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* check initial institution
  IF i_institution IS INITIAL.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ    = 'E'
        i_kla    = 'N1'
        i_num    = '117'
        i_last   = space
        i_object = i_caller.
    e_exists = off.
    RETURN.
  ENDIF.

* call is-h function module
  CALL FUNCTION 'ISH_EINRI_CHECK'
    EXPORTING
      ss_einri  = i_institution
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.
  IF sy-subrc = 1.
    e_exists = off.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ    = sy-msgty
        i_kla    = sy-msgid
        i_num    = sy-msgno
        i_mv1    = sy-msgv1
        i_mv2    = sy-msgv2
        i_mv3    = sy-msgv3
        i_mv4    = sy-msgv4
        i_last   = space
        i_object = i_caller.
  ELSE.
    e_exists = on.
  ENDIF.

ENDMETHOD.


METHOD generate_guid .

  CALL FUNCTION 'GUID_CREATE'
    IMPORTING
      ev_guid_22 = r_guid.

ENDMETHOD.


METHOD GENERATE_UUID .

  CALL FUNCTION 'SYSTEM_UUID_C_CREATE'
    IMPORTING
      uuid = r_uuid.

ENDMETHOD.


METHOD generate_uuid_with_prefix .

  r_uuid(1) = 'C'.
  CALL FUNCTION 'SYSTEM_UUID_C_CREATE'
    IMPORTING
      uuid = r_uuid+1(32).

ENDMETHOD.


METHOD get_all_conns_ending_at_pap.

* local tables
  DATA: lt_conn_obj         TYPE ish_objectlist,
        lt_obj              TYPE ish_t_identify_object,
        lt_read_obj         TYPE ish_t_identify_object,
        lt_tmp_obj          TYPE ish_objectlist.

* definitions
  DATA: l_rc                TYPE ish_method_rc.
  DATA: ls_conn_obj         LIKE LINE OF lt_conn_obj.

* references
  DATA: lr_run              TYPE REF TO cl_ish_run_data,
        lr_id_obj           TYPE REF TO if_ish_identify_object,
        lr_tmp_id_obj       TYPE REF TO if_ish_identify_object,
        lr_pap              TYPE REF TO cl_ish_patient_provisional.

* workareas
  FIELD-SYMBOLS:
        <ls_tmp_obj>        LIKE LINE OF lt_tmp_obj.

  data: lt_srgtimes         TYPE ishmed_t_srgtimes,
        lr_srv              TYPE REF TO cl_ishmed_service.
  field-symbols:
        <ls_srgtimes>       like line of lt_srgtimes.

* CDuerr, MED-32584 - Begin
  DATA: lr_address          TYPE REF TO cl_ish_address.
* CDuerr, MED-32584 - End

* initialization
  e_rc = 0.
  CLEAR: et_conn_obj, lt_conn_obj, lt_obj, lt_tmp_obj.

* use local table
  lt_obj = it_obj.
  IF NOT ir_obj IS INITIAL.
    APPEND ir_obj TO lt_obj.
  ENDIF.

* get connections
  LOOP AT lt_obj INTO lr_id_obj.
*   check for already read objects
    READ TABLE lt_read_obj TRANSPORTING NO FIELDS
       WITH KEY table_line = lr_id_obj.
    IF sy-subrc = 0.
      CONTINUE.
    ENDIF.

*   cast object to correct instance for run data
    CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
      lr_run ?= lr_id_obj.
    ENDCATCH.
    IF sy-subrc <> 0.
      CONTINUE.
    ENDIF.

*   get connections for object
    CLEAR: lt_tmp_obj.
    CALL METHOD lr_run->get_connections
      EXPORTING
        i_all_conn_objects = off
        i_inactive_conns   = on  "PN/MED-33603/2008/11/19
      IMPORTING
        et_objects         = lt_tmp_obj.
    LOOP AT lt_tmp_obj ASSIGNING <ls_tmp_obj>.
*     append to ouput table
      APPEND <ls_tmp_obj> TO lt_conn_obj.
*     check for pap
      CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
        lr_pap ?= <ls_tmp_obj>-object.
      ENDCATCH.
      IF sy-subrc <> 0.
        lr_tmp_id_obj ?= <ls_tmp_obj>-object.
        APPEND lr_tmp_id_obj TO lt_obj.
*     CDuerr, MED-32584 - Begin
      ELSE.
        CALL METHOD lr_pap->get_address
          RECEIVING
            e_instance = lr_address.
        IF lr_address IS BOUND.
          lr_tmp_id_obj ?= lr_address.
          APPEND lr_tmp_id_obj TO lt_obj.
        ENDIF.
*     CDuerr, MED-32584 - End
      ENDIF.
    ENDLOOP.
*    CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
*      lr_srv ?= lr_run.
*    ENDCATCH.
*    IF sy-subrc = 0.
*      CALL METHOD lr_srv->get_t_srgtime
*        EXPORTING
*          i_just_return = on
*        IMPORTING
*          et_srgtime    = lt_srgtimes.
*      LOOP AT lt_srgtimes ASSIGNING <ls_srgtimes>.
*        CLEAR: ls_conn_obj.
*        ls_conn_obj-object = <ls_srgtimes>-obj.
*        APPEND ls_conn_obj TO lt_conn_obj.
*      ENDLOOP.
*    ENDIF.

*   Sta/PN/18975/2006/02/08
    CLEAR: ls_conn_obj.
    ls_conn_obj-object = lr_id_obj.
    APPEND ls_conn_obj TO lt_conn_obj.
*   End/PN/18975/2006/02/08

*   set read object
    APPEND lr_id_obj TO lt_read_obj.
  ENDLOOP.

  CHECK e_rc = 0.

* delete duplicates
  SORT lt_conn_obj BY object.
  DELETE ADJACENT DUPLICATES FROM lt_conn_obj COMPARING object.

* return values
  et_conn_obj = lt_conn_obj.

ENDMETHOD.


METHOD get_auth_vm_def.

* Authority check (but only once).
  IF g_auth_vm_def_read = off.
    AUTHORITY-CHECK OBJECT 'N_VM_DEF' ID 'ACTVT' FIELD '23'.
    IF sy-subrc = 0.
      g_auth_vm_def = on.
    ELSE.
      g_auth_vm_def = off.
    ENDIF.
    g_auth_vm_def_read = on.
  ENDIF.

* Export.
  r_has_auth = g_auth_vm_def.

ENDMETHOD.


METHOD get_customer_id .

  STATICS:
    lt_n1cust_types TYPE HASHED TABLE OF n1customer_types
                    WITH UNIQUE KEY clsid idname.

  DATA:
    ls_n1cust_types TYPE n1customer_types.

  CLEAR r_clsid.

* --- first check if data is in buffer -------------------
  READ TABLE lt_n1cust_types INTO ls_n1cust_types
       WITH KEY idname = i_idname.

  IF sy-subrc EQ 0.
    r_clsid = ls_n1cust_types-clsid.
    EXIT.
  ELSE.
* --- not in buffer - check database ---------------------
    SELECT * FROM n1customer_types UP TO 1 ROWS
                  INTO  ls_n1cust_types
                  WHERE idname = i_idname.
      EXIT.
    ENDSELECT.
    IF sy-subrc EQ 0.
      INSERT ls_n1cust_types INTO TABLE lt_n1cust_types.
      r_clsid = ls_n1cust_types-clsid.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD get_environments .

* workareas
  FIELD-SYMBOLS:
         <ls_run_data>               LIKE LINE OF it_run_data.
* object references
  DATA:  lr_env                      TYPE REF TO cl_ish_environment,
         lr_run_data                 TYPE REF TO cl_ish_run_data.
* ---------- ---------- ----------
  CLEAR: rt_environments.
  LOOP AT it_run_data ASSIGNING <ls_run_data>.
    lr_run_data = <ls_run_data>.
    CALL METHOD lr_run_data->get_environment
      IMPORTING
        e_environment = lr_env.
    READ TABLE rt_environments TRANSPORTING NO FIELDS
       WITH KEY table_line = lr_env.
    IF sy-subrc <> 0.
      INSERT lr_env INTO TABLE rt_environments.
    ENDIF.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_id_objects_of_objlist.

* workareas
  FIELD-SYMBOLS:
        <ls_objlist>               LIKE LINE OF it_objlist.
* definitions
  DATA: l_is_impl                  TYPE ish_on_off.
* object references
  DATA: lr_id_obj                  TYPE REF TO if_ish_identify_object.
* ---------- ---------- ----------
  LOOP AT it_objlist ASSIGNING <ls_objlist>.
*   ----------
*   initialize
    CLEAR: l_is_impl, lr_id_obj.
*   ----------
*   does object implement following interface
    CALL METHOD cl_ish_utl_base=>is_interface_implemented
      EXPORTING
        ir_object        = <ls_objlist>-object
        i_interface_name = 'IF_ISH_IDENTIFY_OBJECT'
      RECEIVING
        r_is_implemented = l_is_impl.
    IF l_is_impl = on.
      lr_id_obj ?= <ls_objlist>-object.
      INSERT lr_id_obj INTO TABLE rt_id_objects.
    ELSE.
      CONTINUE.
    ENDIF.
*   ----------
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_institution_of_obj.

* definitions
  DATA: l_rc                   TYPE ish_method_rc,
        l_is_impl              TYPE ish_on_off.
* object references
  DATA: lr_run_data            TYPE REF TO cl_ish_run_data,
        lr_object              TYPE REF TO if_ish_identify_object,
        lr_data_cont           TYPE REF TO cl_ish_data_container,
        lt_obj                 TYPE ish_objectlist,
        ls_obj                 TYPE ish_object,
        l_flag                 TYPE ish_on_off,
        lr_get_inst            TYPE REF TO if_ish_get_institution.
* ---------- ---------- ----------
* initialize
  CLEAR: r_einri.
* ---------- ---------- ----------
* object is mandatory
  IF ir_object IS INITIAL.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* check if objeckt implement interface "IF_ISH_GET_INSTITUTION"
* -> if yes call method "get_institution" of interface
*  START MED-34863 2010/01/26 Performace HP
*  CALL METHOD cl_ish_utl_base=>is_interface_implemented
*    EXPORTING
*      ir_object        = ir_object
*      i_interface_name = 'IF_ISH_GET_INSTITUTION'
*    RECEIVING
*      r_is_implemented = l_is_impl.
*  IF l_is_impl = on.
**   cast object
*    lr_get_inst ?= ir_object.
*    r_einri = lr_get_inst->get_institution( ).
**   leave method
*    EXIT.
*  ENDIF.
  TRY .
*     cast object
      lr_get_inst ?= ir_object.
      r_einri = lr_get_inst->get_institution( ).
*     leave method
      RETURN.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
* nothing to do
  ENDTRY.

* ---------- ---------- ----------
* object doesn't implement IF_ISH_GET_INSTITUTION
* -> try to find insitution from object

* If the object is a data-container, the institution must be
* searched in one of its objects
  lr_object = ir_object.
  IF lr_object->is_inherited_from(
        cl_ish_data_container=>co_otype_cont_common ) = on.
    lr_data_cont ?= lr_object.
    CLEAR: lt_obj[].
    CALL METHOD lr_data_cont->get_data
      EXPORTING
        i_type    = cl_ish_run_data=>co_otype_run_data
      IMPORTING
        e_rc      = l_rc
        et_object = lt_obj.
    IF l_rc <> 0.
      EXIT.
    ENDIF.
    LOOP AT lt_obj INTO ls_obj.
      CHECK NOT ls_obj-object IS INITIAL.
      lr_run_data ?= ls_obj-object.
      CALL METHOD lr_run_data->get_data_field
        EXPORTING
          i_fill          = off
          i_fieldname     = 'EINRI'
        IMPORTING
          e_rc            = l_rc
          e_field         = r_einri
          e_fld_not_found = l_flag.
      CHECK l_rc = 0      AND
            l_flag = off  AND
            NOT r_einri IS INITIAL.
      EXIT.
    ENDLOOP.
    EXIT.
  ENDIF.

* ---------- ---------- ----------
* check if object is for run or none oo data
* -> then there is a method "get_data_field"
  IF lr_object->is_inherited_from(
      cl_ish_run_data=>co_otype_run_data ) = off.
    EXIT.
  ENDIF.
  lr_run_data ?= lr_object.
* get institution of object
  CALL METHOD lr_run_data->get_data_field
    EXPORTING
      i_fill      = off
      i_fieldname = 'EINRI'
    IMPORTING
      e_rc        = l_rc
      e_field     = r_einri.
  IF l_rc    <> 0 OR
     r_einri IS INITIAL.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_messages_of_exception.
  DATA:
    lr_errorhandler     TYPE REF TO cl_ishmed_errorhandling.

* collect mesaages in errorhanler
  cl_ish_utl_base=>collect_messages_by_exception(
    EXPORTING
      i_exceptions    = i_exception
    CHANGING
      cr_errorhandler = lr_errorhandler
         ).

* get messages
  IF lr_errorhandler IS BOUND.
    lr_errorhandler->get_messages(
      IMPORTING
        t_extended_msg  = et_message
        t_messages      = et_bapiret2
        e_maxty         = e_worst_msgty
           ).
  ENDIF.


ENDMETHOD.


METHOD get_message_text.

  CHECK cs_message-message IS INITIAL.

  CHECK cs_message-id      IS NOT INITIAL.

  CHECK cs_message-number  IS NOT INITIAL.

  CALL FUNCTION 'SX_MESSAGE_TEXT_BUILD'
    EXPORTING
      msgid               = cs_message-id
      msgnr               = cs_message-number
      msgv1               = cs_message-message_v1
      msgv2               = cs_message-message_v2
      msgv3               = cs_message-message_v3
      msgv4               = cs_message-message_v4
    IMPORTING
      message_text_output = cs_message-message.

ENDMETHOD.


METHOD get_notkz_icon.

* work areas
  DATA: ls_nbew     TYPE nbew.

* check input
  CHECK ir_mov IS BOUND.

* get movement data
  CALL METHOD ir_mov->get_data
    IMPORTING
      e_rc           = e_rc
      e_nbew         = ls_nbew
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  e_notkz = ls_nbew-notkz.

* get icon
  IF e_notkz = on.
    CALL METHOD cl_ish_display_tools=>get_wp_icon
      EXPORTING
        i_einri     = ls_nbew-einri
        i_indicator = '123'
      IMPORTING
        e_icon      = e_icon.
  ENDIF.

ENDMETHOD.


METHOD get_orgfa .

  DATA: ls_norg  TYPE norg.

* Initializations.
  e_rc = 0.
  CLEAR e_orgfa.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  CHECK NOT i_orgid IS INITIAL.

* ishmed_read_orgfa
  CALL FUNCTION 'ISHMED_READ_ORGFA'
    EXPORTING
*     Käfer, ID: 15788 - Begin
*      i_datum   = sy-datum
      i_datum   = i_valdt
*     Käfer, ID: 15788 - End
      i_einri   = i_einri
      i_msg     = off
      i_orgid   = i_orgid
      i_fachber = 'X'
    IMPORTING
      e_orgfa   = ls_norg
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.
  e_rc = sy-subrc.

* Errorhandling
  IF e_rc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ    = 'E'
        i_kla    = 'NFCL'
        i_num    = '085'
        i_mv1    = i_orgid
        i_par    = i_par
        i_fld    = i_fld
        i_last   = space
        i_object = ir_object.
    EXIT.
  ENDIF.

* Export
  e_orgfa = ls_norg-orgid.

ENDMETHOD.


METHOD get_ou_hier.

DATA: lt_norg                TYPE ishmed_t_norg,
      lt_nbau                TYPE TABLE OF nbau,
      lt_tn10h               TYPE TABLE OF tn10h,
      lt_tn10i               TYPE TABLE OF tn10i,
      lt_tn10i_temp          TYPE TABLE OF tn10i,
      lt_tn11o               TYPE TABLE OF tn11o,
      lt_tn11h               TYPE TABLE OF tn11h,
      lt_tn11b               TYPE TABLE OF tn11b,
      ls_tn11b               TYPE tn11b,
      ls_norg                TYPE norg,
      ls_nbau                TYPE nbau,
      ls_nbau_tmp            TYPE nbau,
      ls_tn10h               TYPE tn10h,
      ls_tn10i               TYPE tn10i,
      ls_tn11o               TYPE tn11o,
      ls_tn11h               TYPE tn11h,
      l_act_date             TYPE sy-datum,
      lt_norg_hier           TYPE TABLE OF rnorghi,
      ls_norg_hier           TYPE rnorghi,
      ls_norg_hier_cancel    TYPE rnorghi,
      lt_oe_hierarchie       TYPE ish_t_oe_hier,
      ls_oe_hierarchie       TYPE rn1_oe_hier,
      l_level(2)             TYPE n,
      l_tabix                TYPE sy-tabix,
      l_tabix_new            TYPE sy-tabix,
      ls_oe_hierarchie_new   TYPE rn1_oe_hier,
      l_index                TYPE sy-tabix,
      l_starting_orgid       TYPE orgid,
      lr_errorhandler        TYPE REF TO cl_ishmed_errorhandling.

  FIELD-SYMBOLS: <ls_oe_hierarchie> TYPE rn1_oe_hier.

  DATA: gt_fieldcat TYPE lvc_t_fcat.

  l_act_date = i_datum.
  l_starting_orgid = '*'.

  IF NOT i_start_ou IS INITIAL.
    l_starting_orgid = i_start_ou.
  ENDIF.

  CALL FUNCTION 'ISH_FIND_ORG_HIERARCHY_LTD'
    EXPORTING
      ending_date          = l_act_date
      entry_org_unit       = l_starting_orgid
      starting_date        = l_act_date
      interdisz            = i_inderdis
      einri                = i_einri
    TABLES
      back_tab             = lt_norg_hier
    EXCEPTIONS
      wrong_entry_org_unit = 1
      wrong_entry_einri    = 2
      OTHERS               = 3.
  CASE sy-subrc.

    WHEN 1.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1IS_CUST_TRANS_MED'
          i_num           = '120'
        CHANGING
          cr_errorhandler = lr_errorhandler.

      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.

    WHEN 2.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1IS_CUST_TRANS_MED'
          i_num           = '119'
        CHANGING
          cr_errorhandler = lr_errorhandler.

      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.

    WHEN 3.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1IS_CUST_TRANS_MED'
          i_num           = '121'
        CHANGING
          cr_errorhandler = lr_errorhandler.

      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.

  ENDCASE.

  IF NOT lt_norg_hier IS INITIAL.

    CALL METHOD cl_ish_dbr_org=>get_t_org_by_orgid
      EXPORTING
        it_orgid  = lt_norg_hier
        i_read_db = off
        i_einri   = i_einri
      IMPORTING
        et_norg   = lt_norg.

    LOOP AT lt_norg_hier INTO ls_norg_hier.
      l_index = sy-tabix.
      CLEAR ls_oe_hierarchie.
      CLEAR ls_norg.
      ls_oe_hierarchie-hier_level = ls_norg_hier-level.
      READ TABLE lt_norg INTO ls_norg
        WITH KEY orgid = ls_norg_hier-orgid.
      IF ls_norg-sperr NE i_sperr OR
         ls_norg-loekz NE i_loekz OR
         ls_norg-freig NE i_freig.
        DELETE lt_norg_hier.
        LOOP AT lt_norg_hier INTO ls_norg_hier_cancel FROM l_index.
          IF ls_norg_hier_cancel-level = ls_norg_hier-level.
            EXIT.
          ENDIF.
          DELETE lt_norg_hier.
        ENDLOOP.
        CONTINUE.
      ENDIF.
      ls_oe_hierarchie-name    = ls_norg-orgna.
      ls_oe_hierarchie-orgid   = ls_norg_hier-orgid.
      ls_oe_hierarchie-fazuw   = ls_norg-fazuw.
      ls_oe_hierarchie-pfzuw   = ls_norg-pfzuw.
      ls_oe_hierarchie-ambes   = ls_norg-ambes.
      ls_oe_hierarchie-n1anfkz = ls_norg-n1anfkz.
      ls_oe_hierarchie-n1dikz  = ls_norg-n1dikz.
      ls_oe_hierarchie-n1erbrkz = ls_norg-n1erbrkz.
      ls_oe_hierarchie-type = 'OU'.
      ls_oe_hierarchie-norg = ls_norg.
      APPEND ls_oe_hierarchie TO lt_oe_hierarchie.
    ENDLOOP.
  ENDIF.

  CHECK NOT lt_norg_hier IS INITIAL.

* OrgUnits which has no hierarchy are missing.

  IF i_inderdis = on.
*   interdicsiinterdisziplinäre
    CALL METHOD cl_ish_dbr_org_interdep=>get_t_org_interdep_up
      EXPORTING
        it_orgin          = lt_norg_hier
        i_begdt           = l_act_date
        i_enddt           = l_act_date
        i_fieldname_orgin = 'ORGID'
      IMPORTING
        et_tn10i          = lt_tn10i_temp.

    APPEND LINES OF lt_tn10i_temp TO lt_tn10i.

    CALL METHOD cl_ish_dbr_org_interdep=>get_t_org_interdep_down
      EXPORTING
        it_orgbe          = lt_norg_hier
        i_begdt           = l_act_date
        i_enddt           = l_act_date
        i_fieldname_orgbe = 'ORGID'
      IMPORTING
        et_tn10i          = lt_tn10i_temp.

    APPEND LINES OF lt_tn10i_temp TO lt_tn10i.

    IF NOT lt_tn10i IS INITIAL.
      LOOP AT lt_tn10i INTO ls_tn10i.
        LOOP AT lt_oe_hierarchie ASSIGNING <ls_oe_hierarchie>
          WHERE orgid = ls_tn10i-orgin.
          l_tabix = sy-tabix.
          DO 100 TIMES.
            l_tabix = l_tabix - 1.
            l_level = <ls_oe_hierarchie>-hier_level.
            READ TABLE lt_oe_hierarchie INTO ls_oe_hierarchie INDEX l_tabix.
            IF l_level > ls_oe_hierarchie-hier_level.
              IF ls_oe_hierarchie-orgid = ls_tn10i-orgbe.
                <ls_oe_hierarchie>-intkz = 'X'.
              ENDIF.
              EXIT.
            ENDIF.
          ENDDO.
          CONTINUE.
        ENDLOOP.
      ENDLOOP.
    ENDIF.
  ENDIF.

  IF i_sel_bu = on.
* Bauliche Einheiten
*
*    SELECT * FROM nbau INTO TABLE lt_nbau
*                WHERE begdt LE l_act_date
*                  AND enddt GE l_act_date
*                  AND loekz EQ ' '
*                  AND freig EQ 'X'.

    CALL METHOD cl_ish_dbr_bau=>get_t_bau_by_bauid_range
      IMPORTING
        et_nbau = lt_nbau.

    DELETE lt_nbau WHERE freig NE i_freig
                   AND   loekz NE i_loekz
                   AND   enddt LE l_act_date
                   AND   begdt GE l_act_date.

    CALL METHOD cl_ish_dbr_bau_org=>get_t_bau_below_org
      EXPORTING
        it_orgid          = lt_norg_hier
        i_begdt           = l_act_date "MED-53386 (old value was '19000101')
        i_enddt           = l_act_date
        i_fieldname_orgid = 'ORGID'
      IMPORTING
        et_tn11o          = lt_tn11o.

    CALL METHOD cl_ish_dbr_bau_hier=>get_t_bau_hier
      EXPORTING
        i_below         = on
        i_above         = on
        it_bauid        = lt_nbau
        i_fieldname_bau = 'BAUID'
      IMPORTING
        et_tn11h        = lt_tn11h.

    SELECT * FROM tn11b INTO TABLE lt_tn11b
      FOR ALL ENTRIES IN lt_nbau
      WHERE bautex = lt_nbau-bauty.
    l_tabix_new = 1.
    LOOP AT lt_oe_hierarchie INTO ls_oe_hierarchie.
      CHECK sy-tabix = l_tabix_new.
      l_tabix_new = sy-tabix.
      LOOP AT lt_tn11o INTO ls_tn11o
        WHERE orgid = ls_oe_hierarchie-orgid.
        l_tabix_new = l_tabix_new + 1.
        CLEAR ls_oe_hierarchie_new.
        ls_oe_hierarchie_new-hier_level = ls_oe_hierarchie-hier_level + 1.
        READ TABLE lt_nbau INTO ls_nbau
        WITH KEY bauid = ls_tn11o-bauid.
        READ TABLE lt_tn11b INTO ls_tn11b
        WITH KEY bautex = ls_nbau-bauty.
        ls_oe_hierarchie_new-zimkz = ls_tn11b-zimkz.
        ls_oe_hierarchie_new-betkz = ls_tn11b-betkz.
        ls_oe_hierarchie_new-n1apl = ls_tn11b-n1apl.
*   ls_oe_hierarchie_new-
        ls_oe_hierarchie_new-name = ls_nbau-bauna.
        ls_oe_hierarchie_new-bauid = ls_nbau-bauid.
        ls_oe_hierarchie_new-type = 'BU'.
        ls_oe_hierarchie_new-nbau = ls_nbau.
        ls_oe_hierarchie_new-assig = ls_tn11o-assig.
*   l_tabix_new = l_tabix_new + 1.
        INSERT ls_oe_hierarchie_new INTO lt_oe_hierarchie INDEX l_tabix_new.
        l_tabix_new = l_tabix_new.
*   now handle the BU
        l_level = ls_oe_hierarchie_new-hier_level + 1.
        LOOP AT lt_tn11h INTO ls_tn11h
          WHERE uebbe = ls_nbau-bauid.
          CLEAR ls_oe_hierarchie_new.
          ls_oe_hierarchie_new-hier_level = l_level.
          READ TABLE lt_nbau INTO ls_nbau_tmp
            WITH KEY bauid = ls_tn11h-untbe.
          READ TABLE lt_tn11b INTO ls_tn11b
            WITH KEY bautex = ls_nbau_tmp-bauty.
          ls_oe_hierarchie_new-zimkz = ls_tn11b-zimkz.
          ls_oe_hierarchie_new-betkz = ls_tn11b-betkz.
          ls_oe_hierarchie_new-name = ls_nbau_tmp-bauna.
          ls_oe_hierarchie_new-bauid = ls_nbau_tmp-bauid.
          ls_oe_hierarchie_new-type = 'BU'.
          ls_oe_hierarchie_new-nbau = ls_nbau_tmp.
          l_tabix_new = l_tabix_new + 1.
          INSERT ls_oe_hierarchie_new INTO lt_oe_hierarchie INDEX l_tabix_new.
*     hier müsste die Behandlung der TN11B rekursiv aufgerufen werden.
        ENDLOOP.

      ENDLOOP.
      IF sy-subrc <> 0.
        l_tabix_new = l_tabix_new + 1.
      ENDIF.
    ENDLOOP.

  ENDIF.
  rt_ou_hier = lt_oe_hierarchie.

ENDMETHOD.


METHOD get_t100_attr.
* STC, Nov.2006
*
* This method extracts an attribute value from a T100 Message.
* Usually, the attribute values of a T100 message structure *should*
*   contain the name of an attribute. The value of that attribute
*   will then be inserted into the message of the exception.
*
* However, existing code uses this construct incorrectly and instead
*   storing another attribute for storing message parameters, some
*   existing code will store the message parameter directly inside of
*   the T100 strcucture.
*
* This method will check, if the given T100 attribute Value is the
*   name of a member variable of the given exception class. If that is
*   the case than the value of that member variable will be returned
*   (this indirect way is the basis had intended the T100 Construct).
*
* If the Value of the T100 attribute is not the name of an attribute of
*   the exception class, then the value of the T100 attribute will be
*   returned directly.
*

  IF ( i_att IS INITIAL ) OR ( ir_exc IS NOT BOUND ).
    CLEAR r_result.
    RETURN.
  ENDIF.

  FIELD-SYMBOLS <fs> TYPE simple.                           " MED-65981 note 2542261
  TRY.
*     check, if an instance member exists with the given name
*     -> if so: return the value of that member
      ASSIGN ir_exc->(i_att) TO <fs>.
      IF <fs> IS ASSIGNED.
        r_result = <fs>.
        RETURN.
      ENDIF.
    CATCH cx_root.                                      "#EC NO_HANDLER
  ENDTRY.

* class member lookup was unsuccessful for an attribute of the given name
*   -> return the input value; this itself must contain the message parameter
  r_result = i_att.

ENDMETHOD.


METHOD get_telephone_number_of_user.

* definitions
  DATA: ls_adr           TYPE addr3_val,
        l_string(80)     TYPE c,
        l_text(9)        TYPE c.
* ---------- ---------- ----------
* initialize
  CLEAR: e_number, e_number_descr.
* ---------- ---------- ----------
  CALL FUNCTION 'SUSR_USER_ADDRESS_READ'
    EXPORTING
      user_name              = i_user
    IMPORTING
      user_address           = ls_adr
    EXCEPTIONS
      user_address_not_found = 1
      OTHERS                 = 2.
  CHECK sy-subrc = 0.
* ---------- ---------- ----------
* return telephone number
  e_number = ls_adr-tel_extens.
  CHECK NOT e_number IS INITIAL.
* ---------- ---------- ----------
* prepare telephone number for output
  CLEAR l_string.
  l_string    = e_number.
  l_string+40 = ')'.
  CONDENSE l_string NO-GAPS.
  l_text      = text-001.
  CONCATENATE l_text l_string INTO l_string.
  CONDENSE l_string.
  e_number_descr    = l_string.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_user_name.

* ---------- ---------- ----------
* maybe there is an existing function ????
* ---------- ---------- ----------

* definitions
  DATA: l_persnr               TYPE usr21-persnumber,
        ls_addr                TYPE v_addr_usr.
* ---------- ---------- ----------
* initialize
  CLEAR: r_name.
** ---------- ---------- ----------
** get persnr of user
*  SELECT SINGLE persnumber FROM usr21 INTO l_persnr
*     WHERE bname = i_user.
*  CHECK sy-subrc = 0.
** ---------- ---------- ----------
** now get name
*  SELECT SINGLE name_text FROM adrp INTO r_name
*     WHERE persnumber = l_persnr.
** ---------- ---------- ----------
  CALL FUNCTION 'SUSR_SHOW_USER_DETAILS'
    EXPORTING
      bname      = i_user
      no_display = on
    IMPORTING
      addr_usr   = ls_addr.
  r_name = ls_addr-name_text.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_value_of_data_ref .

* field symbols
  FIELD-SYMBOLS:
        <ls_data>           TYPE ANY,
        <l_field>           TYPE ANY.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* data reference is mandatory
  IF ir_data_ref IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  ASSIGN ir_data_ref->* TO <ls_data>.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  ASSIGN COMPONENT i_fieldname OF STRUCTURE <ls_data>
     TO <l_field>.
  IF sy-subrc = 0.
*   return value
    e_value = <l_field>.
  ELSE.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD handle_warnings .
  DATA: l_max_errortype TYPE text15,
        lt_msg          TYPE ishmed_t_messages,
        l_msg           TYPE rn1message.

* initialize
  e_display_messages = on.
  e_only_warnings_exist = off.
* get messages
  CALL METHOD ir_errorhandler->get_messages
    IMPORTING
      t_extended_msg = lt_msg.
* warnings were accepted by using a specific function
* in the message handler screen; the warnings saved before
* could be ignored now
  IF cs_handle_warning-accept = on.
    LOOP AT cs_handle_warning-msg INTO l_msg.
      IF i_ignore_object EQ on.
        DELETE lt_msg WHERE type       = l_msg-type
                      AND   id         = l_msg-id
                      AND   number     = l_msg-number
                      AND   message_v1 = l_msg-message_v1
                      AND   message_v2 = l_msg-message_v2
                      AND   message_v3 = l_msg-message_v3
                      AND   message_v4 = l_msg-message_v4.
      ELSE.
        DELETE lt_msg WHERE type       = l_msg-type
                      AND   id         = l_msg-id
                      AND   number     = l_msg-number
                      AND   message_v1 = l_msg-message_v1
                      AND   message_v2 = l_msg-message_v2
                      AND   message_v3 = l_msg-message_v3
                      AND   message_v4 = l_msg-message_v4
                      AND   object     = l_msg-object.
      ENDIF.
    ENDLOOP.
    DESCRIBE TABLE lt_msg.
    IF sy-tfill < 1.
      e_only_warnings_exist = on.
      e_display_messages = off.
      EXIT.
    ENDIF.
  ENDIF.

* save warnings
  CLEAR: cs_handle_warning.
  cs_handle_warning-okcode = i_okcode.
  CALL METHOD ir_errorhandler->get_messages
    IMPORTING
      t_extended_msg = cs_handle_warning-msg.
  CLEAR: l_max_errortype.
  LOOP AT cs_handle_warning-msg INTO l_msg.
    IF l_msg-type CO 'EA'.
*     indicate existing errors
      CLEAR cs_handle_warning.
      e_only_warnings_exist = off.
      EXIT.
    ENDIF.
    e_only_warnings_exist = on.
  ENDLOOP.
ENDMETHOD.


  METHOD is_background.
* BEGIN MED-53385
    DATA l_is_gui_on      TYPE answer.

    CALL FUNCTION 'RFC_IS_GUI_ON'
      EXPORTING
        login_check = abap_false       " Überprüfung der erfolgreichen Anmeldung (X=Ja/Space=Nein)
      IMPORTING
        on          = l_is_gui_on.     " Verfügt die Sitzung über eine Gui ? (Y=Yes, N= No)

    r_value = boolc( sy-batch    EQ abap_true OR
                     sy-binpt    EQ abap_true OR
                     l_is_gui_on EQ 'N' ).
* END MED-53385
  ENDMETHOD.


METHOD is_gui_control_valid.

  DATA: l_result    TYPE i.

* if gui-control isn't bound it's not valid
  CHECK ir_gui_control IS BOUND.

* check if gui-control is valid
  CALL METHOD ir_gui_control->is_valid
    IMPORTING
      RESULT = l_result.
  IF l_result = 0.
    r_valid = off.
  ELSE.
    r_valid = on.
  ENDIF.

ENDMETHOD.


METHOD is_interface_implemented .

* definitions
  DATA: l_index         TYPE i,
        l_len           TYPE i,
        l_flag          TYPE ish_on_off,
        l_char(1)       TYPE c.
* workares
  FIELD-SYMBOLS:
        <ls_if>         TYPE abap_intfdescr.
* object references
  DATA: lr_descr        TYPE REF TO cl_abap_typedescr,
        lr_class_descr  type ref to CL_ABAP_CLASSDESCR.
* ---------- ---------- ----------
* initialize
  r_is_implemented = off.
* ---------- ---------- ----------
* object and name of interface are mandatory
  CHECK NOT ir_object        IS INITIAL AND
        NOT i_interface_name IS INITIAL.
* ---------- ---------- ----------
* get description of class
  CALL METHOD cl_abap_classdescr=>describe_by_object_ref
    EXPORTING
      p_object_ref         = ir_object
    RECEIVING
      p_descr_ref          = lr_descr
    EXCEPTIONS
      reference_is_initial = 1
      OTHERS               = 2.
  CHECK sy-subrc = 0.
  lr_class_descr ?= lr_descr.
  READ TABLE lr_class_descr->interfaces ASSIGNING <ls_if>
     WITH KEY name = i_interface_name.
  IF sy-subrc = 0.
    r_is_implemented = on.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD is_numeric .

* definitions
  DATA: l_index         TYPE i,
        l_len           TYPE i,
        l_flag          TYPE ish_on_off,
        l_has_num       TYPE ish_on_off,
        l_char(1)       TYPE c.
* object references
  DATA: lr_descr        TYPE REF TO cl_abap_typedescr.
* ---------- ---------- ----------
* initialize
  r_numeric = on.
* ---------- ---------- ----------
* get description (length) of given value
  lr_descr = cl_abap_typedescr=>describe_by_data( i_value ).
  l_len = lr_descr->length.
* ---------- ---------- ----------
  SHIFT i_value LEFT DELETING LEADING ' '.
  l_index = 1.
  CLEAR: l_flag, l_has_num.
  WHILE l_index <= l_len.
*   notice if string contains a space
    l_char = i_value(1).
    IF l_char = ' '.
      l_flag = on.
    ELSEIF l_char CO '0123456789'.
*     if there was a space before this number => error
      IF l_flag = on.
        r_numeric = off.
        EXIT.
      ENDIF.
      l_has_num = on.
    ELSE.
      r_numeric = off.
      EXIT.
    ENDIF.
    l_index = l_index + 1.
    SHIFT i_value BY 1 PLACES.
  ENDWHILE.
* ---------- ---------- ----------
* check for containing numbers
  IF l_has_num = off.
    r_numeric = off.
  ENDIF.
ENDMETHOD.


METHOD is_obj_op .

* definitions
  DATA: l_rc                   TYPE ish_method_rc,
        l_is_impl              TYPE ish_on_off.
* object references
  DATA: lr_is_op               TYPE REF TO if_ish_is_op.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  CLEAR: e_is_op.
* ---------- ---------- ----------
* object is mandatory
  IF ir_object IS INITIAL.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* check if objeckt implement interface "IF_ISH_IS_OP"
  CALL METHOD cl_ish_utl_base=>is_interface_implemented
    EXPORTING
      ir_object        = ir_object
      i_interface_name = 'IF_ISH_IS_OP'
    RECEIVING
      r_is_implemented = l_is_impl.
  CHECK l_is_impl = on.
* cast object
  lr_is_op ?= ir_object.
* ---------- ---------- ----------
* -> if yes call method "is_op" of interface
  CALL METHOD lr_is_op->is_op
    IMPORTING
      e_is_op         = e_is_op
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD is_ou_coord_unit.
*New/PN/MED-39901/2010/06/15

  DATA: ls_norg     TYPE norg.

  e_is_coord_unit = off.

  CHECK i_orgid IS NOT INITIAL OR is_norg IS NOT INITIAL.

* get data
  IF is_norg IS NOT INITIAL.
    ls_norg = is_norg.
  ELSE.
    CALL METHOD cl_ish_dbr_org=>get_org_by_orgid
      EXPORTING
        i_orgid         = i_orgid
      IMPORTING
        es_norg         = ls_norg
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* do check
  CHECK ls_norg-ambes <> on AND
        ls_norg-n1erbrkz <> on AND
        ls_norg-n1dikz = on AND
        ls_norg-n1anfkz = on.

* is coord unit
  e_is_coord_unit = on.

ENDMETHOD.


METHOD is_t_error_derived_from.

* local tabels
  DATA: lt_error         TYPE ishmed_t_objtype_n1error,
        lt_messages      TYPE ishmed_t_messages.
* definitions
  DATA: l_rc             TYPE ish_method_rc,
        l_no             TYPE ish_on_off,
        l_is_error_derived     TYPE ish_on_off,
        l_is_inherited         TYPE ish_on_off,
        l_derived        TYPE ish_on_off,
        l_inherited      TYPE ish_on_off,
        l_err_obj        TYPE ish_on_off.
* workareas
  DATA: ls_messages      LIKE LINE OF lt_messages.
  FIELD-SYMBOLS:
        <ls_error>       LIKE LINE OF lt_error,
        <ls_messages>    LIKE LINE OF lt_messages.

* initialization
  e_derived = off.
  e_all_derived = on.
  CLEAR: lt_messages, l_err_obj.

* check for valid instance of errorhandler
  CHECK ir_errorhandler IS NOT INITIAL OR
        ir_error_obj IS NOT INITIAL OR
        it_messages IS NOT INITIAL.

* check for entries in tables
  CHECK it_error_derived IS NOT INITIAL OR
        it_error_inherited IS NOT INITIAL.

* get all messages
  IF ir_errorhandler IS NOT INITIAL.
    CALL METHOD ir_errorhandler->get_messages
      IMPORTING
        t_extended_msg = lt_messages.
  ELSEIF it_messages IS NOT INITIAL.
    lt_messages = it_messages.
  ELSE.
    CLEAR: ls_messages.
    ls_messages-error_obj = ir_error_obj.
    APPEND ls_messages TO lt_messages.
    l_err_obj = on.
  ENDIF.

  LOOP AT lt_messages ASSIGNING <ls_messages>.
    CLEAR: l_derived, l_inherited.

*   check for other messages than given categories
    IF <ls_messages>-error_obj IS INITIAL.
      e_all_derived = off.
      CONTINUE.
    ENDIF.

*   check for derived errors
    LOOP AT it_error_derived ASSIGNING <ls_error>.
*     check for inheritance of the error instance
      l_is_inherited =
    <ls_messages>-error_obj->if_ish_identify_object~is_inherited_from(
            i_object_type = <ls_error>-objtype ).
*     check for derived error code
      l_is_error_derived =
         <ls_messages>-error_obj->is_error_derived_from(
            i_error = <ls_error>-error ).
      IF l_is_inherited = on AND l_is_error_derived = on.
        l_derived = on.
        EXIT.
      ENDIF.
    ENDLOOP.

*   check for inherited errors
    LOOP AT it_error_inherited ASSIGNING <ls_error>.
*     check for inheritance of the error instance
      l_is_inherited =
    <ls_messages>-error_obj->if_ish_identify_object~is_inherited_from(
            i_object_type = <ls_error>-objtype ).
*     check for derived error code
      l_is_error_derived =
         <ls_messages>-error_obj->is_error_inherited_from(
            i_error = <ls_error>-error ).
      IF l_is_inherited = on AND l_is_error_derived = on.
        l_inherited = on.
        EXIT.
      ENDIF.
    ENDLOOP.

*   check for other messages than given categories
    IF l_derived = on OR l_inherited = on.
      e_derived = on.
      IF l_err_obj = off.
        APPEND <ls_messages> TO et_messages.
      ENDIF.
    ELSE.
      e_all_derived = off.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


method MAX_SESSIONS_CHECK.

  data act_sessions TYPE SM04DIC-COUNTER.
  data max_sessions TYPE SM04DIC-COUNTER.
*
  e_limit_reached = off.
  CALL FUNCTION 'TH_USER_INFO'
    EXPORTING
      CHECK_GUI    = 1
    IMPORTING
      ACT_SESSIONS = act_sessions
      MAX_SESSIONS = max_sessions.
  IF act_sessions >= max_sessions.
    e_limit_reached = on.
  ENDIF.
endmethod.


METHOD message_text_split.
  DATA: lt_lines TYPE trtexts,
        ls_lines TYPE char80.
*---------------------------------------------------------------------*
* Inizialization                                                      *
*---------------------------------------------------------------------*
*
  CLEAR: e_msgvar1, e_msgvar2, e_msgvar3, e_msgvar4.

  IF i_text IS INITIAL.
    RETURN.
  ENDIF.
*
*---------------------------------------------------------------------*
* Splitting Text into lines of 50 digits length                       *
*---------------------------------------------------------------------*
*
  CALL FUNCTION 'TR_SPLIT_TEXT'
    EXPORTING
      iv_text  = i_text
      iv_len   = 50
    IMPORTING
      et_lines = lt_lines.
*
*---------------------------------------------------------------------*
* Supplying message variables                                         *
*---------------------------------------------------------------------*
*
  READ TABLE lt_lines INTO ls_lines INDEX 1.
  CHECK sy-subrc IS INITIAL.
  e_msgvar1 = ls_lines.
*
  READ TABLE lt_lines INTO ls_lines INDEX 2.
  CHECK sy-subrc IS INITIAL.
  e_msgvar2 = ls_lines.
*
  READ TABLE lt_lines INTO ls_lines INDEX 3.
  CHECK sy-subrc IS INITIAL.
  e_msgvar3 = ls_lines.
*
  READ TABLE lt_lines INTO ls_lines INDEX 4.
  CHECK sy-subrc IS INITIAL.
  e_msgvar4 = ls_lines.
*

ENDMETHOD.


METHOD normalize_string.

  r_string = i_string.

  TRANSLATE r_string TO UPPER CASE.

ENDMETHOD.


METHOD remove_messages .

  DATA: lt_msg            TYPE ishmed_t_messages,
        lt_msg_rem        TYPE ishmed_t_messages,
        ls_msg_rem        LIKE LINE OF lt_msg_rem,
        l_deleted         TYPE ish_on_off,
        l_derived         TYPE ish_on_off.
  FIELD-SYMBOLS:
        <ls_msg>          LIKE LINE OF lt_msg.

  REFRESH: lt_msg, lt_msg_rem.

  l_deleted = off.

  CHECK NOT cr_errorhandler IS INITIAL.

  lt_msg_rem[] = it_messages[].

  IF NOT i_id IS INITIAL AND NOT i_number IS INITIAL.
    CLEAR ls_msg_rem.
    ls_msg_rem-id     = i_id.
    ls_msg_rem-number = i_number.
    APPEND ls_msg_rem TO lt_msg_rem.
  ENDIF.

  CALL METHOD cr_errorhandler->get_messages
    IMPORTING
      t_extended_msg = lt_msg.

  IF NOT lt_msg_rem IS INITIAL.
    LOOP AT lt_msg_rem INTO ls_msg_rem.
      DELETE lt_msg WHERE id     = ls_msg_rem-id
                      AND number = ls_msg_rem-number.
      IF sy-subrc = 0.
        l_deleted = on.
      ENDIF.
    ENDLOOP.
  ELSEIF NOT it_err_der_except IS INITIAL OR
     NOT it_err_inh_except IS INITIAL.
    LOOP AT lt_msg ASSIGNING <ls_msg>.
      CLEAR: l_derived.
      IF NOT <ls_msg>-error_obj IS INITIAL.
        CALL METHOD cl_ish_utl_base=>is_t_error_derived_from
          EXPORTING
            it_error_derived   = it_err_der_except
            it_error_inherited = it_err_inh_except
            ir_error_obj       = <ls_msg>-error_obj
          IMPORTING
            e_derived          = l_derived.
      ENDIF.

      IF l_derived = off.
        DELETE lt_msg.
        l_deleted = on.
      ENDIF.
    ENDLOOP.
  ENDIF.

  CHECK l_deleted = on.

  CALL METHOD cr_errorhandler->initialize.

  CHECK NOT lt_msg[] IS INITIAL.

  CALL METHOD cr_errorhandler->collect_messages
    EXPORTING
      t_messages = lt_msg.

ENDMETHOD.


METHOD SET_MESSAGE_BY_SYST .

  rs_message-msgid = sy-msgid.
  rs_message-msgno = sy-msgno.
  rs_message-attr1 = sy-msgv1.
  rs_message-attr2 = sy-msgv2.
  rs_message-attr3 = sy-msgv3.
  rs_message-attr4 = sy-msgv4.

ENDMETHOD.


METHOD set_value_to_data_ref.

* field symbols
  FIELD-SYMBOLS:
        <ls_data>           TYPE ANY,
        <l_field>           TYPE ANY.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* data reference is mandatory
  IF ir_data_ref IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  ASSIGN ir_data_ref->* TO <ls_data>.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  ASSIGN COMPONENT i_fieldname OF STRUCTURE <ls_data>
     TO <l_field>.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* set value
  <l_field> = i_value.
* ---------- ---------- ----------

ENDMETHOD.


METHOD switch_on_off_to_true_false .

  IF i_on_off = on.
    r_true_false = true.
  ELSEIF i_on_off = off.
    r_true_false = false.
  ENDIF.

ENDMETHOD.
ENDCLASS.
