class CL_ISH_GUI_DYNPRO_HELP_EVENT definition
  public
  inheriting from CL_ISH_GUI_DYNPRO_EVENT
  create protected .

public section.
*"* public components of class CL_ISH_GUI_DYNPRO_HELP_EVENT
*"* do not include other source files here!!!

  constants CO_PROCBLOCK_HELP_REQUEST type N1GUI_DYNP_PROCBLOCK value 'F1'. "#EC NOTEXT

  class-methods CREATE_DYNPRO_HELP_EVENT
    importing
      !IR_SENDER type ref to IF_ISH_GUI_DYNPRO_VIEW
      !I_FIELDNAME type ISH_FIELDNAME optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_DYNPRO_HELP_EVENT .
  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_DYNPRO_VIEW
      !I_FIELDNAME type ISH_FIELDNAME optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_FIELDNAME
  final
    returning
      value(R_FIELDNAME) type ISH_FIELDNAME .
protected section.
*"* protected components of class CL_ISH_GUI_DYNPRO_VALUE_EVENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_DYNPRO_HELP_EVENT
*"* do not include other source files here!!!

  data G_FIELDNAME type ISH_FIELDNAME .
ENDCLASS.



CLASS CL_ISH_GUI_DYNPRO_HELP_EVENT IMPLEMENTATION.


METHOD constructor.

  super->constructor( ir_sender          = ir_sender
                      i_processing_block = co_procblock_help_request ).

  g_fieldname = i_fieldname.

  IF g_fieldname IS INITIAL.
    GET CURSOR FIELD g_fieldname.
  ENDIF.

ENDMETHOD.


METHOD create_dynpro_help_event.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender   = ir_sender
          i_fieldname = i_fieldname.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_fieldname.

  r_fieldname = g_fieldname.

ENDMETHOD.
ENDCLASS.
