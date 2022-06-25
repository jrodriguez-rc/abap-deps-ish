FUNCTION ish_sdy_pushbutton_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_PUSHBUTTON) TYPE REF TO  CL_ISH_SCR_PUSHBUTTON
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------


  gr_screen = ir_scr_pushbutton.


ENDFUNCTION.
