class ZCL_Z_OB_011_DPC_EXT definition
  public
  inheriting from ZCL_Z_OB_011_DPC
  create public .

public section.
protected section.

  methods BOOKINGSSET_GET_ENTITYSET
    redefinition .
  methods BOOKINGSSET_GET_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_Z_OB_011_DPC_EXT IMPLEMENTATION.


  method BOOKINGSSET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->BOOKINGSSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

        DATA(lv_id) = it_key_tab[ name = 'Bookid' ]-value.

    SELECT SINGLE
        FROM sbook
        FIELDS
            *
        WHERE bookid = @lv_id
        INTO CORRESPONDING FIELDS OF @er_entity.
  endmethod.


  method BOOKINGSSET_GET_ENTITYSET.
*TRY.
*CALL METHOD SUPER->BOOKINGSSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
*    io_tech_request_context  =
*  IMPORTING
*    et_entityset             =
*    es_response_context      =
*    .
*  CATCH /iwbep/cx_mgw_busi_exception.
*  CATCH /iwbep/cx_mgw_tech_exception.
*ENDTRY.
        SELECT
        FROM sbook
        FIELDS
            *
        INTO CORRESPONDING FIELDS OF TABLE @et_entityset.
  endmethod.
ENDCLASS.
