class CL_ISH_COMP_ORDER definition
  public
  inheriting from CL_ISH_COMPONENT_STD
  create public .

public section.
*"* public components of class CL_ISH_COMP_ORDER
*"* do not include other source files here!!!

  constants CO_CLASSID type N1COMPCLASSID value 'CL_ISH_COMP_ORDER'. "#EC NOTEXT
  constants CO_OTYPE_COMP_ORDER type ISH_OBJECT_TYPE value 8001. "#EC NOTEXT

  events EV_ETR_CHANGED
    exporting
      value(IR_CORDER) type ref to CL_ISH_CORDER
      value(I_ETRBY_OLD) type N1CORDETRBY
      value(I_ETRBY_NEW) type N1CORDETRBY
      value(I_ETROE_OLD) type N1CORDETROE
      value(I_ETROE_NEW) type N1CORDETROE
      value(I_ETRGP_OLD) type N1CORDETRGP
      value(I_ETRGP_NEW) type N1CORDETRGP
      value(I_ORDDEP_NEW) type N1CORDDEP
      value(I_ORDDEP_OLD) type N1CORDDEP .

  methods GET_N1CORDER
    returning
      value(ES_N1CORDER) type N1CORDER .
  methods GET_CORDER
    returning
      value(RR_CORDER) type ref to CL_ISH_CORDER .
  methods CONSTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .
  methods GET_CON_CORDER
    returning
      value(RR_CON_CORDER) type ref to CL_ISH_CON_CORDER .

  methods IF_ISH_COMPONENT~IS_EMPTY
    redefinition .
  methods IF_ISH_DOM~MODIFY_DOM_DATA
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMP_ORDER
*"* do not include other source files here!!!

  class-data GT_CDOC_FIELD type ISH_T_CDOC_FIELD .
  class-data GT_PRINT_FIELD type ISH_T_PRINT_FIELD .
  data G_PREALLOC_DONE_CORDTITLE type ISH_ON_OFF .
  data G_PREALLOC_DONE_ORDDEP type ISH_ON_OFF .
  data G_PREALLOC_DONE_RCKRUF type ISH_ON_OFF .
  data G_PREALLOC_DONE_WLSTA type ISH_ON_OFF .

  methods TRANS_CORDER_FROM_FV_ORDER
    importing
      !IR_SCR_ORDER type ref to CL_ISH_SCR_ORDER
      !IT_FIELD_VAL type ISH_T_FIELD_VALUE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CS_N1CORDER_X type RN1_CORDER_X
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_CORDER_FROM_SCR_ORDER
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IR_SCR_ORDER type ref to CL_ISH_SCR_ORDER
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_CORDER_TO_FV_ORDER
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IS_N1CORDER type N1CORDER
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_FIELD_VAL type ISH_T_FIELD_VALUE
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_CORDER_TO_SCR_ORDER
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IR_SCR_ORDER type ref to CL_ISH_SCR_ORDER
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_FROM_SCR_ORDER
    importing
      !IR_SCR_ORDER type ref to CL_ISH_SCR_ORDER
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_TO_SCR_ORDER
    importing
      !IR_SCR_ORDER type ref to CL_ISH_SCR_ORDER
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
*"* private components of class CL_ISH_COMP_ORDER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMP_ORDER IMPLEMENTATION.


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

  l_fieldname              = 'ETRBY'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ETROE'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ETRGP'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ORDDEP'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'PRGNR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ORDPRI'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'RCKRUF'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLSTA'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'CORDTITLE'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.


* Build table for print.

* N1CORDER
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  = cl_ish_corder=>co_otype_corder.
  l_print_field-tabname     = 'N1CORDER'.

  l_fieldname              = 'ETRBY'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ETROE'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ETRGP'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ORDDEP'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'PRGNR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ORDPRI'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'RCKRUF'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLSTA'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'CORDTITLE'.
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


METHOD get_con_corder .

* Initializations.
  CLEAR rr_con_corder.

  CHECK NOT gr_config IS INITIAL.

  CHECK gr_config->is_inherited_from(
              cl_ish_con_corder=>co_otype_con_corder ) = on.

* Export
  rr_con_corder ?= gr_config.

ENDMETHOD.


METHOD get_corder .

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.

  rr_corder ?= gr_main_object.

ENDMETHOD.


METHOD get_n1corder .

  DATA: lr_corder  TYPE REF TO cl_ish_corder,
        l_rc       TYPE ish_method_rc.

* Initializations
  CLEAR es_n1corder.

* Get corder object
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get corder data.
  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder = es_n1corder
      e_rc        = l_rc.
  IF l_rc <> 0.
    CLEAR es_n1corder.
  ENDIF.

ENDMETHOD.


METHOD if_ish_component~is_empty.

* Michael Manoch, 14.07.2004, ID 14907
* New method.

  DATA: ls_n1corder TYPE n1corder,
        l_rc        TYPE ish_method_rc.

* Call super method.
  r_empty = super->if_ish_component~is_empty( ).

