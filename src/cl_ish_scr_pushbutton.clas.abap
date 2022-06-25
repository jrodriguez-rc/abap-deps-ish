class CL_ISH_SCR_PUSHBUTTON definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

*"* public components of class CL_ISH_SCR_PUSHBUTTON
*"* do not include other source files here!!!
public section.

  class-data CO_PBTYPE_ICON2 type I value 1 .
  class-data CO_PBTYPE_ICON4 type I value 2 .
  class-data CO_PBTYPE_TEXT10 type I value 3 .
  class-data CO_PBTYPE_TEXT12 type I value 4 .
  class-data CO_PBTYPE_TEXT15 type I value 5 .
  class-data CO_PBNAME_PREFIX type STRING value 'PB' .
  class-data CO_MAX_ICON2 type I value 200 .
  class-data CO_MAX_ICON4 type I value 6 .
  class-data CO_MAX_TEXT10 type I value 50 .
  class-data CO_MAX_TEXT12 type I value 50 .
  class-data CO_MAX_TEXT15 type I value 10 .
  constants CO_OTYPE_SCR_PUSHBUTTON type ISH_OBJECT_TYPE value 7080. "#EC NOTEXT

  class-methods CLASS_CONSTRUCTOR .
  class-methods CHECKOUT
    importing
      value(I_PBTYPE) type I
      value(I_ICON) type N1_ICON optional
      value(I_INFO) type STRING optional
      value(I_TEXT) type STRING optional
      value(I_ACTIVE) type ISH_ON_OFF default ON
      value(I_INPUT) type ISH_ON_OFF default ON
    exporting
      value(ER_SCR_PUSHBUTTON) type ref to CL_ISH_SCR_PUSHBUTTON
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FREE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_PROPERTIES
    exporting
      value(E_ACTIVE) type ISH_ON_OFF
      value(E_INPUT) type ISH_ON_OFF
      value(E_ICON) type STRING
      value(E_INFO) type STRING
      value(E_TEXT) type STRING .
  methods GET_ACTIVE
    returning
      value(R_ACTIVE) type ISH_ON_OFF .
  methods GET_ICON
    returning
      value(R_ICON) type N1_ICON .
  methods GET_INFO
    returning
      value(R_INFO) type STRING .
  methods GET_INPUT
    returning
      value(R_INPUT) type ISH_ON_OFF .
  methods GET_PBNAME
    returning
      value(R_PBNAME) type STRING .
  methods GET_PBSTRING
    returning
      value(R_PBSTRING) type STRING .
  methods GET_TEXT
    returning
      value(R_TEXT) type STRING .
  methods GET_UCOMM
    returning
      value(R_UCOMM) type SY-UCOMM .
  methods SET_PROPERTIES
    importing
      value(I_ACTIVE) type ISH_ON_OFF optional
      value(I_ACTIVE_X) type ISH_ON_OFF default OFF
      value(I_INPUT) type ISH_ON_OFF optional
      value(I_INPUT_X) type ISH_ON_OFF default OFF
      value(I_ICON) type N1_ICON optional
      value(I_ICON_X) type ISH_ON_OFF default OFF
      value(I_INFO) type STRING optional
      value(I_INFO_X) type ISH_ON_OFF default OFF
      value(I_TEXT) type STRING optional
      value(I_TEXT_X) type ISH_ON_OFF default OFF .
  methods SET_ACTIVE
    importing
      value(I_ACTIVE) type ISH_ON_OFF default ON .
  methods SET_ICON
    importing
      value(I_ICON) type N1_ICON .
  methods SET_INFO
    importing
      value(I_INFO) type STRING .
  methods SET_INPUT
    importing
      value(I_INPUT) type ISH_ON_OFF default ON .
  methods SET_TEXT
    importing
      value(I_TEXT) type STRING .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_PUSHBUTTON
*"* do not include other source files here!!!

  class-data GT_FREE_PB_ICON2 type ISH_T_PUSHBUTTON .
  class-data GT_FREE_PB_ICON4 type ISH_T_PUSHBUTTON .
  class-data GT_FREE_PB_TEXT10 type ISH_T_PUSHBUTTON .
  class-data GT_FREE_PB_TEXT12 type ISH_T_PUSHBUTTON .
  class-data GT_FREE_PB_TEXT15 type ISH_T_PUSHBUTTON .
  data G_PBTYPE type I .
  data G_ICON type N1_ICON .
  data G_INFO type STRING .
  data G_TEXT type STRING .
  data G_ACTIVE type ISH_ON_OFF .
  data G_INPUT type ISH_ON_OFF .
  data GS_PB type RN1_PUSHBUTTON .

  class-methods CREATE
    importing
      value(I_PBTYPE) type I
      value(I_DYNNR) type SY-DYNNR
    exporting
      !ER_INSTANCE type ref to CL_ISH_SCR_PUSHBUTTON
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods COMPLETE_CONSTRUCTION
    importing
      value(I_PBTYPE) type I
      value(I_DYNNR) type SY-DYNNR
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods MODIFY_SCREEN_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_PUSHBUTTON
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_PUSHBUTTON IMPLEMENTATION.


