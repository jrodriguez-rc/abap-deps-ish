FUNCTION-POOL n1_sdy_procedures.

INCLUDE mndata00.
INCLUDE mndata01.
INCLUDE mndata02.
INCLUDE mncediev.
INCLUDE mncdat20.

TYPE-POOLS: vrm.

CONSTANTS: vcode_anlegen  LIKE vcode VALUE 'INS',
           vcode_aendern  LIKE vcode VALUE 'UPD',
           vcode_anzeigen LIKE vcode VALUE 'DIS'.

DATA: gr_subscr_procedures TYPE REF TO cl_ish_scr_procedures,
      g_einri TYPE einri,
      g_dynpg TYPE sy-repid,
      g_dynnr TYPE sy-dynnr,
      g_frame.
