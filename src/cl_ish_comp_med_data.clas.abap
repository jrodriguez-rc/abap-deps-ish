class CL_ISH_COMP_MED_DATA definition
  public
  inheriting from CL_ISH_COMPONENT_STD
  create public .

*"* public components of class CL_ISH_COMP_MED_DATA
*"* do not include other source files here!!!
public section.

  constants CO_CLASSID type N1COMPCLASSID value 'CL_ISH_COMP_MED_DATA'. "#EC NOTEXT
  constants CO_OTYPE_COMP_MED_DATA type ISH_OBJECT_TYPE value 8002. "#EC NOTEXT

  methods CONSTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .
  methods GET_CORDER
    returning
      value(RR_CORDER) type ref to CL_ISH_CORDER .
  methods GET_DIAGNOSIS
    importing
      value(I_CANCELLED_DATAS) type ISH_ON_OFF default OFF
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
    exporting
      value(ET_DIAGNOSIS) type ISH_T_PREREG_DIAGNOSIS
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_COMPONENT~CANCEL
    redefinition .
  methods IF_ISH_COMPONENT~CHECK
    redefinition .
  methods IF_ISH_COMPONENT~CHECK_CHANGES
    redefinition .
  methods IF_ISH_COMPONENT~GET_T_RUN_DATA
    redefinition .
  methods IF_ISH_COMPONENT~GET_T_UID
    redefinition .
  methods IF_ISH_COMPONENT~IS_EMPTY
    redefinition .
  methods IF_ISH_COMPONENT~SAVE
    redefinition .
  methods IF_ISH_COMPONENT~SET_T_UID
    redefinition .
  methods IF_ISH_DOM~MODIFY_DOM_DATA
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMP_MED_DATA
*"* do not include other source files here!!!

  class-data GT_CDOC_FIELD type ISH_T_CDOC_FIELD .
  class-data GT_PRINT_FIELD type ISH_T_PRINT_FIELD .

  methods TRANS_CORDER_FROM_SCR_MED_DATA
    importing
      !IR_CORDER type ref to CL_ISH_CORDER optional
      !IR_SCR_MED_DATA type ref to CL_ISH_SCR_MED_DATA optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_CORDER_TO_SCR_MED_DATA
    importing
      !IR_CORDER type ref to CL_ISH_CORDER optional
      !IR_SCR_MED_DATA type ref to CL_ISH_SCR_MED_DATA optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_FROM_SCR_MED_DATA
    importing
      !IR_SCR_MED_DATA type ref to CL_ISH_SCR_MED_DATA optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_TO_SCR_MED_DATA
    importing
      !IR_SCR_MED_DATA type ref to CL_ISH_SCR_MED_DATA optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_DIAGNOSIS
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      value(I_FIELD_VALUE) type STRING
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods COPY_DATA_INTERNAL
    redefinition .
  methods GET_DOM_FOR_RUN_DATA
    redefinition .
  methods INITIALIZE_METHODS
    redefinition .
  methods INITIALIZE_SCREENS
    redefinition .
  methods PREALLOC_FROM_EXTERNAL_INT
    redefinition .
  methods PREALLOC_INTERNAL
    redefinition .
  methods TRANSPORT_FROM_SCREEN_INTERNAL
    redefinition .
  methods TRANSPORT_TO_SCREEN_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_COMP_MED_DATA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMP_MED_DATA IMPLEMENTATION.


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
  l_cdoc_field-objecttype  = cl_ishmed_corder=>co_otype_corder.
  l_cdoc_field-tabname     = 'N1CORDER'.

  l_fieldname              = 'KANAM'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'SCHWKZ'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'SCHWO'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'IFG'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'FRAGE'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.

* NDIP
  CLEAR: l_cdoc_field,
         lt_fieldname[].
  l_cdoc_field-objecttype  =
cl_ish_prereg_diagnosis=>co_otype_prereg_diagnosis.
  l_cdoc_field-tabname     = 'NDIP'.

  l_fieldname              = 'DIPNO'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'DCAT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'DKEY'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'DLOC'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'STDAT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'DITXT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'DILTX'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.


* Build table for print.

* N1CORDER
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  = cl_ishmed_corder=>co_otype_corder.
  l_print_field-tabname     = 'N1CORDER'.

  l_fieldname              = 'KANAM'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'SCHWKZ'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'SCHWO'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'IFG'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'FRAGE'.
  APPEND l_fieldname TO lt_fieldname.

  l_print_field-t_fieldname = lt_fieldname.
  APPEND l_print_field TO gt_print_field.

* NDIP
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  =
cl_ish_prereg_diagnosis=>co_otype_prereg_diagnosis.
  l_print_field-tabname     = 'NDIP'.

  l_fieldname              = 'DCAT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'DKEY'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'DLOC'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'DITXT'.
  APPEND l_fieldname TO lt_fieldname.
* MED-30914 - Begin
  l_fieldname              = 'DIKLAT'.
  APPEND l_fieldname TO lt_fieldname.
* MED-30914 - End

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


METHOD copy_data_internal.

* don't copy longtexts KANAM and FRAGE here -> is done in corder itself!
  DATA: lr_corder        TYPE REF TO cl_ish_corder,
        ls_n1corder      TYPE n1corder,
        lt_run_data      TYPE ish_t_objectbase,
        lr_diagnosis     TYPE REF TO cl_ish_prereg_diagnosis,
        ls_data_diag     TYPE rndip_attrib,
        lt_con_obj       TYPE ish_objectlist,
        ls_object        TYPE ish_object,
        lr_diagnosis_new TYPE REF TO cl_ish_prereg_diagnosis,
        lr_object        TYPE REF TO if_ish_objectbase,
        l_rc             TYPE ish_method_rc,
*        l_tid            TYPE ish_textmodule_id,         " REM MED-32853
        lt_tline         TYPE ish_t_textmodule_tline,
        lr_corder_old    TYPE REF TO cl_ish_corder,
        lt_line          TYPE ish_t_textmodule_tline.

  e_rc = 0.

  CHECK i_copy EQ 'C' OR     "Grill, med-20702
        i_copy EQ 'X' OR
        i_copy EQ 'L'.       "IXX-115 Naomi Popa 06.01.2015

  CALL METHOD me->get_corder
    RECEIVING
      rr_corder = lr_corder.

* fill lt_con_obj with corder
  ls_object-object ?= lr_corder.
  APPEND ls_object TO lt_con_obj.

* first call get_t_run_data from original component
  CALL METHOD ir_component_from->get_t_run_data
    IMPORTING
      et_run_data     = lt_run_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  LOOP AT lt_run_data INTO lr_object.

*   diagnosis
    CHECK lr_object->is_inherited_from(
                cl_ish_prereg_diagnosis=>co_otype_prereg_diagnosis ) = on
.
    lr_diagnosis ?= lr_object.
*   get data from diagnosis
    CALL METHOD lr_diagnosis->get_data
      IMPORTING
        es_data        = ls_data_diag
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   initialize some fields.
    CLEAR: ls_data_diag-vkgid.
*    CLEAR: ls_data_diag-ditxt, ls_data_diag-diltx.     " MED-32853 "MED-59118 CristinaG commented
*   build new diagnosis
    CALL METHOD cl_ish_prereg_diagnosis=>create
      EXPORTING
        is_data              = ls_data_diag
        i_environment        = gr_environment
        it_connected_objects = lt_con_obj
      IMPORTING
        e_instance           = lr_diagnosis_new
      EXCEPTIONS
        missing_environment  = 1
        OTHERS               = 2.
    l_rc = sy-subrc.
*   errorhandling
    IF l_rc <> 0.
      e_rc = l_rc.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        EXPORTING
*            I_TYP           =
*            I_PAR           =
*            I_ROW           =
*            I_FIELD         =
          ir_object       = me
*            I_LINE_KEY      =
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.

*   now get longtext from old diagnosis
*    l_tid = lr_diagnosis->get_text_id( ).                   " REM MED-32853

    CALL METHOD lr_diagnosis->get_text
      EXPORTING
*        i_text_id      = cl_ishmed_prereg=>co_text_ditxt    " REM MED-32853
        i_text_id      = cl_ish_prereg_diagnosis=>co_text_diltxt " MED-32853
      IMPORTING
        e_rc           = l_rc
        et_tline       = lt_tline
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF NOT lt_tline[] IS INITIAL.
*     change longtext for new diagnosis
      CALL METHOD lr_diagnosis_new->change_text
        EXPORTING
*          i_text_id      = l_tid                              " REM MED-32853
          i_text_id      = cl_ish_prereg_diagnosis=>co_text_diltxt " MED-32853
          it_tline       = lt_tline
          i_tline_x      = 'X'
        IMPORTING
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD create_diagnosis .

  DATA: lt_diagnosis          TYPE ish_objectlist,
        ls_object             TYPE ish_object,
        lr_diagnosis          TYPE REF TO cl_ish_prereg_diagnosis,
        ls_data_diag          TYPE rndip_attrib,
        l_einri               TYPE einri,
        l_rc                  TYPE ish_method_rc,
        ls_field_val          TYPE rnfield_value,
        ls_rndipx             TYPE rndipx,
        ls_rndip_attrib       TYPE rndip_attrib,
        l_changed             TYPE ish_on_off.

  CHECK NOT ir_corder IS INITIAL.
*  CHECK NOT i_field_value IS INITIAL.    "MED-34332

  l_changed = off.

* Get corder's diagnosis objects.
  CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
    EXPORTING
*     I_CANCELLED_DATAS = OFF
      ir_corder         = ir_corder
      ir_environment    = gr_environment
    IMPORTING
      e_rc              = e_rc
      et_diagnosis      = lt_diagnosis
*     ET_NDIP           = lt_ndip
    CHANGING
      cr_errorhandler   = cr_errorhandler.

* Change DITXT of diagnosis with order-flag
  LOOP AT lt_diagnosis INTO ls_object.
    lr_diagnosis ?= ls_object-object.
    CHECK NOT lr_diagnosis IS INITIAL.
    CALL METHOD lr_diagnosis->get_data
      IMPORTING
        es_data        = ls_data_diag
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    CHECK l_rc = 0.
    CHECK ls_data_diag-diklat = on.
*   DITXT changed?
    IF ls_data_diag-ditxt = i_field_value.
      l_changed = on.
      EXIT.
    ENDIF.
*   Change DITXT.
    CLEAR ls_rndipx.
    ls_rndipx-ditxt   = i_field_value.
    ls_rndipx-ditxt_x = on.
    CALL METHOD lr_diagnosis->change
      EXPORTING
        is_what_to_change = ls_rndipx
      IMPORTING
        e_rc              = l_rc
      CHANGING
        c_errorhandler    = cr_errorhandler.
*-- begin Grill, MED-34332
    IF ls_rndipx-ditxt IS INITIAL AND
       ls_data_diag    IS INITIAL.
      CALL METHOD ir_corder->delete_connection
        EXPORTING
          i_object = lr_diagnosis.
    ENDIF.
*-- end Grill, MED-34332
    l_changed = on.
    EXIT.
  ENDLOOP.

* Existing diagnosis changed?
  CHECK l_changed = off AND
        i_field_value IS NOT INITIAL.     "MED-42226

