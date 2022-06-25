*"* components of interface IF_ISH_CORDT_ELEM
interface IF_ISH_CORDT_ELEM
  public .


  methods GET_ELEM_TYPE
    returning
      value(R_TYPE) type STRING .
  methods GET_ELEM_NAME
    returning
      value(R_NAME) type STRING .
  methods GET_ASS_TYPE
    returning
      value(R_TYPE) type N1COTATYP .
endinterface.
