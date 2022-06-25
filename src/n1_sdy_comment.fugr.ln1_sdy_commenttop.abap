FUNCTION-POOL n1_sdy_comment.

INCLUDE mndata00.
INCLUDE mndata01.
INCLUDE mndata02.
INCLUDE mncediev.
INCLUDE mncdat20.

TYPE-POOLS: vrm.

DATA: gr_subscr_comment TYPE REF TO cl_ish_scr_comment,
      g_einri TYPE einri,
      g_dynpg TYPE sy-repid,
      g_dynnr TYPE sy-dynnr,
      g_frame.
