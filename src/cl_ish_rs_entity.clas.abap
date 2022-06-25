class CL_ISH_RS_ENTITY definition
  public
  inheriting from CL_ISH_RS_OBJECT
  abstract
  create public .

*"* public components of class CL_ISH_RS_ENTITY
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .
  interfaces IF_ISH_RS_ENTITY .

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
protected section.
*"* protected components of class CL_ISH_RS_ENTITY
*"* do not include other source files here!!!

  methods _GET_DATAREF
  abstract
    returning
      value(RR_DATA) type ref to DATA .
private section.
*"* private components of class CL_ISH_RS_ENTITY
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_RS_ENTITY IMPLEMENTATION.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA lr_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>           TYPE data.

* get data
  lr_data = _get_dataref( ).
  CHECK lr_data IS BOUND.
  ASSIGN lr_data->* TO <ls_data>.

* get the content of a field
  CALL METHOD cl_ish_utl_gui_structure_model=>get_field_content
    EXPORTING
      ir_model    = me
      is_data     = <ls_data>
      i_fieldname = i_fieldname
    CHANGING
      c_content   = c_content.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  DATA lr_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>           TYPE data.

* Get data.
  lr_data = _get_dataref( ).
  CHECK lr_data IS BOUND.
  ASSIGN lr_data->* TO <ls_data>.

* get all supported fields
  rt_supported_fieldname = cl_ish_utl_gui_structure_model=>get_supported_fields( <ls_data> ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.


  DATA lr_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>           TYPE data.

* Get data.
  lr_data = _get_dataref( ).
  CHECK lr_data IS BOUND.
  ASSIGN lr_data->* TO <ls_data>.

* check if the field is supported
  r_supported = cl_ish_utl_gui_structure_model=>is_field_supported(
      is_data     = <ls_data>
      i_fieldname = i_fieldname ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.


  DATA: lr_data                TYPE REF TO data,
        l_continue             TYPE ish_on_off,
        lr_read_service        TYPE REF TO if_ish_rs_read_service,
        lt_changed_field       TYPE ish_t_fieldname.

  FIELD-SYMBOLS: <ls_data>    TYPE data.

* Get data.
  lr_data = _get_dataref( ).
  CHECK lr_data IS BOUND.
  ASSIGN lr_data->* TO <ls_data>.

* get the read service
  lr_read_service = get_read_service( ).

* Set the contents of a field
  CALL METHOD lr_read_service->if_ish_gui_cb_structure_model~cb_set_field_content
    EXPORTING
      ir_model    = me
      i_fieldname = i_fieldname
      i_content   = i_content
    RECEIVING
      r_continue  = l_continue.

  CHECK l_continue = abap_true.

* Set field content.
  CALL METHOD cl_ish_utl_gui_structure_model=>set_field_content
    EXPORTING
      ir_model    = me
      i_fieldname = i_fieldname
      i_content   = i_content
    IMPORTING
      e_changed   = r_changed
    CHANGING
      cs_data     = <ls_data>.
  CHECK r_changed = abap_true.

* Raise event ev_changed.
  INSERT i_fieldname INTO TABLE lt_changed_field.
  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = lt_changed_field.

ENDMETHOD.
ENDCLASS.
