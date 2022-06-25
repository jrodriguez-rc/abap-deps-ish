class CL_ISH_GUI_APPL_PROPERTIES definition
  public
  create public .

public section.
*"* public components of class CL_ISH_GUI_APPL_PROPERTIES
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_APPL_PROPERTIES .

  aliases CO_PROPTYPE_BOOLEAN
    for IF_ISH_GUI_APPL_PROPERTIES~CO_PROPTYPE_BOOLEAN .
  aliases CO_PROPTYPE_INTEGER
    for IF_ISH_GUI_APPL_PROPERTIES~CO_PROPTYPE_INTEGER .
  aliases CO_PROPTYPE_STRING
    for IF_ISH_GUI_APPL_PROPERTIES~CO_PROPTYPE_STRING .
  aliases ADD_BOOLEAN
    for IF_ISH_GUI_APPL_PROPERTIES~ADD_BOOLEAN .
  aliases ADD_INTEGER
    for IF_ISH_GUI_APPL_PROPERTIES~ADD_INTEGER .
  aliases ADD_STRING
    for IF_ISH_GUI_APPL_PROPERTIES~ADD_STRING .
  aliases GET_BOOLEAN
    for IF_ISH_GUI_APPL_PROPERTIES~GET_BOOLEAN .
  aliases GET_INTEGER
    for IF_ISH_GUI_APPL_PROPERTIES~GET_INTEGER .
  aliases GET_PROPERTIES
    for IF_ISH_GUI_APPL_PROPERTIES~GET_PROPERTIES .
  aliases GET_PROPERTY_TYPE
    for IF_ISH_GUI_APPL_PROPERTIES~GET_PROPERTY_TYPE .
  aliases GET_STRING
    for IF_ISH_GUI_APPL_PROPERTIES~GET_STRING .
  aliases HAS_PROPERTY
    for IF_ISH_GUI_APPL_PROPERTIES~HAS_PROPERTY .
  aliases SET_BOOLEAN
    for IF_ISH_GUI_APPL_PROPERTIES~SET_BOOLEAN .
  aliases SET_INTEGER
    for IF_ISH_GUI_APPL_PROPERTIES~SET_INTEGER .
  aliases SET_STRING
    for IF_ISH_GUI_APPL_PROPERTIES~SET_STRING .
protected section.
*"* protected components of class CL_ISH_GUI_APPL_PROPERTIES
*"* do not include other source files here!!!

  data GT_PROP type ISH_T_GUI_APPLPROP_HASH .
private section.
*"* private components of class CL_ISH_GUI_APPL_PROPERTIES
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_APPL_PROPERTIES IMPLEMENTATION.


METHOD if_ish_gui_appl_properties~add_boolean.

  DATA:
    ls_prop            LIKE LINE OF gt_prop.

  ls_prop-applprop_name          = i_name.
  ls_prop-applprop_type          = co_proptype_boolean.
  ls_prop-applprop_value_boolean = i_value.

  INSERT ls_prop INTO TABLE gt_prop.
  CHECK sy-subrc = 0.

  r_success = abap_true.

ENDMETHOD.


METHOD if_ish_gui_appl_properties~add_integer.

  DATA:
    ls_prop            LIKE LINE OF gt_prop.

  ls_prop-applprop_name          = i_name.
  ls_prop-applprop_type          = co_proptype_integer.
  ls_prop-applprop_value_integer = i_value.

  INSERT ls_prop INTO TABLE gt_prop.
  CHECK sy-subrc = 0.

  r_success = abap_true.

ENDMETHOD.


METHOD if_ish_gui_appl_properties~add_string.

  DATA:
    ls_prop            LIKE LINE OF gt_prop.

  ls_prop-applprop_name         = i_name.
  ls_prop-applprop_type         = co_proptype_string.
  ls_prop-applprop_value_string = i_value.

  INSERT ls_prop INTO TABLE gt_prop.
  CHECK sy-subrc = 0.

  r_success = abap_true.

