class CL_ISH_UTL_SCREEN definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_UTL_SCREEN
*"* do not include other source files here!!!
public section.
  type-pools ABAP .

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_FV_CONSTANTS .

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
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
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

  class-methods CREATE_SCREEN
    importing
      value(I_CLASS_NAME) type STRING optional
      value(I_FACTORY_NAME) type STRING optional
      value(I_OBJECT_TYPE) type I
      value(I_USE_BADI) type ISH_ON_OFF default ON
      value(I_REFRESH_BADI_INSTANCE) type ISH_ON_OFF default OFF
      value(I_FORCE_BADI_ERROR) type ISH_ON_OFF default OFF
      value(I_CREATE_OWN) type ISH_ON_OFF default ON
      value(I_CREATE_METHOD_NAME) type STRING default 'CREATE'
    exporting
      !ER_SCREEN type ref to IF_ISH_SCREEN
      value(E_CREATED_BY_BADI) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods DESTROY_SCREEN
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      value(I_DESTROY_EMBEDDED_SCR) type ISH_ON_OFF default ON
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_CHG_STR_FROM_FV
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      value(IT_FIELDNAME_MAPPING) type ISH_T_FIELDNAME_MAPPING optional
      value(I_SET_ONLY_CHG_FIELDS) type ISH_ON_OFF default 'X'
    exporting
      value(E_CHANGED) type ISH_ON_OFF
      value(E_RC) type I
    changing
      value(CS_DATA) type ANY
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FILL_FV_FROM_STR
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      value(IS_DATA) type ANY
      value(IT_FIELDNAME_MAPPING) type ISH_T_FIELDNAME_MAPPING optional
    exporting
      value(E_RC) type I
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_CUSTOMER_SCREEN_INST
    importing
      value(I_OBJECT_TYPE) type I
    exporting
      !ER_CUSTOMER_SCREEN type ref to CL_ISH_SCREEN_STD
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DEFAULT_CURSORFIELD
    importing
      value(IT_SCREENS) type ISH_T_SCREEN_OBJECTS
    exporting
      value(E_CRS_FIELD) type ISH_FIELDNAME
      value(ER_CRS_SCR) type ref to IF_ISH_SCREEN
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_EMBEDDED_CNTL_SCR
    importing
      !IR_SCR type ref to IF_ISH_SCREEN
      value(I_ONLY_NEXT_LEVEL) type ISH_ON_OFF default OFF
    exporting
      !ET_CNTL_SCR type ISH_T_SCR_CONTROL
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_FIELDVALS_AS_XML_ELEMENT
    importing
      !IT_FIELDVAL type ISH_T_FIELD_VALUE
      !IR_XML_DOCUMENT type ref to IF_IXML_DOCUMENT
      value(I_EMBEDDED_SCREENS) type ISH_ON_OFF default ON
    exporting
      !ER_XML_ELEMENT type ref to IF_IXML_ELEMENT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_SCREEN_AS_XML_DOCUMENT
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      !IR_IXML type ref to IF_IXML optional
      value(I_EMBEDDED_SCREENS) type ISH_ON_OFF default ON
    exporting
      !ER_XML_DOCUMENT type ref to IF_IXML_DOCUMENT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_SCREEN_AS_XML_ELEMENT
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      !IR_XML_DOCUMENT type ref to IF_IXML_DOCUMENT
      value(I_EMBEDDED_SCREENS) type ISH_ON_OFF default ON
    exporting
      !ER_XML_ELEMENT type ref to IF_IXML_ELEMENT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_SCREEN_INSTANCES
    importing
      value(I_SCREEN) type ref to IF_ISH_SCREEN
      value(I_EMBEDDED_SCR) type ISH_ON_OFF default OFF
      value(I_ONLY_NEXT_LEVEL) type ISH_ON_OFF default OFF
    exporting
      value(ET_SCREENS) type ISH_T_SCREEN_OBJECTS
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_SCR_CONTROL_FOR_UCOMM
    importing
      !IT_SCREEN type ISH_T_SCREEN_OBJECTS
      !I_UCOMM type SY-UCOMM
    returning
      value(RR_SCR_CONTROL) type ref to IF_ISH_SCR_CONTROL .
  class-methods GET_ORIGIN_UCOMM_FOR_SCR_CNTL
    importing
      value(IT_SCREEN) type ISH_T_SCREEN_OBJECTS
      value(I_UCOMM) type SY-UCOMM
    returning
      value(RR_UCOMM) type SY-UCOMM .
  class-methods GET_SPECIAL_SCREEN
    importing
      value(IT_SCREENS) type ISH_T_SCREEN_OBJECTS
      value(I_TYPE) type I
    exporting
      !ER_SCREEN type ref to IF_ISH_SCREEN
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods MAP_FV_TO_STR
    importing
      value(I_SET_CHG_FLAG) type ISH_ON_OFF default SPACE
      value(IT_FIELD_VALUES) type ISH_T_FIELD_VALUE
      value(IT_FIELDNAME_MAPPING) type ISH_T_FIELDNAME_MAPPING optional
    exporting
      value(E_RC) type I
    changing
      value(CS_DATA) type ANY
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods MAP_STR_TO_FV
    importing
      value(IS_DATA) type ANY
      value(IT_FIELDNAME_MAPPING) type ISH_T_FIELDNAME_MAPPING optional
    exporting
      value(E_RC) type I
    changing
      value(CT_FIELD_VALUES) type ISH_T_FIELD_VALUE
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods SET_FIELDVALS_BY_XML_DOCUMENT
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      !IR_XML_DOCUMENT type ref to IF_IXML_DOCUMENT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods SET_FIELDVALS_BY_XML_ELEMENT
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      !IR_XML_ELEMENT type ref to IF_IXML_ELEMENT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods SET_FV_BY_XML_NODE
    importing
      !IR_FIELDVAL type ref to CL_ISH_FIELD_VALUES
      !IR_XML_NODE type ref to IF_IXML_NODE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_UTL_BASE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_SCREEN
*"* do not include other source files here!!!

  aliases CO_FVTYPE_FV
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_FV .
  aliases CO_FVTYPE_IDENTIFY
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_IDENTIFY .
  aliases CO_FVTYPE_SCREEN
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_SCREEN .
  aliases CO_FVTYPE_SINGLE
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_SINGLE .
ENDCLASS.



CLASS CL_ISH_UTL_SCREEN IMPLEMENTATION.


METHOD create_screen.

  DATA: lr_badi     TYPE REF TO if_ex_n1_create_screen,
        lr_screen   TYPE REF TO if_ish_screen,
        l_rc        TYPE ish_method_rc.

* Initializations
  e_rc              = 0.
  e_created_by_badi = off.
  CLEAR: er_screen.

  CLEAR: lr_badi.

* Let the BADI handle the screen creation.
  DO 1 TIMES.
*   Process the badi only if specified.
    CHECK i_use_badi = on.
