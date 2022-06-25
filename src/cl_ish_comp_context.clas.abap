class CL_ISH_COMP_CONTEXT definition
  public
  inheriting from CL_ISH_COMPONENT_STD
  create public .

*"* public components of class CL_ISH_COMP_CONTEXT
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_COMP_CONTEXT type ISH_OBJECT_TYPE value 8009. "#EC NOTEXT

  methods GET_CORDER
    returning
      value(RR_CORDER) type ref to CL_ISH_CORDER .
  methods CONSTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .

  methods IF_ISH_COMPONENT_BASE~SAVE
    redefinition .
  methods IF_ISH_COMPONENT~CANCEL
    redefinition .
  methods IF_ISH_COMPONENT~CONFIGURE
    redefinition .
  methods IF_ISH_COMPONENT~GET_T_RUN_DATA
    redefinition .
  methods IF_ISH_COMPONENT~HAS_CONFIGURATION
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMP_CONTEXT
*"* do not include other source files here!!!

  class-data GT_CDOC_FIELD type ISH_T_CDOC_FIELD .
  class-data GT_PRINT_FIELD type ISH_T_PRINT_FIELD .

  methods TRANS_CORDER_FROM_SCR_CONTEXT
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IR_SCR_CONTEXT type ref to CL_ISH_SCR_CONTEXT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_CORDER_TO_SCR_CONTEXT
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IR_SCR_CONTEXT type ref to CL_ISH_SCR_CONTEXT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_FROM_SCR_CONTEXT
    importing
      !IR_SCR_CONTEXT type ref to CL_ISH_SCR_CONTEXT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_TO_SCR_CONTEXT
    importing
      !IR_SCR_CONTEXT type ref to CL_ISH_SCR_CONTEXT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods COPY_DATA_INTERNAL
    redefinition .
  methods INITIALIZE_METHODS
    redefinition .
  methods INITIALIZE_SCREENS
    redefinition .
  methods TRANSPORT_FROM_SCREEN_INTERNAL
    redefinition .
  methods TRANSPORT_TO_SCREEN_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_COMP_CONTEXT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMP_CONTEXT IMPLEMENTATION.


METHOD class_constructor .

  DATA: l_cdoc_field  TYPE rn1_cdoc_field,
        l_print_field TYPE rn1_print_field,
        l_fieldname   TYPE string,
        lt_fieldname  TYPE ish_t_string.

  CLEAR: gt_cdoc_field[],
         gt_print_field[].


* Build table for cdoc.

* NCTO
  CLEAR: l_cdoc_field,
         lt_fieldname[].
  l_cdoc_field-objecttype  = cl_ish_context=>co_otype_context.
  l_cdoc_field-tabname     = 'NCTO'.

*  l_fieldname              = 'TPAE'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.


* Build table for print.

* NCTO
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  = cl_ish_context=>co_otype_context.
  l_print_field-tabname     = 'NCTO'.

*  l_fieldname              = 'TPAE'.
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


METHOD copy_data_internal.

* don't copy contexts!!
*  DATA: lt_run_data         TYPE ish_t_objectbase,
*        lr_corder_new       TYPE REF TO cl_ish_corder,
*        l_rc                TYPE ish_method_rc,
*        lr_object           TYPE REF TO if_ish_objectbase,
*        ls_object           TYPE ish_object,
*        lt_con_obj          TYPE ish_objectlist,
*        lr_context          TYPE REF TO cl_ish_context,
*        lr_context_new      TYPE REF TO cl_ish_context,
*        lt_objects          TYPE ish_objectlist,
*        lr_comp_context_o   TYPE REF TO cl_ish_comp_context,
*        ls_nctx             TYPE nctx,
*        l_active            TYPE ish_on_off.
*
*  e_rc = 0.
*
** first call get_t_run_data from original component
*  CALL METHOD ir_component_from->get_t_run_data
*    IMPORTING
*      et_run_data     = lt_run_data
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*  lr_comp_context_o ?= ir_component_from.
*
** fill lt_con_obj with corder
*  lr_corder_new ?= gr_main_object.
*  ls_object-object ?= gr_main_object.
*  APPEND ls_object TO lt_con_obj.
*
** get contexts
*  LOOP AT lt_run_data INTO lr_object.
*    IF lr_object->is_inherited_from(
*           co_otype_context ) = on.
*      lr_context ?= lr_object.
***     get objects from context
**      CALL METHOD cl_ish_context=>get_objects_for_context
**        EXPORTING
**         i_context                   = lr_context
**         i_environment               =
**lr_comp_context_o->gr_environment
**        IMPORTING
**         e_rc                        = l_rc
**         et_objects                  = lt_objects
***         ET_CONTEXT_OBJECT_RELATIONS =
***         ET_CONTEXT_TRIGGER          =
**        CHANGING
**         c_errorhandler              = cr_errorhandler.
**     get data from context
*      CALL METHOD lr_context->get_data
*        IMPORTING
*          e_rc           = l_rc
*          e_nctx         = ls_nctx
*          e_active       = l_active
*        CHANGING
*          c_errorhandler = cr_errorhandler.
*      IF l_rc <> 0.
*        e_rc = l_rc.
*        EXIT.
*      ENDIF.
**     check if context is active
*      CHECK l_active = on.
**     do not copy cancelled contexts
*      CHECK ls_nctx-storn = off.
**     clear some fields
*      CLEAR: ls_nctx-cxid.
**     create new context
*      CALL METHOD cl_ish_context=>create
*        EXPORTING
*          i_nctx               = ls_nctx
*          i_environment        = gr_environment
*          it_connected_objects = lt_con_obj
*        IMPORTING
*          e_instance           = lr_context_new
*          e_rc                 = l_rc
*        CHANGING
*          c_errorhandler       = cr_errorhandler.
*      IF l_rc <> 0.
*        e_rc = l_rc.
*        EXIT.
*      ENDIF.
*    ENDIF.
*  ENDLOOP.

