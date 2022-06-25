FUNCTION-POOL n1workplace MESSAGE-ID nf1.

*----------------------------------------------------------------------*
* Definition von TRUE, FALSE ...
*----------------------------------------------------------------------*
INCLUDE mndata00.


*----------------------------------------------------------------------
* Typdefinitioen
*----------------------------------------------------------------------
*TYPE-POOLS: kkblo.
TYPE-POOLS: ustyp.

* Definition for list box
TYPE-POOLS vrm.


TYPES: BEGIN OF ty_placeid,
         wplacetype LIKE nwplace-wplacetype,
         wplaceid   LIKE nwplace-wplaceid,
       END OF ty_placeid.

TYPES: BEGIN OF ty_viewid,
         viewtype LIKE nwview-viewtype,
         viewid   LIKE nwview-viewid,
       END OF ty_viewid.

TYPES: BEGIN OF ty_viewid_only,
         viewid   LIKE nwview-viewid,
       END OF ty_viewid_only.

* Puffer für Selektionsvarianten
TYPES: BEGIN OF ty_selvarbuf.
INCLUDE TYPE ty_viewid.
INCLUDE TYPE ty_placeid.
INCLUDE TYPE rnsvar.
        INCLUDE STRUCTURE rsparams.
TYPES: END OF ty_selvarbuf.

* Anzeigevariantenpuffer
TYPES: BEGIN OF ty_dispvarbuf.
INCLUDE TYPE ty_viewid.
INCLUDE TYPE rnavar.
INCLUDE TYPE lvc_s_fcat.
TYPES: END OF ty_dispvarbuf.
TYPES: BEGIN OF ty_dispsortbuf.
INCLUDE TYPE ty_viewid.
INCLUDE TYPE lvc_s_sort.
TYPES: END OF ty_dispsortbuf.
TYPES: BEGIN OF ty_dispfiltbuf.
INCLUDE TYPE ty_viewid.
INCLUDE TYPE lvc_s_filt.
TYPES: END OF ty_dispfiltbuf.
TYPES: BEGIN OF ty_layoutbuf.
INCLUDE TYPE ty_viewid.
INCLUDE TYPE lvc_s_layo.
TYPES: END OF ty_layoutbuf.


* Funktionsvariantenpuffer
TYPES: BEGIN OF ty_fvarbuf.
INCLUDE TYPE ty_viewid_only.
INCLUDE TYPE rnfvar.
        INCLUDE STRUCTURE v_nwfvar.
TYPES: END OF ty_fvarbuf.

TYPES: BEGIN OF ty_fvarpbuf.
INCLUDE TYPE ty_viewid_only.
        INCLUDE STRUCTURE v_nwfvarp.
TYPES: END OF ty_fvarpbuf.

TYPES: BEGIN OF ty_buttonbuf.
INCLUDE TYPE ty_viewid_only.
        INCLUDE STRUCTURE v_nwbutton.
TYPES: END OF ty_buttonbuf.

TYPES: ty_message   LIKE bapiret2.
TYPES: tyt_messages TYPE STANDARD TABLE OF ty_message.

TYPES: ty_selvar    LIKE rsparams.
TYPES: tyt_selvars  TYPE STANDARD TABLE OF ty_selvar.

TYPES: tyt_fvar   TYPE STANDARD TABLE OF v_nwfvar,
       ty_fvar    TYPE LINE OF tyt_fvar,
       tyt_fvarp  TYPE STANDARD TABLE OF v_nwfvarp,
       ty_fvarp   TYPE LINE OF tyt_fvarp,
       tyt_button TYPE STANDARD TABLE OF v_nwbutton,
       ty_button  TYPE LINE OF tyt_button.


*----------------------------------------------------------------------
* Konstanten
*----------------------------------------------------------------------

CONSTANTS: co_prefix(3)     VALUE 'CST',
           co_prefix_a(1)   VALUE 'C',
           co_prefix_sap(1) VALUE 'S'.

CONSTANTS: co_sap_wfield    TYPE nwplace-wplaceid VALUE 'SAP_WFIELD'.

*----------------------------------------------------------------------
* Globale Tabellen + Workareas
*----------------------------------------------------------------------
* Puffer für die Selektionsvarianten
DATA: gt_selvar      TYPE STANDARD TABLE OF ty_selvarbuf.

* Puffer für die ALV-Anzeigevarianten
DATA: gt_dispvar     TYPE TABLE OF ty_dispvarbuf.
DATA: gt_dispsort    TYPE TABLE OF ty_dispsortbuf.
DATA: gt_dispfilter  TYPE TABLE OF ty_dispfiltbuf.
DATA: gt_lvc_layout  TYPE TABLE OF ty_layoutbuf.

* Puffer für die Funktionsvarianten
DATA: gt_fvar        TYPE STANDARD TABLE OF ty_fvarbuf,
      gt_fvarp       TYPE STANDARD TABLE OF ty_fvarpbuf,
      gt_button      TYPE STANDARD TABLE OF ty_buttonbuf.

* Puffer für die User-Menus usw.
DATA: gt_user_menus     LIKE TABLE OF bxmnodes1,
      gt_user_favorites LIKE TABLE OF bxmnodes,
      gt_nwplace        LIKE TABLE OF v_nwplace,
      gt_nwpusz         LIKE TABLE OF v_nwpusz,
      gt_nwview         LIKE TABLE OF v_nwview,
      gt_nwpvz          LIKE TABLE OF v_nwpvz,
      gt_nwpvz_usz      LIKE TABLE OF nwpvz_usz,
      gt_nwplace_001    LIKE TABLE OF nwplace_001.

* Puffer für die Sichttyp-Bezeichnungen
DATA: gt_viewtype_list_all   TYPE vrm_values,
      gt_viewtype_list_ish   TYPE vrm_values.

* IS-H*MED Installed Kennzeichen
DATA: g_ishmed_used     LIKE true VALUE false.

* Titel für Tree-Open-Node-Popup
DATA: g_title_0100(50)  TYPE c.

* Dynpro-Feld für Tree-Open-Node-Popup
DATA: g_100_open_nodes  TYPE n_open_nodes.

DATA: g_100_viewtype    LIKE nwview-viewtype,
      g_100_act004(1)   TYPE c,
      g_save_ok_code    LIKE ok-code.
*
