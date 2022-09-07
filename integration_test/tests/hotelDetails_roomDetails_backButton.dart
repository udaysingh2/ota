import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/hotel/hotel_detail/view/widgets/primary_hotel_widget.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Verify Back Button Functionality from hotel room details page',
      (WidgetTester tester) async {
    //OTA-110

    print(
        "OTA-110 : Verify Back Button Functionality from hotel room details page");

    //Initialising app
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

    //Login screen
    print("Login");
    await tester.tap(find.text("Login with alpha user"));
    await tester.pump(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 10));

    //Select a hotel
    print("Tap on Hotel 2");
    await tester.tap(find.text("Hotel 2"));
    await tester.pump(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 10));

    //Drag to primary hotel view
    print("Drag to primary hotel view");
    await tester.dragUntilVisible(find.byType(PrimaryHotelView).first,
        find.byType(PrimaryHotelView).first, Offset(0, 500));
    await tester.pump(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 10));

    //Click on primary hotel to open room offer
    print("Click on primary hotel to open room offer");
    await tester.tap(find.byType(PrimaryHotelView).first);
    await tester.pump(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 10));

    //click on first room offer
    print("click on first room offer");
    await tester.tap(find.byType(OtaNextButton).first);
    await tester.pump(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 10));

    //Verifying text 'จองที่พัก' ('Book Accomodation')  TH on room details page
    print("Verifying text ('Book Accomodation')  TH on room details page");
    Finder bookAccText = find.text("จองที่พัก");
    expect(bookAccText, findsOneWidget);

    //Verifying text 'Book Accomodation' EN on room details page
    //     Finder bookAccText = find.byKey(Key("Book Accomodation'"));
    //     expect(bookAccText, findsOneWidget);

    //Drag and validate the text again
    print("Drag to cancellation policy section");
    await tester.dragUntilVisible(find.byType(CancellationPolicy),
        find.byType(CancellationPolicy), Offset(0, 500));
    await tester.pump(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 10));

    //Verifying text 'จองที่พัก' ('Book Accomodation')  TH on room details page
    // to make sure it is visible after scrolling i.e sticking on top
    print(
        "Verifying text ('Book Accomodation')  TH on room details page to make sure it is visible after scrolling i.e sticking on top");
    Finder bookAccText1 = find.text("จองที่พัก");
    expect(bookAccText1, findsOneWidget);

    //Click on back button
    print("Click on back button");
    await tester.tap(find.byType(IconButton).first);
    await tester.pump(Duration(seconds: 2));
    await tester.pumpAndSettle(Duration(seconds: 10));

    //Verifying share button exists
    // so the its confirmed we are back on hotel details page

    ///commented this as share button has been removed
    /*print("Verifying share button exists so the its confirmed we are back on hotel details page");
    Finder shareButtonOnHotelDetailPage = find.byType(ShareButton);
    expect(shareButtonOnHotelDetailPage, findsOneWidget);*/
  });
}
