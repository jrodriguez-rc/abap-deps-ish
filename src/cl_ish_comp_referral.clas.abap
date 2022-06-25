class CL_ISH_COMP_REFERRAL definition
  public
  inheriting from CL_ISH_COMPONENT_STD
  create public .

*"* public components of class CL_ISH_COMP_REFERRAL
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_COMP_REFERRAL type ISH_OBJECT_TYPE value 8005. "#EC NOTEXT

  methods GET_CORDPOS
    returning
      value(RR_CORDPOS) type ref to CL_ISHMED_PREREG .
  methods CONSTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .
  methods CHECK_REFERRAL_MANDATORY
    importing
      value(I_CALL_SUPER_CHECK) type ISH_ON_OFF default ON
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_COMPONENT~CANCEL
    redefinition .
  methods IF_ISH_COMPONENT~CHECK
    redefinition .
  methods IF_ISH_COMPONENT~IS_EMPTY
    redefinition .
  methods IF_ISH_DOM~MODIFY_DOM_DATA
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_A
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMP_REFERRAL
*"* do not include other source files here!!!

  class-data GT_CDOC_FIELD type ISH_T_CDOC_FIELD .
  class-data GT_PRINT_FIELD type ISH_T_PRINT_FIELD .

  methods TRANS_CORDPOS_FROM_SCR_R
    importing
      !IR_CORDPOS type ref to CL_ISHMED_PREREG optional
      !IR_SCR_R type ref to CL_ISH_SCR_REFERRAL optional
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_CORDPOS_TO_SCR_R
    importing
      !IR_CORDPOS type ref to CL_ISHMED_PREREG optional
      !IR_SCR_R type ref to CL_ISH_SCR_REFERRAL optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_FROM_SCR_R
    importing
      !IR_SCR_R type ref to CL_ISH_SCR_REFERRAL optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_TO_SCR_R
    importing
      !IR_SCR_R type ref to CL_ISH_SCR_REFERRAL optional
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
*"* private components of class CL_ISH_COMP_REFERRAL
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMP_REFERRAL IMPLEMENTATION.


METHOD check_referral_mandatory.

  DATA: lr_cordpos       TYPE REF TO cl_ishmed_prereg,
        l_fieldname      TYPE ish_fieldname,
        l_parameter      TYPE bapi_param,
        l_field          TYPE bapi_fld,
        lt_msg           TYPE ishmed_t_messages,
        lt_screen        TYPE ish_t_screen_objects,
        lr_screen        TYPE REF TO if_ish_screen,
        lr_scr_referral  TYPE REF TO cl_ish_scr_referral,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_rc             TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_msg>  TYPE rn1message.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Let the super class do the checks.
  IF i_call_super_check = on.
    CALL METHOD me->if_ish_component~check
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_errorhandler.
    cr_errorhandler = lr_errorhandler.

* Further processing only if there are errors.
    CHECK NOT l_rc = 0.

  ELSE.

    lr_errorhandler = cr_errorhandler.
  ENDIF.                "IF i_call_super_check = on.

* Get the referral screen.
  CLEAR lr_scr_referral.
  lt_screen = get_defined_screens( ).
  LOOP AT lt_screen INTO lr_screen.
    CHECK NOT lr_screen IS INITIAL.
    CHECK lr_screen->is_inherited_from(
                cl_ish_scr_referral=>co_otype_scr_referral ) = on.
    lr_scr_referral ?= lr_screen.
  ENDLOOP.
  CHECK NOT lr_scr_referral IS INITIAL.

* Get the cordpos object.
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ishmed_prereg=>co_otype_prereg ) = on.
  lr_cordpos ?= gr_main_object.

* Get the fielname which errors have to be eliminated.
*   - adm_pos have no uarnr,
*   - amb_pos have no earnr.
  IF lr_cordpos->is_adm_pos( ) = on.
    l_fieldname = lr_scr_referral->g_fieldname_uarnr.
  ELSE.
    l_fieldname = lr_scr_referral->g_fieldname_earnr.
  ENDIF.
  SPLIT l_fieldname
    AT   '-'
    INTO l_parameter
         l_field.

* Get the messages from the local errorhandler.
  CALL METHOD lr_errorhandler->get_messages
    IMPORTING
      t_extended_msg = lt_msg.

