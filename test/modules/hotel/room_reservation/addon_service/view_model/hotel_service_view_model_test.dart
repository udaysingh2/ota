import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_model.dart';

void main() {
  test('hotel service view model ...', () async {
    final addonServiceViewModel = AddonServiceViewModel.fromHotelEnhancement(
      HotelEnhancement(
        hotelEnhancementId: '279',
        hotelEnhancementName: 'Golf Course',
        currency: 'TBH',
        description:
            '<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club</p>',
        image:
            'https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg',
        isFlight: false,
        price: '2300',
      ),
    );

    HotelServiceViewModel hotelServiceListViewModel =
        HotelServiceViewModel(addonServiceList: [addonServiceViewModel]);

    hotelServiceListViewModel.addonServiceState =
        HotelServiceViewModelState.none;
    expect(hotelServiceListViewModel.addonServiceState,
        HotelServiceViewModelState.none);
    hotelServiceListViewModel.addonServiceState =
        HotelServiceViewModelState.loading;
    expect(hotelServiceListViewModel.addonServiceState,
        HotelServiceViewModelState.loading);
    hotelServiceListViewModel.addonServiceState =
        HotelServiceViewModelState.success;
    expect(hotelServiceListViewModel.addonServiceState,
        HotelServiceViewModelState.success);
    hotelServiceListViewModel.addonServiceState =
        HotelServiceViewModelState.failure;
    expect(hotelServiceListViewModel.addonServiceState,
        HotelServiceViewModelState.failure);
  });
}
