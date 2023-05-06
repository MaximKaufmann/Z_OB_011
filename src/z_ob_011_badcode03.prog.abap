*&---------------------------------------------------------------------*
*& Report z_ob_011_badcode01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ob_011_badcode03.

DATA: lv_name TYPE string VALUE 'John',
      lv_age TYPE i VALUE 30,
      lt_data TYPE TABLE OF sairport.

IF lv_age >= 18.
  SELECT * FROM sairport INTO TABLE lt_data.
ENDIF.

IF lt_data IS NOT INITIAL.
  WRITE: / 'Id', 'Name'.
  LOOP AT lt_data INTO DATA(ls_data).
    WRITE: / ls_data-id, ls_data-name.
  ENDLOOP.
ENDIF.
