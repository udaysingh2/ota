import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/message_and_notification/view/widgets/message_webview.dart';

import '../../../../helper/material_wrapper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Message Webview Widget widget", () {
    testWidgets("Message Webview Widget widget", (tester) async {
      Widget widget = getMaterialWrapper(
        const MessageWebViewWidget(
          createDate: "",
          title: "title",
          type: "type",
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });
  });
}
