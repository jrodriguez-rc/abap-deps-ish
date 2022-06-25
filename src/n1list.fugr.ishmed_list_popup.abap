FUNCTION ishmed_list_popup.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_TITLE)
*"     VALUE(I_HEADER1) DEFAULT ' '
*"     VALUE(I_HEADER2) DEFAULT ' '
*"     VALUE(I_ENTER_KEY) LIKE  RNT40-MARK DEFAULT 'X'
*"     VALUE(I_PRINT_KEY) LIKE  RNT40-MARK DEFAULT 'X'
*"     VALUE(I_MODAL) TYPE  ISH_ON_OFF DEFAULT SPACE
*"  EXPORTING
*"     VALUE(F_CODE) LIKE  SY-UCOMM
*"  TABLES
*"      T_OUTTAB STRUCTURE  RN1LIST132
*"      T_BUTTON STRUCTURE  RN1PUSH OPTIONAL
*"----------------------------------------------------------------------
  DATA: h_breite   TYPE i.
  DATA: xk_start   TYPE i,           " Fichte, Nr 3544
        yk_start   TYPE i,           " Fichte, Nr 3544
        xk_end     TYPE i,           " Fichte, Nr 3544
        yk_end     TYPE i.           " Fichte, Nr 3544

  CLEAR f_code.

  lp_enter_key = i_enter_key.
  lp_print_key = i_print_key.
  lp_title     = i_title.
  lp_header1   = i_header1.
  lp_header2   = i_header2.
  lp_outtab[]  = t_outtab[].

* Funktionstabelle übernehmen (Nur die ersten 10 befüllten Sätze!)
  CLEAR lp_button.   REFRESH lp_button.
  lp_button[] = t_button[].
  DELETE lp_button WHERE ( fcode IS initial  AND
                           text  IS initial ).

* Zeilenanzahl für Bestimmung der Popup-Größe ermitteln
  DESCRIBE TABLE lp_outtab.
  IF sy-tfill = 0.
    EXIT.
  ELSEIF sy-tfill < 20.
    lp_zeilen = sy-tfill.
  ELSE.
    lp_zeilen = 20.
  ENDIF.
  IF NOT lp_header1 IS INITIAL.
    lp_zeilen = lp_zeilen + 2.
  ENDIF.
  IF NOT lp_header2 IS INITIAL.
    lp_zeilen = lp_zeilen + 2.
  ENDIF.

* Textlänge für Bestimmung der Popup-Größe ermitteln
  lp_breite = strlen( lp_header1 ).
  h_breite = strlen( lp_header2 ).
  IF h_breite > lp_breite.
    lp_breite = h_breite.
  ENDIF.
  LOOP AT lp_outtab.
    h_breite = strlen( lp_outtab-text ).
    IF h_breite > lp_breite.
      lp_breite = h_breite.
    ENDIF.
  ENDLOOP.
  lp_breite = lp_breite + 1.

* Fichte, Nr 3544: Popup zentriert in der Bildmitte ausgeben
  xk_start = ( 83 - lp_breite ) / 2.
  yk_start = ( 23 - lp_zeilen ) / 2.
  IF xk_start < 1.
    xk_start = 1.
  ENDIF.
  IF yk_start < 1.
    yk_start = 1.
  ENDIF.
  xk_end = xk_start + lp_breite.
  yk_end = yk_start + lp_zeilen.

  IF i_modal = off.
    CALL SCREEN 100 STARTING AT xk_start yk_start
                    ENDING   AT xk_end   yk_end.
  ELSE.
    CALL SCREEN 101 STARTING AT xk_start yk_start
                    ENDING   AT xk_end   yk_end.
  ENDIF.

  f_code = key_back.

ENDFUNCTION.
