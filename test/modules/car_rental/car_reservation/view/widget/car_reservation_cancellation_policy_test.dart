import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/car_reservation_bloc.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_cancellation_controller.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_cancellation_policy.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';

final CarReservationBloc _carReservationBloc = CarReservationBloc();
CarReservationCancellationController controller =
    CarReservationCancellationController();

void main() {
  group("CarReservationCancellationScreen Widget", () {
    testWidgets('CarReservationCancellationScreen Widget Test collapsed',
        (WidgetTester tester) async {
      _carReservationBloc.state.carDetailInfoModel?.cancellationPolicyList = [
        CancellationPolicyListData(
            cancellationDays: 1, cancellationMessage: 'Cannot Cancel')
      ];
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: CarReservationCancellationScreen(
          carReservationBloc: _carReservationBloc,
          controller: controller,
        )),
      ));
      await tester.pumpAndSettle();
    });
    testWidgets('CarReservationCancellationScreen Widget Test expanded',
        (WidgetTester tester) async {
      controller.toggle();
      _carReservationBloc.state.carDetailInfoModel?.cancellationPolicyList = [
        CancellationPolicyListData(
            cancellationDays: 1, cancellationMessage: 'Cannot Cancel')
      ];
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: CarReservationCancellationScreen(
          carReservationBloc: _carReservationBloc,
          controller: controller,
        )),
      ));
      await tester.pumpAndSettle();
    });
  });
}
