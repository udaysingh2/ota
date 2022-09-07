import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_mock.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/domain/hotel/hotel_addon_service/repositories/hotel_service_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_addon_service/usecases/hotel_reservation_use_cases.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  HotelReservationUseCasesImpl? hotelReservationUseCases;
  HotelServiceDataArgument argument = HotelServiceDataArgument(
      checkInDate: "",
      checkOutDate: "",
      currency: "",
      limit: 8,
      hotelId: "",
      offset: 0);
  setUpAll(() async {
    hotelReservationUseCases = HotelReservationUseCasesImpl(
        repository: HotelServiceRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: HotelServicelMockDataSourceImpl()));
  });
  test('Hotel Reservation UseCases ', () async {
    /// Consent user cases impl
    final hotelReservationResult =
        await hotelReservationUseCases!.getHotelAddonServiceData(argument);

    /// Get model from mock data.
    final HotelServiceResultModel? model = hotelReservationResult?.right;

    expect(model!.getAddonServices == null, false);
  });
}
