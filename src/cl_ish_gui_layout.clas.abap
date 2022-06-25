class CL_ISH_GUI_LAYOUT definition
  public
  inheriting from CL_ISH_GUI_ELEMENT
  abstract
  create public .

*"* public components of class CL_ISH_GUI_LAYOUT
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .
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

  constants CO_CLRC_CANCELLED type N1GUI_CONFIG_LAYOUT_RC value 1. "#EC NOTEXT
  constants CO_CLRC_CONFIRMED type N1GUI_CONFIG_LAYOUT_RC value 2. "#EC NOTEXT
  constants CO_CLRC_NOPROC type N1GUI_CONFIG_LAYOUT_RC value 0. "#EC NOTEXT
  constants CO_CLRC_SAVED type N1GUI_CONFIG_LAYOUT_RC value 3. "#EC NOTEXT
  constants CO_DEF_CONFIG_CTRNAME type N1GUI_ELEMENT_NAME value 'LAYOUT_CONFIG_CTR'. "#EC NOTEXT
  constants CO_FIELDNAME_LAYOUT_NAME type ISH_FIELDNAME value 'LAYOUT_NAME'. "#EC NOTEXT
  constants CO_FIELDNAME_WAS_LOADED type ISH_FIELDNAME value 'WAS_LOADED'. "#EC NOTEXT
  constants CO_LAYOFUNC_DISPLAY type N1GUI_LAYOUT_FUNCTION value 1. "#EC NOTEXT
  constants CO_LAYOFUNC_EDIT type N1GUI_LAYOUT_FUNCTION value 2. "#EC NOTEXT
  constants CO_LAYOFUNC_NONE type N1GUI_LAYOUT_FUNCTION value 0. "#EC NOTEXT
  constants CO_LAYOFUNC_SAVE_DEFAULT type N1GUI_LAYOUT_FUNCTION value 8. "#EC NOTEXT
  constants CO_LAYOFUNC_SAVE_USERSPECIFIC type N1GUI_LAYOUT_FUNCTION value 4. "#EC NOTEXT
  constants CO_RELID_LAYOUT type INDX_RELID value 'GL'. "#EC NOTEXT

  class-methods LOAD
    importing
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME
      !I_USERNAME type USERNAME default SY-UNAME
      !I_INTERNAL_KEY type N1GUILAYOINTKEY optional
    returning
      value(RR_LAYOUT) type ref to CL_ISH_GUI_LAYOUT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
    preferred parameter I_ELEMENT_NAME .
  methods GET_COPY
    returning
      value(RR_COPY) type ref to CL_ISH_GUI_LAYOUT
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_LAYOUT_NAME
    returning
      value(R_LAYOUT_NAME) type N1GUI_LAYOUT_NAME .
  interface IF_ISH_GUI_VIEW load .
  methods NEW_CONFIG_CTR
    importing
      !I_CTRNAME type N1GUI_ELEMENT_NAME default CO_DEF_CONFIG_CTRNAME
      !I_VIEWNAME type N1GUI_ELEMENT_NAME
      !IR_PARENT_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !I_VCODE type ISH_VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
      !IR_LAYOUT type ref to CL_ISH_GUI_DYNPRO_LAYOUT optional
      !IT_LAYOUT_VCODE type ISH_T_GUI_DYNPLAY_VCODE_H optional
    returning
      value(RR_CONFIG_CTR) type ref to IF_ISH_GUI_CONTROLLER
    raising
      CX_ISH_STATIC_HANDLER .
  methods SAVE
    importing
      !I_USERNAME type USERNAME default SY-UNAME
      !I_INTERNAL_KEY type N1GUILAYOINTKEY optional
      !I_ERDAT type RI_ERDAT default SY-DATUM
      !I_ERTIM type RI_ERTIM default SY-UZEIT
      !I_ERUSR type RI_ERNAM default SY-UNAME
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods WAS_LOADED
    returning
      value(R_WAS_LOADED) type ABAP_BOOL .
  methods __GET_LAYOUT_ELEMID
  final
    returning
      value(R_LAYOUT_ELEMID) type N1GUI_ELEMENT_ID .
  methods __GET_LAYOUT_ELEMNAME
  final
    returning
      value(R_LAYOUT_ELEMNAME) type N1GUI_ELEMENT_NAME .
protected section.
*"* protected components of class CL_ISH_GUI_LAYOUT
*"* do not include other source files here!!!

  type-pools ABAP .
  data G_WAS_LOADED type ABAP_BOOL .

  methods _GET_CB_STRUCTURE_MODEL
    returning
      value(RR_CB_STRUCTURE_MODEL) type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL .
  methods _GET_DATAREF_BY_FIELDNAME
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(RR_DATA) type ref to DATA .
  methods _GET_RELID
    returning
      value(R_RELID) type INDX_RELID .
  methods _GET_T_DATAREF
    returning
      value(RT_DATAREF) type ISH_T_DATAREF .
