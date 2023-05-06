CLASS z_ob_cl_calc_vat_gb_011 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES z_if_calc_vat_011 .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_ob_cl_calc_vat_gb_011 IMPLEMENTATION.
  METHOD z_if_calc_vat_011~get_vat.

    DATA: percent TYPE p VALUE 16.

    ev_amount_vat = iv_amount * percent / 100.
    ev_percent_vat = percent.
  ENDMETHOD.

ENDCLASS.
