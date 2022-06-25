class CL_IM_ISHMED_BIT__COMP definition
  public
  final
  create public .

*"* public components of class CL_IM_ISHMED_BIT__COMP
*"* do not include other source files here!!!
public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_ISHMED_BASEITEM_ACT .
protected section.
*"* protected components of class CL_IM_ISHMED_BIT__COMP
*"* do not include other source files here!!!

  methods DO_FOR_DWS
    importing
      !IR_OPERATION type ref to IF_ISHMED_BASEITEM_OPERATION
      !IR_BASEITEM type ref to CL_ISHMED_BASEITEM
      !IR_BASEITEMTYPE type ref to CL_ISHMED_BASEITEMTYPE
      !IR_CONTEXT type ref to IF_ISHMED_GENERAL_CTX
      value(FLT_VAL) type N2_BASEITEM_TYPE
      !I_TESTRUN type ISH_ON_OFF
      !I_COMMIT type ISH_ON_OFF
    exporting
      !E_ACTION_RESULT type N2_BASEITEM_RESULT_STATUS
      !ER_RESULT_OBJ type ref to IF_ISHMED_BASEITEM_RESULT
    changing
      !C_RESULT type N2_BASEITEM_RESULT
    raising
      CX_ISHMED_BASEITEM_EXIT
      CX_ISHMED_BASEITEM_EXEC
      CX_ISHMED_BASEITEMS .
private section.
*"* private components of class CL_IM_ISHMED_BIT__COMP
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_IM_ISHMED_BIT__COMP IMPLEMENTATION.


METHOD DO_FOR_DWS .
*--------------------------Change History----------------------------*
* Author: Fricke C5103440
* Date  : 20080104
* What  : Consolidation
*
*--------------------------Change History----------------------------*
  DATA: LR_OPERATION_DWS       TYPE REF TO CL_ISHMED_BI_OPERATION_DWS,
*--------------------------delete C5103440 20080104------------------*
*        ls_bi_component        TYPE rn2_baseitem__component,
*--------------------------delete C5103440 20080104------------------*
        LR_DWS_BROKER          TYPE REF TO CL_ISHMED_DWS_BROKER,
        L_PATNR                TYPE PATNR,
        LS_CTXKEY_PARENT       TYPE RN2CTX_KEY,
        LS_CTXKEY              TYPE RN2CTX_KEY,
        L_DWS_OPERATION        TYPE N2DWS_OPERATION_CODE,
        L_BUSINESS_KEY         TYPE N2DWS_BUSINESSKEY,
        L_OBJECTTYPE           TYPE ISH_OBJECT_TYPE,
        LR_RESPONSE            TYPE REF TO CL_ISHMED_DWS_RESPONSE,
        LR_DOCUMENT            TYPE REF TO IF_ISHMED_DWS_OBJECTTYPE,
        LS_MESSAGE             TYPE SCX_T100KEY,
*--------------------------delete C5103440 20080104------------------*
*        LR_ERRORHANDLER        TYPE REF TO CL_ISHMED_ERRORHANDLING,
*        L_RC                   TYPE ISH_METHOD_RC,
*--------------------------delete C5103440 20080104------------------*
        LX_ROOT                TYPE REF TO CX_ROOT.

  FIELD-SYMBOLS: <L_ACTION_ID>  TYPE CHAR20.
*--------------------------insert C5103440 20080104------------------*
  FIELD-SYMBOLS:
            <LS_BI_COMPONENT>    TYPE        RN2_BASEITEM__COMPONENT.
*--------------------------------------------------------------------

* Get the dws operation object.
  TRY.
      LR_OPERATION_DWS ?= IR_OPERATION.
    CATCH CX_SY_MOVE_CAST_ERROR INTO LX_ROOT.
      RAISE EXCEPTION TYPE CX_ISHMED_BASEITEMS
        EXPORTING
          PREVIOUS = LX_ROOT.
  ENDTRY.
*--------------------------insert C5103440 20080104------------------*
  IF IR_BASEITEM->GS_BI_DESERIALIZED IS INITIAL.
    RAISE EXCEPTION TYPE CX_ISHMED_BASEITEMS.
  ELSE.
    ASSIGN IR_BASEITEM->GS_BI_DESERIALIZED->* TO <LS_BI_COMPONENT>.
  ENDIF.
