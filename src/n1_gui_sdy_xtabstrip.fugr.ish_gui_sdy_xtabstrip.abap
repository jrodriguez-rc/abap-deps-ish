FUNCTION ish_gui_sdy_xtabstrip.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_DYNNR) TYPE  SYDYNNR
*"  EXPORTING
*"     REFERENCE(ER_TABSTRIP) TYPE REF TO  DATA
*"     REFERENCE(ET_TABREF) TYPE  ISH_T_DATAREF
*"----------------------------------------------------------------------


  DATA l_fix_tab_name           TYPE string.
  DATA l_tab_name               TYPE string.
  DATA l_idx                    TYPE i.
  DATA l_idx_string             TYPE string.
  DATA lr_tab                   TYPE REF TO data.

  FIELD-SYMBOLS <l_tabstrip>    TYPE data.
  FIELD-SYMBOLS <l_tab>         TYPE data.

  CHECK i_dynnr IS NOT INITIAL.

  CONCATENATE
    'TS'
    i_dynnr
    INTO l_fix_tab_name
    SEPARATED BY '_'.
  ASSIGN (l_fix_tab_name) TO <l_tabstrip>.
  CHECK sy-subrc = 0.
  GET REFERENCE OF <l_tabstrip> INTO er_tabstrip.

  CONCATENATE
    l_fix_tab_name
    'TAB'
    INTO l_fix_tab_name
    SEPARATED BY '_'.

  l_idx = 0.
  DO co_maxtabs TIMES.
    l_idx = l_idx + 1.
    l_idx_string = l_idx.
    CONCATENATE
      l_fix_tab_name
      l_idx_string
      INTO l_tab_name.
    ASSIGN (l_tab_name) TO <l_tab>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    GET REFERENCE OF <l_tab> INTO lr_tab.
    INSERT lr_tab INTO TABLE et_tabref.
  ENDDO.


ENDFUNCTION.
