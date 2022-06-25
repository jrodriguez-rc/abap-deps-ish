FUNCTION ish_read_object_types.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_CUSTOMER_OBJ) TYPE  C DEFAULT '*'
*"  EXPORTING
*"     REFERENCE(ET_OBJECT_TYPE) TYPE  ISH_T_OBJ_CONSTANT
*"     VALUE(E_NEXT_FREE_VALUE) TYPE  ISH_OBJECT_TYPE
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------
* Fichte, ID 18656
  DATA: lt_clskey     TYPE seo_clskeys,
        ls_clskey     TYPE seoclskey,
        l_rc          TYPE ish_method_rc,
        lt_attrib     TYPE seoo_attributes_r,
        lt_obj_type   TYPE ish_t_obj_constant,
        ls_obj_type   TYPE ish_s_obj_constant,
        l_max_value   TYPE ish_object_type,
        l_int         TYPE ish_object_type,
        l_par         TYPE bapiret2-parameter,
        l_co_len      TYPE i.

  FIELD-SYMBOLS:
        <ls_attrib>   TYPE vseoattrib,
        <ls_obj_type> TYPE ish_s_obj_constant.

* ---------------------------------------------------------
* Initialization
  e_rc = 0.
  e_next_free_value = 0.
  CLEAR: et_object_type[],
         lt_obj_type[].

* ---------------------------------------------------------
* Get all classes, where the interface IF_ISH_IDENTIFY_OBJECT
* is implemented
  CLEAR: lt_clskey[].
  CALL METHOD cl_ish_utl_rtti=>get_interface_implementations
    EXPORTING
      i_interface_name  = 'IF_ISH_IDENTIFY_OBJECT'
      i_with_subclasses = on
    RECEIVING
      rt_clskey         = lt_clskey.
  CHECK NOT lt_clskey[] IS INITIAL.

* ---------------------------------------------------------
* Get the constants within the found classes
  l_max_value = 0.
  LOOP AT lt_clskey INTO ls_clskey.
    CLEAR: lt_attrib[].
    CALL FUNCTION 'SEO_ATTRIBUTE_READ_ALL'
      EXPORTING
        cifkey                  = ls_clskey
*       VERSION                 = SEOC_VERSION_INACTIVE
        master_language         = ' '    " SY-LANGU
*       MODIF_LANGUAGE          = SY-LANGU
      IMPORTING
        attributes              = lt_attrib
      EXCEPTIONS
        clif_not_existing       = 1
        OTHERS                  = 2.
*   Raise no error here; this will be done later

*   Get rid of the aliases
    DELETE lt_attrib WHERE alias = on.

*   Get rid of everything else than constants
    DELETE lt_attrib WHERE attdecltyp <> '2'.

*   Get rid of all attributes with a name <> 'CO_OTYPE_'.
    l_co_len = STRLEN( co_name ).
    LOOP AT lt_attrib ASSIGNING <ls_attrib>.
      CHECK <ls_attrib>-cmpname(l_co_len) <> co_name.
      DELETE lt_attrib.
    ENDLOOP.

*   Build up table
    CLEAR: ls_obj_type.
    ls_obj_type-pgmobj_name = ls_clskey-clsname.
    IF ls_clskey-clsname(3) <> 'CL_'  AND
       ls_clskey-clsname(3) <> 'IF_'.
      ls_obj_type-cust_specific = on.
    ENDIF.

*   Get highest value so far
    IF ls_obj_type-cust_specific = off.
      LOOP AT lt_attrib ASSIGNING <ls_attrib>.
*if <ls_attrib>-attvalue cn ' 0123456789'.
*break c5058352.
*endif.
        l_int = <ls_attrib>-attvalue.
        IF <ls_attrib>-attvalue > l_max_value.
          l_max_value = <ls_attrib>-attvalue.
        ENDIF.
      ENDLOOP.
    ENDIF.

    LOOP AT lt_attrib ASSIGNING <ls_attrib>.
      ls_obj_type-cmpname = <ls_attrib>-cmpname.
      ls_obj_type-value   = <ls_attrib>-attvalue.
      APPEND ls_obj_type TO lt_obj_type.

*     Check the type of the constant. It has to be ISH_OBJECT_TYPE!
      IF <ls_attrib>-type <> 'ISH_OBJECT_TYPE'.
        e_rc = 10.
*       &: Konstante & hat den falschen Typ &
        l_par = ls_clskey-clsname.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = '088'
            i_mv1           = ls_clskey-clsname
            i_mv2           = <ls_attrib>-cmpname
            i_mv3           = <ls_attrib>-type
            i_par           = l_par
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
    ENDLOOP.
    IF sy-subrc <> 0.
      ls_obj_type-no_constant = on.
      APPEND ls_obj_type TO lt_obj_type.

*     Keinen Objekttyp in & gefunden
      l_par = ls_clskey-clsname.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'W'
          i_kla           = 'N1BASE'
          i_num           = '089'
          i_mv1           = ls_clskey-clsname
          i_par           = l_par
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CONTINUE.
    ENDIF.
  ENDLOOP.

* For new objects, the values have to begin at 12000. The ranges
* to use are: 12000 - 19999  and later 100000 - ....
  e_next_free_value = l_max_value + 1.
  IF e_next_free_value < 12000.
    e_next_free_value = 12000.
  ENDIF.
  IF e_next_free_value > 19999.
*  PN, 23.01.2007: range 100000 - 149999 is reserved for MED AddOns
*    e_next_free_value = 100000.
    e_next_free_value = 150000.
  ENDIF.

* Check if constant values have been used several times. This
* is not allowed!
  SORT lt_obj_type BY value.
  CLEAR: ls_obj_type.
  LOOP AT lt_obj_type ASSIGNING <ls_obj_type>.
    IF NOT ls_obj_type-value IS INITIAL  AND
       ls_obj_type-value = <ls_obj_type>-value.
      e_rc = 10.
*     Konstante & in & hat denselben Wert wie & in &
      l_par = <ls_obj_type>-pgmobj_name.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '090'
          i_mv1           = ls_obj_type-cmpname
          i_mv2           = ls_obj_type-pgmobj_name
          i_mv3           = <ls_obj_type>-cmpname
          i_mv4           = <ls_obj_type>-pgmobj_name
          i_par           = l_par
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
    ls_obj_type = <ls_obj_type>.
  ENDLOOP.

* If the caller just wants customer specific objects or just
* standard objekts, get rid of the rest
  IF i_customer_obj = on.
    DELETE lt_obj_type WHERE cust_specific = off.
  ELSEIF i_customer_obj = off.
    DELETE lt_obj_type WHERE cust_specific = on.
  ENDIF.
  et_object_type[] = lt_obj_type[].
ENDFUNCTION.
