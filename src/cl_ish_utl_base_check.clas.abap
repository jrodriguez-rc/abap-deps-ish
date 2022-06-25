class CL_ISH_UTL_BASE_CHECK definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_UTL_BASE_CHECK
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

  class-methods CHECK_CHANGES
    importing
      value(IS_DATA_NEW) type ANY
      value(IS_DATA_OLD) type ANY
      value(IT_FIELDNAME_IGNORE) type FIELDNAME_TAB optional
      value(IT_FIELDNAME_MAPPING) type ISH_T_FIELDNAME_MAPPING optional
      value(I_DATA_NAME) type STRING optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_CHANGED) type ISH_ON_OFF
      value(ET_CHANGED_FIELDS) type DDFIELDS
    changing
      !CS_DATA_X type ANY optional
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CHECK_FIXED_VALUES
    importing
      !I_DATA type SIMPLE
    returning
      value(R_RESULT) type ABAP_BOOL
    exceptions
      NO_DDIC_TYPE
      NOT_SUPPORTED .
  class-methods CHECK_TIME
    importing
      value(I_TIME) type T
      value(I_PARAM) type BAPI_PARAM
      value(I_FIELD) type BAPI_FLD
      value(I_ROW) type BAPI_LINE optional
      !I_OBJECT type N1OBJECTREF optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_UTL_BASE_CHECK
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_BASE_CHECK
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_BASE_CHECK IMPLEMENTATION.


METHOD CHECK_CHANGES .

  DATA: l_rc            TYPE ish_method_rc,
        lt_ddfields     TYPE ddfields,
        l_data_name     TYPE string,
        l_fieldname     TYPE fieldname,
        l_fieldname_x   TYPE fieldname,
        l_fieldname_xx  TYPE fieldname,
        l_mode_dummy    TYPE c,
        lr_structdescr  TYPE REF TO cl_abap_structdescr.

  FIELD-SYMBOLS: <ls_dfies>             TYPE dfies,
                 <l_field_old>          TYPE ANY,
                 <l_field_new>          TYPE ANY,
                 <l_mode>               TYPE ANY,
                 <l_field_x>            TYPE ANY,
                 <l_field_xx>           TYPE ANY,
                 <ls_fieldname_mapping> TYPE rn1_fieldname_mapping.

* Initializations
  CLEAR: cs_data_x,
         e_rc,
         e_changed.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  l_data_name = i_data_name.
  IF l_data_name IS INITIAL.
    l_data_name = 'IS_DATA_NEW'.
  ENDIF.

* Get the DDIC info for is_data_new (and is_data_old).
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct
    EXPORTING
      is_data         = is_data_new
      i_data_name     = l_data_name
      ir_object       = ir_object
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

  CHECK e_rc = 0.

* Now check each field for changes.
  LOOP AT lt_ddfields ASSIGNING <ls_dfies>.

*   l_fieldname: Fieldname in is_data_new/old structure.
    l_fieldname = <ls_dfies>-fieldname.

*   l_fieldname_x:  Fieldname in cs_data_x structure.
*   l_fieldname_xx: Fieldname of the X-flag field in cs_data_x.
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

*   Assign new and old field.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE is_data_new
      TO <l_field_new>.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE is_data_old
      TO <l_field_old>.

*   Changed?
    IF e_changed = off AND
       <l_field_new> <> <l_field_old>.
      e_changed = on.
    ENDIF.

*   If cs_data_x is not requested and et_changed_fields is not requested
*   and any field changed -> do not process any further fields.
    IF NOT cs_data_x         IS SUPPLIED AND
       NOT et_changed_fields IS SUPPLIED AND
       e_changed = on.
      EXIT.
    ENDIF.

*   Handle et_changed_fields.
    IF et_changed_fields IS SUPPLIED AND
       <l_field_new> <> <l_field_old>.
      APPEND <ls_dfies> TO et_changed_fields.
    ENDIF.

*   Further processing for this field only if requested.
    CHECK cs_data_x IS SUPPLIED.

*   Handle field in cs_data_x.
    ASSIGN COMPONENT l_fieldname_x
      OF STRUCTURE cs_data_x
      TO <l_field_x>.
