class CL_ISH_ORDSP_OBJECT definition
  public
  inheriting from CL_ISH_GM_PARENTCHILD_NODE
  abstract
  create public .

*"* public components of class CL_ISH_ORDSP_OBJECT
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_GUI_STRUCTURE_MODEL .

  aliases GET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .

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
*"* protected components of class CL_ISH_ORDSP_OBJECT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_ORDSP_OBJECT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_ORDSP_OBJECT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      ir_parent_node    = ir_parent_node
      ir_cb_tabmdl      = ir_cb_tabmdl
      ir_cb_xtabmdl     = ir_cb_xtabmdl
      i_allowed_entries = i_allowed_entries ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.
ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.
ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  DATA lt_supported_fieldname           TYPE ish_t_fieldname.

  lt_supported_fieldname = get_supported_fields( ).

  READ TABLE lt_supported_fieldname FROM i_fieldname TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_supported = abap_true.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  r_changed = abap_false.

ENDMETHOD.
ENDCLASS.
