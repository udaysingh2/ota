import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/hotel/hotel_detail/view/widgets/secondary_hotel_widget.dart';

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
    await tester.tap(find.text("Login with alpha user"));
    await tester.pumpAndSettle();
    Finder hotel2 = find.text("Hotel 2");
    await tester.tap(hotel2);
    await tester.pumpAndSettle(Duration(seconds: 15));

    List<Room>? roomNameTest = hotelAutomation.data!.hotelDetail!.rooms;

    tester.binding.window.physicalSizeTestValue = Size(360, 640);
    await tester.dragUntilVisible(find.text("ห้อง").first,
        find.byType(CustomScrollView), Offset(0, -150));
    await tester.pumpAndSettle(Duration(seconds: 5));

    for (Room room in roomNameTest!) {
      await tester.tap(find.text(room.roomName.toString()));
      print("Successfully tapped on " + room.roomName.toString());
      await tester.pumpAndSettle(Duration(seconds: 10));

      Finder hotelNameObjSecondary = find.byType(SecondaryHotelView);

      for (int j = 0; j < room.details!.length; j++) {
        String expectedRoomPrice =
            room.details!.elementAt(j).nightPrice.toString();
        String expectedRoomType =
            room.details!.elementAt(j).roomType.toString();
        String expectedRoomName =
            room.details!.elementAt(j).roomOfferName.toString();

        String expectedRoomOfferCancellationPolicy =
            room.details!.elementAt(j).roomOffer!.cancellationPolicy.toString();
        String expectedRoomOfferInstantPay =
            room.details!.elementAt(j).roomOffer!.payNow.toString();
        String expectedRoomOfferBreakfast =
            room.details!.elementAt(j).roomOffer!.breakfast.toString();

        print(
            "---------------------   Below data is from backend ----------------------------");
        print("room name is ----> " + expectedRoomName);
        print("price is ---> " + expectedRoomPrice);
        print("room type is ---> " + expectedRoomType);
        print("Expected Cancellation offer is ------>  " +
            expectedRoomOfferCancellationPolicy);
        print("Expected InstantPay offer is ------>  " +
            expectedRoomOfferInstantPay);
        print("Expected Breakfast offer is ------>  " +
            expectedRoomOfferBreakfast);

        var hotelInfoSecondary = hotelNameObjSecondary
            .evaluate()
            .elementAt(j)
            .widget as SecondaryHotelView;
        String actualRoomName =
            hotelInfoSecondary.secondaryViewModel.roomName.toString();
        String actualRoomPrice =
            hotelInfoSecondary.secondaryViewModel.nightPrice.toString();
        String actualRoomType =
            hotelInfoSecondary.secondaryViewModel.roomType.toString();

        String actualRoomOfferCancellationPolicy = hotelInfoSecondary
            .secondaryViewModel.roomOffer!.cancellationPolicy
            .toString();
        String actualRoomOfferInstantPay =
            hotelInfoSecondary.secondaryViewModel.roomOffer!.payNow.toString();
        String actualRoomOfferBreakfast = hotelInfoSecondary
            .secondaryViewModel.roomOffer!.breakfast
            .toString();

        print(
            "---------------------   Below data is from UI ----------------------------");
        print("room name is ----> " + actualRoomName);
        print("price is ---> " + actualRoomPrice);
        print("room type is ---> " + actualRoomType);
        print("Actual cancellation  ------> " +
            actualRoomOfferCancellationPolicy);
        print("Actual InstantPay  ------> " + actualRoomOfferInstantPay);
        print("Actual Breakfast  ------> " + actualRoomOfferBreakfast);
        print(
            "---------------------------------------------------------------------------");

        expect(actualRoomName, expectedRoomName);
        expect(actualRoomPrice, expectedRoomPrice);
        expect(actualRoomType, expectedRoomType);
        expect(actualRoomOfferCancellationPolicy,
            expectedRoomOfferCancellationPolicy);
        expect(actualRoomOfferInstantPay, expectedRoomOfferInstantPay);
        expect(actualRoomOfferBreakfast, expectedRoomOfferBreakfast);
      }
      await tester.tap(find.text(room.roomName.toString()));
      await tester.pumpAndSettle(Duration(seconds: 5));
    }
  });
}
