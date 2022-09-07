import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_info_section.dart';
import '../models/argument_data_model_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../utils/hotel_detail_data_source_automation.dart';
import '../configs/hoteDetailsConfig.dart' as hotelDetailsConfig;

HotelAutomation hotelAutomation = new HotelAutomation();
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Hotel Details', (WidgetTester tester) async {
    app.main();
    print("Sample test 2");
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    var config = json.decode(hotelDetailsConfig.HotelDetailsConfig.data);
    print("entering test");
    HotelDetailRemoteDataSourceAutomation
        hotelDetailRemoteDataSourceAutomation =
        HotelDetailRemoteDataSourceImpl();
    print("object instance works");
    List<RoomData> roomData=[];
    roomData.add(new RoomData(adults: 2, children: 0));
    hotelAutomation =
        await hotelDetailRemoteDataSourceAutomation.getHotelDetail(
      HotelDetailDataArgumentAutomation(
        currency: config[0]['currency'],
        checkOutDate: config[0]['checkOutDate'],
        checkInDate: config[0]['checkInDate'],
        rooms: roomData ,
        cityId: config[0]['cityId'],
        countryId: config[0]['countryId'],
        hotelId: config[0]['hotelID'],
      ),
    );
    print(config[0]['hotelID']);
    Finder hotel2 = find.text("Hotel 2");
    await tester.tap(hotel2);
    await tester.pumpAndSettle(Duration(seconds: 10));
    String? hotelname =
        hotelAutomation.data?.hotelDetail?.name ?? "NoDateFromGraphQL";
    Finder hotelNameObj = find.byType(HotelInfoSection);
    print(hotelNameObj.precache());
    var htlInfo = hotelNameObj.evaluate().first.widget as HotelInfoSection;
    if (hotelname != "NoDateFromGraphQL") {
      expect(htlInfo.headerText, hotelname);
    } else {
      expect(true, false,
          reason:
              "No hotels found with text :null. GraphQL returned name as null");
    }
  });
}
