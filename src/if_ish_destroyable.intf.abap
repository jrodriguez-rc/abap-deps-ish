*"* components of interface IF_ISH_DESTROYABLE
INTERFACE if_ish_destroyable
  PUBLIC.


  EVENTS ev_after_destroy.
  EVENTS ev_before_destroy.

  METHODS destroy
    RETURNING
      VALUE(r_destroyed) TYPE abap_bool.
  METHODS is_destroyed
    RETURNING
      VALUE(r_destroyed) TYPE abap_bool.
  METHODS is_in_destroy_mode
    RETURNING
      VALUE(r_destroy_mode) TYPE abap_bool.
ENDINTERFACE.