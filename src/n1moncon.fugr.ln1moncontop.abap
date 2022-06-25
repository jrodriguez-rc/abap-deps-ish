FUNCTION-POOL n1moncon   MESSAGE-ID n1base.

INCLUDE mndata00.

DATA: gr_container       TYPE REF TO cl_gui_custom_container,
      gr_complstage_grid TYPE REF TO cl_ish_complstage_grid,
      gr_moncon          TYPE REF TO cl_ish_moncon,
      g_vcode            TYPE ish_vcode,
      g_title            TYPE string,
      g_name             TYPE n1moncon_name,
      g_save             TYPE ish_on_off,
      g_commit           TYPE ish_on_off,
      g_update_task      TYPE ish_on_off,
      g_cancelled        TYPE ish_on_off,
      g_saved            TYPE ish_on_off.

*
