class CL_ISH_SCR_PROCEDURES definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

*"* public components of class CL_ISH_SCR_PROCEDURES
*"* do not include other source files here!!!
public section.

  data GR_PROCEDURES_SUBSCREEN type ref to CL_ISH_SUBSCR_PROCEDURE_CORD .
  data GR_CANCEL type ref to CL_ISH_CANCEL .
  class-data G_FIELDNAME_ICPM type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_ICPML type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_ICPMC type ISH_FIELDNAME read-only .
  constants CO_OTYPE_SCR_PROCEDURES type ISH_OBJECT_TYPE value 7043. "#EC NOTEXT

  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCR_PROCEDURES
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods MODIFY_SCREEN_ATT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  methods GET_DYNPRO_PROCEDURES
    exporting
      value(E_PGM_PROCEDURES) type SY-REPID
      value(E_DYNNR_PROCEDURES) type SY-DYNNR .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_A
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~GET_FIELDS_DEFINITION
    redefinition .
  methods IF_ISH_SCREEN~GET_FIELDS_VALUE
    redefinition .
  methods IF_ISH_SCREEN~IS_FIELD_INITIAL
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_FROM_DY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_PROCEDURES
*"* do not include other source files here!!!

  data G_PGM_PROCEDURES type SY-REPID .
  data G_DYNNR_PROCEDURES type SY-DYNNR .

  methods BUILD_MESSAGE
    redefinition .
  methods CHECK_MANDATORY_FIELDS
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
  methods SET_CURSOR_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_PROCEDURES
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_PROCEDURES IMPLEMENTATION.


METHOD build_message.

  DATA: l_rc            TYPE ish_method_rc,
        l_ok            TYPE ish_on_off,
        lr_corder       TYPE REF TO cl_ish_corder,
        lt_proc         TYPE ish_objectlist,
        ls_proc         LIKE LINE OF lt_proc.

* Call super method.
  CALL METHOD super->build_message
    EXPORTING
      is_message    = is_message
      i_cursorfield = i_cursorfield
    IMPORTING
      es_message    = es_message.

  IF NOT gr_main_object IS INITIAL.
    IF gr_main_object->is_inherited_from(
                cl_ish_corder=>co_otype_corder ) = on.
      lr_corder ?= gr_main_object.
      CALL METHOD cl_ish_corder=>get_procedures_for_corder
        EXPORTING
          ir_corder      = lr_corder
          ir_environment = gr_environment
        IMPORTING
          e_rc           = l_rc
          et_procedures  = lt_proc.
    ENDIF.
  ENDIF.

* Handle only errors on selfs main object.
  l_ok = on.
  IF NOT is_message-object IS INITIAL AND
     NOT is_message-object = gr_main_object.
    l_ok = off.
    LOOP AT lt_proc INTO ls_proc.
      CHECK ls_proc-object = is_message-object.
      l_ok = on.
      EXIT.
    ENDLOOP.
  ENDIF.

  IF l_ok = off.
    CLEAR: es_message-parameter,
           es_message-field.
    EXIT.
  ENDIF.

* Wrap es_message-parameter.
  CASE es_message-parameter.
    WHEN 'NPCP'.
      es_message-parameter = 'RNPREGP'.
  ENDCASE.

* set cursor
  IF NOT gr_procedures_subscreen IS INITIAL.
    CALL METHOD gr_procedures_subscreen->set_cursor
      CHANGING
        c_rn1message = is_message.
  ENDIF.

ENDMETHOD.


METHOD check_mandatory_fields.

