import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("confirm_booking/confirm_booking.json");
  BookingConfirmationData bookingConfirmationData =
      BookingConfirmationData.fromJson(json);
  GuestInfo guestInfo = GuestInfo.fromJson(json);
  AddOnService addOnService = AddOnService.fromJson(json);
  RequestedRoomDetail requestedRoomDetail = RequestedRoomDetail.fromJson(json);
  CancellationPolicy cancellationPolicy = CancellationPolicy.fromJson(json);
  Facility facility = Facility.fromJson(json);
  RoomCategory roomCategory = RoomCategory.fromJson(json);
  Status status = Status.fromJson(json);

  test("confirm booking Result Model Domain", () {
    ///Convert into Model
    BookingConfirmationData model = bookingConfirmationData;
    expect(model.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    BookingConfirmationData mapFromModel = BookingConfirmationData.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("confirm booking Result Model Domain", () {
    ///Convert into Model
    Data? model = bookingConfirmationData.data;
    expect(model?.customerInfo != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.customerInfo != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    Data modelFromJson = Data.fromJson(jsondata);
    expect(modelFromJson.customerInfo != null, true);
  });
  test("confirm booking Result Model Domain", () {
    ///Convert into Model
    CustomerInfo? model = bookingConfirmationData.data!.customerInfo;
    expect(model?.customerId != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    CustomerInfo mapFromModel = CustomerInfo.fromMap(map);
    expect(mapFromModel.customerId != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    CustomerInfo modelFromJson = CustomerInfo.fromJson(jsondata);
    expect(modelFromJson.customerId != null, true);
  });
  test("confirm booking Result Model Domain", () {
    ///Convert into Model
    HotelBookingDetails? model =
        bookingConfirmationData.data!.hotelBookingDetails;
    expect(model?.freeFoodDelivery != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    HotelBookingDetails mapFromModel = HotelBookingDetails.fromMap(map);
    expect(mapFromModel.freeFoodDelivery != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    HotelBookingDetails modelFromJson = HotelBookingDetails.fromJson(jsondata);
    expect(modelFromJson.freeFoodDelivery != null, true);
  });
  test("confirm booking Result Model Domain", () {
    ///Convert into Model
    RoomDetails? model =
        bookingConfirmationData.data!.hotelBookingDetails!.roomDetails;
    expect(model?.hotelName != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    RoomDetails mapFromModel = RoomDetails.fromMap(map);
    expect(mapFromModel.hotelName != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    RoomDetails modelFromJson = RoomDetails.fromJson(jsondata);
    expect(modelFromJson.hotelName != null, true);
  });

  test("Guest Info test ", () {
    ///Convert into Model
    GuestInfo model = guestInfo;
    expect(model.firstName == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GuestInfo mapFromModel = GuestInfo.fromMap(map);
    expect(mapFromModel.firstName == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Addon Service test ", () {
    ///Convert into Model
    AddOnService model = addOnService;
    expect(model.description == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    AddOnService mapFromModel = AddOnService.fromMap(map);
    expect(mapFromModel.description == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Requested Room Detail test ", () {
    ///Convert into Model
    RequestedRoomDetail model = requestedRoomDetail;
    expect(model.adults == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    RequestedRoomDetail mapFromModel = RequestedRoomDetail.fromMap(map);
    expect(mapFromModel.adults == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("CancellationPolicy test ", () {
    ///Convert into Model
    CancellationPolicy model = cancellationPolicy;
    expect(model.cancellationChargeDescription == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    CancellationPolicy mapFromModel = CancellationPolicy.fromMap(map);
    expect(mapFromModel.cancellationChargeDescription == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Facility test ", () {
    ///Convert into Model
    Facility model = facility;
    expect(model.key == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Facility mapFromModel = Facility.fromMap(map);
    expect(mapFromModel.key == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("RoomCategory test ", () {
    ///Convert into Model
    RoomCategory model = roomCategory;
    expect(model.noOfRooms == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    RoomCategory mapFromModel = RoomCategory.fromMap(map);
    expect(mapFromModel.noOfRooms == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Status test ", () {
    ///Convert into Model
    Status model = status;
    expect(model.code == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Status mapFromModel = Status.fromMap(map);
    expect(mapFromModel.code == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
