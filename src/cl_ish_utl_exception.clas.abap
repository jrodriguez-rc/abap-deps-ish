class CL_ISH_UTL_EXCEPTION definition
  public
  abstract
  create public .

public section.

*"* public components of class CL_ISH_UTL_EXCEPTION
*"* do not include other source files here!!!
  class-methods CREATE_STATIC
    importing
      !I_TYP type SY-MSGTY optional
      !I_KLA type SY-MSGID optional
      !I_NUM type SY-MSGNO optional
      !I_MV1 type ANY optional
      !I_MV2 type ANY optional
      !I_MV3 type ANY optional
      !I_MV4 type ANY optional
      !I_PAR type BAPIRET2-PARAMETER optional
      !I_ROW type BAPIRET2-ROW optional
      !I_FIELD type BAPIRET2-FIELD optional
      !IR_OBJECT type NOBJECTREF optional
      !I_LINE_KEY type CHAR100 optional
      !IR_ERROR_OBJ type ref to CL_ISH_ERROR optional
      !IT_MESSAGES type ISHMED_T_MESSAGES optional
      !I_TN21M type ISH_ON_OFF default ' '
      !I_EINRI type EINRI optional
    returning
      value(RR_INSTANCE) type ref to CX_ISH_STATIC_HANDLER .
  class-methods CREATE_STATIC_BY_SYST
    importing
      !I_TYP type SY-MSGTY default SY-MSGTY
      !I_PAR type BAPIRET2-PARAMETER optional
      !I_ROW type BAPIRET2-ROW optional
      !I_FIELD type BAPIRET2-FIELD optional
      !IR_OBJECT type NOBJECTREF optional
      !I_LINE_KEY type CHAR100 optional
    returning
      value(RR_INSTANCE) type ref to CX_ISH_STATIC_HANDLER .
  class-methods RAISE_STATIC
    importing
      !I_TYP type SY-MSGTY optional
      !I_KLA type SY-MSGID optional
      !I_NUM type SY-MSGNO optional
      !I_MV1 type ANY optional
      !I_MV2 type ANY optional
      !I_MV3 type ANY optional
      !I_MV4 type ANY optional
      !I_PAR type BAPIRET2-PARAMETER optional
      !I_ROW type BAPIRET2-ROW optional
      !I_FIELD type BAPIRET2-FIELD optional
      !IR_OBJECT type NOBJECTREF optional
      !I_LINE_KEY type CHAR100 optional
      !IR_ERROR_OBJ type ref to CL_ISH_ERROR optional
      !IT_MESSAGES type ISHMED_T_MESSAGES optional
      !I_TN21M type ISH_ON_OFF default ' '
      !I_EINRI type EINRI optional
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods RAISE_STATIC_BY_SYST
    importing
      !I_TYP type SY-MSGTY default SY-MSGTY
      !I_PAR type BAPIRET2-PARAMETER optional
      !I_ROW type BAPIRET2-ROW optional
      !I_FIELD type BAPIRET2-FIELD optional
      !IR_OBJECT type NOBJECTREF optional
      !I_LINE_KEY type CHAR100 optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_UTL_EXCEPTION
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_EXCEPTION
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_EXCEPTION IMPLEMENTATION.


METHOD create_static.

  DATA:
    lr_errorhandler            TYPE REF TO cl_ishmed_errorhandling.

  CALL METHOD cl_ish_utl_base=>collect_messages
    EXPORTING
      i_typ           = i_typ
      i_kla           = i_kla
      i_num           = i_num
      i_mv1           = i_mv1
      i_mv2           = i_mv2
      i_mv3           = i_mv3
      i_mv4           = i_mv4
      i_par           = i_par
      i_row           = i_row
      i_field         = i_field
      ir_object       = ir_object
      i_line_key      = i_line_key
      ir_error_obj    = ir_error_obj
      it_messages     = it_messages
      i_tn21m         = i_tn21m           "MED-47677 Rares Roman
      I_einri         = i_einri           "MED-47677 Rares Roman
    CHANGING
      cr_errorhandler = lr_errorhandler.

  CREATE OBJECT rr_instance
    EXPORTING
      gr_errorhandler = lr_errorhandler
      gr_msgtyp       = i_typ.

ENDMETHOD.


METHOD create_static_by_syst .

  DATA:
    lr_errorhandler            TYPE REF TO cl_ishmed_errorhandling.

  CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
    EXPORTING
      i_typ           = i_typ
      i_par           = i_par
      i_row           = i_row
      i_field         = i_field
      ir_object       = ir_object
      i_line_key      = i_line_key
    CHANGING
      cr_errorhandler = lr_errorhandler.

  CREATE OBJECT rr_instance
    EXPORTING
      gr_errorhandler = lr_errorhandler
      gr_msgtyp       = i_typ.

ENDMETHOD.


METHOD raise_static.

  DATA:
    lx_static            TYPE REF TO cx_ish_static_handler.

  lx_static = create_static( i_typ        = i_typ
                             i_kla        = i_kla
                             i_num        = i_num
                             i_mv1        = i_mv1
                             i_mv2        = i_mv2
                             i_mv3        = i_mv3
                             i_mv4        = i_mv4
                             i_par        = i_par
                             i_row        = i_row
                             i_field      = i_field
                             ir_object    = ir_object
                             i_line_key   = i_line_key
                             ir_error_obj = ir_error_obj
                             it_messages  = it_messages
                             i_tn21m      = i_tn21m           "MED-47677 Rares Roman
                             i_einri      = i_einri           "MED-47677 Rares Roman
                             ).

  IF lx_static IS BOUND.
    RAISE EXCEPTION lx_static.
  ELSE.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

ENDMETHOD.


METHOD raise_static_by_syst .

  DATA:
    lx_static            TYPE REF TO cx_ish_static_handler.

  lx_static = create_static_by_syst( i_typ       = sy-msgty
                                     i_par       = i_par
                                     i_row       = i_row
                                     i_field     = i_field
                                     ir_object   = ir_object
                                     i_line_key  = i_line_key ).

  IF lx_static IS BOUND.
    RAISE EXCEPTION lx_static.
  ELSE.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

ENDMETHOD.
ENDCLASS.
