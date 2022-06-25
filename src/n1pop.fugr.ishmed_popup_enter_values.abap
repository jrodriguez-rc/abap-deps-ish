FUNCTION ISHMED_POPUP_ENTER_VALUES.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_FIELD) TYPE  DFIES-FIELDNAME
*"     VALUE(I_TABLE) TYPE  DFIES-TABNAME
*"     VALUE(I_TITLE_OF_POPUP)
*"     VALUE(I_NUMERIC_ONLY) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_EXTERNAL_CHECK) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_KEYWORD) TYPE  DFIES-SCRTEXT_L DEFAULT SPACE
*"     VALUE(I_CHECK_PROGRAM_NAME) TYPE  TRDIR-NAME OPTIONAL
*"     VALUE(I_CHECK_FORM_NAME) OPTIONAL
*"     VALUE(I_F1FIELDNAME) TYPE  TRDIR-NAME OPTIONAL
*"  CHANGING
*"     REFERENCE(C_VALUE) OPTIONAL
*"  EXCEPTIONS
*"      CANCELLED
*"      INPUT_ERROR
*"----------------------------------------------------------------------

  CLEAR g_cancel.

  CALL FUNCTION 'G_FIELD_READ'
    EXPORTING
      fieldname  = i_field
      langu      = sy-langu
      table      = i_table
      text_flag  = 'X'
    IMPORTING
      field_attr = g_dfies1
    EXCEPTIONS
      not_found  = 01.

  IF sy-subrc NE 0.
    MESSAGE e025(gg) WITH i_field i_table RAISING input_error.
  ENDIF.

  g_value              = c_value.

  g_title_of_popup     = i_title_of_popup.
  g_numeric_only       = i_numeric_only.
  g_selected_field     = i_field.
  g_selected_table     = i_table.
  g_f1fieldname        = i_f1fieldname.

  IF i_external_check = on AND
     ( i_check_program_name IS INITIAL OR
       i_check_form_name IS INITIAL ) .
    g_external_check = off.
  ELSE.
    g_external_check     = i_external_check.
    g_check_program_name = i_check_program_name.
    g_check_form_name    = i_check_form_name.
  ENDIF.

* use own keyword
  IF i_keyword NE space.
    g_dfies1-scrtext_l = i_keyword.
  ENDIF.

  CALL SCREEN 100 STARTING AT 25 01
                  ENDING   AT 70 02.
  IF g_cancel = 'X'.
    RAISE cancelled.
  ENDIF.

  c_value = g_value.

ENDFUNCTION.
