class CL_ISH_COMP_ADMISSION definition
  public
  inheriting from CL_ISH_COMPONENT_STD
  create public .

*"* public components of class CL_ISH_COMP_ADMISSION
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_COMP_ADMISSION type ISH_OBJECT_TYPE value 8003 ##NO_TEXT.

  methods GET_CORDPOS
    returning
      value(RR_CORDPOS) type ref to CL_ISHMED_PREREG .
  methods CONSTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .
  methods CHECK_BEKAT_FOR_PVPAT
    importing
      !I_EINRI type EINRI
      !I_BEKAT type BEKAT
    exporting
      !E_PVPAT type N1PVPAT .

  methods IF_ISH_COMPONENT~CANCEL
    redefinition .
  methods IF_ISH_COMPONENT~IS_EMPTY
    redefinition .
  methods IF_ISH_COMPONENT~SET_DATA_FROM_EXTERNAL
    redefinition .
  methods IF_ISH_DOM~MODIFY_DOM_DATA
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMP_ADMISSION
*"* do not include other source files here!!!

  class-data GT_CDOC_FIELD type ISH_T_CDOC_FIELD .
  class-data GT_PRINT_FIELD type ISH_T_PRINT_FIELD .

  methods TRANS_CORDPOS_FROM_SCR_ADMIS
    importing
      !IR_CORDPOS type ref to CL_ISHMED_PREREG
      !IR_SCR_ADMIS type ref to CL_ISH_SCR_ADMISSION
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_CORDPOS_TO_SCR_ADMIS
    importing
      !IR_CORDPOS type ref to CL_ISHMED_PREREG
      !IR_SCR_ADMIS type ref to CL_ISH_SCR_ADMISSION
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_FROM_SCR_ADMIS
    importing
      !IR_SCR_ADMIS type ref to CL_ISH_SCR_ADMISSION
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_TO_SCR_ADMIS
    importing
      !IR_SCR_ADMIS type ref to CL_ISH_SCR_ADMISSION
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

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
*"* private components of class CL_ISH_COMP_ADMISSION
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMP_ADMISSION IMPLEMENTATION.


  METHOD check_bekat_for_pvpat.
* Sergiu Popa, 27.10.2014, IXX-153

    DATA: lt_tn24f  TYPE STANDARD TABLE OF tn24f,
          l_cvers   TYPE tn00-cvers,
          lr_klfart TYPE RANGE OF nfkl-klfart,
          lr_klftyp TYPE RANGE OF nfkl-klftyp.

    e_pvpat = off.

* read KLFTYP and KLFARTen (they title the private patient)
    CALL FUNCTION 'ISH_COUNTRY_VERSION_GET'
      IMPORTING
        ss_cvers = l_cvers.
    REFRESH lr_klfart.
    CALL FUNCTION 'ISH_KLTYP_KLART_PRIVATPAT'
      EXPORTING
        i_cvers     = l_cvers
      TABLES
        rtab_klftyp = lr_klftyp
        rtab_klfart = lr_klfart.
    REFRESH lt_tn24f.
    SELECT * FROM tn24f INTO TABLE lt_tn24f
             WHERE einri  =  i_einri
             AND   bekat  =  i_bekat
             AND   klftyp IN lr_klftyp
             AND   klfart IN lr_klfart.
    IF sy-subrc = 0.
      e_pvpat = on.
    ENDIF.

  ENDMETHOD.


METHOD class_constructor .

  DATA: l_cdoc_field  TYPE rn1_cdoc_field,
        l_print_field TYPE rn1_print_field,
        l_fieldname   TYPE string,
        lt_fieldname  TYPE ish_t_string.

  CLEAR: gt_cdoc_field[],
         gt_print_field[].


* Build table for cdoc.

* N1VKG
  CLEAR: l_cdoc_field,
         lt_fieldname[].
  l_cdoc_field-objecttype  = cl_ishmed_prereg=>co_otype_prereg.
  l_cdoc_field-tabname     = 'N1VKG'.

  l_fieldname              = 'FALAR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'BEWAR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'BEKAT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'FATYP'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.


* Build table for print.

* N1VKG
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  = cl_ishmed_prereg=>co_otype_prereg.
  l_print_field-tabname     = 'N1VKG'.

  l_fieldname              = 'FALAR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'BEWAR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'BEKAT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'FATYP'.
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


METHOD get_cordpos .

  CLEAR rr_cordpos.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ishmed_prereg=>co_otype_prereg ) = on.

  rr_cordpos ?= gr_main_object.

ENDMETHOD.


METHOD if_ish_component~cancel.

* Michael Manoch, 13.07.2004, ID 14907
* New method.

  DATA: lr_cordpos     TYPE REF TO cl_ishmed_prereg,
        ls_n1vkg_x     TYPE rn1med_prereg,
        l_cancelled    TYPE ish_on_off.

