@AbapCatalog.sqlViewName: 'ZTEST_SHPSLS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'test ship sales'
@VDM.viewType: #CONSUMPTION

define view z_test_cds_ship_sales with parameters p_matnr:matnr , p_vbeln:vbeln as select from Z_TEST_CDS_SALES_MODEL as test_sls
association [1..1] to vbfa as _sales on test_sls.sales_doc = _sales.vbelv and test_sls.material = _sales.matnr
{
    @Consumption.filter.mandatory: false
    key test_sls.material,
    key test_sls.sales_doc,
    test_sls.mat_type,
    test_sls.sales_item,
    test_sls.plant,
    test_sls.net_qty,
    test_sls.target_qty,
    test_sls.uom,
    _sales.ruuid as Ruuid,
    _sales.posnv as Posnv,
    _sales.vbeln as Vbeln,
    _sales.vbelv as Vbelv,
    _sales.posnn as Posnn,
    _sales.vbtyp_n as VbtypN,
@DefaultAggregation: #SUM
    _sales.rfmng as Rfmng,
    _sales.meins as Meins,
    _sales.rfwrt as Rfwrt,
    _sales.waers as Waers,
    _sales.vbtyp_v as VbtypV,
    _sales // Make association public
}   where _sales.vbelv is not initial
    and   _sales.vbelv=:p_vbeln
    or   test_sls.material=:p_matnr 