* Create new diagnosis and connect with corder.
  CLEAR: lr_diagnosis,
         ls_rndip_attrib,
         l_einri.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( ir_corder ).

  ls_rndip_attrib-einri  = l_einri.
  ls_rndip_attrib-ditxt  = i_field_value.
  ls_rndip_attrib-diklat = on.

  CALL METHOD cl_ish_prereg_diagnosis=>create
    EXPORTING
      is_data       = ls_rndip_attrib
      i_environment = gr_environment
    IMPORTING
      e_instance    = lr_diagnosis.

  CHECK NOT lr_diagnosis IS INITIAL.

  CALL METHOD ir_corder->add_connection
    EXPORTING
      i_object = lr_diagnosis.

ENDMETHOD.


METHOD get_corder .

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ishmed_corder=>co_otype_corder ) = on.

  rr_corder ?= gr_main_object.

ENDMETHOD.


METHOD get_diagnosis .

  DATA: lr_corder        TYPE REF TO cl_ish_corder,
        lr_diagnosis     TYPE REF TO cl_ish_prereg_diagnosis,
        lt_object        TYPE ish_objectlist,
        l_cancelled      TYPE ish_on_off,
        l_deleted        TYPE ish_on_off.
* note 1395973
  DATA: l_new            TYPE ish_on_off,
        l_chk_empty      TYPE ish_on_off,
        ls_ndip          TYPE rndip_attrib,
        l_rc             TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_object>  TYPE ish_object.
* note 1395973
  FIELD-SYMBOLS: <ls_diag>    TYPE ref to CL_ISH_PREREG_DIAGNOSIS.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get all connected diagnosiss from corder.
  CALL METHOD lr_corder->get_connections
    EXPORTING
      i_type     = cl_ish_prereg_diagnosis=>co_otype_prereg_diagnosis
    IMPORTING
      et_objects = lt_object.

* Build et_diagnosiss.
  l_chk_empty = on.                              " note 1395973
  LOOP AT lt_object ASSIGNING <ls_object>.
    CHECK NOT <ls_object>-object IS INITIAL.
    lr_diagnosis ?= <ls_object>-object.
    IF i_cancelled_datas = off.
      CALL METHOD lr_diagnosis->is_cancelled
        IMPORTING
          e_cancelled = l_cancelled
          e_deleted   = l_deleted.
      CHECK l_cancelled = off.
      CHECK l_deleted   = off.
    ENDIF.
    CALL METHOD lr_diagnosis->is_new             " note 1395973
      IMPORTING                                  " note 1395973
        e_new = l_new.                           " note 1395973
    IF l_new = off.                              " note 1395973
      l_chk_empty = off.                         " note 1395973
    ENDIF.                                       " note 1395973
    APPEND lr_diagnosis TO et_diagnosis.
  ENDLOOP.

* begin note 1395973
  IF l_chk_empty = on.
* auf leeren Satz prüfen, wenn nur neue Diagnosen vorhanden sind
    LOOP AT et_diagnosis ASSIGNING <ls_diag>.
      CALL METHOD <ls_diag>->get_data
        IMPORTING
          es_data        = ls_ndip
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      CLEAR ls_ndip-einri. CLEAR ls_ndip-diklat.
      IF ls_ndip IS INITIAL.
        DELETE et_diagnosis.
      ENDIF.
    ENDLOOP.
  ENDIF.
* end note 1395973
ENDMETHOD.


METHOD get_dom_for_run_data.

  DATA: lr_document_fragment TYPE REF TO if_ixml_document_fragment,
        lr_element           TYPE REF TO if_ixml_element,
        lr_text              TYPE REF TO if_ixml_text,
        lr_fragment          TYPE REF TO if_ixml_document_fragment,
        l_objecttype         TYPE i.
  DATA: lr_corder          TYPE REF TO cl_ish_corder,
        lr_diagnosis       TYPE REF TO cl_ish_prereg_diagnosis,
        lt_ddfields        TYPE ddfields,
        lt_ddfields_nrsf   TYPE ddfields,
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
        l_kaltx_value      TYPE string,
        l_kaltx_print      TYPE string,
        l_frltx_value      TYPE string,
        l_frltx_print      TYPE string,
        ls_data            TYPE rndip_attrib,
        l_dkat             TYPE nkdi-dkat,
        l_dkey             TYPE nkdi-dkey,
        l_ditext           TYPE nkdi-dtext1,
        l_diltx_value      TYPE string,
        l_diltx_print      TYPE string,
        lt_nrsf            TYPE TABLE OF nrsf,
        ls_nrsf            TYPE nrsf,
        l_rc               TYPE ish_method_rc,
        l_stack            TYPE i. "Grill, ID-16118

  DATA: lt_field TYPE ish_t_field,
        l_index TYPE i,
        l_string TYPE string.

  FIELD-SYMBOLS: <ls_ddfield> TYPE dfies.

  FIELD-SYMBOLS: <lt_print_field> TYPE ish_t_print_field,
                 <ls_print_field> TYPE rn1_print_field.

  DATA: lt_fields           TYPE ish_t_field.
  DATA: lr_element_body     TYPE REF TO if_ixml_element,
        lr_element_group    TYPE REF TO if_ixml_element,
        l_first_time        TYPE ish_on_off,
        lr_element_last_row TYPE REF TO if_ixml_element,
        lr_node_map         TYPE REF TO if_ixml_named_node_map,
        lr_node_last_row    TYPE REF TO if_ixml_node,
        lr_node_parent      TYPE REF TO if_ixml_node,
        lr_element_parent   TYPE REF TO if_ixml_element,
        l_name              TYPE string,
        l_dia_group         TYPE ish_on_off,
        lr_elementgroup_filter   TYPE REF TO if_ixml_node_filter,
        lr_elementgroup_iterator TYPE REF TO if_ixml_node_iterator,
        lr_elementgroup_node     TYPE REF TO if_ixml_node.

  DATA: lt_text TYPE STANDARD TABLE OF text132,   "MED-60716 AGujev
        ls_text TYPE text132.                      "MED-60716 AGujev
* Init.
  CLEAR: er_document_fragment,
         ls_n1corder,
         lt_tline,
         ls_tline,
         l_kaltx_value,
         l_kaltx_print,
         l_frltx_value,
         l_frltx_print,
         ls_data,
         l_dkat,
         l_dkey,
         l_ditext,
         l_diltx_value,
         l_diltx_print,
         lt_nrsf,
         ls_nrsf,
         l_dia_group.

  CHECK NOT ir_document IS INITIAL.
  CHECK NOT ir_run_data IS INITIAL.

*----------------------------------------------------------------
* This method is called with following run data objects
*   - CO_OTYPE_CORDER              (once)
*   - CO_OTYPE_PREREG_DIAGNOSIS    (n times)
* If run data object is CORDER => Handle N1CORDER(1) and NRSF(n).
* If run data object is DIA    => Handle NDIP(1)
*----------------------------------------------------------------

  IF ir_run_data->is_inherited_from(
                   cl_ishmed_corder=>co_otype_corder ) = on.

    lr_corder ?= ir_run_data.

    CALL METHOD lr_corder->get_data
      IMPORTING
        es_n1corder    = ls_n1corder
        e_rc           = l_rc
*     CHANGING
*       C_ERRORHANDLER =
      .

    IF NOT ls_n1corder IS INITIAL.
      IF ls_n1corder-kaltx = 'X'.
*       Get long text.
        CALL METHOD lr_corder->get_text
          EXPORTING
            i_only_read_db = off
            i_text_id      = cl_ish_corder=>co_text_kanam
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
          CONCATENATE l_kaltx_value ls_text
                 INTO l_kaltx_value
*            SEPARATED BY cl_ish_utl_cord=>co_lgtxt_nline "REM MED-90451
            RESPECTING BLANKS.
          CONCATENATE l_kaltx_print ls_text
                 INTO l_kaltx_print
            SEPARATED BY space
            RESPECTING BLANKS.
        ENDLOOP.
        REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf IN l_kaltx_value WITH cl_ish_utl_cord=>co_lgtxt_nline. "MED-90451
        CLEAR lt_text[].
*following processing was commented - not converted text was used !
*        LOOP AT lt_tline INTO ls_tline.
*          CONCATENATE l_kaltx_value ls_tline-tdline
*                 INTO l_kaltx_value
*            SEPARATED BY cl_ish_utl_cord=>co_lgtxt_nline
*            RESPECTING BLANKS."MED-57020 Cristina Geanta
*          CONCATENATE l_kaltx_print ls_tline-tdline
*                 INTO l_kaltx_print
*            SEPARATED BY space
*            RESPECTING BLANKS."MED-57020 Cristina Geanta
*        ENDLOOP.
*<--end of MED-60716 AGujev
        CONDENSE l_kaltx_print.
*-- begin Grill, MED-44132
        DESCRIBE TABLE lt_tline.
        IF sy-tfill < 2.
          l_kaltx_value = l_kaltx_print.
        ENDIF.
*-- end Grill, MED-33270
      ENDIF.
      CLEAR: lt_tline,
             ls_tline.
      IF ls_n1corder-frltx = 'X'.
*       Get long text.
        CALL METHOD lr_corder->get_text
          EXPORTING
            i_only_read_db = off
            i_text_id      = cl_ish_corder=>co_text_frage
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
          CONCATENATE l_frltx_value ls_text
                 INTO l_frltx_value
*            SEPARATED BY cl_ish_utl_cord=>co_lgtxt_nline "REM MED-90451
            RESPECTING BLANKS.
          CONCATENATE l_frltx_print ls_text
                 INTO l_frltx_print
            SEPARATED BY space
            RESPECTING BLANKS.
        ENDLOOP.
        REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf IN l_frltx_value WITH cl_ish_utl_cord=>co_lgtxt_nline. "MED-90451
        CLEAR lt_text[].
*following processing was commented - not converted text was used !
*        LOOP AT lt_tline INTO ls_tline.
*          CONCATENATE l_frltx_value ls_tline-tdline
*                 INTO l_frltx_value
*            SEPARATED BY cl_ish_utl_cord=>co_lgtxt_nline
*            RESPECTING BLANKS."MED-57020 Cristina Geanta
*          CONCATENATE l_frltx_print ls_tline-tdline
*                 INTO l_frltx_print
*            SEPARATED BY space
*            RESPECTING BLANKS. "MED-57020 Cristina Geanta
*        ENDLOOP.
*<--end of MED-60716 AGujev
        CONDENSE l_frltx_print.
*-- begin Grill, MED-44132
        DESCRIBE TABLE lt_tline.
        IF sy-tfill < 2.
          l_frltx_value = l_frltx_print.
        ENDIF.
*-- end Grill, MED-44132
      ENDIF.
    ENDIF.

    IF NOT ls_n1corder-patnr IS INITIAL.

*-- Begin Grill, ID-16118
      CALL FUNCTION 'ISH_MESSAGES_BACKUP'
        IMPORTING
          e_stack = l_stack.
*-- End Grill, ID-16118

      CALL FUNCTION 'ISH_CHECK_STORNO_NPAT_RISK'
        EXPORTING
*         SS_EINRI = '*'
          ss_patnr      = ls_n1corder-patnr
*       IMPORTING
*         SS_FOUND_RISK =
        TABLES
          ss_nrsf       = lt_nrsf.

*-- Begin Grill, ID-16118
      CALL FUNCTION 'ISH_MESSAGES_RESTORE'
        EXPORTING
          i_stack = 0.
