import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';

class QueriesRoomReservation {
  static String getHotelAddonServicesData(
      HotelServiceDataArgument serviceDataArgument) {
    return '''
        mutation {
          getAddonServices(
            serviceRequest: {
              hotelId: "${serviceDataArgument.hotelId}"
              checkInDate: "${serviceDataArgument.checkInDate}"
              checkOutDate: "${serviceDataArgument.checkOutDate}"
              currency: "${serviceDataArgument.currency}"
              limit: ${serviceDataArgument.limit}
              offset: ${serviceDataArgument.offset}
            }
          ) {
            data {
              hotelEnhancements {
                hotelEnhancementId
                hotelEnhancementName
                currency
                price
                image
                isFlight
                description
              }
            }
            status {
              code
              header
              description
            }
          }
        }
    ''';
  }
}
