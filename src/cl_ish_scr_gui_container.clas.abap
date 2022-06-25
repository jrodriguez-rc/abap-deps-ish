class CL_ISH_SCR_GUI_CONTAINER definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

*"* public components of class CL_ISH_SCR_GUI_CONTAINER
*"* do not include other source files here!!!
public section.

  constants CO_MAX_DYNNR type I value 5. "#EC NOTEXT
  constants CO_OTYPE_SCR_GUI_CONTAINER type ISH_OBJECT_TYPE value 12016. "#EC NOTEXT

  class-methods CLASS_CONSTRUCTOR .
  class-methods CREATE
    exporting
      !ER_INSTANCE type ref to CL_ISH_SCR_GUI_CONTAINER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_GUI_CONTAINER
    exporting
      !ER_GUI_CONTAINER type ref to CL_GUI_CUSTOM_CONTAINER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_GUI_CONTAINER
*"* do not include other source files here!!!

  constants CO_CONTAINER_PREFIX type STRING value 'G_CO_CONTAINER'. "#EC NOTEXT
  class-data GT_FREE_DYNNR type ISH_T_DYNNR .
  data GR_GUI_CONTAINER type ref to CL_GUI_CUSTOM_CONTAINER .

  class-methods CHECKOUT_DYNNR
    exporting
      value(E_DYNNR) type SY-DYNNR
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods FREE_DYNNR
    importing
      value(I_DYNNR) type SY-DYNNR
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods COMPLETE_CONSTRUCTION
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods INITIALIZE_FIELD_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_GUI_CONTAINER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_GUI_CONTAINER IMPLEMENTATION.


METHOD checkout_dynnr .

  DATA: l_dynnr  TYPE sy-dynnr.

* Get the first free dynnr.
  READ TABLE gt_free_dynnr INTO l_dynnr INDEX 1.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* Dynnr is not free any more -> delete it.
  DELETE TABLE gt_free_dynnr FROM l_dynnr.

* Export the dynnr.
  e_dynnr = l_dynnr.

ENDMETHOD.


METHOD class_constructor .

  DATA: l_dynnr  TYPE sy-dynnr.

* Set starting dynnr.
  l_dynnr = '0100'.

* Append entries for all possible dynnr.
  DO co_max_dynnr TIMES.
    APPEND l_dynnr TO gt_free_dynnr.
    l_dynnr = l_dynnr + 1.
  ENDDO.

ENDMETHOD.


METHOD complete_construction .

  DATA: l_dynnr  TYPE sy-dynnr.

* Get next free dynnr.
  CALL METHOD checkout_dynnr
    IMPORTING
      e_dynnr         = l_dynnr
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  gs_parent-repid = 'SAPLN1_SDY_GUI_CONTAINER'.
  gs_parent-dynnr = l_dynnr.

ENDMETHOD.


METHOD create .

* Initializations.
  e_rc = 0.

* Create object.
  CREATE OBJECT er_instance.

* Complete construction.
  CALL METHOD er_instance->complete_construction
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD free_dynnr .

  CHECK NOT i_dynnr IS INITIAL.

* i_dynnr already free?
  READ TABLE gt_free_dynnr FROM i_dynnr TRANSPORTING NO FIELDS.
  CHECK sy-subrc <> 0.

* Set i_dynnr as free.
  APPEND i_dynnr TO gt_free_dynnr.

ENDMETHOD.


METHOD get_gui_container .

  DATA: l_container_name  TYPE scrfname,
        lr_gui_container  TYPE REF TO cl_gui_custom_container.

* Initializations.
  e_rc = 0.
  er_gui_container = gr_gui_container.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Already loaded?
  CHECK gr_gui_container IS INITIAL.

* Build the container name.
  CONCATENATE co_container_prefix
              gs_parent-dynnr
         INTO l_container_name
    SEPARATED BY '_'.

* Create a new gui container.
  CREATE OBJECT lr_gui_container
    EXPORTING
      container_name              = l_container_name
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      OTHERS                      = 6.
  e_rc = sy-subrc.

* Errorhandling.
  IF e_rc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ        = 'E'
        i_kla        = 'NFCL'
        i_num        = '090'
        i_mv1        = l_container_name
        i_mv2        = e_rc
        i_last       = space
        i_identifier = 'CL_ISH_SCR_GUI_CONTAINER'
        i_object     = me.
    EXIT.
  ENDIF.

* Remember the gui container.
  gr_gui_container = lr_gui_container.

* Export the gui container.
  er_gui_container = gr_gui_container.

ENDMETHOD.


METHOD if_ish_screen~destroy .

  DATA: l_rc  TYPE ish_method_rc.

* ED, MED-30172: free before destroy because of GS_PARENT -> BEGIN
* Free the dynnr
  CALL METHOD free_dynnr
    EXPORTING
      i_dynnr         = gs_parent-dynnr
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ED, MED-30172 -> END

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

* ED, MED-30172: free before destroy because of GS_PARENT -> BEGIN COMMENT
** Free the dynnr
*  CALL METHOD free_dynnr
*    EXPORTING
*      i_dynnr         = gs_parent-dynnr
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*    EXIT.
*  ENDIF.
* ED, MED-30172 -> END COMMENT

ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .

  CALL FUNCTION 'ISH_SDY_GUI_CONTAINER_INIT'
    EXPORTING
      ir_scr_gui_container = me
    IMPORTING
      e_rc                 = e_rc
    CHANGING
      cr_errorhandler      = cr_errorhandler.

ENDMETHOD.


METHOD initialize_field_values .

* Nothing to do here.

ENDMETHOD.
ENDCLASS.
