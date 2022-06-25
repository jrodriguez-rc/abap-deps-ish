class CL_ISHMED_ERRORHANDLING definition
  public
  create public .

public section.

*"* public components of class CL_ISHMED_ERRORHANDLING
*"* do not include other source files here!!!
  constants ON type ISH_ON_OFF value 'X' ##NO_TEXT.
  constants OFF type ISH_ON_OFF value SPACE ##NO_TEXT.
  data G_TITEL type TEXT80 .

  events ERRORHANDLING
    exporting
      value(T_MESSAGES) type ISHMED_T_BAPIRET2 optional
      value(E_MAX_ERRORTYPE) type TEXT15 optional
      value(E_IDENTIFIER) type TEXT30 optional .
  events MESSAGE_CLICK
    exporting
      value(E_MESSAGE) type RN1MESSAGE .
  events MESSAGE_FUNCTION
    exporting
      value(E_UCOMM) type SYUCOMM optional .

  methods APPEND_MESSAGE_FOR_EXCEPTION
    importing
      !IR_EXCEPTION type ref to CX_ROOT
    exporting
      value(E_RC) type ISH_METHOD_RC .
  class-methods BUILD_DATA_FROM_LINE_KEY
    importing
      value(I_LINE_KEY) type ANY
    exporting
      value(E_DATA) type ANY .
  class-methods BUILD_LINE_KEY
    importing
      value(I_DATA) type ANY
      value(I_DATATYPE) type ANY
      value(I_NAME_PREFIX) type ISH_ON_OFF default ON
    exporting
      value(E_LINE_KEY) type ANY .
  methods COLLECT_MESSAGES
    importing
      value(I_TYP) type SY-MSGTY optional
      value(I_KLA) type SY-MSGID optional
      value(I_NUM) type SY-MSGNO optional
      value(I_MV1) type ANY optional
      value(I_MV2) type ANY optional
      value(I_MV3) type ANY optional
      value(I_MV4) type ANY optional
      value(I_PAR) type BAPIRET2-PARAMETER optional
      value(I_ROW) type BAPIRET2-ROW optional
      value(I_FLD) type BAPIRET2-FIELD optional
      value(T_MESSAGES) type ISHMED_T_MESSAGES optional
      value(I_LAST) type TEXT15 default 'X'
      value(I_IDENTIFIER) type TEXT30 optional
      value(I_MAX_ERRORTYPE) type TEXT15 optional
      value(I_CONTROL) type RNT40-MARK optional
      !I_OBJECT type N1OBJECTREF optional
      value(I_LINE_KEY) type CHAR100 optional
      !I_EINRI type N1ANF-EINRI optional
      !I_FUNCTION type TN21M-FUNKT default 'NMED'
      !I_READ_TN21M type ISH_ON_OFF default OFF
      !IR_ERROR_OBJ type ref to CL_ISH_ERROR optional
    exporting
      value(E_RC_TN21M) type ISH_METHOD_RC .
  methods CONSTRUCTOR
    importing
      value(I_MESSAGES) type RNT40-MARK optional
      value(I_MAX_ERRORTYPE) type TEXT15 optional
      value(I_SEND_IF_ONE) type RNT40-MARK optional
      value(I_TITEL) type TEXT80 optional
      value(I_CONTROL) type RNT40-MARK optional
      value(I_POPUP_STATIC) type ISH_ON_OFF default ON .
  methods COPY_MESSAGES
    importing
      value(I_COPY_FROM) type ref to CL_ISHMED_ERRORHANDLING .
  class-methods DESTROY_AMODAL_POPUP .
  methods DESTROY_AMODAL_POPUP_INST .
  methods DISPLAY_MESSAGES
    importing
      value(I_AMODAL) type ISH_ON_OFF default OFF
      value(I_REFRESH_AMODAL_POPUP) type ISH_ON_OFF default OFF
      !I_PARENT type ref to CL_GUI_CONTAINER optional
      !I_CAPTION type C optional
      !I_TOP type I default 30
      !I_LEFT type I default 30
      value(I_SHOW_DOUBLE_MSG) type ISH_ON_OFF default OFF
      value(I_SEND_IF_ONE) type C default '*'
      value(I_CONTROL) type ISH_ON_OFF default OFF
    exporting
      value(E_CORR_WANTED) type C
      value(E_EXIT_COMMAND) type BAL_S_EXCM .
  methods GET_ERROR
    importing
      value(I_ERROR) type N1_ERROR
      value(I_ERROR_CLASS_TYPE) type I optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ET_MSG) type ISHMED_T_MESSAGES
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ERROR_DERIVED_FROM
    importing
      value(I_ERROR) type N1_ERROR
      value(I_ERROR_CLASS_TYPE) type I optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ET_MSG) type ISHMED_T_MESSAGES
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ERROR_INHERITED_FROM
    importing
      value(I_ERROR) type N1_ERROR
      value(I_ERROR_CLASS_TYPE) type I optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ET_MSG) type ISHMED_T_MESSAGES
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_MAX_ERRORTYPE
    exporting
      value(E_MAX_ERRORTYPE) type TEXT15
      value(E_MAXTY) type ISH_BAPIRETMAXTY .
  methods GET_MESSAGES
    exporting
      value(T_EXTENDED_MSG) type ISHMED_T_MESSAGES
      value(T_MESSAGES) type ISHMED_T_BAPIRET2
      value(T_WS_MESSAGES) type ISH_T_WS_MSG
      value(E_MAX_ERRORTYPE) type TEXT15
      value(E_MAXTY) type ISH_BAPIRETMAXTY .
  methods GET_MESSAGES_WITH_ERROR
    importing
      value(I_ERROR_CLASS_TYPE) type I optional
    returning
      value(RT_MSG) type ISHMED_T_MESSAGES .
  class-methods IGNORE_WARNINGS
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING
      value(C_RC) type ISH_METHOD_RC .
  methods INITIALIZE .
  methods IS_ERROR
    importing
      value(I_ERROR) type N1_ERROR
      value(I_ERROR_CLASS_TYPE) type I optional
    returning
      value(R_IS) type ISH_ON_OFF .
  methods IS_ERROR_DERIVED_FROM
    importing
      value(I_ERROR) type N1_ERROR
      value(I_ERROR_CLASS_TYPE) type I optional
    returning
      value(R_IS) type ISH_ON_OFF .
  methods IS_ERROR_INHERITED_FROM
    importing
      value(I_ERROR) type N1_ERROR
      value(I_ERROR_CLASS_TYPE) type I optional
    returning
      value(R_IS) type ISH_ON_OFF .
  methods REFRESH_MESSAGES
    importing
      value(IT_MESSAGES) type ISHMED_T_MESSAGES optional
      value(I_SHOW_DOUBLE_MSG) type ISH_ON_OFF default OFF
    exporting
      value(ET_MSG_GRID) type ISHMED_T_MSG_GRID .
  class-methods SET_VISIBLE
    importing
      value(I_VISIBLE) type ISH_ON_OFF
      value(I_CLEAR_GRID) type ISH_ON_OFF default ON .
  methods SWITCH_ERROR_TYPE
    importing
      value(I_TYPE) type BAPI_MTYPE
      !IT_ERROR_DERIVED type ISHMED_T_OBJTYPE_N1ERROR optional
      !IT_ERROR_INHERITED type ISHMED_T_OBJTYPE_N1ERROR optional
    exporting
      value(E_RC) type ISH_METHOD_RC .
  methods HAS_ERROR_BASED_ON_ERRORTYPE
    importing
      value(I_CONSIDER_WARNINGS) type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_HAS_ERROR) type ABAP_BOOL .
  methods CLEAR_MESSAGE_TAB .
protected section.
*"* protected components of class CL_ISHMED_ERRORHANDLING
*"* do not include other source files here!!!

  data G_MSG_GRID type ref to CL_GUI_ALV_GRID .

  methods CONVERT_MV
    changing
      !C_MV type SY-MSGV1 .
private section.
*"* private components of class CL_ISHMED_ERRORHANDLING
*"* do not include other source files here!!!

  class-data G_MSG_GRID_STATIC type ref to CL_GUI_ALV_GRID .
  class-data G_MSG_CONTAINER_STATIC type ref to CL_GUI_CONTAINER .
  class-data G_CONT_FROM_OUTSIDE_STATIC type ISH_ON_OFF value SPACE. "#EC NOTEXT  " .
  class-data G_MSG_BUTTONS_STATIC type CHAR10 .
  class-data GT_MSG_GRID_STATIC type ISHMED_T_MSG_GRID .
  class-data GT_SAVE_MSG_STATIC type ISHMED_T_MESSAGES .
  data G_MESSAGES type RNT40-MARK .
  data G_MAX_ERRORTYPE type TEXT15 .
  data G_SEND_IF_ONE type RNT40-MARK .
  data G_T_MESSAGES type ISHMED_T_MESSAGES .
  data G_CONTROL type RNT40-MARK .
  data G_EVENT_MSG_GRID type ref to CL_ISHMED_ERRORHANDLING .
  data G_POPUP_STATIC type ISH_ON_OFF .
  data G_MSG_CONTAINER type ref to CL_GUI_CONTAINER .
  data G_CONT_FROM_OUTSIDE type ISH_ON_OFF .
  data G_MSG_BUTTONS type CHAR10 .
  data GT_MSG_GRID type ISHMED_T_MSG_GRID .
  data GT_SAVE_MSG type ISHMED_T_MESSAGES .
  data G_SHOW_DOUBLE_MSG type ISH_ON_OFF .

  class-methods BAPIRET2_TO_RN1MESSAGE
    importing
      value(IT_BAPIRET2) type ISHMED_T_BAPIRET2
      value(ET_MESSAGE) type ISHMED_T_MESSAGES .
  methods BUILD_ERRORTYPE
    importing
      value(I_MAX_ERRORTYPE) type TEXT15 optional
    exporting
      value(E_R_ERRORTYPE) type ISHMED_T_RN1RANGE .
  methods DISPLAY_MESSAGES_AMODAL
    importing
      !IT_MESSAGES type ISHMED_T_MESSAGES
      value(I_REFRESH_AMODAL_POPUP) type ISH_ON_OFF default OFF
      !I_PARENT type ref to CL_GUI_CONTAINER optional
      !I_CAPTION type C optional
      !I_TOP type I default 30
      !I_LEFT type I default 30
      value(I_SHOW_DOUBLE_MSG) type ISH_ON_OFF default OFF
    changing
      !C_MSG_GRID type ref to CL_GUI_ALV_GRID
      !C_MSG_CONTAINER type ref to CL_GUI_CONTAINER
      !C_CONT_FROM_OUTSIDE type ISH_ON_OFF
      !C_MSG_BUTTONS type CHAR10
      !CT_MSG_GRID type ISHMED_T_MSG_GRID .
  methods HANDLE_CLOSE_MSG_CONTAINER
    for event CLOSE of CL_GUI_DIALOGBOX_CONTAINER .
  methods HANDLE_DOUBLE_CLICK_MSG_GRID
    for event DOUBLE_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO .
  methods HANDLE_HOTSPOT_CLICK_MSG_GRID
    for event HOTSPOT_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW_ID
      !E_COLUMN_ID
      !ES_ROW_NO .
  methods HANDLE_TOOLBAR_MSG_GRID
    for event TOOLBAR of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_INTERACTIVE .
  methods HANDLE_USER_COMM_MSG_GRID
    for event USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM .
  class-methods RN1MESSAGE_TO_BAPIRET2
    importing
      value(IT_RN1MESSAGE) type ISHMED_T_MESSAGES
    exporting
      value(ET_BAPIRET2) type ISHMED_T_BAPIRET2 .
  class-methods RN1MESSAGE_TO_WS_MSG
    importing
      value(IT_RN1MESSAGE) type ISHMED_T_MESSAGES
    exporting
      value(ET_WS_MSG) type ISH_T_WS_MSG .
ENDCLASS.



CLASS CL_ISHMED_ERRORHANDLING IMPLEMENTATION.


METHOD append_message_for_exception.

* definitons
  DATA: l_text          TYPE string,
        l_program       TYPE sy-repid,
        l_include       TYPE sy-repid,
        l_line          TYPE i.
  DATA: lr_if_t100      TYPE REF TO if_t100_message.
   data: l_attribute_value_1 type char50.
   data: l_attribute_value_2 type char50.
   data: l_attribute_value_3 type char50.
   data: l_attribute_value_4 type char50.
  FIELD-SYMBOLS <fs1> TYPE ANY.
  FIELD-SYMBOLS <fs2> TYPE ANY.
  FIELD-SYMBOLS <fs3> TYPE ANY.
  FIELD-SYMBOLS <fs4> TYPE ANY.
