class CL_ISH_RS_MGR definition
  public
  final
  create private .

*"* public components of class CL_ISH_RS_MGR
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_DESTROYABLE .

  aliases DESTROY
    for IF_ISH_DESTROYABLE~DESTROY .
  aliases IS_DESTROYED
    for IF_ISH_DESTROYABLE~IS_DESTROYED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_DESTROYABLE~IS_IN_DESTROY_MODE .
  aliases EV_AFTER_DESTROY
    for IF_ISH_DESTROYABLE~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_DESTROYABLE~EV_BEFORE_DESTROY .

  class-events EV_ACTUAL_MGR_SET
    exporting
      value(ER_OLD_ACTUAL_MGR) type ref to CL_ISH_RS_MGR
      value(ER_NEW_ACTUAL_MGR) type ref to CL_ISH_RS_MGR .

  class-methods GET_ACTUAL_INSTANCE
    returning
      value(RR_INSTANCE) type ref to CL_ISH_RS_MGR .
  class-methods GET_INSTANCE_BY_USER
    importing
      !IR_USER type ref to IF_ISH_RS_USER
    returning
      value(RR_INSTANCE) type ref to CL_ISH_RS_MGR .
  class-methods GET_USERS
    importing
      !IR_MGR type ref to CL_ISH_RS_MGR
    returning
      value(RT_USER) type ISH_T_RS_USER_OBJH .
  type-pools ABAP .
  class-methods NEW_INSTANCE
    importing
      !IR_USER type ref to IF_ISH_RS_USER optional
      !I_ACTUAL type ABAP_BOOL default 'X'
    preferred parameter IR_USER
    returning
      value(RR_INSTANCE) type ref to CL_ISH_RS_MGR
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods SET_ACTUAL_INSTANCE
    importing
      !IR_MGR type ref to CL_ISH_RS_MGR
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_READ_SERVICE
    importing
      !I_TYPE type N1RS_TYPE
    returning
      value(RR_READ_SERVICE) type ref to IF_ISH_RS_READ_SERVICE
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_USER
    returning
      value(RR_USER) type ref to IF_ISH_RS_USER .
protected section.
*"* protected components of class CL_ISH_RS_MGR
*"* do not include other source files here!!!

  methods _DESTROY .
private section.
*"* private components of class CL_ISH_RS_MGR
*"* do not include other source files here!!!

  class-data GR_ACTUAL_MGR type ref to CL_ISH_RS_MGR .
  class-data GT_MGR type ISH_T_RS_MGR_OBJUSERH .
  data GR_USER type ref to IF_ISH_RS_USER .
  data GT_READ_SERVICE type ISH_T_RS_READSERVICE_OBJIDH .
  type-pools ABAP .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .

  methods CONSTRUCTOR
    importing
      !IR_USER type ref to IF_ISH_RS_USER optional .
ENDCLASS.



CLASS CL_ISH_RS_MGR IMPLEMENTATION.


METHOD constructor.

* set the user
  gr_user = ir_user.

ENDMETHOD.


METHOD get_actual_instance.

* return the actual instance
  rr_instance = gr_actual_mgr.

ENDMETHOD.


METHOD get_instance_by_user.

  FIELD-SYMBOLS <ls_mgr>            LIKE LINE OF gt_mgr.

  READ TABLE gt_mgr
    WITH TABLE KEY r_user = ir_user
    ASSIGNING <ls_mgr>.
  CHECK sy-subrc = 0.

  rr_instance = <ls_mgr>-r_mgr.

ENDMETHOD.


METHOD get_read_service.

  DATA l_clsname                    TYPE seoclsname.
  DATA ls_read_service              LIKE LINE OF gt_read_service.
  DATA lx_static                    TYPE REF TO cx_ish_static_handler.
  DATA lx_root                      TYPE REF TO cx_root.

  FIELD-SYMBOLS <ls_read_service>   LIKE LINE OF gt_read_service.

  IF i_type IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_READ_SERVICE'
        i_mv3        = 'CL_ISH_RS_MGR' ).
  ENDIF.

* Already loaded?
  READ TABLE gt_read_service
    WITH TABLE KEY id = i_type
    ASSIGNING <ls_read_service>.
  IF sy-subrc = 0.
    rr_read_service = <ls_read_service>-r_obj.
    RETURN.
  ENDIF.

* Get the classname.
  l_clsname = cl_ish_rs_type=>sget_clsname_read_service( i_type ).
  IF l_clsname IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'GET_READ_SERVICE'
        i_mv3        = 'CL_ISH_RS_MGR' ).
  ENDIF.

