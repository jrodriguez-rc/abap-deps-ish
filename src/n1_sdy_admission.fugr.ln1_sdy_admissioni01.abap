*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_ADMISSIONI01 .
*----------------------------------------------------------------------*

* Michael Manoch, 11.02.2010, MED-38637
* Whole dynpros redesigned.


*&---------------------------------------------------------------------*
*&      Module  pai  INPUT
*&---------------------------------------------------------------------*
MODULE pai INPUT.

  cl_ish_dynpconn_mgr=>process_pai( i_repid = co_repid ).

ENDMODULE.                 " pai  INPUT


*&---------------------------------------------------------------------*
*&      Module  value_request  INPUT
*&---------------------------------------------------------------------*
MODULE value_request INPUT.

  cl_ish_dynpconn_mgr=>process_f4( i_repid = co_repid ).

ENDMODULE.                 " value_request  INPUT

**&---------------------------------------------------------------------*
**&      Module  pai_0100  INPUT
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
*MODULE pai_0100 INPUT.
*
*  PERFORM pai_0100.
*
*ENDMODULE.                 " pai_0100  INPUT
**&---------------------------------------------------------------------*
**&      Module  value_request_bekat  INPUT
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
*MODULE value_request_bekat INPUT.
*
*  PERFORM value_request.
*
*ENDMODULE.                 " value_request_bekat  INPUT
*
*
**&---------------------------------------------------------------------*
**&      Module  pai_lb_falar_0100  INPUT
**&---------------------------------------------------------------------*
**       Process After Input for SC_LB_FALAR on dynpro 0100.
**----------------------------------------------------------------------*
*MODULE pai_lb_falar_0100 INPUT.
*
*  PERFORM pai_lb_falar_0100.
*
*ENDMODULE.                 " pai_lb_falar_0100  INPUT
*
*
**&---------------------------------------------------------------------*
**&      Module  pai_lb_fatyp_0100  INPUT
**&---------------------------------------------------------------------*
**       Process After Input for SC_LB_FATYP on dynpro 0100.
**----------------------------------------------------------------------*
*MODULE pai_lb_fatyp_0100 INPUT.
*
*  PERFORM pai_lb_fatyp_0100.
*
*ENDMODULE.                 " pai_lb_fatyp_0100  INPUT
*
*
**&---------------------------------------------------------------------*
**&      Module  pai_lb_bewar_0100  INPUT
**&---------------------------------------------------------------------*
**       Process After Input for SC_LB_BEWAR on dynpro 0100.
**----------------------------------------------------------------------*
*MODULE pai_lb_bewar_0100 INPUT.
*
*  PERFORM pai_lb_bewar_0100.
*
*ENDMODULE.                 " pai_lb_bewar_0100  INPUT
