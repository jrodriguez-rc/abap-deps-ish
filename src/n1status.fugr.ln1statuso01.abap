*----------------------------------------------------------------------*
***INCLUDE LN1STATUSO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  init_cua_100  OUTPUT
*&---------------------------------------------------------------------*
*       initialize cua-status and titlebar
*----------------------------------------------------------------------*
MODULE init_cua_100 OUTPUT.

  SET PF-STATUS 'STATUSPOPUP'.
  SET TITLEBAR 'STATUSPOPUP' WITH g_title.

ENDMODULE.                 " init_cua_100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  build_status_grid  OUTPUT
*&---------------------------------------------------------------------*
*       build grid for status popup
*----------------------------------------------------------------------*
MODULE build_status_grid OUTPUT.

  PERFORM build_status_grid.

ENDMODULE.                 " build_status_grid  OUTPUT
