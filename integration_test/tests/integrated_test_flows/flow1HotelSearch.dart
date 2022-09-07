import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_input_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_suggestion_card.dart';
import 'package:ota/core_pack/custom_widgets/ota_suggestion_tile_widget.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/hotel/hotel_detail/view/widgets/secondary_hotel_widget.dart';

import '../../models/argument_data_model_automation.dart';
import '../../models/argument_data_model_room_detail_automation.dart';
import '../../models/hotel_detail_model_automation.dart';
import '../../models/room_detail_model_automation.dart';
import '../../utils/Reusable/utility.dart';
import '../../utils/consolidated_data_source_automation.dart';

AppActions appActions = AppActions();
HotelAutomation hotelAutomation = HotelAutomation();
List<RoomCapacityAutomation> roomCapacityAutomation = [];
List<RoomData> list = [];
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
      'Verify the end to end flow by searching a hotel from hotel search feature',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle(Duration(seconds: 5));

    //TranslationArgumentModel(translationType: TranslationType.english);
    list.add(RoomData(adults: 3, children: 0));

    HotelDetailDataArgumentAutomation hotelDetailDataArgument =
        new HotelDetailDataArgumentAutomation(
            currency: 'THB',
            checkOutDate: '2021-12-12',
            checkInDate: '2021-12-11',
            cityId: 'MA05110041',
            countryId: 'MA05110001',
            hotelId: 'MA0909060653',
            rooms: list);

    OtaConsolidatedRemoteDataSource otaConsolidatedRemoteDataSource =
        OtaConsolidatedRemoteDataSourceImpl();
    hotelAutomation = await otaConsolidatedRemoteDataSource
        .getHotelDetail(hotelDetailDataArgument);
    //***************************************************************************************************
    // Getting Room Details using GraphQL model
    String hotelRoomCode = hotelAutomation.data!.hotelDetail!.rooms!
        .elementAt(0)
        .details!
        .elementAt(0)
        .roomCode
        .toString();
    print("RoomCode is -----------> " + hotelRoomCode);
    double roomTotalPrice = hotelAutomation.data!.hotelDetail!.rooms!
        .elementAt(0)
        .details!
        .elementAt(0)
        .totalPrice!
        .toDouble();
    print("roomTotalPrice is -----------> " + roomTotalPrice.toString());
    roomCapacityAutomation
        .add(new RoomCapacityAutomation(adult: 3, children: 0));
    RoomDetailDataAutomation roomDetailAutomation =
        await otaConsolidatedRemoteDataSource.getRoomDetail(
      RoomDetailDataArgumentAutomation(
        currency: 'THB',
        checkOutDate: '2021-12-12',
        checkInDate: '2021-12-11',
        cityId: 'MA05110041',
        countryId: 'MA05110001',
        room: roomCapacityAutomation,
        hotelId: 'MA0909060653',
        roomCode: hotelRoomCode,
        roomCategory: 0,
        price: roomTotalPrice,
      ),
    );

    //await tester.tap(find.text("Login with alpha user"));
    await tester.pump(Duration(seconds: 10));
    //await tester.tap(find.text('Guest'));
    await tester.pumpAndSettle(Duration(seconds: 15));
    final hotelServiceCard = find.text('ที่พัก');
    await tester.tap(hotelServiceCard);
    await tester.pump(Duration(seconds: 5));
    //getting value from backend and entering in ota search field
    final hotelName = hotelAutomation.data!.hotelDetail!.name;
    print('Hotel name fetched is --------------$hotelName');
    await tester.enterText(find.byType(OtaSearchInputWidget), hotelName!);
    await tester.pump(Duration(seconds: 20));
    final suggestionResult1 = find.byType(OtaSuggestionTileWidget);
    await tester.tap(suggestionResult1.first);
    await tester.pumpAndSettle(Duration(milliseconds: 3000));
    await tester.tap(find.byType(OtaBottomButtonBar));
    //Validates if the hotel name from backend is visible on the page
    // expect(hotelName, findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 15));
    //await tester.tap(find.text(hotelName).last);
    await tester.tap(find.byType(OtaSuggestionCard).first);
    List<Room>? roomNameTest = hotelAutomation.data!.hotelDetail!.rooms;

    // tester.binding.window.physicalSizeTestValue = Size(360, 640);
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.dragUntilVisible(find.text("ห้อง").first,
        find.byType(CustomScrollView), Offset(0, -150));
    await tester.pumpAndSettle(Duration(seconds: 10));

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

        ///This is to test room details
        /* print("Tapping on ----> " + roomNameTest.first.roomName.toString());
        Finder firstRoomName =
            find.text(roomNameTest.first.roomName.toString());
        await appActions.tapOnElement(firstRoomName, tester);
        print("Successfully tapped on " +
            roomNameTest.elementAt(0).roomName.toString());
*/
        // Finder roomDetailKeys = find.byKey(Key("room_detail_key")).first;
        Finder roomDetailKeys =
            appActions.findWidgetBy("Key", "room_detail_key");
        for (int k = 0; k < roomDetailKeys.evaluate().length; k++) {
          await appActions.tapOnElement(roomDetailKeys.at(k), tester);
          print("Successfully tapped on roomDetailKey$k");

          print(
              "----------------Getting room price from backend------------------");

          // String roomName = roomDetailAutomation.getRoomDetails!.data!.roomCategories!.elementAt(0).roomName.toString();
          // String roomType = roomDetailAutomation.getRoomDetails!.data!.roomCategories!.elementAt(0).roomType.toString();
          // String noOfRoom = roomDetailAutomation.getRoomDetails!.data!.roomCategories!.elementAt(0).noOfRooms.toString();
          String totalPrice = roomDetailAutomation
              .getRoomDetails!.data!.totalPrice!
              .round()
              .toString();
          String expectedRoomPrice1 = appActions.getFormattedPrice(totalPrice);

          Finder priceWidget = appActions.findWidgetBy("Key", "Total_Price");
          String actualRoomPrice1 = appActions.getTextFromWidget(priceWidget);
          actualRoomPrice = actualRoomPrice.split("ราคารวม")[0].trim();
          expect(actualRoomPrice1, expectedRoomPrice1);
          print("Successfully validated room price in UI");

          Finder bookNowButton =
              appActions.findWidgetBy("Key", "BookNowButton");
          expect(bookNowButton, findsOneWidget);
          print("Successfully validated BookNowButton displayed in UI");

          List<RoomCategoryAutomation> roomCategories = roomDetailAutomation
              .getRoomDetails!.data!.roomCategories!
              .toList();
          for (RoomCategoryAutomation category in roomCategories) {
            String expectedCategory = category.roomName.toString() +
                " " +
                category.roomType.toString() +
                " " +
                "(" +
                category.noOfRooms.toString() +
                " ห้องนอน) ";
            print("--------------> " + expectedCategory);
            Finder expectedCategories =
                appActions.findWidgetBy("Text", expectedCategory);
            expect(expectedCategories, findsOneWidget);
          }
          print("Successfully validated roomCategories in UI");

          String expectedMealType =
              roomDetailAutomation.getRoomDetails!.data!.mealType.toString();
          Finder expectedMealTypeWidget =
              appActions.findWidgetBy("Text", expectedMealType);
          expect(expectedMealTypeWidget, findsOneWidget);
          print("Successfully validated MealType in UI");

          //Getting facility list from backend response and comparing one by one with UI data
          List<String> roomFacilities = roomDetailAutomation
              .getRoomDetails!.data!.roomFacilities!
              .toList();
          for (String expectedFacility in roomFacilities) {
            Finder expectedRoomFacility =
                appActions.findWidgetBy("Text", expectedFacility);
            expect(expectedRoomFacility, findsOneWidget);
          }
          print("Successfully validated roomFacilities in UI");

          //Getting CancellationPolicy list from backend response and comparing one by one with UI data
          List<CancellationPolicyAutomation> cancellationPolicy =
              roomDetailAutomation.getRoomDetails!.data!.cancellationPolicy!
                  .toList();
          for (CancellationPolicyAutomation expectedPolicy
              in cancellationPolicy) {
            String dayDescPolicy =
                expectedPolicy.cancellationDaysDescription.toString();
            Finder expectedDayDescPolicy =
                appActions.findWidgetBy("Text", dayDescPolicy);
            expect(expectedDayDescPolicy, findsOneWidget);

            String chargeDescPolicy =
                expectedPolicy.cancellationChargeDescription.toString();
            Finder expectedChargeDescPolicy =
                appActions.findWidgetBy("Text", chargeDescPolicy);
            expect(expectedChargeDescPolicy, findsOneWidget);
          }
          print("Successfully validated cancellationPolicies in UI");

          List<FacilityAutomation> facilities =
              roomDetailAutomation.getRoomDetails!.data!.facilities!.toList();

          for (FacilityAutomation facility in facilities) {
            String roomFacility = facility.value.toString();
            switch (roomFacility) {
              case "free.wifi":
                roomFacility = "Wi-Fi ฟรี";
                break;
              case "instant.payment":
                roomFacility = "ชำระเงินทันที";
                break;
              case "breakFast.included":
                roomFacility = "รวมอาหารเช้า";
                break;
            }
            print(roomFacility);
            if (roomFacility != "null") {
              Finder expectedFacility =
                  appActions.findWidgetBy("Text", roomFacility);
              expect(expectedFacility, findsOneWidget);
            }
          }
          print("Successfully room offers in UI");
          //clicking on the back button to come back to
          await tester.tap(find.byType(IconButton));
        }
      }
      await tester.tap(find.text(room.roomName.toString()));
      await tester.pumpAndSettle(Duration(seconds: 5));
      print('====================END===============');
    }
  });
}
