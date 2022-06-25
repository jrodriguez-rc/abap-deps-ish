class CL_ISHMED_SS_CONTROL_OWNER definition
  public
  final
  create private

  global friends CL_ISHMED_SELECTION_SERVICES .

public section.
*"* public components of class CL_ISHMED_SS_CONTROL_OWNER
*"* do not include other source files here!!!

  interfaces IF_ISH_CONTROLLABLE_OWNER .
protected section.
*"* protected components of class CL_ISHMED_SS_CONTROL_OWNER
*"* do not include other source files here!!!

  data GR_CB_CONTROLLABLE type ref to IF_ISH_CONTROLLABLE .
  data G_CB_ACTION type N1_CB_ACTION .

  methods DEREGISTER_OWNER
    importing
      value(I_ACTION) type N1_CB_ACTION
      !IR_CONTROLLABLE type ref to IF_ISH_CONTROLLABLE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DEREGISTER_OWNER_SET_BUFFER
    importing
      !IR_CONTROLLABLE type ref to IF_ISH_CONTROLLABLE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REGISTER_OWNER
    importing
      !I_ACTION type N1_CB_ACTION
      !IR_CONTROLLABLE type ref to IF_ISH_CONTROLLABLE
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  methods REGISTER_OWNER_SET_BUFFER
    importing
      !IR_CONTROLLABLE type ref to IF_ISH_CONTROLLABLE
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
private section.
*"* private components of class CL_ISHMED_SS_CONTROL_OWNER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISHMED_SS_CONTROL_OWNER IMPLEMENTATION.


METHOD deregister_owner.
  DATA lx_static     TYPE REF TO cx_ish_static_handler.
* ----- ----- -----
  CLEAR e_rc.
* ----- ----- -----
  IF ir_controllable IS INITIAL.
    RETURN.
  ENDIF.
* ----- ----- -----
  gr_cb_controllable = ir_controllable.
  g_cb_action = i_action.
* ----- ----- -----
  CALL METHOD ir_controllable->deregister_owner
    EXPORTING
      ir_owner = me
      i_action = i_action.
* ----- ----- -----
  CLEAR: gr_cb_controllable, g_cb_action.
* ----- ----- -----
ENDMETHOD.


METHOD deregister_owner_set_buffer.
  DATA lx_static     TYPE REF TO cx_ish_static_handler.
* ----- ----- -----
  CLEAR e_rc.
* ----- ----- -----
  IF ir_controllable IS INITIAL.
    RETURN.
  ENDIF.
* ----- ----- -----
  CALL METHOD me->deregister_owner
    EXPORTING
      i_action        = cl_ish_run_data=>co_acts_set_buffer
      ir_controllable = ir_controllable
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
* ----- ----- -----
ENDMETHOD.


METHOD if_ish_controllable_owner~cb_boolean_action.
* MED-40483
  CLEAR r_result.

  IF gr_cb_controllable IS NOT BOUND
       OR gr_cb_controllable <> ir_controllable.
    CALL METHOD cl_ish_utl_exception=>raise_static
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'CB_BOOLEAN_ACTION'
        i_mv3 = 'CL_ISHMED_SS_CONTROL_OWNER'.
  ENDIF.
  CASE i_action.

*   if action is not handled raise a exeption
    WHEN OTHERS.
      CALL METHOD cl_ish_utl_exception=>raise_static
        EXPORTING
          i_typ = 'E'
          i_kla = 'N1BASE'
          i_num = '030'
          i_mv1 = '2'
          i_mv2 = 'CB_BOOLEAN_ACTION'
          i_mv3 = 'CL_ISHMED_SS_CONTROL_OWNER'.
  ENDCASE.
ENDMETHOD.


METHOD if_ish_controllable_owner~cb_complex_action.
* MED-40483
  CLEAR rr_result.

  IF gr_cb_controllable IS NOT BOUND
       OR gr_cb_controllable <> ir_controllable.
    CALL METHOD cl_ish_utl_exception=>raise_static
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'CB_COMPLEX_ACTION'
        i_mv3 = 'CL_ISHMED_SS_CONTROL_OWNER'.
  ENDIF.
  CASE i_action.

