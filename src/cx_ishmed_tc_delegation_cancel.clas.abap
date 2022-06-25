class CX_ISHMED_TC_DELEGATION_CANCEL definition
  public
  inheriting from CX_ISHMED_TC
  final
  create public .

public section.

  constants:
    begin of CX_ISHMED_TC_DELEGATION_CANCEL,
      msgid type symsgid value 'N1TC',
      msgno type symsgno value '710',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CX_ISHMED_TC_DELEGATION_CANCEL .

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
protected section.
private section.
ENDCLASS.



CLASS CX_ISHMED_TC_DELEGATION_CANCEL IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
GR_ERRORHANDLER = GR_ERRORHANDLER
GR_MSGTYP = GR_MSGTYP
ATTR1 = ATTR1
ATTR2 = ATTR2
ATTR3 = ATTR3
ATTR4 = ATTR4
.
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = CX_ISHMED_TC_DELEGATION_CANCEL .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
endmethod.
ENDCLASS.
