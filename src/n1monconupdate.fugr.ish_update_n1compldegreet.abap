FUNCTION ish_update_n1compldegreet.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_DATE) TYPE  SY-DATUM DEFAULT SY-DATUM
*"     VALUE(I_TCODE) TYPE  SY-TCODE
*"     VALUE(I_UNAME) TYPE  SY-UNAME DEFAULT SY-UNAME
*"     VALUE(I_UTIME) TYPE  SY-UZEIT DEFAULT SY-UZEIT
*"     VALUE(IT_NVN1COMPLDEGREET) TYPE  ISHMED_T_VN1COMPLDEGREET
*"     VALUE(IT_OVN1COMPLDEGREET) TYPE  ISHMED_T_VN1COMPLDEGREET
*"       OPTIONAL
*"----------------------------------------------------------------------

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*  D e r z e i t   n o c h   o h n e
*  Ä n d e r u n g s b e l e g s f o r t s c h r e i b u n g
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  DATA: ls_n1compldegreet              TYPE n1compldegreet.

  FIELD-SYMBOLS: <ls_vn1compldegreet>  TYPE vn1compldegreet.

* Process new data.
  LOOP AT it_nvn1compldegreet ASSIGNING <ls_vn1compldegreet>.
    CASE <ls_vn1compldegreet>-kz.
      WHEN 'I'.
        CLEAR: ls_n1compldegreet.
        MOVE-CORRESPONDING <ls_vn1compldegreet> TO ls_n1compldegreet.
        INSERT n1compldegreet FROM ls_n1compldegreet.
        IF sy-subrc NE 0.
          MESSAGE a077(n1base) WITH 'N1COMPLDEGREET'
                                    ls_n1compldegreet-compldegree_id.
        ENDIF.
      WHEN 'U'.
        CLEAR: ls_n1compldegreet.
        MOVE-CORRESPONDING <ls_vn1compldegreet> TO ls_n1compldegreet.
        UPDATE n1compldegreet FROM ls_n1compldegreet.
        IF sy-subrc NE 0.
          MESSAGE a078(n1base) WITH 'N1COMPLDEGREET'
                                    ls_n1compldegreet-compldegree_id.
        ENDIF.
      WHEN 'D'.
        DELETE FROM n1compldegreet
          WHERE spras          = <ls_vn1compldegreet>-spras
            AND compldegree_id = <ls_vn1compldegreet>-compldegree_id.
        IF sy-subrc NE 0.
          MESSAGE a079(n1base) WITH 'N1COMPLDEGREET'
                                    ls_n1compldegreet-compldegree_id.
        ENDIF.
    ENDCASE.
  ENDLOOP.

ENDFUNCTION.
