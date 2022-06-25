class CL_ISH_SCR_WAITING_LIST definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

public section.
*"* public components of class CL_ISH_SCR_WAITING_LIST
*"* do not include other source files here!!!

  class-data G_PREFIX_FIELDNAME type ISH_FIELDNAME read-only value 'RN1_DYNP_WAITING_LIST'. "#EC NOTEXT .
  constants CO_DEFAULT_TABNAME type TABNAME value 'N1CORDER'. "#EC NOTEXT
  class-data G_FIELDNAME_WLRRN type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_WLTYP type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_WLPRI type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_WLADT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_WLRDT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_WLHSP type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_WLHSP_TXT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_ABSBDT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_ABSEDT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_ABSRSNTX type ISH_FIELDNAME read-only .
  constants CO_OTYPE_SCR_WAITING_LIST type ISH_OBJECT_TYPE value 7038. "#EC NOTEXT

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCR_WAITING_LIST
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DYNPRO_WAITING_LIST
    exporting
      value(E_PGM_WAITING_LIST) type SY-REPID
      value(E_DYNNR_WAITING_LIST) type SY-DYNNR .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~GET_FIELDS_DEFINITION
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~SET_CURSOR
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_FROM_DY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_WAITING_LIST
*"* do not include other source files here!!!

  data GR_WAITING_LIST_SUBSCREEN type ref to CL_ISH_SUBSCR_WAITINGLIST_CORD .
  data G_PGM_WAITING_LIST type SY-REPID .
  data G_DYNNR_WAITING_LIST type SY-DYNNR .

  methods GET_CORDER
    returning
      value(RR_CORDER) type ref to CL_ISH_CORDER .

  methods BUILD_MESSAGE
    redefinition .
  methods FILL_T_SCRM_FIELD
    redefinition .
  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods INITIALIZE_INTERNAL
    redefinition .
  methods INITIALIZE_PARENT
    redefinition .
  methods IS_MESSAGE_HANDLED
    redefinition .
  methods MODIFY_SCREEN_INTERNAL
    redefinition .
  methods MODIFY_SCREEN_STD
    redefinition .
  methods CHECK_MANDATORY_FIELDS
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_WAITING_LIST
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_WAITING_LIST IMPLEMENTATION.


METHOD build_message .


* Call super method.
  CALL METHOD super->build_message
    EXPORTING
      is_message    = is_message
      i_cursorfield = i_cursorfield
    IMPORTING
      es_message    = es_message.

*-- begin Grill, med-34087
** Handle only errors on selfs main object.
*  IF NOT is_message-object IS INITIAL AND
*     NOT is_message-object = gr_main_object.
*    CLEAR: es_message-parameter,
*           es_message-field.
*    EXIT.
*  ENDIF.
*-- end Grill, med-34087


* Wrap es_message-parameter.
  CASE es_message-parameter.
    WHEN 'N1CORDER'.
      es_message-parameter = g_prefix_fieldname.
*-- begin Grill, MED-34087
    WHEN 'ABSBDT'.
      es_message-parameter = 'NWLM'.
      es_message-field = g_fieldname_absbdt.
    WHEN 'ABSEDT'.
      es_message-parameter = 'NWLM'.
      es_message-field = g_fieldname_absedt.
    WHEN 'ABSRSNTX'.
      es_message-parameter = 'NWLM'.
      es_message-field = g_fieldname_absrsntx.
*-- end Grill, MED-34087
  ENDCASE.

*-- begin Grill, med-34087
* set cursor
  IF NOT gr_waiting_list_subscreen IS INITIAL.
    CALL METHOD gr_waiting_list_subscreen->set_cursor
      CHANGING
        c_rn1message = is_message.
  ENDIF.
*-- end Grill, MED-34087

ENDMETHOD.


METHOD check_mandatory_fields.

  TYPES: BEGIN OF scrm_fattr,
           n1scrm  TYPE n1scrm,
           n1fattr TYPE n1fattr,
         END   OF scrm_fattr.

  DATA: l_rc                       TYPE ish_method_rc,
        lr_main_object             TYPE REF TO if_ish_identify_object,
        lr_corder                  TYPE REF TO cl_ish_corder,
        lt_cordpos                 TYPE ish_t_cordpos,
        lr_prereg                  TYPE REF TO cl_ishmed_prereg,
        lr_cordtyp_help            TYPE REF TO cl_ish_cordtyp,
        lt_compdef                 TYPE ish_t_compdef,
        lt_compdef_all             TYPE ish_t_compdef,
        lt_component               TYPE ish_t_component,
        lr_component               TYPE REF TO if_ish_component,
        l_tabix                    TYPE sy-tabix,
        l_delete                   TYPE ish_on_off,
        l_compdef_found            TYPE ish_on_off,
        lr_compdef                 TYPE REF TO cl_ish_compdef,
        lt_screen_objects          TYPE ish_t_screen_objects,
        lt_screen_objects_help     TYPE ish_t_screen_objects,
        lt_screen_objects_all      TYPE ish_t_screen_objects,
        l_screen_found             TYPE ish_on_off,
        lr_config                  TYPE REF TO cl_ishmed_con_corder,
        lt_cordpos_check_mandatory TYPE ish_t_cordpos,
        l_cordpos_found            TYPE ish_on_off,
        lr_cordpos                 TYPE REF TO cl_ishmed_cordpos,
        lr_cordtyp                 TYPE REF TO cl_ishmed_cordtyp,
        l_compid                   TYPE n1compid,
        l_screenid                 TYPE i,
        l_stsma                    TYPE j_stsma,
        l_estat                    TYPE j_estat,
        lt_scrm                    TYPE ishmed_t_scrm,
        lr_scrm                    TYPE REF TO cl_ishmed_scrm,
        ls_n1scrm                  TYPE n1scrm,
        ls_n1fattr                 TYPE n1fattr,
        l_prio                     TYPE n1fattr-prio,
        l_append                   TYPE ish_on_off,
        ls_scrm_fattr              TYPE scrm_fattr,
        lr_fattr                   TYPE REF TO cl_ishmed_fattr,
        lt_scrm_fattr              TYPE TABLE OF scrm_fattr,
        lt_fv                      TYPE ish_t_field_value,
        l_fieldname                TYPE ish_fieldname,
        l_rownumber                TYPE int4,
        l_par                      TYPE bapiret2-parameter,
        l_fld                      TYPE bapiret2-field,
        l_mv1                      TYPE string,
        lt_scrm_field              TYPE ish_t_scrm_field,
        lr_waiting_list            TYPE REF TO cl_ish_comp_waiting_list,
        l_tabix_absedt             TYPE i,
        l_tabix_absrsntx           TYPE i,
        l_tabix_absbdt             TYPE i,
        lr_sub_waiting_list        TYPE REF TO cl_ish_subscr_waitinglist_cord,
        lr_absence_editor          TYPE REF TO cl_ish_absence_editor_cord,
        lt_absences                TYPE ish_t_absence_edit,
        ls_absences                TYPE rnwlm_edit,
        l_must_display             TYPE ish_on_off,
        l_index_absences           TYPE i.

  FIELD-SYMBOLS: <lr_compdef>       TYPE REF TO cl_ish_compdef,
                 <lr_screen_object> TYPE REF TO if_ish_screen,
                 <lr_prereg>        TYPE REF TO cl_ishmed_prereg,
                 <ls_fv>            TYPE rnfield_value,
                 <ls_scrm_field>    TYPE rn1_scrm_field.

