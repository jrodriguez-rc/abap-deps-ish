FUNCTION ISHMED_CHANGE_DATA_FIELD.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_X_FIELDNAME) TYPE  ANY
*"     VALUE(I_FIELDVALUE) TYPE  ANY OPTIONAL
*"     VALUE(I_CHANGES) TYPE  ANY
*"  CHANGING
*"     REFERENCE(C_FIELD) TYPE  ANY
*"     REFERENCE(C_FIELD_X) TYPE  ANY
*"----------------------------------------------------------------------
  field-symbols: <lfs_change> type c.

* Ein Feld darf nur dann geändert werden, wenn es NICHT vom
* aufrufenden Programm gesetzt wurde. Damit soll vermieden werden,
* dass der Aufrufer einen Wert reinstellt, der z.B aus einem Dialog
* stammt, und dieser Wert hier wieder geändert, d.h. zerstört wird
  assign component i_x_fieldname of structure i_changes
                                 to <lfs_change>.
* Diese Abfrage MUSS so zweistufig formuliert sein, da es bei einer
* gemeinsamen Abfrage (IF sy-subrc = 0  and <lfs_change> = space)
* zu einem Dump kommt, wenn SY-SUBRC <> 0, da das Feldsymbol nicht
* zugewiesen werden kommte!
  if sy-subrc <> 0.
*   Entweder wurde I_CHANGES leer übergeben, oder es hat nicht zu
*   diesem Objekt gehört. In beiden Fällen kann ruhig das Feld
*   geändert werden
    c_field   = i_fieldvalue.
    c_field_x = on.
  else.
    if <lfs_change> = space.
*     X-Feld = SPACE, d.h. das Feld wurde NICHT vom aufrufenden
*     Programm geändert, d.h. es darf hier geändert werden
      c_field   = i_fieldvalue.
      c_field_x = on.
    endif.
  endif.
ENDFUNCTION.
