class CX_ISH_GUI_PAI_NEEDED definition
  public
  inheriting from CX_ISH_GUI
  create public .

public section.
*"* public components of class CX_ISH_GUI_PAI_NEEDED
*"* do not include other source files here!!!

  constants CX_ISH_GUI_PAI_NEEDED type SOTR_CONC value '801CC4454D9E1DEE8D985A78FD2116BA'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      !GR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !GR_MSGTYP type SY-MSGTY default 'E' .
protected section.
*"* protected components of class CX_ISH_GUI_PAI_NEEDED
*"* do not include other source files here!!!
private section.
*"* private components of class CX_ISH_GUI_PAI_NEEDED
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_ISH_GUI_PAI_NEEDED IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
GR_ERRORHANDLER = GR_ERRORHANDLER
GR_MSGTYP = GR_MSGTYP
.
 IF textid IS INITIAL.
   me->textid = CX_ISH_GUI_PAI_NEEDED .
 ENDIF.
endmethod.
ENDCLASS.
