class CX_ISH_FVAR definition
  public
  inheriting from CX_ISH_STATIC_HANDLER
  create public .

public section.
*"* public components of class CX_ISH_FVAR
*"* do not include other source files here!!!

  constants CX_ISH_FVAR type SOTR_CONC value '8003BABDB0C11DEB88A77A6E2E82501D'. "#EC NOTEXT
  data G_VIEWTYPE type NVIEWTYPE read-only .
  data G_FVARID type NFVARID read-only .

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !GR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !GR_MSGTYP type SY-MSGTY default 'E'
      !G_VIEWTYPE type NVIEWTYPE optional
      !G_FVARID type NFVARID optional .
protected section.
*"* protected components of class CX_ISH_FVAR
*"* do not include other source files here!!!
private section.
*"* private components of class CX_ISH_FVAR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_ISH_FVAR IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
GR_ERRORHANDLER = GR_ERRORHANDLER
GR_MSGTYP = GR_MSGTYP
.
 IF textid IS INITIAL.
   me->textid = CX_ISH_FVAR .
 ENDIF.
me->G_VIEWTYPE = G_VIEWTYPE .
me->G_FVARID = G_FVARID .
endmethod.
ENDCLASS.
