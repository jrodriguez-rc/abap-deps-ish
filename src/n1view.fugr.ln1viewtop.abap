FUNCTION-POOL n1view  MESSAGE-ID nf1.


*----------------------------------------------------------------------*
* Definition von TRUE, FALSE ...
*----------------------------------------------------------------------*
INCLUDE mndata00.
INCLUDE <icon>.

*----------------------------------------------------------------------*
* Tabledefinitionen
*----------------------------------------------------------------------*

TABLES: rn1_scr_view100.

*----------------------------------------------------------------------*
* Typdefinitionen
*----------------------------------------------------------------------*

TYPE-POOLS vrm.

* Felder des Dynpro 100 (alte Version - vor MED-29038)
TYPES: BEGIN OF ty_s100,
         viewtype     LIKE nwview-viewtype,
         sap_std      TYPE nwsap_std,
         cst_std      TYPE nwcst_std,
         viewid       LIKE nwview-viewid,
         viewidtxt    LIKE nwviewt-txt,
         zuo_txt      LIKE nwpvzt-txt,
         vdefault     LIKE nwpvz-vdefault,
         sortid       LIKE nwpvz-sortid,
         svarid       LIKE rnsvar-svariantid,
         svar_txt(40) TYPE c,
         avarid       LIKE rnavar-avariantid,
         avar_txt(40) TYPE c,
         fvarid       LIKE rnfvar-fvariantid,
         fvar_txt(40) TYPE c,
         rfsh         TYPE n_refresh,
         rfsh_int     TYPE n_refresh_interval,
       END OF ty_s100.

* Auszuschließende Funktionen des GUI-Status
TYPES: BEGIN OF ty_ex_fct,
         function(30) TYPE c,
       END OF ty_ex_fct.


*----------------------------------------------------------------------*
* Globale Tabellendefinitionen
*----------------------------------------------------------------------*

* Auszuschließende Funktionen des GUI-Status
DATA: gt_ex_fct  TYPE TABLE OF ty_ex_fct WITH HEADER LINE.

* Alle Zuordnungen des Arbeitsumfelds
DATA: gt_nwpvz   LIKE TABLE OF nwpvz.

* Übergebene, gepufferte Zuordnungen des Arbeitsumfelds (für Prüfungen)
DATA: gt_nwpvz_chk    LIKE TABLE OF v_nwpvz.


*----------------------------------------------------------------------
* Konstantendefinitionen
*----------------------------------------------------------------------
CONSTANTS: g_vcode_insert   TYPE ish_vcode  VALUE 'INS',
           g_vcode_update   TYPE ish_vcode  VALUE 'UPD',
           g_vcode_display  TYPE ish_vcode  VALUE 'DIS'.


*----------------------------------------------------------------------*
* Sonstige globale Datendefinitionen
*----------------------------------------------------------------------*
DATA: g_place              TYPE nwplace,
      g_view               TYPE nwview,
      g_vcode              TYPE ish_vcode,
      g_vcode_txt          TYPE ish_vcode,
      g_vcode_spec         TYPE ish_vcode,
      g_title_100(50)      TYPE c,
      g_place_zuo          LIKE off,
      g_chk_buffer         LIKE off,
      g_first_time_100     LIKE off,
*      g_first_time_warning LIKE off,
      g_error              LIKE off,
      g_save_ok_code       LIKE ok-code,
      g_v_nwview           TYPE v_nwview,                   "#EC NEEDED
      g_viewvar            TYPE rnviewvar,
      g_viewvar_old        LIKE rnviewvar,
      gs_refresh           TYPE rnrefresh,
      gs_refresh_old       TYPE rnrefresh,
      g_zuo_txt            LIKE nwpvzt-txt,
      g_view_txt           LIKE nwviewt-txt,
      g_view_txt_old       LIKE nwviewt-txt,
      g_view_sap_std       TYPE nwsap_std,
      g_view_cst_std       TYPE nwcst_std,
      g_vdefault           LIKE nwpvz-vdefault,
      g_sortid             LIKE nwpvz-sortid,
      g_ishmed_used        TYPE i VALUE false,
      g_system_sap         LIKE off,
      g_placetype_pg       TYPE nwview_014-nwplacetype_pg,
      g_placeid_pg         TYPE nwview_014-nwplaceid_pg,
      g_placetype_pg_old   TYPE nwview_014-nwplacetype_pg,
      g_placeid_pg_old     TYPE nwview_014-nwplaceid_pg.

* Felder für Dynpro 100  (alte Version - vor MED-29038)
DATA: s100                 TYPE ty_s100.

*
