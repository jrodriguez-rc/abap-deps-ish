*&---------------------------------------------------------------------*
*& Report  RN1SEOCREATE
*&---------------------------------------------------------------------*
*& creation of classes, methods, parameters, attributes, ...
*&---------------------------------------------------------------------*
REPORT  rn1seocreate.

INCLUDE rndata00.

TYPE-POOLS: seok, seoo, seop, seor, seos, seot.


DATA: ls_cls                   TYPE  seoclskey,
      ls_class                 TYPE  vseoclass,

      lt_methods               TYPE  seoo_methods_r,
      ls_method                TYPE  seoo_method_r,

      lt_redefinitions         TYPE  seor_redefinitions_r,
      ls_redefinition          TYPE  seoredef,

      lt_implementings         TYPE  seor_implementings_r,
      ls_implementing          TYPE  seor_implementing_r,

      lt_impl_details          TYPE  seo_redefinitions,
      ls_impl_detail           TYPE  seoredef,

      lt_attributes            TYPE  seoo_attributes_r,
      ls_attribute             TYPE  seoo_attribute_r,

      lt_events                TYPE  seoo_events_r,
      ls_event                 TYPE  seoo_event_r,

      lt_types                 TYPE  seoo_types_r,
      ls_type                  TYPE  seoo_type_r,

      lt_parameters            TYPE  seos_parameters_r,
      ls_parameter             TYPE  seos_parameter_r,

      lt_exceps                TYPE  seos_exceptions_r,
      ls_excep                 TYPE  seos_exception_r,

      lt_aliases               TYPE  seoo_aliases_r,
      ls_alias                 TYPE  seoo_alias_r,

      lt_typepusages           TYPE  seot_typepusages_r,
      ls_typepusage            TYPE  seot_typepusage_r,

      lt_clsdeferrds           TYPE  seot_clsdeferrds_r,
      ls_clsdeferrd            TYPE  seot_clsdeferrd_r,

      lt_intdeferrds           TYPE  seot_intdeferrds_r,
      ls_intdeferrd            TYPE  seot_intdeferrd_r,

      lt_friendships           TYPE  seo_friends,
      ls_friendship            TYPE  seofriends,

      ls_inheritance           TYPE  vseoextend,

      lt_explore_inheritances  TYPE  seok_cls_typeinfos,
      lt_explore_implementings TYPE  seok_int_typeinfos.

*********************************************************************

* class
SELECTION-SCREEN BEGIN OF BLOCK b_class WITH FRAME TITLE text-t01.

PARAMETERS: p_class  TYPE seoclsname,
            p_clsnew TYPE ish_on_off,
            p_clsdes TYPE seodescr,
            p_clsexp TYPE seoexpose DEFAULT '2'
                                    AS LISTBOX VISIBLE LENGTH 10.

PARAMETERS: p_inher  TYPE seocmpname.

SELECTION-SCREEN END OF BLOCK b_class.

*interface implementation
SELECTION-SCREEN BEGIN OF BLOCK b_implem WITH FRAME TITLE text-t03.

PARAMETERS: p_implem TYPE seocmpname.

SELECTION-SCREEN END OF BLOCK b_implem.

* method
SELECTION-SCREEN BEGIN OF BLOCK b_method WITH FRAME TITLE text-t04.

PARAMETERS: p_method TYPE seocmpname,
            p_metdes TYPE seodescr,
            p_metexp TYPE seoexpose AS LISTBOX VISIBLE LENGTH 10.

SELECTION-SCREEN END OF BLOCK b_method.

* parameter (for method)
SELECTION-SCREEN BEGIN OF BLOCK b_param WITH FRAME TITLE text-t05.

PARAMETERS: p_parmet TYPE seocmpname,
            p_param  TYPE seocmpname,
            p_pardes TYPE seodescr,
            p_pardec TYPE seopardecl AS LISTBOX VISIBLE LENGTH 10,
            p_partyp TYPE seotyptype DEFAULT '1'
                                     AS LISTBOX VISIBLE LENGTH 30,
            p_party  TYPE rs38l_typ,
            p_parpas TYPE seoparpass AS LISTBOX VISIBLE LENGTH 20,
            p_paropt TYPE seooptionl.