* ---------- ---------- ----------
* check instance of exception class
  IF ir_exception IS NOT BOUND.
    e_rc = 1.
    RETURN.
  ENDIF.
* ---------- ---------- ----------
* cast to message interface
  TRY.
      lr_if_t100 ?= ir_exception.
    CATCH cx_root.
  ENDTRY.
*---------------------------------
* append message text from exception message class text
  IF lr_if_t100 IS BOUND.
    IF lr_if_t100->t100key IS NOT INITIAL.
*   BEGIN BM MED-68999 use value of attribute instead of attributename
*      me->collect_messages(
*          i_typ           = 'E'
*          i_kla           = lr_if_t100->t100key-msgid
*          i_num           = lr_if_t100->t100key-msgno
*          i_mv1           = lr_if_t100->t100key-attr1
*          i_mv2           = lr_if_t100->t100key-attr2
*          i_mv3           = lr_if_t100->t100key-attr3
*          i_mv4           = lr_if_t100->t100key-attr4
*          i_last          = space
*          i_object        = ir_exception ).
  ASSIGN ir_exception->(lr_if_t100->t100key-attr1) TO <fs1>.
  ASSIGN ir_exception->(lr_if_t100->t100key-attr2) TO <fs2>.
  ASSIGN ir_exception->(lr_if_t100->t100key-attr3) TO <fs3>.
  ASSIGN ir_exception->(lr_if_t100->t100key-attr4) TO <fs4>.
  IF <fs1> IS ASSIGNED.
  WRITE <fs1> LEFT-JUSTIFIED TO l_attribute_value_1.
  ENDIF.
  IF <fs2> IS ASSIGNED.
  WRITE <fs2> LEFT-JUSTIFIED TO l_attribute_value_2.
  ENDIF.
  IF <fs3> IS ASSIGNED.
  WRITE <fs3> LEFT-JUSTIFIED TO l_attribute_value_3.
  ENDIF.
  IF <fs4> IS ASSIGNED.
  WRITE <fs4> LEFT-JUSTIFIED TO l_attribute_value_4.
  ENDIF.

      me->collect_messages(
          i_typ           = 'E'
          i_kla           = lr_if_t100->t100key-msgid
          i_num           = lr_if_t100->t100key-msgno
          i_mv1           = l_attribute_value_1
          i_mv2           = l_attribute_value_2
          i_mv3           = l_attribute_value_3
          i_mv4           = l_attribute_value_4
          i_last          = space
          i_object        = ir_exception ).
*   END BM MED-68999
      RETURN.
    ENDIF.
  ENDIF.
* append message text from exception otr text
* ---------- ---------- ----------
* get description for exception
  l_text = ir_exception->get_text( ).
* get further information for exception
  CALL METHOD ir_exception->get_source_position
    IMPORTING
      program_name = l_program
      include_name = l_include
      source_line  = l_line.
* ---------- ---------- ----------
* leave method if there is no description for exception
  IF l_text IS INITIAL.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* append message
* & (= description)
  CALL METHOD me->collect_messages
    EXPORTING
      i_typ    = 'E'
      i_kla    = 'N1BASE'
      i_num    = '022'
      i_mv1    = l_text
      i_mv2    = l_program
      i_mv3    = l_include
      i_mv4    = l_line
      i_last   = space
      i_object = ir_exception.
* ---------- ---------- ----------
ENDMETHOD.


method BAPIRET2_TO_RN1MESSAGE.
  data: l_wa_bapiret2 type bapiret2,
        l_wa_msg      type rn1message.

  refresh et_message.
  loop at it_bapiret2 into l_wa_bapiret2.
    move-corresponding l_wa_bapiret2 to l_wa_msg.
    clear: l_wa_msg-object,
           l_wa_msg-line_key.
    append l_wa_msg to et_message.
  endloop.
endmethod.


method BUILD_DATA_FROM_LINE_KEY.
  data: l_data_type(30) type c,
        l_data(200)     type c,
        l_idx           type i,
        l_dfies         type dfies,
        l_fname         type fieldname,
        l_rc            type ish_method_rc,
        lt_fields       type standard table of dfies.
  field-symbols: <l_fs> type any.

* Initialisierungen
  clear: e_data,
         l_data_type,
         l_data.

  check not i_line_key is initial.

  split i_line_key at ';;' into l_data_type l_data.

* Bei einigen Tabellen (z.B NLEI) kommt der Key aus ganz
* bestimmten Feldern. Deshalb diese Tabellen speziell behandeln
* (siehe auch Methode BUILD_LINE_KEY)
  case l_data_type.
    when 'NLEI'.
      assign component 'LNRLS' of structure e_data to <l_fs>.
      if sy-subrc = 0.
        <l_fs> = l_data(10).
      endif.
      exit.
  endcase.

* Bei allen anderen Tabellen beginnt der Key einfach von vorne
  refresh lt_fields.
  CALL FUNCTION 'DDIF_NAMETAB_GET'
       EXPORTING
            tabname   = l_data_type
       TABLES
            dfies_tab = lt_fields
       EXCEPTIONS
            OTHERS    = 1.
  check sy-subrc = 0.
  SORT lt_fields BY tabname DESCENDING position.
  loop at lt_fields into l_dfies
                    where keyflag = on.
    assign component l_dfies-fieldname of structure e_data
                                       to <l_fs>.
    if sy-subrc = 0.
      <l_fs> = l_data(l_dfies-leng).
      shift l_data left by l_dfies-leng places.  " Fichte, Nr 10081
    endif.
  endloop.
endmethod.


method BUILD_ERRORTYPE.
*......................................................................*
  data: l_max_errortype           type text15,
        l_field,
        l_idx                     like sy-tabix,
        l_strlen                  type i,
        l_offset                  like sy-tabix,
        r_errortype               type ishmed_t_rn1range,
        wa_r_errortype            type rn1range,
        r_error                   type ishmed_t_rn1range,
        wa_r_error                type rn1range.
*......................................................................*

  l_max_errortype = i_max_errortype.

* Schwingenschlögl Marina, 02.10.2000:
* die ganze Sache kompakter:
*  l_strlen = strlen( l_max_errortype ). "index origin 1 !!!
*  if l_strlen eq ' '. "falls seltsamerweise mal ' '
*    l_strlen = '6'. "dann alles bis 6 lesen...
*  endif.
* Fichte, 31.5.02: Coding geändert um Warnung der Syntaxprüfung zu
* vermeiden
  l_strlen = strlen( l_max_errortype ).
  l_idx = 0.
  do.
    l_offset = l_idx. "index origin 0!
    if l_offset >= l_strlen. " = auch wegen idx origin 0<->1!
      exit.
    else.
      l_idx = l_idx + 1.
    endif.
    clear l_field.
    l_field = l_max_errortype+l_offset(1).
    if not l_field is initial.
      wa_r_errortype-option = 'EQ'.
      wa_r_errortype-sign   = 'I'.
      wa_r_errortype-low    = l_field.
      APPEND wa_r_errortype TO r_errortype.
    endif.
  enddo.

*=======================================================================
* MAKRO: APPEND_ERROR_RANGE
*-----------------------------------------------------------------------
* Beschreibung: hängt eine Range für den übergebenen Fehlertyp (&2)
*       (unter Verwendung der Workarea: &1) an die Rangetabelle (&3) an.
*-----------------------------------------------------------------------
* &1 = Range-Workarea
* &2 = Fehlertyp
* &3 = Rangetab
DEFINE APPEND_ERROR_RANGE.
  &1-option = 'EQ'.
  &1-sign   = 'I'.
  &1-low    = &2.
  APPEND &1 TO &3.
END-OF-DEFINITION.
*=======================================================================

* Fehlertypen (X = Exit mit Kurzdump,
*              A = Abbruch,
*              E = Fehler,
*              W = Warnung,
*              I = Information,
*              S = Status)
  loop at r_errortype into wa_r_errortype.
    case wa_r_errortype-low.
*     Status
      when 'S'.
        APPEND_ERROR_RANGE wa_r_error 'S' r_error.
        APPEND_ERROR_RANGE wa_r_error 'I' r_error.
        APPEND_ERROR_RANGE wa_r_error 'W' r_error.
        APPEND_ERROR_RANGE wa_r_error 'E' r_error.
        APPEND_ERROR_RANGE wa_r_error 'A' r_error.
        APPEND_ERROR_RANGE wa_r_error 'X' r_error.
*     Information
      when 'I'.
        APPEND_ERROR_RANGE wa_r_error 'I' r_error.
        APPEND_ERROR_RANGE wa_r_error 'W' r_error.
        APPEND_ERROR_RANGE wa_r_error 'E' r_error.
        APPEND_ERROR_RANGE wa_r_error 'A' r_error.
        APPEND_ERROR_RANGE wa_r_error 'X' r_error.
*     Warnung
      when 'W'.
        APPEND_ERROR_RANGE wa_r_error 'W' r_error.
        APPEND_ERROR_RANGE wa_r_error 'E' r_error.
        APPEND_ERROR_RANGE wa_r_error 'A' r_error.
        APPEND_ERROR_RANGE wa_r_error 'X' r_error.
*     Fehler
      when 'E'.
        APPEND_ERROR_RANGE wa_r_error 'E' r_error.
        APPEND_ERROR_RANGE wa_r_error 'A' r_error.
        APPEND_ERROR_RANGE wa_r_error 'X' r_error.
*     Abbruch
      when 'A'.
        APPEND_ERROR_RANGE wa_r_error 'A' r_error.
        APPEND_ERROR_RANGE wa_r_error 'X' r_error.
      when others.
    endcase.
  endloop.

  sort r_error by low.
  delete adjacent duplicates from r_error comparing low.

  e_r_errortype[] = r_error[].
endmethod.


METHOD build_line_key.

  DATA: l_text(50)     TYPE c,
        l_ndoc         TYPE ndoc.
  FIELD-SYMBOLS: <lfs> TYPE ANY.

  CLEAR e_line_key.

  CASE i_datatype.
    WHEN 'NBEW'.
      e_line_key = i_data(22).

    WHEN 'NDIA'.
      e_line_key = i_data(20).

    WHEN 'NLEI'.
      ASSIGN COMPONENT 'LNRLS' OF STRUCTURE i_data TO <lfs>.
      e_line_key = <lfs>.

    WHEN 'N1FAT'.
      e_line_key = i_data(11).

    WHEN 'NDOC'.
*     Um Dump zu vermeiden hier das Feld LFDDOK
*     (da es INT ist und nicht CHAR) speziell behandeln
*      e_line_key = i_data(46).
      CLEAR: l_text,
             l_ndoc.
      l_ndoc = i_data.
      e_line_key = i_data(36).
      WRITE l_ndoc-lfddok TO l_text USING EDIT MASK 'RR__________'.
      CONCATENATE e_line_key l_text INTO e_line_key.

    WHEN 'NMATV'.
      e_line_key = i_data(13).

    WHEN 'N2ZEITEN'.
      e_line_key = i_data(27).

    WHEN 'N1BEZY'.
      e_line_key = i_data(49).

    WHEN 'N2OK'.
      e_line_key = i_data(20).

    WHEN 'NICP'.
      e_line_key = i_data(13).

    WHEN 'NFAL'.
      e_line_key = i_data(17).

    WHEN 'N1ANF'.
      e_line_key = i_data(15).

    WHEN 'NPAT'.
      e_line_key = i_data(13).

    WHEN 'NPAP'.
      e_line_key = i_data(13).

*   Case-Revision
*   dynamic material-proposal
    WHEN 'N1DYLMZUO'.
      e_line_key = i_data(23).

*   material-consumption documentation
    WHEN 'N1MATVM'.
      e_line_key = i_data(13).

*   status-assignment of patient transport-services
    WHEN 'N1FSZ'.
      e_line_key = i_data(27).

*   status-trace of service
    WHEN 'N1LSSTZ'.
      e_line_key = i_data(34).

*   service-procdure connection
    WHEN 'NLICZ'.
      e_line_key = i_data(23).

*   status-trace of request
    WHEN 'N1ANMSZ'.
      e_line_key = i_data(32).

    WHEN 'N1APCN'.
      e_line_key = i_data(35).

    WHEN 'N1APPLAN'.
      e_line_key = i_data(35).

    WHEN 'N1LSTEAM'.
      e_line_key = i_data(16).

    WHEN 'N1STRUCMEDREC'.
      e_line_key = i_data(35).

    WHEN 'N1VP'.
      e_line_key = i_data(13).

    WHEN 'NTMN'.
      e_line_key = i_data(13).

    WHEN 'N1MEORDER'.
      e_line_key = i_data(13).

    WHEN 'N1CORDER'.
      e_line_key = i_data(35).

    WHEN 'N2VDNOTE'.
      e_line_key = i_data(23).

    WHEN 'NNLZ'.                                            "MED-40594
      e_line_key = i_data(25).                              "MED-40594

    when 'N1DWSWL_WRKSUR'.                                  "MED-41889
      e_line_key = i_data(46).                              "MED-41889

  ENDCASE.