* Further processing only if super method returns ON.
  CHECK r_empty = on.

* Check the corder fields.
  r_empty = off.

* Get corder data.
  ls_n1corder = get_n1corder( ).

* If one of the component fields is not empty -> self is not empty.
  CHECK ls_n1corder-etrby      IS INITIAL.
  CHECK ls_n1corder-etrgp      IS INITIAL.
  CHECK ls_n1corder-etroe      IS INITIAL.
  CHECK ls_n1corder-ordpri     IS INITIAL.
  CHECK ls_n1corder-wlsta      IS INITIAL.
  CHECK ls_n1corder-orddep     IS INITIAL.
  CHECK ls_n1corder-prgnr      IS INITIAL.
  CHECK ls_n1corder-rckruf     IS INITIAL.
  CHECK ls_n1corder-cordtitle  IS INITIAL.

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
        l_apri                TYPE n1apri_d,
        l_aprie               TYPE n1aprie,
        l_apritxt             TYPE n1apritxt,
        l_pernr               TYPE ri_pernr,
        l_gpart_text          TYPE ish_pnamec,
        l_wlsta               TYPE ish_wlstatus,
        l_wlstx               TYPE ish_wlstattx,
        l_rc                  TYPE i.

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
*         Get last child of COMPELEMENT => ELEMENTVAL.
          lr_node_last_child  = lr_node->get_last_child( ).
          IF NOT lr_node_last_child IS INITIAL.
            l_string_el_value = lr_node_last_child->get_value( ).
          ENDIF.

*         Check/change COMPELEMENT.
          l_string_compel_name = lr_node_name->get_value( ).
          CASE l_string_compel_name.
*           ETRBY
            WHEN 'ETRBY'.
*             Map domain value.
              CALL METHOD cl_ish_utl_xml=>map_domain_value
                EXPORTING
                  i_domain        = 'N1CORDETRBY'
                  i_value         = l_string_el_value
                IMPORTING
                  e_text          = l_string_el_value
                  e_rc            = e_rc
                CHANGING
                  cr_errorhandler = cr_errorhandler.
*             Modify value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           ETRGP
            WHEN 'ETRGP'.
              CLEAR: l_pernr, l_gpart_text, l_rc.
              l_pernr = l_string_el_value.
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
*             Modify element value in DOM node
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           ORDPRI
            WHEN 'ORDPRI'.
              CLEAR: l_einri, l_aprie, l_apritxt.
*             Get institution.
              l_einri =
              cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
              IF l_einri IS INITIAL.
                EXIT.
              ENDIF.
*             Get text.
              l_aprie = l_string_el_value.
              CALL FUNCTION 'ISHMED_APRIE'
                EXPORTING
                  i_apri    = l_apri
                  i_einri   = l_einri
                IMPORTING
                  e_aprie   = l_aprie
                  e_apritxt = l_apritxt
                EXCEPTIONS
                  not_found = 1
                  OTHERS    = 2.
              IF sy-subrc = 0.
                l_string_el_value = l_apritxt.
              ENDIF.
*             Modify value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           WLSTA
            WHEN 'WLSTA'.
              CLEAR: l_einri, l_wlsta, l_wlstx.
*             Get institution.
              l_einri =
              cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
              IF l_einri IS INITIAL.
                EXIT.
              ENDIF.
*             Get text.
              l_wlsta = l_string_el_value.
              SELECT SINGLE wlstx FROM tn42v
                                  INTO l_wlstx
                                  WHERE spras = sy-langu
                                  AND   einri = l_einri
                                  AND   wlsta = l_wlsta.
              IF sy-subrc = 0.
                l_string_el_value = l_wlstx.
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

* Return modified document.
  cr_document_fragment = lr_document_fragment.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_comp_order.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_comp_order.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD initialize_methods .

* No methods for the order component.

ENDMETHOD.


METHOD initialize_screens.

  DATA: lr_scr_order  TYPE REF TO cl_ish_scr_order.

* order screen.
  CALL METHOD cl_ish_fac_scr_order=>create
    IMPORTING
      er_instance     = lr_scr_order
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  APPEND lr_scr_order TO gt_screen_objects.

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
        l_fname           TYPE string,
        l_compid          TYPE n1comp-compid,
        l_index           TYPE i.

  FIELD-SYMBOLS: <ls_ddfield> TYPE dfies,
                 <ls_mapping> TYPE ishmed_migtyp_l,
                 <fst>        TYPE ANY.

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


