FUNCTION ish_update_n1complstaget .
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_DATE) TYPE  SY-DATUM DEFAULT SY-DATUM
*"     VALUE(I_TCODE) TYPE  SY-TCODE
*"     VALUE(I_UNAME) TYPE  SY-UNAME DEFAULT SY-UNAME
*"     VALUE(I_UTIME) TYPE  SY-UZEIT DEFAULT SY-UZEIT
*"     VALUE(IT_NVN1COMPLSTAGET) TYPE  ISHMED_T_VN1COMPLSTAGET
*"     VALUE(IT_OVN1COMPLSTAGET) TYPE  ISHMED_T_VN1COMPLSTAGET OPTIONAL
*"----------------------------------------------------------------------

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*  D e r z e i t   n o c h   o h n e
*  Ä n d e r u n g s b e l e g s f o r t s c h r e i b u n g
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  DATA: ls_n1complstaget              TYPE n1complstaget.

  FIELD-SYMBOLS: <ls_vn1complstaget>  TYPE vn1complstaget.

* Process new data.
  LOOP AT it_nvn1complstaget ASSIGNING <ls_vn1complstaget>.
    CASE <ls_vn1complstaget>-kz.
      WHEN 'I'.
        CLEAR: ls_n1complstaget.
        MOVE-CORRESPONDING <ls_vn1complstaget> TO ls_n1complstaget.
        INSERT n1complstaget FROM ls_n1complstaget.
        IF sy-subrc NE 0.
          MESSAGE a077(n1base) WITH 'N1COMPLSTAGET'
                                    ls_n1complstaget-complstage_id.
        ENDIF.
      WHEN 'U'.
        CLEAR: ls_n1complstaget.
        MOVE-CORRESPONDING <ls_vn1complstaget> TO ls_n1complstaget.
        UPDATE n1complstaget FROM ls_n1complstaget.
        IF sy-subrc NE 0.
          MESSAGE a078(n1base) WITH 'N1COMPLSTAGET'
                                    ls_n1complstaget-complstage_id.
        ENDIF.
      WHEN 'D'.
        DELETE FROM n1complstaget
          WHERE spras         = <ls_vn1complstaget>-spras
            AND moncon_id     = <ls_vn1complstaget>-moncon_id
            AND complstage_id = <ls_vn1complstaget>-complstage_id.
        IF sy-subrc NE 0.
          MESSAGE a079(n1base) WITH 'N1COMPLSTAGET'
                                    ls_n1complstaget-complstage_id.
        ENDIF.
    ENDCASE.
  ENDLOOP.

ENDFUNCTION.
