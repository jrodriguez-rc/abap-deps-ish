FUNCTION-POOL n1tc_test.                    "MESSAGE-ID ..
INCLUDE mndata_bool.

TABLES: rnpa1,
        rn1tc_stop_clock,
        rn1tc_log_info.

* dynpro values
TYPES: BEGIN OF dyfi_type.
        INCLUDE type dynpread.
TYPES: END OF dyfi_type.

CONSTANTS:
  search_pat_screen TYPE sy-dynnr VALUE '0050',
  test_tc_admin TYPE sy-dynnr VALUE '0781',
  test_tc TYPE sy-dynnr VALUE '0871',
  prog_repid TYPE syrepid VALUE 'SAPLN1TC_TEST'.


**********************************************************************
* DATA
**********************************************************************
DATA g_before_patnr    TYPE patnr.
DATA new_ok            TYPE sy-ucomm.
DATA ok_code           TYPE sy-ucomm.
DATA g_state_srch      TYPE syucomm.                        "#EC NEEDED
DATA g_state_test      TYPE syucomm.
DATA g_init            type flag.
DATA g_use_log         TYPE ish_on_off VALUE on.
* for subscreen
data: sea_repid like sy-repid,
      sea_dynnr like sy-dynnr.
* cursor
DATA g_cursor_field LIKE screen-name.
DATA g_cursor_intensified LIKE screen-intensified.

DATA s_dyfi TYPE dyfi_type.
DATA t_dyfi TYPE TABLE OF dyfi_type.

DATA gr_tc_api TYPE REF TO cl_ishmed_tc_api.
DATA g_uname TYPE xubname.

DATA g_answer_text TYPE n1tc_logtext.

**********************************************************************
* globale Systemeinstellungen
**********************************************************************
DATA g_security_level TYPE n1tc_security_level VALUE '0'.
DATA g_decay_time TYPE n1tc_decay_time VALUE 0.

* INCLUDE LN1TC_TESTD...                     " Local class definition
