class CL_ABAP_STRUCTDESCR definition
  public
  inheriting from CL_ABAP_COMPLEXDESCR
  final
  create protected

  global friends CL_ABAP_REFDESCR .

public section.

  types COMPONENT type ABAP_COMPONENTDESCR .
  types COMPONENT_TABLE type ABAP_COMPONENT_TAB .
  types SYMBOL_TABLE type ABAP_COMPONENT_SYMBOL_TAB .
  types INCLUDED_VIEW type ABAP_COMPONENT_VIEW_TAB .

  data STRUCT_KIND type ABAP_STRUCTKIND read-only .
  constants STRUCTKIND_FLAT type ABAP_STRUCTKIND value 'F' ##NO_TEXT.
  data COMPONENTS type ABAP_COMPDESCR_TAB read-only .
  constants STRUCTKIND_NESTED type ABAP_STRUCTKIND value 'N' ##NO_TEXT.
  constants STRUCTKIND_MESH type ABAP_STRUCTKIND value 'M' ##NO_TEXT.
  data HAS_INCLUDE type ABAP_BOOL read-only .

  class-methods LOAD_CLASS .
  class-methods CLASS_CONSTRUCTOR .
  methods GET_DDIC_FIELD_LIST
    importing
      value(P_LANGU) type SYST-LANGU default SY-LANGU
      !P_INCLUDING_SUBSTRUCTRES type ABAP_BOOL default ABAP_FALSE
    returning
      value(P_FIELD_LIST) type DDFIELDS
    exceptions
      NOT_FOUND
      NO_DDIC_TYPE .
  class-methods GET
    importing
      !P_COMPONENTS type COMPONENT_TABLE
      !P_STRICT type ABAP_BOOL default TRUE
    returning
      value(P_RESULT) type ref to CL_ABAP_STRUCTDESCR
    raising
      CX_SY_STRUCT_CREATION .
  class-methods CREATE
    importing
      !P_COMPONENTS type COMPONENT_TABLE
      !P_STRICT type ABAP_BOOL default TRUE
    returning
      value(P_RESULT) type ref to CL_ABAP_STRUCTDESCR
    raising
      CX_SY_STRUCT_CREATION .
  methods GET_COMPONENTS
    returning
      value(P_RESULT) type COMPONENT_TABLE .
  methods GET_INCLUDED_VIEW
    importing
      value(P_LEVEL) type I optional
    returning
      value(P_RESULT) type INCLUDED_VIEW .
  methods GET_SYMBOLS
    returning
      value(P_RESULT) type SYMBOL_TABLE .
  methods GET_COMPONENT_TYPE
    importing
      !P_NAME type ANY
    returning
      value(P_DESCR_REF) type ref to CL_ABAP_DATADESCR
    exceptions
      COMPONENT_NOT_FOUND
      UNSUPPORTED_INPUT_TYPE .
protected section.
*"* protected components of class CL_ABAP_STRUCTDESCR
*"* do not include other source files here!!!

  class-methods CREATE_STRUCTDESCR_OBJECT
    for event CREATE_STRUCTDESCR of CL_ABAP_TYPEDESCR
    importing
      !XTYPE .
private section.

  types:
