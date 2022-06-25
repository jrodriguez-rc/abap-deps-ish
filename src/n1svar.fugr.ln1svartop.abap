FUNCTION-POOL n1svar  MESSAGE-ID nf1.

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
* Globale Datendefinitionen
*----------------------------------------------------------------------*

TYPES: ty_message   LIKE bapiret2.
TYPES: tyt_messages TYPE STANDARD TABLE OF ty_message.

TYPES: ty_selvar    LIKE rsparams.
TYPES: tyt_selvars  TYPE STANDARD TABLE OF ty_selvar.

*
