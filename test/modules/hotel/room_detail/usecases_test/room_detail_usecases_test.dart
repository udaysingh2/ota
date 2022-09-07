import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';
import 'package:ota/domain/hotel/room_detail/usecases/room_detail_usecases.dart';

import '../repositories/room_detail_impl_success_mock.dart';

void main() {
  RoomDetailUseCases? roomDetailUseCases;
  RoomDetailDataArgument argument = RoomDetailDataArgument(
    hotelId: "MA0511000344",
    cityId: "MA05110041",
    checkInDate: "2021-09-18",
    checkOutDate: "2021-09-19",
    room: [
      RoomCapacity(adult: 2, children: 2),
      RoomCapacity(adult: 5, children: 0)
    ],
    currency: AppConfig().currency,
    countryId: "MA05110001",
    roomCode: "MA07080326",
    roomCategory: 1,
    price: 5040.00,
    supplierId: '123',
    supplierName: 'Mark All Services Co., Ltd',
    mealCode: 'BB',
  );
  setUpAll(() async {
    /// Code coverage for default implementation.
    roomDetailUseCases = RoomDetailUseCasesImpl();

    /// Code coverage for mock class
    roomDetailUseCases = RoomDetailUseCasesImpl(
        repository: RoomDetailRepositoryImplSuccessMock());
  });

  test(
      'Room Detail analytics usecases '
      'When calling getHotelUrlData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await roomDetailUseCases!.getRoomDetail(argument);

    /// Get model from mock data.
    final RoomDetailData? model = consentResult!.right;

    /// Condition check for hotel value null
    expect(model?.getRoomDetails != null, true);
  });
}
