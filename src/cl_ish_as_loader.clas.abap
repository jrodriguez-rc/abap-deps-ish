class CL_ISH_AS_LOADER definition
  public
  final
  create protected
  shared memory enabled

  global friends CL_ISH_APPLSETTINGS
                 CL_ISH_AS_MASTER .

*"* public components of class CL_ISH_AS_LOADER
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_SHM_BUILD_INSTANCE .

  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .

  methods GET_PARAM
    importing
      !I_PARAMID type N1ASPARAMID
    returning
      value(RR_PARAM) type ref to CL_ISH_AS_PARAM .
protected section.
*"* protected components of class CL_ISH_AS_LOADER
*"* do not include other source files here!!!

  data GT_PARAM type ISH_T_AS_PARAM_HASH .

  methods DESTROY .
  methods INITIALIZE
    importing
      !IR_AREA type ref to CL_ISH_SHA_APPLSETTINGS optional .
private section.
*"* private components of class CL_ISH_AS_LOADER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_AS_LOADER IMPLEMENTATION.


METHOD destroy.

  FIELD-SYMBOLS: <ls_param>  LIKE LINE OF gt_param.

  LOOP AT gt_param ASSIGNING <ls_param>.
    <ls_param>-r_param->destroy( ).
  ENDLOOP.

  CLEAR: gt_param.

ENDMETHOD.


METHOD get_param.

  FIELD-SYMBOLS: <ls_param>  LIKE LINE OF gt_param.

  READ TABLE gt_param
    WITH TABLE KEY paramid = i_paramid
    ASSIGNING <ls_param>.
  CHECK sy-subrc = 0.

  rr_param = <ls_param>-r_param.

ENDMETHOD.


METHOD if_shm_build_instance~build.

  DATA: lr_area    TYPE REF TO cl_ish_sha_applsettings,
        lr_root    TYPE REF TO cl_ish_as_loader,
        lr_except  TYPE REF TO cx_root.

* Attach the area for write.
  TRY.
      lr_area = cl_ish_sha_applsettings=>attach_for_write( inst_name ).
    CATCH cx_shm_exclusive_lock_active
          cx_shm_version_limit_exceeded
          cx_shm_change_lock_active
          cx_shm_error INTO lr_except.
      RAISE EXCEPTION TYPE cx_shm_build_failed
        EXPORTING previous = lr_except.
  ENDTRY.

* Create the root.
  CREATE OBJECT lr_root AREA HANDLE lr_area.

* Initialize the root.
  lr_root->initialize( lr_area ).

* Set the area's root.
  lr_area->set_root( lr_root ).

* Commit.
  lr_area->detach_commit( ).

* Errorhandling.
  IF lr_except IS BOUND.
    RAISE EXCEPTION TYPE cx_shm_build_failed
      EXPORTING previous = lr_except.
  ENDIF.

ENDMETHOD.


METHOD initialize.

  DATA: lt_clskey       TYPE TABLE OF seoclskey,
        lt_param        TYPE ish_t_as_param,
        lr_param        TYPE REF TO cl_ish_as_param,
        ls_param        LIKE LINE OF gt_param.

  FIELD-SYMBOLS: <ls_clskey>     TYPE seoclskey,
                 <ls_param>      LIKE LINE OF gt_param.

* Determine all classes which implement the factory interface.
  lt_clskey = cl_ish_utl_rtti=>get_interface_implementations(
                i_interface_name  = 'IF_ISH_FAC_AS_PARAM'
                i_with_subclasses = off ).

* Now let the factories create the param objects and
* collect the param objects
  LOOP AT lt_clskey ASSIGNING <ls_clskey>.
    CHECK <ls_clskey>-clsname IS NOT INITIAL.
*   Let the factory create the param objects.
    TRY.
        CALL METHOD (<ls_clskey>-clsname)=>if_ish_fac_as_param~create_params
          EXPORTING
            ir_area  = ir_area
          RECEIVING
            rt_param = lt_param.
      CATCH cx_sy_dyn_call_illegal_method.
        CONTINUE.
    ENDTRY.
*   Collect the param objects.
    LOOP AT lt_param INTO ls_param-r_param.
      CHECK ls_param-r_param IS BOUND.
*     Get the paramid.
      ls_param-paramid = ls_param-r_param->get_paramid( ).
*     On non-unique paramid invalidate the param object.
      READ TABLE gt_param
        WITH TABLE KEY paramid = ls_param-paramid
        ASSIGNING <ls_param>.
      IF sy-subrc = 0.
        <ls_param>-r_param->invalidate( ).
        CONTINUE.
      ENDIF.
*     Initialize the param object.
      ls_param-r_param->initialize( ).
*     Collect the param object.
      INSERT ls_param INTO TABLE gt_param.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