private section.
*"* private components of class CL_ISH_GUI_LAYOUT
*"* do not include other source files here!!!

  data G_LAYOUT_ELEMID type N1GUI_ELEMENT_ID .
  data G_LAYOUT_ELEMNAME type N1GUI_ELEMENT_NAME .
  data G_LAYOUT_NAME type N1GUI_LAYOUT_NAME .
ENDCLASS.



CLASS CL_ISH_GUI_LAYOUT IMPLEMENTATION.


METHOD constructor.

  super->constructor( i_element_name = i_element_name ).

  IF i_layout_name IS INITIAL.
    g_layout_name = i_element_name.
  ELSE.
    g_layout_name = i_layout_name.
  ENDIF.

  g_layout_elemname     = get_element_name( ).
  g_layout_elemid       = get_element_id( ).

ENDMETHOD.


METHOD get_copy.

  DATA l_xmlstring            TYPE string.
  DATA lx_root                TYPE REF TO cx_root.

* Serialize the layout.
  TRY.
      CALL TRANSFORMATION id
        SOURCE obj = me
        RESULT XML l_xmlstring.
    CATCH cx_root INTO lx_root.                          "#EC CATCH_ALL
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

* Deserialize the layout.
  TRY.
      CALL TRANSFORMATION id
        SOURCE XML l_xmlstring
        RESULT obj = rr_copy.
    CATCH cx_root INTO lx_root.                          "#EC CATCH_ALL
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

ENDMETHOD.


METHOD get_layout_name.

  r_layout_name = g_layout_name.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA l_element_id           TYPE n1gui_element_id.
  DATA l_element_name         TYPE n1gui_element_name.
  DATA lr_data                TYPE REF TO data.
  DATA l_rc                   TYPE ish_method_rc.

  FIELD-SYMBOLS <ls_data>     TYPE data.

* Get the field content.
  CASE i_fieldname.
    WHEN co_fieldname_element_id.
      l_element_id = get_element_id( ).
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source = l_element_id
        IMPORTING
          e_rc     = l_rc
        CHANGING
          c_target = c_content.
    WHEN co_fieldname_element_name.
      l_element_name = get_element_name( ).
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source = l_element_name
        IMPORTING
          e_rc     = l_rc
        CHANGING
          c_target = c_content.
    WHEN co_fieldname_layout_name.
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source = g_layout_name
        IMPORTING
          e_rc     = l_rc
        CHANGING
          c_target = c_content.
    WHEN co_fieldname_was_loaded.
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source = g_was_loaded
        IMPORTING
          e_rc     = l_rc
        CHANGING
          c_target = c_content.
    WHEN OTHERS.
      l_rc = 1.
      DO 1 TIMES.
        lr_data = _get_dataref_by_fieldname( i_fieldname ).
        CHECK lr_data IS BOUND.
        ASSIGN lr_data->* TO <ls_data>.
        CALL METHOD cl_ish_utl_gui_structure_model=>get_field_content
          EXPORTING
            ir_model    = me
            is_data     = <ls_data>
            i_fieldname = i_fieldname
          CHANGING
            c_content   = c_content.
        l_rc = 0.
      ENDDO.
  ENDCASE.

* Errorhandling.
  IF l_rc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_GUI_LAYOUT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  DATA lt_dataref                 TYPE ish_t_dataref.
  DATA lr_data                    TYPE REF TO data.
  DATA lt_supported_fieldname     TYPE ish_t_fieldname.

  FIELD-SYMBOLS <ls_data>         TYPE data.

  lt_dataref = _get_t_dataref( ).
  LOOP AT lt_dataref INTO lr_data.
    ASSIGN lr_data->* TO <ls_data>.
    IF rt_supported_fieldname IS INITIAL.
      rt_supported_fieldname = cl_ish_utl_gui_structure_model=>get_supported_fields(
          is_data = <ls_data> ).
    ELSE.
      lt_supported_fieldname = cl_ish_utl_gui_structure_model=>get_supported_fields(
          is_data = <ls_data> ).
      APPEND LINES OF lt_supported_fieldname TO rt_supported_fieldname.
    ENDIF.
  ENDLOOP.

  INSERT co_fieldname_element_id            INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_element_name          INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_layout_name           INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_was_loaded            INTO TABLE rt_supported_fieldname.

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  DATA lt_supported_fieldname           TYPE ish_t_fieldname.

  lt_supported_fieldname = get_supported_fields( ).

  READ TABLE lt_supported_fieldname FROM i_fieldname TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_supported = abap_true.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  DATA lr_data                      TYPE REF TO data.
  DATA lr_data_copy                 TYPE REF TO data.
  DATA lt_changed_field             TYPE ish_t_fieldname.
  DATA lr_cb                        TYPE REF TO if_ish_gui_cb_structure_model.
  DATA l_rc                         TYPE ish_method_rc.

  FIELD-SYMBOLS <ls_data>           TYPE data.
  FIELD-SYMBOLS <ls_data_copy>      TYPE data.

