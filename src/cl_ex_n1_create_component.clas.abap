class CL_EX_N1_CREATE_COMPONENT definition
  public
  final
  create public .

*"* public components of class CL_EX_N1_CREATE_COMPONENT
*"* do not include other source files here!!!
public section.

  interfaces IF_EX_N1_CREATE_COMPONENT .

  constants VERSION type VERSION value 000001. "#EC NOTEXT
  type-pools SXRT .
protected section.
*"* protected components of class CL_EX_N1_CREATE_COMPONENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_EX_N1_CREATE_COMPONENT
*"* do not include other source files here!!!

  data INSTANCE_BADI_TABLE type SXRT_EXIT_TAB .
  data INSTANCE_FLT_CACHE type SXRT_FLT_CACHE_TAB .
ENDCLASS.



CLASS CL_EX_N1_CREATE_COMPONENT IMPLEMENTATION.


method IF_EX_N1_CREATE_COMPONENT~CREATE_COMPONENT_BASE.
  CLASS CL_EXIT_MASTER DEFINITION LOAD.
  DATA: EXIT_OBJ_TAB TYPE SXRT_EXIT_TAB.

  DATA: exitintf TYPE REF TO IF_EX_N1_CREATE_COMPONENT,
        wa_flt_cache_line TYPE REF TO sxrt_flt_cache_struct,
        flt_name TYPE FILTNAME.


  FIELD-SYMBOLS:
    <exit_obj>       TYPE SXRT_EXIT_TAB_STRUCT,
    <flt_cache_line> TYPE sxrt_flt_cache_struct.

  READ TABLE INSTANCE_FLT_CACHE ASSIGNING <flt_cache_line>
         WITH KEY flt_name    = flt_name
                  method_name = 'CREATE_COMPONENT_BASE'
         .
  IF sy-subrc NE 0.

    CREATE DATA wa_flt_cache_line TYPE sxrt_flt_cache_struct.
    ASSIGN wa_flt_cache_line->* TO <flt_cache_line>.
    <flt_cache_line>-flt_name    = flt_name.
    <flt_cache_line>-method_name = 'CREATE_COMPONENT_BASE'.



        CALL METHOD CL_EXIT_MASTER=>CREATE_OBJ_BY_INTERFACE_FILTER
           EXPORTING
              CALLER       = me
              INTER_NAME   = 'IF_EX_N1_CREATE_COMPONENT'
              METHOD_NAME  = 'CREATE_COMPONENT_BASE'

              delayed_instance_creation    = sxrt_true
           IMPORTING
               exit_obj_tab = exit_obj_tab.

        APPEND LINES OF exit_obj_tab TO INSTANCE_BADI_TABLE.


      <flt_cache_line>-valid = sxrt_false.

      LOOP at exit_obj_tab ASSIGNING <exit_obj>
          WHERE ACTIVE   = SXRT_TRUE.

        <flt_cache_line>-valid = sxrt_true.


          <flt_cache_line>-obj =
               CL_EXIT_MASTER=>instantiate_imp_class(
                        CALLER       = me
                        imp_name  = <exit_obj>-imp_name
                        imp_class = <exit_obj>-imp_class ).
          MOVE <exit_obj>-imp_class to <flt_cache_line>-imp_class.
          MOVE <exit_obj>-imp_switch to <flt_cache_line>-imp_switch.
          MOVE <exit_obj>-order_num to <flt_cache_line>-order_num.
          EXIT.

      ENDLOOP.



    INSERT <flt_cache_line> INTO TABLE INSTANCE_FLT_CACHE.


  ENDIF.


  IF <flt_cache_line>-valid = sxrt_true.


    CALL FUNCTION 'PF_ASTAT_OPEN'
       EXPORTING
           OPENKEY = 'GPjVPJ{M6dtX00002X5DmG'
           TYP     = 'UE'.

    CASE <flt_cache_line>-imp_switch.
      WHEN 'VSR'.
        DATA: exc        TYPE sfbm_xcptn,                  "#EC NEEDED
              data_ref   TYPE REF TO DATA.

        IF <flt_cache_line>-eo_object is initial.
          CALL METHOD ('CL_FOBU_METHOD_EVALUATION')=>load
               EXPORTING
                  im_class_name     = <flt_cache_line>-imp_class
                  im_interface_name = 'IF_EX_N1_CREATE_COMPONENT'
                  im_method_name    = 'CREATE_COMPONENT_BASE'
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
        GET REFERENCE OF I_CLASS_NAME INTO data_ref.
        CALL METHOD <flt_cache_line>-eo_object->set_parameter(
            im_parmname = 'I_CLASS_NAME'
            im_value    = data_ref ).

        CLEAR data_ref.
        GET REFERENCE OF ER_COMPONENT_BASE INTO data_ref.
        CALL METHOD <flt_cache_line>-eo_object->set_parameter(
            im_parmname = 'ER_COMPONENT_BASE'
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
        CALL METHOD EXITINTF->CREATE_COMPONENT_BASE
           EXPORTING
             I_OBJECT_TYPE = I_OBJECT_TYPE
             I_CLASS_NAME = I_CLASS_NAME
           IMPORTING
             ER_COMPONENT_BASE = ER_COMPONENT_BASE
             E_RC = E_RC
           CHANGING
             CR_ERRORHANDLER = CR_ERRORHANDLER.


    ENDCASE.

    CALL FUNCTION 'PF_ASTAT_CLOSE'
       EXPORTING
           OPENKEY = 'GPjVPJ{M6dtX00002X5DmG'
           TYP     = 'UE'.
  ENDIF.


endmethod.
ENDCLASS.