METHOD prealloc_internal.

  DATA: lr_corder          TYPE REF TO cl_ish_corder,
        l_new              TYPE ish_on_off,
        ls_n1corder        TYPE n1corder,
        ls_n1corder_x      TYPE rn1_corder_x,
        lt_cordpos         TYPE ish_t_cordpos,
        lr_cordpos         TYPE REF TO cl_ishmed_prereg,
        l_n1vkgetr         TYPE n1corder-etrby,
        l_n1vkgetrva(50)   TYPE c,
        ls_nfal            TYPE nfal,
        ls_norg            TYPE norg,
        ls_orgfa           TYPE norg,
        l_rckruf           TYPE n1corder-rckruf,
        lt_cordtyp         TYPE ish_t_cordtyp,
        lr_cordtyp         TYPE REF TO cl_ish_cordtyp,
        lr_cordtyp_first   TYPE REF TO cl_ish_cordtyp,
        lr_cordtyp_wl      TYPE REF TO cl_ish_cordtyp,
        lr_compdef_wl      TYPE REF TO cl_ish_compdef,
        l_prealloc_done    TYPE ish_on_off,
        l_rc               TYPE ish_method_rc,
        lr_cordtyp_profile TYPE REF TO cl_ish_cordtyp.     "Grill, med-31614

* Kurt Dudek, 22.09.2004, ID 15479   START
  DATA: ls_nadr           TYPE nadr.
* Kurt Dudek, 22.09.2004, ID 15479   END

*-- Begin Grill, ID-16401
  DATA: lr_prereg    TYPE REF TO cl_ishmed_prereg,
        ls_n1cordtyp TYPE n1cordtyp,
        l_cordtypid  TYPE n1cordtyp-cordtypid,
        ls_n1vkg      TYPE n1vkg.
*-- End Grill, ID-16401

* Initializations.
  e_rc = 0.
  CLEAR: lr_corder,
         ls_n1corder,
         ls_n1corder_x,
         lt_cordtyp.
  l_prealloc_done = on.

* Get corder object
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Prealloc only on new corder object.
  CALL METHOD lr_corder->is_new
    IMPORTING
      e_new = l_new.
  IF l_new = off.
    g_prealloc_done = on.
    EXIT.
  ENDIF.

* Get corder data.
  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* etrby / etroe / etrgp.
* If etrby is not valid set it according to etroe/etrgp.
  IF NOT ls_n1corder-etrby = cl_ish_corder=>co_etrby_oe AND
     NOT ls_n1corder-etrby = cl_ish_corder=>co_etrby_gp.
    IF NOT ls_n1corder-etroe IS INITIAL.
      ls_n1corder-etrby     = cl_ish_corder=>co_etrby_oe.
      ls_n1corder_x-etrby   = cl_ish_corder=>co_etrby_oe.
      ls_n1corder_x-etrby_x = on.
    ELSEIF NOT ls_n1corder-etrgp IS INITIAL.
      ls_n1corder-etrby     = cl_ish_corder=>co_etrby_gp.
      ls_n1corder_x-etrby   = cl_ish_corder=>co_etrby_gp.
      ls_n1corder_x-etrby_x = on.
    ENDIF.
  ENDIF.
* If etrby is not valid yet
* (this can only be if there is no etroe/etrgp)
* use the user parameters n1vkgetr/n1vkgetrva.
  IF NOT ls_n1corder-etrby = cl_ish_corder=>co_etrby_oe AND
     NOT ls_n1corder-etrby = cl_ish_corder=>co_etrby_gp.
    DO 1 TIMES.
*     Get etrby
      CALL FUNCTION 'ISH_GET_PARAMETER_ID'
        EXPORTING
          i_parameter_id    = 'N1VKGETR'
        IMPORTING
          e_parameter_value = l_n1vkgetr
          e_rc              = l_rc.
      CHECK l_rc = 0.
      CHECK l_n1vkgetr = cl_ish_corder=>co_etrby_oe OR
            l_n1vkgetr = cl_ish_corder=>co_etrby_gp.
*     Set etrby
      ls_n1corder-etrby     = l_n1vkgetr.
      ls_n1corder_x-etrby   = l_n1vkgetr.
      ls_n1corder_x-etrby_x = on.
*     Get etroe/etrgp
      CALL FUNCTION 'ISH_GET_PARAMETER_ID'
        EXPORTING
          i_parameter_id    = 'N1VKGETRVA'
        IMPORTING
          e_parameter_value = l_n1vkgetrva
          e_rc              = l_rc.
      CHECK l_rc = 0.
*      translate l_n1vkgetrva to upper case.     "Grill, med-33556
      CHECK NOT l_n1vkgetrva IS INITIAL.
*     Set etroe/etrgp
      CASE ls_n1corder-etrby.
        WHEN cl_ish_corder=>co_etrby_oe.
          ls_n1corder-etroe     = l_n1vkgetrva.
          ls_n1corder_x-etroe   = l_n1vkgetrva.
          ls_n1corder_x-etroe_x = on.
        WHEN cl_ish_corder=>co_etrby_gp.
          ls_n1corder-etrgp     = l_n1vkgetrva.
          ls_n1corder_x-etrgp   = l_n1vkgetrva.
          ls_n1corder_x-etrgp_x = on.
      ENDCASE.
    ENDDO.
  ENDIF.
