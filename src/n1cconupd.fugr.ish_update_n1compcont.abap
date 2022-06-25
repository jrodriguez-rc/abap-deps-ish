FUNCTION ish_update_n1compcont.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IT_VN1COMPCONT) TYPE  ISH_T_VN1COMPCONT
*"----------------------------------------------------------------------



  DATA: ls_n1compcont  TYPE n1compcont.

  FIELD-SYMBOLS: <ls_vn1compcont>  TYPE vn1compcont.

* Loop the actual data
  LOOP AT it_vn1compcont ASSIGNING <ls_vn1compcont>.
    MOVE-CORRESPONDING <ls_vn1compcont> TO ls_n1compcont.
*   Process depending on KZ
    CASE <ls_vn1compcont>-kz.
      WHEN 'I'.
        INSERT n1compcont FROM ls_n1compcont.
        IF sy-subrc NE 0.
          MESSAGE a077(n1base)
            WITH 'N1COMPCONT'
                 <ls_vn1compcont>-compconid.
        ENDIF.
      WHEN 'U'.
        UPDATE n1compcont FROM ls_n1compcont.
        IF sy-subrc NE 0.
          MESSAGE a078(n1base)
            WITH 'N1COMPCONT'
                 <ls_vn1compcont>-compconid.
        ENDIF.
      WHEN 'D'.
        DELETE n1compcont FROM ls_n1compcont.
        IF sy-subrc NE 0.
          MESSAGE a079(n1base)
            WITH 'N1COMPCONT'
                 <ls_vn1compcont>-compconid.
        ENDIF.
    ENDCASE.
  ENDLOOP.

ENDFUNCTION.