*   Get the BADI instance. Offen ???
*    IF i_refresh_badi_instance = on.
*      CLEAR gr_badi_create_screen.
*    ENDIF.
*    lr_badi = gr_badi_create_screen.
*   Load the BADI instance if not already done.
    IF lr_badi IS INITIAL.
*     Check if the BADI is active.
      CALL FUNCTION 'SXC_EXIT_CHECK_ACTIVE'
        EXPORTING
          exit_name  = 'N1_CREATE_SCREEN'
        EXCEPTIONS
          not_active = 1
          OTHERS     = 2.
*     If the BADI is not active do not process the BADI.
      CHECK sy-subrc = 0.
*     Get instance of the BADI.
      CALL METHOD cl_exithandler=>get_instance
        EXPORTING
          exit_name                     = 'N1_CREATE_SCREEN'
          null_instance_accepted        = on
        CHANGING
          instance                      = lr_badi
        EXCEPTIONS
          no_reference                  = 1
          no_interface_reference        = 2
          no_exit_interface             = 3
          class_not_implement_interface = 4
          single_exit_multiply_active   = 5
          cast_error                    = 6
          exit_not_existing             = 7
          data_incons_in_exit_managem   = 8
          OTHERS                        = 9.
      l_rc = sy-subrc.
      IF l_rc <> 0.
*       BADI & kann nicht instanziert werden (Fehler &)
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'NFCL'
            i_num           = '112'
            i_mv1           = 'N1_CREATE_SCREEN'
            i_mv2           = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        EXIT.
      ENDIF.
    ENDIF.
*   Process the badi.
    CHECK NOT lr_badi IS INITIAL.
    CALL METHOD lr_badi->create_screen
      EXPORTING
        i_class_name    = i_class_name
        i_factory_name  = i_factory_name
        i_object_type   = i_object_type
      IMPORTING
        er_screen       = lr_screen
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK l_rc = 0.
    CHECK NOT lr_screen IS INITIAL.
*   Check the created screen object.
*   It has to inherit from the given object type.
    IF lr_screen->is_inherited_from( i_object_type ) = off.
      l_rc = 1.
*     Offen ??? Andere Fehlermeldung.
*     BADI & kann nicht instanziert werden (Fehler &)
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'NFCL'
          i_num           = '112'
          i_mv1           = 'N1_CREATE_SCREEN'
          i_mv2           = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.
  ENDDO.

* Handle badi errors.
  IF l_rc <> 0.
    IF i_force_badi_error = on.
      l_rc = 0.
    ELSE.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.

* Further processing only if the BADI did not create the screen.
  IF NOT lr_screen IS INITIAL.
    e_created_by_badi = on.
    er_screen         = lr_screen.
    EXIT.
  ENDIF.

* Further processing only if specified.
  CHECK i_create_own = on.

* Do own screen creation.
  CATCH SYSTEM-EXCEPTIONS dyn_call_meth_excp_not_found   = 1
                          dyn_call_meth_class_not_found  = 2
                          dyn_call_meth_classconstructor = 3
                          dyn_call_meth_constructor      = 4
                          dyn_call_meth_not_found        = 5
                          dyn_call_meth_no_class_method  = 6
                          dyn_call_meth_private          = 7
                          dyn_call_meth_protected        = 8
                          dyn_call_meth_param_kind       = 9
                          dyn_call_meth_param_litl_move  = 10
                          dyn_call_meth_param_tab_type   = 11
                          dyn_call_meth_param_type       = 12
                          dyn_call_meth_param_missing    = 13
                          dyn_call_meth_parref_initial   = 14
                          dyn_call_meth_param_not_found  = 15
                          dyn_call_meth_ref_is_initial   = 16.
    CASE i_object_type.
      WHEN OTHERS.
        IF NOT i_factory_name IS INITIAL.
*         Create by factory.
          CALL METHOD (i_factory_name)=>(i_create_method_name)
            IMPORTING
              er_interface    = lr_screen
              e_rc            = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          CHECK e_rc = 0.
        ELSEIF NOT i_class_name IS INITIAL.
*         Create by class.
          CALL METHOD (i_class_name)=>(i_create_method_name)
            IMPORTING
              er_interface    = lr_screen
              e_rc            = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          CHECK e_rc = 0.
        ENDIF.
    ENDCASE.
  ENDCATCH.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
*   Offen ??? Andere Fehlermeldung.
*   BADI & kann nicht instanziert werden (Fehler &)
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'NFCL'
        i_num           = '112'
        i_mv1           = 'N1_CREATE_SCREEN'
        i_mv2           = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Export.
  e_created_by_badi = off.
  er_screen         = lr_screen.

ENDMETHOD.


METHOD destroy_screen .

  DATA: l_rc             TYPE ish_method_rc,
        lt_screens       TYPE ish_t_screen_objects.
* Michael Manoch, 17.02.2005   START
  DATA: lr_scr_control  TYPE REF TO if_ish_scr_control.
* Michael Manoch, 17.02.2005   END
  FIELD-SYMBOLS:
        <lr_screen>      TYPE REF TO if_ish_screen.

* initialize
  e_rc = 0.

  CHECK NOT ir_screen IS INITIAL.

* get all screens
  CALL METHOD cl_ish_utl_screen=>get_screen_instances
    EXPORTING
      i_screen       = ir_screen
      i_embedded_scr = i_destroy_embedded_scr
    IMPORTING
      et_screens     = lt_screens
      e_rc           = l_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* destroy screens
  LOOP AT lt_screens ASSIGNING <lr_screen>.
*   Michael Manoch, 17.02.2005   START
*   Control-Screens have to be destroyed in correct order.
*   Therefore use method destroy_incl_embcntl.
    CHECK <lr_screen> IS BOUND.
    IF i_destroy_embedded_scr = on AND
       <lr_screen>->is_inherited_from(
         cl_ish_scr_control=>co_otype_scr_control ) = on.
      lr_scr_control ?= <lr_screen>.
      CALL METHOD lr_scr_control->destroy_incl_embcntl
        IMPORTING
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
      CONTINUE.
    ENDIF.
*   Michael Manoch, 17.02.2005   END
    CALL METHOD <lr_screen>->destroy
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD fill_chg_str_from_fv .

* local tables
  DATA: lt_field_val        TYPE ish_t_field_value.
* definitions
  DATA: l_rc                TYPE ish_method_rc.
* references
  DATA: lr_screen_val       TYPE REF TO cl_ish_field_values.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  CLEAR: e_changed.
* ---------- ---------- ----------
* instance of screen is mandatory
  IF ir_screen IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* get instance of screen values to be able to get changed values
  CALL METHOD ir_screen->get_data
    IMPORTING
      e_screen_values = lr_screen_val.
* ---------- ---------- ----------
* first get changes of field values
  CALL METHOD lr_screen_val->check_changes
    IMPORTING
      e_changed               = e_changed
      et_changed_field_values = lt_field_val
      e_rc                    = l_rc
    CHANGING
      c_errorhandler          = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  IF i_set_only_chg_fields = off.
