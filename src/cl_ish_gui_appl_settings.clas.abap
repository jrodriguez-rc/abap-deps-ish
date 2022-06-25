class CL_ISH_GUI_APPL_SETTINGS definition
  public
  create public .

public section.
*"* public components of class CL_ISH_GUI_APPL_SETTINGS
*"* do not include other source files here!!!

  interfaces IF_SERIALIZABLE_OBJECT .
  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .

  aliases DESTROY
    for IF_ISH_DESTROYABLE~DESTROY .
  aliases GET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS .
  aliases IS_DESTROYED
    for IF_ISH_DESTROYABLE~IS_DESTROYED .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_DESTROYABLE~IS_IN_DESTROY_MODE .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases EV_AFTER_DESTROY
    for IF_ISH_DESTROYABLE~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_DESTROYABLE~EV_BEFORE_DESTROY .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .

  constants CO_FIELDNAME_USE_MSG_VIEWER type ISH_FIELDNAME value 'USE_MSG_VIEWER'. "#EC NOTEXT

  type-pools ABAP .
  methods CONSTRUCTOR
    importing
      !I_USE_MSG_VIEWER type N1GAS_USE_MSG_VIEWER default ABAP_FALSE
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    preferred parameter I_USE_MSG_VIEWER .
  methods GET_CLONE
    returning
      value(RR_CLONE) type ref to CL_ISH_GUI_APPL_SETTINGS
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_USE_MSG_VIEWER
    returning
      value(R_USE_MSG_VIEWER) type N1GAS_USE_MSG_VIEWER .
  methods SET_DATA_BY_OTHER
    importing
      !IR_OTHER type ref to CL_ISH_GUI_APPL_SETTINGS
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_USE_MSG_VIEWER
    importing
      value(I_USE_MSG_VIEWER) type N1GAS_USE_MSG_VIEWER
    returning
      value(R_CHANGED) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_GUI_APPL_SETTINGS
*"* do not include other source files here!!!

  data GR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .
  data G_USE_MSG_VIEWER type N1GAS_USE_MSG_VIEWER .

  methods _DESTROY .
  methods _SET_DATA_BY_OTHER
    importing
      !IR_OTHER type ref to CL_ISH_GUI_APPL_SETTINGS
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_GUI_APPL_SETTINGS
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_APPL_SETTINGS IMPLEMENTATION.


METHOD constructor.

  g_use_msg_viewer  = i_use_msg_viewer.
  gr_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD get_clone.

  CREATE OBJECT rr_clone
    EXPORTING
      i_use_msg_viewer = g_use_msg_viewer.

ENDMETHOD.


METHOD get_use_msg_viewer.

  r_use_msg_viewer = g_use_msg_viewer.

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


METHOD if_ish_gui_structure_model~get_field_content.

  DATA:
    lr_datadescr            TYPE REF TO cl_abap_datadescr.

  FIELD-SYMBOLS:
    <l_field>               TYPE data.

* Assign the field.
  CASE i_fieldname.
    WHEN co_fieldname_use_msg_viewer.
      ASSIGN g_use_msg_viewer TO <l_field>.
    WHEN OTHERS.
      RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDCASE.

* Check c_content.
  lr_datadescr ?= cl_abap_typedescr=>describe_by_data( <l_field> ).
  IF lr_datadescr->applies_to_data( p_data = c_content ) = abap_false.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* Export.
  c_content = <l_field>.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  APPEND co_fieldname_use_msg_viewer    TO rt_supported_fieldname.

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  DATA:
    lt_supported_field            TYPE ish_t_fieldname.

  lt_supported_field = get_supported_fields( ).

  READ TABLE lt_supported_field FROM i_fieldname TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_supported = abap_true.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  DATA:
    lr_datadescr            TYPE REF TO cl_abap_datadescr.

  CASE i_fieldname.
    WHEN co_fieldname_use_msg_viewer.
      lr_datadescr ?= cl_abap_typedescr=>describe_by_data( g_use_msg_viewer ).
      IF lr_datadescr->applies_to_data( p_data = i_content ) = abap_false.
        RAISE EXCEPTION TYPE cx_ish_static_handler.
      ENDIF.
      r_changed = set_use_msg_viewer( i_use_msg_viewer = i_content ).
    WHEN OTHERS.
      RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDCASE.

ENDMETHOD.


METHOD set_data_by_other.

  DATA:
    lt_changed_field            TYPE ish_t_fieldname.

  CHECK ir_other IS BOUND.
  CHECK ir_other <> me.

  lt_changed_field = _set_data_by_other( ir_other = ir_other ).
  CHECK lt_changed_field IS NOT INITIAL.

  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = lt_changed_field.

  r_changed = abap_true.

ENDMETHOD.


METHOD set_use_msg_viewer.

  DATA:
    lt_changed_field            TYPE ish_t_fieldname.

  CHECK i_use_msg_viewer <> g_use_msg_viewer.

  g_use_msg_viewer = i_use_msg_viewer.

  INSERT co_fieldname_use_msg_viewer INTO TABLE lt_changed_field.
  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = lt_changed_field.

  r_changed = abap_true.

ENDMETHOD.


METHOD _destroy.

  CLEAR g_use_msg_viewer.
  CLEAR gr_cb_destroyable.

ENDMETHOD.


METHOD _set_data_by_other.

  CHECK ir_other IS BOUND.
  CHECK ir_other <> me.

  IF g_use_msg_viewer <> ir_other->g_use_msg_viewer.
    g_use_msg_viewer = ir_other->g_use_msg_viewer.
    INSERT co_fieldname_use_msg_viewer INTO TABLE rt_changed_field.
  ENDIF.

ENDMETHOD.
ENDCLASS.
