class CL_ISH_GM_SORTED_TABLE definition
  public
  inheriting from CL_ISH_GM_XTABLE
  create public .

public section.
*"* public components of class CL_ISH_GM_SORTED_TABLE
*"* do not include other source files here!!!

  type-pools ABAP .
  class-methods NEW_INSTANCE_BY_FIELDNAME
    importing
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_XTABMDL type ref to IF_ISH_GUI_CB_XTABLE_MODEL optional
      !IT_ENTRY type ISH_T_GUI_STRUCTMDL_OBJH optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
      !I_FIELDNAME type ISH_FIELDNAME
      !I_DESCENDING type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_SORTED_TABLE
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods NEW_INSTANCE_BY_SORTORDER_TAB
    importing
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_XTABMDL type ref to IF_ISH_GUI_CB_XTABLE_MODEL optional
      !IT_ENTRY type ISH_T_GUI_STRUCTMDL_OBJH optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
      !IT_SORTORDER type ABAP_SORTORDER_TAB
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_SORTED_TABLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_XTABMDL type ref to IF_ISH_GUI_CB_XTABLE_MODEL optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
      !IT_SORTORDER type ABAP_SORTORDER_TAB
    preferred parameter IR_CB_TABMDL
    raising
      CX_ISH_STATIC_HANDLER .

  methods IF_ISH_GUI_TABLE_MODEL~ADD_ENTRY
    redefinition .
  methods IF_ISH_GUI_XTABLE_MODEL~APPEND_ENTRY
    redefinition .
  methods IF_ISH_GUI_XTABLE_MODEL~PREPEND_ENTRY
    redefinition .
protected section.
*"* protected components of class CL_ISH_GM_SORTED_TABLE
*"* do not include other source files here!!!

  type-pools ABAP .
  data GT_SORTORDER type ABAP_SORTORDER_TAB .

  methods ON_ENTRY_AFTER_DESTROY
    for event EV_AFTER_DESTROY of IF_ISH_DESTROYABLE
    importing
      !SENDER .
  methods ON_ENTRY_CHANGED
    for event EV_CHANGED of IF_ISH_GUI_STRUCTURE_MODEL
    importing
      !ET_CHANGED_FIELD
      !SENDER .
  methods _ADJUST_ENTRY_CHANGES
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods _COMPARE_ENTRIES
    importing
      !IR_ENTRY1 type ref to IF_ISH_GUI_MODEL
      !IR_ENTRY2 type ref to IF_ISH_GUI_MODEL
    returning
      value(R_RESULT) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_IDX_4_NEW_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_IDX) type I
    raising
      CX_ISH_STATIC_HANDLER .

  methods _ADD_ENTRY
    redefinition .
  methods _IS_ENTRY_VALID
    redefinition .
  methods _REMOVE_ENTRY
    redefinition .
private section.
*"* private components of class CL_ISH_GM_SORTED_TABLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_SORTED_TABLE IMPLEMENTATION.


METHOD constructor.

  FIELD-SYMBOLS <ls_sortorder>            TYPE abap_sortorder.

  IF it_sortorder IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_GM_SORTED_TABLE' ).
  ENDIF.
  LOOP AT it_sortorder ASSIGNING <ls_sortorder>.
    IF <ls_sortorder>-name IS INITIAL.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = 'CONSTRUCTOR'
          i_mv3        = 'CL_ISH_GM_SORTED_TABLE' ).
    ENDIF.
  ENDLOOP.

  super->constructor(
      ir_cb_tabmdl  = ir_cb_tabmdl
      ir_cb_xtabmdl = ir_cb_xtabmdl
      i_node_text   = i_node_text
      i_node_icon   = i_node_icon ).

  gt_sortorder = it_sortorder.

ENDMETHOD.


METHOD if_ish_gui_table_model~add_entry.

* Callback.
  IF gr_cb_tabmdl IS BOUND.
    CHECK gr_cb_tabmdl->cb_add_entry(
              ir_model   = me
              ir_entry   = ir_entry ) = abap_true.
  ENDIF.

* Check.
  _check_add_entry( ir_entry = ir_entry ).

* Add the entry.
  r_added = _add_entry(
      ir_entry  = ir_entry
      i_idx     = _get_idx_4_new_entry( ir_entry = ir_entry ) ).

ENDMETHOD.


METHOD if_ish_gui_xtable_model~append_entry.

