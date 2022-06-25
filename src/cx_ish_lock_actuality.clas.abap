class CX_ISH_LOCK_ACTUALITY definition
  public
  inheriting from CX_ISH_LOCK
  create public .

public section.
*"* public components of class CX_ISH_LOCK_ACTUALITY
*"* do not include other source files here!!!

  constants CX_ISH_LOCK_ACTUALITY type SOTR_CONC value '800B5DAFF3071DEBB394751DB5A001AF'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !GR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !GR_MSGTYP type SY-MSGTY default 'E'
      !G_LOCKOBJECT type STRING default 'OBJECT' .
protected section.
*"* protected components of class CX_ISH_LOCK_ACTUALITY
*"* do not include other source files here!!!
private section.
*"* private components of class CX_ISH_LOCK_ACTUALITY
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_ISH_LOCK_ACTUALITY IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
GR_ERRORHANDLER = GR_ERRORHANDLER
GR_MSGTYP = GR_MSGTYP
G_LOCKOBJECT = G_LOCKOBJECT
.
 IF textid IS INITIAL.
   me->textid = CX_ISH_LOCK_ACTUALITY .
 ENDIF.
endmethod.
ENDCLASS.
