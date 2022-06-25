class CL_ISH_GM_PARENTCHILD_NODE definition
  public
  inheriting from CL_ISH_GM_PARENT_NODE
  abstract
  create public .

*"* public components of class CL_ISH_GM_PARENTCHILD_NODE
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_GUI_CHILD_NODE_MODEL .

  aliases GET_FIRST_SIBLING
    for IF_ISH_GUI_CHILD_NODE_MODEL~GET_FIRST_SIBLING .
  aliases GET_LAST_SIBLING
    for IF_ISH_GUI_CHILD_NODE_MODEL~GET_LAST_SIBLING .
  aliases GET_NEXT_SIBLING
    for IF_ISH_GUI_CHILD_NODE_MODEL~GET_NEXT_SIBLING .
  aliases GET_PARENT_NODE
    for IF_ISH_GUI_CHILD_NODE_MODEL~GET_PARENT_NODE .
  aliases GET_PREVIOUS_SIBLING
    for IF_ISH_GUI_CHILD_NODE_MODEL~GET_PREVIOUS_SIBLING .

  methods CONSTRUCTOR
    importing
      !IR_PARENT_NODE type ref to IF_ISH_GUI_PARENT_NODE_MODEL optional
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_XTABMDL type ref to IF_ISH_GUI_CB_XTABLE_MODEL optional
      !I_ALLOWED_ENTRIES type I default CO_AE_ALL
    preferred parameter IR_CB_TABMDL
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GM_PARENTCHILD_NODE
*"* do not include other source files here!!!

  data GR_PARENT_NODE type ref to IF_ISH_GUI_PARENT_NODE_MODEL .
private section.
*"* private components of class CL_ISH_GM_PARENTCHILD_NODE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_PARENTCHILD_NODE IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      ir_cb_tabmdl      = ir_cb_tabmdl
      ir_cb_xtabmdl     = ir_cb_xtabmdl
      i_allowed_entries = i_allowed_entries ).

  gr_parent_node = ir_parent_node.

ENDMETHOD.


METHOD if_ish_gui_child_node_model~get_first_sibling.

  DATA lr_parent_node           TYPE REF TO if_ish_gui_parent_node_model.

  lr_parent_node = get_parent_node( ).
  CHECK lr_parent_node IS BOUND.

  rr_first_sibling = lr_parent_node->get_first_child_node( ).

ENDMETHOD.


METHOD if_ish_gui_child_node_model~get_last_sibling.

  DATA lr_parent_node           TYPE REF TO if_ish_gui_parent_node_model.

  lr_parent_node = get_parent_node( ).
  CHECK lr_parent_node IS BOUND.

  rr_last_sibling = lr_parent_node->get_last_child_node( ).

ENDMETHOD.


METHOD if_ish_gui_child_node_model~get_next_sibling.

  DATA lr_parent_node           TYPE REF TO if_ish_gui_parent_node_model.

  lr_parent_node = get_parent_node( ).
  CHECK lr_parent_node IS BOUND.

  rr_next_sibling = lr_parent_node->get_next_child_node(
      ir_previous_child_node = me ).

ENDMETHOD.


METHOD if_ish_gui_child_node_model~get_parent_node.

  rr_parent_node = gr_parent_node.

ENDMETHOD.


METHOD if_ish_gui_child_node_model~get_previous_sibling.

  DATA lr_parent_node           TYPE REF TO if_ish_gui_parent_node_model.

  lr_parent_node = get_parent_node( ).
  CHECK lr_parent_node IS BOUND.

  rr_previous_sibling = lr_parent_node->get_previous_child_node(
      ir_next_child_node = me ).

ENDMETHOD.
ENDCLASS.
