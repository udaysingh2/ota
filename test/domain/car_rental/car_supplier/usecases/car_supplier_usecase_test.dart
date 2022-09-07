import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_supplier/data_source/car_supplier_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';
import 'package:ota/domain/car_rental/car_supplier/repositories/car_supplier_repository_impl.dart';
import 'package:ota/domain/car_rental/car_supplier/usecases/car_supplier_use_cases.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  CarSupplierUseCases? carSupplierUseCases;

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
    carSupplierUseCases = CarSupplierUseCasesImpl();

    /// Code coverage for mock class
    CarSupplierRepository carSupplierRepository = CarSupplierRepositoryImpl(
        remoteDataSource: CarSupplierMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());
    carSupplierUseCases =
        CarSupplierUseCasesImpl(repository: carSupplierRepository);
  });

  test(
      'Car Supplier UseCases '
      'When calling getPlayListData '
      'With Success response data', () async {
    /// Consent user cases impl

    final result =
        await carSupplierUseCases!.getCarSupplierData(argument: argumentModel);

    /// Get model from mock data.
    final CarSupplierModelDomainData model = result!.right;

    /// Condition check for recommended value null
    expect(model.getCarRentalSupplier != null, true);
  });
}
