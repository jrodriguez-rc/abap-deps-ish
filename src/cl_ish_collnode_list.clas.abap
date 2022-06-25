class CL_ISH_COLLNODE_LIST definition
  public
  inheriting from CL_ISH_NODE_COLLECTION
  create public .

public section.
*"* public components of class CL_ISH_COLLNODE_LIST
*"* do not include other source files here!!!

  constants CO_OTYPE_COLLNODE_LIST type ISH_OBJECT_TYPE value 13417. "#EC NOTEXT

  events EV_NODE_INSERTED
    exporting
      value(ER_NODE) type ref to CL_ISH_COLLECTION_NODE .
  events EV_NODE_MOVED
    exporting
      value(ER_NODE) type ref to CL_ISH_COLLECTION_NODE .
  events EV_NODE_REMOVED
    exporting
      value(ER_NODE) type ref to CL_ISH_COLLECTION_NODE .

  methods APPEND
    importing
      !I_CONTENT type ANY
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods AT
    importing
      !I_INDEX type I
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods FIRST
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods INSERT_AFTER
    importing
      !I_CONTENT type ANY
      value(IR_PREVIOUS_NODE) type ref to CL_ISH_COLLECTION_NODE
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods INSERT_AT
    importing
      !I_CONTENT type ANY
      !I_INDEX type I
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods INSERT_BEFORE
    importing
      !I_CONTENT type ANY
      value(IR_NEXT_NODE) type ref to CL_ISH_COLLECTION_NODE
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods LAST
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  type-pools ABAP .
  methods MOVE_AFTER
    importing
      value(IR_NODE) type ref to CL_ISH_COLLECTION_NODE
      value(IR_PREVIOUS_NODE) type ref to CL_ISH_COLLECTION_NODE
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods MOVE_BEFORE
    importing
      value(IR_NODE) type ref to CL_ISH_COLLECTION_NODE
      value(IR_NEXT_NODE) type ref to CL_ISH_COLLECTION_NODE
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods PREPEND
    importing
      !I_CONTENT type ANY
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods REMOVE
    importing
      value(IR_NODE) type ref to CL_ISH_COLLECTION_NODE
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods REMOVE_AT
    importing
      !I_INDEX type I
    returning
      value(R_SUCCESS) type ABAP_BOOL .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COLLNODE_LIST
*"* do not include other source files here!!!

  data GR_FIRST type ref to CL_ISH_COLLECTION_NODE .
  data GR_LAST type ref to CL_ISH_COLLECTION_NODE .

  methods _CLEAR
    redefinition .
  methods _ENTRIES
    redefinition .
  methods _IS_EMPTY
    redefinition .
private section.
*"* private components of class CL_ISH_COLLNODE_LIST
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COLLNODE_LIST IMPLEMENTATION.


METHOD append.

  CHECK is_valid( ) = abap_true.

  IF gr_last IS BOUND.
    rr_node = insert_after( i_content        = i_content
                            ir_previous_node = gr_last ).
    RETURN.
  ENDIF.

  CHECK allows_insert( ) = abap_true.

  rr_node = create_node( i_content ).
  CHECK rr_node IS BOUND.

  gr_first = rr_node.
  gr_last  = rr_node.

  RAISE EVENT ev_node_inserted
    EXPORTING
      er_node = rr_node.

ENDMETHOD.


METHOD at.

  DATA: l_index  TYPE i.

  CHECK is_valid( ) = abap_true.

  CHECK i_index > 0.

  rr_node = gr_first.
  l_index = 1.

  WHILE rr_node IS BOUND AND l_index < i_index.
    l_index = l_index + 1.
    rr_node = rr_node->gr_next.
  ENDWHILE.

ENDMETHOD.


METHOD first.

  CHECK is_valid( ) = abap_true.

  rr_node = gr_first.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_collnode_list.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_collnode_list.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD insert_after.

  CHECK is_valid( ) = abap_true.

  CHECK allows_insert( ) = abap_true.

  CHECK ir_previous_node IS BOUND.
  CHECK ir_previous_node->is_destroyed( ) = abap_false.

  rr_node = create_node( i_content ).
  CHECK rr_node IS BOUND.

  IF ir_previous_node->append( rr_node ) = abap_false.
    rr_node->destroy( ).
    CLEAR: rr_node.
    RETURN.
  ENDIF.

  IF ir_previous_node = gr_last.
    gr_last = rr_node.
  ENDIF.

  RAISE EVENT ev_node_inserted
    EXPORTING
      er_node = rr_node.

ENDMETHOD.


METHOD insert_at.

  DATA: lr_node  TYPE REF TO cl_ish_collection_node.

  IF i_index = 1.
    rr_node = prepend( i_content ).
    RETURN.
  ENDIF.

  lr_node = at( i_index ).
  CHECK lr_node IS BOUND.

  rr_node = insert_before( i_content    = i_content
                           ir_next_node = lr_node ).

ENDMETHOD.


