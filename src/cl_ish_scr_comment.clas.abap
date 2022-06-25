class CL_ISH_SCR_COMMENT definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

public section.
*"* public components of class CL_ISH_SCR_COMMENT
*"* do not include other source files here!!!

  data GR_COMMENT_SUBSCREEN type ref to CL_ISH_SUBSCR_FURTHER_DET_CO .
  data GR_CANCEL type ref to CL_ISH_CANCEL .
  constants CO_OTYPE_SCR_COMMENT type ISH_OBJECT_TYPE value 7045. "#EC NOTEXT

  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCR_COMMENT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods MODIFY_SCREEN_ATT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  methods GET_DYNPRO_COMMENT
    exporting
      value(E_PGM_COMMENT) type SY-REPID
      value(E_DYNNR_COMMENT) type SY-DYNNR .
  methods FREE_CONTROLS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_A
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~GET_DEFAULT_CURSORFIELD
    redefinition .
  methods IF_ISH_SCREEN~IS_FIELD_INITIAL
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
  methods IF_ISH_SCREEN~PROCESS_BEFORE_OUTPUT
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_COMMENT
*"* do not include other source files here!!!

  data G_PGM_COMMENT type SY-REPID .
  data G_DYNNR_COMMENT type SY-DYNNR .

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
*"* private components of class CL_ISH_SCR_COMMENT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_COMMENT IMPLEMENTATION.


METHOD CONSTRUCTOR .

  CALL METHOD super->constructor.

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
        i_mv1           = 'CL_ISH_SCR_COMMENT'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD fill_t_scrm_field .

  DATA: ls_scrm_field  TYPE rn1_scrm_field.

  REFRESH gt_scrm_field.

* bmco
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = 'FRAME_COMMENT'.
  ls_scrm_field-fieldlabel = 'Bemerkung'(001).
  APPEND ls_scrm_field TO gt_scrm_field.

ENDMETHOD.


METHOD free_controls .

  e_rc = 0.

* destroy the controls of the subscreen
  IF NOT gr_comment_subscreen IS INITIAL.
    IF NOT gr_comment_subscreen->g_bmco_edit IS INITIAL.
      CALL METHOD gr_comment_subscreen->g_bmco_edit->free
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.

        CLEAR gr_comment_subscreen->g_bmco_edit."MED-48850,Am
    ENDIF.
  ENDIF.
* DO NOT return an error here!
*  e_rc = sy-subrc.
*  CHECK e_rc = 0.
  IF NOT gr_comment_subscreen IS INITIAL.
    IF NOT gr_comment_subscreen->g_bmco_cont IS INITIAL.
      CALL METHOD gr_comment_subscreen->g_bmco_cont->free
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.

        CLEAR gr_comment_subscreen->g_bmco_cont. "MED-48850,Am
    ENDIF.
  ENDIF.
* DO NOT return an error here!
*  e_rc = sy-subrc.
*  CHECK e_rc = 0.

ENDMETHOD.


METHOD get_dynpro_comment .

  e_pgm_comment = g_pgm_comment.
  e_dynnr_comment = g_dynnr_comment.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~GET_TYPE .

  e_object_type = co_otype_scr_comment.

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

  IF i_object_type = co_otype_scr_comment.
    r_is_inherited_from = on.
  ELSE.
*-- ID-16230
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
*--  r_is_inherited_from = off. ID-16230
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~destroy .

  e_rc = 0.

  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CALL METHOD me->free_controls
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_screen~get_default_cursorfield.

  er_screen = me.
  e_cursorfield = 'N1CORDER-RMCORD'.

ENDMETHOD.


METHOD if_ish_screen~is_field_initial.

* RW ID 14654 - Redefinition.

  DATA: l_text      TYPE string,
        l_text_hex  TYPE xstring,                           "MED-30416
        l_pattern   TYPE xstring,                           "MED-30416
        lr_corder   TYPE REF TO cl_ish_corder,              "MED-30416
        ls_n1corder TYPE n1corder,                          "MED-30416
        l_rc        TYPE ish_method_rc.                     "MED-30416

