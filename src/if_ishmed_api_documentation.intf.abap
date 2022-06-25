interface IF_ISHMED_API_DOCUMENTATION
  public .


  methods GET
    exporting
      !E_ID type DOKU_ID
      !E_OBJECT type DOKU_OBJ .
  methods GET_DESCRIPTION
    returning
      value(R_VALUE) type N1API_DESCRIPTION .
  methods GET_PROGRAM
    exporting
      !ET_VALUE type PROGRAMT .
endinterface.
