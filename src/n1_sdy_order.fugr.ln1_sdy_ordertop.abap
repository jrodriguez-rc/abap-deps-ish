FUNCTION-POOL n1_sdy_order.

INCLUDE mndata00.
INCLUDE mndata01.
INCLUDE mndata02.
INCLUDE mncediev.
INCLUDE mncdat20.

TYPE-POOLS: vrm.

CONSTANTS: vcode_anlegen  LIKE vcode VALUE 'INS',
           vcode_aendern  LIKE vcode VALUE 'UPD',
           vcode_anzeigen LIKE vcode VALUE 'DIS'.

TABLES: rn1_dynp_order.

DATA: gr_subscr_order TYPE REF TO cl_ish_scr_order,
      g_einri TYPE einri.