* Damit dieser Keystring auch wirklich eindeutig ist, davor den
* Namen des Datentypen mit ";;" getrennt anhängen
  IF i_name_prefix = on.
    CONCATENATE i_datatype ';;' e_line_key INTO e_line_key.
  ENDIF.

ENDMETHOD.


  method CLEAR_MESSAGE_TAB.
*   Fichte, MED-69735: Method created
    CLEAR: g_t_messages[].
  endmethod.


METHOD collect_messages.

  DATA: l_typ              TYPE sy-msgty,
        l_kla              TYPE sy-msgid,
        l_num              TYPE sy-msgno,
        l_mv1              TYPE sy-msgv1,
        l_mv2              TYPE sy-msgv2,
        l_mv3              TYPE sy-msgv3,
        l_mv4              TYPE sy-msgv4,
        l_par              TYPE bapiret2-parameter,
        l_row              TYPE bapiret2-row,         " Fichte, Nr 6618
        l_fld              TYPE bapiret2-field,
        l_t_messages       TYPE ishmed_t_messages,    " Fichte, Nr 6618
        l_wa_msg           TYPE rn1message,           " Fichte, Nr 6618
        lt_bapiret2        TYPE ishmed_t_bapiret2,    " Fichte, Nr 6618
        wa_messages        TYPE bapiret2,
        l_last             TYPE text15,
        l_identifier       TYPE text30,
        l_max_errortype    TYPE text15.
  DATA: r_errortype        TYPE ishmed_t_rn1range,
        l_flag.

  DATA: l_type             TYPE rn1message-type,
        l_idx              TYPE sy-tabix,
        l_number           TYPE tn21m-msgnr.

*......................................................................*
* Fichte, Nr 6618: Komplette Methode verändert, um das neue Format der
* Tabelle G_T_MESSAGES versorgen zu können.

* Wenn i_control auf 'X' gesetzt ist, dann werden alle Errors und
* Warnings in S-Meldungen umgewandelt (aber nur für die Ausgabe).
  IF i_control = 'X'.
    g_control = i_control.
  ENDIF.

* Führer, ID 14821 initialize returncode
  e_rc_tn21m = 0.

* alle Importparameter übernehmen in Interne Variable
  l_typ          = i_typ.
  l_kla          = i_kla.
  l_num          = i_num.
  l_par          = i_par.
  l_row          = i_row.
  l_fld          = i_fld.

*  l_mv1          = i_mv1.
*  l_mv2          = i_mv2.
*  l_mv3          = i_mv3.
*  l_mv4          = i_mv4.

* convert message variables to correct output format
  CALL FUNCTION 'ISH_MESSAGE_VARS_PREPARE'
    EXPORTING
      ss_msgv1   = i_mv1      " l_mv1
      ss_msgv2   = i_mv2      " l_mv2
      ss_msgv3   = i_mv3      " l_mv3
      ss_msgv4   = i_mv4      " l_mv4
    IMPORTING
      ss_msgv1_e = l_mv1
      ss_msgv2_e = l_mv2
      ss_msgv3_e = l_mv3
      ss_msgv4_e = l_mv4.

*  l_mv1          = i_mv1.
*  CALL METHOD me->convert_mv
*    CHANGING
*      c_mv = l_mv1.
*  l_mv2          = i_mv2.
*  CALL METHOD me->convert_mv
*    CHANGING
*      c_mv = l_mv2.
*  l_mv3          = i_mv3.
*  CALL METHOD me->convert_mv
*    CHANGING
*      c_mv = l_mv3.
*  l_mv4          = i_mv4.
*  CALL METHOD me->convert_mv
*    CHANGING
*      c_mv = l_mv4.

* Fichte, Nr 6618: Übergabetabelle hat anderes Format
  l_t_messages[]  = t_messages[].
*  CALL METHOD CL_ISHMED_ERRORHANDLING=>BAPIRET2_TO_RN1MESSAGE
*    EXPORTING
*      IT_BAPIRET2 = t_messages
*      ET_MESSAGE  = l_t_messages.
  l_last          = i_last.
  l_identifier    = i_identifier.
  l_max_errortype = i_max_errortype.

* SCHWINGENSCH 021000:
* Aufrufe erst bei Display - sonst nicht instanzübergreifend möglich
* FUNCTION 'MESSAGES_INITIALIZE'.

* Wenn eine einzelne Fehlermeldung übergeben wurde
  IF NOT l_typ IS INITIAL AND NOT l_kla IS INITIAL.
*    Führer, 17.05.01: Nachrichtennummer nicht prüfen -> sonst kann
*                      Nachricht Nr. 000 nicht verarbeitet werden.
*    not l_num is initial.
    l_wa_msg-type       = l_typ.
    l_wa_msg-id         = l_kla.
    l_wa_msg-number     = l_num.
    l_wa_msg-message_v1 = l_mv1.
    l_wa_msg-message_v2 = l_mv2.
    l_wa_msg-message_v3 = l_mv3.
    l_wa_msg-message_v4 = l_mv4.
    l_wa_msg-parameter  = l_par.
    l_wa_msg-row        = l_row.
    l_wa_msg-field      = l_fld.
    l_wa_msg-object     = i_object.
    l_wa_msg-line_key   = i_line_key.
    l_wa_msg-error_obj  = ir_error_obj.       "Führer, ID 17202
*   Fichte, Nr 8490, 2: Auch Variable MESSAGE befüllen
    CLEAR wa_messages.
    CALL FUNCTION 'ISH_BAPI_FILL_RETURN_PARAM'
      EXPORTING
        msgty     = l_wa_msg-type
        msgid     = l_wa_msg-id
        msgno     = l_wa_msg-number
        msgv1     = l_wa_msg-message_v1
        msgv2     = l_wa_msg-message_v2
        msgv3     = l_wa_msg-message_v3
        msgv4     = l_wa_msg-message_v4
        parameter = l_wa_msg-parameter
        field     = l_wa_msg-field
      IMPORTING
        return    = wa_messages.
    l_wa_msg-message = wa_messages-message.
    l_wa_msg-system  = wa_messages-system.
*   Fichte, Nr 8490, 2 - Ende
    APPEND l_wa_msg TO l_t_messages.
  ENDIF.

* Koppensteiner, 09.04.2003 - Begin
  IF i_read_tn21m = on.
    CLEAR l_wa_msg.
    LOOP AT l_t_messages INTO l_wa_msg.
      l_idx = sy-tabix.
      CLEAR l_number.
      l_number = l_wa_msg-number.
      CALL FUNCTION 'ISH_MESSAGE_HANDLER'
        EXPORTING
          einri              = i_einri
          function           = i_function
          mess_arbgb         = l_wa_msg-id
          mess_nr            = l_number
          mess_show          = off
          mess_coll          = off
          mess_coll_active   = off
          mess_typ           = l_wa_msg-type
          mess_error         = on             " MED-40937
        IMPORTING
          mess_typ           = l_type
        EXCEPTIONS
          mess_typ_not_valid = 1
          OTHERS             = 2.
      IF sy-subrc = 0.
        IF l_type IS INITIAL.
          DELETE l_t_messages INDEX l_idx.
          CONTINUE.
        ENDIF.
*       Führer, ID 14821 24.06.04 - begin
*       set returncode dependent of message type
        IF l_type = 'A' OR
           l_type = 'E'.
          e_rc_tn21m = 7.
        ENDIF.
*       Führer, ID 14821 24.06.04 - end
        IF l_type <> l_wa_msg-type.
          l_wa_msg-type = l_type.
          MODIFY l_t_messages FROM l_wa_msg INDEX l_idx.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDIF.
* Koppensteiner, 09.04.2003 - End

* Alle übergebenen Nachrichten in 1 glob. Tabelle stellen, wenn die
* lokale Tabelle leer ist wird sowieso nichts an die Tabelle angehängt..
  APPEND LINES OF l_t_messages TO g_t_messages.

* jede Message (mit komplett identen Messagevariablen...) soll ja nur 1x
* abgelegt werden, d.h. hier die doppelten raus:
* Führer, 17.5.01: dadurch werden die Meldungen leider aber auch
*                  umsortiert -> manchmal unerwünscht !?!?!?!?!?!!?!?!?
*****  sort g_t_messages[].
*****  delete adjacent duplicates from g_t_messages.

* SCHWINGENSCH 021000:
* Aufrufe erst bei Display - sonst nicht instanzübergreifend möglich
* FUNCTION 'MESSAGE_STORE'

* Wenn eine Ausgabe gewünscht wird (g_messages = 'X') und die letzte
* Meldung übergeben wurde (l_last = 'X'), dann wird die Ausgabe
* angesteuert
  IF l_last = 'X' AND g_messages = 'X'.
    CALL METHOD me->display_messages.
  ENDIF.

* Die übergebenen Fehlertypen in Range-Tab stellen
* entweder sie wurden der Methode collect_messages
  IF NOT l_max_errortype IS INITIAL.
    CALL METHOD me->build_errortype
      EXPORTING
        i_max_errortype = l_max_errortype
      IMPORTING
        e_r_errortype   = r_errortype[].
* oder dem Constructor übergeben
  ELSEIF NOT g_max_errortype IS INITIAL.
    CALL METHOD me->build_errortype
      EXPORTING
        i_max_errortype = g_max_errortype
      IMPORTING
        e_r_errortype   = r_errortype[].
  ENDIF.

  IF NOT r_errortype[] IS INITIAL.
*    loop at l_t_messages into wa_messages
    LOOP AT l_t_messages INTO l_wa_msg
      WHERE type IN r_errortype.
      l_flag = 'X'.
      EXIT.
    ENDLOOP.
  ENDIF.

  IF l_flag = 'X' AND l_last = 'X'.
*   den höchst aufgetretenen Fehlertypen ermitteln
    CALL METHOD me->get_max_errortype
      IMPORTING
        e_max_errortype = l_max_errortype.
*   Event errorhandling anstoßen
    CALL METHOD cl_ishmed_errorhandling=>rn1message_to_bapiret2
      EXPORTING
        it_rn1message = g_t_messages
      IMPORTING
        et_bapiret2   = lt_bapiret2.
    RAISE EVENT errorhandling
      EXPORTING
*        t_messages      = g_t_messages
        t_messages      = lt_bapiret2
        e_identifier    = l_identifier
        e_max_errortype = l_max_errortype.
  ENDIF.

ENDMETHOD.


method CONSTRUCTOR.
* Globale Attribute zuweisen
  g_messages      = i_messages.
  g_max_errortype = i_max_errortype.
  g_send_if_one   = i_send_if_one.
  g_titel         = i_titel.
  g_control       = i_control.

* G_POPUP_STATIC: Die Meldungen ALLER Errorhandler, die ebenfalls
* mit diesem Attribut aufgebaut wurden, werden gesammelt in genau
* einem einzigen Popup angezeigt
* Das ist sehr nützlich, wenn man unterschiedliche Errorhandler
* benutzt und trotzdem das Message-Popup nur einmal haben möchte
  g_popup_static  = i_popup_static.

* Messagetabelle ist zwar sowieso initial aber besser so:
  refresh g_t_messages[].

* Hier auf keinen Fall das INITIALIZE aufrufen, denn damit
* initialisiert man auch das statische Message-Grid usw., was
* wiederum bedeuten würde, dass das Message-Popup mehrmals
* aufgebaut wird und zwar auch in der statischen Betriebsart!
*  CALL METHOD me->initialize.

* Schwingenschlögl Marina, 02.10.2000:
* Das sammeln der Messages kann nicht laufend über die
* Funktionsbausteine MESSAGES_INITIALIZE - MESSAGE_STORE - MESSAGES_SHOW
* erfolgen, weil diese nicht Instanzabhängig sind!! -> d.h. wenn mehrere
* Instanzen der Klasse im laufenden Programm existieren funktioniert das
* Fehlerhandling in keiner mehr!!!
* -> folglich diese Aufrufe der FUBs erst unmittelbar vor dem Display
* der Nachrichten durchführen:
** Dieser Funktionsbaustein stößt das Sammeln der Nachrichten an
*  CALL FUNCTION 'MESSAGES_INITIALIZE'.
endmethod.


METHOD convert_mv .