* Eliminate errors for l_fieldname.
  LOOP AT lt_msg ASSIGNING <ls_msg>.
    CHECK <ls_msg>-parameter = l_parameter.
    CHECK <ls_msg>-field     = l_field.
    DELETE lt_msg.
  ENDLOOP.

  CALL METHOD cr_errorhandler->initialize.

* Further processing only if there are any errors left.
  CHECK NOT lt_msg IS INITIAL.

* There are errors -> set e_rc + cr_errorhandler.
  e_rc = 1.


  CALL METHOD cr_errorhandler->collect_messages
    EXPORTING
      t_messages = lt_msg
      i_last     = space.

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

  l_fieldname              = 'RFSRC'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'EARNR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'UARNR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'HARNR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'EXTKH'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.


* Build table for print.

* N1VKG
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  = cl_ishmed_prereg=>co_otype_prereg.
  l_print_field-tabname     = 'N1VKG'.

  l_fieldname              = 'RFSRC'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'EARNR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'UARNR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'HARNR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'EXTKH'.
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


METHOD get_cordpos.

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
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ishmed_prereg=>co_otype_prereg ) = on.
  lr_cordpos ?= gr_main_object.

* Do not process cancelled cordpos objects.
  CALL METHOD lr_cordpos->is_cancelled
    IMPORTING
      e_cancelled = l_cancelled.
  CHECK l_cancelled = off.

* Clear the component's data from the cordpos.

* Build the changing structure.
  CLEAR ls_n1vkg_x.
  ls_n1vkg_x-rfsrc_x = on.
  ls_n1vkg_x-extkh_x = on.
  ls_n1vkg_x-earnr_x = on.
  ls_n1vkg_x-harnr_x = on.
  ls_n1vkg_x-uarnr_x = on.

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


METHOD if_ish_component~check .

  DATA: lr_cordpos       TYPE REF TO cl_ishmed_prereg,
        l_fieldname      TYPE ish_fieldname,
        l_parameter      TYPE bapi_param,
        l_field          TYPE bapi_fld,
        lt_msg           TYPE ishmed_t_messages,
        lt_screen        TYPE ish_t_screen_objects,
        lr_screen        TYPE REF TO if_ish_screen,
        lr_scr_referral  TYPE REF TO cl_ish_scr_referral,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_rc             TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_msg>  TYPE rn1message.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Let the super class do the checks.
  CALL METHOD super->if_ish_component~check
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.
* Further processing only if there are errors.
  CHECK NOT l_rc = 0.

** Get the referral screen.
*  CLEAR lr_scr_referral.
*  lt_screen = get_defined_screens( ).
*  LOOP AT lt_screen INTO lr_screen.
*    CHECK NOT lr_screen IS INITIAL.
*    CHECK lr_screen->is_inherited_from(
*                co_otype_scr_referral ) = on.
*    lr_scr_referral ?= lr_screen.
*  ENDLOOP.
*  CHECK NOT lr_scr_referral IS INITIAL.
*
** Get the cordpos object.
*  CHECK NOT gr_main_object IS INITIAL.
*  CHECK gr_main_object->is_inherited_from(
*              co_otype_prereg ) = on.
*  lr_cordpos ?= gr_main_object.
*
** Get the fielname which errors have to be eliminated.
**   - adm_pos have no uarnr,
**   - amb_pos have no earnr.
*  IF lr_cordpos->is_adm_pos( ) = on.
*    l_fieldname = lr_scr_referral->g_fieldname_uarnr.
*  ELSE.
*    l_fieldname = lr_scr_referral->g_fieldname_earnr.
*  ENDIF.
*  SPLIT l_fieldname
*    AT   '-'
*    INTO l_parameter
*         l_field.
* ED, ID 18427 -> END COMMENT

* ED, ID 18427: new method -> BEGIN
  CALL METHOD me->check_referral_mandatory
    EXPORTING
      i_call_super_check = off "do not check -> already done
    IMPORTING
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = lr_errorhandler.
* ED, ID 18427 -> END

* Get the messages from the local errorhandler.
  CALL METHOD lr_errorhandler->get_messages
    IMPORTING
      t_extended_msg = lt_msg.

