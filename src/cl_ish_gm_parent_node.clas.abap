class CL_ISH_GM_PARENT_NODE definition
  public
  inheriting from CL_ISH_GM_XTABLE
  abstract
  create public .

*"* public components of class CL_ISH_GM_PARENT_NODE
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_GUI_NODE_MODEL .
  interfaces IF_ISH_GUI_PARENT_NODE_MODEL .

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
  aliases GET_CHILD_NODES
    for IF_ISH_GUI_PARENT_NODE_MODEL~GET_CHILD_NODES .
  aliases GET_FIRST_CHILD_NODE
    for IF_ISH_GUI_PARENT_NODE_MODEL~GET_FIRST_CHILD_NODE .
  aliases GET_LAST_CHILD_NODE
    for IF_ISH_GUI_PARENT_NODE_MODEL~GET_LAST_CHILD_NODE .
  aliases GET_NEXT_CHILD_NODE
    for IF_ISH_GUI_PARENT_NODE_MODEL~GET_NEXT_CHILD_NODE .
  aliases GET_PREVIOUS_CHILD_NODE
    for IF_ISH_GUI_PARENT_NODE_MODEL~GET_PREVIOUS_CHILD_NODE .

  constants CO_AE_ALL type I value 0. "#EC NOTEXT
  constants CO_AE_CHILD_NODES type I value 2. "#EC NOTEXT
  constants CO_AE_NODES type I value 1. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_XTABMDL type ref to IF_ISH_GUI_CB_XTABLE_MODEL optional
      !I_ALLOWED_ENTRIES type I default CO_AE_ALL
    preferred parameter IR_CB_TABMDL .
protected section.
*"* protected components of class CL_ISH_GM_PARENT_NODE
*"* do not include other source files here!!!

  data G_ALLOWED_ENTRIES type I value 0. "#EC NOTEXT .

  methods _CHECK_ADD_ENTRY
    redefinition .
private section.
*"* private components of class CL_ISH_GM_PARENT_NODE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_PARENT_NODE IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      ir_cb_tabmdl  = ir_cb_tabmdl
      ir_cb_xtabmdl = ir_cb_xtabmdl ).

  g_allowed_entries = i_allowed_entries.

ENDMETHOD.


METHOD if_ish_gui_parent_node_model~get_child_nodes.

  DATA lt_entry           TYPE ish_t_gui_model_objhash.
  DATA lr_entry           TYPE REF TO if_ish_gui_model.
  DATA lr_child_node      TYPE REF TO if_ish_gui_child_node_model.

  lt_entry = get_entries( ).

  LOOP AT lt_entry INTO lr_entry.
    TRY.
        lr_child_node ?= lr_entry.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
    INSERT lr_child_node INTO TABLE rt_child_node.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_parent_node_model~get_first_child_node.

  DATA lr_entry           TYPE REF TO if_ish_gui_model.

  get_entries( ).

  LOOP AT gt_entry INTO lr_entry.
    TRY.
        rr_first_child_node ?= lr_entry.
        RETURN.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_parent_node_model~get_last_child_node.

  DATA lr_entry           TYPE REF TO if_ish_gui_model.
  DATA l_idx              TYPE i.

  get_entries( ).

  l_idx = LINES( gt_entry ).
  CHECK l_idx > 0.

  WHILE l_idx > 0 AND rr_last_child_node IS NOT BOUND.
    READ TABLE gt_entry INDEX l_idx INTO lr_entry.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    TRY.
        rr_last_child_node ?= lr_entry.
      CATCH cx_sy_move_cast_error.
        CLEAR rr_last_child_node.
    ENDTRY.
    l_idx = l_idx - 1.
  ENDWHILE.

ENDMETHOD.


METHOD if_ish_gui_parent_node_model~get_next_child_node.

  DATA lr_next_entry            TYPE REF TO if_ish_gui_model.

  lr_next_entry = get_next_entry( ir_previous_entry = ir_previous_child_node ).

  WHILE lr_next_entry IS BOUND AND rr_next_child_node IS NOT BOUND.
    TRY.
        rr_next_child_node ?= lr_next_entry.
        RETURN.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
    lr_next_entry = get_next_entry( ir_previous_entry = lr_next_entry ).
  ENDWHILE.

ENDMETHOD.


METHOD if_ish_gui_parent_node_model~get_previous_child_node.

  DATA lr_previous_entry              TYPE REF TO if_ish_gui_model.

  lr_previous_entry = get_previous_entry( ir_next_entry = ir_next_child_node ).

  WHILE lr_previous_entry IS BOUND AND rr_previous_child_node IS NOT BOUND.
    TRY.
        rr_previous_child_node ?= lr_previous_entry.
        RETURN.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
    lr_previous_entry = get_previous_entry( ir_next_entry = lr_previous_entry ).
  ENDWHILE.

ENDMETHOD.


METHOD _check_add_entry.

  DATA lr_child_node            TYPE REF TO if_ish_gui_child_node_model.
  DATA lr_node                  TYPE REF TO if_ish_gui_node_model.

  TRY.
      lr_child_node ?= ir_entry.
      IF g_allowed_entries = co_ae_child_nodes AND
         lr_child_node->get_parent_node( ) <> me.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '3'
            i_mv2        = '_CHECK_ADD_ENTRY'
            i_mv3        = 'CL_ISH_GM_PARENT_NODE' ).
      ENDIF.
    CATCH cx_sy_move_cast_error.
      IF g_allowed_entries = co_ae_child_nodes.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '1'
            i_mv2        = '_CHECK_ADD_ENTRY'
            i_mv3        = 'CL_ISH_GM_PARENT_NODE' ).
      ENDIF.
      TRY.
          lr_node ?= ir_entry.
        CATCH cx_sy_move_cast_error.
          IF g_allowed_entries = co_ae_nodes.
            cl_ish_utl_exception=>raise_static(
                i_typ        = 'E'
                i_kla        = 'N1BASE'
                i_num        = '030'
                i_mv1        = '2'
                i_mv2        = '_CHECK_ADD_ENTRY'
                i_mv3        = 'CL_ISH_GM_PARENT_NODE' ).
          ENDIF.
      ENDTRY.
  ENDTRY.

ENDMETHOD.
ENDCLASS.
