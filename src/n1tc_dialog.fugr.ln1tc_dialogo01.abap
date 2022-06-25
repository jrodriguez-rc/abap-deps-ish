*----------------------------------------------------------------------*
***INCLUDE LN1TC_DIALOGO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE request_screen_status OUTPUT.
  perform request_screen_status.
ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  REQUEST_SCREEN_MOD  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module REQUEST_SCREEN_MOD output.
  perform REQUEST_SCREEN_MOD.
  perform set_reguest_status. "MED-67191
endmodule.                 " REQUEST_SCREEN_MOD  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  REQUEST_SCREEN_INIT  OUTPUT
*&---------------------------------------------------------------------*
*       initalisation of globel dialog data
*----------------------------------------------------------------------*
module REQUEST_SCREEN_INIT output.
  perform REQUEST_SCREEN_INIT.
endmodule.                 " REQUEST_SCREEN_INIT  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  REQUEST_SCREEN_SET_CURSOR  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module REQUEST_SCREEN_SET_CURSOR output.
    PERFORM REQUEST_SCREEN_SET_CURSOR.
endmodule.                 " REQUEST_SCREEN_SET_CURSOR  OUTPUT
