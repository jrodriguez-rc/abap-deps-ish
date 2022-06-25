FUNCTION-POOL n1_wp_010  MESSAGE-ID nf1.

INCLUDE: mndata00.
INCLUDE <icon>.
INCLUDE: mn1define.


* global variables
DATA: g_institution          TYPE tn01-einri.

* type for patient information
TYPES: BEGIN OF ty_pat,
         patnr TYPE npat-patnr,
         einri TYPE tn01-einri,
       END OF ty_pat.

* type for provisional patient information
TYPES: BEGIN OF ty_pap,                                     "MED-34000
         papid TYPE npap-papid,                             "MED-34000
         einri TYPE tn01-einri,                             "MED-34000
       END OF ty_pap.                                       "MED-34000

* type for case information
TYPES: BEGIN OF ty_fal,
         falnr TYPE nfal-falnr,
         einri TYPE tn01-einri,
         falar TYPE nfal-falar,
         vkgid TYPE n1vkg-vkgid,
       END OF ty_fal.

* type for preregistration information
TYPES: BEGIN OF ty_vkg,
         vkgid  TYPE n1vkg-vkgid,
         apcnid TYPE n1vkg-apcnid,
         objnr  TYPE n1vkg-objnr,
         trtgp  TYPE n1vkg-trtgp,
       END OF ty_vkg.

* type for document information
TYPES: BEGIN OF ty_dok,
         patnr  TYPE npat-patnr,
         medok  TYPE ndoc-medok,                            " ID 10488
         meddok TYPE ish_on_off,                            " ID 10488
         labdok TYPE ish_on_off,                            " ID 10488
       END OF ty_dok.

* type for requests information
TYPES: BEGIN OF ty_anf,
         patnr TYPE npat-patnr,
       END OF ty_anf.

* type for order (for patient) information
TYPES: BEGIN OF ty_cord_pat,                                "MED-34000
         patnr LIKE n1corder-patnr,                         "MED-34000
       END OF ty_cord_pat.                                  "MED-34000

* type for order (for provisional patient) information
TYPES: BEGIN OF ty_cord_pap,                                "MED-34000
         papid LIKE n1corder-papid,                         "MED-34000
       END OF ty_cord_pap.                                  "MED-34000

* type for appointment information
TYPES: BEGIN OF ty_tmn,
         apcnid TYPE ntmn-apcnid,
         tmnid  TYPE ntmn-tmnid,
         falnr  TYPE ntmn-falnr,
         tmnlb  TYPE ntmn-tmnlb,
         tmnoe  TYPE ntmn-tmnoe,  "MED-54431 Cristina Geanta 05.03.2014
       END OF ty_tmn.

* type for service information
TYPES: BEGIN OF ty_lei,
         lnrls TYPE nlei-lnrls,
         leist TYPE nlei-leist,
         haust TYPE nlei-haust,
         storn TYPE nlei-storn,                             " ID 11580
         einri TYPE nlei-einri,                             " ID 10562
         leitx TYPE nlei-leitx,                             " ID 10562
       END OF ty_lei.

TYPES: BEGIN OF ty_ntpt,                                    " ID 10562
         spras TYPE ntpt-spras,
         einri TYPE ntpt-einri,
         tarif TYPE ntpt-tarif,
         talst TYPE ntpt-talst,
         ktxt1 TYPE ntpt-ktxt1,
       END OF ty_ntpt.

* type for medical service information
TYPES: BEGIN OF ty_lem,
         vkgid     TYPE nlem-vkgid,
         lnrls     TYPE nlem-lnrls,
         sortleist TYPE nlem-sortleist,
         tmnid     TYPE nlem-tmnid,
         lslok     TYPE nlem-lslok,
       END OF ty_lem.

* type for movement information
TYPES: BEGIN OF ty_bew,
         einri TYPE nbew-einri,
         falnr TYPE nbew-falnr,
         lfdnr TYPE nbew-lfdnr,
         bewty TYPE nbew-bewty,
         orgpf TYPE nbew-orgpf,
         orgfa TYPE nbew-orgfa,
         storn TYPE nbew-storn,
         planb TYPE nbew-planb,
         bwidt TYPE nbew-bwidt,
         bwizt TYPE nbew-bwizt,
       END OF ty_bew.

* type for risk information                                   ID 11887
TYPES: BEGIN OF ty_nrsf,
         patnr TYPE nrsf-patnr,
       END OF ty_nrsf.

* global table for patient information
DATA: gt_pat                 TYPE SORTED TABLE OF ty_pat
                                  WITH NON-UNIQUE KEY patnr.
* global table for provisional patient information
DATA: gt_pap                 TYPE SORTED TABLE OF ty_pap
                                  WITH NON-UNIQUE KEY papid. "MED-34000
* global table for case information
DATA: gt_fal                 TYPE SORTED TABLE OF ty_fal
                                  WITH NON-UNIQUE KEY falnr.
* global table for request information
DATA: gt_anf                 TYPE SORTED TABLE OF ty_anf
                                  WITH NON-UNIQUE KEY patnr.
* global tables for clinical order informations
DATA: gt_cord_pat            TYPE SORTED TABLE OF ty_cord_pat
                                  WITH NON-UNIQUE KEY patnr. "MED-34000
DATA: gt_cord_pap            TYPE SORTED TABLE OF ty_cord_pap
                                  WITH NON-UNIQUE KEY papid. "MED-34000
* global table for document information
DATA: gt_dok                 TYPE SORTED TABLE OF ty_dok
                                  WITH NON-UNIQUE KEY patnr.
* global table for preregistration information
DATA: gt_vkg                 TYPE SORTED TABLE OF ty_vkg
                                  WITH NON-UNIQUE KEY vkgid.
* global table for service information
DATA: gt_lem                 TYPE SORTED TABLE OF ty_lem
                                  WITH NON-UNIQUE KEY
                                  vkgid sortleist lnrls,
      gt_lei                 TYPE SORTED TABLE OF ty_lei
                                  WITH NON-UNIQUE KEY lnrls.
* global table for appointment information
DATA: gt_tmn                 TYPE SORTED TABLE OF ty_tmn
                                  WITH NON-UNIQUE KEY apcnid.
* global table for movement information
DATA: gt_bew                 TYPE SORTED TABLE OF ty_bew
                                  WITH NON-UNIQUE KEY einri falnr lfdnr.
* global table for risk information                           ID 11887
DATA: gt_nrsf                TYPE SORTED TABLE OF ty_nrsf
                                  WITH NON-UNIQUE KEY patnr.

* global table for order position data (MED-34502)
DATA: gt_n1compa             TYPE STANDARD TABLE OF n1compa.

* Icons to be displayed
DATA: g_dok_icon             TYPE nwicons-icon,
      g_anf_icon             TYPE nwicons-icon,
      g_risk_icon            TYPE nwicons-icon,             " ID 11887
      g_meddok_icon          TYPE nwicons-icon,             " ID 10488
      g_labdok_icon          TYPE nwicons-icon.             " ID 10488


* ###########################################################
* Definitions for Functions
* ###########################################################

TYPES:  BEGIN OF ty_marked,
          einri     TYPE tn01-einri,
          patnr     TYPE npat-patnr,
          falnr     TYPE nfal-falnr,
          tmnid     TYPE ntmn-tmnid,
          vkgid     TYPE n1vkg-vkgid,
          papid     TYPE n1vkg-papid,
        END OF ty_marked,
       tyt_marked  TYPE STANDARD TABLE OF ty_marked.

*