* Do not process in check-only mode.
  CHECK i_check_only = off.

* Get the cordpos object.
  lr_cordpos = get_cordpos( ).
  CHECK NOT lr_cordpos IS INITIAL.

* Do not process cancelled cordpos objects.
  CALL METHOD lr_cordpos->is_cancelled
    IMPORTING
      e_cancelled = l_cancelled.
  CHECK l_cancelled = off.

* Clear the component's data from the cordpos.

* Build the changing structure.
  CLEAR ls_n1vkg_x.
  ls_n1vkg_x-falar_x = on.
  ls_n1vkg_x-bewar_x = on.
  ls_n1vkg_x-bekat_x = on.
  ls_n1vkg_x-pvpat_x = on.

* Change cordpos data.
  CALL METHOD lr_cordpos->change
    EXPORTING
      i_prereg       = ls_n1vkg_x
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_component~is_empty.

* Michael Manoch, 13.07.2004, ID 14907
* New method.

  DATA: lr_cordpos  TYPE REF TO cl_ishmed_prereg,
        ls_n1vkg    TYPE n1vkg,
        l_rc        TYPE ish_method_rc.

* Call super method.
  r_empty = super->if_ish_component~is_empty( ).

* Further processing only if super method returns ON.
  CHECK r_empty = on.

* Check the cordpos fields.
  r_empty = off.

* Get cordpos object.
  lr_cordpos = get_cordpos( ).
  CHECK NOT lr_cordpos IS INITIAL.

* Get cordpos data.
  CALL METHOD lr_cordpos->get_data
    IMPORTING
      e_rc    = l_rc
      e_n1vkg = ls_n1vkg.
* On error -> self is not empty.
  CHECK l_rc = 0.

* If one of the component fields is not empty -> self is not empty.
  CHECK ls_n1vkg-falar IS INITIAL.
  CHECK ls_n1vkg-bewar IS INITIAL.
  CHECK ls_n1vkg-bekat IS INITIAL.
  CHECK ls_n1vkg-pvpat IS INITIAL.

* Self is empty.
  r_empty = on.

ENDMETHOD.


  METHOD if_ish_component~set_data_from_external.

    DATA: lr_cordpos      TYPE REF TO cl_ishmed_prereg,
          lr_errorhandler TYPE REF TO cl_ishmed_errorhandling,

          ls_n1vkg        TYPE n1vkg,
          ls_prereg       TYPE rn1med_prereg,

          l_rc            TYPE ish_method_rc,
          l_pvpat         TYPE n1pvpat.

    FIELD-SYMBOLS : <fs_comp_data> TYPE rn1_comp_external_data,

                    <fs_falar>     TYPE fallart,
                    <fs_fatyp>     TYPE ish_casetype,
                    <fs_bewar>     TYPE ri_bwart,
                    <fs_bekat>     TYPE bekat.



*   Get the cordpos.
    lr_cordpos = get_cordpos( ).

    IF lr_cordpos IS BOUND.
*     Get cordpos data.
      CALL METHOD lr_cordpos->get_data
        IMPORTING
          e_rc           = l_rc
          e_n1vkg        = ls_n1vkg
        CHANGING
          c_errorhandler = lr_errorhandler.
      IF l_rc NE 0.
        RAISE EXCEPTION TYPE cx_ish_static_handler
          EXPORTING
            gr_errorhandler = lr_errorhandler.

      ENDIF.

*     Case type
      READ TABLE it_comp_data WITH KEY fieldname = 'SC_LB_FALAR' ASSIGNING <fs_comp_data>.
      IF sy-subrc EQ 0.
        ASSIGN <fs_comp_data>-value->* TO <fs_falar> CASTING.
        IF <fs_falar> IS ASSIGNED AND <fs_falar> <> ls_n1vkg-falar.
          ls_prereg-falar   = <fs_falar>.
          ls_prereg-falar_x = abap_true.
        ENDIF.
      ENDIF.

*     Case category
      READ TABLE it_comp_data WITH KEY fieldname = 'SC_LB_FATYP' ASSIGNING <fs_comp_data>.
      IF sy-subrc EQ 0.
        ASSIGN <fs_comp_data>-value->* TO <fs_fatyp> CASTING.
        IF <fs_fatyp> IS ASSIGNED AND <fs_fatyp> <> ls_n1vkg-fatyp.
          ls_prereg-fatyp   = <fs_fatyp>.
          ls_prereg-fatyp_x = abap_true.
        ENDIF.
      ENDIF.