*   set all fields and not only changed
*   set fields also if there are no changes
    CALL METHOD lr_screen_val->get_data
      IMPORTING
        et_field_values = lt_field_val
        e_rc            = l_rc
      CHANGING
        c_errorhandler  = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ELSE.
*   only process method if there are changes
    CHECK e_changed = on.
  ENDIF.
* ---------- ---------- ----------
  CALL METHOD cl_ish_utl_screen=>map_fv_to_str
    EXPORTING
      i_set_chg_flag       = on
      it_field_values      = lt_field_val
      it_fieldname_mapping = it_fieldname_mapping
    IMPORTING
      e_rc                 = l_rc
    CHANGING
      cs_data              = cs_data
      cr_errorhandler      = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD fill_fv_from_str .

* local tables
  DATA: lt_field_val        TYPE ish_t_field_value.
* definitions
  DATA: l_rc                TYPE ish_method_rc.
* references
  DATA: lr_screen_val       TYPE REF TO cl_ish_field_values.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* instance of screen is mandatory
  IF ir_screen IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* get field values
  CALL METHOD ir_screen->get_fields
    IMPORTING
      et_field_values = lt_field_val
      e_rc            = l_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  CALL METHOD cl_ish_utl_screen=>map_str_to_fv
    EXPORTING
      is_data              = is_data
      it_fieldname_mapping = it_fieldname_mapping
    IMPORTING
      e_rc                 = l_rc
    CHANGING
      ct_field_values      = lt_field_val
      cr_errorhandler      = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


method GET_CUSTOMER_SCREEN_INST .
  data: lr_badi type ref to if_ex_n1create_screen,
        l_rc    type ish_method_rc.

* ---------------------------------------------------------
* Initialization
  e_rc = 0.
  clear: er_customer_screen.
  clear: lr_badi.

* ---------------------------------------------------------
* Is the BADI active? That must always be checked here, because
* it would cause a dump!
  CALL FUNCTION 'SXC_EXIT_CHECK_ACTIVE'
    EXPORTING
      EXIT_NAME         = 'N1CREATE_SCREEN'
    EXCEPTIONS
      NOT_ACTIVE        = 1
      OTHERS            = 2.
  check sy-subrc = 0.

* Get instance of the BADI
  CALL METHOD CL_EXITHANDLER=>GET_INSTANCE
    EXPORTING
      EXIT_NAME                     = 'N1CREATE_SCREEN'
      NULL_INSTANCE_ACCEPTED        = 'X'
    CHANGING
      INSTANCE                      = lr_badi
    EXCEPTIONS
      NO_REFERENCE                  = 1
      NO_INTERFACE_REFERENCE        = 2
      NO_EXIT_INTERFACE             = 3
      CLASS_NOT_IMPLEMENT_INTERFACE = 4
      SINGLE_EXIT_MULTIPLY_ACTIVE   = 5
      CAST_ERROR                    = 6
      EXIT_NOT_EXISTING             = 7
      DATA_INCONS_IN_EXIT_MANAGEM   = 8
      others                        = 9.
  l_rc = sy-subrc.
  IF l_rc <> 0  OR  lr_badi IS INITIAL.
    e_rc = l_rc.
*   BADI & kann nicht instanziert werden (Fehler &)
    CALL METHOD CL_ISH_UTL_BASE=>COLLECT_MESSAGES
      EXPORTING
        I_TYP           = 'E'
        I_KLA           = 'NFCL'
        I_NUM           = '112'
        I_MV1           = 'N1CREATE_SCREEN'
        I_MV2           = e_rc
      CHANGING
        CR_ERRORHANDLER = cr_errorhandler.
    EXIT.
  endif.

* The instance of the BADI has been created now. So its
* CREATE-method can be called to get the instance of the
* customer-screen
  if not lr_badi is initial.
    CALL METHOD LR_BADI->CREATE
      EXPORTING
        I_OBJECT_TYPE   = i_object_type
      IMPORTING
        ER_INSTANCE     = er_customer_screen
        E_RC            = l_rc
      CHANGING
        CR_ERRORHANDLER = cr_errorhandler.
    if l_rc <> 0.
      e_rc = l_rc.
      exit.
    endif.
  endif.
endmethod.


METHOD get_default_cursorfield .

* definitions
  DATA: l_rc                     TYPE ish_method_rc,
        l_crs_field              TYPE ish_fieldname,
*       cursorfields for export
        l_crs_field_prio1_exp    TYPE ish_fieldname,
        l_crs_field_prio2_exp    TYPE ish_fieldname,
        l_crs_field_prio3_exp    TYPE ish_fieldname,
*       cursorfields of actual screen
        l_crs_field_prio1_act    TYPE ish_fieldname,
        l_crs_field_prio2_act    TYPE ish_fieldname,
        l_crs_field_prio3_act    TYPE ish_fieldname.
* object references
  DATA: lr_crs_scr               TYPE REF TO if_ish_screen,
*       cursorfields for export
        lr_crs_scr_prio1_exp     TYPE REF TO if_ish_screen,
        lr_crs_scr_prio2_exp     TYPE REF TO if_ish_screen,
        lr_crs_scr_prio3_exp     TYPE REF TO if_ish_screen,
*       cursorfields of actual screen
        lr_crs_scr_prio1_act     TYPE REF TO if_ish_screen,
        lr_crs_scr_prio2_act     TYPE REF TO if_ish_screen,
        lr_crs_scr_prio3_act     TYPE REF TO if_ish_screen,
        lr_scr                   TYPE REF TO if_ish_screen.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  CLEAR: e_crs_field, er_crs_scr.
* ----------
  CLEAR: l_crs_field_prio1_exp,
         l_crs_field_prio2_exp,
         l_crs_field_prio3_exp,
         l_crs_field_prio1_act,
         l_crs_field_prio2_act,
         l_crs_field_prio3_act,
         lr_crs_scr_prio1_exp,
         lr_crs_scr_prio2_exp,
         lr_crs_scr_prio3_exp,
         lr_crs_scr_prio1_act,
         lr_crs_scr_prio2_act,
         lr_crs_scr_prio3_act.
* ---------- ---------- ----------
* find correct cursor position
  LOOP AT it_screens INTO lr_scr.
*   ----------
*   get default cursorfield
    CALL METHOD lr_scr->get_default_cursorfield
      IMPORTING
        e_cursorfield = l_crs_field
        er_screen     = lr_crs_scr.
    IF l_crs_field IS INITIAL AND
       lr_crs_scr  IS INITIAL.
      CONTINUE.
    ENDIF.
*   ----------
*   get possible cursor positions
*   to check priority
    lr_scr ?= lr_crs_scr.
    CALL METHOD lr_scr->get_def_crs_possible
      IMPORTING
        e_crs_field_prio1 = l_crs_field_prio1_act
        er_crs_scr_prio1  = lr_crs_scr_prio1_act
        e_crs_field_prio2 = l_crs_field_prio2_act
        er_crs_scr_prio2  = lr_crs_scr_prio2_act
        e_crs_field_prio3 = l_crs_field_prio3_act
        er_crs_scr_prio3  = lr_crs_scr_prio3_act
        e_rc              = l_rc.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.
