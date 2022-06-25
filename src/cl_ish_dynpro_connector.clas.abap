class CL_ISH_DYNPRO_CONNECTOR definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_DYNPRO_CONNECTOR
*"* do not include other source files here!!!

  interfaces IF_ISH_DYNPRO_CONNECTOR .

  aliases CONNECT
    for IF_ISH_DYNPRO_CONNECTOR~CONNECT .
  aliases CONNECT_FREE
    for IF_ISH_DYNPRO_CONNECTOR~CONNECT_FREE .
  aliases DISCONNECT
    for IF_ISH_DYNPRO_CONNECTOR~DISCONNECT .
  aliases GET_REPID
    for IF_ISH_DYNPRO_CONNECTOR~GET_REPID .
  aliases GET_SCREEN_FOR_DYNPRO
    for IF_ISH_DYNPRO_CONNECTOR~GET_SCREEN_FOR_DYNPRO .

  methods CONSTRUCTOR
    importing
      !I_REPID type REPID
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  class-methods CREATE_GENERATE
    importing
      !I_REPID type REPID
      !I_REGISTER type ABAP_BOOL default ABAP_TRUE
    returning
      value(RR_CONNECTOR) type ref to CL_ISH_DYNPRO_CONNECTOR
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_INTERVAL
    importing
      !I_REPID type REPID
      !I_DYNNR_FROM type RI_DYNNR
      !I_DYNNR_TO type RI_DYNNR
      !I_REGISTER type ABAP_BOOL default ABAP_TRUE
    returning
      value(RR_CONNECTOR) type ref to CL_ISH_DYNPRO_CONNECTOR
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_SINGLE
    importing
      !I_REPID type REPID
      !I_DYNNR type RI_DYNNR
      !I_REGISTER type ABAP_BOOL default ABAP_TRUE
    returning
      value(RR_CONNECTOR) type ref to CL_ISH_DYNPRO_CONNECTOR
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_TABLE
    importing
      !I_REPID type REPID
      !IT_DYNNR type ISH_T_DYNNR
      !I_REGISTER type ABAP_BOOL default ABAP_TRUE
    returning
      value(RR_CONNECTOR) type ref to CL_ISH_DYNPRO_CONNECTOR
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_DYNPRO_CONNECTOR
*"* do not include other source files here!!!

  data G_REPID type REPID .
  data GT_SCREEN type ISH_T_DYNNR_SCREEN .
private section.
*"* private components of class CL_ISH_DYNPRO_CONNECTOR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DYNPRO_CONNECTOR IMPLEMENTATION.


METHOD constructor.

  IF i_repid IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  g_repid = i_repid.

ENDMETHOD.


METHOD create_generate.

  DATA: lt_d020s  TYPE TABLE OF d020s,
        lt_dynnr  TYPE ish_t_dynnr.

  FIELD-SYMBOLS: <ls_d020s>  LIKE LINE OF lt_d020s.

  SELECT * FROM d020s INTO TABLE lt_d020s WHERE prog = i_repid.
  IF sy-subrc = 0.
    LOOP AT lt_d020s ASSIGNING <ls_d020s>.
      APPEND <ls_d020s>-dnum TO lt_dynnr.
    ENDLOOP.
  ENDIF.

  rr_connector = create_table( i_repid    = i_repid
                               it_dynnr   = lt_dynnr
                               i_register = i_register ).

ENDMETHOD.


