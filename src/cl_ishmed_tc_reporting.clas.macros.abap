*"* use this source file for any macro definitions you need
*"* in the implementation part of the class

  DEFINE add_field_value.
    clear ls_value.

    ls_value-name     = &1.
    ls_value-kind     = &2.
    ls_value-position = &3.

    append ls_value to lt_values.
  END-OF-DEFINITION.