*-- Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

*-- No processing in display mode.
  CHECK NOT g_vcode = co_vcode_display.

*-- Get screen's main object.
  lr_main_object = me->get_main_object( ).
  CHECK NOT lr_main_object IS INITIAL.

*-- Process only if main object is a corder.
  CHECK lr_main_object->is_inherited_from(
              cl_ishmed_corder=>co_otype_corder_med ) = on.

*-- Get the corder object.
  lr_corder ?= lr_main_object.

*-- get all corder positions
  CALL METHOD lr_corder->get_t_cordpos
    IMPORTING
      et_cordpos      = lt_cordpos
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

*-- Get component definitions of all cordpos that must be checked.
  LOOP AT lt_cordpos INTO lr_prereg.
*-- Get cordtyp from cordpos.
    CALL METHOD lr_prereg->get_cordtyp
      RECEIVING
        rr_cordtyp = lr_cordtyp_help.
    CHECK lr_cordtyp_help IS BOUND.
*-- Get component definitions from cordtyp.
    CALL METHOD lr_cordtyp_help->get_t_compdef
      RECEIVING
        rt_compdef = lt_compdef.
    APPEND LINES OF lt_compdef TO lt_compdef_all.
  ENDLOOP.

*-- Get corder's header components.
  CALL METHOD lr_corder->get_t_comphead
    IMPORTING
      et_component = lt_component.
  CHECK NOT lt_component IS INITIAL.

*-- Get corder's header components of all cordpos that must be checked.
  LOOP AT lt_component INTO lr_component.
    l_tabix = sy-tabix.
    l_delete = off.
    l_compdef_found = off.
    IF lr_component->is_inherited_from( i_object_type = cl_ish_comp_waiting_list=>co_otype_comp_waiting_list ) = off.
      l_delete = on.
    ENDIF.

    CALL METHOD lr_component->get_compdef
      RECEIVING
        rr_compdef = lr_compdef.
    CHECK lr_compdef IS BOUND.
    LOOP AT lt_compdef_all ASSIGNING <lr_compdef>.
      CHECK <lr_compdef> = lr_compdef.
      l_compdef_found = on.
      EXIT.
    ENDLOOP.
    CHECK l_compdef_found = off OR l_delete = on.
    DELETE lt_component INDEX l_tabix.
  ENDLOOP.

*-- Get header component's screens.
  LOOP AT lt_component INTO lr_component.
    CHECK lr_component IS BOUND.
    REFRESH lt_screen_objects.
    CALL METHOD lr_component->get_defined_screens
      RECEIVING
        rt_screen_objects = lt_screen_objects.
    LOOP AT lt_screen_objects ASSIGNING <lr_screen_object>.
      CHECK <lr_screen_object> IS BOUND.
      REFRESH lt_screen_objects_help.
      CALL METHOD cl_ish_utl_screen=>get_screen_instances
        EXPORTING
          i_screen       = <lr_screen_object>
          i_embedded_scr = on
        IMPORTING
          et_screens     = lt_screen_objects_help
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      APPEND LINES OF lt_screen_objects_help TO lt_screen_objects_all.
    ENDLOOP.
  ENDLOOP.

*-- Does screen belong to one of the remaining
*-- header components?
  l_screen_found = off.
  LOOP AT lt_screen_objects_all ASSIGNING <lr_screen_object>.
    CHECK <lr_screen_object> = me.
    l_screen_found = on.
    EXIT.
  ENDLOOP.

*-- Do mandatory checks for imported screen?
  CHECK l_screen_found = on.

*-- Loop cordpos objects.
  LOOP AT lt_cordpos INTO lr_prereg.
*-- casting
    lr_cordpos ?= lr_prereg.
*-- get cordtyp
    lr_cordtyp = lr_cordpos->get_cordtyp_med( ).
*-- Process only if there is already a cordtyp.
    CHECK NOT lr_cordtyp IS INITIAL.

