*----------------------------------------------------------------------*
***INCLUDE LN1_BC_MDY_SPEC_CREATEO01 .
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

  cl_ish_gui_dynpro_connector=>pbo( i_repid = co_repid ).

ENDMODULE.                 " pbo_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  after_pbo_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE after_pbo_0100 OUTPUT.

  cl_ish_gui_dynpro_connector=>after_pbo( i_repid = co_repid ).

  CLEAR g_ucomm_0100.

ENDMODULE.                 " after_pbo_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  BEFORE_PBO_SC_POPUP_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE before_pbo_sc_popup_0100 OUTPUT.

  CALL METHOD cl_ish_gui_dynpro_connector=>before_call_subscreen
    EXPORTING
      i_repid           = co_repid
      i_subscreen_name  = 'SC_POPUP'
    IMPORTING
      e_subscreen_repid = g_repid_sc_popup_0100
      e_subscreen_dynnr = g_dynnr_sc_popup_0100.

ENDMODULE.                 " BEFORE_PBO_SC_POPUP_0100  OUTPUT


***Begin of MED-48629, Jitareanu Cristina 24.10.2012

*---------------------------------------------------------------------*
*      Module  INIT_CUA  OUTPUT
*---------------------------------------------------------------------*
MODULE init_cua OUTPUT.
  SET TITLEBAR '0200'. "  'ALL' WITH TITLE.
  PERFORM fill_excltab.
  SET PF-STATUS 'U100' EXCLUDING excl_tab.
ENDMODULE.    " INIT_CUA

*---------------------------------------------------------------------*
*       Suppress Dialog                                               *
*---------------------------------------------------------------------*
MODULE suppress_dialog OUTPUT.
  SUPPRESS DIALOG.
ENDMODULE.    " SUPPRESS_DIALOG

***End of MED-48629, Jitareanu Cristina 24.10.2012
