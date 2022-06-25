class CL_ISH_GM_COMPCON definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GM_COMPCON
*"* do not include other source files here!!!

  interfaces IF_SERIALIZABLE_OBJECT .
  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .
  interfaces IF_ISH_GUI_XSTRUCTURE_MODEL .

  aliases GET_DATA
    for IF_ISH_GUI_XSTRUCTURE_MODEL~GET_DATA .
  aliases GET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS .
  aliases IS_FIELD_CHANGEABLE
    for IF_ISH_GUI_XSTRUCTURE_MODEL~IS_FIELD_CHANGEABLE .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases IS_READONLY
    for IF_ISH_GUI_XSTRUCTURE_MODEL~IS_READONLY .
  aliases SET_DATA
    for IF_ISH_GUI_XSTRUCTURE_MODEL~SET_DATA .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .

  class-methods NEW_INSTANCE_BY_COMPCONID
    importing
      !IR_COMPCON type ref to IF_ISH_COMPONENT_CONFIG optional
      !I_COMPCONID type N1COMPCONID
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_COMPCON
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods NEW_INSTANCE_BY_XMLDOC
    importing
      !IR_COMPCON type ref to IF_ISH_COMPONENT_CONFIG
      !IR_XML_DOCUMENT type ref to IF_IXML_DOCUMENT
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_COMPCON
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods NEW_INSTANCE_BY_XMLRAWSTRING
    importing
      !IR_COMPCON type ref to IF_ISH_COMPONENT_CONFIG optional
      !I_XMLRAWSTRING type N1XMLDATA
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_COMPCON
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods NEW_INSTANCE_BY_XMLSTRING
    importing
      !IR_COMPCON type ref to IF_ISH_COMPONENT_CONFIG optional
      !I_XMLSTRING type N1SERIALIZED
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_COMPCON
    raising
      CX_ISH_STATIC_HANDLER .
  methods AS_XMLDOC
    returning
      value(RR_XML_DOCUMENT) type ref to IF_IXML_DOCUMENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods AS_XMLSTRING
    returning
      value(R_XMLSTRING) type N1SERIALIZED
    raising
      CX_ISH_STATIC_HANDLER .
  methods CHECK
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONSTRUCTOR
    importing
      !IR_COMPCON type ref to IF_ISH_COMPONENT_CONFIG optional .
  methods GET_COMPCON
    returning
      value(RR_COMPCON) type ref to IF_ISH_COMPONENT_CONFIG .
  type-pools ABAP .
  methods IS_EQUAL
    importing
      !IR_OTHER type ref to CL_ISH_GM_COMPCON
    returning
      value(R_EQUAL) type ABAP_BOOL .
  methods SET_COMPCON
    importing
      !IR_COMPCON type ref to IF_ISH_COMPONENT_CONFIG
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_DATA_BY_OTHER
    importing
      !IR_OTHER type ref to CL_ISH_GM_COMPCON
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_DATA_BY_XMLDOC
    importing
      !IR_XML_DOCUMENT type ref to IF_IXML_DOCUMENT
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_DATA_BY_XMLRAWSTRING
    importing
      !I_XMLRAWSTRING type N1XMLDATA
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_DATA_BY_XMLSTRING
    importing
      !I_XMLSTRING type N1SERIALIZED
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GM_COMPCON
*"* do not include other source files here!!!

  methods _GET_R_DATA
  abstract
    returning
      value(RR_DATA) type ref to DATA .
  methods _RAISE_EV_CHANGED
    importing
      !I_FIELDNAME type ISH_FIELDNAME optional
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME optional .
  methods _SET_FIELD_CONTENT
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_CONTENT type ANY
      !I_RAISE_EVENT type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_GM_COMPCON
*"* do not include other source files here!!!

  data GR_COMPCON type ref to IF_ISH_COMPONENT_CONFIG .
ENDCLASS.



CLASS CL_ISH_GM_COMPCON IMPLEMENTATION.


METHOD as_xmldoc.

  DATA l_xmlstring              TYPE string.
  DATA lr_xmlworker             TYPE REF TO cl_ishmed_xml_document_base.

  l_xmlstring = as_xmlstring( ).

  CREATE OBJECT lr_xmlworker.
  CHECK lr_xmlworker->parse_string( l_xmlstring ) = 0.

  rr_xml_document = lr_xmlworker->m_document.

