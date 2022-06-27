CLASS cl_ish_gui_element DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_ish_gui_element
      FINAL METHODS get_element_id
                    get_element_name.

    ALIASES get_element_id FOR if_ish_gui_element~get_element_id.
    ALIASES get_element_name FOR if_ish_gui_element~get_element_name.

    CONSTANTS co_fieldname_element_id TYPE ish_fieldname VALUE 'ELEMENT_ID'. "#EC NOTEXT
    CONSTANTS co_fieldname_element_name TYPE ish_fieldname VALUE 'ELEMENT_NAME'. "#EC NOTEXT

    METHODS constructor
      IMPORTING
        !i_element_name TYPE n1gui_element_name OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS cl_ish_gui_element IMPLEMENTATION.


  METHOD constructor.

  ENDMETHOD.


  METHOD if_ish_gui_element~get_element_id.

  ENDMETHOD.


  METHOD if_ish_gui_element~get_element_name.

  ENDMETHOD.


ENDCLASS.