class CL_ISH_WRP_REQUEST_CORDER definition
  public
  create protected .

*"* public components of class CL_ISH_WRP_REQUEST_CORDER
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .

  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .

  class-methods GET_N1ANF_BY_ANFID
    importing
      value(I_EINRI) type EINRI
      value(I_ANFID) type ANFID
    exporting
      value(ES_N1ANF) type N1ANF
      value(E_IS_CORDER) type ISH_ON_OFF
      value(E_VKGID) type N1VKGID .
  class-methods GET_ANFID_FROM_NLEM
    importing
      value(I_EINRI) type EINRI
      value(I_LNRLS) type NLEM-LNRLS
    exporting
      value(E_ANFID) type ANFID
      value(E_IS_CORDER) type ISH_ON_OFF .
protected section.
*"* protected components of class CL_ISH_WRP_REQUEST_CORDER
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_WRP_REQUEST_CORDER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_WRP_REQUEST_CORDER IMPLEMENTATION.


METHOD get_anfid_from_nlem .

  DATA: l_anfid       TYPE n1anf-anfid,
        l_anfid_cord  TYPE n1anf-anfid.

* Initializations.
  CLEAR: e_anfid,
         l_anfid,
         l_anfid_cord.
  e_is_corder = off.

** Testwerte
*  i_lnrls = '0000167781'. "klau
*  i_lnrls = '0000003033'. "anf

  SELECT a~anfid b~reqcompid
    INTO (l_anfid, l_anfid_cord)
    FROM ( nlem AS a
           LEFT OUTER JOIN n1vkg AS b
           ON b~vkgid = a~vkgid )
    WHERE a~lnrls = i_lnrls
      AND a~einri = i_einri.

    IF NOT l_anfid IS INITIAL.
      e_anfid   = l_anfid.
      EXIT.
    ENDIF.
    IF NOT l_anfid_cord IS INITIAL.
      e_anfid     = l_anfid_cord.
      e_is_corder = on.
      EXIT.
    ENDIF.
  ENDSELECT.

ENDMETHOD.


METHOD get_n1anf_by_anfid .

  DATA: ls_n1vkg     TYPE n1vkg,
        ls_n1cordtyp TYPE n1cordtyp,
        ls_n1corder  TYPE n1corder,
        ls_n1cpr     TYPE n1cpr,
        ls_n1ctr     TYPE n1ctr,
        l_extuid     TYPE n1extuid.

* Kurt Dudek, 22.09.2004, ID 15479   START
  DATA:  l_srcval    TYPE string,
         l_srclen    TYPE i,
         l_srcpos    TYPE i,
         l_tgtlen    TYPE i.
* Kurt Dudek, 22.09.2004, ID 15479   END

* Initializations.
  CLEAR: es_n1anf,
         e_vkgid.
  e_is_corder = off.

*-- Begin Grill, ID-16444
  CHECK NOT i_einri IS INITIAL.
  CHECK NOT i_anfid IS INITIAL.
*-- End Grill, ID-16444

* Get N1ANF from db-table N1ANF.
  SELECT SINGLE *
    FROM n1anf
    INTO es_n1anf
    WHERE einri = i_einri
      AND anfid = i_anfid.

* If i_anfid is in n1anf -> we are ready (N1ANF filled).
  CHECK NOT sy-subrc = 0.

* Get N1VKG.
  SELECT SINGLE *
    FROM n1vkg
    INTO ls_n1vkg
    WHERE reqcompid = i_anfid.

* If not found in N1VKG -> we are ready (empty N1ANF).
  CHECK sy-subrc = 0.

* Handle e_is_corder, e_vkgid.
  e_is_corder = on.
  e_vkgid     = ls_n1vkg-vkgid.

* Get N1CORDTYP.
  SELECT SINGLE *
    FROM n1cordtyp
    INTO ls_n1cordtyp
    WHERE cordtypid = ls_n1vkg-cordtypid.
  IF sy-subrc <> 0.
    CLEAR ls_n1cordtyp.
  ENDIF.

* Get N1CORDER.
  SELECT SINGLE *
    FROM n1corder
    INTO ls_n1corder
    WHERE corderid = ls_n1vkg-corderid.
  IF sy-subrc <> 0.
    CLEAR ls_n1corder.
  ENDIF.

*-- Begin Grill, ID-16444
  CHECK NOT ls_n1vkg-corderid IS INITIAL.
*-- End Grill, ID-16444

* Get N1CPR (Radiology).
  SELECT SINGLE extuid
    FROM n1compa
    INTO l_extuid
    WHERE compid = 'SAP_RADIOLOGY'
      AND vkgid  = ls_n1vkg-vkgid.
  IF sy-subrc = 0.
    SELECT SINGLE *
      FROM n1cpr
      INTO ls_n1cpr
      WHERE cprid = l_extuid.
    IF sy-subrc <> 0.
      CLEAR ls_n1cpr.
    ENDIF.
  ENDIF.