* ED, int. M. 0120061532 0001261428 2005 -> BEGIN
  TYPES: BEGIN OF scrm_fattr,
           n1scrm  TYPE n1scrm,
           n1fattr TYPE n1fattr,
         END   OF scrm_fattr.

  DATA: lr_cordpos                 TYPE REF TO cl_ishmed_cordpos,
        lr_corder                  TYPE REF TO cl_ishmed_corder,
        lt_cordpos                 TYPE ish_t_cordpos,
        lr_cordtyp_help            TYPE REF TO cl_ish_cordtyp,
        lr_main_object             TYPE REF TO if_ish_identify_object,
        lt_compdef_all             TYPE ish_t_compdef,
        lt_compdef                 TYPE ish_t_compdef,
        lr_compdef                 TYPE REF TO cl_ish_compdef,
        lt_component               TYPE ish_t_component,
        lr_component               TYPE REF TO if_ish_component,
        l_object_type              TYPE i,
        lr_prereg                  TYPE REF TO cl_ishmed_prereg,
        lr_cordtyp                 TYPE REF TO cl_ishmed_cordtyp,
        lr_comp_services           TYPE REF TO cl_ishmed_comp_services,
        l_compid                   TYPE n1compid,
        l_screenid                 TYPE i,
        l_stsma                    TYPE j_stsma,
        l_estat                    TYPE j_estat,
        lt_scrm                    TYPE ishmed_t_scrm,
        lr_scrm                    TYPE REF TO cl_ishmed_scrm,
        lt_fv                      TYPE ish_t_field_value,
        lt_fv_sub                  TYPE ish_t_field_value,
        lr_fv                      TYPE REF TO cl_ish_field_values,
        l_fieldname                TYPE ish_fieldname,
        l_par                      TYPE bapiret2-parameter,
        l_fld                      TYPE bapiret2-field,
        l_mv1                      TYPE string,
        lt_scrm_field              TYPE ish_t_scrm_field,
        l_rownumber                TYPE int4,
        l_delete                   TYPE ish_on_off,
        l_rc                       TYPE ish_method_rc,
        lr_config                  TYPE REF TO cl_ishmed_con_corder,
        lt_cordpos_check_mandatory TYPE ish_t_cordpos,
        l_cordpos_found            TYPE ish_on_off,
        lr_procedure               TYPE REF TO cl_ish_prereg_procedure,
        l_tabix                    LIKE sy-tabix,
        l_compdef_found            TYPE ish_on_off,
        lt_screen_objects          TYPE ish_t_screen_objects,
        lt_screen_objects_help     TYPE ish_t_screen_objects,
        lt_screen_objects_all      TYPE ish_t_screen_objects,
        l_screen_found             TYPE ish_on_off,
        ls_n1scrm                  TYPE n1scrm,
        ls_n1fattr                 TYPE n1fattr,
        l_prio                     TYPE n1fattr-prio,
        l_append                   TYPE ish_on_off,
        ls_scrm_fattr              TYPE scrm_fattr,
        lr_fattr                   TYPE REF TO cl_ishmed_fattr,
        lt_scrm_fattr              TYPE TABLE OF scrm_fattr,
        ls_data                    TYPE rnpcp_attrib.

  FIELD-SYMBOLS: <ls_fv>            TYPE rnfield_value,
                 <ls_fv_sub>        TYPE rnfield_value,
                 <ls_scrm_field>    TYPE rn1_scrm_field,
                 <lr_prereg>        TYPE REF TO cl_ishmed_prereg,
                 <ls_fv_proc>       TYPE rnfield_value,
                 <lr_compdef>       TYPE REF TO cl_ish_compdef,
                 <ls_scrmod>        TYPE screen,
                 <lr_screen_object> TYPE REF TO if_ish_screen.

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* No processing in display mode.
  CHECK NOT g_vcode = co_vcode_display.

* Get screen's main object.
  lr_main_object = me->get_main_object( ).
  CHECK NOT lr_main_object IS INITIAL.

* Process only if main object is a corder.
  CHECK lr_main_object->is_inherited_from(
              cl_ishmed_corder=>co_otype_corder_med ) = on.

* Get the corder object.
  lr_corder ?= lr_main_object.

* get all corder positions
  CALL METHOD lr_corder->get_t_cordpos
    IMPORTING
      et_cordpos      = lt_cordpos
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get component definitions of all cordpos that must be checked.
  LOOP AT lt_cordpos INTO lr_prereg.
*   Get cordtyp from cordpos.
    CALL METHOD lr_prereg->get_cordtyp
      RECEIVING
        rr_cordtyp = lr_cordtyp_help.
    CHECK lr_cordtyp_help IS BOUND.
*   Get component definitions from cordtyp.
    CALL METHOD lr_cordtyp_help->get_t_compdef
      RECEIVING
        rt_compdef = lt_compdef.
    APPEND LINES OF lt_compdef TO lt_compdef_all.
  ENDLOOP.
* Delete duplicates?

* Get corder's header components.
  CALL METHOD lr_corder->get_t_comphead
    IMPORTING
      et_component = lt_component.
  CHECK NOT lt_component IS INITIAL.

* Get corder's header components of all cordpos that must be checked.
  LOOP AT lt_component INTO lr_component.
*   Käfer, MED-29541 - Begin
*   remember tabix before calling GET_TYPE or IS_INHERITED_FROM.
*   implementations of method get_type of userspecific components can change the tabix,
*   so a dump can occur.
*    CALL METHOD lr_component->get_type
*      IMPORTING
*        e_object_type = l_object_type.
*   Käfer, MED-29541 - End
    l_tabix = sy-tabix.
    l_delete = off.
    l_compdef_found = off.
*   Käfer, MED-29541 - Begin
*    IF l_object_type <>
*          cl_ish_comp_procedures=>co_otype_comp_procedures.
*      l_delete = on.
*    ENDIF.
    IF lr_component->is_inherited_from( i_object_type = cl_ish_comp_procedures=>co_otype_comp_procedures ) = off.
      l_delete = on.
    ENDIF.
*   Käfer, MED-29541 - End
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

