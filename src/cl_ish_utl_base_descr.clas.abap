class CL_ISH_UTL_BASE_DESCR definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_UTL_BASE_DESCR
*"* do not include other source files here!!!
  type-pools ABAP .

  interfaces IF_ISH_CONSTANT_DEFINITION .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .

  class-methods GET_DESCR_BEKAT
    importing
      value(I_EINRI) type TN01-EINRI default SPACE
      value(I_SPRAS) type SY-LANGU default SY-LANGU
      value(I_BEKAT) type BEKAT
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_BKTXT) type BK_BKTXT
      value(E_TN24T) type TN24T
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DESCR_BEWTY
    importing
      value(I_EINRI) type EINRI
      value(I_BEWTY) type BEWTY
    exporting
      value(E_BEWTX) type TN14T-BEWTX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DESCR_BWART
    importing
      value(I_EINRI) type EINRI
      value(I_BEWTY) type BEWTY
      value(I_BWART) type RI_BWART
    exporting
      value(E_BWATX) type TN14U-BWATX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DESCR_KHANS
    importing
      value(I_GPART) type GPARTNER
    exporting
      value(E_KHANS) type TEXT50
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DESCR_MVMT
    importing
      !IR_MOVEMENT type ref to CL_ISHMED_MOVEMENT
      !IS_NBEW type NBEW optional
    exporting
      !E_BWART type BEWARTXT
      !E_BWIDTZT type STRING
      !E_ORGPF type STRING
      !E_FULL_TEXT type STRING
      !E_LEN_BWART type STRING
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DESCR_ORGUNIT
    importing
      value(I_EINRI) type TN01-EINRI default SPACE
      value(I_ORGID) type NORG-ORGID
    exporting
      value(E_ORGKB) type NORG-ORGKB
      value(E_OKURZ) type NORG-OKURZ
      value(E_ORGNA) type NORG-ORGNA
      value(E_NORG) type NORG
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DESCR_ROOM
    importing
      value(I_BAUID) type NBAU-BAUID
    exporting
      value(E_BAUKB) type NBAU-BAUKB
      value(E_BKURZ) type NBAU-BKURZ
      value(E_NBAU) type NBAU
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DESCR_ORGUNIT_TABLE
    importing
      value(I_EINRI) type TN01-EINRI default SPACE
      !IT_ORGID type STANDARD TABLE
    exporting
      !ET_NORG type ISH_T_NORG
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_UTL_BASE_DESCR
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_BASE_DESCR
*"* do not include other source files here!!!

  class-methods CHECK_NORG_BPOM_BUFFER
    importing
      !I_EINRI type TN01-EINRI default SPACE
      !IT_ORGID type STANDARD TABLE
    exporting
      !ET_NORG type ISH_T_NORG
      !E_RC type ISH_METHOD_RC .
ENDCLASS.



CLASS CL_ISH_UTL_BASE_DESCR IMPLEMENTATION.


METHOD check_norg_bpom_buffer .
**********************************************************************
** MED-60495 (Ki, Bi)                                               **
** Due to escalating performance issues with OM access the solution **
** of note 2197189 has been extended.                               **
** If only description (ORGKB) is needed for a ORGID the table      **
** NORG_BPOM_BUFFER is used for access (bypass OM)                  **
**********************************************************************
* types
  TYPES: BEGIN OF ty_orgid,
           orgid    TYPE orgid,
           einri    TYPE einri,
           headline TYPE n1headline,
         END OF ty_orgid.


  DATA: l_count_orgids      TYPE i,
        l_count_results     TYPE i,
        l_count_difference  TYPE i,
        lt_norg_bpom_buffer TYPE ishmed_t_norg_bpom_buffer,
        lt_orgid            TYPE ish_t_orgid.
  FIELD-SYMBOLS: <fs_norg>             TYPE norg,
                 <fs_norg_bpom_buffer> TYPE norg_bpom_buffer,
                 <fs_orgid>            TYPE ty_orgid,
                 <fs_component_orgid>  TYPE orgid,
                 <fs_lt_orgid>         LIKE LINE OF lt_orgid.
