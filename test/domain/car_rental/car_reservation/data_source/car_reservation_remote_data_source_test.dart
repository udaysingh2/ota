import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_reservation/data_source/car_reservation_data_source_mock.dart';
import 'package:ota/domain/car_rental/car_reservation/data_source/car_reservation_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_reservation/models/car_reservation_argument_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("landing dynamic playlist mock data source group", () {
    CarReservationRemoteDataSource carReservationRemoteDataSource =
        CarReservationRemoteDataSourceImpl();
    carReservationRemoteDataSource = CarReservationMockDataSourceImpl();

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

    test('car reservation mock data source', () async {
      carReservationRemoteDataSource.getCarReservationData(argumentModel);
    });

    test('car reservation mock data source', () async {
      String response = CarReservationMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('car reservation mock data source', () async {
      String response = CarReservationMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('car reservation mock data source', () async {
      carReservationRemoteDataSource.getCarReservationData(argumentModel);
    });
  });
}