ENDMETHOD.


METHOD as_xmlstring.

  DATA lr_messages            TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_root                TYPE REF TO cx_root.

  TRY.
      CALL TRANSFORMATION id
        SOURCE obj = me
        RESULT XML r_xmlstring.
    CATCH cx_root INTO lx_root.                          "#EC CATCH_ALL
      CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
        EXPORTING
          i_exceptions    = lx_root
        CHANGING
          cr_errorhandler = lr_messages.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_messages.
  ENDTRY.

ENDMETHOD.


METHOD check.

  e_rc = 0.

ENDMETHOD.


METHOD constructor.

  gr_compcon = ir_compcon.

ENDMETHOD.


METHOD get_compcon.

  rr_compcon = gr_compcon.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA lr_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>           TYPE data.

  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.
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

  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

  rt_supported_fieldname = cl_ish_utl_gui_structure_model=>get_supported_fields( <ls_data> ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  DATA lt_supported_fieldname           TYPE ish_t_fieldname.

  lt_supported_fieldname = get_supported_fields( ).
  READ TABLE lt_supported_fieldname FROM i_fieldname TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_supported = abap_true.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  CHECK gr_compcon IS BOUND.

  r_changed = _set_field_content(
      i_fieldname   = i_fieldname
      i_content     = i_content
      i_raise_event = abap_true ).

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~get_data.

  DATA lr_structdescr                     TYPE REF TO cl_abap_structdescr.
  DATA lr_data                            TYPE REF TO data.
  DATA l_fieldname                        TYPE ish_fieldname.

  FIELD-SYMBOLS <ls_data>                 TYPE data.
  FIELD-SYMBOLS <ls_component>            TYPE abap_compdescr.
  FIELD-SYMBOLS <l_source_field>          TYPE any.
  FIELD-SYMBOLS <l_target_field>          TYPE any.

* cs_data has to be a structure.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( cs_data ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'GET_DATA'
          i_mv3        = 'CL_ISH_GM_COMPCON' ).
  ENDTRY.

* Get data.
  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

* Take over fields.
  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_data>
      TO <l_source_field>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE cs_data
      TO <l_target_field>.
    CHECK sy-subrc = 0.
    <l_target_field> = <l_source_field>.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~is_field_changeable.

  CHECK is_readonly( ) = abap_false.

  CHECK is_field_supported( i_fieldname ) = abap_true.

  r_changeable = abap_true.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~is_readonly.

  IF gr_compcon IS NOT BOUND.
    r_readonly = abap_true.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~set_data.

  DATA lr_data                            TYPE REF TO data.
  DATA lr_structdescr                     TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname                        TYPE ish_fieldname.
  DATA l_fieldname_x                      TYPE ish_fieldname.
  DATA l_rc                               TYPE ish_method_rc.
  DATA lr_messages                        TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_static                          TYPE REF TO cx_ish_static_handler.

  FIELD-SYMBOLS <ls_data>                 TYPE data.
  FIELD-SYMBOLS <ls_component>            TYPE abap_compdescr.
  FIELD-SYMBOLS <l_source_field>          TYPE any.
  FIELD-SYMBOLS <l_source_field_x>        TYPE any.
  FIELD-SYMBOLS <l_target_field>          TYPE any.

  CHECK gr_compcon IS BOUND.

* cs_data has to be a structure.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( is_data ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'SET_DATA'
          i_mv3        = 'CL_ISH_GM_COMPCON' ).
  ENDTRY.

* Get actual data.
  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.

    l_fieldname = <ls_component>-name.

    IF it_field2change IS NOT INITIAL.
      READ TABLE it_field2change FROM l_fieldname TRANSPORTING NO FIELDS.
      CHECK sy-subrc = 0.
    ENDIF.

    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE is_data
      TO <l_source_field>.
    CHECK sy-subrc = 0.

    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_data>
      TO <l_target_field>.
    CHECK sy-subrc = 0.

    IF i_handle_xfields = abap_true.
      CONCATENATE l_fieldname 'X' INTO l_fieldname_x SEPARATED BY '_'.
      ASSIGN COMPONENT l_fieldname
        OF STRUCTURE is_data
        TO <l_source_field_x>.
      CHECK sy-subrc = 0.
      CHECK <l_source_field_x> = abap_true.
    ENDIF.

    CHECK <l_source_field> <> <l_target_field>.

    IF i_soft = abap_true.
      CHECK is_field_changeable( l_fieldname ) = abap_true.
    ENDIF.

    TRY.
        CHECK _set_field_content(
            i_fieldname   = l_fieldname
            i_content     = <l_source_field>
            i_raise_event = abap_false ) = abap_true.
      CATCH cx_ish_static_handler INTO lx_static.
        l_rc = 1.
        IF lr_messages IS BOUND.
          IF lx_static->gr_errorhandler IS BOUND.
            lr_messages->copy_messages( i_copy_from = lx_static->gr_errorhandler ).
          ENDIF.
        ELSE.
          lr_messages = lx_static->gr_errorhandler.
        ENDIF.
        CONTINUE.
    ENDTRY.

    INSERT l_fieldname INTO TABLE rt_changed_field.

  ENDLOOP.

  _raise_ev_changed( it_changed_field = rt_changed_field ).

  IF l_rc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_messages.
  ENDIF.

ENDMETHOD.


METHOD is_equal.

  DATA lr_data                    TYPE REF TO data.
  data lr_data_other              TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>         TYPE data.
  FIELD-SYMBOLS <ls_data_other>   TYPE data.

  CHECK ir_other IS BOUND.

  CHECK cl_ish_utl_rtti=>get_class_name( ir_other ) = cl_ish_utl_rtti=>get_class_name( me ).

  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

  lr_data_other = ir_other->_get_r_data( ).
  ASSIGN lr_data_other->* TO <ls_data_other>.

  CHECK <ls_data> = <ls_data_other>.

  r_equal = abap_true.

ENDMETHOD.


METHOD new_instance_by_compconid.

  DATA l_xmlrawstring           TYPE n1xmldata.

  IF i_compconid IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'NEW_INSTANCE_BY_COMPCONID'
        i_mv3 = 'CL_ISH_GM_COMPCON' ).
  ENDIF.

  SELECT SINGLE xml_data
    FROM n1compcon
    INTO l_xmlrawstring
    WHERE compconid = i_compconid.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'NEW_INSTANCE_BY_COMPCONID'
        i_mv3 = 'CL_ISH_GM_COMPCON' ).
  ENDIF.

  rr_instance = new_instance_by_xmlrawstring(
      ir_compcon      = ir_compcon
      i_xmlrawstring  = l_xmlrawstring ).

