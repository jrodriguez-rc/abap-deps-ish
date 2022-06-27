CLASS cl_ish_gui_control_view DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_gui_view
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
*"* public components of class CL_ISH_GUI_CONTROL_VIEW
*"* do not include other source files here!!!

    INTERFACES if_ish_gui_control_view.

    ALIASES first_display FOR if_ish_gui_control_view~first_display.
    ALIASES get_control FOR if_ish_gui_control_view~get_control.
    ALIASES get_control_layout FOR if_ish_gui_control_view~get_control_layout.
    ALIASES get_visibility FOR if_ish_gui_control_view~get_visibility.
    ALIASES refresh_display FOR if_ish_gui_control_view~refresh_display.
    ALIASES set_visibility FOR if_ish_gui_control_view~set_visibility.
    ALIASES ev_visibility_changed FOR if_ish_gui_control_view~ev_visibility_changed.

    CLASS-EVENTS ev_dispatch.
    CLASS-EVENTS ev_flush.

    CLASS-METHODS activate_flush_buffer
      RETURNING
        VALUE(r_activated) TYPE abap_bool.
    CLASS-METHODS dispatch.
    CLASS-METHODS flush.
    CLASS-METHODS is_flush_buffer_active
      RETURNING
        VALUE(r_flush_buffer_active) TYPE abap_bool.
    METHODS constructor
      IMPORTING
        !i_element_name TYPE n1gui_element_name OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
      PREFERRED PARAMETER i_element_name.

    METHODS if_ish_gui_view~set_focus REDEFINITION.
  PROTECTED SECTION.
    DATA gr_control TYPE REF TO cl_gui_control.
    DATA g_visible TYPE abap_bool.

    METHODS on_child_visibility_changed FOR EVENT ev_visibility_changed OF if_ish_gui_control_view
      IMPORTING
        !e_visible
        !sender.
    METHODS on_dispatch
      FOR EVENT ev_dispatch OF cl_ish_gui_control_view.
    METHODS _create_control ABSTRACT
      RETURNING
        VALUE(rr_control) TYPE REF TO cl_gui_control
      RAISING
        cx_ish_static_handler.
    METHODS _create_control_on_demand
      RETURNING
        VALUE(rr_control) TYPE REF TO cl_gui_control
      RAISING
        cx_ish_static_handler.
    METHODS _first_display ABSTRACT
      RAISING
        cx_ish_static_handler.
    METHODS _init_control_view
      IMPORTING
        !ir_controller TYPE REF TO if_ish_gui_controller
        !ir_parent_view TYPE REF TO if_ish_gui_view
        !ir_layout TYPE REF TO cl_ish_gui_control_layout OPTIONAL
        !i_vcode TYPE tndym-vcode DEFAULT if_ish_gui_view=>co_vcode_display
      RAISING
        cx_ish_static_handler.
    METHODS _refresh_display ABSTRACT
      IMPORTING
        !i_force TYPE abap_bool DEFAULT abap_false
      RAISING
        cx_ish_static_handler.

    METHODS _add_child_view REDEFINITION.
    METHODS _destroy REDEFINITION.
    METHODS _remove_child_view REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.



CLASS cl_ish_gui_control_view IMPLEMENTATION.


  METHOD activate_flush_buffer.

  ENDMETHOD.


  METHOD constructor.

  ENDMETHOD.


  METHOD dispatch.

  ENDMETHOD.


  METHOD flush.

  ENDMETHOD.


  METHOD if_ish_gui_control_view~first_display.

  ENDMETHOD.


  METHOD if_ish_gui_control_view~get_control.

  ENDMETHOD.


  METHOD if_ish_gui_control_view~get_control_layout.

  ENDMETHOD.


  METHOD if_ish_gui_control_view~get_visibility.

  ENDMETHOD.


  METHOD if_ish_gui_control_view~refresh_display.

  ENDMETHOD.


  METHOD if_ish_gui_control_view~set_visibility.

  ENDMETHOD.


  METHOD if_ish_gui_view~set_focus.

  ENDMETHOD.


  METHOD is_flush_buffer_active.

  ENDMETHOD.


  METHOD on_child_visibility_changed.
  ENDMETHOD.


  METHOD on_dispatch.

  ENDMETHOD.


  METHOD _add_child_view.

  ENDMETHOD.


  METHOD _create_control_on_demand.

  ENDMETHOD.


  METHOD _destroy.

  ENDMETHOD.


  METHOD _init_control_view.

  ENDMETHOD.


  METHOD _remove_child_view.

  ENDMETHOD.


ENDCLASS.