class CL_ISH_COMP_COMMENT definition
  public
  inheriting from CL_ISH_COMPONENT_STD
  create public .

public section.

  constants CO_CLASSID type N1COMPCLASSID value 'CL_ISH_COMP_COMMENT'. "#EC NOTEXT
  constants CO_OTYPE_COMP_COMMENT type ISH_OBJECT_TYPE value 8008. "#EC NOTEXT

  methods CONSTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .

  methods IF_ISH_COMPONENT~CANCEL
    redefinition .
  methods IF_ISH_COMPONENT~IS_EMPTY
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMP_COMMENT
*"* do not include other source files here!!!

  data GR_SCR_COMMENT type ref to CL_ISH_SCR_COMMENT .
  class-data GT_CDOC_FIELD type ISH_T_CDOC_FIELD .
  class-data GT_PRINT_FIELD type ISH_T_PRINT_FIELD .

  methods GET_DOM_FOR_RUN_DATA
    redefinition .
  methods INITIALIZE_METHODS
    redefinition .
  methods INITIALIZE_SCREENS
    redefinition .
  methods PREALLOC_FROM_EXTERNAL_INT
    redefinition .
private section.
*"* private components of class CL_ISH_COMP_COMMENT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMP_COMMENT IMPLEMENTATION.


METHOD class_constructor .

  DATA: l_cdoc_field  TYPE rn1_cdoc_field,
        l_print_field TYPE rn1_print_field,
        l_fieldname   TYPE string,
        lt_fieldname  TYPE ish_t_string.

  CLEAR: gt_cdoc_field[],
         gt_print_field[].


* Build table for cdoc.

* N1CORDER
  CLEAR: l_cdoc_field,
         lt_fieldname[].
  l_cdoc_field-objecttype  = cl_ish_corder=>co_otype_corder.
  l_cdoc_field-tabname     = 'N1CORDER'.

  l_fieldname              = 'RMCORD'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.


* Build table for print.

* N1CORDER
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  = cl_ish_corder=>co_otype_corder.
  l_print_field-tabname     = 'N1CORDER'.

  l_fieldname              = 'RMCORD'.
  APPEND l_fieldname TO lt_fieldname.

  l_print_field-t_fieldname = lt_fieldname.
  APPEND l_print_field TO gt_print_field.

ENDMETHOD.


METHOD constructor .

* Construct super class(es).
  CALL METHOD super->constructor.

* Set gr_t_cdoc_field.
  GET REFERENCE OF gt_cdoc_field INTO gr_t_cdoc_field.

* Set gr_t_print_field.
  GET REFERENCE OF gt_print_field INTO gr_t_print_field.

ENDMETHOD.


METHOD get_dom_for_run_data.

  DATA: lr_document_fragment TYPE REF TO if_ixml_document_fragment,
        lr_element           TYPE REF TO if_ixml_element,
        lr_text              TYPE REF TO if_ixml_text,
        lr_fragment          TYPE REF TO if_ixml_document_fragment,
        l_objecttype         TYPE i.
  DATA: lr_corder          TYPE REF TO cl_ish_corder,
        lt_ddfields        TYPE ddfields,
        ls_cdoc            TYPE rn1_cdoc,
        l_fieldname        TYPE string,
        l_get_all_fields   TYPE c,
        l_field_supported  TYPE c,
        l_field_value      TYPE string,
        ls_field           TYPE rn1_field,
        l_key              TYPE string,
        ls_n1corder        TYPE n1corder,
        lt_tline           TYPE ish_t_textmodule_tline,
        ls_tline           TYPE tline,
        l_text_value       TYPE string,
        l_text_print       TYPE string,
        l_rc               TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_ddfield> TYPE dfies.

  FIELD-SYMBOLS: <lt_print_field> TYPE ish_t_print_field,
                 <ls_print_field> TYPE rn1_print_field.

  DATA: lt_fields          TYPE ish_t_field,
        l_string           TYPE string,
        l_index            TYPE i.

  DATA: lt_text TYPE STANDARD TABLE OF text132,   "MED-60716 AGujev
        ls_text TYPE text132.                      "MED-60716 AGujev

