class CL_ISH_RS_SEARCH_RESULT definition
  public
  inheriting from CL_ISH_RS_OBJECT
  create public .

*"* public components of class CL_ISH_RS_SEARCH_RESULT
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_TABLE_MODEL .
  interfaces IF_ISH_GUI_XTABLE_MODEL .
  interfaces IF_ISH_RS_SEARCH_RESULT .

  aliases ACTIVATE_REFRESH_BUFFER
    for IF_ISH_RS_SEARCH_RESULT~ACTIVATE_REFRESH_BUFFER .
  aliases ADD_ENTRY
    for IF_ISH_GUI_TABLE_MODEL~ADD_ENTRY .
  aliases APPEND_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~APPEND_ENTRY .
  aliases DEACTIVATE_REFRESH_BUFFER
    for IF_ISH_RS_SEARCH_RESULT~DEACTIVATE_REFRESH_BUFFER .
  aliases DESTROY
    for IF_ISH_DESTROYABLE~DESTROY .
  aliases GET_ENTITIES
    for IF_ISH_RS_SEARCH_RESULT~GET_ENTITIES .
  aliases GET_ENTRIES
    for IF_ISH_GUI_TABLE_MODEL~GET_ENTRIES .
  aliases GET_FIRST_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~GET_FIRST_ENTRY .
  aliases GET_LAST_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~GET_LAST_ENTRY .
  aliases GET_NEXT_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~GET_NEXT_ENTRY .
  aliases GET_PREVIOUS_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~GET_PREVIOUS_ENTRY .
  aliases IS_DESTROYED
    for IF_ISH_DESTROYABLE~IS_DESTROYED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_DESTROYABLE~IS_IN_DESTROY_MODE .
  aliases PREPEND_ENTRY
    for IF_ISH_GUI_XTABLE_MODEL~PREPEND_ENTRY .
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
  aliases EV_REFRESHED
    for IF_ISH_RS_SEARCH_RESULT~EV_REFRESHED .

  methods CONSTRUCTOR
    importing
      !IR_READ_SERVICE type ref to IF_ISH_RS_READ_SERVICE
      !IT_ENTITY type ISH_T_RS_ENTITY_OBJH optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_IDX_BY_ENTITY
    importing
      !IR_ENTITY type ref to IF_ISH_RS_ENTITY
    returning
      value(R_IDX) type I .
  type-pools ABAP .
  methods HAS_ENTITY
    importing
      !IR_ENTITY type ref to IF_ISH_RS_ENTITY
    returning
      value(R_HAS_ENTRY) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_RS_SEARCH_RESULT
*"* do not include other source files here!!!

  data GR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE .
  data GT_ENTITY type ISH_T_RS_ENTITY_OBJ .
  data GT_REFBUF_ADDED type ISH_T_RS_ENTITY_OBJH .
  data GT_REFBUF_CHANGED type ISH_T_RS_ENTITY_OBJH .
  data GT_REFBUF_REMOVED type ISH_T_RS_ENTITY_OBJH .
  type-pools ABAP .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .
  data G_REFRESH_BUFFER_ACTIVE type ABAP_BOOL .

  methods ON_ENTITY_CHANGED
    for event EV_CHANGED of IF_ISH_GUI_STRUCTURE_MODEL
    importing
      !ET_CHANGED_FIELD
      !SENDER .
  methods _ADD_ENTITY
    importing
      !IR_ENTITY type ref to IF_ISH_RS_ENTITY
      !I_IDX type I default 0
      !I_RAISE_EVENT type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_ADDED) type ABAP_BOOL .
  methods _CHECK_ADD_ENTITY
    importing
      !IR_ENTITY type ref to IF_ISH_RS_ENTITY .
  methods _CHECK_APPEND_ENTITY
    importing
      !IR_PREVIOUS_ENTITY type ref to IF_ISH_RS_ENTITY
      !IR_ENTITY type ref to IF_ISH_RS_ENTITY .
  methods _CHECK_PREPEND_ENTITY
    importing
      !IR_NEXT_ENTITY type ref to IF_ISH_RS_ENTITY
      !IR_ENTITY type ref to IF_ISH_RS_ENTITY .
  methods _CHECK_REMOVE_ENTITY
    importing
      !IR_ENTITY type ref to IF_ISH_RS_ENTITY .
  methods _DESTROY .
  methods _REMOVE_ENTITY
    importing
      !IR_ENTITY type ref to IF_ISH_RS_ENTITY
      !I_RAISE_EVENT type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_REMOVED) type ABAP_BOOL .
