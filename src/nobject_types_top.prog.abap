*&---------------------------------------------------------------------*
*&  Include           NOBJECT_TYPES_TOP
*&---------------------------------------------------------------------*

REPORT  rnobject_types MESSAGE-ID n1base
                       NO STANDARD PAGE HEADING LINE-SIZE 114.

*-------------------------------------------------------------------
* TRUE, FALSE and internal types
*-------------------------------------------------------------------
INCLUDE mndata00.


tables: tadir.


TYPES: BEGIN OF gty_tadir,
          obj_name TYPE sobj_name,
          devclass TYPE devclass,
        END OF gty_tadir.
TYPES: gtyt_tadir TYPE STANDARD TABLE OF gty_tadir.

TYPES: BEGIN OF gty_outtab,
         pgmobj_name    TYPE ish_object_name,
         cmpname        TYPE ish_objconst_name,
         value          TYPE ish_object_type,    " ish_objconst_value,
         cust_specific  TYPE ish_on_off,
         no_constant    TYPE ish_on_off,
         devclass       TYPE devclass,
       END OF gty_outtab.
TYPES: gtyt_outtab TYPE STANDARD TABLE OF gty_outtab.


FIELD-SYMBOLS: <g_line>  TYPE c,
               <g_vline> TYPE c.

DATA: g_line_size TYPE i,
      gt_outtab   TYPE gtyt_outtab.


* ICON-Definitions
INCLUDE <icon>.
INCLUDE <symbol>.