*-- Is there a configuration?
    IF gr_config IS BOUND.
*-- castings.
      lr_config ?= gr_config.
      IF lr_config IS BOUND AND lr_prereg IS BOUND.
*-- Get config's cordpos table.
        CALL METHOD lr_config->get_cordpos_check_mandatory
          RECEIVING
            rt_cordpos_check_mandatory = lt_cordpos_check_mandatory.
        l_cordpos_found = off.
        LOOP AT lt_cordpos_check_mandatory ASSIGNING <lr_prereg>.
          CHECK <lr_prereg> = lr_prereg.
          l_cordpos_found = on.
          EXIT.
        ENDLOOP.
*-- Cordpos not found => no mandatory checks.
        CHECK l_cordpos_found = on.
      ENDIF.
    ENDIF.

*-- Get the compid for screen.
    CLEAR l_compid.
    READ TABLE lt_component INTO lr_component INDEX 1.
    CHECK NOT lr_component IS INITIAL.
    CHECK lr_component->is_screen_supported( me ) = on.
    l_compid = lr_component->get_compid( ).
    CHECK NOT l_compid IS INITIAL.

*-- Get the screenid.
*    CALL METHOD me->get_type
*      IMPORTING
*        e_object_type = l_screenid.
    l_screenid = me->get_screenid( ).
    CHECK NOT l_screenid IS INITIAL.

*-- Get the actual stsma + estat.
    CALL METHOD lr_cordpos->get_status
      IMPORTING
        e_stsma         = l_stsma
        e_estat         = l_estat
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK NOT l_stsma IS INITIAL.
    CHECK NOT l_estat IS INITIAL.

*--Get the defined scrm definitions.
    CALL METHOD lr_cordtyp->get_t_scrm
      EXPORTING
        i_compid        = l_compid
        i_screenid      = l_screenid
        i_stsma         = l_stsma
        i_estat         = l_estat
        i_fattr_type_id = cl_ishmed_fattr_type=>co_display
      IMPORTING
        et_scrm         = lt_scrm.

*-- Build table for mandatory check.
    LOOP AT lt_scrm INTO lr_scrm.
*-- Get SCRM data.
      CHECK NOT lr_scrm IS INITIAL.
      CALL METHOD lr_scrm->get_data
        RECEIVING
          rs_n1scrm = ls_n1scrm.
*-- Get FATTR data.
      CALL METHOD lr_scrm->get_fattr
        RECEIVING
          rr_fattr = lr_fattr.
      CHECK NOT lr_fattr IS INITIAL.
      CALL METHOD lr_fattr->get_data
        RECEIVING
          rs_n1fattr = ls_n1fattr.
*--  Check for an existing entry.
      CLEAR: ls_scrm_fattr, l_append.
      READ TABLE lt_scrm_fattr
      WITH KEY n1scrm-compid    = ls_n1scrm-compid
               n1scrm-fieldname = ls_n1scrm-fieldname
      INTO ls_scrm_fattr.
      IF sy-subrc = 0.
*-- Compare priority (0001-high ... 9999-low).
        IF ls_scrm_fattr-n1fattr-prio > ls_n1fattr-prio.
*-- Delete existing entry with lower priority.
          DELETE lt_scrm_fattr INDEX sy-tabix.
          l_append = on.
        ENDIF.
      ELSE.
        l_append = on.
      ENDIF.
      IF l_append = on.
        CLEAR ls_scrm_fattr.
        ls_scrm_fattr-n1scrm  = ls_n1scrm.
        ls_scrm_fattr-n1fattr = ls_n1fattr.
        APPEND ls_scrm_fattr TO lt_scrm_fattr.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

* Get field values.
  CALL METHOD get_fields
    IMPORTING
      et_field_values = lt_fv
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Check against the screen modification definitions.
  LOOP AT lt_fv ASSIGNING <ls_fv>.
*   Check the sub field values.
    LOOP AT lt_scrm INTO lr_scrm.

      CHECK NOT lr_scrm IS INITIAL.

*     Process only mandatory fields.
      CHECK lr_scrm->get_fattr_value_id( ) =
              cl_ishmed_fattr_value=>co_display_must.

*     Get the field's name.
      l_fieldname = lr_scrm->get_fieldname( ).

*-- begin Test
      IF l_fieldname = 'ABSEDT' OR
         l_fieldname = 'ABSBDT' OR
         l_fieldname = 'ABSRSNTX'.
        IF gr_waiting_list_subscreen IS BOUND.
          lr_sub_waiting_list ?= gr_waiting_list_subscreen.
          lr_absence_editor = gr_waiting_list_subscreen->g_absence_editor.
          IF lr_absence_editor IS BOUND.
            CALL METHOD lr_absence_editor->get_datas
              IMPORTING
                e_rc           = l_rc
                et_absences    = lt_absences
              CHANGING
                c_errorhandler = cr_errorhandler.
            IF l_rc NE 0.
              e_rc = l_rc.
              EXIT.
            ENDIF.
            CLEAR: l_index_absences.
            LOOP AT lt_absences INTO ls_absences.
              l_index_absences = l_index_absences + 1.
              IF l_fieldname = 'ABSEDT'.
                CHECK ls_absences-absedt IS INITIAL.
                l_must_display = on.
              ELSEIF l_fieldname EQ 'ABSBDT'.
                CHECK ls_absences-absbdt IS INITIAL.
                l_must_display = on.
              ELSEIF l_fieldname EQ 'ABSRSNTX'.
                CHECK ls_absences-absrsntx IS INITIAL.
                l_must_display = on.
              ENDIF.
            ENDLOOP.
            CHECK l_must_display EQ on OR lt_absences IS INITIAL.
            l_must_display = off.
