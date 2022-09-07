import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/modules/tours/details/view/widgets/tour_package_option_view.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_view_model.dart';

void main() {
  testWidgets('Tour Package Option View OtaTextButton',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          routes: AppRoutes.getRoutes(),
          home: Scaffold(
            body: TourPackageOptionView(
                tourPackage: TourPackage(
                    packageDetail: TourPackageDetail(
                        name: "Package name", adultPrice: 800.00))),
          ),
        ),
      );
      expect(find.byType(OtaTextButton), findsOneWidget);
      await tester.tap(find.byType(OtaTextButton));
      await tester.pumpAndSettle();
    });
  });
}
