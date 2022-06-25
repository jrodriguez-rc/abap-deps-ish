class CL_ISH_UTL_RTTI definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_UTL_RTTI
*"* do not include other source files here!!!
public section.
  type-pools ABAP .
  type-pools SEOR .

  interfaces IF_ISH_CONSTANT_DEFINITION .

  class-methods ASSIGN_CONTENT
    importing
      !I_SOURCE type ANY
    exporting
      !E_RC type ISH_METHOD_RC
      !E_CHANGED type ABAP_BOOL
    changing
      !C_TARGET type ANY .
  class-methods GET_CLASS_NAME
    importing
      value(IR_OBJECT) type ref to OBJECT
    returning
      value(R_NAME) type SEOCLASS-CLSNAME .
  class-methods GET_DATA_FIXED_VALUE
    importing
      !I_DATA type ANY
    returning
      value(R_FIXED_VALUE) type STRING .
  class-methods GET_DATA_LABEL
    importing
      value(I_DATA) type ANY
      value(I_TYPE) type CHAR1 default 'M'
    returning
      value(LABEL) type STRING .
  class-methods GET_DATA_NAME
    importing
      !I_DATA type ANY
    returning
      value(R_NAME) type STRING .
  class-methods GET_DDFIELDS_BY_STRUCT
    importing
      value(IS_DATA) type ANY
      value(I_DATA_NAME) type STRING optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(ET_DDFIELDS) type DDFIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DDFIELDS_BY_STRUCTDESCR
    importing
      value(IR_STRUCTDESCR) type ref to CL_ABAP_STRUCTDESCR
      value(I_DATA_NAME) type STRING optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(ET_DDFIELDS) type DDFIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DDFIELDS_BY_STRUCT_NAME
    importing
      value(I_DATA_NAME) type STRING optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(ET_DDFIELDS) type DDFIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DDFIELDS_BY_TYPEDESCR
    importing
      value(IR_TYPEDESCR) type ref to CL_ABAP_TYPEDESCR
      value(I_DATA_NAME) type STRING optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(ET_DDFIELDS) type DDFIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_INTERFACE_IMPLEMENTATIONS
    importing
      !I_INTERFACE_NAME type SEOCLSNAME
      !I_WITH_SUBCLASSES type ISH_ON_OFF default IF_ISH_CONSTANT_DEFINITION=>ON
    returning
      value(RT_CLSKEY) type SEO_CLSKEYS .
  class-methods GET_SUBCLASSES_BY_CLSNAME
    importing
      !I_CLASS_NAME type SEOCLSNAME
    returning
      value(RT_CLSKEY) type SEO_CLSKEYS .
  class-methods IS_ASSIGNMENT_ALLOWED
    importing
      !I_SOURCE type ANY
      !I_TARGET type ANY
    returning
      value(R_ALLOWED) type I .
  class-methods IS_SHM_CLASS
    importing
      !I_CLSNAME type SEOCLSNAME
    returning
      value(R_SHM_CLASS) type ISH_ON_OFF .
  class-methods IS_SHM_OBJECT
    importing
      !IR_OBJECT type ref to OBJECT
    returning
      value(R_IS_SHM_OBJECT) type ISH_ON_OFF .
  class-methods GET_VALUES_OF_DOMAIN
    importing
      value(I_DOMNAME) type DOMNAME
    returning
      value(RT_DOMVALUES) type ISHMED_T_DD07V .
protected section.
*"* protected components of class CL_ISH_UTL_RTTI
*"* do not include other source files here!!!

  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
private section.
*"* private components of class CL_ISH_UTL_RTTI
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_RTTI IMPLEMENTATION.


METHOD assign_content.

  DATA l_allowed                TYPE i.
  DATA lr_source_copy           TYPE REF TO data.

  FIELD-SYMBOLS <l_source_copy> TYPE any.

* Initializations.
  e_changed = abap_false.
  e_rc = 0.

* Check if assignment is allowed.
  l_allowed = is_assignment_allowed( i_source = i_source
                                     i_target = c_target ).
