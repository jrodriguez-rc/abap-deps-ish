class CL_ISH_MONCON_MGR definition
  public
  final
  create public .

public section.
*"* public components of class CL_ISH_MONCON_MGR
*"* do not include other source files here!!!

  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_MONCON_MGR type ISH_OBJECT_TYPE value 12183. "#EC NOTEXT

  class-methods GET_AREA
    importing
      value(I_ID) type N1MONCON_AREAID
    returning
      value(RR_AREA) type ref to CL_ISH_MONCON_AREA
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods GET_AREAS
    returning
      value(RT_AREA) type ISH_T_MONCON_AREA_OBJ .
  class-methods GET_MGR
    returning
      value(RR_MGR) type ref to CL_ISH_MONCON_MGR .
  methods _GET_AREA
    importing
      value(I_ID) type N1MONCON_AREAID
    returning
      value(RR_AREA) type ref to CL_ISH_MONCON_AREA
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_AREAS
    returning
      value(RT_AREA) type ISH_T_MONCON_AREA_OBJ .
protected section.
*"* protected components of class CL_ISH_MONCON_MGR
*"* do not include other source files here!!!

  class-data GR_MGR type ref to CL_ISH_MONCON_MGR .
  data GT_AREA type ISH_T_MONCON_AREA_OBJ .
  type-pools ABAP .
  data G_AREAS_LOADED type ABAP_BOOL .

  methods LOAD_AREAS .
private section.
*"* private components of class CL_ISH_MONCON_MGR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_MONCON_MGR IMPLEMENTATION.


METHOD get_area.

  CALL METHOD cl_ish_moncon_mgr=>get_mgr
    RECEIVING
      rr_mgr = gr_mgr.

*  TRY.
  CALL METHOD gr_mgr->_get_area
    EXPORTING
      i_id    = i_id
    RECEIVING
      rr_area = rr_area.
*   CATCH CX_ISH_STATIC_HANDLER .
*  ENDTRY.

ENDMETHOD.


METHOD get_areas.

  CALL METHOD cl_ish_moncon_mgr=>get_mgr
    RECEIVING
      rr_mgr = gr_mgr.

  CALL METHOD gr_mgr->_get_areas
    RECEIVING
      rt_area = rt_area.

ENDMETHOD.


METHOD get_mgr.

  IF gr_mgr IS INITIAL.
    CREATE OBJECT gr_mgr.
  ENDIF.

  rr_mgr = gr_mgr.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_moncon_mgr.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_type  TYPE ish_object_type.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_type.

  IF i_object_type = l_type.
    r_is_a = abap_on.
  ELSE.
    r_is_a = abap_off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_moncon_mgr.
    r_is_inherited_from = abap_on.
  ELSE.
    r_is_inherited_from = abap_off.
  ENDIF.

ENDMETHOD.


METHOD load_areas.

  DATA: lt_clskey   TYPE seo_clskeys,
        lt_area     TYPE ish_t_moncon_area_obj.

  FIELD-SYMBOLS: <ls_clskey>  LIKE LINE OF lt_clskey.

  g_areas_loaded = abap_on.

  CALL METHOD cl_ish_utl_rtti=>get_interface_implementations
    EXPORTING
      i_interface_name  = 'IF_ISH_FAC_MONCON_AREA'
      i_with_subclasses = if_ish_constant_definition=>off
    RECEIVING
      rt_clskey         = lt_clskey.

  LOOP AT lt_clskey ASSIGNING <ls_clskey>.
    REFRESH lt_area.
    TRY.
        CALL METHOD (<ls_clskey>-clsname)=>('IF_ISH_FAC_MONCON_AREA~CREATE_AREAS')
          RECEIVING
            rt_area = lt_area.
      CATCH cx_root.                                     "#EC CATCH_ALL
        CONTINUE.
    ENDTRY.
    INSERT LINES OF lt_area INTO TABLE gt_area.
  ENDLOOP.

ENDMETHOD.


METHOD _get_area.

  DATA: ls_area           LIKE LINE OF gt_area,
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.

  CLEAR rr_area.

  IF g_areas_loaded = abap_off.
    CALL METHOD gr_mgr->load_areas.
  ENDIF.

  READ TABLE gt_area INTO ls_area WITH TABLE KEY area_id = i_id.
  IF sy-subrc = 0.
    rr_area = ls_area-r_area.
  ELSE.
    CREATE OBJECT lr_errorhandler.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '007'
        i_mv1           = 'CL_ISH_MONCON_MGR'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD _get_areas.

  REFRESH rt_area.

  IF g_areas_loaded = abap_off.
    CALL METHOD gr_mgr->load_areas.
  ENDIF.

  rt_area[] = gt_area[].

ENDMETHOD.
ENDCLASS.