* Init.
  CLEAR: er_document_fragment,
         ls_n1corder,
         lt_tline,
         ls_tline,
         l_text_value,
         l_text_print,
         l_rc.

  CHECK NOT ir_document IS INITIAL.
  CHECK NOT ir_run_data IS INITIAL.

  CHECK ir_run_data->is_inherited_from(
                   cl_ish_corder=>co_otype_corder ) = on.

  lr_corder ?= ir_run_data.

  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder    = ls_n1corder
      e_rc           = l_rc
*    CHANGING
*     C_ERRORHANDLER =
      .

  CHECK l_rc = 0.

  IF ls_n1corder-rmltx = 'X'.
*   Get long text.
    CALL METHOD lr_corder->get_text
      EXPORTING
        i_only_read_db = off
        i_text_id      = cl_ish_corder=>co_text_rmcord
      IMPORTING
        e_rc           = l_rc
        et_tline       = lt_tline.
*-->begin of MED-60716 AGujev
*-- convert text to external format
    CALL FUNCTION 'CONVERT_ITF_TO_STREAM_TEXT'
      EXPORTING
        language    = sy-langu
      TABLES
        itf_text    = lt_tline
        text_stream = lt_text.
    LOOP AT lt_text INTO ls_text.
      CONCATENATE l_text_value ls_text
             INTO l_text_value
*        SEPARATED BY cl_ish_utl_cord=>co_lgtxt_nline "REM MED-90451
        RESPECTING BLANKS.
      CONCATENATE l_text_print ls_text
             INTO l_text_print
        SEPARATED BY space
        RESPECTING BLANKS.
    ENDLOOP.
    REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf IN l_text_value WITH cl_ish_utl_cord=>co_lgtxt_nline. "MED-90451
    CLEAR lt_text[].
    CONDENSE l_text_print.
*following processing was commented - not converted text was used !
*    LOOP AT lt_tline INTO ls_tline.
*      CONCATENATE l_text_value ls_tline-tdline
*             INTO l_text_value
*        SEPARATED BY cl_ish_utl_cord=>co_lgtxt_nline
*        RESPECTING BLANKS. "MED-57020 Cristina Geanta
*    ENDLOOP.
*    CALL METHOD cl_ish_utl_base_conv=>convert_longtext_to_string
*      EXPORTING
*        it_tline    = lt_tline
*      IMPORTING
*        e_longtext  = l_text_print.
*<--end of MED-60716 AGujev
*-- begin Grill, MED-33270
    DESCRIBE TABLE lt_tline.
    IF sy-tfill < 2.
      l_text_value = l_text_print.
    ENDIF.
*-- end Grill, MED-33270
  ENDIF.

  CHECK gr_t_print_field IS BOUND.
  ASSIGN gr_t_print_field->* TO <lt_print_field>.
  CHECK sy-subrc = 0.

* Create document fragment
  lr_document_fragment = ir_document->create_document_fragment( ).

  LOOP AT <lt_print_field> ASSIGNING <ls_print_field>.
*   Check data object's type.
    l_objecttype = <ls_print_field>-objecttype.
    CHECK ir_run_data->is_inherited_from( l_objecttype ) = on.

    CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
      EXPORTING
        i_data_name     = <ls_print_field>-tabname
*       IR_OBJECT   =
      IMPORTING
        et_ddfields     = lt_ddfields
        e_rc            = l_rc
*    CHANGING
*       CR_ERRORHANDLER = cr_errorhandler
     .
    CHECK l_rc = 0.
    CHECK NOT lt_ddfields IS INITIAL.

    IF <ls_print_field>-t_fieldname IS INITIAL.
      l_get_all_fields = 'X'.
    ENDIF.

    LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
      CLEAR: l_field_supported.
      IF NOT l_get_all_fields = 'X'.
        LOOP AT <ls_print_field>-t_fieldname INTO l_fieldname.
          IF <ls_ddfield>-fieldname = l_fieldname.
            l_field_supported = 'X'.
          ENDIF.
        ENDLOOP.
        CHECK l_field_supported = 'X'.
      ENDIF.
*     Get field value.
      CALL METHOD ir_run_data->get_data_field
        EXPORTING
*         I_FILL      = OFF
          i_fieldname = <ls_ddfield>-fieldname
        IMPORTING
*         E_RC        =
          e_field     = l_field_value
*         E_FLD_NOT_FOUND =
*        CHANGING
*         C_ERRORHANDLER  =
          .