METHOD insert_before.

  CHECK is_valid( ) = abap_true.

  CHECK allows_insert( ) = abap_true.

  CHECK ir_next_node IS BOUND.
  CHECK ir_next_node->is_destroyed( ) = abap_false.

  rr_node = create_node( i_content ).
  CHECK rr_node IS BOUND.

  IF ir_next_node->prepend( rr_node ) = abap_false.
    rr_node->destroy( ).
    CLEAR: rr_node.
    RETURN.
  ENDIF.

  IF ir_next_node = gr_first.
    gr_first = rr_node.
  ENDIF.

  RAISE EVENT ev_node_inserted
    EXPORTING
      er_node = rr_node.

ENDMETHOD.


METHOD last.

  CHECK is_valid( ) = abap_true.

  rr_node = gr_last.

ENDMETHOD.


METHOD move_after.

  DATA: lr_first  TYPE REF TO cl_ish_collection_node,
        lr_last   TYPE REF TO cl_ish_collection_node.

  CHECK is_valid( ) = abap_true.

  CHECK allows_update( ) = abap_true.

  CHECK ir_node      IS BOUND.
  CHECK ir_previous_node IS BOUND.

  IF gr_first = ir_node.
    lr_first = ir_node->gr_next.
  ELSE.
    lr_first = gr_first.
  ENDIF.

  IF gr_last = ir_previous_node.
    lr_last = ir_node.
  ELSEIF gr_last = ir_node.
    lr_last = ir_node->gr_previous.
  ELSE.
    lr_last = gr_last.
  ENDIF.

  CHECK ir_previous_node->append( ir_node ) = abap_true.

  gr_first = lr_first.
  gr_last  = lr_last.

  RAISE EVENT ev_node_moved
    EXPORTING
      er_node = ir_node.

  r_success = abap_true.

ENDMETHOD.


METHOD move_before.

  DATA: lr_first  TYPE REF TO cl_ish_collection_node,
        lr_last   TYPE REF TO cl_ish_collection_node.

  CHECK is_valid( ) = abap_true.

  CHECK allows_update( ) = abap_true.

  CHECK ir_node      IS BOUND.
  CHECK ir_next_node IS BOUND.

  IF gr_first = ir_next_node.
    lr_first = ir_node.
  ELSEIF gr_first = ir_node.
    lr_first = ir_node->gr_next.
  ELSE.
    lr_first = gr_first.
  ENDIF.

  IF gr_last = ir_node.
    lr_last = ir_node->gr_previous.
  ELSE.
    lr_last = gr_last.
  ENDIF.

  CHECK ir_next_node->prepend( ir_node ) = abap_true.

  gr_first = lr_first.
  gr_last  = lr_last.

  RAISE EVENT ev_node_moved
    EXPORTING
      er_node = ir_node.

  r_success = abap_true.

ENDMETHOD.


METHOD prepend.

  IF gr_first IS BOUND.
    rr_node = insert_before( i_content    = i_content
                             ir_next_node = gr_first ).
  ELSE.
    rr_node = append( i_content ).
  ENDIF.

ENDMETHOD.


METHOD remove.

  DATA: lr_first  TYPE REF TO cl_ish_collection_node,
        lr_last   TYPE REF TO cl_ish_collection_node.

  CHECK is_valid( ) = abap_true.

  CHECK allows_delete( ) = abap_true.

  CHECK ir_node IS BOUND.

  IF ir_node = gr_first.
    lr_first = ir_node->gr_next.
  ELSE.
    lr_first = gr_first.
  ENDIF.

  IF ir_node = gr_last.
    lr_last = ir_node->gr_previous.
  ELSE.
    lr_last = gr_last.
  ENDIF.

  CHECK ir_node->destroy( ) = abap_true.

  gr_first = lr_first.
  gr_last  = lr_last.

  RAISE EVENT ev_node_removed
    EXPORTING
      er_node = ir_node.

  r_success = abap_true.

ENDMETHOD.


METHOD remove_at.

  DATA: lr_node  TYPE REF TO cl_ish_collection_node.

  lr_node = at( i_index ).

  r_success = remove( lr_node ).

ENDMETHOD.


METHOD _clear.

  DATA: lr_node  TYPE REF TO cl_ish_collection_node,
        lr_next  TYPE REF TO cl_ish_collection_node.

  lr_node = gr_first.
  WHILE lr_node IS BOUND.
    lr_next = lr_node->gr_next.
    lr_node->destroy( ).
    lr_node = lr_next.
  ENDWHILE.

  r_success = super->_clear( ).

ENDMETHOD.


METHOD _entries.

  DATA: lr_node  TYPE REF TO cl_ish_collection_node.

  lr_node = gr_first.
  WHILE lr_node IS BOUND.
    r_entries = r_entries + 1.
    lr_node = lr_node->gr_next.
  ENDWHILE.

ENDMETHOD.


METHOD _is_empty.

  IF is_valid( ) = abap_true AND
     gr_first IS NOT BOUND.
    r_empty = abap_true.
  ELSE.
    r_empty = abap_false.
  ENDIF.

ENDMETHOD.
ENDCLASS.
