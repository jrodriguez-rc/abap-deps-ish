class CL_ISH_SCR_LISTBOX definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

*"* public components of class CL_ISH_SCR_LISTBOX
*"* do not include other source files here!!!
public section.

  constants CO_LBNAME_PREFIX type STRING value 'GS_LB_'. "#EC NOTEXT
  data G_FIELDNAME_TOOLTIP type STRING .
  data CO_LBNAME_TOOLTIP type STRING value 'LB_TOOLTIP' .
  constants CO_LBUCOMM_PREFIX type STRING value 'LB'. "#EC NOTEXT
  constants CO_LBTYPE_LB10 type I value 10. "#EC NOTEXT
  constants CO_LBTYPE_LB12 type I value 12. "#EC NOTEXT
  constants CO_LBTYPE_LB8 type I value 8. "#EC NOTEXT
  constants CO_LBTYPE_LB15 type I value 15. "#EC NOTEXT
  constants CO_LBTYPE_LB15F type I value 1015. "#EC NOTEXT
  constants CO_LBTYPE_LB23F type I value 1023. "#EC NOTEXT
  constants CO_LBTYPE_LB18 type I value 18. "#EC NOTEXT
  constants CO_MAX_LB10 type I value 10. "#EC NOTEXT
  constants CO_MAX_LB12 type I value 50. "#EC NOTEXT
  constants CO_MAX_LB15 type I value 50. "#EC NOTEXT
  constants CO_MAX_LB15F type I value 50. "#EC NOTEXT
  constants CO_MAX_LB8 type I value 10. "#EC NOTEXT
  constants CO_MAX_LB23F type I value 50. "#EC NOTEXT
  constants CO_MAX_LB18 type I value 50. "#EC NOTEXT
  constants CO_OTYPE_SCR_LISTBOX type ISH_OBJECT_TYPE value 7079. "#EC NOTEXT

  methods GET_LB_TOOLTIP
    returning
      value(R_FIELDNAME_TOOLTIP) type STRING .
  class-methods CHECKOUT
    importing
      value(I_LBTYPE) type I
      !IR_LISTBOX type ref to CL_ISH_LISTBOX optional
      value(I_ACTIVE) type ISH_ON_OFF default ON
      value(I_INPUT) type ISH_ON_OFF default ON
      value(I_REQUIRED) type ISH_ON_OFF default OFF
    exporting
      !ER_SCR_LISTBOX type ref to CL_ISH_SCR_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CLASS_CONSTRUCTOR .
  methods FREE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ACTIVE
    returning
      value(R_ACTIVE) type ISH_ON_OFF .
  methods GET_HELP_INFO
    returning
      value(RS_HELP_INFO) type HELP_INFO .
  methods GET_INPUT
    returning
      value(R_INPUT) type ISH_ON_OFF .
  methods GET_LBNAME
    returning
      value(R_LBNAME) type STRING .
  methods GET_LISTBOX
    returning
      value(RR_LISTBOX) type ref to CL_ISH_LISTBOX .
  methods GET_PROPERTIES
    exporting
      value(E_ACTIVE) type ISH_ON_OFF
      value(E_INPUT) type ISH_ON_OFF
      value(E_REQUIRED) type ISH_ON_OFF
      value(ER_LISTBOX) type ref to CL_ISH_LISTBOX .
  methods GET_REQUIRED
    returning
      value(R_REQUIRED) type ISH_ON_OFF .
  methods GET_UCOMM
    returning
      value(R_UCOMM) type SY-UCOMM .
  methods GET_VALUE
    returning
      value(R_VALUE) type NFVVALUE .
  methods SET_ACTIVE
    importing
      value(I_ACTIVE) type ISH_ON_OFF .
  methods SET_HELP_INFO
    importing
      value(IS_HELP_INFO) type HELP_INFO .
  methods SET_INPUT
    importing
      value(I_INPUT) type ISH_ON_OFF .
  methods SET_LISTBOX
    importing
      !IR_LISTBOX type ref to CL_ISH_LISTBOX .
  methods SET_PROPERTIES
    importing
      value(I_ACTIVE) type ISH_ON_OFF optional
      value(I_ACTIVE_X) type ISH_ON_OFF default OFF
      value(I_INPUT) type ISH_ON_OFF optional
      value(I_INPUT_X) type ISH_ON_OFF default OFF
      value(I_REQUIRED) type ISH_ON_OFF
      value(I_REQUIRED_X) type ISH_ON_OFF default OFF
      !IR_LISTBOX type ref to CL_ISH_LISTBOX optional
      value(I_LISTBOX_X) type ISH_ON_OFF default OFF .
  methods SET_REQUIRED
    importing
      value(I_REQUIRED) type ISH_ON_OFF .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~CREATE_ALL_LISTBOXES
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_LISTBOX
*"* do not include other source files here!!!

  data GR_LISTBOX type ref to CL_ISH_LISTBOX .
  data GS_HELP_INFO type HELP_INFO .
  class-data GT_FREE_LB10 type ISH_T_SCR_LISTBOX .
  class-data GT_FREE_LB12 type ISH_T_SCR_LISTBOX .
  class-data GT_FREE_LB15 type ISH_T_SCR_LISTBOX .
  class-data GT_FREE_LB15F type ISH_T_SCR_LISTBOX .
  class-data GT_FREE_LB8 type ISH_T_SCR_LISTBOX .
  class-data GT_FREE_LB23F type ISH_T_SCR_LISTBOX .
  class-data GT_FREE_LB18 type ISH_T_SCR_LISTBOX .
  data G_ACTIVE type ISH_ON_OFF .
  data G_FIELDNAME type ISH_FIELDNAME .
  data G_INPUT type ISH_ON_OFF .
  data G_LBTYPE type I .
  data G_REQUIRED type ISH_ON_OFF .

  methods COMPLETE_CONSTRUCTION
    importing
      value(I_LBTYPE) type I
      value(I_DYNNR) type SY-DYNNR
      !IR_LISTBOX type ref to CL_ISH_LISTBOX
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CREATE
    importing
      value(I_LBTYPE) type I
      value(I_DYNNR) type SY-DYNNR
      !IR_LISTBOX type ref to CL_ISH_LISTBOX
    exporting
      !ER_INSTANCE type ref to CL_ISH_SCR_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods HELP_REQUEST_INTERNAL
    redefinition .
  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods MODIFY_SCREEN_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_LISTBOX
