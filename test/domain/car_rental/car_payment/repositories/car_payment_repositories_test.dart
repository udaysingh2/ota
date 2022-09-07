import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_payment/data_source/car_payment_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_payment/data_source/car_payment_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_payment/models/car_payment_argument_model.dart';
import 'package:ota/domain/car_rental/car_payment/models/car_payment_model_domain.dart';
import 'package:ota/domain/car_rental/car_payment/repositories/car_payment_repository_impl.dart';
import 'package:ota/common/network/exceptions.dart' as exp;

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class CarPaymentRemoteDataSourceFailureMock
    implements CarPaymentRemoteDataSource {
  @override
  Future<CarPaymentDomainModelData> getCarPaymentData(
      CarPaymentDomainArgumentModel argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  CarPaymentRepository? carPaymentRepositoryMock;

  CarPaymentRepository? carPaymentRepositoryInternetFailure;
  CarPaymentRepository? carPaymentRepositoryServerException;
  CarPaymentDomainArgumentModel argumentModel = CarPaymentDomainArgumentModel(
      rateKey: "",
      refCode: "",
      totalPrice: 2,
      bookingUrn: "",
      additionalNeedsText: "");

  setUpAll(() async {
    /// Code coverage for default implementation.
    carPaymentRepositoryMock = CarPaymentRepositoryImpl();

    /// Code coverage for mock class
    carPaymentRepositoryMock = CarPaymentRepositoryImpl(
        remoteDataSource: CarPaymentMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    carPaymentRepositoryServerException = CarPaymentRepositoryImpl(
        remoteDataSource: CarPaymentRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    carPaymentRepositoryInternetFailure = CarPaymentRepositoryImpl(
        remoteDataSource: CarPaymentRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'car Payment Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result =
        await carPaymentRepositoryMock!.getCarPaymentData(argumentModel);

    /// Get model from mock data.
    final CarPaymentDomainModelData bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.saveCarBookingConfirmationDetails != null, true);
  });

  test(
      'car Payment Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await carPaymentRepositoryInternetFailure!
        .getCarPaymentData(argumentModel);

    expect(result.isLeft, true);
  });

  test(
      'car Payment Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await carPaymentRepositoryServerException!
        .getCarPaymentData(argumentModel);

    expect(result.isLeft, true);
  });
}
