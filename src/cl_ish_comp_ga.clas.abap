class CL_ISH_COMP_GA definition
  public
  inheriting from CL_ISH_COMPONENT_BASE
  abstract
  create public .

public section.
*"* public components of class CL_ISH_COMP_GA
*"* do not include other source files here!!!

  constants CO_OTYPE_COMP_GA type ISH_OBJECT_TYPE value 13706. "#EC NOTEXT

  methods CREATE_GM_COMPCON
  abstract
    returning
      value(RR_GM_COMPCON) type ref to CL_ISH_GM_COMPCON
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_COMPCON_GA
    returning
      value(RR_COMPCON_GA) type ref to CL_ISH_COMPCON_GA .
  methods LOAD_COMPCON_APPLICATION
  abstract
    returning
      value(RR_APPLICATION) type ref to CL_ISH_GA_COMPCON
    raising
      CX_ISH_STATIC_HANDLER .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMP_GA
*"* do not include other source files here!!!

  methods CREATE_COMPCON
    redefinition .
private section.
*"* private components of class CL_ISH_COMP_GA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMP_GA IMPLEMENTATION.


METHOD create_compcon.

  DATA: lr_compcon  TYPE REF TO if_ish_component_config.

* Initializations.
  e_rc = 0.

* Create the compcon.
  CALL METHOD cl_ish_component_config=>create
    EXPORTING
      ir_component    = me
      i_object_type   = cl_ish_compcon_ga=>co_otype_compcon_ga
      i_class_name    = 'CL_ISH_COMPCON_GA'
    IMPORTING
      er_compcon      = lr_compcon
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  gr_compcon = lr_compcon.

ENDMETHOD.


METHOD get_compcon_ga.

  TRY.
      rr_compcon_ga ?= gr_compcon.
    CATCH cx_sy_move_cast_error.
      CLEAR rr_compcon_ga.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_comp_ga.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_comp_ga.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
