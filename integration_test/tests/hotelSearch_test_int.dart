import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/search/filters/view/filter_screen.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_input_widget.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/plus_minus_button.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_tile_widget.dart';

import '../configs/hoteDetailsConfig.dart' as hotelDetailsConfig;
import '../models/argument_data_model_automation.dart';
import '../models/argument_data_model_room_detail_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../utils/calendarUtils.dart';
import '../utils/hotel_detail_data_source_automation.dart';

HotelAutomation hotelAutomation = new HotelAutomation();
DetailAutomation detailAutomation = new DetailAutomation();
DataAutomation dataAutomation = new DataAutomation();

Room room = new Room();
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Search details ', (WidgetTester tester) async {
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
    // String roomCode =
    //     hotelAutomation.data!.hotelDetail!.rooms![0].details![0].roomCode!;
    // double price =
    //     hotelAutomation.data!.hotelDetail!.rooms![0].details![0].totalPrice!;

    // HotelDetailRemoteDataSourceAutomation roomRemoteDataSourceAutomation =
    //     HotelDetailRemoteDataSourceImpl();
    // RoomDetailDataAutomation roomDetails =
    //     await roomRemoteDataSourceAutomation.getRoomDetail(
    //   RoomDetailDataArgumentAutomation(
    //       currency: config[0]['currency'],
    //       checkOutDate: config[0]['checkOutDate'],
    //       checkInDate: config[0]['checkInDate'],
    //       room: roomCapacityAutomation,
    //       cityId: config[0]['cityId'],
    //       countryId: config[0]['countryId'],
    //       hotelId: config[0]['hotelID'],
    //       roomCode: roomCode,
    //       price: price,
    //       roomCategory: 1),
    // );
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
    await tester.tap(find.text(checkInDate));
    await tester.pumpAndSettle(Duration(seconds: 10));
    //static text validation
    expect(find.text('วันที่เข้าพัก'), findsOneWidget);
    expect(find.text('จำนวนห้องพัก'), findsOneWidget);
    expect(find.text('รายละเอียดการจองที่พัก'), findsOneWidget);
    //Filter Validation
    expect(find.text(checkInDate + ' - ' + checkOutDate), findsOneWidget);
    for (int i = 1; i <= roomCapacityAutomation.length; i++) {
      await tester.dragUntilVisible(find.text('ห้อง ' + i.toString()),
          find.byType(FilterScreen), Offset(0, 50));
      expect(find.text('ห้อง ' + i.toString()), findsOneWidget);
    }
    //rooms validation
    for (int i = 1; i <= roomCapacityAutomation.length; i++) {
      await tester.dragUntilVisible(find.text('ห้อง ' + i.toString()),
          find.byType(FilterScreen), Offset(0, 50));
      Finder tileWdgt1 = find.byKey(Key(i.toString()));
      FilterTileWidget tileWdgt =
          tester.widget(tileWdgt1.first) as FilterTileWidget;
      expect(tileWdgt.roomNumber, i);
      expect(tileWdgt.adults, roomCapacityAutomation[i - 1].adult);
      expect(
          tileWdgt.childAgeList.length, roomCapacityAutomation[i - 1].children);
      List<int> childAges = [];
      if (roomCapacityAutomation[i - 1].children == 1) {
        childAges.add(roomCapacityAutomation[i - 1].childAge1!);
      }
      if (roomCapacityAutomation[i - 1].children == 2) {
        childAges.add(roomCapacityAutomation[i - 1].childAge1!);
        childAges.add(roomCapacityAutomation[i - 1].childAge2!);
      }
      expect(tileWdgt.childAgeList, childAges);
    }
    //  await tester.pumpAndSettle();
    //  print(find.descendant(of:find.byType(CalendarGridView),matching:find.byType(InkWell),skipOffstage: false).evaluate().length);
    //  find.descendant(of:find.byType(CalendarGridView),matching:find.byType(InkWell),skipOffstage: false).evaluate().forEach((element) {
    //    print(element.widget.key);
    //  });
    //Validate number of rooms cant be 0
    for (int i = 1; i < roomCapacityAutomation.length; i++) {
      await tester.tap(find.byKey(Key('ButtonType.minusButton')).first);
      await tester.pumpAndSettle();
    }
    expect(find.text('ห้อง 1'), findsOneWidget);
    // Validate remove room button is disabled when room is only 1
    Finder removeRoomFndr = find.byKey(Key('ButtonType.minusButton')).first;
    PlusMinusButton removeRoomBtn =
        tester.widget(removeRoomFndr) as PlusMinusButton;
    expect(removeRoomBtn.isEnabled, false);
    Finder addRoomFndr = find.byKey(Key('ButtonType.plusButton')).first;
    PlusMinusButton addRoomBtn = tester.widget(addRoomFndr) as PlusMinusButton;
    expect(addRoomBtn.isEnabled, true);
    //set number of adults as 1 for 1st room
    for (int i = 1; i < roomCapacityAutomation[0].adult; i++) {
      await tester.tap(find.byKey(Key('ButtonType.minusButton')).at(1));
    }
    //set number of child as 0 for 1st room
    for (int i = 1; i <= roomCapacityAutomation[0].children!; i++) {
      await tester.tap(find.byKey(Key('ButtonType.minusButton')).at(2));
    }
    //Validate number of rooms cant be more than 9
    for (int i = 1; i < 9; i++) {
      await tester.tap(find.byKey(Key('ButtonType.plusButton')).first);
      await tester.pumpAndSettle();
    }
    removeRoomBtn = tester.widget(removeRoomFndr) as PlusMinusButton;
    expect(removeRoomBtn.isEnabled, true);
    addRoomBtn = tester.widget(addRoomFndr) as PlusMinusButton;
    expect(addRoomBtn.isEnabled, false);
    //rooms validation for 9 rooms
    for (int i = 1; i <= 9; i++) {
      await tester.dragUntilVisible(find.text('ห้อง ' + i.toString()),
          find.byType(FilterScreen), Offset(0, 50));
      Finder tileWdgt1 = find.byKey(Key(i.toString()));
      FilterTileWidget tileWdgt =
          tester.widget(tileWdgt1.first) as FilterTileWidget;
      expect(tileWdgt.roomNumber, i);
      expect(tileWdgt.adults, 1);
      expect(tileWdgt.childAgeList.length, 0);
      List<int> childAges = [];
      expect(tileWdgt.childAgeList, childAges);
    }
    await tester.tap(find.text('ยืนยัน'));
    await tester.pumpAndSettle();
    expect(find.text('9'), findsNWidgets(2));
    await tester.tap(find.text(checkInDate));
    await tester.pumpAndSettle(Duration(seconds: 10));
    //add children tests
    for (int i = 1; i < 9; i++) {
      await tester.tap(find.byKey(Key('ButtonType.minusButton')).at(0));
    }
    await tester.tap(find.byKey(Key('ButtonType.plusButton')).at(2));
    await tester.pumpAndSettle();
    expect(find.text('อายุของเด็กคนที่ 1'), findsOneWidget);
    expect(find.text("ใส่อายุ (เฉพาะตัวเลขเท่านั้น)"), findsOneWidget);
    await tester.tap(find.byKey(Key('childAgePopUp')));
    await tester.pumpAndSettle();
    Finder tileWdgt1 = find.byKey(Key('1'));
    FilterTileWidget tileWdgt =
        tester.widget(tileWdgt1.first) as FilterTileWidget;
    expect(tileWdgt.childAgeList.length, 0);
    await tester.tap(find.byKey(Key('ButtonType.plusButton')).at(2));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(FilterInputWidget), '18');
    await tester.pumpAndSettle();
    await tester.tap(find.text("ตกลง"));
    await tester.pumpAndSettle();
    expect(find.text('อายุของเด็กคนที่ 1'), findsOneWidget);
    await tester.enterText(find.byType(FilterInputWidget), '0');
    await tester.pumpAndSettle();
    await tester.tap(find.text("ตกลง"));
    await tester.pumpAndSettle();
    expect(find.text('อายุของเด็กคนที่ 1'), findsOneWidget);
    await tester.enterText(find.byType(FilterInputWidget), '15');
    await tester.pumpAndSettle();
    await tester.tap(find.text("ตกลง"));
    await tester.pumpAndSettle();
    expect(find.text('ตกลง'), findsNothing);
    tileWdgt = tester.widget(tileWdgt1.first) as FilterTileWidget;
    expect(tileWdgt.childAgeList.length, 1);
    expect(tileWdgt.childAgeList, [15]);
    await tester.tap(find.byKey(Key('ButtonType.plusButton')).at(2));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(FilterInputWidget), '1');
    await tester.pumpAndSettle();
    await tester.tap(find.text("ตกลง"));
    await tester.pumpAndSettle();
    expect(find.text('ตกลง'), findsNothing);
    tileWdgt = tester.widget(tileWdgt1.first) as FilterTileWidget;
    expect(tileWdgt.childAgeList.length, 2);
    expect(tileWdgt.childAgeList, [15, 1]);
    //validate that more than 9 adults are not allowed
    for (int i = 1; i < 9; i++) {
      await tester.tap(find.byKey(Key('ButtonType.plusButton')).first);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('ButtonType.plusButton')).at(1));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('ยืนยัน'));
    await tester.pumpAndSettle();
    expect(find.text('ไม่สามารถดำเนินการต่อได้'), findsOneWidget);
    expect(
        find.text(
            'จำนวนผู้เข้าพักเกินกว่าที่กำหนด คุณสามารถจองได้สูงสุด 9 คนต่อการจองหนึ่งครั้ง'),
        findsOneWidget);
    await tester.tap(find.text('ตกลง'));
    await tester.pumpAndSettle();
    for (int i = 1; i < 9; i++) {
      await tester.tap(find.byKey(Key('ButtonType.minusButton')).first);
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('ยืนยัน'));
    await tester.pumpAndSettle();
    expect(find.text('ไม่สามารถดำเนินการต่อได้'), findsNothing);
    print("All tests passed");
  });
}
