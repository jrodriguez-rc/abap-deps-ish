class CX_ISH_GUI definition
  public
  inheriting from CX_ISH_STATIC_HANDLER
  create public .

public section.
*"* public components of class CX_ISH_GUI
*"* do not include other source files here!!!

  constants CX_ISH_GUI type SOTR_CONC value '801CC4454D9E1DDE8D9850240B8D9FE4'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !GR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !GR_MSGTYP type SY-MSGTY default 'E' .
protected section.
*"* protected components of class CX_ISH_GUI
*"* do not include other source files here!!!
private section.
*"* private components of class CX_ISH_GUI
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_ISH_GUI IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
GR_ERRORHANDLER = GR_ERRORHANDLER
GR_MSGTYP = GR_MSGTYP
.
 IF textid IS INITIAL.
   me->textid = CX_ISH_GUI .
 ENDIF.
endmethod.
ENDCLASS.
