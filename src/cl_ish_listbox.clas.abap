class CL_ISH_LISTBOX definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_LISTBOX
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .

  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .

  constants CO_LISTB_DYNPRO type NLISTBOX_TYPE value 'DY'. "#EC NOTEXT
  constants CO_LISTB_ALVGRID type NLISTBOX_TYPE value 'AG'. "#EC NOTEXT

  methods DESTROY
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  type-pools VRM .
  methods GET_VRM_VALUES
    returning
      value(RT_VRM_VALUES) type VRM_VALUES .
  methods GET_FIRST_KEY
    returning
      value(R_KEY) type VRM_VALUE-KEY .
  methods GET_HANDLE
    returning
      value(R_HANDLE) type INT4 .
  methods GET_VRM_KEY
    importing
      value(I_VRM_TEXT) type VRM_VALUE-TEXT
    returning
      value(R_VRM_KEY) type VRM_VALUE-KEY .
  methods GET_VRM_TEXT
    importing
      value(I_VRM_KEY) type VRM_VALUE-KEY
    returning
      value(R_VRM_TEXT) type VRM_VALUE-TEXT .
  methods HAS_KEY
    importing
      value(I_KEY) type VRM_VALUE-KEY
    returning
      value(R_HAS_KEY) type ISH_ON_OFF .
  methods GET_DROP_DOWN_VALUES
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_HANDLE) type INT4
      value(ET_DROP_DOWN_ALIAS) type LVC_T_DRAL .
protected section.
*"* protected components of class CL_ISH_LISTBOX
*"* do not include other source files here!!!

  class-data GT_LISTBOX type ISH_T_LISTBOX .
  type-pools VRM .
  data GT_VRM_VALUES type VRM_VALUES .
  data G_HANDLE type INT4 .
  class-data G_HANDLE_COUNT type INT4 .

  class-methods BUILD_KEYSTRING
    importing
      value(I_CLASSNAME) type STRING
      value(I_P1) type ANY optional
      value(I_P2) type ANY optional
      value(I_P3) type ANY optional
      value(I_P4) type ANY optional
      value(I_P5) type ANY optional
      value(I_P6) type ANY optional
      value(I_P7) type ANY optional
      value(I_P8) type ANY optional
      value(I_P9) type ANY optional
      value(I_P10) type ANY optional
      value(I_P11) type ANY optional
      value(I_P12) type ANY optional
      value(I_P13) type ANY optional
      value(I_P14) type ANY optional
      value(I_P15) type ANY optional
      value(I_P16) type ANY optional
      value(I_P17) type ANY optional
      value(I_P18) type ANY optional
      value(I_P19) type ANY optional
      value(I_P20) type ANY optional
    exporting
      value(E_KEYSTRING) type N1LBKEY .
  class-methods GET_LB_OBJECT
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_CLASSNAME) type STRING
      value(I_P1) type ANY optional
      value(I_P2) type ANY optional
      value(I_P3) type ANY optional
      value(I_P4) type ANY optional
      value(I_P5) type ANY optional
      value(I_P6) type ANY optional
      value(I_P7) type ANY optional
      value(I_P8) type ANY optional
      value(I_P9) type ANY optional
      value(I_P10) type ANY optional
      value(I_P11) type ANY optional
      value(I_P12) type ANY optional
      value(I_P13) type ANY optional
      value(I_P14) type ANY optional
      value(I_P15) type ANY optional
      value(I_P16) type ANY optional
      value(I_P17) type ANY optional
      value(I_P18) type ANY optional
      value(I_P19) type ANY optional
      value(I_P20) type ANY optional
    exporting
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX
      value(E_NEW) type ISH_ON_OFF .
  type-pools CO .
  methods FILL_LISTBOX_INTERNAL
    importing
      value(I_LISTBOX_TYPE) type NLISTBOX_TYPE default CO_LISTB_DYNPRO
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_FIELDNAME) type VRM_ID
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ET_DROP_DOWN_ALIAS) type LVC_T_DRAL .
  methods GENERATE_VRM_VALUES
  abstract
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
    exporting
      value(E_RC) type ISH_METHOD_RC .
private section.
*"* private components of class CL_ISH_LISTBOX
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_LISTBOX IMPLEMENTATION.


METHOD build_keystring .

* Classname
  e_keystring = i_classname.

