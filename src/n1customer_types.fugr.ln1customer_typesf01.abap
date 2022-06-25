*----------------------------------------------------------------------*
***INCLUDE LN1CUSTOMER_TYPESF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  ext_check
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM ext_check.

  DATA: BEGIN OF lt_total OCCURS 0010.
          INCLUDE STRUCTURE n1customer_types.
          INCLUDE STRUCTURE vimflagtab.
  DATA: END OF lt_total.

  DATA ls_total LIKE LINE OF lt_total.   "RD, MED-8273

  IF NOT n1customer_types-clsid IS INITIAL.

    lt_total[] = total[].

    IF n1customer_types-clsid < 30000.
      MESSAGE e039(n1base) WITH 30000.
*   Kundentypen müssen größer/gleich & sein.
    ENDIF.

    IF n1customer_types-clsid > 99999.
      MESSAGE e138(n1base) WITH 99999.
*   Kundentypen müssen kleiner/gleich & sein.
    ENDIF.

* --- check for unique values in columns clsid and idname -----------
*   RD, MED-8273, begin
*    TRANSLATE n1customer_types-idname TO UPPER CASE.     "#EC TRANSLANG
*
*    READ TABLE lt_total
*               TRANSPORTING NO FIELDS
*               WITH KEY idname = n1customer_types-idname.
*    IF sy-subrc EQ 0.
** --- value already present ------------------------------------------
*      MESSAGE e040(n1base) WITH n1customer_types-idname.
**   Kundentypname & ist bereits vergeben. Bitte anderen Namen wählen.
*    ENDIF.
*
*    READ TABLE lt_total
*               TRANSPORTING NO FIELDS
*               WITH KEY clsid = n1customer_types-clsid.
*    IF sy-subrc EQ 0.
** --- value already present ------------------------------------------
*      MESSAGE e041(n1base) WITH n1customer_types-clsid.
**   Kundentyp-ID & ist bereits vergeben. Bitte andere ID wählen.
*    ENDIF.
*  ENDIF.

************************************************************************
*   RD, MED-8273, begin of new code

    TRANSLATE n1customer_types-idname TO UPPER CASE.     "#EC TRANSLANG

    READ TABLE lt_total
               into ls_total
               WITH KEY idname = n1customer_types-idname.
    IF sy-subrc EQ 0.
      IF status = 'EALX'.
        MESSAGE e040(n1base) WITH n1customer_types-idname.
*       Kundentypname & ist bereits vergeben.
*       Bitte anderen Namen wählen.
      ELSE.
*       value already present just the description changed
        IF n1customer_types-description = ls_total-description.
          MESSAGE e040(n1base) WITH n1customer_types-idname.
*         Kundentypname & ist bereits vergeben.
*         Bitte anderen Namen wählen.
        ENDIF.
      ENDIF.
    ENDIF.

    READ TABLE lt_total
               TRANSPORTING NO FIELDS
               WITH KEY clsid = n1customer_types-clsid.
    IF sy-subrc EQ 0.
      IF status = 'EALX'.
        MESSAGE e041(n1base) WITH n1customer_types-clsid.
*       Kundentyp-ID & ist bereits vergeben. Bitte andere ID wählen.
      ELSE.
*       value already present just the description changed
        IF n1customer_types-description = ls_total-description.
          MESSAGE e041(n1base) WITH n1customer_types-clsid.
*         Kundentyp-ID & ist bereits vergeben. Bitte andere ID wählen.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.
* RD, MED-8273, end

ENDFORM.                    " ext_check
