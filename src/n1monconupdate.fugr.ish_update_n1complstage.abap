FUNCTION ish_update_n1complstage.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_DATE) TYPE  SY-DATUM DEFAULT SY-DATUM
*"     VALUE(I_TCODE) TYPE  SY-TCODE
*"     VALUE(I_UNAME) TYPE  SY-UNAME DEFAULT SY-UNAME
*"     VALUE(I_UTIME) TYPE  SY-UZEIT DEFAULT SY-UZEIT
*"     VALUE(IT_NVN1COMPLSTAGE) TYPE  ISHMED_T_VN1COMPLSTAGE
*"     VALUE(IT_OVN1COMPLSTAGE) TYPE  ISHMED_T_VN1COMPLSTAGE OPTIONAL
*"----------------------------------------------------------------------

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*  D e r z e i t   n o c h   o h n e
*  Ä n d e r u n g s b e l e g s f o r t s c h r e i b u n g
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  DATA: ls_n1complstage              TYPE n1complstage.

  FIELD-SYMBOLS: <ls_vn1complstage>  TYPE vn1complstage.

* Process new data.
  LOOP AT it_nvn1complstage ASSIGNING <ls_vn1complstage>.
    CASE <ls_vn1complstage>-kz.
      WHEN 'I'.
        CLEAR: ls_n1complstage.
        MOVE-CORRESPONDING <ls_vn1complstage> TO ls_n1complstage.
        INSERT n1complstage FROM ls_n1complstage.
        IF sy-subrc NE 0.
          MESSAGE a077(n1base) WITH 'N1COMPLSTAGE'
                                    ls_n1complstage-complstage_id.
        ENDIF.
      WHEN 'U'.
        CLEAR: ls_n1complstage.
        MOVE-CORRESPONDING <ls_vn1complstage> TO ls_n1complstage.
        UPDATE n1complstage FROM ls_n1complstage.
        IF sy-subrc NE 0.
          MESSAGE a078(n1base) WITH 'N1COMPLSTAGE'
                                    ls_n1complstage-complstage_id.
        ENDIF.
      WHEN 'D'.
        DELETE FROM n1complstage
               WHERE complstage_id = <ls_vn1complstage>-complstage_id.
        IF sy-subrc NE 0.
          MESSAGE a079(n1base) WITH 'N1COMPLSTAGE'
                                    ls_n1complstage-complstage_id.
        ENDIF.
    ENDCASE.
  ENDLOOP.

ENDFUNCTION.