* An error occured
  IF l_allowed = 0.
    e_rc = 1.
    RETURN.
  ENDIF.

* Check for changes.
  CREATE DATA lr_source_copy LIKE c_target.
  ASSIGN lr_source_copy->* TO <l_source_copy>.
  CASE l_allowed.
    WHEN 1.                       "Data
      <l_source_copy> = i_source.
    WHEN 2 OR 3.                  "Object and Data reference
      <l_source_copy> ?= i_source.
  ENDCASE.
  CHECK <l_source_copy> <> c_target.

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


METHOD get_class_name .

* Dagmar Fuehrer, 2003-09-01

* object references
  DATA: lr_descr        TYPE REF TO cl_abap_typedescr.
* ---------- ---------- ----------
* initialize
  CLEAR: r_name.
* ---------- ---------- ----------
  lr_descr = cl_abap_classdescr=>describe_by_object_ref( ir_object ).
  r_name = lr_descr->get_relative_name( ).
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_data_fixed_value .

  DATA:  l_descr     TYPE REF TO cl_abap_typedescr,
         l_elemdescr TYPE REF TO cl_abap_elemdescr,
         l_fixvalues TYPE ddfixvalues.

  FIELD-SYMBOLS:
        <fs>        TYPE LINE OF ddfixvalues.

*
  CALL METHOD cl_abap_elemdescr=>describe_by_data
    EXPORTING
      p_data      = i_data
    RECEIVING
      p_descr_ref = l_descr.

* cast type to elementar description class
  TRY.
      l_elemdescr ?= l_descr.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* get table with fixed values
  CALL METHOD l_elemdescr->get_ddic_fixed_values
    EXPORTING
      p_langu        = sy-langu
    RECEIVING
      p_fixed_values = l_fixvalues
    EXCEPTIONS
      not_found      = 1
      no_ddic_type   = 2
      OTHERS         = 3.

  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

* compare value and fixed values table
  LOOP AT l_fixvalues ASSIGNING <fs>.
    IF <fs>-option = 'EQ'.
      IF i_data = <fs>-low.
        r_fixed_value = <fs>-ddtext.
        RETURN.
      ENDIF.
    ENDIF.

    IF <fs>-option = 'BT'.
      IF i_data >= <fs>-low AND i_data <= <fs>-high. "#EC PORTABLE
        r_fixed_value = <fs>-ddtext.
        RETURN.
      ENDIF.
    ENDIF.

  ENDLOOP.
ENDMETHOD.


METHOD get_data_label .
  DATA:  l_descr     TYPE REF TO cl_abap_typedescr,
         l_elemdescr TYPE REF TO cl_abap_elemdescr,
         l_flddescr  TYPE dfies.

* get field description
  CALL METHOD cl_abap_elemdescr=>describe_by_data
    EXPORTING
      p_data      = i_data
    RECEIVING
      p_descr_ref = l_descr.

* cast type to elementar description class
  TRY.
      l_elemdescr ?= l_descr.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* get field description
  IF l_elemdescr IS BOUND.
    CALL METHOD l_elemdescr->get_ddic_field
      RECEIVING
        p_flddescr   = l_flddescr
      EXCEPTIONS
        not_found    = 1
        no_ddic_type = 2
        OTHERS       = 3.
    IF sy-subrc = 0.
      CASE i_type.
        WHEN 'R'. "title
          label = l_flddescr-reptext.
        WHEN 'S'. "short text
          label = l_flddescr-scrtext_s.
        WHEN 'M'. "medium text
          label = l_flddescr-scrtext_m.
        WHEN 'L'. "long text
          label = l_flddescr-scrtext_l.
      ENDCASE.
    ENDIF.

  ENDIF.

ENDMETHOD.


METHOD get_data_name .

  DATA: lr_descr TYPE REF TO cl_abap_typedescr.

*----------------------------------------------------------
  CALL METHOD cl_abap_typedescr=>describe_by_data
    EXPORTING
      p_data      = i_data
    RECEIVING
      p_descr_ref = lr_descr.

  CALL METHOD lr_descr->get_relative_name
    RECEIVING
      p_relative_name = r_name.