private section.
*"* private components of class CL_ISH_RS_SEARCH_RESULT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_RS_SEARCH_RESULT IMPLEMENTATION.


METHOD constructor.

  super->constructor( ir_read_service = ir_read_service ).

  gt_entity         = it_entity.
  gr_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD get_idx_by_entity.

  READ TABLE gt_entity FROM ir_entity TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_idx = sy-tabix.


ENDMETHOD.


method HAS_ENTITY.

 READ TABLE gt_entity FROM ir_entity TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_has_entry = abap_true.

endmethod.


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

  DATA lr_read_service            TYPE REF TO if_ish_rs_read_service.

* Callback.
  lr_read_service = get_read_service( ).
  IF lr_read_service IS BOUND.
    CHECK lr_read_service->cb_add_entry(
              ir_model  = me
              ir_entry  = ir_entry ) = abap_true.
  ENDIF.

* Append the entry.
  r_added = append_entry( ir_entry = ir_entry ).

ENDMETHOD.


METHOD if_ish_gui_table_model~get_entries.

  rt_entry = gt_entity.

ENDMETHOD.


METHOD if_ish_gui_table_model~remove_entry.

  DATA lr_entity                  TYPE REF TO if_ish_rs_entity.
  DATA lr_read_service            TYPE REF TO if_ish_rs_read_service.

  TRY.
      lr_entity ?= ir_entry.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Check.
  _check_remove_entity( ir_entity = lr_entity ).

* Callback.
  lr_read_service = get_read_service( ).
  IF lr_read_service IS BOUND.
    CHECK lr_read_service->cb_remove_entry(
              ir_model  = me
              ir_entry  = lr_entity ) = abap_true.
  ENDIF.

* Remove the entry.
  r_removed = _remove_entity( ir_entity = lr_entity ).

ENDMETHOD.


METHOD if_ish_gui_xtable_model~append_entry.

  DATA: l_prev_idx           TYPE i,
        l_idx                TYPE i,
        lr_previous_entity   TYPE REF TO if_ish_rs_entity,
        lr_entity            TYPE REF TO if_ish_rs_entity,
        lr_read_service      TYPE REF TO if_ish_rs_read_service.

  TRY.
      lr_entity ?= ir_entry.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Check the given entity.
  IF lr_entity IS NOT BOUND  OR
     lr_entity = me          OR
     has_entity( lr_entity ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'APPEND_ENTRY'
        i_mv3        = 'CL_ISH_RS_SEARCH_RESULT' ).
  ENDIF.

* Determine the index of the previous entity.
  IF ir_previous_entry IS BOUND.
    TRY.
        lr_previous_entity ?= ir_previous_entry.
      CATCH cx_sy_move_cast_error.
        RETURN.
    ENDTRY.
    l_prev_idx = get_idx_by_entity( ir_entity = lr_previous_entity ).
    IF l_prev_idx < 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = 'APPEND_ENTITY'
          i_mv3        = 'CL_ISH_RS_SEARCH_RESULT' ).
    ENDIF.
  ENDIF.

* Check.
  _check_append_entity(
      ir_previous_entity = lr_previous_entity
      ir_entity          = lr_entity ).

