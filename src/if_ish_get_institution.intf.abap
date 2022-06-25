*"* components of interface IF_ISH_GET_INSTITUTION
interface IF_ISH_GET_INSTITUTION
  public .


  methods GET_INSTITUTION
    returning
      value(R_EINRI) type TN01-EINRI .
endinterface.
