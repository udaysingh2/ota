import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_models.dart';
import 'package:ota/modules/tours/reservation/helper/tour_reservation_helper.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

import '../../../../core/app_routes_test.dart';
import '../../../../mocks/fixture_reader.dart';

void main() {
  BuildContext context = MockBuildContext();
  String responseMock = fixture("tour/reservation/tour_reservation.json");
  TourReviewReservation tourReviewReservation =
      TourReviewReservation.fromJson(responseMock);
  test("Tour Reservation Helper", () {
    TourPackageViewModel? tourPackage = TourReservationHelper.checkPackageList(
        tourReviewReservation.getTourBookingInitiate!.data!.tourDetails!);
    expect(tourPackage != null, true);
    List<TourHighlight>? tourHighLight = TourReservationHelper.getHighlights(
        tourReviewReservation
            .getTourBookingInitiate!.data!.tourDetails!.packages![0]);
    expect(tourHighLight != null, true);
    String? cancellationHeader =
        TourReservationHelper.getCancellationHeader(tourHighLight);
    expect(cancellationHeader != null, true);
    double? price = TourReservationHelper.getTotalPrice(2, 2, tourPackage);
    expect(price != 0, true);
    List<String>? cancellationList =
        TourReservationHelper.getCancellationPolicy(
            context, tourPackage?.cancellationPolicy, "4");
    expect(cancellationList.isNotEmpty, true);
  });
}