* Eliminate errors for l_fieldname.
  LOOP AT lt_msg ASSIGNING <ls_msg>.
    CHECK <ls_msg>-parameter = l_parameter.
    CHECK <ls_msg>-field     = l_field.
    DELETE lt_msg.
  ENDLOOP.

* Further processing only if there are any errors left.
  CHECK NOT lt_msg IS INITIAL.

* There are errors -> set e_rc + cr_errorhandler.
  e_rc = 1.
  CALL METHOD cr_errorhandler->collect_messages
    EXPORTING
      t_messages = lt_msg
      i_last     = space.

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
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ishmed_prereg=>co_otype_prereg ) = on.
  lr_cordpos ?= gr_main_object.

* Get cordpos data.
  CALL METHOD lr_cordpos->get_data
    IMPORTING
      e_rc    = l_rc
      e_n1vkg = ls_n1vkg.
* On error -> self is not empty.
  CHECK l_rc = 0.

* If one of the component fields is not empty -> self is not empty.
  CHECK ls_n1vkg-rfsrc IS INITIAL.
  CHECK ls_n1vkg-extkh IS INITIAL.
  CHECK ls_n1vkg-earnr IS INITIAL.
  CHECK ls_n1vkg-harnr IS INITIAL.
  CHECK ls_n1vkg-uarnr IS INITIAL.

* Self is empty.
  r_empty = on.

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
        l_einri               TYPE tn01-einri,
        l_bewty               TYPE tn14h-bewty,
        l_refsrc              TYPE tn14h-refsrc,
        l_refsrctxt           TYPE tn14y-refsrctxt,
        l_pernr               TYPE ri_pernr,
        l_gpart_text          TYPE ish_pnamec,
        l_gpart               TYPE gpartner,
        l_khans               TYPE text50,
        l_rc                  TYPE i.
  .

  e_rc = 0.

* No document => no action
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
*           RFSRC
            WHEN 'RFSRC'.
*             Get institution.
              l_einri =
              cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
              IF l_einri IS INITIAL.
                EXIT.
              ENDIF.
*             Get text.
              l_bewty  = '1'.                   "Aufnahme
              l_refsrc = l_string_el_value.
              CALL FUNCTION 'ISH_REFSRC_CHECK'
                EXPORTING
                  ss_einri     = l_einri
                  ss_bewty     = l_bewty
                  ss_refsrc    = l_refsrc
                  ss_langu     = sy-langu
                IMPORTING
                  ss_refsrctxt = l_refsrctxt
                EXCEPTIONS
                  not_found    = 1
                  OTHERS       = 2.
              IF sy-subrc = 0.
                l_string_el_value = l_refsrctxt.
              ENDIF.
*             Modify value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           EARNR
            WHEN 'EARNR'.
              CLEAR: l_pernr, l_gpart_text, l_rc.
              l_pernr = l_string_el_value.
              IF l_pernr IS NOT INITIAL.
                CALL METHOD cl_ish_utl_base_gpa=>get_name_gpa
                  EXPORTING
                    i_gpart = l_pernr
                  IMPORTING
                    e_pname = l_gpart_text
                    e_rc    = l_rc.
                IF l_rc = 0.
                  CONCATENATE l_pernr
                              l_gpart_text
                         INTO l_string_el_value
                    SEPARATED BY space.
                ENDIF.
              ENDIF.
*             Modify element value in DOM node
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           UARNR
            WHEN 'UARNR'.
              CLEAR: l_pernr, l_gpart_text, l_rc.
              l_pernr = l_string_el_value.
              IF l_pernr IS NOT INITIAL.
                CALL METHOD cl_ish_utl_base_gpa=>get_name_gpa
                  EXPORTING
                    i_gpart = l_pernr
                  IMPORTING
                    e_pname = l_gpart_text
                    e_rc    = l_rc.
                IF l_rc = 0.
                  CONCATENATE l_pernr
                              l_gpart_text
                         INTO l_string_el_value
                    SEPARATED BY space.
                ENDIF.
              ENDIF.