*-- End Grill, ID-16118
    ENDIF.
    CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
      EXPORTING
        i_data_name     = 'NRSF'
*       IR_OBJECT   =
      IMPORTING
        et_ddfields     = lt_ddfields_nrsf
        e_rc            = l_rc
*     CHANGING
*       CR_ERRORHANDLER = cr_errorhandler
      .
  ENDIF.   "corder

  IF ir_run_data->is_inherited_from(
                   cl_ish_prereg_diagnosis=>co_otype_prereg_diagnosis ) = on.

    lr_diagnosis ?= ir_run_data.

    CALL METHOD lr_diagnosis->get_data
      IMPORTING
        es_data        = ls_data
        e_rc           = l_rc
*     CHANGING
*       C_ERRORHANDLER =
      .
    IF NOT ls_data IS INITIAL.
      IF NOT ls_data-dkey IS INITIAL AND
         NOT ls_data-dcat IS INITIAL.
        l_dkat = ls_data-dcat.
        l_dkey = ls_data-dkey.
        CALL FUNCTION 'ISH_READ_NKDI'
          EXPORTING
            dkat     = l_dkat
            dkey     = l_dkey
          IMPORTING
            e_dtext1 = l_ditext.
      ENDIF.
      CLEAR: lt_tline,
             ls_tline.
      IF ls_data-diltx = 'X'.
*       Get long text.
        CALL METHOD lr_diagnosis->get_text
          EXPORTING
            i_only_read_db = off
            i_text_id      = cl_ish_prereg_diagnosis=>co_text_diltxt
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
          CONCATENATE l_diltx_value ls_text
                 INTO l_diltx_value
*            SEPARATED BY cl_ish_utl_cord=>co_lgtxt_nline     "REM MED-90451
            RESPECTING BLANKS.
          CONCATENATE l_diltx_print ls_text
                 INTO l_diltx_print
            SEPARATED BY space
            RESPECTING BLANKS.
        ENDLOOP.
        REPLACE ALL OCCURRENCES OF cl_abap_char_utilities=>cr_lf IN l_diltx_value WITH cl_ish_utl_cord=>co_lgtxt_nline. "MED-90451
        CLEAR lt_text[].
*following processing was commented - not converted text was used !
*        LOOP AT lt_tline INTO ls_tline.
*          CONCATENATE l_diltx_value ls_tline-tdline
*                 INTO l_diltx_value
*            SEPARATED BY cl_ish_utl_cord=>co_lgtxt_nline
*            RESPECTING BLANKS."MED-57020 Cristina Geanta
*          CONCATENATE l_diltx_print ls_tline-tdline
*                 INTO l_diltx_print
*            SEPARATED BY space
*            RESPECTING BLANKS."MED-57020 Cristina Geanta
*        ENDLOOP.
*<--end of MED-60716 AGujev
        CONDENSE l_diltx_print.
*-- begin Grill, MED-44132
        DESCRIBE TABLE lt_tline.
        IF sy-tfill < 2.
          l_diltx_value = l_diltx_print.
        ENDIF.
*-- end Grill, MED-44132
      ENDIF.
    ENDIF.
  ENDIF.   "diagnosis

  CHECK gr_t_print_field IS BOUND.
  ASSIGN gr_t_print_field->* TO <lt_print_field>.
  CHECK sy-subrc = 0.

* CORDER.
  IF ir_run_data->is_inherited_from(
                   cl_ishmed_corder=>co_otype_corder ) = on.
*   Create document fragment.
    lr_document_fragment = ir_document->create_document_fragment( ).
  ENDIF.

* Diagnosis.
  IF ir_run_data->is_inherited_from(
                   cl_ish_prereg_diagnosis=>co_otype_prereg_diagnosis ) = on.
    IF NOT ir_element IS INITIAL.
*     Create ELEMENTGROUP filter.
      lr_elementgroup_filter =
         ir_element->create_filter_name_ns( name = 'ELEMENTGROUP'
                                            namespace = '' ).
*     Create ELEMENTGROUP iterator.
      lr_elementgroup_iterator =
        ir_element->create_iterator_filtered(
                                    filter = lr_elementgroup_filter ).
*     Get first ELEMENTGROUP node.
      lr_elementgroup_node = lr_elementgroup_iterator->get_next( ).
*     Do while nodes found.
      WHILE NOT lr_elementgroup_node IS INITIAL.
*       Get element group's parent.
        lr_node_parent = lr_elementgroup_node->get_parent( ).
        lr_element_parent ?= lr_node_parent.
        CLEAR l_name.
        IF lr_element_parent IS BOUND.
          l_name = lr_element_parent->get_attribute_ns( name = 'NAME' ).
        ENDIF.
        IF l_name = 'Diagnosen'(002).
          l_dia_group = on.
          EXIT.
        ENDIF.
*       Get next ELEMENTGROUP node.
        lr_elementgroup_node = lr_elementgroup_iterator->get_next( ).
      ENDWHILE.
      IF l_dia_group = on.
        lr_element_group ?= lr_elementgroup_node.
      ENDIF.
**     Get element group.
*      lr_element_group =
*        ir_element->find_from_name_ns( depth = 0
*                                       name = 'ELEMENTGROUP'
*                                       uri = '' ).
      IF NOT lr_element_group IS INITIAL.
        IF l_dia_group = on.
*         Existing element group => get element body.
          lr_element_body =
           lr_element_group->find_from_name_ns( depth = 0
                                                name = 'ELEMENTBODY'
                                                uri = '' ).
          IF NOT lr_element_body IS INITIAL.
*           Existing element body => get last child.
            lr_node_last_row = lr_element_body->get_last_child( ).
            IF NOT lr_node_last_row IS INITIAL.
              lr_element_last_row ?= lr_node_last_row.
*             Get last child's row id.
              l_string =
               lr_element_last_row->get_attribute_ns( name = 'RID' ).
              l_index = l_string.
*             Compute new row id.
              l_index = l_index + 1.
            ENDIF.
          ENDIF.
        ELSE.
*         No element group for diagnosis.
          l_first_time = on.
          l_index = 1.
        ENDIF.  "l_name
      ELSE.
*       No element group.
        l_first_time = on.
        l_index = 1.
      ENDIF.  "lr_element_group
    ENDIF.  "ir_element
    IF l_first_time = on.
*     No element group => create DOM fragment.
      lr_document_fragment = ir_document->create_document_fragment( ).
    ENDIF.
  ENDIF.  "diagnosis

* Loop print fields.
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
*     CHANGING
*       CR_ERRORHANDLER = cr_errorhandler
      .
    CHECK l_rc = 0.
    CHECK NOT lt_ddfields IS INITIAL.

    IF <ls_print_field>-t_fieldname IS INITIAL.
      l_get_all_fields = 'X'.
    ENDIF.

    LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
      CLEAR: l_field_supported,
             l_field_value.
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
          e_field         = l_field_value
*       IMPORTING
*         E_FLD_NOT_FOUND =
*       CHANGING
*         C_ERRORHANDLER  =
        .

*     KANAM (longtext).
      IF <ls_ddfield>-fieldname = 'KANAM'.
        IF NOT l_kaltx_value IS INITIAL.
          l_field_value = l_kaltx_value.
        ENDIF.
      ENDIF.

*     Set frage text.
      IF <ls_ddfield>-fieldname = 'FRAGE'.
        IF NOT l_frltx_value IS INITIAL.
          l_field_value = l_frltx_value.
        ENDIF.
      ENDIF.

*      IF <ls_ddfield>-fieldname = 'DKEY'.
*        CONCATENATE l_field_value l_ditext
*               INTO l_field_value SEPARATED BY space.
*      ENDIF.

*     Set diagnosis text.
      IF <ls_ddfield>-fieldname = 'DITXT'.
        IF NOT l_diltx_value IS INITIAL.
          l_field_value = l_diltx_value.
        ENDIF.
      ENDIF.

*     Get field as DOM element.
      CLEAR ls_field.
      ls_field-tabname    = <ls_print_field>-tabname.
      ls_field-fieldname  = <ls_ddfield>-fieldname.
      ls_field-fieldlabel = <ls_ddfield>-scrtext_m.
      ls_field-fieldvalue = l_field_value.
      ls_field-fieldprint = l_field_value.
      IF <ls_ddfield>-fieldname = 'KANAM'.
        IF NOT l_kaltx_print IS INITIAL.
          ls_field-fieldprint = l_kaltx_print.
        ENDIF.
      ENDIF.
      IF <ls_ddfield>-fieldname = 'FRAGE'.
        IF NOT l_frltx_print IS INITIAL.
          ls_field-fieldprint = l_frltx_print.
        ENDIF.
      ENDIF.
      IF <ls_ddfield>-fieldname = 'DKEY'.
        ls_field-fieldprint = l_ditext.
      ENDIF.
      IF <ls_ddfield>-fieldname = 'DITXT'.
        IF NOT l_diltx_print IS INITIAL.
          ls_field-fieldprint = l_diltx_print.
        ENDIF.
      ENDIF.
      ls_field-display    = on.

*     MED-30914 - Begin
      IF <ls_ddfield>-fieldname = 'DIKLAT'.
        CLEAR ls_field-display.
      ENDIF.
*     MED-30914 - End

*     CORDER.
      IF ir_run_data->is_inherited_from(
                       cl_ishmed_corder=>co_otype_corder ) = on.
        CALL METHOD cl_ish_utl_xml=>get_dom_element
          EXPORTING
            is_field   = ls_field
          IMPORTING
            er_element = lr_element.
*       Append component element to component DOM fragment
        l_rc = lr_document_fragment->append_child(
                                            new_child = lr_element ).
      ENDIF.

*     Diagnosis.
      IF ir_run_data->is_inherited_from(
                    cl_ish_prereg_diagnosis=>co_otype_prereg_diagnosis ) = on.
        APPEND ls_field TO lt_fields.
      ENDIF.
    ENDLOOP.
*   CORDER => EXIT.
    IF ir_run_data->is_inherited_from(
                     cl_ishmed_corder=>co_otype_corder ) = on.
      EXIT.
    ENDIF.
  ENDLOOP.

* Diagnosis.
  IF ir_run_data->is_inherited_from(
                   cl_ish_prereg_diagnosis=>co_otype_prereg_diagnosis ) = on.
*   Get component element.
    l_string = 'Diagnosen'(002).
    CALL METHOD cl_ish_utl_xml=>get_dom_complex_element
      EXPORTING
        it_field   = lt_fields
        i_display  = on
        i_is_group = on
        i_index    = l_index
        i_compname = l_string
      IMPORTING
        er_element = lr_element.
    IF l_first_time = on.
*     Append component element to component DOM fragment
      l_rc = lr_document_fragment->append_child(
                                          new_child = lr_element ).
    ELSE.
      IF NOT lr_element_body IS INITIAL.
*       Append component element to body element.
        l_rc = lr_element_body->append_child( lr_element ).
      ENDIF.
    ENDIF.
  ENDIF.

* NRSF
  IF ir_run_data->is_inherited_from(
                   cl_ishmed_corder=>co_otype_corder ) = on.
    l_index = 0.
    LOOP AT lt_nrsf INTO ls_nrsf.
*     Get fields as DOM element.
      l_index = l_index + 1.
      LOOP AT lt_ddfields_nrsf ASSIGNING <ls_ddfield>.
