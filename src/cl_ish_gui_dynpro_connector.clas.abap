class CL_ISH_GUI_DYNPRO_CONNECTOR definition
  public
  final
  create private .

*"* public components of class CL_ISH_GUI_DYNPRO_CONNECTOR
*"* do not include other source files here!!!
public section.

  class-methods AFTER_PAI
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR default SY-DYNNR .
  class-methods AFTER_PBO
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR default SY-DYNNR .
  class-methods BEFORE_CALL_SUBSCREEN
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !I_SUBSCREEN_NAME type N1GUI_ELEMENT_NAME
    exporting
      !E_SUBSCREEN_REPID type SY-REPID
      !E_SUBSCREEN_DYNNR type SY-DYNNR .
  class-methods BEFORE_PAI
    importing
      !I_REPID type SYREPID
      !I_DYNNR type SYDYNNR default SY-DYNNR
      !I_UCOMM type SYUCOMM optional .
  class-methods BEFORE_PBO
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR default SY-DYNNR .
  class-methods CONNECT
    importing
      !IR_VIEW type ref to CL_ISH_GUI_DYNPRO_VIEW
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CONNECT_FREE
    importing
      !IR_VIEW type ref to CL_ISH_GUI_DYNPRO_VIEW
      !I_REPID type SY-REPID
      !I_DYNNR_FROM type SY-DYNNR
      !I_DYNNR_TO type SY-DYNNR
    returning
      value(R_DYNNR) type SY-DYNNR
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  class-methods DISCONNECT
    importing
      !IR_VIEW type ref to CL_ISH_GUI_DYNPRO_VIEW
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
    returning
      value(R_DISCONNECTED) type ABAP_BOOL .
  class-methods EXIT_COMMAND
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !I_UCOMM type SY-UCOMM
    returning
      value(R_EXIT) type ABAP_BOOL .
  class-methods GET_VIEW_BY_DYNPRO
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR default SY-DYNNR
    returning
      value(RR_VIEW) type ref to CL_ISH_GUI_DYNPRO_VIEW .
  class-methods PAI
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !IS_DYNPSTRUCT type DATA optional .
  class-methods PBO
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR default SY-DYNNR
    changing
      !CS_DYNPSTRUCT type DATA optional .
  class-methods POH
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !I_FIELDNAME type ISH_FIELDNAME optional .
  class-methods POV
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !I_FIELDNAME type ISH_FIELDNAME optional .
  class-methods USER_COMMAND
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !I_UCOMM type SY-UCOMM
    returning
      value(R_EXIT) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_GUI_DYNPRO_CONNECTOR
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_DYNPRO_CONNECTOR
*"* do not include other source files here!!!

  types:
    BEGIN OF gty_connector,
      repid        TYPE sy-repid,
      r_connector  TYPE REF TO cl_ish_gui_dynpro_connector,
    END OF gty_connector .
  types:
    gtyt_connector  TYPE HASHED TABLE OF gty_connector WITH UNIQUE KEY repid .
  types:
    BEGIN OF gty_view,
      dynnr    TYPE sy-dynnr,
      r_view   TYPE REF TO cl_ish_gui_dynpro_view,
    END OF gty_view .
  types:
    gtyt_view  TYPE HASHED TABLE OF gty_view WITH UNIQUE KEY dynnr .

  class-data GT_CONNECTOR type GTYT_CONNECTOR .
  data GT_VIEW type GTYT_VIEW .
  data G_REPID type SY-REPID .

  class-methods CREATE_CONNECTOR
    importing
      !I_REPID type SY-REPID
    returning
      value(RR_CONNECTOR) type ref to CL_ISH_GUI_DYNPRO_CONNECTOR
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods GET_CONNECTOR
    importing
      !I_REPID type SY-REPID
    returning
      value(RR_CONNECTOR) type ref to CL_ISH_GUI_DYNPRO_CONNECTOR .
  methods GET_VIEW
    importing
      !I_DYNNR type SY-DYNNR default SY-DYNNR
    returning
      value(RR_VIEW) type ref to CL_ISH_GUI_DYNPRO_VIEW .
  methods _AFTER_PAI
    importing
      !I_DYNNR type SY-DYNNR default SY-DYNNR .
  methods _AFTER_PBO
    importing
      !I_DYNNR type SY-DYNNR default SY-DYNNR .
  methods _BEFORE_CALL_SUBSCREEN
    importing
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !I_SUBSCREEN_NAME type N1GUI_ELEMENT_NAME
    exporting
      !E_SUBSCREEN_REPID type SY-REPID
      !E_SUBSCREEN_DYNNR type SY-DYNNR .
  methods _BEFORE_PAI
    importing
      !I_DYNNR type SYDYNNR default SY-DYNNR
      !I_UCOMM type SYUCOMM optional .
  methods _BEFORE_PBO
    importing
      !I_DYNNR type SY-DYNNR default SY-DYNNR .
  type-pools ABAP .
  methods _EXIT_COMMAND
    importing
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !I_UCOMM type SY-UCOMM
    returning
      value(R_EXIT) type ABAP_BOOL .
  methods _PAI
    importing
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !IS_DYNPSTRUCT type DATA optional .
  methods _PBO
    importing
      !I_DYNNR type SY-DYNNR default SY-DYNNR
    changing
      !CS_DYNPSTRUCT type DATA optional .
  methods _POH
    importing
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !I_FIELDNAME type ISH_FIELDNAME optional .
  methods _POV
    importing
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !I_FIELDNAME type ISH_FIELDNAME optional .
  methods _USER_COMMAND
    importing
      !I_DYNNR type SY-DYNNR default SY-DYNNR
      !I_UCOMM type SY-UCOMM
    returning
      value(R_EXIT) type ABAP_BOOL .