*     Movement Type
      READ TABLE it_comp_data WITH KEY fieldname = 'SC_LB_BEWAR' ASSIGNING <fs_comp_data>.
      IF sy-subrc EQ 0.
        ASSIGN <fs_comp_data>-value->* TO <fs_bewar> CASTING.
        IF <fs_bewar> IS ASSIGNED AND <fs_bewar> <> ls_n1vkg-bewar.
          ls_prereg-bewar   = <fs_bewar>.
          ls_prereg-bewar_x = abap_true.
        ENDIF.
      ENDIF.

*     Treatment Category
      READ TABLE it_comp_data WITH KEY fieldname = 'RN1_DYNP_ADMISSION-BEKAT' ASSIGNING <fs_comp_data>.
      IF sy-subrc EQ 0.
        ASSIGN <fs_comp_data>-value->* TO <fs_bekat> CASTING.
        IF <fs_bekat> IS ASSIGNED AND <fs_bekat> <> ls_n1vkg-bekat.
          ls_prereg-bekat   = <fs_bekat>.
          ls_prereg-bekat_x = abap_true.
        ENDIF.
      ENDIF.


*   Handle pvpat.
      IF ls_prereg-bekat_x = abap_true AND
         ls_prereg-bekat IS NOT INITIAL.

        check_bekat_for_pvpat(
          EXPORTING
            i_einri = ls_n1vkg-einri
            i_bekat = ls_prereg-bekat
          IMPORTING
            e_pvpat = l_pvpat  ).

        IF l_pvpat NE ls_n1vkg-pvpat.
          ls_prereg-pvpat   = l_pvpat.
          ls_prereg-pvpat_x = abap_true.
        ENDIF.

      ENDIF.

*   Process only on changes.
      IF  ls_prereg IS NOT INITIAL.
*     Change cordpos data.
        CALL METHOD lr_cordpos->change
          EXPORTING
            i_prereg       = ls_prereg
          IMPORTING
            e_rc           = l_rc
          CHANGING
            c_errorhandler = lr_errorhandler.
        IF l_rc <> 0.
          RAISE EXCEPTION TYPE cx_ish_static_handler
            EXPORTING
              gr_errorhandler = lr_errorhandler.

        ENDIF.

      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD if_ish_dom~modify_dom_data.

  DATA: lr_document_fragment  TYPE REF TO if_ixml_document_fragment,
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
        l_bewty               TYPE bewty,
        l_bwart               TYPE ri_bwart,
        l_bwatx               TYPE bewartxt,
        l_bekat               TYPE bekat,
        l_bktxt               TYPE bk_bktxt,
        l_casety              TYPE tn15c-casety,
        l_casetx              TYPE tn15s-casetx,
        l_einri               TYPE tn01-einri,
        l_rc                  TYPE i,
        lt_dd07t              TYPE TABLE OF dd07t.
  FIELD-SYMBOLS: <ls_dd07t>   TYPE dd07t.

  e_rc = 0.

* No document => no action.
  CHECK NOT cr_document_fragment IS INITIAL.

* Check/create errorhandler.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Document to local data.
  lr_document_fragment = cr_document_fragment.

* Get ROOT NODE.
  CALL METHOD lr_document_fragment->get_root
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
*       Get NAME attribute.
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
*           FALAR.
            WHEN 'FALAR'.
*             Read from db.
              SELECT *
                FROM dd07t
                INTO TABLE lt_dd07t
                WHERE domname    = 'FALLART'
                  AND ddlanguage =  sy-langu.
*             Get text.
              LOOP AT lt_dd07t ASSIGNING <ls_dd07t>.
                IF l_string_el_value  = <ls_dd07t>-domvalue_l.
                  l_string_el_value = <ls_dd07t>-ddtext.
                ENDIF.
              ENDLOOP.
*             Modify value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           FATYP.
            WHEN 'FATYP'.
*             Get institution.
              l_einri =
              cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
              IF l_einri IS INITIAL.
                EXIT.
              ENDIF.
*             Get text.
              l_casety = l_string_el_value.
              CALL FUNCTION 'ISH_CASETY_CHECK'
                EXPORTING
                  ss_einri  = l_einri
                  ss_casety = l_casety
                IMPORTING
                  ss_casetx = l_casetx
                EXCEPTIONS
                  not_found = 1
                  OTHERS    = 2.
              IF sy-subrc = 0.
                l_string_el_value = l_casetx.
              ENDIF.
*             Modify value in DOM node
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           BEWAR.
            WHEN 'BEWAR'.
*             Get institution.
              l_einri =
              cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
              IF l_einri IS INITIAL.
                EXIT.
              ENDIF.
