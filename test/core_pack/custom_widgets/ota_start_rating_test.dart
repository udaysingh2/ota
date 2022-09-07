import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_star_rating/ota_star_rating.dart';
import 'package:ota/core_pack/custom_widgets/ota_star_rating/ota_star_rating_controller.dart';

void main() {
  testWidgets(
    'Star Rating forcetoone as true',
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OtaStarRating(
            starRating: -1,
            otaStarRatingController: OtaStarRatingController(),
          ),
        ),
      ));
    },
  );
  testWidgets(
    'Star Rating forcetoone as false',
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OtaStarRating(
            starRating: 6,
            otaStarRatingController: OtaStarRatingController(),
            forceToOne: false,
          ),
        ),
      ));
    },
  );
  test("Star count negative", () {
    OtaStarRatingController controller = OtaStarRatingController();
    controller.updateStarRating(-1);
    expect(controller.state.starCount, 0);
  });
}