ENDCLASS.



CLASS CL_ISH_GUI_DYNPRO_CONNECTOR IMPLEMENTATION.


METHOD after_pai.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  lr_connector->_after_pai( i_dynnr = i_dynnr ).

ENDMETHOD.


METHOD after_pbo.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  lr_connector->_after_pbo( i_dynnr = i_dynnr ).

ENDMETHOD.


METHOD before_call_subscreen.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

* Initializations.
  e_subscreen_repid = 'SAPLN1SC'.
  e_subscreen_dynnr = '0001'.

* Get the connector for the given repid.
  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

* Wrap to the connector.
  CALL METHOD lr_connector->_before_call_subscreen
    EXPORTING
      i_dynnr           = i_dynnr
      i_subscreen_name  = i_subscreen_name
    IMPORTING
      e_subscreen_repid = e_subscreen_repid
      e_subscreen_dynnr = e_subscreen_dynnr.

ENDMETHOD.


METHOD before_pai.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  lr_connector->_before_pai(
      i_dynnr = i_dynnr
      i_ucomm = i_ucomm ).

ENDMETHOD.


METHOD before_pbo.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  lr_connector->_before_pbo( i_dynnr = i_dynnr ).

ENDMETHOD.


METHOD connect.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  FIELD-SYMBOLS:
    <ls_view>     TYPE gty_view.

* Initial checking.
  IF ir_view IS NOT BOUND OR
     i_repid IS INITIAL OR
     i_dynnr IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONNECT'
        i_mv3        = 'CL_ISH_GUI_DYNPRO_CONNECTOR' ).
  ENDIF.

* Get the maybe already existing connector for the given repid.
* Create the connector for the given repid if it does not already exist.
  lr_connector = get_connector( i_repid = i_repid ).
  IF lr_connector IS NOT BOUND.
    lr_connector = create_connector( i_repid = i_repid ).
  ENDIF.

* Connect the given view with the given dynpro.
  READ TABLE lr_connector->gt_view
    WITH TABLE KEY dynnr = i_dynnr
    ASSIGNING <ls_view>.
  IF sy-subrc <> 0 OR
     <ls_view>-r_view IS BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'CONNECT'
        i_mv3        = 'CL_ISH_GUI_DYNPRO_CONNECTOR' ).
  ENDIF.
  <ls_view>-r_view = ir_view.

