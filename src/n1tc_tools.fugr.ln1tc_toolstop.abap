FUNCTION-POOL n1tc_tools.                   "MESSAGE-ID ..


CONSTANTS:
  show_matrix_screen TYPE sy-dynnr VALUE '0100'.

DATA gr_cont                 TYPE REF TO cl_gui_custom_container.
DATA gr_matrix_alv           TYPE REF TO cl_ishmed_tc_matrix_alv.
DATA gt_matrix               TYPE rn1tc_matrix_t.
DATA ok_code                 TYPE sy-ucomm.

* INCLUDE LN1TC_TOOLSD...                    " Local class definition