*   ----------
    IF NOT l_crs_field_prio1_act IS INITIAL     AND
       NOT lr_crs_scr_prio1_act  IS INITIAL     AND
           l_crs_field_prio1_act =  l_crs_field AND
           lr_crs_scr_prio1_act  =  lr_crs_scr.
*     field is set as priority one cursorfield
*     use this cursorposition
      l_crs_field_prio1_exp  = l_crs_field_prio1_act.
      lr_crs_scr_prio1_exp   = lr_crs_scr_prio1_act.
      EXIT.
    ENDIF.
*   ----------
    IF l_crs_field_prio2_exp IS INITIAL     AND
       lr_crs_scr_prio2_exp  IS INITIAL     AND
       l_crs_field_prio2_act =  l_crs_field AND
       lr_crs_scr_prio2_act  =  lr_crs_scr.
*     field is set as priority two cursorfield
*     set field for later checks
      l_crs_field_prio2_exp = l_crs_field_prio2_act.
      lr_crs_scr_prio2_exp  = lr_crs_scr_prio2_act.
    ENDIF.
*   ----------
    IF l_crs_field_prio3_exp IS INITIAL     AND
       lr_crs_scr_prio3_exp  IS INITIAL     AND
       l_crs_field_prio3_act =  l_crs_field AND
       lr_crs_scr_prio3_act  =  lr_crs_scr.
*     field is set as priority two cursorfield
*     set field for later checks
      l_crs_field_prio3_exp = l_crs_field_prio3_act.
      lr_crs_scr_prio3_exp  = lr_crs_scr_prio3_act.
    ENDIF.
*   ----------
  ENDLOOP.
* ---------- ---------- ----------
* set correct cursor position
  IF NOT l_crs_field_prio1_exp IS INITIAL AND
     NOT lr_crs_scr_prio1_exp  IS INITIAL.
*   priority 1
    e_crs_field = l_crs_field_prio1_exp.
    er_crs_scr  = lr_crs_scr_prio1_exp.
  ELSEIF NOT l_crs_field_prio2_exp IS INITIAL AND
         NOT lr_crs_scr_prio2_exp  IS INITIAL.
*   priority 2
    e_crs_field = l_crs_field_prio2_exp.
    er_crs_scr  = lr_crs_scr_prio2_exp.
  ELSEIF NOT l_crs_field_prio3_exp IS INITIAL AND
         NOT lr_crs_scr_prio3_exp  IS INITIAL.
*   priority 3
    e_crs_field = l_crs_field_prio3_exp.
    er_crs_scr  = lr_crs_scr_prio3_exp.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_embedded_cntl_scr.

  DATA: l_rc           TYPE ish_method_rc.

  DATA: lt_screens     TYPE ish_t_screen_objects.

  DATA: lr_cntl_scr    TYPE REF TO if_ish_scr_control.

  FIELD-SYMBOLS:
       <ls_screen>    TYPE REF TO if_ish_screen.
* -------- --------- ----------
  CLEAR: e_rc, et_cntl_scr.
* -------- ---------
  CALL METHOD cl_ish_utl_screen=>get_screen_instances
    EXPORTING
      i_screen          = ir_scr
      i_embedded_scr    = on
      i_only_next_level = i_only_next_level
    IMPORTING
      et_screens        = lt_screens
      e_rc              = l_rc
    CHANGING
      c_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* -------- ---------
  LOOP AT lt_screens ASSIGNING <ls_screen>.
    IF <ls_screen>->if_ish_identify_object~is_inherited_from(
        cl_ish_scr_control=>co_otype_scr_control ) = on.
      lr_cntl_scr ?= <ls_screen>.
      INSERT lr_cntl_scr INTO TABLE et_cntl_scr.
    ELSE.
      DELETE lt_screens.
    ENDIF.
  ENDLOOP.
* -------- ---------
  IF e_rc <> 0.
    CLEAR: et_cntl_scr.
  ENDIF.
* -------- --------- ----------
ENDMETHOD.


METHOD get_fieldvals_as_xml_element .

  DATA: l_object_type      TYPE i,
        l_class_name       TYPE string,
        lr_fvroot_element  TYPE REF TO if_ixml_element,
        lr_fv_element      TYPE REF TO if_ixml_element,
        l_string           TYPE string,
        lr_scr_embedded    TYPE REF TO if_ish_screen,
        lr_xml_element     TYPE REF TO if_ixml_element,
        lt_fv_embedded     TYPE ish_t_field_value,
        lr_fv              TYPE REF TO cl_ish_field_values,
        lr_identify        TYPE REF TO if_ish_identify_object,
        l_rval             TYPE i,
        l_rc               TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fv>  TYPE rnfield_value.

* Initializations.
  e_rc = 0.
  CLEAR er_xml_element.

  CHECK NOT it_fieldval     IS INITIAL.
  CHECK NOT ir_xml_document IS INITIAL.

* Create the root element for the field values.
  lr_fvroot_element =
    ir_xml_document->create_element( name = 'FIELD_VALUES' ).
  CHECK NOT lr_fvroot_element IS INITIAL.

* Process the field values.
  LOOP AT it_fieldval ASSIGNING <ls_fv>.

*   Create the field_value element.
    CALL METHOD ir_xml_document->create_element
      EXPORTING
        name = 'FIELD_VALUE'
      RECEIVING
        rval = lr_fv_element.
*   Set the name and type attributes of the field_value element.
    l_string = <ls_fv>-fieldname.
    l_rval = lr_fv_element->set_attribute(
        name  = 'NAME'
        value = l_string ).
    l_string = <ls_fv>-type.
    l_rval = lr_fv_element->set_attribute(
        name  = 'TYPE'
        value = l_string ).
*   Append the field_value element.
    l_rval = lr_fvroot_element->append_child( lr_fv_element ).

*   Processing depends on the fieldvalue type.
    CASE <ls_fv>-type.

*     Handle embedded screens.
      WHEN co_fvtype_screen.
        CHECK i_embedded_screens = on.
        CHECK NOT <ls_fv>-object IS INITIAL.
        lr_scr_embedded ?= <ls_fv>-object.
*       Get the embedded screen's xml_element.
        CALL METHOD get_screen_as_xml_element
          EXPORTING
            ir_screen          = lr_scr_embedded
            ir_xml_document    = ir_xml_document
            i_embedded_screens = i_embedded_screens
          IMPORTING
            er_xml_element     = lr_xml_element
            e_rc               = l_rc
          CHANGING
            cr_errorhandler    = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          CONTINUE.
        ENDIF.
        CHECK NOT lr_xml_element IS INITIAL.
*       Append the embedded xml_element.
        l_rval = lr_fv_element->append_child( lr_xml_element ).

*     Handle field values.
      WHEN co_fvtype_fv.
        CHECK NOT <ls_fv>-object IS INITIAL.
        lr_fv ?= <ls_fv>-object.