ENDMETHOD.


METHOD connect_free.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  FIELD-SYMBOLS:
    <ls_view>     TYPE gty_view.

* Initial checking.
  IF ir_view IS NOT BOUND OR
     i_repid IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONNECT_FREE'
        i_mv3        = 'CL_ISH_GUI_DYNPRO_CONNECTOR' ).
  ENDIF.

* Get the maybe already existing connector for the given repid.
* Create the connector for the given repid if it does not already exist.
  lr_connector = get_connector( i_repid = i_repid ).
  IF lr_connector IS NOT BOUND.
    lr_connector = create_connector( i_repid = i_repid ).
  ENDIF.

* Connect the given view with the next free dynpro.
  LOOP AT lr_connector->gt_view ASSIGNING <ls_view>.
    CHECK <ls_view>-r_view IS NOT BOUND.
    CHECK <ls_view>-dynnr >= i_dynnr_from.
    CHECK <ls_view>-dynnr <= i_dynnr_to.
    <ls_view>-r_view = ir_view.
    r_dynnr = <ls_view>-dynnr.
    EXIT.
  ENDLOOP.

* On no next free dynpro -> error.
  IF r_dynnr IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'CONNECT_FREE'
        i_mv3        = 'CL_ISH_GUI_DYNPRO_CONNECTOR' ).
  ENDIF.

ENDMETHOD.


METHOD create_connector.

  DATA:
    lt_d020s      TYPE TABLE OF d020s,
    lt_dynnr      TYPE ish_t_dynnr,
    ls_connector  LIKE LINE OF gt_connector,
    ls_view       TYPE gty_view.

  FIELD-SYMBOLS:
    <ls_d020s>    LIKE LINE OF lt_d020s.

* Get all dynpros for the given repid.
  SELECT * FROM d020s INTO TABLE lt_d020s WHERE prog = i_repid.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CREATE_CONNECTOR'
        i_mv3        = 'CL_ISH_GUI_DYNPRO_CONNECTOR' ).
  ENDIF.

* Create the connector.
  CREATE OBJECT rr_connector.

* Register the connector.
  ls_connector-repid       = i_repid.
  ls_connector-r_connector = rr_connector.
  INSERT ls_connector INTO TABLE gt_connector.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'CREATE_CONNECTOR'
        i_mv3        = 'CL_ISH_GUI_DYNPRO_CONNECTOR' ).
  ENDIF.

* Initialize the connector.
  rr_connector->g_repid = i_repid.
  LOOP AT lt_d020s ASSIGNING <ls_d020s>.
    ls_view-dynnr = <ls_d020s>-dnum.
    INSERT ls_view INTO TABLE rr_connector->gt_view.
  ENDLOOP.

ENDMETHOD.


METHOD disconnect.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector,
    l_repid       TYPE sy-repid,
    l_dynnr       TYPE sy-dynnr.

  FIELD-SYMBOLS:
    <ls_view>     TYPE gty_view.

* Initial checking.
  CHECK ir_view IS BOUND.

* Get the connector.
  IF i_repid IS INITIAL.
    l_repid = ir_view->get_repid( ).
    lr_connector = get_connector( i_repid = l_repid ).
  ELSE.
    lr_connector = get_connector( i_repid = i_repid ).
  ENDIF.
  CHECK lr_connector IS BOUND.

* Disconnect the given view from the dynpro.
  IF i_dynnr IS INITIAL.
    l_dynnr = ir_view->get_dynnr( ).
    READ TABLE lr_connector->gt_view
      WITH TABLE KEY dynnr = l_dynnr
      ASSIGNING <ls_view>.
  ELSE.
    READ TABLE lr_connector->gt_view
      WITH TABLE KEY dynnr = i_dynnr
      ASSIGNING <ls_view>.
  ENDIF.
  CHECK sy-subrc = 0.
  CHECK <ls_view>-r_view = ir_view.
  CLEAR: <ls_view>-r_view.