* If etrby is not valid yet (this can only be if there is
* no etroe/etrgp and the user parameters are not set correctly)
* use default.
  IF NOT ls_n1corder-etrby = cl_ish_corder=>co_etrby_oe AND
     NOT ls_n1corder-etrby = cl_ish_corder=>co_etrby_gp.
    ls_n1corder-etrby     = cl_ish_corder=>co_etrby_oe.
    ls_n1corder_x-etrby   = cl_ish_corder=>co_etrby_oe.
    ls_n1corder_x-etrby_x = on.
  ENDIF.

* orddep
  IF g_prealloc_done_orddep = off.
    IF ls_n1corder-orddep IS INITIAL.
*     Get all cordpos objects.
      CALL METHOD lr_corder->get_t_cordpos
        IMPORTING
          et_cordpos      = lt_cordpos
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
*     Get the first nfal.
      LOOP AT lt_cordpos INTO lr_cordpos.
        CHECK NOT lr_cordpos IS INITIAL.
        ls_nfal = lr_cordpos->get_nfal( ).
        IF NOT ls_nfal IS INITIAL.
          EXIT.
        ENDIF.
      ENDLOOP.
*     Get orgfa.
*     Begin of MED-57981: MVoicu 17.11.2014
*     Call this method only if FALNR and ETROE are not initial.
      IF NOT ( ls_nfal-falnr IS INITIAL AND ls_n1corder-etroe IS INITIAL ).
*     End of MED-57981: MVoicu 17.11.2014
         CALL FUNCTION 'ISHMED_SEARCH_ORGFA'
        EXPORTING
          i_einri       = ls_n1corder-einri
          i_falnr       = ls_nfal-falnr
          i_nfal        = ls_nfal
          i_orgpf       = ls_n1corder-etroe
        IMPORTING
          e_orgfa       = ls_orgfa
        EXCEPTIONS
          no_valid_nfal = 1
          no_valid_nbew = 2
          OTHERS        = 3.
      ENDIF. "MED-57981: MVoicu 17.11.2014
      IF sy-subrc = 0.
*       Set orgdep.
        ls_n1corder-orddep     = ls_orgfa-orgid.
        ls_n1corder_x-orddep   = ls_orgfa-orgid.
        ls_n1corder_x-orddep_x = on.
      ENDIF.
    ENDIF.
*   Handle g_prealloc_done_orddep
    IF NOT ls_n1corder-orddep IS INITIAL.
      g_prealloc_done_orddep = on.
    ENDIF.
  ENDIF.

* rckruf
  IF g_prealloc_done_rckruf = off.
    IF ls_n1corder-rckruf IS INITIAL.
*     Get rckruf from user parameter.
      CALL FUNCTION 'ISH_GET_PARAMETER_ID'
        EXPORTING
          i_parameter_id    = 'TRR'
        IMPORTING
          e_parameter_value = l_rckruf
          e_rc              = l_rc.
      IF l_rc <> 0.
        CLEAR l_rckruf.
      ENDIF.
      IF l_rckruf IS INITIAL.
*       Get rckruf from initiator.
        IF NOT ls_n1corder-etroe IS INITIAL.
          CALL METHOD cl_ish_dbr_org=>get_org_by_orgid
            EXPORTING
              i_orgid = ls_n1corder-etroe
            IMPORTING
              es_norg = ls_norg
              e_rc    = l_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.    "Grill, med-33556
          IF l_rc <> 0.
            e_rc = l_rc.
            CLEAR ls_norg.
            EXIT.
* Kurt Dudek, 22.09.2004, ID 15479   START
*         ENDIF.
*         l_rckruf = ls_norg-telnr.
          ELSE.
            IF NOT ls_norg-adrnr IS INITIAL AND
               NOT ls_norg-adrob IS INITIAL.
              CLEAR ls_nadr.                    "CDuerr, MED-32975
              CALL FUNCTION 'ISH_ADDRESS_READ'
                EXPORTING
                  ss_adrnr  = ls_norg-adrnr
                  ss_adrob  = ls_norg-adrob
                IMPORTING
                  ss_nadr   = ls_nadr
                EXCEPTIONS
                  not_found = 1
                  OTHERS    = 2.
*BEGIN MED-48359, Oana Bocarnea 10.12.2012
              IF sy-subrc <> 0.
                l_rckruf = ls_norg-telnr.
              ELSE.
*END MED-48359, Oana Bocarnea 10.12.2012
*              IF sy-subrc <> 0.                "CDuerr, MED-32975
*                e_rc = sy-subrc.     "Grill, med-29770
*                EXIT.                          "CDuerr, MED-32975
*              ENDIF.                           "CDuerr, MED-32975
              l_rckruf = ls_nadr-telnr.
              ENDIF. "MED-48359, Oana Bocarnea 10.12.2012
            ELSE.
              l_rckruf = ls_norg-telnr. " MED-48359, Oana Bocarnea 12.09.2012
              CLEAR ls_nadr.
            ENDIF.
          ENDIF.
