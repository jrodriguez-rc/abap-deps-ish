class CL_ISH_GMT_MAINOBJ definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GMT_MAINOBJ
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_TABLE_MODEL .
  interfaces IF_ISH_GUI_TREENODE_MODEL .

  aliases GET_ENTRIES
    for IF_ISH_GUI_TABLE_MODEL~GET_ENTRIES .
  aliases GET_NODE_ICON
    for IF_ISH_GUI_TREENODE_MODEL~GET_NODE_ICON .
  aliases GET_NODE_TEXT
    for IF_ISH_GUI_TREENODE_MODEL~GET_NODE_TEXT .
  aliases EV_ENTRY_ADDED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_ADDED .
  aliases EV_ENTRY_REMOVED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_REMOVED .

  methods CONSTRUCTOR
    importing
      !IR_MAIN_OBJECT type ref to OBJECT
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_MAIN_OBJECT
  final
    returning
      value(RR_MAIN_OBJECT) type ref to OBJECT .
  type-pools ABAP .
  methods GET_TABICON
    importing
      !I_ENTRIES type ABAP_BOOL default ' '
    returning
      value(R_ICON) type TV_IMAGE .
  methods GET_T_ENTRY
    importing
      !I_ONLY_VALID type ABAP_BOOL default ABAP_TRUE
    returning
      value(RT_ENTRY) type ISH_T_GUI_MODEL_OBJHASH .
  methods HAS_ENTRIES
    returning
      value(R_HAS_ENTRIES) type ABAP_BOOL .
  methods HAS_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
      !I_ONLY_VALID type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_HAS_ENTRY) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_GMT_MAINOBJ
*"* do not include other source files here!!!

  data GT_INVALID_ENTRY type ISH_T_GUI_MODEL_OBJHASH .
  data GT_VALID_ENTRY type ISH_T_GUI_MODEL_OBJHASH .
  data G_NODE_ICON type TV_IMAGE .
  data G_NODE_TEXT type LVC_VALUE .

  methods ON_MAIN_OBJECT_AFTER_DESTROY
    for event EV_AFTER_DESTROY of IF_ISH_DESTROYABLE
    importing
      !SENDER .
  methods _ADD_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
      !I_RAISE_EVENT type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_ENTRY_ADDED) type ABAP_BOOL .
  methods _COMPLETE_CONSTRUCTION
    importing
      !IT_ENTRY type ISH_T_GUI_MODEL_OBJHASH optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods _HANDLE_ENTRY_CHANGED
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL .
  methods _HANDLE_ENTRY_INVALIDATED
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL .
  methods _HANDLE_ENTRY_VALIDATED
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL .
  methods _IS_ENTRY_VALID
  abstract
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_VALID) type ABAP_BOOL .
  methods _REGISTER_ENTRY_EVENTS
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
      !I_ACTIVATION type ABAP_BOOL .
  methods _REGISTER_MAIN_OBJECT_EVENTS
    importing
      !I_ACTIVATION type ABAP_BOOL .
private section.
*"* private components of class CL_ISH_GMT_MAINOBJ
*"* do not include other source files here!!!

  data GR_MAIN_OBJECT type ref to OBJECT .
ENDCLASS.



CLASS CL_ISH_GMT_MAINOBJ IMPLEMENTATION.


METHOD CONSTRUCTOR.

  IF ir_main_object IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISHMED_NRS_GMT' ).
  ENDIF.

  gr_main_object    = ir_main_object.
  g_node_text       = i_node_text.
  g_node_icon       = i_node_icon.

  IF g_node_icon IS INITIAL.
    g_node_icon = icon_object_folder.
  ENDIF.

ENDMETHOD.


METHOD GET_MAIN_OBJECT.

  rr_main_object = gr_main_object.

ENDMETHOD.


METHOD GET_TABICON.

  IF i_entries = abap_true.

    r_icon = cl_ishmed_nrs_ga_plan=>co_tabicon_filled.

  ELSE.

    r_icon = cl_ishmed_nrs_ga_plan=>co_tabicon_empty.

  ENDIF.

ENDMETHOD.


METHOD GET_T_ENTRY.

  DATA lr_entry           TYPE REF TO if_ish_gui_model.

  rt_entry = gt_valid_entry.

  IF i_only_valid = abap_false.
    LOOP AT gt_invalid_entry INTO lr_entry.
      INSERT lr_entry INTO TABLE rt_entry.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD has_entries.

* Check if we've at least one valid entry.
  CHECK lines( gt_valid_entry ) >= 1.

  r_has_entries = abap_true.

ENDMETHOD.


METHOD HAS_ENTRY.

  READ TABLE gt_valid_entry
    WITH TABLE KEY table_line = ir_entry
    TRANSPORTING NO FIELDS.
  IF sy-subrc <> 0.
    CHECK i_only_valid = abap_false.
    READ TABLE gt_invalid_entry
      WITH TABLE KEY table_line = ir_entry
      TRANSPORTING NO FIELDS.
    CHECK sy-subrc = 0.
  ENDIF.

  r_has_entry = abap_true.

ENDMETHOD.


