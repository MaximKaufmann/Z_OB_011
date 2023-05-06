*&---------------------------------------------------------------------*
*& Report z_ob_re_011_badi
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ob_re_011_badi.

PARAMETERS: ctry(2) TYPE c.
DATA: handle  TYPE REF TO z_badi_calc_vat_011,
      sum     TYPE p,
      vat     TYPE p,
      percent TYPE p.

sum = 50.

GET BADI handle FILTERS Country = ctry.

CALL BADI handle->get_vat
  EXPORTING
    iv_amount      = sum
  IMPORTING
    ev_amount_vat  = vat
    ev_percent_vat = percent.

WRITE: 'Prozent:', percent, 'Umsatzsteuer:', vat.


DATA: lt_csv_data   TYPE  truxs_t_text_data.

CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    filename                = '<C:\Users\MaximKaufmann\Downloads>'
  TABLES
    data_tab                = lt_csv_data.

 cl_demo_output=>display( lt_csv_data ).
