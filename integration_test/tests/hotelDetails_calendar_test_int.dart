import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;

import '../configs/hoteDetailsConfig.dart' as hotelDetailsConfig;
import '../models/argument_data_model_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../utils/hotel_detail_data_source_automation.dart';

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
    List<RoomData> roomData = [];
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

    print("***************************************");
    //await tester.tap(find.text("Login with alpha user"));

    print("------------------------------");
    await tester.pumpAndSettle(Duration(seconds: 20));
    Finder testHotel = find.text("Hotel 2");
    await tester.tap(testHotel);
    await tester.pumpAndSettle(Duration(seconds: 15));
    print('The hotel is selected');

    Finder checkInElement = find.text("เช็คอิน");
    await tester.tap(checkInElement);
    await tester.pumpAndSettle(Duration(seconds: 15));
    print('The check-in field is selected');
    Finder dateRangeField = find.byKey(Key("dateRange"));
    await tester.tap(dateRangeField);
    await tester.pumpAndSettle(Duration(seconds: 5));
    print('The date range field is selected');
    await tester.pumpAndSettle(Duration(seconds: 5));

    //to check if the confirm field is enabled or not
    Finder confirmBtn = find.text('ยืนยัน').first;

    var status = false;
    try {
      await tester.ensureVisible(confirmBtn);
      status = true;
    } on Exception catch (e) {
      status = false;
      print(e.toString());
    }
    expect(status, true);
    print('The confirm button is enabled');

    Finder highlightedDays = find.byKey(Key('circledDay'));
    expect(highlightedDays, findsWidgets);
    await tester.tap(highlightedDays.first);
    await tester.pumpAndSettle(Duration(seconds: 5));
    /*String lenOfIcon = find.byKey(Key('confirmBtnColor')).evaluate().toString();
    print('lenOfIcon -------------------' + lenOfIcon);
    expect(
        (tester.firstWidget(find.byType(BoxDecoration)) as BoxDecoration).color,
        Color(0xFFE3E4E8));*/
  });
}
