import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_payment/data_source/car_payment_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_payment/data_source/car_payment_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_payment/models/car_payment_argument_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("car payment mock data source group", () {
    CarPaymentRemoteDataSource carPaymentRemoteDataSource =
        CarPaymentRemoteDataSourceImpl();
    carPaymentRemoteDataSource = CarPaymentMockDataSourceImpl();

    CarPaymentDomainArgumentModel argumentModel = CarPaymentDomainArgumentModel(
        rateKey: "",
        refCode: "",
        totalPrice: 2,
        bookingUrn: "",
        additionalNeedsText: "");

    test('car payment mock data source', () async {
      carPaymentRemoteDataSource.getCarPaymentData(argumentModel);
    });

    test('car payment mock data source', () async {
      String response = CarPaymentMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('car payment mock data source', () async {
      String response = CarPaymentMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('car payment mock data source', () async {
      CarPaymentRemoteDataSource carPaymentRemoteDataSource =
          CarPaymentMockDataSourceImpl();
      final result =
          await carPaymentRemoteDataSource.getCarPaymentData(argumentModel);
      expect(result.saveCarBookingConfirmationDetails!.data != null, true);
    });
  });
}
