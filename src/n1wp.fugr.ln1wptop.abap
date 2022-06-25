FUNCTION-POOL n1wp  MESSAGE-ID nf1.

CONSTANTS: co_usage_follow_up_visit   TYPE n1plusage VALUE 'FV'.


INCLUDE mndata00.

INCLUDE <icon>.


TABLES: nbew.                           " für Dynpro 0100

* ---------------------------------------------------------------------
* type definitions
* ---------------------------------------------------------------------

* type for medical record information
TYPES: BEGIN OF ty_ka,
         patnr LIKE ndoc-patnr,
         dokar LIKE ndoc-dokar,      " for authority check
       END OF ty_ka.

* type for treating doctor information
TYPES: BEGIN OF ty_nfpz,
         einri  LIKE nfpz-einri,
         falnr  LIKE nfpz-falnr,
         pernr  LIKE nfpz-pernr,
         lfdnr  LIKE nfpz-lfdnr,
         lfdbw  LIKE nfpz-lfdbw,                            " ID 8013
         farzt  LIKE nfpz-farzt,
       END OF ty_nfpz.

* type for treating doctor name information
TYPES: BEGIN OF ty_ngpa,
         gpart  LIKE ngpa-gpart,
         titel  LIKE ngpa-titel,
*        vorsw  LIKE ngpa-titel,         "MED-50799 NedaV
*        name1  LIKE ngpa-titel,         "MED-50799 NedaV
*        name2  LIKE ngpa-titel,         "MED-50799 NedaV
         vorsw  LIKE ngpa-vorsw,         "MED-50799 NedaV
         name1  LIKE ngpa-name1,         "MED-50799 NedaV
         name2  LIKE ngpa-name2,         "MED-50799 NedaV
       END OF ty_ngpa.

* type for diagnosis catalog information
TYPES: BEGIN OF ty_nkdi,
         spras  LIKE nkdi-spras,
         dkat   LIKE nkdi-dkat,
         dkey   LIKE nkdi-dkey,
         dtext1 LIKE nkdi-dtext1,
       END OF ty_nkdi.

* type for nursing service information
TYPES: BEGIN OF ty_pfl_nlem,
         falnr  LIKE nlem-falnr,
         ibgdt  LIKE nlem-ibgdt,                            "MED-29612
         ibzt   LIKE nlem-ibzt,
         lsstae LIKE nlem-lsstae,                           "MED-29612
         lnrls  LIKE nlem-lnrls,                            "MED-29612
         ankls  like nlem-ankls,                            "MED-58787
         n1pfllei type nlem-n1pfllei,                       "MED-58787
       END OF ty_pfl_nlem.

TYPES: BEGIN OF ty_pfl_n1srv,
         patnr  TYPE n1srv-patnr,
         psdat  TYPE n1srv-psdat,
         pstim  TYPE n1srv-pstim,
         status TYPE n1srv-status,
         srvid  TYPE n1srv-srvid,
         stokz  type n1srv-stokz,                           "MED-58787
         einri  type n1srv-einri,                           "MED-58787
       END OF ty_pfl_n1srv.

* type for document information
TYPES: BEGIN OF ty_dok,
         falnr  LIKE nlem-falnr,
         medok  TYPE ndoc-medok,                            " ID 10488
         meddok TYPE ish_on_off,                            " ID 10488
         labdok TYPE ish_on_off,                            " ID 10488
       END OF ty_dok.

* type for icon-document information
TYPES: BEGIN OF ty_n2flag.
        INCLUDE STRUCTURE tn2flag.
TYPES:   falnr   LIKE ndoc-falnr.
TYPES: END OF ty_n2flag.

* type for patient transport order information
TYPES: BEGIN OF ty_fat,
         fatid LIKE n1fat-fatid,
         einri LIKE n1fat-einri,
         patnr LIKE n1fat-patnr,
         fstid LIKE n1fat-fstid,
         fstat TYPE n1fsted,
         orgag LIKE n1fat-orgag,
         bauag LIKE n1fat-bauag,
         datag LIKE n1fat-datag,
         uztag LIKE n1fat-uztag,
         orgzl LIKE n1fat-orgzl,
         bauzl LIKE n1fat-bauzl,
         datzl LIKE n1fat-datzl,
         uztzl LIKE n1fat-uztzl,
         tpae  LIKE n1fat-tpae,
         tptyp LIKE n1fat-tptyp,                            " ID 7101
         fhrid LIKE n1fat-fhrid,
         papid LIKE n1fat-papid,
         fname TYPE n1fname,
         trans TYPE n1fat-trans,
         trava TYPE n1fat-trava,
       END OF ty_fat.

