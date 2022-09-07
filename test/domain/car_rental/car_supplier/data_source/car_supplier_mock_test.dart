import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_supplier/data_source/car_supplier_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';
import 'package:ota/domain/car_rental/car_supplier/repositories/car_supplier_repository_impl.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/car_supplier_impl_success_mock.dart';

void main() {
  GraphQlResponse graphQlResponsePlayList = MockCarSupplierStatusGraphQl();
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

  CarSupplierRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
  CarSupplierRepository carSupplierRepository = CarSupplierRepositoryImpl(
    internetInfo: InternetSuccessMock(),
    remoteDataSource: CarSupplierRemoteDataSourceImpl(),
  );

  test("car reservation Data Source", () {
    CarSupplierRemoteDataSource carSupplierRemoteDataSource =
        CarSupplierRemoteDataSourceImpl();

    CarSupplierRemoteDataSourceImpl.setMock(graphQlResponsePlayList);

    carSupplierRemoteDataSource.getCarSupplierData(argumentModel);
  });
  test(
      'car reservation  Repository '
      'When calling get car reservation data '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult =
        await carSupplierRepository.getCarSupplierData(argumentModel);

    expect(consentResult.isRight, true);
  });
}