* Parameters
  IF NOT i_p1 IS INITIAL.
    CONCATENATE e_keystring i_p1 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p2 IS INITIAL.
    CONCATENATE e_keystring i_p2 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p3 IS INITIAL.
    CONCATENATE e_keystring i_p3 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p4 IS INITIAL.
    CONCATENATE e_keystring i_p4 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p5 IS INITIAL.
    CONCATENATE e_keystring i_p5 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p6 IS INITIAL.
    CONCATENATE e_keystring i_p6 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p7 IS INITIAL.
    CONCATENATE e_keystring i_p7 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p8 IS INITIAL.
    CONCATENATE e_keystring i_p8 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p9 IS INITIAL.
    CONCATENATE e_keystring i_p9 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p10 IS INITIAL.
    CONCATENATE e_keystring i_p10 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p11 IS INITIAL.
    CONCATENATE e_keystring i_p11 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p12 IS INITIAL.
    CONCATENATE e_keystring i_p12 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p13 IS INITIAL.
    CONCATENATE e_keystring i_p13 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p14 IS INITIAL.
    CONCATENATE e_keystring i_p14 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p15 IS INITIAL.
    CONCATENATE e_keystring i_p15 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p16 IS INITIAL.
    CONCATENATE e_keystring i_p16 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p17 IS INITIAL.
    CONCATENATE e_keystring i_p17 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p18 IS INITIAL.
    CONCATENATE e_keystring i_p18 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p19 IS INITIAL.
    CONCATENATE e_keystring i_p19 INTO e_keystring SEPARATED BY '_'.
  ENDIF.
  IF NOT i_p20 IS INITIAL.
    CONCATENATE e_keystring i_p20 INTO e_keystring SEPARATED BY '_'.
  ENDIF.

ENDMETHOD.


METHOD destroy.
* remove this instance from static table
  DELETE gt_listbox WHERE object = me.
* clear instance attributes
  CLEAR: gt_vrm_values, g_handle.
ENDMETHOD.


METHOD fill_listbox_internal.

  data: ls_vrm      type line of vrm_values,
        ls_dropdown type lvc_s_dral,
        l_rc        type ish_method_rc.

* Initializations.
  CLEAR e_rc.
* Dont initialize ET_DROP_DOWN_ALIAS here!!! This table must be
* initialized only from the caller to enable collecting of
* listbox-entries, which is used to support the ALV-grid

* Generate the vrm_values.
  CALL METHOD generate_vrm_values
    EXPORTING
      i_refresh = i_refresh
    IMPORTING
      e_rc      = e_rc.
  CHECK e_rc = 0.

* Set vrm_values into the dynpro field - but of course only
* if this listbox has type 'DYnpro'! Because on an ALV-grid
* this function-module must not be called!
  if i_listbox_type = co_listb_dynpro.
    CALL FUNCTION 'VRM_SET_VALUES'
      EXPORTING
        id              = i_fieldname
        values          = gt_vrm_values
      EXCEPTIONS
        id_illegal_name = 1
        OTHERS          = 2.
    e_rc = sy-subrc.
  endif.

* Build the table with the fields of the listbox. This table
* is needed e.g. for ALV-Grids
  CALL METHOD ME->GET_DROP_DOWN_VALUES
    IMPORTING
      E_RC               = l_rc
      ET_DROP_DOWN_ALIAS = et_drop_down_alias.
  if l_rc <> 0.
    e_rc = l_rc.
    exit.
  endif.

ENDMETHOD.


method GET_DROP_DOWN_VALUES .
  data: ls_vrm      type line of vrm_values,
        ls_dropdown type lvc_s_dral.

* Initializations.
  CLEAR e_rc.
* Dont initialize ET_DROP_DOWN_ALIAS here!!! This table must be
* initialized only from the caller to enable collecting of
* listbox-entries, which is used to support the ALV-grid

  e_handle = g_handle.

* Build the table with the fields of the listbox. This table
* is needed e.g. for ALV-Grids
  loop at gt_vrm_values into ls_vrm.
    ls_dropdown-handle    = g_handle.
    ls_dropdown-value     = ls_vrm-text.
    ls_dropdown-int_value = ls_vrm-key.
    append ls_dropdown to et_drop_down_alias.
  endloop.
endmethod.


METHOD get_first_key .

  FIELD-SYMBOLS: <ls_vrm_value>  TYPE vrm_value.

* Initializations
  CLEAR r_key.

