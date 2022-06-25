class CL_ISH_COLLNODE_TREE definition
  public
  inheriting from CL_ISH_COLLNODE_LIST
  create public .

public section.
*"* public components of class CL_ISH_COLLNODE_TREE
*"* do not include other source files here!!!

  constants CO_OTYPE_COLLNODE_TREE type ISH_OBJECT_TYPE value 13418. "#EC NOTEXT

  methods APPEND_CHILD
    importing
      !I_CONTENT type ANY
      value(IR_PARENT_NODE) type ref to CL_ISH_COLLECTION_NODE optional
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  type-pools ABAP .
  methods MOVE_BELOW
    importing
      value(IR_NODE) type ref to CL_ISH_COLLECTION_NODE
      value(IR_PARENT_NODE) type ref to CL_ISH_COLLECTION_NODE
      !I_PREPEND type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods PREPEND_CHILD
    importing
      !I_CONTENT type ANY
      value(IR_PARENT_NODE) type ref to CL_ISH_COLLECTION_NODE optional
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COLLNODE_TREE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_COLLNODE_TREE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COLLNODE_TREE IMPLEMENTATION.


METHOD append_child.

  CHECK is_valid( ) = abap_true.

  CHECK ir_parent_node IS BOUND.

  rr_node = create_node( i_content ).

  IF ir_parent_node->insert_child( rr_node ) = abap_false.
    rr_node->destroy( ).
    CLEAR: rr_node.
    RETURN.
  ENDIF.

  RAISE EVENT ev_node_inserted
    EXPORTING
      er_node = rr_node.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_collnode_tree.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_collnode_tree.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD move_below.

  DATA: lr_first  TYPE REF TO cl_ish_collection_node,
        lr_last   TYPE REF TO cl_ish_collection_node.

  CHECK is_valid( ) = abap_true.

  CHECK ir_node        IS BOUND.
  CHECK ir_parent_node IS BOUND.

  IF ir_parent_node->gr_first_child IS BOUND.
    IF i_prepend = abap_true.
      r_success = move_before( ir_node      = ir_node
                               ir_next_node = ir_parent_node->gr_first_child ).
    ELSE.
      r_success = move_after( ir_node          = ir_node
                              ir_previous_node = ir_parent_node->gr_last_child ).
    ENDIF.
    RETURN.
  ENDIF.

  CHECK allows_update( ) = abap_true.

  IF gr_first = ir_node.
    lr_first = ir_node->gr_next.
  ELSE.
    lr_first = gr_first.
  ENDIF.

  IF gr_last = ir_node.
    lr_last = ir_node->gr_previous.
  ELSE.
    lr_last = gr_last.
  ENDIF.

  CHECK ir_parent_node->insert_child( ir_node ) = abap_true.

  gr_first = lr_first.
  gr_last  = lr_last.

  RAISE EVENT ev_node_moved
    EXPORTING
      er_node = ir_node.

  r_success = abap_true.

ENDMETHOD.


METHOD prepend_child.

  CHECK is_valid( ) = abap_true.

  CHECK ir_parent_node IS BOUND.

  rr_node = create_node( i_content ).

  IF ir_parent_node->insert_child( ir_node   = rr_node
                                   i_prepend = abap_true ) = abap_false.
    rr_node->destroy( ).
    CLEAR: rr_node.
    RETURN.
  ENDIF.

  RAISE EVENT ev_node_inserted
    EXPORTING
      er_node = rr_node.

ENDMETHOD.
ENDCLASS.
