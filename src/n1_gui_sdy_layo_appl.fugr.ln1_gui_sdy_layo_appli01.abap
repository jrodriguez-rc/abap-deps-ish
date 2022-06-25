*----------------------------------------------------------------------*
***INCLUDE LN1_BC_SDY_CHEADI01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Module  before_pai_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE before_pai_0100 INPUT.

  cl_ish_gui_dynpro_connector=>before_pai( i_repid = co_repid ).

ENDMODULE.                 " before_pai_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  pai_0100  INPUT
*&---------------------------------------------------------------------*
MODULE pai_0100 INPUT.

  cl_ish_gui_dynpro_connector=>pai(
      i_repid       = co_repid
      is_dynpstruct = rn1_gui_dynp_layo_appl ).

ENDMODULE.                 " pai_0100  INPUT


*&---------------------------------------------------------------------*
*&      Module  after_pai_0100  INPUT
*&---------------------------------------------------------------------*
MODULE after_pai_0100 INPUT.

  cl_ish_gui_dynpro_connector=>after_pai( i_repid = co_repid ).

ENDMODULE.                 " after_pai_0100  INPUT