SELECTION-SCREEN END OF BLOCK b_param.

* attribute
SELECTION-SCREEN BEGIN OF BLOCK b_attrib WITH FRAME TITLE text-t06.

PARAMETERS: p_attrib TYPE seocmpname,
            p_attdes TYPE seodescr,
            p_attexp TYPE seoexpose  AS LISTBOX VISIBLE LENGTH 10,
            p_attdec TYPE seoattdecl AS LISTBOX VISIBLE LENGTH 20,
            p_atttyp TYPE seotyptype DEFAULT '1'
                                     AS LISTBOX VISIBLE LENGTH 30,
            p_attty  TYPE rs38l_typ.

SELECTION-SCREEN END OF BLOCK b_attrib.

*********************************************************************
START-OF-SELECTION.

  ls_cls-clsname = p_class.

* load the class
  CALL FUNCTION 'SEO_CLASS_TYPEINFO_GET'
    EXPORTING
      clskey                = ls_cls
    IMPORTING
      class                 = ls_class
      attributes            = lt_attributes
      methods               = lt_methods
      events                = lt_events
      types                 = lt_types
      PARAMETERS            = lt_parameters
      exceps                = lt_exceps
      implementings         = lt_implementings
      inheritance           = ls_inheritance
      redefinitions         = lt_redefinitions
      impl_details          = lt_impl_details
      friendships           = lt_friendships
      typepusages           = lt_typepusages
      clsdeferrds           = lt_clsdeferrds
      intdeferrds           = lt_intdeferrds
      explore_inheritance   = lt_explore_inheritances
      explore_implementings = lt_explore_implementings
      aliases               = lt_aliases
    EXCEPTIONS
      not_existing          = 1
      is_interface          = 2
      model_only            = 3
      OTHERS                = 4.
  IF sy-subrc <> 0.
    IF sy-subrc = 1 AND p_clsnew = on.
*     create class
      CLEAR ls_class.
      ls_class-clsname  = p_class.
      ls_class-descript = p_clsdes.
      ls_class-exposure = p_clsexp.
      ls_class-state    = 1.
      ls_class-fixpt    = 'X'.
      ls_class-unicode  = 'X'.
      CALL FUNCTION 'SEO_CLASS_CREATE_F_DATA'
        CHANGING
          class        = ls_class
        EXCEPTIONS
          existing     = 1
          is_interface = 2
          not_created  = 3
          db_error     = 4
          OTHERS       = 5.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
        EXIT.
      ELSE.
        WRITE: /1 'Klasse'(005), p_class, 'angelegt'(001).
*       load the new created class
        CALL FUNCTION 'SEO_CLASS_TYPEINFO_GET'
          EXPORTING
            clskey                = ls_cls
          IMPORTING
            class                 = ls_class
            attributes            = lt_attributes
            methods               = lt_methods
            events                = lt_events
            types                 = lt_types
            PARAMETERS            = lt_parameters
            exceps                = lt_exceps
            implementings         = lt_implementings
            inheritance           = ls_inheritance
            redefinitions         = lt_redefinitions
            impl_details          = lt_impl_details
            friendships           = lt_friendships
            typepusages           = lt_typepusages
            clsdeferrds           = lt_clsdeferrds
            intdeferrds           = lt_intdeferrds
            explore_inheritance   = lt_explore_inheritances
            explore_implementings = lt_explore_implementings
            aliases               = lt_aliases
          EXCEPTIONS
            not_existing          = 1
            is_interface          = 2
            model_only            = 3
            OTHERS                = 4.
        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno
                  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          EXIT.
        ENDIF.
      ENDIF.
    ELSE.
      MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      EXIT.
    ENDIF.
  ENDIF.

  CHECK p_class IS NOT INITIAL.

  COMMIT WORK AND WAIT.