* Get header component's screens.
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

* Does screen belong to one of the remaining
* header components?
  l_screen_found = off.
  LOOP AT lt_screen_objects_all ASSIGNING <lr_screen_object>.
    CHECK <lr_screen_object> = me.
    l_screen_found = on.
    EXIT.
  ENDLOOP.

* Do mandatory checks for imported screen?
  CHECK l_screen_found = on.

* Loop cordpos objects.
  LOOP AT lt_cordpos INTO lr_prereg.

*   Casting.
    lr_cordpos ?= lr_prereg.

*   Get the cordtyp.
    lr_cordtyp = lr_cordpos->get_cordtyp_med( ).

*   Process only if there is already a cordtyp.
    CHECK NOT lr_cordtyp IS INITIAL.

*   Is there a configuration?
    IF gr_config IS BOUND.
*   Castings.
      lr_config ?= gr_config.
      IF lr_config IS BOUND AND lr_prereg IS BOUND.
*       Get config's cordpos table.
        CALL METHOD lr_config->get_cordpos_check_mandatory
          RECEIVING
            rt_cordpos_check_mandatory = lt_cordpos_check_mandatory.
*       Search current cordpos in cordpos table.
        l_cordpos_found = off.
        LOOP AT lt_cordpos_check_mandatory ASSIGNING <lr_prereg>.
          CHECK <lr_prereg> = lr_prereg.
          l_cordpos_found = on.
          EXIT.
        ENDLOOP.
*       Cordpos not found => no mandatory checks.
        CHECK l_cordpos_found = on.
      ENDIF.
    ENDIF.

*   Get the compid for screen.
    CLEAR l_compid.
    READ TABLE lt_component INTO lr_component INDEX 1.
    CHECK NOT lr_component IS INITIAL.
    CHECK lr_component->is_screen_supported( me ) = on.
    l_compid = lr_component->get_compid( ).
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
*   Build table for mandatory check.
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

*   Handle sub field values.
    IF NOT <ls_fv>-object IS INITIAL.
      CLEAR: ls_data.
      CHECK <ls_fv>-object->is_inherited_from(
                  cl_ish_prereg_procedure=>co_otype_prereg_procedure ) = on.
      lr_procedure ?= <ls_fv>-object.
      CALL METHOD lr_procedure->get_data
        IMPORTING
          es_data        = ls_data
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      CHECK NOT ls_data-storn = on.
    ENDIF.

**   Process only if ICPM was specified.
*    READ TABLE lt_fv_sub
*      WITH KEY fieldname = 'ICPM'
*      ASSIGNING <ls_fv_sub>.
*    CHECK sy-subrc = 0.
*    CHECK NOT <ls_fv_sub>-value IS INITIAL.

*   Check the sub field values.
    LOOP AT lt_scrm INTO lr_scrm.

      CHECK NOT lr_scrm IS INITIAL.

*     Process only mandatory fields.
      CHECK lr_scrm->get_fattr_value_id( ) =
              cl_ishmed_fattr_value=>co_display_must.

*     Get the field's name.
      l_fieldname = lr_scrm->get_fieldname( ).

*     determine if the field is empty (initial).
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

*     Get field OBJECT for message object.
*      READ TABLE lt_fv_sub ASSIGNING <ls_fv_proc>
*                 WITH KEY fieldname = 'OBJECT'.
*      IF sy-subrc = 0.
      lr_procedure ?= <ls_fv>-object.
*      ENDIF.

*     Add an error message.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '062'
          i_par           = l_par
          i_field         = l_fld
          i_mv1           = l_mv1
          ir_object       = lr_procedure
        CHANGING
          cr_errorhandler = cr_errorhandler.

    ENDLOOP.  " lt_fv_sub

  ENDLOOP.  " lt_fv
* ED, int. M. 0120061532 0001261428 2005 -> END
ENDMETHOD.


METHOD CONSTRUCTOR .

  CALL METHOD super->constructor.

ENDMETHOD.


METHOD create .

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
        i_mv1           = 'CL_ISH_SCR_PROCEDURES'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

* ED, int. M. 0120061532 0001261428 2005 -> BEGIN
* for reading in comp --> check-method!!
  g_fieldname_icpm = 'RNPREGP-ICPM'.
  g_fieldname_icpmc = 'RNPREGP-ICPMC'.
  g_fieldname_icpml = 'RNPREGP-ICPML'.
* ED, int. M. 0120061532 0001261428 2005 -> END

ENDMETHOD.


METHOD fill_t_scrm_field .

  DATA: ls_scrm_field  TYPE rn1_scrm_field.

  REFRESH gt_scrm_field.

* icpm
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'RNPREGP-ICPM'.
  ls_scrm_field-fieldlabel = 'OP-Code'(001).
  APPEND ls_scrm_field TO gt_scrm_field.

