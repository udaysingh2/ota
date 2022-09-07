import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/modules/car_rental/car_payment/bloc/car_payment_bloc.dart';
import 'package:ota/modules/car_rental/car_payment/view/widgets/car_payment_cancellation_policy_list.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_view_model.dart';

CarPaymentBloc _bloc = CarPaymentBloc();
final OtaCancellationPolicyController controller =
    OtaCancellationPolicyController();
void main() {
  group("Car Cancellation Widget", () {
    testWidgets('Car payment header Card Widget Test',
        (WidgetTester tester) async {
      _bloc.state.cancellationPolicyList = [
        CancellationPolicyList(
            cancellationDays: 2, cancellationMessage: 'CancellationMessage')
      ];
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: CarPaymentCancellationPolicy(
        carPaymentBloc: _bloc,
      ))));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('CancellationButton')));
      await tester.pump();
      await tester.pump();
    });
    testWidgets('Car Cancellation Widget Test', (WidgetTester tester) async {
      controller.state.state = OtaCancellationPolicyListModelState.expanded;
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: CarPaymentCancellationPolicy(
        carPaymentBloc: _bloc,
      ))));
      await tester.pumpAndSettle();
    });
  });
}
