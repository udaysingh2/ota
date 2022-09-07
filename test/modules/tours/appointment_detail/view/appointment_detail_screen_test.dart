import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/tours/appointment_detail/view_model/appointment_detail_view_model.dart';
import '../../../../helper.dart';


void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  AppointmentDetailViewModel argument = AppointmentDetailViewModel.mapFromData(
    locationName: "Yaowaraj,Bangkok",
    meetingLatitude: "7.830245",
    meetingLongitude: "98.0797327",
      meetingPointValue: "<div>(Activity rate /Meeting Point)(data/activitys/tours/meetingPoint)</div><p>Hotel Lobby</p>"
  );
  group("Appointment Detail Screen", () {
    testWidgets('Appointment Detail Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.appointmentDetailScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byType(InkWell));
        await tester.pumpAndSettle();
      });
    });
  });
}