*     Get l_par + l_fld.
            SPLIT l_fieldname
              AT   '-'
              INTO l_par
                   l_fld.
*     Get the label of the invald field.
            lt_scrm_field = get_t_scrm_field( ).
            READ TABLE lt_scrm_field
              WITH KEY fieldname = l_fieldname
              ASSIGNING <ls_scrm_field>.
            IF sy-subrc = 0.
              l_mv1 = <ls_scrm_field>-fieldlabel.
            ELSE.
              l_mv1 = l_fld.
            ENDIF.
            IF l_index_absences = '0'.
              l_index_absences = l_index_absences + 1.
            ENDIF.

*     Add an error message.
            CALL METHOD cl_ish_utl_base=>collect_messages
              EXPORTING
                i_typ           = 'E'
                i_kla           = 'N1BASE'
                i_num           = '062'
                i_par           = l_par
                i_field         = l_fld
                i_row           = l_index_absences
                i_mv1           = l_mv1
                ir_object       = lr_cordpos
              CHANGING
                cr_errorhandler = cr_errorhandler.
            e_rc = 1.
          ELSE.
*     Get l_par + l_fld.
            SPLIT l_fieldname
              AT   '-'
              INTO l_par
                   l_fld.
*     Get the label of the invald field.
            lt_scrm_field = get_t_scrm_field( ).
            READ TABLE lt_scrm_field
              WITH KEY fieldname = l_fieldname
              ASSIGNING <ls_scrm_field>.
            IF sy-subrc = 0.
              l_mv1 = <ls_scrm_field>-fieldlabel.
            ELSE.
              l_mv1 = l_fld.
            ENDIF.
*     Add an error message.
            CALL METHOD cl_ish_utl_base=>collect_messages
              EXPORTING
                i_typ           = 'E'
                i_kla           = 'N1BASE'
                i_num           = '062'
                i_par           = l_par
                i_field         = l_fld
                i_row           = '1'
                i_mv1           = l_mv1
                ir_object       = lr_cordpos
              CHANGING
                cr_errorhandler = cr_errorhandler.
            e_rc = 1.
          ENDIF.
        ENDIF.
      ELSE.
*-- end Test
**     determine if the field is empty (initial).
*      l_rownumber = <ls_fv>-fieldname.
        l_rownumber = sy-tabix.
        CHECK is_field_initial(
              i_fieldname = l_fieldname
              i_rownumber = l_rownumber ) = on.
*     This field is invalid
*       -> add an errormessage and set returncode.
        e_rc = 1.

*     Get l_par + l_fld.
        SPLIT l_fieldname
          AT   '-'
          INTO l_par
               l_fld.
*     Get the label of the invald field.
        lt_scrm_field = get_t_scrm_field( ).
        READ TABLE lt_scrm_field
          WITH KEY fieldname = l_fieldname
          ASSIGNING <ls_scrm_field>.
        IF sy-subrc = 0.
          l_mv1 = <ls_scrm_field>-fieldlabel.
        ELSE.
          l_mv1 = l_fld.
        ENDIF.
*     Add an error message.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = '062'
            i_par           = l_par
            i_field         = l_fld
            i_mv1           = l_mv1
            ir_object       = lr_cordpos
          CHANGING
            cr_errorhandler = cr_errorhandler.

      ENDIF.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.


METHOD class_constructor .

* Set fieldnames
  g_fieldname_wltyp     = 'RN1_DYNP_WAITING_LIST-WLTYP'.
  g_fieldname_wlpri     = 'RN1_DYNP_WAITING_LIST-WLPRI'.
  g_fieldname_wladt     = 'RN1_DYNP_WAITING_LIST-WLADT'.
  g_fieldname_wlrrn     = 'RN1_DYNP_WAITING_LIST-WLRRN'.
  g_fieldname_wlrdt     = 'RN1_DYNP_WAITING_LIST-WLRDT'.
  g_fieldname_wlhsp     = 'RN1_DYNP_WAITING_LIST-WLHSP'.
  g_fieldname_wlhsp_txt = 'RN1_DYNP_WAITING_LIST-WLHSP_TXT'.

*-- begin Grill, med-34087
  g_fieldname_absbdt    = 'ABSBDT'.
  g_fieldname_absedt    = 'ABSEDT'.
  g_fieldname_absrsntx  = 'ABSRSNTX'.
*  g_fieldname_absbdt    = 'NWLM-ABSBDT'.
*  g_fieldname_absedt    = 'NWLM-ABSEDT'.
*  g_fieldname_absrsntx  = 'NWLM-ABSRSNTX'.
*-- end Grill, med-34087

ENDMETHOD.


METHOD constructor .

* Construct super class(es).
  CALL METHOD super->constructor.

* Set gr_default_tabname.
  GET REFERENCE OF co_default_tabname INTO gr_default_tabname.

ENDMETHOD.


METHOD CREATE .

* create instance for errorhandling if necessary
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* create instance
  CREATE OBJECT er_instance
    EXCEPTIONS
      instance_not_possible = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
    e_rc = 1.
*   the instance couldn't be created
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '003'
        i_mv1           = 'CL_ISH_SCR_WAITING_LIST'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD fill_t_scrm_field .

  DATA: ls_scrm_field  TYPE rn1_scrm_field.

  REFRESH gt_scrm_field.

* wladt
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_wladt.
  ls_scrm_field-fieldlabel = 'AufnDatum'(002).
  APPEND ls_scrm_field TO gt_scrm_field.

* wlhsp
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_wlhsp.
  ls_scrm_field-fieldlabel = 'Beh. Krankenh.'(003).
  APPEND ls_scrm_field TO gt_scrm_field.