* Kurt Dudek, 22.09.2004, ID 15479   END
        ENDIF.
      ENDIF.
      IF NOT l_rckruf IS INITIAL.
        ls_n1corder-rckruf     = l_rckruf.
        ls_n1corder_x-rckruf   = l_rckruf.
        ls_n1corder_x-rckruf_x = on.
      ENDIF.
    ENDIF.
*   Handle g_prealloc_done_rckruf
    IF NOT ls_n1corder-rckruf IS INITIAL.
      g_prealloc_done_rckruf = on.
    ENDIF.
  ENDIF.

*-- Begin Grill, ID-16401
*-- Get cordpos
  CALL METHOD lr_corder->get_cordpos_by_posnr
    EXPORTING
      i_posnr         = '001'
    IMPORTING
      er_cordpos      = lr_cordpos
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc EQ 0.
  CHECK NOT lr_cordpos IS INITIAL.

  CALL METHOD lr_cordpos->get_data
    IMPORTING
      e_rc           = e_rc
      e_n1vkg        = ls_n1vkg
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc EQ 0.

  l_cordtypid = ls_n1vkg-cordptypid.
  ls_n1cordtyp-cordtypid = l_cordtypid.

  IF NOT l_cordtypid IS INITIAL.
    CALL METHOD cl_ish_cordtyp=>load
      EXPORTING
        is_n1cordtyp     = ls_n1cordtyp
      IMPORTING
*       er_instance      = lr_cordtyp_first     "Grill, med-31614
        er_instance      = lr_cordtyp_profile   "Grill, med-31614
      EXCEPTIONS
        ex_error_occured = 1
        OTHERS           = 2.

    IF sy-subrc <> 0.
      e_rc = sy-subrc.

      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        EXPORTING
          ir_object       = me
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.
*  ELSE.              "Grill, med-31614
  ENDIF.
*-- End Grill, ID-16401

* Get all cordtyp.
  CALL METHOD lr_corder->get_t_cordtyp
    IMPORTING
      et_cordtyp = lt_cordtyp.

* Get the first cordtyp.
  READ TABLE lt_cordtyp INTO lr_cordtyp_first INDEX 1.
*-- ENDIF

* cordtitle
  IF g_prealloc_done_cordtitle = off.
    IF ls_n1corder-cordtitle IS INITIAL.
*-- begin Grill, med-31614
      IF lr_cordtyp_profile IS BOUND.
        ls_n1corder-cordtitle     = lr_cordtyp_profile->get_cordtname( ).
        ls_n1corder_x-cordtitle   = ls_n1corder-cordtitle.
        ls_n1corder_x-cordtitle_x = on.
      ELSEIF lr_cordtyp_first IS BOUND.
*-- end Grill, med-31614
        ls_n1corder-cordtitle     = lr_cordtyp_first->get_cordtname( ).
        ls_n1corder_x-cordtitle   = ls_n1corder-cordtitle.
        ls_n1corder_x-cordtitle_x = on.
      ENDIF.            "Grill, med-31614
    ENDIF.
*   Handle g_prealloc_done_cordtitle
    IF NOT ls_n1corder-cordtitle IS INITIAL.
      g_prealloc_done_cordtitle = on.
    ENDIF.
  ENDIF.

* wlsta
  IF g_prealloc_done_wlsta = off.
    IF ls_n1corder-wlsta IS INITIAL AND
       NOT lr_cordtyp_first IS INITIAL.
      DO 1 TIMES.
*       Get the waiting list compdef.
        CALL METHOD cl_ish_compdef=>get_compdef
          EXPORTING
            i_obtyp    = cl_ish_cordtyp=>co_obtyp
            i_classid  = cl_ish_comp_waiting_list=>co_classid
          IMPORTING
            er_compdef = lr_compdef_wl.
        CHECK NOT lr_compdef_wl IS INITIAL.
*       Get the first cordtyp which has the waiting list component.
        CLEAR lr_cordtyp_wl.
        LOOP AT lt_cordtyp INTO lr_cordtyp.
          CHECK NOT lr_cordtyp IS INITIAL.
          IF lr_cordtyp->has_ass_compdef( lr_compdef_wl ) = on.
            lr_cordtyp_wl = lr_cordtyp.
            EXIT.
          ENDIF.
        ENDLOOP.
*       If no cordtyp has the waiting list component
*         -> use the first cordtyp for wlsta preallocation.
        IF lr_cordtyp_wl IS INITIAL.
          lr_cordtyp_wl = lr_cordtyp_first.
        ENDIF.
*       Prealloc wlsta.
        ls_n1corder-wlsta     = lr_cordtyp_wl->get_wlsta( ).
        ls_n1corder_x-wlsta   = ls_n1corder-wlsta.
        ls_n1corder_x-wlsta_x = on.
      ENDDO.
    ENDIF.
*   Handle g_prealloc_done_wlsta
    IF NOT ls_n1corder-wlsta IS INITIAL.
      g_prealloc_done_wlsta = on.
    ENDIF.
  ENDIF.

