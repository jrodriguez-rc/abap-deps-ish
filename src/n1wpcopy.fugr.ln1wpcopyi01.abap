*----------------------------------------------------------------------*
***INCLUDE LN1WPCOPYI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  exit  INPUT
*&---------------------------------------------------------------------*
*       exit routine
*----------------------------------------------------------------------*
MODULE exit INPUT.

  MOVE ok-code TO g_ok_code.
  CLEAR ok-code.
  CASE g_ok_code.
    WHEN 'CAN'.                                            " cancel
      SET SCREEN 0. LEAVE SCREEN.
    WHEN OTHERS.
      MESSAGE s031(nf) WITH g_ok_code.
  ENDCASE.

ENDMODULE.                 " exit  INPUT
*&---------------------------------------------------------------------*
*&      Module  ok_code  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE ok_code INPUT.

  g_ok_code = ok-code.
  CLEAR ok-code.
  CASE g_ok_code.
    WHEN 'ENTR'.                       " enter
      SET SCREEN 0. LEAVE SCREEN.
    WHEN 'ECAN' OR 'CAN'.              " cancel
      SET SCREEN 0. LEAVE SCREEN.
    WHEN OTHERS.                       " undefined ok-code
      MESSAGE s031(nf) WITH g_ok_code.
  ENDCASE.

ENDMODULE.                 " ok_code  INPUT
*&---------------------------------------------------------------------*
*&      Module  check_text_view  INPUT
*&---------------------------------------------------------------------*
*       Check if Text has changed                          ID 11478
*----------------------------------------------------------------------*
MODULE check_text_view INPUT.

  IF g_text_view = g_text_view_sv AND g_check_text = on.
    MESSAGE w806.
*   Es sollte eine abweichende Bezeichnung eingegeben werden
  ENDIF.

ENDMODULE.                 " check_text_view  INPUT
