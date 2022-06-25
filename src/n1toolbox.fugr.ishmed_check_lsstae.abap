FUNCTION ISHMED_CHECK_LSSTAE.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(SS_EINRI) LIKE  NORG-EINRI
*"     VALUE(SS_LNRLS) LIKE  NLEI-LNRLS
*"     VALUE(SS_LSSTAE) LIKE  N1LSSTA-LSSTAE
*"  EXCEPTIONS
*"      NOT_FOUND
*"----------------------------------------------------------------------
**"----------------------------------------------------------------------
**"*"Lokale Schnittstelle:
**"       IMPORTING
**"             VALUE(SS_EINRI) LIKE  NORG-EINRI
**"             VALUE(SS_LNRLS) LIKE  NLEI-LNRLS
**"             VALUE(SS_LSSTAE) LIKE  N1LSSTA-LSSTAE
**"       EXCEPTIONS
**"              NOT_FOUND
**"----------------------------------------------------------------------
*TABLES: N1LSSTZ.
*
*  SELECT SINGLE * FROM N1LSSTZ
*     WHERE EINRI  = SS_EINRI
*       AND LNRLS  = SS_LNRLS
*       AND LSSTAE = SS_LSSTAE.
*
*  IF SY-SUBRC <> 0.
*    RAISE NOT_FOUND.
*  ENDIF.
*
ENDFUNCTION.
