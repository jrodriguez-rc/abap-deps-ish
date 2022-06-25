FUNCTION ish_sdy_compcon_ga_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCREEN) TYPE REF TO  IF_ISH_SCREEN
*"  EXPORTING
*"     REFERENCE(ER_REPID_SC_GA) TYPE REF TO  DATA
*"     REFERENCE(ER_DYNNR_SC_GA) TYPE REF TO  DATA
*"----------------------------------------------------------------------

  gr_screen = ir_screen.

  GET REFERENCE OF g_repid_sc_ga  INTO er_repid_sc_ga.
  GET REFERENCE OF g_dynnr_sc_ga  INTO er_dynnr_sc_ga.

ENDFUNCTION.