* wlpri
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_wlpri.
  ls_scrm_field-fieldlabel = 'Wartelistenprio'(004).
  APPEND ls_scrm_field TO gt_scrm_field.

* wlrdt
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_wlrdt.
  ls_scrm_field-fieldlabel = 'EntfDatum'(005).
  APPEND ls_scrm_field TO gt_scrm_field.

* wlrrn
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_wlrrn.
  ls_scrm_field-fieldlabel = 'Entfernung'(006).
  APPEND ls_scrm_field TO gt_scrm_field.

* wltyp
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_wltyp.
  ls_scrm_field-fieldlabel = 'Warteliste'(007).
  APPEND ls_scrm_field TO gt_scrm_field.

* absbdt
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_absbdt.
  ls_scrm_field-fieldlabel = 'Beg.Abw.'(009).
  APPEND ls_scrm_field TO gt_scrm_field.

* absedt
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_absedt.
  ls_scrm_field-fieldlabel = 'Endedatum'(010).
  APPEND ls_scrm_field TO gt_scrm_field.

* absrsntx
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_absrsntx.
  ls_scrm_field-fieldlabel = 'Abwesenheitsgrund Text'(011).
  APPEND ls_scrm_field TO gt_scrm_field.

ENDMETHOD.


METHOD get_corder .

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.

  rr_corder ?= gr_main_object.

ENDMETHOD.


METHOD get_dynpro_waiting_list .

  e_pgm_waiting_list = g_pgm_waiting_list.
  e_dynnr_waiting_list = g_dynnr_waiting_list.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~GET_TYPE .

  e_object_type = co_otype_scr_waiting_list.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_waiting_list.
    r_is_inherited_from = on.
  ELSE.
*-- ID-16230
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
*--  r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~destroy .
  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT gr_waiting_list_subscreen IS INITIAL.
    IF NOT gr_waiting_list_subscreen->g_absence_editor IS INITIAL.
      CALL METHOD gr_waiting_list_subscreen->g_absence_editor->destroy.
      CALL METHOD gr_waiting_list_subscreen->destroy.
    ENDIF.
  ENDIF.
ENDMETHOD.


METHOD if_ish_screen~get_fields_definition .

  DATA: ls_parent  TYPE rnscr_parent.

* Use the old subscreen's dynpro.
  ls_parent = gs_parent.
  gs_parent-repid = g_pgm_waiting_list.
  gs_parent-dynnr = g_dynnr_waiting_list.

* Call super method.
  CALL METHOD super->if_ish_screen~get_fields_definition
    IMPORTING
      et_fields_definition = et_fields_definition
      e_rc                 = e_rc
    CHANGING
      c_errorhandler       = c_errorhandler.

* Reset gs_parent.
  gs_parent = ls_parent.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen .

  CALL METHOD gr_waiting_list_subscreen->ok_code_subscreen
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler
      c_okcode       = c_okcode.

ENDMETHOD.


METHOD if_ish_screen~set_cursor .

*  CALL METHOD super->if_ish_screen~set_cursor
*    EXPORTING
*      i_rn1message   = i_rn1message
*      i_cursorfield  = i_cursorfield
*      i_set_cursor   = i_set_cursor
*    IMPORTING
*      e_cursor_set   = e_cursor_set
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = c_errorhandler.


* Initializations.
  e_cursor_set = off.
  e_rc         = 0.

* Remind message.
  CALL METHOD remind_message
    EXPORTING
      is_message    = i_rn1message
      i_cursorfield = i_cursorfield
    IMPORTING
      e_cursor_set  = e_cursor_set.

  CHECK NOT gr_waiting_list_subscreen IS INITIAL.

*  CHECK i_set_cursor = on.     "TEST
  CHECK e_cursor_set EQ on.

* Michael Manoch, 10.08.2004, ID 15151   START
* Process set_cursor of the wl subscreen even if
* gs_message is initial.
* Elsewhere the wl subscreen would hold its old message
* and overwrites the real cursor position.
*  CHECK NOT gs_message IS INITIAL.
* Michael Manoch, 10.08.2004, ID 15151   END

  CALL METHOD gr_waiting_list_subscreen->set_cursor
    CHANGING
      c_rn1message = gs_message.

  e_cursor_set = on.
  CLEAR gs_message.

ENDMETHOD.


METHOD IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY .

* call the fub for component order
  CALL FUNCTION 'ISH_SDY_WAITING_LIST_INIT'
    EXPORTING
      ir_scr_waiting_list    = me
    IMPORTING
      es_parent       = gs_parent
      e_rc            = e_rc
    CHANGING
      cr_dynp_data    = gr_scr_data
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~transport_from_dy .

* Transport is done by old subscreen.

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy .

  DATA: lr_corder     TYPE REF TO cl_ish_corder.

* initialize
  e_rc = 0.

  CHECK NOT gr_waiting_list_subscreen IS INITIAL.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* give the subscreen the actual clinical order
  CALL METHOD gr_waiting_list_subscreen->set_data
    EXPORTING
      i_corder  = lr_corder
      i_vcode   = g_vcode
      i_vcode_x = 'X'.

* give the fub in de subscreen the reference of the screenclass
  CALL FUNCTION 'ISH_SET_SUBSCR_WAITINGLIST_CO'
    EXPORTING
      i_waitinglist_sub = gr_waiting_list_subscreen.

ENDMETHOD.


METHOD initialize_field_values .

  DATA: lt_field_val            TYPE ish_t_field_value,
        ls_field_val            TYPE rnfield_value.

* Initializations.
  e_rc = 0.

* initialize every screen field
  REFRESH lt_field_val.

* wltyp
  CLEAR ls_field_val.
  ls_field_val-fieldname = g_fieldname_wltyp.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.

