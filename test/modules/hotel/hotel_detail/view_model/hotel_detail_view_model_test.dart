import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_view_model.dart';

import '../../../../mocks/fixture_reader.dart';
import '../../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';

void main() {
  Map<String, dynamic> jsonMap =
      json.decode(fixture("hotel/hotel_details/hotel_detail_mock.json"));

  Data hotelDetail = Data.fromMap(jsonMap);

  HotelDetailArgument hotelDetailArgument = getHotelDetailArgumentMock();
  test("Hotel Detail View Model Test", () {
    HotelDetailModel hotelDetailModel =
        HotelDetailModel.mapFromHotelDetail(hotelDetail, hotelDetailArgument);

    HotelDetailViewModel hotelDetailViewModel = HotelDetailViewModel(
        pageState: HotelDetailViewPageState.success, data: hotelDetailModel);
    expect(hotelDetailViewModel.data?.name, "Amora Neoluxe Bangkok");
  });

  test("Hotel Detail View Model Test", () {
    HotelDetailViewModel hotelDetailViewModelParsing = HotelDetailViewModel(
        pageState: HotelDetailViewPageState.success,
        data: HotelDetailModel(id: "id", freeFoodPromotions: []));
    expect(hotelDetailViewModelParsing.data?.id, "id");
  });
}