*             Get text.
              l_bewty = '1'.                         "admission
              l_bwart = l_string_el_value.
              CALL FUNCTION 'ISH_BWART_CHECK'
                EXPORTING
                  ss_einri        = l_einri
                  ss_bewty        = l_bewty
                  ss_bwart        = l_bwart
                  ss_langu        = sy-langu
*                  SS_DATUM        = '00000000'
                IMPORTING
                  ss_bwatx        = l_bwatx
*                  ss_tn14b        =
*                  SS_DEAD         =
*                  SS_BWGR1        =
*                  SS_BWGR2        =
               EXCEPTIONS
                 not_found       = 1
                 OTHERS          = 2.
              IF sy-subrc = 0.
                l_string_el_value = l_bwatx.
              ENDIF.
*             Modify value in DOM node
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           BEKAT.
            WHEN 'BEKAT'.
*             Get institution.
              l_einri =
              cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
              IF l_einri IS INITIAL.
                EXIT.
              ENDIF.
*             Get text.
              l_bekat = l_string_el_value.
              CALL METHOD cl_ish_utl_base_descr=>get_descr_bekat
                EXPORTING
                  i_einri         = l_einri
                  i_bekat         = l_bekat
                IMPORTING
                  e_rc            = l_rc
                  e_bktxt         = l_bktxt
                CHANGING
                  cr_errorhandler = cr_errorhandler.
              IF l_rc = 0.
                l_string_el_value = l_bktxt.
              ENDIF.
*             Modify value in DOM node
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
            WHEN OTHERS.
          ENDCASE.
        ENDIF.  "NAME
      ENDIF.  "attributes
    ENDIF.  "COMPELEMENT

*   Get next COMPELEMENT
    lr_node = lr_node_iterator->get_next( ).
  ENDWHILE.

* Return modified document
  cr_document_fragment = lr_document_fragment.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_comp_admission.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_comp_admission.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD initialize_methods .

* initialize methods.

ENDMETHOD.


METHOD initialize_screens.

  DATA: lr_scr_admis  TYPE REF TO cl_ish_scr_admission.

* screen admission
  CALL METHOD cl_ish_scr_admission=>create
    IMPORTING
      er_instance     = lr_scr_admis
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  APPEND lr_scr_admis TO gt_screen_objects.

ENDMETHOD.


METHOD prealloc_from_external_int.

* ED, ID 16882 -> BEGIN
  DATA: lt_ddfields       TYPE ddfields,
        l_rc              TYPE ish_method_rc,
        lr_cordpos        TYPE REF TO cl_ishmed_prereg,
        l_field_supported TYPE c,
        l_value           TYPE nfvvalue,
        ls_data           TYPE rn1med_prereg,
        l_fname           TYPE string,
        l_compid          TYPE n1comp-compid,
        l_index           TYPE i,
        l_posnr           TYPE n1cordposnr.

  FIELD-SYMBOLS: <ls_ddfield> TYPE dfies,
                 <ls_mapping> TYPE ishmed_migtyp_l,
                 <fst>        TYPE ANY.

  e_rc = 0.

* get corder position
  CHECK gr_main_object->is_inherited_from(
              cl_ishmed_prereg=>co_otype_prereg ) = on.
  lr_cordpos = me->get_cordpos( ).

* get compid
  l_compid = me->get_compid( ).

* get position number
  l_posnr = lr_cordpos->get_posnr( ).

* position *************************************
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
    EXPORTING
      i_data_name     = 'RN1MED_PREREG'
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  LOOP AT it_mapping ASSIGNING <ls_mapping>
      WHERE instno = 0
        AND compid = l_compid
        AND posno  = l_posnr.
    LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
      CLEAR: l_field_supported.
      CHECK <ls_mapping>-fieldname = <ls_ddfield>-fieldname.
      l_field_supported = 'X'.
      CHECK l_field_supported = 'X'.
*     fill changing structure
      CONCATENATE 'LS_DATA-' <ls_mapping>-fieldname INTO l_fname.
      ASSIGN (l_fname) TO <fst>.
      <fst> = <ls_mapping>-fvalue.
*     fill X-Flag too
      CONCATENATE 'LS_DATA-' <ls_mapping>-fieldname
      '_x' INTO l_fname.
      ASSIGN (l_fname) TO <fst>.
      <fst> = on.
    ENDLOOP. "LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
  ENDLOOP. "LOOP AT it_mapping ASSIGNING <ls_mapping>

  CHECK e_rc = 0.

  CHECK NOT ls_data IS INITIAL.
* Change cordpos data.
  CALL METHOD lr_cordpos->change
    EXPORTING
      i_prereg       = ls_data
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* ED, ID 16882 -> END

ENDMETHOD.


