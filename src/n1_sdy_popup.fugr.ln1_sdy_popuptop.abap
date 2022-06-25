FUNCTION-POOL n1_sdy_popup.


INCLUDE mndata00.

TYPE-POOLS: vrm.


* The one and only process object.
DATA: gr_process  TYPE REF TO if_ish_prc_popup.

* Parent of the subscreen.
DATA: gs_parent_subscreen  TYPE rnscr_parent.

* Dynamic functions
DATA: gs_func_01           TYPE smp_dyntxt,
      gs_func_02           TYPE smp_dyntxt,
      gs_func_03           TYPE smp_dyntxt.
