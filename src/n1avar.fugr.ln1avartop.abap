FUNCTION-POOL n1avar   MESSAGE-ID nf1.

*----------------------------------------------------------------------*
* Definition von TRUE, FALSE ...
*----------------------------------------------------------------------*
INCLUDE mndata00.

*----------------------------------------------------------------------
* Konstantendefinitionen
*----------------------------------------------------------------------
CONSTANTS: g_vcode_insert   TYPE ish_vcode  VALUE 'INS',
           g_vcode_update   TYPE ish_vcode  VALUE 'UPD'.
*           g_vcode_display  type ish_vcode  value 'DIS'.

*----------------------------------------------------------------------*
* Typdefinitionen
*----------------------------------------------------------------------*

*TYPE-POOLS kkblo .

TYPES: ty_message   TYPE bapiret2.
TYPES: tyt_messages TYPE STANDARD TABLE OF ty_message.


*----------------------------------------------------------------------*
* Globale Datendefinitionen
*----------------------------------------------------------------------*

DATA:  g_avar_key       LIKE ltdx-variant,
       g_avar_text      LIKE ltdxt-text,
       g_save_ok_code   LIKE ok-code.

DATA:  g_variant        TYPE REF TO cl_alv_variant.

*
