import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/managed_booking/data_sources/booking_list_remote_mock.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';

void main() {
  String hotelJsonString =
      BookingListMockDataSourceImpl.getMockData(OtaServiceType.hotel);
  String tourJsonString =
      BookingListMockDataSourceImpl.getMockData(OtaServiceType.tour);
  String carJsonString =
      BookingListMockDataSourceImpl.getMockData(OtaServiceType.carRental);

  String flightJsonString =
      BookingListMockDataSourceImpl.getMockData(OtaServiceType.flight);

  BookingListModelDomain bookingDetailModelDomain =
      BookingListModelDomain.fromJson(hotelJsonString);
  test("Manage booking model domain Test", () {
    String stringData = bookingDetailModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = bookingDetailModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Manage booking model domain get booking summery Test", () {
    GetBookingSummaryV2 geBookingSummery =
        GetBookingSummaryV2.fromJson(hotelJsonString);
    Map<String, dynamic> map = geBookingSummery.toMap();

    GetBookingSummaryV2 mapFromModel = GetBookingSummaryV2.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Manage booking model domain get Data Test", () {
    Data geData = Data.fromJson(hotelJsonString);
    Map<String, dynamic> map = geData.toMap();

    Data mapFromModel = Data.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Manage booking model domain BookingDetail Test", () {
    BookingDetail geBookingDetail = BookingDetail.fromJson(hotelJsonString);
    Map<String, dynamic> map = geBookingDetail.toMap();

    BookingDetail mapFromModel = BookingDetail.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Manage booking model domain geHotel Test", () {
    Hotel geHotel = Hotel.fromJson(hotelJsonString);
    Map<String, dynamic> map = geHotel.toMap();

    Hotel mapFromModel = Hotel.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Manage booking model domain geHotel Test", () {
    Hotel geHotel = Hotel.fromJson(hotelJsonString);
    Map<String, dynamic> map = geHotel.toMap();

    Hotel mapFromModel = Hotel.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Manage booking model domain getTour Test", () {
    Tour getTour = Tour.fromJson(tourJsonString);
    Map<String, dynamic> map = getTour.toMap();

    Tour mapFromModel = Tour.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Manage booking model domain getCar Test", () {
    Car getCar = Car.fromJson(carJsonString);
    Map<String, dynamic> map = getCar.toMap();

    Car mapFromModel = Car.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Manage booking model domain getFlight Test", () {
    Flight getFlight = Flight.fromJson(flightJsonString);
    Map<String, dynamic> map = getFlight.toMap();

    Flight mapFromModel = Flight.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Manage booking model domain Details Test", () {
    Details getDetails = Details.fromJson(flightJsonString);
    Map<String, dynamic> map = getDetails.toMap();

    Details mapFromModel = Details.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Manage booking model domain RouteInfo Test", () {
    RouteInfo getRouteInfo = RouteInfo.fromJson(flightJsonString);
    Map<String, dynamic> map = getRouteInfo.toMap();

    RouteInfo mapFromModel = RouteInfo.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
