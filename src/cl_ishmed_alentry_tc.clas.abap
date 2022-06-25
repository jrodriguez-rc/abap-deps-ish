class CL_ISHMED_ALENTRY_TC definition
  public
  inheriting from CL_ISHMED_ALENTRY
  create public .

public section.

  data CO_OTYPE_ALENTRY_TC type ISH_OBJECT_TYPE value 13924 ##NO_TEXT.

  class-methods CREATE_TC_BY_ASYNCEVENT
    importing
      !IS_N1ASYNCEVENT type N1ASYNCEVENT
    returning
      value(RR_ALENTRY_TC) type ref to CL_ISHMED_ALENTRY_TC
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DATA_TC
    returning
      value(RS_DATA_TC) type RN1TC_EVENT_DATA .

  methods CREATE_CLONE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.

  data GS_DATA_TC type RN1TC_EVENT_DATA .

  methods CLONE_DATA
    redefinition .
  methods DESTROY_INTERNAL
    redefinition .
  methods INIT_BY_ASYNCEVENT
    redefinition .
private section.
ENDCLASS.



CLASS CL_ISHMED_ALENTRY_TC IMPLEMENTATION.


  method CLONE_DATA.

    DATA: lr_clone  TYPE REF TO cl_ishmed_alentry_tc.

    super->clone_data( ir_clone ).

    lr_clone ?= ir_clone.
    lr_clone->gs_data_tc = gs_data_tc.

  endmethod.


  METHOD create_clone.

    CREATE OBJECT rr_clone TYPE cl_ishmed_alentry_tc.

    clone_data( rr_clone ).

  ENDMETHOD.


  METHOD create_tc_by_asyncevent.

*   create the object
    CREATE OBJECT rr_alentry_tc.

*   complete the construction
    TRY .
        rr_alentry_tc->init_by_asyncevent( is_n1asyncevent ).
      CLEANUP .
        rr_alentry_tc->destroy( ).
    ENDTRY.

  ENDMETHOD.


  method DESTROY_INTERNAL.

    CLEAR gs_data_tc.

  endmethod.


  METHOD get_data_tc.

    rs_data_tc = gs_data_tc.

  ENDMETHOD.


  method IF_ISH_IDENTIFY_OBJECT~GET_TYPE.

    e_object_type = co_otype_alentry_tc.

  endmethod.


  METHOD if_ish_identify_object~is_inherited_from.

    IF i_object_type = co_otype_alentry_tc.
      r_is_inherited_from = on.
    ELSE.
      r_is_inherited_from = super->if_ish_identify_object~is_inherited_from( i_object_type = i_object_type ).
    ENDIF.

  ENDMETHOD.


  METHOD init_by_asyncevent.

    DATA : l_objid          TYPE n1alobjid,
           l_clsname        TYPE seoclsname,
           lr_enum_req_type TYPE REF TO cl_ish_enum,
           l_objid_msgtext  TYPE string,
           lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
           lr_except        TYPE REF TO cx_root.

*   Deserialize the async data.
    TRY.
        CALL TRANSFORMATION id
          SOURCE XML is_n1asyncevent-async_data
          RESULT struct = gs_data_tc.
      CATCH cx_transformation_error INTO lr_except.
        RAISE EXCEPTION TYPE cx_ish_static_handler
          EXPORTING
            previous = lr_except.
    ENDTRY.

*   Check the EVAPPLID
    IF is_n1asyncevent-evapplid <> cl_ishmed_evappl_tc=>co_evapplid_tc.
      l_clsname = cl_ish_utl_rtti=>get_class_name( me ).
      cl_ish_utl_base=>collect_messages(
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '003'
          i_mv1           = l_clsname
        CHANGING
          cr_errorhandler = lr_errorhandler ).
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          gr_errorhandler = lr_errorhandler.
    ENDIF.

*   Set the context institution + patnr + falnr.
    set_ctx_einri( i_einri = gs_data_tc-tc-institution_id ).
    set_ctx_patnr( i_patnr = gs_data_tc-tc-patient_id ).
    set_ctx_falnr( i_falnr = gs_data_tc-tc-case_id ).

*   Dtermine the objid_msgtext.
    lr_enum_req_type = cl_ish_enum=>get_instance_by_domname( i_domname = 'N1TC_REQ_TYPE' ).
    IF lr_enum_req_type IS BOUND.
      TRY.
          l_objid_msgtext = lr_enum_req_type->get_text_by_id( i_id = gs_data_tc-tc-req_type ).
        CATCH cx_static_check.
          CLEAR l_objid_msgtext.
      ENDTRY.
    ENDIF.
    IF l_objid_msgtext IS INITIAL.
      l_objid_msgtext = gs_data_tc-tc-request_id.
    ENDIF.

*   Call the super method
    super->init_by_asyncevent(  is_n1asyncevent = is_n1asyncevent
                                i_objid_msgtext = l_objid_msgtext ).
*   Set the context object id.
    l_objid = gs_data_tc-tc-request_id.
    set_ctx_objid( i_objid = l_objid ).

  ENDMETHOD.
ENDCLASS.
