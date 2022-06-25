*----------------------------------------------------------------------*
***INCLUDE LN1TOOLBOXF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  TREETAB_WRITE
*&---------------------------------------------------------------------*
*       Routine baut aus einer NTPZ-Tabelle eine lineare Treetabelle auf
*----------------------------------------------------------------------*
*      -->P_NTPZ  Tabelle mit Leistungsstruktur
*      -->P_ROTAR Tarif der Wurzel
*      -->P_ROLST LeistungsID der Wurzel
*      -->P_NOTAR Tarif eines Knotens
*      -->P_NOLST LeistungsID eines Knotens
*      -->P_EBENE Level-Zähler für Rekursion
*----------------------------------------------------------------------*
FORM TREETAB_WRITE TABLES   P_NTPZ STRUCTURE NTPZ
                            P_TREE STRUCTURE RN1NTPKTREE
                   USING    VALUE(P_ROTAR)
                            VALUE(P_ROLST)
                            VALUE(P_NOTAR)
                            VALUE(P_NOLST)
                            VALUE(P_EBENE).
*
  DATA: LV TYPE I,
        IX LIKE SY-TABIX.
* Lies von der Root ausgehend alle Kanten
  LV = P_EBENE + 1.
  LOOP AT P_NTPZ WHERE TARIF = P_NOTAR
                   AND TALST = P_NOLST.
    IX = SY-TABIX.
    P_TREE-ROTAR = P_ROTAR.
    P_TREE-ROLST = P_ROLST.
    P_TREE-NOTAR = P_NTPZ-ZUTAR.
    P_TREE-NOLST = P_NTPZ-ZULST.
    P_TREE-EBENE = P_EBENE.
    P_TREE-FOLGE = P_NTPZ-N1REIHN.
    APPEND P_TREE.

*   Suche alle Unterbäume, die an den Kanten hängen
    PERFORM TREETAB_WRITE TABLES P_NTPZ P_TREE
                          USING  P_ROTAR P_ROLST
                                 P_NTPZ-ZUTAR P_NTPZ-ZULST LV.
    SY-TABIX = IX.
  ENDLOOP.
ENDFORM.                    " TREETAB_WRITE
