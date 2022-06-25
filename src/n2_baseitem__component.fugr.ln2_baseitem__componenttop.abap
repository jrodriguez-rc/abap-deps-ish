FUNCTION-POOL n2_baseitem__component.       "MESSAGE-ID ..


TYPE-POOLS: abap.

TABLES rn2_baseitem__component_d.

DATA  gr_manager        TYPE REF TO cl_ishmed_baseitems_manager.
DATA  gr_error          TYPE REF TO cl_ishmed_errorhandling.

DATA  gx_baseitems      TYPE REF TO cx_ishmed_baseitems.

DATA  g_readonly        TYPE        abap_bool.
DATA  g_rc              TYPE        ish_method_rc.
DATA  g_repid           TYPE        program VALUE 'SAPLN2_BASEITEM_COMPONENT'.
DATA  g_dynnr           TYPE        dynnr   VALUE '0001'.

DATA  gs_component      TYPE        rn2_baseitem__component.

DATA  gt_first_actions  TYPE        ishmed_t_action_id.
DATA  gt_again_actions  TYPE        ishmed_t_action_id.

*&---------------------------------------------------------------------*
*&       Class LCL_COMPONENT_SCREEN
*&---------------------------------------------------------------------*
*        Helper Class to finalize instances for screen handling
*----------------------------------------------------------------------*
CLASS lcl_component_screen DEFINITION.

  PUBLIC SECTION.
    INTERFACES if_ishmed_baseitem_check_cb.

    DATA g_baseitem     TYPE        n2_baseitem_id READ-ONLY.

    CLASS-METHODS  create  IMPORTING
                             i_itemtype     TYPE n2_baseitem_type
                             i_baseitem_id  TYPE n2_baseitem_id
                           CHANGING
                             cr_instance TYPE REF TO lcl_component_screen
                           RAISING
                             cx_ishmed_baseitem_screen
                             cx_ishmed_baseitems.

    METHODS        constructor
                           IMPORTING
                             i_itemtype     TYPE n2_baseitem_type
                             i_baseitem_id  TYPE n2_baseitem_id
                           RAISING
                             cx_ishmed_baseitem_screen
                             cx_ishmed_baseitems.

    METHODS        finalize
                           RAISING
                             cx_ishmed_baseitem_screen
                             cx_ishmed_baseitems.

    METHODS        handle_finalize
                           FOR EVENT baseitem_released OF cl_ishmed_baseitems_manager
                           IMPORTING baseitem_id.

    METHODS        set_ok_code
                           IMPORTING
                             i_okcode    TYPE        syucomm
                           EXPORTING                                             " 6.05
                             e_rc        TYPE        ish_method_rc               " 6.05
                           CHANGING                                              " 6.05
                             cr_errorhandler TYPE REF TO cl_ishmed_errorhandling " 6.05
                           RAISING
                             cx_ishmed_baseitem_screen
                             cx_ishmed_baseitems.                            .

    METHODS        set_mode
                           IMPORTING
                             i_readonly  TYPE        abap_bool
                           RAISING
                             cx_ishmed_baseitem_screen
                             cx_ishmed_baseitems.

    METHODS        get_screen
                           EXPORTING
                             e_program   TYPE        program
                             e_dynnr     TYPE        dynnr
                           RAISING
                             cx_ishmed_baseitem_screen
                             cx_ishmed_baseitems.
    METHODS        set_data
                           IMPORTING
                             i_xmldoc    TYPE        n2_baseitem_xmldoc
                           RAISING
                             cx_ishmed_baseitem_screen
                             cx_ishmed_baseitems.

    METHODS        get_data
                           EXPORTING
                             e_xmldoc    TYPE        n2_baseitem_xmldoc
                           RAISING
                             cx_ishmed_baseitem_screen
                             cx_ishmed_baseitems.

  PROTECTED SECTION.
    DATA gr_comp_def    TYPE REF TO cl_ish_compdef.
    DATA gr_comp_base   TYPE REF TO if_ish_component_base.
    DATA gr_comp_config TYPE REF TO if_ish_component_config.
    DATA gr_screen      TYPE REF TO if_ish_screen.
    DATA gr_environment TYPE REF TO cl_ish_environment.
    DATA gr_manager     TYPE REF TO cl_ishmed_baseitems_manager.
    DATA gr_xmldoc      TYPE REF TO cl_ishmed_xml_document_base.

    DATA gs_parent      TYPE        rnscr_parent.


ENDCLASS.               "LCL_COMPONENT_SCREEN

*------------------------------------------------------------
DATA  gr_screen         TYPE REF TO lcl_component_screen.
