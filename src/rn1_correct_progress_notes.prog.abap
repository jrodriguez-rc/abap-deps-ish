*&---------------------------------------------------------------------*
*& Report RN1_CORRECT_PROGRESS_NOTES
*&---------------------------------------------------------------------*
*& New report created for MED-82005
*&---------------------------------------------------------------------*
REPORT RN1_CORRECT_PROGRESS_NOTES.

TABLES: n2vdnote_context, nfal, n2vd, n2vdnote, n2vditems, n2vdnote_type.

CONSTANTS:
           on                TYPE ish_on_off VALUE 'X',
           off               TYPE ish_on_off VALUE ' '.

 DATA: l_save          TYPE c LENGTH 1,
       l_title         TYPE string,
       l_textline      TYPE string,
       l_question      TYPE string.


DATA: lt_oldnotes TYPE STANDARD TABLE OF n2vdnote_context.
DATA: lt_oldnotes_all TYPE STANDARD TABLE OF n2vdnote,
      lt_notes TYPE STANDARD TABLE OF n2vdnote,
      lt_note_types TYPE STANDARD TABLE OF n2vdnote_type,
      lt_new_types TYPE STANDARD TABLE OF n2vdnote_type.
DATA: l_source_pat TYPE patnr,
      l_target_pat TYPE patnr,
      l_source_pat_name TYPE nname_pat,
      l_source_pat_surname TYPE vname_pat,
      l_target_pat_name TYPE nname_pat,
      l_target_pat_surname TYPE vname_pat,
      l_source_storn TYPE ri_storn,
      l_target_storn TYPE ri_storn,
      l_source_vdkey TYPE N2VD_KEY,
      l_target_vdkey TYPE N2VD_KEY,
      l_notes TYPE int2,
      l_simple_update TYPE ish_on_off,
      l_update_errors TYPE ish_on_off,
      l_delete_old_key TYPE ish_on_off.


FIELD-SYMBOLS: <fs_notes> TYPE n2vdnote_context,
               <fs_note_update> TYPE n2vdnote,
               <fs_note_type> TYPE n2vdnote_type,
               <fs_oldnotes> TYPE n2vdnote.

DATA l_screen_errors TYPE ish_on_off.

DATA: ls_source_n2vd TYPE n2vd,
      ls_target_n2vd TYPE n2vd.


* source institution
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (30) text-001 FOR FIELD pf_einri.
SELECTION-SCREEN POSITION 40.
PARAMETERS pf_einri TYPE nfal-einri.
SELECTION-SCREEN END OF LINE.

* source case number
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (30) text-002 FOR FIELD pf_case.
SELECTION-SCREEN POSITION 40.
PARAMETERS pf_case TYPE nfal-falnr.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN SKIP.

* target institution
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (30) text-003 FOR FIELD pt_einri.
SELECTION-SCREEN POSITION 40.
PARAMETERS pt_einri TYPE nfal-einri.
SELECTION-SCREEN END OF LINE.

* target case number
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (30) text-004 FOR FIELD pt_case.
SELECTION-SCREEN POSITION 40.
PARAMETERS pt_case TYPE nfal-falnr.
SELECTION-SCREEN END OF LINE.

* target movement number
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (30) text-006 FOR FIELD pt_movmt.
SELECTION-SCREEN POSITION 40.
PARAMETERS pt_movmt TYPE lfdbew default '00001'.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN SKIP.

* correct data
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (39) text-005 FOR FIELD pa_test.
SELECTION-SCREEN POSITION 41.
PARAMETERS pa_test  AS CHECKBOX DEFAULT on.
SELECTION-SCREEN END OF LINE.


INITIALIZATION.

  IF pf_einri IS INITIAL.
    GET PARAMETER ID 'EIN' FIELD pf_einri.
  ENDIF.

  IF pt_einri IS INITIAL.
    GET PARAMETER ID 'EIN' FIELD pt_einri.
  ENDIF.

