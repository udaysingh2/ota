import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/room_detail/data_sources/room_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/room_detail/repositories/room_detail_repository_impl.dart';

import '../../repositories/internet_success_mock.dart';
import '../repositories/room_detail_mock_data_source.dart';

void main() {
  GraphQlResponse graphQlResponseRoom = MockRoomDetailGraphQl();
  RoomDetailRepository? roomDetailRepositoryMock;
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

  roomDetailRepositoryMock = RoomDetailRepositoryImpl();

  /// Code coverage for mock class
  RoomDetailRemoteDataSourceImpl.setMock(graphQlResponseRoom);
  roomDetailRepositoryMock = RoomDetailRepositoryImpl(
      remoteDataSource: RoomDetailRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("RoomDetail Data Source", () {
    RoomDetailRemoteDataSource roomRemoteDataSource =
        RoomDetailRemoteDataSourceImpl();
    RoomDetailRemoteDataSourceImpl.setMock(graphQlResponseRoom);
    roomRemoteDataSource.getRoomDetail(argument);
  });
  test(
      'Room Detail analytics Repository '
      'When calling getRoomDetailData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
        await roomDetailRepositoryMock!.getRoomDetail(argument);

    /// Condition check for hotel value null
    expect(consentResult.isLeft, false);
  });
}
