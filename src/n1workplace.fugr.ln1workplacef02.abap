*----------------------------------------------------------------------*
***INCLUDE LN1WORKPLACEF02 .
*----------------------------------------------------------------------*

*&--------------------------------------------------------------------*
*&      Form  get_wplace_services
*&--------------------------------------------------------------------*
FORM get_wplace_services TABLES pt_nwpvz_usz  STRUCTURE nwpvz_usz
                                pt_workplaces STRUCTURE v_nwplace
                                pt_rolle                "#EC *
                                pt_messages   STRUCTURE bapiret2
                         USING  p_placeid     TYPE nwplaceid
                                p_placetype   TYPE nwplacetype
                                p_viewid      TYPE nwplaceid
                                p_viewtype    TYPE nwplacetype
                                p_uname       TYPE sy-uname
                                p_rc          LIKE sy-subrc.

  DATA: lt_nwpvz_usz     TYPE TABLE OF nwpvz_usz,
        l_wa_nwpvz_usz   LIKE nwpvz_usz,
        l_wa_msg         LIKE bapiret2,
        l_wa_nwplace     LIKE nwplace,
        l_placetype      TYPE nwplacetype,
        l_placeid        TYPE nwplaceid.
  DATA: l_count          TYPE i.                            "MED-68717

* BEGIN BM MED-68717
  CLEAR l_count.
  DESCRIBE TABLE pt_workplaces LINES l_count.
  IF l_count > 0.
    READ TABLE pt_workplaces INDEX l_count.
  ENDIF.
* END BM MED-68717
  l_placetype = pt_workplaces-wplacetype.
  l_placeid   = pt_workplaces-wplaceid.
  CLEAR pt_workplaces. REFRESH pt_workplaces.

* Zuerst die zum User vorhandenen Arbeitsumfelder lesen
  REFRESH: lt_nwpvz_usz.
  LOOP AT gt_nwpvz_usz INTO l_wa_nwpvz_usz
                       WHERE wplacetype = l_placetype
                       AND   viewtype   = p_viewtype
                       AND   viewid     = p_viewid
                       AND   benutzer   = p_uname.
    APPEND l_wa_nwpvz_usz TO lt_nwpvz_usz.
  ENDLOOP.

* Dann auch die Arbeitsumf. zu einer der Rollen des Benutzers lesen
  IF pt_rolle[] IS NOT INITIAL.
    LOOP AT gt_nwpvz_usz INTO l_wa_nwpvz_usz
                      WHERE wplacetype = l_placetype
                      AND   wplaceid   = l_placeid
                      AND   viewtype   = p_viewtype
                      AND   viewid     = p_viewid
                      AND   benutzer   =  '*'
                      AND   agr_name   IN pt_rolle.
      APPEND l_wa_nwpvz_usz TO lt_nwpvz_usz.
    ENDLOOP.
  ENDIF.
  DESCRIBE TABLE lt_nwpvz_usz.
  IF sy-tfill = 0.
    LOOP AT gt_nwpvz_usz INTO l_wa_nwpvz_usz
                      WHERE wplacetype = l_placetype
                      AND   wplaceid   = l_placeid
                      AND   viewtype   = p_viewtype
                      AND   viewid     = p_viewid
                      AND   benutzer   = '*'
                      AND   agr_name   = space.
      APPEND l_wa_nwpvz_usz TO lt_nwpvz_usz.
    ENDLOOP.
    DESCRIBE TABLE lt_nwpvz_usz.
    IF sy-tfill = 0.
      SELECT * FROM nwpvz_usz INTO TABLE lt_nwpvz_usz       "#EC *
               WHERE wplacetype = l_placetype
               AND   wplaceid   = l_placeid
               AND   viewtype   = p_viewtype
               AND   viewid     = p_viewid
               AND   benutzer   = p_uname.
      IF pt_rolle[] IS NOT INITIAL.
        SELECT * FROM nwpvz_usz APPENDING TABLE lt_nwpvz_usz"#EC *
                 WHERE wplacetype = l_placetype
                 AND   wplaceid   = l_placeid
                 AND   viewtype   = p_viewtype
                 AND   viewid     = p_viewid
                 AND   benutzer   = '*'
                 AND   agr_name   IN pt_rolle.
      ENDIF.
      DESCRIBE TABLE lt_nwpvz_usz.
      IF sy-tfill = 0.
        SELECT * FROM nwpvz_usz INTO TABLE lt_nwpvz_usz     "#EC *
                 WHERE wplacetype = l_placetype
                 AND   wplaceid   = l_placeid
                 AND   viewtype   = p_viewtype
                 AND   viewid     = p_viewid
                 AND   benutzer   = '*'
                 AND   agr_name   = space.
        DESCRIBE TABLE lt_nwpvz_usz.
      ENDIF.

      DESCRIBE TABLE lt_nwpvz_usz.
      IF sy-tfill = 0.
