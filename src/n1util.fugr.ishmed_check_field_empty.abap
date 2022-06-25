FUNCTION ishmed_check_field_empty.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_VALUE) TYPE  ANY
*"     VALUE(I_DDIC_FIELD) TYPE  TABFIELD OPTIONAL
*"     VALUE(I_FIELD_TYPE) TYPE  ANY OPTIONAL
*"  EXPORTING
*"     VALUE(E_EMPTY) TYPE  ISH_ON_OFF
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"  CHANGING
*"     VALUE(C_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------

* Lokale Typen
  TYPES: BEGIN OF ty_split,
            part           TYPE rsdynpar-param,
         END   OF ty_split,
         tyt_split         TYPE STANDARD TABLE OF ty_split.
* Konstanten
  CONSTANTS: l_space       TYPE c    VALUE ' '.
* Lokale Tabellen
  DATA:  lt_split          TYPE tyt_split.
* Workareas
  DATA:  l_split           LIKE LINE OF lt_split.
* Hilfsfelder und -strukturen
  DATA: l_type             TYPE c,
        l_inttype_1(45)    TYPE c,
        l_inttype(45)      TYPE c,
        l_time_date(45)    TYPE c,
        l_hex(45)          TYPE c    VALUE '00',
        l_ctx_dd           TYPE context_free_sel_dd_info,
        l_tfill            TYPE sy-tfill,
        l_convert          TYPE rsconvert.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL AND
     c_errorhandler IS REQUESTED.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  e_empty = off.
* ---------- ---------- ----------
* Feldbeschreibung bestimmen; entweder den übegebenen
* Feldtyp verwenden oder anhand des DDIC-Feldes selbst
* ermitteln.
  IF NOT i_field_type IS INITIAL.
    l_convert-type = i_field_type.
  ELSE.
    SUPPLY tablename = i_ddic_field-tabname
           fieldname = i_ddic_field-fieldname
       TO CONTEXT l_ctx_dd.
    DEMAND  convert     = l_convert
      FROM CONTEXT l_ctx_dd.
  ENDIF.
  IF l_convert-type IS INITIAL.
*   Es konnte keine Feldbeschreibung bestimmt
*   werden => FEHLER
    e_rc = 1.
  ENDIF.
* ---------- ---------- ----------
  MOVE: '0' TO l_inttype_1+44(1), '0' TO l_inttype+43(1).

  CASE l_convert-type.
    WHEN 'C'.
      IF i_value EQ space.
        e_empty = on.
      ENDIF.
    WHEN 'T' .
      MOVE '000000' TO l_time_date.
      IF i_value EQ  l_time_date OR
         i_value EQ  '      '.
        e_empty = on.
      ENDIF.
    WHEN 'D'.
      MOVE '00000000' TO l_time_date.
      IF i_value EQ  l_time_date.
        e_empty = on.
      ENDIF.
    WHEN 'P'.
      SPLIT i_value AT '.' INTO TABLE lt_split.
      DESCRIBE TABLE lt_split LINES l_tfill.
      IF l_tfill LE 2.
        LOOP AT lt_split INTO l_split.
          IF l_split-part CO '0 '.
            ADD 1 TO l_tfill.
          ENDIF.
        ENDLOOP.
        IF l_tfill EQ 4 OR l_tfill EQ 2.
          e_empty = on.
        ENDIF.
      ENDIF.
    WHEN 'I' OR 's' OR 'b'.
      IF i_value = l_inttype_1 OR i_value = l_inttype.
        e_empty = on.
      ENDIF.
    WHEN 'X'.
      IF i_value EQ l_hex.
        e_empty = on.
      ENDIF.
    WHEN 'F'.
      MOVE '0.0000000000000000E+00' TO l_inttype+23.
      IF i_value EQ l_inttype.
        e_empty = on.
      ENDIF.
    WHEN 'N'.
      IF ( i_value CA '0'           AND  i_value CO '0 ' ) OR
         ( i_value CO ' 0123456789' AND  i_value <= 0    ).
        e_empty = on.
      ENDIF.
  ENDCASE.
* ---------- ---------- ----------

ENDFUNCTION.