* wladt
  CLEAR ls_field_val.
  ls_field_val-fieldname = g_fieldname_wladt.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.

* wlrrn
  CLEAR ls_field_val.
  ls_field_val-fieldname = g_fieldname_wlrrn.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.

* wlrdt
  CLEAR ls_field_val.
  ls_field_val-fieldname = g_fieldname_wlrdt.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.

* wlhsp
  CLEAR ls_field_val.
  ls_field_val-fieldname = g_fieldname_wlhsp.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.

* wlpri
  CLEAR ls_field_val.
  ls_field_val-fieldname = g_fieldname_wlpri.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.

* wlhsp_txt
  CLEAR ls_field_val.
  ls_field_val-fieldname = g_fieldname_wlhsp_txt.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.

* set values
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      it_field_values = lt_field_val
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.

ENDMETHOD.


METHOD initialize_internal .

  DATA: l_einri       TYPE tn01-einri.

* initialize
  e_rc = 0.

* set subscreen
  g_pgm_waiting_list   = 'SAPLNCORD'.
  g_dynnr_waiting_list = '0400'.

* Set gr_waiting_list_subscreen.
  IF gr_waiting_list_subscreen IS INITIAL.
*   Get einri.
    l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
    CHECK NOT l_einri IS INITIAL.
*   initialize the screenclass
    CREATE OBJECT gr_waiting_list_subscreen
      EXPORTING
        i_caller      = 'CL_ISH_SCR_WAITING_LIST'
        i_einri       = l_einri
        i_vcode       = g_vcode
        i_environment = gr_environment
        ir_screen     = me.                "RW ID 14654
    e_rc = sy-subrc.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD INITIALIZE_PARENT .

  CLEAR: gs_parent.

  gs_parent-repid = 'SAPLN1_SDY_WAITING_LIST'.
  gs_parent-dynnr = '0100'.
  gs_parent-type = co_scr_parent_type_dynpro.

ENDMETHOD.


METHOD is_message_handled.

  DATA: l_rc            TYPE ish_method_rc,
        l_cursorfield   TYPE ish_fieldname.

  CALL METHOD super->is_message_handled
    EXPORTING
      is_message   = is_message
    RECEIVING
      r_is_handled = r_is_handled.

  CHECK r_is_handled = off AND
        NOT is_message IS INITIAL.

  IF is_message-parameter IS INITIAL.
    l_cursorfield = is_message-field.
  ELSEIF is_message-field IS INITIAL.
    l_cursorfield = is_message-parameter.
  ELSE.
    CONCATENATE is_message-parameter
                is_message-field
           INTO l_cursorfield
      SEPARATED BY '-'.
  ENDIF.

* check fields
  IF l_cursorfield = 'NWLM-ABSBDT' OR
     l_cursorfield = 'NWLM-ABSEDT' OR
     l_cursorfield = 'NWLM-ABSRSNTX'.
    r_is_handled = on.
  ENDIF.

ENDMETHOD.


METHOD modify_screen_internal.

* ED, ID 14654: check also the abscences control!!
  TYPES: BEGIN OF scrm_fattr,
           n1scrm  TYPE n1scrm,
           n1fattr TYPE n1fattr,
         END   OF scrm_fattr.

  DATA: lr_main_object     TYPE REF TO if_ish_identify_object,
        lr_corder          TYPE REF TO cl_ishmed_corder,
        lt_cordpos         TYPE ish_t_cordpos,
        lr_cordpos         TYPE REF TO cl_ishmed_cordpos,
        lr_prereg          TYPE REF TO cl_ishmed_prereg,
        lr_cordtyp         TYPE REF TO cl_ishmed_cordtyp,
        lt_component       TYPE ish_t_component,
        lr_component       TYPE REF TO if_ish_component,
        l_compid           TYPE n1compid,
        l_screenid         TYPE int4,
        l_stsma            TYPE j_stsma,
        l_estat            TYPE j_estat,
        lt_scrm            TYPE ishmed_t_scrm,
        lr_scrm            TYPE REF TO cl_ishmed_scrm,
        ls_n1scrm          TYPE n1scrm,
        lr_fattr           TYPE REF TO cl_ishmed_fattr,
        ls_n1fattr         TYPE n1fattr,
        l_fattr_value_id   TYPE numc4,
        l_modify           TYPE ish_on_off,
        ls_screen          TYPE rn1screen,
        l_rc               TYPE ish_method_rc,
        l_append           TYPE ish_on_off,
        l_fieldname        TYPE ish_fieldname,
        lr_screen          TYPE REF TO if_ish_screen,
        lr_scr_listbox     TYPE REF TO cl_ish_scr_listbox,
        l_active           TYPE ish_on_off,
        l_input            TYPE ish_on_off,
        ls_scrm_fattr      TYPE scrm_fattr,
        lt_scrm_fattr      TYPE TABLE OF scrm_fattr,
        ls_fieldcat        TYPE lvc_s_fcat,
        lt_fieldcat        TYPE lvc_t_fcat,
        lr_absences        TYPE REF TO cl_ish_absence_editor_cord,
        l_set_fieldcatalog TYPE ish_on_off.

  data: lr_ish_corder          TYPE REF TO cl_ish_corder.
  DATA: lt_errors          TYPE ishmed_t_messages.
  DATA: lt_warnings        TYPE ishmed_t_messages.
  DATA: lr_bt_error type REF TO cl_ishmed_errorhandling.

*-- begin Grill, ID-20733
  DATA: lr_screen_values    TYPE REF TO cl_ish_field_values,
        lt_field_values     TYPE ish_t_field_value,
        lt_fieldcat_waiting TYPE lvc_t_fcat.
