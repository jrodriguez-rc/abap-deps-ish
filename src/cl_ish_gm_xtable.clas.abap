class CL_ISH_GM_XTABLE definition
  public
  create public .

public section.
*"* public components of class CL_ISH_GM_XTABLE
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_TABLE_MODEL .
  interfaces IF_ISH_GUI_XTABLE_MODEL .
  interfaces IF_ISH_GUI_TREENODE_MODEL .

  aliases ADD_ENTRY
    for IF_ISH_GUI_TABLE_MODEL~ADD_ENTRY .
  aliases APPEND_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~APPEND_ENTRY .
  aliases GET_ENTRIES
    for IF_ISH_GUI_TABLE_MODEL~GET_ENTRIES .
  aliases GET_FIRST_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~GET_FIRST_ENTRY .
  aliases GET_LAST_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~GET_LAST_ENTRY .
  aliases GET_NEXT_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~GET_NEXT_ENTRY .
  aliases GET_NODE_ICON
    for IF_ISH_GUI_TREENODE_MODEL~GET_NODE_ICON .
  aliases GET_NODE_TEXT
    for IF_ISH_GUI_TREENODE_MODEL~GET_NODE_TEXT .
  aliases GET_PREVIOUS_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~GET_PREVIOUS_ENTRY .
  aliases PREPEND_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~PREPEND_ENTRY .
  aliases REMOVE_ENTRY
    for IF_ISH_GUI_TABLE_MODEL~REMOVE_ENTRY .
  aliases EV_ENTRY_ADDED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_ADDED .
  aliases EV_ENTRY_REMOVED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_REMOVED .

  methods CONSTRUCTOR
    importing
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_XTABMDL type ref to IF_ISH_GUI_CB_XTABLE_MODEL optional
      !IT_ENTRY type ISH_T_GUI_MODEL_OBJHASH optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
    preferred parameter IR_CB_TABMDL .
  methods GET_IDX_BY_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_IDX) type I .
  type-pools ABAP .
  methods HAS_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_HAS_ENTRY) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_GM_XTABLE
*"* do not include other source files here!!!

  data GR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL .
  data GR_CB_XTABMDL type ref to IF_ISH_GUI_CB_XTABLE_MODEL .
  data GT_ENTRY type ISH_T_GUI_MODEL_OBJ .
  data G_NODE_ICON type TV_IMAGE .
  data G_NODE_TEXT type LVC_VALUE .

  type-pools ABAP .
  methods _ADD_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
      !I_IDX type I default 0
      !I_RAISE_EVENT type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_ADDED) type ABAP_BOOL .
  methods _CHECK_ADD_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_APPEND_ENTRY
    importing
      !IR_PREVIOUS_ENTRY type ref to IF_ISH_GUI_MODEL optional
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_IS_ENTRY_VALID
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_PREPEND_ENTRY
    importing
      !IR_NEXT_ENTRY type ref to IF_ISH_GUI_MODEL optional
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CHECK_REMOVE_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _IS_ENTRY_VALID
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_VALID) type ABAP_BOOL .
  methods _REMOVE_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
      !I_RAISE_EVENT type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_REMOVED) type ABAP_BOOL .
private section.
*"* private components of class CL_ISH_GM_XTABLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_XTABLE IMPLEMENTATION.


METHOD constructor.

  gr_cb_tabmdl  = ir_cb_tabmdl.
  gr_cb_xtabmdl = ir_cb_xtabmdl.
  gt_entry      = it_entry.
  g_node_text   = i_node_text.
  g_node_icon   = i_node_icon.

ENDMETHOD.


METHOD get_idx_by_entry.

  DATA lt_entry           TYPE ish_t_gui_model_obj.

  TRY.
      lt_entry = get_entries( ).
    CATCH cx_ish_static_handler.
      lt_entry = gt_entry.
  ENDTRY.

  READ TABLE lt_entry FROM ir_entry TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_idx = sy-tabix.

ENDMETHOD.


