import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';
import 'package:ota/domain/hotel/room_detail/repositories/room_detail_repository_impl.dart';

import '../../repositories/internet_failure_mock.dart';
import '../../repositories/internet_success_mock.dart';
import '../repositories/room_detail_remote_datasource_impl_failure_mock.dart';
import '../repositories/room_detail_remote_datasource_impl_mock.dart';

void main() {
  RoomDetailRepository? roomDetailRepositoryServerException;
  RoomDetailRepository? roomDetailRepositoryMock;
  RoomDetailRepository? roomDetailRepositoryInternetFailure;
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
    roomDetailRepositoryMock = RoomDetailRepositoryImpl();

    /// Code coverage for mock class
    roomDetailRepositoryMock = RoomDetailRepositoryImpl(
        remoteDataSource: RoomDetailRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    roomDetailRepositoryServerException = RoomDetailRepositoryImpl(
        remoteDataSource: RoomDetailRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    roomDetailRepositoryInternetFailure = RoomDetailRepositoryImpl(
        remoteDataSource: RoomDetailRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Room Detail analytics Repository '
      'When calling getRoomDetailData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
        await roomDetailRepositoryMock!.getRoomDetail(argument);

    /// Get model from mock data.
    final RoomDetailData? model = consentResult.right;

    /// Condition check for hotel value null
    expect(model?.getRoomDetails != null, false);
  });

  test(
      'Room Detail analytics Repository '
      'When calling getRoomDetailData '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult =
        await roomDetailRepositoryInternetFailure!.getRoomDetail(argument);

    expect(consentResult.isLeft, true);
  });

  test(
      'Room Detail analytics Repository '
      'When calling getRoomDetailData '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResult =
        await roomDetailRepositoryServerException!.getRoomDetail(argument);

    expect(consentResult.isLeft, true);
  });
}
