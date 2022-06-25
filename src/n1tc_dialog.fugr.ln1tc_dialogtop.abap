FUNCTION-POOL n1tc_dialog.                  "MESSAGE-ID ..
INCLUDE mndata00.
TABLES: rn1tc_request_dlg,
        rnpa1.

TYPES: BEGIN OF dyfi_type.
        INCLUDE TYPE dynpread.
TYPES: END OF dyfi_type.

CONSTANTS:  request_screen TYPE sy-dynnr VALUE '0100',
            search_pat_screen TYPE sy-dynnr VALUE '0050',
            co_request TYPE n1tc_req_type VALUE if_ishmed_tc_constant_def=>co_tc_req_type_temporary,
            co_delegation TYPE n1tc_req_type VALUE if_ishmed_tc_constant_def=>co_tc_req_type_delegation,
            prog_repid TYPE syrepid VALUE 'SAPLN1TC_DIALOG'.

*            prog_repid TYPE syrepid VALUE 'SAPLN1TC_DIALOG'.


**********************************************************************
* DATA
**********************************************************************
** OK CODE
*DATA new_ok               TYPE sy-ucomm.
DATA g_delegation         TYPE ish_on_off.
DATA g_emergency_possible TYPE ish_on_off.
DATA g_special_request    TYPE ish_on_off. "MED-70766 by C5004356
DATA g_state_request      TYPE syucomm.
DATA new_ok               TYPE sy-ucomm.
DATA g_state_srch         TYPE syucomm.                        "#EC NEEDED
DATA g_state_test         TYPE syucomm.
DATA g_before_patnr       TYPE patnr.
DATA g_popup              type ish_on_off.
* cursor
DATA g_cursor_field LIKE screen-name.
DATA g_cursor_intensified LIKE screen-intensified.

DATA s_dyfi TYPE dyfi_type.
DATA t_dyfi TYPE TABLE OF dyfi_type.

DATA gr_edit      TYPE REF TO cl_ishmed_lte_editor.
DATA gr_edit_cust TYPE REF TO cl_gui_custom_container.
DATA g_vcode        TYPE ish_vcode.
DATA g_reason1      TYPE n1tc_reason.
DATA g_reason_edit  TYPE xfeld value 'X'. "MED-67191
DATA g_cat_exsit    TYPE xfeld.
DATA g_check_tc     TYPE  ish_on_off.


**********************************************************************
* Classes
**********************************************************************
*----------------------------------------------------------------------*
*       CLASS lcl_header DEFINITION
*----------------------------------------------------------------------*
* Header with patient's data
*----------------------------------------------------------------------*
CLASS lcl_tc_ttc_helper DEFINITION FINAL
    CREATE PUBLIC.
***schau nach bei FG N2IPPD in NMED_IPPD
  PUBLIC SECTION.
    METHODS:
    constructor
      IMPORTING
        is_data  TYPE rn1tc_request_dlg,

    check_emergency_possible
       RETURNING value(r_emergency_possible) TYPE ish_on_off,

*Begin MED-70773 by C5004356
      check_patient_companion
       IMPORTING
         i_patient_id type patnr
         i_case_id   TYPE falnr
       RETURNING value(r_companion) TYPE ish_on_off,
*End MED-70773 by C5004356

    destroy.

  PRIVATE SECTION.

    METHODS:
      check_patient_present
       IMPORTING
         i_case_id   TYPE falnr
       RETURNING value(r_emergency_possible) TYPE ish_on_off,

      check_in_patient_present
       IMPORTING
         i_case_id   TYPE falnr
       RETURNING value(r_emergency_possible) TYPE ish_on_off,


      check_out_patient_present
       IMPORTING
         i_case_id   TYPE falnr
       RETURNING value(r_emergency_possible) TYPE ish_on_off.


    DATA gs_data  TYPE rn1tc_request_dlg.
*    DATA m_header   TYPE REF TO cl_gui_custom_container.

ENDCLASS.                    "lcl_header DEFINITION

DATA lr_ttc_helper TYPE REF TO lcl_tc_ttc_helper.

* INCLUDE LN1TC_DIALOGD...                   " Local class definition
