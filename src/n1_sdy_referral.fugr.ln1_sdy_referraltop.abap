FUNCTION-POOL N1_SDY_REFERRAL.

INCLUDE mndata00.
INCLUDE mndata01.
INCLUDE mndata02.
INCLUDE mncediev.
INCLUDE mncdat20.

TYPE-POOLS: vrm.

CONSTANTS: vcode_anlegen  LIKE vcode VALUE 'INS',
           vcode_aendern  LIKE vcode VALUE 'UPD',
           vcode_anzeigen LIKE vcode VALUE 'DIS'.

TABLES: rn1_dynp_referral.

DATA: gr_subscr_referral TYPE REF TO cl_ish_scr_referral,
      g_einri type einri.
