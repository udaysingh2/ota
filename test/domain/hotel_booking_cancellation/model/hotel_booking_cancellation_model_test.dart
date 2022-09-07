import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_booking_cancellation/models/hotel_booking_cancellation_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture(
      "hotel_booking_cancellation/hotel_booking_cancellation_details.json");
  HotelBookingCancellationModelDomain hotelBookingCancellationModelDomain =
      HotelBookingCancellationModelDomain.fromJson(json);

  Status status = Status.fromJson(json);

  test("BookingData Model", () {
    ///Convert into Model
    HotelBookingCancellationModelDomain model =
        hotelBookingCancellationModelDomain;
    expect(model.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    HotelBookingCancellationModelDomain mapFromModel =
        HotelBookingCancellationModelDomain.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    HotelBookingCancellationModelDomain modelFromJson =
        HotelBookingCancellationModelDomain.fromJson(jsondata);
    expect(modelFromJson.data != null, true);
  });
  test("Details Model", () {
    ///Convert into Model
    HotelBookingCancellationDataDomain? model =
        hotelBookingCancellationModelDomain.data;
    expect(model?.actionStatus != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    HotelBookingCancellationDataDomain mapFromModel =
        HotelBookingCancellationDataDomain.fromMap(map);
    expect(mapFromModel.actionStatus != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    HotelBookingCancellationDataDomain modelFromJson =
        HotelBookingCancellationDataDomain.fromJson(jsondata);
    expect(modelFromJson.actionStatus != null, true);
  });
  test(" Details Model", () {
    ///Convert into Model
    Refund? model = hotelBookingCancellationModelDomain.data?.refund;
    expect(model?.processingFee != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Refund mapFromModel = Refund.fromMap(map);
    expect(mapFromModel.processingFee != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    Refund modelFromJson = Refund.fromJson(jsondata);
    expect(modelFromJson.processingFee != null, true);
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
