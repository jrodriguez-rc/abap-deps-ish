*----------------------------------------------------------------------*
***INCLUDE LN1_BC_MDY_SPEC_CREATEI01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Module  exit_0100  INPUT
*&---------------------------------------------------------------------*
MODULE exit_0100 INPUT.

  IF cl_ish_gui_dynpro_connector=>exit_command( i_repid = co_repid
                                                i_ucomm = g_ucomm_0100 ) = abap_true.
    LEAVE TO SCREEN 0.
  ENDIF.

ENDMODULE.                 " exit_0100  INPUT


*&---------------------------------------------------------------------*
*&      Module  before_pai_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE before_pai_0100 INPUT.

  cl_ish_gui_dynpro_connector=>before_pai(
      i_repid = co_repid
      i_ucomm = g_ucomm_0100 ).

ENDMODULE.                 " before_pai_0100  OUTPUT


*&---------------------------------------------------------------------*
*&      Module  pai_0100  INPUT
*&---------------------------------------------------------------------*
MODULE pai_0100 INPUT.

  cl_ish_gui_dynpro_connector=>pai( i_repid = co_repid ).

ENDMODULE.                 " pai_0100  INPUT


*&---------------------------------------------------------------------*
*&      Module  after_pai_0100  INPUT
*&---------------------------------------------------------------------*
MODULE after_pai_0100 INPUT.

  cl_ish_gui_dynpro_connector=>after_pai( i_repid = co_repid ).

ENDMODULE.                 " after_pai_0100  INPUT


*&---------------------------------------------------------------------*
*&      Module  ucomm_0100  INPUT
*&---------------------------------------------------------------------*
MODULE ucomm_0100 INPUT.

  IF cl_ish_gui_dynpro_connector=>user_command( i_repid = co_repid
                                                i_ucomm = g_ucomm_0100 ) = abap_true.
    LEAVE TO SCREEN 0.
  ENDIF.

ENDMODULE.                 " ucomm_0100  INPUT

***Begin of MED-48629, Jitareanu Cristina 24.10.2012  "für die Rekonstruktion der Fallliste
*---------------------------------------------------------------------*
* Module LIST_FALLIST   INPUT
*---------------------------------------------------------------------*
MODULE list_fallist INPUT.
  LEAVE TO LIST-PROCESSING.
  NEW-PAGE NO-TITLE LINE-SIZE 95.                           " Nr 4652
* Beim AT USER-COMMAND geschieht irgendetwas Seltsames mit SY-DYNNR
* deshalb hier SY-DYNNR merken
* REM ID 3974: wird bereits vor CALL SCREEN gesetzt ...
* my_dynnr = sy-dynnr.                                       " ID 3974
* Die Liste nun anzeigen
  sy-cpage = 1.
  sy-staro = 1.
  sy-staco = 1.
  PERFORM show_fallist.
ENDMODULE.    " LIST_FALLIST

***End of MED-48629, Jitareanu Cristina 24.10.2012  "für die Rekonstruktion der Fallliste
