class CL_ISH_GUI_DYNPRO_LAYOUT definition
  public
  inheriting from CL_ISH_GUI_VIEW_LAYOUT
  create public .

public section.
*"* public components of class CL_ISH_GUI_DYNPRO_LAYOUT
*"* do not include other source files here!!!

  constants CO_FIELDNAME_VCODE type ISH_FIELDNAME value 'VCODE'. "#EC NOTEXT
  constants CO_FIELDNAME_DEF_CURSORFIELD type ISH_FIELDNAME value 'DEFAULT_CURSORFIELD'. "#EC NOTEXT
  constants CO_FIELDNAME_T_FIELDDEF type ISH_FIELDNAME value 'T_FIELDDEF'. "#EC NOTEXT
  constants CO_FIELDPROP_CAN type N1GUI_DYNPLAY_FIELDPROP value 'CAN'. "#EC NOTEXT
  constants CO_FIELDPROP_DISPLAY type N1GUI_DYNPLAY_FIELDPROP value 'DISPLAY'. "#EC NOTEXT
  constants CO_FIELDPROP_INACTIVE type N1GUI_DYNPLAY_FIELDPROP value 'INACTIVE'. "#EC NOTEXT
  constants CO_FIELDPROP_MUST type N1GUI_DYNPLAY_FIELDPROP value 'MUST'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_VCODE type ISH_VCODE default SPACE
      !I_DEFAULT_CURSORFIELD type N1GUI_DEFAULT_CURSORFIELD optional
      !IT_FIELDDEF type ISH_T_GUI_DYNPLAY_FIELDDEF_H optional
    preferred parameter I_ELEMENT_NAME .
  methods GET_DEFAULT_CURSORFIELD
    returning
      value(R_DEFAULT_CURSORFIELD) type N1GUI_DEFAULT_CURSORFIELD .
  methods GET_FIELDDEFS
    returning
      value(RT_FIELDDEF) type ISH_T_GUI_DYNPLAY_FIELDDEF_H .
  methods GET_FIELDPROP
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_FIELDPROP) type N1GUI_DYNPLAY_FIELDPROP .
  methods GET_VCODE
  final
    returning
      value(R_VCODE) type ISH_VCODE .
  type-pools ABAP .
  methods SET_DEFAULT_CURSORFIELD
    importing
      !I_DEFAULT_CURSORFIELD type N1GUI_DEFAULT_CURSORFIELD
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_FIELDDEFS
    importing
      !IT_FIELDDEF type ISH_T_GUI_DYNPLAY_FIELDDEF_H
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_FIELDPROP
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_FIELDPROP type N1GUI_DYNPLAY_FIELDPROP
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .

  methods IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT
    redefinition .
  methods IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS
    redefinition .
  methods IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_DYNPRO_LAYOUT
*"* do not include other source files here!!!

  data GS_DATA type RN1_GUI_LAYO_DYNPRO_DATA .

  methods _GET_T_DATAREF
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_DYNPRO_LAYOUT
*"* do not include other source files here!!!

  data G_VCODE type ISH_VCODE .
ENDCLASS.



CLASS CL_ISH_GUI_DYNPRO_LAYOUT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name        = i_element_name
      i_layout_name         = i_layout_name ).

  g_vcode                     = i_vcode.
  gs_data-default_cursorfield = i_default_cursorfield.
  gs_data-t_fielddef          = it_fielddef.

ENDMETHOD.


METHOD get_default_cursorfield.

  r_default_cursorfield = gs_data-default_cursorfield.

ENDMETHOD.


METHOD get_fielddefs.

  rt_fielddef = gs_data-t_fielddef.

ENDMETHOD.


METHOD get_fieldprop.

  FIELD-SYMBOLS <ls_fielddef>           LIKE LINE OF gs_data-t_fielddef.

  READ TABLE gs_data-t_fielddef
    WITH TABLE KEY fieldname = i_fieldname
    ASSIGNING <ls_fielddef>.
  CHECK sy-subrc = 0.

  r_fieldprop = <ls_fielddef>-fieldprop.

ENDMETHOD.


METHOD get_vcode.

  r_vcode = g_vcode.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA l_vcode                TYPE ish_vcode.
  DATA l_rc                   TYPE ish_method_rc.

* Handle special fields.
  CASE i_fieldname.
    WHEN co_fieldname_vcode.
      l_vcode = get_vcode( ).
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source = l_vcode
        IMPORTING
          e_rc     = l_rc
        CHANGING
          c_target = c_content.
    WHEN OTHERS.
      CALL METHOD super->get_field_content
        EXPORTING
          i_fieldname = i_fieldname
        CHANGING
          c_content   = c_content.
      RETURN.
  ENDCASE.

* Errorhandling.
  IF l_rc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_GUI_DYNPRO_LAYOUT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  rt_supported_fieldname = super->get_supported_fields( ).

  INSERT co_fieldname_vcode INTO TABLE rt_supported_fieldname.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  CHECK i_fieldname <> co_fieldname_vcode.

  r_changed = super->set_field_content(
      i_fieldname = i_fieldname
      i_content   = i_content ).

ENDMETHOD.


METHOD set_default_cursorfield.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_def_cursorfield
      i_content   = i_default_cursorfield ).

ENDMETHOD.


METHOD set_fielddefs.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_t_fielddef
      i_content   = it_fielddef ).

ENDMETHOD.


METHOD set_fieldprop.

  DATA lt_fielddef                      TYPE ish_t_gui_dynplay_fielddef_h.
  DATA ls_fielddef                      TYPE rn1gui_dynplay_fielddef.

  FIELD-SYMBOLS <ls_fielddef>           TYPE rn1gui_dynplay_fielddef.

  lt_fielddef = gs_data-t_fielddef.

  READ TABLE lt_fielddef
    WITH TABLE KEY fieldname = i_fieldname
    ASSIGNING <ls_fielddef>.
  IF sy-subrc = 0.
    CHECK i_fieldprop <> <ls_fielddef>-fieldprop.
    <ls_fielddef>-fieldprop = i_fieldprop.
  ELSE.
    ls_fielddef-fieldname = i_fieldname.
    ls_fielddef-fieldprop = i_fieldprop.
    INSERT ls_fielddef INTO TABLE lt_fielddef.
  ENDIF.

  r_changed = set_fielddefs( it_fielddef = lt_fielddef ).

ENDMETHOD.


METHOD _get_t_dataref.

  DATA lr_data            TYPE REF TO data.

  rt_dataref = super->_get_t_dataref( ).

  GET REFERENCE OF gs_data INTO lr_data.

  INSERT lr_data INTO TABLE rt_dataref.

ENDMETHOD.
ENDCLASS.
