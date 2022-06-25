*----------------------------------------------------------------------*
***INCLUDE LN1WPI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  exit_100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_100 INPUT.

  MOVE ok-code TO g_pop_ok_code.
  CLEAR ok-code.
  CASE g_pop_ok_code.
    WHEN 'CAN'.                                            "Abbrechen
      SET SCREEN 0. LEAVE SCREEN.
    WHEN OTHERS.
      MESSAGE s031(nf) WITH g_pop_ok_code.
  ENDCASE.

ENDMODULE.                 " exit_100  INPUT
*&---------------------------------------------------------------------*
*&      Module  ok_code_100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE ok_code_100 INPUT.

  g_pop_ok_code = ok-code.
  CLEAR ok-code.
  CASE g_pop_ok_code.
    WHEN 'ENTR'.                       "Enter
      SET SCREEN 0. LEAVE SCREEN.
    WHEN 'ECAN' OR 'CAN'.              "Abbrechen
      SET SCREEN 0. LEAVE SCREEN.
    WHEN OTHERS.                       "undefinierter OK-Code
      MESSAGE s031(nf) WITH g_pop_ok_code.
  ENDCASE.

ENDMODULE.                 " ok_code_100  INPUT