* The view was disconnected from the dynpro.
  r_disconnected = abap_true.

ENDMETHOD.


METHOD exit_command.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  r_exit = lr_connector->_exit_command( i_dynnr = i_dynnr
                                        i_ucomm = i_ucomm ).

ENDMETHOD.


METHOD get_connector.

  FIELD-SYMBOLS:
    <ls_connector>  LIKE LINE OF gt_connector.

  READ TABLE gt_connector
    WITH TABLE KEY repid = i_repid
    ASSIGNING <ls_connector>.
  CHECK sy-subrc = 0.

  rr_connector = <ls_connector>-r_connector.

ENDMETHOD.


METHOD get_view.

  FIELD-SYMBOLS:
    <ls_view>  LIKE LINE OF gt_view.

  READ TABLE gt_view
    WITH TABLE KEY dynnr = i_dynnr
    ASSIGNING <ls_view>.
  CHECK sy-subrc = 0.

  rr_view = <ls_view>-r_view.

ENDMETHOD.


METHOD get_view_by_dynpro.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  lr_connector = get_connector( i_repid = i_repid ).
  CHECK lr_connector IS BOUND.

  rr_view = lr_connector->get_view( i_dynnr = i_dynnr ).

ENDMETHOD.


METHOD pai.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  IF is_dynpstruct IS SUPPLIED.
    lr_connector->_pai( i_dynnr       = i_dynnr
                        is_dynpstruct = is_dynpstruct ).
  ELSE.
    lr_connector->_pai( i_dynnr = i_dynnr ).
  ENDIF.

ENDMETHOD.


METHOD pbo.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  IF cs_dynpstruct IS SUPPLIED.
    CALL METHOD lr_connector->_pbo
      EXPORTING
        i_dynnr       = i_dynnr
      CHANGING
        cs_dynpstruct = cs_dynpstruct.
  ELSE.
    lr_connector->_pbo( i_dynnr = i_dynnr ).
  ENDIF.

ENDMETHOD.


METHOD poh.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  lr_connector->_poh( i_dynnr     = i_dynnr
                      i_fieldname = i_fieldname ).

ENDMETHOD.


METHOD pov.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  lr_connector->_pov( i_dynnr     = i_dynnr
                      i_fieldname = i_fieldname ).

ENDMETHOD.


METHOD user_command.

  DATA:
    lr_connector  TYPE REF TO cl_ish_gui_dynpro_connector.

  lr_connector = get_connector( i_repid ).
  CHECK lr_connector IS BOUND.

  r_exit = lr_connector->_user_command( i_dynnr = i_dynnr
                                        i_ucomm = i_ucomm ).

ENDMETHOD.


METHOD _after_pai.

  DATA:
    lr_view  TYPE REF TO cl_ish_gui_dynpro_view.

  lr_view = get_view( i_dynnr = i_dynnr ).
  CHECK lr_view IS BOUND.

  lr_view->__after_pai( i_repid = g_repid
                        i_dynnr = i_dynnr ).

ENDMETHOD.


METHOD _after_pbo.

  DATA:
    lr_view  TYPE REF TO cl_ish_gui_dynpro_view.

  lr_view = get_view( i_dynnr = i_dynnr ).
  CHECK lr_view IS BOUND.

  lr_view->__after_pbo( i_repid = g_repid
                        i_dynnr = i_dynnr ).

ENDMETHOD.


METHOD _before_call_subscreen.

  DATA:
    lr_view  TYPE REF TO cl_ish_gui_dynpro_view.

* Initializations.
  e_subscreen_repid = 'SAPLN1SC'.
  e_subscreen_dynnr = '0001'.

* Get the view for the given dynnr.
  lr_view = get_view( i_dynnr = i_dynnr ).
  CHECK lr_view IS BOUND.

