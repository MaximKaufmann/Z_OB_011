*&---------------------------------------------------------------------*
*& Report Z_OB_RE_SELECTION_SCREEN_011
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ob_re_selection_screen_011.

"WRITE 'Hello World'.

PARAMETERS p_city TYPE S_from_cit OBLIGATORY.
PARAMETERS p_name TYPE S_from_cit OBLIGATORY.

SELECT *
FROM spfli
INTO TABLE @DATA(lt_flights)
WHERE cityfrom = @p_city.

LOOP AT lt_flights INTO DATA(ls_flight).
  WRITE:/ ls_flight-connid, ls_flight-cityfrom, ls_flight-countryfr, ls_flight-cityto, ls_flight-countryto.
ENDLOOP.

IF lt_flights[] IS INITIAL.
DATA(lv_message) = |Es fliegen keine Flüge vom Flughafen { p_city }.|.
MESSAGE lv_message TYPE 'I'.
ENDIF.

TABLES spfli.
SELECT-OPTIONS s_time FOR spfli-deptime.

SELECT
FROM spfli
FIELDS
 *
WHERE cityfrom = @p_city
  AND deptime IN @s_time
INTO TABLE @lt_flights.
