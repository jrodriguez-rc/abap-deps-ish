FUNCTION-POOL n_sdy_collapsible.            "MESSAGE-ID ..

*----------------------------------------------------------------------
* includes
*----------------------------------------------------------------------
INCLUDE mndata00.

*----------------------------------------------------------------------
* table definitions
*----------------------------------------------------------------------

*----------------------------------------------------------------------
* global instances for screen classes
*----------------------------------------------------------------------
DATA: gr_collapsible          TYPE REF TO cl_ish_scr_collapsible.

*----------------------------------------------------------------------
* global data
*----------------------------------------------------------------------
* name of program, number of dynpro
DATA: g_collapsible_pgm            TYPE sy-repid,
      g_collapsible_dynnr          TYPE sy-dynnr,
      g_pb_coll_pgm                TYPE sy-repid,
      g_pb_coll_dynnr              TYPE sy-dynnr.
