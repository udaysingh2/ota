import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/tour_search/search/view/widget/tour_search_suggestions_tile_widget.dart';
import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Tour Suggestions Tile Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(TourSearchSuggestionTileWidget(
      title: "title",
      serviceType: ServiceType.tour,
      imageUrl: "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg",
      onSearchSuggestionTap: (){},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}