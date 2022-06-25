FUNCTION ishmed_popup_orgid.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       TABLES
*"              SS_NBEW STRUCTURE  NBEW
*"----------------------------------------------------------------------

  TABLES nbau.

  DATA: BEGIN OF help_tab OCCURS 1.
          INCLUDE STRUCTURE rn1f4.
  DATA: END OF help_tab.

  DATA: BEGIN OF headline.
          INCLUDE STRUCTURE rn1f4.
  DATA: END OF headline.

  DATA baukurz LIKE nbau-bkurz.

  CLEAR nbau.
  baukurz = ' '.
  CALL METHOD cl_ish_dbr_bau=>get_bau_by_bauid
    EXPORTING
      i_bauid = ss_nbew-zimmr
    IMPORTING
      es_nbau = nbau.
  baukurz = nbau-bkurz.

* Übergabe-Datenstrukturen für das Popup füllen
  CLEAR help_tab.   REFRESH help_tab.  CLEAR headline.
* Überschrift erzeugen
  headline-key(10)    = 'Station'(005).
  headline-code(10)   = 'Zimmer'(007).
  headline-text(10)   = 'Kürzel'(006).
  headline-other(10)  = 'Bett'(008).
*
  help_tab-key     = ss_nbew-orgpf.
  help_tab-code    = ss_nbew-zimmr.
  help_tab-text    = baukurz.
  help_tab-other   = ss_nbew-bett.
  APPEND help_tab.

* Popup mit den Daten des Präsentationscodes ausgeben
  CALL FUNCTION 'ISHMED_F4_ALLG'
    EXPORTING
      i_disp_key   = 'X'
      i_disp_other = 'X'
      i_height     = 2
      i_len_key    = 10
      i_len_code   = 10
      i_len_other  = 10
      i_len_text   = 10
      i_title      = 'Aufenthaltsort Patient'(009)
      i_vcode      = 'DIS'
      i_sort       = ' '
      i_headline   = headline
    TABLES
      t_f4tab      = help_tab.





ENDFUNCTION.
