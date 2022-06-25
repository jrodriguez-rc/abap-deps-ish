FUNCTION-POOL n1_gui_mdy_popup_simple.        "MESSAGE-ID ..

* INCLUDE LN1_BC_MDY_SPEC_CREATED...         " Local class definition

CONSTANTS co_repid                    TYPE syrepid VALUE 'SAPLN1_GUI_MDY_POPUP_SIMPLE'.

DATA g_ucomm_0100                     TYPE syucomm.

DATA g_repid_sc_popup_0100            TYPE syrepid VALUE 'SAPLN1SC'.
DATA g_dynnr_sc_popup_0100            TYPE sydynnr VALUE '0001'.



***Begin of MED-48629, Jitareanu Cristina 24.10.2012  "für die Rekonstruktion der Fallliste

DATA: title(40).

DATA: BEGIN OF excl_tab OCCURS 10,
        funktion(30) TYPE c.
DATA: END OF excl_tab.

DATA: g_check_datas TYPE xfeld,  " parameter transfered to the function module
      g_node_plus(2),
      g_case_buttons TYPE c . " parameter transfered to the function module

DATA: vcode TYPE tndym-vcode,
      new_bew(1),
      sel_nbew(1) VALUE ' ',
      sel_amb_bew(1),
      feldname(30),
      chg_bew(1),
      sort_field(10),
      fal_out_index  LIKE sy-tabix,
      g_node_empty(2),
      g_node_minus(2),
      g_mts_closed   TYPE c,
      new_case(1).

DATA: pziff_pat(1) VALUE ' ',    " Prüfziffer für NPAT zeigen ?
      pziff_fal(1) VALUE ' '.    " Prüfziffer für NFAL zeigen ?

* Ausgabetabelle für die Bewegungsliste
DATA: BEGIN OF outtab_nbew OCCURS 50.
        INCLUDE STRUCTURE nbew.
DATA: END OF outtab_nbew.

* Ausgabetabelle für die Falliste
DATA: BEGIN OF outtab_nfal OCCURS 10.
        INCLUDE STRUCTURE nfal.
* Knotenkz einfügen
*DATA:   KNOTENKZ TYPE C.
DATA: node(2).
DATA: END OF outtab_nfal.


* Ausgabetabelle für die Falliste
DATA: BEGIN OF gs_nfal OCCURS 10.
        INCLUDE STRUCTURE nfal.
DATA: END OF gs_nfal.

DATA: gs_nfal_highlight  TYPE nfal,
      g_kunden_sort(1)   TYPE c.

* Fälle, die der Falliste übergeben wurden
DATA: BEGIN OF the_nfal OCCURS 5.
        INCLUDE STRUCTURE nfal.
DATA: END OF the_nfal.

DATA: BEGIN OF outtab OCCURS 30,
        type(01),
        einri LIKE nbew-einri,
        tmnid LIKE ntmn-tmnid,
        falnr LIKE nbew-falnr,
        lfdnr LIKE nbew-lfdnr,
        patnr LIKE ntmn-patnr,
        bewty LIKE nbew-bewty,
        upusr LIKE nbew-upusr,
        vgnref LIKE nbew-vgnref,
        nfgref LIKE nbew-nfgref,
        orgpf LIKE nbew-orgpf,
        orgfa LIKE nbew-orgfa,
        zimmr LIKE nbew-zimmr,
        bwidt LIKE nbew-bwidt,
        bwizt LIKE nbew-bwizt,
        dauer LIKE ntmn-tmndr,
        bwart LIKE nbew-bwart,
        aprie LIKE n1apri-aprie,
        statu LIKE nbew-statu,
        tpart LIKE nbew-tpart,
        medtx LIKE nbew-medtx,
        meltx LIKE nbew-meltx,
        papid LIKE npap-papid,
      END OF outtab.

DATA: einri        LIKE tn01-einri,
      out_index      LIKE sy-tabix.
TABLES:  n1apri,             " Priorität
         npat,
         tn17t.              " Geschlecht
DATA: last_colour(1),                                       "#EC *
      last_intens(1).                                       "#EC *
DATA: merk_colour(1),                                       "#EC *
      merk_intens(1).                                       "#EC *

* Interne Pufferung der Fallarttexte
DATA: BEGIN OF itn15t OCCURS 10.
        INCLUDE STRUCTURE tn15t.
DATA: END OF itn15t.

* Interne Pufferung der Bewegungsstati
DATA: BEGIN OF itn14e OCCURS 50.
        INCLUDE STRUCTURE tn14e.
DATA: END OF itn14e.

DATA: fcode TYPE sy-ucomm.

***End of MED-48629, Jitareanu Cristina 24.10.2012  "für die Rekonstruktion der Fallliste
