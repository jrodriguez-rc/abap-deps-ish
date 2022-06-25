FUNCTION ishmed_vm_subscreen_001_set.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"     VALUE(I_VCODE) TYPE  ISH_VCODE DEFAULT 'DIS'
*"     VALUE(I_SETVARS) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_OKCODE)
*"----------------------------------------------------------------------

  ok-code = i_okcode.

* Alle anderen Initialisierungen nur durchführen, wenn dies so
* gewüscht wird
  CHECK i_setvars = on.

  vcode = i_vcode.
  IF vcode <> g_vcode_insert.
    SELECT SINGLE * FROM nwplace_001 INTO rn1_scr_wplsub100
           WHERE  wplacetype  = i_place-wplacetype
           AND    wplaceid    = i_place-wplaceid.
    IF sy-subrc <> 0.
      CLEAR rn1_scr_wplsub100.
      IF vcode = g_vcode_update.
        vcode = g_vcode_insert.
      ENDIF.
    ENDIF.
  ELSE.
    CLEAR rn1_scr_wplsub100.
  ENDIF.

  g_place_001_save = rn1_scr_wplsub100.

  IF rn1_scr_wplsub100 IS INITIAL AND vcode <> g_vcode_display.
    rn1_scr_wplsub100-mandt      = sy-mandt.
    rn1_scr_wplsub100-wplacetype = i_place-wplacetype.
    rn1_scr_wplsub100-wplaceid   = i_place-wplaceid.
*   ID 7232: Beim Anlegen Einrichtung vorbelegen
    GET PARAMETER ID 'EIN' FIELD rn1_scr_wplsub100-einri.
  ENDIF.

ENDFUNCTION.
