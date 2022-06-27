INTERFACE if_ish_constant_definition
  PUBLIC.

  CONSTANTS on TYPE ish_on_off VALUE 'X'. "#EC NOTEXT
  CONSTANTS off TYPE ish_on_off VALUE space. "#EC NOTEXT
  CONSTANTS true TYPE ish_true_false VALUE '1'. "#EC NOTEXT
  CONSTANTS false TYPE ish_true_false VALUE '0'. "#EC NOTEXT
  CONSTANTS yes TYPE ish_on_off VALUE 'Y'. "#EC NOTEXT
  CONSTANTS no TYPE ish_on_off VALUE 'N'. "#EC NOTEXT
  CONSTANTS active TYPE ish_true_false VALUE '1'. "#EC NOTEXT
  CONSTANTS inactive TYPE ish_true_false VALUE '0'. "#EC NOTEXT
  CONSTANTS cv_germany TYPE tn00-cvers VALUE 'DE'. "#EC NOTEXT
  CONSTANTS cv_netherlands TYPE tn00-cvers VALUE 'NL'. "#EC NOTEXT
  CONSTANTS cv_austria TYPE tn00-cvers VALUE 'AT'. "#EC NOTEXT
  CONSTANTS cv_singapore TYPE tn00-cvers VALUE 'SG'. "#EC NOTEXT
  CONSTANTS cv_switzerland TYPE tn00-cvers VALUE 'CH'. "#EC NOTEXT
  CONSTANTS cv_spain TYPE tn00-cvers VALUE 'ES'. "#EC NOTEXT
  CONSTANTS cv_italy TYPE tn00-cvers VALUE 'IT'. "#EC NOTEXT
  CONSTANTS cv_france TYPE tn00-cvers VALUE 'FR'. "#EC NOTEXT
  CONSTANTS cv_canada TYPE tn00-cvers VALUE 'CA'. "#EC NOTEXT
  CONSTANTS cv_china TYPE tn00-cvers VALUE 'CN'. "#EC NOTEXT
  CONSTANTS co_mode_insert TYPE ish_modus VALUE 'I'. "#EC NOTEXT
  CONSTANTS co_mode_update TYPE ish_modus VALUE 'U'. "#EC NOTEXT
  CONSTANTS co_mode_delete TYPE ish_modus VALUE 'D'. "#EC NOTEXT
  CONSTANTS co_mode_unchanged TYPE ish_modus VALUE space. "#EC NOTEXT
  CONSTANTS co_mode_error TYPE ish_modus VALUE 'E'. "#EC NOTEXT
  CONSTANTS co_vcode_insert TYPE ish_vcode VALUE 'INS'. "#EC NOTEXT
  CONSTANTS co_vcode_update TYPE ish_vcode VALUE 'UPD'. "#EC NOTEXT
  CONSTANTS co_vcode_display TYPE ish_vcode VALUE 'DIS'. "#EC NOTEXT
ENDINTERFACE.