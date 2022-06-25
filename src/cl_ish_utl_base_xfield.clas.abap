class CL_ISH_UTL_BASE_XFIELD definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_UTL_BASE_XFIELD
*"* do not include other source files here!!!
public section.
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

  class-methods ADJUST_XFIELDS
    importing
      value(I_FORCE) type ISH_ON_OFF default OFF
      value(I_DATA_NAME) type STRING optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_XFIELDS_CHANGED) type ISH_ON_OFF
    changing
      !CS_DATA_X type ANY optional
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CHANGE_XSTRUCTURE
    importing
      value(IS_DATA_X) type ANY
      value(IT_FIELDNAME_MAPPING) type ISH_T_FIELDNAME_MAPPING optional
      value(I_DATA_NAME) type STRING optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CS_DATA) type ANY
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_UTL_BASE_XFIELD
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_BASE_XFIELD
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_BASE_XFIELD IMPLEMENTATION.


METHOD ADJUST_XFIELDS .

  DATA: lt_ddfields     TYPE ddfields,
        l_data_name     TYPE string,
        l_any_xflag_set TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_dfies>  TYPE dfies,
                 <l_field>   TYPE ANY.

* Initializations
  CLEAR: e_rc.
*Sta/PN/15977/2005/02/22
  CLEAR: e_xfields_changed.
*End/PN/15977/2005/02/22
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  l_data_name = i_data_name.
  IF l_data_name IS INITIAL.
    l_data_name = 'CS_DATA_X'.
  ENDIF.

* Get the DDIC info for cs_data_x.
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct
    EXPORTING
      is_data         = cs_data_x
      i_data_name     = l_data_name
      ir_object       = ir_object
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

  CHECK e_rc = 0.

  l_any_xflag_set = off.

* Determine if any xflag is set
* but only if necessary.
  IF i_force = off AND
     NOT cs_data_x IS INITIAL.
    LOOP AT lt_ddfields ASSIGNING <ls_dfies>
            WHERE ( rollname = 'ISHMED_CHANGE'  OR
                    rollname = 'BAPIUPDATE'     OR
                    rollname = 'ISH_MOVE_FIELD' ).
      ASSIGN COMPONENT <ls_dfies>-fieldname
        OF STRUCTURE cs_data_x
        TO <l_field>.
      IF <l_field> = on.
        l_any_xflag_set = on.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDIF.

* Any xflag set -> no further processing needed.
  CHECK l_any_xflag_set = off.

* No xflag set -> set all xflags.
  LOOP AT lt_ddfields ASSIGNING <ls_dfies>
          WHERE ( rollname = 'ISHMED_CHANGE'  OR
                  rollname = 'BAPIUPDATE'     OR
                  rollname = 'ISH_MOVE_FIELD' ).
    ASSIGN COMPONENT <ls_dfies>-fieldname
      OF STRUCTURE cs_data_x
      TO <l_field>.
    <l_field> = on.
*Sta/PN/15977/2005/02/22
    e_xfields_changed = on.
*End/PN/15977/2005/02/22
  ENDLOOP.

ENDMETHOD.


METHOD CHANGE_XSTRUCTURE.

* local tables
  DATA: lt_ddfields              TYPE ddfields.
* workareas
  FIELD-SYMBOLS:
        <ls_dfies>               TYPE dfies,
        <ls_fieldname_mapping>   TYPE rn1_fieldname_mapping.
* definitions
  DATA: l_rc                     TYPE ish_method_rc,
        l_data_name              TYPE string,
        l_fieldname              TYPE fieldname,
        l_fieldname_x            TYPE fieldname,
        l_fieldname_xx           TYPE fieldname.
* fieldy-symbols
  FIELD-SYMBOLS:
        <ls_data_tmp>            TYPE ANY,
        <l_field>                TYPE ANY,
        <l_field_x>              TYPE ANY,
        <l_field_xx>             TYPE ANY.
* object references
  DATA: lr_data_tmp              TYPE REF TO data.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
  l_data_name = i_data_name.
  IF l_data_name IS INITIAL.
    l_data_name = 'CS_DATA'.
  ENDIF.
* ---------- ---------- ----------
* wrk on temporary data.
  CREATE DATA lr_data_tmp LIKE cs_data.
  ASSIGN lr_data_tmp->* TO <ls_data_tmp>.
  <ls_data_tmp> = cs_data.
* ---------- ---------- ----------
* get ddic info for cs_data
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
* ---------- ---------- ----------
* change fields
  LOOP AT lt_ddfields ASSIGNING <ls_dfies>.
*   ---------- ----------
*   l_fieldname: Fieldname in cs_data structure.
    l_fieldname = <ls_dfies>-fieldname.
*   ---------- ----------
*   l_fieldname_x:  fieldname in is_data_x structure.
*   l_fieldname_xx: fieldname of the x-flag field in is_data_x.
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
*   ---------- ----------
*   only change if x-flag in importing structure is set
    ASSIGN COMPONENT l_fieldname_xx
      OF STRUCTURE is_data_x
      TO <l_field_xx>.
    CHECK sy-subrc = 0.
    CHECK <l_field_xx> = on.
*   ---------- ----------
*   get value of field from importing structure
    ASSIGN COMPONENT l_fieldname_x
      OF STRUCTURE is_data_x
      TO <l_field_x>.
    CHECK sy-subrc = 0.
*   ---------- ----------
*   get value of field from changing structure
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_data_tmp>
      TO <l_field>.
    CHECK sy-subrc = 0.
*   ---------- ----------
*   set field
    <l_field> = <l_field_x>.
*   ---------- ----------
*   set x-flag in changing structure
    CONCATENATE l_fieldname '_X' INTO l_fieldname.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_data_tmp>
      TO <l_field>.
    CHECK sy-subrc = 0.
    <l_field> = <l_field_xx>.
*   ---------- ----------
  ENDLOOP.
* ---------- ---------- ----------
  CHECK e_rc = 0.
* ---------- ---------- ----------
* return changed x-structure
  cs_data = <ls_data_tmp>.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
