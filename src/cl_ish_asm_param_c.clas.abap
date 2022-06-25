class CL_ISH_ASM_PARAM_C definition
  public
  inheriting from CL_ISH_ASM_PARAM
  create public .

*"* public components of class CL_ISH_ASM_PARAM_C
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_ASM_PARAM_C type ISH_OBJECT_TYPE value 12159. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_PARAM type ref to CL_ISH_AS_PARAM_C
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_PARAM_C
    returning
      value(RR_PARAM_C) type ref to CL_ISH_AS_PARAM_C .
  methods GET_T_VALUE
    returning
      value(RT_VALUE) type ISH_T_ASVALUE_C_HASH .
  methods GET_VALUE
    importing
      !I_MANDT type MANDT default SY-MANDT
    returning
      value(R_VALUE) type N1ASVALUE .
  methods SET_VALUE
    importing
      !I_MANDT type MANDT default SY-MANDT
      !I_VALUE type N1ASVALUE .

  methods CHECK
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IS_CHANGED
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_ASM_PARAM_C
*"* do not include other source files here!!!

  data GT_VALUE type ISH_T_ASVALUE_C_HASH .

  methods GET_BOOKING_TABLES
    exporting
      !ET_NVN1ASVALUEC type ISH_T_VN1ASVALUEC
      !ET_OVN1ASVALUEC type ISH_T_VN1ASVALUEC .

  methods INITIALIZE
    redefinition .
  methods SAVE
    redefinition .
  methods _DESTROY
    redefinition .
  methods _LOCK
    redefinition .
  methods _UNLOCK
    redefinition .
private section.
*"* private components of class CL_ISH_ASM_PARAM_C
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_ASM_PARAM_C IMPLEMENTATION.


METHOD check.

* Initializations.
  e_rc = 0.

ENDMETHOD.


METHOD constructor.

  super->constructor( ir_param ).

ENDMETHOD.


METHOD get_booking_tables.

  DATA: lr_param          TYPE REF TO cl_ish_as_param_c,
        lt_value_old      LIKE gt_value,
        l_paramid         TYPE n1asparamid,
        ls_nvn1asvaluec   TYPE vn1asvaluec,
        ls_ovn1asvaluec   TYPE vn1asvaluec.

  FIELD-SYMBOLS: <ls_value_new>  LIKE LINE OF gt_value,
                 <ls_value_old>  LIKE LINE OF gt_value.

* Get old values.
  lr_param = get_param_c( ).
  lt_value_old = lr_param->get_t_value( ).

* Get self's paramid.
  l_paramid = get_paramid( ).

* Handle new or changed values.
  LOOP AT gt_value ASSIGNING <ls_value_new>.
    READ TABLE lt_value_old
      WITH KEY mandt = <ls_value_new>-mandt
      ASSIGNING <ls_value_old>.
    IF sy-subrc = 0.
      CHECK <ls_value_old>-value <> <ls_value_new>-value.
*     Update
      CLEAR: ls_ovn1asvaluec,
             ls_nvn1asvaluec.
      ls_ovn1asvaluec-paramid = l_paramid.
      ls_ovn1asvaluec-mandt   = <ls_value_old>-mandt.
      ls_ovn1asvaluec-value   = <ls_value_old>-value.
      APPEND ls_ovn1asvaluec TO et_ovn1asvaluec.
      MOVE-CORRESPONDING ls_ovn1asvaluec TO ls_nvn1asvaluec.
      ls_nvn1asvaluec-value   = <ls_value_new>-value.
      ls_nvn1asvaluec-kz      = co_mode_update.
      APPEND ls_nvn1asvaluec TO et_nvn1asvaluec.
    ELSE.
*     Insert
      CLEAR: ls_ovn1asvaluec,
             ls_nvn1asvaluec.
      ls_nvn1asvaluec-paramid = l_paramid.
      ls_nvn1asvaluec-mandt   = <ls_value_new>-mandt.
      ls_nvn1asvaluec-value   = <ls_value_new>-value.
      ls_nvn1asvaluec-kz      = co_mode_insert.
      APPEND ls_nvn1asvaluec TO et_nvn1asvaluec.
    ENDIF.
  ENDLOOP.

* Handle deleted values.
  LOOP AT lt_value_old ASSIGNING <ls_value_old>.
    READ TABLE gt_value
      WITH TABLE KEY mandt = <ls_value_old>-mandt
      TRANSPORTING NO FIELDS.
    CHECK sy-subrc <> 0.
*   Delete.
    CLEAR: ls_ovn1asvaluec,
           ls_nvn1asvaluec.
    ls_ovn1asvaluec-paramid = l_paramid.
    ls_ovn1asvaluec-mandt   = <ls_value_old>-mandt.
    ls_ovn1asvaluec-value   = <ls_value_old>-value.
    APPEND ls_ovn1asvaluec TO et_ovn1asvaluec.
    MOVE-CORRESPONDING ls_ovn1asvaluec TO ls_nvn1asvaluec.
    ls_nvn1asvaluec-kz = co_mode_delete.
    APPEND ls_nvn1asvaluec TO et_nvn1asvaluec.
  ENDLOOP.

