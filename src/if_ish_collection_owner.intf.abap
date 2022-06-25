*"* components of interface IF_ISH_COLLECTION_OWNER
interface IF_ISH_COLLECTION_OWNER
  public .


  type-pools ABAP .
  methods ALLOWS_DELETE
    returning
      value(R_ALLOWS) type ABAP_BOOL .
  methods ALLOWS_INSERT
    returning
      value(R_ALLOWS) type ABAP_BOOL .
  methods ALLOWS_UPDATE
    returning
      value(R_ALLOWS) type ABAP_BOOL .
endinterface.