*-- end Grill, ID-20733

    DATA: lv_count         TYPE i,                              "MED-54884 Cristina Geanta
          lr_abs_container TYPE REF TO cl_gui_custom_container. "MED-54884 Cristina Geanta

** process only if no display!!!
*  CHECK g_vcode <> co_vcode_display.

* CV Italy only (it is relevant though for ish and ishmed)
  call function 'ISH_CHECK_ACTIVE_IT'
   exceptions
     not_active       = 1.
  if sy-subrc = 0.
*   this instance of the errorhandler is only for this situation. the messages
*   will be displayed directly
    IF lr_bt_error IS INITIAL.
      CREATE OBJECT lr_bt_error
        EXPORTING
          i_messages = 'X'.
    ENDIF.
*   Get the corder object.
    lr_ish_corder ?= gr_main_object.

    CALL METHOD LR_ISH_CORDER->CHECK_PREREG_CASE_STATUS_ACT
      IMPORTING
        et_errors  = lt_errors
        et_warnings = lt_warnings.

    if lt_errors is not initial.
      loop at screen.
        case screen-name.
          when 'RN1_DYNP_WAITING_LIST-WLTYP'
            or 'RN1_DYNP_WAITING_LIST-WLADT'
            or 'RN1_DYNP_WAITING_LIST-WLPRI'.
            screen-input = 0.
            modify screen.
        endcase.
      endloop.
      if g_vcode ne co_vcode_display and g_first_time eq on.
        CALL METHOD lr_bt_error->collect_messages
          EXPORTING
             t_messages      = lt_errors.
      endif.
    else.
      if g_vcode ne co_vcode_display and g_first_time eq on.
        CALL METHOD lr_bt_error->collect_messages
          EXPORTING
             t_messages      = lt_warnings.
      endif.
     endif.
  endif.

* Process only if main object is a corder.
  if gr_main_object->is_inherited_from(
              cl_ishmed_corder=>co_otype_corder_med ) = on.

*  CHECK gr_main_object->is_inherited_from(
*              cl_ishmed_corder=>co_otype_corder_med ) = on.
" ======================================================> ISHMED_CORDER
* Get the corder object.
  lr_corder ?= gr_main_object.

* Get corder's header components.
  CALL METHOD lr_corder->get_t_comphead
    IMPORTING
      et_component = lt_component.
  CHECK NOT lt_component IS INITIAL.

* Get corder's cordpos objects.
  CALL METHOD lr_corder->get_t_cordpos
    IMPORTING
      et_cordpos      = lt_cordpos
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

* Loop cordpos objects.
  LOOP AT lt_cordpos INTO lr_prereg.

*   Casting.
    lr_cordpos ?= lr_prereg.

*   Get the cordtyp.
    lr_cordtyp = lr_cordpos->get_cordtyp_med( ).

*   Process only if there is already a cordtyp.
    CHECK NOT lr_cordtyp IS INITIAL.

*   Get the compid for ir_screen.
    CLEAR l_compid.
    LOOP AT lt_component INTO lr_component.
      CHECK NOT lr_component IS INITIAL.
      CHECK lr_component->is_screen_supported( me ) = on.
      l_compid = lr_component->get_compid( ).
      EXIT.
    ENDLOOP.
    CHECK NOT l_compid IS INITIAL.

*   Get the screenid.
*    CALL METHOD me->get_type
*      IMPORTING
*        e_object_type = l_screenid.
    l_screenid = me->get_screenid( ).
    CHECK NOT l_screenid IS INITIAL.

*   Get the actual stsma + estat.
    CALL METHOD lr_cordpos->get_status
      IMPORTING
        e_stsma         = l_stsma
        e_estat         = l_estat
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK NOT l_stsma IS INITIAL.
    CHECK NOT l_estat IS INITIAL.

*   Get the defined scrm definitions.
    CALL METHOD lr_cordtyp->get_t_scrm
      EXPORTING
        i_compid        = l_compid
        i_screenid      = l_screenid
        i_stsma         = l_stsma
        i_estat         = l_estat
        i_fattr_type_id = cl_ishmed_fattr_type=>co_display
      IMPORTING
        et_scrm         = lt_scrm.

*   Build table for screen modification.
    LOOP AT lt_scrm INTO lr_scrm.
*     Get SCRM data.
      CHECK NOT lr_scrm IS INITIAL.
      CALL METHOD lr_scrm->get_data
        RECEIVING
          rs_n1scrm = ls_n1scrm.
*     Get FATTR data.
      CALL METHOD lr_scrm->get_fattr
        RECEIVING
          rr_fattr = lr_fattr.
      CHECK NOT lr_fattr IS INITIAL.
      CALL METHOD lr_fattr->get_data
        RECEIVING
          rs_n1fattr = ls_n1fattr.
*     Check for an existing entry.
      CLEAR: ls_scrm_fattr, l_append.
      READ TABLE lt_scrm_fattr
      WITH KEY n1scrm-compid    = ls_n1scrm-compid
*              screenid?
               n1scrm-fieldname = ls_n1scrm-fieldname
      INTO ls_scrm_fattr.
      IF sy-subrc = 0.
*       Compare priority (0001-high ... 9999-low).
        IF ls_scrm_fattr-n1fattr-prio > ls_n1fattr-prio.
*         Delete existing entry with lower priority.
          DELETE lt_scrm_fattr INDEX sy-tabix.
          l_append = on.
        ENDIF.
      ELSE.
        l_append = on.
      ENDIF.
      IF l_append = on.
*       Append new entry.
        CLEAR ls_scrm_fattr.
        ls_scrm_fattr-n1scrm  = ls_n1scrm.
        ls_scrm_fattr-n1fattr = ls_n1fattr.
        APPEND ls_scrm_fattr TO lt_scrm_fattr.
      ENDIF.
    ENDLOOP.  "lt_scrm

  ENDLOOP.  "lt_cordpos

