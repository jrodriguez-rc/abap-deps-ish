FUNCTION ish_update_n1compldegree.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_DATE) TYPE  SY-DATUM DEFAULT SY-DATUM
*"     VALUE(I_TCODE) TYPE  SY-TCODE
*"     VALUE(I_UNAME) TYPE  SY-UNAME DEFAULT SY-UNAME
*"     VALUE(I_UTIME) TYPE  SY-UZEIT DEFAULT SY-UZEIT
*"     VALUE(IT_NVN1COMPLDEGREE) TYPE  ISHMED_T_VN1COMPLDEGREE
*"     VALUE(IT_OVN1COMPLDEGREE) TYPE  ISHMED_T_VN1COMPLDEGREE OPTIONAL
*"----------------------------------------------------------------------

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*  D e r z e i t   n o c h   o h n e
*  Ä n d e r u n g s b e l e g s f o r t s c h r e i b u n g
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  DATA: ls_n1compldegree              TYPE n1compldegree.

  FIELD-SYMBOLS: <ls_vn1compldegree>  TYPE vn1compldegree.

* Process new data.
  LOOP AT it_nvn1compldegree ASSIGNING <ls_vn1compldegree>.
    CASE <ls_vn1compldegree>-kz.
      WHEN 'I'.
        CLEAR: ls_n1compldegree.
        MOVE-CORRESPONDING <ls_vn1compldegree> TO ls_n1compldegree.
        INSERT n1compldegree FROM ls_n1compldegree.
        IF sy-subrc NE 0.
          MESSAGE a077(n1base) WITH 'N1COMPLDEGREE'
                                    ls_n1compldegree-compldegree_id.
        ENDIF.
      WHEN 'U'.
        CLEAR: ls_n1compldegree.
        MOVE-CORRESPONDING <ls_vn1compldegree> TO ls_n1compldegree.
        UPDATE n1compldegree FROM ls_n1compldegree.
        IF sy-subrc NE 0.
          MESSAGE a078(n1base) WITH 'N1COMPLDEGREE'
                                    ls_n1compldegree-compldegree_id.
        ENDIF.
      WHEN 'D'.
        DELETE FROM n1compldegree
               WHERE compldegree_id = <ls_vn1compldegree>-compldegree_id
.
        IF sy-subrc NE 0.
          MESSAGE a079(n1base) WITH 'N1COMPLDEGREE'
                                    ls_n1compldegree-compldegree_id.
        ENDIF.
    ENDCASE.
  ENDLOOP.

ENDFUNCTION.
