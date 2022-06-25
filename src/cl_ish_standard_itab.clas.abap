class CL_ISH_STANDARD_ITAB definition
  public
  inheriting from CL_ISH_INDEXED_ITAB
  create protected .

public section.
*"* public components of class CL_ISH_STANDARD_ITAB
*"* do not include other source files here!!!

  constants CO_OTYPE_STANDARD_ITAB type ISH_OBJECT_TYPE value 13413. "#EC NOTEXT

  type-pools ABAP .
  methods APPEND
    importing
      !I_VALUE type ANY
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods APPEND_ITAB
    importing
      !IT_TABLE type ANY TABLE
    returning
      value(R_ENTRIES) type I .
  class-methods CREATE_BY_TABNAME
    importing
      !I_TABNAME type TABNAME
      !I_ALLOW_NULL_ENTRIES type ABAP_BOOL default ABAP_FALSE
      !IR_OWNER type ref to IF_ISH_COLLECTION_OWNER optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_STANDARD_ITAB .
  methods INSERT_AT
    importing
      !I_VALUE type ANY
      !I_INDEX type I
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods INSERT_ITAB_AT
    importing
      !IT_TABLE type ANY TABLE
      !I_INDEX type I
    returning
      value(R_ENTRIES) type I .
  methods MOVE
    importing
      !I_INDEX_FROM type I
      !I_INDEX_TO type I
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods MOVE_BOTTOM
    importing
      !I_INDEX type I
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods MOVE_NEXT
    importing
      !I_INDEX type I
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods MOVE_PREVIOUS
    importing
      !I_INDEX type I
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods MOVE_TOP
    importing
      !I_INDEX type I
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods PREPEND
    importing
      !I_VALUE type ANY
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods PREPEND_ITAB
    importing
      !IT_TABLE type ANY TABLE
    returning
      value(R_ENTRIES) type I .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_STANDARD_ITAB
*"* do not include other source files here!!!

  methods CHECK_INITIALIZATION
    redefinition .
private section.
*"* private components of class CL_ISH_STANDARD_ITAB
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_STANDARD_ITAB IMPLEMENTATION.


METHOD append.

  r_success = insert( i_value ).

ENDMETHOD.


METHOD append_itab.

  r_entries = insert_itab( it_table ).

ENDMETHOD.


METHOD check_initialization.

  DATA: lr_tabledescr  TYPE REF TO cl_abap_tabledescr.

  lr_tabledescr = get_tabledescr( ).
  CHECK lr_tabledescr IS BOUND.

  CHECK lr_tabledescr->table_kind = cl_abap_tabledescr=>tablekind_std.

  r_success = abap_true.

ENDMETHOD.


METHOD create_by_tabname.

  DATA: lr_instance  TYPE REF TO cl_ish_standard_itab,
        lr_table     TYPE REF TO data.

  CHECK i_tabname IS NOT INITIAL.

  CREATE OBJECT lr_instance
    EXPORTING
    i_allow_null_entries = i_allow_null_entries
    ir_owner = ir_owner.

  TRY.
      CREATE DATA lr_table TYPE (i_tabname).
    CATCH cx_root.
      RETURN.
  ENDTRY.

  CHECK lr_instance->initialize( lr_table ) = abap_true.

  rr_instance = lr_instance.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_standard_itab.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_standard_itab.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD insert_at.

  DATA: lr_table  TYPE REF TO data.
  DATA: l_entries TYPE i.

  FIELD-SYMBOLS: <lt_table>  TYPE table.

  CHECK is_valid( ) = abap_true.

  CHECK allows_insert( ) = abap_true.

  IF allows_null_entries( ) = abap_false.
    CHECK i_value IS NOT INITIAL.
  ENDIF.

  CHECK is_value_valid( i_value ) = abap_true.

  lr_table = get_tableref( ).
  CHECK lr_table IS BOUND.

  ASSIGN lr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  CHECK i_index > 0.

  l_entries = entries( ) + 1.

  CHECK i_index <=  l_entries.

  INSERT i_value INTO <lt_table> INDEX i_index.
  CHECK sy-subrc = 0.

  RAISE EVENT ev_value_inserted
    EXPORTING
      e_value = i_value.

  r_success = abap_true.

ENDMETHOD.


METHOD insert_itab_at.

  DATA: l_index  TYPE i.

  FIELD-SYMBOLS: <l_entry>  TYPE any.

  CHECK is_valid( ) = abap_true.

  CHECK allows_insert( ) = abap_true.

  CHECK i_index > 0.
  CHECK i_index <= entries( ).

  LOOP AT it_table ASSIGNING <l_entry>.
    CHECK insert_at( i_value = <l_entry>
                     i_index = l_index ) = abap_true.
    r_entries = r_entries + 1.
    l_index = l_index + 1.
  ENDLOOP.

ENDMETHOD.


METHOD MOVE.

  DATA: lr_entry  TYPE REF TO data.

  FIELD-SYMBOLS: <l_entry>  TYPE data.

  CHECK is_valid( ) = abap_true.

  CHECK allows_update( ) = abap_true.

  CHECK i_index_from <> i_index_to.

  CHECK i_index_from > 0.
  CHECK i_index_from <= entries( ).

  CHECK i_index_to > 0.
  CHECK i_index_to <= entries( ).

  lr_entry = at( i_index_from ).
  CHECK lr_entry IS BOUND.

  ASSIGN lr_entry->* TO <l_entry>.
  CHECK sy-subrc = 0.

  CHECK remove_at( i_index_from ) = abap_true.

  CHECK insert_at( i_value = <l_entry>
                   i_index = i_index_to ) = abap_true.

  r_success = abap_true.

ENDMETHOD.


METHOD move_bottom.

  DATA: l_entries TYPE i.

  l_entries = entries( ).

  r_success = move( i_index_from = i_index
                    i_index_to   = l_entries ).

ENDMETHOD.


METHOD move_next.

  DATA: l_index TYPE i.

  l_index = i_index + 1.
  r_success = move( i_index_from = i_index
                    i_index_to   = l_index  ).

ENDMETHOD.


METHOD MOVE_PREVIOUS.
  DATA: l_index TYPE i.

  l_index = i_index + 1.
  r_success = move( i_index_from = i_index
                    i_index_to   = l_index ).

ENDMETHOD.


METHOD MOVE_TOP.

  r_success = move( i_index_from = i_index
                    i_index_to   = 1 ).

ENDMETHOD.


METHOD PREPEND.

  r_success = insert_at( i_value = i_value
                         i_index = 1 ).

ENDMETHOD.


METHOD PREPEND_ITAB.

  r_entries = insert_itab_at( it_table = it_table
                              i_index  = 1 ).

ENDMETHOD.
ENDCLASS.
