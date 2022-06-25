class CL_ISH_DBCRIT_RANGE definition
  public
  inheriting from CL_ISH_DBCRITERION
  create public
  shared memory enabled .

*"* public components of class CL_ISH_DBCRIT_RANGE
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_DBCRIT_RANGE type ISH_OBJECT_TYPE value 12164. "#EC NOTEXT
  class-data GT_RANGE1 type ISH_T_R_STRING read-only .
  class-data GT_RANGE10 type ISH_T_R_STRING read-only .
  class-data GT_RANGE11 type ISH_T_R_STRING read-only .
  class-data GT_RANGE12 type ISH_T_R_STRING read-only .
  class-data GT_RANGE13 type ISH_T_R_STRING read-only .
  class-data GT_RANGE14 type ISH_T_R_STRING read-only .
  class-data GT_RANGE15 type ISH_T_R_STRING read-only .
  class-data GT_RANGE16 type ISH_T_R_STRING read-only .
  class-data GT_RANGE17 type ISH_T_R_STRING read-only .
  class-data GT_RANGE18 type ISH_T_R_STRING read-only .
  class-data GT_RANGE19 type ISH_T_R_STRING read-only .
  class-data GT_RANGE2 type ISH_T_R_STRING read-only .
  class-data GT_RANGE20 type ISH_T_R_STRING read-only .
  class-data GT_RANGE3 type ISH_T_R_STRING read-only .
  class-data GT_RANGE4 type ISH_T_R_STRING read-only .
  class-data GT_RANGE5 type ISH_T_R_STRING read-only .
  class-data GT_RANGE6 type ISH_T_R_STRING read-only .
  class-data GT_RANGE7 type ISH_T_R_STRING read-only .
  class-data GT_RANGE8 type ISH_T_R_STRING read-only .
  class-data GT_RANGE9 type ISH_T_R_STRING read-only .

  class CL_ISH_RANGE definition load .
  class-methods CREATE_BY_TABENTRIES
    importing
      !I_FIELDNAME type FIELDNAME
      !IT_TABENTRY type ANY TABLE
      !I_TAB_FIELDNAME type FIELDNAME
      !I_SIGN type TVARV_SIGN default CL_ISH_RANGE=>CO_SIGN_I
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_RANGE .
  methods CONSTRUCTOR
    importing
      !I_FIELDNAME type FIELDNAME
      !IR_RANGE type ref to CL_ISH_RANGE .
  methods GET_FIELDNAME
    returning
      value(R_FIELDNAME) type FIELDNAME .
  methods GET_RANGE
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IS_EMPTY
    redefinition .
protected section.
*"* protected components of class CL_ISH_DBCRIT_RANGE
*"* do not include other source files here!!!

  class-data G_RANGENR type I .
  data GR_RANGE type ref to CL_ISH_RANGE .

  methods PREPARE_STRINGIFICATION
    redefinition .
  methods _AS_STRING
    redefinition .
private section.
*"* private components of class CL_ISH_DBCRIT_RANGE
*"* do not include other source files here!!!

  data G_FIELDNAME type FIELDNAME .
ENDCLASS.



CLASS CL_ISH_DBCRIT_RANGE IMPLEMENTATION.


METHOD constructor.

* Call the super constructor.
  super->constructor( ).

* Initial checking.
  IF i_fieldname IS INITIAL OR
     ir_range IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Initialize self.
  g_fieldname = i_fieldname.
  gr_range    = ir_range.

ENDMETHOD.


METHOD create_by_tabentries.

  DATA: lr_range  TYPE REF TO cl_ish_range.

  FIELD-SYMBOLS: <ls_tabentry>  TYPE ANY,
                 <l_value>      TYPE ANY.

* Check the fieldname.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Create the range.
  CREATE OBJECT lr_range.

* Build the range.
  LOOP AT it_tabentry ASSIGNING <ls_tabentry>.
    IF i_tab_fieldname IS INITIAL.
      ASSIGN <ls_tabentry> TO <l_value>.
    ELSE.
      ASSIGN COMPONENT i_fieldname
        OF STRUCTURE <ls_tabentry>
        TO <l_value>.
    ENDIF.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_ish_no_check_handler.
    ENDIF.
    CASE i_sign.
      WHEN cl_ish_range=>co_sign_i.
        lr_range->incl_eq( <l_value> ).
      WHEN cl_ish_range=>co_sign_e.
        lr_range->excl_eq( <l_value> ).
      WHEN OTHERS.
        RAISE EXCEPTION TYPE cx_ish_no_check_handler.
    ENDCASE.
  ENDLOOP.

* Create the criterion.
  CREATE OBJECT rr_crit
    EXPORTING
      i_fieldname = i_fieldname
      ir_range    = lr_range.

ENDMETHOD.


METHOD get_fieldname.

  r_fieldname = g_fieldname.

ENDMETHOD.


METHOD get_range.

  rr_range = gr_range.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dbcrit_range.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dbcrit_range.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD is_empty.

  r_empty = gr_range->is_empty( ).

ENDMETHOD.


METHOD prepare_stringification.

  super->prepare_stringification( ).

  g_rangenr = 0.

ENDMETHOD.


METHOD _as_string.

  DATA: l_rangename  TYPE string.

  FIELD-SYMBOLS: <lt_range>  LIKE gt_range1.

* Initial checking.
  CHECK gr_range->get_nr_of_entries( ) > 0.

* Increment the range number.
  g_rangenr = g_rangenr + 1.

* Determine the range name.
  l_rangename = g_rangenr.
  CONCATENATE 'CL_ISH_DBCRIT_RANGE=>GT_RANGE'
              l_rangename
         INTO l_rangename.

* Set the range.
  ASSIGN (l_rangename) TO <lt_range>.
  CHECK sy-subrc = 0.
  <lt_range> = gr_range->get_entries( ).

* Stringify self.
  CONCATENATE '('
              g_fieldname
              'IN'
              l_rangename
              ')'
         INTO r_string
    SEPARATED BY space.

ENDMETHOD.
ENDCLASS.
