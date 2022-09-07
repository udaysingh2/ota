import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_virtual_wallet/bloc/virtual_payment_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_virtual_wallet/view/ota_virtual_wallet_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_virtual_wallet/view_model/virtual_payment_model.dart';

import '../../helper/material_wrapper.dart';

void main() {
  testWidgets('Ota Virtual Wallet Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(getMaterialWrapper(OtaVirtualWalletWidget(
      paymentModel: VirtualPaymentViewModel(
          walletState: WalletState.on, state: VirtualPaymentState.success),
      virtualPaymentBloc: VirtualPaymentBloc(),
      amountToBeDeducted: 10.20,
    )));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("buildEnabledButton")));

    await tester.pumpAndSettle();
  });

  testWidgets('Ota Virtual Wallet Widget disabled Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(getMaterialWrapper(OtaVirtualWalletWidget(
      paymentModel: VirtualPaymentViewModel(
          walletState: WalletState.disabled,
          state: VirtualPaymentState.success,
          balance: 0.0),
      virtualPaymentBloc: VirtualPaymentBloc(),
      amountToBeDeducted: 10.20,
    )));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("buildDisabledButton")));

    await tester.pumpAndSettle();
  });

  testWidgets('Ota Virtual Wallet Widget disabled 2 Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(getMaterialWrapper(OtaVirtualWalletWidget(
      paymentModel: VirtualPaymentViewModel(
          walletState: WalletState.disabled,
          state: VirtualPaymentState.success),
      virtualPaymentBloc: VirtualPaymentBloc(),
      amountToBeDeducted: 10.20,
    )));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("buildDisabledButton")));

    await tester.pumpAndSettle();
  });
}
