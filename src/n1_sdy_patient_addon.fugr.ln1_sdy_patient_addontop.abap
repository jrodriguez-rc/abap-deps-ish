FUNCTION-POOL n1_sdy_patient_addon.


INCLUDE mndata00.


CONSTANTS:
  co_dynpg_dummy  TYPE sy-repid VALUE 'SAPLN1_SDY_PATIENT_ADDON',
  co_dynnr_dummy  TYPE sy-dynnr VALUE '0110'.

DATA: g_dynpg_patient  TYPE sy-repid,
      g_dynnr_patient  TYPE sy-dynnr,
      g_dynpg_addon    TYPE sy-repid,
      g_dynnr_addon    TYPE sy-dynnr.

DATA: gr_scr_patient_addon  TYPE REF TO cl_ish_scr_patient_addon.