METHOD prealloc_internal.

  DATA: lr_cordpos  TYPE REF TO cl_ishmed_prereg,
        l_new       TYPE ish_on_off,
        ls_n1vkg    TYPE n1vkg,
        l_falar     TYPE n1vkg-falar,
        lr_cordtyp  TYPE REF TO cl_ish_cordtyp,
        ls_n1vkg_x  TYPE rn1med_prereg.

* Get the cordpos object.
  lr_cordpos = get_cordpos( ).
  CHECK NOT lr_cordpos IS INITIAL.

* Prealloc only on new cordpos object.
  CALL METHOD lr_cordpos->is_new
    IMPORTING
      e_new = l_new.
  IF l_new = off.
    g_prealloc_done = on.
    EXIT.
  ENDIF.

* Get cordpos data.
  CALL METHOD lr_cordpos->get_data
    IMPORTING
      e_rc           = e_rc
      e_n1vkg        = ls_n1vkg
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* falar
  IF ls_n1vkg-falar IS INITIAL.
*   Get the preallocation falar from cordtyp.
    lr_cordtyp = lr_cordpos->get_cordtyp( ).
    CHECK NOT lr_cordtyp IS INITIAL.
    l_falar = lr_cordtyp->get_falar( ).
    IF NOT l_falar IS INITIAL.
      ls_n1vkg_x-falar   = l_falar.
      ls_n1vkg_x-falar_x = on.
    ENDIF.
  ENDIF.

* Change cordpos
  IF NOT ls_n1vkg_x IS INITIAL.
    CALL METHOD lr_cordpos->change
      EXPORTING
        i_prereg       = ls_n1vkg_x
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Preallocation was done.
  g_prealloc_done = on.

ENDMETHOD.


METHOD transport_from_screen_internal.

* Michael Manoch, 11.02.2010, MED-38637
* Whole method redesigned.

  DATA lt_fv            TYPE ish_t_field_value.

  CHECK ir_screen IS BOUND.

  CALL METHOD ir_screen->get_fields
    IMPORTING
      et_field_values = lt_fv
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

  CALL METHOD ir_screen->set_data_from_fieldval
    EXPORTING
      it_field_values = lt_fv
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.


*  DATA: lr_scr_admis  TYPE REF TO cl_ish_scr_admission.
*
*  CHECK NOT ir_screen IS INITIAL.
*
** Processing depends on ir_screen's type.
*  IF ir_screen->is_inherited_from(
*              cl_ish_scr_admission=>co_otype_scr_admission ) = on.
*    lr_scr_admis ?= ir_screen.
*    CALL METHOD trans_from_scr_admis
*      EXPORTING
*        ir_scr_admis    = lr_scr_admis
*      IMPORTING
*        e_rc            = e_rc
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    CHECK e_rc = 0.
*  ENDIF.


ENDMETHOD.


METHOD transport_to_screen_internal.

* Michael Manoch, 11.02.2010, MED-38637
* Whole method redesigned.

  DATA lt_fv            TYPE ish_t_field_value.

  CHECK ir_screen IS BOUND.

  CALL METHOD ir_screen->get_fields
    IMPORTING
      et_field_values = lt_fv
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

  CALL METHOD ir_screen->set_fieldval_from_data
    IMPORTING
      e_rc            = e_rc
    CHANGING
      ct_field_values = lt_fv
      cr_errorhandler = cr_errorhandler.


*  DATA: lr_scr_admis  TYPE REF TO cl_ish_scr_admission.
*
*  CHECK NOT ir_screen IS INITIAL.
*
** Processing depends on ir_screen's type.
*  IF ir_screen->is_inherited_from(
*              cl_ish_scr_admission=>co_otype_scr_admission ) = on.
*    lr_scr_admis ?= ir_screen.
*    CALL METHOD trans_to_scr_admis
*      EXPORTING
*        ir_scr_admis    = lr_scr_admis
*      IMPORTING
*        e_rc            = e_rc
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    CHECK e_rc = 0.
*  ENDIF.

ENDMETHOD.


METHOD trans_cordpos_from_scr_admis .

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet

