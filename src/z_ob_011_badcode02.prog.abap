*&---------------------------------------------------------------------*
*& Report z_ob_011_badcode01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ob_011_badcode02.

DATA: lv_number TYPE i VALUE 20.


CASE lv_number.

WHEN 0.
WRITE 'Die Zahl ist zero.'.
WHEN 1.
WRITE 'Die Zahl ist one.'.
WHEN 2.
WRITE 'Die Zahl ist two.'.
WHEN 3.
WRITE 'Die Zahl ist three.'.
WHEN 4.
WRITE 'Die Zahl ist four.'.
WHEN 5.
WRITE 'Die Zahl ist five.'.
WHEN 6.
WRITE 'Die Zahl ist six.'.
WHEN 7.
WRITE 'Die Zahl ist seven.'.
WHEN 8.
WRITE 'Die Zahl ist eight.'.
WHEN 9.
WRITE 'Die Zahl ist nine.'.
WHEN OTHERS.
WRITE 'Die Zahl ist größer als nine.'.
ENDCASE.
