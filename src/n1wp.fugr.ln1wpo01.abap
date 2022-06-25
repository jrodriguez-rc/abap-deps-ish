*----------------------------------------------------------------------*
***INCLUDE LN1WPO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  init_cua  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module init_cua output.

  case sy-dynnr.
    when '0100'.
      set pf-status 'POP1'.
      set titlebar 'ALL' with g_titel.
  endcase.

endmodule.                 " init_cua  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  modify_screen_100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module modify_screen_100 output.

  loop at screen.
*   Im Display-Modus alle Felder auf Anzeigen setzen
    if g_pvcode = 'DIS'.
      screen-input = false.
      modify screen.
    endif.
  endloop.

endmodule.                 " modify_screen_100  OUTPUT
