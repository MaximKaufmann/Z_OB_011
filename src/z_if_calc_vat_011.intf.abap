interface Z_IF_CALC_VAT_011
  public .

METHODS get_vat
   IMPORTING
     !iv_amount      TYPE p
   EXPORTING
     !ev_amount_vat  TYPE p
     !ev_percent_vat TYPE p.

  interfaces IF_BADI_INTERFACE .
endinterface.