AT SELECTION-SCREEN OUTPUT.

 l_screen_errors = 'X'.

* check institutions
  IF pf_einri IS INITIAL.
    SET CURSOR FIELD 'PF_EINRI'.
    MESSAGE s819(nf1).
    EXIT.
  ENDIF.

  IF pt_einri IS INITIAL.
    SET CURSOR FIELD 'PT_EINRI'.
    MESSAGE s819(nf1).
    EXIT.
  ENDIF.

* check cases
  IF pf_case IS INITIAL.
    SET CURSOR FIELD 'PF_CASE'.
    MESSAGE s033(nf1).
    EXIT.
  ENDIF.

  IF pt_case IS INITIAL.
    SET CURSOR FIELD 'PT_CASE'.
    MESSAGE s033(nf1).
    EXIT.
  ENDIF.

  IF pt_case = pf_case.
    SET CURSOR FIELD 'PT_CASE'.
    MESSAGE s033(nf1).
    EXIT.
  ENDIF.

  CLEAR l_screen_errors.

START-OF-SELECTION.

 IF l_screen_errors = 'X'.
   PERFORM clear_all.
   EXIT.
 ENDIF.

*check source case
SELECT SINGLE patnr storn FROM nfal INTO (l_source_pat , l_source_storn) WHERE einri = pf_einri AND falnr = pf_case.
   IF sy-subrc <> 0.
    SET CURSOR FIELD 'PF_CASE'.
    MESSAGE s710(n1) WITH sy-datum pf_case.
    EXIT.
   ENDIF.

*check target case
SELECT SINGLE patnr storn FROM nfal INTO (l_target_pat , l_target_storn) WHERE einri = pt_einri AND falnr = pt_case.
   IF sy-subrc <> 0.
    SET CURSOR FIELD 'PT_CASE'.
    MESSAGE s710(n1) WITH sy-datum pt_case.
    EXIT.
   ENDIF.
   IF l_target_storn = 'X'.
    SET CURSOR FIELD 'PT_CASE'.
    MESSAGE s026(n1) WITH pt_case.
    EXIT.
   ENDIF.

*check target patient
SELECT SINGLE nname vname storn FROM npat INTO (l_target_pat_name , l_target_pat_surname , l_target_storn) WHERE patnr = l_target_pat.
   IF sy-subrc <> 0 OR l_target_storn = 'X'.
    SET CURSOR FIELD 'PT_CASE'.
    MESSAGE s018(n1) WITH l_target_pat.
    EXIT.
   ENDIF.

"case not canceled - source
IF l_source_storn <> 'X'.
  l_title = 'Confirm choice'(007).
  CONCATENATE 'Fall'(008) pf_case 'not canceled'(009) INTO l_textline SEPARATED BY space.
  l_question = 'Move progress notes anyways?'(010).
  CALL FUNCTION 'ISH_POPUP_TO_CONFIRM_SIMPLE'
  EXPORTING
    i_title    = l_title
    i_textline = l_textline
    i_question = l_question
  IMPORTING
    e_answer       = l_save
  EXCEPTIONS
    text_not_found = 1
    OTHERS         = 2.

  IF sy-subrc = 0.
    CASE l_save.
    WHEN 'Y'. "user wants to save - proceed with next checks!
    WHEN OTHERS. "user wants to cancel the close-command.
      PERFORM clear_all.
      EXIT.
    ENDCASE.
  ELSE.
    PERFORM clear_all.
    EXIT.
  ENDIF.
ENDIF.

"different patient
IF l_source_pat <> l_target_pat.
  l_title = 'Confirm choice'(007).
  CONCATENATE 'Target patient'(011) l_target_pat 'different from source patient'(012) l_source_pat INTO l_textline SEPARATED BY space.
  l_question = 'Move progress notes anyways?'(010).
  CALL FUNCTION 'ISH_POPUP_TO_CONFIRM_SIMPLE'
  EXPORTING
    i_title    = l_title
    i_textline = l_textline
    i_question = l_question
  IMPORTING
    e_answer       = l_save
  EXCEPTIONS
    text_not_found = 1
    OTHERS         = 2.

  IF sy-subrc = 0.
    CASE l_save.
    WHEN 'Y'. "user wants to save - proceed with data selection!
    WHEN OTHERS. "user wants to cancel the close-command.
      PERFORM clear_all.
      EXIT.
    ENDCASE.
  ELSE.
    PERFORM clear_all.
    EXIT.
  ENDIF.