*       RSFNR
        IF <ls_ddfield>-fieldname = 'RSFNR'.
          CLEAR ls_field.
          ls_field-tabname    = 'NRSF'.
          ls_field-fieldname  = <ls_ddfield>-fieldname.
          ls_field-fieldlabel = <ls_ddfield>-scrtext_m.
          ls_field-fieldvalue = ls_nrsf-rsfnr.
          ls_field-fieldprint = ls_nrsf-rsfnr.
*            CALL METHOD cl_ish_utl_xml=>get_dom_element
*              EXPORTING
*                is_field   = ls_field
*              IMPORTING
*                er_element = lr_element.
**         Append component element to component DOM fragment
*            l_rc = lr_document_fragment->append_child(
*                                               new_child = lr_element )
*.
          ls_field-display = on.
          ls_field-lindex = l_index.
          APPEND ls_field TO lt_field.
        ENDIF.
*       KZTXT
        IF <ls_ddfield>-fieldname = 'KZTXT'.
          CLEAR ls_field.
          ls_field-tabname    = 'NRSF'.
          ls_field-fieldname  = <ls_ddfield>-fieldname.
          ls_field-fieldlabel = <ls_ddfield>-scrtext_m.
          ls_field-fieldvalue = ls_nrsf-kztxt.
          ls_field-fieldprint = ls_nrsf-kztxt.
*            CALL METHOD cl_ish_utl_xml=>get_dom_element
*              EXPORTING
*                is_field   = ls_field
*              IMPORTING
*                er_element = lr_element.
**           Append component element to component DOM fragment
*            l_rc = lr_document_fragment->append_child(
*                                               new_child = lr_element )
*.
          ls_field-display = on.
          ls_field-lindex = l_index.
          APPEND ls_field TO lt_field.
        ENDIF.
*       ERDAT
        IF <ls_ddfield>-fieldname = 'ERDAT'.
          CLEAR ls_field.
          ls_field-tabname    = 'NRSF'.
          ls_field-fieldname  = <ls_ddfield>-fieldname.
          ls_field-fieldlabel = <ls_ddfield>-scrtext_m.
          ls_field-fieldvalue = ls_nrsf-erdat.
          ls_field-fieldprint = ls_nrsf-erdat.
*            CALL METHOD cl_ish_utl_xml=>get_dom_element
*              EXPORTING
*                is_field   = ls_field
*              IMPORTING
*                er_element = lr_element.
**           Append component element to component DOM fragment
*            l_rc = lr_document_fragment->append_child(
*                                               new_child = lr_element )
*.
          ls_field-display = on.
          ls_field-lindex = l_index.
          APPEND ls_field TO lt_field.
        ENDIF.
*       ERUSR
        IF <ls_ddfield>-fieldname = 'ERUSR'.
          CLEAR ls_field.
          ls_field-tabname    = 'NRSF'.
          ls_field-fieldname  = <ls_ddfield>-fieldname.
          ls_field-fieldlabel = <ls_ddfield>-scrtext_m.
          ls_field-fieldvalue = ls_nrsf-erusr.
          ls_field-fieldprint = ls_nrsf-erusr.
*          CALL METHOD cl_ish_utl_xml=>get_dom_element
*            EXPORTING
*              is_field   = ls_field
*            IMPORTING
*              er_element = lr_element.
**         Append component element to component DOM fragment
*          l_rc = lr_document_fragment->append_child(
*                                             new_child = lr_element ).
          ls_field-display = on.
          ls_field-lindex = l_index.
          APPEND ls_field TO lt_field.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    l_string = 'Risikofaktoren'(001).
    CALL METHOD cl_ish_utl_xml=>get_dom_complex_element
      EXPORTING
        it_field   = lt_field
        i_is_group = on
        i_index    = 1
        i_compname = l_string
      IMPORTING
        er_element = lr_element.

    l_rc = lr_document_fragment->append_child( lr_element ).
  ENDIF.

* Modify DOM fragment
  CALL METHOD modify_dom_data
    IMPORTING
      e_rc                 = l_rc
    CHANGING
*     cr_errorhandler      = cr_errorhandler
      cr_document_fragment = lr_document_fragment
      cr_element           = lr_element_body.

* Export DOM fragment
  er_document_fragment = lr_document_fragment.

ENDMETHOD.


METHOD if_ish_component~cancel.

* Michael Manoch, 05.07.2004, ID 14907
* Redefine the method to cancel the diagnosis objects.

  DATA: lr_corder     TYPE REF TO cl_ish_corder,
        lt_diagnosis  TYPE ish_t_prereg_diagnosis,
        lr_diagnosis  TYPE REF TO cl_ish_prereg_diagnosis,
        ls_n1corder_x TYPE rn1_corder_x,
        l_cancelled   TYPE ish_on_off,
        l_rc          TYPE ish_method_rc.
  DATA:  lt_tline      TYPE ish_t_textmodule_tline.         "MED-33341

*-- Begin MED-33341
  DATA: lt_textmodule TYPE ish_t_textmodule_use,
        ls_object     TYPE rntextmodule_use,
        lr_textmodule TYPE REF TO cl_ish_textmodule.
*-- end MED-33341

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get diagnosis objects.
  CALL METHOD get_diagnosis
    IMPORTING
      e_rc            = e_rc
      et_diagnosis    = lt_diagnosis
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Process each diagnosis object.
  LOOP AT lt_diagnosis INTO lr_diagnosis.
    CHECK NOT lr_diagnosis IS INITIAL.
*   Cancel diagnosis object.
    CALL METHOD lr_diagnosis->cancel
      EXPORTING
        i_check_only   = i_check_only
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ENDLOOP.
  CHECK e_rc = 0.

* No further processing in check-only mode.
  CHECK i_check_only = off.

* No further processing for cancelled corder objects.
  CALL METHOD lr_corder->is_cancelled
    IMPORTING
      e_cancelled = l_cancelled.
  CHECK l_cancelled = off.

* Clear the component's data from the corder.

* Build the changing structure.
  CLEAR ls_n1corder_x.
  ls_n1corder_x-schwkz_x = on.
  ls_n1corder_x-schwo_x  = on.
  ls_n1corder_x-ifg_x    = on.

* Change corder data.
  CALL METHOD lr_corder->change
    EXPORTING
      is_corder_x     = ls_n1corder_x
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

*Begin of MED-49550 - ChicherneaA
* Clear the corder kanam.
*  CALL METHOD lr_corder->change_text
*    EXPORTING
*      i_text_id      = cl_ish_corder=>co_text_kanam
*    IMPORTING
*      e_rc           = l_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*  ENDIF.
*
** Clear the corder frage.
*  CALL METHOD lr_corder->change_text
*    EXPORTING
*      i_text_id      = cl_ish_corder=>co_text_frage
*    IMPORTING
*      e_rc           = l_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*  ENDIF.
*End of MED-49550 - ChicherneaA

*-- begin Grill, MED-33341
  lt_textmodule = lr_corder->if_ish_use_textmodule~gt_textmodule.
  LOOP AT lt_textmodule INTO ls_object.
    CHECK ls_object-text_id EQ cl_ish_corder=>co_text_kanam OR
          ls_object-text_id EQ cl_ish_corder=>co_text_frage.
    lr_textmodule ?= ls_object-text_obj.
    CHECK lr_textmodule IS BOUND.

    CALL METHOD lr_textmodule->destroy
      IMPORTING
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc NE 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.

    DELETE lr_corder->if_ish_use_textmodule~gt_textmodule WHERE text_id = ls_object-text_id.
  ENDLOOP.
*-- end Grill, MED-33341
ENDMETHOD.


METHOD if_ish_component~check .

  DATA: lt_diagnosis    TYPE ish_t_prereg_diagnosis,
        lr_diagnosis    TYPE REF TO cl_ish_prereg_diagnosis.

* Process super method.
  CALL METHOD super->if_ish_component~check
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get all diagnosis objects.
  CALL METHOD get_diagnosis
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_diagnosis      = lt_diagnosis
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each diagnosis object.
  LOOP AT lt_diagnosis INTO lr_diagnosis.
    CHECK NOT lr_diagnosis IS INITIAL.
*   Check diagnosis object.
    CALL METHOD lr_diagnosis->check
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ENDLOOP.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_component~check_changes .

  DATA: lt_diagnosis   TYPE ish_t_prereg_diagnosis,
        lr_diagnosis   TYPE REF TO cl_ish_prereg_diagnosis.

* Get all diagnosis objects.
  CALL METHOD get_diagnosis
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_diagnosis      = lt_diagnosis
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each diagnosis object.
  LOOP AT lt_diagnosis INTO lr_diagnosis.
    CHECK NOT lr_diagnosis IS INITIAL.
*   Check radiology object for changes
    e_changed = lr_diagnosis->is_changed( ).
    IF e_changed = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_component~get_t_run_data .

  DATA: lr_corder  TYPE REF TO cl_ish_corder,
        lt_diagnosis  TYPE ish_t_prereg_diagnosis.

* Get objects of super class.
  CALL METHOD super->if_ish_component~get_t_run_data
    IMPORTING
      et_run_data     = et_run_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get diagnosis objects.
  CALL METHOD get_diagnosis
    IMPORTING
      e_rc            = e_rc
      et_diagnosis    = lt_diagnosis
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Append diagnosis objects.
  APPEND LINES OF lt_diagnosis TO et_run_data.

ENDMETHOD.


METHOD if_ish_component~get_t_uid .

  DATA: lr_corder        TYPE REF TO cl_ish_corder,
        lr_obj           TYPE REF TO CL_ISH_PREREG_DIAGNOSIS,
        lt_object        TYPE ish_objectlist,
        ls_key           TYPE rndip_key,
        l_uid            TYPE sysuuid_c.

  FIELD-SYMBOLS: <ls_object>  TYPE ish_object.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get all connected diagnosis from corder.
  CALL METHOD lr_corder->get_connections
    EXPORTING
      i_type     = cl_ish_prereg_diagnosis=>co_otype_prereg_diagnosis
    IMPORTING
      et_objects = lt_object.

* For every diagnosis:
*   - Get its stringified key.
*   - Add the key to et_uid.
  LOOP AT lt_object ASSIGNING <ls_object>.
    CHECK NOT <ls_object>-object IS INITIAL.
    lr_obj ?= <ls_object>-object.
    CALL METHOD lr_obj->get_data
      IMPORTING
        es_key = ls_key.
    CHECK NOT ls_key-dipno IS INITIAL.
    l_uid = ls_key-dipno.
    APPEND l_uid TO rt_uid.
  ENDLOOP.

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
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get corder data.
  CALL METHOD lr_corder->get_data
    IMPORTING
      e_rc        = l_rc
      es_n1corder = ls_n1corder.
* On error -> self is not empty.
  CHECK l_rc = 0.

* If one of the component fields is not empty -> self is not empty.
  CHECK ls_n1corder-kanam  IS INITIAL.
  CHECK ls_n1corder-kaltx  IS INITIAL.
  CHECK ls_n1corder-schwkz IS INITIAL.
  CHECK ls_n1corder-schwo  IS INITIAL.
  CHECK ls_n1corder-ifg    IS INITIAL.
  CHECK ls_n1corder-frage  IS INITIAL.
  CHECK ls_n1corder-frltx  IS INITIAL.

