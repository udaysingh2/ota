import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/domain/payment_status/data_sources/payment_status_remote_data_source.dart';
import 'package:ota/domain/payment_status/data_sources/payment_status_remote_sata_source_mock.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("payment method mock data source group", () {
    PaymentStatusRemoteDataSource paymentStatusRemoteDataSource =
        PaymentStatusMockDataSourceImpl();
    paymentStatusRemoteDataSource = PaymentStatusMockDataSourceImpl();
    late OtaCountDownController otaCountDownController =
        OtaCountDownController(durationInSecond: 10);
    PaymentMethodInitiateArgument paymentMethodInitiateArgument =
        PaymentMethodInitiateArgument(
            currency: "THB",
            otaCountDownController: otaCountDownController,
            bookingUrn: "H20211025AA0232",
            newbookingUrn: "",
            paymentDetails: [
          PaymentMethodTypeArgument(
            paymentMethod: "CARD",
            price: 2200.0,
            paymentMethodId: "1MH23456Z789776D",
            cardType: "JCB",
            cardRef: '',
          )
        ]);

    test('Payment method mock data source', () async {
      paymentStatusRemoteDataSource.getPaymentStatus('');
    });
    test('Payment method mock data source', () async {
      paymentStatusRemoteDataSource.getNewBookingUrn('');
    });
    test('Payment method mock data source', () async {
      paymentStatusRemoteDataSource.getPaymentInitiateV2(
          paymentMethodInitiateArgument.toPaymentInitiateArgumentModelDomain());
    });

    test('Payment method mock data source', () async {
      String response = PaymentStatusMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });

    test('Payment method mock data source', () async {
      String response =
          PaymentStatusMockDataSourceImpl.getMockDataForPaymentStatus();
      expect(response, isNotEmpty);
    });
  });
}
