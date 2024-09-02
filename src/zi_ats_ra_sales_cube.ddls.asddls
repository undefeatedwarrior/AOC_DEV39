@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Composite Cube View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Analytics.dataCategory: #CUBE

define view entity ZI_ATS_RA_SALES_CUBE
  as select from ZI_ATS_RA_SALES
  association [1] to ZI_ATS_RA_BPA     as _BusinessPartner on $projection.Buyer = _BusinessPartner.BpId
  association [1] to ZI_ATS_AB_PRODUCT as _Product         on $projection.Producut = _Product.ProductId
{
  key ZI_ATS_RA_SALES.OrderId,
  key ZI_ATS_RA_SALES._Items.item_id  as ItemId,
      ZI_ATS_RA_SALES.OrderNo,
      ZI_ATS_RA_SALES.Buyer,
      ZI_ATS_RA_SALES.CreatedBy,
      ZI_ATS_RA_SALES.CreatedOn, 
      /* Associations */
      ZI_ATS_RA_SALES._Items.product  as Producut,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @DefaultAggregation: #SUM
      ZI_ATS_RA_SALES._Items.amount   as GrossAmount,
      ZI_ATS_RA_SALES._Items.currency as CurrencyCode,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      @DefaultAggregation: #SUM
      ZI_ATS_RA_SALES._Items.qty      as Quantity,
      ZI_ATS_RA_SALES._Items.uom      as UnitOfMeasure,
      _Product,
      _BusinessPartner


}
