FUNCTION ish_sdy_popup_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_PROCESS) TYPE REF TO  IF_ISH_PRC_POPUP
*"  EXPORTING
*"     REFERENCE(ER_OKCODE) TYPE REF TO  DATA
*"     REFERENCE(ER_PARENT_SUBSCREEN) TYPE REF TO  DATA
*"     REFERENCE(ER_FUNC_01) TYPE REF TO  DATA
*"     REFERENCE(ER_FUNC_02) TYPE REF TO  DATA
*"     REFERENCE(ER_FUNC_03) TYPE REF TO  DATA
*"----------------------------------------------------------------------



* Remember the process object.
  gr_process = ir_process.

* Export.
  GET REFERENCE OF ok_code             INTO er_okcode.
  GET REFERENCE OF gs_parent_subscreen INTO er_parent_subscreen.

* Dynamic functions
  get reference of gs_func_01          into er_func_01.
  get reference of gs_func_02          into er_func_02.
  get reference of gs_func_03          into er_func_03.

ENDFUNCTION.
