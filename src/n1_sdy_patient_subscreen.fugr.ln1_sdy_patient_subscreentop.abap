FUNCTION-POOL N1_SDY_PATIENT_SUBSCREEN.

INCLUDE mndata00.
INCLUDE mndata01.
INCLUDE mndata02.
INCLUDE mncediev.
INCLUDE mncdat20.

TYPE-POOLS: vrm.

CONSTANTS: vcode_anlegen  LIKE vcode VALUE 'INS',
           vcode_aendern  LIKE vcode VALUE 'UPD',
           vcode_anzeigen LIKE vcode VALUE 'DIS'.

TABLES: npat.

DATA: gr_subscr_patient TYPE REF TO cl_ish_scr_patient,
      g_einri type einri,
      g_dynpg type sy-repid,
      g_dynnr type sy-dynnr.