* Read the first entry
  READ TABLE gt_vrm_values
    INDEX 1
    ASSIGNING <ls_vrm_value>.
  CHECK sy-subrc = 0.

* Export the key
  r_key = <ls_vrm_value>-key.

ENDMETHOD.


METHOD get_handle.

  r_handle = g_handle.

ENDMETHOD.


METHOD get_lb_object .

  DATA: l_keystring  TYPE n1lbkey,
        ls_listbox   TYPE rn1_listbox.
  FIELD-SYMBOLS: <ls_listbox> TYPE rn1_listbox.

* Initializations
  CLEAR er_lb_object.
  e_new = off.

* Build the keystring
  CALL METHOD cl_ish_listbox=>build_keystring
    EXPORTING
      i_classname = i_classname
      i_p1        = i_p1
      i_p2        = i_p2
      i_p3        = i_p3
      i_p4        = i_p4
      i_p5        = i_p5
      i_p6        = i_p6
      i_p7        = i_p7
      i_p8        = i_p8
      i_p9        = i_p9
      i_p10       = i_p10
      i_p11       = i_p11
      i_p12       = i_p12
      i_p13       = i_p13
      i_p14       = i_p14
      i_p15       = i_p15
      i_p16       = i_p16
      i_p17       = i_p17
      i_p18       = i_p18
      i_p19       = i_p19
      i_p20       = i_p20
    IMPORTING
      e_keystring = l_keystring.

* Get the corresponding listbox object.
  READ TABLE gt_listbox
    WITH KEY keystring = l_keystring
    ASSIGNING <ls_listbox>.
  IF sy-subrc = 0.
    IF i_refresh = on.
*     On refresh delete the entry.
      DELETE gt_listbox INDEX sy-tabix.
    ELSE.
      er_lb_object = <ls_listbox>-object.
    ENDIF.
  ENDIF.

* Listbox object found -> return.
  CHECK er_lb_object IS INITIAL.

* No listbox object found -> create one.
  CATCH SYSTEM-EXCEPTIONS
      create_object_class_not_found  = 1
      create_object_class_abstract   = 2
      create_object_create_private   = 3
      create_object_create_protected = 4.
    CREATE OBJECT er_lb_object TYPE (i_classname).
  ENDCATCH.
  CASE sy-subrc.
    WHEN 0.
    WHEN OTHERS.
      CLEAR er_lb_object.
      EXIT.
  ENDCASE.

* Save the listbox object in gt_listbox.
  ls_listbox-keystring = l_keystring.
  ls_listbox-object    = er_lb_object.
  APPEND ls_listbox TO gt_listbox.

* Set handle for this listbox
* Handle-count which supplies an own number for each listbox
  IF g_handle_count IS INITIAL.
    g_handle_count = 0.
  ENDIF.
  g_handle_count = g_handle_count + 1.

* Handle for THIS INSTANCE of a listbox
  er_lb_object->g_handle = g_handle_count.

* Tell the caller that the listbox object was created.
  e_new = on.

ENDMETHOD.


METHOD get_vrm_key .

  FIELD-SYMBOLS: <ls_vrm_value> TYPE vrm_value.

* Initializations.
  CLEAR r_vrm_key.

* Get the corresponding entry.
  READ TABLE gt_vrm_values
    ASSIGNING <ls_vrm_value>
    WITH KEY text = i_vrm_text.
* Not found -> no export.
  CHECK sy-subrc = 0.

* Export.
  r_vrm_key = <ls_vrm_value>-key.

ENDMETHOD.


METHOD get_vrm_text .

  FIELD-SYMBOLS: <ls_vrm_value> TYPE vrm_value.

* Initializations.
  CLEAR r_vrm_text.

* Get the corresponding entry.
  READ TABLE gt_vrm_values
    ASSIGNING <ls_vrm_value>
    WITH KEY key = i_vrm_key.
* Not found -> no export.
  CHECK sy-subrc = 0.

* Export.
  r_vrm_text = <ls_vrm_value>-text.

ENDMETHOD.


METHOD get_vrm_values .

  rt_vrm_values = gt_vrm_values.

ENDMETHOD.


METHOD has_key .

  FIELD-SYMBOLS: <ls_vrm_value> TYPE vrm_value.

* Initializations.
  r_has_key = off.

* Search for the key.
  LOOP AT gt_vrm_values ASSIGNING <ls_vrm_value>.
    IF i_key = <ls_vrm_value>-key.
      r_has_key = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
