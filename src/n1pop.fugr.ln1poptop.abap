FUNCTION-POOL N1POP.    "MESSAGE-ID ..

INCLUDE mndata00.

TABLES: dfies, rntools.

DATA: g_dfies1               TYPE dfies,
      g_cancel(1)            TYPE c,
      save_ok_code           TYPE sy-ucomm,
      g_title_of_popup(30)   TYPE c,
      g_numeric_only         TYPE ish_on_off,
      g_value(20)            TYPE c,
      g_external_check       TYPE ish_on_off,
      g_selected_field       TYPE dfies-fieldname,
      g_selected_table       TYPE dfies-tabname,
      g_check_program_name   TYPE trdir-name,
      g_check_form_name(100) TYPE c,
      g_f1fieldname          TYPE trdir-name.

*
