import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_mock.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/domain/hotel/hotel_addon_service/repositories/hotel_service_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_addon_service/usecases/hotel_service_use_cases.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  HotelServiceUseCases? hotelServiceUseCases;
  HotelServiceDataArgument argument = HotelServiceDataArgument(
      checkInDate: "",
      checkOutDate: "",
      currency: "",
      limit: 8,
      hotelId: "",
      offset: 0);
  setUpAll(() async {
    hotelServiceUseCases = HotelServiceUseCasesImpl(
        repository: HotelServiceRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: HotelServicelMockDataSourceImpl()));
  });
  test('Hotel service UseCases ', () async {
    /// Consent user cases impl
    final hotelServiceResult =
        await hotelServiceUseCases!.getHotelAddonServiceData(argument);

    /// Get model from mock data.
    final HotelServiceResultModel? model = hotelServiceResult?.right;

    expect(model!.getAddonServices == null, false);
  });
}
