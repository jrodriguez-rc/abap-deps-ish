class CL_ISH_SORTED_OBJECT_ITAB definition
  public
  inheriting from CL_ISH_SORTED_ITAB
  create protected .

public section.
*"* public components of class CL_ISH_SORTED_OBJECT_ITAB
*"* do not include other source files here!!!

  constants CO_OTYPE_SORTED_OBJECT_ITAB type ISH_OBJECT_TYPE value 13414. "#EC NOTEXT
  data GT_OBJECT type ISH_T_OBJECT_SORTED read-only .
  data GT_OBJECT_TYPE type ISH_T_OBJECT_TYPE read-only .
  type-pools ABAP .
  data G_ALLOW_INHERITANCE type ABAP_BOOL read-only value ABAP_FALSE. "#EC NOTEXT .

  class-methods CREATE
    importing
      !I_ALLOW_NULL_ENTRIES type ABAP_BOOL default ABAP_FALSE
      !IR_OWNER type ref to IF_ISH_COLLECTION_OWNER optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_SORTED_OBJECT_ITAB .
  class-methods CREATE_BY_OBJECT_TYPE
    importing
      !I_ALLOW_NULL_ENTRIES type ABAP_BOOL default ABAP_FALSE
      !IR_OWNER type ref to IF_ISH_COLLECTION_OWNER optional
      !I_OBJECT_TYPE type ISH_OBJECT_TYPE optional
      !I_ALLOW_INHERITANCE type ABAP_BOOL default ABAP_TRUE
    returning
      value(RR_INSTANCE) type ref to CL_ISH_SORTED_OBJECT_ITAB .
  class-methods CREATE_BY_OBJECT_TYPES
    importing
      !I_ALLOW_NULL_ENTRIES type ABAP_BOOL default ABAP_FALSE
      !IR_OWNER type ref to IF_ISH_COLLECTION_OWNER optional
      !IT_OBJECT_TYPE type ISH_T_OBJECT_TYPE optional
      !I_ALLOW_INHERITANCE type ABAP_BOOL default ABAP_TRUE
    returning
      value(RR_INSTANCE) type ref to CL_ISH_SORTED_OBJECT_ITAB .
  methods AS_OBJECTLIST
    returning
      value(RT_OBJECTLIST) type ISH_OBJECTLIST .
  methods CONSTRUCTOR
    importing
      !I_ALLOW_NULL_ENTRIES type ABAP_BOOL default ABAP_FALSE
      !IR_OWNER type ref to IF_ISH_COLLECTION_OWNER optional
      !IT_OBJECT_TYPE type ISH_T_OBJECT_TYPE optional
      !I_ALLOW_INHERITANCE type ABAP_BOOL default ABAP_TRUE .
  methods FIRST_OBJECT
    returning
      value(RR_OBJECT) type ref to OBJECT .
  methods LAST_OBJECT
    returning
      value(RR_OBJECT) type ref to OBJECT .
  methods OBJECT_AT
    importing
      !I_INDEX type I
    returning
      value(RR_OBJECT) type ref to OBJECT .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_SORTED_OBJECT_ITAB
*"* do not include other source files here!!!

  methods CHECK_INITIALIZATION
    redefinition .
  methods IS_VALUE_VALID
    redefinition .
private section.
*"* private components of class CL_ISH_SORTED_OBJECT_ITAB
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SORTED_OBJECT_ITAB IMPLEMENTATION.


METHOD as_objectlist.

  DATA: ls_object LIKE LINE OF rt_objectlist.
  LOOP AT gt_object INTO ls_object-object.
    APPEND ls_object TO rt_objectlist.
  ENDLOOP.

ENDMETHOD.


METHOD check_initialization.

  DATA: lr_linedescr   TYPE REF TO cl_abap_datadescr.

  lr_linedescr = get_linedescr( ).
  CHECK lr_linedescr IS BOUND.

  CHECK lr_linedescr->type_kind = cl_abap_datadescr=>typekind_oref.

  r_success = super->check_initialization( ).

ENDMETHOD.


METHOD constructor.

  super->constructor( i_allow_null_entries = i_allow_null_entries
                      ir_owner             = ir_owner ).

  gt_object_type      = it_object_type.
  g_allow_inheritance = i_allow_inheritance.

ENDMETHOD.


METHOD create.

  DATA: lr_instance  TYPE REF TO cl_ish_sorted_object_itab,
        lr_table     TYPE REF TO data.

  CREATE OBJECT lr_instance
    EXPORTING
      i_allow_null_entries = i_allow_null_entries
      ir_owner             = ir_owner.

  GET REFERENCE OF lr_instance->gt_object INTO lr_table.

  CHECK lr_instance->initialize( lr_table ) = abap_true.

  rr_instance = lr_instance.

ENDMETHOD.


METHOD create_by_object_type.

  DATA: lr_instance     TYPE REF TO cl_ish_sorted_object_itab,
        lr_table        TYPE REF TO data,
        lt_object_type  TYPE ish_t_object_type.

  IF i_object_type IS NOT INITIAL.
    INSERT i_object_type INTO TABLE lt_object_type.
  ENDIF.

  CREATE OBJECT lr_instance
    EXPORTING
      i_allow_null_entries = i_allow_null_entries
      ir_owner             = ir_owner
      it_object_type       = lt_object_type
      i_allow_inheritance  = i_allow_inheritance.

  GET REFERENCE OF lr_instance->gt_object INTO lr_table.

  CHECK lr_instance->initialize( lr_table ) = abap_true.

  rr_instance = lr_instance.

ENDMETHOD.


METHOD create_by_object_types.

  DATA: lr_instance     TYPE REF TO cl_ish_sorted_object_itab,
        lr_table        TYPE REF TO data.

  CREATE OBJECT lr_instance
    EXPORTING
      i_allow_null_entries = i_allow_null_entries
      ir_owner             = ir_owner
      it_object_type       = it_object_type
      i_allow_inheritance  = i_allow_inheritance.

  GET REFERENCE OF lr_instance->gt_object INTO lr_table.

  CHECK lr_instance->initialize( lr_table ) = abap_true.

  rr_instance = lr_instance.

ENDMETHOD.


METHOD first_object.

  rr_object = object_at( 1 ).

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_sorted_object_itab.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_sorted_object_itab.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD is_value_valid.

  DATA: lr_identify  TYPE REF TO if_ish_identify_object.

  FIELD-SYMBOLS: <l_object_type>  TYPE ish_object_type.

  IF i_value IS INITIAL OR gt_object_type IS INITIAL.
    r_valid = super->is_value_valid( i_value ).
    RETURN.
  ENDIF.

  TRY.
      lr_identify ?= i_value.
    CATCH cx_root.                                       "#EC CATCH_ALL
      RETURN.
  ENDTRY.

  LOOP AT gt_object_type ASSIGNING <l_object_type>.
    IF g_allow_inheritance = abap_true.
      CHECK lr_identify->is_inherited_from( <l_object_type> ) = abap_true.
    ELSE.
      CHECK lr_identify->is_a( <l_object_type> ) = abap_true.
    ENDIF.
    r_valid = abap_true.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD last_object.
  DATA: l_entries TYPE i.

  l_entries = entries( ).
  rr_object = object_at( l_entries ).

ENDMETHOD.


METHOD object_at.

  CHECK is_valid( ) = abap_true.

  CHECK i_index > 0.
  CHECK i_index <= entries( ).

  READ TABLE gt_object INDEX i_index INTO rr_object.

ENDMETHOD.
ENDCLASS.