* Change corder data.
  IF NOT ls_n1corder_x IS INITIAL.
    CALL METHOD lr_corder->change
      EXPORTING
        is_corder_x     = ls_n1corder_x
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Preallocation done
  IF g_prealloc_done_orddep    = on AND
     g_prealloc_done_rckruf    = on AND
     g_prealloc_done_cordtitle = on AND
     g_prealloc_done_wlsta     = on.
    g_prealloc_done = on.
  ENDIF.

ENDMETHOD.


METHOD transport_from_screen_internal.

  DATA: lr_scr_order  TYPE REF TO cl_ish_scr_order.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_order=>co_otype_scr_order ) = on.
    lr_scr_order ?= ir_screen.
    CALL METHOD trans_from_scr_order
      EXPORTING
        ir_scr_order    = lr_scr_order
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD transport_to_screen_internal.

  DATA: lr_scr_order  TYPE REF TO cl_ish_scr_order.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_order=>co_otype_scr_order ) = on.
    lr_scr_order ?= ir_screen.
    CALL METHOD trans_to_scr_order
      EXPORTING
        ir_scr_order    = lr_scr_order
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_corder_from_fv_order .

  DATA: ls_n1corder  TYPE n1corder,
        l_etrby      TYPE n1corder-etrby. "Grill, ID-16902

  FIELD-SYMBOLS: <ls_field_val>  TYPE rnfield_value.

  CHECK NOT ir_scr_order IS INITIAL.

* Get corder data
  ls_n1corder = get_n1corder( ).

  LOOP AT it_field_val ASSIGNING <ls_field_val>.
    CASE <ls_field_val>-fieldname.

*     etrby
      WHEN ir_scr_order->g_fieldname_etrby.
        l_etrby = <ls_field_val>-value. "Grill, ID-16902
        CHECK ls_n1corder-etrby NE <ls_field_val>-value. "Grill, ID-16902
        cs_n1corder_x-etrby   = <ls_field_val>-value.
        cs_n1corder_x-etrby_x = on.
*     ordpri
      WHEN ir_scr_order->g_fieldname_ordpri.
        CHECK ls_n1corder-ordpri NE <ls_field_val>-value. "Grill, ID-16902
        cs_n1corder_x-ordpri   = <ls_field_val>-value.
        cs_n1corder_x-ordpri_x = on.
*     wlsta
      WHEN ir_scr_order->g_fieldname_wlsta.
        CHECK ls_n1corder-wlsta NE <ls_field_val>-value. "Grill, ID-16902
        cs_n1corder_x-wlsta   = <ls_field_val>-value.
        cs_n1corder_x-wlsta_x = on.
*     gpart
      WHEN ir_scr_order->g_fieldname_gpart.
        CHECK ls_n1corder-etrgp NE <ls_field_val>-value. "Grill, ID-16902
        cs_n1corder_x-etrgp   = <ls_field_val>-value.
        cs_n1corder_x-etrgp_x = on.
*     orddep
      WHEN ir_scr_order->g_fieldname_orddep.
        CHECK ls_n1corder-orddep NE <ls_field_val>-value. "Grill, ID-16902
        cs_n1corder_x-orddep   = <ls_field_val>-value.
        cs_n1corder_x-orddep_x = on.
*     prgnr
      WHEN ir_scr_order->g_fieldname_prgnr.
        CHECK ls_n1corder-prgnr NE <ls_field_val>-value. "Grill, ID-16902
        cs_n1corder_x-prgnr   = <ls_field_val>-value.
        cs_n1corder_x-prgnr_x = on.
*     rckruf
      WHEN ir_scr_order->g_fieldname_rckruf.
        CHECK ls_n1corder-rckruf NE <ls_field_val>-value. "Grill, ID-16902
        cs_n1corder_x-rckruf   = <ls_field_val>-value.
        cs_n1corder_x-rckruf_x = on.
*     cordtitle
      WHEN ir_scr_order->g_fieldname_cordtitle.
        CHECK ls_n1corder-cordtitle NE <ls_field_val>-value."Grill, ID-16902
        cs_n1corder_x-cordtitle   = <ls_field_val>-value.
        cs_n1corder_x-cordtitle_x = on.
    ENDCASE.

  ENDLOOP.

* Handle ETROE/ETRGP.
  LOOP AT it_field_val ASSIGNING <ls_field_val>.
    CASE <ls_field_val>-fieldname.
      WHEN ir_scr_order->g_fieldname_etroegp.
*-- begin delete, Grill ID-16902
*        IF cs_n1corder_x-etrby <> ls_n1corder-etrby.
*          IF cs_n1corder_x-etrby = cl_ish_corder=>co_etrby_oe.
*-- end delete, Grill ID-16902
        IF l_etrby <> ls_n1corder-etrby. "Grill, ID-16902
          IF l_etrby = cl_ish_corder=>co_etrby_oe. "Grill, ID-16902
*-- Grill, ID-19049
            IF ls_n1corder-etrby IS INITIAL.
              cs_n1corder_x-etroe = <ls_field_val>-value.
              cs_n1corder_x-etroe_x = on.
            ENDIF.
