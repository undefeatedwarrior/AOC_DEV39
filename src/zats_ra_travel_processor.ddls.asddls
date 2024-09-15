@EndUserText.label: 'Travel Processor - Projection Layer'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZATS_RA_TRAVEL_PROCESSOR
  as projection on ZATS_RA_TRAVEL
{
  key TravelId,
      AgencyId,
      CustomerId,
      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,
      CurrencyCode,
      Description,
      OverallStatus,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _Agency,
      _Booking,
      _Currency,
      _Customer,
      _OverallStatus
}