* ---------- ---------- ----------
* try to get
  CLEAR: e_rc, et_norg, lt_norg_bpom_buffer,
         l_count_orgids, l_count_results  .

  LOOP AT it_orgid ASSIGNING <fs_orgid>.
    TRY.
        ASSIGN COMPONENT 'ORGID' OF STRUCTURE <fs_orgid> TO <fs_component_orgid>.
        APPEND INITIAL LINE TO lt_orgid ASSIGNING <fs_lt_orgid>.
        <fs_lt_orgid> = <fs_component_orgid>.
    ENDTRY.
  ENDLOOP.

  IF it_orgid IS NOT INITIAL.
    SELECT * FROM  norg_bpom_buffer
           INTO TABLE lt_norg_bpom_buffer
           FOR ALL ENTRIES IN lt_orgid
           WHERE      einri  = i_einri
                 AND  orgid  = lt_orgid-table_line.


    IF sy-subrc <> 0.
      e_rc = sy-subrc.
    ELSE.    "check if there are for all orgids entries in table found
      DESCRIBE TABLE it_orgid LINES l_count_orgids.
      DESCRIBE TABLE lt_norg_bpom_buffer LINES l_count_results.
      l_count_difference = l_count_orgids - l_count_results.
*     IF l_count_orgids = l_count_results.
      IF l_count_difference <= 5.
        e_rc = 0.
      ELSE.     "for more than 5 orgids there was no entry in table norg_bpom_buffer
                "Run of report RN1_FILL_NORG_BPOM_BUFFER might be necessary
        e_rc = 5.
      ENDIF.
    ENDIF.

    IF e_rc = 0.
      LOOP AT lt_norg_bpom_buffer ASSIGNING <fs_norg_bpom_buffer>.
        APPEND INITIAL LINE TO et_norg ASSIGNING <fs_norg>.
        MOVE-CORRESPONDING <fs_norg_bpom_buffer> TO <fs_norg>.
      ENDLOOP.
    ELSE.
      CLEAR et_norg.
    ENDIF.

  ELSE.   "it_orgid was empty
    e_rc = 6.
    CLEAR et_norg.
  ENDIF.

ENDMETHOD.


METHOD GET_DESCR_BEKAT .

* definitions
  DATA: l_wa_tn24t TYPE tn24t,
        lt_tn24t TYPE TABLE OF tn24t.
* ---------- ---------- ----------
* initialize
  CLEAR: e_tn24t, e_bktxt, e_rc.
* ---------- ---------- ----------
  l_wa_tn24t-einri = i_einri.
  l_wa_tn24t-bekat = i_bekat.
  l_wa_tn24t-spras = i_spras.
  APPEND l_wa_tn24t TO lt_tn24t.
* read the text from the dp
  CALL FUNCTION 'ISHMED_DP_TN24T'
    TABLES
      ct_tn24t = lt_tn24t.
  CLEAR l_wa_tn24t.
  READ TABLE lt_tn24t INDEX 1 INTO l_wa_tn24t.
  IF sy-subrc EQ 0.
    e_bktxt = l_wa_tn24t-bktxt.
*   if there is no text use the bekat of its own
    IF e_bktxt = space.
      e_bktxt = i_bekat.
    ENDIF.
  ELSE.
    e_rc = sy-subrc.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD GET_DESCR_BEWTY .
* definitions
  DATA: l_rc                    TYPE ish_method_rc.
* ---------- ---------- ----------
* initialize
  CLEAR: e_bewtx.
* ---------- ---------- ----------
* use IS-H function to get description for bewart
  CALL FUNCTION 'ISH_BEWTY_CHECK'
    EXPORTING
      ss_einri  = i_einri
      ss_bewty  = i_bewty
    IMPORTING
      ss_bewtx  = e_bewtx
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.
  IF sy-subrc = 0.
*   if there is no description use id
    IF e_bewtx IS INITIAL.
      e_bewtx = i_bewty.
    ENDIF.
  ELSE.
    e_rc = sy-subrc.
  ENDIF.
* ---------- ---------- ----------
ENDMETHOD.


METHOD GET_DESCR_BWART .

* definitions
  DATA: l_rc                    TYPE ish_method_rc.
* ---------- ---------- ----------
* initialize
  CLEAR: e_bwatx.
* ---------- ---------- ----------
* use IS-H function to get description for bewart
  CALL FUNCTION 'ISH_BWART_CHECK'
    EXPORTING
      ss_einri  = i_einri
      ss_bewty  = i_bewty
      ss_bwart  = i_bwart
    IMPORTING
      ss_bwatx  = e_bwatx
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.
  IF sy-subrc = 0.
*   if there is no description use id
    IF e_bwatx IS INITIAL.
      e_bwatx = i_bwart.
    ENDIF.
  ELSE.
    e_rc = sy-subrc.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_descr_khans .

* definitions
  DATA: l_ngpa   TYPE ngpa,
        l_nadr   TYPE nadr,
        l_arnam  TYPE arnam,
        l_aradr  TYPE aradr,
        l_pnamec TYPE ish_pnamec.
* ---------- ---------- ----------
* initialize
  CLEAR: e_khans, e_rc.

