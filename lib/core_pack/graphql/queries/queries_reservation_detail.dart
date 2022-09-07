import 'package:ota/core/query_names.dart';
import 'package:ota/domain/hotel/booking_initiate/models/argument_data_model.dart';

class QueriesReservation {
  ///Change the argument model
  static String getData(ReservationDataArgument argument) {
    var value = argument.room.map((result) => result.toMap()).toList();
    return '''
    mutation {
  ${QueryNames.shared.initiateBooking}(
    initiateBookingRequest: {
      hotelId: "${argument.hotelId}"
      cityId: "${argument.cityId}"
      checkInDate: "${argument.checkInDate}"
      checkOutDate: "${argument.checkOutDate}"
      room: $value
      currency: "${argument.currency}"
      countryId: "${argument.countryId}"
      roomCode: "${argument.roomCode}"
      roomCategory: "${argument.roomCategory}"
      price: ${argument.price}
      supplierId: "${argument.supplierId}"
      supplierName: "${argument.supplierName}"
      mealCode: "${argument.mealCode}"
      checkPrice: ${argument.checkPrice}
    }
  ) {
    data {
      hotelName
      hotelImage
      bookingUrn
      roomDetails {
        rateKey
        supplier
        mealType
        roomImage
        roomCategories {
          noOfRoomsAndName
          roomName
          roomType
          noOfRooms
        }
        facilities {
          key
          value
        }
        hotelBenefits {
          shortDescription
          longDescription
        }
        cancellationPolicy {
          days
          cancellationDaysDescription
          cancellationChargeDescription
          cancellationStatus
        }
        totalPrice
        perNightPrice
        numberOfNights       
      }
      promotionList {
        productType
        promotionCode
        title
        description
        web
        iconImage
        bannerDescDisplay
        line1
        line2
        promotionType
        productId
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
