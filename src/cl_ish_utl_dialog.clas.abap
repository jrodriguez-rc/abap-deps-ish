class CL_ISH_UTL_DIALOG definition
  public
  abstract
  final
  create public .

public section.

  class-methods GET_UCOMM_DOUBLECLICK
    importing
      !I_PROGRAM type SYREPID default SY-REPID
      !I_GUI_STATUS type SYPFKEY default SY-PFKEY
    returning
      value(R_UCOMM) type SYUCOMM .
  class-methods SHOW_DOCU
    importing
      !I_ID type DOKU_ID default 'TX'
      !I_OBJECT type DOKU_OBJ
      !I_LANGU type SYLANGU default SY-LANGU .
protected section.
*"* protected components of class CL_ISH_UTL_DIALOG
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_DIALOG
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_DIALOG IMPLEMENTATION.


METHOD get_ucomm_doubleclick.
  DATA:
    lt_function       TYPE TABLE OF RSEUL_KEYS.
  FIELD-SYMBOLS:
     <ls_function>    TYPE RSEUL_KEYS.

  CALL FUNCTION 'RS_CUA_GET_STATUS'
    EXPORTING
*      language              = ' '
      program               = i_program
      status                = i_gui_status
      suppress_cmod_entries = ' '
*      with_second_language  = ' '
    TABLES
*      status_list           = status_list
      fkeys                 = lt_function
*      tree                  = tree
*      not_found_list        = not_found_list
*      menutree              = menutree
*      functionkeys          = functionkeys
    EXCEPTIONS
      not_found_program     = 1
      not_found_status      = 2
      recursive_menues      = 3
      empty_list            = 4
      not_found_menu        = 5
      OTHERS                = 6.
  IF sy-subrc <> 0.
*   --------------------------------------------------> exit
    RETURN.
  ENDIF.

* doubleclick is always keybord button F2
  READ TABLE lt_function ASSIGNING <ls_function>
       WITH KEY pfno = '02'.
  IF sy-subrc = 0.
    r_ucomm = <ls_function>-code.
  ENDIF.


ENDMETHOD.


METHOD show_docu.
  DATA:
     lt_tline       TYPE tlinetab,
     ls_thead       TYPE thead,
     ls_dummy1      TYPE help_info,
     lt_dummy2      TYPE TABLE OF hlpfcode.

  CALL FUNCTION 'DOCU_GET_FOR_F1HELP'
    EXPORTING
      id     = i_id
      langu  = i_langu
      object = i_object
    IMPORTING
      head   = ls_thead
    TABLES
      line   = lt_tline
    EXCEPTIONS
      OTHERS = 1.

  IF sy-subrc NE 0.
    RETURN.
  ENDIF.

** funktioniert nicht !!!
*  ls_dummy1-title = 'Hugo'.
*  ls_dummy1-headertext = 'Hugo'.

  CALL FUNCTION 'HELP_DOCULINES_SHOW'
    EXPORTING
      help_infos     = ls_dummy1
      overlay_header = ls_thead
      not_help       = 'X'
    TABLES
      excludefun     = lt_dummy2
      helplines      = lt_tline.


ENDMETHOD.
ENDCLASS.
