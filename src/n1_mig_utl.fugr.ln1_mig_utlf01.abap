*----------------------------------------------------------------------*
***INCLUDE LN1_MIG_UTLF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  process_components
*&---------------------------------------------------------------------*
*       This form processes the component data of a corder.
*----------------------------------------------------------------------*
*  -->PT_MAP        Table with corder data.
*       The anatomy of a map entry is like this:                       *
*         posno       order item number                                *
*         instno      instance number                                  *
*         compid      component ID or special identifier               *
*         fieldname   name of the dynpro- or object structure field    *
*         fieldvalue  value of the field                               *
*  -->PT_COMPONENT  Components.
*  -->P_POS         Posnr
*----------------------------------------------------------------------*
FORM process_components
  USING    pt_map           TYPE ishmed_migtyp
           pt_component     TYPE ish_t_component
           p_pos            TYPE i
  CHANGING p_rc             TYPE ish_method_rc
           pr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  DATA: lr_component    TYPE REF TO if_ish_component,
        l_compid        TYPE n1compid,
        lt_screen       TYPE ish_t_screen_objects,
        lr_screen       TYPE REF TO if_ish_screen,
        lt_fv           TYPE ish_t_field_value,
        l_scr_actualize TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_fv>  TYPE rnfield_value,
                 <ls_map> LIKE LINE OF pt_map.

  LOOP AT pt_component INTO lr_component.
*   to continue we need the compid **********************************
*   since it is not to be found in wa_mycpl, we got to cast to a  ***
*   general component object ****************************************
    l_compid = lr_component->get_compid( ).
*   now we need to get the screens for this component ***************
    lt_screen = lr_component->get_defined_screens( ).
*   next we loop through the screens found **************************
    LOOP AT lt_screen INTO lr_screen.
      l_scr_actualize = space.
*     get the field objects for this screen *************************
      CALL METHOD lr_screen->get_fields
        IMPORTING
          et_field_values = lt_fv
          e_rc            = p_rc
        CHANGING
          c_errorhandler  = pr_errorhandler.
      CHECK p_rc = 0.
*     loop through the fieldobjects *********************************
*     fieldobject anatomy is fieldname|type|value|object|level ******
      LOOP AT lt_fv ASSIGNING <ls_fv>.
*       update those values defined in the fieldmap *****************
        READ TABLE pt_map
          WITH KEY
            posno     = p_pos
            compid    = l_compid
            fieldname = <ls_fv>-fieldname
          ASSIGNING <ls_map>.
        IF sy-subrc = 0.
          <ls_fv>-value = <ls_map>-fvalue.
          l_scr_actualize = 'X'.
        ENDIF.
      ENDLOOP.
*     actualize those fields that have been updated *****************
      IF l_scr_actualize EQ 'X'.
        CALL METHOD lr_screen->set_fields
          EXPORTING
            i_conv_to_intern = 'X'
            it_field_values  = lt_fv
            i_field_values_x = 'X'
          IMPORTING
            e_rc             = p_rc
          CHANGING
            c_errorhandler   = pr_errorhandler.
        CHECK p_rc = 0.
*       transport actualized screens to it's component's data object*
        CALL METHOD lr_component->transport_from_screen
          EXPORTING
            ir_screen       = lr_screen
          IMPORTING
            e_rc            = p_rc
          CHANGING
            cr_errorhandler = pr_errorhandler.
        CHECK p_rc = 0.
      ENDIF.
    ENDLOOP.
    CHECK p_rc = 0.
  ENDLOOP.

ENDFORM.                    " process_components