ENDMETHOD.


METHOD get_ddfields_by_struct .

* Michael Manoch, 2003-09-01

  DATA: lr_typedescr    TYPE REF TO cl_abap_typedescr.

* Initializations
  CLEAR: e_rc.
  REFRESH: et_ddfields.

* Get the typedescr object for IS_DATA.
  lr_typedescr = cl_abap_typedescr=>describe_by_data( is_data ).

* Get the DDFIELDS of IS_DATA.
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_typedescr
    EXPORTING
      ir_typedescr    = lr_typedescr
      i_data_name     = i_data_name
      ir_object       = ir_object
    IMPORTING
      et_ddfields     = et_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD get_ddfields_by_structdescr .

* Michael Manoch, 2003-09-01

  DATA: l_data_name TYPE bapiret2-parameter.

* Initializations
  CLEAR: e_rc.
  REFRESH: et_ddfields.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  l_data_name = i_data_name.
  IF l_data_name IS INITIAL.
    l_data_name = 'IR_STRUCTDESCR'.
  ENDIF.

* Get the DDIC info from ir_structdescr.
  IF ir_structdescr IS INITIAL.
    sy-subrc = 3.
  ELSE.
    CALL METHOD ir_structdescr->get_ddic_field_list
      RECEIVING
        p_field_list = et_ddfields
      EXCEPTIONS
        not_found    = 1
        no_ddic_type = 2
        OTHERS       = 3.
  ENDIF.
  IF sy-subrc <> 0.
    REFRESH et_ddfields.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ    = sy-msgty
        i_kla    = sy-msgid
        i_num    = sy-msgno
        i_mv1    = sy-msgv1
        i_mv2    = sy-msgv2
        i_mv3    = sy-msgv3
        i_mv4    = sy-msgv4
        i_par    = l_data_name
        i_fld    = space
        i_object = ir_object
        i_last   = space.
    e_rc = 1.
  ENDIF.

ENDMETHOD.


METHOD get_ddfields_by_struct_name .

* Michael Manoch, 2003-09-01

  DATA: lr_typedescr    TYPE REF TO cl_abap_typedescr.

* Initializations
  CLEAR: e_rc.
  REFRESH: et_ddfields.

* Get the typedescr object for I_DATA_NAME.
  lr_typedescr = cl_abap_typedescr=>describe_by_name( i_data_name ).

* Get the DDFIELDS of I_DATA_NAME.
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_typedescr
    EXPORTING
      ir_typedescr    = lr_typedescr
      i_data_name     = i_data_name
      ir_object       = ir_object
    IMPORTING
      et_ddfields     = et_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD get_ddfields_by_typedescr .

* Michael Manoch, 2003-09-01

  DATA: l_data_name     TYPE bapiret2-parameter,
        lr_structdescr  TYPE REF TO cl_abap_structdescr.

* Initializations
  CLEAR: e_rc.
  REFRESH: et_ddfields.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  l_data_name = i_data_name.
  IF l_data_name IS INITIAL.
    l_data_name = 'IR_TYPEDESCR'.
  ENDIF.

* IR_TYPEDESCR initial?.
  IF ir_typedescr IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ    = sy-msgty
        i_kla    = sy-msgid
        i_num    = sy-msgno
        i_mv1    = sy-msgv1
        i_mv2    = sy-msgv2
        i_mv3    = sy-msgv3
        i_mv4    = sy-msgv4
        i_par    = l_data_name
        i_fld    = space
        i_object = ir_object
        i_last   = space.
    e_rc = 1.
  ENDIF.

  CHECK e_rc = 0.

* Get the name of IS_DATA.
  IF l_data_name = 'IR_TYPEDESCR'.
    l_data_name = ir_typedescr->get_relative_name( ).
  ENDIF.

