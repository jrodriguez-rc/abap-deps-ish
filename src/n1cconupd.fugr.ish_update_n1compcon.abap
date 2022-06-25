FUNCTION ish_update_n1compcon.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IT_VN1COMPCON) TYPE  ISH_T_VN1COMPCON
*"----------------------------------------------------------------------



  DATA: ls_n1compcon  TYPE n1compcon.

  FIELD-SYMBOLS: <ls_vn1compcon>  TYPE vn1compcon.

* Loop the actual data
  LOOP AT it_vn1compcon ASSIGNING <ls_vn1compcon>.
    MOVE-CORRESPONDING <ls_vn1compcon> TO ls_n1compcon.
*   Process depending on KZ
    CASE <ls_vn1compcon>-kz.
      WHEN 'I'.
        INSERT n1compcon FROM ls_n1compcon.
        IF sy-subrc NE 0.
          MESSAGE a077(n1base)
            WITH 'N1COMPCON'
                 <ls_vn1compcon>-compconid.
        ENDIF.
      WHEN 'U'.
        UPDATE n1compcon FROM ls_n1compcon.
        IF sy-subrc NE 0.
          MESSAGE a078(n1base)
            WITH 'N1COMPCON'
                 <ls_vn1compcon>-compconid.
        ENDIF.
      WHEN 'D'.
        DELETE n1compcon FROM ls_n1compcon.
        IF sy-subrc NE 0.
          MESSAGE a079(n1base)
            WITH 'N1COMPCON'
                 <ls_vn1compcon>-compconid.
        ENDIF.
    ENDCASE.
  ENDLOOP.

ENDFUNCTION.
