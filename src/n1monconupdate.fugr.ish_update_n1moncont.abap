FUNCTION ish_update_n1moncont.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_DATE) TYPE  SY-DATUM DEFAULT SY-DATUM
*"     VALUE(I_TCODE) TYPE  SY-TCODE
*"     VALUE(I_UNAME) TYPE  SY-UNAME DEFAULT SY-UNAME
*"     VALUE(I_UTIME) TYPE  SY-UZEIT DEFAULT SY-UZEIT
*"     VALUE(IT_NVN1MONCONT) TYPE  ISHMED_T_VN1MONCONT
*"     VALUE(IT_OVN1MONCONT) TYPE  ISHMED_T_VN1MONCONT OPTIONAL
*"----------------------------------------------------------------------

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*  D e r z e i t   n o c h   o h n e
*  Ä n d e r u n g s b e l e g s f o r t s c h r e i b u n g
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  DATA: ls_n1moncont              TYPE n1moncont.

  FIELD-SYMBOLS: <ls_vn1moncont>  TYPE vn1moncont.

* Process new data.
  LOOP AT it_nvn1moncont ASSIGNING <ls_vn1moncont>.
    CASE <ls_vn1moncont>-kz.
      WHEN 'I'.
        CLEAR: ls_n1moncont.
        MOVE-CORRESPONDING <ls_vn1moncont> TO ls_n1moncont.
        INSERT n1moncont FROM ls_n1moncont.
        IF sy-subrc NE 0.
          MESSAGE a077(n1base) WITH 'N1MONCONT' ls_n1moncont-moncon_id.
        ENDIF.
      WHEN 'U'.
        CLEAR: ls_n1moncont.
        MOVE-CORRESPONDING <ls_vn1moncont> TO ls_n1moncont.
        UPDATE n1moncont FROM ls_n1moncont.
        IF sy-subrc NE 0.
          MESSAGE a078(n1base) WITH 'N1MONCONT' ls_n1moncont-moncon_id.
        ENDIF.
      WHEN 'D'.
        DELETE FROM n1moncont
               WHERE spras     = <ls_vn1moncont>-spras
                 AND moncon_id = <ls_vn1moncont>-moncon_id.
        IF sy-subrc NE 0.
          MESSAGE a079(n1base) WITH 'N1MONCONT' ls_n1moncont-moncon_id.
        ENDIF.
    ENDCASE.
  ENDLOOP.

ENDFUNCTION.
