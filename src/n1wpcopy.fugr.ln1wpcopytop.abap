FUNCTION-POOL n1wpcopy   MESSAGE-ID nf1.

* includes
INCLUDE mndata00.


* global data


*-----------------------------------------------------------------------
* datadefinition for popups
*-----------------------------------------------------------------------

DATA: g_ptitel       TYPE char40,             " Titel des Popups
      g_pvcode       LIKE tndym-vcode,        " Verarbeitungscode
      g_ok_code      LIKE ok-code,            " OK-Code im Popup
      g_type         TYPE char1,              " Variantentyp
      g_text_allg    TYPE char50,             " Allg. Bezeichnung
      g_text_svar    TYPE raldb_vtxt,         " Selektionsvariantenbez.
      g_text_avar    TYPE slis_varbz,         " Layoutbezeichnung
      g_text_fvar    TYPE nwfvartxt,          " Funktionsvariantenbez.
      g_text_place   TYPE nwplacetxt,         " Bezeichnung Arb. Umf.
      g_text_view    TYPE nviewstxt,          " Bezeichnung Sicht
      g_text_view_sv TYPE nviewstxt,          " Bezeichnung Sicht (Save)
      g_check_text   TYPE ish_on_off,         " Text prüfen
*     radiobutton - copy workplace
      g_rb_p         TYPE n_wp_rb_p,
*     radiobutton - copy workplace + views
      g_rb_pv        TYPE n_wp_rb_pv,
*     radiobutton - copy workplace + views + variants
      g_rb_pvv       TYPE n_wp_rb_pvv,
*     radiobutton - copy views
      g_rb_v         TYPE n_wp_rb_v,
*     radiobutton - copy views + variants
      g_rb_vv        TYPE n_wp_rb_vv.
*
