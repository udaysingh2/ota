import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/room_detail_error_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void method() {
  printDebug('test');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Hotel Detail Error Widget", () {
    testWidgets('Hotel Detail Error Widget test', (WidgetTester tester) async {
      Widget widget = getMaterialWrapper(const RoomDetailErrorWidget(
        height: 300,
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      expect(find.byType(Container), findsWidgets);
    });
  });
}
