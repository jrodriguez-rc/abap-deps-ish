class CL_ISH_COLLECTION_NODE definition
  public
  abstract
  create public

  global friends CL_ISH_NODE_COLLECTION .

public section.
*"* public components of class CL_ISH_COLLECTION_NODE
*"* do not include other source files here!!!

  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_COLLECTION_NODE type ISH_OBJECT_TYPE value 13419. "#EC NOTEXT

  methods CHILD_AT
    importing
      !I_INDEX type I
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods CLEAR_CONTENT
  abstract .
  methods FIRST_CHILD
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  type-pools ABAP .
  methods GET_CONTENT
  abstract
    exporting
      !E_SUCCESS type ABAP_BOOL
    changing
      !C_CONTENT type ANY .
  methods IS_ANY_CHILD_OF
  final
    importing
      value(IR_NODE) type ref to CL_ISH_COLLECTION_NODE
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods IS_DESTROYED
  final
    returning
      value(R_DESTROYED) type ABAP_BOOL .
  methods LAST_CHILD
    importing
      !I_WITH_SUBCHILDREN type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods NEXT
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods NEXT_SIBLING
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods NR_OF_CHILDREN
    importing
      !I_WITH_SUBCHILDREN type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_NR) type I .
  methods NR_OF_NEXT_SIBLINGS
    returning
      value(R_NR) type I .
  methods NR_OF_PREVIOUS_SIBLINGS
    returning
      value(R_NR) type I .
  methods NR_OF_SIBLINGS
    returning
      value(R_NR) type I .
  methods PARENT
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods PREVIOUS
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods PREVIOUS_SIBLING
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
  methods SET_CONTENT
  abstract
    importing
      !I_CONTENT type ANY
    returning
      value(R_SUCCESS) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_COLLECTION_NODE
*"* do not include other source files here!!!

  data GR_FIRST_CHILD type ref to CL_ISH_COLLECTION_NODE .
  data GR_LAST_CHILD type ref to CL_ISH_COLLECTION_NODE .
  data GR_NEXT type ref to CL_ISH_COLLECTION_NODE .
  data GR_PARENT type ref to CL_ISH_COLLECTION_NODE .
  data GR_PREVIOUS type ref to CL_ISH_COLLECTION_NODE .
  data G_DESTROYED type ABAP_BOOL value ABAP_FALSE. "#EC NOTEXT .

  methods APPEND
    importing
      value(IR_NODE) type ref to CL_ISH_COLLECTION_NODE
      !I_WITH_CHILDREN type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods CUT
    importing
      !I_WITH_CHILDREN type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods DESTROY
    importing
      !I_WITH_CHILDREN type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods INSERT_CHILD
    importing
      value(IR_NODE) type ref to CL_ISH_COLLECTION_NODE
      !I_WITH_CHILDREN type ABAP_BOOL default ABAP_TRUE
      !I_PREPEND type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods PREPEND
    importing
      value(IR_NODE) type ref to CL_ISH_COLLECTION_NODE
      !I_WITH_CHILDREN type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_SUCCESS) type ABAP_BOOL .
private section.
*"* private components of class CL_ISH_COLLECTION_NODE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COLLECTION_NODE IMPLEMENTATION.


METHOD append.

  CHECK is_destroyed( ) = abap_false.

  CHECK ir_node IS BOUND.
  CHECK ir_node <> me.
  IF i_with_children = abap_true.
    CHECK is_any_child_of( ir_node ) = abap_false.
  ENDIF.

  CHECK ir_node->cut( i_with_children ) = abap_true.

  ir_node->gr_parent   = gr_parent.
  ir_node->gr_previous = me.
  ir_node->gr_next     = gr_next.

  IF gr_parent IS BOUND.
    IF gr_parent->gr_last_child = me.
      gr_parent->gr_last_child = ir_node.
    ENDIF.
  ENDIF.

  IF gr_next IS BOUND.
    gr_next->gr_previous = ir_node.
  ENDIF.

  gr_next = ir_node.

  r_success = abap_true.

ENDMETHOD.


METHOD child_at.

  DATA: l_index  TYPE i.

  CHECK is_destroyed( ) = abap_false.

  CHECK i_index > 0.

  rr_node = gr_first_child.
  l_index = 1.

  WHILE rr_node IS BOUND AND l_index < i_index.
    l_index = l_index + 1.
    rr_node = rr_node->gr_next.
  ENDWHILE.

