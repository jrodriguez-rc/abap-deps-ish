class CX_ISH_STATIC_HANDLER definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

*"* public components of class CX_ISH_STATIC_HANDLER
*"* do not include other source files here!!!
public section.

  data GR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  data GR_MSGTYP type SY-MSGTY value 'E' ##NO_TEXT.

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !GR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !GR_MSGTYP type SY-MSGTY default 'E' .
  methods GET_ERRORHANDLER
    importing
      value(I_NO_DEFAULT_MSG) type ISH_ON_OFF default SPACE
    exporting
      !ER_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
protected section.
*"* protected components of class CX_ISH_STATIC_HANDLER
*"* do not include other source files here!!!
private section.
*"* private components of class CX_ISH_STATIC_HANDLER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_ISH_STATIC_HANDLER IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
.
me->GR_ERRORHANDLER = GR_ERRORHANDLER .
me->GR_MSGTYP = GR_MSGTYP .
  endmethod.


METHOD get_errorhandler .

* definitons
  DATA: l_rc          TYPE ish_method_rc,
        lt_msg        TYPE ishmed_t_messages.
* ---------- ---------- ----------
* initialize
  CLEAR: lt_msg, l_rc.
* ---------- ---------- ----------
* return global errorhandler
  er_errorhandler = gr_errorhandler.
* create instance for errorhandling if necessary
  IF er_errorhandler IS INITIAL.
    CREATE OBJECT er_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* check if errorhandler contains already messages
  IF i_no_default_msg = ' '.
    CALL METHOD er_errorhandler->get_messages
      IMPORTING
        t_extended_msg = lt_msg.
    IF lt_msg IS INITIAL.
*     only append message for exception if there aren't other messages
      CALL METHOD er_errorhandler->append_message_for_exception
        EXPORTING
          ir_exception = me
        IMPORTING
          e_rc         = l_rc.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
