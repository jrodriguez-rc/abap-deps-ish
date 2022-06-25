class CL_EX_N1CREATE_SCREEN definition
  public
  final
  create public .

*"* public components of class CL_EX_N1CREATE_SCREEN
*"* do not include other source files here!!!
public section.

  interfaces IF_EX_N1CREATE_SCREEN .

  constants VERSION type VERSION value 000001. "#EC NOTEXT
  type-pools SXRT .
protected section.
*"* protected components of class CL_EX_N1CREATE_SCREEN
*"* do not include other source files here!!!
private section.
*"* private components of class CL_EX_N1CREATE_SCREEN
*"* do not include other source files here!!!

  type-pools SXRT .
  data INSTANCE_BADI_TABLE type SXRT_EXIT_TAB .
  data INSTANCE_FLT_CACHE type SXRT_FLT_CACHE_TAB .
ENDCLASS.



CLASS CL_EX_N1CREATE_SCREEN IMPLEMENTATION.


method IF_EX_N1CREATE_SCREEN~CREATE .
  CLASS CL_EXIT_MASTER DEFINITION LOAD.
  DATA: EXIT_OBJ_TAB TYPE SXRT_EXIT_TAB,
        old_imp_class type seoclsname.
  DATA: exitintf TYPE REF TO IF_EX_N1CREATE_SCREEN,
        wa_flt_cache TYPE sxrt_flt_cache_struct,
        flt_name TYPE FILTNAME.




  FIELD-SYMBOLS:
    <exit_obj>       TYPE SXRT_EXIT_TAB_STRUCT,
    <flt_cache_line> TYPE sxrt_flt_cache_struct.

  READ TABLE INSTANCE_FLT_CACHE
         WITH KEY flt_name    = flt_name
                  method_name = 'CREATE'
         TRANSPORTING NO FIELDS.
  IF sy-subrc NE 0.
    LOOP AT INSTANCE_BADI_TABLE ASSIGNING <exit_obj>
         WHERE INTER_NAME   = 'IF_EX_N1CREATE_SCREEN'
           AND METHOD_NAME  = 'CREATE'.
      APPEND <exit_obj> TO EXIT_OBJ_TAB.
    ENDLOOP.

    IF sy-subrc = 4.
      CALL METHOD CL_EXIT_MASTER=>CREATE_OBJ_BY_INTERFACE_FILTER
         EXPORTING
            CALLER       = me
            INTER_NAME   = 'IF_EX_N1CREATE_SCREEN'
            METHOD_NAME  = 'CREATE'

            delayed_instance_creation    = sxrt_true
         IMPORTING
            exit_obj_tab = exit_obj_tab.

      APPEND LINES OF exit_obj_tab TO INSTANCE_BADI_TABLE.
    ENDIF.

    wa_flt_cache-flt_name    = flt_name.
    wa_flt_cache-valid       = sxrt_false.
    wa_flt_cache-method_name = 'CREATE'.

    LOOP at exit_obj_tab ASSIGNING <exit_obj>
        WHERE ACTIVE   = SXRT_TRUE
          AND RELEASED = SXRT_TRUE.

      CHECK <exit_obj>-imp_class NE old_imp_class.


        MOVE-CORRESPONDING <exit_obj> TO wa_flt_cache.
        wa_flt_cache-valid = sxrt_true.
        wa_flt_cache-obj = CL_EXIT_MASTER=>instantiate_imp_class(
                              CALLER       = me
                              imp_name  = <exit_obj>-imp_name
                              imp_class = <exit_obj>-imp_class ).

        INSERT wa_flt_cache INTO TABLE INSTANCE_FLT_CACHE.
        old_imp_class = <exit_obj>-imp_class.

    ENDLOOP.
    IF wa_flt_cache-valid = sxrt_false.
      INSERT wa_flt_cache INTO TABLE INSTANCE_FLT_CACHE.
    ENDIF.
  ENDIF.

  LOOP AT INSTANCE_FLT_CACHE ASSIGNING <flt_cache_line>
       WHERE flt_name    = flt_name
         AND valid       = sxrt_true
         AND method_name = 'CREATE'.


    CALL FUNCTION 'PF_ASTAT_OPEN'
       EXPORTING
           OPENKEY = 'O17eCidalaQMPrLPeA58OG'
           TYP     = 'UE'.

    CASE <flt_cache_line>-imp_switch.
      WHEN 'VSR'.
        DATA: exc        TYPE sfbm_xcptn,                  "#EC NEEDED
              data_ref   TYPE REF TO DATA.

        IF <flt_cache_line>-eo_object is initial.
          CALL METHOD ('CL_FOBU_METHOD_EVALUATION')=>load
               EXPORTING
                  im_class_name     = <flt_cache_line>-imp_class
                  im_interface_name = 'IF_EX_N1CREATE_SCREEN'
                  im_method_name    = 'CREATE'
               RECEIVING
                  re_fobu_method    = <flt_cache_line>-eo_object
               EXCEPTIONS
                  not_found         = 1
                  OTHERS            = 2.
          IF sy-subrc = 2.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                       WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDIF.
          CHECK sy-subrc = 0.
        ENDIF.


        CLEAR data_ref.
        GET REFERENCE OF I_OBJECT_TYPE INTO data_ref.
        CALL METHOD <flt_cache_line>-eo_object->set_parameter(
            im_parmname = 'I_OBJECT_TYPE'
            im_value    = data_ref ).

        CLEAR data_ref.
        GET REFERENCE OF ER_INSTANCE INTO data_ref.
        CALL METHOD <flt_cache_line>-eo_object->set_parameter(
            im_parmname = 'ER_INSTANCE'
            im_value    = data_ref ).

        CLEAR data_ref.
        GET REFERENCE OF E_RC INTO data_ref.
        CALL METHOD <flt_cache_line>-eo_object->set_parameter(
            im_parmname = 'E_RC'
            im_value    = data_ref ).

        CLEAR data_ref.
        GET REFERENCE OF CR_ERRORHANDLER INTO data_ref.
        CALL METHOD <flt_cache_line>-eo_object->set_parameter(
            im_parmname = 'CR_ERRORHANDLER'
            im_value    = data_ref ).

        CALL METHOD <flt_cache_line>-eo_object->evaluate
             IMPORTING
                ex_exception    = exc
             EXCEPTIONS
                raise_exception = 1
                OTHERS          = 2.
        IF sy-subrc = 2.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                     WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.

        ENDIF.
      WHEN OTHERS.
        EXITINTF ?= <flt_cache_line>-OBJ.
        CALL METHOD EXITINTF->CREATE
           EXPORTING
             I_OBJECT_TYPE = I_OBJECT_TYPE
           IMPORTING
             ER_INSTANCE = ER_INSTANCE
             E_RC = E_RC
           CHANGING
             CR_ERRORHANDLER = CR_ERRORHANDLER.


    ENDCASE.

    CALL FUNCTION 'PF_ASTAT_CLOSE'
       EXPORTING
           OPENKEY = 'O17eCidalaQMPrLPeA58OG'
           TYP     = 'UE'.
  ENDLOOP.


endmethod.
ENDCLASS.