*  DATA: l_x        TYPE i,
*        l_y        TYPE i,
*        l_date     TYPE sy-datum,
*        l_time     TYPE sy-uzeit,
*        l_text(30) TYPE c.
*
** ---------------------------------------------------------
** Check if the message-variable contains a date in internal format
*  l_x = STRLEN( c_mv ).
*  IF l_x = 8  AND  c_mv(l_x) CO '0123456789'.
*    l_x = c_mv(4).
*    l_y = c_mv+4(2).
*    IF l_x > 1900  AND  l_x < 2200  AND
*       l_y > 0     AND  l_y < 13.
*      l_date = c_mv.
*      CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
*        EXPORTING
*          date_internal            = l_date
*        IMPORTING
*          date_external            = l_text
*        EXCEPTIONS
*          date_internal_is_invalid = 1
*          OTHERS                   = 2.
*      IF sy-subrc = 0.
*        c_mv = l_text.
*        EXIT.
*      ENDIF.
*    ENDIF.
*  ENDIF.
*
** ---------------------------------------------------------
** Check if the message-variable contains a time in internal format
*  l_x = STRLEN( c_mv ).
*  IF l_x = 6  AND  c_mv(l_x) CO ' 0123456789'.
*    l_x = c_mv(2).
*    l_y = c_mv+2(2).
*    IF l_x >= 0  AND  l_x < 24  AND
*       l_y >= 0  AND  l_y < 60.
*      l_time = c_mv.
*      CLEAR: l_text.
*      WRITE l_time TO l_text USING EDIT MASK '__:__'.
*      c_mv = l_text.
*      EXIT.
*    ENDIF.
*  ENDIF.
*
*  CONDENSE c_mv.

ENDMETHOD.


method COPY_MESSAGES .
  data: lt_messages type ishmed_t_messages.

  check not i_copy_from is initial.

  refresh lt_messages.
  CALL METHOD I_COPY_FROM->GET_MESSAGES
    IMPORTING
      T_EXTENDED_MSG  = lt_messages.
  read table lt_messages transporting no fields
             index 1.
  check sy-subrc = 0.

  CALL METHOD ME->COLLECT_MESSAGES
    EXPORTING
      T_MESSAGES      = lt_messages
      I_LAST          = space.
endmethod.


METHOD destroy_amodal_popup.
  DATA: l_make_flush TYPE ish_on_off.                     "ID 19996 INS

  CLEAR l_make_flush.                                     "ID 19996 INS

  IF NOT g_msg_grid_static IS INITIAL.
    CALL METHOD g_msg_grid_static->free
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
    ENDIF.
    l_make_flush = on.                                    "ID 19996 INS
  ENDIF.
* Fichte, 22.3.02: Wurde der Container von außerhalb übergeben,
* "gehört" er auch dem Aufrufer und darf hier NICHT initialisiert
* werden!
  IF NOT g_msg_container_static IS INITIAL  AND
         g_cont_from_outside_static = off.
    CALL METHOD g_msg_container_static->free.
    l_make_flush = on.                                    "ID 19996 INS
  ENDIF.
  IF l_make_flush = on.                                   "ID 19996 INS
    CALL METHOD cl_gui_cfw=>flush.
  ENDIF.                                                  "ID 19996 INS
  CLEAR: g_msg_grid_static,
         g_msg_container_static,
         gt_save_msg_static,
         gt_msg_grid_static.
ENDMETHOD.


METHOD destroy_amodal_popup_inst.

*  DATA: l_test_hitlist TYPE ish_on_off.

*  GET PARAMETER ID 'ZN1_TEST_HITLIST' FIELD l_test_hitlist.
*  IF l_test_hitlist = 'X'.

    DATA: l_make_flush TYPE ish_on_off.                     "MED-79772

    CLEAR l_make_flush.                                     "MED-79772

    IF NOT g_msg_grid IS INITIAL.
    CALL METHOD g_msg_grid->free
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
    ENDIF.
      l_make_flush = on.                                    "MED-79772
    ENDIF.
* Fichte, 22.3.02: Wurde der Container von außerhalb übergeben,
* "gehört" er auch dem Aufrufer und darf hier NICHT initialisiert
* werden!
  IF NOT g_msg_container IS INITIAL  AND
         g_cont_from_outside = off.
* Michael Manoch, 11.05.2009: Exceptionhandling   START
*    CALL METHOD g_msg_container->free.
    CALL METHOD g_msg_container->free
      EXCEPTIONS
        OTHERS = 1.
* Michael Manoch, 11.05.2009: Exceptionhandling   END
      l_make_flush = on.                                    "MED-79772
    ENDIF.
* Michael Manoch, 11.05.2009: Exceptionhandling   START
*  CALL METHOD cl_gui_cfw=>flush.
    IF l_make_flush = on.                                   "MED-79772
  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      OTHERS = 1.
    ENDIF.                                                  "MED-79772
* Michael Manoch, 11.05.2009: Exceptionhandling   END
  CLEAR: g_msg_grid,
         g_msg_container,
         gt_save_msg,
         gt_msg_grid.

*  ELSE.
*
*    IF NOT g_msg_grid IS INITIAL.
*      CALL METHOD g_msg_grid->free
*        EXCEPTIONS
*          cntl_error        = 1
*          cntl_system_error = 2
*          OTHERS            = 3.
*      IF sy-subrc <> 0.
*      ENDIF.
*    ENDIF.
** Fichte, 22.3.02: Wurde der Container von außerhalb übergeben,
** "gehört" er auch dem Aufrufer und darf hier NICHT initialisiert
** werden!
*    IF NOT g_msg_container IS INITIAL  AND
*           g_cont_from_outside = off.
** Michael Manoch, 11.05.2009: Exceptionhandling   START
**    CALL METHOD g_msg_container->free.
*      CALL METHOD g_msg_container->free
*        EXCEPTIONS
*          OTHERS = 1.
** Michael Manoch, 11.05.2009: Exceptionhandling   END
*    ENDIF.
** Michael Manoch, 11.05.2009: Exceptionhandling   START
**  CALL METHOD cl_gui_cfw=>flush.
*    CALL METHOD cl_gui_cfw=>flush
*      EXCEPTIONS
*        OTHERS = 1.
** Michael Manoch, 11.05.2009: Exceptionhandling   END
*    CLEAR: g_msg_grid,
*           g_msg_container,
*           gt_save_msg,
*           gt_msg_grid.
*
*  ENDIF.

ENDMETHOD.


METHOD display_messages.
  DATA: l_wa_messages TYPE rn1message,      " Fichte, Nr 6618
        l_send_if_one TYPE c.
*  DATA: l_only_1_msg  TYPE ish_on_off.                      " MED-39893
*  DATA: l_event(3)    TYPE c.                               " MED-39893
* Fichte, MED-30906 - Begin
  DATA: lr_message    TYPE REF TO if_message.
* Fichte, MED-30906 - End
* Michael Manoch, 24.08.2005   START
  FIELD-SYMBOLS: <l_object>  TYPE any.
* Michael Manoch, 24.08.2005   END

* Fichte, 3.10.01: SEND_IF_ONE ist nun auch Parameter dieser
* Methode
  IF i_send_if_one = '*'.
    l_send_if_one = g_send_if_one.
  ELSE.
    l_send_if_one = i_send_if_one.
  ENDIF.

* Führer, 18.11.02: Parameter I_CONTROL aufgenommen.
* Wenn i_control auf 'X' gesetzt ist, dann werden alle Errors und
* Warnings in S-Meldungen umgewandelt (aber nur für die Ausgabe).
  IF i_control = 'X'.
    g_control = i_control.
  ENDIF.

* Führer, ID. 12925 1.9.03
* save "i_show_double_msg" to global attribute; necessary because:
* -) event handler for toolbar needs information if double messages
*    are displayed - to set correct number of messages
* -) information is also necessary to fade in / fade out messages;
*    until now it wasn't possible to fade in double messages (method
*    "refresh_messages" was called without parameter "i_show_double_msg"
  g_show_double_msg = i_show_double_msg.

* Fichte, Nr 7244: Messages nun amodal ausgeben
  IF i_amodal = on.
*   Je nach Betriebsart das Messagepopup aufbauen
    IF g_popup_static = on.
      CALL METHOD me->display_messages_amodal
        EXPORTING
          it_messages            = g_t_messages
          i_refresh_amodal_popup = i_refresh_amodal_popup
          i_parent               = i_parent
          i_caption              = i_caption
          i_top                  = i_top
          i_left                 = i_left
          i_show_double_msg      = i_show_double_msg
        CHANGING
          c_msg_grid             = g_msg_grid_static
          c_msg_container        = g_msg_container_static
          c_cont_from_outside    = g_cont_from_outside_static
          c_msg_buttons          = g_msg_buttons_static
          ct_msg_grid            = gt_msg_grid_static.
    ELSE.
      CALL METHOD me->display_messages_amodal
        EXPORTING
          it_messages            = g_t_messages
          i_refresh_amodal_popup = i_refresh_amodal_popup
          i_parent               = i_parent
          i_caption              = i_caption
          i_top                  = i_top
          i_left                 = i_left
          i_show_double_msg      = i_show_double_msg
        CHANGING
          c_msg_grid             = g_msg_grid
          c_msg_container        = g_msg_container
          c_cont_from_outside    = g_cont_from_outside
          c_msg_buttons          = g_msg_buttons
          ct_msg_grid            = gt_msg_grid.
    ENDIF.
    EXIT.
  ENDIF.
* Fichte, Nr 7244 - Ende

* Fichte, MED-30906: if G_T_MESSAGES just contains exactly 1 message
* and SEND_IF_ONE = ON, then check the message: If it contains an
* ERROR_OBJ which implements interface IF_MESSAGE then the
* message has to be raised directly here with a special syntax,
* because the message wants to show a special text and longtext
  DESCRIBE TABLE g_t_messages.
  IF sy-tfill = 1  AND  l_send_if_one = on.
*    l_only_1_msg = on.                                      " MED-39893
    READ TABLE g_t_messages INTO l_wa_messages INDEX 1.
    IF l_wa_messages-error_obj IS NOT INITIAL.
      CLEAR: lr_message.
      TRY.
          lr_message ?= l_wa_messages-error_obj.
        CATCH cx_root.
          CLEAR: lr_message.
      ENDTRY.

      IF lr_message IS NOT INITIAL.
*       Initialize Message-Queue and clear message-table
        CALL FUNCTION 'MESSAGES_INITIALIZE'.
        CLEAR g_t_messages. REFRESH g_t_messages.
*       Show the message
        MESSAGE lr_message TYPE l_wa_messages-type
                DISPLAY LIKE l_wa_messages-type.
      ENDIF.
    ENDIF.
  ENDIF.
* Fichte, MED-30906 - End

  IF NOT g_t_messages[] IS INITIAL.
*   Aufrufe erst bei Display - sonst nicht instanzübergreifend möglich!!
*   sehr wichtig!!!

*   gesammelte Nachrichten initialisieren:
*   Führer, ID. 12925 1.9.03 - begin
*   if double messages should be displayed call function module
*   "messages_initialize" correct; see parameter "i_no_duplicate_count"
*    CALL FUNCTION 'MESSAGES_INITIALIZE'.
    IF g_show_double_msg = on.
      CALL FUNCTION 'MESSAGES_INITIALIZE'
        EXPORTING
*         number of messages, up to which no duplicates are saved
*         ==> important to show double messages also in modal popup
          i_no_duplicate_count = 0.
    ELSE.
      CALL FUNCTION 'MESSAGES_INITIALIZE'.
    ENDIF.
*   Führer, ID. 12925 1.9.03 - end

    LOOP AT g_t_messages INTO l_wa_messages
      WHERE NOT type   IS INITIAL
        AND NOT id     IS INITIAL.

* Wenn g_control auf 'X' gesetzt ist, dann werden alle Errors und
* Warnings in S-Meldungen umgewandelt.
*      CALL 'DY_GET_DYNPRO_EVENT' ID 'EVENT' FIELD l_event.  " MED-39893
*      IF l_only_1_msg = on AND l_event <> 'PAI'.            " MED-39893
        IF g_control = 'X'.
          IF l_wa_messages-type = 'E' OR l_wa_messages-type = 'W'.
            l_wa_messages-type = 'S'.
          ENDIF.
        ENDIF.
*      ENDIF.                                                " MED-39893

*     Nachrichten speichern
      CALL FUNCTION 'MESSAGE_STORE'
        EXPORTING
          arbgb = l_wa_messages-id
          msgty = l_wa_messages-type
          msgv1 = l_wa_messages-message_v1
          msgv2 = l_wa_messages-message_v2
          msgv3 = l_wa_messages-message_v3
          msgv4 = l_wa_messages-message_v4
          txtnr = l_wa_messages-number
          zeile = l_wa_messages-row.
    ENDLOOP.

    CLEAR g_t_messages. REFRESH g_t_messages.