* type for patient information
TYPES: BEGIN OF ty_pat,
         patnr LIKE npat-patnr,
         einri LIKE tn01-einri,
       END OF ty_pat.

* type for provisional patient information
TYPES: BEGIN OF ty_pap,
         papid LIKE npap-papid,
       END OF ty_pap.

* type for order (for patient) information
TYPES: BEGIN OF ty_cord,
         patnr LIKE n1corder-patnr,
       END OF ty_cord.

* type for case information
TYPES: BEGIN OF ty_fal,
         falnr LIKE nfal-falnr,
         einri LIKE tn01-einri,
         falar LIKE nfal-falar,
       END OF ty_fal.

* KG, MED-43708 - Begin
* type for orders of patients
TYPES: BEGIN OF ty_patorder,
        patnr     TYPE patnr,
        t_meordid TYPE ishmed_t_meordid,
       END OF ty_patorder.
* KG, MED-43708 - End

* ---------------------------------------------------------------------
* global tables
* ---------------------------------------------------------------------

* global table for diagnosis information
DATA: gt_ndia     LIKE SORTED TABLE OF ndia       WITH NON-UNIQUE KEY
                                                  falnr.

* global table for diagnosis catalog information
DATA: gt_nkdi     TYPE SORTED TABLE OF ty_nkdi    WITH NON-UNIQUE KEY
                                                  spras dkat dkey.

* global table for movement information
DATA: gt_nbew     LIKE SORTED TABLE OF nbew       WITH NON-UNIQUE KEY
                                                  einri falnr lfdnr.

* global table for request information
DATA: gt_anf      TYPE SORTED TABLE OF ty_pat     WITH NON-UNIQUE KEY
                                                  patnr.

* global table for clinical order information
DATA: gt_cord     TYPE SORTED TABLE OF ty_cord    WITH NON-UNIQUE KEY
                                                  patnr.

* global table for treating doctor information
DATA: gt_nfpz     TYPE SORTED TABLE OF ty_nfpz    WITH NON-UNIQUE KEY
                                                  einri falnr.

* global table for treating doctor name information
DATA: gt_ngpa     TYPE SORTED TABLE OF ty_ngpa    WITH NON-UNIQUE KEY
                                                  gpart.

* global table for medical record information
DATA: gt_ka       TYPE SORTED TABLE OF ty_ka      WITH NON-UNIQUE KEY
                                                  patnr.

* global table for nursing service information
DATA: gt_pfl_nlem TYPE SORTED TABLE OF ty_pfl_nlem
                                                  WITH NON-UNIQUE KEY
                                                  falnr.

DATA: gt_pfl_n1srv TYPE TABLE OF ty_pfl_n1srv
                                                  WITH NON-UNIQUE KEY
                                                  patnr.

* global table for nursing service information (MED-29612)
DATA: gt_pfll_nlem TYPE SORTED TABLE OF ty_pfl_nlem
                                                  WITH NON-UNIQUE KEY
                                                  falnr.

* global table for document information
DATA: gt_dok      TYPE SORTED TABLE OF ty_dok     WITH NON-UNIQUE KEY
                                                  falnr.

* global table for icon-document information
DATA: gt_n2flag   TYPE SORTED TABLE OF ty_n2flag  WITH NON-UNIQUE KEY
                                                  falnr.

* global table for nursing anchor service information
DATA: gt_pflp_nlei TYPE STANDARD TABLE OF nlei.

DATA: gt_pflp_n1nrsph TYPE STANDARD TABLE OF n1nrsph.

DATA: gt_pflp_eval TYPE STANDARD TABLE OF n1nrsph,          "MED-33285
      gt_eval TYPE STANDARD TABLE OF n1nrspee.              "MED-33285

DATA: BEGIN OF gs_eval_pat,
        patnr   TYPE patnr,
        eval_wa TYPE n1nrspee,
      END OF gs_eval_pat.

DATA: gt_eval_pat LIKE TABLE OF gs_eval_pat.

* globale tables for patient transport orders
DATA: gt_n1fst    LIKE SORTED TABLE OF n1fst      WITH NON-UNIQUE KEY
                                                  fstid.
DATA: gt_n1fat    TYPE STANDARD TABLE OF ty_fat.

* global table for patient information
DATA: gt_pat      TYPE SORTED TABLE OF ty_pat     WITH NON-UNIQUE KEY
                                                  patnr.

