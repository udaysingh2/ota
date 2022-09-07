import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/hotel/hotel_detail/view/hotel_detail.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/suggetion_widget.dart';

import '../models/hotel_detail_model_automation.dart';

HotelAutomation hotelAutomation = new HotelAutomation();
DetailAutomation detailAutomation = new DetailAutomation();
DataAutomation dataAutomation = new DataAutomation();

Room room = new Room();
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Hotel Review Details', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    // var config = json.decode(hotelDetailsConfig.HotelDetailsConfig.data);
    // HotelDetailRemoteDataSourceAutomation
    // hotelDetailRemoteDataSourceAutomation =
    // HotelDetailRemoteDataSourceImpl();
    // hotelAutomation =
    // await hotelDetailRemoteDataSourceAutomation.getHotelDetail(
    //   HotelDetailDataArgumentAutomation(
    //     currency: config[0]['currency'],
    //     checkOutDate: config[0]['checkOutDate'],
    //     checkInDate: config[0]['checkInDate'],
    //     children: config[0]['children'],
    //     adults: config[0]['adults'],
    //     cityId: config[0]['cityId'],
    //     countryId: config[0]['countryId'],
    //     hotelId: config[0]['hotelID'],
    //   ),
    // );
    await tester.tap(find.text("Login with alpha user"));
    await tester.pumpAndSettle();
    Finder hotel2 = find.text("Hotel 2");
    await tester.tap(hotel2);
    await tester.pumpAndSettle(Duration(seconds: 40));
    print("starting Hotel Review Details");
    Finder suggestions = find.text("ที่พักแนะนำ");
    await tester.dragUntilVisible(
        suggestions, find.byType(HotelDetailView), Offset(0, -200));
    await tester.pumpAndSettle();
    Finder suggesionWidget = find.byType(SuggetionWidget);
    SuggetionWidget suggestionList =
        suggesionWidget.evaluate().first.widget as SuggetionWidget;
    print("suggestionList.reviewList!.length" +
        suggestionList.suggetionList.length.toString());
    for (int i = 0; i < suggestionList.suggetionList.length; i++) {
      expect(suggestionList.suggetionList.elementAt(i).headerText!.isNotEmpty,
          true);
      print(i.toString());
      //change finder to search for comment/user
      print(suggestionList.suggetionList.elementAt(i).headerText);
      await tester.dragUntilVisible(find.byType(SuggetionWidget),
          find.byType(HotelDetailView), Offset(50, 0));
      await tester.pumpAndSettle();
    }
    print("All tests passed");
  });
  testWidgets('Hotel Review Negative tests', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    // var config = json.decode(hotelDetailsConfig.HotelDetailsConfig.data);
    print("All tests passed");
  });
}