ENDMETHOD.


METHOD new_instance_by_xmldoc.

  DATA l_xmlstring              TYPE string.
  DATA lr_xml_node              TYPE REF TO if_ixml_node.
  DATA lr_xmlworker             TYPE REF TO cl_ishmed_xml_document_base.

  IF ir_xml_document IS NOT BOUND..
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'NEW_INSTANCE_BY_XMLDOC'
        i_mv3 = 'CL_ISH_GM_COMPCON' ).
  ENDIF.

  CREATE OBJECT lr_xmlworker.
  CHECK lr_xmlworker->create_with_dom( ir_xml_document ) = 0.
  lr_xml_node = lr_xmlworker->get_first_node( ).
  CHECK lr_xml_node IS BOUND.
  CALL METHOD lr_xmlworker->render_fragment_2_string
    EXPORTING
      node         = lr_xml_node
      pretty_print = abap_off
    IMPORTING
      stream       = l_xmlstring.

  rr_instance = new_instance_by_xmlstring(
      ir_compcon  = ir_compcon
      i_xmlstring = l_xmlstring ).

ENDMETHOD.


METHOD new_instance_by_xmlrawstring.

  DATA lr_xml_document      TYPE REF TO if_ixml_document.

  IF i_xmlrawstring IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'NEW_INSTANCE_BY_XMLRAWSTRING'
        i_mv3 = 'CL_ISH_GM_COMPCON' ).
  ENDIF.

  CALL FUNCTION 'SDIXML_XML_TO_DOM'
    EXPORTING
      xml      = i_xmlrawstring
    IMPORTING
      document = lr_xml_document
    EXCEPTIONS
      OTHERS   = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '2'
        i_mv2 = 'NEW_INSTANCE_BY_XMLRAWSTRING'
        i_mv3 = 'CL_ISH_GM_COMPCON' ).
  ENDIF.

  rr_instance = new_instance_by_xmldoc(
      ir_compcon      = ir_compcon
      ir_xml_document = lr_xml_document ).

ENDMETHOD.