*"* private components of class CL_ABAP_STRUCTDESCR
*"* do not include other source files here!!!
    begin of ddfields_cache_line_type,
      langu     type SPRAS,
      not_found type abap_bool,
      value     type ref to DDFIELDS,
    end of ddfields_cache_line_type .
  types:
    begin of STRUC_COMP,
      NAME type string,
      XTYP type xtype_type,
      TYPE_KIND  type ABAP_TYPECATEGORY,
      AS_INCLUDE type abap_bool,
      SUFFIX  type string,
    end of struc_comp .
  types:
    STRUC_COMP_TAB type standard table of STRUC_COMP
      with non-unique default key .

  data:
    DDFIELDS_CACHE type hashed table of ddfields_cache_line_type
                           with unique key langu .
  data COMPONENTS_CACHE type COMPONENT_TABLE .
  type-pools ABAP .
  class-data HAS_OPTIMIZED_GET_METHOD type ABAP_BOOL .

  class-methods NORMALIZE_COMPONENT_TABLE
    importing
      !P_COMPONENTS type COMPONENT_TABLE
    returning
      value(P_COMPTAB) type STRUC_COMP_TAB
    raising
      CX_SY_STRUCT_CREATION .
  class-methods CREATE_CACHED_XTYP
    importing
      !DESC type STRUC_COMP_TAB
      !STRICT type ABAP_BOOL
    returning
      value(XTYP) type XTYPE_TYPE
    raising
      CX_SY_STRUCT_CREATION .
  class-methods GET_CACHED_XTYP
    importing
      !DESC type STRUC_COMP_TAB
      !STRICT type ABAP_BOOL
    returning
      value(XTYP) type XTYPE_TYPE
    raising
      CX_SY_STRUCT_CREATION .
  class-methods XTYP_TO_STRUC_DESC
    importing
      !XTYP type XTYPE_TYPE
      !EXPAND_ON type BOOLEAN default ABAP_FALSE
    returning
      value(DESC) type STRUC_COMP_TAB .
  class-methods CREATE_XTYP_FROM_STRUC_DESC
    importing
      !DESC type STRUC_COMP_TAB
    returning
      value(XTYP) type XTYPE_TYPE
    raising
      CX_SY_STRUCT_CREATION .
  class-methods GET_XTYP_FROM_STRUC_DESC
    importing
      !DESC type STRUC_COMP_TAB
    returning
      value(XTYP) type XTYPE_TYPE
    raising
      CX_SY_STRUCT_CREATION .
  class-methods CHECK_COMPONENT_TAB
    importing
      !P_COMPONENTS type COMPONENT_TABLE
      !P_STRICT type ABAP_BOOL default TRUE
    raising
      CX_SY_STRUCT_CREATION .
  class-methods CHECK_COMPONENT_TABLE
    importing
      !P_COMPONENTS type COMPONENT_TABLE
      !P_STRICT type ABAP_BOOL default TRUE
    returning
      value(P_COMPTAB) type STRUC_COMP_TAB
    raising
      CX_SY_STRUCT_CREATION .
  methods GET_COMPONENTS_TAB
    returning
      value(P_RESULT) type COMPONENT_TABLE .
  methods GET_INCLUDED_VIEW_TAB
    importing
      value(P_LEVEL) type I optional
    returning
      value(P_RESULT) type INCLUDED_VIEW .
  methods GET_SYMBOLS_TAB
    returning
      value(P_RESULT) type SYMBOL_TABLE .
ENDCLASS.



CLASS CL_ABAP_STRUCTDESCR IMPLEMENTATION.


method CHECK_COMPONENT_TAB.

 data:
   comp     type component,
   scomp    type struc_comp,
   nametab  like hashed table of comp-name with unique default key,
   symb_tab type symbol_table,
   symb     like line of symb_tab,
   strutype type ref to cl_abap_structdescr,
   name     like comp-name,
   comp_no  type i,
   off      type i.

 loop at p_components into comp.
   add 1 to comp_no.
   translate comp-name to upper case.
   translate comp-suffix to upper case.
   if comp-name is initial.
     if comp-as_include <> abap_true.
*      only allowed for anonymous includes
       raise exception type CX_SY_STRUCT_COMP_NAME
         exporting textid = CX_SY_STRUCT_COMP_NAME=>empty_name
                   component_name = comp-name
                   component_number = comp_no.
     endif.
     if not comp-suffix is initial and p_strict = abap_true.
*      suffix not allowed for anonymous includes in strict mode
       raise exception type CX_SY_STRUCT_ATTRIBUTES
         exporting textid = CX_SY_STRUCT_ATTRIBUTES=>illegal_suffix
                   component_name = comp-name
                   component_number = comp_no.
     endif.
   else. " comp-name is defined
     if comp-name = 'TABLE_LINE'.
*      reserved word for component name
       raise exception type CX_SY_STRUCT_COMP_NAME
         exporting textid = CX_SY_STRUCT_COMP_NAME=>reserved_word
                   component_name = comp-name
                   component_number = comp_no.
     endif.
     if strlen( comp-name ) > abap_max_comp_name_ln and
       ( comp-name(2) <> '%_' or p_strict = abap_true ).
*      component name too long
       raise exception type CX_SY_STRUCT_COMP_NAME
         exporting textid = CX_SY_STRUCT_COMP_NAME=>name_too_long
                   component_name = comp-name
                   component_number = comp_no.
     endif.
     if comp-name(1) = '/'.
