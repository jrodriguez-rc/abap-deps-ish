class CL_ISH_UTL_XML definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_UTL_XML
*"* do not include other source files here!!!
  type-pools IXML .
  type-pools SDYDO .

  class-methods CLASS_CONSTRUCTOR .
  class-methods MAP_DOMAIN_VALUE
    importing
      value(I_DOMAIN) type STRING
      value(I_VALUE) type STRING
    exporting
      value(E_TEXT) type STRING
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods DOM_EXTRACT_CPOS
    importing
      value(IT_CPOS) type ISH_T_CHECK_LIST_CORD_CPOS optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_DOCUMENT type ref to IF_IXML_DOCUMENT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_CDOC
    importing
      !IR_RUN_DATA type ref to IF_ISH_OBJECTBASE optional
      !IS_CDOC_FIELD type RN1_CDOC_FIELD
    exporting
      value(ET_CDOC) type ISH_T_CDOC .
  class-methods GET_DOM_ELEMENT
    importing
      value(IS_FIELD) type RN1_FIELD
      value(I_DISPLAY) type ISH_ON_OFF default 'X'
    exporting
      value(ER_ELEMENT) type ref to IF_IXML_ELEMENT .
  class-methods GET_DOM_COMPLEX_ELEMENT
    importing
      value(IT_FIELD) type ISH_T_FIELD
      value(I_DISPLAY) type ISH_ON_OFF default 'X'
      value(I_IS_GROUP) type ISH_ON_OFF default SPACE
      value(I_INDEX) type I default 1
      value(I_COMPNAME) type STRING optional
      value(I_COMPVALUE) type STRING optional
    exporting
      !ER_ELEMENT type ref to IF_IXML_ELEMENT .
protected section.
*"* protected components of class CL_ISH_UTL_XML
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_XML
*"* do not include other source files here!!!

  class-data GR_IXML type ref to IF_IXML .
ENDCLASS.



CLASS CL_ISH_UTL_XML IMPLEMENTATION.


METHOD class_constructor .

* Create object iXML-factory
  CLASS cl_ixml DEFINITION LOAD.

  gr_ixml = cl_ixml=>create( ).

ENDMETHOD.


METHOD dom_extract_cpos .

  DATA: lr_document           TYPE REF TO if_ixml_document,
        lr_element_cordpos    TYPE REF TO if_ixml_element,
        lr_iterator_cordpos   TYPE REF TO if_ixml_node_iterator,
        lr_node_cordpos       TYPE REF TO if_ixml_node,
        lr_attributes         TYPE REF TO if_ixml_named_node_map,
        lr_node_name          TYPE REF TO if_ixml_node,
        l_string_name         TYPE string,
        l_string_value        TYPE string,
        l_found               TYPE c.
  FIELD-SYMBOLS: <ls_cpos>    TYPE rn1_check_list_cord_cpos.

  e_rc = 0.

* No document => no action
  CHECK NOT cr_document IS INITIAL.

* Check/create errorhandler
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Received document to local variable
  lr_document = cr_document.

* Get CORDPOSITIONS element
  CALL METHOD lr_document->find_from_name
    EXPORTING
*    DEPTH     = 0
      name      = 'CORDPOSITIONS'
*    NAMESPACE = ''
    RECEIVING
      rval      = lr_element_cordpos.

  CHECK NOT lr_element_cordpos IS INITIAL.

* Create CORDPOSITIONS iterator
  CALL METHOD lr_element_cordpos->create_iterator
*  EXPORTING
*    DEPTH  = 0
    RECEIVING
      rval   = lr_iterator_cordpos.

* Get first CORDPOSITION node
  lr_node_cordpos = lr_iterator_cordpos->get_next( ).

  WHILE NOT lr_node_cordpos IS INITIAL.
    CLEAR: l_string_name,
           l_string_value.

    IF lr_node_cordpos->get_name( ) EQ 'CORDPOSITION'.
*     Get CORDPOSITION attributes
      lr_attributes = lr_node_cordpos->get_attributes( ).
      IF NOT lr_attributes IS INITIAL.
*       Get/check POSNO attribute
        lr_node_name  = lr_attributes->get_named_item( 'POSNO' ).
        IF NOT lr_node_name IS INITIAL.
          l_string_value = lr_node_name->get_value( ).
          l_found = 'N'.
          LOOP AT it_cpos ASSIGNING <ls_cpos>.
            IF <ls_cpos>-n1vkg-posnr EQ l_string_value.
              l_found = 'Y'.
            ENDIF.
          ENDLOOP.
