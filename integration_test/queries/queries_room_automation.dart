import '../models/argument_data_model_room_detail_automation.dart';

class QueriesRoomAutomation {
  ///Change the argument model
  static String getRoomDetailData(RoomDetailDataArgumentAutomation argument) {
    var value = argument.room.map((result) => result.toMap()).toList();
    return '''
    mutation {
  getRoomDetails(
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
    }
  ) {
    data {
      mealType
      roomImage
      roomCategories {
        roomName
        roomType
        noOfRooms
      }
      facilities {
        key
        value
      }
      cancellationPolicy {
        days
        cancellationDaysDescription
        cancellationChargeDescription
        cancellationStatus
      }
      roomFacilities
      totalPrice
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
