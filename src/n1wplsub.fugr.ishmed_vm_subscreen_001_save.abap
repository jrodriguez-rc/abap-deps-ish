FUNCTION ishmed_vm_subscreen_001_save.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"----------------------------------------------------------------------
  DATA: lt_n_nwplace_001   LIKE TABLE OF vnwplace_001,
        lt_o_nwplace_001   LIKE TABLE OF vnwplace_001,
        l_wa_nwplace_001   LIKE vnwplace_001,
        l_kz               LIKE vnwplace_001-kz.

  REFRESH: lt_n_nwplace_001, lt_o_nwplace_001.

  CHECK vcode <> g_vcode_display.

* Verarbeitungs-KZ
  IF vcode = g_vcode_insert.               " Insert
    l_kz = 'I'.
  ELSE.                                    " Update
    l_kz = 'U'.
  ENDIF.

* Neue Daten
  CLEAR l_wa_nwplace_001.
  MOVE-CORRESPONDING rn1_scr_wplsub100 TO l_wa_nwplace_001.  "#EC ENHOK
  l_wa_nwplace_001-kz = l_kz.
  APPEND l_wa_nwplace_001  TO lt_n_nwplace_001.
* Alte Daten
  IF vcode = g_vcode_update.
    CLEAR l_wa_nwplace_001.
    MOVE-CORRESPONDING g_place_001_save TO l_wa_nwplace_001.
    APPEND l_wa_nwplace_001 TO lt_o_nwplace_001.
  ENDIF.

* Verbuchen
  CALL FUNCTION 'ISH_VERBUCHER_NWPLACE_001'
       EXPORTING
*           I_DATE          = SY-DATUM
            i_tcode         = sy-tcode
*           I_UNAME         = SY-UNAME
*           I_UTIME         = SY-UZEIT
       TABLES
            t_n_nwplace_001 = lt_n_nwplace_001
            t_o_nwplace_001 = lt_o_nwplace_001.

ENDFUNCTION.