*   Michael Manoch, 24.08.2005   START
*   Use i_caption if specified.
    IF i_caption IS SUPPLIED.
      ASSIGN i_caption TO <l_object>.
    ELSE.
      ASSIGN g_titel TO <l_object>.
    ENDIF.
*   Michael Manoch, 24.08.2005   END

*   alle Nachrichten anzeigen:
    CALL FUNCTION 'MESSAGES_SHOW'
      EXPORTING
        corrections_option          = on
        corrections_func_text       = ' '
*       Michael Manoch, 24.08.2005   START
*        object                      = g_titel
        object                      = <l_object>
*       Michael Manoch, 24.08.2005   START
        send_if_one                 = l_send_if_one
        show_linno                  = off
*       Fichte, 25.1.02: Aufgrund anhaltender Probleme mit der
*       Darstellung als Grid habe ich die Darstellung wieder auf
*       das normale Reportformat zurückgestellt (Auslieferung
*       mit Hinweis 491643)
        i_use_grid                  = off
      IMPORTING
        corrections_wanted          = e_corr_wanted
        e_exit_command              = e_exit_command
      EXCEPTIONS
        inconsistent_range          = 1
        no_messages                 = 2
        OTHERS                      = 3.

*   gesammelte Nachrichten initialisieren:
    CALL FUNCTION 'MESSAGES_INITIALIZE'.

  ENDIF.

ENDMETHOD.


METHOD display_messages_amodal .

**  data l_bypassing_buffer type char01 value ' '. " Rz 26.08.2013

  DATA: lt_messages     TYPE ishmed_t_messages.
  DATA: lt_events       TYPE cntl_simple_events,
        l_wa_event      TYPE cntl_simple_event,
        lt_tbar_excl    TYPE ui_functions,
        l_wa_tbar       TYPE ui_func,
        lt_fcat         TYPE lvc_t_fcat,
        l_wa_fcat       TYPE lvc_s_fcat,
        l_layout        TYPE lvc_s_layo.
  DATA: lt_msg_grid     TYPE ishmed_t_msg_grid,   " Fichte, 4.10.01
        l_msg_grid      TYPE rn1msg_grid.         " Fichte, 4.10.01
* Fichte, 10.9.02: Dialogboxcontainer für Cast - siehe weiter unten
  DATA: l_dialogbox_container TYPE REF TO cl_gui_dialogbox_container.
* Fichte, Nr 8981: Container-Zwischenvariable
  DATA: l_dialog_cont   TYPE REF TO cl_gui_dialogbox_container.
  FIELD-SYMBOLS: <lfs_msg_buttons> TYPE char10.

* Initialisierungen
  REFRESH: lt_messages.
  lt_messages[] = it_messages[].

* Fichte, 22.3.02: Es muss auch vermerkt werden, ob der Container
* von außerhalb übergeben wird (d.h. dem Aufrufer "gehört") oder
* ob er hier drinnen angelegt wird
  IF NOT i_parent IS INITIAL.
    c_cont_from_outside = on.
  ELSE.
    c_cont_from_outside = off.
  ENDIF.

* Fichte, 4.10.01: Zeilen entfernt. Das Messagepopup darf hier
* auf keinen Fall initialisiert/gelöscht werden, denn die
* Messages sollen ja gesammelt ausgegeben werden. Wenn nun aber
* ein Aufruf von Display_Messages das Popup löschen würde, würden
* die zuvor an das Popup geschickten Messages verloren gehen!
* Deshalb nur dann das Popup zerstören, wenn der Aufrufer ein
* Refresh des Popups wünscht und keine Daten zum Anzeigen da sind.
** Ist die Tabelle leer, d.h. sind keine Messages vorhanden, wird
** das Messagepopup zerstört
  DESCRIBE TABLE lt_messages.
  IF sy-tfill < 1.
    IF i_refresh_amodal_popup = on.
*     Fichte, Nr 8981: Gibt der Aufrufer den Container mit, hat
*     der Aufrufer auch die Kontrolle darüber. Deshalb hier auf
*     keinen Fall den Container initialisieren, sondern einfach
*     auf invisible setzen
*      if not c_msg_container is initial.
      IF NOT i_parent IS INITIAL.
        CALL METHOD cl_ishmed_errorhandling=>set_visible
          EXPORTING
            i_visible = off.
      ELSEIF NOT c_msg_container IS INITIAL.
        CALL METHOD cl_ishmed_errorhandling=>destroy_amodal_popup.
      ENDIF.
    ENDIF.
*   Grid-Tabelle löschen. Damit werden nur mehr Messages der
*   aktuellen Instanz des Messageshandlers und nicht mehr die
*   (in ct_MSG_GRID) gesammtelten Messages aller Handler-Aufrufe
*   seit dem letzten Refresh angezeigt
    REFRESH ct_msg_grid.
    EXIT.
  ENDIF.

* Fichte, Nr 8981: Popup erst weiter unten sichtbar machen!
** Fichte, 4.10.01: Popup wieder sichtbar machen
*  CALL METHOD cl_ishmed_errorhandling=>set_visible
*    EXPORTING
*      i_visible = on.

* Alle Messagetypen anzeigen
  CLEAR c_msg_buttons.

* Dialogbox-Container, der das Grid aufnehmen soll nun anlegen,
* aber nur, wenn er noch nicht existiert!
  IF NOT c_msg_container IS INITIAL.
*   Existiert der Container schon, heißt das, dass die Messages
*   aufgefrischt werden sollen => Messagetabelle neu setzen
    CALL METHOD me->refresh_messages
      EXPORTING
        it_messages       = lt_messages
        i_show_double_msg = i_show_double_msg
      IMPORTING
        et_msg_grid       = lt_msg_grid.         " Fichte, 4.10.01
*   Fichte, 4.10.01: Die Messages aller Aufrufe werden nun
*   gesammelt und gesammelt ausgegeben. Der Aufrufer muss selbst
*   bestimmen, WANN das Message-Popup initialisiert werden soll
*   indem er zu diesem Zeitpunkt die geeignete Methode dieser
*   Klasse aufruft
    APPEND LINES OF lt_msg_grid TO ct_msg_grid.  " Fichte, 4.10.01

*   Doppelte Messages eliminieren und zwar ohne die Messages
*   umzusortieren
    IF i_show_double_msg = off.
      REFRESH lt_msg_grid.
      LOOP AT ct_msg_grid INTO l_msg_grid.
        READ TABLE lt_msg_grid TRANSPORTING NO FIELDS
                   WITH KEY type       = l_msg_grid-type
                            id         = l_msg_grid-id
                            number     = l_msg_grid-number
                            message_v1 = l_msg_grid-message_v1
                            message_v2 = l_msg_grid-message_v2
                            message_v3 = l_msg_grid-message_v3
                            message_v4 = l_msg_grid-message_v4.
        CHECK sy-subrc <> 0.
*       Datensatz existiert noch nicht => In Zieltabelle aufnehmen
        APPEND l_msg_grid TO lt_msg_grid.
      ENDLOOP.
      REFRESH ct_msg_grid.
      ct_msg_grid[] = lt_msg_grid[].
    ENDIF.

    CALL METHOD c_msg_grid->refresh_table_display
*      EXPORTING
*        IS_STABLE      =
*        I_SOFT_REFRESH =
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2.

*   Fichte, 8981: Container nun sichtbar machen
    CALL METHOD cl_ishmed_errorhandling=>set_visible
      EXPORTING
        i_visible = on.
    EXIT.
  ENDIF.
  REFRESH: ct_msg_grid.
  CLEAR: c_msg_grid.

* Wird vom Aufrufer kein Container angegeben, wird hier automatisch
* eine Dialogbox angelegt
  IF i_parent IS INITIAL.
*   Fichte, Nr 8981: Zuerst den Zwischencontainer aufrufen und
*   danach den Dialogbox-Container auf die generischere Variable
*   C_MSG_CONTAINER casten
    CLEAR l_dialog_cont.
*    CREATE OBJECT I_MSG_CONTAINER
    CREATE OBJECT l_dialog_cont
      EXPORTING
*        PARENT                      =
        width                       = 500
        height                      = 120
        top                         = i_top
        left                        = i_left
        caption                     = i_caption
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        event_already_registered    = 6
        error_regist_event          = 7
        OTHERS                      = 8.
    IF sy-subrc <> 0.
*     Schwerer Fehler & bei & aufgetreten
      MESSAGE x219(nf1) WITH sy-subrc
                        'Create Object DialogboxContainer'. "#EC NOTEXT
      EXIT.
    ENDIF.
    c_msg_container = l_dialog_cont.
*   Fichte, Nr 8981 - Ende
  ELSE.
    c_msg_container = i_parent.
  ENDIF.   " else if i_parent is initial

* Nun das Grid für die Fehlermeldungen anlegen
  CREATE OBJECT c_msg_grid
    EXPORTING
      i_parent          = c_msg_container
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.
  IF sy-subrc <> 0.
*   Schwerer Fehler & bei & aufgetreten
    MESSAGE x219(nf1) WITH sy-subrc
                      'Creat Object Msg-Grid'.              "#EC NOTEXT
    EXIT.
  ENDIF.

* Fichte, 8981: Container nun sichtbar machen
  CALL METHOD cl_ishmed_errorhandling=>set_visible
    EXPORTING
      i_visible = on.

* Definition der notwendigen Events
  REFRESH: lt_events.
  CLEAR l_wa_event.
* Dialogbox-Container
* Fichte, 10.9.02: Ich musste den Typ von C_MSG_CONTAINER auf
* CL_GUI_CONTAINER ändern. Ist C_MSG_CONTAINER nun kein
* Dialogbox-Container, gibt es diesen Handler nicht. Deshalb
* hier zuerst einen Cast durchführen
* Diese Änderungen haben auch die globalen G_MSG_CONTAINER_...-
* Attribute betroffen und die Schnittstelle dieser Methode
  CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
    l_dialogbox_container ?= c_msg_container.
  ENDCATCH.
  IF sy-subrc = 0.
    SET HANDLER me->handle_close_msg_container
                FOR l_dialogbox_container.
  ENDIF.
* Grid:
  SET HANDLER me->handle_user_comm_msg_grid
              FOR c_msg_grid.
  SET HANDLER me->handle_toolbar_msg_grid
              FOR c_msg_grid.
  SET HANDLER me->handle_double_click_msg_grid
              FOR c_msg_grid.
  SET HANDLER me->handle_hotspot_click_msg_grid
              FOR c_msg_grid.

* Die Datentabelle des Grids setzen
  CALL METHOD me->refresh_messages
    EXPORTING
      it_messages       = lt_messages
      i_show_double_msg = i_show_double_msg
    IMPORTING
      et_msg_grid       = ct_msg_grid.

* Das Grid nun mit Daten versorgen
* Den Feldkatalog hier zusammenstellen
  REFRESH lt_fcat.
  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname = 'LOG_MSG_NO'.
  l_wa_fcat-inttype   = 'C'.
  l_wa_fcat-outputlen = 6.
  l_wa_fcat-reptext   = 'LOG_MSG_NO'.
  l_wa_fcat-no_out    = on.
  l_wa_fcat-tech      = on.
  APPEND l_wa_fcat TO lt_fcat.

  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname = 'TYPE_GRID'.
  l_wa_fcat-inttype   = 'C'.
  l_wa_fcat-outputlen = 3.
  l_wa_fcat-reptext   = 'Typ'(001).
  l_wa_fcat-icon      = on.
  APPEND l_wa_fcat TO lt_fcat.

  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname = 'MESSAGE'.
  l_wa_fcat-inttype   = 'C'.
  l_wa_fcat-outputlen = 72.
  l_wa_fcat-reptext   = 'Meldungstext'(002).
  APPEND l_wa_fcat TO lt_fcat.

  CLEAR l_wa_fcat.
  l_wa_fcat-fieldname = 'LTEXT_GRID'.
  l_wa_fcat-inttype   = 'C'.
  l_wa_fcat-outputlen = 3.
  l_wa_fcat-reptext   = 'Langtext'(003).
  l_wa_fcat-icon      = on.
  l_wa_fcat-hotspot   = on.
  APPEND l_wa_fcat TO lt_fcat.

* Das grundsätzliche Layout setzen
  CLEAR l_layout.
*  l_layout-grid_title = 'Anzeige der Meldungen'(004).
* Michael Manoch, 02.05.2007   START
* For accessibility reasons we have to display a title if a caption is specified.
  IF i_caption IS NOT INITIAL.
    l_layout-grid_title = i_caption.
    l_layout-smalltitle = on.
  ENDIF.
* Michael Manoch, 02.05.2007   END
  l_layout-sgl_clk_hd = on.
  l_layout-sel_mode   = 'B'.
  l_layout-no_rowmark = off.
  l_layout-no_totline = on.
  l_layout-cwidth_opt = on.

