*----------------------------------------------------------------------*
***INCLUDE LN_SDY_COLLAPSILBEO01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Module  initialize_0100  OUTPUT
*&---------------------------------------------------------------------*
*       initialize dynpro 100
*----------------------------------------------------------------------*
MODULE initialize_0100 OUTPUT.
  PERFORM initialize_0100.
ENDMODULE.                 " initialize_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  pbo_pb_collapse  OUTPUT
*&---------------------------------------------------------------------*
*       Process Before Output for SC_PB_COLLAPSE
*----------------------------------------------------------------------*
MODULE pbo_pb_collapse OUTPUT.
  PERFORM pbo_pb_collapse.
ENDMODULE.                 " pbo_pb_collapse  OUTPUT
