*----------------------------------------------------------------------*
***INCLUDE LN1DOCSTATO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  SET PF-STATUS '0100'.
  SET TITLEBAR '001'.

ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  create_grid  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE create_grid OUTPUT.

  IF gr_grid_dstat IS INITIAL.
    CREATE OBJECT gr_container
      EXPORTING
        container_name              = 'CONTAINER_DOC'
         repid                       = sy-repid
         dynnr                       = sy-dynnr.
    CREATE OBJECT gr_grid_dstat
      EXPORTING
        i_parent = gr_container
        i_caller = sy-repid.
  ENDIF.

  CALL METHOD gr_grid_dstat->set_selected_entries
    EXPORTING
      it_tdwst = gt_tdwst_sel.

ENDMODULE.                 " create_grid  OUTPUT
