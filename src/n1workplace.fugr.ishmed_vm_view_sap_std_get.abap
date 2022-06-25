FUNCTION ISHMED_VM_VIEW_SAP_STD_GET.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VIEWTYPE) TYPE  NWVIEW-VIEWTYPE
*"  EXPORTING
*"     VALUE(E_VIEWID) TYPE  NWVIEW-VIEWID
*"----------------------------------------------------------------------

  PERFORM get_sap_std_view_id USING    i_viewtype
                              CHANGING e_viewid.

ENDFUNCTION.