*"* do not include other source files here!!!

  data CO_LBNAME type STRING value 'LB_VALUE' .
ENDCLASS.



CLASS CL_ISH_SCR_LISTBOX IMPLEMENTATION.


METHOD checkout .

  DATA: ls_lb  TYPE rn1_scr_listbox.

  FIELD-SYMBOLS: <lt_free_lb>  TYPE ish_t_scr_listbox.

* Initializations
  CLEAR: e_rc,
         er_scr_listbox.

* On which gt_free_* to work?
  CASE i_lbtype.
    WHEN co_lbtype_lb8.
      ASSIGN gt_free_lb8 TO <lt_free_lb>.
    WHEN co_lbtype_lb10.
      ASSIGN gt_free_lb10 TO <lt_free_lb>.
    WHEN co_lbtype_lb12.
      ASSIGN gt_free_lb12 TO <lt_free_lb>.
    WHEN co_lbtype_lb15.
      ASSIGN gt_free_lb15 TO <lt_free_lb>.
    WHEN co_lbtype_lb15f.
      ASSIGN gt_free_lb15f TO <lt_free_lb>.
    WHEN co_lbtype_lb23f.
      ASSIGN gt_free_lb23f TO <lt_free_lb>.
    WHEN co_lbtype_lb18.
      ASSIGN gt_free_lb18 TO <lt_free_lb>.
    WHEN OTHERS.
      e_rc = 1.
      EXIT.
  ENDCASE.

* Get the first free listbox.
  READ TABLE <lt_free_lb> INTO ls_lb INDEX 1.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* If the listbox is not already instantiated -> create it.
  IF ls_lb-lbobject IS INITIAL.
    CALL METHOD cl_ish_scr_listbox=>create
      EXPORTING
        i_lbtype        = i_lbtype
        i_dynnr         = ls_lb-dynnr
        ir_listbox      = ir_listbox
      IMPORTING
        er_instance     = ls_lb-lbobject
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Set listbox data.
  CALL METHOD ls_lb-lbobject->set_properties
    EXPORTING
      i_active     = i_active
      i_active_x   = on
      i_input      = i_input
      i_input_x    = on
      i_required   = i_required   "RW ID 15481
      i_required_x = on.          "RW ID 15481

* listbox is not free any more -> delete it.
  DELETE TABLE <lt_free_lb> FROM ls_lb.

* Export the listbox object.
  er_scr_listbox = ls_lb-lbobject.

ENDMETHOD.


METHOD class_constructor .

  DATA: ls_lb  TYPE rn1_scr_listbox.

* lb8 listboxes.
* Set starting dynnr.
  ls_lb-dynnr = '300'.
