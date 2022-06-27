CLASS cx_ish_static_handler DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

*"* public components of class CX_ISH_STATIC_HANDLER
*"* do not include other source files here!!!
  PUBLIC SECTION.

    DATA gr_errorhandler TYPE REF TO cl_ishmed_errorhandling.
    DATA gr_msgtyp TYPE sy-msgty VALUE 'E' ##NO_TEXT.

    METHODS constructor
    IMPORTING
      !textid LIKE textid OPTIONAL
      !previous LIKE previous OPTIONAL
      !gr_errorhandler TYPE REF TO cl_ishmed_errorhandling OPTIONAL
      !gr_msgtyp TYPE sy-msgty DEFAULT 'E'.
    METHODS get_errorhandler
    IMPORTING
      VALUE(i_no_default_msg) TYPE ish_on_off DEFAULT space
    EXPORTING
      !er_errorhandler TYPE REF TO cl_ishmed_errorhandling.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS cx_ish_static_handler IMPLEMENTATION.


  METHOD constructor.
  ENDMETHOD.


  METHOD get_errorhandler.
  ENDMETHOD.


ENDCLASS.