*             Modify element value in DOM node
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           HARNR
            WHEN 'HARNR'.
              CLEAR: l_pernr, l_gpart_text, l_rc.
              l_pernr = l_string_el_value.
              IF l_pernr IS NOT INITIAL.
                CALL METHOD cl_ish_utl_base_gpa=>get_name_gpa
                  EXPORTING
                    i_gpart = l_pernr
                  IMPORTING
                    e_pname = l_gpart_text
                    e_rc    = l_rc.
                IF l_rc = 0.
                  CONCATENATE l_pernr
                              l_gpart_text
                         INTO l_string_el_value
                    SEPARATED BY space.
                ENDIF.
              ENDIF.
*             Modify element value in DOM node
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           EXTKH
            WHEN 'EXTKH'.
              CLEAR: l_gpart, l_khans, l_rc.
              l_gpart = l_string_el_value.
              IF l_gpart IS NOT INITIAL.
                CALL METHOD cl_ish_utl_base_descr=>get_descr_khans
                  EXPORTING
                    i_gpart         = l_gpart
                  IMPORTING
                    e_khans         = l_khans
                    e_rc            = l_rc
*                CHANGING
*                  CR_ERRORHANDLER =
                    .
                IF l_rc = 0.
                  CONCATENATE l_gpart
                              l_khans
                         INTO l_string_el_value
                    SEPARATED BY space.
                ENDIF.
              ENDIF.
*             Modify element value in DOM node
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
            WHEN OTHERS.
          ENDCASE.
        ENDIF.  "NAME
      ENDIF.  "attributes
    ENDIF.  "COMPELEMENT

*   Get next COMPELEMENT.
    lr_node = lr_node_iterator->get_next( ).
  ENDWHILE.

* Return modified document.
  cr_document_fragment = lr_document_fragment.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_comp_referral.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  IF i_object_type = co_otype_comp_referral.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_comp_referral.
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

  DATA: lr_scr_referral TYPE REF TO cl_ish_scr_referral.

* create screen objects.
* screen referral
  CALL METHOD cl_ish_scr_referral=>create
    IMPORTING
      er_instance     = lr_scr_referral
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* Save all used screen object in gt_screen_objects.
  APPEND lr_scr_referral TO gt_screen_objects.

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
        l_rc        TYPE ish_method_rc,
        l_falar     TYPE n1vkg-falar,
        lr_cordtyp  TYPE REF TO cl_ish_cordtyp,
        ls_n1vkg_x  TYPE rn1med_prereg,
        ls_npat     TYPE npat, "ED, ID 17974
        l_get_harz  TYPE ri_parval, "ED, ID 17974
        ls_ngpa     TYPE ngpa.      "Grill, ID-19443

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

* ED, ID 17974: prealloc EARNR, HARNR -> BEGIN
*   Bei einer manuellen Änderung des einweisenden/überweisenden
*   Arztes wird der Hausarzt auf dessen Wert gesetzt, sofern dieses
*   Feld leer ist
*   Hausarzt nur übernehmen, wenn der TN00R-
*   Parameter GET_HARZ gesetzt ist
* get data from cordtyp
  lr_cordtyp = lr_cordpos->get_cordtyp( ).
  CHECK NOT lr_cordtyp IS INITIAL.
  l_falar = lr_cordtyp->get_falar( ).

  CALL FUNCTION 'ISH_TN00R_READ'
    EXPORTING
      ss_einri  = ls_n1vkg-einri
      ss_param  = 'GET_HARZ'
      ss_alpha  = 'X'
    IMPORTING
      ss_value  = l_get_harz
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.
  IF sy-subrc = 0      AND
     l_get_harz = on   AND
     ls_n1vkg-harnr IS INITIAL.
    IF l_falar = '2'.
      IF ls_n1vkg-uarnr <> ls_n1vkg-earnr.
        ls_n1vkg_x-harnr = ls_n1vkg-earnr.
        ls_n1vkg_x-harnr_x = on.
      ENDIF.
    ENDIF.
  ENDIF.

*   Vorbelegung nur durchführen, wenn:
*   -) Das entsprechende Feld leer ist
*   -) Der Subscreen auch wirklich aktiv (d.h. sichtbar) ist
*   -) Die Vormerkung gerade ANGELEGT wird (siehe weiter oben)
*   -) Vormerkung wird für einen REALEN Patienten angelegt
*   -) Fallart ändert sich von Space auf <> space
  IF NOT ls_n1vkg-patnr IS INITIAL   AND
     l_falar <> space.
