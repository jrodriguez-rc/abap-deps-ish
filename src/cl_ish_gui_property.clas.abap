class CL_ISH_GUI_PROPERTY definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_PROPERTY
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL
      abstract methods SET_FIELD_CONTENT .
  interfaces IF_SERIALIZABLE_OBJECT .

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

  constants CO_FIELDNAME_NAME type ISH_FIELDNAME value 'NAME'. "#EC NOTEXT
  constants CO_FIELDNAME_VALUE type ISH_FIELDNAME value 'VALUE'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_NAME type N1GUI_PROPERTY_NAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_NAME
  final
    returning
      value(R_NAME) type N1GUI_PROPERTY_NAME .
protected section.
*"* protected components of class CL_ISH_GUI_PROPERTY
*"* do not include other source files here!!!

  methods _DESTROY
  abstract .
private section.
*"* private components of class CL_ISH_GUI_PROPERTY
*"* do not include other source files here!!!

  data GR_DATADESCR_NAME type ref to CL_ABAP_DATADESCR .
  type-pools ABAP .
  data G_CUSTOMIZABLE type ABAP_BOOL .
  data G_NAME type N1GUI_PROPERTY_NAME .
ENDCLASS.



CLASS CL_ISH_GUI_PROPERTY IMPLEMENTATION.


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


METHOD if_ish_gui_structure_model~get_field_content.

  CASE i_fieldname.
    WHEN co_fieldname_name.
      IF gr_datadescr_name->applies_to_data( p_data = c_content ) = abap_false.
        RAISE EXCEPTION TYPE cx_ish_static_handler.
      ENDIF.
      c_content = get_name( ).
    WHEN OTHERS.
      RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDCASE.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  INSERT co_fieldname_name INTO TABLE rt_supported_fieldname.

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  DATA:
    lt_supported_field            TYPE ish_t_fieldname.

  lt_supported_field = get_supported_fields( ).

  READ TABLE lt_supported_field FROM i_fieldname TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_supported = abap_true.

ENDMETHOD.
ENDCLASS.
