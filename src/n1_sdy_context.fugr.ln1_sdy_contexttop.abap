FUNCTION-POOL n1_sdy_context.

INCLUDE mndata00.
INCLUDE mndata01.
INCLUDE mndata02.
INCLUDE mncediev.
INCLUDE mncdat20.

TYPE-POOLS: vrm.

TYPES: BEGIN OF ty_ctx_subscr,
*         Identifikation (vgl. Konstanten co_sub_behandlung, ...)
          id_sub         TYPE sy-ucomm,
*         Kontext (Auslöser)
          context        TYPE REF TO cl_ish_context,
*         zugeordneter Subscreen
          subscr         TYPE REF TO cl_ishmed_subscr_ctx_userdef,
          text(40)       TYPE c,
          ordnm(2)       TYPE n,
       END   OF ty_ctx_subscr,
       tyt_ctx_subscr    TYPE STANDARD TABLE OF ty_ctx_subscr.

TYPES: BEGIN OF ty_tabstrip,
*         Identifikation (vgl. Konstanten co_sub_behandlung, ...)
          id_sub         TYPE sy-ucomm,
*         Instanz des Subscreens
          subscr         TYPE REF TO object,
*         Beschriftung der Registerkarte
          text(80)       TYPE c,
*         Funktionscode der Registerkarte
          function       TYPE sy-ucomm,
          sort(2)        TYPE n,
          cxtyp          type ncxtyp,
       END   OF ty_tabstrip,
       tyt_tabstrip      TYPE STANDARD TABLE OF ty_tabstrip.

* Tabstrip-Control
CONTROLS: g_tabstrip TYPE TABSTRIP.

DATA: gr_subscr_context TYPE REF TO cl_ish_scr_context,
      g_einri TYPE einri,
      g_dynpg TYPE sy-repid,
      g_dynnr TYPE sy-dynnr,
*     initialize the tabstrips
      g_tab_ctx_userdef01(35)     TYPE c,
      g_tab_ctx_userdef02(35)     TYPE c,
      g_tab_ctx_userdef03(35)     TYPE c,
      g_tab_ctx_userdef04(35)     TYPE c,
      g_tab_ctx_userdef05(35)     TYPE c,
*     Benutzerdef. Kontext
      co_sub_userfields TYPE sy-ucomm VALUE 'SUB_USERFIELDS',
      co_sub_ctx_userdef  TYPE sy-ucomm VALUE 'SUB_CTX_USERDEF',
      co_sub_ctx_userdef1 TYPE sy-ucomm VALUE 'SUB_CTX_USERDEF01',
      co_sub_ctx_userdef2 TYPE sy-ucomm VALUE 'SUB_CTX_USERDEF02',
      co_sub_ctx_userdef3 TYPE sy-ucomm VALUE 'SUB_CTX_USERDEF03',
      co_sub_ctx_userdef4 TYPE sy-ucomm VALUE 'SUB_CTX_USERDEF04',
      co_sub_ctx_userdef5 TYPE sy-ucomm VALUE 'SUB_CTX_USERDEF05',
*     Tabelle, die alle dynamischen Registerkarten enthält
      gt_tabstrip_dyn             TYPE tyt_tabstrip,
*     Default-Registerkarte (vom Aufrufer vorgegeben)
* ED, ID 17836: new length
      g_regcard(18)               TYPE c,
*      g_regcard(15)               TYPE c,
      g_first_time                TYPE ish_on_off VALUE 'X',
*     Var. für Bezeichnung der (dynamischen) Registerkarten
*     Führer, ID. 11356: Erweiterung von 35 auf 132 Stellen
      ts_context_tab01(132)                TYPE c,
      ts_context_tab02(132)                TYPE c,
      ts_context_tab03(132)                TYPE c,
      ts_context_tab04(132)                TYPE c,
      ts_context_tab05(132)                TYPE c.

* Globale Tabstrip-Variable, die den passenden Subscreen steuert
DATA: BEGIN OF g_tabstrip_dynpro,
        dynpro   TYPE sy-dynnr,
        program  TYPE sy-repid,
        function TYPE sy-ucomm VALUE 'SUB_CTX_USERDEF',
      END OF g_tabstrip_dynpro.
