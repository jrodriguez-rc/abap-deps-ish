FUNCTION ISHMED_WOTAGNAME.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(I_VON_DATUM) TYPE  D DEFAULT '19690203'
*"             VALUE(I_BIS_DATUM) TYPE  D DEFAULT '19690209'
*"       TABLES
*"              T_WOTAG STRUCTURE  RN1POB_LST
*"----------------------------------------------------------------------

DATA: DATUM     LIKE SCAL-DATE,
      BIS_DATUM TYPE D,
      WKDY      LIKE SCAL-INDICATOR,
      WKDYNAME  LIKE RNPB2-DAY_TXT.

DATA: IWOTAG    LIKE RN1POB_LST OCCURS 1 WITH HEADER LINE.

  CLEAR IWOTAG. REFRESH IWOTAG.

  DATUM     = I_VON_DATUM.
  BIS_DATUM = I_BIS_DATUM + 1.

  WHILE DATUM <> BIS_DATUM.
    CALL FUNCTION 'ISH_GET_DAY_OF_WEEK'
         EXPORTING
              DATE    = DATUM
         IMPORTING
              DAY     = WKDY
              DAY_TXT = WKDYNAME
         EXCEPTIONS
              OTHERS  = 1.

    IWOTAG-DATUM = DATUM.
    IWOTAG-WOTAG = WKDY.
    IWOTAG-WOTAGNAME = WKDYNAME.
    APPEND IWOTAG.

    DATUM = DATUM + 1.
  ENDWHILE.

  T_WOTAG[] = IWOTAG[].

ENDFUNCTION.
