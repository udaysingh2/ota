import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Hotel Details', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.tap(find.text("Login with alpha user"));
    await tester.pumpAndSettle();
    print("Tap on Hotel 2");
    await tester.tap(find.text("Hotel 2"));
    await tester.pump(Duration(seconds: 5));

    //commenting this as share has been removed
    /*print("Tap on Share button");
    await tester.tap(find.byType(ShareButton));*/
    await tester.pumpAndSettle(Duration(seconds: 10));

    // await Process.run("C:\\Users\\rakhorke\\AppData\\Local\\Android\\Sdk\\platform-tools\\adb" , ['shell' ,'input', 'tap', '421', '1578']);
    // if (Platform.isAndroid) {
    // await Process.run("adb" , ['shell' ,'input',  '421', '1578']);
    // } else if (Platform.isIOS) {
    //   print("iOS");
    // }

    print("Tapping on hotel name");
    await tester.tap(find.text("Shangri La Bangkok").first);
    await tester.pumpAndSettle(Duration(seconds: 10));
  });
}
