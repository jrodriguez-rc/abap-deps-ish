class CL_ISH_DYNPCONN_MGR definition
  public
  final
  create private .

public section.
*"* public components of class CL_ISH_DYNPCONN_MGR
*"* do not include other source files here!!!

  type-pools ABAP .
  class-methods CONNECT_SCREEN
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR
      !I_OVERWRITE type ABAP_BOOL default ABAP_FALSE
    exporting
      !ES_PARENT type RNSCR_PARENT
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CONNECT_SCREEN_FREE
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      !I_REPID type SY-REPID
      !I_DYNNR_FROM type SY-DYNNR default '0000'
      !I_DYNNR_TO type SY-DYNNR default '9999'
    exporting
      !ES_PARENT type RNSCR_PARENT
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods DISCONNECT_SCREEN
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
    returning
      value(R_DISCONNECTED) type ABAP_BOOL .
  class-methods GET_CONNECTOR
    importing
      !I_REPID type REPID
    returning
      value(RR_CONNECTOR) type ref to IF_ISH_DYNPRO_CONNECTOR .
  class-methods GET_EMBEDDED_DYNPRO
    importing
      !I_REPID type REPID
      !I_DYNNR type RI_DYNNR default SY-DYNNR
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(RS_PARENT) type RNSCR_PARENT .
  class-methods GET_OR_CREATE_CONNECTOR
    importing
      !I_REPID type REPID
    returning
      value(RR_CONNECTOR) type ref to IF_ISH_DYNPRO_CONNECTOR
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods GET_SCREEN_FOR_DYNPRO
    importing
      !I_REPID type REPID
      !I_DYNNR type RI_DYNNR
    returning
      value(RR_SCREEN) type ref to IF_ISH_SCREEN .
  class-methods PROCESS_F1
    importing
      !I_REPID type REPID
      !I_DYNNR type RI_DYNNR default SY-DYNNR .
  class-methods PROCESS_F4
    importing
      !I_REPID type REPID
      !I_DYNNR type RI_DYNNR default SY-DYNNR .
  class-methods PROCESS_PAI
    importing
      !I_REPID type REPID
      !I_DYNNR type RI_DYNNR default SY-DYNNR .
  class-methods PROCESS_PBO
    importing
      !I_REPID type REPID
      !I_DYNNR type RI_DYNNR default SY-DYNNR .
  class-methods REGISTER_CONNECTOR
    importing
      !IR_CONNECTOR type ref to IF_ISH_DYNPRO_CONNECTOR
    returning
      value(R_REGISTERED) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_DYNPCONN_MGR
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DYNPCONN_MGR
*"* do not include other source files here!!!

  class-data GT_CONNECTOR type ISH_T_DYNPCONN_HASH .
ENDCLASS.



CLASS CL_ISH_DYNPCONN_MGR IMPLEMENTATION.