* Wrap to the view.
  CALL METHOD lr_view->__before_call_subscreen
    EXPORTING
      i_repid           = g_repid
      i_dynnr           = i_dynnr
      i_subscreen_name  = i_subscreen_name
    IMPORTING
      e_subscreen_repid = e_subscreen_repid
      e_subscreen_dynnr = e_subscreen_dynnr.

ENDMETHOD.


METHOD _before_pai.

  DATA:
    lr_view  TYPE REF TO cl_ish_gui_dynpro_view.

  lr_view = get_view( i_dynnr = i_dynnr ).
  CHECK lr_view IS BOUND.

  lr_view->__before_pai(
      i_repid = g_repid
      i_dynnr = i_dynnr
      i_ucomm = i_ucomm ).

ENDMETHOD.


METHOD _before_pbo.

  DATA:
    lr_view  TYPE REF TO cl_ish_gui_dynpro_view.

  lr_view = get_view( i_dynnr = i_dynnr ).
  CHECK lr_view IS BOUND.

  lr_view->__before_pbo( i_repid = g_repid
                         i_dynnr = i_dynnr ).

ENDMETHOD.


METHOD _exit_command.

  DATA:
    lr_view  TYPE REF TO cl_ish_gui_mdy_view.

  r_exit = abap_true.

  TRY.
      lr_view ?= get_view( i_dynnr = i_dynnr ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_view IS BOUND.

  r_exit = lr_view->__exit_command( i_repid = g_repid
                                    i_dynnr = i_dynnr
                                    i_ucomm = i_ucomm ).

ENDMETHOD.


METHOD _pai.

  DATA:
    lr_view  TYPE REF TO cl_ish_gui_dynpro_view.

  lr_view = get_view( i_dynnr = i_dynnr ).
  CHECK lr_view IS BOUND.

  IF is_dynpstruct IS SUPPLIED.
    lr_view->__pai( i_repid       = g_repid
                    i_dynnr       = i_dynnr
                    is_dynpstruct = is_dynpstruct ).
  ELSE.
    lr_view->__pai( i_repid = g_repid
                    i_dynnr = i_dynnr ).
  ENDIF.

ENDMETHOD.


METHOD _pbo.

  DATA:
    lr_view  TYPE REF TO cl_ish_gui_dynpro_view.

  lr_view = get_view( i_dynnr = i_dynnr ).
  CHECK lr_view IS BOUND.

  IF cs_dynpstruct IS SUPPLIED.
    CALL METHOD lr_view->__pbo
      EXPORTING
        i_repid       = g_repid
        i_dynnr       = i_dynnr
      CHANGING
        cs_dynpstruct = cs_dynpstruct.
  ELSE.
    lr_view->__pbo( i_repid = g_repid
                    i_dynnr = i_dynnr ).
  ENDIF.

ENDMETHOD.


METHOD _poh.

  DATA:
    lr_view  TYPE REF TO cl_ish_gui_dynpro_view.

  lr_view = get_view( i_dynnr = i_dynnr ).
  CHECK lr_view IS BOUND.

  lr_view->__poh( i_repid     = g_repid
                  i_dynnr     = i_dynnr
                  i_fieldname = i_fieldname ).

ENDMETHOD.


METHOD _pov.

  DATA:
    lr_view  TYPE REF TO cl_ish_gui_dynpro_view.

  lr_view = get_view( i_dynnr = i_dynnr ).
  CHECK lr_view IS BOUND.

  lr_view->__pov( i_repid     = g_repid
                  i_dynnr     = i_dynnr
                  i_fieldname = i_fieldname ).

ENDMETHOD.


METHOD _user_command.

  DATA:
    lr_view  TYPE REF TO cl_ish_gui_mdy_view.

  r_exit = abap_true.

  TRY.
      lr_view ?= get_view( i_dynnr = i_dynnr ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_view IS BOUND.

  r_exit = lr_view->__user_command( i_repid = g_repid
                                    i_dynnr = i_dynnr
                                    i_ucomm = i_ucomm ).

ENDMETHOD.
ENDCLASS.
