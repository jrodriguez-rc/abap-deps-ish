class CL_ISH_RS_OBJECT definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_RS_OBJECT
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_RS_OBJECT
      final methods GET_READ_SERVICE .

  aliases GET_READ_SERVICE
    for IF_ISH_RS_OBJECT~GET_READ_SERVICE .

  methods CONSTRUCTOR
    importing
      !IR_READ_SERVICE type ref to IF_ISH_RS_READ_SERVICE
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_RS_OBJECT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_RS_OBJECT
*"* do not include other source files here!!!

  data GR_READ_SERVICE type ref to IF_ISH_RS_READ_SERVICE .
ENDCLASS.



CLASS CL_ISH_RS_OBJECT IMPLEMENTATION.


METHOD constructor.

  IF ir_read_service IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_RS_OBJECT' ).
  ENDIF.

  gr_read_service = ir_read_service.

ENDMETHOD.


METHOD if_ish_rs_object~get_read_service.

  rr_read_service = gr_read_service.

ENDMETHOD.
ENDCLASS.
