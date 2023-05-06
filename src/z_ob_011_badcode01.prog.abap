*&---------------------------------------------------------------------*
*& Report z_ob_011_badcode01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ob_011_badcode01.

DATA: lv_indicator TYPE abap_bool VALUE abap_true, lv_story TYPE string.

IF lv_indicator = abap_true.
  PERFORM write_text CHANGING lv_story.
    cl_demo_output=>display_text( lv_story ).
ENDIF.

FORM write_text CHANGING lv_story TYPE string.
  DATA: lt_beginning TYPE stringtab.

  PERFORM add_text CHANGING lt_beginning.
  LOOP AT lt_beginning INTO DATA(lv_beginning).
    IF lv_story IS INITIAL.
      lv_story = lv_beginning.
    ELSE.
      lv_story = |{ lv_story } { lv_beginning }|.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM add_text CHANGING beginning TYPE stringtab.
  APPEND 'In einer Höhle in der Erde, da lebte ein Hobbit.,''Nicht in einem schmutzigen, nassen Loch, in das die Enden von irgendwelchen Würmern herabbaumelten und das nach Schlamm und Moder roch. ' TO beginning.
  APPEND 'Auch nicht etwa in einer trockenen Kieshöhle, die so kahl war, dass man sich nicht einmal niedersetzen oder gemütlich frühstücken konnte. ' TO beginning.
  APPEND 'Es war eine Hobbithöhle, und das bedeutet Behaglichkeit. ' TO beginning.
ENDFORM.
