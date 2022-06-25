FUNCTION ISHMED_CHECK_N1ZPI.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(SS_EINRI) LIKE  NORG-EINRI
*"     VALUE(SS_ZPIE) LIKE  N1ZPI-ZPIE
*"     VALUE(SS_ZPITY) LIKE  N1ZPI-ZPITY
*"  EXCEPTIONS
*"      NOT_FOUND
*"----------------------------------------------------------------------
**"----------------------------------------------------------------------
**"*"Lokale Schnittstelle:
**"       IMPORTING
**"             VALUE(SS_EINRI) LIKE  NORG-EINRI
**"             VALUE(SS_ZPIE) LIKE  N1ZPI-ZPIE
**"             VALUE(SS_ZPITY) LIKE  N1ZPI-ZPITY
**"       EXCEPTIONS
**"              NOT_FOUND
**"----------------------------------------------------------------------
*  INCLUDE MNDATA00.                    " Standarddefinitionen
*
*  DATA: BEGIN OF OUTTAB OCCURS 50.
*          INCLUDE STRUCTURE N1ZPI.
*  DATA: END OF OUTTAB.
*
*  DATA:  EINRI LIKE N1ZPI-EINRI,
*         FLAG(1),
*         INTENS(1),
*         A_KEY LIKE RN1F4-KEY.
*
*  RANGES: R_EINRI FOR N1ZPI-EINRI.
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
*  SELECT * FROM N1ZPI
*              INTO TABLE OUTTAB
*              WHERE EINRI IN R_EINRI
*              AND   ZPIE  EQ SS_ZPIE
*              AND   ZPITY EQ SS_ZPITY.
*
*  IF SY-SUBRC <> 0.
*    RAISE NOT_FOUND.
*  ENDIF.
*
ENDFUNCTION.
