import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_argument_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_detail_view_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  Map<String, dynamic> jsonMap =
      json.decode(fixture("room_detail/room_detail.json"));

  RoomDetailData roomDetailData = RoomDetail.fromMap(jsonMap).data!;
  GetRoomDetailsData getRoomDetails = roomDetailData.getRoomDetails!.data!;

  RoomDetailArgument roomDetailArgument = RoomDetailArgument(
    address: "address",
    rating: "rating",
    hotelId: "MA0511000344",
    cityId: "MA05110041",
    checkInDate: "2021-09-18",
    checkOutDate: "2021-09-19",
    rooms: [Room(adults: 2, children: 2), Room(adults: 5, children: 0)],
    currency: AppConfig().currency,
    countryId: "MA05110001",
    roomCode: "MA07080326",
    roomCategory: 1,
    price: 5040.00,
    freefoodDelivery: false,
    supplierId: '123',
    supplierName: 'Mark All Services Co., Ltd',
    mealCode: 'BB',
  );
  test("Room Detail View Model Test", () {
    RoomDetailModel roomDetailModel =
        RoomDetailModel.mapFromRoomDetail(getRoomDetails, roomDetailArgument);

    RoomDetailViewModel roomDetailViewModel = RoomDetailViewModel(
        pageState: RoomDetailViewPageState.success, data: roomDetailModel);
    expect(roomDetailViewModel.data?.totalAmount, 5040.00);
  });

  test("Room Detail View Model Test By Parsing", () {
    RoomDetailViewModel roomDetailViewModelParsing = RoomDetailViewModel(
        pageState: RoomDetailViewPageState.success,
        data: RoomDetailModel(
          supplierId: '123',
          roomType: '',
          roomImage: '',
          totalAmount: 2000,
          supplierName: 'Mark All Services Co., Ltd',
        ));
    expect(roomDetailViewModelParsing.data?.totalAmount, 2000);
  });
}
