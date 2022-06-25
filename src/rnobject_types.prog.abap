*&---------------------------------------------------------------------*
*& Report  RNOBJECT_TYPES
*&
*&---------------------------------------------------------------------*
*& Fichte, ID 18656
*&
*&---------------------------------------------------------------------*
INCLUDE nobject_types_top.
INCLUDE mncolour.



*-------------------------------------------------------------------
*                        selection-screen
*-------------------------------------------------------------------

* Development Class
SELECT-OPTIONS gt_devcl FOR tadir-devclass.

SELECTION-SCREEN SKIP.

* Checkbox "Programs without type"
PARAMETERS: g_pgm_wo TYPE ish_on_off DEFAULT off.

SELECTION-SCREEN SKIP.


SELECTION-SCREEN BEGIN OF BLOCK st_cust WITH FRAME TITLE text-001.

* Radiobutton "Standard programs only"
PARAMETERS: g_stand TYPE ish_on_off RADIOBUTTON GROUP cust DEFAULT 'X'.
* Radiobutton "Customer specific programs only"
PARAMETERS: g_cust TYPE ish_on_off RADIOBUTTON GROUP cust.
* Radiobutton "Standard and Customer specific programs"
PARAMETERS: g_all TYPE ish_on_off RADIOBUTTON GROUP cust.

SELECTION-SCREEN END OF BLOCK st_cust.


SELECTION-SCREEN BEGIN OF BLOCK sortby WITH FRAME TITLE text-010.

* Radiobutton "Sort by Development Class"
PARAMETERS: g_sortdc TYPE ish_on_off RADIOBUTTON GROUP sort DEFAULT 'X'.
* Radiobutton "Sort by Constant Name"
PARAMETERS: g_sortcn TYPE ish_on_off RADIOBUTTON GROUP sort.
* Radiobutton "Sort by Program Object"
PARAMETERS: g_sortpo TYPE ish_on_off RADIOBUTTON GROUP sort.
* Radiobutton "Sort by Value"
PARAMETERS: g_sortvl TYPE ish_on_off RADIOBUTTON GROUP sort.

SELECTION-SCREEN END OF BLOCK sortby.


*-------------------------------------------------------------------
* Initialization
*-------------------------------------------------------------------
INITIALIZATION.
  PERFORM initialization.



*-------------------------------------------------------------------
* At Selection-Screen OUTPUT
*-------------------------------------------------------------------
AT SELECTION-SCREEN OUTPUT.
  PERFORM at_selection_screen.



*-------------------------------------------------------------------
* At Selection-Screen
*-------------------------------------------------------------------
AT SELECTION-SCREEN.
  PERFORM at_selection_screen.



*-------------------------------------------------------------------
* Start-of-Selection
*-------------------------------------------------------------------
START-OF-SELECTION.
  PERFORM start_of_selection.



*-------------------------------------------------------------------
* Top-of-Page
*-------------------------------------------------------------------
TOP-OF-PAGE.
  PERFORM top_of_page.



*-------------------------------------------------------------------
* Include all forms
*-------------------------------------------------------------------
  INCLUDE rnobject_types_f01.
