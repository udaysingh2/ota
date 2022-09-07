import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';

void main() {
  late OtaCountDownController otaCountDownController =
      OtaCountDownController(durationInSecond: 10);

  test('For class PaymentMethodInitiateArgument test', () {
    PaymentMethodInitiateArgument argument = PaymentMethodInitiateArgument(
        otaCountDownController: otaCountDownController,
        bookingUrn: 'bookingUrn',
        newbookingUrn: 'newbookingUrn',
        currency: 'BH',
        paymentDetails: [
          PaymentMethodTypeArgument(
            paymentMethod: "CARD",
            price: 2200.0,
            paymentMethodId: "1MH23456Z789776D",
            cardType: "JCB",
            cardRef: '',
          )
        ]);

    expect(argument.currency, 'BH');
  });

  test('For class PaymentMethodReInitiateArgument test', () {
    PaymentMethodReInitiateArgument argument = PaymentMethodReInitiateArgument(
      otaCountDownController: otaCountDownController,
      bookingUrn: 'bookingUrn',
    );

    expect(argument.bookingUrn.isNotEmpty, true);
    expect(argument.bookingUrn, 'bookingUrn');
  });
}
