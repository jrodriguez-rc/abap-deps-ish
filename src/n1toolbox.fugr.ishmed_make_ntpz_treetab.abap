FUNCTION ISHMED_MAKE_NTPZ_TREETAB.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(I_EINRI) LIKE  TNK01-EINRI
*"             VALUE(I_ZOTYP) LIKE  NTPZ-ZOTYP
*"             VALUE(I_DATUM) LIKE  SY-DATUM DEFAULT SY-DATUM
*"       TABLES
*"              TI_NTPZ STRUCTURE  NTPZ
*"              TE_NTPKTREE STRUCTURE  RN1NTPKTREE
*"----------------------------------------------------------------------
  DATA: XNTPZ LIKE NTPZ OCCURS 20 WITH HEADER LINE.
  DATA: BEGIN OF IROOTS OCCURS 10,
          TARIF LIKE NTPK-TARIF,
          TALST LIKE NTPK-TALST,
        END OF IROOTS.
  DATA: IDX LIKE SY-TABIX,
        TAR LIKE NTPK-TARIF,
        LST LIKE NTPK-TALST.

* NTPZ auf Einrichtung, Zuordnungstyp und Datum einschränlen
  CLEAR XNTPZ[].
  LOOP AT TI_NTPZ WHERE EINRI  = I_EINRI
                    AND ZOTYP  = I_ZOTYP
                    AND LOEKZ  = OFF
                    AND BEGDT >= I_DATUM
                    AND ENDDT <= I_DATUM.
    XNTPZ = TI_NTPZ.
    APPEND XNTPZ.
  ENDLOOP.
* Wurzeln aus der NTPZ suchen: Wurzeln sind jene Leistungen, die keine
* übergeordnete Leistungen haben.
  IDX = 0.
  DO.
    IDX = IDX + 1.
    READ TABLE XNTPZ INDEX IDX.
    IF SY-SUBRC <> 0. EXIT. ENDIF.
*   Suche Leistung als untergeordnete Leistung
    READ TABLE XNTPZ WITH KEY ZUTAR  = XNTPZ-TARIF
                              ZULST  = XNTPZ-TALST.
    IF SY-SUBRC <> 0.                  " Leistung ist Root eines Baums
      CLEAR IROOTS.
      MOVE-CORRESPONDING XNTPZ TO IROOTS.
      APPEND IROOTS.
    ENDIF.
  ENDDO.
  SORT IROOTS.
  DELETE ADJACENT DUPLICATES FROM IROOTS.
*
* Von den Wurzeln ausgehend die Treetabelle erstellen
  CLEAR TE_NTPKTREE[].
  LOOP AT IROOTS.
    PERFORM TREETAB_WRITE TABLES XNTPZ TE_NTPKTREE
                          USING  IROOTS-TARIF IROOTS-TALST
                                 IROOTS-TARIF IROOTS-TALST 1.
  ENDLOOP.
* Treetab nach Baum, ebene und Reihenfolge sortieren.
  SORT TE_NTPKTREE BY ROTAR ROLST EBENE FOLGE NOTAR NOLST.

ENDFUNCTION.
