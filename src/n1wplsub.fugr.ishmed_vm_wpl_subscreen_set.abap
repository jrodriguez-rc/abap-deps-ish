FUNCTION ishmed_vm_wpl_subscreen_set.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"     VALUE(I_VCODE) TYPE  ISH_VCODE DEFAULT 'DIS'
*"     VALUE(I_SETVARS) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_OKCODE)
*"  EXPORTING
*"     VALUE(E_SUB_PGM) LIKE  SY-CPROG
*"     VALUE(E_SUB_DYNNR) LIKE  SY-DYNNR
*"----------------------------------------------------------------------

* Je Arbeitsumfeld wird ein anderer Subscreen aufgerufen
  CASE i_place-wplacetype.
    WHEN '001'.
*     Workplace
      CALL FUNCTION 'ISHMED_VM_SUBSCREEN_001_SET'
           EXPORTING
                i_place   = i_place
                i_vcode   = i_vcode
                i_setvars = i_setvars
                i_okcode  = i_okcode.
*     Subscreen für Daten aus Tabelle NWPLACE_001
      e_sub_pgm   = 'SAPLN1WPLSUB'.
      e_sub_dynnr = '0100'.
    WHEN OTHERS.
      ok-code     = i_okcode.
*     Andere --> Leerer Subscreen
      e_sub_pgm   = 'SAPLN1SC'.
      e_sub_dynnr = '0001'.
  ENDCASE.

ENDFUNCTION.