ENDMETHOD.


METHOD if_ish_gui_appl_properties~get_boolean.

  FIELD-SYMBOLS:
    <ls_prop>        LIKE LINE OF gt_prop.

  READ TABLE gt_prop
    WITH TABLE KEY applprop_name = i_name
    ASSIGNING <ls_prop>.
  CHECK sy-subrc = 0.

  CHECK <ls_prop>-applprop_type = co_proptype_boolean.

  r_value = <ls_prop>-applprop_value_boolean.

ENDMETHOD.


METHOD if_ish_gui_appl_properties~get_integer.

  FIELD-SYMBOLS:
    <ls_prop>        LIKE LINE OF gt_prop.

  READ TABLE gt_prop
    WITH TABLE KEY applprop_name = i_name
    ASSIGNING <ls_prop>.
  CHECK sy-subrc = 0.

  CHECK <ls_prop>-applprop_type = co_proptype_integer.

  r_value = <ls_prop>-applprop_value_integer.

ENDMETHOD.


METHOD if_ish_gui_appl_properties~get_properties.

  rt_properties = gt_prop.

ENDMETHOD.


METHOD if_ish_gui_appl_properties~get_property_type.

  FIELD-SYMBOLS:
    <ls_prop>        LIKE LINE OF gt_prop.

  READ TABLE gt_prop
    WITH TABLE KEY applprop_name = i_name
    ASSIGNING <ls_prop>.
  CHECK sy-subrc = 0.

  r_property_type = <ls_prop>-applprop_type.

ENDMETHOD.


METHOD if_ish_gui_appl_properties~get_string.

  FIELD-SYMBOLS:
    <ls_prop>        LIKE LINE OF gt_prop.

  READ TABLE gt_prop
    WITH TABLE KEY applprop_name = i_name
    ASSIGNING <ls_prop>.
  CHECK sy-subrc = 0.

  CHECK <ls_prop>-applprop_type = co_proptype_string.

  r_value = <ls_prop>-applprop_value_string.

ENDMETHOD.


METHOD if_ish_gui_appl_properties~has_property.

  READ TABLE gt_prop
    WITH TABLE KEY applprop_name = i_name
    TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_has_property = abap_true.

ENDMETHOD.


METHOD if_ish_gui_appl_properties~set_boolean.

  FIELD-SYMBOLS:
    <ls_prop>        LIKE LINE OF gt_prop.

  READ TABLE gt_prop
    WITH TABLE KEY applprop_name = i_name
    ASSIGNING <ls_prop>.
  CHECK sy-subrc = 0.

  CHECK <ls_prop>-applprop_type = co_proptype_boolean.

  <ls_prop>-applprop_value_boolean = i_value.

  r_success = abap_true.

ENDMETHOD.


METHOD if_ish_gui_appl_properties~set_integer.

  FIELD-SYMBOLS:
    <ls_prop>        LIKE LINE OF gt_prop.

  READ TABLE gt_prop
    WITH TABLE KEY applprop_name = i_name
    ASSIGNING <ls_prop>.
  CHECK sy-subrc = 0.

  CHECK <ls_prop>-applprop_type = co_proptype_integer.

  <ls_prop>-applprop_value_integer = i_value.

  r_success = abap_true.

ENDMETHOD.


METHOD if_ish_gui_appl_properties~set_string.

  FIELD-SYMBOLS:
    <ls_prop>        LIKE LINE OF gt_prop.

  READ TABLE gt_prop
    WITH TABLE KEY applprop_name = i_name
    ASSIGNING <ls_prop>.
  CHECK sy-subrc = 0.

  CHECK <ls_prop>-applprop_type = co_proptype_string.

  <ls_prop>-applprop_value_string = i_value.

  r_success = abap_true.

ENDMETHOD.
ENDCLASS.