*--------------------------insert C5103440 20080104------------------*
*--------------------------delete C5103440 20080104------------------*
** Get baseitem data
*  CALL METHOD ir_baseitem->get_data
*    IMPORTING
*      es_baseitem     = <ls_bi_component>-header
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = lr_errorhandler.
*  IF l_rc > 0.
*    RAISE EXCEPTION TYPE cx_ishmed_baseitems
*      EXPORTING
*        gr_errorhandler = lr_errorhandler.
*  ENDIF.
*
** Deserialize baseitem component data
*  CALL METHOD cl_ishmed_baseitem=>deserialize_baseitem
*    EXPORTING
*      ir_baseitemtype = ir_baseitemtype
*      i_serialized    = <ls_bi_component>-serialized
*    IMPORTING
*      es_data         = <ls_bi_component>.
*
*--------------------------delete C5103440 20080104------------------*
* Get broker instance
  LR_DWS_BROKER = CL_ISHMED_DWS_BROKER=>GET_INSTANCE( ).

* Get the patient from the context.
  TRY.
      L_PATNR = IR_CONTEXT->GET_PATIENT( ).
    CATCH CX_ISHMED_CONTEXT INTO LX_ROOT.
      RAISE EXCEPTION TYPE CX_ISHMED_BASEITEMS
        EXPORTING
          PREVIOUS = LX_ROOT.
  ENDTRY.

* Add the serialized compcon data to the context.
  IF <LS_BI_COMPONENT>-COMP_AS_XML IS NOT INITIAL.
    LS_CTXKEY_PARENT-OBJECT_ID    = IF_ISHMED_DWS_SEMOBJS=>CO_OBJ_PATIENT.
    LS_CTXKEY_PARENT-BUSINESS_KEY = L_PATNR.
    TRY.
        LS_CTXKEY-OBJECT_ID    = 'BASEITEM_XMLDOC'.
        LS_CTXKEY-BUSINESS_KEY = <LS_BI_COMPONENT>-BASEITEMID.
        IR_CONTEXT->SET_DATA( I_CTX_KEY        = LS_CTXKEY
                              I_OBJECT         = <LS_BI_COMPONENT>-COMP_AS_XML
                              I_PARENT_CTX_KEY = LS_CTXKEY_PARENT ).
      CATCH CX_ISHMED_CONTEXT INTO LX_ROOT.
        RAISE EXCEPTION TYPE CX_ISHMED_BASEITEMS
          EXPORTING
            PREVIOUS = LX_ROOT.
    ENDTRY.
  ENDIF.

* Determine the dws operation code.
  IF C_RESULT IS INITIAL.
*   On first call use action_first.
    ASSIGN <LS_BI_COMPONENT>-ACTION_ID_FIRST TO <L_ACTION_ID>.
  ELSE.
*   On recursive call use action_again.
    ASSIGN <LS_BI_COMPONENT>-ACTION_ID_AGAIN TO <L_ACTION_ID>.
  ENDIF.
* Calculate the dws_operation code depending on action.
  CASE <L_ACTION_ID>.
    WHEN 'CREATE'.
      L_DWS_OPERATION = CL_ISHMED_DWS_BROKER=>CO_OP_CREATE.
    WHEN 'CHANGE'.
      L_DWS_OPERATION = CL_ISHMED_DWS_BROKER=>CO_OP_CHANGE.
    WHEN OTHERS.
      L_DWS_OPERATION = CL_ISHMED_DWS_BROKER=>CO_OP_DISPLAY.
  ENDCASE.

* Determine the business_key.
  IF C_RESULT IS INITIAL.
*   On first call use the task_id as business_key.
*   The task_id is later used by the docuobject for updating the baseitem result.
    L_BUSINESS_KEY =  LR_OPERATION_DWS->TASK_ID.
  ELSE.
*   On recursive call use the given result as business_key.
    L_BUSINESS_KEY = C_RESULT.
  ENDIF.

* Determine the dws objecttype.
  CASE <LS_BI_COMPONENT>-ITEMTYPE.
    WHEN 'SERVICEMED'.
      L_OBJECTTYPE = CL_ISHMED_DWS_CTRL_MEDSRV=>CO_OTYPE_DWS_PROCESS_MEDSRV.
    WHEN 'SRVTEAM'.
      L_OBJECTTYPE = CL_ISHMED_DWS_CTRL_SRVTEAM=>CO_OTYPE_DWS_PROCESS_SRVTEAM.
    WHEN 'MATERIAL'.
      L_OBJECTTYPE = CL_ISHMED_DWS_CTRL_MATERIAL=>CO_OTYPE_DWS_PROCESS_MATERIAL.
    WHEN 'SURGORDER'.
      L_OBJECTTYPE = CL_ISHMED_DWS_CTRL_SURGORDER=>CO_OTYPE_DWS_PROCESS_SURGORDER.
    WHEN 'MEORDER'.
      L_OBJECTTYPE = CL_ISHMED_DWS_CTRL_ME_ORDER=>CO_OTYPE_DWS_CTRL_ME_ORDER.
    WHEN 'SERVICENRS'.
      L_OBJECTTYPE = CL_ISHMED_DWS_CTRL_NRSSRV=>CO_OTYPE_DWS_CTRL_NRSSRV.
    WHEN 'NRSPLAN'.
      L_OBJECTTYPE = CL_ISHMED_DWS_CTRL_NRSPLAN_BI=>CO_OTYPE_DWS_CTRL_NRSPLAN_BI.
    WHEN 'MEADMINEVT'.
      L_OBJECTTYPE = CL_ISHMED_DWS_CTRL_ME_ADMEVT=>CO_OTYPE_DWS_CTRL_ME_ADMEVT.
  ENDCASE.

