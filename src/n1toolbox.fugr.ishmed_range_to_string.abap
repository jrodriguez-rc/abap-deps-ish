FUNCTION ISHMED_RANGE_TO_STRING.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(I_LENGTH) DEFAULT 80
*"       TABLES
*"              RANGES_TAB
*"       CHANGING
*"             VALUE(C_STRING) TYPE  C
*"       EXCEPTIONS
*"              EX_INVALID_RANGE
*"----------------------------------------------------------------------

* Feldbezeichungen fuer Rangefelder
  FIELD-SYMBOLS: <SIGN>, <OPTION>, <LOW>, <HIGH>.

*       temporaere Variablen fuer Stringlaengen
  DATA: SLEN TYPE I,
        DLEN TYPE I.

*       Strings fuer Inklusiv- bzw. Exklusiveintraege (SIGN)
  DATA: ISTR(1)  VALUE '+',
        ESTR(1)  VALUE '-'.

*       Strings fuer die jeweiligen OPTION-Eintraege
  DATA: EQSTR(1) VALUE '+',
        NESTR(1) VALUE '-',
        GTSTR(1) VALUE '>',
        LTSTR(1) VALUE '<',
        GESTR(2) VALUE '>=',
        LESTR(2)  VALUE '<=',
        BTSTR0(1) VALUE '+',
        BTSTR1(1) VALUE '',
        BTSTR2(5) VALUE '#bis#',   " # fungiert als Platzhalter
        BTSTR3(1) VALUE '',       "   fuer Leerzeichen
        NBSTR0(1) VALUE '-',
        NBSTR1(1) VALUE '',
        NBSTR2(5) VALUE '#bis#',
        NBSTR3(1) VALUE '',
        CPSTR(1) VALUE '+',
        NPSTR(1) VALUE '-'.

*       String der bei zu langem Text angehaengt wird, damit der
*       Benutzer weiss, das nicht alles angezeigt wird
DATA:   DOTSTR(3) VALUE '...'.

  CLEAR C_STRING.

  ASSIGN COMPONENT: 1 OF STRUCTURE RANGES_TAB TO <SIGN>,
                    2 OF STRUCTURE RANGES_TAB TO <OPTION>,
                    3 OF STRUCTURE RANGES_TAB TO <LOW>,
                    4 OF STRUCTURE RANGES_TAB TO <HIGH>.

  LOOP AT RANGES_TAB.
    CASE <SIGN>.
      WHEN 'I'.
        CONCATENATE C_STRING ISTR INTO C_STRING.
      WHEN 'E'.
        CONCATENATE C_STRING ESTR INTO C_STRING.
      WHEN OTHERS.
        RAISE EX_INVALID_RANGE.
    ENDCASE.

    CASE <OPTION>.
      WHEN 'EQ'.
        CONCATENATE C_STRING EQSTR <LOW> INTO C_STRING.
      WHEN 'NE'.
        CONCATENATE C_STRING NESTR <LOW> INTO C_STRING.
      WHEN 'GT'.
        CONCATENATE C_STRING GTSTR <LOW> INTO C_STRING.
      WHEN 'LT'.
        CONCATENATE C_STRING LTSTR <LOW> INTO C_STRING.
      WHEN 'GE'.
        CONCATENATE C_STRING GESTR <LOW> INTO C_STRING.
      WHEN 'LE'.
        CONCATENATE C_STRING LESTR <LOW> INTO C_STRING.
      WHEN 'BT'.
        CONCATENATE C_STRING BTSTR0 BTSTR1 <LOW> BTSTR2
                                 <HIGH> BTSTR3 INTO C_STRING.
      WHEN 'NB'.
        CONCATENATE C_STRING NBSTR0 NBSTR1 <LOW> NBSTR2
                                 <HIGH> NBSTR3 INTO C_STRING.
      WHEN 'CP'.
        CONCATENATE C_STRING CPSTR <LOW> INTO C_STRING.
      WHEN 'NP'.
        CONCATENATE C_STRING NPSTR <LOW> INTO C_STRING.
      WHEN OTHERS.
        RAISE EX_INVALID_RANGE.
    ENDCASE.
  ENDLOOP.                             " loop at ranges_tab

* Durch die +/- von SIGN und den Operatoren muessen ++, +-, -+ und --
* zu +, -, - und + konvertiert werden
  DO.
    REPLACE '++' WITH ' +' INTO C_STRING.
    IF SY-SUBRC <> 0.
      EXIT.
    ENDIF.
  ENDDO.

  DO.
    REPLACE '-+' WITH ' -' INTO C_STRING.
    IF SY-SUBRC <> 0.
      EXIT.
    ENDIF.
  ENDDO.

  DO.
    REPLACE '+-' WITH ' -' INTO C_STRING.
    IF SY-SUBRC <> 0.
      EXIT.
    ENDIF.
  ENDDO.

  DO.
    REPLACE '--' WITH ' +' INTO C_STRING.
    IF SY-SUBRC <> 0.
      EXIT.
    ENDIF.
  ENDDO.

  CONDENSE C_STRING NO-GAPS.
  SHIFT C_STRING LEFT DELETING LEADING '+'.  "fuehrendes + loeschen
  TRANSLATE C_STRING USING '# '.

  DLEN = STRLEN( DOTSTR ).
  SLEN = STRLEN( C_STRING ).

  IF SLEN > I_LENGTH.
    SLEN = I_LENGTH - DLEN.
    MOVE C_STRING(SLEN) TO C_STRING.
    CONCATENATE C_STRING DOTSTR INTO C_STRING.
*    write (dotstr) to c_string+slen(dlen).
  ENDIF.
ENDFUNCTION.
