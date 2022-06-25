FUNCTION ishmed_initialize_nr_range.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_MANDT) TYPE  MANDT
*"     VALUE(I_OBJECT) TYPE  NROBJ
*"     VALUE(I_FROMNUMBER) TYPE  NRFROM
*"     VALUE(I_TONUMBER) TYPE  NRTO
*"     VALUE(I_NRLEVEL) TYPE  NRLEVEL
*"     VALUE(I_TEST) TYPE  ISH_ON_OFF DEFAULT OFF
*"  EXPORTING
*"     REFERENCE(E_NRIV_ZZ) TYPE  I
*"     REFERENCE(E_NRIV_ZZ_I) TYPE  I
*"     REFERENCE(E_NRIV_ZZ_U) TYPE  I
*"     REFERENCE(E_TNKRS_ZZ) TYPE  I
*"     REFERENCE(E_TNKRS_ZZ_I) TYPE  I
*"     REFERENCE(E_TNKRS_ZZ_U) TYPE  I
*"----------------------------------------------------------------------

  DATA: l_max_nrlevel TYPE nriv-nrlevel.
  DATA: lwa_t000       TYPE t000,
        lwa_nriv       TYPE nriv,
        lwa_tnkrs      TYPE tnkrs.

* NRIV
  CLEAR lwa_nriv.
  lwa_nriv-client     = i_mandt.
  lwa_nriv-object     = i_object.
  lwa_nriv-subobject  = space.
  lwa_nriv-nrrangenr  = '01'.
  lwa_nriv-toyear     = 0.
  lwa_nriv-fromnumber = i_fromnumber.
  lwa_nriv-tonumber   = i_tonumber.
  lwa_nriv-nrlevel    = i_nrlevel.

  SELECT SINGLE nrlevel INTO l_max_nrlevel
                        FROM nriv CLIENT SPECIFIED
                        WHERE client    EQ i_mandt
                          AND object    EQ i_object
                          AND subobject EQ space
                          AND nrrangenr EQ '01'
                          AND toyear    EQ 0.

  IF l_max_nrlevel GT lwa_nriv-nrlevel.
    lwa_nriv-nrlevel = l_max_nrlevel.
  ENDIF.
  lwa_nriv-externind = space.

  IF i_test = off.
    INSERT nriv CLIENT SPECIFIED FROM lwa_nriv.
    IF sy-subrc EQ 0.
      ADD 1 TO e_nriv_zz.
      ADD 1 TO e_nriv_zz_i.
    ELSE.
      UPDATE nriv CLIENT SPECIFIED FROM lwa_nriv.
      IF sy-subrc EQ 0.
        ADD 1 TO e_nriv_zz.
        ADD 1 TO e_nriv_zz_u.
      ENDIF.
    ENDIF.
  ENDIF.

* TNKRS
  CLEAR lwa_tnkrs.
  lwa_tnkrs-mandt = i_mandt.
  lwa_tnkrs-nkobj = i_object.
  lwa_tnkrs-einri = space.
  lwa_tnkrs-modus = 'N'.
  lwa_tnkrs-obkey = '*'.
  lwa_tnkrs-intnk = '01'.
  lwa_tnkrs-extnk = space.
  lwa_tnkrs-alpnk = space.

  IF i_test = off.
    INSERT tnkrs CLIENT SPECIFIED FROM lwa_tnkrs.
    IF sy-subrc EQ 0.
      ADD 1 TO e_tnkrs_zz.
      ADD 1 TO e_tnkrs_zz_i.
    ELSE.
      UPDATE tnkrs CLIENT SPECIFIED FROM lwa_tnkrs.
      IF sy-subrc EQ 0.
        ADD 1 TO e_tnkrs_zz.
        ADD 1 TO e_tnkrs_zz_u.
      ENDIF.
    ENDIF.
  ENDIF.


ENDFUNCTION.