*       Wenn keines gepflegt ist, ausgeliefertes SAP-Standard-
*       Arbeitsumfeld lesen
        SELECT SINGLE * FROM nwplace INTO l_wa_nwplace
               WHERE  wplacetype  = p_placetype
               AND    wplaceid    = 'SAPSERVICE'.
        IF sy-subrc = 0.
          CLEAR l_wa_nwpvz_usz.
          l_wa_nwpvz_usz-wplacetype     = l_placetype.
          l_wa_nwpvz_usz-wplaceid       = 'SAPSERVICE'.
          l_wa_nwpvz_usz-benutzer       = '*'.
          l_wa_nwpvz_usz-dep_wplacetype = p_placetype.
          APPEND l_wa_nwpvz_usz TO lt_nwpvz_usz.
        ELSE.
*         Keine passenden Arb.umfelder für User & gefunden
          PERFORM build_bapiret2(sapmn1pa)
                  USING 'E' 'NF1' '227' p_uname space space space
                        'I_UNAME' space space
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO pt_messages.
          p_rc = 1.
          EXIT.
        ENDIF.
      ELSE.
        SORT lt_nwpvz_usz BY wplacetype wplaceid ASCENDING.
        DELETE ADJACENT DUPLICATES FROM lt_nwpvz_usz
               COMPARING wplacetype wplaceid.
      ENDIF.
      gt_nwpvz_usz[] = lt_nwpvz_usz[].
    ENDIF.
  ENDIF.

* Falls nur ein bestimmtes Arbeitsumfeld retourniert werden soll,
* dann nur dieses zurückliefern, im Puffer aber alle Arbeitsumfelder
* des Benutzers belassen!!!
  IF NOT p_placeid IS INITIAL.
    DELETE lt_nwpvz_usz WHERE wplaceid <> p_placeid.
    DESCRIBE TABLE lt_nwpvz_usz.
    IF sy-tfill = 0.
      CLEAR l_wa_nwpvz_usz.
      l_wa_nwpvz_usz-wplacetype = p_placetype.
      l_wa_nwpvz_usz-wplaceid   = p_placeid.
      l_wa_nwpvz_usz-viewtype   = p_viewtype.
      l_wa_nwpvz_usz-viewid     = p_viewid.
      APPEND l_wa_nwpvz_usz TO lt_nwpvz_usz.
    ENDIF.
  ENDIF.

  pt_nwpvz_usz[] = lt_nwpvz_usz[].

* Auslesen der Arbeitsumfelder
  LOOP AT lt_nwpvz_usz INTO l_wa_nwpvz_usz.
    READ TABLE gt_nwplace INTO pt_workplaces
               with key wplacetype = l_wa_nwpvz_usz-dep_wplacetype
                        wplaceid   = l_wa_nwpvz_usz-dep_wplaceid.
    IF sy-subrc = 0.
      APPEND pt_workplaces.
    ENDIF.
  ENDLOOP.

  DESCRIBE TABLE pt_workplaces.
  IF sy-tfill = 0.
    SELECT * FROM nwplace INTO TABLE pt_workplaces
             FOR ALL ENTRIES IN lt_nwpvz_usz
             WHERE wplacetype = lt_nwpvz_usz-dep_wplacetype
             AND   wplaceid   = lt_nwpvz_usz-dep_wplaceid.  "#EC ENHOK
    IF sy-subrc = 0.
      LOOP AT pt_workplaces.
        APPEND pt_workplaces TO gt_nwplace.
      ENDLOOP.
    ELSE.
*     Keine passenden Arb.umfelder für User & gefunden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '227' p_uname space space space
                    'I_UNAME' space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      p_rc = 1.
      EXIT.
    ENDIF.
  ENDIF.

ENDFORM.                    "GET_WPLACE_SERVICES
