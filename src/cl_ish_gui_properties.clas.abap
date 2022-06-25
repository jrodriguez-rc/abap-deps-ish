class CL_ISH_GUI_PROPERTIES definition
  public
  create public .

public section.
*"* public components of class CL_ISH_GUI_PROPERTIES
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_TABLE_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .
  interfaces IF_SERIALIZABLE_OBJECT .

  aliases ADD_ENTRY
    for IF_ISH_GUI_TABLE_MODEL~ADD_ENTRY .
  aliases GET_ENTRIES
    for IF_ISH_GUI_TABLE_MODEL~GET_ENTRIES .
  aliases GET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases REMOVE_ENTRY
    for IF_ISH_GUI_TABLE_MODEL~REMOVE_ENTRY .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .
  aliases EV_ENTRY_ADDED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_ADDED .
  aliases EV_ENTRY_REMOVED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_REMOVED .

  constants CO_FIELDNAME_NAME type ISH_FIELDNAME value 'NAME'. "#EC NOTEXT

  type-pools ABAP .
  methods ADD_PROPERTY
    importing
      !IR_PROPERTY type ref to CL_ISH_GUI_PROPERTY
    returning
      value(R_ADDED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !I_NAME type N1GUI_PROPERTIES_NAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_NAME
  final
    returning
      value(R_NAME) type N1GUI_PROPERTIES_NAME .
  methods GET_PROPERTY
    importing
      !I_PROPERTY_NAME type N1GUI_PROPERTY_NAME
    returning
      value(RR_PROPERTY) type ref to CL_ISH_GUI_PROPERTY .
  class-methods TEST1 .
  class-methods TEST2
    importing
      !I_CONTENT type ANY .
protected section.
*"* protected components of class CL_ISH_GUI_PROPERTIES
*"* do not include other source files here!!!

  data GT_PROPERTY type ISH_T_GUI_PROPERTY_HASH .

  methods ON_PROPERTY_CHANGED
    for event EV_CHANGED of CL_ISH_GUI_PROPERTY
    importing
      !ET_CHANGED_FIELD
      !SENDER .
  methods _DESTROY .
private section.
*"* private components of class CL_ISH_GUI_PROPERTIES
*"* do not include other source files here!!!

  data GR_DATADESCR_NAME type ref to CL_ABAP_DATADESCR .
  data G_NAME type N1GUI_PROPERTIES_NAME .
ENDCLASS.



CLASS CL_ISH_GUI_PROPERTIES IMPLEMENTATION.


METHOD add_property.

  DATA:
    ls_property            LIKE LINE OF gt_property.

  CHECK ir_property IS BOUND.

  ls_property-r_property = ir_property.
  ls_property-name       = ir_property->get_name( ).
  INSERT ls_property INTO TABLE gt_property.
  CHECK sy-subrc = 0.

  SET HANDLER on_property_changed FOR ir_property ACTIVATION abap_true.

  RAISE EVENT ev_entry_added
    EXPORTING
      er_entry = ir_property.

  r_added = abap_true.

ENDMETHOD.


METHOD constructor.

  IF i_name IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  g_name = i_name.
  gr_datadescr_name ?= cl_abap_typedescr=>describe_by_data( p_data = g_name ).

ENDMETHOD.


METHOD get_name.

  r_name = g_name.

ENDMETHOD.


METHOD get_property.

  FIELD-SYMBOLS:
    <ls_property>            LIKE LINE OF gt_property.

  READ TABLE gt_property
    WITH TABLE KEY name = i_property_name
    ASSIGNING <ls_property>.
  CHECK sy-subrc = 0.

  rr_property = <ls_property>-r_property.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA:
    l_property_name            TYPE n1gui_property_name,
    lr_property                TYPE REF TO cl_ish_gui_property.

  l_property_name = i_fieldname.
  lr_property = get_property( i_property_name = l_property_name ).
  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  CALL METHOD lr_property->get_field_content
    EXPORTING
      i_fieldname = cl_ish_gui_property=>co_fieldname_value
    CHANGING
      c_content   = c_content.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  DATA:
    l_fieldname              TYPE ish_fieldname.

  FIELD-SYMBOLS:
    <ls_property>            LIKE LINE OF gt_property.

  LOOP AT gt_property ASSIGNING <ls_property>.
    l_fieldname = <ls_property>-name.
    INSERT l_fieldname INTO TABLE rt_supported_fieldname.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  DATA:
    l_property_name            TYPE n1gui_property_name.

  l_property_name = i_fieldname.
  CHECK get_property( i_property_name = l_property_name ) IS BOUND.

  r_supported = abap_true.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  DATA:
    l_property_name        TYPE n1gui_property_name,
    lr_property            TYPE REF TO cl_ish_gui_property.

  l_property_name = i_fieldname.
  lr_property = get_property( i_property_name = l_property_name ).
  IF lr_property IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  r_changed = lr_property->set_field_content( i_fieldname = cl_ish_gui_property=>co_fieldname_value
                                              i_content   = i_content ).

ENDMETHOD.


METHOD if_ish_gui_table_model~add_entry.

  DATA:
    lr_property        TYPE REF TO cl_ish_gui_property,
    lx_root            TYPE REF TO cx_root.

  CHECK ir_entry IS BOUND.

  TRY.
      lr_property ?= ir_entry.
    CATCH cx_sy_move_cast_error INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

  r_added = add_property( ir_property = lr_property ).

ENDMETHOD.


METHOD if_ish_gui_table_model~get_entries.

  FIELD-SYMBOLS:
    <ls_property>              LIKE LINE OF gt_property.

  LOOP AT gt_property ASSIGNING <ls_property>.
    CHECK <ls_property>-r_property IS BOUND.
    INSERT <ls_property>-r_property INTO TABLE rt_entry.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_table_model~remove_entry.

* Not supported.

ENDMETHOD.


METHOD on_property_changed.

  DATA:
    lr_property            TYPE REF TO cl_ish_gui_property,
    l_property_name        TYPE n1gui_property_name,
    l_fieldname            TYPE ish_fieldname,
    lt_changed_field       TYPE ish_t_fieldname.

  CHECK sender IS BOUND.

  TRY.
      lr_property ?= sender.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  l_property_name = lr_property->get_name( ).
  CHECK get_property( i_property_name = l_property_name ) = lr_property.

  l_fieldname = l_property_name.
  INSERT l_fieldname INTO TABLE lt_changed_field.
  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = lt_changed_field.

ENDMETHOD.


METHOD test1.

  DATA:
    lx_root            TYPE REF TO cx_root.

  TRY.
      test2( i_content = 'ASDF' ).
    CATCH cx_root INTO lx_root.
  ENDTRY.

ENDMETHOD.


METHOD test2.

  DATA:
    l_string                TYPE string,
    lr_datadescr            TYPE REF TO cl_abap_datadescr.

  lr_datadescr ?= cl_abap_typedescr=>describe_by_data( p_data = l_string ).

  CHECK lr_datadescr->applies_to_data( p_data = i_content ) = abap_true.

  l_string = i_content.

ENDMETHOD.


METHOD _destroy.

*  FIELD-SYMBOLS:
*    <ls_prop>            LIKE LINE OF gt_prop.
*
** Destroy the property objects.
*  LOOP AT gt_prop ASSIGNING <ls_prop>.
*    CHECK <ls_prop>-r_prop IS BOUND.
*    <ls_prop>-r_prop->destroy( ).
*  ENDLOOP.
*  CLEAR:
*    gt_prop.

ENDMETHOD.
ENDCLASS.
