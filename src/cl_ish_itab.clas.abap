class CL_ISH_ITAB definition
  public
  inheriting from CL_ISH_COLLECTION
  abstract
  create public .

public section.
*"* public components of class CL_ISH_ITAB
*"* do not include other source files here!!!
  type-pools ABAP .

  constants CO_OTYPE_ITAB type ISH_OBJECT_TYPE value 13407. "#EC NOTEXT

  events EV_VALUE_INSERTED
    exporting
      value(E_VALUE) type ANY .
  events EV_VALUE_REMOVED
    exporting
      value(E_VALUE) type ANY .
  events EV_VALUE_REPLACED
    exporting
      value(E_VALUE_OLD) type ANY
      value(E_VALUE_NEW) type ANY .

  methods ALLOWS_NULL_ENTRIES
  final
    returning
      value(R_ALLOWS) type ABAP_BOOL .
  methods AS_ITAB
    exporting
      !E_SUCCESS type ABAP_BOOL
    changing
      !CT_TABLE type ANY TABLE .
  methods AS_ITAB_REF
    returning
      value(RR_TABLE) type ref to DATA .
  methods CONSTRUCTOR
    importing
      !I_ALLOW_NULL_ENTRIES type ABAP_BOOL default ABAP_FALSE
      !IR_OWNER type ref to IF_ISH_COLLECTION_OWNER optional .
  methods CONTAINS
    importing
      !I_VALUE type ANY
    returning
      value(R_CONTAINS) type ABAP_BOOL .
  methods INSERT
    importing
      !I_VALUE type ANY
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods INSERT_ITAB
    importing
      !IT_TABLE type ANY TABLE
    returning
      value(R_ENTRIES) type I .
  methods OCCURRENCES_OF
    importing
      !I_VALUE type ANY
    returning
      value(R_OCCURRENCES) type I .
  methods REMOVE
    importing
      !I_VALUE type ANY
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods REPLACE
  abstract
    importing
      !I_VALUE_OLD type ANY
      !I_VALUE_NEW type ANY
    returning
      value(R_SUCCESS) type ABAP_BOOL .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_ITAB
*"* do not include other source files here!!!

  methods CHECK_INITIALIZATION
  abstract
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods GET_LINEDESCR
  final
    returning
      value(RR_LINEDESCR) type ref to CL_ABAP_DATADESCR .
  methods GET_TABLEDESCR
  final
    returning
      value(RR_TABLEDESCR) type ref to CL_ABAP_TABLEDESCR .
  methods GET_TABLEREF
  final
    returning
      value(RR_TABLE) type ref to DATA .
  methods INITIALIZE
    importing
      !IR_TABLE type ref to DATA
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods IS_VALUE_VALID
    importing
      !I_VALUE type ANY
    returning
      value(R_VALID) type ABAP_BOOL .
  methods _INSERT
    importing
      !I_VALUE type ANY
    returning
      value(R_SUCCESS) type ABAP_BOOL .

  methods _CLEAR
    redefinition .
  methods _DESTROY
    redefinition .
  methods _ENTRIES
    redefinition .
  methods _IS_EMPTY
    redefinition .
  methods _IS_VALID
    redefinition .
private section.
*"* private components of class CL_ISH_ITAB
*"* do not include other source files here!!!

  data GR_LINEDESCR type ref to CL_ABAP_DATADESCR .
  data GR_TABLE type ref to DATA .
  data GR_TABLEDESCR type ref to CL_ABAP_TABLEDESCR .
  data G_ALLOW_NULL_ENTRIES type ABAP_BOOL value ABAP_FALSE. "#EC NOTEXT .
ENDCLASS.



CLASS CL_ISH_ITAB IMPLEMENTATION.


METHOD allows_null_entries.

  r_allows = g_allow_null_entries.

ENDMETHOD.


METHOD as_itab.

  FIELD-SYMBOLS: <lt_table>       TYPE ANY.

  CHECK gr_table IS BOUND.

  get_tabledescr( ).
  CHECK gr_tabledescr IS BOUND.

  CHECK gr_tabledescr->applies_to_data( ct_table ) = abap_true.

  ASSIGN gr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  ct_table = <lt_table>.

ENDMETHOD.


METHOD as_itab_ref.

  FIELD-SYMBOLS: <lt_table>       TYPE ANY,
                 <lt_table_copy>  TYPE ANY.

  CHECK gr_table IS BOUND.

  get_tabledescr( ).
  CHECK gr_tabledescr IS BOUND.

  TRY.
      CREATE DATA rr_table TYPE HANDLE gr_tabledescr.
    CATCH cx_root.
      RETURN.
  ENDTRY.

  ASSIGN gr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.
  ASSIGN rr_table->* TO <lt_table_copy>.
  CHECK sy-subrc = 0.

  <lt_table_copy> = <lt_table>.

ENDMETHOD.


METHOD constructor.

  CALL METHOD super->constructor
    EXPORTING
      ir_owner = ir_owner.

  g_allow_null_entries = i_allow_null_entries.

ENDMETHOD.


METHOD contains.
  DATA: l_lines TYPE i.
  FIELD-SYMBOLS: <lt_table>  TYPE ANY TABLE.

  CHECK is_value_valid( i_value ) = abap_true.

  CHECK gr_table IS BOUND.

  ASSIGN gr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  DESCRIBE TABLE <lt_table> LINES l_lines.
  CHECK l_lines > 0.

  READ TABLE <lt_table> FROM i_value TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_contains = abap_true.

ENDMETHOD.


