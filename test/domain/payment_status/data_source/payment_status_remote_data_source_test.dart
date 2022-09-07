import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/payment_status/data_sources/payment_status_remote_data_source.dart';
import 'package:ota/domain/payment_status/repositories/payment_status_repository_impl.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/payment_status_impl_success_mock.dart';

void main() {
  late OtaCountDownController otaCountDownController =
      OtaCountDownController(durationInSecond: 10);
  PaymentMethodInitiateArgument paymentMethodInitiateArgument =
      PaymentMethodInitiateArgument(
          currency: "THB",
          otaCountDownController: otaCountDownController,
          bookingUrn: "H20211025AA0232",
          newbookingUrn: "",
          paymentDetails: [
        PaymentMethodTypeArgument(paymentMethod: "SCB", price: 770.0)
      ]);

  TestWidgetsFlutterBinding.ensureInitialized();
  GraphQlResponse graphQlResponseOtaSearch = MockPaymentStatusGraphQl();
  PaymentStatusRepository paymentStatusRepository = PaymentStatusRepositoryImpl(
      remoteDataSource: PaymentStatusRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Payment method Data Source", () {
    PaymentStatusRemoteDataSource paymentMethodRemoteDataSource =
        PaymentStatusRemoteDataSourceImpl(
            graphQlResponse: graphQlResponseOtaSearch);
    paymentMethodRemoteDataSource.getPaymentStatus('H20211020AA0171');
  });
  test(
      'Payment method Remote Repository '
      'When calling getPaymentMethodListData '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult =
        await paymentStatusRepository.getPaymentStatus('H20211020AA0171');

    printDebug(consentResult);
    expect(consentResult.isLeft, true);
  });

  test("Payment method Data Source", () {
    PaymentStatusRemoteDataSource paymentMethodRemoteDataSource =
        PaymentStatusRemoteDataSourceImpl(
            graphQlResponse: graphQlResponseOtaSearch);
    paymentMethodRemoteDataSource.getPaymentInitiateV2(
        paymentMethodInitiateArgument.toPaymentInitiateArgumentModelDomain());
  });
  test(
      'Payment method Remote Repository '
      'When calling getPaymentMethodListData '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult = await paymentStatusRepository.getPaymentInitiateV2(
        paymentMethodInitiateArgument.toPaymentInitiateArgumentModelDomain());

    printDebug(consentResult);
    expect(consentResult!.isLeft, true);
  });

  test("Payment method Data Source", () {
    PaymentStatusRemoteDataSource paymentMethodRemoteDataSource =
        PaymentStatusRemoteDataSourceImpl(
            graphQlResponse: graphQlResponseOtaSearch);
    paymentMethodRemoteDataSource.getNewBookingUrn('H20211020AA0171');
  });
  test(
      'Payment method Remote Repository '
      'When calling getPaymentMethodListData '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult =
        await paymentStatusRepository.getNewBookingUrn('H20211020AA0171');

    printDebug(consentResult);
    expect(consentResult!.isLeft, true);
  });
}