*         Remove CORDPOSITION node (if not in tab)
          IF l_found = 'N'.
            lr_node_cordpos->remove_node( ).
          ENDIF.
        ENDIF.  "node_name
      ENDIF.  "attributes
    ENDIF.  "CORDPOSITION

*   Get next CORDPOSITION node
    lr_node_cordpos = lr_iterator_cordpos->get_next( ).
  ENDWHILE.

* Return modified document
  cr_document = lr_document.

ENDMETHOD.


METHOD get_cdoc .

  DATA: lt_ddfields        TYPE ddfields,
        ls_cdoc            TYPE rn1_cdoc,
        l_fieldname        TYPE string,
*       RW ID 15022 - BEGIN
        l_objectclas       TYPE cdobjectcl,
        l_objectid         TYPE cdobjectv,
*       RW ID 15022 - END
        l_get_all_fields   TYPE c,
        l_field_supported  TYPE c,
        l_key              TYPE string,
        l_rc               TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_ddfield> TYPE dfies.

  CLEAR: et_cdoc[],
         l_key.

  IF NOT ir_run_data IS INITIAL.
*   Get object key.
    CALL METHOD ir_run_data->if_ish_data_object~get_key_string
      EXPORTING
        i_with_mandt = 'X'
      IMPORTING
        e_key        = l_key.

*   RW ID 15022 - BEGIN
*   Get CDOC object for tabname.
    CALL METHOD ir_run_data->if_ish_data_object~get_cdoc_object
      EXPORTING
        i_tabname    = is_cdoc_field-tabname
      IMPORTING
        e_objectclas = l_objectclas
        e_objectid   = l_objectid.
*   RW ID 15022 - END
  ENDIF.

  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
    EXPORTING
      i_data_name     = is_cdoc_field-tabname
*      IR_OBJECT       =
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = l_rc
*    CHANGING
*      CR_ERRORHANDLER = cr_errorhandler
   .
  CHECK l_rc = 0.
  CHECK NOT lt_ddfields IS INITIAL.

  IF is_cdoc_field-t_fieldname IS INITIAL.
    l_get_all_fields = 'X'.
  ENDIF.

  LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
    CLEAR: ls_cdoc,
           l_field_supported.
    IF NOT l_get_all_fields = 'X'.
      LOOP AT is_cdoc_field-t_fieldname INTO l_fieldname.
        IF <ls_ddfield>-fieldname = l_fieldname.
          l_field_supported = 'X'.
        ENDIF.
      ENDLOOP.
      CHECK l_field_supported = 'X'.
    ENDIF.

    CHECK <ls_ddfield>-logflag = 'X'.
    ls_cdoc-tabname    = <ls_ddfield>-tabname.
    ls_cdoc-fieldname  = <ls_ddfield>-fieldname.
    ls_cdoc-label_text = <ls_ddfield>-scrtext_m.
    ls_cdoc-tab_key    = l_key.
*   RW ID 15022 - BEGIN
    ls_cdoc-objectclas = l_objectclas.
    ls_cdoc-objectid   = l_objectid.
*   RW ID 15022 - END
    APPEND ls_cdoc TO et_cdoc.
  ENDLOOP.

ENDMETHOD.


METHOD get_dom_complex_element.

  DATA: lr_document          TYPE REF TO if_ixml_document,
        lr_element           TYPE REF TO if_ixml_element,
        lr_element_single    TYPE REF TO if_ixml_element,
        lr_element_group     TYPE REF TO if_ixml_element,
        lr_element_header    TYPE REF TO if_ixml_element,
        lr_element_val       TYPE REF TO if_ixml_element,
        lr_element_body      TYPE REF TO if_ixml_element,
        lr_element_row       TYPE REF TO if_ixml_element,
        lr_text              TYPE REF TO if_ixml_text,
        l_rc                 TYPE ish_method_rc,
        ls_field             TYPE rn1_field,
        l_index              TYPE i,
        l_starting_index     TYPE i,
        l_more_entries       TYPE ish_on_off,
        l_string             TYPE string,
        lt_field             TYPE ish_t_field.

  CLEAR: er_element,
         l_more_entries.

  lt_field[] = it_field[].

  CHECK NOT lt_field IS INITIAL.
  CHECK NOT gr_ixml  IS INITIAL.

* Create document object.
  lr_document = gr_ixml->create_document( ).
  CHECK NOT lr_document IS INITIAL.

* Sort fields by index.
  SORT lt_field BY lindex ASCENDING.
  LOOP AT lt_field INTO ls_field.
    l_index = ls_field-lindex.
    IF l_index = 2.
      l_more_entries = 'X'.
      EXIT.
    ENDIF.
  ENDLOOP.

