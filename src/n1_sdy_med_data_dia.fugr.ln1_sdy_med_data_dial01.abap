*-------------------------------------------------------------------
***INCLUDE LN2DPL01 .
*-------------------------------------------------------------------
*END-OF-SELECTION
*Zeitpunktelemente

TOP-OF-PAGE.
  PERFORM top_of_page.

AT LINE-SELECTION.
  PERFORM ausw_dia.
  LEAVE.

AT USER-COMMAND.
  CASE sy-ucomm.
    WHEN 'OKAY'.
      PERFORM ausw_dia.
      LEAVE.
    WHEN 'CAN'.                        "Abbruch
      enodiag = 0.                                         "Note 0523456
      SET SCREEN 0. LEAVE SCREEN.
  ENDCASE.
*----------------------------------------------------------------------*
*      Form  TOP_OF_PAGE
*----------------------------------------------------------------------*
FORM top_of_page.
* Ausgabe des Eingabefeldes für eine neue Diagnose/Lokalisation
  PERFORM col_background USING on.
* Berechtigt für neue Diagnose/VCODE = UPD
*  IF auth = true AND g_vcode = 'UPD'.
*    WRITE: /1(15) 'Neue Diagnose'(008), new_dia_ditxt INPUT ON,
*           /1(15) 'Lokalisation'(009),  new_dia_dialo INPUT ON
*                                        USING EDIT MASK '__',
*                                        new_dia_dialotext,
*           /1(15) 'Diagn.Person'(013),  new_dia_diape INPUT ON,
*                                        new_dia_diagname.
*  ENDIF.
* Listausgabenüberschrift
  WRITE: (108) sy-uline.
  PERFORM col_heading USING on.
  WRITE: / sy-vline NO-GAP, 'DiagnDatum'(002),
        12 sy-vline NO-GAP, 'K'(003) NO-GAP,
        15 sy-vline NO-GAP, 'Text/Katalogtext'(004),
        70 sy-vline NO-GAP, 'Lo'(010),
        74 sy-vline NO-GAP, 'DG'(011),
        78 sy-vline NO-GAP, 'DZ'(012),
        82 sy-vline NO-GAP, 'Kt'(005) NO-GAP,
        86 sy-vline NO-GAP, 'Diagnose '(006),
        97 sy-vline NO-GAP, 'Fall'(007) NO-GAP,
       108 sy-vline.
  WRITE:/(108) sy-uline.
ENDFORM.                               " TOP_OF_PAGE