ENDMETHOD.


METHOD get_corder .

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.

  rr_corder ?= gr_main_object.

ENDMETHOD.


METHOD if_ish_component_base~save.

* Käfer, ID: 17836
* the context-objects have to be saved here too, because ohterwise
* in memory allready cancelled context will not be saved during normal
* saving of the clinical order.
  DATA: lr_corder          TYPE REF TO cl_ish_corder,
        lt_context         TYPE ish_objectlist,
        ls_object          TYPE ish_object,
        lr_context         TYPE REF TO cl_ish_context,
        lr_identify_object TYPE REF TO if_ish_identify_object,
        l_rc               TYPE ish_method_rc.

  lr_corder = get_corder( ).

  CHECK NOT lr_corder IS INITIAL.

  REFRESH lt_context.

* read all context objects - allready cancelled one too
  CALL METHOD cl_ish_corder=>get_context_for_corder
    EXPORTING
      ir_corder         = lr_corder
      ir_environment    = gr_environment
      i_cancelled_datas = on
    IMPORTING
      et_context        = lt_context
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.

  CHECK e_rc = 0.
  LOOP AT lt_context INTO ls_object.
    CHECK NOT ls_object-object IS INITIAL.
    lr_identify_object ?= ls_object-object.
    IF lr_identify_object->is_inherited_from(
      cl_ish_context=>co_otype_context ) = on.
      lr_context ?= lr_identify_object.
      CALL METHOD lr_context->save
        EXPORTING
          i_testrun      = i_testrun
          i_tcode        = i_tcode
        IMPORTING
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_component~cancel.

* Käfer, ID: 17836 - Begin
  DATA: lt_run_data TYPE ish_t_objectbase,
        lr_run_data TYPE REF TO if_ish_objectbase,
        lr_context  TYPE REF TO cl_ish_context,
        l_rc        TYPE ish_method_rc,
        lr_corder   TYPE REF TO cl_ish_corder.
* Käfer, ID: 17836 - End

* Michael Manoch, 09.07.2004, ID 14907
* Just redefine this method and only call super method
* to allow further changes without having to redfine.

  CALL METHOD super->if_ish_component~cancel
    EXPORTING
      i_authority_check = i_authority_check
      i_check_only      = i_check_only
      i_vma             = i_vma
      i_reason          = i_reason
    IMPORTING
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.

* Käfer, ID: 17836 - Begin
* cancel all context-objects which are connected
* to the clinical order
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

  REFRESH lt_run_data.
  CALL METHOD me->get_t_run_data
    IMPORTING
      et_run_data     = lt_run_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  LOOP AT lt_run_data INTO lr_run_data.
    CHECK NOT lr_run_data IS INITIAL.
    IF lr_run_data->is_inherited_from(
      cl_ish_context=>co_otype_context ) = on.
      lr_context ?= lr_run_data.
      CALL METHOD lr_context->cancel
        EXPORTING
          i_check_only   = i_check_only
          i_vma          = i_vma
          i_reason       = i_reason
        IMPORTING
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
    ENDIF.
  ENDLOOP.
  IF e_rc = 0.
    IF i_check_only = off.
      CALL FUNCTION 'ISHMED_REMOVE_OBJ_FROM_CONTEXT'
        EXPORTING
          i_object       = lr_corder
        IMPORTING
          e_rc           = e_rc
        CHANGING
          c_errorhandler = cr_errorhandler.

    ENDIF.
  ENDIF.
* Käfer, ID: 17836 - End

ENDMETHOD.


METHOD if_ish_component~configure .

* Init.
  e_rc = 0.

  CALL FUNCTION 'ISH_CONTEXT_DISPLAY'.

ENDMETHOD.


METHOD if_ish_component~get_t_run_data .

  DATA: lr_corder      TYPE REF TO cl_ish_corder,
        lt_context     TYPE ish_objectlist,
        lr_run_data    TYPE REF TO if_ish_objectbase,
        lt_screens     TYPE ish_t_screen_objects, "ED, ID 14727
        lr_screen      TYPE REF TO if_ish_screen, "ED, ID 14727
        lr_scr_context TYPE REF TO cl_ish_scr_context. "ED, ID 14727

  FIELD-SYMBOLS: <ls_context>  TYPE ish_object.

