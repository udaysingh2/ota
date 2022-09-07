import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota/view/widgets/otasearch_hotel_list_widget.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('list Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(SingleChildScrollView(
      child: OTASearchResultHorizontalWidget(
        title: 'Hello',
        cardList: [
          HotelListResult(
            address: "test",
            discount: "",
            hotelImage: "",
            hotelId: "12345",
            hotelName: "gdfgeif",
            offerPercent: "10",
            rating: 4,
            reviewText: "test",
            score: "10.3",
          )
        ],
        onCardClick: (String name) {},
      ),
    ));

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('AmenitiesButton')));
    await tester.pump();
    await tester.pump();
  });
}
