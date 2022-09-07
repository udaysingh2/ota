import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view/widgets/wrapped_grid_view_widget.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Service Card Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(WrappedGridView(
      listOfWidget: [
        Container(),
      ],
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });

  testWidgets('Service Card Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(WrappedGridView(
      listOfWidget: [
        Container(),
        Container(),
      ],
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });

  testWidgets('Service Card Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(WrappedGridView(
      listOfWidget: [
        Container(),
        Container(),
        Container(),
      ],
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