* icpmt
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'RNPREGP-ICPMT'.
  ls_scrm_field-fieldlabel = 'Bezeichnung OP'(002).
  APPEND ls_scrm_field TO gt_scrm_field.

* icpml
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'RNPREGP-ICPML'.
  ls_scrm_field-fieldlabel = 'Lokalisation'(003).
  APPEND ls_scrm_field TO gt_scrm_field.

** icpmc
*  CLEAR ls_scrm_field.
*  ls_scrm_field-fieldname  = 'NPCP-ICPMC'.
*  ls_scrm_field-fieldlabel = 'Katalog'(004).
*  APPEND ls_scrm_field TO gt_scrm_field.

ENDMETHOD.


METHOD GET_DYNPRO_PROCEDURES .

  e_pgm_procedures = g_pgm_procedures.
  e_dynnr_procedures = g_dynnr_procedures.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~GET_TYPE .

  e_object_type = co_otype_scr_procedures.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~IS_A .

  DATA: l_object_type                 TYPE i.

* ---------- ---------- ----------
  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF l_object_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  IF i_object_type = co_otype_scr_procedures.
    r_is_inherited_from = on.
  ELSE.
*-- ID-16230
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
*--  r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~destroy.

* ED, ID 14654: new destroy
  e_rc = 0.

* call destroy of subscreen
  IF gr_procedures_subscreen IS BOUND.       "MED-62089 AGujev
    CALL METHOD gr_procedures_subscreen->destroy.
  ENDIF.                                     "MED-62089 AGujev

* ---------------------------------------------------------
* Call destroy of super-class
  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_screen~get_fields_definition.

  DATA: ls_parent  TYPE rnscr_parent.

* Use the old subscreen's dynpro.
  ls_parent = gs_parent.
  gs_parent-repid = g_pgm_procedures.
  gs_parent-dynnr = g_dynnr_procedures.

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


METHOD if_ish_screen~get_fields_value.

* ED, int. M. 0120061532 0001261428 2005 -> BEGIN
  DATA:          lt_fielddef          TYPE dyfatc_tab,
                 lt_field_values      TYPE ish_t_field_value,
                 lt_fields_value      TYPE ish_t_screen_fields,
                 ls_fields_value      LIKE LINE OF lt_fields_value,
                 l_rc                 TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fielddef>        TYPE rpy_dyfatc,
                 <ls_field_values>    TYPE rnfield_value,
                 <ls_fields_value>    TYPE rn1_screen_fields.

* Init
  e_rc = 0.

* Check/create errorhandler
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Get field values
  CALL METHOD me->get_fields
*  EXPORTING
*    I_CONV_TO_EXTERN = SPACE
    IMPORTING
      et_field_values  = lt_field_values
      e_rc             = e_rc
   CHANGING
    c_errorhandler     = cr_errorhandler.
*
* Loop field values
  LOOP AT lt_field_values ASSIGNING <ls_field_values>.
    CLEAR ls_fields_value.
    CASE <ls_field_values>-fieldname.
      WHEN 'NPCP-ICPM' or 'RNPREGP-ICPM'.
        ls_fields_value-value_name = 'NPCP-ICPM'.
        ls_fields_value-value_text = <ls_field_values>-value.
      WHEN 'NPCP-ICPML' or 'RNPREGP-ICPML'.
        ls_fields_value-value_name = 'NPCP-ICPML'.
        ls_fields_value-value_text = <ls_field_values>-value.
      WHEN 'NPCP-ICPMT' or 'RNPREGP-ICPMT'.
        ls_fields_value-value_name = 'NPCP-ICPMT'.
        ls_fields_value-value_text = <ls_field_values>-value.
      WHEN 'NPCP-ICPMC' or 'RNPREGP-ICPMC'.
        ls_fields_value-value_name = 'NPCP-ICPMC'.
        ls_fields_value-value_text = <ls_field_values>-value.
      WHEN OTHERS.

    ENDCASE.
    IF NOT ls_fields_value-value_name IS INITIAL.
      APPEND ls_fields_value TO et_fields_value.
    ENDIF.
  ENDLOOP.
* ED, int. M. 0120061532 0001261428 2005 -> END

ENDMETHOD.


METHOD if_ish_screen~is_field_initial.

* ED, int. M. 0120061532 0001261428 2005 -> BEGIN
  DATA: lt_fields_value TYPE ish_t_screen_fields,
        ls_fields_value LIKE LINE OF lt_fields_value,
        l_rc            TYPE ish_method_rc.

* first check normal fields
  CALL METHOD super->if_ish_screen~is_field_initial
    EXPORTING
      i_fieldname = i_fieldname
      i_rownumber = i_rownumber
    RECEIVING
      r_initial   = r_initial.

  CHECK r_initial = on.
* now check subscreen fields
  CALL METHOD me->get_fields_value