* No valid field name => exit.
* Comment:
* Returning parameter R_INITIAL is still "OFF" (text not initial),
* that is the default value of it's data type.
  CHECK i_fieldname = 'FRAME_COMMENT'.

* Initialization => text is initial.
  r_initial = on.

* MED-30416 - Begin
  IF gr_comment_subscreen IS BOUND.
* Is there a comment screen?
*  CHECK gr_comment_subscreen IS BOUND.
* MED-30416 - End
* Is there a text edit control?
    CHECK gr_comment_subscreen->g_bmco_edit IS BOUND.

* MED-30416 - Begin
* Yes, there is => get the text.
*  CALL METHOD gr_comment_subscreen->g_bmco_edit->get_text_as_string
*    IMPORTING
*      text                   = l_text
*    EXCEPTIONS
*      error_cntl_call_method = 1
*      not_supported_by_gui   = 2
*      OTHERS                 = 3.
*  CHECK sy-subrc = 0.

* If text is initial => exit.
*  CHECK NOT l_text IS INITIAL.

*   is there a text?
    CALL METHOD gr_comment_subscreen->g_bmco_edit->get_text_as_xstring
      IMPORTING
        text                   = l_text_hex
      EXCEPTIONS
        error_cntl_call_method = 1
        not_supported_by_gui   = 2
        OTHERS                 = 3.
    CHECK sy-subrc = 0.

*   ignore enter and space
    l_pattern = '200D0A'.
    CHECK l_text_hex BYTE-CN l_pattern.

  ELSE.
*   this coding is only necessary for the first call of this method.
    TRY.
        lr_corder ?= gr_main_object.
      CATCH cx_sy_move_cast_error.
        EXIT.
    ENDTRY.
    CHECK lr_corder IS BOUND.
    CALL METHOD lr_corder->get_data
      IMPORTING
        es_n1corder = ls_n1corder
        e_rc        = l_rc.
    CHECK l_rc = 0.
    CHECK NOT ls_n1corder-rmcord IS INITIAL.
  ENDIF.
* MED-30416 - End

* Text is not initial.
  r_initial = off.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen .

  CHECK NOT gr_comment_subscreen IS INITIAL.

  CALL METHOD gr_comment_subscreen->ok_code_subscreen
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler
      c_okcode       = c_okcode.


ENDMETHOD.


METHOD if_ish_screen~process_before_output.

* redefined for MED-33697

  DATA: l_einri          TYPE einri,
        l_textedit       TYPE REF TO cl_ishmed_lte_editor,
        l_lte_enable     TYPE i,
        l_ishmed_used    TYPE ish_true_false,
        ls_tn00          TYPE tn00.

* check IS-H*MED active, to enable or disable LTE-editor
  l_ishmed_used = true.

  CALL FUNCTION 'ISHMED_AUTHORITY'
    EXPORTING
      i_msg            = space
    EXCEPTIONS
      ishmed_not_activ = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
    l_ishmed_used = false.
  ENDIF.

  l_lte_enable = l_ishmed_used.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

  IF gr_comment_subscreen IS NOT BOUND.
* ---------- ----------
*   initialize the screenclass
    CREATE OBJECT gr_comment_subscreen
      EXPORTING
        i_caller      = 'CL_ISH_SCR_COMMENT'
        i_einri       = l_einri
        i_environment = gr_environment
        ir_screen     = me.
    e_rc = sy-subrc.
    CHECK e_rc = 0.
    CHECK gr_comment_subscreen IS BOUND.

*   now instanciate the container and the textedit-control
    CREATE OBJECT gr_comment_subscreen->g_bmco_cont
      EXPORTING
        container_name              = 'BMCO_CONTAINER'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    e_rc = sy-subrc.
    IF e_rc <> 0.
