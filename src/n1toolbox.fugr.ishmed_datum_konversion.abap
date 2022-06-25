FUNCTION ISHMED_DATUM_KONVERSION.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(DATUM_IN) LIKE  SY-DATUM
*"     VALUE(DELIMITER) TYPE  C DEFAULT '.'
*"  EXPORTING
*"     VALUE(DATUM_OUT) LIKE  SN1DESK-TEXT12
*"----------------------------------------------------------------------
**"----------------------------------------------------------------------
**"*"Lokale Schnittstelle:
**"       IMPORTING
**"             VALUE(DATUM_IN) LIKE  SY-DATUM
**"             VALUE(DELIMITER) TYPE  C DEFAULT '.'
**"       EXPORTING
**"             VALUE(DATUM_OUT) LIKE  SN1DESK-TEXT12
**"----------------------------------------------------------------------
*
** YYYYMMTT -> TT.MM.YYYY
*  CONCATENATE DATUM_IN+6(2) DELIMITER
*              DATUM_IN+4(2) DELIMITER
*              DATUM_IN(4) INTO DATUM_OUT.
*
** Leerzeichen vor Jahr einfügen: -> TT.MM. YYYY
*  CONCATENATE DATUM_OUT(6) DATUM_OUT+6(4) INTO DATUM_OUT
*                                          SEPARATED BY ' '.
*
** führende 0 von Monat löschen bzw. Leerzeichen einfügen
*  IF DATUM_OUT+3(1) = '0'.
*    DATUM_OUT+3(1) = ' '.
*  ELSE.
*    CONCATENATE DATUM_OUT(3) DATUM_OUT+3(8) INTO DATUM_OUT
*                             SEPARATED BY ' '.
*  ENDIF.
*
** führende 0 von Tag löschen
*  IF DATUM_OUT+0(1) = '0'.
*    DATUM_OUT = DATUM_OUT+1(11).
*  ENDIF.
*
ENDFUNCTION.
