INTERFACE if_ish_gui_treenode_model
  PUBLIC.

  METHODS get_node_icon
    RETURNING
      VALUE(r_node_icon) TYPE tv_image.
  METHODS get_node_text
    RETURNING
      VALUE(r_node_text) TYPE lvc_value.
ENDINTERFACE.