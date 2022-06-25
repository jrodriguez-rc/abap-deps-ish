FUNCTION ish_update_n1moncon.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_DATE) TYPE  SY-DATUM DEFAULT SY-DATUM
*"     VALUE(I_TCODE) TYPE  SY-TCODE
*"     VALUE(I_UNAME) TYPE  SY-UNAME DEFAULT SY-UNAME
*"     VALUE(I_UTIME) TYPE  SY-UZEIT DEFAULT SY-UZEIT
*"     VALUE(IT_NVN1MONCON) TYPE  ISHMED_T_VN1MONCON
*"     VALUE(IT_OVN1MONCON) TYPE  ISHMED_T_VN1MONCON OPTIONAL
*"----------------------------------------------------------------------

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*  D e r z e i t   n o c h   o h n e
*  Ä n d e r u n g s b e l e g s f o r t s c h r e i b u n g
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  DATA: ls_n1moncon              TYPE n1moncon.

  FIELD-SYMBOLS: <ls_vn1moncon>  TYPE vn1moncon.

* Process new data.
  LOOP AT it_nvn1moncon ASSIGNING <ls_vn1moncon>.
    CASE <ls_vn1moncon>-kz.
      WHEN 'I'.
        CLEAR: ls_n1moncon.
        MOVE-CORRESPONDING <ls_vn1moncon> TO ls_n1moncon.
        INSERT n1moncon FROM ls_n1moncon.
        IF sy-subrc NE 0.
          MESSAGE a077(n1base) WITH 'N1MONCON' ls_n1moncon-moncon_id.
        ENDIF.
      WHEN 'U'.
        CLEAR: ls_n1moncon.
        MOVE-CORRESPONDING <ls_vn1moncon> TO ls_n1moncon.
        UPDATE n1moncon FROM ls_n1moncon.
        IF sy-subrc NE 0.
          MESSAGE a078(n1base) WITH 'N1MONCON' ls_n1moncon-moncon_id.
        ENDIF.
      WHEN 'D'.
        DELETE FROM n1moncon
               WHERE moncon_id = <ls_vn1moncon>-moncon_id.
        IF sy-subrc NE 0.
          MESSAGE a079(n1base) WITH 'N1MONCON' ls_n1moncon-moncon_id.
        ENDIF.
    ENDCASE.
  ENDLOOP.

ENDFUNCTION.
