*----------------------------------------------------------------------*
***INCLUDE LN2_POPUP_FOR_ENTER_VALUESO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  d100_init  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE d100_init OUTPUT.

  SET PF-STATUS 'ST_D100'.
  SET TITLEBAR '100' WITH g_title_of_popup.

  CLEAR rntools.
  dfies = g_dfies1.

  rntools-text  = dfies-scrtext_l.
  rntools-field = g_value.

  CALL FUNCTION 'G_CONVERT_OUTPUT'
    EXPORTING
      convexit          = dfies-convexit
      datatype          = dfies-datatype
      length_to_convert = dfies-leng
      output_length     = dfies-outputlen
      value_to_convert  = rntools-field
    IMPORTING
      output_value      = rntools-field
    EXCEPTIONS
      illegal_length    = 01.


ENDMODULE.                 " d100_init  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  d100_check_modus  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE d100_check_modus OUTPUT.

  LOOP AT SCREEN.
    IF screen-group1 = 'FEL'.
      screen-length = dfies-outputlen.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

ENDMODULE.                 " d100_check_modus  OUTPUT
