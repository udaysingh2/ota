import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_input_widget.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/landing/view/widgets/search_text_widget.dart';

void main() {
  String testDescription = 'Hotel Details';
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(testDescription, (WidgetTester tester) async {
    app.main();
    print("Sample Test 1");
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    print("-----------The landing page is visible----------");
    await tester.tap(find.byType(SearchTextWidget));
    await tester.pump(Duration(seconds: 2));
    print("------------the text box is available-----------");
    await tester.enterText(find.byType(OtaSearchInputWidget), 'ABC');
    await tester.pump(Duration(seconds: 6));
    await tester.tap(find.byType(IconButton));
    await tester.pump(Duration(seconds: 6));
    //expect(find.text('testsda 123'), findsOneWidget);
    expect(find.textContaining('est'), findsOneWidget);
    print('Passed: $testDescription');

    /*  Finder facilitiesByText = find.text("สิ่งอำนวยความสะดวก");
    Finder facilities = find.byType(FacilityView);
    await tester.dragUntilVisible(
        facilitiesByText, find.byType(HotelDetailView), Offset(0, 500));
    await tester.pump(Duration(seconds: 2));
    await Future.delayed(Duration(seconds: 1));
    await tester.tap(find.byKey(Key("facilities_additional")));
    await tester.pumpAndSettle();
    print("Tap to view additional facilities");
    expect(facilities.allCandidates.isNotEmpty, true);
    //expect(find.text("สิ่งอำนวยความสะดวก"),findsOneWidget);
    print("Test  completed");

   */
  });
}
