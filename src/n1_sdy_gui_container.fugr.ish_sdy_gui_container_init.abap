FUNCTION ish_sdy_gui_container_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_GUI_CONTAINER) TYPE REF TO
*"        CL_ISH_SCR_GUI_CONTAINER
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------


  gr_scr_gui_container = ir_scr_gui_container.


ENDFUNCTION.
