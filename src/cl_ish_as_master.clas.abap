class CL_ISH_AS_MASTER definition
  public
  final
  create protected .

*"* public components of class CL_ISH_AS_MASTER
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_AS_MASTER type ISH_OBJECT_TYPE value 12030. "#EC NOTEXT

  class-methods CREATE
    returning
      value(RR_MASTER) type ref to CL_ISH_AS_MASTER .
  methods CHECK
    importing
      !I_CHECK_LOCKS type ISH_ON_OFF default ON
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DESTROY .
  methods GET_PARAM
    importing
      !I_PARAMID type N1ASPARAMID
    returning
      value(RR_PARAM) type ref to CL_ISH_ASM_PARAM
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_VALUE_C
    importing
      !I_PARAMID type N1ASPARAMID
      !I_MANDT type MANDT default SY-MANDT
    returning
      value(R_VALUE) type N1ASVALUE .
  methods IS_CHANGED
    returning
      value(R_CHANGED) type ISH_ON_OFF .
  methods LOCK_PARAM
    importing
      !I_PARAMID type N1ASPARAMID
    raising
      CX_ISH_STATIC_HANDLER .
  methods PROCESS_AFTER_COMMIT
    raising
      CX_ISH_STATIC_HANDLER .
  methods SAVE
    importing
      !I_COMMIT type ISH_ON_OFF default OFF
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_VALUE_C
    importing
      !I_PARAMID type N1ASPARAMID
      !I_VALUE type ANY
      !I_MANDT type MANDT default SY-MANDT .
protected section.
*"* protected components of class CL_ISH_AS_MASTER
*"* do not include other source files here!!!

  data GR_LOADER type ref to CL_ISH_AS_LOADER .
  data GT_PARAM type ISH_T_ASM_PARAM_HASH .

  methods INITIALIZE .
  methods _PROCESS_AFTER_COMMIT
    importing
      !I_CHECK_CHANGES type ISH_ON_OFF default ON
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_AS_MASTER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_AS_MASTER IMPLEMENTATION.


METHOD check.

  DATA: l_paramid  TYPE n1asparamid,
        l_rc       TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_param>  LIKE LINE OF gt_param.

* Check all params.
  LOOP AT gt_param ASSIGNING <ls_param>.
*   Check only changed params.
    CHECK <ls_param>-r_param->is_changed( ) = on.
*   Check locks.
    IF i_check_locks = on AND
       <ls_param>-r_param->is_locked( ) = off.
      e_rc = 1.
      l_paramid = <ls_param>-r_param->get_paramid( ).
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '097'
          i_mv1           = l_paramid
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
*   Check the param.
    CALL METHOD <ls_param>-r_param->check
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc > e_rc.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD create.

  CREATE OBJECT rr_master.

  rr_master->initialize( ).

ENDMETHOD.


METHOD destroy.

  FIELD-SYMBOLS: <ls_param>  LIKE LINE OF gt_param.

* Destroy the params.
  LOOP AT gt_param ASSIGNING <ls_param>.
    <ls_param>-r_param->destroy( ).
  ENDLOOP.

* Destroy the loader.
  IF gr_loader IS BOUND.
    gr_loader->destroy( ).
  ENDIF.

  CLEAR: gr_loader,
         gt_param.

ENDMETHOD.


METHOD get_param.

  DATA: lr_as_param  TYPE REF TO cl_ish_as_param,
        ls_param     LIKE LINE OF gt_param.

  FIELD-SYMBOLS: <ls_param>  LIKE LINE OF gt_param.

* If the param is already loaded -> return it.
  READ TABLE gt_param
    WITH TABLE KEY paramid = i_paramid
    ASSIGNING <ls_param>.
  IF sy-subrc = 0.
    rr_param = <ls_param>-r_param.
    EXIT.
  ENDIF.

* The param is not already loaded.

* Let the as_param create the param object.
  lr_as_param = gr_loader->get_param( i_paramid ).
  CHECK lr_as_param IS BOUND.
  ls_param-r_param = lr_as_param->create_asm_param( ).
  CHECK ls_param-r_param IS BOUND.

* Initialize the param.
  ls_param-r_param->initialize( ).

* Collect the param.
  ls_param-paramid = i_paramid.
  INSERT ls_param INTO TABLE gt_param.

* Export.
  rr_param = ls_param-r_param.

ENDMETHOD.


METHOD get_value_c.

  DATA: lr_param  TYPE REF TO cl_ish_asm_param_c.

* Get the param.
  TRY.
      lr_param ?= get_param( i_paramid ).
    CATCH cx_ish_static_handler
          cx_sy_move_cast_error.
  ENDTRY.
  IF lr_param IS NOT BOUND.
    MESSAGE x056(n1base).
  ENDIF.

* Get the value.
  r_value = lr_param->get_value( i_mandt ).

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_as_master.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_type  TYPE ish_object_type.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_type.

  IF i_object_type = l_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_as_master.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD initialize.

  CREATE OBJECT gr_loader.
  gr_loader->initialize( ).

ENDMETHOD.


METHOD is_changed.

  FIELD-SYMBOLS: <ls_param>  LIKE LINE OF gt_param.

  LOOP AT gt_param ASSIGNING <ls_param>.
    r_changed = <ls_param>-r_param->is_changed( ).
    IF r_changed = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD lock_param.

  DATA: lr_param  TYPE REF TO cl_ish_asm_param.

  lr_param = get_param( i_paramid ).
  CHECK lr_param IS BOUND.

  lr_param->lock( ).

ENDMETHOD.


METHOD process_after_commit.

  _process_after_commit( on ).

ENDMETHOD.


METHOD save.

  DATA: l_rc              TYPE ish_method_rc,
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.

  FIELD-SYMBOLS: <ls_param>  LIKE LINE OF gt_param.

* Process only on changes.
  CHECK is_changed( ) = on.

* Check.
  CALL METHOD check
    EXPORTING
      i_check_locks   = on
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.
  IF l_rc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

* Save.
  LOOP AT gt_param ASSIGNING <ls_param>.
    <ls_param>-r_param->save( ).
  ENDLOOP.

* Check for further processing.
  CHECK i_commit = on.

* Commit.
  COMMIT WORK AND WAIT.
  IF sy-subrc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '057'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

* Process after commit.
  _process_after_commit( off ).

ENDMETHOD.


METHOD set_value_c.

  DATA: lr_param  TYPE REF TO cl_ish_asm_param_c,
        l_value   TYPE n1asvalue.

* Get the param.
  TRY.
      lr_param ?= get_param( i_paramid ).
    CATCH cx_ish_static_handler
          cx_sy_move_cast_error.
  ENDTRY.
  IF lr_param IS NOT BOUND.
    MESSAGE x056(n1base).
  ENDIF.

* Set the value.
  l_value = i_value.
  lr_param->set_value( i_value = l_value
                       i_mandt = i_mandt ).

ENDMETHOD.


METHOD _process_after_commit.

  DATA: l_changed  TYPE ish_on_off,
        lr_except  TYPE REF TO cx_root.

* Determine if there were any changes.
  IF i_check_changes = on.
    l_changed = is_changed( ).
  ELSE.
    l_changed = on.
  ENDIF.

* Destroy self.
  destroy( ).

* Invalidate the shared area.
  IF l_changed = on.
    TRY.
        cl_ish_sha_applsettings=>invalidate_area( ).
      CATCH cx_shm_parameter_error INTO lr_except.
        RAISE EXCEPTION TYPE cx_ish_static_handler
          EXPORTING
            previous = lr_except.
    ENDTRY.
  ENDIF.

ENDMETHOD.
ENDCLASS.
