*&---------------------------------------------------------------------*
*& Report z_ob_re_011
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ob_re_011.
*
*DATA: lt_itab      TYPE TABLE OF vbap,
*      ls_tableline LIKE LINE OF lt_itab,
*      lv_posnr     TYPE posnr,
*      lv_vbeln     TYPE vbeln,
*      lv_index     TYPE c LENGTH 3,
*      lv_seconds   TYPE p DECIMALS 10.
*
*******************Befüllung der internen Tabelle******************
*lv_index = '0'.
*******************************************************************
*CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
*  EXPORTING
*    input  = '10'
*  IMPORTING
*    output = lv_posnr.
*******************************************************************
*DO 100 TIMES.
*  lv_index = lv_index + 1.
*******************************************************************
*  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
*    EXPORTING
*      input  = lv_index
*    IMPORTING
*      output = lv_vbeln.
*******************************************************************
*  ls_tableline-vbeln = lv_vbeln.
*  ls_tableline-posnr = lv_posnr.
*  APPEND ls_tableline TO lt_itab.
*ENDDO.
*******************************************************************
*
**********MESSUNG 1 SQL******************************************************************
*CLEAR: lv_seconds.
*GET RUN TIME FIELD DATA(lv_dauer1). "Messung wird gestartet
*SELECT mandt vbeln posnr FROM vbap INTO TABLE lt_itab
*FOR ALL ENTRIES IN lt_itab
*WHERE vbeln = lt_itab-vbeln AND posnr = lt_itab-posnr.
*GET RUN TIME FIELD DATA(lv_dauer2). "messung wird gestoppt
*lv_seconds = ( lv_dauer2 - lv_dauer1 ) / 1000000. "Laufzeit Messstrecke in Sekunden
*WRITE lv_seconds.
*WRITE /.
*
***********MESSUNG 2 SQL******************************************************************
*CLEAR: lv_seconds.
*GET RUN TIME FIELD DATA(lv_dauer3). "Messung wird gestartet
*LOOP AT lt_itab INTO ls_tableline.
*SELECT SINGLE mandt vbeln posnr FROM vbap INTO ls_tableline
*WHERE vbeln = ls_tableline-vbeln AND posnr = ls_tableline-posnr.
*MODIFY lt_itab FROM ls_tableline.
*ENDLOOP.
*GET RUN TIME FIELD DATA(lv_dauer4). "messung wird gestoppt
*lv_seconds = ( lv_dauer4 - lv_dauer3 ) / 1000000. "Laufzeit Messstrecke in Sekunden
*WRITE lv_seconds.

******MESSUNG 1 interne Tabelle******************************************************************
*CLEAR: lv_seconds.
*GET RUN TIME FIELD DATA(lv_dauer1). "Messung wird gestartet
*LOOP AT lt_itab REFERENCE INTO DATA(lo_tableline).
*ENDLOOP.
*GET RUN TIME FIELD DATA(lv_dauer2). "messung wird gestoppt
*lv_seconds = ( lv_dauer2 - lv_dauer1 ) / 1000000. "Laufzeit Messstrecke in Sekunden
*WRITE lv_seconds.
*WRITE /.

******MESSUNG 2 interne Tabelle******************************************************************
*CLEAR: lv_seconds, ls_tableline.
*GET RUN TIME FIELD DATA(lv_dauer3). "Messung wird gestartet
*LOOP AT lt_itab INTO ls_tableline.
*ENDLOOP.
*GET RUN TIME FIELD DATA(lv_dauer4). "messung wird gestoppt
*lv_seconds = ( lv_dauer4 - lv_dauer3 ) / 1000000. "Laufzeit Messstrecke in Sekunden
*WRITE lv_seconds.
*WRITE /.

DATA: lv_carrid TYPE s_carr_id VALUE 'LH',
      lv_connid TYPE s_conn_id VALUE '2402'.


DATA: lt_locktable TYPE TABLE OF zob_t_lock_011.

"SELECT * FROM spfli INTO CORRESPONDING FIELDS OF TABLE lt_locktable.

"MODIFY zob_t_lock_011 FROM TABLE lt_locktable.


CALL FUNCTION 'ENQUEUE_EZOB_T_LOCK_011'
  EXPORTING
    mode_ZOB_T_LOCK_011      = 'E'
    client                   = sy-mandt
    carrid                   = lv_carrid
    connid                   = lv_connid
  EXCEPTIONS
    foreign_lock             = 1
    system_failure           = 2
    OTHERS                   = 3.

IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
  WITH sy-msgv1
  sy-msgv2
  sy-msgv3
  sy-msgv4.
ENDIF.

SELECT SINGLE * FROM ZOB_T_LOCK_011
 WHERE carrid = @lv_carrid
   AND connid = @lv_connid
INTO @DATA(ls_tableline).
MODIFY ZOB_T_LOCK_011 FROM ls_tableline.

CALL FUNCTION 'DEQUEUE_EZOB_T_LOCK_011'
  EXPORTING
    mode_ZOB_T_LOCK_011  = 'E'
    client               = sy-mandt
    carrid               = lv_carrid
    connid               = lv_connid.