*  DATA: lt_field_val       TYPE ish_t_field_value,
*        ls_prereg          TYPE rn1med_prereg,
*        ls_n1vkg           TYPE n1vkg, "Grill, ID-16902
*        lr_scr_lb_falar    TYPE REF TO cl_ish_scr_listbox,
*        lr_scr_lb_bewar    TYPE REF TO cl_ish_scr_listbox,
** ED, ID 17892: local definitions -> BEGIN
*        l_pvpat            TYPE n1pvpat,
*        l_einri            TYPE tn01-einri,
*        ls_field_val_bekat TYPE rnfield_value,
*        l_bekat            TYPE n1vkg-bekat,
** ED, ID 17892 -> END
*        lr_scr_lb_fatyp TYPE REF TO cl_ish_scr_listbox. "ED, ID 18525
*
*
*  FIELD-SYMBOLS: <ls_field_val>  TYPE rnfield_value.
*
*  CHECK NOT ir_cordpos   IS INITIAL.
*  CHECK NOT ir_scr_admis IS INITIAL.
*
*  CHECK g_vcode <> co_vcode_display.
*
** Get screen values.
*  CALL METHOD ir_scr_admis->get_fields
*    IMPORTING
*      et_field_values = lt_field_val
*      e_rc            = e_rc
*    CHANGING
*      c_errorhandler  = cr_errorhandler.
*  CHECK e_rc = 0.
*
**-- start Grill, ID-16902
**-- get data from cordpos
*  CALL METHOD ir_cordpos->get_data
*    IMPORTING
*      e_rc           = e_rc
*      e_n1vkg        = ls_n1vkg
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  CHECK e_rc EQ 0.
**-- end Grill, ID-16902
*
** ED, ID 17892 -> BEGIN
** get the institution
*  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
*  IF l_einri IS INITIAL.
*    EXIT.
*  ENDIF.
** ED, ID 17892 -> END
*
** Fill ls_prereg.
*  LOOP AT lt_field_val ASSIGNING <ls_field_val>.
*    CASE <ls_field_val>-fieldname.
*      WHEN ir_scr_admis->g_fieldname_sc_lb_falar.
*        CHECK NOT <ls_field_val>-object IS INITIAL.
*        CHECK <ls_field_val>-object->is_inherited_from(
*                    cl_ish_scr_listbox=>co_otype_scr_listbox ) = on.
*        lr_scr_lb_falar ?= <ls_field_val>-object.
*        ls_prereg-falar   = lr_scr_lb_falar->get_value( ).
**-- start Grill, ID-16902
*        IF ls_prereg-falar NE ls_n1vkg-falar.
*          ls_prereg-falar_x = on.
*        ELSE.
*          CLEAR ls_prereg-falar.
*        ENDIF.
**-- end Grill, ID-16902
** ED, ID 18525: set falltyp -> BEGIN
*      WHEN ir_scr_admis->g_fieldname_sc_lb_fatyp.
*        CHECK NOT <ls_field_val>-object IS INITIAL.
*        CHECK <ls_field_val>-object->is_inherited_from(
*                    cl_ish_scr_listbox=>co_otype_scr_listbox ) = on.
*        lr_scr_lb_fatyp ?= <ls_field_val>-object.
*        ls_prereg-fatyp   = lr_scr_lb_fatyp->get_value( ).
*        IF ls_prereg-fatyp NE ls_n1vkg-fatyp.
*          ls_prereg-fatyp_x = on.
*        ELSE.
*          CLEAR ls_prereg-fatyp.
*        ENDIF.
** ED, ID 18525 -> END
*      WHEN ir_scr_admis->g_fieldname_sc_lb_bewar.
*        CHECK NOT <ls_field_val>-object IS INITIAL.
*        CHECK <ls_field_val>-object->is_inherited_from(
*                    cl_ish_scr_listbox=>co_otype_scr_listbox ) = on.
*        lr_scr_lb_bewar ?= <ls_field_val>-object.
*        ls_prereg-bewar =   lr_scr_lb_bewar->get_value( ).
**-- start Grill, ID-16902
*        IF ls_prereg-bewar NE ls_n1vkg-bewar.
*          ls_prereg-bewar_x = on.
*        ELSE.
*          CLEAR ls_prereg-bewar.
*        ENDIF.
**-- end Grill, ID-16902
*      WHEN ir_scr_admis->g_fieldname_bekat.
*        CHECK ls_n1vkg-bekat NE <ls_field_val>-value. "Grill, ID-16902
*        ls_prereg-bekat   = <ls_field_val>-value.
*        ls_prereg-bekat_x = on.
*      WHEN ir_scr_admis->g_fieldname_pvpat.
** ED, ID 17892: only if bekat has changed check value for pvpat -> BEGIN
**        CHECK ls_n1vkg-pvpat NE <ls_field_val>-value. "Grill, ID-16902
*        READ TABLE lt_field_val INTO ls_field_val_bekat
*            WITH KEY fieldname = ir_scr_admis->g_fieldname_bekat.
*        CHECK sy-subrc EQ 0.
*        CHECK ls_n1vkg-bekat NE ls_field_val_bekat-value.
*        IF NOT ls_field_val_bekat-value IS INITIAL.
*          l_bekat = ls_field_val_bekat-value.
**   Abhängig von der Behandlungskategorie wird das Kennzeichen
**   Privatpatient gesetzt
*          CALL METHOD ir_scr_admis->check_bekat_for_pvpat
*            EXPORTING
*              i_einri = l_einri
*              i_bekat = l_bekat
*            IMPORTING
*              e_pvpat = l_pvpat.
*        ENDIF.
*        <ls_field_val>-value = l_pvpat.
*        CHECK ls_n1vkg-pvpat NE <ls_field_val>-value.
** ED, ID 17892 -> END
*        ls_prereg-pvpat   = <ls_field_val>-value.
*        ls_prereg-pvpat_x = on.
*    ENDCASE.
*  ENDLOOP.
*
** Change cordpos data.
*  CALL METHOD ir_cordpos->change
*    EXPORTING
*      i_prereg       = ls_prereg
*    IMPORTING
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.


