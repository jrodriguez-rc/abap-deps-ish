class CL_ISH_GUI_DYNPRO_EVENT definition
  public
  inheriting from CL_ISH_GUI_EVENT_REQUEST
  create protected .

*"* public components of class CL_ISH_GUI_DYNPRO_EVENT
*"* do not include other source files here!!!
public section.

  constants CO_PROCBLOCK_AFTER_PAI type N1GUI_DYNP_PROCBLOCK value 'AFTER_PAI'. "#EC NOTEXT
  constants CO_PROCBLOCK_AFTER_PBO type N1GUI_DYNP_PROCBLOCK value 'AFTER_PBO'. "#EC NOTEXT
  constants CO_PROCBLOCK_BEFORE_PAI type N1GUI_DYNP_PROCBLOCK value 'BEFORE_PAI'. "#EC NOTEXT
  constants CO_PROCBLOCK_BEFORE_PBO type N1GUI_DYNP_PROCBLOCK value 'BEFORE_PBO'. "#EC NOTEXT

  class-methods CREATE
    importing
      !IR_SENDER type ref to IF_ISH_GUI_DYNPRO_VIEW
      !I_PROCESSING_BLOCK type N1GUI_DYNP_PROCBLOCK
      !I_UCOMM type SYUCOMM optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_DYNPRO_EVENT .
  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_DYNPRO_VIEW
      !I_PROCESSING_BLOCK type N1GUI_DYNP_PROCBLOCK
      !I_UCOMM type SYUCOMM optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DYNPRO_VIEW
  final
    returning
      value(RR_DYNPRO_VIEW) type ref to IF_ISH_GUI_DYNPRO_VIEW .
  methods GET_PROCESSING_BLOCK
  final
    returning
      value(R_PROCESSING_BLOCK) type N1GUI_DYNP_PROCBLOCK .
  methods GET_UCOMM
    returning
      value(R_UCOMM) type SYUCOMM .
protected section.
*"* protected components of class CL_ISH_GUI_DYNPRO_EVENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_DYNPRO_EVENT
*"* do not include other source files here!!!

  data G_PROCESSING_BLOCK type N1GUI_DYNP_PROCBLOCK .
  data G_UCOMM type SYUCOMM .
ENDCLASS.



CLASS CL_ISH_GUI_DYNPRO_EVENT IMPLEMENTATION.


METHOD constructor.

  IF i_processing_block IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  super->constructor( ir_sender = ir_sender ).

  g_processing_block  = i_processing_block.
  g_ucomm             = i_ucomm.

ENDMETHOD.


METHOD create.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender          = ir_sender
          i_processing_block = i_processing_block
          i_ucomm            = i_ucomm.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_dynpro_view.

  TRY.
      rr_dynpro_view ?= get_sender( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_processing_block.

  r_processing_block = g_processing_block.

ENDMETHOD.


METHOD get_ucomm.

  r_ucomm = g_ucomm.

ENDMETHOD.
ENDCLASS.