*     Auftragsposition wurde gerade an einen echten Patienten gehängt =>
*     Vorbelegung durchführen
*     Dazu den Patientendatensatz ermitteln
    CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
      EXPORTING
        i_patnr = ls_n1vkg-patnr
      IMPORTING
        es_npat = ls_npat
        e_rc    = l_rc.
    e_rc = l_rc.
    CHECK e_rc = 0.
    IF ls_n1vkg-earnr IS INITIAL.
      IF l_falar = '2'.
        ls_n1vkg_x-earnr = ls_npat-uarnr.
      ELSE.
        ls_n1vkg_x-earnr = ls_npat-earnr.
      ENDIF.
      ls_n1vkg_x-earnr_x = on.
    ENDIF.
    IF ls_n1vkg-harnr IS INITIAL.
      ls_n1vkg_x-harnr = ls_npat-harnr.
      ls_n1vkg_x-harnr_x = on.
    ENDIF.
*     Einweisendes Krankenhaus wird NICHT vorbelegt!
  ENDIF.
* ED, ID 17974 -> END

*-- begin Grill, ID-19443
*-- check HARNR
  IF NOT ls_n1vkg_x-harnr IS INITIAL.
    ls_ngpa-gpart = ls_n1vkg_x-harnr.
    CALL METHOD cl_ish_dbr_gpa=>get_gpa_by_gpart
      EXPORTING
        i_gpart = ls_ngpa-gpart
      IMPORTING
        es_ngpa = ls_ngpa
        e_rc    = l_rc.
*   begin GS MED-76559
    IF l_rc <> 0.                             "MED-49635 M.Rebegea 15.01.12
*     IF l_rc <> 0 OR ls_ngpa-loekz = abap_on.  "MED-49635 M.Rebegea 15.01.12
*   end GS MED-76559
      CLEAR ls_n1vkg_x-harnr.
      ls_n1vkg_x-harnr_x = off.
*   begin GS MED-76559
*    ELSEIF ls_ngpa-loekz EQ off.
    ELSE. "spvon and spbis has to be checked for HARNR
*   end GS MED-76559
      IF ls_ngpa-spvon <= sy-datum AND
         ls_ngpa-spbis >= sy-datum.
        CLEAR ls_n1vkg_x-harnr.
        ls_n1vkg_x-harnr_x = off.
      ENDIF.
    ENDIF.
  ENDIF.
*-- check EARNR
  IF NOT ls_n1vkg_x-earnr IS INITIAL.
    CLEAR ls_ngpa.
    ls_ngpa-gpart = ls_n1vkg_x-earnr.
    CALL METHOD cl_ish_dbr_gpa=>get_gpa_by_gpart
      EXPORTING
        i_gpart = ls_ngpa-gpart
      IMPORTING
        es_ngpa = ls_ngpa
        e_rc    = l_rc.
    IF l_rc <> 0.
      CLEAR ls_n1vkg_x-earnr.
      ls_n1vkg_x-earnr_x = off.
*   begin GS MED-76559
*    ELSEIF ls_ngpa-loekz EQ off.
    ELSE. "spvon and spbis has to be checked
*   end GS MED-76559
      IF ls_ngpa-spvon <= sy-datum AND
           ls_ngpa-spbis >= sy-datum.
        CLEAR ls_n1vkg_x-earnr.
        ls_n1vkg_x-earnr_x = off.
      ENDIF.
    ENDIF.
  ENDIF.
