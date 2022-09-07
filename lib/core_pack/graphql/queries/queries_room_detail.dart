import 'package:ota/core/query_names.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';

class QueriesRoom {
  ///Change the argument model
  static String getRoomDetailData(RoomDetailDataArgument argument) {
    var value = argument.room.map((result) => result.toMap()).toList();
    return '''
    mutation {
  ${QueryNames.shared.getRoomDetails}(
    roomRequest: {
      hotelId: "${argument.hotelId}"
      cityId: "${argument.cityId}"
      checkInDate: "${argument.checkInDate}"
      checkOutDate: "${argument.checkOutDate}"
      room: $value
      currency: "${argument.currency}"
      countryId: "${argument.countryId}"
      roomCode: "${argument.roomCode}"
      roomCategory: ${argument.roomCategory}
      price: ${argument.price}
      supplierId: "${argument.supplierId}"
      supplierName: "${argument.supplierName}"
      mealCode: "${argument.mealCode}"
      checkPrice: ${argument.checkPrice}
    }
  ) {
    data {
      mealType
      roomImage
      roomInfo {
				  roomImageCount
				  coverImage
				  roomFacilityInfo
				  description
				  promoteFlag
				  dimension
				  totalRoom
				  doubleBedFlag
				  twinBedFlag
				  queenBedflag
				  smorkingFlag
				  nonSmorkingFlag
				  noWindowFlag
				  balconyFlag
				  wifiFlag
				  maxPaxNbr
			}
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
        longDescription
        shortDescription
      }
      cancellationPolicy {
        days
        cancellationDaysDescription
        cancellationChargeDescription
        cancellationStatus
      }
      roomFacilities
      supplier
      supplierId
      supplierName
      totalPrice
      perNightPrice
      discountPercent
      nightPriceBeforeDiscount
    }
    status {
      code
      header
    }
  }
}
''';
  }
}
