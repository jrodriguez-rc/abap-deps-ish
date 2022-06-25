*"* components of interface IF_ISH_GUI_TREENODE_MODEL
interface IF_ISH_GUI_TREENODE_MODEL
  public .

  type-pools ICON .

  methods GET_NODE_ICON
    returning
      value(R_NODE_ICON) type TV_IMAGE .
  methods GET_NODE_TEXT
    returning
      value(R_NODE_TEXT) type LVC_VALUE .
endinterface.