* Callback.
  lr_read_service = get_read_service( ).
  IF lr_read_service IS BOUND.
    CHECK lr_read_service->if_ish_gui_cb_xtable_model~cb_append_entry(
              ir_model           = me
              ir_previous_entry  = lr_previous_entity
              ir_entry           = lr_entity ) = abap_true.
  ENDIF.

* Add the entity.
  IF l_prev_idx > 0.
    l_idx = l_prev_idx + 1.
  ELSE.
    l_idx = 0.
  ENDIF.
  r_added = _add_entity(
      ir_entity  = lr_entity
      i_idx     = l_idx ).

ENDMETHOD.


method IF_ISH_GUI_XTABLE_MODEL~GET_FIRST_ENTRY.


  READ TABLE gt_entity INDEX 1 INTO rr_first_entry.

endmethod.


method IF_ISH_GUI_XTABLE_MODEL~GET_LAST_ENTRY.

  DATA l_idx            TYPE i.


  l_idx = LINES( gt_entity ).
  READ TABLE gt_entity INDEX l_idx INTO rr_last_entry.

endmethod.


METHOD if_ish_gui_xtable_model~get_next_entry.

  DATA: l_idx              TYPE i,
        lr_previous_entity TYPE REF TO if_ish_rs_entity.

  CHECK ir_previous_entry IS BOUND.

  TRY.
      lr_previous_entity ?= ir_previous_entry.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  l_idx = get_idx_by_entity( lr_previous_entity ).
  CHECK l_idx > 0.

  l_idx = l_idx + 1.
  READ TABLE gt_entity INDEX l_idx INTO rr_next_entry.

ENDMETHOD.


METHOD if_ish_gui_xtable_model~get_previous_entry.

  DATA: l_idx              TYPE i,
        lr_next_entity TYPE REF TO if_ish_rs_entity.

  CHECK ir_next_entry IS BOUND.

  TRY.
      lr_next_entity ?= ir_next_entry.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  l_idx = get_idx_by_entity( lr_next_entity ).
  CHECK l_idx > 1.

  l_idx = l_idx - 1.
  READ TABLE gt_entity INDEX l_idx INTO rr_previous_entry.

ENDMETHOD.


METHOD if_ish_gui_xtable_model~prepend_entry.

  DATA: l_next_idx           TYPE i,
        l_idx                TYPE i,
        lr_next_entity       TYPE REF TO if_ish_rs_entity,
        lr_entity            TYPE REF TO if_ish_rs_entity,
        lr_read_service      TYPE REF TO if_ish_rs_read_service.

  TRY.
      lr_entity ?= ir_entry.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Check the given entry.
  IF lr_entity IS NOT BOUND  OR
     lr_entity = me          OR
     has_entity( lr_entity ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'PREPEND_ENTRY'
        i_mv3        = 'CL_ISH_RS_SEARCH_RESULT' ).
  ENDIF.

* Determine the index of the next entry.
  IF ir_next_entry IS BOUND.
    TRY.
        lr_next_entity ?= ir_next_entry.
      CATCH cx_sy_move_cast_error.
        RETURN.
    ENDTRY.
    l_next_idx = get_idx_by_entity( ir_entity = lr_next_entity ).
    IF l_next_idx < 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = 'PREPEND_ENTRY'
          i_mv3        = 'CL_ISH_RS_SEARCH_RESULT' ).
    ENDIF.
  ENDIF.

* Check.
  _check_prepend_entity(
      ir_next_entity = lr_next_entity
      ir_entity      = lr_entity ).

* Callback.
  lr_read_service = get_read_service( ).
  IF lr_read_service IS BOUND.
    CHECK lr_read_service->if_ish_gui_cb_xtable_model~cb_prepend_entry(
              ir_model      = me
              ir_next_entry = lr_next_entity
              ir_entry      = lr_entity ) = abap_true.
  ENDIF.

