class CL_ISH_FAC_CON_CORDER definition
  public
  create private .

*"* public components of class CL_ISH_FAC_CON_CORDER
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .

  class-methods CLASS_CONSTRUCTOR .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_CON_CORDER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CREATE_AGGREG
    exporting
      value(ER_INSTANCE) type ref to CL_ISHMED_CON_CORDER_AGGREG
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CREATE_CON_BASE_ITEM
    exporting
      value(ER_INSTANCE) type ref to CL_ISHMED_CON_CORDER_BASE_ITEM
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_FAC_CON_CORDER
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_FAC_CON_CORDER
*"* do not include other source files here!!!

  class-data G_ISHMED_AUTH type ISH_ON_OFF .
ENDCLASS.



CLASS CL_ISH_FAC_CON_CORDER IMPLEMENTATION.


METHOD CLASS_CONSTRUCTOR .

* Notice if IS-H*MED is active
  g_ishmed_auth = on.
  CALL FUNCTION 'ISHMED_AUTHORITY'
    EXPORTING
      i_msg            = off
    EXCEPTIONS
      ishmed_not_activ = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
    g_ishmed_auth = off.
  ENDIF.

ENDMETHOD.


METHOD create .

  DATA: lr_con_corder_med  TYPE REF TO cl_ishmed_con_corder.

  IF g_ishmed_auth = on.
    CALL METHOD cl_ishmed_con_corder=>create_med
      IMPORTING
        er_instance     = lr_con_corder_med
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    er_instance = lr_con_corder_med.
  ELSE.
    CALL METHOD cl_ish_con_corder=>create
      IMPORTING
        er_instance     = er_instance
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

  IF e_rc <> 0.
    CLEAR: er_instance.
  ENDIF.

ENDMETHOD.


METHOD create_aggreg .

  DATA: lr_con_corder_aggreg  TYPE REF TO cl_ishmed_con_corder_aggreg.

  IF g_ishmed_auth = on.
    CALL METHOD cl_ishmed_con_corder_aggreg=>create_aggreg
      IMPORTING
        er_instance     = lr_con_corder_aggreg
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    er_instance = lr_con_corder_aggreg.
  ENDIF.

  IF e_rc <> 0.
    CLEAR: er_instance.
  ENDIF.

ENDMETHOD.


METHOD create_con_base_item.

  DATA: lr_con_corder_base_item
                TYPE REF TO cl_ishmed_con_corder_base_item.

  IF g_ishmed_auth = on.
    CALL METHOD cl_ishmed_con_corder_base_item=>create_base_item
      IMPORTING
        er_instance     = lr_con_corder_base_item
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    er_instance = lr_con_corder_base_item.
  ENDIF.

  IF e_rc <> 0.
    CLEAR: er_instance.
  ENDIF.

ENDMETHOD.
ENDCLASS.
