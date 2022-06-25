*"* components of interface IF_ISH_CONTROLLABLE
interface IF_ISH_CONTROLLABLE
  public .


  events EV_OWNER_REGISTERED
    exporting
      value(ER_OWNER) type ref to IF_ISH_CONTROLLABLE_OWNER
      value(E_ACTION) type N1_CB_ACTION .
  events EV_OWNER_DEREGISTERED
    exporting
      value(ER_OWNER) type ref to IF_ISH_CONTROLLABLE_OWNER
      value(E_ACTION) type N1_CB_ACTION .

  methods REGISTER_OWNER
    importing
      !IR_OWNER type ref to IF_ISH_CONTROLLABLE_OWNER
      value(I_ACTION) type N1_CB_ACTION
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods DEREGISTER_OWNER
    importing
      !IR_OWNER type ref to IF_ISH_CONTROLLABLE_OWNER
      value(I_ACTION) type N1_CB_ACTION
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods GET_OWNERS
    importing
      value(I_ACTION) type N1_CB_ACTION
    returning
      value(RT_OWNER) type ISH_T_CONTROLLABLE_OWNER_OBJ .
  methods HAS_OWNER
    importing
      !IR_OWNER type ref to IF_ISH_CONTROLLABLE_OWNER
      value(I_ACTION) type N1_CB_ACTION
    returning
      value(R_HAS_OWNER) type ABAP_BOOL .
endinterface.
