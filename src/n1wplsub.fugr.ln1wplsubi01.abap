*----------------------------------------------------------------------*
***INCLUDE LN1WPLSUBI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  CHECK_EINRI  INPUT
*&---------------------------------------------------------------------*
MODULE check_einri INPUT.

  PERFORM check_einri USING rn1_scr_wplsub100-einri
                            'RN1_SCR_WPLSUB100-EINRI'.

ENDMODULE.                 " CHECK_EINRI  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_PFLEGOE  INPUT
*&---------------------------------------------------------------------*
MODULE check_pflegoe INPUT.

  PERFORM check_orgid USING rn1_scr_wplsub100-einri
                            rn1_scr_wplsub100-pflegoe
                            'RN1_SCR_WPLSUB100-PFLEGOE'
                            '*' '*' '*' '*'.

ENDMODULE.                 " CHECK_PFLEGOE  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_FACHLOE  INPUT
*&---------------------------------------------------------------------*
MODULE check_fachloe INPUT.

  PERFORM check_orgid USING rn1_scr_wplsub100-einri
                            rn1_scr_wplsub100-fachloe
                            'RN1_SCR_WPLSUB100-FACHLOE'
                            '*' '*' '*' '*'.

ENDMODULE.                 " CHECK_FACHLOE  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_ERBOE  INPUT
*&---------------------------------------------------------------------*
MODULE check_erboe INPUT.

  PERFORM check_orgid USING rn1_scr_wplsub100-einri
                            rn1_scr_wplsub100-erboe
                            'RN1_SCR_WPLSUB100-ERBOE'
                            '*' '*' '*' '*'.

ENDMODULE.                 " CHECK_ERBOE  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_PLANOE  INPUT
*&---------------------------------------------------------------------*
MODULE check_planoe INPUT.

  PERFORM check_orgid USING rn1_scr_wplsub100-einri
                            rn1_scr_wplsub100-planoe
                            'RN1_SCR_WPLSUB100-PLANOE'
                            '*' '*' '*' '*'.

ENDMODULE.                 " CHECK_PLANOE  INPUT

*&---------------------------------------------------------------------*
*&      Module  HELP_PFLEGOE  INPUT
*&---------------------------------------------------------------------*
MODULE help_pflegoe INPUT.

  PERFORM help_orgid USING    'RN1_SCR_WPLSUB100-EINRI'
                              'RN1_SCR_WPLSUB100-PFLEGOE'
                     CHANGING  rn1_scr_wplsub100-einri
                               rn1_scr_wplsub100-pflegoe.

ENDMODULE.                 " HELP_PFLEGOE  INPUT

*&---------------------------------------------------------------------*
*&      Module  HELP_FACHLOE  INPUT
*&---------------------------------------------------------------------*
MODULE help_fachloe INPUT.

  PERFORM help_orgid USING    'RN1_SCR_WPLSUB100-EINRI'
                              'RN1_SCR_WPLSUB100-FACHLOE'
                     CHANGING  rn1_scr_wplsub100-einri
                               rn1_scr_wplsub100-fachloe.

ENDMODULE.                 " HELP_FACHLOE  INPUT

*&---------------------------------------------------------------------*
*&      Module  HELP_ERBOE  INPUT
*&---------------------------------------------------------------------*
MODULE help_erboe INPUT.

  PERFORM help_orgid USING    'RN1_SCR_WPLSUB100-EINRI'
                              'RN1_SCR_WPLSUB100-ERBOE'
                     CHANGING  rn1_scr_wplsub100-einri
                               rn1_scr_wplsub100-erboe.

ENDMODULE.                 " HELP_ERBOE  INPUT

*&---------------------------------------------------------------------*
*&      Module  HELP_PLANOE  INPUT
*&---------------------------------------------------------------------*
MODULE help_planoe INPUT.

  PERFORM help_orgid USING    'RN1_SCR_WPLSUB100-EINRI'
                              'RN1_SCR_WPLSUB100-PLANOE'
                     CHANGING  rn1_scr_wplsub100-einri
                               rn1_scr_wplsub100-planoe.

ENDMODULE.                 " HELP_PLANOE  INPUT

*&---------------------------------------------------------------------*
*&      Module  HELP_EINRI  INPUT
*&---------------------------------------------------------------------*
MODULE help_einri INPUT.

  PERFORM help_einri CHANGING rn1_scr_wplsub100-einri.

ENDMODULE.                 " HELP_EINRI  INPUT