* Get first field.
  READ TABLE lt_field INTO ls_field INDEX 1.
  l_starting_index = ls_field-lindex.

  IF i_is_group = 'X' AND i_index = 1.
*--------------------------------
*   Create complex DOM element.
*--------------------------------
*   Create element COMPELEM.
    lr_element = lr_document->create_element(
                           name = cl_ish_utl_cord=>co_tag_compelem ).
    l_rc = lr_element->set_attribute(
                           name  = cl_ish_utl_cord=>co_attr_name
                           value = i_compname ).
    IF i_compvalue IS NOT INITIAL.
      l_rc = lr_element->set_attribute(
                             name  = cl_ish_utl_cord=>co_attr_value
                             value = i_compvalue ).
    ENDIF.

*   Set attribute "ISGROUP".
    l_string = i_is_group.
    l_rc = lr_element->set_attribute(
                           name  = cl_ish_utl_cord=>co_attr_isgroup
                           value = l_string ).
*   Set attribute "DISPLAY".
    l_string = i_display.
    l_rc = lr_element->set_attribute(
                           name  = cl_ish_utl_cord=>co_attr_display
                           value = l_string ).

*   Create group element.
    lr_element_group = lr_document->create_element(
                          name = cl_ish_utl_cord=>co_tag_elementgroup ).

*   Create header element.
    lr_element_header = lr_document->create_element(
                         name = cl_ish_utl_cord=>co_tag_elementheader ).

*   Build header components.
    l_index = 0.
    LOOP AT lt_field INTO ls_field WHERE lindex = l_starting_index.
*     Compute index.
      l_index = l_index + 1.
*     Create value element.
      lr_element_val = lr_document->create_element(
                          name = cl_ish_utl_cord=>co_tag_elementval ).

*     Set attribute "XID".
      l_string = l_index.
      l_rc = lr_element_val->set_attribute(
                               name  = cl_ish_utl_cord=>co_attr_xid
                               value = l_string ).
*     Set attribute "DISPLAY".
      l_string = ls_field-display.
      l_rc = lr_element_val->set_attribute(
                               name  = cl_ish_utl_cord=>co_attr_display
                               value = l_string ).
*     Create text element.
      lr_text = lr_document->create_text( ls_field-fieldlabel ).
*     Append text element to value element.
      l_rc = lr_element_val->append_child( lr_text ).
*     Append value element to header element.
      l_rc = lr_element_header->append_child( lr_element_val ).
    ENDLOOP.

*   Append header element to group element.
    l_rc = lr_element_group->append_child( lr_element_header ).

*   Create body element.
    lr_element_body = lr_document->create_element(
                         name  = cl_ish_utl_cord=>co_tag_elementbody ).

*   Are there more entries?
    IF l_more_entries = 'X'.
      DO.
*       Create row element.
        lr_element_row = lr_document->create_element(
                           name  = cl_ish_utl_cord=>co_tag_elementrow ).
*       Set attribute "RID".
        l_string = l_starting_index.
        l_rc = lr_element_row->set_attribute(
                                   name  = cl_ish_utl_cord=>co_attr_rid
                                   value = l_string ).
*       Initialize index.
        l_index = 0.
*       Loop fields.
        LOOP AT lt_field INTO ls_field WHERE lindex = l_starting_index.
*         Comput index.
          l_index = l_index + 1.
*         Create value element.
          lr_element_val = lr_document->create_element(
                           name  = cl_ish_utl_cord=>co_tag_elementval ).
*         Set attribute "XID".
          l_string = l_index.
          l_rc = lr_element_val->set_attribute(
                                   name  = cl_ish_utl_cord=>co_attr_xid
                                   value = l_string ).
*         Set attribute "DISPLAY".
          l_string = ls_field-display.
          l_rc = lr_element_val->set_attribute(
                                name  = cl_ish_utl_cord=>co_attr_display
                                value = l_string ).
*         Set attribute "NAME".
          l_rc = lr_element_val->set_attribute(
                                   name  = cl_ish_utl_cord=>co_attr_name
                                   value = ls_field-fieldname ).
*         Set attribute "VALUE".
          l_rc = lr_element_val->set_attribute(
                               name  = cl_ish_utl_cord=>co_attr_value
                               value = ls_field-fieldvalue ).
*         Create text element.
          lr_text = lr_document->create_text( ls_field-fieldprint ).
*         Append text element to value element.
          l_rc = lr_element_val->append_child( lr_text ).
*         Append value element to row element.
          l_rc = lr_element_row->append_child( lr_element_val ).
        ENDLOOP.
        IF sy-subrc <> 0.
          EXIT.
        ELSE.
          l_starting_index = l_starting_index + 1.
