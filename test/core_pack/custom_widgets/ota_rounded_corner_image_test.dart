import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_rounded_corner_image.dart';

import '../../helper/material_wrapper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('ota rounded corner image ...', (tester) async {
    Widget widget = getMaterialWrapper(const OtaRoundedCornerImage(
      width: 200,
      height: 200,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSL374FOhTdKi9TaI2z90F5uQjkQ-r8PHYSAw&usqp=CAU',
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    await tester.pump();
    await tester.tap(find.byType(CachedNetworkImage));
  });
}
