FUNCTION ish_sdy_listbox_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_LISTBOX) TYPE REF TO  CL_ISH_SCR_LISTBOX
*"     REFERENCE(I_STRING) TYPE  STRING
*"  EXPORTING
*"     REFERENCE(ER_SCR_DATA) TYPE REF TO  DATA
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------

  FIELD-SYMBOLS: <ls_struct> TYPE ANY.

  gr_screen = ir_scr_listbox.

*   Begin, Siegl, 15.02.2005, ID 15283
*   GET REFERENCE OF rn1_dynp_listbox INTO er_scr_data.
    ASSIGN (i_string) TO <ls_struct>.
    CHECK sy-subrc = 0.
    GET REFERENCE OF <ls_struct> INTO er_scr_data.
*   End, Siegl, 15.02.2005, 15283

ENDFUNCTION.
