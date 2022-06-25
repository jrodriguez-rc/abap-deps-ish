class CL_ISH_UTL_GUI_STRUCTURE_MODEL definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_UTL_GUI_STRUCTURE_MODEL
*"* do not include other source files here!!!
public section.

  type-pools ABAP .
  class-methods ASSIGN_CONTENT
    importing
      !I_SOURCE type ANY
    exporting
      !E_CHANGED type ABAP_BOOL
      !E_RC type ISH_METHOD_RC
    changing
      !C_TARGET type ANY .
  class-methods ASSIGN_FIELD_CONTENT
    importing
      !IR_MODEL type ref to IF_ISH_GUI_STRUCTURE_MODEL
      !I_SOURCE type ANY
      !I_FIELDNAME type ISH_FIELDNAME
      !I_ERROR_PAR type BAPIRET2-PARAMETER optional
      !IR_CB type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
    exporting
      !E_CHANGED type ABAP_BOOL
    changing
      !C_TARGET type ANY
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods GET_FIELD_CONTENT
    importing
      !IR_MODEL type ref to IF_ISH_GUI_STRUCTURE_MODEL
      !IS_DATA type DATA
      !I_FIELDNAME type ISH_FIELDNAME
    changing
      !C_CONTENT type ANY
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods GET_SUPPORTED_FIELDS
    importing
      !IS_DATA type DATA
    returning
      value(RT_SUPPORTED_FIELDNAME) type ISH_T_FIELDNAME .
  class-methods IS_ASSIGNMENT_ALLOWED
    importing
      !I_SOURCE type ANY
      !I_TARGET type ANY
    returning
      value(R_ALLOWED) type I .
  class-methods IS_FIELD_SUPPORTED
    importing
      !IS_DATA type DATA
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_SUPPORTED) type ABAP_BOOL .
  class-methods SET_DATA
    importing
      !IS_SOURCE_DATA type DATA
    exporting
      !ET_CHANGED_FIELD type ISH_T_FIELDNAME
    changing
      !CS_TARGET_DATA type DATA
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods SET_FIELD_CONTENT
    importing
      !IR_MODEL type ref to IF_ISH_GUI_STRUCTURE_MODEL
      !I_FIELDNAME type ISH_FIELDNAME
      !I_CONTENT type ANY
      !IR_CB type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
    exporting
      value(E_CHANGED) type ABAP_BOOL
    changing
      !CS_DATA type DATA
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_UTL_GUI_STRUCTURE_MODEL
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_GUI_STRUCTURE_MODEL
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_GUI_STRUCTURE_MODEL IMPLEMENTATION.


METHOD assign_content.

* Use rtti-method.
  CALL METHOD cl_ish_utl_rtti=>assign_content
    EXPORTING
      i_source  = i_source
    IMPORTING
      e_rc      = e_rc
      e_changed = e_changed
    CHANGING
      c_target  = c_target.

ENDMETHOD.


METHOD assign_field_content.

  DATA l_allowed                TYPE i.
  DATA l_error_field            TYPE bapiret2-field.
  DATA lr_source_copy           TYPE REF TO data.

  FIELD-SYMBOLS <l_source_copy> TYPE any.

* The model has to be specified.
  IF ir_model IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'ASSIGN_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_UTL_GUI_STRUCTURE_MODEL' ).
  ENDIF.

* Check if assignment is allowed.
  l_allowed = is_assignment_allowed(
      i_source  = i_source
      i_target  = c_target ).
  IF l_allowed = 0.
    l_error_field = i_fieldname.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'ASSIGN_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_UTL_GUI_STRUCTURE_MODEL'
        i_par        = i_error_par
        i_field      = l_error_field
        ir_object    = ir_model ).
  ENDIF.

* Further processing only on changes.
  CREATE DATA lr_source_copy LIKE c_target.
  ASSIGN lr_source_copy->* TO <l_source_copy>.
  CASE l_allowed.
    WHEN 1.                       "Data
      <l_source_copy> = i_source.
    WHEN 2 OR 3.                  "Object and Data reference
      <l_source_copy> ?= i_source.
  ENDCASE.
  CHECK <l_source_copy> <> c_target.

* Callback.
  IF ir_cb IS BOUND.
    CHECK ir_cb->cb_set_field_content(
        ir_model    = ir_model
        i_fieldname = i_fieldname
        i_content   = i_source ) = abap_true.
  ENDIF.

* Assign the content.
  CASE l_allowed.
    WHEN 1.                       "Data
      c_target = i_source.
    WHEN 2 OR 3.                  "Object and Data reference
      c_target ?= i_source.
  ENDCASE.

* Export.
  e_changed = abap_true.

ENDMETHOD.


METHOD get_field_content.

  DATA lr_structdescr           TYPE REF TO cl_abap_structdescr.
  DATA l_error_field            TYPE bapiret2-field.
  DATA l_error_par              TYPE bapiret2-parameter.

  FIELD-SYMBOLS <l_content>     TYPE any.

* The model has to be specified.
  IF ir_model IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_UTL_GUI_STRUCTURE_MODEL' ).
  ENDIF.

