FUNCTION-POOL N1_SDY_MED_DATA_DIA MESSAGE-ID NG.

* TABLES: NBEW,
TABLES: nfal, *nfal,
        ndia,
        nkdi,
        ngpa.

* TYPE-POOLS: nstxd.

*----------------------------------------------------------------------*
*        IS-H Datendeklarationen
*----------------------------------------------------------------------*
INCLUDE mndata00.
INCLUDE <icon>.

* Deklarationen für ish_show_diagnoses
DATA: g_einri          LIKE nfal-einri,
      g_patnr          LIKE nfal-patnr,
      g_orgfa          LIKE nbew-orgfa,
      g_vcode          LIKE tndym-vcode,
      hide_counter      TYPE i,
      anzdia            TYPE i VALUE 0,"Anzahl der erfaßten Diagnosen
      feldname(30)      TYPE c,        "Dynp.feldname f. get cursor
      flag              TYPE c,
      n1maoe(1)         TYPE c,        "Parameter Mitarb-OE        4.62
      orgid             LIKE norg-orgid,  "Zw.speichern Orgeinheit 4.62
      enodiag,
      ekat              LIKE nkdi-dkat,
      ekey              LIKE nkdi-dkey,
      efalnr            LIKE nbew-falnr,
      elfdnr            LIKE ndia-lfdnr,
      editxt            LIKE ndia-ditxt,
      edialo            LIKE ndia-dialo,
      edialotext        LIKE tn26x-dialotext,
      para_dld(5).                     " IS-HMED DiagnÜbersicht desc.

*interne Tabelle für Ausgabe der Diagnosen
DATA: BEGIN OF dia_tab  OCCURS 20,
        lfdnr     LIKE ndia-lfdnr,
        falnr     LIKE ndia-falnr,
        lfdbew    LIKE ndia-lfdbew,
        ditxt     LIKE ndia-ditxt,
        katkz     type ish_on_off,
        dkat1     LIKE ndia-dkat1,
        dkey1     LIKE ndia-dkey1,
        dtyp1     LIKE ndia-dtyp1,
        diabz     LIKE ndia-diabz,
        dialo     LIKE ndia-dialo,
        diagw     LIKE ndia-diagw,
        diazs     LIKE ndia-diazs,
        dialotext LIKE tn26x-dialotext,
        diadt     LIKE ndia-diadt,
      END OF dia_tab.

DATA: BEGIN OF teil_nfal OCCURS 20.
        INCLUDE STRUCTURE nfal.
DATA: END OF teil_nfal.

DATA: BEGIN OF india OCCURS 1.
        INCLUDE STRUCTURE rndia.
DATA: END OF india.

DATA:  BEGIN OF ll_nfal .
        INCLUDE STRUCTURE nfal.
DATA:  END OF ll_nfal.

DATA: BEGIN OF inbew OCCURS 10.
        INCLUDE STRUCTURE vnbew.
DATA: END OF inbew.

DATA: BEGIN OF icdtxt_ndia OCCURS 2.   "Änderungsbelegtabelle
        INCLUDE STRUCTURE cdtxt.
DATA: END   OF icdtxt_ndia.

DATA: BEGIN OF vb_ndia       OCCURS 1.
        INCLUDE STRUCTURE vndia      .
DATA: END OF vb_ndia      .

DATA: BEGIN OF vb_*ndia       OCCURS 1.
        INCLUDE STRUCTURE vndia      .
DATA: END OF vb_*ndia      .
* Berechtiguntsprüfung für Diagnosen
DATA: auth(1)         TYPE c,          "Flag Berechtigung vorhanden
      auth_message    TYPE c VALUE '1',"Flag: Auth-Message ausgeben
                                       "wenn nicht alle Diagnosen
                                       "ausgegeben werden konnten
      auth_mod(1)    TYPE c.           "Modus für Authority-Check
"für Diagnosedoku.
*     Festwerte für Berechtigungselement f. Diagnosedokumentation
DATA: diag_orgfa(1)      TYPE c    VALUE '1'.

DATA: BEGIN OF excl_tab OCCURS 20,
          funktion(4) TYPE c,
          nachricht(3) TYPE c,
      END OF excl_tab.

* Hilfsflags, ob nach dem Aufruf eines FBS auch Daten zurückkommen
DATA: find_nkdi(1)  TYPE c VALUE '0',  " Flag: Diagnose vorhanden
      find_tn26e(1) TYPE c VALUE '0'.  "Flag: TN26E Satz vorhanden
