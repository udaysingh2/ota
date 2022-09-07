import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/reservation/bloc/traveller_detail_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_traveller_detail_widget.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';
import '../../../../../helper.dart';

void main() {
  TravellerController controller = TravellerController();
  testWidgets('Package Traveller Detail Widget Test',
      (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(PackageTravellerDetailWidget(
      adultPaxId: "",
      childPaxId: "",
      childCount: 2,
      adultCount: 4,
      travellerController: controller,
      tourRequireInfoViewModel: TourRequireInfoViewModel(
          weight: true,
          passportValidDate: true,
          passportId: true,
          passportCountryIssue: true,
          passportCountry: true,
          guestName: true,
          dateOfBirth: true,
          allName: true),
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
  });
}
