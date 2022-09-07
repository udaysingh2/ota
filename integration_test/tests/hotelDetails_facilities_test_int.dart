import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/hotel/hotel_detail/view/hotel_detail.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/facilities_details_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/facilities_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/primary_hotel_widget.dart';

import '../configs/hoteDetailsConfig.dart' as hotelDetailsConfig;
import '../models/argument_data_model_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../utils/hotel_detail_data_source_automation.dart';

HotelAutomation hotelAutomation = new HotelAutomation();
DetailAutomation detailAutomation = new DetailAutomation();
DataAutomation dataAutomation = new DataAutomation();

Room room = new Room();
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Hotel Facility Details', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.tap(find.text("Login with alpha user"));
    await tester.pumpAndSettle();
    var config = json.decode(hotelDetailsConfig.HotelDetailsConfig.data);
    HotelDetailRemoteDataSourceAutomation
        hotelDetailRemoteDataSourceAutomation =
        HotelDetailRemoteDataSourceImpl();
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
    Finder hotel2 = find.text("Hotel 2");
    await tester.tap(hotel2);
    await tester.pumpAndSettle(Duration(seconds: 10));
    print("starting Hotel Facility Details");
    FacilitiesAutomation? facilitiesDetails =
        hotelAutomation.data!.hotelDetail!.facilities;
    Finder facilityNameObj = find.byType(FacilityView);
    await tester.dragUntilVisible(
        facilityNameObj, find.byType(HotelDetailView), Offset(0, -100));
    await tester.pumpAndSettle();
    FacilityView facilityViewObj = tester.widget(facilityNameObj);
    Map<String, dynamic> facilityMain = new Map();
    Map<String, dynamic> facilityList = new Map();
    facilitiesDetails!.main!.forEach((element) {
      facilityMain.putIfAbsent(element.key!, () => element.value);
    });
    facilitiesDetails.list!.forEach((element) {
      facilityList.putIfAbsent(element.key!, () => element.value);
    });
    print(facilityMain);
    print(facilityList);
    expect(facilityViewObj.facilityMain, facilityMain);
    expect(facilityViewObj.facilityList, facilityList);
    for (var i = 0; i < facilityMain.length; i++) {
      var facility = facilityMain.keys.elementAt(i);
      await tester.pumpAndSettle();
      switch (facility) {
        case "WIFI":
          {
            facility = "Wi-Fi";
          }
          break;
        case "FITNESS":
          {
            facility = "ฟิตเนส";
          }
          break;
        case "ROOM_SRV":
          {
            facility = "รูมเซอร์วิส";
          }
          break;
        case "SPA":
          {
            facility = "สปา";
          }
          break;
        case "LAUNDRY":
          {
            facility = "บริการซักอบรีด";
          }
          break;
      }
      expect(find.text(facility), findsOneWidget);
    }
    await tester.ensureVisible(find.byType(PrimaryHotelView));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key("facilities_additional")));
    await tester.pumpAndSettle();
    expect(find.text("สิ่งอำนวยความสะดวก"), findsOneWidget);
    expect(find.byType(FacilityDetailsView), findsOneWidget);
    for (var i = 0; i < facilityList.length; i++) {
      tester.takeException();
      var facility = facilityList.values.elementAt(i);
      expect(find.text(facility), findsOneWidget);
      if (i == 8) {
        print("Vijesh looking for " +
            facilityList.values.elementAt(facilityList.length - 1));
        await tester.dragUntilVisible(
            find.text(facilityList.values.elementAt(facilityList.length - 1)),
            find.byType(FacilityDetailsView),
            Offset(0, -10));
        await tester.pumpAndSettle();
        //tester.takeException();
        //   expect(
        //       tester.takeException(), ArgumentError("No host specified in URI "));
      }
    }
    print("All tests passed");
  });
  testWidgets('Hotel Detail Negative tests', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.tap(find.text("Login with alpha user"));
    await tester.pumpAndSettle();
    var config = json.decode(hotelDetailsConfig.HotelDetailsConfig.data);
    HotelDetailRemoteDataSourceAutomation
        hotelDetailRemoteDataSourceAutomation =
        HotelDetailRemoteDataSourceImpl();
    List<RoomData> roomData = [];
    roomData.add(new RoomData(adults: 2, children: 0));
    hotelAutomation =
        await hotelDetailRemoteDataSourceAutomation.getHotelDetail(
      HotelDetailDataArgumentAutomation(
        currency: config[1]['currency'],
        checkOutDate: config[1]['checkOutDate'],
        checkInDate: config[1]['checkInDate'],
        rooms: roomData,
        cityId: config[1]['cityId'],
        countryId: config[1]['countryId'],
        hotelId: config[1]['hotelID'],
      ),
    );
    Finder hotel1 = find.text("Hotel 1");
    await tester.tap(hotel1);
    await tester.pumpAndSettle(Duration(seconds: 10));
    print("starting Hotel Facility Details- Negative Tests");
    // FacilitiesAutomation? facilitiesDetails =
    // hotelAutomation.data!.hotelDetail!.facilities;
    Finder facilityNameObj = find.byType(FacilityView);
    Finder facilityNameScroller = find.text("เช็คเอาท์").first;
    await tester.dragUntilVisible(
        facilityNameScroller, find.byType(HotelDetailView), Offset(0, -5));
    await tester.pumpAndSettle();
    FacilityView facilityViewObj = tester.widget(facilityNameObj);
    expect(facilityViewObj.facilityMain, {});
    expect(facilityViewObj.facilityList, {});
    await tester.tap(find.byKey(Key("facilities_additional")).first);
    await tester.pumpAndSettle();
    expect(find.text("สิ่งอำนวยความสะดวก"), findsOneWidget);
    expect(find.byType(FacilityDetailsView), findsOneWidget);
    print("All tests passed");
  });
}
