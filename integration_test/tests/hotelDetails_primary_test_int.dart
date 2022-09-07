import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_info_section.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/primary_hotel_widget.dart';

import '../configs/hoteDetailsConfig.dart' as hotelDetailsConfig;
import '../models/argument_data_model_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../utils/hotel_detail_data_source_automation.dart';

HotelAutomation hotelAutomation = new HotelAutomation();
Room room = new Room();
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
    var config = json.decode(hotelDetailsConfig.HotelDetailsConfig.data);
    HotelDetailRemoteDataSourceAutomation
        hotelDetailRemoteDataSourceAutomation =
        HotelDetailRemoteDataSourceImpl();
    List<RoomData> roomData = [];
    roomData.add(new RoomData(adults: 3, children: 0));
    hotelAutomation =
        await hotelDetailRemoteDataSourceAutomation.getHotelDetail(
      HotelDetailDataArgumentAutomation(
        currency: config[0]['currency'],
        checkOutDate: config[0]['checkOutDate'],
        checkInDate: config[0]['checkInDate'],
        rooms: roomData,
        cityId: config[0]['cityId'],
        countryId: config[0]['countryId'],
        hotelId: config[0]['hotelID'],
      ),
    );
    await tester.tap(find.text("Login with alpha user"));
    await tester.pumpAndSettle();
    Finder hotel2 = find.text("Hotel 2");
    await tester.tap(hotel2);
    await tester.pumpAndSettle(Duration(seconds: 10));
    String? roomNameTest =
        hotelAutomation.data?.hotelDetail?.rooms?.elementAt(0).roomName ??
            "NoDateFromGraphQL";
    String? ratingCount =
        hotelAutomation.data?.hotelDetail?.ratingCount ?? "NoDateFromGraphQL";
    Finder hotelNameObj = find.byType(PrimaryHotelView);
    var htlInfo = hotelNameObj.evaluate().first.widget as PrimaryHotelView;
    Finder roomNameTap = find.text(roomNameTest);
    await tester.pump();
    await tester.tap(roomNameTap);
    await tester.pump(Duration(seconds: 2));
    Finder hotelInfoObj = find.byType(HotelInfoSection);
    var hotelInfoSection =
        hotelInfoObj.evaluate().first.widget as HotelInfoSection;
    Finder hotelinfotap = find.text(ratingCount);
    await tester.pump();
    await tester.tap(hotelinfotap);
    await tester.pump(Duration(seconds: 2));
    if (roomNameTest != "NoDateFromGraphQL") {
      expect(htlInfo.primaryViewModel.roomName, roomNameTest);
      expect(hotelInfoSection.ratingIndexText, ratingCount);
    } else {
      expect(true, false,
          reason:
              "No hotels found with text :null. GraphQL returned name as null");
    }
  });
}
