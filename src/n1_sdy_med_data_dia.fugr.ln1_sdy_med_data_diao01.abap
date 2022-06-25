*-------------------------------------------------------------------
***INCLUDE LN2DPO01 .
*-------------------------------------------------------------------
*&---------------------------------------------------------------------*
*&      Module  CUA_D120  OUTPUT
*&---------------------------------------------------------------------*
MODULE cua_d120 OUTPUT.
  IF auth = false OR g_vcode NE 'UPD'.
*   Wenn Berechtigung für fachl. OE nicht vorhanden, wird OK-CODE
*   ausgeblendet
    CLEAR excl_tab.
    excl_tab-funktion = 'ANLE'.        " kein Anlegen von Diagnsosen
    APPEND excl_tab. CLEAR excl_tab.
    excl_tab-funktion = 'F4'.          " keine Eingabemöglichkeiten
    APPEND excl_tab. CLEAR excl_tab.
  ENDIF.
* GUI-Status setzen
  SET PF-STATUS 'LISTE' EXCLUDING excl_tab.
  SET TITLEBAR  '001'.
ENDMODULE.                             " CUA_D120  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  INIT_D120  OUTPUT
*&---------------------------------------------------------------------*
MODULE init_d120 OUTPUT.
  SUPPRESS DIALOG.
  LEAVE TO LIST-PROCESSING AND RETURN TO SCREEN  0.
  PERFORM dia_liste.
  LEAVE SCREEN.
ENDMODULE.                             " INIT_D120  OUTPUT
