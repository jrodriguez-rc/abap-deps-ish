class CL_ISH_APPLSETTINGS definition
  public
  abstract
  final
  create public .

*"* public components of class CL_ISH_APPLSETTINGS
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .

  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .

  constants CO_ACTUALITY_DB type N1ASACTUALITY value 'DB'. "#EC NOTEXT
  constants CO_ACTUALITY_SESSION type N1ASACTUALITY value 'SESSION'. "#EC NOTEXT

  class-methods GET_PARAM
    importing
      !I_PARAMID type N1ASPARAMID
    returning
      value(RR_PARAM) type ref to CL_ISH_AS_PARAM .
  class-methods GET_VALUE_C
    importing
      !I_PARAMID type N1ASPARAMID
      !I_MANDT type MANDT default SY-MANDT
      !I_ACTUALITY type N1ASACTUALITY default CO_ACTUALITY_SESSION
    returning
      value(R_VALUE) type N1ASVALUE .
protected section.
*"* protected components of class CL_ISH_APPLSETTINGS
*"* do not include other source files here!!!

  class-methods ATTACH_FOR_READ
    returning
      value(RR_AREA) type ref to CL_ISH_SHA_APPLSETTINGS .
  class-methods DETACH
    importing
      !IR_AREA type ref to CL_ISH_SHA_APPLSETTINGS .
  class-methods GET_LOADER
    returning
      value(RR_LOADER) type ref to CL_ISH_AS_LOADER .
private section.
*"* private components of class CL_ISH_APPLSETTINGS
*"* do not include other source files here!!!

  class-data GR_LOADER type ref to CL_ISH_AS_LOADER .
ENDCLASS.



CLASS CL_ISH_APPLSETTINGS IMPLEMENTATION.


METHOD attach_for_read.

  TRY.
      rr_area = cl_ish_sha_applsettings=>attach_for_read( ).
    CATCH cx_shm_no_active_version.
    CATCH cx_shm_inconsistent
          cx_shm_read_lock_active
          cx_shm_exclusive_lock_active
          cx_shm_parameter_error
          cx_shm_change_lock_active.
      EXIT.
  ENDTRY.
  IF rr_area IS NOT BOUND.
    WAIT UP TO 1 SECONDS.
    TRY.
        rr_area = cl_ish_sha_applsettings=>attach_for_read( ).
      CATCH cx_shm_inconsistent
            cx_shm_no_active_version
            cx_shm_read_lock_active
            cx_shm_exclusive_lock_active
            cx_shm_parameter_error
            cx_shm_change_lock_active.
    ENDTRY.
  ENDIF.

ENDMETHOD.


METHOD detach.

  CHECK ir_area IS BOUND.

  TRY.
      ir_area->detach( ).
    CATCH cx_shm_wrong_handle
          cx_shm_already_detached.
  ENDTRY.

ENDMETHOD.


METHOD get_loader.

  DATA: lr_area    TYPE REF TO cl_ish_sha_applsettings.

  IF gr_loader IS NOT BOUND.
    lr_area = attach_for_read( ).
    IF lr_area IS BOUND.
      gr_loader = lr_area->root.
    ENDIF.
    IF gr_loader IS NOT BOUND.
      detach( lr_area ).
      CREATE OBJECT gr_loader.
      gr_loader->initialize( ).
    ENDIF.
  ENDIF.

  rr_loader = gr_loader.

ENDMETHOD.


METHOD get_param.

  DATA: lr_loader        TYPE REF TO cl_ish_as_loader.

  lr_loader = get_loader( ).
  rr_param = lr_loader->get_param( i_paramid ).

ENDMETHOD.


METHOD get_value_c.

* Michael Manoch, 21.01.2010, MED-39426
* Do not raise a x-message.
* If the param object does not exist we try to load it via a temporary loader.

  DATA lr_param       TYPE REF TO cl_ish_as_param_c.
  DATA lr_loader      TYPE REF TO cl_ish_as_loader.

* Get the param.
  TRY.
      lr_param ?= get_param( i_paramid ).
      IF lr_param IS NOT BOUND.
        CREATE OBJECT lr_loader.
        lr_loader->initialize( ).
        lr_param ?= lr_loader->get_param( i_paramid ).
      ENDIF.
    CATCH cx_sy_move_cast_error.
      CLEAR lr_param.
  ENDTRY.

* Get the value.
  IF lr_param IS BOUND AND
     lr_param->is_invalid( ) = abap_false.
    r_value = lr_param->get_value( i_mandt ).
  ENDIF.

* Handle db actuality.
  IF i_actuality = co_actuality_db.
    SELECT SINGLE value
      FROM n1asvaluec
      INTO r_value
      WHERE paramid = i_paramid
        AND mandt   = i_mandt.
  ENDIF.

ENDMETHOD.
ENDCLASS.
