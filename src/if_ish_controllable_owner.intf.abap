*"* components of interface IF_ISH_CONTROLLABLE_OWNER
interface IF_ISH_CONTROLLABLE_OWNER
  public .


  methods CB_REG_TO_CONTROLLABLE
    importing
      value(I_ACTION) type N1_CB_ACTION
      !IR_CONTROLLABLE type ref to IF_ISH_CONTROLLABLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_REG_FURTHER_OWNER
    importing
      value(I_ACTION) type N1_CB_ACTION
      !IR_CONTROLLABLE type ref to IF_ISH_CONTROLLABLE
      !IR_FURTHER_OWNER type ref to IF_ISH_CONTROLLABLE_OWNER
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods CB_DEREG_FROM_CONTROLLABLE
    importing
      value(I_ACTION) type N1_CB_ACTION
      !IR_CONTROLLABLE type ref to IF_ISH_CONTROLLABLE
    returning
      value(R_ALLOWED) type ABAP_BOOL .
  methods CB_SIMPLE_ACTION
    importing
      !IR_CONTROLLABLE type ref to IF_ISH_CONTROLLABLE
      value(I_ACTION) type N1_CB_ACTION
      !IR_PARAMETERS type ref to CL_ISH_NAMED_CONTENT_LIST optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_BOOLEAN_ACTION
    importing
      !IR_CONTROLLABLE type ref to IF_ISH_CONTROLLABLE
      value(I_ACTION) type N1_CB_ACTION
      !IR_PARAMETERS type ref to CL_ISH_NAMED_CONTENT_LIST optional
    returning
      value(R_RESULT) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_COMPLEX_ACTION
    importing
      !IR_CONTROLLABLE type ref to IF_ISH_CONTROLLABLE
      value(I_ACTION) type N1_CB_ACTION
      !IR_PARAMETERS type ref to CL_ISH_NAMED_CONTENT_LIST optional
    returning
      value(RR_RESULT) type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