METHOD new_instance_by_xmlstring.

  DATA lr_other           TYPE REF TO cl_ish_gm_compcon.
  DATA lx_root            TYPE REF TO cx_root.

  IF i_xmlstring IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'NEW_INSTANCE_BY_XMLSTRING'
        i_mv3 = 'CL_ISH_GM_COMPCON' ).
  ENDIF.

  TRY.
      CALL TRANSFORMATION id
        SOURCE XML i_xmlstring
        RESULT obj = rr_instance.
    CATCH cx_root INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

ENDMETHOD.


METHOD set_compcon.

  IF gr_compcon IS BOUND AND
     gr_compcon <> ir_compcon.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_COMPCON'
        i_mv3        = 'CL_ISH_GM_COMPCON' ).
  ENDIF.

  gr_compcon = ir_compcon.

ENDMETHOD.


METHOD set_data_by_other.

  DATA lr_data                    TYPE REF TO data.
  DATA lr_data_other              TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>         TYPE data.
  FIELD-SYMBOLS <ls_data_other>   TYPE data.

  CHECK ir_other IS BOUND.

  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

  lr_data_other = ir_other->_get_r_data( ).
  ASSIGN lr_data_other->* TO <ls_data_other>.

  set_data( is_data = <ls_data_other> ).

ENDMETHOD.


METHOD set_data_by_xmldoc.

  DATA l_xmlstring              TYPE string.
  DATA lr_xml_node              TYPE REF TO if_ixml_node.
  DATA lr_xmlworker             TYPE REF TO cl_ishmed_xml_document_base.

  CHECK ir_xml_document IS BOUND.

  CREATE OBJECT lr_xmlworker.
  CHECK lr_xmlworker->create_with_dom( ir_xml_document ) = 0.
  lr_xml_node = lr_xmlworker->get_first_node( ).
  CHECK lr_xml_node IS BOUND.
  CALL METHOD lr_xmlworker->render_fragment_2_string
    EXPORTING
      node         = lr_xml_node
      pretty_print = abap_off
    IMPORTING
      stream       = l_xmlstring.
  CHECK l_xmlstring IS NOT INITIAL.

  rt_changed_field = set_data_by_xmlstring( i_xmlstring = l_xmlstring ).

ENDMETHOD.


METHOD set_data_by_xmlrawstring.

  DATA lr_xml_document      TYPE REF TO if_ixml_document.

  CHECK i_xmlrawstring IS NOT INITIAL.

  CALL FUNCTION 'SDIXML_XML_TO_DOM'
    EXPORTING
      xml      = i_xmlrawstring
    IMPORTING
      document = lr_xml_document
    EXCEPTIONS
      OTHERS   = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'SET_DATA_BY_XMLRAWSTRING'
        i_mv3 = 'CL_ISH_GM_COMPCON' ).
  ENDIF.

  rt_changed_field = set_data_by_xmldoc( ir_xml_document = lr_xml_document ).

ENDMETHOD.


METHOD set_data_by_xmlstring.

  DATA lr_other           TYPE REF TO cl_ish_gm_compcon.
  DATA lx_root            TYPE REF TO cx_root.

  CHECK i_xmlstring IS NOT INITIAL.

  TRY.
      CALL TRANSFORMATION id
        SOURCE XML i_xmlstring
        RESULT obj = lr_other.
    CATCH cx_root INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.
  CHECK lr_other IS BOUND.

  rt_changed_field = set_data_by_other( ir_other = lr_other ).

ENDMETHOD.


METHOD _raise_ev_changed.

  DATA lt_changed_field           TYPE ish_t_fieldname.

  lt_changed_field = it_changed_field.
  IF i_fieldname IS NOT INITIAL.
    INSERT i_fieldname INTO TABLE lt_changed_field.
  ENDIF.

  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = lt_changed_field.

ENDMETHOD.


METHOD _set_field_content.

  DATA lr_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>           TYPE data.

  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

  CALL METHOD cl_ish_utl_gui_structure_model=>set_field_content
    EXPORTING
      ir_model    = me
      i_fieldname = i_fieldname
      i_content   = i_content
    IMPORTING
      e_changed   = r_changed
    CHANGING
      cs_data     = <ls_data>.

  IF i_raise_event = abap_true AND
     r_changed = abap_true.
    _raise_ev_changed( i_fieldname = i_fieldname ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
