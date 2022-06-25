FUNCTION ish_sdy_patient_addon_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_PATIENT_ADDON) TYPE REF TO
*"        CL_ISH_SCR_PATIENT_ADDON
*"  EXPORTING
*"     REFERENCE(ER_DYNPG_PATIENT) TYPE REF TO  DATA
*"     REFERENCE(ER_DYNNR_PATIENT) TYPE REF TO  DATA
*"     REFERENCE(ER_DYNPG_ADDON) TYPE REF TO  DATA
*"     REFERENCE(ER_DYNNR_ADDON) TYPE REF TO  DATA
*"----------------------------------------------------------------------


* Remember the screen object.
  gr_scr_patient_addon = ir_scr_patient_addon.

* Export dynpg + dynnr references.
  GET REFERENCE OF g_dynpg_patient INTO er_dynpg_patient.
  GET REFERENCE OF g_dynnr_patient INTO er_dynnr_patient.
  GET REFERENCE OF g_dynpg_addon   INTO er_dynpg_addon.
  GET REFERENCE OF g_dynnr_addon   INTO er_dynnr_addon.


ENDFUNCTION.
