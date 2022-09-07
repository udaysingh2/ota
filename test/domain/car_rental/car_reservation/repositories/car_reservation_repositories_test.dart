import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_reservation/data_source/car_reservation_data_source_mock.dart';
import 'package:ota/domain/car_rental/car_reservation/data_source/car_reservation_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_argument_model.dart';
import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_domain_model.dart';
import 'package:ota/domain/car_rental/car_reservation/repositories/car_reservation_repository_impl.dart';
import 'package:ota/common/network/exceptions.dart' as exp;

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class CarReservationRemoteDataSourceFailureMock
    implements CarReservationRemoteDataSource {
  @override
  Future<CarReservationScreenDomainData> getCarReservationData(
      CarReservationDomainArgumentModel argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  CarReservationRepository? carReservationRepositoryMock;

  CarReservationRepository? carReservationRepositoryInternetFailure;
  CarReservationRepository? carReservationRepositoryServerException;
  CarReservationDomainArgumentModel argumentModel =
      CarReservationDomainArgumentModel(
    lastPrice: 2.0,
    refCode: "",
    rateKey: "",
    age: 2,
    carId: "",
    currency: "",
    includeDriver: "",
    pickupCounter: "",
    pickupDate: "",
    pickupLocationId: "",
    rentalType: "",
    residenceCountry: "",
    returnCounter: "",
    returnDate: "",
    returnLocationId: "",
    supplierId: "",
  );

  setUpAll(() async {
    /// Code coverage for default implementation.
    carReservationRepositoryMock = CarReservationRepositoryImpl();

    /// Code coverage for mock class
    carReservationRepositoryMock = CarReservationRepositoryImpl(
        remoteDataSource: CarReservationMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    carReservationRepositoryServerException = CarReservationRepositoryImpl(
        remoteDataSource: CarReservationRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    carReservationRepositoryInternetFailure = CarReservationRepositoryImpl(
        remoteDataSource: CarReservationRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'car Reservation Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await carReservationRepositoryMock!
        .getCarReservationData(argumentModel);

    /// Get model from mock data.
    final CarReservationScreenDomainData bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.getCarInitiateBookingResponse != null, true);
  });

  test(
      'car Reservation Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await carReservationRepositoryInternetFailure!
        .getCarReservationData(argumentModel);

    expect(result.isLeft, true);
  });

  test(
      'car reservation Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await carReservationRepositoryServerException!
        .getCarReservationData(argumentModel);

    expect(result.isLeft, true);
  });
}