* Some fields are not allowed to be changed.
  CHECK i_fieldname <> co_fieldname_element_id.
  CHECK i_fieldname <> co_fieldname_element_name.
  CHECK i_fieldname <> co_fieldname_layout_name.
  CHECK i_fieldname <> co_fieldname_was_loaded.

* Process on a data copy.
  lr_data = _get_dataref_by_fieldname( i_fieldname ).
  CHECK lr_data IS BOUND.
  ASSIGN lr_data->* TO <ls_data>.
  CREATE DATA lr_data_copy LIKE <ls_data>.
  ASSIGN lr_data_copy->* TO <ls_data_copy>.
  <ls_data_copy> = <ls_data>.

* Set field content of the data copy.
  lr_cb = _get_cb_structure_model( ).
  CALL METHOD cl_ish_utl_gui_structure_model=>set_field_content
    EXPORTING
      ir_model    = me
      i_fieldname = i_fieldname
      i_content   = i_content
      ir_cb       = lr_cb
    IMPORTING
      e_changed   = r_changed
    CHANGING
      cs_data     = <ls_data_copy>.
  CHECK r_changed = abap_true.

* Set data.
  <ls_data> = <ls_data_copy>.

* Raise event ev_changed.
  INSERT i_fieldname INTO TABLE lt_changed_field.
  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = lt_changed_field.

ENDMETHOD.


METHOD load.

  TYPES:
    BEGIN OF lty_id,
      layout_name     TYPE n1gui_layout_name,
      username        TYPE username,
      internal_key    TYPE n1guilayointkey,
    END OF lty_id.

  DATA ls_id                          TYPE lty_id.
  DATA l_xmlstring                    TYPE string.
  DATA ls_n1guilayout                 TYPE n1guilayout.
  DATA lx_root                        TYPE REF TO cx_root.

* Build the id.
  ls_id-layout_name     = i_layout_name.
  ls_id-username        = i_username.
  ls_id-internal_key    = i_internal_key.

* Load.
  IMPORT obj = l_xmlstring
    FROM DATABASE n1guilayout(gl)
    ID ls_id
    TO ls_n1guilayout.
  CHECK sy-subrc = 0.

* Deserialize the layout.
  TRY.
      CALL TRANSFORMATION id
        SOURCE XML l_xmlstring
        RESULT obj = rr_layout.
    CATCH cx_root INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.
  CHECK rr_layout IS BOUND.

* The layout was loaded.
  rr_layout->g_was_loaded = abap_true.

ENDMETHOD.


METHOD new_config_ctr.

* No configuration view for the base implementation.

ENDMETHOD.


METHOD save.

  TYPES:
    BEGIN OF lty_id,
      layout_name     TYPE n1gui_layout_name,
      username        TYPE username,
      internal_key    TYPE n1guilayointkey,
    END OF lty_id.

  DATA l_xmlstring                      TYPE string.
  DATA ls_id                            TYPE lty_id.
  DATA ls_n1guilayout                   TYPE n1guilayout.
  DATA lx_root                          TYPE REF TO cx_root.

* Serialize.
  TRY.
      CALL TRANSFORMATION id
        SOURCE obj = me
        RESULT XML l_xmlstring.
    CATCH cx_root INTO lx_root.                          "#EC CATCH_ALL
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

* Build the id.
  ls_id-layout_name     = get_layout_name( ).
  ls_id-username        = i_username.
  ls_id-internal_key    = i_internal_key.

* Build ls_n1guilayout.
  ls_n1guilayout-layout_name    = ls_id-layout_name.
  ls_n1guilayout-username       = ls_id-username.
  ls_n1guilayout-internal_key   = ls_id-internal_key.
  ls_n1guilayout-erdat          = i_erdat.
  ls_n1guilayout-ertim          = i_ertim.
  ls_n1guilayout-erusr          = i_erusr.

* Save.
  EXPORT obj = l_xmlstring
    TO DATABASE n1guilayout(gl)
    ID ls_id
    FROM ls_n1guilayout.

ENDMETHOD.


METHOD was_loaded.

  r_was_loaded = g_was_loaded.

ENDMETHOD.


method _GET_CB_STRUCTURE_MODEL.
endmethod.


METHOD _get_dataref_by_fieldname.

  DATA lt_dataref           TYPE ish_t_dataref.
  DATA lr_data              TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>   TYPE data.

  lt_dataref = _get_t_dataref( ).

  LOOP AT lt_dataref INTO lr_data.
    ASSIGN lr_data->* TO <ls_data>.
    CHECK cl_ish_utl_gui_structure_model=>is_field_supported(
        is_data     = <ls_data>
        i_fieldname = i_fieldname ) = abap_true.
    rr_data = lr_data.
    RETURN.
  ENDLOOP.

ENDMETHOD.


METHOD _get_relid.

  r_relid = co_relid_layout.

ENDMETHOD.


method _GET_T_DATAREF.
endmethod.


METHOD __get_layout_elemid.

  r_layout_elemid = g_layout_elemid.

ENDMETHOD.


METHOD __get_layout_elemname.

  r_layout_elemname = g_layout_elemname.

ENDMETHOD.
ENDCLASS.
