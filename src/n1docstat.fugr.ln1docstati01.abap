*----------------------------------------------------------------------*
***INCLUDE LN1DOCSTATI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
*   All released documents
    WHEN 'FREI'.
      CALL METHOD gr_grid_dstat->set_all_released
        IMPORTING
          et_tdwst = gt_tdwst_sel.
    WHEN 'OK'.
*     Get selected entries
      CALL METHOD gr_grid_dstat->get_selected_entries
        IMPORTING
          et_tdwst = gt_tdwst_sel.
      FREE gr_container.
      LEAVE TO SCREEN 0.
    WHEN 'RW'.
      FREE gr_container.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.                 " USER_COMMAND_0100  INPUT