* Get N1CTR (Transport Oder).
  SELECT SINGLE extuid
    FROM n1compa
    INTO l_extuid
    WHERE compid = 'SAP_TRANS_ORDER'
      AND vkgid  = ls_n1vkg-vkgid.
  IF sy-subrc = 0.
    SELECT SINGLE *
      FROM n1ctr
      INTO ls_n1ctr
      WHERE ctrid = l_extuid.
    IF sy-subrc <> 0.
      CLEAR ls_n1ctr.
    ENDIF.
  ENDIF.

* Map N1VKG to N1ANF.
  es_n1anf-mandt        = ls_n1vkg-mandt.
  es_n1anf-einri        = ls_n1vkg-einri.
  es_n1anf-anfid        = ls_n1vkg-reqcompid.
  es_n1anf-orgid        = ls_n1vkg-orgid.
  es_n1anf-anfoe        = ls_n1corder-orddep.
  es_n1anf-anpoe        = ls_n1corder-etroe.
  es_n1anf-anfty        = ls_n1cordtyp-reqcomp.
  es_n1anf-anfnr        = ls_n1vkg-reqcompnr.
  es_n1anf-falnr        = ls_n1vkg-falnr.
  es_n1anf-anstae       = 'XXX'.
  es_n1anf-apri         = ls_n1corder-ordpri.
  es_n1anf-kanam        = ls_n1corder-kanam.
  es_n1anf-kaltx        = ls_n1corder-kaltx.
*  es_n1anf-faldia       =
*  es_n1anf-lfddia       =
  es_n1anf-frage        = ls_n1corder-frage.
  es_n1anf-frltx        = ls_n1corder-frltx.
  es_n1anf-schwkz       = ls_n1corder-schwkz.
  es_n1anf-schwo        = ls_n1corder-schwo.
*  es_n1anf-lfdmehr      =
  es_n1anf-tpae         = ls_n1vkg-tpae.

* Kurt Dudek, 22.09.2004, ID 15479   START
* store last signs with preceeding '..' if value exceeds target.
*  es_n1anf-rckruf       = ls_n1corder-rckruf.
  l_srcval = ls_n1corder-rckruf.
  CONDENSE l_srcval.
  l_srclen = STRLEN( l_srcval ).
  DESCRIBE FIELD es_n1anf-rckruf LENGTH l_tgtlen IN CHARACTER MODE.

  IF l_srclen <= l_tgtlen.
    es_n1anf-rckruf = l_srcval.
  ELSE.
    l_srcpos = l_srclen - l_tgtlen + 2.
    CONCATENATE '..' l_srcval+l_srcpos(*) INTO es_n1anf-rckruf.
  ENDIF.
* Kurt Dudek, 22.09.2004, ID 15479   END

*  es_n1anf-dokar        =
*  es_n1anf-doknr        =
*  es_n1anf-dokvr        =
*  es_n1anf-doktl        =
  es_n1anf-erdat        = ls_n1vkg-erdat.
  es_n1anf-erusr        = ls_n1vkg-erusr.
  es_n1anf-updat        = ls_n1vkg-updat.
  es_n1anf-upusr        = ls_n1vkg-upusr.
  es_n1anf-storn        = ls_n1vkg-storn.
  es_n1anf-stusr        = ls_n1vkg-stusr.
  es_n1anf-stdat        = ls_n1vkg-stdat.
  es_n1anf-bhanf        = ls_n1corder-rmcord.
  es_n1anf-bhatx        = ls_n1corder-rmltx.
  es_n1anf-patnr        = ls_n1corder-patnr.
*  es_n1anf-ditxt        = not in n1vkg or n1corder, but in ndip
*  es_n1anf-diltx        = not in n1vkg or n1corder, but in ndip
*  es_n1anf-vbund        =
  es_n1anf-mi           = ls_n1cpr-mi.
  es_n1anf-sm           = ls_n1cpr-sm.
  es_n1anf-km           = ls_n1cpr-km.
  es_n1anf-jod          = ls_n1cpr-jod.
  es_n1anf-andere       = ls_n1cpr-andere.
  es_n1anf-kgr          = ls_n1cpr-kgr.
  es_n1anf-kgew         = ls_n1cpr-kgew.
  es_n1anf-rp           = ls_n1cpr-rp.
  es_n1anf-rpid         = ls_n1cpr-rpid.
  es_n1anf-orgfd        = ls_n1ctr-orgfd.
  es_n1anf-papid        = ls_n1corder-papid.

ENDMETHOD.
ENDCLASS.