* read business partner
  CALL METHOD cl_ish_dbr_gpa=>get_gpa_by_gpart
    EXPORTING
      i_gpart         = i_gpart
    IMPORTING
      es_ngpa         = l_ngpa
      es_nadr         = l_nadr
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* ---------- ---------- ----------
* name
  CALL METHOD cl_ish_utl_base_gpa=>get_name_gpa
    EXPORTING
      i_gpart         = i_gpart
      is_ngpa         = l_ngpa
    IMPORTING
      e_pname         = l_pnamec
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF e_rc <> 0.
    EXIT.
  ELSE.
    l_arnam = l_pnamec.
  ENDIF.
* address
  CALL FUNCTION 'ISH_ADDRESS_CONCATENATE'
    EXPORTING
      ss_adrnr   = l_nadr-adrnr
      ss_adrob   = l_nadr-adrob
      ss_nadr    = l_nadr
    IMPORTING
      ss_address = l_aradr
    EXCEPTIONS
      OTHERS     = 1.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* name and address
  CONCATENATE l_arnam l_aradr INTO e_khans SEPARATED BY space.
* ---------- ---------- ----------

ENDMETHOD.


METHOD GET_DESCR_MVMT .
* Michael Manoch, 22.04.2010, MED-40626
*   Parameter ir_movement changed to optional.
*   New parameter is_nbew.

  DATA: ls_nbew        TYPE nbew,
        l_bwart        TYPE bewartxt,
        l_bwidtzt      TYPE string,
        l_bwizt        TYPE string,
        l_orgpf        TYPE string,
        l_full_text    TYPE string.

* Michael Manoch, 22.04.2010, MED-40626   START
** Initial checking.
*  CHECK ir_movement IS BOUND.
* Michael Manoch, 22.04.2010, MED-40626   END

* Initializations.
  e_rc = 0.
  CLEAR: e_bwart,
         e_bwidtzt,
         e_orgpf,
         e_full_text,
         e_len_bwart.

* Get movement data.
* Michael Manoch, 22.04.2010, MED-40626   START
  IF ir_movement IS BOUND.
* Michael Manoch, 22.04.2010, MED-40626   END
    CALL METHOD ir_movement->get_data
    IMPORTING
      e_rc           = e_rc
      e_nbew         = ls_nbew
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* Michael Manoch, 22.04.2010, MED-40626   START
  ELSE.
    CHECK is_nbew IS NOT INITIAL.
    ls_nbew = is_nbew.
  ENDIF.
* Michael Manoch, 22.04.2010, MED-40626   END

* Build bwart.
  CALL METHOD cl_ish_utl_base_descr=>get_descr_bwart
    EXPORTING
      i_einri         = ls_nbew-einri
      i_bewty         = ls_nbew-bewty
      i_bwart         = ls_nbew-bwart
    IMPORTING
      e_bwatx         = l_bwart
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Build bwidtzt.
  IF NOT ls_nbew-bwidt IS INITIAL.
    l_bwidtzt = cl_ish_utl_base_conv=>conv_date_to_extern( ls_nbew-bwidt ).
    IF NOT ls_nbew-bwizt IS INITIAL.
      l_bwizt = cl_ish_utl_base_conv=>conv_time_to_extern( ls_nbew-bwizt ).
      CONCATENATE l_bwidtzt
                  l_bwizt
             INTO l_bwidtzt
        SEPARATED BY space.
    ENDIF.
  ENDIF.

* Build orgpf.
  l_orgpf = ls_nbew-orgpf.

* Build the full text.
  l_full_text = l_bwart.
  IF NOT l_bwidtzt IS INITIAL.
    IF l_full_text IS INITIAL.
      l_full_text = l_bwidtzt.
    ELSE.
      CONCATENATE l_full_text
                  'am'(001)
                  l_bwidtzt
             INTO l_full_text
        SEPARATED BY space.
    ENDIF.
  ENDIF.
  IF NOT l_orgpf IS INITIAL.
    IF l_full_text IS INITIAL.
      l_full_text = l_orgpf.
    ELSE.
      CONCATENATE l_full_text
                  l_orgpf
             INTO l_full_text
        SEPARATED BY ', '.
    ENDIF.
  ENDIF.

* Export.
  e_bwart       = l_bwart.
  e_bwidtzt     = l_bwidtzt.
  e_orgpf       = l_orgpf.
  e_full_text   = l_full_text.
  e_len_bwart   = STRLEN( l_bwart ).

ENDMETHOD.


METHOD get_descr_orgunit .

* definitions
  DATA: l_rc                    TYPE ish_method_rc.
* ---------- ---------- ----------
* initialize
  CLEAR: e_rc, e_norg, e_orgkb, e_okurz.
