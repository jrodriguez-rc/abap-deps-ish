*----------------------------------------------------------------------*
***INCLUDE LN1_GUI_SDY_XTABSTRIPI01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Module  before_pai_0100  INPUT
*&---------------------------------------------------------------------*
MODULE before_pai_0100 INPUT.

  cl_ish_gui_dynpro_connector=>before_pai( i_repid = co_repid ).

ENDMODULE.                 " BEFORE_PAI_0100  INPUT


*&---------------------------------------------------------------------*
*&      Module  pai_0100  INPUT
*&---------------------------------------------------------------------*
MODULE pai_0100 INPUT.

  cl_ish_gui_dynpro_connector=>pai( i_repid = co_repid ).

ENDMODULE.                 " PAI_0100  INPUT


*&---------------------------------------------------------------------*
*&      Module  after_pai_0100  INPUT
*&---------------------------------------------------------------------*
MODULE after_pai_0100 INPUT.

  cl_ish_gui_dynpro_connector=>after_pai( i_repid = co_repid ).

ENDMODULE.                 " AFTER_PAI_0100  INPUT
