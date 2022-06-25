class CL_ISH_GM_TABLE definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_GM_TABLE
*"* do not include other source files here!!!

  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_TABLE_MODEL .
  interfaces IF_ISH_GUI_TREENODE_MODEL .

  aliases ADD_ENTRY
    for IF_ISH_GUI_TABLE_MODEL~ADD_ENTRY .
  aliases DESTROY
    for IF_ISH_DESTROYABLE~DESTROY .
  aliases GET_ENTRIES
    for IF_ISH_GUI_TABLE_MODEL~GET_ENTRIES .
  aliases GET_NODE_ICON
    for IF_ISH_GUI_TREENODE_MODEL~GET_NODE_ICON .
  aliases GET_NODE_TEXT
    for IF_ISH_GUI_TREENODE_MODEL~GET_NODE_TEXT .
  aliases IS_DESTROYED
    for IF_ISH_DESTROYABLE~IS_DESTROYED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_DESTROYABLE~IS_IN_DESTROY_MODE .
  aliases REMOVE_ENTRY
    for IF_ISH_GUI_TABLE_MODEL~REMOVE_ENTRY .
  aliases EV_AFTER_DESTROY
    for IF_ISH_DESTROYABLE~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_DESTROYABLE~EV_BEFORE_DESTROY .
  aliases EV_ENTRY_ADDED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_ADDED .
  aliases EV_ENTRY_REMOVED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_REMOVED .

  class-methods CREATE
    importing
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IT_ENTRY type ISH_T_GUI_MODEL_OBJHASH optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_TABLE .
  methods CONSTRUCTOR
    importing
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IT_ENTRY type ISH_T_GUI_MODEL_OBJHASH optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
    preferred parameter IR_CB_TABMDL .
  type-pools ABAP .
  methods HAS_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_HAS_ENTRY) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_GM_TABLE
*"* do not include other source files here!!!

  data GR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE .
  data GR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL .
  data GT_ENTRY type ISH_T_GUI_MODEL_OBJHASH .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .
  data G_NODE_ICON type TV_IMAGE .
  data G_NODE_TEXT type LVC_VALUE .

  methods _DESTROY .
private section.
*"* private components of class CL_ISH_GM_TABLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_TABLE IMPLEMENTATION.


METHOD constructor.

  gr_cb_tabmdl      = ir_cb_tabmdl.
  gr_cb_destroyable = ir_cb_destroyable.
  gt_entry          = it_entry.
  g_node_text       = i_node_text.
  g_node_icon       = i_node_icon.

ENDMETHOD.


METHOD create.

  CREATE OBJECT rr_instance
    EXPORTING
      ir_cb_tabmdl      = ir_cb_tabmdl
      ir_cb_destroyable = ir_cb_destroyable
      it_entry          = it_entry
      i_node_text       = i_node_text
      i_node_icon       = i_node_icon.

ENDMETHOD.


METHOD has_entry.

  READ TABLE gt_entry
    WITH TABLE KEY table_line = ir_entry
    TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_has_entry = abap_true.

ENDMETHOD.


METHOD if_ish_destroyable~destroy.

* Process only if we are not already destroyed or in destroy mode.
  CHECK is_destroyed( )       = abap_false.
  CHECK is_in_destroy_mode( ) = abap_false.

* Callback.
  IF gr_cb_destroyable IS BOUND.
    CHECK gr_cb_destroyable->cb_destroy( ir_destroyable = me ) = abap_true.
  ENDIF.

* Raise event before_destroy.
  RAISE EVENT ev_before_destroy.

* Set self in destroy mode.
  g_destroy_mode = abap_true.

* Destroy.
  _destroy( ).

* We are destroyed.
  g_destroy_mode = abap_false.
  g_destroyed    = abap_true.

* Export.
  r_destroyed = abap_true.

* Raise event after_destroy.
  RAISE EVENT ev_after_destroy.

ENDMETHOD.


METHOD if_ish_destroyable~is_destroyed.

  r_destroyed = g_destroyed.

ENDMETHOD.


METHOD if_ish_destroyable~is_in_destroy_mode.

  r_destroy_mode = g_destroy_mode.

ENDMETHOD.


METHOD if_ish_gui_table_model~add_entry.

  CHECK ir_entry IS BOUND.
  CHECK ir_entry <> me.

  IF gr_cb_tabmdl IS BOUND.
    CHECK gr_cb_tabmdl->cb_add_entry(
              ir_model   = me
              ir_entry   = ir_entry ) = abap_true.
  ENDIF.

  INSERT ir_entry INTO TABLE gt_entry.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'ADD_ENTRY'
        i_mv3        = 'CL_ISH_GM_TABLE' ).
  ENDIF.

  RAISE EVENT ev_entry_added
    EXPORTING
      er_entry = ir_entry.

  r_added = abap_true.

ENDMETHOD.


METHOD if_ish_gui_table_model~get_entries.

  rt_entry = gt_entry.

ENDMETHOD.


METHOD if_ish_gui_table_model~remove_entry.

  IF gr_cb_tabmdl IS BOUND.
    CHECK gr_cb_tabmdl->cb_remove_entry(
              ir_model   = me
              ir_entry   = ir_entry ) = abap_true.
  ENDIF.

  DELETE TABLE gt_entry WITH TABLE KEY table_line = ir_entry.
  CHECK sy-subrc = 0.

  RAISE EVENT ev_entry_removed
    EXPORTING
      er_entry = ir_entry.

  r_removed = abap_true.

ENDMETHOD.


METHOD if_ish_gui_treenode_model~get_node_icon.

  r_node_icon = g_node_icon.

ENDMETHOD.


METHOD if_ish_gui_treenode_model~get_node_text.

  r_node_text = g_node_text.

ENDMETHOD.


METHOD _destroy.

  CLEAR gt_entry.
  CLEAR gr_cb_tabmdl.
  CLEAR gr_cb_destroyable.

ENDMETHOD.
ENDCLASS.
