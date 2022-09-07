import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_detail/data_source/car_detail_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_detail/data_source/car_detail_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_argument_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("landing dynamic playlist mock data source group", () {
    CarDetailRemoteDataSource carDetailRemoteDataSource =
        CarDetailMockDataSourceImpl();
    carDetailRemoteDataSource = CarDetailMockDataSourceImpl();

    CarDetailDomainArgumentModel argumentModel = CarDetailDomainArgumentModel(
      supplierId: '',
      rentalType: '',
      carId: "",
      pickupLocationId: '',
      returnLocationId: '',
      pickupDate: '',
      returnDate: '',
      includeDriver: '',
      residenceCountry: '',
      currency: '',
      age: 2,
      pickupCounter: '',
      returnCounter: '',
    );

    test('Hotel landing dynamic playlist mock data source', () async {
      carDetailRemoteDataSource.getCarDetail(
        CarDetailDomainArgumentModel(
          supplierId: '',
          rentalType: '',
          carId: "",
          pickupLocationId: '',
          returnLocationId: '',
          pickupDate: '',
          returnDate: '',
          includeDriver: '',
          residenceCountry: '',
          currency: '',
          age: 2,
          pickupCounter: '',
          returnCounter: '',
        ),
      );
    });

    test('car reservation mock data source', () async {
      String response = CarDetailMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('car reservation mock data source', () async {
      String response = CarDetailMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('car reservation mock data source', () async {
      carDetailRemoteDataSource.getCarDetail(argumentModel);
    });
  });
}
