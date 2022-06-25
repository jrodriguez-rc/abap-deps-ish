class CL_ISH_CDO_GM_CDOS definition
  public
  inheriting from CL_ISH_GM_TABLE
  create protected .

public section.
*"* public components of class CL_ISH_CDO_GM_CDOS
*"* do not include other source files here!!!

  methods GET_T_CDO
    returning
      value(RT_CDO) type ISHMED_T_OBJ_CDO_GM_CDO
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_BY_APP
    importing
      !IR_APP type ref to CL_ISH_APPOINTMENT
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_CDO_GM_CDOS
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_CDOS
    importing
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IT_ENTRY type ISH_T_GUI_MODEL_OBJHASH optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_CDO_GM_CDOS
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_CDO_GM_CDOS
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_CDO_GM_CDOS
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_CDO_GM_CDOS IMPLEMENTATION.


METHOD create_by_app.

  DATA: l_rc         TYPE ish_method_rc.
  DATA: lt_changedoc TYPE cdredcd_tab,
        lt_entry     TYPE ish_t_gui_model_objhash.
  DATA: lr_error     TYPE REF TO cl_ishmed_errorhandling.
  DATA: ls_entry     LIKE LINE OF lt_entry.
  FIELD-SYMBOLS: <ls_change> LIKE LINE OF lt_changedoc.
* ----- ----- -----
  IF ir_app IS INITIAL.
    cl_ish_utl_exception=>raise_static(
              i_typ        = 'E'
              i_kla        = 'N1BASE'
              i_num        = '030'
              i_mv1        = '1'
              i_mv2        = 'CREATE_BY_APP'
              i_mv3        = 'CL_ISH_CDO_GM_CDOS' ).
  ENDIF.
* ----- ----- -----

  CALL METHOD cl_ish_utl_apmg=>read_changedoc_app
    EXPORTING
      ir_app          = ir_app
      i_all_fields    = abap_false
    IMPORTING
      et_cdredcd      = lt_changedoc
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.
  IF l_rc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_error.
  ENDIF.
  IF lt_changedoc IS INITIAL.
*   no change documents found
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N091'
        i_num           = '002'
      CHANGING
        cr_errorhandler = lr_error.

    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_error.
  ENDIF.
  LOOP AT lt_changedoc ASSIGNING <ls_change>.
    ls_entry = cl_ish_cdo_gm_cdo=>create( is_cdred = <ls_change> ).
    INSERT ls_entry INTO TABLE lt_entry.
  ENDLOOP.
* ----- ----- -----
  CREATE OBJECT rr_instance
    EXPORTING
      ir_cb_tabmdl      = ir_cb_tabmdl
      ir_cb_destroyable = ir_cb_destroyable
      it_entry          = lt_entry.

* ----- ----- -----
ENDMETHOD.


METHOD create_cdos.

  CREATE OBJECT rr_instance
    EXPORTING
      ir_cb_tabmdl      = ir_cb_tabmdl
      ir_cb_destroyable = ir_cb_destroyable
      it_entry          = it_entry.

ENDMETHOD.


METHOD get_t_cdo.

  DATA: lt_entry TYPE ish_t_gui_model_objhash.
  DATA: ls_cdo   LIKE LINE OF rt_cdo.

  FIELD-SYMBOLS: <ls_entry> LIKE LINE OF lt_entry.
* ----- ----- ----- -----
  lt_entry =  me->if_ish_gui_table_model~get_entries( ).
* ----- ----- ----- -----
  LOOP AT lt_entry ASSIGNING <ls_entry>.
    TRY .
        ls_cdo ?= <ls_entry>.
        APPEND ls_cdo TO rt_cdo.
      CATCH cx_sy_move_cast_error .

    ENDTRY.
  ENDLOOP.
* ----- ----- ----- -----
ENDMETHOD.
ENDCLASS.
