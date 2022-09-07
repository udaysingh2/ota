import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view/widgets/tour_cancellation_reasons_list_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  List<String> cancellationReasons = [
    AppLocalizationsStrings.cancelResFoundAnotherPlaceGo,
    AppLocalizationsStrings.cancelResMyTourCancelled,
    AppLocalizationsStrings.cancelResUnableTravelCovid19,
    AppLocalizationsStrings.changeNumberOfTraveller,
    AppLocalizationsStrings.changeTravelDateOrDestination,
    AppLocalizationsStrings.cancelResOther,
  ];
  final TextEditingController textEditingController = TextEditingController();
  testWidgets('Tour Cancellation Reasons List Test',
      (WidgetTester tester) async {
    Widget widget = getMaterialWrapper(TourCancellationReasonsListWidget(
      labelList: cancellationReasons,
      textEditingController: textEditingController,
      onTap: (intValue, boolValue, stringValue) {},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Column), findsWidgets);
    await tester.pump();
    await tester.pumpAndSettle();
    await tester.tap(find.byType(OtaRadioButton).first);
  });
}