*       Get the embedded field values.
        CALL METHOD lr_fv->get_data
          IMPORTING
            et_field_values = lt_fv_embedded
            e_rc            = l_rc
          CHANGING
            c_errorhandler  = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          CONTINUE.
        ENDIF.
*       Get the xml_element for the embedded field values.
        CALL METHOD get_fieldvals_as_xml_element
          EXPORTING
            it_fieldval        = lt_fv_embedded
            ir_xml_document    = ir_xml_document
            i_embedded_screens = i_embedded_screens
          IMPORTING
            er_xml_element     = lr_xml_element
            e_rc               = l_rc
          CHANGING
            cr_errorhandler    = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          CONTINUE.
        ENDIF.
        CHECK NOT lr_xml_element IS INITIAL.
*       Append the embedded xml_element.
        l_rval = lr_fv_element->append_child( lr_xml_element ).

*     Handle identify objects.
      WHEN co_fvtype_identify.
        CHECK NOT <ls_fv>-object IS INITIAL.
        lr_identify ?= <ls_fv>-object.
*       Get the object's type.
        CALL METHOD lr_identify->get_type
          IMPORTING
            e_object_type = l_object_type.
*       Get the object's class_name.
        l_class_name = cl_ish_utl_rtti=>get_class_name( lr_identify ).
*       Create the identify_object element.
        CALL METHOD ir_xml_document->create_element
          EXPORTING
            name = 'IDENTIFY_OBJECT'
          RECEIVING
            rval = lr_xml_element.
        CHECK NOT lr_xml_element IS INITIAL.
*       Set the object_type and class_name attributes
*       of the field_value element.
        l_string = l_object_type.
        l_rval = lr_xml_element->set_attribute(
            name  = 'OBJECT_TYPE'
            value = l_string ).
        l_rval = lr_xml_element->set_attribute(
            name  = 'CLASS_NAME'
            value = l_class_name ).
*       Append the identify xml_element.
        l_rval = lr_fv_element->append_child( lr_xml_element ).

*     Handle single values.
      WHEN co_fvtype_single.
        CHECK NOT <ls_fv>-value IS INITIAL.
        CALL METHOD lr_fv_element->set_value
          EXPORTING
            value = <ls_fv>-value
          RECEIVING
            rval  = l_rval.
        CHECK l_rval = 0.

    ENDCASE.

  ENDLOOP.

* Export.
  er_xml_element = lr_fvroot_element.

ENDMETHOD.


METHOD get_origin_ucomm_for_scr_cntl .

* object references
  DATA: lr_scr_cntl       TYPE REF TO if_ish_scr_control.
* ---------- ---------- ------------
* check mandatory
  CHECK it_screen IS NOT INITIAL AND
        i_ucomm   IS NOT INITIAL.
* ---------- ---------- ------------
  rr_ucomm = i_ucomm.
* ---------- ---------- ------------
* find screen, which supports given user command
  lr_scr_cntl = cl_ish_utl_screen=>get_scr_control_for_ucomm(
                    it_screen = it_screen
                    i_ucomm   = i_ucomm ).
* ---------- ---------- ------------
  CHECK lr_scr_cntl IS BOUND.
* ---------- ---------- ------------
* get original user command
  rr_ucomm = lr_scr_cntl->get_original_ucomm( i_ucomm ).
* ---------- ---------- ------------

ENDMETHOD.


METHOD get_screen_as_xml_document.

  DATA: lr_ixml         TYPE REF TO if_ixml,
        lr_xml_element  TYPE REF TO if_ixml_element,
        l_rc            TYPE ish_method_rc.

* Initializations.
  e_rc = 0.
  CLEAR er_xml_document.

* Create the ixml instance.
  lr_ixml = ir_ixml.
  IF lr_ixml IS INITIAL.
    CLASS cl_ixml DEFINITION LOAD.
    lr_ixml = cl_ixml=>create( ).
  ENDIF.

* Create the document
  er_xml_document = lr_ixml->create_document( ).

* Get the screen as xml_element.
  CALL METHOD cl_ish_utl_screen=>get_screen_as_xml_element
    EXPORTING
      ir_screen          = ir_screen
      ir_xml_document    = er_xml_document
      i_embedded_screens = i_embedded_screens
    IMPORTING
      er_xml_element     = lr_xml_element
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Append the screen xml_element.
  er_xml_document->append_child( lr_xml_element ).

ENDMETHOD.


METHOD get_screen_as_xml_element .

  DATA: l_object_type      TYPE i,
        l_class_name       TYPE string,
        lr_header_element  TYPE REF TO if_ixml_element,
        lr_xml_element     TYPE REF TO if_ixml_element,
        l_string           TYPE string,
        lt_fv              TYPE ish_t_field_value,
        l_rval             TYPE i,
        l_rc               TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_fv>  TYPE rnfield_value.

* Initializations.
  e_rc = 0.
  CLEAR er_xml_element.

  CHECK NOT ir_screen       IS INITIAL.
  CHECK NOT ir_xml_document IS INITIAL.

* Get the screen's object_type.
  CALL METHOD ir_screen->get_type
    IMPORTING
      e_object_type = l_object_type.

* Get the screen's class_name.
  l_class_name = cl_ish_utl_rtti=>get_class_name( ir_screen ).

* Create the header element.
  lr_header_element = ir_xml_document->create_element(
                        name = 'SCREEN' ).
  CHECK NOT lr_header_element IS INITIAL.

* Set the header attributes.
  l_string = l_object_type.
  l_rval = lr_header_element->set_attribute(
             name  = 'OBJECT_TYPE'
             value = l_string ).
  l_rval = lr_header_element->set_attribute(
             name  = 'CLASS_NAME'
             value = l_class_name ).

* Get the field values.
  CALL METHOD ir_screen->get_fields
    IMPORTING
      et_field_values = lt_fv
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Get the field values as xml_element.
  CALL METHOD cl_ish_utl_screen=>get_fieldvals_as_xml_element
    EXPORTING
      it_fieldval        = lt_fv
      ir_xml_document    = ir_xml_document
      i_embedded_screens = i_embedded_screens
    IMPORTING
      er_xml_element     = lr_xml_element
      e_rc               = l_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Append the field_values element to the header element
  l_rval = lr_header_element->append_child( lr_xml_element ).

* Export.
  er_xml_element = lr_header_element.

ENDMETHOD.


METHOD get_screen_instances .

* local tables
  DATA: lt_values             TYPE ish_t_field_value,
        lt_screens            TYPE ish_t_screen_objects,
        lt_scr_coll           TYPE ish_t_screen_objects.
* workareas
  FIELD-SYMBOLS:
        <ls_val>              LIKE LINE OF lt_values.
* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        l_coll_impl           TYPE ish_on_off.
* object references
  DATA: lr_scr_values         TYPE REF TO cl_ish_field_values,
        lr_scr                TYPE REF TO if_ish_screen,
        lr_scr_coll           TYPE REF TO if_ish_screen_collapsible.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  CLEAR: et_screens, lt_screens.
