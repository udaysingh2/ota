import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/message_and_notification/view/widgets/list_tile.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("List Tile Widget", () {
    testWidgets("List Tile Widget", (tester) async {
      Widget widget = getMaterialWrapper(
        const MessageListTile(
          title: 'title',
          type: 'type',
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });
  });
}
