import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_search_suggestion_tile_widget.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets(' Car Search Suggestion tile test', (tester) async {
    Widget widget = getMaterialWrapper(const CarSearchSuggestionTileWidget(
      serviceType: ServiceType.city,
      title: 'CarSearchSuggestionTileWidget',
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