* Append entries for all possible listboxes.
  DO co_max_lb8 TIMES.
    APPEND ls_lb TO gt_free_lb8.
    ls_lb-dynnr = ls_lb-dynnr + 1.
  ENDDO.

* lb10 listboxes.
* Set starting dynnr.
  ls_lb-dynnr = '100'.
* Append entries for all possible listboxes.
  DO co_max_lb10 TIMES.
    APPEND ls_lb TO gt_free_lb10.
    ls_lb-dynnr = ls_lb-dynnr + 1.
  ENDDO.

* lb12 listboxes.
* Set starting dynnr.
  ls_lb-dynnr = '200'.
* Append entries for all possible listboxes.
  DO co_max_lb12 TIMES.
    APPEND ls_lb TO gt_free_lb12.
    ls_lb-dynnr = ls_lb-dynnr + 1.
  ENDDO.

* lb15 listboxes
* Set starting dynnr.
  ls_lb-dynnr = '600'.
* Append entries for all possible listboxes
  DO co_max_lb15 TIMES.
    APPEND ls_lb TO gt_free_lb15.
    ls_lb-dynnr = ls_lb-dynnr + 1.
  ENDDO.

* lb15f listboxes with functioncode
* Set starting dynnr.
  ls_lb-dynnr = '650'.
* Append entries for all possible listboxes
  DO co_max_lb15f TIMES.
    APPEND ls_lb TO gt_free_lb15f.
    ls_lb-dynnr = ls_lb-dynnr + 1.
  ENDDO.

* lb18 listboxes.
* Set starting dynnr.
  ls_lb-dynnr = '500'.
* Append entries for all possible listboxes.
  DO co_max_lb18 TIMES.
    APPEND ls_lb TO gt_free_lb18.
    ls_lb-dynnr = ls_lb-dynnr + 1.
  ENDDO.

* lb23 listboxes.
* Set starting dynnr.
  ls_lb-dynnr = '400'.
* Append entries for all possible listboxes.
  DO co_max_lb23f TIMES.
    APPEND ls_lb TO gt_free_lb23f.
    ls_lb-dynnr = ls_lb-dynnr + 1.
  ENDDO.

ENDMETHOD.


METHOD complete_construction .

  DATA: l_dynnr_string  TYPE string.

* Set lbtype.
  g_lbtype = i_lbtype.

* Set parent.
  CLEAR gs_parent.
  gs_parent-repid = 'SAPLN1_SDY_LISTBOX'.
  gs_parent-dynnr = i_dynnr.
  gs_parent-type  = co_scr_parent_type_dynpro.

* Set g_fieldname.
  l_dynnr_string = i_dynnr.
  CONCATENATE co_lbname_prefix
              l_dynnr_string
         INTO g_fieldname.
* Begin, Siegl, 14.02.2005, ID 15283
*   SEPARATED BY '_'.
  CONCATENATE g_fieldname
              co_lbname
              INTO g_fieldname SEPARATED BY '-'.

  CONCATENATE co_lbname_prefix
              l_dynnr_string
              INTO g_fieldname_tooltip.

  CONCATENATE g_fieldname_tooltip
              co_lbname_tooltip
              INTO g_fieldname_tooltip SEPARATED BY '-'.

* End, Siegl, 14.02.2005, ID 15283
* Set gr_listbox.
  gr_listbox = ir_listbox.

ENDMETHOD.


METHOD create .

* Create object
  CREATE OBJECT er_instance.

* Complete construction.
  CALL METHOD er_instance->complete_construction
    EXPORTING
      i_lbtype        = i_lbtype
      i_dynnr         = i_dynnr
      ir_listbox      = ir_listbox
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD free .

  DATA: ls_lb     TYPE rn1_scr_listbox.

  FIELD-SYMBOLS: <lt_free_lb>  TYPE ish_t_scr_listbox.

* Initializations
  CLEAR: e_rc.

* On whitch gt_free_lb_* to work?
  CASE g_lbtype.
    WHEN co_lbtype_lb8.
      ASSIGN gt_free_lb8 TO <lt_free_lb>.
    WHEN co_lbtype_lb10.
      ASSIGN gt_free_lb10 TO <lt_free_lb>.
    WHEN co_lbtype_lb12.
      ASSIGN gt_free_lb12 TO <lt_free_lb>.
    WHEN co_lbtype_lb15.
      ASSIGN gt_free_lb15 TO <lt_free_lb>.
    WHEN co_lbtype_lb15f.
      ASSIGN gt_free_lb15f TO <lt_free_lb>.
    WHEN co_lbtype_lb23f.
      ASSIGN gt_free_lb23f TO <lt_free_lb>.
    WHEN co_lbtype_lb18.
      ASSIGN gt_free_lb18 TO <lt_free_lb>.
    WHEN OTHERS.
      EXIT.
  ENDCASE.

