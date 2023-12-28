*&---------------------------------------------------------------------*
*& Report Z_TEST_ABAP_USAGE_CDS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_test_abap_usage_cds.

DATA: lt_sales TYPE STANDARD TABLE OF ztest_shpsls,   "using SQL view 1 ITAB
      ls_sales TYPE ztest_shpsls,                     "WA for the same ztest_shpsls
      lt_mdl   TYPE STANDARD TABLE OF z_testslsmdl,   "using SQL view 2 ITAB
      ls_mdl   TYPE z_testslsmdl.                     "WA for the same z_testslmdl

*--- Selection screen Inputs
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
PARAMETERS: p_matnr TYPE matnr,                      "Material Number
            p_vbeln TYPE vbeln.                      "Sales Doc
SELECTION-SCREEN END OF BLOCK b1.


*---Extraction Begins
START-OF-SELECTION.
PERFORM call_slsmdl_cds.
IF sy-subrc = 0.
  PERFORM call_vbfa_cds.
ENDIF.
"Display ALV
PERFORM call_reports_one_by_one.


*&---------------------------------------------------------------------*
*& Form call_slsmdl_cds
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM call_vbfa_cds.
SELECT * FROM z_test_cds_ship_sales( p_matnr = @p_matnr , p_vbeln = @p_vbeln ) INTO CORRESPONDING FIELDS OF TABLE @lt_sales.
  IF sy-subrc <> 0.
    MESSAGE: 'error occurred' TYPE 'E' DISPLAY LIKE 'I'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form call_slsmdl_cds
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM call_slsmdl_cds .
  SELECT * FROM z_testslsmdl INTO CORRESPONDING FIELDS OF TABLE @lt_mdl.
    IF sy-subrc <> 0.
      MESSAGE: 'error occurred' TYPE 'E' DISPLAY LIKE 'I'.
    ENDIF.
ENDFORM.

FORM call_reports_one_by_one.
  cl_demo_output=>display_data( lt_mdl ).
  cl_demo_output=>display_data( lt_sales ).
ENDFORM.
