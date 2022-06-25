FUNCTION ish_show_diagnoses.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_EINRI) LIKE  NDIA-EINRI
*"     VALUE(I_PATNR) LIKE  NFAL-PATNR
*"     VALUE(I_ORGFA) LIKE  NBEW-ORGFA OPTIONAL
*"     VALUE(I_VCODE) LIKE  RNPK1-VCODE DEFAULT 'UPD'
*"  EXPORTING
*"     VALUE(E_DIAGNOSE) LIKE  NKDI STRUCTURE  NKDI
*"     VALUE(E_FALNR) LIKE  NDIA-FALNR
*"     VALUE(E_LFDNR) LIKE  NDIA-LFDNR
*"     VALUE(E_DITXT) LIKE  NDIA-DITXT
*"     VALUE(E_DIALO) LIKE  NDIA-DIALO
*"     VALUE(E_DIALOTEXT) LIKE  TN26X-DIALOTEXT
*"     VALUE(E_NODIAG) LIKE  NFAL-FALAR
*"  EXCEPTIONS
*"      NOT_FOUND
*"----------------------------------------------------------------------
  g_einri = i_einri.
  g_patnr = i_patnr.
  g_orgfa = i_orgfa.
  g_vcode = i_vcode.

* Initialisierung
  CLEAR: dia_tab, teil_nfal. REFRESH: dia_tab, teil_nfal.
  CLEAR: e_diagnose, elfdnr, efalnr, ekat, ekey,
         edialo, edialotext, enodiag, anzdia.

* Berechtigungsprüfung für Diagnosen
  PERFORM check_authority.

* Zunächst werden alle Fälle des Patienten ermittelt
  PERFORM fuell_fall_tab.

* Ermitteln der Diagnosen je Fall
  PERFORM diagn_pat.

*   Ermittlung des Customizingparameter Mitarbeiterzuordnung
  PERFORM ren00r(sapmnpa0) USING g_einri 'N1MAOE' n1maoe.
  IF n1maoe = space.
    CLEAR orgid.
  ELSE.
    IF NOT g_orgfa IS INITIAL.
      orgid = g_orgfa.
    ENDIF.
  ENDIF.

* Ausgabe der Diagnosenliste in einem modalen Dialogfenster
  CALL SCREEN 120 STARTING AT 3 5
                  ENDING AT 110 15.

  e_lfdnr = elfdnr.
  e_falnr = efalnr.
  e_ditxt = editxt.
  e_dialo = edialo.
  e_dialotext = edialotext.
  e_nodiag = enodiag.
  IF e_nodiag IS INITIAL AND NOT e_falnr IS INITIAL.
    PERFORM ish_read_nkdi USING ekat ekey
                                nkdi find_nkdi.
    IF find_nkdi EQ false.
      CLEAR nkdi.
    ELSE.
      MOVE-CORRESPONDING nkdi TO e_diagnose.
    ENDIF.
  ENDIF.

* Ausnahmebehandlung, wenn kein Diagnose vorhanden/erfasst
  DESCRIBE TABLE dia_tab.
  IF sy-tfill = 1 AND e_nodiag = 1.
    MESSAGE s037(n1cordmg) WITH g_patnr RAISING not_found.
  ENDIF.

ENDFUNCTION.