METHOD checkout .

  DATA: ls_pb  TYPE rn1_pushbutton.

  FIELD-SYMBOLS: <lt_free_pb>  TYPE ish_t_pushbutton.

* Initializations
  CLEAR: e_rc,
         er_scr_pushbutton.

* On which gt_free_* to work?
  CASE i_pbtype.
    WHEN co_pbtype_icon2.
      ASSIGN gt_free_pb_icon2 TO <lt_free_pb>.
    WHEN co_pbtype_icon4.
      ASSIGN gt_free_pb_icon2 TO <lt_free_pb>.
    WHEN co_pbtype_text10.
      ASSIGN gt_free_pb_text10 TO <lt_free_pb>.
    WHEN co_pbtype_text12.
      ASSIGN gt_free_pb_text12 TO <lt_free_pb>.
    WHEN co_pbtype_text15.
      ASSIGN gt_free_pb_text15 TO <lt_free_pb>.
    WHEN OTHERS.
      e_rc = 1.
      EXIT.
  ENDCASE.

* Get the first free pushbutton.
  READ TABLE <lt_free_pb> INTO ls_pb INDEX 1.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the pushbutton is not already instantiated -> create it.
  IF ls_pb-pbobject IS INITIAL.
    CALL METHOD cl_ish_scr_pushbutton=>create
      EXPORTING
        i_pbtype        = i_pbtype
        i_dynnr         = ls_pb-dynnr
      IMPORTING
        er_instance     = ls_pb-pbobject
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Set pushbutton data.
  CALL METHOD ls_pb-pbobject->set_properties
    EXPORTING
      i_active   = i_active
      i_active_x = on
      i_input    = i_input
      i_input_x  = on
      i_icon     = i_icon
      i_icon_x   = on
      i_info     = i_info
      i_info_x   = on
      i_text     = i_text
      i_text_x   = on.

* Pushbutton is not free any more -> delete it.
  DELETE TABLE <lt_free_pb> FROM ls_pb.

* Export the pushbutton object.
  er_scr_pushbutton = ls_pb-pbobject.

ENDMETHOD.


METHOD class_constructor .

  DATA: ls_pb  TYPE rn1_pushbutton.

* Icon2 pushbuttons.
* Set starting dynnr.
  ls_pb-dynnr = '100'.
* Append entries for all possible pushbuttons.
  DO co_max_icon2 TIMES.
    APPEND ls_pb TO gt_free_pb_icon2.
    ls_pb-dynnr = ls_pb-dynnr + 1.
  ENDDO.

* Icon4 pushbuttons.
* Set starting dynnr.
  ls_pb-dynnr = '300'.
* Append entries for all possible pushbuttons.
  DO co_max_icon4 TIMES.
    APPEND ls_pb TO gt_free_pb_icon4.
    ls_pb-dynnr = ls_pb-dynnr + 1.
  ENDDO.

* Text10 pushbuttons.
* Set starting dynnr.
  ls_pb-dynnr = '500'.
* Append entries for all possible dynnr.
  DO co_max_text10 TIMES.
    APPEND ls_pb TO gt_free_pb_text10.
    ls_pb-dynnr = ls_pb-dynnr + 1.
  ENDDO.

* Text12 pushbuttons.
* Set starting dynnr.
  ls_pb-dynnr = '550'.
* Append entries for all possible dynnr.
  DO co_max_text12 TIMES.
    APPEND ls_pb TO gt_free_pb_text12.
    ls_pb-dynnr = ls_pb-dynnr + 1.
  ENDDO.

* Text15 pushbuttons.
* Set starting dynnr.
  ls_pb-dynnr = '600'.
* Append entries for all possible dynnr.
  DO co_max_text15 TIMES.
    APPEND ls_pb TO gt_free_pb_text15.
    ls_pb-dynnr = ls_pb-dynnr + 1.
  ENDDO.

ENDMETHOD.


METHOD complete_construction .

* Set pbtype.
  g_pbtype = i_pbtype.

* Set parent.
  CLEAR gs_parent.
  gs_parent-repid = 'SAPLN1_SDY_PUSHBUTTON'.
  gs_parent-dynnr = i_dynnr.
  gs_parent-type  = co_scr_parent_type_dynpro.

ENDMETHOD.


METHOD create .

* Create object
  CREATE OBJECT er_instance.

* Complete construction.
  CALL METHOD er_instance->complete_construction
    EXPORTING
      i_pbtype        = i_pbtype
      i_dynnr         = i_dynnr
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD free .

  DATA: ls_pb     TYPE rn1_pushbutton.

  FIELD-SYMBOLS: <lt_free_pb>  TYPE ish_t_pushbutton.

* Initializations
  CLEAR: e_rc.