*    EXPORTING
*      I_CONV_TO_EXTERN = SPACE
    IMPORTING
      et_fields_value  = lt_fields_value
      e_rc             = l_rc.
  CHECK l_rc = 0.
  READ TABLE lt_fields_value INTO ls_fields_value
        WITH KEY value_name = i_fieldname.
  CHECK sy-subrc EQ 0.
* Check if value is initial.
  CHECK NOT ls_fields_value-value_text IS INITIAL.
* if value is not initial -> set return parameter!!
  r_initial = off.

ENDMETHOD.


METHOD IF_ISH_SCREEN~OK_CODE_SCREEN .

  CALL METHOD gr_procedures_subscreen->ok_code_subscreen
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler
      c_okcode       = c_okcode.


ENDMETHOD.


METHOD IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY .

  DATA: l_rc TYPE ish_method_rc,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.

  CALL FUNCTION 'ISH_SDY_PROCEDURES_INIT'
    EXPORTING
      ir_scr_procedures = me
    IMPORTING
      es_parent        = gs_parent
      e_rc             = l_rc
    CHANGING
      cr_dynp_data     = gr_scr_data
      cr_errorhandler  = lr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~transport_from_dy .

* ED, int. M. 0120061532 0001261428 2005: COMMENT
*  DATA: l_rc            TYPE ish_method_rc,
*        lr_corder       TYPE REF TO cl_ish_corder,
*        lt_field_val    TYPE ish_t_field_value,
*        ls_field_val    TYPE rnfield_value,
*        lt_procedures  TYPE ish_objectlist,
*        l_wa_object     TYPE ish_object.
*
** Transport super class(es).
*  CALL METHOD super->if_ish_screen~transport_from_dy
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Get subscreen data
*  CLEAR: lr_corder.
*  CALL METHOD gr_procedures_subscreen->get_data
*    IMPORTING
*      e_corder      = lr_corder
*      e_vcode       = g_vcode
**    E_FIRST_TIME  =
*      e_environment = gr_environment
**    E_RN1MESSAGE  =
*      .
*  CHECK e_rc = 0.
*
*  CALL METHOD cl_ish_corder=>get_procedures_for_corder
*    EXPORTING
**    I_CANCELLED_DATAS =
*      ir_corder         = lr_corder
*      ir_environment    = gr_environment
*    IMPORTING
*      e_rc              = e_rc
*      et_procedures     = lt_procedures
*    CHANGING
*      cr_errorhandler   = cr_errorhandler.
*  CHECK e_rc = 0.
*
*  LOOP AT lt_procedures INTO l_wa_object.
**    IF gr_policy1 IS INITIAL.
**      gr_policy1 ?= l_wa_object-object.
**    ELSEIF gr_policy2 IS INITIAL.
**      gr_policy2 ?= l_wa_object-object.
**    ELSE.
**      gr_policy3 ?= l_wa_object-object.
**    ENDIF.
*  ENDLOOP.
*
** Set screen values
*  CLEAR: ls_field_val.
**  ls_field_val-fieldname = 'POLICY1'.
**  ls_field_val-type      = co_fvtype_identify.
**  ls_field_val-object    = gr_policy1.
**  INSERT ls_field_val INTO TABLE lt_field_val.
**  CLEAR: ls_field_val.
**  ls_field_val-fieldname = 'POLICY2'.
**  ls_field_val-type      = co_fvtype_identify.
**  ls_field_val-object    = gr_policy2.
**  INSERT ls_field_val INTO TABLE lt_field_val.
**  CLEAR: ls_field_val.
**  ls_field_val-fieldname = 'POLICY3'.
**  ls_field_val-type      = co_fvtype_identify.
**  ls_field_val-object    = gr_policy3.
**  INSERT ls_field_val INTO TABLE lt_field_val.
** ----------
** set values
*  CALL METHOD gr_screen_values->set_data
*    EXPORTING
*      it_field_values = lt_field_val
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      c_errorhandler  = cr_errorhandler.
** ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy .

  DATA: l_einri TYPE tn01-einri,
        lr_corder TYPE REF TO cl_ish_corder.

* ---------- ----------
* initialize
  e_rc = 0.

  CHECK NOT gr_procedures_subscreen IS INITIAL.
  CHECK NOT gr_screen_values        IS INITIAL.

* Call standard implementation.
  CALL METHOD super->if_ish_screen~transport_to_dy.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

* ---------- ----------
  lr_corder ?= gr_main_object.
* give the subscreen the actual clinical order
  CALL METHOD gr_procedures_subscreen->set_data
    EXPORTING
      i_corder           = lr_corder
*    I_CUSTOM_CONT_PROC =
*    I_GRID_PROC        =
*    I_OUTTAB           =
      i_vcode_x          = on
      i_vcode            = g_vcode.