*      namespace used.
       find '/' in comp-name+1 match offset off.
       if sy-subrc <> 0 or               " unmatched '/'
          off < 3 or                     " namespace at least 3 chars long
          strlen( comp-name+2 ) = off or " at least one char after namespace
          comp-name+1(off) cn 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.
                                         " only alpha-num chars (no '_')
         raise exception type CX_SY_STRUCT_COMP_NAME
           exporting textid = CX_SY_STRUCT_COMP_NAME=>ILLEGAL_NAMESPACE
                     component_name = comp-name
                     component_number = comp_no.
       else.
         add 2 to off.
       endif.
     else.
       off = 0.
     endif.
     if p_strict = abap_true.
       if ( off = 0 and comp-name+off(1) cn 'ABCDEFGHIJKLMNOPQRSTUVWXYZ_' ) or
          comp-name+off(*) cn 'ABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789'.
*        illegal character in component name
         raise exception type CX_SY_STRUCT_COMP_NAME
           exporting textid = CX_SY_STRUCT_COMP_NAME=>illegal_char_in_name
                     component_name = comp-name
                     component_number = comp_no.
       endif.
       if comp-suffix is not initial and
          comp-suffix cn 'ABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789'.
*        illegal character in suffix name
         raise exception type CX_SY_STRUCT_SUFFIX_NAME
           exporting textid = CX_SY_STRUCT_SUFFIX_NAME=>illegal_char_in_suffix
                     component_name = comp-name
                     component_number = comp_no.
       endif.
     else. " non-strict mode
       if comp-name+off cn 'ABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789#$%&*-/;<=>?@^{|}'.
*        illegal character in component name
         raise exception type CX_SY_STRUCT_COMP_NAME
           exporting textid = CX_SY_STRUCT_COMP_NAME=>illegal_char_in_name
                     component_name = comp-name
                     component_number = comp_no.
       endif.
       if comp-suffix is not initial and
          comp-suffix cn 'ABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789#$%&*-/;<=>?@^{|}'.
*        illegal character in suffix name
         raise exception type CX_SY_STRUCT_SUFFIX_NAME
           exporting textid = CX_SY_STRUCT_SUFFIX_NAME=>illegal_char_in_suffix
                     component_name = comp-name
                     component_number = comp_no.
       endif.
     endif.
     insert comp-name into table nametab.
     if sy-subrc = 4.
*      duplicate name
       raise exception type CX_SY_STRUCT_COMP_NAME
         exporting textid = CX_SY_STRUCT_COMP_NAME=>duplicate_name
                   component_name = comp-name
                   component_number = comp_no.
     endif.
   endif.
   assert comp-type is not initial. "checked in normalize_component_table
*   if comp-type is initial.
**    component type not defined
*     raise exception type CX_SY_STRUCT_COMP_TYPE
*       exporting textid = CX_SY_STRUCT_COMP_TYPE=>empty_type
*                 component_name = comp-name
*                 component_number = comp_no.
*   endif.
   scomp-name      = comp-name.
   scomp-xtyp      = comp-type->me_xtype.
   scomp-type_kind = comp-type->kind.
   if comp-as_include = abap_true.
     if comp-type->kind <> KIND_STRUCT.
*      as_include only defined for structures
       raise exception type CX_SY_STRUCT_ATTRIBUTES
         exporting textid = CX_SY_STRUCT_ATTRIBUTES=>illegal_include
                   component_name = comp-name
                   component_number = comp_no.
     endif.
     strutype ?= comp-type.
     symb_tab = strutype->get_symbols_tab( ).
     loop at symb_tab into symb.
       concatenate symb-name comp-suffix into name.
       if name = 'TABLE_LINE'.
*        reserved word for component name
         raise exception type CX_SY_STRUCT_SUFFIX_NAME
           exporting textid = CX_SY_STRUCT_SUFFIX_NAME=>reserved_word_after_include
                     component_name = comp-name
                     component_number = comp_no
                     suffixed_name = name.
       endif.
       if strlen( name ) > abap_max_comp_name_ln and name(2) <> '%_'.
*        compound name too long
         raise exception type CX_SY_STRUCT_SUFFIX_NAME
           exporting textid = CX_SY_STRUCT_SUFFIX_NAME=>name_too_long_after_include
                     component_name = comp-name
                     component_number = comp_no
                     suffixed_name = name.
       endif.
       insert name into table nametab.
       if sy-subrc = 4.
*        duplicate name
         raise exception type CX_SY_STRUCT_SUFFIX_NAME
           exporting textid = CX_SY_STRUCT_SUFFIX_NAME=>duplicate_name_after_include
                     component_name = comp-name
                     component_number = comp_no
                     suffixed_name = name.
       endif.
     endloop.
   else. " it's not an included type
     if not comp-suffix is initial.
