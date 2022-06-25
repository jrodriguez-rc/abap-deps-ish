FUNCTION-POOL n1compcon.               "MESSAGE-ID ..


TYPE-POOLS: vrm.


TYPES: BEGIN OF gty_dynp_0100,
         obtyp            TYPE n1compcon-obtyp,
         compid           TYPE n1compcon-compid,
         compconid        TYPE n1compcon-compconid,
         new_compconid    TYPE n1compcon-compconid,
         new_name         TYPE n1compcont-name,
       END OF gty_dynp_0100.

DATA: g_ucomm  TYPE sy-ucomm.

DATA: gr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

DATA: gs_dynp_0100  TYPE gty_dynp_0100.

DATA: gt_obtyp      TYPE vrm_values,
      gt_compid     TYPE vrm_values,
      gt_compconid  TYPE vrm_values.
