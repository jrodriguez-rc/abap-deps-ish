*** Begin of MED-48629 Cristina Jitareanu 24.10.2012
FUNCTION get_all_cases.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_PATNR) TYPE  PATNR
*"     REFERENCE(I_EINRI) TYPE  EINRI
*"  EXPORTING
*"     REFERENCE(RT_NFAL) TYPE  ISH_T_FALNR
*"----------------------------------------------------------------------


  DATA l_patnr TYPE patnr.  " med-48629
  RANGES: r_falnr FOR nfal-falnr,  " med-48629
          r_orgid FOR norg-orgid.  " med-48629

  DATA lt_nfal TYPE ish_t_nfal.

  FIELD-SYMBOLS <fs_nfal> TYPE nfal.

  SELECT * FROM nfal INTO TABLE lt_nfal
           WHERE  einri   = i_einri
           AND    patnr   = i_patnr
           AND    falar = 1.

  LOOP AT lt_nfal ASSIGNING <fs_nfal>.
* Koppensteiner, ID 5111 - End
    r_falnr-sign   = 'I'.
    r_falnr-option = 'EQ'.
    r_falnr-low    = <fs_nfal>-falnr.
    APPEND r_falnr.
  ENDLOOP.

  rt_nfal = lt_nfal.

ENDFUNCTION.
*** End of MED-48629 Cristina Jitareanu 24.10.2012
