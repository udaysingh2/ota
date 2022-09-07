import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/confirm_booking/models/tour_confirm_booking_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("tour/confirm_booking/tour_confirm_booking.json");

  TourConfirmBookingModelDomain tourConfirmBookingModelDomain =
      TourConfirmBookingModelDomain.fromJson(jsonString);
  test("Tour Method Domain Model Test", () {
    String stringData = tourConfirmBookingModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = tourConfirmBookingModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour domain model Test", () {
    GetTourBookingConfirmation getTourBookingConfirmation =
        GetTourBookingConfirmation.fromJson(jsonString);
    Map<String, dynamic> map = getTourBookingConfirmation.toMap();

    GetTourBookingConfirmation mapFromModel =
        GetTourBookingConfirmation.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
