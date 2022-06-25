FUNCTION-POOL n1fvar MESSAGE-ID nf1.


*----------------------------------------------------------------------*
* Definition von TRUE, FALSE ...
*----------------------------------------------------------------------*
INCLUDE mndata00.
INCLUDE <ctldef>.
INCLUDE ln1fvarcl5.        " Drag Object

*----------------------------------------------------------------------
* Typdefinitionen
*----------------------------------------------------------------------
* Typ-Pool für den F4-Hilfe-Baustein
*TYPE-POOLS: shlp.

* Definition for list box
*TYPE-POOLS vrm.

* definition for icons
TYPE-POOLS: icon.

TYPES: ty_message   LIKE bapiret2,
       tyt_messages TYPE STANDARD TABLE OF ty_message.

*TYPES: BEGIN OF ty_func,
*        code         LIKE rsmpe_funt-code,
*        textno       LIKE rsmpe_funt-textno,
*        type         LIKE rsmpe_funt-type,
*        modif        LIKE rsmpe_funt-modif,
*        text_type    LIKE rsmpe_funt-text_type,
*        text_name    LIKE rsmpe_funt-text_name,
*        icon_id      LIKE rsmpe_funt-icon_id,
*        fun_text(70) TYPE c,
*        icon_text    LIKE rsmpe_funt-icon_text,
*        info_text    LIKE rsmpe_funt-info_text,
*        path         LIKE rsmpe_funt-path,
*       END OF ty_func.
*
*TYPES: tyt_func TYPE STANDARD TABLE OF rn1wp_func.

* Typ für die Tabelle des Funktionscode-Trees
TYPES: BEGIN OF ty_functree,
         hierarchy(70) TYPE c,
         text(30)      TYPE c,
         icon_id       LIKE rsmpe_funt-icon_id,
         icon_text     LIKE rsmpe_funt-icon_text,
         END OF ty_functree.
TYPES: tyt_functree TYPE STANDARD TABLE OF ty_functree.

* Typ für den Edit-Tree, d.h. den der im Dynpro ist
TYPES: BEGIN OF ty_edittree,
         buttonnr  LIKE nwbutton-buttonnr,
*        TYPE: 'R'...Root-Knoten - muss genau einmal existieren
*              'B'...Button
*              'S'...Separator
*              'F'...Funktion, also so eine Art Untermenü des Buttons
*              'Z'...Funktionsseparator
         type      TYPE c,
*        Bei einem Separator ist FCODE immer leer!
         fcode     LIKE nwbutton-fcode,
         txt       LIKE nwfvarpt-txt,
         icon      LIKE nwbutton-icon,
         icon_q    LIKE nwbuttont-icon_q,
         lfdnr     LIKE nwfvarp-lfdnr,
         dbclk     LIKE nwfvarp-dbclk,
         tb_butt   LIKE nwfvarp-tb_butt,
         dbclkinfo TYPE c,
         fkey      TYPE nfkey,                              " ID 10202
         fkeytxt(10) TYPE c,                                " ID 10202
       END OF ty_edittree.

TYPES: tyt_edittree TYPE STANDARD TABLE OF ty_edittree.
TYPES: BEGIN OF ty_ext_edittreelist.
INCLUDE TYPE ty_edittree.
TYPES: level TYPE i,
       END OF ty_ext_edittreelist.

* Hilfsliste für Edittree-Struktur Generierung
TYPES: tyt_ext_edittreelist TYPE STANDARD TABLE OF
                            ty_ext_edittreelist.

TYPES: tyt_nwfvar   TYPE STANDARD TABLE OF v_nwfvar,
       ty_nwfvar    TYPE LINE OF tyt_nwfvar,
       tyt_nwfvarp  TYPE STANDARD TABLE OF v_nwfvarp,
       ty_nwfvarp   TYPE LINE OF tyt_nwfvarp,
       tyt_nwbutton TYPE STANDARD TABLE OF v_nwbutton,
       ty_nwbutton  TYPE LINE OF tyt_nwbutton.


*----------------------------------------------------------------------
* Globale Tabellen + Work areas
*----------------------------------------------------------------------
* In GT_FCODES steht die Menge aller FCodes, die der Benutzer für
* die Funktionsvariante verwenden kann. Diese Tabelle wird aus den
* FCodes der Menüs und Funktionstasten abgeleitet, die aus einem
* Referenz-GUI-Status stammen
DATA: gt_fcodes TYPE ISHMED_T_WP_FUNC.

* Globale Tabelle für den Inhalt des Funktionscode-Trees. Dies ist
* eine Teilmenge der Tabelle GT_FCODES
DATA: gt_functree TYPE tyt_functree.

