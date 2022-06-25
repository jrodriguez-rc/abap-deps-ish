class CL_ISH_UTL_BASE_GPA definition
  public
  abstract
  final
  create public .

public section.

*"* public components of class CL_ISH_UTL_BASE_GPA
*"* do not include other source files here!!!
  interfaces IF_ISH_CONSTANT_DEFINITION .

  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .

  class-methods CLEAR_BUFFER .
  class-methods GET_NAME_GPA
    importing
      value(I_GPART) type GPARTNER
      value(I_LIST) type ISH_ON_OFF default OFF
      value(IS_NGPA) type NGPA optional
    exporting
      value(E_PNAME) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_TELEPHONE_NUMBER_OF_GPA
    importing
      value(I_GPART) type GPARTNER
      value(I_ONLY_DIRECT_DIALLING) type ISH_ON_OFF default ABAP_FALSE
    exporting
      value(E_NUMBER) type STRING
      value(E_NUMBER_DESCR) type STRING .
protected section.
*"* protected components of class CL_ISH_UTL_BASE_GPA
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_BASE_GPA
*"* do not include other source files here!!!

  types:
    BEGIN OF ty_namebuffer,
      gpart TYPE gpartner,
      list  TYPE ish_on_off,
      pname TYPE string,
    END OF ty_namebuffer .

  class-data:
    gt_namebuffer TYPE SORTED TABLE OF ty_namebuffer WITH UNIQUE KEY gpart list .
ENDCLASS.



CLASS CL_ISH_UTL_BASE_GPA IMPLEMENTATION.


  METHOD clear_buffer.

    FREE gt_namebuffer.

  ENDMETHOD.


METHOD get_name_gpa.

  DATA: l_read    TYPE ish_on_off.
  DATA: wa_namebuffer TYPE ty_namebuffer.             " MED-61869 Note 2305161 Bi

  FIELD-SYMBOLS: <fs_namebuffer> TYPE ty_namebuffer.  " MED-61869 Note 2305161 Bi

  e_rc = 0.
  CLEAR: e_pname.

  IF cr_errorhandler IS INITIAL AND cr_errorhandler IS REQUESTED.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

  IF i_gpart IS NOT INITIAL AND is_ngpa IS INITIAL.   " MED-61965 Note 2311441 Bi
* <<< MED-61869 Note 2305161 Bi
*   Read buffer table first
  READ TABLE gt_namebuffer ASSIGNING <fs_namebuffer>
    WITH TABLE KEY  gpart = i_gpart
                    list  = i_list .
  IF sy-subrc EQ 0.
    e_pname = <fs_namebuffer>-pname.
    e_rc    = 0.
    RETURN. " --- EXIT --->
  ENDIF.
* >>> MED-61869 Note 2305161 Bi
  ENDIF.                                              " MED-61965 Note 2311441 Bi

  IF is_ngpa IS INITIAL.
    l_read = on.
  ELSE.
    l_read = off.
  ENDIF.

  CALL FUNCTION 'ISH_NGPA_CONCATENATE'
    EXPORTING
      ss_gpart           = i_gpart
      ss_read_ngpa       = l_read
      ss_ngpa            = is_ngpa
*     SS_ROLLE     = '1'
      ss_list            = i_list
    IMPORTING
      ss_pname           = e_pname
    EXCEPTIONS
      wrong_gpart        = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.   "Michael Manoch, 19.01.2022
    IF cr_errorhandler IS BOUND.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N8'
          i_num  = '373'
          i_mv1  = i_gpart
          i_last = space.
    ENDIF.
*    e_rc = sy-subrc.   "Michael Manoch, 19.01.2022
* <<< MED-61869 Note 2305161 Bi
*    EXIT.
    RETURN. " --- EXIT --->
  ELSE.
*   Add line to the buffer
    wa_namebuffer-gpart = i_gpart.
    wa_namebuffer-list  = i_list.
    wa_namebuffer-pname = e_pname.
    INSERT wa_namebuffer INTO TABLE gt_namebuffer.
  ENDIF.
* >>> MED-61869 Note 2305161 Bi

ENDMETHOD.


METHOD get_telephone_number_of_gpa.

* definitions
  DATA: ls_nadr          TYPE nadr,
        l_string         TYPE string,
        l_text(9)        TYPE c.
* ---------- ---------- ----------
* initialize
  CLEAR: e_number, e_number_descr.
* ---------- ---------- ----------
  IF i_gpart IS INITIAL.
    RETURN.
  ENDIF.
* ---------- ---------- ----------
  CALL FUNCTION 'ISH_READ_NGPA'
    EXPORTING
      gpart        = i_gpart
      ss_with_nadr = abap_true
    IMPORTING
      nadr_e       = ls_nadr
    EXCEPTIONS
      not_found    = 1
      no_authority = 2
      OTHERS       = 3.
  CHECK sy-subrc = 0.

* ---------- ---------- ----------
* return telephone number
  IF i_only_direct_dialling = abap_true.
    e_number = ls_nadr-telxt.
  ELSE.
    IF ls_nadr-telnr IS NOT INITIAL AND ls_nadr-telxt IS NOT INITIAL.
      CONCATENATE ls_nadr-telnr '-' ls_nadr-telxt INTO e_number.
    ELSEIF ls_nadr-telnr IS NOT INITIAL.
      e_number = ls_nadr-telnr.
    ELSE.
      e_number = ls_nadr-telxt.
    ENDIF.
  ENDIF.

  IF e_number IS INITIAL.
    RETURN.
  ENDIF.
* ---------- ---------- ----------
* prepare telephone number for output
  CLEAR l_string.
  l_string    = e_number.
  CONCATENATE l_string  ')' INTO l_string.
  CONDENSE l_string NO-GAPS.
  l_text      = text-001.
  CONCATENATE l_text l_string INTO l_string.
  CONDENSE l_string.
  e_number_descr    = l_string.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
