*----------------------------------------------------------------------*
***INCLUDE LN1AVARI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  check_avar_text  INPUT
*&---------------------------------------------------------------------*
MODULE check_avar_text INPUT.

  IF g_avar_text IS INITIAL.
    MESSAGE e454.
*   Bitte eine Bezeichnung für die Anzeigevariante eingeben
  ENDIF.

ENDMODULE.                             " check_avar_text  INPUT
*&---------------------------------------------------------------------*
*&      Module  exit  INPUT
*&---------------------------------------------------------------------*
MODULE exit INPUT.

  g_save_ok_code = ok-code.
  CLEAR ok-code.
  CASE g_save_ok_code.
    WHEN 'ECAN'.
      SET SCREEN 0. LEAVE SCREEN.
  ENDCASE.

ENDMODULE.                             " exit  INPUT
*&---------------------------------------------------------------------*
*&      Module  ok_code  INPUT
*&---------------------------------------------------------------------*
MODULE ok_code INPUT.

  g_save_ok_code = ok-code.
  CLEAR ok-code.

  CASE g_save_ok_code.
    WHEN 'ENTR'.                       " Enter
      SET SCREEN 0. LEAVE SCREEN.
  ENDCASE.

ENDMODULE.                             " ok_code  INPUT
