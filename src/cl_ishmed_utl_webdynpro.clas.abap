class CL_ISHMED_UTL_WEBDYNPRO definition
  public
  abstract
  create public .

public section.

  type-pools ABAP .
  class-methods IS_CONFIG_EDITOR_RUNNING
    returning
      value(R_RUNNING) type ABAP_BOOL .
  class-methods SET_CONFIG_EDITOR_RUNNING
    importing
      !IR_CONFIG_EDITOR_WDCOMP type ref to IF_WD_COMPONENT .
protected section.

  class-data GR_CONFIG_EDITOR_WDCOMP type ref to IF_WD_COMPONENT .
private section.
ENDCLASS.



CLASS CL_ISHMED_UTL_WEBDYNPRO IMPLEMENTATION.


METHOD IS_CONFIG_EDITOR_RUNNING.

  CHECK gr_config_editor_wdcomp IS BOUND.

  r_running = abap_true.

ENDMETHOD.


METHOD SET_CONFIG_EDITOR_RUNNING.

  gr_config_editor_wdcomp = ir_config_editor_wdcomp.

ENDMETHOD.
ENDCLASS.
