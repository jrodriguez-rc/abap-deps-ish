class CL_ISH_PRC_MED_DATA definition
  public
  create protected .

*"* public components of class CL_ISH_PRC_MED_DATA
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_PRC_MED_DATA type ISH_OBJECT_TYPE value 6020. "#EC NOTEXT

  methods CONSTRUCTOR .
  methods DESTROY .
  class-methods CREATE
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ER_INSTANCE) type ref to CL_ISH_PRC_MED_DATA
    changing
      value(CR_ENVIRONMENT) type ref to CL_ISH_ENVIRONMENT optional
      value(CR_CORDER) type ref to CL_ISH_CORDER optional
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods USER_COMMAND .
  methods COUPLE
    exporting
      value(ES_PARENT) type RNSCR_PARENT .
  methods GET_PARENT
    returning
      value(RS_PARENT) type RNSCR_PARENT .
  methods OK_CODE_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      value(C_OKCODE) type SY-UCOMM .
protected section.
*"* protected components of class CL_ISH_PRC_MED_DATA
*"* do not include other source files here!!!

  class-data G_COMP_MED_DATA_CLASSNAME type STRING .
  data G_VCODE type TNDYM-VCODE .
  data GR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT .
  data GR_CORDER type ref to CL_ISH_CORDER .
  data GR_SCREEN type ref to CL_ISH_SCREEN .
  data GR_SCR_MED_DATA type ref to CL_ISH_SCR_MED_DATA .
  data GR_COMP_MED_DATA type ref to CL_ISH_COMP_MED_DATA .
  data GR_PRC_MED_DATA type ref to CL_ISH_PRC_MED_DATA .
  data GS_PARENT type RNSCR_PARENT .

  methods COMPLETE_CONSTRUCTION
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CR_ENVIRONMENT) type ref to CL_ISH_ENVIRONMENT optional
      value(CR_CORDER) type ref to CL_ISH_CORDER optional
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_PRC_MED_DATA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_PRC_MED_DATA IMPLEMENTATION.


METHOD complete_construction .

  DATA: l_new       TYPE ish_on_off,
        lr_instance TYPE REF TO if_ish_component,
        lt_screen   TYPE ish_t_screen_objects,
        lr_screen   TYPE REF TO if_ish_screen,
        ls_n1corder TYPE n1corder.

* Handle process environment.
  gr_environment = cr_environment.
  IF gr_environment IS INITIAL.
    IF NOT gr_corder IS INITIAL.
      CALL METHOD gr_corder->get_environment
        IMPORTING
          e_environment = gr_environment.
    ENDIF.
  ENDIF.
  IF gr_environment IS INITIAL.
    CALL METHOD cl_ish_fac_environment=>create
      EXPORTING
        i_program_name = 'CL_ISH_PRC_MED_DATA'
      IMPORTING
        e_instance     = gr_environment
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
  ENDIF.

* Errorhandling
  IF e_rc <> 0.
    CALL METHOD destroy.
    EXIT.
  ENDIF.

* Handle the main object.
  gr_corder = cr_corder.
  IF gr_corder IS INITIAL.
    ls_n1corder-mandt = sy-mandt.
    CALL FUNCTION 'ISH_GET_PARAMETER_ID'
      EXPORTING
        i_parameter_id    = 'EIN'
      IMPORTING
        e_parameter_value = ls_n1corder-einri.
    CALL METHOD cl_ish_fac_corder=>create
      EXPORTING
        is_n1corder     = ls_n1corder
        ir_environment  = gr_environment
      IMPORTING
        er_instance     = gr_corder
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

* Errorhandling
  IF e_rc <> 0.
    CALL METHOD destroy.
    EXIT.
  ENDIF.

* G_VCODE
  CALL METHOD gr_corder->is_new
    IMPORTING
      e_new = l_new.
  IF l_new = on.
    g_vcode = co_vcode_insert.
  ELSE.
    g_vcode = co_vcode_update.
  ENDIF.

* handle comp order
  CALL METHOD cl_ish_comp_med_data=>create
    EXPORTING
      i_classname           = g_comp_med_data_classname
      ir_main_object        = gr_corder
*    IT_ADDITIONAL_OBJECTS =
      i_vcode               = g_vcode
      i_caller              = 'CL_ISH_PRC_MED_DATA'
      ir_environment        = gr_environment
*    IR_LOCK               =
*    IR_CONFIG             =
    IMPORTING
      er_instance           = lr_instance
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler
    EXCEPTIONS
      ex_invalid_classname  = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
  CHECK e_rc = 0.

  IF NOT lr_instance IS INITIAL.
    IF lr_instance->is_inherited_from(
              cl_ish_comp_med_data=>co_otype_comp_med_data ) = on.
      gr_comp_med_data ?= lr_instance.
    ENDIF.
  ENDIF.
  IF gr_comp_med_data IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* get defined screens from comp order
  CALL METHOD gr_comp_med_data->get_defined_screens
    RECEIVING
      rt_screen_objects = lt_screen.
  READ TABLE lt_screen INDEX 1 INTO lr_screen.
  IF sy-subrc = 0 AND
     NOT lr_screen IS INITIAL.
    IF lr_screen->is_inherited_from(
              cl_ish_scr_med_data=>co_otype_scr_med_data ) = on.
      gr_scr_med_data ?= lr_screen.
    ENDIF.
  ENDIF.
  IF gr_scr_med_data IS INITIAL.
    e_rc = 1.
  ENDIF.

* initialize the screen
  CALL METHOD gr_scr_med_data->initialize
    EXPORTING
      i_main_object  = gr_corder
      i_vcode        = g_vcode
      i_caller       = sy-repid
      i_environment  = gr_environment
*    I_LOCK         =
*    I_CONFIG       =
*  IMPORTING
*    E_PGM          =
*    E_DYNNR        =
*    E_RC           =
    CHANGING
      c_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD constructor .

** Set dynpg/dynnr
*  gs_parent-repid = 'SAPLN1_SDY_ORDER'.
*  gs_parent-dynnr = '0100'.
*  gs_parent-type = co_scr_parent_type_dynpro.

* Handle component classnames.
  g_comp_med_data_classname = 'CL_ISH_COMP_MED_DATA'.

ENDMETHOD.


METHOD couple .

* screen class
  CALL METHOD gr_scr_med_data->set_instance_for_display.

* dynpro + program
  CALL METHOD gr_scr_med_data->get_parent
    IMPORTING
      es_parent = gs_parent.
  es_parent = gs_parent.

ENDMETHOD.


METHOD create .

  DATA: lr_prc_med_data  TYPE REF TO cl_ish_prc_med_data.

* Create the object.
  CREATE OBJECT lr_prc_med_data.

* Complete construction.
  CALL METHOD lr_prc_med_data->complete_construction
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_environment  = cr_environment
      cr_corder       = cr_corder
      cr_errorhandler = cr_errorhandler.

* Export the object.
  er_instance = lr_prc_med_data.

ENDMETHOD.


METHOD DESTROY .

* Handle process environment.
  CLEAR: gr_environment.

* Handle main object.
  CLEAR: gr_corder.

ENDMETHOD.


METHOD GET_PARENT .

  rs_parent = gs_parent.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~GET_TYPE .

  e_object_type = co_otype_prc_med_data.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~IS_A .

  DATA: l_object_type  TYPE i.

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

  IF i_object_type = co_otype_prc_med_data.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


method OK_CODE_SCREEN .

  CALL METHOD gr_scr_med_data->ok_code_screen
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler
      c_okcode       = c_okcode.

endmethod.


method USER_COMMAND .
endmethod.
ENDCLASS.
