*"* components of interface IF_ISH_GM_ITERABLE
interface IF_ISH_GM_ITERABLE
  public .


  methods ITERATOR
    returning
      value(RR_ITERATOR) type ref to IF_ISH_GM_ITERATOR .
endinterface.