*     Set text.
      IF <ls_ddfield>-fieldname = 'RMCORD'.
        IF NOT l_text_value IS INITIAL.
          l_field_value = l_text_value.
        ENDIF.
      ENDIF.

*     Get field as DOM element.
      CLEAR ls_field.
      ls_field-tabname    = <ls_print_field>-tabname.
      ls_field-fieldname  = <ls_ddfield>-fieldname.
      ls_field-fieldlabel = <ls_ddfield>-scrtext_m.
      ls_field-fieldvalue = l_field_value.
      ls_field-fieldprint = l_field_value.
      IF <ls_ddfield>-fieldname = 'RMCORD'.
        IF NOT l_text_print IS INITIAL.
          ls_field-fieldprint = l_text_print.
        ENDIF.
      ENDIF.
      ls_field-display    = on.
      APPEND ls_field TO lt_fields.
    ENDLOOP.
    EXIT.
  ENDLOOP.

* Get component element.
  CLEAR l_string.
  CALL METHOD cl_ish_utl_xml=>get_dom_complex_element
    EXPORTING
      it_field   = lt_fields
      i_display  = on
      i_is_group = off
      i_index    = l_index
      i_compname = l_string
    IMPORTING
      er_element = lr_element.
* Append component element to component DOM fragment
  l_rc = lr_document_fragment->append_child(
                                      new_child = lr_element ).

* Modify DOM fragment
  CALL METHOD modify_dom_data
    IMPORTING
      e_rc                 = l_rc
    CHANGING
*     cr_errorhandler      = cr_errorhandler
      cr_document_fragment = lr_document_fragment.

* Export DOM fragment
  er_document_fragment = lr_document_fragment.

ENDMETHOD.


METHOD if_ish_component~cancel.

* Michael Manoch, 13.07.2004, ID 14907
* New method.

  DATA: lr_corder      TYPE REF TO cl_ish_corder,
        l_cancelled    TYPE ish_on_off.

* Do not process in check-only mode.
  CHECK i_check_only = off.

* Get the corder object.
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
  lr_corder ?= gr_main_object.

* Do not process cancelled corder objects.
  CALL METHOD lr_corder->is_cancelled
    IMPORTING
      e_cancelled = l_cancelled.
  CHECK l_cancelled = off.

* Clear the component's data from the corder.

  "GT: MED-60728 - Start undo coments
*Begin of MED-49550 - ChicherneaA
* Clear the corder comment.
  CALL METHOD lr_corder->change_text
    EXPORTING
      i_text_id      = cl_ish_corder=>co_text_rmcord
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
*End of MED-49550 - ChicherneaA
  "GT: MED-60728 - END

*MED-48850,Am,we need to free the subscreen controls
  IF gr_scr_comment IS NOT INITIAL.
      gr_scr_comment->free_controls( ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_component~is_empty.

* Michael Manoch, 13.07.2004, ID 14907
* New method.

  DATA: lr_corder   TYPE REF TO cl_ish_corder,
        ls_n1corder TYPE n1corder,
        l_rc        TYPE ish_method_rc.

* Call super method.
  r_empty = super->if_ish_component~is_empty( ).

* Further processing only if super method returns ON.
  CHECK r_empty = on.

* Check the corder fields.
  r_empty = off.

* Get corder object.
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
            cl_ish_corder=>co_otype_corder ) = on.
  lr_corder ?= gr_main_object.

* Get corder data.
  CALL METHOD lr_corder->get_data
    IMPORTING
      e_rc        = l_rc
      es_n1corder = ls_n1corder.
* On error -> self is not empty.
  CHECK l_rc = 0.

* If one of the component fields is not empty -> self is not empty.
  CHECK ls_n1corder-rmcord IS INITIAL.
  CHECK ls_n1corder-rmltx  IS INITIAL.

* Self is empty.
  r_empty = on.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_comp_comment.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_comp_comment.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD INITIALIZE_METHODS .

* initialize methods

ENDMETHOD.


METHOD initialize_screens.

* create screen objects.
* screen insurance
  CALL METHOD cl_ish_scr_comment=>create
    IMPORTING
      er_instance     = gr_scr_comment
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* Save all used screen object in gt_screen_objects.
  APPEND gr_scr_comment TO gt_screen_objects.

ENDMETHOD.


METHOD prealloc_from_external_int.

