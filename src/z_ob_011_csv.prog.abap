*&---------------------------------------------------------------------*
*& Report z_ob_011_csv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ob_011_csv.
*
*DATA: lt_csv_data   TYPE  truxs_t_text_data.
*
*CALL FUNCTION 'GUI_UPLOAD'
*  EXPORTING
*    filename = 'C:\Users\MaximKaufmann\Downloads\Datenquellen_organizations.csv'
*  TABLES
*    data_tab = lt_csv_data.
*
*cl_demo_output=>display( lt_csv_data ).
*
*DATA: BEGIN OF ls_organization,
*        index               TYPE i,
*        organization_Id     TYPE string,
*        name                TYPE string,
*        website             TYPE string,
*        country             TYPE string,
*        description         TYPE string,
*        founded             TYPE gjahr,
*        industry            TYPE string,
*        number_of_employees TYPE i,
*      END OF ls_organization,
*      lt_organizations LIKE TABLE OF ls_organization.
*
*
*DELETE lt_csv_data INDEX 1.
*
*CALL FUNCTION 'TEXT_CONVERT_CSV_TO_SAP'
*  EXPORTING
*    i_tab_raw_data       = lt_csv_data
*  TABLES
*    i_tab_converted_data = lt_organizations.
*
*cl_demo_output=>display( lt_organizations ).
*
*LOOP AT lt_organizations ASSIGNING FIELD-SYMBOL(<line>) WHERE founded >= 2000.
*  DELETE lt_organizations.
*ENDLOOP.
*
*cl_demo_output=>display( lt_organizations ).
*
*CALL FUNCTION 'SAP_CONVERT_TO_CSV_FORMAT'
*  EXPORTING
*    i_field_seperator    = ';'
*  TABLES
*    i_tab_sap_data       = lt_organizations
*  CHANGING
*    i_tab_converted_data = lt_csv_data
*  EXCEPTIONS
*    conversion_failed    = 1
*    OTHERS               = 2.
*
*CALL FUNCTION 'GUI_DOWNLOAD'
*  EXPORTING
*    filename = 'C:\Users\MaximKaufmann\Downloads\Maxim.csv'
*  TABLES
*    data_tab = lt_csv_data.

"""""""""""""""""""""""""""""""""""""""""""JSON""""""""""""""""""""""""""""""""""""""""""""""""
DATA(lv_jsondata) = '{ "key": "1", "value": "One" }'.

TYPES: BEGIN OF ls_json,
         key   TYPE string,
         value TYPE string,
       END OF ls_json.

DATA: ls_jsondata TYPE ls_json.

/ui2/cl_json=>deserialize(
EXPORTING json = CONV #( lv_jsondata )
CHANGING data = ls_jsondata
).

"cl_demo_output=>display( ls_jsondata ).

DATA(ls_jsondata2) = '{ "animals" :[{ "type": "cat", "name": "Tishka", "age": 5,  "loves": "sausage", "breed": "red cat" }, { "type": "dog", "name": "Tuzik", "age":  5, "breed": "Ovcharka", "hobby": "throw a ball" } ]}'.


TYPES:
  BEGIN OF ts_animal_characteristics,
    type  TYPE string,
    name  TYPE string,
    age   TYPE string,
    loves TYPE string,
    breed TYPE string,
  END OF ts_animal_characteristics,
  tt_animals TYPE STANDARD TABLE OF ts_animal_characteristics WITH EMPTY KEY.

DATA: BEGIN OF ls_animals,
        animals TYPE tt_animals,
      END OF ls_animals.

/ui2/cl_json=>deserialize(
 EXPORTING json = CONV #( ls_jsondata2 )
 CHANGING data = ls_animals
).

cl_demo_output=>display( ls_animals-animals ).