ELSE.
  l_simple_update = 'X'. "if target patient is the same, change is much easier to do
ENDIF.


* select data to be changed
  PERFORM select_data.

 IF l_update_errors = 'X'.
   "errors occured - process stopped!
    MESSAGE s157(n1) WITH pt_case.
    PERFORM clear_all.
    EXIT.
 ENDIF.

"if answer to everything is yes and something is found in select_data - show another popup to confirm that progress notes will be canceled/moved!
IF lt_oldnotes IS NOT INITIAL.
  DESCRIBE TABLE lt_oldnotes LINES l_notes.
  l_title = 'Confirm choice'(007).
  l_textline = l_notes.
  CONCATENATE l_textline 'notes found for patient'(013) l_source_pat l_source_pat_name l_source_pat_surname 'fall'(008) pf_case INTO l_textline SEPARATED BY space.
  CONCATENATE 'Copy these to case'(014) pt_case INTO l_question SEPARATED BY space.
  IF l_simple_update = 'X'.
    CONCATENATE l_question 'of the same patient?'(015)  INTO l_question SEPARATED BY space.
  ELSE.
    CONCATENATE l_question 'of patient'(016) l_target_pat l_target_pat_name l_target_pat_surname '?' INTO l_question SEPARATED BY space.
  ENDIF.
  CALL FUNCTION 'ISH_POPUP_TO_CONFIRM_SIMPLE'
  EXPORTING
    i_title    = l_title
    i_textline = l_textline
    i_question = l_question
  IMPORTING
    e_answer       = l_save
  EXCEPTIONS
    text_not_found = 1
    OTHERS         = 2.

  IF sy-subrc = 0.
    CASE l_save.
    WHEN 'Y'. "user wants to save - proceed with updates!
    WHEN OTHERS. "user wants to cancel the close-command.
      PERFORM clear_all.
      EXIT.
    ENDCASE.
  ELSE.
    PERFORM clear_all.
    EXIT.
  ENDIF.
ELSE.
  MESSAGE s010(n1). "no data found
  PERFORM clear_all.
  EXIT.
ENDIF.

* update data in internal tables
  PERFORM update_internal.

* write header
  PERFORM header.

* write corrected data
  PERFORM output.

* update data in database tables
  IF pa_test = off.
  PERFORM update_db.
   IF l_update_errors = 'X'.
   "errors occured - process stoped!
    MESSAGE s157(n1) WITH pt_case.
    PERFORM clear_all.
    EXIT.
   ENDIF.
  ENDIF.

* clear all structures for next possible calls
  PERFORM clear_all.


  TOP-OF-PAGE.
  WRITE: 'Save this protocol in a local file for further reference!'(017).
  ULINE.

*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM select_data .

"select patient details
  SELECT SINGLE nname vname FROM npat INTO (l_source_pat_name , l_source_pat_surname ) WHERE patnr = l_source_pat.