* Build ls_lb.
  ls_lb-dynnr    = gs_parent-dynnr.
  ls_lb-lbobject = me.

* Is self already free?
  READ TABLE <lt_free_lb> FROM ls_lb TRANSPORTING NO FIELDS.
  CHECK sy-subrc <> 0.

* Set self as free.
  APPEND ls_lb TO <lt_free_lb>.

ENDMETHOD.


METHOD get_active .

  r_active = g_active.

ENDMETHOD.


METHOD get_help_info .

  rs_help_info = gs_help_info.

ENDMETHOD.


METHOD get_input .

  r_input = g_input.

ENDMETHOD.


METHOD get_lbname .

  r_lbname = g_fieldname.

ENDMETHOD.


METHOD get_lb_tooltip.
  r_fieldname_tooltip = g_fieldname_tooltip.
ENDMETHOD.


METHOD get_listbox .

  rr_listbox = gr_listbox.

ENDMETHOD.


METHOD get_properties .

  e_active   = g_active.
  e_input    = g_input.
  e_required = g_required.
  er_listbox = gr_listbox.

ENDMETHOD.


METHOD get_required.

  r_required = g_required.

ENDMETHOD.


METHOD get_ucomm .

  CONCATENATE co_lbucomm_prefix
              gs_parent-dynnr
         INTO r_ucomm
    SEPARATED BY '_'.

ENDMETHOD.


METHOD get_value .

  DATA: ls_field_val        TYPE rnfield_value,
        l_rc                TYPE ish_method_rc.

* Initializations.
  CLEAR r_value.

  CHECK NOT gr_screen_values IS INITIAL.

* Get value from field values
  CALL METHOD gr_screen_values->get_data
    EXPORTING
      i_fieldname   = g_fieldname
      i_type        = co_fvtype_single
    IMPORTING
      e_field_value = ls_field_val
      e_rc          = l_rc.
  CHECK l_rc = 0.

* Export
  r_value = ls_field_val-value.

ENDMETHOD.


METHOD help_request_internal .

  DATA: ls_help_info        TYPE help_info,
        lt_dynpselect       TYPE TABLE OF dselc,
        lt_dynpvaluetab     TYPE TABLE OF dval,
        l_ucomm             TYPE sy-ucomm.

  CLEAR: ls_help_info, lt_dynpselect[], lt_dynpvaluetab[].

* If self cannot handle f1 for i_fielname -> raise event.
  IF i_fieldname <> get_lbname( ).
    CONCATENATE if_ish_screen=>co_ucomm_scr_help_request
                i_fieldname
           INTO l_ucomm
      SEPARATED BY '-'.
    CALL METHOD raise_ev_user_command
      EXPORTING
        ir_screen = me
        i_ucomm   = l_ucomm.
    e_called = on.
    EXIT.
  ENDIF.

* Get help info.
  CALL METHOD get_help_info
    RECEIVING
      rs_help_info = ls_help_info.

* Further processing only if there is a help info.
  CHECK NOT ls_help_info IS INITIAL.

* show help information
  CALL FUNCTION 'HELP_START'
    EXPORTING
      help_infos   = ls_help_info
    TABLES
      dynpselect   = lt_dynpselect
      dynpvaluetab = lt_dynpvaluetab.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_scr_listbox.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_listbox.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~create_all_listboxes .

  DATA: lt_vrm_values  TYPE vrm_values,
        l_vrm_id       TYPE vrm_id.

* Get the listbox entries (vrm_values).
  IF NOT gr_listbox IS INITIAL.
    lt_vrm_values = gr_listbox->get_vrm_values( ).
  ENDIF.

* Set vrm values.
  l_vrm_id = g_fieldname.
  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = l_vrm_id
      values          = lt_vrm_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.
  e_rc = sy-subrc.

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

* Begin, Siegl, 14.02.2005, ID 15283
* Get the number of the Dynpro (Listbox)
  DATA: ls_parent TYPE rnscr_parent,
        l_string  TYPE string.

  CALL METHOD me->if_ish_screen~get_parent
    IMPORTING
      es_parent = ls_parent.

  CHECK NOT ls_parent-dynnr IS INITIAL.

  CONCATENATE co_lbname_prefix ls_parent-dynnr INTO l_string.

* End, Siegl, 14.02.2005, ID 15283

  CALL FUNCTION 'ISH_SDY_LISTBOX_INIT'
    EXPORTING
      i_string        = l_string
      ir_scr_listbox  = me
    IMPORTING
      er_scr_data     = gr_scr_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy.
