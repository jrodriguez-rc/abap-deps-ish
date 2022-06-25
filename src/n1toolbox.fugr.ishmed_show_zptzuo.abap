FUNCTION ishmed_show_zptzuo.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(SS_EINRI) LIKE  NORG-EINRI
*"  EXPORTING
*"     VALUE(E_ZMRK) LIKE  N1ZPTZUO-ZUOBEZ
*"  EXCEPTIONS
*"      NOT_FOUND
*"----------------------------------------------------------------------
  INCLUDE mndata00.                    " Standarddefinitionen

  DATA: BEGIN OF outtab OCCURS 50.
          INCLUDE STRUCTURE n1zptzuo.
  DATA: zpbez1 LIKE n2ztpdeft-zpbez,
        zpbez2 LIKE n2ztpdeft-zpbez.
  DATA: END OF outtab.

  DATA: BEGIN OF stati OCCURS 10.
          INCLUDE STRUCTURE rn1f4.
  DATA: END OF stati.

  RANGES: r_einri FOR n1zptzuo-einri.
  DATA:  einri LIKE n1zptzuo-einri,
         flag(1).
  DATA: intens(1).
  DATA: a_key LIKE rn1f4-key.

  einri      = ss_einri.

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
  SELECT * FROM n1zptzuo
              INTO TABLE outtab
              WHERE einri IN r_einri.

  IF sy-subrc <> 0.
    RAISE not_found.
  ENDIF.

  LOOP AT outtab.
    SELECT SINGLE zpbez FROM n2ztpdeft INTO outtab-zpbez1
                  WHERE zpid = outtab-zpid1 AND
                        spras = sy-langu.
    SELECT SINGLE zpbez FROM n2ztpdeft INTO outtab-zpbez2
                  WHERE zpid = outtab-zpid2 AND
                        spras = sy-langu.
    MODIFY outtab.
  ENDLOOP.

  SORT outtab BY zpid1 zpid2.
*  delete adjacent duplicates from outtab comparing zpid1 zpid2.

  CLEAR stati.
  LOOP AT outtab.
    stati-key  = sy-tabix.
    stati-code = outtab-zuobez.
    CONCATENATE outtab-zpbez1 '-' outtab-zpbez2 INTO stati-text.
    APPEND stati.
  ENDLOOP.

  CALL FUNCTION 'ISHMED_F4_ALLG'
    EXPORTING
      i_len_code = 14
      i_len_text = 62
      i_sort     = 'T'
      i_title    = 'Zeitpunkt'(019)
      i_activex  = 'X'
    IMPORTING
      e_key      = a_key
    TABLES
      t_f4tab    = stati.

  CLEAR e_zmrk.
  IF NOT a_key IS INITIAL.
    LOOP AT stati WHERE key = a_key.
      EXIT.
    ENDLOOP.
    IF sy-subrc = 0.
      e_zmrk = stati-code.
    ENDIF.
  ENDIF.

ENDFUNCTION.
