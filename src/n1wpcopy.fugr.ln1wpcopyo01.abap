*----------------------------------------------------------------------*
***INCLUDE LN1WPCOPYO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  init_cua  OUTPUT
*&---------------------------------------------------------------------*
*       dynpro initialization
*----------------------------------------------------------------------*
MODULE init_cua OUTPUT.

  SET PF-STATUS 'VART'.
  SET TITLEBAR 'ALL' WITH g_ptitel.

ENDMODULE.                 " init_cua  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  modify_screen_100  OUTPUT
*&---------------------------------------------------------------------*
*       screen modification
*----------------------------------------------------------------------*
MODULE modify_screen_100 OUTPUT.

  LOOP AT SCREEN.
    check screen-name <> 'OK-CODE'.
*   display mode - no field input
    IF g_pvcode = 'DIS'.
      screen-input = false.
    ENDIF.
*   variant type - only display relevant fields
    screen-active = false.
    screen-input  = false.
    CASE g_type.
      WHEN 'S'.
        IF screen-name = 'G_TEXT_SVAR'.
          screen-active = true.
          screen-input  = true.
        ENDIF.
        IF screen-name = 'TEXT_SVAR'.
          screen-active = true.
        ENDIF.
      WHEN 'A'.
        IF screen-name = 'G_TEXT_AVAR'.
          screen-active = true.
          screen-input  = true.
        ENDIF.
        IF screen-name = 'TEXT_AVAR'.
          screen-active = true.
        ENDIF.
      WHEN 'F'.
        IF screen-name = 'G_TEXT_FVAR'.
          screen-active = true.
          screen-input  = true.
        ENDIF.
        IF screen-name = 'TEXT_FVAR'.
          screen-active = true.
        ENDIF.
      WHEN OTHERS.
        IF screen-name = 'G_TEXT_ALLG'.
          screen-active = true.
          screen-input  = true.
        ENDIF.
        IF screen-name = 'TEXT_ALLG'.
          screen-active = true.
        ENDIF.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.

ENDMODULE.                 " modify_screen_100  OUTPUT