"select all existing (not canceled) notes for source case
  SELECT a~*  INTO TABLE @lt_oldnotes FROM n2vdnote_context AS a
   JOIN n2vdnote AS b ON a~notekey = b~notekey
   WHERE a~institution = @pf_einri AND a~caseid = @pf_case
    AND b~cancelled <> 'X'.

  IF sy-subrc = 0 AND lt_oldnotes IS NOT INITIAL.
    "data was found
    "we need to know the current key!
    SELECT SINGLE a~vdkey INTO l_source_vdkey
     FROM n2vd AS a JOIN n2vdnote_type AS b ON a~vdkey = b~vdkey
     JOIN n2vdnote AS c ON b~notekey = c~notekey
     JOIN n2vdnote_context AS d ON c~notekey = d~notekey
     WHERE a~patient_id = l_source_pat
      AND a~n8dlflag <> 'X'     "not deleted
      AND c~cancelled <> 'X'    "not cancelled
      AND d~caseid = pf_case
      AND d~institution = pf_einri.

    IF sy-subrc <> 0 OR l_source_vdkey IS INITIAL.
      "something is wrong - no key can be determined!
      l_update_errors = 'X'.
      EXIT.
    ENDIF.

      "read also note data for updating tables
    SELECT a~* INTO TABLE @lt_notes
     FROM n2vdnote AS a JOIN n2vdnote_type AS b ON a~notekey = b~notekey
     JOIN n2vdnote_context AS c ON b~notekey = c~notekey
     WHERE a~cancelled <> 'X'    "not cancelled
      AND b~vdkey =  @l_source_vdkey
      AND c~caseid = @pf_case
      AND c~institution = @pf_einri.

      IF sy-subrc <> 0 OR lt_notes IS INITIAL.
        "something is wrong
        l_update_errors = 'X'.
        EXIT.
      ENDIF.

    IF l_simple_update <> 'X'. "need to change also the patient!
      "search if the target case already has created notes
      SELECT SINGLE a~vdkey INTO l_target_vdkey
       FROM n2vd AS a JOIN n2vdnote_type AS b ON a~vdkey = b~vdkey
       JOIN n2vdnote AS c ON b~notekey = c~notekey
       JOIN n2vdnote_context AS d ON c~notekey = d~notekey
       WHERE a~patient_id = l_target_pat
        AND a~n8dlflag <> 'X'
        AND c~cancelled <> 'X'
        AND d~caseid = pt_case
        AND d~institution = pt_einri.
       IF sy-subrc <> 0.  "no notes on the case - try if the patient has some already!
      "search if the target patient already has some created notes
         SELECT SINGLE a~vdkey INTO l_target_vdkey
          FROM n2vd AS a JOIN n2vdnote_type AS b ON a~vdkey = b~vdkey
          JOIN n2vdnote AS c ON b~notekey = c~notekey
          WHERE a~patient_id = l_target_pat
           AND a~n8dlflag <> 'X'
           AND c~cancelled <> 'X'.
       ENDIF.
      "no need to check sy-subrc here - it is possible that no entry will be found
      "if target patient has no notes, no key will be found - we will need to create one ourselves later

      "copy data from the existing key to use as template
      SELECT SINGLE * FROM n2vd INTO ls_source_n2vd WHERE vdkey = l_source_vdkey.
      IF sy-subrc <> 0 OR ls_source_n2vd IS INITIAL.
        "something is wrong
        l_update_errors = 'X'.
        EXIT.
      ENDIF.

      "retrieve all existing notes for the current key to see if we need to delete it
      "we need to consider also cancelled notes - these still refer to the key!
      SELECT a~*  INTO TABLE @lt_oldnotes_all FROM n2vdnote AS a
       JOIN n2vdnote_type AS b ON a~notekey = b~notekey
       WHERE  b~vdkey = @l_source_vdkey.

      IF sy-subrc <> 0 OR lt_oldnotes_all IS INITIAL.
        "something is wrong
        l_update_errors = 'X'.
        EXIT.
      ENDIF.

     "read also type data for updating tables
    SELECT a~* INTO TABLE @lt_note_types
     FROM n2vdnote_type AS a JOIN n2vdnote AS b ON a~notekey = b~notekey
     JOIN n2vdnote_context AS c ON b~notekey = c~notekey
     WHERE a~vdkey =  @l_source_vdkey
      AND b~cancelled <> 'X'    "not cancelled
      AND c~caseid = @pf_case
      AND c~institution = @pf_einri.

      IF sy-subrc <> 0 OR lt_note_types IS INITIAL.
        "something is wrong
        l_update_errors = 'X'.
        EXIT.
      ENDIF.

    ELSE.
      "read notes details for protocol
      SELECT a~*  INTO TABLE @lt_oldnotes_all FROM n2vdnote AS a
       JOIN n2vdnote_type AS b ON a~notekey = b~notekey
       WHERE  a~cancelled <> 'X' AND b~vdkey = @l_source_vdkey.

      IF sy-subrc <> 0 OR lt_oldnotes_all IS INITIAL.
        "something is wrong
        l_update_errors = 'X'.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  UPDATE_INTERNAL
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM update_internal .

