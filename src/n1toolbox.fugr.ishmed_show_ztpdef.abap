FUNCTION ishmed_show_ztpdef.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(SS_EINRI) LIKE  NORG-EINRI
*"     VALUE(SS_TYP) LIKE  N2ZTPDEF-ZPTYP DEFAULT SPACE
*"     VALUE(SS_TITEL) DEFAULT SPACE
*"     VALUE(I_WITH_EINRI_ASTERISK) TYPE  ISH_ON_OFF DEFAULT '*'
*"     VALUE(I_GET_ZPREFID) TYPE  ISH_ON_OFF DEFAULT SPACE
*"  EXPORTING
*"     VALUE(E_ZMRK) LIKE  N2ZTPDEF-ZPID
*"  EXCEPTIONS
*"      NOT_FOUND
*"----------------------------------------------------------------------
  INCLUDE mndata00.                    " Standarddefinitionen

  DATA: BEGIN OF outtab OCCURS 50.
          INCLUDE STRUCTURE n2ztpdef.
  DATA: END OF outtab.

  DATA: BEGIN OF stati OCCURS 10.
          INCLUDE STRUCTURE rn1f4.
  DATA: END OF stati.

  TABLES: tn01.

  RANGES: r_einri   FOR n2ztpdeft-einri.
  RANGES: r_typ     FOR n2ztpdef-zptyp.

  DATA: einri       TYPE n2ztpdeft-einri,
        title(40)   TYPE c,
        flag(1)     TYPE c.
  DATA: intens(1)   TYPE c.
  DATA: a_key       TYPE rn1f4-key.
  DATA: ztyp        LIKE ss_typ.

  einri   = ss_einri.
  ztyp    = ss_typ.
  title   = ss_titel.

  IF title IS INITIAL.
    title = 'Zeitpunkte'(018).
  ENDIF.

* Einrichtung prüfen (wenn erforderlich)
  IF NOT einri IS INITIAL.
    PERFORM ren01(sapmnpa0) USING einri tn01 flag.
    IF flag = false.
      RAISE not_found.
    ENDIF.
  ENDIF.


* Einrichtung in die Range übernehmen
  CLEAR r_einri.   REFRESH r_einri.
  r_einri-sign   = 'I'.
  r_einri-option = 'EQ'.
  IF einri IS INITIAL.                                      " ID 18697
* START MED-33470 HP 2008/12/17
    IF i_with_einri_asterisk = space.
      RAISE not_found.
    ELSEIF i_with_einri_asterisk = '*'.
* END MED-33470
      r_einri-low  = '*'.   " alle allgemeinen Eintraege selektieren
      APPEND r_einri.
    ENDIF.                                                  "MED-33470
  ELSE.                                                     " ID 18697
    r_einri-low  = einri.
    APPEND r_einri.
  ENDIF.                                                    " ID 18697

* START MED-33470 HP 2008/12/17
  IF i_with_einri_asterisk = on.
    CLEAR r_einri.
    r_einri-sign   = 'I'.
    r_einri-option = 'EQ'.
    r_einri-low  = '*'.
    APPEND r_einri.
  ENDIF.
* END MED-33470

* Typ in die Range übernehmen                     " AE 1.4.99
* Wenn kein Typ übergeben wurde, dann soll die Rangetab nicht
* befüllt werden, um alle Einträge zu selektieren
  CLEAR r_typ.   REFRESH r_typ.
  IF NOT ztyp IS INITIAL.
    r_typ-sign   = 'I'.
    r_typ-option = 'EQ'.
    r_typ-low    = ztyp.
    APPEND r_typ.
  ENDIF.

* Jetzt die Tabelle OUTTAB füllen (die später ausgegeben wird)
  SELECT * FROM n2ztpdef INTO TABLE outtab
           WHERE einri IN r_einri
             AND zptyp IN r_typ.

* if there are no entries with the given institution ->
* try it with institution *
* because in report rn1opzst you have to enter an institution -> so at
* this time the institution is never '*'!!!!! (ID 19186)
  IF sy-subrc <> 0
    AND i_with_einri_asterisk = '*'.                        "MED33470
    SELECT * FROM n2ztpdef INTO TABLE outtab
             WHERE einri = '*'
               AND zptyp IN r_typ.
  ENDIF.

  IF sy-subrc <> 0.
    RAISE not_found.
  ENDIF.

  LOOP AT outtab.
    SELECT SINGLE zpbez FROM n2ztpdeft INTO outtab-zbbez
                    WHERE zpid  = outtab-zpid
                      AND einri = outtab-einri              " ID 18697
                      AND spras = sy-langu.
    MODIFY outtab.
  ENDLOOP.

  SORT outtab BY zpid.
  DELETE ADJACENT DUPLICATES FROM outtab COMPARING zpid.

  CLEAR stati.
  LOOP AT outtab.
    stati-key  = sy-tabix.
*   stati-code = outtab-zpid.                               "MED-57440
    IF i_get_zprefid = on.                                  "MED-57440
      stati-code = outtab-zprefid.
    ELSE.
      stati-code = outtab-zpid.
    ENDIF.
    stati-text = outtab-zbbez.
    APPEND stati.
  ENDLOOP.

  CALL FUNCTION 'ISHMED_F4_ALLG'
    EXPORTING
      i_len_code = 15
      i_len_text = 30
      i_sort     = 'T'
      i_title    = title
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
