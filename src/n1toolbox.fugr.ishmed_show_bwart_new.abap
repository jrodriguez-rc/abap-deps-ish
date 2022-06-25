FUNCTION ishmed_show_bwart_new.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_EINRI) TYPE  TN01-EINRI
*"     VALUE(I_BEWTY) TYPE  NBEW-BEWTY OPTIONAL
*"     VALUE(I_DATE) TYPE  SY-DATUM OPTIONAL
*"     VALUE(I_VCODE) TYPE  VCODE DEFAULT 'UPD'
*"  EXPORTING
*"     REFERENCE(E_RC) TYPE  ISH_METHOD_RC
*"     REFERENCE(E_BWART) TYPE  NTMN-BWART
*"----------------------------------------------------------------------

  TYPE-POOLS: shlp .
* Lokaler Typ
* Lokale Tabellen
  DATA: lt_return_values       TYPE STANDARD TABLE OF ddshretval.
* Workareas
  DATA: l_return_value         LIKE LINE OF lt_return_values.
* Hilfsfelder und -strukturen
  DATA: l_rc                   TYPE ish_method_rc,
        l_shlp_descr           TYPE shlp_descr_t,
        l_shlp_selopt          LIKE ddshselopt,
        l_shlp_interface       LIKE ddshiface,
        l_date_high(10)        TYPE c,
        l_date_low(10)         TYPE c,
        l_disponly             TYPE ish_on_off.
* ---------- ---------- ----------
* Initialisierung
  e_rc  =  0.
  IF i_vcode = 'UPD'.
    l_disponly = off.
  ELSE.
    l_disponly = on.
  ENDIF.
* ---------- ---------- ----------
* Vollständige Beschreibung einer Suchhilfe lesen
  CALL FUNCTION 'F4IF_GET_SHLP_DESCR'
       EXPORTING
            shlpname = 'F4_ISHMED_BWART'  "'N_HBWART'
       IMPORTING
            shlp     = l_shlp_descr
       EXCEPTIONS
            OTHERS   = 1.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ----------
* "VALFIELD" muss gesetzt werden -> siehe Dokumentation des FB
* F4IF_GET_SHLP_DESCR
  READ TABLE l_shlp_descr-interface INTO l_shlp_interface
    WITH KEY shlpfield = 'BWART'.
  l_shlp_interface-valfield  = on.
  MODIFY l_shlp_descr-interface FROM l_shlp_interface
     INDEX sy-tabix.
* ---------- ---------- ----------
* Selektionsoptionen setzen
  CLEAR: l_shlp_descr-selopt[].
* Einrichtung
  l_shlp_selopt-shlpname  = l_shlp_descr-intdescr-selmethod.
  l_shlp_selopt-shlpfield = 'EINRI'.
  l_shlp_selopt-sign      = 'I'.
  l_shlp_selopt-option    = 'EQ'.
  l_shlp_selopt-low       = i_einri.
  INSERT l_shlp_selopt INTO TABLE l_shlp_descr-selopt.
* Bewegungstyp
  l_shlp_selopt-shlpname  = l_shlp_descr-intdescr-selmethod.
  l_shlp_selopt-shlpfield = 'BEWTY'.
  l_shlp_selopt-sign      = 'I'.
  l_shlp_selopt-option    = 'EQ'.
  l_shlp_selopt-low       = i_bewty.
  INSERT l_shlp_selopt INTO TABLE l_shlp_descr-selopt.
* Sperrdatum
* Datum MUSS in der korrekten externen Darstellung verwendet werden,
* da im weiteren Verlauf (Pgm. SAPLSDH4,  Up conversion_ex2in_checked)
* eine Konvertierung in das interne Format durchgeführt wird.
* ... dafür zuerst Datum formatieren
  PERFORM format_termin(sapmn1pa) USING '00010101'
                                        '      '
                                        'SMH'
                                        10
                                        l_date_low.
  PERFORM format_termin(sapmn1pa) USING i_date
                                        '      '
                                        'SMH'
                                        10
                                        l_date_high.
  l_shlp_selopt-shlpname  = l_shlp_descr-intdescr-selmethod.
  l_shlp_selopt-shlpfield = 'SPERRDT'.
  l_shlp_selopt-sign      = 'E'.
  l_shlp_selopt-option    = 'BT'.
  l_shlp_selopt-low       = l_date_low.
  l_shlp_selopt-high      = l_date_high.
  INSERT l_shlp_selopt INTO TABLE l_shlp_descr-selopt.
* ---------- ---------- ----------
* F4-Hilfe aufrufen
  CALL FUNCTION 'F4IF_START_VALUE_REQUEST'
       EXPORTING
            shlp          = l_shlp_descr
            disponly      = l_disponly
       IMPORTING
            rc            = l_rc
       TABLES
            return_values = lt_return_values
       EXCEPTIONS
            OTHERS        = 1.
  IF l_rc = 0.
*   Ausgewählten Wert übernehmen
    LOOP AT lt_return_values INTO l_return_value
       WHERE fieldname = 'BWART'.
      e_bwart  =  l_return_value-fieldval.
      EXIT.
    ENDLOOP.
  ELSE.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

*** Tabellen
**  DATA: lt_shlp_descr       TYPE shlp_descr_t,
**        lt_dynpselect       TYPE STANDARD TABLE OF dselc,
**        lt_dynpvaluetab     TYPE STANDARD TABLE OF dval.
*** Workareas
*** Objekte
**  DATA: l_errorhandler      TYPE REF TO cl_ishmed_errorhandling.
*** Hilfsfelder und -strukturen
**  DATA: l_name(60),
**        l_help_info         TYPE help_info,
**        l_select_value      TYPE help_info-fldvalue,
**        l_rc                TYPE sy-subrc,
**        l_shlp_selopt       TYPE ddshselopt,
**        l_vcode             LIKE vcode.
**
**  CALL FUNCTION 'ISHMED_SET_CONDITIONS_BWART'
**       EXPORTING
**            i_einri   = i_einri
**            i_bewty   = i_bewty
**            i_sperrdt = i_date.
**
**  l_help_info-call       =  'T'.
**  l_help_info-object     =  'F'.
**  l_help_info-tabname    =  'RN1APPOINTMENT_LIST'.
**  l_help_info-fieldname  =  'BWART'.
*** Falls das Feld nur angezeigt wird darf auch in der F4-Hilfe
*** kein Wert ausgewählt werden.
***  IF l_vcode = co_vcode_display.
***    l_help_info-show       =  on.
***  ENDIF.
*** Aufruf der "amodalen" F4-Hilfe
**  CALL FUNCTION 'HELP_START'
**       EXPORTING
**            help_infos   = l_help_info
**       IMPORTING
**            select_value = l_select_value
**       TABLES
**            dynpselect   = lt_dynpselect
**            dynpvaluetab = lt_dynpvaluetab.





ENDFUNCTION.
