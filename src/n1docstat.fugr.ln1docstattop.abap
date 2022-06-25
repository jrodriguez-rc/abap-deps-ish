FUNCTION-POOL n1docstat.                    "MESSAGE-ID ..

TABLES: tdwst.

* Show this lines in the list
DATA: gt_tdwst_list  TYPE STANDARD TABLE OF tdwst.

* Selected lines (to set, and to get back)
DATA: gt_tdwst_sel   TYPE STANDARD TABLE OF tdwst.

* General data
DATA: ok_code        TYPE sy-ucomm.

* ALV data
DATA: gr_container   TYPE REF TO cl_gui_custom_container.
DATA: gr_grid_dstat  TYPE REF TO cl_ish_check_list_doc_stat.

*