* ---------- ---------- ----------
  lr_scr ?= i_screen.
  WHILE NOT lr_scr IS INITIAL.
*   ---------- ----------
*   set screen instance for return
    INSERT lr_scr INTO TABLE et_screens.
*   ---------- ----------
*   get instance of screen values
    CALL METHOD lr_scr->get_data
      IMPORTING
        e_screen_values = lr_scr_values.
*   ---------- ----------
*   if it's an collapsible screen get all
*   embedded screens
    IF i_embedded_scr = on.
*     ----------
*     Michael Manoch, 28.02.2005   START
*     Because of bad performance using the abap rtti classes
*     we do not use method is_interface_implemented.
      CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
        lr_scr_coll ?= lr_scr.
      ENDCATCH.
      IF sy-subrc = 0.
        lt_scr_coll =  lr_scr_coll->get_embedded_screens( ).
        APPEND LINES OF lt_scr_coll TO lt_screens.
      ENDIF.
**     is if_ish_screen_collapsible implemented?
*      CALL METHOD cl_ish_utl_base=>is_interface_implemented
*        EXPORTING
*          ir_object        = lr_scr
*          i_interface_name = 'IF_ISH_SCREEN_COLLAPSIBLE'
*        RECEIVING
*          r_is_implemented = l_coll_impl.
**     ----------
*      IF l_coll_impl = on.
*        lr_scr_coll ?= lr_scr.
*        lt_scr_coll =  lr_scr_coll->get_embedded_screens( ).
*        APPEND LINES OF lt_scr_coll TO lt_screens.
*      ENDIF.
*     ----------
*     Michael Manoch, 28.02.2005   END
    ENDIF.     " IF i_embedded_scr = on.
*   ---------- ----------
*   now get all screens of actual screen
    IF NOT lr_scr_values IS INITIAL.
      CLEAR: lt_values.
      CALL METHOD lr_scr_values->get_data
        EXPORTING
          i_type          = co_fvtype_screen
        IMPORTING
          et_field_values = lt_values
          e_rc            = l_rc
        CHANGING
          c_errorhandler  = c_errorhandler.
      IF l_rc = 0.
        LOOP AT lt_values ASSIGNING <ls_val>
          WHERE NOT object IS INITIAL.
          lr_scr ?= <ls_val>-object.
          INSERT lr_scr INTO TABLE lt_screens.
        ENDLOOP.
      ELSE.
        e_rc = l_rc.
        CONTINUE.
      ENDIF.
    ENDIF.  " if not lr_scr_values is initial.
*   ---------- ----------
*   remove duplicate entries and already checked screens
    SORT lt_screens.
    DELETE ADJACENT DUPLICATES FROM lt_screens.
    LOOP AT et_screens INTO lr_scr.
      DELETE lt_screens WHERE table_line = lr_scr.
    ENDLOOP.
*   ---------- ----------
    READ TABLE lt_screens INTO lr_scr INDEX 1.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
*   ---------- ----------
*   If only the next level is needed, finish the loop here
    IF i_only_next_level = on.
      EXIT.
    ENDIF.
  ENDWHILE.
* ---------- ---------- ----------
  IF i_only_next_level = on.
    APPEND LINES OF lt_screens TO et_screens.
  ENDIF.
ENDMETHOD.


METHOD get_scr_control_for_ucomm.

  DATA: lr_screen       TYPE REF TO if_ish_screen,
        lr_scr_control  TYPE REF TO if_ish_scr_control.

* Initializations.
  CLEAR rr_scr_control.

* Initial checking.
  CHECK NOT it_screen IS INITIAL.
  CHECK NOT i_ucomm   IS INITIAL.

* Get the corresponding control screen.
  LOOP AT it_screen INTO lr_screen.
    CHECK lr_screen IS BOUND.
    CHECK lr_screen->is_inherited_from(
            cl_ish_scr_control=>co_otype_scr_control ) = on.
    lr_scr_control ?= lr_screen.
    IF lr_scr_control->is_ucomm_supported( i_ucomm ) = on.
      rr_scr_control = lr_scr_control.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD get_special_screen .

* definitions
  DATA: l_rc              TYPE ish_method_rc.
* object references
  FIELD-SYMBOLS:
        <lr_screen>       TYPE REF TO if_ish_screen.
* ---------- ---------- ------------
* initialize
  e_rc = 0.
  CLEAR: er_screen.
* ---------- ---------- ------------
  LOOP AT it_screens ASSIGNING <lr_screen>.
    IF <lr_screen>->is_inherited_from( i_type ) = on.
      er_screen = <lr_screen>.
      EXIT.
    ENDIF.
  ENDLOOP.
* ---------- ---------- ------------

ENDMETHOD.


METHOD map_fv_to_str .

* local tables
  DATA: lt_ddfields         TYPE ddfields,
        lt_field_val        TYPE ish_t_field_value.
* workareas
  FIELD-SYMBOLS:
      <l_field>             TYPE ANY,
      <l_field_x>           TYPE ANY,
      <ls_data>             TYPE ANY,
      <ls_ddfield>          LIKE LINE OF lt_ddfields,
      <ls_field_val>        LIKE LINE OF it_field_values,
      <ls_map>              LIKE LINE OF it_fieldname_mapping.
* definitions
  DATA: l_fieldname         TYPE rnfield_value-fieldname,
        l_rc                TYPE ish_method_rc.
* references
  DATA: lr_data_tmp         TYPE REF TO data.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* set field value to local table
  lt_field_val = it_field_values.
* ----------
* work on temporary data
  CREATE DATA lr_data_tmp LIKE cs_data.
  ASSIGN lr_data_tmp->* TO <ls_data>.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* take care that you don't loose values
  <ls_data> = cs_data.
* ---------- ---------- ----------
* get ddic fields of given structure
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct
    EXPORTING
      is_data         = <ls_data>
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  IF NOT it_fieldname_mapping IS INITIAL.
    LOOP AT lt_field_val ASSIGNING <ls_field_val>.
*     ----------
*     check if there is a different fieldname
      READ TABLE it_fieldname_mapping ASSIGNING <ls_map>
         WITH KEY fieldname = <ls_field_val>-fieldname.
      IF sy-subrc = 0.
        ASSIGN COMPONENT <ls_map>-fieldname_x OF STRUCTURE <ls_data>
           TO <l_field>.
        IF sy-subrc = 0.
*         take into account the value type
          CASE <ls_field_val>-type.
            WHEN co_fvtype_identify.
              <l_field> ?= <ls_field_val>-object.
            WHEN co_fvtype_single.
              <l_field> = <ls_field_val>-value.
          ENDCASE.
        ELSE.
          CONTINUE.
        ENDIF.
*       set x-flag if necessary
        IF i_set_chg_flag = on.
          ASSIGN COMPONENT <ls_map>-fieldname_xx OF STRUCTURE <ls_data>
             TO <l_field_x>.
          IF sy-subrc = 0.
            <l_field_x> = on.
          ELSE.
            CONTINUE.
          ENDIF.
        ENDIF.
