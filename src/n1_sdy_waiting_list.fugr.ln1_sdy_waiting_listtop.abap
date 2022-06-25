FUNCTION-POOL N1_SDY_WAITING_LIST.

INCLUDE mndata00.
INCLUDE mndata01.
INCLUDE mndata02.
INCLUDE mncediev.
INCLUDE mncdat20.

TYPE-POOLS: vrm.

CONSTANTS: vcode_anlegen  LIKE vcode VALUE 'INS',
           vcode_aendern  LIKE vcode VALUE 'UPD',
           vcode_anzeigen LIKE vcode VALUE 'DIS'.

TABLES: rn1_dynp_waiting_list.

DATA: gr_subscr_waiting_list TYPE REF TO cl_ish_scr_waiting_list,
      g_einri type einri,
      g_dynpg type sy-repid,
      g_dynnr type sy-dynnr,
      g_frame.
