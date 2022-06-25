class CL_ISH_MONCON_AREA definition
  public
  create public .

public section.
*"* public components of class CL_ISH_MONCON_AREA
*"* do not include other source files here!!!

  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_CONSTANT_DEFINITION .

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

  constants CO_OTYPE_MONCON_AREA type ISH_OBJECT_TYPE value 12184. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      value(I_ID) type N1MONCON_AREAID
      value(I_NAME) type N1MONCON_AREANAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods CREATE_CONFIG
    importing
      value(I_NAME) type N1MONCON_NAME optional
    preferred parameter I_NAME
    returning
      value(RR_MONCON) type ref to CL_ISH_MONCON
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_CONFIG
    importing
      value(I_ID) type N1MONCON_ID
    returning
      value(RR_CONFIG) type ref to CL_ISH_MONCON
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_CONFIGS
    returning
      value(RT_CONFIG) type ISH_T_MONCON_OBJ .
  methods GET_ID
  final
    returning
      value(R_ID) type N1MONCON_AREAID .
  methods GET_NAME
  final
    returning
      value(R_NAME) type N1MONCON_AREANAME .
  methods INVALIDATE
  final .
  type-pools ABAP .
  methods IS_VALID
  final
    returning
      value(R_VALID) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_MONCON_AREA
*"* do not include other source files here!!!

  data GT_CONFIG type ISH_T_MONCON_OBJ .
  data G_CONFIGS_LOADED type ABAP_BOOL .

  methods LOAD_CONFIGS .
private section.
*"* private components of class CL_ISH_MONCON_AREA
*"* do not include other source files here!!!

  data G_ID type N1MONCON_AREAID .
  data G_INVALID type ABAP_BOOL .
  data G_NAME type N1MONCON_AREANAME .
ENDCLASS.



CLASS CL_ISH_MONCON_AREA IMPLEMENTATION.


METHOD constructor.

  DATA: lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.

  IF i_id IS INITIAL OR i_name IS INITIAL.
    CREATE OBJECT lr_errorhandler.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_MONCON_AREA'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ELSE.
    me->g_id   = i_id.
    me->g_name = i_name.
  ENDIF.

ENDMETHOD.


METHOD create_config.

  DATA: ls_config     LIKE LINE OF gt_config.

*  TRY.
  CALL METHOD cl_ish_moncon=>create
    EXPORTING
      ir_area   = me
      i_name    = i_name
    RECEIVING
      rr_moncon = rr_moncon.
*   CATCH CX_ISH_STATIC_HANDLER .
*  ENDTRY.

  IF rr_moncon IS BOUND.
    CLEAR ls_config.
    ls_config-moncon_id = rr_moncon->get_id( ).
    ls_config-r_moncon  = rr_moncon.
    INSERT ls_config INTO TABLE gt_config.
  ENDIF.

ENDMETHOD.


METHOD get_config.

  DATA: ls_config         LIKE LINE OF gt_config,
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.

  CLEAR rr_config.

  IF g_configs_loaded = abap_off.
    CALL METHOD me->load_configs.
  ENDIF.

  READ TABLE gt_config INTO ls_config WITH TABLE KEY moncon_id = i_id.
  IF sy-subrc = 0.
    rr_config = ls_config-r_moncon.
  ELSE.
    CREATE OBJECT lr_errorhandler.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_MONCON_AREA'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD get_configs.

  REFRESH rt_config.

  IF g_configs_loaded = abap_off.
    CALL METHOD me->load_configs.
  ENDIF.

  rt_config[] = gt_config[].

ENDMETHOD.


METHOD get_id.

  r_id = g_id.

ENDMETHOD.


METHOD get_name.

  r_name = g_name.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_moncon_area.

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

  IF i_object_type = co_otype_moncon_area.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD invalidate.

  g_invalid = abap_on.

ENDMETHOD.


METHOD is_valid.

  IF g_invalid = abap_on.
    r_valid = abap_off.
  ELSE.
    r_valid = abap_on.
  ENDIF.

ENDMETHOD.


METHOD load_configs.

  DATA: lt_n1moncon     TYPE TABLE OF n1moncon,
        ls_n1moncon     LIKE LINE OF lt_n1moncon,
        lt_n1moncont    TYPE HASHED TABLE OF n1moncont
                             WITH UNIQUE KEY moncon_id,
        ls_n1moncont    LIKE LINE OF lt_n1moncont,
        ls_config       LIKE LINE OF gt_config,
        lr_moncon       TYPE REF TO cl_ish_moncon.

  g_configs_loaded = abap_on.

  REFRESH: lt_n1moncon, lt_n1moncont.

  SELECT * FROM n1moncon INTO TABLE lt_n1moncon
         WHERE  area_id  = g_id.
  CHECK sy-subrc = 0.
  SELECT * FROM n1moncont INTO TABLE lt_n1moncont
         FOR ALL ENTRIES IN lt_n1moncon
         WHERE  spras      = sy-langu
         AND    moncon_id  = lt_n1moncon-moncon_id.

  LOOP AT lt_n1moncon INTO ls_n1moncon.
    READ TABLE lt_n1moncont INTO ls_n1moncont
         WITH TABLE KEY moncon_id = ls_n1moncon-moncon_id.
    IF sy-subrc <> 0.
      CLEAR ls_n1moncont.
    ENDIF.
    CLEAR lr_moncon.
    TRY.
        CALL METHOD cl_ish_moncon=>load
          EXPORTING
            ir_area      = me
            is_n1moncon  = ls_n1moncon
            is_n1moncont = ls_n1moncont
          RECEIVING
            rr_moncon    = lr_moncon.
      CATCH cx_ish_static_handler .
        CONTINUE.
    ENDTRY.
    CHECK lr_moncon IS BOUND.
    CLEAR ls_config.
    ls_config-moncon_id = ls_n1moncon-moncon_id.
    ls_config-r_moncon  = lr_moncon.
    INSERT ls_config INTO TABLE gt_config.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
