import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;
import '../models/argument_data_model_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../utils/hotel_detail_data_source_automation.dart';
import '../configs/hoteDetailsConfig.dart' as hotelDetailsConfig;

HotelAutomation hotelAutomation = new HotelAutomation();
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
    List<RoomData> roomData=[];
    roomData.add(new RoomData(adults: 2, children: 0));
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
    print(config[0]['hotelID']);
    String? hotelname =
        hotelAutomation.data?.hotelDetail?.name ?? "NoDateFromGraphQL";
    Finder hotelNameObj = find.text(hotelname);
    if (hotelname != "NoDateFromGraphQL") {
      expect(hotelNameObj.evaluate().length, 1);
      expect(hotelNameObj.evaluate(), hotelname);
    } else {
      expect(true, false,
          reason:
              "No hotels found with text :null. GraphQL returned name as null");
    }
  });
}
