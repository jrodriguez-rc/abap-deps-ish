*&---------------------------------------------------------------------*
*& Report  RN1CODE
*&
*&---------------------------------------------------------------------*
*& get number of codinglines & search coding for string
*&
*&---------------------------------------------------------------------*

REPORT  rn1code LINE-SIZE 135.

INCLUDE mncolour.

TABLES: tadir.

TYPES: BEGIN OF ty_tadir,
         object                TYPE tadir-object,
         obj_name              TYPE tadir-obj_name,
         devclass              TYPE tadir-devclass,
       END OF ty_tadir.

TYPES: BEGIN OF ty_trdir,
         name                  TYPE trdir-name,
       END OF ty_trdir.

TYPES: BEGIN OF ty_data,
         object                TYPE tadir-object,
         obj_name              TYPE tadir-obj_name,
         devclass              TYPE tadir-devclass,
         komm                  TYPE i,
         code                  TYPE i,
         leer                  TYPE i,
         gesamt                TYPE i,
         tables                TYPE i,
       END OF ty_data.

TYPES: BEGIN OF ty_object,
         object                TYPE tadir-object,
       END OF ty_object.

DATA: lt_tadir                 TYPE STANDARD TABLE OF ty_tadir,
      lt_trdir                 TYPE STANDARD TABLE OF ty_trdir,
      lt_tadir_inc             TYPE STANDARD TABLE OF ty_tadir,
      ls_tadir_inc             TYPE ty_tadir,
      lt_d010inc               TYPE STANDARD TABLE OF d010inc,
      l_tabclass               TYPE dd02l-tabclass,
      l_fugrgroup              TYPE rs38l-area,
      l_include                TYPE rs38l-include.

DATA: lt_object                TYPE TABLE OF ty_object,
      ls_object                LIKE LINE OF lt_object.

DATA: lt_data                  TYPE TABLE OF ty_data,
      ls_data                  LIKE LINE OF lt_data.

DATA: lt_paket                 TYPE TABLE OF ty_data,
      ls_paket                 LIKE LINE OF lt_data,
      lt_summe                 TYPE TABLE OF ty_data,
      ls_summe                 LIKE LINE OF lt_data.

DATA: lt_report                TYPE rswsourcet,
      l_ctext                  TYPE tdevct-ctext,
      l_devclass               TYPE tadir-devclass,
      l_devclass_txt(130)      TYPE c.

FIELD-SYMBOLS: <ls_tadir>      TYPE ty_tadir,
               <ls_tadir_inc>  TYPE ty_tadir,
               <ls_report>     TYPE string,
               <ls_trdir>      TYPE ty_trdir,
               <ls_d010inc>    TYPE d010inc.


SELECT-OPTIONS so_paket FOR tadir-devclass OBLIGATORY.
SELECT-OPTIONS so_autor FOR tadir-author.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS show_prg AS CHECKBOX DEFAULT ' '.
SELECTION-SCREEN COMMENT 4(20) text-001 FOR FIELD show_prg.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS sel_tabl AS CHECKBOX DEFAULT ' '.
SELECTION-SCREEN COMMENT 4(20) text-011 FOR FIELD sel_tabl.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS dosearch AS CHECKBOX DEFAULT ' '.
SELECTION-SCREEN COMMENT 4(20) text-002 FOR FIELD dosearch.
SELECTION-SCREEN POSITION 35.
PARAMETERS ssearch TYPE text50.
SELECTION-SCREEN END OF LINE.


