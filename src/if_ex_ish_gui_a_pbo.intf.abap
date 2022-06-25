*"* components of interface IF_EX_ISH_GUI_A_PBO
interface IF_EX_ISH_GUI_A_PBO
  public .


  interfaces IF_BADI_INTERFACE .

  methods AFTER_PBO
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION
      !IR_DYNPRO_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW
      !I_REPID type SYREPID
      !I_DYNNR type SYDYNNR
    changing
      !CR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