* create inheritance
  IF p_inher IS NOT INITIAL.
    CLEAR ls_inheritance.
    ls_inheritance-clsname     = ls_cls-clsname.
    ls_inheritance-refclsname  = p_inher.
    ls_inheritance-state       = 1.
    CALL FUNCTION 'SEO_INHERITANC_CREATE_F_DATA'
      CHANGING
        inheritance     = ls_inheritance
      EXCEPTIONS
        existing        = 1
        is_comprising   = 2
        is_implementing = 3
        recursion       = 4
        not_created     = 5
        db_error        = 6
        OTHERS          = 7.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ELSE.
      WRITE: /1 'Vererbung'(006), p_inher, 'angelegt'(001).
    ENDIF.
  ENDIF.

* create interface implementation
  IF p_implem IS NOT INITIAL.
    CLEAR ls_implementing.
    ls_implementing-clsname    = ls_cls-clsname.
    ls_implementing-refclsname = p_implem.
    ls_implementing-state      = 1.
    CALL FUNCTION 'SEO_IMPLEMENTG_CREATE_F_DATA'
      CHANGING
        implementing   = ls_implementing
      EXCEPTIONS
        existing       = 1
        is_inheritance = 2
        is_comprising  = 3
        not_created    = 4
        db_error       = 5
        OTHERS         = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ELSE.
      WRITE: /1 'Interface Implem.'(007), p_implem,
                'angelegt'(001).
    ENDIF.
  ENDIF.

* create method
  IF p_method IS NOT INITIAL.
    CLEAR ls_method.
    ls_method-clsname     = ls_cls-clsname.
    ls_method-cmpname     = p_method.
    ls_method-descript    = p_metdes.
    ls_method-exposure    = p_metexp.
    ls_method-mtddecltyp  = 1. " Art (0=instance,1=static)
    ls_method-state       = 1.
    CALL FUNCTION 'SEO_METHOD_CREATE_F_DATA'
      CHANGING
        method       = ls_method
      EXCEPTIONS
        existing     = 1
        is_event     = 2
        is_type      = 3
        is_attribute = 4
        not_created  = 5
        db_error     = 6
        OTHERS       = 7.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ELSE.
      WRITE: /1 'Methode'(002), p_method, 'angelegt'(001).
    ENDIF.
  ENDIF.

* create parameter
  IF p_parmet IS NOT INITIAL AND
     p_param  IS NOT INITIAL.
    CLEAR ls_parameter.
    ls_parameter-clsname    = ls_cls-clsname.
    ls_parameter-cmpname    = p_parmet.
    ls_parameter-sconame    = p_param.
    ls_parameter-descript   = p_pardes.
    ls_parameter-pardecltyp = p_pardec.
    ls_parameter-typtype    = p_partyp.
    ls_parameter-type       = p_party.
    ls_parameter-parpasstyp = p_parpas.
    ls_parameter-paroptionl = p_paropt.
    CALL FUNCTION 'SEO_PARAMETER_CREATE_F_DATA'
      CHANGING
        parameter              = ls_parameter
      EXCEPTIONS
        existing               = 1
        is_exception           = 2
        not_created            = 3
        db_error               = 4
        component_not_existing = 5
        OTHERS                 = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ELSE.
      WRITE: /1 'Parameter'(003), p_param, 'angelegt'(001).
    ENDIF.
  ENDIF.

* create attribute
  IF p_attrib IS NOT INITIAL.
    CLEAR ls_attribute.
    ls_attribute-clsname    = ls_cls-clsname.
    ls_attribute-cmpname    = p_attrib.
    ls_attribute-descript   = p_attdes.
    ls_attribute-exposure   = p_attexp.
    ls_attribute-attdecltyp = p_attdec.
    ls_attribute-state      = 1.
    ls_attribute-typtype    = p_atttyp.
    ls_attribute-type       = p_attty.
    CALL FUNCTION 'SEO_ATTRIBUTE_CREATE_F_DATA'
      CHANGING
        attribute   = ls_attribute
      EXCEPTIONS
        existing    = 1
        is_method   = 2
        is_event    = 3
        is_type     = 4
        not_created = 5
        db_error    = 6
        OTHERS      = 7.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE 'I' NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ELSE.
      WRITE: /1 'Attribut'(004), p_attrib, 'angelegt'(001).
    ENDIF.
  ENDIF.

* The End