ENDMETHOD.


METHOD get_param_c.

  rr_param_c ?= get_param( ).

ENDMETHOD.


METHOD get_t_value.

  rt_value = gt_value.

ENDMETHOD.


METHOD get_value.

  DATA: lr_param  TYPE REF TO cl_ish_as_param_c.

  FIELD-SYMBOLS: <ls_value>  LIKE LINE OF gt_value.

  READ TABLE gt_value
    WITH TABLE KEY mandt = i_mandt
    ASSIGNING <ls_value>.

  IF sy-subrc = 0.
    r_value = <ls_value>-value.
  ELSE.
    lr_param = get_param_c( ).
    r_value = lr_param->get_default_value( ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_asm_param_c.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_asm_param_c.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD initialize.

  DATA: lr_param  TYPE REF TO cl_ish_as_param_c.

  lr_param = get_param_c( ).
  gt_value = lr_param->get_t_value( ).

ENDMETHOD.


METHOD is_changed.

  DATA: lr_param  TYPE REF TO cl_ish_as_param_c,
        lt_value  LIKE gt_value.

  FIELD-SYMBOLS: <ls_value_new>  LIKE LINE OF gt_value,
                 <ls_value_old>  LIKE LINE OF gt_value.

* Initializations.
  r_changed = off.

* Get old values.
  lr_param = get_param_c( ).
  lt_value = lr_param->get_t_value( ).

* Start comparing.

  IF gt_value <> lt_value.
    r_changed = on.
    EXIT.
  ENDIF.

  LOOP AT gt_value ASSIGNING <ls_value_new>.
    READ TABLE lt_value
      WITH TABLE KEY mandt = <ls_value_new>-mandt
      ASSIGNING <ls_value_old>.
    IF sy-subrc <> 0 OR
       <ls_value_new>-value <> <ls_value_old>-value.
      r_changed = on.
      EXIT.
    ENDIF.
  ENDLOOP.
  CHECK r_changed = off.

ENDMETHOD.


METHOD save.

  DATA: lt_nvn1asvaluec  TYPE ish_t_vn1asvaluec,
        lt_ovn1asvaluec  TYPE ish_t_vn1asvaluec.

* Get booking tables.
  CALL METHOD get_booking_tables
    IMPORTING
      et_nvn1asvaluec = lt_nvn1asvaluec
      et_ovn1asvaluec = lt_ovn1asvaluec.
  CHECK lt_nvn1asvaluec IS NOT INITIAL.

* Book.
  CALL FUNCTION 'ISH_UPDATE_N1ASVALUEC' IN UPDATE TASK
    EXPORTING
      it_nvn1asvaluec = lt_nvn1asvaluec
      it_ovn1asvaluec = lt_ovn1asvaluec.

ENDMETHOD.


METHOD set_value.

  DATA: ls_value  LIKE LINE OF gt_value.

  FIELD-SYMBOLS: <ls_value>  LIKE LINE OF gt_value.

  READ TABLE gt_value
    WITH TABLE KEY mandt = i_mandt
    ASSIGNING <ls_value>.
  IF sy-subrc = 0.
    IF i_value = get_default_value( ).
      DELETE TABLE gt_value WITH TABLE KEY mandt = i_mandt.
    ELSE.
      <ls_value>-value = i_value.
    ENDIF.
    EXIT.
  ENDIF.

  CHECK i_value <> get_default_value( ).

  CLEAR: ls_value.
  ls_value-mandt = i_mandt.
  ls_value-value = i_value.
  INSERT ls_value INTO TABLE gt_value.

ENDMETHOD.


METHOD _destroy.

  CLEAR: gt_value.

ENDMETHOD.


METHOD _lock.

  DATA: l_paramid        TYPE n1asparamid,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

* Get the paramid.
  l_paramid = get_paramid( ).

* Enqueue.
  CALL FUNCTION 'ENQUEUE_EN1ASVALUEC'
    EXPORTING
      paramid        = l_paramid
      x_paramid      = on
    EXCEPTIONS
      foreign_lock   = 1
      system_failure = 2
      OTHERS         = 3.

* Handle the result.
  CASE sy-subrc.
    WHEN  0.
    WHEN  1.
*     Already locked.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '092'
          i_mv1           = l_paramid
          i_mv2           = sy-msgv1
        CHANGING
          cr_errorhandler = lr_errorhandler.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.
    WHEN OTHERS.
*     Any locking error.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '093'
          i_mv1           = l_paramid
        CHANGING
          cr_errorhandler = lr_errorhandler.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.
  ENDCASE.

ENDMETHOD.


METHOD _unlock.

  DATA: l_paramid  TYPE n1asparamid.

  l_paramid = get_paramid( ).

  CALL FUNCTION 'DEQUEUE_EN1ASVALUEC'
    EXPORTING
      paramid   = l_paramid
      x_paramid = on.

ENDMETHOD.
ENDCLASS.
