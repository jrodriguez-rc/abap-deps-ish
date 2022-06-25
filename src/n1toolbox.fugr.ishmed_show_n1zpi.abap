FUNCTION ishmed_show_n1zpi.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(SS_EINRI) LIKE  NORG-EINRI
*"             VALUE(SS_ZPITY) LIKE  N1ZPI-ZPITY
*"       EXPORTING
*"             VALUE(E_N1ZPI) LIKE  N1ZPI STRUCTURE  N1ZPI
*"       EXCEPTIONS
*"              NOT_FOUND
*"----------------------------------------------------------------------
  INCLUDE mndata00.                    " Standarddefinitionen

  TABLES: n1zpi,
          n1zpit.

  DATA: BEGIN OF outtab OCCURS 50.
          INCLUDE STRUCTURE n1zpi.
  DATA: zpitxt LIKE n1zpit-zpitxt.
  DATA: END OF outtab.

  DATA: BEGIN OF stati OCCURS 10.
          INCLUDE STRUCTURE rn1f4.
  DATA: END OF stati.

  DATA: BEGIN OF headl.
          INCLUDE STRUCTURE rn1f4.
  DATA: END OF headl.

  RANGES: r_einri  FOR n1zpi-einri.

  DATA:  einri     TYPE n1zpi-einri,
         flag(1)   TYPE c,
         intens(1) TYPE c,
         hight(02) TYPE n,
         a_key     TYPE rn1f4-key.

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
  SELECT * FROM n1zpi INTO TABLE outtab
           WHERE einri IN r_einri
             AND zpity EQ ss_zpity.

  IF sy-subrc <> 0.
    RAISE not_found.
  ENDIF.

  LOOP AT outtab.
    SELECT SINGLE * FROM n1zpit
    WHERE spras EQ sy-langu
    AND   einri EQ outtab-einri
    AND   zpie  EQ outtab-zpie.
    IF sy-subrc = 0.
      outtab-zpitxt = n1zpit-zpitxt.
      MODIFY outtab.
    ELSE.
      sy-subrc = 0.
    ENDIF.
  ENDLOOP.

  SORT outtab BY einri rfgnr.
*  delete adjacent duplicates from outtab comparing zpid1 zpid2.

  CLEAR stati.
  LOOP AT outtab.
    stati-key   = sy-tabix.
    stati-code  = outtab-zpie.
    stati-text  = outtab-zpitxt.
    stati-other = outtab-rfgnr.
    APPEND stati.
  ENDLOOP.

  headl-key  = 1.
  headl-code = text-013.
  headl-text = text-011.

  DESCRIBE TABLE stati.
  hight = sy-tfill + 1.

  CALL FUNCTION 'ISHMED_F4_ALLG'
    EXPORTING
      i_headline = headl
      i_len_code = 14
      i_len_text = 62
      i_height   = hight
      i_sort     = 'O'
      i_title    = text-014
      i_activex  = 'X'
    IMPORTING
      e_key      = a_key
    TABLES
      t_f4tab    = stati.

  CLEAR e_n1zpi.
  IF NOT a_key IS INITIAL.
    LOOP AT stati WHERE key = a_key.
      EXIT.
    ENDLOOP.
    IF sy-subrc = 0.
      SELECT SINGLE * FROM n1zpi
      WHERE einri EQ einri
      AND   zpie  EQ stati-code.
      IF sy-subrc = 0.
        e_n1zpi = n1zpi.
      ELSE.
        sy-subrc = 0.
      ENDIF.
    ENDIF.
  ENDIF.

ENDFUNCTION.