METHOD GET_LINEDESCR.

  DATA: lr_tabledescr  TYPE REF TO cl_abap_tabledescr.

  rr_linedescr = gr_linedescr.

  CHECK rr_linedescr IS NOT BOUND.

  lr_tabledescr = get_tabledescr( ).
  CHECK lr_tabledescr IS BOUND.

  gr_linedescr = lr_tabledescr->get_table_line_type( ).

  rr_linedescr = gr_linedescr.

ENDMETHOD.


METHOD GET_TABLEDESCR.

  FIELD-SYMBOLS: <lt_table>  TYPE ANY TABLE.

  rr_tabledescr = gr_tabledescr.

  CHECK rr_tabledescr IS NOT BOUND.

  CHECK gr_table IS BOUND.

  ASSIGN gr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  TRY.
      gr_tabledescr ?= cl_abap_tabledescr=>describe_by_data( <lt_table> ).
    CATCH cx_root.
      RETURN.
  ENDTRY.

  rr_tabledescr = gr_tabledescr.

ENDMETHOD.


METHOD GET_TABLEREF.

  rr_table = gr_table.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_itab.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_itab.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD initialize.

  CHECK gr_table IS NOT BOUND.

  gr_table = ir_table.

  get_linedescr( ).
  CHECK gr_linedescr IS BOUND.

  r_success = check_initialization( ).

ENDMETHOD.


METHOD insert.

  FIELD-SYMBOLS: <lt_table>  TYPE ANY TABLE.

  CHECK is_valid( ) = abap_true.

  CHECK allows_insert( ) = abap_true.

  CHECK _insert( i_value ) = abap_true.

  RAISE EVENT ev_value_inserted
    EXPORTING
      e_value = i_value.

  r_success = abap_true.

ENDMETHOD.


METHOD insert_itab.

  FIELD-SYMBOLS: <l_entry>  TYPE ANY.

  CHECK allows_insert( ) = abap_true.

  LOOP AT it_table ASSIGNING <l_entry>.
    CHECK insert( <l_entry> ) = abap_true.
    r_entries = r_entries + 1.
  ENDLOOP.

ENDMETHOD.


METHOD is_value_valid.

  DATA: lr_linedescr   TYPE REF TO cl_abap_datadescr,
        lr_object      TYPE REF TO object,
        lr_data        TYPE REF TO data.

  lr_linedescr = get_linedescr( ).
  CHECK lr_linedescr IS BOUND.

  CASE lr_linedescr->type_kind.
    WHEN cl_abap_typedescr=>typekind_oref.
      TRY.
          lr_object ?= i_value.
        CATCH cx_root.
          RETURN.
      ENDTRY.
    WHEN cl_abap_typedescr=>typekind_dref.
      TRY.
          lr_data ?= i_value.
        CATCH cx_root.
          RETURN.
      ENDTRY.
    WHEN OTHERS.
      CHECK lr_linedescr->applies_to_data( i_value ) = abap_true.
  ENDCASE.

  r_valid = abap_true.

ENDMETHOD.


METHOD occurrences_of.

  FIELD-SYMBOLS: <lt_table>  TYPE ANY TABLE,
                 <l_entry>   TYPE ANY.

  CHECK is_value_valid( i_value ) = abap_true.

  CHECK gr_table IS BOUND.

  ASSIGN gr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  LOOP AT <lt_table> ASSIGNING <l_entry>.
    IF i_value = <l_entry>.
      r_occurrences = r_occurrences + 1.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD remove.

  FIELD-SYMBOLS: <lt_table>  TYPE ANY TABLE.

  CHECK allows_delete( ) = abap_true.

  CHECK is_value_valid( i_value ) = abap_true.

  CHECK gr_table IS BOUND.

  ASSIGN gr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  DELETE TABLE <lt_table> FROM i_value.
  CHECK sy-subrc = 0.

  RAISE EVENT ev_value_removed
    EXPORTING
      e_value = i_value.

  r_success = abap_true.

ENDMETHOD.


METHOD _clear.

  FIELD-SYMBOLS: <lt_table>  TYPE ANY TABLE.

  IF gr_table IS BOUND.
    ASSIGN gr_table->* TO <lt_table>.
    IF sy-subrc = 0.
      CLEAR: <lt_table>.
    ENDIF.
  ENDIF.

  r_success = abap_true.

ENDMETHOD.


METHOD _destroy.

  CLEAR: gr_table,
         gr_tabledescr,
         gr_linedescr.

  r_success = abap_true.

ENDMETHOD.


METHOD _entries.

  FIELD-SYMBOLS: <lt_table>  TYPE ANY TABLE.

  CHECK gr_table IS BOUND.

  ASSIGN gr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  r_entries = LINES( <lt_table> ).

ENDMETHOD.


METHOD _insert.

  FIELD-SYMBOLS: <lt_table>  TYPE ANY TABLE.

  IF allows_null_entries( ) = abap_false.
    CHECK i_value IS NOT INITIAL.
  ENDIF.

  CHECK is_value_valid( i_value ) = abap_true.

  CHECK gr_table IS BOUND.

  ASSIGN gr_table->* TO <lt_table>.
  CHECK sy-subrc = 0.

  INSERT i_value INTO TABLE <lt_table>.
  CHECK sy-subrc = 0.

  r_success = abap_true.

ENDMETHOD.


METHOD _is_empty.

  IF _entries( ) < 1.
    r_empty = abap_true.
  ENDIF.

ENDMETHOD.


METHOD _is_valid.

  CHECK super->_is_valid( ) = abap_true.

  CHECK get_tableref( ) IS BOUND.

  CHECK get_tabledescr( ) IS BOUND.

  CHECK get_linedescr( ) IS BOUND.

  r_valid = abap_true.

ENDMETHOD.
ENDCLASS.
