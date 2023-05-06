*&---------------------------------------------------------------------*
*& Report z_ob_000_badcode01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*REPORT z_ob_011_exercise01.
** Beispiele in z_ob_alv_000 & https://techazmaan.com/sap-alv-report-list/
*
**** Aufgabe
** Zeige 80 Verkaufsbelege (VBAP) in einem ALV-Grid an
*
*TABLES: VBAP.
*
*SELECT * FROM VBAP INTO TABLE @DATA(lt_belege) UP TO 80 ROWS.
*
*DATA: lo_alv TYPE REF TO if_salv_gui_table_ida.
*DATA: lo_cc TYPE REF TO cl_gui_custom_container.
*
*LOAD-OF-PROGRAM.
*  lo_cc = NEW cl_gui_custom_container( container_name = 'CCONTAINER_SALV').
*  lo_alv = cl_salv_gui_table_ida=>create(
*    iv_table_name = 'lt_belege'
*    io_gui_container = lo_cc
*  ).
**&---------------------------------------------------------------------*
**&      Module  USER_COMMAND_0100  INPUT
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
*MODULE user_command_0100 INPUT.
*
*ENDMODULE.

REPORT z_ob_011_exercise01.

*TYPES: BEGIN OF ty_vbap,
*         vbeln  TYPE vbap-vbeln,
*         posnr  TYPE vbap-posnr,
*         matnr  TYPE vbap-matnr,
*         matwa TYPE vbap-matwa,
*         matkl  TYPE vbap-matkl,
*         arktx TYPE vbap-arktx,
*         pstyv TYPE vbap-pstyv,
*       END OF ty_vbap.
*
*DATA: lt_vbap TYPE STANDARD TABLE OF ty_vbap,
*      ls_vbap TYPE ty_vbap.
*
*SELECT vbeln posnr matnr matwa matkl arktx pstyv
*  FROM vbap
*  INTO TABLE lt_vbap
*  UP TO 80 ROWS.
*
*CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
*  EXPORTING
*    i_callback_program = sy-repid
*    is_layout          = VALUE alv_layout( grid_title = 'Verkaufsbelege (VBAP)' )
*
*  TABLES
*    t_outtab           = lt_vbap.

DATA: gt_vbap TYPE TABLE OF vbap,
      gs_vbap TYPE vbap.

SELECT * FROM vbap INTO TABLE gt_vbap UP TO 80 ROWS.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_structure_name = 'VBAP'
  TABLES
    t_outtab        = gt_vbap.
