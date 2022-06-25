class CL_ISH_GM_CHILD_NODE definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_GM_CHILD_NODE
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_GUI_CHILD_NODE_MODEL .
  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_NODE_MODEL .

  aliases CO_RELAT_FIRST_CHILD
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_FIRST_CHILD .
  aliases CO_RELAT_FIRST_SIBLING
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_FIRST_SIBLING .
  aliases CO_RELAT_LAST_CHILD
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_LAST_CHILD .
  aliases CO_RELAT_LAST_SIBLING
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_LAST_SIBLING .
  aliases CO_RELAT_NEXT_SIBLING
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_NEXT_SIBLING .
  aliases CO_RELAT_PREV_SIBLING
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_PREV_SIBLING .
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
      !IR_PARENT_NODE type ref to IF_ISH_GUI_PARENT_NODE_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GM_CHILD_NODE
*"* do not include other source files here!!!

  data GR_PARENT_NODE type ref to IF_ISH_GUI_PARENT_NODE_MODEL .
private section.
*"* private components of class CL_ISH_GM_CHILD_NODE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_CHILD_NODE IMPLEMENTATION.


METHOD constructor.

  IF ir_parent_node IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
       i_typ        = 'E'
       i_kla        = 'N1BASE'
       i_num        = '030'
       i_mv1        = '1'
       i_mv2        = 'CONSTRUCTOR'
       i_mv3        = 'CL_ISH_GM_CHILD_NODE' ).
  ENDIF.

  gr_parent_node  = ir_parent_node.

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