*         Append row element to body element.
          l_rc = lr_element_body->append_child( lr_element_row ).
        ENDIF.
      ENDDO.

    ELSE.
*     Create row element.
      lr_element_row = lr_document->create_element(
                          name = cl_ish_utl_cord=>co_tag_elementrow ).
*     Set attribute "RID".
      l_string = i_index.
      l_rc = lr_element_row->set_attribute(
                                 name  = cl_ish_utl_cord=>co_attr_rid
                                 value = l_string ).

*     Initialize index.
      l_index = 0.

*     Loop fields.
      LOOP AT lt_field INTO ls_field.
*       Compute index.
        l_index = l_index + 1.
*       Create value element.
        lr_element_val = lr_document->create_element(
                            name = cl_ish_utl_cord=>co_tag_elementval ).
*       Set attribute "XID".
        l_string = l_index.
        l_rc = lr_element_val->set_attribute(
                                   name  = cl_ish_utl_cord=>co_attr_xid
                                   value = l_string ).
*       Set attribute "DISPLAY".
        l_string = ls_field-display.
        l_rc = lr_element_val->set_attribute(
                               name  = cl_ish_utl_cord=>co_attr_display
                               value = l_string ).
*       Set attribute "NAME".
        l_rc = lr_element_val->set_attribute(
                               name  = cl_ish_utl_cord=>co_attr_name
                               value = ls_field-fieldname ).
*       Set attribute "VALUE".
        l_rc = lr_element_val->set_attribute(
                               name  = cl_ish_utl_cord=>co_attr_value
                               value = ls_field-fieldvalue ).
*       Create text element.
        lr_text = lr_document->create_text( ls_field-fieldprint ).
*       Append text element to value element.
        l_rc = lr_element_val->append_child( lr_text ).
*       Append value element to row element.
        l_rc = lr_element_row->append_child( lr_element_val ).
      ENDLOOP.

*     Append row element to body element.
      l_rc = lr_element_body->append_child( lr_element_row ).
    ENDIF.  "l_more_entries = 'X'.

*   Append body element to group element.
    l_rc = lr_element_group->append_child( lr_element_body ).

*   Append group element to element COMPELEM.
    l_rc = lr_element->append_child( lr_element_group ).

  ELSEIF i_is_group = 'X'.
*--------------------------------
*   Build one single ROW Entry.
*--------------------------------
*   Create row element.
    lr_element = lr_document->create_element(
                        name = cl_ish_utl_cord=>co_tag_elementrow ).
*   Set attribute "RID".
    l_string = i_index.
    l_rc = lr_element->set_attribute(
                           name  = cl_ish_utl_cord=>co_attr_rid
                           value = l_string ).
*   Initialize index.
    l_index = 0.
*   Loop fields.
    LOOP AT lt_field INTO ls_field.
*     Compute index.
      l_index = l_index + 1.
*     Create value element.
      lr_element_val = lr_document->create_element(
                          name = cl_ish_utl_cord=>co_tag_elementval ).
*     Set attribute "XID".
      l_string = l_index.
      l_rc = lr_element_val->set_attribute(
                               name  = cl_ish_utl_cord=>co_attr_xid
                               value = l_string ).
*     Set attribute "DISPLAY".
      l_string = ls_field-display.
      l_rc = lr_element_val->set_attribute(
                               name  = cl_ish_utl_cord=>co_attr_display
                               value = l_string ).
*     Set attribute "NAME".
      l_rc = lr_element_val->set_attribute(
                               name  = cl_ish_utl_cord=>co_attr_name
                               value = ls_field-fieldname ).
*     Set attribute "VALUE".
      l_rc = lr_element_val->set_attribute(
                               name  = cl_ish_utl_cord=>co_attr_value
                               value = ls_field-fieldvalue ).
*     Create text element.
      lr_text = lr_document->create_text( ls_field-fieldprint ).
*     Append text element to value element.
      l_rc = lr_element_val->append_child( lr_text ).
*     Append value element to row element.
      l_rc = lr_element->append_child( lr_element_val ).
    ENDLOOP.

  ELSE.
*-----------------------------------
*   Build an ordinary single node.
*-----------------------------------
    READ TABLE lt_field INTO ls_field INDEX 1.
    IF sy-subrc = 0.
      CALL METHOD cl_ish_utl_xml=>get_dom_element
        EXPORTING
          is_field   = ls_field
          i_display  = ls_field-display
        IMPORTING
          er_element = lr_element.
    ENDIF.
  ENDIF.

* Export element.
  er_element = lr_element.

