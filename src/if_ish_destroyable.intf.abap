*"* components of interface IF_ISH_DESTROYABLE
interface IF_ISH_DESTROYABLE
  public .


  events EV_AFTER_DESTROY .
  events EV_BEFORE_DESTROY .

  type-pools ABAP .
  methods DESTROY
    returning
      value(R_DESTROYED) type ABAP_BOOL .
  methods IS_DESTROYED
    returning
      value(R_DESTROYED) type ABAP_BOOL .
  methods IS_IN_DESTROY_MODE
    returning
      value(R_DESTROY_MODE) type ABAP_BOOL .
endinterface.