* global table for provisional patient information
DATA: gt_pap      TYPE SORTED TABLE OF ty_pap     WITH NON-UNIQUE KEY
                                                  papid.

* global table for case information
DATA: gt_fal      TYPE SORTED TABLE OF ty_fal     WITH NON-UNIQUE KEY
                                                  falnr.
* KG, MED-43708 - Begin
* global table for medication orders of a patient
DATA: gt_patorder TYPE HASHED TABLE OF ty_patorder WITH UNIQUE KEY patnr.
* KG, MED-43708 - End

* ---------------------------------------------------------------------
* global range tables
* ---------------------------------------------------------------------

* global ranges for selection criterias
RANGES: gr_treat_ou  FOR nbew-orgpf,
        gr_dept_ou   FOR nbew-orgfa,
        gr_room      FOR nbew-zimmr.                        "#EC NEEDED


* ---------------------------------------------------------------------
* global data definition
* ---------------------------------------------------------------------

* Globales Feld, welches angibt, ob der Wert im Diagnosefeld aus dem
* User-Exit oder vom Standard ermittelt wird
* Gesetzt wird dieses Kennzeichen über einen Button (Diag+/-) in der
* Stationsliste
* ON = User-Exit-Wert der Diagnose
* OFF = Standard-Wert der Diagnose
DATA: g_diagdisp             LIKE off.

* global data for selection criterias
DATA: g_institution          LIKE nbew-einri,
      g_key_date             LIKE nbew-bwidt,
      g_key_time             LIKE nbew-bwizt,
      g_key_time_sel         LIKE nbew-bwizt,               "MED-29612
      g_planning_period      TYPE ish_planh,
      g_history_period       TYPE ish_histh.

* ID 7248: counter to get info about how often the view has been called
DATA: g_call_counter         TYPE i.

* ID 8690: save last called viewid
DATA: g_call_viewid_last     TYPE nwview-viewid.

* Pflegeankerleistung
DATA: g_n1pflank             LIKE nlei-leist.

DATA: g_check_ppd            TYPE abap_bool.         "PflegeProzesDoku

* Icons to be displayed
DATA: g_ka_icon              LIKE nwicons-icon,
      g_pfl_icon             LIKE nwicons-icon,
      g_pfl_icon_r           LIKE nwicons-icon,            "MED-54909
      g_pfl_icon_g           LIKE nwicons-icon,            "MED-54909
      g_pflp_icon_f          LIKE nwicons-icon,
      g_pflp_icon_nf         LIKE nwicons-icon,
      g_pflp_icon_de         LIKE nwicons-icon,       " Blaha ID 6916
      g_pflp_icon_229        LIKE nwicons-icon,
      g_pflp_icon_230        LIKE nwicons-icon,
      g_pfll_icon_l          LIKE nwicons-icon,             "MED-29612
      g_pfll_icon_g          LIKE nwicons-icon,             "MED-29612
      g_pfll_icon_r          LIKE nwicons-icon,             "MED-29612
      g_eval_icon_k          LIKE nwicons-icon,             "MED-33285
      g_eval_icon_o          LIKE nwicons-icon,             "MED-33285
      g_eval_icon_f          LIKE nwicons-icon,             "MED-33285
      g_dok_icon             LIKE nwicons-icon,
      g_meddok_icon          LIKE nwicons-icon,             " ID 10488
      g_labdok_icon          LIKE nwicons-icon,             " ID 10488
      g_anf_icon             LIKE nwicons-icon,
      g_trava_icon           LIKE nwicons-icon,
      g_batmp_icon           LIKE nwicons-icon,
      g_chdver_icon          like nwicons-icon.             "KG, MED-43708

*-----------------------------------------------------------------------
* Datendefinitionen für FBS 'ISHMED_POPUP_NBEW_KZTXT'
*-----------------------------------------------------------------------
DATA: g_titel(40)    TYPE c,                  " Titel des Popups
      g_pvcode       LIKE tndym-vcode,        " Verarbeitungscode
      g_pop_ok_code  LIKE ok-code.            " OK-Code im Popup
*-----------------------------------------------------------------------

* Asynchroner Aufruf Formuardruck (Langsteiner ID 6964 22.02.01)
DATA: end_of_print_task  LIKE false    VALUE false,         "#EC NEEDED
      subrc_print_task   LIKE sy-subrc VALUE 0,             "#EC NEEDED
      msg_print_task(80) TYPE c        VALUE space.         "#EC NEEDED

*
