import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/suggetion_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/suggetion_view_model.dart';

import '../../../../../helper/material_wrapper.dart';

const int _kTestDelayTimer = 100;

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });
  testWidgets('Suggetion Widget Tests', (tester) async {
    Widget widget = getMaterialWrapper(SingleChildScrollView(
      child: SuggetionWidget(
        suggetionList: [
          SuggetionViewModel(),
          SuggetionViewModel(),
          // SuggetionViewModel(
          //    addressText: "abc",
          //    discount: "10%",
          //    headerText: "def",
          //    ratingText: "abc",
          //    offerPercent: "10",
          //    ratingTitle: "def",
          //    reviewText: "hello"
          // ),
        ],
      ),
    ));
    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: _kTestDelayTimer));
    expect(find.byType(Padding), findsWidgets);
    expect(find.byType(SizedBox), findsWidgets);
  });
}