* give the fub in de subscreen the reference of the screenclass
  CALL FUNCTION 'ISH_SET_SUBSCR_PROCEDURES_CORD'
    EXPORTING
      i_procedures_sub = gr_procedures_subscreen.

ENDMETHOD.


METHOD INITIALIZE_FIELD_VALUES .
* local tables
  DATA: lt_field_val            TYPE ish_t_field_value.
* workareas
  DATA: ls_field_val            TYPE rnfield_value.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
  CLEAR: lt_field_val.
* ----------
** initialize every screen field
*  CLEAR: ls_field_val.
*  ls_field_val-fieldname = 'RN1_DYNP_INSURANCE-MGART'.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = 'RN1_DYNP_INSURANCE-MGART2'.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = 'RN1_DYNP_INSURANCE-IPID'.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = 'RN1_DYNP_INSURANCE-IPID2'.
*  ls_field_val-type      = co_fvtype_single.
*  INSERT ls_field_val INTO TABLE lt_field_val.
* ----------
* set values
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      it_field_values = lt_field_val
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
* ---------- ---------- ----------
ENDMETHOD.


METHOD initialize_internal .

  DATA: l_einri       TYPE tn01-einri.

* set subscreen
  g_pgm_procedures = 'SAPLNCORD'.
  g_dynnr_procedures = '0200'.

  IF gr_procedures_subscreen IS INITIAL.
* ---------- ----------
*   Get einri.
    l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
    CHECK NOT l_einri IS INITIAL.
*   initialize the screenclass
    CREATE OBJECT gr_procedures_subscreen
      EXPORTING
        i_caller      = 'CL_ISH_SCR_PROCEDURES'
        i_einri       = l_einri
        i_vcode       = g_vcode
        i_environment = gr_environment
        ir_screen     = me.                "RW ID 14654
    e_rc = sy-subrc.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD INITIALIZE_PARENT .

  DATA: l_bewty TYPE nbew-bewty.

  CLEAR: gs_parent, e_rc.

  gs_parent-repid = 'SAPLN1_SDY_PROCEDURES'.
  gs_parent-dynnr = '0100'.
  gs_parent-type = co_scr_parent_type_dynpro.

ENDMETHOD.


METHOD is_message_handled.

* ED, int. M. 0120061532 0001261428 2005 -> BEGIN
  DATA: l_rc            TYPE ish_method_rc,
        l_cursorfield   TYPE ish_fieldname.

* first call super method
  CALL METHOD super->is_message_handled
    EXPORTING
      is_message   = is_message
    RECEIVING
      r_is_handled = r_is_handled.

* only go on if r_is_handled is OFF and is_message is filled!!
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
  IF l_cursorfield = g_fieldname_icpm OR
     l_cursorfield = g_fieldname_icpmc OR
     l_cursorfield = g_fieldname_icpml.
    r_is_handled = on.
  ENDIF.
* ED, int. M. 0120061532 0001261428 2005 -> END

ENDMETHOD.


METHOD MODIFY_SCREEN_ATT .

