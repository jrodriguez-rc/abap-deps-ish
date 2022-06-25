*"* components of interface IF_ISH_DOM
interface IF_ISH_DOM
  public .


  methods GET_DOM_NODE
    importing
      value(IR_DOCUMENT) type ref to IF_IXML_DOCUMENT
      !IR_CONFIG type ref to IF_ISH_CONFIG optional
    exporting
      value(ER_NODE) type ref to IF_IXML_NODE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DOM_DOCUMENT
    importing
      value(IR_IXML) type ref to IF_IXML optional
      !IR_CONFIG type ref to IF_ISH_CONFIG optional
    exporting
      value(ER_DOCUMENT) type ref to IF_IXML_DOCUMENT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DOM_FRAGMENT
    importing
      value(IR_DOCUMENT) type ref to IF_IXML_DOCUMENT
      !IR_CONFIG type ref to IF_ISH_CONFIG optional
    exporting
      value(ER_DOCUMENT_FRAGMENT) type ref to IF_IXML_DOCUMENT_FRAGMENT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods MODIFY_DOM_DATA
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !CR_DOCUMENT_FRAGMENT type ref to IF_IXML_DOCUMENT_FRAGMENT optional
      !CR_ELEMENT type ref to IF_IXML_ELEMENT optional .
endinterface.