METHOD connect_screen.

  DATA: lr_connector  TYPE REF TO if_ish_dynpro_connector,
        lx_root       TYPE REF TO cx_root.

  CLEAR: es_parent,
         e_rc.

  es_parent-repid = 'SAPLN1SC'.
  es_parent-dynnr = '0001'.
  es_parent-type  = if_ish_scr_constants=>co_scr_parent_type_dynpro.

  TRY.
      lr_connector = cl_ish_dynpconn_mgr=>get_or_create_connector( i_repid ).
      es_parent = lr_connector->connect( ir_screen   = ir_screen
                                         i_dynnr     = i_dynnr
                                         i_overwrite = i_overwrite ).
    CATCH cx_root INTO lx_root.
      e_rc = 1.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
        EXPORTING
          i_exceptions    = lx_root
        CHANGING
          cr_errorhandler = cr_errorhandler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD connect_screen_free.

  DATA: lr_connector  TYPE REF TO if_ish_dynpro_connector,
        lx_root       TYPE REF TO cx_root.

  CLEAR: es_parent,
         e_rc.

  es_parent-repid = 'SAPLN1SC'.
  es_parent-dynnr = '0001'.
  es_parent-type  = if_ish_scr_constants=>co_scr_parent_type_dynpro.

  TRY.
      lr_connector = cl_ish_dynpconn_mgr=>get_or_create_connector( i_repid ).
      es_parent = lr_connector->connect_free( ir_screen    = ir_screen
                                              i_dynnr_from = i_dynnr_from
                                              i_dynnr_to   = i_dynnr_to ).
    CATCH cx_root INTO lx_root.
      e_rc = 1.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
        EXPORTING
          i_exceptions    = lx_root
        CHANGING
          cr_errorhandler = cr_errorhandler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD disconnect_screen.

  DATA: lr_connector  TYPE REF TO if_ish_dynpro_connector,
        ls_parent     TYPE rnscr_parent.

  CHECK ir_screen IS BOUND.

  IF i_repid IS NOT SUPPLIED OR
     i_dynnr IS NOT SUPPLIED.
    CALL METHOD ir_screen->get_parent
      IMPORTING
        es_parent = ls_parent.
  ENDIF.

  IF i_repid IS SUPPLIED.
    ls_parent-repid = i_repid.
  ENDIF.
  lr_connector = cl_ish_dynpconn_mgr=>get_connector( ls_parent-repid ).
  CHECK lr_connector IS BOUND.

  IF i_dynnr IS SUPPLIED.
    ls_parent-dynnr = i_dynnr.
  ENDIF.
  CHECK lr_connector->disconnect( ls_parent-dynnr ) IS BOUND.

  r_disconnected = abap_true.

ENDMETHOD.


METHOD get_connector.

  FIELD-SYMBOLS: <ls_connector>  LIKE LINE OF gt_connector.

  READ TABLE gt_connector
    WITH TABLE KEY repid = i_repid
    ASSIGNING <ls_connector>.
  CHECK sy-subrc = 0.

  rr_connector = <ls_connector>-r_connector.

ENDMETHOD.


METHOD get_embedded_dynpro.

  DATA: lr_connector  TYPE REF TO if_ish_dynpro_connector.

  rs_parent-type  = if_ish_scr_constants=>co_scr_parent_type_dynpro.
  rs_parent-repid = 'SAPLN1SC'.
  rs_parent-dynnr = '0001'.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  rs_parent = lr_connector->get_embedded_dynpro( i_dynnr     = i_dynnr
                                                 i_fieldname = i_fieldname ).

ENDMETHOD.


METHOD get_or_create_connector.

  FIELD-SYMBOLS: <ls_connector>  LIKE LINE OF gt_connector.

  READ TABLE gt_connector
    WITH TABLE KEY repid = i_repid
    ASSIGNING <ls_connector>.

  IF sy-subrc = 0.
    rr_connector = <ls_connector>-r_connector.
    EXIT.
  ENDIF.

  rr_connector = cl_ish_dynpro_connector=>create_generate( i_repid    = i_repid
                                                           i_register = abap_true ).

ENDMETHOD.


METHOD get_screen_for_dynpro.

  DATA: lr_connector  TYPE REF TO if_ish_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  rr_screen = lr_connector->get_screen_for_dynpro( i_dynnr = i_dynnr ).

ENDMETHOD.


METHOD process_f1.

  DATA: lr_connector  TYPE REF TO if_ish_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  lr_connector->process_f1( i_dynnr ).

ENDMETHOD.


METHOD process_f4.

  DATA: lr_connector  TYPE REF TO if_ish_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  lr_connector->process_f4( i_dynnr ).

ENDMETHOD.


METHOD process_pai.

  DATA: lr_connector  TYPE REF TO if_ish_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  lr_connector->process_pai( i_dynnr ).

ENDMETHOD.


METHOD process_pbo.

  DATA: lr_connector  TYPE REF TO if_ish_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  lr_connector->process_pbo( i_dynnr ).

ENDMETHOD.


METHOD register_connector.

  DATA: ls_connector  LIKE LINE OF gt_connector.

  r_registered = abap_false.

  CHECK ir_connector IS BOUND.

  CLEAR: ls_connector.
  ls_connector-repid       = ir_connector->get_repid( ).
  ls_connector-r_connector = ir_connector.

  INSERT ls_connector INTO TABLE gt_connector.
  CHECK sy-subrc = 0.

  r_registered = abap_true.

ENDMETHOD.
ENDCLASS.
