class CL_ISH_SNAP_HISTORY definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create public

  global friends CL_ISH_HISTORY .

public section.
*"* public components of class CL_ISH_SNAP_HISTORY
*"* do not include other source files here!!!

  methods GET_ATTRIBUTE
    redefinition .
protected section.
*"* protected components of class CL_ISH_SNAP_HISTORY
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SNAP_HISTORY
*"* do not include other source files here!!!

  data GT_HISTORY type ISH_T_HISTORY .
  data G_TIMESTAMP type ISH_HIST_TIMESTAMP .
ENDCLASS.



CLASS CL_ISH_SNAP_HISTORY IMPLEMENTATION.


method GET_ATTRIBUTE.

  DATA: lr_typedescr           TYPE REF TO cl_abap_typedescr.

  FIELD-SYMBOLS: <l_attribute> TYPE ANY.

* Initialize.
  CLEAR: e_value,
         e_type,
         e_rc.

* If no attribute name given => exit.
  IF i_attribute_name IS INITIAL.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '014'
        i_mv1           = 'CL_ISH_SNAP_HISTORY'
        i_mv2           = 'GET_ATTRIBUTE'
        i_mv3           = 'I_ATTRIBUTE_NAME'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 10.
    EXIT.
  ENDIF.

* Get reference of object attribute.
  TRY.
    ASSIGN me->(i_attribute_name) TO <l_attribute>.

    IF sy-subrc <> 0.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '136'
          i_mv1           = 'CL_ISH_SNAP_HISTORY'
          i_mv2           = 'GET_ATTRIBUTE'
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = 10.
      EXIT.
    ENDIF.

    CATCH cx_root.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '136'
          i_mv1           = 'CL_ISH_SNAP_HISTORY'
          i_mv2           = 'GET_ATTRIBUTE'
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = 10.
      EXIT.
  ENDTRY.

* Return attribute reference.
  IF e_value IS SUPPLIED.
    e_value = <l_attribute>.
  ENDIF.

* Return attribute type.
  IF e_type IS SUPPLIED.
    lr_typedescr = cl_abap_typedescr=>describe_by_data( <l_attribute> ).
    IF NOT lr_typedescr IS BOUND.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '136'
          i_mv1           = 'CL_ISH_SNAP_HISTORY'
          i_mv2           = 'GET_ATTRIBUTE'
        CHANGING
          cr_errorhandler = cr_errorhandler.
      e_rc = 10.
      EXIT.
    ENDIF.
    e_type = lr_typedescr->absolute_name+6.
  ENDIF.

endmethod.
ENDCLASS.