*-- end Grill, ID-19443

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

  DATA: lr_scr_r  TYPE REF TO cl_ish_scr_referral.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_referral=>co_otype_scr_referral ) = on.
    lr_scr_r ?= ir_screen.
    CALL METHOD trans_from_scr_r
      EXPORTING
        ir_scr_r        = lr_scr_r
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD transport_to_screen_internal.

  DATA: lr_scr_r  TYPE REF TO cl_ish_scr_referral.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_referral=>co_otype_scr_referral ) = on.
    lr_scr_r ?= ir_screen.
    CALL METHOD trans_to_scr_r
      EXPORTING
        ir_scr_r        = lr_scr_r
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_cordpos_from_scr_r .

  DATA: lt_field_val    TYPE ish_t_field_value,
        lr_main_object  TYPE REF TO if_ish_identify_object,
        lr_cordpos      TYPE REF TO cl_ishmed_prereg,
        ls_prereg       TYPE rn1med_prereg,
        ls_n1vkg        TYPE n1vkg, "Grill, ID-16902
        lr_fct_corder   TYPE REF TO cl_ish_fct_corder.

  FIELD-SYMBOLS: <ls_field_val>  TYPE rnfield_value.

  CHECK NOT ir_cordpos IS INITIAL.
  CHECK NOT ir_scr_r  IS INITIAL.

  CHECK g_vcode <> co_vcode_display.

* Get screen values.
  CALL METHOD ir_scr_r->get_fields
    IMPORTING
      et_field_values = lt_field_val
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

*-- start Grill, ID-16902
  CALL METHOD ir_cordpos->get_data
    IMPORTING
      e_rc           = e_rc
      e_n1vkg        = ls_n1vkg
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc EQ 0.
*-- end Grill, ID-16902

* Fill ls_prereg.
  LOOP AT lt_field_val ASSIGNING <ls_field_val>.
    CASE <ls_field_val>-fieldname.
      WHEN ir_scr_r->g_fieldname_rfsrc.
        CHECK ls_n1vkg-rfsrc NE <ls_field_val>-value. "Grill, ID-16902
        ls_prereg-rfsrc   = <ls_field_val>-value.
        ls_prereg-rfsrc_x = on.
      WHEN ir_scr_r->g_fieldname_extkh.
        CHECK ls_n1vkg-extkh NE <ls_field_val>-value. "Grill, ID-16902
        ls_prereg-extkh   = <ls_field_val>-value.
        ls_prereg-extkh_x = on.
      WHEN ir_scr_r->g_fieldname_earnr.
        CHECK ls_n1vkg-earnr NE <ls_field_val>-value. "Grill, ID-16902
        ls_prereg-earnr   = <ls_field_val>-value.
        ls_prereg-earnr_x = on.
      WHEN ir_scr_r->g_fieldname_harnr.
        CHECK ls_n1vkg-harnr NE <ls_field_val>-value. "Grill, ID-16902
        ls_prereg-harnr   = <ls_field_val>-value.
        ls_prereg-harnr_x = on.
      WHEN ir_scr_r->g_fieldname_uarnr.
        CHECK ls_n1vkg-uarnr NE <ls_field_val>-value. "Grill, ID-16902
        ls_prereg-uarnr   = <ls_field_val>-value.
        ls_prereg-uarnr_x = on.
    ENDCASE.
  ENDLOOP.

* Change cordpos data.
    CALL METHOD ir_cordpos->change
      EXPORTING
        i_prereg       = ls_prereg
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
ENDMETHOD.


METHOD trans_cordpos_to_scr_r .

  DATA: lt_field_val    TYPE ish_t_field_value,
        ls_field_val    TYPE rnfield_value,
        lr_main_object  TYPE REF TO if_ish_identify_object,
        lr_corder       TYPE REF TO cl_ish_corder,
        lr_cordpos      TYPE REF TO cl_ishmed_prereg,
        ls_n1corder     TYPE n1corder,
        ls_n1vkg        TYPE n1vkg,
        ls_ngpa         TYPE ngpa,
        l_rc            type ish_method_rc.

  CHECK NOT ir_cordpos  IS INITIAL.
  CHECK NOT ir_scr_r   IS INITIAL.

* get corder data
  CALL METHOD ir_cordpos->get_corder
    IMPORTING
      er_corder       = lr_corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get cordpos data.
  CALL METHOD ir_cordpos->get_data
    IMPORTING
      e_n1vkg        = ls_n1vkg
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* get business partner information
  IF NOT ls_n1corder-etrgp IS INITIAL.
    CALL METHOD cl_ish_dbr_gpa=>get_gpa_by_gpart
      EXPORTING
        i_gpart = ls_n1corder-etrgp
      IMPORTING
        es_ngpa = ls_ngpa
        e_rc    = l_rc.
    IF l_rc <> 0.
      CLEAR ls_ngpa.
    ENDIF.
  ENDIF.