* Get super objects.
  CALL METHOD super->if_ish_component~get_t_run_data
    EXPORTING
      i_use_only_memory = i_use_only_memory
    IMPORTING
      et_run_data       = et_run_data
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* ED, ID 14727: init the context -> BEGIN
* first get the screen
  CALL METHOD me->get_defined_screens
    RECEIVING
      rt_screen_objects = lt_screens.
  READ TABLE lt_screens INTO lr_screen INDEX 1.
  lr_scr_context ?= lr_screen.
  IF NOT lr_scr_context IS INITIAL.
    CALL METHOD lr_scr_context->init_context
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.
* ED, ID 14727 -> END

* Get context objects.
  CALL METHOD cl_ish_corder=>get_context_for_corder
    EXPORTING
      ir_corder       = lr_corder
      ir_environment  = gr_environment
    IMPORTING
      et_context      = lt_context
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

* Add context objects.
  LOOP AT lt_context ASSIGNING <ls_context>.
    CHECK NOT <ls_context>-object IS INITIAL.
    lr_run_data ?= <ls_context>-object.
    APPEND lr_run_data TO et_run_data.
  ENDLOOP.

* Delete duplicates.
  SORT et_run_data.
  DELETE ADJACENT DUPLICATES FROM et_run_data.

ENDMETHOD.


METHOD if_ish_component~has_configuration .

  r_has_config = on.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_comp_context.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_comp_context.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD initialize_methods .

* initialize methods

ENDMETHOD.


METHOD initialize_screens.

  DATA: lr_scr_context  TYPE REF TO cl_ish_scr_context.

* screen admission
  CALL METHOD cl_ish_scr_context=>create
    IMPORTING
      er_instance     = lr_scr_context
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* Save all used screen object in gt_screen_objects.
  APPEND lr_scr_context TO gt_screen_objects.

ENDMETHOD.


METHOD transport_from_screen_internal.

  DATA: lr_scr_context  TYPE REF TO cl_ish_scr_context.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_context=>co_otype_scr_context ) = on.
    lr_scr_context ?= ir_screen.
    CALL METHOD trans_from_scr_context
      EXPORTING
        ir_scr_context  = lr_scr_context
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD transport_to_screen_internal.

  DATA: lr_scr_context  TYPE REF TO cl_ish_scr_context.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_context=>co_otype_scr_context ) = on.
    lr_scr_context ?= ir_screen.
    CALL METHOD trans_to_scr_context
      EXPORTING
        ir_scr_context  = lr_scr_context
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


method TRANS_CORDER_FROM_SCR_CONTEXT .
endmethod.


METHOD trans_corder_to_scr_context .

  DATA: ls_n1corder           TYPE n1corder,
        ls_field_val          TYPE rnfield_value,
        lt_field_val          TYPE ish_t_field_value.

  CHECK NOT ir_corder      IS INITIAL.
  CHECK NOT ir_scr_context IS INITIAL.

* Get corder data.
  CALL METHOD ir_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

** Get pap.
*  CALL METHOD ir_corder->get_patient_provisional
*    IMPORTING
*      er_patient_provisional = lr_pap
*      e_rc                   = e_rc
*    CHANGING
*      cr_errorhandler        = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Build field values.
*  CLEAR: lt_field_val,
*         ls_field_val.
*  ls_field_val-fieldname = cl_ish_scr_patient=>co_fieldname_patnr.
*  ls_field_val-type      = co_fvtype_single.
*  ls_field_val-value     = ls_n1corder-patnr.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  ls_field_val-fieldname = cl_ish_scr_patient=>co_fieldname_pap.
*  ls_field_val-type      = co_fvtype_identify.
*  ls_field_val-object    = lr_pap.
*  INSERT ls_field_val INTO TABLE lt_field_val.

* Set main object in context screen.
  CALL METHOD ir_scr_context->set_data
    EXPORTING
      i_main_object   = ir_corder
      i_main_object_x = on
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

** Set field values in context screen.
*  CALL METHOD ir_scr_patient->set_fields
*    EXPORTING
*      it_field_values  = lt_field_val
*      i_field_values_x = on
*    IMPORTING
*      e_rc             = e_rc
*    CHANGING
*      c_errorhandler   = cr_errorhandler.
*  CHECK e_rc = 0.

ENDMETHOD.


METHOD trans_from_scr_context .

  DATA: lr_corder  TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object  IS INITIAL.
  CHECK NOT ir_scr_context  IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD trans_corder_from_scr_context
      EXPORTING
        ir_corder       = lr_corder
        ir_scr_context  = ir_scr_context
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_to_scr_context .

  DATA: lr_corder  TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object  IS INITIAL.
  CHECK NOT ir_scr_context  IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD trans_corder_to_scr_context
      EXPORTING
        ir_corder       = lr_corder
        ir_scr_context  = ir_scr_context
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.
ENDCLASS.