* Tabelle für den Inhalt des Edit-Trees (d.h. wo die FVarianten
* zusammengestellt werden)
DATA: gt_edittree TYPE tyt_edittree.

* Tabellen, die die Funktionsvarianten beinhalten und die dem Inhalt
* des Edit-Trees (d.h. der im Dynpro liegt) entspricht
DATA: gt_nwfvar   TYPE tyt_nwfvar,
      gt_nwfvarp  TYPE tyt_nwfvarp,
      gt_nwbutton TYPE tyt_nwbutton.

* Globale Feldleiste für die Editierfelder im Dynpro
DATA: BEGIN OF g_dynpro,
        node_key  TYPE lvc_nkey,
        fcode     LIKE nwbutton-fcode,
        txt       LIKE nwfvarpt-txt,
        icon(30),
        icontech  LIKE icon-name,
        icon_q    LIKE nwbuttont-icon_q,
        dbclk     LIKE nwfvarp-dbclk,
        fkey      TYPE nfkey,                               " ID 10202
      END OF g_dynpro.

* sichern Dynpro
DATA: BEGIN OF g_dynpro200,
        viewtype  LIKE dd07t-ddtext,
        viewid    LIKE nwview-viewid,
        viewbez   LIKE nwviewt-txt,
        name      LIKE nwfvar-fvar,
        bezeich   LIKE nwfvart-txt,
      END OF g_dynpro200.

* Auszuschließende Funktionen des GUI-Status
DATA: BEGIN OF gt_ex_fkt OCCURS 10,
        function(30) TYPE c,
      END OF gt_ex_fkt.

* Sicht mit Bezeichnung
DATA: g_v_nwview TYPE v_nwview.

** glob. node wa
*DATA: g_wa_node TYPE ty_functree.
*
** Warnung beim Speichern kommt nur 1x
*DATA: g_first_time_warning TYPE i VALUE true.

* globale Top-Node
DATA: g_top_node_key TYPE lvc_nkey.

DATA: g_tmp_rc       TYPE sy-subrc.

*----------------------------------------------------------------------
* Konstantendefinitionen
*----------------------------------------------------------------------
*CONSTANTS: co_edit_cont_name(30)    VALUE 'EDIT_CONTAINER',
*           co_toolbar_cont_name(30) VALUE 'TOOLBAR_CONTAINER',
*           co_tree_cont_name(30)    VALUE 'TREE_CONTAINER'.
*
* Konstanten mit den Feldnamen der Table GT_FUNCTREE
*CONSTANTS: co_functree_table(30)     VALUE 'GT_FUNCTREE',
*           co_functree_hierarchy(30) VALUE 'HIERARCHY'.
CONSTANTS: co_functree_text(30)      VALUE 'TEXT',
           co_functree_icon(30)      VALUE 'ICON_ID',
           co_functree_icon_text(30) VALUE 'ICON_TEXT'.

* Konstanten mit den Feldnamen der Table GT_EDITTREE
CONSTANTS: co_edittree_buttonnr(30) VALUE 'BUTTONNR',
*           co_edittree_type(30)     VALUE 'TYPE',
           co_edittree_fcode(30)    VALUE 'FCODE',
*           co_edittree_txt(30)      VALUE 'TXT',
           co_edittree_icon(30)     VALUE 'ICON',
           co_edittree_icon_q(30)   VALUE 'ICON_Q',
           co_edittree_prio(30)     VALUE 'PRIO',
           co_edittree_dbclk(30)    VALUE 'DBCLK',
           co_edittree_dbclkinfo(30) VALUE 'DBCLKI',
           co_edittree_fkey(30)     VALUE 'FKEY',           " ID 10202
           co_edittree_fkeytxt(30)  VALUE 'FKEYTXT',        " ID 10202
           co_edittree_tb_butt(30)  VALUE 'TB_BUTT'.

* Text, der für einen Separator im Edit-Tree ausgegeben wird
CONSTANTS: co_edittree_separator(30)
                       VALUE '------------------------------'.

CONSTANTS: g_vcode_insert   TYPE ish_vcode  VALUE 'INS',
           g_vcode_update   TYPE ish_vcode  VALUE 'UPD'.
*           g_vcode_display  TYPE ish_vcode  VALUE 'DIS'.


*----------------------------------------------------------------------
* Sonstige globale Variablen
*----------------------------------------------------------------------

* OK-Code
DATA: g_okcode LIKE ok-code.

* glob. V-Code
DATA: g_vcode TYPE ish_vcode.

* globales ChangeFlag
DATA: g_anythingchanged TYPE i VALUE false.

* Titelzeile für das Fenster
DATA: g_title(40).

* ISHMED installed kennzeichen
DATA: g_ishmed_used LIKE true.

* translation mode
DATA: g_translation TYPE ish_on_off.