METHOD has_entry.

  DATA lt_entry           TYPE ish_t_gui_model_obj.

  TRY.
      lt_entry = get_entries( ).
    CATCH cx_ish_static_handler.
      lt_entry = gt_entry.
  ENDTRY.

  READ TABLE lt_entry FROM ir_entry TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_has_entry = abap_true.

ENDMETHOD.


METHOD if_ish_gui_table_model~add_entry.

* Callback.
  IF gr_cb_tabmdl IS BOUND.
    CHECK gr_cb_tabmdl->cb_add_entry(
              ir_model   = me
              ir_entry   = ir_entry ) = abap_true.
  ENDIF.

* Append the entry.
  r_added = append_entry( ir_entry = ir_entry ).

ENDMETHOD.


METHOD if_ish_gui_table_model~get_entries.

  DATA lr_entry           TYPE REF TO if_ish_gui_model.

  LOOP AT gt_entry INTO lr_entry.
    INSERT lr_entry INTO TABLE rt_entry.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_table_model~remove_entry.

* Check.
  _check_remove_entry( ir_entry = ir_entry ).

* Callback.
  IF gr_cb_tabmdl IS BOUND.
    CHECK gr_cb_tabmdl->cb_remove_entry(
              ir_model   = me
              ir_entry   = ir_entry ) = abap_true.
  ENDIF.

* Remove the entry.
  r_removed = _remove_entry( ir_entry = ir_entry ).

ENDMETHOD.


METHOD if_ish_gui_treenode_model~get_node_icon.

  r_node_icon = g_node_icon.

ENDMETHOD.


METHOD if_ish_gui_treenode_model~get_node_text.

  r_node_text = g_node_text.

ENDMETHOD.


METHOD if_ish_gui_xtable_model~append_entry.

  DATA l_prev_idx           TYPE i.
  DATA l_idx                TYPE i.

* Check the given entry.
  IF ir_entry IS NOT BOUND  OR
     ir_entry = me          OR
     has_entry( ir_entry ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'APPEND_ENTRY'
        i_mv3        = 'CL_ISH_GM_XTABLE' ).
  ENDIF.

* Determine the index of the previous entry.
  IF ir_previous_entry IS BOUND.
    l_prev_idx = get_idx_by_entry( ir_entry = ir_previous_entry ).
    IF l_prev_idx < 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = 'APPEND_ENTRY'
          i_mv3        = 'CL_ISH_GM_XTABLE' ).
    ENDIF.
  ENDIF.

* Check.
  _check_append_entry(
      ir_previous_entry = ir_previous_entry
      ir_entry          = ir_entry ).

* Callback.
  IF gr_cb_xtabmdl IS BOUND.
    CHECK gr_cb_xtabmdl->cb_append_entry(
              ir_model          = me
              ir_previous_entry = ir_previous_entry
              ir_entry          = ir_entry ) = abap_true.
  ENDIF.

* Add the entry.
  IF l_prev_idx > 0.
    l_idx = l_prev_idx + 1.
  ELSE.
    l_idx = 0.
  ENDIF.
  r_added = _add_entry(
      ir_entry  = ir_entry
      i_idx     = l_idx ).

ENDMETHOD.


METHOD if_ish_gui_xtable_model~get_first_entry.

  DATA lt_entry           TYPE ish_t_gui_model_obj.

  lt_entry = get_entries( ).

  READ TABLE lt_entry INDEX 1 INTO rr_first_entry.

ENDMETHOD.


METHOD if_ish_gui_xtable_model~get_last_entry.

  DATA lt_entry           TYPE ish_t_gui_model_obj.
  DATA l_idx            TYPE i.

  lt_entry = get_entries( ).

  l_idx = LINES( lt_entry ).
  READ TABLE lt_entry INDEX l_idx INTO rr_last_entry.

ENDMETHOD.


METHOD if_ish_gui_xtable_model~get_next_entry.

  DATA lt_entry           TYPE ish_t_gui_model_obj.
  DATA l_idx              TYPE i.

  CHECK ir_previous_entry IS BOUND.

  l_idx = get_idx_by_entry( ir_previous_entry ).
  CHECK l_idx > 0.

  l_idx = l_idx + 1.

  lt_entry = get_entries( ).

  READ TABLE lt_entry INDEX l_idx INTO rr_next_entry.