* Add the entry.
  IF l_next_idx > 0.
    l_idx = l_next_idx.
  ELSE.
    l_idx = 1.
  ENDIF.
  r_added = _add_entity(
      ir_entity  = lr_entity
      i_idx      = l_idx ).


ENDMETHOD.


METHOD if_ish_rs_search_result~activate_refresh_buffer.

  g_refresh_buffer_active = abap_true.

ENDMETHOD.


METHOD if_ish_rs_search_result~deactivate_refresh_buffer.

  CHECK g_refresh_buffer_active = abap_true.

  g_refresh_buffer_active = abap_false.

  IF gt_refbuf_added IS NOT INITIAL OR
     gt_refbuf_changed IS NOT INITIAL OR
     gt_refbuf_removed IS NOT INITIAL.
    RAISE EVENT ev_refreshed
      EXPORTING
        et_entity_added   = gt_refbuf_added
        et_entity_changed = gt_refbuf_changed
        et_entity_removed = gt_refbuf_removed.
    CLEAR gt_refbuf_added.
    CLEAR gt_refbuf_changed.
    CLEAR gt_refbuf_removed.
  ENDIF.

ENDMETHOD.


METHOD if_ish_rs_search_result~get_entities.

  rt_entity = gt_entity.

ENDMETHOD.


METHOD if_ish_rs_search_result~is_refresh_buffer_active.

  r_active = g_refresh_buffer_active.

ENDMETHOD.


METHOD on_entity_changed.

  DATA lr_entity            TYPE REF TO if_ish_rs_entity.

  CHECK sender IS BOUND.

* Handle the refresh buffer.
  IF g_refresh_buffer_active = abap_true.
    TRY.
        lr_entity ?= sender.
        INSERT lr_entity INTO TABLE gt_refbuf_changed.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
  ENDIF.

ENDMETHOD.


METHOD _add_entity.

* Add ir_entry to gt_entity.
  IF i_idx = 0.
    APPEND ir_entity TO gt_entity.
  ELSE.
    INSERT ir_entity INTO gt_entity INDEX i_idx.
  ENDIF.
  CHECK sy-subrc = 0.

* Raise event ev_entry_added.
  IF i_raise_event = abap_true.
    RAISE EVENT ev_entry_added
      EXPORTING
        er_entry = ir_entity.
  ENDIF.

* Handle the refresh buffer.
  IF g_refresh_buffer_active = abap_true.
    INSERT ir_entity INTO TABLE gt_refbuf_added.
  ENDIF.

* Register the changed event.
  SET HANDLER on_entity_changed FOR ir_entity ACTIVATION abap_true.

* Export.
  r_added = abap_true.

ENDMETHOD.


method _CHECK_ADD_ENTITY.
endmethod.


method _CHECK_APPEND_ENTITY.

  _check_add_entity( ir_entity = ir_entity ).

endmethod.


method _CHECK_PREPEND_ENTITY.

  _check_add_entity( ir_entity = ir_entity ).

endmethod.


method _CHECK_REMOVE_ENTITY.
endmethod.


METHOD _destroy.

  CLEAR gt_entity.

ENDMETHOD.


METHOD _remove_entity.

* Remove ir_ENTITY from gt_ENTITY.
  DELETE TABLE gt_entity WITH TABLE KEY table_line = ir_entity.
  CHECK sy-subrc = 0.

* Raise event ev_ENTITY_removed.
  IF i_raise_event = abap_true.
    RAISE EVENT ev_entry_removed
      EXPORTING
        er_entry = ir_entity.
  ENDIF.

* Handle the refresh buffer.
  IF g_refresh_buffer_active = abap_true.
    INSERT ir_entity INTO TABLE gt_refbuf_removed.
  ENDIF.

* Deregister the changed event.
  SET HANDLER on_entity_changed FOR ir_entity ACTIVATION abap_false.

* Export.
  r_removed = abap_true.

ENDMETHOD.
ENDCLASS.
