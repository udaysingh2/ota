import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_models.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("tour/reservation/tour_reservation.json");

  TourReviewReservation tourReviewReservation =
      TourReviewReservation.fromJson(jsonString);
  test("Tour Review Method Domain Model Test", () {
    String stringData = tourReviewReservation.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = tourReviewReservation.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Tour Review Reservation domain model Test", () {
    GetTourBookingInitiate getTourBookingInitiate =
        GetTourBookingInitiate.fromJson(jsonString);
    Map<String, dynamic> map = getTourBookingInitiate.toMap();

    GetTourBookingInitiate mapFromModel = GetTourBookingInitiate.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = mapFromModel.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
