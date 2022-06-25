*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_POPUPF01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Form  pbo
*&---------------------------------------------------------------------*
*       PBO
*----------------------------------------------------------------------*
FORM pbo .

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_process IS INITIAL.

  CALL METHOD gr_process->pbo
    CHANGING
      cr_errorhandler = lr_errorhandler.

  CALL METHOD gr_process->collect_messages
    EXPORTING
      ir_errorhandler = lr_errorhandler.

ENDFORM.                    " pbo


*&---------------------------------------------------------------------*
*&      Form  before_pbo_subscreen
*&---------------------------------------------------------------------*
*       Before PBO of the subscreen.
*----------------------------------------------------------------------*
FORM before_pbo_subscreen .

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_process IS INITIAL.

  CALL METHOD gr_process->before_pbo_subscreen.

  CALL METHOD gr_process->collect_messages
    EXPORTING
      ir_errorhandler = lr_errorhandler.

ENDFORM.                    " before_pbo_subscreen


*&---------------------------------------------------------------------*
*&      Form  exit_command
*&---------------------------------------------------------------------*
*       ExitCommand
*----------------------------------------------------------------------*
FORM exit_command .

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_exit           TYPE ish_on_off,
        l_rc             TYPE ish_method_rc.

  CHECK NOT gr_process IS INITIAL.

  CALL METHOD gr_process->exit_command
    IMPORTING
      e_exit          = l_exit
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.
  IF l_rc <> 0.
    l_exit = on.
  ENDIF.

  CALL METHOD gr_process->collect_messages
    EXPORTING
      ir_errorhandler = lr_errorhandler.

  IF l_exit = on.
    LEAVE TO SCREEN 0.
  ENDIF.

ENDFORM.                    " exit_command


*&---------------------------------------------------------------------*
*&      Form  pai
*&---------------------------------------------------------------------*
*       PAI
*----------------------------------------------------------------------*
FORM pai .

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_process IS INITIAL.

  CALL METHOD gr_process->pai
    CHANGING
      cr_errorhandler = lr_errorhandler.

  CALL METHOD gr_process->collect_messages
    EXPORTING
      ir_errorhandler = lr_errorhandler.

ENDFORM.                    " pai

*&---------------------------------------------------------------------*
*&      Form  before_pai_subscreen
*&---------------------------------------------------------------------*
*       Before PAI of the subscreen.
*----------------------------------------------------------------------*
FORM before_pai_subscreen .

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_process IS INITIAL.

  CALL METHOD gr_process->before_pai_subscreen.

  CALL METHOD gr_process->collect_messages
    EXPORTING
      ir_errorhandler = lr_errorhandler.

ENDFORM.                    " before_pai_subscreen


*&---------------------------------------------------------------------*
*&      Form  after_pai
*&---------------------------------------------------------------------*
*       After PAI of all subscreens
*----------------------------------------------------------------------*
FORM after_pai .

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_process IS INITIAL.

  CALL METHOD gr_process->after_pai
    CHANGING
      cr_errorhandler = lr_errorhandler.

  CALL METHOD gr_process->collect_messages
    EXPORTING
      ir_errorhandler = lr_errorhandler.

ENDFORM.                    " after_pai


*&---------------------------------------------------------------------*
*&      Form  user_command
*&---------------------------------------------------------------------*
*       Handle UserCommand
*----------------------------------------------------------------------*
FORM user_command .

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_exit           TYPE ish_on_off,
        l_rc             TYPE ish_method_rc.

  CHECK NOT gr_process IS INITIAL.

  CALL METHOD gr_process->user_command
    IMPORTING
      e_exit          = l_exit
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.
  IF l_rc <> 0.
    l_exit = off.
  ENDIF.

  CALL METHOD gr_process->collect_messages
    EXPORTING
      ir_errorhandler = lr_errorhandler.

  IF l_exit = on.
    LEAVE TO SCREEN 0.
  ENDIF.

ENDFORM.                    " user_command


*&---------------------------------------------------------------------*
*&      Form  after_pbo
*&---------------------------------------------------------------------*
*       After PBO
*----------------------------------------------------------------------*
FORM after_pbo .

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_process IS INITIAL.

  CALL METHOD gr_process->after_pbo
    CHANGING
      cr_errorhandler = lr_errorhandler.

  CALL METHOD gr_process->collect_messages
    EXPORTING
      ir_errorhandler = lr_errorhandler.

ENDFORM.                    " after_pbo
