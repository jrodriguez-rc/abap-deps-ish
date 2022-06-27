CLASS cl_ish_gui_control_layout DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_gui_view_layout
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !i_element_name TYPE n1gui_element_name OPTIONAL
        !i_layout_name TYPE n1gui_layout_name OPTIONAL
      PREFERRED PARAMETER i_element_name.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS cl_ish_gui_control_layout IMPLEMENTATION.


  METHOD constructor.

  ENDMETHOD.


ENDCLASS.