*"* components of interface IF_ISH_RS_OBJECT
interface IF_ISH_RS_OBJECT
  public .


  methods GET_READ_SERVICE
    returning
      value(RR_READ_SERVICE) type ref to IF_ISH_RS_READ_SERVICE .
endinterface.
