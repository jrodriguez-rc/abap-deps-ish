CLASS cl_ish_ga_popup_simple DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_ga_popup
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !i_element_name TYPE n1gui_element_name OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL.
    METHODS get_popup_model
      RETURNING
        VALUE(rr_model) TYPE REF TO if_ish_gui_model.
    METHODS initialize
      IMPORTING
        !i_vcode TYPE ish_vcode DEFAULT if_ish_gui_view=>co_vcode_display
        !ir_layout TYPE REF TO cl_ish_gui_appl_layout OPTIONAL
        !i_messages_view_name TYPE n1gui_element_name DEFAULT co_def_messages_view_name
        !i_default_ucomm TYPE syucomm DEFAULT space
        !i_start_row TYPE i OPTIONAL
        !i_start_col TYPE i OPTIONAL
        !i_end_row TYPE i OPTIONAL
        !i_end_col TYPE i OPTIONAL
        !i_title_text TYPE string
        !i_popup_repid TYPE syrepid
        !i_popup_dynnr TYPE sydynnr
        !i_popup_dynpstruct_name TYPE tabname OPTIONAL
        !ir_popup_model TYPE REF TO if_ish_gui_model OPTIONAL
      RAISING
        cx_ish_static_handler.
  PROTECTED SECTION.

    DATA gr_popup_model TYPE REF TO if_ish_gui_model.
    DATA g_popup_dynnr TYPE sydynnr.
    DATA g_popup_dynpstruct_name TYPE tabname.
    DATA g_popup_repid TYPE syrepid.
    DATA g_title_text TYPE string.

    METHODS _cmd_enter REDEFINITION.
    METHODS _get_title_text REDEFINITION.
    METHODS _load_popup_view REDEFINITION.
  PRIVATE SECTION.

ENDCLASS.



CLASS cl_ish_ga_popup_simple IMPLEMENTATION.


  METHOD constructor.

  ENDMETHOD.


  METHOD get_popup_model.

    rr_model = gr_popup_model.

  ENDMETHOD.


  METHOD initialize.

  ENDMETHOD.


  METHOD _cmd_enter.

  ENDMETHOD.


  METHOD _get_title_text.

  ENDMETHOD.


  METHOD _load_popup_view.

  ENDMETHOD.


ENDCLASS.