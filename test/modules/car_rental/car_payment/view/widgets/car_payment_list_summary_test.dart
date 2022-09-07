import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_virtual_wallet/bloc/virtual_payment_bloc.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/bloc/promo_widget_bloc.dart';
import 'package:ota/modules/car_rental/car_payment/view/widgets/car_payment_list_summary.dart';

void main() {
  final PromoWidgetBloc promoWidgetBloc = PromoWidgetBloc();
  group("Car payment list Summary Card Widget", () {
    testWidgets('Car payment list Summary Card Widget Test',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: CarPaymentListSummery(
        mechantId: "",
        additionalServicePayAtPickUpPoint: 2,
        payPickUpPoint: 1,
        discountAmount: 2,
        payOnline: 2,
        grandTotal: 2,
        carRental: 2,
        additionalServicePayOnline: 2,
        subTotalPrice: 2,
        pickupPoint: 'Bangkok',
        dropOffPoint: 'Bangkok',
        returnExtraCharge: 200.00,
        bookingUrn: "",
        promoBloc: promoWidgetBloc,
        grandTotalWithWalletAmount: 300.0,
        virtualPaymentBloc: VirtualPaymentBloc(),
        walletAmountTobeDeducted: 90.0,
      ))));
      await tester.pumpAndSettle();
    });
    testWidgets('Car payment header Card Widget Test',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: CarPaymentListSummery(
        mechantId: "",
        additionalServicePayAtPickUpPoint: 2,
        payPickUpPoint: 1,
        discountAmount: 2,
        payOnline: 2,
        grandTotal: 2,
        carRental: 2,
        additionalServicePayOnline: 2,
        subTotalPrice: 2,
        pickupPoint: 'Bangkok',
        dropOffPoint: 'Chiang',
        returnExtraCharge: 200.00,
        bookingUrn: "",
        promoBloc: promoWidgetBloc,
        grandTotalWithWalletAmount: 399.0,
        virtualPaymentBloc: VirtualPaymentBloc(),
        walletAmountTobeDeducted: 10.0,
      ))));
      await tester.pumpAndSettle();
    });
  });
}
