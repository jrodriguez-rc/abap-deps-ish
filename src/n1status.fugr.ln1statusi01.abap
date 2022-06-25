*----------------------------------------------------------------------*
***INCLUDE LN1STATUSI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  exit  INPUT
*&---------------------------------------------------------------------*
*       exit if popup has been cancelled
*----------------------------------------------------------------------*
MODULE exit INPUT.

  CHECK ok-code EQ 'ECAN'.
  SET SCREEN 0. LEAVE SCREEN.

ENDMODULE.                 " exit  INPUT
*&---------------------------------------------------------------------*
*&      Module  user_command  INPUT
*&---------------------------------------------------------------------*
*       user command
*----------------------------------------------------------------------*
MODULE user_command INPUT.

  CASE ok-code.
*   enter on selection popup of status (dynpro 100)
    WHEN 'ENTR'.
      SET SCREEN 0. LEAVE SCREEN.
  ENDCASE.

ENDMODULE.                 " user_command  INPUT
*&---------------------------------------------------------------------*
*&      Module  get_sel_entries_status  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_sel_entries_status INPUT.

  PERFORM get_sel_entries_status.

ENDMODULE.                 " get_sel_entries_status  INPUT