"modify case, institution and movement of the notes
  LOOP AT lt_oldnotes ASSIGNING <fs_notes>.
    <fs_notes>-caseid = pt_case.
    <fs_notes>-institution = pt_einri.
    IF pt_movmt IS NOT INITIAL.
      <fs_notes>-movementid = pt_movmt.
    ELSE.
      <fs_notes>-movementid = '00001'.
    ENDIF.
  ENDLOOP.

"write into the note table the update user, date and time
  LOOP AT lt_notes ASSIGNING <fs_note_update>.
   <fs_note_update>-n8upusr    = sy-uname.
   <fs_note_update>-n8update   = sy-datum.
   <fs_note_update>-n8uptime   = sy-uzeit.
  ENDLOOP.

"if we move to a different patient, there are some additional things to modify
  IF l_simple_update <> 'X'.
    "see if we also need to delete the old document! - if there are no more notes assigned to it
    l_delete_old_key = 'X'.
    LOOP AT lt_oldnotes_all ASSIGNING <fs_oldnotes>.
      READ TABLE lt_oldnotes TRANSPORTING NO FIELDS WITH KEY notekey = <fs_oldnotes>-notekey.
      IF sy-subrc <> 0.  "if there is at least a note which was not selected to be changed, we don't delete the old key!
        CLEAR l_delete_old_key.
        EXIT.
      ENDIF.
    ENDLOOP.
    IF l_target_vdkey IS INITIAL. "if we need to create a new key ourselves
      ls_target_n2vd = ls_source_n2vd.
      CLEAR ls_target_n2vd-vdkey. "will be generated automatically later
      CLEAR ls_target_n2vd-descr. "will be added later
      ls_target_n2vd-patient_id = l_target_pat.
      ls_target_n2vd-n8crusr    = sy-uname.
      ls_target_n2vd-n8crdate   = sy-datum.
      ls_target_n2vd-n8crtime   = sy-uzeit.
    ENDIF.
    IF l_delete_old_key <> 'X'.
      APPEND LINES OF lt_note_types TO lt_new_types.
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  HEADER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM header .
"header line of the protocol

  WRITE: 'Number of updated notes: '(018) , l_notes , /.
  WRITE: 'Old patient: '(019) , l_source_pat , ' ' , l_source_pat_name , ' ' , l_source_pat_surname , ' ' ,
                                        'Old case: '(020) , pf_case , ' ' , 'Institution: '(021) , pf_einri , /.
  WRITE: 'New patient: '(022) , l_target_pat , ' ' , l_target_pat_name , ' ' , l_target_pat_surname , ' ' ,
                                        'New case: '(023) , pt_case , ' ' , 'Institution: '(021) , pt_einri , /.
  WRITE:/1(10)  'Note key'(024) COLOR 3 INTENSIFIED OFF.
  WRITE: 12(12) 'Description'(025) COLOR 3 INTENSIFIED OFF.
  WRITE: 26(10) 'Doc Unit'(026) COLOR 3 INTENSIFIED OFF.
  WRITE: 38(8)  'Date'(027) COLOR 3 INTENSIFIED OFF.
  WRITE:/ sy-uline.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM output .
