@EndUserText.label: 'Booking Processor - Projection Layer'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZATS_RA_BOOKING_PROCESSOR
  as projection on ZATS_RA_BOOKING
{
  key TravelId,
  key BookingId,
      BookingDate,
      CustomerId,
      CarrierId,
      ConnectionId,
      FlightDate,
      FlightPrice,
      CurrencyCode,
      BookingStatus,
      LastChangedAt,
      /* Associations */
      _BookingStatus,
      _BookingSupplement,
      _Carrier,
      _Connection,
      _Customer,
      _Travel : redirected to parent ZATS_RA_TRAVEL_PROCESSOR
}
