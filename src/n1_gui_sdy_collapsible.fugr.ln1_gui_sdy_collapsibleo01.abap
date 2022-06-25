*----------------------------------------------------------------------*
***INCLUDE LN1_GUI_SDY_COLLAPSIBLEO01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Module  before_pbo_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE before_pbo_0100 OUTPUT.

  cl_ish_gui_dynpro_connector=>before_pbo(
      i_repid = co_repid ).

ENDMODULE.                 " before_pbo_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  pbo_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE pbo_0100 OUTPUT.

  CALL METHOD cl_ish_gui_dynpro_connector=>pbo
    EXPORTING
      i_repid       = co_repid
    CHANGING
      cs_dynpstruct = rn1_dynp_gui_collapsible_pb.

ENDMODULE.                 " pbo_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  before_pbo_sc_area_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE before_pbo_sc_area_0100 OUTPUT.

  CALL METHOD cl_ish_gui_dynpro_connector=>before_call_subscreen
    EXPORTING
      i_repid           = co_repid
      i_subscreen_name  = 'SC_AREA'
    IMPORTING
      e_subscreen_repid = g_repid_sc_area_0100
      e_subscreen_dynnr = g_dynnr_sc_area_0100.

ENDMODULE.                 " before_pbo_sc_area_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  after_pbo_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE after_pbo_0100 OUTPUT.

  cl_ish_gui_dynpro_connector=>after_pbo(
      i_repid = co_repid ).

ENDMODULE.                 " after_pbo_0100  OUTPUT
