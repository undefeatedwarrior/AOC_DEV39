@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Analytics Consumption View'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Analytics.query: true

define view entity ZC_ATS_RA_SALES_ANA as select from ZI_ATS_RA_SALES_CUBE
{
    key _BusinessPartner.CompanyName,
    key _BusinessPartner.Country,
    
    @Aggregation.default: #SUM
    @Semantics.amount.currencyCode: 'CurrencyCode'   
    @AnalyticsDetails.query.axis: #COLUMNS
    GrossAmount,
    
    @AnalyticsDetails.query.axis: #ROWS
    @Consumption.filter.selectionType: #SINGLE
    CurrencyCode,
    
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    @AnalyticsDetails.query.axis: #COLUMNS
    Quantity,
    
    @AnalyticsDetails.query.axis: #ROWS
    UnitOfMeasure
}
