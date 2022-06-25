class CX_ISH_FOREIGN_LOCK definition
  public
  inheriting from CX_ISH_LOCK
  create public .

public section.
*"* public components of class CX_ISH_FOREIGN_LOCK
*"* do not include other source files here!!!

  constants CX_ISH_FOREIGN_LOCK type SOTR_CONC value '800B5DAFF3071DDBB394689DA0CA4D7C'. "#EC NOTEXT
  data G_USERNAME type SY-UNAME read-only value 'USER'. "#EC NOTEXT .

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !GR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !GR_MSGTYP type SY-MSGTY default 'E'
      !G_LOCKOBJECT type STRING default 'OBJECT'
      !G_USERNAME type SY-UNAME default 'USER' .
protected section.
*"* protected components of class CX_ISH_FOREIGN_LOCK
*"* do not include other source files here!!!
private section.
*"* private components of class CX_ISH_FOREIGN_LOCK
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_ISH_FOREIGN_LOCK IMPLEMENTATION.


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
   me->textid = CX_ISH_FOREIGN_LOCK .
 ENDIF.
me->G_USERNAME = G_USERNAME .
endmethod.
ENDCLASS.
