*"* components of interface IF_EX_ISH_GUI_SETPOPCOORD
interface IF_EX_ISH_GUI_SETPOPCOORD
  public .


  interfaces IF_BADI_INTERFACE .

  methods SET_POPUP_COORDINATES
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION
    changing
      !C_START_COL type I
      !C_START_ROW type I
      !C_END_COL type I
      !C_END_ROW type I .
endinterface.
