@EndUserText.label: 'Travel Processor - Projection Layer'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZATS_RA_TRAVEL_PROCESSOR
  as projection on ZATS_RA_TRAVEL
{
      @ObjectModel.text.element: [ 'Description' ]
  key TravelId,
      @ObjectModel.text.element: [ 'AgencyName' ]
      @Consumption.valueHelpDefinition: [{ entity.name: '/dmo/i_agency' , entity.element: 'AgencyID' }]
      AgencyId,
      @Semantics.text: true
      _Agency.Name       as AgencyName,
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Consumption.valueHelpDefinition: [{ entity.name: '/DMO/I_Customer' , entity.element: 'CustomerID' }]
      CustomerId,
      @Semantics.text: true
      _Customer.LastName as CustomerName,
      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,
      CurrencyCode,
      @Semantics.text: true
      Description,
      @ObjectModel.text.element: [ 'StatusText' ]
      @Consumption.valueHelpDefinition: [{ entity.name: '/DMO/I_Overall_Status_VH' , entity.element: 'OverallStatus' }]
      OverallStatus,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      @Semantics.text: true
      StatusText,
      Criticality,
      /* Associations */
      _Agency,
      _Booking,
      _Currency,
      _Customer,
      _OverallStatus
}
