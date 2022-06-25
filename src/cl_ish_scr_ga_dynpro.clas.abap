class CL_ISH_SCR_GA_DYNPRO definition
  public
  inheriting from CL_ISH_SCR_GA
  create public .

public section.
*"* public components of class CL_ISH_SCR_GA_DYNPRO
*"* do not include other source files here!!!

  constants CO_OTYPE_SCR_GA_DYNPRO type ISH_OBJECT_TYPE value 13765. "#EC NOTEXT

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods SET_APPLICATION
    redefinition .
  methods IF_ISH_SCREEN~PROCESS_BEFORE_OUTPUT
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_GA_DYNPRO
*"* do not include other source files here!!!

  methods INITIALIZE_PARENT
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_GA_DYNPRO
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_GA_DYNPRO IMPLEMENTATION.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_scr_ga_dynpro.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_scr_ga_dynpro.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~process_before_output.

  DATA lx_static            TYPE REF TO cx_ish_static_handler.

  CLEAR e_rc.

  CHECK gr_application IS BOUND.

  CHECK gr_application->is_running( ) = abap_false.

  TRY.
      gr_application->run( ).
    CATCH cx_ish_static_handler INTO lx_static.
      e_rc = 1.
      IF lx_static->gr_errorhandler IS BOUND.
        CALL METHOD cl_ish_utl_base=>copy_messages
          EXPORTING
            i_copy_from     = lx_static->gr_errorhandler
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
  ENDTRY.

ENDMETHOD.


METHOD initialize_parent.

  DATA lr_main_ctr            TYPE REF TO if_ish_gui_main_controller.
  DATA lr_mdy_view            TYPE REF TO if_ish_gui_mdy_view.
  DATA lx_static              TYPE REF TO cx_ish_static_handler.

  CALL METHOD super->initialize_parent
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

  CHECK gr_application IS BOUND.

  IF gr_application->is_running( ) = abap_false.
    TRY.
        gr_application->run( ).
      CATCH cx_ish_static_handler INTO lx_static.
        e_rc = 1.
        IF lx_static->gr_errorhandler IS BOUND.
          CALL METHOD cl_ish_utl_base=>copy_messages
            EXPORTING
              i_copy_from     = lx_static->gr_errorhandler
            CHANGING
              cr_errorhandler = cr_errorhandler.
        ENDIF.
    ENDTRY.
  ENDIF.

  lr_main_ctr = gr_application->get_main_controller( ).
  CHECK lr_main_ctr IS BOUND.

  lr_mdy_view = lr_main_ctr->get_mdy_view( ).
  CHECK lr_mdy_view IS BOUND.

  gs_parent-repid = lr_mdy_view->get_repid( ).
  gs_parent-dynnr = lr_mdy_view->get_dynnr( ).
  gs_parent-type  = co_scr_parent_type_dynpro.

ENDMETHOD.


METHOD set_application.

  super->set_application( ir_application = ir_application ).

  initialize_parent( ).

ENDMETHOD.
ENDCLASS.
