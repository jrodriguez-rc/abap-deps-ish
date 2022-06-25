FUNCTION ishmed_show_tn14p.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(SS_EINRI) LIKE  NORG-EINRI
*"  EXPORTING
*"     VALUE(E_WLPRI) LIKE  TN14P-WLPRI
*"  EXCEPTIONS
*"      NOT_FOUND
*"----------------------------------------------------------------------
  INCLUDE mndata00.                    " Standarddefinitionen

  TABLES: tn14q.

  DATA: BEGIN OF outtab OCCURS 50.
          INCLUDE STRUCTURE tn14p.
  DATA: prtxt LIKE tn14q-prtxt.
  DATA: END OF outtab.

  DATA: BEGIN OF stati OCCURS 10.
          INCLUDE STRUCTURE rn1f4.
  DATA: END OF stati.

  DATA: BEGIN OF headl.
          INCLUDE STRUCTURE rn1f4.
  DATA: END OF headl.

  DATA:  einri     TYPE tn14p-einri,
         flag(1)   TYPE c,
         intens(1) TYPE c,
         hight(02) TYPE n,
         a_key     TYPE rn1f4-key.

  RANGES: r_einri  FOR tn14p-einri.

  einri = ss_einri.

* Einrichtung prüfen (wenn erforderlich)
  IF NOT einri IS INITIAL.
    PERFORM ren01(sapmnpa0) USING einri tn01 flag.
    IF flag = false.
      RAISE not_found.
    ENDIF.
  ENDIF.

* Einrichtung in den Range übernehmen
  CLEAR r_einri.   REFRESH r_einri.
  r_einri-sign   = 'I'.
  r_einri-option = 'EQ'.
  r_einri-low    = '*'.   " alle allgemeinen Eintraege selektieren
  APPEND r_einri.
  r_einri-low    = einri.
  APPEND r_einri.

* Jetzt die Tabelle OUTTAB füllen (die später ausgegeben wird)
  SELECT * FROM tn14p INTO TABLE outtab
           WHERE einri IN r_einri.

  IF sy-subrc <> 0.
    RAISE not_found.
  ENDIF.

  LOOP AT outtab.
    SELECT SINGLE * FROM tn14q
    WHERE spras EQ sy-langu
    AND   einri EQ outtab-einri
    AND   wlpri EQ outtab-wlpri.
    IF sy-subrc = 0.
      outtab-prtxt = tn14q-prtxt.
      MODIFY outtab.
    ELSE.
      sy-subrc = 0.
    ENDIF.
  ENDLOOP.

  CLEAR outtab.
  SORT outtab BY einri wlpri.

  CLEAR stati.
  LOOP AT outtab.
    stati-key  = sy-tabix.
    stati-code = outtab-wlpri.
    stati-text = outtab-prtxt.
    APPEND stati.
  ENDLOOP.

  headl-key  = 1.
  headl-code = text-010.
  headl-text = text-011.

  CLEAR stati.
  SORT stati BY code.

  DESCRIBE TABLE stati.
  hight = sy-tfill + 1.

  CALL FUNCTION 'ISHMED_F4_ALLG'
    EXPORTING
      i_headline = headl
      i_len_code = 14
      i_len_text = 62
      i_height   = hight
      i_sort     = 'C'
      i_title    = text-012
      i_activex  = 'X'
    IMPORTING
      e_key      = a_key
    TABLES
      t_f4tab    = stati.

  CLEAR e_wlpri.
  IF NOT a_key IS INITIAL.
    LOOP AT stati WHERE key = a_key.
      EXIT.
    ENDLOOP.
    IF sy-subrc = 0.
      e_wlpri = stati-code.
    ENDIF.
  ENDIF.

ENDFUNCTION.