METHOD create_interval.

  DATA: ls_screen      TYPE rn1_dynnr_screen.

  IF i_repid      IS INITIAL OR
     i_dynnr_from IS INITIAL OR
     i_dynnr_to   IS INITIAL OR
     i_dynnr_from > i_dynnr_to.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  CREATE OBJECT rr_connector
    EXPORTING
    i_repid = i_repid.

  CLEAR: ls_screen.
  ls_screen-dynnr = i_dynnr_from.
  WHILE ls_screen-dynnr <= i_dynnr_to.
    INSERT ls_screen INTO TABLE rr_connector->gt_screen.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_ish_static_handler.
    ENDIF.
    ls_screen-dynnr = ls_screen-dynnr + 1.
  ENDWHILE.

  IF i_register = abap_true.
    IF cl_ish_dynpconn_mgr=>register_connector( rr_connector ) = abap_false.
      RAISE EXCEPTION TYPE cx_ish_static_handler.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD create_single.

  DATA: ls_screen  TYPE rn1_dynnr_screen.

  IF i_repid IS INITIAL OR
     i_dynnr IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  CREATE OBJECT rr_connector
    EXPORTING
    i_repid = i_repid.

  CLEAR: ls_screen.
  ls_screen-dynnr = i_dynnr.
  INSERT ls_screen INTO TABLE rr_connector->gt_screen.
  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  IF i_register = abap_true.
    IF cl_ish_dynpconn_mgr=>register_connector( rr_connector ) = abap_false.
      RAISE EXCEPTION TYPE cx_ish_static_handler.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD create_table.

  DATA: ls_screen      TYPE rn1_dynnr_screen.

  FIELD-SYMBOLS: <l_dynnr>  LIKE LINE OF it_dynnr.

  IF i_repid  IS INITIAL OR
     it_dynnr IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  CREATE OBJECT rr_connector
    EXPORTING
    i_repid = i_repid.

  CLEAR: ls_screen.
  LOOP AT it_dynnr ASSIGNING <l_dynnr>.
    ls_screen-dynnr = <l_dynnr>.
    INSERT ls_screen INTO TABLE rr_connector->gt_screen.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_ish_static_handler.
    ENDIF.
  ENDLOOP.

  IF i_register = abap_true.
    IF cl_ish_dynpconn_mgr=>register_connector( rr_connector ) = abap_false.
      RAISE EXCEPTION TYPE cx_ish_static_handler.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD if_ish_dynpro_connector~connect.

  DATA: l_clsname        TYPE string,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  FIELD-SYMBOLS: <ls_screen>  LIKE LINE OF gt_screen.

  rs_parent-repid = g_repid.
  rs_parent-type  = if_ish_scr_constants=>co_scr_parent_type_dynpro.

  DO 1 TIMES.
    CHECK ir_screen IS BOUND.
    READ TABLE gt_screen WITH TABLE KEY dynnr = i_dynnr ASSIGNING <ls_screen>.
    CHECK sy-subrc = 0.
    IF i_overwrite = abap_false.
      CHECK <ls_screen>-r_screen IS NOT BOUND OR
            <ls_screen>-r_screen = ir_screen.
    ENDIF.
    <ls_screen>-r_screen = ir_screen.
    rs_parent-dynnr = i_dynnr.
  ENDDO.

  IF rs_parent-dynnr IS INITIAL.
    IF ir_screen IS BOUND.
      l_clsname = cl_ish_utl_rtti=>get_class_name( ir_screen ).
    ELSE.
      l_clsname = '<UNKNOWN>'.
    ENDIF.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '123'
        i_mv1           = l_clsname
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
    EXPORTING
    gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD if_ish_dynpro_connector~connect_free.

  DATA: l_clsname        TYPE string,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  FIELD-SYMBOLS: <ls_screen>  LIKE LINE OF gt_screen.

  rs_parent-repid = g_repid.
  rs_parent-type  = if_ish_scr_constants=>co_scr_parent_type_dynpro.

  DO 1 TIMES.
    CHECK ir_screen IS BOUND.
    LOOP AT gt_screen ASSIGNING <ls_screen>
            WHERE dynnr >= i_dynnr_from AND
                  dynnr <= i_dynnr_to.
      CHECK <ls_screen>-r_screen IS NOT BOUND.
      <ls_screen>-r_screen = ir_screen.
      rs_parent-dynnr = <ls_screen>-dynnr.
      EXIT.
    ENDLOOP.
  ENDDO.

  IF rs_parent-dynnr IS INITIAL.
    IF ir_screen IS BOUND.
      l_clsname = cl_ish_utl_rtti=>get_class_name( ir_screen ).
    ELSE.
      l_clsname = '<UNKNOWN>'.
    ENDIF.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '123'
        i_mv1           = l_clsname
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
    EXPORTING
    gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD if_ish_dynpro_connector~disconnect.

  FIELD-SYMBOLS: <ls_screen>  LIKE LINE OF gt_screen.

  READ TABLE gt_screen WITH TABLE KEY dynnr = i_dynnr ASSIGNING <ls_screen>.
  CHECK sy-subrc = 0.

  rr_screen = <ls_screen>-r_screen.

  CLEAR: <ls_screen>-r_screen.

