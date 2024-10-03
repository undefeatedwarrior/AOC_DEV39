@EndUserText.label: 'Booking Suppliment Processor - Projection Layer'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZATS_RA_BOOKSUPPL_PROCESSOR
  as projection on ZATS_RA_BOOKSUPPL
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      SupplementId,
      Price,
      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _Booking: redirected to parent ZATS_RA_BOOKING_PROCESSOR,
      _Product,
      _SupplementText,
      _Travel: redirected to ZATS_RA_TRAVEL_PROCESSOR
}
