@EndUserText.label: 'Booking Processor - Projection Layer'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZATS_RA_BOOKING_PROCESSOR
  as projection on ZATS_RA_BOOKING
{
  key TravelId,
  key BookingId,
      BookingDate,
      @Consumption.valueHelpDefinition: [{ 
        entity.name: '/DMO/I_Customer' , entity.element: 'CustomerID' 
       }] //For Value Help
      CustomerId,
      
      @Consumption.valueHelpDefinition: [{ 
        entity.name: '/DMO/I_Carrier', entity.element: 'AirlineID'
       }]
      CarrierId,
      
      @Consumption.valueHelpDefinition: [{ 
        entity.name: '/DMO/I_Connection', entity.element: 'ConnectionID',
        additionalBinding: [{ 
            localElement: 'CarrierId',
            element: 'AirlineID'
         }]
       }]
      ConnectionId,
      FlightDate,
      FlightPrice,
      CurrencyCode,
      BookingStatus,
      LastChangedAt,
      /* Associations */
      _BookingStatus,
      _BookingSupplement: redirected to composition child ZATS_RA_BOOKSUPPL_PROCESSOR,
      _Carrier,
      _Connection,
      _Customer,
      _Travel : redirected to parent ZATS_RA_TRAVEL_PROCESSOR
}