* Cast ir_typedescr to lr_structdescr.
  CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
    lr_structdescr ?= ir_typedescr.
  ENDCATCH.
  IF sy-subrc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ    = sy-msgty
        i_kla    = sy-msgid
        i_num    = sy-msgno
        i_mv1    = sy-msgv1
        i_mv2    = sy-msgv2
        i_mv3    = sy-msgv3
        i_mv4    = sy-msgv4
        i_par    = l_data_name
        i_fld    = space
        i_object = ir_object
        i_last   = space.
    e_rc = 1.
  ENDIF.

  CHECK e_rc = 0.

* Get the DDFIELDS from LR_STRUCTDESCR.
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_structdescr
    EXPORTING
      ir_structdescr  = lr_structdescr
      i_data_name     = i_data_name
      ir_object       = ir_object
    IMPORTING
      et_ddfields     = et_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD get_interface_implementations.

  DATA: ls_intkey           TYPE seoclskey,
        lt_impkey           TYPE seor_implementing_keys,
        ls_clskey           TYPE seoclskey,
        lt_clskey_sub       TYPE seo_clskeys.

  FIELD-SYMBOLS: <ls_impkey>     TYPE seorelkey.

* Initializations.
  CLEAR: rt_clskey.

* Initial checking.
  CHECK NOT i_interface_name IS INITIAL.

* Get all classes which implement interface IF_ISH_IDENTIFY_OBJECT.
  CLEAR: ls_intkey.
  ls_intkey-clsname = i_interface_name.
  CALL FUNCTION 'SEO_INTERFACE_IMPLEM_GET_ALL'
    EXPORTING
      intkey       = ls_intkey
    IMPORTING
      impkeys      = lt_impkey
    EXCEPTIONS
      not_existing = 1
      OTHERS       = 2.
  CHECK sy-subrc = 0.

* Build rt_clskey.
  LOOP AT lt_impkey ASSIGNING <ls_impkey>.
*   Append the implementation class.
    CLEAR: ls_clskey.
    ls_clskey-clsname = <ls_impkey>-clsname.
    APPEND ls_clskey TO rt_clskey.
*   Append the sub classes.
    IF i_with_subclasses = on.
      lt_clskey_sub = get_subclasses_by_clsname( <ls_impkey>-clsname ).
      APPEND LINES OF lt_clskey_sub TO rt_clskey.
    ENDIF.
  ENDLOOP.

* Eliminate duplicates.
  SORT rt_clskey.
  DELETE ADJACENT DUPLICATES FROM rt_clskey.

ENDMETHOD.


METHOD get_subclasses_by_clsname.

  DATA: ls_clskey           TYPE seoclskey,
        lt_inhkey           TYPE seor_inheritance_keys.

  FIELD-SYMBOLS: <ls_inhkey>     TYPE seorelkey.

* Initializations.
  CLEAR: rt_clskey.

* Initial checking.
  CHECK NOT i_class_name IS INITIAL.

* Get the sub classes.
  CLEAR: ls_clskey.
  ls_clskey-clsname = i_class_name.
  CALL FUNCTION 'SEO_CLASS_GET_ALL_SUBS'
    EXPORTING
      clskey             = ls_clskey
    IMPORTING
      inhkeys            = lt_inhkey
    EXCEPTIONS
      class_not_existing = 1
      OTHERS             = 2.
  CHECK sy-subrc = 0.

* Build rt_clskey.
  LOOP AT lt_inhkey ASSIGNING <ls_inhkey>.
    CLEAR: ls_clskey.
    ls_clskey-clsname = <ls_inhkey>-clsname.
    APPEND ls_clskey TO rt_clskey.
  ENDLOOP.

ENDMETHOD.


METHOD get_values_of_domain.
* get domain values
  CALL FUNCTION 'DD_DOMVALUES_GET'
    EXPORTING
      domname        = i_domname
      text           = 'X'
    TABLES
      dd07v_tab      = rt_domvalues
    EXCEPTIONS
      wrong_textflag = 1
      OTHERS         = 2.
ENDMETHOD.


