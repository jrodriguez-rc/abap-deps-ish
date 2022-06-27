CLASS cl_ish_ga_popup_html DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_ga_popup
  CREATE PUBLIC.

  PUBLIC SECTION.

    CONSTANTS co_ctrname_html TYPE n1gui_element_name VALUE 'HTML_CTR'. "#EC NOTEXT
    CONSTANTS co_viewname_html TYPE n1gui_element_name VALUE 'HTML_VIEW'. "#EC NOTEXT

    CLASS-METHODS execute_by_url
      IMPORTING
        !i_start_row TYPE i OPTIONAL
        !i_start_col TYPE i OPTIONAL
        !i_end_row TYPE i OPTIONAL
        !i_end_col TYPE i OPTIONAL
        !i_title_text TYPE string
        !i_url TYPE n1url_www
      RAISING
        cx_ish_static_handler.
    CLASS-METHODS execute_by_url_model
      IMPORTING
        !i_start_row TYPE i OPTIONAL
        !i_start_col TYPE i OPTIONAL
        !i_end_row TYPE i OPTIONAL
        !i_end_col TYPE i OPTIONAL
        !i_title_text TYPE string
        !ir_url_model TYPE REF TO if_ish_gui_structure_model
        !i_fieldname_url TYPE ish_fieldname
      RAISING
        cx_ish_static_handler.
    METHODS initialize
      IMPORTING
        !i_start_row TYPE i OPTIONAL
        !i_start_col TYPE i OPTIONAL
        !i_end_row TYPE i OPTIONAL
        !i_end_col TYPE i OPTIONAL
        !i_title_text TYPE string
        !i_url TYPE n1url_www OPTIONAL
        !ir_url_model TYPE REF TO if_ish_gui_structure_model OPTIONAL
        !i_fieldname_url TYPE ish_fieldname OPTIONAL
      RAISING
        cx_ish_static_handler.
  PROTECTED SECTION.

    DATA gr_url_model TYPE REF TO if_ish_gui_structure_model.
    DATA g_fieldname_url TYPE ish_fieldname.
    DATA g_title_text TYPE string.
    DATA g_url TYPE n1url_www.

    METHODS _cmd_enter REDEFINITION.
    METHODS _get_title_text REDEFINITION.
    METHODS _load_popup_view REDEFINITION.
    METHODS _destroy REDEFINITION.
  PRIVATE SECTION.

ENDCLASS.



CLASS cl_ish_ga_popup_html IMPLEMENTATION.


  METHOD execute_by_url.

  ENDMETHOD.


  METHOD execute_by_url_model.

  ENDMETHOD.


  METHOD initialize.

  ENDMETHOD.


  METHOD _cmd_enter.

  ENDMETHOD.


  METHOD _destroy.

  ENDMETHOD.


  METHOD _get_title_text.

  ENDMETHOD.


  METHOD _load_popup_view.

  ENDMETHOD.


ENDCLASS.