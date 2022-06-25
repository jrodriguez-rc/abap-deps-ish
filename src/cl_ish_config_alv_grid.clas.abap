class CL_ISH_CONFIG_ALV_GRID definition
  public
  create protected .

*"* public components of class CL_ISH_CONFIG_ALV_GRID
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONFIG_ALV_GRID .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .
  aliases ADD_MERGE_FIELDS
    for IF_ISH_CONFIG_ALV_GRID~ADD_MERGE_FIELDS .
  aliases BUILD_GRID_EXCL_FUNC
    for IF_ISH_CONFIG_ALV_GRID~BUILD_GRID_EXCL_FUNC .
  aliases BUILD_GRID_F4
    for IF_ISH_CONFIG_ALV_GRID~BUILD_GRID_F4 .
  aliases BUILD_GRID_FIELDCAT
    for IF_ISH_CONFIG_ALV_GRID~BUILD_GRID_FIELDCAT .
  aliases BUILD_GRID_FILTER
    for IF_ISH_CONFIG_ALV_GRID~BUILD_GRID_FILTER .
  aliases BUILD_GRID_LAYOUT
    for IF_ISH_CONFIG_ALV_GRID~BUILD_GRID_LAYOUT .
  aliases BUILD_GRID_MENU_BUTTON
    for IF_ISH_CONFIG_ALV_GRID~BUILD_GRID_MENU_BUTTON .
  aliases BUILD_GRID_REFRESH_INFO
    for IF_ISH_CONFIG_ALV_GRID~BUILD_GRID_REFRESH_INFO .
  aliases BUILD_GRID_SORT
    for IF_ISH_CONFIG_ALV_GRID~BUILD_GRID_SORT .
  aliases BUILD_GRID_TOOLBAR
    for IF_ISH_CONFIG_ALV_GRID~BUILD_GRID_TOOLBAR .
  aliases BUILD_GRID_VARIANT
    for IF_ISH_CONFIG_ALV_GRID~BUILD_GRID_VARIANT .
  aliases DESTROY
    for IF_ISH_CONFIG_ALV_GRID~DESTROY .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases HANDLE_ONDRAG
    for IF_ISH_CONFIG_ALV_GRID~HANDLE_ONDRAG .
  aliases HANDLE_ONDROP
    for IF_ISH_CONFIG_ALV_GRID~HANDLE_ONDROP .
  aliases HANDLE_ONDROPCOMPLETE
    for IF_ISH_CONFIG_ALV_GRID~HANDLE_ONDROPCOMPLETE .
  aliases HANDLE_ONDROPGETFLAVOR
    for IF_ISH_CONFIG_ALV_GRID~HANDLE_ONDROPGETFLAVOR .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases PRINT_END_OF_LIST
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_PRINT_END_OF_LIST .
  aliases PRINT_END_OF_PAGE
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_PRINT_END_OF_PAGE .
  aliases PRINT_TOP_OF_LIST
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_PRINT_TOP_OF_LIST .
  aliases PRINT_TOP_OF_PAGE
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_PRINT_TOP_OF_PAGE .
  aliases PROCESS_BUTTON_CLICK
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_BUTTON_CLICK .
  aliases PROCESS_DOUBLE_CLICK
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_DOUBLE_CLICK .
  aliases PROCESS_HOTSPOT_CLICK
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_HOTSPOT_CLICK .
  aliases PROCESS_SYSEV_BUTTON_CLICK
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_SYSEV_BUTTON_CLICK .
  aliases PROCESS_SYSEV_DOUBLE_CLICK
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_SYSEV_DOUBLE_CLICK .
  aliases PROCESS_SYSEV_HOTSPOT_CLICK
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_SYSEV_HOTSPOT_CLICK .
  aliases PROCESS_SYSEV_UCOMM
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_SYSEV_UCOMM .
  aliases PROCESS_USER_COMMAND
    for IF_ISH_CONFIG_ALV_GRID~PROCESS_USER_COMMAND .
  aliases SET_FIELD_FOR_ALT_SELECTION
    for IF_ISH_CONFIG_ALV_GRID~SET_FIELD_FOR_ALT_SELECTION .

  constants CO_OTYPE_CONFIG_ALV_GRID type ISH_OBJECT_TYPE value 3019. "#EC NOTEXT

  class-methods CREATE
    exporting
      !ER_INSTANCE type ref to CL_ISH_CONFIG_ALV_GRID
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_CONFIG_ALV_GRID
*"* do not include other source files here!!!

  methods FILL_INSTANCE_BY_CONFIG
    importing
      !IR_CONFIG type ref to CL_ISH_CONFIG_ALV_GRID
      value(I_COPY) type ISH_ON_OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_CONFIG_ALV_GRID
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_CONFIG_ALV_GRID IMPLEMENTATION.


METHOD create.

  CREATE OBJECT er_instance.

ENDMETHOD.


