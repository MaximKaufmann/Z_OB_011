*&---------------------------------------------------------------------*
*& Report z_ob_000_badcode01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ob_011_badcode05.

DATA: lv_result     TYPE int8,
      lv_power      TYPE i VALUE 1.



    DO 10 TIMES.

      lv_result = sy-index * lv_power.
      WRITE: / sy-index, '*', lv_power, '=', lv_result.
    ENDDO.