* Now let the broker process the operation.
  TRY.
      CALL METHOD LR_DWS_BROKER->(L_DWS_OPERATION)
        EXPORTING
          SENDER       = LR_OPERATION_DWS->SENDER
          BUSINESS_KEY = L_BUSINESS_KEY
          OBJECTTYPE   = L_OBJECTTYPE
          CONTEXT      = IR_CONTEXT
        RECEIVING
          RESPONSE     = LR_RESPONSE.
      IF LR_RESPONSE IS BOUND.
        LR_DOCUMENT ?= LR_RESPONSE->SENDER.
      ENDIF.
    CATCH CX_ROOT INTO LX_ROOT.
      RAISE EXCEPTION TYPE CX_ISHMED_BASEITEM_EXEC
        EXPORTING
          PREVIOUS = LX_ROOT.
  ENDTRY.

* No document -> error.
  IF LR_DOCUMENT IS NOT BOUND.
    LS_MESSAGE-MSGID = 'N2BASEITEM_ISH'.
    LS_MESSAGE-MSGNO = '010'.
    RAISE EXCEPTION TYPE CX_ISHMED_BASEITEM_EXEC
      EXPORTING
        TEXTID = LS_MESSAGE.
  ENDIF.

* Handle c_result.
  C_RESULT = LR_DOCUMENT->BUSINESS_KEY.

* Handle e_action_result.
  E_ACTION_RESULT = IF_ISHMED_BASEITEMS_CONST=>CO_RESULT_STATUS_DONE.

* Handle er_result_obj.
  CREATE OBJECT ER_RESULT_OBJ
    TYPE
      CL_ISHMED_BI_RESULT_DWS
    EXPORTING
      IR_OPERATION            = IR_OPERATION
      I_RESULT_STATUS         = E_ACTION_RESULT
      IR_DWS_OBJECT           = LR_DOCUMENT
      I_OPERATION             = L_DWS_OPERATION.

ENDMETHOD.


method IF_EX_ISHMED_BASEITEM_ACT~ASSIGN.

* no support

endmethod.


method IF_EX_ISHMED_BASEITEM_ACT~CHECK.

* no support

endmethod.


METHOD if_ex_ishmed_baseitem_act~check_doc_obj_support.
*  baseitemtype supports docu object _COMP
  r_is_supported = 'X'.

* TODO: Implementation for analyzing i_doc_object_id key structure.
*       Individual logic, if the extracted DocuObjectType
*       matches to the expectations of this Baseitemtype
ENDMETHOD.


method IF_EX_ISHMED_BASEITEM_ACT~CHECK_PROC_MODE.
endmethod.


METHOD if_ex_ishmed_baseitem_act~do.

  IF ir_operation->area CP 'DWS*'.
    CALL METHOD do_for_dws
      EXPORTING
        ir_operation    = ir_operation
        ir_baseitem     = ir_baseitem
        ir_baseitemtype = ir_baseitemtype
        ir_context      = ir_context
        flt_val         = flt_val
        i_testrun       = i_testrun
        i_commit        = i_commit
      IMPORTING
        e_action_result = e_action_result
        er_result_obj   = er_result_obj
      CHANGING
        c_result        = c_result.
  ENDIF.

ENDMETHOD.


method IF_EX_ISHMED_BASEITEM_ACT~GET_INFO.

* no support

endmethod.


method IF_EX_ISHMED_BASEITEM_ACT~PRINT.
endmethod.


METHOD if_ex_ishmed_baseitem_act~result_to_generictab.

ENDMETHOD.


method IF_EX_ISHMED_BASEITEM_ACT~SERIALIZE_RESULT.
endmethod.


method IF_EX_ISHMED_BASEITEM_ACT~TRANSPORT.
endmethod.
ENDCLASS.