METHOD is_assignment_allowed.

  DATA lr_typedescr_source      TYPE REF TO cl_abap_typedescr.
  DATA lr_typedescr_target      TYPE REF TO cl_abap_typedescr.
  DATA lr_datadescr_source      TYPE REF TO cl_abap_datadescr.
  DATA lr_target                TYPE REF TO data.
  DATA lr_elemdescr_source      TYPE REF TO cl_abap_elemdescr.
  DATA lr_elemdescr_target      TYPE REF TO cl_abap_elemdescr.
  DATA l_target_int             TYPE i.
  DATA l_typekind_target        TYPE abap_typekind.
  DATA l_typekind_source        TYPE abap_typekind.

  FIELD-SYMBOLS <lr_target>     TYPE ANY.

* Initializations.
  r_allowed = 0.

* Get the typedescriptor for the source.
  lr_typedescr_source = cl_abap_typedescr=>describe_by_data( p_data = i_source ).

* - - - BEGIN C. Honeder MED-52958
* Describe only if target-typedescriptor is needed.
** Get the typedescriptor fot the target.
*  lr_typedescr_target = cl_abap_typedescr=>describe_by_data( p_data = i_target ).
* - - - END C. Honeder MED-52958

* Handle object/data references.
  IF lr_typedescr_source->type_kind = cl_abap_typedescr=>typekind_oref.
*   Objectreference
* - - - BEGIN C. Honeder MED-52958
*   Get the typedescriptor fot the target.
    lr_typedescr_target = cl_abap_typedescr=>describe_by_data( p_data = i_target ).
* - - - END C. Honeder MED-52958
    CHECK lr_typedescr_target->type_kind = cl_abap_typedescr=>typekind_oref.
    CREATE DATA lr_target LIKE i_target.
    ASSIGN lr_target->* TO <lr_target>.

*   Fits our source to the target
    TRY.
        <lr_target> ?= i_source.
        r_allowed = 2.
      CATCH cx_sy_move_cast_error.
        RETURN.
    ENDTRY.
    RETURN.
  ELSEIF lr_typedescr_source->type_kind = cl_abap_typedescr=>typekind_dref.
*   Datareference
* - - - BEGIN C. Honeder MED-52958
*   Get the typedescriptor fot the target.
    lr_typedescr_target = cl_abap_typedescr=>describe_by_data( p_data = i_target ).
* - - - END C. Honeder MED-52958
    CHECK lr_typedescr_target->type_kind = lr_typedescr_source->type_kind.
    CREATE DATA lr_target LIKE i_target.
    ASSIGN lr_target->* TO <lr_target>.

*   Fits our source to the target
    TRY.
        <lr_target> ?= i_source.
        r_allowed = 3.
      CATCH cx_sy_move_cast_error.
        RETURN.
    ENDTRY.
    RETURN.
  ENDIF.

* Have we already found the right target?
  CHECK r_allowed = 0.

* Handle data.
  TRY.
      lr_datadescr_source ?= lr_typedescr_source.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_datadescr_source IS BOUND.

* If the data can be applied the assignment is allowed
  IF lr_datadescr_source->applies_to_data( i_target ) = abap_true.
    r_allowed = 1.
    RETURN.
  ELSE.
* - - - BEGIN C. Honeder MED-52958
*   Get the typedescriptor fot the target.
    lr_typedescr_target = cl_abap_typedescr=>describe_by_data( p_data = i_target ).
* - - - END C. Honeder MED-52958
*   We proceed our additional checks only on data elements.
*    - References and complex elements (e.g. structures or tables)
*      are not treated anymore -> leave method
    TRY.
        lr_elemdescr_source ?= lr_typedescr_source.
        lr_elemdescr_target ?= lr_typedescr_target.
      CATCH cx_sy_move_cast_error.
        RETURN.
    ENDTRY.
  ENDIF.

  CHECK lr_elemdescr_source IS BOUND AND
        lr_elemdescr_target IS BOUND.

* Get the element descriptions
  l_typekind_source = lr_elemdescr_source->get_data_type_kind( i_source ).
  l_typekind_target = lr_elemdescr_target->get_data_type_kind( i_target ).

  CASE l_typekind_source.