ENDMETHOD.


METHOD cut.

  DATA: lr_node  TYPE REF TO cl_ish_collection_node.

  CHECK is_destroyed( ) = abap_false.

  IF gr_previous IS BOUND.
    IF i_with_children = abap_false AND gr_first_child IS BOUND.
      gr_previous->gr_next = gr_first_child.
    ELSE.
      gr_previous->gr_next = gr_next.
    ENDIF.
  ENDIF.

  IF gr_next IS BOUND.
    IF i_with_children = abap_false AND gr_last_child IS BOUND.
      gr_next->gr_previous = gr_last_child.
    ELSE.
      gr_next->gr_previous = gr_previous.
    ENDIF.
  ENDIF.

  IF gr_parent IS BOUND AND gr_parent->gr_first_child = me.
    IF i_with_children = abap_false AND gr_first_child IS BOUND.
      gr_parent->gr_first_child = gr_first_child.
    ELSE.
      gr_parent->gr_first_child = gr_next.
    ENDIF.
  ENDIF.

  IF gr_parent IS BOUND AND gr_parent->gr_last_child = me.
    IF i_with_children = abap_false AND gr_last_child IS BOUND.
      gr_parent->gr_last_child = gr_last_child.
    ELSE.
      gr_parent->gr_last_child = gr_previous.
    ENDIF.
  ENDIF.

  IF i_with_children = abap_false.
    lr_node = gr_first_child.
    WHILE lr_node IS BOUND.
      lr_node->gr_parent = gr_parent.
      lr_node = lr_node->gr_next.
    ENDWHILE.
    IF gr_first_child IS BOUND.
      gr_first_child->gr_previous = gr_previous.
    ENDIF.
    IF gr_last_child IS BOUND.
      gr_last_child->gr_next = gr_next.
    ENDIF.
  ENDIF.

  CLEAR: gr_parent,
         gr_previous,
         gr_next.
  IF i_with_children = abap_false.
    CLEAR: gr_first_child,
           gr_last_child.
  ENDIF.

  r_success = abap_true.

ENDMETHOD.


METHOD destroy.

  DATA: lr_node      TYPE REF TO cl_ish_collection_node,
        lr_next      TYPE REF TO cl_ish_collection_node.

  CHECK is_destroyed( ) = abap_false.

  CHECK cut( i_with_children ) = abap_true.

  lr_node = gr_first_child.
  WHILE lr_node IS BOUND.
    lr_next = lr_node->gr_next.
    lr_node->destroy( i_with_children ).
    lr_node = lr_next.
  ENDWHILE.

  clear_content( ).

  CLEAR: gr_parent,
         gr_previous,
         gr_next,
         gr_first_child,
         gr_last_child.

  g_destroyed = abap_true.

ENDMETHOD.


METHOD first_child.

  CHECK is_destroyed( ) = abap_false.

  rr_node = gr_first_child.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_collection_node.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_object_type  TYPE ish_object_type.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF i_object_type = l_object_type.
    r_is_a = abap_true.
  ELSE.
    r_is_a = abap_false.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_collection_node.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = abap_false.
  ENDIF.

ENDMETHOD.


METHOD insert_child.

  CHECK is_destroyed( ) = abap_false.

  IF gr_first_child IS BOUND.
    IF i_prepend = abap_false.
      r_success = gr_last_child->append( ir_node         = ir_node
                                         i_with_children = i_with_children ).
    ELSE.
      r_success = gr_first_child->prepend( ir_node         = ir_node
                                           i_with_children = i_with_children ).
    ENDIF.
    RETURN.
  ENDIF.

  CHECK ir_node IS BOUND.
  CHECK ir_node <> me.
  IF i_with_children = abap_true.
    CHECK is_any_child_of( ir_node ) = abap_false.
  ENDIF.

  CHECK ir_node->cut( i_with_children ) = abap_true.

  ir_node->gr_parent = me.

  gr_first_child = ir_node.
  gr_last_child  = ir_node.

  r_success = abap_true.

ENDMETHOD.


