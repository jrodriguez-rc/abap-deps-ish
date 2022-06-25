*----------------------------------------------------------------------*
***INCLUDE LN2_POPUP_FOR_ENTER_VALUESI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  d100_upper_case  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE d100_upper_case INPUT.

  IF dfies-lowercase NE 'X'.
    TRANSLATE rntools-field TO UPPER CASE.               "#EC TRANSLANG
  ENDIF.

ENDMODULE.                 " d100_upper_case  INPUT
*&---------------------------------------------------------------------*
*&      Module  d100_convert_input  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE d100_convert_input INPUT.

  CALL FUNCTION 'G_CONVERT_INPUT'
    EXPORTING
      converted_length         = dfies-leng
      convexit                 = dfies-convexit
      datatype                 = dfies-datatype
      input_length             = dfies-outputlen
      input_value              = rntools-field
    IMPORTING
      converted_value          = rntools-field
    EXCEPTIONS
      date_does_not_exist      = 01
      date_format_unrecognized = 02
      illegal_length           = 03
      input_is_not_numeric     = 04.


ENDMODULE.                 " d100_convert_input  INPUT
*&---------------------------------------------------------------------*
*&      Module  d100_numeric_only  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE d100_numeric_only INPUT.

  CHECK g_numeric_only = on.

  IF rntools-field CN ' 0123456789'.
    MESSAGE e035(n1base).
*   Bitte nur numerische Werte eingeben
  ENDIF.

ENDMODULE.                 " d100_numeric_only  INPUT

*&---------------------------------------------------------------------*
*&      Module  d100_external_check  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE d100_external_check INPUT.

  IF g_external_check = on.
    PERFORM (g_check_form_name) IN PROGRAM (g_check_program_name)
            USING rntools-field.
  ENDIF.

ENDMODULE.                 " d100_external_check  INPUT

*&---------------------------------------------------------------------*
*&      Module  d100_give_values  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE d100_give_values INPUT.

  IF dfies-domname NE 'RLDNR'.
    CALL FUNCTION 'HELP_VALUES_GET'
      EXPORTING
        fieldname    = g_selected_field
        tabname      = g_selected_table
      IMPORTING
        select_value = rntools-field.    "#EC FB_OLDED
  ENDIF.

ENDMODULE.                 " d100_give_values  INPUT

*&---------------------------------------------------------------------*
*&      Module  d100_process_ok_code  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE d100_process_ok_code INPUT.

  MOVE ok-code TO save_ok_code.
  CLEAR ok-code.
  CASE save_ok_code.
    WHEN 'ENTER'.
      g_value = rntools-field.
      SET SCREEN 0.
      LEAVE SCREEN.
  ENDCASE.

ENDMODULE.                 " d100_process_ok_code  INPUT
*&---------------------------------------------------------------------*
*&      Module  d100_abbruch  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE d100_abbruch INPUT.

  IF ok-code EQ 'CANC'.
    CLEAR ok-code.
    g_cancel = 'X'.
    SET SCREEN 0.
    LEAVE SCREEN.
  ENDIF.

ENDMODULE.                 " d100_abbruch  INPUT
*&---------------------------------------------------------------------*
*&      Module  d100_help_display  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE d100_help_display INPUT.

  PERFORM help_display.

ENDMODULE.                 " d100_help_display  INPUT
