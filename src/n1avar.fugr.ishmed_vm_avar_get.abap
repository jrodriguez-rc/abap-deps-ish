FUNCTION ishmed_vm_avar_get.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_VIEWTYPE) TYPE  NWVIEW-VIEWTYPE
*"     REFERENCE(I_AVARIANTID) TYPE  RNAVAR-AVARIANTID OPTIONAL
*"     REFERENCE(I_USER_SPECIFIC) TYPE  ISH_ON_OFF DEFAULT OFF
*"  EXPORTING
*"     REFERENCE(E_RC) TYPE  SY-SUBRC
*"  TABLES
*"      ET_AVAR TYPE  ISH_T_AVAR OPTIONAL
*"      ET_DISVARIANT TYPE  ISH_T_DISVARIANT OPTIONAL
*"----------------------------------------------------------------------

  DATA: lt_variants        TYPE TABLE OF ltvariant,
        ls_variant         LIKE LINE OF lt_variants,
        ls_dispvar         TYPE disvariant,
        ls_avar            LIKE LINE OF et_avar,
        ls_disvariant      LIKE LINE OF et_disvariant,
        l_report           TYPE rnviewvar-reporta.

* initialization
  CLEAR:   e_rc, ls_dispvar, l_report.

  REFRESH: et_avar, et_disvariant, lt_variants.

* get reportname for layout
  PERFORM get_report_anzvar(sapln1workplace) USING    i_viewtype
                                             CHANGING l_report.
  ls_dispvar-report  = l_report.
  ls_dispvar-variant = i_avariantid.

* Michael Manoch, 15.04.2009, MED-33282   START
* Set field handle for nursing plan hierarchy.
  CASE i_viewtype.
    WHEN 'C07' OR 'C08' OR 'C09'.
      ls_dispvar-handle = 'TREE'.
*   KG, MED-40981 - Begin
*   set field handle for medication event administration
    WHEN 'C10'.
      ls_dispvar-handle = 'GRID'.
*   KG, MED-40981 - End
  ENDCASE.
* Michael Manoch, 15.04.2009, MED-33282   END

* read layout(s)
  PERFORM variants_read TABLES   lt_variants
                        USING    ls_dispvar
                                 i_user_specific
                        CHANGING e_rc.

  CHECK e_rc = 0.
  CHECK NOT lt_variants[] IS INITIAL.

* return layout(s)
  LOOP AT lt_variants INTO ls_variant.
    CLEAR: ls_avar, ls_disvariant.
    IF et_avar IS REQUESTED.
      ls_avar-reporta    = ls_variant-report.
      ls_avar-handle     = ls_variant-handle.
      ls_avar-log_group  = ls_variant-log_group.
      ls_avar-username   = ls_variant-username.
      ls_avar-avariantid = ls_variant-variant.
      ls_avar-type       = ls_variant-type.
      APPEND ls_avar TO et_avar.
    ENDIF.
    IF et_disvariant IS REQUESTED.
      ls_disvariant-report     = ls_variant-report.
      ls_disvariant-handle     = ls_variant-handle.
      ls_disvariant-log_group  = ls_variant-log_group.
      ls_disvariant-username   = ls_variant-username.
      ls_disvariant-variant    = ls_variant-variant.
      ls_disvariant-text       = ls_variant-text.
      ls_disvariant-dependvars = ls_variant-dependvars.
      APPEND ls_disvariant TO et_disvariant.
    ENDIF.
  ENDLOOP.

ENDFUNCTION.