* ---------- ---------- ----------
* get OU data
  IF cr_errorhandler IS REQUESTED.
    CALL METHOD cl_ish_dbr_org=>get_org_by_orgid
      EXPORTING
        i_orgid         = i_orgid
        i_einri         = i_einri
      IMPORTING
        es_norg         = e_norg
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ELSE.
    CALL METHOD cl_ish_dbr_org=>get_org_by_orgid
      EXPORTING
        i_orgid = i_orgid
        i_einri = i_einri
      IMPORTING
        es_norg = e_norg
        e_rc    = l_rc.
  ENDIF.
  IF l_rc = 0.
    e_orgkb = e_norg-orgkb.
    e_okurz = e_norg-okurz.
    e_orgna = e_norg-orgna.
*   if there is no description use id
    IF e_orgkb IS INITIAL.
      e_orgkb = e_norg-orgid.
    ENDIF.
    IF e_okurz IS INITIAL.
      e_okurz = e_norg-orgid.
    ENDIF.
  ELSE.
    e_rc = l_rc.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_descr_orgunit_table .
**********************************************************************
** MED-59625 Note 2186731 Bi     based on Method GET_DESCR_ORGUNIT  **
** Method to collectively get descriptions of organisational units  **
**********************************************************************

* definitions
  FIELD-SYMBOLS: <fs_norg>                TYPE norg,
                 <fs_lt_norg_bpom_buffer> TYPE norg_bpom_buffer.
* ---------- ---------- ----------
* initialize
  CLEAR: e_rc, et_norg.
* ---------- ---------- ----------
* get OU data
* First try to get descriptions from NORG_BPOM_BUFFER              MED-60495 CKi
  CALL METHOD cl_ish_utl_base_descr=>check_norg_bpom_buffer
    EXPORTING
      i_einri  = i_einri
      it_orgid = it_orgid
    IMPORTING
      et_norg  = et_norg
      e_rc     = e_rc.

  IF e_rc <> 0.           " try was not successful, so process as before      End of MED-60495 CKi

    IF cr_errorhandler IS REQUESTED.
    cl_ish_dbr_org=>get_t_org_by_orgid(
      EXPORTING
        it_orgid        = it_orgid            " Tabelle mit Organisationseinheiten
        i_einri         = i_einri             " Einrichtung
      IMPORTING
        et_norg         = et_norg             " Daten der Organisationseinheiten
        e_rc            = e_rc                " Returncode
      CHANGING
        cr_errorhandler = cr_errorhandler     " Instanz zur Fehlerbehandlung
    ).
  ELSE.
    cl_ish_dbr_org=>get_t_org_by_orgid(
      EXPORTING
        it_orgid        = it_orgid            " Tabelle mit Organisationseinheiten
        i_einri         = i_einri             " Einrichtung
      IMPORTING
        et_norg         = et_norg             " Daten der Organisationseinheiten
        e_rc            = e_rc ).             " Returncode
  ENDIF.

*   if there is no description, use id
    LOOP AT et_norg ASSIGNING <fs_norg>.
      IF <fs_norg>-orgkb IS INITIAL.
        <fs_norg>-orgkb = <fs_norg>-orgid.
      ENDIF.
      IF <fs_norg>-okurz IS INITIAL.
        <fs_norg>-okurz = <fs_norg>-orgid.
      ENDIF.
    ENDLOOP.

* ---------- ---------- ----------
  ENDIF.

ENDMETHOD.


METHOD get_descr_room .

* definitions
  DATA: l_rc                    TYPE ish_method_rc.
* ---------- ---------- ----------
* initialize
  CLEAR: e_rc, e_nbau, e_baukb, e_bkurz.
* ---------- ---------- ----------
* get description for room
  IF cr_errorhandler IS REQUESTED.
    CALL METHOD cl_ish_dbr_bau=>get_bau_by_bauid
      EXPORTING
        i_bauid         = i_bauid
      IMPORTING
        es_nbau         = e_nbau
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ELSE.
    CALL METHOD cl_ish_dbr_bau=>get_bau_by_bauid
      EXPORTING
        i_bauid = i_bauid
      IMPORTING
        es_nbau = e_nbau
        e_rc    = l_rc.
  ENDIF.
  IF l_rc = 0.
*   if there is no description use id
    IF e_nbau-baukb IS INITIAL.
      e_baukb = e_nbau-bauid.
    ELSE.
      e_baukb = e_nbau-baukb.
    ENDIF.
    IF e_nbau-bkurz IS INITIAL.
      e_bkurz = e_nbau-bauid.
    ELSE.
      e_bkurz = e_nbau-bkurz.
    ENDIF.
  ELSE.
    e_rc = l_rc.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
