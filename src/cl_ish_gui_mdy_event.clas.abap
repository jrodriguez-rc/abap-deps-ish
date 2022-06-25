class CL_ISH_GUI_MDY_EVENT definition
  public
  inheriting from CL_ISH_GUI_EVENT_REQUEST
  create protected .

public section.
*"* public components of class CL_ISH_GUI_MDY_EVENT
*"* do not include other source files here!!!

  type-pools ABAP .
  class-methods CREATE
    importing
      !IR_SENDER type ref to IF_ISH_GUI_MDY_VIEW
      !I_UCOMM type SYUCOMM
      !I_IS_EXIT_COMMAND type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_MDY_EVENT .
  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_MDY_VIEW
      !I_UCOMM type SYUCOMM
      !I_IS_EXIT_COMMAND type ABAP_BOOL default ABAP_FALSE
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_UCOMM
  final
    returning
      value(R_UCOMM) type SYUCOMM .
  methods IS_EXIT_COMMAND
  final
    returning
      value(R_IS_EXIT_COMMAND) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_GUI_MDY_EVENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_MDY_EVENT
*"* do not include other source files here!!!

  data G_IS_EXIT_COMMAND type ABAP_BOOL .
  data G_UCOMM type SYUCOMM .
ENDCLASS.



CLASS CL_ISH_GUI_MDY_EVENT IMPLEMENTATION.


METHOD constructor.

  super->constructor( ir_sender = ir_sender ).

  g_ucomm           = i_ucomm.
  g_is_exit_command = i_is_exit_command.

ENDMETHOD.


METHOD create.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender         = ir_sender
          i_ucomm           = i_ucomm
          i_is_exit_command = i_is_exit_command.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_ucomm.

  r_ucomm = g_ucomm.

ENDMETHOD.


METHOD is_exit_command.

  r_is_exit_command = g_is_exit_command.

ENDMETHOD.
ENDCLASS.