*     Control & konnte nicht angelegt werden (Returncode &)
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'NFCL'
          i_num           = '090'
          i_mv1           = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.

    CREATE OBJECT gr_comment_subscreen->g_bmco_edit
      EXPORTING
        wordwrap_mode          = '2'
        wordwrap_position      = '132'
        parent                 = gr_comment_subscreen->g_bmco_cont
        lte_enable             = l_lte_enable
      EXCEPTIONS
        error_cntl_create      = 1
        error_cntl_init        = 2
        error_cntl_link        = 3
        error_dp_create        = 4
        gui_type_not_supported = 5
        OTHERS                 = 6.
    e_rc = sy-subrc.
    IF sy-subrc <> 0.
*     Control & konnte nicht angelegt werden (Returncode &)
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'NFCL'
          i_num           = '090'
          i_mv1           = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
    CHECK e_rc = 0.
    CHECK gr_comment_subscreen->g_bmco_edit IS BOUND.
*   Statusbar und Toolbar des Textedit ausblenden
    CALL METHOD gr_comment_subscreen->g_bmco_edit->set_toolbar_mode
      EXPORTING
        toolbar_mode           = 0
      EXCEPTIONS
        error_cntl_call_method = 1
        invalid_parameter      = 2
        OTHERS                 = 3.
  ENDIF.

* now call super-method to do pbo
  CALL METHOD super->if_ish_screen~process_before_output
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~set_cursor.

  DATA: l_rn1message TYPE rn1message,
        lr_edit      TYPE REF TO cl_ishmed_lte_editor.      "med-29329

*-- begin Grill, med-29329
  l_rn1message = i_rn1message.

  e_cursor_set = off.

  CHECK gr_comment_subscreen IS BOUND.

  IF g_scr_cursorfield IS NOT INITIAL.
    e_cursor_set = on.
  ELSE.
*-- end Grill, med-29329
*-- set cursor
*   MED-32263 - Begin
    IF l_rn1message IS INITIAL.
      e_cursor_set = off.
    ELSE.
*   MED-32263 - End
      CHECK NOT gr_comment_subscreen IS INITIAL.
      CALL METHOD gr_comment_subscreen->set_cursor
        CHANGING
          c_rn1message = l_rn1message.
*-- begin Grill, med-29329
      IF l_rn1message IS INITIAL.
        gs_message = i_rn1message.
        e_cursor_set = on.
      ENDIF.
    ENDIF.                                                  "MED-32263
  ENDIF.

  IF i_set_cursor = on.
    IF e_cursor_set = on.
      CHECK gr_comment_subscreen->g_bmco_edit IS BOUND AND
            gr_comment_subscreen->g_bmco_cont IS BOUND.
      lr_edit = gr_comment_subscreen->g_bmco_edit.
      lr_edit->set_focus( gr_comment_subscreen->g_bmco_cont ).
      CLEAR: g_scr_cursorfield,
             gs_message.
      gr_comment_subscreen->clear_message( ).      "MED-32263
    ENDIF.
  ENDIF.
*-- end Grill, med-29329

ENDMETHOD.


METHOD IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY .

  DATA: l_rc TYPE ish_method_rc,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.

  CALL FUNCTION 'ISH_SDY_COMMENT_INIT'
    EXPORTING
      ir_scr_comment = me
    IMPORTING
      es_parent        = gs_parent
      e_rc             = l_rc
    CHANGING
      cr_dynp_data     = gr_scr_data
      cr_errorhandler  = lr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~transport_from_dy .

  DATA: l_rc            TYPE ish_method_rc,
        lr_corder       TYPE REF TO cl_ish_corder,
        lt_field_val    TYPE ish_t_field_value,
        ls_field_val    TYPE rnfield_value,
        l_wa_object     TYPE ish_object.