* Einige Funktionen des Toolbars excluden
  REFRESH lt_tbar_excl.
  l_wa_tbar = cl_gui_alv_grid=>mc_fc_detail.
  APPEND l_wa_tbar TO lt_tbar_excl.
  l_wa_tbar = cl_gui_alv_grid=>mc_fc_sum.
  APPEND l_wa_tbar TO lt_tbar_excl.
  l_wa_tbar = cl_gui_alv_grid=>mc_fc_subtot.
  APPEND l_wa_tbar TO lt_tbar_excl.
  l_wa_tbar = cl_gui_alv_grid=>mc_fc_graph.
  APPEND l_wa_tbar TO lt_tbar_excl.

  CALL METHOD c_msg_grid->set_table_for_first_display
    EXPORTING
*      i_bypassing_buffer = l_bypassing_buffer              " Rz
*     I_BUFFER_ACTIVE               =
*     I_STRUCTURE_NAME              =
*     IS_VARIANT                    =
*     I_SAVE                        =
*     I_DEFAULT                     = 'X'
      is_layout                     = l_layout
*     IS_PRINT                      =
*     IT_SPECIAL_GROUPS             =
      it_toolbar_excluding          = lt_tbar_excl
*     IT_HYPERLINK                  =
*     IT_ALV_GRAPHICS               =
    CHANGING
      it_outtab                     = ct_msg_grid
      it_fieldcatalog               = lt_fcat
*     IT_SORT                       =
*     IT_FILTER                     =
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.
  IF sy-subrc <> 0.
*   Schwerer Fehler & bei & aufgetreten
    MESSAGE x219(nf1) WITH sy-subrc
                      'SET_TABLE_FOR_FIRST_DISPLAY'.        "#EC NOTEXT
  ENDIF.
ENDMETHOD.


METHOD get_error.

* definitions
  DATA: lt_msg          TYPE ishmed_t_messages.
  FIELD-SYMBOLS:
        <ls_msg>        LIKE LINE OF lt_msg.

* initialize
  e_rc = 0.
  CLEAR: et_msg.

  lt_msg = get_messages_with_error( i_error_class_type ).

* check if error is inherited
  LOOP AT lt_msg ASSIGNING <ls_msg>.
    IF <ls_msg>-error_obj->is_error( i_error ) = on.
      APPEND <ls_msg> TO et_msg.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD get_error_derived_from.

* definitions
  DATA: lt_msg          TYPE ishmed_t_messages.
  FIELD-SYMBOLS:
        <ls_msg>        LIKE LINE OF lt_msg.

* initialize
  e_rc = 0.
  CLEAR: et_msg.

  lt_msg = get_messages_with_error( i_error_class_type ).

* check if error is inherited
  LOOP AT lt_msg ASSIGNING <ls_msg>.
    IF <ls_msg>-error_obj->is_error_derived_from( i_error ) = on.
      APPEND <ls_msg> TO et_msg.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD get_error_inherited_from.

* definitions
  DATA: lt_msg          TYPE ishmed_t_messages.
  FIELD-SYMBOLS:
        <ls_msg>        LIKE LINE OF lt_msg.

* initialize
  e_rc = 0.
  CLEAR: et_msg.

  lt_msg = get_messages_with_error( i_error_class_type ).

* check if error is inherited
  LOOP AT lt_msg ASSIGNING <ls_msg>.
    IF <ls_msg>-error_obj->is_error_inherited_from( i_error ) = on.
      APPEND <ls_msg> TO et_msg.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD get_max_errortype.
*......................................................................*
  DATA: l_max_errortype TYPE text15,
*       Fichte, Nr 6618: Neues Format von G_T_MESSAGES beachten
*        wa_messages     type bapiret2.
        wa_messages     TYPE rn1message.
*......................................................................*
  CLEAR l_max_errortype.

* den höchsten Fehlertypen ermitteln, um ihn dem Event mitzugeben
* 'X' = Exit mit Kurzdump
  READ TABLE g_t_messages INTO wa_messages WITH KEY type = 'X'.
  IF sy-subrc = 0.
    l_max_errortype = wa_messages-type.
  ELSE.
*  'A' = Abbruch
    READ TABLE g_t_messages INTO wa_messages WITH KEY type = 'A'.
    IF sy-subrc = 0.
      l_max_errortype = wa_messages-type.
    ELSE.
*    'E' = Fehler
      READ TABLE g_t_messages INTO wa_messages WITH KEY type = 'E'.
      IF sy-subrc = 0.
        l_max_errortype = wa_messages-type.
      ELSE.
*      'W' = Warnung
        READ TABLE g_t_messages INTO wa_messages WITH KEY type = 'W'.
        IF sy-subrc = 0.
          l_max_errortype = wa_messages-type.
        ELSE.
*        'I' = Information
          READ TABLE g_t_messages INTO wa_messages WITH KEY type = 'I'.
          IF sy-subrc = 0.
            l_max_errortype = wa_messages-type.
          ELSE.
*          'S' = Status
           READ TABLE g_t_messages INTO wa_messages WITH KEY type = 'S'.
            IF sy-subrc = 0.
              l_max_errortype = wa_messages-type.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

  e_max_errortype = l_max_errortype.

* Michael Manoch, 17.02.2005   START
* New parameter e_maxty.
  e_maxty = l_max_errortype.
* Michael Manoch, 17.02.2005   END

ENDMETHOD.


METHOD get_messages.
*......................................................................*
*  data: l_t_mesg        type tsmesg,
*        wa_mesg         type smesg,
*        l_t_messages    type ishmed_t_bapiret2,
*        wa_messages     type bapiret2.
*......................................................................*