ENDMETHOD.


METHOD if_ish_dynpro_connector~get_embedded_dynpro.

  DATA: lr_screen            TYPE REF TO if_ish_screen,
        lr_embedded_screen   TYPE REF TO if_ish_screen.

  rs_parent-type  = if_ish_scr_constants=>co_scr_parent_type_dynpro.
  rs_parent-repid = 'SAPLN1SC'.
  rs_parent-dynnr = '0001'.

  lr_screen = get_screen_for_dynpro( i_dynnr ).
  CHECK lr_screen IS BOUND.

  lr_embedded_screen = lr_screen->get_fieldval_screen( i_fieldname = i_fieldname ).
  CHECK lr_embedded_screen IS BOUND.

  CALL METHOD lr_embedded_screen->get_parent                "MED-34863
*  CALL METHOD lr_screen->get_parent                        "MED-34863
    IMPORTING
      es_parent = rs_parent.

ENDMETHOD.


METHOD if_ish_dynpro_connector~get_repid.

  r_repid = g_repid.

ENDMETHOD.


METHOD if_ish_dynpro_connector~get_screen_for_dynpro.

  FIELD-SYMBOLS: <ls_screen>  LIKE LINE OF gt_screen.

  READ TABLE gt_screen WITH TABLE KEY dynnr = i_dynnr ASSIGNING <ls_screen>.
  CHECK sy-subrc = 0.

  rr_screen = <ls_screen>-r_screen.

ENDMETHOD.


METHOD if_ish_dynpro_connector~process_f1.

  DATA: lr_screen        TYPE REF TO if_ish_screen,
        l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  lr_screen = get_screen_for_dynpro( i_dynnr ).
  CHECK lr_screen IS BOUND.

  CALL METHOD lr_screen->help_request
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

  IF l_rc <> 0 OR
     lr_errorhandler IS BOUND.
    lr_screen->raise_ev_error( ir_errorhandler = lr_errorhandler ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dynpro_connector~process_f4.

  DATA: lr_screen        TYPE REF TO if_ish_screen,
        l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  lr_screen = get_screen_for_dynpro( i_dynnr ).
  CHECK lr_screen IS BOUND.

  CALL METHOD lr_screen->value_request
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

  IF l_rc <> 0 OR
     lr_errorhandler IS BOUND.
    lr_screen->raise_ev_error( ir_errorhandler = lr_errorhandler ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dynpro_connector~process_pai.

  DATA: lr_screen        TYPE REF TO if_ish_screen,
        l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  lr_screen = get_screen_for_dynpro( i_dynnr ).
  CHECK lr_screen IS BOUND.

  CALL METHOD lr_screen->process_after_input
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

  IF l_rc <> 0 OR
     lr_errorhandler IS BOUND.
    lr_screen->raise_ev_error( ir_errorhandler = lr_errorhandler ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_dynpro_connector~process_pbo.

  DATA: lr_screen        TYPE REF TO if_ish_screen,
        l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  lr_screen = get_screen_for_dynpro( i_dynnr ).
  CHECK lr_screen IS BOUND.

  CALL METHOD lr_screen->process_before_output
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

  IF l_rc <> 0 OR
     lr_errorhandler IS BOUND.
    lr_screen->raise_ev_error( ir_errorhandler = lr_errorhandler ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
