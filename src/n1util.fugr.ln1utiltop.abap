FUNCTION-POOL n1util.                       "MESSAGE-ID ..

* ---------------------------------------------------------
* Interne Konstante für die Datentypen
*----------------------------------------------------------
CONSTANTS: co_ltype_appmnt       TYPE i VALUE 1,
           co_ltype_med_srv      TYPE i VALUE 2,
           co_ltype_prov_pat     TYPE i VALUE 3,
           co_ltype_anchor_srv   TYPE i VALUE 4,
           co_ltype_request      TYPE i VALUE 5,
           co_ltype_prereg       TYPE i VALUE 6,
           co_ltype_address      TYPE i VALUE 7,
           co_ltype_vitpar       TYPE i VALUE 8,
           co_ltype_team         TYPE i VALUE 9,
           co_ltype_context      TYPE i VALUE 10,
           co_ltype_prereg_proc  TYPE i VALUE 11,
           co_ltype_wl_absence   TYPE i VALUE 12,
           co_ltype_prov_ins_pol TYPE i VALUE 13,
           co_ltype_prereg_diag  TYPE i VALUE 14,
           co_ltype_nbew         TYPE i VALUE 15,
           co_ltype_ndia         TYPE i VALUE 16,
           co_ltype_n1fat        TYPE i VALUE 17,
           co_ltype_ndoc         TYPE i VALUE 18,
           co_ltype_nmatv        TYPE i VALUE 19,
           co_ltype_n2zeiten     TYPE i VALUE 20,
           co_ltype_n2ok         TYPE i VALUE 21,
           co_ltype_ish_srv      TYPE i VALUE 22,
           co_ltype_nicp         TYPE i VALUE 23,
           co_ltype_cyclus       TYPE i VALUE 24,
           co_ltype_nfal         TYPE i VALUE 25,
           co_ltype_corder       TYPE i VALUE 26,
           co_ltype_me_order     TYPE i VALUE 27,
           co_ltype_me_event     TYPE i VALUE 28,
           co_ltype_me_edrug     TYPE i VALUE 29,
           co_ltype_me_odrug     TYPE i VALUE 30,
           co_ltype_me_orate     TYPE i VALUE 31,
           co_ltype_cycle        TYPE i VALUE 32,
           co_ltype_cycledef     TYPE i VALUE 33,
*          medical document
           co_ltype_meddoc       TYPE i VALUE 34,
*          complications of surgery
           co_ltype_medsurco     TYPE i VALUE 35,
*          times of surgery
           co_ltype_medsurti     TYPE i VALUE 36,
*          relations of surgery
           co_ltype_medsurre     TYPE i VALUE 37,
*          relation of service to pocedure
           co_ltype_mednlicz     TYPE i VALUE 38,
*          anchordata of surgery
           co_ltype_medsuran     TYPE i VALUE 39,
*          indication of meorder
           co_ltype_me_meorderthcla TYPE i VALUE 40,
*          Hoebarth MED-33288 services (N1SRV)
           co_ltype_srv_service     TYPE i VALUE 41,
*          Siegl MED-34863, Cycle Service Template
           co_ltype_cysrvtpl        TYPE i VALUE 42.


INCLUDE mndata00.
INCLUDE <icon>.
INCLUDE mndata_casrev.

DATA:      gt_norg               TYPE STANDARD TABLE OF norg.

CONTEXTS:  free_sel_dd_info.

*
