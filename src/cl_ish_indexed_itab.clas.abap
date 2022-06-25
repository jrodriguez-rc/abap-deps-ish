class CL_ISH_INDEXED_ITAB definition
  public
  inheriting from CL_ISH_ITAB
  abstract
  create public .

public section.
*"* public components of class CL_ISH_INDEXED_ITAB
*"* do not include other source files here!!!

  constants CO_OTYPE_INDEXED_ITAB type ISH_OBJECT_TYPE value 13410. "#EC NOTEXT

  methods AT
    importing
      !I_INDEX type I
    returning
      value(RR_ENTRY) type ref to DATA .
  methods FIRST
    returning
      value(RR_ENTRY) type ref to DATA .
  methods INDEX
    importing
      !I_VALUE type ANY
    returning
      value(R_INDEX) type I .
  methods LAST
    returning
      value(RR_ENTRY) type ref to DATA .
  type-pools ABAP .
  methods REMOVE_AT
    importing
      !I_INDEX type I
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods REPLACE_AT
    importing
      !I_INDEX type I
      !I_VALUE_NEW type ANY
    returning
      value(R_SUCCESS) type ABAP_BOOL .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods REPLACE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_INDEXED_ITAB
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_INDEXED_ITAB
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_INDEXED_ITAB IMPLEMENTATION.


METHOD at.

  DATA: lr_table  TYPE REF TO data.

  FIELD-SYMBOLS: <lt_table>      TYPE INDEX TABLE,
                 <l_entry>       TYPE ANY,
                 <l_entry_copy>  TYPE ANY.

  CHECK is_valid( ) = abap_true.

  CHECK i_index > 0.
  CHECK i_index <= entries( ).

  lr_table = get_tableref( ).
  CHECK lr_table IS BOUND.

  ASSIGN lr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  READ TABLE <lt_table> INDEX i_index ASSIGNING <l_entry>.
  CHECK sy-subrc = 0.

  TRY.
      CREATE DATA rr_entry LIKE <l_entry>.
    CATCH cx_root.
      RETURN.
  ENDTRY.

  ASSIGN rr_entry->* TO <l_entry_copy>.
  <l_entry_copy> = <l_entry>.

ENDMETHOD.


METHOD FIRST.

  rr_entry = at( 1 ).

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_indexed_itab.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_indexed_itab.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD index.

  DATA: lr_table  TYPE REF TO data.

  FIELD-SYMBOLS: <lt_table>  TYPE INDEX TABLE.

  CHECK is_valid( ) = abap_true.

  CHECK is_value_valid( i_value ) = abap_true.

  lr_table = get_tableref( ).
  CHECK lr_table IS BOUND.

  ASSIGN lr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  READ TABLE <lt_table> FROM i_value TRANSPORTING no fields.
  CHECK sy-subrc = 0.

  r_index = sy-tabix.

ENDMETHOD.


METHOD last.

  DATA: l_entries TYPE i.

  l_entries = entries( ).
  rr_entry = at( l_entries ).

ENDMETHOD.


METHOD remove_at.

  DATA: lr_table  TYPE REF TO data.

  FIELD-SYMBOLS: <lt_table>  TYPE INDEX TABLE.
  FIELD-SYMBOLS: <l_value>   TYPE any.

  CHECK is_valid( ) = abap_true.

  CHECK allows_delete( ) = abap_true.

  lr_table = get_tableref( ).
  CHECK lr_table IS BOUND.

  ASSIGN lr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  READ TABLE <lt_table> INDEX i_index ASSIGNING <l_value>.
  CHECK sy-subrc = 0.

  DELETE <lt_table> INDEX i_index.
  CHECK sy-subrc = 0.

  RAISE EVENT ev_value_removed
    EXPORTING
      e_value = <l_value>.

  r_success = abap_true.

ENDMETHOD.


METHOD replace.
  DATA: l_index_old TYPE i.

  l_index_old = index( i_value_old ).
  r_success = replace_at( i_index     = l_index_old
                          i_value_new = i_value_new ).

ENDMETHOD.


METHOD replace_at.

  DATA: lr_table  TYPE REF TO data,
        lr_entry  TYPE REF TO data.

  FIELD-SYMBOLS: <lt_table>  TYPE INDEX TABLE,
                 <l_entry>   TYPE any.

  CHECK is_valid( ) = abap_true.

  CHECK allows_update( ) = abap_true.

  IF allows_null_entries( ) = abap_false.
    CHECK i_value_new IS NOT INITIAL.
  ENDIF.

  CHECK is_value_valid( i_value_new ) = abap_true.

  lr_entry = at( i_index ).
  CHECK lr_entry IS BOUND.
  ASSIGN lr_entry->* TO <l_entry>.
  CHECK sy-subrc = 0.

  lr_table = get_tableref( ).
  CHECK lr_table IS BOUND.
  ASSIGN lr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  DELETE <lt_table> INDEX i_index.
  CHECK sy-subrc = 0.

  INSERT i_value_new INTO <lt_table> INDEX i_index.
  IF sy-subrc <> 0.
    INSERT <l_entry> INTO <lt_table> INDEX i_index.
    EXIT.
  ENDIF.

  RAISE EVENT ev_value_replaced
    EXPORTING
      e_value_old = <l_entry>
      e_value_new = i_value_new.

  r_success = abap_true.

ENDMETHOD.
ENDCLASS.