** definition
*  DATA: l_rc                TYPE ish_method_rc,
*        l_einri             TYPE tn01-einri,
*        l_flag              TYPE ish_on_off,
*        l_repid             TYPE tndym-pname,
*        l_dynnr             TYPE tndym-dynnr,
*        lt_field_values TYPE ish_t_field_value,
*        l_wa_field_value_falar TYPE rnfield_value,
*        l_wa_field_value_bekat TYPE rnfield_value,
*        l_wa_field_value_pvpat TYPE rnfield_value,
*        l_bekat TYPE bekat,
*        l_pvpat TYPE n1pvpat,
*        l_falar TYPE fallart,
*        l_screen TYPE rn1screen,
*        lt_screen TYPE ishmed_t_screen.
** object references
*  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.
*
*  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
*  IF l_einri IS INITIAL.
*    EXIT.
*  ENDIF.
*
** TNDYN-Modifikationen einlesen
*  CALL METHOD me->get_dynpro
*    IMPORTING
*      e_pgm   = l_repid
*      e_dynnr = l_dynnr.
*
*  IF NOT l_dynnr IS INITIAL  AND  NOT l_repid IS INITIAL.
*    CALL FUNCTION 'ISH_MODIFY_SCREEN'
*      EXPORTING
*        dynnr = l_dynnr
*        einri = l_einri
*        fcode = 'AS '
*        pname = l_repid
*        vcode = g_vcode.
*  ENDIF.
*
*  CALL METHOD me->get_fields
**  EXPORTING
**    I_CONV_TO_EXTERN = SPACE
*    IMPORTING
*      et_field_values  = lt_field_values
*      e_rc             = e_rc
*    CHANGING
*      c_errorhandler   = cr_errorhandler.
*  CHECK l_rc = 0.
*  READ TABLE lt_field_values INTO l_wa_field_value_falar
*     WITH KEY fieldname = g_fieldname_falar.
*  READ TABLE lt_field_values INTO l_wa_field_value_bekat
*     WITH KEY fieldname = g_fieldname_bekat.
*  READ TABLE lt_field_values INTO l_wa_field_value_pvpat
*       WITH KEY fieldname = g_fieldname_pvpat.
*  l_pvpat = l_wa_field_value_pvpat-value.
*  l_falar = l_wa_field_value_falar-value.
*  l_bekat = l_wa_field_value_bekat-value.
*
*  LOOP AT SCREEN.
*    MOVE-CORRESPONDING screen TO l_screen.
*    APPEND l_screen TO lt_screen.
*  ENDLOOP.
*
** Screenmodifikationen
*  LOOP AT lt_screen INTO l_screen.
*
*    IF g_vcode = co_vcode_display.
*      l_screen-input = 0.
*    ENDIF.
*
**   Behandlungskategorie ist nur sichtbar, wenn:
**   -) Fallart ist nicht leer
*    IF l_screen-name = g_fieldname_bekat.
*      IF NOT l_falar IS INITIAL.
*        CALL METHOD me->adjust_field_with_screentab
*          EXPORTING
*            i_name       = l_screen-name
*            it_screentab = lt_screen
*          CHANGING
*            c_screen     = l_screen.
*      ELSE.
*        l_screen-active = false.
*      ENDIF.
*    ENDIF.
*
**   Besuchsart ist nur sichtbar wenn die Fallart nicht leer ist
*    IF l_screen-name = g_fieldname_bewar.
*      IF l_falar IS INITIAL.
*        l_screen-active = false.
*      ELSE.
*        CALL METHOD me->adjust_field_with_screentab
*          EXPORTING
*            i_name       = l_screen-name
*            it_screentab = lt_screen
*          CHANGING
*            c_screen     = l_screen.
*      ENDIF.
*    ENDIF.
*
**   Privatpatient
**   Inaktivieren wenn Fallbezug schon vorhanden
**   Inaktivieren, wenn es nicht angekreuzt ist, und wenn
**   die Behandlungskat. befüllt
*    IF l_screen-name = g_fieldname_pvpat.
*      IF l_falar IS INITIAL  AND
*         l_pvpat = off.
**       Feld ausblenden, wenn Fallart leer und wenn das Feld nicht
**       angekreuzt ist (das ist wegen den mit der "alten" Vkg
**       angelegten Daten...)
*        l_screen-active = false.
*      ELSE.
*        CALL METHOD me->adjust_field_with_screentab
*          EXPORTING
*            i_name       = l_screen-name
*            it_screentab = lt_screen
*          CHANGING
*            c_screen     = l_screen.
** HABE DERWEIL NOCH KEINE FALNR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
**        IF l_pvpat = off           OR
**           NOT l_falnr IS INITIAL  OR
**           NOT l_bekat IS INITIAL.
**          screen-input = false.
**        ELSE.
**CALL METHOD me->adjust_field_with_screentab
**  EXPORTING
**    i_name       = l_screen-name
**    it_screentab = ct_screen
**  changing
**    c_screen     = l_screen.
**        ENDIF.
*      ENDIF.
*    ENDIF.
*  ENDLOOP.
*
** Feldattribute nun übernehmen
*  LOOP AT SCREEN.
*    READ TABLE lt_screen INTO l_screen
*               WITH KEY name = screen-name.
*    CHECK sy-subrc = 0.
*    screen-active = l_screen-active.
*    screen-input  = l_screen-input.
*    screen-required = l_screen-required.
*    MODIFY SCREEN.
*  ENDLOOP.

ENDMETHOD.


METHOD modify_screen_internal .