* Not allowed.

  cl_ish_utl_exception=>raise_static(
      i_typ        = 'E'
      i_kla        = 'N1BASE'
      i_num        = '030'
      i_mv1        = '1'
      i_mv2        = 'APPEND_ENTRY'
      i_mv3        = 'CL_ISH_GM_SORTED_TABLE' ).

ENDMETHOD.


METHOD if_ish_gui_xtable_model~prepend_entry.

* Not allowed.

  cl_ish_utl_exception=>raise_static(
      i_typ        = 'E'
      i_kla        = 'N1BASE'
      i_num        = '030'
      i_mv1        = '1'
      i_mv2        = 'PREPEND_ENTRY'
      i_mv3        = 'CL_ISH_GM_SORTED_TABLE' ).

ENDMETHOD.


METHOD new_instance_by_fieldname.

  DATA ls_sortorder           TYPE abap_sortorder.
  DATA lt_sortorder           TYPE abap_sortorder_tab.

  ls_sortorder-name       = i_fieldname.
  ls_sortorder-descending = i_descending.
  INSERT ls_sortorder INTO TABLE lt_sortorder.

  rr_instance = new_instance_by_sortorder_tab(
      ir_cb_tabmdl  = ir_cb_tabmdl
      ir_cb_xtabmdl = ir_cb_xtabmdl
      it_entry      = it_entry
      i_node_text   = i_node_text
      i_node_icon   = i_node_icon
      it_sortorder  = lt_sortorder ).

ENDMETHOD.


METHOD new_instance_by_sortorder_tab.

  DATA lr_entry           TYPE REF TO if_ish_gui_structure_model.

  CREATE OBJECT rr_instance
    EXPORTING
      ir_cb_tabmdl  = ir_cb_tabmdl
      ir_cb_xtabmdl = ir_cb_xtabmdl
      i_node_text   = i_node_text
      i_node_icon   = i_node_icon
      it_sortorder  = it_sortorder.

  LOOP AT it_entry INTO lr_entry.
    rr_instance->_check_add_entry( ir_entry = lr_entry ).
    rr_instance->_add_entry(
        ir_entry  = lr_entry
        i_idx     = rr_instance->_get_idx_4_new_entry( ir_entry = lr_entry ) ).
  ENDLOOP.

ENDMETHOD.


METHOD on_entry_after_destroy.

  DATA lr_entry           TYPE REF TO if_ish_gui_model.

  CHECK sender IS BOUND.
  TRY.
      lr_entry ?= sender.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  CHECK has_entry( lr_entry ) = abap_true.

  _remove_entry( lr_entry ).

ENDMETHOD.


METHOD on_entry_changed.

  DATA lr_entry               TYPE REF TO if_ish_gui_model.

* Check the sender.
  CHECK sender IS BOUND.
  TRY.
      lr_entry ?= sender.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

* Adjust entry changes.
  TRY.
      _adjust_entry_changes(
          ir_entry          = lr_entry
          it_changed_field  = et_changed_field ).
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD _add_entry.

  DATA lr_structmdl       TYPE REF TO if_ish_gui_structure_model.
  DATA lr_destroyable     TYPE REF TO if_ish_destroyable.

  r_added = super->_add_entry(
      ir_entry      = ir_entry
      i_idx         =  i_idx
      i_raise_event = i_raise_event ).

  CHECK ir_entry IS BOUND.

  TRY.
      lr_structmdl ?= ir_entry.
      SET HANDLER on_entry_changed  FOR lr_structmdl ACTIVATION abap_true.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_destroyable ?= ir_entry.
      SET HANDLER on_entry_after_destroy  FOR lr_destroyable ACTIVATION abap_true.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD _adjust_entry_changes.

  DATA lt_entry               LIKE gt_entry.
  DATA l_old_idx              TYPE i.
  DATA l_new_idx              TYPE i.

* The entry has to be specified.
  CHECK ir_entry IS BOUND.

* The entry has to belong to us.
  CHECK has_entry( ir_entry ) = abap_true.

* Remove?
  IF _is_entry_valid( ir_entry ) = abap_false.
    _remove_entry( ir_entry ).
    RETURN.
  ENDIF.

* Resort?
  DO 1 TIMES.
    l_old_idx = get_idx_by_entry( ir_entry ).
    lt_entry = gt_entry.
    DELETE TABLE gt_entry FROM ir_entry.
    TRY.
        l_new_idx = _get_idx_4_new_entry( ir_entry ).
      CATCH cx_ish_static_handler.
        gt_entry = lt_entry.
        RETURN.
    ENDTRY.
    gt_entry = lt_entry.
    IF l_new_idx < 1.
      l_new_idx = lines( gt_entry ).
    ENDIF.
    CHECK l_old_idx <> l_new_idx.
    _remove_entry( ir_entry ).
    _add_entry(
        ir_entry      = ir_entry
        i_idx         = l_new_idx
        i_raise_event = abap_true ).
  ENDDO.