*   if action is not handled raise a exeption
    WHEN OTHERS.
      CALL METHOD cl_ish_utl_exception=>raise_static
        EXPORTING
          i_typ = 'E'
          i_kla = 'N1BASE'
          i_num = '030'
          i_mv1 = '2'
          i_mv2 = 'CB_COMPLEX_ACTION'
          i_mv3 = 'CL_ISHMED_SS_CONTROL_OWNER'.
  ENDCASE.
ENDMETHOD.


METHOD if_ish_controllable_owner~cb_dereg_from_controllable.
* MED-40483
  CLEAR r_allowed.
  IF ir_controllable IS BOUND
    AND ir_controllable = gr_cb_controllable
    AND g_cb_action IS NOT INITIAL
    AND i_action = g_cb_action.
    r_allowed = abap_true.
  ENDIF.
ENDMETHOD.


METHOD IF_ISH_CONTROLLABLE_OWNER~CB_REG_FURTHER_OWNER.
* MED-40483
* all additional owner are allowed.
ENDMETHOD.


METHOD if_ish_controllable_owner~cb_reg_to_controllable.
* MED-40483
  IF ir_controllable IS NOT BOUND
    OR ir_controllable <> gr_cb_controllable
    OR g_cb_action IS INITIAL
    OR i_action <> g_cb_action.
    CALL METHOD cl_ish_utl_exception=>raise_static
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'CB_REG_TO_CONTROLLABLE'
        i_mv3 = 'CL_ISHMED_SS_CONTROL_OWNER'.
  ENDIF.
ENDMETHOD.


METHOD if_ish_controllable_owner~cb_simple_action.
* MED-40483

  IF gr_cb_controllable IS NOT BOUND
    OR gr_cb_controllable <> ir_controllable.
    CALL METHOD cl_ish_utl_exception=>raise_static
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'CB_SIMPLE_ACTION'
        i_mv3 = 'CL_ISHMED_SS_CONTROL_OWNER'.
  ENDIF.

  CASE i_action.
*   action set buffer into data object is allowed
    WHEN cl_ish_run_data=>co_acts_set_buffer.
*   nothing to do

*   if action is not handled raise a exeption
    WHEN OTHERS.
      CALL METHOD cl_ish_utl_exception=>raise_static
        EXPORTING
          i_typ = 'E'
          i_kla = 'N1BASE'
          i_num = '030'
          i_mv1 = '2'
          i_mv2 = 'CB_SIMPLE_ACTION'
          i_mv3 = 'CL_ISHMED_SS_CONTROL_OWNER'.
  ENDCASE.

ENDMETHOD.


METHOD register_owner.
  DATA lx_static     TYPE REF TO cx_ish_static_handler.
* ----- ----- -----
  CLEAR e_rc.
* ----- ----- -----
  IF ir_controllable IS INITIAL .
    RETURN.
  ENDIF.
* ----- ----- -----
  TRY.
      gr_cb_controllable = ir_controllable.
      g_cb_action = i_action.
      CALL METHOD ir_controllable->register_owner
        EXPORTING
          ir_owner = me
          i_action = i_action.
*      CLEAR: gr_cb_controllable, g_cb_action.
    CATCH cx_ish_static_handler INTO lx_static.
      CLEAR: gr_cb_controllable, g_cb_action.
      e_rc = 1.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
        EXPORTING
          i_exceptions    = lx_static
        CHANGING
          cr_errorhandler = cr_errorhandler.
      RETURN.
  ENDTRY.
* ----- ----- -----
ENDMETHOD.


METHOD register_owner_set_buffer.
  DATA lx_static     TYPE REF TO cx_ish_static_handler.
* ----- ----- -----
  CLEAR e_rc.
* ----- ----- -----
  IF ir_controllable IS INITIAL .
    RETURN.
  ENDIF.
* ----- ----- -----
  CALL METHOD me->register_owner
    EXPORTING
      i_action        = cl_ish_run_data=>co_acts_set_buffer
      ir_controllable = ir_controllable
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
* ----- ----- -----
ENDMETHOD.
ENDCLASS.