*      suffix only defined with as_include
       raise exception type CX_SY_STRUCT_ATTRIBUTES
         exporting textid = CX_SY_STRUCT_ATTRIBUTES=>illegal_suffix
                   component_name = comp-name
                   component_number = comp_no.
     endif.
   endif.
   scomp-as_include = comp-as_include.
   scomp-suffix = comp-suffix.
 endloop.
 if comp_no = 0.
   raise exception type CX_SY_STRUCT_ATTRIBUTES
         exporting textid = CX_SY_STRUCT_ATTRIBUTES=>empty_component_table.
 endif.

endmethod.


method CHECK_COMPONENT_TABLE.
  p_comptab = normalize_component_table( p_components ).
  check_component_tab( p_components = p_components p_strict = p_strict ).
endmethod.


METHOD CLASS_CONSTRUCTOR.
  data comptab type STRUC_COMP_TAB.
  has_optimized_get_method = abap_true.
  try.
    get_cached_xtyp( desc = comptab strict = abap_true ).
  catch CX_SY_DYN_CALL_ILLEGAL_METHOD.
    has_optimized_get_method = abap_false.
  endtry.

  SET HANDLER CREATE_STRUCTDESCR_OBJECT.
ENDMETHOD.


method CREATE.



 data:

   comptab  type struc_comp_tab,   " standard table of struc_comp with key name,

   xtype    like me_xtype.



* caller = cl_package_runtime=>get_client_handle( ).

 comptab = check_component_table( p_components = p_components p_strict = p_strict ).



 xtype = CREATE_XTYP_FROM_STRUC_DESC( comptab ).

 p_result ?= get_by_xtype( p_xtype = xtype p_kind = 'S' ).



endmethod.



  method CREATE_CACHED_XTYP BY KERNEL MODULE ab_createCachedXtypFromStrucDesc FAIL.
  endmethod.


METHOD CREATE_STRUCTDESCR_OBJECT.

  DATA DREF TYPE REF TO CL_ABAP_STRUCTDESCR.
  CREATE OBJECT DREF.
  SYSTEM-CALL DESCRIBE STRUCTURE XTYPE
    INTO DREF->ABSOLUTE_NAME DREF->TYPE_KIND   DREF->LENGTH
         DREF->DECIMALS      DREF->STRUCT_KIND DREF->COMPONENTS DREF->HAS_INCLUDE.
  DREF->ME_XTYPE = XTYPE.
  DREF->KIND  = KIND_STRUCT.
  RETURNING_REF = DREF.
ENDMETHOD.


method CREATE_XTYP_FROM_STRUC_DESC BY KERNEL MODULE ab_createXtypFromStrucDesc.
endmethod.


method GET.
  data:
    comptab  type struc_comp_tab,   " standard table of struc_comp,
    xtype    like me_xtype.

  if HAS_OPTIMIZED_GET_METHOD eq abap_true.
    comptab = normalize_component_table( p_components ).
    xtype = GET_CACHED_XTYP( desc = comptab strict = p_strict ).
    if xtype-i1 eq 0 and xtype-i2 eq 0. "type not found in cache
      check_component_tab( p_components = p_components
                           p_strict     = p_strict ).
      xtype = CREATE_CACHED_XTYP( desc = comptab strict = p_strict ).
    endif.
  else.
    comptab = check_component_table( p_components = p_components p_strict = p_strict ).
    xtype = GET_XTYP_FROM_STRUC_DESC( comptab ).
  endif.

  p_result ?= get_by_xtype( p_xtype = xtype p_kind = 'S' ).
endmethod.


  method GET_CACHED_XTYP BY KERNEL MODULE ab_getCachedXtypFromStrucDesc FAIL.
  endmethod.


method GET_COMPONENTS.

  p_result = get_components_tab( ).

endmethod.


method GET_COMPONENTS_TAB.

  data: comp    type component,
        scomp   type struc_comp,
        comptab type struc_comp_tab.

  if components_cache is initial.

    comptab = XTYP_TO_STRUC_DESC( me_xtype ).