* Soll der Button "Änderung übernehmen" aktiv sein?
DATA: g_show_button_change TYPE c.

* G_VIEW beinhaltet die Sicht, für die die Funktionsvariante
* gepflegt werden soll
DATA: g_view LIKE nwview.

* G_VIEWVAR beinhaltet die Sicht, mit den Varianten (also auch die
* Funktionsvariante, die gepflegt werden soll)
DATA: g_viewvar LIKE rnviewvar.

* G_MODE gibt an, ob die Funktionsvariante gesichert ('S') oder nur
* definiert ('D') werden soll
DATA: g_mode LIKE n1fld-n1mode.

* G_CALLER beinhaltet den Programmnamen des aufrufenden Programms
*DATA: g_caller LIKE sy-repid.

* globales Kennzeichen ob DB-Clk Checkbox editierbar ist oder nicht
DATA: g_show_dbclk.

* globales Kennzeichen ob im Editmodus oder nicht
DATA: g_edit_mode.

* globales Kennzeichen ob im Modus 'Kunden-Funktion anlegen' oder nicht
DATA: g_cust_ins.                                           " ID 11731

* globales Kennzeichen ob Icon-Button enabled ist
DATA: g_edit_iconbutton.

* G_GUI_PGM, G_GUI_STATUS beinhalten den Programmnamen und den
* Namen des GUI-Status, aus dem sich die Menge der Funktionscodes
* dieser Funktionsvariante herleiten
DATA: g_gui_pgm    LIKE trdir-name,
*      g_gui_pgmtxt(30),
      g_gui_status LIKE rsmpe_sta-code.

* ORIGINAL Anfang --------------------------------------------------
* Container: Docking-Container für den Funktionscode-Tree und
* einer für die Anzeige des Toolbars
*data: g_tree_cont       type ref to cl_gui_docking_container,
**     g_result_bar_cont type ref to cl_gui_docking_container,
*      g_result_bar_cont type ref to cl_gui_custom_container,
**     Und ein Custom-Container für den Edit-Tree
*      g_edit_cont       type ref to cl_gui_custom_container.
*
* ORIGINAL Ende --------------------------------------------------

* NEU Anfang -----------------------------------------------------

* Will, 9.6.00 neues Layout.......
DATA: g_splitter_main_cont TYPE REF TO cl_gui_splitter_container,
      g_splitter_main_cont_top TYPE REF TO cl_gui_container,
      g_splitter_main_cont_bottom TYPE REF TO cl_gui_container,

      g_splitter_child_cont TYPE REF TO cl_gui_splitter_container,
      g_splitter_child_cont_left TYPE REF TO cl_gui_container,
      g_splitter_child_cont_right TYPE REF TO cl_gui_container,

      g_main_cust_container TYPE REF TO cl_gui_custom_container.


* NEU Ende --------------------------------------------------------


* Der linke Tree mit den möglichen Funktionscodes
DATA: g_func_tree       TYPE REF TO cl_gui_alv_tree,
*     Der rechte (Edit-)Tree für das Editieren der FVarianten
      g_edit_tree       TYPE REF TO cl_gui_alv_tree,
*     Der Toolbar, in dem das Ergebnis präsentiert wird
      g_result_bar      TYPE REF TO cl_gui_toolbar.

DATA: g_first_time_100 TYPE c.
DATA: g_first_time_200 TYPE c.

DATA: g_system_sap     LIKE off.                            " ID 7947

*DATA  behaviour_func_tree TYPE REF TO cl_dragdrop.
DATA  behaviour_edit_tree TYPE REF TO cl_dragdrop.

*DATA  handle_func_tree TYPE i.
DATA  handle_edit_tree TYPE i.

*definition for ISHMED_VM_FVAR_F4
TYPES: BEGIN OF ty_outtab_fvar,
         fvar LIKE nwfvar-fvar,
         txt  LIKE nwfvart-txt,
       END OF ty_outtab_fvar.
DATA: gt_outtab_fvar TYPE STANDARD TABLE OF ty_outtab_fvar
                     WITH HEADER LINE.

* Drag & Drop
INCLUDE ln1fvarcl4.        " Drag n Drop Event Receiver

* Drag & Drop Event-Receiver
DATA dragdrop TYPE REF TO lcl_dragdrop_receiver.


*--------------------------------------------------------------------
* Klassendefinitionen
*--------------------------------------------------------------------
INCLUDE ln1fvarcl1.        " Event-Verarbeitung des Function-Trees
INCLUDE ln1fvarcl2.        " Include für Toolbarevent
INCLUDE ln1fvarcl3.        " Event-Verarbeitung des Edit-Trees



*     Toolbar-Eventhandler
DATA: g_res_bar_ev_hdl  TYPE REF TO lcl_res_bar_event_receiver.
