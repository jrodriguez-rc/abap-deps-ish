class CL_ISH_GUI_ELEMENT definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_GUI_ELEMENT
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_GUI_ELEMENT
      final methods GET_ELEMENT_ID
                    GET_ELEMENT_NAME .

  aliases GET_ELEMENT_ID
    for IF_ISH_GUI_ELEMENT~GET_ELEMENT_ID .
  aliases GET_ELEMENT_NAME
    for IF_ISH_GUI_ELEMENT~GET_ELEMENT_NAME .

  constants CO_FIELDNAME_ELEMENT_ID type ISH_FIELDNAME value 'ELEMENT_ID'. "#EC NOTEXT
  constants CO_FIELDNAME_ELEMENT_NAME type ISH_FIELDNAME value 'ELEMENT_NAME'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional .
protected section.
*"* protected components of class CL_ISH_GUI_ELEMENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_ELEMENT
*"* do not include other source files here!!!

  data G_ELEMENT_ID type N1GUI_ELEMENT_ID .
  data G_ELEMENT_NAME type N1GUI_ELEMENT_NAME .
ENDCLASS.



CLASS CL_ISH_GUI_ELEMENT IMPLEMENTATION.


METHOD constructor.

  super->constructor( ).

  g_element_id   = cl_ish_utl_base=>generate_uuid( ).
  IF i_element_name IS INITIAL.
    g_element_name = cl_ish_utl_rtti=>get_class_name( me ).
  ELSE.
    g_element_name = i_element_name.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_element~get_element_id.

  DATA lr_layout            TYPE REF TO cl_ish_gui_layout.

  IF g_element_id IS INITIAL.
    TRY.
        lr_layout ?= me.
        g_element_id = lr_layout->__get_layout_elemid( ).
      CATCH cx_sy_move_cast_error.
        RETURN.
    ENDTRY.
  ENDIF.

  r_element_id = g_element_id.

ENDMETHOD.


METHOD if_ish_gui_element~get_element_name.

  DATA lr_layout            TYPE REF TO cl_ish_gui_layout.

  IF g_element_name IS INITIAL.
    TRY.
        lr_layout ?= me.
        g_element_name = lr_layout->__get_layout_elemname( ).
      CATCH cx_sy_move_cast_error.
        RETURN.
    ENDTRY.
  ENDIF.

  r_element_name = g_element_name.

ENDMETHOD.
ENDCLASS.
