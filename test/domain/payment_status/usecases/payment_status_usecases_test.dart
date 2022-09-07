import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/domain/payment_status/data_sources/payment_status_remote_sata_source_mock.dart';
import 'package:ota/domain/payment_status/repositories/payment_status_repository_impl.dart';
import 'package:ota/domain/payment_status/usecases/payment_status_usecases.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  PaymentStatusUseCases? useCases;

  late OtaCountDownController otaCountDownController =
      OtaCountDownController(durationInSecond: 10);

  PaymentMethodInitiateArgument argument = PaymentMethodInitiateArgument(
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

  setUpAll(() async {
    PaymentStatusRepository statusRepository = PaymentStatusRepositoryImpl(
      internetInfo: InternetSuccessMock(),
      remoteDataSource: PaymentStatusMockDataSourceImpl(),
    );

    useCases = PaymentStatusUseCasesImpl(
      repository: statusRepository,
    );
  });

  test('For class PaymentStatusUseCases ==> getPaymentInitiate Test', () async {
    final result = await useCases!
        .getPaymentInitiateV2(argument.toPaymentInitiateArgumentModelDomain());

    expect(result?.isRight, true);
  });

  test('For class PaymentStatusUseCases ==> getNewBookingUrn Test', () async {
    final result = await useCases!.getNewBookingUrn('');

    expect(result?.isRight, true);
  });

  test('For class PaymentStatusUseCases ==> getPaymentStatus Test', () async {
    final result = await useCases!.getPaymentStatus('');

    expect(result?.isRight, true);
  });
}