ENDMETHOD.


METHOD get_dom_element .

  DATA: lr_document          TYPE REF TO if_ixml_document,
        lr_element           TYPE REF TO if_ixml_element,
        lr_element_tag       TYPE REF TO if_ixml_element,
        lr_element_val       TYPE REF TO if_ixml_element,
        lr_text              TYPE REF TO if_ixml_text,
        lt_fields_value      TYPE ish_t_screen_fields,
        ls_fields_value      LIKE LINE OF lt_fields_value,
        l_string             TYPE string,
        l_string1            TYPE string,
        l_string2            TYPE string,
        l_string3            TYPE string,
        l_rc                 TYPE ish_method_rc.
  DATA: lr_element_comp      TYPE REF TO if_ixml_element.

  CLEAR er_element.

  CHECK NOT is_field IS INITIAL.
  CHECK NOT gr_ixml  IS INITIAL.

* Create DOM document
  lr_document = gr_ixml->create_document( ).
  CHECK NOT lr_document IS INITIAL.

*--------------------------------------------------------------
*   The created ELEMENT representing one field
*   looks like the following sample =>
*
*       <COMPELEMENT ROWID="1" COLID="1" NAME="email">
*          <ELEMENTTAG>Email</ELEMENTTAG>
*          <ELEMENTVAL>my.email@data.com</ELEMENTVAL>
*       </COMPELEMENT>
*--------------------------------------------------------------

* Create element COMPELEM.
  lr_element = lr_document->create_element( name = 'COMPELEM' ).
* Set attribute "NAME".
  l_rc = lr_element->set_attribute( name  = 'NAME'
                                    value = is_field-fieldlabel ).
* Set attribute "ISGROUP".
  l_rc = lr_element->set_attribute( name  = 'ISGROUP'
                                    value = '' ).
* Set attribute "DISPLAY".
  l_string = is_field-display.
  l_rc = lr_element->set_attribute( name  = 'DISPLAY'
                                    value = l_string ).

* Create element COMPELEMENT.
  lr_element_comp =
             lr_document->create_element( name = 'COMPELEMENT' ).
* Set attribute "NAME".
  l_rc = lr_element_comp->set_attribute( name  = 'NAME'
                                         value = is_field-fieldname ).
* Set attribute "DISPLAY".
  l_rc = lr_element_comp->set_attribute( name  = 'DISPLAY'
                                         value = l_string ).

* Create element ELEMENTTAG.
  lr_element_tag = lr_document->create_element( name = 'ELEMENTTAG' ).

* Create text element.
  lr_text = lr_document->create_text( is_field-fieldlabel ).
* Append text element to element ELEMENTTAG.
  l_rc = lr_element_tag->append_child( lr_text ).

* Append element ELEMENTTAG to element COMPELEMENT.
  l_rc = lr_element_comp->append_child( lr_element_tag ).

* Create element ELEMENTVAL.
  lr_element_val = lr_document->create_element( name = 'ELEMENTVAL' ).
* Set attribute "VALUE".
  l_rc = lr_element_val->set_attribute( name  = 'VALUE'
                                        value = is_field-fieldvalue ).
* Create text element.
  lr_text = lr_document->create_text( is_field-fieldprint ).
* Append text element to element ELEMENTVAL.
  l_rc = lr_element_val->append_child( lr_text ).

* Append element ELEMENTVAL to element COMPELEMENT.
  l_rc = lr_element_comp->append_child( lr_element_val ).

* Append element COMPELEMENT to element COMPELEM.
  l_rc = lr_element->append_child( lr_element_comp ).

* Export.
  er_element = lr_element.

ENDMETHOD.


METHOD map_domain_value .

  DATA:          l_domain     TYPE dd07l-domname,
                 lt_dd07v     TYPE TABLE OF dd07v.
  FIELD-SYMBOLS: <ls_dd07v>   TYPE dd07v.

  e_rc = 0.

* No domain => no action
  CHECK NOT i_domain IS INITIAL.

  l_domain = i_domain.

* Check/create errorhandler
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Default
  e_text = i_value.

* Get domain values
  CALL FUNCTION 'GET_DOMAIN_VALUES'
    EXPORTING
      domname         = l_domain
    TABLES
      values_tab      = lt_dd07v
    EXCEPTIONS
      no_values_found = 1
      OTHERS          = 2.

  CHECK sy-subrc = 0.

* Map value to text
  LOOP AT lt_dd07v ASSIGNING <ls_dd07v>.
    CHECK i_value EQ <ls_dd07v>-domvalue_l.
    e_text = <ls_dd07v>-ddtext.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