* Transport super class(es).
  CALL METHOD super->if_ish_screen~transport_from_dy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get subscreen data
  CLEAR: lr_corder.
  IF NOT gr_comment_subscreen IS INITIAL.
    CALL METHOD gr_comment_subscreen->get_data
      IMPORTING
        e_corder      = lr_corder
        e_vcode       = g_vcode
        e_environment = gr_environment.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy .

  DATA: l_einri TYPE tn01-einri,
        lr_corder TYPE REF TO cl_ish_corder,
        lt_field_val    TYPE ish_t_field_value.

  FIELD-SYMBOLS: <ls_field_val>    TYPE rnfield_value.
* ---------- ----------
* initialize
  e_rc = 0.

* Call standard implementation.
  CALL METHOD super->if_ish_screen~transport_to_dy.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

  IF gr_comment_subscreen IS INITIAL.
* ---------- ----------
*   initialize the screenclass
    CREATE OBJECT gr_comment_subscreen
      EXPORTING
        i_caller = 'CL_ISH_SCR_COMMENT'
        i_einri = l_einri
*    I_VCODE =
        i_environment = gr_environment
        ir_screen     = me.                "RW ID 14654
    e_rc = sy-subrc.
    CHECK e_rc = 0.
  ENDIF.

** ----------
** get values
*  CALL METHOD gr_screen_values->get_data
*    IMPORTING
*      et_field_values = lt_field_val
*      e_rc            = e_rc
*    CHANGING
*      c_errorhandler  = cr_errorhandler.
** ---------- ---------- ----------
*  LOOP AT lt_field_val ASSIGNING <ls_field_val>.
*    CASE <ls_field_val>-fieldname.
*      WHEN 'POLICY1'.
*        gr_policy1 ?= <ls_field_val>-object.
*      WHEN 'POLICY2'.
*        gr_policy2 ?= <ls_field_val>-object.
*      WHEN 'POLICY3'.
*        gr_policy3 ?= <ls_field_val>-object.
*    ENDCASE.
*  ENDLOOP.
*
* ---------- ----------
  lr_corder ?= gr_main_object.
* give the subscreen the actual clinical order
  CALL METHOD gr_comment_subscreen->set_data
    EXPORTING
      i_corder  = lr_corder
      i_vcode   = g_vcode
      i_vcode_x = on.

* give the fub in de subscreen the reference of the screenclass
* Nun dem Subscreen diese Klasse übergeben
  CALL FUNCTION 'ISH_SET_SUBSCR_FURTHER_DET_CO'
    EXPORTING
      i_further_det_sub = gr_comment_subscreen.

ENDMETHOD.


METHOD INITIALIZE_FIELD_VALUES .
** local tables
*  DATA: lt_field_val            TYPE ish_t_field_value.
** workareas
*  DATA: ls_field_val            TYPE rnfield_value.
** ---------- ---------- ----------
** initialize
*  e_rc = 0.
** ---------- ---------- ----------
*  CLEAR: lt_field_val.
** ----------
** initialize every screen field
*  CLEAR: ls_field_val.
*  ls_field_val-fieldname = 'POLICY1'.
*  ls_field_val-type      = co_fvtype_identify.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  CLEAR: ls_field_val.
*  ls_field_val-fieldname = 'POLICY2'.
*  ls_field_val-type      = co_fvtype_identify.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  CLEAR: ls_field_val.
*  ls_field_val-fieldname = 'POLICY3'.
*  ls_field_val-type      = co_fvtype_identify.
*  INSERT ls_field_val INTO TABLE lt_field_val.
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


METHOD initialize_internal .

* set subscreen
  g_pgm_comment = 'SAPLNCORD'.
  g_dynnr_comment = '0100'.
  IF g_first_time = on.
    IF NOT gr_comment_subscreen IS INITIAL.
      IF NOT gr_comment_subscreen->g_bmco_cont IS INITIAL.
        FREE: gr_comment_subscreen->g_bmco_cont.
        CLEAR gr_comment_subscreen->g_bmco_cont.
      ENDIF.
      IF NOT gr_comment_subscreen->g_bmco_edit IS INITIAL.
        FREE: gr_comment_subscreen->g_bmco_edit.
        CLEAR: gr_comment_subscreen->g_bmco_edit.
      ENDIF.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD INITIALIZE_PARENT .

  CLEAR: gs_parent, e_rc.

  gs_parent-repid = 'SAPLN1_SDY_COMMENT'.
  gs_parent-dynnr = '0100'.
  gs_parent-type = co_scr_parent_type_dynpro.

