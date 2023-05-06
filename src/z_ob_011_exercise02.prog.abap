*&---------------------------------------------------------------------*
*& Report z_ob_000_badcode01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ob_011_exercise02.
"Geben Sie die Adresse des Kunden 132986 aus
" Tabelle KNA1
*
*DATA: lv_name1 TYPE kna1-name1,
*      lv_ort01 TYPE kna1-ort01,
*      lv_pstlz TYPE kna1-pstlz,
*      lv_regio TYPE kna1-regio,
*      lv_stras TYPE kna1-stras,
*      lv_land1 TYPE kna1-land1.
*
*SELECT SINGLE name1, ort01, pstlz, regio, stras, land1
*  INTO (@lv_name1, @lv_ort01, @lv_pstlz, @lv_regio, @lv_stras, @lv_land1)
*  FROM kna1
*  WHERE kunnr = '0000132986'.
*
*
*IF sy-subrc EQ 0.
*  WRITE: / 'Kundenadresse für Kunde 0000132986:',
*           / lv_name1,
*           / lv_ort01,
*           / lv_pstlz,
*           / lv_regio,
*           / lv_stras,
*           / lv_land1.
*ELSE.
*  WRITE: / 'Kunde 0000132986 nicht gefunden.'.
*ENDIF.

"Finden Sie alle Belegnummern von Warenausgabe vom 08/01/2021 über den Betrag 120,000.00 (Deutscher Buchungskreis) heraus
" Ggf. Datum und Betrag anpassen
" Tabellen: BKPF, BSEG

*DATA: lt_bseg TYPE STANDARD TABLE OF bseg,
*      lv_belnr TYPE bkpf-belnr,
*      lv_gjahr TYPE bkpf-gjahr VALUE '2021',
*      lv_bukrs TYPE bkpf-bukrs VALUE '1000',
*      lv_hkont TYPE bseg-hkont VALUE '1234567890',
*      lv_wrbtr TYPE bseg-wrbtr VALUE '120,000.00'.
*
*SELECT-OPTIONS: so_date FOR bkpf-buday.
*
*SELECT bkpf~belnr
*  FROM bkpf
*  JOIN bseg ON bkpf~belnr = bseg~belnr
*  INTO TABLE @DATA(lt_bseg)
*  WHERE bkpf~bukrs = '1000'
*    AND bkpf~gjahr = '2021'
*    AND bkpf~blart = 'WA'
*    AND bseg~hkont = '1234567890'
*    AND bseg~wrbtr >= '120,000.00'
*    AND bkpf~budat = '20210108'.
*
*IF lt_bseg IS NOT INITIAL.
*  WRITE: 'Belegnummern von Warenausgaben vom 08/01/2021 über den Betrag von 120.000,00:'.
*  LOOP AT lt_bseg INTO DATA(ls_bseg).
*    lv_belnr = ls_bseg-belnr.
*    WRITE: / lv_belnr.
*  ENDLOOP.
*ELSE.
*  WRITE: 'Keine passenden Belege gefunden.'.
*ENDIF.
*
*cl_demo_output=>display( result ).




"Finden Sie heraus aus welchen Teilen das 'Deluxe Touring Bike (black)' aus Dallas besteht
" tabellen: MARA / MAKT, MAST, STPO

*Geben Sie nur eine Buchung des Kunden Christa Heller aus.
*Tabelle: SBOOK
*

DATA: lt_sbook TYPE TABLE OF sbook.
     " ls_sbook TYPE sbook.

SELECT * FROM sbook INTO TABLE lt_sbook
     WHERE passname = 'CHRISTAHELLER'.

LOOP AT lt_sbook INTO DATA(ls_sbook).
  "WHERE passname = 'CHRISTAHELLER'.

  WRITE:  / 'Buchungsnummer:', ls_sbook-bookid,
          / 'Kundennummer:', ls_sbook-passname,
          / 'Reisedatum:', ls_sbook-fldate,
          / 'Flugnummer:', ls_sbook-connid.

ENDLOOP.



*Wählen Sie alle Linienflüge der Fluggesellschaft „Lufthansa“ aus.
*Tabelle: SPFLI, SCARR
*

*Sie wollen die durchschnittlichen Sitzplätze der Economy, Business und First Class wissen.
*Gruppieren Sie die Ergebnisse nach carrid und connid.
*Tabelle: SFLIGHT
*

*Sortieren Sie alle Flughäfen nach ihrer Zeitzone.
*Tabelle: SBOOK
*

*Wählen Sie die Spalten für Airline-Code, Flugverbindungsnummer, Flugdatum, Kundenname und Sprache aus. Geben Sie maximal 20 Einträge aus.
*Tabellen: SBOOK und SCUSTOM
*

*Legen Sie sich eine Datenbanktabelle ZOB_T_EXAMPLE_###.
*

*Fügen Sie drei Einträge in die ZOB_T_EXAMPLE_### Tabelle ein.
*

*Ändern Sie einen zuvor angelegten Eintrag in der ZOB_T_EXAMPLE_### Tabelle.

*Löschen Sie einen zuvor angelegten Eintrag in der ZOB_T_EXAMPLE_### Tabelle.
