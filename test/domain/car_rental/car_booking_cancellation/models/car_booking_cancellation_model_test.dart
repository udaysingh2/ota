import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/models/car_booking_cancellation_model.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json =
      fixture("car_booking_cancellation/car_booking_cancellation.json");
  CarBookingCancellationModelDomain carBookingCancellationModelDomain =
      CarBookingCancellationModelDomain.fromJson(json);

  test("Car Booking Detail Modle", () {
    ///Convert into Model
    CarBookingCancellationModelDomain model = carBookingCancellationModelDomain;
    expect(model.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData, isNotEmpty);
  });
}
