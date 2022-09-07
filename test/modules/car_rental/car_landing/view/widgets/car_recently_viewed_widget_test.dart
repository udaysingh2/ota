import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_recently_viewed_widget.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets('Car recently viewed widget', (tester) async {
    await tester.pumpWidget(getMaterialWrapper(CarRecentlyViewedCards(
      carRecentSearchList: [
        CarRecentSearchListViewModel(
          age: 30,
          pickupDate: "2022-05-01",
          pickupLocationId: "MA028107839914",
          pickupLocationName: "Chiang Mai 11International",
          pickupTime: "10:00:00",
          returnDate: "2022-05-03",
          returnLocationId: "MA08030095",
          returnLocationName: "Chiang Mai 11International",
          returnTime: "15:00:00",
        )
      ],
      onPress: (i) {},
      onClearConfirm: () {},
    )));
    await tester.pump();
    await tester.tap(find.byType(InkWell).first);
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
  });
}
