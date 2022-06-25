FUNCTION ishmed_popup_pcode.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       TABLES
*"              I_TN2FLAG STRUCTURE  TN2FLAG
*"       EXCEPTIONS
*"              FLAGID_NOT_FOUND
*"----------------------------------------------------------------------

  DATA: BEGIN OF help_tab OCCURS 1.
          INCLUDE STRUCTURE rn1f4.
  DATA: END OF help_tab.

  DATA: BEGIN OF headline.
          INCLUDE STRUCTURE rn1f4.
  DATA: END OF headline.

* Übergabe-Datenstrukturen für das Popup füllen
  CLEAR help_tab.   REFRESH help_tab.  CLEAR headline.
* Überschrift erzeugen
* headline-code       = 'PCODE'(001). "Baccolini, 24.09.1998 ID 2847
  headline-key        = 'Icon'(016).
  headline-code       = 'Code'(015).
  headline-text(15)   = 'Bezeichnung'(002).
  headline-other      = 'Prio'(004).
*
  READ TABLE i_tn2flag INDEX 1.                             " ab 4.71A

  help_tab-key     = i_tn2flag-icon.
  help_tab-code    = i_tn2flag-flagid.
  help_tab-text    = i_tn2flag-text.
  help_tab-other   = i_tn2flag-prio.
  APPEND help_tab.

* Popup mit den Daten des Präsentationscodes ausgeben
* call function 'ISHMED_F4_ALLG'
*      exporting
*           i_disp_other = 'X'
*           i_height     = 2
*           i_len_code   = 5
*           i_len_other  = 5
*           i_len_text   = 15
*           i_title      = 'Präsentationscode'(003)
*           i_vcode      = 'DIS'
*           i_sort       = ' '
*           i_headline   = headline
*      tables
*           t_f4tab      = help_tab.

  CALL FUNCTION 'ISHMED_F4_ALLG'                            " ID 2847
       EXPORTING
            i_disp_key   = 'X'
            i_disp_other = 'X'
            i_headline   = headline
            i_height     = 2
            i_len_key    = 4
            i_len_code   = 5
            i_len_other  = 5
            i_len_text   = 15
            i_sort       = 'T'
            i_title      = 'Präsentationscode'(003)
            i_vcode      = 'DIS'
*         i_mfsel      = ' '
*         i_enter_key  = 'X'
*         i_refresh    = ' '
*    importing
*         e_key        =
       TABLES
            t_f4tab      = help_tab
*         T_FUNCTION   =
       EXCEPTIONS
            OTHERS       = 1.

ENDFUNCTION.