* Create the object.
  TRY.
      CALL METHOD (l_clsname)=>if_ish_rs_read_service~new_instance
        EXPORTING
          ir_mgr      = me
          i_type      = i_type
        RECEIVING
          rr_instance = rr_read_service.
    CATCH cx_ish_static_handler INTO lx_static.
      RAISE EXCEPTION lx_static.
    CATCH cx_root INTO lx_root. "EC CATCH ALL
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

* Register the object.
  ls_read_service-id    = i_type.
  ls_read_service-r_obj = rr_read_service.
  INSERT ls_read_service INTO TABLE gt_read_service.

ENDMETHOD.


METHOD get_user.

* return the user
  rr_user = gr_user.

ENDMETHOD.


METHOD get_users.

  DATA: ls_mgr TYPE rn1_rs_mgr_objuserh.

* return all useres for the administrator
  LOOP AT gt_mgr INTO ls_mgr WHERE r_mgr = ir_mgr.
    CHECK ls_mgr-r_user IS BOUND.
    INSERT ls_mgr-r_user INTO TABLE rt_user.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_destroyable~destroy.

* Process only if we are not already destroyed or in destroy mode.
  CHECK is_destroyed( )       = abap_false.
  CHECK is_in_destroy_mode( ) = abap_false.

* Callback.
  IF gr_user IS BOUND.
    CHECK gr_user->cb_destroy( ir_destroyable = me ) = abap_true.
  ENDIF.

* Raise event before_destroy.
  RAISE EVENT ev_before_destroy.

* Set self in destroy mode.
  g_destroy_mode = abap_true.

* Destroy.
  _destroy( ).

* We are destroyed.
  g_destroy_mode = abap_false.
  g_destroyed    = abap_true.

* Export.
  r_destroyed = abap_true.

* Raise event after_destroy.
  RAISE EVENT ev_after_destroy.

ENDMETHOD.


METHOD if_ish_destroyable~is_destroyed.

  r_destroyed = g_destroyed.

ENDMETHOD.


METHOD if_ish_destroyable~is_in_destroy_mode.

  r_destroy_mode = g_destroy_mode.

ENDMETHOD.


METHOD new_instance.

  DATA ls_mgr             LIKE LINE OF gt_mgr.

* Already exists?
  READ TABLE gt_mgr
    WITH TABLE KEY r_user = ir_user
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'NEW_INSTANCE'
        i_mv3        = 'CL_ISH_RS_MGR' ).
  ENDIF.

* Create the object.
  CREATE OBJECT rr_instance
    EXPORTING
      ir_user = ir_user.

* Register the object.
  ls_mgr-r_user = ir_user.
  ls_mgr-r_mgr  = rr_instance.
  INSERT ls_mgr INTO TABLE gt_mgr.

* Set the actual mgr.
  IF i_actual = abap_true.
    TRY.
        set_actual_instance( ir_mgr = rr_instance ).
      CLEANUP.
        DELETE TABLE gt_mgr
          WITH TABLE KEY r_user = ir_user.
    ENDTRY.
  ENDIF.

ENDMETHOD.


METHOD set_actual_instance.

  DATA lr_old_actual_mgr                    TYPE REF TO cl_ish_rs_mgr.

* Callback for actual user.
  IF gr_actual_mgr IS BOUND AND
     gr_actual_mgr->gr_user IS BOUND.
    IF gr_actual_mgr->gr_user->cb_set_actual_mgr( ir_new_actual_mgr = ir_mgr ) = abap_false.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'SET_ACTUAL_INSTANCE'
          i_mv3        = 'CL_ISH_RS_MGR' ).
    ENDIF.
  ENDIF.

* Set actual mgr.
  lr_old_actual_mgr = gr_actual_mgr.
  gr_actual_mgr = ir_mgr.

* Raise event.
  RAISE EVENT ev_actual_mgr_set
    EXPORTING
      er_old_actual_mgr = lr_old_actual_mgr
      er_new_actual_mgr = gr_actual_mgr.

ENDMETHOD.


METHOD _destroy.

* Deregister from gt_mgr.
  DELETE TABLE gt_mgr
    WITH TABLE KEY r_user = gr_user.

* Deregister from gr_actual_mgr.
  IF gr_actual_mgr = me.
    CLEAR gr_actual_mgr.
  ENDIF.

* Clear attributes.
  CLEAR gr_user.
  CLEAR gt_read_service.

ENDMETHOD.
ENDCLASS.
