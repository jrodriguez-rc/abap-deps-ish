class CX_ISHMED_TC definition
  public
  inheriting from CX_ISH_STATIC_HANDLER
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  constants:
    begin of CX_ISHMED_TC,
      msgid type symsgid value 'N1TC',
      msgno type symsgno value '000',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CX_ISHMED_TC .
  constants:
    begin of NO_DELEGATION_POSSIBLE,
      msgid type symsgid value 'N1TC',
      msgno type symsgno value '001',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NO_DELEGATION_POSSIBLE .
  constants:
    begin of NO_REQUEST_POSSIBLE,
      msgid type symsgid value 'N1TC',
      msgno type symsgno value '002',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NO_REQUEST_POSSIBLE .
  data ATTR1 type SYMSGV .
  data ATTR2 type SYMSGV .
  data ATTR3 type SYMSGV .
  data ATTR4 type SYMSGV .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !GR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !GR_MSGTYP type SY-MSGTY default 'E'
      !ATTR1 type SYMSGV optional
      !ATTR2 type SYMSGV optional
      !ATTR3 type SYMSGV optional
      !ATTR4 type SYMSGV optional .
  methods DISPLAY_MESSAGES
    returning
      value(R_MAX_ERRORTYPE) type TEXT15 .
  methods SET_SY_MESSAGE .
protected section.

  methods COLLECT_MESSAGES
    importing
      !I_EXCEPTIONS type ref to CX_ROOT optional
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
private section.
ENDCLASS.



CLASS CX_ISHMED_TC IMPLEMENTATION.


METHOD COLLECT_MESSAGES.
  DATA lr_ish_exception  TYPE REF TO cx_ish_static_handler.
  DATA lr_ishmed_tc TYPE REF TO cx_ishmed_tc.
  DATA lr_message       TYPE REF TO if_t100_message.

* Preconditions............................................
  IF i_exceptions IS NOT BOUND.
    RETURN.
  ENDIF.

  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* get message from if_t100_message
  TRY.
      lr_message ?= i_exceptions.

    CATCH cx_sy_move_cast_error.
      FREE lr_message.
  ENDTRY.

* get message from cx_ish_static_handler derived classes
  TRY.
      lr_ish_exception ?= i_exceptions.
    CATCH cx_sy_move_cast_error.
      FREE lr_ish_exception.
  ENDTRY.

* get message from cx_ish_static_handler derived classes
  TRY.
      lr_ishmed_tc ?= i_exceptions.
    CATCH cx_sy_move_cast_error.
      FREE lr_ishmed_tc.
  ENDTRY.

  IF lr_message IS BOUND.
*** add T100 Exception:
    IF lr_ishmed_tc IS BOUND.
      cl_ish_utl_base=>collect_messages(
        EXPORTING
          i_typ           = lr_ishmed_tc->gr_msgtyp
          i_kla           = lr_message->t100key-msgid
          i_num           = lr_message->t100key-msgno
          i_mv1           = lr_ishmed_tc->attr1
          i_mv2           = lr_ishmed_tc->attr2
          i_mv3           = lr_ishmed_tc->attr3
          i_mv4           = lr_ishmed_tc->attr4
        CHANGING
          cr_errorhandler = cr_errorhandler ).

    ELSEIF lr_ish_exception IS BOUND.
      cl_ish_utl_base=>collect_messages(
      EXPORTING
        i_typ           = lr_ish_exception->gr_msgtyp
        i_kla           = lr_message->t100key-msgid
        i_num           = lr_message->t100key-msgno
        i_mv1           = lr_message->t100key-attr1
        i_mv2           = lr_message->t100key-attr2
        i_mv3           = lr_message->t100key-attr3
        i_mv4           = lr_message->t100key-attr4
      CHANGING
        cr_errorhandler = cr_errorhandler ).

    ELSE.
      cl_ish_utl_base=>collect_messages(
        EXPORTING
          i_typ           = 'E'
          i_kla           = lr_message->t100key-msgid
          i_num           = lr_message->t100key-msgno
          i_mv1           = lr_message->t100key-attr1
          i_mv2           = lr_message->t100key-attr2
          i_mv3           = lr_message->t100key-attr3
          i_mv4           = lr_message->t100key-attr4
        CHANGING
          cr_errorhandler = cr_errorhandler ).
    ENDIF.
  ENDIF.

** add messages from errorhandler
  IF lr_ish_exception IS BOUND.
    IF lr_ish_exception->gr_errorhandler IS BOUND.
      cr_errorhandler->copy_messages( i_copy_from = lr_ish_exception->gr_errorhandler ).
    ENDIF.
  ENDIF.

** process previous element
  IF i_exceptions->previous IS BOUND.
    collect_messages(
      EXPORTING
        i_exceptions    = i_exceptions->previous
      CHANGING
        cr_errorhandler = cr_errorhandler ).
  ENDIF.
ENDMETHOD.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
GR_ERRORHANDLER = GR_ERRORHANDLER
GR_MSGTYP = GR_MSGTYP
.
me->ATTR1 = ATTR1 .
me->ATTR2 = ATTR2 .
me->ATTR3 = ATTR3 .
me->ATTR4 = ATTR4 .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = CX_ISHMED_TC .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
endmethod.


METHOD DISPLAY_MESSAGES.
* Display collected exceptions..........
  me->collect_messages(
    EXPORTING
      i_exceptions    = me
    CHANGING
      cr_errorhandler = gr_errorhandler ).

  IF gr_errorhandler IS BOUND.
    gr_errorhandler->get_max_errortype(
      IMPORTING
           e_max_errortype = r_max_errortype ).

    gr_errorhandler->display_messages(
      i_send_if_one = abap_true
      i_control     = abap_true ).
  ENDIF.
ENDMETHOD.


method SET_SY_MESSAGE.
  if_t100_message~t100key-msgid = sy-msgid.
  if_t100_message~t100key-msgno = sy-msgno.
  if_t100_message~t100key-attr1 = sy-msgv1.
  if_t100_message~t100key-attr2 = sy-msgv2.
  if_t100_message~t100key-attr3 = sy-msgv3.
  if_t100_message~t100key-attr4 = sy-msgv4.
endmethod.
ENDCLASS.
