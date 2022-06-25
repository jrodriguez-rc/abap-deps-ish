class CL_ISH_GUI_MDY_PFSTATUS definition
  public
  inheriting from CL_ISH_GUI_ELEMENT
  create protected .

public section.
*"* public components of class CL_ISH_GUI_MDY_PFSTATUS
*"* do not include other source files here!!!

  constants CO_DEF_PFSTATUS_NAME type N1GUI_ELEMENT_NAME value 'PFSTATUS'. "#EC NOTEXT

  class-methods CREATE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME default CO_DEF_PFSTATUS_NAME
      !I_PFKEY type SY-PFKEY
      !I_REPID type SY-REPID default SY-REPID
      !IT_EXCLFUNC type SYUCOMM_T optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_MDY_PFSTATUS .
  methods ADD_EXCLUDING_FUNCTION
    importing
      !I_EXCLFUNC type SYUCOMM .
  methods CLEAR_EXCLUDING_FUNCTIONS .
  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME default CO_DEF_PFSTATUS_NAME
      !I_PFKEY type SY-PFKEY
      !I_REPID type SY-REPID default SY-REPID
      !IT_EXCLFUNC type SYUCOMM_T optional .
  methods GET_CLONE
    returning
      value(RR_CLONE) type ref to CL_ISH_GUI_MDY_PFSTATUS .
  methods GET_EXCLUDING_FUNCTIONS
    returning
      value(RT_EXCLFUNC) type SYUCOMM_T .
  methods GET_PFKEY
    returning
      value(R_PFKEY) type SY-PFKEY .
  methods GET_REPID
    returning
      value(R_REPID) type SY-REPID .
  type-pools ABAP .
  methods HAS_EXCLUDING_FUNCTION
    importing
      !I_EXCLFUNC type SYUCOMM
    returning
      value(R_RESULT) type ABAP_BOOL .
  methods REMOVE_EXCLUDING_FUNCTION
    importing
      !I_EXCLFUNC type SYUCOMM .
  methods SET_EXCLUDING_FUNCTIONS
    importing
      !IT_EXCLFUNC type SYUCOMM_T .
protected section.
*"* protected components of class CL_ISH_GUI_MDY_PFSTATUS
*"* do not include other source files here!!!

  data GT_EXCLFUNC type SYUCOMM_T .
  data G_PFKEY type SY-PFKEY .
  data G_REPID type SY-REPID .
private section.
*"* private components of class CL_ISH_GUI_MDY_PFSTATUS
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_MDY_PFSTATUS IMPLEMENTATION.


METHOD add_excluding_function.

  CHECK i_exclfunc IS NOT INITIAL.
  CHECK has_excluding_function( i_exclfunc ) = abap_false.

  INSERT i_exclfunc INTO TABLE gt_exclfunc.

ENDMETHOD.


METHOD clear_excluding_functions.

  CLEAR gt_exclfunc.

ENDMETHOD.


METHOD constructor.

  super->constructor( i_element_name = i_element_name ).

  g_pfkey     = i_pfkey.
  g_repid     = i_repid.
  gt_exclfunc = it_exclfunc.

ENDMETHOD.


METHOD create.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name = i_element_name
      i_pfkey        = i_pfkey
      i_repid        = i_repid
      it_exclfunc    = it_exclfunc.

ENDMETHOD.


METHOD get_clone.

  DATA l_element_name  TYPE n1gui_element_name.

  l_element_name = get_element_name( ).

  rr_clone = create( i_element_name = l_element_name
                     i_pfkey        = g_pfkey
                     i_repid        = g_repid
                     it_exclfunc    = gt_exclfunc ).

ENDMETHOD.


METHOD get_excluding_functions.

  rt_exclfunc = gt_exclfunc.

ENDMETHOD.


METHOD get_pfkey.

  r_pfkey = g_pfkey.

ENDMETHOD.


METHOD get_repid.

  r_repid = g_repid.

ENDMETHOD.


METHOD has_excluding_function.

  READ TABLE gt_exclfunc FROM i_exclfunc TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_result = abap_true.

ENDMETHOD.


METHOD REMOVE_EXCLUDING_FUNCTION.

  DELETE TABLE gt_exclfunc FROM i_exclfunc.

ENDMETHOD.


METHOD set_excluding_functions.

  gt_exclfunc = it_exclfunc.

ENDMETHOD.
ENDCLASS.
