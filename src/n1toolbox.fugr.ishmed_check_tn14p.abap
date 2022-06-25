FUNCTION ISHMED_CHECK_TN14P.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(SS_EINRI) LIKE  NORG-EINRI
*"     VALUE(SS_WLPRI) LIKE  TN14P-WLPRI
*"  EXCEPTIONS
*"      NOT_FOUND
*"----------------------------------------------------------------------
**"----------------------------------------------------------------------
**"*"Lokale Schnittstelle:
**"       IMPORTING
**"             VALUE(SS_EINRI) LIKE  NORG-EINRI
**"             VALUE(SS_WLPRI) LIKE  TN14P-WLPRI
**"       EXCEPTIONS
**"              NOT_FOUND
**"----------------------------------------------------------------------
*  INCLUDE MNDATA00.                    " Standarddefinitionen
*
*  DATA: BEGIN OF OUTTAB OCCURS 50.
*          INCLUDE STRUCTURE TN14P.
*  DATA: PRTXT LIKE TN14Q-PRTXT.
*  DATA: END OF OUTTAB.
*
*  DATA:  EINRI LIKE TN14P-EINRI,
*         FLAG(1),
*         INTENS(1),
*         A_KEY LIKE RN1F4-KEY.
*
*  RANGES: R_EINRI FOR TN14P-EINRI.
*
*  EINRI      = SS_EINRI.
*
** Einrichtung prüfen (wenn erforderlich)
*  IF NOT EINRI IS INITIAL.
*    PERFORM REN01(SAPMNPA0) USING EINRI TN01 FLAG.
*    IF FLAG = FALSE.
*      RAISE NOT_FOUND.
*    ENDIF.
*  ENDIF.
*
** Einrichtung in den Range übernehmen
*  CLEAR R_EINRI.   REFRESH R_EINRI.
*  R_EINRI-SIGN   = 'I'.
*  R_EINRI-OPTION = 'EQ'.
*  R_EINRI-LOW    = '*'.   " alle allgemeinen Eintraege selektieren
*  APPEND R_EINRI.
*  R_EINRI-LOW    = EINRI.
*  APPEND R_EINRI.
*
** Jetzt die Tabelle OUTTAB füllen (die später ausgegeben wird)
*  SELECT * FROM TN14P
*              INTO TABLE OUTTAB
*              WHERE EINRI IN R_EINRI
*              AND   WLPRI EQ SS_WLPRI.
*
*  IF SY-SUBRC <> 0.
*    RAISE NOT_FOUND.
*  ENDIF.
*
ENDFUNCTION.