*   If field does not exist in cs_data_x -> ignore this field
    CHECK sy-subrc = 0.
    <l_field_x> = <l_field_new>.

*   Handle X-Flag in cs_data_x.
    ASSIGN COMPONENT l_fieldname_xx
      OF STRUCTURE cs_data_x
      TO <l_field_xx>.
    IF sy-subrc = 0.
      IF <l_field_new> <> <l_field_old>.
        <l_field_xx> = on.
      ELSE.
        <l_field_xx> = off.
      ENDIF.
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD CHECK_FIXED_VALUES .

  DATA: l_descr     TYPE REF TO cl_abap_typedescr,
        l_elemdescr TYPE REF TO cl_abap_elemdescr,
        l_fixvalues TYPE ddfixvalues,
        l_ddic      TYPE abap_bool.

  FIELD-SYMBOLS:
        <fs>        TYPE LINE OF ddfixvalues.

* initialization
  r_result = abap_false.

  CALL METHOD cl_abap_elemdescr=>describe_by_data
    EXPORTING
      p_data      = i_data
    RECEIVING
      p_descr_ref = l_descr.

* check ddic for ddic type
  CALL METHOD l_descr->is_ddic_type
    RECEIVING
      p_abap_bool = l_ddic.

  IF l_ddic = abap_false.
    RAISE no_ddic_type.
  ENDIF.

* cast type to elementar description class
  TRY.
      l_elemdescr ?= l_descr.
    CATCH cx_sy_move_cast_error.
      RAISE not_supported.
  ENDTRY.

* get table with fixed values
  CALL METHOD l_elemdescr->get_ddic_fixed_values
    EXPORTING
      p_langu        = sy-langu
    RECEIVING
      p_fixed_values = l_fixvalues
  EXCEPTIONS
    not_found      = 1
*    NO_DDIC_TYPE   = 2
*    others         = 3
          .
  IF sy-subrc = 1.
    r_result = abap_true.
  ENDIF.

* compare value and fixed values table
  LOOP AT l_fixvalues ASSIGNING <fs>.
    IF <fs>-option = 'EQ'.
      IF i_data = <fs>-low.
        r_result = abap_true.
        RETURN.
      ENDIF.
    ENDIF.

    IF <fs>-option = 'BT'.
      IF i_data >= <fs>-low AND i_data <= <fs>-high.
        r_result = abap_true.
        RETURN.
      ENDIF.
    ENDIF.

  ENDLOOP.




ENDMETHOD.


METHOD CHECK_TIME .
* definitions
  DATA: l_rc              TYPE i,
        l_time_output(08) TYPE c.
* ---------- ---------- ----------
* initialization
  e_rc = 0.
* ---------- ---------- ----------
* create errorhanlder if required
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* check given time
  IF i_time EQ space.
*     message e069(00).
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ    = 'E'
        i_kla    = '00'
        i_num    = '069'
        i_par    = i_param
        i_fld    = i_field
        i_row    = i_row
        i_object = i_object
        i_last   = space.
    e_rc = 1.
  ELSE.
    WRITE i_time TO l_time_output USING EDIT MASK '__:__:__'.
    CALL FUNCTION 'CONVERT_TIME_INPUT'
      EXPORTING
        input  = l_time_output
      EXCEPTIONS
        OTHERS = 1.
    IF sy-subrc NE 0.
*     message e069(00).
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ    = 'E'
          i_kla    = '00'
          i_num    = '069'
          i_par    = i_param
          i_fld    = i_field
          i_row    = i_row
          i_object = i_object
          i_last   = space.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ    = 'E'
          i_kla    = sy-msgid
          i_num    = sy-msgno
          i_mv1    = sy-msgv1
          i_mv2    = sy-msgv2
          i_mv3    = sy-msgv3
          i_mv4    = sy-msgv4
          i_par    = i_param
          i_fld    = i_field
          i_row    = i_row
          i_object = i_object
          i_last   = space.
      e_rc = 1.
      EXIT.
    ENDIF.
  ENDIF.   "IF i_time IS INITIAL OR
ENDMETHOD.
ENDCLASS.
