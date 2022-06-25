class CL_ISHMED_EVAPPL_TC definition
  public
  inheriting from CL_ISHMED_EVAPPL
  create public
  shared memory enabled .

public section.

  interfaces IF_ISHMED_FAC_EVAPPL .
  interfaces IF_ISHMED_LOGABLE_EVAPPL .

  constants CO_EVAPPLID_TC type N1EVAPPLID value 'TC' ##NO_TEXT.
  constants CO_OTYPE_EVAPPL_TC type ISH_OBJECT_TYPE value 13920 ##NO_TEXT.
  constants CO_DOKU_OBJ_EVAPPL_TC type DOKU_OBJ value 'N1_EVAPPL_TC' ##NO_TEXT.
  constants CO_DOKU_OBJ_EVDEF_TC_CREATED type DOKU_OBJ value 'N1_EVDEF_TC_CREATED' ##NO_TEXT.

  methods GET_DOKU_OBJ
    redefinition .
  methods GET_DOKU_OBJ_FOR_EVDEF
    redefinition .
  methods GET_EVDEF_NAME
    redefinition .
  methods GET_EVDEF_SHORT_NAME
    redefinition .
  methods GET_SHORT_NAME
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.

  methods CREATE_EVDEFS
    redefinition .
  methods GET_INITIAL_ID
    redefinition .
private section.
ENDCLASS.



CLASS CL_ISHMED_EVAPPL_TC IMPLEMENTATION.


  METHOD create_evdefs.

    DATA lr_evloader TYPE REF TO cl_ishmed_evloader.

*   get de event loader refference
    lr_evloader = get_evloader( ).
    IF lr_evloader IS NOT BOUND.
      RETURN.
    ENDIF.

*    created
    lr_evloader->create_evdef( ir_evappl  = me
                               i_id       = co_evdefid_created ).

  ENDMETHOD.


  METHOD get_doku_obj.

    r_doku_obj = co_doku_obj_evappl_tc.

  ENDMETHOD.


  METHOD get_doku_obj_for_evdef.

    DATA: l_evdefid TYPE n1evdefid.

    IF ir_evdef IS BOUND.
      l_evdefid = ir_evdef->get_id( ).
    ENDIF.

    CASE l_evdefid.
*     created
      WHEN co_evdefid_created.
        r_doku_obj = co_doku_obj_evdef_tc_created.
    ENDCASE.

  ENDMETHOD.


  method GET_EVDEF_NAME.

    DATA l_evapplsn TYPE n1evapplsn.
    DATA l_part2    TYPE string.

* Get the evappl short_name (=part1).
    l_evapplsn = get_short_name( ).

* Get part2.
    CASE i_evdefid.
      WHEN co_evdefid_created.
        l_evapplsn = 'Behandlungsauftrag'(001).
        l_part2 = 'wurde beantragt'(002).

      WHEN OTHERS.
        super->get_evdef_name(
          EXPORTING
            i_evdefid = i_evdefid
          RECEIVING
            r_name    = r_name
               ).
        RETURN.
    ENDCASE.

* Build the name.
    CONCATENATE l_evapplsn
                l_part2
           INTO r_name
      SEPARATED BY space.

  endmethod.


  method GET_EVDEF_SHORT_NAME.

    CASE i_evdefid.


      WHEN co_evdefid_created.
        r_short_name = 'Beantragt'(004).
      WHEN OTHERS.
        r_short_name = super->get_evdef_short_name( i_evdefid ).
    ENDCASE.

  endmethod.


  METHOD get_initial_id.

    r_id = co_evapplid_tc.

  ENDMETHOD.


  METHOD get_short_name.

    r_short_name = 'Behandlungsauftrag'(001).

  ENDMETHOD.


  method IF_ISHMED_FAC_EVAPPL~GET_CLSNAME.

    r_clsname = 'CL_ISHMED_EVAPPL_TC'.

  endmethod.


  METHOD if_ishmed_logable_evappl~get_async_event_data.

    CHECK ir_event IS BOUND.
    r_async_data = ir_event->get_async_data( ).

  ENDMETHOD.


  METHOD if_ishmed_logable_evappl~get_clsname_alappl.

    r_clsname = 'CL_ISHMED_ALAPPL_TC'.

  ENDMETHOD.


  METHOD if_ishmed_logable_evappl~is_logable_evdef.

*    initialization
    r_logable = off.

*    initial checking
    IF ir_evdef IS NOT BOUND.
      RETURN.
    ENDIF.
    IF ir_evdef->get_evappl( ) <> me.
      RETURN.
    ENDIF.

*    check de evdef
    CASE ir_evdef->get_id( ).
      WHEN co_evdefid_created.
        r_logable = on.
    ENDCASE.

  ENDMETHOD.


  METHOD if_ish_identify_object~get_type.

    e_object_type = co_otype_evappl_tc.

  ENDMETHOD.


  METHOD if_ish_identify_object~is_inherited_from.

    IF i_object_type = co_otype_evappl_tc.
      r_is_inherited_from = on.
    ELSE.
      r_is_inherited_from = super->is_inherited_from( i_object_type = i_object_type ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
