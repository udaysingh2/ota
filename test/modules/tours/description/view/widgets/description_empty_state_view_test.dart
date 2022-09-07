import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/description/view/widgets/description_empty_state_view.dart';

import '../../../../../helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Description Empty State Widget", () {
    testWidgets("Description Empty State Widget", (tester) async {
      Widget widget = getMaterialWrapper(
        const DescriptionEmptyStateView(),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });
  });
}
