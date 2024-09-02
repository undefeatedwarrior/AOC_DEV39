@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product master data CDS entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_ATS_RA_PRODUCT
  as select from zats_ra_product
{
  key product_id as ProductId,
      name       as Name,
      category   as Category,
      @Semantics.amount.currencyCode: 'Currency'
      price      as Price,
      currency   as Currency,
      discount   as Discount
}
