FUNCTION-POOL n1_sdy_med_data.

INCLUDE mndata00.
INCLUDE mndata01.
INCLUDE mndata02.
INCLUDE mncediev.
INCLUDE mncdat20.

TYPE-POOLS: vrm.

TABLES: rn1_dynp_med_data.

DATA: gr_subscr_med_data TYPE REF TO cl_ish_scr_med_data,
      risk_facts(40)     TYPE c.
