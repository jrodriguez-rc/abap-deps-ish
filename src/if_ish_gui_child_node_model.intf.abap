*"* components of interface IF_ISH_GUI_CHILD_NODE_MODEL
interface IF_ISH_GUI_CHILD_NODE_MODEL
  public .


  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_NODE_MODEL .

  aliases CO_RELAT_FIRST_CHILD
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_FIRST_CHILD .
  aliases CO_RELAT_FIRST_SIBLING
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_FIRST_SIBLING .
  aliases CO_RELAT_LAST_CHILD
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_LAST_CHILD .
  aliases CO_RELAT_LAST_SIBLING
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_LAST_SIBLING .
  aliases CO_RELAT_NEXT_SIBLING
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_NEXT_SIBLING .
  aliases CO_RELAT_PREV_SIBLING
    for IF_ISH_GUI_NODE_MODEL~CO_RELAT_PREV_SIBLING .

  methods GET_FIRST_SIBLING
    returning
      value(RR_FIRST_SIBLING) type ref to IF_ISH_GUI_CHILD_NODE_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_LAST_SIBLING
    returning
      value(RR_LAST_SIBLING) type ref to IF_ISH_GUI_CHILD_NODE_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_NEXT_SIBLING
    returning
      value(RR_NEXT_SIBLING) type ref to IF_ISH_GUI_CHILD_NODE_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_PARENT_NODE
    returning
      value(RR_PARENT_NODE) type ref to IF_ISH_GUI_PARENT_NODE_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_PREVIOUS_SIBLING
    returning
      value(RR_PREVIOUS_SIBLING) type ref to IF_ISH_GUI_CHILD_NODE_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
