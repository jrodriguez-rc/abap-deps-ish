CLASS cl_ish_ga_popup DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_gui_application
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS co_ctrname_popup TYPE n1gui_element_name VALUE 'POPUP_CTR'. "#EC NOTEXT
    CONSTANTS co_mdy_dynnr TYPE sydynnr VALUE '0100'. "#EC NOTEXT
    CONSTANTS co_mdy_dynnr_to TYPE sydynnr VALUE '0110'. "#EC NOTEXT
    CONSTANTS co_mdy_repid TYPE syrepid VALUE 'SAPLN1_GUI_MDY_POPUP_SIMPLE'. "#EC NOTEXT
    CONSTANTS co_viewname_popup TYPE n1gui_element_name VALUE 'SC_POPUP'. "#EC NOTEXT

    METHODS constructor
      IMPORTING
        !i_element_name TYPE n1gui_element_name OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL.
    METHODS get_popup_ctr
      RETURNING
        VALUE(rr_ctr) TYPE REF TO if_ish_gui_controller.
    METHODS get_popup_view
      RETURNING
        VALUE(rr_view) TYPE REF TO if_ish_gui_sdy_view.
  PROTECTED SECTION.

    DATA g_end_col TYPE i.
    DATA g_end_row TYPE i.
    DATA g_start_col TYPE i.
    DATA g_start_row TYPE i.

    METHODS _cmd_cancel
      RETURNING
        VALUE(r_exit) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _cmd_enter ABSTRACT
      RETURNING
        VALUE(r_exit) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _create_pfstatus
      RETURNING
        VALUE(rr_pfstatus) TYPE REF TO cl_ish_gui_mdy_pfstatus
      RAISING
        cx_ish_static_handler.
    METHODS _create_titlebar
      RETURNING
        VALUE(rr_titlebar) TYPE REF TO cl_ish_gui_mdy_titlebar
      RAISING
        cx_ish_static_handler.
    METHODS _get_title_text ABSTRACT
      RETURNING
        VALUE(r_title_text) TYPE string
      RAISING
        cx_ish_static_handler.
    METHODS _init_ga_popup
      IMPORTING
        !i_vcode TYPE ish_vcode DEFAULT if_ish_gui_view=>co_vcode_display
        !ir_layout TYPE REF TO cl_ish_gui_appl_layout OPTIONAL
        !i_messages_view_name TYPE n1gui_element_name DEFAULT co_def_messages_view_name
        !i_default_ucomm TYPE syucomm DEFAULT space
        !i_start_row TYPE i DEFAULT 0
        !i_start_col TYPE i DEFAULT 0
        !i_end_row TYPE i DEFAULT 0
        !i_end_col TYPE i DEFAULT 0
      RAISING
        cx_ish_static_handler.
    METHODS _load_popup_view ABSTRACT
      RAISING
        cx_ish_static_handler.

    METHODS _before_run REDEFINITION.
    METHODS _create_main_controller REDEFINITION.
    METHODS _process_command_request REDEFINITION.
    METHODS _process_mdy_event REDEFINITION.
    METHODS _run REDEFINITION.
  PRIVATE SECTION.

ENDCLASS.



CLASS cl_ish_ga_popup IMPLEMENTATION.


  METHOD constructor.

  ENDMETHOD.


  METHOD get_popup_ctr.

  ENDMETHOD.


  METHOD get_popup_view.

  ENDMETHOD.


  METHOD _before_run.

  ENDMETHOD.


  METHOD _cmd_cancel.

  ENDMETHOD.


  METHOD _create_main_controller.

  ENDMETHOD.


  METHOD _create_pfstatus.

  ENDMETHOD.


  METHOD _create_titlebar.

  ENDMETHOD.


  METHOD _init_ga_popup.

  ENDMETHOD.


  METHOD _process_command_request.

  ENDMETHOD.


  METHOD _process_mdy_event.

  ENDMETHOD.


  METHOD _run.

  ENDMETHOD.


ENDCLASS.