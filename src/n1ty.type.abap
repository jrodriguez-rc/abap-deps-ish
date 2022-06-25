TYPE-POOL n1ty .

TYPES:
* Typen für BADI´s
* Erweiterung Funktionen des Sichttyp Klinische Aufträge
* im Klinischen Arbeitsplatz übersteuern
  BEGIN OF n1ty_marked,
    einri      TYPE tn01-einri,
    patnr      TYPE npat-patnr,
    papid      TYPE npap-papid,
    falnr      TYPE nfal-falnr,
    corderid   TYPE n1corder-corderid,
    vkgid      TYPE n1vkg-vkgid,
    anfid      TYPE n1anf-anfid,
    lnrls      TYPE nlei-lnrls,
    txttyp     TYPE c,
    node_key   TYPE lvc_nkey,
  END OF n1ty_marked,

  n1ty_tmarked TYPE STANDARD TABLE OF n1ty_marked.