"list the modified notes

  LOOP AT lt_oldnotes_all ASSIGNING <fs_oldnotes>.
    READ TABLE lt_oldnotes TRANSPORTING NO FIELDS WITH KEY notekey = <fs_oldnotes>-notekey.
    IF sy-subrc = 0.
      WRITE:/1 <fs_oldnotes>-notekey,
      12 <fs_oldnotes>-descr,
      26 <fs_oldnotes>-doc_unit,
      38 <fs_oldnotes>-n8crdate.
    ENDIF.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  UPDATE_DB
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM update_db .
"modify the DB
"updates will be done asynchronously and commited together at the end

  CLEAR l_update_errors.
*first update the case in the notes context
  CALL FUNCTION 'ISH_N2_VB_VD_NOTE_CONTEXT' IN UPDATE TASK
  EXPORTING
    i_mode  = 'U'
    it_data = lt_oldnotes.

  "update modified notes
  CALL FUNCTION 'ISH_N2_VB_VD_NOTES' IN UPDATE TASK
   EXPORTING
    i_mode       = 'U'
    it_note      = lt_notes.

  IF l_simple_update <> 'X'.

    IF l_target_vdkey IS INITIAL.  "need to create new key!
      "call the key generator
      CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ISH_N2VD'
*       QUANTITY                = '1'
      IMPORTING
        NUMBER                  = l_target_vdkey
*       QUANTITY                =
*        returncode              = rc
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.
      IF sy-subrc <> 0.
        l_update_errors = 'X'.
      ELSE.
        ls_target_n2vd-vdkey = l_target_vdkey.
        ls_target_n2vd-descr = 'Copy from'(028).
        CONCATENATE ls_target_n2vd-descr l_source_pat_name l_source_pat_surname INTO ls_target_n2vd-descr SEPARATED BY ','. "generate a description
        "try to create a new document for the target patient
        CALL FUNCTION 'ISH_N2_VB_VD_DOCUMENT' IN UPDATE TASK
        EXPORTING
          i_mode  = 'I'
          is_data = ls_target_n2vd.
      ENDIF.
    ENDIF.

    IF l_update_errors <> 'X'.
      IF l_delete_old_key = 'X'.
      "try to modify the patient key
      CALL FUNCTION 'ISH_N2_VB_VD_RELINK_NOTES' IN UPDATE TASK
      EXPORTING
        i_source_vdkey = l_source_vdkey
        i_target_vdkey = l_target_vdkey .
        "cancel the old document (if there are no more entries assigned to it)
        CALL FUNCTION 'ISH_N2_VB_VD_DOCUMENT_DELETE' IN UPDATE TASK
        EXPORTING
          i_vdkey = l_source_vdkey.
        ELSE.
         LOOP AT lt_new_types ASSIGNING <fs_note_type>.
           <fs_note_type>-vdkey = l_target_vdkey.
         ENDLOOP.
         "need to delete type manually as vdkey is part of the table key and cannot be updated!
         DELETE n2vdnote_type FROM TABLE @lt_note_types.
          IF sy-subrc <> 0.
            l_update_errors = 'X'.
            ELSE.
            "now insert the new type manually - there is no separate update function just for types
              INSERT n2vdnote_type FROM TABLE @lt_new_types.
              IF sy-subrc <> 0.
                l_update_errors = 'X'.
              ENDIF.
          ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

  IF l_update_errors <> 'X'.
    COMMIT WORK AND WAIT.
    IF sy-subrc <> 0.
      ROLLBACK WORK.
      l_update_errors = 'X'.
    ENDIF.
    ELSE.
      ROLLBACK WORK.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CLEAR_ALL
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM clear_all .
"clear all internal variables

CLEAR:  lt_oldnotes[] , lt_oldnotes_all[] , l_source_pat , l_target_pat , l_source_pat_name , l_source_pat_surname , l_target_pat_name , l_target_pat_surname ,
       l_source_storn , l_target_storn , l_source_vdkey , l_target_vdkey , l_notes , l_simple_update , l_update_errors , l_delete_old_key , ls_source_n2vd ,
       ls_target_n2vd , lt_notes[] , lt_note_types[] , lt_new_types[] .

ENDFORM.
