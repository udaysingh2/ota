import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/hotel/hotel_detail/view/hotel_detail.dart';

import '../configs/hoteDetailsConfig.dart' as hotelDetailsConfig;
import '../models/argument_data_model_automation.dart';
import '../models/argument_data_model_room_detail_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../models/room_detail_model_automation.dart';
import '../utils/calendarUtils.dart';
import '../utils/hotel_detail_data_source_automation.dart';

HotelAutomation hotelAutomation = new HotelAutomation();
DetailAutomation detailAutomation = new DetailAutomation();
DataAutomation dataAutomation = new DataAutomation();

Room room = new Room();
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Room details- Single room', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    //await tester.tap(find.text("Login with alpha user"));
    await tester.pumpAndSettle();
    var config = json.decode(hotelDetailsConfig.HotelDetailsConfig.data);
    HotelDetailRemoteDataSourceAutomation
        hotelDetailRemoteDataSourceAutomation =
        HotelDetailRemoteDataSourceImpl();
    List<RoomData> roomData = [];
    roomData
        .add(new RoomData(adults: 2, children: 2, childAge1: 12, childAge2: 9));
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
    //print(hotelAutomation.toJson());
    List<RoomCapacityAutomation> roomCapacityAutomation = [];
    roomCapacityAutomation.add(new RoomCapacityAutomation(
        adult: 2, children: 2, childAge1: 12, childAge2: 9));
    String roomCode =
        hotelAutomation.data!.hotelDetail!.rooms![0].details![0].roomCode!;
    double price =
        hotelAutomation.data!.hotelDetail!.rooms![0].details![0].totalPrice!;

    HotelDetailRemoteDataSourceAutomation roomRemoteDataSourceAutomation =
        HotelDetailRemoteDataSourceImpl();
    RoomDetailDataAutomation roomDetails =
        await roomRemoteDataSourceAutomation.getRoomDetail(
      RoomDetailDataArgumentAutomation(
          currency: config[0]['currency'],
          checkOutDate: config[0]['checkOutDate'],
          checkInDate: config[0]['checkInDate'],
          room: roomCapacityAutomation,
          cityId: config[0]['cityId'],
          countryId: config[0]['countryId'],
          hotelId: config[0]['hotelID'],
          roomCode: roomCode,
          price: price,
          roomCategory: 1),
    );
    //get todays date
    //DateTime now = new DateTime.now();
    //DateTime date = new DateTime(now.year, now.month, now.day);
    await tester.tap(find.text('Hotel 2'));
    await tester.pumpAndSettle();
    //int adults = roomData.fold(
    //    0, (int previousValue, element) => previousValue + element.adults);
    //int children = roomData.fold(
    //    0, (int previousValue, element) => previousValue + element.children);
    CalendarUtils calendarUtils = new CalendarUtils();
    String checkInDate =
        calendarUtils.covertToBhudhistDate(config[0]['checkInDate'])!;
    String checkOutDate =
        calendarUtils.covertToBhudhistDate(config[0]['checkOutDate'])!;
    //verify the static fields
    expect(find.text("เช็คอิน"), findsOneWidget);
    expect(find.text("เช็คเอาท์"), findsOneWidget);
    expect(find.text("ห้อง"), findsNWidgets(2));
    expect(find.text("ผู้เข้าพัก"), findsOneWidget);
    //verify search filters
    expect(find.text(checkInDate), findsOneWidget);
    expect(find.text(checkOutDate), findsOneWidget);
    expect(find.text(checkInDate), findsOneWidget);
    expect(find.text(checkOutDate), findsOneWidget);
    // await tester.tap(find.text(checkInDate));
    // await tester.pumpAndSettle(Duration(seconds: 10));
    // await tester.tap(find.text(checkInDate+' - '+checkOutDate));
    //  await tester.pumpAndSettle();
    //  print(find.descendant(of:find.byType(CalendarGridView),matching:find.byType(InkWell),skipOffstage: false).evaluate().length);
    //  find.descendant(of:find.byType(CalendarGridView),matching:find.byType(InkWell),skipOffstage: false).evaluate().forEach((element) {
    //    print(element.widget.key);
    //  });
    await tester.dragUntilVisible(
        find.text('ห้อง').first, find.byType(HotelDetailView), Offset(0, -100));
    await tester.pumpAndSettle();
    await tester
        .tap(find.text(hotelAutomation.data!.hotelDetail!.rooms![0].roomName!));
    await tester.pumpAndSettle();
    //String roomOffer = hotelAutomation.data!.hotelDetail!.rooms![0].details![0].roomOfferName!.toString()+" + "+
    //hotelAutomation.data!.hotelDetail!.rooms![0].details![0].roomType!.toString();
    await tester.tap(find.byKey(Key('room_detail_key')).first);
    await tester.pumpAndSettle();
    expect(
        find.text(roomDetails.getRoomDetails!.data!.mealType!), findsOneWidget);
    getRoomDetailsTopText(roomDetails).forEach((element) {
      expect(find.text(element), findsOneWidget);
    });
    print("All tests passed");
  });
  testWidgets('Roomm details -multiple Rooms', (WidgetTester tester) async {
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
    roomData
        .add(new RoomData(adults: 2, children: 2, childAge1: 12, childAge2: 9));
    roomData.add(new RoomData(adults: 3, children: 1, childAge1: 10));
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
    //print(hotelAutomation.toJson());
    List<RoomCapacityAutomation> roomCapacityAutomation = [];
    roomCapacityAutomation.add(new RoomCapacityAutomation(
        adult: 2, children: 2, childAge1: 12, childAge2: 9));
    roomCapacityAutomation
        .add(new RoomCapacityAutomation(adult: 3, children: 1, childAge1: 10));
    String roomCode =
        hotelAutomation.data!.hotelDetail!.rooms![0].details![0].roomCode!;
    double price =
        hotelAutomation.data!.hotelDetail!.rooms![0].details![0].totalPrice!;

    HotelDetailRemoteDataSourceAutomation roomRemoteDataSourceAutomation =
        HotelDetailRemoteDataSourceImpl();
    RoomDetailDataAutomation roomDetails =
        await roomRemoteDataSourceAutomation.getRoomDetail(
      RoomDetailDataArgumentAutomation(
          currency: config[0]['currency'],
          checkOutDate: config[0]['checkOutDate'],
          checkInDate: config[0]['checkInDate'],
          room: roomCapacityAutomation,
          cityId: config[0]['cityId'],
          countryId: config[0]['countryId'],
          hotelId: config[0]['hotelID'],
          roomCode: roomCode,
          price: price,
          roomCategory: 1),
    );
    await tester.tap(find.text('Hotel 4'));
    await tester.pumpAndSettle();
    int adults = roomData.fold(
        0, (int previousValue, element) => previousValue + element.adults);
    //int children= roomData.fold(0, (int previousValue, element) => previousValue!+element.children);
    CalendarUtils calendarUtils = new CalendarUtils();
    String checkInDate =
        calendarUtils.covertToBhudhistDate(config[0]['checkInDate'])!;
    String checkOutDate =
        calendarUtils.covertToBhudhistDate(config[0]['checkOutDate'])!;
    //verify the static fields
    expect(find.text("เช็คอิน"), findsOneWidget);
    expect(find.text("เช็คเอาท์"), findsOneWidget);
    expect(find.text("ห้อง"), findsNWidgets(2));
    expect(find.text("ผู้เข้าพัก"), findsOneWidget);
    //verify search filters
    expect(find.text(adults.toString()), findsOneWidget);
    expect(find.text(checkInDate), findsOneWidget);
    expect(find.text(checkOutDate), findsOneWidget);
    expect(find.text(checkInDate), findsOneWidget);
    expect(find.text(checkOutDate), findsOneWidget);
    // await tester.tap(find.text(checkInDate));
    // await tester.pumpAndSettle(Duration(seconds: 10));
    // await tester.tap(find.text(checkInDate+' - '+checkOutDate));
    //  await tester.pumpAndSettle();
    //  print(find.descendant(of:find.byType(CalendarGridView),matching:find.byType(InkWell),skipOffstage: false).evaluate().length);
    //  find.descendant(of:find.byType(CalendarGridView),matching:find.byType(InkWell),skipOffstage: false).evaluate().forEach((element) {
    //    print(element.widget.key);
    //  });
    await tester.dragUntilVisible(
        find.text('ห้อง').first, find.byType(HotelDetailView), Offset(0, -100));
    await tester.pumpAndSettle();
    await tester
        .tap(find.text(hotelAutomation.data!.hotelDetail!.rooms![0].roomName!));
    await tester.pumpAndSettle();
    //String roomOffer = hotelAutomation.data!.hotelDetail!.rooms![0].details![0].roomOfferName!.toString()+" + "+
    //    hotelAutomation.data!.hotelDetail!.rooms![0].details![0].roomType!.toString();
    await tester.tap(find.byKey(Key('room_detail_key')).first);
    await tester.pumpAndSettle();
    expect(
        find.text(roomDetails.getRoomDetails!.data!.mealType!), findsOneWidget);
    getRoomDetailsTopText(roomDetails).forEach((element) {
      expect(find.text(element), findsOneWidget);
    });
    await tester.tap(find.byType(IconButton).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text(checkInDate).first);
    await tester.pumpAndSettle();
    for (int i = 0; i < 3; i++) {
      await tester.tap(find.byKey(Key('ButtonType.plusButton')).first);
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('ยืนยัน'));
    await tester.pumpAndSettle();
    adults = adults + 3;
    expect(find.text(adults.toString()), findsOneWidget);
    await tester.dragUntilVisible(
        find.text('ห้อง').first, find.byType(HotelDetailView), Offset(0, -100));
    await tester.pumpAndSettle();
    roomData.add(new RoomData(adults: 1, children: 0));
    roomData.add(new RoomData(adults: 1, children: 0));
    roomData.add(new RoomData(adults: 1, children: 0));
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
    roomCapacityAutomation
        .add(new RoomCapacityAutomation(adult: 1, children: 0));
    roomCapacityAutomation
        .add(new RoomCapacityAutomation(adult: 1, children: 0));
    roomCapacityAutomation
        .add(new RoomCapacityAutomation(adult: 1, children: 0));
    roomCode =
        hotelAutomation.data!.hotelDetail!.rooms![0].details![0].roomCode!;
    price =
        hotelAutomation.data!.hotelDetail!.rooms![0].details![0].totalPrice!;
    roomDetails = await roomRemoteDataSourceAutomation.getRoomDetail(
      RoomDetailDataArgumentAutomation(
          currency: config[0]['currency'],
          checkOutDate: config[0]['checkOutDate'],
          checkInDate: config[0]['checkInDate'],
          room: roomCapacityAutomation,
          cityId: config[0]['cityId'],
          countryId: config[0]['countryId'],
          hotelId: config[0]['hotelID'],
          roomCode: roomCode,
          price: price,
          roomCategory: 1),
    );
    await tester
        .tap(find.text(hotelAutomation.data!.hotelDetail!.rooms![0].roomName!));
    await tester.pumpAndSettle();
    //String roomOffer = hotelAutomation.data!.hotelDetail!.rooms![0].details![0].roomOfferName!.toString()+" + "+
    //    hotelAutomation.data!.hotelDetail!.rooms![0].details![0].roomType!.toString();
    await tester.tap(find.byKey(Key('room_detail_key')).first);
    await tester.pumpAndSettle();
    expect(
        find.text(roomDetails.getRoomDetails!.data!.mealType!), findsOneWidget);
    getRoomDetailsTopText(roomDetails).forEach((element) {
      expect(find.text(element), findsOneWidget);
    });
    print("All tests passed");
  });
}

List<String> getRoomDetailsTopText(RoomDetailDataAutomation roomDetails) {
  List<String> result = [];
  roomDetails.getRoomDetails!.data!.roomCategories!.forEach((element) {
    result.add(element.roomName!.toString().trim() +
        " " +
        element.roomType.toString().trim() +
        " (" +
        element.noOfRooms.toString().trim() +
        " ห้องนอน) ");
  });
  return result;
}