* Self is empty.
  r_empty = on.

ENDMETHOD.


METHOD if_ish_component~save .

  DATA: lt_diagnosis   TYPE ish_t_prereg_diagnosis,
        lr_diagnosis    TYPE REF TO cl_ish_prereg_diagnosis,
        ls_ndip_key     TYPE rndip_key,
        l_uid           TYPE sysuuid_c.

* Get all diagnosis objects.
  CALL METHOD get_diagnosis
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_diagnosis      = lt_diagnosis
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each diagnosis object.
  LOOP AT lt_diagnosis INTO lr_diagnosis.
    CHECK NOT lr_diagnosis IS INITIAL.
*   Save diagnosis object.
    CALL METHOD lr_diagnosis->save
      EXPORTING
        i_testrun           = i_testrun
        i_tcode             = i_tcode
        i_save_conn_objects = off
      IMPORTING
        e_rc                = e_rc
      CHANGING
        c_errorhandler      = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
*   Handle et_uid_save.
    CALL METHOD lr_diagnosis->get_data
      IMPORTING
        es_key = ls_ndip_key.
    l_uid = ls_ndip_key-dipno.
    IF l_uid NE '0000000000'. "Grill, ID-18347
      APPEND l_uid TO et_uid_save.
    ENDIF.                    "Grill, ID-18347
  ENDLOOP.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_component~set_t_uid .

  DATA: lr_obj        TYPE REF TO cl_ish_prereg_diagnosis,
        lr_corder     TYPE REF TO cl_ish_corder,
        ls_key        TYPE rndip_key.

  FIELD-SYMBOLS: <l_uid>  TYPE sysuuid_c.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* For every uid:
*   - Load the corresponding object
*   - Connect it with corder.
  LOOP AT it_uid ASSIGNING <l_uid>.
    CHECK NOT <l_uid> IS INITIAL.
    CLEAR ls_key.
    ls_key-dipno = <l_uid>.
*   Load object.
    CALL METHOD cl_ish_prereg_diagnosis=>load
      EXPORTING
        is_key              = ls_key
        i_environment       = gr_environment
      IMPORTING
        e_instance          = lr_obj
      EXCEPTIONS
        missing_environment = 1
        not_found           = 2
        OTHERS              = 3.
    CHECK sy-subrc = 0.  " Ignore errors
    CHECK NOT lr_obj IS INITIAL.
*   Connect with corder.
    CALL METHOD lr_corder->add_connection
      EXPORTING
        i_object = lr_obj.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_dom~modify_dom_data.

  DATA: lr_changing_node      TYPE REF TO if_ixml_node,
        lr_document_fragment  TYPE REF TO if_ixml_document_fragment,
        lr_root_node          TYPE REF TO if_ixml_node,
        lr_node_iterator      TYPE REF TO if_ixml_node_iterator,
        lr_node               TYPE REF TO if_ixml_node,
        lr_node_name          TYPE REF TO if_ixml_node,
        lr_attributes         TYPE REF TO if_ixml_named_node_map,
        lr_node_first_child   TYPE REF TO if_ixml_node,
        lr_node_last_child    TYPE REF TO if_ixml_node,
        l_string_compel_name  TYPE string,
        l_string_el_name      TYPE string,
        l_string_el_value     TYPE string,
        l_einri               TYPE tn01-einri,
        l_ifg                 TYPE n1ifg-ifg,
        l_ifge                TYPE n1ifg-ifge,
        l_ifgtxt              TYPE n1ifgt-ifgtxt,
        l_dialo               TYPE tn26x-dialo,
        l_dialotext           TYPE tn26x-dialotext,
        l_katid               TYPE katid,
        l_kattx               TYPE kattx,
        l_table_field         TYPE tabfield,
        l_cdat_in             TYPE char10,
        l_cdat_out            TYPE char10.
  DATA:   lr_elementrow_filter   TYPE REF TO if_ixml_node_filter,
          lr_elementrow_iterator TYPE REF TO if_ixml_node_iterator,
          lr_element             TYPE REF TO if_ixml_element,
          lr_elementrow_node     TYPE REF TO if_ixml_node,
          lr_elementrow_elem     TYPE REF TO if_ixml_element,
          lr_elementval_nodes    TYPE REF TO if_ixml_node_list,
          lr_elementval_node     TYPE REF TO if_ixml_node,
          lr_elementval_elem     TYPE REF TO if_ixml_element,
          lr_elem_last_child     TYPE REF TO if_ixml_element,
          l_name                 TYPE string,
          l_value                TYPE string,
          l_value1               TYPE string,
          l_index                TYPE i.

  e_rc = 0.

* No document => no action.
  IF cr_document_fragment IS BOUND.
    lr_changing_node ?= cr_document_fragment.
  ELSE.
    lr_changing_node ?= cr_element.
  ENDIF.
  CHECK lr_changing_node IS BOUND.

* Check/create errorhandler.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Get ROOT NODE.
  CALL METHOD lr_changing_node->get_root
    RECEIVING
      rval = lr_root_node.
  CHECK NOT lr_root_node IS INITIAL.

* Create NODE ITERATOR.
  CALL METHOD lr_root_node->create_iterator
*  EXPORTING
*    DEPTH  = 0
    RECEIVING
      rval   = lr_node_iterator.

* Get first COMPELEMENT.
  lr_node = lr_node_iterator->get_next( ).

  WHILE NOT lr_node IS INITIAL.
    CLEAR: l_string_el_name,
           l_string_el_value,
           l_string_compel_name.
*----------------------------------------------------
*   The current DOM node should look like this:
*
*   <COMPELEMENT ROWID="1" COLID="1" NAME="email">
*      <ELEMENTTAG>Email</ELEMENTTAG>
*      <ELEMENTVAL>my.email@data.com</ELEMENTVAL>
*   </COMPELEMENT>
*----------------------------------------------------
    IF lr_node->get_name( ) EQ 'COMPELEMENT'.
*     Get COMPELEMENT attributes.
      lr_attributes = lr_node->get_attributes( ).

      IF NOT lr_attributes IS INITIAL.
*       Get attribute NAME.
        lr_node_name  = lr_attributes->get_named_item( 'NAME' ).

        IF NOT lr_node_name IS INITIAL.
*         Get first child of COMPELEMENT => ELEMENTTAG.
          lr_node_first_child = lr_node->get_first_child( ).
          IF NOT lr_node_first_child IS INITIAL.
            l_string_el_name = lr_node_first_child->get_value( ).
          ENDIF.
*         Get last  child of COMPELEMENT => ELEMENTVAL.
          lr_node_last_child  = lr_node->get_last_child( ).
          IF NOT lr_node_last_child IS INITIAL.
            l_string_el_value = lr_node_last_child->get_value( ).
          ENDIF.

*         Check/change COMPELEMENT.
          l_string_compel_name = lr_node_name->get_value( ).
          CASE l_string_compel_name.
*           SCHWKZ
            WHEN 'SCHWKZ'.
*             Map domain value.
              CALL METHOD cl_ish_utl_xml=>map_domain_value
                EXPORTING
*                 CDuerr, MED-72351 - begin
*                  i_domain        = 'XFELD'
                  i_domain        = 'N1SCHWANGER'
*                 CDuerr, MED-72351 - end
                  i_value         = l_string_el_value
                IMPORTING
                  e_text          = l_string_el_value
                  e_rc            = e_rc
                CHANGING
                  cr_errorhandler = cr_errorhandler.
*             Modify element value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           SCHWO
            WHEN 'SCHWO'.
*             No leading 0.
              SHIFT l_string_el_value LEFT DELETING LEADING '0'.
*             Modify element value in DOM node
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           IFG
            WHEN 'IFG'.
              CLEAR: l_einri, l_ifg, l_ifge, l_ifgtxt.
              IF l_string_el_value = '00'.
                l_string_el_value = space.
              ELSE.
*               Get institution.
                l_einri =
                  cl_ish_utl_base=>get_institution_of_obj(
                                   gr_main_object ).
                CHECK NOT l_einri IS INITIAL.
*               Get text.
                l_ifg = l_string_el_value.
                SELECT SINGLE ifge
                  FROM n1ifg
                  INTO l_ifge
                 WHERE einri = l_einri
                   AND ifg   = l_ifg.
                IF sy-subrc = 0.
                  l_string_el_value = l_ifge.
                  SELECT SINGLE ifgtxt
                    FROM n1ifgt
                    INTO l_ifgtxt
                   WHERE spras = sy-langu
                     AND einri = l_einri
                     AND ifge  = l_ifge.
                  IF sy-subrc = 0.
                    l_string_el_value = l_ifgtxt.
                  ENDIF.
                ENDIF.
              ENDIF.
*             Modify value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
            WHEN OTHERS.
          ENDCASE.
        ENDIF.  "NAME
      ENDIF.  "attributes
    ENDIF.  "COMPELEMENT

*   Get next COMPELEMENT.
    lr_node = lr_node_iterator->get_next( ).
  ENDWHILE.

* Create ELEMENTROW filter.
  lr_elementrow_filter =
     lr_root_node->create_filter_name_ns( name = 'ELEMENTROW'
                                          namespace = '' ).
* Create ELEMENTROW iterator.
  lr_elementrow_iterator =
    lr_root_node->create_iterator_filtered(
                                  filter = lr_elementrow_filter ).

* Get first ELEMENTROW node.
  lr_elementrow_node = lr_elementrow_iterator->get_next( ).
* Do while nodes found.
  WHILE NOT lr_elementrow_node IS INITIAL.
*   Cast node to element.
    lr_elementrow_elem ?= lr_elementrow_node.
    CHECK lr_elementrow_elem IS BOUND.
*   Get children .
    lr_elementval_nodes = lr_elementrow_elem->get_children( ).
    l_index = 0.
    WHILE l_index < lr_elementval_nodes->get_length( ).
      lr_elementval_node =
                    lr_elementval_nodes->get_item( l_index ).
      lr_elementval_elem ?= lr_elementval_node.
      l_name   = lr_elementval_elem->get_attribute( name = 'NAME' ).
      l_value1 = lr_elementval_elem->get_attribute( name = 'VALUE' ).
      l_value  = lr_elementval_elem->get_value( ).
      CASE l_name.
*       ERDAT
        WHEN 'ERDAT'.
          IF l_value = l_value1.
*             Convert date from intern to extern.
            l_cdat_in = l_value.
            l_table_field-tabname   = 'SY'.
            l_table_field-fieldname = 'DATUM'.
            IF l_cdat_in = '00000000'.
              l_value = space.
            ELSE.
              CALL FUNCTION 'RS_DS_CONV_IN_2_EX'
                EXPORTING
                  input                = l_cdat_in
*                    DESCR                =
                  table_field          = l_table_field
*                    CHECK_INPUT          =
                IMPORTING
                  output               = l_cdat_out
                EXCEPTIONS
                  conversion_error     = 1
                  OTHERS               = 2.
              IF sy-subrc = 0.
                l_value = l_cdat_out.
              ENDIF.
            ENDIF.
*           Modify element value in DOM node
            e_rc = lr_elementval_elem->set_value( l_value ).
          ENDIF.
*       DCAT
        WHEN 'DCAT'.
          IF l_value = l_value1.
            CLEAR: l_einri, l_katid, l_kattx.