*       value was set, delete this entry of field value so that it won't
*       checked afterwards
        DELETE lt_field_val.
      ENDIF.
*     ----------
    ENDLOOP.
  ENDIF.
* ---------- ---------- ----------
* now set values for fields where fieldname isn't different
* loop at ddic-structure, because there you know exactly name of
* structure and name of field (this information you don't have in
* field values)
  LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
*   ----------
*   get complete name (structure + fieldname)
    CONCATENATE <ls_ddfield>-tabname <ls_ddfield>-fieldname
       INTO l_fieldname
       SEPARATED BY '-'.
*   ----------
*   find corresponding field in table field values
    READ TABLE lt_field_val ASSIGNING <ls_field_val>
       WITH KEY fieldname = l_fieldname.
    IF sy-subrc = 0.
*     change field in structure
      ASSIGN COMPONENT <ls_ddfield>-fieldname OF STRUCTURE <ls_data>
         TO <l_field>.
      IF sy-subrc = 0.
*       take into account the value type
        CASE <ls_field_val>-type.
          WHEN co_fvtype_identify.
            <l_field> ?= <ls_field_val>-object.
          WHEN co_fvtype_single.
            <l_field> = <ls_field_val>-value.
        ENDCASE.
      ELSE.
        CONTINUE.
      ENDIF.
*     set x-flag if necessary
      IF i_set_chg_flag = on.
        CONCATENATE <ls_ddfield>-fieldname '_X' INTO l_fieldname.
        ASSIGN COMPONENT l_fieldname OF STRUCTURE <ls_data>
          TO <l_field_x>.
        IF sy-subrc = 0.
          <l_field_x> = on.
        ELSE.
          CONTINUE.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDLOOP.
* ---------- ---------- ----------
* return values if everything is ok
  IF e_rc = 0.
    cs_data = <ls_data>.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD map_str_to_fv .

* local tables
  DATA: lt_ddfields         TYPE ddfields,
        lt_field_val        TYPE ish_t_field_value,
        lt_screen           TYPE TABLE OF screen.
* workareas
  FIELD-SYMBOLS:
        <l_field>           TYPE ANY,
        <ls_ddfield>        LIKE LINE OF lt_ddfields,
        <ls_map>            LIKE LINE OF it_fieldname_mapping.
  DATA: ls_field_val        LIKE LINE OF lt_field_val,
        ls_screen           LIKE LINE OF lt_screen.
* definitions
  DATA: "l_fieldname         TYPE rnfield_value-fieldname,
        l_rc                TYPE ish_method_rc,
        l_index             TYPE i,
        l_tabname           TYPE dfies-tabname,
        l_fieldname         TYPE dfies-fieldname.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* work on temporary data
  lt_field_val = ct_field_values.
* ---------- ---------- ----------
* remember all screen fields, which are not inputable
* important because at pai not inputable fields get
* not transported from dynpro processor
  LOOP AT SCREEN.
    IF screen-input = false.
      ls_screen = screen.
      INSERT ls_screen INTO TABLE lt_screen.
    ENDIF.
  ENDLOOP.
* ---------- ---------- ----------
* get ddic fields of given structure
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct
    EXPORTING
      is_data         = is_data
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  LOOP AT lt_field_val INTO ls_field_val.
*   ----------
*   ignore, fields which are not inputable
    READ TABLE lt_screen TRANSPORTING NO FIELDS
       WITH KEY name = ls_field_val-fieldname.
    IF sy-subrc = 0.
      CONTINUE.
    ENDIF.
*   ----------
*   check if there is a different fieldname
    READ TABLE it_fieldname_mapping ASSIGNING <ls_map>
       WITH KEY fieldname = ls_field_val-fieldname.
    IF sy-subrc = 0.
*     field mapping
      ASSIGN COMPONENT <ls_map>-fieldname_x OF STRUCTURE is_data
         TO <l_field>.
      IF sy-subrc = 0.
*       take into account the value type
        CASE ls_field_val-type.
          WHEN co_fvtype_identify.
            ls_field_val-object ?= <l_field>.
          WHEN co_fvtype_single.
            ls_field_val-value = <l_field>.
        ENDCASE.
        MODIFY lt_field_val FROM ls_field_val.
      ELSE.
        CONTINUE.
      ENDIF.
    ELSE.
*     no field mapping
      SPLIT ls_field_val-fieldname AT '-'
         INTO l_tabname l_fieldname.
*     change field in structure
      ASSIGN COMPONENT l_fieldname OF STRUCTURE is_data
         TO <l_field>.
      IF sy-subrc = 0.
*       take into account the value type
        CASE ls_field_val-type.
          WHEN co_fvtype_identify.
            ls_field_val-object ?= <l_field>.
          WHEN co_fvtype_single.
            ls_field_val-value = <l_field>.
        ENDCASE.
        MODIFY lt_field_val FROM ls_field_val.
      ELSE.
        CONTINUE.
      ENDIF.
    ENDIF.
*   ----------
  ENDLOOP.
* ---------- ---------- ----------
* return values if everything is ok
  IF e_rc = 0.
    ct_field_values = lt_field_val.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD set_fieldvals_by_xml_document.

  DATA: lr_root_element  TYPE REF TO if_ixml_element.

* Initializations.
  e_rc = 0.

  CHECK NOT ir_screen       IS INITIAL.
  CHECK NOT ir_xml_document IS INITIAL.

* Get the root element.
  lr_root_element = ir_xml_document->get_root_element( ).
  CHECK NOT lr_root_element IS INITIAL.

* Set fieldvals by xml_element.
  CALL METHOD set_fieldvals_by_xml_element
    EXPORTING
      ir_screen       = ir_screen
      ir_xml_element  = lr_root_element
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD set_fieldvals_by_xml_element .

  DATA: lr_node_collection   TYPE REF TO if_ixml_node_collection,
        l_object_type        TYPE i,
        l_class_name         TYPE string,
        l_string             TYPE string,
        l_nodes              TYPE i,
        lr_fvs_node          TYPE REF TO if_ixml_node,
        lr_node              TYPE REF TO if_ixml_node.
  DATA: lr_fv                TYPE REF TO cl_ish_field_values.
* Initializations.
  e_rc = 0.

  CHECK NOT ir_screen       IS INITIAL.
  CHECK NOT ir_xml_element  IS INITIAL.

* ir_xml_element has to be a SCREEN node.
  CHECK ir_xml_element->get_name( ) = 'SCREEN'.

* Get the screen's object_type.
  CALL METHOD ir_screen->get_type
    IMPORTING
      e_object_type = l_object_type.
  CHECK NOT l_object_type IS INITIAL.

* Get the screen's class_name.
  l_class_name = cl_ish_utl_rtti=>get_class_name( ir_screen ).
  CHECK NOT l_class_name IS INITIAL.

