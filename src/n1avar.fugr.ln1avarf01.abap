*----------------------------------------------------------------------*
***INCLUDE LN1AVARF01 .
*----------------------------------------------------------------------*
*&--------------------------------------------------------------------*
*&      Form  variants_read
*&--------------------------------------------------------------------*
*       read display variants (layouts)
*---------------------------------------------------------------------*
FORM variants_read   TABLES   pt_variants  STRUCTURE ltvariant
                     USING    value(ps_dispvar)      TYPE disvariant
                              value(i_user_specific) TYPE ish_on_off
                     CHANGING p_rc                   TYPE sy-subrc.

  RANGES: lr_report    FOR ltdx-report,
          lr_handle    FOR ltdx-handle,
          lr_log_group FOR ltdx-log_group,
          lr_username  FOR ltdx-username,
          lr_variant   FOR ltdx-variant,
          lr_type      FOR ltdx-type.

  lr_report-sign = 'I'.
  lr_report-option = 'EQ'.
  lr_report-low    = ps_dispvar-report.
  APPEND lr_report.

  lr_handle-sign = 'I'.
  lr_handle-option = 'EQ'.
  lr_handle-low    = ps_dispvar-handle.
  APPEND lr_handle.

  lr_log_group-sign   = 'I'.
  lr_log_group-option = 'EQ'.
  lr_log_group-low    = ps_dispvar-log_group.
  APPEND lr_log_group.

  IF NOT i_user_specific IS INITIAL.
    lr_username-sign   = 'I'.
    lr_username-option = 'EQ'.
    IF ps_dispvar-username IS INITIAL.
      lr_username-sign   = 'I'.
      lr_username-option = 'EQ'.
      lr_username-low    = space.
      APPEND lr_username.
      lr_username-low    = sy-uname.
    ELSE.
      lr_username-low    = ps_dispvar-username.
    ENDIF.
    APPEND lr_username.
  ELSE.
    lr_username-sign   = 'I'.
    lr_username-option = 'EQ'.
    lr_username-low    = space.
    APPEND lr_username.
  ENDIF.

  IF NOT ps_dispvar-variant IS INITIAL.
    lr_variant-sign   = 'I'.
    lr_variant-option = 'EQ'.
    lr_variant-low    = ps_dispvar-variant.
    APPEND lr_variant.
  ENDIF.

  lr_type-sign   = 'I'.
  lr_type-option = 'EQ'.
  lr_type-low    = 'F'.
  APPEND lr_type.

  CALL FUNCTION 'LT_VARIANTS_READ_FROM_LTDX'
    EXPORTING
      i_tool          = 'LT'
      i_text          = 'X'
    TABLES
      et_variants     = pt_variants
      it_ra_report    = lr_report
      it_ra_handle    = lr_handle
      it_ra_log_group = lr_log_group
      it_ra_username  = lr_username
      it_ra_variant   = lr_variant
      it_ra_type      = lr_type
    EXCEPTIONS
      not_found       = 1
      OTHERS          = 2.

  p_rc = sy-subrc.

ENDFORM.                               " VARIANTS_RAED