METHOD fill_instance_by_config.
* No implementation yet
ENDMETHOD.


METHOD if_ish_config_alv_grid~add_merge_fields.

* The default implementation does not modify anything.
  e_rc = 0.

ENDMETHOD.


METHOD if_ish_config_alv_grid~build_grid_excl_func.

* The default implementation does not modify anything.

  e_rc = 0.
  e_excl_func_changed = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~build_grid_f4.

* The default implementation does not modify anything.

  e_rc = 0.
  e_f4_changed = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~build_grid_fieldcat.

* The default implementation does not modify anything.

  e_rc = 0.
  e_fieldcat_changed = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~build_grid_filter.

* The default implementation does not modify anything.

  e_rc = 0.
  e_filter_changed = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~build_grid_layout.

* The default implementation does not modify anything.

  e_rc = 0.
  e_layout_changed = off.

ENDMETHOD.


method IF_ISH_CONFIG_ALV_GRID~BUILD_GRID_MENU_BUTTON.

* The default implementation does not modify anything.

endmethod.


METHOD if_ish_config_alv_grid~build_grid_refresh_info.

* The default implementation does not modify anything.

  e_rc = 0.
  e_refresh_info_changed = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~build_grid_sort.

* The default implementation does not modify anything.

  e_rc = 0.
  e_sort_changed = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~build_grid_toolbar.

* The default implementation does not modify anything.

ENDMETHOD.


METHOD if_ish_config_alv_grid~build_grid_variant.

* The default implementation does not modify anything.

  e_rc = 0.
  e_variant_changed = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~clone.
  DATA: lr_config TYPE REF TO cl_ish_config_alv_grid,
        l_rc      TYPE ish_method_rc.

  CALL METHOD cl_ish_config_alv_grid=>create
    IMPORTING
      er_instance = lr_config
      e_rc        = l_rc.
  IF l_rc <> 0.
    EXIT.
  ENDIF.

  CALL METHOD lr_config->fill_instance_by_config
    EXPORTING
      ir_config = me
      i_copy    = off
    IMPORTING
      e_rc      = l_rc.
  IF l_rc <> 0.
    EXIT.
  ENDIF.
  rr_config = lr_config.
ENDMETHOD.


METHOD if_ish_config_alv_grid~copy.
  DATA: lr_config TYPE REF TO cl_ish_config_alv_grid,
        l_rc      TYPE ish_method_rc.

  CALL METHOD cl_ish_config_alv_grid=>create
    IMPORTING
      er_instance = lr_config
      e_rc        = l_rc.
  IF l_rc <> 0.
    EXIT.
  ENDIF.

  CALL METHOD lr_config->fill_instance_by_config
    EXPORTING
      ir_config = me
      i_copy    = off
    IMPORTING
      e_rc      = l_rc.
  IF l_rc <> 0.
    EXIT.
  ENDIF.
  rr_config = lr_config.
ENDMETHOD.


METHOD if_ish_config_alv_grid~destroy.
ENDMETHOD.


METHOD if_ish_config_alv_grid~handle_ondrag.

* No default implementation.
* Redefine if needed.

  e_rc = 0.
  e_handled = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~handle_ondrop.

* No default implementation.
* Redefine if needed.

  e_rc = 0.
  e_handled = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~handle_ondropcomplete.

* No default implementation.
* Redefine if needed.

  e_rc = 0.
  e_handled = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~handle_ondropgetflavor.

* No default implementation.
* Redefine if needed.

  e_rc = 0.
  e_handled = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_button_click.

* Initializations
  e_handled = off.
  e_rc = 0.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_double_click.

* Initializations
  e_ucomm_handled = off.
  e_rc = 0.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_hotspot_click.

* Initializations
  e_ucomm_handled = off.
  e_rc = 0.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_print_end_of_list.

* Initializations
  e_handled = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_print_end_of_page.

* Initializations
  e_handled = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_print_top_of_list.

* Initializations
  e_handled = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_print_top_of_page.

* Initializations
  e_handled = off.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_sysev_button_click.

* Initializations
  e_handled = off.
  e_rc = 0.
  clear et_modi.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_sysev_double_click.

* Initializations
  e_handled = off.
  e_rc = 0.
  CLEAR et_modi.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_sysev_hotspot_click.

* Initializations
  e_handled = off.
  e_rc = 0.
  CLEAR et_modi.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_sysev_ucomm.

* Initializations
  e_handled = off.
  e_rc = 0.
  clear et_modi.

ENDMETHOD.


METHOD if_ish_config_alv_grid~process_user_command.

* Initializations
  e_ucomm_handled = off.
  e_rc = 0.

ENDMETHOD.


METHOD if_ish_config_alv_grid~set_field_for_alt_selection.

* The default implementation does not modify anything.
  e_rc = 0.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_config_alv_grid.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_object_type TYPE i.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.
  IF l_object_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.


ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_config_alv_grid.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.
ENDCLASS.
