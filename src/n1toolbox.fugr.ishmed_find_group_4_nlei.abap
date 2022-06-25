FUNCTION ISHMED_FIND_GROUP_4_NLEI.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(I_EINRI) LIKE  TNK01-EINRI
*"             VALUE(I_ZOTYP) LIKE  NTPZ-ZOTYP
*"             VALUE(I_DATUM) LIKE  SY-DATUM DEFAULT SY-DATUM
*"             VALUE(I_FORCE_GRP) DEFAULT ' '
*"             VALUE(I_NTPT_DEF) LIKE  NTPT STRUCTURE  NTPT OPTIONAL
*"       TABLES
*"              TI_NLEI STRUCTURE  NLEI
*"              TE_NTPZ STRUCTURE  NTPZ
*"              TE_NTPT STRUCTURE  NTPT
*"       EXCEPTIONS
*"              NO_GROUP
*"----------------------------------------------------------------------

  DATA: XNTPK LIKE NTPK OCCURS 10 WITH HEADER LINE.

* NTPK-Positionen aus Leistungen erstellen
  CLEAR XNTPK[].
  LOOP AT TI_NLEI.
    XNTPK-TARIF = TI_NLEI-HAUST.
    XNTPK-TALST = TI_NLEI-LEIST.
    APPEND XNTPK.
  ENDLOOP.
* Gruppierung ermitteln
  CALL FUNCTION 'ISHMED_FIND_GROUP_4_NTPK'
       EXPORTING
            I_EINRI     = I_EINRI
            I_ZOTYP     = I_ZOTYP
            I_DATUM     = I_DATUM
            I_FORCE_GRP = I_FORCE_GRP
            I_NTPT_DEF  = I_NTPT_DEF
       TABLES
            TI_NTPK     = XNTPK
            TE_NTPT     = TE_NTPT
            TE_NTPZ     = TE_NTPZ
       EXCEPTIONS
            NO_GROUP    = 1
            OTHERS      = 2.
  CASE SY-SUBRC.
    WHEN 0.
    WHEN 1.        RAISE NO_GROUP.
    WHEN OTHERS.   RAISE OTHERS.
  ENDCASE.
ENDFUNCTION.