*    comptab = CL_ABAP_RTTC_XTYP_CONVERTER=>XTYP_TO_STRUCT_DESC( me_xtype ).


    loop at comptab into scomp.
      clear comp.
      comp-name = scomp-name.
      comp-type ?= get_by_xtype( p_xtype = scomp-xtyp p_kind = scomp-type_kind ).
      comp-as_include = scomp-as_include.
      comp-suffix = scomp-suffix.
      append comp to components_cache.
    endloop.

  endif.
  p_result = components_cache.

endmethod.


method get_component_type.

  data: crc type xtype_type,
        res like p_descr_ref.

* get administration information
  system-call describe navigation mode 'C' from me_xtype
    to p_name ' ' into admin_tab_line-xtype crc admin_tab_line-kind.

* look at hash tabel wether descr object already exists
  read table admin_tab from admin_tab_line into admin_tab_line.
  if sy-subrc = 0.
    res ?= admin_tab_line-ref->get( ).
    if res is bound.
      p_descr_ref = res.
      return.
    endif.
    delete table admin_tab from admin_tab_line.
  endif.

* create new descr object
  case admin_tab_line-kind.
    when kind_elem.
      raise event create_elemdescr
        exporting xtype = admin_tab_line-xtype.
    when kind_ref.
      raise event create_refdescr
        exporting xtype = admin_tab_line-xtype.
    when kind_struct.
      raise event create_structdescr
        exporting xtype = admin_tab_line-xtype.
    when kind_table.
      raise event create_tabledescr
        exporting xtype = admin_tab_line-xtype.
    when 'Y'.
      raise unsupported_input_type.
    when others.
*     others error, try upper case
      data p_name_kind type  abap_typekind.
      p_name_kind = cl_abap_datadescr=>get_data_type_kind( p_name ).
      if p_name_kind = typekind_char or p_name_kind = typekind_string.
        data upper_name type string.
        upper_name = p_name.
        translate upper_name to upper case.
*       get administration information
        system-call describe navigation mode 'C' from me_xtype
          to upper_name ' ' into admin_tab_line-xtype crc admin_tab_line-kind.
*       look at hash tabel wether descr object already exists
        read table admin_tab from admin_tab_line into admin_tab_line.
        if sy-subrc = 0.
          res ?= admin_tab_line-ref->get( ).
          if res is bound.
            p_descr_ref = res.
            return.
          endif.
          delete table admin_tab from admin_tab_line.
        endif.
*       create new descr object
        case admin_tab_line-kind.
          when kind_elem.
            raise event create_elemdescr
              exporting xtype = admin_tab_line-xtype.
          when kind_ref.
            raise event create_refdescr
              exporting xtype = admin_tab_line-xtype.
          when kind_struct.
           raise event create_structdescr
              exporting xtype = admin_tab_line-xtype.
          when kind_table.
            raise event create_tabledescr
              exporting xtype = admin_tab_line-xtype.
          when 'Y'.
            raise unsupported_input_type.
          when others.
            raise component_not_found.
        endcase.
      else.
        raise component_not_found.
      endif.
  endcase.

  create object admin_tab_line-ref exporting oref = returning_ref.
  insert admin_tab_line into table admin_tab.
  p_descr_ref ?= returning_ref.
  clear returning_ref.

endmethod.


method GET_DDIC_FIELD_LIST .

  data:
    REL_NAME type DDOBJNAME,
    cache_wa type ddfields_cache_line_type.

  field-symbols:
    <cache_line> type ddfields_cache_line_type.

* first look in cache
  read table me->ddfields_cache assigning <cache_line> with table key langu = p_langu.
  if sy-subrc = 0.
    if <cache_line>-not_found = abap_true.
      raise NOT_FOUND.
    else.
      P_FIELD_LIST = <cache_line>-value->*.
      if P_INCLUDING_SUBSTRUCTRES = ABAP_FALSE.
*       only first level, remove all nested components
        delete P_FIELD_LIST where NOAUTHCH = 'X'.
      endif.
      return.
    endif.
  endif.

* check if structure is dictionary structure
  REL_NAME = ME->GET_RELATIVE_NAME( ).
  if ME->IS_DDIC_TYPE( ) = ABAP_FALSE or REL_NAME is initial.
    raise NO_DDIC_TYPE.
  endif.

* call DDIC interface
  call function 'DDIF_FIELDINFO_GET'
    exporting
      TABNAME              = REL_NAME
*     FIELDNAME            = ' '
      LANGU                = P_LANGU
*     LFIELDNAME           = ' '
      ALL_TYPES            = 'X'