* Build screen values.
  CLEAR lt_field_val.
  CLEAR ls_field_val.
  ls_field_val-fieldname = ir_scr_r->g_fieldname_rfsrc.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1vkg-rfsrc.
  INSERT ls_field_val INTO TABLE lt_field_val.
  CLEAR ls_field_val.
  ls_field_val-fieldname = ir_scr_r->g_fieldname_extkh.
  ls_field_val-type      = co_fvtype_single.
  IF NOT ls_n1vkg-extkh IS INITIAL.
    ls_field_val-value   = ls_n1vkg-extkh.
  ELSE.
    IF ls_n1corder-etrby = cl_ish_corder=>co_etrby_gp.
      IF NOT ls_ngpa IS INITIAL AND ls_ngpa-krkhs = on.
        ls_field_val-value = ls_n1corder-etrgp.
      ENDIF.
    ENDIF.
  ENDIF.
  INSERT ls_field_val INTO TABLE lt_field_val.
  CLEAR ls_field_val.
  ls_field_val-fieldname = ir_scr_r->g_fieldname_earnr.
  ls_field_val-type      = co_fvtype_single.
  IF NOT ls_n1vkg-earnr IS INITIAL.
    ls_field_val-value   = ls_n1vkg-earnr.
  ELSE.
    IF ls_n1corder-etrby = cl_ish_corder=>co_etrby_gp.
      IF NOT ls_ngpa IS INITIAL AND ls_ngpa-pers = on.
        ls_field_val-value = ls_n1corder-etrgp.
      ENDIF.
    ENDIF.
  ENDIF.
  INSERT ls_field_val INTO TABLE lt_field_val.
  CLEAR ls_field_val.
  ls_field_val-fieldname = ir_scr_r->g_fieldname_harnr.
  ls_field_val-type      = co_fvtype_single.
  IF NOT ls_n1vkg-harnr IS INITIAL.
    ls_field_val-value   = ls_n1vkg-harnr.
  ELSE.
    IF ls_n1corder-etrby = cl_ish_corder=>co_etrby_gp.
      IF NOT ls_ngpa IS INITIAL AND ls_ngpa-pers = on.
        ls_field_val-value = ls_n1corder-etrgp.
      ENDIF.
    ENDIF.
  ENDIF.
  INSERT ls_field_val INTO TABLE lt_field_val.
  CLEAR ls_field_val.
  ls_field_val-fieldname = ir_scr_r->g_fieldname_uarnr.
  ls_field_val-type      = co_fvtype_single.
  IF NOT ls_n1vkg-uarnr IS INITIAL.
    ls_field_val-value   = ls_n1vkg-uarnr.
  ELSE.
    IF ls_n1corder-etrby = cl_ish_corder=>co_etrby_gp.
      IF NOT ls_ngpa IS INITIAL AND ls_ngpa-pers = on.
        ls_field_val-value = ls_n1corder-etrgp.
      ENDIF.
    ENDIF.
  ENDIF.
  INSERT ls_field_val INTO TABLE lt_field_val.

* Set screen values.
  CALL METHOD ir_scr_r->set_fields
    EXPORTING
      it_field_values  = lt_field_val
      i_field_values_x = on
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD trans_from_scr_r .

  DATA: lr_cordpos  TYPE REF TO cl_ishmed_prereg.

  CHECK NOT gr_main_object  IS INITIAL.
  CHECK NOT ir_scr_r    IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ishmed_prereg=>co_otype_prereg ) = on.
    lr_cordpos ?= gr_main_object.
    CALL METHOD trans_cordpos_from_scr_r
      EXPORTING
        ir_cordpos      = lr_cordpos
        ir_scr_r        = ir_scr_r
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_to_scr_r .

  DATA: lr_cordpos  TYPE REF TO cl_ishmed_prereg.

  CHECK NOT gr_main_object  IS INITIAL.
  CHECK NOT ir_scr_r    IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ishmed_prereg=>co_otype_prereg ) = on.
    lr_cordpos ?= gr_main_object.
    CALL METHOD trans_cordpos_to_scr_r
      EXPORTING
        ir_cordpos      = lr_cordpos
        ir_scr_r        = ir_scr_r
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.
ENDCLASS.
