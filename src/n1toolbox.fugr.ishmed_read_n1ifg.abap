FUNCTION ishmed_read_n1ifg.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_EINRI) TYPE  EINRI
*"     VALUE(I_IFGE) TYPE  N1IFG-IFGE OPTIONAL
*"     VALUE(I_IFG) TYPE  N1IFG-IFG OPTIONAL
*"  EXPORTING
*"     VALUE(E_IFGE) TYPE  N1IFG-IFGE
*"     VALUE(E_IFG) TYPE  N1IFG-IFG
*"     VALUE(E_IFGICON) TYPE  N1IFG-ICON
*"     VALUE(E_IFGTXT) TYPE  N1IFGT-IFGTXT
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"----------------------------------------------------------------------

  STATICS: lt_n1ifg    TYPE HASHED TABLE OF n1ifg
                       WITH UNIQUE KEY einri ifge,
           l_n1ifg     LIKE LINE OF lt_n1ifg,
           lt_n1ifgt   TYPE HASHED TABLE OF n1ifgt
                       WITH UNIQUE KEY einri ifge,
           l_n1ifgt    LIKE LINE OF lt_n1ifgt.

  e_rc = 0.
  CLEAR: e_ifge, e_ifg, e_ifgicon, e_ifgtxt.

  READ TABLE lt_n1ifg TRANSPORTING NO FIELDS WITH KEY einri = i_einri.
  IF sy-subrc <> 0.
    SELECT * FROM n1ifg INTO TABLE lt_n1ifg
                WHERE einri = i_einri.
    IF sy-subrc = 0.
      SELECT * FROM n1ifgt INTO TABLE lt_n1ifgt
             WHERE  spras  = sy-langu
             AND    einri  = i_einri.
    ENDIF.
  ENDIF.

  IF NOT i_ifge IS INITIAL.
    READ TABLE lt_n1ifg INTO l_n1ifg WITH TABLE KEY einri = i_einri
                                                    ifge  = i_ifge.
    IF sy-subrc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
  ELSEIF NOT i_ifg IS INITIAL.
    READ TABLE lt_n1ifg INTO l_n1ifg WITH KEY einri = i_einri
                                              ifg   = i_ifg.
    IF sy-subrc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
  ELSE.
    e_rc = 1.
    EXIT.
  ENDIF.

  e_ifge    = l_n1ifg-ifge.
  e_ifg     = l_n1ifg-ifg.
  e_ifgicon = l_n1ifg-icon.

  READ TABLE lt_n1ifgt INTO l_n1ifgt WITH TABLE KEY einri = i_einri
                                                    ifge  = e_ifge.
  IF sy-subrc = 0.
    e_ifgtxt = l_n1ifgt-ifgtxt.
  ENDIF.

ENDFUNCTION.