ENDMETHOD.


METHOD is_message_handled.

  IF is_message-field = 'N1CORDER-RMCORD'.
    r_is_handled     = on.
  ENDIF.

ENDMETHOD.


METHOD modify_screen_att .

*  IF NOT gr_comment_subscreen IS INITIAL.
*    IF NOT gr_comment_subscreen->g_bmco_edit IS INITIAL.
*      CALL METHOD gr_comment_subscreen->g_bmco_edit->set_readonly_mode
*        EXPORTING
*          readonly_mode          = true
*        EXCEPTIONS
*          error_cntl_call_method = 1
*          invalid_parameter      = 2
*          OTHERS                 = 3.
*      IF sy-subrc <> 0.
** MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
**            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*      ENDIF.
*    ENDIF.
*  ENDIF.

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


  DATA l_readonly_mode            TYPE i.
  DATA l_visible                  TYPE ish_on_off.

  FIELD-SYMBOLS <ls_modified>     TYPE rn1screen.

  CLEAR e_rc.

  check gr_comment_subscreen->g_bmco_edit is bound.

  l_readonly_mode = 0.
  l_visible = on.

  IF g_vcode = co_vcode_display.
    l_readonly_mode = 1.
  ENDIF.

  READ TABLE it_modified
    WITH KEY name = 'FRAME_COMMENT'
    ASSIGNING <ls_modified>.
  IF sy-subrc = 0.
    IF <ls_modified>-active = 0.
      l_visible = off.
      l_readonly_mode = 1.
    ELSEIF <ls_modified>-input = 0.
      l_readonly_mode = 1.
    ENDIF.
  ENDIF.

  CALL METHOD gr_comment_subscreen->g_bmco_edit->set_visible
    EXPORTING
      visible = l_visible
    EXCEPTIONS
      OTHERS  = 1.

  CALL METHOD gr_comment_subscreen->g_bmco_edit->set_readonly_mode
    EXPORTING
      readonly_mode = l_readonly_mode
    EXCEPTIONS
      OTHERS        = 1.

*  CLEAR: e_rc.
*
**  CALL METHOD me->modify_screen_att
**    IMPORTING
**      e_rc            = e_rc
**    CHANGING
**      cr_errorhandler = cr_errorhandler.
*
*  LOOP AT SCREEN.
*
*    IF screen-name = 'BMCO_CONTAINER' OR
*       screen-name = 'FRAME_COMMENT'.
*      READ TABLE it_modified
*            WITH KEY name = screen-name
*               TRANSPORTING NO FIELDS.
*      CHECK sy-subrc = 0.
*      IF NOT gr_comment_subscreen IS INITIAL.
*        IF NOT gr_comment_subscreen->g_bmco_edit IS INITIAL.
*       CALL METHOD gr_comment_subscreen->g_bmco_edit->set_readonly_mode
**            EXPORTING
**              readonly_mode          = true
*            EXCEPTIONS
*              error_cntl_call_method = 1
*              invalid_parameter      = 2
*              OTHERS                 = 3.
*          IF sy-subrc <> 0.
** MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
**            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*          ENDIF.
*        ENDIF.
*      ENDIF.
*    ENDIF.
*
*  ENDLOOP.

ENDMETHOD.


METHOD set_cursor_internal.

*-- begin Grill, med-29329
*  DATA: lr_message TYPE rn1message.
*
**-- set cursor
*  CHECK NOT gr_comment_subscreen IS INITIAL.
*  CALL METHOD gr_comment_subscreen->set_cursor
*    CHANGING
*      c_rn1message = lr_message.
  CALL METHOD super->set_cursor_internal. "med-29329
*-- end Grill, med-29329

ENDMETHOD.
ENDCLASS.
