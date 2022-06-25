FUNCTION-POOL n1list MESSAGE-ID nf NO STANDARD PAGE HEADING.

INCLUDE mndata00.
INCLUDE rncolour.

*---------- TYPE POOLS ------------------------------------------------*
TYPE-POOLS: slis.

*---------- TABLES ----------------------------------------------------*
*TABLES: tcdob.                          "Objects for change documents


* Für POPUP-Textelemente:
TABLES: spop.

*-----------------------------------------------------------------------
* Globale Datendefinitionen
*-----------------------------------------------------------------------
DATA: lp_enter_key   LIKE off,              " List-Popup-Enter-Key
      lp_print_key   LIKE off,              " List-Popup-Print-Key
      lp_title(60)   TYPE c,                " List-Popup-Titel
      lp_header1     LIKE rn1list132-text,  " List-Popup-Überschrift1
      lp_header2     LIKE rn1list132-text,  " List-Popup-Überschrift2
      lp_zeilen      TYPE i,                " List-Popup Zeilenanzahl
      lp_breite      TYPE i.                " List-Popup Breite

* List-Popup-Ausgabetabelle
DATA: lp_outtab      LIKE rn1list132  OCCURS 0  WITH HEADER LINE.
* List-Popup-Pusbutton-Tabelle
DATA: lp_button      LIKE rn1push     OCCURS 10 WITH HEADER LINE.
* Tabelle enthaelt auszuschliessende FCODES
DATA: BEGIN OF excl_tab OCCURS 10,
        funktion TYPE sy-ucomm.
DATA: END OF excl_tab.

* Ausgewählter Funktionscode (Drucktaste)
DATA: key_back    LIKE sy-ucomm.

* Variablen für dynamische Pushbuttons
DATA: button1(50),
      button2(50),
      button3(50),
      button4(50),
      button5(50),
      button6(50),
      button7(50),
      button8(50),
      button9(50),
      button10(50).
*