* On whitch gt_free_pb_* to work?
  CASE g_pbtype.
    WHEN co_pbtype_icon2.
      ASSIGN gt_free_pb_icon2 TO <lt_free_pb>.
    WHEN co_pbtype_icon4.
      ASSIGN gt_free_pb_icon4 TO <lt_free_pb>.
    WHEN co_pbtype_text10.
      ASSIGN gt_free_pb_text10 TO <lt_free_pb>.
    WHEN co_pbtype_text12.
      ASSIGN gt_free_pb_text12 TO <lt_free_pb>.
    WHEN co_pbtype_text15.
      ASSIGN gt_free_pb_text15 TO <lt_free_pb>.
    WHEN OTHERS.
      EXIT.
  ENDCASE.

* Build ls_pb.
  ls_pb-dynnr    = gs_parent-dynnr.
  ls_pb-pbobject = me.

* Is self already free?
  READ TABLE <lt_free_pb> FROM ls_pb TRANSPORTING NO FIELDS.
  CHECK sy-subrc <> 0.

* Set self as free.
  APPEND ls_pb TO <lt_free_pb>.

ENDMETHOD.


METHOD get_active .

  r_active = g_active.

ENDMETHOD.


METHOD get_icon .

  r_icon = g_icon.

ENDMETHOD.


method GET_INFO .

  r_info = g_info.

endmethod.


METHOD get_input .

  r_input = g_input.

ENDMETHOD.


METHOD get_pbname .

  CONCATENATE co_pbname_prefix
              gs_parent-dynnr
         INTO r_pbname
    SEPARATED BY '_'.

ENDMETHOD.


METHOD get_pbstring .

* Generate the pushbutton string.

  IF g_icon = icon_space.
*   If the pushbutton has no icon, build the pushbutton string.
    IF NOT g_info IS INITIAL.
      CONCATENATE '@\Q'
                  g_info
                  '@'
                  space
             INTO r_pbstring.
    ENDIF.
    CONCATENATE r_pbstring
                g_text
           INTO r_pbstring.
  ELSE.
*   If the pushbutton has an icon, use ICON_CREATE.
    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name   = g_icon
        text   = g_text
        info   = g_info
      IMPORTING
        RESULT = r_pbstring.
  ENDIF.

ENDMETHOD.


METHOD get_properties .

  e_active  = g_active.
  e_input   = g_input.
  e_icon    = g_icon.
  e_info    = g_info.
  e_text    = g_text.

ENDMETHOD.


METHOD get_text .

  r_text = g_text.

ENDMETHOD.


METHOD get_ucomm .

  CONCATENATE co_pbname_prefix
              gs_parent-dynnr
         INTO r_ucomm
    SEPARATED BY '_'.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_scr_pushbutton.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_pushbutton.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~destroy .

  DATA: l_rc      TYPE ish_method_rc,
        ls_parent TYPE rnscr_parent.

* Self is not free no more.
* the free-method has to be called now before
* the destroy-method of the super-class will be called,
* because now in the superclass the DYNNR will be cleared.
  CALL METHOD free
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* save parent
  ls_parent = gs_parent.

* Destroy of super class(es).
  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
*   In case of errors do not exit here
*   but try to free selfs dynnr.
    e_rc = l_rc.
  ENDIF.

** Self is not free no more.
*  CALL METHOD free
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*    EXIT.
*  ENDIF.

* set parent again
  gs_parent = ls_parent.

ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .

  CALL FUNCTION 'ISH_SDY_PUSHBUTTON_INIT'
    EXPORTING
      ir_scr_pushbutton = me
    IMPORTING
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD initialize_field_values .

* Not needed.

ENDMETHOD.


METHOD modify_screen_internal .

  DATA: l_pbname  TYPE string.

* Get pushbutton name.
  l_pbname = get_pbname( ).

* Has pushbutton already been modified?
  READ TABLE it_modified
    WITH KEY name = l_pbname
    TRANSPORTING NO FIELDS.
  CHECK NOT sy-subrc = 0.

* Pushbutton has not already been modified -> modify now.
  LOOP AT SCREEN.
    IF screen-name = l_pbname.
      IF g_active = off.
        screen-active = 0.
      ELSE.
        screen-active = 1.
      ENDIF.
      IF g_input = off.
        screen-input = 0.
      ELSE.
        screen-input = 1.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD set_active .

  g_active = i_active.

ENDMETHOD.


METHOD set_icon .

  g_icon = i_icon.

ENDMETHOD.


METHOD set_info .

  g_info = i_info.

ENDMETHOD.


METHOD set_input .

  g_input = i_input.

ENDMETHOD.


METHOD set_properties .

  IF i_active_x = on.
    g_active = i_active.
  ENDIF.
  IF i_input_x = on.
    g_input = i_input.
  ENDIF.
  IF i_icon_x = on.
    g_icon = i_icon.
  ENDIF.
  IF i_info_x = on.
    g_info = i_info.
  ENDIF.
  IF i_text_x = on.
    g_text = i_text.
  ENDIF.

ENDMETHOD.


METHOD set_text .

  g_text = i_text.

ENDMETHOD.
ENDCLASS.
