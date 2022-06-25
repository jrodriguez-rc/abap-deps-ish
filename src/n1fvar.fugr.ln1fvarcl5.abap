*----------------------------------------------------------------------*
*   INCLUDE LN1FVARCL5                                                 *
*----------------------------------------------------------------------*
*---------------------------------------------------------------------*
*       CLASS lcl_treeobject DEFINITION
*---------------------------------------------------------------------*
*       Definition of Data Container                                  *
*---------------------------------------------------------------------*
CLASS lcl_drag_object DEFINITION.
  PUBLIC SECTION.
*    DATA text TYPE STANDARD TABLE OF mtreesnode-text.
    data text type standard table of lvc_nkey.
ENDCLASS.

