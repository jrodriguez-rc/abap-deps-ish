FUNCTION ishmed_read_nbew.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_EINRI) TYPE  NBEW-EINRI OPTIONAL
*"     VALUE(I_FALNR) TYPE  NBEW-FALNR OPTIONAL
*"     VALUE(I_LFDNR) TYPE  NBEW-LFDNR OPTIONAL
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(E_NBEW) TYPE  NBEW
*"  CHANGING
*"     REFERENCE(C_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------
  DATA: l_nbew     TYPE nbew,
        l_line_key TYPE char100.

* Initialisierungen
  e_rc = 0.
  CLEAR: e_nbew.

  CHECK NOT i_einri IS INITIAL  OR
        NOT i_falnr IS INITIAL  OR
        NOT i_lfdnr IS INITIAL.

  SELECT SINGLE * FROM nbew INTO e_nbew
                  WHERE einri = i_einri
                  AND   falnr = i_falnr
                  AND   lfdnr = i_lfdnr.
  IF sy-subrc <> 0.
    CALL FUNCTION 'ISH_MOVEMENT_POOL_GET'
      EXPORTING
        ss_falnr     = i_falnr
        ss_einri     = i_einri
        ss_lfdnr     = i_lfdnr
      IMPORTING
        ss_nbew_curr = e_nbew.
    IF e_nbew IS INITIAL.
      IF c_errorhandler IS INITIAL.
        CREATE OBJECT c_errorhandler.
      ENDIF.
      e_rc = 4.
      CLEAR: l_nbew,
             l_line_key.
      l_nbew-mandt = sy-mandt.
      l_nbew-einri = i_einri.
      l_nbew-falnr = i_falnr.
      l_nbew-lfdnr = i_lfdnr.
      CALL METHOD cl_ishmed_errorhandling=>build_line_key
        EXPORTING
          i_data     = l_nbew
          i_datatype = 'NBEW'
        IMPORTING
          e_line_key = l_line_key.
*     Bewegung & zu Einri &, Fall & konnte nicht gefunden werden
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ      = 'E'
          i_kla      = 'NFCL'
          i_num      = '164'
          i_mv1      = i_lfdnr
          i_mv2      = i_einri
          i_mv3      = i_falnr
          i_par      = 'NBEW'
          i_last     = space
          i_line_key = l_line_key.
    ENDIF.
  ENDIF.
ENDFUNCTION.
