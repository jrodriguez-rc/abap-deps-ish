*----------------------------------------------------------------------*
***INCLUDE LN1_BC_SDY_CHEADO01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Module  before_pbo_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE before_pbo_0100 OUTPUT.

  cl_ish_gui_dynpro_connector=>before_pbo( i_repid = co_repid ).

ENDMODULE.                 " before_pbo_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  pbo_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE pbo_0100 OUTPUT.

  CALL METHOD cl_ish_gui_dynpro_connector=>pbo
    EXPORTING
      i_repid       = co_repid
    CHANGING
      cs_dynpstruct = rn1_gui_dynp_layo_splitter.

ENDMODULE.                 " pbo_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  after_pbo_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE after_pbo_0100 OUTPUT.

  cl_ish_gui_dynpro_connector=>after_pbo( i_repid = co_repid ).

ENDMODULE.                 " after_pbo_0100  OUTPUT