*           Get text.
            l_katid = l_value.
            SELECT SINGLE kattx
              FROM tnk00
              INTO l_kattx
             WHERE katid = l_katid.
            IF sy-subrc = 0.
              l_value = l_kattx.
            ENDIF.
*           Modify element value in DOM node
            e_rc = lr_elementval_elem->set_value( l_value ).
          ENDIF.
*           DLOC
        WHEN 'DLOC'.
          IF l_value = l_value1.
            CLEAR: l_einri, l_dialo, l_dialotext.
*           Get institution.
            l_einri =
              cl_ish_utl_base=>get_institution_of_obj(
                               gr_main_object ).
            CHECK NOT l_einri IS INITIAL.
*           Get text.
            l_dialo = l_value.
            SELECT SINGLE dialotext
              FROM tn26x
              INTO l_dialotext
             WHERE einri = l_einri
               AND spras = sy-langu
               AND dialo = l_dialo.
            IF sy-subrc = 0.
              l_value = l_dialotext.
            ENDIF.
*           Modify element value in DOM node
            e_rc = lr_elementval_elem->set_value( l_value ).
          ENDIF.
        WHEN OTHERS.
      ENDCASE.
      l_index = l_index + 1.
    ENDWHILE.
*   Get next ELEMENTROW node.
    lr_elementrow_node = lr_elementrow_iterator->get_next( ).
  ENDWHILE.

* Return modified document.
  IF cr_document_fragment IS BOUND.
    cr_document_fragment ?= lr_changing_node.
  ELSE.
    cr_element ?= lr_changing_node.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_comp_med_data.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_comp_med_data.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD INITIALIZE_METHODS .

* initialize methods.

ENDMETHOD.


METHOD initialize_screens.

  DATA: lr_scr_med_data TYPE REF TO cl_ish_scr_med_data.

  CALL METHOD cl_ish_scr_med_data=>create
    IMPORTING
      er_instance     = lr_scr_med_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  APPEND lr_scr_med_data TO gt_screen_objects.

ENDMETHOD.


METHOD prealloc_from_external_int.

* ED, ID 16882 -> BEGIN
  DATA: lt_ddfields       TYPE ddfields,
        l_rc              TYPE ish_method_rc,
        lr_corder         TYPE REF TO cl_ish_corder,
        ls_corder_x       TYPE rn1_corder_x,
        l_field_supported TYPE c,
        l_value           TYPE nfvvalue,
        ls_data_ndip      TYPE rndip_attrib,
        lt_con_obj        TYPE ish_objectlist,
        ls_object         TYPE ish_object,
        lr_diagnosis      TYPE REF TO cl_ish_prereg_diagnosis,
        l_fname           TYPE string,
        lt_line           TYPE ish_t_textmodule_tline,
        l_compid          TYPE n1comp-compid,
        l_index           TYPE i,
        l_longtext        TYPE ish_on_off,
        ls_ndipx          TYPE rndipx.

  DATA ls_line LIKE LINE OF lt_line.                "MED-44132

  FIELD-SYMBOLS: <ls_ddfield> TYPE dfies,
                 <ls_mapping> TYPE ishmed_migtyp_l,
                 <fst>        TYPE any.

  e_rc = 0.

* get clinical order
  CALL METHOD me->get_corder
    RECEIVING
      rr_corder = lr_corder.

* fill lt_con_obj with corder
  ls_object-object ?= lr_corder.
  APPEND ls_object TO lt_con_obj.

* get compid
  CALL METHOD me->get_compid
    RECEIVING
      r_compid = l_compid.

* only data which refer to the corder object are relevant *******
  LOOP AT it_mapping ASSIGNING <ls_mapping>
      WHERE instno = 0
        AND compid = l_compid.
    CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
      EXPORTING
        i_data_name     = 'RN1_CORDER_X'
      IMPORTING
        et_ddfields     = lt_ddfields
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.

    LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
      CLEAR: l_field_supported.
      CHECK <ls_mapping>-fieldname = <ls_ddfield>-fieldname.
      l_field_supported = 'X'.
      CHECK l_field_supported = 'X'.
*     fill changing structure
      CONCATENATE 'LS_CORDER_X-' <ls_mapping>-fieldname INTO l_fname.
      ASSIGN (l_fname) TO <fst>.
      <fst> = <ls_mapping>-fvalue.
*     fill X-Flag too
      CONCATENATE 'ls_corder_x-' <ls_mapping>-fieldname
      '_x' INTO l_fname.
      ASSIGN (l_fname) TO <fst>.
      <fst> = on.
      CLEAR: lt_line[], l_longtext.
*     xxxxx longtext KANAM xxxxx
      IF <ls_mapping>-fieldname = 'KANAM'.
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
*-- begin Grill, MED-44132
        IF l_longtext = on.
*        IF NOT lt_line[] IS INITIAL AND l_longtext = on.
*-- end Grill, MED-44132
          ls_corder_x-kaltx = on.
          ls_corder_x-kaltx_x = on.
          CALL METHOD lr_corder->change_text
            EXPORTING
              i_text_id      = cl_ish_corder=>co_text_kanam
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
              i_text_id      = cl_ish_corder=>co_text_kanam
            IMPORTING
              e_textline     = ls_corder_x-kanam
              e_rc           = l_rc
            CHANGING
              c_errorhandler = cr_errorhandler.
          ls_corder_x-kanam_x = on.
          IF l_rc <> 0.
            e_rc = l_rc.
            EXIT.
          ENDIF.
*-- begin Grill, MED-44132
        ELSEIF lines( lt_line ) = 1.
          READ TABLE lt_line INTO ls_line INDEX 1.
          ls_corder_x-kaltx = off.
          ls_corder_x-kaltx_x = on.
          ls_corder_x-kanam = ls_line-tdline.
          ls_corder_x-kanam_x = on.
*-- end Grill, MED-44132
        ENDIF. "IF NOT lt_line[] IS INITIAL.

*     xxxxx longtext FRAGE xxxxx
      ELSEIF <ls_mapping>-fieldname = 'FRAGE'.
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
*-- begin Grill, MED-44132
        IF l_longtext = on.
*        IF NOT lt_line[] IS INITIAL AND l_longtext = on.
*-- end Grill, MED-44132
          ls_corder_x-frltx = on.
          ls_corder_x-frltx_x = on.
          CALL METHOD lr_corder->change_text
            EXPORTING
              i_text_id      = cl_ish_corder=>co_text_frage
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
              i_text_id      = cl_ish_corder=>co_text_frage
            IMPORTING
              e_textline     = ls_corder_x-frage
              e_rc           = l_rc
            CHANGING
              c_errorhandler = cr_errorhandler.
          ls_corder_x-frage_x = on.
          IF l_rc <> 0.
            e_rc = l_rc.
            EXIT.
          ENDIF.
*-- begin Grill, MED-44132
        ELSEIF lines( lt_line ) = 1.
          READ TABLE lt_line INTO ls_line INDEX 1.
          ls_corder_x-frltx = off.
          ls_corder_x-frltx_x = on.
          ls_corder_x-frage = ls_line-tdline.
          ls_corder_x-frage_x = on.
*-- end Grill, MED-44132
        ENDIF. "IF NOT lt_line[] IS INITIAL.
      ENDIF. "IF <ls_mapping>-fieldname = 'KANAM'.
    ENDLOOP. "LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
    CHECK e_rc = 0.
  ENDLOOP. "LOOP AT it_mapping ASSIGNING <ls_mapping>
* Change corder data.
  IF NOT ls_corder_x IS INITIAL.
    CALL METHOD lr_corder->change
      EXPORTING
        is_corder_x     = ls_corder_x
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* NDIP = diagnosis *************************************
  CLEAR: lt_ddfields[].
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
    EXPORTING
      i_data_name     = 'RNDIP_ATTRIB'
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  l_index = 0.
  DO.
    l_index = l_index + 1.
    CLEAR: ls_data_ndip.
    LOOP AT it_mapping ASSIGNING <ls_mapping>
        WHERE instno = l_index
          AND compid = l_compid.
      LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
        CLEAR: l_field_supported.
        CHECK <ls_mapping>-fieldname = <ls_ddfield>-fieldname.
        l_field_supported = 'X'.
        CHECK l_field_supported = 'X'.
*       fill changing structure
        CONCATENATE 'LS_DATA_NDIP-' <ls_mapping>-fieldname INTO l_fname.
        ASSIGN (l_fname) TO <fst>.
        <fst> = <ls_mapping>-fvalue.
*       LONGTEXT DITXT
        IF <ls_mapping>-fieldname = 'DITXT'.
*         call method CONVERT_STRING_TO_LONGTEXT
          REFRESH lt_line.
          CLEAR: l_longtext.
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
        ENDIF.
      ENDLOOP. "LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
    ENDLOOP. "LOOP AT it_mapping ASSIGNING <ls_mapping>
    IF sy-subrc <> 0.
      EXIT.
    ELSE.
*     create a new diagnosis
      CALL METHOD cl_ish_prereg_diagnosis=>create
        EXPORTING
          is_data              = ls_data_ndip
          i_environment        = gr_environment
          it_connected_objects = lt_con_obj
        IMPORTING
          e_instance           = lr_diagnosis
        EXCEPTIONS
          missing_environment  = 1
          OTHERS               = 2.
      l_rc = sy-subrc.
*     errorhandling
      IF l_rc <> 0.
        e_rc = l_rc.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
          EXPORTING
            ir_object       = me
          CHANGING
            cr_errorhandler = cr_errorhandler.
        EXIT.
      ENDIF.
      IF NOT lt_line[] IS INITIAL AND l_longtext = on.
        CLEAR: ls_ndipx.
        CALL METHOD lr_diagnosis->change_text
          EXPORTING
            i_text_id      = cl_ish_prereg_diagnosis=>co_text_diltxt
            it_tline       = lt_line
            i_tline_x      = 'X'
          IMPORTING
            e_rc           = l_rc
          CHANGING
            c_errorhandler = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
        ls_ndipx-diltx = on.
        ls_ndipx-diltx_x = on.
*         now get the new first textline
        CALL METHOD lr_diagnosis->get_text_header
          EXPORTING
            i_text_id      = cl_ish_prereg_diagnosis=>co_text_diltxt
          IMPORTING
            e_textline     = ls_ndipx-ditxt
            e_rc           = l_rc
          CHANGING
            c_errorhandler = cr_errorhandler.
        ls_ndipx-ditxt_x = on.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
*       MED-30914 - Begin
**       now change first textline of diagnosis
*        IF <ls_mapping>-instno = 1.
*          ls_ndipx-diklat = on.
*          ls_ndipx-diklat_x = on.
*        ENDIF.
*        CALL METHOD lr_diagnosis->change
*          EXPORTING
*            is_what_to_change = ls_ndipx
*          IMPORTING
*            e_rc              = l_rc
*          CHANGING
*            c_errorhandler    = cr_errorhandler.
*        IF l_rc <> 0.
*          e_rc = l_rc.
*          EXIT.
*        ENDIF.
*       MED-30914 - End
      ENDIF. "IF NOT lt_line[] IS INITIAL.
    ENDIF.
  ENDDO.
  CHECK e_rc = 0.
* ED, ID 16882 -> END

ENDMETHOD.


METHOD prealloc_internal.