START-OF-SELECTION.

  ls_object = 'FUGR'.
  APPEND ls_object TO lt_object.
  ls_object = 'PROG'.
  APPEND ls_object TO lt_object.
  ls_object = 'CLAS'.
  APPEND ls_object TO lt_object.
  IF sel_tabl = 'X'.
    ls_object = 'TABL'.
    APPEND ls_object TO lt_object.
  ENDIF.

  SELECT object obj_name devclass FROM tadir INTO TABLE lt_tadir
         FOR ALL ENTRIES IN lt_object
         WHERE object    = lt_object-object
           AND pgmid     = 'R3TR'
           AND devclass IN so_paket
           AND author   IN so_autor.  "#EC CI_SGLSELECT "#EC CI_GENBUFF

  IF sel_tabl = 'X'.
    LOOP AT lt_tadir ASSIGNING <ls_tadir> WHERE object = 'TABL'.
      SELECT SINGLE tabclass FROM dd02l INTO l_tabclass
             WHERE  tabname  = <ls_tadir>-obj_name
               AND  as4local = 'A'
               AND  as4vers  = ' '.
      IF sy-subrc <> 0.
        CLEAR l_tabclass.
      ENDIF.
      IF l_tabclass <> 'TRANSP'.
        DELETE lt_tadir.
      ENDIF.
    ENDLOOP.
  ENDIF.

  IF lt_tadir[] IS INITIAL.
    WRITE: 'Es wurden keine Daten selektiert.'(009).
    EXIT.
  ENDIF.

  SORT lt_tadir ASCENDING BY devclass obj_name.

  LOOP AT lt_tadir ASSIGNING <ls_tadir> WHERE object = 'FUGR'.
    ls_tadir_inc = <ls_tadir>.
    CONCATENATE 'SAPL' <ls_tadir>-obj_name INTO ls_tadir_inc-obj_name.
    APPEND ls_tadir_inc TO lt_tadir_inc.
  ENDLOOP.
  DELETE lt_tadir WHERE object = 'FUGR'.
  IF lt_tadir_inc[] IS NOT INITIAL.
    SELECT * FROM d010inc INTO TABLE lt_d010inc
             FOR ALL ENTRIES IN lt_tadir_inc
             WHERE master = lt_tadir_inc-obj_name.
  ENDIF.

  LOOP AT lt_tadir ASSIGNING <ls_tadir>.
    ls_data-object   = <ls_tadir>-object.
    ls_data-obj_name = <ls_tadir>-obj_name.
    ls_data-devclass = <ls_tadir>-devclass.
    IF <ls_tadir>-object = 'PROG'.
      REFRESH lt_report.
      READ REPORT <ls_tadir>-obj_name INTO lt_report.
      LOOP AT lt_report ASSIGNING <ls_report>.
        IF <ls_report> IS NOT INITIAL.
          SHIFT <ls_report> LEFT DELETING LEADING space.
          IF <ls_report>(1) = '*' OR <ls_report>(1) = '"'.
            IF dosearch = 'X'.
              IF <ls_report> CS ssearch.
                ls_data-komm = ls_data-komm + 1.
              ENDIF.
            ELSE.
              ls_data-komm = ls_data-komm + 1.
            ENDIF.
          ELSE.
            IF dosearch = 'X'.
              IF <ls_report> CS ssearch.
                ls_data-code = ls_data-code + 1.
              ENDIF.
            ELSE.
              ls_data-code = ls_data-code + 1.
            ENDIF.
          ENDIF.
        ELSE.
          IF dosearch <> 'X'.
            ls_data-leer = ls_data-leer + 1.
          ENDIF.
        ENDIF.
      ENDLOOP.
      ls_data-gesamt = ls_data-code + ls_data-komm + ls_data-leer.
      APPEND ls_data TO lt_data.
      CLEAR ls_data.
    ELSEIF <ls_tadir>-object = 'CLAS'.
      CONCATENATE <ls_tadir>-obj_name '=%'
             INTO <ls_tadir>-obj_name.
      SELECT name FROM trdir INTO TABLE lt_trdir
             WHERE name LIKE <ls_tadir>-obj_name.
      IF sy-subrc = 0.
        LOOP AT lt_trdir ASSIGNING <ls_trdir>.
          REFRESH lt_report.
          READ REPORT <ls_trdir>-name INTO lt_report.
          LOOP AT lt_report ASSIGNING <ls_report>.
            IF <ls_report> IS NOT INITIAL.
              SHIFT <ls_report> LEFT DELETING LEADING space.
              IF <ls_report>(1) = '*' OR <ls_report>(1) = '"'.
                IF dosearch = 'X'.
                  IF <ls_report> CS ssearch.
                    ls_data-komm = ls_data-komm + 1.
                  ENDIF.
                ELSE.
                  ls_data-komm = ls_data-komm + 1.
                ENDIF.
              ELSE.
                IF dosearch = 'X'.
                  IF <ls_report> CS ssearch.
                    ls_data-code = ls_data-code + 1.
                  ENDIF.
                ELSE.
                  ls_data-code = ls_data-code + 1.
                ENDIF.
              ENDIF.
            ELSE.
              IF dosearch <> 'X'.
                ls_data-leer = ls_data-leer + 1.
              ENDIF.
            ENDIF.
          ENDLOOP.
        ENDLOOP.
      ENDIF.
      ls_data-gesamt = ls_data-code + ls_data-komm + ls_data-leer.
      APPEND ls_data TO lt_data.
      CLEAR ls_data.
    ELSEIF <ls_tadir>-object = 'TABL'.
      ls_data-tables = 1.
      APPEND ls_data TO lt_data.
      CLEAR ls_data.
    ENDIF.
  ENDLOOP.

  LOOP AT lt_tadir_inc ASSIGNING <ls_tadir_inc>.
    ls_data-object = <ls_tadir_inc>-object.
    ls_data-obj_name = <ls_tadir_inc>-obj_name.
    ls_data-devclass = <ls_tadir_inc>-devclass.
    READ REPORT <ls_tadir_inc>-obj_name INTO lt_report.
    LOOP AT lt_report ASSIGNING <ls_report>.
      IF <ls_report> IS NOT INITIAL.
        SHIFT <ls_report> LEFT DELETING LEADING space.
        IF <ls_report>(1) = '*' OR <ls_report>(1) = '"'.
          IF dosearch = 'X'.
            IF <ls_report> CS ssearch.
              ls_data-komm = ls_data-komm + 1.
            ENDIF.
          ELSE.
            ls_data-komm = ls_data-komm + 1.
          ENDIF.
        ELSE.
          IF dosearch = 'X'.
            IF <ls_report> CS ssearch.
              ls_data-code = ls_data-code + 1.
            ENDIF.
          ELSE.
            ls_data-code = ls_data-code + 1.
          ENDIF.
        ENDIF.
      ELSE.
        IF dosearch <> 'X'.
          ls_data-leer = ls_data-leer + 1.
        ENDIF.
      ENDIF.
    ENDLOOP.
    LOOP AT lt_d010inc ASSIGNING <ls_d010inc>
         WHERE master = <ls_tadir_inc>-obj_name.
      CLEAR l_fugrgroup.
      l_include = <ls_d010inc>-include.
      CALL FUNCTION 'FUNCTION_INCLUDE_SPLIT'
        IMPORTING
          group   = l_fugrgroup
        CHANGING
          include = l_include.
      CONCATENATE  'SAPL' l_fugrgroup INTO l_fugrgroup.
      IF l_fugrgroup = <ls_d010inc>-master.
        READ REPORT <ls_d010inc>-include INTO lt_report.
        LOOP AT lt_report ASSIGNING <ls_report>.
          IF <ls_report> IS NOT INITIAL.
            SHIFT <ls_report> LEFT DELETING LEADING space.
            IF <ls_report>(1) = '*' OR <ls_report>(1) = '"'.
              IF dosearch = 'X'.
                IF <ls_report> CS ssearch.
                  ls_data-komm = ls_data-komm + 1.
                ENDIF.
              ELSE.
                ls_data-komm = ls_data-komm + 1.
              ENDIF.
            ELSE.
              IF dosearch = 'X'.
                IF <ls_report> CS ssearch.
                  ls_data-code  = ls_data-code + 1.
                ENDIF.
              ELSE.
                ls_data-code  = ls_data-code + 1.
              ENDIF.
            ENDIF.
          ELSE.
            IF dosearch <> 'X'.
              ls_data-leer = ls_data-leer + 1.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDLOOP.
    ls_data-gesamt = ls_data-code + ls_data-komm + ls_data-leer.
    APPEND ls_data TO lt_data.
    CLEAR ls_data.
  ENDLOOP.

  SORT lt_data ASCENDING BY devclass object.
  LOOP AT lt_data INTO ls_data.
    IF sy-tabix = 1 OR ls_paket-devclass = ls_data-devclass.
      ls_paket-devclass = ls_data-devclass.
      ls_paket-komm = ls_paket-komm + ls_data-komm.
      ls_paket-code = ls_paket-code + ls_data-code.
      ls_paket-leer = ls_paket-leer + ls_data-leer.
      ls_paket-gesamt = ls_paket-gesamt + ls_data-gesamt.
      ls_paket-tables = ls_paket-tables + ls_data-tables.
    ELSE.
      APPEND ls_paket TO lt_paket.
      CLEAR ls_paket.
      ls_paket-devclass = ls_data-devclass.
      ls_paket-komm = ls_paket-komm + ls_data-komm.
      ls_paket-code = ls_paket-code + ls_data-code.
      ls_paket-leer = ls_paket-leer + ls_data-leer.
      ls_paket-gesamt = ls_paket-gesamt + ls_data-gesamt.
      ls_paket-tables = ls_paket-tables + ls_data-tables.
    ENDIF.
  ENDLOOP.
  APPEND ls_paket TO lt_paket.
  SORT lt_paket ASCENDING BY devclass.
  LOOP AT lt_paket INTO ls_paket.
    ls_summe-komm = ls_summe-komm + ls_paket-komm.
    ls_summe-code = ls_summe-code + ls_paket-code.
    ls_summe-leer = ls_summe-leer + ls_paket-leer.
    ls_summe-gesamt = ls_summe-gesamt + ls_paket-gesamt.
    ls_summe-tables = ls_summe-tables + ls_paket-tables.
  ENDLOOP.
  APPEND ls_summe TO lt_summe.

  IF dosearch = 'X'.
    PERFORM col_heading USING ' '.
    WRITE: / sy-vline.
    WRITE: 'Suche nach String:'(010), ssearch.
    WRITE: / sy-uline.
  ENDIF.
  IF show_prg = 'X'.
    PERFORM col_heading USING ' '.
    WRITE: / sy-vline.
    WRITE:    (35) 'Paket'(003).
    WRITE:  39(20) 'Codingzeilen'(004).
    WRITE:  58(20) 'Kommentarzeilen'(005).
    WRITE:  85(20) 'Leerzeilen'(012).
    WRITE: 111(20) 'Gesamt'(006).
    WRITE: / sy-uline.
    LOOP AT lt_paket INTO ls_paket.
      PERFORM col_heading USING ' '.
      WRITE: / sy-vline.
      SELECT SINGLE ctext FROM tdevct INTO l_ctext
             WHERE  devclass  = ls_paket-devclass
             AND    spras     = sy-langu.
      IF sy-subrc = 0.
        CONCATENATE ls_paket-devclass l_ctext INTO l_devclass_txt SEPARATED BY space.
      ENDIF.
      WRITE:   (115) l_devclass_txt.
      WRITE:  / sy-vline.
      IF sel_tabl = 'X'.
        WRITE:  (15) 'Tabellen:'(013).
        WRITE: 17(13) ls_paket-tables.
      ENDIF.
      WRITE:  32(20) ls_paket-code.
      WRITE:  54(20) ls_paket-komm.
      WRITE:  76(20) ls_paket-leer.
      WRITE:  98(20) ls_paket-gesamt.
    ENDLOOP.
    READ TABLE lt_summe INTO ls_summe INDEX 1.
    PERFORM col_total USING ' '.
    WRITE:  / sy-vline.
    WRITE:    sy-uline.
    WRITE:  / sy-vline.
    WRITE:    (30) 'Summe'(007).
    WRITE:  32(20) ls_summe-code.
    WRITE:  54(20) ls_summe-komm.
    WRITE:  76(20) ls_summe-leer.
    WRITE:  98(20) ls_summe-gesamt.
    IF sel_tabl = 'X'.
      WRITE: / sy-vline.
      WRITE:  (15) 'Tabellen:'(013).
      WRITE: 17(13) ls_summe-tables.
      WRITE: 117(1) ' '.
    ENDIF.
    WRITE:  / sy-uline.
  ELSE.
    PERFORM col_normal USING ' '.
    WRITE: / sy-vline.
    WRITE:    (35) 'Programm/Klasse'(008).
    WRITE:  39(20) 'Codingzeilen'(004).
    WRITE:  58(20) 'Kommentarzeilen'(005).
    WRITE:  85(20) 'Leerzeilen'(012).
    WRITE: 111(20) 'Gesamt'(006).
    PERFORM col_heading USING ' '.
    WRITE: / sy-vline.
    WRITE:   (128) 'Paket'(003).
    WRITE: / sy-uline.
    DELETE lt_data WHERE gesamt IS INITIAL.
    LOOP AT lt_data INTO ls_data.
      IF sy-tabix = 1 OR l_devclass = ls_data-devclass.
        PERFORM col_normal USING ' '.
        WRITE: / sy-vline.
        WRITE:    (30) ls_data-obj_name.
        WRITE:  32(20) ls_data-code.
        WRITE:  54(20) ls_data-komm.
        WRITE:  76(20) ls_data-leer.
        WRITE:  98(20) ls_data-gesamt.
        l_devclass = ls_data-devclass.
      ELSE.
        READ TABLE lt_paket INTO ls_paket
             WITH KEY devclass = l_devclass.
        PERFORM col_heading USING ' '.
        WRITE: / sy-vline.
        SELECT SINGLE ctext FROM tdevct INTO l_ctext
               WHERE  devclass  = ls_paket-devclass
               AND    spras     = sy-langu.
        IF sy-subrc = 0.
          CONCATENATE ls_paket-devclass l_ctext INTO l_devclass_txt SEPARATED BY space.
        ENDIF.
        WRITE:   (115) l_devclass_txt.
        WRITE:  / sy-vline.
        IF sel_tabl = 'X'.
          WRITE:  (15) 'Tabellen:'(013).
          WRITE: 17(13) ls_paket-tables.
        ENDIF.
        WRITE:  32(20) ls_paket-code.
        WRITE:  54(20) ls_paket-komm.
        WRITE:  76(20) ls_paket-leer.
        WRITE:  98(20) ls_paket-gesamt.
        PERFORM col_normal USING ' '.
        WRITE: / sy-vline.
        WRITE:    (30) ls_data-obj_name.
        WRITE:  32(20) ls_data-code.
        WRITE:  54(20) ls_data-komm.
        WRITE:  76(20) ls_data-leer.
        WRITE:  98(20) ls_data-gesamt.
        l_devclass = ls_data-devclass.
      ENDIF.
    ENDLOOP.
    READ TABLE lt_paket INTO ls_paket
         WITH KEY devclass = l_devclass.
    PERFORM col_heading USING ' '.
    WRITE: / sy-vline.
    SELECT SINGLE ctext FROM tdevct INTO l_ctext
           WHERE  devclass  = ls_paket-devclass
           AND    spras     = sy-langu.
    IF sy-subrc = 0.
      CONCATENATE ls_paket-devclass l_ctext INTO l_devclass_txt SEPARATED BY space.
    ENDIF.
    WRITE:   (115) l_devclass_txt.
    WRITE:  / sy-vline.
    IF sel_tabl = 'X'.
      WRITE:  (15) 'Tabellen:'(013).
      WRITE: 17(13) ls_paket-tables.
    ENDIF.
    WRITE:  32(20) ls_paket-code.
    WRITE:  54(20) ls_paket-komm.
    WRITE:  86(20) ls_paket-leer.
    WRITE:  98(20) ls_paket-gesamt.
    READ TABLE lt_summe INTO ls_summe INDEX 1.
    PERFORM col_total USING ' '.
    WRITE:  / sy-vline.
    WRITE:    sy-uline.
    WRITE:  / sy-vline.
    WRITE:    (30) 'Summe'(007).
    WRITE:  32(20) ls_summe-code.
    WRITE:  54(20) ls_summe-komm.
    WRITE:  76(20) ls_summe-leer.
    WRITE:  98(20) ls_summe-gesamt.
    IF sel_tabl = 'X'.
      WRITE: / sy-vline.
      WRITE:  (15) 'Tabellen:'(013).
      WRITE: 17(13) ls_summe-tables.
      WRITE: 117(1) ' '.
    ENDIF.
    WRITE:  / sy-uline.
  ENDIF.

* That's the end my friend!
