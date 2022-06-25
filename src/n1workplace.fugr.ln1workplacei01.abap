*----------------------------------------------------------------------*
***INCLUDE LN1WORKPLACEI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  ok_code  INPUT
*&---------------------------------------------------------------------*
module ok_code input.

  g_save_ok_code = ok-code.
  clear ok-code.

  case g_save_ok_code.
    when 'ENTR'.
      set screen 0.
      leave screen.
    when 'CANC'.
      set screen 0.
      leave screen.
    when others.
  endcase.

endmodule.                 " ok_code  INPUT
