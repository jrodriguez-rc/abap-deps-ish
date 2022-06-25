class CL_ISHMED_ALAPPL_TC definition
  public
  inheriting from CL_ISHMED_ALAPPL
  create protected

  global friends CL_ISHMED_ALLOADER .

public section.

  constants CO_OTYPE_ALAPPL_TC type ISH_OBJECT_TYPE value 13923 ##NO_TEXT.

  methods GET_EVAPPL_TC
    returning
      value(RR_EVAPPL_TC) type ref to CL_ISHMED_EVAPPL_TC .

  methods GET_DOKU_OBJ
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.

  methods CREATE_ALENTRY_INTERNAL
    redefinition .
private section.
ENDCLASS.



CLASS CL_ISHMED_ALAPPL_TC IMPLEMENTATION.


  method CREATE_ALENTRY_INTERNAL.

    rr_alentry = cl_ishmed_alentry_tc=>create_tc_by_asyncevent( is_n1asyncevent = is_n1asyncevent ).

  endmethod.


  METHOD get_doku_obj.

    r_doku_obj = 'N1_ALAPPL_TC'.

  ENDMETHOD.


  METHOD GET_EVAPPL_TC.

    TRY.
        rr_evappl_tc ?= get_evappl( ).
      CATCH cx_sy_move_cast_error.
        CLEAR rr_evappl_tc.
    ENDTRY.


  ENDMETHOD.


  method IF_ISH_IDENTIFY_OBJECT~GET_TYPE.

    e_object_type = co_otype_alappl_tc.

  endmethod.


  METHOD if_ish_identify_object~is_inherited_from.

    IF i_object_type = co_otype_alappl_tc.
      r_is_inherited_from = on.
    ELSE.
      r_is_inherited_from = super->if_ish_identify_object~is_inherited_from( i_object_type = i_object_type ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