METHOD is_any_child_of.

  DATA: lr_node  TYPE REF TO cl_ish_collection_node.

  CHECK is_destroyed( ) = abap_false.

  CHECK ir_node IS BOUND.
  CHECK ir_node->is_destroyed( ) = abap_false.

  lr_node = gr_parent.
  WHILE lr_node IS BOUND AND r_success = abap_false.
    IF lr_node = ir_node.
      r_success = abap_true.
    ELSE.
      lr_node = lr_node->gr_parent.
    ENDIF.
  ENDWHILE.

ENDMETHOD.


METHOD is_destroyed.

  r_destroyed = g_destroyed.

ENDMETHOD.


METHOD last_child.

  CHECK is_destroyed( ) = abap_false.

  rr_node = gr_last_child.
  CHECK rr_node IS BOUND.

  IF i_with_subchildren = abap_true.
    WHILE rr_node->gr_last_child IS BOUND.
      rr_node = rr_node->gr_last_child.
    ENDWHILE.
  ENDIF.

ENDMETHOD.


METHOD next.

  DATA: lr_parent  TYPE REF TO cl_ish_collection_node.

  CHECK is_destroyed( ) = abap_false.

  rr_node = gr_first_child.
  IF rr_node IS NOT BOUND.
    rr_node = gr_next.
    IF rr_node IS NOT BOUND.
      lr_parent = gr_parent.
      WHILE lr_parent IS BOUND AND rr_node IS NOT BOUND.
        rr_node = lr_parent->gr_next.
        IF rr_node IS NOT BOUND.
          lr_parent = lr_parent->gr_parent.
        ENDIF.
      ENDWHILE.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD next_sibling.

  CHECK is_destroyed( ) = abap_false.

  rr_node = gr_next.

ENDMETHOD.


METHOD nr_of_children.

  DATA: lr_node   TYPE REF TO cl_ish_collection_node.

  lr_node = gr_first_child.
  WHILE lr_node IS BOUND.
    r_nr = r_nr + 1.
    IF i_with_subchildren = abap_true.
      r_nr = r_nr + + lr_node->nr_of_children( i_with_subchildren ).
    ENDIF.
    lr_node = lr_node->gr_next.
  ENDWHILE.

ENDMETHOD.


METHOD nr_of_next_siblings.

  DATA: lr_node  TYPE REF TO cl_ish_collection_node.

  lr_node = gr_next.
  WHILE lr_node IS BOUND.
    r_nr = r_nr + 1.
    lr_node = lr_node->gr_next.
  ENDWHILE.

ENDMETHOD.


METHOD nr_of_previous_siblings.

  DATA: lr_node  TYPE REF TO cl_ish_collection_node.

  lr_node = gr_previous.
  WHILE lr_node IS BOUND.
    r_nr = r_nr + 1.
    lr_node = lr_node->gr_previous.
  ENDWHILE.

ENDMETHOD.


METHOD nr_of_siblings.

  r_nr = nr_of_next_siblings( ) + nr_of_previous_siblings( ).

ENDMETHOD.


METHOD parent.

  CHECK is_destroyed( ) = abap_false.

  rr_node = gr_parent.

ENDMETHOD.


METHOD prepend.

  CHECK is_destroyed( ) = abap_false.

  CHECK ir_node IS BOUND.
  CHECK ir_node <> me.
  IF i_with_children = abap_true.
    CHECK is_any_child_of( ir_node ) = abap_false.
  ENDIF.

  CHECK ir_node->cut( i_with_children ) = abap_true.

  ir_node->gr_parent   = gr_parent.
  ir_node->gr_next     = me.
  ir_node->gr_previous = gr_previous.

  IF gr_parent IS BOUND.
    IF gr_parent->gr_first_child = me.
      gr_parent->gr_first_child = ir_node.
    ENDIF.
  ENDIF.

  IF gr_previous IS BOUND.
    gr_previous->gr_next = ir_node.
  ENDIF.

  gr_previous = ir_node.

  r_success = abap_true.

ENDMETHOD.


METHOD previous.

  CHECK is_destroyed( ) = abap_false.

  IF gr_previous IS BOUND.
    rr_node = gr_previous->last_child( abap_true ).
    IF rr_node IS NOT BOUND.
      rr_node = gr_previous.
    ENDIF.
  ELSE.
    rr_node = gr_parent.
  ENDIF.

ENDMETHOD.


METHOD previous_sibling.

  CHECK is_destroyed( ) = abap_false.

  rr_node = gr_previous.

ENDMETHOD.
ENDCLASS.
