@AbapCatalog.sqlViewName: 'Z_TESTSLSMDL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'TEST_PROD_ENTITY'
@VDM.viewType: #BASIC

define view Z_TEST_CDS_SALES_MODEL
as select from mara as m_tab inner join vbap as v_tab on m_tab.matnr = v_tab.matnr {
    key v_tab.vbeln as sales_doc,
    key m_tab.matnr as material, 
        m_tab.mtart as mat_type,
        v_tab.posnr as sales_item, 
        v_tab.waerk as plant, 
        v_tab.netwr as net_qty,
        v_tab.zmeng as target_qty,
        v_tab.zieme as uom
    } 
    