ENDMETHOD.


METHOD if_ish_gui_xtable_model~get_previous_entry.

  DATA lt_entry           TYPE ish_t_gui_model_obj.
  DATA l_idx            TYPE i.

  CHECK ir_next_entry IS BOUND.

  l_idx = get_idx_by_entry( ir_next_entry ).
  CHECK l_idx > 1.

  l_idx = l_idx - 1.

  lt_entry = get_entries( ).

  READ TABLE lt_entry INDEX l_idx INTO rr_previous_entry.

ENDMETHOD.


METHOD if_ish_gui_xtable_model~prepend_entry.

  DATA l_next_idx           TYPE i.
  DATA l_idx                TYPE i.

* Check the given entry.
  IF ir_entry IS NOT BOUND  OR
     ir_entry = me          OR
     has_entry( ir_entry ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'PREPEND_ENTRY'
        i_mv3        = 'CL_ISH_GM_XTABLE' ).
  ENDIF.

* Determine the index of the next entry.
  IF ir_next_entry IS BOUND.
    l_next_idx = get_idx_by_entry( ir_entry = ir_next_entry ).
    IF l_next_idx < 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = 'PREPEND_ENTRY'
          i_mv3        = 'CL_ISH_GM_XTABLE' ).
    ENDIF.
  ENDIF.

* Check.
  _check_prepend_entry(
      ir_next_entry = ir_next_entry
      ir_entry      = ir_entry ).

* Callback.
  IF gr_cb_xtabmdl IS BOUND.
    CHECK gr_cb_xtabmdl->cb_prepend_entry(
              ir_model      = me
              ir_next_entry = ir_next_entry
              ir_entry      = ir_entry ) = abap_true.
  ENDIF.

* Add the entry.
  IF l_next_idx > 0.
    l_idx = l_next_idx.
  ELSE.
    l_idx = 1.
  ENDIF.
  r_added = _add_entry(
      ir_entry  = ir_entry
      i_idx     = l_idx ).

ENDMETHOD.


METHOD _add_entry.

* Add ir_entry to gt_entry.
  IF i_idx = 0.
    INSERT ir_entry INTO TABLE gt_entry.
  ELSE.
    INSERT ir_entry INTO gt_entry INDEX i_idx.
  ENDIF.
  CHECK sy-subrc = 0.

* Raise event ev_entry_added.
  IF i_raise_event = abap_true.
    RAISE EVENT ev_entry_added
      EXPORTING
        er_entry = ir_entry.
  ENDIF.

* Export.
  r_added = abap_true.

ENDMETHOD.


METHOD _check_add_entry.

  _check_is_entry_valid( ir_entry ).

  IF has_entry( ir_entry ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_ADD_ENTRY'
        i_mv3        = 'CL_ISH_GM_XTABLE' ).
  ENDIF.

ENDMETHOD.


METHOD _check_append_entry.

  _check_add_entry( ir_entry = ir_entry ).

ENDMETHOD.


METHOD _check_is_entry_valid.

  IF _is_entry_valid( ir_entry ) = abap_false.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_IS_ENTRY_VALID'
        i_mv3        = 'CL_ISH_GM_XTABLE' ).
  ENDIF.

ENDMETHOD.


METHOD _check_prepend_entry.

  _check_add_entry( ir_entry = ir_entry ).

ENDMETHOD.


method _CHECK_REMOVE_ENTRY.
endmethod.


METHOD _is_entry_valid.

  CHECK ir_entry IS BOUND.
  CHECK ir_entry <> me.

  r_valid = abap_true.

ENDMETHOD.


METHOD _remove_entry.

* Remove ir_entry from gt_entry.
  DELETE TABLE gt_entry WITH TABLE KEY table_line = ir_entry.
  CHECK sy-subrc = 0.

* Raise event ev_entry_removed.
  IF i_raise_event = abap_true.
    RAISE EVENT ev_entry_removed
      EXPORTING
        er_entry = ir_entry.
  ENDIF.

* Export.
  r_removed = abap_true.

ENDMETHOD.
ENDCLASS.
