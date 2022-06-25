FUNCTION-POOL n1_mdy_gui_appl_settings.     "MESSAGE-ID ..

* INCLUDE LN1_MDY_GUI_APPL_SETTINGSD...      " Local class definition


CONSTANTS:
  co_repid_0100               TYPE sy-repid VALUE 'SAPLN1_MDY_GUI_APPL_SETTINGS'.

DATA:
  g_ucomm_0100                TYPE sy-ucomm,
  g_repid_sc_settings_0100    TYPE sy-repid VALUE 'SAPLN1SC',
  g_dynnr_sc_settings_0100    TYPE sy-dynnr VALUE '0001'.