*-- Grill, ID-19049
*-- begin delete, Grill, ID-18682
*            IF <ls_field_val>-value <> ls_n1corder-etrgp.
*              cs_n1corder_x-etroe   = <ls_field_val>-value.
*              cs_n1corder_x-etroe_x = on.
*            ENDIF.
*-- end delete, Grill, ID-18682
*-- begin Grill, ID-16902
* ELSEIF cs_n1corder_x-etrby = cl_ish_corder=>co_etrby_gp.
          ELSEIF l_etrby = cl_ish_corder=>co_etrby_gp.
*-- end Grill, ID-16902
*-- begin Grill, ID-18682
*            IF <ls_field_val>-value <> ls_n1corder-etroe.
*              cs_n1corder_x-etrgp   = <ls_field_val>-value.
*              cs_n1corder_x-etrgp_x = on.
            CLEAR cs_n1corder_x-etroe.
            cs_n1corder_x-etroe_x = on.
*            ENDIF.
*-- end Grill, ID-18682
          ENDIF.
        ELSE.
*-- begin Grill, ID-16902
*          IF cs_n1corder_x-etrby = cl_ish_corder=>co_etrby_oe.
          IF l_etrby = cl_ish_corder=>co_etrby_oe.
*-- end Grill, ID-16902
            cs_n1corder_x-etroe   = <ls_field_val>-value.
            cs_n1corder_x-etroe_x = on.
*-- Beginn Grill, ID-16902
*          ELSEIF cs_n1corder_x-etrby = cl_ish_corder=>co_etrby_gp.
          ELSEIF l_etrby = cl_ish_corder=>co_etrby_gp.
*-- end Grill, ID-16902
            cs_n1corder_x-etrgp   = <ls_field_val>-value.
            cs_n1corder_x-etrgp_x = on.
          ENDIF.
        ENDIF.
    ENDCASE.
  ENDLOOP.

* convert some fields from extern to intern values
  CALL METHOD cl_ish_utl_base_conv=>conv_char_to_intern
    EXPORTING
      i_length = 10
    CHANGING
      c_value  = cs_n1corder_x-etrgp.
  CALL METHOD cl_ish_utl_base_conv=>conv_char_to_intern
    EXPORTING
      i_length = 8
    CHANGING
      c_value  = cs_n1corder_x-etroe.
  CALL METHOD cl_ish_utl_base_conv=>conv_char_to_intern
    EXPORTING
      i_length = 8
    CHANGING
      c_value  = cs_n1corder_x-orddep.

ENDMETHOD.


METHOD trans_corder_from_scr_order .

  DATA: lt_field_val    TYPE ish_t_field_value,
        ls_n1corder_x   TYPE rn1_corder_x,
        ls_n1corder_old TYPE n1corder,
        ls_n1corder_new TYPE n1corder.

  FIELD-SYMBOLS: <ls_field_val>  TYPE rnfield_value.

  CHECK NOT ir_corder    IS INITIAL.
  CHECK NOT ir_scr_order IS INITIAL.

* Get (old) corder data.
  CALL METHOD ir_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder_old
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

* Get screen values.
  CALL METHOD ir_scr_order->get_fields
    IMPORTING
      et_field_values = lt_field_val
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Build ls_n1corder_x.
  CLEAR ls_n1corder_x.
  CALL METHOD trans_corder_from_fv_order
    EXPORTING
      ir_scr_order    = ir_scr_order
      it_field_val    = lt_field_val
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cs_n1corder_x   = ls_n1corder_x
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Change corder data.
  CALL METHOD ir_corder->change
    EXPORTING
      is_corder_x     = ls_n1corder_x
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get (new) corder data.
  CALL METHOD ir_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder_new
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

* Raise event ev_etr_changed.
  IF ls_n1corder_old-etrby <> ls_n1corder_new-etrby       OR
     ( ls_n1corder_new-etrby = cl_ish_corder=>co_etrby_oe AND
       ls_n1corder_old-etroe <> ls_n1corder_new-etroe )   OR
      ls_n1corder_new-etrby = cl_ish_corder=>co_etrby_gp
*             AND                                                 "MED-48187 AGujev
*       ls_n1corder_old-etrgp <> ls_n1corder_new-etrgp )   OR     "MED-48187 AGujev
        OR                                                        "MED-48187 AGujev
      ( ls_n1corder_old-orddep <> ls_n1corder_new-orddep ).     "Grill, ID-20531
    RAISE EVENT ev_etr_changed
      EXPORTING
        ir_corder   = ir_corder
        i_etrby_old = ls_n1corder_old-etrby
        i_etrby_new = ls_n1corder_new-etrby
        i_etroe_old = ls_n1corder_old-etroe
        i_etroe_new = ls_n1corder_new-etroe
        i_etrgp_old = ls_n1corder_old-etrgp
        i_etrgp_new = ls_n1corder_new-etrgp
        i_orddep_new  = ls_n1corder_new-orddep  "Grill, ID-20531
        i_orddep_old  = ls_n1corder_old-orddep. "Grill, ID-20531
  ENDIF.

