class CL_ISHMED_API_FACTORY definition
  public
  final
  create private .

public section.

  constants CO_API_CLIM_BC1 type N1API_TYPE value 'CL_ISHMED_API_CLIM_BC1' ##NO_TEXT.
  constants CO_API_CLIM1 type N1API_TYPE value 'CL_ISHMED_API_CLIM1' ##NO_TEXT.
  constants CO_API_CORDER1 type N1API_TYPE value 'CL_ISHMED_API_CORDER1' ##NO_TEXT.
  constants CO_API_DOCUMENT1 type N1API_TYPE value 'CL_ISHMED_API_DOCUMENT1' ##NO_TEXT.
  constants CO_API_PORD1 type N1API_TYPE value 'CL_ISHMED_API_PORD1' ##NO_TEXT.
  constants CO_API_ME1 type N1API_TYPE value 'CL_ISHMED_API_ME1' ##NO_TEXT.
  constants CO_API_CC1 type N1API_TYPE value 'CL_ISHMED_API_CC1' ##NO_TEXT.
  constants CO_API_LIN1 type N1API_TYPE value 'CL_ISHMED_API_LIN1' ##NO_TEXT.
  constants CO_API_FLU1 type N1API_TYPE value 'CL_ISHMED_API_FLUI1' ##NO_TEXT.
  constants CO_API_CLIM2 type N1API_TYPE value 'CL_ISHMED_API_CLIM2' ##NO_TEXT.
  constants CO_API_ALG1 type N1API_TYPE value 'CL_ISHMED_API_ALLERGY1' ##NO_TEXT.
  constants CO_API_CORDER2 type N1API_TYPE value 'CL_ISHMED_API_CORDER2' ##NO_TEXT.
  constants CO_API_DOC1 type N1API_TYPE value 'CL_ISHMED_API_DOC1' ##NO_TEXT.
  constants CO_API_MEDSRV1 type N1API_TYPE value 'CL_ISHMED_API_MEDSRV1' ##NO_TEXT.
  constants CO_API_TEAM1 type N1API_TYPE value 'CL_ISHMED_API_TEAM1' ##NO_TEXT.
  constants CO_API_TERMINOLOGY1 type N1API_TYPE value 'CL_ISHMED_API_TERMINOLOGY1' ##NO_TEXT.
  constants CO_API_DOC_SUBMISSION_SET type N1API_TYPE value 'CL_ISHMED_API_DOC_SUBMSET1' ##NO_TEXT.

  class-methods GET_INSTANCE
    importing
      !I_TYPE type N1API_TYPE
    returning
      value(RR_VALUE) type ref to IF_ISHMED_API
    raising
      CX_ISHMED_API_FACTORY .
protected section.
private section.

  types:
    BEGIN OF ts_instance,
           type     TYPE n1api_type,
           api      TYPE REF TO if_ishmed_api,
         END OF ts_instance .
  types:
    tt_instance TYPE HASHED TABLE OF ts_instance WITH UNIQUE KEY type .

  class-data ST_INSTANCE type TT_INSTANCE .
ENDCLASS.



CLASS CL_ISHMED_API_FACTORY IMPLEMENTATION.


  METHOD get_instance.
    DATA ls_instance    TYPE ts_instance.

    DATA lx_create      TYPE  REF TO cx_sy_create_object_error.

    READ TABLE cl_ishmed_api_factory=>st_instance
         INTO ls_instance
         WITH KEY type    = i_type.
    IF sy-subrc EQ 0.
      rr_value = ls_instance-api.

      RETURN.
    ENDIF.

    TRY.
        CREATE OBJECT rr_value TYPE (i_type).
      CATCH cx_sy_create_object_error INTO lx_create.
        RAISE EXCEPTION TYPE cx_ishmed_api_factory
          EXPORTING
            textid   = cx_ishmed_api_factory=>class_not_created
            previous = lx_create
            attr1    = |{ i_type }|.
    ENDTRY.

    IF rr_value->if_ishmed_api_descriptor~is_singleton( ) EQ abap_true.
      ls_instance-type    = i_type.
      ls_instance-api     = rr_value.

      INSERT ls_instance INTO TABLE cl_ishmed_api_factory=>st_instance.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