* ED, ID 14654: check modifications
  TYPES: BEGIN OF scrm_fattr,
           n1scrm  TYPE n1scrm,
           n1fattr TYPE n1fattr,
         END   OF scrm_fattr.

  DATA: lr_main_object       TYPE REF TO if_ish_identify_object,
        lr_corder            TYPE REF TO cl_ishmed_corder,
        lt_cordpos           TYPE ish_t_cordpos,
        lr_cordpos           TYPE REF TO cl_ishmed_cordpos,
        lr_prereg            TYPE REF TO cl_ishmed_prereg,
        lr_cordtyp           TYPE REF TO cl_ishmed_cordtyp,
        lt_component         TYPE ish_t_component,
        lr_component         TYPE REF TO if_ish_component,
        l_compid             TYPE n1compid,
        l_screenid           TYPE int4,
        l_stsma              TYPE j_stsma,
        l_estat              TYPE j_estat,
        lt_scrm              TYPE ishmed_t_scrm,
        lr_scrm              TYPE REF TO cl_ishmed_scrm,
        ls_n1scrm            TYPE n1scrm,
        lr_fattr             TYPE REF TO cl_ishmed_fattr,
        ls_n1fattr           TYPE n1fattr,
        l_fattr_value_id     TYPE numc4,
        l_modify             TYPE ish_on_off,
        ls_screen            TYPE rn1screen,
        l_rc                 TYPE ish_method_rc,
        l_append             TYPE ish_on_off,
        l_fieldname          TYPE ish_fieldname,
        lr_screen            TYPE REF TO if_ish_screen,
        lr_scr_listbox       TYPE REF TO cl_ish_scr_listbox,
        l_active             TYPE ish_on_off,
        l_input              TYPE ish_on_off,
        ls_scrm_fattr        TYPE scrm_fattr,
        lt_scrm_fattr        TYPE TABLE OF scrm_fattr,
        ls_fieldcat          TYPE lvc_s_fcat,
        lt_fieldcat          TYPE lvc_t_fcat,
        lr_absences          TYPE REF TO cl_ish_absence_editor_cord,
        l_set_fieldcatalog   TYPE ish_on_off,
        l_fieldname_proc     TYPE lvc_fname,
        l_structure          TYPE lvc_fname.

** process only if no display!!!
*  CHECK g_vcode <> co_vcode_display.

* Process only if main object is a corder.
  CHECK gr_main_object->is_inherited_from(
              cl_ishmed_corder=>co_otype_corder_med ) = on.

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
  CHECK NOT gr_procedures_subscreen IS INITIAL.

  CALL METHOD gr_procedures_subscreen->get_data
    IMPORTING
      et_fieldcat = lt_fieldcat.

  l_set_fieldcatalog = off.
  LOOP AT lt_fieldcat INTO ls_fieldcat.
    l_modify = off.
*   Check for modification.
    LOOP AT lt_scrm_fattr INTO ls_scrm_fattr.
*     Compare fieldname.
      CLEAR l_fieldname.
      SPLIT ls_scrm_fattr-n1scrm-fieldname AT '-' INTO
          l_structure l_fieldname_proc.
      CHECK sy-subrc EQ 0.
      CHECK ls_fieldcat-fieldname = l_fieldname_proc.
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
          ls_fieldcat-edit = off.
          l_modify = on.
*-- begin Grill, MED-34087
        WHEN cl_ishmed_fattr_value=>co_display_must.
            ls_fieldcat-tech = off.
          IF g_vcode <> co_vcode_display.
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

* change fieldcat
  CALL METHOD gr_procedures_subscreen->set_data
    EXPORTING
      it_fieldcat = lt_fieldcat.

ENDMETHOD.


METHOD set_cursor_internal.

*  DATA: ls_row_no    TYPE lvc_s_roid,
*        lr_identify  TYPE REF TO if_ish_identify_object,
*        lr_alv_grid  TYPE REF TO cl_gui_alv_grid,
*        lr_container TYPE REF TO cl_gui_custom_container.
*
** get grid and container from subscreen
*  CALL METHOD gr_procedures_subscreen->get_data
*    IMPORTING
**    E_CORDER            =
**    E_VCODE             =
**    E_FIRST_TIME        =
**    E_ENVIRONMENT       =
**    E_RN1MESSAGE        =
**    ER_SCREEN           =
*      er_grid_proc        = lr_alv_grid
*      er_custom_cont_proc = lr_container.
*
*  CHECK NOT lr_alv_grid  IS INITIAL.
*  CHECK NOT lr_container IS INITIAL.
*
** Set focus.
*  CALL METHOD cl_gui_alv_grid=>set_focus
*    EXPORTING
*      control           = lr_container
*    EXCEPTIONS
*      cntl_error        = 1
*      cntl_system_error = 2
*      OTHERS            = 3.
*  CHECK sy-subrc = 0.
*
** Position in grid.
** Further processing only if the error-object is a procedure.
** Comment:
** Method IS_MESSAGE_HANDLED cannot be used, because gs_message-field
** was replaced by row number and would not be found as field value.
*  CHECK NOT gs_message-object IS INITIAL.
*  lr_identify ?= gs_message-object.
*  CHECK lr_identify->is_inherited_from(
*              co_otype_prereg_procedure ) = on.
*
*  IF NOT gs_message-object IS INITIAL.
*
** get object from outtab table grid
*
*
**   Determine the row_id.
**   Set right row_id.
**   Check field for num values (=> Dump).
**    IF gs_message-field CO '1234567890 '.
**     Set row number.
**      ls_row_no-row_id = gs_message-field.
**    ELSE.
**     Set default.
*    ls_row_no-row_id = 1.
**    ENDIF.
**   Set cursor to row_id.
*    CALL METHOD lr_alv_grid->set_current_cell_via_id
*      EXPORTING
*        is_row_no = ls_row_no.
*  ENDIF.

ENDMETHOD.
ENDCLASS.
