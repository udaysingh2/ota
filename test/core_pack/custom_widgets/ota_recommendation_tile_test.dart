import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_recommendation_tile_widget.dart';

import '../../helper/material_wrapper.dart';

void main() {
  testWidgets("Recommendation Tile", (WidgetTester tester) async {
    Widget widget =
        getMaterialWrapper(Flex(direction: Axis.vertical, children: [
      OtaRecommendationTileWidget(
        title: "title",
        imageUrl: "imageUrl",
        onRecommendationTap: () {},
      ),
    ]));
    await tester.pumpWidget(widget);
    await tester.pump();
  });
}