ENDMETHOD.


METHOD trans_cordpos_to_scr_admis .

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet

*  DATA: lt_field_val            TYPE ish_t_field_value,
*        ls_field_val            TYPE rnfield_value,
*        ls_n1vkg                TYPE n1vkg,
*        ls_n1cordtyp            TYPE n1cordtyp,
*        lr_cordtyp              TYPE REF TO cl_ish_cordtyp,
*        l_einri                 TYPE tn01-einri,
*        l_pvpat                 TYPE n1pvpat,
*        l_bekat                 TYPE bekat,
*        lt_field_val_falar      TYPE ish_t_field_value,
*        ls_field_val_falar      TYPE rnfield_value,
*        lr_scr_lb_falar         TYPE REF TO cl_ish_scr_listbox,
*        lt_field_val_fatyp      TYPE ish_t_field_value,
*        ls_field_val_fatyp      TYPE rnfield_value,
*        lr_scr_lb_fatyp         TYPE REF TO cl_ish_scr_listbox,
*        lt_field_val_bewar      TYPE ish_t_field_value,
*        ls_field_val_bewar      TYPE rnfield_value,
*        lr_scr_lb_bewar         TYPE REF TO cl_ish_scr_listbox.
*
*  CHECK NOT ir_cordpos   IS INITIAL.
*  CHECK NOT ir_scr_admis IS INITIAL.
*
** Get cordpos data.
*  CALL METHOD ir_cordpos->get_data
*    IMPORTING
*      e_n1vkg        = ls_n1vkg
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** get clinical order type
*  CALL METHOD ir_cordpos->get_cordtyp
*    RECEIVING
*      rr_cordtyp = lr_cordtyp.
*  IF NOT lr_cordtyp IS INITIAL.
*    CALL METHOD lr_cordtyp->get_data
*      IMPORTING
*        es_n1cordtyp = ls_n1cordtyp.
*  ENDIF.
*
** get the institution
*  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
*  IF l_einri IS INITIAL.
*    EXIT.
*  ENDIF.
*
** ED, ID 17892: get fieldvalues -> BEGIN
** Get screen values.
*  CALL METHOD ir_scr_admis->get_fields
*    IMPORTING
*      et_field_values = lt_field_val
*      e_rc            = e_rc
*    CHANGING
*      c_errorhandler  = cr_errorhandler.
*  CHECK e_rc = 0.
*  READ TABLE lt_field_val INTO ls_field_val
*          WITH KEY fieldname = ir_scr_admis->g_fieldname_bekat.
*  CHECK sy-subrc EQ 0.
** ED, ID 17892 -> END
*
** ED, ID 17892: compare value from bekat with value from object
*  IF ls_field_val-value <> ls_n1vkg-bekat.
**  IF NOT ls_n1vkg-bekat IS INITIAL.
**   Abhängig von der Behandlungskategorie wird das Kennzeichen
**   Privatpatient gesetzt
*    CALL METHOD ir_scr_admis->check_bekat_for_pvpat
*      EXPORTING
*        i_einri = l_einri
*        i_bekat = ls_n1vkg-bekat
*      IMPORTING
*        e_pvpat = l_pvpat.
*    ls_n1vkg-pvpat = l_pvpat.
*  ENDIF.
*
** Build screen values.
*  CLEAR lt_field_val.
** bekat
*  CLEAR ls_field_val.
*  ls_field_val-fieldname = ir_scr_admis->g_fieldname_bekat.
*  ls_field_val-type      = co_fvtype_single.
*  ls_field_val-value     = ls_n1vkg-bekat.
*  INSERT ls_field_val INTO TABLE lt_field_val.
** pvpat
*  CLEAR ls_field_val.
*  ls_field_val-fieldname = ir_scr_admis->g_fieldname_pvpat.
*  ls_field_val-type      = co_fvtype_single.
*  ls_field_val-value     = ls_n1vkg-pvpat.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*
** Set screen values.
*  CALL METHOD ir_scr_admis->set_fields
*    EXPORTING
*      it_field_values  = lt_field_val
*      i_field_values_x = on
*    IMPORTING
*      e_rc             = e_rc
*    CHANGING
*      c_errorhandler   = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Handle the falar listbox screen.
*  REFRESH lt_field_val_falar.
*
** Get the falar listbox screen.
*  CALL METHOD ir_scr_admis->get_scr_lb_falar
*    IMPORTING
*      er_scr_lb_falar = lr_scr_lb_falar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
*  IF NOT lr_scr_lb_falar IS INITIAL.
**   Set falar fieldvalue
*    CLEAR ls_field_val_falar.
*    ls_field_val_falar-fieldname = lr_scr_lb_falar->get_lbname( ).
*    ls_field_val_falar-type      = co_fvtype_single.
*    ls_field_val_falar-value     = ls_n1vkg-falar.
*    INSERT ls_field_val_falar INTO TABLE lt_field_val_falar.
**   Set falar screen values
*    CALL METHOD lr_scr_lb_falar->set_fields
*      EXPORTING
*        it_field_values  = lt_field_val_falar
*        i_field_values_x = on.
*  ENDIF.
*
** Get the fatyp listbox screen.
*  CALL METHOD ir_scr_admis->get_scr_lb_fatyp
*    IMPORTING
*      er_scr_lb_fatyp = lr_scr_lb_fatyp
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
*  IF NOT lr_scr_lb_fatyp IS INITIAL.
**   Set fatyp fieldvalue
*    CLEAR ls_field_val_fatyp.
*    ls_field_val_fatyp-fieldname = lr_scr_lb_fatyp->get_lbname( ).
*    ls_field_val_fatyp-type      = co_fvtype_single.
*    ls_field_val_fatyp-value     = ls_n1vkg-fatyp.
*    INSERT ls_field_val_fatyp INTO TABLE lt_field_val_fatyp.
**   Set fatyp screen values
*    CALL METHOD lr_scr_lb_fatyp->set_fields
*      EXPORTING
*        it_field_values  = lt_field_val_fatyp
*        i_field_values_x = on.
*  ENDIF.
*
** Handle the bewar listbox screen.
*  REFRESH lt_field_val_bewar.
*
** Get the bewar listbox screen.
*  CALL METHOD ir_scr_admis->get_scr_lb_bewar
*    IMPORTING
*      er_scr_lb_bewar = lr_scr_lb_bewar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
*  IF NOT lr_scr_lb_bewar IS INITIAL.
**   Set bewar fieldvalue
*    CLEAR ls_field_val_bewar.
*    ls_field_val_bewar-fieldname = lr_scr_lb_bewar->get_lbname( ).
*    ls_field_val_bewar-type      = co_fvtype_single.
*    ls_field_val_bewar-value     = ls_n1vkg-bewar.
*    INSERT ls_field_val_bewar INTO TABLE lt_field_val_bewar.
**   Set bewar screen values
*    CALL METHOD lr_scr_lb_bewar->set_fields
*      EXPORTING
*        it_field_values  = lt_field_val_bewar
*        i_field_values_x = on.
*  ENDIF.

