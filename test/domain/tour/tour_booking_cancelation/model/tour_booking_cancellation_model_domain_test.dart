import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/models/tours_booking_cancellation_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture(
      "tour/tour_booking_cancellation/tour_booking_cancellation_success_mock.json");
  TourBookingDetailCancellationDomain tourBookingCancellationResultModel =
      TourBookingDetailCancellationDomain.fromJson(jsonString);
  GetTourBookingReject getTourBookingCancellation =
      GetTourBookingReject.fromJson(jsonString);

  test("TourBookingCancellation Models", () {
    //Convert into Model
    expect(
        tourBookingCancellationResultModel.getTourBookingReject != null, true);

    //convert into map
    Map<String, dynamic> map = tourBookingCancellationResultModel.toMap();

    ///Check map conversion
    TourBookingDetailCancellationDomain mapFromModel =
        TourBookingDetailCancellationDomain.fromMap(map);

    expect(mapFromModel.getTourBookingReject != null, true);

    ///Convert to String
    String stringData = tourBookingCancellationResultModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = tourBookingCancellationResultModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("data", () {
    Data data = Data.fromJson(tourBookingCancellationResultModel
        .getTourBookingReject!.data!
        .toJson());
    //convert into map
    Map<String, dynamic> map = data.toMap();
    expect(map.isNotEmpty, true);

    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.cancellationDate != null, false);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("GetTourBookingReject test ", () {
    ///Convert into Model
    GetTourBookingReject model = getTourBookingCancellation;
    expect(model.data == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GetTourBookingReject mapFromModel = GetTourBookingReject.fromMap(map);
    expect(mapFromModel.data == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