* Christian Söldner - 23.08.2004 - 15142 - Method redefined.

  DATA: lr_corder             TYPE REF TO cl_ish_corder,
        ls_corder_x           TYPE rn1_corder_x,
        ls_npat               TYPE npat.
  DATA: ls_n1corder           TYPE n1corder,
        l_gschl               TYPE npat-gschl,
        ls_pap_data           TYPE rnpap_attrib,
        l_rc                  TYPE ish_method_rc.

* only if g_vcode = co_vcode_insert
  CHECK g_vcode = co_vcode_insert.

* Set the g_prealloc_done flag.
  g_prealloc_done = 'X'.

* Get the corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get the corder data.
  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Prealloc only if schwo/schwkz are initial.
  CHECK ls_n1corder-schwo  IS INITIAL.
  CHECK ls_n1corder-schwkz IS INITIAL.

* Get the patient's sex.
  CLEAR l_gschl.
  CASE ls_n1corder-reftyp.
    WHEN cl_ish_corder=>co_reftyp_pat.
*     Get sex from real patient.
      IF NOT ls_n1corder-patnr IS INITIAL.
        CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
          EXPORTING
            i_patnr     = ls_n1corder-patnr
            i_read_db   = on
            i_no_buffer = on
          IMPORTING
            e_rc        = l_rc
            es_npat     = ls_npat.
        IF l_rc = 0.
          l_gschl = ls_npat-gschl.
        ENDIF.
      ENDIF.
    WHEN OTHERS.
*     Get sex from patient provisional.
      CALL METHOD lr_corder->get_patient_provisional
        EXPORTING
          ir_environment  = gr_environment
        IMPORTING
          es_pap_data     = ls_pap_data
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
      IF NOT ls_pap_data-gschle IS INITIAL.
        CALL FUNCTION 'ISH_CONVERT_SEX_INPUT'
          EXPORTING
            ss_gschle = ls_pap_data-gschle
          IMPORTING
            ss_gschl  = l_gschl
          EXCEPTIONS
            not_found = 1
            OTHERS    = 2.
        l_rc = sy-subrc.
        IF l_rc <> 0.
          CLEAR l_gschl.
        ENDIF.
      ENDIF.
  ENDCASE.

* Modify schwkz depending on l_gschl.
  CASE l_gschl.
    WHEN 1.
      ls_corder_x-schwkz = 'N'.  "Grill, ID-17243
      ls_corder_x-schwkz_x = on. "Grill, ID-17243
*      EXIT.                     "Grill, ID-17243
    WHEN OTHERS.
*     Female or unknown sex -> schwkz is always unknown.
      ls_corder_x-schwkz   = space. "Grill, ID-18007
*      ls_corder_x-schwkz   = 'U'.  "Grill, ID-18007
      ls_corder_x-schwkz_x = on.
  ENDCASE.

* Change corder data.
  CALL METHOD lr_corder->change
    EXPORTING
      is_corder_x     = ls_corder_x
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD transport_from_screen_internal.

  DATA: lr_scr_med_data  TYPE REF TO cl_ish_scr_med_data.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_med_data=>co_otype_scr_med_data ) = on.
    lr_scr_med_data ?= ir_screen.
    CALL METHOD trans_from_scr_med_data
      EXPORTING
        ir_scr_med_data = lr_scr_med_data
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD transport_to_screen_internal.

  DATA: lr_scr_med_data  TYPE REF TO cl_ish_scr_med_data.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_med_data=>co_otype_scr_med_data ) = on.
    lr_scr_med_data ?= ir_screen.
    CALL METHOD trans_to_scr_med_data
      EXPORTING
        ir_scr_med_data = lr_scr_med_data
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_corder_from_scr_med_data .

  DATA: lt_field_val    TYPE ish_t_field_value,
        ls_corder_x     TYPE rn1_corder_x,
        ls_npat         TYPE npat.

* Christian Söldner, 23.08.2004, ID 15142   START
  DATA: ls_n1corder           TYPE n1corder,
        l_gschl               TYPE npat-gschl,
        ls_pap_data           TYPE rnpap_attrib,
        l_rc                  TYPE ish_method_rc.
* Christian Söldner, 23.08.2004, ID 15142   END

  FIELD-SYMBOLS: <ls_field_val>  TYPE rnfield_value.
  FIELD-SYMBOLS: <ls_field_val_copy>  TYPE rnfield_value.

  CHECK NOT ir_corder    IS INITIAL.
  CHECK NOT ir_scr_med_data IS INITIAL.

* Get screen values.
  CALL METHOD ir_scr_med_data->get_fields
    IMPORTING
      et_field_values = lt_field_val
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Fill ls_corder_x.
  LOOP AT lt_field_val ASSIGNING <ls_field_val>.
    CASE <ls_field_val>-fieldname.
      WHEN ir_scr_med_data->g_fieldname_kanam.
        ls_corder_x-kanam   = <ls_field_val>-value.
        ls_corder_x-kanam_x = on.
      WHEN ir_scr_med_data->g_fieldname_schwkz.
        ls_corder_x-schwkz   = <ls_field_val>-value.
        ls_corder_x-schwkz_x = on.
      WHEN ir_scr_med_data->g_fieldname_schwo.
*        READ TABLE lt_field_val ASSIGNING <ls_field_val_copy>
*           WITH KEY fieldname =
*                          ir_scr_med_data->g_fieldname_schwkz.
*        CHECK sy-subrc EQ 0.
*        IF <ls_field_val_copy>-value = off. "male
*          CLEAR <ls_field_val>-value.
*        ENDIF.
        ls_corder_x-schwo   = <ls_field_val>-value.
        ls_corder_x-schwo_x = on.
*       if schwo not initial then set pregnant YES
        IF NOT ls_corder_x-schwo IS INITIAL.
          ls_corder_x-schwkz = on.     " yes
          ls_corder_x-schwkz_x = on.
        ENDIF.
      WHEN ir_scr_med_data->g_fieldname_ifg.
        ls_corder_x-ifg   = <ls_field_val>-value.
        ls_corder_x-ifg_x = on.
      WHEN ir_scr_med_data->g_fieldname_ditxt.
*        ls_corder_x-ditxt   = <ls_field_val>-value.
*        ls_corder_x-ditxt_x = on.
*        CHECK NOT <ls_field_val>-value IS INITIAL.  "MED-42226
        CALL METHOD me->create_diagnosis
          EXPORTING
            ir_corder       = ir_corder
            i_field_value   = <ls_field_val>-value
          IMPORTING
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
*      WHEN ir_scr_med_data->g_fieldname_n1kaltxt.
*        ls_corder_x-n1kaltxt   = <ls_field_val>-value.
*        ls_corder_x-n1kaltxt_x = on.
*      WHEN ir_scr_med_data->g_fieldname_n1diltxt.
*        ls_corder_x-n1diltxt   = <ls_field_val>-value.
*        ls_corder_x-n1diltxt_x = on.
      WHEN ir_scr_med_data->g_fieldname_frage.
        ls_corder_x-frage   = <ls_field_val>-value.
        ls_corder_x-frage_x = on.
*      WHEN ir_scr_med_data->g_fieldname_n1frltxt.
*        ls_corder_x-n1frltxt   = <ls_field_val>-value.
*        ls_corder_x-n1frltxt_x = on.
    ENDCASE.
  ENDLOOP.

* Christian Söldner, 23.08.2004, ID 15142   START
* Special handling of schwkz and schwo depending on the patient's sex.

* Get the corder data.
  CALL METHOD ir_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get the patient's sex.
  CLEAR l_gschl.
  CASE ls_n1corder-reftyp.
    WHEN cl_ish_corder=>co_reftyp_pat.
*     Get sex from real patient.
      IF NOT ls_n1corder-patnr IS INITIAL.
        CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
          EXPORTING
            i_patnr     = ls_n1corder-patnr
            i_read_db   = on
            i_no_buffer = on
          IMPORTING
            e_rc        = l_rc
            es_npat     = ls_npat.
        IF l_rc = 0.
          l_gschl = ls_npat-gschl.
        ENDIF.
      ENDIF.
    WHEN OTHERS.
*     Get sex from patient provisional.
      CALL METHOD ir_corder->get_patient_provisional
        EXPORTING
          ir_environment  = gr_environment
        IMPORTING
          es_pap_data     = ls_pap_data
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
      IF NOT ls_pap_data-gschle IS INITIAL.
        CALL FUNCTION 'ISH_CONVERT_SEX_INPUT'
          EXPORTING
            ss_gschle = ls_pap_data-gschle
          IMPORTING
            ss_gschl  = l_gschl
          EXCEPTIONS
            not_found = 1
            OTHERS    = 2.
        l_rc = sy-subrc.
        IF l_rc <> 0.
          CLEAR l_gschl.
        ENDIF.
      ENDIF.
  ENDCASE.

* Modify schwkz/schwo depending on l_gschl.
  CASE l_gschl.
    WHEN 1.
*     Male patient -> no schwkz/schwo.
*     ls_corder_x-schwkz   = off. "Grill, ID-17243
      ls_corder_x-schwkz   = 'N'. "Grill, ID-17243
      ls_corder_x-schwkz_x = on.
      CLEAR ls_corder_x-schwo.
      ls_corder_x-schwo_x = on.
    WHEN OTHERS.
*     Female or unknown sex -> handle schwkz depending on schwo.
      IF ls_n1corder-schwkz <> on.
        IF NOT ls_n1corder-schwo IS INITIAL AND
           NOT ls_n1corder-schwo = space.
          ls_corder_x-schwkz   = on.
          ls_corder_x-schwkz_x = on.
        ENDIF.
      ENDIF.
  ENDCASE.

* Christian Söldner, 23.08.2004, ID 15142   END

* Change corder data.
  CALL METHOD ir_corder->change
    EXPORTING
      is_corder_x     = ls_corder_x
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD trans_corder_to_scr_med_data .

  TYPES: BEGIN OF lty_leist,
             sign(1)   TYPE c,
             option(2) TYPE c,
             low       TYPE nlei-leist,
             high      TYPE nlei-leist,
         END OF lty_leist.

  DATA: ls_n1corder           TYPE n1corder,
        ls_field_val          TYPE rnfield_value,
        lt_field_val          TYPE ish_t_field_value,
        l_einri               TYPE tn01-einri,
        l_ifg                 TYPE n1ifg-ifg,
        lr_anchor_service     TYPE REF TO cl_ishmed_service,
        ls_nlei               TYPE nlei,
        ls_nlem               TYPE nlem,
        ls_leist              TYPE lty_leist,
        lt_leist              TYPE RANGE OF nlei-leist,
        l_gtarif              TYPE n1tpm-tarif,
        ls_n1tpm              TYPE n1tpm,
        lt_nlei               TYPE ishmed_t_vnlei,
        lt_cordpos            TYPE ish_t_cordpos,
        lr_cordpos            TYPE REF TO cl_ishmed_prereg,
*       Christian Söldner, 23.08.2004, ID 15142   START
*       Not needed.
*        l_gschl               TYPE npat-gschl,
*        ls_pap_data           TYPE rnpap_attrib,
*       Christian Söldner, 23.08.2004, ID 15142   END
        l_rc                  TYPE ish_method_rc,
        l_new                 TYPE ish_on_off,
        l_fld_not_found       TYPE ish_on_off,
        lt_diagnosis          TYPE ish_objectlist,
        ls_object             TYPE ish_object,
        lr_diagnosis          TYPE REF TO cl_ish_prereg_diagnosis,
        ls_data_diag          TYPE rndip_attrib,
        lr_corder             TYPE REF TO cl_ish_corder.    "ID-15970

  CHECK NOT ir_corder    IS INITIAL.
  CHECK NOT ir_scr_med_data IS INITIAL.