* now get subscreen for absences
  CHECK NOT gr_waiting_list_subscreen IS INITIAL.
  CALL METHOD gr_waiting_list_subscreen->get_data
    IMPORTING
      e_control = lr_absences.
  CHECK NOT lr_absences IS INITIAL.
  CALL METHOD lr_absences->get_fieldcatalog
    IMPORTING
      et_fieldcat = lt_fieldcat.
  CHECK NOT lt_fieldcat[] IS INITIAL.

*-- begin Grill, ID-20733
*-- get screen data
  CALL METHOD me->if_ish_screen~get_data
    IMPORTING
      e_screen_values = lr_screen_values.
  CHECK lr_screen_values IS BOUND.
  CALL METHOD lr_screen_values->get_data
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
*    IF NOT lt_field_values IS INITIAL.
*      APPEND LINES OF lt_field_values TO lt_fieldcat.
*    ENDIF.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'RN1_DYNP_WAITING_LIST'
    CHANGING
      ct_fieldcat      = lt_fieldcat_waiting.
  LOOP AT lt_fieldcat_waiting INTO ls_fieldcat.
    CONCATENATE 'RN1_DYNP_WAITING_LIST' ls_fieldcat-fieldname INTO ls_fieldcat-fieldname
     SEPARATED BY  '-'.
    APPEND ls_fieldcat TO lt_fieldcat.
  ENDLOOP.
*-- end Grill, ID-20733

  l_set_fieldcatalog = off.
  LOOP AT lt_fieldcat INTO ls_fieldcat.
    l_modify = off.
*   Check for modification.
    LOOP AT lt_scrm_fattr INTO ls_scrm_fattr.
*     Compare fieldname.
      CHECK ls_fieldcat-fieldname = ls_scrm_fattr-n1scrm-fieldname.
      l_fattr_value_id = ls_scrm_fattr-n1fattr-fattr_value_id.
      CASE l_fattr_value_id.
        WHEN cl_ishmed_fattr_value=>co_display_can.
          ls_fieldcat-tech = off.
          IF g_vcode <> co_vcode_display.
            ls_fieldcat-edit = on.
          ELSE.
            ls_fieldcat-edit = off.
          ENDIF.
          l_modify = on.
        WHEN cl_ishmed_fattr_value=>co_display_inactive.
          ls_fieldcat-tech = 'X'.
          l_modify = on.
        WHEN cl_ishmed_fattr_value=>co_display_show.
            ls_fieldcat-tech = off. "MED-54884 Cristina Geanta
            ls_fieldcat-edit = off.
          l_modify = on.
*-- begin Grill, MED-34087
        WHEN cl_ishmed_fattr_value=>co_display_must.
            ls_fieldcat-tech = off. "MED-54884 Cristina Geanta
            IF g_vcode NE co_vcode_display.
            ls_fieldcat-edit = on.
          ELSE.
            ls_fieldcat-edit = off.
          ENDIF.
          l_modify = on.
*-- end Grill, MED-34087
      ENDCASE.
      EXIT.
    ENDLOOP.  "lt_scrm_fattr
*   Do modification.
    IF l_modify = on.
      l_set_fieldcatalog = on.
      MODIFY lt_fieldcat FROM ls_fieldcat
            TRANSPORTING tech edit.
    ENDIF.
  ENDLOOP.  "loop at lt_fieldcat...

"MED-54884 Cristina Geanta 09.04.2014
    CLEAR lv_count.
    LOOP AT lt_fieldcat INTO ls_fieldcat WHERE fieldname EQ 'ABSBDT'
                                            OR fieldname EQ 'ABSEDT'
                                            OR fieldname EQ 'ABSRSNTX'.
      IF ls_fieldcat-tech EQ 'X'.
        lv_count = lv_count + 1.
      ENDIF.
    ENDLOOP.

       lr_abs_container ?= gr_waiting_list_subscreen->g_abs_container.

    IF lv_count EQ 3.
* If ABSBDT (Beg. Abw.), ABSEDT (Endedatum), ABSRSNTX (Abwesenheitsgrund Text)
* were set to inactive in N1COT, then hide the container
      CALL METHOD lr_abs_container->set_visible
        EXPORTING
          visible           = ' '
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
    ELSE.
      CALL METHOD lr_abs_container->set_visible
        EXPORTING
          visible           = 'X'
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.

    ENDIF.
"MED-54884 Cristina Geanta 09.04.2014

* change fieldcat
    CALL METHOD lr_absences->set_fieldcatalog
    EXPORTING
      it_fieldcat = lt_fieldcat
      i_vcode     = g_vcode.
" <=====================================================/ ISHMED_CORDER

  endif.

ENDMETHOD.


METHOD modify_screen_std.

* definitions
  DATA: l_einri                    TYPE tn01-einri.
* ---------- ---------- ----------
  CHECK gs_parent-type = co_scr_parent_type_dynpro.
* ---------- ---------- ----------
* get institution of main object
  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
* ---------- ---------- ----------
* call standard is-h screen modification
* but only if there is an institution.
  IF NOT l_einri IS INITIAL.
    CALL FUNCTION 'ISH_MODIFY_SCREEN'
      EXPORTING
        dynnr = g_dynnr_waiting_list
        einri = l_einri
        fcode = 'AS '
        pname = g_pgm_waiting_list
        vcode = g_vcode.
  ENDIF.
* ---------- ---------- ----------
* Set required fields to optional
* depending on g_handle_mandatory_fields.
  IF get_handle_mandatory_fields( ) = off.
    LOOP AT SCREEN.
      CHECK screen-required = true.
      screen-required = false.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
