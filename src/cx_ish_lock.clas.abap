class CX_ISH_LOCK definition
  public
  inheriting from CX_ISH_STATIC_HANDLER
  create public .

*"* public components of class CX_ISH_LOCK
*"* do not include other source files here!!!
public section.

  constants CX_ISH_LOCK type SOTR_CONC value '800B5DAFF3071DDBB3944633E5161952'. "#EC NOTEXT
  data G_LOCKOBJECT type STRING read-only value 'OBJECT'. "#EC NOTEXT .

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !GR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !GR_MSGTYP type SY-MSGTY default 'E'
      !G_LOCKOBJECT type STRING default 'OBJECT' .
protected section.
*"* protected components of class CX_ISH_LOCK
*"* do not include other source files here!!!
private section.
*"* private components of class CX_ISH_LOCK
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_ISH_LOCK IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
GR_ERRORHANDLER = GR_ERRORHANDLER
GR_MSGTYP = GR_MSGTYP
.
 IF textid IS INITIAL.
   me->textid = CX_ISH_LOCK .
 ENDIF.
me->G_LOCKOBJECT = G_LOCKOBJECT .
endmethod.
ENDCLASS.