METHOD IF_ISH_GUI_TABLE_MODEL~ADD_ENTRY.

  cl_ish_utl_exception=>raise_static(
      i_typ        = 'E'
      i_kla        = 'N1BASE'
      i_num        = '030'
      i_mv1        = '1'
      i_mv2        = 'ADD_ENTRY'
      i_mv3        = 'CL_ISHMED_NRS_GMT' ).

ENDMETHOD.


METHOD IF_ISH_GUI_TABLE_MODEL~GET_ENTRIES.

  rt_entry = gt_valid_entry.

ENDMETHOD.


METHOD IF_ISH_GUI_TABLE_MODEL~REMOVE_ENTRY.

  cl_ish_utl_exception=>raise_static(
      i_typ        = 'E'
      i_kla        = 'N1BASE'
      i_num        = '030'
      i_mv1        = '1'
      i_mv2        = 'REMOVE_ENTRY'
      i_mv3        = 'CL_ISHMED_NRS_GMT' ).

ENDMETHOD.


METHOD IF_ISH_GUI_TREENODE_MODEL~GET_NODE_ICON.

  r_node_icon = g_node_icon.

ENDMETHOD.


METHOD IF_ISH_GUI_TREENODE_MODEL~GET_NODE_TEXT.

  r_node_text = g_node_text.

ENDMETHOD.


METHOD ON_MAIN_OBJECT_AFTER_DESTROY.

  DATA lr_entry           TYPE REF TO if_ish_gui_model.
  DATA lt_entry           TYPE ish_t_gui_model_objhash.

  CHECK sender IS BOUND.
  CHECK sender = gr_main_object.

  _register_main_object_events( i_activation = abap_false ).

  LOOP AT gt_invalid_entry INTO lr_entry.
    _register_entry_events(
        ir_entry      = lr_entry
        i_activation  = abap_false ).
  ENDLOOP.
  CLEAR gt_invalid_entry.

  lt_entry = gt_valid_entry.
  CLEAR gt_valid_entry.
  LOOP AT lt_entry INTO lr_entry.
    _register_entry_events(
        ir_entry      = lr_entry
        i_activation  = abap_false ).
    RAISE EVENT ev_entry_removed
      EXPORTING
        er_entry = lr_entry.
  ENDLOOP.

  CLEAR gr_main_object.

ENDMETHOD.


METHOD _add_entry.

  CHECK gr_main_object IS BOUND.

  CHECK ir_entry IS BOUND.

  _register_entry_events(
      ir_entry      = ir_entry
      i_activation  = abap_true ).

  IF _is_entry_valid( ir_entry ) = abap_true.
    INSERT ir_entry INTO TABLE gt_valid_entry.
    CHECK sy-subrc = 0.
    IF i_raise_event = abap_true.
      RAISE EVENT ev_entry_added
        EXPORTING
          er_entry = ir_entry.
    ENDIF.
  ELSE.
    INSERT ir_entry INTO TABLE gt_invalid_entry.
    CHECK sy-subrc = 0.
  ENDIF.

  r_entry_added = abap_true.

ENDMETHOD.


METHOD _COMPLETE_CONSTRUCTION.

  DATA lr_entry           TYPE REF TO if_ish_gui_model.

  LOOP AT it_entry INTO lr_entry.
    _add_entry(
        ir_entry      = lr_entry
        i_raise_event = abap_false ).
  ENDLOOP.

* Register events on main object.
  _register_main_object_events( i_activation = abap_true ).

ENDMETHOD.


METHOD _HANDLE_ENTRY_CHANGED.

  CHECK gr_main_object IS BOUND.

  CHECK ir_entry IS BOUND.

  IF _is_entry_valid( ir_entry ) = abap_true.
    _handle_entry_validated( ir_entry ).
  ELSE.
    _handle_entry_invalidated( ir_entry ).
  ENDIF.

ENDMETHOD.


METHOD _HANDLE_ENTRY_INVALIDATED.

  CHECK gr_main_object IS BOUND.

  CHECK ir_entry IS BOUND.

  DELETE TABLE gt_valid_entry WITH TABLE KEY table_line = ir_entry.
  CHECK sy-subrc = 0.

  INSERT ir_entry INTO TABLE gt_invalid_entry.
  CHECK sy-subrc = 0.

  RAISE EVENT ev_entry_removed
    EXPORTING
      er_entry = ir_entry.

ENDMETHOD.


METHOD _HANDLE_ENTRY_VALIDATED.

  CHECK gr_main_object IS BOUND.

  CHECK ir_entry IS BOUND.

  DELETE TABLE gt_invalid_entry WITH TABLE KEY table_line = ir_entry.
  CHECK sy-subrc = 0.

  INSERT ir_entry INTO TABLE gt_valid_entry.
  CHECK sy-subrc = 0.

  RAISE EVENT ev_entry_added
    EXPORTING
      er_entry = ir_entry.

ENDMETHOD.


method _REGISTER_ENTRY_EVENTS.
endmethod.


METHOD _REGISTER_MAIN_OBJECT_EVENTS.

  DATA lr_destroyable           TYPE REF TO if_ish_destroyable.

  CHECK gr_main_object IS BOUND.

  TRY.
      lr_destroyable ?= gr_main_object.
      SET HANDLER on_main_object_after_destroy  FOR lr_destroyable ACTIVATION i_activation.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.
ENDCLASS.
