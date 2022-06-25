FUNCTION ishmed_vm_wpl_subscreen_save.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"----------------------------------------------------------------------

* Je Arbeitsumfeld wird ein anderer Subscreen verwendet
  CASE i_place-wplacetype.
    WHEN '001'.
*     Workplace
      IF rn1_scr_wplsub100-wplaceid IS INITIAL.
        rn1_scr_wplsub100-wplaceid = i_place-wplaceid.
      ENDIF.
      CALL FUNCTION 'ISHMED_VM_SUBSCREEN_001_SAVE'
        EXCEPTIONS
          OTHERS = 0.
    WHEN OTHERS.
*     Andere
  ENDCASE.

ENDFUNCTION.
