import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/message_and_notification/view/widgets/message_empty_state.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Message Empty State Widget", () {
    testWidgets("Message Empty State Widget", (tester) async {
      Widget widget = getMaterialWrapper(
        const MessageAndNotificationEmptyStateWithRefresh(
          height: 400,
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });
  });
}
