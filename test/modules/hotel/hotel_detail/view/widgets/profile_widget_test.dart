import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/profile_widget.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });
  testWidgets('Profile Widget Test', (tester) async {
    Widget widget = getMaterialWrapper(
      const ProfileWidget(name: "test",
      date: "00/00/0000", 
      citizen: "abc",
      imageUrl:'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
      roomType: "Large",
      travelType: "Bus",),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(Container), findsWidgets);
    expect(find.text("test"), findsOneWidget);
    expect(find.byType(SizedBox), findsWidgets);
  });
}