ENDMETHOD.


METHOD trans_corder_to_fv_order .

  DATA: ls_field_val          TYPE rnfield_value,
        ls_n1corder           TYPE n1corder.

  ls_n1corder = is_n1corder.

* convert some fields from intern to extern values
  CALL METHOD cl_ish_utl_base_conv=>conv_char_to_extern
    CHANGING
      c_value = ls_n1corder-etrgp.
  CALL METHOD cl_ish_utl_base_conv=>conv_char_to_extern
    CHANGING
      c_value = ls_n1corder-etroe.
  CALL METHOD cl_ish_utl_base_conv=>conv_char_to_extern
    CHANGING
      c_value = ls_n1corder-orddep.

* etrby
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_order=>g_fieldname_etrby.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1corder-etrby.
  INSERT ls_field_val INTO TABLE ct_field_val.

* ordpri
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_order=>g_fieldname_ordpri.
  ls_field_val-type      = co_fvtype_single.
* MED-30413 - Begin
* if variable ordpri is initial ('000' - numeric) clear fieldvalue-value (char)
* if the field is marked as an obligatory field the check will not catch the initial
* value
*  IF ls_n1corder-ordpri IS INITIAL.  "KG, MED-8608
*    CLEAR ls_field_val-value.        "KG, MED-8608
*  ELSE.                              "KG, MED-8608
    ls_field_val-value     = ls_n1corder-ordpri.
*  ENDIF.                             "KG, MED-8608
* MED-30413 - End
  INSERT ls_field_val INTO TABLE ct_field_val.

* wlsta
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_order=>g_fieldname_wlsta.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1corder-wlsta.
  INSERT ls_field_val INTO TABLE ct_field_val.

* gpart
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_order=>g_fieldname_gpart.
  ls_field_val-type      = co_fvtype_single.
*  ls_field_val-value     = ls_n1corder-etrgp. "Grill, ID-20496
*-- begin Grill, ID-20496
  IF is_n1corder-etrby = cl_ish_corder=>co_etrby_oe.
    ls_field_val-value     = ls_n1corder-etrgp.
  ENDIF.
*-- end Grill, ID-20496
  INSERT ls_field_val INTO TABLE ct_field_val.

* etroegp
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_order=>g_fieldname_etroegp.
  ls_field_val-type      = co_fvtype_single.
  IF is_n1corder-etrby = cl_ish_corder=>co_etrby_oe.
    ls_field_val-value   = ls_n1corder-etroe.
  ELSE.
    ls_field_val-value   = ls_n1corder-etrgp.
  ENDIF.
  INSERT ls_field_val INTO TABLE ct_field_val.

* orddep
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_order=>g_fieldname_orddep.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1corder-orddep.
  INSERT ls_field_val INTO TABLE ct_field_val.

* prgnr
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_order=>g_fieldname_prgnr.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1corder-prgnr.
  INSERT ls_field_val INTO TABLE ct_field_val.

* rckruf
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_order=>g_fieldname_rckruf.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1corder-rckruf.
  INSERT ls_field_val INTO TABLE ct_field_val.

* cordtitle
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_order=>g_fieldname_cordtitle.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1corder-cordtitle.
  INSERT ls_field_val INTO TABLE ct_field_val.

ENDMETHOD.


METHOD trans_corder_to_scr_order .

  DATA: ls_n1corder           TYPE n1corder,
        lt_field_val          TYPE ish_t_field_value.

  CHECK NOT ir_corder    IS INITIAL.
  CHECK NOT ir_scr_order IS INITIAL.

* Get corder data.
  CALL METHOD ir_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Build field values.
  CLEAR lt_field_val.
  CALL METHOD trans_corder_to_fv_order
    EXPORTING
      ir_corder       = ir_corder
      is_n1corder     = ls_n1corder
    IMPORTING
      e_rc            = e_rc
    CHANGING
      ct_field_val    = lt_field_val
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Set main object in order screen.
  CALL METHOD ir_scr_order->set_data
    EXPORTING
      i_main_object   = ir_corder
      i_main_object_x = on
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Set field values in order screen.
  CALL METHOD ir_scr_order->set_fields
    EXPORTING
      it_field_values  = lt_field_val
      i_field_values_x = on
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD trans_from_scr_order .

  DATA: lr_corder  TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object  IS INITIAL.
  CHECK NOT ir_scr_order    IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD trans_corder_from_scr_order
      EXPORTING
        ir_corder       = lr_corder
        ir_scr_order    = ir_scr_order
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_to_scr_order .

  DATA: lr_corder  TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object  IS INITIAL.
  CHECK NOT ir_scr_order    IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD trans_corder_to_scr_order
      EXPORTING
        ir_corder       = lr_corder
        ir_scr_order    = ir_scr_order
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.
ENDCLASS.
