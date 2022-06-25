interface IF_ISHMED_API
  public .


  interfaces IF_ISHMED_API_DESCRIPTOR .
  interfaces IF_ISHMED_API_DOCUMENTATION .

  methods GET_TYPE
    returning
      value(R_VALUE) type N1API_TYPE .
  methods GET_VERSION
    returning
      value(R_VALUE) type N1API_VERSION .
endinterface.