* - - BEGIN REM C. Honeder MED-52958
* The following steps are just needed in case of an error.
* So move them into the if statement.
** Determine the structure descriptor for the given data.
*  TRY.
*      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = is_data ).
*    CATCH cx_sy_move_cast_error.
*      cl_ish_utl_exception=>raise_static(
*          i_typ        = 'E'
*          i_kla        = 'N1BASE'
*          i_num        = '030'
*          i_mv1        = '2'
*          i_mv2        = 'GET_FIELD_CONTENT'
*          i_mv3        = 'CL_ISH_UTL_GUI_STRUCTURE_MODEL'
*          ir_object    = ir_model ).
*  ENDTRY.
*
** Set error fields.
*  l_error_par   = lr_structdescr->get_relative_name( ).
*  l_error_field = i_fieldname.
* - - END REM C. Honeder MED-52958

* Assign the structure field.
  ASSIGN COMPONENT i_fieldname
    OF STRUCTURE is_data
    TO <l_content>.
  IF sy-subrc <> 0.
* - - BEGIN C. Honeder MED-52958
*   Get the additional error parameters.
*   Determine the structure descriptor for the given data.
    TRY.
        lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = is_data ).
      CATCH cx_sy_move_cast_error.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '2'
            i_mv2        = 'GET_FIELD_CONTENT'
            i_mv3        = 'CL_ISH_UTL_GUI_STRUCTURE_MODEL'
            ir_object    = ir_model ).
    ENDTRY.

*   Set error fields.
    l_error_par   = lr_structdescr->get_relative_name( ).
    l_error_field = i_fieldname.
* - - END C. Honeder MED-52958
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = 'GET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_UTL_GUI_STRUCTURE_MODEL'
        i_par        = l_error_par
        i_field      = l_error_field
        ir_object    = ir_model ).
  ENDIF.

* Assign the content.
  CALL METHOD assign_field_content
    EXPORTING
      ir_model    = ir_model
      i_source    = <l_content>
      i_fieldname = i_fieldname
      i_error_par = l_error_par
    CHANGING
      c_target    = c_content.

ENDMETHOD.


METHOD get_supported_fields.

  DATA lr_structdescr           TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname              TYPE ish_fieldname.

  FIELD-SYMBOLS <ls_component>  TYPE abap_compdescr.

* Determine the structure descriptor for the given data.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = is_data ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_structdescr IS BOUND.

* Return each fieldname of the structure.
  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
    INSERT l_fieldname INTO TABLE rt_supported_fieldname.
  ENDLOOP.

ENDMETHOD.


METHOD is_assignment_allowed.

* Use rtti-method.
  r_allowed = cl_ish_utl_rtti=>is_assignment_allowed( i_source = i_source
                                                      i_target = i_target ).

ENDMETHOD.


METHOD is_field_supported.

  DATA lt_supported_fieldname           TYPE ish_t_fieldname.

  lt_supported_fieldname = get_supported_fields( is_data = is_data ).

  READ TABLE lt_supported_fieldname FROM i_fieldname TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_supported = abap_true.

ENDMETHOD.


METHOD set_data.

  DATA lr_structdescr                     TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname                        TYPE ish_fieldname.

  FIELD-SYMBOLS <ls_component>            TYPE abap_compdescr.
  FIELD-SYMBOLS <l_source_field>          TYPE ANY.
  FIELD-SYMBOLS <l_target_field>          TYPE ANY.

  CLEAR et_changed_field.

* Get the structdescr (is_source_data + cs_target_data have to be of the same type).
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = is_source_data ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_structdescr.
  ENDTRY.
  IF lr_structdescr <> cl_abap_typedescr=>describe_by_data( p_data = cs_target_data ).
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_DATA'
        i_mv3        = 'CL_ISH_UTL_GUI_STRUCTURE_MODEL' ).
  ENDIF.

* Set data.
  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE is_source_data
      TO <l_source_field>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE cs_target_data
      TO <l_target_field>.
    CHECK sy-subrc = 0.
    CHECK <l_source_field> <> <l_target_field>.
    <l_target_field> = <l_source_field>.
    INSERT l_fieldname INTO TABLE et_changed_field.
  ENDLOOP.

ENDMETHOD.


METHOD set_field_content.

  DATA lr_structdescr           TYPE REF TO cl_abap_structdescr.
  DATA l_error_field            TYPE bapiret2-field.
  DATA l_error_par              TYPE bapiret2-parameter.

  FIELD-SYMBOLS <l_content>     TYPE any.

  e_changed = abap_false.

* The model has to be specified.
  IF ir_model IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_UTL_GUI_STRUCTURE_MODEL' ).
  ENDIF.

* The fieldname has to be specified.
  IF i_fieldname IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_UTL_GUI_STRUCTURE_MODEL' ).
  ENDIF.

* Determine the structure descriptor for the given data.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = cs_data ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '3'
          i_mv2        = 'SET_FIELD_CONTENT'
          i_mv3        = 'CL_ISH_UTL_GUI_STRUCTURE_MODEL'
          ir_object    = ir_model ).
  ENDTRY.

* Set error fields.
  l_error_par   = lr_structdescr->get_relative_name( ).
  l_error_field = i_fieldname.

* Assign the structure field.
  ASSIGN COMPONENT i_fieldname
    OF STRUCTURE cs_data
    TO <l_content>.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '4'
        i_mv2        = 'SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_UTL_GUI_STRUCTURE_MODEL'
        i_par        = l_error_par
        i_field      = l_error_field
        ir_object    = ir_model ).
  ENDIF.

* Assign the content.
  CALL METHOD assign_field_content
    EXPORTING
      ir_model    = ir_model
      i_source    = i_content
      i_fieldname = i_fieldname
      i_error_par = l_error_par
      ir_cb       = ir_cb
    IMPORTING
      e_changed   = e_changed
    CHANGING
      c_target    = <l_content>.

ENDMETHOD.
ENDCLASS.
