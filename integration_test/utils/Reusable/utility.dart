import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

class AppActions {
/*
This method will help user to return the price in thai currency format
User need to pass normal price which is getting from GraphQL response
 */
  String getFormattedPrice(String totalPrice) {
    int k = 1;
    StringBuffer sb = new StringBuffer();
    for (int i = totalPrice.length - 1; i >= 0; i--) {
      sb.write(totalPrice[i]);
      if (k % 3 == 0) {
        if (sb.toString().replaceAll(",", "").length == totalPrice.length) {
          break;
        } else {
          sb.write(",");
        }
      }
      k++;
    }

    totalPrice = sb.toString().split("").reversed.join();
    totalPrice = "฿" + totalPrice;

    return totalPrice;
  }

/*
This method will help user to get the text from widget
Here user need to pass the finder object and it will return the
text which is attached to that widget
 */
  String getTextFromWidget(Finder finder) {
    RichText value = finder.evaluate().first.widget as RichText;
    String textOfWidget = value.text.toPlainText().trim();
    return textOfWidget;
  }

  Future<bool> isWidgetDisplayed(Finder finder, WidgetTester tester) async {
    bool status;
    try {
      await tester.ensureVisible(finder);
      status = true;
    } on Exception {
      status = false;
    }
    return status;
  }

  Future<void> waitForPageLoad(int durationInSec, WidgetTester tester) async {
    await tester.pumpAndSettle(Duration(seconds: durationInSec));
  }

  Future<void> scrollToSeeSpecificText(
      String textToSee, WidgetTester tester) async {
    await tester.dragUntilVisible(find.text(textToSee).first,
        find.byType(CustomScrollView), Offset(0, -150));
    await tester.pumpAndSettle(Duration(seconds: 4));
  }

  Future<void> tapOnElement(Finder elementToTap, WidgetTester tester) async {
    await tester.tap(elementToTap);
    await waitForPageLoad(10, tester);
  }

//Need to write for finders one by one
  findWidgetBy(String finderType, String value) {
    var finder;
    switch (finderType) {
      case "Key":
        finder = find.byKey(Key(value));
        break;
      case "Text":
        finder = find.text(value);
        break;
      case "ValueKey":
        finder = find.byKey(ValueKey(value));
        break;
    }
    return finder;
  }

  String getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    var randomString = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return randomString;
  }
}