* ED, ID 16882 -> BEGIN
  DATA: lt_ddfields       TYPE ddfields,
        l_rc              TYPE ish_method_rc,
        lr_corder         TYPE REF TO cl_ish_corder,
        ls_corder_x       TYPE rn1_corder_x,
        l_field_supported TYPE c,
        l_value           TYPE nfvvalue,
        lt_con_obj        TYPE ish_objectlist,
        ls_object         TYPE ish_object,
        l_fname           TYPE string,
        l_compid          TYPE n1comp-compid,
        l_index           TYPE i,
        lt_line           TYPE ish_t_textmodule_tline,
        l_longtext        TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_ddfield> TYPE dfies,
                 <ls_mapping> TYPE ishmed_migtyp_l,
                 <fst>        TYPE ANY.

  e_rc = 0.

* get clinical order
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
  lr_corder ?= gr_main_object.

* fill lt_con_obj with corder
  ls_object-object ?= lr_corder.
  APPEND ls_object TO lt_con_obj.

* get compid
  CALL METHOD me->get_compid
    RECEIVING
      r_compid = l_compid.

  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
    EXPORTING
      i_data_name     = 'RN1_CORDER_X'
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* only data which refer to the corder object are relevant *******
  LOOP AT it_mapping ASSIGNING <ls_mapping>
      WHERE instno = 0
        AND compid = l_compid.
    LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
      CLEAR: l_field_supported.
      CHECK <ls_mapping>-fieldname = <ls_ddfield>-fieldname.
      l_field_supported = 'X'.
      CHECK l_field_supported = 'X'.
*     fill changing structure
      CONCATENATE 'LS_CORDER_X-' <ls_mapping>-fieldname INTO l_fname.
      ASSIGN (l_fname) TO <fst>.
      <fst> = <ls_mapping>-fvalue.
*     set x-flag to on.
      CONCATENATE 'ls_corder_x-' <ls_mapping>-fieldname '_x' INTO
      l_fname.
      ASSIGN (l_fname) TO <fst>.
      <fst> = on.
*     xxxxx longtext RMCORD xxxxx
      IF <ls_mapping>-fieldname = 'RMCORD'.
        CLEAR: lt_line[], l_longtext.
*       call method CONVERT_STRING_TO_LONGTEXT
        CALL METHOD cl_ish_utl_base_conv=>convert_string_to_longtext
          EXPORTING
            i_string         = <ls_mapping>-fvalue
            i_length         = 50
            i_seperator_sign = cl_ish_utl_cord=>co_lgtxt_nline
          IMPORTING
            et_tline         = lt_line
            e_rc             = l_rc
            e_is_longtext    = l_longtext
          CHANGING
            cr_errorhandler  = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
        IF NOT lt_line[] IS INITIAL AND l_longtext = on.
          ls_corder_x-rmltx = on.
          ls_corder_x-rmltx_x = on.
          CALL METHOD lr_corder->change_text
            EXPORTING
              i_text_id      = cl_ish_corder=>co_text_rmcord
              it_tline       = lt_line
              i_tline_x      = on
            IMPORTING
              e_rc           = l_rc
            CHANGING
              c_errorhandler = cr_errorhandler.
          IF l_rc <> 0.
            e_rc = l_rc.
            EXIT.
          ENDIF.
*         now get the new first textline
          CALL METHOD lr_corder->get_text_header
            EXPORTING
              i_text_id      = cl_ish_corder=>co_text_rmcord
            IMPORTING
              e_textline     = ls_corder_x-rmcord
              e_rc           = l_rc
            CHANGING
              c_errorhandler = cr_errorhandler.
          ls_corder_x-rmcord_x = on.
          IF l_rc <> 0.
            e_rc = l_rc.
            EXIT.
          ENDIF.
        ENDIF. "IF NOT lt_line[] IS INITIAL.
      ENDIF.
    ENDLOOP. "LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
    CHECK e_rc = 0.
  ENDLOOP. "LOOP AT it_mapping ASSIGNING <ls_mapping>

* only go on if no error
  CHECK e_rc = 0.

* Change corder data.
  CHECK NOT ls_corder_x IS INITIAL.
  CALL METHOD lr_corder->change
    EXPORTING
      is_corder_x     = ls_corder_x
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* ED, ID 16882 -> END

ENDMETHOD.
ENDCLASS.
