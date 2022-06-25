*"* components of interface IF_ISH_FAC_AS_PARAM
interface IF_ISH_FAC_AS_PARAM
  public .


  class-methods CREATE_PARAMS
    importing
      !IR_AREA type ref to CL_ISH_SHA_APPLSETTINGS optional
    preferred parameter IR_AREA
    returning
      value(RT_PARAM) type ISH_T_AS_PARAM .
endinterface.
