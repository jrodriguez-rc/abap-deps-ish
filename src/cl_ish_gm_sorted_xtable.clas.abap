class CL_ISH_GM_SORTED_XTABLE definition
  public
  inheriting from CL_ISH_GM_XTABLE
  create public .

public section.
*"* public components of class CL_ISH_GM_SORTED_XTABLE
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_XTABMDL type ref to IF_ISH_GUI_CB_XTABLE_MODEL optional
      !IT_ENTRY type ISH_T_GUI_MODEL_OBJHASH optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
      !I_SORTFIELD type ISH_FIELDNAME optional
    preferred parameter IR_CB_TABMDL .
  methods GET_SORTFIELD
    returning
      value(R_SORTFIELD) type ISH_FIELDNAME .
  type-pools ABAP .
  methods SET_SORTFIELD
    importing
      !I_SORTFIELD type ISH_FIELDNAME optional
      !I_SORT_DESCENDING type ABAP_BOOL optional
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .

  methods IF_ISH_GUI_TABLE_MODEL~ADD_ENTRY
    redefinition .
protected section.
*"* protected components of class CL_ISH_GM_SORTED_XTABLE
*"* do not include other source files here!!!

  methods ON_COMPARABLE_CHANGED
    for event EV_CHANGED of IF_ISH_GM_COMPARABLE
    importing
      !ET_CHANGED_FIELD
      !SENDER .
  methods _ADD_COMPARABLE
    importing
      !IR_COMPARABLE type ref to IF_ISH_GM_COMPARABLE
      !I_RAISE_EVENT type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_ADDED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_IDX_4_NEW_COMPARABLE
    importing
      !IR_COMPARABLE type ref to IF_ISH_GM_COMPARABLE
    returning
      value(R_IDX) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods _SORT
    importing
      !I_SORTFIELD type ISH_FIELDNAME optional
      !I_SORT_DESCENDING type ABAP_BOOL optional
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .

  methods _CHECK_ADD_ENTRY
    redefinition .
  methods _CHECK_APPEND_ENTRY
    redefinition .
  methods _CHECK_PREPEND_ENTRY
    redefinition .
private section.
*"* private components of class CL_ISH_GM_SORTED_XTABLE
*"* do not include other source files here!!!

  data G_SORTFIELD type ISH_FIELDNAME .
ENDCLASS.



CLASS CL_ISH_GM_SORTED_XTABLE IMPLEMENTATION.


METHOD constructor.

  DATA lr_entry       TYPE REF TO if_ish_gui_model.
  DATA lr_comparable  TYPE REF TO if_ish_gm_comparable.

  CALL METHOD super->constructor
    EXPORTING
      ir_cb_tabmdl  = ir_cb_tabmdl
      ir_cb_xtabmdl = ir_cb_xtabmdl
      i_node_text   = i_node_text
      i_node_icon   = i_node_icon.

  g_sortfield = i_sortfield.

  LOOP AT it_entry INTO lr_entry.
    TRY.
      lr_comparable ?= lr_entry.
    CATCH cx_sy_move_cast_error.
      CONTINUE.
    ENDTRY.

    CHECK lr_comparable IS BOUND.

    TRY.
      _add_comparable(
        ir_comparable = lr_comparable
        i_raise_event = abap_false ).
    CATCH cx_ish_static_handler.
      CONTINUE.
    ENDTRY.
  ENDLOOP.

ENDMETHOD.


METHOD get_sortfield.

  r_sortfield = g_sortfield.

ENDMETHOD.


method IF_ISH_GUI_TABLE_MODEL~ADD_ENTRY.

  DATA lr_comparable      TYPE REF TO if_ish_gm_comparable.

* Callback.
  IF gr_cb_tabmdl IS BOUND.
    CHECK gr_cb_tabmdl->cb_add_entry(
              ir_model   = me
              ir_entry   = ir_entry ) = abap_true.
  ENDIF.

  TRY.
    lr_comparable ?= ir_entry.
  CATCH cx_sy_move_cast_error.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'ADD_ENTRY'
        i_mv3        = 'CL_ISHMED_SRV_SERVICES' ).
  ENDTRY.

* Append the entry.
  r_added = _add_comparable( ir_comparable = lr_comparable ).

endmethod.


method ON_COMPARABLE_CHANGED.
endmethod.


METHOD set_sortfield.

  IF i_sortfield <> g_sortfield.


    r_changed = _sort( i_sortfield = i_sortfield
                       i_sort_descending = i_sort_descending ).

  ENDIF.

  CHECK r_changed = abap_true.

  g_sortfield = i_sortfield.

ENDMETHOD.


METHOD _add_comparable.

  DATA l_idx      TYPE i.

  l_idx = _get_idx_4_new_comparable( ir_comparable ).

  r_added = _add_entry(
    ir_entry    = ir_comparable
    i_idx       = l_idx ).

  CHECK r_added = abap_true.

  SET HANDLER on_comparable_changed FOR ir_comparable ACTIVATION abap_true.

ENDMETHOD.


METHOD _check_add_entry.

  DATA lr_entry       TYPE REF TO if_ish_gm_comparable.
  DATA lr_comparable  TYPE REF TO if_ish_gm_comparable.

  TRY.
      lr_entry ?= ir_entry.

      CALL METHOD super->_check_add_entry
        EXPORTING
          ir_entry = lr_entry.

    CATCH cx_ish_static_handler .
  ENDTRY.

  TRY.
    lr_comparable ?= ir_entry.
  CATCH cx_sy_move_cast_error.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'ADD_ENTRY'
        i_mv3        = 'CL_ISHMED_SRV_SERVICES' ).
  ENDTRY.

ENDMETHOD.


METHOD _check_append_entry.

  TRY.

      CALL METHOD super->_check_append_entry
        EXPORTING
          ir_previous_entry = ir_previous_entry
          ir_entry          = ir_entry.

    CATCH cx_ish_static_handler .
  ENDTRY.

ENDMETHOD.


METHOD _check_prepend_entry.

  TRY.

      CALL METHOD super->_check_prepend_entry
        EXPORTING
          ir_next_entry = ir_next_entry
          ir_entry      = ir_entry.

    CATCH cx_ish_static_handler .
  ENDTRY.

ENDMETHOD.


METHOD _get_idx_4_new_comparable.

  DATA lr_entry       TYPE REF TO if_ish_gui_model.
  DATA lr_comparable  TYPE REF TO if_ish_gm_comparable.

  r_idx = LINES( gt_entry ) + 1.

  LOOP AT gt_entry INTO lr_entry.
    TRY.
      lr_comparable ?= lr_entry.
    CATCH cx_sy_move_cast_error.
      CONTINUE.
    ENDTRY.

    IF ir_comparable->compare_to(
          ir_other_comparable   = lr_comparable
          i_comparefield        = get_sortfield( ) ) < 0.
      r_idx = sy-tabix.
      RETURN.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD _sort.


* if gt_entry changed
*r_changed = abap_true.
* else
  r_changed = abap_true.
*endif.

ENDMETHOD.
ENDCLASS.
