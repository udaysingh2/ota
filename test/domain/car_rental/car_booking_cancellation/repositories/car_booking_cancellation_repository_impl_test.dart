import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/data_source/car_booking_cancellation_mock.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/data_source/car_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/models/car_booking_cancellation_model.dart';
import 'package:ota/domain/car_rental/car_booking_cancellation/repositories/car_booking_cancellation_repository_impl.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';
import 'package:ota/common/network/exceptions.dart' as exp;

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class CarBookingCancellationRemoteDataSourceFailureMock
    implements CarBookingCancellationRemoteDataSource {
  @override
  Future<CarBookingCancellationModelDomain> getCarBookingCancellationData(
      CarBookingCancellationArgument argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  CarBookingCancellationRepository? carBookingCancellationRepositoryMock;
  CarBookingCancellationRepository?
      carBookingCancellationRepositoryInternetFailure;
  CarBookingCancellationRepository?
      carBookingCancellationRepositoryServerException;

  CarBookingCancellationArgument argument =
      CarBookingCancellationArgument(reason: '', confirmNo: '');

  setUpAll(() async {
    /// Code coverage for default implementation.
    carBookingCancellationRepositoryMock =
        CarBookingCancellationRepositoryImpl();

    /// Code coverage for mock class
    carBookingCancellationRepositoryMock = CarBookingCancellationRepositoryImpl(
        remoteDataSource: CarBookingCancellationMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    carBookingCancellationRepositoryServerException =
        CarBookingCancellationRepositoryImpl(
            remoteDataSource:
                CarBookingCancellationRemoteDataSourceFailureMock(),
            internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    carBookingCancellationRepositoryInternetFailure =
        CarBookingCancellationRepositoryImpl(
            remoteDataSource:
                CarBookingCancellationRemoteDataSourceFailureMock(),
            internetInfo: InternetFailureMock());
  });

  test(
      'Car Booking Cancellation analytics Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await carBookingCancellationRepositoryMock!
        .getCarBookingCancellationData(argument);

    /// Get model from mock data.
    final CarBookingCancellationModelDomain bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.data != null, true);
  });

  test(
      'Car Booking Cancellation analytics Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await carBookingCancellationRepositoryInternetFailure!
        .getCarBookingCancellationData(argument);

    expect(result.isLeft, true);
  });

  test(
      'Car Booking Cancellation analytics Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await carBookingCancellationRepositoryServerException!
        .getCarBookingCancellationData(argument);

    expect(result.isLeft, true);
  });
}
