class CL_ISH_GUI_MDY_TITLEBAR definition
  public
  inheriting from CL_ISH_GUI_ELEMENT
  create protected .

public section.
*"* public components of class CL_ISH_GUI_MDY_TITLEBAR
*"* do not include other source files here!!!

  constants CO_DEF_TITLEBAR_NAME type N1GUI_ELEMENT_NAME value 'TITLEBAR'. "#EC NOTEXT

  type-pools CO .
  class-methods CREATE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME default CO_DEF_TITLEBAR_NAME
      !I_TITLE type SY-TITLE
      !I_REPID type SY-REPID default SY-REPID
      !I_PAR1 type STRING optional
      !I_PAR2 type STRING optional
      !I_PAR3 type STRING optional
      !I_PAR4 type STRING optional
      !I_PAR5 type STRING optional
      !I_PAR6 type STRING optional
      !I_PAR7 type STRING optional
      !I_PAR8 type STRING optional
      !I_PAR9 type STRING optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_MDY_TITLEBAR .
  class-methods CREATE_BY_PARTAB
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME default CO_DEF_TITLEBAR_NAME
      !I_TITLE type SY-TITLE
      !I_REPID type SY-REPID default SY-REPID
      !IT_PARAMETER type ISH_T_STRING
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_MDY_TITLEBAR .
  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME default CO_DEF_TITLEBAR_NAME
      !I_TITLE type SY-TITLE
      !I_REPID type SY-REPID default SY-REPID
      !IT_PARAMETER type ISH_T_STRING optional .
  methods GET_CLONE
    returning
      value(RR_CLONE) type ref to CL_ISH_GUI_MDY_TITLEBAR .
  methods GET_PARAMETER
    importing
      !I_IDX type I
    returning
      value(R_PARAMETER) type STRING .
  methods GET_PARAMETERS
    returning
      value(RT_PARAMETER) type ISH_T_STRING .
  methods GET_REPID
    returning
      value(R_REPID) type SY-REPID .
  methods GET_TITLE
    returning
      value(R_TITLE) type SY-TITLE .
  type-pools ABAP .
  methods HAS_PARAMETERS
    returning
      value(R_PARAMETERS) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_GUI_MDY_TITLEBAR
*"* do not include other source files here!!!

  data GT_PARAMETER type ISH_T_STRING .
  data G_REPID type SY-REPID .
  data G_TITLE type SY-TITLE .
private section.
*"* private components of class CL_ISH_GUI_MDY_TITLEBAR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_MDY_TITLEBAR IMPLEMENTATION.


METHOD constructor.

  super->constructor( i_element_name = i_element_name ).

  g_title      = i_title.
  g_repid      = i_repid.
  gt_parameter = it_parameter.

ENDMETHOD.


METHOD create.

  DATA: lt_parameter  TYPE ish_t_string.

  IF i_par1 IS NOT INITIAL OR
     i_par2 IS NOT INITIAL OR
     i_par3 IS NOT INITIAL OR
     i_par4 IS NOT INITIAL OR
     i_par5 IS NOT INITIAL OR
     i_par6 IS NOT INITIAL OR
     i_par7 IS NOT INITIAL OR
     i_par8 IS NOT INITIAL OR
     i_par9 IS NOT INITIAL.
    APPEND i_par1 TO lt_parameter.
    APPEND i_par2 TO lt_parameter.
    APPEND i_par3 TO lt_parameter.
    APPEND i_par4 TO lt_parameter.
    APPEND i_par5 TO lt_parameter.
    APPEND i_par6 TO lt_parameter.
    APPEND i_par7 TO lt_parameter.
    APPEND i_par8 TO lt_parameter.
    APPEND i_par9 TO lt_parameter.
  ENDIF.

  rr_instance = create_by_partab( i_element_name = i_element_name
                                  i_title        = i_title
                                  i_repid        = i_repid
                                  it_parameter   = lt_parameter ).
ENDMETHOD.


METHOD create_by_partab.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name = i_element_name
      i_title        = i_title
      i_repid        = i_repid
      it_parameter   = it_parameter.

ENDMETHOD.


METHOD get_clone.

  DATA l_element_name  TYPE n1gui_element_name.

  l_element_name = get_element_name( ).

  rr_clone = create_by_partab( i_element_name = l_element_name
                               i_title        = g_title
                               i_repid        = g_repid
                               it_parameter   = gt_parameter ).

ENDMETHOD.


METHOD get_parameter.

  READ TABLE gt_parameter INDEX i_idx INTO r_parameter.

ENDMETHOD.


METHOD get_parameters.

  rt_parameter = gt_parameter.

ENDMETHOD.


METHOD get_repid.

  r_repid = g_repid.

ENDMETHOD.


METHOD get_title.

  r_title = g_title.

ENDMETHOD.


METHOD has_parameters.

  CHECK gt_parameter IS NOT INITIAL.

  r_parameters = abap_true.

ENDMETHOD.
ENDCLASS.