*-- Begin Grill, ID-15970
  CALL METHOD ir_corder->fill_ifg
    IMPORTING
      e_rc            = l_rc
      e_ifg           = l_ifg
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK l_rc EQ 0.
*-- End Grill, ID-15970

** Get corder data.
  CALL METHOD ir_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

*    l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object )
*.
*    IF l_einri IS INITIAL.
*      EXIT.
*    ENDIF.
*
*    IF ls_n1corder-ifg IS INITIAL.        "Käfer, ID: 14520
** select the ifg-flag from services only when the field is not
** set for the current order
**   get all cordpos
*      CALL METHOD ir_corder->get_t_cordpos
*        EXPORTING
*          ir_environment  = gr_environment
*        IMPORTING
*          et_cordpos      = lt_cordpos
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      CHECK e_rc = 0.
*
*      LOOP AT lt_cordpos INTO lr_cordpos.
**     Get op main anchor service
*        CALL METHOD lr_cordpos->get_op_main_anchor_srv
*          IMPORTING
*            er_anchor_service = lr_anchor_service
*            e_rc              = e_rc
*          CHANGING
*            cr_errorhandler   = cr_errorhandler.
*        CHECK e_rc = 0.
*
**     Get anchor_service's data.
*        CLEAR ls_nlem.
*        IF NOT lr_anchor_service IS INITIAL.
*          CALL METHOD lr_anchor_service->get_data
*            IMPORTING
*              e_rc           = e_rc
*              e_nlem         = ls_nlem
*              e_nlei         = ls_nlei
*            CHANGING
*              c_errorhandler = cr_errorhandler.
*          CHECK e_rc = 0.
*        ENDIF.
*        IF NOT ls_nlei-leist IS INITIAL.
*          ls_leist-sign = 'I'.
*          ls_leist-option = 'EQ'.
*          ls_leist-low = ls_nlei-leist.
*          APPEND ls_leist TO lt_leist.
*        ENDIF.
*
***     if a service or the anchor service of the operation has the kz
***     IFG "septisch", then set it on field IFG!!
**     first get all services from the main object -> prereg
*        CALL METHOD cl_ishmed_prereg=>get_services_for_prereg
*          EXPORTING
*            i_prereg       = lr_cordpos
*            i_environment  = gr_environment
*          IMPORTING
*            e_rc           = e_rc
*            et_nlei        = lt_nlei
*          CHANGING
*            c_errorhandler = cr_errorhandler.
*        CHECK e_rc = 0.
*
**     now get the n1tpm-data from the services
**     read the tarif first
**     ground tarif
*        CALL FUNCTION 'ISH_TN00Q_READ'
*          EXPORTING
*            ss_einri  = l_einri
*            ss_param  = 'GTARIF'
*            ss_date   = sy-datum
*            ss_alpha  = 'X'
*          IMPORTING
*            ss_value  = l_gtarif
*          EXCEPTIONS
*            not_found = 1
*            OTHERS    = 2.
*        e_rc = sy-subrc.
*        CHECK sy-subrc EQ 0.
*        IF NOT lt_nlei[] IS INITIAL.
*          SORT lt_nlei BY einri falnr orgid leist.
*          DELETE ADJACENT DUPLICATES FROM lt_nlei
*             COMPARING einri falnr orgid leist.
*          ls_leist-sign = 'I'.
*          ls_leist-option = 'EQ'.
*          LOOP AT lt_nlei INTO ls_nlei.
*            ls_leist-low = ls_nlei-leist.
*            APPEND ls_leist TO lt_leist.
*          ENDLOOP.
*        ENDIF.
*      ENDLOOP.
**   now read the n1tpm entries
*      IF NOT lt_leist[] IS INITIAL.
**     Käfer, ID: 14520 - Begin
**     get the highest value for IFG and put this one
**     into structure for corder
*        DELETE ADJACENT DUPLICATES FROM lt_leist
*            COMPARING sign option low.
*
*        CLEAR l_ifg.
*
*        SELECT MAX( ifg ) FROM n1tpm INTO l_ifg
*          WHERE einri = l_einri
*            AND tarif = l_gtarif
*            AND talst IN lt_leist.
*
*        ls_n1corder-ifg = l_ifg.
***   now read the IFG
**    SELECT ifg FROM n1ifg INTO l_ifg
**      WHERE einri = l_einri
**        AND ifge  = 'SEP'.
**    ENDSELECT.
**    e_rc = sy-subrc.
**    CHECK e_rc = 0.
**    CLEAR ls_n1tpm.
**    SORT lt_leist BY sign option low.
**    DELETE ADJACENT DUPLICATES FROM lt_leist
**       COMPARING sign option low.
**    SELECT SINGLE * FROM n1tpm INTO ls_n1tpm
**      WHERE einri = l_einri
**        AND tarif = l_gtarif
**        AND talst IN lt_leist
**        AND ifg = l_ifg.
**    IF sy-subrc EQ 0.
**      ls_n1corder-ifg = l_ifg.
**    ENDIF.
**   Käfer, ID: 14520 - End
*      ENDIF.
*    ENDIF.                              "Käfer, ID: 14520
*-- End Grill, ID-15970

* Christian Söldner, 23.08.2004, ID 15142   START
* The following coding has to be processed at pai (not pbo).
* See trans_corder_from_scr_med_data.
** SCHWKZ -> if patient is female, then handle it
*  CALL METHOD ir_corder->is_new
*    IMPORTING
*      e_new = l_new.
*  IF l_new = on. "only for new corders
*    IF NOT ls_n1corder-patnr IS INITIAL.
*      SELECT gschl FROM npat INTO l_gschl
*        WHERE patnr = ls_n1corder-patnr.
*      ENDSELECT.
*    ELSE.
*      CALL METHOD ir_corder->get_patient_provisional
*        EXPORTING
*          ir_environment  = gr_environment
*        IMPORTING
*          es_pap_data     = ls_pap_data
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      CHECK e_rc = 0.
*      IF NOT ls_pap_data-gschle IS INITIAL.
*        CALL FUNCTION 'ISH_CONVERT_SEX_INPUT'
*          EXPORTING
*            ss_gschle = ls_pap_data-gschle
*          IMPORTING
*            ss_gschl  = l_gschl
*          EXCEPTIONS
*            not_found = 1
*            OTHERS    = 2.
*        l_rc = sy-subrc.
*        IF l_rc <> 0.
*          CLEAR l_gschl.
*        ENDIF.
*      ELSE. "if no sex in patient provisional
*        IF ls_n1corder-schwo IS INITIAL OR
*           ls_n1corder-schwo = off.
*          ls_n1corder-schwkz = 'U'. "unknown
*        ELSE.
*          ls_n1corder-schwkz = on.
*        ENDIF.
*      ENDIF.
*    ENDIF.
*    IF NOT l_gschl IS INITIAL.
*      CASE l_gschl.
*        WHEN 1. "male
*          ls_n1corder-schwkz = off.
*          CLEAR ls_n1corder-schwo.
*        WHEN OTHERS.
**         if schwo is not initial, then schwkz is on -> pregnant
*          IF ls_n1corder-schwo IS INITIAL OR
*             ls_n1corder-schwo = off.
*            ls_n1corder-schwkz = 'U'. "unknown
*          ELSE.
*            ls_n1corder-schwkz = on.
*          ENDIF.
*      ENDCASE.
*    ELSE.
*      IF ls_n1corder-schwo IS INITIAL OR
*         ls_n1corder-schwo = off.
*        ls_n1corder-schwkz = 'U'. "unknown
*      ELSE.
*        ls_n1corder-schwkz = on.
*      ENDIF.
*    ENDIF.
*  ENDIF.
* Christian Söldner, 23.08.2004, ID 15142   END

* Build field values.
  CLEAR lt_field_val.

* KANAM
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_med_data=>g_fieldname_kanam.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1corder-kanam.
  INSERT ls_field_val INTO TABLE lt_field_val.

* SCHWKZ
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_med_data=>g_fieldname_schwkz.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1corder-schwkz.
  INSERT ls_field_val INTO TABLE lt_field_val.

* SCHWO
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_med_data=>g_fieldname_schwo.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1corder-schwo.
  INSERT ls_field_val INTO TABLE lt_field_val.

* IFG
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_med_data=>g_fieldname_ifg.
  ls_field_val-type      = co_fvtype_single.
* MED-30413 - Begin
* if variable l_ifg is initial ('00' - numeric) clear fieldvalue-value (char)
* if the field is marked as an obligatory field the check will not catch the initial
* value
  IF l_ifg IS INITIAL.
    CLEAR ls_field_val-value.
  ELSE.
    ls_field_val-value     = l_ifg.            "Grill, ID-15970
  ENDIF.
* MED-30413 - End
  INSERT ls_field_val INTO TABLE lt_field_val.

* DITXT
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_med_data=>g_fieldname_ditxt.
  ls_field_val-type      = co_fvtype_single.
*  ls_field_val-value     = ls_n1corder-ditxt.
* Get corder's diagnosis objects.
  CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
    EXPORTING
*      I_CANCELLED_DATAS = OFF
      ir_corder         = ir_corder
      ir_environment    = gr_environment
    IMPORTING
      e_rc              = e_rc
      et_diagnosis      = lt_diagnosis
*      ET_NDIP           = lt_ndip
    CHANGING
      cr_errorhandler   = cr_errorhandler.
* Get ditxt of diagnosis.
  LOOP AT lt_diagnosis INTO ls_object.
    lr_diagnosis ?= ls_object-object.
    CHECK NOT lr_diagnosis IS INITIAL.
    CALL METHOD lr_diagnosis->get_data
      IMPORTING
        es_data        = ls_data_diag
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    CHECK l_rc = 0.
    CHECK ls_data_diag-diklat = on.
    ls_field_val-value = ls_data_diag-ditxt.
    EXIT.
  ENDLOOP.
  INSERT ls_field_val INTO TABLE lt_field_val.

* FRAGE
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_med_data=>g_fieldname_frage.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1corder-frage.
  INSERT ls_field_val INTO TABLE lt_field_val.

* Set main object in med data screen.
  CALL METHOD ir_scr_med_data->set_data
    EXPORTING
      i_main_object   = ir_corder
      i_main_object_x = on
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.
* Set field values in med data screen.
  CALL METHOD ir_scr_med_data->set_fields
    EXPORTING
      it_field_values  = lt_field_val
      i_field_values_x = on
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD trans_from_scr_med_data .

  DATA: lr_corder  TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object  IS INITIAL.
  CHECK NOT ir_scr_med_data    IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ishmed_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD trans_corder_from_scr_med_data
      EXPORTING
        ir_corder       = lr_corder
        ir_scr_med_data = ir_scr_med_data
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_to_scr_med_data .

  DATA: lr_corder  TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object  IS INITIAL.
  CHECK NOT ir_scr_med_data    IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ishmed_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD trans_corder_to_scr_med_data
      EXPORTING
        ir_corder       = lr_corder
        ir_scr_med_data = ir_scr_med_data
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.
ENDCLASS.