* The given ir_xml_element has to be our screen.
  CALL METHOD ir_xml_element->get_attribute
    EXPORTING
      name = 'CLASS_NAME'
    RECEIVING
      rval = l_string.
  CHECK l_string = l_class_name.
  CALL METHOD ir_xml_element->get_attribute
    EXPORTING
      name = 'OBJECT_TYPE'
    RECEIVING
      rval = l_string.
  CHECK l_string = l_object_type.

* Get the field_values node.
  CALL METHOD ir_xml_element->get_elements_by_tag_name
    EXPORTING
      depth = 1
      name  = 'FIELD_VALUES'
    RECEIVING
      rval  = lr_node_collection.
  CHECK NOT lr_node_collection IS INITIAL.
  l_nodes = lr_node_collection->get_length( ).
  CHECK l_nodes > 0.
  lr_fvs_node = lr_node_collection->get_item( 0 ).
  CHECK NOT lr_fvs_node IS INITIAL.

* Get ir_screen's screen_values object.
  CALL METHOD ir_screen->get_data
    IMPORTING
      e_screen_values = lr_fv.
  CHECK NOT lr_fv IS INITIAL.

* Further processing for the screen_values object.
  CALL METHOD set_fv_by_xml_node
    EXPORTING
      ir_fieldval     = lr_fv
      ir_xml_node     = lr_fvs_node
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD set_fv_by_xml_node .

  DATA: lr_node_list         TYPE REF TO if_ixml_node_list,
        l_nodes              TYPE i,
        l_idx                TYPE i,
        lr_attributes        TYPE REF TO if_ixml_named_node_map,
        lr_attr_node         TYPE REF TO if_ixml_node,
        lr_node              TYPE REF TO if_ixml_node,
        lr_fvs_node          TYPE REF TO if_ixml_node,
        ls_fv                TYPE rnfield_value.

  DATA: lt_fv                TYPE ish_t_field_value.
  DATA: ls_fv2               TYPE rnfield_value,
        lr_fv2               TYPE REF TO cl_ish_field_values,
        lr_screen            TYPE REF TO if_ish_screen.
  DATA: lr_first_child       TYPE REF TO if_ixml_node,
        lr_xml_element       TYPE REF TO if_ixml_element.

* Initializations.
  e_rc = 0.

  CHECK NOT ir_fieldval IS INITIAL.
  CHECK NOT ir_xml_node IS INITIAL.

* Check ir_xml_node.
* It has to be a FIELD_VALUES node.
  CHECK ir_xml_node->get_name( ) = 'FIELD_VALUES'.

* Get the FIELD_VALUE nodes under ir_xml_node.
  lr_node_list = ir_xml_node->get_children( ).
  l_nodes = lr_node_list->get_length( ).
  CHECK l_nodes > 0.

* Now process each FIELD_VALUE node.
  l_idx = -1.
  DO l_nodes TIMES.

    CLEAR ls_fv.
    l_idx = l_idx + 1.

*   Get the FIELD_VALUE node
    lr_node = lr_node_list->get_item( l_idx ).
    CHECK NOT lr_node IS INITIAL.
    CHECK lr_node->get_name( ) = 'FIELD_VALUE'.

*   Get the type and name attributes
*   (= type and fieldname of ls_fv).
    lr_attributes = lr_node->get_attributes( ).
    CHECK NOT lr_attributes IS INITIAL.
    CALL METHOD lr_attributes->get_named_item
      EXPORTING
        name = 'TYPE'
      RECEIVING
        rval = lr_attr_node.
    CHECK NOT lr_attr_node IS INITIAL.
    ls_fv-type = lr_attr_node->get_value( ).
    CALL METHOD lr_attributes->get_named_item
      EXPORTING
        name = 'NAME'
      RECEIVING
        rval = lr_attr_node.
    CHECK NOT lr_attr_node IS INITIAL.
    ls_fv-fieldname = lr_attr_node->get_value( ).
    CHECK NOT ls_fv-fieldname IS INITIAL.

*   Now process the FIELD_VALUE node depending on it's type.
    CASE ls_fv-type.

*     Single value.
      WHEN co_fvtype_single.

*       Just set ls_fv-value from the FIELD_VALUE node.
        ls_fv-value = lr_node->get_value( ).

*     FieldValue
      WHEN co_fvtype_fv.

*       Get the field_values object.
        CALL METHOD ir_fieldval->get_data
          EXPORTING
            i_fieldname    = ls_fv-fieldname
            i_type         = co_fvtype_fv
          IMPORTING
            e_field_value  = ls_fv2
            e_rc           = e_rc
          CHANGING
            c_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.

*       If it does not already exist we create a new one.
        IF ls_fv2-object IS INITIAL.
          CALL METHOD cl_ish_field_values=>create
            IMPORTING
              e_instance     = lr_fv2
              e_rc           = e_rc
            CHANGING
              c_errorhandler = cr_errorhandler.
          CHECK e_rc = 0.
          ls_fv2-object = lr_fv2.
        ENDIF.
        lr_fv2 ?= ls_fv2-object.
        CHECK NOT lr_fv2 IS INITIAL.

*       Get the FIELD_VALUES node under the actual FIELD_VALUE node.
        lr_first_child = lr_node->get_first_child( ).
        CHECK NOT lr_first_child IS INITIAL.
        CHECK lr_first_child->get_name( ) = 'FIELD_VALUES'.

*       Now process the embedded FIELD_VALUES node.
        CALL METHOD set_fv_by_xml_node
          EXPORTING
            ir_fieldval     = lr_fv2
            ir_xml_node     = lr_first_child
          IMPORTING
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.

        ls_fv-object = lr_fv2.

*     Object reference.
      WHEN co_fvtype_identify.
*       Object references can not be handled here.
        CONTINUE.

*     Embedded screen.
      WHEN co_fvtype_screen.

*       Get the screen object.
*       If it does not already exist we do not handle it.
        CALL METHOD ir_fieldval->get_data
          EXPORTING
            i_fieldname    = ls_fv-fieldname
            i_type         = co_fvtype_screen
          IMPORTING
            e_field_value  = ls_fv2
            e_rc           = e_rc
          CHANGING
            c_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
        CHECK NOT ls_fv2-object IS INITIAL.
        lr_screen ?= ls_fv2-object.

*       Get the SCREEN node under the actual FIELD_VALUE node.
        lr_first_child = lr_node->get_first_child( ).
        CHECK NOT lr_first_child IS INITIAL.
        CHECK lr_first_child->get_name( ) = 'SCREEN'.
        lr_xml_element ?= lr_first_child.

*       Now process the embedded SCREEN element.
        CALL METHOD cl_ish_utl_screen=>set_fieldvals_by_xml_element
          EXPORTING
            ir_screen       = lr_screen
            ir_xml_element  = lr_xml_element
          IMPORTING
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.

        ls_fv-object = lr_screen.

    ENDCASE.

*   Build lt_fv (the fieldvals to set).
    APPEND ls_fv TO lt_fv.

  ENDDO.

* Set the fieldvals.
  CALL METHOD ir_fieldval->set_data
    EXPORTING
      it_field_values = lt_fv
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.

ENDMETHOD.
ENDCLASS.
