*&---------------------------------------------------------------------*
*& Report z_ob_011_report
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ob_011_report.

DATA: lv_host      TYPE string VALUE 'openlibrary.org',
      lv_service   TYPE string VALUE '443',
      li_client    TYPE REF TO if_http_client,
      lv_errortext TYPE string,
      lv_data      TYPE string,
      lt_fields    TYPE tihttpnvp,
      ls_field     LIKE LINE OF lt_fields,
      lt_data      TYPE stringtab,
      ls_data      LIKE LINE OF lt_data.

CALL METHOD cl_http_client=>create
  EXPORTING
    host               = lv_host
    service            = lv_service
    scheme             = cl_http_client=>schemetype_https
  IMPORTING
    client             = li_client
  EXCEPTIONS
    argument_not_found = 1
    internal_error     = 2
    plugin_not_active  = 3
    OTHERS             = 4.

IF sy-subrc <> 0.
  WRITE: / 'Die Anlage des Clients schlug fehlt'.
  EXIT.
ENDIF.

CALL METHOD li_client->request->set_method(
  if_http_request=>co_request_method_get ).

li_client->request->set_version(
  if_http_request=>co_protocol_version_1_1 ).

cl_http_utility=>set_request_uri(
  request = li_client->request
  uri = '/api/books?bibkeys=ISBN9684760892&jscmd=data&format=json' ).

CALL METHOD li_client->send
  EXCEPTIONS
    http_communication_failure = 1
    http_invalid_state         = 2
    http_processing_failed     = 3
    OTHERS                     = 4.

IF sy-subrc <> 0.
  CALL METHOD li_client->get_last_error
    IMPORTING
      message = lv_errortext.
  WRITE: / 'Kommunikationsfehler beim send.', 'Fehlernachricht: ',  lv_errortext.
  EXIT.
ENDIF.

CALL METHOD li_client->receive
  EXCEPTIONS
    http_communication_failure = 1
    http_invalid_state         = 2
    http_processing_failed     = 3
    OTHERS                     = 4.

IF sy-subrc <> 0.
  CALL METHOD li_client->get_last_error
    IMPORTING
      message = lv_errortext.
  WRITE: / 'Kommunikationsfehler beim send.', 'Fehlernachricht: ',  lv_errortext.
  EXIT.
ENDIF.

CALL METHOD li_client->response->get_header_fields
  CHANGING
    fields = lt_fields.

WRITE: / 'Nachrichtenkopf:'.

LOOP AT lt_fields INTO ls_field.
  WRITE: / 'header_name', ls_field-name,
  'header_value', ls_field-value.
ENDLOOP.

lv_data = li_client->response->get_cdata( ).

WRITE: / , /'Nachrichtenkörper:'.

SPLIT lv_data AT '{' INTO TABLE lt_data.
LOOP AT lt_data INTO ls_data.
  WRITE: / ls_data.
ENDLOOP.

CALL METHOD li_client->close
  EXCEPTIONS
    http_invalid_state = 1
    OTHERS             = 2.

IF sy-subrc <> 0.
  CALL METHOD li_client->get_last_error
    IMPORTING
      message = lv_errortext.
  WRITE: / 'Kommunikationsfehler beim close:', lv_errortext.
  EXIT. "Beende die Verarbeitung
ENDIF.
