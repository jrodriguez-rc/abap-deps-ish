FUNCTION ish_update_n1asvaluec.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_DATE) TYPE  SY-DATUM DEFAULT SY-DATUM
*"     VALUE(I_UZEIT) TYPE  SY-UZEIT DEFAULT SY-UZEIT
*"     VALUE(I_TCODE) TYPE  SY-TCODE DEFAULT SY-TCODE
*"     VALUE(I_UNAME) TYPE  SY-UNAME DEFAULT SY-UNAME
*"     VALUE(IT_NVN1ASVALUEC) TYPE  ISH_T_VN1ASVALUEC
*"     VALUE(IT_OVN1ASVALUEC) TYPE  ISH_T_VN1ASVALUEC OPTIONAL
*"----------------------------------------------------------------------


* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*  D e r z e i t   n o c h   o h n e
*   Ä n d e r u n g s b e l e g s f o r t s c h r e i b u n g
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  DATA: ls_n1asvaluec  TYPE n1asvaluec.

  FIELD-SYMBOLS: <ls_vn1asvaluec>  TYPE vn1asvaluec.

* Process new data.
  LOOP AT it_nvn1asvaluec ASSIGNING <ls_vn1asvaluec>.
    CASE <ls_vn1asvaluec>-kz.
      WHEN 'I'.
        CLEAR: ls_n1asvaluec.
        MOVE-CORRESPONDING <ls_vn1asvaluec> TO ls_n1asvaluec.
        INSERT n1asvaluec FROM ls_n1asvaluec.
        IF sy-subrc NE 0.
          MESSAGE a077(n1base) WITH 'N1ASVALUEC' ls_n1asvaluec-paramid.
        ENDIF.
      WHEN 'U'.
        CLEAR: ls_n1asvaluec.
        MOVE-CORRESPONDING <ls_vn1asvaluec> TO ls_n1asvaluec.
        UPDATE n1asvaluec FROM ls_n1asvaluec.
        IF sy-subrc NE 0.
          MESSAGE a078(n1base) WITH 'N1ASVALUEC' ls_n1asvaluec-paramid.
        ENDIF.
      WHEN 'D'.
*       MED-67388, Michael Manoch, 01.03.2018   Begin
*        DELETE FROM n1asvaluec WHERE paramid = <ls_vn1asvaluec>-paramid.
        DELETE FROM n1asvaluec WHERE paramid = <ls_vn1asvaluec>-paramid AND mandt = <ls_vn1asvaluec>-mandt.
*       MED-67388, Michael Manoch, 01.03.2018   End
        IF sy-subrc NE 0.
          MESSAGE a079(n1base) WITH 'N1ASVALUEC' ls_n1asvaluec-paramid.
        ENDIF.
    ENDCASE.
  ENDLOOP.



ENDFUNCTION.
