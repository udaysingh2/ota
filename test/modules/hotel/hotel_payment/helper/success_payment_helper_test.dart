import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_payment/helper/success_payment_helper.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_main_argument_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_room_view_model.dart';

void main() {
  testWidgets('success payment helper ...', (tester) async {
    final hotelPaymentAddonsList = [
      HotelPaymentAddonsModel(
        imageUrl: "",
        quantity: "2",
        cost: "200.00",
        selectedDate: DateTime.now(),
        serviceName: "hotel",
        uniqueId: "123456",
        description: "",
        isFlightRequired: false,
      )
    ];
    final hotelPaymentFacilityList = [
      HotelPaymentFacilityList(key: 'key_hotel', value: '')
    ];
    final hotelPaymentRoomDetailList = [
      HotelPaymentRoomDetails(
          category: 'Category 1', numberOfRooms: 2, roomType: 'Superior')
    ];
    expect(
        SuccessPaymentHelper.generateAdddon(hotelPaymentAddonsList)?.length ==
            1,
        true);
    expect(
        SuccessPaymentHelper.generateFacilityList(hotelPaymentFacilityList)
                ?.length ==
            1,
        true);
    expect(
        SuccessPaymentHelper.generateRoomDetails(hotelPaymentRoomDetailList)
                ?.length ==
            1,
        true);
  });
}