*     GROUP_NAMES          = ' '
*     UCLEN                =
*     DO_NOT_WRITE         = ' '
*   IMPORTING
*     X030L_WA             =
*     DDOBJTYPE            =
*     DFIES_WA             =
*     LINES_DESCR          =
    tables
      DFIES_TAB            = P_FIELD_LIST
*     FIXED_VALUES         =
    exceptions
      NOT_FOUND            = 1
      INTERNAL_ERROR       = 2
      others               = 3
            .
  if SY-SUBRC <> 0.
*   fill cache with negative result
    cache_wa-langu     = p_langu.
    cache_wa-not_found = abap_true.
    insert cache_wa into table me->ddfields_cache.
    raise NOT_FOUND.
  endif.

* fill cache
  cache_wa-langu     = p_langu.
  create data cache_wa-value.
  cache_wa-value->* = P_FIELD_LIST.
  insert cache_wa into table me->ddfields_cache.

  if P_INCLUDING_SUBSTRUCTRES = ABAP_FALSE.
*   only first level, remove all nested components
    delete P_FIELD_LIST where NOAUTHCH = 'X'.
  endif.

endmethod.


method GET_INCLUDED_VIEW.

  if not p_level is supplied.
    p_result = get_included_view_tab( ).
  else.
    p_result = get_included_view_tab( p_level ).
  endif.

endmethod.


method GET_INCLUDED_VIEW_TAB.

  data: comp      type component_table,
        comp_line like line of comp,
        incl_comp type included_view,
        view_comp_line like line of incl_comp,
        incl_type type ref to cl_abap_structdescr.

  comp = get_components_tab( ).
  loop at comp into comp_line.
    if comp_line-as_include = abap_false.
      move-corresponding comp_line to view_comp_line.
      append view_comp_line to p_result.
    else.
      incl_type ?= comp_line-type.
      if not p_level is supplied.
        incl_comp = incl_type->get_included_view_tab( ).
      else.
        if p_level > 0.
          subtract 1 from p_level.
          incl_comp = incl_type->get_included_view_tab( p_level ).
          add 1 to p_level.
        elseif comp_line-name is initial.
          incl_comp = incl_type->get_included_view_tab( 0 ).
        else.
          move-corresponding comp_line to view_comp_line.
          append view_comp_line to p_result.
          continue.
        endif.
      endif.
      loop at incl_comp into view_comp_line.
        concatenate view_comp_line-name comp_line-suffix
          into view_comp_line-name.
        append view_comp_line to p_result.
      endloop.
    endif.
  endloop.

endmethod.


method GET_SYMBOLS.

  p_result = get_symbols_tab( ).

endmethod.


method GET_SYMBOLS_TAB.

  data: comp_tab like components_cache,
        comp     like line of comp_tab,
        symb_tab like p_result,
        symb     like line of symb_tab,
        struct_t type ref to cl_abap_structdescr.

  comp_tab = get_components_tab( ).
  loop at comp_tab into comp.
    if not comp-name is initial.
      move-corresponding comp to symb.
      insert symb into table p_result.
    endif.
    if comp-as_include = abap_true.
      struct_t ?= comp-type.
      symb_tab = struct_t->get_symbols_tab( ).
      loop at symb_tab into symb.
        concatenate symb-name comp-suffix into symb-name.
        insert symb into table p_result.
      endloop.
    endif.
  endloop.

endmethod.


method GET_XTYP_FROM_STRUC_DESC BY KERNEL MODULE ab_getXtypFromStrucDesc FAIL.
endmethod.


METHOD LOAD_CLASS. "#EC NEEDED
"#EC NEEDED
ENDMETHOD.


method NORMALIZE_COMPONENT_TABLE.
  data:
    comp     type component,
    scomp    type struc_comp.
  loop at p_components into comp.
    scomp-name = to_upper( comp-name ).
    if comp-type is initial.
*     component type not defined
      raise exception type CX_SY_STRUCT_COMP_TYPE
        exporting textid = CX_SY_STRUCT_COMP_TYPE=>empty_type
                  component_name = scomp-name
                  component_number = sy-tabix.
    endif.
    scomp-xtyp = comp-type->me_xtype.
    scomp-type_kind = comp-type->kind.
    scomp-as_include = comp-as_include.
    scomp-suffix = to_upper( comp-suffix ).
    append scomp to p_comptab.
  endloop.
endmethod.


method XTYP_TO_STRUC_DESC by KERNEL MODULE ab_xtypToStrucDesc.
endmethod.
ENDCLASS.
