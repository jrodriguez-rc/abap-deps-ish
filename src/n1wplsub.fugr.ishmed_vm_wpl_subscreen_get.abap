FUNCTION ishmed_vm_wpl_subscreen_get.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"  EXPORTING
*"     VALUE(E_OKCODE)
*"     VALUE(E_DATA_CHANGED) TYPE  ISH_ON_OFF
*"     VALUE(E_NWPLACE_001) TYPE  NWPLACE_001
*"----------------------------------------------------------------------

* Je Arbeitsumfeld wird ein anderer Subscreen verwendet
  CASE i_place-wplacetype.
    WHEN '001'.
*     Workplace
      CALL FUNCTION 'ISHMED_VM_SUBSCREEN_001_GET'
           EXPORTING
                i_place        = i_place
           IMPORTING
                e_okcode       = e_okcode
                e_data_changed = e_data_changed
                e_nwplace_001  = e_nwplace_001.
    WHEN OTHERS.
*     Andere
      e_okcode       = ok-code.
      e_data_changed = off.
      clear e_nwplace_001.
  ENDCASE.

ENDFUNCTION.