* Schwingenschlögl Marina:
* MESSAGES_GIVE ist hier nicht verwendbar (nicht instanzübergreifend
* möglich

* in der globalen Tabelle stehen ja eh alle gesammelten drin, die
* doppelten werden auch immer rausgefiltert - also 1:1 retour damit

* Fichte, Nr 6618: Neues Format der G_T_MESSAGES beachten
*  t_messages[] = g_t_messages[].
  t_extended_msg[] = g_t_messages[].

  CALL METHOD cl_ishmed_errorhandling=>rn1message_to_bapiret2
    EXPORTING
      it_rn1message = g_t_messages
    IMPORTING
      et_bapiret2   = t_messages.

  CALL METHOD cl_ishmed_errorhandling=>rn1message_to_ws_msg
    EXPORTING
      it_rn1message = g_t_messages
    IMPORTING
      et_ws_msg     = t_ws_messages.

* Michael Manoch, 17.02.2005   START
* Return the max errortype.
* New parameter e_maxty.
  IF e_max_errortype IS SUPPLIED OR
     e_maxty         IS SUPPLIED.
    CALL METHOD get_max_errortype
      IMPORTING
        e_max_errortype = e_max_errortype
        e_maxty         = e_maxty.
  ENDIF.
* Michael Manoch, 17.02.2005   END

ENDMETHOD.


METHOD get_messages_with_error.

* definitions
  FIELD-SYMBOLS:
        <ls_msg>              LIKE LINE OF rt_msg.

  rt_msg = g_t_messages.

* remove messages without error description
  DELETE rt_msg WHERE error_obj IS INITIAL.

* return only messages with given object type for error class
  IF NOT i_error_class_type IS INITIAL.
    LOOP AT rt_msg ASSIGNING <ls_msg>.
      IF <ls_msg>-error_obj->is_inherited_from(
                                  i_error_class_type ) = off.
        DELETE rt_msg.
      ENDIF.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD handle_close_msg_container.
** Fichte, 5.10.01: Hier das Popup NICHT zerstören, sondern nur
** auf unsichtbar setzen. Grund: Wird das Popup, d.h. der
** Dialogbox-Container zerstört und irgendwann später neu aufgebaut,
** hat er seine Position, an die ihn vielleicht der Benutzer
** geschoben hat, verloren. Das nervt, denn der Benutzer muss nun
** erneut das Popup an die von ihm gewollte Popup verschieben.
*  CALL METHOD cl_ishmed_errorhandling=>set_visible
*    EXPORTING
*      i_visible    = off
*      I_CLEAR_GRID = ON.
  IF g_popup_static = on.
    CALL METHOD cl_ishmed_errorhandling=>destroy_amodal_popup.
  ELSE.
    CALL METHOD me->destroy_amodal_popup_inst.
  ENDIF.

* Michael Manoch, 12.05.2009   START
* Raise event message_function to publish closing.
  RAISE EVENT message_function
    EXPORTING
      e_ucomm = 'MSG_CLOSED'.
* Michael Manoch, 12.05.2009   END

ENDMETHOD.


method HANDLE_DOUBLE_CLICK_MSG_GRID.
  data: l_wa_msg_grid type rn1msg_grid,
        l_message     type RN1MESSAGE.

* Einfach die angeklickte Zeile ermitteln
  if g_popup_static = on.
    read table gt_msg_grid_static into l_wa_msg_grid
                                  index e_row-index.
  else.
    read table gt_msg_grid into l_wa_msg_grid
                           index e_row-index.
  endif.
  check sy-subrc = 0.

* Und diese Zeile dem Aufrufer per Exception übergeben
  move-corresponding l_wa_msg_grid to l_message.
  RAISE EVENT MESSAGE_CLICK
    EXPORTING
      E_MESSAGE = l_message.
endmethod.


METHOD handle_hotspot_click_msg_grid.
  DATA: l_wa_msg_grid TYPE rn1msg_grid,
        l_textobject  TYPE dokil-object,
        l_dokname     TYPE dokil-object,
*        l_dokname     type DSYSH-DOKNAME,
*       Fichte, MED-30906 - Begin
        lr_cb_errhdl  TYPE REF TO if_ish_cb_errhdl,
        ls_rn1message TYPE rn1message,
        l_flag        TYPE c,
*       Fichte, MED-30906 - End
        lt_links      TYPE STANDARD TABLE OF tline.

* Fichte, MED-30906: Call CallBack object if supplied
  IF g_popup_static = on.
    READ TABLE gt_msg_grid_static INTO l_wa_msg_grid
                                  INDEX e_row_id-index.
  ELSE.
    READ TABLE gt_msg_grid INTO l_wa_msg_grid
                            INDEX e_row_id-index.
  ENDIF.
  CHECK sy-subrc = 0.

  IF l_wa_msg_grid-error_obj IS NOT INITIAL.
    CLEAR: lr_cb_errhdl.
    TRY.
      lr_cb_errhdl ?= l_wa_msg_grid-error_obj.
      CATCH cx_root.
        CLEAR: lr_cb_errhdl.
    ENDTRY.

    IF lr_cb_errhdl IS NOT INITIAL.
      MOVE-CORRESPONDING l_wa_msg_grid TO ls_rn1message.
      CALL METHOD lr_cb_errhdl->hotspot_click
        EXPORTING
          is_message     = ls_rn1message
        IMPORTING
          e_dont_proceed = l_flag.

*     proceed or not?
      CHECK l_flag <> 'X'.
    ENDIF.
  ENDIF.   " IF l_wa_msg_grid-error_obj IS NOT INITIAL.
* Fichte, MED-30906 - End

  CASE e_column_id-fieldname.
*   Langtext
    WHEN 'LTEXT_GRID'.
*     Fichte, MED-30906: This has been made above
*      IF g_popup_static = on.
*        READ TABLE gt_msg_grid_static INTO l_wa_msg_grid
*                                      INDEX e_row_id-index.
*      ELSE.
*        READ TABLE gt_msg_grid INTO l_wa_msg_grid
*                               INDEX e_row_id-index.
*      ENDIF.
*      CHECK sy-subrc = 0.
*     Fichte, MED-30906 - End
      CALL FUNCTION 'DOCU_OBJECT_NAME_CONCATENATE'
        EXPORTING
          docu_id  = 'NA'
          element  = l_wa_msg_grid-id
          addition = l_wa_msg_grid-number
        IMPORTING
          object   = l_textobject.
      REFRESH lt_links.
      l_dokname = l_textobject.
      CALL FUNCTION 'HELP_OBJECT_SHOW'
        EXPORTING
          dokclass                            = 'NA'
*         DOKLANGU                            = SY-LANGU
          dokname                             = l_dokname
*         DOKTITLE                            = ' '
          msg_var_1                           = l_wa_msg_grid-message_v1
          msg_var_2                           = l_wa_msg_grid-message_v2
          msg_var_3                           = l_wa_msg_grid-message_v3
          msg_var_4                           = l_wa_msg_grid-message_v4
        TABLES
          links                               = lt_links
        EXCEPTIONS
          object_not_found                    = 1
          sapscript_error                     = 2
          OTHERS                              = 3.

    WHEN OTHERS.
*     Noch kein Coding
  ENDCASE.
ENDMETHOD.


METHOD handle_toolbar_msg_grid.
  DATA: l_toolbar     TYPE stb_button,
        l_wa_msg      TYPE rn1message,
        l_wa_func     TYPE rn1func.
  DATA: l_cnt_abort   TYPE i,
        l_cnt_error   TYPE i,
        l_cnt_warning TYPE i,
        l_cnt_info    TYPE i,
        l_text(3)     TYPE c.
  DATA: lt_msg        TYPE STANDARD TABLE OF rn1message.
  FIELD-SYMBOLS: <lfs_msg_buttons> TYPE char10.

* Zuerst die einzelnen Fehlertypen zählen
  REFRESH lt_msg.
  IF g_popup_static = on.
    lt_msg[] = gt_save_msg_static[].
    ASSIGN g_msg_buttons_static TO <lfs_msg_buttons>.
  ELSE.
    lt_msg[] = gt_save_msg[].
    ASSIGN g_msg_buttons TO <lfs_msg_buttons>.
  ENDIF.

  CLEAR: l_cnt_abort,
         l_cnt_error,
         l_cnt_warning,
         l_cnt_info.
* Führer, ID. 12925 1.9.03
* only delete double messages if necessary (check global
* attribute "g_show_double_msg")
  IF g_show_double_msg = off.
    SORT lt_msg BY type id number message_v1 message_v2
                   message_v3 message_v4.
    DELETE ADJACENT DUPLICATES FROM lt_msg
                    COMPARING type id number message_v1 message_v2
                              message_v3 message_v4.
  ENDIF.
  LOOP AT lt_msg INTO l_wa_msg.
    CASE l_wa_msg-type.
      WHEN 'A'.
        l_cnt_abort = l_cnt_abort + 1.
      WHEN 'E'.
        l_cnt_error = l_cnt_error + 1.
      WHEN 'W'.
        l_cnt_warning = l_cnt_warning + 1.
      WHEN OTHERS.
        l_cnt_info = l_cnt_info + 1.
    ENDCASE.
  ENDLOOP.

* Nun - sofern es Meldungen des entsprechenden Typs (d.h.
* z.B Abbruchmeldungen) gibt, einen entsprechenden Button
* mit dem Zählwert als Text anlegen bzw. wenn es diesen Button
* schon gibt, den Zählwert ändern

* Abbruch-Meldungen
  IF l_cnt_abort < 1.
    DELETE e_object->mt_toolbar WHERE function = 'ABORT'.
  ELSE.
    l_text = l_cnt_abort.
    LOOP AT e_object->mt_toolbar INTO l_toolbar
            WHERE function = 'ABORT'.
      l_toolbar-text    = l_text.
      IF <lfs_msg_buttons>(1) = on.
        l_toolbar-checked = off.
      ELSE.
        l_toolbar-checked = on.
      ENDIF.
      MODIFY e_object->mt_toolbar FROM l_toolbar.
    ENDLOOP.
    IF sy-subrc <> 0.
      CLEAR l_toolbar.
      l_toolbar-function   = 'ABORT'.
      l_toolbar-icon       = icon_message_critical_small.
      l_toolbar-text       = l_text.
      l_toolbar-quickinfo  = 'Abbruch'(004).
      l_toolbar-disabled   = space.
      IF <lfs_msg_buttons>(1) = on.
        l_toolbar-checked = off.
      ELSE.
        l_toolbar-checked = on.
      ENDIF.
      APPEND l_toolbar TO e_object->mt_toolbar.
    ENDIF.
  ENDIF.

* Fehlermeldungen
  IF l_cnt_error < 1.
    DELETE e_object->mt_toolbar WHERE function = 'ERROR'.
  ELSE.
    l_text = l_cnt_error.
    LOOP AT e_object->mt_toolbar INTO l_toolbar
            WHERE function = 'ERROR'.
      l_toolbar-text    = l_text.
      IF <lfs_msg_buttons>+1(1) = on.
        l_toolbar-checked = off.
      ELSE.
        l_toolbar-checked = on.
      ENDIF.
      MODIFY e_object->mt_toolbar FROM l_toolbar.
    ENDLOOP.
    IF sy-subrc <> 0.
      CLEAR l_toolbar.
      l_toolbar-function   = 'ERROR'.
      l_toolbar-icon       = icon_led_red.
      l_toolbar-text       = l_text.
      l_toolbar-quickinfo  = 'Fehler'(005).
      l_toolbar-disabled   = space.
      IF <lfs_msg_buttons>+1(1) = on.
        l_toolbar-checked = off.
      ELSE.
        l_toolbar-checked = on.
      ENDIF.
      APPEND l_toolbar TO e_object->mt_toolbar.
    ENDIF.
  ENDIF.

* Warnungen
  IF l_cnt_warning < 1.
    DELETE e_object->mt_toolbar WHERE function = 'WARNING'.
  ELSE.
    l_text = l_cnt_warning.
    LOOP AT e_object->mt_toolbar INTO l_toolbar
            WHERE function = 'WARNING'.
      l_toolbar-text    = l_text.
      IF <lfs_msg_buttons>+2(1) = on.
        l_toolbar-checked = off.
      ELSE.
        l_toolbar-checked = on.
      ENDIF.
      MODIFY e_object->mt_toolbar FROM l_toolbar.
    ENDLOOP.
    IF sy-subrc <> 0.
      CLEAR l_toolbar.
      l_toolbar-function   = 'WARNING'.
      l_toolbar-icon       = icon_led_yellow.
      l_toolbar-text       = l_text.
      l_toolbar-quickinfo  = 'Warnung'(006).
      l_toolbar-disabled   = space.
      IF <lfs_msg_buttons>+2(1) = on.
        l_toolbar-checked = off.
      ELSE.
        l_toolbar-checked = on.
      ENDIF.
      APPEND l_toolbar TO e_object->mt_toolbar.
    ENDIF.
  ENDIF.

* Info
  IF l_cnt_info < 1.
    DELETE e_object->mt_toolbar WHERE function = 'INFO'.
  ELSE.
    l_text = l_cnt_info.
    LOOP AT e_object->mt_toolbar INTO l_toolbar
            WHERE function = 'INFO'.
      l_toolbar-text    = l_text.
      IF <lfs_msg_buttons>+3(1) = on.
        l_toolbar-checked = off.
      ELSE.
        l_toolbar-checked = on.
      ENDIF.
      MODIFY e_object->mt_toolbar FROM l_toolbar.
    ENDLOOP.
    IF sy-subrc <> 0.
      CLEAR l_toolbar.
      l_toolbar-function   = 'INFO'.
      l_toolbar-icon       = icon_led_green.
      l_toolbar-text       = l_text.
      l_toolbar-quickinfo  = 'Information'(007).
      l_toolbar-disabled   = space.
      IF <lfs_msg_buttons>+3(1) = on.
        l_toolbar-checked = off.
      ELSE.
        l_toolbar-checked = on.
      ENDIF.
      APPEND l_toolbar TO e_object->mt_toolbar.
    ENDIF.
  ENDIF.

* Wurde kein schwerer Fehler, d.h. Abbruch oder Error ausgegeben,
* so wird im Popup ein Weiter-Button eingeblendet, der beim
* Drücken den Event "Message_Function" auslöst
  IF l_cnt_abort < 1  AND  l_cnt_error < 1.
    CLEAR l_toolbar.
    l_toolbar-function  = 'MSG_ENTER'.
    l_toolbar-icon      = icon_okay.
*    l_toolbar-text      =
    l_toolbar-quickinfo = 'Warnungen ignorieren'(008).
    l_toolbar-disabled  = space.
    INSERT l_toolbar INTO e_object->mt_toolbar INDEX 1.
  ENDIF.   " if l_cnt_abort < 1  and  l_cnt_error < 1

* Führer, ID. 9656 (42): Abbrechen-Button aufnehmen
*  CLEAR l_toolbar.
*  l_toolbar-butn_type = cntb_btype_sep.
*  APPEND l_toolbar TO e_object->mt_toolbar.
*
*  CLEAR l_toolbar.
*  l_toolbar-function   = 'CANC'.
*  l_toolbar-icon       = icon_cancel.
** l_toolbar-text       = l_text.
*  l_toolbar-quickinfo  = 'Abbrechen'(009).
*  l_toolbar-disabled   = space.
*  APPEND l_toolbar TO e_object->mt_toolbar.

ENDMETHOD.


METHOD handle_user_comm_msg_grid.
  FIELD-SYMBOLS: <lfs_msg_buttons> TYPE char10.

  IF g_popup_static = on.
    ASSIGN g_msg_buttons_static TO <lfs_msg_buttons>.
  ELSE.
    ASSIGN g_msg_buttons TO <lfs_msg_buttons>.
  ENDIF.
  CASE e_ucomm.
*   Abbruch-Button
    WHEN 'ABORT'.
      IF <lfs_msg_buttons>(1) = space.
        <lfs_msg_buttons>(1) = on.
      ELSE.
        <lfs_msg_buttons>(1) = space.
      ENDIF.

*   Fehler-Button
    WHEN 'ERROR'.
      IF <lfs_msg_buttons>+1(1) = space.
        <lfs_msg_buttons>+1(1) = on.
      ELSE.
        <lfs_msg_buttons>+1(1) = space.
      ENDIF.

*   Warnung-Button
    WHEN 'WARNING'.
      IF <lfs_msg_buttons>+2(1) = space.
        <lfs_msg_buttons>+2(1) = on.
      ELSE.
        <lfs_msg_buttons>+2(1) = space.
      ENDIF.

*   Information
    WHEN 'INFO'.
      IF <lfs_msg_buttons>+3(1) = space.
        <lfs_msg_buttons>+3(1) = on.
      ELSE.
        <lfs_msg_buttons>+3(1) = space.
      ENDIF.

*   Weiter-Button
    WHEN 'MSG_ENTER'.
      RAISE EVENT message_function
        EXPORTING
          e_ucomm = e_ucomm.

*   Abbrechen (ID. 9656, 42)
    WHEN 'CANC'.
      IF g_popup_static = on.
        CALL METHOD cl_ishmed_errorhandling=>destroy_amodal_popup.
      ELSE.
        CALL METHOD me->destroy_amodal_popup_inst.
      ENDIF.

  ENDCASE.   " case e_ucomm

  IF e_ucomm <> 'CANC'.                                     " ID. 9656
*   Auch das Grid muss neu aufgebaut werden
    IF g_popup_static = on.
      CALL METHOD me->refresh_messages
*       Führer, ID. 12925 1.9.03 - begin
*       at "display_messages" the global attribute "g_show_double_msg"
*       is set; now give this information to "refresh_messages" so
*       that it is possible to fade in double messages
        EXPORTING
           i_show_double_msg = g_show_double_msg
*       Führer, ID. 12925 1.9.03 - end
*        Keine Tabelle mitnehmen. Die Methode holt sich dann die
*        Daten aus der Sicherungstabelle GT_MESSAGES
*        exporting
*          it_messages =
        IMPORTING
          et_msg_grid = gt_msg_grid_static.
      CALL METHOD g_msg_grid_static->refresh_table_display.
*     Den Toolbar nun neu aufbauen
      CALL METHOD g_msg_grid_static->set_toolbar_interactive.
    ELSE.
      CALL METHOD me->refresh_messages
*       Führer, ID. 12925 1.9.03 - begin
*       at "display_messages" the global attribute "g_show_double_msg"
*       is set; now give this information to "refresh_messages" so
*       that it is possible to fade in double messages
        EXPORTING
           i_show_double_msg = g_show_double_msg
*       Führer, ID. 12925 1.9.03 - end
*        Keine Tabelle mitnehmen. Die Methode holt sich dann die
*        Daten aus der Sicherungstabelle GT_MESSAGES
*        exporting
*          it_messages =
        IMPORTING
          et_msg_grid = gt_msg_grid.
**** Start: MED-47677 M.Rebegea 18.06.2012
      CHECK g_msg_grid IS BOUND.
**** End: MED-47677 M.Rebegea 18.06.2012

      CALL METHOD g_msg_grid->refresh_table_display.
*     Den Toolbar nun neu aufbauen
      CALL METHOD g_msg_grid->set_toolbar_interactive.
    ENDIF.
  ENDIF.

ENDMETHOD.


  METHOD HAS_ERROR_BASED_ON_ERRORTYPE.

*  Führer, IXX-5753 18.08.2016
*  new method to determine if the errorhandler has any error, this
*  means any dump, abort, error or warning message. Warnings are only
*  considered if wished (see i_consider_warnings).

    DATA: l_maxty TYPE ish_bapiretmaxty.

    CALL METHOD me->get_max_errortype
      IMPORTING
        e_maxty = l_maxty.

*   initialize
    r_has_error = abap_false.

    IF l_maxty = 'X' OR
       l_maxty = 'A' OR
       l_maxty = 'E'.
      r_has_error = abap_true.
      RETURN.
    ENDIF.

    IF i_consider_warnings = abap_true AND l_maxty = 'W'.
      r_has_error = abap_true.
    ENDIF.

  ENDMETHOD.


method IGNORE_WARNINGS.
  data: lt_msg type ishmed_t_messages,
        l_msg  type rn1message.

  check not c_errorhandler is initial.

  refresh lt_msg.
  CALL METHOD c_errorhandler->get_messages
    IMPORTING
      T_EXTENDED_MSG  = lt_msg.
* Alle Messages mit Errortyp <= 'W' entfernen
  delete lt_msg where type cn 'EA'.

* Die Messages ohne Warnings usw. jetzt wieder in den Handler
* hineinstellen
  CALL METHOD c_errorhandler->initialize.
  if lt_msg[] is initial.
*   Keine Meldungen mehr übrig => Es waren nur harmlose Messages
*   (Warnungen, Infos) im Handler => RC darf = 0 gesetzt werden
    c_rc = 0.
    exit.
  endif.
  CALL METHOD c_errorhandler->collect_messages
    EXPORTING
      T_MESSAGES      = lt_msg
      I_LAST          = space.
endmethod.


METHOD initialize.

  CLEAR: g_t_messages[].

* Auch hier bei statischer Betriebsart das statische Msg-Popup
* schließen
  IF g_popup_static = on.
    CALL METHOD cl_ishmed_errorhandling=>destroy_amodal_popup.
  ELSE.
    CALL METHOD me->destroy_amodal_popup_inst.
  ENDIF.

ENDMETHOD.


METHOD is_error.

* definitions
  DATA: lt_msg          TYPE ishmed_t_messages.
  FIELD-SYMBOLS:
        <ls_msg>        LIKE LINE OF lt_msg.

* initialize
  r_is = off.

  lt_msg = get_messages_with_error( i_error_class_type ).

* check if error is inherited
  LOOP AT lt_msg ASSIGNING <ls_msg>.
    IF <ls_msg>-error_obj->is_error( i_error ) = on.
      r_is = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD is_error_derived_from.

* definitions
  DATA: lt_msg          TYPE ishmed_t_messages.
  FIELD-SYMBOLS:
        <ls_msg>        LIKE LINE OF lt_msg.

* initialize
  r_is = off.

  lt_msg = get_messages_with_error( i_error_class_type ).

* check if error is inherited
  LOOP AT lt_msg ASSIGNING <ls_msg>.
    IF <ls_msg>-error_obj->is_error_derived_from( i_error ) = on.
      r_is = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD is_error_inherited_from.

* definitions
  DATA: lt_msg          TYPE ishmed_t_messages.
  FIELD-SYMBOLS:
        <ls_msg>        LIKE LINE OF lt_msg.

* initialize
  r_is = off.

  lt_msg = get_messages_with_error( i_error_class_type ).

* check if error is inherited
  LOOP AT lt_msg ASSIGNING <ls_msg>.
    IF <ls_msg>-error_obj->is_error_inherited_from( i_error ) = on.
      r_is = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD refresh_messages.
  DATA: l_wa_msg_grid TYPE rn1msg_grid,
        lt_messages   TYPE ishmed_t_messages,
        l_bapiret2    TYPE bapiret2,      " Fichte, Nr 9160
        l_wa_msg      TYPE rn1message.
  DATA: l_t100          TYPE t100,
        l_iconname(200) TYPE c,
        l_qinfo         TYPE icont-quickinfo.
* Fichte, 26.3.02: Message-Variablen, damit Integer-Werte schöner
* ausgegeben werden
  DATA: l_msgv1 TYPE bapiret2-message_v1,
        l_msgv2 TYPE bapiret2-message_v2,
        l_msgv3 TYPE bapiret2-message_v3,
        l_msgv4 TYPE bapiret2-message_v4.
  FIELD-SYMBOLS: <lfs_msg_buttons> TYPE char10.

* Ist die übergebene Tabelle leer, muss die Sicherungstabelle
* genommen werden
* Unterscheiden, ob der Errorhandler mit statischem Popup
* arbeitet oder nicht
  IF g_popup_static = on.
    IF it_messages[] IS INITIAL.
      lt_messages[] = gt_save_msg_static[].
    ELSE.
      lt_messages[] = it_messages[].
*     Sicherungstabelle mit den übergebenen Werten neu befüllen
      gt_save_msg_static[] = it_messages[].
    ENDIF.
    ASSIGN g_msg_buttons_static TO <lfs_msg_buttons>.
  ELSE.
    IF it_messages[] IS INITIAL.
      lt_messages[] = gt_save_msg[].
    ELSE.
      lt_messages[] = it_messages[].
*     Sicherungstabelle mit den übergebenen Werten neu befüllen
      gt_save_msg[] = it_messages[].
    ENDIF.
    ASSIGN g_msg_buttons TO <lfs_msg_buttons>.
  ENDIF.

  REFRESH et_msg_grid.
  LOOP AT lt_messages INTO l_wa_msg.
*   Messages, die mehrfach vorhanden sind nur genau einmal
*   anzeigen (sofern der Aufrufer das so haben möchte)
    IF i_show_double_msg = off.
      LOOP AT et_msg_grid TRANSPORTING NO FIELDS
                          WHERE type       = l_wa_msg-type
                          AND   id         = l_wa_msg-id
                          AND   number     = l_wa_msg-number
                          AND   message_v1 = l_wa_msg-message_v1
                          AND   message_v2 = l_wa_msg-message_v2
                          AND   message_v3 = l_wa_msg-message_v3
                          AND   message_v4 = l_wa_msg-message_v4.
        EXIT.
      ENDLOOP.
*     Nur weiter, wenn diese Message noch nicht existiert
      CHECK sy-subrc <> 0.
    ENDIF.

    CLEAR l_wa_msg_grid.
    MOVE-CORRESPONDING l_wa_msg TO l_wa_msg_grid.

    CASE l_wa_msg-type.
      WHEN 'A'.
        l_iconname = icon_message_critical_small.
        l_qinfo    = 'Abbruch'(004).
*       Soll dieser Messagetyp überhaupt angezeigt werden?
        CHECK <lfs_msg_buttons>(1) = space.

      WHEN 'E'.
        l_iconname = icon_led_red.
        l_qinfo    = 'Fehler'(005).
        CHECK <lfs_msg_buttons>+1(1) = space.

      WHEN 'W'.
        l_iconname = icon_led_yellow.
        l_qinfo    = 'Warnung'(006).
        CHECK <lfs_msg_buttons>+2(1) = space.

      WHEN OTHERS.
        l_iconname = icon_led_green.
        l_qinfo    = 'Information'(007).
        CHECK <lfs_msg_buttons>+3(1) = space.
    ENDCASE.
    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name       = l_iconname
        info       = l_qinfo
        add_stdinf = 'X'
      IMPORTING
        result     = l_wa_msg_grid-type_grid
      EXCEPTIONS
        OTHERS     = 3.
    IF sy-subrc <> 0.
      l_wa_msg_grid-type_grid = l_qinfo.
    ENDIF.

*   Messagetext zusammenstellen
*   Fichte, 26.3.02: Messagevariablen schöner ausgeben
    l_msgv1 = l_wa_msg-message_v1.
    CONDENSE l_msgv1.
    l_msgv2 = l_wa_msg-message_v2.
    CONDENSE l_msgv2.
    l_msgv3 = l_wa_msg-message_v3.
    CONDENSE l_msgv3.
    l_msgv4 = l_wa_msg-message_v4.
    CONDENSE l_msgv4.

*   Fichte, Nr 9160, 6: Messagetext in der richtigen Reihenfolge
*   zusammenstellen
    CLEAR l_bapiret2.
    IF l_wa_msg-id IS NOT INITIAL AND l_wa_msg-number IS NOT INITIAL."MED-53050 Cristina Geanta
      CALL FUNCTION 'ISH_BAPI_FILL_RETURN_PARAM'
        EXPORTING
          msgty     = l_wa_msg-type
          msgid     = l_wa_msg-id
          msgno     = l_wa_msg-number
          msgv1     = l_msgv1
          msgv2     = l_msgv2
          msgv3     = l_msgv3
          msgv4     = l_msgv4
          parameter = l_wa_msg-parameter
          field     = l_wa_msg-field
        IMPORTING
          return    = l_bapiret2.
      l_wa_msg-message = l_bapiret2-message.
      l_wa_msg-system  = l_bapiret2-system.
      l_wa_msg_grid-message = l_bapiret2-message."MED-53050 Cristina Geanta
      l_wa_msg_grid-system  = l_bapiret2-system. "MED-53050 Cristina Geanta
    ENDIF."MED-53050 Cristina Geanta
*   Fichte, Nr 9160 - Ende

*   Icon für Langtext setzen
    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name       = icon_system_help
        info       = 'Langtext'(003)
        add_stdinf = 'X'
      IMPORTING
        result     = l_wa_msg_grid-ltext_grid
      EXCEPTIONS
        OTHERS     = 3.
    IF sy-subrc <> 0.
      l_wa_msg_grid-ltext_grid = 'Langtext'(003).
    ENDIF.

    APPEND l_wa_msg_grid TO et_msg_grid.
  ENDLOOP.   " loop at it_messages into l_wa_msg
ENDMETHOD.


method RN1MESSAGE_TO_BAPIRET2.
  data: l_wa_msg      type rn1message,
        l_wa_bapiret2 type bapiret2.

  refresh et_bapiret2.
  loop at it_rn1message into l_wa_msg.
    move-corresponding l_wa_msg to l_wa_bapiret2.
    append l_wa_bapiret2 to et_bapiret2.
  endloop.
endmethod.


METHOD rn1message_to_ws_msg.
  DATA: l_wa_msg      TYPE rn1message,
        l_wa_ws_msg   TYPE n1ws_msg.

  REFRESH et_ws_msg.
  LOOP AT it_rn1message INTO l_wa_msg WHERE type = 'E'.
    l_wa_ws_msg-message_class_id = l_wa_msg-id.
    l_wa_ws_msg-message_number = l_wa_msg-number.
    l_wa_ws_msg-message_text = l_wa_msg-message.
    APPEND l_wa_ws_msg TO et_ws_msg.
  ENDLOOP.
ENDMETHOD.


method SET_VISIBLE.
  check not g_msg_container_static is initial.

  CALL METHOD g_msg_container_static->set_visible
    EXPORTING
      visible           = i_visible
    EXCEPTIONS
      CNTL_ERROR        = 1
      CNTL_SYSTEM_ERROR = 2
      others            = 3.
  IF sy-subrc > 0.              " MED-52902
    RETURN.                     " MED-52902
  ENDIF.                        " MED-52902

  IF i_clear_grid = on  AND  i_visible = off.
    refresh gt_msg_grid_static.
    CALL METHOD G_MSG_GRID_STATIC->REFRESH_TABLE_DISPLAY
*      EXPORTING
*        IS_STABLE      =
*        I_SOFT_REFRESH =
      EXCEPTIONS
        FINISHED       = 1
        others         = 2.
  endif.
endmethod.


METHOD switch_error_type.

* definitions
  DATA: l_all      TYPE ish_on_off,
        l_derived  TYPE ish_on_off.

* local tables
  DATA: lt_msg     TYPE ishmed_t_messages.

* workareas
  FIELD-SYMBOLS:
        <ls_msg>   TYPE rn1message.

* initialization
  l_all = on.
  e_rc = 0.

* get all messages
  CALL METHOD me->get_messages
    IMPORTING
      t_extended_msg = lt_msg.

* check for messages
  CHECK lt_msg IS NOT INITIAL.

* clear messages
  CALL METHOD me->initialize.

* only specific messages
  IF it_error_derived IS NOT INITIAL OR
     it_error_inherited IS NOT INITIAL.
    l_all = off.
  ENDIF.

* switch type of messages
  LOOP AT lt_msg ASSIGNING <ls_msg>.
    CLEAR: l_derived.
    IF l_all = off.
*     check for derived message
      CALL METHOD cl_ish_utl_base=>is_t_error_derived_from
        EXPORTING
          it_error_derived   = it_error_derived
          it_error_inherited = it_error_inherited
          ir_error_obj       = <ls_msg>-error_obj
        IMPORTING
          e_derived          = l_derived.
    ENDIF.
*   now switch type
    IF l_all = on OR l_derived = on.
      <ls_msg>-type = i_type.
    ENDIF.
  ENDLOOP.

* add messages
  CALL METHOD me->collect_messages
    EXPORTING
      t_messages = lt_msg
      i_last     = space.

ENDMETHOD.
ENDCLASS.
