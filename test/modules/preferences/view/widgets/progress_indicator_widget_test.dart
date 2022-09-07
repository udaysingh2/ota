import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/preferences/view/widgets/progress_indicator_widget.dart';
import '../../../../helper/material_wrapper.dart';

void main() {
    testWidgets('Progress Indicator Widget Test', (tester) async {
      Widget widget = getMaterialWrapper(const ProgressIndicatorWidget(
        width: 140,
        limit: 4,
        progress: 2,
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });
}
