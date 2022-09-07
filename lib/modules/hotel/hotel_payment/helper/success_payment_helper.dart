import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_main_argument_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_room_view_model.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_argument_model.dart';

class SuccessPaymentHelper {
  static List<AddonsModel>? generateAdddon(
      List<HotelPaymentAddonsModel>? hotelPaymentAddonsModelList) {
    List<AddonsModel> addonsModelList = [];
    if (hotelPaymentAddonsModelList != null &&
        hotelPaymentAddonsModelList.isNotEmpty) {
      addonsModelList = List<AddonsModel>.generate(
          hotelPaymentAddonsModelList.length, (index) {
        return AddonsModel(
            cost: hotelPaymentAddonsModelList.elementAt(index).cost,
            description:
                hotelPaymentAddonsModelList.elementAt(index).description,
            imageUrl: hotelPaymentAddonsModelList.elementAt(index).imageUrl,
            quantity: hotelPaymentAddonsModelList.elementAt(index).quantity,
            selectedDate:
                hotelPaymentAddonsModelList.elementAt(index).selectedDate,
            serviceName:
                hotelPaymentAddonsModelList.elementAt(index).serviceName,
            uniqueId: hotelPaymentAddonsModelList.elementAt(index).uniqueId);
      });
    }
    return addonsModelList;
  }

  static List<FacilityList>? generateFacilityList(
      List<HotelPaymentFacilityList>? hotelPaymentFacilityList) {
    List<FacilityList> facilityList = [];
    if (hotelPaymentFacilityList != null &&
        hotelPaymentFacilityList.isNotEmpty) {
      facilityList =
          List<FacilityList>.generate(hotelPaymentFacilityList.length, (index) {
        return FacilityList(
          key: hotelPaymentFacilityList.elementAt(index).key,
          value: hotelPaymentFacilityList.elementAt(index).value,
        );
      });
    }
    return facilityList;
  }

  static List<RoomDetails>? generateRoomDetails(
      List<HotelPaymentRoomDetails>? hotelPaymentRoomDetailsList) {
    List<RoomDetails> roomDetailsList = [];
    if (hotelPaymentRoomDetailsList != null &&
        hotelPaymentRoomDetailsList.isNotEmpty) {
      roomDetailsList = List<RoomDetails>.generate(
          hotelPaymentRoomDetailsList.length, (index) {
        return RoomDetails(
          category: hotelPaymentRoomDetailsList.elementAt(index).category,
          numberOfRooms:
              hotelPaymentRoomDetailsList.elementAt(index).numberOfRooms,
          roomType: hotelPaymentRoomDetailsList.elementAt(index).roomType,
        );
      });
    }
    return roomDetailsList;
  }
}
