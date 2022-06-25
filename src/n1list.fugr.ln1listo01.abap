*----------------------------------------------------------------------*
***INCLUDE LN1LISTO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.

  SET TITLEBAR '100' WITH LP_TITLE.
* Button mit Texten/Icons belegen
  PERFORM SET_BUTTONS.
  PERFORM FILL_EXCLTAB_0100.
  SET PF-STATUS '0100' EXCLUDING EXCL_TAB.
  SUPPRESS DIALOG.

ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  INIT_200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module INIT_200 output.

  SET TITLEBAR '100' WITH SPOP-TITEL.
  SET PF-STATUS '0200'.

endmodule.                 " INIT_200  OUTPUT
