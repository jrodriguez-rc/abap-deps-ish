*"* components of interface IF_ISH_GUI_BADIAPPL
interface IF_ISH_GUI_BADIAPPL
  public .


  interfaces IF_BADI_CONTEXT .

  methods GET_BADIAPPLID
    returning
      value(R_BADIAPPLID) type N1GUI_BADIAPPLID .
endinterface.