ENDMETHOD.


METHOD _compare_entries.

  DATA lr_entry1                    TYPE REF TO if_ish_gui_structure_model.
  DATA lr_entry2                    TYPE REF TO if_ish_gui_structure_model.
  DATA l_fieldname                  TYPE ish_fieldname.
  DATA l_field1                     TYPE string.
  DATA l_field2                     TYPE string.

  FIELD-SYMBOLS <ls_sortorder>      TYPE abap_sortorder.

  IF ir_entry1 IS NOT BOUND OR
     ir_entry2 IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_COMPARE_ENTRIES'
        i_mv3        = 'CL_ISH_GM_SORTED_TABLE' ).
  ENDIF.

  TRY.
      lr_entry1 ?= ir_entry1.
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = '_COMPARE_ENTRIES'
          i_mv3        = 'CL_ISH_GM_SORTED_TABLE' ).
  ENDTRY.

  TRY.
      lr_entry2 ?= ir_entry2.
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '3'
          i_mv2        = '_COMPARE_ENTRIES'
          i_mv3        = 'CL_ISH_GM_SORTED_TABLE' ).
  ENDTRY.

  LOOP AT gt_sortorder ASSIGNING <ls_sortorder>.
    l_fieldname = <ls_sortorder>-name.
    CALL METHOD lr_entry1->get_field_content
      EXPORTING
        i_fieldname = l_fieldname
      CHANGING
        c_content   = l_field1.
    CALL METHOD lr_entry2->get_field_content
      EXPORTING
        i_fieldname = l_fieldname
      CHANGING
        c_content   = l_field2.
    IF <ls_sortorder>-descending = abap_true.
      IF l_field2 > l_field1.
        r_result = 1.
        RETURN.
      ELSEIF l_field2 < l_field1.
        r_result = 2.
        RETURN.
      ENDIF.
    ELSE.
      IF l_field2 < l_field1.
        r_result = 1.
        RETURN.
      ELSEIF l_field2 > l_field1.
        r_result = 2.
        RETURN.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD _get_idx_4_new_entry.

  DATA lr_entry           TYPE REF TO if_ish_gui_model.
  DATA l_idx              TYPE i.

  CHECK ir_entry IS BOUND.

  LOOP AT gt_entry INTO lr_entry.
    l_idx = l_idx + 1.
    CASE _compare_entries(
        ir_entry1 = lr_entry
        ir_entry2 = ir_entry ).
      WHEN 0 OR 1.
        r_idx = l_idx.
        RETURN.
    ENDCASE.
  ENDLOOP.

ENDMETHOD.


METHOD _is_entry_valid.

  DATA lr_destroyable               TYPE REF TO if_ish_destroyable.
  DATA lr_structmdl                 TYPE REF TO if_ish_gui_structure_model.
  DATA l_fieldname                  TYPE ish_fieldname.

  FIELD-SYMBOLS <ls_sortorder>      TYPE abap_sortorder.

  CHECK super->_is_entry_valid( ir_entry ) = abap_true.

  TRY.
      lr_destroyable ?= ir_entry.
      CHECK lr_destroyable->is_destroyed( ) = abap_false.
      CHECK lr_destroyable->is_in_destroy_mode( ) = abap_false.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_structmdl ?= ir_entry.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  LOOP AT gt_sortorder ASSIGNING <ls_sortorder>.
    l_fieldname = <ls_sortorder>-name.
    IF lr_structmdl->is_field_supported( i_fieldname = l_fieldname ) = abap_false.
      RETURN.
    ENDIF.
  ENDLOOP.

  r_valid = abap_true.

ENDMETHOD.


METHOD _remove_entry.

  DATA lr_entry           TYPE REF TO if_ish_gui_structure_model.

  r_removed = super->_remove_entry(
      ir_entry      = ir_entry
      i_raise_event = i_raise_event ).
  CHECK ir_entry IS BOUND.

  TRY.
      lr_entry ?= ir_entry.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  SET HANDLER on_entry_changed  FOR lr_entry ACTIVATION abap_false.

ENDMETHOD.
ENDCLASS.