*   String and Character
    WHEN cl_abap_typedescr=>typekind_string OR
         cl_abap_typedescr=>typekind_char.
      CASE l_typekind_target.
        WHEN cl_abap_typedescr=>typekind_string OR
             cl_abap_typedescr=>typekind_char.
*         char or string -> string = allowed
*         char or string -> char   = allowed
          r_allowed = 1.
          RETURN.
        WHEN cl_abap_typedescr=>typekind_int OR
             cl_abap_typedescr=>typekind_num.
*         string or char -> int or num = allowed when only numeric
          TRY.
              l_target_int = i_source.
              r_allowed = 1.
            CATCH cx_sy_conversion_no_number.
              RETURN.
          ENDTRY.
        WHEN cl_abap_typedescr=>typekind_date OR
             cl_abap_typedescr=>typekind_time.
*         char or string -> date or time
          r_allowed = 1.
          RETURN.
      ENDCASE.
*   Date and Time
    WHEN cl_abap_typedescr=>typekind_date OR
         cl_abap_typedescr=>typekind_time.
      CASE l_typekind_target.
        WHEN cl_abap_typedescr=>typekind_string OR
             cl_abap_typedescr=>typekind_char.
*         time -> string or char = allowed
*         date -> string or char = allowed
          r_allowed = 1.
          RETURN.
        WHEN cl_abap_typedescr=>typekind_int OR
             cl_abap_typedescr=>typekind_num.
*         date or time -> int or num = allowed
          r_allowed = 1.
          RETURN.
      ENDCASE.
*   Integer and Numeric
    WHEN cl_abap_typedescr=>typekind_int OR
         cl_abap_typedescr=>typekind_num.
      CASE l_typekind_target.
        WHEN cl_abap_typedescr=>typekind_string OR
             cl_abap_typedescr=>typekind_char.
*         int or numeric -> string or char = allowed
          r_allowed = 1.
          RETURN.
*         int or numeric -> date or time = allowed
        WHEN cl_abap_typedescr=>typekind_date OR
             cl_abap_typedescr=>typekind_time.
          r_allowed = 1.
          RETURN.
        WHEN cl_abap_typedescr=>typekind_int OR
             cl_abap_typedescr=>typekind_num.
          r_allowed = 1.
          RETURN.
      ENDCASE.
*   Hex and Float
    WHEN cl_abap_typedescr=>typekind_hex OR
         cl_abap_typedescr=>typekind_float.
      CASE l_typekind_target.
        WHEN cl_abap_typedescr=>typekind_string OR
             cl_abap_typedescr=>typekind_char.
*         hex or float -> string or char = allowed
          r_allowed = 1.
          RETURN.
      ENDCASE.
  ENDCASE.

ENDMETHOD.


METHOD is_shm_class.

  DATA: lr_classdescr  TYPE REF TO cl_abap_classdescr.

  r_shm_class = off.

  CHECK i_clsname IS NOT INITIAL.

  TRY.
      lr_classdescr ?= cl_abap_typedescr=>describe_by_name( i_clsname ).
    CATCH cx_sy_move_cast_error.
      EXIT.
  ENDTRY.

  CHECK lr_classdescr IS BOUND.
  CHECK lr_classdescr->is_shared_memory_enabled( ) = abap_true.

  r_shm_class = on.

ENDMETHOD.


METHOD is_shm_object.

  DATA: lr_classdescr  TYPE REF TO cl_abap_classdescr.

  r_is_shm_object = off.

  CHECK ir_object IS BOUND.

  TRY.
      lr_classdescr ?= cl_abap_typedescr=>describe_by_object_ref( ir_object ).
    CATCH cx_sy_move_cast_error.
      EXIT.
  ENDTRY.

  CHECK lr_classdescr IS BOUND.
  CHECK lr_classdescr->is_shared_memory_enabled( ) = abap_true.

  r_is_shm_object = on.

ENDMETHOD.
ENDCLASS.
