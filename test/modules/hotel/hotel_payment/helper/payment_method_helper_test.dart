import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';
import 'package:ota/modules/hotel/hotel_payment/helper/payment_method_helper.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_list_view_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';

void main() {
  testWidgets('payment method helper ...', (tester) async {
    final paymentList = PaymentList(
      paymentMethodId: '1AB23456C7890123D',
      sortSequence: 1,
      cardMask: '***3456',
      cardType: 'VISA',
      paymentType: 'CREDIT_CARD',
      cardBank: '',
      defaultMethodFlag: false,
      nickname: 'My Visa',
      paymentStatus: 'ACTIVE',
    );
    final paymentMethodList = [paymentList];
    final paymentMethodViewModelList = [
      PaymentMethodViewModel.fromPaymentList(paymentList)
    ];

    expect(
        PlaymentMethodHelper.getPaymentMethodViewModelList(paymentMethodList)
                ?.length ==
            1,
        true);

    expect(
        PlaymentMethodHelper.getPaymentMethodArgumentModelList(
                    paymentMethodViewModelList)
                ?.length ==
            1,
        true);

    expect(
        PlaymentMethodHelper.buildPaymentMethodImage(PaymentMethodType.jcb)
            is Image,
        true);
    expect(
        PlaymentMethodHelper.buildPaymentMethodImage(PaymentMethodType.scb)
            is Image,
        true);
    expect(
        PlaymentMethodHelper.buildPaymentMethodImage(PaymentMethodType.visa)
            is SvgPicture,
        true);
    expect(
        PlaymentMethodHelper.buildPaymentMethodImage(
            PaymentMethodType.mastercard) is SvgPicture,
        true);
  });
}
