*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_ADMISSIONO01 .
*----------------------------------------------------------------------*

* Michael Manoch, 11.02.2010, MED-38637
* Whole dynpros redesigned.


*&---------------------------------------------------------------------*
*&      Module  pbo  OUTPUT
*&---------------------------------------------------------------------*
MODULE pbo OUTPUT.

  cl_ish_dynpconn_mgr=>process_pbo( i_repid = co_repid ).

ENDMODULE.                 " pbo  OUTPUT

**&---------------------------------------------------------------------*
**&      Module  pbo_0100  OUTPUT
**&---------------------------------------------------------------------*
**       Process Before Output for dynpro 0100.
**----------------------------------------------------------------------*
*MODULE pbo_0100 OUTPUT.
*
*  PERFORM pbo_0100.
*
*ENDMODULE.                 " pbo_0100  OUTPUT
*
*
**&---------------------------------------------------------------------*
**&      Module  pbo_lb_falar_0100  OUTPUT
**&---------------------------------------------------------------------*
**       Process Before Output for SC_LB_FALAR on dynpro 0100.
**----------------------------------------------------------------------*
*MODULE pbo_lb_falar_0100 OUTPUT.
*
*  PERFORM pbo_lb_falar_0100.
*
*ENDMODULE.                 " pbo_lb_falar_0100  OUTPUT
*
*
**&---------------------------------------------------------------------*
**&      Module  pbo_lb_fatyp_0100  OUTPUT
**&---------------------------------------------------------------------*
**       Process Before Output for SC_LB_FATYP on dynpro 0100.
**----------------------------------------------------------------------*
*MODULE pbo_lb_fatyp_0100 OUTPUT.
*
*  PERFORM pbo_lb_fatyp_0100.
*
*ENDMODULE.                 " pbo_lb_fatyp_0100  OUTPUT
*
*
**&---------------------------------------------------------------------*
**&      Module  pbo_lb_bewar_0100  OUTPUT
**&---------------------------------------------------------------------*
**       Process Before Output for SC_LB_BEWAR on dynpro 0100.
**----------------------------------------------------------------------*
*MODULE pbo_lb_bewar_0100 OUTPUT.
*
*  PERFORM pbo_lb_bewar_0100.
*
*ENDMODULE.                 " pbo_lb_bewar_0100  OUTPUT
