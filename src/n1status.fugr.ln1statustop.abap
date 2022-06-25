FUNCTION-POOL n1status.                     "MESSAGE-ID ..

INCLUDE: mndata00,
         mndata_flavors.


DATA: g_container            TYPE REF TO cl_gui_custom_container.
DATA: g_grid_status          TYPE REF TO cl_ish_check_list_status.

DATA: gt_stsma               TYPE ish_t_stsma,
      gt_status_marked       TYPE ish_t_status,
      gt_status_obj_marked   TYPE ish_t_status_obj,
      gt_stsma_marked        TYPE ish_t_stsma,
      gt_estat_marked        TYPE ish_t_estat.

DATA: g_title(60)            TYPE c,
      g_vcode                TYPE vcode,
      g_obtyp                TYPE tj21-obtyp.

*
