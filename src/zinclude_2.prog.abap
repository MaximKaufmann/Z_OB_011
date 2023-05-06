*&---------------------------------------------------------------------*
*& Include zinclude_2
*&---------------------------------------------------------------------*

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