ENDMETHOD.


METHOD trans_from_scr_admis .

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet

*  DATA: lr_cordpos  TYPE REF TO cl_ishmed_prereg.
*
*  CHECK NOT gr_main_object  IS INITIAL.
*  CHECK NOT ir_scr_admis    IS INITIAL.
*
** Processing depends on gr_main_object's type.
*  IF gr_main_object->is_inherited_from(
*              cl_ishmed_prereg=>co_otype_prereg ) = on.
*    lr_cordpos ?= gr_main_object.
*    CALL METHOD trans_cordpos_from_scr_admis
*      EXPORTING
*        ir_cordpos      = lr_cordpos
*        ir_scr_admis    = ir_scr_admis
*      IMPORTING
*        e_rc            = e_rc
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    CHECK e_rc = 0.
*  ENDIF.

ENDMETHOD.


METHOD trans_to_scr_admis .

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet

*  DATA: lr_cordpos  TYPE REF TO cl_ishmed_prereg.
*
*  CHECK NOT gr_main_object  IS INITIAL.
*  CHECK NOT ir_scr_admis    IS INITIAL.
*
** Processing depends on gr_main_object's type.
*  IF gr_main_object->is_inherited_from(
*              cl_ishmed_prereg=>co_otype_prereg ) = on.
*    lr_cordpos ?= gr_main_object.
*    CALL METHOD trans_cordpos_to_scr_admis
*      EXPORTING
*        ir_cordpos      = lr_cordpos
*        ir_scr_admis    = ir_scr_admis
*      IMPORTING
*        e_rc            = e_rc
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    CHECK e_rc = 0.
*  ENDIF.


ENDMETHOD.
ENDCLASS.
