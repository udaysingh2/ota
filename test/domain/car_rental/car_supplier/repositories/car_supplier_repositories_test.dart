import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/car_rental/car_supplier/data_source/car_supplier_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_supplier/data_source/car_supplier_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';
import 'package:ota/domain/car_rental/car_supplier/repositories/car_supplier_repository_impl.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class CarSupplierRemoteDataSourceFailureMock
    implements CarSupplierRemoteDataSource {
  @override
  Future<CarSupplierModelDomainData> getCarSupplierData(
      CarSupplierArgumentModel argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  CarSupplierRepository? carSupplierRepositoryMock;

  CarSupplierRepository? carSupplierRepositoryInternetFailure;
  CarSupplierRepository? carSupplierRepositoryServerException;

  String? rentalType;

  String? pickupLocation;
  String? returnLocation;
  String? pickupDate;
  String? includeDriver;
  String? currency;
  String? carId;
  int? age;
  String? returnDate;
  String? residenceCountry;
  String? pickupCounter;
  String? returnCounter;
  CarSupplierArgumentModel argumentModel = CarSupplierArgumentModel(
      pickupLocation,
      returnLocation,
      pickupDate,
      returnDate,
      carId,
      includeDriver,
      residenceCountry,
      currency,
      rentalType,
      pickupCounter,
      returnCounter,
      age);

  setUpAll(() async {
    /// Code coverage for default implementation.
    carSupplierRepositoryMock = CarSupplierRepositoryImpl();

    /// Code coverage for mock class
    carSupplierRepositoryMock = CarSupplierRepositoryImpl(
        remoteDataSource: CarSupplierMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    carSupplierRepositoryServerException = CarSupplierRepositoryImpl(
        remoteDataSource: CarSupplierRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    carSupplierRepositoryInternetFailure = CarSupplierRepositoryImpl(
        remoteDataSource: CarSupplierRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'car Reservation Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result =
        await carSupplierRepositoryMock!.getCarSupplierData(argumentModel);

    /// Get model from mock data.
    final CarSupplierModelDomainData bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.getCarRentalSupplier != null, true);
  });

  test(
      'car Reservation Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await carSupplierRepositoryInternetFailure!
        .getCarSupplierData(argumentModel);

    expect(result.isLeft, true);
  });

  test(
      'car reservation Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await carSupplierRepositoryServerException!
        .getCarSupplierData(argumentModel);

    expect(result.isLeft, true);
  });
}
