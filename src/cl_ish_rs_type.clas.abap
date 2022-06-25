class CL_ISH_RS_TYPE definition
  public
  create protected .

*"* public components of class CL_ISH_RS_TYPE
*"* do not include other source files here!!!
public section.

  class-methods CLASS_CONSTRUCTOR .
  class-methods GET_INSTANCE
    importing
      !I_TYPE type N1RS_TYPE
    returning
      value(RR_INSTANCE) type ref to CL_ISH_RS_TYPE .
  methods GET_TYPE
  final
    returning
      value(R_TYPE) type N1RS_TYPE .
  methods GET_CLSNAME_READ_SERVICE
  final
    returning
      value(R_CLSNAME) type SEOCLSNAME .
  class-methods SGET_CLSNAME_READ_SERVICE
    importing
      !I_TYPE type N1RS_TYPE
    returning
      value(R_CLSNAME) type SEOCLSNAME .
  methods CONSTRUCTOR
    importing
      !I_TYPE type N1RS_TYPE
      !I_CLSNAME type SEOCLSNAME .
protected section.
*"* protected components of class CL_ISH_RS_TYPE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_RS_TYPE
*"* do not include other source files here!!!

  class-data GT_TYPE type ISH_T_RS_TYPE_OBJIDH .
  data G_CLSNAME_READ_SERVICE type SEOCLSNAME .
  data G_TYPE type N1RS_TYPE .
ENDCLASS.



CLASS CL_ISH_RS_TYPE IMPLEMENTATION.


METHOD class_constructor.

  DATA: lr_rs_type TYPE REF TO cl_ish_rs_type,
        ls_type    TYPE rn1_rs_type_objidh.

* VITPAR

  CREATE OBJECT lr_rs_type
    EXPORTING
      i_type                 = 'VITPAR'
      i_clsname              = 'CL_ISHMED_VP_RS_READ_SERVICE'.

  ls_type-id = 'VITPAR'.
  ls_type-r_obj = lr_rs_type.

  INSERT ls_type INTO TABLE gt_type .

ENDMETHOD.


METHOD constructor.

* set the global attributes for the instance
  g_type = i_type.
  g_clsname_read_service = i_clsname.

ENDMETHOD.


METHOD get_clsname_read_service.

* return the clsname
  r_clsname = g_clsname_read_service.

ENDMETHOD.


METHOD get_instance.

  DATA: ls_type TYPE rn1_rs_type_objidh.

* get the right instnce for the type
  READ TABLE gt_type INTO ls_type WITH KEY id = i_type.

  CHECK sy-subrc = 0.

  rr_instance = ls_type-r_obj.


ENDMETHOD.


METHOD get_type.

* return the type
  r_type = g_type.

ENDMETHOD.


METHOD sget_clsname_read_service.

  DATA: lr_rs_type TYPE REF TO cl_ish_rs_type.

* get the instance for the type
  lr_rs_type = get_instance( i_type ).
  CHECK lr_rs_type IS BOUND.

* get the classname of the instance
  r_clsname = lr_rs_type->get_clsname_read_service( ).

ENDMETHOD.
ENDCLASS.
