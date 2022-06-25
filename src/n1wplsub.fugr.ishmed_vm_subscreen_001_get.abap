FUNCTION ishmed_vm_subscreen_001_get.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"  EXPORTING
*"     VALUE(E_OKCODE)
*"     VALUE(E_DATA_CHANGED) TYPE  ISH_ON_OFF
*"     VALUE(E_NWPLACE_001) TYPE  NWPLACE_001
*"----------------------------------------------------------------------

  e_okcode = ok-code.

* Nun prüfen, ob sich Daten geändert haben
  e_data_changed = off.
  IF vcode = g_vcode_insert OR
     vcode = g_vcode_update AND
     rn1_scr_wplsub100 <> g_place_001_save.
    e_data_changed = on.
  ENDIF.

  e_nwplace_001 = rn1_scr_wplsub100.

ENDFUNCTION.
