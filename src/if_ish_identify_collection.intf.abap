*"* components of interface IF_ISH_IDENTIFY_COLLECTION
interface IF_ISH_IDENTIFY_COLLECTION
  public .


  methods ADD_OBJECT
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT .
  methods CLEAR .
  methods GET_OBJECTLIST
    returning
      value(RT_OBJECT) type ISH_OBJECTLIST .
  type-pools ABAP .
  methods GET_OBJECTLIST_BY_TYPE
    importing
      !I_TYPE type ISH_OBJECT_TYPE
      !I_INCL_DERIVED type ABAP_BOOL default ABAP_TRUE
    returning
      value(RT_OBJECT) type ISH_OBJECTLIST .
  methods GET_OBJECTS
    returning
      value(RT_OBJECT) type ISH_T_IDENTIFY_OBJECT .
  methods GET_OBJECTS_BY_TYPE
    importing
      !I_TYPE type ISH_OBJECT_TYPE
      !I_INCL_DERIVED type ABAP_BOOL default ABAP_TRUE
    returning
      value(RT_OBJECT) type ISH_T_IDENTIFY_OBJECT .
  methods HAS_OBJECT
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
    returning
      value(R_HAS_OBJECT) type ABAP_BOOL .
  methods REMOVE_OBJECT
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
    returning
      value(R_REMOVED) type ABAP_BOOL .
endinterface.
