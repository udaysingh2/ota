import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_list_view_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/payment_method/view_model/payment_method_argument_model.dart';

void main() {
  test('payment method argument model ...', () async {
    final paymentMethodArgumentModel = PaymentMethodArgumentModel.fromViewModel(
      PaymentMethodViewModel(
        paymentMethodId: '1AB23456C7890123D',
        nickname: 'My Visa',
        paymentMethodType: PaymentMethodType.visa,
        cardMask: '***3456',
        isDefault: true,
        cardRef: '',
      ),
    );
    expect(paymentMethodArgumentModel.cardMask.length == 7, true);
    expect(paymentMethodArgumentModel.paymentMethodId.isNotEmpty, true);
  });
}
