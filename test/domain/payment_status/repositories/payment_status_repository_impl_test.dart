import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/domain/payment_status/data_sources/payment_status_remote_data_source.dart';
import 'package:ota/domain/payment_status/data_sources/payment_status_remote_sata_source_mock.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_argument_domain.dart';
import 'package:ota/domain/payment_status/models/payment_initiate_new_model.dart';
import 'package:ota/domain/payment_status/models/payment_new_booking_urn_model_domain.dart';
import 'package:ota/domain/payment_status/models/payment_status_model.dart';
import 'package:ota/domain/payment_status/repositories/payment_status_repository_impl.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

class MockedPaymentStatusRemoteDataSourceExp
    implements PaymentStatusRemoteDataSource {
  @override
  Future<PaymentStatusModelDomain> getPaymentStatus(String bookingUrn) async {
    throw Exception();
  }

  @override
  Future<PaymentNewBookingUrnModelDomain> getNewBookingUrn(
      String bookingUrn) async {
    throw Exception();
  }

  @override
  Future<PaymentNewCarBookingUrnModelDomain> getNewCarBookingUrn(
      String bookingUrn) async {
    throw Exception();
  }

  @override
  Future<PaymentInitiateNewModelDomain> getPaymentInitiateV2(
      PaymentInitiateArgumentModelDomain argument) {
    throw Exception();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
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

  group("Payment method repo group", () {
    test('Payment method  repo internet success', () async {
      PaymentStatusRepositoryImpl();
      PaymentStatusRepository paymentMethodRepository =
          PaymentStatusRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: PaymentStatusMockDataSourceImpl(),
      );
      paymentMethodRepository.getPaymentInitiateV2(
          paymentMethodInitiateArgument.toPaymentInitiateArgumentModelDomain());
      paymentMethodRepository.getNewBookingUrn('');
      paymentMethodRepository.getPaymentStatus('');
    });

    test('Payment method  repo internet failure', () async {
      PaymentStatusRepositoryImpl();
      PaymentStatusRepository paymentMethodRepository =
          PaymentStatusRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: PaymentStatusMockDataSourceImpl(),
      );
      paymentMethodRepository.getPaymentInitiateV2(
          paymentMethodInitiateArgument.toPaymentInitiateArgumentModelDomain());
      paymentMethodRepository.getNewBookingUrn('');
      paymentMethodRepository.getPaymentStatus('');
    });

    test(
        'Translation analytics Repository '
        'When calling getPaymentInitiate '
        'With response data', () async {
      PaymentStatusRepositoryImpl();
      PaymentStatusRepository paymentMethodRepository =
          PaymentStatusRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: MockedPaymentStatusRemoteDataSourceExp(),
      );
      try {
        await paymentMethodRepository.getPaymentInitiateV2(
            paymentMethodInitiateArgument
                .toPaymentInitiateArgumentModelDomain());
        await paymentMethodRepository.getNewBookingUrn('');
        await paymentMethodRepository.getPaymentStatus('');
      } catch (_) {}
    });
  });
}
