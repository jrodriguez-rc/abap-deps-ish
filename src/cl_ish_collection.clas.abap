class CL_ISH_COLLECTION definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_COLLECTION
*"* do not include other source files here!!!
  type-pools ABAP .

  interfaces IF_ISH_COLLECTION_OWNER .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases ALLOWS_DELETE
    for IF_ISH_COLLECTION_OWNER~ALLOWS_DELETE .
  aliases ALLOWS_INSERT
    for IF_ISH_COLLECTION_OWNER~ALLOWS_INSERT .
  aliases ALLOWS_UPDATE
    for IF_ISH_COLLECTION_OWNER~ALLOWS_UPDATE .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_COLLECTION type ISH_OBJECT_TYPE value 13406. "#EC NOTEXT

  events EV_CLEARED .
  events EV_DESTROYED .

  methods CLEAR
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods CONSTRUCTOR
    importing
      !IR_OWNER type ref to IF_ISH_COLLECTION_OWNER optional .
  methods DESTROY
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods ENTRIES
    returning
      value(R_ENTRIES) type I .
  methods IS_DESTROYED
    returning
      value(R_DESTROYED) type ABAP_BOOL .
  methods IS_EMPTY
    returning
      value(R_EMPTY) type ABAP_BOOL .
  methods IS_VALID
    returning
      value(R_VALID) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_COLLECTION
*"* do not include other source files here!!!

  data GR_OWNER type ref to IF_ISH_COLLECTION_OWNER .
  data G_DESTROYED type ABAP_BOOL .

  methods _CLEAR
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods _DESTROY
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods _ENTRIES
  abstract
    returning
      value(R_ENTRIES) type I .
  methods _IS_EMPTY
  abstract
    returning
      value(R_EMPTY) type ABAP_BOOL .
  methods _IS_VALID
    returning
      value(R_VALID) type ABAP_BOOL .
private section.
*"* private components of class CL_ISH_COLLECTION
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COLLECTION IMPLEMENTATION.


METHOD clear.

  CHECK is_valid( ) = abap_true.

  CHECK allows_delete( ) = abap_true.

  CHECK _clear( ) = abap_true.

  RAISE EVENT ev_cleared.

  r_success = abap_true.

ENDMETHOD.


METHOD constructor.

  gr_owner = ir_owner.

ENDMETHOD.


METHOD destroy.

  CHECK is_destroyed( ) = abap_false.

  CHECK allows_delete( ) = abap_true.

  CHECK _clear( ) = abap_true.

  CHECK _destroy( ) = abap_true.

  CLEAR: gr_owner.

  g_destroyed = abap_true.

  RAISE EVENT ev_destroyed.

  r_success = abap_true.

ENDMETHOD.


METHOD entries.

  CHECK is_valid( ) = abap_true.

  r_entries = _entries( ).

ENDMETHOD.


METHOD if_ish_collection_owner~allows_delete.

  r_allows = abap_true.

  IF gr_owner IS BOUND.
    r_allows = gr_owner->allows_delete( ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_collection_owner~allows_insert.

  r_allows = abap_true.

  IF gr_owner IS BOUND.
    r_allows = gr_owner->allows_insert( ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_collection_owner~allows_update.

  r_allows = abap_true.

  IF gr_owner IS BOUND.
    r_allows = gr_owner->allows_update( ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_collection.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_object_type  TYPE ish_object_type.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF l_object_type = i_object_type.
    r_is_a = abap_true.
  ELSE.
    r_is_a = abap_false.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_collection.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = abap_false.
  ENDIF.

ENDMETHOD.


METHOD is_destroyed.

  r_destroyed = g_destroyed.

ENDMETHOD.


METHOD is_empty.

  IF is_valid( ) = abap_false.
    r_empty = abap_true.
    RETURN.
  ENDIF.

  r_empty = _is_empty( ).

ENDMETHOD.


METHOD is_valid.

  CHECK is_destroyed( ) = abap_false.

  r_valid = _is_valid( ).

ENDMETHOD.


METHOD _clear.

  r_success = abap_true.

ENDMETHOD.


METHOD _destroy.

  r_success = abap_true.

ENDMETHOD.


METHOD _is_valid.

  r_valid = abap_true.

ENDMETHOD.
ENDCLASS.
