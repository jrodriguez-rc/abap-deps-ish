class CL_ISH_GM_NTPK definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_GM_NTPK
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .
  interfaces IF_ISH_GUI_TREENODE_MODEL .

  aliases GET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT .
  aliases GET_NODE_ICON
    for IF_ISH_GUI_TREENODE_MODEL~GET_NODE_ICON .
  aliases GET_NODE_TEXT
    for IF_ISH_GUI_TREENODE_MODEL~GET_NODE_TEXT .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .

  constants CO_FIELDNAME_KATKB type ISH_FIELDNAME value 'KATKB'. "#EC NOTEXT
  type-pools ICON .
  constants CO_ICON_FOLDER type TV_IMAGE value ICON_OBJECT_FOLDER. "#EC NOTEXT
  constants CO_ICON_LEAF type TV_IMAGE value ICON_ACTIVITY_TYPE. "#EC NOTEXT

  methods GET_KATKB
    returning
      value(R_KATKB) type KATKB .
  class-methods NEW_INSTANCE
    importing
      !IS_DATA type RN1_NTPKHIERNODE_DATA
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_NTPK
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !IS_DATA type RN1_NTPKHIERNODE_DATA
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DATA
  final
    returning
      value(RS_DATA) type RN1_NTPKHIERNODE_DATA .
  methods GET_EINRI
  final
    returning
      value(R_EINRI) type EINRI .
  methods GET_TALST
  final
    returning
      value(R_TALST) type TARLS .
  methods GET_TALST_TEXT
  final
    returning
      value(R_TALST_TEXT) type N1LEITXT .
  methods GET_TARIF
  final
    returning
      value(R_TARIF) type TARID .
  methods GET_TGRKZ
  final
    returning
      value(R_TGRKZ) type TGRU_KZ .
protected section.
*"* protected components of class CL_ISH_GM_NTPK
*"* do not include other source files here!!!

  data GS_DATA type RN1_NTPKHIERNODE_DATA .
  data G_KATKB type KATKB .
private section.
*"* private components of class CL_ISH_GM_NTPK
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_NTPK IMPLEMENTATION.


METHOD constructor.

* Initialize attributes.
  gs_data     = is_data.

ENDMETHOD.


METHOD get_data.

  rs_data = gs_data.

ENDMETHOD.


METHOD get_einri.

  r_einri = gs_data-einri.

ENDMETHOD.


METHOD get_katkb.

  DATA l_einri          TYPE einri.
  DATA l_tarif          TYPE tarid.

  IF g_katkb IS INITIAL.
    l_einri = get_einri( ).
    l_tarif = get_tarif( ).
    SELECT SINGLE katkb FROM tnk01 INTO g_katkb WHERE
                                      einri = l_einri AND
                                      katid = l_tarif.
  ENDIF.

  r_katkb = g_katkb.

ENDMETHOD.


METHOD GET_TALST.

  r_talst = gs_data-talst.

ENDMETHOD.


METHOD get_talst_text.

  r_talst_text = gs_data-talst_text.

ENDMETHOD.


METHOD get_tarif.

  r_tarif = gs_data-tarif.

ENDMETHOD.


METHOD GET_TGRKZ.

  r_tgrkz = gs_data-tgrkz.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  CASE i_fieldname.
    WHEN co_fieldname_katkb.
      c_content = get_katkb( ).

    WHEN OTHERS.
      CALL METHOD cl_ish_utl_gui_structure_model=>get_field_content
        EXPORTING
          ir_model    = me
          is_data     = gs_data
          i_fieldname = i_fieldname
        CHANGING
          c_content   = c_content.

  ENDCASE.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  rt_supported_fieldname = cl_ish_utl_gui_structure_model=>get_supported_fields(
      is_data = gs_data ).

  INSERT co_fieldname_katkb       INTO TABLE rt_supported_fieldname.

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  r_supported = cl_ish_utl_gui_structure_model=>is_field_supported(
      is_data     = gs_data
      i_fieldname = i_fieldname ).

  CHECK r_supported = abap_false.
  CHECK i_fieldname = co_fieldname_katkb.
  r_supported = abap_true.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

* No changes allowed.

ENDMETHOD.


METHOD if_ish_gui_treenode_model~get_node_icon.

  r_node_icon = co_icon_leaf.   "icon_activity_type.

ENDMETHOD.


METHOD if_ish_gui_treenode_model~get_node_text.

  r_node_text = get_talst_text( ).

ENDMETHOD.


METHOD new_instance.

  CREATE OBJECT rr_instance
    EXPORTING
      is_data = is_data.

ENDMETHOD.
ENDCLASS.
