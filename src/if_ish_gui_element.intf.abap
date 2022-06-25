*"* components of interface IF_ISH_GUI_ELEMENT
interface IF_ISH_GUI_ELEMENT
  public .


  methods GET_ELEMENT_ID
    returning
      value(R_ELEMENT_ID) type N1GUI_ELEMENT_ID .
  methods GET_ELEMENT_NAME
    returning
      value(R_ELEMENT_NAME) type N1GUI_ELEMENT_NAME .
endinterface.
