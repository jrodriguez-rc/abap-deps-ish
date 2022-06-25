*"* components of interface IF_ISH_INDEXED_OBJECT_ITAB
interface IF_ISH_INDEXED_OBJECT_ITAB
  public .


  methods OBJECT_AT
    importing
      !I_INDEX type I
    returning
      value(RR_OBJECT) type ref to OBJECT .
  methods FIRST_OBJECT
    returning
      value(RR_OBJECT) type ref to OBJECT .
  methods LAST_OBJECT
    returning
      value(RR_OBJECT) type ref to OBJECT .
endinterface.