* Begin, Siegl, 15.02.2005, ID 15283
* local tables
  DATA: lt_field_val             TYPE ish_t_field_value.
* definitions
  DATA: l_rc                     TYPE ish_method_rc,
        l_prefix                 TYPE string,
        l_fieldname              TYPE ish_fieldname.
* field symbols
  FIELD-SYMBOLS:
        <ls_data>                TYPE ANY,
        <ls_data_tmp>            TYPE ANY,
        <l_field>                TYPE ANY,
        <l_field_x>              TYPE ANY,
        <ls_field_val>           LIKE LINE OF lt_field_val.
* object references
  DATA: lr_error                 TYPE REF TO cl_ishmed_errorhandling.
* references
  DATA: lr_data_tmp              TYPE REF TO data.

* ---------- ---------- ----------
* first get field values in extern format
  CALL METHOD me->get_fields
    EXPORTING
      i_conv_to_extern = on
    IMPORTING
      et_field_values  = lt_field_val
      e_rc             = l_rc
    CHANGING
      c_errorhandler   = lr_error.
  IF l_rc <> 0.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  CHECK NOT gr_scr_data IS INITIAL.
  ASSIGN gr_scr_data->* TO <ls_data>.
  CHECK sy-subrc = 0.

* work on temporary data
  CREATE DATA lr_data_tmp LIKE <ls_data>.
  ASSIGN lr_data_tmp->* TO <ls_data_tmp>.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* take care that you don't loose values
  <ls_data_tmp> = <ls_data>.

  LOOP AT lt_field_val ASSIGNING <ls_field_val>.
    SPLIT <ls_field_val>-fieldname AT '-' INTO l_prefix l_fieldname.

    ASSIGN COMPONENT l_fieldname OF STRUCTURE <ls_data_tmp>
         TO <l_field>.
    IF sy-subrc = 0.
* take into account the value type
      CASE <ls_field_val>-type.
        WHEN co_fvtype_identify.
          <l_field> ?= <ls_field_val>-object.
        WHEN co_fvtype_single.
          <l_field> = <ls_field_val>-value.
      ENDCASE.
    ELSE.
      CONTINUE.
    ENDIF.

  ENDLOOP.
  <ls_data> = <ls_data_tmp>.
*  End, Siegl, 15.02.2005, ID 15283
ENDMETHOD.


METHOD initialize_field_values .

  DATA: ls_field_val  TYPE rnfield_value,
        lt_field_val  TYPE ish_t_field_value.

* Initializations.
  e_rc = 0.
  REFRESH lt_field_val.

* Build fieldvalues.
  CLEAR ls_field_val.
  ls_field_val-fieldname = g_fieldname.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
* Begin, Siegl, 14.02.2005, ID 15283
  CLEAR ls_field_val.
  ls_field_val-fieldname = g_fieldname_tooltip.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
* End, Siegl, 14.02.2005, ID 15283
* Set screen values
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      it_field_values = lt_field_val
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD modify_screen_internal .

  DATA: l_lbname  TYPE string.

* Get listbox name.
  l_lbname = get_lbname( ).

* Has listbox already been modified?
  READ TABLE it_modified
    WITH KEY name = l_lbname
    TRANSPORTING NO FIELDS.
  CHECK NOT sy-subrc = 0.

* Listbox has not already been modified -> modify now.
  LOOP AT SCREEN.
    IF screen-name = l_lbname.
      IF g_active = off.
        screen-active = 0.
      ELSEIF g_input = off.
        screen-input = 0.
      ENDIF.
*     RW ID 15481 - BEGIN
      IF g_active   = on AND
         g_input    = on.
        IF g_required = on.
          screen-required = 1.
        ENDIF.
      ENDIF.
*     RW ID 15481 - END
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD set_active .

  g_active = i_active.

ENDMETHOD.


METHOD set_help_info .

  gs_help_info = is_help_info.

ENDMETHOD.


METHOD set_input .

  g_input = i_input.

ENDMETHOD.


METHOD set_listbox .

  gr_listbox = ir_listbox.

ENDMETHOD.


METHOD set_properties .

  IF i_active_x = on.
    g_active = i_active.
  ENDIF.
  IF i_input_x = on.
    g_input = i_input.
  ENDIF.
  IF i_required_x = on.
    g_required = i_required.
  ENDIF.
  IF i_listbox_x = on.
    gr_listbox = ir_listbox.
  ENDIF.

ENDMETHOD.


METHOD set_required.

  g_required = i_required.

ENDMETHOD.
ENDCLASS.
